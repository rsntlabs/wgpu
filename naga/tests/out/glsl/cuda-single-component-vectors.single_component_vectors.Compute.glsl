#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct int1_ {
    int x;
};
struct float1_ {
    float x;
};
struct uint1_ {
    uint x;
};
struct short1_ {
    int16_t x;
};
struct ushort1_ {
    uint16_t x;
};
struct type_7 {
    uint value;
};
layout(std430) readonly buffer type_5_block_0Compute { int1_ _group_0_binding_0_cs[]; };

layout(std430) buffer type_5_block_1Compute { int1_ _group_0_binding_1_cs[]; };

layout(std430) buffer type_6_block_2Compute { uint _group_0_binding_2_cs[]; };

layout(std140) uniform type_7_block_3Compute { type_7 _group_0_binding_3_cs; };


uint kind(float1_ value) {
    float1_ value_1 = float1_(0.0);
    value_1 = value;
    return 11u;
}

uint kind_1(int1_ value_2) {
    int1_ value_3 = int1_(0);
    value_3 = value_2;
    return 13u;
}

uint kind_2(uint1_ value_4) {
    uint1_ value_5 = uint1_(0u);
    value_5 = value_4;
    return 17u;
}

uint kind_3(short1_ value_6) {
    short1_ value_7 = short1_(int16_t(0));
    value_7 = value_6;
    return 19u;
}

uint kind_4(ushort1_ value_8) {
    ushort1_ value_9 = ushort1_(uint16_t(0));
    value_9 = value_8;
    return 23u;
}

uint kind_5(float value_10) {
    return 31u;
}

uint kind_6(int value_11) {
    return 37u;
}

uint kind_7(uint value_12) {
    return 41u;
}

uint kind_8(int16_t value_13) {
    return 43u;
}

uint kind_9(uint16_t value_14) {
    return 47u;
}

int1_ identity_int1_(int1_ value_15) {
    int1_ value_16 = int1_(0);
    value_16 = value_15;
    int1_ _e2 = value_16;
    return _e2;
}

uint1_ identity_uint1_(uint1_ value_17) {
    uint1_ value_18 = uint1_(0u);
    value_18 = value_17;
    uint1_ _e2 = value_18;
    return _e2;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    int1_ signed_value = int1_(0);
    uint1_ unsigned_value = uint1_(0u);
    float1_ floating = float1_(0.0);
    short1_ signed_half = short1_(int16_t(0));
    ushort1_ unsigned_half = ushort1_(uint16_t(0));
    int1_ changed = int1_(0);
    int1_ local = int1_(0);
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
    uint local_14 = 0u;
    uint local_15 = 0u;
    int1_ result = int1_(0);
    int1_ local_16 = int1_(0);
    uint count_1 = _group_0_binding_3_cs.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    int _e14 = _group_0_binding_0_cs[index].x;
    int1_ _e16 = identity_int1_(int1_(_e14));
    signed_value = _e16;
    int _e19 = signed_value.x;
    uint1_ _e22 = identity_uint1_(uint1_(uint(_e19)));
    unsigned_value = _e22;
    int _e25 = signed_value.x;
    floating = float1_((float((_e25 & 7)) + 0.5));
    int _e34 = signed_value.x;
    signed_half = short1_(int16_t(_e34));
    int _e39 = signed_value.x;
    unsigned_half = ushort1_(uint16_t(_e39));
    int16_t _e44 = signed_half.x;
    signed_half.x = int16_t((int(_e44) + 1));
    uint16_t _e50 = unsigned_half.x;
    unsigned_half.x = uint16_t((int(_e50) + 1));
    result = int1_(0);
    int1_ _e57 = signed_value;
    local_16 = _e57;
    int1_ _e59 = local_16;
    result = _e59;
    int _e62 = result.x;
    result.x = (_e62 ^ 324508639);
    int1_ _e65 = result;
    local = _e65;
    int1_ _e67 = local;
    changed = _e67;
    int1_ _e69 = changed;
    _group_0_binding_1_cs[index] = _e69;
    uint base = (index * 16u);
    int _e75 = signed_value.x;
    _group_0_binding_2_cs[base] = uint(_e75);
    int _e80 = changed.x;
    local_1 = uint((base + 1u));
    uint _e86 = local_1;
    _group_0_binding_2_cs[_e86] = uint(_e80);
    uint _e89 = unsigned_value.x;
    local_2 = uint((base + 2u));
    uint _e94 = local_2;
    _group_0_binding_2_cs[_e94] = _e89;
    float _e97 = floating.x;
    local_3 = uint((base + 3u));
    uint _e103 = local_3;
    _group_0_binding_2_cs[_e103] = floatBitsToUint(_e97);
    int16_t _e106 = signed_half.x;
    local_4 = uint((base + 4u));
    uint _e112 = local_4;
    _group_0_binding_2_cs[_e112] = uint(_e106);
    uint16_t _e115 = unsigned_half.x;
    local_5 = uint((base + 5u));
    uint _e121 = local_5;
    _group_0_binding_2_cs[_e121] = uint(_e115);
    float1_ _e123 = floating;
    uint _e124 = kind(_e123);
    local_6 = uint((base + 6u));
    uint _e129 = local_6;
    _group_0_binding_2_cs[_e129] = _e124;
    int1_ _e131 = signed_value;
    uint _e132 = kind_1(_e131);
    local_7 = uint((base + 7u));
    uint _e137 = local_7;
    _group_0_binding_2_cs[_e137] = _e132;
    uint1_ _e139 = unsigned_value;
    uint _e140 = kind_2(_e139);
    local_8 = uint((base + 8u));
    uint _e145 = local_8;
    _group_0_binding_2_cs[_e145] = _e140;
    short1_ _e147 = signed_half;
    uint _e148 = kind_3(_e147);
    local_9 = uint((base + 9u));
    uint _e153 = local_9;
    _group_0_binding_2_cs[_e153] = _e148;
    ushort1_ _e155 = unsigned_half;
    uint _e156 = kind_4(_e155);
    local_10 = uint((base + 10u));
    uint _e161 = local_10;
    _group_0_binding_2_cs[_e161] = _e156;
    float _e164 = floating.x;
    uint _e165 = kind_5(_e164);
    local_11 = uint((base + 11u));
    uint _e170 = local_11;
    _group_0_binding_2_cs[_e170] = _e165;
    int _e173 = signed_value.x;
    uint _e174 = kind_6(_e173);
    local_12 = uint((base + 12u));
    uint _e179 = local_12;
    _group_0_binding_2_cs[_e179] = _e174;
    uint _e182 = unsigned_value.x;
    uint _e183 = kind_7(_e182);
    local_13 = uint((base + 13u));
    uint _e188 = local_13;
    _group_0_binding_2_cs[_e188] = _e183;
    int16_t _e191 = signed_half.x;
    uint _e192 = kind_8(_e191);
    local_14 = uint((base + 14u));
    uint _e197 = local_14;
    _group_0_binding_2_cs[_e197] = _e192;
    uint16_t _e200 = unsigned_half.x;
    uint _e201 = kind_9(_e200);
    local_15 = uint((base + 15u));
    uint _e206 = local_15;
    _group_0_binding_2_cs[_e206] = _e201;
}

