use super::*;

pub(super) struct ParameterType {
    pub(super) ty: QualifiedType,
    pub(super) pointer_qualifiers: Option<Qualifiers>,
    pub(super) is_reference: bool,
    pub(super) type_span: Span,
    pub(super) declarator_span: Span,
}

impl Parser<'_> {
    pub(super) fn parameter_type(&mut self) -> Result<ParameterType, ParseError> {
        let type_span = self.lexer.peek()?.1;
        let ty = self.parse_type()?;
        let declarator_span = self.lexer.peek()?.1;
        let (pointer_qualifiers, is_reference) = if matches!(ty.ty, TypeSpecifier::ThreadBlock) {
            (None, false)
        } else {
            let pointer_qualifiers = if self.lexer.next_if(Token::Operation('*'))? {
                Some(types::pointer_qualifiers(&mut self.lexer)?)
            } else {
                None
            };
            let is_reference = self.lexer.next_if(Token::Operation('&'))?;
            (pointer_qualifiers, is_reference)
        };
        Ok(ParameterType {
            ty,
            pointer_qualifiers,
            is_reference,
            type_span,
            declarator_span,
        })
    }
}
