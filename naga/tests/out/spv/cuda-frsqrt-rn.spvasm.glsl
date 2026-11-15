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

uint _17(uint _16)
{
    uint _42 = 0u;
    uint _45 = 0u;
    uvec2 _101 = uvec2(4294967295u);
    uint _48 = _16 & 2147483647u;
    uint _49 = _16 & 2147483648u;
    if (_48 == 0u)
    {
        return _49 | 2139095040u;
    }
    if ((_49 != 0u) || (_48 > 2139095040u))
    {
        return 2143289344u;
    }
    if (_48 == 2139095040u)
    {
        return 0u;
    }
    uint _62 = _48 >> 23u;
    uint _63 = _48 & 8388607u;
    bool _64 = _62 != 0u;
    uint _69 = (31u - uint(findMSB(_63 | 1u))) - 8u;
    uint _72 = _64 ? (_63 | 8388608u) : (_63 << (_69 & 31u));
    int _76 = _64 ? int(_62) : (1 - int(_69));
    int _77 = _76 - 127;
    int _86 = ((-(_77 + 1)) >> int(1u)) + int(((_77 & 1) == 0) && (_72 == 8388608u));
    uint _90 = uint((198 - _76) - (_86 * 2));
    _42 = 8388608u;
    _45 = 22u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _101)))
        {
            break;
        }
        _101 -= uvec2(uint(_101.y == 0u), 1u);
        uint _116 = _42 | (1u << (_45 & 31u));
        uint _117 = _116 << 1u;
        uint _118 = _117 & 4095u;
        uint _119 = _117 >> 12u;
        uint _120 = _118 * _118;
        uint _124 = (2u * (_118 * _119)) + (_120 >> 12u);
        uint _127 = (_119 * _119) + (_124 >> 12u);
        uint _128 = _120 & 4095u;
        uint _129 = _124 & 4095u;
        uint _130 = _127 & 4095u;
        uint _132 = (_127 >> 12u) & 4095u;
        uint _133 = _127 >> 24u;
        uint _134 = _72 & 4095u;
        uint _135 = _72 >> 12u;
        uint _160 = ((_135 * _133) + ((((_134 * _133) + (_135 * _132)) + ((((_134 * _132) + (_135 * _130)) + ((((_134 * _130) + (_135 * _129)) + ((((_134 * _129) + (_135 * _128)) + ((_134 * _128) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u;
        _42 = (((71u + uint(_160 != 0u)) + uint(_160 >= 2u)) < _90) ? _116 : _42;
        if (_45 == 0u)
        {
            break;
        }
        _45--;
        continue;
    }
    uint _175 = (_42 << 1u) + 1u;
    uint _176 = _175 & 4095u;
    uint _177 = _175 >> 12u;
    uint _178 = _176 * _176;
    uint _182 = (2u * (_176 * _177)) + (_178 >> 12u);
    uint _185 = (_177 * _177) + (_182 >> 12u);
    uint _186 = _178 & 4095u;
    uint _187 = _182 & 4095u;
    uint _188 = _185 & 4095u;
    uint _190 = (_185 >> 12u) & 4095u;
    uint _191 = _185 >> 24u;
    uint _192 = _72 & 4095u;
    uint _193 = _72 >> 12u;
    uint _218 = ((_193 * _191) + ((((_192 * _191) + (_193 * _190)) + ((((_192 * _190) + (_193 * _188)) + ((((_192 * _188) + (_193 * _187)) + ((((_192 * _187) + (_193 * _186)) + ((_192 * _186) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u;
    uint _227 = _42 + uint(((71u + uint(_218 != 0u)) + uint(_218 >= 2u)) < _90);
    bool _228 = _227 >= 16777216u;
    return (uint((_86 + int(_228)) + 127) << 23u) | ((_228 ? (_227 >> 1u) : _227) & 8388607u);
}

float _240(float _239)
{
    return uintBitsToFloat(_17(floatBitsToUint(_239)));
}

uint _262(uint _261)
{
    uint _264 = _261 & 2147483647u;
    return (_264 > 2139095040u) ? 2143289344u : _264;
}

int _248(bool _247)
{
    int _252 = 0;
    if (_247)
    {
        _252 = 7;
    }
    else
    {
        _252 = 9;
    }
    return _252;
}

void main()
{
    float _317 = 0.0;
    uint _311 = 0u;
    uint _305 = 0u;
    bool _298 = false;
    int _292 = 0;
    uint _315 = 0u;
    uint _309 = 0u;
    uint _303 = 0u;
    uint _296 = 0u;
    uint _290 = 0u;
    uint _320 = 0u;
    uint _313 = 0u;
    uint _307 = 0u;
    bool _301 = false;
    uint _294 = 0u;
    uint _326 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_326 >= 4096u)
    {
        return;
    }
    uint _331 = 4u + (_326 * 10u);
    uint _334 = _9._m0[_326];
    float _335 = uintBitsToFloat(_334);
    _12._m0[_331] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_335))));
    _290 = _331 + 1u;
    _12._m0[_290] = floatBitsToUint(_240(_335));
    _292 = 0;
    int _346 = _292;
    _292 = _346 + 1;
    _296 = _326 + uint(_346);
    _294 = _331 + 2u;
    _12._m0[_294] = floatBitsToUint(_240(uintBitsToFloat(_9._m0[_296])));
    _298 = false;
    if (false)
    {
        int _361 = _292;
        _292 = _361 + 1;
        _298 = _262(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_361)))))) != 0u;
    }
    _301 = true;
    if (!true)
    {
        int _372 = _292;
        _292 = _372 + 1;
        _301 = _262(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_372)))))) != 0u;
    }
    _303 = _331 + 3u;
    _12._m0[_303] = uint(_292);
    float _386 = -0.0;
    _305 = _331 + 4u;
    _12._m0[_305] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_386))));
    _309 = 2139095040u;
    _307 = _331 + 5u;
    _12._m0[_307] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_309)))));
    float _403 = float(4u);
    _311 = _331 + 6u;
    _12._m0[_311] = floatBitsToUint(_240(_403));
    _313 = _331 + 7u;
    _12._m0[_313] = uint(_248(true));
    if (true)
    {
        _317 = uintBitsToFloat(_17(floatBitsToUint(_335)));
    }
    else
    {
        int _420 = _292;
        _292 = _420 + 1;
        _317 = uintBitsToFloat(_17(floatBitsToUint(float(_420))));
    }
    _315 = _331 + 8u;
    _12._m0[_315] = floatBitsToUint(_317);
    _320 = _331 + 9u;
    _12._m0[_320] = uint(_292);
}

