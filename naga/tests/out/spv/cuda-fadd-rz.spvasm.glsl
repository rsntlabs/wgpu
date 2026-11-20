#version 460
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    uint _m0[];
} _13;

uint _19(uint _17, uint _18)
{
    uint _38 = _17 & 2147483647u;
    uint _39 = _18 & 2147483647u;
    uint _40 = _17 & 2147483648u;
    uint _41 = _18 & 2147483648u;
    if ((_38 > 2139095040u) || (_39 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _47 = _38 == 2139095040u;
    bool _48 = _39 == 2139095040u;
    if ((_47 && _48) && (_40 != _41))
    {
        return 2143289344u;
    }
    if (_47)
    {
        return _17;
    }
    if (_48)
    {
        return _18;
    }
    bool _59 = _38 >= _39;
    uint _60 = _59 ? _38 : _39;
    uint _61 = _59 ? _39 : _38;
    uint _62 = _59 ? _40 : _41;
    uint _63 = _60 >> 23u;
    uint _64 = _61 >> 23u;
    bool _65 = _63 != 0u;
    bool _66 = _64 != 0u;
    uint _73 = ((_60 & 8388607u) | (_65 ? 8388608u : 0u)) << 3u;
    uint _74 = ((_61 & 8388607u) | (_66 ? 8388608u : 0u)) << 3u;
    uint _75 = _65 ? _63 : 1u;
    uint _77 = _75 - (_66 ? _64 : 1u);
    uint _78 = _77 & 31u;
    uint _89 = (_77 < 32u) ? ((_74 >> _78) | uint((_74 & ((1u << _78) - 1u)) != 0u)) : uint(_74 != 0u);
    uint _92 = (_40 == _41) ? (_73 + _89) : (_73 - _89);
    if (_92 == 0u)
    {
        return _40 & _41;
    }
    bool _97 = _92 >= 134217728u;
    uint _98 = 1u & 31u;
    uint _110 = _97 ? ((1u < 32u) ? ((_92 >> _98) | uint((_92 & ((1u << _98) - 1u)) != 0u)) : uint(_92 != 0u)) : _92;
    uint _112 = _75 + uint(_97);
    uint _117 = min(((31u - uint(findMSB(_110))) - 5u), (_112 - 1u));
    uint _119 = _112 - _117;
    uint _120 = (_110 << _117) >> 3u;
    if (_119 >= 255u)
    {
        return _62 | 2139095039u;
    }
    return _62 | ((((_120 >= 8388608u) ? _119 : 0u) << 23u) | (_120 & 8388607u));
}

float _134(float _132, float _133)
{
    return uintBitsToFloat(_19(floatBitsToUint(_132), floatBitsToUint(_133)));
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

uint _282(uint _280, uint _281)
{
    uint _284 = _280 & 2147483647u;
    uint _285 = _281 & 2147483647u;
    uint _286 = _280 & 2147483648u;
    uint _287 = _281 & 2147483648u;
    if ((_284 > 2139095040u) || (_285 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _293 = _284 == 2139095040u;
    bool _294 = _285 == 2139095040u;
    if ((_293 && _294) && (_286 != _287))
    {
        return 2143289344u;
    }
    if (_293)
    {
        return _280;
    }
    if (_294)
    {
        return _281;
    }
    bool _305 = _284 >= _285;
    uint _306 = _305 ? _284 : _285;
    uint _307 = _305 ? _285 : _284;
    uint _308 = _305 ? _286 : _287;
    uint _309 = _306 >> 23u;
    uint _310 = _307 >> 23u;
    bool _311 = _309 != 0u;
    bool _312 = _310 != 0u;
    uint _319 = ((_306 & 8388607u) | (_311 ? 8388608u : 0u)) << 3u;
    uint _320 = ((_307 & 8388607u) | (_312 ? 8388608u : 0u)) << 3u;
    uint _321 = _311 ? _309 : 1u;
    uint _323 = _321 - (_312 ? _310 : 1u);
    uint _324 = _323 & 31u;
    uint _335 = (_323 < 32u) ? ((_320 >> _324) | uint((_320 & ((1u << _324) - 1u)) != 0u)) : uint(_320 != 0u);
    uint _338 = (_286 == _287) ? (_319 + _335) : (_319 - _335);
    if (_338 == 0u)
    {
        return _286 | _287;
    }
    bool _343 = _338 >= 134217728u;
    uint _344 = 1u & 31u;
    uint _356 = _343 ? ((1u < 32u) ? ((_338 >> _344) | uint((_338 & ((1u << _344) - 1u)) != 0u)) : uint(_338 != 0u)) : _338;
    uint _358 = _321 + uint(_343);
    uint _363 = min(((31u - uint(findMSB(_356))) - 5u), (_358 - 1u));
    uint _364 = _356 << _363;
    bool _366 = _308 != 0u;
    uint _372 = (_364 >> 3u) + uint(_366 && ((_364 & 7u) > 0u));
    bool _373 = _372 >= 16777216u;
    uint _375 = _373 ? (_372 >> 1u) : _372;
    uint _377 = (_358 - _363) + uint(_373);
    if (_377 >= 255u)
    {
        return _308 | (_366 ? 2139095040u : 2139095039u);
    }
    return _308 | ((((_375 >= 8388608u) ? _377 : 0u) << 23u) | (_375 & 8388607u));
}

uint _392(uint _390, uint _391)
{
    uint _394 = _390 & 2147483647u;
    uint _395 = _391 & 2147483647u;
    uint _396 = _390 & 2147483648u;
    uint _397 = _391 & 2147483648u;
    if ((_394 > 2139095040u) || (_395 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _403 = _394 == 2139095040u;
    bool _404 = _395 == 2139095040u;
    if ((_403 && _404) && (_396 != _397))
    {
        return 2143289344u;
    }
    if (_403)
    {
        return _390;
    }
    if (_404)
    {
        return _391;
    }
    bool _415 = _394 >= _395;
    uint _416 = _415 ? _394 : _395;
    uint _417 = _415 ? _395 : _394;
    uint _418 = _415 ? _396 : _397;
    uint _419 = _416 >> 23u;
    uint _420 = _417 >> 23u;
    bool _421 = _419 != 0u;
    bool _422 = _420 != 0u;
    uint _429 = ((_416 & 8388607u) | (_421 ? 8388608u : 0u)) << 3u;
    uint _430 = ((_417 & 8388607u) | (_422 ? 8388608u : 0u)) << 3u;
    uint _431 = _421 ? _419 : 1u;
    uint _433 = _431 - (_422 ? _420 : 1u);
    uint _434 = _433 & 31u;
    uint _445 = (_433 < 32u) ? ((_430 >> _434) | uint((_430 & ((1u << _434) - 1u)) != 0u)) : uint(_430 != 0u);
    uint _448 = (_396 == _397) ? (_429 + _445) : (_429 - _445);
    if (_448 == 0u)
    {
        return _396 & _397;
    }
    bool _453 = _448 >= 134217728u;
    uint _454 = 1u & 31u;
    uint _466 = _453 ? ((1u < 32u) ? ((_448 >> _454) | uint((_448 & ((1u << _454) - 1u)) != 0u)) : uint(_448 != 0u)) : _448;
    uint _468 = _431 + uint(_453);
    uint _473 = min(((31u - uint(findMSB(_466))) - 5u), (_468 - 1u));
    uint _474 = _466 << _473;
    bool _476 = _418 == 0u;
    uint _482 = (_474 >> 3u) + uint(_476 && ((_474 & 7u) > 0u));
    bool _483 = _482 >= 16777216u;
    uint _485 = _483 ? (_482 >> 1u) : _482;
    uint _487 = (_468 - _473) + uint(_483);
    if (_487 >= 255u)
    {
        return _418 | (_476 ? 2139095040u : 2139095039u);
    }
    return _418 | ((((_485 >= 8388608u) ? _487 : 0u) << 23u) | (_485 & 8388607u));
}

void main()
{
    uint _665 = 0u;
    uint _653 = 0u;
    uint _641 = 0u;
    uint _629 = 0u;
    vec2 _617 = vec2(0.0);
    uint _604 = 0u;
    uint _592 = 0u;
    uint _580 = 0u;
    uint _567 = 0u;
    uint _554 = 0u;
    vec2 _679 = vec2(0.0);
    uint _541 = 0u;
    uint _667 = 0u;
    uint _655 = 0u;
    uint _643 = 0u;
    uint _631 = 0u;
    uint _619 = 0u;
    uint _606 = 0u;
    uint _594 = 0u;
    uint _582 = 0u;
    uint _569 = 0u;
    bool _556 = false;
    vec2 _681 = vec2(0.0);
    uint _544 = 0u;
    vec2 _669 = vec2(0.0);
    vec2 _657 = vec2(0.0);
    vec2 _645 = vec2(0.0);
    vec2 _633 = vec2(0.0);
    vec2 _621 = vec2(0.0);
    uint _608 = 0u;
    uint _596 = 0u;
    uint _584 = 0u;
    uint _571 = 0u;
    bool _559 = false;
    vec2 _683 = vec2(0.0);
    uint _546 = 0u;
    vec2 _671 = vec2(0.0);
    vec2 _659 = vec2(0.0);
    vec2 _647 = vec2(0.0);
    vec2 _635 = vec2(0.0);
    vec2 _623 = vec2(0.0);
    uint _610 = 0u;
    uint _598 = 0u;
    uint _586 = 0u;
    float _573 = 0.0;
    uint _561 = 0u;
    int _548 = 0;
    vec2 _673 = vec2(0.0);
    vec2 _661 = vec2(0.0);
    vec2 _649 = vec2(0.0);
    vec2 _637 = vec2(0.0);
    vec2 _625 = vec2(0.0);
    vec2 _612 = vec2(0.0);
    uint _600 = 0u;
    uint _588 = 0u;
    uint _576 = 0u;
    uint _563 = 0u;
    uint _550 = 0u;
    vec2 _675 = vec2(0.0);
    uint _663 = 0u;
    uint _651 = 0u;
    uint _639 = 0u;
    uint _627 = 0u;
    uint _615 = 0u;
    uint _602 = 0u;
    uint _590 = 0u;
    int _578 = 0;
    uint _565 = 0u;
    uint _552 = 0u;
    vec2 _677 = vec2(0.0);
    uint _689 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_689 >= 4096u)
    {
        return;
    }
    uint _694 = 4u + (_689 * 30u);
    _541 = _689 * 2u;
    uint _699 = _10._m0[_541];
    float _700 = uintBitsToFloat(_699);
    _544 = (_689 * 2u) + 1u;
    uint _705 = _10._m0[_544];
    float _706 = uintBitsToFloat(_705);
    _13._m0[_694] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_700), floatBitsToUint(_706))));
    _546 = _694 + 1u;
    _13._m0[_546] = floatBitsToUint(_134(_700, _706));
    _548 = 0;
    int _719 = _548;
    _548 = _719 + 1;
    _552 = (_689 * 2u) + uint(_719);
    int _728 = _548;
    _548 = _728 + 1;
    _554 = (_689 * 2u) + uint(_728);
    _550 = _694 + 2u;
    _13._m0[_550] = floatBitsToUint(_134(uintBitsToFloat(_10._m0[_552]), uintBitsToFloat(_10._m0[_554])));
    _556 = false;
    if (false)
    {
        int _743 = _548;
        _548 = _743 + 1;
        _556 = _158(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(float(_743)), floatBitsToUint(_700))))) != 0u;
    }
    _559 = true;
    if (!true)
    {
        int _755 = _548;
        _548 = _755 + 1;
        _559 = _158(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_700), floatBitsToUint(float(_755)))))) != 0u;
    }
    _561 = _694 + 3u;
    _13._m0[_561] = uint(_548);
    float _770 = -0.0;
    float _771 = -0.0;
    _563 = _694 + 4u;
    _13._m0[_563] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_770), floatBitsToUint(_771))));
    float _780 = -0.0;
    _565 = _694 + 5u;
    _13._m0[_565] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_780), floatBitsToUint(0.0))));
    float _789 = float(1);
    float _790 = float(2u);
    _567 = _694 + 6u;
    _13._m0[_567] = floatBitsToUint(_134(_789, _790));
    _569 = _694 + 7u;
    _13._m0[_569] = uint(_144(true, false));
    if (true)
    {
        _573 = uintBitsToFloat(_19(floatBitsToUint(_700), floatBitsToUint(_706)));
    }
    else
    {
        int _808 = _548;
        _548 = _808 + 1;
        _573 = uintBitsToFloat(_19(floatBitsToUint(float(_808)), floatBitsToUint(_700)));
    }
    _571 = _694 + 8u;
    _13._m0[_571] = floatBitsToUint(_573);
    _576 = _694 + 9u;
    _13._m0[_576] = floatBitsToUint(uintBitsToFloat(_167(floatBitsToUint(_700), floatBitsToUint(_706))));
    _578 = 0;
    int _829 = _578;
    _578 = _829 + 1;
    _582 = (_689 * 2u) + uint(_829);
    int _838 = _578;
    _578 = _838 + 1;
    _584 = (_689 * 2u) + uint(_838);
    _580 = _694 + 10u;
    _13._m0[_580] = floatBitsToUint(uintBitsToFloat(_282(floatBitsToUint(uintBitsToFloat(_10._m0[_582])), floatBitsToUint(uintBitsToFloat(_10._m0[_584])))));
    _586 = _694 + 11u;
    _13._m0[_586] = uint(_578);
    _578 = 0;
    int _860 = _578;
    _578 = _860 + 1;
    _590 = (_689 * 2u) + uint(_860);
    int _869 = _578;
    _578 = _869 + 1;
    _592 = (_689 * 2u) + uint(_869);
    _588 = _694 + 12u;
    _13._m0[_588] = floatBitsToUint(uintBitsToFloat(_392(floatBitsToUint(uintBitsToFloat(_10._m0[_590])), floatBitsToUint(uintBitsToFloat(_10._m0[_592])))));
    _594 = _694 + 13u;
    _13._m0[_594] = uint(_578);
    _578 = 0;
    int _891 = _578;
    _578 = _891 + 1;
    _598 = (_689 * 2u) + uint(_891);
    int _900 = _578;
    _578 = _900 + 1;
    _600 = (_689 * 2u) + uint(_900);
    _596 = _694 + 14u;
    _13._m0[_596] = floatBitsToUint(uintBitsToFloat(_282(floatBitsToUint(uintBitsToFloat(_10._m0[_598])), floatBitsToUint(uintBitsToFloat(_10._m0[_600])) ^ 2147483648u)));
    _602 = _694 + 15u;
    _13._m0[_602] = uint(_578);
    _578 = 0;
    int _923 = _578;
    _578 = _923 + 1;
    _606 = (_689 * 2u) + uint(_923);
    int _932 = _578;
    _578 = _932 + 1;
    _608 = (_689 * 2u) + uint(_932);
    _604 = _694 + 16u;
    _13._m0[_604] = floatBitsToUint(uintBitsToFloat(_392(floatBitsToUint(uintBitsToFloat(_10._m0[_606])), floatBitsToUint(uintBitsToFloat(_10._m0[_608])) ^ 2147483648u)));
    _610 = _694 + 17u;
    _13._m0[_610] = uint(_578);
    uint _954 = _689 ^ 1u;
    _615 = _954 * 2u;
    _612 = vec2(_700, uintBitsToFloat(_10._m0[_615]));
    _619 = (_954 * 2u) + 1u;
    _617 = vec2(_706, uintBitsToFloat(_10._m0[_619]));
    _578 = 0;
    _669 = vec2(0.0);
    _669 = _612;
    _578++;
    _623 = _669;
    _671 = vec2(0.0);
    _671 = _617;
    _578++;
    _625 = _671;
    _621 = vec2(uintBitsToFloat(_167(floatBitsToUint(_623.x), floatBitsToUint(_625.x))), uintBitsToFloat(_167(floatBitsToUint(_623.y), floatBitsToUint(_625.y))));
    _627 = _694 + 18u;
    _13._m0[_627] = floatBitsToUint(_621.x);
    _629 = _694 + 19u;
    _13._m0[_629] = floatBitsToUint(_621.y);
    _631 = _694 + 20u;
    _13._m0[_631] = uint(_578);
    _578 = 0;
    _673 = vec2(0.0);
    _673 = _612;
    _578++;
    _635 = _673;
    _675 = vec2(0.0);
    _675 = _617;
    _578++;
    _637 = _675;
    _633 = vec2(uintBitsToFloat(_19(floatBitsToUint(_635.x), floatBitsToUint(_637.x))), uintBitsToFloat(_19(floatBitsToUint(_635.y), floatBitsToUint(_637.y))));
    _639 = _694 + 21u;
    _13._m0[_639] = floatBitsToUint(_633.x);
    _641 = _694 + 22u;
    _13._m0[_641] = floatBitsToUint(_633.y);
    _643 = _694 + 23u;
    _13._m0[_643] = uint(_578);
    _578 = 0;
    _677 = vec2(0.0);
    _677 = _612;
    _578++;
    _647 = _677;
    _679 = vec2(0.0);
    _679 = _617;
    _578++;
    _649 = _679;
    _645 = vec2(uintBitsToFloat(_282(floatBitsToUint(_647.x), floatBitsToUint(_649.x))), uintBitsToFloat(_282(floatBitsToUint(_647.y), floatBitsToUint(_649.y))));
    _651 = _694 + 24u;
    _13._m0[_651] = floatBitsToUint(_645.x);
    _653 = _694 + 25u;
    _13._m0[_653] = floatBitsToUint(_645.y);
    _655 = _694 + 26u;
    _13._m0[_655] = uint(_578);
    _578 = 0;
    _681 = vec2(0.0);
    _681 = _612;
    _578++;
    _659 = _681;
    _683 = vec2(0.0);
    _683 = _617;
    _578++;
    _661 = _683;
    _657 = vec2(uintBitsToFloat(_392(floatBitsToUint(_659.x), floatBitsToUint(_661.x))), uintBitsToFloat(_392(floatBitsToUint(_659.y), floatBitsToUint(_661.y))));
    _663 = _694 + 27u;
    _13._m0[_663] = floatBitsToUint(_657.x);
    _665 = _694 + 28u;
    _13._m0[_665] = floatBitsToUint(_657.y);
    _667 = _694 + 29u;
    _13._m0[_667] = uint(_578);
}

