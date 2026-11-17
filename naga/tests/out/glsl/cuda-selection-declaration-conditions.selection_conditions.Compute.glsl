#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    int cursor = 0;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    int header = 0;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    int state = 0;
    uint local_10 = 0u;
    int fixed_ = 0;
    int pass = 0;
    int skip = 0;
    bool stop = false;
    uint local_11 = 0u;
    int nested = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    float fraction = 0.0;
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
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    cursor = 0;
    int _e15 = cursor;
    cursor = (_e15 + 1);
    local = uint((lane + uint(_e15)));
    uint _e22 = local;
    int selected = _group_0_binding_0_cs[_e22];
    if ((selected != 0)) {
        local_1 = base;
        uint _e32 = local_1;
        local_18 = _e32;
        uint _e34 = local_18;
        _group_0_binding_1_cs[_e34] = uint((selected + 100));
    } else {
        local_2 = base;
        uint _e41 = local_2;
        local_19 = _e41;
        uint _e43 = local_19;
        _group_0_binding_1_cs[_e43] = uint((selected + 200));
    }
    int _e46 = cursor;
    local_3 = uint((base + 1u));
    uint _e52 = local_3;
    _group_0_binding_1_cs[_e52] = uint(_e46);
    header = 50;
    int header_1 = _group_0_binding_0_cs[lane];
    if ((header_1 != 0)) {
        local_4 = uint((base + 2u));
        uint _e68 = local_4;
        local_20 = _e68;
        uint _e70 = local_20;
        _group_0_binding_1_cs[_e70] = uint((header_1 + 300));
    } else {
        local_5 = uint((base + 2u));
        uint _e79 = local_5;
        local_21 = _e79;
        uint _e81 = local_21;
        _group_0_binding_1_cs[_e81] = uint((header_1 + 400));
    }
    int _e83 = header;
    local_6 = uint((base + 3u));
    uint _e89 = local_6;
    _group_0_binding_1_cs[_e89] = uint(_e83);
    local_7 = uint((lane + 4u));
    uint _e95 = local_7;
    int seed = _group_0_binding_0_cs[_e95];
    bool ready = (seed > 0);
    if (ready) {
        local_8 = uint((base + 4u));
        uint _e107 = local_8;
        local_22 = _e107;
        uint _e109 = local_22;
        _group_0_binding_1_cs[_e109] = uint((seed + 500));
    } else {
        local_9 = uint((base + 4u));
        uint _e118 = local_9;
        local_23 = _e118;
        uint _e120 = local_23;
        _group_0_binding_1_cs[_e120] = uint((seed + 600));
    }
    state = 0;
    int _e124 = cursor;
    cursor = (_e124 + 1);
    uint mode = (lane - 3u * (lane / 3u));
    switch(mode) {
        case 0u: {
            int _e129 = state;
            state = (_e129 + 10);
            break;
        }
        case 1u: {
            int _e132 = state;
            state = (_e132 + 20);
            int _e135 = state;
            state = (_e135 + 30);
            break;
        }
        default: {
            int _e138 = state;
            state = (_e138 + 30);
            break;
        }
    }
    int _e141 = state;
    local_10 = uint((base + 5u));
    uint _e147 = local_10;
    _group_0_binding_1_cs[_e147] = uint(_e141);
    fixed_ = 2;
    int _e151 = fixed_;
    switch(_e151) {
        case 2: {
            int _e152 = state;
            state = (_e152 + 7);
            break;
        }
        default: {
            break;
        }
    }
    {
        pass = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e178 = pass;
                pass = (_e178 + 1);
            }
            loop_init = false;
            int _e157 = pass;
            if ((_e157 < 4)) {
            } else {
                break;
            }
            int _e160 = pass;
            skip = int((_e160 == 1));
            int _e165 = skip;
            if ((_e165 != 0)) {
                continue;
            }
            int _e168 = pass;
            stop = (_e168 == 3);
            bool _e172 = stop;
            if (_e172) {
                break;
            }
            int _e173 = pass;
            int _e176 = state;
            state = (_e176 + (_e173 + 1));
        }
    }
    int _e181 = state;
    local_11 = uint((base + 6u));
    uint _e187 = local_11;
    _group_0_binding_1_cs[_e187] = uint(_e181);
    int nested_1 = _group_0_binding_0_cs[lane];
    if ((nested_1 != 0)) {
        {
            nested = 9;
            int _e195 = nested;
            int _e196 = state;
            state = (_e196 + _e195);
        }
        local_12 = uint((base + 7u));
        uint _e205 = local_12;
        local_24 = _e205;
        uint _e207 = local_24;
        _group_0_binding_1_cs[_e207] = uint((nested_1 + 700));
    } else {
        local_13 = uint((base + 7u));
        uint _e213 = local_13;
        local_25 = _e213;
        uint _e215 = local_25;
        _group_0_binding_1_cs[_e215] = 800u;
    }
    int _e218 = state;
    local_14 = uint((base + 8u));
    uint _e224 = local_14;
    _group_0_binding_1_cs[_e224] = uint(_e218);
    fraction = 0.5;
    float _e228 = fraction;
    uint _e230 = _naga_fabsf(floatBitsToUint(_e228));
    if ((_e230 != 0u)) {
        int _e233 = state;
        state = (_e233 + 1);
    }
    int _e236 = state;
    local_15 = uint((base + 9u));
    uint _e242 = local_15;
    _group_0_binding_1_cs[_e242] = uint(_e236);
    int _e245 = _group_0_binding_0_cs[lane];
    if ((_e245 != 0)) {
        int _e248 = state;
        state = (_e248 + 1);
    }
    int _e251 = state;
    local_16 = uint((base + 10u));
    uint _e257 = local_16;
    _group_0_binding_1_cs[_e257] = uint(_e251);
    int _e259 = cursor;
    local_17 = uint((base + 11u));
    uint _e265 = local_17;
    _group_0_binding_1_cs[_e265] = uint(_e259);
}

