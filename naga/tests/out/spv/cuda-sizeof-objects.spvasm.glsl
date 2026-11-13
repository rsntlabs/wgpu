#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

void main()
{
    _6 _26[2] = _6[](_6(0.0, 0.0, 0.0), _6(0.0, 0.0, 0.0));
    uint _30 = uint(24ul);
    _9._m0[uint(0)] = _30;
    uint _34 = uint(12ul);
    _9._m0[uint(1)] = _34;
    uint _37 = uint(8ul);
    _9._m0[uint(2)] = _37;
}

