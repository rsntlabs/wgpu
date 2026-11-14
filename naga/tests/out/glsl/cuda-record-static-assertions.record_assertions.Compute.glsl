#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
struct Inner_cuda_record_0_ {
    float3_ vector;
    int row[3];
};
struct Record_cuda_record_1_ {
    int scalar;
    float3_ vector;
    int matrix[2][3];
    Inner_cuda_record_0_ nested;
};
struct Local_cuda_record_2_ {
    uint token;
};
layout(std430) buffer type_5_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    Record_cuda_record_1_ value = Record_cuda_record_1_(0, float3_(0.0, 0.0, 0.0), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)), Inner_cuda_record_0_(float3_(0.0, 0.0, 0.0), int[3](0, 0, 0)));
    Local_cuda_record_2_ local = Local_cuda_record_2_(0u);
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint lane = threadIdx.x;
    value.scalar = int((lane + 3u));
    value.vector = float3_(1.0, 2.0, float((lane + 5u)));
    value.matrix[1][2] = int((lane + 9u));
    value.nested.row[2] = int((lane + 15u));
    local.token = (lane + 21u);
    uint index = (4u + (lane * 8u));
    int _e38 = value.scalar;
    _group_0_binding_0_cs[index] = uint(_e38);
    float _e44 = value.vector.z;
    local_1 = uint((index + 1u));
    uint _e50 = local_1;
    _group_0_binding_0_cs[_e50] = uint(_e44);
    int _e57 = value.matrix[1][2];
    local_2 = uint((index + 2u));
    uint _e63 = local_2;
    _group_0_binding_0_cs[_e63] = uint(_e57);
    int _e69 = value.nested.row[2];
    local_3 = uint((index + 3u));
    uint _e75 = local_3;
    _group_0_binding_0_cs[_e75] = uint(_e69);
    local_4 = uint((index + 4u));
    uint _e83 = local_4;
    _group_0_binding_0_cs[_e83] = uint(64ul);
    local_5 = uint((index + 5u));
    uint _e91 = local_5;
    _group_0_binding_0_cs[_e91] = uint(24ul);
    local_6 = uint((index + 6u));
    uint _e99 = local_6;
    _group_0_binding_0_cs[_e99] = uint(12ul);
    uint _e102 = local.token;
    local_7 = uint((index + 7u));
    uint _e107 = local_7;
    _group_0_binding_0_cs[_e107] = _e102;
}

