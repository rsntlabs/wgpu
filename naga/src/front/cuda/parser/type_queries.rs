use super::*;

enum SizeofOperand {
    Scalar(SourceScalar),
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
        let result = (|| {
            if self.function.expression_depth > 64 {
                return self.fail("CUDA expression nesting limit exceeded");
            }
            self.parameter_expansion_budget
                .charge_work(1, self.lexer.peek()?.1)?;
            self.sizeof_operand_inner()
        })();
        self.function.expression_depth -= 1;
        result
    }

    fn sizeof_conditional_expression(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (condition, condition_span) = self.sizeof_binary_expression(0)?;
        let (token, question_span) = self.lexer.peek()?;
        if token != Token::Operation('?') {
            return Ok((condition, condition_span));
        }
        self.lexer.next()?;

        self.function.expression_depth += 1;
        let result = (|| {
            if self.function.expression_depth > 64 {
                return self.fail("CUDA expression nesting limit exceeded");
            }
            self.parameter_expansion_budget
                .charge_work(1, question_span)?;
            let supported_condition = match condition {
                SizeofOperand::Object(ref ty) => {
                    self.source_scalar(ty).is_some()
                        || self.source_pointer_pointee(ty).is_some()
                        || matches!(ty.inner_with(&self.module.types), TypeInner::Array { .. })
                }
                SizeofOperand::Scalar(_)
                | SizeofOperand::IncompleteArray(_)
                | SizeofOperand::NullPointer => true,
            };
            if !supported_condition {
                return Err(ParseError {
                    message: String::from(
                        "sizeof conditional requires a scalar, pointer, array, or nullptr condition",
                    ),
                    span: condition_span,
                });
            }
            let (accept, accept_span) = self.sizeof_conditional_expression()?;
            let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
            self.parameter_expansion_budget.charge_work(1, colon_span)?;
            let (reject, reject_span) = self.sizeof_conditional_expression()?;
            let operand = match (accept, reject) {
                (SizeofOperand::Object(ty), SizeofOperand::NullPointer)
                | (SizeofOperand::NullPointer, SizeofOperand::Object(ty))
                    if self.source_pointer_pointee(&ty).is_some() =>
                {
                    SizeofOperand::Object(ty)
                }
                (SizeofOperand::NullPointer, SizeofOperand::NullPointer) => {
                    SizeofOperand::NullPointer
                }
                (accept, reject) => {
                    let scalar_arm = |operand, span| {
                        self.sizeof_source_scalar(operand).ok_or_else(|| ParseError {
                            message: String::from(
                                "sizeof conditional requires scalar arms, a pointer with nullptr, or two nullptr arms",
                            ),
                            span,
                        })
                    };
                    let accept = scalar_arm(&accept, accept_span)?;
                    let reject = scalar_arm(&reject, reject_span)?;
                    SizeofOperand::Scalar(if accept == reject {
                        accept
                    } else {
                        Self::arithmetic_scalar(accept, reject)
                    })
                }
            };
            Ok((operand, condition_span.until(&reject_span)))
        })();
        self.function.expression_depth -= 1;
        result
    }

    fn sizeof_binary_expression(
        &mut self,
        minimum_precedence: u8,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (mut left, mut span) = self.sizeof_operand()?;
        while let Some((operator, precedence)) = expressions::binary_operator(self.lexer.peek()?.0)
        {
            if precedence < minimum_precedence {
                break;
            }
            let operator_span = self.lexer.next()?.1;
            self.parameter_expansion_budget
                .charge_work(1, operator_span)?;
            let (right, right_span) = self.sizeof_binary_expression(precedence + 1)?;
            left = self.sizeof_binary_operand(operator, left, right, operator_span)?;
            span = span.until(&right_span);
        }
        Ok((left, span))
    }

    fn sizeof_source_scalar(&self, operand: &SizeofOperand) -> Option<SourceScalar> {
        match *operand {
            SizeofOperand::Scalar(scalar) => Some(scalar),
            SizeofOperand::Object(ref ty) => self.source_scalar(ty),
            _ => None,
        }
    }

    const fn sizeof_promoted_scalar(scalar: SourceScalar) -> SourceScalar {
        if matches!(scalar.scalar(), Scalar::BOOL | Scalar::I16 | Scalar::U16) {
            SourceScalar::Scalar(Scalar::I32)
        } else {
            scalar
        }
    }

    fn sizeof_binary_operand(
        &self,
        operator: BinaryOperator,
        left: SizeofOperand,
        right: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from("sizeof binary operator requires supported scalar operands"),
            span,
        };
        let left = self.sizeof_source_scalar(&left).ok_or_else(invalid)?;
        let right = self.sizeof_source_scalar(&right).ok_or_else(invalid)?;
        let integral = |scalar: SourceScalar| {
            matches!(
                scalar.scalar().kind,
                ScalarKind::Sint | ScalarKind::Uint | ScalarKind::Bool
            )
        };
        let common = Self::arithmetic_scalar(left, right);
        let scalar = match operator {
            BinaryOperator::Add
            | BinaryOperator::Subtract
            | BinaryOperator::Multiply
            | BinaryOperator::Divide => common,
            BinaryOperator::Modulo
            | BinaryOperator::And
            | BinaryOperator::InclusiveOr
            | BinaryOperator::ExclusiveOr => {
                if !integral(left) || !integral(right) {
                    return Err(invalid());
                }
                common
            }
            BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight => {
                if !integral(left) || !integral(right) {
                    return Err(invalid());
                }
                Self::sizeof_promoted_scalar(left)
            }
            BinaryOperator::Equal
            | BinaryOperator::NotEqual
            | BinaryOperator::Less
            | BinaryOperator::LessEqual
            | BinaryOperator::Greater
            | BinaryOperator::GreaterEqual
            | BinaryOperator::LogicalAnd
            | BinaryOperator::LogicalOr => SourceScalar::Scalar(Scalar::BOOL),
        };
        Ok(SizeofOperand::Scalar(scalar))
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
                let (operand, _) = self.sizeof_conditional_expression()?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                (operand, start.until(&closing))
            }
            Token::Number(text) => {
                let number = number::parse(text).ok_or_else(|| ParseError {
                    message: String::from("unsupported or out-of-range numeric literal"),
                    span: start,
                })?;
                (SizeofOperand::Scalar(number.scalar), start)
            }
            Token::Word("true" | "false") => (
                SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)),
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
        while matches!(
            self.lexer.peek()?.0,
            Token::Separator('.') | Token::Arrow | Token::Paren('[')
        ) {
            if self.lexer.next_if(Token::Paren('['))? {
                let (index, _) = self.sizeof_conditional_expression()?;
                end = self.lexer.expect_span(Token::Paren(']'))?;
                operand = self.sizeof_subscript(operand, index, start.until(&end))?;
                continue;
            }
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

    fn sizeof_integral_operand(&self, operand: &SizeofOperand) -> bool {
        self.sizeof_source_scalar(operand).is_some_and(|scalar| {
            matches!(
                scalar.scalar().kind,
                ScalarKind::Sint | ScalarKind::Uint | ScalarKind::Bool
            )
        })
    }

    fn sizeof_subscript(
        &mut self,
        base: SizeofOperand,
        index: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from(
                "sizeof subscript requires one pointer or array and one integral operand",
            ),
            span,
        };
        let (pointer, index) = if self.sizeof_integral_operand(&base) {
            (index, base)
        } else {
            (base, index)
        };
        if !self.sizeof_integral_operand(&index) {
            return Err(invalid());
        }
        let operand = self
            .sizeof_dereference(pointer, span)
            .map_err(|_| invalid())?;
        if let SizeofOperand::Object(ref ty) = operand {
            let ty = self.type_handle(ty, span);
            if self.is_incomplete_array(ty) {
                return Err(ParseError {
                    message: String::from("sizeof subscript requires a complete element type"),
                    span,
                });
            }
        }
        Ok(operand)
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
            SizeofOperand::Scalar(_) | SizeofOperand::NullPointer => None,
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
            SizeofOperand::Scalar(scalar) => {
                if operator == '!' {
                    return Ok(SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)));
                }
                if operator == '~' && scalar.scalar().kind == ScalarKind::Float {
                    return Err(invalid());
                }
                return Ok(SizeofOperand::Scalar(Self::sizeof_promoted_scalar(scalar)));
            }
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
            SizeofOperand::Scalar(scalar) => u32::from(scalar.scalar().width),
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
            Symbol::TemplateFunctionParameter(Some(SourceType::Shader(ty))) => {
                TypeResolution::Handle(ty)
            }
            Symbol::TemplateFunctionParameter(Some(SourceType::NullPointer)) => {
                return Ok(SizeofOperand::NullPointer)
            }
            Symbol::TemplateFunctionParameter(_) => {
                return Err(ParseError {
                    message: String::from(
                        "sizeof requires a known nondependent function parameter type",
                    ),
                    span,
                })
            }
            Symbol::Member(Some(ty)) => TypeResolution::Handle(ty),
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
            Symbol::TemplateParameter { scalar, .. } => return Ok(SizeofOperand::Scalar(scalar)),
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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn sizeof_binary_scalar_types_preserve_source_identity_without_ir() {
        for (source, expected) in [
            ("(1L + 1u)", SourceScalar::Long(ScalarKind::Sint)),
            ("(1L + 1ull)", SourceScalar::Scalar(Scalar::U64)),
            ("(1ul + 1ll)", SourceScalar::Scalar(Scalar::U64)),
            ("(1u << 1ull)", SourceScalar::Scalar(Scalar::U32)),
            ("(true + false)", SourceScalar::Scalar(Scalar::I32)),
            ("(1.0f < 2u)", SourceScalar::Scalar(Scalar::BOOL)),
            ("(1 / 0)", SourceScalar::Scalar(Scalar::I32)),
            ("(1 << -1)", SourceScalar::Scalar(Scalar::I32)),
            ("(true || (1 / 0))", SourceScalar::Scalar(Scalar::BOOL)),
        ] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(
                matches!(operand, SizeofOperand::Scalar(scalar) if scalar == expected),
                "{source}"
            );
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.module.types.is_empty());
            assert!(parser.module.functions.is_empty());
            assert!(parser.module.global_variables.is_empty());
        }
    }

    #[test]
    fn sizeof_binary_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(1L + 1u)");
    }

    #[test]
    fn sizeof_conditional_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(1 / 0 ? 1L : 1u)");
    }

    #[test]
    fn sizeof_pointer_conditions_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(nullptr ? 1L : 1u)");
    }

    #[test]
    fn sizeof_pointer_arms_reuse_the_source_descriptor_under_allocation_limits() {
        for exhaust_bytes in [false, true] {
            let span = Span::new(0, 1);
            let mut parser = Parser::new(
                Lexer::new("(true ? nullptr : pointer)").unwrap(),
                &Options::default(),
            );
            let pointee = parser.module.types.insert(
                Type {
                    name: None,
                    inner: TypeInner::Scalar(Scalar::I32),
                },
                span,
            );
            let pointer = parser.query_parameter_pointer_type(pointee, span).unwrap();
            parser
                .insert_symbol(
                    "pointer",
                    Symbol::TemplateFunctionParameter(Some(SourceType::Shader(pointer))),
                    span,
                )
                .unwrap();
            exhaust_sizeof_allocation_budget(&mut parser, exhaust_bytes);
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(
                matches!(operand, SizeofOperand::Object(TypeResolution::Handle(handle)) if handle == pointer)
            );
            assert_eq!(parser.module.types.len(), 2);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.body.is_empty());
        }
    }

    fn check_sizeof_metadata_budget(source: &str) {
        for exhaust_bytes in [false, true] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            exhaust_sizeof_allocation_budget(&mut parser, exhaust_bytes);
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(matches!(
                operand,
                SizeofOperand::Scalar(SourceScalar::Long(ScalarKind::Sint))
            ));
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    fn exhaust_sizeof_allocation_budget(parser: &mut Parser<'_>, exhaust_bytes: bool) {
        let span = Span::new(0, 1);
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        for bit in (0..usize::BITS).rev() {
            let count = 1usize << bit;
            let _ = if exhaust_bytes {
                parser.parameter_expansion_budget.charge_bytes(count, span)
            } else {
                parser.parameter_expansion_budget.charge_nodes(count, span)
            };
        }
    }

    #[test]
    fn sizeof_conditional_rejects_excessive_arm_nesting_and_restores_depth() {
        for source in [
            format!("({}1)", "true ? 1 : ".repeat(70)),
            format!("({}1{})", "true ? ".repeat(70), " : 1".repeat(70)),
        ] {
            let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
            let Err(error) = parser.sizeof_operand() else {
                panic!("expected expression nesting error");
            };
            assert_eq!(error.message, "CUDA expression nesting limit exceeded");
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    #[test]
    fn sizeof_binary_errors_restore_depth_without_evaluation() {
        for source in ["(1 +)", "(1 + (2 *))", "((1)", "(1.0f % 2)", "(1 << 2.0f)"] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            assert!(parser.sizeof_operand().is_err(), "{source}");
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
        let mut parser = Parser::new(
            Lexer::new("(1 + 2 * 3 + 4 * 5)").unwrap(),
            &Options::default(),
        );
        let span = Span::new(0, 1);
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        parser
            .parameter_expansion_budget
            .charge_work(1, span)
            .unwrap();
        for bit in (3..usize::BITS).rev() {
            let _ = parser
                .parameter_expansion_budget
                .charge_work(1usize << bit, span);
        }
        let start = parser.lexer.position();
        assert!(parser.sizeof_operand().is_err());
        assert_ne!(parser.lexer.position(), start);
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_binary_preserves_legacy_grouping_depth_boundary() {
        for groups in [51, 63, 64] {
            let source = format!("{}1{}", "(".repeat(groups), ")".repeat(groups));
            let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
            assert_eq!(parser.sizeof_operand().is_ok(), groups < 64);
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    #[test]
    fn sizeof_operand_depth_and_work_errors_restore_expression_depth() {
        for exhaust_work in [false, true] {
            let mut parser = Parser::new(Lexer::new("1").unwrap(), &Options::default());
            let span = Span::new(0, 1);
            let previous_depth = if exhaust_work { 0 } else { 64 };
            parser.function.expression_depth = previous_depth;
            if exhaust_work {
                parser.parameter_expansion_budget.activate();
                parser.prepare_parameter_bindings(span).unwrap();
                for bit in (0..usize::BITS).rev() {
                    let _ = parser
                        .parameter_expansion_budget
                        .charge_work(1usize << bit, span);
                }
            }
            assert!(parser.sizeof_operand().is_err());
            assert_eq!(parser.function.expression_depth, previous_depth);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }
}
