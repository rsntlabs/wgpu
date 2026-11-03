#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _28 = _12 & 2147483647u;
    uint _29 = _12 & 2147483648u;
    uint _33 = 1u << ((150u - (_28 >> 23u)) & 31u);
    uint _34 = _33 - 1u;
    uint _35 = _12 & _34;
    uint _38 = _12 & (~_34);
    return (_28 > 2139095040u) ? 2143289344u : ((_28 >= 1258291200u) ? _12 : ((_28 < 1065353216u) ? ((_28 == 0u) ? _12 : ((_28 >= 1056964608u) ? (_29 | 1065353216u) : _29)) : (((_35 >= (_33 >> 1u)) && (_35 != 0u)) ? (_38 + _33) : _38)));
}

float _57(float _56)
{
    return uintBitsToFloat(_13(floatBitsToUint(_56)));
}

int _65(bool _64)
{
    int _69 = 0;
    if (_64)
    {
        _69 = 7;
    }
    else
    {
        _69 = 9;
    }
    return _69;
}

float _80(float _78, float _79)
{
    return _78 + _79;
}

void main()
{
    uint _194 = 0u;
    uint _188 = 0u;
    float _181 = 0.0;
    uint _175 = 0u;
    uint _169 = 0u;
    uint _163 = 0u;
    uint _198 = 0u;
    uint _192 = 0u;
    uint _186 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _167 = 0u;
    uint _160 = 0u;
    uint _196 = 0u;
    uint _190 = 0u;
    uint _184 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _165 = 0u;
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _208 = -0.0;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_208))));
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.25))));
    float _221 = -1.75;
    _8._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_221))));
    float _228 = float(3);
    _8._m0[uint(4)] = floatBitsToUint(_57(_228));
    float _233 = float(5u);
    _8._m0[uint(5)] = floatBitsToUint(_57(_233));
    _8._m0[uint(6)] = uint(_65(true));
    _8._m0[uint(7)] = uint(_65(false));
    _8._m0[uint(8)] = floatBitsToUint(_57(float(true)));
    _8._m0[uint(9)] = floatBitsToUint(_57(float(false)));
    _160 = 1u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_160)))));
    _163 = 2147483649u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_163)))));
    _165 = 8388607u;
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_165)))));
    _167 = 2155872255u;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_167)))));
    float _289 = -0.25;
    _8._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_289))));
    _169 = 1258291199u;
    _8._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_169)))));
    _171 = 3405774847u;
    _8._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_171)))));
    _8._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(3.4028234663852885981170418348452e+38))));
    float _318 = -3.4028234663852885981170418348452e+38;
    _8._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_318))));
    _173 = 2139095040u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_173)))));
    _175 = 4286578688u;
    _8._m0[uint(20)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_175)))));
    _177 = 2143363909u;
    _8._m0[uint(21)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_177)))));
    _179 = 4286578689u;
    _8._m0[uint(22)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_179)))));
    _181 = 2.25;
    float _357 = _181;
    float _358 = float(1);
    _181 = _357 + _358;
    _8._m0[uint(23)] = floatBitsToUint(_57(_357));
    _8._m0[uint(24)] = floatBitsToUint(_181);
    _8._m0[uint(25)] = floatBitsToUint(_80(2.0, 3.0));
    float _372 = float(4294967295u);
    _8._m0[uint(26)] = floatBitsToUint(_57(_372));
    int _377 = -2147483647;
    _8._m0[uint(27)] = floatBitsToUint(_57(float(_377 - 1)));
    _8._m0[uint(28)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(10000000000.0))));
    _8._m0[uint(29)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.5))));
    float _396 = -1.5;
    _8._m0[uint(30)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_396))));
    _8._m0[uint(31)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.5))));
    float _409 = -2.5;
    _8._m0[uint(32)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_409))));
    _184 = 1056964607u;
    _8._m0[uint(33)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_184)))));
    _186 = 1056964609u;
    _8._m0[uint(34)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_186)))));
    _188 = 3204448255u;
    _8._m0[uint(35)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_188)))));
    _190 = 3204448257u;
    _8._m0[uint(36)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_190)))));
    _192 = 1249902593u;
    _8._m0[uint(37)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_192)))));
    _194 = 3397386241u;
    _8._m0[uint(38)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_194)))));
    _196 = 1258291197u;
    _8._m0[uint(39)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_196)))));
    _198 = 3405774845u;
    _8._m0[uint(40)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_198)))));
}

