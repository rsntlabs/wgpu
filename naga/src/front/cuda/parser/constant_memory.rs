use super::types::IntegerSpecifiers;
use super::*;

#[derive(Clone, Copy, Debug)]
pub(super) struct ConstantMemoryDeclaration {
    global: Handle<GlobalVariable>,
    qualifiers: Qualifiers,
    is_defined: bool,
    is_internal: bool,
    has_c_linkage: bool,
}

#[derive(Default)]
pub(super) struct ConstantMemory {
    pub(super) globals: crate::FastHashSet<Handle<GlobalVariable>>,
    next_binding: u32,
}

#[derive(Clone, Copy)]
struct ConstantMemoryLinkage {
    is_defined: bool,
    is_internal: bool,
    has_c_linkage: bool,
}

fn constant_memory_error(message: &str, span: Span) -> ParseError {
    ParseError {
        message: String::from(message),
        span,
    }
}

impl<'a> Parser<'a> {
    pub(super) fn starts_constant_memory_declaration(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        let mut has_extern = false;
        loop {
            match lexer.next()?.0 {
                Token::Word("__constant__") => return Ok(true),
                Token::Word("extern") => has_extern = true,
                Token::Word(
                    "static" | "__device__" | "const" | "volatile" | "int" | "short" | "signed"
                    | "unsigned" | "constexpr",
                )
                | Token::String("C") => {}
                Token::Word(name) if self.type_name(name).is_some() => {}
                Token::Word(name) if has_extern => {
                    return Ok(matches!(
                        self.global_declarations.get(name),
                        Some(GlobalDeclaration::ConstantMemory(_))
                    ));
                }
                _ => return Ok(false),
            }
        }
    }

