use super::*;

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub(super) enum TypeSpecifier {
    NullPointer,
    TemplateParameter(u32),
    ThreadBlock,
    Dim3,
    Scalar(Scalar),
    Vector {
        size: VectorSize,
        scalar: Scalar,
    },
    Structure(Handle<Type>),
    Pointer {
        pointee: Handle<Type>,
        pointee_qualifiers: Qualifiers,
    },
}

pub(super) const VECTOR_TYPES: [(&str, &str, VectorSize, Scalar); 9] = [
    ("float2", "make_float2", VectorSize::Bi, Scalar::F32),
    ("float3", "make_float3", VectorSize::Tri, Scalar::F32),
    ("float4", "make_float4", VectorSize::Quad, Scalar::F32),
    ("int2", "make_int2", VectorSize::Bi, Scalar::I32),
    ("int3", "make_int3", VectorSize::Tri, Scalar::I32),
    ("int4", "make_int4", VectorSize::Quad, Scalar::I32),
    ("uint2", "make_uint2", VectorSize::Bi, Scalar::U32),
    ("uint3", "make_uint3", VectorSize::Tri, Scalar::U32),
    ("uint4", "make_uint4", VectorSize::Quad, Scalar::U32),
];

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
pub(super) struct QualifiedType {
    pub ty: TypeSpecifier,
    pub qualifiers: Qualifiers,
}

pub(super) enum DeclarationType {
    Explicit(QualifiedType),
    Inferred { qualifiers: Qualifiers },
}

#[derive(Clone, Debug)]
pub(super) enum GlobalDeclaration {
    NullPointer(NullPointerValue),
    Namespace(Namespace),
    PendingAuto,
    Type(QualifiedType),
    Functions(FunctionOverloads),
    Kernel,
    DynamicShared(DynamicSharedDeclaration),
    Constant {
        handle: Option<Handle<crate::Constant>>,
        scalar: Scalar,
        literal: Option<Literal>,
    },
}

#[derive(Clone, Debug, Default)]
pub(super) struct FunctionOverloads {
    pub(super) functions: Vec<Handle<Function>>,
    pub(super) templates: Vec<usize>,
}

#[derive(Default)]
pub(super) struct IntegerSpecifiers {
    seen_int: bool,
    seen_signed: bool,
    seen_unsigned: bool,
}

impl IntegerSpecifiers {
    pub(super) const fn is_empty(&self) -> bool {
        !self.seen_int && !self.seen_signed && !self.seen_unsigned
    }

    pub(super) fn consume(&mut self, specifier: &str) -> Option<Scalar> {
        match specifier {
            "int" if !self.seen_int => self.seen_int = true,
            "signed" if !self.seen_signed && !self.seen_unsigned => self.seen_signed = true,
            "unsigned" if !self.seen_unsigned && !self.seen_signed => self.seen_unsigned = true,
            _ => return None,
        }
        Some(if self.seen_unsigned {
            Scalar::U32
        } else {
            Scalar::I32
        })
    }
}

fn type_name(
    name: &str,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
) -> Option<QualifiedType> {
    let scalar = match name {
        "bool" => Scalar::BOOL,
        "float" => Scalar::F32,
        "int" | "signed" => Scalar::I32,
        "unsigned" => Scalar::U32,
        _ => {
            return match symbols.lookup(name) {
                Some(&Symbol::Type(ref ty)) => Some(ty.clone()),
                Some(&Symbol::TemplateTypeParameter { ref ty }) => Some(ty.clone()),
                Some(_) => None,
                None => match globals.get(name) {
                    Some(&GlobalDeclaration::Type(ref ty)) => Some(ty.clone()),
                    _ => None,
                },
            };
        }
    };
    Some(QualifiedType {
        ty: TypeSpecifier::Scalar(scalar),
        qualifiers: Qualifiers::NONE,
    })
}

