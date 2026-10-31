use super::*;

mod inventory;

#[cfg(test)]
mod tests;

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
enum OriginRoot {
    Local(Handle<LocalVariable>),
    Global(Handle<GlobalVariable>),
}

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
enum OriginProjection {
    Field(u32),
    Index,
}

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
enum OriginKind {
    Array,
    Object,
}

#[derive(Clone, Debug)]
struct OriginFamily {
    root: OriginRoot,
    root_expression: Handle<Expression>,
    projections: Vec<OriginProjection>,
    kind: OriginKind,
    pointee: Handle<Type>,
}

#[derive(Clone)]
pub(in super::super) struct PointerRuntime {
    pub(in super::super) state_type: Handle<Type>,
    families: Vec<OriginFamily>,
    expression_families: Vec<Vec<u32>>,
    cell_families: FastHashMap<Handle<LocalVariable>, Vec<u32>>,
    coordinate_count: usize,
}

#[derive(Clone, Copy)]
struct PointerWrite<'a> {
    source: &'a FunctionParameterState,
    destination: Handle<Expression>,
    span: Span,
}

fn runtime_error(span: Span) -> ParseError {
    ParseError {
        message: String::from("invalid CUDA runtime pointer state"),
        span,
    }
}

fn mapped_value(
    parser: &mut Parser<'_>,
    mapper: &mut impl PointerRemapper,
    expression: Handle<Expression>,
    span: Span,
) -> Result<Handle<Expression>, ParseError> {
    match mapper.expression(parser, expression)? {
        MappedExpression::Value(value) => Ok(value),
        _ => Err(runtime_error(span)),
    }
}

impl PointerRuntime {
    pub(in super::super) fn new(
        parser: &mut Parser<'_>,
        function: &Function,
        source: &FunctionParameterState,
        span: Span,
    ) -> Result<Self, ParseError> {
        inventory::build(parser, function, source, span)
    }

    fn cell_pointer(
        &self,
        parser: &mut Parser<'_>,
        source: &FunctionParameterState,
        cell: Handle<LocalVariable>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        if self.cell_families.get(&cell).is_none_or(Vec::is_empty) {
            return Err(runtime_error(span));
        }
        let cell = source
            .pointers
            .cells
            .get(&cell)
            .ok_or_else(|| runtime_error(span))?;
        let pointer = mapped_value(parser, mapper, cell.expression, span)?;
        let expression = parser
            .function
            .ir
            .expressions
            .try_get(pointer)
            .map_err(|_| runtime_error(span))?;
        let Expression::LocalVariable(local) = *expression else {
            return Err(runtime_error(span));
        };
        if parser
            .function
            .ir
            .local_variables
            .try_get(local)
            .map_err(|_| runtime_error(span))?
            .ty
            != self.state_type
        {
            return Err(runtime_error(span));
        }
        Ok(pointer)
    }

    fn check_state_pointer(
        &self,
        parser: &Parser<'_>,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        let expression = parser
            .function
            .ir
            .expressions
            .try_get(pointer)
            .map_err(|_| runtime_error(span))?;
        let Expression::LocalVariable(local) = *expression else {
            return Err(runtime_error(span));
        };
        if parser
            .function
            .ir
            .local_variables
            .try_get(local)
            .map_err(|_| runtime_error(span))?
            .ty
            != self.state_type
        {
            return Err(runtime_error(span));
        }
        Ok(())
    }

    fn word_pointer(
        &self,
        parser: &mut Parser<'_>,
        pointer: Handle<Expression>,
        index: u32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.check_state_pointer(parser, pointer, span)?;
        parser.append(
            Expression::AccessIndex {
                base: pointer,
                index,
            },
            span,
        )
    }

    fn load_word(
        &self,
        parser: &mut Parser<'_>,
        pointer: Handle<Expression>,
        index: u32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let pointer = self.word_pointer(parser, pointer, index, span)?;
        parser.append(Expression::Load { pointer }, span)
    }

    fn store_word(
        &self,
        parser: &mut Parser<'_>,
        pointer: Handle<Expression>,
        index: u32,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        let pointer = self.word_pointer(parser, pointer, index, span)?;
        parser.generated_pointer_statement(Statement::Store { pointer, value }, span)
    }

    fn copy_state(
        &self,
        parser: &mut Parser<'_>,
        destination: Handle<Expression>,
        source: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.check_state_pointer(parser, destination, span)?;
        self.check_state_pointer(parser, source, span)?;
        let value = parser.append(Expression::Load { pointer: source }, span)?;
        parser.generated_pointer_statement(
            Statement::Store {
                pointer: destination,
                value,
            },
            span,
        )
    }

