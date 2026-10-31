use super::*;

impl Parser<'_> {
    pub(super) fn wrapping_atomic_call(
        &mut self,
        mut reference: ReferenceValue,
        limit: Handle<Expression>,
        function: WrappingAtomicFunction,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let ty = scalar_resolution(Scalar::U32);
        let captured_limit = self.temporary_pointer(&ty, span)?;
        self.generated_statement(
            Statement::Store {
                pointer: captured_limit,
                value: limit,
            },
            span,
        )?;
        let limit = self.append(
            Expression::Load {
                pointer: captured_limit,
            },
            span,
        )?;
        let result_pointer = self.temporary_pointer(&ty, span)?;
        self.decorate_reference(&mut reference, &mut |parser, pointer, _, span| {
            parser.emit_wrapping_atomic(pointer, limit, function, result_pointer, span)
        })?;
        Ok(self.load_pointer(result_pointer, &ty, span)?.into())
    }

    fn emit_wrapping_atomic(
        &mut self,
        pointer: Handle<Expression>,
        limit: Handle<Expression>,
        function: WrappingAtomicFunction,
        result_pointer: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        let ty = self.scalar_handle(Scalar::U32, span);
        let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let one = self.append(Expression::Literal(Literal::U32(1)), span)?;
        let initial = self.append_atomic_result(ty, false, span)?;
        self.generated_statement(
            Statement::Atomic {
                pointer,
                fun: AtomicFunction::Add,
                value: zero,
                result: Some(initial),
            },
            span,
        )?;
        self.generated_statement(
            Statement::Store {
                pointer: result_pointer,
                value: initial,
            },
            span,
        )?;
        let ((), body) = self.capture_block(|parser| {
            let expected = parser.append(
                Expression::Load {
                    pointer: result_pointer,
                },
                span,
            )?;
            let (condition, reset, step) = match function {
                WrappingAtomicFunction::Increment => (
                    parser.append(
                        Expression::Binary {
                            op: BinaryOperator::GreaterEqual,
                            left: expected,
                            right: limit,
                        },
                        span,
                    )?,
                    zero,
                    BinaryOperator::Add,
                ),
                WrappingAtomicFunction::Decrement => {
                    let is_zero = parser.append(
                        Expression::Binary {
                            op: BinaryOperator::Equal,
                            left: expected,
                            right: zero,
                        },
                        span,
                    )?;
                    let above_limit = parser.append(
                        Expression::Binary {
                            op: BinaryOperator::Greater,
                            left: expected,
                            right: limit,
                        },
                        span,
                    )?;
                    let condition = parser.append(
                        Expression::Binary {
                            op: BinaryOperator::LogicalOr,
                            left: is_zero,
                            right: above_limit,
                        },
                        span,
                    )?;
                    (condition, limit, BinaryOperator::Subtract)
                }
            };
            let adjusted = parser.append(
                Expression::Binary {
                    op: step,
                    left: expected,
                    right: one,
                },
                span,
            )?;
            let replacement = parser.append(
                Expression::Select {
                    condition,
                    accept: reset,
                    reject: adjusted,
                },
                span,
            )?;
            let observed = parser.append_atomic_result(ty, false, span)?;
            parser.generated_statement(
                Statement::Atomic {
                    pointer,
                    fun: AtomicFunction::Exchange {
                        compare: Some(expected),
                    },
                    value: replacement,
                    result: Some(observed),
                },
                span,
            )?;
            parser.generated_statement(
                Statement::Store {
                    pointer: result_pointer,
                    value: observed,
                },
                span,
            )?;
            let matched = parser.append(
                Expression::Binary {
                    op: BinaryOperator::Equal,
                    left: observed,
                    right: expected,
                },
                span,
            )?;
            let ((), accept) = parser
                .capture_block(|parser| parser.generated_statement(Statement::Break, span))?;
            parser.generated_statement(
                Statement::If {
                    condition: matched,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            )
        })?;
        self.generated_statement(
            Statement::Loop {
                body,
                continuing: crate::Block::new(),
                break_if: None,
            },
            span,
        )
    }
}
