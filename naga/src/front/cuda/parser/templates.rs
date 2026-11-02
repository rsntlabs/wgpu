use super::super::lexer::LexerPosition;
use super::functions::{FunctionCandidate, FunctionHeader, OverloadResolution, ReturnType};
use super::*;

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
enum TemplateValue {
    Int(i32),
    Uint(u32),
    Bool(bool),
}

impl TemplateValue {
    const fn literal(self) -> Literal {
        match self {
            Self::Int(value) => Literal::I32(value),
            Self::Uint(value) => Literal::U32(value),
            Self::Bool(value) => Literal::Bool(value),
        }
    }

    fn converted(value: Literal, scalar: Scalar) -> Option<Self> {
        let value = match value {
            Literal::I32(value) => i64::from(value),
            Literal::U32(value) => i64::from(value),
            Literal::Bool(value) => i64::from(value),
            _ => return None,
        };
        match scalar {
            Scalar::I32 => i32::try_from(value).ok().map(Self::Int),
            Scalar::U32 => u32::try_from(value).ok().map(Self::Uint),
            Scalar::BOOL if value == 0 || value == 1 => Some(Self::Bool(value != 0)),
            _ => None,
        }
    }

    fn spelling(self) -> String {
        match self {
            Self::Int(value) => format!("{value}"),
            Self::Uint(value) => format!("{value}u"),
            Self::Bool(value) => String::from(if value { "true" } else { "false" }),
        }
    }
}

#[derive(Clone)]
struct TemplateParameter<'a> {
    name: &'a str,
    scalar: Scalar,
    span: Span,
}

struct Definition<'a> {
    parameters: Lexer<'a>,
    end: LexerPosition,
    globals: FastHashMap<&'a str, GlobalDeclaration>,
}

struct FunctionTemplate<'a> {
    header: FunctionHeader<'a>,
    parameters: Vec<TemplateParameter<'a>>,
    signature: Vec<SourceParameter>,
    result: Option<Handle<Type>>,
    definition: Option<Definition<'a>>,
}

#[derive(Clone, Eq, Hash, PartialEq)]
struct InstanceKey {
    template: usize,
    arguments: Vec<TemplateValue>,
}

#[derive(Clone, Copy)]
enum InstanceTarget {
    Device(Handle<Function>),
    Kernel(usize),
}

struct Instance {
    key: InstanceKey,
    target: InstanceTarget,
    queued: bool,
    span: Span,
}

#[derive(Default)]
pub(super) struct Templates<'a> {
    declarations: Vec<FunctionTemplate<'a>>,
    instances: Vec<Instance>,
    keys: FastHashMap<InstanceKey, usize>,
    pending: Vec<usize>,
    pub(super) parsing_signature: bool,
}

impl<'a> Parser<'a> {
    pub(super) fn template_parameter_value(
        &mut self,
        scalar: Scalar,
        literal: Option<Literal>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let literal = literal.ok_or_else(|| ParseError {
            message: String::from("dependent template parameter requires an instantiation"),
            span,
        })?;
        let handle = self.append(Expression::Literal(literal), span)?;
        Ok(Value {
            handle,
            ty: scalar_resolution(scalar),
            span,
            constant: literal.into(),
        }
        .into())
    }

    pub(super) fn has_function_template(&self, name: &str) -> bool {
        self.lookup_symbol(name).is_none()
            && matches!(self.global_declarations.get(name), Some(GlobalDeclaration::Functions(overloads)) if !overloads.templates.is_empty())
    }

    fn clone_template_environment(
        &mut self,
        span: Span,
    ) -> Result<FastHashMap<&'a str, GlobalDeclaration>, ParseError> {
        Self::charge_template_environment(
            &self.global_declarations,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        Ok(self.global_declarations.clone())
    }

