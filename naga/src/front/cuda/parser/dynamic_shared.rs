use super::*;
use core::num::NonZeroU32;

#[derive(Clone, Copy, Debug, PartialEq)]
pub(super) struct DynamicSharedDeclaration {
    element: Handle<Type>,
    count: NonZeroU32,
    qualifiers: Qualifiers,
}

#[derive(Default)]
pub(super) struct DynamicShared<'a> {
    declarations: FastHashMap<&'a str, DynamicSharedDeclaration>,
    globals: FastHashMap<Handle<Type>, Handle<GlobalVariable>>,
    elements: FastHashMap<Handle<GlobalVariable>, Handle<Type>>,
}

fn shared_error(message: &str, span: Span) -> ParseError {
    ParseError {
        message: String::from(message),
        span,
    }
}

fn charge_call_global_uses(
    function: &Function,
    budget: &mut parameter_expansion::ExpansionBudget,
    globals: usize,
    span: Span,
) -> Result<(), ParseError> {
    budget.charge_slice::<&crate::Block>(1, span)?;
    let mut pending = alloc::vec![&function.body];
    while let Some(block) = pending.pop() {
        for (statement, span) in block.span_iter() {
            budget.charge_work(1, *span)?;
            let mut child = |body| -> Result<(), ParseError> {
                budget.charge_work(1, *span)?;
                budget.charge_slice::<&crate::Block>(1, *span)?;
                pending.push(body);
                Ok(())
            };
            match *statement {
                Statement::Call { .. } => budget.charge_work(globals, *span)?,
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
                _ => {}
            }
        }
    }
    Ok(())
}

impl<'a> Parser<'a> {
    pub(super) fn starts_dynamic_shared_declaration(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        match lexer.next()?.0 {
            Token::Word("extern") => Ok(!matches!(lexer.peek()?.0, Token::String("C"))),
            Token::Word("__shared__") => loop {
                match lexer.peek()?.0 {
                    Token::Word("extern") => return Ok(true),
                    Token::Word(
                        "__shared__" | "const" | "volatile" | "int" | "short" | "signed"
                        | "unsigned",
                    ) => {}
                    Token::Word(name) if self.type_name(name).is_some() => {}
                    _ => return Ok(false),
                }
                lexer.next()?;
            },
            _ => Ok(false),
        }
    }

