#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };

shared uint shared_values[64];


int transform(float value, float multiplier, int offset) {
    return int(((value * multiplier) + float(offset)));
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    uint lane = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int signed_count = 0;
    uint local_3 = 0u;
    float fraction = 0.0;
    uint local_4 = 0u;
    int after_block = 0;
    uint local_5 = 0u;
    float coefficient = 0.0;
    uint local_6 = 0u;
    bool selected = false;
    uint local_7 = 0u;
    int total = 0;
    int current = 0;
    uint local_8 = 0u;
    float after_loop = 0.0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int local_11 = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    int local_14 = 0;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 10u);
        lane = threadIdx.x;
        uint _e18 = lane;
        shared_values[_e18] = (i + 10u);
        uint _e21 = lane;
        uint _e23 = shared_values[_e21];
        uint _e24 = base;
        local = uint(_e24);
        uint _e27 = local;
        local_12 = uint(_e27);
        uint _e30 = local_12;
        _group_0_binding_0_cs[_e30] = _e23;
        local_2 = uint(i);
        uint _e35 = local_2;
        local_13 = uint(_e35);
        uint _e38 = local_13;
        int _e41 = _group_0_binding_1_cs[_e38];
        local_14 = _e41;
        int _e43 = local_14;
        local_11 = _e43;
        int _e45 = local_11;
        int _e49 = transform(float(_e45), 2.0, 1);
        uint _e51 = base;
        local_1 = uint((_e51 + 1u));
        uint _e56 = local_1;
        local_15 = uint(_e56);
        uint _e59 = local_15;
        _group_0_binding_0_cs[_e59] = uint(_e49);
        signed_count = -(3);
        int _e64 = signed_count;
        uint _e66 = base;
        local_3 = uint((_e66 + 2u));
        uint _e71 = local_3;
        local_16 = uint(_e71);
        uint _e74 = local_16;
        _group_0_binding_0_cs[_e74] = uint(_e64);
        {
            fraction = 3.75;
            float _e78 = fraction;
            uint _e80 = base;
            local_4 = uint((_e80 + 3u));
            uint _e85 = local_4;
            local_17 = uint(_e85);
            uint _e88 = local_17;
            _group_0_binding_0_cs[_e88] = uint(_e78);
        }
        after_block = -(5);
        int _e93 = after_block;
        uint _e95 = base;
        local_5 = uint((_e95 + 4u));
        uint _e100 = local_5;
        local_18 = uint(_e100);
        uint _e103 = local_18;
        _group_0_binding_0_cs[_e103] = uint(_e93);
        coefficient = 1.25;
        float _e107 = coefficient;
        uint _e111 = base;
        local_6 = uint((_e111 + 5u));
        uint _e116 = local_6;
        local_19 = uint(_e116);
        uint _e119 = local_19;
        _group_0_binding_0_cs[_e119] = uint((_e107 * 4.0));
        selected = ((i - 2u * (i / 2u)) == 0u);
        bool _e126 = selected;
        uint _e128 = base;
        local_7 = uint((_e128 + 6u));
        uint _e133 = local_7;
        local_20 = uint(_e133);
        uint _e136 = local_20;
        _group_0_binding_0_cs[_e136] = uint(_e126);
        total = 0;
        {
            while(true) {
                int _e140 = total;
                if ((_e140 < 3)) {
                } else {
                    break;
                }
                int _e143 = total;
                current = _e143;
                int _e145 = current;
                total = (_e145 + 1);
            }
        }
        int _e148 = total;
        uint _e150 = base;
        local_8 = uint((_e150 + 7u));
        uint _e155 = local_8;
        local_21 = uint(_e155);
        uint _e158 = local_21;
        _group_0_binding_0_cs[_e158] = uint(_e148);
        after_loop = 1.5;
        float _e162 = after_loop;
        uint _e166 = base;
        local_9 = uint((_e166 + 8u));
        uint _e171 = local_9;
        local_22 = uint(_e171);
        uint _e174 = local_22;
        _group_0_binding_0_cs[_e174] = uint((_e162 * 2.0));
        uint _e178 = base;
        local_10 = uint((_e178 + 9u));
        uint _e183 = local_10;
        local_23 = uint(_e183);
        uint _e186 = local_23;
        _group_0_binding_0_cs[_e186] = uint(float(n_1));
    }
}

