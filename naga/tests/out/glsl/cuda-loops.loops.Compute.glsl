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
    uint local[2] = uint[2](0u, 0u);
    int n = 0;
    int sum = 0;
    int i = 0;
    int i_1 = 0;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    int _e10 = _group_0_binding_1_cs.value;
    n = _e10;
    sum = 0;
    {
        i = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e28 = i;
                i = (_e28 + 1);
            }
            loop_init = false;
            int _e16 = i;
            int _e17 = n;
            if ((_e16 < _e17)) {
            } else {
                break;
            }
            int _e19 = i;
            if ((_e19 == 2)) {
                continue;
            }
            int _e22 = i;
            if ((_e22 == 7)) {
                break;
            }
            int _e25 = sum;
            int _e26 = i;
            sum = (_e25 + _e26);
        }
    }
    i_1 = 0;
    while(true) {
        int _e33 = i_1;
        if ((_e33 < 3)) {
        } else {
            break;
        }
        {
            int _e36 = i_1;
            i_1 = (_e36 + 1);
            int _e39 = i_1;
            if ((_e39 == 2)) {
                continue;
            }
            int _e42 = sum;
            sum = (_e42 + 10);
        }
    }
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e51 = sum;
            if (!((_e51 < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e45 = sum;
        sum = (_e45 + 100);
        int _e48 = sum;
        if ((_e48 > 200)) {
            break;
        }
    }
    int _e55 = sum;
    uint _e58[2] = local;
    local_1 = _e58;
    local_2 = uint(threadIdx.x);
    uint _e63[2] = local_1;
    local_3 = _e63;
    uint _e64 = local_2;
    uint _e66 = local_3[1];
    local_3[1] = (_e66 + _e64);
    uint _e70 = local_3[0];
    local_4 = uint(_e70);
    uint _e74 = local_3[1];
    local_5 = uint(_e74);
    uint _e77 = local_5;
    _group_0_binding_0_cs[_e77] = _e55;
}

