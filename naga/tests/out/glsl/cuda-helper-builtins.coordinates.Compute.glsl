#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    float value;
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_7 {
    uint value;
};
uvec3 threadIdx_1 = uvec3(0u);

uvec3 blockIdx_1 = uvec3(0u);

uvec3 gridDim_1 = uvec3(0u);

layout(std430) readonly buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };

layout(std430) readonly buffer type_6_block_2Compute { float3_ _group_0_binding_2_cs[]; };

layout(std140) uniform type_7_block_3Compute { type_7 _group_0_binding_3_cs; };

layout(std430) buffer type_8_block_4Compute { uint _group_0_binding_4_cs[]; };


uint thread_component(uint axis) {
    if ((axis == 0u)) {
        uvec3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if ((axis == 1u)) {
        uvec3 _e9 = threadIdx_1;
        return _e9.y;
    }
    uvec3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(uint axis_1) {
    if ((axis_1 == 0u)) {
        uvec3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if ((axis_1 == 1u)) {
        uvec3 _e9 = blockIdx_1;
        return _e9.y;
    }
    uvec3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(uint axis_2) {
    if ((axis_2 == 0u)) {
        return 1u;
    }
    if ((axis_2 == 1u)) {
        return 1u;
    }
    return 1u;
}

uint grid_component(uint axis_3) {
    if ((axis_3 == 0u)) {
        uvec3 _e4 = gridDim_1;
        return _e4.x;
    }
    if ((axis_3 == 1u)) {
        uvec3 _e9 = gridDim_1;
        return _e9.y;
    }
    uvec3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(uint axis_4) {
    uint _e1 = thread_component(axis_4);
    return _e1;
}

float component_1(float offset) {
    uvec3 _e2 = blockIdx_1;
    return (float(_e2.x) + offset);
}

uint global_x() {
    uint _e1 = group_component(0u);
    uint _e3 = shape_component(0u);
    uint _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

uint kind(uint value) {
    return 11u;
}

void observe() {
    uvec3 _e1 = gridDim_1;
    if ((_e1.z != 0u)) {
        return;
    } else {
        return;
    }
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 gridDim = gl_NumWorkGroups;
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
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    float scale_1 = _group_0_binding_1_cs.value;
    uint limit_1 = _group_0_binding_3_cs.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    uint _e12 = global_x();
    if ((_e12 >= limit_1)) {
        return;
    }
    observe();
    uint _e15 = thread_component(0u);
    local = uint(0);
    uint _e19 = local;
    _group_0_binding_4_cs[_e19] = _e15;
    uint _e23 = thread_component(1u);
    local_1 = uint(1);
    uint _e27 = local_1;
    _group_0_binding_4_cs[_e27] = _e23;
    uint _e30 = thread_component(2u);
    local_2 = uint(2);
    uint _e34 = local_2;
    _group_0_binding_4_cs[_e34] = _e30;
    uint _e37 = group_component(0u);
    local_3 = uint(3);
    uint _e41 = local_3;
    _group_0_binding_4_cs[_e41] = _e37;
    uint _e44 = group_component(1u);
    local_4 = uint(4);
    uint _e48 = local_4;
    _group_0_binding_4_cs[_e48] = _e44;
    uint _e51 = group_component(2u);
    local_5 = uint(5);
    uint _e55 = local_5;
    _group_0_binding_4_cs[_e55] = _e51;
    uint _e58 = shape_component(0u);
    local_6 = uint(6);
    uint _e62 = local_6;
    _group_0_binding_4_cs[_e62] = _e58;
    uint _e65 = shape_component(1u);
    local_7 = uint(7);
    uint _e69 = local_7;
    _group_0_binding_4_cs[_e69] = _e65;
    uint _e72 = shape_component(2u);
    local_8 = uint(8);
    uint _e76 = local_8;
    _group_0_binding_4_cs[_e76] = _e72;
    uint _e79 = grid_component(0u);
    local_9 = uint(9);
    uint _e83 = local_9;
    _group_0_binding_4_cs[_e83] = _e79;
    uint _e86 = grid_component(1u);
    local_10 = uint(10);
    uint _e90 = local_10;
    _group_0_binding_4_cs[_e90] = _e86;
    uint _e93 = grid_component(2u);
    local_11 = uint(11);
    uint _e97 = local_11;
    _group_0_binding_4_cs[_e97] = _e93;
    uint _e99 = global_x();
    local_12 = uint(12);
    uint _e103 = local_12;
    _group_0_binding_4_cs[_e103] = _e99;
    uint _e106 = component(0u);
    local_13 = uint(13);
    uint _e110 = local_13;
    _group_0_binding_4_cs[_e110] = _e106;
    float _e113 = component_1(2.5);
    local_14 = uint(14);
    uint _e118 = local_14;
    _group_0_binding_4_cs[_e118] = floatBitsToUint(_e113);
    local_15 = uint(15);
    uint _e124 = local_15;
    _group_0_binding_4_cs[_e124] = threadIdx.x;
    local_16 = uint(16);
    uint _e130 = local_16;
    _group_0_binding_4_cs[_e130] = blockIdx.y;
    local_17 = uint(17);
    uint _e136 = local_17;
    _group_0_binding_4_cs[_e136] = gridDim.z;
    local_18 = uint(18);
    uint _e141 = local_18;
    _group_0_binding_4_cs[_e141] = 1u;
    local_20 = uint(0);
    uint _e147 = local_20;
    int _e150 = _group_0_binding_0_cs[_e147];
    local_19 = uint(19);
    uint _e155 = local_19;
    _group_0_binding_4_cs[_e155] = uint(_e150);
    local_21 = uint(20);
    uint _e161 = local_21;
    _group_0_binding_4_cs[_e161] = floatBitsToUint(scale_1);
    local_23 = uint(0);
    uint _e166 = local_23;
    float _e170 = _group_0_binding_2_cs[_e166].x;
    local_22 = uint(21);
    uint _e175 = local_22;
    _group_0_binding_4_cs[_e175] = floatBitsToUint(_e170);
    local_25 = uint(0);
    uint _e180 = local_25;
    float _e183 = _group_0_binding_2_cs[_e180].y;
    local_24 = uint(22);
    uint _e188 = local_24;
    _group_0_binding_4_cs[_e188] = floatBitsToUint(_e183);
    local_27 = uint(0);
    uint _e193 = local_27;
    float _e196 = _group_0_binding_2_cs[_e193].z;
    local_26 = uint(23);
    uint _e201 = local_26;
    _group_0_binding_4_cs[_e201] = floatBitsToUint(_e196);
    local_28 = uint(24);
    uint _e206 = local_28;
    _group_0_binding_4_cs[_e206] = limit_1;
    uint _e209 = thread_component(0u);
    uint _e211 = group_component(1u);
    uint _e214 = shape_component(2u);
    uint _e217 = grid_component(0u);
    local_29 = uint(25);
    uint _e222 = local_29;
    _group_0_binding_4_cs[_e222] = (((_e209 + _e211) + _e214) + _e217);
    uint _e224 = global_x();
    uint _e225 = global_x();
    local_30 = uint(26);
    uint _e230 = local_30;
    _group_0_binding_4_cs[_e230] = (_e224 + _e225);
    local_32 = uint(0);
    uint _e235 = local_32;
    int _e237 = _group_0_binding_0_cs[_e235];
    local_33 = uint(0);
    uint _e243 = local_33;
    float _e246 = _group_0_binding_2_cs[_e243].x;
    local_31 = uint(27);
    uint _e252 = local_31;
    _group_0_binding_4_cs[_e252] = floatBitsToUint(((float(_e237) * scale_1) + _e246));
    uint _e255 = kind(threadIdx.x);
    local_34 = uint(28);
    uint _e259 = local_34;
    _group_0_binding_4_cs[_e259] = _e255;
    uint _e262 = grid_component(2u);
    local_35 = uint(29);
    uint _e266 = local_35;
    _group_0_binding_4_cs[_e266] = _e262;
}

