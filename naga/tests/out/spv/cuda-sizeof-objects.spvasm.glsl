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
    _4 _41[2] = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
    _11 _44 = _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)));
    _11 _47[2] = _11[](_11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))), _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))));
    uint _51 = uint(24ul);
    _15._m0[uint(0)] = _51;
    uint _55 = uint(12ul);
    _15._m0[uint(1)] = _55;
    uint _58 = uint(8ul);
    _15._m0[uint(2)] = _58;
    uint _61 = uint(12ul);
    _15._m0[uint(3)] = _61;
    uint _64 = uint(24ul);
    _15._m0[uint(4)] = _64;
    uint _67 = uint(4ul);
    _15._m0[uint(5)] = _67;
    uint _70 = uint(4ul);
    _15._m0[uint(6)] = _70;
    uint _73 = uint(12ul);
    _15._m0[uint(7)] = _73;
    uint _76 = uint(12ul);
    _15._m0[uint(8)] = _76;
    uint _79 = uint(4ul);
    _15._m0[uint(9)] = _79;
    uint _82 = uint(36ul);
    _15._m0[uint(10)] = _82;
}

