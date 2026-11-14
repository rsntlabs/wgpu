#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
    float _m1;
    float _m2;
};

struct _9
{
    _4 _m0;
    int _m1[3];
};

struct _12
{
    int _m0;
    _4 _m1;
    int _m2[2][3];
    _9 _m3;
};

struct _14
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _17_16
{
    uint _m0[];
} _16;

void main()
{
    uint _60 = 0u;
    uint _54 = 0u;
    _12 _45 = _12(0, _4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)), _9(_4(0.0, 0.0, 0.0), int[](0, 0, 0)));
    uint _62 = 0u;
    uint _56 = 0u;
    _14 _48 = _14(0u);
    uint _64 = 0u;
    uint _58 = 0u;
    uint _51 = 0u;
    _45._m0 = int(gl_LocalInvocationID.x + 3u);
    _45._m1 = _4(1.0, 2.0, float(gl_LocalInvocationID.x + 5u));
    _45._m2[1u][2u] = int(gl_LocalInvocationID.x + 9u);
    _45._m3._m1[2u] = int(gl_LocalInvocationID.x + 15u);
    _48._m0 = gl_LocalInvocationID.x + 21u;
    uint _89 = 4u + (gl_LocalInvocationID.x * 8u);
    _16._m0[_89] = uint(_45._m0);
    _51 = _89 + 1u;
    _16._m0[_51] = uint(clamp(_45._m1._m2, 0.0, 4294967040.0));
    _54 = _89 + 2u;
    _16._m0[_54] = uint(_45._m2[1u][2u]);
    _56 = _89 + 3u;
    _16._m0[_56] = uint(_45._m3._m1[2u]);
    uint _117 = uint(64ul);
    _58 = _89 + 4u;
    _16._m0[_58] = _117;
    uint _121 = uint(24ul);
    _60 = _89 + 5u;
    _16._m0[_60] = _121;
    uint _125 = uint(12ul);
    _62 = _89 + 6u;
    _16._m0[_62] = _125;
    _64 = _89 + 7u;
    _16._m0[_64] = _48._m0;
}

