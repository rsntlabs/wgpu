use super::*;

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub(super) enum TypeSpecifier {
    NullPointer,
    TemplateParameter(u32),
    ThreadBlock,
    Dim3,
    Scalar(Scalar),
    Long {
        kind: ScalarKind,
    },
    Vector {
        component_count: u8,
        scalar: Scalar,
    },
    Structure(Handle<Type>),
    Array(Handle<Type>),
    Pointer {
        pointee: Handle<Type>,
        pointee_qualifiers: Qualifiers,
    },
}

pub(super) const VECTOR_TYPES: [(&str, &str, u8, Scalar); 20] = [
    ("float2", "make_float2", 2, Scalar::F32),
    ("float3", "make_float3", 3, Scalar::F32),
    ("float4", "make_float4", 4, Scalar::F32),
    ("int2", "make_int2", 2, Scalar::I32),
    ("int3", "make_int3", 3, Scalar::I32),
    ("int4", "make_int4", 4, Scalar::I32),
    ("uint2", "make_uint2", 2, Scalar::U32),
    ("uint3", "make_uint3", 3, Scalar::U32),
    ("uint4", "make_uint4", 4, Scalar::U32),
    ("short2", "make_short2", 2, Scalar::I16),
    ("short3", "make_short3", 3, Scalar::I16),
    ("short4", "make_short4", 4, Scalar::I16),
    ("ushort2", "make_ushort2", 2, Scalar::U16),
    ("ushort3", "make_ushort3", 3, Scalar::U16),
    ("ushort4", "make_ushort4", 4, Scalar::U16),
    ("float1", "make_float1", 1, Scalar::F32),
    ("int1", "make_int1", 1, Scalar::I32),
    ("uint1", "make_uint1", 1, Scalar::U32),
    ("short1", "make_short1", 1, Scalar::I16),
    ("ushort1", "make_ushort1", 1, Scalar::U16),
];

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
pub(super) struct QualifiedType {
    pub ty: TypeSpecifier,
    pub qualifiers: Qualifiers,
}

pub(super) enum DeclarationType {
    Explicit(QualifiedType),
    Inferred { qualifiers: Qualifiers },
}

#[derive(Clone, Debug)]
pub(super) enum GlobalDeclaration {
    NullPointer(NullPointerValue),
    Namespace(Namespace),
    PendingAuto,
    Type(QualifiedType),
    Functions(FunctionOverloads),
    Kernel,
    DynamicShared(DynamicSharedDeclaration),
    ConstantMemory(ConstantMemoryDeclaration),
    Constant {
        handle: Option<Handle<crate::Constant>>,
        ty: TypeResolution,
        literal: Option<Literal>,
    },
}

#[derive(Clone, Debug, Default)]
pub(super) struct FunctionOverloads {
    pub(super) functions: Vec<Handle<Function>>,
    pub(super) templates: Vec<usize>,
}

#[derive(Default)]
pub(super) struct IntegerSpecifiers {
    seen_int: bool,
    seen_short: bool,
    long_count: u8,
    seen_signed: bool,
    seen_unsigned: bool,
}

impl IntegerSpecifiers {
    pub(super) const fn is_empty(&self) -> bool {
        !self.seen_int
            && !self.seen_short
            && self.long_count == 0
            && !self.seen_signed
            && !self.seen_unsigned
    }

    pub(super) fn consume(&mut self, specifier: &str) -> Option<SourceScalar> {
        match specifier {
            "int" if !self.seen_int => self.seen_int = true,
            "short" if !self.seen_short && self.long_count == 0 => self.seen_short = true,
            "long" if !self.seen_short && self.long_count < 2 => self.long_count += 1,
            "signed" if !self.seen_signed && !self.seen_unsigned => self.seen_signed = true,
            "unsigned" if !self.seen_unsigned && !self.seen_signed => self.seen_unsigned = true,
            _ => return None,
        }
        let scalar = match (self.seen_unsigned, self.seen_short, self.long_count) {
            (false, _, 1 | 2) => Scalar::I64,
            (true, _, 1 | 2) => Scalar::U64,
            (false, false, _) => Scalar::I32,
            (false, true, _) => Scalar::I16,
            (true, false, _) => Scalar::U32,
            (true, true, _) => Scalar::U16,
        };
        Some(if self.long_count == 1 {
            SourceScalar::Long(scalar.kind)
        } else {
            SourceScalar::Scalar(scalar)
        })
    }
}

impl TypeSpecifier {
    pub(super) const fn from_scalar(scalar: SourceScalar) -> Self {
        match scalar {
            SourceScalar::Scalar(scalar) => Self::Scalar(scalar),
            SourceScalar::Long(kind) => Self::Long { kind },
        }
    }

    pub(super) const fn source_scalar(self) -> Option<SourceScalar> {
        match self {
            Self::Scalar(scalar) => Some(SourceScalar::Scalar(scalar)),
            Self::Long { kind } => Some(SourceScalar::Long(kind)),
            _ => None,
        }
    }
}

