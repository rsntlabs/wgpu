#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    int _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _7 _m0;
} _16;

int _21(int _20)
{
    return _20;
}

void main()
{
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    int _80 = 0;
    uint _74 = 0u;
    int _68 = 0;
    uint _61 = 0u;
    uint _54 = 0u;
    int _84 = 0;
    uint _78 = 0u;
    uint _72 = 0u;
    int _65 = 0;
    uint _59 = 0u;
    uint _93 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_93 >= _16._m0._m0)
    {
        return;
    }
    uint _99 = 4u + (_93 * 8u);
    int _102 = _10._m0[_93];
    _54 = 0u;
    uint _103 = uint(_102);
    uint _104 = _103 >> 31u;
    uint _108 = (_103 ^ ((_104 != 0u) ? 4294967295u : 0u)) + _104;
    uint _112 = 31u - (31u - uint(findMSB(_108 | 1u)));
    uint _113 = min(_112, 23u);
    _13._m0[_99] = floatBitsToUint(uintBitsToFloat((_108 != 0u) ? ((_104 << 31u) | (((_112 + 127u) << 23u) | (((_108 << (23u - _113)) >> (_112 - _113)) & 8388607u))) : 0u));
    uint _131 = uint(_21(_102));
    uint _132 = _131 >> 31u;
    uint _136 = (_131 ^ ((_132 != 0u) ? 4294967295u : 0u)) + _132;
    uint _140 = 31u - (31u - uint(findMSB(_136 | 1u)));
    uint _141 = min(_140, 23u);
    _57 = _99 + 1u;
    _13._m0[_57] = floatBitsToUint(uintBitsToFloat((_136 != 0u) ? ((_132 << 31u) | (((_140 + 127u) << 23u) | (((_136 << (23u - _141)) >> (_140 - _141)) & 8388607u))) : 0u));
    _54++;
    uint _162 = uint(_102);
    uint _163 = _162 >> 31u;
    uint _167 = (_162 ^ ((_163 != 0u) ? 4294967295u : 0u)) + _163;
    uint _171 = 31u - (31u - uint(findMSB(_167 | 1u)));
    uint _172 = min(_171, 23u);
    _59 = _99 + 2u;
    _13._m0[_59] = floatBitsToUint(uintBitsToFloat((_167 != 0u) ? ((_163 << 31u) | (((_171 + 127u) << 23u) | (((_167 << (23u - _172)) >> (_171 - _172)) & 8388607u))) : 0u));
    _61 = _99 + 3u;
    _13._m0[_61] = _54;
    if ((_93 & 1u) != 0u)
    {
        _78 = _54;
        _54 = _78 + uint(1);
        _80 = _102;
        _65 = _80;
        uint _205 = uint(_65);
        uint _206 = _205 >> 31u;
        uint _210 = (_205 ^ ((_206 != 0u) ? 4294967295u : 0u)) + _206;
        uint _214 = 31u - (31u - uint(findMSB(_210 | 1u)));
        uint _215 = min(_214, 23u);
        _70 = floatBitsToUint(uintBitsToFloat((_210 != 0u) ? ((_206 << 31u) | (((_214 + 127u) << 23u) | (((_210 << (23u - _215)) >> (_214 - _215)) & 8388607u))) : 0u));
    }
    else
    {
        _82 = _54;
        _54 = _82 + uint(1);
        _84 = _102;
        _68 = _84;
        uint _236 = uint(_68);
        uint _237 = _236 >> 31u;
        uint _241 = (_236 ^ ((_237 != 0u) ? 4294967295u : 0u)) + _237;
        uint _245 = 31u - (31u - uint(findMSB(_241 | 1u)));
        uint _246 = min(_245, 23u);
        _70 = floatBitsToUint(uintBitsToFloat((_241 != 0u) ? ((_237 << 31u) | (((_245 + 127u) << 23u) | (((_241 << (23u - _246)) >> (_245 - _246)) & 8388607u))) : 0u));
    }
    _63 = _99 + 4u;
    _13._m0[_63] = _70;
    _72 = _99 + 5u;
    _13._m0[_72] = _54;
    uint _270 = uint(int(4294967295u));
    uint _271 = _270 >> 31u;
    uint _275 = (_270 ^ ((_271 != 0u) ? 4294967295u : 0u)) + _271;
    uint _279 = 31u - (31u - uint(findMSB(_275 | 1u)));
    uint _280 = min(_279, 23u);
    _74 = _99 + 6u;
    _13._m0[_74] = floatBitsToUint(uintBitsToFloat((_275 != 0u) ? ((_271 << 31u) | (((_279 + 127u) << 23u) | (((_275 << (23u - _280)) >> (_279 - _280)) & 8388607u))) : 0u));
    float _298 = -3.5;
    uint _303 = uint(int(clamp(_298, -2147483648.0, 2147483520.0)));
    uint _304 = _303 >> 31u;
    uint _308 = (_303 ^ ((_304 != 0u) ? 4294967295u : 0u)) + _304;
    uint _312 = 31u - (31u - uint(findMSB(_308 | 1u)));
    uint _313 = min(_312, 23u);
    _76 = _99 + 7u;
    _13._m0[_76] = floatBitsToUint(uintBitsToFloat((_308 != 0u) ? ((_304 << 31u) | (((_312 + 127u) << 23u) | (((_308 << (23u - _313)) >> (_312 - _313)) & 8388607u))) : 0u));
}

