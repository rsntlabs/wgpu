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
    uint _47 = _16 & 2147483647u;
    uint _48 = _17 & 2147483647u;
    uint _50 = (_16 ^ _17) & 2147483648u;
    if ((_47 > 2139095040u) || (_48 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _58 = (_47 == 2139095040u) || (_48 == 2139095040u);
    bool _61 = (_47 == 0u) || (_48 == 0u);
    if (_58 && _61)
    {
        return 2143289344u;
    }
    if (_58)
    {
        return _50 | 2139095040u;
    }
    if (_61)
    {
        return _50;
    }
    uint _70 = _47 >> 23u;
    uint _71 = _48 >> 23u;
    bool _72 = _70 != 0u;
    bool _73 = _71 != 0u;
    uint _78 = (_47 & 8388607u) | (_72 ? 8388608u : 0u);
    uint _79 = (_48 & 8388607u) | (_73 ? 8388608u : 0u);
    uint _80 = _78 & 4095u;
    uint _81 = _79 & 4095u;
    uint _82 = _78 >> 12u;
    uint _83 = _79 >> 12u;
    uint _84 = _80 * _81;
    uint _89 = ((_80 * _83) + (_82 * _81)) + (_84 >> 12u);
    uint _92 = (_82 * _83) + (_89 >> 12u);
    uint _96 = (_84 & 4095u) | ((_89 & 4095u) << 12u);
    int _106 = int((_92 != 0u) ? (55u - (31u - uint(findMSB(_92)))) : (31u - (31u - uint(findMSB(_96 | 1u)))));
    int _111 = int(_72 ? _70 : 1u) + int(_73 ? _71 : 1u);
    int _113 = (_106 + _111) - 173;
    int _117 = max((_106 - 23), (151 - _111)) - 3;
    uint _129 = uint(min(max(_117, 0), 31)) & 31u;
    uint _151 = uint(min(max((_117 - 24), 0), 31)) & 31u;
    uint _172 = ((_117 <= 0) ? (((_92 << 24u) | _96) << (uint(min(max((0 - _117), 0), 31)) & 31u)) : ((_117 < 24) ? (((_92 << (uint(min(max((24 - _117), 0), 31)) & 31u)) | (_96 >> _129)) | uint((_96 & ((1u << _129) - 1u)) != 0u)) : ((_117 == 24) ? (_92 | uint(_96 != 0u)) : ((_117 < 48) ? ((_92 >> _151) | uint(((_92 & ((1u << _151) - 1u)) != 0u) || (_96 != 0u))) : uint((_92 | _96) != 0u))))) >> 3u;
    if (_113 >= 255)
    {
        return _50 | 2139095039u;
    }
    return _50 | ((((_172 >= 8388608u) ? uint(max(_113, 1)) : 0u) << 23u) | (_172 & 8388607u));
}

float _188(float _186, float _187)
{
    return uintBitsToFloat(_18(floatBitsToUint(_186), floatBitsToUint(_187)));
}

uint _212(uint _211)
{
    uint _215 = _211 & 2147483647u;
    return (_215 > 2139095040u) ? 2143289344u : _215;
}

int _198(bool _196, bool _197)
{
    int _202 = 0;
    if (_196)
    {
        _202 = 7;
    }
    else
    {
        _202 = 9;
    }
    return _202;
}

uint _221(uint _219, uint _220)
{
    uint _226 = _219 & 2147483647u;
    uint _227 = _220 & 2147483647u;
    uint _229 = (_219 ^ _220) & 2147483648u;
    if ((_226 > 2139095040u) || (_227 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _237 = (_226 == 2139095040u) || (_227 == 2139095040u);
    bool _240 = (_226 == 0u) || (_227 == 0u);
    if (_237 && _240)
    {
        return 2143289344u;
    }
    uint _244 = _229 | 2139095040u;
    if (_237)
    {
        return _244;
    }
    if (_240)
    {
        return _229;
    }
    uint _249 = _226 >> 23u;
    uint _250 = _227 >> 23u;
    bool _251 = _249 != 0u;
    bool _252 = _250 != 0u;
    uint _257 = (_226 & 8388607u) | (_251 ? 8388608u : 0u);
    uint _258 = (_227 & 8388607u) | (_252 ? 8388608u : 0u);
    uint _259 = _257 & 4095u;
    uint _260 = _258 & 4095u;
    uint _261 = _257 >> 12u;
    uint _262 = _258 >> 12u;
    uint _263 = _259 * _260;
    uint _268 = ((_259 * _262) + (_261 * _260)) + (_263 >> 12u);
    uint _271 = (_261 * _262) + (_268 >> 12u);
    uint _275 = (_263 & 4095u) | ((_268 & 4095u) << 12u);
    int _285 = int((_271 != 0u) ? (55u - (31u - uint(findMSB(_271)))) : (31u - (31u - uint(findMSB(_275 | 1u)))));
    int _290 = int(_251 ? _249 : 1u) + int(_252 ? _250 : 1u);
    int _296 = max((_285 - 23), (151 - _290)) - 3;
    uint _308 = uint(min(max(_296, 0), 31)) & 31u;
    uint _330 = uint(min(max((_296 - 24), 0), 31)) & 31u;
    uint _350 = (_296 <= 0) ? (((_271 << 24u) | _275) << (uint(min(max((0 - _296), 0), 31)) & 31u)) : ((_296 < 24) ? (((_271 << (uint(min(max((24 - _296), 0), 31)) & 31u)) | (_275 >> _308)) | uint((_275 & ((1u << _308) - 1u)) != 0u)) : ((_296 == 24) ? (_271 | uint(_275 != 0u)) : ((_296 < 48) ? ((_271 >> _330) | uint(((_271 & ((1u << _330) - 1u)) != 0u) || (_275 != 0u))) : uint((_271 | _275) != 0u))));
    uint _351 = _350 & 7u;
    uint _352 = _350 >> 3u;
    uint _360 = _352 + uint((_351 > 4u) || ((_351 == 4u) && ((_352 & 1u) != 0u)));
    bool _361 = _360 >= 16777216u;
    uint _363 = _361 ? (_360 >> 1u) : _360;
    int _365 = ((_285 + _290) - 173) + int(_361);
    if (_365 >= 255)
    {
        return _244;
    }
    return _229 | ((((_363 >= 8388608u) ? uint(max(_365, 1)) : 0u) << 23u) | (_363 & 8388607u));
}

void main()
{
    uint _428 = 0u;
    uint _422 = 0u;
    bool _415 = false;
    uint _409 = 0u;
    uint _403 = 0u;
    uint _432 = 0u;
    uint _426 = 0u;
    uint _420 = 0u;
    uint _413 = 0u;
    int _407 = 0;
    uint _400 = 0u;
    uint _430 = 0u;
    uint _424 = 0u;
    bool _418 = false;
    uint _411 = 0u;
    uint _405 = 0u;
    uint _438 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_438 >= 4096u)
    {
        return;
    }
    uint _443 = 4u + (_438 * 10u);
    _400 = _438 * 2u;
    uint _448 = _9._m0[_400];
    float _449 = uintBitsToFloat(_448);
    _403 = (_438 * 2u) + 1u;
    uint _454 = _9._m0[_403];
    float _455 = uintBitsToFloat(_454);
    _12._m0[_443] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_449), floatBitsToUint(_455))));
    _405 = _443 + 1u;
    _12._m0[_405] = floatBitsToUint(_188(_449, _455));
    _407 = 0;
    int _468 = _407;
    _407 = _468 + 1;
    _411 = (_438 * 2u) + uint(_468);
    int _477 = _407;
    _407 = _477 + 1;
    _413 = (_438 * 2u) + uint(_477);
    _409 = _443 + 2u;
    _12._m0[_409] = floatBitsToUint(_188(uintBitsToFloat(_9._m0[_411]), uintBitsToFloat(_9._m0[_413])));
    _415 = false;
    if (false)
    {
        int _492 = _407;
        _407 = _492 + 1;
        _415 = _212(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_492)), floatBitsToUint(_449))))) != 0u;
    }
    _418 = true;
    if (!true)
    {
        int _504 = _407;
        _407 = _504 + 1;
        _418 = _212(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_449), floatBitsToUint(float(_504)))))) != 0u;
    }
    _420 = _443 + 3u;
    _12._m0[_420] = uint(_407);
    float _519 = -0.0;
    float _520 = -0.0;
    _422 = _443 + 4u;
    _12._m0[_422] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_519), floatBitsToUint(_520))));
    float _529 = -0.0;
    _424 = _443 + 5u;
    _12._m0[_424] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_529), floatBitsToUint(0.0))));
    float _538 = float(2);
    float _539 = float(3u);
    _426 = _443 + 6u;
    _12._m0[_426] = floatBitsToUint(_188(_538, _539));
    _428 = _443 + 7u;
    _12._m0[_428] = uint(_198(true, false));
    _430 = _443 + 8u;
    _12._m0[_430] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_455), floatBitsToUint(_449))));
    _432 = _443 + 9u;
    _12._m0[_432] = floatBitsToUint(uintBitsToFloat(_221(floatBitsToUint(_449), floatBitsToUint(_455))));
}

