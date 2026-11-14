use super::*;

impl Parser<'_> {
    pub(super) fn parameter_default(&mut self) -> Result<(), ParseError> {
        let span = self.lexer.peek()?.1;
        let has_default = self.lexer.peek()?.0 == Token::Operation('=');
        if let Some(template) = self.function.replay_default_header {
            if has_default {
                self.skip_template_default(template, self.function.parameters.len() - 1)?;
            }
            return Ok(());
        }
        if self.function.kind == FunctionKind::Kernel {
            if has_default {
                return self.fail("kernel default arguments are unsupported");
            }
            return Ok(());
        }
        if !has_default && self.function.defaults.is_empty() {
            return Ok(());
        }
        if has_default {
            self.activate_parameter_expansion(span)?;
        }
        let count = self.function.parameters.len() - self.function.defaults.len();
        self.parameter_expansion_budget
            .charge_slice::<Option<ScalarDefault>>(count, span)?;
        self.parameter_expansion_budget.charge_work(count, span)?;
        self.function
            .defaults
            .resize(self.function.parameters.len(), None);
        if !has_default {
            return Ok(());
        }
        let Some(SourceParameter::Shader {
            ty,
            mode: ParameterMode::Value,
        }) = self.function.parameters.last().copied()
        else {
            return self.fail("default arguments require scalar value parameters");
        };
        if !matches!(self.module.types[ty].inner, TypeInner::Scalar(_)) {
            return self.fail("default arguments require scalar value parameters");
        }
        self.prepare_parameter_bindings(span)?;
        self.function.parsing_default = true;
        let result = self.constant_initializer(&TypeResolution::Handle(ty));
        self.function.parsing_default = false;
        let literal = result?;
        *self.function.defaults.last_mut().unwrap() = Some(ScalarDefault {
            literal,
            ty,
            position: self.lexer.position(),
            span,
        });
        Ok(())
    }

    pub(super) fn merge_parameter_defaults(
        &mut self,
        previous: Option<Handle<Function>>,
        span: Span,
    ) -> Result<(), ParseError> {
        let previous_defaults =
            previous.map(|handle| &self.function_declarations[&handle].defaults);
        if self.function.defaults.is_empty() && previous_defaults.is_none_or(Vec::is_empty) {
            return Ok(());
        }
        let count = self.function.parameters.len();
        let missing = count - self.function.defaults.len();
        self.parameter_expansion_budget
            .charge_slice::<Option<ScalarDefault>>(missing, span)?;
        self.parameter_expansion_budget.charge_work(count, span)?;
        self.function.defaults.resize(count, None);
        if let Some(defaults) = previous_defaults {
            for (target, prior) in self.function.defaults.iter_mut().zip(defaults) {
                if target.is_some() && prior.is_some() {
                    return Err(ParseError {
                        message: String::from("repeated default argument"),
                        span: target.unwrap().span,
                    });
                }
                *target = target.or(*prior);
            }
        }
        let mut trailing = false;
        for default in &self.function.defaults {
            if default.is_some() {
                trailing = true;
            } else if trailing {
                return Err(ParseError {
                    message: String::from("default arguments must be trailing"),
                    span,
                });
            }
        }
        Ok(())
    }

    fn candidate_defaults(
        &self,
        candidate: functions::FunctionCandidate,
    ) -> &[Option<ScalarDefault>] {
        match candidate {
            functions::FunctionCandidate::Defined(handle) => self
                .function_declarations
                .get(&handle)
                .map_or(&[], |declaration| declaration.defaults.as_slice()),
            functions::FunctionCandidate::Current => &self.function.defaults,
            _ => &[],
        }
    }

    pub(super) fn candidate_accepts_arity(
        &self,
        candidate: functions::FunctionCandidate,
        supplied: usize,
        position: super::super::lexer::LexerPosition,
    ) -> bool {
        let total = self.candidate_arity(candidate);
        supplied <= total
            && (supplied..total).all(|index| {
                self.candidate_defaults(candidate)
                    .get(index)
                    .and_then(|default| *default)
                    .is_some_and(|default| default.position.precedes(position))
            })
    }

    pub(super) fn materialize_default(
        &mut self,
        candidate: functions::FunctionCandidate,
        index: usize,
        span: Span,
    ) -> Result<Value, ParseError> {
        self.prepare_parameter_bindings(span)?;
        let default = self.candidate_defaults(candidate)[index].unwrap();
        let handle = self.materialize_literal(default.literal, span)?;
        let value = Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: default.literal.into(),
            handle,
            ty: scalar_resolution(default.literal.scalar()),
            span,
        };
        self.convert_value(value.into(), &TypeResolution::Handle(default.ty))
    }

    pub(super) fn append_default_arguments(
        &mut self,
        candidate: functions::FunctionCandidate,
        arguments: &mut Vec<Value>,
        span: Span,
    ) -> Result<(), ParseError> {
        let total = self.candidate_arity(candidate);
        self.parameter_expansion_budget
            .charge_slice::<Value>(total - arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_work(total - arguments.len(), span)?;
        while arguments.len() < total {
            arguments.push(self.materialize_default(candidate, arguments.len(), span)?);
        }
        Ok(())
    }

    pub(super) fn append_captured_defaults(
        &mut self,
        candidate: functions::FunctionCandidate,
        arguments: &mut Vec<CapturedArgument>,
        span: Span,
    ) -> Result<(), ParseError> {
        let total = self.candidate_arity(candidate);
        self.parameter_expansion_budget
            .charge_slice::<CapturedArgument>(total - arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_work(total - arguments.len(), span)?;
        while arguments.len() < total {
            let index = arguments.len();
            let (value, body) =
                self.capture_block(|parser| parser.materialize_default(candidate, index, span))?;
            arguments.push(CapturedArgument {
                value: value.into(),
                body,
            });
        }
        Ok(())
    }
}
