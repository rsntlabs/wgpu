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
    uvec3 blockIdx_1 = gl_WorkGroupID;
    uvec3 threadIdx_1 = gl_LocalInvocationID;
    uint output_1[2] = uint[2](0u, 0u);
    uint input_1[2] = uint[2](0u, 0u);
    Settings_cuda_record_0_ current = Settings_cuda_record_0_(0u, 0u);
    uint view[2] = uint[2](0u, 0u);
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint values[2] = uint[2](0u, 0u);
    uint index = 0u;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint value_1[2] = uint[2](0u, 0u);
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30 = 0u;
    output_1 = uint[2](0u, 0u);
    output_1[0] = 2u;
    output_1[1] = 0u;
    input_1 = uint[2](0u, 0u);
    input_1[0] = 3u;
    input_1[1] = 0u;
    uint count_2 = _group_0_binding_2_cs.value;
    uint index_3 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if ((index_3 >= count_2)) {
        return;
    }
    Settings_cuda_record_0_ _e24 = _group_1_binding_2_cs;
    current = _e24;
    view = uint[2](0u, 0u);
    view[0] = 4u;
    view[1] = 0u;
    uint _e33[2] = input_1;
    local_15 = _e33;
    uint _e36 = (index_3 + 1u);
    index = 0u;
    local_20 = 0u;
    local_21 = 0u;
    values = uint[2](0u, 0u);
    values[0] = 4u;
    values[1] = 0u;
    index = (_e36 - 4u * (_e36 / 4u));
    uint _e53[2] = values;
    local_19 = _e53;
    uint _e55 = index;
    local_20 = _e55;
    uint _e57[2] = local_19;
    local_22 = _e57;
    uint _e59 = local_20;
    uint _e61 = local_22[1];
    local_22[1] = (_e61 + _e59);
    uint _e65 = local_22[0];
    local_23 = uint(_e65);
    uint _e69 = local_22[1];
    local_24 = uint(_e69);
    uint _e72 = local_24;
    uint _e75 = _group_1_binding_1_cs[_e72];
    local_21 = _e75;
    uint _e77 = local_21;
    uint _e78[2] = local_15;
    local_25 = _e78;
    uint _e81 = local_25[1];
    local_25[1] = (_e81 + index_3);
    uint _e85 = local_25[0];
    local_26 = uint(_e85);
    uint _e89 = local_25[1];
    local_27 = uint(_e89);
    uint _e92 = local_27;
    uint _e95 = _group_0_binding_1_cs[_e92];
    uint _e98 = _group_1_binding_0_cs;
    uint _e101 = current.scale;
    uint _e104 = current.bias;
    uint _e107[2] = view;
    local_16 = _e107;
    uint _e109[2] = local_16;
    value_1 = _e109;
    local_17 = 37u;
    uint _e113 = local_17;
    local_18 = 43u;
    uint _e117 = local_18;
    uint _e120[2] = output_1;
    local_14 = _e120;
    uint _e122[2] = local_14;
    local_28 = _e122;
    uint _e125 = local_28[1];
    local_28[1] = (_e125 + index_3);
    uint _e129 = local_28[0];
    local_29 = uint(_e129);
    uint _e133 = local_28[1];
    local_30 = uint(_e133);
    uint _e136 = local_30;
    _group_0_binding_0_cs[_e136] = ((((((_e95 + _e77) + _e98) + _e101) + _e104) + _e113) + _e117);
}

