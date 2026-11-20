use super::*;

enum SizeofOperand {
    Scalar(SourceScalar),
    IntegerZeroLiteral(SourceScalar),
    Object(TypeResolution),
    IncompleteArray(TypeResolution),
    NullPointer,
}

struct RecordOffsetIndex {
    value: Option<i128>,
    scalar: SourceScalar,
    lvalue: Option<Qualifiers>,
}

impl RecordOffsetIndex {
    const fn prvalue(scalar: SourceScalar, value: Option<i128>) -> Self {
        Self {
            value,
            scalar,
            lvalue: None,
        }
    }

    fn boolean(value: bool) -> Self {
        Self::prvalue(SourceScalar::Scalar(Scalar::BOOL), Some(i128::from(value)))
    }
}

impl Parser<'_> {
    pub(super) fn record_offset_query(&mut self, span: Span) -> Result<Value, ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        let type_span = self.lexer.peek()?.1;
        let TypeSpecifier::Structure(mut record) = self.parse_type()?.ty else {
            return Err(ParseError {
                message: String::from("__builtin_offsetof requires a complete record type"),
                span: type_span,
            });
        };
        self.lexer.expect_span(Token::Separator(','))?;
        let mut offset = 0u32;
        loop {
            let (field, field_span) = self.identifier()?;
            let mut closing = match self.lexer.peek()?.0 {
                Token::Separator('.') | Token::Paren('[') => None,
                _ => Some(self.lexer.expect_span(Token::Paren(')'))?),
            };
            let (index, _) = self.field_type(&TypeResolution::Handle(record), field, field_span)?;
            let TypeInner::Struct { ref members, .. } = self.module.types[record].inner else {
                unreachable!();
            };
            let member = &members[index as usize];
            offset = Self::checked_record_offset(offset, u64::from(member.offset), field_span)?;
            let mut member_type = member.ty;
            if closing.is_none() {
                while self.lexer.next_if(Token::Paren('['))? {
                    (member_type, offset) =
                        self.record_offset_array_element(member_type, offset)?;
                }
                if !self.lexer.next_if(Token::Separator('.'))? {
                    closing = Some(self.lexer.expect_span(Token::Paren(')'))?);
                }
            }
            if let Some(closing) = closing {
                return self.type_query_result(offset, span.until(&closing));
            }
            self.parameter_expansion_budget.charge_work(1, field_span)?;
            record = member_type;
            if !self.structures.contains_key(&record) {
                return Err(ParseError {
                    message: String::from(
                        "__builtin_offsetof member path requires a complete record field",
                    ),
                    span: field_span,
                });
            }
        }
    }

    fn record_offset_array_element(
        &mut self,
        array: Handle<Type>,
        offset: u32,
    ) -> Result<(Handle<Type>, u32), ParseError> {
        let (index, span) = self.record_offset_index(self.function.expression_depth, 0, true)?;
        let index = index
            .value
            .and_then(|value| u32::try_from(value).ok())
            .ok_or_else(|| Self::invalid_record_offset_index(span))?;
        self.lexer.expect_span(Token::Paren(']'))?;
        let TypeInner::Array {
            base,
            size: ArraySize::Constant(count),
            stride,
        } = self.module.types[array].inner
        else {
            return Err(ParseError {
                message: String::from("__builtin_offsetof subscript requires a fixed array"),
                span,
            });
        };
        if index >= count.get() {
            return Err(ParseError {
                message: String::from("__builtin_offsetof index is out of bounds"),
                span,
            });
        }
        let bytes = u64::from(stride) * u64::from(index);
        Ok((base, Self::checked_record_offset(offset, bytes, span)?))
    }

    fn record_offset_index(
        &mut self,
        depth: u32,
        minimum_precedence: u8,
        evaluate: bool,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        let (mut left, mut span) = self.record_offset_index_prefix(depth, evaluate)?;
        while let Some((operator, precedence)) = expressions::binary_operator(self.lexer.peek()?.0)
        {
            if precedence < minimum_precedence {
                break;
            }
            let (_, operator_span) = self.lexer.next()?;
            self.parameter_expansion_budget
                .charge_work(1, operator_span)?;
            let short_circuit = match (operator, left.value) {
                (BinaryOperator::LogicalAnd, Some(0)) => Some(false),
                (BinaryOperator::LogicalOr, Some(value)) if value != 0 => Some(true),
                _ => None,
            };
            let (right, right_span) = self.record_offset_index(
                depth,
                precedence + 1,
                evaluate && short_circuit.is_none(),
            )?;
            left = match short_circuit {
                Some(value) => RecordOffsetIndex::boolean(value),
                None => Self::record_offset_binary(operator, left, right, operator_span)?,
            };
            span = span.until(&right_span);
        }
        let (token, question_span) = self.lexer.peek()?;
        if minimum_precedence != 0 || token != Token::Operation('?') {
            return Ok((left, span));
        }
        if depth >= 64 {
            return Err(ParseError {
                message: String::from("CUDA expression nesting limit exceeded"),
                span: question_span,
            });
        }
        self.lexer.next()?;
        self.parameter_expansion_budget
            .charge_work(1, question_span)?;
        let condition = left.value.map(|value| value != 0);
        let (accept, _) = self.record_offset_index(depth + 1, 0, condition == Some(true))?;
        let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
        self.parameter_expansion_budget.charge_work(1, colon_span)?;
        let (reject, reject_span) =
            self.record_offset_index(depth + 1, 0, condition == Some(false))?;
        let result = Self::record_offset_conditional(condition, accept, reject, question_span)?;
        Ok((result, span.until(&reject_span)))
    }

    fn record_offset_conditional(
        condition: Option<bool>,
        accept: RecordOffsetIndex,
        reject: RecordOffsetIndex,
        span: Span,
    ) -> Result<RecordOffsetIndex, ParseError> {
        let scalar = if accept.scalar == reject.scalar {
            accept.scalar
        } else {
            Self::arithmetic_scalar(accept.scalar, reject.scalar)
        };
        let lvalue = match (accept.lvalue, reject.lvalue) {
            (Some(left), Some(right))
                if accept.scalar == reject.scalar
                    && (left.contains(right) || right.contains(left)) =>
            {
                Some(left.union(right))
            }
            _ => None,
        };
        let value = match condition {
            Some(true) => accept.value,
            Some(false) => reject.value,
            None => None,
        };
        if value.is_some() && lvalue.is_some_and(|qualifiers| qualifiers.is_volatile) {
            return Err(ParseError {
                message: String::from(
                    "__builtin_offsetof index cannot read a volatile conditional result",
                ),
                span,
            });
        }
        let value = if accept.scalar == reject.scalar {
            value
        } else {
            value
                .map(|value| Self::record_offset_arithmetic(value, scalar, span))
                .transpose()?
        };
        Ok(RecordOffsetIndex {
            value,
            scalar,
            lvalue,
        })
    }

    fn record_offset_index_prefix(
        &mut self,
        depth: u32,
        evaluate: bool,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        if let Some(name) = self.qualified_item()? {
            self.parameter_expansion_budget.charge_work(3, name.span)?;
            let cooperative_groups::QualifiedItem::Type(target) = name.item else {
                return Err(Self::invalid_record_offset_index(name.span));
            };
            return self.record_offset_functional_cast(target, depth, evaluate, name.span);
        }
        let (token, span) = self.lexer.next()?;
        let invalid = || Self::invalid_record_offset_index(span);
        let number = match token {
            Token::Paren('(') | Token::Operation('+' | '-' | '~' | '!') => {
                if depth >= 64 {
                    return Err(ParseError {
                        message: String::from("CUDA expression nesting limit exceeded"),
                        span,
                    });
                }
                self.parameter_expansion_budget.charge_work(1, span)?;
                if let Token::Operation(operator) = token {
                    let (operand, operand_span) =
                        self.record_offset_index_prefix(depth + 1, evaluate)?;
                    let result = Self::record_offset_unary(operator, operand, span)?;
                    return Ok((result, span.until(&operand_span)));
                }
                if self.starts_type()? {
                    self.parameter_expansion_budget.charge_work(2, span)?;
                    let mut lookahead = self.lexer.clone();
                    let target_span = lookahead.peek()?.1;
                    let target = self.parse_type_from(&mut lookahead)?;
                    if lookahead.next_if(Token::Paren(')'))? {
                        let scalar = target
                            .ty
                            .source_scalar()
                            .filter(|&scalar| Self::record_offset_integral_scalar(scalar))
                            .ok_or_else(|| ParseError {
                                message: String::from(
                                    "__builtin_offsetof C-style cast requires an integral scalar target",
                                ),
                                span: target_span,
                            })?;
                        self.lexer = lookahead;
                        let (operand, end) =
                            self.record_offset_index_prefix(depth + 1, evaluate)?;
                        return Ok((Self::record_offset_cast(scalar, operand.value), span.until(&end)));
                    }
                }
                let (operand, _) = self.record_offset_index(depth + 1, 0, evaluate)?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                self.parameter_expansion_budget.charge_work(1, closing)?;
                return Ok((operand, span.until(&closing)));
            }
            Token::Number(text) => {
                self.parameter_expansion_budget
                    .charge_work(text.len() + 1, span)?;
                if text.contains('\'') {
                    self.parameter_expansion_budget
                        .charge_bytes(text.len(), span)?;
                }
                number::parse_integer(text)
            }
            Token::Word(word @ ("true" | "false")) => {
                self.parameter_expansion_budget
                    .charge_work(word.len() + 1, span)?;
                Some(Literal::Bool(word == "true").into())
            }
            Token::Word("static_cast") => {
                return self.record_offset_static_cast(depth, evaluate, span);
            }
            Token::Word(name @ ("sizeof" | "alignof")) => {
                return self.record_offset_type_query(name, depth, evaluate, span);
            }
            Token::Word("decltype") => {
                self.parameter_expansion_budget.charge_work(4, span)?;
                let (target, end) = self.decltype_operand_type()?;
                return self.record_offset_functional_cast(target, depth, evaluate, span.until(&end));
            }
            Token::Word(name) => {
                self.parameter_expansion_budget
                    .charge_work(name.len() + 1, span)?;
                let target = if self.lexer.peek()?.0 == Token::Paren('(') {
                    self.type_name(name)
                } else {
                    None
                };
                if let Some(target) = target {
                    return self.record_offset_functional_cast(target, depth, evaluate, span);
                }
                let symbol = self.record_offset_index_symbol(name).ok_or_else(invalid)?;
                let (scalar, lvalue) = self
                    .record_offset_integral_symbol(&symbol)
                    .ok_or_else(invalid)?;
                let value = if evaluate {
                    Some(
                        self.record_offset_named_constant(symbol)
                            .and_then(Self::record_offset_literal_value)
                            .ok_or_else(invalid)?,
                    )
                } else {
                    None
                };
                return Ok((
                    RecordOffsetIndex {
                        value,
                        scalar,
                        lvalue,
                    },
                    span,
                ));
            }
            _ => None,
        }
        .ok_or_else(invalid)?;
        let value = Self::record_offset_literal_value(number.literal).ok_or_else(invalid)?;
        Ok((
            RecordOffsetIndex::prvalue(number.scalar, evaluate.then_some(value)),
            span,
        ))
    }

    fn record_offset_literal_value(literal: Literal) -> Option<i128> {
        Some(match literal {
            Literal::Bool(value) => i128::from(value),
            Literal::I16(value) => i128::from(value),
            Literal::U16(value) => i128::from(value),
            Literal::I32(value) => i128::from(value),
            Literal::U32(value) => i128::from(value),
            Literal::I64(value) => i128::from(value),
            Literal::U64(value) => i128::from(value),
            _ => return None,
        })
    }

    fn record_offset_type_query(
        &mut self,
        name: &str,
        depth: u32,
        evaluate: bool,
        start: Span,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        if depth >= 64 {
            return Err(ParseError {
                message: String::from("CUDA expression nesting limit exceeded"),
                span: start,
            });
        }
        self.parameter_expansion_budget.charge_work(3, start)?;
        self.lexer.expect_span(Token::Paren('('))?;
        let target_span = self.lexer.peek()?.1;
        let ty = self.parse_type()?.ty;
        let size = if let Some(scalar) = ty.source_scalar() {
            // The supported scalar types have natural alignment equal to their size.
            u32::from(scalar.scalar().width)
        } else if name == "sizeof" {
            self.record_offset_aggregate_size(ty).ok_or_else(|| ParseError {
                message: String::from(
                    "__builtin_offsetof nested sizeof requires a scalar, vector, complete record, or fixed-array type",
                ),
                span: target_span,
            })?
        } else {
            self.record_offset_aggregate_alignment(ty, target_span)?
                .ok_or_else(|| ParseError {
                    message: String::from(
                        "__builtin_offsetof nested alignof requires a scalar, vector, complete record, or array type with a supported element",
                    ),
                    span: target_span,
                })?
        };
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        let value = evaluate.then_some(i128::from(size));
        Ok((
            RecordOffsetIndex::prvalue(SourceScalar::Long(ScalarKind::Uint), value),
            start.until(&end),
        ))
    }

    fn record_offset_aggregate_size(&self, ty: TypeSpecifier) -> Option<u32> {
        let handle = match ty {
            TypeSpecifier::Vector {
                component_count,
                scalar,
            } => {
                return Some(u32::from(component_count) * u32::from(scalar.width));
            }
            TypeSpecifier::Structure(handle) if self.structures.contains_key(&handle) => handle,
            TypeSpecifier::Array(handle) => handle,
            _ => return None,
        };
        let inner = &self.module.types[handle].inner;
        match *inner {
            TypeInner::Struct { .. }
            | TypeInner::Array {
                size: ArraySize::Constant(_),
                ..
            } => inner.try_size(self.module.to_ctx()),
            _ => None,
        }
    }

    fn record_offset_aggregate_alignment(
        &mut self,
        ty: TypeSpecifier,
        span: Span,
    ) -> Result<Option<u32>, ParseError> {
        Ok(match ty {
            TypeSpecifier::Vector {
                component_count,
                scalar,
            } => Some(Self::record_offset_vector_alignment(
                component_count,
                scalar,
            )),
            TypeSpecifier::Structure(handle) => self
                .structures
                .get(&handle)
                .map(|record| record.alignment * 1),
            TypeSpecifier::Array(handle) => {
                let (element, _) = self.array_shape(handle, span)?;
                let ty = &self.module.types[element];
                match ty.inner {
                    TypeInner::Scalar(scalar) => Some(u32::from(scalar.width)),
                    TypeInner::Vector { size, scalar } => {
                        Some(Self::record_offset_vector_alignment(u8::from(size), scalar))
                    }
                    TypeInner::Struct { .. } => {
                        if let Some(record) = self.structures.get(&element) {
                            Some(record.alignment * 1)
                        } else {
                            self.parameter_expansion_budget
                                .charge_work(types::VECTOR_TYPES.len(), span)?;
                            types::VECTOR_TYPES
                                .iter()
                                .find_map(|&(name, _, count, scalar)| {
                                    (ty.name.as_deref() == Some(name)).then(|| {
                                        Self::record_offset_vector_alignment(count, scalar)
                                    })
                                })
                        }
                    }
                    _ => None,
                }
            }
            _ => None,
        })
    }

    const fn record_offset_vector_alignment(component_count: u8, scalar: Scalar) -> u32 {
        // CUDA's one- and three-lane vectors use the alignment of a single lane.
        match component_count {
            1 | 3 => scalar.width as u32,
            2 | 4 => component_count as u32 * scalar.width as u32,
            _ => unreachable!(),
        }
    }

    fn record_offset_static_cast(
        &mut self,
        depth: u32,
        evaluate: bool,
        start: Span,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        if depth >= 64 {
            return Err(ParseError {
                message: String::from("CUDA expression nesting limit exceeded"),
                span: start,
            });
        }
        self.parameter_expansion_budget.charge_work(5, start)?;
        self.lexer.expect_span(Token::Paren('<'))?;
        let target_span = self.lexer.peek()?.1;
        let scalar = self
            .parse_type()?
            .ty
            .source_scalar()
            .filter(|&scalar| Self::record_offset_integral_scalar(scalar))
            .ok_or_else(|| ParseError {
                message: String::from(
                    "__builtin_offsetof static_cast requires an integral scalar target",
                ),
                span: target_span,
            })?;
        self.lexer.expect_span(Token::Paren('>'))?;
        self.lexer.expect_span(Token::Paren('('))?;
        let (operand, _) = self.record_offset_index(depth + 1, 0, evaluate)?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        Ok((
            Self::record_offset_cast(scalar, operand.value),
            start.until(&end),
        ))
    }

    fn record_offset_functional_cast(
        &mut self,
        target: QualifiedType,
        depth: u32,
        evaluate: bool,
        start: Span,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        if depth >= 64 {
            return Err(ParseError {
                message: String::from("CUDA expression nesting limit exceeded"),
                span: start,
            });
        }
        let scalar = target
            .ty
            .source_scalar()
            .filter(|&scalar| Self::record_offset_integral_scalar(scalar))
            .ok_or_else(|| ParseError {
                message: String::from(
                    "__builtin_offsetof functional cast requires an integral scalar target",
                ),
                span: start,
            })?;
        self.parameter_expansion_budget.charge_work(2, start)?;
        self.lexer.expect_span(Token::Paren('('))?;
        let value = if self.lexer.peek()?.0 == Token::Paren(')') {
            evaluate.then_some(0)
        } else {
            self.record_offset_index(depth + 1, 0, evaluate)?.0.value
        };
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        Ok((Self::record_offset_cast(scalar, value), start.until(&end)))
    }

    fn record_offset_cast(scalar: SourceScalar, value: Option<i128>) -> RecordOffsetIndex {
        let value = value.map(|value| match scalar.scalar() {
            Scalar::BOOL => i128::from(value != 0),
            Scalar::I16 => i128::from(value as i16),
            Scalar::U16 => i128::from(value as u16),
            Scalar::I32 => i128::from(value as i32),
            Scalar::U32 => i128::from(value as u32),
            Scalar::I64 => i128::from(value as i64),
            Scalar::U64 => i128::from(value as u64),
            _ => unreachable!(),
        });
        RecordOffsetIndex::prvalue(scalar, value)
    }

    fn record_offset_unary(
        operator: char,
        operand: RecordOffsetIndex,
        span: Span,
    ) -> Result<RecordOffsetIndex, ParseError> {
        let scalar = if operator == '!' {
            SourceScalar::Scalar(Scalar::BOOL)
        } else {
            Self::promoted_type_query_scalar(operand.scalar)
        };
        let value = if let Some(value) = operand.value {
            let value = match operator {
                '+' => value,
                '-' => -value,
                '~' => !value,
                '!' => return Ok(RecordOffsetIndex::boolean(value == 0)),
                _ => unreachable!(),
            };
            Some(Self::record_offset_arithmetic(value, scalar, span)?)
        } else {
            None
        };
        Ok(RecordOffsetIndex::prvalue(scalar, value))
    }

    fn record_offset_arithmetic(
        value: i128,
        scalar: SourceScalar,
        span: Span,
    ) -> Result<i128, ParseError> {
        // Reducing the result modulo the unsigned width also accounts for operand conversion.
        match scalar.scalar() {
            Scalar::I32 => i32::try_from(value).ok().map(i128::from),
            Scalar::I64 => i64::try_from(value).ok().map(i128::from),
            Scalar::U32 => Some(i128::from(value as u32)),
            Scalar::U64 => Some(i128::from(value as u64)),
            _ => unreachable!(),
        }
        .ok_or_else(|| ParseError {
            message: String::from("__builtin_offsetof index has signed overflow"),
            span,
        })
    }

    fn record_offset_binary(
        operator: BinaryOperator,
        left: RecordOffsetIndex,
        right: RecordOffsetIndex,
        span: Span,
    ) -> Result<RecordOffsetIndex, ParseError> {
        let scalar = match operator {
            BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight => {
                Self::promoted_type_query_scalar(left.scalar)
            }
            BinaryOperator::Less
            | BinaryOperator::LessEqual
            | BinaryOperator::Greater
            | BinaryOperator::GreaterEqual
            | BinaryOperator::Equal
            | BinaryOperator::NotEqual
            | BinaryOperator::LogicalAnd
            | BinaryOperator::LogicalOr => SourceScalar::Scalar(Scalar::BOOL),
            _ => Self::arithmetic_scalar(left.scalar, right.scalar),
        };
        let (Some(left_value), Some(right_value)) = (left.value, right.value) else {
            return Ok(RecordOffsetIndex::prvalue(scalar, None));
        };
        let value = match operator {
            BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight => {
                Self::record_offset_shift(operator, left_value, right_value, scalar, span)?
            }
            BinaryOperator::Multiply | BinaryOperator::Divide | BinaryOperator::Modulo => {
                Self::record_offset_product(operator, left_value, right_value, scalar, span)?
            }
            BinaryOperator::Less
            | BinaryOperator::LessEqual
            | BinaryOperator::Greater
            | BinaryOperator::GreaterEqual
            | BinaryOperator::Equal
            | BinaryOperator::NotEqual => {
                let common = Self::arithmetic_scalar(left.scalar, right.scalar);
                Self::record_offset_comparison(operator, left_value, right_value, common, span)?
            }
            BinaryOperator::LogicalAnd => i128::from(left_value != 0 && right_value != 0),
            BinaryOperator::LogicalOr => i128::from(left_value != 0 || right_value != 0),
            BinaryOperator::Add => {
                Self::record_offset_arithmetic(left_value + right_value, scalar, span)?
            }
            BinaryOperator::Subtract => {
                Self::record_offset_arithmetic(left_value - right_value, scalar, span)?
            }
            BinaryOperator::And => {
                Self::record_offset_arithmetic(left_value & right_value, scalar, span)?
            }
            BinaryOperator::ExclusiveOr => {
                Self::record_offset_arithmetic(left_value ^ right_value, scalar, span)?
            }
            BinaryOperator::InclusiveOr => {
                Self::record_offset_arithmetic(left_value | right_value, scalar, span)?
            }
        };
        Ok(RecordOffsetIndex::prvalue(scalar, Some(value)))
    }

    fn record_offset_comparison(
        operator: BinaryOperator,
        left: i128,
        right: i128,
        scalar: SourceScalar,
        span: Span,
    ) -> Result<i128, ParseError> {
        let left = Self::record_offset_arithmetic(left, scalar, span)?;
        let right = Self::record_offset_arithmetic(right, scalar, span)?;
        let value = match operator {
            BinaryOperator::Less => left < right,
            BinaryOperator::LessEqual => left <= right,
            BinaryOperator::Greater => left > right,
            BinaryOperator::GreaterEqual => left >= right,
            BinaryOperator::Equal => left == right,
            BinaryOperator::NotEqual => left != right,
            _ => unreachable!(),
        };
        Ok(i128::from(value))
    }

    fn record_offset_product(
        operator: BinaryOperator,
        left: i128,
        right: i128,
        scalar: SourceScalar,
        span: Span,
    ) -> Result<i128, ParseError> {
        let left = Self::record_offset_arithmetic(left, scalar, span)?;
        let right = Self::record_offset_arithmetic(right, scalar, span)?;
        let value = match (operator, scalar.scalar()) {
            (BinaryOperator::Multiply, Scalar::U64) => {
                i128::from((left as u64).wrapping_mul(right as u64))
            }
            (BinaryOperator::Multiply, _) => left * right,
            (BinaryOperator::Divide | BinaryOperator::Modulo, _) if right == 0 => {
                let operation = if operator == BinaryOperator::Divide {
                    "division"
                } else {
                    "remainder"
                };
                return Err(ParseError {
                    message: format!("__builtin_offsetof index has {operation} by zero"),
                    span,
                });
            }
            (BinaryOperator::Divide, _) => left / right,
            (BinaryOperator::Modulo, _) => {
                // The quotient must be representable even for remainder.
                if right == -1 {
                    Self::record_offset_arithmetic(-left, scalar, span)?;
                }
                left % right
            }
            _ => unreachable!(),
        };
        Self::record_offset_arithmetic(value, scalar, span)
    }

    fn record_offset_shift(
        operator: BinaryOperator,
        left: i128,
        right: i128,
        scalar: SourceScalar,
        span: Span,
    ) -> Result<i128, ParseError> {
        let width = u32::from(scalar.scalar().width) * 8;
        let count = u32::try_from(right)
            .ok()
            .filter(|&count| count < width)
            .ok_or_else(|| ParseError {
                message: String::from("__builtin_offsetof index has an out-of-range shift count"),
                span,
            })?;
        let value = match (operator, scalar.scalar()) {
            (BinaryOperator::ShiftLeft, Scalar::I32) => {
                i128::from((left as i32).wrapping_shl(count))
            }
            (BinaryOperator::ShiftLeft, Scalar::U32) => {
                i128::from((left as u32).wrapping_shl(count))
            }
            (BinaryOperator::ShiftLeft, Scalar::I64) => {
                i128::from((left as i64).wrapping_shl(count))
            }
            (BinaryOperator::ShiftLeft, Scalar::U64) => {
                i128::from((left as u64).wrapping_shl(count))
            }
            (BinaryOperator::ShiftRight, _) => left >> count,
            _ => unreachable!(),
        };
        Ok(value)
    }

    fn invalid_record_offset_index(span: Span) -> ParseError {
        ParseError {
            message: String::from(
                "__builtin_offsetof index requires an integer literal, Boolean literal, or named integral constant with a nonnegative value that fits in 32 bits",
            ),
            span,
        }
    }

    fn record_offset_index_symbol(&self, name: &str) -> Option<Symbol> {
        if (self.function.parsing_default || self.function.parsing_exception_specification)
            && self.function.symbol_table.lookup(name).is_some()
        {
            return None;
        }
        self.lookup_symbol(name)
    }

    fn record_offset_integral_symbol(
        &self,
        symbol: &Symbol,
    ) -> Option<(SourceScalar, Option<Qualifiers>)> {
        let (scalar, lvalue) = match *symbol {
            Symbol::Constant { ref ty, .. } => (self.source_scalar(ty)?, Some(Qualifiers::CONST)),
            Symbol::Variable {
                ref ty, qualifiers, ..
            }
            | Symbol::Reference {
                ref ty, qualifiers, ..
            } => (self.source_scalar(ty)?, Some(qualifiers)),
            Symbol::TemplateFunctionParameter(Some(SourceType::Shader(ty))) => (
                self.source_scalar(&TypeResolution::Handle(ty))?,
                Some(Qualifiers::NONE),
            ),
            Symbol::ConstantMemory(declaration) => (
                self.source_scalar(&TypeResolution::Handle(
                    self.constant_memory_type(declaration),
                ))?,
                Some(declaration.qualifiers),
            ),
            Symbol::TemplateParameter { scalar, .. } => (scalar, None),
            _ => return None,
        };
        Self::record_offset_integral_scalar(scalar).then_some((scalar, lvalue))
    }

    const fn record_offset_integral_scalar(scalar: SourceScalar) -> bool {
        matches!(
            scalar.scalar(),
            Scalar::BOOL
                | Scalar::I16
                | Scalar::U16
                | Scalar::I32
                | Scalar::U32
                | Scalar::I64
                | Scalar::U64
        )
    }

    fn record_offset_named_constant(&self, symbol: Symbol) -> Option<Literal> {
        match symbol {
            Symbol::Constant { literal, .. } | Symbol::TemplateParameter { literal, .. } => literal,
            Symbol::Variable {
                pointer,
                qualifiers,
                ..
            } if qualifiers.is_const && !qualifiers.is_volatile => {
                let Expression::LocalVariable(local) = self.function.ir.expressions[pointer] else {
                    return None;
                };
                self.function.constant_locals.get(&local).copied()
            }
            _ => None,
        }
    }

    fn checked_record_offset(offset: u32, bytes: u64, span: Span) -> Result<u32, ParseError> {
        u64::from(offset)
            .checked_add(bytes)
            .filter(|&total| total <= u64::from(crate::valid::MAX_TYPE_SIZE))
            .map(|total| total as u32)
            .ok_or_else(|| ParseError {
                message: String::from("CUDA record member offset exceeds the type size limit"),
                span,
            })
    }

    pub(super) fn type_query(&mut self, name: &str, span: Span) -> Result<Value, ParseError> {
        let operand_start = self.lexer.clone();
        let parenthesized = self.lexer.next_if(Token::Paren('('))?;
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        if name == "sizeof" {
            let (token, operand_span) = self.lexer.peek()?;
            let expression_operand = match token {
                Token::Operation('*' | '+' | '-' | '~' | '!')
                | Token::Paren('(')
                | Token::Number(_)
                | Token::Word("true" | "false" | "nullptr" | "static_cast") => true,
                Token::Word(operand)
                    if self
                        .type_name(operand)
                        .is_some_and(|ty| ty.ty.source_scalar().is_some()) =>
                {
                    self.parameter_expansion_budget
                        .charge_work(1, operand_span)?;
                    let mut lookahead = self.lexer.clone();
                    lookahead.next()?;
                    lookahead.peek()?.0 == Token::Paren('(')
                }
                Token::Word(operand) => self.lookup_symbol(operand).is_some_and(|symbol| {
                    !matches!(
                        symbol,
                        Symbol::Type(_)
                            | Symbol::TemplateTypeParameter { .. }
                            | Symbol::Namespace(_)
                    )
                }),
                _ => false,
            };
            if expression_operand {
                self.lexer = operand_start;
                let (operand, operand_span) = self.sizeof_operand()?;
                let span = span.until(&operand_span);
                let value = self.sizeof_operand_size(operand, span)?;
                return self.type_query_result(value, span);
            }
        }
        if !parenthesized {
            return self.fail("type queries require a parenthesized type or sizeof a named object");
        }

        let mut lookahead = self.lexer.clone();
        let qualifiers = types::declaration_qualifiers(&mut lookahead, Qualifiers::NONE, false)?;
        let operand = if lookahead.next_if(Token::Word("void"))? {
            types::declaration_qualifiers(&mut lookahead, qualifiers, false)?;
            self.lexer = lookahead;
            None
        } else {
            Some(self.parse_type()?)
        };

        let mut pointer_depth = usize::from(matches!(
            operand,
            Some(QualifiedType {
                ty: TypeSpecifier::Pointer { .. },
                ..
            })
        ));
        while self.lexer.next_if(Token::Operation('*'))? {
            self.parameter_expansion_budget.charge_work(1, span)?;
            pointer_depth += 1;
            if pointer_depth > 64 {
                return self.fail("CUDA pointer nesting limit exceeded");
            }
            types::pointer_qualifiers(&mut self.lexer)?;
        }
        if operand.is_none() && pointer_depth == 0 {
            return Err(ParseError {
                message: String::from("type queries require a complete object type"),
                span,
            });
        }

        let reference = self.lexer.next_if(Token::Operation('&'))?
            || self.lexer.next_if(Token::LogicalOperation('&'))?;
        if (reference || pointer_depth != 0) && self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("direct arrays of pointers or references are unsupported");
        }
        let value = if pointer_depth != 0 {
            8
        } else {
            let operand = operand.unwrap();
            let ty = if reference {
                operand.ty
            } else {
                self.array_alias_declarator(operand, span)?.ty
            };
            self.type_query_value(name, ty, span)?
        };
        let closing = self.lexer.expect_span(Token::Paren(')'))?;
        self.type_query_result(value, span.until(&closing))
    }

    fn type_query_result(&mut self, value: u32, span: Span) -> Result<Value, ParseError> {
        let literal = Literal::U64(u64::from(value));
        let ty = self.source_scalar_resolution(SourceScalar::Long(ScalarKind::Uint), span)?;
        let handle = self.append(Expression::Literal(literal), span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: literal.into(),
            handle,
            ty,
            span,
        })
    }

    fn type_query_value(
        &mut self,
        name: &str,
        operand: TypeSpecifier,
        span: Span,
    ) -> Result<u32, ParseError> {
        if matches!(
            operand,
            TypeSpecifier::Pointer { .. } | TypeSpecifier::NullPointer
        ) {
            return Ok(8);
        }
        let resolution = self.lower_type(operand, span)?;
        self.type_query_layout(name, resolution, span)
    }

    fn sizeof_operand(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        self.function.expression_depth += 1;
        let result = (|| {
            if self.function.expression_depth > 64 {
                return self.fail("CUDA expression nesting limit exceeded");
            }
            self.parameter_expansion_budget
                .charge_work(1, self.lexer.peek()?.1)?;
            self.sizeof_operand_inner()
        })();
        self.function.expression_depth -= 1;
        result
    }

    fn sizeof_comma_expression(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (mut operand, mut span) = self.sizeof_conditional_expression()?;
        while let (Token::Separator(','), comma_span) = self.lexer.peek()? {
            self.lexer.next()?;
            self.parameter_expansion_budget.charge_work(1, comma_span)?;
            let (right, right_span) = self.sizeof_conditional_expression()?;
            operand = match right {
                SizeofOperand::IntegerZeroLiteral(scalar) => SizeofOperand::Scalar(scalar),
                other => other,
            };
            span = span.until(&right_span);
        }
        Ok((operand, span))
    }

    fn sizeof_conditional_expression(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (condition, condition_span) = self.sizeof_binary_expression(0)?;
        let (token, question_span) = self.lexer.peek()?;
        if token != Token::Operation('?') {
            return Ok((condition, condition_span));
        }
        self.lexer.next()?;

        self.function.expression_depth += 1;
        let result = (|| {
            if self.function.expression_depth > 64 {
                return self.fail("CUDA expression nesting limit exceeded");
            }
            self.parameter_expansion_budget
                .charge_work(1, question_span)?;
            if !self.sizeof_bool_convertible(&condition) {
                return Err(ParseError {
                    message: String::from(
                        "sizeof conditional requires a scalar, pointer, array, or nullptr condition",
                    ),
                    span: condition_span,
                });
            }
            let (accept, accept_span) = self.sizeof_comma_expression()?;
            let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
            self.parameter_expansion_budget.charge_work(1, colon_span)?;
            let (reject, reject_span) = self.sizeof_conditional_expression()?;
            let operand = match (accept, reject) {
                (SizeofOperand::Object(left), SizeofOperand::Object(right))
                    if self.source_pointer_pointee(&left).is_some_and(|pointee| {
                        self.source_pointer_pointee(&right) == Some(pointee)
                            && !matches!(
                                self.module.types[pointee].inner,
                                TypeInner::Pointer { .. }
                            )
                    }) =>
                {
                    SizeofOperand::Object(left)
                }
                (
                    SizeofOperand::Object(ty),
                    SizeofOperand::NullPointer | SizeofOperand::IntegerZeroLiteral(_),
                )
                | (
                    SizeofOperand::NullPointer | SizeofOperand::IntegerZeroLiteral(_),
                    SizeofOperand::Object(ty),
                ) if self.source_pointer_pointee(&ty).is_some() => SizeofOperand::Object(ty),
                (SizeofOperand::NullPointer, SizeofOperand::NullPointer) => {
                    SizeofOperand::NullPointer
                }
                (accept, reject) => {
                    let scalar_arm = |operand, span| {
                        self.sizeof_source_scalar(operand).ok_or_else(|| ParseError {
                            message: String::from(
                                "sizeof conditional requires scalar arms, matching single-level pointer arms, a pointer with nullptr or literal integer zero, or two nullptr arms",
                            ),
                            span,
                        })
                    };
                    let accept = scalar_arm(&accept, accept_span)?;
                    let reject = scalar_arm(&reject, reject_span)?;
                    SizeofOperand::Scalar(if accept == reject {
                        accept
                    } else {
                        Self::arithmetic_scalar(accept, reject)
                    })
                }
            };
            Ok((operand, condition_span.until(&reject_span)))
        })();
        self.function.expression_depth -= 1;
        result
    }

    fn sizeof_binary_expression(
        &mut self,
        minimum_precedence: u8,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (mut left, mut span) = self.sizeof_operand()?;
        while let Some((operator, precedence)) = expressions::binary_operator(self.lexer.peek()?.0)
        {
            if precedence < minimum_precedence {
                break;
            }
            let operator_span = self.lexer.next()?.1;
            self.parameter_expansion_budget
                .charge_work(1, operator_span)?;
            let (right, right_span) = self.sizeof_binary_expression(precedence + 1)?;
            left = self.sizeof_binary_operand(operator, left, right, operator_span)?;
            span = span.until(&right_span);
        }
        Ok((left, span))
    }

    fn sizeof_source_scalar(&self, operand: &SizeofOperand) -> Option<SourceScalar> {
        match *operand {
            SizeofOperand::Scalar(scalar) | SizeofOperand::IntegerZeroLiteral(scalar) => {
                Some(scalar)
            }
            SizeofOperand::Object(ref ty) => self.source_scalar(ty),
            _ => None,
        }
    }

    fn sizeof_bool_convertible(&self, operand: &SizeofOperand) -> bool {
        match *operand {
            SizeofOperand::Object(ref ty) => {
                self.source_scalar(ty).is_some()
                    || self.source_pointer_pointee(ty).is_some()
                    || matches!(ty.inner_with(&self.module.types), TypeInner::Array { .. })
            }
            SizeofOperand::Scalar(_)
            | SizeofOperand::IntegerZeroLiteral(_)
            | SizeofOperand::IncompleteArray(_)
            | SizeofOperand::NullPointer => true,
        }
    }

    const fn promoted_type_query_scalar(scalar: SourceScalar) -> SourceScalar {
        if matches!(scalar.scalar(), Scalar::BOOL | Scalar::I16 | Scalar::U16) {
            SourceScalar::Scalar(Scalar::I32)
        } else {
            scalar
        }
    }

    fn sizeof_binary_operand(
        &self,
        operator: BinaryOperator,
        left: SizeofOperand,
        right: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from("sizeof binary operator requires supported scalar operands"),
            span,
        };
        let left = self.sizeof_source_scalar(&left).ok_or_else(invalid)?;
        let right = self.sizeof_source_scalar(&right).ok_or_else(invalid)?;
        let integral = |scalar: SourceScalar| {
            matches!(
                scalar.scalar().kind,
                ScalarKind::Sint | ScalarKind::Uint | ScalarKind::Bool
            )
        };
        let common = Self::arithmetic_scalar(left, right);
        let scalar = match operator {
            BinaryOperator::Add
            | BinaryOperator::Subtract
            | BinaryOperator::Multiply
            | BinaryOperator::Divide => common,
            BinaryOperator::Modulo
            | BinaryOperator::And
            | BinaryOperator::InclusiveOr
            | BinaryOperator::ExclusiveOr => {
                if !integral(left) || !integral(right) {
                    return Err(invalid());
                }
                common
            }
            BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight => {
                if !integral(left) || !integral(right) {
                    return Err(invalid());
                }
                Self::promoted_type_query_scalar(left)
            }
            BinaryOperator::Equal
            | BinaryOperator::NotEqual
            | BinaryOperator::Less
            | BinaryOperator::LessEqual
            | BinaryOperator::Greater
            | BinaryOperator::GreaterEqual
            | BinaryOperator::LogicalAnd
            | BinaryOperator::LogicalOr => SourceScalar::Scalar(Scalar::BOOL),
        };
        Ok(SizeofOperand::Scalar(scalar))
    }

    fn sizeof_operand_inner(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (token, start) = self.lexer.next()?;
        let (mut operand, mut end) = match token {
            Token::Operation('*') => {
                let (operand, end) = self.sizeof_operand()?;
                let span = start.until(&end);
                return self
                    .sizeof_dereference(operand, span)
                    .map(|operand| (operand, span));
            }
            Token::Operation(operator @ ('+' | '-' | '~' | '!')) => {
                let (operand, end) = self.sizeof_operand()?;
                let span = start.until(&end);
                return self
                    .sizeof_unary(operator, operand, span)
                    .map(|operand| (operand, span));
            }
            Token::Paren('(') => {
                self.parameter_expansion_budget.charge_work(1, start)?;
                if self.starts_type()? {
                    self.parameter_expansion_budget.charge_work(2, start)?;
                    let mut lookahead = self.lexer.clone();
                    let target_span = lookahead.peek()?.1;
                    let target = self.parse_type_from(&mut lookahead)?;
                    if lookahead.next_if(Token::Paren(')'))? {
                        let scalar = target.ty.source_scalar().ok_or_else(|| ParseError {
                            message: String::from(
                                "sizeof C-style cast requires an arithmetic scalar target",
                            ),
                            span: target_span,
                        })?;
                        self.lexer = lookahead;
                        let (operand, end) = self.sizeof_operand()?;
                        let operand = self.sizeof_scalar_cast_result(scalar, &operand, end)?;
                        return Ok((operand, start.until(&end)));
                    }
                }
                let (operand, _) = self.sizeof_comma_expression()?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                (operand, start.until(&closing))
            }
            Token::Number(text) => {
                let number = number::parse(text).ok_or_else(|| ParseError {
                    message: String::from("unsupported or out-of-range numeric literal"),
                    span: start,
                })?;
                let operand = match number.literal {
                    Literal::I32(0) | Literal::U32(0) | Literal::I64(0) | Literal::U64(0) => {
                        SizeofOperand::IntegerZeroLiteral(number.scalar)
                    }
                    _ => SizeofOperand::Scalar(number.scalar),
                };
                (operand, start)
            }
            Token::Word("true" | "false") => (
                SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)),
                start,
            ),
            Token::Word("nullptr") => (SizeofOperand::NullPointer, start),
            Token::Word("static_cast") => self.sizeof_static_cast(start)?,
            Token::Word(name) => {
                let target = if self.lexer.peek()?.0 == Token::Paren('(') {
                    self.parameter_expansion_budget.charge_work(1, start)?;
                    self.type_name(name).and_then(|ty| ty.ty.source_scalar())
                } else {
                    None
                };
                if let Some(scalar) = target {
                    self.sizeof_functional_cast(scalar, start)?
                } else {
                    let symbol = self.lookup_symbol(name).ok_or_else(|| ParseError {
                        message: String::from("sizeof requires a supported named object"),
                        span: start,
                    })?;
                    (self.named_sizeof_operand(symbol, start)?, start)
                }
            }
            _ => {
                return Err(ParseError {
                    message: String::from("sizeof requires a supported named object"),
                    span: start,
                })
            }
        };
        while matches!(
            self.lexer.peek()?.0,
            Token::Separator('.') | Token::Arrow | Token::Paren('[')
        ) {
            if self.lexer.next_if(Token::Paren('['))? {
                let (index, _) = self.sizeof_comma_expression()?;
                end = self.lexer.expect_span(Token::Paren(']'))?;
                operand = self.sizeof_subscript(operand, index, start.until(&end))?;
                continue;
            }
            let arrow = self.lexer.next()?.0 == Token::Arrow;
            let (field, field_span) = self.identifier()?;
            self.parameter_expansion_budget.charge_work(1, field_span)?;
            let invalid = || ParseError {
                message: String::from(
                    "sizeof member access requires a record or vector object, or a pointer with ->",
                ),
                span: field_span,
            };
            let ty = match operand {
                SizeofOperand::Object(ty) => {
                    if arrow {
                        let pointee = self
                            .source_pointer_pointee(&ty)
                            .or_else(|| match *ty.inner_with(&self.module.types) {
                                TypeInner::Array { base, .. } => Some(base),
                                _ => None,
                            })
                            .ok_or_else(invalid)?;
                        TypeResolution::Handle(pointee)
                    } else if self.source_pointer_pointee(&ty).is_some() {
                        return Err(invalid());
                    } else {
                        ty
                    }
                }
                SizeofOperand::IncompleteArray(element) if arrow => element,
                _ => return Err(invalid()),
            };
            let (_, ty) = self.field_type(&ty, field, field_span)?;
            operand = SizeofOperand::Object(ty);
            end = field_span;
        }
        Ok((operand, start.until(&end)))
    }

    fn sizeof_static_cast(&mut self, start: Span) -> Result<(SizeofOperand, Span), ParseError> {
        // Account for parsing the bounded type syntax and the four delimiters.
        self.parameter_expansion_budget.charge_work(5, start)?;
        self.lexer.expect_span(Token::Paren('<'))?;
        let target_span = self.lexer.peek()?.1;
        let scalar = self
            .parse_type()?
            .ty
            .source_scalar()
            .ok_or_else(|| ParseError {
                message: String::from("sizeof static_cast requires an arithmetic scalar target"),
                span: target_span,
            })?;
        self.lexer.expect_span(Token::Paren('>'))?;
        self.lexer.expect_span(Token::Paren('('))?;
        let (operand, operand_span) = self.sizeof_comma_expression()?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        Ok((
            self.sizeof_scalar_cast_result(scalar, &operand, operand_span)?,
            start.until(&end),
        ))
    }

    fn sizeof_functional_cast(
        &mut self,
        scalar: SourceScalar,
        start: Span,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        self.parameter_expansion_budget.charge_work(2, start)?;
        self.lexer.expect_span(Token::Paren('('))?;
        let (operand, operand_span) = self.sizeof_conditional_expression()?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        Ok((
            self.sizeof_scalar_cast_result(scalar, &operand, operand_span)?,
            start.until(&end),
        ))
    }

    fn sizeof_scalar_cast_result(
        &self,
        scalar: SourceScalar,
        operand: &SizeofOperand,
        operand_span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let valid_operand = if scalar == SourceScalar::Scalar(Scalar::BOOL) {
            self.sizeof_bool_convertible(operand)
        } else {
            self.sizeof_source_scalar(operand).is_some()
        };
        if !valid_operand {
            return Err(ParseError {
                message: String::from("invalid operand type for sizeof scalar cast"),
                span: operand_span,
            });
        }
        Ok(SizeofOperand::Scalar(scalar))
    }

    fn sizeof_integral_operand(&self, operand: &SizeofOperand) -> bool {
        self.sizeof_source_scalar(operand).is_some_and(|scalar| {
            matches!(
                scalar.scalar().kind,
                ScalarKind::Sint | ScalarKind::Uint | ScalarKind::Bool
            )
        })
    }

    fn sizeof_subscript(
        &mut self,
        base: SizeofOperand,
        index: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from(
                "sizeof subscript requires one pointer or array and one integral operand",
            ),
            span,
        };
        let (pointer, index) = if self.sizeof_integral_operand(&base) {
            (index, base)
        } else {
            (base, index)
        };
        if !self.sizeof_integral_operand(&index) {
            return Err(invalid());
        }
        let operand = self
            .sizeof_dereference(pointer, span)
            .map_err(|_| invalid())?;
        if let SizeofOperand::Object(ref ty) = operand {
            let ty = self.type_handle(ty, span);
            if self.is_incomplete_array(ty) {
                return Err(ParseError {
                    message: String::from("sizeof subscript requires a complete element type"),
                    span,
                });
            }
        }
        Ok(operand)
    }

    fn sizeof_dereference(
        &self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let element = match operand {
            SizeofOperand::Object(ref ty) => self
                .source_pointer_pointee(ty)
                .or_else(|| match *ty.inner_with(&self.module.types) {
                    TypeInner::Array { base, .. } => Some(base),
                    _ => None,
                })
                .map(TypeResolution::Handle),
            SizeofOperand::IncompleteArray(element) => Some(element),
            SizeofOperand::Scalar(_)
            | SizeofOperand::IntegerZeroLiteral(_)
            | SizeofOperand::NullPointer => None,
        }
        .ok_or_else(|| ParseError {
            message: String::from("sizeof dereference requires a pointer or array operand"),
            span,
        })?;
        Ok(SizeofOperand::Object(element))
    }

    fn sizeof_unary(
        &mut self,
        operator: char,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from("invalid operand for sizeof builtin unary operator"),
            span,
        };
        let ty = match operand {
            SizeofOperand::Scalar(scalar) | SizeofOperand::IntegerZeroLiteral(scalar) => {
                if operator == '!' {
                    return Ok(SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)));
                }
                if operator == '~' && scalar.scalar().kind == ScalarKind::Float {
                    return Err(invalid());
                }
                return Ok(SizeofOperand::Scalar(Self::promoted_type_query_scalar(
                    scalar,
                )));
            }
            SizeofOperand::NullPointer if operator == '!' => {
                return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
            }
            SizeofOperand::NullPointer => return Err(invalid()),
            SizeofOperand::IncompleteArray(element) => {
                if operator == '!' {
                    return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
                }
                if operator != '+' {
                    return Err(invalid());
                }
                let base = self.type_handle(&element, span);
                return self.pointer_type(base, span).map(SizeofOperand::Object);
            }
            SizeofOperand::Object(ty) => ty,
        };
        if self.source_pointer_pointee(&ty).is_some() {
            return match operator {
                '+' => Ok(SizeofOperand::Object(ty)),
                '!' => Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL))),
                _ => Err(invalid()),
            };
        }
        if let TypeInner::Array { base, .. } = *ty.inner_with(&self.module.types) {
            return match operator {
                '+' => self.pointer_type(base, span).map(SizeofOperand::Object),
                '!' => Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL))),
                _ => Err(invalid()),
            };
        }
        let scalar = self.require_scalar_type(&ty, span)?;
        if operator == '!' {
            return Ok(SizeofOperand::Object(scalar_resolution(Scalar::BOOL)));
        }
        if operator == '~' && scalar.kind == ScalarKind::Float {
            return Err(invalid());
        }
        Ok(SizeofOperand::Object(
            if matches!(scalar, Scalar::BOOL | Scalar::I16 | Scalar::U16) {
                scalar_resolution(Scalar::I32)
            } else {
                ty
            },
        ))
    }

    fn sizeof_operand_size(
        &mut self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<u32, ParseError> {
        let value = match operand {
            SizeofOperand::Scalar(scalar) | SizeofOperand::IntegerZeroLiteral(scalar) => {
                u32::from(scalar.scalar().width)
            }
            SizeofOperand::NullPointer => 8,
            SizeofOperand::IncompleteArray(_) => {
                return Err(ParseError {
                    message: String::from("sizeof requires a complete object type"),
                    span,
                });
            }
            SizeofOperand::Object(ty) => {
                if self.source_pointer_pointee(&ty).is_some() {
                    8
                } else {
                    self.type_query_layout("sizeof", ty, span)?
                }
            }
        };
        Ok(value)
    }

    fn named_sizeof_operand(
        &mut self,
        symbol: Symbol,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let ty = match symbol {
            Symbol::TemplateFunctionParameter(Some(SourceType::Shader(ty))) => {
                TypeResolution::Handle(ty)
            }
            Symbol::TemplateFunctionParameter(Some(SourceType::NullPointer)) => {
                return Ok(SizeofOperand::NullPointer)
            }
            Symbol::TemplateFunctionParameter(_) => {
                return Err(ParseError {
                    message: String::from(
                        "sizeof requires a known nondependent function parameter type",
                    ),
                    span,
                })
            }
            Symbol::Member(Some(ty)) => TypeResolution::Handle(ty),
            Symbol::Pointer(pointer) => self.function.pointer_symbols[pointer].ty.clone(),
            Symbol::NullPointer(_) => return Ok(SizeofOperand::NullPointer),
            Symbol::Variable { ty, .. }
            | Symbol::Reference { ty, .. }
            | Symbol::Constant { ty, .. } => ty,
            Symbol::Array { pointer, ty, .. } => {
                let array = match self.function.ir.expressions[pointer] {
                    Expression::LocalVariable(local) => {
                        if self.function.pending_array == Some(local) {
                            return Ok(SizeofOperand::IncompleteArray(ty));
                        }
                        self.function.ir.local_variables[local].ty
                    }
                    Expression::GlobalVariable(global) => self.module.global_variables[global].ty,
                    _ => unreachable!(),
                };
                TypeResolution::Handle(array)
            }
            Symbol::ConstantMemory(declaration) => {
                TypeResolution::Handle(self.constant_memory_type(declaration))
            }
            Symbol::TemplateParameter { scalar, .. } => return Ok(SizeofOperand::Scalar(scalar)),
            Symbol::DynamicShared(declaration) => {
                return Ok(SizeofOperand::IncompleteArray(TypeResolution::Handle(
                    self.dynamic_shared_element_type(declaration),
                )));
            }
            _ => {
                return Err(ParseError {
                    message: String::from("sizeof requires a supported named object or type"),
                    span,
                });
            }
        };
        Ok(SizeofOperand::Object(ty))
    }

    fn type_query_layout(
        &mut self,
        name: &str,
        resolution: TypeResolution,
        span: Span,
    ) -> Result<u32, ParseError> {
        let ty = self.type_handle(&resolution, span);
        if name == "sizeof" && self.is_incomplete_array(ty) {
            return Err(ParseError {
                message: String::from("sizeof requires a complete object type"),
                span,
            });
        }
        self.layouter
            .update(self.module.to_ctx())
            .map_err(|error| ParseError {
                message: format!("invalid type query layout: {error}"),
                span,
            })?;
        let layout = self.layouter[ty];
        Ok(if name == "sizeof" {
            layout.size
        } else {
            layout.alignment * 1
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn offsetof_indices_respect_expression_depth_without_allocating() {
        let sum_chain = format!("{}1]", "0 + ".repeat(128));
        let product_chain = format!("{}1]", "1 * ".repeat(128));
        let shift_chain = format!("1{}]", " >> 0".repeat(128));
        let bitwise_chain = format!("1{}]", " | 0 ^ 0 & 0".repeat(128));
        let comparison_chain = format!("1{}]", " == 0 < 1".repeat(128));
        let logical_chain = format!("1{}]", " || (1 / 0)".repeat(128));
        for (source, exhaust_bytes, succeeds) in [
            ("((((1ULL))))]", false, true),
            ("((((1ULL))))]", true, true),
            ("(((((1ULL)))))]", false, false),
            ("+(!!1ULL)]", true, true),
            ("+(!!!1ULL)]", false, false),
            ("((1 + 0) + (0))]", true, true),
            ("((1 + 2) / (3))]", true, true),
            ("((2 >> 1) << (0))]", true, true),
            (sum_chain.as_str(), false, true),
            (product_chain.as_str(), false, true),
            (shift_chain.as_str(), false, true),
            (bitwise_chain.as_str(), false, true),
            (comparison_chain.as_str(), true, true),
            (logical_chain.as_str(), true, true),
            ("1 || ((((1 / 0))))]", false, true),
            ("1 || (((((1 / 0)))))]", false, false),
            ("0 ? 1 / 0 : 0 ? 1 << 32 : 1]", true, true),
            ("1 ? 1 : (((0 ? 1 : 0)))]", false, false),
            ("true || (false ? 1 / 0 : false)]", true, true),
            ("static_cast<unsigned short>(65537u)]", true, true),
            ("true || static_cast<bool>(1 / 0)]", false, true),
            ("static_cast<int>((((1))))]", true, true),
            ("static_cast<int>(((((1)))))]", false, false),
            ("short(65537u) + bool()]", true, true),
            ("true || bool(1 / 0)]", false, true),
            ("int((((1))))]", true, true),
            ("int(((((1)))))]", false, false),
            ("(int)(short)(unsigned)(bool)1]", true, true),
            ("(int)(int)(short)(unsigned)(bool)1]", false, false),
            ("true || (int)(1 / 0)]", true, true),
            ("::Index((((65537u))))]", true, true),
            ("decltype(One)(((((1))))) ]", false, false),
            ("true || decltype(One)(1 / 0)]", true, true),
            ("sizeof(bool) * alignof(bool)]", true, true),
            ("sizeof(float3) / 12]", true, true),
            ("sizeof(Fixed) / 8]", false, true),
            ("alignof(Fixed) / 4]", true, true),
            ("alignof(float3) / 4]", false, true),
            ("true || (sizeof(float) / alignof(long))]", false, true),
            ("((((sizeof(bool)))))]", false, false),
        ] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let span = Span::new(0, 1);
            let element = parser.module.types.insert(
                Type {
                    name: None,
                    inner: TypeInner::Scalar(Scalar::I32),
                },
                span,
            );
            let array = parser.module.types.insert(
                Type {
                    name: None,
                    inner: TypeInner::Array {
                        base: element,
                        size: ArraySize::Constant(core::num::NonZeroU32::new(2).unwrap()),
                        stride: 4,
                    },
                },
                span,
            );
            parser.global_declarations.insert(
                "Fixed",
                GlobalDeclaration::Type(QualifiedType {
                    ty: TypeSpecifier::Array(array),
                    qualifiers: Qualifiers::NONE,
                }),
            );
            parser.global_declarations.insert(
                "Index",
                GlobalDeclaration::Type(QualifiedType {
                    ty: TypeSpecifier::Scalar(Scalar::U16),
                    qualifiers: Qualifiers::NONE,
                }),
            );
            parser.global_declarations.insert(
                "One",
                GlobalDeclaration::Constant {
                    handle: None,
                    ty: TypeResolution::Handle(element),
                    literal: Some(Literal::I32(1)),
                },
            );
            parser.function.expression_depth = 60;
            exhaust_query_allocation_budget(&mut parser, exhaust_bytes);
            let result = parser.record_offset_array_element(array, 8);
            if succeeds {
                assert_eq!(result.unwrap(), (element, 12));
            } else {
                assert_eq!(
                    result.unwrap_err().message,
                    "CUDA expression nesting limit exceeded"
                );
            }
            assert_eq!(parser.function.expression_depth, 60);
            assert_eq!(parser.module.types.len(), 2);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.body.is_empty());
        }
    }

    #[test]
    fn sizeof_binary_scalar_types_preserve_source_identity_without_ir() {
        for (source, expected) in [
            ("(1L + 1u)", SourceScalar::Long(ScalarKind::Sint)),
            ("(1L + 1ull)", SourceScalar::Scalar(Scalar::U64)),
            ("(1ul + 1ll)", SourceScalar::Scalar(Scalar::U64)),
            ("(1u << 1ull)", SourceScalar::Scalar(Scalar::U32)),
            ("(true + false)", SourceScalar::Scalar(Scalar::I32)),
            ("(1.0f < 2u)", SourceScalar::Scalar(Scalar::BOOL)),
            ("(1 / 0)", SourceScalar::Scalar(Scalar::I32)),
            ("(1 << -1)", SourceScalar::Scalar(Scalar::I32)),
            ("(true || (1 / 0))", SourceScalar::Scalar(Scalar::BOOL)),
        ] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(
                matches!(operand, SizeofOperand::Scalar(scalar) if scalar == expected),
                "{source}"
            );
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.module.types.is_empty());
            assert!(parser.module.functions.is_empty());
            assert!(parser.module.global_variables.is_empty());
        }
    }

    #[test]
    fn sizeof_binary_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(1L + 1u)", SourceScalar::Long(ScalarKind::Sint));
    }

    #[test]
    fn sizeof_conditional_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(1 / 0 ? 1L : 1u)", SourceScalar::Long(ScalarKind::Sint));
    }

    #[test]
    fn sizeof_pointer_conditions_metadata_needs_no_node_or_byte_allocation_budget() {
        check_sizeof_metadata_budget("(nullptr ? 1L : 1u)", SourceScalar::Long(ScalarKind::Sint));
    }

    #[test]
    fn sizeof_static_casts_preserve_source_long_without_allocations() {
        check_sizeof_metadata_budget(
            "static_cast<const long>(1 / 0, static_cast<short>(3u))",
            SourceScalar::Long(ScalarKind::Sint),
        );
    }

    #[test]
    fn sizeof_functional_casts_preserve_source_long_without_allocations() {
        check_sizeof_metadata_budget(
            "long((1 / 0, short(3u)))",
            SourceScalar::Long(ScalarKind::Sint),
        );
    }

    #[test]
    fn sizeof_functional_casts_bound_nesting_and_restore_depth() {
        let source = format!("{}1{}", "int(".repeat(70), ")".repeat(70));
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        let Err(error) = parser.sizeof_operand() else {
            panic!("expected expression nesting error");
        };
        assert_eq!(error.message, "CUDA expression nesting limit exceeded");
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_c_style_casts_need_no_allocation_budget() {
        check_sizeof_metadata_budget(
            "(const signed long)(short)(1 / 0, 3u)",
            SourceScalar::Long(ScalarKind::Sint),
        );
        check_sizeof_metadata_budget("(bool)nullptr", SourceScalar::Scalar(Scalar::BOOL));
    }

    #[test]
    fn sizeof_c_style_casts_bound_nesting_and_restore_depth() {
        let source = format!("{}1", "(int)".repeat(70));
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        let Err(error) = parser.sizeof_operand() else {
            panic!("expected expression nesting error");
        };
        assert_eq!(error.message, "CUDA expression nesting limit exceeded");
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_bool_casts_require_no_allocation_for_nullptr() {
        check_sizeof_metadata_budget(
            "static_cast<const bool>((1, nullptr))",
            SourceScalar::Scalar(Scalar::BOOL),
        );
    }

    #[test]
    fn sizeof_static_casts_bound_nesting_and_restore_depth() {
        let source = format!("{}1{}", "static_cast<int>(".repeat(70), ")".repeat(70));
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        let Err(error) = parser.sizeof_operand() else {
            panic!("expected expression nesting error");
        };
        assert_eq!(error.message, "CUDA expression nesting limit exceeded");
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_comma_metadata_handles_flat_chains_without_allocations() {
        let source = format!("({}1L)", "1,".repeat(96));
        check_sizeof_metadata_budget(&source, SourceScalar::Long(ScalarKind::Sint));

        let span = Span::new(0, 1);
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        for bit in (4..usize::BITS).rev() {
            let _ = parser
                .parameter_expansion_budget
                .charge_work(1usize << bit, span);
        }
        assert!(parser.sizeof_operand().is_err());
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_pointer_arms_reuse_the_source_descriptor_under_allocation_limits() {
        for (source, exhaust_bytes) in [
            ("(true ? nullptr : pointer)", false),
            ("(true ? nullptr : pointer)", true),
            ("(true ? pointer : pointer)", false),
            ("(true ? pointer : pointer)", true),
            ("(true ? pointer : (0L))", false),
            ("(true ? (0x0ULL) : pointer)", true),
        ] {
            let span = Span::new(0, 1);
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let pointee = parser.module.types.insert(
                Type {
                    name: None,
                    inner: TypeInner::Scalar(Scalar::I32),
                },
                span,
            );
            let pointer = parser.query_parameter_pointer_type(pointee, span).unwrap();
            parser
                .insert_symbol(
                    "pointer",
                    Symbol::TemplateFunctionParameter(Some(SourceType::Shader(pointer))),
                    span,
                )
                .unwrap();
            exhaust_query_allocation_budget(&mut parser, exhaust_bytes);
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(
                matches!(operand, SizeofOperand::Object(TypeResolution::Handle(handle)) if handle == pointer)
            );
            assert_eq!(parser.module.types.len(), 2);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.body.is_empty());
        }
    }

    #[test]
    fn sizeof_pointer_pairs_reject_nested_source_descriptors() {
        let source = "(true ? pointer : pointer)";
        let span = Span::new(0, 1);
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        let pointee = parser.module.types.insert(
            Type {
                name: None,
                inner: TypeInner::Scalar(Scalar::I32),
            },
            span,
        );
        let inner = parser.query_parameter_pointer_type(pointee, span).unwrap();
        let outer = parser.query_parameter_pointer_type(inner, span).unwrap();
        parser
            .insert_symbol(
                "pointer",
                Symbol::TemplateFunctionParameter(Some(SourceType::Shader(outer))),
                span,
            )
            .unwrap();
        assert!(parser.sizeof_operand().is_err());
        assert_eq!(parser.function.expression_depth, 0);
    }

    fn check_sizeof_metadata_budget(source: &str, expected: SourceScalar) {
        for exhaust_bytes in [false, true] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            exhaust_query_allocation_budget(&mut parser, exhaust_bytes);
            let (operand, _) = parser.sizeof_operand().unwrap();
            assert!(matches!(
                operand,
                SizeofOperand::Scalar(scalar) if scalar == expected
            ));
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    fn exhaust_query_allocation_budget(parser: &mut Parser<'_>, exhaust_bytes: bool) {
        let span = Span::new(0, 1);
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        for bit in (0..usize::BITS).rev() {
            let count = 1usize << bit;
            let _ = if exhaust_bytes {
                parser.parameter_expansion_budget.charge_bytes(count, span)
            } else {
                parser.parameter_expansion_budget.charge_nodes(count, span)
            };
        }
    }

    #[test]
    fn sizeof_conditional_rejects_excessive_arm_nesting_and_restores_depth() {
        for source in [
            format!("({}1)", "true ? 1 : ".repeat(70)),
            format!("({}1{})", "true ? ".repeat(70), " : 1".repeat(70)),
        ] {
            let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
            let Err(error) = parser.sizeof_operand() else {
                panic!("expected expression nesting error");
            };
            assert_eq!(error.message, "CUDA expression nesting limit exceeded");
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    #[test]
    fn sizeof_binary_errors_restore_depth_without_evaluation() {
        for source in ["(1 +)", "(1 + (2 *))", "((1)", "(1.0f % 2)", "(1 << 2.0f)"] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            assert!(parser.sizeof_operand().is_err(), "{source}");
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
        let mut parser = Parser::new(
            Lexer::new("(1 + 2 * 3 + 4 * 5)").unwrap(),
            &Options::default(),
        );
        let span = Span::new(0, 1);
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        parser
            .parameter_expansion_budget
            .charge_work(1, span)
            .unwrap();
        for bit in (3..usize::BITS).rev() {
            let _ = parser
                .parameter_expansion_budget
                .charge_work(1usize << bit, span);
        }
        let start = parser.lexer.position();
        assert!(parser.sizeof_operand().is_err());
        assert_ne!(parser.lexer.position(), start);
        assert_eq!(parser.function.expression_depth, 0);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
    }

    #[test]
    fn sizeof_binary_preserves_legacy_grouping_depth_boundary() {
        for groups in [51, 63, 64] {
            let source = format!("{}1{}", "(".repeat(groups), ")".repeat(groups));
            let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
            assert_eq!(parser.sizeof_operand().is_ok(), groups < 64);
            assert_eq!(parser.function.expression_depth, 0);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }

    #[test]
    fn sizeof_operand_depth_and_work_errors_restore_expression_depth() {
        for exhaust_work in [false, true] {
            let mut parser = Parser::new(Lexer::new("1").unwrap(), &Options::default());
            let span = Span::new(0, 1);
            let previous_depth = if exhaust_work { 0 } else { 64 };
            parser.function.expression_depth = previous_depth;
            if exhaust_work {
                parser.parameter_expansion_budget.activate();
                parser.prepare_parameter_bindings(span).unwrap();
                for bit in (0..usize::BITS).rev() {
                    let _ = parser
                        .parameter_expansion_budget
                        .charge_work(1usize << bit, span);
                }
            }
            assert!(parser.sizeof_operand().is_err());
            assert_eq!(parser.function.expression_depth, previous_depth);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.module.types.is_empty());
        }
    }
}
