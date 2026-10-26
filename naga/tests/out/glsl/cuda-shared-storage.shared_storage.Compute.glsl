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
    uint lane = 0u;
    uint base = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    local = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 128u);
    uint _e13 = lane;
    uint _e17 = lane;
    values[_e17] = (((blockIdx.x * 1000u) + _e13) + 10u);
    uint _e20 = lane;
    uint _e22 = values[_e20];
    uint _e23 = local;
    local_1 = _e23;
    uint _e25 = local_1;
    local_2 = uint(_e25);
    uint _e28 = base;
    uint _e29 = lane;
    local_3 = uint((_e28 + _e29));
    uint _e34 = local_2;
    uint _e35 = local_3;
    local_10 = uint((_e34 + _e35));
    uint _e39 = local_10;
    _group_0_binding_0_cs[_e39] = _e22;
    uint _e41 = lane;
    if ((_e41 == 0u)) {
        signed_value = -(7);
        float_value = 3.5;
        int _e49 = signed_value;
        uint _e52 = local;
        local_4 = _e52;
        uint _e54 = local_4;
        local_5 = uint(_e54);
        uint _e57 = base;
        local_6 = uint((_e57 + 64u));
        uint _e63 = local_5;
        uint _e64 = local_6;
        local_11 = uint((_e63 + _e64));
        uint _e68 = local_11;
        _group_0_binding_0_cs[_e68] = uint((_e49 + 10));
        float _e70 = float_value;
        uint _e73 = local;
        local_7 = _e73;
        uint _e75 = local_7;
        local_8 = uint(_e75);
        uint _e78 = base;
        local_9 = uint((_e78 + 65u));
        uint _e84 = local_8;
        uint _e85 = local_9;
        local_12 = uint((_e84 + _e85));
        uint _e89 = local_12;
        _group_0_binding_0_cs[_e89] = uint((_e70 * 2.0));
    }
}

