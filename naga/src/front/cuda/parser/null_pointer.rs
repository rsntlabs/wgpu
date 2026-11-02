use super::*;

impl NullPointerValue {
    pub(super) const fn literal(span: Span) -> Self {
        Self {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            span,
            constant: ConstantValue {
                literal: None,
                is_discardable: true,
                is_null_pointer_constant: false,
            },
            is_constant: true,
        }
    }

    pub(super) const fn rvalue(mut self) -> Self {
        self.category = ValueCategory::Prvalue;
        self.qualifiers = Qualifiers::NONE;
        self
    }
}

impl ExpressionValue {
    pub(super) const fn is_null_pointer_constant(&self) -> bool {
        match *self {
            Self::NullPointer(_) => true,
            Self::Plain(ref value) => value.constant.is_null_pointer_constant,
            Self::Reference(_) | Self::Pointer(_) => false,
        }
    }
}

impl<'a> Parser<'a> {
    pub(super) fn global_null_pointer_declaration(
        &mut self,
        qualifiers: Qualifiers,
    ) -> Result<(), ParseError> {
        loop {
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            self.check_dynamic_shared_linkage(name, span)?;
            if self.global_declarations.contains_key(name) {
                return self.fail("incompatible nullptr_t redeclaration");
            }
            self.activate_parameter_expansion(span)?;
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
            let mut value = NullPointerValue::literal(span);
            value.category = ValueCategory::Lvalue;
            value.qualifiers = qualifiers;
            self.global_declarations
                .insert(name, GlobalDeclaration::NullPointer(value));
            self.null_pointer_initializer(qualifiers, true)?;
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    pub(super) fn null_pointer_comparison(
        &mut self,
        left: ExpressionValue,
        right: ExpressionValue,
        right_body: crate::Block,
        operator: BinaryOperator,
    ) -> Result<Value, ParseError> {
        let span = left.span().until(&right.span());
        let left = self.require_null_pointer_value(left)?;
        let right = self.require_null_pointer_value(right)?;
        self.append_block(right_body);
        let literal = Literal::Bool(operator == BinaryOperator::Equal);
        let handle = self.append(Expression::Literal(literal), span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(Scalar::BOOL),
            span,
            constant: if left.is_constant && right.is_constant {
                literal.into()
            } else {
                ConstantValue::default()
            },
        })
    }

    pub(super) fn require_null_pointer_value(
        &self,
        value: ExpressionValue,
    ) -> Result<NullPointerValue, ParseError> {
        match value {
            ExpressionValue::NullPointer(value) => Ok(value.rvalue()),
            ExpressionValue::Plain(value) if value.constant.is_null_pointer_constant => {
                Ok(NullPointerValue::literal(value.span))
            }
            value => Err(ParseError {
                message: String::from("nullptr_t requires nullptr or an integer literal zero"),
                span: value.span(),
            }),
        }
    }

    pub(super) fn bind_null_pointer_symbol(
        &mut self,
        name: &'a str,
        span: Span,
        qualifiers: Qualifiers,
    ) -> Result<(), ParseError> {
        self.activate_parameter_expansion(span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<&str, Symbol>(1, span)?;
        let mut value = NullPointerValue::literal(span);
        value.category = ValueCategory::Lvalue;
        value.qualifiers = qualifiers;
        self.function
            .symbol_table
            .add(name, Symbol::NullPointer(value));
        Ok(())
    }

    pub(super) fn null_pointer_initializer(
        &mut self,
        qualifiers: Qualifiers,
        is_constexpr: bool,
    ) -> Result<NullPointerValue, ParseError> {
        if qualifiers.is_volatile {
            return self.fail("volatile nullptr_t objects are unsupported");
        }
        let has_equals = self.lexer.next_if(Token::Operation('='))?;
        let opening = self.lexer.peek()?;
        let closing = match opening.0 {
            Token::Paren('{') => Some('}'),
            Token::Paren('(') if !has_equals => Some(')'),
            _ => None,
        };
        let value = if let Some(closing) = closing {
            if closing == ')'
                && declarations::parenthesized_function_declaration(self, self.lexer.clone())?
            {
                return self.fail("local function declarations are unsupported");
            }
            self.lexer.next()?;
            if self.lexer.next_if(Token::Paren(closing))? {
                NullPointerValue::literal(opening.1)
            } else {
                let value = self.expression(0)?;
                let value = self.require_null_pointer_value(value)?;
                if closing == '}' {
                    self.lexer.next_if(Token::Separator(','))?;
                }
                self.lexer.expect_span(Token::Paren(closing))?;
                value
            }
        } else if has_equals {
            let value = self.expression(0)?;
            self.require_null_pointer_value(value)?
        } else {
            if is_constexpr || qualifiers.is_const {
                return self.fail("const nullptr_t declaration requires an initializer");
            }
            NullPointerValue::literal(opening.1)
        };
        if is_constexpr && !value.is_constant {
            return self.fail("constexpr requires a constant expression");
        }
        Ok(value)
    }

    pub(super) fn null_pointer_declaration(
        &mut self,
        qualifiers: Qualifiers,
        is_constexpr: bool,
    ) -> Result<(), ParseError> {
        if qualifiers.is_volatile {
            return self.fail("volatile nullptr_t objects and references are unsupported");
        }
        loop {
            if self.lexer.peek()?.0 == Token::Operation('*') {
                return self.fail("pointers to nullptr_t objects are unsupported");
            }
            let is_reference = self.lexer.next_if(Token::Operation('&'))?;
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            self.insert_symbol(name, Symbol::PendingAuto, span)?;
            if self.lexer.peek()?.0 == Token::Paren('[') {
                return self.fail("arrays of nullptr_t objects are unsupported");
            }
            let has_initializer = is_reference
                || matches!(
                    self.lexer.peek()?.0,
                    Token::Operation('=') | Token::Paren('(' | '{')
                );
            if is_reference {
                if is_constexpr {
                    return self.fail("constexpr reference declarations are unsupported");
                }
                let has_equals = self.lexer.next_if(Token::Operation('='))?;
                let value = if !has_equals && self.lexer.peek()?.0 == Token::Paren('(') {
                    self.parenthesized_initializer()?
                } else {
                    if !has_equals {
                        self.lexer.expect_span(Token::Operation('='))?;
                    }
                    self.expression(0)?
                };
                self.require_null_pointer_reference(value, qualifiers)?;
                self.bind_null_pointer_symbol(name, span, qualifiers)?;
            } else {
                self.bind_null_pointer_symbol(name, span, qualifiers)?;
                self.null_pointer_initializer(qualifiers, is_constexpr)?;
            }
            if has_initializer {
                self.function.initialized_declarations.push(span);
            }
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    pub(super) fn require_null_pointer_reference(
        &self,
        value: ExpressionValue,
        qualifiers: Qualifiers,
    ) -> Result<NullPointerValue, ParseError> {
        if qualifiers.is_volatile {
            return Err(ParseError {
                message: String::from("volatile nullptr_t references are unsupported"),
                span: value.span(),
            });
        }
        if let ExpressionValue::NullPointer(ref value) = value {
            if value.category == ValueCategory::Lvalue && qualifiers.contains(value.qualifiers) {
                return Ok(value.clone());
            }
        }
        if !qualifiers.is_const || qualifiers.is_volatile {
            return Err(ParseError {
                message: String::from("mutable reference requires an exact-type lvalue"),
                span: value.span(),
            });
        }
        self.require_null_pointer_value(value)
    }

    pub(super) fn null_pointer_constructor(
        &mut self,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        let closing = match self.lexer.next()?.0 {
            Token::Paren('(') => ')',
            Token::Paren('{') => '}',
            _ => return self.fail("expected a nullptr_t initializer"),
        };
        let mut value = if self.lexer.next_if(Token::Paren(closing))? {
            NullPointerValue::literal(span)
        } else {
            let value = self.expression(0)?;
            let value = self.require_null_pointer_value(value)?;
            if closing == '}' {
                self.lexer.next_if(Token::Separator(','))?;
            }
            self.lexer.expect_span(Token::Paren(closing))?;
            value
        };
        value.span = span.until(&value.span);
        Ok(ExpressionValue::NullPointer(value.rvalue()).into())
    }

    pub(super) fn null_pointer_boolean(
        &mut self,
        value: NullPointerValue,
    ) -> Result<Value, ParseError> {
        let literal = Literal::Bool(false);
        let handle = self.append(Expression::Literal(literal), value.span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(Scalar::BOOL),
            span: value.span,
            constant: if value.is_constant {
                literal.into()
            } else {
                ConstantValue::default()
            },
        })
    }

    pub(super) fn null_pointer_assignment(
        &mut self,
        mut left: NullPointerValue,
        operator: Option<BinaryOperator>,
    ) -> Result<ExpressionValue, ParseError> {
        if left.qualifiers.is_volatile {
            return self.fail("volatile nullptr_t assignments are unsupported");
        }
        if left.category != ValueCategory::Lvalue || left.qualifiers.is_const {
            return self.fail("assignment requires a modifiable nullptr_t lvalue");
        }
        if operator.is_some() {
            return self.fail("nullptr_t does not support compound assignment");
        }
        self.lexer.next()?;
        let (right, right_body) = self.capture_block(|parser| {
            let right = parser.expression(0)?;
            parser.require_null_pointer_value(right)
        })?;
        self.prepend_block(right_body);
        left.span = left.span.until(&right.span);
        left.is_constant = false;
        left.constant = ConstantValue::default();
        Ok(ExpressionValue::NullPointer(left))
    }
}
