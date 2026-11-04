#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint64_t _m0;
};

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint64_t _m0[];
} _8;

layout(set = 0, binding = 1, std140) uniform _12_11
{
    _5 _m0;
} _11;

uint64_t _15()
{
    return 12ul;
}

void main()
{
    _8._m0[(gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x] = (((_11._m0._m0 + _15()) + 24ul) * 8ul) + 8ul;
}

