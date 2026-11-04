RWByteAddressBuffer output : register(u0);

uint _naga_fmodf(uint dividend_bits, uint divisor_bits)
{
    uint dividend_significand = (uint)0;
    int dividend_exponent = (int)0;
    uint divisor_significand = (uint)0;
    int divisor_exponent = (int)0;
    uint remainder = (uint)0;
    uint remaining_bits = (uint)0;

    uint _e8 = (dividend_bits & 2147483647u);
    uint _e9 = (divisor_bits & 2147483647u);
    uint _e10 = (dividend_bits & 2147483648u);
    if (((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u)))) {
        return 2143289344u;
    }
    if ((_e8 < _e9)) {
        return dividend_bits;
    }
    if ((_e8 == _e9)) {
        return _e10;
    }
    uint _e22 = (_e8 & 8388607u);
    uint _e23 = (_e8 >> 23u);
    dividend_significand = (_e22 | 8388608u);
    dividend_exponent = asint(asuint(int(_e23)) - asuint(int(127)));
    if ((_e23 == 0u)) {
        uint _e33 = ((31u - firstbithigh(_e22)) - 8u);
        dividend_significand = (_e22 << _e33);
        dividend_exponent = asint(asuint(int(-126)) - asuint(int(_e33)));
    }
    uint _e38 = dividend_significand;
    int _e39 = dividend_exponent;
    uint _e44 = (_e9 & 8388607u);
    uint _e45 = (_e9 >> 23u);
    divisor_significand = (_e44 | 8388608u);
    divisor_exponent = asint(asuint(int(_e45)) - asuint(int(127)));
    if ((_e45 == 0u)) {
        uint _e55 = ((31u - firstbithigh(_e44)) - 8u);
        divisor_significand = (_e44 << _e55);
        divisor_exponent = asint(asuint(int(-126)) - asuint(int(_e55)));
    }
    uint _e60 = divisor_significand;
    int _e61 = divisor_exponent;
    remainder = _e38;
    remaining_bits = uint(asint(asuint(_e39) - asuint(_e61)));
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e66 = remaining_bits;
        if ((_e66 == 0u)) {
            break;
        }
        uint _e68 = remainder;
        remainder = (((_e68 >= _e60) ? (_e68 - _e60) : _e68) << 1u);
        remaining_bits = (_e66 - 1u);
    }
    uint _e74 = remainder;
    uint _e77 = ((_e74 >= _e60) ? (_e74 - _e60) : _e74);
    if ((_e77 == 0u)) {
        return _e10;
    }
    uint _e81 = ((31u - firstbithigh(_e77)) - 8u);
    uint _e82 = (_e77 << _e81);
    int _e84 = asint(asuint(_e61) - asuint(int(_e81)));
    return (_e10 | ((_e84 >= int(-126)) ? ((uint(asint(asuint(_e84) + asuint(int(127)))) << 23u) | (_e82 & 8388607u)) : (_e82 >> (uint(asint(asuint(int(-126)) - asuint(_e84))) & 31u))));
}

float sample_remainder(float numerator, float denominator_1)
{
    const uint _e4 = _naga_fmodf(asuint(numerator), asuint(denominator_1));
    return asfloat(_e4);
}

int fmodf(bool numerator_1, bool denominator_2)
{
    int local_32 = (int)0;

    if (numerator_1) {
        local_32 = int(7);
    } else {
        local_32 = int(9);
    }
    int _e6 = local_32;
    return _e6;
}

