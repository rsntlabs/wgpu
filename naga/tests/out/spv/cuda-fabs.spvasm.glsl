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
    vec4 _258 = vec4(0.0);
    _6 _252 = _6(0.0, 0.0, 0.0);
    uint _246 = 0u;
    uint _240 = 0u;
    uint _233 = 0u;
    uint _254 = 0u;
    uint _248 = 0u;
    uint _242 = 0u;
    uint _236 = 0u;
    vec2 _256 = vec2(0.0);
    float _250 = 0.0;
    uint _244 = 0u;
    uint _238 = 0u;
    _11._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(0.0))));
    float _268 = -0.0;
    _11._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_268))));
    float _275 = -1.75;
    _11._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_275))));
    float _282 = -1.25;
    _11._m0[uint(3)] = floatBitsToUint(_104(_282));
    int _287 = -3;
    _11._m0[uint(4)] = floatBitsToUint(_112(_287));
    _11._m0[uint(5)] = floatBitsToUint(_121(4294967295u));
    _11._m0[uint(6)] = floatBitsToUint(_130(true));
    _11._m0[uint(7)] = floatBitsToUint(_130(false));
    _233 = 1u;
    _11._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_233)))));
    _236 = 2147483649u;
    _11._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_236)))));
    _238 = 8388607u;
    _11._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_238)))));
    _240 = 2155872255u;
    _11._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_240)))));
    _11._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _342 = -3.4028234663852885981170418348452e+38;
    _11._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_342))));
    _242 = 2139095040u;
    _11._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_242)))));
    _244 = 4286578688u;
    _11._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_244)))));
    _246 = 2143363909u;
    _11._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_246)))));
    _248 = 2139095041u;
    _11._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_248)))));
    float _381 = -2.75;
    _250 = _381;
    float _382 = _250;
    float _383 = float(1);
    _250 = _382 + _383;
    _11._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_382))));
    _11._m0[uint(19)] = floatBitsToUint(_250);
    int _395 = -3;
    _11._m0[uint(20)] = uint(_141(_395));
    _11._m0[uint(21)] = _148(3u);
    _11._m0[uint(22)] = uint(_154(true));
    _11._m0[uint(23)] = uint(_154(false));
    _11._m0[uint(24)] = uint(_168(true));
    float _415 = -2.5;
    float _416 = -0.0;
    _254 = 2147483649u;
    _252 = _49(_6(_415, _416, uintBitsToFloat(_254)));
    _11._m0[uint(25)] = floatBitsToUint(_252._m0);
    _11._m0[uint(26)] = floatBitsToUint(_252._m1);
    _11._m0[uint(27)] = floatBitsToUint(_252._m2);
    float _436 = -2.0;
    _11._m0[uint(28)] = floatBitsToUint(_181(_436, 3.0));
    float _441 = -3.0;
    float _442 = -4.0;
    _256 = _27(vec2(_441, _442));
    float _445 = -1.0;
    float _446 = -2.0;
    float _447 = -3.0;
    float _448 = -4.0;
    _258 = _74(vec4(_445, _446, _447, _448));
    _11._m0[uint(29)] = floatBitsToUint(((_256.x + _256.y) + _258.x) + _258.w);
}