    pub(super) fn dynamic_shared_declaration(&mut self, global: bool) -> Result<(), ParseError> {
        let span = self.lexer.peek()?.1;
        self.activate_parameter_expansion(span)?;
        let mut has_extern = false;
        let mut has_shared = false;
        let mut qualified = None;
        loop {
            match self.lexer.peek()?.0 {
                Token::Word("extern") => {
                    if has_extern {
                        return self.fail("duplicate extern specifier");
                    }
                    has_extern = true;
                }
                Token::Word("__shared__") => {
                    if has_shared {
                        return self.fail("duplicate shared specifier");
                    }
                    has_shared = true;
                }
                _ if qualified.is_none() => {
                    qualified = Some(self.parse_type()?);
                    continue;
                }
                _ => break,
            }
            self.lexer.next()?;
        }
        if !has_extern || !has_shared {
            return Err(shared_error(
                "dynamic shared arrays require extern and __shared__",
                span,
            ));
        }
        let qualified = qualified.unwrap();
        if qualified.qualifiers.is_const || matches!(qualified.ty, TypeSpecifier::Pointer { .. }) {
            return Err(shared_error(
                "dynamic shared arrays require a non-const supported value type",
                span,
            ));
        }
        let resolution = self.lower_type(qualified.ty, span)?;
        let base = self.type_handle(&resolution, span);
        loop {
            let (name, name_span) = self.identifier()?;
            self.check_name(name, name_span)?;
            self.lexer.expect_span(Token::Paren('['))?;
            let array = self.array_declaration(base, true, name_span)?;
            if array.count.is_some() {
                return Err(shared_error(
                    "dynamic shared arrays require an incomplete outer dimension",
                    name_span,
                ));
            }
            let mut declaration = self.dynamic_shared_layout(array.element_ty, name_span)?;
            declaration.qualifiers = qualified.qualifiers;
            self.declare_dynamic_shared(name, declaration, global, name_span)?;
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    fn dynamic_shared_layout(
        &mut self,
        element: Handle<Type>,
        span: Span,
    ) -> Result<DynamicSharedDeclaration, ParseError> {
        if !self.numeric_storage_type(element, span)? {
            return Err(shared_error(
                "dynamic shared arrays require numeric scalars, vectors, or POD records",
                span,
            ));
        }
        self.parameter_expansion_budget
            .charge_work(self.module.types.len(), span)?;
        self.layouter
            .update(self.module.to_ctx())
            .map_err(|error| ParseError {
                message: format!("invalid dynamic shared layout: {error}"),
                span,
            })?;
        let stride = self.layouter[element].to_stride();
        if stride == 0 {
            return Err(shared_error(
                "dynamic shared element has no supported storage layout",
                span,
            ));
        }
        let count = self.dynamic_shared_memory_size.div_ceil(stride).max(1);
        if u64::from(count) * u64::from(stride) > u64::from(crate::valid::MAX_TYPE_SIZE) {
            return Err(shared_error(
                "dynamic shared allocation exceeds Naga's type size limit",
                span,
            ));
        }
        Ok(DynamicSharedDeclaration {
            element,
            count: NonZeroU32::new(count).unwrap(),
            qualifiers: Qualifiers::NONE,
        })
    }

    fn declare_dynamic_shared(
        &mut self,
        name: &'a str,
        declaration: DynamicSharedDeclaration,
        global: bool,
        span: Span,
    ) -> Result<(), ParseError> {
        if let Some(previous) = self.dynamic_shared.declarations.get(name) {
            if *previous != declaration {
                return Err(shared_error(
                    "incompatible extern shared array redeclaration",
                    span,
                ));
            }
        } else {
            self.parameter_expansion_budget
                .charge_map_entry::<&str, DynamicSharedDeclaration>(1, span)?;
            self.dynamic_shared.declarations.insert(name, declaration);
        }
        if let Some(previous) = self.global_declarations.get(name) {
            if !matches!(previous, GlobalDeclaration::DynamicShared(previous) if *previous == declaration)
            {
                return Err(shared_error(
                    "incompatible extern shared array redeclaration",
                    span,
                ));
            }
        }
        if global {
            if !self.global_declarations.contains_key(name) {
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
                self.global_declarations
                    .insert(name, GlobalDeclaration::DynamicShared(declaration));
            }
        } else if let Some(previous) = self
            .function
            .symbol_table
            .add(name, Symbol::DynamicShared(declaration))
        {
            if !matches!(previous, Symbol::DynamicShared(previous) if previous == declaration) {
                return Err(shared_error(
                    "incompatible extern shared array redeclaration",
                    span,
                ));
            }
        }
        Ok(())
    }

    pub(super) fn dynamic_shared_symbol(
        &mut self,
        name: &str,
        declaration: DynamicSharedDeclaration,
        span: Span,
    ) -> Result<Symbol, ParseError> {
        let global = if let Some(&global) = self.dynamic_shared.globals.get(&declaration.element) {
            global
        } else {
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<Type, Span>(1, span)?;
            let ty = self.array_type(
                declaration.element,
                ArraySize::Constant(declaration.count),
                span,
                span,
            )?;
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<(GlobalVariable, Span)>(1, span)?;
            self.parameter_expansion_budget
                .charge_bytes(name.len(), span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Type>, Handle<GlobalVariable>>(1, span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<GlobalVariable>, Handle<Type>>(1, span)?;
            let global = self.module.global_variables.append(
                GlobalVariable {
                    name: Some(String::from(name)),
                    space: AddressSpace::WorkGroup,
                    binding: None,
                    ty,
                    init: None,
                    memory_decorations: Default::default(),
                },
                span,
            );
            self.dynamic_shared
                .globals
                .insert(declaration.element, global);
            self.dynamic_shared
                .elements
                .insert(global, declaration.element);
            global
        };
        let pointer = self.append(Expression::GlobalVariable(global), span)?;
        Ok(Symbol::Array {
            pointer,
            ty: TypeResolution::Handle(declaration.element),
            qualifiers: declaration.qualifiers,
        })
    }

    pub(super) fn is_dynamic_shared_global(&self, global: Handle<GlobalVariable>) -> bool {
        self.dynamic_shared.elements.contains_key(&global)
    }

    pub(super) fn reference_is_dynamic_shared(
        &mut self,
        reference: &ReferenceValue,
    ) -> Result<bool, ParseError> {
        if self.dynamic_shared.elements.is_empty() {
            return Ok(false);
        }
        let span = reference.span;
        let mut reference = reference.reference;
        loop {
            self.parameter_expansion_budget.charge_work(1, span)?;
            match reference {
                Reference::Pointer(pointer) => {
                    return self.dynamic_shared_pointer_root(pointer, span)
                }
                Reference::Bound(binding) => {
                    let targets = self.function.bound_references[binding].targets.len();
                    for index in 0..targets {
                        self.parameter_expansion_budget.charge_work(1, span)?;
                        let address =
                            self.function.bound_references[binding].targets[index].address;
                        let pointer = self.function.bound_addresses[address].root;
                        if self.dynamic_shared_pointer_root(pointer, span)? {
                            return Ok(true);
                        }
                    }
                    return Ok(false);
                }
                Reference::PointerAccess(access) => {
                    return Ok(self.function.pointers.accesses[access]
                        .pointer
                        .constant_address
                        .is_some_and(|address| {
                            address.has_static_lifetime && address.extent.is_none()
                        }));
                }
                Reference::Conditional(handle) => {
                    let conditional = self.function.conditional_references[handle]
                        .as_ref()
                        .unwrap();
                    reference = match conditional.constant_condition {
                        Some(true) => conditional.accept.reference.reference,
                        Some(false) => conditional.reject.reference.reference,
                        None => return Ok(false),
                    };
                }
                Reference::Constant(_) => return Ok(false),
            }
        }
    }

    fn dynamic_shared_pointer_root(
        &mut self,
        mut pointer: Handle<Expression>,
        span: Span,
    ) -> Result<bool, ParseError> {
        for _ in 0..self.function.ir.expressions.len() {
            self.parameter_expansion_budget.charge_work(1, span)?;
            match self.function.ir.expressions[pointer] {
                Expression::Access { base, .. } | Expression::AccessIndex { base, .. } => {
                    pointer = base
                }
                Expression::GlobalVariable(global) => {
                    return Ok(self.is_dynamic_shared_global(global))
                }
                _ => return Ok(false),
            }
        }
        Err(shared_error("invalid dynamic shared address", span))
    }

    pub(super) fn dynamic_shared_index(&mut self) -> Result<Value, ParseError> {
        let (mut index, body) = self.capture_block(|parser| {
            let index = parser.expression(0)?;
            parser.integral_operand(index)
        })?;
        index.constant.is_discardable |= self.dynamic_shared_index_is_pure(&body)?;
        self.append_block(body);
        Ok(index)
    }

    pub(super) fn dynamic_shared_index_is_pure(
        &mut self,
        body: &crate::Block,
    ) -> Result<bool, ParseError> {
        let mut pure = true;
        for (statement, span) in body.span_iter() {
            self.parameter_expansion_budget.charge_work(1, *span)?;
            pure &= matches!(statement, Statement::Emit(_));
        }
        Ok(pure)
    }

    pub(super) fn has_dynamic_shared_declaration(&self, name: &str) -> bool {
        self.dynamic_shared.declarations.contains_key(name)
    }

    pub(super) fn check_dynamic_shared_linkage(
        &self,
        name: &str,
        span: Span,
    ) -> Result<(), ParseError> {
        if self.has_dynamic_shared_declaration(name) {
            return Err(shared_error(
                "incompatible extern shared array redeclaration",
                span,
            ));
        }
        Ok(())
    }

    pub(super) fn check_dynamic_shared_views(&mut self) -> Result<(), ParseError> {
        if self.dynamic_shared.elements.is_empty() {
            return Ok(());
        }
        let span = self.lexer.span_from(0);
        self.parameter_expansion_budget
            .inventory_module(&self.module, span)?;
        let functions = self
            .module
            .functions
            .len()
            .checked_add(self.module.entry_points.len())
            .and_then(|count| count.checked_add(1))
            .ok_or_else(|| {
                shared_error("dynamic shared validation resource limit exceeded", span)
            })?;
        let global_uses = self
            .module
            .global_variables
            .len()
            .checked_mul(functions)
            .ok_or_else(|| {
                shared_error("dynamic shared validation resource limit exceeded", span)
            })?;
        let budget = &mut self.parameter_expansion_budget;
        budget.charge_slice::<crate::valid::GlobalUse>(global_uses, span)?;
        budget.charge_work(global_uses, span)?;
        budget.charge_slice::<crate::valid::FunctionInfo>(functions, span)?;
        budget.charge_slice::<Type>(self.module.types.len(), span)?;
        budget.charge_slice::<crate::valid::TypeFlags>(self.module.types.len(), span)?;
        budget.charge_work(self.module.types.len(), span)?;
        budget.charge_slice::<crate::valid::ExpressionInfo>(
            self.module.global_expressions.len(),
            span,
        )?;
        for (_, function) in self.module.functions.iter() {
            budget.charge_work(1, span)?;
            charge_call_global_uses(function, budget, self.module.global_variables.len(), span)?;
            budget
                .charge_slice::<crate::valid::ExpressionInfo>(function.expressions.len(), span)?;
        }
        for entry in &self.module.entry_points {
            budget.charge_work(1, span)?;
            charge_call_global_uses(
                &entry.function,
                budget,
                self.module.global_variables.len(),
                span,
            )?;
            budget.charge_slice::<crate::valid::ExpressionInfo>(
                entry.function.expressions.len(),
                span,
            )?;
        }
        let mut validation = self.module.clone();
        crate::compact::compact(&mut validation, crate::compact::KeepUnused::Yes);
        let info = crate::valid::Validator::new(
            crate::valid::ValidationFlags::all(),
            crate::valid::Capabilities::all(),
        )
        .validate(&validation)
        .map_err(|error| ParseError {
            span: error.spans().next().map_or(span, |context| context.0),
            message: format!("invalid CUDA dynamic shared storage: {error}"),
        })?;
        for index in 0..self.module.entry_points.len() {
            let mut element = None;
            for (&global, &actual) in &self.dynamic_shared.elements {
                self.parameter_expansion_budget.charge_work(1, span)?;
                if info.get_entry_point(index)[global].is_empty() {
                    continue;
                }
                if element.is_some_and(|element| element != actual) {
                    return Err(shared_error(
                        "heterogeneous dynamic shared views in one kernel are unsupported",
                        self.module.global_variables.get_span(global),
                    ));
                }
                element = Some(actual);
            }
        }
        Ok(())
    }
}
