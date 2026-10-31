#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _9_8
{
    float _m0[];
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _6 _m0;
} _14;

void main()
{
    float _111 = 0.0;
    uint _105 = 0u;
    uint _99 = 0u;
    uint _93 = 0u;
    uint _87 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _55 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    uint _97 = 0u;
    uint _91 = 0u;
    float _84 = 0.0;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _122 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_122 < _14._m0._m0)
    {
        _55 = _122 * 12u;
        _58 = _55;
        _87 = _58;
        _8._m0[_87] = 1024.5;
        _60 = _55 + 1u;
        _89 = _60;
        _8._m0[_89] = 0.125;
        _62 = _55 + 2u;
        _91 = _62;
        _8._m0[_91] = 12.0;
        _64 = _55 + 3u;
        _93 = _64;
        _8._m0[_93] = 25.0;
        _66 = _55 + 4u;
        _95 = _66;
        _8._m0[_95] = 0.5;
        _68 = _55 + 5u;
        _97 = _68;
        _8._m0[_97] = 6.25;
        float _158 = -1024.5;
        _70 = _55 + 6u;
        _99 = _70;
        _8._m0[_99] = _158;
        _72 = _55 + 7u;
        _101 = _72;
        _8._m0[_101] = 0.125;
        _74 = _55 + 8u;
        _103 = _74;
        _8._m0[_103] = 3.1415927410125732421875;
        _76 = _55 + 9u;
        _105 = _76;
        _8._m0[_105] = 1.0;
        _78 = _55 + 10u;
        _107 = _78;
        _8._m0[_107] = 1.0000002384185791015625;
        _82 = _122;
        _109 = _82;
        _111 = _11._m0[_109];
        _84 = _111;
        _80 = _55 + 11u;
        _113 = _80;
        _8._m0[_113] = (_84 * 0.25) + 10.0;
    }
}

