use super::parameter_expansion::ExpansionBudget;
use super::*;

struct Candidate {
    initializer: Option<Handle<Expression>>,
    store_position: usize,
    first_load: usize,
    stores: u8,
    eligible: bool,
}

#[derive(Default)]
pub(super) struct ScalarPromotions {
    candidates: Vec<Candidate>,
    has_promotions: bool,
}

struct Analysis<'a> {
    function: &'a Function,
    budget: &'a mut ExpansionBudget,
    span: Span,
    candidates: Vec<Candidate>,
    emitted_loads: Vec<bool>,
}

impl ScalarPromotions {
    pub(super) fn analyze(
        parser: &mut Parser<'_>,
        function: &Function,
        span: Span,
    ) -> Result<Self, ParseError> {
        let budget = &mut parser.parameter_expansion_budget;
        budget.charge_work(function.local_variables.len(), span)?;
        if !function.local_variables.iter().any(|(_, local)| {
            local.name.is_some()
                && local.init.is_none()
                && matches!(parser.module.types[local.ty].inner, TypeInner::Scalar(_))
        }) {
            return Ok(Self::default());
        }
        budget.charge_slice::<Candidate>(function.local_variables.len(), span)?;
        budget.charge_work(function.local_variables.len(), span)?;
        let candidates = function
            .local_variables
            .iter()
            .map(|(_, local)| Candidate {
                initializer: None,
                store_position: usize::MAX,
                first_load: usize::MAX,
                stores: 0,
                eligible: local.name.is_some()
                    && local.init.is_none()
                    && matches!(parser.module.types[local.ty].inner, TypeInner::Scalar(_)),
            })
            .collect();
        let mut analysis = Analysis {
            function,
            budget,
            span,
            candidates,
            emitted_loads: Vec::new(),
        };
        if !analysis.expressions()? {
            return Ok(Self::default());
        }
        analysis
            .budget
            .charge_slice::<bool>(function.expressions.len(), span)?;
        analysis
            .budget
            .charge_work(function.expressions.len(), span)?;
        analysis.emitted_loads = alloc::vec![false; function.expressions.len()];
        if !analysis.statements()? {
            return Ok(Self::default());
        }
        analysis.finish()
    }

    pub(super) fn initializer(&self, local: Handle<LocalVariable>) -> Option<Handle<Expression>> {
        self.candidates.get(local.index())?.initializer
    }

    pub(super) const fn is_empty(&self) -> bool {
        !self.has_promotions
    }
}

impl<'a> Analysis<'a> {
    fn operand(
        &mut self,
        owner: Option<Handle<Expression>>,
        operand: Handle<Expression>,
        allow_local: bool,
    ) -> Result<bool, ParseError> {
        self.budget.charge_work(1, self.span)?;
        if operand.index() >= self.function.expressions.len()
            || owner.is_some_and(|owner| operand.index() >= owner.index())
        {
            return Ok(false);
        }
        if let Expression::LocalVariable(local) = self.function.expressions[operand] {
            let Some(candidate) = self.candidates.get_mut(local.index()) else {
                return Ok(false);
            };
            if !allow_local {
                candidate.eligible = false;
            }
        }
        Ok(true)
    }

