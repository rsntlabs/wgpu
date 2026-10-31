use super::*;

impl Parser<'_> {
    pub(in super::super) fn promote_scalar_locals(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.span_from(0);
        self.activate_parameter_expansion(span)?;
        if self.parameter_expansion_budget.is_exhausted() {
            return Err(limit_error(span));
        }
        let result = self.promote_scalar_functions(span);
        self.function = FunctionContext::new(FunctionKind::Kernel);
        match result {
            Err(_) if self.parameter_expansion_budget.is_exhausted() => Ok(()),
            result => result,
        }
    }

    fn promote_scalar_functions(&mut self, span: Span) -> Result<(), ParseError> {
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
            if self.parameter_expansion_budget.is_exhausted() {
                return Ok(());
            }
        }
        for index in 0..self.module.entry_points.len() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let function = core::mem::take(&mut self.module.entry_points[index].function);
            self.module.entry_points[index].function =
                self.promote_scalar_function(function, span)?;
            if self.parameter_expansion_budget.is_exhausted() {
                return Ok(());
            }
        }
        Ok(())
    }

    fn promote_scalar_function(
        &mut self,
        function: Function,
        span: Span,
    ) -> Result<Function, ParseError> {
        let result: Result<Option<Function>, ParseError> = (|| {
            let promotions = ScalarPromotions::analyze(self, &function, span)?;
            if promotions.is_empty() {
                return Ok(None);
            }
            self.clone_parameter_function(
                &function,
                FunctionParameterState::default(),
                Vec::new(),
                Some(&promotions),
                span,
            )?;
            Ok(Some(core::mem::take(&mut self.function.ir)))
        })();
        match result {
            Ok(promoted) => Ok(promoted.unwrap_or(function)),
            Err(_) if self.parameter_expansion_budget.is_exhausted() => {
                self.function = FunctionContext::new(FunctionKind::Kernel);
                Ok(function)
            }
            Err(error) => Err(error),
        }
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
        let Some(name) = invocation.source.local_variables[local].name.as_ref() else {
            return Ok(true);
        };
        if !matches!(
            self.function.ir.expressions[value],
            Expression::FunctionArgument(_)
        ) && !self.function.ir.named_expressions.contains_key(&value)
        {
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
