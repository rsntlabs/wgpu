use super::*;
use crate::front::atomic_upgrade::{StorageViews, Upgrades};
use crate::AtomicFunction;

mod storage;

pub(super) const INTEGER_ATOMICS: [(&str, AtomicFunction); 8] = [
    ("atomicAdd", AtomicFunction::Add),
    ("atomicSub", AtomicFunction::Subtract),
    ("atomicMin", AtomicFunction::Min),
    ("atomicMax", AtomicFunction::Max),
    ("atomicAnd", AtomicFunction::And),
    ("atomicOr", AtomicFunction::InclusiveOr),
    ("atomicXor", AtomicFunction::ExclusiveOr),
    ("atomicExch", AtomicFunction::Exchange { compare: None }),
];

pub(super) fn supports_integer_atomic(function: AtomicFunction) -> bool {
    INTEGER_ATOMICS
        .into_iter()
        .any(|(_, supported)| supported == function)
}

pub(super) struct AtomicStorage {
    original_globals: FastHashMap<Handle<GlobalVariable>, Handle<Type>>,
    views: StorageViews,
}

pub(super) fn atomic_error(span: Span) -> ParseError {
    ParseError {
        message: String::from(
            "integer atomic operation requires a writable storage or shared 32-bit integer",
        ),
        span,
    }
}

