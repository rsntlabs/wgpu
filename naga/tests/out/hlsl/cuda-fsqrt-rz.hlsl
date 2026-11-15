ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_sqrtf_rz(uint input_bits)
{
    uint significand = (uint)0;
    uint adjusted_exponent = (uint)0;
    uint upper_word = (uint)0;
    uint lower_word = (uint)0;
    uint root = (uint)0;
    uint remainder = (uint)0;
    uint iteration = (uint)0;

    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = ((31u - firstbithigh(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    return (((_e33 >> 1u) << 23u) | (_e74 & 8388607u));
}

float truncated_sqrt(float value)
{
    const uint _e2 = _naga_sqrtf_rz(asuint(value));
    return asfloat(_e2);
}

int _fsqrt_rz(bool value_1)
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

uint _naga_sqrtf(uint input_bits_2)
{
    uint significand_1 = (uint)0;
    uint adjusted_exponent_1 = (uint)0;
    uint upper_word_1 = (uint)0;
    uint lower_word_1 = (uint)0;
    uint root_1 = (uint)0;
    uint remainder_1 = (uint)0;
    uint iteration_1 = (uint)0;

    uint _e5 = (input_bits_2 & 2147483647u);
    if (((_e5 == 0u) || (input_bits_2 == 2139095040u))) {
        return input_bits_2;
    }
    if ((((input_bits_2 & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits_2 & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand_1 = (_e19 | 8388608u);
    adjusted_exponent_1 = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = ((31u - firstbithigh(_e19)) - 8u);
        significand_1 = (_e19 << _e28);
        adjusted_exponent_1 = (128u - _e28);
    }
    uint _e32 = significand_1;
    uint _e33 = adjusted_exponent_1;
    uint _e34 = (_e33 & 1u);
    upper_word_1 = (_e32 >> (9u - _e34));
    lower_word_1 = (_e32 << (23u + _e34));
    root_1 = 0u;
    remainder_1 = 0u;
    iteration_1 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
        loop_init_1 = false;
        uint _e50 = iteration_1;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word_1;
        uint _e53 = lower_word_1;
        uint _e54 = root_1;
        uint _e55 = remainder_1;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word_1 = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word_1 = (_e53 << 2u);
        remainder_1 = (_e66 ? (_e63 - _e65) : _e63);
        root_1 = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root_1;
    uint _e75 = remainder_1;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

[numthreads(32, 1, 1)]
void sqrt_round_zero(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
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
    const uint _e18 = _naga_sqrtf_rz(asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e18))));
    const float _e23 = truncated_sqrt(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    output.Store(_e29*4, asuint(asuint(_e23)));
    cursor = int(0);
    int _e33 = cursor;
    cursor = asint(asuint(_e33) + asuint(int(1)));
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = asuint(input.Load(_e40*4));
    const float _e44 = truncated_sqrt(asfloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(asuint(_e44)));
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = asint(asuint(_e54) + asuint(int(1)));
        const uint _e59 = _naga_sqrtf_rz(asuint(float(_e54)));
        const uint _e62 = _naga_fabsf(asuint(asfloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = asint(asuint(_e67) + asuint(int(1)));
        const uint _e72 = _naga_sqrtf_rz(asuint(float(_e67)));
        const uint _e75 = _naga_fabsf(asuint(asfloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    output.Store(_e84*4, asuint(uint(_e78)));
    const uint _e89 = _naga_sqrtf_rz(asuint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    output.Store(_e96*4, asuint(asuint(asfloat(_e89))));
    local_8 = 2139095040u;
    uint _e100 = local_8;
    const uint _e103 = _naga_sqrtf_rz(asuint(asfloat(_e100)));
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    output.Store(_e110*4, asuint(asuint(asfloat(_e103))));
    const float _e114 = truncated_sqrt(float(4u));
    local_9 = uint((base + 6u));
    uint _e120 = local_9;
    output.Store(_e120*4, asuint(asuint(_e114)));
    const int _e123 = _fsqrt_rz(true);
    local_10 = uint((base + 7u));
    uint _e129 = local_10;
    output.Store(_e129*4, asuint(uint(_e123)));
    if (true) {
        const uint _e133 = _naga_sqrtf_rz(asuint(value_2));
        local_12 = asfloat(_e133);
    } else {
        int _e136 = cursor;
        cursor = asint(asuint(_e136) + asuint(int(1)));
        const uint _e141 = _naga_sqrtf_rz(asuint(float(_e136)));
        local_12 = asfloat(_e141);
    }
    float _e145 = local_12;
    local_11 = uint((base + 8u));
    uint _e151 = local_11;
    output.Store(_e151*4, asuint(asuint(_e145)));
    const uint _e154 = _naga_sqrtf(asuint(value_2));
    local_13 = uint((base + 9u));
    uint _e161 = local_13;
    output.Store(_e161*4, asuint(asuint(asfloat(_e154))));
}
