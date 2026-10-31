#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint input_[2] = uint[2](0u, 0u);
    uint output_[2] = uint[2](0u, 0u);
    float offset = 0.0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    float local_4 = 0.0;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7 = 0u;
    float local_8 = 0.0;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11 = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 0u;
    input_[1] = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 1u;
    output_[1] = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    int i = int(((blockIdx.x * 1u) + threadIdx.x));
    if ((uint(i) < n_1)) {
        offset = float(i);
        uint _e28[2] = input_;
        local_2 = _e28;
        local_3 = uint(i);
        uint _e32[2] = local_2;
        local_5 = _e32;
        uint _e34 = local_3;
        uint _e36 = local_5[1];
        local_5[1] = (_e36 + _e34);
        uint _e40 = local_5[0];
        local_6 = uint(_e40);
        uint _e44 = local_5[1];
        local_7 = uint(_e44);
        uint _e47 = local_7;
        float _e50 = _group_0_binding_0_cs[_e47];
        local_8 = _e50;
        float _e52 = local_8;
        local_4 = _e52;
        float _e54 = local_4;
        float _e55 = offset;
        uint _e58[2] = output_;
        local = _e58;
        local_1 = uint(i);
        uint _e62[2] = local;
        local_9 = _e62;
        uint _e64 = local_1;
        uint _e66 = local_9[1];
        local_9[1] = (_e66 + _e64);
        uint _e70 = local_9[0];
        local_10 = uint(_e70);
        uint _e74 = local_9[1];
        local_11 = uint(_e74);
        uint _e77 = local_11;
        _group_0_binding_1_cs[_e77] = (_e54 + _e55);
    }
}

