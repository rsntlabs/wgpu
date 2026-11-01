use super::*;

#[derive(Clone, Copy)]
enum Declarator {
    Value,
    Pointer { is_const: bool },
    Reference,
}

enum DeducedType {
    Value {
        ty: TypeResolution,
        is_const: bool,
        pointee_const: Option<bool>,
    },
    ThreadBlock,
}

enum InferredBinding {
    ThreadBlock,
    Value(Value),
    Pointer {
        pointer: PointerValue,
        is_const: bool,
    },
    Reference {
        value: ExpressionValue,
        ty: TypeResolution,
        is_const: bool,
    },
}

impl<'a> Parser<'a> {
    pub(super) fn inferred_local_declaration(
        &mut self,
        is_const: bool,
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
                parser.deduce_initializer(value, declarator, is_const, is_constexpr)
            })?;
            self.check_deduced_type(&mut deduced_type, deduced, span)?;
            match binding {
                InferredBinding::ThreadBlock => {
                    self.append_block(body);
                    self.function.symbol_table.add(name, Symbol::ThreadBlock);
                }
                InferredBinding::Value(value) => {
                    self.bind_inferred_value(name, span, value, body, is_const, is_constexpr)?;
                }
                InferredBinding::Pointer { pointer, is_const } => {
                    self.append_block(body);
                    self.bind_local_pointer(name, pointer, is_const, span)?;
                }
                InferredBinding::Reference {
                    value,
                    ty,
                    is_const,
                } => {
                    self.append_block(body);
                    self.bind_local_reference(name, span, ty, is_const, value)?;
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
                parser.deduce_initializer(value, declarator, true, true)
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
            let is_const = types::pointer_qualifiers(&mut self.lexer)?;
            if matches!(
                self.lexer.peek()?.0,
                Token::Operation('*' | '&') | Token::LogicalOperation('&')
            ) {
                return self
                    .fail("nested pointer and pointer reference declarators are unsupported");
            }
            Ok(Declarator::Pointer { is_const })
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
        is_const: bool,
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
                let source_const =
                    matches!(&value, ExpressionValue::Reference(reference) if !reference.writable);
                let ty = value.ty().clone();
                Ok((
                    DeducedType::Value {
                        ty: ty.clone(),
                        is_const: source_const && !is_const,
                        pointee_const: None,
                    },
                    InferredBinding::Reference {
                        value,
                        ty,
                        is_const: is_const || source_const,
                    },
                ))
            }
            Declarator::Pointer {
                is_const: pointer_const,
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
                    is_const: pointer.is_const && !is_const,
                    pointee_const: None,
                };
                pointer.is_const |= is_const;
                Ok((
                    deduced,
                    InferredBinding::Pointer {
                        pointer,
                        is_const: pointer_const,
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
                    is_const: false,
                    pointee_const: Some(pointer.is_const),
                };
                Ok((deduced, InferredBinding::Pointer { pointer, is_const }))
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
                        is_const: false,
                        pointee_const: None,
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
                        is_const: previous_const,
                        pointee_const: previous_pointee,
                    },
                    &DeducedType::Value {
                        ref ty,
                        is_const,
                        pointee_const,
                    },
                ) => {
                    previous_const == is_const
                        && previous_pointee == pointee_const
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
        is_const: bool,
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
                writable: !is_const,
            },
        );
        let end = value.span;
        let initializer = if is_constexpr
            || (is_const
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
