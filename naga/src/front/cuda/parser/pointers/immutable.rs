use super::super::parameter_expansion::{deferred_call_marker, ExpansionBudget};
use super::*;

#[derive(Clone, Copy, Debug)]
enum Definition {
    Object {
        initializer: Handle<PointerExpression>,
        root_position: usize,
    },
    Snapshot {
        object: Handle<LocalVariable>,
        root_position: usize,
    },
}

#[derive(Clone, Debug, Default)]
pub(in super::super) struct ImmutablePointers {
    definitions: Vec<Option<Definition>>,
}

#[cfg(test)]
mod tests;

struct Analysis<'a> {
    module: &'a Module,
    function: &'a Function,
    source: &'a FunctionParameterState,
    budget: &'a mut ExpansionBudget,
    span: Span,
    definitions: Vec<Option<Definition>>,
}

impl ImmutablePointers {
    pub(in super::super) fn analyze(
        parser: &mut Parser<'_>,
        function: &Function,
        source: &FunctionParameterState,
        span: Span,
    ) -> Result<Self, ParseError> {
        if source.pointers.cells.is_empty()
            || source.pointers.runtime.is_some()
            || source.pointers.immutable.is_some()
            || !source.deferred_calls.is_empty()
        {
            return Ok(Self::default());
        }
        parser
            .parameter_expansion_budget
            .charge_slice::<Option<Definition>>(function.local_variables.len(), span)?;
        parser
            .parameter_expansion_budget
            .charge_work(function.local_variables.len(), span)?;
        let mut analysis = Analysis {
            module: &parser.module,
            function,
            source,
            budget: &mut parser.parameter_expansion_budget,
            span,
            definitions: alloc::vec![None; function.local_variables.len()],
        };
        if !analysis.statements()? || !analysis.complete()? {
            return Ok(Self::default());
        }
        Ok(Self {
            definitions: analysis.definitions,
        })
    }

    pub(in super::super) fn initializer(
        &self,
        local: Handle<LocalVariable>,
    ) -> Option<Handle<PointerExpression>> {
        match *self.definitions.get(local.index())?.as_ref()? {
            Definition::Object { initializer, .. } => Some(initializer),
            Definition::Snapshot { object, .. } => {
                match *self.definitions.get(object.index())?.as_ref()? {
                    Definition::Object { initializer, .. } => Some(initializer),
                    Definition::Snapshot { .. } => None,
                }
            }
        }
    }

    pub(in super::super) const fn is_empty(&self) -> bool {
        self.definitions.is_empty()
    }
}

impl<'a> Analysis<'a> {
    fn single_address(&self, binding: Handle<BoundReference>) -> Option<&BoundAddress> {
        let reference = self.source.bound_references.try_get(binding).ok()?;
        if reference.selector.is_some() || reference.targets.len() != 1 {
            return None;
        }
        let address = self
            .source
            .bound_addresses
            .try_get(reference.targets[0].address)
            .ok()?;
        address.projections.is_empty().then_some(address)
    }

    fn resource_initializer(
        &self,
        value: &PointerValue,
        cell: &PointerCell,
    ) -> Option<Handle<PointerExpression>> {
        if value.category != (PointerValueCategory::Value { position: None })
            || (value.is_const && !cell.is_const)
        {
            return None;
        }
        let expression = self
            .source
            .pointers
            .expressions
            .try_get(value.expression)
            .ok()?;
        if expression.pointee != cell.pointee {
            return None;
        }
        let ty = match value.ty {
            TypeResolution::Handle(handle) => {
                self.module.types.check_contains_handle(handle).ok()?;
                &self.module.types[handle].inner
            }
            TypeResolution::Value(ref inner) => inner,
        };
        if !matches!(*ty, TypeInner::Pointer { base, space: AddressSpace::Function } if base == cell.pointee)
        {
            return None;
        }
        let PointerExpressionKind::Array(binding) = expression.kind else {
            return None;
        };
        let address = self.single_address(binding)?;
        let Expression::GlobalVariable(global) =
            *self.function.expressions.try_get(address.root).ok()?
        else {
            return None;
        };
        let global = self.module.global_variables.try_get(global).ok()?;
        let AddressSpace::Storage { access } = global.space else {
            return None;
        };
        if global.binding.is_none()
            || !access.contains(StorageAccess::LOAD)
            || (!value.is_const && !access.contains(StorageAccess::STORE))
        {
            return None;
        }
        self.module.types.check_contains_handle(global.ty).ok()?;
        let TypeInner::Array { base, .. } = self.module.types[global.ty].inner else {
            return None;
        };
        (base == cell.pointee).then_some(value.expression)
    }

