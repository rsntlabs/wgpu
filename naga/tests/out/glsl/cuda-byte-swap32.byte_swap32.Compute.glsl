#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };


int swap_result(uint value_2) {
    return 1;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint row = 0u;
    uint value = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint value_1 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    bool local_7 = false;
    bool local_8 = false;
    uint local_9 = 0u;
    uint index = 0u;
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
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e92 = row;
                row = (_e92 + 4u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            local = uint((1u + _e10));
            uint _e15 = local;
            local_16 = _e15;
            uint _e17 = local_16;
            uint _e19 = _group_0_binding_1_cs[_e17];
            local_17 = _e19;
            uint _e21 = local_17;
            local_15 = _e21;
            uint _e23 = local_15;
            value = _e23;
            uint _e25 = value;
            uint _e40 = row;
            local_1 = uint((4u + (_e40 * 2u)));
            uint _e47 = local_1;
            local_18 = _e47;
            uint _e49 = local_18;
            _group_0_binding_0_cs[_e49] = ((((_e25 & 255u) << 24u) | ((_e25 & 65280u) << 8u)) | (((_e25 >> 8u) & 65280u) | (_e25 >> 24u)));
            uint _e52 = value;
            uint _e66 = ((((_e52 & 255u) << 24u) | ((_e52 & 65280u) << 8u)) | (((_e52 >> 8u) & 65280u) | (_e52 >> 24u)));
            uint _e81 = row;
            local_2 = uint((5u + (_e81 * 2u)));
            uint _e88 = local_2;
            local_19 = _e88;
            uint _e90 = local_19;
            _group_0_binding_0_cs[_e90] = ((((_e66 & 255u) << 24u) | ((_e66 & 65280u) << 8u)) | (((_e66 >> 8u) & 65280u) | (_e66 >> 24u)));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 10u));
    value_1 = (16909060u + lane);
    uint _e105 = value_1;
    value_1 = (_e105 + uint(1));
    _group_0_binding_0_cs[base] = ((((_e105 & 255u) << 24u) | ((_e105 & 65280u) << 8u)) | (((_e105 >> 8u) & 65280u) | (_e105 >> 24u)));
    uint _e125 = value_1;
    value_1 = (_e125 + uint(1));
    local_3 = uint((base + 1u));
    uint _e147 = local_3;
    _group_0_binding_0_cs[_e147] = ((((_e125 & 255u) << 24u) | ((_e125 & 65280u) << 8u)) | (((_e125 >> 8u) & 65280u) | (_e125 >> 24u)));
    uint _e149 = value_1;
    local_4 = uint((base + 2u));
    uint _e154 = local_4;
    _group_0_binding_0_cs[_e154] = _e149;
    if (((lane & 1u) == 0u)) {
        uint _e160 = value_1;
        value_1 = (_e160 + uint(1));
        local_5 = ((((_e160 & 255u) << 24u) | ((_e160 & 65280u) << 8u)) | (((_e160 >> 8u) & 65280u) | (_e160 >> 24u)));
    } else {
        local_5 = 0u;
    }
    uint _e181 = value_1;
    local_6 = uint((base + 3u));
    uint _e186 = local_6;
    _group_0_binding_0_cs[_e186] = _e181;
    local_7 = false;
    if (false) {
        uint _e190 = value_1;
        value_1 = (_e190 + uint(1));
        local_7 = (((((_e190 & 255u) << 24u) | ((_e190 & 65280u) << 8u)) | (((_e190 >> 8u) & 65280u) | (_e190 >> 24u))) != 0u);
    }
    local_8 = true;
    if (true) {
    } else {
        uint _e212 = value_1;
        value_1 = (_e212 + uint(1));
        local_8 = (((((_e212 & 255u) << 24u) | ((_e212 & 65280u) << 8u)) | (((_e212 >> 8u) & 65280u) | (_e212 >> 24u))) != 0u);
    }
    uint _e232 = value_1;
    value_1 = (_e232 + uint(1));
    uint _e236 = value_1;
    local_9 = uint((base + 4u));
    uint _e241 = local_9;
    _group_0_binding_0_cs[_e241] = _e236;
    index = 1u;
    uint _e245 = index;
    index = (_e245 + uint(1));
    uint _e250 = _group_0_binding_1_cs[_e245];
    local_10 = uint((base + 5u));
    uint _e269 = local_10;
    _group_0_binding_0_cs[_e269] = ((((_e250 & 255u) << 24u) | ((_e250 & 65280u) << 8u)) | (((_e250 >> 8u) & 65280u) | (_e250 >> 24u)));
    uint _e271 = index;
    local_11 = uint((base + 6u));
    uint _e276 = local_11;
    _group_0_binding_0_cs[_e276] = _e271;
    uint _e278 = value_1;
    int _e293 = swap_result(((((_e278 & 255u) << 24u) | ((_e278 & 65280u) << 8u)) | (((_e278 >> 8u) & 65280u) | (_e278 >> 24u))));
    local_12 = uint((base + 7u));
    uint _e299 = local_12;
    _group_0_binding_0_cs[_e299] = uint(_e293);
    local_13 = uint((base + 8u));
    uint _e320 = local_13;
    _group_0_binding_0_cs[_e320] = ((((4294967295u & 255u) << 24u) | ((4294967295u & 65280u) << 8u)) | (((4294967295u >> 8u) & 65280u) | (4294967295u >> 24u)));
    uint _e322 = value_1;
    uint _e336 = ((((_e322 & 255u) << 24u) | ((_e322 & 65280u) << 8u)) | (((_e322 >> 8u) & 65280u) | (_e322 >> 24u)));
    local_14 = uint((base + 9u));
    uint _e355 = local_14;
    _group_0_binding_0_cs[_e355] = ((((_e336 & 255u) << 24u) | ((_e336 & 65280u) << 8u)) | (((_e336 >> 8u) & 65280u) | (_e336 >> 24u)));
}

