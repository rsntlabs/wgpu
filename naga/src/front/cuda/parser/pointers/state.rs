use super::*;

#[derive(Clone, Copy, Debug, PartialEq)]
pub(in super::super) enum PointerCellKind {
    Object { writable: bool },
    Snapshot,
}

#[derive(Clone, Copy, Debug)]
pub(in super::super) struct PointerCell {
    pub(in super::super) pointee: Handle<Type>,
    pub(in super::super) is_const: bool,
    pub(in super::super) kind: PointerCellKind,
    pub(in super::super) expression: Handle<Expression>,
}

#[derive(Clone, Debug)]
pub(in super::super) enum PointerOperation {
    Initialize {
        destination: Handle<LocalVariable>,
        value: PointerValue,
    },
    Assign {
        destination: Handle<BoundReference>,
        value: PointerValue,
    },
    Capture {
        destination: Handle<LocalVariable>,
        source: Handle<BoundReference>,
    },
    Update {
        destination: Handle<BoundReference>,
        amount: Handle<Expression>,
        subtract: bool,
    },
}

impl Parser<'_> {
    pub(in super::super) fn register_pointer_cell(
        &mut self,
        local: Handle<LocalVariable>,
        cell: PointerCell,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<LocalVariable>, PointerCell>(1, span)?;
        self.function.pointers.cells.insert(local, cell);
        Ok(())
    }

    pub(super) fn pointer_cell(
        &mut self,
        pointee: Handle<Type>,
        is_const: bool,
        kind: PointerCellKind,
        span: Span,
    ) -> Result<Handle<LocalVariable>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let expression = self.temporary_pointer(&scalar_resolution(Scalar::U32), span)?;
        let Expression::LocalVariable(local) = self.function.ir.expressions[expression] else {
            unreachable!()
        };
        self.register_pointer_cell(
            local,
            PointerCell {
                pointee,
                is_const,
                kind,
                expression,
            },
            span,
        )?;
        Ok(local)
    }

    pub(super) fn pointer_operation(
        &mut self,
        operation: PointerOperation,
        span: Span,
    ) -> Result<(), ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<Expression>, PointerOperation>(1, span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<Expression>, ()>(1, span)?;
        let (marker, body) = self.deferred_marker(span)?;
        self.function.pointers.operations.insert(marker, operation);
        self.function.pointers.operation_markers.insert(marker);
        self.generated_pointer_statement(Statement::Block(body), span)
    }
}
