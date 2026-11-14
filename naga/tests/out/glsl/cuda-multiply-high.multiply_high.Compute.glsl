#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

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
    bool local_11 = false;
    bool local_12 = false;
    uint local_13 = 0u;
    uint index = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint scale = 0u;
    uint scale_1 = 0u;
    uint scale_2 = 0u;
    uint scale_3 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e113 = row;
                row = (_e113 + 4u);
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
            local_22 = _e17;
            uint _e19 = local_22;
            uint _e21 = _group_0_binding_1_cs[_e19];
            local_23 = _e21;
            uint _e23 = local_23;
            local_20 = _e23;
            uint _e25 = local_20;
            a = _e25;
            uint _e27 = row;
            local_1 = uint((2u + (_e27 * 2u)));
            uint _e34 = local_1;
            local_24 = _e34;
            uint _e36 = local_24;
            uint _e38 = _group_0_binding_1_cs[_e36];
            local_25 = _e38;
            uint _e40 = local_25;
            local_21 = _e40;
            uint _e42 = local_21;
            b = _e42;
            uint _e44 = a;
            uint _e45 = b;
            uint _e47 = (_e44 & 65535u);
            uint _e48 = (_e45 & 65535u);
            uint _e50 = (_e44 >> 16u);
            uint _e51 = (_e45 >> 16u);
            uint _e55 = ((_e50 * _e48) + ((_e47 * _e48) >> 16u));
            uint _e64 = row;
            local_2 = uint((4u + (_e64 * 2u)));
            uint _e71 = local_2;
            local_26 = _e71;
            uint _e73 = local_26;
            _group_0_binding_0_cs[_e73] = (((_e50 * _e51) + (_e55 >> 16u)) + (((_e47 * _e51) + (_e55 & 65535u)) >> 16u));
            uint _e76 = a;
            int _e77 = int(_e76);
            uint _e78 = b;
            int _e79 = int(_e78);
            int _e81 = (_e77 & 65535);
            int _e82 = (_e79 & 65535);
            int _e84 = (_e77 >> 16u);
            int _e85 = (_e79 >> 16u);
            int _e92 = ((_e84 * _e82) + int(((uint(_e81) * uint(_e82)) >> 16u)));
            uint _e102 = row;
            local_3 = uint((5u + (_e102 * 2u)));
            uint _e109 = local_3;
            local_27 = _e109;
            uint _e111 = local_27;
            _group_0_binding_0_cs[_e111] = uint((((_e84 * _e85) + (_e92 >> 16u)) + (((_e81 * _e85) + (_e92 & 65535)) >> 16u)));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 10u));
    value = 1u;
    scale = 0u;
    scale = 1073741825u;
    uint _e129 = value;
    value = (_e129 + uint(1));
    uint _e133 = scale;
    local_4 = (_e129 * _e133);
    uint _e136 = local_4;
    scale_1 = 0u;
    scale_1 = 536870915u;
    uint _e141 = value;
    value = (_e141 + uint(1));
    uint _e145 = scale_1;
    local_5 = (_e141 * _e145);
    uint _e148 = local_5;
    uint _e150 = (_e136 & 65535u);
    uint _e151 = (_e148 & 65535u);
    uint _e153 = (_e136 >> 16u);
    uint _e154 = (_e148 >> 16u);
    uint _e158 = ((_e153 * _e151) + ((_e150 * _e151) >> 16u));
    _group_0_binding_0_cs[base] = (((_e153 * _e154) + (_e158 >> 16u)) + (((_e150 * _e154) + (_e158 & 65535u)) >> 16u));
    scale_2 = 0u;
    scale_2 = 1073741825u;
    uint _e173 = value;
    value = (_e173 + uint(1));
    uint _e177 = scale_2;
    local_7 = (_e173 * _e177);
    uint _e180 = local_7;
    int _e181 = int(_e180);
    scale_3 = 0u;
    scale_3 = 536870915u;
    uint _e186 = value;
    value = (_e186 + uint(1));
    uint _e190 = scale_3;
    local_8 = (_e186 * _e190);
    uint _e193 = local_8;
    int _e194 = int(_e193);
    int _e196 = (_e181 & 65535);
    int _e197 = (_e194 & 65535);
    int _e199 = (_e181 >> 16u);
    int _e200 = (_e194 >> 16u);
    int _e207 = ((_e199 * _e197) + int(((uint(_e196) * uint(_e197)) >> 16u)));
    local_6 = uint((base + 1u));
    uint _e221 = local_6;
    _group_0_binding_0_cs[_e221] = uint((((_e199 * _e200) + (_e207 >> 16u)) + (((_e196 * _e200) + (_e207 & 65535)) >> 16u)));
    if (((lane & 1u) == 0u)) {
        uint _e227 = value;
        value = (_e227 + uint(1));
        uint _e231 = value;
        value = (_e231 + uint(1));
        uint _e236 = (_e227 & 65535u);
        uint _e237 = (_e231 & 65535u);
        uint _e239 = (_e227 >> 16u);
        uint _e240 = (_e231 >> 16u);
        uint _e244 = ((_e239 * _e237) + ((_e236 * _e237) >> 16u));
        local_9 = (((_e239 * _e240) + (_e244 >> 16u)) + (((_e236 * _e240) + (_e244 & 65535u)) >> 16u));
    } else {
        local_9 = 0u;
    }
    uint _e256 = value;
    local_10 = uint((base + 2u));
    uint _e261 = local_10;
    _group_0_binding_0_cs[_e261] = _e256;
    local_11 = false;
    if (false) {
        uint _e265 = value;
        value = (_e265 + uint(1));
        int _e269 = int(_e265);
        uint _e270 = value;
        value = (_e270 + uint(1));
        int _e274 = int(_e270);
        int _e276 = (_e269 & 65535);
        int _e277 = (_e274 & 65535);
        int _e279 = (_e269 >> 16u);
        int _e280 = (_e274 >> 16u);
        int _e287 = ((_e279 * _e277) + int(((uint(_e276) * uint(_e277)) >> 16u)));
        local_11 = ((((_e279 * _e280) + (_e287 >> 16u)) + (((_e276 * _e280) + (_e287 & 65535)) >> 16u)) != 0);
    }
    local_12 = true;
    if (true) {
    } else {
        uint _e300 = value;
        value = (_e300 + uint(1));
        uint _e304 = value;
        value = (_e304 + uint(1));
        uint _e309 = (_e300 & 65535u);
        uint _e310 = (_e304 & 65535u);
        uint _e312 = (_e300 >> 16u);
        uint _e313 = (_e304 >> 16u);
        uint _e317 = ((_e312 * _e310) + ((_e309 * _e310) >> 16u));
        local_12 = ((((_e312 * _e313) + (_e317 >> 16u)) + (((_e309 * _e313) + (_e317 & 65535u)) >> 16u)) != 0u);
    }
    uint _e328 = value;
    value = (_e328 + uint(1));
    uint _e332 = value;
    value = (_e332 + uint(1));
    uint _e336 = value;
    local_13 = uint((base + 3u));
    uint _e341 = local_13;
    _group_0_binding_0_cs[_e341] = _e336;
    index = 1u;
    uint _e345 = index;
    index = (_e345 + uint(1));
    uint _e350 = _group_0_binding_1_cs[_e345];
    uint _e351 = index;
    index = (_e351 + uint(1));
    uint _e356 = _group_0_binding_1_cs[_e351];
    uint _e358 = (_e350 & 65535u);
    uint _e359 = (_e356 & 65535u);
    uint _e361 = (_e350 >> 16u);
    uint _e362 = (_e356 >> 16u);
    uint _e366 = ((_e361 * _e359) + ((_e358 * _e359) >> 16u));
    local_14 = uint((base + 4u));
    uint _e379 = local_14;
    _group_0_binding_0_cs[_e379] = (((_e361 * _e362) + (_e366 >> 16u)) + (((_e358 * _e362) + (_e366 & 65535u)) >> 16u));
    uint _e381 = index;
    local_15 = uint((base + 5u));
    uint _e386 = local_15;
    _group_0_binding_0_cs[_e386] = _e381;
    int _e389 = -(1);
    int _e391 = (_e389 & 65535);
    int _e393 = (1 & 65535);
    int _e395 = (_e389 >> 16u);
    int _e396 = (1 >> 16u);
    int _e403 = ((_e395 * _e393) + int(((uint(_e391) * uint(_e393)) >> 16u)));
    local_16 = uint((base + 6u));
    uint _e417 = local_16;
    _group_0_binding_0_cs[_e417] = uint((((_e395 * _e396) + (_e403 >> 16u)) + (((_e391 * _e396) + (_e403 & 65535)) >> 16u)));
    int _e422 = (-(2147483647) - 1);
    int _e426 = (-(2147483647) - 1);
    int _e428 = (_e422 & 65535);
    int _e429 = (_e426 & 65535);
    int _e431 = (_e422 >> 16u);
    int _e432 = (_e426 >> 16u);
    int _e439 = ((_e431 * _e429) + int(((uint(_e428) * uint(_e429)) >> 16u)));
    local_17 = uint((base + 7u));
    uint _e453 = local_17;
    _group_0_binding_0_cs[_e453] = uint((((_e431 * _e432) + (_e439 >> 16u)) + (((_e428 * _e432) + (_e439 & 65535)) >> 16u)));
    uint _e457 = (4294967295u & 65535u);
    uint _e459 = (4294967295u & 65535u);
    uint _e461 = (4294967295u >> 16u);
    uint _e462 = (4294967295u >> 16u);
    uint _e466 = ((_e461 * _e459) + ((_e457 * _e459) >> 16u));
    local_18 = uint((base + 8u));
    uint _e479 = local_18;
    _group_0_binding_0_cs[_e479] = (((_e461 * _e462) + (_e466 >> 16u)) + (((_e457 * _e462) + (_e466 & 65535u)) >> 16u));
    uint _e483 = uint(-(1));
    uint _e485 = (_e483 & 65535u);
    uint _e487 = (2u & 65535u);
    uint _e489 = (_e483 >> 16u);
    uint _e490 = (2u >> 16u);
    uint _e494 = ((_e489 * _e487) + ((_e485 * _e487) >> 16u));
    local_19 = uint((base + 9u));
    uint _e507 = local_19;
    _group_0_binding_0_cs[_e507] = (((_e489 * _e490) + (_e494 >> 16u)) + (((_e485 * _e490) + (_e494 & 65535u)) >> 16u));
}

