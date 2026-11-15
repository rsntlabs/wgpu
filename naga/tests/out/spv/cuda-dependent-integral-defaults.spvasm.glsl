#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) readonly buffer _14_13
{
    int _m0[];
} _13;

uint _17()
{
    return uint(6);
}

uint _22()
{
    return uint(7);
}

int _27()
{
    return 8;
}

uint _32()
{
    return uint(false);
}

uint _39()
{
    return uint(true);
}

uint _44()
{
    return 7u;
}

uint _48()
{
    return 65535u;
}

uint _52()
{
    return uint(4);
}

int _57()
{
    return 9;
}

uint _62(uint _61)
{
    return _61 + uint(3);
}

void main()
{
    int _160 = 0;
    int _154 = 0;
    int _148 = 0;
    uint _142 = 0u;
    uint _136 = 0u;
    int _130 = 0;
    int _123 = 0;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    int _97 = 0;
    int _156 = 0;
    int _150 = 0;
    uint _144 = 0u;
    int _138 = 0;
    bool _132 = false;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _100 = 0u;
    int _158 = 0;
    int _152 = 0;
    int _146 = 0;
    uint _140 = 0u;
    int _134 = 0;
    bool _127 = false;
    uint _121 = 0u;
    uint _115 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    uint _165 = 4u + (gl_LocalInvocationID.x * 16u);
    _97 = 99;
    _10._m0[_165] = _17();
    _100 = _165 + 1u;
    _10._m0[_100] = _17();
    _103 = _165 + 2u;
    _10._m0[_103] = _17();
    _105 = _165 + 3u;
    _10._m0[_105] = _22();
    _107 = _165 + 4u;
    _10._m0[_107] = uint(_27());
    _109 = _165 + 5u;
    _10._m0[_109] = _32();
    _111 = _165 + 6u;
    _10._m0[_111] = _39();
    _113 = _165 + 7u;
    _10._m0[_113] = _44();
    _115 = _165 + 8u;
    _10._m0[_115] = _48();
    _117 = _165 + 9u;
    _10._m0[_117] = _52();
    _119 = _165 + 10u;
    _10._m0[_119] = uint(_57());
    _121 = _165 + 11u;
    _10._m0[_121] = _62(2u);
    _123 = int(gl_LocalInvocationID.x) + 1;
    _146 = 0;
    _146 = _123;
    _123 += 2;
    _125 = _165 + 12u;
    _10._m0[_125] = uint(_146);
    _127 = false;
    if (false)
    {
        _148 = 0;
        _150 = _123;
        _148 = _150;
        _152 = _123;
        _123 = _152 + 99;
        _130 = _148;
        _127 = _130 != 0;
    }
    _132 = true;
    if (!true)
    {
        _154 = 0;
        _156 = _123;
        _154 = _156;
        _158 = _123;
        _123 = _158 + 99;
        _134 = _154;
        _132 = _134 != 0;
    }
    _160 = 0;
    _160 = _123;
    _123 += 3;
    _136 = _165 + 13u;
    _10._m0[_136] = uint(_123);
    _138 = 0;
    int _253 = _138;
    _138 = _253 + 1;
    _142 = uint(_253);
    _140 = _165 + 14u;
    _10._m0[_140] = _62(uint(_13._m0[_142]));
    _144 = _165 + 15u;
    _10._m0[_144] = uint(_138);
}

