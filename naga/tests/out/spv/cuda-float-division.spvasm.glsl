#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    float _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 1, std430) buffer _16_15
{
    uint _m0[];
} _15;

uint _21(uint _19, uint _20)
{
    uint _48 = 0u;
    int _41 = 0;
    int _46 = 0;
    uint _38 = 0u;
    uint _50 = 0u;
    uint _44 = 0u;
    uvec2 _133 = uvec2(4294967295u);
    uint _55 = _19 & 2147483647u;
    uint _56 = _20 & 2147483647u;
    uint _58 = (_19 ^ _20) & 2147483648u;
    uint _59 = _58 | 2139095040u;
    bool _63 = _55 == 0u;
    bool _64 = _56 == 0u;
    bool _66 = _55 == 2139095040u;
    bool _67 = _56 == 2139095040u;
    if ((((_55 > 2139095040u) || (_56 > 2139095040u)) || (_63 && _64)) || (_66 && _67))
    {
        return 2143289344u;
    }
    if (_66 || _64)
    {
        return _59;
    }
    if (_63 || _67)
    {
        return _58;
    }
    uint _79 = _55 & 8388607u;
    uint _80 = _55 >> 23u;
    _38 = _79 | 8388608u;
    _41 = int(_80) - 127;
    if (_80 == 0u)
    {
        uint _89 = (31u - uint(findMSB(_79))) - 8u;
        _38 = _79 << _89;
        _41 = (-126) - int(_89);
    }
    uint _95 = _56 & 8388607u;
    uint _96 = _56 >> 23u;
    _44 = _95 | 8388608u;
    _46 = int(_96) - 127;
    if (_96 == 0u)
    {
        uint _105 = (31u - uint(findMSB(_95))) - 8u;
        _44 = _95 << _105;
        _46 = (-126) - int(_105);
    }
    bool _111 = _38 < _44;
    int _118 = (_41 - _46) - int(_111);
    if (_118 < (-150))
    {
        return _58;
    }
    _48 = 1u;
    _50 = (_111 ? (_38 << 1u) : _38) - _44;
    uint _52 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _133)))
        {
            break;
        }
        _133 -= uvec2(uint(_133.y == 0u), 1u);
        if (_52 >= 23u)
        {
            break;
        }
        uint _148 = _50;
        uint _150 = _148 << 1u;
        bool _151 = _150 >= _44;
        _50 = _151 ? (_150 - _44) : _150;
        _48 = (_48 << 1u) | uint(_151);
        _52++;
        continue;
    }
    if (_118 < (-126))
    {
        uint _166 = uint((-126) - _118) & 31u;
        uint _167 = 1u << _166;
        uint _169 = _48 & (_167 - 1u);
        uint _170 = _167 >> 1u;
        uint _171 = _48 >> _166;
        return _58 | (_171 + uint((_169 > _170) || ((_169 == _170) && ((_50 != 0u) || ((_171 & 1u) != 0u)))));
    }
    uint _183 = _50 << 1u;
    uint _191 = _48 + uint((_183 > _44) || ((_183 == _44) && ((_48 & 1u) != 0u)));
    uint _192 = _191 >> 24u;
    int _195 = _118 + int(_192);
    if (_195 > 127)
    {
        return _59;
    }
    return _58 | ((uint(_195 + 127) << 23u) | ((_191 >> _192) & 8388607u));
}

float _208(float _206, float _207)
{
    return uintBitsToFloat(_21(floatBitsToUint(_206), floatBitsToUint(_207)));
}

vec4 _218(vec4 _216, vec4 _217)
{
    vec4 _220 = vec4(0.0);
    vec4 _223 = vec4(0.0);
    _220 = _216;
    _223 = _217;
    return vec4(uintBitsToFloat(_21(floatBitsToUint(_220.x), floatBitsToUint(_223.x))), uintBitsToFloat(_21(floatBitsToUint(_220.y), floatBitsToUint(_223.y))), uintBitsToFloat(_21(floatBitsToUint(_220.z), floatBitsToUint(_223.z))), uintBitsToFloat(_21(floatBitsToUint(_220.w), floatBitsToUint(_223.w))));
}

