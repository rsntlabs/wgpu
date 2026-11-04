#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_1 {
    uint64_t value;
};
layout(std430) buffer type_block_0Compute { uint64_t _group_0_binding_0_cs[]; };

layout(std140) uniform type_1_block_1Compute { type_1 _group_0_binding_1_cs; };


uint64_t byte_count_float3_() {
    return 12ul;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint64_t base_1 = _group_0_binding_1_cs.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    uint64_t _e10 = byte_count_float3_();
    _group_0_binding_0_cs[index] = ((((base_1 + _e10) + 24ul) * 8ul) + 8ul);
}

