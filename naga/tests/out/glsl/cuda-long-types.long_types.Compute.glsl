#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_4 {
    uint64_t value;
};
struct type_5 {
    int64_t value;
};
layout(std430) readonly buffer type_2_block_0Compute { int64_t _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint64_t _group_0_binding_1_cs[]; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };

layout(std140) uniform type_5_block_3Compute { type_5 _group_0_binding_3_cs; };


uint kind(int64_t value) {
    return 3u;
}

uint kind_1(int64_t value_1) {
    return 5u;
}

int64_t identity_long(int64_t value_2) {
    return value_2;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint64_t count_1 = _group_0_binding_2_cs.value;
    int64_t bias_1 = _group_0_binding_3_cs.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    if ((uint64_t(index) >= count_1)) {
        return;
    }
    int64_t _e17 = _group_0_binding_0_cs[index];
    int64_t _e19 = identity_long((_e17 + bias_1));
    uint _e20 = kind(_e19);
    uint _e23 = kind_1(_e19);
    uint tags = ((_e20 * 10u) + _e23);
    _group_0_binding_1_cs[index] = (uint64_t((_e19 + 1l)) + uint64_t(tags));
}

