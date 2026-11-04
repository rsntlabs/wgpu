use super::*;

const NODE_LIMIT: usize = 1_048_576;
const WORK_LIMIT: usize = 4_194_304;
const BYTE_LIMIT: usize = 67_108_864;

#[derive(Default)]
pub(in super::super) struct ExpansionBudget {
    active: bool,
    exhausted: bool,
    nodes: usize,
    work: usize,
    bytes: usize,
}

impl ExpansionBudget {
    pub(in super::super) const fn activate(&mut self) -> bool {
        let newly_active = !self.active;
        self.active = true;
        newly_active
    }

    pub(in super::super) const fn is_exhausted(&self) -> bool {
        self.exhausted
    }

    fn charge(
        active: bool,
        exhausted: &mut bool,
        used: &mut usize,
        count: usize,
        limit: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        if active {
            if count > limit - *used {
                *exhausted = true;
                return Err(limit_error(span));
            }
            *used += count;
        }
        Ok(())
    }

    pub(in super::super) fn charge_nodes(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.nodes,
            count,
            NODE_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_work(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.work,
            count,
            WORK_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_bytes(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.bytes,
            count,
            BYTE_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_slice<T>(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        let bytes = count
            .checked_mul(size_of::<T>())
            .ok_or_else(|| limit_error(span))?;
        self.charge_bytes(bytes, span)
    }

    pub(in super::super) fn charge_map_entry<K, V>(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        let entry = size_of::<K>()
            .checked_add(size_of::<V>())
            .and_then(|size| size.checked_add(size_of::<usize>()))
            .and_then(|size| size.checked_mul(2))
            .and_then(|size| size.checked_mul(count))
            .ok_or_else(|| limit_error(span))?;
        self.charge_bytes(entry, span)
    }
}

pub(super) fn limit_error(span: Span) -> ParseError {
    ParseError {
        message: String::from("CUDA helper parameter expansion limit exceeded"),
        span,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn aggregate_initializer_checks_node_budget(parenthesized: bool) {
        let fields = (0..16)
            .map(|index| format!("int field_{index};"))
            .collect::<String>();
        let initializer = if parenthesized { "(1)" } else { "{1}" };
        let source = format!("struct Record {{ {fields} }}; {initializer}");
        let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
        parser.structure_declaration(true).unwrap();
        let TypeSpecifier::Structure(ty) = parser.type_name("Record").unwrap().ty else {
            panic!("expected the declared record type");
        };
        let span = parser.lexer.peek().unwrap().1;
        parser.function = FunctionContext::new(FunctionKind::Kernel);
        let local = parser.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from("value")),
                ty,
                init: None,
            },
            span,
        );
        let pointer = parser
            .append(Expression::LocalVariable(local), span)
            .unwrap();
        parser.parameter_expansion_budget.activate();
        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
        parser
            .parameter_expansion_budget
            .charge_nodes(remaining, span)
            .unwrap();
        assert!(!parser.function.parameter_state_charged);
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert!(parser.function.ir.body.is_empty());

        let result = if parenthesized {
            parser.lexer.expect_span(Token::Paren('(')).unwrap();
            parser
                .parenthesized_aggregate_initializer(pointer, ty, span, None)
                .map(|_| ())
        } else {
            parser.aggregate_initializer(pointer, TypeSpecifier::Structure(ty), ty, None)
        };
        let error = result.unwrap_err();
        assert_eq!(error.message, limit_error(span).message);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty());
        assert!(source.get(range).is_some());
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert_eq!(parser.function.expression_graph_depths.len(), 1);
        assert_eq!(parser.function.ir.local_variables.len(), 1);
        assert!(parser.function.ir.body.is_empty());
        assert!(parser.function.parameters.is_empty());
        assert!(parser.module.functions.is_empty());
        assert!(parser.module.global_variables.is_empty());
    }

    #[test]
    fn parenthesized_aggregate_initialization_charges_nodes_without_parameter_state() {
        aggregate_initializer_checks_node_budget(true);
    }

    #[test]
    fn braced_aggregate_initialization_charges_nodes_without_parameter_state() {
        aggregate_initializer_checks_node_budget(false);
    }

