use super::*;

#[derive(Clone, Copy, PartialEq)]
enum AtomicTargetKind {
    Legal,
    Private,
    Deferred,
}

impl Parser<'_> {
    fn atomic_target_kind(
        &mut self,
        mut pointer: Handle<Expression>,
        span: Span,
    ) -> Result<AtomicTargetKind, ParseError> {
        for _ in 0..=64 {
            self.parameter_expansion_budget.charge_work(1, span)?;
            match self.function.ir.expressions[pointer] {
                Expression::Access { base, .. } | Expression::AccessIndex { base, .. } => {
                    pointer = base
                }
                Expression::GlobalVariable(global) => {
                    return match self.module.global_variables[global].space {
                        AddressSpace::Storage { access }
                            if access.contains(StorageAccess::LOAD | StorageAccess::STORE) =>
                        {
                            Ok(AtomicTargetKind::Legal)
                        }
                        AddressSpace::WorkGroup => Ok(AtomicTargetKind::Legal),
                        _ => Err(super::super::atomics::atomic_error(span)),
                    };
                }
                Expression::LocalVariable(local) => {
                    return Ok(
                        if self
                            .function
                            .pointers
                            .validation_addresses
                            .contains_key(&local)
                        {
                            AtomicTargetKind::Deferred
                        } else {
                            AtomicTargetKind::Private
                        },
                    );
                }
                Expression::FunctionArgument(_) => return Ok(AtomicTargetKind::Deferred),
                _ => return Err(expansion_error(span)),
            }
        }
        Err(expansion_error(span))
    }

    fn atomic_binding_is_concrete(
        &mut self,
        binding: Handle<BoundReference>,
        span: Span,
    ) -> Result<bool, ParseError> {
        let reference = self.bound_reference_view(binding, span)?;
        let mut has_legal = false;
        let mut has_deferred = false;
        for target in reference.targets {
            let root = self.function.bound_addresses[target.address].root;
            match self.atomic_target_kind(root, span)? {
                AtomicTargetKind::Legal => has_legal = true,
                AtomicTargetKind::Deferred => has_deferred = true,
                AtomicTargetKind::Private => {}
            }
        }
        if !has_deferred && !has_legal {
            return Err(super::super::atomics::atomic_error(span));
        }
        Ok(!has_deferred)
    }

    fn deferred_atomic_pointer(
        &mut self,
        binding: Handle<BoundReference>,
        ty: TypeResolution,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let reference = self.bound_reference_view(binding, span)?;
        if reference.selector.is_none() && reference.targets.len() == 1 {
            return self.bound_address_pointer(reference.targets[0].address, span);
        }
        let pointer = self.address_of(
            ExpressionValue::Reference(ReferenceValue {
                reference: Reference::Bound(binding),
                writable: true,
                ty,
                span,
                constant: ConstantValue::default(),
            }),
            span,
        )?;
        let reference = self.pointer_reference(pointer)?;
        let Reference::PointerAccess(access) = reference.reference else {
            return Err(expansion_error(span));
        };
        self.validation_pointer(access, span)
    }

    pub(super) fn clone_parameter_atomic(
        &mut self,
        invocation: &mut Invocation<'_>,
        pointer: Handle<Expression>,
        fun: crate::AtomicFunction,
        value: Handle<Expression>,
        result: Option<Handle<Expression>>,
        span: Span,
    ) -> Result<(), ParseError> {
        let pointer = self.invocation_expression(invocation, pointer)?;
        let value = self.invocation_value(invocation, value)?;
        let ty = result
            .map(|result| match invocation.source.expressions[result] {
                Expression::AtomicResult {
                    ty,
                    comparison: false,
                } => Ok(ty),
                _ => Err(expansion_error(span)),
            })
            .transpose()?;
        let mapped = match pointer {
            MappedExpression::Value(pointer) => {
                if self.atomic_target_kind(pointer, span)? == AtomicTargetKind::Private {
                    return Err(super::super::atomics::atomic_error(span));
                }
                let result = ty
                    .map(|ty| self.append_atomic_result(ty, span))
                    .transpose()?;
                self.generated_statement(
                    Statement::Atomic {
                        pointer,
                        fun,
                        value,
                        result,
                    },
                    span,
                )?;
                result
            }
            MappedExpression::Reference {
                binding,
                ty: pointee,
            } => {
                let concrete = self.atomic_binding_is_concrete(binding, span)?;
                if !concrete {
                    let pointer = self.deferred_atomic_pointer(binding, pointee, span)?;
                    let result = ty
                        .map(|ty| self.append_atomic_result(ty, span))
                        .transpose()?;
                    self.generated_statement(
                        Statement::Atomic {
                            pointer,
                            fun,
                            value,
                            result,
                        },
                        span,
                    )?;
                    result
                } else {
                    let destination = ty
                        .map(|ty| self.temporary_pointer(&TypeResolution::Handle(ty), span))
                        .transpose()?;
                    let mut reference = ReferenceValue {
                        reference: Reference::Bound(binding),
                        writable: true,
                        ty: pointee,
                        span,
                        constant: ConstantValue::default(),
                    };
                    self.decorate_reference(&mut reference, &mut |parser, pointer, _, span| {
                        if parser.atomic_target_kind(pointer, span)? == AtomicTargetKind::Private {
                            // A private selection has no defined CUDA atomic behavior.
                            if let (Some(pointer), Some(ty)) = (destination, ty) {
                                let zero = match parser.module.types[ty].inner {
                                    TypeInner::Scalar(Scalar::I32) => Literal::I32(0),
                                    TypeInner::Scalar(Scalar::U32) => Literal::U32(0),
                                    _ => return Err(expansion_error(span)),
                                };
                                let value = parser.append(Expression::Literal(zero), span)?;
                                parser.generated_statement(
                                    Statement::Store { pointer, value },
                                    span,
                                )?;
                            }
                            return Ok(());
                        }
                        let result = ty
                            .map(|ty| parser.append_atomic_result(ty, span))
                            .transpose()?;
                        parser.generated_statement(
                            Statement::Atomic {
                                pointer,
                                fun,
                                value,
                                result,
                            },
                            span,
                        )?;
                        if let (Some(pointer), Some(value)) = (destination, result) {
                            parser
                                .generated_statement(Statement::Store { pointer, value }, span)?;
                        }
                        Ok(())
                    })?;
                    destination
                        .map(|pointer| self.append(Expression::Load { pointer }, span))
                        .transpose()?
                }
            }
            MappedExpression::Pointer(_) => return Err(expansion_error(span)),
        };
        if let (Some(source), Some(mapped)) = (result, mapped) {
            self.cache_invocation_expression(invocation, source, MappedExpression::Value(mapped))?;
            self.name_invocation_expression(invocation.source, source, mapped, span)?;
        }
        Ok(())
    }
}
