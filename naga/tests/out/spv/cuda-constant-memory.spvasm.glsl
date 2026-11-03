///////////////////////////////////////////
// Entry point: "constant_memory" (comp) //
///////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

struct _8
{
    uint _m0;
};

layout(set = 1, binding = 0, std430) readonly buffer _13_12
{
    uint _m0;
} _12;

layout(set = 1, binding = 1, std430) readonly buffer _16_15
{
    uint _m0[4];
} _15;

layout(set = 1, binding = 2, std430) readonly buffer _19_18
{
    _4 _m0;
} _18;

layout(set = 0, binding = 0, std430) buffer _22_21
{
    uint _m0[];
} _21;

layout(set = 0, binding = 1, std430) readonly buffer _25_24
{
    uint _m0[];
} _24;

layout(set = 0, binding = 2, std140) uniform _28_27
{
    _8 _m0;
} _27;

layout(set = 0, binding = 0, std430) buffer _31_30
{
    uint _m0[];
} _30;

layout(set = 0, binding = 1, std430) readonly buffer _34_33
{
    uint _m0[];
} _33;

layout(set = 0, binding = 2, std140) uniform _37_36
{
    _8 _m0;
} _36;

uint _71(uint _72, uint _73)
{
    return _72 % ((_73 == 0u) ? 1u : _73);
}

uint _42(uint _40, uint _41)
{
    uint _52 = 0u;
    uint _55 = 0u;
    uint _57 = 0u;
    _52 = 0u;
    _55 = 0u;
    _57 = 0u;
    _52 = _41;
    _55 = _52;
    _57 = _15._m0[_55];
    return ((_40 * _18._m0._m0) + _57) + _12._m0;
}

void main()
{
    uint _133 = 0u;
    uint _127 = 0u;
    uint _121[2] = uint[](0u, 0u);
    uint _115 = 0u;
    uint _109[2] = uint[](0u, 0u);
    uint _103[2] = uint[](0u, 0u);
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119[2] = uint[](0u, 0u);
    uint _113 = 0u;
    uint _107 = 0u;
    uint _100[2] = uint[](0u, 0u);
    uint _129[2] = uint[](0u, 0u);
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105[2] = uint[](0u, 0u);
    _100 = uint[](0u, 0u);
    _100[0u] = 2u;
    _100[1u] = 0u;
    _103 = uint[](0u, 0u);
    _103[0u] = 3u;
    _103[1u] = 0u;
    uint _146 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_146 < _27._m0._m0)
    {
        _109 = _103;
        _111 = _146;
        _121 = _109;
        _121[1u] += _111;
        _123 = _121[0u];
        _125 = _121[1u];
        _127 = _24._m0[_125];
        _117 = _127;
        _119 = uint[](0u, 0u);
        _119[0u] = 4u;
        _119[1u] = 0u;
        _113 = 31u;
        _115 = 41u;
        _105 = _100;
        _107 = _146;
        _129 = _105;
        _129[1u] += _107;
        _131 = _129[0u];
        _133 = _129[1u];
        _21._m0[_133] = ((_42(_117, _71(_146, 4u)) + _18._m0._m1) + _113) + _115;
    }
}


///////////////////////////////////////////////
// Entry point: "constant_references" (comp) //
///////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

struct _8
{
    uint _m0;
};

layout(set = 1, binding = 0, std430) readonly buffer _13_12
{
    uint _m0;
} _12;

layout(set = 1, binding = 1, std430) readonly buffer _16_15
{
    uint _m0[4];
} _15;

layout(set = 1, binding = 2, std430) readonly buffer _19_18
{
    _4 _m0;
} _18;

layout(set = 0, binding = 0, std430) buffer _22_21
{
    uint _m0[];
} _21;

layout(set = 0, binding = 1, std430) readonly buffer _25_24
{
    uint _m0[];
} _24;

layout(set = 0, binding = 2, std140) uniform _28_27
{
    _8 _m0;
} _27;

layout(set = 0, binding = 0, std430) buffer _31_30
{
    uint _m0[];
} _30;

layout(set = 0, binding = 1, std430) readonly buffer _34_33
{
    uint _m0[];
} _33;

layout(set = 0, binding = 2, std140) uniform _37_36
{
    _8 _m0;
} _36;

uint _71(uint _72, uint _73)
{
    return _72 % ((_73 == 0u) ? 1u : _73);
}

void main()
{
    uint _249 = 0u;
    uint _243 = 0u;
    uint _237 = 0u;
    uint _231 = 0u;
    uint _225 = 0u;
    uint _219 = 0u;
    uint _213[2] = uint[](0u, 0u);
    uint _206[2] = uint[](0u, 0u);
    uint _247[2] = uint[](0u, 0u);
    uint _241[2] = uint[](0u, 0u);
    uint _235[2] = uint[](0u, 0u);
    uint _229 = 0u;
    uint _223[2] = uint[](0u, 0u);
    uint _217[2] = uint[](0u, 0u);
    uint _211[2] = uint[](0u, 0u);
    uint _204[2] = uint[](0u, 0u);
    uint _251 = 0u;
    uint _245 = 0u;
    uint _239 = 0u;
    uint _233[2] = uint[](0u, 0u);
    uint _227[2] = uint[](0u, 0u);
    uint _221 = 0u;
    uint _215[2] = uint[](0u, 0u);
    _4 _208 = _4(0u, 0u);
    _204 = uint[](0u, 0u);
    _204[0u] = 2u;
    _204[1u] = 0u;
    _206 = uint[](0u, 0u);
    _206[0u] = 3u;
    _206[1u] = 0u;
    uint _263 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_263 >= _36._m0._m0)
    {
        return;
    }
    _208 = _18._m0;
    _211 = uint[](0u, 0u);
    _211[0u] = 4u;
    _211[1u] = 0u;
    _215 = _206;
    _225 = 0u;
    _229 = 0u;
    _231 = 0u;
    _223 = uint[](0u, 0u);
    _223[0u] = 4u;
    _223[1u] = 0u;
    _225 = _71(_263 + 1u, 4u);
    _227 = _223;
    _229 = _225;
    _235 = _227;
    _235[1u] += _229;
    _237 = _235[0u];
    _239 = _235[1u];
    _231 = _15._m0[_239];
    _241 = _215;
    _241[1u] += _263;
    _243 = _241[0u];
    _245 = _241[1u];
    _217 = _211;
    _233 = _217;
    _219 = 37u;
    _221 = 43u;
    _213 = _204;
    _247 = _213;
    _247[1u] += _263;
    _249 = _247[0u];
    _251 = _247[1u];
    _30._m0[_251] = (((((_33._m0[_245] + _231) + _12._m0) + _208._m0) + _208._m1) + _219) + _221;
}

