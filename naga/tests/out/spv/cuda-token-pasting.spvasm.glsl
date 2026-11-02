#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _6_5
{
    uint _m0[];
} _5;

uint _10(uint _9)
{
    return _9 + 3u;
}

void main()
{
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _67 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    _67 = 7u;
    _70 = 11u;
    _72 = 13u;
    _74 = 17u;
    _5._m0[uint(0)] = _67;
    _5._m0[uint(1)] = _70;
    _5._m0[uint(2)] = _72;
    _5._m0[uint(3)] = _74;
    _5._m0[uint(4)] = 23u;
    _5._m0[uint(5)] = 42u;
    _5._m0[uint(6)] = floatBitsToUint(1.5);
    _5._m0[uint(7)] = floatBitsToUint(4.0);
    if (3u <= 4u)
    {
        _76 = 1u;
    }
    else
    {
        _76 = 0u;
    }
    _5._m0[uint(8)] = _76;
    uint _120 = 32u >> 2u;
    _5._m0[uint(9)] = _120;
    _78 = 9u;
    _78 += 5u;
    _5._m0[uint(10)] = _78;
    _5._m0[uint(11)] = uint(63);
    _5._m0[uint(12)] = 29u;
    _5._m0[uint(13)] = _10(5u);
    _5._m0[uint(14)] = 19u;
    _5._m0[uint(15)] = 21u;
    uint _140 = 4u + 5u;
    _5._m0[uint(16)] = _140;
    _5._m0[uint(17)] = 23u;
    _80 = 10u;
    _5._m0[uint(18)] = (3u + _80) + 2u;
    uint _150 = 2u + 3u;
    _5._m0[uint(19)] = _150;
    _82 = 0u;
    _82++;
    _84 = 0u;
    _84 = 7u;
    _82++;
    _5._m0[uint(20)] = _84;
    _5._m0[uint(21)] = _82;
    _82++;
    _86 = 0u;
    _86 = 9u;
    _82++;
    _5._m0[uint(22)] = _86;
    _5._m0[uint(23)] = _82;
}

