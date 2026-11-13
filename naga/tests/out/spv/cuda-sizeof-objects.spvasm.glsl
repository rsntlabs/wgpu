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
    _4 _61[2] = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
    _11 _64 = _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0)));
    _11 _67[2] = _11[](_11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))), _11(_4(0.0, 0.0, 0.0), int[][](int[](0, 0, 0), int[](0, 0, 0))));
    uint _71 = uint(24ul);
    _15._m0[uint(0)] = _71;
    uint _75 = uint(12ul);
    _15._m0[uint(1)] = _75;
    uint _78 = uint(8ul);
    _15._m0[uint(2)] = _78;
    uint _81 = uint(12ul);
    _15._m0[uint(3)] = _81;
    uint _84 = uint(24ul);
    _15._m0[uint(4)] = _84;
    uint _87 = uint(4ul);
    _15._m0[uint(5)] = _87;
    uint _90 = uint(4ul);
    _15._m0[uint(6)] = _90;
    uint _93 = uint(12ul);
    _15._m0[uint(7)] = _93;
    uint _96 = uint(12ul);
    _15._m0[uint(8)] = _96;
    uint _99 = uint(4ul);
    _15._m0[uint(9)] = _99;
    uint _102 = uint(36ul);
    _15._m0[uint(10)] = _102;
    uint _105 = uint(24ul);
    _15._m0[uint(11)] = _105;
    uint _108 = uint(24ul);
    _15._m0[uint(12)] = _108;
    uint _111 = uint(12ul);
    _15._m0[uint(13)] = _111;
    uint _114 = uint(12ul);
    _15._m0[uint(14)] = _114;
    uint _117 = uint(8ul);
    _15._m0[uint(15)] = _117;
    uint _120 = uint(1ul);
    _15._m0[uint(16)] = _120;
    uint _123 = uint(8ul);
    _15._m0[uint(17)] = _123;
    uint _126 = uint(4ul);
    _15._m0[uint(18)] = _126;
    uint _129 = uint(4ul);
    _15._m0[uint(19)] = _129;
    uint _132 = uint(1ul);
    _15._m0[uint(20)] = _132;
    uint _135 = uint(4ul);
    _15._m0[uint(21)] = _135;
    uint _138 = uint(8ul);
    _15._m0[uint(22)] = _138;
    uint _141 = uint(8ul);
    _15._m0[uint(23)] = _141;
    uint _144 = uint(12ul);
    _15._m0[uint(24)] = _144;
    uint _147 = uint(12ul);
    _15._m0[uint(25)] = _147;
    uint _150 = uint(12ul);
    _15._m0[uint(26)] = _150;
    uint _153 = uint(4ul);
    _15._m0[uint(27)] = _153;
    uint _156 = uint(4ul);
    _15._m0[uint(28)] = _156;
    uint _159 = uint(4ul);
    _15._m0[uint(29)] = _159;
}

