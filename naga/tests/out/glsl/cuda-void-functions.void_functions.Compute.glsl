#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };


int next_value(int value_1) {
    return (value_1 + 1);
}

void consume(bool stop, int value_2, uint count, float scale) {
    int value_3 = 0;
    value_3 = value_2;
    int _e5 = value_3;
    value_3 = int((uint(_e5) + count));
    if (stop) {
        return;
    }
    int _e9 = value_3;
    value_3 = int((float(_e9) * scale));
    return;
}

void forward(bool stop_1, int value_4) {
    int _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5);
    return;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int iterations = 0;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint n_1 = _group_0_binding_1_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 6u);
        value = 2;
        int _e16 = value;
        value = (_e16 + 1);
        consume(false, _e16, 1u, 1.5);
        int _e22 = value;
        uint _e23 = base;
        local = _e23;
        uint _e25 = local;
        local_6 = _e25;
        uint _e27 = local_6;
        _group_0_binding_0_cs[_e27] = _e22;
        int _e30 = value;
        value = (_e30 + 1);
        int _e33 = next_value(_e30);
        consume(true, _e33, 2u, 0.5);
        int _e37 = value;
        uint _e38 = base;
        local_1 = uint((_e38 + 1u));
        uint _e43 = local_1;
        local_7 = _e43;
        uint _e45 = local_7;
        _group_0_binding_0_cs[_e45] = _e37;
        int _e51 = value;
        value = (_e51 + 1);
        forward(((i - 2u * (i / 2u)) == 0u), _e51);
        int _e54 = value;
        uint _e55 = base;
        local_2 = uint((_e55 + 2u));
        uint _e60 = local_2;
        local_8 = _e60;
        uint _e62 = local_8;
        _group_0_binding_0_cs[_e62] = _e54;
        iterations = 0;
        {
            int _e69 = value;
            value = (_e69 + 1);
            consume((0 != 0), _e69, uint(0), float(1u));
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e85 = value;
                    value = (_e85 + 1);
                    int _e88 = value;
                    consume(false, _e88, 0u, 1.0);
                }
                loop_init = false;
                int _e76 = iterations;
                if ((_e76 < 3)) {
                } else {
                    break;
                }
                int _e79 = iterations;
                iterations = (_e79 + 1);
                int _e82 = iterations;
                if ((_e82 == 1)) {
                    continue;
                }
            }
        }
        int _e92 = value;
        uint _e93 = base;
        local_3 = uint((_e93 + 3u));
        uint _e98 = local_3;
        local_9 = _e98;
        uint _e100 = local_9;
        _group_0_binding_0_cs[_e100] = _e92;
        int _e102 = iterations;
        uint _e103 = base;
        local_4 = uint((_e103 + 4u));
        uint _e108 = local_4;
        local_10 = _e108;
        uint _e110 = local_10;
        _group_0_binding_0_cs[_e110] = _e102;
        int _e112 = value;
        int _e113 = next_value(_e112);
        uint _e114 = base;
        local_5 = uint((_e114 + 5u));
        uint _e119 = local_5;
        local_11 = _e119;
        uint _e121 = local_11;
        _group_0_binding_0_cs[_e121] = _e113;
    }
}

