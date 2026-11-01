use super::parameter_expansion::ExpansionBudget;
use super::*;

struct Candidate {
    initializer: Option<Handle<Expression>>,
    constant_index: Option<u32>,
    copy_source: Option<Handle<LocalVariable>>,
    index_only: bool,
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
    module: &'a Module,
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
            local.init.is_none()
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
                constant_index: None,
                copy_source: None,
                index_only: true,
                store_position: usize::MAX,
                first_load: usize::MAX,
                stores: 0,
                eligible: local.init.is_none()
                    && matches!(parser.module.types[local.ty].inner, TypeInner::Scalar(_)),
            })
            .collect();
        let mut analysis = Analysis {
            module: &parser.module,
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
        self.operand_use(owner, operand, allow_local, false)
    }

    fn index_operand(
        &mut self,
        owner: Handle<Expression>,
        operand: Handle<Expression>,
    ) -> Result<bool, ParseError> {
        self.operand_use(Some(owner), operand, false, true)
    }

    fn operand_use(
        &mut self,
        owner: Option<Handle<Expression>>,
        operand: Handle<Expression>,
        allow_local: bool,
        is_index: bool,
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
        if !is_index {
            self.non_index_use(operand);
        }
        Ok(true)
    }

    fn non_index_use(&mut self, operand: Handle<Expression>) {
        if let Expression::Load { pointer } = self.function.expressions[operand] {
            if let Expression::LocalVariable(local) = self.function.expressions[pointer] {
                self.candidates[local.index()].index_only = false;
            }
        }
    }

    fn copied_index_source(
        &self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        is_root: bool,
    ) -> Option<Handle<LocalVariable>> {
        if !is_root {
            return None;
        }
        let function = self.function;
        let Expression::LocalVariable(destination) = function.expressions[pointer] else {
            return None;
        };
        let local = &function.local_variables[destination];
        if local.name.is_some()
            || self.module.types[local.ty].inner != TypeInner::Scalar(Scalar::U32)
            || self.candidates[destination.index()].stores != 0
        {
            return None;
        }
        let Expression::Load { pointer } = function.expressions[value] else {
            return None;
        };
        let Expression::LocalVariable(source) = function.expressions[pointer] else {
            return None;
        };
        (self.module.types[function.local_variables[source].ty].inner
            == TypeInner::Scalar(Scalar::U32))
        .then_some(source)
    }

    fn expressions(&mut self) -> Result<bool, ParseError> {
        let function = self.function;
        for (handle, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            if let Expression::Access { base, index } = *expression {
                if !self.operand(Some(handle), base, false)?
                    || !self.index_operand(handle, index)?
                {
                    return Ok(false);
                }
                continue;
            }
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
                Expression::Binary { left, right, .. } => {
                    operand(left, false)? && operand(right, false)?
                }
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
                            || !self.operand_use(None, value, false, true)?
                        {
                            return Ok(false);
                        }
                        let copy_source = self.copied_index_source(pointer, value, is_root);
                        if copy_source.is_none() {
                            self.non_index_use(value);
                        }
                        if let Expression::LocalVariable(local) = function.expressions[pointer] {
                            let constant_index = if function.local_variables[local].name.is_none()
                                && self.module.types[function.local_variables[local].ty].inner
                                    == TypeInner::Scalar(Scalar::U32)
                            {
                                self.constant_index(value)?
                            } else {
                                None
                            };
                            let candidate = &mut self.candidates[local.index()];
                            candidate.stores = candidate.stores.saturating_add(1);
                            if is_root && candidate.stores == 1 {
                                candidate.initializer = Some(value);
                                candidate.constant_index = constant_index;
                                candidate.copy_source = copy_source;
                                candidate.store_position = position;
                            } else {
                                candidate.eligible = false;
                            }
                            if function.local_variables[local].name.is_none()
                                && !matches!(
                                    function.expressions[value],
                                    Expression::Load { .. }
                                        | Expression::FunctionArgument(_)
                                        | Expression::CallResult(_)
                                        | Expression::AtomicResult { .. }
                                )
                                && constant_index.is_none()
                            {
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
                        fun,
                        value,
                        result,
                    } => {
                        if !self.operand(None, pointer, false)?
                            || !self.operand(None, value, false)?
                        {
                            return Ok(false);
                        }
                        if let crate::AtomicFunction::Exchange {
                            compare: Some(compare),
                        } = fun
                        {
                            if !self.operand(None, compare, false)? {
                                return Ok(false);
                            }
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

    fn constant_index(
        &mut self,
        mut handle: Handle<Expression>,
    ) -> Result<Option<u32>, ParseError> {
        if !matches!(
            self.function.expressions[handle],
            Expression::As {
                kind: ScalarKind::Uint,
                convert: Some(4),
                ..
            }
        ) {
            return Ok(None);
        }
        let mut has_signed_cast = false;
        loop {
            self.budget.charge_work(1, self.span)?;
            let value = match self.function.expressions[handle] {
                Expression::As {
                    expr,
                    kind: ScalarKind::Sint,
                    convert: Some(4),
                } => {
                    has_signed_cast = true;
                    handle = expr;
                    continue;
                }
                Expression::As {
                    expr,
                    kind: ScalarKind::Uint,
                    convert: Some(4),
                } => {
                    handle = expr;
                    continue;
                }
                Expression::Literal(Literal::I32(value)) if value >= 0 => value as u32,
                Expression::Literal(Literal::U32(value)) => value,
                _ => return Ok(None),
            };
            return Ok((!has_signed_cast || value <= i32::MAX as u32).then_some(value));
        }
    }

    fn constant_index_origins(&mut self) -> Result<Vec<Option<Handle<LocalVariable>>>, ParseError> {
        self.budget
            .charge_slice::<Handle<LocalVariable>>(self.candidates.len(), self.span)?;
        self.budget.charge_work(self.candidates.len(), self.span)?;
        let mut pending = Vec::with_capacity(self.candidates.len());
        for candidate in &self.candidates {
            if candidate.initializer.is_none() || !candidate.index_only {
                if let Some(source) = candidate.copy_source {
                    pending.push(source);
                }
            }
        }
        while let Some(local) = pending.pop() {
            self.budget.charge_work(1, self.span)?;
            let candidate = &mut self.candidates[local.index()];
            if candidate.index_only {
                candidate.index_only = false;
                if let Some(source) = candidate.copy_source {
                    pending.push(source);
                }
            }
        }
        self.budget.charge_work(self.candidates.len(), self.span)?;
        for candidate in &mut self.candidates {
            if candidate.constant_index.is_some() && !candidate.index_only {
                candidate.initializer = None;
            }
        }
        self.budget
            .charge_slice::<Option<Handle<LocalVariable>>>(self.candidates.len(), self.span)?;
        self.budget.charge_work(self.candidates.len(), self.span)?;
        let mut origins = alloc::vec![None; self.candidates.len()];
        for statement in self.function.body.iter() {
            self.budget.charge_work(1, self.span)?;
            let Statement::Store { pointer, value } = *statement else {
                continue;
            };
            let Expression::LocalVariable(local) = self.function.expressions[pointer] else {
                continue;
            };
            let candidate = &self.candidates[local.index()];
            if candidate.initializer == Some(value) {
                origins[local.index()] = if candidate.constant_index.is_some() {
                    Some(local)
                } else {
                    candidate
                        .copy_source
                        .and_then(|source| origins[source.index()])
                };
            }
        }
        Ok(origins)
    }

    fn constant_index_bounds(
        &mut self,
        origins: &[Option<Handle<LocalVariable>>],
    ) -> Result<(), ParseError> {
        let function = self.function;
        self.budget
            .charge_slice::<TypeResolution>(function.expressions.len(), self.span)?;
        self.budget
            .charge_work(function.expressions.len(), self.span)?;
        let mut types = crate::front::Typifier::new();
        let (first, _) = function.expressions.iter().next().unwrap();
        if types
            .grow(
                first,
                &function.expressions,
                &crate::proc::ResolveContext::with_locals(
                    self.module,
                    &function.local_variables,
                    &function.arguments,
                ),
            )
            .is_err()
        {
            self.budget.charge_work(self.candidates.len(), self.span)?;
            for candidate in &mut self.candidates {
                if candidate.constant_index.is_some() {
                    candidate.initializer = None;
                }
            }
            return Ok(());
        }
        for (_, expression) in function.expressions.iter() {
            self.budget.charge_work(1, self.span)?;
            let Expression::Access { base, index } = *expression else {
                continue;
            };
            let Expression::Load { pointer } = function.expressions[index] else {
                continue;
            };
            let Expression::LocalVariable(local) = function.expressions[pointer] else {
                continue;
            };
            let Some(origin) = origins[local.index()] else {
                continue;
            };
            let candidate = &mut self.candidates[origin.index()];
            let Some(value) = candidate.constant_index else {
                continue;
            };
            if candidate.initializer.is_none() {
                continue;
            }
            let in_bounds = match types[base]
                .inner_with(&self.module.types)
                .indexable_length_pending(self.module)
            {
                Ok(crate::proc::IndexableLength::Known(length)) => value < length,
                Ok(crate::proc::IndexableLength::Dynamic) => true,
                Err(_) => false,
            };
            if !in_bounds {
                candidate.initializer = None;
            }
        }
        Ok(())
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
        let mut check_constant_indices = false;
        for candidate in &mut self.candidates {
            self.budget.charge_work(1, self.span)?;
            if !candidate.eligible
                || candidate.stores != 1
                || candidate.first_load <= candidate.store_position
            {
                candidate.initializer = None;
            }
            has_promotions |= candidate.initializer.is_some();
            check_constant_indices |=
                candidate.initializer.is_some() && candidate.constant_index.is_some();
        }
        if check_constant_indices {
            let origins = self.constant_index_origins()?;
            self.budget.charge_work(origins.len(), self.span)?;
            if origins.iter().any(Option::is_some) {
                self.constant_index_bounds(&origins)?;
            }
            self.budget.charge_work(self.candidates.len(), self.span)?;
            has_promotions = self
                .candidates
                .iter()
                .any(|candidate| candidate.initializer.is_some());
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
