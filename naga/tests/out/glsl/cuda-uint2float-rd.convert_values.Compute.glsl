#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_2 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_2_block_2Compute { type_2 _group_0_binding_2_cs; };


uint forward(uint value) {
    return value;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
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
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint value_1 = _group_0_binding_0_cs[index];
    counter = 0u;
    uint _e24 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e26 = min(_e24, 23u);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? (((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> (_e24 - _e26)) & 8388607u)) : 0u)));
    uint _e44 = forward(value_1);
    uint _e49 = (31u - uint(31 - findMSB((_e44 | 1u))));
    uint _e51 = min(_e49, 23u);
    local = uint((base + 1u));
    uint _e71 = local;
    _group_0_binding_1_cs[_e71] = floatBitsToUint(uintBitsToFloat(((_e44 != 0u) ? (((_e49 + 127u) << 23u) | (((_e44 << (23u - _e51)) >> (_e49 - _e51)) & 8388607u)) : 0u)));
    uint _e73 = counter;
    counter = (_e73 + uint(1));
    uint _e81 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e83 = min(_e81, 23u);
    local_1 = uint((base + 2u));
    uint _e103 = local_1;
    _group_0_binding_1_cs[_e103] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? (((_e81 + 127u) << 23u) | (((value_1 << (23u - _e83)) >> (_e81 - _e83)) & 8388607u)) : 0u)));
    uint _e105 = counter;
    local_2 = uint((base + 3u));
    uint _e110 = local_2;
    _group_0_binding_1_cs[_e110] = _e105;
    if (((index & 1u) != 0u)) {
        uint _e116 = counter;
        local_12 = _e116;
        uint _e118 = local_12;
        counter = (_e118 + uint(1));
        local_13 = value_1;
        uint _e123 = local_13;
        local_4 = _e123;
        uint _e125 = local_4;
        uint _e130 = (31u - uint(31 - findMSB((_e125 | 1u))));
        uint _e132 = min(_e130, 23u);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e125 != 0u) ? (((_e130 + 127u) << 23u) | (((_e125 << (23u - _e132)) >> (_e130 - _e132)) & 8388607u)) : 0u)));
    } else {
        uint _e149 = counter;
        local_14 = _e149;
        uint _e151 = local_14;
        counter = (_e151 + uint(1));
        local_15 = value_1;
        uint _e156 = local_15;
        local_5 = _e156;
        uint _e158 = local_5;
        uint _e163 = (31u - uint(31 - findMSB((_e158 | 1u))));
        uint _e165 = min(_e163, 23u);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e158 != 0u) ? (((_e163 + 127u) << 23u) | (((_e158 << (23u - _e165)) >> (_e163 - _e165)) & 8388607u)) : 0u)));
    }
    uint _e183 = local_6;
    local_3 = uint((base + 4u));
    uint _e188 = local_3;
    _group_0_binding_1_cs[_e188] = _e183;
    uint _e190 = counter;
    local_7 = uint((base + 5u));
    uint _e195 = local_7;
    _group_0_binding_1_cs[_e195] = _e190;
    uint _e199 = uint(-(1));
    uint _e204 = (31u - uint(31 - findMSB((_e199 | 1u))));
    uint _e206 = min(_e204, 23u);
    local_8 = uint((base + 6u));
    uint _e226 = local_8;
    _group_0_binding_1_cs[_e226] = floatBitsToUint(uintBitsToFloat(((_e199 != 0u) ? (((_e204 + 127u) << 23u) | (((_e199 << (23u - _e206)) >> (_e204 - _e206)) & 8388607u)) : 0u)));
    uint _e229 = uint(3.5);
    uint _e234 = (31u - uint(31 - findMSB((_e229 | 1u))));
    uint _e236 = min(_e234, 23u);
    local_9 = uint((base + 7u));
    uint _e256 = local_9;
    _group_0_binding_1_cs[_e256] = floatBitsToUint(uintBitsToFloat(((_e229 != 0u) ? (((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> (_e234 - _e236)) & 8388607u)) : 0u)));
    uint _e262 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e264 = min(_e262, 23u);
    uint _e266 = (_e262 - _e264);
    local_10 = uint((base + 8u));
    uint _e290 = local_10;
    _group_0_binding_1_cs[_e290] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? ((((_e262 + 127u) << 23u) | (((value_1 << (23u - _e264)) >> _e266) & 8388607u)) + (((value_1 & ((1u << _e266) - 1u)) != 0u) ? 1u : 0u)) : 0u)));
    uint _e296 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e298 = min(_e296, 23u);
    uint _e300 = (_e296 - _e298);
    uint _e302 = ((value_1 << (23u - _e298)) >> _e300);
    uint _e309 = (1u << _e300);
    local_11 = uint((base + 9u));
    uint _e327 = local_11;
    _group_0_binding_1_cs[_e327] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? ((((_e296 + 127u) << 23u) | (_e302 & 8388607u)) + (((((value_1 & (_e309 - 1u)) << 1u) | (_e302 & 1u)) > _e309) ? 1u : 0u)) : 0u)));
}

