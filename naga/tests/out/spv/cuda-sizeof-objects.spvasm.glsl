#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
    float _m1;
    float _m2;
};

struct _11
{
    _4 _m0;
    int _m1[2][3];
};

layout(set = 0, binding = 0, std430) buffer _16_15
{
    uint _m0[];
} _15;

void main()
{
    _4 _36[2] = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
    _11 _39 = _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)));
    _11 _42[2] = _11[](_11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))), _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))));
    uint _46 = uint(24ul);
    _15._m0[uint(0)] = _46;
    uint _50 = uint(12ul);
    _15._m0[uint(1)] = _50;
    uint _53 = uint(8ul);
    _15._m0[uint(2)] = _53;
    uint _56 = uint(12ul);
    _15._m0[uint(3)] = _56;
    uint _59 = uint(24ul);
    _15._m0[uint(4)] = _59;
    uint _62 = uint(4ul);
    _15._m0[uint(5)] = _62;
    uint _65 = uint(4ul);
    _15._m0[uint(6)] = _65;
}

