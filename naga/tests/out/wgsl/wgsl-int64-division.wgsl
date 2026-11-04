struct Values {
    signed_scalar: i64,
    unsigned_scalar: u64,
    signed_pair: vec2<i64>,
    unsigned_pair: vec2<u64>,
    signed_triple: vec3<i64>,
    unsigned_triple: vec3<u64>,
    signed_quad: vec4<i64>,
    unsigned_quad: vec4<u64>,
}

@group(0) @binding(0)
var<storage> operands: array<Values>;
@group(0) @binding(1)
var<storage, read_write> quotients: array<Values>;
@group(0) @binding(2)
var<storage, read_write> remainders: array<Values>;

@compute @workgroup_size(1, 1, 1)
fn integer_division() {
    let dividend = operands[0];
    let divisor = operands[1];
    quotients[0] = Values((dividend.signed_scalar / divisor.signed_scalar), (dividend.unsigned_scalar / divisor.unsigned_scalar), (dividend.signed_pair / divisor.signed_pair), (dividend.unsigned_pair / divisor.unsigned_pair), (dividend.signed_triple / divisor.signed_triple), (dividend.unsigned_triple / divisor.unsigned_triple), (dividend.signed_quad / divisor.signed_quad), (dividend.unsigned_quad / divisor.unsigned_quad));
    remainders[0] = Values((dividend.signed_scalar % divisor.signed_scalar), (dividend.unsigned_scalar % divisor.unsigned_scalar), (dividend.signed_pair % divisor.signed_pair), (dividend.unsigned_pair % divisor.unsigned_pair), (dividend.signed_triple % divisor.signed_triple), (dividend.unsigned_triple % divisor.unsigned_triple), (dividend.signed_quad % divisor.signed_quad), (dividend.unsigned_quad % divisor.unsigned_quad));
    return;
}
