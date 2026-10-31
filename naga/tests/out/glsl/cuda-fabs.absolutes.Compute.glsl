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
    uint local_53 = 0u;
    uint local_54 = 0u;
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_53 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_53;
    float _e15 = value_2.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_54 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_54;
    return vec2(uintBitsToFloat(_e12), uintBitsToFloat(_e24));
}

float3_ fabs_1(float3_ value_3) {
    float3_ value_4 = float3_(0.0, 0.0, 0.0);
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_55 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_55;
    float _e15 = value_4.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_56 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_56;
    float _e27 = value_4.z;
    uint _e30 = (floatBitsToUint(_e27) & 2147483647u);
    local_57 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_57;
    return float3_(uintBitsToFloat(_e12), uintBitsToFloat(_e24), uintBitsToFloat(_e36));
}

vec4 fabs_2(vec4 value_5) {
    vec4 value_6 = vec4(0.0);
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = (floatBitsToUint(_e3) & 2147483647u);
    local_58 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_58;
    float _e15 = value_6.y;
    uint _e18 = (floatBitsToUint(_e15) & 2147483647u);
    local_59 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_59;
    float _e27 = value_6.z;
    uint _e30 = (floatBitsToUint(_e27) & 2147483647u);
    local_60 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_60;
    float _e39 = value_6.w;
    uint _e42 = (floatBitsToUint(_e39) & 2147483647u);
    local_61 = ((_e42 > 2139095040u) ? 2143289344u : _e42);
    uint _e48 = local_61;
    return vec4(uintBitsToFloat(_e12), uintBitsToFloat(_e24), uintBitsToFloat(_e36), uintBitsToFloat(_e48));
}

float absolute(float value_7) {
    uint local_62 = 0u;
    uint _e3 = (floatBitsToUint(value_7) & 2147483647u);
    local_62 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_62;
    return uintBitsToFloat(_e9);
}

float converted_absolute(int value_8) {
    uint local_63 = 0u;
    uint _e4 = (floatBitsToUint(float(value_8)) & 2147483647u);
    local_63 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_63;
    return uintBitsToFloat(_e10);
}

float converted_absolute_1(uint value_9) {
    uint local_64 = 0u;
    uint _e4 = (floatBitsToUint(float(value_9)) & 2147483647u);
    local_64 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_64;
    return uintBitsToFloat(_e10);
}

float converted_absolute_2(bool value_10) {
    uint local_65 = 0u;
    uint _e4 = (floatBitsToUint(float(value_10)) & 2147483647u);
    local_65 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_65;
    return uintBitsToFloat(_e10);
}

int fabs_3(int value_11) {
    return (value_11 + 40);
}

uint fabs_4(uint value_12) {
    return (value_12 + 50u);
}

int fabs_5(bool value_13) {
    int local_66 = 0;
    if (value_13) {
        local_66 = 7;
    } else {
        local_66 = 9;
    }
    int _e6 = local_66;
    return _e6;
}

