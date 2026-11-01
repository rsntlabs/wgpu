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
    int local_9 = (int)0;

    if (value_13) {
        local_9 = int(7);
    } else {
        local_9 = int(9);
    }
    int _e6 = local_9;
    return _e6;
}

int fabsf(bool value_14)
{
    int local_10 = (int)0;

    if (value_14) {
        local_10 = int(11);
    } else {
        local_10 = int(13);
    }
    int _e6 = local_10;
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
    float value = (float)0;
    float3_ triple = (float3_)0;
    uint local_8 = (uint)0;
    float2 pair = (float2)0;
    float4 quadruple = (float4)0;

    const uint _e2 = _naga_fabsf(asuint(0.0));
    out_.Store(uint(int(0))*4, asuint(asuint(asfloat(_e2))));
    const uint _e12 = _naga_fabsf(asuint(-(0.0)));
    out_.Store(uint(int(1))*4, asuint(asuint(asfloat(_e12))));
    const uint _e21 = _naga_fabsf(asuint(-(1.75)));
    out_.Store(uint(int(2))*4, asuint(asuint(asfloat(_e21))));
    const float _e29 = absolute(-(1.25));
    out_.Store(uint(int(3))*4, asuint(asuint(_e29)));
    const float _e36 = converted_absolute(naga_neg(int(3)));
    out_.Store(uint(int(4))*4, asuint(asuint(_e36)));
    const float _e42 = converted_absolute_1(4294967295u);
    out_.Store(uint(int(5))*4, asuint(asuint(_e42)));
    const float _e48 = converted_absolute_2(true);
    out_.Store(uint(int(6))*4, asuint(asuint(_e48)));
    const float _e54 = converted_absolute_2(false);
    out_.Store(uint(int(7))*4, asuint(asuint(_e54)));
    local = 1u;
    uint _e61 = local;
    const uint _e64 = _naga_fabsf(asuint(asfloat(_e61)));
    out_.Store(uint(int(8))*4, asuint(asuint(asfloat(_e64))));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    const uint _e75 = _naga_fabsf(asuint(asfloat(_e72)));
    out_.Store(uint(int(9))*4, asuint(asuint(asfloat(_e75))));
    local_2 = 8388607u;
    uint _e83 = local_2;
    const uint _e86 = _naga_fabsf(asuint(asfloat(_e83)));
    out_.Store(uint(int(10))*4, asuint(asuint(asfloat(_e86))));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    const uint _e97 = _naga_fabsf(asuint(asfloat(_e94)));
    out_.Store(uint(int(11))*4, asuint(asuint(asfloat(_e97))));
    const uint _e105 = _naga_fabsf(asuint(3.4028235e38));
    out_.Store(uint(int(12))*4, asuint(asuint(asfloat(_e105))));
    const uint _e114 = _naga_fabsf(asuint(-(3.4028235e38)));
    out_.Store(uint(int(13))*4, asuint(asuint(asfloat(_e114))));
    local_4 = 2139095040u;
    uint _e122 = local_4;
    const uint _e125 = _naga_fabsf(asuint(asfloat(_e122)));
    out_.Store(uint(int(14))*4, asuint(asuint(asfloat(_e125))));
    local_5 = 4286578688u;
    uint _e133 = local_5;
    const uint _e136 = _naga_fabsf(asuint(asfloat(_e133)));
    out_.Store(uint(int(15))*4, asuint(asuint(asfloat(_e136))));
    local_6 = 2143363909u;
    uint _e144 = local_6;
    const uint _e147 = _naga_fabsf(asuint(asfloat(_e144)));
    out_.Store(uint(int(16))*4, asuint(asuint(asfloat(_e147))));
    local_7 = 2139095041u;
    uint _e155 = local_7;
    const uint _e158 = _naga_fabsf(asuint(asfloat(_e155)));
    out_.Store(uint(int(17))*4, asuint(asuint(asfloat(_e158))));
    value = -(2.75);
    float _e167 = value;
    value = (_e167 + float(int(1)));
    const uint _e172 = _naga_fabsf(asuint(_e167));
    out_.Store(uint(int(18))*4, asuint(asuint(asfloat(_e172))));
    float _e178 = value;
    out_.Store(uint(int(19))*4, asuint(asuint(_e178)));
    const int _e185 = fabs_3(naga_neg(int(3)));
    out_.Store(uint(int(20))*4, asuint(uint(_e185)));
    const uint _e191 = fabs_4(3u);
    out_.Store(uint(int(21))*4, asuint(_e191));
    const int _e196 = fabs_5(true);
    out_.Store(uint(int(22))*4, asuint(uint(_e196)));
    const int _e202 = fabs_5(false);
    out_.Store(uint(int(23))*4, asuint(uint(_e202)));
    const int _e208 = fabsf(true);
    out_.Store(uint(int(24))*4, asuint(uint(_e208)));
    local_8 = 2147483649u;
    uint _e219 = local_8;
    const float3_ _e222 = fabs_1(Constructfloat3_(-(2.5), -(0.0), asfloat(_e219)));
    triple = _e222;
    float _e225 = triple.x;
    out_.Store(uint(int(25))*4, asuint(asuint(_e225)));
    float _e231 = triple.y;
    out_.Store(uint(int(26))*4, asuint(asuint(_e231)));
    float _e237 = triple.z;
    out_.Store(uint(int(27))*4, asuint(asuint(_e237)));
    const float _e245 = fabsf_1(-(2.0), 3.0);
    out_.Store(uint(int(28))*4, asuint(asuint(_e245)));
    const float2 _e255 = fabs(float2(-(3.0), -(4.0)));
    pair = _e255;
    const float4 _e266 = fabs_2(float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e266;
    float _e270 = pair.x;
    float _e271 = pair.y;
    float _e274 = quadruple.x;
    float _e277 = quadruple.w;
    out_.Store(uint(int(29))*4, asuint(asuint((((_e270 + _e271) + _e274) + _e277))));
}