fn type_name(
    name: &str,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
) -> Option<QualifiedType> {
    let scalar = match name {
        "bool" => Scalar::BOOL,
        "float" => Scalar::F32,
        "int" | "signed" => Scalar::I32,
        "short" => Scalar::I16,
        "unsigned" => Scalar::U32,
        "long" => {
            return Some(QualifiedType {
                ty: TypeSpecifier::Long {
                    kind: ScalarKind::Sint,
                },
                qualifiers: Qualifiers::NONE,
            })
        }
        _ => {
            return match symbols.lookup(name) {
                Some(&Symbol::Type(ref ty)) => Some(ty.clone()),
                Some(&Symbol::TemplateTypeParameter { ref ty }) => Some(ty.clone()),
                Some(_) => None,
                None => match globals.get(name) {
                    Some(&GlobalDeclaration::Type(ref ty)) => Some(ty.clone()),
                    _ => None,
                },
            };
        }
    };
    Some(QualifiedType {
        ty: TypeSpecifier::Scalar(scalar),
        qualifiers: Qualifiers::NONE,
    })
}

pub(super) fn pointer_qualifiers(lexer: &mut Lexer<'_>) -> Result<Qualifiers, ParseError> {
    declaration_qualifiers(lexer, Qualifiers::NONE, true)
}

pub(super) fn declaration_qualifiers(
    lexer: &mut Lexer<'_>,
    mut qualifiers: Qualifiers,
    allow_restrict: bool,
) -> Result<Qualifiers, ParseError> {
    loop {
        let token = lexer.peek()?;
        match token.0 {
            Token::Word("const") => {
                if qualifiers.is_const {
                    return Err(ParseError {
                        message: String::from("duplicate const qualifier"),
                        span: token.1,
                    });
                }
                qualifiers.is_const = true;
            }
            Token::Word("volatile") => {
                if qualifiers.is_volatile {
                    return Err(ParseError {
                        message: String::from("duplicate volatile qualifier"),
                        span: token.1,
                    });
                }
                qualifiers.is_volatile = true;
            }
            Token::Word("__restrict__" | "__restrict") if allow_restrict => {}
            _ => return Ok(qualifiers),
        }
        lexer.next()?;
    }
}

pub(super) fn pointer_declarator(
    lexer: &mut Lexer<'_>,
    ty: TypeSpecifier,
) -> Result<Option<Qualifiers>, ParseError> {
    if !lexer.next_if(Token::Operation('*'))? {
        return Ok(None);
    }
    if matches!(ty, TypeSpecifier::Pointer { .. }) {
        return Err(ParseError {
            message: String::from("nested pointer types are unsupported"),
            span: lexer.peek()?.1,
        });
    }
    let qualifiers = pointer_qualifiers(lexer)?;
    if matches!(
        lexer.peek()?.0,
        Token::Operation('*' | '&') | Token::LogicalOperation('&')
    ) {
        return Err(ParseError {
            message: String::from("nested pointer and pointer reference types are unsupported"),
            span: lexer.peek()?.1,
        });
    }
    Ok(Some(qualifiers))
}

struct TypeContext<'context, 'source> {
    types: &'context crate::arena::UniqueArena<Type>,
    global_variables: &'context Arena<GlobalVariable>,
    function: &'context FunctionContext<'source>,
    long_types: &'context [Option<Handle<Type>>; 2],
    dim3_type: Option<Handle<Type>>,
    structures: &'context FastHashMap<Handle<Type>, structures::Structure>,
}

impl TypeContext<'_, '_> {
    fn object_type(&self, ty: &TypeResolution, span: Span) -> Result<TypeSpecifier, ParseError> {
        let invalid = || ParseError {
            message: String::from("decltype requires a supported non-reference value object"),
            span,
        };
        match *ty.inner_with(self.types) {
            TypeInner::Scalar(scalar) => {
                if ty
                    .handle()
                    .is_some_and(|handle| self.long_types.contains(&Some(handle)))
                {
                    Ok(TypeSpecifier::Long { kind: scalar.kind })
                } else {
                    Ok(TypeSpecifier::Scalar(scalar))
                }
            }
            TypeInner::Vector { size, scalar } => Ok(TypeSpecifier::Vector {
                component_count: u8::from(size),
                scalar,
            }),
            TypeInner::Struct { .. } => {
                let handle = ty.handle().ok_or_else(invalid)?;
                if Some(handle) == self.dim3_type {
                    return Ok(TypeSpecifier::Dim3);
                }
                if self.structures.contains_key(&handle) {
                    return Ok(TypeSpecifier::Structure(handle));
                }
                let name = self.types[handle].name.as_deref();
                VECTOR_TYPES
                    .iter()
                    .find_map(|&(vector_name, _, component_count, scalar)| {
                        (Some(vector_name) == name).then_some(TypeSpecifier::Vector {
                            component_count,
                            scalar,
                        })
                    })
                    .ok_or_else(invalid)
            }
            _ => Err(invalid()),
        }
    }
}

