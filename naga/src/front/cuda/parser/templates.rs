mod deduction;

use super::super::lexer::LexerPosition;
use super::functions::{
    ArgumentConversion, FunctionCandidate, FunctionHeader, OverloadResolution, ReturnType,
};
use super::*;

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
enum TemplateValue {
    Short(i16),
    UnsignedShort(u16),
    Int(i32),
    Uint(u32),
    Bool(bool),
    Type {
        ty: TypeSpecifier,
        qualifiers: Qualifiers,
    },
    ArrayType {
        ty: Handle<Type>,
        qualifiers: Qualifiers,
    },
}

impl TemplateValue {
    const fn literal(self) -> Literal {
        match self {
            Self::Short(value) => Literal::I16(value),
            Self::UnsignedShort(value) => Literal::U16(value),
            Self::Int(value) => Literal::I32(value),
            Self::Uint(value) => Literal::U32(value),
            Self::Bool(value) => Literal::Bool(value),
            Self::Type { .. } | Self::ArrayType { .. } => unreachable!(),
        }
    }

    fn converted(value: Literal, scalar: Scalar) -> Option<Self> {
        let value = match value {
            Literal::I16(value) => i64::from(value),
            Literal::U16(value) => i64::from(value),
            Literal::I32(value) => i64::from(value),
            Literal::U32(value) => i64::from(value),
            Literal::Bool(value) => i64::from(value),
            _ => return None,
        };
        match scalar {
            Scalar::I16 => i16::try_from(value).ok().map(Self::Short),
            Scalar::U16 => u16::try_from(value).ok().map(Self::UnsignedShort),
            Scalar::I32 => i32::try_from(value).ok().map(Self::Int),
            Scalar::U32 => u32::try_from(value).ok().map(Self::Uint),
            Scalar::BOOL if value == 0 || value == 1 => Some(Self::Bool(value != 0)),
            _ => None,
        }
    }

    fn spelling(self) -> String {
        match self {
            Self::Short(value) => format!("{value}"),
            Self::UnsignedShort(value) => format!("{value}u"),
            Self::Int(value) => format!("{value}"),
            Self::Uint(value) => format!("{value}u"),
            Self::Bool(value) => String::from(if value { "true" } else { "false" }),
            Self::Type { .. } | Self::ArrayType { .. } => unreachable!(),
        }
    }
}

#[derive(Clone)]
enum TemplateArgument {
    Type(QualifiedType),
    Value(Literal),
}

#[derive(Clone, Copy, Eq, PartialEq)]
enum TemplateParameterKind {
    Type,
    Value(Scalar),
}

#[derive(Clone)]
struct TemplateParameter<'a> {
    name: &'a str,
    index: u32,
    kind: TemplateParameterKind,
    span: Span,
}

#[derive(Clone)]
struct SignatureSource<'a> {
    start: Lexer<'a>,
    end: LexerPosition,
}

struct ResolvedSignature {
    parameters: Vec<SourceParameter>,
    result: Option<Handle<Type>>,
    source_result: ReturnType,
    result_qualifiers: Qualifiers,
}

#[derive(Clone, Copy, Eq, PartialEq)]
enum PatternType {
    Concrete(Handle<Type>),
    NullPointer,
    Parameter(u32),
}

#[derive(Clone, Copy, Eq, PartialEq)]
enum ParameterPattern {
    Shader {
        ty: PatternType,
        mode: ParameterMode,
    },
    NullPointer {
        mode: ParameterMode,
    },
    ThreadBlock,
}

struct FunctionTemplate<'a> {
    header: FunctionHeader<'a>,
    parameters: Vec<TemplateParameter<'a>>,
    signature: Vec<ParameterPattern>,
    result: ReturnType,
    source: SignatureSource<'a>,
    globals: FastHashMap<&'a str, GlobalDeclaration>,
    definition: Option<LexerPosition>,
    launch_bounds: Option<TemplateLaunchBounds<'a>>,
}

struct TemplateLaunchBounds<'a> {
    source: SignatureSource<'a>,
    parameters: Vec<TemplateParameter<'a>>,
    globals: FastHashMap<&'a str, GlobalDeclaration>,
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

enum CandidateOrigin {
    Ordinary(FunctionCandidate),
    Template {
        template: usize,
        arguments: Vec<TemplateValue>,
    },
}

struct CallCandidate {
    origin: CandidateOrigin,
    conversions: Vec<ArgumentConversion>,
}