impl Parser<'_> {
    pub(super) fn atomic_binary(
        &mut self,
        arguments: Vec<CapturedArgument>,
        function: AtomicFunction,
        scalar: Scalar,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.has_atomics = true;
        let mut arguments = arguments.into_iter();
        let destination = arguments.next().ok_or_else(|| atomic_error(span))?;
        self.append_block(destination.body);
        let pointer = self.borrowed_pointer(destination.value)?;
        if pointer.is_const {
            return Err(atomic_error(span));
        }
        let mut reference = self.pointer_reference(pointer)?;
        let operand = arguments.next().ok_or_else(|| atomic_error(span))?;
        self.append_block(operand.body);
        let value = self.convert_scalar(operand.value, scalar)?;
        let ty = self.scalar_handle(scalar, span);
        let result_pointer = self.temporary_pointer(&scalar_resolution(scalar), span)?;
        self.decorate_reference(&mut reference, &mut |parser, pointer, _, span| {
            let result = parser.append_atomic_result(ty, span)?;
            parser.push_statement(
                Statement::Atomic {
                    pointer,
                    fun: function,
                    value: value.handle,
                    result: Some(result),
                },
                span,
            );
            parser.push_statement(
                Statement::Store {
                    pointer: result_pointer,
                    value: result,
                },
                span,
            );
            Ok(())
        })?;
        Ok(self
            .load_pointer(result_pointer, &scalar_resolution(scalar), span)?
            .into())
    }

    pub(super) fn upgrade_atomic_storage(&mut self) -> Result<(), ParseError> {
        if !self.has_atomics {
            return Ok(());
        }
        let span = self.lexer.span_from(0);
        let mut upgrades = Upgrades::default();
        let mut original_globals = FastHashMap::default();
        self.parameter_expansion_budget
            .charge_slice::<Handle<Function>>(self.module.functions.len(), span)?;
        let functions: Vec<_> = self
            .module
            .functions
            .iter()
            .map(|(handle, _)| handle)
            .collect();
        for &handle in &functions {
            let function = core::mem::take(&mut self.module.functions[handle]);
            self.collect_atomic_storage(&function, &mut upgrades, &mut original_globals, span)?;
            self.module.functions[handle] = function;
        }
        for index in 0..self.module.entry_points.len() {
            let function = core::mem::take(&mut self.module.entry_points[index].function);
            self.collect_atomic_storage(&function, &mut upgrades, &mut original_globals, span)?;
            self.module.entry_points[index].function = function;
        }
        if upgrades.is_empty() {
            return Ok(());
        }
        self.precharge_atomic_views(&original_globals, span)?;
        self.parameter_expansion_budget.charge_bytes(64, span)?;
        let views = self
            .module
            .upgrade_atomics_with_storage_views(&upgrades)
            .map_err(|error| ParseError {
                message: format!("unsupported CUDA atomic storage: {error}"),
                span,
            })?;
        self.atomic_storage = Some(AtomicStorage {
            original_globals,
            views,
        });
        for handle in functions {
            let function = core::mem::take(&mut self.module.functions[handle]);
            let function = self.rewrite_atomic_storage(function, span)?;
            self.module.functions[handle] = function;
        }
        for index in 0..self.module.entry_points.len() {
            let function = core::mem::take(&mut self.module.entry_points[index].function);
            self.module.entry_points[index].function =
                self.rewrite_atomic_storage(function, span)?;
        }
        self.atomic_storage = None;
        self.function = FunctionContext::new(FunctionKind::Kernel);
        Ok(())
    }

    fn rewrite_atomic_storage(
        &mut self,
        function: Function,
        span: Span,
    ) -> Result<Function, ParseError> {
        let mut affected = false;
        for (_, expression) in function.expressions.iter() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            if let Expression::GlobalVariable(global) = *expression {
                affected |= self
                    .atomic_storage
                    .as_ref()
                    .unwrap()
                    .original_globals
                    .contains_key(&global);
            }
        }
        if !affected {
            return Ok(function);
        }
        self.clone_parameter_function(
            function,
            FunctionParameterState::default(),
            Vec::new(),
            None,
            span,
        )?;
        Ok(core::mem::take(&mut self.function.ir))
    }

    fn collect_atomic_storage(
        &mut self,
        function: &Function,
        upgrades: &mut Upgrades,
        original_globals: &mut FastHashMap<Handle<GlobalVariable>, Handle<Type>>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_slice::<&crate::Block>(1, span)?;
        let mut pending = alloc::vec![&function.body];
        while let Some(block) = pending.pop() {
            for (statement, &span) in block.span_iter() {
                self.parameter_expansion_budget.charge_work(1, span)?;
                let mut child = |body| -> Result<(), ParseError> {
                    self.parameter_expansion_budget
                        .charge_slice::<&crate::Block>(1, span)?;
                    pending.push(body);
                    Ok(())
                };
                match *statement {
                    Statement::Block(ref body) => child(body)?,
                    Statement::If {
                        ref accept,
                        ref reject,
                        ..
                    } => {
                        child(accept)?;
                        child(reject)?;
                    }
                    Statement::Switch { ref cases, .. } => {
                        for case in cases {
                            child(&case.body)?;
                        }
                    }
                    Statement::Loop {
                        ref body,
                        ref continuing,
                        ..
                    } => {
                        child(body)?;
                        child(continuing)?;
                    }
                    Statement::Atomic { pointer, fun, .. } if supports_integer_atomic(fun) => {
                        let ty = self.record_atomic_storage(
                            function,
                            pointer,
                            upgrades,
                            original_globals,
                            0,
                            span,
                        )?;
                        if !matches!(
                            self.module.types[ty].inner,
                            TypeInner::Scalar(Scalar::I32 | Scalar::U32)
                        ) {
                            return Err(atomic_error(span));
                        }
                    }
                    Statement::Atomic { .. } => return Err(atomic_error(span)),
                    _ => {}
                }
            }
        }
        Ok(())
    }

    fn record_atomic_storage(
        &mut self,
        function: &Function,
        pointer: Handle<Expression>,
        upgrades: &mut Upgrades,
        original_globals: &mut FastHashMap<Handle<GlobalVariable>, Handle<Type>>,
        depth: u32,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        self.parameter_expansion_budget.charge_work(1, span)?;
        if depth > 64 {
            return Err(atomic_error(span));
        }
        match *function
            .expressions
            .try_get(pointer)
            .map_err(|_| atomic_error(span))?
        {
            Expression::GlobalVariable(global) => {
                let variable = &self.module.global_variables[global];
                match variable.space {
                    AddressSpace::Storage { access }
                        if access.contains(StorageAccess::LOAD | StorageAccess::STORE) => {}
                    AddressSpace::WorkGroup => {}
                    _ => return Err(atomic_error(span)),
                }
                if variable.init.is_some() {
                    return Err(atomic_error(span));
                }
                let ty = variable.ty;
                self.parameter_expansion_budget
                    .charge_map_entry::<Handle<GlobalVariable>, Handle<Type>>(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<usize>(self.module.global_variables.len(), span)?;
                original_globals.insert(global, ty);
                upgrades.insert_global(global);
                Ok(ty)
            }
            Expression::Access { base, .. } => {
                let ty = self.record_atomic_storage(
                    function,
                    base,
                    upgrades,
                    original_globals,
                    depth + 1,
                    span,
                )?;
                match self.module.types[ty].inner {
                    TypeInner::Array { base, .. } => Ok(base),
                    _ => Err(atomic_error(span)),
                }
            }
            Expression::AccessIndex { base, index } => {
                let ty = self.record_atomic_storage(
                    function,
                    base,
                    upgrades,
                    original_globals,
                    depth + 1,
                    span,
                )?;
                match self.module.types[ty].inner {
                    TypeInner::Struct { ref members, .. } => {
                        let field = members
                            .get(index as usize)
                            .ok_or_else(|| atomic_error(span))?
                            .ty;
                        self.parameter_expansion_budget
                            .charge_map_entry::<Handle<Type>, Vec<u32>>(1, span)?;
                        self.parameter_expansion_budget
                            .charge_slice::<usize>(members.len(), span)?;
                        upgrades.insert_field(ty, index as usize);
                        Ok(field)
                    }
                    TypeInner::Vector { size, scalar }
                        if index < size as u32 && matches!(scalar, Scalar::I32 | Scalar::U32) =>
                    {
                        self.parameter_expansion_budget
                            .charge_map_entry::<Handle<Type>, Vec<u32>>(1, span)?;
                        self.parameter_expansion_budget
                            .charge_slice::<usize>(4, span)?;
                        upgrades.insert_vector_component(ty, index as usize);
                        Ok(self.scalar_handle(scalar, span))
                    }
                    TypeInner::Array { base, .. } => Ok(base),
                    _ => Err(atomic_error(span)),
                }
            }
            _ => Err(atomic_error(span)),
        }
    }

    fn precharge_atomic_views(
        &mut self,
        original_globals: &FastHashMap<Handle<GlobalVariable>, Handle<Type>>,
        span: Span,
    ) -> Result<(), ParseError> {
        let budget = &mut self.parameter_expansion_budget;
        budget.charge_slice::<bool>(self.module.types.len(), span)?;
        let mut visited = alloc::vec![false; self.module.types.len()];
        budget.charge_slice::<Handle<Type>>(original_globals.len(), span)?;
        let mut pending: Vec<_> = original_globals.values().copied().collect();
        while let Some(handle) = pending.pop() {
            budget.charge_work(1, span)?;
            let seen = visited
                .get_mut(handle.index())
                .ok_or_else(|| atomic_error(span))?;
            if *seen {
                continue;
            }
            *seen = true;
            let ty = &self.module.types[handle];
            let members = match ty.inner {
                TypeInner::Struct { ref members, .. } => members.len(),
                TypeInner::Vector { size, .. } => size as usize,
                _ => 0,
            };
            budget.charge_work(members * 4 + 8, span)?;
            budget.charge_nodes(members + 4, span)?;
            budget.charge_slice::<(Type, Span)>(members + 4, span)?;
            budget.charge_map_entry::<Type, Handle<Type>>(members + 4, span)?;
            budget.charge_map_entry::<Handle<Type>, Handle<Type>>(4, span)?;
            budget.charge_map_entry::<Handle<Type>, Vec<u32>>(1, span)?;
            budget.charge_slice::<u32>(members, span)?;
            budget.charge_slice::<StructMember>(members * 3 + 1, span)?;
            budget.charge_bytes(ty.name.as_ref().map_or(0, String::len), span)?;
            match ty.inner {
                TypeInner::Struct {
                    ref members,
                    span: size,
                } => {
                    if size % 4 != 0 {
                        return Err(atomic_error(span));
                    }
                    for member in members {
                        if member.offset % 4 != 0 {
                            return Err(atomic_error(span));
                        }
                        budget
                            .charge_bytes(member.name.as_ref().map_or(0, String::len) * 2, span)?;
                        budget.charge_slice::<Handle<Type>>(1, span)?;
                        pending.push(member.ty);
                    }
                }
                TypeInner::Array { base, .. } => {
                    budget.charge_slice::<Handle<Type>>(1, span)?;
                    pending.push(base);
                }
                TypeInner::Vector { .. } => budget.charge_bytes(4, span)?,
                _ => {}
            }
        }
        Ok(())
    }
}
