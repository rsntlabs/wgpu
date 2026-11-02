use super::*;

use super::atomics::{WrappingAtomicFunction, INTEGER_ATOMICS, WRAPPING_ATOMICS};
use super::float_helpers::FloatMathFunction;
use super::function_declarations::Inlining;
use super::types::{IntegerSpecifiers, VECTOR_TYPES};
use crate::MathFunction;

const MATH_BUILTINS: [(&str, MathFunction); 4] = [
    ("min", MathFunction::Min),
    ("max", MathFunction::Max),
    ("fminf", MathFunction::Min),
    ("fmaxf", MathFunction::Max),
];

const MATH_SIGNATURES: [([Scalar; 2], Scalar); 5] = [
    ([Scalar::I32, Scalar::I32], Scalar::I32),
    ([Scalar::U32, Scalar::U32], Scalar::U32),
    ([Scalar::I32, Scalar::U32], Scalar::U32),
    ([Scalar::U32, Scalar::I32], Scalar::U32),
    ([Scalar::F32, Scalar::F32], Scalar::F32),
];

const MULTIPLY24_BUILTINS: [(&str, Scalar); 2] =
    [("__mul24", Scalar::I32), ("__umul24", Scalar::U32)];

const BITCAST_BUILTINS: [(&str, Scalar, Scalar); 4] = [
    ("__float_as_int", Scalar::F32, Scalar::I32),
    ("__float_as_uint", Scalar::F32, Scalar::U32),
    ("__int_as_float", Scalar::I32, Scalar::F32),
    ("__uint_as_float", Scalar::U32, Scalar::F32),
];

const UNARY_BUILTINS: [(&str, MathFunction, Scalar, Scalar); 11] = [
    (
        "__clz",
        MathFunction::CountLeadingZeros,
        Scalar::I32,
        Scalar::I32,
    ),
    (
        "__ffs",
        MathFunction::FirstTrailingBit,
        Scalar::I32,
        Scalar::I32,
    ),
    (
        "__popc",
        MathFunction::CountOneBits,
        Scalar::U32,
        Scalar::I32,
    ),
    (
        "__brev",
        MathFunction::ReverseBits,
        Scalar::U32,
        Scalar::U32,
    ),
    ("floorf", MathFunction::Floor, Scalar::F32, Scalar::F32),
    ("ceilf", MathFunction::Ceil, Scalar::F32, Scalar::F32),
    ("fabsf", MathFunction::Abs, Scalar::F32, Scalar::F32),
    ("fabs", MathFunction::Abs, Scalar::F32, Scalar::F32),
    ("sinf", MathFunction::Sin, Scalar::F32, Scalar::F32),
    ("cosf", MathFunction::Cos, Scalar::F32, Scalar::F32),
    (
        "__saturatef",
        MathFunction::Saturate,
        Scalar::F32,
        Scalar::F32,
    ),
];

const SQRT_BUILTINS: [&str; 2] = ["sqrtf", "sqrt"];
const INTEGRAL_DOUBLE_BUILTINS: [&str; 2] = ["fabs", "sqrt"];

#[derive(Clone, Copy, PartialEq)]
pub(super) struct MathBuiltin {
    function: MathFunction,
    parameters: [Scalar; 2],
    result: Scalar,
}

fn math_builtins(name: &str) -> impl Iterator<Item = MathBuiltin> + Clone {
    let function = MATH_BUILTINS
        .into_iter()
        .find_map(|(candidate, function)| (candidate == name).then_some(function));
    let signatures = if matches!(name, "fminf" | "fmaxf") {
        &MATH_SIGNATURES[4..]
    } else {
        &MATH_SIGNATURES[..]
    };
    signatures
        .iter()
        .copied()
        .filter_map(move |(parameters, result)| {
            function.map(|function| MathBuiltin {
                function,
                parameters,
                result,
            })
        })
}

fn vector_constructor(name: &str) -> Option<(VectorSize, Scalar)> {
    VECTOR_TYPES
        .into_iter()
        .find_map(|(_, constructor, size, scalar)| (name == constructor).then_some((size, scalar)))
}

