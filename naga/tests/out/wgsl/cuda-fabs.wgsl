struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn fabs(value_1: vec2<f32>) -> vec2<f32> {
    var value_2: vec2<f32>;
    var local_83: u32;
    var local_84: u32;

    value_2 = value_1;
    let _e3 = value_2.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_83 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_83;
    let _e15 = value_2.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_84 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_84;
    return vec2<f32>(bitcast<f32>(_e12), bitcast<f32>(_e24));
}

fn fabs_1(value_3: float3_) -> float3_ {
    var value_4: float3_;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;

    value_4 = value_3;
    let _e3 = value_4.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_85 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_85;
    let _e15 = value_4.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_86 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_86;
    let _e27 = value_4.z;
    let _e30 = (bitcast<u32>(_e27) & 2147483647u);
    local_87 = select(_e30, 2143289344u, (_e30 > 2139095040u));
    let _e36 = local_87;
    return float3_(bitcast<f32>(_e12), bitcast<f32>(_e24), bitcast<f32>(_e36));
}

fn fabs_2(value_5: vec4<f32>) -> vec4<f32> {
    var value_6: vec4<f32>;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;

    value_6 = value_5;
    let _e3 = value_6.x;
    let _e6 = (bitcast<u32>(_e3) & 2147483647u);
    local_88 = select(_e6, 2143289344u, (_e6 > 2139095040u));
    let _e12 = local_88;
    let _e15 = value_6.y;
    let _e18 = (bitcast<u32>(_e15) & 2147483647u);
    local_89 = select(_e18, 2143289344u, (_e18 > 2139095040u));
    let _e24 = local_89;
    let _e27 = value_6.z;
    let _e30 = (bitcast<u32>(_e27) & 2147483647u);
    local_90 = select(_e30, 2143289344u, (_e30 > 2139095040u));
    let _e36 = local_90;
    let _e39 = value_6.w;
    let _e42 = (bitcast<u32>(_e39) & 2147483647u);
    local_91 = select(_e42, 2143289344u, (_e42 > 2139095040u));
    let _e48 = local_91;
    return vec4<f32>(bitcast<f32>(_e12), bitcast<f32>(_e24), bitcast<f32>(_e36), bitcast<f32>(_e48));
}

fn absolute(value_7: f32) -> f32 {
    var local_92: u32;

    let _e3 = (bitcast<u32>(value_7) & 2147483647u);
    local_92 = select(_e3, 2143289344u, (_e3 > 2139095040u));
    let _e9 = local_92;
    return bitcast<f32>(_e9);
}

fn converted_absolute(value_8: i32) -> f32 {
    var local_93: u32;

    let _e4 = (bitcast<u32>(f32(value_8)) & 2147483647u);
    local_93 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_93;
    return bitcast<f32>(_e10);
}

fn converted_absolute_1(value_9: u32) -> f32 {
    var local_94: u32;

    let _e4 = (bitcast<u32>(f32(value_9)) & 2147483647u);
    local_94 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_94;
    return bitcast<f32>(_e10);
}

fn converted_absolute_2(value_10: bool) -> f32 {
    var local_95: u32;

    let _e4 = (bitcast<u32>(f32(value_10)) & 2147483647u);
    local_95 = select(_e4, 2143289344u, (_e4 > 2139095040u));
    let _e10 = local_95;
    return bitcast<f32>(_e10);
}

fn fabs_3(value_11: i32) -> i32 {
    return (value_11 + 40i);
}

fn fabs_4(value_12: u32) -> u32 {
    return (value_12 + 50u);
}

fn fabs_5(value_13: bool) -> i32 {
    var local_96: i32;

    if value_13 {
        local_96 = 7i;
    } else {
        local_96 = 9i;
    }
    let _e6 = local_96;
    return _e6;
}

