#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _9
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _12_11
{
    uvec2 _m0[];
} _11;

layout(set = 0, binding = 1, std430) buffer _15_14
{
    uint _m0[];
} _14;

layout(set = 0, binding = 2, std140) uniform _18_17
{
    _9 _m0;
} _17;

uint _29(uint _27, uint _28)
{
    uint _56 = 0u;
    int _49 = 0;
    int _54 = 0;
    uint _46 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uvec2 _144 = uvec2(4294967295u);
    uint _63 = _27 & 2147483647u;
    uint _64 = _28 & 2147483647u;
    uint _66 = (_27 ^ _28) & 2147483648u;
    uint _67 = _66 | 2139095040u;
    bool _72 = _63 == 0u;
    bool _73 = _64 == 0u;
    bool _75 = _63 == 2139095040u;
    bool _76 = _64 == 2139095040u;
    if ((((_63 > 2139095040u) || (_64 > 2139095040u)) || (_72 && _73)) || (_75 && _76))
    {
        return 2143289344u;
    }
    if (_75 || _73)
    {
        return _67;
    }
    if (_72 || _76)
    {
        return _66;
    }
    uint _88 = _63 & 8388607u;
    uint _89 = _63 >> 23u;
    _46 = _88 | 8388608u;
    _49 = int(_89) - 127;
    if (_89 == 0u)
    {
        uint _98 = (31u - uint(findMSB(_88))) - 8u;
        _46 = _88 << _98;
        _49 = (-126) - int(_98);
    }
    uint _104 = _64 & 8388607u;
    uint _105 = _64 >> 23u;
    _52 = _104 | 8388608u;
    _54 = int(_105) - 127;
    if (_105 == 0u)
    {
        uint _114 = (31u - uint(findMSB(_104))) - 8u;
        _52 = _104 << _114;
        _54 = (-126) - int(_114);
    }
    bool _120 = _46 < _52;
    int _127 = (_49 - _54) - int(_120);
    bool _129 = _66 != 0u;
    if (_127 < (-150))
    {
        return _66 | uint(_129);
    }
    _56 = 1u;
    _58 = (_120 ? (_46 << 1u) : _46) - _52;
    uint _60 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _144)))
        {
            break;
        }
        _144 -= uvec2(uint(_144.y == 0u), 1u);
        if (_60 >= 23u)
        {
            break;
        }
        uint _159 = _58;
        uint _161 = _159 << 1u;
        bool _162 = _161 >= _52;
        _58 = _162 ? (_161 - _52) : _161;
        _56 = (_56 << 1u) | uint(_162);
        _60++;
        continue;
    }
    if (_127 < (-126))
    {
        uint _177 = uint((-126) - _127) & 31u;
        return _66 | ((_56 >> _177) + uint(_129 && (((_56 & ((1u << _177) - 1u)) | _58) != 0u)));
    }
    uint _191 = _56 + uint(_129 && (_58 != 0u));
    uint _192 = _191 >> 24u;
    int _195 = _127 + int(_192);
    if (_195 > 127)
    {
        return _129 ? _67 : 2139095039u;
    }
    return _66 | ((uint(_195 + 127) << 23u) | ((_191 >> _192) & 8388607u));
}

uint _22(float _21)
{
    return 1u;
}

uint _209(uint _207, uint _208)
{
    uint _219 = 0u;
    int _213 = 0;
    int _217 = 0;
    uint _211 = 0u;
    uint _221 = 0u;
    uint _215 = 0u;
    uvec2 _299 = uvec2(4294967295u);
    uint _226 = _207 & 2147483647u;
    uint _227 = _208 & 2147483647u;
    uint _229 = (_207 ^ _208) & 2147483648u;
    uint _230 = _229 | 2139095040u;
    bool _234 = _226 == 0u;
    bool _235 = _227 == 0u;
    bool _237 = _226 == 2139095040u;
    bool _238 = _227 == 2139095040u;
    if ((((_226 > 2139095040u) || (_227 > 2139095040u)) || (_234 && _235)) || (_237 && _238))
    {
        return 2143289344u;
    }
    if (_237 || _235)
    {
        return _230;
    }
    if (_234 || _238)
    {
        return _229;
    }
    uint _250 = _226 & 8388607u;
    uint _251 = _226 >> 23u;
    _211 = _250 | 8388608u;
    _213 = int(_251) - 127;
    if (_251 == 0u)
    {
        uint _260 = (31u - uint(findMSB(_250))) - 8u;
        _211 = _250 << _260;
        _213 = (-126) - int(_260);
    }
    uint _266 = _227 & 8388607u;
    uint _267 = _227 >> 23u;
    _215 = _266 | 8388608u;
    _217 = int(_267) - 127;
    if (_267 == 0u)
    {
        uint _276 = (31u - uint(findMSB(_266))) - 8u;
        _215 = _266 << _276;
        _217 = (-126) - int(_276);
    }
    bool _282 = _211 < _215;
    int _287 = (_213 - _217) - int(_282);
    bool _289 = _229 == 0u;
    if (_287 < (-150))
    {
        return _229 | uint(_289);
    }
    _219 = 1u;
    _221 = (_282 ? (_211 << 1u) : _211) - _215;
    uint _223 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _299)))
        {
            break;
        }
        _299 -= uvec2(uint(_299.y == 0u), 1u);
        if (_223 >= 23u)
        {
            break;
        }
        uint _314 = _221;
        uint _316 = _314 << 1u;
        bool _317 = _316 >= _215;
        _221 = _317 ? (_316 - _215) : _316;
        _219 = (_219 << 1u) | uint(_317);
        _223++;
        continue;
    }
    if (_287 < (-126))
    {
        uint _332 = uint((-126) - _287) & 31u;
        return _229 | ((_219 >> _332) + uint(_289 && (((_219 & ((1u << _332) - 1u)) | _221) != 0u)));
    }
    uint _346 = _219 + uint(_289 && (_221 != 0u));
    uint _347 = _346 >> 24u;
    int _350 = _287 + int(_347);
    if (_350 > 127)
    {
        return _289 ? _230 : 4286578687u;
    }
    return _229 | ((uint(_350 + 127) << 23u) | ((_346 >> _347) & 8388607u));
}

