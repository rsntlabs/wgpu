ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits)
{
    uint numerator_significand = (uint)0;
    int numerator_exponent = (int)0;
    uint denominator_significand = (uint)0;
    int denominator_exponent = (int)0;
    uint quotient = (uint)0;
    uint remainder = (uint)0;
    uint iteration = (uint)0;

    uint _e8 = (numerator_bits & 2147483647u);
    uint _e9 = (denominator_bits & 2147483647u);
    uint _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    uint _e12 = (_e11 | 2139095040u);
    bool _e16 = (_e8 == 0u);
    bool _e17 = (_e9 == 0u);
    bool _e19 = (_e8 == 2139095040u);
    bool _e20 = (_e9 == 2139095040u);
    if (((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20))) {
        return 2143289344u;
    }
    if ((_e19 || _e17)) {
        return _e12;
    }
    if ((_e16 || _e20)) {
        return _e11;
    }
    uint _e30 = (_e8 & 8388607u);
    uint _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = asint(asuint(int(_e31)) - asuint(int(127)));
    if ((_e31 == 0u)) {
        uint _e41 = ((31u - firstbithigh(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = asint(asuint(int(-126)) - asuint(int(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = asint(asuint(int(_e53)) - asuint(int(127)));
    if ((_e53 == 0u)) {
        uint _e63 = ((31u - firstbithigh(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = asint(asuint(int(-126)) - asuint(int(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = asint(asuint(asint(asuint(_e47) - asuint(_e69))) - asuint(int(_e70)));
    if ((_e75 < int(-150))) {
        return _e11;
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e94 = iteration;
            iteration = (_e94 + 1u);
        }
        loop_init = false;
        uint _e83 = iteration;
        if ((_e83 >= 23u)) {
            break;
        }
        uint _e85 = remainder;
        uint _e86 = quotient;
        uint _e87 = (_e85 << 1u);
        bool _e88 = (_e87 >= _e68);
        remainder = (_e88 ? (_e87 - _e68) : _e87);
        quotient = ((_e86 << 1u) | (_e88 ? 1u : 0u));
    }
    uint _e96 = quotient;
    uint _e97 = remainder;
    if ((_e75 < int(-126))) {
        uint _e103 = (uint(asint(asuint(int(-126)) - asuint(_e75))) & 31u);
        uint _e104 = (1u << _e103);
        uint _e106 = (_e96 & (_e104 - 1u));
        uint _e107 = (_e104 >> 1u);
        uint _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u)));
    }
    uint _e120 = (_e97 << 1u);
    uint _e128 = (_e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u));
    uint _e130 = (_e128 >> 24u);
    int _e133 = asint(asuint(_e75) + asuint(int(_e130)));
    if ((_e133 > int(127))) {
        return _e12;
    }
    return (_e11 | ((uint(asint(asuint(_e133) + asuint(int(127)))) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

float reciprocal_value(float value)
{
    const uint _e4 = _naga_divide_f32_(asuint(1.0), asuint(value));
    return asfloat(_e4);
}

int _frcp_rn(bool value_1)
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

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

[numthreads(32, 1, 1)]
void reciprocal_round_nearest(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
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
    const uint _e20 = _naga_divide_f32_(asuint(1.0), asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e20))));
    const float _e25 = reciprocal_value(value_2);
    local = uint((base + 1u));
    uint _e31 = local;
    output.Store(_e31*4, asuint(asuint(_e25)));
    cursor = int(0);
    int _e35 = cursor;
    cursor = asint(asuint(_e35) + asuint(int(1)));
    local_2 = uint((index + uint(_e35)));
    uint _e42 = local_2;
    uint _e44 = asuint(input.Load(_e42*4));
    const float _e46 = reciprocal_value(asfloat(_e44));
    local_1 = uint((base + 2u));
    uint _e52 = local_1;
    output.Store(_e52*4, asuint(asuint(_e46)));
    local_3 = false;
    if (false) {
        int _e56 = cursor;
        cursor = asint(asuint(_e56) + asuint(int(1)));
        const uint _e63 = _naga_divide_f32_(asuint(1.0), asuint(float(_e56)));
        const uint _e66 = _naga_fabsf(asuint(asfloat(_e63)));
        local_3 = (_e66 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e71 = cursor;
        cursor = asint(asuint(_e71) + asuint(int(1)));
        const uint _e78 = _naga_divide_f32_(asuint(1.0), asuint(float(_e71)));
        const uint _e81 = _naga_fabsf(asuint(asfloat(_e78)));
        local_4 = (_e81 != 0u);
    }
    int _e84 = cursor;
    local_5 = uint((base + 3u));
    uint _e90 = local_5;
    output.Store(_e90*4, asuint(uint(_e84)));
    const uint _e97 = _naga_divide_f32_(asuint(1.0), asuint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e104 = local_6;
    output.Store(_e104*4, asuint(asuint(asfloat(_e97))));
    local_8 = 4286578688u;
    uint _e108 = local_8;
    const uint _e113 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e108)));
    local_7 = uint((base + 5u));
    uint _e120 = local_7;
    output.Store(_e120*4, asuint(asuint(asfloat(_e113))));
    const float _e124 = reciprocal_value(float(2u));
    local_9 = uint((base + 6u));
    uint _e130 = local_9;
    output.Store(_e130*4, asuint(asuint(_e124)));
    const int _e133 = _frcp_rn(true);
    local_10 = uint((base + 7u));
    uint _e139 = local_10;
    output.Store(_e139*4, asuint(uint(_e133)));
    if (true) {
        const uint _e145 = _naga_divide_f32_(asuint(1.0), asuint(value_2));
        local_12 = asfloat(_e145);
    } else {
        int _e148 = cursor;
        cursor = asint(asuint(_e148) + asuint(int(1)));
        const uint _e155 = _naga_divide_f32_(asuint(1.0), asuint(float(_e148)));
        local_12 = asfloat(_e155);
    }
    float _e159 = local_12;
    local_11 = uint((base + 8u));
    uint _e165 = local_11;
    output.Store(_e165*4, asuint(asuint(_e159)));
    int _e167 = cursor;
    local_13 = uint((base + 9u));
    uint _e173 = local_13;
    output.Store(_e173*4, asuint(uint(_e167)));
}
