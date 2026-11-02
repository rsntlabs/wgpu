use super::pointers::{PointerState, PointerValue};
use super::*;

#[derive(Clone, Copy, Eq, PartialEq)]
pub(super) enum ParameterMode {
    Value,
    Reference { qualifiers: Qualifiers },
    Pointer { qualifiers: Qualifiers },
}

impl ParameterMode {
    pub(super) const fn is_indirect(self) -> bool {
        matches!(self, Self::Reference { .. } | Self::Pointer { .. })
    }
}

#[derive(Clone, Copy, Eq, PartialEq)]
pub(super) enum SourceParameter {
    Shader {
        ty: Handle<Type>,
        mode: ParameterMode,
    },
    ThreadBlock,
}

impl SourceParameter {
    pub(super) const fn shader_type(self) -> Option<Handle<Type>> {
        match self {
            Self::Shader { ty, .. } => Some(ty),
            Self::ThreadBlock => None,
        }
    }

    pub(super) const fn mode(self) -> ParameterMode {
        match self {
            Self::Shader { mode, .. } => mode,
            Self::ThreadBlock => ParameterMode::Value,
        }
    }
}

#[derive(Clone)]
pub(super) enum DeferredArgument {
    Value(Handle<Expression>),
    Reference(Handle<BoundReference>),
    Pointer(Box<PointerValue>),
}

#[derive(Clone)]
pub(super) enum MappedExpression {
    Value(Handle<Expression>),
    Reference {
        binding: Handle<BoundReference>,
        ty: TypeResolution,
    },
    Pointer(Box<PointerValue>),
}

#[derive(Clone)]
pub(super) struct DeferredCall {
    pub(super) function: Handle<Function>,
    pub(super) arguments: Vec<DeferredArgument>,
    pub(super) result_pointer: Option<Handle<Expression>>,
    pub(super) span: Span,
}

#[derive(Clone, Default)]
pub(super) struct FunctionParameterState {
    pub(super) expression_graph_depths: Vec<u32>,
    pub(super) deferred_calls: FastHashMap<Handle<Expression>, DeferredCall>,
    pub(super) bound_addresses: Arena<BoundAddress>,
    pub(super) bound_address_indices: FastHashMap<BoundAddress, Handle<BoundAddress>>,
    pub(super) bound_references: Arena<BoundReference>,
    pub(super) reference_binding_work: u32,
    pub(super) pointers: PointerState,
    pub(super) volatile_accesses: VolatileAccesses,
}

pub(super) struct CapturedArgument {
    pub(super) value: ExpressionResult,
    pub(super) body: crate::Block,
}

#[derive(Clone, Copy)]
pub(super) struct SourcePointerType {
    pub(super) pointee: Handle<Type>,
    pub(super) qualifiers: Qualifiers,
}

pub(super) trait CallArgument {
    fn ty(&self) -> Option<&TypeResolution>;
    fn is_thread_block(&self) -> bool;
    fn span(&self) -> Span;
    fn reference_qualifiers(&self) -> Option<Qualifiers>;
    fn value_qualifiers(&self) -> Option<Qualifiers>;
    fn pointer_type(&self, module: &Module) -> Option<SourcePointerType>;
    fn pointer_object_qualifiers(&self) -> Option<Qualifiers> {
        None
    }
    fn is_null_pointer_constant(&self) -> bool;
}

impl CallArgument for Value {
    fn ty(&self) -> Option<&TypeResolution> {
        Some(&self.ty)
    }
    fn is_thread_block(&self) -> bool {
        false
    }
    fn span(&self) -> Span {
        self.span
    }
    fn reference_qualifiers(&self) -> Option<Qualifiers> {
        None
    }
    fn value_qualifiers(&self) -> Option<Qualifiers> {
        Some(self.qualifiers)
    }
    fn pointer_type(&self, _module: &Module) -> Option<SourcePointerType> {
        None
    }
    fn is_null_pointer_constant(&self) -> bool {
        self.constant.is_null_pointer_constant
    }
}