void main()
{
    float _430 = 0.0;
    float _423 = 0.0;
    uint _417 = 0u;
    uint _411 = 0u;
    uint _405 = 0u;
    uint _399 = 0u;
    uint _393 = 0u;
    float _434 = 0.0;
    float _428 = 0.0;
    uint _421 = 0u;
    uint _415 = 0u;
    uint _409 = 0u;
    uint _403 = 0u;
    uint _397 = 0u;
    uint _391 = 0u;
    float _432 = 0.0;
    float _426 = 0.0;
    uint _419 = 0u;
    uint _413 = 0u;
    uint _407 = 0u;
    uint _401 = 0u;
    uint _395 = 0u;
    uint _443 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_443 >= _17._m0._m0)
    {
        return;
    }
    uint _448 = 4u + (_443 * 16u);
    uint _452 = _11._m0[_443].x;
    float _453 = uintBitsToFloat(_452);
    uint _455 = _11._m0[_443].y;
    float _456 = uintBitsToFloat(_455);
    _391 = 0u;
    _14._m0[_448] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_453), floatBitsToUint(_456))));
    _423 = 0.0;
    _423 = _453;
    _391++;
    _426 = 0.0;
    _426 = _456;
    _391++;
    _393 = _448 + 1u;
    _14._m0[_393] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_423), floatBitsToUint(_426))));
    _395 = _448 + 2u;
    _14._m0[_395] = _391;
    _397 = _448 + 3u;
    _14._m0[_397] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_456))));
    _428 = 0.0;
    _428 = _456;
    _391++;
    _399 = _448 + 4u;
    _14._m0[_399] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_428))));
    _401 = _448 + 5u;
    _14._m0[_401] = _391;
    _403 = _448 + 6u;
    _14._m0[_403] = _22(uintBitsToFloat(_29(floatBitsToUint(_453), floatBitsToUint(_456))));
    _405 = _448 + 7u;
    _14._m0[_405] = _22(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_456))));
    _407 = _448 + 8u;
    _14._m0[_407] = floatBitsToUint(uintBitsToFloat(_209(floatBitsToUint(_453), floatBitsToUint(_456))));
    _430 = 0.0;
    _430 = _453;
    _391++;
    _432 = 0.0;
    _432 = _456;
    _391++;
    _409 = _448 + 9u;
    _14._m0[_409] = floatBitsToUint(uintBitsToFloat(_209(floatBitsToUint(_430), floatBitsToUint(_432))));
    _411 = _448 + 10u;
    _14._m0[_411] = _391;
    _413 = _448 + 11u;
    _14._m0[_413] = floatBitsToUint(uintBitsToFloat(_209(floatBitsToUint(1.0), floatBitsToUint(_456))));
    _434 = 0.0;
    _434 = _456;
    _391++;
    _415 = _448 + 12u;
    _14._m0[_415] = floatBitsToUint(uintBitsToFloat(_209(floatBitsToUint(1.0), floatBitsToUint(_434))));
    _417 = _448 + 13u;
    _14._m0[_417] = _391;
    _419 = _448 + 14u;
    _14._m0[_419] = _22(uintBitsToFloat(_209(floatBitsToUint(_453), floatBitsToUint(_456))));
    _421 = _448 + 15u;
    _14._m0[_421] = _22(uintBitsToFloat(_209(floatBitsToUint(1.0), floatBitsToUint(_456))));
}

