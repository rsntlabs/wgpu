#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint row = 0u;
    uint a = 0u;
    uint local = 0u;
    uint b = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint value = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    bool local_13 = false;
    bool local_14 = false;
    uint local_15 = 0u;
    uint index = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint scale = 0u;
    uint bias = 0u;
    uint scale_1 = 0u;
    uint bias_1 = 0u;
    uint scale_2 = 0u;
    uint bias_2 = 0u;
    uint scale_3 = 0u;
    uint bias_3 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e125 = row;
                row = (_e125 + 64u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            local = uint((1u + (_e10 * 2u)));
            uint _e17 = local;
            local_25 = _e17;
            uint _e19 = local_25;
            uint _e21 = _group_0_binding_1_cs[_e19];
            local_26 = _e21;
            uint _e23 = local_26;
            local_23 = _e23;
            uint _e25 = local_23;
            a = _e25;
            uint _e27 = row;
            local_1 = uint((2u + (_e27 * 2u)));
            uint _e34 = local_1;
            local_27 = _e34;
            uint _e36 = local_27;
            uint _e38 = _group_0_binding_1_cs[_e36];
            local_28 = _e38;
            uint _e40 = local_28;
            local_24 = _e40;
            uint _e42 = local_24;
            b = _e42;
            uint _e44 = a;
            uint _e45 = b;
            uint _e63 = row;
            local_2 = uint((4u + (_e63 * 2u)));
            uint _e70 = local_2;
            local_29 = _e70;
            uint _e72 = local_29;
            _group_0_binding_0_cs[_e72] = (((((_e44 & 65535u) + (_e45 & 65535u)) >> 1u) & 65535u) | ((((((_e44 >> 16u) & 65535u) + ((_e45 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
            uint _e75 = a;
            uint _e76 = b;
            uint _e114 = row;
            local_3 = uint((5u + (_e114 * 2u)));
            uint _e121 = local_3;
            local_30 = _e121;
            uint _e123 = local_30;
            _group_0_binding_0_cs[_e123] = (((((((_e75 & 255u) + (_e76 & 255u)) >> 1u) & 255u) | ((((((_e75 >> 8u) & 255u) + ((_e76 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e75 >> 16u) & 255u) + ((_e76 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e75 >> 24u) & 255u) + ((_e76 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 13u));
    value = 1u;
    scale = 0u;
    bias = 0u;
    scale = 16909060u;
    bias = 2164195711u;
    uint _e145 = value;
    value = (_e145 + uint(1));
    uint _e149 = scale;
    uint _e151 = bias;
    local_4 = ((_e145 * _e149) ^ _e151);
    uint _e154 = local_4;
    scale_1 = 0u;
    bias_1 = 0u;
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e163 = value;
    value = (_e163 + uint(1));
    uint _e167 = scale_1;
    uint _e169 = bias_1;
    local_5 = ((_e163 * _e167) ^ _e169);
    uint _e172 = local_5;
    _group_0_binding_0_cs[base] = (((((_e154 & 65535u) + (_e172 & 65535u)) >> 1u) & 65535u) | ((((((_e154 >> 16u) & 65535u) + ((_e172 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    scale_2 = 0u;
    bias_2 = 0u;
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e200 = value;
    value = (_e200 + uint(1));
    uint _e204 = scale_2;
    uint _e206 = bias_2;
    local_7 = ((_e200 * _e204) ^ _e206);
    uint _e209 = local_7;
    scale_3 = 0u;
    bias_3 = 0u;
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e218 = value;
    value = (_e218 + uint(1));
    uint _e222 = scale_3;
    uint _e224 = bias_3;
    local_8 = ((_e218 * _e222) ^ _e224);
    uint _e227 = local_8;
    local_6 = uint((base + 1u));
    uint _e269 = local_6;
    _group_0_binding_0_cs[_e269] = (((((((_e209 & 255u) + (_e227 & 255u)) >> 1u) & 255u) | ((((((_e209 >> 8u) & 255u) + ((_e227 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e209 >> 16u) & 255u) + ((_e227 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e209 >> 24u) & 255u) + ((_e227 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    uint _e271 = value;
    value = (_e271 + uint(1));
    uint _e292 = (((((_e271 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e271 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_9 = uint((base + 2u));
    uint _e315 = local_9;
    _group_0_binding_0_cs[_e315] = (((((_e292 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e292 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    uint _e317 = value;
    local_10 = uint((base + 3u));
    uint _e322 = local_10;
    _group_0_binding_0_cs[_e322] = _e317;
    if (((lane & 1u) == 0u)) {
        uint _e328 = value;
        value = (_e328 + uint(1));
        uint _e332 = value;
        value = (_e332 + uint(1));
        local_11 = (((((((_e328 & 255u) + (_e332 & 255u)) >> 1u) & 255u) | ((((((_e328 >> 8u) & 255u) + ((_e332 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e328 >> 16u) & 255u) + ((_e332 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e328 >> 24u) & 255u) + ((_e332 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    } else {
        local_11 = 0u;
    }
    uint _e376 = value;
    local_12 = uint((base + 4u));
    uint _e381 = local_12;
    _group_0_binding_0_cs[_e381] = _e376;
    local_13 = false;
    if (false) {
        uint _e385 = value;
        value = (_e385 + uint(1));
        uint _e389 = value;
        value = (_e389 + uint(1));
        local_13 = ((((((_e385 & 65535u) + (_e389 & 65535u)) >> 1u) & 65535u) | ((((((_e385 >> 16u) & 65535u) + ((_e389 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u)) != 0u);
    }
    local_14 = true;
    if (true) {
    } else {
        uint _e414 = value;
        value = (_e414 + uint(1));
        uint _e418 = value;
        value = (_e418 + uint(1));
        local_14 = ((((((((_e414 & 255u) + (_e418 & 255u)) >> 1u) & 255u) | ((((((_e414 >> 8u) & 255u) + ((_e418 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e414 >> 16u) & 255u) + ((_e418 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e414 >> 24u) & 255u) + ((_e418 >> 24u) & 255u)) >> 1u) & 255u) << 24u)) != 0u);
    }
    uint _e461 = value;
    value = (_e461 + uint(1));
    uint _e465 = value;
    value = (_e465 + uint(1));
    uint _e469 = value;
    local_15 = uint((base + 5u));
    uint _e474 = local_15;
    _group_0_binding_0_cs[_e474] = _e469;
    index = 1u;
    uint _e478 = index;
    index = (_e478 + uint(1));
    uint _e483 = _group_0_binding_1_cs[_e478];
    uint _e484 = index;
    index = (_e484 + uint(1));
    uint _e489 = _group_0_binding_1_cs[_e484];
    local_16 = uint((base + 6u));
    uint _e531 = local_16;
    _group_0_binding_0_cs[_e531] = (((((((_e483 & 255u) + (_e489 & 255u)) >> 1u) & 255u) | ((((((_e483 >> 8u) & 255u) + ((_e489 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e483 >> 16u) & 255u) + ((_e489 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e483 >> 24u) & 255u) + ((_e489 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    uint _e533 = index;
    local_17 = uint((base + 7u));
    uint _e538 = local_17;
    _group_0_binding_0_cs[_e538] = _e533;
    local_18 = uint((base + 8u));
    uint _e563 = local_18;
    _group_0_binding_0_cs[_e563] = (((((4294967295u & 65535u) + (4294967295u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((4294967295u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_19 = uint((base + 9u));
    uint _e608 = local_19;
    _group_0_binding_0_cs[_e608] = (((((((4294967295u & 255u) + (0u & 255u)) >> 1u) & 255u) | ((((((4294967295u >> 8u) & 255u) + ((0u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((4294967295u >> 16u) & 255u) + ((0u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((4294967295u >> 24u) & 255u) + ((0u >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    local_20 = uint((base + 10u));
    uint _e633 = local_20;
    _group_0_binding_0_cs[_e633] = (((((4294967295u & 65535u) + (0u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((0u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_21 = uint((base + 11u));
    uint _e678 = local_21;
    _group_0_binding_0_cs[_e678] = (((((((0u & 255u) + (16843009u & 255u)) >> 1u) & 255u) | ((((((0u >> 8u) & 255u) + ((16843009u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((0u >> 16u) & 255u) + ((16843009u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((0u >> 24u) & 255u) + ((16843009u >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    local_22 = uint((base + 12u));
    uint _e703 = local_22;
    _group_0_binding_0_cs[_e703] = (((((4294901761u & 65535u) + (131071u & 65535u)) >> 1u) & 65535u) | ((((((4294901761u >> 16u) & 65535u) + ((131071u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
}

