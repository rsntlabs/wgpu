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
    uint _37 = _16 & 2147483647u;
    uint _38 = _17 & 2147483647u;
    uint _39 = _16 & 2147483648u;
    uint _40 = _17 & 2147483648u;
    if ((_37 > 2139095040u) || (_38 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _46 = _37 == 2139095040u;
    bool _47 = _38 == 2139095040u;
    if ((_46 && _47) && (_39 != _40))
    {
        return 2143289344u;
    }
    if (_46)
    {
        return _16;
    }
    if (_47)
    {
        return _17;
    }
    bool _58 = _37 >= _38;
    uint _59 = _58 ? _37 : _38;
    uint _60 = _58 ? _38 : _37;
    uint _61 = _58 ? _39 : _40;
    uint _62 = _59 >> 23u;
    uint _63 = _60 >> 23u;
    bool _64 = _62 != 0u;
    bool _65 = _63 != 0u;
    uint _72 = ((_59 & 8388607u) | (_64 ? 8388608u : 0u)) << 3u;
    uint _73 = ((_60 & 8388607u) | (_65 ? 8388608u : 0u)) << 3u;
    uint _74 = _64 ? _62 : 1u;
    uint _76 = _74 - (_65 ? _63 : 1u);
    uint _77 = _76 & 31u;
    uint _88 = (_76 < 32u) ? ((_73 >> _77) | uint((_73 & ((1u << _77) - 1u)) != 0u)) : uint(_73 != 0u);
    uint _91 = (_39 == _40) ? (_72 + _88) : (_72 - _88);
    if (_91 == 0u)
    {
        return _39 & _40;
    }
    bool _96 = _91 >= 134217728u;
    uint _97 = 1u & 31u;
    uint _109 = _96 ? ((1u < 32u) ? ((_91 >> _97) | uint((_91 & ((1u << _97) - 1u)) != 0u)) : uint(_91 != 0u)) : _91;
    uint _111 = _74 + uint(_96);
    uint _116 = min(((31u - uint(findMSB(_109))) - 5u), (_111 - 1u));
    uint _118 = _111 - _116;
    uint _119 = (_109 << _116) >> 3u;
    if (_118 >= 255u)
    {
        return _61 | 2139095039u;
    }
    return _61 | ((((_119 >= 8388608u) ? _118 : 0u) << 23u) | (_119 & 8388607u));
}

float _133(float _131, float _132)
{
    return uintBitsToFloat(_18(floatBitsToUint(_131), floatBitsToUint(_132) ^ 2147483648u));
}

uint _158(uint _157)
{
    uint _161 = _157 & 2147483647u;
    return (_161 > 2139095040u) ? 2143289344u : _161;
}

int _144(bool _142, bool _143)
{
    int _148 = 0;
    if (_142)
    {
        _148 = 7;
    }
    else
    {
        _148 = 9;
    }
    return _148;
}

uint _167(uint _165, uint _166)
{
    uint _172 = _165 & 2147483647u;
    uint _173 = _166 & 2147483647u;
    uint _174 = _165 & 2147483648u;
    uint _175 = _166 & 2147483648u;
    if ((_172 > 2139095040u) || (_173 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _181 = _172 == 2139095040u;
    bool _182 = _173 == 2139095040u;
    if ((_181 && _182) && (_174 != _175))
    {
        return 2143289344u;
    }
    if (_181)
    {
        return _165;
    }
    if (_182)
    {
        return _166;
    }
    bool _193 = _172 >= _173;
    uint _194 = _193 ? _172 : _173;
    uint _195 = _193 ? _173 : _172;
    uint _196 = _193 ? _174 : _175;
    uint _197 = _194 >> 23u;
    uint _198 = _195 >> 23u;
    bool _199 = _197 != 0u;
    bool _200 = _198 != 0u;
    uint _207 = ((_194 & 8388607u) | (_199 ? 8388608u : 0u)) << 3u;
    uint _208 = ((_195 & 8388607u) | (_200 ? 8388608u : 0u)) << 3u;
    uint _209 = _199 ? _197 : 1u;
    uint _211 = _209 - (_200 ? _198 : 1u);
    uint _212 = _211 & 31u;
    uint _223 = (_211 < 32u) ? ((_208 >> _212) | uint((_208 & ((1u << _212) - 1u)) != 0u)) : uint(_208 != 0u);
    uint _226 = (_174 == _175) ? (_207 + _223) : (_207 - _223);
    if (_226 == 0u)
    {
        return _174 & _175;
    }
    bool _231 = _226 >= 134217728u;
    uint _232 = 1u & 31u;
    uint _244 = _231 ? ((1u < 32u) ? ((_226 >> _232) | uint((_226 & ((1u << _232) - 1u)) != 0u)) : uint(_226 != 0u)) : _226;
    uint _246 = _209 + uint(_231);
    uint _251 = min(((31u - uint(findMSB(_244))) - 5u), (_246 - 1u));
    uint _252 = _244 << _251;
    uint _254 = _252 & 7u;
    uint _255 = _252 >> 3u;
    uint _263 = _255 + uint((_254 > 4u) || ((_254 == 4u) && ((_255 & 1u) != 0u)));
    bool _264 = _263 >= 16777216u;
    uint _266 = _264 ? (_263 >> 1u) : _263;
    uint _268 = (_246 - _251) + uint(_264);
    if (_268 >= 255u)
    {
        return _196 | 2139095040u;
    }
    return _196 | ((((_266 >= 8388608u) ? _268 : 0u) << 23u) | (_266 & 8388607u));
}

void main()
{
    uint _336 = 0u;
    uint _329 = 0u;
    uint _323 = 0u;
    bool _316 = false;
    uint _310 = 0u;
    uint _304 = 0u;
    float _333 = 0.0;
    uint _327 = 0u;
    uint _321 = 0u;
    uint _314 = 0u;
    int _308 = 0;
    uint _301 = 0u;
    uint _331 = 0u;
    uint _325 = 0u;
    bool _319 = false;
    uint _312 = 0u;
    uint _306 = 0u;
    uint _342 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_342 >= 4096u)
    {
        return;
    }
    uint _347 = 4u + (_342 * 10u);
    _301 = _342 * 2u;
    uint _352 = _9._m0[_301];
    float _353 = uintBitsToFloat(_352);
    _304 = (_342 * 2u) + 1u;
    uint _358 = _9._m0[_304];
    float _359 = uintBitsToFloat(_358);
    _12._m0[_347] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_353), floatBitsToUint(_359) ^ 2147483648u)));
    _306 = _347 + 1u;
    _12._m0[_306] = floatBitsToUint(_133(_353, _359));
    _308 = 0;
    int _373 = _308;
    _308 = _373 + 1;
    _312 = (_342 * 2u) + uint(_373);
    int _382 = _308;
    _308 = _382 + 1;
    _314 = (_342 * 2u) + uint(_382);
    _310 = _347 + 2u;
    _12._m0[_310] = floatBitsToUint(_133(uintBitsToFloat(_9._m0[_312]), uintBitsToFloat(_9._m0[_314])));
    _316 = false;
    if (false)
    {
        int _397 = _308;
        _308 = _397 + 1;
        _316 = _158(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_397)), floatBitsToUint(_353) ^ 2147483648u)))) != 0u;
    }
    _319 = true;
    if (!true)
    {
        int _410 = _308;
        _308 = _410 + 1;
        _319 = _158(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_353), floatBitsToUint(float(_410)) ^ 2147483648u)))) != 0u;
    }
    _321 = _347 + 3u;
    _12._m0[_321] = uint(_308);
    float _426 = -0.0;
    float _427 = -0.0;
    _323 = _347 + 4u;
    _12._m0[_323] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_426), floatBitsToUint(_427) ^ 2147483648u)));
    float _437 = -0.0;
    _325 = _347 + 5u;
    _12._m0[_325] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_437), floatBitsToUint(0.0) ^ 2147483648u)));
    float _447 = float(1);
    float _448 = float(2u);
    _327 = _347 + 6u;
    _12._m0[_327] = floatBitsToUint(_133(_447, _448));
    _329 = _347 + 7u;
    _12._m0[_329] = uint(_144(true, false));
    if (true)
    {
        _333 = uintBitsToFloat(_18(floatBitsToUint(_353), floatBitsToUint(_359) ^ 2147483648u));
    }
    else
    {
        int _467 = _308;
        _308 = _467 + 1;
        _333 = uintBitsToFloat(_18(floatBitsToUint(float(_467)), floatBitsToUint(_353) ^ 2147483648u));
    }
    _331 = _347 + 8u;
    _12._m0[_331] = floatBitsToUint(_333);
    _336 = _347 + 9u;
    _12._m0[_336] = floatBitsToUint(uintBitsToFloat(_167(floatBitsToUint(_353), floatBitsToUint(_359) ^ 2147483648u)));
}

