#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { int _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int value = 0;
    int local = 0;
    int local_1 = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    int index = 0;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    int turn = 0;
    uint local_9 = 0u;
    int Count = 0;
    int array[3] = int[3](0, 0, 0);
    uint local_10 = 0u;
    int step_ = 0;
    int previous = 0;
    int local_11 = 0;
    int local_12 = 0;
    int step_1 = 0;
    int previous_1 = 0;
    int local_13 = 0;
    int local_14 = 0;
    int local_15 = 0;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 8u));
    value = (int(lane) + 1);
    int _e10 = value;
    value = (_e10 + 1);
    int _e13 = value;
    value = (_e13 + 1);
    int _e16 = value;
    value = (_e16 + 1);
    int _e19 = value;
    _group_0_binding_0_cs[base] = _e19;
    bool choose = ((lane & 1u) == 0u);
    if (choose) {
        step_ = 0;
        previous = 0;
        step_ = 3;
        int _e32 = value;
        local_11 = _e32;
        int _e34 = local_11;
        previous = _e34;
        int _e36 = step_;
        int _e37 = value;
        local_12 = _e37;
        int _e39 = local_12;
        value = (_e39 + _e36);
        int _e41 = previous;
        local = _e41;
    } else {
        step_1 = 0;
        previous_1 = 0;
        step_1 = 7;
        int _e49 = value;
        local_13 = _e49;
        int _e51 = local_13;
        previous_1 = _e51;
        int _e53 = step_1;
        int _e54 = value;
        local_14 = _e54;
        int _e56 = local_14;
        value = (_e56 + _e53);
        int _e58 = previous_1;
        local_1 = _e58;
    }
    int _e60 = value;
    local_2 = uint((base + 1u));
    uint _e65 = local_2;
    _group_0_binding_0_cs[_e65] = _e60;
    int _e67 = value;
    value = (_e67 + 1);
    int _e70 = value;
    value = (_e70 + 1);
    int _e73 = value;
    local_3 = uint((base + 2u));
    uint _e78 = local_3;
    _group_0_binding_0_cs[_e78] = _e73;
    index = 0;
    int _e82 = index;
    index = (_e82 + 1);
    local_4 = uint(_e82);
    int _e87 = index;
    index = (_e87 + 1);
    local_5 = uint(_e87);
    int _e92 = index;
    local_6 = uint((base + 3u));
    uint _e97 = local_6;
    _group_0_binding_0_cs[_e97] = _e92;
    int _e103 = _group_0_binding_1_cs[uint(0)];
    local_7 = uint((base + 4u));
    uint _e108 = local_7;
    _group_0_binding_0_cs[_e108] = _e103;
    local_15 = 0;
    int _e112 = value;
    local_15 = _e112;
    int _e114 = local_15;
    value = (_e114 + 1);
    int _e117 = value;
    local_8 = uint((base + 5u));
    uint _e122 = local_8;
    _group_0_binding_0_cs[_e122] = _e117;
    {
        turn = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e132 = turn;
                turn = (_e132 + 1);
            }
            loop_init = false;
            int _e126 = turn;
            if ((_e126 < 2)) {
            } else {
                break;
            }
            int _e129 = value;
            value = (_e129 + 1);
        }
    }
    int _e135 = value;
    local_9 = uint((base + 6u));
    uint _e140 = local_9;
    _group_0_binding_0_cs[_e140] = _e135;
    int runtime = _group_0_binding_1_cs[uint(1)];
    Count = 3;
    array = int[3](0, 0, 0);
    int _e152 = array[2];
    local_10 = uint((base + 7u));
    uint _e157 = local_10;
    _group_0_binding_0_cs[_e157] = _e152;
}

