RWByteAddressBuffer out_ : register(u0);

uint _naga_floorf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    bool _e7 = ((input_bits & 2147483648u) != 0u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value_1)
{
    const uint _e2 = _naga_floorf(asuint(value_1));
    return asfloat(_e2);
}

float floor_value_1(int value_2)
{
    const uint _e3 = _naga_floorf(asuint(float(value_2)));
    return asfloat(_e3);
}

float floor_value_2(uint value_3)
{
    const uint _e3 = _naga_floorf(asuint(float(value_3)));
    return asfloat(_e3);
}

float floor_value_3(bool value_4)
{
    const uint _e3 = _naga_floorf(asuint(float(value_4)));
    return asfloat(_e3);
}

int floorf(bool value_5)
{
    int local_12 = (int)0;

    if (value_5) {
        local_12 = int(7);
    } else {
        local_12 = int(9);
    }
    int _e6 = local_12;
    return _e6;
}

float floorf_1(float first, float second)
{
    return (first + second);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void floors()
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

    const uint _e2 = _naga_floorf(asuint(0.0));
    out_.Store(uint(int(0))*4, asuint(asuint(asfloat(_e2))));
    const uint _e12 = _naga_floorf(asuint(-(0.0)));
    out_.Store(uint(int(1))*4, asuint(asuint(asfloat(_e12))));
    const uint _e20 = _naga_floorf(asuint(1.75));
    out_.Store(uint(int(2))*4, asuint(asuint(asfloat(_e20))));
    const uint _e29 = _naga_floorf(asuint(-(1.25)));
    out_.Store(uint(int(3))*4, asuint(asuint(asfloat(_e29))));
    const float _e36 = floor_value_1(int(3));
    out_.Store(uint(int(4))*4, asuint(asuint(_e36)));
    const float _e42 = floor_value_2(5u);
    out_.Store(uint(int(5))*4, asuint(asuint(_e42)));
    const float _e48 = floor_value_3(true);
    out_.Store(uint(int(6))*4, asuint(asuint(_e48)));
    const float _e54 = floor_value_3(false);
    out_.Store(uint(int(7))*4, asuint(asuint(_e54)));
    local = 1u;
    uint _e61 = local;
    const uint _e64 = _naga_floorf(asuint(asfloat(_e61)));
    out_.Store(uint(int(8))*4, asuint(asuint(asfloat(_e64))));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    const uint _e75 = _naga_floorf(asuint(asfloat(_e72)));
    out_.Store(uint(int(9))*4, asuint(asuint(asfloat(_e75))));
    local_2 = 8388607u;
    uint _e83 = local_2;
    const uint _e86 = _naga_floorf(asuint(asfloat(_e83)));
    out_.Store(uint(int(10))*4, asuint(asuint(asfloat(_e86))));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    const uint _e97 = _naga_floorf(asuint(asfloat(_e94)));
    out_.Store(uint(int(11))*4, asuint(asuint(asfloat(_e97))));
    const uint _e105 = _naga_floorf(asuint(3.4028235e38));
    out_.Store(uint(int(12))*4, asuint(asuint(asfloat(_e105))));
    const uint _e114 = _naga_floorf(asuint(-(3.4028235e38)));
    out_.Store(uint(int(13))*4, asuint(asuint(asfloat(_e114))));
    local_4 = 2139095039u;
    uint _e122 = local_4;
    const uint _e125 = _naga_floorf(asuint(asfloat(_e122)));
    out_.Store(uint(int(14))*4, asuint(asuint(asfloat(_e125))));
    local_5 = 4286578687u;
    uint _e133 = local_5;
    const uint _e136 = _naga_floorf(asuint(asfloat(_e133)));
    out_.Store(uint(int(15))*4, asuint(asuint(asfloat(_e136))));
    local_6 = 2139095040u;
    uint _e144 = local_6;
    const uint _e147 = _naga_floorf(asuint(asfloat(_e144)));
    out_.Store(uint(int(16))*4, asuint(asuint(asfloat(_e147))));
    local_7 = 4286578688u;
    uint _e155 = local_7;
    const uint _e158 = _naga_floorf(asuint(asfloat(_e155)));
    out_.Store(uint(int(17))*4, asuint(asuint(asfloat(_e158))));
    local_8 = 2143363909u;
    uint _e166 = local_8;
    const uint _e169 = _naga_floorf(asuint(asfloat(_e166)));
    out_.Store(uint(int(18))*4, asuint(asuint(asfloat(_e169))));
    local_9 = 2139095041u;
    uint _e177 = local_9;
    const uint _e180 = _naga_floorf(asuint(asfloat(_e177)));
    out_.Store(uint(int(19))*4, asuint(asuint(asfloat(_e180))));
    value = 2.75;
    float _e188 = value;
    value = (_e188 + float(int(1)));
    const float _e192 = floor_value(_e188);
    out_.Store(uint(int(20))*4, asuint(asuint(_e192)));
    float _e197 = value;
    out_.Store(uint(int(21))*4, asuint(asuint(_e197)));
    const int _e203 = floorf(true);
    out_.Store(uint(int(22))*4, asuint(uint(_e203)));
    const int _e209 = floorf(false);
    out_.Store(uint(int(23))*4, asuint(uint(_e209)));
    const float _e216 = floorf_1(2.0, 3.0);
    out_.Store(uint(int(24))*4, asuint(asuint(_e216)));
    local_10 = 1258291199u;
    uint _e223 = local_10;
    const uint _e226 = _naga_floorf(asuint(asfloat(_e223)));
    out_.Store(uint(int(25))*4, asuint(asuint(asfloat(_e226))));
    local_11 = 3405774847u;
    uint _e234 = local_11;
    const uint _e237 = _naga_floorf(asuint(asfloat(_e234)));
    out_.Store(uint(int(26))*4, asuint(asuint(asfloat(_e237))));
    const float _e244 = floor_value_2(4294967295u);
    out_.Store(uint(int(27))*4, asuint(asuint(_e244)));
    const float _e253 = floor_value_1(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1))));
    out_.Store(uint(int(28))*4, asuint(asuint(_e253)));
    const uint _e260 = _naga_floorf(asuint(10000000000.0));
    out_.Store(uint(int(29))*4, asuint(asuint(asfloat(_e260))));
}
