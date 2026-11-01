#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    int _m0;
    int _m1[2];
};

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

int _16(int _15)
{
    int _19 = 0;
    _19 = _15;
    _19 += 2;
    return _19;
}

void main()
{
    uint _98 = 0u;
    int _91 = 0;
    int _85 = 0;
    int _79 = 0;
    float _72 = 0.0;
    int _66 = 0;
    _7 _103 = _7(0, int[](0, 0));
    bool _95 = false;
    int _89 = 0;
    float _83 = 0.0;
    int _77 = 0;
    int _70 = 0;
    int _64 = 0;
    float _101 = 0.0;
    int _93 = 0;
    int _87 = 0;
    int _81 = 0;
    int _75 = 0;
    int _68 = 0;
    _64 = 1;
    _64 = 5;
    _64 += 2;
    _64 += _64;
    _11._m0[uint(0)] = uint(_64);
    _11._m0[uint(1)] = uint(_64);
    _11._m0[uint(2)] = uint(_64);
    _66 = 1;
    _68 = 2;
    _66 = 5;
    _68 += 2;
    _66 += _68;
    _11._m0[uint(3)] = uint(_66);
    _11._m0[uint(4)] = uint(_68);
    _70 = 3;
    _72 = float(_70);
    _70 = 9;
    _11._m0[uint(5)] = uint(clamp(_72, 0.0, 4294967040.0));
    _11._m0[uint(6)] = uint(_70);
    _11._m0[uint(7)] = uint(_70);
    _75 = 7;
    _11._m0[uint(8)] = uint(_75);
    _77 = 2;
    _79 = 8;
    _77 = _79;
    _79 = 10;
    _11._m0[uint(9)] = uint(_77);
    _11._m0[uint(10)] = uint(_77);
    _11._m0[uint(11)] = uint(_79);
    _81 = 0;
    _83 = 1.5;
    float _174 = clamp(3.75, -2147483648.0, 2147483520.0);
    _85 = int(_174);
    _11._m0[uint(12)] = uint(_81);
    _11._m0[uint(13)] = floatBitsToUint(_83);
    _11._m0[uint(14)] = uint(_85);
    _87 = 1;
    _87++;
    _87 += 3;
    _11._m0[uint(15)] = uint(_87);
    _87 = 9;
    _87 += 2;
    _11._m0[uint(16)] = uint(_87);
    _89 = 3;
    _91 = 4;
    _93 = 0;
    _93++;
    _91 += 5;
    _11._m0[uint(17)] = uint(_89);
    _11._m0[uint(18)] = uint(_91);
    _11._m0[uint(19)] = uint(_93);
    _95 = false;
    _95 = true;
    _11._m0[uint(20)] = uint(_95);
    _98 = 4294901760u;
    _98 += 3u;
    _11._m0[uint(21)] = _98;
    _101 = 2.0;
    _101 *= 0.5;
    _11._m0[uint(22)] = floatBitsToUint(_101);
    _103._m0 = 10;
    _103._m1[0u] = 2;
    _103._m1[1u] = 3;
    _103._m0 = _16(_103._m0);
    _11._m0[uint(23)] = uint(_103._m0);
}

