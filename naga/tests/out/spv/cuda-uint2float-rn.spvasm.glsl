#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _5 _m0;
} _14;

uint _19(uint _18)
{
    return _18;
}

void main()
{
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _52 = 0u;
    uint _81 = 0u;
    uint _75 = 0u;
    uint _69 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _92 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_92 >= _14._m0._m0)
    {
        return;
    }
    uint _98 = 4u + (_92 * 9u);
    uint _101 = _8._m0[_92];
    _52 = 0u;
    uint _105 = 31u - (31u - uint(findMSB(_101 | 1u)));
    uint _106 = min(_105, 23u);
    uint _108 = _105 - _106;
    uint _110 = (_101 << (23u - _106)) >> _108;
    uint _115 = 1u << _108;
    _11._m0[_98] = floatBitsToUint(uintBitsToFloat((_101 != 0u) ? ((((_105 + 127u) << 23u) | (_110 & 8388607u)) + uint((((_101 & (_115 - 1u)) << 1u) | (_110 & 1u)) > _115)) : 0u));
    uint _129 = _19(_101);
    uint _133 = 31u - (31u - uint(findMSB(_129 | 1u)));
    uint _134 = min(_133, 23u);
    uint _136 = _133 - _134;
    uint _138 = (_129 << (23u - _134)) >> _136;
    uint _143 = 1u << _136;
    _55 = _98 + 1u;
    _11._m0[_55] = floatBitsToUint(uintBitsToFloat((_129 != 0u) ? ((((_133 + 127u) << 23u) | (_138 & 8388607u)) + uint((((_129 & (_143 - 1u)) << 1u) | (_138 & 1u)) > _143)) : 0u));
    _52++;
    uint _165 = 31u - (31u - uint(findMSB(_101 | 1u)));
    uint _166 = min(_165, 23u);
    uint _168 = _165 - _166;
    uint _170 = (_101 << (23u - _166)) >> _168;
    uint _175 = 1u << _168;
    _57 = _98 + 2u;
    _11._m0[_57] = floatBitsToUint(uintBitsToFloat((_101 != 0u) ? ((((_165 + 127u) << 23u) | (_170 & 8388607u)) + uint((((_101 & (_175 - 1u)) << 1u) | (_170 & 1u)) > _175)) : 0u));
    _59 = _98 + 3u;
    _11._m0[_59] = _52;
    if ((_92 & 1u) != 0u)
    {
        _77 = _52;
        _52 = _77 + uint(1);
        _79 = _101;
        _63 = _79;
        uint _209 = 31u - (31u - uint(findMSB(_63 | 1u)));
        uint _210 = min(_209, 23u);
        uint _212 = _209 - _210;
        uint _214 = (_63 << (23u - _210)) >> _212;
        uint _219 = 1u << _212;
        _67 = floatBitsToUint(uintBitsToFloat((_63 != 0u) ? ((((_209 + 127u) << 23u) | (_214 & 8388607u)) + uint((((_63 & (_219 - 1u)) << 1u) | (_214 & 1u)) > _219)) : 0u));
    }
    else
    {
        _81 = _52;
        _52 = _81 + uint(1);
        _83 = _101;
        _65 = _83;
        uint _241 = 31u - (31u - uint(findMSB(_65 | 1u)));
        uint _242 = min(_241, 23u);
        uint _244 = _241 - _242;
        uint _246 = (_65 << (23u - _242)) >> _244;
        uint _251 = 1u << _244;
        _67 = floatBitsToUint(uintBitsToFloat((_65 != 0u) ? ((((_241 + 127u) << 23u) | (_246 & 8388607u)) + uint((((_65 & (_251 - 1u)) << 1u) | (_246 & 1u)) > _251)) : 0u));
    }
    _61 = _98 + 4u;
    _11._m0[_61] = _67;
    _69 = _98 + 5u;
    _11._m0[_69] = _52;
    int _272 = -1;
    uint _273 = uint(_272);
    uint _277 = 31u - (31u - uint(findMSB(_273 | 1u)));
    uint _278 = min(_277, 23u);
    uint _280 = _277 - _278;
    uint _282 = (_273 << (23u - _278)) >> _280;
    uint _287 = 1u << _280;
    _71 = _98 + 6u;
    _11._m0[_71] = floatBitsToUint(uintBitsToFloat((_273 != 0u) ? ((((_277 + 127u) << 23u) | (_282 & 8388607u)) + uint((((_273 & (_287 - 1u)) << 1u) | (_282 & 1u)) > _287)) : 0u));
    float _305 = clamp(3.5, 0.0, 4294967040.0);
    uint _306 = uint(_305);
    uint _310 = 31u - (31u - uint(findMSB(_306 | 1u)));
    uint _311 = min(_310, 23u);
    uint _313 = _310 - _311;
    uint _315 = (_306 << (23u - _311)) >> _313;
    uint _320 = 1u << _313;
    _73 = _98 + 7u;
    _11._m0[_73] = floatBitsToUint(uintBitsToFloat((_306 != 0u) ? ((((_310 + 127u) << 23u) | (_315 & 8388607u)) + uint((((_306 & (_320 - 1u)) << 1u) | (_315 & 1u)) > _320)) : 0u));
    uint _339 = 31u - (31u - uint(findMSB(_101 | 1u)));
    uint _340 = min(_339, 23u);
    _75 = _98 + 8u;
    _11._m0[_75] = floatBitsToUint(uintBitsToFloat((_101 != 0u) ? (((_339 + 127u) << 23u) | (((_101 << (23u - _340)) >> (_339 - _340)) & 8388607u)) : 0u));
}

