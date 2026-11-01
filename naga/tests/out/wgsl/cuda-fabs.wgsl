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
    var local_9: i32;

    if value_13 {
        local_9 = 7i;
    } else {
        local_9 = 9i;
    }
    let _e6 = local_9;
    return _e6;
}

fn fabsf(value_14: bool) -> i32 {
    var local_10: i32;

    if value_14 {
        local_10 = 11i;
    } else {
        local_10 = 13i;
    }
    let _e6 = local_10;
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
    var value: f32;
    var triple: float3_;
    var local_8: u32;
    var pair: vec2<f32>;
    var quadruple: vec4<f32>;

    let _e2 = gen__naga_fabsf(bitcast<u32>(0f));
    out[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_fabsf(bitcast<u32>(-(0f)));
    out[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e21 = gen__naga_fabsf(bitcast<u32>(-(1.75f)));
    out[u32(2i)] = bitcast<u32>(bitcast<f32>(_e21));
    let _e29 = absolute(-(1.25f));
    out[u32(3i)] = bitcast<u32>(_e29);
    let _e36 = converted_absolute(-(3i));
    out[u32(4i)] = bitcast<u32>(_e36);
    let _e42 = converted_absolute_1(4294967295u);
    out[u32(5i)] = bitcast<u32>(_e42);
    let _e48 = converted_absolute_2(true);
    out[u32(6i)] = bitcast<u32>(_e48);
    let _e54 = converted_absolute_2(false);
    out[u32(7i)] = bitcast<u32>(_e54);
    local = 1u;
    let _e61 = local;
    let _e64 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e61)));
    out[u32(8i)] = bitcast<u32>(bitcast<f32>(_e64));
    local_1 = 2147483649u;
    let _e72 = local_1;
    let _e75 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e72)));
    out[u32(9i)] = bitcast<u32>(bitcast<f32>(_e75));
    local_2 = 8388607u;
    let _e83 = local_2;
    let _e86 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e83)));
    out[u32(10i)] = bitcast<u32>(bitcast<f32>(_e86));
    local_3 = 2155872255u;
    let _e94 = local_3;
    let _e97 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e94)));
    out[u32(11i)] = bitcast<u32>(bitcast<f32>(_e97));
    let _e105 = gen__naga_fabsf(bitcast<u32>(340282350000000000000000000000000000000f));
    out[u32(12i)] = bitcast<u32>(bitcast<f32>(_e105));
    let _e114 = gen__naga_fabsf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    out[u32(13i)] = bitcast<u32>(bitcast<f32>(_e114));
    local_4 = 2139095040u;
    let _e122 = local_4;
    let _e125 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e122)));
    out[u32(14i)] = bitcast<u32>(bitcast<f32>(_e125));
    local_5 = 4286578688u;
    let _e133 = local_5;
    let _e136 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e133)));
    out[u32(15i)] = bitcast<u32>(bitcast<f32>(_e136));
    local_6 = 2143363909u;
    let _e144 = local_6;
    let _e147 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e144)));
    out[u32(16i)] = bitcast<u32>(bitcast<f32>(_e147));
    local_7 = 2139095041u;
    let _e155 = local_7;
    let _e158 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e155)));
    out[u32(17i)] = bitcast<u32>(bitcast<f32>(_e158));
    value = -(2.75f);
    let _e167 = value;
    value = (_e167 + f32(1i));
    let _e172 = gen__naga_fabsf(bitcast<u32>(_e167));
    out[u32(18i)] = bitcast<u32>(bitcast<f32>(_e172));
    let _e178 = value;
    out[u32(19i)] = bitcast<u32>(_e178);
    let _e185 = fabs_3(-(3i));
    out[u32(20i)] = u32(_e185);
    let _e191 = fabs_4(3u);
    out[u32(21i)] = _e191;
    let _e196 = fabs_5(true);
    out[u32(22i)] = u32(_e196);
    let _e202 = fabs_5(false);
    out[u32(23i)] = u32(_e202);
    let _e208 = fabsf(true);
    out[u32(24i)] = u32(_e208);
    local_8 = 2147483649u;
    let _e219 = local_8;
    let _e222 = fabs_1(float3_(-(2.5f), -(0f), bitcast<f32>(_e219)));
    triple = _e222;
    let _e225 = triple.x;
    out[u32(25i)] = bitcast<u32>(_e225);
    let _e231 = triple.y;
    out[u32(26i)] = bitcast<u32>(_e231);
    let _e237 = triple.z;
    out[u32(27i)] = bitcast<u32>(_e237);
    let _e245 = fabsf_1(-(2f), 3f);
    out[u32(28i)] = bitcast<u32>(_e245);
    let _e255 = fabs(vec2<f32>(-(3f), -(4f)));
    pair = _e255;
    let _e266 = fabs_2(vec4<f32>(-(1f), -(2f), -(3f), -(4f)));
    quadruple = _e266;
    let _e270 = pair.x;
    let _e271 = pair.y;
    let _e274 = quadruple.x;
    let _e277 = quadruple.w;
    out[u32(29i)] = bitcast<u32>((((_e270 + _e271) + _e274) + _e277));
}
