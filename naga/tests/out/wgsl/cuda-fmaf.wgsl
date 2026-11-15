@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_fmaf_rn(left_bits: u32, right_bits: u32, addend_bits: u32) -> u32 {
    var stage: u32;
    var stage_1: u32;
    var stage_2: u32;
    var stage_3: u32;
    var stage_4: u32;
    var stage_5: u32;
    var stage_6: i32;
    var stage_7: i32;
    var stage_8: u32;
    var stage_9: i32;
    var stage_10: u32;
    var stage_11: u32;
    var stage_12: u32;
    var stage_13: u32;
    var stage_14: i32;
    var stage_15: i32;
    var stage_16: u32;
    var stage_17: u32;

    let _e12 = (left_bits & 2147483647u);
    let _e14 = (_e12 == 2139095040u);
    let _e15 = (_e12 == 0u);
    let _e16 = (right_bits & 2147483647u);
    let _e18 = (_e16 == 2139095040u);
    let _e19 = (_e16 == 0u);
    let _e20 = (addend_bits & 2147483647u);
    let _e22 = (_e20 == 2139095040u);
    let _e23 = (_e20 == 0u);
    if (((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u)) {
        return 2143289344u;
    }
    if ((_e15 && _e18) || (_e19 && _e14)) {
        return 2143289344u;
    }
    let _e30 = ((left_bits ^ right_bits) & 2147483648u);
    let _e31 = (addend_bits & 2147483648u);
    let _e32 = (_e30 != _e31);
    let _e33 = (_e14 || _e18);
    if (_e33 && (_e22 && _e32)) {
        return 2143289344u;
    }
    if _e33 {
        return (_e30 | 2139095040u);
    }
    if _e22 {
        return addend_bits;
    }
    let _e37 = (_e15 || _e19);
    if (_e37 && _e23) {
        return (_e30 & _e31);
    }
    if _e37 {
        return addend_bits;
    }
    let _e40 = (_e12 >> 23u);
    let _e41 = (_e40 != 0u);
    let _e44 = ((_e12 & 8388607u) | select(0u, 8388608u, _e41));
    let _e49 = (_e16 >> 23u);
    let _e50 = (_e49 != 0u);
    let _e53 = ((_e16 & 8388607u) | select(0u, 8388608u, _e50));
    let _e58 = (_e20 >> 23u);
    let _e59 = (_e58 != 0u);
    let _e62 = ((_e20 & 8388607u) | select(0u, 8388608u, _e59));
    let _e69 = (_e44 & 4095u);
    let _e70 = (_e44 >> 12u);
    let _e71 = (_e53 & 4095u);
    let _e72 = (_e53 >> 12u);
    let _e73 = (_e69 * _e71);
    let _e78 = (((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u));
    let _e81 = ((_e70 * _e72) + (_e78 >> 12u));
    stage = (((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u));
    let _e92 = stage;
    stage_1 = (_e81 >> 8u);
    let _e94 = stage_1;
    let _e107 = i32(select((31u - countLeadingZeros((_e92 | 1u))), (63u - countLeadingZeros((_e94 | 1u))), (_e94 != 0u)));
    let _e109 = (50i - _e107);
    let _e119 = (u32(min(max(_e109, 0i), 31i)) & 31u);
    let _e143 = (_e109 < 32i);
    stage_2 = select(0u, (_e92 << _e119), _e143);
    let _e147 = stage_2;
    stage_3 = select((_e92 << (u32(min(max((_e109 - 32i), 0i), 31i)) & 31u)), ((_e94 << _e119) | select(0u, (_e92 >> (u32(min(max((32i - _e109), 0i), 31i)) & 31u)), (_e109 > 0i))), _e143);
    let _e149 = stage_3;
    let _e151 = (((i32(select(1u, _e40, _e41)) - 150i) + (i32(select(1u, _e49, _e50)) - 150i)) + _e107);
    let _e164 = i32(select((31u - countLeadingZeros((_e62 | 1u))), (63u - countLeadingZeros((0u | 1u))), (0u != 0u)));
    let _e165 = (50i - _e164);
    let _e175 = (u32(min(max(_e165, 0i), 31i)) & 31u);
    let _e199 = (_e165 < 32i);
    stage_4 = select(0u, (_e62 << _e175), _e199);
    let _e203 = stage_4;
    stage_5 = select((_e62 << (u32(min(max((_e165 - 32i), 0i), 31i)) & 31u)), ((0u << _e175) | select(0u, (_e62 >> (u32(min(max((32i - _e165), 0i), 31i)) & 31u)), (_e165 > 0i))), _e199);
    let _e205 = stage_5;
    let _e207 = select(((i32(select(1u, _e58, _e59)) - 150i) + _e164), _e151, _e23);
    let _e216 = ((_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203)))));
    let _e217 = select(_e147, _e203, _e216);
    let _e218 = select(_e149, _e205, _e216);
    let _e219 = select(_e203, _e147, _e216);
    let _e220 = select(_e205, _e149, _e216);
    stage_6 = select(_e151, _e207, _e216);
    let _e225 = stage_6;
    stage_7 = select(_e207, _e151, _e216);
    let _e227 = stage_7;
    stage_8 = select(_e30, _e31, _e216);
    let _e229 = stage_8;
    stage_9 = (_e225 - _e227);
    let _e232 = stage_9;
    let _e244 = (u32(min(max(_e232, 0i), 31i)) & 31u);
    let _e272 = (u32(min(max((_e232 - 32i), 0i), 31i)) & 31u);
    let _e281 = (_e232 < 32i);
    let _e287 = (_e232 < 64i);
    let _e290 = (0i - _e232);
    let _e300 = (u32(min(max(_e290, 0i), 31i)) & 31u);
    let _e324 = (_e290 < 32i);
    let _e327 = (_e232 <= 0i);
    stage_10 = select(select(u32(((_e220 | _e219) != 0u)), select(((_e220 >> _e272) | u32((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u))), (((_e219 >> _e244) | select(0u, (_e220 << (u32(min(max((32i - _e232), 0i), 31i)) & 31u)), (_e232 > 0i))) | u32(((_e219 & ((1u << _e244) - 1u)) != 0u))), _e281), _e287), select(0u, (_e219 << _e300), _e324), _e327);
    let _e331 = stage_10;
    stage_11 = select(select(0u, select(0u, (_e220 >> _e244), _e281), _e287), select((_e219 << (u32(min(max((_e290 - 32i), 0i), 31i)) & 31u)), ((_e220 << _e300) | select(0u, (_e219 >> (u32(min(max((32i - _e290), 0i), 31i)) & 31u)), (_e290 > 0i))), _e324), _e327);
    let _e333 = stage_11;
    let _e334 = (_e217 + _e331);
    stage_12 = select(_e334, (_e217 - _e331), _e32);
    let _e347 = stage_12;
    stage_13 = select(((_e218 + _e333) + u32((_e334 < _e217))), ((_e218 - _e333) - u32((_e217 < _e331))), _e32);
    let _e349 = stage_13;
    if ((_e347 | _e349) == 0u) {
        return 0u;
    }
    let _e365 = (_e225 - 50i);
    let _e370 = max(((i32(select((31u - countLeadingZeros((_e347 | 1u))), (63u - countLeadingZeros((_e349 | 1u))), (_e349 != 0u))) + _e365) - 23i), -149i);
    stage_14 = _e370;
    let _e375 = stage_14;
    stage_15 = ((_e370 - _e365) - 3i);
    let _e377 = stage_15;
    let _e389 = (u32(min(max(_e377, 0i), 31i)) & 31u);
    let _e417 = (u32(min(max((_e377 - 32i), 0i), 31i)) & 31u);
    let _e426 = (_e377 < 32i);
    let _e432 = (_e377 < 64i);
    let _e435 = (0i - _e377);
    let _e445 = (u32(min(max(_e435, 0i), 31i)) & 31u);
    let _e469 = (_e435 < 32i);
    let _e472 = (_e377 <= 0i);
    stage_16 = select(select(u32(((_e349 | _e347) != 0u)), select(((_e349 >> _e417) | u32((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u))), (((_e347 >> _e389) | select(0u, (_e349 << (u32(min(max((32i - _e377), 0i), 31i)) & 31u)), (_e377 > 0i))) | u32(((_e347 & ((1u << _e389) - 1u)) != 0u))), _e426), _e432), select(0u, (_e347 << _e445), _e469), _e472);
    let _e476 = stage_16;
    stage_17 = select(select(0u, select(0u, (_e349 >> _e389), _e426), _e432), select((_e347 << (u32(min(max((_e435 - 32i), 0i), 31i)) & 31u)), ((_e349 << _e445) | select(0u, (_e347 >> (u32(min(max((32i - _e435), 0i), 31i)) & 31u)), (_e435 > 0i))), _e469), _e472);
    let _e481 = (_e476 >> 3u);
    let _e482 = (_e476 & 7u);
    let _e490 = (_e481 + u32(((_e482 > 4u) || ((_e482 == 4u) && ((_e481 & 1u) != 0u)))));
    let _e492 = (_e490 >= 16777216u);
    let _e494 = select(_e490, (_e490 >> 1u), _e492);
    let _e498 = ((_e375 + i32(_e492)) + 150i);
    if (_e498 >= 255i) {
        return (_e229 | 2139095040u);
    }
    return (_e229 | ((select(0u, u32(max(_e498, 0i)), (_e494 >= 8388608u)) << 23u) | (_e494 & 8388607u)));
}

