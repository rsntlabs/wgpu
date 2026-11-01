use super::*;

impl Parser<'_> {
    pub(super) fn emit_workgroup_barrier(&mut self, span: Span) -> Result<(), ParseError> {
        if self.function.kind == FunctionKind::Device {
            return Err(ParseError {
                message: String::from("barriers are unsupported in device helpers"),
                span,
            });
        }
        self.push_statement(
            Statement::ControlBarrier(crate::Barrier::WORK_GROUP | crate::Barrier::STORAGE),
            span,
        );
        Ok(())
    }

    pub(super) fn check_workgroup_barriers(&mut self) -> Result<(), ParseError> {
        for index in 0..self.module.entry_points.len() {
            self.parameter_expansion_budget
                .charge_work(1, self.lexer.span_from(0))?;
            let error = match check_control_flow(
                &self.module.entry_points[index].function.body,
                false,
                false,
            ) {
                Ok(_) => continue,
                Err(error) => error,
            };
            self.activate_parameter_expansion(error.span)?;
            if self.parameter_expansion_budget.is_exhausted() {
                return Err(ParseError {
                    message: String::from(
                        "CUDA barrier uniformity analysis resource limit exceeded",
                    ),
                    span: error.span,
                });
            }
            let function = &self.module.entry_points[index].function;
            let mut proof = UniformLoops::new(
                &self.module,
                function,
                &mut self.parameter_expansion_budget,
                error.span,
            )?;
            proof.analyze()?;
            proof.check(&function.body, false, false, &mut 0)?;
        }
        Ok(())
    }
}

struct LoopUniformity<'a> {
    body: &'a crate::Block,
    continuing: &'a crate::Block,
    break_if: Option<Handle<Expression>>,
    uniform: bool,
}

struct UniformLoops<'a> {
    module: &'a Module,
    function: &'a Function,
    budget: &'a mut parameter_expansion::ExpansionBudget,
    span: Span,
    locals: Vec<bool>,
    values: Vec<bool>,
    loops: Vec<LoopUniformity<'a>>,
    changed: bool,
}

impl<'a> UniformLoops<'a> {
    fn new(
        module: &'a Module,
        function: &'a Function,
        budget: &'a mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<Self, ParseError> {
        budget.charge_slice::<bool>(function.local_variables.len(), span)?;
        budget.charge_work(function.local_variables.len(), span)?;
        // All supported backends zero-initialize scalar locals.
        let locals = function
            .local_variables
            .iter()
            .map(|(_, local)| matches!(module.types[local.ty].inner, TypeInner::Scalar(_)))
            .collect();
        budget.charge_slice::<bool>(function.expressions.len(), span)?;
        budget.charge_work(function.expressions.len(), span)?;
        let values = alloc::vec![false; function.expressions.len()];
        let mut proof = Self {
            module,
            function,
            budget,
            span,
            locals,
            values,
            loops: Vec::new(),
            changed: false,
        };
        proof.inventory(&function.body, 1)?;
        Ok(proof)
    }

    fn inventory(&mut self, block: &'a crate::Block, depth: u32) -> Result<(), ParseError> {
        if depth > 127 {
            return Err(ParseError {
                message: String::from("CUDA barrier uniformity analysis nesting limit exceeded"),
                span: self.span,
            });
        }
        for statement in block {
            self.budget.charge_work(1, self.span)?;
            match *statement {
                Statement::Block(ref body) => self.inventory(body, depth + 1)?,
                Statement::If {
                    ref accept,
                    ref reject,
                    ..
                } => {
                    self.inventory(accept, depth + 1)?;
                    self.inventory(reject, depth + 1)?;
                }
                Statement::Switch { ref cases, .. } => {
                    for case in cases {
                        self.budget.charge_work(1, self.span)?;
                        self.inventory(&case.body, depth + 3)?;
                    }
                }
                Statement::Loop {
                    ref body,
                    ref continuing,
                    break_if,
                } => {
                    self.budget
                        .charge_slice::<LoopUniformity<'_>>(1, self.span)?;
                    self.loops.push(LoopUniformity {
                        body,
                        continuing,
                        break_if,
                        uniform: true,
                    });
                    self.inventory(body, depth + 1)?;
                    self.inventory(continuing, depth + 2)?;
                }
                _ => {}
            }
        }
        Ok(())
    }

