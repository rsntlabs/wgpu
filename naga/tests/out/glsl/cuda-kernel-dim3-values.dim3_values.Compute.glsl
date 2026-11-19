#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct type_2 {
    dim3_ value;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_2_block_1Compute { type_2 _group_0_binding_1_cs; };

layout(std140) uniform type_2_block_2Compute { type_2 _group_0_binding_2_cs; };


uint kind(dim3_ param) {
    return 11u;
}

uint kind_1(uint3_ param_1) {
    return 22u;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    dim3_ shape = dim3_(0u, 0u, 0u);
    dim3_ fixed_ = dim3_(0u, 0u, 0u);
    dim3_ original = dim3_(0u, 0u, 0u);
    uint3_ packed_ = uint3_(0u, 0u, 0u);
    dim3_ restored = dim3_(0u, 0u, 0u);
    dim3_ local = dim3_(0u, 0u, 0u);
    dim3_ partial = dim3_(0u, 0u, 0u);
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint lane = 0u;
    dim3_ _e4 = _group_0_binding_1_cs.value;
    shape = _e4;
    dim3_ _e8 = _group_0_binding_2_cs.value;
    fixed_ = _e8;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 14u));
    dim3_ _e21 = shape;
    original = _e21;
    dim3_ _e23 = original;
    packed_ = uint3_(_e23.x, _e23.y, _e23.z);
    uint3_ _e29 = packed_;
    restored = dim3_(_e29.x, _e29.y, _e29.z);
    lane = 0u;
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = shape.x;
    shape.x = (_e40 + _e38);
    uint _e44 = shape.y;
    shape.y = (_e44 + 2u);
    uint _e49 = shape.x;
    uint _e51 = shape.y;
    shape = dim3_(_e49, _e51, 1u);
    local = dim3_(1u, 1u, 1u);
    partial = dim3_(2u, 1u, 1u);
    uint _e65 = original.x;
    _group_0_binding_0_cs[base] = _e65;
    uint _e69 = original.y;
    local_1 = uint((base + 1u));
    uint _e74 = local_1;
    _group_0_binding_0_cs[_e74] = _e69;
    uint _e77 = original.z;
    local_2 = uint((base + 2u));
    uint _e82 = local_2;
    _group_0_binding_0_cs[_e82] = _e77;
    uint _e85 = shape.x;
    local_3 = uint((base + 3u));
    uint _e90 = local_3;
    _group_0_binding_0_cs[_e90] = _e85;
    uint _e93 = shape.y;
    local_4 = uint((base + 4u));
    uint _e98 = local_4;
    _group_0_binding_0_cs[_e98] = _e93;
    uint _e101 = shape.z;
    local_5 = uint((base + 5u));
    uint _e106 = local_5;
    _group_0_binding_0_cs[_e106] = _e101;
    uint _e110 = local.x;
    uint _e111 = local.y;
    uint _e114 = local.z;
    local_6 = uint((base + 6u));
    uint _e120 = local_6;
    _group_0_binding_0_cs[_e120] = ((_e110 + _e111) + _e114);
    uint _e123 = fixed_.x;
    local_7 = uint((base + 7u));
    uint _e128 = local_7;
    _group_0_binding_0_cs[_e128] = _e123;
    uint _e131 = fixed_.y;
    local_8 = uint((base + 8u));
    uint _e136 = local_8;
    _group_0_binding_0_cs[_e136] = _e131;
    uint _e139 = fixed_.z;
    local_9 = uint((base + 9u));
    uint _e144 = local_9;
    _group_0_binding_0_cs[_e144] = _e139;
    dim3_ _e146 = shape;
    uint _e147 = kind(_e146);
    uint3_ _e148 = packed_;
    uint _e149 = kind_1(_e148);
    local_10 = uint((base + 10u));
    uint _e155 = local_10;
    _group_0_binding_0_cs[_e155] = (_e147 + _e149);
    uint _e159 = restored.x;
    uint _e160 = restored.y;
    uint _e163 = restored.z;
    local_11 = uint((base + 11u));
    uint _e169 = local_11;
    _group_0_binding_0_cs[_e169] = ((_e159 ^ _e160) ^ _e163);
    local_12 = uint((base + 12u));
    uint _e175 = local_12;
    _group_0_binding_0_cs[_e175] = 4u;
    uint _e180 = partial.y;
    uint _e181 = partial.z;
    local_13 = uint((base + 13u));
    uint _e187 = local_13;
    _group_0_binding_0_cs[_e187] = (_e180 + _e181);
}

