// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

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
typedef uint type_9[1];

metal::float2 operator_u002b(
    metal::float2 left,
    metal::float2 right
) {
    metal::float2 left_1 = {};
    metal::float2 right_1 = {};
    left_1 = left;
    right_1 = right;
    float _e6 = left_1.x;
    float _e7 = right_1.x;
    float _e11 = left_1.y;
    float _e12 = right_1.y;
    return metal::float2(_e6 + _e7, _e11 + _e12);
}

metal::float2 operator_u002b_1(
    metal::float2 left_2,
    float right_2
) {
    metal::float2 left_3 = {};
    left_3 = left_2;
    float _e4 = left_3.x;
    float _e7 = left_3.y;
    return metal::float2(_e4 + right_2, _e7 + right_2);
}

metal::float2 operator_u002b_2(
    float left_4,
    metal::float2 right_3
) {
    metal::float2 right_4 = {};
    right_4 = right_3;
    float _e4 = right_4.x;
    float _e7 = right_4.y;
    return metal::float2(left_4 + _e4, left_4 + _e7);
}

float3_ operator_u002b_3(
    float3_ left_5,
    float3_ right_5
) {
    float3_ left_6 = {};
    float3_ right_6 = {};
    left_6 = left_5;
    right_6 = right_5;
    float _e6 = left_6.x;
    float _e7 = right_6.x;
    float _e11 = left_6.y;
    float _e12 = right_6.y;
    float _e16 = left_6.z;
    float _e17 = right_6.z;
    return float3_ {_e6 + _e7, _e11 + _e12, _e16 + _e17};
}

float3_ operator_u002b_4(
    float3_ left_7,
    float right_7
) {
    float3_ left_8 = {};
    left_8 = left_7;
    float _e4 = left_8.x;
    float _e7 = left_8.y;
    float _e10 = left_8.z;
    return float3_ {_e4 + right_7, _e7 + right_7, _e10 + right_7};
}

float3_ operator_u002b_5(
    float left_9,
    float3_ right_8
) {
    float3_ right_9 = {};
    right_9 = right_8;
    float _e4 = right_9.x;
    float _e7 = right_9.y;
    float _e10 = right_9.z;
    return float3_ {left_9 + _e4, left_9 + _e7, left_9 + _e10};
}

metal::float4 operator_u002b_6(
    metal::float4 left_10,
    metal::float4 right_10
) {
    metal::float4 left_11 = {};
    metal::float4 right_11 = {};
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
    return metal::float4(_e6 + _e7, _e11 + _e12, _e16 + _e17, _e21 + _e22);
}

metal::float4 operator_u002b_7(
    metal::float4 left_12,
    float right_12
) {
    metal::float4 left_13 = {};
    left_13 = left_12;
    float _e4 = left_13.x;
    float _e7 = left_13.y;
    float _e10 = left_13.z;
    float _e13 = left_13.w;
    return metal::float4(_e4 + right_12, _e7 + right_12, _e10 + right_12, _e13 + right_12);
}

metal::float4 operator_u002b_8(
    float left_14,
    metal::float4 right_13
) {
    metal::float4 right_14 = {};
    right_14 = right_13;
    float _e4 = right_14.x;
    float _e7 = right_14.y;
    float _e10 = right_14.z;
    float _e13 = right_14.w;
    return metal::float4(left_14 + _e4, left_14 + _e7, left_14 + _e10, left_14 + _e13);
}

metal::int2 operator_u002b_9(
    metal::int2 left_15,
    metal::int2 right_15
) {
    metal::int2 left_16 = {};
    metal::int2 right_16 = {};
    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12)));
}

metal::int2 operator_u002b_10(
    metal::int2 left_17,
    int right_17
) {
    metal::int2 left_18 = {};
    left_18 = left_17;
    int _e4 = left_18.x;
    int _e7 = left_18.y;
    return metal::int2(as_type<int>(as_type<uint>(_e4) + as_type<uint>(right_17)), as_type<int>(as_type<uint>(_e7) + as_type<uint>(right_17)));
}

