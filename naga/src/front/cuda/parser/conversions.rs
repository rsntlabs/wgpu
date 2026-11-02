use super::*;

impl Parser<'_> {
    pub(super) fn convert_value(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
    ) -> Result<Value, ParseError> {
        if *target.inner_with(&self.module.types) == TypeInner::Scalar(Scalar::BOOL)
            && self.is_pointer_operand(&value)
        {
            return self.truthy(value);
        }
        if self.module.compare_types(value.shader_type()?, target) {
            return self.rvalue(value);
        }
        if self.dimension_conversion(value.shader_type()?, target) {
            return self.convert_dimension(value, target);
        }
        let scalar = self.require_scalar_type(target, value.span())?;
        self.convert_scalar(value, scalar)
    }

    pub(super) fn convert_scalar(
        &mut self,
        value: ExpressionValue,
        target: Scalar,
    ) -> Result<Value, ParseError> {
        if target == Scalar::BOOL && self.is_pointer_operand(&value) {
            return self.truthy(value);
        }
        let value = self.rvalue(value)?;
        if self.require_scalar_type(&value.ty, value.span)? == target {
            return Ok(value);
        }
        if target == Scalar::BOOL {
            return self.truthy(value.into());
        }
        if ![Scalar::I32, Scalar::U32, Scalar::F32].contains(&target) {
            return Err(ParseError {
                message: String::from("unsupported scalar conversion"),
                span: value.span,
            });
        }
        let handle = self.append(
            Expression::As {
                expr: value.handle,
                kind: target.kind,
                convert: Some(target.width),
            },
            value.span,
        )?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(target),
            span: value.span,
            constant: ConstantValue::evaluated(
                value
                    .constant
                    .literal
                    .and_then(|literal| constant_evaluation::convert(literal, target)),
            ),
        })
    }

    pub(super) fn usual_arithmetic(
        &mut self,
        left: ExpressionValue,
        right: ExpressionValue,
    ) -> Result<(Value, Value), ParseError> {
        let common = Self::arithmetic_scalar(
            self.require_scalar_type(left.shader_type()?, left.span())?,
            self.require_scalar_type(right.shader_type()?, right.span())?,
        );
        Ok((
            self.convert_scalar(left, common)?,
            self.convert_scalar(right, common)?,
        ))
    }

    pub(super) fn arithmetic_scalar(left: Scalar, right: Scalar) -> Scalar {
        let scalars = [left, right];
        if scalars.contains(&Scalar::F32) {
            Scalar::F32
        } else if scalars.contains(&Scalar::U32) {
            Scalar::U32
        } else {
            Scalar::I32
        }
    }

    pub(super) fn promote_integral(&mut self, value: ExpressionValue) -> Result<Value, ParseError> {
        let value = self.rvalue(value)?;
        if self.require_scalar_type(&value.ty, value.span)? == Scalar::BOOL {
            self.convert_scalar(value.into(), Scalar::I32)
        } else {
            Ok(value)
        }
    }

    pub(super) fn integral_operand(&mut self, value: ExpressionValue) -> Result<Value, ParseError> {
        if self
            .require_scalar_type(value.shader_type()?, value.span())?
            .kind
            == ScalarKind::Float
        {
            return Err(ParseError {
                message: String::from("operator requires integral operands"),
                span: value.span(),
            });
        }
        self.promote_integral(value)
    }

    pub(super) fn binary_value(
        &mut self,
        operator: BinaryOperator,
        left: ExpressionValue,
        right: ExpressionValue,
    ) -> Result<Value, ParseError> {
        let span = left.span().until(&right.span());
        let shift = matches!(
            operator,
            BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight
        );
        let mut constant = None;
        let (left, right) =
            match operator {
                BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight => {
                    let left = self.integral_operand(left)?;
                    let right = self.integral_operand(right)?;
                    constant = left.constant.literal.zip(right.constant.literal).and_then(
                        |(left, right)| constant_evaluation::binary(operator, left, right),
                    );
                    let mut right = self.convert_scalar(right.into(), Scalar::U32)?;
                    if operator == BinaryOperator::ShiftLeft {
                        // Keep wrapping shifts out of WGSL constant evaluation.
                        let ty = self.scalar_handle(Scalar::U32, right.span);
                        let local = self.function.ir.local_variables.append(
                            LocalVariable {
                                name: None,
                                ty,
                                init: None,
                            },
                            right.span,
                        );
                        let pointer = self.append(Expression::LocalVariable(local), right.span)?;
                        self.push_statement(
                            Statement::Store {
                                pointer,
                                value: right.handle,
                            },
                            right.span,
                        );
                        right.handle = self.append(Expression::Load { pointer }, right.span)?;
                    }
                    (left, right)
                }
                BinaryOperator::Modulo
                | BinaryOperator::And
                | BinaryOperator::InclusiveOr
                | BinaryOperator::ExclusiveOr => {
                    let left = self.integral_operand(left)?;
                    let right = self.integral_operand(right)?;
                    self.usual_arithmetic(left.into(), right.into())?
                }
                _ => self.usual_arithmetic(left, right)?,
            };
        if !shift {
            constant = left
                .constant
                .literal
                .zip(right.constant.literal)
                .and_then(|(left, right)| constant_evaluation::binary(operator, left, right));
        }
        let scalar = match operator {
            BinaryOperator::Equal
            | BinaryOperator::NotEqual
            | BinaryOperator::Less
            | BinaryOperator::LessEqual
            | BinaryOperator::Greater
            | BinaryOperator::GreaterEqual => Scalar::BOOL,
            _ => self.require_scalar_type(&left.ty, left.span)?,
        };
        let handle = self.append(
            Expression::Binary {
                op: operator,
                left: left.handle,
                right: right.handle,
            },
            span,
        )?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(scalar),
            span,
            constant: ConstantValue::evaluated(constant),
        })
    }

    pub(super) fn cast_type(&mut self) -> Result<SourceType<TypeResolution>, ParseError> {
        let span = self.lexer.peek()?.1;
        let ty = self.parse_type()?.ty;
        if matches!(ty, TypeSpecifier::NullPointer) {
            return Ok(SourceType::NullPointer);
        }
        if matches!(ty, TypeSpecifier::Pointer { .. }) {
            return Err(ParseError {
                message: String::from("pointer casts are unsupported"),
                span,
            });
        }
        if !matches!(ty, TypeSpecifier::Scalar(_)) {
            return Err(ParseError {
                message: String::from("vector casts are unsupported"),
                span,
            });
        }
        self.lower_type(ty, span).map(SourceType::Shader)
    }

    pub(super) fn cast_source_value(
        &mut self,
        value: ExpressionValue,
        target: SourceType<TypeResolution>,
        span: Span,
    ) -> Result<ExpressionValue, ParseError> {
        match target {
            SourceType::NullPointer => {
                let mut value = self.require_null_pointer_value(value)?;
                value.span = span;
                Ok(ExpressionValue::NullPointer(value.rvalue()))
            }
            SourceType::Shader(target) => {
                let mut value = self.cast_value(value, &target)?;
                value.span = span;
                Ok(value.into())
            }
            SourceType::ThreadBlock => self.fail("thread_block casts are unsupported"),
        }
    }

    pub(super) fn cast_value(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
    ) -> Result<Value, ParseError> {
        if *target.inner_with(&self.module.types) == TypeInner::Scalar(Scalar::BOOL) {
            if let ExpressionValue::NullPointer(value) = value {
                return self.null_pointer_boolean(value);
            }
        }
        if *target.inner_with(&self.module.types) != TypeInner::Scalar(Scalar::BOOL)
            || !self.is_pointer_operand(&value)
        {
            self.require_scalar_type(value.shader_type()?, value.span())?;
        }
        let mut value = self.convert_value(value, target)?;
        value.constant = value.constant.non_literal();
        Ok(value)
    }
}
