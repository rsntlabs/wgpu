#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { uint64_t _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { uint64_t _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


uint64_t reverse_word(uint64_t value) {
    return ((uint64_t(bitfieldReverse(uint(value))) << (32u & 63u)) | uint64_t(bitfieldReverse(uint((value >> (32u & 63u))))));
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    uint64_t _e13 = _group_0_binding_1_cs[index];
    uint64_t _e14 = reverse_word(_e13);
    local = uint((index + 4u));
    uint _e19 = local;
    _group_0_binding_0_cs[_e19] = _e14;
}

