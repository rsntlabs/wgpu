#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct Record_cuda_record_0_ {
    int16_t signed_value;
    uint16_t unsigned_value;
    uint wide;
    int16_t tail;
    uint16_t tag;
};
struct type_6 {
    uint16_t value;
};
layout(std430) readonly buffer type_4_block_0Compute { Record_cuda_record_0_ _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { Record_cuda_record_0_ _group_0_binding_1_cs[]; };

layout(std430) buffer type_5_block_2Compute { uint _group_0_binding_2_cs[]; };

layout(std140) uniform type_6_block_3Compute { type_6 _group_0_binding_3_cs; };


int promoted(int value) {
    return 31;
}

int exact(int16_t value_1) {
    return 41;
}

int exact_1(uint16_t value_2) {
    return 43;
}

int16_t identity_short(int16_t value_3) {
    return value_3;
}

uint16_t identity_unsigned_u0020_short(uint16_t value_4) {
    return value_4;
}

int signed_type_u002d_1_() {
    int _e1 = exact(int16_t(-1));
    return _e1;
}

int unsigned_type_65535u() {
    int _e1 = exact_1(uint16_t(65535));
    return _e1;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    Record_cuda_record_0_ original = Record_cuda_record_0_(int16_t(0), uint16_t(0), 0u, int16_t(0), uint16_t(0));
    Record_cuda_record_0_ result = Record_cuda_record_0_(int16_t(0), uint16_t(0), 0u, int16_t(0), uint16_t(0));
    int16_t signed_value = int16_t(0);
    uint16_t unsigned_value = uint16_t(0);
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
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    int16_t local_16 = int16_t(0);
    Record_cuda_record_0_ local_17 = Record_cuda_record_0_(int16_t(0), uint16_t(0), 0u, int16_t(0), uint16_t(0));
    Record_cuda_record_0_ local_18 = Record_cuda_record_0_(int16_t(0), uint16_t(0), 0u, int16_t(0), uint16_t(0));
    uint16_t count_1 = _group_0_binding_3_cs.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= uint(count_1))) {
        return;
    }
    Record_cuda_record_0_ _e14 = _group_0_binding_0_cs[index];
    local_18 = _e14;
    Record_cuda_record_0_ _e16 = local_18;
    local_17 = _e16;
    Record_cuda_record_0_ _e18 = local_17;
    original = _e18;
    Record_cuda_record_0_ _e20 = original;
    result = _e20;
    uint16_t _e24 = original.unsigned_value;
    uint16_t _e26 = original.unsigned_value;
    int promoted_sum = (int(_e24) + int(_e26));
    int16_t _e30 = original.signed_value;
    int16_t _e31 = identity_short(_e30);
    signed_value = _e31;
    uint16_t _e34 = original.unsigned_value;
    uint16_t _e35 = identity_unsigned_u0020_short(_e34);
    unsigned_value = _e35;
    int16_t _e37 = signed_value;
    signed_value = int16_t((int(_e37) + 3));
    int16_t _e45 = signed_value;
    signed_value = int16_t((int(_e45) / int(int16_t(-(1)))));
    uint16_t _e52 = unsigned_value;
    unsigned_value = uint16_t((int(_e52) + int(uint16_t(1))));
    uint16_t _e57 = unsigned_value;
    local = uint(1);
    uint _e62 = local;
    unsigned_value = uint16_t((int(_e57) << _e62));
    int16_t _e65 = signed_value;
    result.signed_value = int16_t(float(_e65));
    uint16_t _e69 = unsigned_value;
    result.unsigned_value = uint16_t(float(_e69));
    result.wide = uint(promoted_sum);
    int16_t _e76 = original.tail;
    result.tail = int16_t(~(int(_e76)));
    uint16_t _e82 = original.tag;
    result.tag = uint16_t((int(_e82) + 1));
    Record_cuda_record_0_ _e88 = result;
    _group_0_binding_1_cs[index] = _e88;
    uint base = (index * 16u);
    _group_0_binding_2_cs[base] = uint(promoted_sum);
    uint16_t _e97 = original.unsigned_value;
    int _e99 = promoted(int(_e97));
    local_1 = uint((base + 1u));
    uint _e105 = local_1;
    _group_0_binding_2_cs[_e105] = uint(_e99);
    int16_t _e108 = original.signed_value;
    int _e109 = exact(_e108);
    local_2 = uint((base + 2u));
    uint _e115 = local_2;
    _group_0_binding_2_cs[_e115] = uint(_e109);
    uint16_t _e118 = original.unsigned_value;
    int _e119 = exact_1(_e118);
    local_3 = uint((base + 3u));
    uint _e125 = local_3;
    _group_0_binding_2_cs[_e125] = uint(_e119);
    int _e127 = signed_type_u002d_1_();
    local_4 = uint((base + 4u));
    uint _e133 = local_4;
    _group_0_binding_2_cs[_e133] = uint(_e127);
    int _e135 = unsigned_type_65535u();
    local_5 = uint((base + 5u));
    uint _e141 = local_5;
    _group_0_binding_2_cs[_e141] = uint(_e135);
    uint16_t _e144 = original.unsigned_value;
    local_6 = uint((base + 6u));
    uint _e151 = local_6;
    _group_0_binding_2_cs[_e151] = uint(int(_e144));
    uint16_t _e154 = original.unsigned_value;
    local_7 = uint((base + 7u));
    uint _e162 = local_7;
    _group_0_binding_2_cs[_e162] = uint(-(int(_e154)));
    uint16_t _e165 = original.unsigned_value;
    local_8 = uint((base + 8u));
    uint _e173 = local_8;
    _group_0_binding_2_cs[_e173] = uint(~(int(_e165)));
    local_9 = uint((base + 9u));
    uint _e189 = local_9;
    _group_0_binding_2_cs[_e189] = uint((int(int16_t(-(32768))) / int(int16_t(-(1)))));
    int16_t _e193 = original.signed_value;
    uint16_t _e195 = original.unsigned_value;
    local_10 = uint((base + 10u));
    uint _e203 = local_10;
    _group_0_binding_2_cs[_e203] = uint((int(_e193) < int(_e195)));
    int16_t _e206 = original.signed_value;
    local_11 = uint((base + 11u));
    uint _e215 = local_11;
    _group_0_binding_2_cs[_e215] = uint((uint(_e206) < 1u));
    int16_t _e218 = result.signed_value;
    local_12 = uint((base + 12u));
    uint _e224 = local_12;
    _group_0_binding_2_cs[_e224] = uint(_e218);
    uint16_t _e227 = result.unsigned_value;
    local_13 = uint((base + 13u));
    uint _e233 = local_13;
    _group_0_binding_2_cs[_e233] = uint(_e227);
    int16_t _e236 = original.tail;
    local_14 = uint((base + 14u));
    uint _e242 = local_14;
    _group_0_binding_2_cs[_e242] = uint(_e236);
    if (((index & 1u) != 0u)) {
        int16_t _e249 = original.signed_value;
        local_16 = _e249;
    } else {
        int16_t _e252 = result.tail;
        local_16 = _e252;
    }
    int16_t _e255 = local_16;
    int _e256 = exact(_e255);
    local_15 = uint((base + 15u));
    uint _e262 = local_15;
    _group_0_binding_2_cs[_e262] = uint(_e256);
}

