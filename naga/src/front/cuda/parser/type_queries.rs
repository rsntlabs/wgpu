use super::*;

enum SizeofOperand {
    Object(TypeResolution),
    IncompleteArray(TypeResolution),
    NullPointer,
}

impl Parser<'_> {
    pub(super) fn type_query(&mut self, name: &str, span: Span) -> Result<Value, ParseError> {
        let operand_start = self.lexer.clone();
        let parenthesized = self.lexer.next_if(Token::Paren('('))?;
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        if name == "sizeof" {
            let expression_operand = match self.lexer.peek()?.0 {
                Token::Operation('*' | '+' | '-' | '~' | '!')
                | Token::Paren('(')
                | Token::Number(_)
                | Token::Word("true" | "false" | "nullptr") => true,
                Token::Word(operand) => self.lookup_symbol(operand).is_some_and(|symbol| {
                    !matches!(
                        symbol,
                        Symbol::Type(_)
                            | Symbol::TemplateTypeParameter { .. }
                            | Symbol::Namespace(_)
                    )
                }),
                _ => false,
            };
            if expression_operand {
                self.lexer = operand_start;
                let (operand, operand_span) = self.sizeof_operand()?;
                let span = span.until(&operand_span);
                let value = self.sizeof_operand_size(operand, span)?;
                return self.type_query_result(value, span);
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

    fn sizeof_operand(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        self.function.expression_depth += 1;
        if self.function.expression_depth > 64 {
            return self.fail("CUDA expression nesting limit exceeded");
        }
        self.parameter_expansion_budget
            .charge_work(1, self.lexer.peek()?.1)?;
        let result = self.sizeof_operand_inner();
        self.function.expression_depth -= 1;
        result
    }

    fn sizeof_operand_inner(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (token, start) = self.lexer.next()?;
        let (mut operand, mut end) = match token {
            Token::Operation('*') => {
                let (operand, end) = self.sizeof_operand()?;
                let span = start.until(&end);
                return self
                    .sizeof_dereference(operand, span)
                    .map(|operand| (operand, span));
            }
            Token::Operation(operator @ ('+' | '-' | '~' | '!')) => {
                let (operand, end) = self.sizeof_operand()?;
                let span = start.until(&end);
                return self
                    .sizeof_unary(operator, operand, span)
                    .map(|operand| (operand, span));
            }
            Token::Paren('(') => {
                let (operand, _) = self.sizeof_operand()?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                (operand, start.until(&closing))
            }
            Token::Number(text) => {
                let number = number::parse(text).ok_or_else(|| ParseError {
                    message: String::from("unsupported or out-of-range numeric literal"),
                    span: start,
                })?;
                let ty = self.source_scalar_resolution(number.scalar, start)?;
                (SizeofOperand::Object(ty), start)
            }
            Token::Word("true" | "false") => (
                SizeofOperand::Object(scalar_resolution(Scalar::BOOL)),
                start,
            ),
            Token::Word("nullptr") => (SizeofOperand::NullPointer, start),
            Token::Word(name) => {
                let symbol = self.lookup_symbol(name).ok_or_else(|| ParseError {
                    message: String::from("sizeof requires a supported named object"),
                    span: start,
                })?;
                (self.named_sizeof_operand(symbol, start)?, start)
            }
            _ => {
                return Err(ParseError {
                    message: String::from("sizeof requires a supported named object"),
                    span: start,
                })
            }
        };
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
        Ok((operand, start.until(&end)))
    }

    fn sizeof_dereference(
        &self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
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
            span,
        })?;
        Ok(SizeofOperand::Object(element))
    }

    fn sizeof_unary(
        &mut self,
        operator: char,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from("invalid operand for sizeof builtin unary operator"),
            span,
        };
        let ty = match operand {
            SizeofOperand::NullPointer if operator == '!' => {
                return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
            }
            SizeofOperand::NullPointer => return Err(invalid()),
            SizeofOperand::IncompleteArray(element) => {
                if operator == '!' {
                    return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
                }
                if operator != '+' {
                    return Err(invalid());
                }
                let base = self.type_handle(&element, span);
                return self.pointer_type(base, span).map(SizeofOperand::Object);
            }
            SizeofOperand::Object(ty) => ty,
        };
        if self.source_pointer_pointee(&ty).is_some() {
            return match operator {
                '+' => Ok(SizeofOperand::Object(ty)),
                '!' => Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL))),
                _ => Err(invalid()),
            };
        }
        if let TypeInner::Array { base, .. } = *ty.inner_with(&self.module.types) {
            return match operator {
                '+' => self.pointer_type(base, span).map(SizeofOperand::Object),
                '!' => Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL))),
                _ => Err(invalid()),
            };
        }
        let scalar = self.require_scalar_type(&ty, span)?;
        if operator == '!' {
            return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
        }
        if operator == '~' && scalar.kind == ScalarKind::Float {
            return Err(invalid());
        }
        Ok(SizeofOperand::Object(
            if matches!(scalar, Scalar::BOOL | Scalar::I16 | Scalar::U16) {
                scalar_resolution(Scalar::I32)
            } else {
                ty
            },
        ))
    }

    fn sizeof_operand_size(
        &mut self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<u32, ParseError> {
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
                    self.type_query_layout("sizeof", ty, span)?
                }
            }
        };
        Ok(value)
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
