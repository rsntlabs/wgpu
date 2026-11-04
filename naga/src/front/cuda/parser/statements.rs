use super::functions::ReturnType;
use super::*;

use core::num::NonZeroU32;

use super::super::preprocess::UnrollPragma;

pub(super) struct ArrayDeclaration {
    pub(super) ty: Handle<Type>,
    pub(super) element_ty: Handle<Type>,
    pub(super) count: Option<NonZeroU32>,
}

impl<'a> Parser<'a> {
    pub(super) fn block_contents(&mut self) -> Result<bool, ParseError> {
        let mut terminated = false;
        while !self.lexer.next_if(Token::Paren('}'))? {
            if self.lexer.peek()?.0 == Token::End {
                return self.fail("expected `}`");
            }
            if terminated {
                self.capture_block(Self::statement)?;
            } else {
                terminated = self.statement()?;
            }
        }
        Ok(terminated)
    }

    pub(super) fn scoped_statement(&mut self) -> Result<(crate::Block, bool), ParseError> {
        let compound = self.lexer.next_if(Token::Paren('{'))?;
        let initialization_start = self.function.push_scope();
        let result = self.capture_block(|parser| {
            if compound {
                parser.block_contents()
            } else {
                parser.statement()
            }
        });
        self.function.pop_scope(initialization_start);
        result.map(|(terminated, body)| (body, terminated))
    }

    pub(super) fn statement(&mut self) -> Result<bool, ParseError> {
        self.function.statement_depth += 1;
        if self.function.statement_depth > 64 {
            return self.fail("CUDA statement nesting limit exceeded");
        }
        let result = self.statement_inner();
        self.function.statement_depth -= 1;
        result
    }

    fn statement_inner(&mut self) -> Result<bool, ParseError> {
        let token = self.lexer.peek()?;
        if matches!(token.0, Token::Word("for" | "while" | "do")) {
            for pragma in self.lexer.pragmas_before() {
                self.unroll_pragma(pragma)?;
            }
        }
        let start = token.1;
        if self.lexer.next_if(Token::Separator(';'))? {
            return Ok(false);
        }
        if self.lexer.peek()?.0 == Token::Paren('{') {
            let (body, terminated) = self.scoped_statement()?;
            self.push_statement(Statement::Block(body), start);
            return Ok(terminated);
        }
        if self.take_ident("if")? {
            self.lexer.expect_span(Token::Paren('('))?;
            let value = self.comma_expression()?;
            let condition = self.truthy(value)?;
            self.lexer.expect_span(Token::Paren(')'))?;
            let (accept, accept_terminated) = self.scoped_statement()?;
            let (reject, reject_terminated) = if self.take_ident("else")? {
                self.scoped_statement()?
            } else {
                (crate::Block::new(), false)
            };
            self.push_statement(
                Statement::If {
                    condition: condition.handle,
                    accept,
                    reject,
                },
                start,
            );
            return Ok(accept_terminated && reject_terminated);
        }
        if self.take_ident("switch")? {
            return self.switch_statement(start);
        }
        if matches!(token.0, Token::Word("case" | "default")) {
            return Err(ParseError {
                message: String::from("case and default labels require a direct switch body"),
                span: start,
            });
        }
        if self.take_ident("return")? {
            let value = if self.function.source_result
                == ReturnType::Value(TypeSpecifier::NullPointer)
            {
                let value = self.comma_expression()?;
                self.require_null_pointer_value(value)?;
                None
            } else if let Some(ref result) = self.function.ir.result {
                let ty = TypeResolution::Handle(result.ty);
                let value = self.comma_expression()?;
                Some(self.convert_value(value, &ty)?.handle)
            } else {
                if self.lexer.peek()?.0 != Token::Separator(';') {
                    match self.comma_expression_result()? {
                        ExpressionResult::Value(value) => {
                            return Err(ParseError {
                                message: String::from("cannot return a value from a void function"),
                                span: value.span(),
                            })
                        }
                        ExpressionResult::ThreadBlock(value) => {
                            return Err(ParseError {
                                message: String::from(
                                    "cannot return a thread_block handle from a void function",
                                ),
                                span: value.span,
                            })
                        }
                        ExpressionResult::Void(_) => {}
                    }
                }
                None
            };
            let end = self.lexer.expect_span(Token::Separator(';'))?;
            self.push_statement(Statement::Return { value }, start.until(&end));
            return Ok(true);
        }
        if self.take_ident("__syncthreads")? {
            self.lexer.expect_span(Token::Paren('('))?;
            self.lexer.expect_span(Token::Paren(')'))?;
            let end = self.lexer.expect_span(Token::Separator(';'))?;
            self.emit_workgroup_barrier(start.until(&end))?;
            return Ok(false);
        }
        if self.take_ident("for")? {
            self.for_loop(start)?;
            return Ok(false);
        }
        if self.take_ident("while")? {
            self.while_loop(start)?;
            return Ok(false);
        }
        if self.take_ident("do")? {
            self.do_loop(start)?;
            return Ok(false);
        }
        if matches!(token.0, Token::Word("break" | "continue")) {
            self.lexer.next()?;
            if self.function.loop_depth == 0
                && (token.0 == Token::Word("continue") || self.function.switch_depth == 0)
            {
                return Err(ParseError {
                    message: if token.0 == Token::Word("continue") {
                        String::from("continue requires an enclosing loop")
                    } else {
                        String::from("break requires an enclosing loop or switch")
                    },
                    span: start,
                });
            }
            let statement = if token.0 == Token::Word("break") {
                Statement::Break
            } else {
                Statement::Continue
            };
            let end = self.lexer.expect_span(Token::Separator(';'))?;
            self.push_statement(statement, start.until(&end));
            return Ok(true);
        }
        if self.starts_declaration()? {
            self.local_declaration()?;
            return Ok(false);
        }
        self.discard_expression()?;
        self.lexer.expect_span(Token::Separator(';'))?;
        Ok(false)
    }

