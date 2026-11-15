#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    int state = 0;
    uint local_1 = 0u;
    int index = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    int header = 0;
    uint local_8 = 0u;
    int header_1 = 0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int header_2 = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    int pass = 0;
    int selected = 0;
    int selected_1 = 0;
    uint local_14 = 0u;
    uint local_15 = 0u;
    int read = 0;
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
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    int seed = _group_0_binding_0_cs[lane];
    local = uint((lane + 4u));
    uint _e13 = local;
    int other = _group_0_binding_0_cs[_e13];
    state = (int(lane) + 1);
    if ((seed > 0)) {
        int _e22 = state;
        state = (_e22 + 10);
    } else {
        int _e25 = state;
        state = (_e25 + 20);
    }
    int _e28 = state;
    _group_0_binding_1_cs[base] = uint(_e28);
    int _e32 = state;
    state = (_e32 + 1);
    if (false) {
        int _e36 = state;
        state = (_e36 + 99);
    } else {
        int _e39 = state;
        local_1 = uint((base + 1u));
        uint _e45 = local_1;
        local_21 = _e45;
        uint _e47 = local_21;
        _group_0_binding_1_cs[_e47] = uint(_e39);
    }
    index = 0;
    int _e51 = index;
    index = (_e51 + 1);
    int _e54 = state;
    state = (_e54 + 2);
    if ((seed < other)) {
        int _e58 = state;
        state = (_e58 + 3);
    } else {
        int _e61 = state;
        state = (_e61 + 5);
    }
    int _e64 = index;
    local_2 = uint((base + 2u));
    uint _e70 = local_2;
    _group_0_binding_1_cs[_e70] = uint(_e64);
    int _e72 = state;
    local_3 = uint((base + 3u));
    uint _e78 = local_3;
    _group_0_binding_1_cs[_e78] = uint(_e72);
    if ((seed < other)) {
        local_4 = uint((base + 4u));
        uint _e88 = local_4;
        local_22 = _e88;
        uint _e90 = local_22;
        _group_0_binding_1_cs[_e90] = uint((seed + 100));
    } else {
        local_5 = uint((base + 4u));
        uint _e99 = local_5;
        local_23 = _e99;
        uint _e101 = local_23;
        _group_0_binding_1_cs[_e101] = uint((other + 200));
    }
    if (true) {
        local_6 = uint((base + 5u));
        uint _e111 = local_6;
        local_24 = _e111;
        uint _e113 = local_24;
        _group_0_binding_1_cs[_e113] = uint((seed + 300));
    }
    int _e115 = state;
    if ((_e115 > 0)) {
        int _e118 = state;
        state = (_e118 + 7);
    }
    int _e121 = state;
    local_7 = uint((base + 6u));
    uint _e127 = local_7;
    _group_0_binding_1_cs[_e127] = uint(_e121);
    header = 50;
    if ((seed > 0)) {
        local_8 = uint((base + 7u));
        uint _e140 = local_8;
        local_25 = _e140;
        uint _e142 = local_25;
        _group_0_binding_1_cs[_e142] = uint((seed + 400));
    } else {
        header_1 = other;
        int _e145 = header_1;
        if ((_e145 > 0)) {
            int _e148 = header_1;
            local_9 = uint((base + 7u));
            uint _e156 = local_9;
            local_26 = _e156;
            uint _e158 = local_26;
            _group_0_binding_1_cs[_e158] = uint((_e148 + 500));
        } else {
            int _e160 = header_1;
            local_10 = uint((base + 7u));
            uint _e168 = local_10;
            local_27 = _e168;
            uint _e170 = local_27;
            _group_0_binding_1_cs[_e170] = uint((_e160 + 600));
        }
    }
    int _e172 = header;
    local_11 = uint((base + 8u));
    uint _e178 = local_11;
    _group_0_binding_1_cs[_e178] = uint(_e172);
    if (true) {
        {
            header_2 = 9;
            int _e183 = header_2;
            int _e184 = state;
            state = (_e184 + _e183);
        }
        local_12 = uint((base + 9u));
        uint _e193 = local_12;
        local_28 = _e193;
        uint _e195 = local_28;
        _group_0_binding_1_cs[_e195] = uint((seed + 20));
    }
    int _e197 = state;
    local_13 = uint((base + 10u));
    uint _e203 = local_13;
    _group_0_binding_1_cs[_e203] = uint(_e197);
    {
        pass = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e225 = pass;
                pass = (_e225 + 1);
            }
            loop_init = false;
            int _e207 = pass;
            if ((_e207 < 4)) {
            } else {
                break;
            }
            int _e210 = pass;
            selected = _e210;
            int _e212 = selected;
            if ((_e212 == 1)) {
                continue;
            }
            int _e215 = pass;
            selected_1 = _e215;
            int _e217 = selected_1;
            if ((_e217 == 3)) {
                break;
            }
            int _e220 = pass;
            int _e223 = state;
            state = (_e223 + (_e220 + 1));
        }
    }
    int _e228 = state;
    local_14 = uint((base + 11u));
    uint _e234 = local_14;
    _group_0_binding_1_cs[_e234] = uint(_e228);
    int _e236 = state;
    state = (_e236 + 1);
    if (true) {
        int _e240 = state;
        local_15 = uint((base + 12u));
        uint _e246 = local_15;
        local_29 = _e246;
        uint _e248 = local_29;
        _group_0_binding_1_cs[_e248] = uint(_e240);
    }
    read = 0;
    int _e252 = read;
    read = (_e252 + 1);
    local_16 = uint((lane + uint(_e252)));
    uint _e259 = local_16;
    int saved = _group_0_binding_0_cs[_e259];
    if ((saved > 0)) {
        int _e264 = read;
        local_17 = uint((base + 13u));
        uint _e272 = local_17;
        local_30 = _e272;
        uint _e274 = local_30;
        _group_0_binding_1_cs[_e274] = uint((_e264 + 100));
    } else {
        int _e276 = read;
        local_18 = uint((base + 13u));
        uint _e284 = local_18;
        local_31 = _e284;
        uint _e286 = local_31;
        _group_0_binding_1_cs[_e286] = uint((_e276 + 200));
    }
    int _e288 = state;
    local_19 = uint((base + 14u));
    uint _e294 = local_19;
    _group_0_binding_1_cs[_e294] = uint(_e288);
    int _e296 = index;
    local_20 = uint((base + 15u));
    uint _e302 = local_20;
    _group_0_binding_1_cs[_e302] = uint(_e296);
}

