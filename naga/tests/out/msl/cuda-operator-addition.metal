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
    uint local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    uint local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    uint local_155 = {};
    uint local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    uint local_159 = {};
    uint local_160 = {};
    uint local_161 = {};
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
    uint _e28 = local;
    local_81 = static_cast<uint>(_e28);
    uint _e31 = local_81;
    out[_e31] = as_type<uint>(_e22);
    float _e34 = float_2_vectors.y;
    local_1 = static_cast<uint>(1);
    uint _e39 = local_1;
    local_82 = static_cast<uint>(_e39);
    uint _e42 = local_82;
    out[_e42] = as_type<uint>(_e34);
    float _e45 = float_2_vector_scalar.x;
    local_2 = static_cast<uint>(2);
    uint _e50 = local_2;
    local_83 = static_cast<uint>(_e50);
    uint _e53 = local_83;
    out[_e53] = as_type<uint>(_e45);
    float _e56 = float_2_vector_scalar.y;
    local_3 = static_cast<uint>(3);
    uint _e61 = local_3;
    local_84 = static_cast<uint>(_e61);
    uint _e64 = local_84;
    out[_e64] = as_type<uint>(_e56);
    float _e67 = float_2_scalar_vector.x;
    local_4 = static_cast<uint>(4);
    uint _e72 = local_4;
    local_85 = static_cast<uint>(_e72);
    uint _e75 = local_85;
    out[_e75] = as_type<uint>(_e67);
    float _e78 = float_2_scalar_vector.y;
    local_5 = static_cast<uint>(5);
    uint _e83 = local_5;
    local_86 = static_cast<uint>(_e83);
    uint _e86 = local_86;
    out[_e86] = as_type<uint>(_e78);
    float_3_left = float3_ {1.25, -(2.5), 3.75};
    float_3_right = float3_ {0.5, 1.5, -(2.0)};
    float3_ _e100 = float_3_left;
    float3_ _e101 = float_3_right;
    float3_ _e102 = operator_u002b_3(_e100, _e101);
    float_3_vectors = _e102;
    float3_ _e104 = float_3_left;
    float3_ _e106 = operator_u002b_4(_e104, 2.0);
    float_3_vector_scalar = _e106;
    float3_ _e108 = float_3_right;
    float3_ _e110 = operator_u002b_5(2.0, _e108);
    float_3_scalar_vector = _e110;
    float _e113 = float_3_vectors.x;
    local_6 = static_cast<uint>(6);
    uint _e118 = local_6;
    local_87 = static_cast<uint>(_e118);
    uint _e121 = local_87;
    out[_e121] = as_type<uint>(_e113);
    float _e124 = float_3_vectors.y;
    local_7 = static_cast<uint>(7);
    uint _e129 = local_7;
    local_88 = static_cast<uint>(_e129);
    uint _e132 = local_88;
    out[_e132] = as_type<uint>(_e124);
    float _e135 = float_3_vectors.z;
    local_8 = static_cast<uint>(8);
    uint _e140 = local_8;
    local_89 = static_cast<uint>(_e140);
    uint _e143 = local_89;
    out[_e143] = as_type<uint>(_e135);
    float _e146 = float_3_vector_scalar.x;
    local_9 = static_cast<uint>(9);
    uint _e151 = local_9;
    local_90 = static_cast<uint>(_e151);
    uint _e154 = local_90;
    out[_e154] = as_type<uint>(_e146);
    float _e157 = float_3_vector_scalar.y;
    local_10 = static_cast<uint>(10);
    uint _e162 = local_10;
    local_91 = static_cast<uint>(_e162);
    uint _e165 = local_91;
    out[_e165] = as_type<uint>(_e157);
    float _e168 = float_3_vector_scalar.z;
    local_11 = static_cast<uint>(11);
    uint _e173 = local_11;
    local_92 = static_cast<uint>(_e173);
    uint _e176 = local_92;
    out[_e176] = as_type<uint>(_e168);
    float _e179 = float_3_scalar_vector.x;
    local_12 = static_cast<uint>(12);
    uint _e184 = local_12;
    local_93 = static_cast<uint>(_e184);
    uint _e187 = local_93;
    out[_e187] = as_type<uint>(_e179);
    float _e190 = float_3_scalar_vector.y;
    local_13 = static_cast<uint>(13);
    uint _e195 = local_13;
    local_94 = static_cast<uint>(_e195);
    uint _e198 = local_94;
    out[_e198] = as_type<uint>(_e190);
    float _e201 = float_3_scalar_vector.z;
    local_14 = static_cast<uint>(14);
    uint _e206 = local_14;
    local_95 = static_cast<uint>(_e206);
    uint _e209 = local_95;
    out[_e209] = as_type<uint>(_e201);
    float_4_left = metal::float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = metal::float4(0.5, 1.5, -(2.0), 0.25);
    metal::float4 _e226 = float_4_left;
    metal::float4 _e227 = float_4_right;
    metal::float4 _e228 = operator_u002b_6(_e226, _e227);
    float_4_vectors = _e228;
    metal::float4 _e230 = float_4_left;
    metal::float4 _e232 = operator_u002b_7(_e230, 2.0);
    float_4_vector_scalar = _e232;
    metal::float4 _e234 = float_4_right;
    metal::float4 _e236 = operator_u002b_8(2.0, _e234);
    float_4_scalar_vector = _e236;
    float _e239 = float_4_vectors.x;
    local_15 = static_cast<uint>(15);
    uint _e244 = local_15;
    local_96 = static_cast<uint>(_e244);
    uint _e247 = local_96;
    out[_e247] = as_type<uint>(_e239);
    float _e250 = float_4_vectors.y;
    local_16 = static_cast<uint>(16);
    uint _e255 = local_16;
    local_97 = static_cast<uint>(_e255);
    uint _e258 = local_97;
    out[_e258] = as_type<uint>(_e250);
    float _e261 = float_4_vectors.z;
    local_17 = static_cast<uint>(17);
    uint _e266 = local_17;
    local_98 = static_cast<uint>(_e266);
    uint _e269 = local_98;
    out[_e269] = as_type<uint>(_e261);
    float _e272 = float_4_vectors.w;
    local_18 = static_cast<uint>(18);
    uint _e277 = local_18;
    local_99 = static_cast<uint>(_e277);
    uint _e280 = local_99;
    out[_e280] = as_type<uint>(_e272);
    float _e283 = float_4_vector_scalar.x;
    local_19 = static_cast<uint>(19);
    uint _e288 = local_19;
    local_100 = static_cast<uint>(_e288);
    uint _e291 = local_100;
    out[_e291] = as_type<uint>(_e283);
    float _e294 = float_4_vector_scalar.y;
    local_20 = static_cast<uint>(20);
    uint _e299 = local_20;
    local_101 = static_cast<uint>(_e299);
    uint _e302 = local_101;
    out[_e302] = as_type<uint>(_e294);
    float _e305 = float_4_vector_scalar.z;
    local_21 = static_cast<uint>(21);
    uint _e310 = local_21;
    local_102 = static_cast<uint>(_e310);
    uint _e313 = local_102;
    out[_e313] = as_type<uint>(_e305);
    float _e316 = float_4_vector_scalar.w;
    local_22 = static_cast<uint>(22);
    uint _e321 = local_22;
    local_103 = static_cast<uint>(_e321);
    uint _e324 = local_103;
    out[_e324] = as_type<uint>(_e316);
    float _e327 = float_4_scalar_vector.x;
    local_23 = static_cast<uint>(23);
    uint _e332 = local_23;
    local_104 = static_cast<uint>(_e332);
    uint _e335 = local_104;
    out[_e335] = as_type<uint>(_e327);
    float _e338 = float_4_scalar_vector.y;
    local_24 = static_cast<uint>(24);
    uint _e343 = local_24;
    local_105 = static_cast<uint>(_e343);
    uint _e346 = local_105;
    out[_e346] = as_type<uint>(_e338);
    float _e349 = float_4_scalar_vector.z;
    local_25 = static_cast<uint>(25);
    uint _e354 = local_25;
    local_106 = static_cast<uint>(_e354);
    uint _e357 = local_106;
    out[_e357] = as_type<uint>(_e349);
    float _e360 = float_4_scalar_vector.w;
    local_26 = static_cast<uint>(26);
    uint _e365 = local_26;
    local_107 = static_cast<uint>(_e365);
    uint _e368 = local_107;
    out[_e368] = as_type<uint>(_e360);
    int_2_left = metal::int2(1, naga_neg(2));
    int_2_right = metal::int2(5, 6);
    metal::int2 _e379 = int_2_left;
    metal::int2 _e380 = int_2_right;
    metal::int2 _e381 = operator_u002b_9(_e379, _e380);
    int_2_vectors = _e381;
    metal::int2 _e383 = int_2_left;
    metal::int2 _e385 = operator_u002b_10(_e383, 3);
    int_2_vector_scalar = _e385;
    metal::int2 _e387 = int_2_right;
    metal::int2 _e389 = operator_u002b_11(3, _e387);
    int_2_scalar_vector = _e389;
    int _e392 = int_2_vectors.x;
    local_27 = static_cast<uint>(27);
    uint _e397 = local_27;
    local_108 = static_cast<uint>(_e397);
    uint _e400 = local_108;
    out[_e400] = static_cast<uint>(_e392);
    int _e403 = int_2_vectors.y;
    local_28 = static_cast<uint>(28);
    uint _e408 = local_28;
    local_109 = static_cast<uint>(_e408);
    uint _e411 = local_109;
    out[_e411] = static_cast<uint>(_e403);
    int _e414 = int_2_vector_scalar.x;
    local_29 = static_cast<uint>(29);
    uint _e419 = local_29;
    local_110 = static_cast<uint>(_e419);
    uint _e422 = local_110;
    out[_e422] = static_cast<uint>(_e414);
    int _e425 = int_2_vector_scalar.y;
    local_30 = static_cast<uint>(30);
    uint _e430 = local_30;
    local_111 = static_cast<uint>(_e430);
    uint _e433 = local_111;
    out[_e433] = static_cast<uint>(_e425);
    int _e436 = int_2_scalar_vector.x;
    local_31 = static_cast<uint>(31);
    uint _e441 = local_31;
    local_112 = static_cast<uint>(_e441);
    uint _e444 = local_112;
    out[_e444] = static_cast<uint>(_e436);
    int _e447 = int_2_scalar_vector.y;
    local_32 = static_cast<uint>(32);
    uint _e452 = local_32;
    local_113 = static_cast<uint>(_e452);
    uint _e455 = local_113;
    out[_e455] = static_cast<uint>(_e447);
    int_3_left = int3_ {1, naga_neg(2), 3};
    int_3_right = int3_ {5, 6, naga_neg(7)};
    int3_ _e469 = int_3_left;
    int3_ _e470 = int_3_right;
    int3_ _e471 = operator_u002b_12(_e469, _e470);
    int_3_vectors = _e471;
    int3_ _e473 = int_3_left;
    int3_ _e475 = operator_u002b_13(_e473, 3);
    int_3_vector_scalar = _e475;
    int3_ _e477 = int_3_right;
    int3_ _e479 = operator_u002b_14(3, _e477);
    int_3_scalar_vector = _e479;
    int _e482 = int_3_vectors.x;
    local_33 = static_cast<uint>(33);
    uint _e487 = local_33;
    local_114 = static_cast<uint>(_e487);
    uint _e490 = local_114;
    out[_e490] = static_cast<uint>(_e482);
    int _e493 = int_3_vectors.y;
    local_34 = static_cast<uint>(34);
    uint _e498 = local_34;
    local_115 = static_cast<uint>(_e498);
    uint _e501 = local_115;
    out[_e501] = static_cast<uint>(_e493);
    int _e504 = int_3_vectors.z;
    local_35 = static_cast<uint>(35);
    uint _e509 = local_35;
    local_116 = static_cast<uint>(_e509);
    uint _e512 = local_116;
    out[_e512] = static_cast<uint>(_e504);
    int _e515 = int_3_vector_scalar.x;
    local_36 = static_cast<uint>(36);
    uint _e520 = local_36;
    local_117 = static_cast<uint>(_e520);
    uint _e523 = local_117;
    out[_e523] = static_cast<uint>(_e515);
    int _e526 = int_3_vector_scalar.y;
    local_37 = static_cast<uint>(37);
    uint _e531 = local_37;
    local_118 = static_cast<uint>(_e531);
    uint _e534 = local_118;
    out[_e534] = static_cast<uint>(_e526);
    int _e537 = int_3_vector_scalar.z;
    local_38 = static_cast<uint>(38);
    uint _e542 = local_38;
    local_119 = static_cast<uint>(_e542);
    uint _e545 = local_119;
    out[_e545] = static_cast<uint>(_e537);
    int _e548 = int_3_scalar_vector.x;
    local_39 = static_cast<uint>(39);
    uint _e553 = local_39;
    local_120 = static_cast<uint>(_e553);
    uint _e556 = local_120;
    out[_e556] = static_cast<uint>(_e548);
    int _e559 = int_3_scalar_vector.y;
    local_40 = static_cast<uint>(40);
    uint _e564 = local_40;
    local_121 = static_cast<uint>(_e564);
    uint _e567 = local_121;
    out[_e567] = static_cast<uint>(_e559);
    int _e570 = int_3_scalar_vector.z;
    local_41 = static_cast<uint>(41);
    uint _e575 = local_41;
    local_122 = static_cast<uint>(_e575);
    uint _e578 = local_122;
    out[_e578] = static_cast<uint>(_e570);
    int_4_left = metal::int4(1, naga_neg(2), 3, naga_neg(4));
    int_4_right = metal::int4(5, 6, naga_neg(7), 8);
    metal::int4 _e595 = int_4_left;
    metal::int4 _e596 = int_4_right;
    metal::int4 _e597 = operator_u002b_15(_e595, _e596);
    int_4_vectors = _e597;
    metal::int4 _e599 = int_4_left;
    metal::int4 _e601 = operator_u002b_16(_e599, 3);
    int_4_vector_scalar = _e601;
    metal::int4 _e603 = int_4_right;
    metal::int4 _e605 = operator_u002b_17(3, _e603);
    int_4_scalar_vector = _e605;
    int _e608 = int_4_vectors.x;
    local_42 = static_cast<uint>(42);
    uint _e613 = local_42;
    local_123 = static_cast<uint>(_e613);
    uint _e616 = local_123;
    out[_e616] = static_cast<uint>(_e608);
    int _e619 = int_4_vectors.y;
    local_43 = static_cast<uint>(43);
    uint _e624 = local_43;
    local_124 = static_cast<uint>(_e624);
    uint _e627 = local_124;
    out[_e627] = static_cast<uint>(_e619);
    int _e630 = int_4_vectors.z;
    local_44 = static_cast<uint>(44);
    uint _e635 = local_44;
    local_125 = static_cast<uint>(_e635);
    uint _e638 = local_125;
    out[_e638] = static_cast<uint>(_e630);
    int _e641 = int_4_vectors.w;
    local_45 = static_cast<uint>(45);
    uint _e646 = local_45;
    local_126 = static_cast<uint>(_e646);
    uint _e649 = local_126;
    out[_e649] = static_cast<uint>(_e641);
    int _e652 = int_4_vector_scalar.x;
    local_46 = static_cast<uint>(46);
    uint _e657 = local_46;
    local_127 = static_cast<uint>(_e657);
    uint _e660 = local_127;
    out[_e660] = static_cast<uint>(_e652);
    int _e663 = int_4_vector_scalar.y;
    local_47 = static_cast<uint>(47);
    uint _e668 = local_47;
    local_128 = static_cast<uint>(_e668);
    uint _e671 = local_128;
    out[_e671] = static_cast<uint>(_e663);
    int _e674 = int_4_vector_scalar.z;
    local_48 = static_cast<uint>(48);
    uint _e679 = local_48;
    local_129 = static_cast<uint>(_e679);
    uint _e682 = local_129;
    out[_e682] = static_cast<uint>(_e674);
    int _e685 = int_4_vector_scalar.w;
    local_49 = static_cast<uint>(49);
    uint _e690 = local_49;
    local_130 = static_cast<uint>(_e690);
    uint _e693 = local_130;
    out[_e693] = static_cast<uint>(_e685);
    int _e696 = int_4_scalar_vector.x;
    local_50 = static_cast<uint>(50);
    uint _e701 = local_50;
    local_131 = static_cast<uint>(_e701);
    uint _e704 = local_131;
    out[_e704] = static_cast<uint>(_e696);
    int _e707 = int_4_scalar_vector.y;
    local_51 = static_cast<uint>(51);
    uint _e712 = local_51;
    local_132 = static_cast<uint>(_e712);
    uint _e715 = local_132;
    out[_e715] = static_cast<uint>(_e707);
    int _e718 = int_4_scalar_vector.z;
    local_52 = static_cast<uint>(52);
    uint _e723 = local_52;
    local_133 = static_cast<uint>(_e723);
    uint _e726 = local_133;
    out[_e726] = static_cast<uint>(_e718);
    int _e729 = int_4_scalar_vector.w;
    local_53 = static_cast<uint>(53);
    uint _e734 = local_53;
    local_134 = static_cast<uint>(_e734);
    uint _e737 = local_134;
    out[_e737] = static_cast<uint>(_e729);
    uint_2_left = metal::uint2(4294967294u, 2147483649u);
    uint_2_right = metal::uint2(5u, 2u);
    metal::uint2 _e747 = uint_2_left;
    metal::uint2 _e748 = uint_2_right;
    metal::uint2 _e749 = operator_u002b_18(_e747, _e748);
    uint_2_vectors = _e749;
    metal::uint2 _e751 = uint_2_left;
    metal::uint2 _e753 = operator_u002b_19(_e751, 4u);
    uint_2_vector_scalar = _e753;
    metal::uint2 _e755 = uint_2_right;
    metal::uint2 _e757 = operator_u002b_20(4u, _e755);
    uint_2_scalar_vector = _e757;
    uint _e760 = uint_2_vectors.x;
    local_54 = static_cast<uint>(54);
    uint _e764 = local_54;
    local_135 = static_cast<uint>(_e764);
    uint _e767 = local_135;
    out[_e767] = _e760;
    uint _e770 = uint_2_vectors.y;
    local_55 = static_cast<uint>(55);
    uint _e774 = local_55;
    local_136 = static_cast<uint>(_e774);
    uint _e777 = local_136;
    out[_e777] = _e770;
    uint _e780 = uint_2_vector_scalar.x;
    local_56 = static_cast<uint>(56);
    uint _e784 = local_56;
    local_137 = static_cast<uint>(_e784);
    uint _e787 = local_137;
    out[_e787] = _e780;
    uint _e790 = uint_2_vector_scalar.y;
    local_57 = static_cast<uint>(57);
    uint _e794 = local_57;
    local_138 = static_cast<uint>(_e794);
    uint _e797 = local_138;
    out[_e797] = _e790;
    uint _e800 = uint_2_scalar_vector.x;
    local_58 = static_cast<uint>(58);
    uint _e804 = local_58;
    local_139 = static_cast<uint>(_e804);
    uint _e807 = local_139;
    out[_e807] = _e800;
    uint _e810 = uint_2_scalar_vector.y;
    local_59 = static_cast<uint>(59);
    uint _e814 = local_59;
    local_140 = static_cast<uint>(_e814);
    uint _e817 = local_140;
    out[_e817] = _e810;
    uint_3_left = uint3_ {4294967294u, 2147483649u, 3u};
    uint_3_right = uint3_ {5u, 2u, 4294967293u};
    uint3_ _e829 = uint_3_left;
    uint3_ _e830 = uint_3_right;
    uint3_ _e831 = operator_u002b_21(_e829, _e830);
    uint_3_vectors = _e831;
    uint3_ _e833 = uint_3_left;
    uint3_ _e835 = operator_u002b_22(_e833, 4u);
    uint_3_vector_scalar = _e835;
    uint3_ _e837 = uint_3_right;
    uint3_ _e839 = operator_u002b_23(4u, _e837);
    uint_3_scalar_vector = _e839;
    uint _e842 = uint_3_vectors.x;
    local_60 = static_cast<uint>(60);
    uint _e846 = local_60;
    local_141 = static_cast<uint>(_e846);
    uint _e849 = local_141;
    out[_e849] = _e842;
    uint _e852 = uint_3_vectors.y;
    local_61 = static_cast<uint>(61);
    uint _e856 = local_61;
    local_142 = static_cast<uint>(_e856);
    uint _e859 = local_142;
    out[_e859] = _e852;
    uint _e862 = uint_3_vectors.z;
    local_62 = static_cast<uint>(62);
    uint _e866 = local_62;
    local_143 = static_cast<uint>(_e866);
    uint _e869 = local_143;
    out[_e869] = _e862;
    uint _e872 = uint_3_vector_scalar.x;
    local_63 = static_cast<uint>(63);
    uint _e876 = local_63;
    local_144 = static_cast<uint>(_e876);
    uint _e879 = local_144;
    out[_e879] = _e872;
    uint _e882 = uint_3_vector_scalar.y;
    local_64 = static_cast<uint>(64);
    uint _e886 = local_64;
    local_145 = static_cast<uint>(_e886);
    uint _e889 = local_145;
    out[_e889] = _e882;
    uint _e892 = uint_3_vector_scalar.z;
    local_65 = static_cast<uint>(65);
    uint _e896 = local_65;
    local_146 = static_cast<uint>(_e896);
    uint _e899 = local_146;
    out[_e899] = _e892;
    uint _e902 = uint_3_scalar_vector.x;
    local_66 = static_cast<uint>(66);
    uint _e906 = local_66;
    local_147 = static_cast<uint>(_e906);
    uint _e909 = local_147;
    out[_e909] = _e902;
    uint _e912 = uint_3_scalar_vector.y;
    local_67 = static_cast<uint>(67);
    uint _e916 = local_67;
    local_148 = static_cast<uint>(_e916);
    uint _e919 = local_148;
    out[_e919] = _e912;
    uint _e922 = uint_3_scalar_vector.z;
    local_68 = static_cast<uint>(68);
    uint _e926 = local_68;
    local_149 = static_cast<uint>(_e926);
    uint _e929 = local_149;
    out[_e929] = _e922;
    uint_4_left = metal::uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = metal::uint4(5u, 2u, 4294967293u, 1u);
    metal::uint4 _e943 = uint_4_left;
    metal::uint4 _e944 = uint_4_right;
    metal::uint4 _e945 = operator_u002b_24(_e943, _e944);
    uint_4_vectors = _e945;
    metal::uint4 _e947 = uint_4_left;
    metal::uint4 _e949 = operator_u002b_25(_e947, 4u);
    uint_4_vector_scalar = _e949;
    metal::uint4 _e951 = uint_4_right;
    metal::uint4 _e953 = operator_u002b_26(4u, _e951);
    uint_4_scalar_vector = _e953;
    uint _e956 = uint_4_vectors.x;
    local_69 = static_cast<uint>(69);
    uint _e960 = local_69;
    local_150 = static_cast<uint>(_e960);
    uint _e963 = local_150;
    out[_e963] = _e956;
    uint _e966 = uint_4_vectors.y;
    local_70 = static_cast<uint>(70);
    uint _e970 = local_70;
    local_151 = static_cast<uint>(_e970);
    uint _e973 = local_151;
    out[_e973] = _e966;
    uint _e976 = uint_4_vectors.z;
    local_71 = static_cast<uint>(71);
    uint _e980 = local_71;
    local_152 = static_cast<uint>(_e980);
    uint _e983 = local_152;
    out[_e983] = _e976;
    uint _e986 = uint_4_vectors.w;
    local_72 = static_cast<uint>(72);
    uint _e990 = local_72;
    local_153 = static_cast<uint>(_e990);
    uint _e993 = local_153;
    out[_e993] = _e986;
    uint _e996 = uint_4_vector_scalar.x;
    local_73 = static_cast<uint>(73);
    uint _e1000 = local_73;
    local_154 = static_cast<uint>(_e1000);
    uint _e1003 = local_154;
    out[_e1003] = _e996;
    uint _e1006 = uint_4_vector_scalar.y;
    local_74 = static_cast<uint>(74);
    uint _e1010 = local_74;
    local_155 = static_cast<uint>(_e1010);
    uint _e1013 = local_155;
    out[_e1013] = _e1006;
    uint _e1016 = uint_4_vector_scalar.z;
    local_75 = static_cast<uint>(75);
    uint _e1020 = local_75;
    local_156 = static_cast<uint>(_e1020);
    uint _e1023 = local_156;
    out[_e1023] = _e1016;
    uint _e1026 = uint_4_vector_scalar.w;
    local_76 = static_cast<uint>(76);
    uint _e1030 = local_76;
    local_157 = static_cast<uint>(_e1030);
    uint _e1033 = local_157;
    out[_e1033] = _e1026;
    uint _e1036 = uint_4_scalar_vector.x;
    local_77 = static_cast<uint>(77);
    uint _e1040 = local_77;
    local_158 = static_cast<uint>(_e1040);
    uint _e1043 = local_158;
    out[_e1043] = _e1036;
    uint _e1046 = uint_4_scalar_vector.y;
    local_78 = static_cast<uint>(78);
    uint _e1050 = local_78;
    local_159 = static_cast<uint>(_e1050);
    uint _e1053 = local_159;
    out[_e1053] = _e1046;
    uint _e1056 = uint_4_scalar_vector.z;
    local_79 = static_cast<uint>(79);
    uint _e1060 = local_79;
    local_160 = static_cast<uint>(_e1060);
    uint _e1063 = local_160;
    out[_e1063] = _e1056;
    uint _e1066 = uint_4_scalar_vector.w;
    local_80 = static_cast<uint>(80);
    uint _e1070 = local_80;
    local_161 = static_cast<uint>(_e1070);
    uint _e1073 = local_161;
    out[_e1073] = _e1066;
}
