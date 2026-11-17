use super::rounding::Rounding;
use super::*;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FloatMathFunction {
    Floor,
    Ceil,
    AbsoluteValue,
    Round,
    Truncate,
    NearestEven,
}

impl FloatMathFunction {
    pub(super) const fn index(self) -> usize {
        match self {
            Self::Floor => 0,
            Self::Ceil => 1,
            Self::AbsoluteValue => 2,
            Self::Round => 3,
            Self::Truncate => 4,
            Self::NearestEven => 5,
        }
    }

    const fn name(self) -> &'static str {
        match self {
            Self::Floor => "_naga_floorf",
            Self::Ceil => "_naga_ceilf",
            Self::AbsoluteValue => "_naga_fabsf",
            Self::Round => "_naga_roundf",
            Self::Truncate => "_naga_truncf",
            Self::NearestEven => "_naga_rintf",
        }
    }
}

impl Parser<'_> {
    pub(super) fn lower_float_math_call(
        &mut self,
        operation: FloatMathFunction,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let argument =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
        let handle = self.call_float_math(argument.handle, operation, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty: scalar_resolution(Scalar::F32),
            span,
        }
        .into())
    }

    pub(super) fn call_float_math(
        &mut self,
        value: Handle<Expression>,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let result = self.call_float_math_bits(value, operation, span)?;
        self.bitcast_scalar(result, Scalar::F32, span)
    }

    pub(super) fn call_float_math_bits(
        &mut self,
        value: Handle<Expression>,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let input_bits = self.bitcast_scalar(value, Scalar::U32, span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_float_math_function(operation, span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![input_bits],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_float_math_function(
        &mut self,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.float_math_functions[operation.index()] {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_float_math_function(operation, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        self.float_math_functions[operation.index()] = Some(function);
        Ok(function)
    }

    fn build_float_math_function(
        &mut self,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(Scalar::U32),
        };
        let scalar_ty = match self.module.types.get(&ty) {
            Some(handle) => handle,
            None => {
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(Type, Span)>(1, span)?;
                self.module.types.insert(ty, span)
            }
        };
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(operation.name().len() + "input_bits".len(), span)?;
        self.function.ir.name = Some(String::from(operation.name()));
        self.function.ir.arguments.push(FunctionArgument {
            name: Some(String::from("input_bits")),
            ty: scalar_ty,
            binding: None,
        });
        self.function.ir.result = Some(crate::FunctionResult {
            ty: scalar_ty,
            binding: None,
        });
        let input_bits = self.append(Expression::FunctionArgument(0), span)?;
        let result = match operation {
            FloatMathFunction::Floor => self.rounding_bits(input_bits, Rounding::Floor, span)?,
            FloatMathFunction::Ceil => self.rounding_bits(input_bits, Rounding::Ceil, span)?,
            FloatMathFunction::AbsoluteValue => self.absolute_value_bits(input_bits, span)?,
            FloatMathFunction::Round => {
                self.rounding_bits(input_bits, Rounding::NearestAway, span)?
            }
            FloatMathFunction::Truncate => self.truncation_bits(input_bits, span)?,
            FloatMathFunction::NearestEven => {
                self.rounding_bits(input_bits, Rounding::NearestEven, span)?
            }
        };
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn float_math_first_cache_build_preflights_exhausted_budgets() {
        for operation in [
            FloatMathFunction::Floor,
            FloatMathFunction::Ceil,
            FloatMathFunction::AbsoluteValue,
            FloatMathFunction::Round,
            FloatMathFunction::Truncate,
            FloatMathFunction::NearestEven,
        ] {
            for exhaust_bytes in [false, true] {
                let mut parser = Parser::new(Lexer::new("1").unwrap(), &Options::default());
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
                let caller = format!("{:?}", parser.function.ir);
                let types = format!("{:?}", parser.module.types);
                let cache = parser.float_math_functions;
                assert!(parser.cached_float_math_function(operation, span).is_err());
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_eq!(format!("{:?}", parser.function.ir), caller);
                assert_eq!(format!("{:?}", parser.module.types), types);
                assert_eq!(parser.float_math_functions, cache);
                assert!(parser.module.functions.is_empty());
            }
        }
    }
}
