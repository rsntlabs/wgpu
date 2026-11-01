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


uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

vec2 fabs(vec2 value_1) {
    vec2 value_2 = vec2(0.0);
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e5 = _naga_fabsf(floatBitsToUint(_e3));
    float _e8 = value_2.y;
    uint _e10 = _naga_fabsf(floatBitsToUint(_e8));
    return vec2(uintBitsToFloat(_e5), uintBitsToFloat(_e10));
}

float3_ fabs_1(float3_ value_3) {
    float3_ value_4 = float3_(0.0, 0.0, 0.0);
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e5 = _naga_fabsf(floatBitsToUint(_e3));
    float _e8 = value_4.y;
    uint _e10 = _naga_fabsf(floatBitsToUint(_e8));
    float _e13 = value_4.z;
    uint _e15 = _naga_fabsf(floatBitsToUint(_e13));
    return float3_(uintBitsToFloat(_e5), uintBitsToFloat(_e10), uintBitsToFloat(_e15));
}

vec4 fabs_2(vec4 value_5) {
    vec4 value_6 = vec4(0.0);
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e5 = _naga_fabsf(floatBitsToUint(_e3));
    float _e8 = value_6.y;
    uint _e10 = _naga_fabsf(floatBitsToUint(_e8));
    float _e13 = value_6.z;
    uint _e15 = _naga_fabsf(floatBitsToUint(_e13));
    float _e18 = value_6.w;
    uint _e20 = _naga_fabsf(floatBitsToUint(_e18));
    return vec4(uintBitsToFloat(_e5), uintBitsToFloat(_e10), uintBitsToFloat(_e15), uintBitsToFloat(_e20));
}

float absolute(float value_7) {
    uint _e2 = _naga_fabsf(floatBitsToUint(value_7));
    return uintBitsToFloat(_e2);
}

float converted_absolute(int value_8) {
    uint _e3 = _naga_fabsf(floatBitsToUint(float(value_8)));
    return uintBitsToFloat(_e3);
}

float converted_absolute_1(uint value_9) {
    uint _e3 = _naga_fabsf(floatBitsToUint(float(value_9)));
    return uintBitsToFloat(_e3);
}

float converted_absolute_2(bool value_10) {
    uint _e3 = _naga_fabsf(floatBitsToUint(float(value_10)));
    return uintBitsToFloat(_e3);
}

int fabs_3(int value_11) {
    return (value_11 + 40);
}

uint fabs_4(uint value_12) {
    return (value_12 + 50u);
}

int fabs_5(bool value_13) {
    int local_39 = 0;
    if (value_13) {
        local_39 = 7;
    } else {
        local_39 = 9;
    }
    int _e6 = local_39;
    return _e6;
}

