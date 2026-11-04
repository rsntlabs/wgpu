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
        let mut ty = self.parse_type()?;
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
        if let TypeSpecifier::Array(array) = ty.ty {
            if pointer_qualifiers.is_some() && self.is_incomplete_array(array) {
                return Err(ParseError {
                    message: String::from("pointers to incomplete arrays are unsupported"),
                    span: declarator_span,
                });
            }
            if is_reference && pointer_qualifiers.is_none() {
                return Err(ParseError {
                    message: String::from("whole-array reference parameters are unsupported"),
                    span: declarator_span,
                });
            }
            if pointer_qualifiers.is_none() {
                let mut lookahead = self.lexer.clone();
                if matches!(lookahead.peek()?.0, Token::Word(_)) {
                    lookahead.next()?;
                }
                if lookahead.peek()?.0 != Token::Paren('[') {
                    let TypeInner::Array { base, .. } = self.module.types[array].inner else {
                        unreachable!()
                    };
                    ty = QualifiedType {
                        ty: TypeSpecifier::Pointer {
                            pointee: base,
                            pointee_qualifiers: ty.qualifiers,
                        },
                        qualifiers: Qualifiers::NONE,
                    };
                }
            }
        }
        Ok(ParameterType {
            ty,
            pointer_qualifiers,
            is_reference,
            type_span,
            declarator_span,
        })
    }
}
