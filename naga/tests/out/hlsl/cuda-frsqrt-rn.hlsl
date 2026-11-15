ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint _naga_frsqrt_rn(uint input_bits)
{
    uint significand = (uint)0;
    uint trial_bit = (uint)0;

    uint _e7 = (input_bits & 2147483647u);
    uint _e8 = (input_bits & 2147483648u);
    if ((_e7 == 0u)) {
        return (_e8 | 2139095040u);
    }
    if (((_e8 != 0u) || (_e7 > 2139095040u))) {
        return 2143289344u;
    }
    if ((_e7 == 2139095040u)) {
        return 0u;
    }
    uint _e18 = (_e7 >> 23u);
    uint _e19 = (_e7 & 8388607u);
    bool _e20 = (_e18 != 0u);
    uint _e25 = ((31u - firstbithigh((_e19 | 1u))) - 8u);
    uint _e29 = (_e20 ? (_e19 | 8388608u) : (_e19 << (_e25 & 31u)));
    int _e35 = (_e20 ? int(_e18) : asint(asuint(int(1)) - asuint(int(_e25))));
    int _e37 = asint(asuint(_e35) - asuint(int(127)));
    int _e46 = asint(asuint((naga_neg(asint(asuint(_e37) + asuint(int(1)))) >> 1u)) + asuint(int((((_e37 & int(1)) == int(0)) && (_e29 == 8388608u)))));
    uint _e52 = uint(asint(asuint(asint(asuint(int(198)) - asuint(_e35))) - asuint(asint(asuint(_e46) * asuint(int(2))))));
    significand = 8388608u;
    trial_bit = 22u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e56 = significand;
        uint _e57 = trial_bit;
        uint _e60 = (_e56 | (1u << (_e57 & 31u)));
        uint _e61 = (_e60 << 1u);
        uint _e65 = (_e61 & 4095u);
        uint _e66 = (_e61 >> 12u);
        uint _e67 = (_e65 * _e65);
        uint _e71 = ((2u * (_e65 * _e66)) + (_e67 >> 12u));
        uint _e74 = ((_e66 * _e66) + (_e71 >> 12u));
        uint _e75 = (_e67 & 4095u);
        uint _e76 = (_e71 & 4095u);
        uint _e77 = (_e74 & 4095u);
        uint _e79 = ((_e74 >> 12u) & 4095u);
        uint _e81 = (_e74 >> 24u);
        uint _e82 = (_e29 & 4095u);
        uint _e83 = (_e29 >> 12u);
        uint _e108 = (((_e83 * _e81) + ((((_e82 * _e81) + (_e83 * _e79)) + ((((_e82 * _e79) + (_e83 * _e77)) + ((((_e82 * _e77) + (_e83 * _e76)) + ((((_e82 * _e76) + (_e83 * _e75)) + ((_e82 * _e75) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
        significand = ((((71u + uint((_e108 != 0u))) + uint((_e108 >= 2u))) < _e52) ? _e60 : _e56);
        if ((_e57 == 0u)) {
            break;
        }
        trial_bit = (_e57 - 1u);
    }
    uint _e121 = significand;
    uint _e123 = ((_e121 << 1u) + 1u);
    uint _e127 = (_e123 & 4095u);
    uint _e128 = (_e123 >> 12u);
    uint _e129 = (_e127 * _e127);
    uint _e133 = ((2u * (_e127 * _e128)) + (_e129 >> 12u));
    uint _e136 = ((_e128 * _e128) + (_e133 >> 12u));
    uint _e137 = (_e129 & 4095u);
    uint _e138 = (_e133 & 4095u);
    uint _e139 = (_e136 & 4095u);
    uint _e141 = ((_e136 >> 12u) & 4095u);
    uint _e143 = (_e136 >> 24u);
    uint _e144 = (_e29 & 4095u);
    uint _e145 = (_e29 >> 12u);
    uint _e170 = (((_e145 * _e143) + ((((_e144 * _e143) + (_e145 * _e141)) + ((((_e144 * _e141) + (_e145 * _e139)) + ((((_e144 * _e139) + (_e145 * _e138)) + ((((_e144 * _e138) + (_e145 * _e137)) + ((_e144 * _e137) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
    uint _e181 = (_e121 + uint((((71u + uint((_e170 != 0u))) + uint((_e170 >= 2u))) < _e52)));
    bool _e183 = (_e181 >= 16777216u);
    return ((uint(asint(asuint(asint(asuint(_e46) + asuint(int(_e183)))) + asuint(int(127)))) << 23u) | ((_e183 ? (_e181 >> 1u) : _e181) & 8388607u));
}

float reciprocal_sqrt_value(float value)
{
    const uint _e2 = _naga_frsqrt_rn(asuint(value));
    return asfloat(_e2);
}

int _frsqrt_rn(bool value_1)
{
    int local_14 = (int)0;

    if (value_1) {
        local_14 = int(7);
    } else {
        local_14 = int(9);
    }
    int _e6 = local_14;
    return _e6;
}

uint _naga_fabsf(uint input_bits_1)
{
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

[numthreads(32, 1, 1)]
void reciprocal_sqrt_round_nearest(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    int cursor = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    bool local_3 = (bool)0;
    bool local_4 = (bool)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    float local_12 = (float)0;
    uint local_13 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint _e15 = asuint(input.Load(index*4));
    float value_2 = asfloat(_e15);
    const uint _e18 = _naga_frsqrt_rn(asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e18))));
    const float _e23 = reciprocal_sqrt_value(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    output.Store(_e29*4, asuint(asuint(_e23)));
    cursor = int(0);
    int _e33 = cursor;
    cursor = asint(asuint(_e33) + asuint(int(1)));
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = asuint(input.Load(_e40*4));
    const float _e44 = reciprocal_sqrt_value(asfloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(asuint(_e44)));
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = asint(asuint(_e54) + asuint(int(1)));
        const uint _e59 = _naga_frsqrt_rn(asuint(float(_e54)));
        const uint _e62 = _naga_fabsf(asuint(asfloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = asint(asuint(_e67) + asuint(int(1)));
        const uint _e72 = _naga_frsqrt_rn(asuint(float(_e67)));
        const uint _e75 = _naga_fabsf(asuint(asfloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    output.Store(_e84*4, asuint(uint(_e78)));
    const uint _e89 = _naga_frsqrt_rn(asuint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    output.Store(_e96*4, asuint(asuint(asfloat(_e89))));
    local_8 = 2139095040u;
    uint _e100 = local_8;
    const uint _e103 = _naga_frsqrt_rn(asuint(asfloat(_e100)));
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    output.Store(_e110*4, asuint(asuint(asfloat(_e103))));
    const float _e114 = reciprocal_sqrt_value(float(4u));
    local_9 = uint((base + 6u));
    uint _e120 = local_9;
    output.Store(_e120*4, asuint(asuint(_e114)));
    const int _e123 = _frsqrt_rn(true);
    local_10 = uint((base + 7u));
    uint _e129 = local_10;
    output.Store(_e129*4, asuint(uint(_e123)));
    if (true) {
        const uint _e133 = _naga_frsqrt_rn(asuint(value_2));
        local_12 = asfloat(_e133);
    } else {
        int _e136 = cursor;
        cursor = asint(asuint(_e136) + asuint(int(1)));
        const uint _e141 = _naga_frsqrt_rn(asuint(float(_e136)));
        local_12 = asfloat(_e141);
    }
    float _e145 = local_12;
    local_11 = uint((base + 8u));
    uint _e151 = local_11;
    output.Store(_e151*4, asuint(asuint(_e145)));
    int _e153 = cursor;
    local_13 = uint((base + 9u));
    uint _e159 = local_13;
    output.Store(_e159*4, asuint(uint(_e153)));
}
