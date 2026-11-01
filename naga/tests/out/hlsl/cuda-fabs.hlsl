struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

float2 fabs(float2 value_1)
{
    float2 value_2 = (float2)0;

    value_2 = value_1;
    float _e3 = value_2.x;
    const uint _e5 = _naga_fabsf(asuint(_e3));
    float _e8 = value_2.y;
    const uint _e10 = _naga_fabsf(asuint(_e8));
    return float2(asfloat(_e5), asfloat(_e10));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

float3_ fabs_1(float3_ value_3)
{
    float3_ value_4 = (float3_)0;

    value_4 = value_3;
    float _e3 = value_4.x;
    const uint _e5 = _naga_fabsf(asuint(_e3));
    float _e8 = value_4.y;
    const uint _e10 = _naga_fabsf(asuint(_e8));
    float _e13 = value_4.z;
    const uint _e15 = _naga_fabsf(asuint(_e13));
    const float3_ float3_1 = Constructfloat3_(asfloat(_e5), asfloat(_e10), asfloat(_e15));
    return float3_1;
}

float4 fabs_2(float4 value_5)
{
    float4 value_6 = (float4)0;

    value_6 = value_5;
    float _e3 = value_6.x;
    const uint _e5 = _naga_fabsf(asuint(_e3));
    float _e8 = value_6.y;
    const uint _e10 = _naga_fabsf(asuint(_e8));
    float _e13 = value_6.z;
    const uint _e15 = _naga_fabsf(asuint(_e13));
    float _e18 = value_6.w;
    const uint _e20 = _naga_fabsf(asuint(_e18));
    return float4(asfloat(_e5), asfloat(_e10), asfloat(_e15), asfloat(_e20));
}

float absolute(float value_7)
{
    const uint _e2 = _naga_fabsf(asuint(value_7));
    return asfloat(_e2);
}

float converted_absolute(int value_8)
{
    const uint _e3 = _naga_fabsf(asuint(float(value_8)));
    return asfloat(_e3);
}

float converted_absolute_1(uint value_9)
{
    const uint _e3 = _naga_fabsf(asuint(float(value_9)));
    return asfloat(_e3);
}

float converted_absolute_2(bool value_10)
{
    const uint _e3 = _naga_fabsf(asuint(float(value_10)));
    return asfloat(_e3);
}

int fabs_3(int value_11)
{
    return asint(asuint(value_11) + asuint(int(40)));
}

uint fabs_4(uint value_12)
{
    return (value_12 + 50u);
}

int fabs_5(bool value_13)
{
    int local_39 = (int)0;

    if (value_13) {
        local_39 = int(7);
    } else {
        local_39 = int(9);
    }
    int _e6 = local_39;
    return _e6;
}

int fabsf(bool value_14)
{
    int local_40 = (int)0;

    if (value_14) {
        local_40 = int(11);
    } else {
        local_40 = int(13);
    }
    int _e6 = local_40;
    return _e6;
}

float fabsf_1(float first, float second)
{
    return (first + second);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void absolutes()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
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
    float value = (float)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    float3_ triple = (float3_)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    float2 pair = (float2)0;
    float4 quadruple = (float4)0;
    uint local_38 = (uint)0;

    const uint _e2 = _naga_fabsf(asuint(0.0));
    local = uint(int(0));
    uint _e8 = local;
    out_.Store(_e8*4, asuint(asuint(asfloat(_e2))));
    const uint _e14 = _naga_fabsf(asuint(-(0.0)));
    local_1 = uint(int(1));
    uint _e20 = local_1;
    out_.Store(_e20*4, asuint(asuint(asfloat(_e14))));
    const uint _e25 = _naga_fabsf(asuint(-(1.75)));
    local_2 = uint(int(2));
    uint _e31 = local_2;
    out_.Store(_e31*4, asuint(asuint(asfloat(_e25))));
    const float _e35 = absolute(-(1.25));
    local_3 = uint(int(3));
    uint _e40 = local_3;
    out_.Store(_e40*4, asuint(asuint(_e35)));
    const float _e44 = converted_absolute(naga_neg(int(3)));
    local_4 = uint(int(4));
    uint _e49 = local_4;
    out_.Store(_e49*4, asuint(asuint(_e44)));
    const float _e52 = converted_absolute_1(4294967295u);
    local_5 = uint(int(5));
    uint _e57 = local_5;
    out_.Store(_e57*4, asuint(asuint(_e52)));
    const float _e60 = converted_absolute_2(true);
    local_6 = uint(int(6));
    uint _e65 = local_6;
    out_.Store(_e65*4, asuint(asuint(_e60)));
    const float _e68 = converted_absolute_2(false);
    local_7 = uint(int(7));
    uint _e73 = local_7;
    out_.Store(_e73*4, asuint(asuint(_e68)));
    local_9 = 1u;
    uint _e77 = local_9;
    const uint _e80 = _naga_fabsf(asuint(asfloat(_e77)));
    local_8 = uint(int(8));
    uint _e86 = local_8;
    out_.Store(_e86*4, asuint(asuint(asfloat(_e80))));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    const uint _e93 = _naga_fabsf(asuint(asfloat(_e90)));
    local_10 = uint(int(9));
    uint _e99 = local_10;
    out_.Store(_e99*4, asuint(asuint(asfloat(_e93))));
    local_13 = 8388607u;
    uint _e103 = local_13;
    const uint _e106 = _naga_fabsf(asuint(asfloat(_e103)));
    local_12 = uint(int(10));
    uint _e112 = local_12;
    out_.Store(_e112*4, asuint(asuint(asfloat(_e106))));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    const uint _e119 = _naga_fabsf(asuint(asfloat(_e116)));
    local_14 = uint(int(11));
    uint _e125 = local_14;
    out_.Store(_e125*4, asuint(asuint(asfloat(_e119))));
    const uint _e129 = _naga_fabsf(asuint(3.4028235e38));
    local_16 = uint(int(12));
    uint _e135 = local_16;
    out_.Store(_e135*4, asuint(asuint(asfloat(_e129))));
    const uint _e140 = _naga_fabsf(asuint(-(3.4028235e38)));
    local_17 = uint(int(13));
    uint _e146 = local_17;
    out_.Store(_e146*4, asuint(asuint(asfloat(_e140))));
    local_19 = 2139095040u;
    uint _e150 = local_19;
    const uint _e153 = _naga_fabsf(asuint(asfloat(_e150)));
    local_18 = uint(int(14));
    uint _e159 = local_18;
    out_.Store(_e159*4, asuint(asuint(asfloat(_e153))));
    local_21 = 4286578688u;
    uint _e163 = local_21;
    const uint _e166 = _naga_fabsf(asuint(asfloat(_e163)));
    local_20 = uint(int(15));
    uint _e172 = local_20;
    out_.Store(_e172*4, asuint(asuint(asfloat(_e166))));
    local_23 = 2143363909u;
    uint _e176 = local_23;
    const uint _e179 = _naga_fabsf(asuint(asfloat(_e176)));
    local_22 = uint(int(16));
    uint _e185 = local_22;
    out_.Store(_e185*4, asuint(asuint(asfloat(_e179))));
    local_25 = 2139095041u;
    uint _e189 = local_25;
    const uint _e192 = _naga_fabsf(asuint(asfloat(_e189)));
    local_24 = uint(int(17));
    uint _e198 = local_24;
    out_.Store(_e198*4, asuint(asuint(asfloat(_e192))));
    value = -(2.75);
    float _e203 = value;
    value = (_e203 + float(int(1)));
    const uint _e208 = _naga_fabsf(asuint(_e203));
    local_26 = uint(int(18));
    uint _e214 = local_26;
    out_.Store(_e214*4, asuint(asuint(asfloat(_e208))));
    float _e216 = value;
    local_27 = uint(int(19));
    uint _e221 = local_27;
    out_.Store(_e221*4, asuint(asuint(_e216)));
    const int _e225 = fabs_3(naga_neg(int(3)));
    local_28 = uint(int(20));
    uint _e230 = local_28;
    out_.Store(_e230*4, asuint(uint(_e225)));
    const uint _e233 = fabs_4(3u);
    local_29 = uint(int(21));
    uint _e237 = local_29;
    out_.Store(_e237*4, asuint(_e233));
    const int _e240 = fabs_5(true);
    local_30 = uint(int(22));
    uint _e245 = local_30;
    out_.Store(_e245*4, asuint(uint(_e240)));
    const int _e248 = fabs_5(false);
    local_31 = uint(int(23));
    uint _e253 = local_31;
    out_.Store(_e253*4, asuint(uint(_e248)));
    const int _e256 = fabsf(true);
    local_32 = uint(int(24));
    uint _e261 = local_32;
    out_.Store(_e261*4, asuint(uint(_e256)));
    local_33 = 2147483649u;
    uint _e269 = local_33;
    const float3_ _e272 = fabs_1(Constructfloat3_(-(2.5), -(0.0), asfloat(_e269)));
    triple = _e272;
    float _e275 = triple.x;
    local_34 = uint(int(25));
    uint _e280 = local_34;
    out_.Store(_e280*4, asuint(asuint(_e275)));
    float _e283 = triple.y;
    local_35 = uint(int(26));
    uint _e288 = local_35;
    out_.Store(_e288*4, asuint(asuint(_e283)));
    float _e291 = triple.z;
    local_36 = uint(int(27));
    uint _e296 = local_36;
    out_.Store(_e296*4, asuint(asuint(_e291)));
    const float _e301 = fabsf_1(-(2.0), 3.0);
    local_37 = uint(int(28));
    uint _e306 = local_37;
    out_.Store(_e306*4, asuint(asuint(_e301)));
    const float2 _e313 = fabs(float2(-(3.0), -(4.0)));
    pair = _e313;
    const float4 _e324 = fabs_2(float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e324;
    float _e328 = pair.x;
    float _e329 = pair.y;
    float _e332 = quadruple.x;
    float _e335 = quadruple.w;
    local_38 = uint(int(29));
    uint _e341 = local_38;
    out_.Store(_e341*4, asuint(asuint((((_e328 + _e329) + _e332) + _e335))));
}
