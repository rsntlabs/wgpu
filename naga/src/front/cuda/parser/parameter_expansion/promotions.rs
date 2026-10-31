use super::*;

impl Parser<'_> {
    pub(in super::super) fn promote_scalar_locals(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.span_from(0);
        self.activate_parameter_expansion(span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Function>>(self.module.functions.len(), span)?;
        self.parameter_expansion_budget
            .charge_work(self.module.functions.len(), span)?;
        let functions: Vec<_> = self
            .module
            .functions
            .iter()
            .map(|(handle, _)| handle)
            .collect();
        for handle in functions {
            let span = self.module.functions.get_span(handle);
            let function = core::mem::take(&mut self.module.functions[handle]);
            self.module.functions[handle] = self.promote_scalar_function(function, span)?;
        }
        for index in 0..self.module.entry_points.len() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let function = core::mem::take(&mut self.module.entry_points[index].function);
            self.module.entry_points[index].function =
                self.promote_scalar_function(function, span)?;
        }
        self.function = FunctionContext::new(FunctionKind::Kernel);
        Ok(())
    }

    fn promote_scalar_function(
        &mut self,
        function: Function,
        span: Span,
    ) -> Result<Function, ParseError> {
        let promotions = ScalarPromotions::analyze(self, &function, span)?;
        if promotions.is_empty() {
            return Ok(function);
        }
        self.clone_parameter_function(
            function,
            FunctionParameterState::default(),
            Vec::new(),
            Some(&promotions),
            span,
        )?;
        Ok(core::mem::take(&mut self.function.ir))
    }

    pub(super) fn remove_promoted_store(
        &mut self,
        invocation: &mut Invocation<'_>,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<bool, ParseError> {
        let Some(promotions) = invocation.promotions else {
            return Ok(false);
        };
        let Expression::LocalVariable(local) = invocation.source.expressions[pointer] else {
            return Ok(false);
        };
        let Some(initializer) = promotions.initializer(local) else {
            return Ok(false);
        };
        if initializer != value {
            return Err(expansion_error(span));
        }
        let value = self.invocation_value(invocation, value)?;
        if !matches!(
            self.function.ir.expressions[value],
            Expression::FunctionArgument(_)
        ) && !self.function.ir.named_expressions.contains_key(&value)
        {
            let name = invocation.source.local_variables[local]
                .name
                .as_ref()
                .ok_or_else(|| expansion_error(span))?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Expression>, String>(1, span)?;
            self.parameter_expansion_budget
                .charge_bytes(name.len(), span)?;
            self.function
                .ir
                .named_expressions
                .insert(value, name.clone());
        }
        Ok(true)
    }
}
