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
    uint _98 = 0u;
    int _92 = 0;
    uint _85 = 0u;
    int _78 = 0;
    int _71 = 0;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _87 = 0u;
    uint _80 = 0u;
    int _74 = 0;
    int _96 = 0;
    float _89 = 0.0;
    uint _83 = 0u;
    int _76 = 0;
    _7._m0[uint(0)] = uint(floatBitsToInt(float(true)));
    float _111 = float(3);
    _7._m0[uint(1)] = uint(floatBitsToInt(_111));
    float _116 = float(5u);
    _7._m0[uint(2)] = uint(floatBitsToInt(_116));
    _7._m0[uint(3)] = uint(floatBitsToInt(2.75));
    _7._m0[uint(4)] = floatBitsToUint(float(true));
    float _129 = float(3);
    _7._m0[uint(5)] = floatBitsToUint(_129);
    float _133 = float(5u);
    _7._m0[uint(6)] = floatBitsToUint(_133);
    _7._m0[uint(7)] = floatBitsToUint(2.75);
    _71 = int(true);
    _7._m0[uint(8)] = floatBitsToUint(intBitsToFloat(_71));
    _74 = 3;
    _7._m0[uint(9)] = floatBitsToUint(intBitsToFloat(_74));
    _76 = int(5u);
    _7._m0[uint(10)] = floatBitsToUint(intBitsToFloat(_76));
    float _159 = clamp(2.75, -2147483648.0, 2147483520.0);
    _78 = int(_159);
    _7._m0[uint(11)] = floatBitsToUint(intBitsToFloat(_78));
    _80 = uint(true);
    _7._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_80));
    _83 = uint(3);
    _7._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_83));
    _85 = 5u;
    _7._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_85));
    float _184 = clamp(2.75, 0.0, 4294967040.0);
    _87 = uint(_184);
    _7._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_87));
    _89 = 1.5;
    float _191 = _89;
    float _192 = float(1);
    _89 = _191 + _192;
    _7._m0[uint(16)] = uint(floatBitsToInt(_191));
    _7._m0[uint(17)] = floatBitsToUint(_89);
    float _202 = _89;
    float _203 = float(1);
    _89 = _202 + _203;
    _7._m0[uint(18)] = floatBitsToUint(_202);
    _7._m0[uint(19)] = floatBitsToUint(_89);
    _92 = 1065353216;
    int _212 = _92;
    _92 = _212 + 1;
    _7._m0[uint(20)] = floatBitsToUint(intBitsToFloat(_212));
    _7._m0[uint(21)] = uint(_92);
    _94 = 1073741824u;
    uint _222 = _94;
    _94 = _222 + uint(1);
    _7._m0[uint(22)] = floatBitsToUint(uintBitsToFloat(_222));
    _7._m0[uint(23)] = _94;
    _7._m0[uint(24)] = uint(_19(3, 4));
    _7._m0[uint(25)] = floatBitsToUint(_12(3212836864u));
    _96 = 2139095040;
    _7._m0[uint(26)] = floatBitsToUint(intBitsToFloat(_96));
    _98 = 2143363909u;
    _7._m0[uint(27)] = floatBitsToUint(uintBitsToFloat(_98));
    float _250 = clamp(1065353216.0, 0.0, 4294967040.0);
    _100 = uint(_250);
    _7._m0[uint(28)] = floatBitsToUint(uintBitsToFloat(_100));
    float _257 = float(1u);
    _7._m0[uint(29)] = uint(floatBitsToInt(_257));
}