fn decltype_operand_type(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    context: &TypeContext<'_, '_>,
) -> Result<(QualifiedType, Span), ParseError> {
    lexer.expect_span(Token::Paren('('))?;
    let (operand, span) = lexer.next()?;
    let invalid = || ParseError {
        message: String::from(
            "decltype requires nullptr or an unparenthesized non-reference value object",
        ),
        span,
    };
    let Token::Word(name) = operand else {
        return Err(invalid());
    };
    let end = lexer.expect_span(Token::Paren(')'))?;
    if name == "nullptr" {
        return Ok((
            QualifiedType {
                ty: TypeSpecifier::NullPointer,
                qualifiers: Qualifiers::NONE,
            },
            end,
        ));
    }
    let (ty, qualifiers) = match symbols.lookup(name) {
        Some(&Symbol::Pointer(pointer)) => {
            let pointer = &context.function.pointer_symbols[pointer];
            let pointers::PointerValueCategory::Variable { writable, .. } = pointer.category else {
                return Err(invalid());
            };
            let TypeInner::Pointer { base, .. } = *pointer.ty.inner_with(context.types) else {
                return Err(invalid());
            };
            return Ok((
                QualifiedType {
                    ty: TypeSpecifier::Pointer {
                        pointee: base,
                        pointee_qualifiers: pointer.qualifiers,
                    },
                    qualifiers: Qualifiers {
                        is_const: !writable,
                        is_volatile: false,
                    },
                },
                end,
            ));
        }
        Some(&Symbol::Array {
            pointer,
            qualifiers,
            ..
        }) => {
            let array = match context.function.ir.expressions[pointer] {
                Expression::LocalVariable(local) => {
                    if context.function.pending_array == Some(local) {
                        return Err(invalid());
                    }
                    context.function.ir.local_variables[local].ty
                }
                Expression::GlobalVariable(global) => context.global_variables[global].ty,
                _ => return Err(invalid()),
            };
            if !matches!(
                context.types[array].inner,
                TypeInner::Array {
                    size: ArraySize::Constant(_),
                    ..
                }
            ) {
                return Err(invalid());
            }
            return Ok((
                QualifiedType {
                    ty: TypeSpecifier::Array(array),
                    qualifiers,
                },
                end,
            ));
        }
        Some(&Symbol::Variable {
            pointer,
            ref ty,
            qualifiers,
        }) => {
            if let Expression::FunctionArgument(index) = context.function.ir.expressions[pointer] {
                if matches!(
                    context.function.parameter_mode(index),
                    Some(ParameterMode::Reference { .. })
                ) {
                    return Err(invalid());
                }
            }
            (ty, qualifiers)
        }
        Some(&Symbol::Constant { ref ty, .. }) => (
            ty,
            Qualifiers {
                is_const: true,
                is_volatile: false,
            },
        ),
        Some(_) => return Err(invalid()),
        None => match globals.get(name) {
            Some(&GlobalDeclaration::Constant { ref ty, .. }) => (
                ty,
                Qualifiers {
                    is_const: true,
                    is_volatile: false,
                },
            ),
            _ => return Err(invalid()),
        },
    };
    Ok((
        QualifiedType {
            ty: context.object_type(ty, span)?,
            qualifiers,
        },
        end,
    ))
}

fn parse_type(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    context: &TypeContext<'_, '_>,
) -> Result<QualifiedType, ParseError> {
    declaration_type(lexer, symbols, globals, context, false).map(|(ty, _)| match ty {
        DeclarationType::Explicit(ty) => ty,
        DeclarationType::Inferred { .. } => unreachable!(),
    })
}

