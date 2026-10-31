#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[64];

shared int signed_value;

shared float float_value;


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        signed_value = 0;
        float_value = 0.0;
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e15 = values[lane];
    local = uint((base + lane));
    uint _e19 = local;
    _group_0_binding_0_cs[_e19] = _e15;
    if ((lane == 0u)) {
        signed_value = -(7);
        float_value = 3.5;
        int _e29 = signed_value;
        local_1 = uint((base + 64u));
        uint _e37 = local_1;
        local_3 = _e37;
        uint _e39 = local_3;
        _group_0_binding_0_cs[_e39] = uint((_e29 + 10));
        float _e41 = float_value;
        local_2 = uint((base + 65u));
        uint _e49 = local_2;
        local_4 = _e49;
        uint _e51 = local_4;
        _group_0_binding_0_cs[_e51] = uint((_e41 * 2.0));
    }
}

