#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _28 = _12 & 2147483647u;
    bool _30 = (_12 & 2147483648u) != 0u;
    uint _34 = 1u << ((150u - (_28 >> 23u)) & 31u);
    uint _35 = _34 - 1u;
    uint _39 = _12 & (~_35);
    return (_28 > 2139095040u) ? 2143289344u : ((_28 >= 1258291200u) ? _12 : ((_28 < 1065353216u) ? ((_28 == 0u) ? _12 : (_30 ? 3212836864u : 0u)) : ((_30 && ((_12 & _35) != 0u)) ? (_39 + _34) : _39)));
}

float _62(int _61)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_61))));
}

float _71(uint _70)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_70))));
}

float _80(bool _79)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_79))));
}

float _54(float _53)
{
    return uintBitsToFloat(_13(floatBitsToUint(_53)));
}

int _91(bool _90)
{
    int _95 = 0;
    if (_90)
    {
        _95 = 7;
    }
    else
    {
        _95 = 9;
    }
    return _95;
}

float _106(float _104, float _105)
{
    return _104 + _105;
}

void main()
{
    uint _251 = 0u;
    uint _245 = 0u;
    uint _239 = 0u;
    uint _233 = 0u;
    float _226 = 0.0;
    uint _220 = 0u;
    uint _214 = 0u;
    uint _208 = 0u;
    uint _202 = 0u;
    uint _196 = 0u;
    uint _190 = 0u;
    uint _184 = 0u;
    uint _178 = 0u;
    uint _172 = 0u;
    uint _165 = 0u;
    uint _247 = 0u;
    uint _241 = 0u;
    uint _235 = 0u;
    uint _229 = 0u;
    uint _222 = 0u;
    uint _216 = 0u;
    uint _210 = 0u;
    uint _204 = 0u;
    uint _198 = 0u;
    uint _192 = 0u;
    uint _186 = 0u;
    uint _180 = 0u;
    uint _174 = 0u;
    uint _168 = 0u;
    uint _249 = 0u;
    uint _243 = 0u;
    uint _237 = 0u;
    uint _231 = 0u;
    uint _224 = 0u;
    uint _218 = 0u;
    uint _212 = 0u;
    uint _206 = 0u;
    uint _200 = 0u;
    uint _194 = 0u;
    uint _188 = 0u;
    uint _182 = 0u;
    uint _176 = 0u;
    uint _170 = 0u;
    _165 = uint(0);
    _8._m0[_165] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _262 = -0.0;
    _168 = uint(1);
    _8._m0[_168] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_262))));
    _170 = uint(2);
    _8._m0[_170] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.75))));
    float _277 = -1.25;
    _172 = uint(3);
    _8._m0[_172] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_277))));
    _174 = uint(4);
    _8._m0[_174] = floatBitsToUint(_62(3));
    _176 = uint(5);
    _8._m0[_176] = floatBitsToUint(_71(5u));
    _178 = uint(6);
    _8._m0[_178] = floatBitsToUint(_80(true));
    _180 = uint(7);
    _8._m0[_180] = floatBitsToUint(_80(false));
    _184 = 1u;
    _182 = uint(8);
    _8._m0[_182] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_184)))));
    _188 = 2147483649u;
    _186 = uint(9);
    _8._m0[_186] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_188)))));
    _192 = 8388607u;
    _190 = uint(10);
    _8._m0[_190] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_192)))));
    _196 = 2155872255u;
    _194 = uint(11);
    _8._m0[_194] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_196)))));
    _198 = uint(12);
    _8._m0[_198] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _348 = -3.4028234663852885981170418348452e+38;
    _200 = uint(13);
    _8._m0[_200] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_348))));
    _204 = 2139095039u;
    _202 = uint(14);
    _8._m0[_202] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_204)))));
    _208 = 4286578687u;
    _206 = uint(15);
    _8._m0[_206] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_208)))));
    _212 = 2139095040u;
    _210 = uint(16);
    _8._m0[_210] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_212)))));
    _216 = 4286578688u;
    _214 = uint(17);
    _8._m0[_214] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_216)))));
    _220 = 2143363909u;
    _218 = uint(18);
    _8._m0[_218] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_220)))));
    _224 = 2139095041u;
    _222 = uint(19);
    _8._m0[_222] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_224)))));
    _226 = 2.75;
    float _410 = _226;
    float _411 = float(1);
    _226 = _410 + _411;
    _229 = uint(20);
    _8._m0[_229] = floatBitsToUint(_54(_410));
    _231 = uint(21);
    _8._m0[_231] = floatBitsToUint(_226);
    _233 = uint(22);
    _8._m0[_233] = uint(_91(true));
    _235 = uint(23);
    _8._m0[_235] = uint(_91(false));
    _237 = uint(24);
    _8._m0[_237] = floatBitsToUint(_106(2.0, 3.0));
    _241 = 1258291199u;
    _239 = uint(25);
    _8._m0[_239] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_241)))));
    _245 = 3405774847u;
    _243 = uint(26);
    _8._m0[_243] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_245)))));
    _247 = uint(27);
    _8._m0[_247] = floatBitsToUint(_71(4294967295u));
    int _461 = -2147483647;
    _249 = uint(28);
    _8._m0[_249] = floatBitsToUint(_62(_461 - 1));
    _251 = uint(29);
    _8._m0[_251] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(10000000000.0))));
}