    fn expressions(&mut self) -> Result<bool, ParseError> {
        let function = self.function;
        for (handle, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            let mut operand = |value, allow_local| self.operand(Some(handle), value, allow_local);
            let supported = match *expression {
                Expression::Literal(_)
                | Expression::Constant(_)
                | Expression::Override(_)
                | Expression::ZeroValue(_)
                | Expression::FunctionArgument(_)
                | Expression::GlobalVariable(_)
                | Expression::CallResult(_)
                | Expression::AtomicResult { .. } => true,
                Expression::LocalVariable(local) => local.index() < function.local_variables.len(),
                Expression::Load { pointer } => operand(pointer, true)?,
                Expression::Unary { expr, .. }
                | Expression::As { expr, .. }
                | Expression::Splat { value: expr, .. }
                | Expression::Swizzle { vector: expr, .. }
                | Expression::Relational { argument: expr, .. }
                | Expression::AccessIndex { base: expr, .. } => operand(expr, false)?,
                Expression::Binary { left, right, .. }
                | Expression::Access {
                    base: left,
                    index: right,
                } => operand(left, false)? && operand(right, false)?,
                Expression::Select {
                    condition,
                    accept,
                    reject,
                } => {
                    operand(condition, false)? && operand(accept, false)? && operand(reject, false)?
                }
                Expression::Compose { ref components, .. } => {
                    for &component in components {
                        if !operand(component, false)? {
                            return Ok(false);
                        }
                    }
                    true
                }
                Expression::Math {
                    arg,
                    arg1,
                    arg2,
                    arg3,
                    ..
                } => {
                    for argument in [Some(arg), arg1, arg2, arg3].into_iter().flatten() {
                        if !operand(argument, false)? {
                            return Ok(false);
                        }
                    }
                    true
                }
                _ => false,
            };
            if !supported {
                return Ok(false);
            }
        }
        for (_, local) in function.local_variables.iter() {
            self.budget.charge_work(1, self.span)?;
            if let Some(initializer) = local.init {
                if !self.operand(None, initializer, false)? {
                    return Ok(false);
                }
            }
        }
        for &handle in function.named_expressions.keys() {
            if !self.operand(None, handle, false)? {
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn push_block(
        &mut self,
        pending: &mut Vec<(&'a crate::Block, usize, bool)>,
        block: &'a crate::Block,
        root_position: usize,
        is_root: bool,
    ) -> Result<(), ParseError> {
        self.budget
            .charge_slice::<(&crate::Block, usize, bool)>(1, self.span)?;
        pending.push((block, root_position, is_root));
        Ok(())
    }

    fn statements(&mut self) -> Result<bool, ParseError> {
        let function = self.function;
        let mut pending = Vec::new();
        self.push_block(&mut pending, &function.body, 0, true)?;
        while let Some((block, root_position, is_root)) = pending.pop() {
            for (index, statement) in block.iter().enumerate() {
                self.budget.charge_work(1, self.span)?;
                let position = if is_root { index } else { root_position };
                match *statement {
                    Statement::Emit(ref range) => {
                        for handle in range.clone() {
                            self.budget.charge_work(1, self.span)?;
                            if handle.index() >= function.expressions.len() {
                                return Ok(false);
                            }
                            if let Expression::Load { pointer } = function.expressions[handle] {
                                if let Expression::LocalVariable(local) =
                                    function.expressions[pointer]
                                {
                                    let candidate = &mut self.candidates[local.index()];
                                    candidate.first_load = candidate.first_load.min(position);
                                    if self.emitted_loads[handle.index()] {
                                        candidate.eligible = false;
                                    }
                                    self.emitted_loads[handle.index()] = true;
                                }
                            }
                        }
                    }
                    Statement::Store { pointer, value } => {
                        if !self.operand(None, pointer, true)?
                            || !self.operand(None, value, false)?
                        {
                            return Ok(false);
                        }
                        if let Expression::LocalVariable(local) = function.expressions[pointer] {
                            let candidate = &mut self.candidates[local.index()];
                            candidate.stores = candidate.stores.saturating_add(1);
                            if is_root && candidate.stores == 1 {
                                candidate.initializer = Some(value);
                                candidate.store_position = position;
                            } else {
                                candidate.eligible = false;
                            }
                            if function.expressions[value].needs_pre_emit()
                                && !matches!(
                                    function.expressions[value],
                                    Expression::FunctionArgument(_)
                                )
                            {
                                candidate.eligible = false;
                            }
                        }
                    }
                    Statement::Block(ref body) => {
                        self.push_block(&mut pending, body, position, false)?;
                    }
                    Statement::If {
                        condition,
                        ref accept,
                        ref reject,
                    } => {
                        if !self.operand(None, condition, false)? {
                            return Ok(false);
                        }
                        self.push_block(&mut pending, accept, position, false)?;
                        self.push_block(&mut pending, reject, position, false)?;
                    }
                    Statement::Switch {
                        selector,
                        ref cases,
                    } => {
                        if !self.operand(None, selector, false)? {
                            return Ok(false);
                        }
                        for case in cases {
                            self.budget.charge_work(1, self.span)?;
                            self.push_block(&mut pending, &case.body, position, false)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        break_if,
                    } => {
                        if let Some(condition) = break_if {
                            if !self.operand(None, condition, false)? {
                                return Ok(false);
                            }
                        }
                        self.push_block(&mut pending, body, position, false)?;
                        self.push_block(&mut pending, continuing, position, false)?;
                    }
                    Statement::Atomic {
                        pointer,
                        value,
                        result,
                        ..
                    } => {
                        if !self.operand(None, pointer, false)?
                            || !self.operand(None, value, false)?
                        {
                            return Ok(false);
                        }
                        if let Some(result) = result {
                            if !self.operand(None, result, false)? {
                                return Ok(false);
                            }
                        }
                    }
                    Statement::Call {
                        ref arguments,
                        result,
                        ..
                    } => {
                        for &argument in arguments {
                            if !self.operand(None, argument, false)? {
                                return Ok(false);
                            }
                        }
                        if let Some(result) = result {
                            if !self.operand(None, result, false)? {
                                return Ok(false);
                            }
                        }
                    }
                    Statement::Return { value } => {
                        if let Some(value) = value {
                            if !self.operand(None, value, false)? {
                                return Ok(false);
                            }
                        }
                    }
                    Statement::Break
                    | Statement::Continue
                    | Statement::ControlBarrier(_)
                    | Statement::MemoryBarrier(_) => {}
                    _ => return Ok(false),
                }
            }
        }
        Ok(true)
    }

    fn finish(mut self) -> Result<ScalarPromotions, ParseError> {
        let function = self.function;
        for (handle, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            if let Expression::Load { pointer } = *expression {
                if let Expression::LocalVariable(local) = function.expressions[pointer] {
                    let candidate = &mut self.candidates[local.index()];
                    if !self.emitted_loads[handle.index()]
                        || candidate
                            .initializer
                            .is_some_and(|initializer| initializer.index() >= handle.index())
                    {
                        candidate.eligible = false;
                    }
                }
            }
        }
        let mut has_promotions = false;
        for candidate in &mut self.candidates {
            self.budget.charge_work(1, self.span)?;
            if !candidate.eligible
                || candidate.stores != 1
                || candidate.first_load <= candidate.store_position
            {
                candidate.initializer = None;
            }
            has_promotions |= candidate.initializer.is_some();
        }
        if !has_promotions {
            return Ok(ScalarPromotions::default());
        }
        self.budget
            .charge_slice::<u32>(function.expressions.len(), self.span)?;
        let mut depths = Vec::with_capacity(function.expressions.len());
        for (_, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            if let Expression::Compose { ref components, .. } = *expression {
                self.budget.charge_work(components.len(), self.span)?;
            }
            let initializer = match *expression {
                Expression::Load { pointer } => match function.expressions[pointer] {
                    Expression::LocalVariable(local) => self.candidates[local.index()].initializer,
                    _ => None,
                },
                _ => None,
            };
            let depth = initializer.map_or_else(
                || expression_depth(expression, &depths),
                |initializer| depths[initializer.index()],
            );
            if depth > 64 {
                return Ok(ScalarPromotions::default());
            }
            depths.push(depth);
        }
        Ok(ScalarPromotions {
            candidates: self.candidates,
            has_promotions,
        })
    }
}
