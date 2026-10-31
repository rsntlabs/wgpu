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
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    float3_ float_3_left = {};
    float3_ float_3_right = {};
    float3_ float_3_vectors = {};
    float3_ float_3_vector_scalar = {};
    float3_ float_3_scalar_vector = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    metal::float4 float_4_left = {};
    metal::float4 float_4_right = {};
    metal::float4 float_4_vectors = {};
    metal::float4 float_4_vector_scalar = {};
    metal::float4 float_4_scalar_vector = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    metal::int2 int_2_left = {};
    metal::int2 int_2_right = {};
    metal::int2 int_2_vectors = {};
    metal::int2 int_2_vector_scalar = {};
    metal::int2 int_2_scalar_vector = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    int3_ int_3_left = {};
    int3_ int_3_right = {};
    int3_ int_3_vectors = {};
    int3_ int_3_vector_scalar = {};
    int3_ int_3_scalar_vector = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    metal::int4 int_4_left = {};
    metal::int4 int_4_right = {};
    metal::int4 int_4_vectors = {};
    metal::int4 int_4_vector_scalar = {};
    metal::int4 int_4_scalar_vector = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    metal::uint2 uint_2_left = {};
    metal::uint2 uint_2_right = {};
    metal::uint2 uint_2_vectors = {};
    metal::uint2 uint_2_vector_scalar = {};
    metal::uint2 uint_2_scalar_vector = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint3_ uint_3_left = {};
    uint3_ uint_3_right = {};
    uint3_ uint_3_vectors = {};
    uint3_ uint_3_vector_scalar = {};
    uint3_ uint_3_scalar_vector = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    metal::uint4 uint_4_left = {};
    metal::uint4 uint_4_right = {};
    metal::uint4 uint_4_vectors = {};
    metal::uint4 uint_4_vector_scalar = {};
    metal::uint4 uint_4_scalar_vector = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
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
    local = static_cast<uint>(0);
    uint _e27 = local;
    out[_e27] = as_type<uint>(_e22);
    float _e31 = float_2_vectors.y;
    local_1 = static_cast<uint>(1);
    uint _e36 = local_1;
    out[_e36] = as_type<uint>(_e31);
    float _e39 = float_2_vector_scalar.x;
    local_2 = static_cast<uint>(2);
    uint _e44 = local_2;
    out[_e44] = as_type<uint>(_e39);
    float _e47 = float_2_vector_scalar.y;
    local_3 = static_cast<uint>(3);
    uint _e52 = local_3;
    out[_e52] = as_type<uint>(_e47);
    float _e55 = float_2_scalar_vector.x;
    local_4 = static_cast<uint>(4);
    uint _e60 = local_4;
    out[_e60] = as_type<uint>(_e55);
    float _e63 = float_2_scalar_vector.y;
    local_5 = static_cast<uint>(5);
    uint _e68 = local_5;
    out[_e68] = as_type<uint>(_e63);
    float_3_left = float3_ {1.25, -(2.5), 3.75};
    float_3_right = float3_ {0.5, 1.5, -(2.0)};
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
    local_6 = static_cast<uint>(6);
    uint _e100 = local_6;
    out[_e100] = as_type<uint>(_e95);
    float _e103 = float_3_vectors.y;
    local_7 = static_cast<uint>(7);
    uint _e108 = local_7;
    out[_e108] = as_type<uint>(_e103);
    float _e111 = float_3_vectors.z;
    local_8 = static_cast<uint>(8);
    uint _e116 = local_8;
    out[_e116] = as_type<uint>(_e111);
    float _e119 = float_3_vector_scalar.x;
    local_9 = static_cast<uint>(9);
    uint _e124 = local_9;
    out[_e124] = as_type<uint>(_e119);
    float _e127 = float_3_vector_scalar.y;
    local_10 = static_cast<uint>(10);
    uint _e132 = local_10;
    out[_e132] = as_type<uint>(_e127);
    float _e135 = float_3_vector_scalar.z;
    local_11 = static_cast<uint>(11);
    uint _e140 = local_11;
    out[_e140] = as_type<uint>(_e135);
    float _e143 = float_3_scalar_vector.x;
    local_12 = static_cast<uint>(12);
    uint _e148 = local_12;
    out[_e148] = as_type<uint>(_e143);
    float _e151 = float_3_scalar_vector.y;
    local_13 = static_cast<uint>(13);
    uint _e156 = local_13;
    out[_e156] = as_type<uint>(_e151);
    float _e159 = float_3_scalar_vector.z;
    local_14 = static_cast<uint>(14);
    uint _e164 = local_14;
    out[_e164] = as_type<uint>(_e159);
    float_4_left = metal::float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = metal::float4(0.5, 1.5, -(2.0), 0.25);
    metal::float4 _e181 = float_4_left;
    metal::float4 _e182 = float_4_right;
    metal::float4 _e183 = operator_u002b_6(_e181, _e182);
    float_4_vectors = _e183;
    metal::float4 _e185 = float_4_left;
    metal::float4 _e187 = operator_u002b_7(_e185, 2.0);
    float_4_vector_scalar = _e187;
    metal::float4 _e189 = float_4_right;
    metal::float4 _e191 = operator_u002b_8(2.0, _e189);
    float_4_scalar_vector = _e191;
    float _e194 = float_4_vectors.x;
    local_15 = static_cast<uint>(15);
    uint _e199 = local_15;
    out[_e199] = as_type<uint>(_e194);
    float _e202 = float_4_vectors.y;
    local_16 = static_cast<uint>(16);
    uint _e207 = local_16;
    out[_e207] = as_type<uint>(_e202);
    float _e210 = float_4_vectors.z;
    local_17 = static_cast<uint>(17);
    uint _e215 = local_17;
    out[_e215] = as_type<uint>(_e210);
    float _e218 = float_4_vectors.w;
    local_18 = static_cast<uint>(18);
    uint _e223 = local_18;
    out[_e223] = as_type<uint>(_e218);
    float _e226 = float_4_vector_scalar.x;
    local_19 = static_cast<uint>(19);
    uint _e231 = local_19;
    out[_e231] = as_type<uint>(_e226);
    float _e234 = float_4_vector_scalar.y;
    local_20 = static_cast<uint>(20);
    uint _e239 = local_20;
    out[_e239] = as_type<uint>(_e234);
    float _e242 = float_4_vector_scalar.z;
    local_21 = static_cast<uint>(21);
    uint _e247 = local_21;
    out[_e247] = as_type<uint>(_e242);
    float _e250 = float_4_vector_scalar.w;
    local_22 = static_cast<uint>(22);
    uint _e255 = local_22;
    out[_e255] = as_type<uint>(_e250);
    float _e258 = float_4_scalar_vector.x;
    local_23 = static_cast<uint>(23);
    uint _e263 = local_23;
    out[_e263] = as_type<uint>(_e258);
    float _e266 = float_4_scalar_vector.y;
    local_24 = static_cast<uint>(24);
    uint _e271 = local_24;
    out[_e271] = as_type<uint>(_e266);
    float _e274 = float_4_scalar_vector.z;
    local_25 = static_cast<uint>(25);
    uint _e279 = local_25;
    out[_e279] = as_type<uint>(_e274);
    float _e282 = float_4_scalar_vector.w;
    local_26 = static_cast<uint>(26);
    uint _e287 = local_26;
    out[_e287] = as_type<uint>(_e282);
    int_2_left = metal::int2(1, naga_neg(2));
    int_2_right = metal::int2(5, 6);
    metal::int2 _e298 = int_2_left;
    metal::int2 _e299 = int_2_right;
    metal::int2 _e300 = operator_u002b_9(_e298, _e299);
    int_2_vectors = _e300;
    metal::int2 _e302 = int_2_left;
    metal::int2 _e304 = operator_u002b_10(_e302, 3);
    int_2_vector_scalar = _e304;
    metal::int2 _e306 = int_2_right;
    metal::int2 _e308 = operator_u002b_11(3, _e306);
    int_2_scalar_vector = _e308;
    int _e311 = int_2_vectors.x;
    local_27 = static_cast<uint>(27);
    uint _e316 = local_27;
    out[_e316] = static_cast<uint>(_e311);
    int _e319 = int_2_vectors.y;
    local_28 = static_cast<uint>(28);
    uint _e324 = local_28;
    out[_e324] = static_cast<uint>(_e319);
    int _e327 = int_2_vector_scalar.x;
    local_29 = static_cast<uint>(29);
    uint _e332 = local_29;
    out[_e332] = static_cast<uint>(_e327);
    int _e335 = int_2_vector_scalar.y;
    local_30 = static_cast<uint>(30);
    uint _e340 = local_30;
    out[_e340] = static_cast<uint>(_e335);
    int _e343 = int_2_scalar_vector.x;
    local_31 = static_cast<uint>(31);
    uint _e348 = local_31;
    out[_e348] = static_cast<uint>(_e343);
    int _e351 = int_2_scalar_vector.y;
    local_32 = static_cast<uint>(32);
    uint _e356 = local_32;
    out[_e356] = static_cast<uint>(_e351);
    int_3_left = int3_ {1, naga_neg(2), 3};
    int_3_right = int3_ {5, 6, naga_neg(7)};
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
    local_33 = static_cast<uint>(33);
    uint _e388 = local_33;
    out[_e388] = static_cast<uint>(_e383);
    int _e391 = int_3_vectors.y;
    local_34 = static_cast<uint>(34);
    uint _e396 = local_34;
    out[_e396] = static_cast<uint>(_e391);
    int _e399 = int_3_vectors.z;
    local_35 = static_cast<uint>(35);
    uint _e404 = local_35;
    out[_e404] = static_cast<uint>(_e399);
    int _e407 = int_3_vector_scalar.x;
    local_36 = static_cast<uint>(36);
    uint _e412 = local_36;
    out[_e412] = static_cast<uint>(_e407);
    int _e415 = int_3_vector_scalar.y;
    local_37 = static_cast<uint>(37);
    uint _e420 = local_37;
    out[_e420] = static_cast<uint>(_e415);
    int _e423 = int_3_vector_scalar.z;
    local_38 = static_cast<uint>(38);
    uint _e428 = local_38;
    out[_e428] = static_cast<uint>(_e423);
    int _e431 = int_3_scalar_vector.x;
    local_39 = static_cast<uint>(39);
    uint _e436 = local_39;
    out[_e436] = static_cast<uint>(_e431);
    int _e439 = int_3_scalar_vector.y;
    local_40 = static_cast<uint>(40);
    uint _e444 = local_40;
    out[_e444] = static_cast<uint>(_e439);
    int _e447 = int_3_scalar_vector.z;
    local_41 = static_cast<uint>(41);
    uint _e452 = local_41;
    out[_e452] = static_cast<uint>(_e447);
    int_4_left = metal::int4(1, naga_neg(2), 3, naga_neg(4));
    int_4_right = metal::int4(5, 6, naga_neg(7), 8);
    metal::int4 _e469 = int_4_left;
    metal::int4 _e470 = int_4_right;
    metal::int4 _e471 = operator_u002b_15(_e469, _e470);
    int_4_vectors = _e471;
    metal::int4 _e473 = int_4_left;
    metal::int4 _e475 = operator_u002b_16(_e473, 3);
    int_4_vector_scalar = _e475;
    metal::int4 _e477 = int_4_right;
    metal::int4 _e479 = operator_u002b_17(3, _e477);
    int_4_scalar_vector = _e479;
    int _e482 = int_4_vectors.x;
    local_42 = static_cast<uint>(42);
    uint _e487 = local_42;
    out[_e487] = static_cast<uint>(_e482);
    int _e490 = int_4_vectors.y;
    local_43 = static_cast<uint>(43);
    uint _e495 = local_43;
    out[_e495] = static_cast<uint>(_e490);
    int _e498 = int_4_vectors.z;
    local_44 = static_cast<uint>(44);
    uint _e503 = local_44;
    out[_e503] = static_cast<uint>(_e498);
    int _e506 = int_4_vectors.w;
    local_45 = static_cast<uint>(45);
    uint _e511 = local_45;
    out[_e511] = static_cast<uint>(_e506);
    int _e514 = int_4_vector_scalar.x;
    local_46 = static_cast<uint>(46);
    uint _e519 = local_46;
    out[_e519] = static_cast<uint>(_e514);
    int _e522 = int_4_vector_scalar.y;
    local_47 = static_cast<uint>(47);
    uint _e527 = local_47;
    out[_e527] = static_cast<uint>(_e522);
    int _e530 = int_4_vector_scalar.z;
    local_48 = static_cast<uint>(48);
    uint _e535 = local_48;
    out[_e535] = static_cast<uint>(_e530);
    int _e538 = int_4_vector_scalar.w;
    local_49 = static_cast<uint>(49);
    uint _e543 = local_49;
    out[_e543] = static_cast<uint>(_e538);
    int _e546 = int_4_scalar_vector.x;
    local_50 = static_cast<uint>(50);
    uint _e551 = local_50;
    out[_e551] = static_cast<uint>(_e546);
    int _e554 = int_4_scalar_vector.y;
    local_51 = static_cast<uint>(51);
    uint _e559 = local_51;
    out[_e559] = static_cast<uint>(_e554);
    int _e562 = int_4_scalar_vector.z;
    local_52 = static_cast<uint>(52);
    uint _e567 = local_52;
    out[_e567] = static_cast<uint>(_e562);
    int _e570 = int_4_scalar_vector.w;
    local_53 = static_cast<uint>(53);
    uint _e575 = local_53;
    out[_e575] = static_cast<uint>(_e570);
    uint_2_left = metal::uint2(4294967294u, 2147483649u);
    uint_2_right = metal::uint2(5u, 2u);
    metal::uint2 _e585 = uint_2_left;
    metal::uint2 _e586 = uint_2_right;
    metal::uint2 _e587 = operator_u002b_18(_e585, _e586);
    uint_2_vectors = _e587;
    metal::uint2 _e589 = uint_2_left;
    metal::uint2 _e591 = operator_u002b_19(_e589, 4u);
    uint_2_vector_scalar = _e591;
    metal::uint2 _e593 = uint_2_right;
    metal::uint2 _e595 = operator_u002b_20(4u, _e593);
    uint_2_scalar_vector = _e595;
    uint _e598 = uint_2_vectors.x;
    local_54 = static_cast<uint>(54);
    uint _e602 = local_54;
    out[_e602] = _e598;
    uint _e605 = uint_2_vectors.y;
    local_55 = static_cast<uint>(55);
    uint _e609 = local_55;
    out[_e609] = _e605;
    uint _e612 = uint_2_vector_scalar.x;
    local_56 = static_cast<uint>(56);
    uint _e616 = local_56;
    out[_e616] = _e612;
    uint _e619 = uint_2_vector_scalar.y;
    local_57 = static_cast<uint>(57);
    uint _e623 = local_57;
    out[_e623] = _e619;
    uint _e626 = uint_2_scalar_vector.x;
    local_58 = static_cast<uint>(58);
    uint _e630 = local_58;
    out[_e630] = _e626;
    uint _e633 = uint_2_scalar_vector.y;
    local_59 = static_cast<uint>(59);
    uint _e637 = local_59;
    out[_e637] = _e633;
    uint_3_left = uint3_ {4294967294u, 2147483649u, 3u};
    uint_3_right = uint3_ {5u, 2u, 4294967293u};
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
    local_60 = static_cast<uint>(60);
    uint _e666 = local_60;
    out[_e666] = _e662;
    uint _e669 = uint_3_vectors.y;
    local_61 = static_cast<uint>(61);
    uint _e673 = local_61;
    out[_e673] = _e669;
    uint _e676 = uint_3_vectors.z;
    local_62 = static_cast<uint>(62);
    uint _e680 = local_62;
    out[_e680] = _e676;
    uint _e683 = uint_3_vector_scalar.x;
    local_63 = static_cast<uint>(63);
    uint _e687 = local_63;
    out[_e687] = _e683;
    uint _e690 = uint_3_vector_scalar.y;
    local_64 = static_cast<uint>(64);
    uint _e694 = local_64;
    out[_e694] = _e690;
    uint _e697 = uint_3_vector_scalar.z;
    local_65 = static_cast<uint>(65);
    uint _e701 = local_65;
    out[_e701] = _e697;
    uint _e704 = uint_3_scalar_vector.x;
    local_66 = static_cast<uint>(66);
    uint _e708 = local_66;
    out[_e708] = _e704;
    uint _e711 = uint_3_scalar_vector.y;
    local_67 = static_cast<uint>(67);
    uint _e715 = local_67;
    out[_e715] = _e711;
    uint _e718 = uint_3_scalar_vector.z;
    local_68 = static_cast<uint>(68);
    uint _e722 = local_68;
    out[_e722] = _e718;
    uint_4_left = metal::uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = metal::uint4(5u, 2u, 4294967293u, 1u);
    metal::uint4 _e736 = uint_4_left;
    metal::uint4 _e737 = uint_4_right;
    metal::uint4 _e738 = operator_u002b_24(_e736, _e737);
    uint_4_vectors = _e738;
    metal::uint4 _e740 = uint_4_left;
    metal::uint4 _e742 = operator_u002b_25(_e740, 4u);
    uint_4_vector_scalar = _e742;
    metal::uint4 _e744 = uint_4_right;
    metal::uint4 _e746 = operator_u002b_26(4u, _e744);
    uint_4_scalar_vector = _e746;
    uint _e749 = uint_4_vectors.x;
    local_69 = static_cast<uint>(69);
    uint _e753 = local_69;
    out[_e753] = _e749;
    uint _e756 = uint_4_vectors.y;
    local_70 = static_cast<uint>(70);
    uint _e760 = local_70;
    out[_e760] = _e756;
    uint _e763 = uint_4_vectors.z;
    local_71 = static_cast<uint>(71);
    uint _e767 = local_71;
    out[_e767] = _e763;
    uint _e770 = uint_4_vectors.w;
    local_72 = static_cast<uint>(72);
    uint _e774 = local_72;
    out[_e774] = _e770;
    uint _e777 = uint_4_vector_scalar.x;
    local_73 = static_cast<uint>(73);
    uint _e781 = local_73;
    out[_e781] = _e777;
    uint _e784 = uint_4_vector_scalar.y;
    local_74 = static_cast<uint>(74);
    uint _e788 = local_74;
    out[_e788] = _e784;
    uint _e791 = uint_4_vector_scalar.z;
    local_75 = static_cast<uint>(75);
    uint _e795 = local_75;
    out[_e795] = _e791;
    uint _e798 = uint_4_vector_scalar.w;
    local_76 = static_cast<uint>(76);
    uint _e802 = local_76;
    out[_e802] = _e798;
    uint _e805 = uint_4_scalar_vector.x;
    local_77 = static_cast<uint>(77);
    uint _e809 = local_77;
    out[_e809] = _e805;
    uint _e812 = uint_4_scalar_vector.y;
    local_78 = static_cast<uint>(78);
    uint _e816 = local_78;
    out[_e816] = _e812;
    uint _e819 = uint_4_scalar_vector.z;
    local_79 = static_cast<uint>(79);
    uint _e823 = local_79;
    out[_e823] = _e819;
    uint _e826 = uint_4_scalar_vector.w;
    local_80 = static_cast<uint>(80);
    uint _e830 = local_80;
    out[_e830] = _e826;
}
