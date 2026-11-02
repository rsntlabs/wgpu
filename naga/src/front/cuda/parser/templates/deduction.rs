use super::*;

impl Parser<'_> {
    pub(super) fn template_call_arguments(
        &mut self,
        template: usize,
        explicit: &[TemplateArgument],
        arguments: &[CapturedArgument],
        span: Span,
    ) -> Result<Option<Vec<TemplateValue>>, ParseError> {
        let declaration = &self.templates.declarations[template];
        let parameter_count = declaration.parameters.len();
        if explicit.len() > parameter_count || declaration.signature.len() != arguments.len() {
            return Ok(None);
        }
        self.parameter_expansion_budget
            .charge_slice::<Option<TemplateValue>>(parameter_count, span)?;
        self.parameter_expansion_budget
            .charge_work(parameter_count + arguments.len(), span)?;
        let mut values = alloc::vec![None; parameter_count];
        for (index, argument) in explicit.iter().enumerate() {
            let kind = self.templates.declarations[template].parameters[index].kind;
            let value = match (kind, argument) {
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
            values[index] = Some(value);
        }
        for (index, argument) in arguments.iter().enumerate() {
            let ParameterPattern::Shader {
                ty: PatternType::Parameter(parameter),
                mode,
            } = self.templates.declarations[template].signature[index]
            else {
                continue;
            };
            let parameter = parameter as usize;
            if parameter < explicit.len() {
                continue;
            }
            let Some(value) = self.deduced_argument_type(argument, mode, span)? else {
                return Ok(None);
            };
            if values[parameter].is_some_and(|previous| previous != value) {
                return Ok(None);
            }
            values[parameter] = Some(value);
        }
        if values.iter().any(Option::is_none) {
            return Ok(None);
        }
        self.parameter_expansion_budget
            .charge_slice::<TemplateValue>(parameter_count, span)?;
        Ok(Some(values.into_iter().map(Option::unwrap).collect()))
    }

    fn deduced_argument_type(
        &mut self,
        argument: &CapturedArgument,
        mode: ParameterMode,
        span: Span,
    ) -> Result<Option<TemplateValue>, ParseError> {
        if let ParameterMode::Reference { qualifiers } = mode {
            if let Some(ty) = argument.ty() {
                if matches!(ty.inner_with(&self.module.types), &TypeInner::Array { .. }) {
                    let ty = self.type_handle(ty, span);
                    let qualifiers = argument
                        .reference_qualifiers()
                        .or_else(|| argument.value_qualifiers())
                        .unwrap_or(Qualifiers::NONE)
                        .without(qualifiers);
                    return Ok(Some(TemplateValue::ArrayType { ty, qualifiers }));
                }
            }
        }
        if let ParameterMode::Pointer { qualifiers } = mode {
            let Some(pointer) = argument.pointer_type(&self.module) else {
                return Ok(None);
            };
            if matches!(
                self.module.types[pointer.pointee].inner,
                TypeInner::Array { .. }
            ) {
                return Ok(Some(TemplateValue::ArrayType {
                    ty: pointer.pointee,
                    qualifiers: pointer.qualifiers.without(qualifiers),
                }));
            }
            let ty = self.template_type_from_handle(pointer.pointee, span)?;
            return Ok(Some(TemplateValue::Type {
                ty,
                qualifiers: pointer.qualifiers.without(qualifiers),
            }));
        }
        if argument.is_thread_block() {
            return Ok(
                matches!(mode, ParameterMode::Value).then_some(TemplateValue::Type {
                    ty: TypeSpecifier::ThreadBlock,
                    qualifiers: Qualifiers::NONE,
                }),
            );
        }
        let qualifiers = if let ParameterMode::Reference { qualifiers } = mode {
            if let Some(source) = argument
                .pointer_object_qualifiers()
                .or_else(|| argument.reference_qualifiers())
            {
                source.without(qualifiers)
            } else {
                let source = argument.value_qualifiers().unwrap_or(Qualifiers::NONE);
                let reference = qualifiers.union(source);
                if !reference.is_const || reference.is_volatile {
                    return Ok(None);
                }
                source.without(qualifiers)
            }
        } else {
            Qualifiers::NONE
        };
        if argument.is_null_pointer() {
            return Ok(Some(TemplateValue::Type {
                ty: TypeSpecifier::NullPointer,
                qualifiers,
            }));
        }
        if let Some(pointer) = argument.pointer_type(&self.module) {
            return Ok(Some(TemplateValue::Type {
                ty: TypeSpecifier::Pointer {
                    pointee: pointer.pointee,
                    pointee_qualifiers: pointer.qualifiers,
                },
                qualifiers,
            }));
        }
        let Some(ty) = argument.ty() else {
            return Ok(None);
        };
        let ty = match *ty {
            TypeResolution::Handle(handle) => self.template_type_from_handle(handle, span)?,
            TypeResolution::Value(TypeInner::Scalar(scalar)) => TypeSpecifier::Scalar(scalar),
            TypeResolution::Value(TypeInner::Vector { size, scalar }) => {
                TypeSpecifier::Vector { size, scalar }
            }
            TypeResolution::Value(_) => {
                return Err(ParseError {
                    message: String::from("unsupported source type in template argument deduction"),
                    span,
                })
            }
        };
        Ok(Some(TemplateValue::Type { ty, qualifiers }))
    }

    pub(super) fn source_candidate_better(
        &self,
        left: &CallCandidate,
        right: &CallCandidate,
        left_bindings: &mut [Option<PatternTerm>],
        right_bindings: &mut [Option<PatternTerm>],
    ) -> bool {
        if functions::better_conversion_sequences(
            left.conversions
                .iter()
                .zip(&right.conversions)
                .map(|(&left, &right)| Some((left, right))),
        ) {
            return true;
        }
        if !left
            .conversions
            .iter()
            .zip(&right.conversions)
            .all(|(left, right)| {
                left.rank == right.rank
                    && match (left.mode, right.mode) {
                        (
                            ParameterMode::Reference { qualifiers: left },
                            ParameterMode::Reference { qualifiers: right },
                        ) => left == right || (!left.contains(right) && !right.contains(left)),
                        _ => true,
                    }
            })
        {
            return false;
        }
        match (&left.origin, &right.origin) {
            (&CandidateOrigin::Ordinary(_), &CandidateOrigin::Template { .. }) => true,
            (
                &CandidateOrigin::Template { template: left, .. },
                &CandidateOrigin::Template {
                    template: right, ..
                },
            ) => {
                self.pattern_deducible_from(right, left, right_bindings)
                    && !self.pattern_deducible_from(left, right, left_bindings)
            }
            _ => false,
        }
    }

    fn pattern_deducible_from(
        &self,
        formal: usize,
        actual: usize,
        bindings: &mut [Option<PatternTerm>],
    ) -> bool {
        bindings.fill(None);
        let formal = &self.templates.declarations[formal].signature;
        let actual = &self.templates.declarations[actual].signature;
        formal.len() == actual.len()
            && formal.iter().zip(actual).all(|(&formal, &actual)| {
                let both_references = matches!(
                    formal,
                    ParameterPattern::Shader {
                        mode: ParameterMode::Reference { .. },
                        ..
                    } | ParameterPattern::NullPointer {
                        mode: ParameterMode::Reference { .. }
                    }
                ) && matches!(
                    actual,
                    ParameterPattern::Shader {
                        mode: ParameterMode::Reference { .. },
                        ..
                    } | ParameterPattern::NullPointer {
                        mode: ParameterMode::Reference { .. }
                    }
                );
                match_pattern(
                    pattern_term(formal, both_references),
                    pattern_term(actual, both_references),
                    bindings,
                )
            })
    }
}

