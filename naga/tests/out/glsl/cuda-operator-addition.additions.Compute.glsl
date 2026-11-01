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
    float3_ float_3_left = float3_(0.0, 0.0, 0.0);
    float3_ float_3_right = float3_(0.0, 0.0, 0.0);
    float3_ float_3_vectors = float3_(0.0, 0.0, 0.0);
    float3_ float_3_vector_scalar = float3_(0.0, 0.0, 0.0);
    float3_ float_3_scalar_vector = float3_(0.0, 0.0, 0.0);
    vec4 float_4_left = vec4(0.0);
    vec4 float_4_right = vec4(0.0);
    vec4 float_4_vectors = vec4(0.0);
    vec4 float_4_vector_scalar = vec4(0.0);
    vec4 float_4_scalar_vector = vec4(0.0);
    ivec2 int_2_left = ivec2(0);
    ivec2 int_2_right = ivec2(0);
    ivec2 int_2_vectors = ivec2(0);
    ivec2 int_2_vector_scalar = ivec2(0);
    ivec2 int_2_scalar_vector = ivec2(0);
    int3_ int_3_left = int3_(0, 0, 0);
    int3_ int_3_right = int3_(0, 0, 0);
    int3_ int_3_vectors = int3_(0, 0, 0);
    int3_ int_3_vector_scalar = int3_(0, 0, 0);
    int3_ int_3_scalar_vector = int3_(0, 0, 0);
    ivec4 int_4_left = ivec4(0);
    ivec4 int_4_right = ivec4(0);
    ivec4 int_4_vectors = ivec4(0);
    ivec4 int_4_vector_scalar = ivec4(0);
    ivec4 int_4_scalar_vector = ivec4(0);
    uvec2 uint_2_left = uvec2(0u);
    uvec2 uint_2_right = uvec2(0u);
    uvec2 uint_2_vectors = uvec2(0u);
    uvec2 uint_2_vector_scalar = uvec2(0u);
    uvec2 uint_2_scalar_vector = uvec2(0u);
    uint3_ uint_3_left = uint3_(0u, 0u, 0u);
    uint3_ uint_3_right = uint3_(0u, 0u, 0u);
    uint3_ uint_3_vectors = uint3_(0u, 0u, 0u);
    uint3_ uint_3_vector_scalar = uint3_(0u, 0u, 0u);
    uint3_ uint_3_scalar_vector = uint3_(0u, 0u, 0u);
    uvec4 uint_4_left = uvec4(0u);
    uvec4 uint_4_right = uvec4(0u);
    uvec4 uint_4_vectors = uvec4(0u);
    uvec4 uint_4_vector_scalar = uvec4(0u);
    uvec4 uint_4_scalar_vector = uvec4(0u);
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
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(_e22);
    float _e29 = float_2_vectors.y;
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(_e29);
    float _e35 = float_2_vector_scalar.x;
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(_e35);
    float _e41 = float_2_vector_scalar.y;
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(_e41);
    float _e47 = float_2_scalar_vector.x;
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e47);
    float _e53 = float_2_scalar_vector.y;
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(_e53);
    float_3_left = float3_(1.25, -(2.5), 3.75);
    float_3_right = float3_(0.5, 1.5, -(2.0));
    float3_ _e70 = float_3_left;
    float3_ _e71 = float_3_right;
    float3_ _e72 = operator_u002b_3(_e70, _e71);
    float_3_vectors = _e72;
    float3_ _e74 = float_3_left;
    float3_ _e76 = operator_u002b_4(_e74, 2.0);
    float_3_vector_scalar = _e76;
    float3_ _e78 = float_3_right;
    float3_ _e80 = operator_u002b_5(2.0, _e78);
    float_3_scalar_vector = _e80;
    float _e83 = float_3_vectors.x;
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(_e83);
    float _e89 = float_3_vectors.y;
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(_e89);
    float _e95 = float_3_vectors.z;
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(_e95);
    float _e101 = float_3_vector_scalar.x;
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(_e101);
    float _e107 = float_3_vector_scalar.y;
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(_e107);
    float _e113 = float_3_vector_scalar.z;
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(_e113);
    float _e119 = float_3_scalar_vector.x;
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(_e119);
    float _e125 = float_3_scalar_vector.y;
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(_e125);
    float _e131 = float_3_scalar_vector.z;
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(_e131);
    float_4_left = vec4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = vec4(0.5, 1.5, -(2.0), 0.25);
    vec4 _e151 = float_4_left;
    vec4 _e152 = float_4_right;
    vec4 _e153 = operator_u002b_6(_e151, _e152);
    float_4_vectors = _e153;
    vec4 _e155 = float_4_left;
    vec4 _e157 = operator_u002b_7(_e155, 2.0);
    float_4_vector_scalar = _e157;
    vec4 _e159 = float_4_right;
    vec4 _e161 = operator_u002b_8(2.0, _e159);
    float_4_scalar_vector = _e161;
    float _e164 = float_4_vectors.x;
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(_e164);
    float _e170 = float_4_vectors.y;
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(_e170);
    float _e176 = float_4_vectors.z;
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(_e176);
    float _e182 = float_4_vectors.w;
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(_e182);
    float _e188 = float_4_vector_scalar.x;
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(_e188);
    float _e194 = float_4_vector_scalar.y;
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(_e194);
    float _e200 = float_4_vector_scalar.z;
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(_e200);
    float _e206 = float_4_vector_scalar.w;
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(_e206);
    float _e212 = float_4_scalar_vector.x;
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(_e212);
    float _e218 = float_4_scalar_vector.y;
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(_e218);
    float _e224 = float_4_scalar_vector.z;
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(_e224);
    float _e230 = float_4_scalar_vector.w;
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(_e230);
    int_2_left = ivec2(1, -(2));
    int_2_right = ivec2(5, 6);
    ivec2 _e244 = int_2_left;
    ivec2 _e245 = int_2_right;
    ivec2 _e246 = operator_u002b_9(_e244, _e245);
    int_2_vectors = _e246;
    ivec2 _e248 = int_2_left;
    ivec2 _e250 = operator_u002b_10(_e248, 3);
    int_2_vector_scalar = _e250;
    ivec2 _e252 = int_2_right;
    ivec2 _e254 = operator_u002b_11(3, _e252);
    int_2_scalar_vector = _e254;
    int _e257 = int_2_vectors.x;
    _group_0_binding_0_cs[uint(27)] = uint(_e257);
    int _e263 = int_2_vectors.y;
    _group_0_binding_0_cs[uint(28)] = uint(_e263);
    int _e269 = int_2_vector_scalar.x;
    _group_0_binding_0_cs[uint(29)] = uint(_e269);
    int _e275 = int_2_vector_scalar.y;
    _group_0_binding_0_cs[uint(30)] = uint(_e275);
    int _e281 = int_2_scalar_vector.x;
    _group_0_binding_0_cs[uint(31)] = uint(_e281);
    int _e287 = int_2_scalar_vector.y;
    _group_0_binding_0_cs[uint(32)] = uint(_e287);
    int_3_left = int3_(1, -(2), 3);
    int_3_right = int3_(5, 6, -(7));
    int3_ _e304 = int_3_left;
    int3_ _e305 = int_3_right;
    int3_ _e306 = operator_u002b_12(_e304, _e305);
    int_3_vectors = _e306;
    int3_ _e308 = int_3_left;
    int3_ _e310 = operator_u002b_13(_e308, 3);
    int_3_vector_scalar = _e310;
    int3_ _e312 = int_3_right;
    int3_ _e314 = operator_u002b_14(3, _e312);
    int_3_scalar_vector = _e314;
    int _e317 = int_3_vectors.x;
    _group_0_binding_0_cs[uint(33)] = uint(_e317);
    int _e323 = int_3_vectors.y;
    _group_0_binding_0_cs[uint(34)] = uint(_e323);
    int _e329 = int_3_vectors.z;
    _group_0_binding_0_cs[uint(35)] = uint(_e329);
    int _e335 = int_3_vector_scalar.x;
    _group_0_binding_0_cs[uint(36)] = uint(_e335);
    int _e341 = int_3_vector_scalar.y;
    _group_0_binding_0_cs[uint(37)] = uint(_e341);
    int _e347 = int_3_vector_scalar.z;
    _group_0_binding_0_cs[uint(38)] = uint(_e347);
    int _e353 = int_3_scalar_vector.x;
    _group_0_binding_0_cs[uint(39)] = uint(_e353);
    int _e359 = int_3_scalar_vector.y;
    _group_0_binding_0_cs[uint(40)] = uint(_e359);
    int _e365 = int_3_scalar_vector.z;
    _group_0_binding_0_cs[uint(41)] = uint(_e365);
    int_4_left = ivec4(1, -(2), 3, -(4));
    int_4_right = ivec4(5, 6, -(7), 8);
    ivec4 _e385 = int_4_left;
    ivec4 _e386 = int_4_right;
    ivec4 _e387 = operator_u002b_15(_e385, _e386);
    int_4_vectors = _e387;
    ivec4 _e389 = int_4_left;
    ivec4 _e391 = operator_u002b_16(_e389, 3);
    int_4_vector_scalar = _e391;
    ivec4 _e393 = int_4_right;
    ivec4 _e395 = operator_u002b_17(3, _e393);
    int_4_scalar_vector = _e395;
    int _e398 = int_4_vectors.x;
    _group_0_binding_0_cs[uint(42)] = uint(_e398);
    int _e404 = int_4_vectors.y;
    _group_0_binding_0_cs[uint(43)] = uint(_e404);
    int _e410 = int_4_vectors.z;
    _group_0_binding_0_cs[uint(44)] = uint(_e410);
    int _e416 = int_4_vectors.w;
    _group_0_binding_0_cs[uint(45)] = uint(_e416);
    int _e422 = int_4_vector_scalar.x;
    _group_0_binding_0_cs[uint(46)] = uint(_e422);
    int _e428 = int_4_vector_scalar.y;
    _group_0_binding_0_cs[uint(47)] = uint(_e428);
    int _e434 = int_4_vector_scalar.z;
    _group_0_binding_0_cs[uint(48)] = uint(_e434);
    int _e440 = int_4_vector_scalar.w;
    _group_0_binding_0_cs[uint(49)] = uint(_e440);
    int _e446 = int_4_scalar_vector.x;
    _group_0_binding_0_cs[uint(50)] = uint(_e446);
    int _e452 = int_4_scalar_vector.y;
    _group_0_binding_0_cs[uint(51)] = uint(_e452);
    int _e458 = int_4_scalar_vector.z;
    _group_0_binding_0_cs[uint(52)] = uint(_e458);
    int _e464 = int_4_scalar_vector.w;
    _group_0_binding_0_cs[uint(53)] = uint(_e464);
    uint_2_left = uvec2(4294967294u, 2147483649u);
    uint_2_right = uvec2(5u, 2u);
    uvec2 _e477 = uint_2_left;
    uvec2 _e478 = uint_2_right;
    uvec2 _e479 = operator_u002b_18(_e477, _e478);
    uint_2_vectors = _e479;
    uvec2 _e481 = uint_2_left;
    uvec2 _e483 = operator_u002b_19(_e481, 4u);
    uint_2_vector_scalar = _e483;
    uvec2 _e485 = uint_2_right;
    uvec2 _e487 = operator_u002b_20(4u, _e485);
    uint_2_scalar_vector = _e487;
    uint _e490 = uint_2_vectors.x;
    _group_0_binding_0_cs[uint(54)] = _e490;
    uint _e495 = uint_2_vectors.y;
    _group_0_binding_0_cs[uint(55)] = _e495;
    uint _e500 = uint_2_vector_scalar.x;
    _group_0_binding_0_cs[uint(56)] = _e500;
    uint _e505 = uint_2_vector_scalar.y;
    _group_0_binding_0_cs[uint(57)] = _e505;
    uint _e510 = uint_2_scalar_vector.x;
    _group_0_binding_0_cs[uint(58)] = _e510;
    uint _e515 = uint_2_scalar_vector.y;
    _group_0_binding_0_cs[uint(59)] = _e515;
    uint_3_left = uint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = uint3_(5u, 2u, 4294967293u);
    uint3_ _e529 = uint_3_left;
    uint3_ _e530 = uint_3_right;
    uint3_ _e531 = operator_u002b_21(_e529, _e530);
    uint_3_vectors = _e531;
    uint3_ _e533 = uint_3_left;
    uint3_ _e535 = operator_u002b_22(_e533, 4u);
    uint_3_vector_scalar = _e535;
    uint3_ _e537 = uint_3_right;
    uint3_ _e539 = operator_u002b_23(4u, _e537);
    uint_3_scalar_vector = _e539;
    uint _e542 = uint_3_vectors.x;
    _group_0_binding_0_cs[uint(60)] = _e542;
    uint _e547 = uint_3_vectors.y;
    _group_0_binding_0_cs[uint(61)] = _e547;
    uint _e552 = uint_3_vectors.z;
    _group_0_binding_0_cs[uint(62)] = _e552;
    uint _e557 = uint_3_vector_scalar.x;
    _group_0_binding_0_cs[uint(63)] = _e557;
    uint _e562 = uint_3_vector_scalar.y;
    _group_0_binding_0_cs[uint(64)] = _e562;
    uint _e567 = uint_3_vector_scalar.z;
    _group_0_binding_0_cs[uint(65)] = _e567;
    uint _e572 = uint_3_scalar_vector.x;
    _group_0_binding_0_cs[uint(66)] = _e572;
    uint _e577 = uint_3_scalar_vector.y;
    _group_0_binding_0_cs[uint(67)] = _e577;
    uint _e582 = uint_3_scalar_vector.z;
    _group_0_binding_0_cs[uint(68)] = _e582;
    uint_4_left = uvec4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = uvec4(5u, 2u, 4294967293u, 1u);
    uvec4 _e598 = uint_4_left;
    uvec4 _e599 = uint_4_right;
    uvec4 _e600 = operator_u002b_24(_e598, _e599);
    uint_4_vectors = _e600;
    uvec4 _e602 = uint_4_left;
    uvec4 _e604 = operator_u002b_25(_e602, 4u);
    uint_4_vector_scalar = _e604;
    uvec4 _e606 = uint_4_right;
    uvec4 _e608 = operator_u002b_26(4u, _e606);
    uint_4_scalar_vector = _e608;
    uint _e611 = uint_4_vectors.x;
    _group_0_binding_0_cs[uint(69)] = _e611;
    uint _e616 = uint_4_vectors.y;
    _group_0_binding_0_cs[uint(70)] = _e616;
    uint _e621 = uint_4_vectors.z;
    _group_0_binding_0_cs[uint(71)] = _e621;
    uint _e626 = uint_4_vectors.w;
    _group_0_binding_0_cs[uint(72)] = _e626;
    uint _e631 = uint_4_vector_scalar.x;
    _group_0_binding_0_cs[uint(73)] = _e631;
    uint _e636 = uint_4_vector_scalar.y;
    _group_0_binding_0_cs[uint(74)] = _e636;
    uint _e641 = uint_4_vector_scalar.z;
    _group_0_binding_0_cs[uint(75)] = _e641;
    uint _e646 = uint_4_vector_scalar.w;
    _group_0_binding_0_cs[uint(76)] = _e646;
    uint _e651 = uint_4_scalar_vector.x;
    _group_0_binding_0_cs[uint(77)] = _e651;
    uint _e656 = uint_4_scalar_vector.y;
    _group_0_binding_0_cs[uint(78)] = _e656;
    uint _e661 = uint_4_scalar_vector.z;
    _group_0_binding_0_cs[uint(79)] = _e661;
    uint _e666 = uint_4_scalar_vector.w;
    _group_0_binding_0_cs[uint(80)] = _e666;
}