    fn charge_template_environment(
        declarations: &FastHashMap<&'a str, GlobalDeclaration>,
        budget: &mut parameter_expansion::ExpansionBudget,
        span: Span,
    ) -> Result<(), ParseError> {
        budget.charge_map_entry::<&str, GlobalDeclaration>(declarations.len(), span)?;
        budget.charge_work(declarations.len(), span)?;
        for declaration in declarations.values() {
            if let &GlobalDeclaration::Functions(ref overloads) = declaration {
                budget.charge_slice::<Handle<Function>>(overloads.functions.len(), span)?;
                budget.charge_slice::<usize>(overloads.templates.len(), span)?;
                budget.charge_work(overloads.functions.len() + overloads.templates.len(), span)?;
            }
        }
        Ok(())
    }

    fn bind_template_parameters(
        &mut self,
        parameters: &[TemplateParameter<'a>],
        arguments: Option<&[TemplateValue]>,
    ) -> Result<(), ParseError> {
        for (index, parameter) in parameters.iter().enumerate() {
            self.parameter_expansion_budget
                .charge_work(1, parameter.span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<&str, Symbol>(1, parameter.span)?;
            self.insert_symbol(
                parameter.name,
                Symbol::TemplateParameter {
                    scalar: parameter.scalar,
                    literal: arguments.map(|arguments| arguments[index].literal()),
                },
                parameter.span,
            )?;
        }
        Ok(())
    }

    pub(super) fn template_declaration(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.expect_span(Token::Word("template"))?;
        self.activate_parameter_expansion(span)?;
        if !self.lexer.next_if(Token::Paren('<'))? {
            return self.explicit_kernel_instantiation(span);
        }
        let saved = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        self.templates.parsing_signature = true;
        let signature_result = self.template_signature(span);
        self.templates.parsing_signature = false;
        self.function = saved;
        let (declaration, parameters_lexer) = signature_result?;
        let FunctionTemplate {
            mut header,
            parameters,
            signature,
            result,
            ..
        } = declaration;
        let is_definition = self.lexer.peek()?.0 == Token::Paren('{');
        if is_definition {
            self.skip_template_body()?;
        } else {
            self.lexer.expect_span(Token::Separator(';'))?;
        }
        let end = self.lexer.position();
        if let Some(&GlobalDeclaration::Functions(ref overloads)) =
            self.global_declarations.get(header.name)
        {
            let comparison_work = parameters
                .len()
                .checked_add(signature.len())
                .and_then(|count| count.checked_add(3))
                .and_then(|count| count.checked_mul(overloads.templates.len()))
                .ok_or_else(|| ParseError {
                    message: String::from("CUDA template declaration limit exceeded"),
                    span,
                })?;
            self.parameter_expansion_budget
                .charge_work(comparison_work, span)?;
        }
        let previous = match self.global_declarations.get(header.name) {
            Some(&GlobalDeclaration::Functions(ref overloads)) => {
                overloads.templates.iter().copied().find(|&id| {
                    let previous = &self.templates.declarations[id];
                    previous.parameters.len() == parameters.len()
                        && previous
                            .parameters
                            .iter()
                            .zip(&parameters)
                            .all(|(left, right)| left.scalar == right.scalar)
                        && previous.signature == signature
                })
            }
            Some(_) => {
                return Err(ParseError {
                    message: format!("incompatible template declaration `{}`", header.name),
                    span: header.name_span,
                })
            }
            None => None,
        };
        let id = if let Some(id) = previous {
            let previous = &mut self.templates.declarations[id];
            if previous.header.kind != header.kind || previous.result != result {
                return Err(ParseError {
                    message: String::from("incompatible function template redeclaration"),
                    span: header.name_span,
                });
            }
            function_declarations::check_redeclaration(
                previous.header.has_host,
                previous.header.is_static,
                previous.header.inlining,
                header.has_host,
                header.is_static,
                header.inlining,
                header.name_span,
            )?;
            if is_definition && previous.definition.is_some() {
                return Err(ParseError {
                    message: String::from("duplicate function template definition"),
                    span: header.name_span,
                });
            }
            header.is_static = previous.header.is_static;
            header.inlining = previous.header.inlining.or(header.inlining);
            previous.header.inlining = header.inlining;
            id
        } else {
            if let Some(&GlobalDeclaration::Functions(ref overloads)) =
                self.global_declarations.get(header.name)
            {
                if header.kind == FunctionKind::Kernel
                    && (!overloads.functions.is_empty() || !overloads.templates.is_empty())
                    || overloads.templates.iter().any(|&id| {
                        self.templates.declarations[id].header.kind == FunctionKind::Kernel
                    })
                {
                    return Err(ParseError {
                        message: String::from("kernel template overloading is unsupported"),
                        span: header.name_span,
                    });
                }
            }
            self.parameter_expansion_budget
                .charge_slice::<FunctionTemplate<'_>>(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<usize>(1, span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
            let id = self.templates.declarations.len();
            self.templates.declarations.push(FunctionTemplate {
                header: header.clone(),
                parameters: Vec::new(),
                signature,
                result,
                definition: None,
            });
            let &mut GlobalDeclaration::Functions(ref mut overloads) = self
                .global_declarations
                .entry(header.name)
                .or_insert_with(|| GlobalDeclaration::Functions(FunctionOverloads::default()))
            else {
                unreachable!()
            };
            overloads.templates.push(id);
            id
        };
        if previous.is_none() || is_definition {
            self.templates.declarations[id].parameters = parameters;
        }
        if is_definition {
            let globals = self.clone_template_environment(span)?;
            let declaration = &mut self.templates.declarations[id];
            declaration.header = header;
            declaration.definition = Some(Definition {
                parameters: parameters_lexer,
                end,
                globals,
            });
        }
        Ok(())
    }

    fn template_signature(
        &mut self,
        span: Span,
    ) -> Result<(FunctionTemplate<'a>, Lexer<'a>), ParseError> {
        self.prepare_parameter_bindings(span)?;
        if self.lexer.peek()?.0 == Token::Paren('>') {
            return self.fail("explicit template specializations are unsupported");
        }
        let mut parameters = Vec::new();
        loop {
            let parameter_span = self.lexer.peek()?.1;
            let ty = self.parse_type()?;
            let TypeSpecifier::Scalar(scalar @ (Scalar::I32 | Scalar::U32 | Scalar::BOOL)) = ty.ty
            else {
                return Err(ParseError {
                    message: String::from("template parameters must be int, unsigned, or bool"),
                    span: parameter_span,
                });
            };
            let (name, name_span) = self.identifier()?;
            self.check_name(name, name_span)?;
            self.parameter_expansion_budget
                .charge_slice::<TemplateParameter<'_>>(1, name_span)?;
            let parameter = TemplateParameter {
                name,
                scalar,
                span: name_span,
            };
            self.bind_template_parameters(core::slice::from_ref(&parameter), None)?;
            parameters.push(parameter);
            if self.lexer.next_if(Token::Paren('>'))? {
                break;
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
        let header = self.function_header(false)?;
        if header.operator.is_some() {
            return self.fail("operator templates are unsupported");
        }
        self.check_name(header.name, header.name_span)?;
        self.check_dynamic_shared_linkage(header.name, header.name_span)?;
        let parameters_lexer = self.lexer.clone();
        self.parameter_expansion_budget
            .charge_bytes(header.name.len(), header.name_span)?;
        self.initialize_function_header(&header)?;
        self.parameters()?;
        Ok((
            FunctionTemplate {
                header,
                parameters,
                signature: core::mem::take(&mut self.function.parameters),
                result: self.function.ir.result.as_ref().map(|result| result.ty),
                definition: None,
            },
            parameters_lexer,
        ))
    }

    pub(super) fn has_kernel_template(&self, name: &str) -> bool {
        match self.global_declarations.get(name) {
            Some(&GlobalDeclaration::Functions(ref overloads)) => {
                overloads.templates.first().is_some_and(|&id| {
                    self.templates.declarations[id].header.kind == FunctionKind::Kernel
                })
            }
            _ => false,
        }
    }

    fn skip_template_body(&mut self) -> Result<(), ParseError> {
        let start = self.lexer.expect_span(Token::Paren('{'))?;
        let mut delimiters = Vec::new();
        self.parameter_expansion_budget
            .charge_slice::<char>(1, start)?;
        delimiters.push('}');
        while let Some(&expected) = delimiters.last() {
            let (token, span) = self.lexer.next()?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            match token {
                Token::Paren(open @ ('(' | '[' | '{')) => {
                    if delimiters.len() >= 64 {
                        return Err(ParseError {
                            message: String::from("CUDA template source nesting limit exceeded"),
                            span,
                        });
                    }
                    self.parameter_expansion_budget
                        .charge_slice::<char>(1, span)?;
                    delimiters.push(match open {
                        '(' => ')',
                        '[' => ']',
                        _ => '}',
                    });
                }
                Token::Paren(close @ (')' | ']' | '}')) => {
                    if close != expected {
                        return Err(ParseError {
                            message: String::from("mismatched template body delimiter"),
                            span,
                        });
                    }
                    delimiters.pop();
                }
                Token::End => {
                    return Err(ParseError {
                        message: String::from("unterminated function template body"),
                        span,
                    })
                }
                _ => {}
            }
        }
        Ok(())
    }

    pub(super) fn skip_template_array_bound(&mut self) -> Result<(), ParseError> {
        let mut delimiters = Vec::new();
        loop {
            let (token, span) = self.lexer.peek()?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            match token {
                Token::Paren(']') if delimiters.is_empty() => return Ok(()),
                Token::Paren(open @ ('(' | '[')) => {
                    if delimiters.len() >= 64 {
                        return self.fail("CUDA template source nesting limit exceeded");
                    }
                    self.parameter_expansion_budget
                        .charge_slice::<char>(1, span)?;
                    delimiters.push(if open == '(' { ')' } else { ']' });
                }
                Token::Paren(close @ (')' | ']')) => {
                    if delimiters.pop() != Some(close) {
                        return Err(ParseError {
                            message: String::from("mismatched template array bound delimiter"),
                            span,
                        });
                    }
                }
                Token::End | Token::Separator(';') | Token::Paren('{' | '}') => {
                    return self.fail("unsupported template array bound")
                }
                _ => {}
            }
            self.lexer.next()?;
        }
    }

    fn template_arguments(&mut self) -> Result<Vec<Literal>, ParseError> {
        self.lexer.expect_span(Token::Paren('<'))?;
        let mut arguments = Vec::new();
        if self.lexer.next_if(Token::Paren('>'))? {
            return Ok(arguments);
        }
        loop {
            let start = self.lexer.clone();
            let mut end = start.clone();
            let mut delimiters = Vec::new();
            let mut cast_angle = false;
            loop {
                let (token, span) = end.peek()?;
                self.parameter_expansion_budget.charge_work(1, span)?;
                if delimiters.is_empty()
                    && matches!(token, Token::Separator(',') | Token::Paren('>'))
                {
                    break;
                }
                if delimiters.is_empty() && token == Token::ShiftOperation('>') {
                    return Err(ParseError {
                        message: String::from(
                            "right shifts in template arguments require parentheses",
                        ),
                        span,
                    });
                }
                match token {
                    Token::Word("static_cast") => cast_angle = true,
                    Token::Paren('<') if cast_angle => {
                        self.parameter_expansion_budget
                            .charge_slice::<char>(1, span)?;
                        delimiters.push('>');
                        cast_angle = false;
                    }
                    Token::Paren(open @ ('(' | '[' | '{')) => {
                        if delimiters.len() >= 64 {
                            return Err(ParseError {
                                message: String::from(
                                    "CUDA template argument nesting limit exceeded",
                                ),
                                span,
                            });
                        }
                        self.parameter_expansion_budget
                            .charge_slice::<char>(1, span)?;
                        delimiters.push(match open {
                            '(' => ')',
                            '[' => ']',
                            _ => '}',
                        });
                    }
                    Token::Paren(close @ (')' | ']' | '}' | '>')) => {
                        if delimiters.last() == Some(&close) {
                            delimiters.pop();
                        } else if close != '>' {
                            return Err(ParseError {
                                message: String::from("mismatched template argument delimiter"),
                                span,
                            });
                        }
                    }
                    Token::End | Token::Separator(';') => {
                        return Err(ParseError {
                            message: String::from("unterminated template argument list"),
                            span,
                        })
                    }
                    _ => {}
                }
                end.next()?;
            }
            self.lexer = start.bounded(end.position());
            let parsed = self.capture_block(|parser| {
                let value = parser.conditional_expression()?;
                let value = parser.rvalue(value)?;
                let literal = Self::required_constant(&value)?;
                parser.lexer.expect_span(Token::End)?;
                Ok(literal)
            });
            self.lexer = end;
            let (literal, _) = parsed?;
            let span = self.lexer.peek()?.1;
            self.parameter_expansion_budget
                .charge_slice::<Literal>(1, span)?;
            arguments.push(literal);
            if self.lexer.next_if(Token::Paren('>'))? {
                return Ok(arguments);
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
    }

    fn normalized_template_arguments(
        &mut self,
        template: usize,
        arguments: &[Literal],
        span: Span,
    ) -> Result<Option<Vec<TemplateValue>>, ParseError> {
        let parameters = &self.templates.declarations[template].parameters;
        self.parameter_expansion_budget
            .charge_work(parameters.len(), span)?;
        if parameters.len() != arguments.len() {
            return Ok(None);
        }
        self.parameter_expansion_budget
            .charge_slice::<TemplateValue>(arguments.len(), span)?;
        let mut converted = Vec::with_capacity(arguments.len());
        for (parameter, &argument) in parameters.iter().zip(arguments) {
            let Some(value) = TemplateValue::converted(argument, parameter.scalar) else {
                return Ok(None);
            };
            converted.push(value);
        }
        Ok(Some(converted))
    }

    fn template_selector(
        &mut self,
        name: &str,
        arguments: &[TemplateValue],
        span: Span,
    ) -> Result<String, ParseError> {
        let bytes = arguments
            .len()
            .checked_mul(24)
            .and_then(|bytes| bytes.checked_add(name.len() + 2))
            .ok_or_else(|| ParseError {
                message: String::from("CUDA template specialization limit exceeded"),
                span,
            })?;
        self.parameter_expansion_budget.charge_bytes(bytes, span)?;
        self.parameter_expansion_budget
            .charge_work(arguments.len(), span)?;
        let mut name = String::from(name);
        name.push('<');
        for (index, &argument) in arguments.iter().enumerate() {
            if index != 0 {
                name.push(',');
            }
            name.push_str(&argument.spelling());
        }
        name.push('>');
        Ok(name)
    }

    fn template_instance(
        &mut self,
        template: usize,
        arguments: Vec<TemplateValue>,
        span: Span,
    ) -> Result<usize, ParseError> {
        let key = InstanceKey {
            template,
            arguments,
        };
        self.parameter_expansion_budget
            .charge_work(key.arguments.len() + 1, span)?;
        if let Some(&instance) = self.templates.keys.get(&key) {
            return Ok(instance);
        }
        let name = self.templates.declarations[template].header.name;
        let name = self.template_selector(name, &key.arguments, span)?;
        let declaration = &self.templates.declarations[template];
        self.parameter_expansion_budget
            .charge_slice::<Instance>(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<TemplateValue>(key.arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_map_entry::<InstanceKey, usize>(1, span)?;
        let target = if declaration.header.kind == FunctionKind::Device {
            self.parameter_expansion_budget
                .charge_slice::<Function>(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<SourceParameter>(declaration.signature.len(), span)?;
            self.parameter_expansion_budget
                .charge_slice::<FunctionArgument>(declaration.signature.len(), span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Function>, FunctionDeclaration>(1, span)?;
            let mut arguments = Vec::with_capacity(declaration.signature.len());
            for &parameter in &declaration.signature {
                if let SourceParameter::Shader { ty, mode } = parameter {
                    let ty = if matches!(mode, ParameterMode::Reference { .. }) {
                        self.module.types.insert(
                            Type {
                                name: None,
                                inner: TypeInner::Pointer {
                                    base: ty,
                                    space: AddressSpace::Function,
                                },
                            },
                            span,
                        )
                    } else {
                        ty
                    };
                    arguments.push(FunctionArgument {
                        name: None,
                        ty,
                        binding: None,
                    });
                }
            }
            let function = self.module.functions.append(
                Function {
                    name: Some(name),
                    arguments,
                    result: declaration
                        .result
                        .map(|ty| crate::FunctionResult { ty, binding: None }),
                    ..Function::default()
                },
                span,
            );
            self.function_declarations.insert(
                function,
                FunctionDeclaration {
                    parameters: declaration.signature.clone(),
                    has_host: declaration.header.has_host,
                    is_static: declaration.header.is_static,
                    inlining: declaration.header.inlining,
                    is_defined: false,
                    calls: Vec::new(),
                },
            );
            InstanceTarget::Device(function)
        } else {
            self.parameter_expansion_budget
                .charge_slice::<Kernel<'_>>(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<EntryPoint>(1, span)?;
            let index = self.kernels.len();
            self.module.entry_points.push(EntryPoint {
                name,
                stage: ShaderStage::Compute,
                early_depth_test: None,
                workgroup_size: self.workgroup_size,
                workgroup_size_overrides: None,
                function: Function::default(),
                mesh_info: None,
                task_payload: None,
                incoming_ray_payload: None,
            });
            self.kernels.push(Kernel {
                context: None,
                parameter_state: None,
                calls: Vec::new(),
            });
            InstanceTarget::Kernel(index)
        };
        let instance = self.templates.instances.len();
        self.templates.keys.insert(key.clone(), instance);
        self.templates.instances.push(Instance {
            key,
            target,
            queued: false,
            span,
        });
        Ok(instance)
    }

    fn queue_template_instance(&mut self, instance: usize) -> Result<(), ParseError> {
        let index = instance;
        let instance = &mut self.templates.instances[instance];
        if !instance.queued {
            self.parameter_expansion_budget
                .charge_slice::<usize>(1, instance.span)?;
            self.parameter_expansion_budget
                .charge_work(1, instance.span)?;
            instance.queued = true;
            self.templates.pending.push(index);
        }
        Ok(())
    }

    pub(super) fn template_call(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let template_arguments = self.template_arguments()?;
        self.lexer.expect_span(Token::Paren('('))?;
        let mut arguments = Vec::new();
        if self.lexer.peek()?.0 != Token::Paren(')') {
            loop {
                arguments.push(self.capture_call_argument()?);
                if self.lexer.peek()?.0 == Token::Paren(')') {
                    break;
                }
                self.lexer.expect_span(Token::Separator(','))?;
            }
        }
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        let ids = match &self.global_declarations[name] {
            &GlobalDeclaration::Functions(ref overloads) => {
                self.parameter_expansion_budget
                    .charge_slice::<usize>(overloads.templates.len(), span)?;
                self.parameter_expansion_budget
                    .charge_work(overloads.templates.len(), span)?;
                overloads.templates.clone()
            }
            _ => unreachable!(),
        };
        let mut candidates = Vec::new();
        for id in ids {
            if self.templates.declarations[id].header.kind != FunctionKind::Device {
                continue;
            }
            let Some(values) = self.normalized_template_arguments(id, &template_arguments, span)?
            else {
                continue;
            };
            let instance = self.template_instance(id, values, span)?;
            let InstanceTarget::Device(function) = self.templates.instances[instance].target else {
                unreachable!()
            };
            self.parameter_expansion_budget
                .charge_slice::<(FunctionCandidate, usize)>(1, span)?;
            self.parameter_expansion_budget
                .charge_work(arguments.len() + 1, span)?;
            candidates.push((FunctionCandidate::Defined(function), instance));
        }
        let candidate = match self.select_candidates(
            candidates.iter().map(|&(candidate, _)| candidate),
            &arguments,
        ) {
            OverloadResolution::Selected(candidate) => candidate,
            OverloadResolution::NoViable => {
                return Err(ParseError {
                    message: format!("no matching function template `{name}`"),
                    span,
                })
            }
            OverloadResolution::Ambiguous => {
                return Err(ParseError {
                    message: format!("ambiguous function template `{name}`"),
                    span,
                })
            }
        };
        let instance = candidates
            .iter()
            .find(|&&(function, _)| function == candidate)
            .unwrap()
            .1;
        self.queue_template_instance(instance)?;
        self.lower_captured_call(candidate, arguments, span.until(&end))
    }

    fn explicit_kernel_instantiation(&mut self, span: Span) -> Result<(), ParseError> {
        let header = self.function_header(false)?;
        if header.kind != FunctionKind::Kernel || !matches!(header.result, ReturnType::Void) {
            return self.fail("only explicit kernel instantiation declarations are supported");
        }
        if !self.has_function_template(header.name) {
            return Err(ParseError {
                message: String::from("unknown kernel template"),
                span: header.name_span,
            });
        }
        let arguments = self.template_arguments()?;
        let saved = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let parsed = (|| {
            self.prepare_parameter_bindings(span)?;
            self.parameters()?;
            Ok::<_, ParseError>(core::mem::take(&mut self.function.parameters))
        })();
        self.function = saved;
        let signature = parsed?;
        self.lexer.expect_span(Token::Separator(';'))?;
        let id = match &self.global_declarations[header.name] {
            &GlobalDeclaration::Functions(ref overloads) => {
                overloads.templates.iter().copied().find(|&id| {
                    let declaration = &self.templates.declarations[id];
                    declaration.header.kind == FunctionKind::Kernel
                        && declaration.signature == signature
                })
            }
            _ => None,
        }
        .ok_or_else(|| ParseError {
            message: String::from("incompatible explicit kernel instantiation signature"),
            span: header.name_span,
        })?;
        let values = self
            .normalized_template_arguments(id, &arguments, span)?
            .ok_or_else(|| ParseError {
                message: String::from("invalid kernel template arguments"),
                span: header.name_span,
            })?;
        let instance = self.template_instance(id, values, header.name_span)?;
        if self.templates.instances[instance].queued {
            return Err(ParseError {
                message: String::from("duplicate explicit kernel instantiation"),
                span: header.name_span,
            });
        }
        self.queue_template_instance(instance)
    }

    pub(super) fn finish_templates(&mut self) -> Result<(), ParseError> {
        let mut cursor = 0;
        while let Some(&instance) = self.templates.pending.get(cursor) {
            self.materialize_template_instance(instance)?;
            cursor += 1;
        }
        Ok(())
    }

    fn materialize_template_instance(&mut self, instance: usize) -> Result<(), ParseError> {
        let instance = &self.templates.instances[instance];
        let span = instance.span;
        let declaration = &self.templates.declarations[instance.key.template];
        let definition = declaration.definition.as_ref().ok_or_else(|| ParseError {
            message: format!(
                "function template `{}` has no definition",
                declaration.header.name
            ),
            span,
        })?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<TemplateValue>(instance.key.arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_slice::<TemplateParameter<'_>>(declaration.parameters.len(), span)?;
        Self::charge_template_environment(
            &definition.globals,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        let arguments = instance.key.arguments.clone();
        let target = instance.target;
        let header = declaration.header.clone();
        let parameters = declaration.parameters.clone();
        let lexer = definition.parameters.bounded(definition.end);
        let globals = definition.globals.clone();
        let previous_globals = core::mem::replace(&mut self.global_declarations, globals);
        let previous_lexer = core::mem::replace(&mut self.lexer, lexer);
        let previous_function =
            core::mem::replace(&mut self.function, FunctionContext::new(header.kind));
        let result = (|| {
            self.parameter_expansion_budget
                .charge_bytes(header.name.len(), span)?;
            self.prepare_parameter_bindings(span)?;
            self.bind_template_parameters(&parameters, Some(&arguments))?;
            match target {
                InstanceTarget::Device(function) => {
                    self.device_function_with_target(header, Some(function))?
                }
                InstanceTarget::Kernel(index) => {
                    self.kernel_body(&header)?;
                    let function = core::mem::replace(
                        &mut self.function,
                        FunctionContext::new(FunctionKind::Kernel),
                    );
                    self.kernels[index].context = Some(function);
                }
            }
            self.lexer.expect_span(Token::End)?;
            Ok(())
        })();
        self.function = previous_function;
        self.lexer = previous_lexer;
        self.global_declarations = previous_globals;
        result
    }
}
