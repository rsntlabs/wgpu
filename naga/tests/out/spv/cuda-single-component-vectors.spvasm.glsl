#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_16bit_storage : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    int _m0;
};

struct _7
{
    float _m0;
};

struct _8
{
    uint _m0;
};

struct _10
{
    int16_t _m0;
};

struct _12
{
    uint16_t _m0;
};

struct _15
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _18_17
{
    _4 _m0[];
} _17;

layout(set = 0, binding = 1, std430) buffer _21_20
{
    _4 _m0[];
} _20;

layout(set = 0, binding = 2, std430) buffer _24_23
{
    uint _m0[];
} _23;

layout(set = 0, binding = 3, std140) uniform _27_26
{
    _15 _m0;
} _26;

_4 _106(_4 _105)
{
    _4 _108 = _4(0);
    _108 = _105;
    return _108;
}

_8 _114(_8 _113)
{
    _8 _116 = _8(0u);
    _116 = _113;
    return _116;
}

uint _31(_7 _30)
{
    _7 _34 = _7(0.0);
    _34 = _30;
    return 11u;
}

uint _40(_4 _39)
{
    _4 _43 = _4(0);
    _43 = _39;
    return 13u;
}

uint _49(_8 _48)
{
    _8 _52 = _8(0u);
    _52 = _48;
    return 17u;
}

uint _58(_10 _57)
{
    _10 _61 = _10(0s);
    _61 = _57;
    return 19u;
}

uint _67(_12 _66)
{
    _12 _70 = _12(0us);
    _70 = _66;
    return 23u;
}

uint _76(float _75)
{
    return 31u;
}

uint _82(int _81)
{
    return 37u;
}

uint _88(uint _87)
{
    return 41u;
}

uint _94(int16_t _93)
{
    return 43u;
}

uint _100(uint16_t _99)
{
    return 47u;
}

void main()
{
    _4 _200 = _4(0);
    uint _194 = 0u;
    uint _188 = 0u;
    uint _182 = 0u;
    uint _176 = 0u;
    uint _169 = 0u;
    _12 _163 = _12(0us);
    _8 _157 = _8(0u);
    uint _198 = 0u;
    uint _192 = 0u;
    uint _186 = 0u;
    uint _180 = 0u;
    uint _174 = 0u;
    _4 _167 = _4(0);
    _10 _161 = _10(0s);
    _4 _155 = _4(0);
    _4 _202 = _4(0);
    uint _196 = 0u;
    uint _190 = 0u;
    uint _184 = 0u;
    uint _178 = 0u;
    uint _172 = 0u;
    _4 _165 = _4(0);
    _7 _159 = _7(0.0);
    uint _211 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_211 >= _26._m0._m0)
    {
        return;
    }
    _155 = _106(_4(_17._m0[_211]._m0));
    _157 = _114(_8(uint(_155._m0)));
    _159 = _7(float(_155._m0 & 7) + 0.5);
    _161 = _10(int16_t(_155._m0));
    _163 = _12(uint16_t(_155._m0));
    _161._m0 = int16_t(int(_161._m0) + 1);
    _163._m0 = uint16_t(int(uint(_163._m0)) + 1);
    _200 = _4(0);
    _202 = _155;
    _200 = _202;
    _200._m0 ^= 324508639;
    _167 = _200;
    _165 = _167;
    _20._m0[_211] = _165;
    uint _267 = _211 * 16u;
    _23._m0[_267] = uint(_155._m0);
    _169 = _267 + 1u;
    _23._m0[_169] = uint(_165._m0);
    _172 = _267 + 2u;
    _23._m0[_172] = _157._m0;
    _174 = _267 + 3u;
    _23._m0[_174] = floatBitsToUint(_159._m0);
    _176 = _267 + 4u;
    _23._m0[_176] = uint(_161._m0);
    _178 = _267 + 5u;
    _23._m0[_178] = uint(_163._m0);
    _180 = _267 + 6u;
    _23._m0[_180] = _31(_159);
    _182 = _267 + 7u;
    _23._m0[_182] = _40(_155);
    _184 = _267 + 8u;
    _23._m0[_184] = _49(_157);
    _186 = _267 + 9u;
    _23._m0[_186] = _58(_161);
    _188 = _267 + 10u;
    _23._m0[_188] = _67(_163);
    _190 = _267 + 11u;
    _23._m0[_190] = _76(_159._m0);
    _192 = _267 + 12u;
    _23._m0[_192] = _82(_155._m0);
    _194 = _267 + 13u;
    _23._m0[_194] = _88(_157._m0);
    _196 = _267 + 14u;
    _23._m0[_196] = _94(_161._m0);
    _198 = _267 + 15u;
    _23._m0[_198] = _100(_163._m0);
}

