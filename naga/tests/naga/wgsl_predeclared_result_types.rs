#![cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]

use naga::back::wgsl::WriterFlags;
use naga::valid::{Capabilities, ValidationFlags, Validator};

#[track_caller]
fn roundtrip(source: &str, flags: WriterFlags) -> String {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = Validator::new(ValidationFlags::all(), Capabilities::empty())
        .validate(&module)
        .unwrap();
    let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
    let reparsed = naga::front::wgsl::parse_str(&output)
        .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
    Validator::new(ValidationFlags::all(), Capabilities::empty())
        .validate(&reparsed)
        .unwrap();
    output
}

#[test]
fn wgsl_writer_infers_signed_and_unsigned_compare_exchange_result_types() {
    let source = "@group(0) @binding(0) var<storage, read_write> signed_counter: atomic<i32>;
        @group(0) @binding(1) var<storage, read_write> unsigned_counter: atomic<u32>;
        @group(0) @binding(2) var<storage, read_write> output: array<i32>;
        @compute @workgroup_size(1) fn main() {
            let signed_result = atomicCompareExchangeWeak(&signed_counter, 0i, 1i);
            let unsigned_result = atomicCompareExchangeWeak(&unsigned_counter, 0u, 1u);
            output[0] = signed_result.old_value;
            output[1] = select(0i, 1i, signed_result.exchanged);
            output[2] = signed_result.old_value + select(0i, 1i, signed_result.exchanged);
            output[3] = i32(unsigned_result.old_value);
            output[4] = select(0i, 1i, unsigned_result.exchanged);
            output[5] = i32(unsigned_result.old_value) + select(0i, 1i, unsigned_result.exchanged);
        }";
    roundtrip(source, WriterFlags::EXPLICIT_TYPES);
}

#[test]
fn wgsl_writer_infers_runtime_scalar_and_vector_modf_and_frexp_result_types() {
    let source = "@group(0) @binding(0) var<storage, read> input: array<vec2<f32>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec2<f32>>;
        @compute @workgroup_size(1) fn main() {
            let scalar = input[0].x;
            let pair = input[1];
            let scalar_fraction = modf(scalar);
            let scalar_exponent = frexp(scalar);
            let vector_fraction = modf(pair);
            let vector_exponent = frexp(pair);
            output[0] = vec2<f32>(scalar_fraction.fract, scalar_fraction.whole);
            output[1] = vec2<f32>(scalar_fraction.fract + scalar_fraction.whole,
                scalar_exponent.fract + f32(scalar_exponent.exp));
            output[2] = vec2<f32>(scalar_exponent.fract, f32(scalar_exponent.exp));
            output[3] = vector_fraction.fract;
            output[4] = vector_fraction.whole;
            output[5] = vector_fraction.fract + vector_fraction.whole;
            output[6] = vector_exponent.fract;
            output[7] = vec2<f32>(vector_exponent.exp);
            output[8] = vector_exponent.fract + vec2<f32>(vector_exponent.exp);
        }";
    roundtrip(source, WriterFlags::EXPLICIT_TYPES);
}

#[test]
fn wgsl_writer_keeps_explicit_annotations_for_ordinary_result_types() {
    let source = "struct Payload { left: f32, right: f32, }
        @group(0) @binding(0) var<storage, read> input: array<f32>;
        @group(0) @binding(1) var<storage, read_write> output: array<f32>;
        fn make_payload(left: f32, right: f32) -> Payload { return Payload(left, right); }
        @compute @workgroup_size(1) fn main() {
            let retained_scalar = input[0] + 1.0;
            let retained_vector = vec2<f32>(retained_scalar, input[1]);
            let retained_record = make_payload(retained_vector.x, retained_vector.y);
            output[0] = retained_scalar;
            output[1] = retained_record.left;
            output[2] = retained_record.right;
            output[3] = retained_record.left + retained_record.right + retained_scalar;
            output[4] = retained_vector.x + retained_vector.y;
        }";
    let output = roundtrip(source, WriterFlags::EXPLICIT_TYPES);
    assert!(output.contains("let retained_scalar: f32 ="), "{output}");
    assert!(
        output.contains("let retained_vector: vec2<f32> ="),
        "{output}"
    );
    assert!(
        output.contains("let retained_record: Payload ="),
        "{output}"
    );
    roundtrip(source, WriterFlags::empty());
}
