#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _28 = _12 & 2147483647u;
    bool _30 = (_12 & 2147483648u) != 0u;
    uint _34 = 1u << ((150u - (_28 >> 23u)) & 31u);
    uint _35 = _34 - 1u;
    uint _39 = _12 & (~_35);
    return (_28 > 2139095040u) ? 2143289344u : ((_28 >= 1258291200u) ? _12 : ((_28 < 1065353216u) ? ((_28 == 0u) ? _12 : (_30 ? 3212836864u : 0u)) : ((_30 && ((_12 & _35) != 0u)) ? (_39 + _34) : _39)));
}

float _62(int _61)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_61))));
}

float _71(uint _70)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_70))));
}

float _80(bool _79)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_79))));
}

float _54(float _53)
{
    return uintBitsToFloat(_13(floatBitsToUint(_53)));
}

int _91(bool _90)
{
    int _95 = 0;
    if (_90)
    {
        _95 = 7;
    }
    else
    {
        _95 = 9;
    }
    return _95;
}

float _106(float _104, float _105)
{
    return _104 + _105;
}

void main()
{
    uint _191 = 0u;
    uint _184 = 0u;
    uint _178 = 0u;
    uint _172 = 0u;
    uint _165 = 0u;
    float _186 = 0.0;
    uint _180 = 0u;
    uint _174 = 0u;
    uint _168 = 0u;
    uint _189 = 0u;
    uint _182 = 0u;
    uint _176 = 0u;
    uint _170 = 0u;
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _201 = -0.0;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_201))));
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.75))));
    float _214 = -1.25;
    _8._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_214))));
    _8._m0[uint(4)] = floatBitsToUint(_62(3));
    _8._m0[uint(5)] = floatBitsToUint(_71(5u));
    _8._m0[uint(6)] = floatBitsToUint(_80(true));
    _8._m0[uint(7)] = floatBitsToUint(_80(false));
    _165 = 1u;
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_165)))));
    _168 = 2147483649u;
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_168)))));
    _170 = 8388607u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_170)))));
    _172 = 2155872255u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_172)))));
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _275 = -3.4028234663852885981170418348452e+38;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_275))));
    _174 = 2139095039u;
    _8._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_174)))));
    _176 = 4286578687u;
    _8._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_176)))));
    _178 = 2139095040u;
    _8._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_178)))));
    _180 = 4286578688u;
    _8._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_180)))));
    _182 = 2143363909u;
    _8._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_182)))));
    _184 = 2139095041u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_184)))));
    _186 = 2.75;
    float _330 = _186;
    float _331 = float(1);
    _186 = _330 + _331;
    _8._m0[uint(20)] = floatBitsToUint(_54(_330));
    _8._m0[uint(21)] = floatBitsToUint(_186);
    _8._m0[uint(22)] = uint(_91(true));
    _8._m0[uint(23)] = uint(_91(false));
    _8._m0[uint(24)] = floatBitsToUint(_106(2.0, 3.0));
    _189 = 1258291199u;
    _8._m0[uint(25)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_189)))));
    _191 = 3405774847u;
    _8._m0[uint(26)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_191)))));
    _8._m0[uint(27)] = floatBitsToUint(_71(4294967295u));
    int _373 = -2147483647;
    _8._m0[uint(28)] = floatBitsToUint(_62(_373 - 1));
    _8._m0[uint(29)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(10000000000.0))));
}

