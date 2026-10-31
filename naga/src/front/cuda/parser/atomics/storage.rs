use super::*;

struct StorageAddress {
    source: TypeResolution,
    storage: TypeResolution,
}

impl Parser<'_> {
    fn atomic_storage_address(
        &mut self,
        function: &Function,
        pointer: Handle<Expression>,
        depth: u32,
        span: Span,
    ) -> Result<Option<StorageAddress>, ParseError> {
        let Some(storage) = self.atomic_storage.as_ref() else {
            return Ok(None);
        };
        if depth > 64 {
            return Err(atomic_error(span));
        }
        self.parameter_expansion_budget.charge_work(1, span)?;
        match *function
            .expressions
            .try_get(pointer)
            .map_err(|_| atomic_error(span))?
        {
            Expression::GlobalVariable(global) => {
                Ok(storage
                    .original_globals
                    .get(&global)
                    .map(|&source| StorageAddress {
                        source: TypeResolution::Handle(source),
                        storage: TypeResolution::Handle(self.module.global_variables[global].ty),
                    }))
            }
            Expression::AccessIndex { base, index } => {
                let Some(address) = self.atomic_storage_address(function, base, depth + 1, span)?
                else {
                    return Ok(None);
                };
                let mapped = self.storage_field_index(&address, index, span)?;
                Ok(Some(StorageAddress {
                    source: self.storage_projected_type(&address.source, Some(index), span)?,
                    storage: self.storage_projected_type(&address.storage, Some(mapped), span)?,
                }))
            }
            Expression::Access { base, .. } => {
                let Some(address) = self.atomic_storage_address(function, base, depth + 1, span)?
                else {
                    return Ok(None);
                };
                Ok(Some(StorageAddress {
                    source: self.storage_projected_type(&address.source, None, span)?,
                    storage: self.storage_projected_type(&address.storage, None, span)?,
                }))
            }
            _ => Ok(None),
        }
    }

    fn storage_projected_type(
        &self,
        ty: &TypeResolution,
        index: Option<u32>,
        span: Span,
    ) -> Result<TypeResolution, ParseError> {
        match *ty.inner_with(&self.module.types) {
            TypeInner::Struct { ref members, .. } => index
                .and_then(|index| members.get(index as usize))
                .map(|member| TypeResolution::Handle(member.ty))
                .ok_or_else(|| atomic_error(span)),
            TypeInner::Array { base, .. } => Ok(TypeResolution::Handle(base)),
            TypeInner::Vector { size, scalar }
                if index.is_some_and(|index| index < size as u32) =>
            {
                Ok(scalar_resolution(scalar))
            }
            _ => Err(atomic_error(span)),
        }
    }

    fn storage_field_index(
        &self,
        address: &StorageAddress,
        index: u32,
        span: Span,
    ) -> Result<u32, ParseError> {
        if self.module.compare_types(&address.source, &address.storage) {
            return Ok(index);
        }
        match *address.source.inner_with(&self.module.types) {
            TypeInner::Array { .. } => Ok(index),
            TypeInner::Struct { .. } | TypeInner::Vector { .. } => {
                let TypeResolution::Handle(storage) = address.storage else {
                    return Err(atomic_error(span));
                };
                let plan = self
                    .atomic_storage
                    .as_ref()
                    .ok_or_else(|| atomic_error(span))?;
                if address.source.handle() != plan.views.source_type(storage) {
                    return Err(atomic_error(span));
                }
                plan.views
                    .field_index(storage, index)
                    .ok_or_else(|| atomic_error(span))
            }
            _ => Err(atomic_error(span)),
        }
    }

    pub(in super::super) fn atomic_storage_field(
        &mut self,
        function: &Function,
        base: Handle<Expression>,
        index: u32,
        span: Span,
    ) -> Result<u32, ParseError> {
        match self.atomic_storage_address(function, base, 0, span)? {
            Some(address) => self.storage_field_index(&address, index, span),
            None => Ok(index),
        }
    }

    pub(in super::super) fn load_atomic_storage(
        &mut self,
        function: &Function,
        source_pointer: Handle<Expression>,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<Option<Handle<Expression>>, ParseError> {
        let Some(address) = self.atomic_storage_address(function, source_pointer, 0, span)? else {
            return Ok(None);
        };
        if self.module.compare_types(&address.source, &address.storage)
            || matches!(
                *address.storage.inner_with(&self.module.types),
                TypeInner::Atomic(_)
            )
        {
            return Ok(None);
        }
        self.load_storage_value(pointer, address, 0, span).map(Some)
    }

    pub(in super::super) fn store_atomic_storage(
        &mut self,
        function: &Function,
        source_pointer: Handle<Expression>,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<bool, ParseError> {
        let Some(address) = self.atomic_storage_address(function, source_pointer, 0, span)? else {
            return Ok(false);
        };
        if self.module.compare_types(&address.source, &address.storage)
            || matches!(
                *address.storage.inner_with(&self.module.types),
                TypeInner::Atomic(_)
            )
        {
            return Ok(false);
        }
        self.store_storage_value(pointer, value, address, 0, span)?;
        Ok(true)
    }

    fn storage_component_count(&self, ty: &TypeResolution, span: Span) -> Result<u32, ParseError> {
        match *ty.inner_with(&self.module.types) {
            TypeInner::Struct { ref members, .. } => {
                u32::try_from(members.len()).map_err(|_| atomic_error(span))
            }
            TypeInner::Vector { size, .. } => Ok(size as u32),
            TypeInner::Array {
                size: ArraySize::Constant(count),
                ..
            } => Ok(count.get()),
            _ => Err(atomic_error(span)),
        }
    }

    fn storage_component(
        &self,
        address: &StorageAddress,
        index: u32,
        span: Span,
    ) -> Result<(u32, StorageAddress), ParseError> {
        let mapped = self.storage_field_index(address, index, span)?;
        Ok((
            mapped,
            StorageAddress {
                source: self.storage_projected_type(&address.source, Some(index), span)?,
                storage: self.storage_projected_type(&address.storage, Some(mapped), span)?,
            },
        ))
    }

    fn load_storage_value(
        &mut self,
        pointer: Handle<Expression>,
        address: StorageAddress,
        depth: u32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.parameter_expansion_budget.charge_work(1, span)?;
        if self.module.compare_types(&address.source, &address.storage)
            || matches!(
                *address.storage.inner_with(&self.module.types),
                TypeInner::Atomic(_)
            )
        {
            return self.append(Expression::Load { pointer }, span);
        }
        if depth > 64 {
            return Err(atomic_error(span));
        }
        let count = self.storage_component_count(&address.source, span)?;
        self.parameter_expansion_budget
            .charge_nodes(count as usize, span)?;
        self.parameter_expansion_budget
            .charge_work(count as usize, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(count as usize, span)?;
        let mut components = Vec::with_capacity(count as usize);
        for index in 0..count {
            let (mapped, child) = self.storage_component(&address, index, span)?;
            let pointer = self.append(
                Expression::AccessIndex {
                    base: pointer,
                    index: mapped,
                },
                span,
            )?;
            components.push(self.load_storage_value(pointer, child, depth + 1, span)?);
        }
        let ty = self.type_handle(&address.source, span);
        self.append(Expression::Compose { ty, components }, span)
    }

    fn store_storage_value(
        &mut self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        address: StorageAddress,
        depth: u32,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_work(1, span)?;
        if self.module.compare_types(&address.source, &address.storage)
            || matches!(
                *address.storage.inner_with(&self.module.types),
                TypeInner::Atomic(_)
            )
        {
            return self.generated_statement(Statement::Store { pointer, value }, span);
        }
        if depth > 64 {
            return Err(atomic_error(span));
        }
        let count = self.storage_component_count(&address.source, span)?;
        self.parameter_expansion_budget
            .charge_nodes(count as usize, span)?;
        self.parameter_expansion_budget
            .charge_work(count as usize, span)?;
        for index in 0..count {
            let (mapped, child) = self.storage_component(&address, index, span)?;
            let pointer = self.append(
                Expression::AccessIndex {
                    base: pointer,
                    index: mapped,
                },
                span,
            )?;
            let component = self.append(Expression::AccessIndex { base: value, index }, span)?;
            self.store_storage_value(pointer, component, child, depth + 1, span)?;
        }
        Ok(())
    }
}
