use super::float_helpers::FloatMathFunction;
use super::*;

const UNARY_PRECEDENCE: u8 = 11;

impl Parser<'_> {
    pub(super) fn comma_expression(&mut self) -> Result<ExpressionValue, ParseError> {
        self.comma_expression_result()?.require_value()
    }

    pub(super) fn comma_expression_result(&mut self) -> Result<ExpressionResult, ParseError> {
        let mut result = self.expression_result(0)?;
        while self.lexer.next_if(Token::Separator(','))? {
            let earlier = match result {
                ExpressionResult::Value(ExpressionValue::Reference(ref reference))
                    if self.has_discarded_volatile_read(reference) =>
                {
                    ConstantValue::default()
                }
                ExpressionResult::Value(ref value) => value.constant(),
                ExpressionResult::ThreadBlock(ref value) => value.constant,
                ExpressionResult::Void(_) => ConstantValue::default(),
            };
            self.discard_result(result)?;
            result = self.expression_result(0)?;
            if let ExpressionResult::Value(ref mut value) = result {
                self.sequence_value(value, earlier)?;
            } else if let ExpressionResult::ThreadBlock(ref mut value) = result {
                value.constant = value.constant.after(earlier);
            }
        }
        Ok(result)
    }

    pub(super) fn expression(
        &mut self,
        minimum_precedence: u8,
    ) -> Result<ExpressionValue, ParseError> {
        self.expression_result(minimum_precedence)?.require_value()
    }

    pub(super) fn discard_expression(&mut self) -> Result<(), ParseError> {
        let result = self.comma_expression_result()?;
        self.discard_result(result)
    }

    pub(super) fn expression_result(
        &mut self,
        minimum_precedence: u8,
    ) -> Result<ExpressionResult, ParseError> {
        self.expression_result_with_assignment(minimum_precedence, true)
    }

    pub(super) fn conditional_expression(&mut self) -> Result<ExpressionValue, ParseError> {
        self.expression_result_with_assignment(0, false)?
            .require_value()
    }

    fn expression_result_with_assignment(
        &mut self,
        minimum_precedence: u8,
        allow_assignment: bool,
    ) -> Result<ExpressionResult, ParseError> {
        self.function.expression_depth += 1;
        if self.function.expression_depth > 64 {
            return self.fail("CUDA expression nesting limit exceeded");
        }
        let result = self
            .capture_block(|parser| parser.expression_inner(minimum_precedence, allow_assignment));
        self.function.expression_depth -= 1;
        let (value, body) = result?;
        self.append_block(body);
        Ok(value)
    }

    fn expression_inner(
        &mut self,
        minimum_precedence: u8,
        allow_assignment: bool,
    ) -> Result<ExpressionResult, ParseError> {
        let start = self.lexer.peek()?.1.to_range().unwrap().start;
        let mut left = self.primary()?;
        loop {
            let (operator, precedence) = match self.lexer.peek()?.0 {
                Token::LogicalOperation('|') => (BinaryOperator::LogicalOr, 1),
                Token::LogicalOperation('&') => (BinaryOperator::LogicalAnd, 2),
                Token::Operation('|') => (BinaryOperator::InclusiveOr, 3),
                Token::Operation('^') => (BinaryOperator::ExclusiveOr, 4),
                Token::Operation('&') => (BinaryOperator::And, 5),
                Token::LogicalOperation('=') => (BinaryOperator::Equal, 6),
                Token::LogicalOperation('!') => (BinaryOperator::NotEqual, 6),
                Token::Paren('<') => (BinaryOperator::Less, 7),
                Token::Paren('>') => (BinaryOperator::Greater, 7),
                Token::LogicalOperation('<') => (BinaryOperator::LessEqual, 7),
                Token::LogicalOperation('>') => (BinaryOperator::GreaterEqual, 7),
                Token::ShiftOperation('<') => (BinaryOperator::ShiftLeft, 8),
                Token::ShiftOperation('>') => (BinaryOperator::ShiftRight, 8),
                Token::Operation('+') => (BinaryOperator::Add, 9),
                Token::Operation('-') => (BinaryOperator::Subtract, 9),
                Token::Operation('*') => (BinaryOperator::Multiply, 10),
                Token::Operation('/') => (BinaryOperator::Divide, 10),
                Token::Operation('%') => (BinaryOperator::Modulo, 10),
                _ => break,
            };
            if precedence < minimum_precedence {
                break;
            }
            let operator_span = self.lexer.next()?.1;
            let left_value = left.require_value()?;
            if matches!(
                operator,
                BinaryOperator::LogicalAnd | BinaryOperator::LogicalOr
            ) {
                left = self.logical(left_value, operator, precedence, operator_span)?;
                continue;
            }
            if operators::Operator::from_binary(operator).is_some() {
                left = self.binary_operator(left_value, operator, precedence, operator_span)?;
                continue;
            }
            if matches!(operator, BinaryOperator::Equal | BinaryOperator::NotEqual) {
                let (right, right_body) =
                    self.capture_block(|parser| parser.expression(precedence + 1))?;
                if self.is_pointer_operand(&left_value) || self.is_pointer_operand(&right) {
                    left = self.pointer_binary(left_value, right, right_body, operator)?;
                } else if matches!(left_value, ExpressionValue::NullPointer(_))
                    || matches!(right, ExpressionValue::NullPointer(_))
                {
                    left = self
                        .null_pointer_comparison(left_value, right, right_body, operator)?
                        .into();
                } else {
                    self.append_block(right_body);
                    left = self.binary_value(operator, left_value, right)?.into();
                }
                continue;
            }
            let right = self.expression(precedence + 1)?;
            left = self.binary_value(operator, left_value, right)?.into();
        }
        if minimum_precedence == 0 {
            if self.lexer.next_if(Token::Operation('?'))? {
                left = self.conditional(left, start)?;
            }
            if !allow_assignment {
                return Ok(left);
            }
            let operator = match self.lexer.peek()?.0 {
                Token::Operation('=') => Some(None),
                Token::AssignmentOperation(character) => Some(Some(match character {
                    '+' => BinaryOperator::Add,
                    '-' => BinaryOperator::Subtract,
                    '*' => BinaryOperator::Multiply,
                    '/' => BinaryOperator::Divide,
                    '%' => BinaryOperator::Modulo,
                    '&' => BinaryOperator::And,
                    '|' => BinaryOperator::InclusiveOr,
                    '^' => BinaryOperator::ExclusiveOr,
                    '<' => BinaryOperator::ShiftLeft,
                    '>' => BinaryOperator::ShiftRight,
                    _ => unreachable!(),
                })),
                _ => None,
            };
            if let Some(operator) = operator {
                return self.assignment(left.require_value()?, operator);
            }
        }
        Ok(left)
    }

    fn primary(&mut self) -> Result<ExpressionResult, ParseError> {
        let mut value = self.primary_inner()?;
        loop {
            match self.lexer.peek()?.0 {
                Token::Separator('.') | Token::Arrow => {
                    value = self.member_access(value)?;
                }
                Token::Paren('[') => {
                    value = ExpressionResult::Value(self.array_index(value.require_value()?)?);
                }
                operator @ (Token::IncrementOperation | Token::DecrementOperation) => {
                    let operand = value.require_value()?;
                    let span = operand.span().until(&self.lexer.peek()?.1);
                    self.lexer.next()?;
                    value = ExpressionResult::Value(self.update(
                        operand,
                        operator == Token::IncrementOperation,
                        true,
                        span,
                    )?);
                }
                _ => break,
            }
        }
        Ok(value)
    }

    fn primary_inner(&mut self) -> Result<ExpressionResult, ParseError> {
        let token = self.lexer.peek()?;
        if let operator @ (Token::IncrementOperation | Token::DecrementOperation) = token.0 {
            self.lexer.next()?;
            let value = self.expression(UNARY_PRECEDENCE)?;
            let span = token.1.until(&value.span());
            return self
                .update(value, operator == Token::IncrementOperation, false, span)
                .map(ExpressionResult::Value);
        }
        if self.lexer.next_if(Token::Paren('('))? {
            return self.parenthesized_expression(token.1);
        }
        if matches!(token.0, Token::Operation('-' | '+' | '!' | '~' | '*' | '&')) {
            return self.unary_expression(token.0, token.1);
        }
        if let Some(name) = self.qualified_item()? {
            return self.qualified_expression(name);
        }
        match token.0 {
            Token::Number(text) => {
                self.lexer.next()?;
                self.number(text, token.1).map(Into::into)
            }
            Token::Word(name) => {
                self.lexer.next()?;
                self.word_expression(name, token.1)
            }
            _ => self.fail("expected a supported scalar expression"),
        }
    }

    fn parenthesized_expression(&mut self, span: Span) -> Result<ExpressionResult, ParseError> {
        if self.starts_type()? {
            let mut lookahead = self.lexer.clone();
            let target = self.parse_type_from(&mut lookahead)?;
            types::pointer_declarator(&mut lookahead, target.ty)?;
            if lookahead.next_if(Token::Paren(')'))? {
                let target = self.cast_type()?;
                self.lexer.expect_span(Token::Paren(')'))?;
                let value = self.expression(UNARY_PRECEDENCE)?;
                let span = span.until(&value.span());
                return self.cast_source_value(value, target, span).map(Into::into);
            }
        }
        let value = self.comma_expression_result()?;
        self.lexer.expect_span(Token::Paren(')'))?;
        Ok(value)
    }

    fn unary_expression(
        &mut self,
        operator: Token<'_>,
        operator_span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lexer.next()?;
        let value = if operator == Token::Operation('&') {
            self.address_operand()?
        } else {
            self.expression(UNARY_PRECEDENCE)?
        };
        if self.is_source_class_value(&value) {
            return self.unary_operator(operator, value, operator_span);
        }
        if matches!(operator, Token::Operation('*' | '&'))
            || (operator == Token::Operation('+') && self.is_pointer_operand(&value))
        {
            return self.pointer_operator(operator, value, operator_span);
        }
        if operator == Token::Operation('!') {
            let value = self.truthy(value)?;
            let span = operator_span.until(&value.span);
            let handle = self.append(
                Expression::Unary {
                    op: UnaryOperator::LogicalNot,
                    expr: value.handle,
                },
                span,
            )?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::evaluated(value.constant.literal.and_then(|literal| {
                    constant_evaluation::unary(UnaryOperator::LogicalNot, literal)
                })),
                handle,
                ty: scalar_resolution(Scalar::BOOL),
                span,
            }
            .into());
        }
        if operator == Token::Operation('~') {
            let value = self.integral_operand(value)?;
            let span = operator_span.until(&value.span);
            let handle = self.append(
                Expression::Unary {
                    op: UnaryOperator::BitwiseNot,
                    expr: value.handle,
                },
                span,
            )?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::evaluated(value.constant.literal.and_then(|literal| {
                    constant_evaluation::unary(UnaryOperator::BitwiseNot, literal)
                })),
                handle,
                ty: value.ty,
                span,
            }
            .into());
        }
        let mut value = self.promote_integral(value)?;
        if operator == Token::Operation('+') {
            value.constant = value.constant.non_literal();
            return Ok(value.into());
        }
        let span = operator_span.until(&value.span);
        let expression = if self.require_scalar_type(&value.ty, value.span)? == Scalar::U32 {
            let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
            Expression::Binary {
                op: BinaryOperator::Subtract,
                left: zero,
                right: value.handle,
            }
        } else {
            Expression::Unary {
                op: UnaryOperator::Negate,
                expr: value.handle,
            }
        };
        let constant = value
            .constant
            .literal
            .and_then(|literal| constant_evaluation::unary(UnaryOperator::Negate, literal));
        let handle = if let Some(literal) = constant.filter(|_| value.constant.is_nonfinite()) {
            self.materialize_literal(literal, span)?
        } else {
            self.append(expression, span)?
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::evaluated(constant),
            handle,
            ty: value.ty,
            span,
        }
        .into())
    }

    fn word_expression(&mut self, name: &str, span: Span) -> Result<ExpressionResult, ParseError> {
        if name == "nullptr" {
            self.activate_parameter_expansion(span)?;
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            return Ok(ExpressionValue::NullPointer(NullPointerValue::literal(span)).into());
        }
        if name == "decltype" {
            self.lexer.expect_span(Token::Paren('('))?;
            self.expect_ident("nullptr")?;
            self.lexer.expect_span(Token::Paren(')'))?;
            return self.null_pointer_constructor(span);
        }
        if matches!(self.lookup_symbol(name), Some(Symbol::Member)) {
            return Err(ParseError {
                message: String::from("non-static structure member requires an object"),
                span,
            });
        }
        if name == "operator" {
            let (operator, span) = self.operator_name(span)?;
            return self.call(operator.name(), span);
        }
        if name == "static_cast" {
            return self.static_cast_expression(span);
        }
        if let Some(target) = self.type_name(name) {
            if target.qualifiers.is_volatile
                && !matches!(
                    target.ty,
                    TypeSpecifier::Scalar(_)
                        | TypeSpecifier::Pointer { .. }
                        | TypeSpecifier::Array(_)
                )
            {
                return self.fail("volatile class value construction is unsupported");
            }
            return self.type_expression(target, span);
        }
        if matches!(name, "true" | "false") {
            let handle = self.append(Expression::Literal(Literal::Bool(name == "true")), span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: Literal::Bool(name == "true").into(),
                handle,
                ty: scalar_resolution(Scalar::BOOL),
                span,
            }
            .into());
        }
        if matches!(name, "threadIdx" | "blockIdx" | "blockDim" | "gridDim") {
            return self.builtin(name, span).map(Into::into);
        }
        if self.lexer.peek()?.0 == Token::Paren('<') && self.has_function_template(name) {
            return self.template_call(name, span);
        }
        if self.lexer.peek()?.0 == Token::Paren('(') {
            return self.call(name, span);
        }
        self.variable_expression(name, span)
    }

    fn static_cast_expression(&mut self, span: Span) -> Result<ExpressionResult, ParseError> {
        self.lexer.expect_span(Token::Paren('<'))?;
        let target = self.cast_type()?;
        self.lexer.expect_span(Token::Paren('>'))?;
        self.lexer.expect_span(Token::Paren('('))?;
        let value = self.comma_expression()?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        self.cast_source_value(value, target, span.until(&end))
            .map(Into::into)
    }

    fn variable_expression(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let symbol = self.lookup_symbol(name).ok_or_else(|| ParseError {
            message: format!("unknown variable `{name}`"),
            span,
        })?;
        let symbol = match symbol {
            Symbol::DynamicShared(declaration) => {
                self.dynamic_shared_symbol(name, declaration, span)?
            }
            Symbol::ConstantMemory(declaration) => {
                self.constant_memory_symbol(declaration, span)?
            }
            symbol => symbol,
        };
        let (pointer, ty, qualifiers, span, constant) = match symbol {
            Symbol::NullPointer(mut value) => {
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                value.span = span;
                return Ok(ExpressionValue::NullPointer(value).into());
            }
            Symbol::TemplateParameter { scalar, literal } => {
                return self.template_parameter_value(scalar, literal, span);
            }
            Symbol::DynamicShared(_) | Symbol::ConstantMemory(_) => unreachable!(),
            Symbol::Namespace(_) => {
                return Err(ParseError {
                    message: String::from("namespace cannot be used as a value"),
                    span,
                })
            }
            Symbol::ThreadBlock => {
                return Ok(ExpressionResult::ThreadBlock(ThreadBlockValue {
                    span,
                    constant: ConstantValue {
                        literal: None,
                        is_discardable: true,
                        is_null_pointer_constant: false,
                    },
                }))
            }
            Symbol::Pointer(pointer) => {
                return self.pointer_symbol_value(pointer, span);
            }
            Symbol::PendingPointer => {
                return Err(ParseError {
                    message: String::from("pointer initializer cannot use its own binding"),
                    span,
                });
            }
            Symbol::PendingAuto => {
                return Err(ParseError {
                    message: String::from("auto initializer cannot use its own binding"),
                    span,
                });
            }
            Symbol::PendingThreadBlock => {
                return Err(ParseError {
                    message: String::from("thread_block initializer cannot use its own binding"),
                    span,
                })
            }
            Symbol::PendingReference => {
                return Err(ParseError {
                    message: String::from("reference initializer cannot use its own binding"),
                    span,
                });
            }
            Symbol::Reference {
                binding,
                ty,
                qualifiers,
                constant,
            } => {
                return Ok(ExpressionResult::Value(ExpressionValue::Reference(
                    ReferenceValue {
                        discard_read: true,
                        reference: Reference::Bound(binding),
                        qualifiers,
                        ty,
                        span,
                        constant,
                    },
                )));
            }
            Symbol::Member => {
                return Err(ParseError {
                    message: String::from("non-static structure member requires an object"),
                    span,
                });
            }
            Symbol::Type(_) | Symbol::TemplateTypeParameter { .. } => {
                return Err(ParseError {
                    message: format!("type `{name}` cannot be used as a value"),
                    span,
                });
            }
            Symbol::Array {
                pointer,
                ty,
                qualifiers,
            } => {
                if self.function.address_operand || self.lexer.peek()?.0 != Token::Paren('[') {
                    return self.borrowed_array_value(pointer, qualifiers, span);
                }
                let (pointer, ty, is_discardable) = self.array_element(pointer, ty, span)?;
                (
                    pointer,
                    ty,
                    qualifiers,
                    self.function.ir.expressions.get_span(pointer),
                    ConstantValue {
                        literal: None,
                        is_discardable,
                        is_null_pointer_constant: false,
                    },
                )
            }
            Symbol::Variable {
                pointer,
                ty,
                qualifiers,
            } => (
                pointer,
                ty,
                qualifiers,
                span,
                self.pointer_constant(pointer),
            ),
            Symbol::Constant {
                handle,
                scalar,
                literal,
            } => {
                return Ok(ExpressionResult::Value(ExpressionValue::Reference(
                    ReferenceValue {
                        discard_read: true,
                        reference: Reference::Constant(handle),
                        qualifiers: Qualifiers::CONST,
                        ty: scalar_resolution(scalar),
                        span,
                        constant: ConstantValue {
                            literal,
                            is_discardable: true,
                            is_null_pointer_constant: false,
                        },
                    },
                )));
            }
        };
        Ok(ExpressionResult::Value(ExpressionValue::Reference(
            ReferenceValue {
                discard_read: true,
                reference: Reference::Pointer(pointer),
                qualifiers,
                ty,
                span,
                constant,
            },
        )))
    }

    pub(super) fn type_expression(
        &mut self,
        target: QualifiedType,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        if matches!(target.ty, TypeSpecifier::Array(_)) {
            return Err(ParseError {
                message: String::from("array value construction is unsupported"),
                span,
            });
        }
        let mut result = self.type_value_expression(target.ty, span)?;
        if let ExpressionResult::Value(ExpressionValue::Plain(ref mut value)) = result {
            value.qualifiers = self.prvalue_qualifiers(&value.ty, target.qualifiers);
            value.constant = value.constant.non_literal();
        }
        Ok(result)
    }

    fn type_value_expression(
        &mut self,
        target: TypeSpecifier,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        if matches!(target, TypeSpecifier::NullPointer) {
            return self.null_pointer_constructor(span);
        }
        if matches!(target, TypeSpecifier::ThreadBlock) {
            return self.thread_block_copy();
        }
        if matches!(target, TypeSpecifier::Dim3) {
            return self.dim3_constructor(span).map(Into::into);
        }
        if let TypeSpecifier::Pointer {
            pointee,
            pointee_qualifiers,
        } = target
        {
            return self.pointer_value_constructor(pointee, pointee_qualifiers, span);
        }
        if matches!(
            target,
            TypeSpecifier::Structure(_) | TypeSpecifier::Vector { .. }
        ) {
            if self.lexer.peek()?.0 == Token::Paren('{') {
                return self.aggregate_value(target, span).map(Into::into);
            }
            return self.class_value_constructor(target, span).map(Into::into);
        }
        if let TypeSpecifier::Scalar(scalar) = target {
            if self.lexer.peek()?.0 == Token::Paren('{') {
                let mut value = self.scalar_list_initializer(scalar, true)?;
                value.span = span.until(&value.span);
                return Ok(value.into());
            }
        }
        self.lexer.expect_span(Token::Paren('('))?;
        if let TypeSpecifier::Scalar(scalar) = target {
            if self.lexer.peek()?.0 == Token::Paren(')') {
                let end = self.lexer.next()?.1;
                return self
                    .zero_scalar_value(scalar, span.until(&end))
                    .map(Into::into);
            }
        }
        let value = self.expression(0)?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        let target = self.lower_type(target, span)?;
        let mut value = self.cast_value(value, &target)?;
        value.span = span.until(&end);
        Ok(value.into())
    }

    fn class_value_constructor(
        &mut self,
        target: TypeSpecifier,
        span: Span,
    ) -> Result<Value, ParseError> {
        let opening = self.lexer.expect_span(Token::Paren('('))?;
        let ty = self.lower_type(target, span)?;
        if self.lexer.peek()?.0 == Token::Paren(')') {
            let end = self.lexer.next()?.1;
            let span = span.until(&end);
            let target_type = self.type_handle(&ty, span);
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                handle: self.default_initializer_value(target_type, span)?,
                ty,
                span,
                constant: ConstantValue {
                    literal: None,
                    is_discardable: !self.requires_default_constructor(target_type)
                        || self.const_default_constructible(target_type),
                    is_null_pointer_constant: false,
                },
            });
        }
        let pending_value = if self.lexer.peek()?.0 == Token::Paren('{') {
            None
        } else {
            let expression = self.expression(0)?;
            let value = self.rvalue(expression)?;
            if self.module.compare_types(&value.ty, &ty)
                || self.dimension_conversion(&value.ty, &ty)
            {
                let end = self.lexer.expect_span(Token::Paren(')'))?;
                let mut value = self.cast_value(value.into(), &ty)?;
                value.span = span.until(&end);
                return Ok(value);
            }
            Some(value)
        };
        let target_type = self.type_handle(&ty, span);
        let pointer = self.temporary_pointer(&ty, span)?;
        let constant =
            self.parenthesized_aggregate_initializer(pointer, target_type, opening, pending_value)?;
        let span = self.lexer.span_from(span.to_range().unwrap().start);
        let mut value = self.load_pointer(pointer, &ty, span)?;
        self.record_constructed_result(value.handle, pointer, span)?;
        value.constant = constant;
        Ok(value)
    }

    fn address_operand(&mut self) -> Result<ExpressionValue, ParseError> {
        let parent = self.function.address_operand;
        self.function.address_operand = true;
        let value = self.expression(UNARY_PRECEDENCE);
        self.function.address_operand = parent;
        value
    }

    pub(super) fn truthy(&mut self, value: ExpressionValue) -> Result<Value, ParseError> {
        if let ExpressionValue::NullPointer(value) = value {
            return self.null_pointer_boolean(value);
        }
        if self.is_pointer_operand(&value) {
            return self.pointer_test(value, false);
        }
        let value = self.rvalue(value)?;
        let scalar = self.require_scalar_type(&value.ty, value.span)?;
        if scalar == Scalar::BOOL {
            return Ok(value);
        }
        let literal = Literal::zero(scalar).ok_or_else(|| ParseError {
            message: String::from("condition requires a scalar value"),
            span: value.span,
        })?;
        let constant = value.constant.literal.and_then(|value| {
            constant_evaluation::binary(BinaryOperator::NotEqual, value, literal)
        });
        let handle = if let Some(literal) = constant.filter(|_| value.constant.is_nonfinite()) {
            self.materialize_literal(literal, value.span)?
        } else {
            let (comparison_value, zero_literal) = if scalar == Scalar::F32 {
                let magnitude = self.call_float_math_bits(
                    value.handle,
                    FloatMathFunction::AbsoluteValue,
                    value.span,
                )?;
                (magnitude, Literal::U32(0))
            } else {
                (value.handle, literal)
            };
            let zero = self.append(Expression::Literal(zero_literal), value.span)?;
            self.append(
                Expression::Binary {
                    op: BinaryOperator::NotEqual,
                    left: comparison_value,
                    right: zero,
                },
                value.span,
            )?
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::evaluated(constant),
            handle,
            ty: scalar_resolution(Scalar::BOOL),
            span: value.span,
        })
    }

    fn logical(
        &mut self,
        left: ExpressionValue,
        operator: BinaryOperator,
        precedence: u8,
        operator_span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let name = operators::Operator::from_binary(operator).unwrap().name();
        if !self.is_source_class_value(&left) && !self.has_function_candidate(name) {
            return self
                .builtin_logical(left, operator, |parser| parser.expression(precedence + 1))
                .map(Into::into);
        }
        if self.has_captured_candidate(name) {
            let (right, right_body) =
                self.capture_block(|parser| parser.expression(precedence + 1))?;
            if self.is_source_class_value(&left) || self.is_source_class_value(&right) {
                let span = left.span().until(&right.span());
                self.parameter_expansion_budget
                    .charge_slice::<CapturedArgument>(2, span)?;
                return self.call_with_captured_arguments(
                    name,
                    alloc::vec![
                        CapturedArgument {
                            value: left.into(),
                            body: crate::Block::new()
                        },
                        CapturedArgument {
                            value: right.into(),
                            body: right_body
                        }
                    ],
                    operator_span,
                    span,
                );
            }
            return self
                .builtin_logical(left, operator, |parser| {
                    parser.append_block(right_body);
                    Ok(right)
                })
                .map(Into::into);
        }
        let left = self.rvalue(left)?;
        let (right, right_body) = self.capture_block(|parser| parser.expression(precedence + 1))?;
        if self.is_source_class(&left.ty) || self.is_source_class_value(&right) {
            self.append_block(right_body);
            let right = self.rvalue(right)?;
            let span = left.span.until(&right.span);
            self.call_with_arguments(name, alloc::vec![left, right], operator_span, span)
        } else {
            self.builtin_logical(left.into(), operator, |parser| {
                parser.append_block(right_body);
                Ok(right)
            })
            .map(Into::into)
        }
    }

    fn builtin_logical(
        &mut self,
        left: ExpressionValue,
        operator: BinaryOperator,
        right: impl FnOnce(&mut Self) -> Result<ExpressionValue, ParseError>,
    ) -> Result<Value, ParseError> {
        let left = self.truthy(left)?;
        let ty = self.scalar_handle(Scalar::BOOL, left.span);
        let local = self.function.ir.local_variables.append(
            LocalVariable {
                name: None,
                ty,
                init: None,
            },
            left.span,
        );
        let pointer = self.append(Expression::LocalVariable(local), left.span)?;
        self.push_statement(
            Statement::Store {
                pointer,
                value: left.handle,
            },
            left.span,
        );
        let (right, right_body) = self.capture_block(|parser| {
            let right = right(parser)?;
            let right = parser.truthy(right)?;
            parser.push_statement(
                Statement::Store {
                    pointer,
                    value: right.handle,
                },
                right.span,
            );
            Ok(right)
        })?;
        let span = left.span.until(&right.span);
        let (accept, reject) = if operator == BinaryOperator::LogicalAnd {
            (right_body, crate::Block::new())
        } else {
            (crate::Block::new(), right_body)
        };
        self.push_statement(
            Statement::If {
                condition: left.handle,
                accept,
                reject,
            },
            span,
        );
        let handle = self.append(Expression::Load { pointer }, span)?;
        let constant = match left.constant.literal {
            Some(Literal::Bool(value)) if value == (operator == BinaryOperator::LogicalOr) => {
                Some(Literal::Bool(value))
            }
            Some(Literal::Bool(_)) => right.constant.literal,
            _ => None,
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::evaluated(constant),
            handle,
            ty: scalar_resolution(Scalar::BOOL),
            span,
        })
    }
}
