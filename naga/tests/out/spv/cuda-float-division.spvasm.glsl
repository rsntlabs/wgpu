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

int _351(int _353, int _354)
{
    return _353 / (((_354 == 0) || ((_353 == int(0x80000000)) && (_354 == (-1)))) ? 1 : _354);
}

uint _365(uint _366, uint _367)
{
    return _366 / ((_367 == 0u) ? 1u : _367);
}

float _330(_7 _328, _7 _329)
{
    _7 _332 = _7(0.0);
    _7 _335 = _7(0.0);
    _332 = _328;
    _335 = _329;
    return _332._m0 + _335._m0;
}

uint _345(uint _344)
{
    uint _348 = _344 & 2147483647u;
    return (_348 > 2139095040u) ? 2143289344u : _348;
}

void main()
{
    float _506 = 0.0;
    vec4 _500 = vec4(0.0);
    bool _488 = false;
    float _481 = 0.0;
    float _475 = 0.0;
    _7 _469 = _7(0.0);
    float _463 = 0.0;
    float _456 = 0.0;
    vec4 _450 = vec4(0.0);
    _7 _508 = _7(0.0);
    float _502 = 0.0;
    float _496 = 0.0;
    bool _490 = false;
    bool _483 = false;
    float _477 = 0.0;
    _7 _471 = _7(0.0);
    _7 _465 = _7(0.0);
    float _458[2] = float[](0.0, 0.0);
    vec4 _452 = vec4(0.0);
    vec4 _504 = vec4(0.0);
    vec4 _498 = vec4(0.0);
    float _492 = 0.0;
    float _486 = 0.0;
    float _479 = 0.0;
    float _473 = 0.0;
    _7 _467 = _7(0.0);
    uint _461 = 0u;
    vec4 _454 = vec4(0.0);
    uvec2 _878 = uvec2(4294967295u);
    uint _514 = _12._m0[uint(0)];
    float _515 = uintBitsToFloat(_514);
    uint _518 = _12._m0[uint(1)];
    float _519 = uintBitsToFloat(_518);
    _15._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_515), floatBitsToUint(_519))));
    _15._m0[uint(1)] = floatBitsToUint(_208(_515, _519));
    float _531 = float(3);
    _15._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_515), floatBitsToUint(_531))));
    float _539 = float(3);
    _15._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_539), floatBitsToUint(_515))));
    float _547 = -0.0;
    _450 = vec4(_515, 1.0, _547, uintBitsToFloat(_12._m0[uint(3)]));
    _452 = vec4(_519, 3.0, 3.0, 2.0);
    _454 = _218(_450, _452);
    _15._m0[uint(4)] = floatBitsToUint(_454.x);
    _15._m0[uint(5)] = floatBitsToUint(_454.y);
    _15._m0[uint(6)] = floatBitsToUint(_454.z);
    _15._m0[uint(7)] = floatBitsToUint(_454.w);
    _454 = _264(_450, 3.0);
    _15._m0[uint(8)] = floatBitsToUint(_454.x);
    _15._m0[uint(9)] = floatBitsToUint(_454.y);
    _15._m0[uint(10)] = floatBitsToUint(_454.z);
    _15._m0[uint(11)] = floatBitsToUint(_454.w);
    _454 = _297(3.0, _452);
    _15._m0[uint(12)] = floatBitsToUint(_454.x);
    _15._m0[uint(13)] = floatBitsToUint(_454.y);
    _15._m0[uint(14)] = floatBitsToUint(_454.z);
    _15._m0[uint(15)] = floatBitsToUint(_454.w);
    _454 = _450;
    _498 = vec4(0.0);
    _498 = _452;
    _500 = _454;
    _454 = _218(_500, _498);
    _15._m0[uint(16)] = floatBitsToUint(_454.x);
    _15._m0[uint(17)] = floatBitsToUint(_454.y);
    _15._m0[uint(18)] = floatBitsToUint(_454.z);
    _15._m0[uint(19)] = floatBitsToUint(_454.w);
    _454 = _450;
    _502 = 0.0;
    _502 = 3.0;
    _504 = _454;
    _454 = _264(_504, _502);
    _15._m0[uint(20)] = floatBitsToUint(_454.x);
    _15._m0[uint(21)] = floatBitsToUint(_454.y);
    _15._m0[uint(22)] = floatBitsToUint(_454.z);
    _15._m0[uint(23)] = floatBitsToUint(_454.w);
    _456 = _515;
    _456 = uintBitsToFloat(_21(floatBitsToUint(_456), floatBitsToUint(_519)));
    _15._m0[uint(24)] = floatBitsToUint(_456);
    _15._m0[uint(25)] = floatBitsToUint(_456);
    _458[0u] = _515;
    _458[1u] = 7.0;
    _461 = 0u;
    _463 = _519;
    float _687 = _463;
    float _688 = float(1);
    _463 = _687 + _688;
    uint _690 = _461;
    _461 = _690 + uint(1);
    _458[_690] = uintBitsToFloat(_21(floatBitsToUint(_458[_690]), floatBitsToUint(_687)));
    _15._m0[uint(26)] = floatBitsToUint(_458[_690]);
    _15._m0[uint(27)] = floatBitsToUint(_458[0u]);
    _15._m0[uint(28)] = _461;
    _15._m0[uint(29)] = floatBitsToUint(_463);
    _15._m0[uint(30)] = floatBitsToUint(_458[1u]);
    int _722 = -7;
    _15._m0[uint(31)] = uint(_351(_722, 3));
    _15._m0[uint(32)] = _365(4294967295u, 3u);
    _465._m0 = 2.0;
    _467._m0 = 3.0;
    _15._m0[uint(33)] = floatBitsToUint(_330(_465, _467));
    _506 = 0.0;
    _506 = 3.0;
    _465._m0 += _506;
    _508 = _465;
    _471 = _508;
    _469 = _471;
    _15._m0[uint(34)] = floatBitsToUint(_469._m0);
    _15._m0[uint(35)] = floatBitsToUint(_465._m0);
    _473 = 0.3333333432674407958984375;
    _15._m0[uint(36)] = floatBitsToUint(_473);
    _475 = 2.0;
    _477 = 3.0;
    float _760 = _475;
    float _761 = float(1);
    _475 = _760 + _761;
    float _763 = _477;
    float _764 = float(1);
    _477 = _763 + _764;
    _15._m0[uint(37)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_760), floatBitsToUint(_763))));
    _15._m0[uint(38)] = floatBitsToUint(_475);
    _15._m0[uint(39)] = floatBitsToUint(_477);
    _479 = _515;
    _481 = _519;
    _483 = false;
    if (_483)
    {
        float _785 = _479;
        float _786 = float(1);
        _479 = _785 + _786;
        float _788 = _481;
        float _789 = float(1);
        _481 = _788 + _789;
        _486 = _208(_785, _788);
    }
    else
    {
        float _792 = _479;
        float _793 = float(1);
        _479 = _792 + _793;
        float _795 = _481;
        float _796 = float(1);
        _481 = _795 + _796;
        _486 = uintBitsToFloat(_21(floatBitsToUint(_792), floatBitsToUint(_795)));
    }
    _15._m0[uint(40)] = floatBitsToUint(_486);
    _15._m0[uint(41)] = floatBitsToUint(_479);
    _15._m0[uint(42)] = floatBitsToUint(_481);
    _488 = false;
    if (false)
    {
        float _816 = _479;
        float _817 = float(1);
        _479 = _816 + _817;
        float _819 = _481;
        float _820 = float(1);
        _481 = _819 + _820;
        _488 = _345(floatBitsToUint(_208(_816, _819))) != 0u;
    }
    _15._m0[uint(43)] = uint(_488);
    _15._m0[uint(44)] = floatBitsToUint(_479);
    _490 = true;
    if (!true)
    {
        float _836 = _479;
        float _837 = float(1);
        _479 = _836 + _837;
        float _839 = _481;
        float _840 = float(1);
        _481 = _839 + _840;
        _490 = _345(floatBitsToUint(_208(_836, _839))) != 0u;
    }
    _15._m0[uint(45)] = uint(_490);
    _15._m0[uint(46)] = floatBitsToUint(_481);
    _492 = 6.0;
    _492 = uintBitsToFloat(_21(floatBitsToUint(_492), floatBitsToUint(2.0)));
    _492 = uintBitsToFloat(_21(floatBitsToUint(_492), floatBitsToUint(3.0)));
    _15._m0[uint(47)] = floatBitsToUint(_492);
    _15._m0[uint(48)] = floatBitsToUint(_492);
    _492 = 8.0;
    int _494 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _878)))
        {
            break;
        }
        _878 -= uvec2(uint(_878.y == 0u), 1u);
        if (!(_494 < 2))
        {
            break;
        }
        if (_494 == 0)
        {
            int _902 = _494;
            _494 = _902 + 1;
            continue;
        }
        _492 = uintBitsToFloat(_21(floatBitsToUint(_492), floatBitsToUint(2.0)));
        int _902 = _494;
        _494 = _902 + 1;
        continue;
    }
    _15._m0[uint(49)] = floatBitsToUint(_492);
    _475 = 2.0;
    _477 = 3.0;
    float _908 = _475;
    float _909 = float(1);
    _475 = _908 + _909;
    float _911 = _477;
    float _912 = float(1);
    _477 = _911 + _912;
    _496 = uintBitsToFloat(_21(floatBitsToUint(_908), floatBitsToUint(_911)));
    _15._m0[uint(50)] = floatBitsToUint(_496);
    _15._m0[uint(51)] = floatBitsToUint(_475);
    _15._m0[uint(52)] = floatBitsToUint(_477);
    _15._m0[uint(53)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_515), floatBitsToUint(_519)))), floatBitsToUint(3.0))));
    _15._m0[uint(54)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(24.0), floatBitsToUint(_519)))), floatBitsToUint(2.0))));
    _15._m0[uint(55)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(24.0), floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_519), floatBitsToUint(2.0)))))));
    _15._m0[uint(56)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_515), floatBitsToUint(float(true)))));
    float _971 = float(4294967295u);
    _15._m0[uint(57)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_971), floatBitsToUint(_519))));
    _15._m0[uint(58)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(_515), floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])))));
    _15._m0[uint(59)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])), floatBitsToUint(uintBitsToFloat(_12._m0[uint(2)])))));
    _15._m0[uint(60)] = floatBitsToUint(uintBitsToFloat(_21(floatBitsToUint(uintBitsToFloat(_12._m0[uint(3)])), floatBitsToUint(uintBitsToFloat(_12._m0[uint(3)])))));
}

