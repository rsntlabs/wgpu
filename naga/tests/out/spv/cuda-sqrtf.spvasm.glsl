#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _42 = 0u;
    uint _36 = 0u;
    uint _40 = 0u;
    uint _33 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    uvec2 _91 = uvec2(4294967295u);
    uint _49 = _12 & 2147483647u;
    if ((_49 == 0u) || (_12 == 2139095040u))
    {
        return _12;
    }
    if (((_12 & 2147483648u) != 0u) || (_49 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _61 = _12 & 8388607u;
    uint _62 = _49 >> 23u;
    _33 = _61 | 8388608u;
    _36 = _62 + 127u;
    if (_62 == 0u)
    {
        uint _71 = (31u - uint(findMSB(_61))) - 8u;
        _33 = _61 << _71;
        _36 = 128u - _71;
    }
    uint _76 = _36 & 1u;
    _38 = _33 >> (9u - _76);
    _40 = _33 << (23u + _76);
    _42 = 0u;
    _44 = 0u;
    uint _46 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _91)))
        {
            break;
        }
        _91 -= uvec2(uint(_91.y == 0u), 1u);
        if (_46 >= 24u)
        {
            break;
        }
        uint _106 = _38;
        uint _109 = _44;
        uint _117 = (_109 << 2u) | (_106 >> 14u);
        uint _119 = (_42 << 2u) | 1u;
        bool _120 = _117 >= _119;
        uint _123 = _42 << 1u;
        _38 = ((_106 << 2u) | (_40 >> 30u)) & 65535u;
        _40 = _40 << 2u;
        _44 = _120 ? (_117 - _119) : _117;
        _42 = _120 ? (_123 | 1u) : _123;
        _46++;
        continue;
    }
    return ((_36 >> 1u) << 23u) | (((_44 > _42) ? (_42 + 1u) : _42) & 8388607u);
}

float _147(int _146)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_146))));
}

float _156(uint _155)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_155))));
}

float _139(float _138)
{
    return uintBitsToFloat(_13(floatBitsToUint(_138)));
}

int _176(bool _175)
{
    int _180 = 0;
    if (_175)
    {
        _180 = 7;
    }
    else
    {
        _180 = 9;
    }
    return _180;
}

float _191(float _189, float _190)
{
    return _189 + _190;
}

float _165(bool _164)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_164))));
}

void main()
{
    uint _262 = 0u;
    float _255 = 0.0;
    uint _249 = 0u;
    uint _243 = 0u;
    uint _264 = 0u;
    uint _258 = 0u;
    uint _251 = 0u;
    uint _245 = 0u;
    uint _260 = 0u;
    uint _253 = 0u;
    uint _247 = 0u;
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _274 = -0.0;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_274))));
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.0))));
    _8._m0[uint(3)] = floatBitsToUint(_147(4));
    _8._m0[uint(4)] = floatBitsToUint(_156(9u));
    _8._m0[uint(5)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(6.25))));
    _8._m0[uint(6)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0))));
    _243 = 1u;
    _8._m0[uint(7)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_243)))));
    _245 = 8388607u;
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_245)))));
    _247 = 8388608u;
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_247)))));
    _249 = 2139095039u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_249)))));
    _251 = 2139095040u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_251)))));
    float _347 = -1.0;
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_347))));
    _253 = 2139095041u;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_253)))));
    _255 = 4.0;
    float _362 = _255;
    float _363 = float(1);
    _255 = _362 + _363;
    _8._m0[uint(14)] = floatBitsToUint(_139(_362));
    _8._m0[uint(15)] = floatBitsToUint(_255);
    _8._m0[uint(16)] = uint(_176(true));
    _8._m0[uint(17)] = uint(_176(false));
    _8._m0[uint(18)] = floatBitsToUint(_191(2.0, 3.0));
    _258 = 1065353217u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_258)))));
    _260 = 1065353218u;
    _8._m0[uint(20)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_260)))));
    _262 = 1065353215u;
    _8._m0[uint(21)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_262)))));
    _8._m0[uint(22)] = floatBitsToUint(_156(4294967295u));
    int _413 = -4;
    _8._m0[uint(23)] = floatBitsToUint(_147(_413));
    _8._m0[uint(24)] = floatBitsToUint(_139(16.0));
    _8._m0[uint(25)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.25))));
    _264 = 2147483649u;
    _8._m0[uint(26)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_264)))));
    _8._m0[uint(27)] = floatBitsToUint(_165(false));
    _8._m0[uint(28)] = floatBitsToUint(_165(true));
    _8._m0[uint(29)] = floatBitsToUint(_139(0.5));
}

