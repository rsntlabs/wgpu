#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _7 _m0;
} _15;

float _20(float _19)
{
    return _19;
}

void main()
{
    int _96 = 0;
    float _90 = 0.0;
    uint _84 = 0u;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    float _94 = 0.0;
    uint _88 = 0u;
    int _81 = 0;
    uint _75 = 0u;
    float _69 = 0.0;
    uint _62 = 0u;
    uint _55 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _79 = 0u;
    uint _73 = 0u;
    float _66 = 0.0;
    uint _60 = 0u;
    uint _105 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_105 >= _15._m0._m0)
    {
        return;
    }
    uint _110 = 4u + (_105 * 10u);
    uint _113 = _9._m0[_105];
    float _114 = uintBitsToFloat(_113);
    _55 = 0u;
    _12._m0[_110] = uint(clamp(_114, 0.0, 4294967040.0));
    _58 = _110 + 1u;
    _12._m0[_58] = uint(clamp(_20(_114), 0.0, 4294967040.0));
    _55++;
    _60 = _110 + 2u;
    _12._m0[_60] = uint(clamp(_114, 0.0, 4294967040.0));
    _62 = _110 + 3u;
    _12._m0[_62] = _55;
    if ((_105 & 1u) != 0u)
    {
        _88 = _55;
        _55 = _88 + uint(1);
        _90 = _114;
        _66 = _90;
        _71 = uint(clamp(_66, 0.0, 4294967040.0));
    }
    else
    {
        _92 = _55;
        _55 = _92 + uint(1);
        _94 = _114;
        _69 = _94;
        _71 = uint(clamp(_69, 0.0, 4294967040.0));
    }
    _64 = _110 + 4u;
    _12._m0[_64] = _71;
    _73 = _110 + 5u;
    _12._m0[_73] = _55;
    float _167 = float(16777217u);
    _75 = _110 + 6u;
    _12._m0[_75] = uint(clamp(_167, 0.0, 4294967040.0));
    float _173 = float(2147483649u);
    _77 = _110 + 7u;
    _12._m0[_77] = uint(clamp(_173, 0.0, 4294967040.0));
    _79 = _110 + 8u;
    _12._m0[_79] = uint(clamp(float(true), 0.0, 4294967040.0));
    _81 = 7;
    _96 = 0;
    _96 = 3;
    _86 = uint(_81 + _96);
    _84 = _110 + 9u;
    _12._m0[_84] = _86;
}

