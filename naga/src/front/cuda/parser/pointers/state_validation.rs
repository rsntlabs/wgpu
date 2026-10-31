use super::validation::{captured_pointer, pointer_state_error};
use super::*;

impl Parser<'_> {
    pub(super) fn validate_pointer_cells(
        &mut self,
        state: &FunctionParameterState,
        function: &Function,
        span: Span,
    ) -> Result<(), ParseError> {
        for (&local, cell) in &state.pointers.cells {
            self.parameter_expansion_budget.charge_work(1, span)?;
            self.module
                .types
                .check_contains_handle(cell.pointee)
                .map_err(|_| pointer_state_error(span))?;
            captured_pointer(function, cell.expression, &self.module, span)?;
            if function.expressions[cell.expression] != Expression::LocalVariable(local)
                || function.local_variables[local].init.is_some()
                || state.pointers.validation_addresses.contains_key(&local)
            {
                return Err(pointer_state_error(span));
            }
        }
        Ok(())
    }

    pub(super) fn validate_pointer_objects(
        &mut self,
        state: &FunctionParameterState,
        function: &Function,
        binding: Handle<BoundReference>,
        span: Span,
        mut visit: impl FnMut(&PointerCell) -> Result<(), ParseError>,
    ) -> Result<(), ParseError> {
        let reference = state
            .bound_references
            .try_get(binding)
            .map_err(|_| pointer_state_error(span))?;
        if reference.targets.is_empty()
            || (reference.selector.is_none() && reference.targets.len() != 1)
        {
            return Err(pointer_state_error(span));
        }
        let mut qualification = None;
        for target in &reference.targets {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let address = state
                .bound_addresses
                .try_get(target.address)
                .map_err(|_| pointer_state_error(span))?;
            let Expression::LocalVariable(local) = *function
                .expressions
                .try_get(address.root)
                .map_err(|_| pointer_state_error(span))?
            else {
                return Err(pointer_state_error(span));
            };
            let cell = state
                .pointers
                .cells
                .get(&local)
                .ok_or_else(|| pointer_state_error(span))?;
            if !address.projections.is_empty()
                || !matches!(cell.kind, PointerCellKind::Object { .. })
            {
                return Err(pointer_state_error(span));
            }
            let current = (cell.pointee, cell.is_const);
            if qualification.is_some_and(|expected| expected != current) {
                return Err(pointer_state_error(span));
            }
            qualification = Some(current);
            visit(cell)?;
        }
        Ok(())
    }

    pub(super) fn validate_pointer_rvalue(
        &mut self,
        state: &PointerState,
        expression: Handle<PointerExpression>,
        is_const: bool,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_slice::<Handle<PointerExpression>>(1, span)?;
        let mut pending = alloc::vec![expression];
        while let Some(handle) = pending.pop() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let expression = state
                .expressions
                .try_get(handle)
                .map_err(|_| pointer_state_error(span))?;
            match expression.kind {
                PointerExpressionKind::Object(_) => return Err(pointer_state_error(span)),
                PointerExpressionKind::Snapshot(local) => {
                    let cell = state
                        .cells
                        .get(&local)
                        .ok_or_else(|| pointer_state_error(span))?;
                    if cell.kind != PointerCellKind::Snapshot || (cell.is_const && !is_const) {
                        return Err(pointer_state_error(span));
                    }
                }
                PointerExpressionKind::Offset { base, .. } => {
                    self.parameter_expansion_budget
                        .charge_slice::<Handle<PointerExpression>>(1, span)?;
                    pending.push(base);
                }
                PointerExpressionKind::Select { accept, reject, .. } => {
                    self.parameter_expansion_budget
                        .charge_slice::<Handle<PointerExpression>>(2, span)?;
                    pending.extend([accept, reject]);
                }
                _ => {}
            }
        }
        Ok(())
    }

    pub(super) fn validate_pointer_operations(
        &mut self,
        state: &FunctionParameterState,
        function: &Function,
        span: Span,
    ) -> Result<(), ParseError> {
        self.validate_pointer_markers(state, function, span)?;
        let mut amounts = crate::front::Typifier::new();
        if let Some(amount) = state.pointers.operations.values().find_map(|operation| {
            if let PointerOperation::Update { amount, .. } = *operation {
                Some(amount)
            } else {
                None
            }
        }) {
            function
                .expressions
                .check_contains_handle(amount)
                .map_err(|_| pointer_state_error(span))?;
            self.parameter_expansion_budget
                .charge_slice::<TypeResolution>(function.expressions.len(), span)?;
            self.parameter_expansion_budget
                .charge_work(function.expressions.len(), span)?;
            amounts
                .grow(
                    amount,
                    &function.expressions,
                    &crate::proc::ResolveContext::with_locals(
                        &self.module,
                        &function.local_variables,
                        &function.arguments,
                    ),
                )
                .map_err(|_| pointer_state_error(span))?;
        }
        for (&marker, operation) in &state.pointers.operations {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if !state.pointers.operation_markers.contains(&marker) {
                return Err(pointer_state_error(span));
            }
            match *operation {
                PointerOperation::Initialize {
                    destination,
                    ref value,
                } => {
                    let cell = state
                        .pointers
                        .cells
                        .get(&destination)
                        .ok_or_else(|| pointer_state_error(span))?;
                    if !matches!(cell.kind, PointerCellKind::Object { .. }) {
                        return Err(pointer_state_error(span));
                    }
                    self.validate_source_pointer_value(&state.pointers, function, value)?;
                    if cell.pointee != state.pointers.expressions[value.expression].pointee
                        || (value.is_const && !cell.is_const)
                    {
                        return Err(pointer_state_error(span));
                    }
                }
                PointerOperation::Assign {
                    destination,
                    ref value,
                } => {
                    self.validate_source_pointer_value(&state.pointers, function, value)?;
                    let pointee = state.pointers.expressions[value.expression].pointee;
                    self.validate_pointer_objects(state, function, destination, span, |cell| {
                        if cell.kind != (PointerCellKind::Object { writable: true })
                            || cell.pointee != pointee
                            || (value.is_const && !cell.is_const)
                        {
                            return Err(pointer_state_error(span));
                        }
                        Ok(())
                    })?;
                }
                PointerOperation::Capture {
                    destination,
                    source,
                } => {
                    let captured = state
                        .pointers
                        .cells
                        .get(&destination)
                        .ok_or_else(|| pointer_state_error(span))?;
                    if captured.kind != PointerCellKind::Snapshot {
                        return Err(pointer_state_error(span));
                    }
                    self.validate_pointer_objects(state, function, source, span, |cell| {
                        if cell.pointee != captured.pointee || (cell.is_const && !captured.is_const)
                        {
                            return Err(pointer_state_error(span));
                        }
                        Ok(())
                    })?;
                }
                PointerOperation::Update {
                    destination,
                    amount,
                    ..
                } => {
                    function
                        .expressions
                        .check_contains_handle(amount)
                        .map_err(|_| pointer_state_error(span))?;
                    if amounts.get(amount, &self.module.types) != &TypeInner::Scalar(Scalar::U32) {
                        return Err(pointer_state_error(span));
                    }
                    self.validate_pointer_objects(state, function, destination, span, |cell| {
                        if cell.kind == (PointerCellKind::Object { writable: true }) {
                            Ok(())
                        } else {
                            Err(pointer_state_error(span))
                        }
                    })?;
                }
            }
        }
        Ok(())
    }

    fn validate_pointer_markers(
        &mut self,
        state: &FunctionParameterState,
        function: &Function,
        span: Span,
    ) -> Result<(), ParseError> {
        for &marker in &state.pointers.operation_markers {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if state.deferred_calls.contains_key(&marker) {
                return Err(pointer_state_error(span));
            }
            let Expression::Binary {
                op: BinaryOperator::Add,
                left,
                right,
            } = *function
                .expressions
                .try_get(marker)
                .map_err(|_| pointer_state_error(span))?
            else {
                return Err(pointer_state_error(span));
            };
            for operand in [left, right] {
                if function.expressions.try_get(operand).ok()
                    != Some(&Expression::Literal(Literal::U32(0)))
                {
                    return Err(pointer_state_error(span));
                }
            }
        }
        self.parameter_expansion_budget
            .charge_slice::<(&crate::Block, Option<Handle<Expression>>)>(1, span)?;
        let mut pending = alloc::vec![(&function.body, None)];
        while let Some((block, enclosing_marker)) = pending.pop() {
            for statement in block {
                self.parameter_expansion_budget.charge_work(1, span)?;
                let mut child = |body, marker| -> Result<(), ParseError> {
                    self.parameter_expansion_budget
                        .charge_slice::<(&crate::Block, Option<Handle<Expression>>)>(1, span)?;
                    pending.push((body, marker));
                    Ok(())
                };
                match *statement {
                    Statement::Emit(ref range) => {
                        for marker in range.clone() {
                            self.parameter_expansion_budget.charge_work(1, span)?;
                            if state.pointers.operation_markers.contains(&marker)
                                && (enclosing_marker != Some(marker)
                                    || !state.pointers.operations.contains_key(&marker))
                            {
                                return Err(pointer_state_error(span));
                            }
                        }
                    }
                    Statement::Block(ref body) => {
                        let marker = parameter_expansion::deferred_call_marker(body)
                            .filter(|marker| state.pointers.operation_markers.contains(marker));
                        child(body, marker)?;
                    }
                    Statement::If {
                        ref accept,
                        ref reject,
                        ..
                    } => {
                        child(accept, None)?;
                        child(reject, None)?;
                    }
                    Statement::Switch { ref cases, .. } => {
                        for case in cases {
                            child(&case.body, None)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        ..
                    } => {
                        child(body, None)?;
                        child(continuing, None)?;
                    }
                    _ => {}
                }
            }
        }
        Ok(())
    }
}
