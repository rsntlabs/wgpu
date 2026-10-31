#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_1 {
    float value;
};
layout(std140) uniform type_1_block_0Compute { type_1 _group_0_binding_0_cs; };

layout(std430) readonly buffer type_2_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_2_block_2Compute { float _group_0_binding_2_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    float factor = 0.0;
    uint input_[2] = uint[2](0u, 0u);
    uint output_[2] = uint[2](0u, 0u);
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
    float _e3 = _group_0_binding_0_cs.value;
    factor = _e3;
    input_ = uint[2](0u, 0u);
    input_[0] = 0u;
    input_[1] = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 1u;
    output_[1] = 0u;
    float _e19 = factor;
    factor = (_e19 * 2.0);
    uint _e24[2] = input_;
    local_2 = _e24;
    local_3 = uint(threadIdx.x);
    uint _e29[2] = local_2;
    local_5 = _e29;
    uint _e30 = local_3;
    uint _e32 = local_5[1];
    local_5[1] = (_e32 + _e30);
    uint _e36 = local_5[0];
    local_6 = uint(_e36);
    uint _e40 = local_5[1];
    local_7 = uint(_e40);
    uint _e44 = local_7;
    float _e46 = _group_0_binding_1_cs[_e44];
    local_8 = _e46;
    float _e47 = local_8;
    local_4 = _e47;
    float _e49 = local_4;
    float _e50 = factor;
    uint _e54[2] = output_;
    local = _e54;
    local_1 = uint(threadIdx.x);
    uint _e59[2] = local;
    local_9 = _e59;
    uint _e60 = local_1;
    uint _e62 = local_9[1];
    local_9[1] = (_e62 + _e60);
    uint _e66 = local_9[0];
    local_10 = uint(_e66);
    uint _e70 = local_9[1];
    local_11 = uint(_e70);
    uint _e73 = local_11;
    _group_0_binding_2_cs[_e73] = (_e49 * _e50);
}