    fn taint(&mut self, local: Handle<LocalVariable>) {
        if self.locals[local.index()] {
            self.locals[local.index()] = false;
            self.changed = true;
        }
    }

    fn value(&self, handle: Handle<Expression>) -> bool {
        self.values[handle.index()]
    }

    fn read(&mut self, handle: Handle<Expression>) -> bool {
        if let Expression::LocalVariable(local) = self.function.expressions[handle] {
            self.taint(local);
        }
        self.value(handle)
    }

    fn expressions(&mut self) -> Result<(), ParseError> {
        let function = self.function;
        for (handle, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            let uniform = match *expression {
                Expression::Literal(_)
                | Expression::Constant(_)
                | Expression::Override(_)
                | Expression::ZeroValue(_) => true,
                Expression::FunctionArgument(index) => matches!(
                    self.function.arguments[index as usize].binding,
                    Some(Binding::BuiltIn(
                        BuiltIn::WorkGroupId | BuiltIn::WorkGroupSize | BuiltIn::NumWorkGroups
                    ))
                ),
                Expression::GlobalVariable(global) => matches!(
                    self.module.global_variables[global].space,
                    AddressSpace::Uniform | AddressSpace::Immediate
                ),
                Expression::LocalVariable(_) => false,
                Expression::Load { pointer } => match self.function.expressions[pointer] {
                    Expression::LocalVariable(local) => self.locals[local.index()],
                    _ => self.value(pointer),
                },
                Expression::Access { base, index } => self.read(base) & self.read(index),
                Expression::AccessIndex { base, .. } => self.read(base),
                Expression::Unary { expr, .. }
                | Expression::As { expr, .. }
                | Expression::Relational { argument: expr, .. }
                | Expression::Splat { value: expr, .. }
                | Expression::Swizzle { vector: expr, .. } => self.read(expr),
                Expression::Binary { left, right, .. } => self.read(left) & self.read(right),
                Expression::Select {
                    condition,
                    accept,
                    reject,
                } => self.read(condition) & self.read(accept) & self.read(reject),
                Expression::Compose { ref components, .. } => {
                    self.budget.charge_work(components.len(), self.span)?;
                    let mut uniform = true;
                    for &component in components {
                        uniform &= self.read(component);
                    }
                    uniform
                }
                Expression::Math {
                    arg,
                    arg1,
                    arg2,
                    arg3,
                    ..
                } => {
                    let mut uniform = self.read(arg);
                    for argument in [arg1, arg2, arg3].into_iter().flatten() {
                        uniform &= self.read(argument);
                    }
                    uniform
                }
                Expression::CallResult(_) | Expression::AtomicResult { .. } => false,
                _ => return Err(barrier_error(self.span)),
            };
            self.values[handle.index()] = uniform;
        }
        for (handle, local) in function.local_variables.iter() {
            self.budget.charge_work(1, self.span)?;
            if local.init.is_some_and(|init| !self.value(init)) {
                self.taint(handle);
            }
        }
        Ok(())
    }