metal::int2 operator_u002b_11(
    int left_19,
    metal::int2 right_18
) {
    metal::int2 right_19 = {};
    right_19 = right_18;
    int _e4 = right_19.x;
    int _e7 = right_19.y;
    return metal::int2(as_type<int>(as_type<uint>(left_19) + as_type<uint>(_e4)), as_type<int>(as_type<uint>(left_19) + as_type<uint>(_e7)));
}

int3_ operator_u002b_12(
    int3_ left_20,
    int3_ right_20
) {
    int3_ left_21 = {};
    int3_ right_21 = {};
    left_21 = left_20;
    right_21 = right_20;
    int _e6 = left_21.x;
    int _e7 = right_21.x;
    int _e11 = left_21.y;
    int _e12 = right_21.y;
    int _e16 = left_21.z;
    int _e17 = right_21.z;
    return int3_ {as_type<int>(as_type<uint>(_e6) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12)), as_type<int>(as_type<uint>(_e16) + as_type<uint>(_e17))};
}

int3_ operator_u002b_13(
    int3_ left_22,
    int right_22
) {
    int3_ left_23 = {};
    left_23 = left_22;
    int _e4 = left_23.x;
    int _e7 = left_23.y;
    int _e10 = left_23.z;
    return int3_ {as_type<int>(as_type<uint>(_e4) + as_type<uint>(right_22)), as_type<int>(as_type<uint>(_e7) + as_type<uint>(right_22)), as_type<int>(as_type<uint>(_e10) + as_type<uint>(right_22))};
}

int3_ operator_u002b_14(
    int left_24,
    int3_ right_23
) {
    int3_ right_24 = {};
    right_24 = right_23;
    int _e4 = right_24.x;
    int _e7 = right_24.y;
    int _e10 = right_24.z;
    return int3_ {as_type<int>(as_type<uint>(left_24) + as_type<uint>(_e4)), as_type<int>(as_type<uint>(left_24) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(left_24) + as_type<uint>(_e10))};
}

metal::int4 operator_u002b_15(
    metal::int4 left_25,
    metal::int4 right_25
) {
    metal::int4 left_26 = {};
    metal::int4 right_26 = {};
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
    return metal::int4(as_type<int>(as_type<uint>(_e6) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12)), as_type<int>(as_type<uint>(_e16) + as_type<uint>(_e17)), as_type<int>(as_type<uint>(_e21) + as_type<uint>(_e22)));
}

metal::int4 operator_u002b_16(
    metal::int4 left_27,
    int right_27
) {
    metal::int4 left_28 = {};
    left_28 = left_27;
    int _e4 = left_28.x;
    int _e7 = left_28.y;
    int _e10 = left_28.z;
    int _e13 = left_28.w;
    return metal::int4(as_type<int>(as_type<uint>(_e4) + as_type<uint>(right_27)), as_type<int>(as_type<uint>(_e7) + as_type<uint>(right_27)), as_type<int>(as_type<uint>(_e10) + as_type<uint>(right_27)), as_type<int>(as_type<uint>(_e13) + as_type<uint>(right_27)));
}

metal::int4 operator_u002b_17(
    int left_29,
    metal::int4 right_28
) {
    metal::int4 right_29 = {};
    right_29 = right_28;
    int _e4 = right_29.x;
    int _e7 = right_29.y;
    int _e10 = right_29.z;
    int _e13 = right_29.w;
    return metal::int4(as_type<int>(as_type<uint>(left_29) + as_type<uint>(_e4)), as_type<int>(as_type<uint>(left_29) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(left_29) + as_type<uint>(_e10)), as_type<int>(as_type<uint>(left_29) + as_type<uint>(_e13)));
}