pub(super) fn builtin_declarations<'a>() -> FastHashMap<&'a str, GlobalDeclaration> {
    MATH_BUILTINS
        .into_iter()
        .map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        })
        .chain(MULTIPLY24_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(BITCAST_BUILTINS.into_iter().map(|(name, _, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(UNARY_BUILTINS.into_iter().map(|(name, _, _, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(SQRT_BUILTINS.into_iter().map(|name| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(INTEGER_ATOMICS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(core::iter::once((
            "atomicCAS",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(WRAPPING_ATOMICS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(core::iter::once((
            "cooperative_groups",
            GlobalDeclaration::Namespace(Namespace::CooperativeGroups),
        )))
        .chain(core::iter::once((
            "dim3",
            GlobalDeclaration::Type(QualifiedType {
                ty: TypeSpecifier::Dim3,
                qualifiers: Qualifiers::NONE,
            }),
        )))
        .chain(
            VECTOR_TYPES
                .into_iter()
                .flat_map(|(name, constructor, size, scalar)| {
                    [
                        (
                            name,
                            GlobalDeclaration::Type(QualifiedType {
                                ty: TypeSpecifier::Vector { size, scalar },
                                qualifiers: Qualifiers::NONE,
                            }),
                        ),
                        (
                            constructor,
                            GlobalDeclaration::Functions(FunctionOverloads::default()),
                        ),
                    ]
                }),
        )
        .collect()
}

#[derive(Clone, Copy, Eq, PartialEq)]
pub(super) enum ReturnType {
    Void,
    Value(TypeSpecifier),
}

#[derive(Clone)]
pub(super) struct FunctionHeader<'a> {
    pub(super) kind: FunctionKind,
    pub(super) result: ReturnType,
    pub(super) result_span: Span,
    pub(super) result_qualifiers: Qualifiers,
    pub(super) name: &'a str,
    pub(super) name_span: Span,
    pub(super) has_host: bool,
    pub(super) is_static: bool,
    pub(super) inlining: Option<Inlining>,
    pub(super) operator: Option<operators::Operator>,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FunctionCandidate {
    Defined(Handle<Function>),
    Current,
    Builtin(MathBuiltin),
    Multiply24(Scalar),
    Atomic {
        function: crate::AtomicFunction,
        scalar: Scalar,
    },
    AtomicCompareExchange(Scalar),
    WrappingAtomic(WrappingAtomicFunction),
    Bitcast {
        source: Scalar,
        result: Scalar,
    },
    Unary {
        function: MathFunction,
        source: Scalar,
        result: Scalar,
    },
    IntegralDouble {
        source: Scalar,
    },
    Sqrt,
    Constructor {
        size: VectorSize,
        scalar: Scalar,
    },
}

pub(super) enum OverloadResolution<C = FunctionCandidate> {
    Selected(C),
    NoViable,
    Ambiguous,
}

#[derive(Clone, Copy)]
pub(super) struct ArgumentConversion {
    pub(super) rank: u8,
    pub(super) mode: ParameterMode,
}

pub(super) fn better_conversion_sequences(
    conversions: impl Iterator<Item = Option<(ArgumentConversion, ArgumentConversion)>>,
) -> bool {
    let mut has_better_conversion = false;
    for conversion in conversions {
        let Some((left, right)) = conversion else {
            return false;
        };
        if left.rank > right.rank {
            return false;
        }
        has_better_conversion |= left.rank < right.rank;
        if left.rank == right.rank {
            if let (
                ParameterMode::Reference { qualifiers: left },
                ParameterMode::Reference { qualifiers: right },
            ) = (left.mode, right.mode)
            {
                if left != right && left.contains(right) {
                    return false;
                }
                has_better_conversion |= left != right && right.contains(left);
            }
        }
    }
    has_better_conversion
}

pub(super) fn select_ranked_candidate<C: Copy + PartialEq>(
    candidates: impl Iterator<Item = C> + Clone,
    mut better: impl FnMut(C, C) -> bool,
) -> OverloadResolution<C> {
    let mut remaining = candidates.clone();
    let Some(mut best) = remaining.next() else {
        return OverloadResolution::NoViable;
    };
    for candidate in remaining {
        if better(candidate, best) {
            best = candidate;
        }
    }
    if candidates
        .clone()
        .any(|candidate| candidate != best && !better(best, candidate))
    {
        OverloadResolution::Ambiguous
    } else {
        OverloadResolution::Selected(best)
    }
}

pub(super) fn conversion_rank(
    source: &TypeResolution,
    target: &TypeResolution,
    module: &Module,
    user_conversion: bool,
) -> Option<u8> {
    if module.compare_types(source, target) {
        return Some(0);
    }
    match (
        source.inner_with(&module.types),
        target.inner_with(&module.types),
    ) {
        (&TypeInner::Scalar(source), &TypeInner::Scalar(target)) => {
            Some(if source == Scalar::BOOL && target == Scalar::I32 {
                1
            } else {
                2
            })
        }
        _ => user_conversion.then_some(3),
    }
}

impl<'a> Parser<'a> {
    pub(super) fn parameters(&mut self) -> Result<(), ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        if !self.lexer.next_if(Token::Paren(')'))? {
            if self.take_ident("void")? {
                self.lexer.expect_span(Token::Paren(')'))?;
            } else {
                let mut parameter_index = 0u32;
                loop {
                    self.parameter(parameter_index)?;
                    if self.lexer.next_if(Token::Paren(')'))? {
                        break;
                    }
                    let separator_span = self.lexer.expect_span(Token::Separator(','))?;
                    parameter_index = parameter_index.checked_add(1).ok_or_else(|| ParseError {
                        message: String::from("too many CUDA function parameters"),
                        span: separator_span,
                    })?;
                }
            }
        }
        Ok(())
    }

    fn check_function_name(
        &self,
        name: &str,
        span: Span,
        kind: FunctionKind,
    ) -> Result<(), ParseError> {
        self.check_name(name, span)?;
        self.check_dynamic_shared_linkage(name, span)?;
        let compatible = match self.global_declarations.get(name) {
            None => true,
            Some(&GlobalDeclaration::Functions(_)) => {
                kind == FunctionKind::Device && !self.has_kernel_template(name)
            }
            Some(_) => false,
        };
        if !compatible {
            return Err(ParseError {
                message: format!("incompatible function declaration `{name}`"),
                span,
            });
        }
        Ok(())
    }

    pub(super) fn function_header(
        &mut self,
        extern_c: bool,
    ) -> Result<FunctionHeader<'a>, ParseError> {
        let mut kind = None;
        let mut host_span = None;
        let mut result = None;
        let mut result_span = None;
        let mut inlining = None;
        let mut seen_static = false;
        let mut cuda_inline_span = None;
        let mut explicit_const = false;
        let mut explicit_volatile = false;
        let mut volatile_result = false;
        let mut const_result = false;
        let mut integers = IntegerSpecifiers::default();
        loop {
            let token = self.lexer.peek()?;
            if result.is_none() {
                if let Some(name) = self.qualified_item()? {
                    let cooperative_groups::QualifiedItem::Type(ty) = name.item else {
                        return self.fail("expected a supported function return type");
                    };
                    volatile_result = ty.qualifiers.is_volatile;
                    const_result = ty.qualifiers.is_const;
                    result = Some(ReturnType::Value(ty.ty));
                    result_span.get_or_insert(name.span);
                    continue;
                }
            }
            match token.0 {
                Token::Word("inline") => {
                    if inlining == Some(Inlining::Inline) {
                        return self.fail("duplicate inline specifier");
                    }
                    if cuda_inline_span.is_some() {
                        return self.fail("incompatible inlining specifiers");
                    }
                    inlining = Some(Inlining::Inline);
                }
                Token::Word("static") => {
                    if extern_c {
                        return self.fail("static conflicts with an extern C declaration");
                    }
                    if seen_static {
                        return self.fail("duplicate static specifier");
                    }
                    seen_static = true;
                }
                Token::Word("__forceinline__" | "__noinline__") => {
                    if inlining.is_some() {
                        return self.fail("duplicate or incompatible inlining specifiers");
                    }
                    cuda_inline_span = Some(token.1);
                    inlining = Some(if token.0 == Token::Word("__forceinline__") {
                        Inlining::ForceInline
                    } else {
                        Inlining::NoInline
                    });
                }
                Token::Word("__host__") => {
                    if host_span.is_some() || kind == Some(FunctionKind::Kernel) {
                        return self
                            .fail("duplicate or incompatible CUDA execution space specifier");
                    }
                    host_span = Some(token.1);
                }
                Token::Word("__device__" | "__global__") => {
                    if kind.is_some()
                        || (host_span.is_some() && token.0 == Token::Word("__global__"))
                    {
                        return self
                            .fail("duplicate or incompatible CUDA execution space specifier");
                    }
                    kind = Some(if token.0 == Token::Word("__device__") {
                        FunctionKind::Device
                    } else {
                        FunctionKind::Kernel
                    });
                }
                Token::Word("const") => {
                    if explicit_const {
                        return self.fail("duplicate const qualifier");
                    }
                    explicit_const = true;
                    result_span.get_or_insert(token.1);
                }
                Token::Word("volatile") => {
                    if explicit_volatile {
                        return self.fail("duplicate volatile qualifier");
                    }
                    explicit_volatile = true;
                    result_span.get_or_insert(token.1);
                }
                Token::Word(specifier @ ("int" | "signed" | "unsigned")) => {
                    if result.is_some() && integers.is_empty() {
                        return self.fail("incompatible or repeated return type specifier");
                    }
                    let Some(scalar) = integers.consume(specifier) else {
                        return self.fail("incompatible or repeated return type specifier");
                    };
                    result = Some(ReturnType::Value(TypeSpecifier::Scalar(scalar)));
                    result_span.get_or_insert(token.1);
                }
                Token::Word("void" | "float" | "bool") => {
                    if result.is_some() {
                        return self.fail("incompatible or repeated return type specifier");
                    }
                    result = Some(match token.0 {
                        Token::Word("void") => ReturnType::Void,
                        Token::Word("float") => {
                            ReturnType::Value(TypeSpecifier::Scalar(Scalar::F32))
                        }
                        _ => ReturnType::Value(TypeSpecifier::Scalar(Scalar::BOOL)),
                    });
                    result_span.get_or_insert(token.1);
                }
                Token::Word(name) if result.is_none() => {
                    let Some(ty) = self.type_name(name) else {
                        break;
                    };
                    volatile_result = ty.qualifiers.is_volatile;
                    const_result = ty.qualifiers.is_const;
                    result = Some(ReturnType::Value(ty.ty));
                    result_span.get_or_insert(token.1);
                }
                _ => break,
            }
            self.lexer.next()?;
        }
        if let (Some(span), None) = (host_span, kind) {
            return Err(ParseError {
                message: String::from("host-only functions are unsupported"),
                span,
            });
        }
        let Some(result) = result else {
            return self.fail("expected a supported function return type");
        };
        if (explicit_volatile || volatile_result)
            && !matches!(
                result,
                ReturnType::Void
                    | ReturnType::Value(
                        TypeSpecifier::Scalar(_) | TypeSpecifier::TemplateParameter(_)
                    )
            )
        {
            return self.fail("volatile class return types are unsupported");
        }
        if matches!(result, ReturnType::Value(TypeSpecifier::ThreadBlock)) {
            return self.fail("thread_block return types are unsupported");
        }
        if matches!(result, ReturnType::Value(TypeSpecifier::Pointer { .. })) {
            return self.fail("pointer return types are unsupported");
        }
        let Some(kind) = kind else {
            return self.fail("expected a CUDA execution space specifier");
        };
        if let (FunctionKind::Kernel, Some(span)) = (kind, cuda_inline_span) {
            return Err(ParseError {
                message: String::from("CUDA inlining specifiers are unsupported for kernels"),
                span,
            });
        }
        let token = self.lexer.peek()?;
        let (name, name_span, operator) = if self.take_ident("operator")? {
            let (operator, span) = self.operator_name(token.1)?;
            (operator.name(), span, Some(operator))
        } else {
            let (name, span) = self.identifier()?;
            (name, span, None)
        };
        if operator.is_some() && kind != FunctionKind::Device {
            return Err(ParseError {
                message: String::from("operator functions must be device helpers"),
                span: name_span,
            });
        }
        Ok(FunctionHeader {
            kind,
            result,
            result_span: result_span.unwrap(),
            result_qualifiers: Qualifiers {
                is_const: explicit_const || const_result,
                is_volatile: explicit_volatile || volatile_result,
            },
            name,
            name_span,
            has_host: host_span.is_some(),
            is_static: seen_static,
            inlining,
            operator,
        })
    }

    pub(super) fn function_definition(&mut self) -> Result<FunctionKind, ParseError> {
        let extern_c = self.take_ident("extern")?;
        if extern_c {
            if self.lexer.peek()?.0 != Token::String("C") {
                return self.fail("expected `\"C\"` after `extern`");
            }
            self.lexer.next()?;
        }
        let header = self.function_header(extern_c)?;
        self.check_function_name(header.name, header.name_span, header.kind)?;
        self.function = FunctionContext::new(header.kind);
        match header.kind {
            FunctionKind::Device => {
                if extern_c {
                    return Err(ParseError {
                        message: String::from("extern C device helpers are unsupported"),
                        span: header.name_span,
                    });
                }
                self.device_function(header)?;
                Ok(FunctionKind::Device)
            }
            FunctionKind::Kernel => {
                self.kernel(header)?;
                Ok(FunctionKind::Kernel)
            }
        }
    }

    pub(super) fn kernel(&mut self, header: FunctionHeader<'a>) -> Result<(), ParseError> {
        if !self.kernels.is_empty() {
            self.activate_parameter_expansion(header.name_span)?;
        }
        self.kernel_body(&header)?;
        let function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Kernel),
        );
        self.parameter_expansion_budget
            .charge_slice::<Kernel<'_>>(1, header.name_span)?;
        self.parameter_expansion_budget
            .charge_slice::<EntryPoint>(1, header.name_span)?;
        self.parameter_expansion_budget
            .charge_bytes(header.name.len(), header.name_span)?;
        self.parameter_expansion_budget
            .charge_work(1, header.name_span)?;
        self.module.entry_points.push(EntryPoint {
            name: String::from(header.name),
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
            context: Some(function),
            parameter_state: None,
            calls: Vec::new(),
        });
        self.global_declarations
            .insert(header.name, GlobalDeclaration::Kernel);
        Ok(())
    }

    pub(super) fn kernel_body(&mut self, header: &FunctionHeader<'a>) -> Result<(), ParseError> {
        if !matches!(header.result, ReturnType::Void) {
            return Err(ParseError {
                message: String::from("CUDA kernels must return void"),
                span: header.result_span,
            });
        }
        self.parameters()?;
        self.lexer.expect_span(Token::Paren('{'))?;
        self.initialize_helper_builtins()?;
        self.block_contents()?;
        self.flush_emitter();
        Ok(())
    }

    pub(super) fn initialize_function_header(
        &mut self,
        header: &FunctionHeader<'a>,
    ) -> Result<(), ParseError> {
        self.function.ir.name = Some(String::from(header.name));
        if let ReturnType::Value(ty) = header.result {
            let ty = self.lower_type(ty, header.result_span)?;
            self.function.ir.result = Some(crate::FunctionResult {
                ty: self.type_handle(&ty, header.result_span),
                binding: None,
            });
        }
        Ok(())
    }

    pub(super) fn device_function(&mut self, header: FunctionHeader<'a>) -> Result<(), ParseError> {
        self.device_function_with_target(header, None)
    }

    pub(super) fn device_function_with_target(
        &mut self,
        header: FunctionHeader<'a>,
        target: Option<Handle<Function>>,
    ) -> Result<(), ParseError> {
        self.initialize_function_header(&header)?;
        if let Some(target) = target {
            self.parameter_expansion_budget.charge_bytes(
                self.module.functions[target]
                    .name
                    .as_ref()
                    .map_or(0, String::len),
                header.name_span,
            )?;
            self.function.ir.name = self.module.functions[target].name.clone();
        }
        self.parameters()?;
        if let Some(target) = target {
            if self.function_declarations[&target].parameters != self.function.parameters {
                return self.fail("incompatible instantiated function parameter types");
            }
        }
        if let Some(operator) = header.operator {
            self.check_operator_parameters(operator, header.name_span)?;
        }
        let is_prototype = self.lexer.peek()?.0 == Token::Separator(';');
        if !is_prototype {
            if let Some(span) = self.function.volatile_parameter_object {
                return Err(ParseError {
                    message: String::from("volatile parameter objects are unsupported"),
                    span,
                });
            }
        }
        let intrinsic = self.function_candidates(header.name).find(|&candidate| {
            target.is_none()
                && matches!(
                    candidate,
                    FunctionCandidate::Builtin(_)
                        | FunctionCandidate::Multiply24(_)
                        | FunctionCandidate::Atomic { .. }
                        | FunctionCandidate::AtomicCompareExchange(_)
                        | FunctionCandidate::WrappingAtomic(_)
                        | FunctionCandidate::Bitcast { .. }
                        | FunctionCandidate::Unary { .. }
                        | FunctionCandidate::Sqrt
                        | FunctionCandidate::Constructor { .. }
                )
                && self.function.parameters.len() == self.candidate_arity(candidate)
                && (0..self.candidate_arity(candidate)).all(|index| {
                    self.function.parameters[index].mode() == self.candidate_mode(candidate, index)
                        && match (
                            self.candidate_type(FunctionCandidate::Current, index),
                            self.candidate_type(candidate, index),
                        ) {
                            (Some(source), Some(target)) => {
                                self.module.compare_types(&source, &target)
                            }
                            _ => false,
                        }
                })
        });
        if let Some(candidate) = intrinsic {
            if !is_prototype {
                return Err(ParseError {
                    message: format!("duplicate builtin definition `{}`", header.name),
                    span: header.name_span,
                });
            }
            let result = self.candidate_result(candidate, header.result_span)?;
            if self.function.ir.result.as_ref().map(|result| result.ty) != result {
                return Err(ParseError {
                    message: format!("incompatible builtin result type `{}`", header.name),
                    span: header.name_span,
                });
            }
            let parameters: Vec<_> = self
                .function
                .ir
                .arguments
                .iter()
                .map(|argument| argument.ty)
                .collect();
            if let Some(previous) = self
                .intrinsic_declarations
                .iter_mut()
                .find(|previous| previous.name == header.name && previous.parameters == parameters)
            {
                function_declarations::check_redeclaration(
                    previous.has_host,
                    previous.is_static,
                    previous.inlining,
                    header.has_host,
                    header.is_static,
                    header.inlining,
                    header.name_span,
                )?;
                previous.inlining = previous.inlining.or(header.inlining);
            } else {
                self.intrinsic_declarations.push(IntrinsicDeclaration {
                    name: header.name,
                    parameters,
                    has_host: header.has_host,
                    is_static: header.is_static,
                    inlining: header.inlining,
                });
            }
            self.lexer.expect_span(Token::Separator(';'))?;
            self.function = FunctionContext::new(FunctionKind::Kernel);
            return Ok(());
        }
        let previous = target.or_else(|| match self.global_declarations.get(header.name) {
            Some(&GlobalDeclaration::Functions(ref functions)) => {
                functions.functions.iter().copied().find(|&function| {
                    self.function_declarations[&function].parameters == self.function.parameters
                })
            }
            _ => None,
        });
        if let Some(previous) = previous {
            let declaration = self.function_declarations.get_mut(&previous).unwrap();
            function_declarations::check_redeclaration(
                declaration.has_host,
                declaration.is_static,
                declaration.inlining,
                header.has_host,
                header.is_static,
                header.inlining,
                header.name_span,
            )?;
            if !is_prototype && declaration.is_defined {
                return Err(ParseError {
                    message: format!("duplicate device helper definition `{}`", header.name),
                    span: header.name_span,
                });
            }
            if self.module.functions[previous]
                .result
                .as_ref()
                .map(|result| result.ty)
                != self.function.ir.result.as_ref().map(|result| result.ty)
            {
                return Err(ParseError {
                    message: format!("incompatible device helper result type `{}`", header.name),
                    span: header.name_span,
                });
            }
            declaration.inlining = declaration.inlining.or(header.inlining);
        }
        if is_prototype {
            if previous.is_none() {
                let function = Function {
                    name: self.function.ir.name.clone(),
                    arguments: self.function.ir.arguments.clone(),
                    result: self.function.ir.result.clone(),
                    ..Function::default()
                };
                let handle = self.module.functions.append(function, header.name_span);
                self.register_function(header.name, handle);
                self.function_declarations.insert(
                    handle,
                    FunctionDeclaration {
                        parameters: core::mem::take(&mut self.function.parameters),
                        has_host: header.has_host,
                        is_static: header.is_static,
                        inlining: header.inlining,
                        is_defined: false,
                        calls: Vec::new(),
                    },
                );
            }
            self.lexer.expect_span(Token::Separator(';'))?;
            self.function = FunctionContext::new(FunctionKind::Kernel);
            return Ok(());
        }
        self.function.current_declaration = previous;
        self.lexer.expect_span(Token::Paren('{'))?;
        let terminated = self.block_contents()?;
        if self.function.ir.result.is_some() && !terminated {
            return Err(ParseError {
                message: String::from("device helper must return a value on every supported path"),
                span: header.name_span,
            });
        }
        self.flush_emitter();
        if self.function.ir.result.is_none() {
            crate::proc::ensure_block_returns(&mut self.function.ir.body);
        }
        let parameter_state = if self.parameter_state_needed() {
            self.prepare_parameter_bindings(header.name_span)?;
            self.parameter_expansion_budget.charge_slice::<u32>(
                self.function.expression_graph_depths.len(),
                header.name_span,
            )?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Function>, FunctionParameterState>(
                    1,
                    header.name_span,
                )?;
            Some(self.function.take_parameter_state())
        } else {
            None
        };
        let function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Kernel),
        );
        if let Some(previous) = previous {
            self.module.functions[previous] = function.ir;
            let declaration = self.function_declarations.get_mut(&previous).unwrap();
            declaration.parameters = function.parameters;
            declaration.is_defined = true;
            declaration.calls = function.calls;
            if let Some(state) = parameter_state {
                self.parameter_states.insert(previous, state);
            }
        } else {
            let handle = self.module.functions.append(function.ir, header.name_span);
            self.register_function(header.name, handle);
            self.function_declarations.insert(
                handle,
                FunctionDeclaration {
                    parameters: function.parameters,
                    has_host: header.has_host,
                    is_static: header.is_static,
                    inlining: header.inlining,
                    is_defined: true,
                    calls: function.calls,
                },
            );
            if let Some(state) = parameter_state {
                self.parameter_states.insert(handle, state);
            }
        }
        Ok(())
    }

    fn register_function(&mut self, name: &'a str, handle: Handle<Function>) {
        match *self
            .global_declarations
            .entry(name)
            .or_insert_with(|| GlobalDeclaration::Functions(FunctionOverloads::default()))
        {
            GlobalDeclaration::Functions(ref mut functions) => functions.functions.push(handle),
            _ => unreachable!(),
        }
    }

    fn candidate_result(
        &mut self,
        candidate: FunctionCandidate,
        span: Span,
    ) -> Result<Option<Handle<Type>>, ParseError> {
        let ty = match candidate {
            FunctionCandidate::Defined(function) => {
                return Ok(self.module.functions[function]
                    .result
                    .as_ref()
                    .map(|result| result.ty))
            }
            FunctionCandidate::Current => {
                return Ok(self.function.ir.result.as_ref().map(|result| result.ty))
            }
            FunctionCandidate::Builtin(builtin) => TypeSpecifier::Scalar(builtin.result),
            FunctionCandidate::Multiply24(result)
            | FunctionCandidate::Atomic { scalar: result, .. }
            | FunctionCandidate::AtomicCompareExchange(result)
            | FunctionCandidate::Bitcast { result, .. }
            | FunctionCandidate::Unary { result, .. } => TypeSpecifier::Scalar(result),
            FunctionCandidate::WrappingAtomic(_) => TypeSpecifier::Scalar(Scalar::U32),
            FunctionCandidate::IntegralDouble { .. } => unreachable!(),
            FunctionCandidate::Sqrt => TypeSpecifier::Scalar(Scalar::F32),
            FunctionCandidate::Constructor { size, scalar } => {
                TypeSpecifier::Vector { size, scalar }
            }
        };
        let ty = self.lower_type(ty, span)?;
        Ok(Some(self.type_handle(&ty, span)))
    }

    pub(super) fn device_parameter(
        &mut self,
        name: Option<&'a str>,
        span: Span,
        parameter_ty: &TypeResolution,
        is_const: bool,
        mode: ParameterMode,
    ) -> Result<(), ParseError> {
        let ty = self.type_handle(parameter_ty, span);
        self.parameter_expansion_budget
            .charge_slice::<SourceParameter>(1, span)?;
        self.function
            .parameters
            .push(SourceParameter::Shader { ty, mode });
        if let Some(modes) = self.function.physical_parameter_modes.as_mut() {
            self.parameter_expansion_budget
                .charge_slice::<ParameterMode>(1, span)?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            modes.push(mode);
        }
        let argument_ty = if matches!(mode, ParameterMode::Reference { .. }) {
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
        let argument_index = self.function.ir.arguments.len() as u32;
        self.function.ir.arguments.push(FunctionArgument {
            name: name.map(String::from),
            ty: argument_ty,
            binding: None,
        });
        let Some(name) = name else {
            return Ok(());
        };
        if let ParameterMode::Pointer { qualifiers } = mode {
            let pointer = self.parameter_pointer(argument_index, parameter_ty, qualifiers, span)?;
            let pointer = self.source_pointer_variable(name, pointer, is_const, span)?;
            let pointer = self.retain_pointer_symbol(pointer)?;
            return self.insert_symbol(name, Symbol::Pointer(pointer), span);
        }
        let value = self.append(Expression::FunctionArgument(argument_index), span)?;
        if let ParameterMode::Reference { qualifiers } = mode {
            self.insert_symbol(
                name,
                Symbol::Variable {
                    pointer: value,
                    ty: parameter_ty.clone(),
                    qualifiers,
                },
                span,
            )
        } else {
            self.initialize_parameter(name, span, parameter_ty, is_const, value)
        }
    }

    pub(super) fn call(&mut self, name: &str, span: Span) -> Result<ExpressionResult, ParseError> {
        if self.lookup_symbol(name).is_some() {
            return Err(ParseError {
                message: format!("local value `{name}` cannot be called"),
                span,
            });
        }
        if self.has_function_template(name) {
            return self.deduced_template_call(name, span);
        }
        self.ordinary_call(name, span)
    }

    fn ordinary_call(&mut self, name: &str, span: Span) -> Result<ExpressionResult, ParseError> {
        if self.function_candidates(name).next().is_none() {
            return Err(ParseError {
                message: format!("unknown or not previously declared device helper `{name}`"),
                span,
            });
        }
        self.lexer.expect_span(Token::Paren('('))?;
        if self.has_captured_candidate(name) {
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
            return self.call_with_captured_arguments(name, arguments, span, span.until(&end));
        }
        let mut arguments = Vec::new();
        if self.lexer.peek()?.0 != Token::Paren(')') {
            loop {
                let value = self.expression(0)?;
                arguments.push(self.rvalue(value)?);
                if self.lexer.peek()?.0 == Token::Paren(')') {
                    break;
                }
                self.lexer.expect_span(Token::Separator(','))?;
            }
        }
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        self.call_with_arguments(name, arguments, span, span.until(&end))
    }

    pub(super) fn call_with_arguments(
        &mut self,
        name: &str,
        arguments: Vec<Value>,
        name_span: Span,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let candidate = self.resolve_overload(name, &arguments, name_span)?;
        self.lower_call(candidate, arguments, span)
    }

    pub(super) fn lower_call(
        &mut self,
        candidate: FunctionCandidate,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        if let FunctionCandidate::Constructor { size, scalar } = candidate {
            let components = arguments
                .into_iter()
                .map(|value| {
                    self.convert_scalar(value.into(), scalar)
                        .map(|value| value.handle)
                })
                .collect::<Result<Vec<_>, _>>()?;
            let ty = self.lower_type(TypeSpecifier::Vector { size, scalar }, span)?;
            let handle_ty = self.type_handle(&ty, span);
            let handle = self.append(
                Expression::Compose {
                    ty: handle_ty,
                    components,
                },
                span,
            )?;
            return Ok(Value {
                constant: ConstantValue::default(),
                handle,
                ty,
                span,
            }
            .into());
        }
        if let FunctionCandidate::Bitcast { source, result } = candidate {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), source)?;
            let mut expr = argument.handle;
            if result == Scalar::F32 {
                // Keep non-finite results out of WGSL constant evaluation.
                let pointer = self.temporary_pointer(&argument.ty, span)?;
                self.push_statement(
                    Statement::Store {
                        pointer,
                        value: expr,
                    },
                    span,
                );
                expr = self.append(Expression::Load { pointer }, span)?;
            }
            let handle = self.append(
                Expression::As {
                    expr,
                    kind: result.kind,
                    convert: None,
                },
                span,
            )?;
            return Ok(Value {
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(result),
                span,
            }
            .into());
        }
        if candidate == FunctionCandidate::Sqrt {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
            let bits = self.append(
                Expression::As {
                    expr: argument.handle,
                    kind: ScalarKind::Uint,
                    convert: None,
                },
                span,
            )?;
            let function = self.sqrtf_function(span)?;
            let result = self.append_call_result(function, span)?;
            self.push_statement(
                Statement::Call {
                    function,
                    arguments: alloc::vec![bits],
                    result: Some(result),
                },
                span,
            );
            let handle = self.append(
                Expression::As {
                    expr: result,
                    kind: ScalarKind::Float,
                    convert: None,
                },
                span,
            )?;
            return Ok(Value {
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::F32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Unary {
            function,
            source,
            result,
        } = candidate
        {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), source)?;
            let handle = match function {
                MathFunction::Floor => {
                    self.call_float_math(argument.handle, FloatMathFunction::Floor, span)?
                }
                MathFunction::Ceil => {
                    self.call_float_math(argument.handle, FloatMathFunction::Ceil, span)?
                }
                MathFunction::Abs => {
                    self.call_float_math(argument.handle, FloatMathFunction::AbsoluteValue, span)?
                }
                MathFunction::Saturate => self.saturate(argument.handle, span)?,
                MathFunction::Sin | MathFunction::Cos => {
                    self.trigonometry(argument.handle, function == MathFunction::Cos, span)?
                }
                _ => self.append(
                    Expression::Math {
                        fun: function,
                        arg: argument.handle,
                        arg1: None,
                        arg2: None,
                        arg3: None,
                    },
                    span,
                )?,
            };
            let mut value = Value {
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(source),
                span,
            };
            if function == MathFunction::FirstTrailingBit {
                // CUDA numbers set bits from one and returns zero for no set bits.
                let one = self.append(Expression::Literal(Literal::I32(1)), span)?;
                value.handle = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: value.handle,
                        right: one,
                    },
                    span,
                )?;
            }
            return Ok(self.convert_scalar(value.into(), result)?.into());
        }
        if let FunctionCandidate::Multiply24(scalar) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let offset = self.append(Expression::Literal(Literal::U32(0)), span)?;
            let count = self.append(Expression::Literal(Literal::U32(24)), span)?;
            let mut operands = [left.handle, right.handle];
            for operand in &mut operands {
                let extracted = self.append(
                    Expression::Math {
                        fun: MathFunction::ExtractBits,
                        arg: *operand,
                        arg1: Some(offset),
                        arg2: Some(count),
                        arg3: None,
                    },
                    span,
                )?;
                *operand = if scalar == Scalar::I32 {
                    self.append(
                        Expression::As {
                            expr: extracted,
                            kind: ScalarKind::Uint,
                            convert: None,
                        },
                        span,
                    )?
                } else {
                    extracted
                };
            }
            let [left, right] = operands;
            let product = self.append(
                Expression::Binary {
                    op: BinaryOperator::Multiply,
                    left,
                    right,
                },
                span,
            )?;
            let handle = if scalar == Scalar::I32 {
                self.append(
                    Expression::As {
                        expr: product,
                        kind: ScalarKind::Sint,
                        convert: None,
                    },
                    span,
                )?
            } else {
                product
            };
            return Ok(Value {
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(scalar),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Builtin(builtin) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), builtin.result)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), builtin.result)?;
            let handle = if builtin.result == Scalar::F32 {
                self.float_minmax(builtin.function, left.handle, right.handle, span)?
            } else {
                self.append(
                    Expression::Math {
                        fun: builtin.function,
                        arg: left.handle,
                        arg1: Some(right.handle),
                        arg2: None,
                        arg3: None,
                    },
                    span,
                )?
            };
            return Ok(Value {
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(builtin.result),
                span,
            }
            .into());
        }
        let FunctionCandidate::Defined(function) = candidate else {
            unreachable!()
        };
        self.function.calls.push(FunctionCall { function, span });
        let mut converted = Vec::with_capacity(arguments.len());
        for (argument_index, value) in arguments.into_iter().enumerate() {
            let parameter = &self.module.functions[function].arguments[argument_index];
            let ty = TypeResolution::Handle(parameter.ty);
            converted.push(self.convert_value(value.into(), &ty)?.handle);
        }
        let ty = self.module.functions[function]
            .result
            .as_ref()
            .map(|result| TypeResolution::Handle(result.ty));
        let value = if let Some(ty) = ty {
            let handle = self.append_call_result(function, span)?;
            Some(Value {
                constant: ConstantValue::default(),
                handle,
                ty,
                span,
            })
        } else {
            None
        };
        self.push_statement(
            Statement::Call {
                function,
                arguments: converted,
                result: value.as_ref().map(|value| value.handle),
            },
            span,
        );
        Ok(match value {
            Some(value) => value.into(),
            None => ExpressionResult::Void(span),
        })
    }

    fn float_minmax(
        &mut self,
        function: MathFunction,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let sign_bit = self.append(Expression::Literal(Literal::U32(0x8000_0000)), span)?;
        let magnitude_mask = self.append(Expression::Literal(Literal::U32(0x7fff_ffff)), span)?;
        let infinity_bits = self.append(Expression::Literal(Literal::U32(0x7f80_0000)), span)?;
        let canonical_nan_bits =
            self.append(Expression::Literal(Literal::U32(0x7fc0_0000)), span)?;
        let operands = [left, right].map(|value| {
            let bits = self.append(
                Expression::As {
                    expr: value,
                    kind: ScalarKind::Uint,
                    convert: None,
                },
                span,
            )?;
            let is_negative = self.append(
                Expression::Binary {
                    op: BinaryOperator::GreaterEqual,
                    left: bits,
                    right: sign_bit,
                },
                span,
            )?;
            let reversed_bits = self.append(
                Expression::Unary {
                    op: UnaryOperator::BitwiseNot,
                    expr: bits,
                },
                span,
            )?;
            let positive_key = self.append(
                Expression::Binary {
                    op: BinaryOperator::ExclusiveOr,
                    left: bits,
                    right: sign_bit,
                },
                span,
            )?;
            let ordering_key = self.append(
                Expression::Select {
                    condition: is_negative,
                    accept: reversed_bits,
                    reject: positive_key,
                },
                span,
            )?;
            let absolute_bits = self.append(
                Expression::Binary {
                    op: BinaryOperator::And,
                    left: bits,
                    right: magnitude_mask,
                },
                span,
            )?;
            let is_nan = self.append(
                Expression::Binary {
                    op: BinaryOperator::Greater,
                    left: absolute_bits,
                    right: infinity_bits,
                },
                span,
            )?;
            Ok::<_, ParseError>((bits, ordering_key, is_nan))
        });
        let [left, right] = operands;
        let (left_bits, left_key, left_is_nan) = left?;
        let (right_bits, right_key, right_is_nan) = right?;
        let choose_left = self.append(
            Expression::Binary {
                op: if function == MathFunction::Min {
                    BinaryOperator::Less
                } else {
                    BinaryOperator::Greater
                },
                left: left_key,
                right: right_key,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: choose_left,
                accept: left_bits,
                reject: right_bits,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: left_is_nan,
                accept: right_bits,
                reject: selected_bits,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: right_is_nan,
                accept: left_bits,
                reject: selected_bits,
            },
            span,
        )?;
        let both_are_nan = self.append(
            Expression::Binary {
                op: BinaryOperator::LogicalAnd,
                left: left_is_nan,
                right: right_is_nan,
            },
            span,
        )?;
        let bits = self.append(
            Expression::Select {
                condition: both_are_nan,
                accept: canonical_nan_bits,
                reject: selected_bits,
            },
            span,
        )?;
        self.append(
            Expression::As {
                expr: bits,
                kind: ScalarKind::Float,
                convert: None,
            },
            span,
        )
    }

    pub(super) fn has_function_candidate(&self, name: &str) -> bool {
        self.function_candidates(name).next().is_some()
    }

    pub(super) fn function_candidates<'b>(
        &'b self,
        name: &str,
    ) -> impl Iterator<Item = FunctionCandidate> + Clone + 'b {
        let functions = match self.global_declarations.get(name) {
            Some(&GlobalDeclaration::Functions(ref functions)) => functions.functions.as_slice(),
            _ => &[],
        };
        let current = (self.function.kind == FunctionKind::Device
            && self.function.ir.name.as_deref() == Some(name))
        .then_some(FunctionCandidate::Current);
        let builtin_visible = matches!(
            self.global_declarations.get(name),
            Some(&GlobalDeclaration::Functions(_))
        );
        let atomic_function = INTEGER_ATOMICS
            .into_iter()
            .find_map(|(candidate, function)| {
                (builtin_visible && name == candidate).then_some(function)
            });
        let compare_exchange_visible = builtin_visible && name == "atomicCAS";
        functions
            .iter()
            .copied()
            .filter(move |&function| self.function.current_declaration != Some(function))
            .map(FunctionCandidate::Defined)
            .chain(current)
            .chain(
                math_builtins(name)
                    .filter(move |_| builtin_visible)
                    .map(FunctionCandidate::Builtin),
            )
            .chain(
                MULTIPLY24_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, scalar)| FunctionCandidate::Multiply24(scalar)),
            )
            .chain(
                BITCAST_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, source, result)| FunctionCandidate::Bitcast { source, result }),
            )
            .chain(
                UNARY_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _, _, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, function, source, result)| FunctionCandidate::Unary {
                        function,
                        source,
                        result,
                    }),
            )
            .chain(
                (builtin_visible && SQRT_BUILTINS.contains(&name))
                    .then_some(FunctionCandidate::Sqrt),
            )
            .chain(atomic_function.into_iter().flat_map(|function| {
                [Scalar::I32, Scalar::U32]
                    .map(|scalar| FunctionCandidate::Atomic { function, scalar })
            }))
            .chain(
                [Scalar::I32, Scalar::U32]
                    .into_iter()
                    .filter(move |_| compare_exchange_visible)
                    .map(FunctionCandidate::AtomicCompareExchange),
            )
            .chain(
                WRAPPING_ATOMICS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, function)| FunctionCandidate::WrappingAtomic(function)),
            )
            .chain(
                vector_constructor(name)
                    .filter(move |_| builtin_visible)
                    .map(|(size, scalar)| FunctionCandidate::Constructor { size, scalar }),
            )
    }

    pub(super) fn candidate_arity(&self, candidate: FunctionCandidate) -> usize {
        match candidate {
            FunctionCandidate::Defined(handle) => self.function_declarations.get(&handle).map_or(
                self.module.functions[handle].arguments.len(),
                |declaration| declaration.parameters.len(),
            ),
            FunctionCandidate::Current => self.function.parameters.len(),
            FunctionCandidate::Builtin(builtin) => builtin.parameters.len(),
            FunctionCandidate::Multiply24(_)
            | FunctionCandidate::Atomic { .. }
            | FunctionCandidate::WrappingAtomic(_) => 2,
            FunctionCandidate::AtomicCompareExchange(_) => 3,
            FunctionCandidate::Bitcast { .. }
            | FunctionCandidate::Unary { .. }
            | FunctionCandidate::IntegralDouble { .. }
            | FunctionCandidate::Sqrt => 1,
            FunctionCandidate::Constructor { size, .. } => size as usize,
        }
    }

    pub(super) fn candidate_type(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
    ) -> Option<TypeResolution> {
        match candidate {
            FunctionCandidate::Defined(handle) => {
                if let Some(declaration) = self.function_declarations.get(&handle) {
                    return declaration.parameters[logical_index]
                        .shader_type()
                        .map(TypeResolution::Handle);
                }
            }
            FunctionCandidate::Current => {
                return self.function.parameters[logical_index]
                    .shader_type()
                    .map(TypeResolution::Handle)
            }
            _ => {}
        }
        let argument = match candidate {
            FunctionCandidate::Defined(handle) => {
                &self.module.functions[handle].arguments[logical_index]
            }
            FunctionCandidate::Current => &self.function.ir.arguments[logical_index],
            FunctionCandidate::Builtin(builtin) => {
                return Some(scalar_resolution(builtin.parameters[logical_index]))
            }
            FunctionCandidate::Bitcast { source, .. }
            | FunctionCandidate::Unary { source, .. }
            | FunctionCandidate::Multiply24(source)
            | FunctionCandidate::IntegralDouble { source } => {
                return Some(scalar_resolution(source))
            }
            FunctionCandidate::Sqrt => return Some(scalar_resolution(Scalar::F32)),
            FunctionCandidate::Constructor { scalar, .. } => {
                return Some(scalar_resolution(scalar))
            }
            FunctionCandidate::Atomic { scalar, .. }
            | FunctionCandidate::AtomicCompareExchange(scalar) => {
                return Some(if logical_index == 0 {
                    TypeResolution::Value(TypeInner::ValuePointer {
                        size: None,
                        scalar,
                        space: AddressSpace::Function,
                    })
                } else {
                    scalar_resolution(scalar)
                })
            }
            FunctionCandidate::WrappingAtomic(_) => {
                return Some(if logical_index == 0 {
                    TypeResolution::Value(TypeInner::ValuePointer {
                        size: None,
                        scalar: Scalar::U32,
                        space: AddressSpace::Function,
                    })
                } else {
                    scalar_resolution(Scalar::U32)
                })
            }
        };
        Some(TypeResolution::Handle(argument.ty))
    }

    pub(super) fn candidate_mode(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
    ) -> ParameterMode {
        match candidate {
            FunctionCandidate::Defined(handle) => self
                .function_declarations
                .get(&handle)
                .map_or(ParameterMode::Value, |declaration| {
                    declaration.parameters[logical_index].mode()
                }),
            FunctionCandidate::Current => self.function.parameters[logical_index].mode(),
            FunctionCandidate::Atomic { .. }
            | FunctionCandidate::AtomicCompareExchange(_)
            | FunctionCandidate::WrappingAtomic(_)
                if logical_index == 0 =>
            {
                ParameterMode::Pointer {
                    qualifiers: Qualifiers::NONE,
                }
            }
            _ => ParameterMode::Value,
        }
    }

    pub(super) fn candidate_conversion(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let target = self.candidate_type(candidate, logical_index);
        if target.is_none() {
            return argument.is_thread_block().then_some(0);
        }
        if argument.is_thread_block() {
            return None;
        }
        let atomic_scalar = match candidate {
            FunctionCandidate::Atomic { scalar, .. }
            | FunctionCandidate::AtomicCompareExchange(scalar) => Some(scalar),
            FunctionCandidate::WrappingAtomic(_) => Some(Scalar::U32),
            _ => None,
        };
        if let Some(scalar) = atomic_scalar {
            if logical_index == 0 {
                let pointer = argument.pointer_type(&self.module)?;
                return (pointer.qualifiers == Qualifiers::NONE
                    && self.module.types[pointer.pointee].inner == TypeInner::Scalar(scalar))
                .then_some(0);
            }
        }
        let target = target?;
        let mode = self.candidate_mode(candidate, logical_index);
        if let ParameterMode::Pointer { qualifiers } = mode {
            let TypeInner::Pointer { base, .. } = *target.inner_with(&self.module.types) else {
                return None;
            };
            return self.pointer_argument_conversion(
                &TypeResolution::Handle(base),
                qualifiers,
                argument,
            );
        }
        self.value_argument_conversion(&target, mode, argument)
    }

    pub(super) fn pointer_argument_conversion(
        &self,
        pointee: &TypeResolution,
        qualifiers: Qualifiers,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        if argument.is_null_pointer_constant() {
            return Some(2);
        }
        let source = argument.pointer_type(&self.module)?;
        self.module
            .compare_types(&TypeResolution::Handle(source.pointee), pointee)
            .then(|| qualifiers.qualification_rank(source.qualifiers))
            .flatten()
    }

    pub(super) fn value_argument_conversion(
        &self,
        target: &TypeResolution,
        mode: ParameterMode,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let source = argument.ty()?;
        let rank = conversion_rank(
            source,
            target,
            &self.module,
            self.dimension_conversion(source, target),
        )?;
        match mode {
            ParameterMode::Value => Some(rank),
            ParameterMode::Reference { qualifiers } => {
                if rank == 0 {
                    if let Some(source) = argument.reference_qualifiers() {
                        return qualifiers.contains(source).then_some(rank);
                    }
                }
                (qualifiers.is_const && !qualifiers.is_volatile).then_some(rank)
            }
            ParameterMode::Pointer { .. } => unreachable!(),
        }
    }

    pub(super) fn pointer_reference_conversion(
        &self,
        pointee: Handle<Type>,
        pointee_qualifiers: Qualifiers,
        object_qualifiers: Qualifiers,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let rank = self.pointer_argument_conversion(
            &TypeResolution::Handle(pointee),
            pointee_qualifiers,
            argument,
        )?;
        if rank == 0 {
            if let Some(source) = argument.pointer_object_qualifiers() {
                return object_qualifiers.contains(source).then_some(rank);
            }
        }
        (object_qualifiers.is_const && !object_qualifiers.is_volatile).then_some(rank)
    }

    fn better_candidate(
        &self,
        left_candidate: FunctionCandidate,
        right_candidate: FunctionCandidate,
        arguments: &[impl CallArgument],
    ) -> bool {
        better_conversion_sequences(arguments.iter().enumerate().map(|(index, argument)| {
            let left = self.candidate_conversion(left_candidate, index, argument)?;
            let right = self.candidate_conversion(right_candidate, index, argument)?;
            Some((
                ArgumentConversion {
                    rank: left,
                    mode: self.candidate_mode(left_candidate, index),
                },
                ArgumentConversion {
                    rank: right,
                    mode: self.candidate_mode(right_candidate, index),
                },
            ))
        }))
    }

    pub(super) fn resolve_overload(
        &self,
        name: &str,
        arguments: &[impl CallArgument],
        span: Span,
    ) -> Result<FunctionCandidate, ParseError> {
        let best_candidate = match self.select_overload(name, arguments) {
            OverloadResolution::Selected(candidate) => candidate,
            OverloadResolution::NoViable => {
                let argument_span = self
                    .function_candidates(name)
                    .filter(|&candidate| self.candidate_arity(candidate) == arguments.len())
                    .find_map(|candidate| {
                        arguments.iter().enumerate().find_map(|(index, argument)| {
                            (matches!(
                                self.candidate_mode(candidate, index),
                                ParameterMode::Pointer { .. }
                            ) && self
                                .candidate_conversion(candidate, index, argument)
                                .is_none())
                            .then(|| argument.span())
                        })
                    });
                return Err(ParseError {
                    message: format!("no matching device helper overload `{name}`"),
                    span: argument_span.unwrap_or(span),
                });
            }
            OverloadResolution::Ambiguous => {
                return Err(ParseError {
                    message: format!("ambiguous device helper overload `{name}`"),
                    span,
                })
            }
        };
        match best_candidate {
            FunctionCandidate::Current => Err(ParseError {
                message: String::from("recursive device helper calls are unsupported"),
                span,
            }),
            FunctionCandidate::IntegralDouble { .. } => Err(ParseError {
                message: format!("integral {name} requires unsupported double precision"),
                span,
            }),
            _ => Ok(best_candidate),
        }
    }

    pub(super) fn select_overload(
        &self,
        name: &str,
        arguments: &[impl CallArgument],
    ) -> OverloadResolution {
        let integral_double = self.integral_double_candidate(name, arguments);
        self.select_candidates(
            self.function_candidates(name).chain(integral_double),
            arguments,
        )
    }

    pub(super) fn select_candidates(
        &self,
        candidates: impl Iterator<Item = FunctionCandidate> + Clone,
        arguments: &[impl CallArgument],
    ) -> OverloadResolution {
        let viable_candidates = candidates.filter(|&candidate| {
            self.candidate_arity(candidate) == arguments.len()
                && arguments.iter().enumerate().all(|(index, argument)| {
                    self.candidate_conversion(candidate, index, argument)
                        .is_some()
                })
        });
        select_ranked_candidate(viable_candidates, |left, right| {
            self.better_candidate(left, right, arguments)
        })
    }

    pub(super) fn integral_double_candidate(
        &self,
        name: &str,
        arguments: &[impl CallArgument],
    ) -> Option<FunctionCandidate> {
        if !INTEGRAL_DOUBLE_BUILTINS.contains(&name)
            || arguments.len() != 1
            || !matches!(
                self.global_declarations.get(name),
                Some(&GlobalDeclaration::Functions(_))
            )
        {
            return None;
        }
        let argument_type = arguments[0].ty()?;
        let &TypeInner::Scalar(source) = argument_type.inner_with(&self.module.types) else {
            return None;
        };
        if ![Scalar::BOOL, Scalar::I32, Scalar::U32].contains(&source) {
            return None;
        }
        // An exact ordinary overload wins its tie with the arithmetic template.
        let exact_ordinary = self.function_candidates(name).any(|candidate| {
            matches!(
                candidate,
                FunctionCandidate::Defined(_) | FunctionCandidate::Current
            ) && self.candidate_arity(candidate) == 1
                && self
                    .candidate_type(candidate, 0)
                    .is_some_and(|target| self.module.compare_types(&target, argument_type))
                && self
                    .candidate_conversion(candidate, 0, &arguments[0])
                    .is_some()
        });
        (!exact_ordinary).then_some(FunctionCandidate::IntegralDouble { source })
    }
}
