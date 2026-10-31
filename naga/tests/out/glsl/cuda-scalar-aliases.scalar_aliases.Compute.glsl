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
        local = _e24;
        uint _e26 = local;
        local_12 = _e26;
        uint _e28 = local_12;
        _group_0_binding_0_cs[_e28] = _e23;
        local_2 = i;
        uint _e32 = local_2;
        local_13 = _e32;
        uint _e34 = local_13;
        int _e37 = _group_0_binding_1_cs[_e34];
        local_14 = _e37;
        int _e39 = local_14;
        local_11 = _e39;
        int _e41 = local_11;
        int _e45 = transform(float(_e41), 2.0, 1);
        uint _e47 = base;
        local_1 = uint((_e47 + 1u));
        uint _e52 = local_1;
        local_15 = _e52;
        uint _e54 = local_15;
        _group_0_binding_0_cs[_e54] = uint(_e45);
        signed_count = -(3);
        int _e59 = signed_count;
        uint _e61 = base;
        local_3 = uint((_e61 + 2u));
        uint _e66 = local_3;
        local_16 = _e66;
        uint _e68 = local_16;
        _group_0_binding_0_cs[_e68] = uint(_e59);
        {
            fraction = 3.75;
            float _e72 = fraction;
            uint _e74 = base;
            local_4 = uint((_e74 + 3u));
            uint _e79 = local_4;
            local_17 = _e79;
            uint _e81 = local_17;
            _group_0_binding_0_cs[_e81] = uint(_e72);
        }
        after_block = -(5);
        int _e86 = after_block;
        uint _e88 = base;
        local_5 = uint((_e88 + 4u));
        uint _e93 = local_5;
        local_18 = _e93;
        uint _e95 = local_18;
        _group_0_binding_0_cs[_e95] = uint(_e86);
        coefficient = 1.25;
        float _e99 = coefficient;
        uint _e103 = base;
        local_6 = uint((_e103 + 5u));
        uint _e108 = local_6;
        local_19 = _e108;
        uint _e110 = local_19;
        _group_0_binding_0_cs[_e110] = uint((_e99 * 4.0));
        selected = ((i - 2u * (i / 2u)) == 0u);
        bool _e117 = selected;
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e124 = local_7;
        local_20 = _e124;
        uint _e126 = local_20;
        _group_0_binding_0_cs[_e126] = uint(_e117);
        total = 0;
        {
            while(true) {
                int _e130 = total;
                if ((_e130 < 3)) {
                } else {
                    break;
                }
                int _e133 = total;
                current = _e133;
                int _e135 = current;
                total = (_e135 + 1);
            }
        }
        int _e138 = total;
        uint _e140 = base;
        local_8 = uint((_e140 + 7u));
        uint _e145 = local_8;
        local_21 = _e145;
        uint _e147 = local_21;
        _group_0_binding_0_cs[_e147] = uint(_e138);
        after_loop = 1.5;
        float _e151 = after_loop;
        uint _e155 = base;
        local_9 = uint((_e155 + 8u));
        uint _e160 = local_9;
        local_22 = _e160;
        uint _e162 = local_22;
        _group_0_binding_0_cs[_e162] = uint((_e151 * 2.0));
        uint _e166 = base;
        local_10 = uint((_e166 + 9u));
        uint _e171 = local_10;
        local_23 = _e171;
        uint _e173 = local_23;
        _group_0_binding_0_cs[_e173] = uint(float(n_1));
    }
}

