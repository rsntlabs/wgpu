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
    _4 _45[2] = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
    _11 _48 = _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)));
    _11 _51[2] = _11[](_11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))), _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))));
    uint _55 = uint(24ul);
    _15._m0[uint(0)] = _55;
    uint _59 = uint(12ul);
    _15._m0[uint(1)] = _59;
    uint _62 = uint(8ul);
    _15._m0[uint(2)] = _62;
    uint _65 = uint(12ul);
    _15._m0[uint(3)] = _65;
    uint _68 = uint(24ul);
    _15._m0[uint(4)] = _68;
    uint _71 = uint(4ul);
    _15._m0[uint(5)] = _71;
    uint _74 = uint(4ul);
    _15._m0[uint(6)] = _74;
    uint _77 = uint(12ul);
    _15._m0[uint(7)] = _77;
    uint _80 = uint(12ul);
    _15._m0[uint(8)] = _80;
    uint _83 = uint(4ul);
    _15._m0[uint(9)] = _83;
    uint _86 = uint(36ul);
    _15._m0[uint(10)] = _86;
    uint _89 = uint(24ul);
    _15._m0[uint(11)] = _89;
    uint _92 = uint(24ul);
    _15._m0[uint(12)] = _92;
    uint _95 = uint(12ul);
    _15._m0[uint(13)] = _95;
    uint _98 = uint(12ul);
    _15._m0[uint(14)] = _98;
}

