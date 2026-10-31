#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _42 = 0u;
    uint _36 = 0u;
    uint _40 = 0u;
    uint _33 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    uvec2 _91 = uvec2(4294967295u);
    uint _49 = _12 & 2147483647u;
    if ((_49 == 0u) || (_12 == 2139095040u))
    {
        return _12;
    }
    if (((_12 & 2147483648u) != 0u) || (_49 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _61 = _12 & 8388607u;
    uint _62 = _49 >> 23u;
    _33 = _61 | 8388608u;
    _36 = _62 + 127u;
    if (_62 == 0u)
    {
        uint _71 = (31u - uint(findMSB(_61))) - 8u;
        _33 = _61 << _71;
        _36 = 128u - _71;
    }
    uint _76 = _36 & 1u;
    _38 = _33 >> (9u - _76);
    _40 = _33 << (23u + _76);
    _42 = 0u;
    _44 = 0u;
    uint _46 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _91)))
        {
            break;
        }
        _91 -= uvec2(uint(_91.y == 0u), 1u);
        if (_46 >= 24u)
        {
            break;
        }
        uint _106 = _38;
        uint _109 = _44;
        uint _117 = (_109 << 2u) | (_106 >> 14u);
        uint _119 = (_42 << 2u) | 1u;
        bool _120 = _117 >= _119;
        uint _123 = _42 << 1u;
        _38 = ((_106 << 2u) | (_40 >> 30u)) & 65535u;
        _40 = _40 << 2u;
        _44 = _120 ? (_117 - _119) : _117;
        _42 = _120 ? (_123 | 1u) : _123;
        _46++;
        continue;
    }
    return ((_36 >> 1u) << 23u) | (((_44 > _42) ? (_42 + 1u) : _42) & 8388607u);
}

float _147(int _146)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_146))));
}

float _156(uint _155)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_155))));
}

float _139(float _138)
{
    return uintBitsToFloat(_13(floatBitsToUint(_138)));
}

int _176(bool _175)
{
    int _180 = 0;
    if (_175)
    {
        _180 = 7;
    }
    else
    {
        _180 = 9;
    }
    return _180;
}

float _191(float _189, float _190)
{
    return _189 + _190;
}

float _165(bool _164)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_164))));
}

void main()
{
    uint _322 = 0u;
    uint _316 = 0u;
    uint _310 = 0u;
    uint _304 = 0u;
    uint _298 = 0u;
    uint _292 = 0u;
    uint _286 = 0u;
    uint _279 = 0u;
    uint _273 = 0u;
    uint _267 = 0u;
    uint _261 = 0u;
    uint _255 = 0u;
    uint _249 = 0u;
    uint _243 = 0u;
    uint _324 = 0u;
    uint _318 = 0u;
    uint _312 = 0u;
    uint _306 = 0u;
    uint _300 = 0u;
    uint _294 = 0u;
    uint _288 = 0u;
    uint _281 = 0u;
    uint _275 = 0u;
    uint _269 = 0u;
    uint _263 = 0u;
    uint _257 = 0u;
    uint _251 = 0u;
    uint _245 = 0u;
    uint _320 = 0u;
    uint _314 = 0u;
    uint _308 = 0u;
    uint _302 = 0u;
    uint _296 = 0u;
    uint _290 = 0u;
    float _283 = 0.0;
    uint _277 = 0u;
    uint _271 = 0u;
    uint _265 = 0u;
    uint _259 = 0u;
    uint _253 = 0u;
    uint _247 = 0u;
    _243 = uint(0);
    _8._m0[_243] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _335 = -0.0;
    _245 = uint(1);
    _8._m0[_245] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_335))));
    _247 = uint(2);
    _8._m0[_247] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.0))));
    _249 = uint(3);
    _8._m0[_249] = floatBitsToUint(_147(4));
    _251 = uint(4);
    _8._m0[_251] = floatBitsToUint(_156(9u));
    _253 = uint(5);
    _8._m0[_253] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(6.25))));
    _255 = uint(6);
    _8._m0[_255] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0))));
    _259 = 1u;
    _257 = uint(7);
    _8._m0[_257] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_259)))));
    _263 = 8388607u;
    _261 = uint(8);
    _8._m0[_261] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_263)))));
    _267 = 8388608u;
    _265 = uint(9);
    _8._m0[_265] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_267)))));
    _271 = 2139095039u;
    _269 = uint(10);
    _8._m0[_269] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_271)))));
    _275 = 2139095040u;
    _273 = uint(11);
    _8._m0[_273] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_275)))));
    float _419 = -1.0;
    _277 = uint(12);
    _8._m0[_277] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_419))));
    _281 = 2139095041u;
    _279 = uint(13);
    _8._m0[_279] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_281)))));
    _283 = 4.0;
    float _436 = _283;
    float _437 = float(1);
    _283 = _436 + _437;
    _286 = uint(14);
    _8._m0[_286] = floatBitsToUint(_139(_436));
    _288 = uint(15);
    _8._m0[_288] = floatBitsToUint(_283);
    _290 = uint(16);
    _8._m0[_290] = uint(_176(true));
    _292 = uint(17);
    _8._m0[_292] = uint(_176(false));
    _294 = uint(18);
    _8._m0[_294] = floatBitsToUint(_191(2.0, 3.0));
    _298 = 1065353217u;
    _296 = uint(19);
    _8._m0[_296] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_298)))));
    _302 = 1065353218u;
    _300 = uint(20);
    _8._m0[_300] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_302)))));
    _306 = 1065353215u;
    _304 = uint(21);
    _8._m0[_304] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_306)))));
    _308 = uint(22);
    _8._m0[_308] = floatBitsToUint(_156(4294967295u));
    int _496 = -4;
    _310 = uint(23);
    _8._m0[_310] = floatBitsToUint(_147(_496));
    _312 = uint(24);
    _8._m0[_312] = floatBitsToUint(_139(16.0));
    _314 = uint(25);
    _8._m0[_314] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.25))));
    _318 = 2147483649u;
    _316 = uint(26);
    _8._m0[_316] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_318)))));
    _320 = uint(27);
    _8._m0[_320] = floatBitsToUint(_165(false));
    _322 = uint(28);
    _8._m0[_322] = floatBitsToUint(_165(true));
    _324 = uint(29);
    _8._m0[_324] = floatBitsToUint(_139(0.5));
}

