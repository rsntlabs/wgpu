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
    uint local_11 = 0u;
    int local_12 = 0;
    uint local_13 = 0u;
    int local_14 = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 9u));
    int value_1 = _group_0_binding_0_cs[index];
    counter = 0u;
    uint _e20 = uint(value_1);
    uint _e22 = (_e20 >> 31u);
    uint _e28 = ((_e20 ^ ((_e22 != 0u) ? 4294967295u : 0u)) + _e22);
    uint _e32 = (31u - uint(31 - findMSB((_e28 | 1u))));
    uint _e34 = min(_e32, 23u);
    uint _e36 = (_e32 - _e34);
    uint _e38 = ((_e28 << (23u - _e34)) >> _e36);
    uint _e46 = (1u << _e36);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(((_e28 != 0u) ? ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (_e38 & 8388607u)) + (((((_e28 & (_e46 - 1u)) << 1u) | (_e38 & 1u)) > _e46) ? 1u : 0u))) : 0u)));
    int _e62 = forward(value_1);
    uint _e63 = uint(_e62);
    uint _e65 = (_e63 >> 31u);
    uint _e71 = ((_e63 ^ ((_e65 != 0u) ? 4294967295u : 0u)) + _e65);
    uint _e75 = (31u - uint(31 - findMSB((_e71 | 1u))));
    uint _e77 = min(_e75, 23u);
    uint _e79 = (_e75 - _e77);
    uint _e81 = ((_e71 << (23u - _e77)) >> _e79);
    uint _e89 = (1u << _e79);
    local = uint((base + 1u));
    uint _e107 = local;
    _group_0_binding_1_cs[_e107] = floatBitsToUint(uintBitsToFloat(((_e71 != 0u) ? ((_e65 << 31u) | ((((_e75 + 127u) << 23u) | (_e81 & 8388607u)) + (((((_e71 & (_e89 - 1u)) << 1u) | (_e81 & 1u)) > _e89) ? 1u : 0u))) : 0u)));
    uint _e109 = counter;
    counter = (_e109 + uint(1));
    uint _e113 = uint(value_1);
    uint _e115 = (_e113 >> 31u);
    uint _e121 = ((_e113 ^ ((_e115 != 0u) ? 4294967295u : 0u)) + _e115);
    uint _e125 = (31u - uint(31 - findMSB((_e121 | 1u))));
    uint _e127 = min(_e125, 23u);
    uint _e129 = (_e125 - _e127);
    uint _e131 = ((_e121 << (23u - _e127)) >> _e129);
    uint _e139 = (1u << _e129);
    local_1 = uint((base + 2u));
    uint _e157 = local_1;
    _group_0_binding_1_cs[_e157] = floatBitsToUint(uintBitsToFloat(((_e121 != 0u) ? ((_e115 << 31u) | ((((_e125 + 127u) << 23u) | (_e131 & 8388607u)) + (((((_e121 & (_e139 - 1u)) << 1u) | (_e131 & 1u)) > _e139) ? 1u : 0u))) : 0u)));
    uint _e159 = counter;
    local_2 = uint((base + 3u));
    uint _e164 = local_2;
    _group_0_binding_1_cs[_e164] = _e159;
    if (((index & 1u) != 0u)) {
        uint _e170 = counter;
        local_11 = _e170;
        uint _e172 = local_11;
        counter = (_e172 + uint(1));
        local_12 = value_1;
        int _e177 = local_12;
        local_4 = _e177;
        int _e179 = local_4;
        uint _e180 = uint(_e179);
        uint _e182 = (_e180 >> 31u);
        uint _e188 = ((_e180 ^ ((_e182 != 0u) ? 4294967295u : 0u)) + _e182);
        uint _e192 = (31u - uint(31 - findMSB((_e188 | 1u))));
        uint _e194 = min(_e192, 23u);
        uint _e196 = (_e192 - _e194);
        uint _e198 = ((_e188 << (23u - _e194)) >> _e196);
        uint _e206 = (1u << _e196);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e188 != 0u) ? ((_e182 << 31u) | ((((_e192 + 127u) << 23u) | (_e198 & 8388607u)) + (((((_e188 & (_e206 - 1u)) << 1u) | (_e198 & 1u)) > _e206) ? 1u : 0u))) : 0u)));
    } else {
        uint _e221 = counter;
        local_13 = _e221;
        uint _e223 = local_13;
        counter = (_e223 + uint(1));
        local_14 = value_1;
        int _e228 = local_14;
        local_5 = _e228;
        int _e230 = local_5;
        uint _e231 = uint(_e230);
        uint _e233 = (_e231 >> 31u);
        uint _e239 = ((_e231 ^ ((_e233 != 0u) ? 4294967295u : 0u)) + _e233);
        uint _e243 = (31u - uint(31 - findMSB((_e239 | 1u))));
        uint _e245 = min(_e243, 23u);
        uint _e247 = (_e243 - _e245);
        uint _e249 = ((_e239 << (23u - _e245)) >> _e247);
        uint _e257 = (1u << _e247);
        local_6 = floatBitsToUint(uintBitsToFloat(((_e239 != 0u) ? ((_e233 << 31u) | ((((_e243 + 127u) << 23u) | (_e249 & 8388607u)) + (((((_e239 & (_e257 - 1u)) << 1u) | (_e249 & 1u)) > _e257) ? 1u : 0u))) : 0u)));
    }
    uint _e273 = local_6;
    local_3 = uint((base + 4u));
    uint _e278 = local_3;
    _group_0_binding_1_cs[_e278] = _e273;
    uint _e280 = counter;
    local_7 = uint((base + 5u));
    uint _e285 = local_7;
    _group_0_binding_1_cs[_e285] = _e280;
    uint _e289 = uint(int(4294967295u));
    uint _e291 = (_e289 >> 31u);
    uint _e297 = ((_e289 ^ ((_e291 != 0u) ? 4294967295u : 0u)) + _e291);
    uint _e301 = (31u - uint(31 - findMSB((_e297 | 1u))));
    uint _e303 = min(_e301, 23u);
    uint _e305 = (_e301 - _e303);
    uint _e307 = ((_e297 << (23u - _e303)) >> _e305);
    uint _e315 = (1u << _e305);
    local_8 = uint((base + 6u));
    uint _e333 = local_8;
    _group_0_binding_1_cs[_e333] = floatBitsToUint(uintBitsToFloat(((_e297 != 0u) ? ((_e291 << 31u) | ((((_e301 + 127u) << 23u) | (_e307 & 8388607u)) + (((((_e297 & (_e315 - 1u)) << 1u) | (_e307 & 1u)) > _e315) ? 1u : 0u))) : 0u)));
    uint _e338 = uint(int(-(3.5)));
    uint _e340 = (_e338 >> 31u);
    uint _e346 = ((_e338 ^ ((_e340 != 0u) ? 4294967295u : 0u)) + _e340);
    uint _e350 = (31u - uint(31 - findMSB((_e346 | 1u))));
    uint _e352 = min(_e350, 23u);
    uint _e354 = (_e350 - _e352);
    uint _e356 = ((_e346 << (23u - _e352)) >> _e354);
    uint _e364 = (1u << _e354);
    local_9 = uint((base + 7u));
    uint _e382 = local_9;
    _group_0_binding_1_cs[_e382] = floatBitsToUint(uintBitsToFloat(((_e346 != 0u) ? ((_e340 << 31u) | ((((_e350 + 127u) << 23u) | (_e356 & 8388607u)) + (((((_e346 & (_e364 - 1u)) << 1u) | (_e356 & 1u)) > _e364) ? 1u : 0u))) : 0u)));
    uint _e384 = uint(value_1);
    uint _e386 = (_e384 >> 31u);
    uint _e392 = ((_e384 ^ ((_e386 != 0u) ? 4294967295u : 0u)) + _e386);
    uint _e396 = (31u - uint(31 - findMSB((_e392 | 1u))));
    uint _e398 = min(_e396, 23u);
    local_10 = uint((base + 8u));
    uint _e419 = local_10;
    _group_0_binding_1_cs[_e419] = floatBitsToUint(uintBitsToFloat(((_e392 != 0u) ? ((_e386 << 31u) | (((_e396 + 127u) << 23u) | (((_e392 << (23u - _e398)) >> (_e396 - _e398)) & 8388607u))) : 0u)));
}