    fn exits_uniform(
        &mut self,
        block: &crate::Block,
        uniform: bool,
        nested_breakable: u32,
        nested_loops: u32,
    ) -> Result<bool, ParseError> {
        let mut result = true;
        for statement in block {
            self.budget.charge_work(1, self.span)?;
            match *statement {
                Statement::Block(ref body) => {
                    result &= self.exits_uniform(body, uniform, nested_breakable, nested_loops)?;
                }
                Statement::If {
                    condition,
                    ref accept,
                    ref reject,
                } => {
                    let branch_uniform = uniform && self.value(condition);
                    result &=
                        self.exits_uniform(accept, branch_uniform, nested_breakable, nested_loops)?;
                    result &=
                        self.exits_uniform(reject, branch_uniform, nested_breakable, nested_loops)?;
                }
                Statement::Switch {
                    selector,
                    ref cases,
                } => {
                    let branch_uniform = uniform && self.value(selector);
                    for case in cases {
                        self.budget.charge_work(1, self.span)?;
                        result &= self.exits_uniform(
                            &case.body,
                            branch_uniform,
                            nested_breakable + 1,
                            nested_loops,
                        )?;
                    }
                }
                Statement::Loop {
                    ref body,
                    ref continuing,
                    ..
                } => {
                    result &=
                        self.exits_uniform(body, uniform, nested_breakable + 1, nested_loops + 1)?;
                    result &= self.exits_uniform(
                        continuing,
                        uniform,
                        nested_breakable + 1,
                        nested_loops + 1,
                    )?;
                }
                Statement::Break if nested_breakable == 0 => result &= uniform,
                Statement::Continue if nested_loops == 0 => result &= uniform,
                Statement::Return { .. } => result = false,
                _ => {}
            }
        }
        Ok(result)
    }

    fn stores(
        &mut self,
        block: &crate::Block,
        uniform: bool,
        mut returned: bool,
        loop_index: &mut usize,
    ) -> Result<bool, ParseError> {
        for statement in block {
            self.budget.charge_work(1, self.span)?;
            match *statement {
                Statement::Block(ref body) => {
                    returned = self.stores(body, uniform, returned, loop_index)?
                }
                Statement::If {
                    condition,
                    ref accept,
                    ref reject,
                } => {
                    let branch_uniform = uniform && self.value(condition);
                    let accept_returned =
                        self.stores(accept, branch_uniform, returned, loop_index)?;
                    let reject_returned =
                        self.stores(reject, branch_uniform, returned, loop_index)?;
                    returned |= accept_returned || reject_returned;
                }
                Statement::Switch {
                    selector,
                    ref cases,
                } => {
                    let mut branch_uniform = uniform && self.value(selector);
                    for case in cases {
                        self.budget.charge_work(1, self.span)?;
                        branch_uniform &= self.exits_uniform(&case.body, true, 0, 0)?;
                    }
                    for case in cases {
                        self.budget.charge_work(1, self.span)?;
                        returned |=
                            self.stores(&case.body, branch_uniform, returned, loop_index)?;
                    }
                }
                Statement::Loop {
                    ref body,
                    ref continuing,
                    ..
                } => {
                    let loop_uniform = uniform && self.loops[*loop_index].uniform;
                    *loop_index += 1;
                    returned |= self.stores(body, loop_uniform, returned, loop_index)?;
                    returned |= self.stores(continuing, loop_uniform, returned, loop_index)?;
                }
                Statement::Store { pointer, value } => {
                    let value_uniform = self.read(value);
                    match self.function.expressions[pointer] {
                        Expression::LocalVariable(local) => {
                            if !uniform || returned || !value_uniform {
                                self.taint(local);
                            }
                        }
                        _ => {
                            self.read(pointer);
                        }
                    }
                }
                Statement::Call { ref arguments, .. } => {
                    self.budget.charge_work(arguments.len(), self.span)?;
                    for &argument in arguments {
                        self.read(argument);
                    }
                }
                Statement::Atomic {
                    pointer,
                    fun,
                    value,
                    ..
                } => {
                    self.read(pointer);
                    self.read(value);
                    if let crate::AtomicFunction::Exchange {
                        compare: Some(compare),
                    } = fun
                    {
                        self.read(compare);
                    }
                }
                Statement::Return { .. } => returned = true,
                Statement::Emit(_)
                | Statement::Break
                | Statement::Continue
                | Statement::ControlBarrier(_)
                | Statement::MemoryBarrier(_) => {}
                _ => return Err(barrier_error(self.span)),
            }
        }
        Ok(returned)
    }

