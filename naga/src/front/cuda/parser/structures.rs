use super::*;

pub(super) struct Structure {
    pub(super) source_name: Option<String>,
    pub(super) depth: u32,
    pub(super) requires_default_constructor: bool,
    pub(super) const_default_constructible: bool,
}

impl<'a> Parser<'a> {
    pub(super) fn structure_declaration(&mut self, global: bool) -> Result<(), ParseError> {
        self.structure_definition(global, false)?;
        self.lexer.expect_span(Token::Separator(';'))?;
        Ok(())
    }

    pub(super) fn structure_definition(
        &mut self,
        global: bool,
        allow_anonymous: bool,
    ) -> Result<QualifiedType, ParseError> {
        let start = self.lexer.expect_span(Token::Word("struct"))?;
        let tag = if allow_anonymous && self.lexer.peek()?.0 == Token::Paren('{') {
            None
        } else {
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            if global && self.global_declarations.contains_key(name) {
                return Err(ParseError {
                    message: format!("duplicate structure definition `{name}`"),
                    span,
                });
            }
            Some((name, span))
        };
        if self.lexer.peek()?.0 != Token::Paren('{') {
            return self.fail("incomplete and elaborated struct declarations are unsupported");
        }
        self.lexer.next()?;
        let initialization_start = self.function.push_scope();
        if let Some((name, _)) = tag {
            self.function.symbol_table.add(name, Symbol::Member);
        }
        let definition = self.structure_members();
        self.function.pop_scope(initialization_start);
        let (members, size, mut structure) = definition?;
        let name_span = tag.map_or(start, |(_, span)| span);
        let name = tag.map(|(name, _)| name);
        for bytes in [name.map_or(0, str::len), name.map_or(0, str::len), 32] {
            self.parameter_expansion_budget
                .charge_bytes(bytes, name_span)?;
        }
        self.parameter_expansion_budget
            .charge_map_entry::<Type, Span>(1, name_span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<Type>, Structure>(1, name_span)?;
        self.parameter_expansion_budget.charge_nodes(1, name_span)?;
        structure.source_name = name.map(String::from);
        let declaration_id = self.next_structure_id;
        self.next_structure_id = declaration_id.checked_add(1).ok_or_else(|| ParseError {
            message: String::from("too many structure declarations"),
            span: name_span,
        })?;
        // Equal names and layouts must still have distinct nominal identities.
        let handle = self.module.types.insert(
            Type {
                name: Some(match name {
                    Some(name) => format!("{name}_cuda_record_{declaration_id}"),
                    None => format!("cuda_record_{declaration_id}"),
                }),
                inner: TypeInner::Struct {
                    members,
                    span: size,
                },
            },
            self.lexer.span_from(start.to_range().unwrap().start),
        );
        self.structures.insert(handle, structure);
        let ty = QualifiedType {
            ty: TypeSpecifier::Structure(handle),
            qualifiers: Qualifiers::NONE,
        };
        if let Some((name, span)) = tag {
            self.insert_type(name, ty.clone(), span, global)?;
        }
        Ok(ty)
    }

    pub(super) fn name_anonymous_structure(
        &mut self,
        handle: Handle<Type>,
        name: &str,
        span: Span,
    ) -> Result<(), ParseError> {
        if self.structures[&handle].source_name.is_some() {
            return Ok(());
        }
        let ty = &self.module.types[handle];
        let previous_name_length = ty.name.as_ref().map_or(0, String::len);
        for bytes in [
            previous_name_length,
            previous_name_length,
            name.len(),
            name.len(),
            1,
        ] {
            self.parameter_expansion_budget.charge_bytes(bytes, span)?;
        }
        if let TypeInner::Struct { ref members, .. } = ty.inner {
            self.parameter_expansion_budget
                .charge_slice::<StructMember>(members.len(), span)?;
            for member in members {
                self.parameter_expansion_budget
                    .charge_bytes(member.name.as_ref().map_or(0, String::len), span)?;
                self.parameter_expansion_budget.charge_work(1, span)?;
            }
        }
        let mut ty = ty.clone();
        ty.name = Some(format!("{name}_{}", ty.name.as_deref().unwrap()));
        self.module.types.replace(handle, ty);
        self.structures.get_mut(&handle).unwrap().source_name = Some(String::from(name));
        Ok(())
    }

    fn structure_members(&mut self) -> Result<(Vec<StructMember>, u32, Structure), ParseError> {
        let mut members = Vec::new();
        let mut names = crate::FastHashSet::default();
        let mut offset = 0;
        let mut alignment = crate::proc::Alignment::ONE;
        let mut depth = 1u32;
        let mut requires_default_constructor = false;
        let mut const_default_constructible = true;
        while !self.lexer.next_if(Token::Paren('}'))? {
            let type_span = self.lexer.peek()?.1;
            let QualifiedType {
                ty: specifier,
                qualifiers,
            } = self.parse_type()?;
            let is_const = qualifiers.is_const;
            if qualifiers.is_volatile {
                return Err(ParseError {
                    message: String::from("volatile structure members are unsupported"),
                    span: type_span,
                });
            }
            if matches!(specifier, TypeSpecifier::Pointer { .. }) {
                return Err(ParseError {
                    message: String::from("pointer structure members are unsupported"),
                    span: type_span,
                });
            }
            if is_const || matches!(specifier, TypeSpecifier::Scalar(Scalar::BOOL)) {
                return Err(ParseError {
                    message: String::from(
                        "structure members require non-const numeric value types",
                    ),
                    span: type_span,
                });
            }
            let resolution = self.lower_type(specifier, type_span)?;
            let base = self.type_handle(&resolution, type_span);
            loop {
                let (name, span) = self.identifier()?;
                if !matches!(name, "threadIdx" | "blockIdx" | "gridDim" | "blockDim") {
                    self.check_name(name, span)?;
                }
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, ()>(1, span)?;
                if !names.insert(name) {
                    return Err(ParseError {
                        message: format!("duplicate structure member `{name}`"),
                        span,
                    });
                }
                let ty = if self.lexer.next_if(Token::Paren('['))? {
                    self.array_declaration(base, false, span)?.ty
                } else {
                    base
                };
                let member_depth = self.structure_field_depth(ty);
                requires_default_constructor |= self.requires_default_constructor(ty);
                const_default_constructible &= self.const_default_constructible(ty);
                depth = depth.max(1 + member_depth);
                if depth > 64 {
                    return Err(ParseError {
                        message: String::from("CUDA structure nesting limit exceeded"),
                        span,
                    });
                }
                self.layouter
                    .update(self.module.to_ctx())
                    .map_err(|error| ParseError {
                        message: format!("invalid structure layout: {error}"),
                        span,
                    })?;
                let layout = self.layouter[ty];
                offset = Self::structure_aligned_offset(offset, layout.alignment, span)?;
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<StructMember>(1, span)?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len(), span)?;
                members.push(StructMember {
                    name: Some(String::from(name)),
                    ty,
                    binding: None,
                    offset,
                });
                offset = offset
                    .checked_add(layout.size)
                    .filter(|&size| size <= crate::valid::MAX_TYPE_SIZE)
                    .ok_or_else(|| ParseError {
                        message: String::from("structure exceeds Naga's type size limit"),
                        span,
                    })?;
                alignment = alignment.max(layout.alignment);
                self.function.symbol_table.add(name, Symbol::Member);
                if !self.lexer.next_if(Token::Separator(','))? {
                    self.lexer.expect_span(Token::Separator(';'))?;
                    break;
                }
            }
        }
        if members.is_empty() {
            return self.fail("empty structures are unsupported");
        }
        let span = self.lexer.peek()?.1;
        let size = Self::structure_aligned_offset(offset, alignment, span)?;
        Ok((
            members,
            size,
            Structure {
                source_name: None,
                depth,
                requires_default_constructor,
                const_default_constructible,
            },
        ))
    }

