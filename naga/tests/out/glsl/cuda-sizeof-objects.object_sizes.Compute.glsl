#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    float3_ values[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    _group_0_binding_0_cs[uint(0)] = uint(24ul);
    _group_0_binding_0_cs[uint(1)] = uint(12ul);
    _group_0_binding_0_cs[uint(2)] = uint(8ul);
}

