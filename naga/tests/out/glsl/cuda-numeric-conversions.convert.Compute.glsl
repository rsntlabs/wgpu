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
    uint n = 0u;
    int i = 0;
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
    uint _e18 = _group_0_binding_2_cs.value;
    n = _e18;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e27 = i;
    uint _e29 = n;
    if ((uint(_e27) < _e29)) {
        int _e31 = i;
        offset = float(_e31);
        uint _e36[2] = input_;
        local_2 = _e36;
        int _e37 = i;
        local_3 = uint(_e37);
        uint _e41[2] = local_2;
        local_5 = _e41;
        uint _e42 = local_3;
        uint _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        uint _e48 = local_5[0];
        local_6 = uint(_e48);
        uint _e52 = local_5[1];
        local_7 = uint(_e52);
        uint _e56 = local_7;
        float _e58 = _group_0_binding_0_cs[_e56];
        local_8 = _e58;
        float _e59 = local_8;
        local_4 = _e59;
        float _e61 = local_4;
        float _e62 = offset;
        uint _e66[2] = output_;
        local = _e66;
        int _e67 = i;
        local_1 = uint(_e67);
        uint _e71[2] = local;
        local_9 = _e71;
        uint _e72 = local_1;
        uint _e74 = local_9[1];
        local_9[1] = (_e74 + _e72);
        uint _e78 = local_9[0];
        local_10 = uint(_e78);
        uint _e82 = local_9[1];
        local_11 = uint(_e82);
        uint _e85 = local_11;
        _group_0_binding_1_cs[_e85] = (_e61 + _e62);
    }
}

