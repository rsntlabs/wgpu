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
    uint local[2] = uint[2](0u, 0u);
    uint lane = 0u;
    uint base = 0u;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    uint local_27 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 256u);
    uint _e18 = lane;
    uint _e22 = lane;
    values[_e22] = (((blockIdx.x * 2000u) + _e18) + 7u);
    uint _e28 = lane;
    uint _e32[2] = local;
    local_1 = _e32;
    uint _e33 = base;
    uint _e34 = lane;
    local_2 = uint((_e33 + _e34));
    uint _e39[2] = local_1;
    local_12 = _e39;
    uint _e40 = local_2;
    uint _e42 = local_12[1];
    local_12[1] = (_e42 + _e40);
    uint _e46 = local_12[0];
    local_13 = uint(_e46);
    uint _e50 = local_12[1];
    local_14 = uint(_e50);
    uint _e53 = local_14;
    _group_0_binding_0_cs[_e53] = ((blockIdx.x * 1000u) + _e28);
    uint _e55 = lane;
    if ((_e55 == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e64 = lane;
    uint _e68 = values[(63u - _e64)];
    uint _e70[2] = local;
    local_3 = _e70;
    uint _e71 = base;
    uint _e74 = lane;
    local_4 = uint(((_e71 + 64u) + _e74));
    uint _e79[2] = local_3;
    local_15 = _e79;
    uint _e80 = local_4;
    uint _e82 = local_15[1];
    local_15[1] = (_e82 + _e80);
    uint _e86 = local_15[0];
    local_16 = uint(_e86);
    uint _e90 = local_15[1];
    local_17 = uint(_e90);
    uint _e93 = local_17;
    _group_0_binding_0_cs[_e93] = _e68;
    uint _e96[2] = local;
    local_7 = _e96;
    uint _e97 = lane;
    uint _e99 = (_e97 + 1u);
    uint _e102 = base;
    local_8 = uint((_e102 + (_e99 - 64u * (_e99 / 64u))));
    uint _e107[2] = local_7;
    local_18 = _e107;
    uint _e108 = local_8;
    uint _e110 = local_18[1];
    local_18[1] = (_e110 + _e108);
    uint _e114 = local_18[0];
    local_19 = uint(_e114);
    uint _e118 = local_18[1];
    local_20 = uint(_e118);
    uint _e122 = local_20;
    uint _e124 = _group_0_binding_0_cs[_e122];
    local_21 = _e124;
    uint _e125 = local_21;
    local_11 = _e125;
    uint _e127 = local_11;
    uint _e129[2] = local;
    local_5 = _e129;
    uint _e130 = base;
    uint _e133 = lane;
    local_6 = uint(((_e130 + 128u) + _e133));
    uint _e138[2] = local_5;
    local_22 = _e138;
    uint _e139 = local_6;
    uint _e141 = local_22[1];
    local_22[1] = (_e141 + _e139);
    uint _e145 = local_22[0];
    local_23 = uint(_e145);
    uint _e149 = local_22[1];
    local_24 = uint(_e149);
    uint _e152 = local_24;
    _group_0_binding_0_cs[_e152] = _e127;
    uint _e155 = broadcast;
    uint _e157[2] = local;
    local_9 = _e157;
    uint _e158 = base;
    uint _e161 = lane;
    local_10 = uint(((_e158 + 192u) + _e161));
    uint _e166[2] = local_9;
    local_25 = _e166;
    uint _e167 = local_10;
    uint _e169 = local_25[1];
    local_25[1] = (_e169 + _e167);
    uint _e173 = local_25[0];
    local_26 = uint(_e173);
    uint _e177 = local_25[1];
    local_27 = uint(_e177);
    uint _e180 = local_27;
    _group_0_binding_0_cs[_e180] = _e155;
}

