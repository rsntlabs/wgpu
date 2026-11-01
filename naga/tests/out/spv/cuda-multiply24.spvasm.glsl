#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

int _16(float _14, float _15)
{
    uint _29 = min(0u, 32u);
    uint _34 = min(0u, 32u);
    return int(uint(bitfieldExtract(int(clamp(_14, -2147483648.0, 2147483520.0)), int(_29), int(min(24u, (32u - _29))))) * uint(bitfieldExtract(int(clamp(_15, -2147483648.0, 2147483520.0)), int(_34), int(min(24u, (32u - _34))))));
}

uint _43(float _41, float _42)
{
    uint _53 = min(0u, 32u);
    uint _57 = min(0u, 32u);
    return bitfieldExtract(uint(clamp(_41, 0.0, 4294967040.0)), int(_53), int(min(24u, (32u - _53)))) * bitfieldExtract(uint(clamp(_42, 0.0, 4294967040.0)), int(_57), int(min(24u, (32u - _57))));
}

int _64(bool _62, bool _63)
{
    int _69 = 0;
    int _72 = 0;
    if (_62)
    {
        if (_63)
        {
            _69 = 71;
        }
        else
        {
            _69 = 73;
        }
        _72 = _69;
    }
    else
    {
        _72 = 79;
    }
    return _72;
}

int _86(float _84, float _85)
{
    return int(clamp((_84 * 10.0) + _85, -2147483648.0, 2147483520.0));
}

uint _96(int _94, int _95)
{
    return uint((_94 + _95) + 100);
}

int _106(int _104, int _105)
{
    uint _110 = min(0u, 32u);
    uint _115 = min(0u, 32u);
    return int(uint(bitfieldExtract(_104, int(_110), int(min(24u, (32u - _110))))) * uint(bitfieldExtract(_105, int(_115), int(min(24u, (32u - _115))))));
}

