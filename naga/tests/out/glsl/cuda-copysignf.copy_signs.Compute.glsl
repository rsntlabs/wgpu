#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


float copied(float value, float sign_) {
    return uintBitsToFloat(((floatBitsToUint(value) & 2147483647u) | (floatBitsToUint(sign_) & 2147483648u)));
}

int copysignf(bool value_1, bool sign_1) {
    int local_22 = 0;
    if (value_1) {
        local_22 = 7;
    } else {
        local_22 = 9;
    }
    int _e6 = local_22;
    return _e6;
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
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
    int cursor = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    bool run = false;
    bool local_15 = false;
    bool local_16 = false;
    uint local_17 = 0u;
    uint local_18 = 0u;
    float local_19 = 0.0;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 912u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float value_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float sign_2 = uintBitsToFloat(_e30);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(((floatBitsToUint(value_2) & 2147483647u) | (floatBitsToUint(sign_2) & 2147483648u))));
    float _e43 = copied(value_2, sign_2);
    local_2 = uint((base + 1u));
    uint _e49 = local_2;
    _group_0_binding_1_cs[_e49] = floatBitsToUint(_e43);
    local_3 = uint((base + 2u));
    uint _e67 = local_3;
    _group_0_binding_1_cs[_e67] = floatBitsToUint(uintBitsToFloat(((floatBitsToUint(0.0) & 2147483647u) | (floatBitsToUint(-(0.0)) & 2147483648u))));
    local_4 = uint((base + 3u));
    uint _e85 = local_4;
    _group_0_binding_1_cs[_e85] = floatBitsToUint(uintBitsToFloat(((floatBitsToUint(-(0.0)) & 2147483647u) | (floatBitsToUint(0.0) & 2147483648u))));
    local_6 = 4286578689u;
    uint _e89 = local_6;
    local_5 = uint((base + 4u));
    uint _e105 = local_5;
    _group_0_binding_1_cs[_e105] = floatBitsToUint(uintBitsToFloat(((floatBitsToUint(uintBitsToFloat(_e89)) & 2147483647u) | (floatBitsToUint(0.0) & 2147483648u))));
    local_8 = 2143363909u;
    uint _e109 = local_8;
    local_7 = uint((base + 5u));
    uint _e126 = local_7;
    _group_0_binding_1_cs[_e126] = floatBitsToUint(uintBitsToFloat(((floatBitsToUint(uintBitsToFloat(_e109)) & 2147483647u) | (floatBitsToUint(-(0.0)) & 2147483648u))));
    float _e133 = copied(float(-(3)), float(0u));
    local_9 = uint((base + 6u));
    uint _e139 = local_9;
    _group_0_binding_1_cs[_e139] = floatBitsToUint(_e133);
    float _e146 = copied(float(5u), float(-(1)));
    local_10 = uint((base + 7u));
    uint _e152 = local_10;
    _group_0_binding_1_cs[_e152] = floatBitsToUint(_e146);
    int _e156 = copysignf(true, false);
    local_11 = uint((base + 8u));
    uint _e162 = local_11;
    _group_0_binding_1_cs[_e162] = uint(_e156);
    cursor = 0;
    int _e168 = cursor;
    cursor = (_e168 + 1);
    local_13 = uint(((index * 2u) + uint(_e168)));
    uint _e175 = local_13;
    uint _e177 = _group_0_binding_0_cs[_e175];
    int _e181 = cursor;
    cursor = (_e181 + 1);
    local_14 = uint(((index * 2u) + uint(_e181)));
    uint _e188 = local_14;
    uint _e190 = _group_0_binding_0_cs[_e188];
    float _e192 = copied(uintBitsToFloat(_e177), uintBitsToFloat(_e190));
    local_12 = uint((base + 9u));
    uint _e198 = local_12;
    _group_0_binding_1_cs[_e198] = floatBitsToUint(_e192);
    run = false;
    bool _e202 = run;
    local_15 = _e202;
    if (_e202) {
        int _e204 = cursor;
        cursor = (_e204 + 1);
        uint _e217 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(((floatBitsToUint(float(_e204)) & 2147483647u) | (floatBitsToUint(sign_2) & 2147483648u)))));
        local_15 = (_e217 != 0u);
    }
    run = true;
    bool _e221 = run;
    local_16 = _e221;
    if (_e221) {
    } else {
        int _e223 = cursor;
        cursor = (_e223 + 1);
        uint _e236 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(((floatBitsToUint(float(_e223)) & 2147483647u) | (floatBitsToUint(sign_2) & 2147483648u)))));
        local_16 = (_e236 != 0u);
    }
    int _e239 = cursor;
    local_17 = uint((base + 10u));
    uint _e245 = local_17;
    _group_0_binding_1_cs[_e245] = uint(_e239);
    bool _e247 = run;
    if (_e247) {
        local_19 = uintBitsToFloat(((floatBitsToUint(value_2) & 2147483647u) | (floatBitsToUint(sign_2) & 2147483648u)));
    } else {
        int _e257 = cursor;
        cursor = (_e257 + 1);
        local_19 = uintBitsToFloat(((floatBitsToUint(float(_e257)) & 2147483647u) | (floatBitsToUint(sign_2) & 2147483648u)));
    }
    float _e271 = local_19;
    local_18 = uint((base + 11u));
    uint _e277 = local_18;
    _group_0_binding_1_cs[_e277] = floatBitsToUint(_e271);
    float _e283 = copied(float(true), -(1.0));
    local_20 = uint((base + 12u));
    uint _e289 = local_20;
    _group_0_binding_1_cs[_e289] = floatBitsToUint(_e283);
    int _e291 = cursor;
    local_21 = uint((base + 13u));
    uint _e297 = local_21;
    _group_0_binding_1_cs[_e297] = uint(_e291);
}

