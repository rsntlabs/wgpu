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
    uint _303 = 0u;
    uint _291 = 0u;
    uint _279 = 0u;
    uint _267 = 0u;
    uint _255 = 0u;
    int _243 = 0;
    uint _230 = 0u;
    uint _218 = 0u;
    uint _206 = 0u;
    uint _329 = 0u;
    uint _194 = 0u;
    uint _317 = 0u;
    uint _181 = 0u;
    uint _305 = 0u;
    uint _293 = 0u;
    uint _281 = 0u;
    uint _269 = 0u;
    int _257 = 0;
    int _245 = 0;
    uint _232 = 0u;
    uint _220 = 0u;
    uint _208 = 0u;
    uint _196 = 0u;
    uint _319 = 0u;
    uint _184 = 0u;
    uint _307 = 0u;
    uint _295 = 0u;
    uint _283 = 0u;
    uint _271 = 0u;
    int _247[2] = int[](0, 0);
    uint _234 = 0u;
    int _222 = 0;
    uint _210 = 0u;
    uint _198 = 0u;
    uint _321 = 0u;
    uint _186 = 0u;
    uint _309 = 0u;
    uint _297 = 0u;
    uint _285 = 0u;
    uint _273 = 0u;
    uint _261 = 0u;
    uint _249 = 0u;
    int _236 = 0;
    uint _224 = 0u;
    uint _212 = 0u;
    uint _200 = 0u;
    uint _323 = 0u;
    uint _188 = 0u;
    uint _311 = 0u;
    uint _299 = 0u;
    uint _287 = 0u;
    uint _275 = 0u;
    uint _263 = 0u;
    int _251 = 0;
    int _238[2] = int[](0, 0);
    uint _226 = 0u;
    uint _214 = 0u;
    uint _202 = 0u;
    uint _325 = 0u;
    uint _190 = 0u;
    uint _313 = 0u;
    uint _301 = 0u;
    uint _289 = 0u;
    uint _277 = 0u;
    uint _265 = 0u;
    uint _253 = 0u;
    uint _241 = 0u;
    uint _228 = 0u;
    uint _216 = 0u;
    uint _204 = 0u;
    uint _327 = 0u;
    uint _192 = 0u;
    uint _315 = 0u;
    uvec2 _753 = uvec2(4294967295u);
    uint _333 = min(0u, 32u);
    uint _338 = min(0u, 32u);
    _181 = uint(0);
    _267 = _181;
    _10._m0[_267] = uint(int(uint(bitfieldExtract(8388608, int(_333), int(min(24u, (32u - _333))))) * uint(bitfieldExtract(1, int(_338), int(min(24u, (32u - _338)))))));
    uint _351 = min(0u, 32u);
    uint _355 = min(0u, 32u);
    _184 = uint(1);
    _269 = _184;
    _10._m0[_269] = bitfieldExtract(16777215u, int(_351), int(min(24u, (32u - _351)))) * bitfieldExtract(16777215u, int(_355), int(min(24u, (32u - _355))));
    uint _364 = min(0u, 32u);
    uint _369 = min(0u, 32u);
    _186 = uint(2);
    _271 = _186;
    _10._m0[_271] = uint(int(uint(bitfieldExtract(8388607, int(_364), int(min(24u, (32u - _364))))) * uint(bitfieldExtract(8388607, int(_369), int(min(24u, (32u - _369)))))));
    uint _381 = min(0u, 32u);
    uint _385 = min(0u, 32u);
    _188 = uint(3);
    _273 = _188;
    _10._m0[_273] = bitfieldExtract(16777216u, int(_381), int(min(24u, (32u - _381)))) * bitfieldExtract(13u, int(_385), int(min(24u, (32u - _385))));
    float _393 = -2.75;
    _190 = uint(4);
    _275 = _190;
    _10._m0[_275] = uint(_16(3.75, _393));
    float _400 = -3.75;
    _192 = uint(5);
    _277 = _192;
    _10._m0[_277] = uint(_16(_400, 2.75));
    _194 = uint(6);
    _279 = _194;
    _10._m0[_279] = _43(3.75, 2.75);
    _196 = uint(7);
    _281 = _196;
    _10._m0[_281] = _43(16777215.0, 1.0);
    _198 = uint(8);
    _283 = _198;
    _10._m0[_283] = uint(_64(true, true));
    _200 = uint(9);
    _285 = _200;
    _10._m0[_285] = uint(_64(false, true));
    uint _431 = min(0u, 32u);
    uint _436 = min(0u, 32u);
    _202 = uint(10);
    _287 = _202;
    _10._m0[_287] = uint(int(uint(bitfieldExtract(3, int(_431), int(min(24u, (32u - _431))))) * uint(bitfieldExtract(int(true), int(_436), int(min(24u, (32u - _436)))))));
    uint _449 = min(0u, 32u);
    uint _454 = min(0u, 32u);
    _204 = uint(11);
    _289 = _204;
    _10._m0[_289] = uint(int(uint(bitfieldExtract(int(true), int(_449), int(min(24u, (32u - _449))))) * uint(bitfieldExtract(3, int(_454), int(min(24u, (32u - _454)))))));
    _206 = uint(12);
    _291 = _206;
    _10._m0[_291] = uint(_86(3.75, 2.0));
    _208 = uint(13);
    _293 = _208;
    _10._m0[_293] = _96(3, 4);
    uint _477 = min(0u, 32u);
    uint _481 = min(0u, 32u);
    _210 = uint(14);
    _295 = _210;
    _10._m0[_295] = bitfieldExtract(3u, int(_477), int(min(24u, (32u - _477)))) * bitfieldExtract(4u, int(_481), int(min(24u, (32u - _481))));
    _212 = uint(15);
    _297 = _212;
    _10._m0[_297] = _96(int(true), int(true));
    uint _498 = min(0u, 32u);
    uint _502 = min(0u, 32u);
    _214 = uint(16);
    _299 = _214;
    _10._m0[_299] = bitfieldExtract(3u, int(_498), int(min(24u, (32u - _498)))) * bitfieldExtract(uint(4), int(_502), int(min(24u, (32u - _502))));
    int _510 = -7;
    _216 = uint(17);
    _301 = _216;
    _10._m0[_301] = uint(_106(_510, 3));
    uint _518 = min(0u, 32u);
    uint _523 = min(0u, 32u);
    uint _530 = min(0u, 32u);
    uint _535 = min(0u, 32u);
    _218 = uint(18);
    _303 = _218;
    _10._m0[_303] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_518), int(min(24u, (32u - _518))))) * uint(bitfieldExtract(4, int(_523), int(min(24u, (32u - _523)))))), int(_530), int(min(24u, (32u - _530))))) * uint(bitfieldExtract(5, int(_535), int(min(24u, (32u - _535)))))));
    uint _547 = min(0u, 32u);
    uint _551 = min(0u, 32u);
    uint _556 = min(0u, 32u);
    uint _560 = min(0u, 32u);
    _220 = uint(19);
    _305 = _220;
    _10._m0[_305] = bitfieldExtract(bitfieldExtract(16777215u, int(_547), int(min(24u, (32u - _547)))) * bitfieldExtract(2u, int(_551), int(min(24u, (32u - _551)))), int(_556), int(min(24u, (32u - _556)))) * bitfieldExtract(2u, int(_560), int(min(24u, (32u - _560))));
    _222 = -3;
    _224 = 5u;
    uint _572 = min(0u, 32u);
    uint _577 = min(0u, 32u);
    _226 = uint(20);
    _307 = _226;
    _10._m0[_307] = uint(int(uint(bitfieldExtract(_222, int(_572), int(min(24u, (32u - _572))))) * uint(bitfieldExtract(int(_224), int(_577), int(min(24u, (32u - _577)))))));
    uint _592 = min(0u, 32u);
    uint _596 = min(0u, 32u);
    _228 = uint(21);
    _309 = _228;
    _10._m0[_309] = bitfieldExtract(uint(_222), int(_592), int(min(24u, (32u - _592)))) * bitfieldExtract(_224, int(_596), int(min(24u, (32u - _596))));
    uint _605 = min(0u, 32u);
    uint _610 = min(0u, 32u);
    _230 = uint(22);
    _311 = _230;
    _10._m0[_311] = uint(int(uint(bitfieldExtract(25165824, int(_605), int(min(24u, (32u - _605))))) * uint(bitfieldExtract(16777217, int(_610), int(min(24u, (32u - _610)))))));
    uint _622 = min(0u, 32u);
    uint _626 = min(0u, 32u);
    _232 = uint(23);
    _313 = _232;
    _10._m0[_313] = bitfieldExtract(4286578688u, int(_622), int(min(24u, (32u - _622)))) * bitfieldExtract(4278190081u, int(_626), int(min(24u, (32u - _626))));
    if (true)
    {
        int _637 = -3;
        uint _639 = min(0u, 32u);
        uint _644 = min(0u, 32u);
        _236 = int(uint(bitfieldExtract(_637, int(_639), int(min(24u, (32u - _639))))) * uint(bitfieldExtract(7, int(_644), int(min(24u, (32u - _644))))));
    }
    else
    {
        uint _651 = min(0u, 32u);
        uint _656 = min(0u, 32u);
        _236 = int(uint(bitfieldExtract(0, int(_651), int(min(24u, (32u - _651))))) * uint(bitfieldExtract(0, int(_656), int(min(24u, (32u - _656))))));
    }
    _234 = uint(24);
    _315 = _234;
    _10._m0[_315] = uint(_236);
    uint _669 = min(0u, 32u);
    uint _674 = min(0u, 32u);
    _238[0u] = int(uint(bitfieldExtract(2, int(_669), int(min(24u, (32u - _669))))) * uint(bitfieldExtract(3, int(_674), int(min(24u, (32u - _674))))));
    uint _682 = min(0u, 32u);
    uint _687 = min(0u, 32u);
    _238[1u] = int(uint(bitfieldExtract(3, int(_682), int(min(24u, (32u - _682))))) * uint(bitfieldExtract(4, int(_687), int(min(24u, (32u - _687))))));
    _241 = uint(25);
    _317 = _241;
    _10._m0[_317] = uint(_238[0u] + _238[1u]);
    _243 = 2;
    _247 = int[](0, 0);
    _249 = uint(26);
    _319 = _249;
    _10._m0[_319] = uint(_243 + _247[0u]);
    _251 = 2;
    int _714 = _251;
    _251 = _714 + 1;
    int _716 = _251;
    _251 = _716 + 1;
    uint _719 = min(0u, 32u);
    uint _724 = min(0u, 32u);
    _253 = uint(27);
    _321 = _253;
    _10._m0[_321] = uint(int(uint(bitfieldExtract(_714, int(_719), int(min(24u, (32u - _719))))) * uint(bitfieldExtract(_716, int(_724), int(min(24u, (32u - _724)))))));
    _255 = uint(28);
    _323 = _255;
    _10._m0[_323] = uint(_251);
    _257 = 0;
    int _259 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _753)))
        {
            break;
        }
        _753 -= uvec2(uint(_753.y == 0u), 1u);
        if (!(_259 < 3))
        {
            break;
        }
        uint _771 = min(0u, 32u);
        uint _776 = min(0u, 32u);
        _257 += int(uint(bitfieldExtract(_259 + 1, int(_771), int(min(24u, (32u - _771))))) * uint(bitfieldExtract(2, int(_776), int(min(24u, (32u - _776))))));
        _259++;
        continue;
    }
    _261 = uint(29);
    _325 = _261;
    _10._m0[_325] = uint(_257);
    float _794 = clamp(9.75, -2147483648.0, 2147483520.0);
    _263 = uint(30);
    _327 = _263;
    _10._m0[_327] = uint(int(_794));
    uint _802 = min(0u, 32u);
    uint _807 = min(0u, 32u);
    _265 = uint(31);
    _329 = _265;
    _10._m0[_329] = uint(int(uint(bitfieldExtract(16777215, int(_802), int(min(24u, (32u - _802))))) * uint(bitfieldExtract(3, int(_807), int(min(24u, (32u - _807)))))));
}

