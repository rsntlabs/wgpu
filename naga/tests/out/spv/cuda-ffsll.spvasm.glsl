#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    int _m0[];
} _10;

layout(set = 0, binding = 1, std430) readonly buffer _14_13
{
    int64_t _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _8 _m0;
} _16;

int _21(int64_t _20)
{
    uint _28 = uint(_20);
    uint _30 = uint(_20 >> 32u);
    return int((_28 != 0u) ? (min(32u, uint(findLSB(_28))) + 1u) : ((_30 != 0u) ? (min(32u, uint(findLSB(_30))) + 33u) : 0u));
}

void main()
{
    uint _59 = 0u;
    uint _69 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_69 >= _16._m0._m0)
    {
        return;
    }
    _59 = _69 + 4u;
    _10._m0[_59] = _21(_13._m0[_69]);
}

