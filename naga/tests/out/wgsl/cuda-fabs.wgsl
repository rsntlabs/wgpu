struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn fabs(value_1: vec2<f32>) -> vec2<f32> {
    var value_2: vec2<f32>;

    value_2 = value_1;
    let _e3 = value_2.x;
    let _e5 = gen__naga_fabsf(bitcast<u32>(_e3));
    let _e8 = value_2.y;
    let _e10 = gen__naga_fabsf(bitcast<u32>(_e8));
    return vec2<f32>(bitcast<f32>(_e5), bitcast<f32>(_e10));
}

fn fabs_1(value_3: float3_) -> float3_ {
    var value_4: float3_;

    value_4 = value_3;
    let _e3 = value_4.x;
    let _e5 = gen__naga_fabsf(bitcast<u32>(_e3));
    let _e8 = value_4.y;
    let _e10 = gen__naga_fabsf(bitcast<u32>(_e8));
    let _e13 = value_4.z;
    let _e15 = gen__naga_fabsf(bitcast<u32>(_e13));
    return float3_(bitcast<f32>(_e5), bitcast<f32>(_e10), bitcast<f32>(_e15));
}

fn fabs_2(value_5: vec4<f32>) -> vec4<f32> {
    var value_6: vec4<f32>;

    value_6 = value_5;
    let _e3 = value_6.x;
    let _e5 = gen__naga_fabsf(bitcast<u32>(_e3));
    let _e8 = value_6.y;
    let _e10 = gen__naga_fabsf(bitcast<u32>(_e8));
    let _e13 = value_6.z;
    let _e15 = gen__naga_fabsf(bitcast<u32>(_e13));
    let _e18 = value_6.w;
    let _e20 = gen__naga_fabsf(bitcast<u32>(_e18));
    return vec4<f32>(bitcast<f32>(_e5), bitcast<f32>(_e10), bitcast<f32>(_e15), bitcast<f32>(_e20));
}

fn absolute(value_7: f32) -> f32 {
    let _e2 = gen__naga_fabsf(bitcast<u32>(value_7));
    return bitcast<f32>(_e2);
}

fn converted_absolute(value_8: i32) -> f32 {
    let _e3 = gen__naga_fabsf(bitcast<u32>(f32(value_8)));
    return bitcast<f32>(_e3);
}

fn converted_absolute_1(value_9: u32) -> f32 {
    let _e3 = gen__naga_fabsf(bitcast<u32>(f32(value_9)));
    return bitcast<f32>(_e3);
}

fn converted_absolute_2(value_10: bool) -> f32 {
    let _e3 = gen__naga_fabsf(bitcast<u32>(f32(value_10)));
    return bitcast<f32>(_e3);
}

fn fabs_3(value_11: i32) -> i32 {
    return (value_11 + 40i);
}

fn fabs_4(value_12: u32) -> u32 {
    return (value_12 + 50u);
}

fn fabs_5(value_13: bool) -> i32 {
    var local_39: i32;

    if value_13 {
        local_39 = 7i;
    } else {
        local_39 = 9i;
    }
    let _e6 = local_39;
    return _e6;
}

fn fabsf(value_14: bool) -> i32 {
    var local_40: i32;

    if value_14 {
        local_40 = 11i;
    } else {
        local_40 = 13i;
    }
    let _e6 = local_40;
    return _e6;
}

