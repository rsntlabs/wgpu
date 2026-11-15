#version 460
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

uint _18(uint _16, uint _17)
{
    uint _39 = _16 & 2147483647u;
    uint _40 = _17 & 2147483647u;
    uint _41 = _16 & 2147483648u;
    uint _42 = _17 & 2147483648u;
    if ((_39 > 2139095040u) || (_40 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _48 = _39 == 2139095040u;
    bool _49 = _40 == 2139095040u;
    if ((_48 && _49) && (_41 != _42))
    {
        return 2143289344u;
    }
    if (_48)
    {
        return _16;
    }
    if (_49)
    {
        return _17;
    }
    bool _60 = _39 >= _40;
    uint _61 = _60 ? _39 : _40;
    uint _62 = _60 ? _40 : _39;
    uint _63 = _60 ? _41 : _42;
    uint _64 = _61 >> 23u;
    uint _65 = _62 >> 23u;
    bool _66 = _64 != 0u;
    bool _67 = _65 != 0u;
    uint _74 = ((_61 & 8388607u) | (_66 ? 8388608u : 0u)) << 3u;
    uint _75 = ((_62 & 8388607u) | (_67 ? 8388608u : 0u)) << 3u;
    uint _76 = _66 ? _64 : 1u;
    uint _78 = _76 - (_67 ? _65 : 1u);
    uint _79 = _78 & 31u;
    uint _90 = (_78 < 32u) ? ((_75 >> _79) | uint((_75 & ((1u << _79) - 1u)) != 0u)) : uint(_75 != 0u);
    uint _93 = (_41 == _42) ? (_74 + _90) : (_74 - _90);
    if (_93 == 0u)
    {
        return _41 & _42;
    }
    bool _98 = _93 >= 134217728u;
    uint _99 = 1u & 31u;
    uint _111 = _98 ? ((1u < 32u) ? ((_93 >> _99) | uint((_93 & ((1u << _99) - 1u)) != 0u)) : uint(_93 != 0u)) : _93;
    uint _113 = _76 + uint(_98);
    uint _118 = min(((31u - uint(findMSB(_111))) - 5u), (_113 - 1u));
    uint _119 = _111 << _118;
    uint _121 = _119 & 7u;
    uint _122 = _119 >> 3u;
    uint _130 = _122 + uint((_121 > 4u) || ((_121 == 4u) && ((_122 & 1u) != 0u)));
    bool _131 = _130 >= 16777216u;
    uint _133 = _131 ? (_130 >> 1u) : _130;
    uint _135 = (_113 - _118) + uint(_131);
    if (_135 >= 255u)
    {
        return _63 | 2139095040u;
    }
    return _63 | ((((_133 >= 8388608u) ? _135 : 0u) << 23u) | (_133 & 8388607u));
}

float _149(float _147, float _148)
{
    return uintBitsToFloat(_18(floatBitsToUint(_147), floatBitsToUint(_148)));
}

uint _173(uint _172)
{
    uint _176 = _172 & 2147483647u;
    return (_176 > 2139095040u) ? 2143289344u : _176;
}

int _159(bool _157, bool _158)
{
    int _163 = 0;
    if (_157)
    {
        _163 = 7;
    }
    else
    {
        _163 = 9;
    }
    return _163;
}

void main()
{
    uint _225 = 0u;
    uint _219 = 0u;
    uint _212 = 0u;
    int _206 = 0;
    uint _199 = 0u;
    uint _227 = 0u;
    uint _221 = 0u;
    bool _214 = false;
    uint _208 = 0u;
    uint _202 = 0u;
    uint _223 = 0u;
    bool _217 = false;
    uint _210 = 0u;
    uint _204 = 0u;
    uint _233 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_233 >= 4096u)
    {
        return;
    }
    uint _238 = 4u + (_233 * 8u);
    _199 = _233 * 2u;
    uint _243 = _9._m0[_199];
    float _244 = uintBitsToFloat(_243);
    _202 = (_233 * 2u) + 1u;
    uint _249 = _9._m0[_202];
    float _250 = uintBitsToFloat(_249);
    _12._m0[_238] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_244), floatBitsToUint(_250))));
    _204 = _238 + 1u;
    _12._m0[_204] = floatBitsToUint(_149(_244, _250));
    _206 = 0;
    int _263 = _206;
    _206 = _263 + 1;
    _210 = (_233 * 2u) + uint(_263);
    int _272 = _206;
    _206 = _272 + 1;
    _212 = (_233 * 2u) + uint(_272);
    _208 = _238 + 2u;
    _12._m0[_208] = floatBitsToUint(_149(uintBitsToFloat(_9._m0[_210]), uintBitsToFloat(_9._m0[_212])));
    _214 = false;
    if (false)
    {
        int _287 = _206;
        _206 = _287 + 1;
        _214 = _173(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_287)), floatBitsToUint(_244))))) != 0u;
    }
    _217 = true;
    if (!true)
    {
        int _299 = _206;
        _206 = _299 + 1;
        _217 = _173(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_244), floatBitsToUint(float(_299)))))) != 0u;
    }
    _219 = _238 + 3u;
    _12._m0[_219] = uint(_206);
    float _314 = -0.0;
    float _315 = -0.0;
    _221 = _238 + 4u;
    _12._m0[_221] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_314), floatBitsToUint(_315))));
    float _324 = -0.0;
    _223 = _238 + 5u;
    _12._m0[_223] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_324), floatBitsToUint(0.0))));
    float _333 = float(1);
    float _334 = float(2u);
    _225 = _238 + 6u;
    _12._m0[_225] = floatBitsToUint(_149(_333, _334));
    _227 = _238 + 7u;
    _12._m0[_227] = uint(_159(true, false));
}