    fn define(&mut self, local: Handle<LocalVariable>, definition: Definition) -> bool {
        let Some(slot) = self.definitions.get_mut(local.index()) else {
            return false;
        };
        if slot.is_some() {
            return false;
        }
        *slot = Some(definition);
        true
    }

    fn operation(
        &mut self,
        operation: &PointerOperation,
        root_position: usize,
        is_root: bool,
    ) -> Result<bool, ParseError> {
        self.budget.charge_work(1, self.span)?;
        let definition = match *operation {
            PointerOperation::Initialize {
                destination,
                ref value,
            } => {
                let Some(cell) = self.source.pointers.cells.get(&destination) else {
                    return Ok(false);
                };
                if !is_root || !matches!(cell.kind, PointerCellKind::Object { .. }) {
                    return Ok(false);
                }
                let Some(initializer) = self.resource_initializer(value, cell) else {
                    return Ok(false);
                };
                (
                    destination,
                    Definition::Object {
                        initializer,
                        root_position,
                    },
                )
            }
            PointerOperation::Capture {
                destination,
                source: binding,
            } => {
                let Some(captured) = self.source.pointers.cells.get(&destination) else {
                    return Ok(false);
                };
                let Some(address) = self.single_address(binding) else {
                    return Ok(false);
                };
                let Some(&Expression::LocalVariable(object)) =
                    self.function.expressions.try_get(address.root).ok()
                else {
                    return Ok(false);
                };
                let Some(cell) = self.source.pointers.cells.get(&object) else {
                    return Ok(false);
                };
                if captured.kind != PointerCellKind::Snapshot
                    || !matches!(cell.kind, PointerCellKind::Object { .. })
                    || captured.pointee != cell.pointee
                    || (cell.is_const && !captured.is_const)
                {
                    return Ok(false);
                }
                (
                    destination,
                    Definition::Snapshot {
                        object,
                        root_position,
                    },
                )
            }
            PointerOperation::Assign { .. } | PointerOperation::Update { .. } => return Ok(false),
        };
        Ok(self.define(definition.0, definition.1))
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
        let source = self.source;
        let mut pending = Vec::new();
        self.push_block(&mut pending, &function.body, 0, true)?;
        while let Some((block, root_position, is_root)) = pending.pop() {
            for (index, statement) in block.iter().enumerate() {
                self.budget.charge_work(1, self.span)?;
                let position = if is_root { index } else { root_position };
                match *statement {
                    Statement::Block(ref body) => {
                        let operation = deferred_call_marker(body)
                            .and_then(|marker| source.pointers.operations.get(&marker));
                        if let Some(operation) = operation {
                            if !self.operation(operation, position, is_root)? {
                                return Ok(false);
                            }
                        } else {
                            self.push_block(&mut pending, body, position, false)?;
                        }
                    }
                    Statement::If {
                        ref accept,
                        ref reject,
                        ..
                    } => {
                        self.push_block(&mut pending, accept, position, false)?;
                        self.push_block(&mut pending, reject, position, false)?;
                    }
                    Statement::Switch { ref cases, .. } => {
                        for case in cases {
                            self.budget.charge_work(1, self.span)?;
                            self.push_block(&mut pending, &case.body, position, false)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        ..
                    } => {
                        self.push_block(&mut pending, body, position, false)?;
                        self.push_block(&mut pending, continuing, position, false)?;
                    }
                    Statement::Emit(_)
                    | Statement::Store { .. }
                    | Statement::Call { .. }
                    | Statement::Return { .. }
                    | Statement::Break
                    | Statement::Continue
                    | Statement::ControlBarrier(_)
                    | Statement::MemoryBarrier(_) => {}
                    _ => return Ok(false),
                }
            }
        }
        Ok(true)
    }

    fn complete(&mut self) -> Result<bool, ParseError> {
        for (&local, cell) in &self.source.pointers.cells {
            self.budget.charge_work(1, self.span)?;
            let Some(&Some(definition)) = self.definitions.get(local.index()) else {
                return Ok(false);
            };
            match (definition, cell.kind) {
                (Definition::Object { .. }, PointerCellKind::Object { .. }) => {}
                (
                    Definition::Snapshot {
                        object,
                        root_position,
                    },
                    PointerCellKind::Snapshot,
                ) => {
                    let Some(&Some(Definition::Object {
                        root_position: initialized,
                        ..
                    })) = self.definitions.get(object.index())
                    else {
                        return Ok(false);
                    };
                    if initialized >= root_position {
                        return Ok(false);
                    }
                }
                _ => return Ok(false),
            }
        }
        Ok(true)
    }
}
