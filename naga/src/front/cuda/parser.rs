use alloc::{boxed::Box, format, string::String, vec::Vec};

mod absolute_value;
mod atomics;
mod barriers;
mod call_graph;
mod conditionals;
mod constant_evaluation;
mod constants;
mod context;
mod conversions;
mod cooperative_groups;
mod declarations;
mod dim3;
mod dynamic_shared;
mod expressions;
mod float_helpers;
mod function_declarations;
mod functions;
mod inferred_declarations;
mod initializers;
mod loops;
mod null_pointer;
mod operators;
mod parameter_calls;
mod parameter_expansion;
mod pointers;
mod qualifiers;
mod reference_bindings;
mod references;
mod rounding;
mod saturate;
mod scalar_promotions;
mod signatures;
mod sqrtf;
mod statements;
mod structures;
mod switches;
mod templates;
mod trigonometry;
mod types;
mod updates;
mod volatile;

use crate::proc::TypeResolution;
use context::{FunctionContext, FunctionKind};
use cooperative_groups::{Namespace, ThreadBlockValue};
use dynamic_shared::{DynamicShared, DynamicSharedDeclaration};
use function_declarations::{FunctionCall, FunctionDeclaration, IntrinsicDeclaration};
use parameter_calls::{
    CallArgument, CapturedArgument, DeferredCall, FunctionParameterState, ParameterMode,
    SourceParameter,
};
use pointers::{PointerAccess, PointerState, PointerValue};
use qualifiers::Qualifiers;
use reference_bindings::{BoundAddress, BoundReference};
use scalar_promotions::ScalarPromotions;
use types::scalar_resolution;
use types::{DeclarationType, FunctionOverloads, GlobalDeclaration, QualifiedType, TypeSpecifier};
use volatile::VolatileAccesses;

use crate::{
    front::SymbolTable, AddressSpace, Arena, ArraySize, BinaryOperator, Binding, BuiltIn,
    EntryPoint, Expression, FastHashMap, Function, FunctionArgument, GlobalVariable, Handle,
    Literal, LocalVariable, Module, ResourceBinding, Scalar, ScalarKind, ShaderStage, Span,
    Statement, StorageAccess, StructMember, Type, TypeInner, UnaryOperator, VectorSize,
};

use super::{
    lexer::{Lexer, Token},
    number, Options, ParseError,
};

const BUILTIN_INPUTS: [(&str, BuiltIn); 3] = [
    ("threadIdx", BuiltIn::LocalInvocationId),
    ("blockIdx", BuiltIn::WorkGroupId),
    ("gridDim", BuiltIn::NumWorkGroups),
];

#[derive(Clone, Debug)]
enum Symbol {
    Namespace(Namespace),
    ThreadBlock,
    Type(QualifiedType),
    Member,
    PendingReference,
    PendingPointer,
    PendingAuto,
    PendingThreadBlock,
    NullPointer(NullPointerValue),
    Pointer(Handle<PointerValue>),
    DynamicShared(DynamicSharedDeclaration),
    Reference {
        binding: Handle<BoundReference>,
        ty: TypeResolution,
        qualifiers: Qualifiers,
        constant: ConstantValue,
    },
    Array {
        pointer: Handle<Expression>,
        ty: TypeResolution,
        qualifiers: Qualifiers,
    },
    Variable {
        pointer: Handle<Expression>,
        ty: TypeResolution,
        qualifiers: Qualifiers,
    },
    Constant {
        handle: Option<Handle<crate::Constant>>,
        scalar: Scalar,
        literal: Option<Literal>,
    },
    TemplateParameter {
        scalar: Scalar,
        literal: Option<Literal>,
    },
    TemplateTypeParameter {
        ty: QualifiedType,
    },
}

#[derive(Clone, Copy, Debug, Default)]
struct ConstantValue {
    literal: Option<Literal>,
    // Discarded glvalues can qualify without a constant rvalue.
    is_discardable: bool,
    is_null_pointer_constant: bool,
}

impl From<Literal> for ConstantValue {
    fn from(literal: Literal) -> Self {
        Self {
            literal: Some(literal),
            is_discardable: true,
            is_null_pointer_constant: false,
        }
    }
}

impl ConstantValue {
    fn evaluated(literal: Option<Literal>) -> Self {
        literal.map(Self::from).unwrap_or_default()
    }

    const fn non_literal(mut self) -> Self {
        self.is_null_pointer_constant = false;
        self
    }

    fn after(self, earlier: Self) -> Self {
        if earlier.is_discardable {
            self.non_literal()
        } else {
            Self::default()
        }
    }
}