    fn update_position(
        &self,
        parser: &mut Parser<'_>,
        destination: Handle<Expression>,
        amount: Handle<Expression>,
        subtract: bool,
        span: Span,
    ) -> Result<(), ParseError> {
        let left = self.load_word(parser, destination, 1, span)?;
        let value = parser.append(
            Expression::Binary {
                op: if subtract {
                    BinaryOperator::Subtract
                } else {
                    BinaryOperator::Add
                },
                left,
                right: amount,
            },
            span,
        )?;
        self.store_word(parser, destination, 1, value, span)
    }

    fn temporary_state(
        &self,
        parser: &mut Parser<'_>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        parser.temporary_pointer(&TypeResolution::Handle(self.state_type), span)
    }

    fn copy_binding(
        &self,
        parser: &mut Parser<'_>,
        source: &FunctionParameterState,
        binding: Handle<BoundReference>,
        destination: Handle<Expression>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<(), ParseError> {
        let binding = parser.remap_bound_binding(source, binding, mapper, span)?;
        parser.with_bound_target(binding, span, &mut |parser, address| {
            let pointer = parser.bound_address_pointer(address, span)?;
            self.copy_state(parser, destination, pointer, span)
        })
    }

    fn family_for_address(
        &self,
        parser: &mut Parser<'_>,
        address: &BoundAddress,
        kind: OriginKind,
        pointee: Handle<Type>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<u32, ParseError> {
        let actual_root = match parser.function.ir.expressions[address.root] {
            Expression::LocalVariable(local) => OriginRoot::Local(local),
            Expression::GlobalVariable(global) => OriginRoot::Global(global),
            _ => return Err(runtime_error(span)),
        };
        for (index, family) in self.families.iter().enumerate() {
            parser
                .parameter_expansion_budget
                .charge_work(address.projections.len() + 1, span)?;
            if family.kind != kind
                || family.pointee != pointee
                || family.projections.len() != address.projections.len()
            {
                continue;
            }
            if !family.projections.iter().zip(&address.projections).all(
                |(expected, actual)| match (expected, actual) {
                    (&OriginProjection::Field(left), &AddressProjection::Field(right)) => {
                        left == right
                    }
                    (&OriginProjection::Index, &AddressProjection::Index(_)) => true,
                    _ => false,
                },
            ) {
                continue;
            }
            let root = mapped_value(parser, mapper, family.root_expression, span)?;
            let root = match parser.function.ir.expressions[root] {
                Expression::LocalVariable(local) => OriginRoot::Local(local),
                Expression::GlobalVariable(global) => OriginRoot::Global(global),
                _ => return Err(runtime_error(span)),
            };
            if root == actual_root {
                return u32::try_from(index).map_err(|_| runtime_error(span));
            }
        }
        Err(runtime_error(span))
    }

    fn write_origin(
        &self,
        parser: &mut Parser<'_>,
        write: PointerWrite<'_>,
        expression: &PointerExpression,
        mapper: &mut impl PointerRemapper,
    ) -> Result<(), ParseError> {
        let PointerWrite { source, span, .. } = write;
        let binding = match expression.kind {
            PointerExpressionKind::Array(binding) | PointerExpressionKind::Address(binding) => {
                binding
            }
            _ => return Err(runtime_error(span)),
        };
        let binding = parser.remap_bound_binding(source, binding, mapper, span)?;
        parser.with_bound_target(binding, span, &mut |parser, handle| {
            let checkpoint = mapper.checkpoint();
            let result = self.write_address(parser, write, handle, expression, mapper);
            mapper.restore(parser, checkpoint)?;
            result
        })
    }

    fn write_address(
        &self,
        parser: &mut Parser<'_>,
        write: PointerWrite<'_>,
        handle: Handle<BoundAddress>,
        expression: &PointerExpression,
        mapper: &mut impl PointerRemapper,
    ) -> Result<(), ParseError> {
        let PointerWrite {
            destination, span, ..
        } = write;
        let is_array = matches!(expression.kind, PointerExpressionKind::Array(_));
        let count = parser.function.bound_addresses[handle].projections.len();
        parser
            .parameter_expansion_budget
            .charge_slice::<AddressProjection>(count, span)?;
        parser
            .parameter_expansion_budget
            .charge_work(count + 1, span)?;
        let address = parser.function.bound_addresses[handle].clone();
        let (address, initial, kind) =
            match parser.analyze_pointer_origin(address, is_array, span)? {
                PointerOrigin::Array {
                    address,
                    initial_index,
                } => (address, initial_index, OriginKind::Array),
                PointerOrigin::Object(address) => (address, None, OriginKind::Object),
            };
        let family =
            self.family_for_address(parser, &address, kind, expression.pointee, mapper, span)?;
        let zero = parser.append(Expression::ZeroValue(self.state_type), span)?;
        parser.generated_pointer_statement(
            Statement::Store {
                pointer: destination,
                value: zero,
            },
            span,
        )?;
        let tag = parser.append(Expression::Literal(Literal::U32(family)), span)?;
        self.store_word(parser, destination, 0, tag, span)?;
        let position = match initial {
            Some(AddressProjection::Field(index)) => {
                parser.append(Expression::Literal(Literal::U32(index)), span)?
            }
            Some(AddressProjection::Index(pointer)) => {
                parser.append(Expression::Load { pointer }, span)?
            }
            None => parser.append(Expression::Literal(Literal::U32(0)), span)?,
        };
        self.store_word(parser, destination, 1, position, span)?;
        let mut coordinate = 2;
        for projection in address.projections {
            if let AddressProjection::Index(pointer) = projection {
                let value = parser.append(Expression::Load { pointer }, span)?;
                self.store_word(parser, destination, coordinate, value, span)?;
                coordinate += 1;
            }
        }
        Ok(())
    }

    fn write_expression(
        &self,
        parser: &mut Parser<'_>,
        write: PointerWrite<'_>,
        expression: Handle<PointerExpression>,
        mapper: &mut impl PointerRemapper,
        depth: u32,
    ) -> Result<(), ParseError> {
        let PointerWrite {
            source,
            destination,
            span,
        } = write;
        parser.parameter_expansion_budget.charge_work(1, span)?;
        if depth > 64 {
            return Err(runtime_error(span));
        }
        let expression = source
            .pointers
            .expressions
            .try_get(expression)
            .map_err(|_| runtime_error(span))?;
        match expression.kind {
            PointerExpressionKind::Parameter(_) => Err(runtime_error(span)),
            PointerExpressionKind::Object(binding) => {
                self.copy_binding(parser, source, binding, destination, mapper, span)
            }
            PointerExpressionKind::Snapshot(cell) => {
                let pointer = self.cell_pointer(parser, source, cell, mapper, span)?;
                self.copy_state(parser, destination, pointer, span)
            }
            PointerExpressionKind::Array(_) | PointerExpressionKind::Address(_) => {
                self.write_origin(parser, write, expression, mapper)
            }
            PointerExpressionKind::Offset {
                base,
                offset,
                subtract,
            } => {
                self.write_expression(parser, write, base, mapper, depth + 1)?;
                let offset = parser.remap_pointer_snapshot(offset, mapper, span)?;
                let amount = parser.append(Expression::Load { pointer: offset }, span)?;
                self.update_position(parser, destination, amount, subtract, span)
            }
            PointerExpressionKind::Select {
                selector,
                accept,
                reject,
            } => {
                let selector = parser.remap_pointer_snapshot(selector, mapper, span)?;
                let selector = parser.append(Expression::Load { pointer: selector }, span)?;
                let zero = parser.append(Expression::Literal(Literal::U32(0)), span)?;
                let condition = parser.append(
                    Expression::Binary {
                        op: BinaryOperator::NotEqual,
                        left: selector,
                        right: zero,
                    },
                    span,
                )?;
                let checkpoint = mapper.checkpoint();
                let ((), accept) = parser.capture_block(|parser| {
                    self.write_expression(parser, write, accept, mapper, depth + 1)
                })?;
                mapper.restore(parser, checkpoint)?;
                let ((), reject) = parser.capture_block(|parser| {
                    self.write_expression(parser, write, reject, mapper, depth + 1)
                })?;
                mapper.restore(parser, checkpoint)?;
                parser.generated_pointer_statement(
                    Statement::If {
                        condition,
                        accept,
                        reject,
                    },
                    span,
                )
            }
        }
    }

    fn write_value(
        &self,
        parser: &mut Parser<'_>,
        source: &FunctionParameterState,
        value: &PointerValue,
        destination: Handle<Expression>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<(), ParseError> {
        let write = PointerWrite {
            source,
            destination,
            span,
        };
        self.write_expression(parser, write, value.expression, mapper, 1)?;
        let PointerValueCategory::Value { position } = value.category else {
            return Err(runtime_error(span));
        };
        if let Some(position) = position {
            let position = parser.remap_pointer_snapshot(position, mapper, span)?;
            let amount = parser.append(Expression::Load { pointer: position }, span)?;
            self.update_position(parser, destination, amount, false, span)?;
        }
        Ok(())
    }

    pub(in super::super) fn lower_operation(
        &self,
        parser: &mut Parser<'_>,
        source: &FunctionParameterState,
        operation: &PointerOperation,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<(), ParseError> {
        match *operation {
            PointerOperation::Initialize {
                destination,
                ref value,
            } => {
                let destination = self.cell_pointer(parser, source, destination, mapper, span)?;
                self.write_value(parser, source, value, destination, mapper, span)
            }
            PointerOperation::Capture {
                destination,
                source: binding,
            } => {
                let destination = self.cell_pointer(parser, source, destination, mapper, span)?;
                self.copy_binding(parser, source, binding, destination, mapper, span)
            }
            PointerOperation::Assign {
                destination,
                ref value,
            } => {
                let captured = self.temporary_state(parser, span)?;
                self.write_value(parser, source, value, captured, mapper, span)?;
                let destination = parser.remap_bound_binding(source, destination, mapper, span)?;
                parser.with_bound_target(destination, span, &mut |parser, address| {
                    let destination = parser.bound_address_pointer(address, span)?;
                    self.copy_state(parser, destination, captured, span)
                })
            }
            PointerOperation::Update {
                destination,
                amount,
                subtract,
            } => {
                let amount = mapped_value(parser, mapper, amount, span)?;
                let destination = parser.remap_bound_binding(source, destination, mapper, span)?;
                parser.with_bound_target(destination, span, &mut |parser, address| {
                    let destination = parser.bound_address_pointer(address, span)?;
                    self.update_position(parser, destination, amount, subtract, span)
                })
            }
        }
    }

    pub(in super::super) fn reference(
        &self,
        parser: &mut Parser<'_>,
        source: &FunctionParameterState,
        access: Handle<PointerAccess>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<ReferenceValue, ParseError> {
        let access = source
            .pointers
            .accesses
            .try_get(access)
            .map_err(|_| runtime_error(span))?;
        let families = self
            .expression_families
            .get(access.pointer.expression.index())
            .ok_or_else(|| runtime_error(span))?;
        if families.is_empty() {
            return Err(runtime_error(span));
        }
        let state = self.temporary_state(parser, span)?;
        self.write_value(parser, source, &access.pointer, state, mapper, span)?;
        let value = self.load_word(parser, state, 0, span)?;
        let selector = parser.freeze_reference_index(value, span)?;
        let value = self.load_word(parser, state, 1, span)?;
        let position = parser.freeze_reference_index(value, span)?;
        parser
            .parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(self.coordinate_count, span)?;
        let mut coordinates = Vec::with_capacity(self.coordinate_count);
        for index in 0..self.coordinate_count {
            let value = self.load_word(parser, state, (index + 2) as u32, span)?;
            coordinates.push(parser.freeze_reference_index(value, span)?);
        }
        parser
            .parameter_expansion_budget
            .charge_slice::<AddressProjection>(access.projections.len(), span)?;
        let mut projections = Vec::with_capacity(access.projections.len());
        for projection in &access.projections {
            projections.push(match *projection {
                AddressProjection::Field(index) => AddressProjection::Field(index),
                AddressProjection::Index(pointer) => {
                    AddressProjection::Index(parser.remap_pointer_snapshot(pointer, mapper, span)?)
                }
            });
        }
        parser
            .parameter_expansion_budget
            .charge_slice::<BoundTarget>(families.len(), span)?;
        let mut targets = Vec::with_capacity(families.len());
        for &tag in families {
            let family = self
                .families
                .get(tag as usize)
                .ok_or_else(|| runtime_error(span))?;
            parser
                .parameter_expansion_budget
                .charge_work(family.projections.len() + projections.len() + 1, span)?;
            if !access.pointer.is_const && !inventory::writable_root(parser, family.root) {
                return Err(runtime_error(span));
            }
            let root = mapped_value(parser, mapper, family.root_expression, span)?;
            let length = family.projections.len()
                + projections.len()
                + usize::from(family.kind == OriginKind::Array);
            parser
                .parameter_expansion_budget
                .charge_slice::<AddressProjection>(length, span)?;
            let mut path = Vec::with_capacity(length);
            let mut coordinate = 0;
            for projection in &family.projections {
                path.push(match *projection {
                    OriginProjection::Field(index) => AddressProjection::Field(index),
                    OriginProjection::Index => {
                        let pointer = *coordinates
                            .get(coordinate)
                            .ok_or_else(|| runtime_error(span))?;
                        coordinate += 1;
                        AddressProjection::Index(pointer)
                    }
                });
            }
            if family.kind == OriginKind::Array {
                path.push(AddressProjection::Index(position));
            }
            path.extend(projections.iter().cloned());
            let address = parser.retain_bound_address(
                BoundAddress {
                    root,
                    projections: path,
                },
                span,
            )?;
            targets.push(BoundTarget {
                selector: tag,
                address,
            });
        }
        let selector = (targets.len() > 1).then_some(selector);
        let binding = parser.retain_bound_reference(selector, targets, span)?;
        Ok(ReferenceValue {
            reference: Reference::Bound(binding),
            writable: !access.pointer.is_const,
            ty: access.ty.clone(),
            span,
            constant: ConstantValue::default(),
        })
    }
}
