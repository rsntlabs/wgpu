#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint64_t _m0[];
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    uint64_t _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _6 _m0;
} _14;

uint64_t _19(uint64_t _18)
{
    return (uint64_t(bitfieldReverse(uint(_18))) << 32u) | uint64_t(bitfieldReverse(uint(_18 >> 32u)));
}

void main()
{
    uint _48 = 0u;
    uint _58 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_58 >= _14._m0._m0)
    {
        return;
    }
    _48 = _58 + 4u;
    _8._m0[_48] = _19(_11._m0[_58]);
}

