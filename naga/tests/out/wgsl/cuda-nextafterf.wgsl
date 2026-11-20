@group(0) @binding(0)
var<storage> input: array<vec2<u32>>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn kind(value_2: f32) -> u32 {
    return 1u;
}

fn gen__naga_nextafterf(from_bits: u32, toward_bits: u32) -> u32 {
    let _e8 = (from_bits & 2147483647u);
    let _e9 = (toward_bits & 2147483647u);
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    let _e13 = (_e8 == 0u);
    if ((_e13 && (_e9 == 0u)) || (from_bits == toward_bits)) {
        return toward_bits;
    }
    if _e13 {
        return ((toward_bits & 2147483648u) | 1u);
    }
    return select((from_bits - 1u), (from_bits + 1u), (((from_bits ^ toward_bits) < 2147483648u) && (_e9 > _e8)));
}

@compute @workgroup_size(4, 1, 1)
fn next_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value: f32;
    var value_1: f32;

    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= 24u) {
        return;
    }
    let base = (4u + (index * 4u));
    let _e16 = input[index].x;
    let x = bitcast<f32>(_e16);
    let _e20 = input[index].y;
    let y = bitcast<f32>(_e20);
    counter = 0u;
    let _e26 = gen__naga_nextafterf(bitcast<u32>(x), bitcast<u32>(y));
    output[base] = bitcast<u32>(bitcast<f32>(_e26));
    value = f32();
    value = x;
    let _e34 = counter;
    counter = (_e34 + u32(1i));
    let _e38 = value;
    value_1 = f32();
    value_1 = y;
    let _e42 = counter;
    counter = (_e42 + u32(1i));
    let _e46 = value_1;
    let _e49 = gen__naga_nextafterf(bitcast<u32>(_e38), bitcast<u32>(_e46));
    local = u32((base + 1u));
    let _e56 = local;
    output[_e56] = bitcast<u32>(bitcast<f32>(_e49));
    let _e58 = counter;
    local_1 = u32((base + 2u));
    let _e63 = local_1;
    output[_e63] = _e58;
    let _e67 = gen__naga_nextafterf(bitcast<u32>(x), bitcast<u32>(y));
    let _e69 = kind(bitcast<f32>(_e67));
    local_2 = u32((base + 3u));
    let _e74 = local_2;
    output[_e74] = _e69;
}
