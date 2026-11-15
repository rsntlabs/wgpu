#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _27 = _12 & 2147483647u;
    uint _28 = _12 & 2147483648u;
    uint _33 = 1u << ((150u - (_27 >> 23u)) & 31u);
    uint _34 = _33 - 1u;
    uint _38 = _12 & (~_34);
    return (_27 > 2139095040u) ? 2143289344u : ((_27 >= 1258291200u) ? _12 : ((_27 < 1065353216u) ? ((_27 == 0u) ? _12 : (_28 | ((_28 >> 31u) * 1065353216u))) : (((_28 != 0u) && ((_12 & _34) != 0u)) ? (_38 + _33) : _38)));
}

float _63(int _62)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_62))));
}

float _72(uint _71)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_71))));
}

float _81(bool _80)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_80))));
}

float _55(float _54)
{
    return uintBitsToFloat(_13(floatBitsToUint(_54)));
}

int _92(bool _91)
{
    int _96 = 0;
    if (_91)
    {
        _96 = 7;
    }
    else
    {
        _96 = 9;
    }
    return _96;
}

float _107(float _105, float _106)
{
    return _105 + _106;
}

void main()
{
    uint _192 = 0u;
    uint _185 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _166 = 0u;
    float _187 = 0.0;
    uint _181 = 0u;
    uint _175 = 0u;
    uint _169 = 0u;
    uint _190 = 0u;
    uint _183 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _202 = -0.0;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_202))));
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.75))));
    float _215 = -1.25;
    _8._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_215))));
    _8._m0[uint(4)] = floatBitsToUint(_63(3));
    _8._m0[uint(5)] = floatBitsToUint(_72(5u));
    _8._m0[uint(6)] = floatBitsToUint(_81(true));
    _8._m0[uint(7)] = floatBitsToUint(_81(false));
    _166 = 1u;
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_166)))));
    _169 = 2147483649u;
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_169)))));
    _171 = 8388607u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_171)))));
    _173 = 2155872255u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_173)))));
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _276 = -3.4028234663852885981170418348452e+38;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_276))));
    _175 = 2139095039u;
    _8._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_175)))));
    _177 = 4286578687u;
    _8._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_177)))));
    _179 = 2139095040u;
    _8._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_179)))));
    _181 = 4286578688u;
    _8._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_181)))));
    _183 = 2143363909u;
    _8._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_183)))));
    _185 = 2139095041u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_185)))));
    _187 = 2.75;
    float _331 = _187;
    float _332 = float(1);
    _187 = _331 + _332;
    _8._m0[uint(20)] = floatBitsToUint(_55(_331));
    _8._m0[uint(21)] = floatBitsToUint(_187);
    _8._m0[uint(22)] = uint(_92(true));
    _8._m0[uint(23)] = uint(_92(false));
    _8._m0[uint(24)] = floatBitsToUint(_107(2.0, 3.0));
    _190 = 1258291199u;
    _8._m0[uint(25)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_190)))));
    _192 = 3405774847u;
    _8._m0[uint(26)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_192)))));
    _8._m0[uint(27)] = floatBitsToUint(_72(4294967295u));
    int _374 = -2147483647;
    _8._m0[uint(28)] = floatBitsToUint(_63(_374 - 1));
    _8._m0[uint(29)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(10000000000.0))));
}

