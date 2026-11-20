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
    uint _217 = 0u;
    uint _211 = 0u;
    int _205 = 0;
    uint _199 = 0u;
    uint _193 = 0u;
    uint _187 = 0u;
    uint _181 = 0u;
    uint _175 = 0u;
    uint _169 = 0u;
    uint _163 = 0u;
    uint _156 = 0u;
    uint _150 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _125 = 0u;
    uint _213 = 0u;
    uint _207 = 0u;
    uint _201 = 0u;
    uint _195 = 0u;
    uint _189 = 0u;
    uint _183 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _165 = 0u;
    uint _158 = 0u;
    uint _152 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    uint _215 = 0u;
    uint _209 = 0u;
    uint _203 = 0u;
    uint _197 = 0u;
    uint _191 = 0u;
    uint _185 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _167 = 0u;
    bool _160 = false;
    uint _154 = 0u;
    uint _148 = 0u;
    int _142 = 0;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _223 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_223 >= 544u)
    {
        return;
    }
    uint _229 = _9._m0[_223];
    uint _231 = 4u + (_223 * 33u);
    float _232 = uintBitsToFloat(_229);
    _12._m0[_231] = uint(int((floatBitsToUint(_232) & 2147483647u) < 2139095040u));
    _125 = _231 + 1u;
    _12._m0[_125] = uint(int((floatBitsToUint(_232) & 2147483647u) == 2139095040u));
    _128 = _231 + 2u;
    _12._m0[_128] = uint(int((floatBitsToUint(_232) & 2147483647u) > 2139095040u));
    _130 = _231 + 3u;
    _12._m0[_130] = uint(int((floatBitsToUint(_232) & 2147483648u) != 0u));
    _132 = _231 + 4u;
    _12._m0[_132] = uint(_17(_232));
    _134 = _231 + 5u;
    _12._m0[_134] = uint(_30(_232));
    _136 = _231 + 6u;
    _12._m0[_136] = uint(_38(_232));
    _138 = _231 + 7u;
    _12._m0[_138] = uint(_46(_232));
    _140 = _231 + 8u;
    _12._m0[_140] = _56(int((floatBitsToUint(_232) & 2147483647u) > 2139095040u));
    _142 = 0;
    int _291 = _142;
    _142 = _291 + 1;
    _146 = _223 + uint(_291);
    _144 = _231 + 9u;
    _12._m0[_144] = uint(int((floatBitsToUint(uintBitsToFloat(_9._m0[_146])) & 2147483648u) != 0u));
    _148 = _231 + 10u;
    _12._m0[_148] = uint(_142);
    _150 = _231 + 11u;
    _12._m0[_150] = uint(_64(true));
    if (int((floatBitsToUint(_232) & 2147483647u) < 2139095040u) != 0)
    {
        _152 = _231 + 12u;
        _213 = _152;
        _12._m0[_213] = 2u;
    }
    else
    {
        if (int((floatBitsToUint(_232) & 2147483647u) == 2139095040u) != 0)
        {
            _154 = _231 + 12u;
            _215 = _154;
            _12._m0[_215] = 3u;
        }
        else
        {
            _156 = _231 + 12u;
            _217 = _156;
            _12._m0[_217] = 4u;
        }
    }
    _160 = false;
    if (false)
    {
        int _347 = _142;
        _142 = _347 + 1;
        _160 = int((floatBitsToUint(_232 + float(_347)) & 2147483647u) > 2139095040u) != 0;
    }
    _158 = _231 + 13u;
    _12._m0[_158] = uint(_160);
    _163 = _231 + 14u;
    _12._m0[_163] = uint(_142);
    float _366 = float(3);
    _165 = _231 + 15u;
    _12._m0[_165] = uint(int((floatBitsToUint(_366) & 2147483647u) < 2139095040u));
    _167 = _231 + 16u;
    _12._m0[_167] = uint(int((floatBitsToUint(0.0) & 2147483648u) != 0u));
    float _383 = -0.0;
    _169 = _231 + 17u;
    _12._m0[_169] = uint(int((floatBitsToUint(_383) & 2147483648u) != 0u));
    float _392 = -0.0;
    _171 = _231 + 18u;
    _12._m0[_171] = uint(_46(_392));
    _175 = 2139095040u;
    _173 = _231 + 19u;
    _12._m0[_173] = uint(int((floatBitsToUint(uintBitsToFloat(_175)) & 2147483647u) < 2139095040u));
    _179 = 2139095040u;
    _177 = _231 + 20u;
    _12._m0[_177] = uint(int((floatBitsToUint(uintBitsToFloat(_179)) & 2147483647u) == 2139095040u));
    _183 = 4286578689u;
    _181 = _231 + 21u;
    _12._m0[_181] = uint(int((floatBitsToUint(uintBitsToFloat(_183)) & 2147483647u) > 2139095040u));
    _187 = 4286578689u;
    _185 = _231 + 22u;
    _12._m0[_185] = uint(int((floatBitsToUint(uintBitsToFloat(_187)) & 2147483648u) != 0u));
    _189 = _231 + 23u;
    _12._m0[_189] = uint(int((floatBitsToUint(_232) & 2147483647u) < 2139095040u));
    _191 = _231 + 24u;
    _12._m0[_191] = uint(int((floatBitsToUint(_232) & 2147483647u) == 2139095040u));
    _193 = _231 + 25u;
    _12._m0[_193] = uint(int((floatBitsToUint(_232) & 2147483647u) > 2139095040u));
    _195 = _231 + 26u;
    _12._m0[_195] = uint(int((floatBitsToUint(_232) & 2147483648u) != 0u));
    float _470 = float(3);
    _197 = _231 + 27u;
    _12._m0[_197] = uint(int((floatBitsToUint(_470) & 2147483647u) < 2139095040u));
    float _479 = float(0u);
    _199 = _231 + 28u;
    _12._m0[_199] = uint(int((floatBitsToUint(_479) & 2147483647u) == 2139095040u));
    _201 = _231 + 29u;
    _12._m0[_201] = uint(int((floatBitsToUint(float(true)) & 2147483647u) > 2139095040u));
    int _498 = -3;
    _203 = _231 + 30u;
    _12._m0[_203] = uint(int((floatBitsToUint(float(_498)) & 2147483648u) != 0u));
    _205 = 0;
    int _508 = _205;
    _205 = _508 + 1;
    _209 = _223 + uint(_508);
    _207 = _231 + 31u;
    _12._m0[_207] = uint(int((floatBitsToUint(uintBitsToFloat(_9._m0[_209])) & 2147483648u) != 0u));
    _211 = _231 + 32u;
    _12._m0[_211] = uint(_205);
}

