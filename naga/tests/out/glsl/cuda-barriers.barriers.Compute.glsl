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
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    local = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 256u);
    uint _e13 = lane;
    uint _e17 = lane;
    values[_e17] = (((blockIdx.x * 2000u) + _e13) + 7u);
    uint _e23 = lane;
    uint _e25 = local;
    local_1 = _e25;
    uint _e27 = local_1;
    local_2 = uint(_e27);
    uint _e30 = base;
    uint _e31 = lane;
    local_3 = uint((_e30 + _e31));
    uint _e36 = local_2;
    uint _e37 = local_3;
    local_16 = uint((_e36 + _e37));
    uint _e41 = local_16;
    _group_0_binding_0_cs[_e41] = ((blockIdx.x * 1000u) + _e23);
    uint _e43 = lane;
    if ((_e43 == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e52 = lane;
    uint _e56 = values[(63u - _e52)];
    uint _e57 = local;
    local_4 = _e57;
    uint _e59 = local_4;
    local_5 = uint(_e59);
    uint _e62 = base;
    uint _e65 = lane;
    local_6 = uint(((_e62 + 64u) + _e65));
    uint _e69 = local_5;
    uint _e70 = local_6;
    local_17 = uint((_e69 + _e70));
    uint _e74 = local_17;
    _group_0_binding_0_cs[_e74] = _e56;
    uint _e76 = local;
    local_10 = _e76;
    uint _e78 = local_10;
    local_11 = uint(_e78);
    uint _e81 = lane;
    uint _e83 = (_e81 + 1u);
    uint _e86 = base;
    local_12 = uint((_e86 + (_e83 - 64u * (_e83 / 64u))));
    uint _e90 = local_11;
    uint _e91 = local_12;
    local_18 = uint((_e90 + _e91));
    uint _e96 = local_18;
    uint _e98 = _group_0_binding_0_cs[_e96];
    local_19 = _e98;
    uint _e99 = local_19;
    uint _e100 = local;
    local_7 = _e100;
    uint _e102 = local_7;
    local_8 = uint(_e102);
    uint _e105 = base;
    uint _e108 = lane;
    local_9 = uint(((_e105 + 128u) + _e108));
    uint _e112 = local_8;
    uint _e113 = local_9;
    local_20 = uint((_e112 + _e113));
    uint _e117 = local_20;
    _group_0_binding_0_cs[_e117] = _e99;
    uint _e120 = broadcast;
    uint _e121 = local;
    local_13 = _e121;
    uint _e123 = local_13;
    local_14 = uint(_e123);
    uint _e126 = base;
    uint _e129 = lane;
    local_15 = uint(((_e126 + 192u) + _e129));
    uint _e133 = local_14;
    uint _e134 = local_15;
    local_21 = uint((_e133 + _e134));
    uint _e138 = local_21;
    _group_0_binding_0_cs[_e138] = _e120;
}

