use super::*;

impl Parser<'_> {
    pub(super) fn prvalue_qualifiers(
        &self,
        ty: &TypeResolution,
        qualifiers: Qualifiers,
    ) -> Qualifiers {
        if self.is_source_class(ty) {
            qualifiers
        } else {
            Qualifiers::NONE
        }
    }

    pub(super) fn member_access(
        &mut self,
        value: ExpressionResult,
    ) -> Result<ExpressionResult, ParseError> {
        let arrow = self.lexer.next()?.0 == Token::Arrow;
        let (field, span) = self.identifier()?;
        if let ExpressionResult::ThreadBlock(group) = value {
            if arrow {
                return Err(ParseError {
                    message: String::from(
                        "thread_block handles do not support pointer member access",
                    ),
                    span: group.span.until(&span),
                });
            }
            return self.thread_block_member(field, group.span.until(&span));
        }
        let value = value.require_value()?;
        let value = if arrow {
            let pointer = self.borrowed_pointer(value)?;
            ExpressionValue::Reference(self.pointer_reference(pointer)?)
        } else {
            value
        };
        self.field(value, field, span).map(ExpressionResult::Value)
    }

    pub(super) fn field(
        &mut self,
        value: ExpressionValue,
        field: &str,
        field_span: Span,
    ) -> Result<ExpressionValue, ParseError> {
        let invalid = || ParseError {
            message: format!("unknown or unsupported field `{field}`"),
            span: field_span,
        };
        let (index, ty) = match *value.shader_type()?.inner_with(&self.module.types) {
            TypeInner::Vector { size, scalar } => {
                let index = match field {
                    "x" => 0,
                    "y" => 1,
                    "z" => 2,
                    "w" => 3,
                    _ => return Err(invalid()),
                };
                if index >= size as u32 {
                    return Err(invalid());
                }
                (index, scalar_resolution(scalar))
            }
            TypeInner::Struct { ref members, .. } => {
                let index = members
                    .iter()
                    .position(|member| member.name.as_deref() == Some(field))
                    .ok_or_else(invalid)?;
                (index as u32, TypeResolution::Handle(members[index].ty))
            }
            _ => return Err(invalid()),
        };
        let span = value.span().until(&field_span);
        match value {
            ExpressionValue::NullPointer(value) => Err(ParseError {
                message: String::from("nullptr_t values have no fields"),
                span: value.span,
            }),
            ExpressionValue::Pointer(pointer) => Err(ParseError {
                message: String::from("pointer fields require dereferencing the pointer"),
                span: pointer.span,
            }),
            ExpressionValue::Plain(value) => {
                let handle = self.append(
                    Expression::AccessIndex {
                        base: value.handle,
                        index,
                    },
                    span,
                )?;
                Ok(Value {
                    category: ValueCategory::Xvalue,
                    qualifiers: value.qualifiers,
                    handle,
                    ty,
                    span,
                    constant: ConstantValue::default(),
                }
                .into())
            }
            ExpressionValue::Reference(reference) => self
                .project_reference(reference, index, &ty, span)
                .map(ExpressionValue::Reference),
        }
    }

    pub(super) fn array_index(
        &mut self,
        value: ExpressionValue,
    ) -> Result<ExpressionValue, ParseError> {
        if matches!(value, ExpressionValue::Pointer(_)) || self.function.address_operand {
            return self.pointer_index(value);
        }
        if !matches!(
            *value.shader_type()?.inner_with(&self.module.types),
            TypeInner::Array { .. }
        ) {
            return self.pointer_index(value);
        }
        let (element_ty, count) = match *value.shader_type()?.inner_with(&self.module.types) {
            TypeInner::Array { base, size, .. } => (
                TypeResolution::Handle(base),
                match size {
                    ArraySize::Constant(count) => Some(count),
                    _ => None,
                },
            ),
            _ => return self.fail("subscript requires an array"),
        };
        if matches!(&value, ExpressionValue::Reference(reference) if matches!(reference.reference, Reference::Conditional(_)))
        {
            return self.fail("conditional array subscripts are unsupported");
        }
        self.lexer.expect_span(Token::Paren('['))?;
        let index = self.expression(0)?;
        let index = self.rvalue(index)?;
        let scalar = self.require_scalar_type(&index.ty, index.span)?;
        if !matches!(scalar.kind, ScalarKind::Sint | ScalarKind::Uint) {
            return Err(ParseError {
                message: String::from("array index must be an integer"),
                span: index.span,
            });
        }
        let end = self.lexer.expect_span(Token::Paren(']'))?;
        let span = value.span().until(&end);
        let discardable =
            Self::constant_array_address(value.constant().is_discardable, count, index.constant);
        match value {
            ExpressionValue::Plain(value) => {
                let handle = self.append(
                    Expression::Access {
                        base: value.handle,
                        index: index.handle,
                    },
                    span,
                )?;
                Ok(Value {
                    category: ValueCategory::Xvalue,
                    qualifiers: value.qualifiers,
                    handle,
                    ty: element_ty,
                    span,
                    constant: ConstantValue {
                        literal: None,
                        is_discardable: discardable,
                        is_null_pointer_constant: false,
                    },
                }
                .into())
            }
            ExpressionValue::Reference(mut reference) => {
                reference.reference = match reference.reference {
                    Reference::Pointer(base) => Reference::Pointer(self.append(
                        Expression::Access {
                            base,
                            index: index.handle,
                        },
                        span,
                    )?),
                    Reference::Bound(handle) => {
                        Reference::Bound(self.project_bound_index(handle, index.handle, span)?)
                    }
                    Reference::PointerAccess(access) => {
                        let captured = self.freeze_reference_index(index.handle, index.span)?;
                        return self
                            .project_pointer_access(
                                access,
                                reference_bindings::AddressProjection::Index(captured),
                                &element_ty,
                                ConstantValue {
                                    literal: None,
                                    is_discardable: discardable,
                                    is_null_pointer_constant: false,
                                },
                                span,
                            )
                            .map(ExpressionValue::Reference);
                    }
                    Reference::Conditional(_) | Reference::Constant(_) => {
                        return self.fail("unsupported array reference");
                    }
                };
                reference.ty = element_ty;
                reference.span = span;
                reference.discard_read = true;
                reference.constant = ConstantValue {
                    literal: None,
                    is_discardable: discardable,
                    is_null_pointer_constant: false,
                };
                Ok(ExpressionValue::Reference(reference))
            }
            ExpressionValue::Pointer(_) => unreachable!(),
            ExpressionValue::NullPointer(value) => Err(ParseError {
                message: String::from("nullptr_t values cannot be indexed"),
                span: value.span,
            }),
        }
    }

    fn project_reference(
        &mut self,
        mut reference: ReferenceValue,
        index: u32,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<ReferenceValue, ParseError> {
        match reference.reference {
            Reference::PointerAccess(access) => {
                return self.project_pointer_access(
                    access,
                    reference_bindings::AddressProjection::Field(index),
                    ty,
                    ConstantValue {
                        literal: None,
                        is_null_pointer_constant: false,
                        ..reference.constant
                    },
                    span,
                );
            }
            Reference::Pointer(base) => {
                reference.reference =
                    Reference::Pointer(self.append(Expression::AccessIndex { base, index }, span)?);
            }
            Reference::Bound(handle) => {
                reference.reference = Reference::Bound(self.project_bound_reference(
                    handle,
                    reference_bindings::AddressProjection::Field(index),
                    span,
                )?);
            }
            Reference::Conditional(handle) => {
                let ConditionalReference {
                    condition,
                    constant_condition,
                    accept,
                    reject,
                    depth,
                } = self.function.conditional_references[handle].take().unwrap();
                let mut project = |branch: ReferenceBranch| -> Result<ReferenceBranch, ParseError> {
                    let (reference, body) = self.capture_block(|parser| {
                        parser.append_block(branch.body);
                        parser.project_reference(branch.reference, index, ty, span)
                    })?;
                    Ok(ReferenceBranch { body, reference })
                };
                let accept = project(accept)?;
                let reject = project(reject)?;
                self.function.conditional_references[handle] = Some(ConditionalReference {
                    condition,
                    constant_condition,
                    accept,
                    reject,
                    depth,
                });
            }
            Reference::Constant(_) => {
                return Err(ParseError {
                    message: String::from("constant has no supported fields"),
                    span,
                });
            }
        }
        reference.ty = ty.clone();
        reference.span = span;
        reference.discard_read = true;
        reference.constant.literal = None;
        Ok(reference)
    }

    pub(super) fn temporary_pointer(
        &mut self,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        if self.function.parameter_state_charged {
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<LocalVariable>(1, span)?;
        }
        let ty = self.type_handle(ty, span);
        let local = self.function.ir.local_variables.append(
            LocalVariable {
                name: None,
                ty,
                init: None,
            },
            span,
        );
        self.append(Expression::LocalVariable(local), span)
    }

    pub(super) fn reference_depth(&self, reference: &ReferenceValue) -> u32 {
        match reference.reference {
            Reference::Pointer(_)
            | Reference::PointerAccess(_)
            | Reference::Bound(_)
            | Reference::Constant(_) => 0,
            Reference::Conditional(handle) => {
                self.function.conditional_references[handle]
                    .as_ref()
                    .unwrap()
                    .depth
            }
        }
    }

    pub(super) fn rvalue(&mut self, expression: ExpressionValue) -> Result<Value, ParseError> {
        if matches!(
            *expression.shader_type()?.inner_with(&self.module.types),
            TypeInner::Array { .. }
        ) {
            return Err(ParseError {
                message: String::from("standalone array values and pointer decay are unsupported"),
                span: expression.span(),
            });
        }
        let reference = match expression {
            ExpressionValue::NullPointer(value) => {
                return Err(ParseError {
                    message: String::from("nullptr_t values cannot be used as shader values"),
                    span: value.span,
                })
            }
            ExpressionValue::Pointer(pointer) => {
                return Err(ParseError {
                    message: String::from(
                        "CUDA pointer values require a borrowed pointer operation",
                    ),
                    span: pointer.span,
                })
            }
            ExpressionValue::Plain(mut value) => {
                value.category = ValueCategory::Prvalue;
                value.qualifiers = self.prvalue_qualifiers(&value.ty, value.qualifiers);
                return Ok(value);
            }
            ExpressionValue::Reference(reference) => reference,
        };
        let ty = reference.ty.clone();
        let span = reference.span;
        let reference_volatile = reference.qualifiers.is_volatile;
        let qualifiers = self.prvalue_qualifiers(&ty, reference.qualifiers);
        self.require_volatile_scalar(reference.qualifiers, &ty, span)?;
        let constant = reference.constant;
        if !matches!(
            reference.reference,
            Reference::Conditional(_) | Reference::Bound(_)
        ) {
            return self.read_reference(reference);
        }
        let pointer = self.temporary_pointer(&ty, span)?;
        if matches!(reference.reference, Reference::Bound(binding) if self.function.bound_references[binding].is_nullable)
        {
            let ty = self.type_handle(&ty, span);
            let value = self.append(Expression::ZeroValue(ty), span)?;
            self.generated_pointer_statement(Statement::Store { pointer, value }, span)?;
        }
        self.consume_reference(reference, &mut |parser, source| {
            let span = source.span;
            let value = parser.read_reference(source)?;
            parser.push_statement(
                Statement::Store {
                    pointer,
                    value: value.handle,
                },
                span,
            );
            Ok(())
        })?;
        let handle = self.append(Expression::Load { pointer }, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers,
            handle,
            ty,
            span,
            constant: if reference_volatile {
                ConstantValue::default()
            } else {
                ConstantValue::evaluated(constant.literal)
            },
        })
    }

    fn read_reference(&mut self, reference: ReferenceValue) -> Result<Value, ParseError> {
        let span = reference.span;
        self.require_volatile_scalar(reference.qualifiers, &reference.ty, span)?;
        let handle = match reference.reference {
            Reference::PointerAccess(access) => {
                let pointer = self.validation_pointer(access, span)?;
                self.append(Expression::Load { pointer }, span)?
            }
            Reference::Pointer(pointer) => self.append(Expression::Load { pointer }, span)?,
            Reference::Constant(Some(handle)) => self.append(Expression::Constant(handle), span)?,
            Reference::Constant(None) => {
                // Unselected branches can reference the variable being initialized.
                let ty = self.type_handle(&reference.ty, span);
                self.append(Expression::ZeroValue(ty), span)?
            }
            Reference::Conditional(_) | Reference::Bound(_) => {
                return self.rvalue(ExpressionValue::Reference(reference))
            }
        };
        if reference.qualifiers.is_volatile {
            self.record_volatile_load(handle, span)?;
        }
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: self.prvalue_qualifiers(&reference.ty, reference.qualifiers),
            handle,
            ty: reference.ty,
            span,
            constant: if reference.qualifiers.is_volatile {
                ConstantValue::default()
            } else {
                ConstantValue::evaluated(reference.constant.literal)
            },
        })
    }

    pub(super) fn load_pointer(
        &mut self,
        pointer: Handle<Expression>,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<Value, ParseError> {
        let handle = self.append(Expression::Load { pointer }, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: ty.clone(),
            span,
            constant: ConstantValue::default(),
        })
    }

    pub(super) fn discard_result(&mut self, result: ExpressionResult) -> Result<(), ParseError> {
        if let ExpressionResult::Value(ExpressionValue::Reference(reference)) = result {
            if self.has_discarded_volatile_read(&reference) {
                self.rvalue(ExpressionValue::Reference(reference))?;
            } else {
                self.consume_reference(reference, &mut |_, _| Ok(()))?;
            }
        }
        Ok(())
    }

    pub(super) fn has_discarded_volatile_read(&self, reference: &ReferenceValue) -> bool {
        reference.qualifiers.is_volatile
            && reference.discard_read
            && !matches!(
                reference.ty.inner_with(&self.module.types),
                TypeInner::Array { .. }
            )
    }

    pub(super) fn decorate_reference(
        &mut self,
        reference: &mut ReferenceValue,
        action: &mut impl FnMut(
            &mut Self,
            Handle<Expression>,
            &TypeResolution,
            Span,
        ) -> Result<(), ParseError>,
    ) -> Result<(), ParseError> {
        let handle = match reference.reference {
            Reference::PointerAccess(access) => {
                let pointer = self.validation_pointer(access, reference.span)?;
                self.check_writable_pointer(pointer, reference.span)?;
                return action(self, pointer, &reference.ty, reference.span);
            }
            Reference::Pointer(pointer) => {
                self.check_writable_pointer(pointer, reference.span)?;
                return action(self, pointer, &reference.ty, reference.span);
            }
            Reference::Bound(handle) => {
                return self.consume_bound_reference(
                    handle,
                    reference.clone(),
                    &mut |parser, source| {
                        let Reference::Pointer(pointer) = source.reference else {
                            unreachable!()
                        };
                        parser.check_writable_pointer(pointer, source.span)?;
                        action(parser, pointer, &source.ty, source.span)
                    },
                );
            }
            Reference::Conditional(handle) => handle,
            Reference::Constant(_) => {
                return Err(ParseError {
                    message: String::from("cannot modify a const value"),
                    span: reference.span,
                })
            }
        };
        let mut conditional = self.function.conditional_references[handle].take().unwrap();
        for branch in [&mut conditional.accept, &mut conditional.reject] {
            branch.reference.qualifiers = reference.qualifiers;
            let ((), body) = self.capture_block(|parser| {
                parser.append_block(core::mem::take(&mut branch.body));
                parser.decorate_reference(&mut branch.reference, action)
            })?;
            branch.body = body;
        }
        self.function.conditional_references[handle] = Some(conditional);
        Ok(())
    }

    pub(super) fn consume_reference(
        &mut self,
        reference: ReferenceValue,
        action: &mut impl FnMut(&mut Self, ReferenceValue) -> Result<(), ParseError>,
    ) -> Result<(), ParseError> {
        let handle = match reference.reference {
            Reference::PointerAccess(access) => {
                let pointer = self.validation_pointer(access, reference.span)?;
                return action(
                    self,
                    ReferenceValue {
                        reference: Reference::Pointer(pointer),
                        ..reference
                    },
                );
            }
            Reference::Pointer(_) | Reference::Constant(_) => {
                return action(self, reference);
            }
            Reference::Bound(handle) => {
                return self.consume_bound_reference(handle, reference, action)
            }
            Reference::Conditional(handle) => handle,
        };
        let mut conditional = self.function.conditional_references[handle].take().unwrap();
        conditional.accept.reference.qualifiers = reference.qualifiers;
        conditional.reject.reference.qualifiers = reference.qualifiers;
        let ((), accept) = self.capture_block(|parser| {
            parser.append_block(conditional.accept.body);
            parser.consume_reference(conditional.accept.reference, action)
        })?;
        let ((), reject) = self.capture_block(|parser| {
            parser.append_block(conditional.reject.body);
            parser.consume_reference(conditional.reject.reference, action)
        })?;
        self.push_statement(
            Statement::If {
                condition: conditional.condition,
                accept,
                reject,
            },
            reference.span,
        );
        Ok(())
    }
}
