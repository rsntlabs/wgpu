#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };

shared uint shared_values[4];


uint _naga_fns(uint mask, uint base, int offset) {
    int position = 0;
    int remaining = 0;
    if ((base > 31u)) {
        return 4294967295u;
    }
    uint _e8 = (base & 31u);
    if ((offset == 0)) {
        return ((((mask >> _e8) & 1u) != 0u) ? base : 4294967295u);
    }
    int _e18 = ((offset > 0) ? 1 : -1);
    position = int(_e8);
    remaining = offset;
    while(true) {
        int _e23 = position;
        if (((_e23 < 0) || (_e23 > 31))) {
            break;
        }
        uint _e27 = uint(_e23);
        if ((((mask >> (_e27 & 31u)) & 1u) != 0u)) {
            int _e32 = remaining;
            if ((_e32 == _e18)) {
                return _e27;
            }
            remaining = (_e32 - _e18);
        }
        position = (_e23 + _e18);
    }
    return 4294967295u;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uint row = 0u;
    uint at = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint value = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    int local_6 = 0;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    bool local_10 = false;
    bool local_11 = false;
    uint local_12 = 0u;
    uint index = 0u;
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
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    shared_values[lane] = (lane + 1u);
    uint _e14 = _naga_fns(1u, 0u, 1);
    if ((_e14 == 0u)) {
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
    }
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e77 = row;
                row = (_e77 + 4u);
            }
            loop_init = false;
            uint _e18 = row;
            if ((_e18 < count)) {
            } else {
                break;
            }
            uint _e20 = row;
            at = (1u + (_e20 * 3u));
            uint _e26 = at;
            local_1 = _e26;
            uint _e28 = local_1;
            local_23 = _e28;
            uint _e30 = local_23;
            uint _e32 = _group_0_binding_1_cs[_e30];
            local_24 = _e32;
            uint _e34 = local_24;
            local_20 = _e34;
            uint _e36 = local_20;
            uint _e37 = at;
            local_2 = uint((_e37 + 1u));
            uint _e42 = local_2;
            local_25 = _e42;
            uint _e44 = local_25;
            uint _e46 = _group_0_binding_1_cs[_e44];
            local_26 = _e46;
            uint _e48 = local_26;
            local_21 = _e48;
            uint _e50 = local_21;
            uint _e51 = at;
            local_3 = uint((_e51 + 2u));
            uint _e56 = local_3;
            local_27 = _e56;
            uint _e58 = local_27;
            uint _e60 = _group_0_binding_1_cs[_e58];
            local_28 = _e60;
            uint _e62 = local_28;
            local_22 = _e62;
            uint _e64 = local_22;
            uint _e66 = _naga_fns(_e36, _e50, int(_e64));
            uint _e67 = row;
            local = uint((4u + _e67));
            uint _e72 = local;
            local_29 = _e72;
            uint _e74 = local_29;
            _group_0_binding_0_cs[_e74] = _e66;
        }
    }
    uint base_1 = ((4u + count) + (lane * 11u));
    value = 1u;
    uint _e87 = value;
    value = (_e87 + uint(1));
    local_4 = ((_e87 * 16909060u) ^ 2164195711u);
    uint _e96 = local_4;
    uint _e97 = value;
    value = (_e97 + uint(1));
    local_5 = ((_e97 * 5u) & 31u);
    uint _e106 = local_5;
    uint _e107 = value;
    value = (_e107 + uint(1));
    local_6 = (2 - int(_e107));
    int _e115 = local_6;
    uint _e116 = _naga_fns(_e96, _e106, _e115);
    _group_0_binding_0_cs[base_1] = _e116;
    uint _e119 = value;
    local_7 = uint((base_1 + 1u));
    uint _e124 = local_7;
    _group_0_binding_0_cs[_e124] = _e119;
    if (((lane & 1u) == 0u)) {
        uint _e130 = value;
        value = (_e130 + uint(1));
        uint _e136 = _naga_fns(_e130, 0u, 1);
        local_8 = _e136;
    } else {
        local_8 = 0u;
    }
    uint _e140 = value;
    local_9 = uint((base_1 + 2u));
    uint _e145 = local_9;
    _group_0_binding_0_cs[_e145] = _e140;
    local_10 = false;
    if (false) {
        uint _e149 = value;
        value = (_e149 + uint(1));
        uint _e155 = _naga_fns(_e149, 0u, 1);
        local_10 = (_e155 != 0u);
    }
    local_11 = true;
    if (true) {
    } else {
        uint _e160 = value;
        value = (_e160 + uint(1));
        uint _e166 = _naga_fns(_e160, 0u, 1);
        local_11 = (_e166 != 0u);
    }
    uint _e169 = value;
    value = (_e169 + uint(1));
    uint _e175 = _naga_fns(_e169, 0u, 1);
    uint _e176 = value;
    local_12 = uint((base_1 + 3u));
    uint _e181 = local_12;
    _group_0_binding_0_cs[_e181] = _e176;
    index = 1u;
    uint _e185 = index;
    index = (_e185 + uint(1));
    uint _e190 = _group_0_binding_1_cs[_e185];
    uint _e191 = index;
    index = (_e191 + uint(1));
    uint _e196 = _group_0_binding_1_cs[_e191];
    uint _e197 = index;
    index = (_e197 + uint(1));
    uint _e202 = _group_0_binding_1_cs[_e197];
    uint _e204 = _naga_fns(_e190, _e196, int(_e202));
    local_13 = uint((base_1 + 4u));
    uint _e209 = local_13;
    _group_0_binding_0_cs[_e209] = _e204;
    uint _e211 = index;
    local_14 = uint((base_1 + 5u));
    uint _e216 = local_14;
    _group_0_binding_0_cs[_e216] = _e211;
    uint _e221 = _naga_fns(2863311530u, 2u, 0);
    local_15 = uint((base_1 + 6u));
    uint _e226 = local_15;
    _group_0_binding_0_cs[_e226] = _e221;
    uint _e231 = _naga_fns(2863311530u, 2u, 1);
    local_16 = uint((base_1 + 7u));
    uint _e236 = local_16;
    _group_0_binding_0_cs[_e236] = _e231;
    uint _e242 = _naga_fns(2863311530u, 2u, -(1));
    local_17 = uint((base_1 + 8u));
    uint _e247 = local_17;
    _group_0_binding_0_cs[_e247] = _e242;
    uint _e255 = _naga_fns(4294967295u, 31u, (-(2147483647) - 1));
    local_18 = uint((base_1 + 9u));
    uint _e260 = local_18;
    _group_0_binding_0_cs[_e260] = _e255;
    uint _e267 = shared_values[((lane + 1u) & 3u)];
    local_19 = uint((base_1 + 10u));
    uint _e272 = local_19;
    _group_0_binding_0_cs[_e272] = _e267;
}