fn declaration_type(
    lexer: &mut Lexer<'_>,
    symbols: &SymbolTable<&str, Symbol>,
    globals: &FastHashMap<&str, GlobalDeclaration>,
    context: &TypeContext<'_, '_>,
    is_variable_declaration: bool,
) -> Result<(DeclarationType, bool), ParseError> {
    let mut ty: Option<QualifiedType> = None;
    let mut inferred = false;
    let mut explicit_const = false;
    let mut explicit_volatile = false;
    let mut is_constexpr = false;
    let mut integers = IntegerSpecifiers::default();
    loop {
        let token = lexer.peek()?;
        if ty.is_none() && !inferred {
            if let Some(name) = cooperative_groups::try_qualified_name(lexer, symbols, globals)? {
                let cooperative_groups::QualifiedItem::Type(qualified) = name.item else {
                    return Err(ParseError {
                        message: String::from("expected a CUDA type"),
                        span: name.span,
                    });
                };
                ty = Some(qualified);
                continue;
            }
        }
        let invalid = |message: &str| ParseError {
            message: String::from(message),
            span: token.1,
        };
        match token.0 {
            Token::Word("decltype") if ty.is_none() && !inferred => {
                lexer.next()?;
                ty = Some(decltype_operand_type(lexer, symbols, globals, context)?.0);
                continue;
            }
            Token::Word("struct") => {
                return Err(invalid("elaborated struct type spellings are unsupported"));
            }
            Token::Word("const") => {
                if explicit_const {
                    return Err(invalid("duplicate const qualifier"));
                }
                explicit_const = true;
            }
            Token::Word("volatile") => {
                if explicit_volatile {
                    return Err(invalid("duplicate volatile qualifier"));
                }
                explicit_volatile = true;
            }
            Token::Word("constexpr") => {
                if !is_variable_declaration {
                    return Err(invalid("constexpr is unsupported in this type"));
                }
                if is_constexpr {
                    return Err(invalid("duplicate constexpr specifier"));
                }
                is_constexpr = true;
            }
            Token::Word("auto") => {
                if !is_variable_declaration {
                    return Err(invalid("auto deduction is unsupported in this type"));
                }
                if inferred || ty.is_some() {
                    return Err(invalid("incompatible or repeated type specifier"));
                }
                inferred = true;
            }
            Token::Word(specifier @ ("int" | "short" | "long" | "signed" | "unsigned")) => {
                if inferred || (ty.is_some() && integers.is_empty()) {
                    return Err(invalid("incompatible or repeated type specifier"));
                }
                let scalar = integers
                    .consume(specifier)
                    .ok_or_else(|| invalid("incompatible or repeated type specifier"))?;
                ty = Some(QualifiedType {
                    ty: TypeSpecifier::from_scalar(scalar),
                    qualifiers: Qualifiers::NONE,
                });
            }
            Token::Word(name) if ty.is_none() && !inferred => {
                ty = Some(type_name(name, symbols, globals).ok_or_else(|| ParseError {
                    message: format!("unknown or unsupported scalar type `{name}`"),
                    span: token.1,
                })?);
            }
            _ => break,
        }
        lexer.next()?;
    }
    if inferred {
        return Ok((
            DeclarationType::Inferred {
                qualifiers: Qualifiers {
                    is_const: explicit_const || is_constexpr,
                    is_volatile: explicit_volatile,
                },
            },
            is_constexpr,
        ));
    }
    let Some(mut ty) = ty else {
        return Err(ParseError {
            message: String::from("expected a scalar type"),
            span: lexer.peek()?.1,
        });
    };
    ty.qualifiers = ty.qualifiers.union(Qualifiers {
        is_const: explicit_const || is_constexpr,
        is_volatile: explicit_volatile,
    });
    Ok((DeclarationType::Explicit(ty), is_constexpr))
}

impl<'a> Parser<'a> {
    pub(super) fn source_scalar(&self, ty: &TypeResolution) -> Option<SourceScalar> {
        let &TypeInner::Scalar(scalar) = ty.inner_with(&self.module.types) else {
            return None;
        };
        if ty
            .handle()
            .is_some_and(|handle| self.long_types.contains(&Some(handle)))
        {
            Some(SourceScalar::Long(scalar.kind))
        } else {
            Some(SourceScalar::Scalar(scalar))
        }
    }

