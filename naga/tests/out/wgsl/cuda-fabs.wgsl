struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn fabs(value_1: vec2<f32>) -> vec2<f32> {
    var value_2: vec2<f32>;
    var local_53: u32;
    var local_54: u32;

    value_2 = value_1;
    let _e3 = value_2.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_53 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_53;
    let _e15 = value_2.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_54 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_54;
    return vec2<f32>(bitcast<f32>(_e12), bitcast<f32>(_e24));
}

fn fabs_1(value_3: float3_) -> float3_ {
    var value_4: float3_;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;

    value_4 = value_3;
    let _e3 = value_4.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_55 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_55;
    let _e15 = value_4.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_56 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_56;
    let _e27 = value_4.z;
    let _e30 = (bitcast<u32>(_e27) & 2147483647u);
    local_57 = select(_e30, 2143289344u, (_e30 > 2139095040u));
    let _e36 = local_57;
    return float3_(bitcast<f32>(_e12), bitcast<f32>(_e24), bitcast<f32>(_e36));
}

fn fabs_2(value_5: vec4<f32>) -> vec4<f32> {
    var value_6: vec4<f32>;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;

    value_6 = value_5;
    let _e3 = value_6.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_58 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_58;
    let _e15 = value_6.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_59 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_59;
    let _e27 = value_6.z;
    let _e30 = (bitcast<u32>(_e27) & 2147483647u);
    local_60 = select(_e30, 2143289344u, (_e30 > 2139095040u));
    let _e36 = local_60;
    let _e39 = value_6.w;
    let _e42 = (bitcast<u32>(_e39) & 2147483647u);
    local_61 = select(_e42, 2143289344u, (_e42 > 2139095040u));
    let _e48 = local_61;
    return vec4<f32>(bitcast<f32>(_e12), bitcast<f32>(_e24), bitcast<f32>(_e36), bitcast<f32>(_e48));
}

fn absolute(value_7: f32) -> f32 {
    var local_62: u32;

    let _e3 = (bitcast<u32>(value_7) & 2147483647u);
    local_62 = select(_e3, 2143289344u, (_e3 > 2139095040u));
    let _e9 = local_62;
    return bitcast<f32>(_e9);
}

fn converted_absolute(value_8: i32) -> f32 {
    var local_63: u32;

    let _e4 = (bitcast<u32>(f32(value_8)) & 2147483647u);
    local_63 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_63;
    return bitcast<f32>(_e10);
}

fn converted_absolute_1(value_9: u32) -> f32 {
    var local_64: u32;

    let _e4 = (bitcast<u32>(f32(value_9)) & 2147483647u);
    local_64 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_64;
    return bitcast<f32>(_e10);
}

fn converted_absolute_2(value_10: bool) -> f32 {
    var local_65: u32;

    let _e4 = (bitcast<u32>(f32(value_10)) & 2147483647u);
    local_65 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_65;
    return bitcast<f32>(_e10);
}

fn fabs_3(value_11: i32) -> i32 {
    return (value_11 + 40i);
}

fn fabs_4(value_12: u32) -> u32 {
    return (value_12 + 50u);
}

fn fabs_5(value_13: bool) -> i32 {
    var local_66: i32;

    if value_13 {
        local_66 = 7i;
    } else {
        local_66 = 9i;
    }
    let _e6 = local_66;
    return _e6;
}

