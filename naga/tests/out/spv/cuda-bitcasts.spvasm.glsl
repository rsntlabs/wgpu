#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

int _19(int _17, int _18)
{
    return _17 + _18;
}

float _12(uint _11)
{
    return uintBitsToFloat(_11);
}

void main()
{
    uint _136 = 0u;
    int _130 = 0;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _111 = 0u;
    uint _104 = 0u;
    int _98 = 0;
    uint _140 = 0u;
    uint _134 = 0u;
    int _128 = 0;
    uint _122 = 0u;
    int _116 = 0;
    uint _109 = 0u;
    int _102 = 0;
    int _95 = 0;
    uint _138 = 0u;
    int _132 = 0;
    int _126 = 0;
    int _120 = 0;
    float _113 = 0.0;
    uint _107 = 0u;
    int _100 = 0;
    _7._m0[uint(0)] = uint(floatBitsToInt(float(true)));
    float _151 = float(3);
    _7._m0[uint(1)] = uint(floatBitsToInt(_151));
    float _156 = float(5u);
    _7._m0[uint(2)] = uint(floatBitsToInt(_156));
    _7._m0[uint(3)] = uint(floatBitsToInt(2.75));
    _7._m0[uint(4)] = floatBitsToUint(float(true));
    float _169 = float(3);
    _7._m0[uint(5)] = floatBitsToUint(_169);
    float _173 = float(5u);
    _7._m0[uint(6)] = floatBitsToUint(_173);
    _7._m0[uint(7)] = floatBitsToUint(2.75);
    _95 = int(true);
    _7._m0[uint(8)] = floatBitsToUint(intBitsToFloat(_95));
    _98 = 3;
    _7._m0[uint(9)] = floatBitsToUint(intBitsToFloat(_98));
    _100 = int(5u);
    _7._m0[uint(10)] = floatBitsToUint(intBitsToFloat(_100));
    float _199 = clamp(2.75, -2147483648.0, 2147483520.0);
    _102 = int(_199);
    _7._m0[uint(11)] = floatBitsToUint(intBitsToFloat(_102));
    _104 = uint(true);
    _7._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_104));
    _107 = uint(3);
    _7._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_107));
    _109 = 5u;
    _7._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_109));
    float _224 = clamp(2.75, 0.0, 4294967040.0);
    _111 = uint(_224);
    _7._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_111));
    _113 = 1.5;
    float _231 = _113;
    float _232 = float(1);
    _113 = _231 + _232;
    _7._m0[uint(16)] = uint(floatBitsToInt(_231));
    _7._m0[uint(17)] = floatBitsToUint(_113);
    float _242 = _113;
    float _243 = float(1);
    _113 = _242 + _243;
    _7._m0[uint(18)] = floatBitsToUint(_242);
    _7._m0[uint(19)] = floatBitsToUint(_113);
    _116 = 1065353216;
    int _252 = _116;
    _116 = _252 + 1;
    _7._m0[uint(20)] = floatBitsToUint(intBitsToFloat(_252));
    _7._m0[uint(21)] = uint(_116);
    _118 = 1073741824u;
    uint _262 = _118;
    _118 = _262 + uint(1);
    _7._m0[uint(22)] = floatBitsToUint(uintBitsToFloat(_262));
    _7._m0[uint(23)] = _118;
    _7._m0[uint(24)] = uint(_19(3, 4));
    _7._m0[uint(25)] = floatBitsToUint(_12(3212836864u));
    _120 = 2139095040;
    _7._m0[uint(26)] = floatBitsToUint(intBitsToFloat(_120));
    _122 = 2143363909u;
    _7._m0[uint(27)] = floatBitsToUint(uintBitsToFloat(_122));
    float _290 = clamp(1065353216.0, 0.0, 4294967040.0);
    _124 = uint(_290);
    _7._m0[uint(28)] = floatBitsToUint(uintBitsToFloat(_124));
    float _297 = float(1u);
    _7._m0[uint(29)] = uint(floatBitsToInt(_297));
    _7._m0[uint(30)] = uint(floatBitsToInt(float(true)));
    float _307 = float(3);
    _7._m0[uint(31)] = uint(floatBitsToInt(_307));
    float _312 = float(5u);
    _7._m0[uint(32)] = uint(floatBitsToInt(_312));
    _7._m0[uint(33)] = uint(floatBitsToInt(2.75));
    _7._m0[uint(34)] = floatBitsToUint(float(true));
    float _325 = float(3);
    _7._m0[uint(35)] = floatBitsToUint(_325);
    float _329 = float(5u);
    _7._m0[uint(36)] = floatBitsToUint(_329);
    _7._m0[uint(37)] = floatBitsToUint(2.75);
    _126 = int(true);
    _7._m0[uint(38)] = floatBitsToUint(intBitsToFloat(_126));
    _128 = 3;
    _7._m0[uint(39)] = floatBitsToUint(intBitsToFloat(_128));
    _130 = int(5u);
    _7._m0[uint(40)] = floatBitsToUint(intBitsToFloat(_130));
    float _353 = clamp(2.75, -2147483648.0, 2147483520.0);
    _132 = int(_353);
    _7._m0[uint(41)] = floatBitsToUint(intBitsToFloat(_132));
    _134 = uint(true);
    _7._m0[uint(42)] = floatBitsToUint(uintBitsToFloat(_134));
    _136 = uint(3);
    _7._m0[uint(43)] = floatBitsToUint(uintBitsToFloat(_136));
    _138 = 5u;
    _7._m0[uint(44)] = floatBitsToUint(uintBitsToFloat(_138));
    float _377 = clamp(2.75, 0.0, 4294967040.0);
    _140 = uint(_377);
    _7._m0[uint(45)] = floatBitsToUint(uintBitsToFloat(_140));
    _113 = 1.5;
    float _384 = _113;
    float _385 = float(1);
    _113 = _384 + _385;
    _7._m0[uint(46)] = uint(floatBitsToInt(_384));
    _7._m0[uint(47)] = floatBitsToUint(_113);
    float _395 = _113;
    float _396 = float(1);
    _113 = _395 + _396;
    _7._m0[uint(48)] = floatBitsToUint(_395);
    _7._m0[uint(49)] = floatBitsToUint(_113);
    _116 = 1065353216;
    int _405 = _116;
    _116 = _405 + 1;
    _7._m0[uint(50)] = floatBitsToUint(intBitsToFloat(_405));
    _7._m0[uint(51)] = uint(_116);
    _118 = 1073741824u;
    uint _415 = _118;
    _118 = _415 + uint(1);
    _7._m0[uint(52)] = floatBitsToUint(uintBitsToFloat(_415));
    _7._m0[uint(53)] = _118;
}

