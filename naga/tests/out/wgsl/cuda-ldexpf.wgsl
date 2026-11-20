struct type_6 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<vec2<u32>>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_6;

fn kind(value_2: f32) -> u32 {
    return 1u;
}

fn gen__naga_ldexpf(bits: u32, exponent: i32) -> u32 {
    let _e12 = (bits & 2147483647u);
    let _e13 = (bits & 2147483648u);
    if (_e12 > 2139095040u) {
        return 2143289344u;
    }
    if ((_e12 == 0u) || (_e12 == 2139095040u)) {
        return bits;
    }
    let _e21 = (max(countLeadingZeros(_e12), 8u) - 8u);
    let _e23 = ((_e12 << _e21) & 8388607u);
    let _e24 = (_e23 | 8388608u);
    let _e33 = ((max(i32((_e12 >> 23u)), 1i) - i32(_e21)) + clamp(exponent, -512i, 512i));
    if (_e33 >= 255i) {
        return (2139095040u | _e13);
    }
    if (_e33 >= 1i) {
        return (((u32(_e33) << 23u) | _e23) | _e13);
    }
    let _e45 = u32(clamp((1i - _e33), 1i, 25i));
    let _e46 = (_e24 >> _e45);
    let _e47 = (1u << _e45);
    let _e49 = (_e24 & (_e47 - 1u));
    let _e50 = (_e47 >> 1u);
    return ((_e46 + select(0u, 1u, ((_e49 > _e50) || ((_e49 == _e50) && ((_e46 & 1u) != 0u))))) | _e13);
}

@compute @workgroup_size(4, 1, 1)
fn scale_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value: f32;
    var value_1: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 4u));
    let _e18 = input[index].x;
    let value_3 = bitcast<f32>(_e18);
    let _e22 = input[index].y;
    let power = i32(_e22);
    counter = 0u;
    let _e27 = gen__naga_ldexpf(bitcast<u32>(value_3), power);
    output[base] = bitcast<u32>(bitcast<f32>(_e27));
    value = f32();
    value = value_3;
    let _e35 = counter;
    counter = (_e35 + u32(1i));
    let _e39 = value;
    value_1 = i32();
    value_1 = power;
    let _e43 = counter;
    counter = (_e43 + u32(1i));
    let _e47 = value_1;
    let _e49 = gen__naga_ldexpf(bitcast<u32>(_e39), _e47);
    local = u32((base + 1u));
    let _e56 = local;
    output[_e56] = bitcast<u32>(bitcast<f32>(_e49));
    let _e58 = counter;
    local_1 = u32((base + 2u));
    let _e63 = local_1;
    output[_e63] = _e58;
    let _e66 = gen__naga_ldexpf(bitcast<u32>(value_3), power);
    let _e68 = kind(bitcast<f32>(_e66));
    local_2 = u32((base + 3u));
    let _e73 = local_2;
    output[_e73] = _e68;
}
