#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
struct int3_ {
    int x;
    int y;
    int z;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
layout(std430) buffer type_9_block_0Compute { uint _group_0_binding_0_cs[]; };


vec2 operator_u002b(vec2 left, vec2 right) {
    vec2 left_1 = vec2(0.0);
    vec2 right_1 = vec2(0.0);
    left_1 = left;
    right_1 = right;
    float _e6 = left_1.x;
    float _e7 = right_1.x;
    float _e11 = left_1.y;
    float _e12 = right_1.y;
    return vec2((_e6 + _e7), (_e11 + _e12));
}

vec2 operator_u002b_1(vec2 left_2, float right_2) {
    vec2 left_3 = vec2(0.0);
    left_3 = left_2;
    float _e4 = left_3.x;
    float _e7 = left_3.y;
    return vec2((_e4 + right_2), (_e7 + right_2));
}

vec2 operator_u002b_2(float left_4, vec2 right_3) {
    vec2 right_4 = vec2(0.0);
    right_4 = right_3;
    float _e4 = right_4.x;
    float _e7 = right_4.y;
    return vec2((left_4 + _e4), (left_4 + _e7));
}

float3_ operator_u002b_3(float3_ left_5, float3_ right_5) {
    float3_ left_6 = float3_(0.0, 0.0, 0.0);
    float3_ right_6 = float3_(0.0, 0.0, 0.0);
    left_6 = left_5;
    right_6 = right_5;
    float _e6 = left_6.x;
    float _e7 = right_6.x;
    float _e11 = left_6.y;
    float _e12 = right_6.y;
    float _e16 = left_6.z;
    float _e17 = right_6.z;
    return float3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

float3_ operator_u002b_4(float3_ left_7, float right_7) {
    float3_ left_8 = float3_(0.0, 0.0, 0.0);
    left_8 = left_7;
    float _e4 = left_8.x;
    float _e7 = left_8.y;
    float _e10 = left_8.z;
    return float3_((_e4 + right_7), (_e7 + right_7), (_e10 + right_7));
}

float3_ operator_u002b_5(float left_9, float3_ right_8) {
    float3_ right_9 = float3_(0.0, 0.0, 0.0);
    right_9 = right_8;
    float _e4 = right_9.x;
    float _e7 = right_9.y;
    float _e10 = right_9.z;
    return float3_((left_9 + _e4), (left_9 + _e7), (left_9 + _e10));
}

vec4 operator_u002b_6(vec4 left_10, vec4 right_10) {
    vec4 left_11 = vec4(0.0);
    vec4 right_11 = vec4(0.0);
    left_11 = left_10;
    right_11 = right_10;
    float _e6 = left_11.x;
    float _e7 = right_11.x;
    float _e11 = left_11.y;
    float _e12 = right_11.y;
    float _e16 = left_11.z;
    float _e17 = right_11.z;
    float _e21 = left_11.w;
    float _e22 = right_11.w;
    return vec4((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

vec4 operator_u002b_7(vec4 left_12, float right_12) {
    vec4 left_13 = vec4(0.0);
    left_13 = left_12;
    float _e4 = left_13.x;
    float _e7 = left_13.y;
    float _e10 = left_13.z;
    float _e13 = left_13.w;
    return vec4((_e4 + right_12), (_e7 + right_12), (_e10 + right_12), (_e13 + right_12));
}

vec4 operator_u002b_8(float left_14, vec4 right_13) {
    vec4 right_14 = vec4(0.0);
    right_14 = right_13;
    float _e4 = right_14.x;
    float _e7 = right_14.y;
    float _e10 = right_14.z;
    float _e13 = right_14.w;
    return vec4((left_14 + _e4), (left_14 + _e7), (left_14 + _e10), (left_14 + _e13));
}

ivec2 operator_u002b_9(ivec2 left_15, ivec2 right_15) {
    ivec2 left_16 = ivec2(0);
    ivec2 right_16 = ivec2(0);
    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return ivec2((_e6 + _e7), (_e11 + _e12));
}

ivec2 operator_u002b_10(ivec2 left_17, int right_17) {
    ivec2 left_18 = ivec2(0);
    left_18 = left_17;
    int _e4 = left_18.x;
    int _e7 = left_18.y;
    return ivec2((_e4 + right_17), (_e7 + right_17));
}

ivec2 operator_u002b_11(int left_19, ivec2 right_18) {
    ivec2 right_19 = ivec2(0);
    right_19 = right_18;
    int _e4 = right_19.x;
    int _e7 = right_19.y;
    return ivec2((left_19 + _e4), (left_19 + _e7));
}

int3_ operator_u002b_12(int3_ left_20, int3_ right_20) {
    int3_ left_21 = int3_(0, 0, 0);
    int3_ right_21 = int3_(0, 0, 0);
    left_21 = left_20;
    right_21 = right_20;
    int _e6 = left_21.x;
    int _e7 = right_21.x;
    int _e11 = left_21.y;
    int _e12 = right_21.y;
    int _e16 = left_21.z;
    int _e17 = right_21.z;
    return int3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

int3_ operator_u002b_13(int3_ left_22, int right_22) {
    int3_ left_23 = int3_(0, 0, 0);
    left_23 = left_22;
    int _e4 = left_23.x;
    int _e7 = left_23.y;
    int _e10 = left_23.z;
    return int3_((_e4 + right_22), (_e7 + right_22), (_e10 + right_22));
}

int3_ operator_u002b_14(int left_24, int3_ right_23) {
    int3_ right_24 = int3_(0, 0, 0);
    right_24 = right_23;
    int _e4 = right_24.x;
    int _e7 = right_24.y;
    int _e10 = right_24.z;
    return int3_((left_24 + _e4), (left_24 + _e7), (left_24 + _e10));
}

ivec4 operator_u002b_15(ivec4 left_25, ivec4 right_25) {
    ivec4 left_26 = ivec4(0);
    ivec4 right_26 = ivec4(0);
    left_26 = left_25;
    right_26 = right_25;
    int _e6 = left_26.x;
    int _e7 = right_26.x;
    int _e11 = left_26.y;
    int _e12 = right_26.y;
    int _e16 = left_26.z;
    int _e17 = right_26.z;
    int _e21 = left_26.w;
    int _e22 = right_26.w;
    return ivec4((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

ivec4 operator_u002b_16(ivec4 left_27, int right_27) {
    ivec4 left_28 = ivec4(0);
    left_28 = left_27;
    int _e4 = left_28.x;
    int _e7 = left_28.y;
    int _e10 = left_28.z;
    int _e13 = left_28.w;
    return ivec4((_e4 + right_27), (_e7 + right_27), (_e10 + right_27), (_e13 + right_27));
}

ivec4 operator_u002b_17(int left_29, ivec4 right_28) {
    ivec4 right_29 = ivec4(0);
    right_29 = right_28;
    int _e4 = right_29.x;
    int _e7 = right_29.y;
    int _e10 = right_29.z;
    int _e13 = right_29.w;
    return ivec4((left_29 + _e4), (left_29 + _e7), (left_29 + _e10), (left_29 + _e13));
}

uvec2 operator_u002b_18(uvec2 left_30, uvec2 right_30) {
    uvec2 left_31 = uvec2(0u);
    uvec2 right_31 = uvec2(0u);
    left_31 = left_30;
    right_31 = right_30;
    uint _e6 = left_31.x;
    uint _e7 = right_31.x;
    uint _e11 = left_31.y;
    uint _e12 = right_31.y;
    return uvec2((_e6 + _e7), (_e11 + _e12));
}

uvec2 operator_u002b_19(uvec2 left_32, uint right_32) {
    uvec2 left_33 = uvec2(0u);
    left_33 = left_32;
    uint _e4 = left_33.x;
    uint _e7 = left_33.y;
    return uvec2((_e4 + right_32), (_e7 + right_32));
}

uvec2 operator_u002b_20(uint left_34, uvec2 right_33) {
    uvec2 right_34 = uvec2(0u);
    right_34 = right_33;
    uint _e4 = right_34.x;
    uint _e7 = right_34.y;
    return uvec2((left_34 + _e4), (left_34 + _e7));
}

uint3_ operator_u002b_21(uint3_ left_35, uint3_ right_35) {
    uint3_ left_36 = uint3_(0u, 0u, 0u);
    uint3_ right_36 = uint3_(0u, 0u, 0u);
    left_36 = left_35;
    right_36 = right_35;
    uint _e6 = left_36.x;
    uint _e7 = right_36.x;
    uint _e11 = left_36.y;
    uint _e12 = right_36.y;
    uint _e16 = left_36.z;
    uint _e17 = right_36.z;
    return uint3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

uint3_ operator_u002b_22(uint3_ left_37, uint right_37) {
    uint3_ left_38 = uint3_(0u, 0u, 0u);
    left_38 = left_37;
    uint _e4 = left_38.x;
    uint _e7 = left_38.y;
    uint _e10 = left_38.z;
    return uint3_((_e4 + right_37), (_e7 + right_37), (_e10 + right_37));
}

uint3_ operator_u002b_23(uint left_39, uint3_ right_38) {
    uint3_ right_39 = uint3_(0u, 0u, 0u);
    right_39 = right_38;
    uint _e4 = right_39.x;
    uint _e7 = right_39.y;
    uint _e10 = right_39.z;
    return uint3_((left_39 + _e4), (left_39 + _e7), (left_39 + _e10));
}

uvec4 operator_u002b_24(uvec4 left_40, uvec4 right_40) {
    uvec4 left_41 = uvec4(0u);
    uvec4 right_41 = uvec4(0u);
    left_41 = left_40;
    right_41 = right_40;
    uint _e6 = left_41.x;
    uint _e7 = right_41.x;
    uint _e11 = left_41.y;
    uint _e12 = right_41.y;
    uint _e16 = left_41.z;
    uint _e17 = right_41.z;
    uint _e21 = left_41.w;
    uint _e22 = right_41.w;
    return uvec4((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

uvec4 operator_u002b_25(uvec4 left_42, uint right_42) {
    uvec4 left_43 = uvec4(0u);
    left_43 = left_42;
    uint _e4 = left_43.x;
    uint _e7 = left_43.y;
    uint _e10 = left_43.z;
    uint _e13 = left_43.w;
    return uvec4((_e4 + right_42), (_e7 + right_42), (_e10 + right_42), (_e13 + right_42));
}

uvec4 operator_u002b_26(uint left_44, uvec4 right_43) {
    uvec4 right_44 = uvec4(0u);
    right_44 = right_43;
    uint _e4 = right_44.x;
    uint _e7 = right_44.y;
    uint _e10 = right_44.z;
    uint _e13 = right_44.w;
    return uvec4((left_44 + _e4), (left_44 + _e7), (left_44 + _e10), (left_44 + _e13));
}

void main() {
    vec2 float_2_left = vec2(0.0);
    vec2 float_2_right = vec2(0.0);
    vec2 float_2_vectors = vec2(0.0);
    vec2 float_2_vector_scalar = vec2(0.0);
    vec2 float_2_scalar_vector = vec2(0.0);
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    float3_ float_3_left = float3_(0.0, 0.0, 0.0);
    float3_ float_3_right = float3_(0.0, 0.0, 0.0);
    float3_ float_3_vectors = float3_(0.0, 0.0, 0.0);
    float3_ float_3_vector_scalar = float3_(0.0, 0.0, 0.0);
    float3_ float_3_scalar_vector = float3_(0.0, 0.0, 0.0);
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    vec4 float_4_left = vec4(0.0);
    vec4 float_4_right = vec4(0.0);
    vec4 float_4_vectors = vec4(0.0);
    vec4 float_4_vector_scalar = vec4(0.0);
    vec4 float_4_scalar_vector = vec4(0.0);
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    ivec2 int_2_left = ivec2(0);
    ivec2 int_2_right = ivec2(0);
    ivec2 int_2_vectors = ivec2(0);
    ivec2 int_2_vector_scalar = ivec2(0);
    ivec2 int_2_scalar_vector = ivec2(0);
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    int3_ int_3_left = int3_(0, 0, 0);
    int3_ int_3_right = int3_(0, 0, 0);
    int3_ int_3_vectors = int3_(0, 0, 0);
    int3_ int_3_vector_scalar = int3_(0, 0, 0);
    int3_ int_3_scalar_vector = int3_(0, 0, 0);
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    ivec4 int_4_left = ivec4(0);
    ivec4 int_4_right = ivec4(0);
    ivec4 int_4_vectors = ivec4(0);
    ivec4 int_4_vector_scalar = ivec4(0);
    ivec4 int_4_scalar_vector = ivec4(0);
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uvec2 uint_2_left = uvec2(0u);
    uvec2 uint_2_right = uvec2(0u);
    uvec2 uint_2_vectors = uvec2(0u);
    uvec2 uint_2_vector_scalar = uvec2(0u);
    uvec2 uint_2_scalar_vector = uvec2(0u);
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint3_ uint_3_left = uint3_(0u, 0u, 0u);
    uint3_ uint_3_right = uint3_(0u, 0u, 0u);
    uint3_ uint_3_vectors = uint3_(0u, 0u, 0u);
    uint3_ uint_3_vector_scalar = uint3_(0u, 0u, 0u);
    uint3_ uint_3_scalar_vector = uint3_(0u, 0u, 0u);
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uvec4 uint_4_left = uvec4(0u);
    uvec4 uint_4_right = uvec4(0u);
    uvec4 uint_4_vectors = uvec4(0u);
    uvec4 uint_4_vector_scalar = uvec4(0u);
    uvec4 uint_4_scalar_vector = uvec4(0u);
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    float_2_left = vec2(1.25, -(2.5));
    float_2_right = vec2(0.5, 1.5);
    vec2 _e9 = float_2_left;
    vec2 _e10 = float_2_right;
    vec2 _e11 = operator_u002b(_e9, _e10);
    float_2_vectors = _e11;
    vec2 _e13 = float_2_left;
    vec2 _e15 = operator_u002b_1(_e13, 2.0);
    float_2_vector_scalar = _e15;
    vec2 _e17 = float_2_right;
    vec2 _e19 = operator_u002b_2(2.0, _e17);
    float_2_scalar_vector = _e19;
    float _e22 = float_2_vectors.x;
    local = uint(0);
    uint _e27 = local;
    _group_0_binding_0_cs[_e27] = floatBitsToUint(_e22);
    float _e31 = float_2_vectors.y;
    local_1 = uint(1);
    uint _e36 = local_1;
    _group_0_binding_0_cs[_e36] = floatBitsToUint(_e31);
    float _e39 = float_2_vector_scalar.x;
    local_2 = uint(2);
    uint _e44 = local_2;
    _group_0_binding_0_cs[_e44] = floatBitsToUint(_e39);
    float _e47 = float_2_vector_scalar.y;
    local_3 = uint(3);
    uint _e52 = local_3;
    _group_0_binding_0_cs[_e52] = floatBitsToUint(_e47);
    float _e55 = float_2_scalar_vector.x;
    local_4 = uint(4);
    uint _e60 = local_4;
    _group_0_binding_0_cs[_e60] = floatBitsToUint(_e55);
    float _e63 = float_2_scalar_vector.y;
    local_5 = uint(5);
    uint _e68 = local_5;
    _group_0_binding_0_cs[_e68] = floatBitsToUint(_e63);
    float_3_left = float3_(1.25, -(2.5), 3.75);
    float_3_right = float3_(0.5, 1.5, -(2.0));
    float3_ _e82 = float_3_left;
    float3_ _e83 = float_3_right;
    float3_ _e84 = operator_u002b_3(_e82, _e83);
    float_3_vectors = _e84;
    float3_ _e86 = float_3_left;
    float3_ _e88 = operator_u002b_4(_e86, 2.0);
    float_3_vector_scalar = _e88;
    float3_ _e90 = float_3_right;
    float3_ _e92 = operator_u002b_5(2.0, _e90);
    float_3_scalar_vector = _e92;
    float _e95 = float_3_vectors.x;
    local_6 = uint(6);
    uint _e100 = local_6;
    _group_0_binding_0_cs[_e100] = floatBitsToUint(_e95);
    float _e103 = float_3_vectors.y;
    local_7 = uint(7);
    uint _e108 = local_7;
    _group_0_binding_0_cs[_e108] = floatBitsToUint(_e103);
    float _e111 = float_3_vectors.z;
    local_8 = uint(8);
    uint _e116 = local_8;
    _group_0_binding_0_cs[_e116] = floatBitsToUint(_e111);
    float _e119 = float_3_vector_scalar.x;
    local_9 = uint(9);
    uint _e124 = local_9;
    _group_0_binding_0_cs[_e124] = floatBitsToUint(_e119);
    float _e127 = float_3_vector_scalar.y;
    local_10 = uint(10);
    uint _e132 = local_10;
    _group_0_binding_0_cs[_e132] = floatBitsToUint(_e127);
    float _e135 = float_3_vector_scalar.z;
    local_11 = uint(11);
    uint _e140 = local_11;
    _group_0_binding_0_cs[_e140] = floatBitsToUint(_e135);
    float _e143 = float_3_scalar_vector.x;
    local_12 = uint(12);
    uint _e148 = local_12;
    _group_0_binding_0_cs[_e148] = floatBitsToUint(_e143);
    float _e151 = float_3_scalar_vector.y;
    local_13 = uint(13);
    uint _e156 = local_13;
    _group_0_binding_0_cs[_e156] = floatBitsToUint(_e151);
    float _e159 = float_3_scalar_vector.z;
    local_14 = uint(14);
    uint _e164 = local_14;
    _group_0_binding_0_cs[_e164] = floatBitsToUint(_e159);
    float_4_left = vec4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = vec4(0.5, 1.5, -(2.0), 0.25);
    vec4 _e181 = float_4_left;
    vec4 _e182 = float_4_right;
    vec4 _e183 = operator_u002b_6(_e181, _e182);
    float_4_vectors = _e183;
    vec4 _e185 = float_4_left;
    vec4 _e187 = operator_u002b_7(_e185, 2.0);
    float_4_vector_scalar = _e187;
    vec4 _e189 = float_4_right;
    vec4 _e191 = operator_u002b_8(2.0, _e189);
    float_4_scalar_vector = _e191;
    float _e194 = float_4_vectors.x;
    local_15 = uint(15);
    uint _e199 = local_15;
    _group_0_binding_0_cs[_e199] = floatBitsToUint(_e194);
    float _e202 = float_4_vectors.y;
    local_16 = uint(16);
    uint _e207 = local_16;
    _group_0_binding_0_cs[_e207] = floatBitsToUint(_e202);
    float _e210 = float_4_vectors.z;
    local_17 = uint(17);
    uint _e215 = local_17;
    _group_0_binding_0_cs[_e215] = floatBitsToUint(_e210);
    float _e218 = float_4_vectors.w;
    local_18 = uint(18);
    uint _e223 = local_18;
    _group_0_binding_0_cs[_e223] = floatBitsToUint(_e218);
    float _e226 = float_4_vector_scalar.x;
    local_19 = uint(19);
    uint _e231 = local_19;
    _group_0_binding_0_cs[_e231] = floatBitsToUint(_e226);
    float _e234 = float_4_vector_scalar.y;
    local_20 = uint(20);
    uint _e239 = local_20;
    _group_0_binding_0_cs[_e239] = floatBitsToUint(_e234);
    float _e242 = float_4_vector_scalar.z;
    local_21 = uint(21);
    uint _e247 = local_21;
    _group_0_binding_0_cs[_e247] = floatBitsToUint(_e242);
    float _e250 = float_4_vector_scalar.w;
    local_22 = uint(22);
    uint _e255 = local_22;
    _group_0_binding_0_cs[_e255] = floatBitsToUint(_e250);
    float _e258 = float_4_scalar_vector.x;
    local_23 = uint(23);
    uint _e263 = local_23;
    _group_0_binding_0_cs[_e263] = floatBitsToUint(_e258);
    float _e266 = float_4_scalar_vector.y;
    local_24 = uint(24);
    uint _e271 = local_24;
    _group_0_binding_0_cs[_e271] = floatBitsToUint(_e266);
    float _e274 = float_4_scalar_vector.z;
    local_25 = uint(25);
    uint _e279 = local_25;
    _group_0_binding_0_cs[_e279] = floatBitsToUint(_e274);
    float _e282 = float_4_scalar_vector.w;
    local_26 = uint(26);
    uint _e287 = local_26;
    _group_0_binding_0_cs[_e287] = floatBitsToUint(_e282);
    int_2_left = ivec2(1, -(2));
    int_2_right = ivec2(5, 6);
    ivec2 _e298 = int_2_left;
    ivec2 _e299 = int_2_right;
    ivec2 _e300 = operator_u002b_9(_e298, _e299);
    int_2_vectors = _e300;
    ivec2 _e302 = int_2_left;
    ivec2 _e304 = operator_u002b_10(_e302, 3);
    int_2_vector_scalar = _e304;
    ivec2 _e306 = int_2_right;
    ivec2 _e308 = operator_u002b_11(3, _e306);
    int_2_scalar_vector = _e308;
    int _e311 = int_2_vectors.x;
    local_27 = uint(27);
    uint _e316 = local_27;
    _group_0_binding_0_cs[_e316] = uint(_e311);
    int _e319 = int_2_vectors.y;
    local_28 = uint(28);
    uint _e324 = local_28;
    _group_0_binding_0_cs[_e324] = uint(_e319);
    int _e327 = int_2_vector_scalar.x;
    local_29 = uint(29);
    uint _e332 = local_29;
    _group_0_binding_0_cs[_e332] = uint(_e327);
    int _e335 = int_2_vector_scalar.y;
    local_30 = uint(30);
    uint _e340 = local_30;
    _group_0_binding_0_cs[_e340] = uint(_e335);
    int _e343 = int_2_scalar_vector.x;
    local_31 = uint(31);
    uint _e348 = local_31;
    _group_0_binding_0_cs[_e348] = uint(_e343);
    int _e351 = int_2_scalar_vector.y;
    local_32 = uint(32);
    uint _e356 = local_32;
    _group_0_binding_0_cs[_e356] = uint(_e351);
    int_3_left = int3_(1, -(2), 3);
    int_3_right = int3_(5, 6, -(7));
    int3_ _e370 = int_3_left;
    int3_ _e371 = int_3_right;
    int3_ _e372 = operator_u002b_12(_e370, _e371);
    int_3_vectors = _e372;
    int3_ _e374 = int_3_left;
    int3_ _e376 = operator_u002b_13(_e374, 3);
    int_3_vector_scalar = _e376;
    int3_ _e378 = int_3_right;
    int3_ _e380 = operator_u002b_14(3, _e378);
    int_3_scalar_vector = _e380;
    int _e383 = int_3_vectors.x;
    local_33 = uint(33);
    uint _e388 = local_33;
    _group_0_binding_0_cs[_e388] = uint(_e383);
    int _e391 = int_3_vectors.y;
    local_34 = uint(34);
    uint _e396 = local_34;
    _group_0_binding_0_cs[_e396] = uint(_e391);
    int _e399 = int_3_vectors.z;
    local_35 = uint(35);
    uint _e404 = local_35;
    _group_0_binding_0_cs[_e404] = uint(_e399);
    int _e407 = int_3_vector_scalar.x;
    local_36 = uint(36);
    uint _e412 = local_36;
    _group_0_binding_0_cs[_e412] = uint(_e407);
    int _e415 = int_3_vector_scalar.y;
    local_37 = uint(37);
    uint _e420 = local_37;
    _group_0_binding_0_cs[_e420] = uint(_e415);
    int _e423 = int_3_vector_scalar.z;
    local_38 = uint(38);
    uint _e428 = local_38;
    _group_0_binding_0_cs[_e428] = uint(_e423);
    int _e431 = int_3_scalar_vector.x;
    local_39 = uint(39);
    uint _e436 = local_39;
    _group_0_binding_0_cs[_e436] = uint(_e431);
    int _e439 = int_3_scalar_vector.y;
    local_40 = uint(40);
    uint _e444 = local_40;
    _group_0_binding_0_cs[_e444] = uint(_e439);
    int _e447 = int_3_scalar_vector.z;
    local_41 = uint(41);
    uint _e452 = local_41;
    _group_0_binding_0_cs[_e452] = uint(_e447);
    int_4_left = ivec4(1, -(2), 3, -(4));
    int_4_right = ivec4(5, 6, -(7), 8);
    ivec4 _e469 = int_4_left;
    ivec4 _e470 = int_4_right;
    ivec4 _e471 = operator_u002b_15(_e469, _e470);
    int_4_vectors = _e471;
    ivec4 _e473 = int_4_left;
    ivec4 _e475 = operator_u002b_16(_e473, 3);
    int_4_vector_scalar = _e475;
    ivec4 _e477 = int_4_right;
    ivec4 _e479 = operator_u002b_17(3, _e477);
    int_4_scalar_vector = _e479;
    int _e482 = int_4_vectors.x;
    local_42 = uint(42);
    uint _e487 = local_42;
    _group_0_binding_0_cs[_e487] = uint(_e482);
    int _e490 = int_4_vectors.y;
    local_43 = uint(43);
    uint _e495 = local_43;
    _group_0_binding_0_cs[_e495] = uint(_e490);
    int _e498 = int_4_vectors.z;
    local_44 = uint(44);
    uint _e503 = local_44;
    _group_0_binding_0_cs[_e503] = uint(_e498);
    int _e506 = int_4_vectors.w;
    local_45 = uint(45);
    uint _e511 = local_45;
    _group_0_binding_0_cs[_e511] = uint(_e506);
    int _e514 = int_4_vector_scalar.x;
    local_46 = uint(46);
    uint _e519 = local_46;
    _group_0_binding_0_cs[_e519] = uint(_e514);
    int _e522 = int_4_vector_scalar.y;
    local_47 = uint(47);
    uint _e527 = local_47;
    _group_0_binding_0_cs[_e527] = uint(_e522);
    int _e530 = int_4_vector_scalar.z;
    local_48 = uint(48);
    uint _e535 = local_48;
    _group_0_binding_0_cs[_e535] = uint(_e530);
    int _e538 = int_4_vector_scalar.w;
    local_49 = uint(49);
    uint _e543 = local_49;
    _group_0_binding_0_cs[_e543] = uint(_e538);
    int _e546 = int_4_scalar_vector.x;
    local_50 = uint(50);
    uint _e551 = local_50;
    _group_0_binding_0_cs[_e551] = uint(_e546);
    int _e554 = int_4_scalar_vector.y;
    local_51 = uint(51);
    uint _e559 = local_51;
    _group_0_binding_0_cs[_e559] = uint(_e554);
    int _e562 = int_4_scalar_vector.z;
    local_52 = uint(52);
    uint _e567 = local_52;
    _group_0_binding_0_cs[_e567] = uint(_e562);
    int _e570 = int_4_scalar_vector.w;
    local_53 = uint(53);
    uint _e575 = local_53;
    _group_0_binding_0_cs[_e575] = uint(_e570);
    uint_2_left = uvec2(4294967294u, 2147483649u);
    uint_2_right = uvec2(5u, 2u);
    uvec2 _e585 = uint_2_left;
    uvec2 _e586 = uint_2_right;
    uvec2 _e587 = operator_u002b_18(_e585, _e586);
    uint_2_vectors = _e587;
    uvec2 _e589 = uint_2_left;
    uvec2 _e591 = operator_u002b_19(_e589, 4u);
    uint_2_vector_scalar = _e591;
    uvec2 _e593 = uint_2_right;
    uvec2 _e595 = operator_u002b_20(4u, _e593);
    uint_2_scalar_vector = _e595;
    uint _e598 = uint_2_vectors.x;
    local_54 = uint(54);
    uint _e602 = local_54;
    _group_0_binding_0_cs[_e602] = _e598;
    uint _e605 = uint_2_vectors.y;
    local_55 = uint(55);
    uint _e609 = local_55;
    _group_0_binding_0_cs[_e609] = _e605;
    uint _e612 = uint_2_vector_scalar.x;
    local_56 = uint(56);
    uint _e616 = local_56;
    _group_0_binding_0_cs[_e616] = _e612;
    uint _e619 = uint_2_vector_scalar.y;
    local_57 = uint(57);
    uint _e623 = local_57;
    _group_0_binding_0_cs[_e623] = _e619;
    uint _e626 = uint_2_scalar_vector.x;
    local_58 = uint(58);
    uint _e630 = local_58;
    _group_0_binding_0_cs[_e630] = _e626;
    uint _e633 = uint_2_scalar_vector.y;
    local_59 = uint(59);
    uint _e637 = local_59;
    _group_0_binding_0_cs[_e637] = _e633;
    uint_3_left = uint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = uint3_(5u, 2u, 4294967293u);
    uint3_ _e649 = uint_3_left;
    uint3_ _e650 = uint_3_right;
    uint3_ _e651 = operator_u002b_21(_e649, _e650);
    uint_3_vectors = _e651;
    uint3_ _e653 = uint_3_left;
    uint3_ _e655 = operator_u002b_22(_e653, 4u);
    uint_3_vector_scalar = _e655;
    uint3_ _e657 = uint_3_right;
    uint3_ _e659 = operator_u002b_23(4u, _e657);
    uint_3_scalar_vector = _e659;
    uint _e662 = uint_3_vectors.x;
    local_60 = uint(60);
    uint _e666 = local_60;
    _group_0_binding_0_cs[_e666] = _e662;
    uint _e669 = uint_3_vectors.y;
    local_61 = uint(61);
    uint _e673 = local_61;
    _group_0_binding_0_cs[_e673] = _e669;
    uint _e676 = uint_3_vectors.z;
    local_62 = uint(62);
    uint _e680 = local_62;
    _group_0_binding_0_cs[_e680] = _e676;
    uint _e683 = uint_3_vector_scalar.x;
    local_63 = uint(63);
    uint _e687 = local_63;
    _group_0_binding_0_cs[_e687] = _e683;
    uint _e690 = uint_3_vector_scalar.y;
    local_64 = uint(64);
    uint _e694 = local_64;
    _group_0_binding_0_cs[_e694] = _e690;
    uint _e697 = uint_3_vector_scalar.z;
    local_65 = uint(65);
    uint _e701 = local_65;
    _group_0_binding_0_cs[_e701] = _e697;
    uint _e704 = uint_3_scalar_vector.x;
    local_66 = uint(66);
    uint _e708 = local_66;
    _group_0_binding_0_cs[_e708] = _e704;
    uint _e711 = uint_3_scalar_vector.y;
    local_67 = uint(67);
    uint _e715 = local_67;
    _group_0_binding_0_cs[_e715] = _e711;
    uint _e718 = uint_3_scalar_vector.z;
    local_68 = uint(68);
    uint _e722 = local_68;
    _group_0_binding_0_cs[_e722] = _e718;
    uint_4_left = uvec4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = uvec4(5u, 2u, 4294967293u, 1u);
    uvec4 _e736 = uint_4_left;
    uvec4 _e737 = uint_4_right;
    uvec4 _e738 = operator_u002b_24(_e736, _e737);
    uint_4_vectors = _e738;
    uvec4 _e740 = uint_4_left;
    uvec4 _e742 = operator_u002b_25(_e740, 4u);
    uint_4_vector_scalar = _e742;
    uvec4 _e744 = uint_4_right;
    uvec4 _e746 = operator_u002b_26(4u, _e744);
    uint_4_scalar_vector = _e746;
    uint _e749 = uint_4_vectors.x;
    local_69 = uint(69);
    uint _e753 = local_69;
    _group_0_binding_0_cs[_e753] = _e749;
    uint _e756 = uint_4_vectors.y;
    local_70 = uint(70);
    uint _e760 = local_70;
    _group_0_binding_0_cs[_e760] = _e756;
    uint _e763 = uint_4_vectors.z;
    local_71 = uint(71);
    uint _e767 = local_71;
    _group_0_binding_0_cs[_e767] = _e763;
    uint _e770 = uint_4_vectors.w;
    local_72 = uint(72);
    uint _e774 = local_72;
    _group_0_binding_0_cs[_e774] = _e770;
    uint _e777 = uint_4_vector_scalar.x;
    local_73 = uint(73);
    uint _e781 = local_73;
    _group_0_binding_0_cs[_e781] = _e777;
    uint _e784 = uint_4_vector_scalar.y;
    local_74 = uint(74);
    uint _e788 = local_74;
    _group_0_binding_0_cs[_e788] = _e784;
    uint _e791 = uint_4_vector_scalar.z;
    local_75 = uint(75);
    uint _e795 = local_75;
    _group_0_binding_0_cs[_e795] = _e791;
    uint _e798 = uint_4_vector_scalar.w;
    local_76 = uint(76);
    uint _e802 = local_76;
    _group_0_binding_0_cs[_e802] = _e798;
    uint _e805 = uint_4_scalar_vector.x;
    local_77 = uint(77);
    uint _e809 = local_77;
    _group_0_binding_0_cs[_e809] = _e805;
    uint _e812 = uint_4_scalar_vector.y;
    local_78 = uint(78);
    uint _e816 = local_78;
    _group_0_binding_0_cs[_e816] = _e812;
    uint _e819 = uint_4_scalar_vector.z;
    local_79 = uint(79);
    uint _e823 = local_79;
    _group_0_binding_0_cs[_e823] = _e819;
    uint _e826 = uint_4_scalar_vector.w;
    local_80 = uint(80);
    uint _e830 = local_80;
    _group_0_binding_0_cs[_e830] = _e826;
}

