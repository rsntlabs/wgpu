#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_fmodf(uint dividend_bits, uint divisor_bits) {
    uint dividend_significand = 0u;
    int dividend_exponent = 0;
    uint divisor_significand = 0u;
    int divisor_exponent = 0;
    uint remainder = 0u;
    uint remaining_bits = 0u;
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
    dividend_exponent = (int(_e23) - 127);
    if ((_e23 == 0u)) {
        uint _e33 = (uint(31 - findMSB(_e22)) - 8u);
        dividend_significand = (_e22 << _e33);
        dividend_exponent = (-126 - int(_e33));
    }
    uint _e38 = dividend_significand;
    int _e39 = dividend_exponent;
    uint _e44 = (_e9 & 8388607u);
    uint _e45 = (_e9 >> 23u);
    divisor_significand = (_e44 | 8388608u);
    divisor_exponent = (int(_e45) - 127);
    if ((_e45 == 0u)) {
        uint _e55 = (uint(31 - findMSB(_e44)) - 8u);
        divisor_significand = (_e44 << _e55);
        divisor_exponent = (-126 - int(_e55));
    }
    uint _e60 = divisor_significand;
    int _e61 = divisor_exponent;
    remainder = _e38;
    remaining_bits = uint((_e39 - _e61));
    while(true) {
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
    uint _e81 = (uint(31 - findMSB(_e77)) - 8u);
    uint _e82 = (_e77 << _e81);
    int _e84 = (_e61 - int(_e81));
    return (_e10 | ((_e84 >= -126) ? ((uint((_e84 + 127)) << 23u) | (_e82 & 8388607u)) : (_e82 >> (uint((-126 - _e84)) & 31u))));
}

float sample_remainder(float numerator, float denominator_1) {
    uint _e4 = _naga_fmodf(floatBitsToUint(numerator), floatBitsToUint(denominator_1));
    return uintBitsToFloat(_e4);
}

int fmodf(bool numerator_1, bool denominator_2) {
    int local_32 = 0;
    if (numerator_1) {
        local_32 = 7;
    } else {
        local_32 = 9;
    }
    int _e6 = local_32;
    return _e6;
}

