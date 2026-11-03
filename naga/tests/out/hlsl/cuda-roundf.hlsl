RWByteAddressBuffer output : register(u0);

uint _naga_roundf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits & _e14);
    uint _e18 = (input_bits & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

float rounded(float value_1)
{
    const uint _e2 = _naga_roundf(asuint(value_1));
    return asfloat(_e2);
}

int roundf(bool value_2)
{
    int local_18 = (int)0;

    if (value_2) {
        local_18 = int(7);
    } else {
        local_18 = int(9);
    }
    int _e6 = local_18;
    return _e6;
}

float roundf_1(float first, float second)
{
    return (first + second);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void rounds()
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
    float value = (float)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;

    const uint _e2 = _naga_roundf(asuint(0.0));
    output.Store(uint(int(0))*4, asuint(asuint(asfloat(_e2))));
    const uint _e12 = _naga_roundf(asuint(-(0.0)));
    output.Store(uint(int(1))*4, asuint(asuint(asfloat(_e12))));
    const uint _e20 = _naga_roundf(asuint(1.25));
    output.Store(uint(int(2))*4, asuint(asuint(asfloat(_e20))));
    const uint _e29 = _naga_roundf(asuint(-(1.75)));
    output.Store(uint(int(3))*4, asuint(asuint(asfloat(_e29))));
    const float _e37 = rounded(float(int(3)));
    output.Store(uint(int(4))*4, asuint(asuint(_e37)));
    const float _e44 = rounded(float(5u));
    output.Store(uint(int(5))*4, asuint(asuint(_e44)));
    const int _e50 = roundf(true);
    output.Store(uint(int(6))*4, asuint(uint(_e50)));
    const int _e56 = roundf(false);
    output.Store(uint(int(7))*4, asuint(uint(_e56)));
    const float _e63 = rounded(float(true));
    output.Store(uint(int(8))*4, asuint(asuint(_e63)));
    const float _e70 = rounded(float(false));
    output.Store(uint(int(9))*4, asuint(asuint(_e70)));
    local = 1u;
    uint _e77 = local;
    const uint _e80 = _naga_roundf(asuint(asfloat(_e77)));
    output.Store(uint(int(10))*4, asuint(asuint(asfloat(_e80))));
    local_1 = 2147483649u;
    uint _e88 = local_1;
    const uint _e91 = _naga_roundf(asuint(asfloat(_e88)));
    output.Store(uint(int(11))*4, asuint(asuint(asfloat(_e91))));
    local_2 = 8388607u;
    uint _e99 = local_2;
    const uint _e102 = _naga_roundf(asuint(asfloat(_e99)));
    output.Store(uint(int(12))*4, asuint(asuint(asfloat(_e102))));
    local_3 = 2155872255u;
    uint _e110 = local_3;
    const uint _e113 = _naga_roundf(asuint(asfloat(_e110)));
    output.Store(uint(int(13))*4, asuint(asuint(asfloat(_e113))));
    const uint _e122 = _naga_roundf(asuint(-(0.25)));
    output.Store(uint(int(14))*4, asuint(asuint(asfloat(_e122))));
    local_4 = 1258291199u;
    uint _e130 = local_4;
    const uint _e133 = _naga_roundf(asuint(asfloat(_e130)));
    output.Store(uint(int(15))*4, asuint(asuint(asfloat(_e133))));
    local_5 = 3405774847u;
    uint _e141 = local_5;
    const uint _e144 = _naga_roundf(asuint(asfloat(_e141)));
    output.Store(uint(int(16))*4, asuint(asuint(asfloat(_e144))));
    const uint _e152 = _naga_roundf(asuint(3.4028235e38));
    output.Store(uint(int(17))*4, asuint(asuint(asfloat(_e152))));
    const uint _e161 = _naga_roundf(asuint(-(3.4028235e38)));
    output.Store(uint(int(18))*4, asuint(asuint(asfloat(_e161))));
    local_6 = 2139095040u;
    uint _e169 = local_6;
    const uint _e172 = _naga_roundf(asuint(asfloat(_e169)));
    output.Store(uint(int(19))*4, asuint(asuint(asfloat(_e172))));
    local_7 = 4286578688u;
    uint _e180 = local_7;
    const uint _e183 = _naga_roundf(asuint(asfloat(_e180)));
    output.Store(uint(int(20))*4, asuint(asuint(asfloat(_e183))));
    local_8 = 2143363909u;
    uint _e191 = local_8;
    const uint _e194 = _naga_roundf(asuint(asfloat(_e191)));
    output.Store(uint(int(21))*4, asuint(asuint(asfloat(_e194))));
    local_9 = 4286578689u;
    uint _e202 = local_9;
    const uint _e205 = _naga_roundf(asuint(asfloat(_e202)));
    output.Store(uint(int(22))*4, asuint(asuint(asfloat(_e205))));
    value = 2.25;
    float _e213 = value;
    value = (_e213 + float(int(1)));
    const float _e217 = rounded(_e213);
    output.Store(uint(int(23))*4, asuint(asuint(_e217)));
    float _e222 = value;
    output.Store(uint(int(24))*4, asuint(asuint(_e222)));
    const float _e229 = roundf_1(2.0, 3.0);
    output.Store(uint(int(25))*4, asuint(asuint(_e229)));
    const float _e236 = rounded(float(4294967295u));
    output.Store(uint(int(26))*4, asuint(asuint(_e236)));
    const float _e246 = rounded(float(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1)))));
    output.Store(uint(int(27))*4, asuint(asuint(_e246)));
    const uint _e253 = _naga_roundf(asuint(10000000000.0));
    output.Store(uint(int(28))*4, asuint(asuint(asfloat(_e253))));
    const uint _e261 = _naga_roundf(asuint(1.5));
    output.Store(uint(int(29))*4, asuint(asuint(asfloat(_e261))));
    const uint _e270 = _naga_roundf(asuint(-(1.5)));
    output.Store(uint(int(30))*4, asuint(asuint(asfloat(_e270))));
    const uint _e278 = _naga_roundf(asuint(2.5));
    output.Store(uint(int(31))*4, asuint(asuint(asfloat(_e278))));
    const uint _e287 = _naga_roundf(asuint(-(2.5)));
    output.Store(uint(int(32))*4, asuint(asuint(asfloat(_e287))));
    local_10 = 1056964607u;
    uint _e295 = local_10;
    const uint _e298 = _naga_roundf(asuint(asfloat(_e295)));
    output.Store(uint(int(33))*4, asuint(asuint(asfloat(_e298))));
    local_11 = 1056964609u;
    uint _e306 = local_11;
    const uint _e309 = _naga_roundf(asuint(asfloat(_e306)));
    output.Store(uint(int(34))*4, asuint(asuint(asfloat(_e309))));
    local_12 = 3204448255u;
    uint _e317 = local_12;
    const uint _e320 = _naga_roundf(asuint(asfloat(_e317)));
    output.Store(uint(int(35))*4, asuint(asuint(asfloat(_e320))));
    local_13 = 3204448257u;
    uint _e328 = local_13;
    const uint _e331 = _naga_roundf(asuint(asfloat(_e328)));
    output.Store(uint(int(36))*4, asuint(asuint(asfloat(_e331))));
    local_14 = 1249902593u;
    uint _e339 = local_14;
    const uint _e342 = _naga_roundf(asuint(asfloat(_e339)));
    output.Store(uint(int(37))*4, asuint(asuint(asfloat(_e342))));
    local_15 = 3397386241u;
    uint _e350 = local_15;
    const uint _e353 = _naga_roundf(asuint(asfloat(_e350)));
    output.Store(uint(int(38))*4, asuint(asuint(asfloat(_e353))));
    local_16 = 1258291197u;
    uint _e361 = local_16;
    const uint _e364 = _naga_roundf(asuint(asfloat(_e361)));
    output.Store(uint(int(39))*4, asuint(asuint(asfloat(_e364))));
    local_17 = 3405774845u;
    uint _e372 = local_17;
    const uint _e375 = _naga_roundf(asuint(asfloat(_e372)));
    output.Store(uint(int(40))*4, asuint(asuint(asfloat(_e375))));
}