#[derive(Clone, Debug)]
struct ReferenceValue {
    reference: Reference,
    qualifiers: Qualifiers,
    discard_read: bool,
    ty: TypeResolution,
    span: Span,
    constant: ConstantValue,
}

impl ReferenceValue {
    const fn writable(&self) -> bool {
        !self.qualifiers.is_const
    }
}

#[derive(Clone, Copy, Debug)]
enum Reference {
    Pointer(Handle<Expression>),
    PointerAccess(Handle<PointerAccess>),
    Bound(Handle<BoundReference>),
    Conditional(Handle<Option<ConditionalReference>>),
    Constant(Option<Handle<crate::Constant>>),
}

#[derive(Debug)]
struct ReferenceBranch {
    body: crate::Block,
    reference: ReferenceValue,
}

#[derive(Debug)]
struct ConditionalReference {
    // Keep branch-local addresses in their blocks until the reference is consumed.
    condition: Handle<Expression>,
    constant_condition: Option<bool>,
    accept: ReferenceBranch,
    reject: ReferenceBranch,
    depth: u32,
}

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
enum ValueCategory {
    Prvalue,
    Xvalue,
    Lvalue,
}

#[derive(Clone, Debug)]
struct Value {
    category: ValueCategory,
    qualifiers: Qualifiers,
    handle: Handle<Expression>,
    ty: TypeResolution,
    span: Span,
    constant: ConstantValue,
}

#[derive(Clone, Copy, Debug)]
enum SourceType<T> {
    Shader(T),
    NullPointer,
    ThreadBlock,
}

#[derive(Clone, Debug)]
struct NullPointerValue {
    category: ValueCategory,
    qualifiers: Qualifiers,
    span: Span,
    constant: ConstantValue,
    is_constant: bool,
}

#[derive(Debug)]
enum ExpressionValue {
    NullPointer(NullPointerValue),
    Plain(Value),
    Reference(ReferenceValue),
    Pointer(Box<PointerValue>),
}

impl ExpressionValue {
    const fn constant(&self) -> ConstantValue {
        match *self {
            Self::NullPointer(ref value) => value.constant,
            Self::Plain(ref value) => value.constant,
            Self::Reference(ref reference) => reference.constant,
            Self::Pointer(ref pointer) => pointer.constant,
        }
    }

    const fn source_type(&self) -> SourceType<&TypeResolution> {
        match *self {
            Self::NullPointer(_) => SourceType::NullPointer,
            Self::Plain(ref value) => SourceType::Shader(&value.ty),
            Self::Reference(ref reference) => SourceType::Shader(&reference.ty),
            Self::Pointer(ref pointer) => SourceType::Shader(&pointer.ty),
        }
    }

    fn shader_type(&self) -> Result<&TypeResolution, ParseError> {
        match self.source_type() {
            SourceType::Shader(ty) => Ok(ty),
            SourceType::NullPointer | SourceType::ThreadBlock => Err(ParseError {
                message: String::from("nullptr_t values cannot be used as shader values"),
                span: self.span(),
            }),
        }
    }

    const fn span(&self) -> Span {
        match *self {
            Self::NullPointer(ref value) => value.span,
            Self::Plain(ref value) => value.span,
            Self::Reference(ref reference) => reference.span,
            Self::Pointer(ref pointer) => pointer.span,
        }
    }
}

impl From<Value> for ExpressionValue {
    fn from(value: Value) -> Self {
        Self::Plain(value)
    }
}

#[derive(Debug)]
enum ExpressionResult {
    Value(ExpressionValue),
    ThreadBlock(ThreadBlockValue),
    Void(Span),
}

impl From<Value> for ExpressionResult {
    fn from(value: Value) -> Self {
        Self::Value(value.into())
    }
}

impl From<ExpressionValue> for ExpressionResult {
    fn from(value: ExpressionValue) -> Self {
        Self::Value(value)
    }
}

impl ExpressionResult {
    fn require_value(self) -> Result<ExpressionValue, ParseError> {
        match self {
            Self::Value(value) => Ok(value),
            Self::ThreadBlock(value) => Err(ParseError {
                message: String::from("thread_block handles cannot be used as shader values"),
                span: value.span,
            }),
            Self::Void(span) => Err(ParseError {
                message: String::from("void expression cannot be used as a value"),
                span,
            }),
        }
    }
}

struct Kernel<'a> {
    context: Option<FunctionContext<'a>>,
    parameter_state: Option<FunctionParameterState>,
    calls: Vec<FunctionCall>,
}

