#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int state = 0;
    uint local = 0u;
    int bias = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    int key = 0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    int key_1 = 0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int One = 0;
    uint local_11 = 0u;
    int pass = 0;
    int selected = 0;
    uint local_12 = 0u;
    int counter = 0;
    uint local_13 = 0u;
    uint local_14 = 0u;
    int inner = 0;
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
    uint base = (4u + (lane * 16u));
    int seed = _group_0_binding_0_cs[lane];
    state = (int(lane) + 1);
    switch(seed) {
        case 0: {
            int _e13 = state;
            state = (_e13 + 1);
            break;
        }
        default: {
            int _e16 = state;
            state = (_e16 + 2);
            break;
        }
    }
    int _e19 = state;
    _group_0_binding_1_cs[base] = uint(_e19);
    int _e23 = state;
    state = (_e23 + 1);
    switch(seed) {
        case 0: {
            int _e26 = state;
            state = (_e26 + 10);
            break;
        }
        case 1: {
            int _e29 = state;
            state = (_e29 + 20);
            int _e32 = state;
            state = (_e32 + 30);
            break;
        }
        case 2: {
            int _e35 = state;
            state = (_e35 + 30);
            break;
        }
        default: {
            int _e38 = state;
            state = (_e38 + 40);
            break;
        }
    }
    int _e41 = state;
    local = uint((base + 1u));
    uint _e47 = local;
    _group_0_binding_1_cs[_e47] = uint(_e41);
    bias = 5;
    switch(seed) {
        case 0: {
            int _e51 = bias;
            local_1 = uint((base + 2u));
            uint _e57 = local_1;
            local_18 = _e57;
            uint _e59 = local_18;
            _group_0_binding_1_cs[_e59] = uint(_e51);
            break;
        }
        case 1: {
            int _e61 = bias;
            local_2 = uint((base + 2u));
            uint _e68 = local_2;
            local_19 = _e68;
            uint _e70 = local_19;
            _group_0_binding_1_cs[_e70] = uint((_e61 + seed));
            break;
        }
        default: {
            int _e72 = bias;
            local_3 = uint((base + 2u));
            uint _e79 = local_3;
            local_20 = _e79;
            uint _e81 = local_20;
            _group_0_binding_1_cs[_e81] = uint((_e72 + seed));
            break;
        }
    }
    int key_2 = (seed + 1);
    switch(key_2) {
        case 1: {
            int _e85 = state;
            state = (_e85 + 3);
            break;
        }
        default: {
            int _e88 = state;
            state = (_e88 + 4);
            break;
        }
    }
    int _e91 = state;
    local_4 = uint((base + 3u));
    uint _e97 = local_4;
    _group_0_binding_1_cs[_e97] = uint(_e91);
    int _e99 = state;
    do {
        int _e100 = state;
        state = (_e100 + 7);
    } while(false);
    int _e103 = state;
    local_5 = uint((base + 4u));
    uint _e109 = local_5;
    _group_0_binding_1_cs[_e109] = uint(_e103);
    key = 99;
    switch(seed) {
        case 0: {
            local_6 = uint((base + 5u));
            uint _e120 = local_6;
            local_21 = _e120;
            uint _e122 = local_21;
            _group_0_binding_1_cs[_e122] = uint((seed + 10));
            break;
        }
        default: {
            local_7 = uint((base + 5u));
            uint _e131 = local_7;
            local_22 = _e131;
            uint _e133 = local_22;
            _group_0_binding_1_cs[_e133] = uint((seed + 20));
            break;
        }
    }
    int _e135 = key;
    local_8 = uint((base + 6u));
    uint _e141 = local_8;
    _group_0_binding_1_cs[_e141] = uint(_e135);
    do {
        {
            {
                key_1 = 9;
                int _e145 = key_1;
                int _e146 = state;
                state = (_e146 + _e145);
            }
            local_9 = uint((base + 7u));
            uint _e155 = local_9;
            local_23 = _e155;
            uint _e157 = local_23;
            _group_0_binding_1_cs[_e157] = uint((seed + 30));
        }
    } while(false);
    int _e159 = state;
    local_10 = uint((base + 8u));
    uint _e165 = local_10;
    _group_0_binding_1_cs[_e165] = uint(_e159);
    One = 1;
    switch(seed) {
        case 1: {
            int _e169 = state;
            state = (_e169 + 1);
            break;
        }
        default: {
            int _e172 = state;
            state = (_e172 + 2);
            break;
        }
    }
    int _e175 = state;
    local_11 = uint((base + 9u));
    uint _e181 = local_11;
    _group_0_binding_1_cs[_e181] = uint(_e175);
    {
        pass = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e200 = pass;
                pass = (_e200 + 1);
            }
            loop_init = false;
            int _e185 = pass;
            if ((_e185 < 4)) {
            } else {
                break;
            }
            int _e188 = pass;
            selected = _e188;
            int _e190 = selected;
            switch(_e190) {
                case 1: {
                    continue;
                }
                case 2: {
                    int _e191 = state;
                    state = (_e191 + 10);
                    break;
                }
                default: {
                    int _e194 = state;
                    state = (_e194 + 1);
                    break;
                }
            }
            int _e197 = state;
            state = (_e197 + 2);
        }
    }
    int _e203 = state;
    local_12 = uint((base + 10u));
    uint _e209 = local_12;
    _group_0_binding_1_cs[_e209] = uint(_e203);
    counter = 0;
    int _e213 = counter;
    counter = (_e213 + 1);
    int _e216 = state;
    state = (_e216 + 2);
    do {
        int _e219 = state;
        state = (_e219 + 3);
    } while(false);
    int _e222 = counter;
    local_13 = uint((base + 11u));
    uint _e228 = local_13;
    _group_0_binding_1_cs[_e228] = uint(_e222);
    int _e230 = state;
    local_14 = uint((base + 12u));
    uint _e236 = local_14;
    _group_0_binding_1_cs[_e236] = uint(_e230);
    switch(seed) {
        case 0: {
            inner = (seed + 1);
            int _e241 = inner;
            do {
                int _e242 = inner;
                int _e243 = state;
                state = (_e243 + _e242);
            } while(false);
            break;
        }
        default: {
            int _e245 = state;
            state = (_e245 + 4);
            break;
        }
    }
    int _e248 = state;
    local_15 = uint((base + 13u));
    uint _e254 = local_15;
    _group_0_binding_1_cs[_e254] = uint(_e248);
    local_16 = uint((base + 14u));
    uint _e261 = local_16;
    _group_0_binding_1_cs[_e261] = uint(seed);
    int _e263 = counter;
    local_17 = uint((base + 15u));
    uint _e269 = local_17;
    _group_0_binding_1_cs[_e269] = uint(_e263);
}