    pub(super) fn requires_default_constructor(&self, mut ty: Handle<Type>) -> bool {
        while let TypeInner::Array { base, .. } = self.module.types[ty].inner {
            ty = base;
        }
        self.structures
            .get(&ty)
            .is_some_and(|structure| structure.requires_default_constructor)
    }

    pub(super) fn const_default_constructible(&self, mut ty: Handle<Type>) -> bool {
        while let TypeInner::Array { base, .. } = self.module.types[ty].inner {
            ty = base;
        }
        self.structures
            .get(&ty)
            .is_some_and(|structure| structure.const_default_constructible)
    }

    fn structure_field_depth(&self, mut ty: Handle<Type>) -> u32 {
        let mut depth = 0;
        while let TypeInner::Array { base, .. } = self.module.types[ty].inner {
            depth += 1;
            ty = base;
        }
        depth
            + self
                .structures
                .get(&ty)
                .map_or(0, |structure| structure.depth)
    }

    fn structure_aligned_offset(
        offset: u32,
        alignment: crate::proc::Alignment,
        span: Span,
    ) -> Result<u32, ParseError> {
        offset
            .checked_add(alignment * 1 - 1)
            .filter(|&size| size <= crate::valid::MAX_TYPE_SIZE)
            .map(|_| alignment.round_up(offset))
            .ok_or_else(|| ParseError {
                message: String::from("structure exceeds Naga's type size limit"),
                span,
            })
    }

    pub(super) fn aggregate_value(
        &mut self,
        specifier: TypeSpecifier,
        span: Span,
    ) -> Result<Value, ParseError> {
        if matches!(specifier, TypeSpecifier::Pointer { .. }) {
            return Err(ParseError {
                message: String::from("pointer value constructors are unsupported"),
                span,
            });
        }
        let resolution = self.lower_type(specifier, span)?;
        let ty = self.type_handle(&resolution, span);
        let pointer = self.temporary_pointer(&resolution, span)?;
        self.aggregate_initializer(pointer, specifier, ty, None)?;
        let span = self.lexer.span_from(span.to_range().unwrap().start);
        let value = self.load_pointer(pointer, &resolution, span)?;
        self.record_constructed_result(value.handle, pointer, span)?;
        Ok(value)
    }
}