impl CallArgument for CapturedArgument {
    fn ty(&self) -> Option<&TypeResolution> {
        match self.value {
            ExpressionResult::Value(ref value) => Some(value.ty()),
            ExpressionResult::ThreadBlock(_) | ExpressionResult::Void(_) => None,
        }
    }
    fn is_thread_block(&self) -> bool {
        matches!(self.value, ExpressionResult::ThreadBlock(_))
    }
    fn span(&self) -> Span {
        match self.value {
            ExpressionResult::Value(ref value) => value.span(),
            ExpressionResult::ThreadBlock(ref value) => value.span,
            ExpressionResult::Void(span) => span,
        }
    }
    fn reference_qualifiers(&self) -> Option<Qualifiers> {
        match self.value {
            ExpressionResult::Value(ExpressionValue::Reference(ref reference)) => {
                Some(reference.qualifiers)
            }
            _ => None,
        }
    }
    fn value_qualifiers(&self) -> Option<Qualifiers> {
        match self.value {
            ExpressionResult::Value(ExpressionValue::Plain(ref value)) => Some(value.qualifiers),
            _ => None,
        }
    }
    fn pointer_object_qualifiers(&self) -> Option<Qualifiers> {
        match self.value {
            ExpressionResult::Value(ExpressionValue::Pointer(ref pointer)) => {
                match pointer.category {
                    pointers::PointerValueCategory::Variable { writable, .. } => Some(Qualifiers {
                        is_const: !writable,
                        is_volatile: false,
                    }),
                    pointers::PointerValueCategory::Value { .. } => None,
                }
            }
            _ => None,
        }
    }
    fn is_null_pointer_constant(&self) -> bool {
        match self.value {
            ExpressionResult::Value(ExpressionValue::Plain(ref value)) => {
                value.constant.is_null_pointer_constant
            }
            _ => false,
        }
    }
    fn pointer_type(&self, module: &Module) -> Option<SourcePointerType> {
        match self.value {
            ExpressionResult::Value(ExpressionValue::Pointer(ref pointer)) => {
                match *pointer.ty.inner_with(&module.types) {
                    TypeInner::Pointer { base, .. } => Some(SourcePointerType {
                        pointee: base,
                        qualifiers: pointer.qualifiers,
                    }),
                    _ => None,
                }
            }
            ExpressionResult::Value(ExpressionValue::Reference(ref reference)) => {
                match *reference.ty.inner_with(&module.types) {
                    TypeInner::Array { base, .. } => Some(SourcePointerType {
                        pointee: base,
                        qualifiers: reference.qualifiers,
                    }),
                    _ => None,
                }
            }
            _ => None,
        }
    }
}

