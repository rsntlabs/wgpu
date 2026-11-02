use super::super::reference_bindings::bound_reference_is_valid;
use super::remapping::remapping_error;
use super::*;

impl Parser<'_> {
    pub(super) fn remap_bound_address(
        &mut self,
        source: &FunctionParameterState,
        handle: Handle<BoundAddress>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<Handle<BoundReference>, ParseError> {
        let address = source
            .bound_addresses
            .try_get(handle)
            .map_err(|_| remapping_error(span))?;
        let mut binding = match mapper.expression(self, address.root)? {
            MappedExpression::Reference { binding, .. } => binding,
            MappedExpression::Value(root) => {
                let address = self.retain_bound_address(
                    BoundAddress {
                        root,
                        projections: Vec::new(),
                    },
                    span,
                )?;
                self.parameter_expansion_budget
                    .charge_slice::<BoundTarget>(1, span)?;
                self.retain_bound_reference(
                    None,
                    alloc::vec![BoundTarget {
                        selector: address.index() as u32,
                        address,
                    }],
                    span,
                )?
            }
            MappedExpression::Pointer(_) => return Err(remapping_error(span)),
        };
        for projection in &address.projections {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let projection = match *projection {
                AddressProjection::Field(index) => AddressProjection::Field(index),
                AddressProjection::Index(captured) => {
                    AddressProjection::Index(self.remap_pointer_snapshot(captured, mapper, span)?)
                }
            };
            binding = self.project_bound_reference(binding, projection, span)?;
        }
        Ok(binding)
    }

    pub(super) fn remap_bound_binding(
        &mut self,
        source: &FunctionParameterState,
        handle: Handle<BoundReference>,
        mapper: &mut impl PointerRemapper,
        span: Span,
    ) -> Result<Handle<BoundReference>, ParseError> {
        let reference = source
            .bound_references
            .try_get(handle)
            .map_err(|_| remapping_error(span))?;
        self.parameter_expansion_budget
            .charge_work(reference.targets.len() + 1, span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<u32, ()>(reference.targets.len(), span)?;
        if !bound_reference_is_valid(reference) {
            return Err(remapping_error(span));
        }
        let Some(selector) = reference.selector else {
            return self.remap_bound_address(source, reference.targets[0].address, mapper, span);
        };
        let captured = self.remap_pointer_snapshot(selector, mapper, span)?;
        let selector = self.append(Expression::Load { pointer: captured }, span)?;
        let selected = self.temporary_pointer(&scalar_resolution(Scalar::U32), span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<BoundReference>>(reference.targets.len(), span)?;
        let mut bindings = Vec::with_capacity(reference.targets.len());
        let mut is_nullable = reference.is_nullable;
        for target in &reference.targets {
            let binding = self.remap_bound_address(source, target.address, mapper, span)?;
            is_nullable |= self.function.bound_references[binding].is_nullable;
            bindings.push(binding);
        }
        if is_nullable {
            self.initialize_empty_bound_selector(selected, span)?;
        }
        let case_count = reference.targets.len() + usize::from(is_nullable);
        self.parameter_expansion_budget
            .charge_slice::<crate::SwitchCase>(case_count, span)?;
        self.parameter_expansion_budget
            .charge_nodes(case_count, span)?;
        let mut cases = Vec::with_capacity(case_count);
        let mut addresses = Vec::new();
        for (index, (target, &binding)) in reference.targets.iter().zip(&bindings).enumerate() {
            let (_, body) = self.capture_block(|parser| {
                parser.with_bound_target(binding, span, &mut |parser, address| {
                    parser
                        .parameter_expansion_budget
                        .charge_slice::<Handle<BoundAddress>>(1, span)?;
                    addresses.push(address);
                    let value = parser.append(
                        Expression::Literal(Literal::U32(address.index() as u32)),
                        span,
                    )?;
                    parser.generated_pointer_statement(
                        Statement::Store {
                            pointer: selected,
                            value,
                        },
                        span,
                    )
                })
            })?;
            cases.push(crate::SwitchCase {
                value: if index + 1 == reference.targets.len() && !is_nullable {
                    crate::SwitchValue::Default
                } else {
                    crate::SwitchValue::U32(target.selector)
                },
                body,
                fall_through: false,
            });
        }
        if is_nullable {
            cases.push(crate::SwitchCase {
                value: crate::SwitchValue::Default,
                body: crate::Block::new(),
                fall_through: false,
            });
        }
        self.generated_pointer_statement(Statement::Switch { selector, cases }, span)?;
        let sorting_work = addresses
            .len()
            .saturating_mul((usize::BITS - addresses.len().leading_zeros()) as usize + 1);
        self.parameter_expansion_budget
            .charge_work(sorting_work, span)?;
        addresses.sort_unstable_by_key(|address| address.index());
        addresses.dedup();
        self.parameter_expansion_budget
            .charge_slice::<BoundTarget>(addresses.len(), span)?;
        let targets = addresses
            .into_iter()
            .map(|address| BoundTarget {
                selector: address.index() as u32,
                address,
            })
            .collect();
        self.retain_bound_reference_with_nullability(Some(selected), targets, is_nullable, span)
    }
}
