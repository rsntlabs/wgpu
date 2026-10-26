use super::*;

impl Parser<'_> {
    pub(in super::super) fn source_pointer_variable(
        &mut self,
        pointer: PointerValue,
        is_const: bool,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        let mut pointer = self.pointer_rvalue(pointer)?;
        let PointerValueCategory::Value { position } = pointer.category else {
            unreachable!()
        };
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let ty = scalar_resolution(Scalar::U32);
        let cell = self.temporary_pointer(&ty, span)?;
        let value = self.load_pointer_position(position, span)?;
        self.generated_pointer_statement(
            Statement::Store {
                pointer: cell,
                value,
            },
            span,
        )?;
        while let PointerExpressionKind::Offset {
            base,
            offset,
            subtract,
        } = self.function.pointers.expressions[pointer.expression].kind
        {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let left = self.append(Expression::Load { pointer: cell }, span)?;
            let right = self.append(Expression::Load { pointer: offset }, span)?;
            let value = self.append(
                Expression::Binary {
                    op: if subtract {
                        BinaryOperator::Subtract
                    } else {
                        BinaryOperator::Add
                    },
                    left,
                    right,
                },
                span,
            )?;
            self.generated_pointer_statement(
                Statement::Store {
                    pointer: cell,
                    value,
                },
                span,
            )?;
            pointer.expression = base;
        }
        let binding = self.freeze_reference(ReferenceValue {
            reference: Reference::Pointer(cell),
            writable: true,
            ty,
            span,
            constant: ConstantValue::default(),
        })?;
        pointer.category = PointerValueCategory::Variable {
            binding,
            writable: !is_const,
        };
        pointer.span = span;
        pointer.constant = ConstantValue {
            literal: None,
            is_discardable: true,
        };
        pointer.constant_address = None;
        Ok(pointer)
    }

    pub(super) fn pointer_position_reference(
        &self,
        binding: Handle<BoundReference>,
        writable: bool,
        span: Span,
    ) -> ReferenceValue {
        ReferenceValue {
            reference: Reference::Bound(binding),
            writable,
            ty: scalar_resolution(Scalar::U32),
            span,
            constant: ConstantValue::default(),
        }
    }

    fn mutable_pointer_position(
        &self,
        pointer: &PointerValue,
    ) -> Result<ReferenceValue, ParseError> {
        match pointer.category {
            PointerValueCategory::Variable {
                binding,
                writable: true,
            } => Ok(self.pointer_position_reference(binding, true, pointer.span)),
            PointerValueCategory::Variable {
                writable: false, ..
            } => Err(ParseError {
                message: String::from("cannot modify a const pointer"),
                span: pointer.span,
            }),
            PointerValueCategory::Value { .. } => Err(ParseError {
                message: String::from("update requires a modifiable pointer lvalue"),
                span: pointer.span,
            }),
        }
    }

    pub(in super::super) fn pointer_update(
        &mut self,
        mut pointer: PointerValue,
        increment: bool,
        postfix: bool,
        span: Span,
    ) -> Result<ExpressionValue, ParseError> {
        let mut position = self.mutable_pointer_position(&pointer)?;
        let previous = if postfix {
            Some(self.pointer_rvalue(pointer.clone())?)
        } else {
            None
        };
        self.decorate_reference(&mut position, &mut |parser, cell, ty, reference_span| {
            parser.parameter_expansion_budget.charge_nodes(1, span)?;
            parser
                .parameter_expansion_budget
                .charge_slice::<(Statement, Span)>(1, span)?;
            parser.update_pointer(cell, ty, increment, reference_span, span)?;
            Ok(())
        })?;
        pointer = previous.unwrap_or(pointer);
        pointer.span = span;
        pointer.constant = ConstantValue::default();
        pointer.constant_address = None;
        Ok(ExpressionValue::Pointer(self.boxed_pointer_value(pointer)?))
    }

    pub(in super::super) fn pointer_assignment(
        &mut self,
        mut pointer: PointerValue,
        operator: Option<BinaryOperator>,
    ) -> Result<ExpressionValue, ParseError> {
        let Some(operator @ (BinaryOperator::Add | BinaryOperator::Subtract)) = operator else {
            return Err(ParseError {
                message: String::from("CUDA pointers support only += and -= assignment"),
                span: pointer.span,
            });
        };
        let mut position = self.mutable_pointer_position(&pointer)?;
        self.lexer.next()?;
        let (right, body) = self.capture_block(|parser| {
            let right = parser.expression(0)?;
            let right = parser.integral_operand(right)?;
            parser.convert_value(right.into(), &scalar_resolution(Scalar::U32))
        })?;
        let span = pointer.span.until(&right.span);
        self.prepend_block(body);
        self.decorate_reference(&mut position, &mut |parser, cell, _, _| {
            let left = parser.append(Expression::Load { pointer: cell }, span)?;
            let value = parser.append(
                Expression::Binary {
                    op: operator,
                    left,
                    right: right.handle,
                },
                span,
            )?;
            parser.generated_pointer_statement(
                Statement::Store {
                    pointer: cell,
                    value,
                },
                span,
            )
        })?;
        pointer.span = span;
        pointer.constant = ConstantValue::default();
        pointer.constant_address = None;
        Ok(ExpressionValue::Pointer(self.boxed_pointer_value(pointer)?))
    }

    pub(super) fn load_pointer_position(
        &mut self,
        position: Option<Handle<Expression>>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            match position {
                Some(pointer) => Expression::Load { pointer },
                None => Expression::Literal(Literal::U32(0)),
            },
            span,
        )
    }

    pub(super) fn combine_pointer_positions(
        &mut self,
        left: Option<Handle<Expression>>,
        right: Option<Handle<Expression>>,
        span: Span,
    ) -> Result<Option<Handle<Expression>>, ParseError> {
        match (left, right) {
            (Some(left), Some(right)) => {
                let left = self.load_pointer_position(Some(left), span)?;
                let right = self.load_pointer_position(Some(right), span)?;
                let value = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left,
                        right,
                    },
                    span,
                )?;
                self.freeze_reference_index(value, span).map(Some)
            }
            (position, None) | (None, position) => Ok(position),
        }
    }
}
