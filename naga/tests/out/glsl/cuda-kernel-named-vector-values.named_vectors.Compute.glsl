#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct int3_ {
    int x;
    int y;
    int z;
};
struct int1_ {
    int x;
};
struct type_3 {
    int1_ value;
};
struct uint1_ {
    uint x;
};
struct type_4 {
    uint1_ value;
};
struct float1_ {
    float x;
};
struct type_6 {
    float1_ value;
};
struct type_7 {
    int3_ value;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct type_8 {
    uint3_ value;
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_9 {
    float3_ value;
};
layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_3_block_1Compute { type_3 _group_0_binding_1_cs; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };

layout(std140) uniform type_6_block_3Compute { type_6 _group_0_binding_3_cs; };

layout(std140) uniform type_7_block_4Compute { type_7 _group_0_binding_4_cs; };

layout(std140) uniform type_8_block_5Compute { type_8 _group_0_binding_5_cs; };

layout(std140) uniform type_9_block_6Compute { type_9 _group_0_binding_6_cs; };

layout(std430) readonly buffer type_10_block_7Compute { float3_ _group_0_binding_7_cs[]; };


int sum_pair(int3_ value) {
    int3_ value_1 = int3_(0, 0, 0);
    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return (_e4 + _e5);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    int1_ signed1_ = int1_(0);
    uint1_ unsigned1_ = uint1_(0u);
    float1_ real1_ = float1_(0.0);
    int3_ signed3_ = int3_(0, 0, 0);
    uint3_ unsigned3_ = uint3_(0u, 0u, 0u);
    float3_ real3_ = float3_(0.0, 0.0, 0.0);
    int1_ original_signed = int1_(0);
    float1_ original_real = float1_(0.0);
    uint3_ original_unsigned = uint3_(0u, 0u, 0u);
    float3_ stored = float3_(0.0, 0.0, 0.0);
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
    float3_ local_11 = float3_(0.0, 0.0, 0.0);
    float3_ local_12 = float3_(0.0, 0.0, 0.0);
    int1_ _e4 = _group_0_binding_1_cs.value;
    signed1_ = _e4;
    uint1_ _e8 = _group_0_binding_2_cs.value;
    unsigned1_ = _e8;
    float1_ _e12 = _group_0_binding_3_cs.value;
    real1_ = _e12;
    int3_ _e16 = _group_0_binding_4_cs.value;
    signed3_ = _e16;
    uint3_ _e20 = _group_0_binding_5_cs.value;
    unsigned3_ = _e20;
    float3_ _e24 = _group_0_binding_6_cs.value;
    real3_ = _e24;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    int1_ _e37 = signed1_;
    original_signed = _e37;
    float1_ _e39 = real1_;
    original_real = _e39;
    uint3_ _e41 = unsigned3_;
    original_unsigned = _e41;
    int _e45 = signed1_.x;
    signed1_.x = (_e45 + int(lane));
    uint _e48 = unsigned1_.x;
    unsigned1_.x = (_e48 + lane);
    float _e52 = real1_.x;
    real1_.x = (_e52 + float(lane));
    int _e55 = signed3_.x;
    int _e57 = signed3_.y;
    int _e60 = signed3_.z;
    signed3_ = int3_(_e55, _e57, (_e60 + int(lane)));
    uint _e64 = unsigned3_.y;
    unsigned3_.x = (_e64 + 1u);
    uint _e69 = unsigned3_.z;
    unsigned3_.z = (_e69 + lane);
    float3_ _e73 = _group_0_binding_7_cs[lane];
    local_12 = _e73;
    float3_ _e75 = local_12;
    local_11 = _e75;
    float3_ _e77 = local_11;
    stored = _e77;
    int _e80 = signed1_.x;
    _group_0_binding_0_cs[base] = uint((_e80 + 10));
    uint _e87 = unsigned1_.x;
    local = uint((base + 1u));
    uint _e92 = local;
    _group_0_binding_0_cs[_e92] = _e87;
    float _e95 = real1_.x;
    local_1 = uint((base + 2u));
    uint _e101 = local_1;
    _group_0_binding_0_cs[_e101] = floatBitsToUint(_e95);
    int _e104 = signed3_.z;
    local_2 = uint((base + 3u));
    uint _e112 = local_2;
    _group_0_binding_0_cs[_e112] = uint((_e104 + 10));
    int3_ _e114 = signed3_;
    int _e115 = sum_pair(_e114);
    local_3 = uint((base + 4u));
    uint _e121 = local_3;
    _group_0_binding_0_cs[_e121] = uint(_e115);
    uint _e125 = unsigned3_.x;
    uint _e126 = unsigned3_.z;
    local_4 = uint((base + 5u));
    uint _e132 = local_4;
    _group_0_binding_0_cs[_e132] = (_e125 + _e126);
    float _e136 = real3_.x;
    float _e137 = real3_.y;
    float _e140 = real3_.z;
    local_5 = uint((base + 6u));
    uint _e147 = local_5;
    _group_0_binding_0_cs[_e147] = floatBitsToUint(((_e136 + _e137) + _e140));
    int _e150 = original_signed.x;
    local_6 = uint((base + 7u));
    uint _e158 = local_6;
    _group_0_binding_0_cs[_e158] = uint((_e150 + 10));
    uint _e162 = original_unsigned.x;
    uint _e163 = original_unsigned.z;
    local_7 = uint((base + 8u));
    uint _e169 = local_7;
    _group_0_binding_0_cs[_e169] = (_e162 + _e163);
    float _e172 = original_real.x;
    local_8 = uint((base + 9u));
    uint _e178 = local_8;
    _group_0_binding_0_cs[_e178] = floatBitsToUint(_e172);
    float _e181 = stored.z;
    local_9 = uint((base + 10u));
    uint _e187 = local_9;
    _group_0_binding_0_cs[_e187] = floatBitsToUint(_e181);
    float _e191 = stored.x;
    float _e192 = real3_.x;
    local_10 = uint((base + 11u));
    uint _e199 = local_10;
    _group_0_binding_0_cs[_e199] = floatBitsToUint((_e191 + _e192));
}

