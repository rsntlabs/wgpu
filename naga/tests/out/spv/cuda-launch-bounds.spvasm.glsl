///////////////////////////////////
// Entry point: "bounded" (comp) //
///////////////////////////////////
#version 460
layout(local_size_x = 2, local_size_y = 3, local_size_z = 2) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    uint _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _6 _m0;
} _19;

layout(set = 0, binding = 0, std430) buffer _23_22
{
    uint _m0[];
} _22;

layout(set = 0, binding = 1, std430) readonly buffer _26_25
{
    uint _m0[];
} _25;

layout(set = 0, binding = 2, std140) uniform _29_28
{
    _6 _m0;
} _28;

uvec3 _9 = uvec3(0u);
uvec3 _12 = uvec3(0u);

uint _33(uint _32)
{
    return (_32 * 3u) + 7u;
}

void main()
{
    uint _132[2] = uint[](0u, 0u);
    uint _126[2] = uint[](0u, 0u);
    uint _120[2] = uint[](0u, 0u);
    uint _114[2] = uint[](0u, 0u);
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90[2] = uint[](0u, 0u);
    uint _84 = 0u;
    uint _78 = 0u;
    uint _71 = 0u;
    uint _65[2] = uint[](0u, 0u);
    uint _58[2] = uint[](0u, 0u);
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98[2] = uint[](0u, 0u);
    uint _92 = 0u;
    uint _86[2] = uint[](0u, 0u);
    uint _80 = 0u;
    uint _74 = 0u;
    uint _67[2] = uint[](0u, 0u);
    uint _61[2] = uint[](0u, 0u);
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106[2] = uint[](0u, 0u);
    uint _100 = 0u;
    uint _94[2] = uint[](0u, 0u);
    uint _88 = 0u;
    uint _82[2] = uint[](0u, 0u);
    uint _76 = 0u;
    uint _69[2] = uint[](0u, 0u);
    uint _63[2] = uint[](0u, 0u);
    _58 = uint[](0u, 0u);
    _58[0u] = 2u;
    _58[1u] = 0u;
    _61 = uint[](0u, 0u);
    _61[0u] = 3u;
    _61[1u] = 0u;
    _9 = gl_LocalInvocationID;
    _12 = gl_WorkGroupID;
    _63 = _58;
    _65 = _61;
    _71 = 0u;
    _74 = 0u;
    _76 = 0u;
    _78 = 0u;
    _80 = 0u;
    _84 = 0u;
    _88 = 0u;
    _92 = 0u;
    _96 = 0u;
    _100 = 0u;
    _102 = 0u;
    _67 = _63;
    _69 = _65;
    _71 = _19._m0._m0;
    uint _150 = 2u * 3u;
    _74 = _150 * 2u;
    _76 = _9.x + (2u * (_9.y + (3u * _9.z)));
    _78 = (_12.x * _74) + _76;
    if (_78 < _71)
    {
        _80 = _78 * 4u;
        _86 = _69;
        _88 = _78;
        _106 = _86;
        _106[1u] += _88;
        _108 = _106[0u];
        _110 = _106[1u];
        _112 = _16._m0[_110];
        _104 = _112;
        _102 = _104;
        _82 = _67;
        _84 = _80;
        _114 = _82;
        _114[1u] += _84;
        _116 = _114[0u];
        _118 = _114[1u];
        _13._m0[_118] = _33(_102);
        _90 = _67;
        _92 = _80 + 1u;
        _120 = _90;
        _120[1u] += _92;
        _122 = _120[0u];
        _124 = _120[1u];
        _13._m0[_124] = _74;
        _94 = _67;
        _96 = _80 + 2u;
        _126 = _94;
        _126[1u] += _96;
        _128 = _126[0u];
        _130 = _126[1u];
        _13._m0[_130] = _76;
        _98 = _67;
        _100 = _80 + 3u;
        _132 = _98;
        _132[1u] += _100;
        _134 = _132[0u];
        _136 = _132[1u];
        _13._m0[_136] = _12.x;
    }
}


/////////////////////////////////////////////////
// Entry point: "bounded_template<12u>" (comp) //
/////////////////////////////////////////////////
#version 460
layout(local_size_x = 2, local_size_y = 3, local_size_z = 2) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    uint _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _6 _m0;
} _19;

