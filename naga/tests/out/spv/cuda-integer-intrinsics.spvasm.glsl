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
    int _81 = 31 - int(uint(findMSB(uint(int(true)))));
    _6._m0[uint(0)] = uint(_81);
    int _91 = 31 - int(uint(findMSB(uint(8))));
    _6._m0[uint(1)] = uint(_91);
    int _100 = 31 - int(uint(findMSB(uint(int(2147483648u)))));
    _6._m0[uint(2)] = uint(_100);
    float _110 = clamp(8.75, -2147483648.0, 2147483520.0);
    int _112 = 31 - int(uint(findMSB(uint(int(_110)))));
    _6._m0[uint(3)] = uint(_112);
    _6._m0[uint(4)] = uint(findLSB(int(true)) + 1);
    int _126 = findLSB(8);
    _6._m0[uint(5)] = uint(_126 + 1);
    _6._m0[uint(6)] = uint(findLSB(int(2147483648u)) + 1);
    float _137 = clamp(8.75, -2147483648.0, 2147483520.0);
    _6._m0[uint(7)] = uint(findLSB(int(_137)) + 1);
    _6._m0[uint(8)] = uint(int(uint(bitCount(uint(true)))));
    int _150 = -1;
    _6._m0[uint(9)] = uint(int(uint(bitCount(uint(_150)))));
    uint _157 = uint(bitCount(2147483649u));
    _6._m0[uint(10)] = uint(int(_157));
    float _164 = clamp(3.75, 0.0, 4294967040.0);
    _6._m0[uint(11)] = uint(int(uint(bitCount(uint(_164)))));
    _6._m0[uint(12)] = bitfieldReverse(uint(true));
    int _175 = -1;
    _6._m0[uint(13)] = bitfieldReverse(uint(_175));
    uint _180 = bitfieldReverse(19088743u);
    _6._m0[uint(14)] = _180;
    float _183 = clamp(2.75, 0.0, 4294967040.0);
    _6._m0[uint(15)] = bitfieldReverse(uint(_183));
    _6._m0[uint(16)] = uint(_11(2147483649u));
    _6._m0[uint(17)] = uint(_18(int(2147483648u)));
    int _197 = 31 - int(uint(findMSB(uint(0))));
    _6._m0[uint(18)] = uint(_197);
    int _205 = findLSB(0);
    _6._m0[uint(19)] = uint(_205 + 1);
    uint _210 = uint(bitCount(4294967295u));
    _6._m0[uint(20)] = uint(int(_210));
    uint _215 = bitfieldReverse(0u);
    _6._m0[uint(21)] = _215;
    uint _218 = bitfieldReverse(1u);
    _6._m0[uint(22)] = _218;
    uint _221 = bitfieldReverse(2147483648u);
    _6._m0[uint(23)] = _221;
    int _224 = -2;
    int _225 = 31 - int(uint(findMSB(uint(_224))));
    _6._m0[uint(24)] = uint(_225);
    int _233 = -2;
    _6._m0[uint(25)] = uint(findLSB(_233) + 1);
    uint _239 = uint(bitCount(2863311530u));
    _6._m0[uint(26)] = uint(int(_239));
    uint _244 = bitfieldReverse(2863311530u);
    _6._m0[uint(27)] = _244;
    _6._m0[uint(28)] = uint(_27(3, 4));
    uint _251 = uint(bitCount(3u));
    _6._m0[uint(29)] = uint((int(_251) - 3) < 0);
}