    fn analyze(&mut self) -> Result<(), ParseError> {
        loop {
            self.changed = false;
            self.expressions()?;
            for index in 0..self.loops.len() {
                self.budget.charge_work(1, self.span)?;
                let body = self.loops[index].body;
                let continuing = self.loops[index].continuing;
                let mut uniform = self.exits_uniform(body, true, 0, 0)?;
                uniform &= self.exits_uniform(continuing, true, 0, 0)?;
                uniform &= self.loops[index]
                    .break_if
                    .is_none_or(|condition| self.value(condition));
                if self.loops[index].uniform && !uniform {
                    self.loops[index].uniform = false;
                    self.changed = true;
                }
            }
            let function = self.function;
            self.stores(&function.body, true, false, &mut 0)?;
            if !self.changed {
                return Ok(());
            }
        }
    }

    fn check(
        &mut self,
        block: &crate::Block,
        conditional: bool,
        mut returned: bool,
        loop_index: &mut usize,
    ) -> Result<bool, ParseError> {
        for (statement, &span) in block.span_iter() {
            self.budget.charge_work(1, span)?;
            match *statement {
                Statement::ControlBarrier(_) if conditional || returned => {
                    return Err(barrier_error(span))
                }
                Statement::Block(ref body) => {
                    returned = self.check(body, conditional, returned, loop_index)?
                }
                Statement::If {
                    ref accept,
                    ref reject,
                    ..
                } => {
                    let accept_returned = self.check(accept, true, returned, loop_index)?;
                    let reject_returned = self.check(reject, true, returned, loop_index)?;
                    returned |= accept_returned || reject_returned;
                }
                Statement::Switch { ref cases, .. } => {
                    for case in cases {
                        self.budget.charge_work(1, self.span)?;
                        returned |= self.check(&case.body, true, returned, loop_index)?;
                    }
                }
                Statement::Loop {
                    ref body,
                    ref continuing,
                    ..
                } => {
                    let conditional = conditional || !self.loops[*loop_index].uniform;
                    *loop_index += 1;
                    returned |= self.check(body, conditional, returned, loop_index)?;
                    returned |= self.check(continuing, conditional, returned, loop_index)?;
                }
                Statement::Return { .. } => returned = true,
                _ => {}
            }
        }
        Ok(returned)
    }
}

fn barrier_error(span: Span) -> ParseError {
    ParseError {
        message: String::from("CUDA barriers require straight-line control flow or a proved uniform loop with no prior possible return"),
        span,
    }
}

// Naga's uniformity analysis does not yet validate control barriers.
pub(super) fn check_control_flow(
    block: &crate::Block,
    conditional: bool,
    mut may_have_returned: bool,
) -> Result<bool, ParseError> {
    for (statement, &span) in block.span_iter() {
        match *statement {
            Statement::ControlBarrier(_) if conditional || may_have_returned => {
                return Err(ParseError {
                    message: String::from(
                        "CUDA barriers require straight-line control flow with no prior possible return",
                    ),
                    span,
                });
            }
            Statement::Block(ref body) => {
                may_have_returned = check_control_flow(body, conditional, may_have_returned)?;
            }
            Statement::If {
                ref accept,
                ref reject,
                ..
            } => {
                let accept_returned = check_control_flow(accept, true, may_have_returned)?;
                let reject_returned = check_control_flow(reject, true, may_have_returned)?;
                may_have_returned |= accept_returned || reject_returned;
            }
            Statement::Loop {
                ref body,
                ref continuing,
                ..
            } => {
                may_have_returned |= check_control_flow(body, true, may_have_returned)?;
                may_have_returned |= check_control_flow(continuing, true, may_have_returned)?;
            }
            Statement::Switch { ref cases, .. } => {
                for case in cases {
                    may_have_returned |= check_control_flow(&case.body, true, may_have_returned)?;
                }
            }
            Statement::Return { .. } => may_have_returned = true,
            _ => {}
        }
    }
    Ok(may_have_returned)
}
