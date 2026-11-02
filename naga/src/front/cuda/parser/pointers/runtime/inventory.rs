use super::*;

struct OriginAddress {
    root: OriginRoot,
    root_expression: Handle<Expression>,
    projections: Vec<OriginProjection>,
}

struct OriginAddresses {
    addresses: Vec<OriginAddress>,
    is_nullable: bool,
}

struct Inventory<'a> {
    function: &'a Function,
    source: &'a FunctionParameterState,
    families: Vec<OriginFamily>,
    cells: FastHashMap<Handle<LocalVariable>, Vec<RuntimeOrigin>>,
}

pub(super) fn writable_root(parser: &Parser<'_>, root: OriginRoot) -> bool {
    match root {
        OriginRoot::Local(_) => true,
        OriginRoot::Global(global) => match parser.module.global_variables[global].space {
            AddressSpace::Storage { access } => access.contains(StorageAccess::STORE),
            AddressSpace::WorkGroup | AddressSpace::Private => true,
            _ => false,
        },
    }
}

impl Inventory<'_> {
    fn depth(&self, parser: &mut Parser<'_>, depth: u32, span: Span) -> Result<(), ParseError> {
        parser.parameter_expansion_budget.charge_work(1, span)?;
        if depth > 64 {
            Err(runtime_error(span))
        } else {
            Ok(())
        }
    }

    fn clone_set(
        &self,
        parser: &mut Parser<'_>,
        values: &[RuntimeOrigin],
        span: Span,
    ) -> Result<Vec<RuntimeOrigin>, ParseError> {
        parser
            .parameter_expansion_budget
            .charge_slice::<RuntimeOrigin>(values.len(), span)?;
        parser
            .parameter_expansion_budget
            .charge_work(values.len(), span)?;
        Ok(values.to_vec())
    }

    fn union(
        &self,
        parser: &mut Parser<'_>,
        destination: &mut Vec<RuntimeOrigin>,
        values: &[RuntimeOrigin],
        span: Span,
    ) -> Result<bool, ParseError> {
        let mut changed = false;
        for &value in values {
            parser
                .parameter_expansion_budget
                .charge_work(destination.len() + 1, span)?;
            if !destination.contains(&value) {
                parser
                    .parameter_expansion_budget
                    .charge_slice::<RuntimeOrigin>(1, span)?;
                destination.push(value);
                changed = true;
            }
        }
        Ok(changed)
    }

    fn binding_cells(
        &self,
        parser: &mut Parser<'_>,
        binding: Handle<BoundReference>,
        span: Span,
    ) -> Result<Vec<Handle<LocalVariable>>, ParseError> {
        let reference = self
            .source
            .bound_references
            .try_get(binding)
            .map_err(|_| runtime_error(span))?;
        parser
            .parameter_expansion_budget
            .charge_slice::<Handle<LocalVariable>>(reference.targets.len(), span)?;
        let mut cells = Vec::with_capacity(reference.targets.len());
        for target in &reference.targets {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            let address = self
                .source
                .bound_addresses
                .try_get(target.address)
                .map_err(|_| runtime_error(span))?;
            if !address.projections.is_empty() {
                return Err(runtime_error(span));
            }
            let expression = self
                .function
                .expressions
                .try_get(address.root)
                .map_err(|_| runtime_error(span))?;
            let Expression::LocalVariable(local) = *expression else {
                return Err(runtime_error(span));
            };
            let cell = self
                .source
                .pointers
                .cells
                .get(&local)
                .ok_or_else(|| runtime_error(span))?;
            if !matches!(cell.kind, PointerCellKind::Object { .. }) {
                return Err(runtime_error(span));
            }
            cells.push(local);
        }
        if cells.is_empty() {
            return Err(runtime_error(span));
        }
        Ok(cells)
    }

    fn binding_families(
        &self,
        parser: &mut Parser<'_>,
        binding: Handle<BoundReference>,
        span: Span,
    ) -> Result<Vec<RuntimeOrigin>, ParseError> {
        let mut result = Vec::new();
        for local in self.binding_cells(parser, binding, span)? {
            let families = self.cells.get(&local).ok_or_else(|| runtime_error(span))?;
            self.union(parser, &mut result, families, span)?;
        }
        Ok(result)
    }

    fn add_cell_families(
        &mut self,
        parser: &mut Parser<'_>,
        destination: Handle<LocalVariable>,
        values: &[RuntimeOrigin],
        value_qualifiers: Qualifiers,
        span: Span,
    ) -> Result<bool, ParseError> {
        let cell = self
            .source
            .pointers
            .cells
            .get(&destination)
            .ok_or_else(|| runtime_error(span))?;
        if !cell.qualifiers.contains(value_qualifiers) {
            return Err(runtime_error(span));
        }
        for &origin in values {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            let RuntimeOrigin::Family(family) = origin else {
                continue;
            };
            let family = self
                .families
                .get(family as usize)
                .ok_or_else(|| runtime_error(span))?;
            if family.pointee != cell.pointee
                || (!cell.qualifiers.is_const && !writable_root(parser, family.root))
            {
                return Err(runtime_error(span));
            }
        }
        let mut current = self
            .cells
            .remove(&destination)
            .ok_or_else(|| runtime_error(span))?;
        let changed = self.union(parser, &mut current, values, span)?;
        self.cells.insert(destination, current);
        Ok(changed)
    }

    fn root_type(
        &self,
        parser: &Parser<'_>,
        root: OriginRoot,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        match root {
            OriginRoot::Local(local) => self
                .function
                .local_variables
                .try_get(local)
                .map(|local| local.ty)
                .map_err(|_| runtime_error(span)),
            OriginRoot::Global(global) => parser
                .module
                .global_variables
                .try_get(global)
                .map(|global| global.ty)
                .map_err(|_| runtime_error(span)),
        }
    }

    fn projected_type(
        &self,
        parser: &mut Parser<'_>,
        ty: Handle<Type>,
        projection: OriginProjection,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        match parser.module.types[ty].inner {
            TypeInner::Array { base, .. } => Ok(base),
            TypeInner::Vector { scalar, .. } => {
                Ok(parser.type_handle(&scalar_resolution(scalar), span))
            }
            TypeInner::Struct { ref members, .. } => match projection {
                OriginProjection::Field(index) => members
                    .get(index as usize)
                    .map(|member| member.ty)
                    .ok_or_else(|| runtime_error(span)),
                OriginProjection::Index => Err(runtime_error(span)),
            },
            _ => Err(runtime_error(span)),
        }
    }

    fn intern(
        &mut self,
        parser: &mut Parser<'_>,
        mut address: OriginAddress,
        is_array: bool,
        pointee: Handle<Type>,
        span: Span,
    ) -> Result<u32, ParseError> {
        let mut ty = self.root_type(parser, address.root, span)?;
        let mut last_parent = None;
        for &projection in &address.projections {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            last_parent = Some(ty);
            ty = self.projected_type(parser, ty, projection, span)?;
        }
        let kind = if is_array {
            let TypeInner::Array { base, .. } = parser.module.types[ty].inner else {
                return Err(runtime_error(span));
            };
            if base != pointee {
                return Err(runtime_error(span));
            }
            OriginKind::Array
        } else {
            if ty != pointee {
                return Err(runtime_error(span));
            }
            if last_parent.is_some_and(|parent| {
                matches!(parser.module.types[parent].inner, TypeInner::Array { .. })
            }) {
                address.projections.pop();
                OriginKind::Array
            } else {
                OriginKind::Object
            }
        };
        for (index, family) in self.families.iter().enumerate() {
            parser
                .parameter_expansion_budget
                .charge_work(address.projections.len() + 1, span)?;
            if family.root == address.root
                && family.kind == kind
                && family.pointee == pointee
                && family.projections == address.projections
            {
                return u32::try_from(index).map_err(|_| runtime_error(span));
            }
        }
        parser.parameter_expansion_budget.charge_nodes(1, span)?;
        parser
            .parameter_expansion_budget
            .charge_slice::<OriginFamily>(1, span)?;
        let tag = u32::try_from(self.families.len()).map_err(|_| runtime_error(span))?;
        self.families.push(OriginFamily {
            root: address.root,
            root_expression: address.root_expression,
            projections: address.projections,
            kind,
            pointee,
        });
        Ok(tag)
    }

    fn append_projections(
        &self,
        parser: &mut Parser<'_>,
        address: &mut OriginAddress,
        projections: &[AddressProjection],
        span: Span,
    ) -> Result<(), ParseError> {
        parser
            .parameter_expansion_budget
            .charge_slice::<OriginProjection>(projections.len(), span)?;
        parser
            .parameter_expansion_budget
            .charge_work(projections.len(), span)?;
        address
            .projections
            .extend(projections.iter().map(|projection| match *projection {
                AddressProjection::Field(index) => OriginProjection::Field(index),
                AddressProjection::Index(_) => OriginProjection::Index,
            }));
        Ok(())
    }

    fn address(
        &mut self,
        parser: &mut Parser<'_>,
        handle: Handle<BoundAddress>,
        depth: u32,
        span: Span,
    ) -> Result<OriginAddresses, ParseError> {
        self.depth(parser, depth, span)?;
        let source = self.source;
        let address = source
            .bound_addresses
            .try_get(handle)
            .map_err(|_| runtime_error(span))?;
        let mut is_nullable = false;
        let mut result = match self.function.expressions[address.root] {
            Expression::LocalVariable(local) => {
                if let Some(&access) = source.pointers.validation_addresses.get(&local) {
                    let access = source
                        .pointers
                        .accesses
                        .try_get(access)
                        .map_err(|_| runtime_error(span))?;
                    let families =
                        self.expression(parser, access.pointer.expression, depth + 2, span)?;
                    parser
                        .parameter_expansion_budget
                        .charge_slice::<OriginAddress>(families.len(), span)?;
                    let mut views = Vec::with_capacity(families.len());
                    for origin in families {
                        let RuntimeOrigin::Family(family) = origin else {
                            is_nullable = true;
                            continue;
                        };
                        let family = &self.families[family as usize];
                        let extra = usize::from(family.kind == OriginKind::Array);
                        parser
                            .parameter_expansion_budget
                            .charge_slice::<OriginProjection>(
                                family.projections.len() + extra,
                                span,
                            )?;
                        let mut view = OriginAddress {
                            root: family.root,
                            root_expression: family.root_expression,
                            projections: family.projections.clone(),
                        };
                        if family.kind == OriginKind::Array {
                            view.projections.push(OriginProjection::Index);
                        }
                        self.append_projections(parser, &mut view, &access.projections, span)?;
                        views.push(view);
                    }
                    views
                } else {
                    if source.pointers.cells.contains_key(&local) {
                        return Err(runtime_error(span));
                    }
                    parser
                        .parameter_expansion_budget
                        .charge_slice::<OriginAddress>(1, span)?;
                    alloc::vec![OriginAddress {
                        root: OriginRoot::Local(local),
                        root_expression: address.root,
                        projections: Vec::new()
                    }]
                }
            }
            Expression::GlobalVariable(global) => {
                parser
                    .parameter_expansion_budget
                    .charge_slice::<OriginAddress>(1, span)?;
                alloc::vec![OriginAddress {
                    root: OriginRoot::Global(global),
                    root_expression: address.root,
                    projections: Vec::new()
                }]
            }
            _ => return Err(runtime_error(span)),
        };
        for view in &mut result {
            self.append_projections(parser, view, &address.projections, span)?;
        }
        Ok(OriginAddresses {
            addresses: result,
            is_nullable,
        })
    }

    fn expression(
        &mut self,
        parser: &mut Parser<'_>,
        handle: Handle<PointerExpression>,
        depth: u32,
        span: Span,
    ) -> Result<Vec<RuntimeOrigin>, ParseError> {
        self.depth(parser, depth, span)?;
        let source = self.source;
        let expression = source
            .pointers
            .expressions
            .try_get(handle)
            .map_err(|_| runtime_error(span))?;
        match expression.kind {
            PointerExpressionKind::Null => self.clone_set(parser, &[RuntimeOrigin::Null], span),
            PointerExpressionKind::Parameter(_) => Err(runtime_error(span)),
            PointerExpressionKind::Object(binding) => self.binding_families(parser, binding, span),
            PointerExpressionKind::Snapshot(local) => {
                let values = self.cells.get(&local).ok_or_else(|| runtime_error(span))?;
                self.clone_set(parser, values, span)
            }
            PointerExpressionKind::Offset { base, .. } => {
                self.expression(parser, base, depth + 1, span)
            }
            PointerExpressionKind::Select { accept, reject, .. } => {
                let mut result = self.expression(parser, accept, depth + 1, span)?;
                let reject = self.expression(parser, reject, depth + 1, span)?;
                self.union(parser, &mut result, &reject, span)?;
                Ok(result)
            }
            PointerExpressionKind::Array(binding) | PointerExpressionKind::Address(binding) => {
                let is_array = matches!(expression.kind, PointerExpressionKind::Array(_));
                let reference = source
                    .bound_references
                    .try_get(binding)
                    .map_err(|_| runtime_error(span))?;
                let mut result = Vec::new();
                if reference.is_nullable {
                    self.union(parser, &mut result, &[RuntimeOrigin::Null], span)?;
                }
                for target in &reference.targets {
                    let addresses = self.address(parser, target.address, depth, span)?;
                    if addresses.is_nullable {
                        self.union(parser, &mut result, &[RuntimeOrigin::Null], span)?;
                    }
                    for address in addresses.addresses {
                        let family =
                            self.intern(parser, address, is_array, expression.pointee, span)?;
                        self.union(parser, &mut result, &[RuntimeOrigin::Family(family)], span)?;
                    }
                }
                Ok(result)
            }
        }
    }

    fn operation(
        &mut self,
        parser: &mut Parser<'_>,
        operation: &PointerOperation,
        span: Span,
    ) -> Result<bool, ParseError> {
        match *operation {
            PointerOperation::Test { .. } => Ok(false),
            PointerOperation::Initialize {
                destination,
                ref value,
            } => {
                let cell = self
                    .source
                    .pointers
                    .cells
                    .get(&destination)
                    .ok_or_else(|| runtime_error(span))?;
                if !matches!(cell.kind, PointerCellKind::Object { .. }) {
                    return Err(runtime_error(span));
                }
                let families = self.expression(parser, value.expression, 1, span)?;
                self.add_cell_families(parser, destination, &families, value.qualifiers, span)
            }
            PointerOperation::Assign {
                destination,
                ref value,
            } => {
                let families = self.expression(parser, value.expression, 1, span)?;
                let mut changed = false;
                for destination in self.binding_cells(parser, destination, span)? {
                    if !matches!(
                        self.source.pointers.cells[&destination].kind,
                        PointerCellKind::Object { writable: true }
                    ) {
                        return Err(runtime_error(span));
                    }
                    changed |= self.add_cell_families(
                        parser,
                        destination,
                        &families,
                        value.qualifiers,
                        span,
                    )?;
                }
                Ok(changed)
            }
            PointerOperation::Capture {
                destination,
                source,
            } => {
                let cell = self
                    .source
                    .pointers
                    .cells
                    .get(&destination)
                    .ok_or_else(|| runtime_error(span))?;
                if cell.kind != PointerCellKind::Snapshot {
                    return Err(runtime_error(span));
                }
                for source in self.binding_cells(parser, source, span)? {
                    let actual = &self.source.pointers.cells[&source];
                    if actual.pointee != cell.pointee
                        || !cell.qualifiers.contains(actual.qualifiers)
                    {
                        return Err(runtime_error(span));
                    }
                }
                let families = self.binding_families(parser, source, span)?;
                self.add_cell_families(parser, destination, &families, Qualifiers::NONE, span)
            }
            PointerOperation::Update { destination, .. } => {
                for local in self.binding_cells(parser, destination, span)? {
                    if !matches!(
                        self.source.pointers.cells[&local].kind,
                        PointerCellKind::Object { writable: true }
                    ) {
                        return Err(runtime_error(span));
                    }
                }
                Ok(false)
            }
        }
    }
}

