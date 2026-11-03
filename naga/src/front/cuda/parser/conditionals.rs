use super::*;

impl Parser<'_> {
    pub(super) fn conditional(
        &mut self,
        condition: ExpressionResult,
        start: usize,
    ) -> Result<ExpressionResult, ParseError> {
        let condition = self.truthy(condition.require_value()?)?;
        let (accept, accept_body) =
            self.capture_block(|parser| parser.comma_expression_result())?;
        self.lexer.expect_span(Token::Separator(':'))?;
        let (reject, reject_body) = self.capture_block(|parser| parser.expression_result(0))?;
        let span = self.lexer.span_from(start);
        let null_arms = matches!((&accept, &reject), (ExpressionResult::Value(left), ExpressionResult::Value(right))
            if left.is_null_pointer_constant() && right.is_null_pointer_constant()
                && (matches!(left, ExpressionValue::NullPointer(_)) || matches!(right, ExpressionValue::NullPointer(_))));
        if null_arms {
            let accept = accept.require_value()?;
            let reject = reject.require_value()?;
            let category = match (&accept, &reject) {
                (
                    &ExpressionValue::NullPointer(ref accept),
                    &ExpressionValue::NullPointer(ref reject),
                ) if accept.category == ValueCategory::Lvalue
                    && reject.category == ValueCategory::Lvalue =>
                {
                    ValueCategory::Lvalue
                }
                _ => ValueCategory::Prvalue,
            };
            let qualifiers = match (&accept, &reject) {
                (
                    &ExpressionValue::NullPointer(ref accept),
                    &ExpressionValue::NullPointer(ref reject),
                ) if category == ValueCategory::Lvalue => {
                    accept.qualifiers.union(reject.qualifiers)
                }
                _ => Qualifiers::NONE,
            };
            let accept = self.require_null_pointer_value(accept)?;
            let reject = self.require_null_pointer_value(reject)?;
            let is_constant = match condition.constant.literal {
                Some(Literal::Bool(true)) => accept.is_constant,
                Some(Literal::Bool(false)) => reject.is_constant,
                _ => false,
            };
            self.push_statement(
                Statement::If {
                    condition: condition.handle,
                    accept: accept_body,
                    reject: reject_body,
                },
                span,
            );
            let mut value = NullPointerValue::literal(span);
            value.category = category;
            value.qualifiers = qualifiers;
            value.is_constant = is_constant;
            value.constant.is_discardable = is_constant;
            return Ok(ExpressionValue::NullPointer(value).into());
        }
        match (accept, reject) {
            (ExpressionResult::Void(_), ExpressionResult::Void(_)) => {
                self.push_statement(
                    Statement::If {
                        condition: condition.handle,
                        accept: accept_body,
                        reject: reject_body,
                    },
                    span,
                );
                Ok(ExpressionResult::Void(span))
            }
            (
                ExpressionResult::Value(ExpressionValue::Reference(accept)),
                ExpressionResult::Value(ExpressionValue::Reference(reject)),
            ) if self.module.compare_types(&accept.ty, &reject.ty)
                && (accept.qualifiers.contains(reject.qualifiers)
                    || reject.qualifiers.contains(accept.qualifiers)) =>
            {
                let depth = 1 + self
                    .reference_depth(&accept)
                    .max(self.reference_depth(&reject));
                if depth > 64 {
                    return Err(ParseError {
                        message: String::from("CUDA reference nesting limit exceeded"),
                        span,
                    });
                }
                let ty = accept.ty.clone();
                let qualifiers = accept.qualifiers.union(reject.qualifiers);
                let discard_read = accept.discard_read && reject.discard_read;
                let constant = match condition.constant.literal {
                    Some(Literal::Bool(true)) => accept.constant,
                    Some(Literal::Bool(false)) => reject.constant,
                    _ => ConstantValue::default(),
                }
                .non_literal();
                let handle = self.function.conditional_references.append(
                    Some(ConditionalReference {
                        condition: condition.handle,
                        constant_condition: match condition.constant.literal {
                            Some(Literal::Bool(value)) => Some(value),
                            _ => None,
                        },
                        accept: ReferenceBranch {
                            body: accept_body,
                            reference: accept,
                        },
                        reject: ReferenceBranch {
                            body: reject_body,
                            reference: reject,
                        },
                        depth,
                    }),
                    span,
                );
                Ok(ExpressionResult::Value(ExpressionValue::Reference(
                    ReferenceValue {
                        discard_read,
                        reference: Reference::Conditional(handle),
                        qualifiers,
                        ty,
                        span,
                        constant,
                    },
                )))
            }
            (ExpressionResult::Value(accept), ExpressionResult::Value(reject)) => {
                if self.is_pointer_operand(&accept) || self.is_pointer_operand(&reject) {
                    let pointer = self.select_pointer(
                        condition,
                        accept,
                        accept_body,
                        reject,
                        reject_body,
                        span,
                    )?;
                    return self.pointer_result(pointer);
                }
                let ty = if self
                    .module
                    .compare_types(accept.shader_type()?, reject.shader_type()?)
                {
                    accept.shader_type()?.clone()
                } else {
                    scalar_resolution(Self::arithmetic_scalar(
                        self.require_scalar_type(accept.shader_type()?, accept.span())?,
                        self.require_scalar_type(reject.shader_type()?, reject.span())?,
                    ))
                };
                let category = match (&accept, &reject) {
                    (&ExpressionValue::Plain(ref accept), &ExpressionValue::Plain(ref reject))
                        if accept.category == ValueCategory::Xvalue
                            && reject.category == ValueCategory::Xvalue
                            && self.module.compare_types(&accept.ty, &reject.ty)
                            && (accept.qualifiers.contains(reject.qualifiers)
                                || reject.qualifiers.contains(accept.qualifiers)) =>
                    {
                        ValueCategory::Xvalue
                    }
                    _ => ValueCategory::Prvalue,
                };
                let source_qualifiers = |value: &ExpressionValue| match *value {
                    ExpressionValue::NullPointer(ref value) => value.qualifiers,
                    ExpressionValue::Plain(ref value) => value.qualifiers,
                    ExpressionValue::Reference(ref reference) => reference.qualifiers,
                    ExpressionValue::Pointer(_) => unreachable!(),
                };
                let qualifiers = source_qualifiers(&accept).union(source_qualifiers(&reject));
                let qualifiers = if category == ValueCategory::Prvalue {
                    self.prvalue_qualifiers(&ty, qualifiers)
                } else {
                    qualifiers
                };
                let is_result_object =
                    category == ValueCategory::Prvalue && self.is_source_class(&ty);
                let pointer = self.temporary_pointer(&ty, span)?;
                let (accept_constant, accept) = self.capture_block(|parser| {
                    parser.append_block(accept_body);
                    let value = parser.convert_value(accept, &ty)?;
                    let constant = value.constant;
                    if is_result_object {
                        parser.store_initializer(pointer, value.handle, span)?;
                    } else {
                        parser.push_statement(
                            Statement::Store {
                                pointer,
                                value: value.handle,
                            },
                            span,
                        );
                    }
                    Ok(constant)
                })?;
                let (reject_constant, reject) = self.capture_block(|parser| {
                    parser.append_block(reject_body);
                    let value = parser.convert_value(reject, &ty)?;
                    let constant = value.constant;
                    if is_result_object {
                        parser.store_initializer(pointer, value.handle, span)?;
                    } else {
                        parser.push_statement(
                            Statement::Store {
                                pointer,
                                value: value.handle,
                            },
                            span,
                        );
                    }
                    Ok(constant)
                })?;
                self.push_statement(
                    Statement::If {
                        condition: condition.handle,
                        accept,
                        reject,
                    },
                    span,
                );
                let handle = self.append(Expression::Load { pointer }, span)?;
                if is_result_object {
                    self.record_constructed_result(handle, pointer, span)?;
                }
                let constant = match condition.constant.literal {
                    Some(Literal::Bool(true)) => accept_constant,
                    Some(Literal::Bool(false)) => reject_constant,
                    _ => ConstantValue::default(),
                }
                .non_literal();
                Ok(Value {
                    category,
                    qualifiers,
                    constant,
                    handle,
                    ty,
                    span,
                }
                .into())
            }
            _ => Err(ParseError {
                message: String::from("conditional arms must both be scalar or both be void"),
                span,
            }),
        }
    }
}
