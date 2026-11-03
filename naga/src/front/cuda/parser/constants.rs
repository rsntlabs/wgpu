use super::*;

impl<'a> Parser<'a> {
    pub(super) fn starts_constexpr_declaration(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        loop {
            match lexer.peek()?.0 {
                Token::Word("constexpr") => return Ok(true),
                Token::Word("const" | "volatile" | "int" | "unsigned" | "auto") => {}
                Token::Word(name) if self.type_name(name).is_some() => {}
                _ => return Ok(false),
            }
            lexer.next()?;
        }
    }

    pub(super) fn global_constant_declaration(&mut self) -> Result<(), ParseError> {
        let (declaration, _) = self.declaration_type()?;
        let ty = match declaration {
            DeclarationType::Explicit(ty) => ty,
            DeclarationType::Inferred { qualifiers } => {
                if qualifiers.is_volatile {
                    return self.fail("volatile constexpr objects are unsupported");
                }
                return self.inferred_global_constant_declaration();
            }
        };
        if ty.qualifiers.is_volatile {
            return self.fail("volatile constexpr objects are unsupported");
        }
        if matches!(ty.ty, TypeSpecifier::NullPointer) {
            return self.global_null_pointer_declaration(ty.qualifiers);
        }
        let TypeSpecifier::Scalar(scalar) = ty.ty else {
            return self.fail("constexpr requires a scalar variable");
        };
        loop {
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            self.check_dynamic_shared_linkage(name, span)?;
            if self.global_declarations.contains_key(name) {
                return Err(ParseError {
                    message: format!("incompatible redeclaration of `{name}`"),
                    span,
                });
            }
            self.global_declarations.insert(
                name,
                GlobalDeclaration::Constant {
                    handle: None,
                    scalar,
                    literal: None,
                },
            );
            let literal = self.constant_initializer(&scalar_resolution(scalar))?;
            self.bind_global_constant(name, scalar, literal, span)?;
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    pub(super) fn bind_global_constant(
        &mut self,
        name: &'a str,
        scalar: Scalar,
        literal: Literal,
        span: Span,
    ) -> Result<(), ParseError> {
        let nonfinite = ConstantValue::from(literal).is_nonfinite();
        let (physical_scalar, physical_literal) = match literal {
            Literal::F32(value) if nonfinite => {
                self.activate_parameter_expansion(span)?;
                self.parameter_expansion_budget.charge_nodes(2, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(Expression, Span)>(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(crate::Constant, Span)>(1, span)?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len() + "_bits".len(), span)?;
                (Scalar::U32, Literal::U32(value.to_bits()))
            }
            _ => (scalar, literal),
        };
        let ty = self.scalar_handle(physical_scalar, span);
        let init = self
            .module
            .global_expressions
            .append(Expression::Literal(physical_literal), span);
        let constant_handle = self.module.constants.append(
            crate::Constant {
                name: Some(if nonfinite {
                    format!("{name}_bits")
                } else {
                    String::from(name)
                }),
                ty,
                init,
            },
            span,
        );
        self.global_declarations.insert(
            name,
            GlobalDeclaration::Constant {
                handle: Some(constant_handle),
                scalar,
                literal: Some(literal),
            },
        );
        self.function = FunctionContext::new(FunctionKind::Kernel);
        Ok(())
    }

    pub(super) fn materialize_literal(
        &mut self,
        literal: Literal,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        match literal {
            Literal::F32(value) if !value.is_finite() => self
                .materialize_float_bits(Expression::Literal(Literal::U32(value.to_bits())), span),
            _ => self.append(Expression::Literal(literal), span),
        }
    }

    pub(super) fn materialize_float_bits(
        &mut self,
        bits: Expression,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let bits = self.append(bits, span)?;
        let pointer = self.temporary_pointer(&scalar_resolution(Scalar::U32), span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(
            Statement::Store {
                pointer,
                value: bits,
            },
            span,
        );
        let loaded = self.append(Expression::Load { pointer }, span)?;
        self.append(
            Expression::As {
                expr: loaded,
                kind: ScalarKind::Float,
                convert: None,
            },
            span,
        )
    }

    pub(super) fn constant_initializer(
        &mut self,
        ty: &TypeResolution,
    ) -> Result<Literal, ParseError> {
        let (value, _) = self.capture_block(|parser| parser.value_initializer(ty))?;
        Self::required_constant(&value)
    }

    pub(super) fn required_constant(value: &Value) -> Result<Literal, ParseError> {
        value.constant.literal.ok_or_else(|| ParseError {
            message: String::from("not a supported scalar constant expression"),
            span: value.span,
        })
    }

    pub(super) fn pointer_constant(&self, pointer: Handle<Expression>) -> ConstantValue {
        let (literal, is_discardable) = match self.function.ir.expressions[pointer] {
            Expression::LocalVariable(local) => {
                (self.function.constant_locals.get(&local).copied(), true)
            }
            Expression::GlobalVariable(global) => (
                None,
                self.module.global_variables[global].space == AddressSpace::WorkGroup,
            ),
            _ => (None, false),
        };
        ConstantValue {
            literal,
            is_discardable,
            is_null_pointer_constant: false,
        }
    }

    pub(super) fn constant_array_address(
        is_discardable: bool,
        count: Option<core::num::NonZeroU32>,
        index: ConstantValue,
    ) -> bool {
        if !is_discardable || !index.is_discardable {
            return false;
        }
        let index = match index.literal {
            Some(Literal::I32(index)) if index >= 0 => index as u32,
            Some(Literal::U32(index)) => index,
            _ => return false,
        };
        count.map_or(index == 0, |count| index < count.get())
    }
}
