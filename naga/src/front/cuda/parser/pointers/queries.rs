use super::*;

impl Parser<'_> {
    pub(super) fn null_pointer(
        &mut self,
        target: &TypeResolution,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        let TypeInner::Pointer {
            base,
            space: AddressSpace::Function,
        } = *target.inner_with(&self.module.types)
        else {
            return Err(ParseError {
                message: String::from("expected a CUDA source pointer type"),
                span,
            });
        };
        let expression = self.retain_pointer_expression(PointerExpressionKind::Null, base, span)?;
        Ok(PointerValue {
            expression,
            ty: target.clone(),
            qualifiers,
            span,
            constant: ConstantValue::default(),
            constant_address: None,
            category: PointerValueCategory::Value { position: None },
        })
    }

    pub(in super::super) fn pointer_test(
        &mut self,
        value: ExpressionValue,
        is_null: bool,
    ) -> Result<Value, ParseError> {
        let pointer = self.borrowed_pointer(value)?;
        let span = pointer.span;
        let ty = scalar_resolution(Scalar::BOOL);
        let destination = self.temporary_pointer(&ty, span)?;
        self.pointer_operation(
            PointerOperation::Test {
                destination,
                value: pointer,
                is_null,
            },
            span,
        )?;
        self.load_pointer(destination, &ty, span)
    }

    pub(super) fn pointer_null_comparison(
        &mut self,
        left: ExpressionValue,
        right: ExpressionValue,
        right_body: crate::Block,
        operator: BinaryOperator,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let is_null = operator == BinaryOperator::Equal;
        let left_null = left.is_null_pointer_constant();
        let right_null = right.is_null_pointer_constant();
        let pointer = if self.is_pointer_operand(&left) && right_null {
            let pointer = self.borrowed_pointer(left)?;
            self.append_block(right_body);
            pointer
        } else if left_null && self.is_pointer_operand(&right) {
            self.append_block(right_body);
            self.borrowed_pointer(right)?
        } else {
            return Err(ParseError {
                message: String::from("CUDA pointer comparisons require an integer literal zero"),
                span,
            });
        };
        let pointer = ExpressionValue::Pointer(self.boxed_pointer_value(pointer)?);
        let mut value = self.pointer_test(pointer, is_null)?;
        value.span = span;
        Ok(value.into())
    }
}
