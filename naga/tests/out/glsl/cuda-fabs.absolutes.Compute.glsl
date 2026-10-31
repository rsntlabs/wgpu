#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
layout(std430) buffer type_6_block_0Compute { uint _group_0_binding_0_cs[]; };


vec2 fabs(vec2 value_1) {
    vec2 value_2 = vec2(0.0);
    uint local_83 = 0u;
    uint local_84 = 0u;
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_83 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_83;
    float _e15 = value_2.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_84 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_84;
    return vec2(uintBitsToFloat(_e12), uintBitsToFloat(_e24));
}

float3_ fabs_1(float3_ value_3) {
    float3_ value_4 = float3_(0.0, 0.0, 0.0);
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87 = 0u;
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_85 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_85;
    float _e15 = value_4.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_86 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_86;
    float _e27 = value_4.z;
    uint _e30 = (floatBitsToUint(_e27) & 2147483647u);
    local_87 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_87;
    return float3_(uintBitsToFloat(_e12), uintBitsToFloat(_e24), uintBitsToFloat(_e36));
}

vec4 fabs_2(vec4 value_5) {
    vec4 value_6 = vec4(0.0);
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90 = 0u;
    uint local_91 = 0u;
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_88 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_88;
    float _e15 = value_6.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_89 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_89;
    float _e27 = value_6.z;
    uint _e30 = (floatBitsToUint(_e27) & 2147483647u);
    local_90 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_90;
    float _e39 = value_6.w;
    uint _e42 = (floatBitsToUint(_e39) & 2147483647u);
    local_91 = ((_e42 > 2139095040u) ? 2143289344u : _e42);
    uint _e48 = local_91;
    return vec4(uintBitsToFloat(_e12), uintBitsToFloat(_e24), uintBitsToFloat(_e36), uintBitsToFloat(_e48));
}

float absolute(float value_7) {
    uint local_92 = 0u;
    uint _e3 = (floatBitsToUint(value_7) & 2147483647u);
    local_92 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_92;
    return uintBitsToFloat(_e9);
}

float converted_absolute(int value_8) {
    uint local_93 = 0u;
    uint _e4 = (floatBitsToUint(float(value_8)) & 2147483647u);
    local_93 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_93;
    return uintBitsToFloat(_e10);
}

float converted_absolute_1(uint value_9) {
    uint local_94 = 0u;
    uint _e4 = (floatBitsToUint(float(value_9)) & 2147483647u);
    local_94 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_94;
    return uintBitsToFloat(_e10);
}

float converted_absolute_2(bool value_10) {
    uint local_95 = 0u;
    uint _e4 = (floatBitsToUint(float(value_10)) & 2147483647u);
    local_95 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_95;
    return uintBitsToFloat(_e10);
}

int fabs_3(int value_11) {
    return (value_11 + 40);
}

uint fabs_4(uint value_12) {
    return (value_12 + 50u);
}

int fabs_5(bool value_13) {
    int local_96 = 0;
    if (value_13) {
        local_96 = 7;
    } else {
        local_96 = 9;
    }
    int _e6 = local_96;
    return _e6;
}

int fabsf(bool value_14) {
    int local_97 = 0;
    if (value_14) {
        local_97 = 11;
    } else {
        local_97 = 13;
    }
    int _e6 = local_97;
    return _e6;
}

