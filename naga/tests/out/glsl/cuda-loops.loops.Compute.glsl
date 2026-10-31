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
    uint out_[2] = uint[2](0u, 0u);
    int sum = 0;
    int i = 0;
    int i_1 = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    int n_1 = _group_0_binding_1_cs.value;
    sum = 0;
    {
        i = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e25 = i;
                i = (_e25 + 1);
            }
            loop_init = false;
            int _e14 = i;
            if ((_e14 < n_1)) {
            } else {
                break;
            }
            int _e16 = i;
            if ((_e16 == 2)) {
                continue;
            }
            int _e19 = i;
            if ((_e19 == 7)) {
                break;
            }
            int _e22 = sum;
            int _e23 = i;
            sum = (_e22 + _e23);
        }
    }
    i_1 = 0;
    while(true) {
        int _e30 = i_1;
        if ((_e30 < 3)) {
        } else {
            break;
        }
        {
            int _e33 = i_1;
            i_1 = (_e33 + 1);
            int _e36 = i_1;
            if ((_e36 == 2)) {
                continue;
            }
            int _e39 = sum;
            sum = (_e39 + 10);
        }
    }
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e48 = sum;
            if (!((_e48 < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e42 = sum;
        sum = (_e42 + 100);
        int _e45 = sum;
        if ((_e45 > 200)) {
            break;
        }
    }
    int _e52 = sum;
    uint _e54[2] = out_;
    local = _e54;
    local_1 = uint(threadIdx.x);
    uint _e59[2] = local;
    local_2 = _e59;
    uint _e61 = local_1;
    uint _e63 = local_2[1];
    local_2[1] = (_e63 + _e61);
    uint _e67 = local_2[0];
    local_3 = uint(_e67);
    uint _e71 = local_2[1];
    local_4 = uint(_e71);
    uint _e74 = local_4;
    _group_0_binding_0_cs[_e74] = _e52;
}

