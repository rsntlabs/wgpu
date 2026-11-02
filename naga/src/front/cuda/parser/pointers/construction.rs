use super::*;

#[derive(Clone, Copy)]
enum PointerConversion {
    Initialization,
    Cast,
}

impl PointerConversion {
    fn error(self, span: Span) -> ParseError {
        ParseError {
            message: String::from(match self {
                Self::Initialization => "incompatible CUDA pointer type",
                Self::Cast => "unsupported CUDA pointer cast",
            }),
            span,
        }
    }
}

impl Parser<'_> {
    pub(in super::super) fn pointer_value_constructor(
        &mut self,
        pointee: Handle<Type>,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let target = self.pointer_type(pointee, span);
        let mut pointer = match self.lexer.peek()?.0 {
            Token::Paren('{') => self.pointer_list_initializer(&target, qualifiers)?,
            Token::Paren('(') => {
                self.lexer.next()?;
                if self.lexer.peek()?.0 == Token::Paren(')') {
                    let end = self.lexer.next()?.1;
                    self.value_initialized_pointer(&target, qualifiers, span.until(&end))?
                } else {
                    let value = self.expression(0)?;
                    let end = self.lexer.expect_span(Token::Paren(')'))?;
                    self.cast_pointer(value, &target, qualifiers, span.until(&end))?
                }
            }
            _ => return self.fail("expected a pointer constructor argument list"),
        };
        pointer.span = span.until(&pointer.span);
        self.pointer_result(pointer)
    }

    pub(super) fn pointer_list_initializer(
        &mut self,
        target: &TypeResolution,
        qualifiers: Qualifiers,
    ) -> Result<PointerValue, ParseError> {
        let start = self.lexer.expect_span(Token::Paren('{'))?;
        if self.lexer.peek()?.0 == Token::Paren('}') {
            let end = self.lexer.next()?.1;
            return self.value_initialized_pointer(target, qualifiers, start.until(&end));
        }
        let value = self.expression(0)?;
        self.lexer.next_if(Token::Separator(','))?;
        let end = self.lexer.expect_span(Token::Paren('}'))?;
        let value_span = value.span();
        let mut pointer = self.convert_pointer(value, target, qualifiers, value_span)?;
        pointer.span = start.until(&end);
        Ok(pointer)
    }

    fn value_initialized_pointer(
        &mut self,
        target: &TypeResolution,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        let mut pointer = self.null_pointer(target, qualifiers, span)?;
        pointer.constant.is_discardable = true;
        Ok(pointer)
    }

    pub(in super::super) fn convert_pointer(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        self.pointer_conversion(
            value,
            target,
            qualifiers,
            span,
            PointerConversion::Initialization,
        )
    }

    pub(in super::super) fn cast_pointer(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<PointerValue, ParseError> {
        let mut pointer =
            self.pointer_conversion(value, target, qualifiers, span, PointerConversion::Cast)?;
        pointer.span = span;
        Ok(pointer)
    }

    fn pointer_conversion(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
        qualifiers: Qualifiers,
        span: Span,
        conversion: PointerConversion,
    ) -> Result<PointerValue, ParseError> {
        let constant = value.constant();
        if value.is_null_pointer_constant() {
            let mut pointer = self.null_pointer(target, qualifiers, span)?;
            pointer.constant.is_discardable = constant.is_discardable;
            return Ok(pointer);
        }
        if matches!(conversion, PointerConversion::Cast) && !self.is_pointer_operand(&value) {
            return Err(conversion.error(span));
        }
        let mut pointer = self.borrowed_pointer(value)?;
        if !self.module.compare_types(&pointer.ty, target)
            || !qualifiers.contains(pointer.qualifiers)
        {
            return Err(conversion.error(span));
        }
        pointer.qualifiers = qualifiers;
        pointer.constant.is_discardable &= constant.is_discardable;
        pointer.constant = pointer.constant.non_literal();
        Ok(pointer)
    }
}