pub(super) fn pointer_qualifiers(lexer: &mut Lexer<'_>) -> Result<Qualifiers, ParseError> {
    let mut qualifiers = Qualifiers::NONE;
    loop {
        let token = lexer.peek()?;
        match token.0 {
            Token::Word("const") => {
                if qualifiers.is_const {
                    return Err(ParseError {
                        message: String::from("duplicate const qualifier"),
                        span: token.1,
                    });
                }
                qualifiers.is_const = true;
            }
            Token::Word("volatile") => {
                if qualifiers.is_volatile {
                    return Err(ParseError {
                        message: String::from("duplicate volatile qualifier"),
                        span: token.1,
                    });
                }
                qualifiers.is_volatile = true;
            }
            Token::Word("__restrict__" | "__restrict") => {}
            _ => return Ok(qualifiers),
        }
        lexer.next()?;
    }
}

fn parse_type(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
) -> Result<QualifiedType, ParseError> {
    declaration_type(lexer, symbols, globals, false).map(|(ty, _)| match ty {
        DeclarationType::Explicit(ty) => ty,
        DeclarationType::Inferred { .. } => unreachable!(),
    })
}

fn declaration_type(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    is_variable_declaration: bool,
) -> Result<(DeclarationType, bool), ParseError> {
    let mut ty: Option<QualifiedType> = None;
    let mut inferred = false;
    let mut explicit_const = false;
    let mut explicit_volatile = false;
    let mut is_constexpr = false;
    let mut integers = IntegerSpecifiers::default();
    loop {
        let token = lexer.peek()?;
        if ty.is_none() && !inferred {
            if let Some(name) = cooperative_groups::try_qualified_name(lexer, symbols, globals)? {
                let cooperative_groups::QualifiedItem::Type(qualified) = name.item else {
                    return Err(ParseError {
                        message: String::from("expected a CUDA type"),
                        span: name.span,
                    });
                };
                ty = Some(qualified);
                continue;
            }
        }
        let invalid = |message: &str| ParseError {
            message: String::from(message),
            span: token.1,
        };
        match token.0 {
            Token::Word("decltype") if ty.is_none() && !inferred => {
                lexer.next()?;
                lexer.expect_span(Token::Paren('('))?;
                lexer.expect_span(Token::Word("nullptr"))?;
                lexer.expect_span(Token::Paren(')'))?;
                ty = Some(QualifiedType {
                    ty: TypeSpecifier::NullPointer,
                    qualifiers: Qualifiers::NONE,
                });
                continue;
            }
            Token::Word("struct") => {
                return Err(invalid("elaborated struct type spellings are unsupported"));
            }
            Token::Word("const") => {
                if explicit_const {
                    return Err(invalid("duplicate const qualifier"));
                }
                explicit_const = true;
            }
            Token::Word("volatile") => {
                if explicit_volatile {
                    return Err(invalid("duplicate volatile qualifier"));
                }
                explicit_volatile = true;
            }
            Token::Word("constexpr") => {
                if !is_variable_declaration {
                    return Err(invalid("constexpr is unsupported in this type"));
                }
                if is_constexpr {
                    return Err(invalid("duplicate constexpr specifier"));
                }
                is_constexpr = true;
            }
            Token::Word("auto") => {
                if !is_variable_declaration {
                    return Err(invalid("auto deduction is unsupported in this type"));
                }
                if inferred || ty.is_some() {
                    return Err(invalid("incompatible or repeated type specifier"));
                }
                inferred = true;
            }
            Token::Word(specifier @ ("int" | "signed" | "unsigned")) => {
                if inferred || (ty.is_some() && integers.is_empty()) {
                    return Err(invalid("incompatible or repeated type specifier"));
                }
                let scalar = integers
                    .consume(specifier)
                    .ok_or_else(|| invalid("incompatible or repeated type specifier"))?;
                ty = Some(QualifiedType {
                    ty: TypeSpecifier::Scalar(scalar),
                    qualifiers: Qualifiers::NONE,
                });
            }
            Token::Word(name) if ty.is_none() && !inferred => {
                ty = Some(type_name(name, symbols, globals).ok_or_else(|| ParseError {
                    message: format!("unknown or unsupported scalar type `{name}`"),
                    span: token.1,
                })?);
            }
            _ => break,
        }
        lexer.next()?;
    }
    if inferred {
        return Ok((
            DeclarationType::Inferred {
                qualifiers: Qualifiers {
                    is_const: explicit_const || is_constexpr,
                    is_volatile: explicit_volatile,
                },
            },
            is_constexpr,
        ));
    }
    let Some(mut ty) = ty else {
        return Err(ParseError {
            message: String::from("expected a scalar type"),
            span: lexer.peek()?.1,
        });
    };
    ty.qualifiers = ty.qualifiers.union(Qualifiers {
        is_const: explicit_const || is_constexpr,
        is_volatile: explicit_volatile,
    });
    Ok((DeclarationType::Explicit(ty), is_constexpr))
}

