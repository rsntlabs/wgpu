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
    uint _267 = 0u;
    uint _261 = 0u;
    uint _255 = 0u;
    uint _249 = 0u;
    int _243 = 0;
    int _236 = 0;
    uint _230 = 0u;
    uint _224 = 0u;
    uint _218 = 0u;
    uint _212 = 0u;
    uint _206 = 0u;
    uint _200 = 0u;
    uint _194 = 0u;
    uint _188 = 0u;
    uint _181 = 0u;
    uint _263 = 0u;
    int _257 = 0;
    int _251 = 0;
    int _245 = 0;
    int _238[2] = int[](0, 0);
    uint _232 = 0u;
    uint _226 = 0u;
    uint _220 = 0u;
    uint _214 = 0u;
    uint _208 = 0u;
    uint _202 = 0u;
    uint _196 = 0u;
    uint _190 = 0u;
    uint _184 = 0u;
    uint _265 = 0u;
    uint _253 = 0u;
    int _247[2] = int[](0, 0);
    uint _241 = 0u;
    uint _234 = 0u;
    uint _228 = 0u;
    int _222 = 0;
    uint _216 = 0u;
    uint _210 = 0u;
    uint _204 = 0u;
    uint _198 = 0u;
    uint _192 = 0u;
    uint _186 = 0u;
    uvec2 _662 = uvec2(4294967295u);
    uint _271 = min(0u, 32u);
    uint _276 = min(0u, 32u);
    _181 = uint(0);
    _10._m0[_181] = uint(int(uint(bitfieldExtract(8388608, int(_271), int(min(24u, (32u - _271))))) * uint(bitfieldExtract(1, int(_276), int(min(24u, (32u - _276)))))));
    uint _288 = min(0u, 32u);
    uint _292 = min(0u, 32u);
    _184 = uint(1);
    _10._m0[_184] = bitfieldExtract(16777215u, int(_288), int(min(24u, (32u - _288)))) * bitfieldExtract(16777215u, int(_292), int(min(24u, (32u - _292))));
    uint _300 = min(0u, 32u);
    uint _305 = min(0u, 32u);
    _186 = uint(2);
    _10._m0[_186] = uint(int(uint(bitfieldExtract(8388607, int(_300), int(min(24u, (32u - _300))))) * uint(bitfieldExtract(8388607, int(_305), int(min(24u, (32u - _305)))))));
    uint _316 = min(0u, 32u);
    uint _320 = min(0u, 32u);
    _188 = uint(3);
    _10._m0[_188] = bitfieldExtract(16777216u, int(_316), int(min(24u, (32u - _316)))) * bitfieldExtract(13u, int(_320), int(min(24u, (32u - _320))));
    float _327 = -2.75;
    _190 = uint(4);
    _10._m0[_190] = uint(_16(3.75, _327));
    float _333 = -3.75;
    _192 = uint(5);
    _10._m0[_192] = uint(_16(_333, 2.75));
    _194 = uint(6);
    _10._m0[_194] = _43(3.75, 2.75);
    _196 = uint(7);
    _10._m0[_196] = _43(16777215.0, 1.0);
    _198 = uint(8);
    _10._m0[_198] = uint(_64(true, true));
    _200 = uint(9);
    _10._m0[_200] = uint(_64(false, true));
    uint _359 = min(0u, 32u);
    uint _364 = min(0u, 32u);
    _202 = uint(10);
    _10._m0[_202] = uint(int(uint(bitfieldExtract(3, int(_359), int(min(24u, (32u - _359))))) * uint(bitfieldExtract(int(true), int(_364), int(min(24u, (32u - _364)))))));
    uint _376 = min(0u, 32u);
    uint _381 = min(0u, 32u);
    _204 = uint(11);
    _10._m0[_204] = uint(int(uint(bitfieldExtract(int(true), int(_376), int(min(24u, (32u - _376))))) * uint(bitfieldExtract(3, int(_381), int(min(24u, (32u - _381)))))));
    _206 = uint(12);
    _10._m0[_206] = uint(_86(3.75, 2.0));
    _208 = uint(13);
    _10._m0[_208] = _96(3, 4);
    uint _401 = min(0u, 32u);
    uint _405 = min(0u, 32u);
    _210 = uint(14);
    _10._m0[_210] = bitfieldExtract(3u, int(_401), int(min(24u, (32u - _401)))) * bitfieldExtract(4u, int(_405), int(min(24u, (32u - _405))));
    _212 = uint(15);
    _10._m0[_212] = _96(int(true), int(true));
    uint _420 = min(0u, 32u);
    uint _424 = min(0u, 32u);
    _214 = uint(16);
    _10._m0[_214] = bitfieldExtract(3u, int(_420), int(min(24u, (32u - _420)))) * bitfieldExtract(uint(4), int(_424), int(min(24u, (32u - _424))));
    int _431 = -7;
    _216 = uint(17);
    _10._m0[_216] = uint(_106(_431, 3));
    uint _438 = min(0u, 32u);
    uint _443 = min(0u, 32u);
    uint _450 = min(0u, 32u);
    uint _455 = min(0u, 32u);
    _218 = uint(18);
    _10._m0[_218] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_438), int(min(24u, (32u - _438))))) * uint(bitfieldExtract(4, int(_443), int(min(24u, (32u - _443)))))), int(_450), int(min(24u, (32u - _450))))) * uint(bitfieldExtract(5, int(_455), int(min(24u, (32u - _455)))))));
    uint _466 = min(0u, 32u);
    uint _470 = min(0u, 32u);
    uint _475 = min(0u, 32u);
    uint _479 = min(0u, 32u);
    _220 = uint(19);
    _10._m0[_220] = bitfieldExtract(bitfieldExtract(16777215u, int(_466), int(min(24u, (32u - _466)))) * bitfieldExtract(2u, int(_470), int(min(24u, (32u - _470)))), int(_475), int(min(24u, (32u - _475)))) * bitfieldExtract(2u, int(_479), int(min(24u, (32u - _479))));
    _222 = -3;
    _224 = 5u;
    uint _490 = min(0u, 32u);
    uint _495 = min(0u, 32u);
    _226 = uint(20);
    _10._m0[_226] = uint(int(uint(bitfieldExtract(_222, int(_490), int(min(24u, (32u - _490))))) * uint(bitfieldExtract(int(_224), int(_495), int(min(24u, (32u - _495)))))));
    uint _509 = min(0u, 32u);
    uint _513 = min(0u, 32u);
    _228 = uint(21);
    _10._m0[_228] = bitfieldExtract(uint(_222), int(_509), int(min(24u, (32u - _509)))) * bitfieldExtract(_224, int(_513), int(min(24u, (32u - _513))));
    uint _521 = min(0u, 32u);
    uint _526 = min(0u, 32u);
    _230 = uint(22);
    _10._m0[_230] = uint(int(uint(bitfieldExtract(25165824, int(_521), int(min(24u, (32u - _521))))) * uint(bitfieldExtract(16777217, int(_526), int(min(24u, (32u - _526)))))));
    uint _537 = min(0u, 32u);
    uint _541 = min(0u, 32u);
    _232 = uint(23);
    _10._m0[_232] = bitfieldExtract(4286578688u, int(_537), int(min(24u, (32u - _537)))) * bitfieldExtract(4278190081u, int(_541), int(min(24u, (32u - _541))));
    if (true)
    {
        int _551 = -3;
        uint _553 = min(0u, 32u);
        uint _558 = min(0u, 32u);
        _236 = int(uint(bitfieldExtract(_551, int(_553), int(min(24u, (32u - _553))))) * uint(bitfieldExtract(7, int(_558), int(min(24u, (32u - _558))))));
    }
    else
    {
        uint _565 = min(0u, 32u);
        uint _570 = min(0u, 32u);
        _236 = int(uint(bitfieldExtract(0, int(_565), int(min(24u, (32u - _565))))) * uint(bitfieldExtract(0, int(_570), int(min(24u, (32u - _570))))));
    }
    _234 = uint(24);
    _10._m0[_234] = uint(_236);
    uint _582 = min(0u, 32u);
    uint _587 = min(0u, 32u);
    _238[0u] = int(uint(bitfieldExtract(2, int(_582), int(min(24u, (32u - _582))))) * uint(bitfieldExtract(3, int(_587), int(min(24u, (32u - _587))))));
    uint _595 = min(0u, 32u);
    uint _600 = min(0u, 32u);
    _238[1u] = int(uint(bitfieldExtract(3, int(_595), int(min(24u, (32u - _595))))) * uint(bitfieldExtract(4, int(_600), int(min(24u, (32u - _600))))));
    _241 = uint(25);
    _10._m0[_241] = uint(_238[0u] + _238[1u]);
    _243 = 2;
    _247 = int[](0, 0);
    _249 = uint(26);
    _10._m0[_249] = uint(_243 + _247[0u]);
    _251 = 2;
    int _625 = _251;
    _251 = _625 + 1;
    int _627 = _251;
    _251 = _627 + 1;
    uint _630 = min(0u, 32u);
    uint _635 = min(0u, 32u);
    _253 = uint(27);
    _10._m0[_253] = uint(int(uint(bitfieldExtract(_625, int(_630), int(min(24u, (32u - _630))))) * uint(bitfieldExtract(_627, int(_635), int(min(24u, (32u - _635)))))));
    _255 = uint(28);
    _10._m0[_255] = uint(_251);
    _257 = 0;
    int _259 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _662)))
        {
            break;
        }
        _662 -= uvec2(uint(_662.y == 0u), 1u);
        if (!(_259 < 3))
        {
            break;
        }
        uint _680 = min(0u, 32u);
        uint _685 = min(0u, 32u);
        _257 += int(uint(bitfieldExtract(_259 + 1, int(_680), int(min(24u, (32u - _680))))) * uint(bitfieldExtract(2, int(_685), int(min(24u, (32u - _685))))));
        _259++;
        continue;
    }
    _261 = uint(29);
    _10._m0[_261] = uint(_257);
    float _702 = clamp(9.75, -2147483648.0, 2147483520.0);
    _263 = uint(30);
    _267 = _263;
    _10._m0[_267] = uint(int(_702));
    uint _710 = min(0u, 32u);
    uint _715 = min(0u, 32u);
    _265 = uint(31);
    _10._m0[_265] = uint(int(uint(bitfieldExtract(16777215, int(_710), int(min(24u, (32u - _710))))) * uint(bitfieldExtract(3, int(_715), int(min(24u, (32u - _715)))))));
}

