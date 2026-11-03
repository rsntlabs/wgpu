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
        if ![
            Scalar::I16,
            Scalar::U16,
            Scalar::I32,
            Scalar::U32,
            Scalar::F32,
        ]
        .contains(&target)
        {
            return Err(ParseError {
                message: String::from("unsupported scalar conversion"),
                span: value.span,
            });
        }
        let constant = value
            .constant
            .literal
            .and_then(|literal| constant_evaluation::convert(literal, target));
        let handle = if let Some(literal) = constant.filter(|_| value.constant.is_nonfinite()) {
            self.materialize_literal(literal, value.span)?
        } else {
            self.append(
                Expression::As {
                    expr: value.handle,
                    kind: target.kind,
                    convert: Some(target.width),
                },
                value.span,
            )?
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(target),
            span: value.span,
            constant: ConstantValue::evaluated(constant),
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
        if matches!(
            self.require_scalar_type(&value.ty, value.span)?,
            Scalar::BOOL | Scalar::I16 | Scalar::U16
        ) {
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
        let folded = constant.filter(|literal| {
            left.constant.is_nonfinite()
                || right.constant.is_nonfinite()
                || ConstantValue::from(*literal).is_nonfinite()
        });
        let handle = if let Some(literal) = folded {
            self.materialize_literal(literal, span)?
        } else if operator == BinaryOperator::Divide && scalar == Scalar::F32 {
            if let Some(literal @ Literal::F32(_)) = constant {
                self.materialize_literal(literal, span)?
            } else {
                self.divide_f32(left.handle, right.handle, span)?
            }
        } else {
            self.append(
                Expression::Binary {
                    op: operator,
                    left: left.handle,
                    right: right.handle,
                },
                span,
            )?
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(scalar),
            span,
            constant: ConstantValue::evaluated(constant),
        })
    }

    pub(super) fn cast_type(&mut self) -> Result<QualifiedType, ParseError> {
        let span = self.lexer.peek()?.1;
        let target = self.parse_type()?;
        let target = self.alias_declarator(target)?;
        if !matches!(
            target.ty,
            TypeSpecifier::NullPointer
                | TypeSpecifier::Scalar(_)
                | TypeSpecifier::Vector { .. }
                | TypeSpecifier::Structure(_)
                | TypeSpecifier::Dim3
                | TypeSpecifier::Pointer { .. }
        ) {
            return Err(ParseError {
                message: String::from("unsupported cast target"),
                span,
            });
        }
        if target.qualifiers.is_volatile
            && matches!(
                target.ty,
                TypeSpecifier::Vector { .. } | TypeSpecifier::Structure(_) | TypeSpecifier::Dim3
            )
        {
            return Err(ParseError {
                message: String::from("volatile class value construction is unsupported"),
                span,
            });
        }
        Ok(target)
    }

    pub(super) fn cast_source_value(
        &mut self,
        value: ExpressionValue,
        target: QualifiedType,
        span: Span,
    ) -> Result<ExpressionValue, ParseError> {
        if matches!(target.ty, TypeSpecifier::NullPointer) {
            let mut value = self.require_null_pointer_value(value)?;
            value.span = span;
            return Ok(ExpressionValue::NullPointer(value.rvalue()));
        }
        if let TypeSpecifier::Pointer {
            pointee,
            pointee_qualifiers,
        } = target.ty
        {
            let target = self.pointer_type(pointee, span);
            let pointer = self.cast_pointer(value, &target, pointee_qualifiers, span)?;
            return self
                .boxed_pointer_value(pointer)
                .map(ExpressionValue::Pointer);
        }
        let ty = self.lower_type(target.ty, span)?;
        let mut value = self.cast_value(value, &ty)?;
        value.qualifiers = self.prvalue_qualifiers(&ty, target.qualifiers);
        value.span = span;
        Ok(value.into())
    }

    pub(super) fn cast_value(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
    ) -> Result<Value, ParseError> {
        if self.is_source_class(target) {
            let value = self.rvalue(value)?;
            self.require_volatile_scalar(value.qualifiers, &value.ty, value.span)?;
            let mut value = self.convert_value(value.into(), target)?;
            value.category = ValueCategory::Prvalue;
            value.qualifiers = Qualifiers::NONE;
            value.constant = value.constant.non_literal();
            return Ok(value);
        }
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
