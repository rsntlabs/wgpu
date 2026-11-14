#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_2_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int64_t _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };


int first_set_word(int64_t value) {
    uint _e1 = uint(value);
    uint _e4 = uint((value >> (32u & 63u)));
    return int(((_e1 != 0u) ? (min(uint(findLSB(_e1)), 32u) + 1u) : ((_e4 != 0u) ? (min(uint(findLSB(_e4)), 32u) + 33u) : 0u)));
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
    int64_t _e13 = _group_0_binding_1_cs[index];
    int _e14 = first_set_word(_e13);
    local = uint((index + 4u));
    uint _e19 = local;
    _group_0_binding_0_cs[_e19] = _e14;
}

