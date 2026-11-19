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
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 9u));
    uint value_1 = _group_0_binding_0_cs[index];
    counter = 0u;
    uint _e24 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e26 = min(_e24, 23u);
    uint _e28 = (_e24 - _e26);
    uint _e30 = ((value_1 << (23u - _e26)) >> _e28);
    uint _e37 = (1u << _e28);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? ((((_e24 + 127u) << 23u) | (_e30 & 8388607u)) + (((((value_1 & (_e37 - 1u)) << 1u) | (_e30 & 1u)) > _e37) ? 1u : 0u)) : 0u)));
    uint _e53 = forward(value_1);
    uint _e58 = (31u - uint(31 - findMSB((_e53 | 1u))));
    uint _e60 = min(_e58, 23u);
    uint _e62 = (_e58 - _e60);
    uint _e64 = ((_e53 << (23u - _e60)) >> _e62);
    uint _e71 = (1u << _e62);
    local = uint((base + 1u));
    uint _e89 = local;
    _group_0_binding_1_cs[_e89] = floatBitsToUint(uintBitsToFloat(((_e53 != 0u) ? ((((_e58 + 127u) << 23u) | (_e64 & 8388607u)) + (((((_e53 & (_e71 - 1u)) << 1u) | (_e64 & 1u)) > _e71) ? 1u : 0u)) : 0u)));
    uint _e91 = counter;
    counter = (_e91 + uint(1));
    uint _e99 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e101 = min(_e99, 23u);
    uint _e103 = (_e99 - _e101);
    uint _e105 = ((value_1 << (23u - _e101)) >> _e103);
    uint _e112 = (1u << _e103);
    local_1 = uint((base + 2u));
    uint _e130 = local_1;
    _group_0_binding_1_cs[_e130] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? ((((_e99 + 127u) << 23u) | (_e105 & 8388607u)) + (((((value_1 & (_e112 - 1u)) << 1u) | (_e105 & 1u)) > _e112) ? 1u : 0u)) : 0u)));
    uint _e132 = counter;
    local_2 = uint((base + 3u));
    uint _e137 = local_2;
    _group_0_binding_1_cs[_e137] = _e132;
    if (((index & 1u) != 0u)) {
        uint _e143 = counter;
        local_11 = _e143;
        uint _e145 = local_11;
        counter = (_e145 + uint(1));
        local_12 = value_1;
        uint _e150 = local_12;
        local_4 = _e150;
        uint _e152 = local_4;
        uint _e157 = (31u - uint(31 - findMSB((_e152 | 1u))));
        uint _e159 = min(_e157, 23u);
        uint _e161 = (_e157 - _e159);
        uint _e163 = ((_e152 << (23u - _e159)) >> _e161);
        uint _e170 = (1u << _e161);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e152 != 0u) ? ((((_e157 + 127u) << 23u) | (_e163 & 8388607u)) + (((((_e152 & (_e170 - 1u)) << 1u) | (_e163 & 1u)) > _e170) ? 1u : 0u)) : 0u)));
    } else {
        uint _e185 = counter;
        local_13 = _e185;
        uint _e187 = local_13;
        counter = (_e187 + uint(1));
        local_14 = value_1;
        uint _e192 = local_14;
        local_5 = _e192;
        uint _e194 = local_5;
        uint _e199 = (31u - uint(31 - findMSB((_e194 | 1u))));
        uint _e201 = min(_e199, 23u);
        uint _e203 = (_e199 - _e201);
        uint _e205 = ((_e194 << (23u - _e201)) >> _e203);
        uint _e212 = (1u << _e203);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e194 != 0u) ? ((((_e199 + 127u) << 23u) | (_e205 & 8388607u)) + (((((_e194 & (_e212 - 1u)) << 1u) | (_e205 & 1u)) > _e212) ? 1u : 0u)) : 0u)));
    }
    uint _e228 = local_6;
    local_3 = uint((base + 4u));
    uint _e233 = local_3;
    _group_0_binding_1_cs[_e233] = _e228;
    uint _e235 = counter;
    local_7 = uint((base + 5u));
    uint _e240 = local_7;
    _group_0_binding_1_cs[_e240] = _e235;
    uint _e244 = uint(-(1));
    uint _e249 = (31u - uint(31 - findMSB((_e244 | 1u))));
    uint _e251 = min(_e249, 23u);
    uint _e253 = (_e249 - _e251);
    uint _e255 = ((_e244 << (23u - _e251)) >> _e253);
    uint _e262 = (1u << _e253);
    local_8 = uint((base + 6u));
    uint _e280 = local_8;
    _group_0_binding_1_cs[_e280] = floatBitsToUint(uintBitsToFloat(((_e244 != 0u) ? ((((_e249 + 127u) << 23u) | (_e255 & 8388607u)) + (((((_e244 & (_e262 - 1u)) << 1u) | (_e255 & 1u)) > _e262) ? 1u : 0u)) : 0u)));
    uint _e283 = uint(3.5);
    uint _e288 = (31u - uint(31 - findMSB((_e283 | 1u))));
    uint _e290 = min(_e288, 23u);
    uint _e292 = (_e288 - _e290);
    uint _e294 = ((_e283 << (23u - _e290)) >> _e292);
    uint _e301 = (1u << _e292);
    local_9 = uint((base + 7u));
    uint _e319 = local_9;
    _group_0_binding_1_cs[_e319] = floatBitsToUint(uintBitsToFloat(((_e283 != 0u) ? ((((_e288 + 127u) << 23u) | (_e294 & 8388607u)) + (((((_e283 & (_e301 - 1u)) << 1u) | (_e294 & 1u)) > _e301) ? 1u : 0u)) : 0u)));
    uint _e325 = (31u - uint(31 - findMSB((value_1 | 1u))));
    uint _e327 = min(_e325, 23u);
    local_10 = uint((base + 8u));
    uint _e347 = local_10;
    _group_0_binding_1_cs[_e347] = floatBitsToUint(uintBitsToFloat(((value_1 != 0u) ? (((_e325 + 127u) << 23u) | (((value_1 << (23u - _e327)) >> (_e325 - _e327)) & 8388607u)) : 0u)));
}