int fabsf(bool value_14) {
    int local_40 = 0;
    if (value_14) {
        local_40 = 11;
    } else {
        local_40 = 13;
    }
    int _e6 = local_40;
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
    float value = 0.0;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    float3_ triple = float3_(0.0, 0.0, 0.0);
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    vec2 pair = vec2(0.0);
    vec4 quadruple = vec4(0.0);
    uint local_38 = 0u;
    uint _e2 = _naga_fabsf(floatBitsToUint(0.0));
    local = uint(0);
    uint _e8 = local;
    _group_0_binding_0_cs[_e8] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e14 = _naga_fabsf(floatBitsToUint(-(0.0)));
    local_1 = uint(1);
    uint _e20 = local_1;
    _group_0_binding_0_cs[_e20] = floatBitsToUint(uintBitsToFloat(_e14));
    uint _e25 = _naga_fabsf(floatBitsToUint(-(1.75)));
    local_2 = uint(2);
    uint _e31 = local_2;
    _group_0_binding_0_cs[_e31] = floatBitsToUint(uintBitsToFloat(_e25));
    float _e35 = absolute(-(1.25));
    local_3 = uint(3);
    uint _e40 = local_3;
    _group_0_binding_0_cs[_e40] = floatBitsToUint(_e35);
    float _e44 = converted_absolute(-(3));
    local_4 = uint(4);
    uint _e49 = local_4;
    _group_0_binding_0_cs[_e49] = floatBitsToUint(_e44);
    float _e52 = converted_absolute_1(4294967295u);
    local_5 = uint(5);
    uint _e57 = local_5;
    _group_0_binding_0_cs[_e57] = floatBitsToUint(_e52);
    float _e60 = converted_absolute_2(true);
    local_6 = uint(6);
    uint _e65 = local_6;
    _group_0_binding_0_cs[_e65] = floatBitsToUint(_e60);
    float _e68 = converted_absolute_2(false);
    local_7 = uint(7);
    uint _e73 = local_7;
    _group_0_binding_0_cs[_e73] = floatBitsToUint(_e68);
    local_9 = 1u;
    uint _e77 = local_9;
    uint _e80 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e77)));
    local_8 = uint(8);
    uint _e86 = local_8;
    _group_0_binding_0_cs[_e86] = floatBitsToUint(uintBitsToFloat(_e80));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    uint _e93 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e90)));
    local_10 = uint(9);
    uint _e99 = local_10;
    _group_0_binding_0_cs[_e99] = floatBitsToUint(uintBitsToFloat(_e93));
    local_13 = 8388607u;
    uint _e103 = local_13;
    uint _e106 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e103)));
    local_12 = uint(10);
    uint _e112 = local_12;
    _group_0_binding_0_cs[_e112] = floatBitsToUint(uintBitsToFloat(_e106));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    uint _e119 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e116)));
    local_14 = uint(11);
    uint _e125 = local_14;
    _group_0_binding_0_cs[_e125] = floatBitsToUint(uintBitsToFloat(_e119));
    uint _e129 = _naga_fabsf(floatBitsToUint(3.4028235e38));
    local_16 = uint(12);
    uint _e135 = local_16;
    _group_0_binding_0_cs[_e135] = floatBitsToUint(uintBitsToFloat(_e129));
    uint _e140 = _naga_fabsf(floatBitsToUint(-(3.4028235e38)));
    local_17 = uint(13);
    uint _e146 = local_17;
    _group_0_binding_0_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e140));
    local_19 = 2139095040u;
    uint _e150 = local_19;
    uint _e153 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e150)));
    local_18 = uint(14);
    uint _e159 = local_18;
    _group_0_binding_0_cs[_e159] = floatBitsToUint(uintBitsToFloat(_e153));
    local_21 = 4286578688u;
    uint _e163 = local_21;
    uint _e166 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e163)));
    local_20 = uint(15);
    uint _e172 = local_20;
    _group_0_binding_0_cs[_e172] = floatBitsToUint(uintBitsToFloat(_e166));
    local_23 = 2143363909u;
    uint _e176 = local_23;
    uint _e179 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e176)));
    local_22 = uint(16);
    uint _e185 = local_22;
    _group_0_binding_0_cs[_e185] = floatBitsToUint(uintBitsToFloat(_e179));
    local_25 = 2139095041u;
    uint _e189 = local_25;
    uint _e192 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e189)));
    local_24 = uint(17);
    uint _e198 = local_24;
    _group_0_binding_0_cs[_e198] = floatBitsToUint(uintBitsToFloat(_e192));
    value = -(2.75);
    float _e203 = value;
    value = (_e203 + float(1));
    uint _e208 = _naga_fabsf(floatBitsToUint(_e203));
    local_26 = uint(18);
    uint _e214 = local_26;
    _group_0_binding_0_cs[_e214] = floatBitsToUint(uintBitsToFloat(_e208));
    float _e216 = value;
    local_27 = uint(19);
    uint _e221 = local_27;
    _group_0_binding_0_cs[_e221] = floatBitsToUint(_e216);
    int _e225 = fabs_3(-(3));
    local_28 = uint(20);
    uint _e230 = local_28;
    _group_0_binding_0_cs[_e230] = uint(_e225);
    uint _e233 = fabs_4(3u);
    local_29 = uint(21);
    uint _e237 = local_29;
    _group_0_binding_0_cs[_e237] = _e233;
    int _e240 = fabs_5(true);
    local_30 = uint(22);
    uint _e245 = local_30;
    _group_0_binding_0_cs[_e245] = uint(_e240);
    int _e248 = fabs_5(false);
    local_31 = uint(23);
    uint _e253 = local_31;
    _group_0_binding_0_cs[_e253] = uint(_e248);
    int _e256 = fabsf(true);
    local_32 = uint(24);
    uint _e261 = local_32;
    _group_0_binding_0_cs[_e261] = uint(_e256);
    local_33 = 2147483649u;
    uint _e269 = local_33;
    float3_ _e272 = fabs_1(float3_(-(2.5), -(0.0), uintBitsToFloat(_e269)));
    triple = _e272;
    float _e275 = triple.x;
    local_34 = uint(25);
    uint _e280 = local_34;
    _group_0_binding_0_cs[_e280] = floatBitsToUint(_e275);
    float _e283 = triple.y;
    local_35 = uint(26);
    uint _e288 = local_35;
    _group_0_binding_0_cs[_e288] = floatBitsToUint(_e283);
    float _e291 = triple.z;
    local_36 = uint(27);
    uint _e296 = local_36;
    _group_0_binding_0_cs[_e296] = floatBitsToUint(_e291);
    float _e301 = fabsf_1(-(2.0), 3.0);
    local_37 = uint(28);
    uint _e306 = local_37;
    _group_0_binding_0_cs[_e306] = floatBitsToUint(_e301);
    vec2 _e313 = fabs(vec2(-(3.0), -(4.0)));
    pair = _e313;
    vec4 _e324 = fabs_2(vec4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e324;
    float _e328 = pair.x;
    float _e329 = pair.y;
    float _e332 = quadruple.x;
    float _e335 = quadruple.w;
    local_38 = uint(29);
    uint _e341 = local_38;
    _group_0_binding_0_cs[_e341] = floatBitsToUint((((_e328 + _e329) + _e332) + _e335));
}