int fabsf(bool value_14) {
    int local_67 = 0;
    if (value_14) {
        local_67 = 11;
    } else {
        local_67 = 13;
    }
    int _e6 = local_67;
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
    uint _e3 = (floatBitsToUint(0.0) & 2147483647u);
    local_1 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_1;
    local = uint(0);
    uint _e15 = local;
    _group_0_binding_0_cs[_e15] = floatBitsToUint(uintBitsToFloat(_e9));
    uint _e22 = (floatBitsToUint(-(0.0)) & 2147483647u);
    local_3 = ((_e22 > 2139095040u) ? 2143289344u : _e22);
    uint _e28 = local_3;
    local_2 = uint(1);
    uint _e34 = local_2;
    _group_0_binding_0_cs[_e34] = floatBitsToUint(uintBitsToFloat(_e28));
    uint _e40 = (floatBitsToUint(-(1.75)) & 2147483647u);
    local_5 = ((_e40 > 2139095040u) ? 2143289344u : _e40);
    uint _e46 = local_5;
    local_4 = uint(2);
    uint _e52 = local_4;
    _group_0_binding_0_cs[_e52] = floatBitsToUint(uintBitsToFloat(_e46));
    float _e56 = absolute(-(1.25));
    local_6 = uint(3);
    uint _e61 = local_6;
    _group_0_binding_0_cs[_e61] = floatBitsToUint(_e56);
    float _e65 = converted_absolute(-(3));
    local_7 = uint(4);
    uint _e70 = local_7;
    _group_0_binding_0_cs[_e70] = floatBitsToUint(_e65);
    float _e73 = converted_absolute_1(4294967295u);
    local_8 = uint(5);
    uint _e78 = local_8;
    _group_0_binding_0_cs[_e78] = floatBitsToUint(_e73);
    float _e81 = converted_absolute_2(true);
    local_9 = uint(6);
    uint _e86 = local_9;
    _group_0_binding_0_cs[_e86] = floatBitsToUint(_e81);
    float _e89 = converted_absolute_2(false);
    local_10 = uint(7);
    uint _e94 = local_10;
    _group_0_binding_0_cs[_e94] = floatBitsToUint(_e89);
    local_12 = 1u;
    uint _e98 = local_12;
    uint _e102 = (floatBitsToUint(uintBitsToFloat(_e98)) & 2147483647u);
    local_13 = ((_e102 > 2139095040u) ? 2143289344u : _e102);
    uint _e108 = local_13;
    local_11 = uint(8);
    uint _e114 = local_11;
    _group_0_binding_0_cs[_e114] = floatBitsToUint(uintBitsToFloat(_e108));
    local_15 = 2147483649u;
    uint _e118 = local_15;
    uint _e122 = (floatBitsToUint(uintBitsToFloat(_e118)) & 2147483647u);
    local_16 = ((_e122 > 2139095040u) ? 2143289344u : _e122);
    uint _e128 = local_16;
    local_14 = uint(9);
    uint _e134 = local_14;
    _group_0_binding_0_cs[_e134] = floatBitsToUint(uintBitsToFloat(_e128));
    local_18 = 8388607u;
    uint _e138 = local_18;
    uint _e142 = (floatBitsToUint(uintBitsToFloat(_e138)) & 2147483647u);
    local_19 = ((_e142 > 2139095040u) ? 2143289344u : _e142);
    uint _e148 = local_19;
    local_17 = uint(10);
    uint _e154 = local_17;
    _group_0_binding_0_cs[_e154] = floatBitsToUint(uintBitsToFloat(_e148));
    local_21 = 2155872255u;
    uint _e158 = local_21;
    uint _e162 = (floatBitsToUint(uintBitsToFloat(_e158)) & 2147483647u);
    local_22 = ((_e162 > 2139095040u) ? 2143289344u : _e162);
    uint _e168 = local_22;
    local_20 = uint(11);
    uint _e174 = local_20;
    _group_0_binding_0_cs[_e174] = floatBitsToUint(uintBitsToFloat(_e168));
    uint _e179 = (floatBitsToUint(3.4028235e38) & 2147483647u);
    local_24 = ((_e179 > 2139095040u) ? 2143289344u : _e179);
    uint _e185 = local_24;
    local_23 = uint(12);
    uint _e191 = local_23;
    _group_0_binding_0_cs[_e191] = floatBitsToUint(uintBitsToFloat(_e185));
    uint _e197 = (floatBitsToUint(-(3.4028235e38)) & 2147483647u);
    local_26 = ((_e197 > 2139095040u) ? 2143289344u : _e197);
    uint _e203 = local_26;
    local_25 = uint(13);
    uint _e209 = local_25;
    _group_0_binding_0_cs[_e209] = floatBitsToUint(uintBitsToFloat(_e203));
    local_28 = 2139095040u;
    uint _e213 = local_28;
    uint _e217 = (floatBitsToUint(uintBitsToFloat(_e213)) & 2147483647u);
    local_29 = ((_e217 > 2139095040u) ? 2143289344u : _e217);
    uint _e223 = local_29;
    local_27 = uint(14);
    uint _e229 = local_27;
    _group_0_binding_0_cs[_e229] = floatBitsToUint(uintBitsToFloat(_e223));
    local_31 = 4286578688u;
    uint _e233 = local_31;
    uint _e237 = (floatBitsToUint(uintBitsToFloat(_e233)) & 2147483647u);
    local_32 = ((_e237 > 2139095040u) ? 2143289344u : _e237);
    uint _e243 = local_32;
    local_30 = uint(15);
    uint _e249 = local_30;
    _group_0_binding_0_cs[_e249] = floatBitsToUint(uintBitsToFloat(_e243));
    local_34 = 2143363909u;
    uint _e253 = local_34;
    uint _e257 = (floatBitsToUint(uintBitsToFloat(_e253)) & 2147483647u);
    local_35 = ((_e257 > 2139095040u) ? 2143289344u : _e257);
    uint _e263 = local_35;
    local_33 = uint(16);
    uint _e269 = local_33;
    _group_0_binding_0_cs[_e269] = floatBitsToUint(uintBitsToFloat(_e263));
    local_37 = 2139095041u;
    uint _e273 = local_37;
    uint _e277 = (floatBitsToUint(uintBitsToFloat(_e273)) & 2147483647u);
    local_38 = ((_e277 > 2139095040u) ? 2143289344u : _e277);
    uint _e283 = local_38;
    local_36 = uint(17);
    uint _e289 = local_36;
    _group_0_binding_0_cs[_e289] = floatBitsToUint(uintBitsToFloat(_e283));
    value = -(2.75);
    float _e294 = value;
    value = (_e294 + float(1));
    uint _e300 = (floatBitsToUint(_e294) & 2147483647u);
    local_40 = ((_e300 > 2139095040u) ? 2143289344u : _e300);
    uint _e306 = local_40;
    local_39 = uint(18);
    uint _e312 = local_39;
    _group_0_binding_0_cs[_e312] = floatBitsToUint(uintBitsToFloat(_e306));
    float _e314 = value;
    local_41 = uint(19);
    uint _e319 = local_41;
    _group_0_binding_0_cs[_e319] = floatBitsToUint(_e314);
    int _e323 = fabs_3(-(3));
    local_42 = uint(20);
    uint _e328 = local_42;
    _group_0_binding_0_cs[_e328] = uint(_e323);
    uint _e331 = fabs_4(3u);
    local_43 = uint(21);
    uint _e335 = local_43;
    _group_0_binding_0_cs[_e335] = _e331;
    int _e338 = fabs_5(true);
    local_44 = uint(22);
    uint _e343 = local_44;
    _group_0_binding_0_cs[_e343] = uint(_e338);
    int _e346 = fabs_5(false);
    local_45 = uint(23);
    uint _e351 = local_45;
    _group_0_binding_0_cs[_e351] = uint(_e346);
    int _e354 = fabsf(true);
    local_46 = uint(24);
    uint _e359 = local_46;
    _group_0_binding_0_cs[_e359] = uint(_e354);
    local_47 = 2147483649u;
    uint _e367 = local_47;
    float3_ _e370 = fabs_1(float3_(-(2.5), -(0.0), uintBitsToFloat(_e367)));
    triple = _e370;
    float _e373 = triple.x;
    local_48 = uint(25);
    uint _e378 = local_48;
    _group_0_binding_0_cs[_e378] = floatBitsToUint(_e373);
    float _e381 = triple.y;
    local_49 = uint(26);
    uint _e386 = local_49;
    _group_0_binding_0_cs[_e386] = floatBitsToUint(_e381);
    float _e389 = triple.z;
    local_50 = uint(27);
    uint _e394 = local_50;
    _group_0_binding_0_cs[_e394] = floatBitsToUint(_e389);
    float _e399 = fabsf_1(-(2.0), 3.0);
    local_51 = uint(28);
    uint _e404 = local_51;
    _group_0_binding_0_cs[_e404] = floatBitsToUint(_e399);
    vec2 _e411 = fabs(vec2(-(3.0), -(4.0)));
    pair = _e411;
    vec4 _e422 = fabs_2(vec4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e422;
    float _e426 = pair.x;
    float _e427 = pair.y;
    float _e430 = quadruple.x;
    float _e433 = quadruple.w;
    local_52 = uint(29);
    uint _e439 = local_52;
    _group_0_binding_0_cs[_e439] = floatBitsToUint((((_e426 + _e427) + _e430) + _e433));
}

