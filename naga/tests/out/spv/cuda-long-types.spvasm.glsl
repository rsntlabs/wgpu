#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint64_t _m0;
};

struct _9
{
    int64_t _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _12_11
{
    int64_t _m0[];
} _11;

layout(set = 0, binding = 1, std430) buffer _15_14
{
    uint64_t _m0[];
} _14;

layout(set = 0, binding = 2, std140) uniform _18_17
{
    _8 _m0;
} _17;

layout(set = 0, binding = 3, std140) uniform _21_20
{
    _9 _m0;
} _20;

int64_t _36(int64_t _35)
{
    return _35;
}

uint _25(int64_t _24)
{
    return 3u;
}

uint _31(int64_t _30)
{
    return 5u;
}

void main()
{
    uint _69 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (uint64_t(_69) >= _17._m0._m0)
    {
        return;
    }
    int64_t _79 = _36(_11._m0[_69] + _20._m0._m0);
    _14._m0[_69] = uint64_t(_79 + 1l) + uint64_t((_25(_79) * 10u) + _31(_79));
}

