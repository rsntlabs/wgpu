#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[64];

shared uint broadcast;


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        broadcast = 0u;
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
    uint base = (blockIdx.x * 256u);
    values[lane] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = uint((base + lane));
    uint _e21 = local;
    _group_0_binding_0_cs[_e21] = ((blockIdx.x * 1000u) + lane);
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e35 = values[(63u - lane)];
    local_1 = uint(((base + 64u) + lane));
    uint _e41 = local_1;
    _group_0_binding_0_cs[_e41] = _e35;
    uint _e44 = (lane + 1u);
    local_3 = uint((base + (_e44 - 64u * (_e44 / 64u))));
    uint _e50 = local_3;
    uint _e52 = _group_0_binding_0_cs[_e50];
    local_2 = uint(((base + 128u) + lane));
    uint _e58 = local_2;
    _group_0_binding_0_cs[_e58] = _e52;
    uint _e61 = broadcast;
    local_4 = uint(((base + 192u) + lane));
    uint _e67 = local_4;
    _group_0_binding_0_cs[_e67] = _e61;
}

