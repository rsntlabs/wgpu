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
    uint _158 = 0u;
    uint _152 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    float _121 = 0.0;
    uint _115 = 0u;
    uint _109 = 0u;
    int _103 = 0;
    uint _97 = 0u;
    int _90 = 0;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _71 = 0u;
    uint _160 = 0u;
    uint _154 = 0u;
    uint _148 = 0u;
    uint _142 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    int _99 = 0;
    uint _93 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _156 = 0u;
    int _150 = 0;
    uint _144 = 0u;
    uint _138 = 0u;
    int _132 = 0;
    uint _126 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    int _95 = 0;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    _71 = uint(0);
    _7._m0[_71] = uint(floatBitsToInt(float(true)));
    float _172 = float(3);
    _74 = uint(1);
    _7._m0[_74] = uint(floatBitsToInt(_172));
    float _178 = float(5u);
    _76 = uint(2);
    _7._m0[_76] = uint(floatBitsToInt(_178));
    _78 = uint(3);
    _7._m0[_78] = uint(floatBitsToInt(2.75));
    _80 = uint(4);
    _7._m0[_80] = floatBitsToUint(float(true));
    float _194 = float(3);
    _82 = uint(5);
    _7._m0[_82] = floatBitsToUint(_194);
    float _199 = float(5u);
    _84 = uint(6);
    _7._m0[_84] = floatBitsToUint(_199);
    _86 = uint(7);
    _7._m0[_86] = floatBitsToUint(2.75);
    _90 = int(true);
    _88 = uint(8);
    _7._m0[_88] = floatBitsToUint(intBitsToFloat(_90));
    _95 = 3;
    _93 = uint(9);
    _7._m0[_93] = floatBitsToUint(intBitsToFloat(_95));
    _99 = int(5u);
    _97 = uint(10);
    _7._m0[_97] = floatBitsToUint(intBitsToFloat(_99));
    float _230 = clamp(2.75, -2147483648.0, 2147483520.0);
    _103 = int(_230);
    _101 = uint(11);
    _7._m0[_101] = floatBitsToUint(intBitsToFloat(_103));
    _107 = uint(true);
    _105 = uint(12);
    _7._m0[_105] = floatBitsToUint(uintBitsToFloat(_107));
    _111 = uint(3);
    _109 = uint(13);
    _7._m0[_109] = floatBitsToUint(uintBitsToFloat(_111));
    _115 = 5u;
    _113 = uint(14);
    _7._m0[_113] = floatBitsToUint(uintBitsToFloat(_115));
    float _259 = clamp(2.75, 0.0, 4294967040.0);
    _119 = uint(_259);
    _117 = uint(15);
    _7._m0[_117] = floatBitsToUint(uintBitsToFloat(_119));
    _121 = 1.5;
    float _267 = _121;
    float _268 = float(1);
    _121 = _267 + _268;
    _124 = uint(16);
    _7._m0[_124] = uint(floatBitsToInt(_267));
    _126 = uint(17);
    _7._m0[_126] = floatBitsToUint(_121);
    float _280 = _121;
    float _281 = float(1);
    _121 = _280 + _281;
    _128 = uint(18);
    _7._m0[_128] = floatBitsToUint(_280);
    _130 = uint(19);
    _7._m0[_130] = floatBitsToUint(_121);
    _132 = 1065353216;
    int _292 = _132;
    _132 = _292 + 1;
    _134 = uint(20);
    _7._m0[_134] = floatBitsToUint(intBitsToFloat(_292));
    _136 = uint(21);
    _7._m0[_136] = uint(_132);
    _138 = 1073741824u;
    uint _304 = _138;
    _138 = _304 + uint(1);
    _140 = uint(22);
    _7._m0[_140] = floatBitsToUint(uintBitsToFloat(_304));
    _142 = uint(23);
    _7._m0[_142] = _138;
    _144 = uint(24);
    _7._m0[_144] = uint(_19(3, 4));
    _146 = uint(25);
    _7._m0[_146] = floatBitsToUint(_12(3212836864u));
    _150 = 2139095040;
    _148 = uint(26);
    _7._m0[_148] = floatBitsToUint(intBitsToFloat(_150));
    _154 = 2143363909u;
    _152 = uint(27);
    _7._m0[_152] = floatBitsToUint(uintBitsToFloat(_154));
    float _338 = clamp(1065353216.0, 0.0, 4294967040.0);
    _158 = uint(_338);
    _156 = uint(28);
    _7._m0[_156] = floatBitsToUint(uintBitsToFloat(_158));
    float _346 = float(1u);
    _160 = uint(29);
    _7._m0[_160] = uint(floatBitsToInt(_346));
}

