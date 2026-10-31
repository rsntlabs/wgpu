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
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _79 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    _79 = uint(0);
    _6._m0[_79] = uint(31 - findMSB(uint(int(true))));
    int _151 = findMSB(uint(8));
    _82 = uint(1);
    _6._m0[_82] = uint(31 - _151);
    _84 = uint(2);
    _6._m0[_84] = uint(31 - findMSB(uint(int(2147483648u))));
    float _165 = clamp(8.75, -2147483648.0, 2147483520.0);
    _86 = uint(3);
    _6._m0[_86] = uint(31 - findMSB(uint(int(_165))));
    _88 = uint(4);
    _6._m0[_88] = uint(findLSB(int(true)) + 1);
    int _180 = findLSB(8);
    _90 = uint(5);
    _6._m0[_90] = uint(_180 + 1);
    _92 = uint(6);
    _6._m0[_92] = uint(findLSB(int(2147483648u)) + 1);
    float _193 = clamp(8.75, -2147483648.0, 2147483520.0);
    _94 = uint(7);
    _6._m0[_94] = uint(findLSB(int(_193)) + 1);
    _96 = uint(8);
    _6._m0[_96] = uint(int(uint(bitCount(uint(true)))));
    int _208 = -1;
    _98 = uint(9);
    _6._m0[_98] = uint(int(uint(bitCount(uint(_208)))));
    uint _216 = uint(bitCount(2147483649u));
    _100 = uint(10);
    _6._m0[_100] = uint(int(_216));
    float _224 = clamp(3.75, 0.0, 4294967040.0);
    _102 = uint(11);
    _6._m0[_102] = uint(int(uint(bitCount(uint(_224)))));
    _104 = uint(12);
    _6._m0[_104] = bitfieldReverse(uint(true));
    int _237 = -1;
    _106 = uint(13);
    _6._m0[_106] = bitfieldReverse(uint(_237));
    uint _243 = bitfieldReverse(19088743u);
    _108 = uint(14);
    _6._m0[_108] = _243;
    float _247 = clamp(2.75, 0.0, 4294967040.0);
    _110 = uint(15);
    _6._m0[_110] = bitfieldReverse(uint(_247));
    _112 = uint(16);
    _6._m0[_112] = uint(_11(2147483649u));
    _114 = uint(17);
    _6._m0[_114] = uint(_18(int(2147483648u)));
    int _265 = findMSB(uint(0));
    _116 = uint(18);
    _6._m0[_116] = uint(31 - _265);
    int _270 = findLSB(0);
    _118 = uint(19);
    _6._m0[_118] = uint(_270 + 1);
    uint _276 = uint(bitCount(4294967295u));
    _120 = uint(20);
    _6._m0[_120] = uint(int(_276));
    uint _282 = bitfieldReverse(0u);
    _122 = uint(21);
    _6._m0[_122] = _282;
    uint _286 = bitfieldReverse(1u);
    _124 = uint(22);
    _6._m0[_124] = _286;
    uint _290 = bitfieldReverse(2147483648u);
    _126 = uint(23);
    _6._m0[_126] = _290;
    int _294 = -2;
    _128 = uint(24);
    _6._m0[_128] = uint(31 - findMSB(uint(_294)));
    int _301 = -2;
    _130 = uint(25);
    _6._m0[_130] = uint(findLSB(_301) + 1);
    uint _308 = uint(bitCount(2863311530u));
    _132 = uint(26);
    _6._m0[_132] = uint(int(_308));
    uint _314 = bitfieldReverse(2863311530u);
    _134 = uint(27);
    _6._m0[_134] = _314;
    _136 = uint(28);
    _6._m0[_136] = uint(_27(3, 4));
    uint _323 = uint(bitCount(3u));
    _138 = uint(29);
    _6._m0[_138] = uint((int(_323) - 3) < 0);
}

