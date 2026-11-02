use super::*;

#[derive(Clone, Copy, Debug, PartialEq)]
pub(super) enum Namespace {
    CooperativeGroups,
}

#[derive(Debug)]
pub(super) struct ThreadBlockValue {
    pub(super) span: Span,
    pub(super) constant: ConstantValue,
}

pub(super) enum QualifiedItem {
    Namespace(Namespace),
    Type(QualifiedType),
    Function(GroupFunction),
}

pub(super) enum GroupFunction {
    Current,
    Sync,
    Static(GroupMethod),
}

#[derive(Clone, Copy)]
pub(super) enum GroupMethod {
    Sync,
    Rank,
    Size,
    GroupIndex,
    ThreadIndex,
    Dimensions,
}

pub(super) struct QualifiedName {
    pub(super) item: QualifiedItem,
    pub(super) span: Span,
}

fn method(name: &str, span: Span) -> Result<GroupMethod, ParseError> {
    match name {
        "sync" => Ok(GroupMethod::Sync),
        "thread_rank" => Ok(GroupMethod::Rank),
        "size" | "num_threads" => Ok(GroupMethod::Size),
        "group_index" => Ok(GroupMethod::GroupIndex),
        "thread_index" => Ok(GroupMethod::ThreadIndex),
        "dim_threads" | "group_dim" => Ok(GroupMethod::Dimensions),
        _ => Err(ParseError {
            message: format!("unsupported thread_block method `{name}`"),
            span,
        }),
    }
}

fn qualifier(
    name: &str,
    global: bool,
    namespace_only: bool,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    span: Span,
) -> Result<QualifiedItem, ParseError> {
    let symbol = (!global)
        .then(|| {
            symbols.lookup_where(name, |symbol| {
                matches!(symbol, Symbol::Namespace(_))
                    || (!namespace_only && matches!(symbol, Symbol::Type(_)))
            })
        })
        .flatten();
    match symbol {
        Some(&Symbol::Namespace(namespace)) => return Ok(QualifiedItem::Namespace(namespace)),
        Some(&Symbol::Type(ref ty)) => return Ok(QualifiedItem::Type(ty.clone())),
        _ => {}
    }
    match globals.get(name) {
        Some(&GlobalDeclaration::Namespace(namespace)) => Ok(QualifiedItem::Namespace(namespace)),
        Some(&GlobalDeclaration::Type(ref ty)) if !namespace_only => {
            Ok(QualifiedItem::Type(ty.clone()))
        }
        _ => Err(ParseError {
            message: format!("unknown CUDA namespace or type qualifier `{name}`"),
            span,
        }),
    }
}

fn qualified_name(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    namespace_only: bool,
) -> Result<QualifiedName, ParseError> {
    let start = lexer.peek()?.1.to_range().unwrap().start;
    let global = lexer.next_if(Token::ScopeResolution)?;
    let (Token::Word(name), span) = lexer.next()? else {
        return Err(ParseError {
            message: String::from("expected a namespace or type qualifier"),
            span: lexer.peek()?.1,
        });
    };
    let mut item = qualifier(name, global, namespace_only, symbols, globals, span)?;
    while lexer.next_if(Token::ScopeResolution)? {
        let (token, span) = lexer.next()?;
        let Token::Word(name) = token else {
            return Err(ParseError {
                message: String::from("expected a qualified CUDA name"),
                span,
            });
        };
        item = match item {
            QualifiedItem::Namespace(Namespace::CooperativeGroups) => match name {
                "thread_block" if !namespace_only => QualifiedItem::Type(QualifiedType {
                    ty: TypeSpecifier::ThreadBlock,
                    qualifiers: Qualifiers::NONE,
                }),
                "this_thread_block" if !namespace_only => {
                    QualifiedItem::Function(GroupFunction::Current)
                }
                "sync" if !namespace_only => QualifiedItem::Function(GroupFunction::Sync),
                _ => {
                    return Err(ParseError {
                        message: format!("unsupported Cooperative Groups name `{name}`"),
                        span,
                    })
                }
            },
            QualifiedItem::Type(QualifiedType {
                ty: TypeSpecifier::ThreadBlock,
                ..
            }) => QualifiedItem::Function(GroupFunction::Static(method(name, span)?)),
            _ => {
                return Err(ParseError {
                    message: String::from("unsupported CUDA type qualification"),
                    span,
                })
            }
        };
    }
    Ok(QualifiedName {
        item,
        span: lexer.span_from(start),
    })
}