fn plain_fused_value(first: f32, second: f32, third: f32) -> f32 {
    let _e6 = gen__naga_fmaf_rn(bitcast<u32>(first), bitcast<u32>(second), bitcast<u32>(third));
    return bitcast<f32>(_e6);
}

fn fmaf(first_1: bool, second_1: bool, third_1: bool) -> i32 {
    var local_19: i32;

    if first_1 {
        local_19 = 7i;
    } else {
        local_19 = 9i;
    }
    let _e6 = local_19;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn plain_fused(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var cursor: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: bool;
    var local_9: bool;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: f32;
    var local_17: u32;
    var local_18: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 11u));
    local = u32((index * 3u));
    let _e17 = local;
    let _e20 = input[_e17];
    let first_2 = bitcast<f32>(_e20);
    local_1 = u32(((index * 3u) + 1u));
    let _e28 = local_1;
    let _e30 = input[_e28];
    let second_2 = bitcast<f32>(_e30);
    local_2 = u32(((index * 3u) + 2u));
    let _e38 = local_2;
    let _e40 = input[_e38];
    let third_2 = bitcast<f32>(_e40);
    let _e45 = gen__naga_fmaf_rn(bitcast<u32>(first_2), bitcast<u32>(second_2), bitcast<u32>(third_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e45));
    let _e50 = plain_fused_value(first_2, second_2, third_2);
    local_3 = u32((base + 1u));
    let _e56 = local_3;
    output[_e56] = bitcast<u32>(_e50);
    cursor = 0i;
    let _e62 = cursor;
    cursor = (_e62 + 1i);
    local_5 = u32(((index * 3u) + u32(_e62)));
    let _e69 = local_5;
    let _e71 = input[_e69];
    let _e75 = cursor;
    cursor = (_e75 + 1i);
    local_6 = u32(((index * 3u) + u32(_e75)));
    let _e82 = local_6;
    let _e84 = input[_e82];
    let _e88 = cursor;
    cursor = (_e88 + 1i);
    local_7 = u32(((index * 3u) + u32(_e88)));
    let _e95 = local_7;
    let _e97 = input[_e95];
    let _e99 = plain_fused_value(bitcast<f32>(_e71), bitcast<f32>(_e84), bitcast<f32>(_e97));
    local_4 = u32((base + 2u));
    let _e105 = local_4;
    output[_e105] = bitcast<u32>(_e99);
    local_8 = false;
    if false {
        let _e109 = cursor;
        cursor = (_e109 + 1i);
        let _e116 = gen__naga_fmaf_rn(bitcast<u32>(f32(_e109)), bitcast<u32>(first_2), bitcast<u32>(second_2));
        let _e119 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e116)));
        local_8 = (_e119 != 0u);
    }
    local_9 = true;
    if true {
    } else {
        let _e124 = cursor;
        cursor = (_e124 + 1i);
        let _e131 = gen__naga_fmaf_rn(bitcast<u32>(first_2), bitcast<u32>(f32(_e124)), bitcast<u32>(second_2));
        let _e134 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e131)));
        local_9 = (_e134 != 0u);
    }
    let _e137 = cursor;
    local_10 = u32((base + 3u));
    let _e143 = local_10;
    output[_e143] = u32(_e137);
    let _e153 = gen__naga_fmaf_rn(bitcast<u32>(-(0f)), bitcast<u32>(1f), bitcast<u32>(-(0f)));
    local_11 = u32((base + 4u));
    let _e160 = local_11;
    output[_e160] = bitcast<u32>(bitcast<f32>(_e153));
    let _e169 = gen__naga_fmaf_rn(bitcast<u32>(-(0f)), bitcast<u32>(1f), bitcast<u32>(0f));
    local_12 = u32((base + 5u));
    let _e176 = local_12;
    output[_e176] = bitcast<u32>(bitcast<f32>(_e169));
    let _e184 = plain_fused_value(f32(2i), f32(3u), f32(4i));
    local_13 = u32((base + 6u));
    let _e190 = local_13;
    output[_e190] = bitcast<u32>(_e184);
    let _e195 = fmaf(true, false, true);
    local_14 = u32((base + 7u));
    let _e201 = local_14;
    output[_e201] = u32(_e195);
    if true {
        let _e207 = gen__naga_fmaf_rn(bitcast<u32>(first_2), bitcast<u32>(second_2), bitcast<u32>(third_2));
        local_16 = bitcast<f32>(_e207);
    } else {
        let _e210 = cursor;
        cursor = (_e210 + 1i);
        let _e217 = gen__naga_fmaf_rn(bitcast<u32>(f32(_e210)), bitcast<u32>(first_2), bitcast<u32>(second_2));
        local_16 = bitcast<f32>(_e217);
    }
    let _e221 = local_16;
    local_15 = u32((base + 8u));
    let _e227 = local_15;
    output[_e227] = bitcast<u32>(_e221);
    let _e229 = cursor;
    local_17 = u32((base + 9u));
    let _e235 = local_17;
    output[_e235] = u32(_e229);
    let _e240 = gen__naga_fmaf_rn(bitcast<u32>(first_2), bitcast<u32>(second_2), bitcast<u32>(third_2));
    local_18 = u32((base + 10u));
    let _e247 = local_18;
    output[_e247] = bitcast<u32>(bitcast<f32>(_e240));
}
