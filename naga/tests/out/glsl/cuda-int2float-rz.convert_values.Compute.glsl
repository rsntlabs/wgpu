#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_4 {
    uint value;
};
layout(std430) readonly buffer type_2_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };


int forward(int value) {
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
    int local_4 = 0;
    int local_5 = 0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int local_11 = 0;
    uint local_12 = 0u;
    int local_13 = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    int value_1 = _group_0_binding_0_cs[index];
    counter = 0u;
    uint _e20 = uint(value_1);
    uint _e22 = (_e20 >> 31u);
    uint _e28 = ((_e20 ^ ((_e22 != 0u) ? 4294967295u : 0u)) + _e22);
    uint _e32 = (31u - uint(31 - findMSB((_e28 | 1u))));
    uint _e34 = min(_e32, 23u);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(((_e28 != 0u) ? ((_e22 << 31u) | (((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> (_e32 - _e34)) & 8388607u))) : 0u)));
    int _e53 = forward(value_1);
    uint _e54 = uint(_e53);
    uint _e56 = (_e54 >> 31u);
    uint _e62 = ((_e54 ^ ((_e56 != 0u) ? 4294967295u : 0u)) + _e56);
    uint _e66 = (31u - uint(31 - findMSB((_e62 | 1u))));
    uint _e68 = min(_e66, 23u);
    local = uint((base + 1u));
    uint _e89 = local;
    _group_0_binding_1_cs[_e89] = floatBitsToUint(uintBitsToFloat(((_e62 != 0u) ? ((_e56 << 31u) | (((_e66 + 127u) << 23u) | (((_e62 << (23u - _e68)) >> (_e66 - _e68)) & 8388607u))) : 0u)));
    uint _e91 = counter;
    counter = (_e91 + uint(1));
    uint _e95 = uint(value_1);
    uint _e97 = (_e95 >> 31u);
    uint _e103 = ((_e95 ^ ((_e97 != 0u) ? 4294967295u : 0u)) + _e97);
    uint _e107 = (31u - uint(31 - findMSB((_e103 | 1u))));
    uint _e109 = min(_e107, 23u);
    local_1 = uint((base + 2u));
    uint _e130 = local_1;
    _group_0_binding_1_cs[_e130] = floatBitsToUint(uintBitsToFloat(((_e103 != 0u) ? ((_e97 << 31u) | (((_e107 + 127u) << 23u) | (((_e103 << (23u - _e109)) >> (_e107 - _e109)) & 8388607u))) : 0u)));
    uint _e132 = counter;
    local_2 = uint((base + 3u));
    uint _e137 = local_2;
    _group_0_binding_1_cs[_e137] = _e132;
    if (((index & 1u) != 0u)) {
        uint _e143 = counter;
        local_10 = _e143;
        uint _e145 = local_10;
        counter = (_e145 + uint(1));
        local_11 = value_1;
        int _e150 = local_11;
        local_4 = _e150;
        int _e152 = local_4;
        uint _e153 = uint(_e152);
        uint _e155 = (_e153 >> 31u);
        uint _e161 = ((_e153 ^ ((_e155 != 0u) ? 4294967295u : 0u)) + _e155);
        uint _e165 = (31u - uint(31 - findMSB((_e161 | 1u))));
        uint _e167 = min(_e165, 23u);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e161 != 0u) ? ((_e155 << 31u) | (((_e165 + 127u) << 23u) | (((_e161 << (23u - _e167)) >> (_e165 - _e167)) & 8388607u))) : 0u)));
    } else {
        uint _e185 = counter;
        local_12 = _e185;
        uint _e187 = local_12;
        counter = (_e187 + uint(1));
        local_13 = value_1;
        int _e192 = local_13;
        local_5 = _e192;
        int _e194 = local_5;
        uint _e195 = uint(_e194);
        uint _e197 = (_e195 >> 31u);
        uint _e203 = ((_e195 ^ ((_e197 != 0u) ? 4294967295u : 0u)) + _e197);
        uint _e207 = (31u - uint(31 - findMSB((_e203 | 1u))));
        uint _e209 = min(_e207, 23u);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e203 != 0u) ? ((_e197 << 31u) | (((_e207 + 127u) << 23u) | (((_e203 << (23u - _e209)) >> (_e207 - _e209)) & 8388607u))) : 0u)));
    }
    uint _e228 = local_6;
    local_3 = uint((base + 4u));
    uint _e233 = local_3;
    _group_0_binding_1_cs[_e233] = _e228;
    uint _e235 = counter;
    local_7 = uint((base + 5u));
    uint _e240 = local_7;
    _group_0_binding_1_cs[_e240] = _e235;
    uint _e244 = uint(int(4294967295u));
    uint _e246 = (_e244 >> 31u);
    uint _e252 = ((_e244 ^ ((_e246 != 0u) ? 4294967295u : 0u)) + _e246);
    uint _e256 = (31u - uint(31 - findMSB((_e252 | 1u))));
    uint _e258 = min(_e256, 23u);
    local_8 = uint((base + 6u));
    uint _e279 = local_8;
    _group_0_binding_1_cs[_e279] = floatBitsToUint(uintBitsToFloat(((_e252 != 0u) ? ((_e246 << 31u) | (((_e256 + 127u) << 23u) | (((_e252 << (23u - _e258)) >> (_e256 - _e258)) & 8388607u))) : 0u)));
    uint _e284 = uint(int(-(3.5)));
    uint _e286 = (_e284 >> 31u);
    uint _e292 = ((_e284 ^ ((_e286 != 0u) ? 4294967295u : 0u)) + _e286);
    uint _e296 = (31u - uint(31 - findMSB((_e292 | 1u))));
    uint _e298 = min(_e296, 23u);
    local_9 = uint((base + 7u));
    uint _e319 = local_9;
    _group_0_binding_1_cs[_e319] = floatBitsToUint(uintBitsToFloat(((_e292 != 0u) ? ((_e286 << 31u) | (((_e296 + 127u) << 23u) | (((_e292 << (23u - _e298)) >> (_e296 - _e298)) & 8388607u))) : 0u)));
}