impl Parser<'_> {
    pub(super) fn activate_parameter_expansion(&mut self, span: Span) -> Result<(), ParseError> {
        if self.parameter_expansion_budget.activate() {
            self.parameter_expansion_budget
                .charge_slice::<Kernel<'_>>(self.kernels.len(), span)?;
            self.parameter_expansion_budget
                .charge_slice::<EntryPoint>(self.kernels.len(), span)?;
            self.parameter_expansion_budget
                .charge_work(self.kernels.len(), span)?;
            for entry in &self.module.entry_points {
                self.parameter_expansion_budget
                    .charge_bytes(entry.name.len(), span)?;
            }
            for declaration in self.function_declarations.values() {
                self.parameter_expansion_budget
                    .charge_slice::<SourceParameter>(declaration.parameters.len(), span)?;
            }
            self.parameter_expansion_budget
                .charge_slice::<SourceParameter>(self.function.parameters.len(), span)?;
        }
        Ok(())
    }

    pub(super) fn prepare_parameter_bindings(&mut self, span: Span) -> Result<(), ParseError> {
        if self.function.parameter_state_charged {
            return Ok(());
        }
        let budget = &mut self.parameter_expansion_budget;
        budget.charge_bytes(size_of::<FunctionParameterState>(), span)?;
        budget.charge_slice::<BoundAddress>(self.function.bound_addresses.len(), span)?;
        for (_, address) in self.function.bound_addresses.iter() {
            budget.charge_slice::<reference_bindings::AddressProjection>(
                address.projections.len(),
                span,
            )?;
        }
        budget.charge_map_entry::<BoundAddress, Handle<BoundAddress>>(
            self.function.bound_address_indices.len(),
            span,
        )?;
        for address in self.function.bound_address_indices.keys() {
            budget.charge_slice::<reference_bindings::AddressProjection>(
                address.projections.len(),
                span,
            )?;
        }
        budget.charge_slice::<BoundReference>(self.function.bound_references.len(), span)?;
        for (_, reference) in self.function.bound_references.iter() {
            budget
                .charge_slice::<reference_bindings::BoundTarget>(reference.targets.len(), span)?;
        }
        self.function.volatile_accesses.inventory(budget, span)?;
        self.function.parameter_state_charged = true;
        Ok(())
    }

    pub(super) fn parameter_state_needed(&self) -> bool {
        !self.function.deferred_calls.is_empty()
            || !self.function.pointers.is_empty()
            || !self.function.volatile_accesses.is_empty()
            || self
                .function
                .parameters
                .iter()
                .any(|parameter| parameter.mode().is_indirect())
    }

    pub(super) fn capture_call_argument(&mut self) -> Result<CapturedArgument, ParseError> {
        let span = self.lexer.peek()?.1;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<CapturedArgument>(1, span)?;
        let (value, body) = self.capture_block(|parser| parser.expression_result(0))?;
        if let ExpressionResult::Void(span) = value {
            return Err(ParseError {
                message: String::from("void expression cannot be used as an argument"),
                span,
            });
        }
        Ok(CapturedArgument { value, body })
    }

    pub(super) fn has_captured_candidate(&self, name: &str) -> bool {
        self.function_candidates(name).any(|candidate| {
            (0..self.candidate_arity(candidate)).any(|logical_index| {
                self.candidate_mode(candidate, logical_index).is_indirect()
                    || self.candidate_type(candidate, logical_index).is_none()
            })
        })
    }

    pub(super) fn call_with_captured_arguments(
        &mut self,
        name: &str,
        arguments: Vec<CapturedArgument>,
        name_span: Span,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.parameter_expansion_budget
            .charge_work(arguments.len(), span)?;
        let candidate = self.resolve_overload(name, &arguments, name_span)?;
        self.lower_captured_call(candidate, arguments, span)
    }

    pub(super) fn lower_captured_call(
        &mut self,
        candidate: functions::FunctionCandidate,
        arguments: Vec<CapturedArgument>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        if matches!(
            candidate,
            functions::FunctionCandidate::Atomic { .. }
                | functions::FunctionCandidate::AtomicCompareExchange(_)
                | functions::FunctionCandidate::WrappingAtomic(_)
        ) {
            return self.atomic_call(arguments, candidate, span);
        }
        let has_indirect_parameters =
            (0..arguments.len()).any(|index| self.candidate_mode(candidate, index).is_indirect());
        if !has_indirect_parameters {
            self.parameter_expansion_budget
                .charge_slice::<Value>(arguments.len(), span)?;
            let mut values = Vec::with_capacity(arguments.len());
            for (logical_index, argument) in arguments.into_iter().enumerate() {
                self.parameter_expansion_budget.charge_work(1, span)?;
                self.append_block(argument.body);
                let Some(target) = self.candidate_type(candidate, logical_index) else {
                    self.require_thread_block(argument.value)?;
                    continue;
                };
                values.push(self.convert_value(argument.value.require_value()?, &target)?);
            }
            return self.lower_call(candidate, values, span);
        }
        let functions::FunctionCandidate::Defined(function) = candidate else {
            unreachable!()
        };
        self.prepare_parameter_bindings(span)?;
        self.parameter_expansion_budget
            .charge_slice::<DeferredArgument>(arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<Expression>, DeferredCall>(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionCall>(1, span)?;
        let mut bound_arguments = Vec::with_capacity(arguments.len());
        for (logical_index, argument) in arguments.into_iter().enumerate() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            self.append_block(argument.body);
            let Some(target) = self.candidate_type(candidate, logical_index) else {
                self.require_thread_block(argument.value)?;
                continue;
            };
            let value = argument.value.require_value()?;
            let argument = match self.candidate_mode(candidate, logical_index) {
                ParameterMode::Value => {
                    DeferredArgument::Value(self.convert_value(value, &target)?.handle)
                }
                ParameterMode::Reference { qualifiers } => {
                    let reference = match value {
                        ExpressionValue::Reference(reference)
                            if self.module.compare_types(&reference.ty, &target) =>
                        {
                            reference
                        }
                        value => {
                            let value = self.convert_value(value, &target)?;
                            let pointer = self.temporary_pointer(&target, span)?;
                            self.push_statement(
                                Statement::Store {
                                    pointer,
                                    value: value.handle,
                                },
                                value.span,
                            );
                            ReferenceValue {
                                discard_read: true,
                                reference: Reference::Pointer(pointer),
                                qualifiers: Qualifiers::CONST,
                                ty: target,
                                span: value.span,
                                constant: ConstantValue::default(),
                            }
                        }
                    };
                    if !qualifiers.contains(reference.qualifiers) {
                        return self.fail("mutable reference requires a writable lvalue");
                    }
                    DeferredArgument::Reference(self.freeze_reference(reference)?)
                }
                ParameterMode::Pointer { qualifiers } => {
                    let pointer = self.convert_pointer(value, &target, qualifiers, span)?;
                    DeferredArgument::Pointer(self.boxed_pointer_value(pointer)?)
                }
            };
            bound_arguments.push(argument);
        }
        let result_ty = self.module.functions[function]
            .result
            .as_ref()
            .map(|result| TypeResolution::Handle(result.ty));
        let result_pointer = match result_ty.as_ref() {
            Some(ty) => Some(self.temporary_pointer(ty, span)?),
            None => None,
        };
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        // Keep a unique emitted identity until the deferred call is expanded.
        let (marker, body) = self.deferred_marker(span)?;
        self.function.calls.push(FunctionCall { function, span });
        self.function.deferred_calls.insert(
            marker,
            DeferredCall {
                function,
                arguments: bound_arguments,
                result_pointer,
                span,
            },
        );
        self.push_statement(Statement::Block(body), span);
        match (result_pointer, result_ty) {
            (Some(pointer), Some(ty)) => {
                let mut value = self.load_pointer(pointer, &ty, span)?;
                value.qualifiers = self.prvalue_qualifiers(
                    &ty,
                    self.function_declarations[&function].result_qualifiers,
                );
                Ok(value.into())
            }
            _ => Ok(ExpressionResult::Void(span)),
        }
    }

    pub(super) fn deferred_marker(
        &mut self,
        span: Span,
    ) -> Result<(Handle<Expression>, crate::Block), ParseError> {
        self.capture_block(|parser| {
            let zero = parser.append(Expression::Literal(Literal::U32(0)), span)?;
            parser.append(
                Expression::Binary {
                    op: BinaryOperator::Add,
                    left: zero,
                    right: zero,
                },
                span,
            )
        })
    }
}

impl FunctionContext<'_> {
    pub(super) fn take_parameter_state(&mut self) -> FunctionParameterState {
        FunctionParameterState {
            expression_graph_depths: core::mem::take(&mut self.expression_graph_depths),
            deferred_calls: core::mem::take(&mut self.deferred_calls),
            bound_addresses: core::mem::take(&mut self.bound_addresses),
            bound_address_indices: core::mem::take(&mut self.bound_address_indices),
            bound_references: core::mem::take(&mut self.bound_references),
            reference_binding_work: core::mem::take(&mut self.reference_binding_work),
            pointers: core::mem::take(&mut self.pointers),
            volatile_accesses: core::mem::take(&mut self.volatile_accesses),
        }
    }

    pub(super) fn install_parameter_state(&mut self, state: FunctionParameterState) {
        self.expression_graph_depths = state.expression_graph_depths;
        self.deferred_calls = state.deferred_calls;
        self.bound_addresses = state.bound_addresses;
        self.bound_address_indices = state.bound_address_indices;
        self.bound_references = state.bound_references;
        self.reference_binding_work = state.reference_binding_work;
        self.pointers = state.pointers;
        self.volatile_accesses = state.volatile_accesses;
        self.parameter_state_charged = true;
    }
}