    pub(super) fn require_source_scalar_type(
        &self,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<SourceScalar, ParseError> {
        self.require_scalar_type(ty, span)?;
        Ok(self.source_scalar(ty).unwrap())
    }

    pub(super) fn source_scalar_resolution(
        &mut self,
        scalar: SourceScalar,
        span: Span,
    ) -> Result<TypeResolution, ParseError> {
        let SourceScalar::Long(kind) = scalar else {
            return Ok(scalar_resolution(scalar.scalar()));
        };
        let index = usize::from(kind == ScalarKind::Uint);
        if let Some(handle) = self.long_types[index] {
            return Ok(TypeResolution::Handle(handle));
        }
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let name = if kind == ScalarKind::Sint {
            "long"
        } else {
            "unsigned_long"
        };
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Type, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        let handle = self.module.types.insert(
            Type {
                name: Some(String::from(name)),
                inner: TypeInner::Scalar(scalar.scalar()),
            },
            span,
        );
        self.long_types[index] = Some(handle);
        Ok(TypeResolution::Handle(handle))
    }

    pub(super) fn source_types_equal(&self, left: &TypeResolution, right: &TypeResolution) -> bool {
        let mut left = left.clone();
        let mut right = right.clone();
        for _ in 0..=65 {
            if left.handle().is_some() && left.handle() == right.handle() {
                return true;
            }
            if let (Some(left), Some(right)) =
                (self.source_scalar(&left), self.source_scalar(&right))
            {
                return left == right;
            }
            match (
                left.inner_with(&self.module.types),
                right.inner_with(&self.module.types),
            ) {
                (
                    &TypeInner::Pointer {
                        base: left_base,
                        space: left_space,
                    },
                    &TypeInner::Pointer {
                        base: right_base,
                        space: right_space,
                    },
                ) if left_space == right_space => {
                    left = TypeResolution::Handle(left_base);
                    right = TypeResolution::Handle(right_base);
                }
                (
                    &TypeInner::Array {
                        base: left_base,
                        size: left_size,
                        stride: left_stride,
                    },
                    &TypeInner::Array {
                        base: right_base,
                        size: right_size,
                        stride: right_stride,
                    },
                ) if left_size == right_size && left_stride == right_stride => {
                    left = TypeResolution::Handle(left_base);
                    right = TypeResolution::Handle(right_base);
                }
                (&TypeInner::Pointer { base, .. }, &TypeInner::ValuePointer { .. })
                    if self
                        .source_scalar(&TypeResolution::Handle(base))
                        .is_some_and(|scalar| matches!(scalar, SourceScalar::Long(_))) =>
                {
                    return false
                }
                (&TypeInner::ValuePointer { .. }, &TypeInner::Pointer { base, .. })
                    if self
                        .source_scalar(&TypeResolution::Handle(base))
                        .is_some_and(|scalar| matches!(scalar, SourceScalar::Long(_))) =>
                {
                    return false
                }
                _ => return self.module.compare_types(&left, &right),
            }
        }
        false
    }

    pub(super) fn lower_type(
        &mut self,
        ty: TypeSpecifier,
        span: Span,
    ) -> Result<TypeResolution, ParseError> {
        let (component_count, scalar) = match ty {
            TypeSpecifier::TemplateParameter(_) => {
                return Err(ParseError {
                    message: String::from("dependent type requires an instantiation"),
                    span,
                });
            }
            TypeSpecifier::NullPointer => {
                return Err(ParseError {
                    message: String::from("nullptr_t has no shader storage representation"),
                    span,
                });
            }
            TypeSpecifier::ThreadBlock => {
                return Err(ParseError {
                    message: String::from(
                        "thread_block handles cannot be stored or passed as shader values",
                    ),
                    span,
                })
            }
            TypeSpecifier::Scalar(scalar) => return Ok(scalar_resolution(scalar)),
            TypeSpecifier::Long { kind } => {
                return self.source_scalar_resolution(SourceScalar::Long(kind), span)
            }
            TypeSpecifier::Dim3 => return Ok(TypeResolution::Handle(self.dim3_type(span))),
            TypeSpecifier::Structure(handle) | TypeSpecifier::Array(handle) => {
                return Ok(TypeResolution::Handle(handle));
            }
            TypeSpecifier::Pointer { pointee, .. } => return self.pointer_type(pointee, span),
            TypeSpecifier::Vector {
                component_count,
                scalar,
            } => (component_count, scalar),
        };
        let vector_size = match component_count {
            2 => Some(VectorSize::Bi),
            4 => Some(VectorSize::Quad),
            1 | 3 => None,
            _ => unreachable!(),
        };
        if let Some(size) = vector_size {
            return Ok(TypeResolution::Value(TypeInner::Vector { size, scalar }));
        }
        let base = self.scalar_handle(scalar, span);
        let scalar_width = u32::from(scalar.width);
        let name = VECTOR_TYPES
            .into_iter()
            .find_map(|(name, _, candidate_count, candidate_scalar)| {
                (component_count == candidate_count && scalar == candidate_scalar).then_some(name)
            })
            .unwrap();
        let members = ["x", "y", "z"]
            .into_iter()
            .take(usize::from(component_count))
            .enumerate()
            .map(|(index, name)| StructMember {
                name: Some(String::from(name)),
                ty: base,
                binding: None,
                offset: index as u32 * scalar_width,
            })
            .collect();
        let handle = self.module.types.insert(
            Type {
                name: Some(String::from(name)),
                inner: TypeInner::Struct {
                    members,
                    span: u32::from(component_count) * scalar_width,
                },
            },
            span,
        );
        if component_count == 3 && scalar == Scalar::U32 {
            self.uint3_type = Some(handle);
        }
        Ok(TypeResolution::Handle(handle))
    }

    pub(super) fn type_handle(&mut self, ty: &TypeResolution, span: Span) -> Handle<Type> {
        match ty.clone() {
            TypeResolution::Handle(handle) => handle,
            TypeResolution::Value(inner) => {
                self.module.types.insert(Type { name: None, inner }, span)
            }
        }
    }

    pub(super) fn array_type(
        &mut self,
        base: Handle<Type>,
        size: ArraySize,
        layout_span: Span,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        if self.is_incomplete_array(base) {
            return Err(ParseError {
                message: String::from("array elements require a complete type"),
                span: layout_span,
            });
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Type, Span)>(1, span)?;
        self.layouter
            .update(self.module.to_ctx())
            .map_err(|error| ParseError {
                message: format!("invalid array layout: {error}"),
                span: layout_span,
            })?;
        let inner = TypeInner::Array {
            base,
            size,
            stride: self.layouter[base].to_stride(),
        };
        if inner.try_size(self.module.to_ctx()).is_none() {
            return Err(ParseError {
                message: String::from("array exceeds Naga's type size limit"),
                span: layout_span,
            });
        }
        Ok(self.module.types.insert(Type { name: None, inner }, span))
    }

    pub(super) fn is_incomplete_array(&self, ty: Handle<Type>) -> bool {
        matches!(
            self.module.types[ty].inner,
            TypeInner::Array {
                size: ArraySize::Dynamic,
                ..
            }
        )
    }

    pub(super) fn array_shape(
        &mut self,
        mut ty: Handle<Type>,
        span: Span,
    ) -> Result<(Handle<Type>, usize), ParseError> {
        let mut rank = 0;
        while let TypeInner::Array { base, .. } = self.module.types[ty].inner {
            self.parameter_expansion_budget.charge_work(1, span)?;
            rank += 1;
            if rank > 64 {
                return Err(ParseError {
                    message: String::from("CUDA array rank limit exceeded"),
                    span,
                });
            }
            ty = base;
        }
        Ok((ty, rank))
    }

    pub(super) fn numeric_storage_type(
        &mut self,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<bool, ParseError> {
        let start = self.numeric_storage_types.len();
        self.parameter_expansion_budget
            .charge_slice::<bool>(self.module.types.len() - start, span)?;
        for (handle, source) in self.module.types.iter().skip(start) {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let child = |child: Handle<Type>| {
                self.numeric_storage_types
                    .get(child.index())
                    .copied()
                    .ok_or_else(|| ParseError {
                        message: String::from("invalid CUDA numeric storage layout"),
                        span,
                    })
            };
            let eligible = if self.dim3_type == Some(handle) {
                false
            } else {
                match source.inner {
                    TypeInner::Scalar(scalar) | TypeInner::Vector { scalar, .. } => {
                        matches!(
                            scalar,
                            Scalar::I16
                                | Scalar::U16
                                | Scalar::I32
                                | Scalar::U32
                                | Scalar::I64
                                | Scalar::U64
                                | Scalar::F32
                        )
                    }
                    TypeInner::Array {
                        base,
                        size: ArraySize::Constant(_),
                        ..
                    } => child(base)?,
                    TypeInner::Struct { ref members, .. } => {
                        self.parameter_expansion_budget
                            .charge_work(members.len(), span)?;
                        let mut eligible = true;
                        for member in members {
                            eligible &= child(member.ty)?;
                        }
                        eligible
                    }
                    _ => false,
                }
            };
            self.numeric_storage_types.push(eligible);
        }
        Ok(self.numeric_storage_types[ty.index()])
    }

    pub(super) fn require_scalar_type(
        &self,
        ty: &TypeResolution,
        span: Span,
    ) -> Result<Scalar, ParseError> {
        match *ty.inner_with(&self.module.types) {
            TypeInner::Scalar(scalar) => Ok(scalar),
            _ => Err(ParseError {
                message: String::from("expected a supported scalar expression"),
                span,
            }),
        }
    }

    pub(super) fn type_name(&self, name: &str) -> Option<QualifiedType> {
        type_name(name, &self.function.symbol_table, &self.global_declarations)
    }

    pub(super) fn parse_type(&mut self) -> Result<QualifiedType, ParseError> {
        parse_type(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            &TypeContext {
                types: &self.module.types,
                global_variables: &self.module.global_variables,
                function: &self.function,
                long_types: &self.long_types,
                dim3_type: self.dim3_type,
                structures: &self.structures,
            },
        )
    }

    pub(super) fn parse_type_from(
        &self,
        lexer: &mut Lexer<'_>,
    ) -> Result<QualifiedType, ParseError> {
        parse_type(
            lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            &TypeContext {
                types: &self.module.types,
                global_variables: &self.module.global_variables,
                function: &self.function,
                long_types: &self.long_types,
                dim3_type: self.dim3_type,
                structures: &self.structures,
            },
        )
    }

    pub(super) fn declaration_type(&mut self) -> Result<(DeclarationType, bool), ParseError> {
        declaration_type(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            &TypeContext {
                types: &self.module.types,
                global_variables: &self.module.global_variables,
                function: &self.function,
                long_types: &self.long_types,
                dim3_type: self.dim3_type,
                structures: &self.structures,
            },
            true,
        )
    }

    pub(super) fn decltype_operand_type(&mut self) -> Result<(QualifiedType, Span), ParseError> {
        decltype_operand_type(
            &mut self.lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            &TypeContext {
                types: &self.module.types,
                global_variables: &self.module.global_variables,
                function: &self.function,
                long_types: &self.long_types,
                dim3_type: self.dim3_type,
                structures: &self.structures,
            },
        )
    }

    pub(super) fn decltype_operand_type_from(
        &self,
        lexer: &mut Lexer<'_>,
    ) -> Result<(QualifiedType, Span), ParseError> {
        decltype_operand_type(
            lexer,
            &self.function.symbol_table,
            &self.global_declarations,
            &TypeContext {
                types: &self.module.types,
                global_variables: &self.module.global_variables,
                function: &self.function,
                long_types: &self.long_types,
                dim3_type: self.dim3_type,
                structures: &self.structures,
            },
        )
    }

    pub(super) fn starts_type(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        if let Some(name) = cooperative_groups::try_qualified_name(
            &mut lexer,
            &self.function.symbol_table,
            &self.global_declarations,
        )? {
            return Ok(matches!(
                name.item,
                cooperative_groups::QualifiedItem::Type(_)
            ));
        }
        Ok(match self.lexer.peek()?.0 {
            Token::Word("const" | "volatile" | "constexpr" | "decltype" | "long") => true,
            Token::Word(name) => self.type_name(name).is_some(),
            _ => false,
        })
    }

    pub(super) fn starts_alias(&mut self) -> Result<bool, ParseError> {
        Ok(matches!(
            self.lexer.peek()?.0,
            Token::Word("typedef" | "using" | "namespace")
        ))
    }

    pub(super) fn alias_declaration(&mut self, global: bool) -> Result<(), ParseError> {
        if self.take_ident("namespace")? {
            return self.namespace_alias_declaration(global);
        }
        if self.take_ident("typedef")? {
            let ty = if self.starts_typedef_structure_definition()? {
                let span = self.lexer.peek()?.1;
                self.activate_parameter_expansion(span)?;
                self.prepare_parameter_bindings(span)?;
                let qualifiers = declaration_qualifiers(&mut self.lexer, Qualifiers::NONE, false)?;
                let mut ty = self.structure_definition(global, true)?;
                ty.qualifiers = declaration_qualifiers(&mut self.lexer, qualifiers, false)?;
                ty
            } else {
                self.parse_type()?
            };
            loop {
                let declarator = self.alias_declarator(ty.clone())?;
                let (name, span) = self.identifier()?;
                self.check_name(name, span)?;
                let declarator = self.array_alias_declarator(declarator, span)?;
                if let TypeSpecifier::Structure(handle) = declarator.ty {
                    self.name_anonymous_structure(handle, name, span)?;
                }
                self.insert_type(name, declarator, span, global)?;
                if self.lexer.next_if(Token::Separator(';'))? {
                    return Ok(());
                }
                self.lexer.expect_span(Token::Separator(','))?;
            }
        }
        self.expect_ident("using")?;
        let (name, span) = self.identifier()?;
        self.check_name(name, span)?;
        self.lexer.expect_span(Token::Operation('='))?;
        let ty = self.parse_type()?;
        let ty = self.alias_declarator(ty)?;
        let ty = self.array_alias_declarator(ty, span)?;
        self.lexer.expect_span(Token::Separator(';'))?;
        self.insert_type(name, ty, span, global)
    }

    fn starts_typedef_structure_definition(&mut self) -> Result<bool, ParseError> {
        let mut lexer = self.lexer.clone();
        while matches!(lexer.peek()?.0, Token::Word("const" | "volatile")) {
            lexer.next()?;
        }
        if !lexer.next_if(Token::Word("struct"))? {
            return Ok(false);
        }
        if matches!(lexer.peek()?.0, Token::Word(_)) {
            lexer.next()?;
        }
        Ok(lexer.peek()?.0 == Token::Paren('{'))
    }

    pub(super) fn alias_declarator(
        &mut self,
        ty: QualifiedType,
    ) -> Result<QualifiedType, ParseError> {
        let span = self.lexer.peek()?.1;
        let Some(pointer_qualifiers) = pointer_declarator(&mut self.lexer, ty.ty)? else {
            return Ok(ty);
        };
        let resolution = self.lower_type(ty.ty, span)?;
        let pointee = self.type_handle(&resolution, span);
        Ok(QualifiedType {
            ty: TypeSpecifier::Pointer {
                pointee,
                pointee_qualifiers: ty.qualifiers,
            },
            qualifiers: pointer_qualifiers,
        })
    }

    pub(super) fn array_alias_declarator(
        &mut self,
        ty: QualifiedType,
        span: Span,
    ) -> Result<QualifiedType, ParseError> {
        if self.lexer.peek()?.0 != Token::Paren('[') {
            return Ok(ty);
        }
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        if matches!(
            ty.ty,
            TypeSpecifier::Pointer { .. } | TypeSpecifier::NullPointer | TypeSpecifier::ThreadBlock
        ) {
            return self.fail("array aliases require supported value element types");
        }
        self.lexer.next()?;
        let resolution = self.lower_type(ty.ty, span)?;
        let base = self.type_handle(&resolution, span);
        let array = self.array_declaration(base, true, span)?;
        let array_ty = match array.count {
            Some(_) => array.ty,
            None => self.array_type(array.element_ty, ArraySize::Dynamic, span, span)?,
        };
        Ok(QualifiedType {
            ty: TypeSpecifier::Array(array_ty),
            qualifiers: ty.qualifiers,
        })
    }

    pub(super) fn insert_type(
        &mut self,
        name: &'a str,
        ty: QualifiedType,
        span: Span,
        global: bool,
    ) -> Result<(), ParseError> {
        self.check_name(name, span)?;
        if global {
            self.check_dynamic_shared_linkage(name, span)?;
        }
        if matches!(ty.ty, TypeSpecifier::Array(_) | TypeSpecifier::Long { .. })
            || matches!(ty.ty, TypeSpecifier::Pointer { pointee, .. } if self.is_incomplete_array(pointee))
        {
            self.activate_parameter_expansion(span)?;
            self.prepare_parameter_bindings(span)?;
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            if global {
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, GlobalDeclaration>(1, span)?;
            } else {
                self.parameter_expansion_budget
                    .charge_map_entry::<&str, Symbol>(1, span)?;
            }
        }
        let compatible = if global {
            match self
                .global_declarations
                .insert(name, GlobalDeclaration::Type(ty.clone()))
            {
                None => true,
                Some(GlobalDeclaration::Type(previous)) => ty == previous,
                Some(_) => false,
            }
        } else {
            match self
                .function
                .symbol_table
                .add(name, Symbol::Type(ty.clone()))
            {
                None => true,
                Some(Symbol::Type(previous)) => ty == previous,
                Some(_) => false,
            }
        };
        if compatible {
            Ok(())
        } else {
            Err(ParseError {
                message: format!("incompatible redeclaration of `{name}`"),
                span,
            })
        }
    }
}

pub(super) const fn scalar_resolution(scalar: Scalar) -> TypeResolution {
    TypeResolution::Value(TypeInner::Scalar(scalar))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn exhaust_budget(parser: &mut Parser<'_>, resource: u8, span: Span) {
        parser.parameter_expansion_budget.activate();
        parser.prepare_parameter_bindings(span).unwrap();
        for bit in (0..usize::BITS).rev() {
            let count = 1usize << bit;
            let _ = match resource {
                0 => parser.parameter_expansion_budget.charge_nodes(count, span),
                1 => parser.parameter_expansion_budget.charge_bytes(count, span),
                _ => parser.parameter_expansion_budget.charge_work(count, span),
            };
        }
        assert!(parser.parameter_expansion_budget.is_exhausted());
    }

    #[test]
    fn decltype_pointer_and_array_queries_remain_pure_with_exhausted_budgets() {
        for resource in 0..3 {
            let source = "int value = 1; int *const pointer = &value; int array[3] = {}; __shared__ volatile int shared_array[2];";
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            for _ in 0..4 {
                parser.local_declaration().unwrap();
            }
            exhaust_budget(&mut parser, resource, Span::new(0, 1));
            let ir = format!("{:?}", parser.function.ir);
            let types = format!("{:?}", parser.module.types);
            let globals = format!("{:?}", parser.module.global_variables);
            let symbols = format!("{:?}", parser.function.symbol_table);
            let pointers = format!("{:?}", parser.function.pointer_symbols);
            let pointer_expressions = format!("{:?}", parser.function.pointers.expressions);
            let pointer_operations = parser.function.pointers.operations.len();
            let depths = parser.function.expression_graph_depths.clone();
            let pointer = parser
                .parse_type_from(&mut Lexer::new("decltype(pointer)").unwrap())
                .unwrap();
            assert!(pointer.qualifiers.is_const);
            assert!(matches!(
                pointer.ty,
                TypeSpecifier::Pointer {
                    pointee_qualifiers: Qualifiers::NONE,
                    ..
                }
            ));
            for (query, count, is_volatile) in [
                ("decltype(array)", 3, false),
                ("decltype(shared_array)", 2, true),
            ] {
                let array = parser
                    .parse_type_from(&mut Lexer::new(query).unwrap())
                    .unwrap();
                assert_eq!(array.qualifiers.is_volatile, is_volatile);
                let TypeSpecifier::Array(handle) = array.ty else {
                    panic!("expected full array type");
                };
                assert!(
                    matches!(parser.module.types[handle].inner, TypeInner::Array { size: ArraySize::Constant(size), .. } if size.get() == count)
                );
            }
            assert_eq!(format!("{:?}", parser.function.ir), ir);
            assert_eq!(format!("{:?}", parser.module.types), types);
            assert_eq!(format!("{:?}", parser.module.global_variables), globals);
            assert_eq!(format!("{:?}", parser.function.symbol_table), symbols);
            assert_eq!(format!("{:?}", parser.function.pointer_symbols), pointers);
            assert_eq!(
                format!("{:?}", parser.function.pointers.expressions),
                pointer_expressions
            );
            assert_eq!(
                parser.function.pointers.operations.len(),
                pointer_operations
            );
            assert_eq!(parser.function.expression_graph_depths, depths);
        }
    }

    #[test]
    fn decltype_array_alias_insertion_and_extent_allocation_obey_budgets() {
        for declare_object in [false, true] {
            for resource in 0..2 {
                let source =
                    "int array[3] = {}; using Alias = decltype(array); Alias fresh[(1 + 2)];";
                let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                parser.local_declaration().unwrap();
                if declare_object {
                    parser.local_declaration().unwrap();
                }
                exhaust_budget(&mut parser, resource, Span::new(0, 1));
                let ir = format!("{:?}", parser.function.ir);
                let types = format!("{:?}", parser.module.types);
                let symbols = format!("{:?}", parser.function.symbol_table);
                let depths = parser.function.expression_graph_depths.clone();
                let error = parser.local_declaration().unwrap_err();
                assert_eq!(
                    error.message,
                    "CUDA helper parameter expansion limit exceeded"
                );
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_eq!(format!("{:?}", parser.function.ir), ir);
                assert_eq!(format!("{:?}", parser.module.types), types);
                assert_eq!(format!("{:?}", parser.function.symbol_table), symbols);
                assert_eq!(parser.function.expression_graph_depths, depths);
                assert!(parser.function.symbol_table.lookup("fresh").is_none());
            }
        }
    }
}
