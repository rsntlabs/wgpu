use super::rounding::Rounding;
use super::*;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FloatMathFunction {
    Floor,
    Ceil,
    AbsoluteValue,
    Round,
}

impl FloatMathFunction {
    pub(super) const fn index(self) -> usize {
        match self {
            Self::Floor => 0,
            Self::Ceil => 1,
            Self::AbsoluteValue => 2,
            Self::Round => 3,
        }
    }

    const fn name(self) -> &'static str {
        match self {
            Self::Floor => "_naga_floorf",
            Self::Ceil => "_naga_ceilf",
            Self::AbsoluteValue => "_naga_fabsf",
            Self::Round => "_naga_roundf",
        }
    }
}

impl Parser<'_> {
    pub(super) fn call_float_math(
        &mut self,
        value: Handle<Expression>,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let result = self.call_float_math_bits(value, operation, span)?;
        self.append(
            Expression::As {
                expr: result,
                kind: ScalarKind::Float,
                convert: None,
            },
            span,
        )
    }

    pub(super) fn call_float_math_bits(
        &mut self,
        value: Handle<Expression>,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let input_bits = self.append(
            Expression::As {
                expr: value,
                kind: ScalarKind::Uint,
                convert: None,
            },
            span,
        )?;
        let function = self.cached_float_math_function(operation, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let result = self.append_call_result(function, span)?;
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
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_float_math_function(operation, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let function = self.module.functions.append(helper.ir, span);
        self.float_math_functions[operation.index()] = Some(function);
        Ok(function)
    }

    fn build_float_math_function(
        &mut self,
        operation: FloatMathFunction,
        span: Span,
    ) -> Result<(), ParseError> {
        let scalar_ty = self.scalar_handle(Scalar::U32, span);
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
        };
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
        Ok(())
    }
}