metal::uint2 operator_u002b_18(
    metal::uint2 left_30,
    metal::uint2 right_30
) {
    metal::uint2 left_31 = {};
    metal::uint2 right_31 = {};
    left_31 = left_30;
    right_31 = right_30;
    uint _e6 = left_31.x;
    uint _e7 = right_31.x;
    uint _e11 = left_31.y;
    uint _e12 = right_31.y;
    return metal::uint2(_e6 + _e7, _e11 + _e12);
}

metal::uint2 operator_u002b_19(
    metal::uint2 left_32,
    uint right_32
) {
    metal::uint2 left_33 = {};
    left_33 = left_32;
    uint _e4 = left_33.x;
    uint _e7 = left_33.y;
    return metal::uint2(_e4 + right_32, _e7 + right_32);
}

metal::uint2 operator_u002b_20(
    uint left_34,
    metal::uint2 right_33
) {
    metal::uint2 right_34 = {};
    right_34 = right_33;
    uint _e4 = right_34.x;
    uint _e7 = right_34.y;
    return metal::uint2(left_34 + _e4, left_34 + _e7);
}

uint3_ operator_u002b_21(
    uint3_ left_35,
    uint3_ right_35
) {
    uint3_ left_36 = {};
    uint3_ right_36 = {};
    left_36 = left_35;
    right_36 = right_35;
    uint _e6 = left_36.x;
    uint _e7 = right_36.x;
    uint _e11 = left_36.y;
    uint _e12 = right_36.y;
    uint _e16 = left_36.z;
    uint _e17 = right_36.z;
    return uint3_ {_e6 + _e7, _e11 + _e12, _e16 + _e17};
}

uint3_ operator_u002b_22(
    uint3_ left_37,
    uint right_37
) {
    uint3_ left_38 = {};
    left_38 = left_37;
    uint _e4 = left_38.x;
    uint _e7 = left_38.y;
    uint _e10 = left_38.z;
    return uint3_ {_e4 + right_37, _e7 + right_37, _e10 + right_37};
}

uint3_ operator_u002b_23(
    uint left_39,
    uint3_ right_38
) {
    uint3_ right_39 = {};
    right_39 = right_38;
    uint _e4 = right_39.x;
    uint _e7 = right_39.y;
    uint _e10 = right_39.z;
    return uint3_ {left_39 + _e4, left_39 + _e7, left_39 + _e10};
}

metal::uint4 operator_u002b_24(
    metal::uint4 left_40,
    metal::uint4 right_40
) {
    metal::uint4 left_41 = {};
    metal::uint4 right_41 = {};
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
    return metal::uint4(_e6 + _e7, _e11 + _e12, _e16 + _e17, _e21 + _e22);
}

metal::uint4 operator_u002b_25(
    metal::uint4 left_42,
    uint right_42
) {
    metal::uint4 left_43 = {};
    left_43 = left_42;
    uint _e4 = left_43.x;
    uint _e7 = left_43.y;
    uint _e10 = left_43.z;
    uint _e13 = left_43.w;
    return metal::uint4(_e4 + right_42, _e7 + right_42, _e10 + right_42, _e13 + right_42);
}

