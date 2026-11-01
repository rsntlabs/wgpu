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
    int local_9 = 0;
    if (value_13) {
        local_9 = 7;
    } else {
        local_9 = 9;
    }
    int _e6 = local_9;
    return _e6;
}

int fabsf(bool value_14) {
    int local_10 = 0;
    if (value_14) {
        local_10 = 11;
    } else {
        local_10 = 13;
    }
    int _e6 = local_10;
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
    float value = 0.0;
    float3_ triple = float3_(0.0, 0.0, 0.0);
    uint local_8 = 0u;
    vec2 pair = vec2(0.0);
    vec4 quadruple = vec4(0.0);
    uint _e2 = _naga_fabsf(floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e12 = _naga_fabsf(floatBitsToUint(-(0.0)));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e12));
    uint _e21 = _naga_fabsf(floatBitsToUint(-(1.75)));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e21));
    float _e29 = absolute(-(1.25));
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(_e29);
    float _e36 = converted_absolute(-(3));
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e36);
    float _e42 = converted_absolute_1(4294967295u);
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(_e42);
    float _e48 = converted_absolute_2(true);
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(_e48);
    float _e54 = converted_absolute_2(false);
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(_e54);
    local = 1u;
    uint _e61 = local;
    uint _e64 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e61)));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(uintBitsToFloat(_e64));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    uint _e75 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e72)));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e75));
    local_2 = 8388607u;
    uint _e83 = local_2;
    uint _e86 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e83)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e86));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    uint _e97 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e94)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e97));
    uint _e105 = _naga_fabsf(floatBitsToUint(3.4028235e38));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e105));
    uint _e114 = _naga_fabsf(floatBitsToUint(-(3.4028235e38)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e114));
    local_4 = 2139095040u;
    uint _e122 = local_4;
    uint _e125 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e122)));
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e125));
    local_5 = 4286578688u;
    uint _e133 = local_5;
    uint _e136 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e133)));
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(uintBitsToFloat(_e136));
    local_6 = 2143363909u;
    uint _e144 = local_6;
    uint _e147 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e144)));
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(uintBitsToFloat(_e147));
    local_7 = 2139095041u;
    uint _e155 = local_7;
    uint _e158 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e155)));
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(uintBitsToFloat(_e158));
    value = -(2.75);
    float _e167 = value;
    value = (_e167 + float(1));
    uint _e172 = _naga_fabsf(floatBitsToUint(_e167));
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(uintBitsToFloat(_e172));
    float _e178 = value;
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(_e178);
    int _e185 = fabs_3(-(3));
    _group_0_binding_0_cs[uint(20)] = uint(_e185);
    uint _e191 = fabs_4(3u);
    _group_0_binding_0_cs[uint(21)] = _e191;
    int _e196 = fabs_5(true);
    _group_0_binding_0_cs[uint(22)] = uint(_e196);
    int _e202 = fabs_5(false);
    _group_0_binding_0_cs[uint(23)] = uint(_e202);
    int _e208 = fabsf(true);
    _group_0_binding_0_cs[uint(24)] = uint(_e208);
    local_8 = 2147483649u;
    uint _e219 = local_8;
    float3_ _e222 = fabs_1(float3_(-(2.5), -(0.0), uintBitsToFloat(_e219)));
    triple = _e222;
    float _e225 = triple.x;
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(_e225);
    float _e231 = triple.y;
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(_e231);
    float _e237 = triple.z;
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e237);
    float _e245 = fabsf_1(-(2.0), 3.0);
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e245);
    vec2 _e255 = fabs(vec2(-(3.0), -(4.0)));
    pair = _e255;
    vec4 _e266 = fabs_2(vec4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e266;
    float _e270 = pair.x;
    float _e271 = pair.y;
    float _e274 = quadruple.x;
    float _e277 = quadruple.w;
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint((((_e270 + _e271) + _e274) + _e277));
}

