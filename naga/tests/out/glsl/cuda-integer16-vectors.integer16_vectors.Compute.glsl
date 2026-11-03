#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct short3_ {
    int16_t x;
    int16_t y;
    int16_t z;
};
struct type_6 {
    uint16_t value;
};
struct ushort3_ {
    uint16_t x;
    uint16_t y;
    uint16_t z;
};
layout(std430) readonly buffer type_4_block_0Compute { short3_ _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { short3_ _group_0_binding_1_cs[]; };

layout(std430) buffer type_5_block_2Compute { uint _group_0_binding_2_cs[]; };

layout(std140) uniform type_6_block_3Compute { type_6 _group_0_binding_3_cs; };


uint promoted(int value) {
    return 31u;
}

uint field_kind(uint16_t value_1) {
    return 43u;
}

short3_ identity_short3_(short3_ value_2) {
    short3_ value_3 = short3_(int16_t(0), int16_t(0), int16_t(0));
    value_3 = value_2;
    short3_ _e2 = value_3;
    return _e2;
}

u16vec4 identity_ushort4_(u16vec4 value_4) {
    u16vec4 value_5 = u16vec4(0u);
    value_5 = value_4;
    u16vec4 _e2 = value_5;
    return _e2;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    short3_ signed_triple = short3_(int16_t(0), int16_t(0), int16_t(0));
    i16vec2 signed_pair = i16vec2(0);
    i16vec4 signed_quad = i16vec4(0);
    i16vec4 copied_quad = i16vec4(0);
    u16vec2 unsigned_pair = u16vec2(0u);
    ushort3_ unsigned_triple = ushort3_(uint16_t(0), uint16_t(0), uint16_t(0));
    u16vec4 unsigned_quad = u16vec4(0u);
    short3_ local = short3_(int16_t(0), int16_t(0), int16_t(0));
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
    short3_ local_16 = short3_(int16_t(0), int16_t(0), int16_t(0));
    short3_ result = short3_(int16_t(0), int16_t(0), int16_t(0));
    short3_ local_17 = short3_(int16_t(0), int16_t(0), int16_t(0));
    short3_ local_18 = short3_(int16_t(0), int16_t(0), int16_t(0));
    uint16_t count_1 = _group_0_binding_3_cs.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= uint(count_1))) {
        return;
    }
    short3_ _e14 = _group_0_binding_0_cs[index];
    local_18 = _e14;
    short3_ _e16 = local_18;
    local_16 = _e16;
    short3_ _e18 = local_16;
    short3_ _e19 = identity_short3_(_e18);
    signed_triple = _e19;
    int16_t _e22 = signed_triple.x;
    int16_t _e24 = signed_triple.y;
    signed_pair = i16vec2(_e22, _e24);
    int16_t _e28 = signed_triple.x;
    int16_t _e30 = signed_triple.y;
    int16_t _e32 = signed_triple.z;
    signed_quad = i16vec4(_e28, _e30, _e32, int16_t(7));
    i16vec4 _e37 = signed_quad;
    copied_quad = _e37;
    int16_t _e40 = signed_triple.x;
    int16_t _e42 = copied_quad.w;
    copied_quad.w = int16_t((int(_e42) + int(_e40)));
    int16_t _e48 = signed_triple.x;
    int16_t _e50 = signed_triple.y;
    unsigned_pair = u16vec2(uint16_t(_e48), uint16_t(_e50));
    uint16_t _e56 = unsigned_pair.x;
    unsigned_pair.x = uint16_t((int(_e56) + 1));
    uint16_t _e62 = unsigned_pair.y;
    unsigned_pair.y = uint16_t((int(_e62) + 1));
    int16_t _e68 = signed_triple.x;
    int16_t _e70 = signed_triple.y;
    int16_t _e72 = signed_triple.z;
    unsigned_triple = ushort3_(uint16_t(_e68), uint16_t(_e70), uint16_t(_e72));
    int16_t _e79 = signed_triple.z;
    int16_t _e81 = signed_triple.y;
    int16_t _e83 = signed_triple.x;
    u16vec4 _e90 = identity_ushort4_(u16vec4(uint16_t(_e79), uint16_t(_e81), uint16_t(_e83), uint16_t(65535u)));
    unsigned_quad = _e90;
    uint16_t _e93 = unsigned_quad.w;
    unsigned_quad.w = uint16_t((int(_e93) + 2));
    result = short3_(int16_t(0), int16_t(0), int16_t(0));
    short3_ _e100 = signed_triple;
    local_17 = _e100;
    short3_ _e102 = local_17;
    result = _e102;
    int16_t _e105 = result.x;
    result.x = int16_t((int(_e105) + 3));
    int16_t _e111 = result.y;
    result.y = int16_t(-(int(_e111)));
    int16_t _e117 = result.z;
    result.z = int16_t((int(_e117) ^ 4951));
    short3_ _e122 = result;
    local = _e122;
    short3_ _e124 = local;
    _group_0_binding_1_cs[index] = _e124;
    uint base = (index * 16u);
    int16_t _e130 = signed_pair.x;
    _group_0_binding_2_cs[base] = uint(_e130);
    int16_t _e135 = signed_pair.y;
    local_1 = uint((base + 1u));
    uint _e141 = local_1;
    _group_0_binding_2_cs[_e141] = uint(_e135);
    int16_t _e144 = copied_quad.x;
    local_2 = uint((base + 2u));
    uint _e150 = local_2;
    _group_0_binding_2_cs[_e150] = uint(_e144);
    int16_t _e153 = copied_quad.y;
    local_3 = uint((base + 3u));
    uint _e159 = local_3;
    _group_0_binding_2_cs[_e159] = uint(_e153);
    int16_t _e162 = copied_quad.z;
    local_4 = uint((base + 4u));
    uint _e168 = local_4;
    _group_0_binding_2_cs[_e168] = uint(_e162);
    int16_t _e171 = copied_quad.w;
    local_5 = uint((base + 5u));
    uint _e177 = local_5;
    _group_0_binding_2_cs[_e177] = uint(_e171);
    uint16_t _e180 = unsigned_pair.x;
    local_6 = uint((base + 6u));
    uint _e186 = local_6;
    _group_0_binding_2_cs[_e186] = uint(_e180);
    uint16_t _e189 = unsigned_pair.y;
    local_7 = uint((base + 7u));
    uint _e195 = local_7;
    _group_0_binding_2_cs[_e195] = uint(_e189);
    uint16_t _e199 = unsigned_triple.y;
    uint16_t _e203 = unsigned_triple.x;
    local_8 = uint((base + 8u));
    uint _e211 = local_8;
    _group_0_binding_2_cs[_e211] = uint((int(_e203) + (3 * int(_e199))));
    uint16_t _e214 = unsigned_triple.z;
    local_9 = uint((base + 9u));
    uint _e220 = local_9;
    _group_0_binding_2_cs[_e220] = uint(_e214);
    uint16_t _e223 = unsigned_quad.x;
    local_10 = uint((base + 10u));
    uint _e229 = local_10;
    _group_0_binding_2_cs[_e229] = uint(_e223);
    uint16_t _e232 = unsigned_quad.y;
    local_11 = uint((base + 11u));
    uint _e238 = local_11;
    _group_0_binding_2_cs[_e238] = uint(_e232);
    uint16_t _e241 = unsigned_quad.z;
    local_12 = uint((base + 12u));
    uint _e247 = local_12;
    _group_0_binding_2_cs[_e247] = uint(_e241);
    uint16_t _e250 = unsigned_quad.w;
    local_13 = uint((base + 13u));
    uint _e256 = local_13;
    _group_0_binding_2_cs[_e256] = uint(_e250);
    uint16_t _e259 = unsigned_triple.x;
    uint _e261 = promoted(int(_e259));
    local_14 = uint((base + 14u));
    uint _e266 = local_14;
    _group_0_binding_2_cs[_e266] = _e261;
    uint16_t _e269 = unsigned_triple.z;
    uint _e270 = field_kind(_e269);
    local_15 = uint((base + 15u));
    uint _e275 = local_15;
    _group_0_binding_2_cs[_e275] = _e270;
}