vec4 _264(vec4 _262, float _263)
{
    vec4 _266 = vec4(0.0);
    _266 = _262;
    return vec4(uintBitsToFloat(_21(floatBitsToUint(_266.x), floatBitsToUint(_263))), uintBitsToFloat(_21(floatBitsToUint(_266.y), floatBitsToUint(_263))), uintBitsToFloat(_21(floatBitsToUint(_266.z), floatBitsToUint(_263))), uintBitsToFloat(_21(floatBitsToUint(_266.w), floatBitsToUint(_263))));
}

vec4 _297(float _295, vec4 _296)
{
    vec4 _299 = vec4(0.0);
    _299 = _296;
    return vec4(uintBitsToFloat(_21(floatBitsToUint(_295), floatBitsToUint(_299.x))), uintBitsToFloat(_21(floatBitsToUint(_295), floatBitsToUint(_299.y))), uintBitsToFloat(_21(floatBitsToUint(_295), floatBitsToUint(_299.z))), uintBitsToFloat(_21(floatBitsToUint(_295), floatBitsToUint(_299.w))));
}

int _343(int _345, int _346)
{
    return _345 / (((_346 == 0) || ((_345 == int(0x80000000)) && (_346 == (-1)))) ? 1 : _346);
}

uint _357(uint _358, uint _359)
{
    return _358 / ((_359 == 0u) ? 1u : _359);
}

float _330(_7 _328, _7 _329)
{
    _7 _332 = _7(0.0);
    _7 _335 = _7(0.0);
    _332 = _328;
    _335 = _329;
    return _332._m0 + _335._m0;
}

