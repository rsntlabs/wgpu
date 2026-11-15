@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_frsqrt_rn(input_bits: u32) -> u32 {
    var significand: u32;
    var trial_bit: u32;

    let _e7 = (input_bits & 2147483647u);
    let _e8 = (input_bits & 2147483648u);
    if (_e7 == 0u) {
        return (_e8 | 2139095040u);
    }
    if ((_e8 != 0u) || (_e7 > 2139095040u)) {
        return 2143289344u;
    }
    if (_e7 == 2139095040u) {
        return 0u;
    }
    let _e18 = (_e7 >> 23u);
    let _e19 = (_e7 & 8388607u);
    let _e20 = (_e18 != 0u);
    let _e25 = (countLeadingZeros((_e19 | 1u)) - 8u);
    let _e29 = select((_e19 << (_e25 & 31u)), (_e19 | 8388608u), _e20);
    let _e35 = select((1i - i32(_e25)), i32(_e18), _e20);
    let _e37 = (_e35 - 127i);
    let _e46 = ((-((_e37 + 1i)) >> 1u) + i32((((_e37 & 1i) == 0i) && (_e29 == 8388608u))));
    let _e52 = u32(((198i - _e35) - (_e46 * 2i)));
    significand = 8388608u;
    trial_bit = 22u;
    loop {
        let _e56 = significand;
        let _e57 = trial_bit;
        let _e60 = (_e56 | (1u << (_e57 & 31u)));
        let _e61 = (_e60 << 1u);
        let _e65 = (_e61 & 4095u);
        let _e66 = (_e61 >> 12u);
        let _e67 = (_e65 * _e65);
        let _e71 = ((2u * (_e65 * _e66)) + (_e67 >> 12u));
        let _e74 = ((_e66 * _e66) + (_e71 >> 12u));
        let _e75 = (_e67 & 4095u);
        let _e76 = (_e71 & 4095u);
        let _e77 = (_e74 & 4095u);
        let _e79 = ((_e74 >> 12u) & 4095u);
        let _e81 = (_e74 >> 24u);
        let _e82 = (_e29 & 4095u);
        let _e83 = (_e29 >> 12u);
        let _e108 = (((_e83 * _e81) + ((((_e82 * _e81) + (_e83 * _e79)) + ((((_e82 * _e79) + (_e83 * _e77)) + ((((_e82 * _e77) + (_e83 * _e76)) + ((((_e82 * _e76) + (_e83 * _e75)) + ((_e82 * _e75) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
        significand = select(_e56, _e60, (((71u + u32((_e108 != 0u))) + u32((_e108 >= 2u))) < _e52));
        if (_e57 == 0u) {
            break;
        }
        trial_bit = (_e57 - 1u);
    }
    let _e121 = significand;
    let _e123 = ((_e121 << 1u) + 1u);
    let _e127 = (_e123 & 4095u);
    let _e128 = (_e123 >> 12u);
    let _e129 = (_e127 * _e127);
    let _e133 = ((2u * (_e127 * _e128)) + (_e129 >> 12u));
    let _e136 = ((_e128 * _e128) + (_e133 >> 12u));
    let _e137 = (_e129 & 4095u);
    let _e138 = (_e133 & 4095u);
    let _e139 = (_e136 & 4095u);
    let _e141 = ((_e136 >> 12u) & 4095u);
    let _e143 = (_e136 >> 24u);
    let _e144 = (_e29 & 4095u);
    let _e145 = (_e29 >> 12u);
    let _e170 = (((_e145 * _e143) + ((((_e144 * _e143) + (_e145 * _e141)) + ((((_e144 * _e141) + (_e145 * _e139)) + ((((_e144 * _e139) + (_e145 * _e138)) + ((((_e144 * _e138) + (_e145 * _e137)) + ((_e144 * _e137) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
    let _e181 = (_e121 + u32((((71u + u32((_e170 != 0u))) + u32((_e170 >= 2u))) < _e52)));
    let _e183 = (_e181 >= 16777216u);
    return ((u32(((_e46 + i32(_e183)) + 127i)) << 23u) | (select(_e181, (_e181 >> 1u), _e183) & 8388607u));
}

fn reciprocal_sqrt_value(value: f32) -> f32 {
    let _e2 = gen__naga_frsqrt_rn(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn _frsqrt_rn(value_1: bool) -> i32 {
    var local_14: i32;

    if value_1 {
        local_14 = 7i;
    } else {
        local_14 = 9i;
    }
    let _e6 = local_14;
    return _e6;
}

fn gen__naga_fabsf(input_bits_1: u32) -> u32 {
    let _e2 = (input_bits_1 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn reciprocal_sqrt_round_nearest(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var cursor: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: bool;
    var local_4: bool;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: f32;
    var local_13: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 10u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e18 = gen__naga_frsqrt_rn(bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e18));
    let _e23 = reciprocal_sqrt_value(value_2);
    local = u32((base + 1u));
    let _e29 = local;
    output[_e29] = bitcast<u32>(_e23);
    cursor = 0i;
    let _e33 = cursor;
    cursor = (_e33 + 1i);
    local_2 = u32((index + u32(_e33)));
    let _e40 = local_2;
    let _e42 = input[_e40];
    let _e44 = reciprocal_sqrt_value(bitcast<f32>(_e42));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = bitcast<u32>(_e44);
    local_3 = false;
    if false {
        let _e54 = cursor;
        cursor = (_e54 + 1i);
        let _e59 = gen__naga_frsqrt_rn(bitcast<u32>(f32(_e54)));
        let _e62 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if true {
    } else {
        let _e67 = cursor;
        cursor = (_e67 + 1i);
        let _e72 = gen__naga_frsqrt_rn(bitcast<u32>(f32(_e67)));
        let _e75 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e72)));
        local_4 = (_e75 != 0u);
    }
    let _e78 = cursor;
    local_5 = u32((base + 3u));
    let _e84 = local_5;
    output[_e84] = u32(_e78);
    let _e89 = gen__naga_frsqrt_rn(bitcast<u32>(-(0f)));
    local_6 = u32((base + 4u));
    let _e96 = local_6;
    output[_e96] = bitcast<u32>(bitcast<f32>(_e89));
    local_8 = 2139095040u;
    let _e100 = local_8;
    let _e103 = gen__naga_frsqrt_rn(bitcast<u32>(bitcast<f32>(_e100)));
    local_7 = u32((base + 5u));
    let _e110 = local_7;
    output[_e110] = bitcast<u32>(bitcast<f32>(_e103));
    let _e114 = reciprocal_sqrt_value(f32(4u));
    local_9 = u32((base + 6u));
    let _e120 = local_9;
    output[_e120] = bitcast<u32>(_e114);
    let _e123 = _frsqrt_rn(true);
    local_10 = u32((base + 7u));
    let _e129 = local_10;
    output[_e129] = u32(_e123);
    if true {
        let _e133 = gen__naga_frsqrt_rn(bitcast<u32>(value_2));
        local_12 = bitcast<f32>(_e133);
    } else {
        let _e136 = cursor;
        cursor = (_e136 + 1i);
        let _e141 = gen__naga_frsqrt_rn(bitcast<u32>(f32(_e136)));
        local_12 = bitcast<f32>(_e141);
    }
    let _e145 = local_12;
    local_11 = u32((base + 8u));
    let _e151 = local_11;
    output[_e151] = bitcast<u32>(_e145);
    let _e153 = cursor;
    local_13 = u32((base + 9u));
    let _e159 = local_13;
    output[_e159] = u32(_e153);
}
