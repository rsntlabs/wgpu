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
    uint base = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint value = 0u;
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
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    bool local_19 = false;
    bool local_20 = false;
    uint local_21 = 0u;
    uint index = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint scale = 0u;
    uint scale_1 = 0u;
    uint scale_2 = 0u;
    uint scale_3 = 0u;
    uint scale_4 = 0u;
    uint scale_5 = 0u;
    uint scale_6 = 0u;
    uint scale_7 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e118 = row;
                row = (_e118 + 4u);
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
            local_28 = _e17;
            uint _e19 = local_28;
            uint _e21 = _group_0_binding_1_cs[_e19];
            local_29 = _e21;
            uint _e23 = local_29;
            local_26 = _e23;
            uint _e25 = local_26;
            a = _e25;
            uint _e27 = row;
            local_1 = uint((2u + (_e27 * 2u)));
            uint _e34 = local_1;
            local_30 = _e34;
            uint _e36 = local_30;
            uint _e38 = _group_0_binding_1_cs[_e36];
            local_31 = _e38;
            uint _e40 = local_31;
            local_27 = _e40;
            uint _e42 = local_27;
            b = _e42;
            uint _e44 = row;
            base = (4u + (_e44 * 4u));
            uint _e50 = a;
            int _e51 = int(_e50);
            uint _e52 = b;
            int _e53 = int(_e52);
            uint _e60 = base;
            local_2 = _e60;
            uint _e62 = local_2;
            local_32 = _e62;
            uint _e64 = local_32;
            _group_0_binding_0_cs[_e64] = uint(((_e51 & _e53) + ((_e51 ^ _e53) >> 1u)));
            uint _e67 = a;
            int _e68 = int(_e67);
            uint _e69 = b;
            int _e70 = int(_e69);
            uint _e77 = base;
            local_3 = uint((_e77 + 1u));
            uint _e82 = local_3;
            local_33 = _e82;
            uint _e84 = local_33;
            _group_0_binding_0_cs[_e84] = uint(((_e68 | _e70) - ((_e68 ^ _e70) >> 1u)));
            uint _e86 = a;
            uint _e87 = b;
            uint _e93 = base;
            local_4 = uint((_e93 + 2u));
            uint _e98 = local_4;
            local_34 = _e98;
            uint _e100 = local_34;
            _group_0_binding_0_cs[_e100] = ((_e86 & _e87) + ((_e86 ^ _e87) >> 1u));
            uint _e102 = a;
            uint _e103 = b;
            uint _e109 = base;
            local_5 = uint((_e109 + 3u));
            uint _e114 = local_5;
            local_35 = _e114;
            uint _e116 = local_35;
            _group_0_binding_0_cs[_e116] = ((_e102 | _e103) - ((_e102 ^ _e103) >> 1u));
        }
    }
    uint base_1 = ((4u + (count * 4u)) + (lane * 10u));
    value = 1u;
    scale = 0u;
    scale = 3u;
    uint _e134 = value;
    value = (_e134 + uint(1));
    uint _e138 = scale;
    local_6 = (_e134 * _e138);
    uint _e141 = local_6;
    int _e142 = int(_e141);
    scale_1 = 0u;
    scale_1 = 5u;
    uint _e147 = value;
    value = (_e147 + uint(1));
    uint _e151 = scale_1;
    local_7 = (_e147 * _e151);
    uint _e154 = local_7;
    int _e155 = int(_e154);
    _group_0_binding_0_cs[base_1] = uint(((_e142 & _e155) + ((_e142 ^ _e155) >> 1u)));
    scale_2 = 0u;
    scale_2 = 3u;
    uint _e168 = value;
    value = (_e168 + uint(1));
    uint _e172 = scale_2;
    local_9 = (_e168 * _e172);
    uint _e175 = local_9;
    int _e176 = int(_e175);
    scale_3 = 0u;
    scale_3 = 5u;
    uint _e181 = value;
    value = (_e181 + uint(1));
    uint _e185 = scale_3;
    local_10 = (_e181 * _e185);
    uint _e188 = local_10;
    int _e189 = int(_e188);
    local_8 = uint((base_1 + 1u));
    uint _e200 = local_8;
    _group_0_binding_0_cs[_e200] = uint(((_e176 | _e189) - ((_e176 ^ _e189) >> 1u)));
    scale_4 = 0u;
    scale_4 = 3u;
    uint _e206 = value;
    value = (_e206 + uint(1));
    uint _e210 = scale_4;
    local_12 = (_e206 * _e210);
    uint _e213 = local_12;
    scale_5 = 0u;
    scale_5 = 5u;
    uint _e218 = value;
    value = (_e218 + uint(1));
    uint _e222 = scale_5;
    local_13 = (_e218 * _e222);
    uint _e225 = local_13;
    local_11 = uint((base_1 + 2u));
    uint _e235 = local_11;
    _group_0_binding_0_cs[_e235] = ((_e213 & _e225) + ((_e213 ^ _e225) >> 1u));
    scale_6 = 0u;
    scale_6 = 3u;
    uint _e241 = value;
    value = (_e241 + uint(1));
    uint _e245 = scale_6;
    local_15 = (_e241 * _e245);
    uint _e248 = local_15;
    scale_7 = 0u;
    scale_7 = 5u;
    uint _e253 = value;
    value = (_e253 + uint(1));
    uint _e257 = scale_7;
    local_16 = (_e253 * _e257);
    uint _e260 = local_16;
    local_14 = uint((base_1 + 3u));
    uint _e270 = local_14;
    _group_0_binding_0_cs[_e270] = ((_e248 | _e260) - ((_e248 ^ _e260) >> 1u));
    if (((lane & 1u) == 0u)) {
        uint _e276 = value;
        value = (_e276 + uint(1));
        uint _e280 = value;
        value = (_e280 + uint(1));
        local_17 = ((_e276 & _e280) + ((_e276 ^ _e280) >> 1u));
    } else {
        local_17 = 0u;
    }
    uint _e292 = value;
    local_18 = uint((base_1 + 4u));
    uint _e297 = local_18;
    _group_0_binding_0_cs[_e297] = _e292;
    local_19 = false;
    if (false) {
        uint _e301 = value;
        value = (_e301 + uint(1));
        int _e305 = int(_e301);
        uint _e306 = value;
        value = (_e306 + uint(1));
        int _e310 = int(_e306);
        local_19 = (((_e305 & _e310) + ((_e305 ^ _e310) >> 1u)) != 0);
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e320 = value;
        value = (_e320 + uint(1));
        uint _e324 = value;
        value = (_e324 + uint(1));
        local_20 = (((_e320 | _e324) - ((_e320 ^ _e324) >> 1u)) != 0u);
    }
    uint _e335 = value;
    value = (_e335 + uint(1));
    uint _e339 = value;
    value = (_e339 + uint(1));
    uint _e343 = value;
    local_21 = uint((base_1 + 5u));
    uint _e348 = local_21;
    _group_0_binding_0_cs[_e348] = _e343;
    index = 1u;
    uint _e352 = index;
    index = (_e352 + uint(1));
    uint _e357 = _group_0_binding_1_cs[_e352];
    uint _e358 = index;
    index = (_e358 + uint(1));
    uint _e363 = _group_0_binding_1_cs[_e358];
    local_22 = uint((base_1 + 6u));
    uint _e373 = local_22;
    _group_0_binding_0_cs[_e373] = ((_e357 & _e363) + ((_e357 ^ _e363) >> 1u));
    uint _e375 = index;
    local_23 = uint((base_1 + 7u));
    uint _e380 = local_23;
    _group_0_binding_0_cs[_e380] = _e375;
    int _e383 = -(1);
    local_24 = uint((base_1 + 8u));
    uint _e395 = local_24;
    _group_0_binding_0_cs[_e395] = uint(((_e383 & 0) + ((_e383 ^ 0) >> 1u)));
    int _e398 = -(1);
    local_25 = uint((base_1 + 9u));
    uint _e410 = local_25;
    _group_0_binding_0_cs[_e410] = uint(((_e398 | 0) - ((_e398 ^ 0) >> 1u)));
}