impl<'a> Parser<'a> {
    pub(super) fn lower_type(
        &mut self,
        ty: TypeSpecifier,
        span: Span,
    ) -> Result<TypeResolution, ParseError> {
        let (size, scalar) = match ty {
            TypeSpecifier::TemplateParameter(_) => {
                return Err(ParseError {
                    message: String::from("dependent type requires an instantiation"),
                    span,
                });
            }
            TypeSpecifier::NullPointer => {
                return Err(ParseError {
                    message: String::from("nullptr_t has no shader storage representation"),
                    span,
                });
            }
            TypeSpecifier::ThreadBlock => {
                return Err(ParseError {
                    message: String::from(
                        "thread_block handles cannot be stored or passed as shader values",
                    ),
                    span,
                })
            }
            TypeSpecifier::Scalar(scalar) => return Ok(scalar_resolution(scalar)),
            TypeSpecifier::Dim3 => return Ok(TypeResolution::Handle(self.dim3_type(span))),
            TypeSpecifier::Structure(handle) => return Ok(TypeResolution::Handle(handle)),
            TypeSpecifier::Pointer { pointee, .. } => return Ok(self.pointer_type(pointee, span)),
            TypeSpecifier::Vector { size, scalar } => (size, scalar),
        };
        if size != VectorSize::Tri {
            return Ok(TypeResolution::Value(TypeInner::Vector { size, scalar }));
        }
        let base = self.scalar_handle(scalar, span);
        let name = VECTOR_TYPES
            .into_iter()
            .find_map(|(name, _, candidate_size, candidate_scalar)| {
                (size == candidate_size && scalar == candidate_scalar).then_some(name)
            })
            .unwrap();
        let members = ["x", "y", "z"]
            .into_iter()
            .enumerate()
            .map(|(index, name)| StructMember {
                name: Some(String::from(name)),
                ty: base,
                binding: None,
                offset: index as u32 * 4,
            })
            .collect();
        let handle = self.module.types.insert(
            Type {
                name: Some(String::from(name)),
                inner: TypeInner::Struct { members, span: 12 },
            },
            span,
        );
        if scalar == Scalar::U32 {
            self.uint3_type = Some(handle);
        }
        Ok(TypeResolution::Handle(handle))
    }

    pub(super) fn type_handle(&mut self, ty: &TypeResolution, span: Span) -> Handle<Type> {
        match ty.clone() {
            TypeResolution::Handle(handle) => handle,
            TypeResolution::Value(inner) => {
                self.module.types.insert(Type { name: None, inner }, span)
            }
        }
    }

    pub(super) fn array_type(
        &mut self,
        base: Handle<Type>,
        size: ArraySize,
        layout_span: Span,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        self.layouter
            .update(self.module.to_ctx())
            .map_err(|error| ParseError {
                message: format!("invalid array layout: {error}"),
                span: layout_span,
            })?;
        let inner = TypeInner::Array {
            base,
            size,
            stride: self.layouter[base].to_stride(),
        };
        if inner.try_size(self.module.to_ctx()).is_none() {
            return Err(ParseError {
                message: String::from("array exceeds Naga's type size limit"),
                span: layout_span,
            });
        }
        Ok(self.module.types.insert(Type { name: None, inner }, span))
    }

