use super::*;

enum SizeofOperand {
    Scalar(SourceScalar),
    IntegerZeroLiteral(SourceScalar),
    Object(TypeResolution),
    IncompleteArray(Handle<Type>),
    NullPointer,
}

enum TypeQueryType {
    Pointer,
    FunctionReference,
    PointerArrayLayout(u32),
    PointerToArray(QualifiedType),
    ArrayOfPointers,
    Object(QualifiedType),
}

enum TypeQueryContext<'a> {
    Operand(&'a str),
    FunctionParameter,
}

impl TypeQueryContext<'_> {
    const fn array_query_name(&self) -> &str {
        match *self {
            Self::Operand(name) => name,
            Self::FunctionParameter => "alignof",
        }
    }
}

enum GroupedTypeQuery {
    PointerToArray,
    ArrayReference,
    FunctionPointer,
    FunctionReference,
    PointerArray,
}

enum GroupedArrayElement {
    Pointer,
    Value(QualifiedType),
}

struct RecordOffsetIndex {
    value: Option<i128>,
    scalar: SourceScalar,
    lvalue: Option<Qualifiers>,
}

#[derive(Clone, Copy, PartialEq)]
enum RecordOffsetIndexMode {
    Evaluate,
    Discarded,
}

impl RecordOffsetIndexMode {
    const fn discard_if(self, condition: bool) -> Self {
        match self {
            Self::Evaluate if condition => Self::Discarded,
            _ => self,
        }
    }
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
        let (index, span) = self.record_offset_index(
            self.function.expression_depth,
            0,
            RecordOffsetIndexMode::Evaluate,
        )?;
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
        mode: RecordOffsetIndexMode,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        let (mut left, mut span) = self.record_offset_index_prefix(depth, mode)?;
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
                mode.discard_if(short_circuit.is_some()),
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
        let (accept, _) =
            self.record_offset_index(depth + 1, 0, mode.discard_if(condition != Some(true)))?;
        let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
        self.parameter_expansion_budget.charge_work(1, colon_span)?;
        let (reject, reject_span) =
            self.record_offset_index(depth + 1, 0, mode.discard_if(condition != Some(false)))?;
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
        mode: RecordOffsetIndexMode,
    ) -> Result<(RecordOffsetIndex, Span), ParseError> {
        if let Some(name) = self.qualified_item()? {
            self.parameter_expansion_budget.charge_work(3, name.span)?;
            let cooperative_groups::QualifiedItem::Type(target) = name.item else {
                return Err(Self::invalid_record_offset_index(name.span));
            };
            return self.record_offset_functional_cast(target, depth, mode, name.span);
        }
        let (token, span) = self.lexer.next()?;
        let evaluate = mode == RecordOffsetIndexMode::Evaluate;
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
                        self.record_offset_index_prefix(depth + 1, mode)?;
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
                            self.record_offset_index_prefix(depth + 1, mode)?;
                        return Ok((Self::record_offset_cast(scalar, operand.value), span.until(&end)));
                    }
                }
                let (operand, _) = self.record_offset_index(depth + 1, 0, mode)?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                self.parameter_expansion_budget.charge_work(1, closing)?;
                return Ok((operand, span.until(&closing)));
            }
            Token::Number(text) => {
                self.charge_type_query_number(text, span)?;
                number::parse_integer(text)
            }
            Token::Word(word @ ("true" | "false")) => {
                self.parameter_expansion_budget
                    .charge_work(word.len() + 1, span)?;
                Some(Literal::Bool(word == "true").into())
            }
            Token::Word("static_cast") => {
                return self.record_offset_static_cast(depth, mode, span);
            }
            Token::Word(name @ ("sizeof" | "alignof")) => {
                return self.record_offset_type_query(name, depth, evaluate, span);
            }
            Token::Word("decltype") => {
                self.parameter_expansion_budget.charge_work(4, span)?;
                let (target, end) = self.decltype_operand_type()?;
                return self.record_offset_functional_cast(target, depth, mode, span.until(&end));
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
                    return self.record_offset_functional_cast(target, depth, mode, span);
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
        let operand_start = self.lexer.clone();
        let parenthesized = if name == "sizeof" {
            self.lexer.next_if(Token::Paren('('))?
        } else {
            self.lexer.expect_span(Token::Paren('('))?;
            true
        };
        let (_, target_span) = self.lexer.peek()?;
        let (size, end) = if name == "sizeof" && self.sizeof_starts_expression(parenthesized)? {
            self.lexer = operand_start;
            let (operand, span) = self.record_offset_sizeof_operand(depth)?;
            let size = self.record_offset_sizeof_operand_size(operand, span)?;
            (size, span)
        } else if parenthesized {
            let size = self.record_offset_type_layout(name, depth + 1, target_span)?;
            let end = self.lexer.expect_span(Token::Paren(')'))?;
            (size, end)
        } else {
            return Err(ParseError {
                message: String::from(
                    "nested sizeof expected a parenthesized type or a named object",
                ),
                span: target_span,
            });
        };
        let value = evaluate.then_some(i128::from(size));
        Ok((
            RecordOffsetIndex::prvalue(SourceScalar::Long(ScalarKind::Uint), value),
            start.until(&end),
        ))
    }

    fn sizeof_layout_operand(
        &mut self,
        name: &str,
        depth: u32,
        start: Span,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (result, span) = self.record_offset_type_query(name, depth, false, start)?;
        Ok((SizeofOperand::Scalar(result.scalar), span))
    }

    fn record_offset_type_layout(
        &mut self,
        name: &str,
        depth: u32,
        target_span: Span,
    ) -> Result<u32, ParseError> {
        match self.type_query_type_id(target_span, depth, TypeQueryContext::Operand(name))? {
            TypeQueryType::Pointer => Ok(8),
            TypeQueryType::PointerArrayLayout(layout) => Ok(layout),
            TypeQueryType::FunctionReference => {
                self.fail("function references have no object layout")
            }
            TypeQueryType::PointerToArray(ty) => {
                // The pointee may have an omitted outer bound.
                self.record_offset_array_layout("alignof", ty.ty, depth, target_span)?;
                Ok(8)
            }
            TypeQueryType::ArrayOfPointers => self.record_offset_pointer_array_layout(name, depth),
            TypeQueryType::Object(ty) => {
                if self.lexer.peek()?.0 == Token::Paren('[') {
                    self.record_offset_array_layout(name, ty.ty, depth, target_span)
                } else {
                    self.record_offset_layout_value(name, ty.ty, target_span)
                }
            }
        }
    }

    fn record_offset_layout_value(
        &mut self,
        name: &str,
        ty: TypeSpecifier,
        target_span: Span,
    ) -> Result<u32, ParseError> {
        if let Some(scalar) = ty.source_scalar() {
            // The supported scalar types have natural alignment equal to their size.
            Ok(u32::from(scalar.scalar().width))
        } else if name == "sizeof" {
            self.record_offset_aggregate_size(ty)
                .ok_or_else(|| {
                    ParseError {
                message: String::from(
                    "nested sizeof requires a scalar, vector, complete record, or fixed-array type",
                ),
                span: target_span,
            }
                })
        } else {
            self.record_offset_aggregate_alignment(ty, target_span)?
                .ok_or_else(|| ParseError {
                    message: String::from(
                        "nested alignof requires a scalar, vector, complete record, or array type with a supported element",
                    ),
                    span: target_span,
                })
        }
    }

    fn record_offset_array_layout(
        &mut self,
        name: &str,
        ty: TypeSpecifier,
        depth: u32,
        span: Span,
    ) -> Result<u32, ParseError> {
        let size = self.record_offset_layout_value("sizeof", ty, span)?;
        let alignment = self.record_offset_layout_value("alignof", ty, span)?;
        let base_rank = match ty {
            TypeSpecifier::Array(handle) => self.array_shape(handle, span)?.1,
            _ => 0,
        };
        let stride = size
            .checked_next_multiple_of(alignment)
            .filter(|&size| size <= crate::valid::MAX_TYPE_SIZE)
            .ok_or_else(|| Self::type_query_array_size_limit(span))?;
        self.type_query_array_layout(name, stride, alignment, base_rank, |parser| {
            parser.record_offset_array_bound(depth)
        })
    }

    fn record_offset_array_bound(&mut self, depth: u32) -> Result<(u32, Span), ParseError> {
        // A skipped query still requires a valid array type.
        let (bound, span) = self.record_offset_index(depth, 0, RecordOffsetIndexMode::Evaluate)?;
        let count = bound
            .value
            .and_then(|value| u32::try_from(value).ok())
            .filter(|&count| count != 0)
            .ok_or_else(|| ParseError {
                message: String::from("array bound must be a positive 32-bit integral constant"),
                span,
            })?;
        Ok((count, span))
    }

    fn record_offset_pointer_array_layout(
        &mut self,
        name: &str,
        depth: u32,
    ) -> Result<u32, ParseError> {
        self.type_query_array_layout(name, 8, 8, 0, |parser| {
            parser.record_offset_array_bound(depth)
        })
    }

    fn type_query_array_size_limit(span: Span) -> ParseError {
        ParseError {
            message: String::from("array exceeds Naga's type size limit"),
            span,
        }
    }

    fn type_query_array_layout(
        &mut self,
        name: &str,
        mut size: u32,
        alignment: u32,
        base_rank: usize,
        mut parse_bound: impl FnMut(&mut Self) -> Result<(u32, Span), ParseError>,
    ) -> Result<u32, ParseError> {
        let mut rank = base_rank;
        while let (Token::Paren('['), open) = self.lexer.peek()? {
            self.lexer.next()?;
            self.parameter_expansion_budget.charge_work(2, open)?;
            rank += 1;
            if rank > 64 {
                return Err(ParseError {
                    message: String::from("CUDA array rank limit exceeded"),
                    span: open,
                });
            }
            if self.lexer.next_if(Token::Paren(']'))? {
                if rank != base_rank + 1 {
                    return Err(ParseError {
                        message: String::from("only the outermost array bound may be omitted"),
                        span: open,
                    });
                }
                if name == "sizeof" {
                    return Err(ParseError {
                        message: String::from("sizeof requires a complete array type"),
                        span: open,
                    });
                }
                continue;
            }
            let (count, bound_span) = parse_bound(self)?;
            self.lexer.expect_span(Token::Paren(']'))?;
            size = size
                .checked_mul(count)
                .filter(|&size| size <= crate::valid::MAX_TYPE_SIZE)
                .ok_or_else(|| Self::type_query_array_size_limit(bound_span))?;
        }
        Ok(if name == "sizeof" { size } else { alignment })
    }

    fn record_offset_sizeof_conditional(
        &mut self,
        depth: u32,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (condition, condition_span) =
            self.sizeof_binary_expression(0, |parser| parser.record_offset_sizeof_operand(depth))?;
        let (token, question_span) = self.lexer.peek()?;
        if token != Token::Operation('?') {
            return Ok((condition, condition_span));
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
        self.require_sizeof_condition(&condition, condition_span)?;
        let accept = self
            .sizeof_comma_expression(|parser| parser.record_offset_sizeof_conditional(depth + 1))?;
        let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
        self.parameter_expansion_budget.charge_work(1, colon_span)?;
        let reject = self.record_offset_sizeof_conditional(depth + 1)?;
        let span = condition_span.until(&reject.1);
        let operand = self.sizeof_conditional_arm_type(accept, reject)?;
        Ok((operand, span))
    }

    fn record_offset_sizeof_operand(
        &mut self,
        depth: u32,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        if let Some((scalar, span)) = self.sizeof_qualified_or_decltype_cast_target()? {
            if depth >= 64 {
                return Err(ParseError {
                    message: String::from("CUDA expression nesting limit exceeded"),
                    span,
                });
            }
            return self.sizeof_functional_cast(scalar, span, |parser| {
                parser.record_offset_sizeof_conditional(depth + 1)
            });
        }
        let (token, start) = self.lexer.next()?;
        if matches!(
            token,
            Token::Operation('*' | '+' | '-' | '~' | '!')
                | Token::Paren('(')
                | Token::Word("static_cast")
        ) && depth >= 64
        {
            return Err(ParseError {
                message: String::from("CUDA expression nesting limit exceeded"),
                span: start,
            });
        }
        let invalid = || ParseError {
            message: String::from("nested sizeof expected a supported literal or named object"),
            span: start,
        };
        let (mut operand, mut end) = match token {
            Token::Operation(operator @ ('*' | '+' | '-' | '~' | '!')) => {
                self.parameter_expansion_budget.charge_work(1, start)?;
                let (operand, end) = self.record_offset_sizeof_operand(depth + 1)?;
                let span = start.until(&end);
                let operand = if operator == '*' {
                    self.sizeof_dereference(operand, span)?
                } else {
                    self.sizeof_unary(operator, operand, span)?
                };
                return Ok((operand, span));
            }
            Token::Paren('(') => {
                self.parameter_expansion_budget.charge_work(2, start)?;
                if let Some(scalar) = self.sizeof_c_style_cast_target(start)? {
                    let (operand, end) = self.record_offset_sizeof_operand(depth + 1)?;
                    let operand = self.sizeof_scalar_cast_result(scalar, &operand, end)?;
                    return Ok((operand, start.until(&end)));
                }
                let (operand, _) = self.sizeof_comma_expression(|parser| {
                    parser.record_offset_sizeof_conditional(depth + 1)
                })?;
                let end = self.lexer.expect_span(Token::Paren(')'))?;
                (operand, end)
            }
            Token::Number(text) => (self.sizeof_numeric_literal(text, start)?, start),
            Token::Word("true" | "false") => (
                SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)),
                start,
            ),
            Token::Word("nullptr") => (SizeofOperand::NullPointer, start),
            Token::Word(name @ ("sizeof" | "alignof")) => {
                return self.sizeof_layout_operand(name, depth + 1, start);
            }
            Token::Word("static_cast") => self.sizeof_static_cast(start, |parser| {
                parser.record_offset_sizeof_conditional(depth + 1)
            })?,
            Token::Word(word) => {
                self.parameter_expansion_budget
                    .charge_work(word.len() + 1, start)?;
                if let Some(scalar) = self.sizeof_functional_cast_target(word, start)? {
                    if depth >= 64 {
                        return Err(ParseError {
                            message: String::from("CUDA expression nesting limit exceeded"),
                            span: start,
                        });
                    }
                    self.sizeof_functional_cast(scalar, start, |parser| {
                        parser.record_offset_sizeof_conditional(depth + 1)
                    })?
                } else {
                    let symbol = self.lookup_symbol(word).ok_or_else(invalid)?;
                    (self.named_sizeof_operand(symbol, start)?, start)
                }
            }
            _ => return Err(invalid()),
        };
        loop {
            match self.lexer.peek()? {
                (Token::Separator('.') | Token::Arrow, _) => {
                    (operand, end) = self.sizeof_member(operand)?;
                }
                (Token::Paren('['), opening) => {
                    if depth >= 64 {
                        return Err(ParseError {
                            message: String::from("CUDA expression nesting limit exceeded"),
                            span: opening,
                        });
                    }
                    self.parameter_expansion_budget.charge_work(2, opening)?;
                    self.lexer.next()?;
                    let (other, _) = self.record_offset_sizeof_conditional(depth + 1)?;
                    end = self.lexer.expect_span(Token::Paren(']'))?;
                    let (base, index) = if self.sizeof_integral_operand(&operand) {
                        (other, operand)
                    } else {
                        (operand, other)
                    };
                    operand = self.sizeof_subscript(base, index, start.until(&end))?;
                }
                _ => break,
            }
        }
        Ok((operand, start.until(&end)))
    }

    fn record_offset_sizeof_operand_size(
        &self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<u32, ParseError> {
        let size = match operand {
            SizeofOperand::Scalar(scalar) | SizeofOperand::IntegerZeroLiteral(scalar) => {
                Some(u32::from(scalar.scalar().width))
            }
            SizeofOperand::NullPointer => Some(8),
            SizeofOperand::Object(ty) if self.source_pointer_pointee(&ty).is_some() => Some(8),
            SizeofOperand::Object(ty) => {
                self.record_offset_stored_size(ty.inner_with(&self.module.types))
            }
            SizeofOperand::IncompleteArray(_) => None,
        };
        size.ok_or_else(|| ParseError {
            message: String::from("nested sizeof requires a complete object type"),
            span,
        })
    }

    fn charge_type_query_number(&mut self, text: &str, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_work(text.len() + 1, span)?;
        if text.contains('\'') {
            self.parameter_expansion_budget
                .charge_bytes(text.len(), span)?;
        }
        Ok(())
    }

    fn sizeof_numeric_literal(
        &mut self,
        text: &str,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        self.charge_type_query_number(text, span)?;
        let number = number::parse(text).ok_or_else(|| ParseError {
            message: String::from("unsupported or out-of-range numeric literal"),
            span,
        })?;
        Ok(match number.literal {
            Literal::I32(0) | Literal::U32(0) | Literal::I64(0) | Literal::U64(0) => {
                SizeofOperand::IntegerZeroLiteral(number.scalar)
            }
            _ => SizeofOperand::Scalar(number.scalar),
        })
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
        self.record_offset_stored_size(&self.module.types[handle].inner)
    }

    fn record_offset_stored_size(&self, inner: &TypeInner) -> Option<u32> {
        match *inner {
            TypeInner::Scalar(_)
            | TypeInner::Vector { .. }
            | TypeInner::Struct { .. }
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
        mode: RecordOffsetIndexMode,
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
        let (operand, _) = self.record_offset_index(depth + 1, 0, mode)?;
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
        mode: RecordOffsetIndexMode,
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
            (mode == RecordOffsetIndexMode::Evaluate).then_some(0)
        } else {
            self.record_offset_index(depth + 1, 0, mode)?.0.value
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
        if name == "sizeof" && self.sizeof_starts_expression(parenthesized)? {
            self.lexer = operand_start;
            let (operand, operand_span) = self.sizeof_operand()?;
            let span = span.until(&operand_span);
            let value = self.sizeof_operand_size(operand, span)?;
            return self.type_query_result(value, span);
        }
        if !parenthesized {
            return self.fail("type queries require a parenthesized type or sizeof a named object");
        }

        let value = match self.type_query_type_id(span, 0, TypeQueryContext::Operand(name))? {
            TypeQueryType::Pointer => 8,
            TypeQueryType::PointerArrayLayout(layout) => layout,
            TypeQueryType::FunctionReference => {
                return self.fail("function references have no object layout")
            }
            TypeQueryType::PointerToArray(ty) => {
                self.array_alias_declarator(ty, span)?;
                8
            }
            TypeQueryType::ArrayOfPointers => {
                self.type_query_array_layout(name, 8, 8, 0, |parser| {
                    parser.array_size().map(|(count, span)| (count.get(), span))
                })?
            }
            TypeQueryType::Object(ty) => {
                let ty = self.array_alias_declarator(ty, span)?.ty;
                self.type_query_value(name, ty, span)?
            }
        };
        let closing = self.lexer.expect_span(Token::Paren(')'))?;
        self.type_query_result(value, span.until(&closing))
    }

    fn sizeof_starts_expression(&mut self, parenthesized: bool) -> Result<bool, ParseError> {
        let (token, _) = self.lexer.peek()?;
        match token {
            Token::Operation('*' | '+' | '-' | '~' | '!')
            | Token::Paren('(')
            | Token::Number(_)
            | Token::Word("true" | "false" | "nullptr" | "static_cast" | "sizeof" | "alignof") => {
                return Ok(true);
            }
            Token::Word(_) | Token::ScopeResolution => {}
            _ => return Ok(false),
        }

        let mut lookahead = self.lexer.clone();
        if self.scan_sizeof_cast_type(&mut lookahead)? {
            if lookahead.peek()?.0 != Token::Paren('(') {
                return Ok(false);
            }
            if parenthesized
                && self
                    .scan_grouped_query_declarator(&mut lookahead)?
                    .is_some()
            {
                return Ok(false);
            }
            // In sizeof(type-id), a function declarator takes precedence over an expression.
            return Ok(!parenthesized
                || !self.scan_sizeof_function_declarator(&mut lookahead, 0)?
                || lookahead.peek()?.0 != Token::Paren(')'));
        }

        Ok(
            matches!(token, Token::Word(word) if self.lookup_symbol(word).is_some_and(|symbol| {
                !matches!(
                    symbol,
                    Symbol::Type(_) | Symbol::TemplateTypeParameter { .. } | Symbol::Namespace(_)
                )
            })),
        )
    }

    fn scan_sizeof_cast_type(&mut self, lexer: &mut Lexer<'_>) -> Result<bool, ParseError> {
        let (token, span) = lexer.peek()?;
        if token == Token::Word("decltype") {
            self.parameter_expansion_budget.charge_work(4, span)?;
            lexer.next()?;
            let (target, _) = self.decltype_operand_type_from(lexer)?;
            return Ok(target.ty.source_scalar().is_some());
        }
        if !matches!(token, Token::Word(_) | Token::ScopeResolution) {
            return Ok(false);
        }
        if let Some(name) = cooperative_groups::try_qualified_name(
            lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )? {
            self.parameter_expansion_budget.charge_work(3, name.span)?;
            return Ok(
                matches!(name.item, cooperative_groups::QualifiedItem::Type(ty)
                if ty.ty.source_scalar().is_some()),
            );
        }
        if matches!(token, Token::Word(word) if self.type_name(word).is_some_and(|ty| ty.ty.source_scalar().is_some()))
        {
            self.parameter_expansion_budget.charge_work(1, span)?;
            lexer.next()?;
            return Ok(true);
        }
        Ok(false)
    }

    fn scan_sizeof_function_declarator(
        &mut self,
        lexer: &mut Lexer<'_>,
        depth: u32,
    ) -> Result<bool, ParseError> {
        let (token, span) = lexer.peek()?;
        if token != Token::Paren('(') || depth >= 64 {
            return Ok(false);
        }
        self.parameter_expansion_budget.charge_work(2, span)?;
        lexer.next()?;
        if lexer.next_if(Token::Paren(')'))? {
            return Ok(true);
        }
        loop {
            if lexer.peek()?.0 != Token::Paren('(') && !self.scan_sizeof_cast_type(lexer)? {
                return Ok(false);
            }
            while lexer.peek()?.0 == Token::Paren('(') {
                if !self.scan_sizeof_function_declarator(lexer, depth + 1)? {
                    return Ok(false);
                }
            }
            let (token, comma_span) = lexer.peek()?;
            if token != Token::Separator(',') {
                return lexer.next_if(Token::Paren(')'));
            }
            self.parameter_expansion_budget.charge_work(1, comma_span)?;
            lexer.next()?;
        }
    }

    fn type_query_type_id(
        &mut self,
        span: Span,
        depth: u32,
        context: TypeQueryContext<'_>,
    ) -> Result<TypeQueryType, ParseError> {
        let operand = self.type_query_base()?;
        let pointer_depth = self.type_query_pointer_depth(operand.as_ref())?;
        let (token, reference_span) = self.lexer.peek()?;
        let reference = matches!(token, Token::Operation('&') | Token::LogicalOperation('&'));
        if reference {
            self.parameter_expansion_budget
                .charge_work(1, reference_span)?;
            self.lexer.next()?;
        }
        let mut lookahead = self.lexer.clone();
        let declarator = self.scan_grouped_query_declarator(&mut lookahead)?;
        if declarator.is_some() {
            self.lexer = lookahead;
        }
        let function_parameter = declarator.is_none()
            && matches!(context, TypeQueryContext::FunctionParameter)
            && self.lexer.peek()?.0 == Token::Paren('(');
        let function_reference = matches!(declarator, Some(GroupedTypeQuery::FunctionReference));
        let function = matches!(declarator, Some(GroupedTypeQuery::FunctionPointer))
            || function_reference
            || function_parameter;
        let pointer_array = matches!(declarator, Some(GroupedTypeQuery::PointerArray));
        if (function || pointer_array) && depth >= 64 {
            return self.fail("CUDA expression nesting limit exceeded");
        }
        let array_layout = if pointer_array {
            let layout =
                self.record_offset_pointer_array_layout(context.array_query_name(), depth + 1)?;
            self.lexer.expect_span(Token::Paren(')'))?;
            if self.lexer.peek()?.0 == Token::Paren('[') {
                let element =
                    self.type_query_grouped_array_element(operand, pointer_depth, reference, span)?;
                match element {
                    GroupedArrayElement::Pointer => {
                        self.record_offset_pointer_array_layout("alignof", depth + 1)?;
                    }
                    GroupedArrayElement::Value(ty) => {
                        self.record_offset_array_layout("alignof", ty.ty, depth + 1, span)?;
                    }
                }
                return Ok(TypeQueryType::PointerArrayLayout(layout));
            }
            Some(layout)
        } else {
            None
        };
        if function || array_layout.is_some() {
            if pointer_depth == 0 {
                if reference && operand.is_none() {
                    return self.fail("function types cannot return references to void");
                }
                if !reference
                    && matches!(operand, Some(ty) if matches!(ty.ty, TypeSpecifier::Array(_)))
                {
                    return self.fail("function types cannot return arrays");
                }
            }
            self.type_query_function_parameters(depth + 1)?;
            self.type_query_function_noexcept(depth)?;
            return Ok(if let Some(layout) = array_layout {
                TypeQueryType::PointerArrayLayout(layout)
            } else if function_reference {
                TypeQueryType::FunctionReference
            } else {
                TypeQueryType::Pointer
            });
        }
        if let Some(declarator) = declarator {
            let element =
                self.type_query_grouped_array_element(operand, pointer_depth, reference, span)?;
            let pointer = matches!(declarator, GroupedTypeQuery::PointerToArray);
            return Ok(match element {
                GroupedArrayElement::Value(ty) if pointer => TypeQueryType::PointerToArray(ty),
                GroupedArrayElement::Value(ty) => TypeQueryType::Object(ty),
                GroupedArrayElement::Pointer => {
                    if depth >= 64 {
                        return self.fail("CUDA expression nesting limit exceeded");
                    }
                    let name = if pointer {
                        "alignof"
                    } else {
                        context.array_query_name()
                    };
                    let layout = self.record_offset_pointer_array_layout(name, depth + 1)?;
                    if pointer {
                        TypeQueryType::Pointer
                    } else {
                        TypeQueryType::PointerArrayLayout(layout)
                    }
                }
            });
        }

        if operand.is_none() && pointer_depth == 0 {
            return Err(ParseError {
                message: String::from(match context {
                    TypeQueryContext::Operand(_) => "type queries require a complete object type",
                    TypeQueryContext::FunctionParameter => {
                        "void must be the only function parameter"
                    }
                }),
                span,
            });
        }

        if self.lexer.peek()?.0 == Token::Paren('[') {
            if reference {
                return self.fail("direct arrays of references are unsupported");
            }
            if pointer_depth != 0 {
                return Ok(TypeQueryType::ArrayOfPointers);
            }
        }
        Ok(if pointer_depth != 0 {
            TypeQueryType::Pointer
        } else {
            TypeQueryType::Object(operand.unwrap())
        })
    }

    fn type_query_grouped_array_element(
        &mut self,
        operand: Option<QualifiedType>,
        pointer_depth: usize,
        reference: bool,
        span: Span,
    ) -> Result<GroupedArrayElement, ParseError> {
        if reference {
            return self.fail("arrays of references are unsupported");
        }
        if pointer_depth != 0 {
            return Ok(GroupedArrayElement::Pointer);
        }
        operand
            .map(GroupedArrayElement::Value)
            .ok_or_else(|| ParseError {
                message: String::from("array elements require a complete type"),
                span,
            })
    }

    fn type_query_base(&mut self) -> Result<Option<QualifiedType>, ParseError> {
        let mut lookahead = self.lexer.clone();
        let qualifiers = types::declaration_qualifiers(&mut lookahead, Qualifiers::NONE, false)?;
        if lookahead.next_if(Token::Word("void"))? {
            types::declaration_qualifiers(&mut lookahead, qualifiers, false)?;
            self.lexer = lookahead;
            Ok(None)
        } else {
            self.parse_type().map(Some)
        }
    }

    fn type_query_pointer_depth(
        &mut self,
        operand: Option<&QualifiedType>,
    ) -> Result<usize, ParseError> {
        let depth =
            usize::from(operand.is_some_and(|ty| matches!(ty.ty, TypeSpecifier::Pointer { .. })));
        Self::scan_type_query_pointer_chain(
            &mut self.lexer,
            &mut self.parameter_expansion_budget,
            depth,
        )
    }

    fn type_query_function_parameters(&mut self, depth: u32) -> Result<(), ParseError> {
        let open = self.lexer.expect_span(Token::Paren('('))?;
        self.parameter_expansion_budget.charge_work(2, open)?;
        if self.lexer.next_if(Token::Paren(')'))? {
            return Ok(());
        }
        let mut lookahead = self.lexer.clone();
        if lookahead.next_if(Token::Word("void"))? && lookahead.next_if(Token::Paren(')'))? {
            self.lexer = lookahead;
            return Ok(());
        }
        loop {
            let (token, parameter_span) = self.lexer.peek()?;
            if token == Token::Ellipsis {
                self.parameter_expansion_budget
                    .charge_work(2, parameter_span)?;
                self.lexer.next()?;
                self.lexer.expect_span(Token::Paren(')'))?;
                return Ok(());
            }
            self.parameter_expansion_budget
                .charge_work(1, parameter_span)?;
            let parameter = self.type_query_type_id(
                parameter_span,
                depth,
                TypeQueryContext::FunctionParameter,
            )?;
            if self.lexer.peek()?.0 == Token::Paren('[') {
                if depth >= 64 {
                    return self.fail("CUDA expression nesting limit exceeded");
                }
                match parameter {
                    TypeQueryType::Object(ty) | TypeQueryType::PointerToArray(ty) => {
                        self.record_offset_array_layout(
                            "alignof",
                            ty.ty,
                            depth + 1,
                            parameter_span,
                        )?;
                    }
                    TypeQueryType::ArrayOfPointers => {
                        self.record_offset_pointer_array_layout("alignof", depth + 1)?;
                    }
                    TypeQueryType::Pointer
                    | TypeQueryType::FunctionReference
                    | TypeQueryType::PointerArrayLayout(_) => {}
                }
            }
            if self.lexer.next_if(Token::Paren(')'))? {
                return Ok(());
            }
            if self.lexer.peek()?.0 != Token::Ellipsis {
                let comma = self.lexer.expect_span(Token::Separator(','))?;
                self.parameter_expansion_budget.charge_work(1, comma)?;
            }
        }
    }

    fn type_query_function_noexcept(&mut self, depth: u32) -> Result<(), ParseError> {
        let (token, span) = self.lexer.peek()?;
        if token != Token::Word("noexcept") {
            return Ok(());
        }
        self.parameter_expansion_budget.charge_work(1, span)?;
        self.lexer.next()?;
        if self.lexer.next_if(Token::Paren('('))? {
            if depth >= 64 {
                return self.fail("CUDA expression nesting limit exceeded");
            }
            self.parameter_expansion_budget.charge_work(2, span)?;
            let (condition, span) =
                self.record_offset_index(depth + 1, 0, RecordOffsetIndexMode::Evaluate)?;
            self.lexer.expect_span(Token::Paren(')'))?;
            if !matches!(condition.value, Some(0 | 1)) {
                return Err(ParseError {
                    message: String::from(
                        "noexcept requires a non-narrowing integral constant expression of bool",
                    ),
                    span,
                });
            }
        }
        if self.lexer.peek()?.0 == Token::Word("noexcept") {
            return self.fail("duplicate noexcept specification");
        }
        Ok(())
    }

    fn scan_type_query_pointer_chain(
        lexer: &mut Lexer<'_>,
        budget: &mut parameter_expansion::ExpansionBudget,
        mut depth: usize,
    ) -> Result<usize, ParseError> {
        while let (Token::Operation('*'), span) = lexer.peek()? {
            lexer.next()?;
            budget.charge_work(1, span)?;
            depth += 1;
            if depth > 64 {
                return Err(ParseError {
                    message: String::from("CUDA pointer nesting limit exceeded"),
                    span,
                });
            }
            types::declaration_qualifiers_with_work(lexer, Qualifiers::NONE, true, |span| {
                budget.charge_work(1, span)
            })?;
        }
        Ok(depth)
    }

    fn scan_grouped_query_declarator(
        &mut self,
        lexer: &mut Lexer<'_>,
    ) -> Result<Option<GroupedTypeQuery>, ParseError> {
        let (token, span) = lexer.peek()?;
        if token != Token::Paren('(') {
            return Ok(None);
        }
        let mut lookahead = lexer.clone();
        lookahead.next()?;
        let budget = &mut self.parameter_expansion_budget;
        let pointer = match lookahead.peek()?.0 {
            Token::Operation('*') => {
                budget.charge_work(2, span)?;
                Self::scan_type_query_pointer_chain(&mut lookahead, budget, 0)?;
                if lookahead.next_if(Token::Paren('('))? {
                    let (token, span) = lookahead.next()?;
                    if !matches!(token, Token::Operation('&') | Token::LogicalOperation('&'))
                        || !lookahead.next_if(Token::Paren(')'))?
                        || lookahead.peek()?.0 != Token::Paren('[')
                    {
                        return Ok(None);
                    }
                    budget.charge_work(3, span)?;
                }
                let (token, reference_span) = lookahead.peek()?;
                if token == Token::Paren('[') {
                    *lexer = lookahead;
                    return Ok(Some(GroupedTypeQuery::PointerArray));
                }
                if matches!(token, Token::Operation('&') | Token::LogicalOperation('&')) {
                    budget.charge_work(1, reference_span)?;
                    lookahead.next()?;
                }
                true
            }
            Token::Operation('&') | Token::LogicalOperation('&') => {
                lookahead.next()?;
                budget.charge_work(3, span)?;
                false
            }
            _ => return Ok(None),
        };
        if !lookahead.next_if(Token::Paren(')'))? {
            return Ok(None);
        }
        let declarator = match (pointer, lookahead.peek()?.0) {
            (true, Token::Paren('(')) => GroupedTypeQuery::FunctionPointer,
            (false, Token::Paren('(')) => GroupedTypeQuery::FunctionReference,
            (true, Token::Paren('[')) => GroupedTypeQuery::PointerToArray,
            (false, Token::Paren('[')) => GroupedTypeQuery::ArrayReference,
            _ => return Ok(None),
        };
        *lexer = lookahead;
        Ok(Some(declarator))
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

    fn sizeof_comma_expression(
        &mut self,
        parse_conditional: impl Fn(&mut Self) -> Result<(SizeofOperand, Span), ParseError>,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (mut operand, mut span) = parse_conditional(self)?;
        while let (Token::Separator(','), comma_span) = self.lexer.peek()? {
            self.lexer.next()?;
            self.parameter_expansion_budget.charge_work(1, comma_span)?;
            let (right, right_span) = parse_conditional(self)?;
            operand = match right {
                SizeofOperand::IntegerZeroLiteral(scalar) => SizeofOperand::Scalar(scalar),
                other => other,
            };
            span = span.until(&right_span);
        }
        Ok((operand, span))
    }

    fn sizeof_conditional_expression(&mut self) -> Result<(SizeofOperand, Span), ParseError> {
        let (condition, condition_span) = self.sizeof_binary_expression(0, Self::sizeof_operand)?;
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
            self.require_sizeof_condition(&condition, condition_span)?;
            let accept = self.sizeof_comma_expression(Self::sizeof_conditional_expression)?;
            let colon_span = self.lexer.expect_span(Token::Separator(':'))?;
            self.parameter_expansion_budget.charge_work(1, colon_span)?;
            let reject = self.sizeof_conditional_expression()?;
            let span = condition_span.until(&reject.1);
            let operand = self.sizeof_conditional_arm_type(accept, reject)?;
            Ok((operand, span))
        })();
        self.function.expression_depth -= 1;
        result
    }

    fn require_sizeof_condition(
        &self,
        operand: &SizeofOperand,
        span: Span,
    ) -> Result<(), ParseError> {
        if !self.sizeof_bool_convertible(operand) {
            return Err(ParseError {
                message: String::from(
                    "sizeof conditional requires a scalar, pointer, array, or nullptr condition",
                ),
                span,
            });
        }
        Ok(())
    }

    fn sizeof_conditional_arm_type(
        &self,
        (accept, accept_span): (SizeofOperand, Span),
        (reject, reject_span): (SizeofOperand, Span),
    ) -> Result<SizeofOperand, ParseError> {
        Ok(match (accept, reject) {
            (SizeofOperand::Object(left), SizeofOperand::Object(right))
                if self.source_pointer_pointee(&left).is_some_and(|pointee| {
                    self.source_pointer_pointee(&right) == Some(pointee)
                        && !matches!(self.module.types[pointee].inner, TypeInner::Pointer { .. })
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
            (SizeofOperand::NullPointer, SizeofOperand::NullPointer) => SizeofOperand::NullPointer,
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
        })
    }

    fn sizeof_binary_expression(
        &mut self,
        minimum_precedence: u8,
        parse_operand: impl Fn(&mut Self) -> Result<(SizeofOperand, Span), ParseError> + Copy,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let (mut left, mut span) = parse_operand(self)?;
        while let Some((operator, precedence)) = expressions::binary_operator(self.lexer.peek()?.0)
        {
            if precedence < minimum_precedence {
                break;
            }
            let operator_span = self.lexer.next()?.1;
            self.parameter_expansion_budget
                .charge_work(1, operator_span)?;
            let (right, right_span) =
                self.sizeof_binary_expression(precedence + 1, parse_operand)?;
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
        if let Some((scalar, start)) = self.sizeof_qualified_or_decltype_cast_target()? {
            let (operand, end) =
                self.sizeof_functional_cast(scalar, start, Self::sizeof_conditional_expression)?;
            return self.sizeof_postfix_operand(operand, start, end);
        }
        let (token, start) = self.lexer.next()?;
        let (operand, end) = match token {
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
                if let Some(scalar) = self.sizeof_c_style_cast_target(start)? {
                    let (operand, end) = self.sizeof_operand()?;
                    let operand = self.sizeof_scalar_cast_result(scalar, &operand, end)?;
                    return Ok((operand, start.until(&end)));
                }
                let (operand, _) =
                    self.sizeof_comma_expression(Self::sizeof_conditional_expression)?;
                let closing = self.lexer.expect_span(Token::Paren(')'))?;
                (operand, start.until(&closing))
            }
            Token::Number(text) => (self.sizeof_numeric_literal(text, start)?, start),
            Token::Word("true" | "false") => (
                SizeofOperand::Scalar(SourceScalar::Scalar(Scalar::BOOL)),
                start,
            ),
            Token::Word("nullptr") => (SizeofOperand::NullPointer, start),
            Token::Word(name @ ("sizeof" | "alignof")) => {
                return self.sizeof_layout_operand(name, self.function.expression_depth, start);
            }
            Token::Word("static_cast") => {
                self.sizeof_static_cast(start, Self::sizeof_conditional_expression)?
            }
            Token::Word(name) => {
                if let Some(scalar) = self.sizeof_functional_cast_target(name, start)? {
                    self.sizeof_functional_cast(scalar, start, Self::sizeof_conditional_expression)?
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
        self.sizeof_postfix_operand(operand, start, end)
    }

    fn sizeof_postfix_operand(
        &mut self,
        mut operand: SizeofOperand,
        start: Span,
        mut end: Span,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        while matches!(
            self.lexer.peek()?.0,
            Token::Separator('.') | Token::Arrow | Token::Paren('[')
        ) {
            if self.lexer.next_if(Token::Paren('['))? {
                let (index, _) =
                    self.sizeof_comma_expression(Self::sizeof_conditional_expression)?;
                end = self.lexer.expect_span(Token::Paren(']'))?;
                let (base, index) = if self.sizeof_integral_operand(&operand) {
                    (index, operand)
                } else {
                    (operand, index)
                };
                operand = self.sizeof_subscript(base, index, start.until(&end))?;
                continue;
            }
            (operand, end) = self.sizeof_member(operand)?;
        }
        Ok((operand, start.until(&end)))
    }

    fn sizeof_member(
        &mut self,
        operand: SizeofOperand,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        let arrow = self.lexer.next()?.0 == Token::Arrow;
        let (field, field_span) = self.identifier()?;
        self.parameter_expansion_budget
            .charge_work(field.len() + 1, field_span)?;
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
            SizeofOperand::IncompleteArray(element) if arrow => TypeResolution::Handle(element),
            _ => return Err(invalid()),
        };
        let (_, ty) = self.field_type(&ty, field, field_span)?;
        Ok((SizeofOperand::Object(ty), field_span))
    }

    fn sizeof_c_style_cast_target(
        &mut self,
        start: Span,
    ) -> Result<Option<SourceScalar>, ParseError> {
        if !self.starts_type()? {
            return Ok(None);
        }
        self.parameter_expansion_budget.charge_work(2, start)?;
        let mut lookahead = self.lexer.clone();
        let target_span = lookahead.peek()?.1;
        let target = self.parse_type_from(&mut lookahead)?;
        if !lookahead.next_if(Token::Paren(')'))? {
            if target.ty.source_scalar().is_some()
                && self.scan_sizeof_function_declarator(&mut lookahead, 0)?
                && lookahead.next_if(Token::Paren(')'))?
                && matches!(
                    lookahead.peek()?.0,
                    Token::Word(_)
                        | Token::Number(_)
                        | Token::String(_)
                        | Token::ScopeResolution
                        | Token::Paren('(' | '[')
                        | Token::Operation('+' | '-' | '*' | '&' | '~' | '!')
                        | Token::IncrementOperation
                        | Token::DecrementOperation
                )
            {
                return Err(ParseError {
                    message: String::from(
                        "sizeof C-style cast requires an arithmetic scalar target",
                    ),
                    span: target_span,
                });
            }
            return Ok(None);
        }
        let scalar = target.ty.source_scalar().ok_or_else(|| ParseError {
            message: String::from("sizeof C-style cast requires an arithmetic scalar target"),
            span: target_span,
        })?;
        self.lexer = lookahead;
        Ok(Some(scalar))
    }

    fn sizeof_static_cast(
        &mut self,
        start: Span,
        parse_conditional: impl Fn(&mut Self) -> Result<(SizeofOperand, Span), ParseError>,
    ) -> Result<(SizeofOperand, Span), ParseError> {
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
        let (operand, operand_span) = self.sizeof_comma_expression(parse_conditional)?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        Ok((
            self.sizeof_scalar_cast_result(scalar, &operand, operand_span)?,
            start.until(&end),
        ))
    }

    fn sizeof_qualified_or_decltype_cast_target(
        &mut self,
    ) -> Result<Option<(SourceScalar, Span)>, ParseError> {
        let (token, start) = self.lexer.peek()?;
        let (target, span) = if token == Token::Word("decltype") {
            self.parameter_expansion_budget.charge_work(4, start)?;
            self.lexer.next()?;
            let (ty, end) = self.decltype_operand_type()?;
            (Some(ty), start.until(&end))
        } else {
            let Some(name) = self.qualified_item()? else {
                return Ok(None);
            };
            self.parameter_expansion_budget.charge_work(3, name.span)?;
            let target = match name.item {
                cooperative_groups::QualifiedItem::Type(ty) => Some(ty),
                _ => None,
            };
            (target, name.span)
        };
        let scalar = target
            .and_then(|ty| ty.ty.source_scalar())
            .ok_or_else(|| ParseError {
                message: String::from(
                    "sizeof functional cast requires an arithmetic scalar target",
                ),
                span,
            })?;
        Ok(Some((scalar, span)))
    }

    fn sizeof_functional_cast_target(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<Option<SourceScalar>, ParseError> {
        if self.lexer.peek()?.0 != Token::Paren('(') {
            return Ok(None);
        }
        self.parameter_expansion_budget.charge_work(1, span)?;
        Ok(self.type_name(name).and_then(|ty| ty.ty.source_scalar()))
    }

    fn sizeof_functional_cast(
        &mut self,
        scalar: SourceScalar,
        start: Span,
        parse_conditional: impl FnOnce(&mut Self) -> Result<(SizeofOperand, Span), ParseError>,
    ) -> Result<(SizeofOperand, Span), ParseError> {
        self.parameter_expansion_budget.charge_work(2, start)?;
        self.lexer.expect_span(Token::Paren('('))?;
        if let (Token::Paren(')'), end) = self.lexer.peek()? {
            self.lexer.next()?;
            return Ok((SizeofOperand::Scalar(scalar), start.until(&end)));
        }
        let (operand, operand_span) = parse_conditional(self)?;
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
        &self,
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
        if !self.sizeof_integral_operand(&index) {
            return Err(invalid());
        }
        let operand = self.sizeof_dereference(base, span).map_err(|_| invalid())?;
        if matches!(
            operand,
            SizeofOperand::Object(ref ty)
                if matches!(ty.inner_with(&self.module.types), TypeInner::Array { size: ArraySize::Dynamic, .. })
        ) {
            return Err(ParseError {
                message: String::from("sizeof subscript requires a complete element type"),
                span,
            });
        }
        Ok(operand)
    }

    fn sizeof_dereference(
        &self,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let element = match operand {
            SizeofOperand::Object(ref ty) => self.source_pointer_pointee(ty).or_else(|| match *ty
                .inner_with(&self.module.types)
            {
                TypeInner::Array { base, .. } => Some(base),
                _ => None,
            }),
            SizeofOperand::IncompleteArray(element) => Some(element),
            SizeofOperand::Scalar(_)
            | SizeofOperand::IntegerZeroLiteral(_)
            | SizeofOperand::NullPointer => None,
        }
        .ok_or_else(|| ParseError {
            message: String::from("sizeof dereference requires a pointer or array operand"),
            span,
        })?;
        Ok(SizeofOperand::Object(TypeResolution::Handle(element)))
    }

    fn sizeof_unary(
        &self,
        operator: char,
        operand: SizeofOperand,
        span: Span,
    ) -> Result<SizeofOperand, ParseError> {
        let invalid = || ParseError {
            message: String::from("invalid operand for sizeof builtin unary operator"),
            span,
        };
        let decayed_pointer = |base| {
            TypeResolution::Value(TypeInner::Pointer {
                base,
                space: self.source_pointer_space(base),
            })
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
            SizeofOperand::IncompleteArray(base) => decayed_pointer(base),
            SizeofOperand::Object(ty) => match *ty.inner_with(&self.module.types) {
                TypeInner::Array { base, .. } => decayed_pointer(base),
                _ => ty,
            },
        };
        if self.source_pointer_pointee(&ty).is_some() {
            return match operator {
                '+' => Ok(SizeofOperand::Object(ty)),
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
        &self,
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
            Symbol::Array { pointer, .. } => {
                let array = match self.function.ir.expressions[pointer] {
                    Expression::LocalVariable(local) => {
                        if self.function.pending_array == Some(local) {
                            let element = self.function.ir.local_variables[local].ty;
                            return Ok(SizeofOperand::IncompleteArray(element));
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
                return Ok(SizeofOperand::IncompleteArray(
                    self.dynamic_shared_element_type(declaration),
                ));
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
        let sizeof_sum_chain = format!("sizeof({}1) / 4]", "0 + ".repeat(128));
        let sizeof_comma_chain = format!("sizeof({}1) / 4]", "0L,".repeat(128));
        let array_rank = format!("sizeof(int{}) / 4]", "[1]".repeat(64));
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
            ("sizeof One / 4]", true, true),
            ("sizeof(One) / 4]", false, true),
            ("sizeof(0x1.8p+2f) / 4]", true, true),
            ("sizeof nullptr / 8]", false, true),
            ("sizeof true]", true, true),
            ("sizeof Pair.y / 4]", true, true),
            ("sizeof Items[((One))] / 4]", true, true),
            ("sizeof(0[Items]) / 4]", true, true),
            ("sizeof(0[1[2[3[4[Items]]]]]) / 4]", false, false),
            ("sizeof(Items[false]) / 4]", false, true),
            ("sizeof(Items[1.0f < 2.0f]) / 4]", true, true),
            ("sizeof(Items[Items[Items[Items[0]]]]) / 4]", false, false),
            ("sizeof Items[One ? short(1 / 0) : -1] / 4]", true, true),
            ("sizeof Items[One + sizeof(int[1 + 1])] / 4]", false, true),
            ("sizeof Items[((((One))))] / 4]", false, false),
            ("sizeof (*Items) / 4]", true, true),
            ("sizeof *((Items)) / 4]", false, true),
            ("sizeof *+Items / 4]", true, true),
            ("sizeof(+Items) / 8]", false, true),
            ("sizeof(-~!!One) / 4]", false, false),
            (sizeof_sum_chain.as_str(), true, true),
            (sizeof_comma_chain.as_str(), true, true),
            ("sizeof(true ? 0L, 1 : 1) / 4]", false, true),
            ("sizeof(((((1 + 1))))) / 4]", false, false),
            ("sizeof(true ? 1 : false ? 0L : 4) / 8]", true, true),
            ("sizeof static_cast<unsigned long>(0) / 8]", true, true),
            ("sizeof((short)(+One)) / 2]", true, true),
            ("sizeof((short)(short)(short)(short)1) / 2]", false, false),
            ("sizeof short(One) / 2]", true, true),
            ("sizeof sizeof One / 8]", true, true),
            ("sizeof(alignof(int[sizeof(One)])) / 8]", false, true),
            ("sizeof sizeof sizeof sizeof sizeof One / 8]", false, false),
            ("sizeof(short() + 1) / 4]", true, true),
            ("sizeof((true ? short() : short())) / 2]", false, true),
            ("sizeof decltype(One)(1) / 4]", true, true),
            (
                "sizeof(decltype(One)(decltype(One)(decltype(One)(decltype(One)(1))))) / 4]",
                false,
                false,
            ),
            ("sizeof ::Index(One) / 2]", true, true),
            ("sizeof(::Index(::Index(::Index(::Index(1))))) / 2]", false, false),
            ("sizeof(short(short(short(short(1))))) / 2]", false, false),
            ("sizeof(static_cast<short>(static_cast<short>(static_cast<short>(static_cast<short>(1))))) / 2]", false, false),
            (
                "sizeof(true ? 1 : true ? 1 : true ? 1 : true ? 1 : 1) / 4]",
                false,
                false,
            ),
            (
                "sizeof(true ? true ? true ? true ? 1 : 1 : 1 : 1 : 1) / 4]",
                false,
                false,
            ),
            ("sizeof (((((*Items))))) / 4]", false, false),
            ("sizeof(void const * const * volatile) / 8]", true, true),
            ("alignof(Fixed &) / 4]", false, true),
            ("sizeof(int[sizeof(int)][2]) / 32]", true, true),
            ("alignof(int[][3]) / 4]", false, true),
            (array_rank.as_str(), true, true),
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
            parser.global_declarations.insert(
                "Pair",
                GlobalDeclaration::Constant {
                    handle: None,
                    ty: TypeResolution::Value(TypeInner::Vector {
                        size: VectorSize::Bi,
                        scalar: Scalar::I32,
                    }),
                    literal: None,
                },
            );
            parser.global_declarations.insert(
                "Items",
                GlobalDeclaration::Constant {
                    handle: None,
                    ty: TypeResolution::Handle(array),
                    literal: None,
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
    fn offsetof_indirect_type_queries_charge_for_pointer_qualifiers() {
        let source = format!("sizeof(void *{})", "__restrict__ ".repeat(64));
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        let (index, _) = parser
            .record_offset_index(0, 0, RecordOffsetIndexMode::Evaluate)
            .unwrap();
        assert_eq!(index.value, Some(8));

        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        let span = Span::new(0, 1);
        parser.parameter_expansion_budget.activate();
        for bit in (4..usize::BITS).rev() {
            let _ = parser
                .parameter_expansion_budget
                .charge_work(1usize << bit, span);
        }
        assert!(parser
            .record_offset_index(0, 0, RecordOffsetIndexMode::Evaluate)
            .is_err());
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.module.types.is_empty());
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
