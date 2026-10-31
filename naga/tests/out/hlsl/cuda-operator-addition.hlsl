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
    uint _e27 = local;
    out_.Store(_e27*4, asuint(asuint(_e22)));
    float _e31 = float_2_vectors.y;
    local_1 = uint(int(1));
    uint _e36 = local_1;
    out_.Store(_e36*4, asuint(asuint(_e31)));
    float _e39 = float_2_vector_scalar.x;
    local_2 = uint(int(2));
    uint _e44 = local_2;
    out_.Store(_e44*4, asuint(asuint(_e39)));
    float _e47 = float_2_vector_scalar.y;
    local_3 = uint(int(3));
    uint _e52 = local_3;
    out_.Store(_e52*4, asuint(asuint(_e47)));
    float _e55 = float_2_scalar_vector.x;
    local_4 = uint(int(4));
    uint _e60 = local_4;
    out_.Store(_e60*4, asuint(asuint(_e55)));
    float _e63 = float_2_scalar_vector.y;
    local_5 = uint(int(5));
    uint _e68 = local_5;
    out_.Store(_e68*4, asuint(asuint(_e63)));
    float_3_left = Constructfloat3_(1.25, -(2.5), 3.75);
    float_3_right = Constructfloat3_(0.5, 1.5, -(2.0));
    float3_ _e82 = float_3_left;
    float3_ _e83 = float_3_right;
    const float3_ _e84 = operator_u002b_3(_e82, _e83);
    float_3_vectors = _e84;
    float3_ _e86 = float_3_left;
    const float3_ _e88 = operator_u002b_4(_e86, 2.0);
    float_3_vector_scalar = _e88;
    float3_ _e90 = float_3_right;
    const float3_ _e92 = operator_u002b_5(2.0, _e90);
    float_3_scalar_vector = _e92;
    float _e95 = float_3_vectors.x;
    local_6 = uint(int(6));
    uint _e100 = local_6;
    out_.Store(_e100*4, asuint(asuint(_e95)));
    float _e103 = float_3_vectors.y;
    local_7 = uint(int(7));
    uint _e108 = local_7;
    out_.Store(_e108*4, asuint(asuint(_e103)));
    float _e111 = float_3_vectors.z;
    local_8 = uint(int(8));
    uint _e116 = local_8;
    out_.Store(_e116*4, asuint(asuint(_e111)));
    float _e119 = float_3_vector_scalar.x;
    local_9 = uint(int(9));
    uint _e124 = local_9;
    out_.Store(_e124*4, asuint(asuint(_e119)));
    float _e127 = float_3_vector_scalar.y;
    local_10 = uint(int(10));
    uint _e132 = local_10;
    out_.Store(_e132*4, asuint(asuint(_e127)));
    float _e135 = float_3_vector_scalar.z;
    local_11 = uint(int(11));
    uint _e140 = local_11;
    out_.Store(_e140*4, asuint(asuint(_e135)));
    float _e143 = float_3_scalar_vector.x;
    local_12 = uint(int(12));
    uint _e148 = local_12;
    out_.Store(_e148*4, asuint(asuint(_e143)));
    float _e151 = float_3_scalar_vector.y;
    local_13 = uint(int(13));
    uint _e156 = local_13;
    out_.Store(_e156*4, asuint(asuint(_e151)));
    float _e159 = float_3_scalar_vector.z;
    local_14 = uint(int(14));
    uint _e164 = local_14;
    out_.Store(_e164*4, asuint(asuint(_e159)));
    float_4_left = float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = float4(0.5, 1.5, -(2.0), 0.25);
    float4 _e181 = float_4_left;
    float4 _e182 = float_4_right;
    const float4 _e183 = operator_u002b_6(_e181, _e182);
    float_4_vectors = _e183;
    float4 _e185 = float_4_left;
    const float4 _e187 = operator_u002b_7(_e185, 2.0);
    float_4_vector_scalar = _e187;
    float4 _e189 = float_4_right;
    const float4 _e191 = operator_u002b_8(2.0, _e189);
    float_4_scalar_vector = _e191;
    float _e194 = float_4_vectors.x;
    local_15 = uint(int(15));
    uint _e199 = local_15;
    out_.Store(_e199*4, asuint(asuint(_e194)));
    float _e202 = float_4_vectors.y;
    local_16 = uint(int(16));
    uint _e207 = local_16;
    out_.Store(_e207*4, asuint(asuint(_e202)));
    float _e210 = float_4_vectors.z;
    local_17 = uint(int(17));
    uint _e215 = local_17;
    out_.Store(_e215*4, asuint(asuint(_e210)));
    float _e218 = float_4_vectors.w;
    local_18 = uint(int(18));
    uint _e223 = local_18;
    out_.Store(_e223*4, asuint(asuint(_e218)));
    float _e226 = float_4_vector_scalar.x;
    local_19 = uint(int(19));
    uint _e231 = local_19;
    out_.Store(_e231*4, asuint(asuint(_e226)));
    float _e234 = float_4_vector_scalar.y;
    local_20 = uint(int(20));
    uint _e239 = local_20;
    out_.Store(_e239*4, asuint(asuint(_e234)));
    float _e242 = float_4_vector_scalar.z;
    local_21 = uint(int(21));
    uint _e247 = local_21;
    out_.Store(_e247*4, asuint(asuint(_e242)));
    float _e250 = float_4_vector_scalar.w;
    local_22 = uint(int(22));
    uint _e255 = local_22;
    out_.Store(_e255*4, asuint(asuint(_e250)));
    float _e258 = float_4_scalar_vector.x;
    local_23 = uint(int(23));
    uint _e263 = local_23;
    out_.Store(_e263*4, asuint(asuint(_e258)));
    float _e266 = float_4_scalar_vector.y;
    local_24 = uint(int(24));
    uint _e271 = local_24;
    out_.Store(_e271*4, asuint(asuint(_e266)));
    float _e274 = float_4_scalar_vector.z;
    local_25 = uint(int(25));
    uint _e279 = local_25;
    out_.Store(_e279*4, asuint(asuint(_e274)));
    float _e282 = float_4_scalar_vector.w;
    local_26 = uint(int(26));
    uint _e287 = local_26;
    out_.Store(_e287*4, asuint(asuint(_e282)));
    int_2_left = int2(int(1), naga_neg(int(2)));
    int_2_right = int2(int(5), int(6));
    int2 _e298 = int_2_left;
    int2 _e299 = int_2_right;
    const int2 _e300 = operator_u002b_9(_e298, _e299);
    int_2_vectors = _e300;
    int2 _e302 = int_2_left;
    const int2 _e304 = operator_u002b_10(_e302, int(3));
    int_2_vector_scalar = _e304;
    int2 _e306 = int_2_right;
    const int2 _e308 = operator_u002b_11(int(3), _e306);
    int_2_scalar_vector = _e308;
    int _e311 = int_2_vectors.x;
    local_27 = uint(int(27));
    uint _e316 = local_27;
    out_.Store(_e316*4, asuint(uint(_e311)));
    int _e319 = int_2_vectors.y;
    local_28 = uint(int(28));
    uint _e324 = local_28;
    out_.Store(_e324*4, asuint(uint(_e319)));
    int _e327 = int_2_vector_scalar.x;
    local_29 = uint(int(29));
    uint _e332 = local_29;
    out_.Store(_e332*4, asuint(uint(_e327)));
    int _e335 = int_2_vector_scalar.y;
    local_30 = uint(int(30));
    uint _e340 = local_30;
    out_.Store(_e340*4, asuint(uint(_e335)));
    int _e343 = int_2_scalar_vector.x;
    local_31 = uint(int(31));
    uint _e348 = local_31;
    out_.Store(_e348*4, asuint(uint(_e343)));
    int _e351 = int_2_scalar_vector.y;
    local_32 = uint(int(32));
    uint _e356 = local_32;
    out_.Store(_e356*4, asuint(uint(_e351)));
    int_3_left = Constructint3_(int(1), naga_neg(int(2)), int(3));
    int_3_right = Constructint3_(int(5), int(6), naga_neg(int(7)));
    int3_ _e370 = int_3_left;
    int3_ _e371 = int_3_right;
    const int3_ _e372 = operator_u002b_12(_e370, _e371);
    int_3_vectors = _e372;
    int3_ _e374 = int_3_left;
    const int3_ _e376 = operator_u002b_13(_e374, int(3));
    int_3_vector_scalar = _e376;
    int3_ _e378 = int_3_right;
    const int3_ _e380 = operator_u002b_14(int(3), _e378);
    int_3_scalar_vector = _e380;
    int _e383 = int_3_vectors.x;
    local_33 = uint(int(33));
    uint _e388 = local_33;
    out_.Store(_e388*4, asuint(uint(_e383)));
    int _e391 = int_3_vectors.y;
    local_34 = uint(int(34));
    uint _e396 = local_34;
    out_.Store(_e396*4, asuint(uint(_e391)));
    int _e399 = int_3_vectors.z;
    local_35 = uint(int(35));
    uint _e404 = local_35;
    out_.Store(_e404*4, asuint(uint(_e399)));
    int _e407 = int_3_vector_scalar.x;
    local_36 = uint(int(36));
    uint _e412 = local_36;
    out_.Store(_e412*4, asuint(uint(_e407)));
    int _e415 = int_3_vector_scalar.y;
    local_37 = uint(int(37));
    uint _e420 = local_37;
    out_.Store(_e420*4, asuint(uint(_e415)));
    int _e423 = int_3_vector_scalar.z;
    local_38 = uint(int(38));
    uint _e428 = local_38;
    out_.Store(_e428*4, asuint(uint(_e423)));
    int _e431 = int_3_scalar_vector.x;
    local_39 = uint(int(39));
    uint _e436 = local_39;
    out_.Store(_e436*4, asuint(uint(_e431)));
    int _e439 = int_3_scalar_vector.y;
    local_40 = uint(int(40));
    uint _e444 = local_40;
    out_.Store(_e444*4, asuint(uint(_e439)));
    int _e447 = int_3_scalar_vector.z;
    local_41 = uint(int(41));
    uint _e452 = local_41;
    out_.Store(_e452*4, asuint(uint(_e447)));
    int_4_left = int4(int(1), naga_neg(int(2)), int(3), naga_neg(int(4)));
    int_4_right = int4(int(5), int(6), naga_neg(int(7)), int(8));
    int4 _e469 = int_4_left;
    int4 _e470 = int_4_right;
    const int4 _e471 = operator_u002b_15(_e469, _e470);
    int_4_vectors = _e471;
    int4 _e473 = int_4_left;
    const int4 _e475 = operator_u002b_16(_e473, int(3));
    int_4_vector_scalar = _e475;
    int4 _e477 = int_4_right;
    const int4 _e479 = operator_u002b_17(int(3), _e477);
    int_4_scalar_vector = _e479;
    int _e482 = int_4_vectors.x;
    local_42 = uint(int(42));
    uint _e487 = local_42;
    out_.Store(_e487*4, asuint(uint(_e482)));
    int _e490 = int_4_vectors.y;
    local_43 = uint(int(43));
    uint _e495 = local_43;
    out_.Store(_e495*4, asuint(uint(_e490)));
    int _e498 = int_4_vectors.z;
    local_44 = uint(int(44));
    uint _e503 = local_44;
    out_.Store(_e503*4, asuint(uint(_e498)));
    int _e506 = int_4_vectors.w;
    local_45 = uint(int(45));
    uint _e511 = local_45;
    out_.Store(_e511*4, asuint(uint(_e506)));
    int _e514 = int_4_vector_scalar.x;
    local_46 = uint(int(46));
    uint _e519 = local_46;
    out_.Store(_e519*4, asuint(uint(_e514)));
    int _e522 = int_4_vector_scalar.y;
    local_47 = uint(int(47));
    uint _e527 = local_47;
    out_.Store(_e527*4, asuint(uint(_e522)));
    int _e530 = int_4_vector_scalar.z;
    local_48 = uint(int(48));
    uint _e535 = local_48;
    out_.Store(_e535*4, asuint(uint(_e530)));
    int _e538 = int_4_vector_scalar.w;
    local_49 = uint(int(49));
    uint _e543 = local_49;
    out_.Store(_e543*4, asuint(uint(_e538)));
    int _e546 = int_4_scalar_vector.x;
    local_50 = uint(int(50));
    uint _e551 = local_50;
    out_.Store(_e551*4, asuint(uint(_e546)));
    int _e554 = int_4_scalar_vector.y;
    local_51 = uint(int(51));
    uint _e559 = local_51;
    out_.Store(_e559*4, asuint(uint(_e554)));
    int _e562 = int_4_scalar_vector.z;
    local_52 = uint(int(52));
    uint _e567 = local_52;
    out_.Store(_e567*4, asuint(uint(_e562)));
    int _e570 = int_4_scalar_vector.w;
    local_53 = uint(int(53));
    uint _e575 = local_53;
    out_.Store(_e575*4, asuint(uint(_e570)));
    uint_2_left = uint2(4294967294u, 2147483649u);
    uint_2_right = uint2(5u, 2u);
    uint2 _e585 = uint_2_left;
    uint2 _e586 = uint_2_right;
    const uint2 _e587 = operator_u002b_18(_e585, _e586);
    uint_2_vectors = _e587;
    uint2 _e589 = uint_2_left;
    const uint2 _e591 = operator_u002b_19(_e589, 4u);
    uint_2_vector_scalar = _e591;
    uint2 _e593 = uint_2_right;
    const uint2 _e595 = operator_u002b_20(4u, _e593);
    uint_2_scalar_vector = _e595;
    uint _e598 = uint_2_vectors.x;
    local_54 = uint(int(54));
    uint _e602 = local_54;
    out_.Store(_e602*4, asuint(_e598));
    uint _e605 = uint_2_vectors.y;
    local_55 = uint(int(55));
    uint _e609 = local_55;
    out_.Store(_e609*4, asuint(_e605));
    uint _e612 = uint_2_vector_scalar.x;
    local_56 = uint(int(56));
    uint _e616 = local_56;
    out_.Store(_e616*4, asuint(_e612));
    uint _e619 = uint_2_vector_scalar.y;
    local_57 = uint(int(57));
    uint _e623 = local_57;
    out_.Store(_e623*4, asuint(_e619));
    uint _e626 = uint_2_scalar_vector.x;
    local_58 = uint(int(58));
    uint _e630 = local_58;
    out_.Store(_e630*4, asuint(_e626));
    uint _e633 = uint_2_scalar_vector.y;
    local_59 = uint(int(59));
    uint _e637 = local_59;
    out_.Store(_e637*4, asuint(_e633));
    uint_3_left = Constructuint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = Constructuint3_(5u, 2u, 4294967293u);
    uint3_ _e649 = uint_3_left;
    uint3_ _e650 = uint_3_right;
    const uint3_ _e651 = operator_u002b_21(_e649, _e650);
    uint_3_vectors = _e651;
    uint3_ _e653 = uint_3_left;
    const uint3_ _e655 = operator_u002b_22(_e653, 4u);
    uint_3_vector_scalar = _e655;
    uint3_ _e657 = uint_3_right;
    const uint3_ _e659 = operator_u002b_23(4u, _e657);
    uint_3_scalar_vector = _e659;
    uint _e662 = uint_3_vectors.x;
    local_60 = uint(int(60));
    uint _e666 = local_60;
    out_.Store(_e666*4, asuint(_e662));
    uint _e669 = uint_3_vectors.y;
    local_61 = uint(int(61));
    uint _e673 = local_61;
    out_.Store(_e673*4, asuint(_e669));
    uint _e676 = uint_3_vectors.z;
    local_62 = uint(int(62));
    uint _e680 = local_62;
    out_.Store(_e680*4, asuint(_e676));
    uint _e683 = uint_3_vector_scalar.x;
    local_63 = uint(int(63));
    uint _e687 = local_63;
    out_.Store(_e687*4, asuint(_e683));
    uint _e690 = uint_3_vector_scalar.y;
    local_64 = uint(int(64));
    uint _e694 = local_64;
    out_.Store(_e694*4, asuint(_e690));
    uint _e697 = uint_3_vector_scalar.z;
    local_65 = uint(int(65));
    uint _e701 = local_65;
    out_.Store(_e701*4, asuint(_e697));
    uint _e704 = uint_3_scalar_vector.x;
    local_66 = uint(int(66));
    uint _e708 = local_66;
    out_.Store(_e708*4, asuint(_e704));
    uint _e711 = uint_3_scalar_vector.y;
    local_67 = uint(int(67));
    uint _e715 = local_67;
    out_.Store(_e715*4, asuint(_e711));
    uint _e718 = uint_3_scalar_vector.z;
    local_68 = uint(int(68));
    uint _e722 = local_68;
    out_.Store(_e722*4, asuint(_e718));
    uint_4_left = uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = uint4(5u, 2u, 4294967293u, 1u);
    uint4 _e736 = uint_4_left;
    uint4 _e737 = uint_4_right;
    const uint4 _e738 = operator_u002b_24(_e736, _e737);
    uint_4_vectors = _e738;
    uint4 _e740 = uint_4_left;
    const uint4 _e742 = operator_u002b_25(_e740, 4u);
    uint_4_vector_scalar = _e742;
    uint4 _e744 = uint_4_right;
    const uint4 _e746 = operator_u002b_26(4u, _e744);
    uint_4_scalar_vector = _e746;
    uint _e749 = uint_4_vectors.x;
    local_69 = uint(int(69));
    uint _e753 = local_69;
    out_.Store(_e753*4, asuint(_e749));
    uint _e756 = uint_4_vectors.y;
    local_70 = uint(int(70));
    uint _e760 = local_70;
    out_.Store(_e760*4, asuint(_e756));
    uint _e763 = uint_4_vectors.z;
    local_71 = uint(int(71));
    uint _e767 = local_71;
    out_.Store(_e767*4, asuint(_e763));
    uint _e770 = uint_4_vectors.w;
    local_72 = uint(int(72));
    uint _e774 = local_72;
    out_.Store(_e774*4, asuint(_e770));
    uint _e777 = uint_4_vector_scalar.x;
    local_73 = uint(int(73));
    uint _e781 = local_73;
    out_.Store(_e781*4, asuint(_e777));
    uint _e784 = uint_4_vector_scalar.y;
    local_74 = uint(int(74));
    uint _e788 = local_74;
    out_.Store(_e788*4, asuint(_e784));
    uint _e791 = uint_4_vector_scalar.z;
    local_75 = uint(int(75));
    uint _e795 = local_75;
    out_.Store(_e795*4, asuint(_e791));
    uint _e798 = uint_4_vector_scalar.w;
    local_76 = uint(int(76));
    uint _e802 = local_76;
    out_.Store(_e802*4, asuint(_e798));
    uint _e805 = uint_4_scalar_vector.x;
    local_77 = uint(int(77));
    uint _e809 = local_77;
    out_.Store(_e809*4, asuint(_e805));
    uint _e812 = uint_4_scalar_vector.y;
    local_78 = uint(int(78));
    uint _e816 = local_78;
    out_.Store(_e816*4, asuint(_e812));
    uint _e819 = uint_4_scalar_vector.z;
    local_79 = uint(int(79));
    uint _e823 = local_79;
    out_.Store(_e823*4, asuint(_e819));
    uint _e826 = uint_4_scalar_vector.w;
    local_80 = uint(int(80));
    uint _e830 = local_80;
    out_.Store(_e830*4, asuint(_e826));
}
