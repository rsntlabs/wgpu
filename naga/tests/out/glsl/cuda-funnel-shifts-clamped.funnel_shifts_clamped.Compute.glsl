#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint row = 0u;
    uint at = 0u;
    uint lo = 0u;
    uint local = 0u;
    uint hi = 0u;
    uint local_1 = 0u;
    uint shift = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint value = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    bool local_8 = false;
    bool local_9 = false;
    uint local_10 = 0u;
    uint index = 0u;
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
            at = (1u + (_e10 * 3u));
            uint _e16 = at;
            local = _e16;
            uint _e18 = local;
            local_16 = _e18;
            uint _e20 = local_16;
            uint _e22 = _group_0_binding_1_cs[_e20];
            local_17 = _e22;
            uint _e24 = local_17;
            local_13 = _e24;
            uint _e26 = local_13;
            lo = _e26;
            uint _e28 = at;
            local_1 = uint((_e28 + 1u));
            uint _e33 = local_1;
            local_18 = _e33;
            uint _e35 = local_18;
            uint _e37 = _group_0_binding_1_cs[_e35];
            local_19 = _e37;
            uint _e39 = local_19;
            local_14 = _e39;
            uint _e41 = local_14;
            hi = _e41;
            uint _e43 = at;
            local_2 = uint((_e43 + 2u));
            uint _e48 = local_2;
            local_20 = _e48;
            uint _e50 = local_20;
            uint _e52 = _group_0_binding_1_cs[_e50];
            local_21 = _e52;
            uint _e54 = local_21;
            local_15 = _e54;
            uint _e56 = local_15;
            shift = _e56;
            uint _e58 = lo;
            uint _e59 = hi;
            uint _e60 = shift;
            uint _e62 = (_e60 & 31u);
            uint _e74 = row;
            local_3 = uint((4u + (_e74 * 2u)));
            uint _e81 = local_3;
            local_22 = _e81;
            uint _e83 = local_22;
            _group_0_binding_0_cs[_e83] = ((_e60 >= 32u) ? _e58 : ((_e62 != 0u) ? ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))) : _e59));
            uint _e86 = lo;
            uint _e87 = hi;
            uint _e88 = shift;
            uint _e90 = (_e88 & 31u);
            uint _e102 = row;
            local_4 = uint((5u + (_e102 * 2u)));
            uint _e109 = local_4;
            local_23 = _e109;
            uint _e111 = local_23;
            _group_0_binding_0_cs[_e111] = ((_e88 >= 32u) ? _e87 : ((_e90 != 0u) ? ((_e86 >> _e90) | (_e87 << ((32u - _e90) & 31u))) : _e86));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    uint _e125 = value;
    value = (_e125 + uint(1));
    uint _e129 = value;
    value = (_e129 + uint(1));
    uint _e133 = value;
    value = (_e133 + uint(1));
    uint _e138 = (_e133 & 31u);
    _group_0_binding_0_cs[base] = ((_e133 >= 32u) ? _e125 : ((_e138 != 0u) ? ((_e129 << _e138) | (_e125 >> ((32u - _e138) & 31u))) : _e129));
    uint _e152 = value;
    value = (_e152 + uint(1));
    uint _e156 = value;
    value = (_e156 + uint(1));
    uint _e160 = value;
    value = (_e160 + uint(1));
    uint _e165 = (_e160 & 31u);
    local_5 = uint((base + 1u));
    uint _e181 = local_5;
    _group_0_binding_0_cs[_e181] = ((_e160 >= 32u) ? _e156 : ((_e165 != 0u) ? ((_e152 >> _e165) | (_e156 << ((32u - _e165) & 31u))) : _e152));
    if (((lane & 1u) == 0u)) {
        uint _e187 = value;
        value = (_e187 + uint(1));
        uint _e191 = value;
        value = (_e191 + uint(1));
        uint _e195 = value;
        value = (_e195 + uint(1));
        uint _e200 = (_e195 & 31u);
        local_6 = ((_e195 >= 32u) ? _e187 : ((_e200 != 0u) ? ((_e191 << _e200) | (_e187 >> ((32u - _e200) & 31u))) : _e191));
    } else {
        local_6 = 0u;
    }
    uint _e215 = value;
    local_7 = uint((base + 2u));
    uint _e220 = local_7;
    _group_0_binding_0_cs[_e220] = _e215;
    local_8 = false;
    if (false) {
        uint _e224 = value;
        value = (_e224 + uint(1));
        uint _e228 = value;
        value = (_e228 + uint(1));
        uint _e232 = value;
        value = (_e232 + uint(1));
        uint _e237 = (_e232 & 31u);
        local_8 = (((_e232 >= 32u) ? _e228 : ((_e237 != 0u) ? ((_e224 >> _e237) | (_e228 << ((32u - _e237) & 31u))) : _e224)) != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        uint _e253 = value;
        value = (_e253 + uint(1));
        uint _e257 = value;
        value = (_e257 + uint(1));
        uint _e261 = value;
        value = (_e261 + uint(1));
        uint _e266 = (_e261 & 31u);
        local_9 = (((_e261 >= 32u) ? _e253 : ((_e266 != 0u) ? ((_e257 << _e266) | (_e253 >> ((32u - _e266) & 31u))) : _e257)) != 0u);
    }
    uint _e280 = value;
    value = (_e280 + uint(1));
    uint _e284 = value;
    value = (_e284 + uint(1));
    uint _e288 = value;
    value = (_e288 + uint(1));
    uint _e292 = value;
    local_10 = uint((base + 3u));
    uint _e297 = local_10;
    _group_0_binding_0_cs[_e297] = _e292;
    index = 1u;
    uint _e301 = index;
    index = (_e301 + uint(1));
    uint _e306 = _group_0_binding_1_cs[_e301];
    uint _e307 = index;
    index = (_e307 + uint(1));
    uint _e312 = _group_0_binding_1_cs[_e307];
    uint _e313 = index;
    index = (_e313 + uint(1));
    uint _e318 = _group_0_binding_1_cs[_e313];
    uint _e320 = (_e318 & 31u);
    local_11 = uint((base + 4u));
    uint _e336 = local_11;
    _group_0_binding_0_cs[_e336] = ((_e318 >= 32u) ? _e306 : ((_e320 != 0u) ? ((_e312 << _e320) | (_e306 >> ((32u - _e320) & 31u))) : _e312));
    uint _e338 = index;
    local_12 = uint((base + 5u));
    uint _e343 = local_12;
    _group_0_binding_0_cs[_e343] = _e338;
}

