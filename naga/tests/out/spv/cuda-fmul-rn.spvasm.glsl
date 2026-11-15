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
    uint _49 = _16 & 2147483647u;
    uint _50 = _17 & 2147483647u;
    uint _52 = (_16 ^ _17) & 2147483648u;
    if ((_49 > 2139095040u) || (_50 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _60 = (_49 == 2139095040u) || (_50 == 2139095040u);
    bool _63 = (_49 == 0u) || (_50 == 0u);
    if (_60 && _63)
    {
        return 2143289344u;
    }
    uint _67 = _52 | 2139095040u;
    if (_60)
    {
        return _67;
    }
    if (_63)
    {
        return _52;
    }
    uint _72 = _49 >> 23u;
    uint _73 = _50 >> 23u;
    bool _74 = _72 != 0u;
    bool _75 = _73 != 0u;
    uint _80 = (_49 & 8388607u) | (_74 ? 8388608u : 0u);
    uint _81 = (_50 & 8388607u) | (_75 ? 8388608u : 0u);
    uint _82 = _80 & 4095u;
    uint _83 = _81 & 4095u;
    uint _84 = _80 >> 12u;
    uint _85 = _81 >> 12u;
    uint _86 = _82 * _83;
    uint _91 = ((_82 * _85) + (_84 * _83)) + (_86 >> 12u);
    uint _94 = (_84 * _85) + (_91 >> 12u);
    uint _98 = (_86 & 4095u) | ((_91 & 4095u) << 12u);
    int _108 = int((_94 != 0u) ? (55u - (31u - uint(findMSB(_94)))) : (31u - (31u - uint(findMSB(_98 | 1u)))));
    int _113 = int(_74 ? _72 : 1u) + int(_75 ? _73 : 1u);
    int _119 = max((_108 - 23), (151 - _113)) - 3;
    uint _131 = uint(min(max(_119, 0), 31)) & 31u;
    uint _153 = uint(min(max((_119 - 24), 0), 31)) & 31u;
    uint _173 = (_119 <= 0) ? (((_94 << 24u) | _98) << (uint(min(max((0 - _119), 0), 31)) & 31u)) : ((_119 < 24) ? (((_94 << (uint(min(max((24 - _119), 0), 31)) & 31u)) | (_98 >> _131)) | uint((_98 & ((1u << _131) - 1u)) != 0u)) : ((_119 == 24) ? (_94 | uint(_98 != 0u)) : ((_119 < 48) ? ((_94 >> _153) | uint(((_94 & ((1u << _153) - 1u)) != 0u) || (_98 != 0u))) : uint((_94 | _98) != 0u))));
    uint _174 = _173 & 7u;
    uint _175 = _173 >> 3u;
    uint _183 = _175 + uint((_174 > 4u) || ((_174 == 4u) && ((_175 & 1u) != 0u)));
    bool _184 = _183 >= 16777216u;
    uint _186 = _184 ? (_183 >> 1u) : _183;
    int _188 = ((_108 + _113) - 173) + int(_184);
    if (_188 >= 255)
    {
        return _67;
    }
    return _52 | ((((_186 >= 8388608u) ? uint(max(_188, 1)) : 0u) << 23u) | (_186 & 8388607u));
}

float _203(float _201, float _202)
{
    return uintBitsToFloat(_18(floatBitsToUint(_201), floatBitsToUint(_202)));
}

uint _227(uint _226)
{
    uint _230 = _226 & 2147483647u;
    return (_230 > 2139095040u) ? 2143289344u : _230;
}

int _213(bool _211, bool _212)
{
    int _217 = 0;
    if (_211)
    {
        _217 = 7;
    }
    else
    {
        _217 = 9;
    }
    return _217;
}

void main()
{
    uint _293 = 0u;
    uint _287 = 0u;
    uint _281 = 0u;
    bool _274 = false;
    uint _268 = 0u;
    uint _262 = 0u;
    uint _291 = 0u;
    uint _285 = 0u;
    uint _279 = 0u;
    uint _272 = 0u;
    int _266 = 0;
    uint _259 = 0u;
    uint _295 = 0u;
    uint _289 = 0u;
    uint _283 = 0u;
    bool _277 = false;
    uint _270 = 0u;
    uint _264 = 0u;
    uint _301 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_301 >= 4096u)
    {
        return;
    }
    uint _306 = 4u + (_301 * 10u);
    _259 = _301 * 2u;
    uint _311 = _9._m0[_259];
    float _312 = uintBitsToFloat(_311);
    _262 = (_301 * 2u) + 1u;
    uint _317 = _9._m0[_262];
    float _318 = uintBitsToFloat(_317);
    _12._m0[_306] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_312), floatBitsToUint(_318))));
    _264 = _306 + 1u;
    _12._m0[_264] = floatBitsToUint(_203(_312, _318));
    _266 = 0;
    int _331 = _266;
    _266 = _331 + 1;
    _270 = (_301 * 2u) + uint(_331);
    int _340 = _266;
    _266 = _340 + 1;
    _272 = (_301 * 2u) + uint(_340);
    _268 = _306 + 2u;
    _12._m0[_268] = floatBitsToUint(_203(uintBitsToFloat(_9._m0[_270]), uintBitsToFloat(_9._m0[_272])));
    _274 = false;
    if (false)
    {
        int _355 = _266;
        _266 = _355 + 1;
        _274 = _227(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_355)), floatBitsToUint(_312))))) != 0u;
    }
    _277 = true;
    if (!true)
    {
        int _367 = _266;
        _266 = _367 + 1;
        _277 = _227(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_312), floatBitsToUint(float(_367)))))) != 0u;
    }
    _279 = _306 + 3u;
    _12._m0[_279] = uint(_266);
    float _382 = -0.0;
    float _383 = -0.0;
    _281 = _306 + 4u;
    _12._m0[_281] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_382), floatBitsToUint(_383))));
    float _392 = -0.0;
    _283 = _306 + 5u;
    _12._m0[_283] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_392), floatBitsToUint(0.0))));
    float _401 = float(2);
    float _402 = float(3u);
    _285 = _306 + 6u;
    _12._m0[_285] = floatBitsToUint(_203(_401, _402));
    _287 = _306 + 7u;
    _12._m0[_287] = uint(_213(true, false));
    _289 = _306 + 8u;
    _12._m0[_289] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_318), floatBitsToUint(_312))));
    _293 = 1065353217u;
    _295 = 1065353214u;
    _291 = _306 + 9u;
    _12._m0[_291] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_293)), floatBitsToUint(uintBitsToFloat(_295)))) - 1.0);
}

