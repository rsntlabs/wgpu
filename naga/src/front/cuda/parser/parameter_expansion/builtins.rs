use super::*;

pub(super) struct BuiltinRemapping<'a> {
    functions: &'a [u8],
    inputs: u8,
    entry_point: bool,
}

pub(super) struct BuiltinArguments<'a> {
    functions: &'a [u8],
    globals: [Option<Handle<GlobalVariable>>; 2],
    values: [Option<Handle<Expression>>; 2],
}

impl Parser<'_> {
    pub(in super::super) fn rewrite_barrier_builtins(
        &mut self,
        functions: &[u8],
        entries: &[u8],
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_slice::<Handle<Function>>(self.module.functions.len(), span)?;
        self.parameter_expansion_budget
            .charge_work(self.module.functions.len(), span)?;
        let handles: Vec<_> = self
            .module
            .functions
            .iter()
            .map(|(handle, _)| handle)
            .collect();
        for handle in handles {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let inputs = functions[handle.index()];
            if inputs == 0 {
                continue;
            }
            let span = self.module.functions.get_span(handle);
            let source = core::mem::take(&mut self.module.functions[handle]);
            self.clone_function(
                &source,
                FunctionParameterState::default(),
                Vec::new(),
                None,
                Some(BuiltinRemapping {
                    functions,
                    inputs,
                    entry_point: false,
                }),
                span,
            )?;
            self.module.functions[handle] = core::mem::take(&mut self.function.ir);
        }
        for (index, &inputs) in entries.iter().enumerate() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if inputs == 0 {
                continue;
            }
            let source = core::mem::take(&mut self.module.entry_points[index].function);
            self.clone_function(
                &source,
                FunctionParameterState::default(),
                Vec::new(),
                None,
                Some(BuiltinRemapping {
                    functions,
                    inputs,
                    entry_point: true,
                }),
                span,
            )?;
            self.module.entry_points[index].function = core::mem::take(&mut self.function.ir);
        }
        self.function = FunctionContext::new(FunctionKind::Kernel);
        Ok(())
    }

    pub(super) fn prepare_builtin_arguments<'a>(
        &mut self,
        source: &Function,
        arguments: &[MappedExpression],
        remapping: BuiltinRemapping<'a>,
        span: Span,
    ) -> Result<BuiltinArguments<'a>, ParseError> {
        let mut values = [None; 2];
        let globals = [
            self.helper_builtin_globals[1],
            self.helper_builtin_globals[2],
        ];
        for (index, value) in values.iter_mut().enumerate() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if remapping.inputs & (1 << index) == 0 {
                continue;
            }
            let global = globals[index].ok_or_else(|| expansion_error(span))?;
            let (name, builtin) = BUILTIN_INPUTS[index + 1];
            let mapped = if remapping.entry_point {
                self.parameter_expansion_budget
                    .charge_work(source.arguments.len(), span)?;
                let argument = source
                    .arguments
                    .iter()
                    .position(|argument| argument.binding == Some(Binding::BuiltIn(builtin)))
                    .ok_or_else(|| expansion_error(span))?;
                let MappedExpression::Value(mapped) = arguments[argument] else {
                    return Err(expansion_error(span));
                };
                mapped
            } else {
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<FunctionArgument>(1, span)?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len(), span)?;
                let argument = self.function.ir.arguments.len() as u32;
                self.function.ir.arguments.push(FunctionArgument {
                    name: Some(String::from(name)),
                    ty: self.module.global_variables[global].ty,
                    binding: None,
                });
                self.append(Expression::FunctionArgument(argument), span)?
            };
            *value = Some(mapped);
        }
        Ok(BuiltinArguments {
            functions: remapping.functions,
            globals,
            values,
        })
    }

    pub(super) fn invocation_builtin_load(
        &self,
        invocation: &Invocation<'_>,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<Option<Handle<Expression>>, ParseError> {
        let Some(builtins) = invocation.builtins.as_ref() else {
            return Ok(None);
        };
        let Expression::GlobalVariable(global) = invocation.source.expressions[pointer] else {
            return Ok(None);
        };
        for (index, &recorded) in builtins.globals.iter().enumerate() {
            if recorded == Some(global) {
                return builtins.values[index]
                    .map(Some)
                    .ok_or_else(|| expansion_error(span));
            }
        }
        Ok(None)
    }

    pub(super) fn append_invocation_builtins(
        &mut self,
        invocation: &Invocation<'_>,
        function: Handle<Function>,
        arguments: &mut Vec<Handle<Expression>>,
        span: Span,
    ) -> Result<(), ParseError> {
        let Some(builtins) = invocation.builtins.as_ref() else {
            return Ok(());
        };
        let inputs = *builtins
            .functions
            .get(function.index())
            .ok_or_else(|| expansion_error(span))?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(inputs.count_ones() as usize, span)?;
        for (index, &value) in builtins.values.iter().enumerate() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if inputs & (1 << index) != 0 {
                arguments.push(value.ok_or_else(|| expansion_error(span))?);
            }
        }
        Ok(())
    }
}
