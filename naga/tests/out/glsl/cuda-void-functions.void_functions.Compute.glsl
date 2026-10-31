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
        local = uint(_e23);
        uint _e26 = local;
        local_6 = uint(_e26);
        uint _e29 = local_6;
        _group_0_binding_0_cs[_e29] = _e22;
        int _e32 = value;
        value = (_e32 + 1);
        int _e35 = next_value(_e32);
        consume(true, _e35, 2u, 0.5);
        int _e39 = value;
        uint _e40 = base;
        local_1 = uint((_e40 + 1u));
        uint _e45 = local_1;
        local_7 = uint(_e45);
        uint _e48 = local_7;
        _group_0_binding_0_cs[_e48] = _e39;
        int _e54 = value;
        value = (_e54 + 1);
        forward(((i - 2u * (i / 2u)) == 0u), _e54);
        int _e57 = value;
        uint _e58 = base;
        local_2 = uint((_e58 + 2u));
        uint _e63 = local_2;
        local_8 = uint(_e63);
        uint _e66 = local_8;
        _group_0_binding_0_cs[_e66] = _e57;
        iterations = 0;
        {
            int _e70 = value;
            value = (_e70 + 1);
            consume((0 != 0), _e70, uint(0), float(1u));
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e89 = value;
                    value = (_e89 + 1);
                    int _e92 = value;
                    consume(false, _e92, 0u, 1.0);
                }
                loop_init = false;
                int _e80 = iterations;
                if ((_e80 < 3)) {
                } else {
                    break;
                }
                int _e83 = iterations;
                iterations = (_e83 + 1);
                int _e86 = iterations;
                if ((_e86 == 1)) {
                    continue;
                }
            }
        }
        int _e96 = value;
        uint _e97 = base;
        local_3 = uint((_e97 + 3u));
        uint _e102 = local_3;
        local_9 = uint(_e102);
        uint _e105 = local_9;
        _group_0_binding_0_cs[_e105] = _e96;
        int _e107 = iterations;
        uint _e108 = base;
        local_4 = uint((_e108 + 4u));
        uint _e113 = local_4;
        local_10 = uint(_e113);
        uint _e116 = local_10;
        _group_0_binding_0_cs[_e116] = _e107;
        int _e118 = value;
        int _e119 = next_value(_e118);
        uint _e120 = base;
        local_5 = uint((_e120 + 5u));
        uint _e125 = local_5;
        local_11 = uint(_e125);
        uint _e128 = local_11;
        _group_0_binding_0_cs[_e128] = _e119;
    }
}