const fn pattern_term(pattern: ParameterPattern, reference_qualifiers: bool) -> PatternTerm {
    match pattern {
        ParameterPattern::NullPointer { mode } => PatternTerm::Type {
            ty: PatternType::NullPointer,
            qualifiers: if reference_qualifiers {
                match mode {
                    ParameterMode::Reference { qualifiers } => qualifiers,
                    _ => Qualifiers::NONE,
                }
            } else {
                Qualifiers::NONE
            },
        },
        ParameterPattern::ThreadBlock => PatternTerm::ThreadBlock,
        ParameterPattern::Shader {
            ty,
            mode: ParameterMode::Pointer { qualifiers },
        } => PatternTerm::Pointer {
            pointee: ty,
            qualifiers,
        },
        ParameterPattern::Shader { ty, mode } => PatternTerm::Type {
            ty,
            qualifiers: if reference_qualifiers {
                match mode {
                    ParameterMode::Reference { qualifiers } => qualifiers,
                    _ => Qualifiers::NONE,
                }
            } else {
                Qualifiers::NONE
            },
        },
    }
}

fn match_pattern(
    formal: PatternTerm,
    actual: PatternTerm,
    bindings: &mut [Option<PatternTerm>],
) -> bool {
    match formal {
        PatternTerm::ThreadBlock => actual == PatternTerm::ThreadBlock,
        PatternTerm::Type {
            ty: PatternType::Parameter(parameter),
            qualifiers,
        } => {
            let value = match actual {
                PatternTerm::Type {
                    ty,
                    qualifiers: actual,
                } => {
                    if !actual.contains(qualifiers) {
                        return false;
                    }
                    PatternTerm::Type {
                        ty,
                        qualifiers: actual.without(qualifiers),
                    }
                }
                actual if qualifiers == Qualifiers::NONE => actual,
                _ => return false,
            };
            let slot = &mut bindings[parameter as usize];
            if slot.is_some_and(|previous| previous != value) {
                return false;
            }
            *slot = Some(value);
            true
        }
        PatternTerm::Type { .. } => formal == actual,
        PatternTerm::Pointer {
            pointee,
            qualifiers,
        } => {
            let PatternTerm::Pointer {
                pointee: actual,
                qualifiers: actual_qualifiers,
            } = actual
            else {
                return false;
            };
            actual_qualifiers.contains(qualifiers)
                && match_pattern(
                    PatternTerm::Type {
                        ty: pointee,
                        qualifiers: Qualifiers::NONE,
                    },
                    PatternTerm::Type {
                        ty: actual,
                        qualifiers: actual_qualifiers.without(qualifiers),
                    },
                    bindings,
                )
        }
    }
}
