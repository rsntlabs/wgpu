#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    int _m0;
    int _m1;
    int _m2;
};

struct _7
{
    int _m0;
};

struct _8
{
    _7 _m0;
};

struct _9
{
    uint _m0;
};

struct _10
{
    _9 _m0;
};

struct _12
{
    float _m0;
};

struct _13
{
    _12 _m0;
};

struct _14
{
    _4 _m0;
};

struct _15
{
    uint _m0;
    uint _m1;
    uint _m2;
};

struct _16
{
    _15 _m0;
};

struct _17
{
    float _m0;
    float _m1;
    float _m2;
};

struct _18
{
    _17 _m0;
};

layout(set = 0, binding = 0, std430) buffer _22_21
{
    uint _m0[];
} _21;

layout(set = 0, binding = 1, std140) uniform _25_24
{
    _8 _m0;
} _24;

layout(set = 0, binding = 2, std140) uniform _28_27
{
    _10 _m0;
} _27;

layout(set = 0, binding = 3, std140) uniform _31_30
{
    _13 _m0;
} _30;

layout(set = 0, binding = 4, std140) uniform _34_33
{
    _14 _m0;
} _33;

layout(set = 0, binding = 5, std140) uniform _37_36
{
    _16 _m0;
} _36;

layout(set = 0, binding = 6, std140) uniform _40_39
{
    _18 _m0;
} _39;

layout(set = 0, binding = 7, std430) readonly buffer _43_42
{
    _17 _m0[];
} _42;

int _47(_4 _46)
{
    _4 _49 = _4(0, 0, 0);
    _49 = _46;
    return _49._m0 + _49._m1;
}

void main()
{
    _17 _147 = _17(0.0, 0.0, 0.0);
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _122 = 0u;
    _12 _116 = _12(0.0);
    _15 _108 = _15(0u, 0u, 0u);
    _9 _100 = _9(0u);
    _17 _145 = _17(0.0, 0.0, 0.0);
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    _17 _120 = _17(0.0, 0.0, 0.0);
    _7 _114 = _7(0);
    _4 _106 = _4(0, 0, 0);
    _7 _97 = _7(0);
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    _15 _118 = _15(0u, 0u, 0u);
    _17 _111 = _17(0.0, 0.0, 0.0);
    _12 _103 = _12(0.0);
    _97 = _24._m0._m0;
    _100 = _27._m0._m0;
    _103 = _30._m0._m0;
    _106 = _33._m0._m0;
    _108 = _36._m0._m0;
    _111 = _39._m0._m0;
    uint _171 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_171 >= 4u)
    {
        return;
    }
    uint _177 = 4u + (_171 * 12u);
    _114 = _97;
    _116 = _103;
    _118 = _108;
    _97._m0 += int(_171);
    _100._m0 += _171;
    _103._m0 += float(_171);
    _106 = _4(_106._m0, _106._m1, _106._m2 + int(_171));
    _108._m0 = _108._m1 + 1u;
    _108._m2 += _171;
    _147 = _42._m0[_171];
    _145 = _147;
    _120 = _145;
    _21._m0[_177] = uint(_97._m0 + 10);
    _122 = _177 + 1u;
    _21._m0[_122] = _100._m0;
    _125 = _177 + 2u;
    _21._m0[_125] = floatBitsToUint(_103._m0);
    _127 = _177 + 3u;
    _21._m0[_127] = uint(_106._m2 + 10);
    _129 = _177 + 4u;
    _21._m0[_129] = uint(_47(_106));
    _131 = _177 + 5u;
    _21._m0[_131] = _108._m0 + _108._m2;
    _133 = _177 + 6u;
    _21._m0[_133] = floatBitsToUint((_111._m0 + _111._m1) + _111._m2);
    _135 = _177 + 7u;
    _21._m0[_135] = uint(_114._m0 + 10);
    _137 = _177 + 8u;
    _21._m0[_137] = _118._m0 + _118._m2;
    _139 = _177 + 9u;
    _21._m0[_139] = floatBitsToUint(_116._m0);
    _141 = _177 + 10u;
    _21._m0[_141] = floatBitsToUint(_120._m2);
    _143 = _177 + 11u;
    _21._m0[_143] = floatBitsToUint(_120._m0 + _111._m0);
}

