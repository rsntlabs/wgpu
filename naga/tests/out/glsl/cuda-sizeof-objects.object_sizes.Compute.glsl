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
struct Record_cuda_record_0_ {
    float3_ vector;
    int matrix[2][3];
};
layout(std430) buffer type_5_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    float3_ values[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    Record_cuda_record_0_ record = Record_cuda_record_0_(float3_(0.0, 0.0, 0.0), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)));
    Record_cuda_record_0_ records[2] = Record_cuda_record_0_[2](Record_cuda_record_0_(float3_(0.0, 0.0, 0.0), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0))), Record_cuda_record_0_(float3_(0.0, 0.0, 0.0), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0))));
    _group_0_binding_0_cs[uint(0)] = uint(24ul);
    _group_0_binding_0_cs[uint(1)] = uint(12ul);
    _group_0_binding_0_cs[uint(2)] = uint(8ul);
    _group_0_binding_0_cs[uint(3)] = uint(12ul);
    _group_0_binding_0_cs[uint(4)] = uint(24ul);
    _group_0_binding_0_cs[uint(5)] = uint(4ul);
    _group_0_binding_0_cs[uint(6)] = uint(4ul);
}

