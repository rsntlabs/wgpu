#version 460
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

uint _16(uint _15)
{
    uint _30 = _15 & 2147483647u;
    uint _31 = _15 & 2147483648u;
    uint _37 = 1u << ((150u - (_30 >> 23u)) & 31u);
    uint _38 = _37 - 1u;
    uint _42 = _15 & (~_38);
    return (_30 > 2139095040u) ? 2143289344u : ((_30 >= 1258291200u) ? _15 : ((_30 < 1065353216u) ? ((_30 == 0u) ? _15 : (_31 | ((_31 >> 31u) * 1065353216u))) : (((_31 != 0u) && ((_15 & _38) != 0u)) ? (_42 + _37) : _42)));
}

uint _67(uint _66)
{
    uint _69 = _66 & 2147483647u;
    uint _70 = _66 & 2147483648u;
    uint _74 = 1u << ((150u - (_69 >> 23u)) & 31u);
    uint _75 = _74 - 1u;
    uint _79 = _66 & (~_75);
    return (_69 > 2139095040u) ? 2143289344u : ((_69 >= 1258291200u) ? _66 : ((_69 < 1065353216u) ? ((_69 == 0u) ? _66 : (_70 | ((1u - (_70 >> 31u)) * 1065353216u))) : (((_70 == 0u) && ((_66 & _75) != 0u)) ? (_79 + _74) : _79)));
}

float _59(float _58)
{
    return uintBitsToFloat(_16(floatBitsToUint(_58)));
}

float _98(float _97)
{
    return uintBitsToFloat(_67(floatBitsToUint(_97)));
}

void main()
{
    uint _157 = 0u;
    uint _151 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _155 = 0u;
    int _148 = 0;
    uint _142 = 0u;
    uint _136 = 0u;
    uint _129 = 0u;
    uint _159 = 0u;
    uint _153 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _165 = _8._m0[gl_LocalInvocationID.x];
    uint _167 = 4u + (gl_LocalInvocationID.x * 14u);
    _11._m0[_167] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(uintBitsToFloat(_165)))));
    _129 = _167 + 1u;
    _11._m0[_129] = floatBitsToUint(uintBitsToFloat(_67(floatBitsToUint(uintBitsToFloat(_165)))));
    _132 = _167 + 2u;
    _11._m0[_132] = floatBitsToUint(_59(uintBitsToFloat(_165)));
    _134 = _167 + 3u;
    _11._m0[_134] = floatBitsToUint(_98(uintBitsToFloat(_165)));
    _136 = _167 + 4u;
    _11._m0[_136] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(0.0))));
    float _201 = -0.0;
    _138 = _167 + 5u;
    _11._m0[_138] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(_201))));
    _140 = _167 + 6u;
    _11._m0[_140] = floatBitsToUint(uintBitsToFloat(_67(floatBitsToUint(0.0))));
    float _216 = -0.0;
    _142 = _167 + 7u;
    _11._m0[_142] = floatBitsToUint(uintBitsToFloat(_67(floatBitsToUint(_216))));
    _144 = _167 + 8u;
    _11._m0[_144] = floatBitsToUint(uintBitsToFloat(_16(floatBitsToUint(0.25))));
    float _231 = -0.25;
    _146 = _167 + 9u;
    _11._m0[_146] = floatBitsToUint(uintBitsToFloat(_67(floatBitsToUint(_231))));
    _148 = 0;
    int _239 = _148;
    _148 = _239 + 1;
    _153 = gl_LocalInvocationID.x + uint(_239);
    _151 = _167 + 10u;
    _11._m0[_151] = floatBitsToUint(_59(uintBitsToFloat(_8._m0[_153])));
    int _252 = _148;
    _148 = _252 + 1;
    _155 = _167 + 11u;
    _11._m0[_155] = floatBitsToUint(_98(float(_252)));
    _157 = _167 + 12u;
    _11._m0[_157] = uint(_148 - 1);
    _159 = _167 + 13u;
    _11._m0[_159] = uint(_148);
}