metal::uint4 operator_u002b_26(
    uint left_44,
    metal::uint4 right_43
) {
    metal::uint4 right_44 = {};
    right_44 = right_43;
    uint _e4 = right_44.x;
    uint _e7 = right_44.y;
    uint _e10 = right_44.z;
    uint _e13 = right_44.w;
    return metal::uint4(left_44 + _e4, left_44 + _e7, left_44 + _e10, left_44 + _e13);
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void additions(
  device type_9& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::float2 float_2_left = {};
    metal::float2 float_2_right = {};
    metal::float2 float_2_vectors = {};
    metal::float2 float_2_vector_scalar = {};
    metal::float2 float_2_scalar_vector = {};
    float3_ float_3_left = {};
    float3_ float_3_right = {};
    float3_ float_3_vectors = {};
    float3_ float_3_vector_scalar = {};
    float3_ float_3_scalar_vector = {};
    metal::float4 float_4_left = {};
    metal::float4 float_4_right = {};
    metal::float4 float_4_vectors = {};
    metal::float4 float_4_vector_scalar = {};
    metal::float4 float_4_scalar_vector = {};
    metal::int2 int_2_left = {};
    metal::int2 int_2_right = {};
    metal::int2 int_2_vectors = {};
    metal::int2 int_2_vector_scalar = {};
    metal::int2 int_2_scalar_vector = {};
    int3_ int_3_left = {};
    int3_ int_3_right = {};
    int3_ int_3_vectors = {};
    int3_ int_3_vector_scalar = {};
    int3_ int_3_scalar_vector = {};
    metal::int4 int_4_left = {};
    metal::int4 int_4_right = {};
    metal::int4 int_4_vectors = {};
    metal::int4 int_4_vector_scalar = {};
    metal::int4 int_4_scalar_vector = {};
    metal::uint2 uint_2_left = {};
    metal::uint2 uint_2_right = {};
    metal::uint2 uint_2_vectors = {};
    metal::uint2 uint_2_vector_scalar = {};
    metal::uint2 uint_2_scalar_vector = {};
    uint3_ uint_3_left = {};
    uint3_ uint_3_right = {};
    uint3_ uint_3_vectors = {};
    uint3_ uint_3_vector_scalar = {};
    uint3_ uint_3_scalar_vector = {};
    metal::uint4 uint_4_left = {};
    metal::uint4 uint_4_right = {};
    metal::uint4 uint_4_vectors = {};
    metal::uint4 uint_4_vector_scalar = {};
    metal::uint4 uint_4_scalar_vector = {};
    float_2_left = metal::float2(1.25, -(2.5));
    float_2_right = metal::float2(0.5, 1.5);
    metal::float2 _e9 = float_2_left;
    metal::float2 _e10 = float_2_right;
    metal::float2 _e11 = operator_u002b(_e9, _e10);
    float_2_vectors = _e11;
    metal::float2 _e13 = float_2_left;
    metal::float2 _e15 = operator_u002b_1(_e13, 2.0);
    float_2_vector_scalar = _e15;
    metal::float2 _e17 = float_2_right;
    metal::float2 _e19 = operator_u002b_2(2.0, _e17);
    float_2_scalar_vector = _e19;
    float _e22 = float_2_vectors.x;
    out[static_cast<uint>(0)] = as_type<uint>(_e22);
    float _e29 = float_2_vectors.y;
    out[static_cast<uint>(1)] = as_type<uint>(_e29);
    float _e35 = float_2_vector_scalar.x;
    out[static_cast<uint>(2)] = as_type<uint>(_e35);
    float _e41 = float_2_vector_scalar.y;
    out[static_cast<uint>(3)] = as_type<uint>(_e41);
    float _e47 = float_2_scalar_vector.x;
    out[static_cast<uint>(4)] = as_type<uint>(_e47);
    float _e53 = float_2_scalar_vector.y;
    out[static_cast<uint>(5)] = as_type<uint>(_e53);
    float_3_left = float3_ {1.25, -(2.5), 3.75};
    float_3_right = float3_ {0.5, 1.5, -(2.0)};
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
    out[static_cast<uint>(6)] = as_type<uint>(_e83);
    float _e89 = float_3_vectors.y;
    out[static_cast<uint>(7)] = as_type<uint>(_e89);
    float _e95 = float_3_vectors.z;
    out[static_cast<uint>(8)] = as_type<uint>(_e95);
    float _e101 = float_3_vector_scalar.x;
    out[static_cast<uint>(9)] = as_type<uint>(_e101);
    float _e107 = float_3_vector_scalar.y;
    out[static_cast<uint>(10)] = as_type<uint>(_e107);
    float _e113 = float_3_vector_scalar.z;
    out[static_cast<uint>(11)] = as_type<uint>(_e113);
    float _e119 = float_3_scalar_vector.x;
    out[static_cast<uint>(12)] = as_type<uint>(_e119);
    float _e125 = float_3_scalar_vector.y;
    out[static_cast<uint>(13)] = as_type<uint>(_e125);
    float _e131 = float_3_scalar_vector.z;
    out[static_cast<uint>(14)] = as_type<uint>(_e131);
    float_4_left = metal::float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = metal::float4(0.5, 1.5, -(2.0), 0.25);
    metal::float4 _e151 = float_4_left;
    metal::float4 _e152 = float_4_right;
    metal::float4 _e153 = operator_u002b_6(_e151, _e152);
    float_4_vectors = _e153;
    metal::float4 _e155 = float_4_left;
    metal::float4 _e157 = operator_u002b_7(_e155, 2.0);
    float_4_vector_scalar = _e157;
    metal::float4 _e159 = float_4_right;
    metal::float4 _e161 = operator_u002b_8(2.0, _e159);
    float_4_scalar_vector = _e161;
    float _e164 = float_4_vectors.x;
    out[static_cast<uint>(15)] = as_type<uint>(_e164);
    float _e170 = float_4_vectors.y;
    out[static_cast<uint>(16)] = as_type<uint>(_e170);
    float _e176 = float_4_vectors.z;
    out[static_cast<uint>(17)] = as_type<uint>(_e176);
    float _e182 = float_4_vectors.w;
    out[static_cast<uint>(18)] = as_type<uint>(_e182);
    float _e188 = float_4_vector_scalar.x;
    out[static_cast<uint>(19)] = as_type<uint>(_e188);
    float _e194 = float_4_vector_scalar.y;
    out[static_cast<uint>(20)] = as_type<uint>(_e194);
    float _e200 = float_4_vector_scalar.z;
    out[static_cast<uint>(21)] = as_type<uint>(_e200);
    float _e206 = float_4_vector_scalar.w;
    out[static_cast<uint>(22)] = as_type<uint>(_e206);
    float _e212 = float_4_scalar_vector.x;
    out[static_cast<uint>(23)] = as_type<uint>(_e212);
    float _e218 = float_4_scalar_vector.y;
    out[static_cast<uint>(24)] = as_type<uint>(_e218);
    float _e224 = float_4_scalar_vector.z;
    out[static_cast<uint>(25)] = as_type<uint>(_e224);
    float _e230 = float_4_scalar_vector.w;
    out[static_cast<uint>(26)] = as_type<uint>(_e230);
    int_2_left = metal::int2(1, naga_neg(2));
    int_2_right = metal::int2(5, 6);
    metal::int2 _e244 = int_2_left;
    metal::int2 _e245 = int_2_right;
    metal::int2 _e246 = operator_u002b_9(_e244, _e245);
    int_2_vectors = _e246;
    metal::int2 _e248 = int_2_left;
    metal::int2 _e250 = operator_u002b_10(_e248, 3);
    int_2_vector_scalar = _e250;
    metal::int2 _e252 = int_2_right;
    metal::int2 _e254 = operator_u002b_11(3, _e252);
    int_2_scalar_vector = _e254;
    int _e257 = int_2_vectors.x;
    out[static_cast<uint>(27)] = static_cast<uint>(_e257);
    int _e263 = int_2_vectors.y;
    out[static_cast<uint>(28)] = static_cast<uint>(_e263);
    int _e269 = int_2_vector_scalar.x;
    out[static_cast<uint>(29)] = static_cast<uint>(_e269);
    int _e275 = int_2_vector_scalar.y;
    out[static_cast<uint>(30)] = static_cast<uint>(_e275);
    int _e281 = int_2_scalar_vector.x;
    out[static_cast<uint>(31)] = static_cast<uint>(_e281);
    int _e287 = int_2_scalar_vector.y;
    out[static_cast<uint>(32)] = static_cast<uint>(_e287);
    int_3_left = int3_ {1, naga_neg(2), 3};
    int_3_right = int3_ {5, 6, naga_neg(7)};
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
    out[static_cast<uint>(33)] = static_cast<uint>(_e317);
    int _e323 = int_3_vectors.y;
    out[static_cast<uint>(34)] = static_cast<uint>(_e323);
    int _e329 = int_3_vectors.z;
    out[static_cast<uint>(35)] = static_cast<uint>(_e329);
    int _e335 = int_3_vector_scalar.x;
    out[static_cast<uint>(36)] = static_cast<uint>(_e335);
    int _e341 = int_3_vector_scalar.y;
    out[static_cast<uint>(37)] = static_cast<uint>(_e341);
    int _e347 = int_3_vector_scalar.z;
    out[static_cast<uint>(38)] = static_cast<uint>(_e347);
    int _e353 = int_3_scalar_vector.x;
    out[static_cast<uint>(39)] = static_cast<uint>(_e353);
    int _e359 = int_3_scalar_vector.y;
    out[static_cast<uint>(40)] = static_cast<uint>(_e359);
    int _e365 = int_3_scalar_vector.z;
    out[static_cast<uint>(41)] = static_cast<uint>(_e365);
    int_4_left = metal::int4(1, naga_neg(2), 3, naga_neg(4));
    int_4_right = metal::int4(5, 6, naga_neg(7), 8);
    metal::int4 _e385 = int_4_left;
    metal::int4 _e386 = int_4_right;
    metal::int4 _e387 = operator_u002b_15(_e385, _e386);
    int_4_vectors = _e387;
    metal::int4 _e389 = int_4_left;
    metal::int4 _e391 = operator_u002b_16(_e389, 3);
    int_4_vector_scalar = _e391;
    metal::int4 _e393 = int_4_right;
    metal::int4 _e395 = operator_u002b_17(3, _e393);
    int_4_scalar_vector = _e395;
    int _e398 = int_4_vectors.x;
    out[static_cast<uint>(42)] = static_cast<uint>(_e398);
    int _e404 = int_4_vectors.y;
    out[static_cast<uint>(43)] = static_cast<uint>(_e404);
    int _e410 = int_4_vectors.z;
    out[static_cast<uint>(44)] = static_cast<uint>(_e410);
    int _e416 = int_4_vectors.w;
    out[static_cast<uint>(45)] = static_cast<uint>(_e416);
    int _e422 = int_4_vector_scalar.x;
    out[static_cast<uint>(46)] = static_cast<uint>(_e422);
    int _e428 = int_4_vector_scalar.y;
    out[static_cast<uint>(47)] = static_cast<uint>(_e428);
    int _e434 = int_4_vector_scalar.z;
    out[static_cast<uint>(48)] = static_cast<uint>(_e434);
    int _e440 = int_4_vector_scalar.w;
    out[static_cast<uint>(49)] = static_cast<uint>(_e440);
    int _e446 = int_4_scalar_vector.x;
    out[static_cast<uint>(50)] = static_cast<uint>(_e446);
    int _e452 = int_4_scalar_vector.y;
    out[static_cast<uint>(51)] = static_cast<uint>(_e452);
    int _e458 = int_4_scalar_vector.z;
    out[static_cast<uint>(52)] = static_cast<uint>(_e458);
    int _e464 = int_4_scalar_vector.w;
    out[static_cast<uint>(53)] = static_cast<uint>(_e464);
    uint_2_left = metal::uint2(4294967294u, 2147483649u);
    uint_2_right = metal::uint2(5u, 2u);
    metal::uint2 _e477 = uint_2_left;
    metal::uint2 _e478 = uint_2_right;
    metal::uint2 _e479 = operator_u002b_18(_e477, _e478);
    uint_2_vectors = _e479;
    metal::uint2 _e481 = uint_2_left;
    metal::uint2 _e483 = operator_u002b_19(_e481, 4u);
    uint_2_vector_scalar = _e483;
    metal::uint2 _e485 = uint_2_right;
    metal::uint2 _e487 = operator_u002b_20(4u, _e485);
    uint_2_scalar_vector = _e487;
    uint _e490 = uint_2_vectors.x;
    out[static_cast<uint>(54)] = _e490;
    uint _e495 = uint_2_vectors.y;
    out[static_cast<uint>(55)] = _e495;
    uint _e500 = uint_2_vector_scalar.x;
    out[static_cast<uint>(56)] = _e500;
    uint _e505 = uint_2_vector_scalar.y;
    out[static_cast<uint>(57)] = _e505;
    uint _e510 = uint_2_scalar_vector.x;
    out[static_cast<uint>(58)] = _e510;
    uint _e515 = uint_2_scalar_vector.y;
    out[static_cast<uint>(59)] = _e515;
    uint_3_left = uint3_ {4294967294u, 2147483649u, 3u};
    uint_3_right = uint3_ {5u, 2u, 4294967293u};
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
    out[static_cast<uint>(60)] = _e542;
    uint _e547 = uint_3_vectors.y;
    out[static_cast<uint>(61)] = _e547;
    uint _e552 = uint_3_vectors.z;
    out[static_cast<uint>(62)] = _e552;
    uint _e557 = uint_3_vector_scalar.x;
    out[static_cast<uint>(63)] = _e557;
    uint _e562 = uint_3_vector_scalar.y;
    out[static_cast<uint>(64)] = _e562;
    uint _e567 = uint_3_vector_scalar.z;
    out[static_cast<uint>(65)] = _e567;
    uint _e572 = uint_3_scalar_vector.x;
    out[static_cast<uint>(66)] = _e572;
    uint _e577 = uint_3_scalar_vector.y;
    out[static_cast<uint>(67)] = _e577;
    uint _e582 = uint_3_scalar_vector.z;
    out[static_cast<uint>(68)] = _e582;
    uint_4_left = metal::uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = metal::uint4(5u, 2u, 4294967293u, 1u);
    metal::uint4 _e598 = uint_4_left;
    metal::uint4 _e599 = uint_4_right;
    metal::uint4 _e600 = operator_u002b_24(_e598, _e599);
    uint_4_vectors = _e600;
    metal::uint4 _e602 = uint_4_left;
    metal::uint4 _e604 = operator_u002b_25(_e602, 4u);
    uint_4_vector_scalar = _e604;
    metal::uint4 _e606 = uint_4_right;
    metal::uint4 _e608 = operator_u002b_26(4u, _e606);
    uint_4_scalar_vector = _e608;
    uint _e611 = uint_4_vectors.x;
    out[static_cast<uint>(69)] = _e611;
    uint _e616 = uint_4_vectors.y;
    out[static_cast<uint>(70)] = _e616;
    uint _e621 = uint_4_vectors.z;
    out[static_cast<uint>(71)] = _e621;
    uint _e626 = uint_4_vectors.w;
    out[static_cast<uint>(72)] = _e626;
    uint _e631 = uint_4_vector_scalar.x;
    out[static_cast<uint>(73)] = _e631;
    uint _e636 = uint_4_vector_scalar.y;
    out[static_cast<uint>(74)] = _e636;
    uint _e641 = uint_4_vector_scalar.z;
    out[static_cast<uint>(75)] = _e641;
    uint _e646 = uint_4_vector_scalar.w;
    out[static_cast<uint>(76)] = _e646;
    uint _e651 = uint_4_scalar_vector.x;
    out[static_cast<uint>(77)] = _e651;
    uint _e656 = uint_4_scalar_vector.y;
    out[static_cast<uint>(78)] = _e656;
    uint _e661 = uint_4_scalar_vector.z;
    out[static_cast<uint>(79)] = _e661;
    uint _e666 = uint_4_scalar_vector.w;
    out[static_cast<uint>(80)] = _e666;
}
