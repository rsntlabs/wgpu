use super::*;

pub(super) struct CallUniformity<'a> {
    pub(super) arguments: &'a [bool],
    synchronizing: &'a [bool],
    contexts: &'a mut [Option<Vec<bool>>],
}

impl CallUniformity<'_> {
    pub(super) fn synchronizes(
        &self,
        function: Handle<Function>,
        span: Span,
    ) -> Result<bool, ParseError> {
        self.synchronizing
            .get(function.index())
            .copied()
            .ok_or_else(|| barrier_error(span))
    }

    pub(super) fn join(
        &mut self,
        function: Handle<Function>,
        arguments: &[Handle<Expression>],
        values: &[bool],
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<(), ParseError> {
        budget.charge_work(arguments.len(), span)?;
        let context = self
            .contexts
            .get_mut(function.index())
            .ok_or_else(|| barrier_error(span))?;
        if context.is_none() {
            budget.charge_slice::<bool>(arguments.len(), span)?;
            *context = Some(alloc::vec![true; arguments.len()]);
        }
        let context = context.as_mut().unwrap();
        if context.len() != arguments.len() {
            return Err(barrier_error(span));
        }
        for (uniform, argument) in context.iter_mut().zip(arguments) {
            *uniform &= values[argument.index()];
        }
        Ok(())
    }
}

struct Synchronization {
    functions: Vec<bool>,
    builtin_inputs: Vec<u8>,
    entry_inputs: Vec<u8>,
    entry_calls: Vec<Option<Span>>,
}

impl Synchronization {
    fn new(
        module: &Module,
        globals: [Option<Handle<GlobalVariable>>; 3],
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<Self, ParseError> {
        budget.charge_slice::<bool>(module.functions.len(), span)?;
        budget.charge_slice::<u8>(module.functions.len(), span)?;
        budget.charge_slice::<u8>(module.entry_points.len(), span)?;
        budget.charge_slice::<Option<Span>>(module.entry_points.len(), span)?;
        let mut summary = Self {
            functions: Vec::with_capacity(module.functions.len()),
            builtin_inputs: Vec::with_capacity(module.functions.len()),
            entry_inputs: Vec::with_capacity(module.entry_points.len()),
            entry_calls: Vec::with_capacity(module.entry_points.len()),
        };
        for (handle, function) in module.functions.iter() {
            budget.charge_work(1, span)?;
            let direct = Self::builtin_inputs(function, globals, budget, span)?;
            let (synchronizes, inputs, _) = summary.scan(function, budget, span)?;
            if handle.index() != summary.functions.len() {
                return Err(barrier_error(span));
            }
            summary.functions.push(synchronizes);
            summary
                .builtin_inputs
                .push(if synchronizes { direct | inputs } else { 0 });
        }
        for entry in &module.entry_points {
            budget.charge_work(1, span)?;
            let direct = Self::builtin_inputs(&entry.function, globals, budget, span)?;
            let (_, inputs, call) = summary.scan(&entry.function, budget, span)?;
            summary.entry_inputs.push(direct | inputs);
            summary.entry_calls.push(call);
        }
        Ok(summary)
    }

    fn builtin_inputs(
        function: &Function,
        globals: [Option<Handle<GlobalVariable>>; 3],
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<u8, ParseError> {
        let mut inputs = 0;
        for (_, expression) in function.expressions.iter() {
            budget.charge_work(1, span)?;
            let Expression::Load { pointer } = *expression else {
                continue;
            };
            let Expression::GlobalVariable(global) = function.expressions[pointer] else {
                continue;
            };
            if globals[1] == Some(global) {
                inputs |= 1;
            } else if globals[2] == Some(global) {
                inputs |= 2;
            }
        }
        Ok(inputs)
    }

    fn scan(
        &self,
        function: &Function,
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<(bool, u8, Option<Span>), ParseError> {
        budget.charge_slice::<&crate::Block>(1, span)?;
        let mut pending = alloc::vec![&function.body];
        let mut synchronizes = false;
        let mut inputs = 0;
        let mut call = None;
        while let Some(block) = pending.pop() {
            for (statement, &span) in block.span_iter() {
                budget.charge_work(1, span)?;
                let mut child = |body| -> Result<(), ParseError> {
                    budget.charge_slice::<&crate::Block>(1, span)?;
                    pending.push(body);
                    Ok(())
                };
                match *statement {
                    Statement::ControlBarrier(_) => synchronizes = true,
                    Statement::Call { function, .. } => {
                        let Some(&callee_synchronizes) = self.functions.get(function.index())
                        else {
                            return Err(barrier_error(span));
                        };
                        if callee_synchronizes {
                            synchronizes = true;
                            inputs |= self.builtin_inputs[function.index()];
                            call.get_or_insert(span);
                        }
                    }
                    Statement::Block(ref body) => child(body)?,
                    Statement::If {
                        ref accept,
                        ref reject,
                        ..
                    } => {
                        child(reject)?;
                        child(accept)?;
                    }
                    Statement::Switch { ref cases, .. } => {
                        for case in cases {
                            child(&case.body)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        ..
                    } => {
                        child(continuing)?;
                        child(body)?;
                    }
                    _ => {}
                }
            }
        }
        Ok((synchronizes, inputs, call))
    }
}

impl Parser<'_> {
    pub(super) fn check_helper_barriers(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.span_from(0);
        self.activate_parameter_expansion(span)?;
        if self.parameter_expansion_budget.is_exhausted() {
            return Err(ParseError {
                message: String::from("CUDA barrier uniformity analysis resource limit exceeded"),
                span,
            });
        }
        let summary = Synchronization::new(
            &self.module,
            self.helper_builtin_globals,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        self.rewrite_barrier_builtins(&summary.builtin_inputs, &summary.entry_inputs, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Option<Vec<bool>>>(self.module.functions.len(), span)?;
        self.parameter_expansion_budget
            .charge_work(self.module.functions.len(), span)?;
        let mut contexts = alloc::vec![None; self.module.functions.len()];
        for (index, entry) in self.module.entry_points.iter().enumerate() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let span = match (
                summary.entry_calls[index],
                check_control_flow(&entry.function.body, false, false),
            ) {
                (None, Ok(_)) => continue,
                (Some(span), _) => span,
                (None, Err(error)) => error.span,
            };
            let mut proof = UniformControlFlow::new(
                &self.module,
                &entry.function,
                &mut self.parameter_expansion_budget,
                span,
            )?;
            proof.calls = Some(CallUniformity {
                arguments: &[],
                synchronizing: &summary.functions,
                contexts: &mut contexts,
            });
            proof.analyze()?;
            proof.check(&entry.function.body, false, false, &mut 0)?;
        }
        for (handle, function) in self.module.functions.iter().rev() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let Some(arguments) = contexts[handle.index()].take() else {
                continue;
            };
            if arguments.len() != function.arguments.len() || !summary.functions[handle.index()] {
                return Err(barrier_error(span));
            }
            let mut proof = UniformControlFlow::new(
                &self.module,
                function,
                &mut self.parameter_expansion_budget,
                self.module.functions.get_span(handle),
            )?;
            proof.calls = Some(CallUniformity {
                arguments: &arguments,
                synchronizing: &summary.functions,
                contexts: &mut contexts,
            });
            proof.analyze()?;
            proof.check(&function.body, false, false, &mut 0)?;
        }
        Ok(())
    }
}
