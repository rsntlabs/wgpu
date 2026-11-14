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
                uint _e109 = row;
                row = (_e109 + 4u);
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
            uint _e72 = row;
            local_3 = uint((4u + (_e72 * 2u)));
            uint _e79 = local_3;
            local_22 = _e79;
            uint _e81 = local_22;
            _group_0_binding_0_cs[_e81] = ((_e62 != 0u) ? ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))) : _e59);
            uint _e84 = lo;
            uint _e85 = hi;
            uint _e86 = shift;
            uint _e88 = (_e86 & 31u);
            uint _e98 = row;
            local_4 = uint((5u + (_e98 * 2u)));
            uint _e105 = local_4;
            local_23 = _e105;
            uint _e107 = local_23;
            _group_0_binding_0_cs[_e107] = ((_e88 != 0u) ? ((_e84 >> _e88) | (_e85 << ((32u - _e88) & 31u))) : _e84);
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    uint _e121 = value;
    value = (_e121 + uint(1));
    uint _e125 = value;
    value = (_e125 + uint(1));
    uint _e129 = value;
    value = (_e129 + uint(1));
    uint _e134 = (_e129 & 31u);
    _group_0_binding_0_cs[base] = ((_e134 != 0u) ? ((_e125 << _e134) | (_e121 >> ((32u - _e134) & 31u))) : _e125);
    uint _e146 = value;
    value = (_e146 + uint(1));
    uint _e150 = value;
    value = (_e150 + uint(1));
    uint _e154 = value;
    value = (_e154 + uint(1));
    uint _e159 = (_e154 & 31u);
    local_5 = uint((base + 1u));
    uint _e173 = local_5;
    _group_0_binding_0_cs[_e173] = ((_e159 != 0u) ? ((_e146 >> _e159) | (_e150 << ((32u - _e159) & 31u))) : _e146);
    if (((lane & 1u) == 0u)) {
        uint _e179 = value;
        value = (_e179 + uint(1));
        uint _e183 = value;
        value = (_e183 + uint(1));
        uint _e187 = value;
        value = (_e187 + uint(1));
        uint _e192 = (_e187 & 31u);
        local_6 = ((_e192 != 0u) ? ((_e183 << _e192) | (_e179 >> ((32u - _e192) & 31u))) : _e183);
    } else {
        local_6 = 0u;
    }
    uint _e205 = value;
    local_7 = uint((base + 2u));
    uint _e210 = local_7;
    _group_0_binding_0_cs[_e210] = _e205;
    local_8 = false;
    if (false) {
        uint _e214 = value;
        value = (_e214 + uint(1));
        uint _e218 = value;
        value = (_e218 + uint(1));
        uint _e222 = value;
        value = (_e222 + uint(1));
        uint _e227 = (_e222 & 31u);
        local_8 = (((_e227 != 0u) ? ((_e214 >> _e227) | (_e218 << ((32u - _e227) & 31u))) : _e214) != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        uint _e241 = value;
        value = (_e241 + uint(1));
        uint _e245 = value;
        value = (_e245 + uint(1));
        uint _e249 = value;
        value = (_e249 + uint(1));
        uint _e254 = (_e249 & 31u);
        local_9 = (((_e254 != 0u) ? ((_e245 << _e254) | (_e241 >> ((32u - _e254) & 31u))) : _e245) != 0u);
    }
    uint _e266 = value;
    value = (_e266 + uint(1));
    uint _e270 = value;
    value = (_e270 + uint(1));
    uint _e274 = value;
    value = (_e274 + uint(1));
    uint _e278 = value;
    local_10 = uint((base + 3u));
    uint _e283 = local_10;
    _group_0_binding_0_cs[_e283] = _e278;
    index = 1u;
    uint _e287 = index;
    index = (_e287 + uint(1));
    uint _e292 = _group_0_binding_1_cs[_e287];
    uint _e293 = index;
    index = (_e293 + uint(1));
    uint _e298 = _group_0_binding_1_cs[_e293];
    uint _e299 = index;
    index = (_e299 + uint(1));
    uint _e304 = _group_0_binding_1_cs[_e299];
    uint _e306 = (_e304 & 31u);
    local_11 = uint((base + 4u));
    uint _e320 = local_11;
    _group_0_binding_0_cs[_e320] = ((_e306 != 0u) ? ((_e298 << _e306) | (_e292 >> ((32u - _e306) & 31u))) : _e298);
    uint _e322 = index;
    local_12 = uint((base + 5u));
    uint _e327 = local_12;
    _group_0_binding_0_cs[_e327] = _e322;
}