float fabsf_1(float first, float second) {
    return (first + second);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    float value = 0.0;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    float3_ triple = float3_(0.0, 0.0, 0.0);
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    vec2 pair = vec2(0.0);
    vec4 quadruple = vec4(0.0);
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint _e3 = (floatBitsToUint(0.0) & 2147483647u);
    local_1 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_1;
    local = uint(0);
    uint _e16 = local;
    local_53 = uint(_e16);
    uint _e19 = local_53;
    _group_0_binding_0_cs[_e19] = floatBitsToUint(uintBitsToFloat(_e9));
    uint _e25 = (floatBitsToUint(-(0.0)) & 2147483647u);
    local_3 = ((_e25 > 2139095040u) ? 2143289344u : _e25);
    uint _e31 = local_3;
    local_2 = uint(1);
    uint _e37 = local_2;
    local_54 = uint(_e37);
    uint _e40 = local_54;
    _group_0_binding_0_cs[_e40] = floatBitsToUint(uintBitsToFloat(_e31));
    uint _e46 = (floatBitsToUint(-(1.75)) & 2147483647u);
    local_5 = ((_e46 > 2139095040u) ? 2143289344u : _e46);
    uint _e52 = local_5;
    local_4 = uint(2);
    uint _e58 = local_4;
    local_55 = uint(_e58);
    uint _e61 = local_55;
    _group_0_binding_0_cs[_e61] = floatBitsToUint(uintBitsToFloat(_e52));
    float _e65 = absolute(-(1.25));
    local_6 = uint(3);
    uint _e70 = local_6;
    local_56 = uint(_e70);
    uint _e73 = local_56;
    _group_0_binding_0_cs[_e73] = floatBitsToUint(_e65);
    float _e77 = converted_absolute(-(3));
    local_7 = uint(4);
    uint _e82 = local_7;
    local_57 = uint(_e82);
    uint _e85 = local_57;
    _group_0_binding_0_cs[_e85] = floatBitsToUint(_e77);
    float _e88 = converted_absolute_1(4294967295u);
    local_8 = uint(5);
    uint _e93 = local_8;
    local_58 = uint(_e93);
    uint _e96 = local_58;
    _group_0_binding_0_cs[_e96] = floatBitsToUint(_e88);
    float _e99 = converted_absolute_2(true);
    local_9 = uint(6);
    uint _e104 = local_9;
    local_59 = uint(_e104);
    uint _e107 = local_59;
    _group_0_binding_0_cs[_e107] = floatBitsToUint(_e99);
    float _e110 = converted_absolute_2(false);
    local_10 = uint(7);
    uint _e115 = local_10;
    local_60 = uint(_e115);
    uint _e118 = local_60;
    _group_0_binding_0_cs[_e118] = floatBitsToUint(_e110);
    local_12 = 1u;
    uint _e122 = local_12;
    uint _e126 = (floatBitsToUint(uintBitsToFloat(_e122)) & 2147483647u);
    local_13 = ((_e126 > 2139095040u) ? 2143289344u : _e126);
    uint _e132 = local_13;
    local_11 = uint(8);
    uint _e138 = local_11;
    local_61 = uint(_e138);
    uint _e141 = local_61;
    _group_0_binding_0_cs[_e141] = floatBitsToUint(uintBitsToFloat(_e132));
    local_15 = 2147483649u;
    uint _e145 = local_15;
    uint _e149 = (floatBitsToUint(uintBitsToFloat(_e145)) & 2147483647u);
    local_16 = ((_e149 > 2139095040u) ? 2143289344u : _e149);
    uint _e155 = local_16;
    local_14 = uint(9);
    uint _e161 = local_14;
    local_62 = uint(_e161);
    uint _e164 = local_62;
    _group_0_binding_0_cs[_e164] = floatBitsToUint(uintBitsToFloat(_e155));
    local_18 = 8388607u;
    uint _e168 = local_18;
    uint _e172 = (floatBitsToUint(uintBitsToFloat(_e168)) & 2147483647u);
    local_19 = ((_e172 > 2139095040u) ? 2143289344u : _e172);
    uint _e178 = local_19;
    local_17 = uint(10);
    uint _e184 = local_17;
    local_63 = uint(_e184);
    uint _e187 = local_63;
    _group_0_binding_0_cs[_e187] = floatBitsToUint(uintBitsToFloat(_e178));
    local_21 = 2155872255u;
    uint _e191 = local_21;
    uint _e195 = (floatBitsToUint(uintBitsToFloat(_e191)) & 2147483647u);
    local_22 = ((_e195 > 2139095040u) ? 2143289344u : _e195);
    uint _e201 = local_22;
    local_20 = uint(11);
    uint _e207 = local_20;
    local_64 = uint(_e207);
    uint _e210 = local_64;
    _group_0_binding_0_cs[_e210] = floatBitsToUint(uintBitsToFloat(_e201));
    uint _e215 = (floatBitsToUint(3.4028235e38) & 2147483647u);
    local_24 = ((_e215 > 2139095040u) ? 2143289344u : _e215);
    uint _e221 = local_24;
    local_23 = uint(12);
    uint _e227 = local_23;
    local_65 = uint(_e227);
    uint _e230 = local_65;
    _group_0_binding_0_cs[_e230] = floatBitsToUint(uintBitsToFloat(_e221));
    uint _e236 = (floatBitsToUint(-(3.4028235e38)) & 2147483647u);
    local_26 = ((_e236 > 2139095040u) ? 2143289344u : _e236);
    uint _e242 = local_26;
    local_25 = uint(13);
    uint _e248 = local_25;
    local_66 = uint(_e248);
    uint _e251 = local_66;
    _group_0_binding_0_cs[_e251] = floatBitsToUint(uintBitsToFloat(_e242));
    local_28 = 2139095040u;
    uint _e255 = local_28;
    uint _e259 = (floatBitsToUint(uintBitsToFloat(_e255)) & 2147483647u);
    local_29 = ((_e259 > 2139095040u) ? 2143289344u : _e259);
    uint _e265 = local_29;
    local_27 = uint(14);
    uint _e271 = local_27;
    local_67 = uint(_e271);
    uint _e274 = local_67;
    _group_0_binding_0_cs[_e274] = floatBitsToUint(uintBitsToFloat(_e265));
    local_31 = 4286578688u;
    uint _e278 = local_31;
    uint _e282 = (floatBitsToUint(uintBitsToFloat(_e278)) & 2147483647u);
    local_32 = ((_e282 > 2139095040u) ? 2143289344u : _e282);
    uint _e288 = local_32;
    local_30 = uint(15);
    uint _e294 = local_30;
    local_68 = uint(_e294);
    uint _e297 = local_68;
    _group_0_binding_0_cs[_e297] = floatBitsToUint(uintBitsToFloat(_e288));
    local_34 = 2143363909u;
    uint _e301 = local_34;
    uint _e305 = (floatBitsToUint(uintBitsToFloat(_e301)) & 2147483647u);
    local_35 = ((_e305 > 2139095040u) ? 2143289344u : _e305);
    uint _e311 = local_35;
    local_33 = uint(16);
    uint _e317 = local_33;
    local_69 = uint(_e317);
    uint _e320 = local_69;
    _group_0_binding_0_cs[_e320] = floatBitsToUint(uintBitsToFloat(_e311));
    local_37 = 2139095041u;
    uint _e324 = local_37;
    uint _e328 = (floatBitsToUint(uintBitsToFloat(_e324)) & 2147483647u);
    local_38 = ((_e328 > 2139095040u) ? 2143289344u : _e328);
    uint _e334 = local_38;
    local_36 = uint(17);
    uint _e340 = local_36;
    local_70 = uint(_e340);
    uint _e343 = local_70;
    _group_0_binding_0_cs[_e343] = floatBitsToUint(uintBitsToFloat(_e334));
    value = -(2.75);
    float _e348 = value;
    value = (_e348 + float(1));
    uint _e354 = (floatBitsToUint(_e348) & 2147483647u);
    local_40 = ((_e354 > 2139095040u) ? 2143289344u : _e354);
    uint _e360 = local_40;
    local_39 = uint(18);
    uint _e366 = local_39;
    local_71 = uint(_e366);
    uint _e369 = local_71;
    _group_0_binding_0_cs[_e369] = floatBitsToUint(uintBitsToFloat(_e360));
    float _e371 = value;
    local_41 = uint(19);
    uint _e376 = local_41;
    local_72 = uint(_e376);
    uint _e379 = local_72;
    _group_0_binding_0_cs[_e379] = floatBitsToUint(_e371);
    int _e383 = fabs_3(-(3));
    local_42 = uint(20);
    uint _e388 = local_42;
    local_73 = uint(_e388);
    uint _e391 = local_73;
    _group_0_binding_0_cs[_e391] = uint(_e383);
    uint _e394 = fabs_4(3u);
    local_43 = uint(21);
    uint _e398 = local_43;
    local_74 = uint(_e398);
    uint _e401 = local_74;
    _group_0_binding_0_cs[_e401] = _e394;
    int _e404 = fabs_5(true);
    local_44 = uint(22);
    uint _e409 = local_44;
    local_75 = uint(_e409);
    uint _e412 = local_75;
    _group_0_binding_0_cs[_e412] = uint(_e404);
    int _e415 = fabs_5(false);
    local_45 = uint(23);
    uint _e420 = local_45;
    local_76 = uint(_e420);
    uint _e423 = local_76;
    _group_0_binding_0_cs[_e423] = uint(_e415);
    int _e426 = fabsf(true);
    local_46 = uint(24);
    uint _e431 = local_46;
    local_77 = uint(_e431);
    uint _e434 = local_77;
    _group_0_binding_0_cs[_e434] = uint(_e426);
    local_47 = 2147483649u;
    uint _e442 = local_47;
    float3_ _e445 = fabs_1(float3_(-(2.5), -(0.0), uintBitsToFloat(_e442)));
    triple = _e445;
    float _e448 = triple.x;
    local_48 = uint(25);
    uint _e453 = local_48;
    local_78 = uint(_e453);
    uint _e456 = local_78;
    _group_0_binding_0_cs[_e456] = floatBitsToUint(_e448);
    float _e459 = triple.y;
    local_49 = uint(26);
    uint _e464 = local_49;
    local_79 = uint(_e464);
    uint _e467 = local_79;
    _group_0_binding_0_cs[_e467] = floatBitsToUint(_e459);
    float _e470 = triple.z;
    local_50 = uint(27);
    uint _e475 = local_50;
    local_80 = uint(_e475);
    uint _e478 = local_80;
    _group_0_binding_0_cs[_e478] = floatBitsToUint(_e470);
    float _e483 = fabsf_1(-(2.0), 3.0);
    local_51 = uint(28);
    uint _e488 = local_51;
    local_81 = uint(_e488);
    uint _e491 = local_81;
    _group_0_binding_0_cs[_e491] = floatBitsToUint(_e483);
    vec2 _e498 = fabs(vec2(-(3.0), -(4.0)));
    pair = _e498;
    vec4 _e509 = fabs_2(vec4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e509;
    float _e513 = pair.x;
    float _e514 = pair.y;
    float _e517 = quadruple.x;
    float _e520 = quadruple.w;
    local_52 = uint(29);
    uint _e526 = local_52;
    local_82 = uint(_e526);
    uint _e529 = local_82;
    _group_0_binding_0_cs[_e529] = floatBitsToUint((((_e513 + _e514) + _e517) + _e520));
}

