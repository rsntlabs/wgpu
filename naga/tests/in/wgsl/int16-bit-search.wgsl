enable wgpu_int16;

struct Values {
    signed_scalar: i16,
    unsigned_scalar: u16,
    signed_pair: vec2<i16>,
    unsigned_pair: vec2<u16>,
    signed_triple: vec3<i16>,
    unsigned_triple: vec3<u16>,
    signed_quad: vec4<i16>,
    unsigned_quad: vec4<u16>,
}

struct Results {
    leading_zeros: Values,
    trailing_zeros: Values,
    first_leading_bit: Values,
    first_trailing_bit: Values,
}

@group(0) @binding(0)
var<storage> input: array<Values>;
@group(0) @binding(1)
var<storage, read_write> output: array<Results>;

@compute @workgroup_size(1)
fn integer_bit_search() {
    let value = input[0];
    output[0].leading_zeros = Values(
        countLeadingZeros(value.signed_scalar),
        countLeadingZeros(value.unsigned_scalar),
        countLeadingZeros(value.signed_pair),
        countLeadingZeros(value.unsigned_pair),
        countLeadingZeros(value.signed_triple),
        countLeadingZeros(value.unsigned_triple),
        countLeadingZeros(value.signed_quad),
        countLeadingZeros(value.unsigned_quad),
    );
    output[0].trailing_zeros = Values(
        countTrailingZeros(value.signed_scalar),
        countTrailingZeros(value.unsigned_scalar),
        countTrailingZeros(value.signed_pair),
        countTrailingZeros(value.unsigned_pair),
        countTrailingZeros(value.signed_triple),
        countTrailingZeros(value.unsigned_triple),
        countTrailingZeros(value.signed_quad),
        countTrailingZeros(value.unsigned_quad),
    );
    output[0].first_leading_bit = Values(
        firstLeadingBit(value.signed_scalar),
        firstLeadingBit(value.unsigned_scalar),
        firstLeadingBit(value.signed_pair),
        firstLeadingBit(value.unsigned_pair),
        firstLeadingBit(value.signed_triple),
        firstLeadingBit(value.unsigned_triple),
        firstLeadingBit(value.signed_quad),
        firstLeadingBit(value.unsigned_quad),
    );
    output[0].first_trailing_bit = Values(
        firstTrailingBit(value.signed_scalar),
        firstTrailingBit(value.unsigned_scalar),
        firstTrailingBit(value.signed_pair),
        firstTrailingBit(value.unsigned_pair),
        firstTrailingBit(value.signed_triple),
        firstTrailingBit(value.unsigned_triple),
        firstTrailingBit(value.signed_quad),
        firstTrailingBit(value.unsigned_quad),
    );
}
