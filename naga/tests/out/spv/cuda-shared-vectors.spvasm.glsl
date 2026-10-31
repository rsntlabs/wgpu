#version 460
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    float _m0[];
} _13;

shared _4 _16[8];
shared _4 _18;

uint _43(uint _45, uint _46)
{
    return _45 % ((_46 == 0u) ? 1u : _46);
}

_4 _22(_4 _21)
{
    _4 _25 = _4(0.0, 0.0, 0.0);
    _25 = _21;
    _25._m0 += 1.0;
    _25._m1 = _25._m2 - _25._m1;
    return _25;
}

void main()
{
    uint _169[2] = uint[](0u, 0u);
    uint _163[2] = uint[](0u, 0u);
    uint _157[2] = uint[](0u, 0u);
    uint _151[2] = uint[](0u, 0u);
    uint _145[2] = uint[](0u, 0u);
    uint _139[2] = uint[](0u, 0u);
    uint _133[2] = uint[](0u, 0u);
    uint _127[2] = uint[](0u, 0u);
    uint _121[2] = uint[](0u, 0u);
    uint _115 = 0u;
    uint _109[2] = uint[](0u, 0u);
    uint _103 = 0u;
    uint _97[2] = uint[](0u, 0u);
    uint _91 = 0u;
    uint _84[2] = uint[](0u, 0u);
    uint _76[2] = uint[](0u, 0u);
    uint _171 = 0u;
    uint _165 = 0u;
    uint _159 = 0u;
    uint _153 = 0u;
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    uint _117[2] = uint[](0u, 0u);
    uint _111 = 0u;
    uint _105[2] = uint[](0u, 0u);
    uint _99 = 0u;
    uint _93[2] = uint[](0u, 0u);
    uint _86 = 0u;
    _4 _79 = _4(0.0, 0.0, 0.0);
    uint _173 = 0u;
    uint _167 = 0u;
    uint _161 = 0u;
    uint _155 = 0u;
    uint _149 = 0u;
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113[2] = uint[](0u, 0u);
    uint _107 = 0u;
    uint _101[2] = uint[](0u, 0u);
    uint _95 = 0u;
    uint _89[2] = uint[](0u, 0u);
    int _81 = 0;
    if (gl_LocalInvocationIndex == 0u)
    {
        _16 = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
        _18 = _4(0.0, 0.0, 0.0);
    }
    barrier();
    _76 = uint[](0u, 0u);
    _76[0u] = 0u;
    _76[1u] = 0u;
    float _192 = float((gl_WorkGroupID.x * 16u) + gl_LocalInvocationID.x);
    _16[gl_LocalInvocationID.x] = _4(_192 + 0.5, (-_192) - 1.25, _192 + 2.5);
    if (gl_LocalInvocationID.x == 0u)
    {
        _18 = _4(float(gl_WorkGroupID.x) + 0.25, float(gl_WorkGroupID.x) + 0.5, float(gl_WorkGroupID.x) + 0.75);
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _211 = _43(gl_LocalInvocationID.x + 1u, 8u);
    _79 = _22(_16[_211]);
    _81 = 1;
    _79._m0 += float(_81);
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    if ((gl_LocalInvocationID.x & 1u) != 0u)
    {
        _16[gl_LocalInvocationID.x]._m1 += _18._m0;
    }
    else
    {
        _79._m1 += _18._m0;
    }
    _16[gl_LocalInvocationID.x]._m2 = _79._m0;
    uint _244 = ((gl_WorkGroupID.x * 8u) + gl_LocalInvocationID.x) * 9u;
    _84 = _76;
    _86 = _244;
    _121 = _84;
    _121[1u] += _86;
    _123 = _121[0u];
    _125 = _121[1u];
    _13._m0[_125] = _79._m0;
    _89 = _76;
    _91 = _244 + 1u;
    _127 = _89;
    _127[1u] += _91;
    _129 = _127[0u];
    _131 = _127[1u];
    _13._m0[_131] = _79._m1;
    _93 = _76;
    _95 = _244 + 2u;
    _133 = _93;
    _133[1u] += _95;
    _135 = _133[0u];
    _137 = _133[1u];
    _13._m0[_137] = _79._m2;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _97 = _76;
    _99 = _244 + 3u;
    _139 = _97;
    _139[1u] += _99;
    _141 = _139[0u];
    _143 = _139[1u];
    _13._m0[_143] = _16[_211]._m0;
    _101 = _76;
    _103 = _244 + 4u;
    _145 = _101;
    _145[1u] += _103;
    _147 = _145[0u];
    _149 = _145[1u];
    _13._m0[_149] = _16[_211]._m1;
    _105 = _76;
    _107 = _244 + 5u;
    _151 = _105;
    _151[1u] += _107;
    _153 = _151[0u];
    _155 = _151[1u];
    _13._m0[_155] = _16[_211]._m2;
    _109 = _76;
    _111 = _244 + 6u;
    _157 = _109;
    _157[1u] += _111;
    _159 = _157[0u];
    _161 = _157[1u];
    _13._m0[_161] = _18._m0;
    _113 = _76;
    _115 = _244 + 7u;
    _163 = _113;
    _163[1u] += _115;
    _165 = _163[0u];
    _167 = _163[1u];
    _13._m0[_167] = _18._m1;
    _117 = _76;
    _119 = _244 + 8u;
    _169 = _117;
    _169[1u] += _119;
    _171 = _169[0u];
    _173 = _169[1u];
    _13._m0[_173] = _18._m2;
}