#[derive(Clone, Copy, Eq, PartialEq)]
enum PatternTerm {
    Type {
        ty: PatternType,
        qualifiers: Qualifiers,
    },
    Pointer {
        pointee: PatternType,
        qualifiers: Qualifiers,
    },
    ThreadBlock,
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
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
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
            let symbol = match parameter.kind {
                TemplateParameterKind::Value(scalar) => Symbol::TemplateParameter {
                    scalar,
                    literal: arguments.map(|arguments| arguments[index].literal()),
                },
                TemplateParameterKind::Type => {
                    let ty = match arguments.map(|arguments| arguments[index]) {
                        Some(TemplateValue::Type { ty, qualifiers }) => {
                            QualifiedType { ty, qualifiers }
                        }
                        Some(TemplateValue::ArrayType { .. }) => return Err(ParseError {
                            message: String::from("template array types and array reference parameters are unsupported"),
                            span: parameter.span,
                        }),
                        None => QualifiedType {
                            ty: TypeSpecifier::TemplateParameter(parameter.index),
                            qualifiers: Qualifiers::NONE,
                        },
                        _ => unreachable!(),
                    };
                    Symbol::TemplateTypeParameter { ty }
                }
            };
            self.insert_symbol(parameter.name, symbol, parameter.span)?;
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
        let declaration = signature_result?;
        let FunctionTemplate {
            mut header,
            parameters,
            signature,
            result,
            source,
            ..
        } = declaration;
        let bounds_source = header.launch_bounds.map(|_| source.clone());
        let mut source = Some(source);
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
                            .all(|(left, right)| left.kind == right.kind)
                        && previous.signature == signature
                        && previous.result == result
                        && previous.header.result_qualifiers == header.result_qualifiers
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
                source: source.take().unwrap(),
                globals: FastHashMap::default(),
                definition: None,
                launch_bounds: None,
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
        if self.templates.declarations[id].definition.is_none() {
            if let Some(source) = bounds_source {
                self.parameter_expansion_budget
                    .charge_slice::<TemplateLaunchBounds<'_>>(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<TemplateParameter<'_>>(parameters.len(), span)?;
                let globals = self.clone_template_environment(span)?;
                self.templates.declarations[id].launch_bounds = Some(TemplateLaunchBounds {
                    source,
                    parameters: parameters.clone(),
                    globals,
                });
            }
        }
        if previous.is_none() || is_definition {
            let globals = self.clone_template_environment(span)?;
            let declaration = &mut self.templates.declarations[id];
            declaration.parameters = parameters;
            declaration.globals = globals;
            if let Some(source) = source {
                declaration.source = source;
            }
        }
        if is_definition {
            let declaration = &mut self.templates.declarations[id];
            declaration.header = header;
            declaration.definition = Some(end);
        }
        Ok(())
    }

    fn template_signature(&mut self, span: Span) -> Result<FunctionTemplate<'a>, ParseError> {
        self.prepare_parameter_bindings(span)?;
        if self.lexer.peek()?.0 == Token::Paren('>') {
            return self.fail("explicit template specializations are unsupported");
        }
        let mut parameters = Vec::new();
        loop {
            let parameter_span = self.lexer.peek()?.1;
            let kind = if self.lexer.next_if(Token::Word("typename"))?
                || self.lexer.next_if(Token::Word("class"))?
            {
                TemplateParameterKind::Type
            } else {
                let ty = self.parse_type()?;
                let TypeSpecifier::Scalar(
                    scalar @ (Scalar::I16 | Scalar::U16 | Scalar::I32 | Scalar::U32 | Scalar::BOOL),
                ) = ty.ty
                else {
                    return Err(ParseError {
                        message: String::from(
                            "non-type template parameters must be short, unsigned short, int, unsigned, or bool",
                        ),
                        span: parameter_span,
                    });
                };
                TemplateParameterKind::Value(scalar)
            };
            let (name, name_span) = self.identifier()?;
            self.check_name(name, name_span)?;
            self.parameter_expansion_budget
                .charge_slice::<TemplateParameter<'_>>(1, name_span)?;
            let parameter = TemplateParameter {
                name,
                index: u32::try_from(parameters.len()).map_err(|_| ParseError {
                    message: String::from("CUDA template parameter limit exceeded"),
                    span: name_span,
                })?,
                kind,
                span: name_span,
            };
            self.bind_template_parameters(core::slice::from_ref(&parameter), None)?;
            parameters.push(parameter);
            if self.lexer.next_if(Token::Paren('>'))? {
                break;
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
        let source = self.lexer.clone();
        let mut header = self.function_header(false)?;
        if header.operator.is_some() {
            return self.fail("operator templates are unsupported");
        }
        self.check_name(header.name, header.name_span)?;
        self.check_dynamic_shared_linkage(header.name, header.name_span)?;
        self.function.symbol_table.push_scope();
        let signature = self.template_parameter_patterns()?;
        self.trailing_launch_bounds(&mut header.launch_bounds)?;
        let end = self.lexer.position();
        Ok(FunctionTemplate {
            result: header.result,
            header,
            parameters,
            signature,
            source: SignatureSource { start: source, end },
            globals: FastHashMap::default(),
            definition: None,
            launch_bounds: None,
        })
    }

    fn template_parameter_patterns(&mut self) -> Result<Vec<ParameterPattern>, ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        let mut parameters = Vec::new();
        if self.lexer.next_if(Token::Paren(')'))? {
            return Ok(parameters);
        }
        if self.take_ident("void")? {
            self.lexer.expect_span(Token::Paren(')'))?;
            return Ok(parameters);
        }
        loop {
            let declaration = self.parameter_type()?;
            if !matches!(
                self.lexer.peek()?.0,
                Token::Separator(',') | Token::Paren(')') | Token::Paren('[')
            ) {
                let (name, span) = self.identifier()?;
                self.check_name(name, span)?;
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, Symbol>(1, span)?;
                self.insert_symbol(name, Symbol::PendingAuto, span)?;
            }
            let is_array = self.lexer.next_if(Token::Paren('['))?;
            if is_array {
                self.skip_template_array_bound()?;
                self.lexer.expect_span(Token::Paren(']'))?;
                if self.lexer.peek()?.0 == Token::Paren('[') {
                    return self.fail("multidimensional array parameters are unsupported");
                }
            }
            let pattern = self.parameter_pattern(declaration, is_array)?;
            self.parameter_expansion_budget
                .charge_slice::<ParameterPattern>(1, self.lexer.peek()?.1)?;
            parameters.push(pattern);
            if self.lexer.next_if(Token::Paren(')'))? {
                return Ok(parameters);
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
    }

    fn parameter_pattern(
        &mut self,
        declaration: signatures::ParameterType,
        is_array: bool,
    ) -> Result<ParameterPattern, ParseError> {
        let signatures::ParameterType {
            ty,
            pointer_qualifiers,
            is_reference,
            type_span,
            declarator_span,
        } = declaration;
        let pointer = pointer_qualifiers.is_some() || is_array;
        if is_array && (pointer_qualifiers.is_some() || is_reference) {
            return Err(ParseError {
                message: String::from("array pointer and reference parameters are unsupported"),
                span: declarator_span,
            });
        }
        if pointer_qualifiers.is_some() && is_reference {
            return Err(ParseError {
                message: String::from("pointer reference parameters are unsupported"),
                span: declarator_span,
            });
        }
        let (base, qualifiers, is_pointer) = match ty.ty {
            TypeSpecifier::NullPointer => {
                if pointer || ty.qualifiers.is_volatile {
                    return Err(ParseError {
                        message: String::from(
                            "pointers, arrays and volatile nullptr_t parameters are unsupported",
                        ),
                        span: type_span,
                    });
                }
                let mode = if is_reference {
                    ParameterMode::Reference {
                        qualifiers: ty.qualifiers,
                    }
                } else {
                    ParameterMode::Value
                };
                return Ok(ParameterPattern::NullPointer { mode });
            }
            TypeSpecifier::ThreadBlock => {
                if pointer || is_reference || ty.qualifiers.is_volatile {
                    return Err(ParseError {
                        message: String::from("thread_block parameters must be passed by value"),
                        span: type_span,
                    });
                }
                return Ok(ParameterPattern::ThreadBlock);
            }
            TypeSpecifier::TemplateParameter(index) => {
                (PatternType::Parameter(index), ty.qualifiers, pointer)
            }
            TypeSpecifier::Pointer {
                pointee,
                pointee_qualifiers,
            } => {
                if pointer || is_reference {
                    return Err(ParseError {
                        message: String::from(
                            "nested pointer and pointer reference parameters are unsupported",
                        ),
                        span: declarator_span,
                    });
                }
                (PatternType::Concrete(pointee), pointee_qualifiers, true)
            }
            specifier => {
                let resolution = self.lower_type(specifier, type_span)?;
                (
                    PatternType::Concrete(self.type_handle(&resolution, type_span)),
                    ty.qualifiers,
                    pointer,
                )
            }
        };
        let mode = if is_pointer {
            ParameterMode::Pointer { qualifiers }
        } else if is_reference {
            ParameterMode::Reference { qualifiers }
        } else {
            ParameterMode::Value
        };
        Ok(ParameterPattern::Shader { ty: base, mode })
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

    fn template_arguments(&mut self) -> Result<Vec<TemplateArgument>, ParseError> {
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
                if let Some(ty) = parser.template_type_argument()? {
                    return Ok(TemplateArgument::Type(ty));
                }
                let value = parser.conditional_expression()?;
                let value = parser.rvalue(value)?;
                let literal = Self::required_constant(&value)?;
                parser.lexer.expect_span(Token::End)?;
                Ok(TemplateArgument::Value(literal))
            });
            self.lexer = end;
            let (literal, _) = parsed?;
            let span = self.lexer.peek()?.1;
            self.parameter_expansion_budget
                .charge_slice::<TemplateArgument>(1, span)?;
            arguments.push(literal);
            if self.lexer.next_if(Token::Paren('>'))? {
                return Ok(arguments);
            }
            self.lexer.expect_span(Token::Separator(','))?;
        }
    }

    fn template_type_argument(&mut self) -> Result<Option<QualifiedType>, ParseError> {
        let mut lookahead = self.lexer.clone();
        let Ok(_) = self.parse_type_from(&mut lookahead) else {
            return Ok(None);
        };
        let is_pointer = lookahead.next_if(Token::Operation('*'))?;
        if is_pointer {
            types::pointer_qualifiers(&mut lookahead)?;
        }
        if lookahead.peek()?.0 != Token::End {
            return Ok(None);
        }
        let ty = self.parse_type()?;
        let ty = self.alias_declarator(ty)?;
        self.lexer.expect_span(Token::End)?;
        Ok(Some(ty))
    }

    fn normalized_template_arguments(
        &mut self,
        template: usize,
        arguments: &[TemplateArgument],
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
        for (parameter, argument) in parameters.iter().zip(arguments) {
            let value = match (parameter.kind, argument) {
                (TemplateParameterKind::Type, &TemplateArgument::Type(ref ty)) => {
                    TemplateValue::Type {
                        ty: ty.ty,
                        qualifiers: ty.qualifiers,
                    }
                }
                (TemplateParameterKind::Value(scalar), &TemplateArgument::Value(literal)) => {
                    let Some(value) = TemplateValue::converted(literal, scalar) else {
                        return Ok(None);
                    };
                    value
                }
                _ => return Ok(None),
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
            match argument {
                TemplateValue::Type { ty, qualifiers } => {
                    name.push_str(&self.template_type_spelling(ty, qualifiers, span)?);
                }
                value => name.push_str(&value.spelling()),
            }
        }
        name.push('>');
        Ok(name)
    }

    fn template_type_spelling(
        &mut self,
        ty: TypeSpecifier,
        qualifiers: Qualifiers,
        span: Span,
    ) -> Result<String, ParseError> {
        self.parameter_expansion_budget.charge_bytes(32, span)?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        let mut name = match ty {
            TypeSpecifier::Scalar(Scalar::I16) => String::from("short"),
            TypeSpecifier::Scalar(Scalar::U16) => String::from("unsigned short"),
            TypeSpecifier::Scalar(Scalar::I32) => String::from("int"),
            TypeSpecifier::Scalar(Scalar::U32) => String::from("unsigned"),
            TypeSpecifier::Scalar(Scalar::F32) => String::from("float"),
            TypeSpecifier::Scalar(Scalar::BOOL) => String::from("bool"),
            TypeSpecifier::Dim3 => String::from("dim3"),
            TypeSpecifier::NullPointer => String::from("decltype(nullptr)"),
            TypeSpecifier::ThreadBlock => String::from("cooperative_groups::thread_block"),
            TypeSpecifier::Vector {
                component_count,
                scalar,
            } => {
                let name = types::VECTOR_TYPES
                    .iter()
                    .find(|entry| entry.2 == component_count && entry.3 == scalar)
                    .unwrap()
                    .0;
                String::from(name)
            }
            TypeSpecifier::Structure(handle) => {
                let name = self
                    .structures
                    .get(&handle)
                    .and_then(|structure| structure.source_name.as_ref())
                    .ok_or_else(|| ParseError {
                        message: String::from("type has no CUDA source name"),
                        span,
                    })?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len(), span)?;
                String::from(name)
            }
            TypeSpecifier::Pointer {
                pointee,
                pointee_qualifiers,
            } => {
                let pointee = self.template_type_from_handle(pointee, span)?;
                let mut name = self.template_type_spelling(pointee, pointee_qualifiers, span)?;
                self.parameter_expansion_budget
                    .charge_bytes(name.len() + 16, span)?;
                name.push('*');
                if qualifiers.is_const {
                    name.push_str(" const");
                }
                if qualifiers.is_volatile {
                    name.push_str(" volatile");
                }
                return Ok(name);
            }
            _ => {
                return Err(ParseError {
                    message: String::from("unsupported template type argument"),
                    span,
                })
            }
        };
        self.parameter_expansion_budget
            .charge_bytes(name.len() + 16, span)?;
        if qualifiers.is_volatile {
            name.insert_str(0, "volatile ");
        }
        if qualifiers.is_const {
            name.insert_str(0, "const ");
        }
        Ok(name)
    }

    fn template_type_from_handle(
        &self,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<TypeSpecifier, ParseError> {
        if Some(ty) == self.dim3_type {
            return Ok(TypeSpecifier::Dim3);
        }
        match self.module.types[ty].inner {
            TypeInner::Scalar(scalar) => Ok(TypeSpecifier::Scalar(scalar)),
            TypeInner::Vector { size, scalar } => Ok(TypeSpecifier::Vector {
                component_count: u8::from(size),
                scalar,
            }),
            TypeInner::Struct { .. } => {
                if self.structures.contains_key(&ty) {
                    return Ok(TypeSpecifier::Structure(ty));
                }
                let name = self.module.types[ty].name.as_deref();
                if let Some(&(_, _, component_count, scalar)) = types::VECTOR_TYPES
                    .iter()
                    .find(|entry| Some(entry.0) == name)
                {
                    return Ok(TypeSpecifier::Vector {
                        component_count,
                        scalar,
                    });
                }
                Err(ParseError {
                    message: String::from("unsupported template source type"),
                    span,
                })
            }
            _ => Err(ParseError {
                message: String::from("unsupported template source type"),
                span,
            }),
        }
    }

    fn resolved_template_signature(
        &mut self,
        template: usize,
        arguments: &[TemplateValue],
        span: Span,
    ) -> Result<ResolvedSignature, ParseError> {
        let declaration = &self.templates.declarations[template];
        self.parameter_expansion_budget
            .charge_slice::<TemplateParameter<'_>>(declaration.parameters.len(), span)?;
        Self::charge_template_environment(
            &declaration.globals,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        let lexer = declaration.source.start.bounded(declaration.source.end);
        let parameters = declaration.parameters.clone();
        let globals = declaration.globals.clone();
        let previous_globals = core::mem::replace(&mut self.global_declarations, globals);
        let previous_lexer = core::mem::replace(&mut self.lexer, lexer);
        let previous_function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let previous_signature = core::mem::replace(&mut self.templates.parsing_signature, true);
        let parsed = (|| {
            self.prepare_parameter_bindings(span)?;
            self.bind_template_parameters(&parameters, Some(arguments))?;
            let mut header = self.function_header(false)?;
            self.parameter_expansion_budget
                .charge_bytes(header.name.len(), span)?;
            self.initialize_function_header(&header)?;
            self.parameters_with_launch_bounds(&mut header.launch_bounds)?;
            self.lexer.expect_span(Token::End)?;
            let result = self.function.ir.result.as_ref().map(|result| result.ty);
            Ok(ResolvedSignature {
                parameters: core::mem::take(&mut self.function.parameters),
                result,
                source_result: self.function.source_result,
                result_qualifiers: header.result_qualifiers,
            })
        })();
        self.templates.parsing_signature = previous_signature;
        self.function = previous_function;
        self.lexer = previous_lexer;
        self.global_declarations = previous_globals;
        parsed
    }

    fn template_instance(
        &mut self,
        template: usize,
        arguments: Vec<TemplateValue>,
        span: Span,
    ) -> Result<usize, ParseError> {
        if arguments
            .iter()
            .any(|argument| matches!(argument, &TemplateValue::ArrayType { .. }))
        {
            return Err(ParseError {
                message: String::from(
                    "template array types and array reference parameters are unsupported",
                ),
                span,
            });
        }
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
        let ResolvedSignature {
            parameters: signature,
            result,
            source_result,
            result_qualifiers,
        } = self.resolved_template_signature(template, &key.arguments, span)?;
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
                .charge_slice::<SourceParameter>(signature.len(), span)?;
            self.parameter_expansion_budget
                .charge_slice::<FunctionArgument>(signature.len(), span)?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Function>, FunctionDeclaration>(1, span)?;
            let mut arguments = Vec::with_capacity(signature.len());
            for &parameter in &signature {
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
                    result: result.map(|ty| crate::FunctionResult { ty, binding: None }),
                    ..Function::default()
                },
                span,
            );
            self.function_declarations.insert(
                function,
                FunctionDeclaration {
                    parameters: signature,
                    source_result,
                    result_qualifiers,
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

    fn template_candidate_conversions(
        &mut self,
        template: usize,
        values: &[TemplateValue],
        arguments: &[CapturedArgument],
        span: Span,
    ) -> Result<Option<Vec<ArgumentConversion>>, ParseError> {
        let parameter_count = self.templates.declarations[template].signature.len();
        self.parameter_expansion_budget
            .charge_work(parameter_count, span)?;
        if parameter_count != arguments.len() {
            return Ok(None);
        }
        self.parameter_expansion_budget
            .charge_slice::<ArgumentConversion>(parameter_count, span)?;
        let mut conversions = Vec::with_capacity(parameter_count);
        for (index, argument) in arguments.iter().enumerate() {
            let pattern = self.templates.declarations[template].signature[index];
            let Some(conversion) =
                self.template_argument_conversion(pattern, values, argument, span)?
            else {
                return Ok(None);
            };
            conversions.push(conversion);
        }
        Ok(Some(conversions))
    }

    fn template_argument_conversion(
        &mut self,
        pattern: ParameterPattern,
        values: &[TemplateValue],
        argument: &CapturedArgument,
        span: Span,
    ) -> Result<Option<ArgumentConversion>, ParseError> {
        if let ParameterPattern::NullPointer { mode } = pattern {
            return Ok(self
                .null_pointer_argument_conversion(mode, argument)
                .map(|rank| ArgumentConversion { rank, mode }));
        }
        let ParameterPattern::Shader { ty, mode } = pattern else {
            return Ok(argument.is_thread_block().then_some(ArgumentConversion {
                rank: 0,
                mode: ParameterMode::Value,
            }));
        };
        let (target, mode) = match ty {
            PatternType::NullPointer => {
                return Ok(self
                    .null_pointer_argument_conversion(mode, argument)
                    .map(|rank| ArgumentConversion { rank, mode }))
            }
            PatternType::Concrete(ty) => (TypeResolution::Handle(ty), mode),
            PatternType::Parameter(parameter) => {
                if let TemplateValue::ArrayType { ty, qualifiers } = values[parameter as usize] {
                    let mode = match mode {
                        ParameterMode::Reference { qualifiers: formal } => {
                            ParameterMode::Reference {
                                qualifiers: formal.union(qualifiers),
                            }
                        }
                        ParameterMode::Pointer { qualifiers: formal } => ParameterMode::Pointer {
                            qualifiers: formal.union(qualifiers),
                        },
                        ParameterMode::Value => ParameterMode::Value,
                    };
                    if argument.is_thread_block() {
                        return Ok(None);
                    }
                    let rank = match mode {
                        ParameterMode::Pointer { qualifiers } => self.pointer_argument_conversion(
                            &TypeResolution::Handle(ty),
                            qualifiers,
                            argument,
                        ),
                        ParameterMode::Reference { .. } => self.value_argument_conversion(
                            &TypeResolution::Handle(ty),
                            mode,
                            argument,
                        ),
                        ParameterMode::Value => {
                            let TypeInner::Array { base, .. } = self.module.types[ty].inner else {
                                unreachable!()
                            };
                            self.pointer_argument_conversion(
                                &TypeResolution::Handle(base),
                                qualifiers,
                                argument,
                            )
                        }
                    };
                    return Ok(rank.map(|rank| ArgumentConversion { rank, mode }));
                }
                let TemplateValue::Type { ty, qualifiers } = values[parameter as usize] else {
                    unreachable!()
                };
                let mode = match mode {
                    ParameterMode::Reference { qualifiers: formal } => ParameterMode::Reference {
                        qualifiers: formal.union(qualifiers),
                    },
                    ParameterMode::Pointer { qualifiers: formal } => ParameterMode::Pointer {
                        qualifiers: formal.union(qualifiers),
                    },
                    ParameterMode::Value => ParameterMode::Value,
                };
                if ty == TypeSpecifier::ThreadBlock {
                    return Ok((argument.is_thread_block()
                        && !matches!(mode, ParameterMode::Pointer { .. }))
                    .then_some(ArgumentConversion { rank: 0, mode }));
                }
                if ty == TypeSpecifier::NullPointer {
                    return Ok(self
                        .null_pointer_argument_conversion(mode, argument)
                        .map(|rank| ArgumentConversion { rank, mode }));
                }
                if let (
                    ParameterMode::Reference { qualifiers },
                    TypeSpecifier::Pointer {
                        pointee,
                        pointee_qualifiers,
                    },
                ) = (mode, ty)
                {
                    return Ok(self
                        .pointer_reference_conversion(
                            pointee,
                            pointee_qualifiers,
                            qualifiers,
                            argument,
                        )
                        .map(|rank| ArgumentConversion { rank, mode }));
                }
                if let (
                    ParameterMode::Value,
                    TypeSpecifier::Pointer {
                        pointee,
                        pointee_qualifiers,
                    },
                ) = (mode, ty)
                {
                    (
                        TypeResolution::Handle(pointee),
                        ParameterMode::Pointer {
                            qualifiers: pointee_qualifiers,
                        },
                    )
                } else {
                    (self.lower_type(ty, span)?, mode)
                }
            }
        };
        if argument.is_thread_block() {
            return Ok(None);
        }
        let rank = match mode {
            ParameterMode::Pointer { qualifiers } => {
                self.pointer_argument_conversion(&target, qualifiers, argument)
            }
            _ => self.value_argument_conversion(&target, mode, argument),
        };
        Ok(rank.map(|rank| ArgumentConversion { rank, mode }))
    }

    pub(super) fn template_call(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let arguments = self.template_arguments()?;
        self.template_call_inner(name, span, Some(arguments))
    }

    pub(super) fn deduced_template_call(
        &mut self,
        name: &str,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.template_call_inner(name, span, None)
    }

    fn template_call_inner(
        &mut self,
        name: &str,
        span: Span,
        explicit: Option<Vec<TemplateArgument>>,
    ) -> Result<ExpressionResult, ParseError> {
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
        self.lower_template_call(name, span, end, explicit, arguments)
    }

    fn lower_template_call(
        &mut self,
        name: &str,
        span: Span,
        end: Span,
        explicit: Option<Vec<TemplateArgument>>,
        arguments: Vec<CapturedArgument>,
    ) -> Result<ExpressionResult, ParseError> {
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
        if explicit.is_none() {
            let ordinary_count = self.function_candidates(name).count() + 1;
            self.parameter_expansion_budget
                .charge_slice::<FunctionCandidate>(ordinary_count, span)?;
            let ordinary: Vec<_> = self
                .function_candidates(name)
                .chain(self.integral_double_candidate(name, &arguments))
                .collect();
            for candidate in ordinary {
                self.parameter_expansion_budget
                    .charge_work(arguments.len() + 1, span)?;
                if self.candidate_arity(candidate) != arguments.len() {
                    continue;
                }
                self.parameter_expansion_budget
                    .charge_slice::<ArgumentConversion>(arguments.len(), span)?;
                let conversions: Option<Vec<_>> = arguments
                    .iter()
                    .enumerate()
                    .map(|(index, argument)| {
                        self.candidate_conversion(candidate, index, argument)
                            .map(|rank| ArgumentConversion {
                                rank,
                                mode: self.candidate_mode(candidate, index),
                            })
                    })
                    .collect();
                if let Some(conversions) = conversions {
                    self.parameter_expansion_budget
                        .charge_slice::<CallCandidate>(1, span)?;
                    candidates.push(CallCandidate {
                        origin: CandidateOrigin::Ordinary(candidate),
                        conversions,
                    });
                }
            }
        }
        let mut maximum_parameters = 0;
        for id in ids {
            if self.templates.declarations[id].header.kind != FunctionKind::Device {
                continue;
            }
            let Some(values) = self.template_call_arguments(
                id,
                explicit.as_deref().unwrap_or(&[]),
                &arguments,
                span,
            )?
            else {
                continue;
            };
            let Some(conversions) =
                self.template_candidate_conversions(id, &values, &arguments, span)?
            else {
                continue;
            };
            maximum_parameters =
                maximum_parameters.max(self.templates.declarations[id].parameters.len());
            self.parameter_expansion_budget
                .charge_slice::<CallCandidate>(1, span)?;
            self.parameter_expansion_budget
                .charge_work(arguments.len() * 3 + 1, span)?;
            candidates.push(CallCandidate {
                origin: CandidateOrigin::Template {
                    template: id,
                    arguments: values,
                },
                conversions,
            });
        }
        self.parameter_expansion_budget
            .charge_slice::<Option<PatternTerm>>(maximum_parameters * 2, span)?;
        let comparison_work = candidates
            .len()
            .saturating_sub(1)
            .checked_mul(4)
            .and_then(|count| count.checked_mul(maximum_parameters + arguments.len()))
            .ok_or_else(|| ParseError {
                message: String::from("CUDA template ordering limit exceeded"),
                span,
            })?;
        self.parameter_expansion_budget
            .charge_work(comparison_work, span)?;
        let mut left_bindings = alloc::vec![None; maximum_parameters];
        let mut right_bindings = alloc::vec![None; maximum_parameters];
        let selected =
            match functions::select_ranked_candidate(0..candidates.len(), |left, right| {
                self.source_candidate_better(
                    &candidates[left],
                    &candidates[right],
                    &mut left_bindings,
                    &mut right_bindings,
                )
            }) {
                OverloadResolution::Selected(index) => index,
                OverloadResolution::NoViable => {
                    return Err(ParseError {
                        message: format!(
                            "no matching function template or ordinary overload `{name}`"
                        ),
                        span,
                    })
                }
                OverloadResolution::Ambiguous => {
                    return Err(ParseError {
                        message: format!(
                            "ambiguous function template or ordinary overload `{name}`"
                        ),
                        span,
                    })
                }
            };
        let selected = candidates.into_iter().nth(selected).unwrap();
        let candidate = match selected.origin {
            CandidateOrigin::Ordinary(FunctionCandidate::Current) => {
                return Err(ParseError {
                    message: String::from("recursive device helper calls are unsupported"),
                    span,
                })
            }
            CandidateOrigin::Ordinary(FunctionCandidate::IntegralDouble { .. }) => {
                return Err(ParseError {
                    message: format!("integral {name} requires unsupported double precision"),
                    span,
                })
            }
            CandidateOrigin::Ordinary(candidate) => candidate,
            CandidateOrigin::Template {
                template,
                arguments,
            } => {
                let instance = self.template_instance(template, arguments, span)?;
                let InstanceTarget::Device(function) = self.templates.instances[instance].target
                else {
                    unreachable!()
                };
                self.queue_template_instance(instance)?;
                FunctionCandidate::Defined(function)
            }
        };
        self.lower_captured_call(candidate, arguments, span.until(&end))
    }

    fn explicit_kernel_instantiation(&mut self, span: Span) -> Result<(), ParseError> {
        let mut header = self.function_header(false)?;
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
            self.parameters_with_launch_bounds(&mut header.launch_bounds)?;
            Ok::<_, ParseError>(core::mem::take(&mut self.function.parameters))
        })();
        self.function = saved;
        let signature = parsed?;
        self.lexer.expect_span(Token::Separator(';'))?;
        let ids = match &self.global_declarations[header.name] {
            &GlobalDeclaration::Functions(ref overloads) => {
                self.parameter_expansion_budget
                    .charge_slice::<usize>(overloads.templates.len(), span)?;
                overloads.templates.clone()
            }
            _ => unreachable!(),
        };
        let mut selected = None;
        for id in ids {
            if self.templates.declarations[id].header.kind != FunctionKind::Kernel {
                continue;
            }
            let Some(values) = self.normalized_template_arguments(id, &arguments, span)? else {
                continue;
            };
            let instantiated = self.resolved_template_signature(id, &values, span)?;
            if instantiated.parameters == signature {
                selected = Some((id, values));
                break;
            }
        }
        let (id, values) = selected.ok_or_else(|| ParseError {
            message: String::from(
                "incompatible explicit kernel instantiation signature or arguments",
            ),
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

    fn check_template_launch_bounds(&mut self, instance: usize) -> Result<(), ParseError> {
        let instance = &self.templates.instances[instance];
        let span = instance.span;
        let is_kernel = matches!(instance.target, InstanceTarget::Kernel(_));
        let Some(bounds) = self.templates.declarations[instance.key.template]
            .launch_bounds
            .as_ref()
        else {
            return Ok(());
        };
        self.parameter_expansion_budget
            .charge_slice::<TemplateParameter<'_>>(bounds.parameters.len(), span)?;
        self.parameter_expansion_budget
            .charge_slice::<TemplateValue>(instance.key.arguments.len(), span)?;
        Self::charge_template_environment(
            &bounds.globals,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        let lexer = bounds.source.start.bounded(bounds.source.end);
        let parameters = bounds.parameters.clone();
        let arguments = instance.key.arguments.clone();
        let globals = bounds.globals.clone();
        let previous_globals = core::mem::replace(&mut self.global_declarations, globals);
        let previous_lexer = core::mem::replace(&mut self.lexer, lexer);
        let previous_function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let previous_signature = core::mem::replace(&mut self.templates.parsing_signature, true);
        let result = (|| {
            self.prepare_parameter_bindings(span)?;
            self.bind_template_parameters(&parameters, Some(&arguments))?;
            let mut header = self.function_header(false)?;
            self.parameter_expansion_budget
                .charge_bytes(header.name.len(), span)?;
            self.initialize_function_header(&header)?;
            self.parameters_with_launch_bounds(&mut header.launch_bounds)?;
            self.lexer.expect_span(Token::End)?;
            Ok::<_, ParseError>(header.launch_bounds)
        })();
        self.templates.parsing_signature = previous_signature;
        self.function = previous_function;
        self.lexer = previous_lexer;
        self.global_declarations = previous_globals;
        let bounds = result?;
        if is_kernel {
            self.check_launch_bounds(bounds)?;
        }
        Ok(())
    }

    fn materialize_template_instance(&mut self, instance: usize) -> Result<(), ParseError> {
        self.check_template_launch_bounds(instance)?;
        let instance = &self.templates.instances[instance];
        let span = instance.span;
        let declaration = &self.templates.declarations[instance.key.template];
        let end = declaration.definition.ok_or_else(|| ParseError {
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
            &declaration.globals,
            &mut self.parameter_expansion_budget,
            span,
        )?;
        let arguments = instance.key.arguments.clone();
        let target = instance.target;
        let metadata = declaration.header.clone();
        let parameters = declaration.parameters.clone();
        let lexer = declaration.source.start.bounded(end);
        let globals = declaration.globals.clone();
        let previous_globals = core::mem::replace(&mut self.global_declarations, globals);
        let previous_lexer = core::mem::replace(&mut self.lexer, lexer);
        let previous_function =
            core::mem::replace(&mut self.function, FunctionContext::new(metadata.kind));
        let result = (|| {
            self.prepare_parameter_bindings(span)?;
            self.bind_template_parameters(&parameters, Some(&arguments))?;
            let mut header = self.function_header(false)?;
            header.is_static = metadata.is_static;
            header.inlining = metadata.inlining;
            self.parameter_expansion_budget
                .charge_bytes(header.name.len(), span)?;
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