fn fabsf(value_14: bool) -> i32 {
    var local_67: i32;

    if value_14 {
        local_67 = 11i;
    } else {
        local_67 = 13i;
    }
    let _e6 = local_67;
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
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var value: f32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var triple: float3_;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var pair: vec2<f32>;
    var quadruple: vec4<f32>;
    var local_52: u32;

    let _e3 = (bitcast<u32>(0f) & 2147483647u);
    local_1 = select(_e3, 2143289344u, (_e3 > 2139095040u));
    let _e9 = local_1;
    local = u32(0i);
    let _e15 = local;
    out[_e15] = bitcast<u32>(bitcast<f32>(_e9));
    let _e22 = (bitcast<u32>(-(0f)) & 2147483647u);
    local_3 = select(_e22, 2143289344u, (_e22 > 2139095040u));
    let _e28 = local_3;
    local_2 = u32(1i);
    let _e34 = local_2;
    out[_e34] = bitcast<u32>(bitcast<f32>(_e28));
    let _e40 = (bitcast<u32>(-(1.75f)) & 2147483647u);
    local_5 = select(_e40, 2143289344u, (_e40 > 2139095040u));
    let _e46 = local_5;
    local_4 = u32(2i);
    let _e52 = local_4;
    out[_e52] = bitcast<u32>(bitcast<f32>(_e46));
    let _e56 = absolute(-(1.25f));
    local_6 = u32(3i);
    let _e61 = local_6;
    out[_e61] = bitcast<u32>(_e56);
    let _e65 = converted_absolute(-(3i));
    local_7 = u32(4i);
    let _e70 = local_7;
    out[_e70] = bitcast<u32>(_e65);
    let _e73 = converted_absolute_1(4294967295u);
    local_8 = u32(5i);
    let _e78 = local_8;
    out[_e78] = bitcast<u32>(_e73);
    let _e81 = converted_absolute_2(true);
    local_9 = u32(6i);
    let _e86 = local_9;
    out[_e86] = bitcast<u32>(_e81);
    let _e89 = converted_absolute_2(false);
    local_10 = u32(7i);
    let _e94 = local_10;
    out[_e94] = bitcast<u32>(_e89);
    local_12 = 1u;
    let _e98 = local_12;
    let _e102 = (bitcast<u32>(bitcast<f32>(_e98)) & 2147483647u);
    local_13 = select(_e102, 2143289344u, (_e102 > 2139095040u));
    let _e108 = local_13;
    local_11 = u32(8i);
    let _e114 = local_11;
    out[_e114] = bitcast<u32>(bitcast<f32>(_e108));
    local_15 = 2147483649u;
    let _e118 = local_15;
    let _e122 = (bitcast<u32>(bitcast<f32>(_e118)) & 2147483647u);
    local_16 = select(_e122, 2143289344u, (_e122 > 2139095040u));
    let _e128 = local_16;
    local_14 = u32(9i);
    let _e134 = local_14;
    out[_e134] = bitcast<u32>(bitcast<f32>(_e128));
    local_18 = 8388607u;
    let _e138 = local_18;
    let _e142 = (bitcast<u32>(bitcast<f32>(_e138)) & 2147483647u);
    local_19 = select(_e142, 2143289344u, (_e142 > 2139095040u));
    let _e148 = local_19;
    local_17 = u32(10i);
    let _e154 = local_17;
    out[_e154] = bitcast<u32>(bitcast<f32>(_e148));
    local_21 = 2155872255u;
    let _e158 = local_21;
    let _e162 = (bitcast<u32>(bitcast<f32>(_e158)) & 2147483647u);
    local_22 = select(_e162, 2143289344u, (_e162 > 2139095040u));
    let _e168 = local_22;
    local_20 = u32(11i);
    let _e174 = local_20;
    out[_e174] = bitcast<u32>(bitcast<f32>(_e168));
    let _e179 = (bitcast<u32>(340282350000000000000000000000000000000f) & 2147483647u);
    local_24 = select(_e179, 2143289344u, (_e179 > 2139095040u));
    let _e185 = local_24;
    local_23 = u32(12i);
    let _e191 = local_23;
    out[_e191] = bitcast<u32>(bitcast<f32>(_e185));
    let _e197 = (bitcast<u32>(-(340282350000000000000000000000000000000f)) & 2147483647u);
    local_26 = select(_e197, 2143289344u, (_e197 > 2139095040u));
    let _e203 = local_26;
    local_25 = u32(13i);
    let _e209 = local_25;
    out[_e209] = bitcast<u32>(bitcast<f32>(_e203));
    local_28 = 2139095040u;
    let _e213 = local_28;
    let _e217 = (bitcast<u32>(bitcast<f32>(_e213)) & 2147483647u);
    local_29 = select(_e217, 2143289344u, (_e217 > 2139095040u));
    let _e223 = local_29;
    local_27 = u32(14i);
    let _e229 = local_27;
    out[_e229] = bitcast<u32>(bitcast<f32>(_e223));
    local_31 = 4286578688u;
    let _e233 = local_31;
    let _e237 = (bitcast<u32>(bitcast<f32>(_e233)) & 2147483647u);
    local_32 = select(_e237, 2143289344u, (_e237 > 2139095040u));
    let _e243 = local_32;
    local_30 = u32(15i);
    let _e249 = local_30;
    out[_e249] = bitcast<u32>(bitcast<f32>(_e243));
    local_34 = 2143363909u;
    let _e253 = local_34;
    let _e257 = (bitcast<u32>(bitcast<f32>(_e253)) & 2147483647u);
    local_35 = select(_e257, 2143289344u, (_e257 > 2139095040u));
    let _e263 = local_35;
    local_33 = u32(16i);
    let _e269 = local_33;
    out[_e269] = bitcast<u32>(bitcast<f32>(_e263));
    local_37 = 2139095041u;
    let _e273 = local_37;
    let _e277 = (bitcast<u32>(bitcast<f32>(_e273)) & 2147483647u);
    local_38 = select(_e277, 2143289344u, (_e277 > 2139095040u));
    let _e283 = local_38;
    local_36 = u32(17i);
    let _e289 = local_36;
    out[_e289] = bitcast<u32>(bitcast<f32>(_e283));
    value = -(2.75f);
    let _e294 = value;
    value = (_e294 + f32(1i));
    let _e300 = (bitcast<u32>(_e294) & 2147483647u);
    local_40 = select(_e300, 2143289344u, (_e300 > 2139095040u));
    let _e306 = local_40;
    local_39 = u32(18i);
    let _e312 = local_39;
    out[_e312] = bitcast<u32>(bitcast<f32>(_e306));
    let _e314 = value;
    local_41 = u32(19i);
    let _e319 = local_41;
    out[_e319] = bitcast<u32>(_e314);
    let _e323 = fabs_3(-(3i));
    local_42 = u32(20i);
    let _e328 = local_42;
    out[_e328] = u32(_e323);
    let _e331 = fabs_4(3u);
    local_43 = u32(21i);
    let _e335 = local_43;
    out[_e335] = _e331;
    let _e338 = fabs_5(true);
    local_44 = u32(22i);
    let _e343 = local_44;
    out[_e343] = u32(_e338);
    let _e346 = fabs_5(false);
    local_45 = u32(23i);
    let _e351 = local_45;
    out[_e351] = u32(_e346);
    let _e354 = fabsf(true);
    local_46 = u32(24i);
    let _e359 = local_46;
    out[_e359] = u32(_e354);
    local_47 = 2147483649u;
    let _e367 = local_47;
    let _e370 = fabs_1(float3_(-(2.5f), -(0f), bitcast<f32>(_e367)));
    triple = _e370;
    let _e373 = triple.x;
    local_48 = u32(25i);
    let _e378 = local_48;
    out[_e378] = bitcast<u32>(_e373);
    let _e381 = triple.y;
    local_49 = u32(26i);
    let _e386 = local_49;
    out[_e386] = bitcast<u32>(_e381);
    let _e389 = triple.z;
    local_50 = u32(27i);
    let _e394 = local_50;
    out[_e394] = bitcast<u32>(_e389);
    let _e399 = fabsf_1(-(2f), 3f);
    local_51 = u32(28i);
    let _e404 = local_51;
    out[_e404] = bitcast<u32>(_e399);
    let _e411 = fabs(vec2<f32>(-(3f), -(4f)));
    pair = _e411;
    let _e422 = fabs_2(vec4<f32>(-(1f), -(2f), -(3f), -(4f)));
    quadruple = _e422;
    let _e426 = pair.x;
    let _e427 = pair.y;
    let _e430 = quadruple.x;
    let _e433 = quadruple.w;
    local_52 = u32(29i);
    let _e439 = local_52;
    out[_e439] = bitcast<u32>((((_e426 + _e427) + _e430) + _e433));
}
