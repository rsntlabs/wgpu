use super::*;

impl Parser<'_> {
    fn loop_condition(&mut self, declaration: bool) -> Result<(), ParseError> {
        let value = if declaration {
            self.scalar_condition_declaration()?
        } else {
            self.comma_expression()?
        };
        let condition = self.truthy(value)?;
        let mut reject = crate::Block::new();
        reject.push(Statement::Break, condition.span);
        self.push_statement(
            Statement::If {
                condition: condition.handle,
                accept: crate::Block::new(),
                reject,
            },
            condition.span,
        );
        Ok(())
    }

    pub(super) fn while_loop(&mut self, start: Span) -> Result<(), ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        let declaration = self.condition_declaration_follows()?;
        let initialization_start = declaration.then(|| self.function.push_scope());
        let previous_guard = self.function.protected_if_header_scope;
        if declaration {
            self.function.protected_if_header_scope = None;
        }
        let result = self.capture_block(|parser| {
            parser.loop_condition(declaration)?;
            parser.lexer.expect_span(Token::Paren(')'))?;
            if declaration {
                parser.function.protected_if_header_scope =
                    Some(parser.function.symbol_table.scope_depth());
            }
            parser.function.loop_depth += 1;
            let result = parser.scoped_statement();
            parser.function.loop_depth -= 1;
            let (body, _) = result?;
            parser.push_statement(Statement::Block(body), start);
            Ok(())
        });
        self.function.protected_if_header_scope = previous_guard;
        if let Some(initialization_start) = initialization_start {
            self.function.pop_scope(initialization_start);
        }
        let ((), body) = result?;
        self.push_statement(
            Statement::Loop {
                body,
                continuing: crate::Block::new(),
                break_if: None,
            },
            start,
        );
        Ok(())
    }

    pub(super) fn for_loop(&mut self, start: Span) -> Result<(), ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        let initialization_start = self.function.push_scope();
        let result = self.for_loop_body(start);
        self.function.pop_scope(initialization_start);
        self.push_statement(Statement::Block(result?), start);
        Ok(())
    }

    fn for_loop_body(&mut self, start: Span) -> Result<crate::Block, ParseError> {
        let ((), mut init) = self.capture_block(|parser| {
            if !parser.lexer.next_if(Token::Separator(';'))? {
                if parser.lexer.peek()?.0 == Token::Word("namespace") {
                    return parser.fail("namespace aliases are unsupported in for initializers");
                }
                if parser.starts_declaration()? {
                    parser.local_declaration()?;
                } else {
                    parser.discard_expression()?;
                    parser.lexer.expect_span(Token::Separator(';'))?;
                }
            }
            Ok(())
        })?;
        let ((), mut body) = self.capture_block(|parser| {
            if !parser.lexer.next_if(Token::Separator(';'))? {
                let declaration = parser.condition_declaration_follows()?;
                parser.loop_condition(declaration)?;
                parser.lexer.expect_span(Token::Separator(';'))?;
            }
            Ok(())
        })?;
        let ((), continuing) = self.capture_block(|parser| {
            if !parser.lexer.next_if(Token::Paren(')'))? {
                parser.discard_expression()?;
                parser.lexer.expect_span(Token::Paren(')'))?;
            }
            Ok(())
        })?;
        self.function.loop_depth += 1;
        let result = self.capture_block(|parser| {
            if parser.lexer.next_if(Token::Paren('{'))? {
                parser.block_contents()
            } else {
                parser.statement()
            }
        });
        self.function.loop_depth -= 1;
        let (_, statements) = result?;
        body.extend_block(statements);
        init.push(
            Statement::Loop {
                body,
                continuing,
                break_if: None,
            },
            start,
        );
        Ok(init)
    }

    pub(super) fn do_loop(&mut self, start: Span) -> Result<(), ParseError> {
        self.function.loop_depth += 1;
        let result = self.scoped_statement();
        self.function.loop_depth -= 1;
        let (body, _) = result?;
        self.expect_ident("while")?;
        self.lexer.expect_span(Token::Paren('('))?;
        let ((break_if, end), continuing) = self.capture_block(|parser| {
            let value = parser.comma_expression()?;
            let condition = parser.truthy(value)?;
            let break_if = parser.append(
                Expression::Unary {
                    op: UnaryOperator::LogicalNot,
                    expr: condition.handle,
                },
                condition.span,
            )?;
            parser.lexer.expect_span(Token::Paren(')'))?;
            let end = parser.lexer.expect_span(Token::Separator(';'))?;
            Ok((break_if, end))
        })?;
        self.push_statement(
            Statement::Loop {
                body,
                continuing,
                break_if: Some(break_if),
            },
            start.until(&end),
        );
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn parser_with_outer_scope(source: &str) -> Parser<'_> {
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser
            .function
            .initialized_declarations
            .push(Span::new(0, 1));
        parser
            .function
            .symbol_table
            .add("outer", Symbol::PendingAuto);
        parser.function.protected_if_header_scope =
            Some(parser.function.symbol_table.scope_depth());
        parser.function.loop_depth = 7;
        parser.function.switch_depth = 2;
        parser
    }

    fn assert_outer_scope(parser: &Parser<'_>, depth: usize) {
        assert_eq!(parser.function.symbol_table.scope_depth(), depth);
        assert_eq!(parser.function.protected_if_header_scope, Some(depth));
        assert_eq!(parser.function.initialized_declarations, [Span::new(0, 1)]);
        assert_eq!(parser.function.loop_depth, 7);
        assert_eq!(parser.function.switch_depth, 2);
        assert_eq!(parser.function.statement_depth, 0);
        assert!(parser.function.symbol_table.lookup("outer").is_some());
        for name in ["header", "branch", "inner"] {
            assert!(parser.function.symbol_table.lookup(name).is_none());
        }
    }

    #[test]
    fn while_declaration_initialization_stays_in_loop_before_exit_test() {
        let source = "while(int header = 1) { header = 0; continue; }";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.statement().unwrap();
        assert!(!parser
            .function
            .ir
            .body
            .iter()
            .any(|statement| matches!(statement, &Statement::Store { .. })));
        let body = parser
            .function
            .ir
            .body
            .iter()
            .find_map(|statement| match *statement {
                Statement::Loop {
                    ref body,
                    ref continuing,
                    ..
                } => {
                    assert!(continuing.is_empty());
                    Some(body)
                }
                _ => None,
            })
            .unwrap();
        let initialize = body
            .iter()
            .position(|statement| matches!(statement, &Statement::Store { .. }))
            .unwrap();
        let test = body.iter().position(|statement| matches!(statement, &Statement::If { ref reject, .. } if reject.iter().any(|statement| matches!(statement, &Statement::Break)))).unwrap();
        assert!(initialize < test);
        assert!(body.iter().any(|statement| matches!(statement, &Statement::Block(ref block) if block.iter().any(|statement| matches!(statement, &Statement::Continue)))));
        assert!(parser.function.symbol_table.lookup("header").is_none());
    }

    #[test]
    fn while_declaration_errors_restore_outer_scope_and_control_depths() {
        for source in [
            "while(int header) {}",
            "while(auto header = header) {}",
            "while(int header = 1; header) {}",
            "while(int header = 1) { int header = 2; }",
            "while(int header = 1) { int branch = 2;",
            "while(int header = 1) { while(auto inner{}) {} }",
        ] {
            let mut parser = parser_with_outer_scope(source);
            let depth = parser.function.symbol_table.scope_depth();
            assert!(parser.statement().is_err(), "{source}");
            assert_outer_scope(&parser, depth);
        }
    }

    #[test]
    fn while_declaration_resource_errors_restore_header_metadata() {
        for inferred in [false, true] {
            for resource in 0..3 {
                let source = if inferred {
                    "while(auto header = 1) {}"
                } else {
                    "while(int header = 1) {}"
                };
                let mut parser = parser_with_outer_scope(source);
                let span = Span::new(0, 1);
                let depth = parser.function.symbol_table.scope_depth();
                parser.parameter_expansion_budget.activate();
                parser.prepare_parameter_bindings(span).unwrap();
                for bit in (0..usize::BITS).rev() {
                    let count = 1usize << bit;
                    let _ = match resource {
                        0 => parser.parameter_expansion_budget.charge_nodes(count, span),
                        1 => parser.parameter_expansion_budget.charge_bytes(count, span),
                        _ => parser.parameter_expansion_budget.charge_work(count, span),
                    };
                }
                assert!(parser.statement().is_err());
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_outer_scope(&parser, depth);
            }
        }
    }

    #[test]
    fn for_declaration_is_initialized_in_body_and_loaded_in_continuing() {
        let source = "for (; int header = 1; header += 2) { header = 3; continue; }";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.statement().unwrap();
        let &[Statement::Block(ref init)] = &parser.function.ir.body[..] else {
            panic!("expected for scope");
        };
        let &[Statement::Loop {
            ref body,
            ref continuing,
            ..
        }] = &init[..]
        else {
            panic!("condition initializer belongs inside the loop");
        };
        let initialize = body
            .iter()
            .position(|statement| matches!(statement, Statement::Store { .. }))
            .unwrap();
        let exit = body.iter().position(|statement| {
            matches!(statement, Statement::If { reject, .. } if matches!(&reject[..], [Statement::Break]))
        }).unwrap();
        assert!(initialize < exit);
        let Statement::Store { pointer, .. } = body[initialize] else {
            unreachable!();
        };
        let expressions = &parser.function.ir.expressions;
        assert!(continuing.iter().any(|statement| match *statement {
            Statement::Emit(ref range) => range.clone().any(|handle| {
                matches!(expressions[handle], Expression::Load { pointer: loaded } if loaded == pointer)
            }),
            _ => false,
        }));
        assert!(parser.function.symbol_table.lookup("header").is_none());
    }

    #[test]
    fn for_declaration_errors_restore_outer_scope_and_control_depths() {
        for source in [
            "for (int branch = 1; auto header = header;) {}",
            "for (int branch = 1; int header = 2; header +=) {}",
            "for (int branch = 1; int header = 2;) { int inner = 3;",
        ] {
            let mut parser = parser_with_outer_scope(source);
            let depth = parser.function.symbol_table.scope_depth();
            assert!(parser.statement().is_err(), "{source}");
            assert_outer_scope(&parser, depth);
        }
    }

    #[test]
    fn ordinary_while_preserves_inactive_and_exhausted_work_budget_behavior() {
        for active in [false, true] {
            let mut parser =
                Parser::new(Lexer::new("while(false) {}").unwrap(), &Options::default());
            if active {
                parser.parameter_expansion_budget.activate();
                parser.prepare_parameter_bindings(Span::new(0, 1)).unwrap();
                for bit in (0..usize::BITS).rev() {
                    let _ = parser
                        .parameter_expansion_budget
                        .charge_work(1usize << bit, Span::new(0, 1));
                }
            }
            let depth = parser.function.symbol_table.scope_depth();
            parser.statement().unwrap();
            assert_eq!(parser.function.symbol_table.scope_depth(), depth);
            assert_eq!(parser.parameter_expansion_budget.activate(), !active);
        }
    }
}