pub(super) fn build(
    parser: &mut Parser<'_>,
    function: &Function,
    source: &FunctionParameterState,
    span: Span,
) -> Result<PointerRuntime, ParseError> {
    if source.pointers.immutable.is_some() || source.pointers.runtime.is_some() {
        return Err(runtime_error(span));
    }
    parser
        .parameter_expansion_budget
        .charge_map_entry::<Handle<LocalVariable>, Vec<RuntimeOrigin>>(
            source.pointers.cells.len(),
            span,
        )?;
    let mut cells = FastHashMap::default();
    for &local in source.pointers.cells.keys() {
        cells.insert(local, Vec::new());
    }
    let mut inventory = Inventory {
        function,
        source,
        families: Vec::new(),
        cells,
    };
    let count = source.pointers.expressions.len();
    parser
        .parameter_expansion_budget
        .charge_slice::<Vec<RuntimeOrigin>>(count, span)?;
    let mut expression_families: Vec<Vec<RuntimeOrigin>> = (0..count).map(|_| Vec::new()).collect();
    loop {
        for (handle, _) in source.pointers.expressions.iter() {
            expression_families[handle.index()] = inventory.expression(parser, handle, 1, span)?;
        }
        let mut changed = false;
        for (marker, operation) in &source.pointers.operations {
            parser.parameter_expansion_budget.charge_work(1, span)?;
            changed |=
                inventory.operation(parser, operation, function.expressions.get_span(*marker))?;
        }
        if !changed {
            break;
        }
    }
    let coordinate_count = inventory
        .families
        .iter()
        .map(|family| {
            family
                .projections
                .iter()
                .filter(|projection| **projection == OriginProjection::Index)
                .count()
        })
        .max()
        .unwrap_or(0);
    let width = coordinate_count
        .checked_add(2)
        .and_then(|width| u32::try_from(width).ok())
        .and_then(core::num::NonZeroU32::new)
        .ok_or_else(|| runtime_error(span))?;
    let base = parser.type_handle(&scalar_resolution(Scalar::U32), span);
    parser.parameter_expansion_budget.charge_nodes(1, span)?;
    parser
        .parameter_expansion_budget
        .charge_bytes(size_of::<Type>(), span)?;
    let state_type = parser.module.types.insert(
        Type {
            name: None,
            inner: TypeInner::Array {
                base,
                size: ArraySize::Constant(width),
                stride: 4,
            },
        },
        span,
    );
    Ok(PointerRuntime {
        state_type,
        families: inventory.families,
        expression_families,
        cell_families: inventory.cells,
        coordinate_count,
    })
}
