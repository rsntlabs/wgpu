#version 460
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

int _17(float _16)
{
    return int((floatBitsToUint(_16) & 2147483647u) < 2139095040u);
}

int _30(float _29)
{
    return int((floatBitsToUint(_29) & 2147483647u) == 2139095040u);
}

int _38(float _37)
{
    return int((floatBitsToUint(_37) & 2147483647u) > 2139095040u);
}

int _46(float _45)
{
    return int((floatBitsToUint(_45) & 2147483648u) != 0u);
}

uint _56(int _55)
{
    return 10u + uint(_55);
}

int _64(bool _63)
{
    int _68 = 0;
    if (_63)
    {
        _68 = 7;
    }
    else
    {
        _68 = 9;
    }
    return _68;
}

void main()
{
    uint _184 = 0u;
    uint _178 = 0u;
    uint _172 = 0u;
    uint _166 = 0u;
    uint _160 = 0u;
    uint _154 = 0u;
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    uint _116 = 0u;
    uint _180 = 0u;
    uint _174 = 0u;
    uint _168 = 0u;
    uint _162 = 0u;
    uint _156 = 0u;
    uint _149 = 0u;
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _182 = 0u;
    uint _176 = 0u;
    uint _170 = 0u;
    uint _164 = 0u;
    uint _158 = 0u;
    bool _151 = false;
    uint _145 = 0u;
    uint _139 = 0u;
    int _133 = 0;
    uint _127 = 0u;
    uint _121 = 0u;
    uint _190 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_190 >= 544u)
    {
        return;
    }
    uint _196 = _9._m0[_190];
    uint _198 = 4u + (_190 * 23u);
    float _199 = uintBitsToFloat(_196);
    _12._m0[_198] = uint(int((floatBitsToUint(_199) & 2147483647u) < 2139095040u));
    _116 = _198 + 1u;
    _12._m0[_116] = uint(int((floatBitsToUint(_199) & 2147483647u) == 2139095040u));
    _119 = _198 + 2u;
    _12._m0[_119] = uint(int((floatBitsToUint(_199) & 2147483647u) > 2139095040u));
    _121 = _198 + 3u;
    _12._m0[_121] = uint(int((floatBitsToUint(_199) & 2147483648u) != 0u));
    _123 = _198 + 4u;
    _12._m0[_123] = uint(_17(_199));
    _125 = _198 + 5u;
    _12._m0[_125] = uint(_30(_199));
    _127 = _198 + 6u;
    _12._m0[_127] = uint(_38(_199));
    _129 = _198 + 7u;
    _12._m0[_129] = uint(_46(_199));
    _131 = _198 + 8u;
    _12._m0[_131] = _56(int((floatBitsToUint(_199) & 2147483647u) > 2139095040u));
    _133 = 0;
    int _258 = _133;
    _133 = _258 + 1;
    _137 = _190 + uint(_258);
    _135 = _198 + 9u;
    _12._m0[_135] = uint(int((floatBitsToUint(uintBitsToFloat(_9._m0[_137])) & 2147483648u) != 0u));
    _139 = _198 + 10u;
    _12._m0[_139] = uint(_133);
    _141 = _198 + 11u;
    _12._m0[_141] = uint(_64(true));
    if (int((floatBitsToUint(_199) & 2147483647u) < 2139095040u) != 0)
    {
        _143 = _198 + 12u;
        _180 = _143;
        _12._m0[_180] = 2u;
    }
    else
    {
        if (int((floatBitsToUint(_199) & 2147483647u) == 2139095040u) != 0)
        {
            _145 = _198 + 12u;
            _182 = _145;
            _12._m0[_182] = 3u;
        }
        else
        {
            _147 = _198 + 12u;
            _184 = _147;
            _12._m0[_184] = 4u;
        }
    }
    _151 = false;
    if (false)
    {
        int _314 = _133;
        _133 = _314 + 1;
        _151 = int((floatBitsToUint(_199 + float(_314)) & 2147483647u) > 2139095040u) != 0;
    }
    _149 = _198 + 13u;
    _12._m0[_149] = uint(_151);
    _154 = _198 + 14u;
    _12._m0[_154] = uint(_133);
    float _333 = float(3);
    _156 = _198 + 15u;
    _12._m0[_156] = uint(int((floatBitsToUint(_333) & 2147483647u) < 2139095040u));
    _158 = _198 + 16u;
    _12._m0[_158] = uint(int((floatBitsToUint(0.0) & 2147483648u) != 0u));
    float _350 = -0.0;
    _160 = _198 + 17u;
    _12._m0[_160] = uint(int((floatBitsToUint(_350) & 2147483648u) != 0u));
    float _359 = -0.0;
    _162 = _198 + 18u;
    _12._m0[_162] = uint(_46(_359));
    _166 = 2139095040u;
    _164 = _198 + 19u;
    _12._m0[_164] = uint(int((floatBitsToUint(uintBitsToFloat(_166)) & 2147483647u) < 2139095040u));
    _170 = 2139095040u;
    _168 = _198 + 20u;
    _12._m0[_168] = uint(int((floatBitsToUint(uintBitsToFloat(_170)) & 2147483647u) == 2139095040u));
    _174 = 4286578689u;
    _172 = _198 + 21u;
    _12._m0[_172] = uint(int((floatBitsToUint(uintBitsToFloat(_174)) & 2147483647u) > 2139095040u));
    _178 = 4286578689u;
    _176 = _198 + 22u;
    _12._m0[_176] = uint(int((floatBitsToUint(uintBitsToFloat(_178)) & 2147483648u) != 0u));
}

