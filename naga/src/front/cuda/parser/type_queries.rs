use super::*;

enum SizeofOperand {
    Object(TypeResolution),
    IncompleteArray(TypeResolution),
    NullPointer,
}

impl Parser<'_> {
    pub(super) fn type_query(&mut self, name: &str, span: Span) -> Result<Value, ParseError> {
        let parenthesized = self.lexer.next_if(Token::Paren('('))?;
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        if name == "sizeof" {
            let mut dereferences = 0;
            while self.lexer.next_if(Token::Operation('*'))? {
                self.parameter_expansion_budget.charge_work(1, span)?;
                dereferences += 1;
                if dereferences > 64 {
                    return self.fail("CUDA pointer nesting limit exceeded");
                }
            }
            if let (Token::Word(operand), operand_span) = self.lexer.peek()? {
                if let Some(symbol) = self.lookup_symbol(operand).filter(|symbol| {
                    !matches!(
                        symbol,
                        Symbol::Type(_)
                            | Symbol::TemplateTypeParameter { .. }
                            | Symbol::Namespace(_)
                    )
                }) {
                    self.lexer.next()?;
                    let (value, end) =
                        self.named_object_size(symbol, operand_span, dereferences)?;
                    let end = if parenthesized {
                        self.lexer.expect_span(Token::Paren(')'))?
                    } else {
                        end
                    };
                    return self.type_query_result(value, span.until(&end));
                }
            }
            if dereferences != 0 {
                return self.fail("sizeof dereference requires a supported named object");
            }
        }
        if !parenthesized {
            return self.fail("type queries require a parenthesized type or sizeof a named object");
        }

        let mut lookahead = self.lexer.clone();
        let qualifiers = types::declaration_qualifiers(&mut lookahead, Qualifiers::NONE, false)?;
        let operand = if lookahead.next_if(Token::Word("void"))? {
            types::declaration_qualifiers(&mut lookahead, qualifiers, false)?;
            self.lexer = lookahead;
            None
        } else {
            Some(self.parse_type()?)
        };

        let mut pointer_depth = usize::from(matches!(
            operand,
            Some(QualifiedType {
                ty: TypeSpecifier::Pointer { .. },
                ..
            })
        ));
        while self.lexer.next_if(Token::Operation('*'))? {
            self.parameter_expansion_budget.charge_work(1, span)?;
            pointer_depth += 1;
            if pointer_depth > 64 {
                return self.fail("CUDA pointer nesting limit exceeded");
            }
            types::pointer_qualifiers(&mut self.lexer)?;
        }
        if operand.is_none() && pointer_depth == 0 {
            return Err(ParseError {
                message: String::from("type queries require a complete object type"),
                span,
            });
        }

        let reference = self.lexer.next_if(Token::Operation('&'))?
            || self.lexer.next_if(Token::LogicalOperation('&'))?;
        if (reference || pointer_depth != 0) && self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("direct arrays of pointers or references are unsupported");
        }
        let value = if pointer_depth != 0 {
            8
        } else {
            let operand = operand.unwrap();
            let ty = if reference {
                operand.ty
            } else {
                self.array_alias_declarator(operand, span)?.ty
            };
            self.type_query_value(name, ty, span)?
        };
        let closing = self.lexer.expect_span(Token::Paren(')'))?;
        self.type_query_result(value, span.until(&closing))
    }

    fn type_query_result(&mut self, value: u32, span: Span) -> Result<Value, ParseError> {
        let literal = Literal::U64(u64::from(value));
        let ty = self.source_scalar_resolution(SourceScalar::Long(ScalarKind::Uint), span)?;
        let handle = self.append(Expression::Literal(literal), span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: literal.into(),
            handle,
            ty,
            span,
        })
    }

    fn type_query_value(
        &mut self,
        name: &str,
        operand: TypeSpecifier,
        span: Span,
    ) -> Result<u32, ParseError> {
        if matches!(
            operand,
            TypeSpecifier::Pointer { .. } | TypeSpecifier::NullPointer
        ) {
            return Ok(8);
        }
        let resolution = self.lower_type(operand, span)?;
        self.type_query_layout(name, resolution, span)
    }

    fn named_object_size(
        &mut self,
        symbol: Symbol,
        span: Span,
        dereferences: usize,
    ) -> Result<(u32, Span), ParseError> {
        let mut operand = self.named_sizeof_operand(symbol, span)?;
        let mut end = span;
        while matches!(self.lexer.peek()?.0, Token::Separator('.') | Token::Arrow) {
            let arrow = self.lexer.next()?.0 == Token::Arrow;
            let (field, field_span) = self.identifier()?;
            self.parameter_expansion_budget.charge_work(1, field_span)?;
            let invalid = || ParseError {
                message: String::from(
                    "sizeof member access requires a record or vector object, or a pointer with ->",
                ),
                span: field_span,
            };
            let ty = match operand {
                SizeofOperand::Object(ty) => {
                    if arrow {
                        let pointee = self
                            .source_pointer_pointee(&ty)
                            .or_else(|| match *ty.inner_with(&self.module.types) {
                                TypeInner::Array { base, .. } => Some(base),
                                _ => None,
                            })
                            .ok_or_else(invalid)?;
                        TypeResolution::Handle(pointee)
                    } else if self.source_pointer_pointee(&ty).is_some() {
                        return Err(invalid());
                    } else {
                        ty
                    }
                }
                SizeofOperand::IncompleteArray(element) if arrow => element,
                _ => return Err(invalid()),
            };
            let (_, ty) = self.field_type(&ty, field, field_span)?;
            operand = SizeofOperand::Object(ty);
            end = field_span;
        }
        // Postfix member access binds more tightly than unary dereference.
        for _ in 0..dereferences {
            let element = match operand {
                SizeofOperand::Object(ref ty) => self
                    .source_pointer_pointee(ty)
                    .or_else(|| match *ty.inner_with(&self.module.types) {
                        TypeInner::Array { base, .. } => Some(base),
                        _ => None,
                    })
                    .map(TypeResolution::Handle),
                SizeofOperand::IncompleteArray(element) => Some(element),
                SizeofOperand::NullPointer => None,
            }
            .ok_or_else(|| ParseError {
                message: String::from("sizeof dereference requires a pointer or array operand"),
                span: span.until(&end),
            })?;
            operand = SizeofOperand::Object(element);
        }
        let value = match operand {
            SizeofOperand::NullPointer => 8,
            SizeofOperand::IncompleteArray(_) => {
                return Err(ParseError {
                    message: String::from("sizeof requires a complete object type"),
                    span,
                });
            }
            SizeofOperand::Object(ty) => {
                if self.source_pointer_pointee(&ty).is_some() {
                    8
                } else {
                    self.type_query_layout("sizeof", ty, span.until(&end))?
                }
            }
        };
        Ok((value, end))
    }

    fn named_sizeof_operand(
        &mut self,
        symbol: Symbol,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let ty = match symbol {
            Symbol::Pointer(pointer) => self.function.pointer_symbols[pointer].ty.clone(),
            Symbol::NullPointer(_) => return Ok(SizeofOperand::NullPointer),
            Symbol::Variable { ty, .. }
            | Symbol::Reference { ty, .. }
            | Symbol::Constant { ty, .. } => ty,
            Symbol::Array { pointer, ty, .. } => {
                let array = match self.function.ir.expressions[pointer] {
                    Expression::LocalVariable(local) => {
                        if self.function.pending_array == Some(local) {
                            return Ok(SizeofOperand::IncompleteArray(ty));
                        }
                        self.function.ir.local_variables[local].ty
                    }
                    Expression::GlobalVariable(global) => self.module.global_variables[global].ty,
                    _ => unreachable!(),
                };
                TypeResolution::Handle(array)
            }
            Symbol::ConstantMemory(declaration) => {
                TypeResolution::Handle(self.constant_memory_type(declaration))
            }
            Symbol::TemplateParameter { scalar, .. } => {
                self.source_scalar_resolution(scalar, span)?
            }
            Symbol::DynamicShared(declaration) => {
                return Ok(SizeofOperand::IncompleteArray(TypeResolution::Handle(
                    self.dynamic_shared_element_type(declaration),
                )));
            }
            _ => {
                return Err(ParseError {
                    message: String::from("sizeof requires a supported named object or type"),
                    span,
                });
            }
        };
        Ok(SizeofOperand::Object(ty))
    }

    fn type_query_layout(
        &mut self,
        name: &str,
        resolution: TypeResolution,
        span: Span,
    ) -> Result<u32, ParseError> {
        let ty = self.type_handle(&resolution, span);
        if name == "sizeof" && self.is_incomplete_array(ty) {
            return Err(ParseError {
                message: String::from("sizeof requires a complete object type"),
                span,
            });
        }
        self.layouter
            .update(self.module.to_ctx())
            .map_err(|error| ParseError {
                message: format!("invalid type query layout: {error}"),
                span,
            })?;
        let layout = self.layouter[ty];
        Ok(if name == "sizeof" {
            layout.size
        } else {
            layout.alignment * 1
        })
    }
}
