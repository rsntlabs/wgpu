#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    ivec2 value;
};
struct type_7 {
    uvec2 value;
};
struct type_9 {
    vec2 value;
};
struct type_10 {
    ivec4 value;
};
struct type_12 {
    uvec4 value;
};
struct type_14 {
    vec4 value;
};
layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };

layout(std140) uniform type_7_block_2Compute { type_7 _group_0_binding_2_cs; };

layout(std140) uniform type_9_block_3Compute { type_9 _group_0_binding_3_cs; };

layout(std140) uniform type_10_block_4Compute { type_10 _group_0_binding_4_cs; };

layout(std140) uniform type_12_block_5Compute { type_12 _group_0_binding_5_cs; };

layout(std140) uniform type_14_block_6Compute { type_14 _group_0_binding_6_cs; };


int sum_pair(ivec4 value) {
    ivec4 value_1 = ivec4(0);
    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return (_e4 + _e5);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    ivec2 signed2_ = ivec2(0);
    uvec2 unsigned2_ = uvec2(0u);
    vec2 real2_ = vec2(0.0);
    ivec4 signed4_ = ivec4(0);
    uvec4 unsigned4_ = uvec4(0u);
    vec4 real4_ = vec4(0.0);
    ivec2 original_signed = ivec2(0);
    vec2 original_real = vec2(0.0);
    uvec4 original_unsigned = uvec4(0u);
    uint local = 0u;
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
    ivec2 _e4 = _group_0_binding_1_cs.value;
    signed2_ = _e4;
    uvec2 _e8 = _group_0_binding_2_cs.value;
    unsigned2_ = _e8;
    vec2 _e12 = _group_0_binding_3_cs.value;
    real2_ = _e12;
    ivec4 _e16 = _group_0_binding_4_cs.value;
    signed4_ = _e16;
    uvec4 _e20 = _group_0_binding_5_cs.value;
    unsigned4_ = _e20;
    vec4 _e24 = _group_0_binding_6_cs.value;
    real4_ = _e24;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    ivec2 _e37 = signed2_;
    original_signed = _e37;
    vec2 _e39 = real2_;
    original_real = _e39;
    uvec4 _e41 = unsigned4_;
    original_unsigned = _e41;
    int _e45 = signed2_.x;
    signed2_.x = (_e45 + int(lane));
    int _e49 = signed2_.y;
    signed2_.y = (_e49 - int(lane));
    uint _e52 = unsigned2_.x;
    unsigned2_.x = (_e52 + lane);
    uint _e55 = unsigned2_.y;
    unsigned2_.y = (_e55 + 2u);
    float _e60 = real2_.x;
    real2_.x = (_e60 + float(lane));
    float _e63 = real2_.y;
    real2_.y = (_e63 * 2.0);
    int _e67 = signed4_.x;
    int _e69 = signed4_.y;
    int _e72 = signed4_.z;
    ivec4 _e74 = signed4_;
    int _e75 = sum_pair(_e74);
    signed4_ = ivec4(_e67, _e69, (_e72 + int(lane)), _e75);
    uint _e78 = unsigned4_.y;
    unsigned4_.x = (_e78 + 1u);
    uint _e83 = unsigned4_.w;
    unsigned4_.w = (_e83 + lane);
    int _e86 = signed2_.x;
    _group_0_binding_0_cs[base] = uint((_e86 + 10));
    int _e93 = signed2_.y;
    local = uint((base + 1u));
    uint _e99 = local;
    _group_0_binding_0_cs[_e99] = uint(_e93);
    uint _e103 = unsigned2_.x;
    uint _e104 = unsigned2_.y;
    local_1 = uint((base + 2u));
    uint _e110 = local_1;
    _group_0_binding_0_cs[_e110] = (_e103 + _e104);
    float _e113 = real2_.x;
    local_2 = uint((base + 3u));
    uint _e119 = local_2;
    _group_0_binding_0_cs[_e119] = floatBitsToUint(_e113);
    float _e122 = real2_.y;
    local_3 = uint((base + 4u));
    uint _e128 = local_3;
    _group_0_binding_0_cs[_e128] = floatBitsToUint(_e122);
    int _e131 = signed4_.z;
    local_4 = uint((base + 5u));
    uint _e139 = local_4;
    _group_0_binding_0_cs[_e139] = uint((_e131 + 10));
    int _e142 = signed4_.w;
    local_5 = uint((base + 6u));
    uint _e148 = local_5;
    _group_0_binding_0_cs[_e148] = uint(_e142);
    uint _e152 = unsigned4_.x;
    uint _e153 = unsigned4_.w;
    local_6 = uint((base + 7u));
    uint _e159 = local_6;
    _group_0_binding_0_cs[_e159] = (_e152 + _e153);
    float _e163 = real4_.x;
    float _e164 = real4_.y;
    float _e167 = real4_.z;
    float _e170 = real4_.w;
    local_7 = uint((base + 8u));
    uint _e177 = local_7;
    _group_0_binding_0_cs[_e177] = floatBitsToUint((((_e163 + _e164) + _e167) + _e170));
    int _e180 = original_signed.x;
    local_8 = uint((base + 9u));
    uint _e188 = local_8;
    _group_0_binding_0_cs[_e188] = uint((_e180 + 10));
    float _e191 = original_real.x;
    local_9 = uint((base + 10u));
    uint _e197 = local_9;
    _group_0_binding_0_cs[_e197] = floatBitsToUint(_e191);
    uint _e201 = original_unsigned.x;
    uint _e202 = original_unsigned.w;
    local_10 = uint((base + 11u));
    uint _e208 = local_10;
    _group_0_binding_0_cs[_e208] = (_e201 + _e202);
}

