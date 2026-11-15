#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    int _m0[];
} _16;

uvec3 _10 = uvec3(0u);

int _27()
{
    return 4;
}

int _31()
{
    return 5;
}

int _35()
{
    return 7;
}

int _40(int _39)
{
    return _39 + 3;
}

uint _46(uint _45)
{
    return _45 + uint(7);
}

uint _52()
{
    return uint(5);
}

int _57()
{
    return 8;
}

uint _61()
{
    return uint(true) + 4u;
}

int _70()
{
    return 3;
}

int _73()
{
    return 2;
}

int _77()
{
    return 4;
}

int _21(int _20)
{
    return _20 + 10;
}

int _81(uint _80)
{
    return int(_80) + 20;
}

int _89(int _88)
{
    return _88 + 20;
}

int _93()
{
    return int(true);
}

int _99()
{
    return int(false);
}

int _104()
{
    return int(true);
}

void main()
{
    int _222 = 0;
    int _216 = 0;
    int _210 = 0;
    uint _204 = 0u;
    int _198 = 0;
    uint _192 = 0u;
    bool _186 = false;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _167 = 0u;
    uint _161 = 0u;
    uint _155 = 0u;
    uint _149 = 0u;
    int _141 = 0;
    int _218 = 0;
    int _212 = 0;
    int _206 = 0;
    uint _200 = 0u;
    uint _194 = 0u;
    int _188 = 0;
    bool _181 = false;
    int _175 = 0;
    uint _169 = 0u;
    uint _163 = 0u;
    uint _157 = 0u;
    uint _151 = 0u;
    uint _144 = 0u;
    int _220 = 0;
    int _214 = 0;
    int _208 = 0;
    uint _202 = 0u;
    uint _196 = 0u;
    uint _190 = 0u;
    int _184 = 0;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _165 = 0u;
    uint _159 = 0u;
    uint _153 = 0u;
    uint _147 = 0u;
    _10 = gl_LocalInvocationID;
    uint _227 = 4u + (gl_LocalInvocationID.x * 24u);
    _141 = 99;
    _13._m0[_227] = uint(_27());
    _144 = _227 + 1u;
    _13._m0[_144] = uint(_31());
    _147 = _227 + 2u;
    _13._m0[_147] = uint(_35());
    _149 = _227 + 3u;
    _13._m0[_149] = uint(_35());
    _151 = _227 + 4u;
    _13._m0[_151] = uint(_35());
    _153 = _227 + 5u;
    _13._m0[_153] = uint(_40(2));
    _155 = _227 + 6u;
    _13._m0[_155] = _46(3u);
    _157 = _227 + 7u;
    _13._m0[_157] = _52();
    _159 = _227 + 8u;
    _13._m0[_159] = uint(_57());
    _161 = _227 + 9u;
    _13._m0[_161] = _61();
    _163 = _227 + 10u;
    _13._m0[_163] = uint(_70());
    _165 = _227 + 11u;
    _13._m0[_165] = uint(_73());
    _167 = _227 + 12u;
    _13._m0[_167] = uint(_77());
    _169 = _227 + 13u;
    _13._m0[_169] = uint(_21(1));
    _171 = _227 + 14u;
    _13._m0[_171] = uint(_81(1u));
    _173 = _227 + 15u;
    _13._m0[_173] = uint(_89(1));
    _175 = int(gl_LocalInvocationID.x) + 1;
    _206 = 0;
    _206 = _175;
    _175 += 2;
    _177 = _227 + 16u;
    _13._m0[_177] = uint(_206);
    _208 = 0;
    _208 = _175;
    _175 += 3;
    _179 = _227 + 17u;
    _13._m0[_179] = uint(_208);
    _181 = false;
    if (false)
    {
        _210 = 0;
        _212 = _175;
        _210 = _212;
        _214 = _175;
        _175 = _214 + 2;
        _184 = _210;
        _181 = _184 != 0;
    }
    _186 = true;
    if (!true)
    {
        _216 = 0;
        _218 = _175;
        _216 = _218;
        _220 = _175;
        _175 = _220 + 2;
        _188 = _216;
        _186 = _188 != 0;
    }
    _222 = 0;
    _222 = _175;
    _175 += 2;
    _190 = _227 + 18u;
    _13._m0[_190] = uint(_175);
    _192 = _227 + 19u;
    _13._m0[_192] = uint(_93());
    _194 = _227 + 20u;
    _13._m0[_194] = uint(_99());
    _196 = _227 + 21u;
    _13._m0[_196] = uint(_104());
    _198 = 0;
    int _365 = _198;
    _198 = _365 + 1;
    _202 = uint(_365);
    _200 = _227 + 22u;
    _13._m0[_200] = uint(_40(_16._m0[_202]));
    _204 = _227 + 23u;
    _13._m0[_204] = uint(_198);
}