    pub(super) fn require_scalar_type(
        &self,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<Scalar, ParseError> {
        match *ty.inner_with(&self.module.types) {
            TypeInner::Scalar(scalar) => Ok(scalar),
            _ => Err(ParseError {
                message: String::from("expected a supported scalar expression"),
                span,
            }),
        }
    }

    pub(super) fn type_name(&self, name: &str) -> Option<QualifiedType> {
        type_name(name, &self.function.symbol_table, &self.global_declarations)
    }

    pub(super) fn parse_type(&mut self) -> Result<QualifiedType, ParseError> {
        parse_type(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )
    }

    pub(super) fn parse_type_from(
        &self,
        lexer: &mut Lexer<'_>,
    ) -> Result<QualifiedType, ParseError> {
        parse_type(
            lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )
    }

    pub(super) fn declaration_type(&mut self) -> Result<(DeclarationType, bool), ParseError> {
        declaration_type(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            true,
        )
    }

    pub(super) fn starts_type(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        if let Some(name) = cooperative_groups::try_qualified_name(
            &mut lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )? {
            return Ok(matches!(
                name.item,
                cooperative_groups::QualifiedItem::Type(_)
            ));
        }
        Ok(match self.lexer.peek()?.0 {
            Token::Word("const" | "volatile" | "constexpr" | "decltype") => true,
            Token::Word(name) => self.type_name(name).is_some(),
            _ => false,
        })
    }

    pub(super) fn starts_alias(&mut self) -> Result<bool, ParseError> {
        Ok(matches!(
            self.lexer.peek()?.0,
            Token::Word("typedef" | "using" | "namespace")
        ))
    }

    pub(super) fn alias_declaration(&mut self, global: bool) -> Result<(), ParseError> {
        if self.take_ident("namespace")? {
            return self.namespace_alias_declaration(global);
        }
        if self.take_ident("typedef")? {
            let ty = self.parse_type()?;
            loop {
                let declarator = self.alias_declarator(ty.clone())?;
                let (name, span) = self.identifier()?;
                self.insert_type(name, declarator, span, global)?;
                if self.lexer.next_if(Token::Separator(';'))? {
                    return Ok(());
                }
                self.lexer.expect_span(Token::Separator(','))?;
            }
        }
        self.expect_ident("using")?;
        let (name, span) = self.identifier()?;
        self.check_name(name, span)?;
        self.lexer.expect_span(Token::Operation('='))?;
        let ty = self.parse_type()?;
        let ty = self.alias_declarator(ty)?;
        self.lexer.expect_span(Token::Separator(';'))?;
        self.insert_type(name, ty, span, global)
    }

    pub(super) fn alias_declarator(
        &mut self,
        ty: QualifiedType,
    ) -> Result<QualifiedType, ParseError> {
        let span = self.lexer.peek()?.1;
        if !self.lexer.next_if(Token::Operation('*'))? {
            return Ok(ty);
        }
        if matches!(ty.ty, TypeSpecifier::Pointer { .. }) {
            return self.fail("nested pointer aliases are unsupported");
        }
        let pointer_qualifiers = pointer_qualifiers(&mut self.lexer)?;
        if matches!(
            self.lexer.peek()?.0,
            Token::Operation('*' | '&') | Token::LogicalOperation('&')
        ) {
            return self.fail("nested pointer and pointer reference aliases are unsupported");
        }
        let resolution = self.lower_type(ty.ty, span)?;
        let pointee = self.type_handle(&resolution, span);
        Ok(QualifiedType {
            ty: TypeSpecifier::Pointer {
                pointee,
                pointee_qualifiers: ty.qualifiers,
            },
            qualifiers: pointer_qualifiers,
        })
    }

    pub(super) fn insert_type(
        &mut self,
        name: &'a str,
        ty: QualifiedType,
        span: Span,
        global: bool,
    ) -> Result<(), ParseError> {
        self.check_name(name, span)?;
        if global {
            self.check_dynamic_shared_linkage(name, span)?;
        }
        let compatible = if global {
            match self
                .global_declarations
                .insert(name, GlobalDeclaration::Type(ty.clone()))
            {
                None => true,
                Some(GlobalDeclaration::Type(previous)) => ty == previous,
                Some(_) => false,
            }
        } else {
            match self
                .function
                .symbol_table
                .add(name, Symbol::Type(ty.clone()))
            {
                None => true,
                Some(Symbol::Type(previous)) => ty == previous,
                Some(_) => false,
            }
        };
        if compatible {
            Ok(())
        } else {
            Err(ParseError {
                message: format!("incompatible redeclaration of `{name}`"),
                span,
            })
        }
    }
}

pub(super) const fn scalar_resolution(scalar: Scalar) -> TypeResolution {
    TypeResolution::Value(TypeInner::Scalar(scalar))
}
