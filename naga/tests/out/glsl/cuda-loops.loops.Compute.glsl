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
    int sum = 0;
    int i = 0;
    int i_1 = 0;
    uint local = 0u;
    uint local_1 = 0u;
    int n_1 = _group_0_binding_1_cs.value;
    sum = 0;
    {
        i = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e19 = i;
                i = (_e19 + 1);
            }
            loop_init = false;
            int _e8 = i;
            if ((_e8 < n_1)) {
            } else {
                break;
            }
            int _e10 = i;
            if ((_e10 == 2)) {
                continue;
            }
            int _e13 = i;
            if ((_e13 == 7)) {
                break;
            }
            int _e16 = sum;
            int _e17 = i;
            sum = (_e16 + _e17);
        }
    }
    i_1 = 0;
    while(true) {
        int _e24 = i_1;
        if ((_e24 < 3)) {
        } else {
            break;
        }
        {
            int _e27 = i_1;
            i_1 = (_e27 + 1);
            int _e30 = i_1;
            if ((_e30 == 2)) {
                continue;
            }
            int _e33 = sum;
            sum = (_e33 + 10);
        }
    }
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e42 = sum;
            if (!((_e42 < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e36 = sum;
        sum = (_e36 + 100);
        int _e39 = sum;
        if ((_e39 > 200)) {
            break;
        }
    }
    int _e46 = sum;
    local = uint(threadIdx.x);
    uint _e50 = local;
    local_1 = uint(_e50);
    uint _e53 = local_1;
    _group_0_binding_0_cs[_e53] = _e46;
}