float fmodf_1(float first, float second, float third) {
    return ((first + second) + third);
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    float value = 0.0;
    float denominator = 0.0;
    bool choose = false;
    float local_19 = 0.0;
    bool local_20 = false;
    bool local_21 = false;
    float local_22 = 0.0;
    int iteration = 0;
    uint local_23 = 0u;
    bool local_24 = false;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint _e4 = _naga_fmodf(floatBitsToUint(5.5), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e4));
    uint _e16 = _naga_fmodf(floatBitsToUint(-(5.5)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e16));
    uint _e27 = _naga_fmodf(floatBitsToUint(5.5), floatBitsToUint(-(2.0)));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e27));
    uint _e39 = _naga_fmodf(floatBitsToUint(-(5.5)), floatBitsToUint(-(2.0)));
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(uintBitsToFloat(_e39));
    uint _e49 = _naga_fmodf(floatBitsToUint(4.0), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(uintBitsToFloat(_e49));
    uint _e60 = _naga_fmodf(floatBitsToUint(-(4.0)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(uintBitsToFloat(_e60));
    uint _e71 = _naga_fmodf(floatBitsToUint(0.0), floatBitsToUint(-(2.0)));
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(uintBitsToFloat(_e71));
    uint _e82 = _naga_fmodf(floatBitsToUint(-(0.0)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(uintBitsToFloat(_e82));
    uint _e92 = _naga_fmodf(floatBitsToUint(1.0), floatBitsToUint(3.0));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(uintBitsToFloat(_e92));
    uint _e102 = _naga_fmodf(floatBitsToUint(3.0), floatBitsToUint(1.0));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e102));
    local = 2139095039u;
    uint _e110 = local;
    local_1 = 1u;
    uint _e114 = local_1;
    uint _e118 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e110)), floatBitsToUint(uintBitsToFloat(_e114)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e118));
    local_2 = 4286578687u;
    uint _e126 = local_2;
    local_3 = 1u;
    uint _e130 = local_3;
    uint _e134 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e126)), floatBitsToUint(uintBitsToFloat(_e130)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e134));
    local_4 = 8388608u;
    uint _e142 = local_4;
    local_5 = 3u;
    uint _e146 = local_5;
    uint _e150 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e142)), floatBitsToUint(uintBitsToFloat(_e146)));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e150));
    local_6 = 8388607u;
    uint _e158 = local_6;
    local_7 = 3u;
    uint _e162 = local_7;
    uint _e166 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e158)), floatBitsToUint(uintBitsToFloat(_e162)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e166));
    local_8 = 1u;
    uint _e174 = local_8;
    local_9 = 8388608u;
    uint _e178 = local_9;
    uint _e182 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e174)), floatBitsToUint(uintBitsToFloat(_e178)));
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e182));
    local_10 = 1065353217u;
    uint _e190 = local_10;
    uint _e195 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e190)), floatBitsToUint(1.0));
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(uintBitsToFloat(_e195));
    local_11 = 1065353217u;
    uint _e203 = local_11;
    uint _e208 = _naga_fmodf(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e203)));
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(uintBitsToFloat(_e208));
    local_12 = 2139095041u;
    uint _e216 = local_12;
    uint _e221 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e216)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(uintBitsToFloat(_e221));
    local_13 = 2143363909u;
    uint _e229 = local_13;
    uint _e234 = _naga_fmodf(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e229)));
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(uintBitsToFloat(_e234));
    local_14 = 2139095040u;
    uint _e242 = local_14;
    uint _e247 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e242)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(uintBitsToFloat(_e247));
    local_15 = 4286578688u;
    uint _e255 = local_15;
    local_16 = 2139095040u;
    uint _e259 = local_16;
    uint _e263 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e255)), floatBitsToUint(uintBitsToFloat(_e259)));
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(uintBitsToFloat(_e263));
    uint _e273 = _naga_fmodf(floatBitsToUint(1.0), floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(uintBitsToFloat(_e273));
    uint _e283 = _naga_fmodf(floatBitsToUint(0.0), floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(uintBitsToFloat(_e283));
    local_17 = 2139095040u;
    uint _e291 = local_17;
    uint _e296 = _naga_fmodf(floatBitsToUint(5.5), floatBitsToUint(uintBitsToFloat(_e291)));
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(uintBitsToFloat(_e296));
    local_18 = 4286578688u;
    uint _e306 = local_18;
    uint _e310 = _naga_fmodf(floatBitsToUint(-(5.5)), floatBitsToUint(uintBitsToFloat(_e306)));
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(uintBitsToFloat(_e310));
    float _e320 = sample_remainder(float(7), float(3));
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(_e320);
    float _e329 = sample_remainder(float(7u), float(3u));
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(_e329);
    float _e338 = sample_remainder(float(true), float(true));
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e338);
    float _e347 = sample_remainder(float(false), float(true));
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e347);
    int _e354 = fmodf(true, false);
    _group_0_binding_0_cs[uint(29)] = uint(_e354);
    int _e361 = fmodf(false, true);
    _group_0_binding_0_cs[uint(30)] = uint(_e361);
    float _e369 = fmodf_1(1.0, 2.0, 3.0);
    _group_0_binding_0_cs[uint(31)] = floatBitsToUint(_e369);
    value = 5.5;
    float _e376 = value;
    value = (_e376 + float(1));
    uint _e383 = _naga_fmodf(floatBitsToUint(_e376), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(32)] = floatBitsToUint(uintBitsToFloat(_e383));
    float _e389 = value;
    _group_0_binding_0_cs[uint(33)] = floatBitsToUint(_e389);
    denominator = 2.0;
    float _e396 = denominator;
    denominator = (_e396 + float(1));
    uint _e403 = _naga_fmodf(floatBitsToUint(7.0), floatBitsToUint(_e396));
    _group_0_binding_0_cs[uint(34)] = floatBitsToUint(uintBitsToFloat(_e403));
    float _e409 = denominator;
    _group_0_binding_0_cs[uint(35)] = floatBitsToUint(_e409);
    value = 5.5;
    float _e415 = value;
    value = (_e415 + float(1));
    float _e419 = value;
    value = (_e419 + float(1));
    uint _e425 = _naga_fmodf(floatBitsToUint(_e415), floatBitsToUint(_e419));
    _group_0_binding_0_cs[uint(36)] = floatBitsToUint(uintBitsToFloat(_e425));
    float _e431 = value;
    _group_0_binding_0_cs[uint(37)] = floatBitsToUint(_e431);
    choose = false;
    bool _e438 = choose;
    if (_e438) {
        float _e439 = value;
        value = (_e439 + float(1));
        uint _e446 = _naga_fmodf(floatBitsToUint(_e439), floatBitsToUint(2.0));
        local_19 = uintBitsToFloat(_e446);
    } else {
        float _e449 = value;
        value = (_e449 + float(1));
        uint _e456 = _naga_fmodf(floatBitsToUint(_e449), floatBitsToUint(3.0));
        local_19 = uintBitsToFloat(_e456);
    }
    float _e460 = local_19;
    _group_0_binding_0_cs[uint(38)] = floatBitsToUint(_e460);
    float _e465 = value;
    _group_0_binding_0_cs[uint(39)] = floatBitsToUint(_e465);
    local_20 = false;
    if (false) {
        float _e472 = value;
        value = (_e472 + float(1));
        uint _e479 = _naga_fmodf(floatBitsToUint(_e472), floatBitsToUint(2.0));
        uint _e482 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e479)));
        local_20 = (_e482 != 0u);
    }
    bool _e485 = local_20;
    _group_0_binding_0_cs[uint(40)] = uint(_e485);
    local_21 = true;
    if (true) {
    } else {
        float _e492 = value;
        value = (_e492 + float(1));
        uint _e499 = _naga_fmodf(floatBitsToUint(_e492), floatBitsToUint(2.0));
        uint _e502 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e499)));
        local_21 = (_e502 != 0u);
    }
    bool _e505 = local_21;
    _group_0_binding_0_cs[uint(41)] = uint(_e505);
    float _e510 = value;
    _group_0_binding_0_cs[uint(42)] = floatBitsToUint(_e510);
    float _e515 = value;
    value = (_e515 + float(1));
    uint _e522 = _naga_fmodf(floatBitsToUint(_e515), floatBitsToUint(2.0));
    float _e523 = value;
    value = (_e523 + float(1));
    uint _e530 = _naga_fmodf(floatBitsToUint(_e523), floatBitsToUint(3.0));
    _group_0_binding_0_cs[uint(43)] = floatBitsToUint(uintBitsToFloat(_e530));
    float _e536 = value;
    _group_0_binding_0_cs[uint(44)] = floatBitsToUint(_e536);
    float _e541 = value;
    value = (_e541 + float(1));
    uint _e548 = _naga_fmodf(floatBitsToUint(_e541), floatBitsToUint(3.0));
    local_22 = uintBitsToFloat(_e548);
    float _e551 = local_22;
    _group_0_binding_0_cs[uint(45)] = floatBitsToUint(_e551);
    float _e556 = value;
    _group_0_binding_0_cs[uint(46)] = floatBitsToUint(_e556);
    {
        iteration = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e586 = iteration;
                iteration = (_e586 + 1);
            }
            loop_init = false;
            int _e563 = iteration;
            if ((_e563 < 2)) {
            } else {
                break;
            }
            int _e566 = iteration;
            if ((_e566 == 0)) {
                continue;
            }
            float _e569 = value;
            value = (_e569 + float(1));
            uint _e576 = _naga_fmodf(floatBitsToUint(_e569), floatBitsToUint(2.0));
            local_23 = uint(47);
            uint _e582 = local_23;
            local_31 = _e582;
            uint _e584 = local_31;
            _group_0_binding_0_cs[_e584] = floatBitsToUint(uintBitsToFloat(_e576));
        }
    }
    float _e589 = value;
    _group_0_binding_0_cs[uint(48)] = floatBitsToUint(_e589);
    local_24 = true;
    if (true) {
        float _e596 = value;
        value = (_e596 + float(1));
        uint _e603 = _naga_fmodf(floatBitsToUint(_e596), floatBitsToUint(2.0));
        uint _e606 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e603)));
        local_24 = (_e606 != 0u);
    }
    bool _e609 = local_24;
    _group_0_binding_0_cs[uint(49)] = uint(_e609);
    float _e614 = value;
    _group_0_binding_0_cs[uint(50)] = floatBitsToUint(_e614);
    float _e623 = sample_remainder(float(4294967295u), float(3u));
    _group_0_binding_0_cs[uint(51)] = floatBitsToUint(_e623);
    float _e635 = sample_remainder(float((-(2147483647) - 1)), float(3));
    _group_0_binding_0_cs[uint(52)] = floatBitsToUint(_e635);
    uint _e644 = _naga_fmodf(floatBitsToUint(0.5), floatBitsToUint(0.25));
    _group_0_binding_0_cs[uint(53)] = floatBitsToUint(uintBitsToFloat(_e644));
    uint _e655 = _naga_fmodf(floatBitsToUint(-(0.5)), floatBitsToUint(0.25));
    _group_0_binding_0_cs[uint(54)] = floatBitsToUint(uintBitsToFloat(_e655));
    local_25 = 2147483647u;
    uint _e663 = local_25;
    uint _e668 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e663)), floatBitsToUint(1.0));
    _group_0_binding_0_cs[uint(55)] = floatBitsToUint(uintBitsToFloat(_e668));
    float _e676 = sample_remainder(3.25, 2.0);
    _group_0_binding_0_cs[uint(56)] = floatBitsToUint(_e676);
    uint _e685 = _naga_fmodf(floatBitsToUint(5.5), floatBitsToUint(2.0));
    uint _e690 = _naga_fmodf(floatBitsToUint(1.5), floatBitsToUint(uintBitsToFloat(_e685)));
    _group_0_binding_0_cs[uint(57)] = floatBitsToUint(uintBitsToFloat(_e690));
    uint _e700 = _naga_fmodf(floatBitsToUint(8.5), floatBitsToUint(3.0));
    uint _e705 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e700)), floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(58)] = floatBitsToUint(uintBitsToFloat(_e705));
    local_26 = 2139095040u;
    uint _e715 = local_26;
    uint _e719 = _naga_fmodf(floatBitsToUint(-(0.0)), floatBitsToUint(uintBitsToFloat(_e715)));
    _group_0_binding_0_cs[uint(59)] = floatBitsToUint(uintBitsToFloat(_e719));
    local_27 = 1u;
    uint _e727 = local_27;
    local_28 = 4286578688u;
    uint _e731 = local_28;
    uint _e735 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e727)), floatBitsToUint(uintBitsToFloat(_e731)));
    _group_0_binding_0_cs[uint(60)] = floatBitsToUint(uintBitsToFloat(_e735));
    local_29 = 8388609u;
    uint _e743 = local_29;
    local_30 = 8388607u;
    uint _e747 = local_30;
    uint _e751 = _naga_fmodf(floatBitsToUint(uintBitsToFloat(_e743)), floatBitsToUint(uintBitsToFloat(_e747)));
    _group_0_binding_0_cs[uint(61)] = floatBitsToUint(uintBitsToFloat(_e751));
}

