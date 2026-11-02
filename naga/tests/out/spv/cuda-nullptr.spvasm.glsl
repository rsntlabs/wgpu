#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

shared uint _16[4];

void _36()
{
}

void _19()
{
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
}

uint _25()
{
    return 7u;
}

uint _31(int _30)
{
    return 13u;
}

void main()
{
    uint _141[2] = uint[](0u, 0u);
    uint _135[2] = uint[](0u, 0u);
    uint _129[2] = uint[](0u, 0u);
    uint _123[2] = uint[](0u, 0u);
    uint _117[2] = uint[](0u, 0u);
    uint _111 = 0u;
    uint _105 = 0u;
    uint _99 = 0u;
    uint _93[2] = uint[](0u, 0u);
    uint _87 = 0u;
    uint _81[2] = uint[](0u, 0u);
    uint _74 = 0u;
    uint _68[2] = uint[](0u, 0u);
    uint _62[2] = uint[](0u, 0u);
    uint _54[2] = uint[](0u, 0u);
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89[2] = uint[](0u, 0u);
    uint _83 = 0u;
    uint _76[2] = uint[](0u, 0u);
    uint _70 = 0u;
    uint _64[2] = uint[](0u, 0u);
    uint _57 = 0u;
    uint _145 = 0u;
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    uint _121 = 0u;
    uint _115[2] = uint[](0u, 0u);
    uint _109[2] = uint[](0u, 0u);
    uint _103[2] = uint[](0u, 0u);
    uint _97[2] = uint[](0u, 0u);
    uint _91 = 0u;
    uint _85[2] = uint[](0u, 0u);
    bool _78 = false;
    uint _72[2] = uint[](0u, 0u);
    uint _66 = 0u;
    uint _60[2] = uint[](0u, 0u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _16 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _54 = uint[](0u, 0u);
    _54[0u] = 2u;
    _54[1u] = 0u;
    _57 = 0u;
    _36();
    _57++;
    _60 = uint[](0u, 0u);
    _60[0u] = 1u;
    _16[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 3u;
    _19();
    uint _169 = gl_LocalInvocationID.x * 8u;
    _62 = _54;
    _97 = _62;
    _97[1u] += _169;
    _99 = _97[0u];
    _101 = _97[1u];
    _13._m0[_101] = _16[3u - gl_LocalInvocationID.x];
    _64 = _54;
    _66 = _169 + 1u;
    _103 = _64;
    _103[1u] += _66;
    _105 = _103[0u];
    _107 = _103[1u];
    _13._m0[_107] = _25();
    _68 = _54;
    _70 = _169 + 2u;
    _109 = _68;
    _109[1u] += _70;
    _111 = _109[0u];
    _113 = _109[1u];
    _13._m0[_113] = _31(0);
    _76 = _60;
    _115 = _76;
    _78 = _115[0u] == 1u;
    _72 = _54;
    _74 = _169 + 3u;
    _117 = _72;
    _117[1u] += _74;
    _119 = _117[0u];
    _121 = _117[1u];
    _13._m0[_121] = uint(_78);
    _81 = _54;
    _83 = _169 + 4u;
    _123 = _81;
    _123[1u] += _83;
    _125 = _123[0u];
    _127 = _123[1u];
    _13._m0[_127] = _57;
    _36();
    _85 = _54;
    _87 = _169 + 5u;
    _129 = _85;
    _129[1u] += _87;
    _131 = _129[0u];
    _133 = _129[1u];
    _13._m0[_133] = _25();
    _89 = _54;
    _91 = _169 + 6u;
    _135 = _89;
    _135[1u] += _91;
    _137 = _135[0u];
    _139 = _135[1u];
    _13._m0[_139] = _25();
    _93 = _54;
    _95 = _169 + 7u;
    _141 = _93;
    _141[1u] += _95;
    _143 = _141[0u];
    _145 = _141[1u];
    _13._m0[_145] = uint(false);
}

