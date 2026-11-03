use super::*;

impl Inventory<'_> {
    fn replace_families(
        &mut self,
        parser: &mut Parser<'_>,
        destination: Handle<LocalVariable>,
        families: &[RuntimeOrigin],
        span: Span,
    ) -> Result<(), ParseError> {
        let values = self.clone_set(parser, families, span)?;
        *self
            .cells
            .get_mut(&destination)
            .ok_or_else(|| runtime_error(span))? = values;
        Ok(())
    }

    fn forget_objects(
        &mut self,
        parser: &mut Parser<'_>,
        original: &FastHashMap<Handle<LocalVariable>, Vec<RuntimeOrigin>>,
        span: Span,
    ) -> Result<(), ParseError> {
        for (&local, values) in original {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            if matches!(
                self.source.pointers.cells[&local].kind,
                PointerCellKind::Object { .. }
            ) {
                self.replace_families(parser, local, values, span)?;
            }
        }
        Ok(())
    }

    fn single_cell(&self, binding: Handle<BoundReference>) -> Option<Handle<LocalVariable>> {
        let reference = self.source.bound_references.try_get(binding).ok()?;
        if reference.selector.is_some() || reference.is_nullable || reference.targets.len() != 1 {
            return None;
        }
        let address = self
            .source
            .bound_addresses
            .try_get(reference.targets[0].address)
            .ok()?;
        if !address.projections.is_empty() {
            return None;
        }
        let Expression::LocalVariable(local) = self.function.expressions[address.root] else {
            return None;
        };
        self.source
            .pointers
            .cells
            .contains_key(&local)
            .then_some(local)
    }

    fn captures_in_block(
        &mut self,
        parser: &mut Parser<'_>,
        body: &crate::Block,
        original: &FastHashMap<Handle<LocalVariable>, Vec<RuntimeOrigin>>,
        depth: u32,
        span: Span,
    ) -> Result<(), ParseError> {
        if depth > 127 {
            return Err(runtime_error(span));
        }
        let source = self.source;
        for (statement, &span) in body.span_iter() {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            match *statement {
                Statement::Block(ref body) => {
                    if let Some(marker) = parameter_expansion::deferred_call_marker(body) {
                        if let Some(operation) = source.pointers.operations.get(&marker) {
                            match *operation {
                                PointerOperation::Initialize {
                                    destination,
                                    ref value,
                                } => {
                                    let families =
                                        self.expression(parser, value.expression, 1, span)?;
                                    self.replace_families(parser, destination, &families, span)?;
                                }
                                PointerOperation::Capture {
                                    destination,
                                    source,
                                } => {
                                    let families = self.binding_families(parser, source, span)?;
                                    self.replace_families(parser, destination, &families, span)?;
                                }
                                PointerOperation::Assign {
                                    destination,
                                    ref value,
                                } => {
                                    if let Some(local) = self.single_cell(destination) {
                                        let families =
                                            self.expression(parser, value.expression, 1, span)?;
                                        self.replace_families(parser, local, &families, span)?;
                                    } else {
                                        self.forget_objects(parser, original, span)?;
                                    }
                                }
                                PointerOperation::Update { .. } | PointerOperation::Test { .. } => {
                                }
                            }
                            continue;
                        }
                        if source.deferred_calls.contains_key(&marker) {
                            self.forget_objects(parser, original, span)?;
                            continue;
                        }
                    }
                    self.captures_in_block(parser, body, original, depth + 1, span)?;
                }
                Statement::If { .. }
                | Statement::Switch { .. }
                | Statement::Loop { .. }
                | Statement::Call { .. } => self.forget_objects(parser, original, span)?,
                _ => {}
            }
        }
        Ok(())
    }

    pub(super) fn refine_captures(
        &mut self,
        parser: &mut Parser<'_>,
        expressions: &mut [Vec<RuntimeOrigin>],
        span: Span,
    ) -> Result<(), ParseError> {
        parser
            .parameter_expansion_budget
            .charge_map_entry::<Handle<LocalVariable>, Vec<RuntimeOrigin>>(
                self.cells.len(),
                span,
            )?;
        let mut original = FastHashMap::default();
        for (&local, values) in &self.cells {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            original.insert(local, self.clone_set(parser, values, span)?);
        }
        let body = &self.function.body;
        self.captures_in_block(parser, body, &original, 1, span)?;
        self.forget_objects(parser, &original, span)?;
        let source = self.source;
        for (handle, _) in source.pointers.expressions.iter() {
            expressions[handle.index()] = self.expression(parser, handle, 1, span)?;
        }
        self.cells = original;
        Ok(())
    }
}
