use super::*;

#[derive(Clone, Copy)]
enum Declarator {
    Value,
    Pointer { qualifiers: Qualifiers },
    Reference,
}

enum DeducedType {
    NullPointer {
        qualifiers: Qualifiers,
    },
    Value {
        ty: TypeResolution,
        qualifiers: Qualifiers,
        pointee_qualifiers: Option<Qualifiers>,
    },
    ThreadBlock,
}

enum InferredBinding {
    NullPointer {
        qualifiers: Qualifiers,
    },
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
                InferredBinding::NullPointer { qualifiers } => {
                    self.append_block(body);
                    self.bind_null_pointer_symbol(name, span, qualifiers)?;
                }
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
                    if qualifiers.is_volatile {
                        return self.fail("volatile pointer objects are unsupported");
                    }
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
                if let InferredBinding::NullPointer { qualifiers } = binding {
                    self.activate_parameter_expansion(span)?;
                    self.parameter_expansion_budget.charge_nodes(1, span)?;
                    self.parameter_expansion_budget
                        .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
                    let mut value = NullPointerValue::literal(span);
                    value.category = ValueCategory::Lvalue;
                    value.qualifiers = qualifiers;
                    self.global_declarations
                        .insert(name, GlobalDeclaration::NullPointer(value));
                    if self.lexer.next_if(Token::Separator(','))? {
                        continue;
                    }
                    self.lexer.expect_span(Token::Separator(';'))?;
                    return Ok(());
                }
                return self.fail("constexpr requires a scalar variable");
            };
            let scalar = self.require_scalar_type(&value.ty, value.span)?;
            let literal = Self::required_constant(&value)?;
            self.bind_global_constant(name, scalar, literal, span)?;
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
            Token::Paren('(') if !has_equals => {
                if declarations::parenthesized_function_declaration(self, self.lexer.clone())? {
                    return self.fail("local function declarations are unsupported");
                }
                Some(')')
            }
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
                if qualifiers.is_volatile {
                    return self.fail("volatile thread_block objects are unsupported");
                }
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
        if let ExpressionValue::NullPointer(value) = value {
            if is_constexpr && matches!(declarator, Declarator::Reference) {
                return self.fail("constexpr reference declarations are unsupported");
            }
            if qualifiers.is_volatile {
                return self.fail("volatile nullptr_t objects are unsupported");
            }
            let deduced_qualifiers = if matches!(declarator, Declarator::Reference) {
                value.qualifiers.without(qualifiers)
            } else {
                Qualifiers::NONE
            };
            let binding_qualifiers = if matches!(declarator, Declarator::Reference) {
                let source = value.qualifiers;
                self.require_null_pointer_reference(
                    ExpressionValue::NullPointer(value.clone()),
                    qualifiers.union(source),
                )?;
                qualifiers.union(source)
            } else {
                qualifiers
            };
            if matches!(declarator, Declarator::Pointer { .. }) {
                return self.fail("auto pointer deduction requires a pointer or array");
            }
            if is_constexpr && !value.is_constant {
                return self.fail("constexpr requires a constant expression");
            }
            return Ok((
                DeducedType::NullPointer {
                    qualifiers: deduced_qualifiers,
                },
                InferredBinding::NullPointer {
                    qualifiers: binding_qualifiers,
                },
            ));
        }
        match declarator {
            Declarator::Reference => {
                if is_constexpr {
                    return self.fail("constexpr reference declarations are unsupported");
                }
                if matches!(value, ExpressionValue::Pointer(_))
                    || matches!(
                        *value.shader_type()?.inner_with(&self.module.types),
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
                self.require_inferred_value_type(value.shader_type()?, value.span())?;
                let source_qualifiers = match value {
                    ExpressionValue::Reference(ref reference) => reference.qualifiers,
                    _ => Qualifiers::NONE,
                };
                let ty = value.shader_type()?.clone();
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
                (
                    &DeducedType::NullPointer {
                        qualifiers: previous,
                    },
                    &DeducedType::NullPointer { qualifiers },
                ) => previous == qualifiers,
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
        if qualifiers.is_volatile {
            return self.fail("volatile automatic objects are unsupported");
        }
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