pub(super) struct Parser<'a> {
    lexer: Lexer<'a>,
    module: Module,
    layouter: crate::proc::Layouter,
    global_declarations: FastHashMap<&'a str, GlobalDeclaration>,
    function: FunctionContext<'a>,
    function_declarations: FastHashMap<Handle<Function>, FunctionDeclaration>,
    intrinsic_declarations: Vec<IntrinsicDeclaration<'a>>,
    parameter_states: FastHashMap<Handle<Function>, FunctionParameterState>,
    parameter_expansion_budget: parameter_expansion::ExpansionBudget,
    atomic_storage: Option<atomics::AtomicStorage>,
    has_atomics: bool,
    has_helper_barriers: bool,
    kernels: Vec<Kernel<'a>>,
    sqrtf_function: Option<Handle<Function>>,
    float_math_functions: [Option<Handle<Function>>; 3],
    trigonometry_function: Option<Handle<Function>>,
    structures: FastHashMap<Handle<Type>, structures::Structure>,
    dim3_type: Option<Handle<Type>>,
    uint3_type: Option<Handle<Type>>,
    next_structure_id: u32,
    helper_builtin_globals: [Option<Handle<GlobalVariable>>; 3],
    workgroup_size: [u32; 3],
    dynamic_shared_memory_size: u32,
    dynamic_shared: DynamicShared<'a>,
    volatile_globals: FastHashMap<Handle<GlobalVariable>, Span>,
    templates: templates::Templates<'a>,
}

impl<'a> Parser<'a> {
    pub fn new(lexer: Lexer<'a>, options: &Options) -> Self {
        Self {
            lexer,
            module: Module::default(),
            layouter: crate::proc::Layouter::default(),
            global_declarations: functions::builtin_declarations(),
            function: FunctionContext::new(FunctionKind::Kernel),
            function_declarations: FastHashMap::default(),
            intrinsic_declarations: Vec::new(),
            parameter_states: FastHashMap::default(),
            parameter_expansion_budget: parameter_expansion::ExpansionBudget::default(),
            atomic_storage: None,
            has_atomics: false,
            has_helper_barriers: false,
            kernels: Vec::new(),
            sqrtf_function: None,
            float_math_functions: [None; 3],
            trigonometry_function: None,
            structures: FastHashMap::default(),
            dim3_type: None,
            uint3_type: None,
            next_structure_id: 0,
            helper_builtin_globals: [None; 3],
            workgroup_size: options.workgroup_size,
            dynamic_shared_memory_size: options.dynamic_shared_memory_size,
            dynamic_shared: DynamicShared::default(),
            volatile_globals: FastHashMap::default(),
            templates: templates::Templates::default(),
        }
    }

    pub fn parse(mut self) -> Result<Module, ParseError> {
        while self.lexer.peek()?.0 != Token::End {
            if self.lexer.peek()?.0 == Token::Word("template") {
                self.template_declaration()?;
            } else if self.starts_dynamic_shared_declaration()? {
                self.dynamic_shared_declaration(true)?;
            } else if self.lexer.peek()?.0 == Token::Word("struct") {
                self.structure_declaration(true)?;
            } else if self.starts_alias()? {
                self.alias_declaration(true)?;
            } else if self.starts_constexpr_declaration()? {
                self.global_constant_declaration()?;
            } else {
                self.function_definition()?;
            }
        }
        self.finish_templates()?;
        if self.kernels.is_empty() {
            return self.fail("expected a CUDA kernel definition");
        }
        self.finish_kernels()?;
        self.finish_functions()?;
        self.upgrade_atomic_storage()?;
        self.upgrade_volatile_storage()?;
        self.check_dynamic_shared_views()?;
        self.check_workgroup_barriers()?;
        self.promote_scalar_locals()?;
        // Remove call results from source statements discarded after a jump.
        let keep_unused = if self.has_helper_barriers {
            crate::compact::KeepUnused::No
        } else {
            crate::compact::KeepUnused::Yes
        };
        crate::compact::compact(&mut self.module, keep_unused);
        Ok(self.module)
    }

