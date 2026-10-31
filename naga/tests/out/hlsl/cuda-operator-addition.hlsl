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

RWByteAddressBuffer out_ : register(u0);

float2 operator_u002b(float2 left, float2 right)
{
    float2 left_1 = (float2)0;
    float2 right_1 = (float2)0;

    left_1 = left;
    right_1 = right;
    float _e6 = left_1.x;
    float _e7 = right_1.x;
    float _e11 = left_1.y;
    float _e12 = right_1.y;
    return float2((_e6 + _e7), (_e11 + _e12));
}

float2 operator_u002b_1(float2 left_2, float right_2)
{
    float2 left_3 = (float2)0;

    left_3 = left_2;
    float _e4 = left_3.x;
    float _e7 = left_3.y;
    return float2((_e4 + right_2), (_e7 + right_2));
}

float2 operator_u002b_2(float left_4, float2 right_3)
{
    float2 right_4 = (float2)0;

    right_4 = right_3;
    float _e4 = right_4.x;
    float _e7 = right_4.y;
    return float2((left_4 + _e4), (left_4 + _e7));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

float3_ operator_u002b_3(float3_ left_5, float3_ right_5)
{
    float3_ left_6 = (float3_)0;
    float3_ right_6 = (float3_)0;

    left_6 = left_5;
    right_6 = right_5;
    float _e6 = left_6.x;
    float _e7 = right_6.x;
    float _e11 = left_6.y;
    float _e12 = right_6.y;
    float _e16 = left_6.z;
    float _e17 = right_6.z;
    const float3_ float3_1 = Constructfloat3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
    return float3_1;
}

float3_ operator_u002b_4(float3_ left_7, float right_7)
{
    float3_ left_8 = (float3_)0;

    left_8 = left_7;
    float _e4 = left_8.x;
    float _e7 = left_8.y;
    float _e10 = left_8.z;
    const float3_ float3_2 = Constructfloat3_((_e4 + right_7), (_e7 + right_7), (_e10 + right_7));
    return float3_2;
}

float3_ operator_u002b_5(float left_9, float3_ right_8)
{
    float3_ right_9 = (float3_)0;

    right_9 = right_8;
    float _e4 = right_9.x;
    float _e7 = right_9.y;
    float _e10 = right_9.z;
    const float3_ float3_3 = Constructfloat3_((left_9 + _e4), (left_9 + _e7), (left_9 + _e10));
    return float3_3;
}

float4 operator_u002b_6(float4 left_10, float4 right_10)
{
    float4 left_11 = (float4)0;
    float4 right_11 = (float4)0;

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
    return float4((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

float4 operator_u002b_7(float4 left_12, float right_12)
{
    float4 left_13 = (float4)0;

    left_13 = left_12;
    float _e4 = left_13.x;
    float _e7 = left_13.y;
    float _e10 = left_13.z;
    float _e13 = left_13.w;
    return float4((_e4 + right_12), (_e7 + right_12), (_e10 + right_12), (_e13 + right_12));
}

float4 operator_u002b_8(float left_14, float4 right_13)
{
    float4 right_14 = (float4)0;

    right_14 = right_13;
    float _e4 = right_14.x;
    float _e7 = right_14.y;
    float _e10 = right_14.z;
    float _e13 = right_14.w;
    return float4((left_14 + _e4), (left_14 + _e7), (left_14 + _e10), (left_14 + _e13));
}

int2 operator_u002b_9(int2 left_15, int2 right_15)
{
    int2 left_16 = (int2)0;
    int2 right_16 = (int2)0;

    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return int2(asint(asuint(_e6) + asuint(_e7)), asint(asuint(_e11) + asuint(_e12)));
}

int2 operator_u002b_10(int2 left_17, int right_17)
{
    int2 left_18 = (int2)0;

    left_18 = left_17;
    int _e4 = left_18.x;
    int _e7 = left_18.y;
    return int2(asint(asuint(_e4) + asuint(right_17)), asint(asuint(_e7) + asuint(right_17)));
}

int2 operator_u002b_11(int left_19, int2 right_18)
{
    int2 right_19 = (int2)0;

    right_19 = right_18;
    int _e4 = right_19.x;
    int _e7 = right_19.y;
    return int2(asint(asuint(left_19) + asuint(_e4)), asint(asuint(left_19) + asuint(_e7)));
}

int3_ Constructint3_(int arg0, int arg1, int arg2) {
    int3_ ret = (int3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

int3_ operator_u002b_12(int3_ left_20, int3_ right_20)
{
    int3_ left_21 = (int3_)0;
    int3_ right_21 = (int3_)0;

    left_21 = left_20;
    right_21 = right_20;
    int _e6 = left_21.x;
    int _e7 = right_21.x;
    int _e11 = left_21.y;
    int _e12 = right_21.y;
    int _e16 = left_21.z;
    int _e17 = right_21.z;
    const int3_ int3_1 = Constructint3_(asint(asuint(_e6) + asuint(_e7)), asint(asuint(_e11) + asuint(_e12)), asint(asuint(_e16) + asuint(_e17)));
    return int3_1;
}

int3_ operator_u002b_13(int3_ left_22, int right_22)
{
    int3_ left_23 = (int3_)0;

    left_23 = left_22;
    int _e4 = left_23.x;
    int _e7 = left_23.y;
    int _e10 = left_23.z;
    const int3_ int3_2 = Constructint3_(asint(asuint(_e4) + asuint(right_22)), asint(asuint(_e7) + asuint(right_22)), asint(asuint(_e10) + asuint(right_22)));
    return int3_2;
}

int3_ operator_u002b_14(int left_24, int3_ right_23)
{
    int3_ right_24 = (int3_)0;

    right_24 = right_23;
    int _e4 = right_24.x;
    int _e7 = right_24.y;
    int _e10 = right_24.z;
    const int3_ int3_3 = Constructint3_(asint(asuint(left_24) + asuint(_e4)), asint(asuint(left_24) + asuint(_e7)), asint(asuint(left_24) + asuint(_e10)));
    return int3_3;
}

int4 operator_u002b_15(int4 left_25, int4 right_25)
{
    int4 left_26 = (int4)0;
    int4 right_26 = (int4)0;

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
    return int4(asint(asuint(_e6) + asuint(_e7)), asint(asuint(_e11) + asuint(_e12)), asint(asuint(_e16) + asuint(_e17)), asint(asuint(_e21) + asuint(_e22)));
}

int4 operator_u002b_16(int4 left_27, int right_27)
{
    int4 left_28 = (int4)0;

    left_28 = left_27;
    int _e4 = left_28.x;
    int _e7 = left_28.y;
    int _e10 = left_28.z;
    int _e13 = left_28.w;
    return int4(asint(asuint(_e4) + asuint(right_27)), asint(asuint(_e7) + asuint(right_27)), asint(asuint(_e10) + asuint(right_27)), asint(asuint(_e13) + asuint(right_27)));
}

int4 operator_u002b_17(int left_29, int4 right_28)
{
    int4 right_29 = (int4)0;

    right_29 = right_28;
    int _e4 = right_29.x;
    int _e7 = right_29.y;
    int _e10 = right_29.z;
    int _e13 = right_29.w;
    return int4(asint(asuint(left_29) + asuint(_e4)), asint(asuint(left_29) + asuint(_e7)), asint(asuint(left_29) + asuint(_e10)), asint(asuint(left_29) + asuint(_e13)));
}

uint2 operator_u002b_18(uint2 left_30, uint2 right_30)
{
    uint2 left_31 = (uint2)0;
    uint2 right_31 = (uint2)0;

    left_31 = left_30;
    right_31 = right_30;
    uint _e6 = left_31.x;
    uint _e7 = right_31.x;
    uint _e11 = left_31.y;
    uint _e12 = right_31.y;
    return uint2((_e6 + _e7), (_e11 + _e12));
}

uint2 operator_u002b_19(uint2 left_32, uint right_32)
{
    uint2 left_33 = (uint2)0;

    left_33 = left_32;
    uint _e4 = left_33.x;
    uint _e7 = left_33.y;
    return uint2((_e4 + right_32), (_e7 + right_32));
}

uint2 operator_u002b_20(uint left_34, uint2 right_33)
{
    uint2 right_34 = (uint2)0;

    right_34 = right_33;
    uint _e4 = right_34.x;
    uint _e7 = right_34.y;
    return uint2((left_34 + _e4), (left_34 + _e7));
}

uint3_ Constructuint3_(uint arg0, uint arg1, uint arg2) {
    uint3_ ret = (uint3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint3_ operator_u002b_21(uint3_ left_35, uint3_ right_35)
{
    uint3_ left_36 = (uint3_)0;
    uint3_ right_36 = (uint3_)0;

    left_36 = left_35;
    right_36 = right_35;
    uint _e6 = left_36.x;
    uint _e7 = right_36.x;
    uint _e11 = left_36.y;
    uint _e12 = right_36.y;
    uint _e16 = left_36.z;
    uint _e17 = right_36.z;
    const uint3_ uint3_1 = Constructuint3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
    return uint3_1;
}

uint3_ operator_u002b_22(uint3_ left_37, uint right_37)
{
    uint3_ left_38 = (uint3_)0;

    left_38 = left_37;
    uint _e4 = left_38.x;
    uint _e7 = left_38.y;
    uint _e10 = left_38.z;
    const uint3_ uint3_2 = Constructuint3_((_e4 + right_37), (_e7 + right_37), (_e10 + right_37));
    return uint3_2;
}

uint3_ operator_u002b_23(uint left_39, uint3_ right_38)
{
    uint3_ right_39 = (uint3_)0;

    right_39 = right_38;
    uint _e4 = right_39.x;
    uint _e7 = right_39.y;
    uint _e10 = right_39.z;
    const uint3_ uint3_3 = Constructuint3_((left_39 + _e4), (left_39 + _e7), (left_39 + _e10));
    return uint3_3;
}

uint4 operator_u002b_24(uint4 left_40, uint4 right_40)
{
    uint4 left_41 = (uint4)0;
    uint4 right_41 = (uint4)0;

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
    return uint4((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

uint4 operator_u002b_25(uint4 left_42, uint right_42)
{
    uint4 left_43 = (uint4)0;

    left_43 = left_42;
    uint _e4 = left_43.x;
    uint _e7 = left_43.y;
    uint _e10 = left_43.z;
    uint _e13 = left_43.w;
    return uint4((_e4 + right_42), (_e7 + right_42), (_e10 + right_42), (_e13 + right_42));
}

uint4 operator_u002b_26(uint left_44, uint4 right_43)
{
    uint4 right_44 = (uint4)0;

    right_44 = right_43;
    uint _e4 = right_44.x;
    uint _e7 = right_44.y;
    uint _e10 = right_44.z;
    uint _e13 = right_44.w;
    return uint4((left_44 + _e4), (left_44 + _e7), (left_44 + _e10), (left_44 + _e13));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void additions()
{
    float2 float_2_left = (float2)0;
    float2 float_2_right = (float2)0;
    float2 float_2_vectors = (float2)0;
    float2 float_2_vector_scalar = (float2)0;
    float2 float_2_scalar_vector = (float2)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    float3_ float_3_left = (float3_)0;
    float3_ float_3_right = (float3_)0;
    float3_ float_3_vectors = (float3_)0;
    float3_ float_3_vector_scalar = (float3_)0;
    float3_ float_3_scalar_vector = (float3_)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float4 float_4_left = (float4)0;
    float4 float_4_right = (float4)0;
    float4 float_4_vectors = (float4)0;
    float4 float_4_vector_scalar = (float4)0;
    float4 float_4_scalar_vector = (float4)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    int2 int_2_left = (int2)0;
    int2 int_2_right = (int2)0;
    int2 int_2_vectors = (int2)0;
    int2 int_2_vector_scalar = (int2)0;
    int2 int_2_scalar_vector = (int2)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    int3_ int_3_left = (int3_)0;
    int3_ int_3_right = (int3_)0;
    int3_ int_3_vectors = (int3_)0;
    int3_ int_3_vector_scalar = (int3_)0;
    int3_ int_3_scalar_vector = (int3_)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    int4 int_4_left = (int4)0;
    int4 int_4_right = (int4)0;
    int4 int_4_vectors = (int4)0;
    int4 int_4_vector_scalar = (int4)0;
    int4 int_4_scalar_vector = (int4)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint2 uint_2_left = (uint2)0;
    uint2 uint_2_right = (uint2)0;
    uint2 uint_2_vectors = (uint2)0;
    uint2 uint_2_vector_scalar = (uint2)0;
    uint2 uint_2_scalar_vector = (uint2)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint3_ uint_3_left = (uint3_)0;
    uint3_ uint_3_right = (uint3_)0;
    uint3_ uint_3_vectors = (uint3_)0;
    uint3_ uint_3_vector_scalar = (uint3_)0;
    uint3_ uint_3_scalar_vector = (uint3_)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint4 uint_4_left = (uint4)0;
    uint4 uint_4_right = (uint4)0;
    uint4 uint_4_vectors = (uint4)0;
    uint4 uint_4_vector_scalar = (uint4)0;
    uint4 uint_4_scalar_vector = (uint4)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138 = (uint)0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    uint local_147 = (uint)0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;
    uint local_153 = (uint)0;
    uint local_154 = (uint)0;
    uint local_155 = (uint)0;
    uint local_156 = (uint)0;
    uint local_157 = (uint)0;
    uint local_158 = (uint)0;
    uint local_159 = (uint)0;
    uint local_160 = (uint)0;
    uint local_161 = (uint)0;

    float_2_left = float2(1.25, -(2.5));
    float_2_right = float2(0.5, 1.5);
    float2 _e9 = float_2_left;
    float2 _e10 = float_2_right;
    const float2 _e11 = operator_u002b(_e9, _e10);
    float_2_vectors = _e11;
    float2 _e13 = float_2_left;
    const float2 _e15 = operator_u002b_1(_e13, 2.0);
    float_2_vector_scalar = _e15;
    float2 _e17 = float_2_right;
    const float2 _e19 = operator_u002b_2(2.0, _e17);
    float_2_scalar_vector = _e19;
    float _e22 = float_2_vectors.x;
    local = uint(int(0));
    uint _e28 = local;
    local_81 = uint(_e28);
    uint _e31 = local_81;
    out_.Store(_e31*4, asuint(asuint(_e22)));
    float _e34 = float_2_vectors.y;
    local_1 = uint(int(1));
    uint _e39 = local_1;
    local_82 = uint(_e39);
    uint _e42 = local_82;
    out_.Store(_e42*4, asuint(asuint(_e34)));
    float _e45 = float_2_vector_scalar.x;
    local_2 = uint(int(2));
    uint _e50 = local_2;
    local_83 = uint(_e50);
    uint _e53 = local_83;
    out_.Store(_e53*4, asuint(asuint(_e45)));
    float _e56 = float_2_vector_scalar.y;
    local_3 = uint(int(3));
    uint _e61 = local_3;
    local_84 = uint(_e61);
    uint _e64 = local_84;
    out_.Store(_e64*4, asuint(asuint(_e56)));
    float _e67 = float_2_scalar_vector.x;
    local_4 = uint(int(4));
    uint _e72 = local_4;
    local_85 = uint(_e72);
    uint _e75 = local_85;
    out_.Store(_e75*4, asuint(asuint(_e67)));
    float _e78 = float_2_scalar_vector.y;
    local_5 = uint(int(5));
    uint _e83 = local_5;
    local_86 = uint(_e83);
    uint _e86 = local_86;
    out_.Store(_e86*4, asuint(asuint(_e78)));
    float_3_left = Constructfloat3_(1.25, -(2.5), 3.75);
    float_3_right = Constructfloat3_(0.5, 1.5, -(2.0));
    float3_ _e100 = float_3_left;
    float3_ _e101 = float_3_right;
    const float3_ _e102 = operator_u002b_3(_e100, _e101);
    float_3_vectors = _e102;
    float3_ _e104 = float_3_left;
    const float3_ _e106 = operator_u002b_4(_e104, 2.0);
    float_3_vector_scalar = _e106;
    float3_ _e108 = float_3_right;
    const float3_ _e110 = operator_u002b_5(2.0, _e108);
    float_3_scalar_vector = _e110;
    float _e113 = float_3_vectors.x;
    local_6 = uint(int(6));
    uint _e118 = local_6;
    local_87 = uint(_e118);
    uint _e121 = local_87;
    out_.Store(_e121*4, asuint(asuint(_e113)));
    float _e124 = float_3_vectors.y;
    local_7 = uint(int(7));
    uint _e129 = local_7;
    local_88 = uint(_e129);
    uint _e132 = local_88;
    out_.Store(_e132*4, asuint(asuint(_e124)));
    float _e135 = float_3_vectors.z;
    local_8 = uint(int(8));
    uint _e140 = local_8;
    local_89 = uint(_e140);
    uint _e143 = local_89;
    out_.Store(_e143*4, asuint(asuint(_e135)));
    float _e146 = float_3_vector_scalar.x;
    local_9 = uint(int(9));
    uint _e151 = local_9;
    local_90 = uint(_e151);
    uint _e154 = local_90;
    out_.Store(_e154*4, asuint(asuint(_e146)));
    float _e157 = float_3_vector_scalar.y;
    local_10 = uint(int(10));
    uint _e162 = local_10;
    local_91 = uint(_e162);
    uint _e165 = local_91;
    out_.Store(_e165*4, asuint(asuint(_e157)));
    float _e168 = float_3_vector_scalar.z;
    local_11 = uint(int(11));
    uint _e173 = local_11;
    local_92 = uint(_e173);
    uint _e176 = local_92;
    out_.Store(_e176*4, asuint(asuint(_e168)));
    float _e179 = float_3_scalar_vector.x;
    local_12 = uint(int(12));
    uint _e184 = local_12;
    local_93 = uint(_e184);
    uint _e187 = local_93;
    out_.Store(_e187*4, asuint(asuint(_e179)));
    float _e190 = float_3_scalar_vector.y;
    local_13 = uint(int(13));
    uint _e195 = local_13;
    local_94 = uint(_e195);
    uint _e198 = local_94;
    out_.Store(_e198*4, asuint(asuint(_e190)));
    float _e201 = float_3_scalar_vector.z;
    local_14 = uint(int(14));
    uint _e206 = local_14;
    local_95 = uint(_e206);
    uint _e209 = local_95;
    out_.Store(_e209*4, asuint(asuint(_e201)));
    float_4_left = float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = float4(0.5, 1.5, -(2.0), 0.25);
    float4 _e226 = float_4_left;
    float4 _e227 = float_4_right;
    const float4 _e228 = operator_u002b_6(_e226, _e227);
    float_4_vectors = _e228;
    float4 _e230 = float_4_left;
    const float4 _e232 = operator_u002b_7(_e230, 2.0);
    float_4_vector_scalar = _e232;
    float4 _e234 = float_4_right;
    const float4 _e236 = operator_u002b_8(2.0, _e234);
    float_4_scalar_vector = _e236;
    float _e239 = float_4_vectors.x;
    local_15 = uint(int(15));
    uint _e244 = local_15;
    local_96 = uint(_e244);
    uint _e247 = local_96;
    out_.Store(_e247*4, asuint(asuint(_e239)));
    float _e250 = float_4_vectors.y;
    local_16 = uint(int(16));
    uint _e255 = local_16;
    local_97 = uint(_e255);
    uint _e258 = local_97;
    out_.Store(_e258*4, asuint(asuint(_e250)));
    float _e261 = float_4_vectors.z;
    local_17 = uint(int(17));
    uint _e266 = local_17;
    local_98 = uint(_e266);
    uint _e269 = local_98;
    out_.Store(_e269*4, asuint(asuint(_e261)));
    float _e272 = float_4_vectors.w;
    local_18 = uint(int(18));
    uint _e277 = local_18;
    local_99 = uint(_e277);
    uint _e280 = local_99;
    out_.Store(_e280*4, asuint(asuint(_e272)));
    float _e283 = float_4_vector_scalar.x;
    local_19 = uint(int(19));
    uint _e288 = local_19;
    local_100 = uint(_e288);
    uint _e291 = local_100;
    out_.Store(_e291*4, asuint(asuint(_e283)));
    float _e294 = float_4_vector_scalar.y;
    local_20 = uint(int(20));
    uint _e299 = local_20;
    local_101 = uint(_e299);
    uint _e302 = local_101;
    out_.Store(_e302*4, asuint(asuint(_e294)));
    float _e305 = float_4_vector_scalar.z;
    local_21 = uint(int(21));
    uint _e310 = local_21;
    local_102 = uint(_e310);
    uint _e313 = local_102;
    out_.Store(_e313*4, asuint(asuint(_e305)));
    float _e316 = float_4_vector_scalar.w;
    local_22 = uint(int(22));
    uint _e321 = local_22;
    local_103 = uint(_e321);
    uint _e324 = local_103;
    out_.Store(_e324*4, asuint(asuint(_e316)));
    float _e327 = float_4_scalar_vector.x;
    local_23 = uint(int(23));
    uint _e332 = local_23;
    local_104 = uint(_e332);
    uint _e335 = local_104;
    out_.Store(_e335*4, asuint(asuint(_e327)));
    float _e338 = float_4_scalar_vector.y;
    local_24 = uint(int(24));
    uint _e343 = local_24;
    local_105 = uint(_e343);
    uint _e346 = local_105;
    out_.Store(_e346*4, asuint(asuint(_e338)));
    float _e349 = float_4_scalar_vector.z;
    local_25 = uint(int(25));
    uint _e354 = local_25;
    local_106 = uint(_e354);
    uint _e357 = local_106;
    out_.Store(_e357*4, asuint(asuint(_e349)));
    float _e360 = float_4_scalar_vector.w;
    local_26 = uint(int(26));
    uint _e365 = local_26;
    local_107 = uint(_e365);
    uint _e368 = local_107;
    out_.Store(_e368*4, asuint(asuint(_e360)));
    int_2_left = int2(int(1), naga_neg(int(2)));
    int_2_right = int2(int(5), int(6));
    int2 _e379 = int_2_left;
    int2 _e380 = int_2_right;
    const int2 _e381 = operator_u002b_9(_e379, _e380);
    int_2_vectors = _e381;
    int2 _e383 = int_2_left;
    const int2 _e385 = operator_u002b_10(_e383, int(3));
    int_2_vector_scalar = _e385;
    int2 _e387 = int_2_right;
    const int2 _e389 = operator_u002b_11(int(3), _e387);
    int_2_scalar_vector = _e389;
    int _e392 = int_2_vectors.x;
    local_27 = uint(int(27));
    uint _e397 = local_27;
    local_108 = uint(_e397);
    uint _e400 = local_108;
    out_.Store(_e400*4, asuint(uint(_e392)));
    int _e403 = int_2_vectors.y;
    local_28 = uint(int(28));
    uint _e408 = local_28;
    local_109 = uint(_e408);
    uint _e411 = local_109;
    out_.Store(_e411*4, asuint(uint(_e403)));
    int _e414 = int_2_vector_scalar.x;
    local_29 = uint(int(29));
    uint _e419 = local_29;
    local_110 = uint(_e419);
    uint _e422 = local_110;
    out_.Store(_e422*4, asuint(uint(_e414)));
    int _e425 = int_2_vector_scalar.y;
    local_30 = uint(int(30));
    uint _e430 = local_30;
    local_111 = uint(_e430);
    uint _e433 = local_111;
    out_.Store(_e433*4, asuint(uint(_e425)));
    int _e436 = int_2_scalar_vector.x;
    local_31 = uint(int(31));
    uint _e441 = local_31;
    local_112 = uint(_e441);
    uint _e444 = local_112;
    out_.Store(_e444*4, asuint(uint(_e436)));
    int _e447 = int_2_scalar_vector.y;
    local_32 = uint(int(32));
    uint _e452 = local_32;
    local_113 = uint(_e452);
    uint _e455 = local_113;
    out_.Store(_e455*4, asuint(uint(_e447)));
    int_3_left = Constructint3_(int(1), naga_neg(int(2)), int(3));
    int_3_right = Constructint3_(int(5), int(6), naga_neg(int(7)));
    int3_ _e469 = int_3_left;
    int3_ _e470 = int_3_right;
    const int3_ _e471 = operator_u002b_12(_e469, _e470);
    int_3_vectors = _e471;
    int3_ _e473 = int_3_left;
    const int3_ _e475 = operator_u002b_13(_e473, int(3));
    int_3_vector_scalar = _e475;
    int3_ _e477 = int_3_right;
    const int3_ _e479 = operator_u002b_14(int(3), _e477);
    int_3_scalar_vector = _e479;
    int _e482 = int_3_vectors.x;
    local_33 = uint(int(33));
    uint _e487 = local_33;
    local_114 = uint(_e487);
    uint _e490 = local_114;
    out_.Store(_e490*4, asuint(uint(_e482)));
    int _e493 = int_3_vectors.y;
    local_34 = uint(int(34));
    uint _e498 = local_34;
    local_115 = uint(_e498);
    uint _e501 = local_115;
    out_.Store(_e501*4, asuint(uint(_e493)));
    int _e504 = int_3_vectors.z;
    local_35 = uint(int(35));
    uint _e509 = local_35;
    local_116 = uint(_e509);
    uint _e512 = local_116;
    out_.Store(_e512*4, asuint(uint(_e504)));
    int _e515 = int_3_vector_scalar.x;
    local_36 = uint(int(36));
    uint _e520 = local_36;
    local_117 = uint(_e520);
    uint _e523 = local_117;
    out_.Store(_e523*4, asuint(uint(_e515)));
    int _e526 = int_3_vector_scalar.y;
    local_37 = uint(int(37));
    uint _e531 = local_37;
    local_118 = uint(_e531);
    uint _e534 = local_118;
    out_.Store(_e534*4, asuint(uint(_e526)));
    int _e537 = int_3_vector_scalar.z;
    local_38 = uint(int(38));
    uint _e542 = local_38;
    local_119 = uint(_e542);
    uint _e545 = local_119;
    out_.Store(_e545*4, asuint(uint(_e537)));
    int _e548 = int_3_scalar_vector.x;
    local_39 = uint(int(39));
    uint _e553 = local_39;
    local_120 = uint(_e553);
    uint _e556 = local_120;
    out_.Store(_e556*4, asuint(uint(_e548)));
    int _e559 = int_3_scalar_vector.y;
    local_40 = uint(int(40));
    uint _e564 = local_40;
    local_121 = uint(_e564);
    uint _e567 = local_121;
    out_.Store(_e567*4, asuint(uint(_e559)));
    int _e570 = int_3_scalar_vector.z;
    local_41 = uint(int(41));
    uint _e575 = local_41;
    local_122 = uint(_e575);
    uint _e578 = local_122;
    out_.Store(_e578*4, asuint(uint(_e570)));
    int_4_left = int4(int(1), naga_neg(int(2)), int(3), naga_neg(int(4)));
    int_4_right = int4(int(5), int(6), naga_neg(int(7)), int(8));
    int4 _e595 = int_4_left;
    int4 _e596 = int_4_right;
    const int4 _e597 = operator_u002b_15(_e595, _e596);
    int_4_vectors = _e597;
    int4 _e599 = int_4_left;
    const int4 _e601 = operator_u002b_16(_e599, int(3));
    int_4_vector_scalar = _e601;
    int4 _e603 = int_4_right;
    const int4 _e605 = operator_u002b_17(int(3), _e603);
    int_4_scalar_vector = _e605;
    int _e608 = int_4_vectors.x;
    local_42 = uint(int(42));
    uint _e613 = local_42;
    local_123 = uint(_e613);
    uint _e616 = local_123;
    out_.Store(_e616*4, asuint(uint(_e608)));
    int _e619 = int_4_vectors.y;
    local_43 = uint(int(43));
    uint _e624 = local_43;
    local_124 = uint(_e624);
    uint _e627 = local_124;
    out_.Store(_e627*4, asuint(uint(_e619)));
    int _e630 = int_4_vectors.z;
    local_44 = uint(int(44));
    uint _e635 = local_44;
    local_125 = uint(_e635);
    uint _e638 = local_125;
    out_.Store(_e638*4, asuint(uint(_e630)));
    int _e641 = int_4_vectors.w;
    local_45 = uint(int(45));
    uint _e646 = local_45;
    local_126 = uint(_e646);
    uint _e649 = local_126;
    out_.Store(_e649*4, asuint(uint(_e641)));
    int _e652 = int_4_vector_scalar.x;
    local_46 = uint(int(46));
    uint _e657 = local_46;
    local_127 = uint(_e657);
    uint _e660 = local_127;
    out_.Store(_e660*4, asuint(uint(_e652)));
    int _e663 = int_4_vector_scalar.y;
    local_47 = uint(int(47));
    uint _e668 = local_47;
    local_128 = uint(_e668);
    uint _e671 = local_128;
    out_.Store(_e671*4, asuint(uint(_e663)));
    int _e674 = int_4_vector_scalar.z;
    local_48 = uint(int(48));
    uint _e679 = local_48;
    local_129 = uint(_e679);
    uint _e682 = local_129;
    out_.Store(_e682*4, asuint(uint(_e674)));
    int _e685 = int_4_vector_scalar.w;
    local_49 = uint(int(49));
    uint _e690 = local_49;
    local_130 = uint(_e690);
    uint _e693 = local_130;
    out_.Store(_e693*4, asuint(uint(_e685)));
    int _e696 = int_4_scalar_vector.x;
    local_50 = uint(int(50));
    uint _e701 = local_50;
    local_131 = uint(_e701);
    uint _e704 = local_131;
    out_.Store(_e704*4, asuint(uint(_e696)));
    int _e707 = int_4_scalar_vector.y;
    local_51 = uint(int(51));
    uint _e712 = local_51;
    local_132 = uint(_e712);
    uint _e715 = local_132;
    out_.Store(_e715*4, asuint(uint(_e707)));
    int _e718 = int_4_scalar_vector.z;
    local_52 = uint(int(52));
    uint _e723 = local_52;
    local_133 = uint(_e723);
    uint _e726 = local_133;
    out_.Store(_e726*4, asuint(uint(_e718)));
    int _e729 = int_4_scalar_vector.w;
    local_53 = uint(int(53));
    uint _e734 = local_53;
    local_134 = uint(_e734);
    uint _e737 = local_134;
    out_.Store(_e737*4, asuint(uint(_e729)));
    uint_2_left = uint2(4294967294u, 2147483649u);
    uint_2_right = uint2(5u, 2u);
    uint2 _e747 = uint_2_left;
    uint2 _e748 = uint_2_right;
    const uint2 _e749 = operator_u002b_18(_e747, _e748);
    uint_2_vectors = _e749;
    uint2 _e751 = uint_2_left;
    const uint2 _e753 = operator_u002b_19(_e751, 4u);
    uint_2_vector_scalar = _e753;
    uint2 _e755 = uint_2_right;
    const uint2 _e757 = operator_u002b_20(4u, _e755);
    uint_2_scalar_vector = _e757;
    uint _e760 = uint_2_vectors.x;
    local_54 = uint(int(54));
    uint _e764 = local_54;
    local_135 = uint(_e764);
    uint _e767 = local_135;
    out_.Store(_e767*4, asuint(_e760));
    uint _e770 = uint_2_vectors.y;
    local_55 = uint(int(55));
    uint _e774 = local_55;
    local_136 = uint(_e774);
    uint _e777 = local_136;
    out_.Store(_e777*4, asuint(_e770));
    uint _e780 = uint_2_vector_scalar.x;
    local_56 = uint(int(56));
    uint _e784 = local_56;
    local_137 = uint(_e784);
    uint _e787 = local_137;
    out_.Store(_e787*4, asuint(_e780));
    uint _e790 = uint_2_vector_scalar.y;
    local_57 = uint(int(57));
    uint _e794 = local_57;
    local_138 = uint(_e794);
    uint _e797 = local_138;
    out_.Store(_e797*4, asuint(_e790));
    uint _e800 = uint_2_scalar_vector.x;
    local_58 = uint(int(58));
    uint _e804 = local_58;
    local_139 = uint(_e804);
    uint _e807 = local_139;
    out_.Store(_e807*4, asuint(_e800));
    uint _e810 = uint_2_scalar_vector.y;
    local_59 = uint(int(59));
    uint _e814 = local_59;
    local_140 = uint(_e814);
    uint _e817 = local_140;
    out_.Store(_e817*4, asuint(_e810));
    uint_3_left = Constructuint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = Constructuint3_(5u, 2u, 4294967293u);
    uint3_ _e829 = uint_3_left;
    uint3_ _e830 = uint_3_right;
    const uint3_ _e831 = operator_u002b_21(_e829, _e830);
    uint_3_vectors = _e831;
    uint3_ _e833 = uint_3_left;
    const uint3_ _e835 = operator_u002b_22(_e833, 4u);
    uint_3_vector_scalar = _e835;
    uint3_ _e837 = uint_3_right;
    const uint3_ _e839 = operator_u002b_23(4u, _e837);
    uint_3_scalar_vector = _e839;
    uint _e842 = uint_3_vectors.x;
    local_60 = uint(int(60));
    uint _e846 = local_60;
    local_141 = uint(_e846);
    uint _e849 = local_141;
    out_.Store(_e849*4, asuint(_e842));
    uint _e852 = uint_3_vectors.y;
    local_61 = uint(int(61));
    uint _e856 = local_61;
    local_142 = uint(_e856);
    uint _e859 = local_142;
    out_.Store(_e859*4, asuint(_e852));
    uint _e862 = uint_3_vectors.z;
    local_62 = uint(int(62));
    uint _e866 = local_62;
    local_143 = uint(_e866);
    uint _e869 = local_143;
    out_.Store(_e869*4, asuint(_e862));
    uint _e872 = uint_3_vector_scalar.x;
    local_63 = uint(int(63));
    uint _e876 = local_63;
    local_144 = uint(_e876);
    uint _e879 = local_144;
    out_.Store(_e879*4, asuint(_e872));
    uint _e882 = uint_3_vector_scalar.y;
    local_64 = uint(int(64));
    uint _e886 = local_64;
    local_145 = uint(_e886);
    uint _e889 = local_145;
    out_.Store(_e889*4, asuint(_e882));
    uint _e892 = uint_3_vector_scalar.z;
    local_65 = uint(int(65));
    uint _e896 = local_65;
    local_146 = uint(_e896);
    uint _e899 = local_146;
    out_.Store(_e899*4, asuint(_e892));
    uint _e902 = uint_3_scalar_vector.x;
    local_66 = uint(int(66));
    uint _e906 = local_66;
    local_147 = uint(_e906);
    uint _e909 = local_147;
    out_.Store(_e909*4, asuint(_e902));
    uint _e912 = uint_3_scalar_vector.y;
    local_67 = uint(int(67));
    uint _e916 = local_67;
    local_148 = uint(_e916);
    uint _e919 = local_148;
    out_.Store(_e919*4, asuint(_e912));
    uint _e922 = uint_3_scalar_vector.z;
    local_68 = uint(int(68));
    uint _e926 = local_68;
    local_149 = uint(_e926);
    uint _e929 = local_149;
    out_.Store(_e929*4, asuint(_e922));
    uint_4_left = uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = uint4(5u, 2u, 4294967293u, 1u);
    uint4 _e943 = uint_4_left;
    uint4 _e944 = uint_4_right;
    const uint4 _e945 = operator_u002b_24(_e943, _e944);
    uint_4_vectors = _e945;
    uint4 _e947 = uint_4_left;
    const uint4 _e949 = operator_u002b_25(_e947, 4u);
    uint_4_vector_scalar = _e949;
    uint4 _e951 = uint_4_right;
    const uint4 _e953 = operator_u002b_26(4u, _e951);
    uint_4_scalar_vector = _e953;
    uint _e956 = uint_4_vectors.x;
    local_69 = uint(int(69));
    uint _e960 = local_69;
    local_150 = uint(_e960);
    uint _e963 = local_150;
    out_.Store(_e963*4, asuint(_e956));
    uint _e966 = uint_4_vectors.y;
    local_70 = uint(int(70));
    uint _e970 = local_70;
    local_151 = uint(_e970);
    uint _e973 = local_151;
    out_.Store(_e973*4, asuint(_e966));
    uint _e976 = uint_4_vectors.z;
    local_71 = uint(int(71));
    uint _e980 = local_71;
    local_152 = uint(_e980);
    uint _e983 = local_152;
    out_.Store(_e983*4, asuint(_e976));
    uint _e986 = uint_4_vectors.w;
    local_72 = uint(int(72));
    uint _e990 = local_72;
    local_153 = uint(_e990);
    uint _e993 = local_153;
    out_.Store(_e993*4, asuint(_e986));
    uint _e996 = uint_4_vector_scalar.x;
    local_73 = uint(int(73));
    uint _e1000 = local_73;
    local_154 = uint(_e1000);
    uint _e1003 = local_154;
    out_.Store(_e1003*4, asuint(_e996));
    uint _e1006 = uint_4_vector_scalar.y;
    local_74 = uint(int(74));
    uint _e1010 = local_74;
    local_155 = uint(_e1010);
    uint _e1013 = local_155;
    out_.Store(_e1013*4, asuint(_e1006));
    uint _e1016 = uint_4_vector_scalar.z;
    local_75 = uint(int(75));
    uint _e1020 = local_75;
    local_156 = uint(_e1020);
    uint _e1023 = local_156;
    out_.Store(_e1023*4, asuint(_e1016));
    uint _e1026 = uint_4_vector_scalar.w;
    local_76 = uint(int(76));
    uint _e1030 = local_76;
    local_157 = uint(_e1030);
    uint _e1033 = local_157;
    out_.Store(_e1033*4, asuint(_e1026));
    uint _e1036 = uint_4_scalar_vector.x;
    local_77 = uint(int(77));
    uint _e1040 = local_77;
    local_158 = uint(_e1040);
    uint _e1043 = local_158;
    out_.Store(_e1043*4, asuint(_e1036));
    uint _e1046 = uint_4_scalar_vector.y;
    local_78 = uint(int(78));
    uint _e1050 = local_78;
    local_159 = uint(_e1050);
    uint _e1053 = local_159;
    out_.Store(_e1053*4, asuint(_e1046));
    uint _e1056 = uint_4_scalar_vector.z;
    local_79 = uint(int(79));
    uint _e1060 = local_79;
    local_160 = uint(_e1060);
    uint _e1063 = local_160;
    out_.Store(_e1063*4, asuint(_e1056));
    uint _e1066 = uint_4_scalar_vector.w;
    local_80 = uint(int(80));
    uint _e1070 = local_80;
    local_161 = uint(_e1070);
    uint _e1073 = local_161;
    out_.Store(_e1073*4, asuint(_e1066));
}
