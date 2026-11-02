use super::*;

struct MappedPointerExpression {
    expression: Handle<PointerExpression>,
    position: Option<Handle<Expression>>,
}

pub(super) fn remapping_error(span: Span) -> ParseError {
    ParseError {
        message: String::from("invalid CUDA pointer parameter mapping"),
        span,
    }
}

impl Parser<'_> {
    pub(super) fn remap_pointer_snapshot(
        &mut self,
        source: Handle<Expression>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        match mapper.expression(self, source)? {
            MappedExpression::Value(pointer) => Ok(pointer),
            _ => Err(remapping_error(span)),
        }
    }

    fn remap_pointer_expression(
        &mut self,
        source: &FunctionParameterState,
        handle: Handle<PointerExpression>,
        mapper: &mut impl PointerRemapper,
        depth: u32,
        span: Span,
    ) -> Result<MappedPointerExpression, ParseError> {
        self.parameter_expansion_budget.charge_work(1, span)?;
        if depth > 64 {
            return Err(ParseError {
                message: String::from("CUDA pointer expression nesting limit exceeded"),
                span,
            });
        }
        let expression = source
            .pointers
            .expressions
            .try_get(handle)
            .map_err(|_| remapping_error(span))?;
        let expression = if let (&PointerExpressionKind::Snapshot(local), Some(immutable)) =
            (&expression.kind, source.pointers.immutable.as_deref())
        {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let initializer = immutable
                .initializer(local)
                .ok_or_else(|| remapping_error(span))?;
            let initializer = source
                .pointers
                .expressions
                .try_get(initializer)
                .map_err(|_| remapping_error(span))?;
            if !matches!(initializer.kind, PointerExpressionKind::Array(_))
                || initializer.pointee != expression.pointee
            {
                return Err(remapping_error(span));
            }
            initializer
        } else {
            expression
        };
        let mut position = None;
        let kind = match expression.kind {
            PointerExpressionKind::Null => PointerExpressionKind::Null,
            PointerExpressionKind::Object(binding) => PointerExpressionKind::Object(
                self.remap_bound_binding(source, binding, mapper, span)?,
            ),
            PointerExpressionKind::Snapshot(local) => PointerExpressionKind::Snapshot(
                self.remap_pointer_cell(source, local, mapper, span)?,
            ),
            PointerExpressionKind::Parameter(index) => {
                let actual = mapper.parameter(index)?;
                if self.function.pointers.expressions[actual.expression].pointee
                    != expression.pointee
                {
                    return Err(remapping_error(span));
                }
                let PointerValueCategory::Value { position } = actual.category else {
                    return Err(remapping_error(span));
                };
                return Ok(MappedPointerExpression {
                    expression: actual.expression,
                    position,
                });
            }
            PointerExpressionKind::Array(binding) => PointerExpressionKind::Array(
                self.remap_bound_binding(source, binding, mapper, span)?,
            ),
            PointerExpressionKind::Address(binding) => PointerExpressionKind::Address(
                self.remap_bound_binding(source, binding, mapper, span)?,
            ),
            PointerExpressionKind::Offset {
                base,
                offset,
                subtract,
            } => {
                let base = self.remap_pointer_expression(source, base, mapper, depth + 1, span)?;
                let offset = self.remap_pointer_snapshot(offset, mapper, span)?;
                position = base.position;
                PointerExpressionKind::Offset {
                    base: base.expression,
                    offset,
                    subtract,
                }
            }
            PointerExpressionKind::Select {
                selector,
                accept,
                reject,
            } => {
                let selector = self.remap_pointer_snapshot(selector, mapper, span)?;
                let accept =
                    self.remap_pointer_expression(source, accept, mapper, depth + 1, span)?;
                let reject =
                    self.remap_pointer_expression(source, reject, mapper, depth + 1, span)?;
                if accept.position.is_some() || reject.position.is_some() {
                    let selected = self.load_pointer_position(Some(selector), span)?;
                    let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
                    let condition = self.append(
                        Expression::Binary {
                            op: BinaryOperator::NotEqual,
                            left: selected,
                            right: zero,
                        },
                        span,
                    )?;
                    let accept_position = self.load_pointer_position(accept.position, span)?;
                    let reject_position = self.load_pointer_position(reject.position, span)?;
                    let value = self.append(
                        Expression::Select {
                            condition,
                            accept: accept_position,
                            reject: reject_position,
                        },
                        span,
                    )?;
                    position = Some(self.freeze_reference_index(value, span)?);
                }
                PointerExpressionKind::Select {
                    selector,
                    accept: accept.expression,
                    reject: reject.expression,
                }
            }
        };
        let expression = self.retain_pointer_expression(kind, expression.pointee, span)?;
        Ok(MappedPointerExpression {
            expression,
            position,
        })
    }

    pub(in super::super) fn remap_pointer_value(
        &mut self,
        source: &FunctionParameterState,
        value: &PointerValue,
        mapper: &mut impl PointerRemapper,
    ) -> Result<PointerValue, ParseError> {
        let mapped =
            self.remap_pointer_expression(source, value.expression, mapper, 1, value.span)?;
        let PointerValueCategory::Value { position } = value.category else {
            return Err(remapping_error(value.span));
        };
        let position = position
            .map(|position| self.remap_pointer_snapshot(position, mapper, value.span))
            .transpose()?;
        let position = self.combine_pointer_positions(mapped.position, position, value.span)?;
        Ok(PointerValue {
            expression: mapped.expression,
            category: PointerValueCategory::Value { position },
            ..value.clone()
        })
    }

    pub(in super::super) fn remap_pointer_access(
        &mut self,
        source: &FunctionParameterState,
        handle: Handle<PointerAccess>,
        mapper: &mut impl PointerRemapper,
    ) -> Result<ReferenceValue, ParseError> {
        let access = source
            .pointers
            .accesses
            .try_get(handle)
            .map_err(|_| remapping_error(Span::default()))?;
        let span = source.pointers.accesses.get_span(handle);
        if let Some(runtime) = source.pointers.runtime.as_deref() {
            return runtime.reference(self, source, handle, mapper, span);
        }
        let pointer = self.remap_pointer_value(source, &access.pointer, mapper)?;
        self.parameter_expansion_budget
            .charge_slice::<AddressProjection>(access.projections.len(), span)?;
        let mut projections = Vec::with_capacity(access.projections.len());
        for projection in &access.projections {
            self.parameter_expansion_budget.charge_work(1, span)?;
            projections.push(match *projection {
                AddressProjection::Field(index) => AddressProjection::Field(index),
                AddressProjection::Index(captured) => {
                    AddressProjection::Index(self.remap_pointer_snapshot(captured, mapper, span)?)
                }
            });
        }
        let reference =
            self.retain_pointer_access(pointer, projections, access.ty.clone(), span)?;
        self.materialize_pointer_reference(reference)
    }

    fn remap_pointer_cell(
        &mut self,
        source: &FunctionParameterState,
        local: Handle<LocalVariable>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<Handle<LocalVariable>, ParseError> {
        let cell = source
            .pointers
            .cells
            .get(&local)
            .ok_or_else(|| remapping_error(span))?;
        let expression = self.remap_pointer_snapshot(cell.expression, mapper, span)?;
        let Expression::LocalVariable(local) = self.function.ir.expressions[expression] else {
            return Err(remapping_error(span));
        };
        if !self.function.pointers.cells.contains_key(&local) {
            return Err(remapping_error(span));
        }
        Ok(local)
    }

    pub(in super::super) fn remap_pointer_operation(
        &mut self,
        source: &FunctionParameterState,
        operation: &PointerOperation,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<(), ParseError> {
        if let Some(immutable) = source.pointers.immutable.as_deref() {
            let proven = match *operation {
                PointerOperation::Initialize {
                    destination,
                    ref value,
                } => immutable.initializer(destination) == Some(value.expression),
                PointerOperation::Capture { destination, .. } => {
                    immutable.initializer(destination).is_some()
                }
                _ => false,
            };
            return if proven {
                Ok(())
            } else {
                Err(remapping_error(span))
            };
        }
        if let Some(runtime) = source.pointers.runtime.as_deref() {
            return runtime.lower_operation(self, source, operation, mapper, span);
        }
        let operation = match *operation {
            PointerOperation::Test {
                destination,
                ref value,
                is_null,
            } => PointerOperation::Test {
                destination: self.remap_pointer_snapshot(destination, mapper, span)?,
                value: self.remap_pointer_value(source, value, mapper)?,
                is_null,
            },
            PointerOperation::Initialize {
                destination,
                ref value,
            } => PointerOperation::Initialize {
                destination: self.remap_pointer_cell(source, destination, mapper, span)?,
                value: self.remap_pointer_value(source, value, mapper)?,
            },
            PointerOperation::Assign {
                destination,
                ref value,
            } => {
                let value = self.remap_pointer_value(source, value, mapper)?;
                PointerOperation::Assign {
                    destination: self.remap_bound_binding(source, destination, mapper, span)?,
                    value,
                }
            }
            PointerOperation::Capture {
                destination,
                source: binding,
            } => PointerOperation::Capture {
                destination: self.remap_pointer_cell(source, destination, mapper, span)?,
                source: self.remap_bound_binding(source, binding, mapper, span)?,
            },
            PointerOperation::Update {
                destination,
                amount,
                subtract,
            } => PointerOperation::Update {
                destination: self.remap_bound_binding(source, destination, mapper, span)?,
                amount: self.remap_pointer_snapshot(amount, mapper, span)?,
                subtract,
            },
        };
        self.pointer_operation(operation, span)
    }

    pub(in super::super) fn generated_pointer_statement(
        &mut self,
        statement: Statement,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    pub(in super::super) fn remap_bound_reference(
        &mut self,
        source: &FunctionParameterState,
        binding: Handle<BoundReference>,
        ty: &TypeResolution,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<ReferenceValue, ParseError> {
        let binding = self.remap_bound_binding(source, binding, mapper, span)?;
        Ok(ReferenceValue {
            discard_read: true,
            reference: Reference::Bound(binding),
            qualifiers: Qualifiers::NONE,
            ty: ty.clone(),
            span,
            constant: ConstantValue::default(),
        })
    }
}