    #[test]
    fn empty_aggregate_default_initialization_charges_nodes_without_parameter_state() {
        let source = "struct Record { dim3 shape; int first; int second; int third; }; {}";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.structure_declaration(true).unwrap();
        let TypeSpecifier::Structure(ty) = parser.type_name("Record").unwrap().ty else {
            panic!("expected the declared record type");
        };
        assert!(parser.requires_default_constructor(ty));
        let span = parser.lexer.peek().unwrap().1;
        parser.function = FunctionContext::new(FunctionKind::Kernel);
        let local = parser.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from("value")),
                ty,
                init: None,
            },
            span,
        );
        let pointer = parser
            .append(Expression::LocalVariable(local), span)
            .unwrap();
        parser.parameter_expansion_budget.activate();
        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
        parser
            .parameter_expansion_budget
            .charge_nodes(remaining, span)
            .unwrap();
        assert!(!parser.function.parameter_state_charged);
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert!(parser.function.ir.body.is_empty());

        let error = parser
            .aggregate_initializer(pointer, TypeSpecifier::Structure(ty), ty, None)
            .unwrap_err();
        assert_eq!(error.message, limit_error(span).message);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty());
        assert!(source.get(range).is_some());
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert_eq!(parser.function.expression_graph_depths.len(), 1);
        assert_eq!(parser.function.ir.local_variables.len(), 1);
        assert!(parser.function.ir.body.is_empty());
        assert!(parser.function.parameters.is_empty());
        assert!(parser.module.functions.is_empty());
        assert!(parser.module.global_variables.is_empty());
    }

    fn array_initializer_checks_node_budget(source: &str, inferred: bool) {
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.function = FunctionContext::new(FunctionKind::Kernel);
        let span = parser.lexer.peek().unwrap().1;
        let element_ty = parser.scalar_handle(Scalar::I32, span);
        let count = core::num::NonZeroU32::new(4).unwrap();
        let ty = if inferred {
            element_ty
        } else {
            parser
                .array_type(element_ty, ArraySize::Constant(count), span, span)
                .unwrap()
        };
        let local = parser.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from("values")),
                ty,
                init: None,
            },
            span,
        );
        let pointer = parser
            .append(Expression::LocalVariable(local), span)
            .unwrap();
        if inferred {
            parser.function.pending_array = Some(local);
        }
        parser.parameter_expansion_budget.activate();
        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
        parser
            .parameter_expansion_budget
            .charge_nodes(remaining, span)
            .unwrap();
        assert!(!parser.function.parameter_state_charged);
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert!(parser.function.ir.body.is_empty());

        let result = if inferred {
            parser
                .inferred_array_initializer(pointer, TypeSpecifier::Scalar(Scalar::I32), element_ty)
                .map(|_| ())
        } else {
            parser.aggregate_initializer(
                pointer,
                TypeSpecifier::Scalar(Scalar::I32),
                ty,
                Some(count),
            )
        };
        let error = result.unwrap_err();
        assert_eq!(error.message, limit_error(span).message);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty());
        assert!(source.get(range).is_some());
        assert_eq!(parser.function.ir.expressions.len(), 1);
        assert_eq!(parser.function.expression_graph_depths.len(), 1);
        assert_eq!(parser.function.ir.local_variables.len(), 1);
        assert!(parser.function.ir.body.is_empty());
        assert!(parser.function.parameters.is_empty());
        assert!(parser.module.functions.is_empty());
        assert!(parser.module.global_variables.is_empty());
    }

    #[test]
    fn fixed_array_initialization_charges_nodes_without_parameter_state() {
        for source in ["{1}", "{}", "(1)"] {
            array_initializer_checks_node_budget(source, false);
        }
    }

    #[test]
    fn inferred_array_initialization_charges_nodes_without_parameter_state() {
        for source in ["{1}", "(1)"] {
            array_initializer_checks_node_budget(source, true);
        }
    }

    #[test]
    fn cached_float_math_checks_node_budget_without_parameter_state() {
        use super::super::super::float_helpers::FloatMathFunction;

        for (operation, return_bits) in [
            (FloatMathFunction::Floor, false),
            (FloatMathFunction::Ceil, false),
            (FloatMathFunction::AbsoluteValue, false),
            (FloatMathFunction::Round, false),
            (FloatMathFunction::AbsoluteValue, true),
        ] {
            let source = "1.5f";
            let span = Span::new(0, source.len() as u32);
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.function = FunctionContext::new(FunctionKind::Kernel);
            parser.function.ir.name = Some(String::from("caller"));
            let input = parser.number(source, span).unwrap().handle;
            let original_type_count = parser.module.types.len();
            parser.parameter_expansion_budget.activate();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining, span)
                .unwrap();
            assert!(!parser.function.parameter_state_charged);
            assert_eq!(parser.float_math_functions, [None; 4]);
            assert_eq!(parser.function.ir.expressions.len(), 1);
            assert!(parser.function.ir.body.is_empty());

            let error = if return_bits {
                parser.call_float_math_bits(input, operation, span)
            } else {
                parser.call_float_math(input, operation, span)
            }
            .unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(parser.float_math_functions, [None; 4]);
            assert!(parser.function.kind == FunctionKind::Kernel);
            assert_eq!(parser.function.ir.name.as_deref(), Some("caller"));
            assert_eq!(parser.function.ir.expressions.len(), 1);
            assert_eq!(parser.function.expression_graph_depths.len(), 1);
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.arguments.is_empty());
            assert!(parser.function.parameters.is_empty());
            assert_eq!(parser.module.types.len(), original_type_count);
            assert!(parser.module.functions.is_empty());
            assert!(parser.module.global_variables.is_empty());
        }
    }

    fn dynamic_shared_source(calls: usize) -> String {
        let mut source = String::from("__device__ void no_op() {} __global__ void kernel() {");
        for index in 0..64 {
            source.push_str(&format!("__shared__ int fixed_{index};"));
        }
        source.push_str("extern __shared__ int dynamic[]; dynamic[0] = 1; {");
        for _ in 0..calls {
            source.push_str("no_op();");
        }
        source.push_str("} }");
        source
    }

    fn closed_dynamic_shared_parser(source: &str) -> Parser<'_> {
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        while parser.lexer.peek().unwrap().0 != Token::End {
            parser.function_definition().unwrap();
        }
        parser.finish_kernels().unwrap();
        parser.finish_functions().unwrap();
        parser.upgrade_atomic_storage().unwrap();
        parser.parameter_expansion_budget = ExpansionBudget::default();
        parser.parameter_expansion_budget.activate();
        parser
    }

    #[test]
    fn dynamic_shared_validation_charges_globals_for_repeated_nested_calls() {
        let single_source = dynamic_shared_source(1);
        let mut single = closed_dynamic_shared_parser(&single_source);
        single.check_dynamic_shared_views().unwrap();
        let single_work = single.parameter_expansion_budget.work;
        let globals = single.module.global_variables.len();
        assert_eq!(globals, 65);

        let repeated_source = dynamic_shared_source(2);
        let mut repeated = closed_dynamic_shared_parser(&repeated_source);
        let remaining = single_work + globals - 1;
        let span = Span::new(0, repeated_source.len() as u32);
        repeated
            .parameter_expansion_budget
            .charge_work(WORK_LIMIT - remaining, span)
            .unwrap();
        let error = repeated.check_dynamic_shared_views().unwrap_err();
        assert!(error.message.contains("limit"), "{error}");
        assert!(repeated.parameter_expansion_budget.is_exhausted());
    }

    #[test]
    fn erased_nullptr_name_reads_charge_the_expansion_node_budget() {
        let source = "value";
        let span = Span::new(0, source.len() as u32);
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser
            .bind_null_pointer_symbol("value", span, Qualifiers::NONE)
            .unwrap();
        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
        parser
            .parameter_expansion_budget
            .charge_nodes(remaining, span)
            .unwrap();
        let error = parser.expression(0).unwrap_err();
        assert!(error.message.contains("limit"), "{error}");
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert_eq!(error.span.to_range(), Some(0..source.len()));
    }

    #[test]
    fn device_shared_allocations_check_node_and_name_budgets_before_append() {
        let source = "__shared__ unsigned retained_state;";
        let span = Span::new(0, source.len() as u32);
        for exhaust_bytes in [false, true] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.function = FunctionContext::new(FunctionKind::Device);
            parser.activate_parameter_expansion(span).unwrap();
            parser.prepare_parameter_bindings(span).unwrap();
            if exhaust_bytes {
                let remaining = size_of::<(GlobalVariable, Span)>() + "retained_state".len() - 1;
                let charge = BYTE_LIMIT - parser.parameter_expansion_budget.bytes - remaining;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(charge, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.statement().unwrap_err();
            assert!(error.message.contains("limit"), "{error}");
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert!(parser.module.global_variables.is_empty());
            assert_eq!(&source[error.span.to_range().unwrap()], "retained_state");
        }
    }

    #[test]
    fn constant_memory_allocations_preserve_binding_zero_after_budget_exhaustion() {
        let source = "__constant__ unsigned retained_constant;";
        let span = Span::new(0, source.len() as u32);
        for exhaust_bytes in [false, true] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.activate_parameter_expansion(span).unwrap();
            let ty = parser.scalar_handle(Scalar::U32, span);
            assert!(parser.numeric_storage_type(ty, span).unwrap());
            if exhaust_bytes {
                let remaining = size_of::<(GlobalVariable, Span)>() + "retained_constant".len() - 1;
                let charge = BYTE_LIMIT - parser.parameter_expansion_budget.bytes - remaining;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(charge, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.constant_memory_declaration().unwrap_err();
            assert!(error.message.contains("limit"), "{error}");
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(&source[error.span.to_range().unwrap()], "retained_constant");
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.constant_memory.globals.is_empty());
            assert!(!parser.global_declarations.values().any(|declaration| {
                matches!(declaration, GlobalDeclaration::ConstantMemory(_))
            }));

            parser.parameter_expansion_budget = ExpansionBudget::default();
            parser.lexer = Lexer::new("__constant__ unsigned next_constant;").unwrap();
            parser.constant_memory_declaration().unwrap();
            assert_eq!(parser.module.global_variables.len(), 1);
            assert_eq!(parser.constant_memory.globals.len(), 1);
            let (_, global) = parser.module.global_variables.iter().next().unwrap();
            assert_eq!(global.name.as_deref(), Some("next_constant"));
            assert_eq!(
                global.binding,
                Some(ResourceBinding {
                    group: 1,
                    binding: 0
                })
            );
            assert!(!parser.global_declarations.contains_key("retained_constant"));
        }
    }

    #[test]
    fn constant_memory_write_audit_checks_work_budget_before_inspecting_the_root() {
        let source = "__constant__ unsigned retained_constant;";
        let span = Span::new(0, source.len() as u32);
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.constant_memory_declaration().unwrap();
        let (global, _) = parser.module.global_variables.iter().next().unwrap();
        let pointer = parser
            .function
            .ir
            .expressions
            .append(Expression::GlobalVariable(global), span);
        let value = parser
            .function
            .ir
            .expressions
            .append(Expression::Literal(Literal::U32(1)), span);
        parser
            .function
            .ir
            .body
            .push(Statement::Store { pointer, value }, span);
        let function = core::mem::take(&mut parser.function.ir);
        parser.module.functions.append(function, span);
        parser.parameter_expansion_budget = ExpansionBudget::default();
        parser.parameter_expansion_budget.activate();
        parser
            .parameter_expansion_budget
            .charge_work(WORK_LIMIT, span)
            .unwrap();

        let error = parser.check_constant_memory_accesses().unwrap_err();
        assert_eq!(error.message, limit_error(span).message);
        assert_eq!(error.span, span);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert_eq!(parser.module.global_variables.len(), 1);
        let (_, function) = parser.module.functions.iter().next().unwrap();
        assert_eq!(function.expressions.len(), 2);
        assert_eq!(function.body.len(), 1);

        parser.parameter_expansion_budget = ExpansionBudget::default();
        parser.parameter_expansion_budget.activate();
        let error = parser.check_constant_memory_accesses().unwrap_err();
        assert!(error.message.contains("read-only"), "{error}");
        assert!(!parser.parameter_expansion_budget.is_exhausted());
    }
}
