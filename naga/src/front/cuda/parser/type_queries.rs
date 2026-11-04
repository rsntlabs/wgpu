use super::*;

impl Parser<'_> {
    pub(super) fn type_query(&mut self, name: &str, span: Span) -> Result<Value, ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;

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
        let span = span.until(&closing);
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