    fn parameter(&mut self, parameter_index: u32) -> Result<(), ParseError> {
        let signatures::ParameterType {
            ty:
                QualifiedType {
                    ty: specifier,
                    qualifiers,
                },
            pointer_qualifiers: explicit_pointer_qualifiers,
            is_reference,
            type_span,
            declarator_span: pointer_span,
        } = self.parameter_type()?;
        if matches!(specifier, TypeSpecifier::NullPointer) {
            return self.null_pointer_parameter(
                qualifiers,
                is_reference,
                explicit_pointer_qualifiers.is_some(),
                type_span,
            );
        }
        if matches!(specifier, TypeSpecifier::ThreadBlock) {
            if qualifiers.is_volatile {
                return self.fail("volatile thread_block parameters are unsupported");
            }
            return self.thread_block_parameter(type_span);
        }
        let (ty, qualifiers, aliased_pointer_qualifiers) = match specifier {
            TypeSpecifier::Pointer {
                pointee,
                pointee_qualifiers,
            } => (
                TypeResolution::Handle(pointee),
                pointee_qualifiers,
                Some(qualifiers),
            ),
            _ => (self.lower_type(specifier, type_span)?, qualifiers, None),
        };
        let is_const = qualifiers.is_const;
        if self.function.kind == FunctionKind::Kernel
            && self
                .module
                .compare_types(&ty, &scalar_resolution(Scalar::BOOL))
        {
            return self.fail("boolean kernel parameters are unsupported");
        }
        let explicit_pointer = explicit_pointer_qualifiers.is_some();
        if explicit_pointer && aliased_pointer_qualifiers.is_some() {
            return self.fail("nested pointer parameters are unsupported");
        }
        let is_pointer = explicit_pointer || aliased_pointer_qualifiers.is_some();
        let pointer_qualifiers = match aliased_pointer_qualifiers {
            Some(qualifiers) => qualifiers,
            None if explicit_pointer => explicit_pointer_qualifiers.unwrap(),
            None => Qualifiers::NONE,
        };
        let pointer_const = pointer_qualifiers.is_const;
        self.note_volatile_parameter_object(pointer_qualifiers, pointer_span)?;
        if aliased_pointer_qualifiers.is_some() && self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("arrays of pointers are unsupported");
        }
        if self.function.kind == FunctionKind::Device && is_pointer {
            if is_reference
                || matches!(
                    self.lexer.peek()?.0,
                    Token::Operation('*' | '&') | Token::LogicalOperation('&') | Token::Paren('(')
                )
            {
                return self
                    .fail("nested pointer and pointer reference declarators are unsupported");
            }
            self.activate_parameter_expansion(pointer_span)?;
            let base = self.type_handle(&ty, type_span);
            let pointer_ty = self.pointer_type(base, pointer_span);
            let name = if matches!(
                self.lexer.peek()?.0,
                Token::Separator(',') | Token::Paren(')')
            ) {
                None
            } else {
                let (name, span) = self.identifier()?;
                self.check_name(name, span)?;
                if self.lexer.peek()?.0 == Token::Paren('[') {
                    return self.fail("arrays of pointers are unsupported");
                }
                Some(name)
            };
            return self.device_parameter(
                name,
                type_span,
                &pointer_ty,
                pointer_const,
                ParameterMode::Pointer { qualifiers },
            );
        }
        let mode = if is_reference {
            if self.function.kind == FunctionKind::Kernel {
                return Err(ParseError {
                    message: String::from("kernel reference parameters are unsupported"),
                    span: pointer_span,
                });
            }
            self.activate_parameter_expansion(pointer_span)?;
            ParameterMode::Reference { qualifiers }
        } else {
            ParameterMode::Value
        };
        if self.function.kind == FunctionKind::Kernel
            && !is_pointer
            && !matches!(specifier, TypeSpecifier::Scalar(_))
        {
            return Err(ParseError {
                message: String::from(
                    if matches!(specifier, TypeSpecifier::Dim3 | TypeSpecifier::Structure(_)) {
                        "structure kernel value parameters are unsupported"
                    } else {
                        "vector kernel parameters are unsupported"
                    },
                ),
                span: type_span,
            });
        }
        if self.function.kind == FunctionKind::Device && self.lexer.peek()?.0 == Token::Paren('[') {
            return self.array_parameter(None, type_span, &ty, qualifiers, mode);
        }
        if self.function.kind == FunctionKind::Device
            && matches!(
                self.lexer.peek()?.0,
                Token::Separator(',') | Token::Paren(')')
            )
        {
            if mode == ParameterMode::Value {
                self.note_volatile_parameter_object(qualifiers, type_span)?;
            }
            return self.device_parameter(None, type_span, &ty, is_const, mode);
        }
        let (name, span) = self.identifier()?;
        self.check_name(name, span)?;
        if aliased_pointer_qualifiers.is_some() && self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("arrays of pointers are unsupported");
        }
        if self.function.kind == FunctionKind::Device {
            if self.lexer.peek()?.0 == Token::Paren('[') {
                return self.array_parameter(Some(name), span, &ty, qualifiers, mode);
            }
            if mode == ParameterMode::Value {
                self.note_volatile_parameter_object(qualifiers, type_span)?;
            }
            return self.device_parameter(Some(name), span, &ty, is_const, mode);
        }
        if !is_pointer {
            self.note_volatile_parameter_object(qualifiers, type_span)?;
            return self.value_parameter(parameter_index, name, span, &ty, is_const);
        }
        let base = self.type_handle(&ty, span);
        let array_ty = self.array_type(base, ArraySize::Dynamic, type_span, span)?;
        let access = if is_const {
            StorageAccess::LOAD
        } else {
            StorageAccess::LOAD | StorageAccess::STORE
        };
        let global = self.module.global_variables.append(
            GlobalVariable {
                name: Some(String::from(name)),
                space: AddressSpace::Storage { access },
                binding: Some(ResourceBinding {
                    group: 0,
                    binding: parameter_index,
                }),
                ty: array_ty,
                init: None,
                memory_decorations: Default::default(),
            },
            span,
        );
        let pointer = self.append(Expression::GlobalVariable(global), span)?;
        let pointer = self.decay_array(ReferenceValue {
            discard_read: true,
            reference: Reference::Pointer(pointer),
            qualifiers,
            ty: TypeResolution::Handle(array_ty),
            span,
            constant: ConstantValue::default(),
        })?;
        let pointer = self.source_pointer_variable(name, pointer, pointer_const, span)?;
        let pointer = self.retain_pointer_symbol(pointer)?;
        self.insert_symbol(name, Symbol::Pointer(pointer), span)?;
        Ok(())
    }

    fn value_parameter(
        &mut self,
        parameter_index: u32,
        name: &'a str,
        span: Span,
        parameter_ty: &TypeResolution,
        is_const: bool,
    ) -> Result<(), ParseError> {
        let value_ty = self.type_handle(parameter_ty, span);
        let ty = self.module.types.insert(
            Type {
                name: None,
                inner: TypeInner::Struct {
                    members: alloc::vec![StructMember {
                        name: Some(String::from("value")),
                        ty: value_ty,
                        binding: None,
                        offset: 0,
                    }],
                    span: 16,
                },
            },
            span,
        );
        let global = self.module.global_variables.append(
            GlobalVariable {
                name: Some(String::from(name)),
                space: AddressSpace::Uniform,
                binding: Some(ResourceBinding {
                    group: 0,
                    binding: parameter_index,
                }),
                ty,
                init: None,
                memory_decorations: Default::default(),
            },
            span,
        );
        let base = self.append(Expression::GlobalVariable(global), span)?;
        let field = self.append(Expression::AccessIndex { base, index: 0 }, span)?;
        let value = self.append(Expression::Load { pointer: field }, span)?;
        self.initialize_parameter(name, span, parameter_ty, is_const, value)
    }

    fn initialize_parameter(
        &mut self,
        name: &'a str,
        span: Span,
        ty: &TypeResolution,
        is_const: bool,
        value: Handle<Expression>,
    ) -> Result<(), ParseError> {
        let value_ty = self.type_handle(ty, span);
        let local = self.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from(name)),
                ty: value_ty,
                init: None,
            },
            span,
        );
        let pointer = self.append(Expression::LocalVariable(local), span)?;
        self.push_statement(Statement::Store { pointer, value }, span);
        self.insert_symbol(
            name,
            Symbol::Variable {
                pointer,
                ty: ty.clone(),
                qualifiers: Qualifiers {
                    is_const,
                    ..Qualifiers::NONE
                },
            },
            span,
        )?;
        Ok(())
    }

    fn array_element(
        &mut self,
        mut base: Handle<Expression>,
        mut element_ty: TypeResolution,
        span: Span,
    ) -> Result<(Handle<Expression>, TypeResolution, bool), ParseError> {
        let (array_ty, is_pending) = match self.function.ir.expressions[base] {
            Expression::LocalVariable(local) => (
                self.function.ir.local_variables[local].ty,
                self.function.pending_array == Some(local),
            ),
            Expression::GlobalVariable(global) => (self.module.global_variables[global].ty, false),
            _ => unreachable!(),
        };
        let dynamic = matches!(self.function.ir.expressions[base], Expression::GlobalVariable(global) if self.is_dynamic_shared_global(global));
        let mut count = if is_pending {
            None
        } else {
            match self.module.types[array_ty].inner {
                TypeInner::Array {
                    size: ArraySize::Constant(count),
                    ..
                } => Some(count),
                _ => None,
            }
        };
        let mut is_discardable = self.pointer_constant(base).is_discardable;
        loop {
            self.lexer.expect_span(Token::Paren('['))?;
            let index = if dynamic {
                self.dynamic_shared_index()?
            } else {
                let index = self.expression(0)?;
                self.rvalue(index)?
            };
            let scalar = self.require_scalar_type(&index.ty, index.span)?;
            if !matches!(scalar.kind, ScalarKind::Sint | ScalarKind::Uint) {
                return Err(ParseError {
                    message: String::from("array index must be an integer"),
                    span: index.span,
                });
            }
            let end = self.lexer.expect_span(Token::Paren(']'))?;
            is_discardable = if dynamic {
                is_discardable && index.constant.is_discardable
            } else {
                Self::constant_array_address(is_discardable, count, index.constant)
            };
            base = self.append(
                Expression::Access {
                    base,
                    index: index.handle,
                },
                span.until(&end),
            )?;
            match *element_ty.inner_with(&self.module.types) {
                TypeInner::Array {
                    base: nested_element,
                    size: ArraySize::Constant(nested_count),
                    ..
                } => {
                    if self.lexer.peek()?.0 != Token::Paren('[') {
                        return Ok((base, element_ty, is_discardable));
                    }
                    element_ty = TypeResolution::Handle(nested_element);
                    count = Some(nested_count);
                }
                _ => return Ok((base, element_ty, is_discardable)),
            }
        }
    }

    fn builtin(&mut self, name: &str, start: Span) -> Result<Value, ParseError> {
        self.lexer.expect_span(Token::Separator('.'))?;
        let (component, span) = self.identifier()?;
        let index = match component {
            "x" => 0,
            "y" => 1,
            "z" => 2,
            _ => {
                return Err(ParseError {
                    message: String::from("CUDA dimension must be x, y, or z"),
                    span,
                })
            }
        };
        let span = start.until(&span);
        let handle = if name == "blockDim" {
            self.append(
                Expression::Literal(Literal::U32(self.workgroup_size[index as usize])),
                span,
            )?
        } else {
            let slot = match name {
                "threadIdx" => 0,
                "blockIdx" => 1,
                _ => 2,
            };
            let base = if self.function.kind == FunctionKind::Device {
                self.helper_builtin_value(slot, span)?
            } else {
                self.builtin_input(slot, span)?
            };
            self.append(Expression::AccessIndex { base, index }, span)?
        };
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty: scalar_resolution(Scalar::U32),
            span,
        })
    }

    fn builtin_vector_type(&mut self, span: Span) -> Handle<Type> {
        self.module.types.insert(
            Type {
                name: None,
                inner: TypeInner::Vector {
                    size: VectorSize::Tri,
                    scalar: Scalar::U32,
                },
            },
            span,
        )
    }

    fn builtin_input(&mut self, slot: usize, span: Span) -> Result<Handle<Expression>, ParseError> {
        if let Some(argument) = self.function.builtin_arguments[slot] {
            return Ok(argument);
        }
        let (name, builtin) = BUILTIN_INPUTS[slot];
        let ty = self.builtin_vector_type(span);
        let argument_index = self.function.ir.arguments.len() as u32;
        self.function.ir.arguments.push(FunctionArgument {
            name: Some(String::from(name)),
            ty,
            binding: Some(Binding::BuiltIn(builtin)),
        });
        let argument = self.append(Expression::FunctionArgument(argument_index), span)?;
        self.function.builtin_arguments[slot] = Some(argument);
        Ok(argument)
    }

    fn helper_builtin_value(
        &mut self,
        slot: usize,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let global_handle = if let Some(global_handle) = self.helper_builtin_globals[slot] {
            global_handle
        } else {
            let ty = self.builtin_vector_type(span);
            let global_handle = self.module.global_variables.append(
                GlobalVariable {
                    name: Some(String::from(BUILTIN_INPUTS[slot].0)),
                    space: AddressSpace::Private,
                    binding: None,
                    ty,
                    init: None,
                    memory_decorations: Default::default(),
                },
                span,
            );
            self.helper_builtin_globals[slot] = Some(global_handle);
            global_handle
        };
        let pointer = self.append(Expression::GlobalVariable(global_handle), span)?;
        self.append(Expression::Load { pointer }, span)
    }

    fn initialize_helper_builtins(&mut self) -> Result<(), ParseError> {
        for (slot, global_handle) in self.helper_builtin_globals.into_iter().enumerate() {
            let Some(global_handle) = global_handle else {
                continue;
            };
            if self.function.initialized_helper_builtins[slot] {
                continue;
            }
            let span = self.module.global_variables.get_span(global_handle);
            let value = self.builtin_input(slot, span)?;
            let pointer = self.append(Expression::GlobalVariable(global_handle), span)?;
            self.push_statement(Statement::Store { pointer, value }, span);
            self.function.initialized_helper_builtins[slot] = true;
        }
        Ok(())
    }

    fn finish_kernels(&mut self) -> Result<(), ParseError> {
        for index in 0..self.kernels.len() {
            self.parameter_expansion_budget
                .charge_work(1, self.lexer.span_from(0))?;
            self.finish_kernel(index)?;
        }
        Ok(())
    }

    fn finish_kernel(&mut self, index: usize) -> Result<(), ParseError> {
        self.function = self.kernels[index].context.take().unwrap();
        if self
            .helper_builtin_globals
            .iter()
            .enumerate()
            .any(|(slot, global)| {
                global.is_some() && !self.function.initialized_helper_builtins[slot]
            })
        {
            let (_, initializers) = self.capture_block(Self::initialize_helper_builtins)?;
            self.prepend_block(initializers);
        }
        self.kernels[index].calls = core::mem::take(&mut self.function.calls);
        if self.parameter_state_needed() {
            let span = self
                .function
                .ir
                .body
                .span_iter()
                .next()
                .map_or(Span::UNDEFINED, |(_, span)| *span);
            self.prepare_parameter_bindings(span)?;
            self.parameter_expansion_budget
                .charge_slice::<u32>(self.function.expression_graph_depths.len(), span)?;
            self.kernels[index].parameter_state = Some(self.function.take_parameter_state());
        }
        self.module.entry_points[index].function = core::mem::take(&mut self.function.ir);
        Ok(())
    }

    fn number(&mut self, text: &str, span: Span) -> Result<Value, ParseError> {
        let invalid = || ParseError {
            message: String::from("unsupported or out-of-range numeric literal"),
            span,
        };
        let literal = number::parse(text).ok_or_else(invalid)?;
        let handle = self.append(Expression::Literal(literal), span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue {
                is_null_pointer_constant: matches!(literal, Literal::I32(0) | Literal::U32(0)),
                ..literal.into()
            },
            handle,
            ty: scalar_resolution(literal.scalar()),
            span,
        })
    }

    fn scalar_handle(&mut self, scalar: Scalar, span: Span) -> Handle<Type> {
        self.type_handle(&scalar_resolution(scalar), span)
    }

    fn append(
        &mut self,
        expression: Expression,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        if self.function.parameter_state_charged {
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<Expression>(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<u32>(1, span)?;
        }
        let depth = expression_depth(&expression, &self.function.expression_graph_depths);
        if depth > 64 {
            return Err(ParseError {
                message: String::from("CUDA expression graph depth limit exceeded"),
                span,
            });
        }
        let pre_emitted = expression.needs_pre_emit();
        if pre_emitted {
            self.function
                .ir
                .body
                .extend(self.function.emitter.finish(&self.function.ir.expressions));
        }
        let handle = self.function.ir.expressions.append(expression, span);
        self.function.expression_graph_depths.push(depth);
        if pre_emitted {
            self.function.emitter.start(&self.function.ir.expressions);
        }
        Ok(handle)
    }

    fn check_name(&self, name: &str, span: Span) -> Result<(), ParseError> {
        if Self::reserved_name(name)
            || matches!(
                self.function.symbol_table.lookup(name),
                Some(Symbol::TemplateParameter { .. } | Symbol::TemplateTypeParameter { .. })
            )
        {
            Err(ParseError {
                message: format!("duplicate or reserved name `{name}`"),
                span,
            })
        } else {
            Ok(())
        }
    }

    fn reserved_name(name: &str) -> bool {
        matches!(
            name,
            "threadIdx"
                | "blockIdx"
                | "gridDim"
                | "blockDim"
                | "const"
                | "float"
                | "int"
                | "unsigned"
                | "void"
                | "return"
                | "extern"
                | "__global__"
                | "__device__"
                | "__forceinline__"
                | "__noinline__"
                | "__syncthreads"
        ) || [
            "alignas",
            "alignof",
            "and",
            "and_eq",
            "asm",
            "auto",
            "bitand",
            "bitor",
            "bool",
            "break",
            "case",
            "catch",
            "char",
            "char8_t",
            "char16_t",
            "char32_t",
            "class",
            "compl",
            "concept",
            "consteval",
            "constexpr",
            "constinit",
            "const_cast",
            "continue",
            "co_await",
            "co_return",
            "co_yield",
            "decltype",
            "default",
            "delete",
            "do",
            "double",
            "dynamic_cast",
            "else",
            "enum",
            "explicit",
            "export",
            "false",
            "for",
            "friend",
            "goto",
            "if",
            "inline",
            "long",
            "mutable",
            "namespace",
            "new",
            "noexcept",
            "not",
            "not_eq",
            "nullptr",
            "operator",
            "or",
            "or_eq",
            "private",
            "protected",
            "public",
            "register",
            "reinterpret_cast",
            "requires",
            "short",
            "signed",
            "sizeof",
            "static",
            "static_assert",
            "static_cast",
            "struct",
            "switch",
            "template",
            "this",
            "thread_local",
            "throw",
            "true",
            "try",
            "typedef",
            "typeid",
            "typename",
            "union",
            "using",
            "virtual",
            "volatile",
            "wchar_t",
            "while",
            "xor",
            "xor_eq",
            "__device__",
            "__host__",
            "__shared__",
            "__constant__",
            "__managed__",
            "__restrict",
            "__restrict__",
            "__launch_bounds__",
        ]
        .contains(&name)
    }

    fn insert_symbol(
        &mut self,
        name: &'a str,
        symbol: Symbol,
        span: Span,
    ) -> Result<(), ParseError> {
        if self.function.symbol_table.add(name, symbol).is_some() {
            Err(ParseError {
                message: format!("duplicate or reserved name `{name}`"),
                span,
            })
        } else {
            Ok(())
        }
    }

    fn lookup_symbol(&self, name: &str) -> Option<Symbol> {
        self.function
            .symbol_table
            .lookup(name)
            .cloned()
            .or_else(|| match self.global_declarations.get(name) {
                Some(&GlobalDeclaration::Namespace(namespace)) => {
                    Some(Symbol::Namespace(namespace))
                }
                Some(&GlobalDeclaration::PendingAuto) => Some(Symbol::PendingAuto),
                Some(&GlobalDeclaration::NullPointer(ref value)) => {
                    Some(Symbol::NullPointer(value.clone()))
                }
                Some(&GlobalDeclaration::DynamicShared(declaration)) => {
                    Some(Symbol::DynamicShared(declaration))
                }
                Some(&GlobalDeclaration::Constant {
                    handle,
                    scalar,
                    literal,
                }) => Some(Symbol::Constant {
                    handle,
                    scalar,
                    literal,
                }),
                _ => None,
            })
    }

    fn take_ident(&mut self, identifier: &str) -> Result<bool, ParseError> {
        self.lexer.next_if(Token::Word(identifier))
    }

    fn expect_ident(&mut self, identifier: &str) -> Result<(), ParseError> {
        self.lexer.expect_span(Token::Word(identifier))?;
        Ok(())
    }

    fn identifier(&mut self) -> Result<(&'a str, Span), ParseError> {
        let token = self.lexer.next()?;
        if let Token::Word(name) = token.0 {
            Ok((name, token.1))
        } else {
            Err(ParseError {
                message: String::from("expected an identifier"),
                span: token.1,
            })
        }
    }

    fn fail<T>(&mut self, message: &str) -> Result<T, ParseError> {
        Err(ParseError {
            message: String::from(message),
            span: self.lexer.peek()?.1,
        })
    }
}

pub(super) fn expression_depth(expression: &Expression, depths: &[u32]) -> u32 {
    match *expression {
        Expression::Unary { expr: operand, .. }
        | Expression::As { expr: operand, .. }
        | Expression::AccessIndex { base: operand, .. }
        | Expression::Load { pointer: operand } => depths[operand.index()] + 1,
        Expression::Binary { left, right, .. }
        | Expression::Access {
            base: left,
            index: right,
        } => depths[left.index()].max(depths[right.index()]) + 1,
        Expression::Compose { ref components, .. } => {
            components
                .iter()
                .map(|handle| depths[handle.index()])
                .max()
                .unwrap_or(0)
                + 1
        }
        Expression::Math {
            arg,
            arg1,
            arg2,
            arg3,
            ..
        } => {
            let mut depth = depths[arg.index()];
            for operand in [arg1, arg2, arg3].into_iter().flatten() {
                depth = depth.max(depths[operand.index()]);
            }
            depth + 1
        }
        Expression::Select {
            condition,
            accept,
            reject,
        } => {
            depths[condition.index()]
                .max(depths[accept.index()])
                .max(depths[reject.index()])
                + 1
        }
        _ => 0,
    }
}
