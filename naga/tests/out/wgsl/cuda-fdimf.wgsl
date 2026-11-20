@group(0) @binding(0)
var<storage> input: array<vec2<u32>>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn kind(value_2: f32) -> u32 {
    return 1u;
}

fn gen__naga_fadd_rn(left_bits: u32, right_bits: u32) -> u32 {
    let _e9 = (left_bits & 2147483647u);
    let _e10 = (right_bits & 2147483647u);
    let _e11 = (left_bits & 2147483648u);
    let _e12 = (right_bits & 2147483648u);
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    let _e16 = (_e9 == 2139095040u);
    let _e17 = (_e10 == 2139095040u);
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if _e16 {
        return left_bits;
    }
    if _e17 {
        return right_bits;
    }
    let _e22 = (_e9 >= _e10);
    let _e23 = select(_e10, _e9, _e22);
    let _e24 = select(_e9, _e10, _e22);
    let _e25 = select(_e12, _e11, _e22);
    let _e29 = (_e23 >> 23u);
    let _e30 = (_e24 >> 23u);
    let _e31 = (_e29 != 0u);
    let _e32 = (_e30 != 0u);
    let _e39 = (((_e23 & 8388607u) | select(0u, 8388608u, _e31)) << 3u);
    let _e40 = (((_e24 & 8388607u) | select(0u, 8388608u, _e32)) << 3u);
    let _e41 = select(1u, _e29, _e31);
    let _e43 = (_e41 - select(1u, _e30, _e32));
    let _e48 = (_e43 & 31u);
    let _e59 = select(u32((_e40 != 0u)), ((_e40 >> _e48) | u32(((_e40 & ((1u << _e48) - 1u)) != 0u))), (_e43 < 32u));
    let _e62 = select((_e39 - _e59), (_e39 + _e59), (_e11 == _e12));
    if (_e62 == 0u) {
        return (_e11 & _e12);
    }
    let _e66 = (_e62 >= 134217728u);
    let _e71 = (1u & 31u);
    let _e83 = select(_e62, select(u32((_e62 != 0u)), ((_e62 >> _e71) | u32(((_e62 & ((1u << _e71) - 1u)) != 0u))), (1u < 32u)), _e66);
    let _e85 = (_e41 + u32(_e66));
    let _e90 = min((countLeadingZeros(_e83) - 5u), (_e85 - 1u));
    let _e91 = (_e83 << _e90);
    let _e95 = (_e91 & 7u);
    let _e96 = (_e91 >> 3u);
    let _e104 = (_e96 + u32(((_e95 > 4u) || ((_e95 == 4u) && ((_e96 & 1u) != 0u)))));
    let _e106 = (_e104 >= 16777216u);
    let _e108 = select(_e104, (_e104 >> 1u), _e106);
    let _e110 = ((_e85 - _e90) + u32(_e106));
    if (_e110 >= 255u) {
        return (_e25 | 2139095040u);
    }
    return (_e25 | ((select(0u, _e110, (_e108 >= 8388608u)) << 23u) | (_e108 & 8388607u)));
}

@compute @workgroup_size(4, 1, 1)
fn positive_differences(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value: f32;
    var value_1: f32;

    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= 26u) {
        return;
    }
    let base = (4u + (index * 4u));
    let _e16 = input[index].x;
    let x = bitcast<f32>(_e16);
    let _e20 = input[index].y;
    let y = bitcast<f32>(_e20);
    counter = 0u;
    let _e24 = bitcast<u32>(x);
    let _e25 = bitcast<u32>(y);
    let _e34 = gen__naga_fadd_rn(_e24, (_e25 ^ 2147483648u));
    output[base] = bitcast<u32>(bitcast<f32>(select(_e34, 0u, ((_e34 >= 2147483648u) || ((_e24 == _e25) && ((_e24 & 2147483647u) == 2139095040u))))));
    value = f32();
    value = x;
    let _e46 = counter;
    counter = (_e46 + u32(1i));
    let _e50 = value;
    value_1 = f32();
    value_1 = y;
    let _e54 = counter;
    counter = (_e54 + u32(1i));
    let _e58 = value_1;
    let _e59 = bitcast<u32>(_e50);
    let _e60 = bitcast<u32>(_e58);
    let _e69 = gen__naga_fadd_rn(_e59, (_e60 ^ 2147483648u));
    local = u32((base + 1u));
    let _e80 = local;
    output[_e80] = bitcast<u32>(bitcast<f32>(select(_e69, 0u, ((_e69 >= 2147483648u) || ((_e59 == _e60) && ((_e59 & 2147483647u) == 2139095040u))))));
    let _e82 = counter;
    local_1 = u32((base + 2u));
    let _e87 = local_1;
    output[_e87] = _e82;
    let _e89 = bitcast<u32>(x);
    let _e90 = bitcast<u32>(y);
    let _e99 = gen__naga_fadd_rn(_e89, (_e90 ^ 2147483648u));
    let _e105 = kind(bitcast<f32>(select(_e99, 0u, ((_e99 >= 2147483648u) || ((_e89 == _e90) && ((_e89 & 2147483647u) == 2139095040u))))));
    local_2 = u32((base + 3u));
    let _e110 = local_2;
    output[_e110] = _e105;
}
