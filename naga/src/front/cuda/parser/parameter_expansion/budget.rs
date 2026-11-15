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

    #[test]
    fn packed_unary_checks_budgets_before_generating_ir() {
        for operation in [
            integer_intrinsics::PackedUnaryOperation::Absolute,
            integer_intrinsics::PackedUnaryOperation::Negate,
        ] {
            for lane_width in [8, 16] {
                for saturating in [false, true] {
                    for prepared in [false, true] {
                        for exhaust_bytes in [false, true] {
                            let mut parser =
                                Parser::new(Lexer::new("1u").unwrap(), &Options::default());
                            let span = parser.lexer.peek().unwrap().1;
                            let value = parser.number("1u", span).unwrap().handle;
                            parser.activate_parameter_expansion(span).unwrap();
                            if prepared {
                                parser.prepare_parameter_bindings(span).unwrap();
                            }
                            let before = format!("{:?}", parser.function.ir);
                            if exhaust_bytes {
                                parser.parameter_expansion_budget.bytes = BYTE_LIMIT;
                            } else {
                                parser.parameter_expansion_budget.nodes = NODE_LIMIT;
                            }
                            let error = parser
                                .packed_unary(
                                    integer_intrinsics::PackedUnaryBuiltin {
                                        lane_width,
                                        operation,
                                        saturating,
                                    },
                                    value,
                                    span,
                                )
                                .unwrap_err();
                            assert_eq!(error.message, limit_error(span).message);
                            assert!(parser.parameter_expansion_budget.is_exhausted());
                            assert_eq!(format!("{:?}", parser.function.ir), before);
                        }
                    }
                }
            }
        }
    }

    #[test]
    fn packed_unary_checks_budgets_before_implicit_operand_conversion() {
        for operation in [
            integer_intrinsics::PackedUnaryOperation::Absolute,
            integer_intrinsics::PackedUnaryOperation::Negate,
        ] {
            for lane_width in [8, 16] {
                for saturating in [false, true] {
                    for exhaust_bytes in [false, true] {
                        let mut parser = Parser::new(Lexer::new("1").unwrap(), &Options::default());
                        let span = parser.lexer.peek().unwrap().1;
                        let arguments = [parser.number("1", span).unwrap()].to_vec();
                        parser.activate_parameter_expansion(span).unwrap();
                        let before = format!("{:?}", parser.function.ir);
                        if exhaust_bytes {
                            parser.parameter_expansion_budget.bytes = BYTE_LIMIT;
                        } else {
                            parser.parameter_expansion_budget.nodes = NODE_LIMIT;
                        }
                        let candidate = functions::FunctionCandidate::PackedUnary(
                            integer_intrinsics::PackedUnaryBuiltin {
                                lane_width,
                                operation,
                                saturating,
                            },
                        );
                        let error = parser.lower_call(candidate, arguments, span).unwrap_err();
                        assert_eq!(error.message, limit_error(span).message);
                        assert!(parser.parameter_expansion_budget.is_exhausted());
                        assert_eq!(format!("{:?}", parser.function.ir), before);
                    }
                }
            }
        }
    }

    fn packed_arithmetic_operations() -> [integer_intrinsics::PackedArithmeticOperation; 37] {
        use integer_intrinsics::{
            PackedArithmeticOperation as Operation, PackedArithmeticSaturation as Saturation,
            PackedAverageMode as Average,
        };
        [
            Operation::Add(Saturation::Wrapping),
            Operation::Subtract(Saturation::Wrapping),
            Operation::Add(Saturation::Unsigned),
            Operation::Subtract(Saturation::Unsigned),
            Operation::Add(Saturation::Signed),
            Operation::Subtract(Saturation::Signed),
            Operation::Average(Average::UnsignedUp),
            Operation::Average(Average::SignedAwayFromZero),
            Operation::Average(Average::UnsignedDown),
            Operation::AbsoluteDifference { signed: false },
            Operation::AbsoluteDifference { signed: true },
            Operation::Minimum { signed: false },
            Operation::Minimum { signed: true },
            Operation::Maximum { signed: false },
            Operation::Maximum { signed: true },
            Operation::SumAbsoluteDifferences { signed: false },
            Operation::SumAbsoluteDifferences { signed: true },
            Operation::Equal { mask: false },
            Operation::Equal { mask: true },
            Operation::NotEqual { mask: false },
            Operation::NotEqual { mask: true },
            Operation::LessThan {
                signed: false,
                mask: false,
            },
            Operation::LessThan {
                signed: false,
                mask: true,
            },
            Operation::LessThan {
                signed: true,
                mask: false,
            },
            Operation::LessThan {
                signed: true,
                mask: true,
            },
            Operation::LessEqual {
                signed: false,
                mask: false,
            },
            Operation::LessEqual {
                signed: false,
                mask: true,
            },
            Operation::LessEqual {
                signed: true,
                mask: false,
            },
            Operation::LessEqual {
                signed: true,
                mask: true,
            },
            Operation::GreaterThan {
                signed: false,
                mask: false,
            },
            Operation::GreaterThan {
                signed: false,
                mask: true,
            },
            Operation::GreaterThan {
                signed: true,
                mask: false,
            },
            Operation::GreaterThan {
                signed: true,
                mask: true,
            },
            Operation::GreaterEqual {
                signed: false,
                mask: false,
            },
            Operation::GreaterEqual {
                signed: false,
                mask: true,
            },
            Operation::GreaterEqual {
                signed: true,
                mask: false,
            },
            Operation::GreaterEqual {
                signed: true,
                mask: true,
            },
        ]
    }

    #[test]
    fn packed_arithmetic_checks_node_and_byte_budgets_before_generating_ir() {
        for operation in packed_arithmetic_operations() {
            for lane_width in [8, 16] {
                for prepared in [false, true] {
                    for exhaust_bytes in [false, true] {
                        let mut parser =
                            Parser::new(Lexer::new("1u 2u").unwrap(), &Options::default());
                        let span = parser.lexer.peek().unwrap().1;
                        let [left, right] =
                            ["1u", "2u"].map(|text| parser.number(text, span).unwrap().handle);
                        parser.activate_parameter_expansion(span).unwrap();
                        if prepared {
                            parser.prepare_parameter_bindings(span).unwrap();
                        }
                        let before = format!("{:?}", parser.function.ir);
                        if exhaust_bytes {
                            parser.parameter_expansion_budget.bytes = BYTE_LIMIT;
                        } else {
                            parser.parameter_expansion_budget.nodes = NODE_LIMIT;
                        }
                        let error = parser
                            .packed_arithmetic(
                                integer_intrinsics::PackedArithmeticBuiltin {
                                    lane_width,
                                    operation,
                                },
                                left,
                                right,
                                span,
                            )
                            .unwrap_err();
                        assert_eq!(error.message, limit_error(span).message);
                        assert!(parser.parameter_expansion_budget.is_exhausted());
                        assert_eq!(format!("{:?}", parser.function.ir), before);
                    }
                }
            }
        }
    }

    #[test]
    fn packed_arithmetic_checks_budgets_before_implicit_operand_conversions() {
        for operation in packed_arithmetic_operations() {
            for lane_width in [8, 16] {
                for exhaust_bytes in [false, true] {
                    let mut parser = Parser::new(Lexer::new("1 2").unwrap(), &Options::default());
                    let span = parser.lexer.peek().unwrap().1;
                    let arguments = ["1", "2"]
                        .map(|text| parser.number(text, span).unwrap())
                        .to_vec();
                    parser.activate_parameter_expansion(span).unwrap();
                    let before = format!("{:?}", parser.function.ir);
                    if exhaust_bytes {
                        parser.parameter_expansion_budget.bytes = BYTE_LIMIT;
                    } else {
                        parser.parameter_expansion_budget.nodes = NODE_LIMIT;
                    }
                    let candidate = functions::FunctionCandidate::PackedArithmetic(
                        integer_intrinsics::PackedArithmeticBuiltin {
                            lane_width,
                            operation,
                        },
                    );
                    let error = parser.lower_call(candidate, arguments, span).unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(format!("{:?}", parser.function.ir), before);
                }
            }
        }
    }

    #[test]
    fn query_parameter_pointer_descriptors_check_budgets_before_insertion() {
        for exhausted in 0..3 {
            let mut parser = Parser::new(Lexer::new("pointer").unwrap(), &Options::default());
            let span = parser.lexer.peek().unwrap().1;
            let pointee = parser.scalar_handle(Scalar::I32, span);
            parser.activate_parameter_expansion(span).unwrap();
            let types = parser.module.types.len();
            match exhausted {
                0 => parser.parameter_expansion_budget.nodes = NODE_LIMIT,
                1 => parser.parameter_expansion_budget.bytes = BYTE_LIMIT,
                _ => parser.parameter_expansion_budget.work = WORK_LIMIT,
            }
            let error = parser
                .query_parameter_pointer_type(pointee, span)
                .unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(parser.module.types.len(), types);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
        }
    }

    #[test]
    fn query_parameter_pointer_descriptors_reuse_types_without_allocation_budget() {
        let mut parser = Parser::new(Lexer::new("pointer").unwrap(), &Options::default());
        let span = parser.lexer.peek().unwrap().1;
        let pointee = parser.scalar_handle(Scalar::I32, span);
        parser.activate_parameter_expansion(span).unwrap();
        let pointer = parser.query_parameter_pointer_type(pointee, span).unwrap();
        let types = parser.module.types.len();
        parser.parameter_expansion_budget.nodes = NODE_LIMIT;
        parser.parameter_expansion_budget.bytes = BYTE_LIMIT;
        assert_eq!(
            parser.query_parameter_pointer_type(pointee, span).unwrap(),
            pointer
        );
        assert_eq!(parser.module.types.len(), types);
        assert!(!parser.parameter_expansion_budget.is_exhausted());
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.function.ir.local_variables.is_empty());
    }

    #[test]
    fn template_default_replay_checks_work_before_consuming_source() {
        let source = "template<class T> __device__ int helper(T value, int bias = (1 + 2));";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        let mut initializer = parser.lexer.clone();
        while initializer.peek().unwrap().0 != Token::Operation('=') {
            initializer.next().unwrap();
        }
        parser.template_declaration().unwrap();
        parser.lexer = initializer;
        let start = parser.lexer.position();
        parser.parameter_expansion_budget.work = WORK_LIMIT;
        let error = parser.skip_template_default(0, 1).unwrap_err();
        assert_eq!(error.message, limit_error(error.span).message);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert_eq!(parser.lexer.position(), start);
    }

    #[test]
    fn default_declarations_check_node_budget_before_building_initializer() {
        let source = "= 3";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        let span = parser.lexer.peek().unwrap().1;
        parser.function = FunctionContext::new(FunctionKind::Device);
        let ty = parser.scalar_handle(Scalar::I32, span);
        parser.function.parameters.push(SourceParameter::Shader {
            ty,
            mode: ParameterMode::Value,
        });
        parser.activate_parameter_expansion(span).unwrap();
        parser.parameter_expansion_budget.nodes = NODE_LIMIT;
        let error = parser.parameter_default().unwrap_err();
        assert_eq!(error.message, limit_error(span).message);
        assert!(parser.parameter_expansion_budget.is_exhausted());
        assert!(parser.function.ir.expressions.is_empty());
        assert!(parser.function.ir.local_variables.is_empty());
        assert!(parser.function.ir.body.is_empty());
    }

    #[test]
    fn default_arguments_check_budgets_before_materializing_omitted_values() {
        for captured in [false, true] {
            for exhausted in 0..3 {
                let source = "__device__ int helper(int value = 3);";
                let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                parser.function_definition().unwrap();
                let candidate = parser.function_candidates("helper").next().unwrap();
                let span = Span::new(0, source.len() as u32);
                let expressions = parser.function.ir.expressions.len();
                match exhausted {
                    0 => parser.parameter_expansion_budget.nodes = NODE_LIMIT,
                    1 => parser.parameter_expansion_budget.bytes = BYTE_LIMIT,
                    _ => parser.parameter_expansion_budget.work = WORK_LIMIT,
                }
                let error = if captured {
                    let mut arguments = Vec::new();
                    let error = parser
                        .append_captured_defaults(candidate, &mut arguments, span)
                        .unwrap_err();
                    assert!(arguments.is_empty());
                    error
                } else {
                    let mut arguments = Vec::new();
                    let error = parser
                        .append_default_arguments(candidate, &mut arguments, span)
                        .unwrap_err();
                    assert!(arguments.is_empty());
                    error
                };
                assert_eq!(error.message, limit_error(span).message);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_eq!(parser.function.ir.expressions.len(), expressions);
                assert!(parser.function.ir.body.is_empty());
                assert!(parser.function.ir.local_variables.is_empty());
            }
        }
    }

    #[test]
    fn empty_void_values_charge_source_nodes_without_shader_allocations() {
        for source in ["void()", "void{}"] {
            for available_nodes in [0, 1] {
                let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                let span = parser.lexer.peek().unwrap().1;
                parser.activate_parameter_expansion(span).unwrap();
                parser
                    .parameter_expansion_budget
                    .charge_nodes(NODE_LIMIT - available_nodes, span)
                    .unwrap();
                let type_count = parser.module.types.len();
                let expression_count = parser.function.ir.expressions.len();
                let result = parser.expression_result(0);
                if available_nodes == 0 {
                    let error = result.unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                } else {
                    let ExpressionResult::Void(value) = result.unwrap() else {
                        panic!("empty void construction must yield a source-only void value");
                    };
                    assert!(value.constant.is_discardable);
                    assert!(value.constant.literal.is_none());
                    assert_eq!(parser.parameter_expansion_budget.nodes, NODE_LIMIT);
                }
                assert_eq!(parser.module.types.len(), type_count);
                assert_eq!(parser.function.ir.expressions.len(), expression_count);
            }
        }
    }

    #[test]
    fn static_assertions_activate_resource_accounting_for_simple_conditions() {
        for exhaust_bytes in [false, true] {
            let source = "static_assert(true, \"first\"); static_assert(true, \"second\");";
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.static_assert_declaration().unwrap();
            let span = parser.lexer.peek().unwrap().1;
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = WORK_LIMIT - parser.parameter_expansion_budget.work;
                parser
                    .parameter_expansion_budget
                    .charge_work(remaining, span)
                    .unwrap();
            }
            let error = parser.static_assert_declaration().unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert!(parser.parameter_expansion_budget.is_exhausted());
        }
    }

    #[test]
    fn record_static_assertions_reject_resource_exhaustion_before_fields() {
        for resource in 0..3 {
            let source = "static_assert(true); struct Record { static_assert(true, \"record\"); int field; };";
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.static_assert_declaration().unwrap();
            let span = parser.lexer.peek().unwrap().1;
            match resource {
                0 => {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }
                1 => {
                    let remaining = WORK_LIMIT - parser.parameter_expansion_budget.work;
                    parser
                        .parameter_expansion_budget
                        .charge_work(remaining, span)
                        .unwrap();
                }
                _ => {
                    let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                }
            }
            let type_count = parser.module.types.len();
            let declaration_count = parser.global_declarations.len();
            let error = parser.structure_declaration(true).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.structures.is_empty());
            assert_eq!(parser.global_declarations.len(), declaration_count);
            assert!(!parser.global_declarations.contains_key("Record"));
            assert_eq!(parser.next_structure_id, 0);
            assert!(parser.function.symbol_table.lookup("Record").is_none());
            assert!(parser.function.symbol_table.lookup("field").is_none());
        }
    }

    #[test]
    fn record_static_assertions_restore_scope_after_failed_member_check() {
        let source = "struct Record { int field; static_assert(sizeof(field) == 8); };";
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        let declaration_count = parser.global_declarations.len();
        let error = parser.structure_declaration(true).unwrap_err();
        assert!(error.message.contains("static assertion failed"), "{error}");
        assert!(parser.structures.is_empty());
        assert_eq!(parser.global_declarations.len(), declaration_count);
        assert!(!parser.global_declarations.contains_key("Record"));
        assert_eq!(parser.next_structure_id, 0);
        assert!(parser.function.symbol_table.lookup("Record").is_none());
        assert!(parser.function.symbol_table.lookup("field").is_none());
    }

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
    fn long_source_types_check_budget_before_allocation_and_reuse_cached_types() {
        for kind in [ScalarKind::Sint, ScalarKind::Uint] {
            for exhaust_bytes in [false, true] {
                let source = "long";
                let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                let span = parser.lexer.peek().unwrap().1;
                let cached_kind = if kind == ScalarKind::Sint {
                    ScalarKind::Uint
                } else {
                    ScalarKind::Sint
                };
                let cached_scalar = SourceScalar::Long(cached_kind);
                let cached_type = parser
                    .source_scalar_resolution(cached_scalar, span)
                    .unwrap();
                let type_count = parser.module.types.len();
                let cached_types = parser.long_types;
                if exhaust_bytes {
                    let remaining = BYTE_LIMIT
                        - parser.parameter_expansion_budget.bytes
                        - size_of::<(Type, Span)>();
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                } else {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }

                let error = parser
                    .source_scalar_resolution(SourceScalar::Long(kind), span)
                    .unwrap_err();
                assert_eq!(error.message, limit_error(span).message);
                assert_eq!(error.span, span);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_eq!(parser.module.types.len(), type_count);
                assert_eq!(parser.long_types, cached_types);
                let charged = (
                    parser.parameter_expansion_budget.nodes,
                    parser.parameter_expansion_budget.work,
                    parser.parameter_expansion_budget.bytes,
                );
                assert_eq!(
                    parser
                        .source_scalar_resolution(cached_scalar, span)
                        .unwrap(),
                    cached_type
                );
                assert_eq!(parser.module.types.len(), type_count);
                assert_eq!(parser.long_types, cached_types);
                assert_eq!(
                    (
                        parser.parameter_expansion_budget.nodes,
                        parser.parameter_expansion_budget.work,
                        parser.parameter_expansion_budget.bytes,
                    ),
                    charged
                );
            }
        }
    }

    #[test]
    fn array_type_checks_budget_before_allocation() {
        for exhaust_bytes in [false, true] {
            let source = "int";
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let span = parser.lexer.peek().unwrap().1;
            let element = parser.scalar_handle(Scalar::I32, span);
            let type_count = parser.module.types.len();
            let count = core::num::NonZeroU32::new(4).unwrap();
            parser.parameter_expansion_budget.activate();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            assert!(!parser.function.parameter_state_charged);

            let error = parser
                .array_type(element, ArraySize::Constant(count), span, span)
                .unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.expression_graph_depths.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
        }
    }

    #[test]
    fn array_alias_declarations_check_budget_before_types_and_symbols() {
        for source in [
            "typedef int Values[3];",
            "using Values = int[3];",
            "typedef Row Values;",
            "using Values = Row;",
        ] {
            for global in [false, true] {
                for exhaust_bytes in [false, true] {
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    let span = parser.lexer.peek().unwrap().1;
                    let element = parser.scalar_handle(Scalar::I32, span);
                    let count = core::num::NonZeroU32::new(4).unwrap();
                    let row = parser
                        .array_type(element, ArraySize::Constant(count), span, span)
                        .unwrap();
                    let row_type = QualifiedType {
                        ty: TypeSpecifier::Array(row),
                        qualifiers: Qualifiers::NONE,
                    };
                    assert!(parser
                        .global_declarations
                        .insert("Row", GlobalDeclaration::Type(row_type.clone()))
                        .is_none());
                    let type_count = parser.module.types.len();
                    let declaration_count = parser.global_declarations.len();
                    parser.parameter_expansion_budget.activate();
                    if exhaust_bytes {
                        let preparation = size_of::<FunctionParameterState>();
                        let remaining =
                            BYTE_LIMIT - parser.parameter_expansion_budget.bytes - preparation;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    assert!(!parser.function.parameter_state_charged);

                    let error = parser.alias_declaration(global).unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    let range = error.span.to_range().unwrap();
                    assert!(!range.is_empty());
                    assert!(source.get(range).is_some());
                    assert_eq!(parser.module.types.len(), type_count);
                    assert_eq!(parser.global_declarations.len(), declaration_count);
                    assert!(!parser.global_declarations.contains_key("Values"));
                    assert!(parser.function.symbol_table.lookup("Values").is_none());
                    assert_eq!(parser.type_name("Row"), Some(row_type));
                    assert!(parser.function.ir.expressions.is_empty());
                    assert!(parser.function.expression_graph_depths.is_empty());
                    assert!(parser.function.ir.named_expressions.is_empty());
                    assert!(parser.function.ir.local_variables.is_empty());
                    assert!(parser.function.ir.body.is_empty());
                    assert!(parser.function.parameters.is_empty());
                    assert!(parser.module.global_variables.is_empty());
                    assert!(parser.module.functions.is_empty());
                    assert_eq!(parser.dim3_type, None);
                    assert_eq!(parser.uint3_type, None);
                    assert_eq!(parser.float_math_functions, [None; 4]);
                    assert_eq!(parser.sqrtf_function, None);
                    assert_eq!(parser.division_function, None);
                    assert_eq!(parser.fmodf_function, None);
                    assert_eq!(parser.trigonometry_function, None);
                }
            }
        }
    }

    #[test]
    fn array_declarators_check_budget_before_extent_expressions() {
        for kind in [FunctionKind::Kernel, FunctionKind::Device] {
            for (source, parameter) in [("1]", false), ("[1]", true)] {
                for exhaust_bytes in [false, true] {
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    parser.function = FunctionContext::new(kind);
                    let span = parser.lexer.peek().unwrap().1;
                    let element = parser.scalar_handle(Scalar::I32, span);
                    let type_count = parser.module.types.len();
                    parser.parameter_expansion_budget.activate();
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    assert!(!parser.function.parameter_state_charged);

                    let result = if parameter {
                        parser.array_parameter(
                            Some("values"),
                            span,
                            &TypeResolution::Handle(element),
                            Qualifiers::NONE,
                            ParameterMode::Value,
                            0,
                        )
                    } else {
                        parser.array_declaration(element, false, span).map(|_| ())
                    };
                    let error = result.unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    let range = error.span.to_range().unwrap();
                    assert!(!range.is_empty());
                    assert!(source.get(range).is_some());
                    assert_eq!(parser.module.types.len(), type_count);
                    assert!(parser.function.ir.expressions.is_empty());
                    assert!(parser.function.expression_graph_depths.is_empty());
                    assert!(parser.function.ir.named_expressions.is_empty());
                    assert!(parser.function.ir.local_variables.is_empty());
                    assert!(parser.function.ir.arguments.is_empty());
                    assert!(parser.function.ir.body.is_empty());
                    assert!(parser.function.parameters.is_empty());
                    assert!(parser.function.symbol_table.lookup("values").is_none());
                    assert!(parser.module.global_variables.is_empty());
                    assert!(parser.module.functions.is_empty());
                }
            }
        }
    }

    #[test]
    fn array_alias_objects_check_budget_before_explicit_extent_expressions() {
        for source in ["Row values[1];", "Row values[(1 + 2)];"] {
            for kind in [FunctionKind::Kernel, FunctionKind::Device] {
                for exhaust_bytes in [false, true] {
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    parser.function = FunctionContext::new(kind);
                    let span = parser.lexer.peek().unwrap().1;
                    let element = parser.scalar_handle(Scalar::I32, span);
                    let count = core::num::NonZeroU32::new(4).unwrap();
                    let row = parser
                        .array_type(element, ArraySize::Constant(count), span, span)
                        .unwrap();
                    let row_type = QualifiedType {
                        ty: TypeSpecifier::Array(row),
                        qualifiers: Qualifiers::NONE,
                    };
                    assert!(parser
                        .global_declarations
                        .insert("Row", GlobalDeclaration::Type(row_type.clone()))
                        .is_none());
                    let type_count = parser.module.types.len();
                    let declaration_count = parser.global_declarations.len();
                    parser.parameter_expansion_budget.activate();
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    assert!(!parser.function.parameter_state_charged);

                    let error = parser.local_declaration().unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    let range = error.span.to_range().unwrap();
                    assert!(!range.is_empty());
                    assert!(source.get(range).is_some());
                    assert_eq!(parser.module.types.len(), type_count);
                    assert_eq!(parser.global_declarations.len(), declaration_count);
                    assert!(!parser.global_declarations.contains_key("values"));
                    assert!(parser.function.symbol_table.lookup("values").is_none());
                    assert_eq!(parser.type_name("Row"), Some(row_type));
                    assert!(parser.function.ir.expressions.is_empty());
                    assert!(parser.function.expression_graph_depths.is_empty());
                    assert!(parser.function.ir.named_expressions.is_empty());
                    assert!(parser.function.ir.local_variables.is_empty());
                    assert!(parser.function.ir.arguments.is_empty());
                    assert!(parser.function.ir.body.is_empty());
                    assert!(parser.function.parameters.is_empty());
                    assert!(parser.module.global_variables.is_empty());
                    assert!(parser.module.functions.is_empty());
                    assert_eq!(parser.dim3_type, None);
                    assert_eq!(parser.uint3_type, None);
                }
            }
        }
    }

    #[test]
    fn incomplete_array_pointer_parameter_proxies_check_budget_before_allocation() {
        for exhaust_bytes in [false, true] {
            let source = "Values";
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let span = parser.lexer.peek().unwrap().1;
            let element = parser.scalar_handle(Scalar::I32, span);
            let values = parser
                .array_type(element, ArraySize::Dynamic, span, span)
                .unwrap();
            let logical = parser.module.types.insert(
                Type {
                    name: None,
                    inner: TypeInner::Pointer {
                        base: values,
                        space: AddressSpace::Storage {
                            access: StorageAccess::LOAD | StorageAccess::STORE,
                        },
                    },
                },
                span,
            );
            let type_count = parser.module.types.len();
            let declaration_count = parser.global_declarations.len();
            assert_eq!(type_count, 3);
            parser.parameter_expansion_budget.activate();
            if exhaust_bytes {
                let preparation = size_of::<FunctionParameterState>();
                let one_type = size_of::<(Type, Span)>();
                let remaining =
                    BYTE_LIMIT - parser.parameter_expansion_budget.bytes - preparation - one_type;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes - 1;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            assert!(!parser.function.parameter_state_charged);

            let error = parser
                .physical_parameter_type(
                    logical,
                    ParameterMode::Pointer {
                        qualifiers: Qualifiers::NONE,
                    },
                    span,
                )
                .unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(parser.module.types.len(), type_count);
            assert_eq!(parser.global_declarations.len(), declaration_count);
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.expression_graph_depths.is_empty());
            assert!(parser.function.ir.named_expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.arguments.is_empty());
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.function.parameters.is_empty());
            assert!(parser.function.pointers.is_empty());
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert!(parser.numeric_storage_types.is_empty());
            assert_eq!(parser.dim3_type, None);
            assert_eq!(parser.uint3_type, None);
            assert_eq!(parser.float_math_functions, [None; 4]);
            assert_eq!(parser.sqrtf_function, None);
            assert_eq!(parser.division_function, None);
            assert_eq!(parser.fmodf_function, None);
            assert_eq!(parser.trigonometry_function, None);
        }
    }

    #[test]
    fn incomplete_array_pointer_types_check_budget_before_allocation() {
        for kind in [FunctionKind::Kernel, FunctionKind::Device] {
            for exhaust_bytes in [false, true] {
                let source = "Values";
                let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                parser.function = FunctionContext::new(kind);
                let span = parser.lexer.peek().unwrap().1;
                let element = parser.scalar_handle(Scalar::I32, span);
                let values = parser
                    .array_type(element, ArraySize::Dynamic, span, span)
                    .unwrap();
                let type_count = parser.module.types.len();
                let declaration_count = parser.global_declarations.len();
                parser.parameter_expansion_budget.activate();
                if exhaust_bytes {
                    let preparation = size_of::<FunctionParameterState>();
                    let remaining =
                        BYTE_LIMIT - parser.parameter_expansion_budget.bytes - preparation;
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                } else {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }
                assert!(!parser.function.parameter_state_charged);

                let error = parser.pointer_type(values, span).unwrap_err();
                assert_eq!(error.message, limit_error(span).message);
                assert_eq!(error.span, span);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_eq!(parser.module.types.len(), type_count);
                assert_eq!(parser.global_declarations.len(), declaration_count);
                assert!(parser.function.ir.expressions.is_empty());
                assert!(parser.function.expression_graph_depths.is_empty());
                assert!(parser.function.ir.named_expressions.is_empty());
                assert!(parser.function.ir.local_variables.is_empty());
                assert!(parser.function.ir.arguments.is_empty());
                assert!(parser.function.ir.body.is_empty());
                assert!(parser.function.parameters.is_empty());
                assert!(parser.function.pointers.is_empty());
                assert!(parser.function.bound_addresses.is_empty());
                assert!(parser.function.bound_address_indices.is_empty());
                assert!(parser.function.bound_references.is_empty());
                assert!(parser.module.global_variables.is_empty());
                assert!(parser.module.functions.is_empty());
                assert!(parser.numeric_storage_types.is_empty());
                assert_eq!(parser.dim3_type, None);
                assert_eq!(parser.uint3_type, None);
                assert_eq!(parser.float_math_functions, [None; 4]);
                assert_eq!(parser.sqrtf_function, None);
                assert_eq!(parser.division_function, None);
                assert_eq!(parser.fmodf_function, None);
                assert_eq!(parser.trigonometry_function, None);
            }
        }
    }

    #[test]
    fn incomplete_array_pointer_aliases_check_budget_before_symbol_insertion() {
        for global in [false, true] {
            for cached in [false, true] {
                for limit in ["nodes", "bytes", "work"] {
                    let source = "View";
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    let span = parser.lexer.peek().unwrap().1;
                    let element = parser.scalar_handle(Scalar::I32, span);
                    let values = parser
                        .array_type(element, ArraySize::Dynamic, span, span)
                        .unwrap();
                    let alias = QualifiedType {
                        ty: TypeSpecifier::Pointer {
                            pointee: values,
                            pointee_qualifiers: Qualifiers::NONE,
                        },
                        qualifiers: Qualifiers::NONE,
                    };
                    if cached {
                        if global {
                            assert!(parser
                                .global_declarations
                                .insert("View", GlobalDeclaration::Type(alias.clone()))
                                .is_none());
                        } else {
                            assert!(parser
                                .function
                                .symbol_table
                                .add("View", Symbol::Type(alias.clone()))
                                .is_none());
                        }
                    }
                    let previous = parser.type_name("View");
                    let type_count = parser.module.types.len();
                    let declaration_count = parser.global_declarations.len();
                    parser.parameter_expansion_budget.activate();
                    match limit {
                        "nodes" => {
                            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                            parser
                                .parameter_expansion_budget
                                .charge_nodes(remaining, span)
                                .unwrap();
                        }
                        "bytes" => {
                            let preparation = size_of::<FunctionParameterState>();
                            let remaining =
                                BYTE_LIMIT - parser.parameter_expansion_budget.bytes - preparation;
                            parser
                                .parameter_expansion_budget
                                .charge_bytes(remaining, span)
                                .unwrap();
                        }
                        "work" => {
                            let remaining = WORK_LIMIT - parser.parameter_expansion_budget.work;
                            parser
                                .parameter_expansion_budget
                                .charge_work(remaining, span)
                                .unwrap();
                        }
                        _ => unreachable!(),
                    }
                    assert!(!parser.function.parameter_state_charged);

                    let error = parser.insert_type("View", alias, span, global).unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.type_name("View"), previous);
                    assert_eq!(parser.module.types.len(), type_count);
                    assert_eq!(parser.global_declarations.len(), declaration_count);
                    assert!(parser.function.ir.expressions.is_empty());
                    assert!(parser.function.expression_graph_depths.is_empty());
                    assert!(parser.function.ir.named_expressions.is_empty());
                    assert!(parser.function.ir.local_variables.is_empty());
                    assert!(parser.function.ir.arguments.is_empty());
                    assert!(parser.function.ir.body.is_empty());
                    assert!(parser.function.parameters.is_empty());
                    assert!(parser.function.pointers.is_empty());
                    assert!(parser.function.bound_addresses.is_empty());
                    assert!(parser.function.bound_address_indices.is_empty());
                    assert!(parser.function.bound_references.is_empty());
                    assert!(parser.module.global_variables.is_empty());
                    assert!(parser.module.functions.is_empty());
                    assert!(parser.numeric_storage_types.is_empty());
                    assert_eq!(parser.dim3_type, None);
                    assert_eq!(parser.uint3_type, None);
                    assert_eq!(parser.float_math_functions, [None; 4]);
                    assert_eq!(parser.sqrtf_function, None);
                    assert_eq!(parser.division_function, None);
                    assert_eq!(parser.fmodf_function, None);
                    assert_eq!(parser.trigonometry_function, None);
                }
            }
        }
    }

    #[test]
    fn incomplete_dynamic_shared_aliases_check_bytes_before_storage_inventory() {
        let source = "extern __shared__ Values values;";
        for (kind, global) in [
            (FunctionKind::Kernel, false),
            (FunctionKind::Device, false),
            (FunctionKind::Kernel, true),
        ] {
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            parser.function = FunctionContext::new(kind);
            let span = parser.lexer.peek().unwrap().1;
            let element = parser.scalar_handle(Scalar::I32, span);
            let values = parser
                .array_type(element, ArraySize::Dynamic, span, span)
                .unwrap();
            let alias = QualifiedType {
                ty: TypeSpecifier::Array(values),
                qualifiers: Qualifiers::NONE,
            };
            assert!(parser
                .global_declarations
                .insert("Values", GlobalDeclaration::Type(alias.clone()))
                .is_none());
            let type_count = parser.module.types.len();
            let declaration_count = parser.global_declarations.len();
            assert_eq!(type_count, 2);
            assert!(parser.numeric_storage_types.is_empty());
            parser.parameter_expansion_budget.activate();
            let inventory_bytes = type_count * size_of::<bool>();
            let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes - inventory_bytes;
            parser
                .parameter_expansion_budget
                .charge_bytes(remaining, span)
                .unwrap();
            assert!(!parser.function.parameter_state_charged);

            let error = parser.dynamic_shared_declaration(global).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty());
            assert!(source.get(range).is_some());
            assert!(!parser.function.parameter_state_charged);
            assert!(parser.numeric_storage_types.is_empty());
            assert_eq!(parser.module.types.len(), type_count);
            assert_eq!(parser.global_declarations.len(), declaration_count);
            assert_eq!(parser.type_name("Values"), Some(alias));
            assert!(!parser.global_declarations.contains_key("values"));
            assert!(!parser.has_dynamic_shared_declaration("values"));
            assert!(parser.function.symbol_table.lookup("values").is_none());
            assert!(parser.function.ir.expressions.is_empty());
            assert!(parser.function.expression_graph_depths.is_empty());
            assert!(parser.function.ir.named_expressions.is_empty());
            assert!(parser.function.ir.local_variables.is_empty());
            assert!(parser.function.ir.arguments.is_empty());
            assert!(parser.function.ir.body.is_empty());
            assert!(parser.function.parameters.is_empty());
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.dim3_type, None);
            assert_eq!(parser.uint3_type, None);
            assert_eq!(parser.float_math_functions, [None; 4]);
            assert_eq!(parser.sqrtf_function, None);
            assert_eq!(parser.division_function, None);
            assert_eq!(parser.fmodf_function, None);
            assert_eq!(parser.trigonometry_function, None);
        }
    }

    #[test]
    fn bitcast_checks_type_and_expression_nodes_before_inserting_types() {
        for available_nodes in [0, 1] {
            let source = "1.5f";
            let span = Span::new(0, source.len() as u32);
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let input = parser.number(source, span).unwrap().handle;
            assert!(parser.module.types.is_empty());
            parser.parameter_expansion_budget.activate();
            parser.prepare_parameter_bindings(span).unwrap();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining - available_nodes, span)
                .unwrap();
            let error = parser.bitcast_scalar(input, Scalar::U32, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert!(parser.module.types.is_empty());
            assert_eq!(parser.function.ir.expressions.len(), 1);
            assert_eq!(parser.function.expression_graph_depths.len(), 1);
            assert!(parser.function.ir.body.is_empty());
        }
    }

    #[test]
    fn bitcast_checks_type_bytes_before_inserting_types() {
        let expression_bytes = size_of::<Expression>() + size_of::<u32>();
        let type_bytes = size_of::<(Type, Span)>();
        for available_bytes in [0, expression_bytes, expression_bytes + type_bytes - 1] {
            let source = "1.5f";
            let span = Span::new(0, source.len() as u32);
            let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
            let input = parser.number(source, span).unwrap().handle;
            assert!(parser.module.types.is_empty());
            parser.parameter_expansion_budget.activate();
            parser.prepare_parameter_bindings(span).unwrap();
            let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
            parser
                .parameter_expansion_budget
                .charge_bytes(remaining - available_bytes, span)
                .unwrap();
            let error = parser.bitcast_scalar(input, Scalar::U32, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert!(parser.module.types.is_empty());
            assert_eq!(parser.function.ir.expressions.len(), 1);
            assert_eq!(parser.function.expression_graph_depths.len(), 1);
            assert!(parser.function.ir.body.is_empty());
        }
    }

    fn fns_budget_parser() -> (Parser<'static>, [Handle<Expression>; 3], Span) {
        let source = "1u 0u 1";
        let span = Span::new(0, source.len() as u32);
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        parser.function = FunctionContext::new(FunctionKind::Kernel);
        parser.function.ir.name = Some(String::from("caller"));
        parser.function.loop_depth = 1;
        parser.function.expression_depth = 2;
        let inputs = [
            parser.number("1u", span).unwrap().handle,
            parser.number("0u", span).unwrap().handle,
            parser.number("1", span).unwrap().handle,
        ];
        parser
            .function
            .ir
            .named_expressions
            .insert(inputs[0], String::from("mask"));
        parser.function.symbol_table.add(
            "marker",
            Symbol::TemplateParameter {
                index: 0,
                scalar: SourceScalar::Scalar(Scalar::U32),
                literal: Some(Literal::U32(7)),
            },
        );
        (parser, inputs, span)
    }

    fn assert_fns_budget_caller(parser: &Parser<'_>, mask: Handle<Expression>) {
        assert!(parser.function.kind == FunctionKind::Kernel);
        assert_eq!(parser.function.ir.name.as_deref(), Some("caller"));
        assert_eq!(parser.function.loop_depth, 1);
        assert_eq!(parser.function.expression_depth, 2);
        assert_eq!(
            parser
                .function
                .ir
                .named_expressions
                .get(&mask)
                .map(String::as_str),
            Some("mask")
        );
        assert!(matches!(
            parser.function.symbol_table.lookup("marker"),
            Some(&Symbol::TemplateParameter {
                index: 0,
                scalar: SourceScalar::Scalar(Scalar::U32),
                literal: Some(Literal::U32(7))
            })
        ));
        assert!(parser.function.ir.local_variables.is_empty());
        assert!(parser.function.ir.arguments.is_empty());
        assert!(parser.function.parameters.is_empty());
    }

    #[test]
    fn frsqrt_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1 2";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let left = parser.number("1u", span).unwrap().handle;
                        parser.call_frsqrt_rn_bits(left, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("reciprocal_root_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![parser.number("1", span).unwrap()];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.frsqrt_rn_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(
                            functions::FunctionCandidate::ReciprocalSqrtRoundNearest,
                            arguments,
                            span,
                        )
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.frsqrt_rn_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn frsqrt_rn_first_call_exhaustion_preserves_prepared_and_unprepared_callers() {
        for prepared in [false, true] {
            for exhaust_bytes in [false, true] {
                let (mut parser, [left, _, _], span) = fns_budget_parser();
                parser.parameter_expansion_budget.activate();
                if prepared {
                    parser.prepare_parameter_bindings(span).unwrap();
                }
                let caller = format!("{:?}", parser.function.ir);
                let depths = parser.function.expression_graph_depths.clone();
                let type_count = parser.module.types.len();
                if exhaust_bytes {
                    let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                } else {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }
                let error = parser.call_frsqrt_rn_bits(left, span).unwrap_err();
                assert_eq!(error.message, limit_error(span).message);
                assert_eq!(error.span, span);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_fns_budget_caller(&parser, left);
                assert_eq!(format!("{:?}", parser.function.ir), caller);
                assert_eq!(parser.function.expression_graph_depths, depths);
                assert_eq!(parser.module.types.len(), type_count);
                assert!(parser.module.global_variables.is_empty());
                assert!(parser.module.functions.is_empty());
                assert_eq!(parser.frsqrt_rn_function, None);
            }
        }
    }

    #[test]
    fn frsqrt_rn_partial_helper_failure_restores_caller_and_keeps_cache_unpublished() {
        for available_nodes in [3, 6, 12, 32, 96, 160] {
            let (mut parser, [left, _, _], span) = fns_budget_parser();
            parser.parameter_expansion_budget.activate();
            parser.prepare_parameter_bindings(span).unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining - available_nodes, span)
                .unwrap();
            let error = parser.call_frsqrt_rn_bits(left, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.frsqrt_rn_function, None);
        }
    }

    #[test]
    fn frsqrt_rn_cached_call_exhaustion_preserves_helper_and_pending_caller_expressions() {
        for exhaust_bytes in [false, true] {
            let (mut parser, [left, right, _], span) = fns_budget_parser();
            let result = parser.call_frsqrt_rn_bits(left, span).unwrap();
            let cached = parser.frsqrt_rn_function.unwrap();
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(
                parser.module.functions[cached].name.as_deref(),
                Some("_naga_frsqrt_rn")
            );
            parser
                .append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: result,
                        right,
                    },
                    span,
                )
                .unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let helper = format!("{:?}", parser.module.functions[cached]);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.call_frsqrt_rn_bits(left, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.module.global_variables.is_empty());
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(parser.frsqrt_rn_function, Some(cached));
            assert_eq!(format!("{:?}", parser.module.functions[cached]), helper);
        }
    }

    #[test]
    fn fsqrt_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let input = parser.number("4.0f", span).unwrap().handle;
                        parser.call_sqrtf(input, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("square_root_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![parser.number("1", span).unwrap()];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.sqrtf_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(functions::FunctionCandidate::Sqrt, arguments, span)
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.sqrtf_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn frcp_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let left = parser.number("1.0f", span).unwrap().handle;
                        let right = parser.number("2.0f", span).unwrap().handle;
                        parser.divide_f32(left, right, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("reciprocal_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![parser.number("1", span).unwrap()];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.division_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(
                            functions::FunctionCandidate::ReciprocalRoundNearest,
                            arguments,
                            span,
                        )
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.division_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn fdiv_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1 2";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let left = parser.number("1.0f", span).unwrap().handle;
                        let right = parser.number("2.0f", span).unwrap().handle;
                        parser.divide_f32(left, right, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("division_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![
                        parser.number("1", span).unwrap(),
                        parser.number("2", span).unwrap()
                    ];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.division_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(
                            functions::FunctionCandidate::DivideRoundNearest,
                            arguments,
                            span,
                        )
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.division_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn fmul_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1 2";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let left = parser.number("1u", span).unwrap().handle;
                        let right = parser.number("0u", span).unwrap().handle;
                        parser.call_fmul_rn_bits(left, right, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("multiplication_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![
                        parser.number("1", span).unwrap(),
                        parser.number("2", span).unwrap()
                    ];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.fmul_rn_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(
                            functions::FunctionCandidate::MultiplyRoundNearest,
                            arguments,
                            span,
                        )
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.fmul_rn_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn fmul_rn_first_call_exhaustion_preserves_prepared_and_unprepared_callers() {
        for prepared in [false, true] {
            for exhaust_bytes in [false, true] {
                let (mut parser, [left, right, _], span) = fns_budget_parser();
                parser.parameter_expansion_budget.activate();
                if prepared {
                    parser.prepare_parameter_bindings(span).unwrap();
                }
                let caller = format!("{:?}", parser.function.ir);
                let depths = parser.function.expression_graph_depths.clone();
                let type_count = parser.module.types.len();
                if exhaust_bytes {
                    let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                } else {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }
                let error = parser.call_fmul_rn_bits(left, right, span).unwrap_err();
                assert_eq!(error.message, limit_error(span).message);
                assert_eq!(error.span, span);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_fns_budget_caller(&parser, left);
                assert_eq!(format!("{:?}", parser.function.ir), caller);
                assert_eq!(parser.function.expression_graph_depths, depths);
                assert_eq!(parser.module.types.len(), type_count);
                assert!(parser.module.global_variables.is_empty());
                assert!(parser.module.functions.is_empty());
                assert_eq!(parser.fmul_rn_function, None);
            }
        }
    }

    #[test]
    fn fmul_rn_partial_helper_failure_restores_caller_and_keeps_cache_unpublished() {
        for available_nodes in [3, 6, 12, 32, 96, 160] {
            let (mut parser, [left, right, _], span) = fns_budget_parser();
            parser.parameter_expansion_budget.activate();
            parser.prepare_parameter_bindings(span).unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining - available_nodes, span)
                .unwrap();
            let error = parser.call_fmul_rn_bits(left, right, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.fmul_rn_function, None);
        }
    }

    #[test]
    fn fmul_rn_cached_call_exhaustion_preserves_helper_and_pending_caller_expressions() {
        for exhaust_bytes in [false, true] {
            let (mut parser, [left, right, _], span) = fns_budget_parser();
            let result = parser.call_fmul_rn_bits(left, right, span).unwrap();
            let cached = parser.fmul_rn_function.unwrap();
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(
                parser.module.functions[cached].name.as_deref(),
                Some("_naga_fmul_rn")
            );
            parser
                .append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: result,
                        right,
                    },
                    span,
                )
                .unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let helper = format!("{:?}", parser.module.functions[cached]);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.call_fmul_rn_bits(left, right, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.module.global_variables.is_empty());
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(parser.fmul_rn_function, Some(cached));
            assert_eq!(format!("{:?}", parser.module.functions[cached]), helper);
        }
    }

    #[test]
    fn fsub_rn_checks_budgets_before_converting_with_cold_and_warm_shared_cache() {
        for cached in [false, true] {
            for prepared in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1 2";
                    let span = Span::new(0, source.len() as u32);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    if cached {
                        let left = parser.number("1u", span).unwrap().handle;
                        let right = parser.number("0u", span).unwrap().handle;
                        parser.call_fadd_rn_bits(left, right, span).unwrap();
                        parser.function = FunctionContext::new(FunctionKind::Kernel);
                    }
                    parser.function.ir.name = Some(String::from("subtraction_caller"));
                    parser.function.loop_depth = 1;
                    let arguments = alloc::vec![
                        parser.number("1", span).unwrap(),
                        parser.number("2", span).unwrap()
                    ];
                    parser.parameter_expansion_budget.activate();
                    if prepared {
                        parser.prepare_parameter_bindings(span).unwrap();
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let depths = parser.function.expression_graph_depths.clone();
                    let types = format!("{:?}", parser.module.types);
                    let functions = format!("{:?}", parser.module.functions);
                    let cache = parser.fadd_rn_function;
                    assert_eq!(cache.is_some(), cached);
                    if exhaust_bytes {
                        let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                        parser
                            .parameter_expansion_budget
                            .charge_bytes(remaining, span)
                            .unwrap();
                    } else {
                        let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                        parser
                            .parameter_expansion_budget
                            .charge_nodes(remaining, span)
                            .unwrap();
                    }
                    let error = parser
                        .lower_call(
                            functions::FunctionCandidate::SubtractRoundNearest,
                            arguments,
                            span,
                        )
                        .unwrap_err();
                    assert_eq!(error.message, limit_error(span).message);
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(parser.function.loop_depth, 1);
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(parser.function.expression_graph_depths, depths);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert_eq!(format!("{:?}", parser.module.functions), functions);
                    assert_eq!(parser.fadd_rn_function, cache);
                    assert!(parser.module.global_variables.is_empty());
                }
            }
        }
    }

    #[test]
    fn fadd_rn_first_call_exhaustion_preserves_prepared_and_unprepared_callers() {
        for prepared in [false, true] {
            for exhaust_bytes in [false, true] {
                let (mut parser, [left, right, _], span) = fns_budget_parser();
                parser.parameter_expansion_budget.activate();
                if prepared {
                    parser.prepare_parameter_bindings(span).unwrap();
                }
                let caller = format!("{:?}", parser.function.ir);
                let depths = parser.function.expression_graph_depths.clone();
                let type_count = parser.module.types.len();
                if exhaust_bytes {
                    let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                    parser
                        .parameter_expansion_budget
                        .charge_bytes(remaining, span)
                        .unwrap();
                } else {
                    let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                    parser
                        .parameter_expansion_budget
                        .charge_nodes(remaining, span)
                        .unwrap();
                }
                let error = parser.call_fadd_rn_bits(left, right, span).unwrap_err();
                assert_eq!(error.message, limit_error(span).message);
                assert_eq!(error.span, span);
                assert!(parser.parameter_expansion_budget.is_exhausted());
                assert_fns_budget_caller(&parser, left);
                assert_eq!(format!("{:?}", parser.function.ir), caller);
                assert_eq!(parser.function.expression_graph_depths, depths);
                assert_eq!(parser.module.types.len(), type_count);
                assert!(parser.module.global_variables.is_empty());
                assert!(parser.module.functions.is_empty());
                assert_eq!(parser.fadd_rn_function, None);
            }
        }
    }

    #[test]
    fn fadd_rn_partial_helper_failure_restores_caller_and_keeps_cache_unpublished() {
        for available_nodes in [3, 6, 12, 32, 96] {
            let (mut parser, [left, right, _], span) = fns_budget_parser();
            parser.parameter_expansion_budget.activate();
            parser.prepare_parameter_bindings(span).unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining - available_nodes, span)
                .unwrap();
            let error = parser.call_fadd_rn_bits(left, right, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.fadd_rn_function, None);
        }
    }

    #[test]
    fn fadd_rn_cached_call_exhaustion_preserves_helper_and_pending_caller_expressions() {
        for exhaust_bytes in [false, true] {
            let (mut parser, [left, right, _], span) = fns_budget_parser();
            let result = parser.call_fadd_rn_bits(left, right, span).unwrap();
            let cached = parser.fadd_rn_function.unwrap();
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(
                parser.module.functions[cached].name.as_deref(),
                Some("_naga_fadd_rn")
            );
            parser
                .append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: result,
                        right,
                    },
                    span,
                )
                .unwrap();
            let caller = format!("{:?}", parser.function.ir);
            let helper = format!("{:?}", parser.module.functions[cached]);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.call_fadd_rn_bits(left, right, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, left);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.module.global_variables.is_empty());
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(parser.fadd_rn_function, Some(cached));
            assert_eq!(format!("{:?}", parser.module.functions[cached]), helper);
        }
    }

    #[test]
    fn fns_first_call_checks_node_and_byte_budget_before_allocating() {
        for exhaust_bytes in [false, true] {
            let (mut parser, [mask, base, offset], span) = fns_budget_parser();
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            parser.parameter_expansion_budget.activate();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.call_fns(mask, base, offset, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, mask);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.fns_function, None);
        }
    }

    #[test]
    fn fns_cached_call_checks_node_and_byte_budget_before_changing_caller() {
        for exhaust_bytes in [false, true] {
            let (mut parser, [mask, base, offset], span) = fns_budget_parser();
            parser.call_fns(mask, base, offset, span).unwrap();
            let cached = parser
                .fns_function
                .expect("completed helper must be cached");
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(parser.module.functions[cached].arguments.len(), 3);
            assert!(parser.module.functions[cached].result.is_some());
            assert!(parser.module.functions[cached]
                .body
                .iter()
                .any(|statement| matches!(*statement, Statement::Return { value: Some(_) })));
            let helper = format!("{:?}", parser.module.functions[cached]);
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            if exhaust_bytes {
                let remaining = BYTE_LIMIT - parser.parameter_expansion_budget.bytes;
                parser
                    .parameter_expansion_budget
                    .charge_bytes(remaining, span)
                    .unwrap();
            } else {
                let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes;
                parser
                    .parameter_expansion_budget
                    .charge_nodes(remaining, span)
                    .unwrap();
            }
            let error = parser.call_fns(mask, base, offset, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, mask);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert_eq!(parser.module.types.len(), type_count);
            assert!(parser.module.global_variables.is_empty());
            assert_eq!(parser.module.functions.len(), 1);
            assert_eq!(parser.fns_function, Some(cached));
            assert_eq!(format!("{:?}", parser.module.functions[cached]), helper);
        }
    }

    #[test]
    fn fns_failed_helper_construction_restores_caller_without_publishing_cache() {
        for available_nodes in [2, 5, 12, 20] {
            let (mut parser, [mask, base, offset], span) = fns_budget_parser();
            let caller = format!("{:?}", parser.function.ir);
            let depths = parser.function.expression_graph_depths.clone();
            let type_count = parser.module.types.len();
            parser.parameter_expansion_budget.activate();
            let remaining = NODE_LIMIT - parser.parameter_expansion_budget.nodes - available_nodes;
            parser
                .parameter_expansion_budget
                .charge_nodes(remaining, span)
                .unwrap();
            let error = parser.call_fns(mask, base, offset, span).unwrap_err();
            assert_eq!(error.message, limit_error(span).message);
            assert_eq!(error.span, span);
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_fns_budget_caller(&parser, mask);
            assert_eq!(format!("{:?}", parser.function.ir), caller);
            assert_eq!(parser.function.expression_graph_depths, depths);
            assert!(parser.module.global_variables.is_empty());
            assert!(parser.module.functions.is_empty());
            assert_eq!(parser.fns_function, None);
            if available_nodes >= 12 {
                assert!(parser.module.types.len() > type_count);
            }
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

    #[test]
    fn member_type_lookup_charges_structure_scan_work_before_searching() {
        for field in ["field_0", "field_15", "missing"] {
            let fields = (0..16)
                .map(|index| format!("int field_{index};"))
                .collect::<String>();
            let source = format!("struct Record {{ {fields} }}; {field}");
            let mut parser = Parser::new(Lexer::new(&source).unwrap(), &Options::default());
            parser.structure_declaration(true).unwrap();
            let TypeSpecifier::Structure(ty) = parser.type_name("Record").unwrap().ty else {
                panic!("expected the declared record type");
            };
            let span = parser.lexer.peek().unwrap().1;
            parser.parameter_expansion_budget = ExpansionBudget::default();
            parser.parameter_expansion_budget.activate();
            parser
                .parameter_expansion_budget
                .charge_work(WORK_LIMIT - 15, span)
                .unwrap();
            let error = parser
                .field_type(&TypeResolution::Handle(ty), field, span)
                .unwrap_err();
            assert!(error.message.contains("limit"), "{error}");
            assert!(parser.parameter_expansion_budget.is_exhausted());
            assert_eq!(error.span, span);
        }
    }
}