pub(super) fn try_qualified_name(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
) -> Result<Option<QualifiedName>, ParseError> {
    let mut lookahead = lexer.clone();
    if lookahead.peek()?.0 != Token::ScopeResolution {
        if !matches!(lookahead.next()?.0, Token::Word(_))
            || !matches!(lookahead.peek(), Ok((Token::ScopeResolution, _)))
        {
            return Ok(None);
        }
    }
    qualified_name(lexer, symbols, globals, false).map(Some)
}

impl<'a> Parser<'a> {
    pub(super) fn thread_block_parameter(&mut self, span: Span) -> Result<(), ParseError> {
        if self.function.kind == FunctionKind::Kernel {
            return Err(ParseError {
                message: String::from("thread_block kernel parameters are unsupported"),
                span,
            });
        }
        if matches!(
            self.lexer.peek()?.0,
            Token::Operation('*' | '&') | Token::LogicalOperation('&') | Token::Paren('[' | '(')
        ) {
            return self.fail("thread_block parameters must be passed by value");
        }
        self.activate_parameter_expansion(span)?;
        if self.function.physical_parameter_modes.is_none() {
            self.parameter_expansion_budget
                .charge_slice::<ParameterMode>(self.function.parameters.len(), span)?;
            self.parameter_expansion_budget
                .charge_work(self.function.parameters.len(), span)?;
            self.function.physical_parameter_modes = Some(
                self.function
                    .parameters
                    .iter()
                    .copied()
                    .map(SourceParameter::mode)
                    .collect(),
            );
        }
        self.parameter_expansion_budget
            .charge_slice::<SourceParameter>(1, span)?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        self.function.parameters.push(SourceParameter::ThreadBlock);
        if matches!(
            self.lexer.peek()?.0,
            Token::Separator(',') | Token::Paren(')')
        ) {
            return Ok(());
        }
        let (name, name_span) = self.identifier()?;
        self.check_name(name, name_span)?;
        if self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("thread_block array parameters are unsupported");
        }
        self.insert_symbol(name, Symbol::ThreadBlock, name_span)
    }

    pub(super) fn namespace_alias_declaration(&mut self, global: bool) -> Result<(), ParseError> {
        let (name, span) = self.identifier()?;
        self.check_name(name, span)?;
        if global {
            self.check_dynamic_shared_linkage(name, span)?;
        }
        self.lexer.expect_span(Token::Operation('='))?;
        let target = qualified_name(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            true,
        )?;
        let QualifiedItem::Namespace(namespace) = target.item else {
            return self.fail("namespace aliases require a namespace target");
        };
        self.lexer.expect_span(Token::Separator(';'))?;
        let compatible = if global {
            match self
                .global_declarations
                .insert(name, GlobalDeclaration::Namespace(namespace))
            {
                None => true,
                Some(GlobalDeclaration::Namespace(previous)) => previous == namespace,
                _ => false,
            }
        } else {
            match self
                .function
                .symbol_table
                .add(name, Symbol::Namespace(namespace))
            {
                None => true,
                Some(Symbol::Namespace(previous)) => previous == namespace,
                _ => false,
            }
        };
        if compatible {
            Ok(())
        } else {
            Err(ParseError {
                message: format!("incompatible namespace alias `{name}`"),
                span,
            })
        }
    }

    pub(super) fn qualified_item(&mut self) -> Result<Option<QualifiedName>, ParseError> {
        try_qualified_name(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )
    }

    pub(super) fn qualified_expression(
        &mut self,
        name: QualifiedName,
    ) -> Result<ExpressionResult, ParseError> {
        match name.item {
            QualifiedItem::Type(ty) => {
                if ty.qualifiers.is_volatile && !matches!(ty.ty, TypeSpecifier::Scalar(_)) {
                    return self.fail("volatile class value construction is unsupported");
                }
                self.type_expression(ty, name.span)
            }
            QualifiedItem::Function(GroupFunction::Current) => {
                self.lexer.expect_span(Token::Paren('('))?;
                let end = self.lexer.expect_span(Token::Paren(')'))?;
                Ok(ExpressionResult::ThreadBlock(ThreadBlockValue {
                    span: name.span.until(&end),
                    constant: ConstantValue::default(),
                }))
            }
            QualifiedItem::Function(GroupFunction::Sync) => {
                self.lexer.expect_span(Token::Paren('('))?;
                let group = self.expression_result(0)?;
                self.require_thread_block(group)?;
                let end = self.lexer.expect_span(Token::Paren(')'))?;
                let span = name.span.until(&end);
                self.emit_workgroup_barrier(span)?;
                Ok(ExpressionResult::Void(span))
            }
            QualifiedItem::Function(GroupFunction::Static(method)) => {
                self.thread_block_method(method, name.span)
            }
            _ => Err(ParseError {
                message: String::from("namespace cannot be used as a value"),
                span: name.span,
            }),
        }
    }

    pub(super) fn require_thread_block(
        &self,
        result: ExpressionResult,
    ) -> Result<ThreadBlockValue, ParseError> {
        match result {
            ExpressionResult::ThreadBlock(value) => Ok(value),
            ExpressionResult::Value(value) => Err(ParseError {
                message: String::from("expected a thread_block handle"),
                span: value.span(),
            }),
            ExpressionResult::Void(span) => Err(ParseError {
                message: String::from("expected a thread_block handle"),
                span,
            }),
        }
    }

    pub(super) fn thread_block_copy(&mut self) -> Result<ExpressionResult, ParseError> {
        let opening = self.lexer.next()?;
        let closing = match opening.0 {
            Token::Paren('(') => ')',
            Token::Paren('{') => '}',
            _ => {
                return Err(ParseError {
                    message: String::from("thread_block copy construction requires one handle"),
                    span: opening.1,
                })
            }
        };
        if self.lexer.peek()?.0 == Token::Paren(closing) {
            return self.fail("thread_block has no default constructor");
        }
        let result = self.expression_result(0)?;
        self.require_thread_block(result)?;
        if closing == '}' {
            self.lexer.next_if(Token::Separator(','))?;
        }
        let end = self.lexer.expect_span(Token::Paren(closing))?;
        Ok(ExpressionResult::ThreadBlock(ThreadBlockValue {
            span: opening.1.until(&end),
            constant: ConstantValue::default(),
        }))
    }

    pub(super) fn thread_block_declaration(&mut self) -> Result<(), ParseError> {
        loop {
            if matches!(
                self.lexer.peek()?.0,
                Token::Operation('*' | '&') | Token::LogicalOperation('&')
            ) {
                return self
                    .fail("thread_block pointer and reference declarations are unsupported");
            }
            let (name, span) = self.identifier()?;
            self.check_name(name, span)?;
            if self.lexer.peek()?.0 == Token::Paren('[') {
                return self.fail("thread_block arrays are unsupported");
            }
            self.insert_symbol(name, Symbol::PendingThreadBlock, span)?;
            let has_equals = self.lexer.next_if(Token::Operation('='))?;
            let result = if self.lexer.peek()?.0 == Token::Paren('{')
                || (!has_equals && self.lexer.peek()?.0 == Token::Paren('('))
            {
                self.thread_block_copy()?
            } else if has_equals {
                self.expression_result(0)?
            } else {
                return self.fail("thread_block has no default constructor");
            };
            self.require_thread_block(result)?;
            self.function.symbol_table.add(name, Symbol::ThreadBlock);
            self.function.initialized_declarations.push(span);
            if !self.lexer.next_if(Token::Separator(','))? {
                self.lexer.expect_span(Token::Separator(';'))?;
                return Ok(());
            }
        }
    }

    pub(super) fn thread_block_member(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.thread_block_method(method(name, span)?, span)
    }

    fn thread_block_method(
        &mut self,
        method: GroupMethod,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        let span = span.until(&end);
        if matches!(method, GroupMethod::Sync) {
            self.emit_workgroup_barrier(span)?;
            return Ok(ExpressionResult::Void(span));
        }
        if matches!(
            method,
            GroupMethod::GroupIndex | GroupMethod::ThreadIndex | GroupMethod::Dimensions
        ) {
            return self.thread_block_dimensions(method, span).map(Into::into);
        }
        let handle = match method {
            GroupMethod::Size => self.append(
                Expression::Literal(Literal::U32(self.workgroup_size.into_iter().product())),
                span,
            )?,
            GroupMethod::Rank => {
                let base = if self.function.kind == FunctionKind::Device {
                    self.helper_builtin_value(0, span)?
                } else {
                    self.builtin_input(0, span)?
                };
                let x = self.append(Expression::AccessIndex { base, index: 0 }, span)?;
                let y = self.append(Expression::AccessIndex { base, index: 1 }, span)?;
                let z = self.append(Expression::AccessIndex { base, index: 2 }, span)?;
                let width = self.append(
                    Expression::Literal(Literal::U32(self.workgroup_size[0])),
                    span,
                )?;
                let height = self.append(
                    Expression::Literal(Literal::U32(self.workgroup_size[1])),
                    span,
                )?;
                let z = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Multiply,
                        left: height,
                        right: z,
                    },
                    span,
                )?;
                let yz = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: y,
                        right: z,
                    },
                    span,
                )?;
                let yz = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Multiply,
                        left: width,
                        right: yz,
                    },
                    span,
                )?;
                self.append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: x,
                        right: yz,
                    },
                    span,
                )?
            }
            GroupMethod::Sync
            | GroupMethod::GroupIndex
            | GroupMethod::ThreadIndex
            | GroupMethod::Dimensions => unreachable!(),
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: scalar_resolution(Scalar::U32),
            span,
            constant: ConstantValue::default(),
        }
        .into())
    }

    fn thread_block_dimensions(
        &mut self,
        method: GroupMethod,
        span: Span,
    ) -> Result<Value, ParseError> {
        let mut components = Vec::with_capacity(3);
        match method {
            GroupMethod::GroupIndex | GroupMethod::ThreadIndex => {
                let slot = match method {
                    GroupMethod::GroupIndex => 1,
                    GroupMethod::ThreadIndex => 0,
                    _ => unreachable!(),
                };
                let base = if self.function.kind == FunctionKind::Device {
                    self.helper_builtin_value(slot, span)?
                } else {
                    self.builtin_input(slot, span)?
                };
                for index in 0..3 {
                    components.push(self.append(Expression::AccessIndex { base, index }, span)?);
                }
            }
            GroupMethod::Dimensions => {
                for extent in self.workgroup_size {
                    components.push(self.append(Expression::Literal(Literal::U32(extent)), span)?);
                }
            }
            GroupMethod::Sync | GroupMethod::Rank | GroupMethod::Size => unreachable!(),
        }
        let ty = self.dim3_type(span);
        let handle = self.append(Expression::Compose { ty, components }, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            handle,
            ty: TypeResolution::Handle(ty),
            span,
            constant: ConstantValue::default(),
        })
    }
}
