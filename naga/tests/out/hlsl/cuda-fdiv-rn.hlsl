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

float quotient_value(float first, float second)
{
    const uint _e4 = _naga_divide_f32_(asuint(first), asuint(second));
    return asfloat(_e4);
}

int _fdiv_rn(bool first_1, bool second_1)
{
    int local_15 = (int)0;

    if (first_1) {
        local_15 = int(7);
    } else {
        local_15 = int(9);
    }
    int _e6 = local_15;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

[numthreads(32, 1, 1)]
void divide_round_nearest(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int cursor = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    bool local_6 = (bool)0;
    bool local_7 = (bool)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float first_2 = asfloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float second_2 = asfloat(_e30);
    const uint _e34 = _naga_divide_f32_(asuint(first_2), asuint(second_2));
    output.Store(base*4, asuint(asuint(asfloat(_e34))));
    const float _e39 = quotient_value(first_2, second_2);
    local_2 = uint((base + 1u));
    uint _e45 = local_2;
    output.Store(_e45*4, asuint(asuint(_e39)));
    cursor = int(0);
    int _e51 = cursor;
    cursor = asint(asuint(_e51) + asuint(int(1)));
    local_4 = uint(((index * 2u) + uint(_e51)));
    uint _e58 = local_4;
    uint _e60 = asuint(input.Load(_e58*4));
    int _e64 = cursor;
    cursor = asint(asuint(_e64) + asuint(int(1)));
    local_5 = uint(((index * 2u) + uint(_e64)));
    uint _e71 = local_5;
    uint _e73 = asuint(input.Load(_e71*4));
    const float _e75 = quotient_value(asfloat(_e60), asfloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    output.Store(_e81*4, asuint(asuint(_e75)));
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = asint(asuint(_e85) + asuint(int(1)));
        const uint _e91 = _naga_divide_f32_(asuint(float(_e85)), asuint(first_2));
        const uint _e94 = _naga_fabsf(asuint(asfloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = asint(asuint(_e99) + asuint(int(1)));
        const uint _e105 = _naga_divide_f32_(asuint(first_2), asuint(float(_e99)));
        const uint _e108 = _naga_fabsf(asuint(asfloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    output.Store(_e117*4, asuint(uint(_e111)));
    const uint _e125 = _naga_divide_f32_(asuint(-(0.0)), asuint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    output.Store(_e132*4, asuint(asuint(asfloat(_e125))));
    const uint _e139 = _naga_divide_f32_(asuint(-(0.0)), asuint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    output.Store(_e146*4, asuint(asuint(asfloat(_e139))));
    const float _e152 = quotient_value(float(int(2)), float(3u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    output.Store(_e158*4, asuint(asuint(_e152)));
    const int _e162 = _fdiv_rn(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    output.Store(_e168*4, asuint(uint(_e162)));
    const uint _e172 = _naga_divide_f32_(asuint(second_2), asuint(first_2));
    local_13 = uint((base + 8u));
    uint _e179 = local_13;
    output.Store(_e179*4, asuint(asuint(asfloat(_e172))));
    const float _e183 = quotient_value(1.0, 3.0);
    local_14 = uint((base + 9u));
    uint _e189 = local_14;
    output.Store(_e189*4, asuint(asuint(_e183)));
}
