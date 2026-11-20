use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_libdevice_trigonometry_matches_cuda_spellings() {
    let source = "
        __host__ __device__ float __nv_sinf(float);
        __device__ float __nv_cosf(float);
        __device__ void __nv_sincosf(float,float*,float*);
        __global__ void kernel(float *out, float value) {
            float sine;
            __nv_sincosf(value++, &sine, out);
            out[1] = sine;
            out[2] = __nv_sinf(value);
            out[3] = __nv_cosf(3);
            __nv_sincosf(value, out + 4, out + 4);
        }";
    assert_same_trigonometry_lowering(source, &source.replace("__nv_", ""));
}

fn assert_same_trigonometry_lowering(source: &str, cuda_source: &str) {
    let (libdevice, libdevice_info) = validate(source);
    let (cuda, cuda_info) = validate(cuda_source);
    assert_eq!(
        libdevice
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some("_naga_trigonometry"))
            .count(),
        1
    );
    let expressions = |module: &naga::Module| {
        module.entry_points[0]
            .function
            .expressions
            .iter()
            .map(|(_, expression)| expression.clone())
            .collect::<Vec<_>>()
    };
    assert_eq!(expressions(&libdevice), expressions(&cuda));

    #[cfg(feature = "wgsl-out")]
    {
        use naga::back::wgsl::{write_string, WriterFlags};
        let flags = WriterFlags::EXPLICIT_TYPES;
        assert_eq!(
            write_string(&libdevice, &libdevice_info, flags).unwrap(),
            write_string(&cuda, &cuda_info, flags).unwrap(),
        );
    }
    let _ = (libdevice_info, cuda_info);
}

#[test]
fn cuda_libdevice_trigonometry_rejects_reserved_signatures_and_invalid_calls() {
    for (name, result, parameters, return_body, invalid_calls) in [
        (
            "__nv_sinf",
            "float",
            "float x",
            "return x;",
            ["()", "(p)", "(1, 2)"],
        ),
        (
            "__nv_cosf",
            "float",
            "float x",
            "return x;",
            ["()", "(p)", "(1, 2)"],
        ),
        (
            "__nv_sincosf",
            "void",
            "float x, float *s, float *c",
            "",
            ["(1, p)", "(1, p, q)", "(1, p, nullptr)"],
        ),
    ]
    .into_iter()
    .flat_map(|(name, result, parameters, return_body, invalid_calls)| {
        [name.to_owned(), name.replacen("__nv_", "__nv_fast_", 1)]
            .map(|name| (name, result, parameters, return_body, invalid_calls))
    }) {
        for source in [
            format!("__device__ int {name}({parameters}); __global__ void kernel() {{}}"),
            format!("__device__ {result} {name}({parameters}) {{ {return_body} }} __global__ void kernel() {{}}"),
            format!("using {name} = float; __global__ void kernel() {{}}"),
        ]
        .into_iter()
        .chain(invalid_calls.map(|args| {
            format!("__global__ void kernel(float *p, const float *q) {{ {name}{args}; }}")
        }))
        {
            assert!(parse_str(&source, &Options::default()).is_err(), "{source}");
        }
    }
}

#[test]
fn cuda_libdevice_fast_unary_trigonometry_flushes_input_and_result() {
    use naga::{BinaryOperator, Expression, Handle, Literal, Statement};

    for (name, mode) in [("__nv_fast_sinf", 0), ("__nv_fast_cosf", 1)] {
        let (module, info) = validate(&format!(
            "__device__ float {name}(float);
            __global__ void kernel(float *out, float x) {{ out[0] = {name}(x++); }}"
        ));
        let function = &module.entry_points[0].function;
        let expressions = &function.expressions;
        let check_flush = |handle: Handle<Expression>| {
            let Expression::Select {
                condition,
                accept,
                reject: bits,
            } = expressions[handle]
            else {
                panic!("expected a subnormal flush");
            };
            let binary_literal = |handle: Handle<Expression>, expected_op, expected_constant| {
                let Expression::Binary { op, left, right } = expressions[handle] else {
                    panic!("expected a binary expression");
                };
                assert_eq!(op, expected_op);
                assert_eq!(
                    expressions[right],
                    Expression::Literal(Literal::U32(expected_constant))
                );
                left
            };
            assert_eq!(
                binary_literal(accept, BinaryOperator::And, 0x8000_0000),
                bits
            );
            let exponent = binary_literal(condition, BinaryOperator::Equal, 0);
            assert_eq!(
                binary_literal(exponent, BinaryOperator::And, 0x7f80_0000),
                bits
            );
            bits
        };
        let [(arguments, result)] = function
            .body
            .iter()
            .filter_map(|statement| match statement {
                Statement::Call {
                    function,
                    arguments,
                    result: Some(result),
                } if module.functions[*function].name.as_deref() == Some("_naga_trigonometry") => {
                    Some((arguments, *result))
                }
                _ => None,
            })
            .collect::<Vec<_>>()[..]
        else {
            panic!("expected one trigonometry call");
        };
        assert_eq!(
            expressions[arguments[1]],
            Expression::Literal(Literal::U32(mode))
        );
        let Expression::Bitcast { ty, .. } = expressions[check_flush(arguments[0])] else {
            panic!("expected an input bitcast");
        };
        assert_eq!(
            module.types[ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        let value = function
            .body
            .iter()
            .rev()
            .find_map(|statement| match statement {
                Statement::Store { value, .. } => Some(*value),
                _ => None,
            })
            .unwrap();
        let Expression::Bitcast { expr, ty } = expressions[value] else {
            panic!("expected a bitcast of the flushed result");
        };
        assert_eq!(
            module.types[ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::F32)
        );
        assert_eq!(check_flush(expr), result);

        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = info;
    }
}

#[test]
fn cuda_libdevice_fast_sincosf_matches_cuda_spelling() {
    let source = "
        __host__ __device__ void __nv_fast_sincosf(float,float*,float*);
        __global__ void kernel(float *out, float x) {
            float sine;
            unsigned cursor = 0;
            __nv_fast_sincosf(x++, &sine, out + cursor++);
            out[1] = sine;
            __nv_fast_sincosf(x, out + 2, out + 2);
        }";
    assert_same_trigonometry_lowering(source, &source.replace("__nv_fast_sincosf", "__sincosf"));
}
