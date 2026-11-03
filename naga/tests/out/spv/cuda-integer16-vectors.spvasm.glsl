#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_16bit_storage : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    int16_t _m0;
    int16_t _m1;
    int16_t _m2;
};

struct _10
{
    uint16_t _m0;
};

struct _15
{
    uint16_t _m0;
    uint16_t _m1;
    uint16_t _m2;
};

layout(set = 0, binding = 0, std430) readonly buffer _18_17
{
    _4 _m0[];
} _17;

layout(set = 0, binding = 1, std430) buffer _21_20
{
    _4 _m0[];
} _20;

layout(set = 0, binding = 2, std430) buffer _24_23
{
    uint _m0[];
} _23;

layout(set = 0, binding = 3, std140) uniform _27_26
{
    _10 _m0;
} _26;

_4 _43(_4 _42)
{
    _4 _45 = _4(0s, 0s, 0s);
    _45 = _42;
    return _45;
}

u16vec4 _52(u16vec4 _51)
{
    u16vec4 _54 = u16vec4(0);
    _54 = _51;
    return _54;
}

uint _31(int _30)
{
    return 31u;
}

uint _37(uint16_t _36)
{
    return 43u;
}

void main()
{
    _4 _153 = _4(0s, 0s, 0s);
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    _4 _116 = _4(0s, 0s, 0s);
    u16vec2 _108 = u16vec2(0);
    i16vec2 _100 = i16vec2(0);
    _4 _151 = _4(0s, 0s, 0s);
    uint _145 = 0u;
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    uint _121 = 0u;
    u16vec4 _114 = u16vec4(0);
    i16vec4 _106 = i16vec4(0);
    _4 _98 = _4(0s, 0s, 0s);
    _4 _155 = _4(0s, 0s, 0s);
    _4 _149 = _4(0s, 0s, 0s);
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _118 = 0u;
    _15 _111 = _15(0us, 0us, 0us);
    i16vec4 _103 = i16vec4(0);
    uint _164 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_164 >= uint(_26._m0._m0))
    {
        return;
    }
    _155 = _17._m0[_164];
    _149 = _155;
    _98 = _43(_149);
    _100 = i16vec2(_98._m0, _98._m1);
    _103 = i16vec4(_98._m0, _98._m1, _98._m2, int16_t(7));
    _106 = _103;
    _106.w = int16_t(int(_106.w) + int(_98._m0));
    _108 = u16vec2(uint16_t(_98._m0), uint16_t(_98._m1));
    _108.x = uint16_t(int(uint(_108.x)) + 1);
    _108.y = uint16_t(int(uint(_108.y)) + 1);
    _111 = _15(uint16_t(_98._m0), uint16_t(_98._m1), uint16_t(_98._m2));
    _114 = _52(u16vec4(uint16_t(_98._m2), uint16_t(_98._m1), uint16_t(_98._m0), uint16_t(65535u)));
    _114.w = uint16_t(int(uint(_114.w)) + 2);
    _151 = _4(0s, 0s, 0s);
    _153 = _98;
    _151 = _153;
    _151._m0 = int16_t(int(_151._m0) + 3);
    _151._m1 = int16_t(-int(_151._m1));
    _151._m2 = int16_t(int(_151._m2) ^ 4951);
    _116 = _151;
    _20._m0[_164] = _116;
    uint _274 = _164 * 16u;
    _23._m0[_274] = uint(_100.x);
    _118 = _274 + 1u;
    _23._m0[_118] = uint(_100.y);
    _121 = _274 + 2u;
    _23._m0[_121] = uint(_106.x);
    _123 = _274 + 3u;
    _23._m0[_123] = uint(_106.y);
    _125 = _274 + 4u;
    _23._m0[_125] = uint(_106.z);
    _127 = _274 + 5u;
    _23._m0[_127] = uint(_106.w);
    _129 = _274 + 6u;
    _23._m0[_129] = uint(_108.x);
    _131 = _274 + 7u;
    _23._m0[_131] = uint(_108.y);
    _133 = _274 + 8u;
    _23._m0[_133] = uint(int(uint(_111._m0)) + (3 * int(uint(_111._m1))));
    _135 = _274 + 9u;
    _23._m0[_135] = uint(_111._m2);
    _137 = _274 + 10u;
    _23._m0[_137] = uint(_114.x);
    _139 = _274 + 11u;
    _23._m0[_139] = uint(_114.y);
    _141 = _274 + 12u;
    _23._m0[_141] = uint(_114.z);
    _143 = _274 + 13u;
    _23._m0[_143] = uint(_114.w);
    _145 = _274 + 14u;
    _23._m0[_145] = _31(int(uint(_111._m0)));
    _147 = _274 + 15u;
    _23._m0[_147] = _37(_111._m2);
}

