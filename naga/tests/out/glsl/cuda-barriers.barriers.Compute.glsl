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
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 256u);
    values[lane] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = uint((base + lane));
    uint _e21 = local;
    local_5 = uint(_e21);
    uint _e24 = local_5;
    _group_0_binding_0_cs[_e24] = ((blockIdx.x * 1000u) + lane);
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e38 = values[(63u - lane)];
    local_1 = uint(((base + 64u) + lane));
    uint _e44 = local_1;
    local_6 = uint(_e44);
    uint _e47 = local_6;
    _group_0_binding_0_cs[_e47] = _e38;
    uint _e50 = (lane + 1u);
    local_3 = uint((base + (_e50 - 64u * (_e50 / 64u))));
    uint _e56 = local_3;
    local_7 = uint(_e56);
    uint _e59 = local_7;
    uint _e61 = _group_0_binding_0_cs[_e59];
    local_2 = uint(((base + 128u) + lane));
    uint _e67 = local_2;
    local_8 = uint(_e67);
    uint _e70 = local_8;
    _group_0_binding_0_cs[_e70] = _e61;
    uint _e73 = broadcast;
    local_4 = uint(((base + 192u) + lane));
    uint _e79 = local_4;
    local_9 = uint(_e79);
    uint _e82 = local_9;
    _group_0_binding_0_cs[_e82] = _e73;
}