layout(set = 0, binding = 0, std430) buffer _23_22
{
    uint _m0[];
} _22;

layout(set = 0, binding = 1, std430) readonly buffer _26_25
{
    uint _m0[];
} _25;

layout(set = 0, binding = 2, std140) uniform _29_28
{
    _6 _m0;
} _28;

uvec3 _9 = uvec3(0u);
uvec3 _12 = uvec3(0u);

uint _33(uint _32)
{
    return (_32 * 3u) + 7u;
}

void main()
{
    uint _340[2] = uint[](0u, 0u);
    uint _334[2] = uint[](0u, 0u);
    uint _328[2] = uint[](0u, 0u);
    uint _322[2] = uint[](0u, 0u);
    uint _316 = 0u;
    uint _310 = 0u;
    uint _304 = 0u;
    uint _298[2] = uint[](0u, 0u);
    uint _292 = 0u;
    uint _286 = 0u;
    uint _280 = 0u;
    uint _274[2] = uint[](0u, 0u);
    uint _268[2] = uint[](0u, 0u);
    uint _342 = 0u;
    uint _336 = 0u;
    uint _330 = 0u;
    uint _324 = 0u;
    uint _318 = 0u;
    uint _312 = 0u;
    uint _306[2] = uint[](0u, 0u);
    uint _300 = 0u;
    uint _294[2] = uint[](0u, 0u);
    uint _288 = 0u;
    uint _282 = 0u;
    uint _276[2] = uint[](0u, 0u);
    uint _270[2] = uint[](0u, 0u);
    uint _344 = 0u;
    uint _338 = 0u;
    uint _332 = 0u;
    uint _326 = 0u;
    uint _320 = 0u;
    uint _314[2] = uint[](0u, 0u);
    uint _308 = 0u;
    uint _302[2] = uint[](0u, 0u);
    uint _296 = 0u;
    uint _290[2] = uint[](0u, 0u);
    uint _284 = 0u;
    uint _278[2] = uint[](0u, 0u);
    uint _272[2] = uint[](0u, 0u);
    _268 = uint[](0u, 0u);
    _268[0u] = 2u;
    _268[1u] = 0u;
    _270 = uint[](0u, 0u);
    _270[0u] = 3u;
    _270[1u] = 0u;
    _9 = gl_LocalInvocationID;
    _12 = gl_WorkGroupID;
    _272 = _268;
    _274 = _270;
    _280 = 0u;
    _282 = 0u;
    _284 = 0u;
    _286 = 0u;
    _288 = 0u;
    _292 = 0u;
    _296 = 0u;
    _300 = 0u;
    _304 = 0u;
    _308 = 0u;
    _310 = 0u;
    _276 = _272;
    _278 = _274;
    _280 = _28._m0._m0;
    uint _357 = 2u * 3u;
    _282 = _357 * 2u;
    _284 = _9.x + (2u * (_9.y + (3u * _9.z)));
    _286 = (_12.x * _282) + _284;
    if (_286 < _280)
    {
        _288 = _286 * 4u;
        _294 = _278;
        _296 = _286;
        _314 = _294;
        _314[1u] += _296;
        _316 = _314[0u];
        _318 = _314[1u];
        _320 = _25._m0[_318];
        _312 = _320;
        _310 = _312;
        _290 = _276;
        _292 = _288;
        _322 = _290;
        _322[1u] += _292;
        _324 = _322[0u];
        _326 = _322[1u];
        _22._m0[_326] = _33(_310);
        _298 = _276;
        _300 = _288 + 1u;
        _328 = _298;
        _328[1u] += _300;
        _330 = _328[0u];
        _332 = _328[1u];
        _22._m0[_332] = _282;
        _302 = _276;
        _304 = _288 + 2u;
        _334 = _302;
        _334[1u] += _304;
        _336 = _334[0u];
        _338 = _334[1u];
        _22._m0[_338] = _284;
        _306 = _276;
        _308 = _288 + 3u;
        _340 = _306;
        _340[1u] += _308;
        _342 = _340[0u];
        _344 = _340[1u];
        _22._m0[_344] = _12.x;
    }
}