    fn unroll_pragma(&mut self, pragma: &'a UnrollPragma) -> Result<(), ParseError> {
        let payload = self.lexer.pragma_payload(pragma);
        let caller = core::mem::replace(&mut self.lexer, payload);
        let result = self.capture_block(|parser| {
            if parser.lexer.next_if(Token::End)? {
                return Ok(());
            }
            let expression = parser.conditional_expression()?;
            let value = parser.rvalue(expression)?;
            let literal = Self::required_constant(&value)?;
            if !matches!(
                literal,
                Literal::Bool(_)
                    | Literal::I16(_)
                    | Literal::U16(_)
                    | Literal::I32(_)
                    | Literal::U32(_)
            ) {
                return Err(ParseError {
                    message: String::from("unroll factor requires an integral constant expression"),
                    span: value.span,
                });
            }
            while parser.lexer.next()?.0 != Token::End {}
            Ok(())
        });
        self.lexer = caller;
        result.map(|_| ())
    }

    pub(super) fn starts_declaration(&mut self) -> Result<bool, ParseError> {
        if self.starts_alias()?
            || matches!(
                self.lexer.peek()?.0,
                Token::Word("extern" | "__shared__" | "struct" | "auto")
            )
        {
            return Ok(true);
        }
        if !self.starts_type()? {
            return Ok(false);
        }
        let mut lookahead = self.lexer.clone();
        if cooperative_groups::try_qualified_name(
            &mut lookahead,
            &self.function.symbol_table,
            &self.global_declarations,
        )?
        .is_none()
        {
            if lookahead.next()?.0 == Token::Word("decltype") {
                lookahead.expect_span(Token::Paren('('))?;
                lookahead.expect_span(Token::Word("nullptr"))?;
                lookahead.expect_span(Token::Paren(')'))?;
            }
        }
        let next = lookahead.peek()?;
        if next.0 == Token::Paren('{') {
            return Ok(false);
        }
        if next.0 != Token::Paren('(') {
            return Ok(true);
        }
        if declarations::parenthesized_declaration(self, lookahead)? {
            return Err(ParseError {
                message: String::from("parenthesized declarators are unsupported"),
                span: next.1,
            });
        }
        Ok(false)
    }

