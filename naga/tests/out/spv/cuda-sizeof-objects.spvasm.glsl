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
    _4 _50[2] = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
    _11 _53 = _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)));
    _11 _56[2] = _11[](_11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))), _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))));
    uint _60 = uint(24ul);
    _15._m0[uint(0)] = _60;
    uint _64 = uint(12ul);
    _15._m0[uint(1)] = _64;
    uint _67 = uint(8ul);
    _15._m0[uint(2)] = _67;
    uint _70 = uint(12ul);
    _15._m0[uint(3)] = _70;
    uint _73 = uint(24ul);
    _15._m0[uint(4)] = _73;
    uint _76 = uint(4ul);
    _15._m0[uint(5)] = _76;
    uint _79 = uint(4ul);
    _15._m0[uint(6)] = _79;
    uint _82 = uint(12ul);
    _15._m0[uint(7)] = _82;
    uint _85 = uint(12ul);
    _15._m0[uint(8)] = _85;
    uint _88 = uint(4ul);
    _15._m0[uint(9)] = _88;
    uint _91 = uint(36ul);
    _15._m0[uint(10)] = _91;
    uint _94 = uint(24ul);
    _15._m0[uint(11)] = _94;
    uint _97 = uint(24ul);
    _15._m0[uint(12)] = _97;
    uint _100 = uint(12ul);
    _15._m0[uint(13)] = _100;
    uint _103 = uint(12ul);
    _15._m0[uint(14)] = _103;
    uint _106 = uint(8ul);
    _15._m0[uint(15)] = _106;
    uint _109 = uint(1ul);
    _15._m0[uint(16)] = _109;
    uint _112 = uint(8ul);
    _15._m0[uint(17)] = _112;
    uint _115 = uint(4ul);
    _15._m0[uint(18)] = _115;
}

