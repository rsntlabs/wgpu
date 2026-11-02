use super::*;

impl Parser<'_> {
    pub(super) fn dim3_type(&mut self, span: Span) -> Handle<Type> {
        if let Some(ty) = self.dim3_type {
            return ty;
        }
        let scalar = self.scalar_handle(Scalar::U32, span);
        let members = ["x", "y", "z"]
            .into_iter()
            .enumerate()
            .map(|(index, name)| StructMember {
                name: Some(String::from(name)),
                ty: scalar,
                binding: None,
                offset: index as u32 * 4,
            })
            .collect();
        let ty = self.module.types.insert(
            Type {
                name: Some(String::from("dim3")),
                inner: TypeInner::Struct { members, span: 12 },
            },
            span,
        );
        self.structures.insert(
            ty,
            structures::Structure {
                source_name: None,
                depth: 1,
                requires_default_constructor: true,
                const_default_constructible: true,
            },
        );
        self.dim3_type = Some(ty);
        ty
    }

    pub(super) fn is_dim3(&self, ty: &TypeResolution) -> bool {
        ty.handle().is_some_and(|ty| Some(ty) == self.dim3_type)
    }

    pub(super) fn is_uint3(&self, ty: &TypeResolution) -> bool {
        ty.handle().is_some_and(|ty| Some(ty) == self.uint3_type)
    }

    pub(super) fn dimension_conversion(
        &self,
        source: &TypeResolution,
        target: &TypeResolution,
    ) -> bool {
        if self.is_dim3(target) {
            self.is_uint3(source)
                || matches!(*source.inner_with(&self.module.types), TypeInner::Scalar(_))
        } else {
            self.is_uint3(target) && self.is_dim3(source)
        }
    }

    pub(super) fn convert_dimension(
        &mut self,
        value: ExpressionValue,
        target: &TypeResolution,
    ) -> Result<Value, ParseError> {
        let value = self.rvalue(value)?;
        if matches!(
            *value.ty.inner_with(&self.module.types),
            TypeInner::Scalar(_)
        ) {
            let span = value.span;
            return self.construct_dim3(alloc::vec![value], false, span);
        }
        let span = value.span;
        let mut components = Vec::with_capacity(3);
        for index in 0..3 {
            components.push(self.append(
                Expression::AccessIndex {
                    base: value.handle,
                    index,
                },
                span,
            )?);
        }
        let ty = self.type_handle(target, span);
        let handle = self.append(Expression::Compose { ty, components }, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: target.clone(),
            span,
            constant: value.constant,
        })
    }

    pub(super) fn dim3_constructor(&mut self, span: Span) -> Result<Value, ParseError> {
        let (closing, list_initialization) = match self.lexer.next()?.0 {
            Token::Paren('(') => (')', false),
            Token::Paren('{') => ('}', true),
            _ => return self.fail("expected a dim3 constructor argument list"),
        };
        self.dim3_arguments(closing, list_initialization, span, None)
    }

    pub(super) fn dim3_initializer(&mut self) -> Result<Value, ParseError> {
        let has_equals = self.lexer.next_if(Token::Operation('='))?;
        let token = self.lexer.peek()?;
        if token.0 == Token::Paren('{') || (!has_equals && token.0 == Token::Paren('(')) {
            if token.0 == Token::Paren('(') {
                let mut lookahead = self.lexer.clone();
                lookahead.next()?;
                let empty = lookahead.next_if(Token::Paren(')'))?;
                let function_parameter = !empty
                    && self.parse_type_from(&mut lookahead).is_ok()
                    && lookahead.next_if(Token::Paren('('))?
                    && lookahead.next_if(Token::Paren(')'))?
                    && lookahead.next_if(Token::Paren(')'))?;
                if empty || function_parameter {
                    return Err(ParseError {
                        message: String::from("local function declarations are unsupported"),
                        span: token.1,
                    });
                }
            }
            return self.dim3_constructor(token.1);
        }
        if !has_equals {
            self.lexer.expect_span(Token::Operation('='))?;
        }
        let expression = self.expression(0)?;
        let value = self.rvalue(expression)?;
        let span = value.span;
        self.construct_dim3(alloc::vec![value], false, span)
    }

    pub(super) fn dim3_list_initializer(
        &mut self,
        span: Span,
        pending: Option<Value>,
    ) -> Result<Value, ParseError> {
        self.dim3_arguments('}', true, span, pending)
    }

    fn dim3_arguments(
        &mut self,
        closing: char,
        list_initialization: bool,
        span: Span,
        pending: Option<Value>,
    ) -> Result<Value, ParseError> {
        let mut arguments: Vec<_> = pending.into_iter().collect();
        if arguments.is_empty() && self.lexer.peek()?.0 != Token::Paren(closing) {
            let value = self.expression(0)?;
            arguments.push(self.rvalue(value)?);
        }
        if !arguments.is_empty() {
            while self.lexer.next_if(Token::Separator(','))? {
                if list_initialization && self.lexer.peek()?.0 == Token::Paren(closing) {
                    break;
                }
                if arguments.len() == 3 {
                    return self.fail("dim3 constructors accept at most three arguments");
                }
                let value = self.expression(0)?;
                arguments.push(self.rvalue(value)?);
            }
        }
        let end = self.lexer.expect_span(Token::Paren(closing))?;
        self.construct_dim3(arguments, list_initialization, span.until(&end))
    }

    pub(super) fn construct_dim3(
        &mut self,
        mut arguments: Vec<Value>,
        list_initialization: bool,
        span: Span,
    ) -> Result<Value, ParseError> {
        let ty = TypeResolution::Handle(self.dim3_type(span));
        if arguments.len() == 1 {
            if self.is_dim3(&arguments[0].ty) {
                let mut value = arguments.pop().unwrap();
                value.span = span;
                return Ok(value);
            }
            if self.is_uint3(&arguments[0].ty) {
                let mut value = self.convert_dimension(arguments.pop().unwrap().into(), &ty)?;
                value.span = span;
                return Ok(value);
            }
        }
        let mut components = Vec::with_capacity(3);
        let mut is_discardable = true;
        for value in arguments {
            let value = if list_initialization {
                self.list_convert_scalar(value, Scalar::U32)?
            } else {
                self.convert_scalar(value.into(), Scalar::U32)?
            };
            is_discardable &= value.constant.literal.is_some();
            components.push(value.handle);
        }
        while components.len() < 3 {
            components.push(self.append(Expression::Literal(Literal::U32(1)), span)?);
        }
        let handle = self.append(
            Expression::Compose {
                ty: ty.handle().unwrap(),
                components,
            },
            span,
        )?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty,
            span,
            constant: ConstantValue {
                literal: None,
                is_discardable,
                is_null_pointer_constant: false,
            },
        })
    }
}
