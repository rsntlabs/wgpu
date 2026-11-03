#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct Settings_cuda_record_0_ {
    uint scale;
    uint bias;
};
struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_block_0Compute { uint _group_1_binding_0_cs; };

layout(std430) readonly buffer type_1_block_1Compute { uint _group_1_binding_1_cs[4]; };

layout(std430) readonly buffer Settings_cuda_record_0_block_2Compute { Settings_cuda_record_0_ _group_1_binding_2_cs; };

layout(std430) buffer type_2_block_3Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_4Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_5Compute { type_3 _group_0_binding_2_cs; };


uint weighted_unsigned(uint input_2, uint index_1) {
    uint index_2 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint _e4 = _group_1_binding_2_cs.scale;
    index_2 = 0u;
    local_31 = 0u;
    local_32 = 0u;
    index_2 = index_1;
    uint _e13 = index_2;
    local_31 = _e13;
    uint _e15 = local_31;
    uint _e18 = _group_1_binding_1_cs[_e15];
    local_32 = _e18;
    uint _e20 = local_32;
    uint _e23 = _group_1_binding_0_cs;
    return (((input_2 * _e4) + _e20) + _e23);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint output_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint value[2] = uint[2](0u, 0u);
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 2u;
    output_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 3u;
    input_[1] = 0u;
    uint count_2 = _group_0_binding_2_cs.value;
    uint index_3 = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index_3 < count_2)) {
        uint _e24[2] = input_;
        local_2 = _e24;
        local_3 = index_3;
        uint _e27[2] = local_2;
        local_7 = _e27;
        uint _e29 = local_3;
        uint _e31 = local_7[1];
        local_7[1] = (_e31 + _e29);
        uint _e35 = local_7[0];
        local_8 = uint(_e35);
        uint _e39 = local_7[1];
        local_9 = uint(_e39);
        uint _e42 = local_9;
        uint _e45 = _group_0_binding_1_cs[_e42];
        local_10 = _e45;
        uint _e47 = local_10;
        local_6 = _e47;
        uint _e49 = local_6;
        uint _e52 = weighted_unsigned(_e49, (index_3 - 4u * (index_3 / 4u)));
        uint _e55 = _group_1_binding_2_cs.bias;
        value = uint[2](0u, 0u);
        value[0] = 4u;
        value[1] = 0u;
        local_4 = 31u;
        uint _e65 = local_4;
        local_5 = 41u;
        uint _e69 = local_5;
        uint _e72[2] = output_;
        local = _e72;
        local_1 = index_3;
        uint _e75[2] = local;
        local_11 = _e75;
        uint _e77 = local_1;
        uint _e79 = local_11[1];
        local_11[1] = (_e79 + _e77);
        uint _e83 = local_11[0];
        local_12 = uint(_e83);
        uint _e87 = local_11[1];
        local_13 = uint(_e87);
        uint _e90 = local_13;
        _group_0_binding_0_cs[_e90] = (((_e52 + _e55) + _e65) + _e69);
    }
}

