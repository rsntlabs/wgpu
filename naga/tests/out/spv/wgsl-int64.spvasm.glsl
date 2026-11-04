#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _14
{
    uint _m0;
    int _m1;
    float _m2;
    uint64_t _m3;
    u64vec2 _m4;
    u64vec3 _m5;
    u64vec4 _m6;
    int64_t _m7;
    i64vec2 _m8;
    i64vec3 _m9;
    i64vec4 _m10;
    uint64_t _m11;
};

struct _18
{
    uint64_t _m0[2];
    int64_t _m1[2];
};

layout(set = 0, binding = 0, std140) uniform _24_23
{
    _14 _m0;
} _23;

layout(set = 0, binding = 1, std430) readonly buffer _27_26
{
    _14 _m0;
} _26;

layout(set = 0, binding = 2, std430) readonly buffer _30_29
{
    _18 _m0;
} _29;

layout(set = 0, binding = 3, std430) buffer _33_32
{
    _14 _m0;
} _32;

layout(set = 0, binding = 4, std430) buffer _36_35
{
    _18 _m0;
} _35;

int64_t _21 = 1l;

uint64_t _219(uint64_t _218)
{
    uint64_t _228 = 20ul;
    _228 += 31ul;
    _228 += (_228 + 5ul);
    _228 += uint64_t(_23._m0._m0 + uint(_228));
    _228 += uint64_t(_23._m0._m1 + int(uint(_228)));
    _228 += uint64_t(clamp(_23._m0._m2 + float(_228), 0.0, 18446742974197923840.0));
    _228 += u64vec3(_23._m0._m3).z;
    _228 += uint64_t(_23._m0._m7);
    _228 += u64vec2(_23._m0._m8).y;
    _228 += u64vec3(_23._m0._m9).z;
    _228 += u64vec4(_23._m0._m10).w;
    _32._m0._m3 = _23._m0._m3 + _26._m0._m3;
    _32._m0._m4 = _23._m0._m4 + _26._m0._m4;
    _32._m0._m5 = _23._m0._m5 + _26._m0._m5;
    _32._m0._m6 = _23._m0._m6 + _26._m0._m6;
    _35._m0._m0 = _29._m0._m0;
    uint64_t _328 = _228;
    _228 += _328;
    _228 += min(max(_228, _228), _228);
    u64vec2 _339 = u64vec2(_228);
    u64vec2 _341 = u64vec2(_228);
    _228 += ((0ul + (_339.x * _341.x)) + (_339.y * _341.y));
    _228 += max(_228, _228);
    _228 += min(_228, _228);
    return _228;
}

int64_t _40(int64_t _39)
{
    int64_t _55 = 20l;
    _55 += 9222370033850770834l;
    _55 += (_55 + 5l);
    _55 += int64_t(uint64_t(_23._m0._m0 + uint(_55)));
    _55 += int64_t(_23._m0._m1 + int(_55));
    _55 += int64_t(clamp(_23._m0._m2 + float(_55), -9223372036854775808.0, 9223371487098961920.0));
    _55 += i64vec3(_23._m0._m7).z;
    _55 += int64_t(_23._m0._m3);
    _55 += i64vec2(_23._m0._m4).y;
    _55 += i64vec3(_23._m0._m5).z;
    _55 += i64vec4(_23._m0._m6).w;
    _55 += int64_t(0x8000000000000000ul);
    _32._m0._m7 = _23._m0._m7 + _26._m0._m7;
    _32._m0._m8 = _23._m0._m8 + _26._m0._m8;
    _32._m0._m9 = _23._m0._m9 + _26._m0._m9;
    _32._m0._m10 = _23._m0._m10 + _26._m0._m10;
    _35._m0._m1 = _29._m0._m1;
    _55 += abs(_55);
    _55 += min(max(_55, _55), _55);
    i64vec2 _189 = i64vec2(_55);
    i64vec2 _191 = i64vec2(_55);
    _55 += ((0l + (_189.x * _191.x)) + (_189.y * _191.y));
    _55 += max(_55, _55);
    _55 += min(_55, _55);
    _55 += sign(_55);
    return _55;
}

void main()
{
    uint64_t _374 = _219(67ul);
    int64_t _375 = _40(60l);
    _32._m0._m11 = _374 + uint64_t(_375);
}

