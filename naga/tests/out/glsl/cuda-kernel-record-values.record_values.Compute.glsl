#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct One_cuda_record_0_ {
    int x;
};
struct Two_cuda_record_1_ {
    uint x;
    float y;
};
struct Trio_cuda_record_2_ {
    int x;
    uint y;
    float z;
};
struct Four_cuda_record_3_ {
    int x;
    uint y;
    float z;
    uint w;
};
struct Twin_cuda_record_4_ {
    int x;
    uint y;
    float z;
};
struct type_4 {
    One_cuda_record_0_ value;
};
struct type_5 {
    Two_cuda_record_1_ value;
};
struct type_6 {
    Trio_cuda_record_2_ value;
};
struct type_7 {
    Four_cuda_record_3_ value;
};
layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_4_block_1Compute { type_4 _group_0_binding_1_cs; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };

layout(std140) uniform type_6_block_3Compute { type_6 _group_0_binding_3_cs; };

layout(std140) uniform type_7_block_4Compute { type_7 _group_0_binding_4_cs; };

layout(std430) readonly buffer type_8_block_5Compute { Trio_cuda_record_2_ _group_0_binding_5_cs[]; };


uint kind(Trio_cuda_record_2_ param) {
    return 11u;
}

uint kind_1(Twin_cuda_record_4_ param_1) {
    return 22u;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    One_cuda_record_0_ one = One_cuda_record_0_(0);
    Two_cuda_record_1_ two = Two_cuda_record_1_(0u, 0.0);
    Trio_cuda_record_2_ three = Trio_cuda_record_2_(0, 0u, 0.0);
    Four_cuda_record_3_ four = Four_cuda_record_3_(0, 0u, 0.0, 0u);
    Trio_cuda_record_2_ original = Trio_cuda_record_2_(0, 0u, 0.0);
    Four_cuda_record_3_ changed = Four_cuda_record_3_(0, 0u, 0.0, 0u);
    Twin_cuda_record_4_ other = Twin_cuda_record_4_(0, 0u, 0.0);
    Trio_cuda_record_2_ stored = Trio_cuda_record_2_(0, 0u, 0.0);
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
    Trio_cuda_record_2_ local_11 = Trio_cuda_record_2_(0, 0u, 0.0);
    Trio_cuda_record_2_ local_12 = Trio_cuda_record_2_(0, 0u, 0.0);
    One_cuda_record_0_ _e4 = _group_0_binding_1_cs.value;
    one = _e4;
    Two_cuda_record_1_ _e8 = _group_0_binding_2_cs.value;
    two = _e8;
    Trio_cuda_record_2_ _e12 = _group_0_binding_3_cs.value;
    three = _e12;
    Four_cuda_record_3_ _e16 = _group_0_binding_4_cs.value;
    four = _e16;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 12u));
    Trio_cuda_record_2_ _e29 = three;
    original = _e29;
    int _e33 = one.x;
    one.x = (_e33 + int(lane_1));
    lane = 0u;
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = three.y;
    three.y = (_e40 + _e38);
    int _e45 = three.x;
    three.x = (_e45 - int(lane_1));
    Four_cuda_record_3_ _e47 = four;
    changed = _e47;
    int _e51 = changed.x;
    changed.x = (_e51 + int(lane_1));
    uint _e54 = changed.y;
    changed.y = (_e54 + 1u);
    float _e58 = changed.z;
    changed.z = (_e58 * 2.0);
    Four_cuda_record_3_ _e61 = changed;
    four = _e61;
    int _e63 = original.x;
    other.x = _e63;
    uint _e67 = original.y;
    other.y = _e67;
    float _e70 = original.z;
    other.z = _e70;
    Trio_cuda_record_2_ _e74 = _group_0_binding_5_cs[lane_1];
    local_12 = _e74;
    Trio_cuda_record_2_ _e76 = local_12;
    local_11 = _e76;
    Trio_cuda_record_2_ _e78 = local_11;
    stored = _e78;
    int _e81 = one.x;
    _group_0_binding_0_cs[base] = uint((_e81 + 10));
    uint _e88 = two.x;
    local = uint((base + 1u));
    uint _e93 = local;
    _group_0_binding_0_cs[_e93] = _e88;
    float _e96 = two.y;
    local_1 = uint((base + 2u));
    uint _e102 = local_1;
    _group_0_binding_0_cs[_e102] = floatBitsToUint(_e96);
    int _e105 = three.x;
    local_2 = uint((base + 3u));
    uint _e113 = local_2;
    _group_0_binding_0_cs[_e113] = uint((_e105 + 20));
    uint _e116 = three.y;
    local_3 = uint((base + 4u));
    uint _e121 = local_3;
    _group_0_binding_0_cs[_e121] = _e116;
    float _e124 = three.z;
    local_4 = uint((base + 5u));
    uint _e130 = local_4;
    _group_0_binding_0_cs[_e130] = floatBitsToUint(_e124);
    int _e133 = four.x;
    local_5 = uint((base + 6u));
    uint _e141 = local_5;
    _group_0_binding_0_cs[_e141] = uint((_e133 + 20));
    uint _e144 = four.y;
    local_6 = uint((base + 7u));
    uint _e149 = local_6;
    _group_0_binding_0_cs[_e149] = _e144;
    float _e152 = four.z;
    local_7 = uint((base + 8u));
    uint _e158 = local_7;
    _group_0_binding_0_cs[_e158] = floatBitsToUint(_e152);
    uint _e161 = four.w;
    local_8 = uint((base + 9u));
    uint _e166 = local_8;
    _group_0_binding_0_cs[_e166] = _e161;
    uint _e169 = original.y;
    local_9 = uint((base + 10u));
    uint _e174 = local_9;
    _group_0_binding_0_cs[_e174] = _e169;
    Trio_cuda_record_2_ _e176 = three;
    uint _e177 = kind(_e176);
    Twin_cuda_record_4_ _e178 = other;
    uint _e179 = kind_1(_e178);
    int _e182 = stored.x;
    uint _e186 = stored.y;
    float _e189 = stored.z;
    local_10 = uint((base + 11u));
    uint _e196 = local_10;
    _group_0_binding_0_cs[_e196] = ((((_e177 + _e179) + uint(_e182)) + _e186) + uint(_e189));
}

