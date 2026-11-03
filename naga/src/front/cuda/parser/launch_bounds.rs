use super::*;

#[derive(Clone, Copy)]
pub(super) struct LaunchBounds {
    pub(super) max_threads: Option<u32>,
    pub(super) span: Span,
}

impl<'a> Parser<'a> {
    pub(super) fn launch_bounds(&mut self) -> Result<LaunchBounds, ParseError> {
        let start = self.lexer.expect_span(Token::Word("__launch_bounds__"))?;
        self.activate_parameter_expansion(start)?;
        self.prepare_parameter_bindings(start)?;
        self.lexer.expect_span(Token::Paren('('))?;
        let mut max_threads = None;
        let mut count = 0;
        loop {
            if count == 3 {
                return self.fail("launch bounds require one to three arguments");
            }
            let argument_start = self.lexer.clone();
            let (argument_end, dependent) = self.launch_bound_argument_end()?;
            if !dependent {
                self.lexer = argument_start.bounded(argument_end.position());
                let result = self.capture_block(|parser| {
                    let expression = parser.conditional_expression()?;
                    let value = parser.rvalue(expression)?;
                    let literal = Self::required_constant(&value)?;
                    let integer = match literal {
                        Literal::I32(value) => value,
                        Literal::U32(value) => value as i32,
                        Literal::Bool(value) => i32::from(value),
                        _ => {
                            return Err(ParseError {
                                message: String::from(
                                    "launch bounds require integral constant expressions",
                                ),
                                span: value.span,
                            })
                        }
                    };
                    parser.lexer.expect_span(Token::End)?;
                    Ok((integer > 0).then_some(integer as u32))
                });
                self.lexer = argument_end;
                let (value, _) = result?;
                if count == 0 {
                    max_threads = value;
                }
            } else {
                self.lexer = argument_end;
            }
            count += 1;
            if self.lexer.peek()?.0 == Token::Paren(')') {
                let end = self.lexer.expect_span(Token::Paren(')'))?;
                return Ok(LaunchBounds {
                    max_threads,
                    span: start.until(&end),
                });
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
    }

    fn launch_bound_argument_end(&mut self) -> Result<(Lexer<'a>, bool), ParseError> {
        let mut lexer = self.lexer.clone();
        let mut delimiters = Vec::new();
        let mut dependent = false;
        let mut template_name = false;
        let mut empty = true;
        loop {
            let (token, span) = lexer.peek()?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            if delimiters.is_empty() && matches!(token, Token::Separator(',') | Token::Paren(')')) {
                if empty {
                    return Err(ParseError {
                        message: String::from("expected a launch bound argument"),
                        span,
                    });
                }
                return Ok((lexer, dependent));
            }
            let next_template_name = if let Token::Word(name) = token {
                dependent |= matches!(
                    self.lookup_symbol(name),
                    Some(Symbol::TemplateParameter { literal: None, .. })
                        | Some(Symbol::TemplateTypeParameter {
                            ty: QualifiedType {
                                ty: TypeSpecifier::TemplateParameter(_),
                                ..
                            }
                        })
                );
                name == "static_cast" || self.has_function_template(name)
            } else {
                false
            };
            let closing = match token {
                Token::Paren('(') => Some(')'),
                Token::Paren('[') => Some(']'),
                Token::Paren('{') => Some('}'),
                Token::Paren('<') if template_name => Some('>'),
                _ => None,
            };
            if let Some(closing) = closing {
                if delimiters.len() == 64 {
                    return Err(ParseError {
                        message: String::from("CUDA launch bound nesting limit exceeded"),
                        span,
                    });
                }
                self.parameter_expansion_budget
                    .charge_slice::<char>(1, span)?;
                delimiters.push(closing);
            } else {
                match token {
                    Token::Paren(close @ (')' | ']' | '}')) => {
                        if delimiters.pop() != Some(close) {
                            return Err(ParseError {
                                message: String::from("mismatched launch bound delimiter"),
                                span,
                            });
                        }
                    }
                    Token::Paren('>') if delimiters.last() == Some(&'>') => {
                        delimiters.pop();
                    }
                    Token::ShiftOperation('>') if delimiters.last() == Some(&'>') => {
                        delimiters.pop();
                        if delimiters.pop() != Some('>') {
                            return Err(ParseError {
                                message: String::from("mismatched launch bound template delimiter"),
                                span,
                            });
                        }
                    }
                    Token::End | Token::Separator(';') => {
                        return Err(ParseError {
                            message: String::from("unterminated launch bounds"),
                            span,
                        })
                    }
                    _ => {}
                }
            }
            empty = false;
            template_name = next_template_name;
            lexer.next()?;
        }
    }

    pub(super) fn trailing_launch_bounds(
        &mut self,
        bounds: &mut Option<LaunchBounds>,
    ) -> Result<(), ParseError> {
        self.function.symbol_table.reduce_lookup_scope();
        let result = (|| {
            while self.lexer.peek()?.0 == Token::Word("__launch_bounds__") {
                let next = self.launch_bounds()?;
                bounds.get_or_insert(next);
            }
            Ok(())
        })();
        self.function.symbol_table.reset_lookup_scope();
        result
    }

    pub(super) fn parameters_with_launch_bounds(
        &mut self,
        bounds: &mut Option<LaunchBounds>,
    ) -> Result<(), ParseError> {
        self.function.symbol_table.push_scope();
        self.parameters()?;
        self.trailing_launch_bounds(bounds)
    }

    pub(super) fn check_launch_bounds(
        &self,
        bounds: Option<LaunchBounds>,
    ) -> Result<(), ParseError> {
        if let Some(LaunchBounds {
            max_threads: Some(maximum),
            span,
        }) = bounds
        {
            let threads: u32 = self.workgroup_size.into_iter().product();
            if threads > maximum {
                return Err(ParseError {
                    message: format!("workgroup contains {threads} threads but CUDA launch bounds allow at most {maximum}"),
                    span,
                });
            }
        }
        Ok(())
    }
}