void main()
{
    int _195[2] = int[](0, 0);
    int _188[2] = int[](0, 0);
    int _181 = 0;
    uint _203 = 0u;
    int _197 = 0;
    int _191 = 0;
    uint _183 = 0u;
    uint _205 = 0u;
    int _199 = 0;
    int _193 = 0;
    int _186 = 0;
    uvec2 _571 = uvec2(4294967295u);
    uint _209 = min(0u, 32u);
    uint _214 = min(0u, 32u);
    _10._m0[uint(0)] = uint(int(uint(bitfieldExtract(8388608, int(_209), int(min(24u, (32u - _209))))) * uint(bitfieldExtract(1, int(_214), int(min(24u, (32u - _214)))))));
    uint _225 = min(0u, 32u);
    uint _229 = min(0u, 32u);
    _10._m0[uint(1)] = bitfieldExtract(16777215u, int(_225), int(min(24u, (32u - _225)))) * bitfieldExtract(16777215u, int(_229), int(min(24u, (32u - _229))));
    uint _236 = min(0u, 32u);
    uint _241 = min(0u, 32u);
    _10._m0[uint(2)] = uint(int(uint(bitfieldExtract(8388607, int(_236), int(min(24u, (32u - _236))))) * uint(bitfieldExtract(8388607, int(_241), int(min(24u, (32u - _241)))))));
    uint _251 = min(0u, 32u);
    uint _255 = min(0u, 32u);
    _10._m0[uint(3)] = bitfieldExtract(16777216u, int(_251), int(min(24u, (32u - _251)))) * bitfieldExtract(13u, int(_255), int(min(24u, (32u - _255))));
    float _261 = -2.75;
    _10._m0[uint(4)] = uint(_16(3.75, _261));
    float _266 = -3.75;
    _10._m0[uint(5)] = uint(_16(_266, 2.75));
    _10._m0[uint(6)] = _43(3.75, 2.75);
    _10._m0[uint(7)] = _43(16777215.0, 1.0);
    _10._m0[uint(8)] = uint(_64(true, true));
    _10._m0[uint(9)] = uint(_64(false, true));
    uint _287 = min(0u, 32u);
    uint _292 = min(0u, 32u);
    _10._m0[uint(10)] = uint(int(uint(bitfieldExtract(3, int(_287), int(min(24u, (32u - _287))))) * uint(bitfieldExtract(int(true), int(_292), int(min(24u, (32u - _292)))))));
    uint _303 = min(0u, 32u);
    uint _308 = min(0u, 32u);
    _10._m0[uint(11)] = uint(int(uint(bitfieldExtract(int(true), int(_303), int(min(24u, (32u - _303))))) * uint(bitfieldExtract(3, int(_308), int(min(24u, (32u - _308)))))));
    _10._m0[uint(12)] = uint(_86(3.75, 2.0));
    _10._m0[uint(13)] = _96(3, 4);
    uint _325 = min(0u, 32u);
    uint _329 = min(0u, 32u);
    _10._m0[uint(14)] = bitfieldExtract(3u, int(_325), int(min(24u, (32u - _325)))) * bitfieldExtract(4u, int(_329), int(min(24u, (32u - _329))));
    _10._m0[uint(15)] = _96(int(true), int(true));
    uint _342 = min(0u, 32u);
    uint _346 = min(0u, 32u);
    _10._m0[uint(16)] = bitfieldExtract(3u, int(_342), int(min(24u, (32u - _342)))) * bitfieldExtract(uint(4), int(_346), int(min(24u, (32u - _346))));
    int _352 = -7;
    _10._m0[uint(17)] = uint(_106(_352, 3));
    uint _358 = min(0u, 32u);
    uint _363 = min(0u, 32u);
    uint _370 = min(0u, 32u);
    uint _375 = min(0u, 32u);
    _10._m0[uint(18)] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_358), int(min(24u, (32u - _358))))) * uint(bitfieldExtract(4, int(_363), int(min(24u, (32u - _363)))))), int(_370), int(min(24u, (32u - _370))))) * uint(bitfieldExtract(5, int(_375), int(min(24u, (32u - _375)))))));
    uint _385 = min(0u, 32u);
    uint _389 = min(0u, 32u);
    uint _394 = min(0u, 32u);
    uint _398 = min(0u, 32u);
    _10._m0[uint(19)] = bitfieldExtract(bitfieldExtract(16777215u, int(_385), int(min(24u, (32u - _385)))) * bitfieldExtract(2u, int(_389), int(min(24u, (32u - _389)))), int(_394), int(min(24u, (32u - _394)))) * bitfieldExtract(2u, int(_398), int(min(24u, (32u - _398))));
    _181 = -3;
    _183 = 5u;
    uint _408 = min(0u, 32u);
    uint _413 = min(0u, 32u);
    _10._m0[uint(20)] = uint(int(uint(bitfieldExtract(_181, int(_408), int(min(24u, (32u - _408))))) * uint(bitfieldExtract(int(_183), int(_413), int(min(24u, (32u - _413)))))));
    uint _426 = min(0u, 32u);
    uint _430 = min(0u, 32u);
    _10._m0[uint(21)] = bitfieldExtract(uint(_181), int(_426), int(min(24u, (32u - _426)))) * bitfieldExtract(_183, int(_430), int(min(24u, (32u - _430))));
    uint _437 = min(0u, 32u);
    uint _442 = min(0u, 32u);
    _10._m0[uint(22)] = uint(int(uint(bitfieldExtract(25165824, int(_437), int(min(24u, (32u - _437))))) * uint(bitfieldExtract(16777217, int(_442), int(min(24u, (32u - _442)))))));
    uint _452 = min(0u, 32u);
    uint _456 = min(0u, 32u);
    _10._m0[uint(23)] = bitfieldExtract(4286578688u, int(_452), int(min(24u, (32u - _452)))) * bitfieldExtract(4278190081u, int(_456), int(min(24u, (32u - _456))));
    if (true)
    {
        int _465 = -3;
        uint _467 = min(0u, 32u);
        uint _472 = min(0u, 32u);
        _186 = int(uint(bitfieldExtract(_465, int(_467), int(min(24u, (32u - _467))))) * uint(bitfieldExtract(7, int(_472), int(min(24u, (32u - _472))))));
    }
    else
    {
        uint _479 = min(0u, 32u);
        uint _484 = min(0u, 32u);
        _186 = int(uint(bitfieldExtract(0, int(_479), int(min(24u, (32u - _479))))) * uint(bitfieldExtract(0, int(_484), int(min(24u, (32u - _484))))));
    }
    _10._m0[uint(24)] = uint(_186);
    uint _495 = min(0u, 32u);
    uint _500 = min(0u, 32u);
    _188[0u] = int(uint(bitfieldExtract(2, int(_495), int(min(24u, (32u - _495))))) * uint(bitfieldExtract(3, int(_500), int(min(24u, (32u - _500))))));
    uint _508 = min(0u, 32u);
    uint _513 = min(0u, 32u);
    _188[1u] = int(uint(bitfieldExtract(3, int(_508), int(min(24u, (32u - _508))))) * uint(bitfieldExtract(4, int(_513), int(min(24u, (32u - _513))))));
    _10._m0[uint(25)] = uint(_188[0u] + _188[1u]);
    _191 = 2;
    _195 = int[](0, 0);
    _10._m0[uint(26)] = uint(_191 + _195[0u]);
    _197 = 2;
    int _536 = _197;
    _197 = _536 + 1;
    int _538 = _197;
    _197 = _538 + 1;
    uint _541 = min(0u, 32u);
    uint _546 = min(0u, 32u);
    _10._m0[uint(27)] = uint(int(uint(bitfieldExtract(_536, int(_541), int(min(24u, (32u - _541))))) * uint(bitfieldExtract(_538, int(_546), int(min(24u, (32u - _546)))))));
    _10._m0[uint(28)] = uint(_197);
    _199 = 0;
    int _201 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _571)))
        {
            break;
        }
        _571 -= uvec2(uint(_571.y == 0u), 1u);
        if (!(_201 < 3))
        {
            break;
        }
        uint _589 = min(0u, 32u);
        uint _594 = min(0u, 32u);
        _199 += int(uint(bitfieldExtract(_201 + 1, int(_589), int(min(24u, (32u - _589))))) * uint(bitfieldExtract(2, int(_594), int(min(24u, (32u - _594))))));
        _201++;
        continue;
    }
    _10._m0[uint(29)] = uint(_199);
    float _610 = clamp(9.75, -2147483648.0, 2147483520.0);
    _203 = uint(30);
    _205 = _203;
    _10._m0[_205] = uint(int(_610));
    uint _618 = min(0u, 32u);
    uint _623 = min(0u, 32u);
    _10._m0[uint(31)] = uint(int(uint(bitfieldExtract(16777215, int(_618), int(min(24u, (32u - _618))))) * uint(bitfieldExtract(3, int(_623), int(min(24u, (32u - _623)))))));
}

