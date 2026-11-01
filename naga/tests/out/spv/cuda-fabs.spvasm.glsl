#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

uint _16(uint _15)
{
    uint _22 = _15 & 2147483647u;
    return (_22 > 2139095040u) ? 2143289344u : _22;
}

float _104(float _103)
{
    return uintBitsToFloat(_16(floatBitsToUint(_103)));
}

float _112(int _111)
{
    return uintBitsToFloat(_16(floatBitsToUint(float(_111))));
}

float _121(uint _120)
{
    return uintBitsToFloat(_16(floatBitsToUint(float(_120))));
}

float _130(bool _129)
{
    return uintBitsToFloat(_16(floatBitsToUint(float(_129))));
}

int _141(int _140)
{
    return _140 + 40;
}

uint _148(uint _147)
{
    return _147 + 50u;
}

int _154(bool _153)
{
    int _158 = 0;
    if (_153)
    {
        _158 = 7;
    }
    else
    {
        _158 = 9;
    }
    return _158;
}

int _168(bool _167)
{
    int _171 = 0;
    if (_167)
    {
        _171 = 11;
    }
    else
    {
        _171 = 13;
    }
    return _171;
}

_6 _49(_6 _48)
{
    _6 _51 = _6(0.0, 0.0, 0.0);
    _51 = _48;
    return _6(uintBitsToFloat(_16(floatBitsToUint(_51._m0))), uintBitsToFloat(_16(floatBitsToUint(_51._m1))), uintBitsToFloat(_16(floatBitsToUint(_51._m2))));
}

float _181(float _179, float _180)
{
    return _179 + _180;
}

vec2 _27(vec2 _26)
{
    vec2 _29 = vec2(0.0);
    _29 = _26;
    return vec2(uintBitsToFloat(_16(floatBitsToUint(_29.x))), uintBitsToFloat(_16(floatBitsToUint(_29.y))));
}

vec4 _74(vec4 _73)
{
    vec4 _76 = vec4(0.0);
    _76 = _73;
    return vec4(uintBitsToFloat(_16(floatBitsToUint(_76.x))), uintBitsToFloat(_16(floatBitsToUint(_76.y))), uintBitsToFloat(_16(floatBitsToUint(_76.z))), uintBitsToFloat(_16(floatBitsToUint(_76.w))));
}

void main()
{
    uint _318 = 0u;
    uint _312 = 0u;
    uint _306 = 0u;
    uint _300 = 0u;
    uint _294 = 0u;
    uint _288 = 0u;
    uint _282 = 0u;
    uint _276 = 0u;
    uint _270 = 0u;
    uint _264 = 0u;
    uint _258 = 0u;
    uint _252 = 0u;
    uint _246 = 0u;
    uint _240 = 0u;
    uint _233 = 0u;
    vec2 _314 = vec2(0.0);
    uint _308 = 0u;
    _6 _302 = _6(0.0, 0.0, 0.0);
    uint _296 = 0u;
    uint _290 = 0u;
    uint _284 = 0u;
    uint _278 = 0u;
    uint _272 = 0u;
    uint _266 = 0u;
    uint _260 = 0u;
    uint _254 = 0u;
    uint _248 = 0u;
    uint _242 = 0u;
    uint _236 = 0u;
    vec4 _316 = vec4(0.0);
    uint _310 = 0u;
    uint _304 = 0u;
    uint _298 = 0u;
    uint _292 = 0u;
    float _286 = 0.0;
    uint _280 = 0u;
    uint _274 = 0u;
    uint _268 = 0u;
    uint _262 = 0u;
    uint _256 = 0u;
    uint _250 = 0u;
    uint _244 = 0u;
    uint _238 = 0u;
    _233 = uint(0);
    _11._m0[_233] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(0.0))));
    float _329 = -0.0;
    _236 = uint(1);
    _11._m0[_236] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_329))));
    float _337 = -1.75;
    _238 = uint(2);
    _11._m0[_238] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_337))));
    float _345 = -1.25;
    _240 = uint(3);
    _11._m0[_240] = floatBitsToUint(_104(_345));
    int _351 = -3;
    _242 = uint(4);
    _11._m0[_242] = floatBitsToUint(_112(_351));
    _244 = uint(5);
    _11._m0[_244] = floatBitsToUint(_121(4294967295u));
    _246 = uint(6);
    _11._m0[_246] = floatBitsToUint(_130(true));
    _248 = uint(7);
    _11._m0[_248] = floatBitsToUint(_130(false));
    _252 = 1u;
    _250 = uint(8);
    _11._m0[_250] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_252)))));
    _256 = 2147483649u;
    _254 = uint(9);
    _11._m0[_254] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_256)))));
    _260 = 8388607u;
    _258 = uint(10);
    _11._m0[_258] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_260)))));
    _264 = 2155872255u;
    _262 = uint(11);
    _11._m0[_262] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_264)))));
    _266 = uint(12);
    _11._m0[_266] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _415 = -3.4028234663852885981170418348452e+38;
    _268 = uint(13);
    _11._m0[_268] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_415))));
    _272 = 2139095040u;
    _270 = uint(14);
    _11._m0[_270] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_272)))));
    _276 = 4286578688u;
    _274 = uint(15);
    _11._m0[_274] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_276)))));
    _280 = 2143363909u;
    _278 = uint(16);
    _11._m0[_278] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_280)))));
    _284 = 2139095041u;
    _282 = uint(17);
    _11._m0[_282] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_284)))));
    float _459 = -2.75;
    _286 = _459;
    float _460 = _286;
    float _461 = float(1);
    _286 = _460 + _461;
    _288 = uint(18);
    _11._m0[_288] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_460))));
    _290 = uint(19);
    _11._m0[_290] = floatBitsToUint(_286);
    int _475 = -3;
    _292 = uint(20);
    _11._m0[_292] = uint(_141(_475));
    _294 = uint(21);
    _11._m0[_294] = _148(3u);
    _296 = uint(22);
    _11._m0[_296] = uint(_154(true));
    _298 = uint(23);
    _11._m0[_298] = uint(_154(false));
    _300 = uint(24);
    _11._m0[_300] = uint(_168(true));
    float _500 = -2.5;
    float _501 = -0.0;
    _304 = 2147483649u;
    _302 = _49(_6(_500, _501, uintBitsToFloat(_304)));
    _306 = uint(25);
    _11._m0[_306] = floatBitsToUint(_302._m0);
    _308 = uint(26);
    _11._m0[_308] = floatBitsToUint(_302._m1);
    _310 = uint(27);
    _11._m0[_310] = floatBitsToUint(_302._m2);
    float _524 = -2.0;
    _312 = uint(28);
    _11._m0[_312] = floatBitsToUint(_181(_524, 3.0));
    float _530 = -3.0;
    float _531 = -4.0;
    _314 = _27(vec2(_530, _531));
    float _534 = -1.0;
    float _535 = -2.0;
    float _536 = -3.0;
    float _537 = -4.0;
    _316 = _74(vec4(_534, _535, _536, _537));
    _318 = uint(29);
    _11._m0[_318] = floatBitsToUint(((_314.x + _314.y) + _316.x) + _316.w);
}