    pub(super) fn local_declaration(&mut self) -> Result<(), ParseError> {
        if self.starts_dynamic_shared_declaration()? {
            return self.dynamic_shared_declaration(false);
        }
        if self.lexer.peek()?.0 == Token::Word("struct") {
            return self.structure_declaration(false);
        }
        if self.starts_alias()? {
            return self.alias_declaration(false);
        }
        if self.take_ident("__shared__")? {
            return self.shared_declaration();
        }
        let (declaration, is_constexpr) = self.declaration_type()?;
        let QualifiedType {
            ty: specifier,
            qualifiers,
        } = match declaration {
            DeclarationType::Explicit(ty) => ty,
            DeclarationType::Inferred { qualifiers } => {
                return self.inferred_local_declaration(qualifiers, is_constexpr);
            }
        };
        let is_const = qualifiers.is_const;
        if matches!(specifier, TypeSpecifier::NullPointer) {
            return self.null_pointer_declaration(qualifiers, is_constexpr);
        }
        if is_constexpr && !matches!(specifier, TypeSpecifier::Scalar(_)) {
            return self.fail("constexpr requires a scalar variable");
        }
        if matches!(specifier, TypeSpecifier::ThreadBlock) {
            if qualifiers.is_volatile {
                return self.fail("volatile thread_block objects are unsupported");
            }
            return self.thread_block_declaration();
        }
        loop {
            let explicit_pointer = self.lexer.next_if(Token::Operation('*'))?;
            let pointer_alias = match specifier {
                TypeSpecifier::Pointer {
                    pointee_qualifiers, ..
                } => Some(pointee_qualifiers),
                _ => None,
            };
            if explicit_pointer && pointer_alias.is_some() {
                return self.fail("nested pointer declarations are unsupported");
            }
            if explicit_pointer || pointer_alias.is_some() {
                if is_constexpr {
                    return self.fail("constexpr pointer declarations are unsupported");
                }
                let (pointee_qualifiers, pointer_qualifiers) =
                    if let Some(pointee_qualifiers) = pointer_alias {
                        (pointee_qualifiers, qualifiers)
                    } else {
                        (qualifiers, types::pointer_qualifiers(&mut self.lexer)?)
                    };
                if pointer_qualifiers.is_volatile {
                    return self.fail("volatile pointer objects are unsupported");
                }
                let (span, has_initializer) = self.local_pointer_declaration(
                    specifier,
                    pointee_qualifiers,
                    pointer_qualifiers.is_const,
                )?;
                if has_initializer {
                    self.function.initialized_declarations.push(span);
                }
                if self.lexer.next_if(Token::Separator(','))? {
                    continue;
                }
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
            if self.lexer.next_if(Token::Operation('&'))? {
                if is_constexpr {
                    return self.fail("constexpr reference declarations are unsupported");
                }
                let (name, span) = self.identifier()?;
                self.check_name(name, span)?;
                self.local_reference_declaration(name, span, specifier, qualifiers)?;
                self.function.initialized_declarations.push(span);
                if self.lexer.next_if(Token::Separator(','))? {
                    continue;
                }
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
            if qualifiers.is_volatile {
                return self.fail("volatile automatic objects are unsupported");
            }
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            let declared_ty = self.lower_type(specifier, span)?;
            let base = self.type_handle(&declared_ty, span);
            let array = self.array_declarator(base, true, span)?;
            let is_array = array.is_some();
            if is_constexpr && is_array {
                return self.fail("constexpr arrays are unsupported");
            }
            let ty = array.as_ref().map_or(base, |array| array.ty);
            let array_count = array.as_ref().and_then(|array| array.count);
            let has_initializer = !matches!(self.lexer.peek()?.0, Token::Separator(',' | ';'));
            let requires_default_constructor = self.requires_default_constructor(ty);
            if matches!(specifier, TypeSpecifier::Array(_)) {
                self.activate_parameter_expansion(span)?;
                self.prepare_parameter_bindings(span)?;
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(LocalVariable, Span)>(1, span)?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len(), span)?;
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, Symbol>(1, span)?;
            }
            let (local, pointer) = self.allocate_local(name, ty, span)?;
            let symbol = if is_array {
                Symbol::Array {
                    pointer,
                    ty: TypeResolution::Handle(array.as_ref().unwrap().element_ty),
                    qualifiers: Qualifiers {
                        is_const,
                        ..Qualifiers::NONE
                    },
                }
            } else {
                Symbol::Variable {
                    pointer,
                    ty: declared_ty.clone(),
                    qualifiers: Qualifiers {
                        is_const,
                        ..Qualifiers::NONE
                    },
                }
            };
            self.insert_symbol(name, symbol, span)?;
            let initializer = if is_array && array_count.is_none() {
                self.function.pending_array = Some(local);
                let element_ty = array.as_ref().unwrap().element_ty;
                let count = self.inferred_array_initializer(pointer, specifier, element_ty)?;
                let ty = self.array_type(element_ty, ArraySize::Constant(count), span, span)?;
                self.function.ir.local_variables[local].ty = ty;
                self.function.pending_array = None;
                None
            } else if is_constexpr {
                let literal = self.constant_initializer(&declared_ty)?;
                self.function.constant_locals.insert(local, literal);
                Some(self.materialize_literal(literal, span)?)
            } else if !has_initializer && requires_default_constructor {
                if is_const && !self.const_default_constructible(ty) {
                    return Err(ParseError {
                        message: String::from("const variable requires an initializer"),
                        span,
                    });
                }
                self.store_default_initializer(pointer, ty, span)?;
                None
            } else if !is_array && matches!(specifier, TypeSpecifier::Dim3) {
                Some(self.dim3_initializer()?.handle)
            } else if !is_const && matches!(self.lexer.peek()?.0, Token::Separator(',' | ';')) {
                None
            } else if is_array
                || (matches!(
                    specifier,
                    TypeSpecifier::Vector { .. } | TypeSpecifier::Structure(_)
                ) && self.starts_list_initializer()?)
            {
                self.aggregate_initializer(pointer, specifier, ty, array_count)?;
                None
            } else if !is_array
                && matches!(
                    specifier,
                    TypeSpecifier::Vector { .. } | TypeSpecifier::Structure(_)
                )
                && self.lexer.peek()?.0 == Token::Paren('(')
            {
                if declarations::parenthesized_function_declaration(self, self.lexer.clone())? {
                    return self.fail("local function declarations are unsupported");
                }
                let opening = self.lexer.expect_span(Token::Paren('('))?;
                self.parenthesized_aggregate_initializer(pointer, ty, opening, None)?;
                None
            } else if is_const
                && matches!(
                    specifier,
                    TypeSpecifier::Scalar(
                        Scalar::BOOL | Scalar::I16 | Scalar::U16 | Scalar::I32 | Scalar::U32
                    )
                )
            {
                let (value, body) =
                    self.capture_block(|parser| parser.value_initializer(&declared_ty))?;
                Some(self.constant_local_initializer(local, value, body)?)
            } else {
                Some(self.value_initializer(&declared_ty)?.handle)
            };
            if has_initializer || requires_default_constructor {
                self.function.initialized_declarations.push(span);
            }
            let end = self.lexer.peek()?.1;
            let has_next_declarator = self.lexer.next_if(Token::Separator(','))?;
            if !has_next_declarator {
                self.lexer.expect_span(Token::Separator(';'))?;
            }
            if let Some(initializer) = initializer {
                self.store_initializer(pointer, initializer, span.until(&end))?;
            }
            if !has_next_declarator {
                return Ok(());
            }
        }
    }

    pub(super) fn allocate_local(
        &mut self,
        name: &str,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<(Handle<LocalVariable>, Handle<Expression>), ParseError> {
        let local = self.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from(name)),
                ty,
                init: None,
            },
            span,
        );
        let pointer = self.append(Expression::LocalVariable(local), span)?;
        Ok((local, pointer))
    }

    pub(super) fn constant_local_initializer(
        &mut self,
        local: Handle<LocalVariable>,
        value: Value,
        body: crate::Block,
    ) -> Result<Handle<Expression>, ParseError> {
        if let Some(literal) = value.constant.literal {
            self.function.constant_locals.insert(local, literal);
            self.materialize_literal(literal, value.span)
        } else {
            self.append_block(body);
            Ok(value.handle)
        }
    }

    fn shared_declaration(&mut self) -> Result<(), ParseError> {
        let type_span = self.lexer.peek()?.1;
        if self.function.kind == FunctionKind::Device {
            self.activate_parameter_expansion(type_span)?;
            self.prepare_parameter_bindings(type_span)?;
        }
        let QualifiedType {
            ty: specifier,
            qualifiers,
        } = self.parse_type()?;
        let is_const = qualifiers.is_const;
        if matches!(specifier, TypeSpecifier::Array(_)) {
            self.activate_parameter_expansion(type_span)?;
            self.prepare_parameter_bindings(type_span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<&str, Symbol>(1, type_span)?;
        }
        if matches!(specifier, TypeSpecifier::Pointer { .. }) {
            return Err(ParseError {
                message: String::from("shared pointer variables are unsupported"),
                span: type_span,
            });
        }
        let declared_ty = self.lower_type(specifier, type_span)?;
        let base = self.type_handle(&declared_ty, type_span);
        let (element, _) = self.array_shape(base, type_span)?;
        if matches!(
            self.module.types[element].inner,
            TypeInner::Scalar(Scalar::BOOL)
        ) || is_const
        {
            return Err(ParseError {
                message: String::from(
                    "shared storage requires a non-const numeric scalar or vector type",
                ),
                span: type_span,
            });
        }
        let (name, span) = self.identifier()?;
        self.check_name(name, span)?;
        if self.requires_default_constructor(base) {
            return Err(ParseError {
                message: String::from("shared variables cannot require a constructor"),
                span: type_span,
            });
        }
        let array = self.array_declarator(base, false, span)?;
        let is_array = array.is_some();
        let ty = array.as_ref().map_or(base, |array| array.ty);
        if self.lexer.peek()?.0 == Token::Operation('=') {
            return self.fail("shared variables cannot have initializers");
        }
        self.lexer.expect_span(Token::Separator(';'))?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(GlobalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
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
        let pointer = self.append(Expression::GlobalVariable(global), span)?;
        let symbol = if is_array {
            Symbol::Array {
                pointer,
                ty: TypeResolution::Handle(array.as_ref().unwrap().element_ty),
                qualifiers,
            }
        } else {
            Symbol::Variable {
                pointer,
                ty: declared_ty,
                qualifiers,
            }
        };
        self.insert_symbol(name, symbol, span)
    }

    pub(super) fn array_declarator(
        &mut self,
        base: Handle<Type>,
        allow_inferred: bool,
        span: Span,
    ) -> Result<Option<ArrayDeclaration>, ParseError> {
        if self.lexer.next_if(Token::Paren('['))? {
            return self.array_declaration(base, allow_inferred, span).map(Some);
        }
        Ok(match self.module.types[base].inner {
            TypeInner::Array {
                base: element_ty,
                size: ArraySize::Constant(count),
                ..
            } => Some(ArrayDeclaration {
                ty: base,
                element_ty,
                count: Some(count),
            }),
            _ => None,
        })
    }

    pub(super) fn array_declaration(
        &mut self,
        base: Handle<Type>,
        allow_inferred: bool,
        span: Span,
    ) -> Result<ArrayDeclaration, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let (_, base_rank) = self.array_shape(base, span)?;
        let mut dimensions = Vec::new();
        loop {
            if dimensions.len() + base_rank == 64 {
                return self.fail("CUDA array rank limit exceeded");
            }
            let extent = if self.lexer.peek()?.0 == Token::Paren(']') {
                if !allow_inferred || !dimensions.is_empty() {
                    return self.fail("only the outermost local array bound may be inferred");
                }
                (None, self.lexer.next()?.1)
            } else {
                let (count, extent_span) = self.array_size()?;
                self.lexer.expect_span(Token::Paren(']'))?;
                (Some(count), extent_span)
            };
            self.parameter_expansion_budget
                .charge_slice::<(Option<NonZeroU32>, Span)>(1, span)?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            dimensions.push(extent);
            if !self.lexer.next_if(Token::Paren('['))? {
                break;
            }
        }
        let mut element_ty = base;
        for &(count, extent_span) in dimensions[1..].iter().rev() {
            element_ty = self.array_type(
                element_ty,
                ArraySize::Constant(count.unwrap()),
                extent_span,
                span,
            )?;
        }
        let (count, extent_span) = dimensions[0];
        let ty = match count {
            Some(count) => {
                self.array_type(element_ty, ArraySize::Constant(count), extent_span, span)?
            }
            None => element_ty,
        };
        Ok(ArrayDeclaration {
            ty,
            element_ty,
            count,
        })
    }

    pub(super) fn array_size(&mut self) -> Result<(NonZeroU32, Span), ParseError> {
        let (value, _) = self.capture_block(|parser| {
            let value = parser.expression(0)?;
            parser.rvalue(value)
        })?;
        let invalid = || ParseError {
            message: String::from("array extent must be a positive integral constant expression"),
            span: value.span,
        };
        let size = match value.constant.literal {
            Some(Literal::Bool(value)) => u32::from(value),
            Some(Literal::I16(value)) => u32::try_from(value).map_err(|_| invalid())?,
            Some(Literal::U16(value)) => u32::from(value),
            Some(Literal::I32(value)) => u32::try_from(value).map_err(|_| invalid())?,
            Some(Literal::U32(value)) => value,
            _ => return Err(invalid()),
        };
        let size = NonZeroU32::new(size).ok_or_else(invalid)?;
        Ok((size, value.span))
    }
}
