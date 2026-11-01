#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _13
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) readonly buffer _23_22
{
    int _m0[];
} _22;

layout(set = 0, binding = 1, std430) buffer _26_25
{
    uint _m0[];
} _25;

int _30(int _29)
{
    int _45 = 0;
    int _38 = 0;
    int _42[3] = int[](0, 0, 0);
    int _35 = 0;
    int _40 = 0;
    uvec2 _64 = uvec2(4294967295u);
    _35 = _29;
    _38 = 3;
    _42 = int[](0, 0, 0);
    _45 = 0;
    int _47 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _64)))
        {
            break;
        }
        _64 -= uvec2(uint(_64.y == 0u), 1u);
        if (!(_47 < _38))
        {
            break;
        }
        _42[_47] = _35 + _47;
        _45 += _42[_47];
        _47++;
        continue;
    }
    return _45;
}

void main()
{
    uint _202 = 0u;
    int _196 = 0;
    int _190 = 0;
    int _183[2] = int[](0, 0);
    bool _176 = false;
    bool _170 = false;
    int _164 = 0;
    int _157 = 0;
    uint _151 = 0u;
    int _145 = 0;
    int _137[5] = int[](0, 0, 0, 0, 0);
    int _131 = 0;
    int _198 = 0;
    int _192[3] = int[](0, 0, 0);
    uint _186 = 0u;
    int _178 = 0;
    bool _172 = false;
    int _166 = 0;
    uint _159 = 0u;
    uint _153 = 0u;
    uint _147 = 0u;
    int _140 = 0;
    int _133 = 0;
    uint _200 = 0u;
    uint _194 = 0u;
    _13 _180[2] = _13[](_13(0.0, 0.0, 0.0), _13(0.0, 0.0, 0.0));
    bool _174 = false;
    int _168 = 0;
    bool _161 = false;
    uint _155 = 0u;
    uint _149 = 0u;
    uint _142 = 0u;
    int _135 = 0;
    uvec2 _329 = uvec2(4294967295u);
    uint _205 = uint(0);
    int _208 = _22._m0[_205];
    _131 = 3;
    _135 = 4;
    _137 = int[](0, 0, 0, 0, 0);
    _137[0u] = _208;
    _137[_135] = _22._m0[uint(1)];
    _25._m0[uint(0)] = uint(2);
    _25._m0[uint(1)] = 2147483648u;
    _25._m0[uint(2)] = floatBitsToUint(0.5);
    _25._m0[uint(3)] = uint(_131);
    _25._m0[uint(4)] = uint(_30(_208));
    _25._m0[uint(5)] = uint(_137[_135]);
    _25._m0[uint(6)] = uint(_137[1u]);
    _25._m0[uint(7)] = uint(clamp(float(_208) * 0.5, 0.0, 4294967040.0));
    _140 = int(0x80000000);
    _145 = -2;
    _149 = 4294967295u;
    _151 = 0u;
    _25._m0[uint(8)] = uint(_140);
    _25._m0[uint(9)] = uint(_145);
    _25._m0[uint(10)] = _149;
    _25._m0[uint(11)] = _151;
    _155 = 0u;
    _157 = int(0x80000000);
    _159 = 4294967040u;
    _161 = true;
    _25._m0[uint(12)] = _155;
    _25._m0[uint(13)] = uint(_157);
    _25._m0[uint(14)] = _159;
    _25._m0[uint(15)] = uint(_161);
    _164 = 4;
    _166 = 6;
    _25._m0[uint(16)] = uint(_164);
    _25._m0[uint(17)] = uint(_166);
    _25._m0[uint(18)] = uint(_208);
    _170 = false;
    _174 = true;
    _25._m0[uint(19)] = uint(_170);
    _25._m0[uint(20)] = uint(_174);
    _25._m0[uint(21)] = uint(_208);
    _178 = 2;
    _180 = _13[](_13(0.0, 0.0, 0.0), _13(0.0, 0.0, 0.0));
    _180[1u]._m1 = float(_22._m0[uint(1)]);
    _25._m0[uint(22)] = uint(clamp(_180[1u]._m1, 0.0, 4294967040.0));
    _183 = int[](0, 0);
    _186 = uint(23);
    _200 = _186;
    _25._m0[_200] = uint(_183[1u]);
    int _188 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _329)))
        {
            break;
        }
        _329 -= uvec2(uint(_329.y == 0u), 1u);
        if (!(_188 < 3))
        {
            break;
        }
        _190 = 3;
        _192 = int[](0, 0, 0);
        _194 = uint(24 + _188);
        _202 = _194;
        _25._m0[_202] = uint(_192[2u]);
        _192[2u] = _208 + _188;
        _188++;
        continue;
    }
    _25._m0[uint(27)] = uint(_30(_22._m0[uint(1)]));
    _25._m0[uint(28)] = uint(3);
    _196 = 3;
    _25._m0[uint(29)] = uint(((_208 + _22._m0[uint(1)]) + _196) - 3);
}

