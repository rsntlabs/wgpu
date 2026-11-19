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
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _54 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _51 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _89 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_89 >= _14._m0._m0)
    {
        return;
    }
    uint _95 = 4u + (_89 * 8u);
    uint _98 = _8._m0[_89];
    _51 = 0u;
    uint _102 = 31u - (31u - uint(findMSB(_98 | 1u)));
    uint _103 = min(_102, 23u);
    _11._m0[_95] = floatBitsToUint(uintBitsToFloat((_98 != 0u) ? (((_102 + 127u) << 23u) | (((_98 << (23u - _103)) >> (_102 - _103)) & 8388607u)) : 0u));
    uint _117 = _19(_98);
    uint _121 = 31u - (31u - uint(findMSB(_117 | 1u)));
    uint _122 = min(_121, 23u);
    _54 = _95 + 1u;
    _11._m0[_54] = floatBitsToUint(uintBitsToFloat((_117 != 0u) ? (((_121 + 127u) << 23u) | (((_117 << (23u - _122)) >> (_121 - _122)) & 8388607u)) : 0u));
    _51++;
    uint _144 = 31u - (31u - uint(findMSB(_98 | 1u)));
    uint _145 = min(_144, 23u);
    _56 = _95 + 2u;
    _11._m0[_56] = floatBitsToUint(uintBitsToFloat((_98 != 0u) ? (((_144 + 127u) << 23u) | (((_98 << (23u - _145)) >> (_144 - _145)) & 8388607u)) : 0u));
    _58 = _95 + 3u;
    _11._m0[_58] = _51;
    if ((_89 & 1u) != 0u)
    {
        _74 = _51;
        _51 = _74 + uint(1);
        _76 = _98;
        _62 = _76;
        uint _179 = 31u - (31u - uint(findMSB(_62 | 1u)));
        uint _180 = min(_179, 23u);
        _66 = floatBitsToUint(uintBitsToFloat((_62 != 0u) ? (((_179 + 127u) << 23u) | (((_62 << (23u - _180)) >> (_179 - _180)) & 8388607u)) : 0u));
    }
    else
    {
        _78 = _51;
        _51 = _78 + uint(1);
        _80 = _98;
        _64 = _80;
        uint _202 = 31u - (31u - uint(findMSB(_64 | 1u)));
        uint _203 = min(_202, 23u);
        _66 = floatBitsToUint(uintBitsToFloat((_64 != 0u) ? (((_202 + 127u) << 23u) | (((_64 << (23u - _203)) >> (_202 - _203)) & 8388607u)) : 0u));
    }
    _60 = _95 + 4u;
    _11._m0[_60] = _66;
    _68 = _95 + 5u;
    _11._m0[_68] = _51;
    int _224 = -1;
    uint _225 = uint(_224);
    uint _229 = 31u - (31u - uint(findMSB(_225 | 1u)));
    uint _230 = min(_229, 23u);
    _70 = _95 + 6u;
    _11._m0[_70] = floatBitsToUint(uintBitsToFloat((_225 != 0u) ? (((_229 + 127u) << 23u) | (((_225 << (23u - _230)) >> (_229 - _230)) & 8388607u)) : 0u));
    float _248 = clamp(3.5, 0.0, 4294967040.0);
    uint _249 = uint(_248);
    uint _253 = 31u - (31u - uint(findMSB(_249 | 1u)));
    uint _254 = min(_253, 23u);
    _72 = _95 + 7u;
    _11._m0[_72] = floatBitsToUint(uintBitsToFloat((_249 != 0u) ? (((_253 + 127u) << 23u) | (((_249 << (23u - _254)) >> (_253 - _254)) & 8388607u)) : 0u));
}

