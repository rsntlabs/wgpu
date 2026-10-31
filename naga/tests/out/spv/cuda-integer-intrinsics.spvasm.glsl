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
    uint _188 = 0u;
    uint _176 = 0u;
    uint _164 = 0u;
    uint _152 = 0u;
    uint _140 = 0u;
    uint _128 = 0u;
    uint _116 = 0u;
    uint _104 = 0u;
    uint _92 = 0u;
    uint _79 = 0u;
    uint _190 = 0u;
    uint _178 = 0u;
    uint _166 = 0u;
    uint _154 = 0u;
    uint _142 = 0u;
    uint _130 = 0u;
    uint _118 = 0u;
    uint _106 = 0u;
    uint _94 = 0u;
    uint _82 = 0u;
    uint _192 = 0u;
    uint _180 = 0u;
    uint _168 = 0u;
    uint _156 = 0u;
    uint _144 = 0u;
    uint _132 = 0u;
    uint _120 = 0u;
    uint _108 = 0u;
    uint _96 = 0u;
    uint _84 = 0u;
    uint _194 = 0u;
    uint _182 = 0u;
    uint _170 = 0u;
    uint _158 = 0u;
    uint _146 = 0u;
    uint _134 = 0u;
    uint _122 = 0u;
    uint _110 = 0u;
    uint _98 = 0u;
    uint _86 = 0u;
    uint _196 = 0u;
    uint _184 = 0u;
    uint _172 = 0u;
    uint _160 = 0u;
    uint _148 = 0u;
    uint _136 = 0u;
    uint _124 = 0u;
    uint _112 = 0u;
    uint _100 = 0u;
    uint _88 = 0u;
    uint _198 = 0u;
    uint _186 = 0u;
    uint _174 = 0u;
    uint _162 = 0u;
    uint _150 = 0u;
    uint _138 = 0u;
    uint _126 = 0u;
    uint _114 = 0u;
    uint _102 = 0u;
    uint _90 = 0u;
    _79 = uint(0);
    _140 = _79;
    _6._m0[_140] = uint(31 - findMSB(uint(int(true))));
    int _212 = findMSB(uint(8));
    _82 = uint(1);
    _142 = _82;
    _6._m0[_142] = uint(31 - _212);
    _84 = uint(2);
    _144 = _84;
    _6._m0[_144] = uint(31 - findMSB(uint(int(2147483648u))));
    float _228 = clamp(8.75, -2147483648.0, 2147483520.0);
    _86 = uint(3);
    _146 = _86;
    _6._m0[_146] = uint(31 - findMSB(uint(int(_228))));
    _88 = uint(4);
    _148 = _88;
    _6._m0[_148] = uint(findLSB(int(true)) + 1);
    int _245 = findLSB(8);
    _90 = uint(5);
    _150 = _90;
    _6._m0[_150] = uint(_245 + 1);
    _92 = uint(6);
    _152 = _92;
    _6._m0[_152] = uint(findLSB(int(2147483648u)) + 1);
    float _260 = clamp(8.75, -2147483648.0, 2147483520.0);
    _94 = uint(7);
    _154 = _94;
    _6._m0[_154] = uint(findLSB(int(_260)) + 1);
    _96 = uint(8);
    _156 = _96;
    _6._m0[_156] = uint(int(uint(bitCount(uint(true)))));
    int _277 = -1;
    _98 = uint(9);
    _158 = _98;
    _6._m0[_158] = uint(int(uint(bitCount(uint(_277)))));
    uint _286 = uint(bitCount(2147483649u));
    _100 = uint(10);
    _160 = _100;
    _6._m0[_160] = uint(int(_286));
    float _295 = clamp(3.75, 0.0, 4294967040.0);
    _102 = uint(11);
    _162 = _102;
    _6._m0[_162] = uint(int(uint(bitCount(uint(_295)))));
    _104 = uint(12);
    _164 = _104;
    _6._m0[_164] = bitfieldReverse(uint(true));
    int _310 = -1;
    _106 = uint(13);
    _166 = _106;
    _6._m0[_166] = bitfieldReverse(uint(_310));
    uint _317 = bitfieldReverse(19088743u);
    _108 = uint(14);
    _168 = _108;
    _6._m0[_168] = _317;
    float _322 = clamp(2.75, 0.0, 4294967040.0);
    _110 = uint(15);
    _170 = _110;
    _6._m0[_170] = bitfieldReverse(uint(_322));
    _112 = uint(16);
    _172 = _112;
    _6._m0[_172] = uint(_11(2147483649u));
    _114 = uint(17);
    _174 = _114;
    _6._m0[_174] = uint(_18(int(2147483648u)));
    int _343 = findMSB(uint(0));
    _116 = uint(18);
    _176 = _116;
    _6._m0[_176] = uint(31 - _343);
    int _349 = findLSB(0);
    _118 = uint(19);
    _178 = _118;
    _6._m0[_178] = uint(_349 + 1);
    uint _356 = uint(bitCount(4294967295u));
    _120 = uint(20);
    _180 = _120;
    _6._m0[_180] = uint(int(_356));
    uint _363 = bitfieldReverse(0u);
    _122 = uint(21);
    _182 = _122;
    _6._m0[_182] = _363;
    uint _368 = bitfieldReverse(1u);
    _124 = uint(22);
    _184 = _124;
    _6._m0[_184] = _368;
    uint _373 = bitfieldReverse(2147483648u);
    _126 = uint(23);
    _186 = _126;
    _6._m0[_186] = _373;
    int _378 = -2;
    _128 = uint(24);
    _188 = _128;
    _6._m0[_188] = uint(31 - findMSB(uint(_378)));
    int _386 = -2;
    _130 = uint(25);
    _190 = _130;
    _6._m0[_190] = uint(findLSB(_386) + 1);
    uint _394 = uint(bitCount(2863311530u));
    _132 = uint(26);
    _192 = _132;
    _6._m0[_192] = uint(int(_394));
    uint _401 = bitfieldReverse(2863311530u);
    _134 = uint(27);
    _194 = _134;
    _6._m0[_194] = _401;
    _136 = uint(28);
    _196 = _136;
    _6._m0[_196] = uint(_27(3, 4));
    uint _412 = uint(bitCount(3u));
    _138 = uint(29);
    _198 = _138;
    _6._m0[_198] = uint((int(_412) - 3) < 0);
}

