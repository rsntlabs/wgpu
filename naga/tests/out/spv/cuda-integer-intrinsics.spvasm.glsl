#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _7_6
{
    uint _m0[];
} _6;

int _11(uint _10)
{
    return int(uint(bitCount(_10)));
}

int _18(int _17)
{
    return findLSB(_17) + 1;
}

int _27(int _25, int _26)
{
    return _25 + _26;
}

void main()
{
    _6._m0[uint(0)] = uint(31 - findMSB(uint(int(true))));
    int _89 = findMSB(uint(8));
    _6._m0[uint(1)] = uint(31 - _89);
    _6._m0[uint(2)] = uint(31 - findMSB(uint(int(2147483648u))));
    float _101 = clamp(8.75, -2147483648.0, 2147483520.0);
    _6._m0[uint(3)] = uint(31 - findMSB(uint(int(_101))));
    _6._m0[uint(4)] = uint(findLSB(int(true)) + 1);
    int _114 = findLSB(8);
    _6._m0[uint(5)] = uint(_114 + 1);
    _6._m0[uint(6)] = uint(findLSB(int(2147483648u)) + 1);
    float _125 = clamp(8.75, -2147483648.0, 2147483520.0);
    _6._m0[uint(7)] = uint(findLSB(int(_125)) + 1);
    _6._m0[uint(8)] = uint(int(uint(bitCount(uint(true)))));
    int _138 = -1;
    _6._m0[uint(9)] = uint(int(uint(bitCount(uint(_138)))));
    uint _145 = uint(bitCount(2147483649u));
    _6._m0[uint(10)] = uint(int(_145));
    float _152 = clamp(3.75, 0.0, 4294967040.0);
    _6._m0[uint(11)] = uint(int(uint(bitCount(uint(_152)))));
    _6._m0[uint(12)] = bitfieldReverse(uint(true));
    int _163 = -1;
    _6._m0[uint(13)] = bitfieldReverse(uint(_163));
    uint _168 = bitfieldReverse(19088743u);
    _6._m0[uint(14)] = _168;
    float _171 = clamp(2.75, 0.0, 4294967040.0);
    _6._m0[uint(15)] = bitfieldReverse(uint(_171));
    _6._m0[uint(16)] = uint(_11(2147483649u));
    _6._m0[uint(17)] = uint(_18(int(2147483648u)));
    int _186 = findMSB(uint(0));
    _6._m0[uint(18)] = uint(31 - _186);
    int _190 = findLSB(0);
    _6._m0[uint(19)] = uint(_190 + 1);
    uint _195 = uint(bitCount(4294967295u));
    _6._m0[uint(20)] = uint(int(_195));
    uint _200 = bitfieldReverse(0u);
    _6._m0[uint(21)] = _200;
    uint _203 = bitfieldReverse(1u);
    _6._m0[uint(22)] = _203;
    uint _206 = bitfieldReverse(2147483648u);
    _6._m0[uint(23)] = _206;
    int _209 = -2;
    _6._m0[uint(24)] = uint(31 - findMSB(uint(_209)));
    int _215 = -2;
    _6._m0[uint(25)] = uint(findLSB(_215) + 1);
    uint _221 = uint(bitCount(2863311530u));
    _6._m0[uint(26)] = uint(int(_221));
    uint _226 = bitfieldReverse(2863311530u);
    _6._m0[uint(27)] = _226;
    _6._m0[uint(28)] = uint(_27(3, 4));
    uint _233 = uint(bitCount(3u));
    _6._m0[uint(29)] = uint((int(_233) - 3) < 0);
}

