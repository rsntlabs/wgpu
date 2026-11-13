#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_3_block_1Compute { uint64_t _group_0_binding_1_cs[]; };


int count_word(uint64_t value) {
    return int((uint(bitCount(uint(value))) + uint(bitCount(uint((value >> (32u & 63u)))))));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint index = threadIdx.x;
    uint64_t _e4 = _group_0_binding_1_cs[index];
    int _e5 = count_word(_e4);
    _group_0_binding_0_cs[index] = _e5;
}

