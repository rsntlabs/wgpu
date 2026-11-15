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
    uint _45 = 0u;
    int _38 = 0;
    int _43 = 0;
    uint _35 = 0u;
    uint _47 = 0u;
    uint _41 = 0u;
    uvec2 _130 = uvec2(4294967295u);
    uint _52 = _16 & 2147483647u;
    uint _53 = _17 & 2147483647u;
    uint _55 = (_16 ^ _17) & 2147483648u;
    uint _56 = _55 | 2139095040u;
    bool _60 = _52 == 0u;
    bool _61 = _53 == 0u;
    bool _63 = _52 == 2139095040u;
    bool _64 = _53 == 2139095040u;
    if ((((_52 > 2139095040u) || (_53 > 2139095040u)) || (_60 && _61)) || (_63 && _64))
    {
        return 2143289344u;
    }
    if (_63 || _61)
    {
        return _56;
    }
    if (_60 || _64)
    {
        return _55;
    }
    uint _76 = _52 & 8388607u;
    uint _77 = _52 >> 23u;
    _35 = _76 | 8388608u;
    _38 = int(_77) - 127;
    if (_77 == 0u)
    {
        uint _86 = (31u - uint(findMSB(_76))) - 8u;
        _35 = _76 << _86;
        _38 = (-126) - int(_86);
    }
    uint _92 = _53 & 8388607u;
    uint _93 = _53 >> 23u;
    _41 = _92 | 8388608u;
    _43 = int(_93) - 127;
    if (_93 == 0u)
    {
        uint _102 = (31u - uint(findMSB(_92))) - 8u;
        _41 = _92 << _102;
        _43 = (-126) - int(_102);
    }
    bool _108 = _35 < _41;
    int _115 = (_38 - _43) - int(_108);
    if (_115 < (-150))
    {
        return _55;
    }
    _45 = 1u;
    _47 = (_108 ? (_35 << 1u) : _35) - _41;
    uint _49 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _130)))
        {
            break;
        }
        _130 -= uvec2(uint(_130.y == 0u), 1u);
        if (_49 >= 23u)
        {
            break;
        }
        uint _145 = _47;
        uint _147 = _145 << 1u;
        bool _148 = _147 >= _41;
        _47 = _148 ? (_147 - _41) : _147;
        _45 = (_45 << 1u) | uint(_148);
        _49++;
        continue;
    }
    if (_115 < (-126))
    {
        uint _163 = uint((-126) - _115) & 31u;
        uint _164 = 1u << _163;
        uint _166 = _45 & (_164 - 1u);
        uint _167 = _164 >> 1u;
        uint _168 = _45 >> _163;
        return _55 | (_168 + uint((_166 > _167) || ((_166 == _167) && ((_47 != 0u) || ((_168 & 1u) != 0u)))));
    }
    uint _180 = _47 << 1u;
    uint _188 = _45 + uint((_180 > _41) || ((_180 == _41) && ((_45 & 1u) != 0u)));
    uint _189 = _188 >> 24u;
    int _192 = _115 + int(_189);
    if (_192 > 127)
    {
        return _56;
    }
    return _55 | ((uint(_192 + 127) << 23u) | ((_188 >> _189) & 8388607u));
}

float _205(float _203, float _204)
{
    return uintBitsToFloat(_18(floatBitsToUint(_203), floatBitsToUint(_204)));
}

uint _228(uint _227)
{
    uint _231 = _227 & 2147483647u;
    return (_231 > 2139095040u) ? 2143289344u : _231;
}

int _215(bool _213, bool _214)
{
    int _219 = 0;
    if (_213)
    {
        _219 = 7;
    }
    else
    {
        _219 = 9;
    }
    return _219;
}

void main()
{
    uint _288 = 0u;
    uint _282 = 0u;
    bool _275 = false;
    uint _269 = 0u;
    uint _263 = 0u;
    uint _292 = 0u;
    uint _286 = 0u;
    uint _280 = 0u;
    uint _273 = 0u;
    int _267 = 0;
    uint _261 = 0u;
    uint _290 = 0u;
    uint _284 = 0u;
    bool _278 = false;
    uint _271 = 0u;
    uint _265 = 0u;
    uint _298 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_298 >= 4096u)
    {
        return;
    }
    uint _303 = 4u + (_298 * 10u);
    _261 = _298 * 2u;
    uint _308 = _9._m0[_261];
    float _309 = uintBitsToFloat(_308);
    _263 = (_298 * 2u) + 1u;
    uint _314 = _9._m0[_263];
    float _315 = uintBitsToFloat(_314);
    _12._m0[_303] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_309), floatBitsToUint(_315))));
    _265 = _303 + 1u;
    _12._m0[_265] = floatBitsToUint(_205(_309, _315));
    _267 = 0;
    int _328 = _267;
    _267 = _328 + 1;
    _271 = (_298 * 2u) + uint(_328);
    int _337 = _267;
    _267 = _337 + 1;
    _273 = (_298 * 2u) + uint(_337);
    _269 = _303 + 2u;
    _12._m0[_269] = floatBitsToUint(_205(uintBitsToFloat(_9._m0[_271]), uintBitsToFloat(_9._m0[_273])));
    _275 = false;
    if (false)
    {
        int _352 = _267;
        _267 = _352 + 1;
        _275 = _228(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_352)), floatBitsToUint(_309))))) != 0u;
    }
    _278 = true;
    if (!true)
    {
        int _364 = _267;
        _267 = _364 + 1;
        _278 = _228(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_309), floatBitsToUint(float(_364)))))) != 0u;
    }
    _280 = _303 + 3u;
    _12._m0[_280] = uint(_267);
    float _379 = -0.0;
    float _380 = -0.0;
    _282 = _303 + 4u;
    _12._m0[_282] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_379), floatBitsToUint(_380))));
    float _389 = -0.0;
    _284 = _303 + 5u;
    _12._m0[_284] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_389), floatBitsToUint(0.0))));
    float _398 = float(2);
    float _399 = float(3u);
    _286 = _303 + 6u;
    _12._m0[_286] = floatBitsToUint(_205(_398, _399));
    _288 = _303 + 7u;
    _12._m0[_288] = uint(_215(true, false));
    _290 = _303 + 8u;
    _12._m0[_290] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_315), floatBitsToUint(_309))));
    _292 = _303 + 9u;
    _12._m0[_292] = floatBitsToUint(_205(1.0, 3.0));
}

