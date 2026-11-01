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
    float3_ float_3_left = (float3_)0;
    float3_ float_3_right = (float3_)0;
    float3_ float_3_vectors = (float3_)0;
    float3_ float_3_vector_scalar = (float3_)0;
    float3_ float_3_scalar_vector = (float3_)0;
    float4 float_4_left = (float4)0;
    float4 float_4_right = (float4)0;
    float4 float_4_vectors = (float4)0;
    float4 float_4_vector_scalar = (float4)0;
    float4 float_4_scalar_vector = (float4)0;
    int2 int_2_left = (int2)0;
    int2 int_2_right = (int2)0;
    int2 int_2_vectors = (int2)0;
    int2 int_2_vector_scalar = (int2)0;
    int2 int_2_scalar_vector = (int2)0;
    int3_ int_3_left = (int3_)0;
    int3_ int_3_right = (int3_)0;
    int3_ int_3_vectors = (int3_)0;
    int3_ int_3_vector_scalar = (int3_)0;
    int3_ int_3_scalar_vector = (int3_)0;
    int4 int_4_left = (int4)0;
    int4 int_4_right = (int4)0;
    int4 int_4_vectors = (int4)0;
    int4 int_4_vector_scalar = (int4)0;
    int4 int_4_scalar_vector = (int4)0;
    uint2 uint_2_left = (uint2)0;
    uint2 uint_2_right = (uint2)0;
    uint2 uint_2_vectors = (uint2)0;
    uint2 uint_2_vector_scalar = (uint2)0;
    uint2 uint_2_scalar_vector = (uint2)0;
    uint3_ uint_3_left = (uint3_)0;
    uint3_ uint_3_right = (uint3_)0;
    uint3_ uint_3_vectors = (uint3_)0;
    uint3_ uint_3_vector_scalar = (uint3_)0;
    uint3_ uint_3_scalar_vector = (uint3_)0;
    uint4 uint_4_left = (uint4)0;
    uint4 uint_4_right = (uint4)0;
    uint4 uint_4_vectors = (uint4)0;
    uint4 uint_4_vector_scalar = (uint4)0;
    uint4 uint_4_scalar_vector = (uint4)0;

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
    out_.Store(uint(int(0))*4, asuint(asuint(_e22)));
    float _e29 = float_2_vectors.y;
    out_.Store(uint(int(1))*4, asuint(asuint(_e29)));
    float _e35 = float_2_vector_scalar.x;
    out_.Store(uint(int(2))*4, asuint(asuint(_e35)));
    float _e41 = float_2_vector_scalar.y;
    out_.Store(uint(int(3))*4, asuint(asuint(_e41)));
    float _e47 = float_2_scalar_vector.x;
    out_.Store(uint(int(4))*4, asuint(asuint(_e47)));
    float _e53 = float_2_scalar_vector.y;
    out_.Store(uint(int(5))*4, asuint(asuint(_e53)));
    float_3_left = Constructfloat3_(1.25, -(2.5), 3.75);
    float_3_right = Constructfloat3_(0.5, 1.5, -(2.0));
    float3_ _e70 = float_3_left;
    float3_ _e71 = float_3_right;
    const float3_ _e72 = operator_u002b_3(_e70, _e71);
    float_3_vectors = _e72;
    float3_ _e74 = float_3_left;
    const float3_ _e76 = operator_u002b_4(_e74, 2.0);
    float_3_vector_scalar = _e76;
    float3_ _e78 = float_3_right;
    const float3_ _e80 = operator_u002b_5(2.0, _e78);
    float_3_scalar_vector = _e80;
    float _e83 = float_3_vectors.x;
    out_.Store(uint(int(6))*4, asuint(asuint(_e83)));
    float _e89 = float_3_vectors.y;
    out_.Store(uint(int(7))*4, asuint(asuint(_e89)));
    float _e95 = float_3_vectors.z;
    out_.Store(uint(int(8))*4, asuint(asuint(_e95)));
    float _e101 = float_3_vector_scalar.x;
    out_.Store(uint(int(9))*4, asuint(asuint(_e101)));
    float _e107 = float_3_vector_scalar.y;
    out_.Store(uint(int(10))*4, asuint(asuint(_e107)));
    float _e113 = float_3_vector_scalar.z;
    out_.Store(uint(int(11))*4, asuint(asuint(_e113)));
    float _e119 = float_3_scalar_vector.x;
    out_.Store(uint(int(12))*4, asuint(asuint(_e119)));
    float _e125 = float_3_scalar_vector.y;
    out_.Store(uint(int(13))*4, asuint(asuint(_e125)));
    float _e131 = float_3_scalar_vector.z;
    out_.Store(uint(int(14))*4, asuint(asuint(_e131)));
    float_4_left = float4(1.25, -(2.5), 3.75, -(4.0));
    float_4_right = float4(0.5, 1.5, -(2.0), 0.25);
    float4 _e151 = float_4_left;
    float4 _e152 = float_4_right;
    const float4 _e153 = operator_u002b_6(_e151, _e152);
    float_4_vectors = _e153;
    float4 _e155 = float_4_left;
    const float4 _e157 = operator_u002b_7(_e155, 2.0);
    float_4_vector_scalar = _e157;
    float4 _e159 = float_4_right;
    const float4 _e161 = operator_u002b_8(2.0, _e159);
    float_4_scalar_vector = _e161;
    float _e164 = float_4_vectors.x;
    out_.Store(uint(int(15))*4, asuint(asuint(_e164)));
    float _e170 = float_4_vectors.y;
    out_.Store(uint(int(16))*4, asuint(asuint(_e170)));
    float _e176 = float_4_vectors.z;
    out_.Store(uint(int(17))*4, asuint(asuint(_e176)));
    float _e182 = float_4_vectors.w;
    out_.Store(uint(int(18))*4, asuint(asuint(_e182)));
    float _e188 = float_4_vector_scalar.x;
    out_.Store(uint(int(19))*4, asuint(asuint(_e188)));
    float _e194 = float_4_vector_scalar.y;
    out_.Store(uint(int(20))*4, asuint(asuint(_e194)));
    float _e200 = float_4_vector_scalar.z;
    out_.Store(uint(int(21))*4, asuint(asuint(_e200)));
    float _e206 = float_4_vector_scalar.w;
    out_.Store(uint(int(22))*4, asuint(asuint(_e206)));
    float _e212 = float_4_scalar_vector.x;
    out_.Store(uint(int(23))*4, asuint(asuint(_e212)));
    float _e218 = float_4_scalar_vector.y;
    out_.Store(uint(int(24))*4, asuint(asuint(_e218)));
    float _e224 = float_4_scalar_vector.z;
    out_.Store(uint(int(25))*4, asuint(asuint(_e224)));
    float _e230 = float_4_scalar_vector.w;
    out_.Store(uint(int(26))*4, asuint(asuint(_e230)));
    int_2_left = int2(int(1), naga_neg(int(2)));
    int_2_right = int2(int(5), int(6));
    int2 _e244 = int_2_left;
    int2 _e245 = int_2_right;
    const int2 _e246 = operator_u002b_9(_e244, _e245);
    int_2_vectors = _e246;
    int2 _e248 = int_2_left;
    const int2 _e250 = operator_u002b_10(_e248, int(3));
    int_2_vector_scalar = _e250;
    int2 _e252 = int_2_right;
    const int2 _e254 = operator_u002b_11(int(3), _e252);
    int_2_scalar_vector = _e254;
    int _e257 = int_2_vectors.x;
    out_.Store(uint(int(27))*4, asuint(uint(_e257)));
    int _e263 = int_2_vectors.y;
    out_.Store(uint(int(28))*4, asuint(uint(_e263)));
    int _e269 = int_2_vector_scalar.x;
    out_.Store(uint(int(29))*4, asuint(uint(_e269)));
    int _e275 = int_2_vector_scalar.y;
    out_.Store(uint(int(30))*4, asuint(uint(_e275)));
    int _e281 = int_2_scalar_vector.x;
    out_.Store(uint(int(31))*4, asuint(uint(_e281)));
    int _e287 = int_2_scalar_vector.y;
    out_.Store(uint(int(32))*4, asuint(uint(_e287)));
    int_3_left = Constructint3_(int(1), naga_neg(int(2)), int(3));
    int_3_right = Constructint3_(int(5), int(6), naga_neg(int(7)));
    int3_ _e304 = int_3_left;
    int3_ _e305 = int_3_right;
    const int3_ _e306 = operator_u002b_12(_e304, _e305);
    int_3_vectors = _e306;
    int3_ _e308 = int_3_left;
    const int3_ _e310 = operator_u002b_13(_e308, int(3));
    int_3_vector_scalar = _e310;
    int3_ _e312 = int_3_right;
    const int3_ _e314 = operator_u002b_14(int(3), _e312);
    int_3_scalar_vector = _e314;
    int _e317 = int_3_vectors.x;
    out_.Store(uint(int(33))*4, asuint(uint(_e317)));
    int _e323 = int_3_vectors.y;
    out_.Store(uint(int(34))*4, asuint(uint(_e323)));
    int _e329 = int_3_vectors.z;
    out_.Store(uint(int(35))*4, asuint(uint(_e329)));
    int _e335 = int_3_vector_scalar.x;
    out_.Store(uint(int(36))*4, asuint(uint(_e335)));
    int _e341 = int_3_vector_scalar.y;
    out_.Store(uint(int(37))*4, asuint(uint(_e341)));
    int _e347 = int_3_vector_scalar.z;
    out_.Store(uint(int(38))*4, asuint(uint(_e347)));
    int _e353 = int_3_scalar_vector.x;
    out_.Store(uint(int(39))*4, asuint(uint(_e353)));
    int _e359 = int_3_scalar_vector.y;
    out_.Store(uint(int(40))*4, asuint(uint(_e359)));
    int _e365 = int_3_scalar_vector.z;
    out_.Store(uint(int(41))*4, asuint(uint(_e365)));
    int_4_left = int4(int(1), naga_neg(int(2)), int(3), naga_neg(int(4)));
    int_4_right = int4(int(5), int(6), naga_neg(int(7)), int(8));
    int4 _e385 = int_4_left;
    int4 _e386 = int_4_right;
    const int4 _e387 = operator_u002b_15(_e385, _e386);
    int_4_vectors = _e387;
    int4 _e389 = int_4_left;
    const int4 _e391 = operator_u002b_16(_e389, int(3));
    int_4_vector_scalar = _e391;
    int4 _e393 = int_4_right;
    const int4 _e395 = operator_u002b_17(int(3), _e393);
    int_4_scalar_vector = _e395;
    int _e398 = int_4_vectors.x;
    out_.Store(uint(int(42))*4, asuint(uint(_e398)));
    int _e404 = int_4_vectors.y;
    out_.Store(uint(int(43))*4, asuint(uint(_e404)));
    int _e410 = int_4_vectors.z;
    out_.Store(uint(int(44))*4, asuint(uint(_e410)));
    int _e416 = int_4_vectors.w;
    out_.Store(uint(int(45))*4, asuint(uint(_e416)));
    int _e422 = int_4_vector_scalar.x;
    out_.Store(uint(int(46))*4, asuint(uint(_e422)));
    int _e428 = int_4_vector_scalar.y;
    out_.Store(uint(int(47))*4, asuint(uint(_e428)));
    int _e434 = int_4_vector_scalar.z;
    out_.Store(uint(int(48))*4, asuint(uint(_e434)));
    int _e440 = int_4_vector_scalar.w;
    out_.Store(uint(int(49))*4, asuint(uint(_e440)));
    int _e446 = int_4_scalar_vector.x;
    out_.Store(uint(int(50))*4, asuint(uint(_e446)));
    int _e452 = int_4_scalar_vector.y;
    out_.Store(uint(int(51))*4, asuint(uint(_e452)));
    int _e458 = int_4_scalar_vector.z;
    out_.Store(uint(int(52))*4, asuint(uint(_e458)));
    int _e464 = int_4_scalar_vector.w;
    out_.Store(uint(int(53))*4, asuint(uint(_e464)));
    uint_2_left = uint2(4294967294u, 2147483649u);
    uint_2_right = uint2(5u, 2u);
    uint2 _e477 = uint_2_left;
    uint2 _e478 = uint_2_right;
    const uint2 _e479 = operator_u002b_18(_e477, _e478);
    uint_2_vectors = _e479;
    uint2 _e481 = uint_2_left;
    const uint2 _e483 = operator_u002b_19(_e481, 4u);
    uint_2_vector_scalar = _e483;
    uint2 _e485 = uint_2_right;
    const uint2 _e487 = operator_u002b_20(4u, _e485);
    uint_2_scalar_vector = _e487;
    uint _e490 = uint_2_vectors.x;
    out_.Store(uint(int(54))*4, asuint(_e490));
    uint _e495 = uint_2_vectors.y;
    out_.Store(uint(int(55))*4, asuint(_e495));
    uint _e500 = uint_2_vector_scalar.x;
    out_.Store(uint(int(56))*4, asuint(_e500));
    uint _e505 = uint_2_vector_scalar.y;
    out_.Store(uint(int(57))*4, asuint(_e505));
    uint _e510 = uint_2_scalar_vector.x;
    out_.Store(uint(int(58))*4, asuint(_e510));
    uint _e515 = uint_2_scalar_vector.y;
    out_.Store(uint(int(59))*4, asuint(_e515));
    uint_3_left = Constructuint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = Constructuint3_(5u, 2u, 4294967293u);
    uint3_ _e529 = uint_3_left;
    uint3_ _e530 = uint_3_right;
    const uint3_ _e531 = operator_u002b_21(_e529, _e530);
    uint_3_vectors = _e531;
    uint3_ _e533 = uint_3_left;
    const uint3_ _e535 = operator_u002b_22(_e533, 4u);
    uint_3_vector_scalar = _e535;
    uint3_ _e537 = uint_3_right;
    const uint3_ _e539 = operator_u002b_23(4u, _e537);
    uint_3_scalar_vector = _e539;
    uint _e542 = uint_3_vectors.x;
    out_.Store(uint(int(60))*4, asuint(_e542));
    uint _e547 = uint_3_vectors.y;
    out_.Store(uint(int(61))*4, asuint(_e547));
    uint _e552 = uint_3_vectors.z;
    out_.Store(uint(int(62))*4, asuint(_e552));
    uint _e557 = uint_3_vector_scalar.x;
    out_.Store(uint(int(63))*4, asuint(_e557));
    uint _e562 = uint_3_vector_scalar.y;
    out_.Store(uint(int(64))*4, asuint(_e562));
    uint _e567 = uint_3_vector_scalar.z;
    out_.Store(uint(int(65))*4, asuint(_e567));
    uint _e572 = uint_3_scalar_vector.x;
    out_.Store(uint(int(66))*4, asuint(_e572));
    uint _e577 = uint_3_scalar_vector.y;
    out_.Store(uint(int(67))*4, asuint(_e577));
    uint _e582 = uint_3_scalar_vector.z;
    out_.Store(uint(int(68))*4, asuint(_e582));
    uint_4_left = uint4(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = uint4(5u, 2u, 4294967293u, 1u);
    uint4 _e598 = uint_4_left;
    uint4 _e599 = uint_4_right;
    const uint4 _e600 = operator_u002b_24(_e598, _e599);
    uint_4_vectors = _e600;
    uint4 _e602 = uint_4_left;
    const uint4 _e604 = operator_u002b_25(_e602, 4u);
    uint_4_vector_scalar = _e604;
    uint4 _e606 = uint_4_right;
    const uint4 _e608 = operator_u002b_26(4u, _e606);
    uint_4_scalar_vector = _e608;
    uint _e611 = uint_4_vectors.x;
    out_.Store(uint(int(69))*4, asuint(_e611));
    uint _e616 = uint_4_vectors.y;
    out_.Store(uint(int(70))*4, asuint(_e616));
    uint _e621 = uint_4_vectors.z;
    out_.Store(uint(int(71))*4, asuint(_e621));
    uint _e626 = uint_4_vectors.w;
    out_.Store(uint(int(72))*4, asuint(_e626));
    uint _e631 = uint_4_vector_scalar.x;
    out_.Store(uint(int(73))*4, asuint(_e631));
    uint _e636 = uint_4_vector_scalar.y;
    out_.Store(uint(int(74))*4, asuint(_e636));
    uint _e641 = uint_4_vector_scalar.z;
    out_.Store(uint(int(75))*4, asuint(_e641));
    uint _e646 = uint_4_vector_scalar.w;
    out_.Store(uint(int(76))*4, asuint(_e646));
    uint _e651 = uint_4_scalar_vector.x;
    out_.Store(uint(int(77))*4, asuint(_e651));
    uint _e656 = uint_4_scalar_vector.y;
    out_.Store(uint(int(78))*4, asuint(_e656));
    uint _e661 = uint_4_scalar_vector.z;
    out_.Store(uint(int(79))*4, asuint(_e661));
    uint _e666 = uint_4_scalar_vector.w;
    out_.Store(uint(int(80))*4, asuint(_e666));
}