fn fabsf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn absolutes() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var value: f32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var triple: float3_;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var pair: vec2<f32>;
    var quadruple: vec4<f32>;
    var local_38: u32;

    let _e2 = gen__naga_fabsf(bitcast<u32>(0f));
    local = u32(0i);
    let _e8 = local;
    out[_e8] = bitcast<u32>(bitcast<f32>(_e2));
    let _e14 = gen__naga_fabsf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e20 = local_1;
    out[_e20] = bitcast<u32>(bitcast<f32>(_e14));
    let _e25 = gen__naga_fabsf(bitcast<u32>(-(1.75f)));
    local_2 = u32(2i);
    let _e31 = local_2;
    out[_e31] = bitcast<u32>(bitcast<f32>(_e25));
    let _e35 = absolute(-(1.25f));
    local_3 = u32(3i);
    let _e40 = local_3;
    out[_e40] = bitcast<u32>(_e35);
    let _e44 = converted_absolute(-(3i));
    local_4 = u32(4i);
    let _e49 = local_4;
    out[_e49] = bitcast<u32>(_e44);
    let _e52 = converted_absolute_1(4294967295u);
    local_5 = u32(5i);
    let _e57 = local_5;
    out[_e57] = bitcast<u32>(_e52);
    let _e60 = converted_absolute_2(true);
    local_6 = u32(6i);
    let _e65 = local_6;
    out[_e65] = bitcast<u32>(_e60);
    let _e68 = converted_absolute_2(false);
    local_7 = u32(7i);
    let _e73 = local_7;
    out[_e73] = bitcast<u32>(_e68);
    local_9 = 1u;
    let _e77 = local_9;
    let _e80 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e77)));
    local_8 = u32(8i);
    let _e86 = local_8;
    out[_e86] = bitcast<u32>(bitcast<f32>(_e80));
    local_11 = 2147483649u;
    let _e90 = local_11;
    let _e93 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e90)));
    local_10 = u32(9i);
    let _e99 = local_10;
    out[_e99] = bitcast<u32>(bitcast<f32>(_e93));
    local_13 = 8388607u;
    let _e103 = local_13;
    let _e106 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e103)));
    local_12 = u32(10i);
    let _e112 = local_12;
    out[_e112] = bitcast<u32>(bitcast<f32>(_e106));
    local_15 = 2155872255u;
    let _e116 = local_15;
    let _e119 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e116)));
    local_14 = u32(11i);
    let _e125 = local_14;
    out[_e125] = bitcast<u32>(bitcast<f32>(_e119));
    let _e129 = gen__naga_fabsf(bitcast<u32>(340282350000000000000000000000000000000f));
    local_16 = u32(12i);
    let _e135 = local_16;
    out[_e135] = bitcast<u32>(bitcast<f32>(_e129));
    let _e140 = gen__naga_fabsf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    local_17 = u32(13i);
    let _e146 = local_17;
    out[_e146] = bitcast<u32>(bitcast<f32>(_e140));
    local_19 = 2139095040u;
    let _e150 = local_19;
    let _e153 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e150)));
    local_18 = u32(14i);
    let _e159 = local_18;
    out[_e159] = bitcast<u32>(bitcast<f32>(_e153));
    local_21 = 4286578688u;
    let _e163 = local_21;
    let _e166 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e163)));
    local_20 = u32(15i);
    let _e172 = local_20;
    out[_e172] = bitcast<u32>(bitcast<f32>(_e166));
    local_23 = 2143363909u;
    let _e176 = local_23;
    let _e179 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e176)));
    local_22 = u32(16i);
    let _e185 = local_22;
    out[_e185] = bitcast<u32>(bitcast<f32>(_e179));
    local_25 = 2139095041u;
    let _e189 = local_25;
    let _e192 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e189)));
    local_24 = u32(17i);
    let _e198 = local_24;
    out[_e198] = bitcast<u32>(bitcast<f32>(_e192));
    value = -(2.75f);
    let _e203 = value;
    value = (_e203 + f32(1i));
    let _e208 = gen__naga_fabsf(bitcast<u32>(_e203));
    local_26 = u32(18i);
    let _e214 = local_26;
    out[_e214] = bitcast<u32>(bitcast<f32>(_e208));
    let _e216 = value;
    local_27 = u32(19i);
    let _e221 = local_27;
    out[_e221] = bitcast<u32>(_e216);
    let _e225 = fabs_3(-(3i));
    local_28 = u32(20i);
    let _e230 = local_28;
    out[_e230] = u32(_e225);
    let _e233 = fabs_4(3u);
    local_29 = u32(21i);
    let _e237 = local_29;
    out[_e237] = _e233;
    let _e240 = fabs_5(true);
    local_30 = u32(22i);
    let _e245 = local_30;
    out[_e245] = u32(_e240);
    let _e248 = fabs_5(false);
    local_31 = u32(23i);
    let _e253 = local_31;
    out[_e253] = u32(_e248);
    let _e256 = fabsf(true);
    local_32 = u32(24i);
    let _e261 = local_32;
    out[_e261] = u32(_e256);
    local_33 = 2147483649u;
    let _e269 = local_33;
    let _e272 = fabs_1(float3_(-(2.5f), -(0f), bitcast<f32>(_e269)));
    triple = _e272;
    let _e275 = triple.x;
    local_34 = u32(25i);
    let _e280 = local_34;
    out[_e280] = bitcast<u32>(_e275);
    let _e283 = triple.y;
    local_35 = u32(26i);
    let _e288 = local_35;
    out[_e288] = bitcast<u32>(_e283);
    let _e291 = triple.z;
    local_36 = u32(27i);
    let _e296 = local_36;
    out[_e296] = bitcast<u32>(_e291);
    let _e301 = fabsf_1(-(2f), 3f);
    local_37 = u32(28i);
    let _e306 = local_37;
    out[_e306] = bitcast<u32>(_e301);
    let _e313 = fabs(vec2<f32>(-(3f), -(4f)));
    pair = _e313;
    let _e324 = fabs_2(vec4<f32>(-(1f), -(2f), -(3f), -(4f)));
    quadruple = _e324;
    let _e328 = pair.x;
    let _e329 = pair.y;
    let _e332 = quadruple.x;
    let _e335 = quadruple.w;
    local_38 = u32(29i);
    let _e341 = local_38;
    out[_e341] = bitcast<u32>((((_e328 + _e329) + _e332) + _e335));
}
