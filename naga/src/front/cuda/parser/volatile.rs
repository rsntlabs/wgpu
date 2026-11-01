use super::*;

#[derive(Clone, Copy, Eq, Hash, PartialEq)]
pub(super) struct StoreAccess {
    pointer: Handle<Expression>,
    value: Handle<Expression>,
    range: Option<(usize, usize)>,
}

impl StoreAccess {
    fn new(pointer: Handle<Expression>, value: Handle<Expression>, span: Span) -> Self {
        Self {
            pointer,
            value,
            range: span.to_range().map(|range| (range.start, range.end)),
        }
    }
}

#[derive(Clone, Default)]
pub(super) struct VolatileAccesses {
    pub(super) loads: crate::FastHashSet<Handle<Expression>>,
    stores: crate::FastHashSet<StoreAccess>,
}

impl VolatileAccesses {
    pub(super) fn is_empty(&self) -> bool {
        self.loads.is_empty() && self.stores.is_empty()
    }

    pub(super) fn contains_store(
        &self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> bool {
        self.stores
            .contains(&StoreAccess::new(pointer, value, span))
    }

    pub(super) fn inventory(
        &self,
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<(), ParseError> {
        budget.charge_map_entry::<Handle<Expression>, ()>(self.loads.len(), span)?;
        budget.charge_map_entry::<StoreAccess, ()>(self.stores.len(), span)?;
        budget.charge_work(self.loads.len() + self.stores.len(), span)
    }
}

impl Parser<'_> {
    pub(super) fn note_volatile_parameter_object(
        &mut self,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<(), ParseError> {
        if qualifiers.is_volatile {
            if self.function.kind == FunctionKind::Kernel {
                return Err(ParseError {
                    message: String::from("volatile parameter objects are unsupported"),
                    span,
                });
            }
            self.function.volatile_parameter_object.get_or_insert(span);
        }
        Ok(())
    }

    pub(super) fn require_volatile_scalar(
        &self,
        qualifiers: Qualifiers,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<(), ParseError> {
        if qualifiers.is_volatile
            && !matches!(ty.inner_with(&self.module.types), TypeInner::Scalar(_))
        {
            return Err(ParseError {
                message: String::from("whole volatile class value operations are unsupported"),
                span,
            });
        }
        Ok(())
    }

    pub(super) fn record_volatile_load(
        &mut self,
        load: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        if !self.function.volatile_accesses.loads.contains(&load) {
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Expression>, ()>(1, span)?;
            self.function.volatile_accesses.loads.insert(load);
        }
        Ok(())
    }

    pub(super) fn record_volatile_store(
        &mut self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let access = StoreAccess::new(pointer, value, span);
        if !self.function.volatile_accesses.stores.contains(&access) {
            self.parameter_expansion_budget
                .charge_map_entry::<StoreAccess, ()>(1, span)?;
            self.function.volatile_accesses.stores.insert(access);
        }
        Ok(())
    }

    pub(super) fn check_closed_volatile_accesses(
        &mut self,
        function: &Function,
        state: &FunctionParameterState,
        span: Span,
    ) -> Result<(), ParseError> {
        if state.volatile_accesses.is_empty() {
            return Ok(());
        }
        self.parameter_expansion_budget
            .charge_slice::<&crate::Block>(1, span)?;
        let mut pending = alloc::vec![&function.body];
        while let Some(block) = pending.pop() {
            for (statement, span) in block.span_iter() {
                self.parameter_expansion_budget.charge_work(1, *span)?;
                let mut child = |budget: &mut parameter_expansion::ExpansionBudget,
                                 body|
                 -> Result<(), ParseError> {
                    budget.charge_slice::<&crate::Block>(1, *span)?;
                    pending.push(body);
                    Ok(())
                };
                match *statement {
                    Statement::Emit(ref range) => {
                        for expression in range.clone() {
                            self.parameter_expansion_budget.charge_work(1, *span)?;
                            if state.volatile_accesses.loads.contains(&expression) {
                                let Expression::Load { pointer } = function.expressions[expression]
                                else {
                                    return Err(ParseError {
                                        message: String::from(
                                            "invalid CUDA volatile access metadata",
                                        ),
                                        span: *span,
                                    });
                                };
                                self.request_volatile_root(function, pointer, *span)?;
                            }
                        }
                    }
                    Statement::Store { pointer, value }
                        if state
                            .volatile_accesses
                            .contains_store(pointer, value, *span) =>
                    {
                        self.request_volatile_root(function, pointer, *span)?;
                    }
                    Statement::Block(ref body) => {
                        child(&mut self.parameter_expansion_budget, body)?
                    }
                    Statement::If {
                        ref accept,
                        ref reject,
                        ..
                    } => {
                        child(&mut self.parameter_expansion_budget, accept)?;
                        child(&mut self.parameter_expansion_budget, reject)?;
                    }
                    Statement::Switch { ref cases, .. } => {
                        for case in cases {
                            child(&mut self.parameter_expansion_budget, &case.body)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        ..
                    } => {
                        child(&mut self.parameter_expansion_budget, body)?;
                        child(&mut self.parameter_expansion_budget, continuing)?;
                    }
                    _ => {}
                }
            }
        }
        Ok(())
    }

    fn request_volatile_root(
        &mut self,
        function: &Function,
        mut pointer: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        loop {
            self.parameter_expansion_budget.charge_work(1, span)?;
            match function.expressions[pointer] {
                Expression::Access { base, .. } | Expression::AccessIndex { base, .. }
                    if base.index() < pointer.index() =>
                {
                    pointer = base
                }
                Expression::GlobalVariable(global)
                    if matches!(
                        self.module.global_variables[global].space,
                        AddressSpace::Storage { .. } | AddressSpace::WorkGroup
                    ) =>
                {
                    if !self.volatile_globals.contains_key(&global) {
                        self.parameter_expansion_budget
                            .charge_map_entry::<Handle<GlobalVariable>, Span>(1, span)?;
                        self.volatile_globals.insert(global, span);
                    }
                    return Ok(());
                }
                _ => {
                    return Err(ParseError {
                        message: String::from("volatile accesses require storage or shared memory"),
                        span,
                    })
                }
            }
        }
    }

    pub(super) fn upgrade_volatile_storage(&mut self) -> Result<(), ParseError> {
        if self.volatile_globals.is_empty() {
            return Ok(());
        }
        let span = self.volatile_globals.values().next().copied().unwrap();
        self.parameter_expansion_budget
            .charge_slice::<bool>(self.module.types.len(), span)?;
        let mut atomic = Vec::with_capacity(self.module.types.len());
        for (_, ty) in self.module.types.iter() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            atomic.push(match ty.inner {
                TypeInner::Atomic(_) => true,
                TypeInner::Array { base, .. } => atomic[base.index()],
                TypeInner::Struct { ref members, .. } => {
                    self.parameter_expansion_budget
                        .charge_work(members.len(), span)?;
                    members.iter().any(|member| atomic[member.ty.index()])
                }
                _ => false,
            });
        }
        for (&global, &span) in &self.volatile_globals {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let variable = &mut self.module.global_variables[global];
            if variable.space == AddressSpace::WorkGroup && atomic[variable.ty.index()] {
                return Err(ParseError {
                    message: String::from("volatile shared memory cannot alias atomic storage"),
                    span,
                });
            }
            variable
                .memory_decorations
                .insert(crate::MemoryDecorations::VOLATILE);
        }
        Ok(())
    }
}
