use super::*;

impl Parser<'_> {
    pub(in super::super) fn source_pointer_variable(
        &mut self,
        name: &str,
        pointer: PointerValue,
        is_const: bool,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        let mut pointer = self.pointer_rvalue(pointer)?;
        let pointee = self.function.pointers.expressions[pointer.expression].pointee;
        let cell = self.pointer_cell(
            pointee,
            pointer.is_const,
            PointerCellKind::Object {
                writable: !is_const,
            },
            span,
        )?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        self.function.ir.local_variables[cell].name = Some(String::from(name));
        let expression = self.function.pointers.cells[&cell].expression;
        let binding = self.freeze_reference(ReferenceValue {
            reference: Reference::Pointer(expression),
            writable: true,
            ty: scalar_resolution(Scalar::U32),
            span,
            constant: ConstantValue::default(),
        })?;
        self.pointer_operation(
            PointerOperation::Initialize {
                destination: cell,
                value: pointer.clone(),
            },
            span,
        )?;
        pointer.expression =
            self.retain_pointer_expression(PointerExpressionKind::Object(binding), pointee, span)?;
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

    fn mutable_pointer_binding(
        &self,
        pointer: &PointerValue,
    ) -> Result<Handle<BoundReference>, ParseError> {
        match pointer.category {
            PointerValueCategory::Variable {
                binding,
                writable: true,
            } => Ok(binding),
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
        let binding = self.mutable_pointer_binding(&pointer)?;
        let previous = if postfix {
            Some(self.pointer_rvalue(pointer.clone())?)
        } else {
            None
        };
        let amount = self.append(Expression::Literal(Literal::U32(1)), span)?;
        self.pointer_operation(
            PointerOperation::Update {
                destination: binding,
                amount,
                subtract: !increment,
            },
            span,
        )?;
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
        if operator.is_some_and(|operator| {
            !matches!(operator, BinaryOperator::Add | BinaryOperator::Subtract)
        }) {
            return Err(ParseError {
                message: String::from("CUDA pointers support only += and -= compound assignment"),
                span: pointer.span,
            });
        }
        let binding = self.mutable_pointer_binding(&pointer)?;
        self.lexer.next()?;
        if operator.is_none() {
            let (right, body) = self.capture_block(|parser| {
                let right = parser.expression(0)?;
                let span = right.span();
                parser.convert_pointer(right, &pointer.ty, pointer.is_const, span)
            })?;
            let span = pointer.span.until(&right.span);
            self.prepend_block(body);
            self.pointer_operation(
                PointerOperation::Assign {
                    destination: binding,
                    value: right,
                },
                span,
            )?;
            pointer.span = span;
            pointer.constant = ConstantValue::default();
            pointer.constant_address = None;
            return Ok(ExpressionValue::Pointer(self.boxed_pointer_value(pointer)?));
        }
        let (right, body) = self.capture_block(|parser| {
            let right = parser.expression(0)?;
            let right = parser.integral_operand(right)?;
            parser.convert_value(right.into(), &scalar_resolution(Scalar::U32))
        })?;
        let span = pointer.span.until(&right.span);
        self.prepend_block(body);
        self.pointer_operation(
            PointerOperation::Update {
                destination: binding,
                amount: right.handle,
                subtract: operator == Some(BinaryOperator::Subtract),
            },
            span,
        )?;
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
