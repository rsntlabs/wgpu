#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _10_9
{
    int _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    uint64_t _m0[];
} _12;

int _17(uint64_t _16)
{
    return int(uint(bitCount(uint(_16))) + uint(bitCount(uint(_16 >> 32u))));
}

void main()
{
    _9._m0[gl_LocalInvocationID.x] = _17(_12._m0[gl_LocalInvocationID.x]);
}