    pub(super) fn constant_memory_declaration(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.peek()?.1;
        self.activate_parameter_expansion(span)?;
        let mut ty: Option<QualifiedType> = None;
        let mut integers = IntegerSpecifiers::default();
        let mut qualifiers = Qualifiers::NONE;
        let mut has_constant = false;
        let mut has_device = false;
        let mut has_extern = false;
        let mut has_static = false;
        let mut has_c_linkage = false;
        loop {
            match self.lexer.peek()?.0 {
                Token::Word("__constant__") => {
                    if has_constant {
                        return self.fail("duplicate constant memory specifier");
                    }
                    has_constant = true;
                }
                Token::Word("__device__") => {
                    if has_device {
                        return self.fail("duplicate device specifier");
                    }
                    has_device = true;
                }
                Token::Word("extern") => {
                    self.lexer.next()?;
                    if self.lexer.next_if(Token::String("C"))? {
                        if has_c_linkage || has_static || has_extern {
                            return self.fail("incompatible constant memory linkage");
                        }
                        has_c_linkage = true;
                        has_extern = true;
                    } else {
                        if has_extern || has_static {
                            return self.fail("duplicate or incompatible storage specifier");
                        }
                        has_extern = true;
                    }
                    continue;
                }
                Token::Word("static") => {
                    if has_static || has_extern || has_c_linkage {
                        return self.fail("duplicate or incompatible storage specifier");
                    }
                    has_static = true;
                }
                Token::Word("const") => {
                    if qualifiers.is_const {
                        return self.fail("duplicate const qualifier");
                    }
                    qualifiers.is_const = true;
                }
                Token::Word("volatile") => {
                    if qualifiers.is_volatile {
                        return self.fail("duplicate volatile qualifier");
                    }
                    qualifiers.is_volatile = true;
                }
                Token::Word(specifier @ ("int" | "short" | "signed" | "unsigned")) => {
                    if ty.is_some() && integers.is_empty() {
                        return self.fail("incompatible or repeated type specifier");
                    }
                    let scalar = integers.consume(specifier).ok_or_else(|| {
                        constant_memory_error("incompatible or repeated type specifier", span)
                    })?;
                    ty = Some(QualifiedType {
                        ty: TypeSpecifier::Scalar(scalar),
                        qualifiers: Qualifiers::NONE,
                    });
                }
                Token::Word(name) if ty.is_none() => {
                    let Some(qualified) = self.type_name(name) else {
                        break;
                    };
                    ty = Some(qualified);
                }
                _ => break,
            }
            self.lexer.next()?;
        }
        let inherits_constant = has_extern
            && matches!(self.lexer.peek()?.0, Token::Word(name) if matches!(self.global_declarations.get(name), Some(GlobalDeclaration::ConstantMemory(_))));
        let Some(mut qualified) = ty.filter(|_| has_constant || inherits_constant) else {
            return self.fail("constant memory requires a supported numeric value type");
        };
        qualified.qualifiers = qualified.qualifiers.union(qualifiers);
        if qualified.qualifiers.is_const && !has_extern {
            return self.fail("const-qualified constant memory requires an extern declaration or an initializer; initializers are unsupported");
        }
        if matches!(qualified.ty, TypeSpecifier::Pointer { .. }) {
            return self.fail("constant memory pointer objects are unsupported");
        }
        let resolution = self.lower_type(qualified.ty, span)?;
        let base = self.type_handle(&resolution, span);
        if self.is_incomplete_array(base) {
            return self.fail("constant memory requires a complete array bound");
        }
        if !self.numeric_storage_type(base, span)? || self.requires_default_constructor(base) {
            return self.fail("constant memory requires numeric values or POD records");
        }
        loop {
            let (name, name_span) = self.identifier()?;
            self.check_name(name, name_span)?;
            if !has_constant
                && !matches!(
                    self.global_declarations.get(name),
                    Some(GlobalDeclaration::ConstantMemory(_))
                )
            {
                return Err(constant_memory_error(
                    "constant memory attribute omission requires a previous constant memory declaration",
                    name_span,
                ));
            }
            let ty = if self.lexer.next_if(Token::Paren('['))? {
                self.array_declaration(base, false, name_span)?.ty
            } else {
                base
            };
            if matches!(
                self.lexer.peek()?.0,
                Token::Operation('=') | Token::Paren('{' | '(')
            ) {
                return self
                    .fail("constant memory initializers require caller-provided buffer data");
            }
            self.declare_constant_memory(
                name,
                ty,
                qualified.qualifiers,
                ConstantMemoryLinkage {
                    is_defined: !has_extern,
                    is_internal: has_static,
                    has_c_linkage,
                },
                name_span,
            )?;
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    fn declare_constant_memory(
        &mut self,
        name: &'a str,
        ty: Handle<Type>,
        qualifiers: Qualifiers,
        linkage: ConstantMemoryLinkage,
        span: Span,
    ) -> Result<(), ParseError> {
        self.check_dynamic_shared_linkage(name, span)?;
        if let Some(previous) = self.global_declarations.get_mut(name) {
            let &mut GlobalDeclaration::ConstantMemory(ref mut previous) = previous else {
                return Err(constant_memory_error(
                    "incompatible constant memory redeclaration",
                    span,
                ));
            };
            if previous.qualifiers != qualifiers
                || self.module.global_variables[previous.global].ty != ty
                || (linkage.is_internal && !previous.is_internal)
                || (linkage.has_c_linkage && !previous.has_c_linkage)
            {
                return Err(constant_memory_error(
                    "incompatible constant memory redeclaration",
                    span,
                ));
            }
            if linkage.is_defined && previous.is_defined {
                return Err(constant_memory_error(
                    "duplicate constant memory definition",
                    span,
                ));
            }
            previous.is_defined |= linkage.is_defined;
            return Ok(());
        }
        let binding = self.constant_memory.next_binding;
        let next_binding = binding.checked_add(1).ok_or_else(|| {
            constant_memory_error("CUDA constant memory binding limit exceeded", span)
        })?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(GlobalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<Handle<GlobalVariable>, ()>(1, span)?;
        let global = self.module.global_variables.append(
            GlobalVariable {
                name: Some(String::from(name)),
                space: AddressSpace::Storage {
                    access: StorageAccess::LOAD,
                },
                binding: Some(ResourceBinding { group: 1, binding }),
                ty,
                init: None,
                memory_decorations: Default::default(),
            },
            span,
        );
        self.constant_memory.globals.insert(global);
        self.constant_memory.next_binding = next_binding;
        self.global_declarations.insert(
            name,
            GlobalDeclaration::ConstantMemory(ConstantMemoryDeclaration {
                global,
                qualifiers,
                is_defined: linkage.is_defined,
                is_internal: linkage.is_internal,
                has_c_linkage: linkage.has_c_linkage,
            }),
        );
        Ok(())
    }

    pub(super) fn constant_memory_symbol(
        &mut self,
        declaration: ConstantMemoryDeclaration,
        span: Span,
    ) -> Result<Symbol, ParseError> {
        self.prepare_parameter_bindings(span)?;
        let ty = self.module.global_variables[declaration.global].ty;
        let pointer = self.append(Expression::GlobalVariable(declaration.global), span)?;
        Ok(
            if let TypeInner::Array { base, .. } = self.module.types[ty].inner {
                Symbol::Array {
                    pointer,
                    ty: TypeResolution::Handle(base),
                    qualifiers: declaration.qualifiers,
                }
            } else {
                Symbol::Variable {
                    pointer,
                    ty: TypeResolution::Handle(ty),
                    qualifiers: declaration.qualifiers,
                }
            },
        )
    }

    pub(super) fn check_constant_memory_accesses(&mut self) -> Result<(), ParseError> {
        if self.constant_memory.globals.is_empty() {
            return Ok(());
        }
        for (_, function) in self.module.functions.iter() {
            check_writes(&self.module, function, &mut self.parameter_expansion_budget)?;
        }
        for entry in &self.module.entry_points {
            check_writes(
                &self.module,
                &entry.function,
                &mut self.parameter_expansion_budget,
            )?;
        }
        Ok(())
    }

    pub(super) fn check_writable_pointer(
        &mut self,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        if self.constant_memory.globals.is_empty() {
            return Ok(());
        }
        check_pointer_write(
            &self.module,
            &self.function.ir,
            pointer,
            &mut self.parameter_expansion_budget,
            span,
        )
    }
}

fn check_pointer_write(
    module: &Module,
    function: &Function,
    mut pointer: Handle<Expression>,
    budget: &mut parameter_expansion::ExpansionBudget,
    span: Span,
) -> Result<(), ParseError> {
    for _ in 0..=64 {
        budget.charge_work(1, span)?;
        match function.expressions[pointer] {
            Expression::Access { base, .. } | Expression::AccessIndex { base, .. } => {
                pointer = base
            }
            Expression::GlobalVariable(global) => {
                if matches!(module.global_variables[global].space, AddressSpace::Storage { access } if !access.contains(StorageAccess::STORE))
                {
                    return Err(constant_memory_error(
                        "cannot modify read-only CUDA constant memory",
                        span,
                    ));
                }
                return Ok(());
            }
            _ => return Ok(()),
        }
    }
    Err(constant_memory_error(
        "CUDA constant memory access depth limit exceeded",
        span,
    ))
}

fn check_writes(
    module: &Module,
    function: &Function,
    budget: &mut parameter_expansion::ExpansionBudget,
) -> Result<(), ParseError> {
    budget.charge_slice::<&crate::Block>(1, Span::UNDEFINED)?;
    let mut pending = alloc::vec![&function.body];
    while let Some(body) = pending.pop() {
        for (statement, &span) in body.span_iter() {
            budget.charge_work(1, span)?;
            let mut child = |body| -> Result<(), ParseError> {
                budget.charge_slice::<&crate::Block>(1, span)?;
                pending.push(body);
                Ok(())
            };
            match *statement {
                Statement::Store { pointer, .. } | Statement::Atomic { pointer, .. } => {
                    check_pointer_write(module, function, pointer, budget, span)?;
                }
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
