#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    int value;
};
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_3_block_1Compute { type_3 _group_0_binding_1_cs; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    int n = 0;
    int sum = 0;
    int i = 0;
    int i_1 = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    local = 0u;
    int _e5 = _group_0_binding_1_cs.value;
    n = _e5;
    sum = 0;
    {
        i = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e23 = i;
                i = (_e23 + 1);
            }
            loop_init = false;
            int _e11 = i;
            int _e12 = n;
            if ((_e11 < _e12)) {
            } else {
                break;
            }
            int _e14 = i;
            if ((_e14 == 2)) {
                continue;
            }
            int _e17 = i;
            if ((_e17 == 7)) {
                break;
            }
            int _e20 = sum;
            int _e21 = i;
            sum = (_e20 + _e21);
        }
    }
    i_1 = 0;
    while(true) {
        int _e28 = i_1;
        if ((_e28 < 3)) {
        } else {
            break;
        }
        {
            int _e31 = i_1;
            i_1 = (_e31 + 1);
            int _e34 = i_1;
            if ((_e34 == 2)) {
                continue;
            }
            int _e37 = sum;
            sum = (_e37 + 10);
        }
    }
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e46 = sum;
            if (!((_e46 < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e40 = sum;
        sum = (_e40 + 100);
        int _e43 = sum;
        if ((_e43 > 200)) {
            break;
        }
    }
    int _e50 = sum;
    uint _e51 = local;
    local_1 = _e51;
    uint _e53 = local_1;
    local_2 = uint(_e53);
    local_3 = uint(threadIdx.x);
    uint _e60 = local_2;
    uint _e61 = local_3;
    local_4 = uint((_e60 + _e61));
    uint _e65 = local_4;
    _group_0_binding_0_cs[_e65] = _e50;
}

