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
    return uintBitsToFloat(_18(floatBitsToUint(_147), floatBitsToUint(_148) ^ 2147483648u));
}

uint _174(uint _173)
{
    uint _177 = _173 & 2147483647u;
    return (_177 > 2139095040u) ? 2143289344u : _177;
}

int _160(bool _158, bool _159)
{
    int _164 = 0;
    if (_158)
    {
        _164 = 7;
    }
    else
    {
        _164 = 9;
    }
    return _164;
}

void main()
{
    uint _239 = 0u;
    uint _233 = 0u;
    uint _227 = 0u;
    bool _220 = false;
    uint _214 = 0u;
    uint _208 = 0u;
    uint _237 = 0u;
    uint _231 = 0u;
    uint _225 = 0u;
    uint _218 = 0u;
    int _212 = 0;
    uint _205 = 0u;
    uint _241 = 0u;
    uint _235 = 0u;
    uint _229 = 0u;
    bool _223 = false;
    uint _216 = 0u;
    uint _210 = 0u;
    uint _247 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_247 >= 4096u)
    {
        return;
    }
    uint _252 = 4u + (_247 * 10u);
    _205 = _247 * 2u;
    uint _257 = _9._m0[_205];
    float _258 = uintBitsToFloat(_257);
    _208 = (_247 * 2u) + 1u;
    uint _263 = _9._m0[_208];
    float _264 = uintBitsToFloat(_263);
    _12._m0[_252] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_258), floatBitsToUint(_264) ^ 2147483648u)));
    _210 = _252 + 1u;
    _12._m0[_210] = floatBitsToUint(_149(_258, _264));
    _212 = 0;
    int _278 = _212;
    _212 = _278 + 1;
    _216 = (_247 * 2u) + uint(_278);
    int _287 = _212;
    _212 = _287 + 1;
    _218 = (_247 * 2u) + uint(_287);
    _214 = _252 + 2u;
    _12._m0[_214] = floatBitsToUint(_149(uintBitsToFloat(_9._m0[_216]), uintBitsToFloat(_9._m0[_218])));
    _220 = false;
    if (false)
    {
        int _302 = _212;
        _212 = _302 + 1;
        _220 = _174(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_302)), floatBitsToUint(_258) ^ 2147483648u)))) != 0u;
    }
    _223 = true;
    if (!true)
    {
        int _315 = _212;
        _212 = _315 + 1;
        _223 = _174(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_258), floatBitsToUint(float(_315)) ^ 2147483648u)))) != 0u;
    }
    _225 = _252 + 3u;
    _12._m0[_225] = uint(_212);
    float _331 = -0.0;
    float _332 = -0.0;
    _227 = _252 + 4u;
    _12._m0[_227] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_331), floatBitsToUint(_332) ^ 2147483648u)));
    float _342 = -0.0;
    _229 = _252 + 5u;
    _12._m0[_229] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_342), floatBitsToUint(0.0) ^ 2147483648u)));
    float _352 = float(1);
    float _353 = float(2u);
    _231 = _252 + 6u;
    _12._m0[_231] = floatBitsToUint(_149(_352, _353));
    _233 = _252 + 7u;
    _12._m0[_233] = uint(_160(true, false));
    _235 = _252 + 8u;
    _12._m0[_235] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_264), floatBitsToUint(_258) ^ 2147483648u)));
    _239 = 1065353217u;
    _241 = 1065353214u;
    _237 = _252 + 9u;
    _12._m0[_237] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_239) * uintBitsToFloat(_241)), floatBitsToUint(1.0) ^ 2147483648u)));
}

