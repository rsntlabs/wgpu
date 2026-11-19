#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct Five_cuda_record_0_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
};
struct Six_cuda_record_1_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
};
struct Seven_cuda_record_2_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
};
struct Eight_cuda_record_3_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
    uint h;
};
struct Small_cuda_record_4_ {
    uint value;
};
struct type_4 {
    Five_cuda_record_0_ value;
};
struct type_5 {
    Six_cuda_record_1_ value;
};
struct type_6 {
    Seven_cuda_record_2_ value;
};
struct type_7 {
    Eight_cuda_record_3_ value;
};
struct type_8 {
    Small_cuda_record_4_ value;
};
layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_4_block_1Compute { type_4 _group_0_binding_1_cs; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };

layout(std140) uniform type_6_block_3Compute { type_6 _group_0_binding_3_cs; };

layout(std140) uniform type_7_block_4Compute { type_7 _group_0_binding_4_cs; };

layout(std140) uniform type_8_block_5Compute { type_8 _group_0_binding_5_cs; };

layout(std430) readonly buffer type_9_block_6Compute { Five_cuda_record_0_ _group_0_binding_6_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    Five_cuda_record_0_ five = Five_cuda_record_0_(0, 0u, 0.0, 0u, 0);
    Six_cuda_record_1_ six = Six_cuda_record_1_(0, 0u, 0.0, 0u, 0, 0u);
    Seven_cuda_record_2_ seven = Seven_cuda_record_2_(0, 0u, 0.0, 0u, 0, 0u, 0.0);
    Eight_cuda_record_3_ eight = Eight_cuda_record_3_(0, 0u, 0.0, 0u, 0, 0u, 0.0, 0u);
    Small_cuda_record_4_ small = Small_cuda_record_4_(0u);
    Five_cuda_record_0_ original = Five_cuda_record_0_(0, 0u, 0.0, 0u, 0);
    Seven_cuda_record_2_ saved = Seven_cuda_record_2_(0, 0u, 0.0, 0u, 0, 0u, 0.0);
    Eight_cuda_record_3_ changed = Eight_cuda_record_3_(0, 0u, 0.0, 0u, 0, 0u, 0.0, 0u);
    Five_cuda_record_0_ stored = Five_cuda_record_0_(0, 0u, 0.0, 0u, 0);
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
    uint lane = 0u;
    Five_cuda_record_0_ local_11 = Five_cuda_record_0_(0, 0u, 0.0, 0u, 0);
    Five_cuda_record_0_ local_12 = Five_cuda_record_0_(0, 0u, 0.0, 0u, 0);
    Five_cuda_record_0_ _e4 = _group_0_binding_1_cs.value;
    five = _e4;
    Six_cuda_record_1_ _e8 = _group_0_binding_2_cs.value;
    six = _e8;
    Seven_cuda_record_2_ _e12 = _group_0_binding_3_cs.value;
    seven = _e12;
    Eight_cuda_record_3_ _e16 = _group_0_binding_4_cs.value;
    eight = _e16;
    Small_cuda_record_4_ _e20 = _group_0_binding_5_cs.value;
    small = _e20;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 12u));
    Five_cuda_record_0_ _e33 = five;
    original = _e33;
    Seven_cuda_record_2_ _e35 = seven;
    saved = _e35;
    lane = 0u;
    lane = lane_1;
    uint _e40 = lane;
    int _e43 = five.e;
    five.e = (_e43 + int(_e40));
    float _e48 = seven.g;
    seven.g = (_e48 + float(lane_1));
    Eight_cuda_record_3_ _e50 = eight;
    changed = _e50;
    uint _e53 = changed.h;
    changed.h = (_e53 + lane_1);
    Eight_cuda_record_3_ _e55 = changed;
    eight = _e55;
    Five_cuda_record_0_ _e58 = _group_0_binding_6_cs[lane_1];
    local_12 = _e58;
    Five_cuda_record_0_ _e60 = local_12;
    local_11 = _e60;
    Five_cuda_record_0_ _e62 = local_11;
    stored = _e62;
    int _e65 = original.e;
    _group_0_binding_0_cs[base] = uint((_e65 + 30));
    int _e72 = five.e;
    local = uint((base + 1u));
    uint _e80 = local;
    _group_0_binding_0_cs[_e80] = uint((_e72 + 30));
    int _e83 = six.e;
    local_1 = uint((base + 2u));
    uint _e91 = local_1;
    _group_0_binding_0_cs[_e91] = uint((_e83 + 30));
    uint _e94 = six.f;
    local_2 = uint((base + 3u));
    uint _e99 = local_2;
    _group_0_binding_0_cs[_e99] = _e94;
    float _e102 = seven.g;
    local_3 = uint((base + 4u));
    uint _e108 = local_3;
    _group_0_binding_0_cs[_e108] = floatBitsToUint(_e102);
    float _e111 = saved.g;
    local_4 = uint((base + 5u));
    uint _e117 = local_4;
    _group_0_binding_0_cs[_e117] = floatBitsToUint(_e111);
    uint _e120 = eight.h;
    local_5 = uint((base + 6u));
    uint _e125 = local_5;
    _group_0_binding_0_cs[_e125] = _e120;
    uint _e128 = eight.f;
    local_6 = uint((base + 7u));
    uint _e133 = local_6;
    _group_0_binding_0_cs[_e133] = _e128;
    float _e136 = eight.g;
    local_7 = uint((base + 8u));
    uint _e142 = local_7;
    _group_0_binding_0_cs[_e142] = floatBitsToUint(_e136);
    int _e145 = eight.e;
    local_8 = uint((base + 9u));
    uint _e153 = local_8;
    _group_0_binding_0_cs[_e153] = uint((_e145 + 30));
    uint _e156 = small.value;
    local_9 = uint((base + 10u));
    uint _e161 = local_9;
    _group_0_binding_0_cs[_e161] = _e156;
    int _e165 = stored.a;
    int _e166 = stored.e;
    uint _e170 = stored.b;
    uint _e173 = stored.d;
    float _e176 = stored.c;
    local_10 = uint((base + 11u));
    uint _e183 = local_10;
    _group_0_binding_0_cs[_e183] = (((uint((_e165 + _e166)) + _e170) + _e173) + uint(_e176));
}

