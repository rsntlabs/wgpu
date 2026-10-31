use super::*;

impl Parser<'_> {
    pub(super) fn strong_compare_exchange(
        &mut self,
        pointer: Handle<Expression>,
        compare: Handle<Expression>,
        value: Handle<Expression>,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let scalar = match self.module.types[ty].inner {
            TypeInner::Scalar(scalar @ (Scalar::I32 | Scalar::U32)) => scalar,
            _ => return Err(expansion_error(span)),
        };
        let kind = crate::PredeclaredType::AtomicCompareExchangeWeakResult(scalar);
        if !self
            .module
            .special_types
            .predeclared_types
            .contains_key(&kind)
        {
            let budget = &mut self.parameter_expansion_budget;
            budget.charge_work(6, span)?;
            budget.charge_nodes(5, span)?;
            budget.charge_slice::<(Type, Span)>(3, span)?;
            budget.charge_map_entry::<Type, Handle<Type>>(3, span)?;
            budget.charge_slice::<StructMember>(2, span)?;
            budget.charge_map_entry::<crate::PredeclaredType, Handle<Type>>(1, span)?;
            budget.charge_bytes(128, span)?;
        }
        let result_type = self.module.generate_predeclared_type(kind);
        let destination = self.temporary_pointer(&TypeResolution::Handle(ty), span)?;
        // Leave room for both expressions in the retry condition.
        let compare = if self.function.expression_graph_depths[compare.index()] > 64 - 2 {
            let captured = self.temporary_pointer(&TypeResolution::Handle(ty), span)?;
            self.generated_statement(
                Statement::Store {
                    pointer: captured,
                    value: compare,
                },
                span,
            )?;
            self.append(Expression::Load { pointer: captured }, span)?
        } else {
            compare
        };
        let ((), body) = self.capture_block(|parser| {
            let result = parser.append_atomic_result(result_type, true, span)?;
            parser.generated_statement(
                Statement::Atomic {
                    pointer,
                    fun: crate::AtomicFunction::Exchange {
                        compare: Some(compare),
                    },
                    value,
                    result: Some(result),
                },
                span,
            )?;
            let old_value = parser.append(
                Expression::AccessIndex {
                    base: result,
                    index: 0,
                },
                span,
            )?;
            let exchanged = parser.append(
                Expression::AccessIndex {
                    base: result,
                    index: 1,
                },
                span,
            )?;
            parser.generated_statement(
                Statement::Store {
                    pointer: destination,
                    value: old_value,
                },
                span,
            )?;
            let different = parser.append(
                Expression::Binary {
                    op: BinaryOperator::NotEqual,
                    left: old_value,
                    right: compare,
                },
                span,
            )?;
            let finished = parser.append(
                Expression::Binary {
                    op: BinaryOperator::LogicalOr,
                    left: exchanged,
                    right: different,
                },
                span,
            )?;
            let ((), accept) = parser
                .capture_block(|parser| parser.generated_statement(Statement::Break, span))?;
            parser.generated_statement(
                Statement::If {
                    condition: finished,
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
        )?;
        self.append(
            Expression::Load {
                pointer: destination,
            },
            span,
        )
    }
}