fn fabsf(value_14: bool) -> i32 {
    var local_97: i32;

    if value_14 {
        local_97 = 11i;
    } else {
        local_97 = 13i;
    }
    let _e6 = local_97;
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
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: u32;

    let _e3 = (bitcast<u32>(0f) & 2147483647u);
    local_1 = select(_e3, 2143289344u, (_e3 > 2139095040u));
    let _e9 = local_1;
    local = u32(0i);
    let _e16 = local;
    local_53 = u32(_e16);
    let _e19 = local_53;
    out[_e19] = bitcast<u32>(bitcast<f32>(_e9));
    let _e25 = (bitcast<u32>(-(0f)) & 2147483647u);
    local_3 = select(_e25, 2143289344u, (_e25 > 2139095040u));
    let _e31 = local_3;
    local_2 = u32(1i);
    let _e37 = local_2;
    local_54 = u32(_e37);
    let _e40 = local_54;
    out[_e40] = bitcast<u32>(bitcast<f32>(_e31));
    let _e46 = (bitcast<u32>(-(1.75f)) & 2147483647u);
    local_5 = select(_e46, 2143289344u, (_e46 > 2139095040u));
    let _e52 = local_5;
    local_4 = u32(2i);
    let _e58 = local_4;
    local_55 = u32(_e58);
    let _e61 = local_55;
    out[_e61] = bitcast<u32>(bitcast<f32>(_e52));
    let _e65 = absolute(-(1.25f));
    local_6 = u32(3i);
    let _e70 = local_6;
    local_56 = u32(_e70);
    let _e73 = local_56;
    out[_e73] = bitcast<u32>(_e65);
    let _e77 = converted_absolute(-(3i));
    local_7 = u32(4i);
    let _e82 = local_7;
    local_57 = u32(_e82);
    let _e85 = local_57;
    out[_e85] = bitcast<u32>(_e77);
    let _e88 = converted_absolute_1(4294967295u);
    local_8 = u32(5i);
    let _e93 = local_8;
    local_58 = u32(_e93);
    let _e96 = local_58;
    out[_e96] = bitcast<u32>(_e88);
    let _e99 = converted_absolute_2(true);
    local_9 = u32(6i);
    let _e104 = local_9;
    local_59 = u32(_e104);
    let _e107 = local_59;
    out[_e107] = bitcast<u32>(_e99);
    let _e110 = converted_absolute_2(false);
    local_10 = u32(7i);
    let _e115 = local_10;
    local_60 = u32(_e115);
    let _e118 = local_60;
    out[_e118] = bitcast<u32>(_e110);
    local_12 = 1u;
    let _e122 = local_12;
    let _e126 = (bitcast<u32>(bitcast<f32>(_e122)) & 2147483647u);
    local_13 = select(_e126, 2143289344u, (_e126 > 2139095040u));
    let _e132 = local_13;
    local_11 = u32(8i);
    let _e138 = local_11;
    local_61 = u32(_e138);
    let _e141 = local_61;
    out[_e141] = bitcast<u32>(bitcast<f32>(_e132));
    local_15 = 2147483649u;
    let _e145 = local_15;
    let _e149 = (bitcast<u32>(bitcast<f32>(_e145)) & 2147483647u);
    local_16 = select(_e149, 2143289344u, (_e149 > 2139095040u));
    let _e155 = local_16;
    local_14 = u32(9i);
    let _e161 = local_14;
    local_62 = u32(_e161);
    let _e164 = local_62;
    out[_e164] = bitcast<u32>(bitcast<f32>(_e155));
    local_18 = 8388607u;
    let _e168 = local_18;
    let _e172 = (bitcast<u32>(bitcast<f32>(_e168)) & 2147483647u);
    local_19 = select(_e172, 2143289344u, (_e172 > 2139095040u));
    let _e178 = local_19;
    local_17 = u32(10i);
    let _e184 = local_17;
    local_63 = u32(_e184);
    let _e187 = local_63;
    out[_e187] = bitcast<u32>(bitcast<f32>(_e178));
    local_21 = 2155872255u;
    let _e191 = local_21;
    let _e195 = (bitcast<u32>(bitcast<f32>(_e191)) & 2147483647u);
    local_22 = select(_e195, 2143289344u, (_e195 > 2139095040u));
    let _e201 = local_22;
    local_20 = u32(11i);
    let _e207 = local_20;
    local_64 = u32(_e207);
    let _e210 = local_64;
    out[_e210] = bitcast<u32>(bitcast<f32>(_e201));
    let _e215 = (bitcast<u32>(340282350000000000000000000000000000000f) & 2147483647u);
    local_24 = select(_e215, 2143289344u, (_e215 > 2139095040u));
    let _e221 = local_24;
    local_23 = u32(12i);
    let _e227 = local_23;
    local_65 = u32(_e227);
    let _e230 = local_65;
    out[_e230] = bitcast<u32>(bitcast<f32>(_e221));
    let _e236 = (bitcast<u32>(-(340282350000000000000000000000000000000f)) & 2147483647u);
    local_26 = select(_e236, 2143289344u, (_e236 > 2139095040u));
    let _e242 = local_26;
    local_25 = u32(13i);
    let _e248 = local_25;
    local_66 = u32(_e248);
    let _e251 = local_66;
    out[_e251] = bitcast<u32>(bitcast<f32>(_e242));
    local_28 = 2139095040u;
    let _e255 = local_28;
    let _e259 = (bitcast<u32>(bitcast<f32>(_e255)) & 2147483647u);
    local_29 = select(_e259, 2143289344u, (_e259 > 2139095040u));
    let _e265 = local_29;
    local_27 = u32(14i);
    let _e271 = local_27;
    local_67 = u32(_e271);
    let _e274 = local_67;
    out[_e274] = bitcast<u32>(bitcast<f32>(_e265));
    local_31 = 4286578688u;
    let _e278 = local_31;
    let _e282 = (bitcast<u32>(bitcast<f32>(_e278)) & 2147483647u);
    local_32 = select(_e282, 2143289344u, (_e282 > 2139095040u));
    let _e288 = local_32;
    local_30 = u32(15i);
    let _e294 = local_30;
    local_68 = u32(_e294);
    let _e297 = local_68;
    out[_e297] = bitcast<u32>(bitcast<f32>(_e288));
    local_34 = 2143363909u;
    let _e301 = local_34;
    let _e305 = (bitcast<u32>(bitcast<f32>(_e301)) & 2147483647u);
    local_35 = select(_e305, 2143289344u, (_e305 > 2139095040u));
    let _e311 = local_35;
    local_33 = u32(16i);
    let _e317 = local_33;
    local_69 = u32(_e317);
    let _e320 = local_69;
    out[_e320] = bitcast<u32>(bitcast<f32>(_e311));
    local_37 = 2139095041u;
    let _e324 = local_37;
    let _e328 = (bitcast<u32>(bitcast<f32>(_e324)) & 2147483647u);
    local_38 = select(_e328, 2143289344u, (_e328 > 2139095040u));
    let _e334 = local_38;
    local_36 = u32(17i);
    let _e340 = local_36;
    local_70 = u32(_e340);
    let _e343 = local_70;
    out[_e343] = bitcast<u32>(bitcast<f32>(_e334));
    value = -(2.75f);
    let _e348 = value;
    value = (_e348 + f32(1i));
    let _e354 = (bitcast<u32>(_e348) & 2147483647u);
    local_40 = select(_e354, 2143289344u, (_e354 > 2139095040u));
    let _e360 = local_40;
    local_39 = u32(18i);
    let _e366 = local_39;
    local_71 = u32(_e366);
    let _e369 = local_71;
    out[_e369] = bitcast<u32>(bitcast<f32>(_e360));
    let _e371 = value;
    local_41 = u32(19i);
    let _e376 = local_41;
    local_72 = u32(_e376);
    let _e379 = local_72;
    out[_e379] = bitcast<u32>(_e371);
    let _e383 = fabs_3(-(3i));
    local_42 = u32(20i);
    let _e388 = local_42;
    local_73 = u32(_e388);
    let _e391 = local_73;
    out[_e391] = u32(_e383);
    let _e394 = fabs_4(3u);
    local_43 = u32(21i);
    let _e398 = local_43;
    local_74 = u32(_e398);
    let _e401 = local_74;
    out[_e401] = _e394;
    let _e404 = fabs_5(true);
    local_44 = u32(22i);
    let _e409 = local_44;
    local_75 = u32(_e409);
    let _e412 = local_75;
    out[_e412] = u32(_e404);
    let _e415 = fabs_5(false);
    local_45 = u32(23i);
    let _e420 = local_45;
    local_76 = u32(_e420);
    let _e423 = local_76;
    out[_e423] = u32(_e415);
    let _e426 = fabsf(true);
    local_46 = u32(24i);
    let _e431 = local_46;
    local_77 = u32(_e431);
    let _e434 = local_77;
    out[_e434] = u32(_e426);
    local_47 = 2147483649u;
    let _e442 = local_47;
    let _e445 = fabs_1(float3_(-(2.5f), -(0f), bitcast<f32>(_e442)));
    triple = _e445;
    let _e448 = triple.x;
    local_48 = u32(25i);
    let _e453 = local_48;
    local_78 = u32(_e453);
    let _e456 = local_78;
    out[_e456] = bitcast<u32>(_e448);
    let _e459 = triple.y;
    local_49 = u32(26i);
    let _e464 = local_49;
    local_79 = u32(_e464);
    let _e467 = local_79;
    out[_e467] = bitcast<u32>(_e459);
    let _e470 = triple.z;
    local_50 = u32(27i);
    let _e475 = local_50;
    local_80 = u32(_e475);
    let _e478 = local_80;
    out[_e478] = bitcast<u32>(_e470);
    let _e483 = fabsf_1(-(2f), 3f);
    local_51 = u32(28i);
    let _e488 = local_51;
    local_81 = u32(_e488);
    let _e491 = local_81;
    out[_e491] = bitcast<u32>(_e483);
    let _e498 = fabs(vec2<f32>(-(3f), -(4f)));
    pair = _e498;
    let _e509 = fabs_2(vec4<f32>(-(1f), -(2f), -(3f), -(4f)));
    quadruple = _e509;
    let _e513 = pair.x;
    let _e514 = pair.y;
    let _e517 = quadruple.x;
    let _e520 = quadruple.w;
    local_52 = u32(29i);
    let _e526 = local_52;
    local_82 = u32(_e526);
    let _e529 = local_82;
    out[_e529] = bitcast<u32>((((_e513 + _e514) + _e517) + _e520));
}
