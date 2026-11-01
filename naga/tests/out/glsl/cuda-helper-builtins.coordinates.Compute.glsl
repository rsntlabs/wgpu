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
    _group_0_binding_4_cs[uint(0)] = _e15;
    uint _e21 = thread_component(1u);
    _group_0_binding_4_cs[uint(1)] = _e21;
    uint _e26 = thread_component(2u);
    _group_0_binding_4_cs[uint(2)] = _e26;
    uint _e31 = group_component(0u);
    _group_0_binding_4_cs[uint(3)] = _e31;
    uint _e36 = group_component(1u);
    _group_0_binding_4_cs[uint(4)] = _e36;
    uint _e41 = group_component(2u);
    _group_0_binding_4_cs[uint(5)] = _e41;
    uint _e46 = shape_component(0u);
    _group_0_binding_4_cs[uint(6)] = _e46;
    uint _e51 = shape_component(1u);
    _group_0_binding_4_cs[uint(7)] = _e51;
    uint _e56 = shape_component(2u);
    _group_0_binding_4_cs[uint(8)] = _e56;
    uint _e61 = grid_component(0u);
    _group_0_binding_4_cs[uint(9)] = _e61;
    uint _e66 = grid_component(1u);
    _group_0_binding_4_cs[uint(10)] = _e66;
    uint _e71 = grid_component(2u);
    _group_0_binding_4_cs[uint(11)] = _e71;
    uint _e75 = global_x();
    _group_0_binding_4_cs[uint(12)] = _e75;
    uint _e80 = component(0u);
    _group_0_binding_4_cs[uint(13)] = _e80;
    float _e85 = component_1(2.5);
    _group_0_binding_4_cs[uint(14)] = floatBitsToUint(_e85);
    _group_0_binding_4_cs[uint(15)] = threadIdx.x;
    _group_0_binding_4_cs[uint(16)] = blockIdx.y;
    _group_0_binding_4_cs[uint(17)] = gridDim.z;
    _group_0_binding_4_cs[uint(18)] = 1u;
    int _e110 = _group_0_binding_0_cs[uint(0)];
    _group_0_binding_4_cs[uint(19)] = uint(_e110);
    _group_0_binding_4_cs[uint(20)] = floatBitsToUint(scale_1);
    float _e124 = _group_0_binding_2_cs[uint(0)].x;
    _group_0_binding_4_cs[uint(21)] = floatBitsToUint(_e124);
    float _e133 = _group_0_binding_2_cs[uint(0)].y;
    _group_0_binding_4_cs[uint(22)] = floatBitsToUint(_e133);
    float _e142 = _group_0_binding_2_cs[uint(0)].z;
    _group_0_binding_4_cs[uint(23)] = floatBitsToUint(_e142);
    _group_0_binding_4_cs[uint(24)] = limit_1;
    uint _e151 = thread_component(0u);
    uint _e153 = group_component(1u);
    uint _e156 = shape_component(2u);
    uint _e159 = grid_component(0u);
    _group_0_binding_4_cs[uint(25)] = (((_e151 + _e153) + _e156) + _e159);
    uint _e164 = global_x();
    uint _e165 = global_x();
    _group_0_binding_4_cs[uint(26)] = (_e164 + _e165);
    int _e173 = _group_0_binding_0_cs[uint(0)];
    float _e180 = _group_0_binding_2_cs[uint(0)].x;
    _group_0_binding_4_cs[uint(27)] = floatBitsToUint(((float(_e173) * scale_1) + _e180));
    uint _e187 = kind(threadIdx.x);
    _group_0_binding_4_cs[uint(28)] = _e187;
    uint _e192 = grid_component(2u);
    _group_0_binding_4_cs[uint(29)] = _e192;
}