float fmodf_1(float first, float second, float third)
{
    return ((first + second) + third);
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void remainders()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    float value = (float)0;
    float denominator = (float)0;
    bool choose = (bool)0;
    float local_19 = (float)0;
    bool local_20 = (bool)0;
    bool local_21 = (bool)0;
    float local_22 = (float)0;
    int iteration = (int)0;
    uint local_23 = (uint)0;
    bool local_24 = (bool)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;

    const uint _e4 = _naga_fmodf(asuint(5.5), asuint(2.0));
    output.Store(uint(int(0))*4, asuint(asuint(asfloat(_e4))));
    const uint _e16 = _naga_fmodf(asuint(-(5.5)), asuint(2.0));
    output.Store(uint(int(1))*4, asuint(asuint(asfloat(_e16))));
    const uint _e27 = _naga_fmodf(asuint(5.5), asuint(-(2.0)));
    output.Store(uint(int(2))*4, asuint(asuint(asfloat(_e27))));
    const uint _e39 = _naga_fmodf(asuint(-(5.5)), asuint(-(2.0)));
    output.Store(uint(int(3))*4, asuint(asuint(asfloat(_e39))));
    const uint _e49 = _naga_fmodf(asuint(4.0), asuint(2.0));
    output.Store(uint(int(4))*4, asuint(asuint(asfloat(_e49))));
    const uint _e60 = _naga_fmodf(asuint(-(4.0)), asuint(2.0));
    output.Store(uint(int(5))*4, asuint(asuint(asfloat(_e60))));
    const uint _e71 = _naga_fmodf(asuint(0.0), asuint(-(2.0)));
    output.Store(uint(int(6))*4, asuint(asuint(asfloat(_e71))));
    const uint _e82 = _naga_fmodf(asuint(-(0.0)), asuint(2.0));
    output.Store(uint(int(7))*4, asuint(asuint(asfloat(_e82))));
    const uint _e92 = _naga_fmodf(asuint(1.0), asuint(3.0));
    output.Store(uint(int(8))*4, asuint(asuint(asfloat(_e92))));
    const uint _e102 = _naga_fmodf(asuint(3.0), asuint(1.0));
    output.Store(uint(int(9))*4, asuint(asuint(asfloat(_e102))));
    local = 2139095039u;
    uint _e110 = local;
    local_1 = 1u;
    uint _e114 = local_1;
    const uint _e118 = _naga_fmodf(asuint(asfloat(_e110)), asuint(asfloat(_e114)));
    output.Store(uint(int(10))*4, asuint(asuint(asfloat(_e118))));
    local_2 = 4286578687u;
    uint _e126 = local_2;
    local_3 = 1u;
    uint _e130 = local_3;
    const uint _e134 = _naga_fmodf(asuint(asfloat(_e126)), asuint(asfloat(_e130)));
    output.Store(uint(int(11))*4, asuint(asuint(asfloat(_e134))));
    local_4 = 8388608u;
    uint _e142 = local_4;
    local_5 = 3u;
    uint _e146 = local_5;
    const uint _e150 = _naga_fmodf(asuint(asfloat(_e142)), asuint(asfloat(_e146)));
    output.Store(uint(int(12))*4, asuint(asuint(asfloat(_e150))));
    local_6 = 8388607u;
    uint _e158 = local_6;
    local_7 = 3u;
    uint _e162 = local_7;
    const uint _e166 = _naga_fmodf(asuint(asfloat(_e158)), asuint(asfloat(_e162)));
    output.Store(uint(int(13))*4, asuint(asuint(asfloat(_e166))));
    local_8 = 1u;
    uint _e174 = local_8;
    local_9 = 8388608u;
    uint _e178 = local_9;
    const uint _e182 = _naga_fmodf(asuint(asfloat(_e174)), asuint(asfloat(_e178)));
    output.Store(uint(int(14))*4, asuint(asuint(asfloat(_e182))));
    local_10 = 1065353217u;
    uint _e190 = local_10;
    const uint _e195 = _naga_fmodf(asuint(asfloat(_e190)), asuint(1.0));
    output.Store(uint(int(15))*4, asuint(asuint(asfloat(_e195))));
    local_11 = 1065353217u;
    uint _e203 = local_11;
    const uint _e208 = _naga_fmodf(asuint(1.0), asuint(asfloat(_e203)));
    output.Store(uint(int(16))*4, asuint(asuint(asfloat(_e208))));
    local_12 = 2139095041u;
    uint _e216 = local_12;
    const uint _e221 = _naga_fmodf(asuint(asfloat(_e216)), asuint(2.0));
    output.Store(uint(int(17))*4, asuint(asuint(asfloat(_e221))));
    local_13 = 2143363909u;
    uint _e229 = local_13;
    const uint _e234 = _naga_fmodf(asuint(1.0), asuint(asfloat(_e229)));
    output.Store(uint(int(18))*4, asuint(asuint(asfloat(_e234))));
    local_14 = 2139095040u;
    uint _e242 = local_14;
    const uint _e247 = _naga_fmodf(asuint(asfloat(_e242)), asuint(2.0));
    output.Store(uint(int(19))*4, asuint(asuint(asfloat(_e247))));
    local_15 = 4286578688u;
    uint _e255 = local_15;
    local_16 = 2139095040u;
    uint _e259 = local_16;
    const uint _e263 = _naga_fmodf(asuint(asfloat(_e255)), asuint(asfloat(_e259)));
    output.Store(uint(int(20))*4, asuint(asuint(asfloat(_e263))));
    const uint _e273 = _naga_fmodf(asuint(1.0), asuint(0.0));
    output.Store(uint(int(21))*4, asuint(asuint(asfloat(_e273))));
    const uint _e283 = _naga_fmodf(asuint(0.0), asuint(0.0));
    output.Store(uint(int(22))*4, asuint(asuint(asfloat(_e283))));
    local_17 = 2139095040u;
    uint _e291 = local_17;
    const uint _e296 = _naga_fmodf(asuint(5.5), asuint(asfloat(_e291)));
    output.Store(uint(int(23))*4, asuint(asuint(asfloat(_e296))));
    local_18 = 4286578688u;
    uint _e306 = local_18;
    const uint _e310 = _naga_fmodf(asuint(-(5.5)), asuint(asfloat(_e306)));
    output.Store(uint(int(24))*4, asuint(asuint(asfloat(_e310))));
    const float _e320 = sample_remainder(float(int(7)), float(int(3)));
    output.Store(uint(int(25))*4, asuint(asuint(_e320)));
    const float _e329 = sample_remainder(float(7u), float(3u));
    output.Store(uint(int(26))*4, asuint(asuint(_e329)));
    const float _e338 = sample_remainder(float(true), float(true));
    output.Store(uint(int(27))*4, asuint(asuint(_e338)));
    const float _e347 = sample_remainder(float(false), float(true));
    output.Store(uint(int(28))*4, asuint(asuint(_e347)));
    const int _e354 = fmodf(true, false);
    output.Store(uint(int(29))*4, asuint(uint(_e354)));
    const int _e361 = fmodf(false, true);
    output.Store(uint(int(30))*4, asuint(uint(_e361)));
    const float _e369 = fmodf_1(1.0, 2.0, 3.0);
    output.Store(uint(int(31))*4, asuint(asuint(_e369)));
    value = 5.5;
    float _e376 = value;
    value = (_e376 + float(int(1)));
    const uint _e383 = _naga_fmodf(asuint(_e376), asuint(2.0));
    output.Store(uint(int(32))*4, asuint(asuint(asfloat(_e383))));
    float _e389 = value;
    output.Store(uint(int(33))*4, asuint(asuint(_e389)));
    denominator = 2.0;
    float _e396 = denominator;
    denominator = (_e396 + float(int(1)));
    const uint _e403 = _naga_fmodf(asuint(7.0), asuint(_e396));
    output.Store(uint(int(34))*4, asuint(asuint(asfloat(_e403))));
    float _e409 = denominator;
    output.Store(uint(int(35))*4, asuint(asuint(_e409)));
    value = 5.5;
    float _e415 = value;
    value = (_e415 + float(int(1)));
    float _e419 = value;
    value = (_e419 + float(int(1)));
    const uint _e425 = _naga_fmodf(asuint(_e415), asuint(_e419));
    output.Store(uint(int(36))*4, asuint(asuint(asfloat(_e425))));
    float _e431 = value;
    output.Store(uint(int(37))*4, asuint(asuint(_e431)));
    choose = false;
    bool _e438 = choose;
    if (_e438) {
        float _e439 = value;
        value = (_e439 + float(int(1)));
        const uint _e446 = _naga_fmodf(asuint(_e439), asuint(2.0));
        local_19 = asfloat(_e446);
    } else {
        float _e449 = value;
        value = (_e449 + float(int(1)));
        const uint _e456 = _naga_fmodf(asuint(_e449), asuint(3.0));
        local_19 = asfloat(_e456);
    }
    float _e460 = local_19;
    output.Store(uint(int(38))*4, asuint(asuint(_e460)));
    float _e465 = value;
    output.Store(uint(int(39))*4, asuint(asuint(_e465)));
    local_20 = false;
    if (false) {
        float _e472 = value;
        value = (_e472 + float(int(1)));
        const uint _e479 = _naga_fmodf(asuint(_e472), asuint(2.0));
        const uint _e482 = _naga_fabsf(asuint(asfloat(_e479)));
        local_20 = (_e482 != 0u);
    }
    bool _e485 = local_20;
    output.Store(uint(int(40))*4, asuint(uint(_e485)));
    local_21 = true;
    if (true) {
    } else {
        float _e492 = value;
        value = (_e492 + float(int(1)));
        const uint _e499 = _naga_fmodf(asuint(_e492), asuint(2.0));
        const uint _e502 = _naga_fabsf(asuint(asfloat(_e499)));
        local_21 = (_e502 != 0u);
    }
    bool _e505 = local_21;
    output.Store(uint(int(41))*4, asuint(uint(_e505)));
    float _e510 = value;
    output.Store(uint(int(42))*4, asuint(asuint(_e510)));
    float _e515 = value;
    value = (_e515 + float(int(1)));
    const uint _e522 = _naga_fmodf(asuint(_e515), asuint(2.0));
    float _e523 = value;
    value = (_e523 + float(int(1)));
    const uint _e530 = _naga_fmodf(asuint(_e523), asuint(3.0));
    output.Store(uint(int(43))*4, asuint(asuint(asfloat(_e530))));
    float _e536 = value;
    output.Store(uint(int(44))*4, asuint(asuint(_e536)));
    float _e541 = value;
    value = (_e541 + float(int(1)));
    const uint _e548 = _naga_fmodf(asuint(_e541), asuint(3.0));
    local_22 = asfloat(_e548);
    float _e551 = local_22;
    output.Store(uint(int(45))*4, asuint(asuint(_e551)));
    float _e556 = value;
    output.Store(uint(int(46))*4, asuint(asuint(_e556)));
    {
        iteration = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init) {
                int _e586 = iteration;
                iteration = asint(asuint(_e586) + asuint(int(1)));
            }
            loop_init = false;
            int _e563 = iteration;
            if ((_e563 < int(2))) {
            } else {
                break;
            }
            int _e566 = iteration;
            if ((_e566 == int(0))) {
                continue;
            }
            float _e569 = value;
            value = (_e569 + float(int(1)));
            const uint _e576 = _naga_fmodf(asuint(_e569), asuint(2.0));
            local_23 = uint(int(47));
            uint _e582 = local_23;
            local_31 = _e582;
            uint _e584 = local_31;
            output.Store(_e584*4, asuint(asuint(asfloat(_e576))));
        }
    }
    float _e589 = value;
    output.Store(uint(int(48))*4, asuint(asuint(_e589)));
    local_24 = true;
    if (true) {
        float _e596 = value;
        value = (_e596 + float(int(1)));
        const uint _e603 = _naga_fmodf(asuint(_e596), asuint(2.0));
        const uint _e606 = _naga_fabsf(asuint(asfloat(_e603)));
        local_24 = (_e606 != 0u);
    }
    bool _e609 = local_24;
    output.Store(uint(int(49))*4, asuint(uint(_e609)));
    float _e614 = value;
    output.Store(uint(int(50))*4, asuint(asuint(_e614)));
    const float _e623 = sample_remainder(float(4294967295u), float(3u));
    output.Store(uint(int(51))*4, asuint(asuint(_e623)));
    const float _e635 = sample_remainder(float(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1)))), float(int(3)));
    output.Store(uint(int(52))*4, asuint(asuint(_e635)));
    const uint _e644 = _naga_fmodf(asuint(0.5), asuint(0.25));
    output.Store(uint(int(53))*4, asuint(asuint(asfloat(_e644))));
    const uint _e655 = _naga_fmodf(asuint(-(0.5)), asuint(0.25));
    output.Store(uint(int(54))*4, asuint(asuint(asfloat(_e655))));
    local_25 = 2147483647u;
    uint _e663 = local_25;
    const uint _e668 = _naga_fmodf(asuint(asfloat(_e663)), asuint(1.0));
    output.Store(uint(int(55))*4, asuint(asuint(asfloat(_e668))));
    const float _e676 = sample_remainder(3.25, 2.0);
    output.Store(uint(int(56))*4, asuint(asuint(_e676)));
    const uint _e685 = _naga_fmodf(asuint(5.5), asuint(2.0));
    const uint _e690 = _naga_fmodf(asuint(1.5), asuint(asfloat(_e685)));
    output.Store(uint(int(57))*4, asuint(asuint(asfloat(_e690))));
    const uint _e700 = _naga_fmodf(asuint(8.5), asuint(3.0));
    const uint _e705 = _naga_fmodf(asuint(asfloat(_e700)), asuint(2.0));
    output.Store(uint(int(58))*4, asuint(asuint(asfloat(_e705))));
    local_26 = 2139095040u;
    uint _e715 = local_26;
    const uint _e719 = _naga_fmodf(asuint(-(0.0)), asuint(asfloat(_e715)));
    output.Store(uint(int(59))*4, asuint(asuint(asfloat(_e719))));
    local_27 = 1u;
    uint _e727 = local_27;
    local_28 = 4286578688u;
    uint _e731 = local_28;
    const uint _e735 = _naga_fmodf(asuint(asfloat(_e727)), asuint(asfloat(_e731)));
    output.Store(uint(int(60))*4, asuint(asuint(asfloat(_e735))));
    local_29 = 8388609u;
    uint _e743 = local_29;
    local_30 = 8388607u;
    uint _e747 = local_30;
    const uint _e751 = _naga_fmodf(asuint(asfloat(_e743)), asuint(asfloat(_e747)));
    output.Store(uint(int(61))*4, asuint(asuint(asfloat(_e751))));
}
