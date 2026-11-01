use super::*;

#[derive(Clone, Copy)]
enum Declarator {
    Value,
    Pointer { qualifiers: Qualifiers },
    Reference,
}

enum DeducedType {
    Value {
        ty: TypeResolution,
        qualifiers: Qualifiers,
        pointee_qualifiers: Option<Qualifiers>,
    },
    ThreadBlock,
}

enum InferredBinding {
    ThreadBlock,
    Value(Value),
    Pointer {
        pointer: PointerValue,
        qualifiers: Qualifiers,
    },
    Reference {
        value: ExpressionValue,
        ty: TypeResolution,
        qualifiers: Qualifiers,
    },
}

impl<'a> Parser<'a> {
    pub(super) fn inferred_local_declaration(
        &mut self,
        qualifiers: Qualifiers,
        is_constexpr: bool,
    ) -> Result<(), ParseError> {
        let mut deduced_type = None;
        loop {
            let declarator = self.inferred_declarator()?;
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            self.insert_symbol(name, Symbol::PendingAuto, span)?;
            if self.lexer.peek()?.0 == Token::Paren('[') {
                return self.fail("auto array declarations are unsupported");
            }
            let ((deduced, binding), body) = self.capture_block(|parser| {
                let value = parser.inferred_initializer()?;
                parser.deduce_initializer(value, declarator, qualifiers, is_constexpr)
            })?;
            self.check_deduced_type(&mut deduced_type, deduced, span)?;
            match binding {
                InferredBinding::ThreadBlock => {
                    self.append_block(body);
                    self.function.symbol_table.add(name, Symbol::ThreadBlock);
                }
                InferredBinding::Value(value) => {
                    self.bind_inferred_value(name, span, value, body, qualifiers, is_constexpr)?;
                }
                InferredBinding::Pointer {
                    pointer,
                    qualifiers,
                } => {
                    self.append_block(body);
                    self.bind_local_pointer(name, pointer, qualifiers.is_const, span)?;
                }
                InferredBinding::Reference {
                    value,
                    ty,
                    qualifiers,
                } => {
                    self.append_block(body);
                    self.bind_local_reference(name, span, ty, qualifiers, value)?;
                }
            }
            self.function.initialized_declarations.push(span);
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    pub(super) fn inferred_global_constant_declaration(&mut self) -> Result<(), ParseError> {
        let mut deduced_type = None;
        loop {
            let declarator = self.inferred_declarator()?;
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            self.check_dynamic_shared_linkage(name, span)?;
            if self.global_declarations.contains_key(name) {
                return Err(ParseError {
                    message: format!("incompatible redeclaration of `{name}`"),
                    span,
                });
            }
            self.global_declarations
                .insert(name, GlobalDeclaration::PendingAuto);
            let ((deduced, binding), _) = self.capture_block(|parser| {
                let value = parser.inferred_initializer()?;
                parser.deduce_initializer(value, declarator, Qualifiers::CONST, true)
            })?;
            self.check_deduced_type(&mut deduced_type, deduced, span)?;
            let InferredBinding::Value(value) = binding else {
                return self.fail("constexpr requires a scalar variable");
            };
            let scalar = self.require_scalar_type(&value.ty, value.span)?;
            let literal = Self::required_constant(&value)?;
            self.bind_global_constant(name, scalar, literal, span);
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    fn inferred_declarator(&mut self) -> Result<Declarator, ParseError> {
        if self.lexer.next_if(Token::Operation('*'))? {
            let qualifiers = types::pointer_qualifiers(&mut self.lexer)?;
            if matches!(
                self.lexer.peek()?.0,
                Token::Operation('*' | '&') | Token::LogicalOperation('&')
            ) {
                return self
                    .fail("nested pointer and pointer reference declarators are unsupported");
            }
            Ok(Declarator::Pointer { qualifiers })
        } else if self.lexer.next_if(Token::Operation('&'))? {
            Ok(Declarator::Reference)
        } else if self.lexer.peek()?.0 == Token::LogicalOperation('&') {
            self.fail("rvalue reference declarations are unsupported")
        } else if self.lexer.peek()?.0 == Token::Paren('(') {
            self.fail("parenthesized declarators are unsupported")
        } else {
            Ok(Declarator::Value)
        }
    }

    fn inferred_initializer(&mut self) -> Result<ExpressionResult, ParseError> {
        let has_equals = self.lexer.next_if(Token::Operation('='))?;
        let delimiter = match self.lexer.peek()?.0 {
            Token::Paren('{') if has_equals => {
                return self.fail("auto initializer lists are unsupported");
            }
            Token::Paren('{') => Some('}'),
            Token::Paren('(') if !has_equals => Some(')'),
            _ if has_equals => None,
            _ => return self.fail("auto declaration requires an initializer"),
        };
        if let Some(closing) = delimiter {
            self.lexer.next()?;
            if matches!(self.lexer.peek()?.0, Token::Paren('{' | '}' | ')')) {
                return self.fail("auto deduction requires a single expression initializer");
            }
            let value = self.expression_result(0)?;
            if closing == '}' {
                self.lexer.next_if(Token::Separator(','))?;
            }
            self.lexer.expect_span(Token::Paren(closing))?;
            Ok(value)
        } else {
            self.expression_result(0)
        }
    }

    fn deduce_initializer(
        &mut self,
        result: ExpressionResult,
        declarator: Declarator,
        qualifiers: Qualifiers,
        is_constexpr: bool,
    ) -> Result<(DeducedType, InferredBinding), ParseError> {
        let value = match result {
            ExpressionResult::ThreadBlock(value) => {
                if is_constexpr || !matches!(declarator, Declarator::Value) {
                    return Err(ParseError {
                        message: String::from(
                            "thread_block handles require non-constexpr value declarations",
                        ),
                        span: value.span,
                    });
                }
                return Ok((DeducedType::ThreadBlock, InferredBinding::ThreadBlock));
            }
            result => result.require_value()?,
        };
        match declarator {
            Declarator::Reference => {
                if is_constexpr {
                    return self.fail("constexpr reference declarations are unsupported");
                }
                if matches!(value, ExpressionValue::Pointer(_))
                    || matches!(
                        *value.ty().inner_with(&self.module.types),
                        TypeInner::Array { .. }
                    )
                {
                    return Err(ParseError {
                        message: String::from(
                            "auto references to pointers or arrays are unsupported",
                        ),
                        span: value.span(),
                    });
                }
                self.require_inferred_value_type(value.ty(), value.span())?;
                let source_qualifiers = match &value {
                    ExpressionValue::Reference(reference) => reference.qualifiers,
                    _ => Qualifiers::NONE,
                };
                let ty = value.ty().clone();
                Ok((
                    DeducedType::Value {
                        ty: ty.clone(),
                        qualifiers: source_qualifiers.without(qualifiers),
                        pointee_qualifiers: None,
                    },
                    InferredBinding::Reference {
                        value,
                        ty,
                        qualifiers: qualifiers.union(source_qualifiers),
                    },
                ))
            }
            Declarator::Pointer {
                qualifiers: pointer_qualifiers,
            } => {
                if is_constexpr {
                    return self.fail("constexpr pointer declarations are unsupported");
                }
                let mut pointer = self.borrowed_pointer(value)?;
                let TypeInner::Pointer { base, .. } = *pointer.ty.inner_with(&self.module.types)
                else {
                    return self.fail("expected a CUDA source pointer type");
                };
                let deduced = DeducedType::Value {
                    ty: TypeResolution::Handle(base),
                    qualifiers: pointer.qualifiers.without(qualifiers),
                    pointee_qualifiers: None,
                };
                pointer.qualifiers = pointer.qualifiers.union(qualifiers);
                Ok((
                    deduced,
                    InferredBinding::Pointer {
                        pointer,
                        qualifiers: pointer_qualifiers,
                    },
                ))
            }
            Declarator::Value if self.is_pointer_operand(&value) => {
                if is_constexpr {
                    return self.fail("constexpr pointer declarations are unsupported");
                }
                let pointer = self.borrowed_pointer(value)?;
                let deduced = DeducedType::Value {
                    ty: pointer.ty.clone(),
                    qualifiers: Qualifiers::NONE,
                    pointee_qualifiers: Some(pointer.qualifiers),
                };
                Ok((
                    deduced,
                    InferredBinding::Pointer {
                        pointer,
                        qualifiers,
                    },
                ))
            }
            Declarator::Value => {
                let value = self.rvalue(value)?;
                self.require_inferred_value_type(&value.ty, value.span)?;
                if is_constexpr {
                    self.require_scalar_type(&value.ty, value.span)?;
                }
                Ok((
                    DeducedType::Value {
                        ty: value.ty.clone(),
                        qualifiers: Qualifiers::NONE,
                        pointee_qualifiers: None,
                    },
                    InferredBinding::Value(value),
                ))
            }
        }
    }

    fn require_inferred_value_type(
        &self,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<(), ParseError> {
        if matches!(
            *ty.inner_with(&self.module.types),
            TypeInner::Scalar(_) | TypeInner::Vector { .. } | TypeInner::Struct { .. }
        ) {
            Ok(())
        } else {
            Err(ParseError {
                message: String::from("unsupported auto value type"),
                span,
            })
        }
    }

    fn check_deduced_type(
        &self,
        previous: &mut Option<DeducedType>,
        deduced: DeducedType,
        span: Span,
    ) -> Result<(), ParseError> {
        if let Some(previous) = previous.as_ref() {
            let consistent = match (previous, &deduced) {
                (&DeducedType::ThreadBlock, &DeducedType::ThreadBlock) => true,
                (
                    &DeducedType::Value {
                        ty: ref previous,
                        qualifiers: previous_qualifiers,
                        pointee_qualifiers: previous_pointee,
                    },
                    &DeducedType::Value {
                        ref ty,
                        qualifiers,
                        pointee_qualifiers,
                    },
                ) => {
                    previous_qualifiers == qualifiers
                        && previous_pointee == pointee_qualifiers
                        && self.module.compare_types(previous, ty)
                }
                _ => false,
            };
            if !consistent {
                return Err(ParseError {
                    message: String::from("inconsistent deduced auto types in declaration"),
                    span,
                });
            }
        } else {
            *previous = Some(deduced);
        }
        Ok(())
    }

    fn bind_inferred_value(
        &mut self,
        name: &'a str,
        span: Span,
        value: Value,
        body: crate::Block,
        qualifiers: Qualifiers,
        is_constexpr: bool,
    ) -> Result<(), ParseError> {
        if is_constexpr {
            Self::required_constant(&value)?;
        }
        let ty = value.ty.clone();
        let handle = self.type_handle(&ty, span);
        let (local, pointer) = self.allocate_local(name, handle, span)?;
        self.function.symbol_table.add(
            name,
            Symbol::Variable {
                pointer,
                ty: ty.clone(),
                qualifiers,
            },
        );
        let end = value.span;
        let initializer = if is_constexpr
            || (qualifiers.is_const
                && matches!(
                    *ty.inner_with(&self.module.types),
                    TypeInner::Scalar(Scalar::BOOL | Scalar::I32 | Scalar::U32)
                )) {
            self.constant_local_initializer(local, value, body)?
        } else {
            self.append_block(body);
            value.handle
        };
        self.push_statement(
            Statement::Store {
                pointer,
                value: initializer,
            },
            span.until(&end),
        );
        Ok(())
    }
}