void main()
{
    float _498 = 0.0;
    vec4 _492 = vec4(0.0);
    bool _480 = false;
    float _473 = 0.0;
    float _467 = 0.0;
    _7 _461 = _7(0.0);
    float _455 = 0.0;
    float _448 = 0.0;
    vec4 _442 = vec4(0.0);
    _7 _500 = _7(0.0);
    float _494 = 0.0;
    float _488 = 0.0;
    bool _482 = false;
    bool _475 = false;
    float _469 = 0.0;
    _7 _463 = _7(0.0);
    _7 _457 = _7(0.0);
    float _450[2] = float[](0.0, 0.0);
    vec4 _444 = vec4(0.0);
    vec4 _496 = vec4(0.0);
    vec4 _490 = vec4(0.0);
    float _484 = 0.0;
    float _478 = 0.0;
    float _471 = 0.0;
    float _465 = 0.0;
    _7 _459 = _7(0.0);
    uint _453 = 0u;
    vec4 _446 = vec4(0.0);
    uvec2 _866 = uvec2(4294967295u);
    uint _506 = _12._m0[uint(0)];
    float _507 = uintBitsToFloat(_506);
    uint _510 = _12._m0[uint(1)];
    float _511 = uintBitsToFloat(_510);
    _15._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_507), floatBitsToUint(_511))));
    _15._m0[uint(1)] = floatBitsToUint(_208(_507, _511));
    float _523 = float(3);
    _15._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_507), floatBitsToUint(_523))));
    float _531 = float(3);
    _15._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_531), floatBitsToUint(_507))));
    float _539 = -0.0;
    _442 = vec4(_507, 1.0, _539, uintBitsToFloat(_12._m0[uint(3)]));
    _444 = vec4(_511, 3.0, 3.0, 2.0);
    _446 = _218(_442, _444);
    _15._m0[uint(4)] = floatBitsToUint(_446.x);
    _15._m0[uint(5)] = floatBitsToUint(_446.y);
    _15._m0[uint(6)] = floatBitsToUint(_446.z);
    _15._m0[uint(7)] = floatBitsToUint(_446.w);
    _446 = _264(_442, 3.0);
    _15._m0[uint(8)] = floatBitsToUint(_446.x);
    _15._m0[uint(9)] = floatBitsToUint(_446.y);
    _15._m0[uint(10)] = floatBitsToUint(_446.z);
    _15._m0[uint(11)] = floatBitsToUint(_446.w);
    _446 = _297(3.0, _444);
    _15._m0[uint(12)] = floatBitsToUint(_446.x);
    _15._m0[uint(13)] = floatBitsToUint(_446.y);
    _15._m0[uint(14)] = floatBitsToUint(_446.z);
    _15._m0[uint(15)] = floatBitsToUint(_446.w);
    _446 = _442;
    _490 = vec4(0.0);
    _490 = _444;
    _492 = _446;
    _446 = _218(_492, _490);
    _15._m0[uint(16)] = floatBitsToUint(_446.x);
    _15._m0[uint(17)] = floatBitsToUint(_446.y);
    _15._m0[uint(18)] = floatBitsToUint(_446.z);
    _15._m0[uint(19)] = floatBitsToUint(_446.w);
    _446 = _442;
    _494 = 0.0;
    _494 = 3.0;
    _496 = _446;
    _446 = _264(_496, _494);
    _15._m0[uint(20)] = floatBitsToUint(_446.x);
    _15._m0[uint(21)] = floatBitsToUint(_446.y);
    _15._m0[uint(22)] = floatBitsToUint(_446.z);
    _15._m0[uint(23)] = floatBitsToUint(_446.w);
    _448 = _507;
    _448 = uintBitsToFloat(_21(floatBitsToUint(_448), floatBitsToUint(_511)));
    _15._m0[uint(24)] = floatBitsToUint(_448);
    _15._m0[uint(25)] = floatBitsToUint(_448);
    _450[0u] = _507;
    _450[1u] = 7.0;
    _453 = 0u;
    _455 = _511;
    float _679 = _455;
    float _680 = float(1);
    _455 = _679 + _680;
    uint _682 = _453;
    _453 = _682 + uint(1);
    _450[_682] = uintBitsToFloat(_21(floatBitsToUint(_450[_682]), floatBitsToUint(_679)));
    _15._m0[uint(26)] = floatBitsToUint(_450[_682]);
    _15._m0[uint(27)] = floatBitsToUint(_450[0u]);
    _15._m0[uint(28)] = _453;
    _15._m0[uint(29)] = floatBitsToUint(_455);
    _15._m0[uint(30)] = floatBitsToUint(_450[1u]);
    int _714 = -7;
    _15._m0[uint(31)] = uint(_343(_714, 3));
    _15._m0[uint(32)] = _357(4294967295u, 3u);
    _457._m0 = 2.0;
    _459._m0 = 3.0;
    _15._m0[uint(33)] = floatBitsToUint(_330(_457, _459));
    _498 = 0.0;
    _498 = 3.0;
    _457._m0 += _498;
    _500 = _457;
    _463 = _500;
    _461 = _463;
    _15._m0[uint(34)] = floatBitsToUint(_461._m0);
    _15._m0[uint(35)] = floatBitsToUint(_457._m0);
    _465 = 0.3333333432674407958984375;
    _15._m0[uint(36)] = floatBitsToUint(_465);
    _467 = 2.0;
    _469 = 3.0;
    float _752 = _467;
    float _753 = float(1);
    _467 = _752 + _753;
    float _755 = _469;
    float _756 = float(1);
    _469 = _755 + _756;
    _15._m0[uint(37)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_752), floatBitsToUint(_755))));
    _15._m0[uint(38)] = floatBitsToUint(_467);
    _15._m0[uint(39)] = floatBitsToUint(_469);
    _471 = _507;
    _473 = _511;
    _475 = false;
    if (_475)
    {
        float _777 = _471;
        float _778 = float(1);
        _471 = _777 + _778;
        float _780 = _473;
        float _781 = float(1);
        _473 = _780 + _781;
        _478 = _208(_777, _780);
    }
    else
    {
        float _784 = _471;
        float _785 = float(1);
        _471 = _784 + _785;
        float _787 = _473;
        float _788 = float(1);
        _473 = _787 + _788;
        _478 = uintBitsToFloat(_21(floatBitsToUint(_784), floatBitsToUint(_787)));
    }
    _15._m0[uint(40)] = floatBitsToUint(_478);
    _15._m0[uint(41)] = floatBitsToUint(_471);
    _15._m0[uint(42)] = floatBitsToUint(_473);
    _480 = false;
    if (false)
    {
        float _808 = _471;
        float _809 = float(1);
        _471 = _808 + _809;
        float _811 = _473;
        float _812 = float(1);
        _473 = _811 + _812;
        _480 = _208(_808, _811) != 0.0;
    }
    _15._m0[uint(43)] = uint(_480);
    _15._m0[uint(44)] = floatBitsToUint(_471);
    _482 = true;
    if (!true)
    {
        float _826 = _471;
        float _827 = float(1);
        _471 = _826 + _827;
        float _829 = _473;
        float _830 = float(1);
        _473 = _829 + _830;
        _482 = _208(_826, _829) != 0.0;
    }
    _15._m0[uint(45)] = uint(_482);
    _15._m0[uint(46)] = floatBitsToUint(_473);
    _484 = 6.0;
    _484 = uintBitsToFloat(_21(floatBitsToUint(_484), floatBitsToUint(2.0)));
    _484 = uintBitsToFloat(_21(floatBitsToUint(_484), floatBitsToUint(3.0)));
    _15._m0[uint(47)] = floatBitsToUint(_484);
    _15._m0[uint(48)] = floatBitsToUint(_484);
    _484 = 8.0;
    int _486 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _866)))
        {
            break;
        }
        _866 -= uvec2(uint(_866.y == 0u), 1u);
        if (!(_486 < 2))
        {
            break;
        }
        if (_486 == 0)
        {
            int _890 = _486;
            _486 = _890 + 1;
            continue;
        }
        _484 = uintBitsToFloat(_21(floatBitsToUint(_484), floatBitsToUint(2.0)));
        int _890 = _486;
        _486 = _890 + 1;
        continue;
    }
    _15._m0[uint(49)] = floatBitsToUint(_484);
    _467 = 2.0;
    _469 = 3.0;
    float _896 = _467;
    float _897 = float(1);
    _467 = _896 + _897;
    float _899 = _469;
    float _900 = float(1);
    _469 = _899 + _900;
    _488 = uintBitsToFloat(_21(floatBitsToUint(_896), floatBitsToUint(_899)));
    _15._m0[uint(50)] = floatBitsToUint(_488);
    _15._m0[uint(51)] = floatBitsToUint(_467);
    _15._m0[uint(52)] = floatBitsToUint(_469);
    _15._m0[uint(53)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_507), floatBitsToUint(_511)))), floatBitsToUint(3.0))));
    _15._m0[uint(54)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(24.0), floatBitsToUint(_511)))), floatBitsToUint(2.0))));
    _15._m0[uint(55)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(24.0), floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_511), floatBitsToUint(2.0)))))));
    _15._m0[uint(56)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_507), floatBitsToUint(float(true)))));
    float _959 = float(4294967295u);
    _15._m0[uint(57)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_959), floatBitsToUint(_511))));
    _15._m0[uint(58)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_507), floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])))));
    _15._m0[uint(59)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])), floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])))));
    _15._m0[uint(60)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_12._m0[uint(3)])), floatBitsToUint(uintBitsToFloat(_12._m0[uint(3)])))));
}

