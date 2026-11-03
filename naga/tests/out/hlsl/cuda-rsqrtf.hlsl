RWByteAddressBuffer out_ : register(u0);

uint _naga_sqrtf(uint input_bits)
{
    uint significand = (uint)0;
    uint adjusted_exponent = (uint)0;
    uint upper_word = (uint)0;
    uint lower_word = (uint)0;
    uint root = (uint)0;
    uint remainder = (uint)0;
    uint iteration_1 = (uint)0;

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
    iteration_1 = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration_1;
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
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits)
{
    uint numerator_significand = (uint)0;
    int numerator_exponent = (int)0;
    uint denominator_significand = (uint)0;
    int denominator_exponent = (int)0;
    uint quotient = (uint)0;
    uint remainder_1 = (uint)0;
    uint iteration_2 = (uint)0;

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
    remainder_1 = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration_2 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e94 = iteration_2;
            iteration_2 = (_e94 + 1u);
        }
        loop_init_1 = false;
        uint _e83 = iteration_2;
        if ((_e83 >= 23u)) {
            break;
        }
        uint _e85 = remainder_1;
        uint _e86 = quotient;
        uint _e87 = (_e85 << 1u);
        bool _e88 = (_e87 >= _e68);
        remainder_1 = (_e88 ? (_e87 - _e68) : _e87);
        quotient = ((_e86 << 1u) | (_e88 ? 1u : 0u));
    }
    uint _e96 = quotient;
    uint _e97 = remainder_1;
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

float inverse_root(float value_1)
{
    const uint _e2 = _naga_sqrtf(asuint(value_1));
    const uint _e7 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e2)));
    return asfloat(_e7);
}

float inverse_root_1(int value_2)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_2)));
    const uint _e8 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e3)));
    return asfloat(_e8);
}

float inverse_root_2(uint value_3)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_3)));
    const uint _e8 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e3)));
    return asfloat(_e8);
}

float inverse_root_3(bool value_4)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_4)));
    const uint _e8 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e3)));
    return asfloat(_e8);
}

int rsqrtf(bool value_5)
{
    int local_17 = (int)0;

    if (value_5) {
        local_17 = int(7);
    } else {
        local_17 = int(9);
    }
    int _e6 = local_17;
    return _e6;
}

float rsqrtf_1(float first, float second)
{
    return (first + second);
}

float pair(float first_1, float second_1)
{
    return ((first_1 * 10.0) + second_1);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void inverse_roots()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    float value = (float)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    bool choose = (bool)0;
    float local_10 = (float)0;
    bool local_11 = (bool)0;
    bool local_12 = (bool)0;
    float left = (float)0;
    float right = (float)0;
    int iteration = (int)0;
    uint local_13 = (uint)0;
    float local_14 = (float)0;
    bool local_15 = (bool)0;
    uint local_16 = (uint)0;

    const uint _e2 = _naga_sqrtf(asuint(0.0));
    const uint _e7 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e2)));
    out_.Store(uint(int(0))*4, asuint(asuint(asfloat(_e7))));
    const uint _e17 = _naga_sqrtf(asuint(-(0.0)));
    const uint _e22 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e17)));
    out_.Store(uint(int(1))*4, asuint(asuint(asfloat(_e22))));
    const uint _e30 = _naga_sqrtf(asuint(1.0));
    const uint _e35 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e30)));
    out_.Store(uint(int(2))*4, asuint(asuint(asfloat(_e35))));
    const float _e42 = inverse_root_1(int(4));
    out_.Store(uint(int(3))*4, asuint(asuint(_e42)));
    const float _e48 = inverse_root_2(9u);
    out_.Store(uint(int(4))*4, asuint(asuint(_e48)));
    const uint _e55 = _naga_sqrtf(asuint(6.25));
    const uint _e60 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e55)));
    out_.Store(uint(int(5))*4, asuint(asuint(asfloat(_e60))));
    const uint _e68 = _naga_sqrtf(asuint(2.0));
    const uint _e73 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e68)));
    out_.Store(uint(int(6))*4, asuint(asuint(asfloat(_e73))));
    local = 1u;
    uint _e81 = local;
    const uint _e84 = _naga_sqrtf(asuint(asfloat(_e81)));
    const uint _e89 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e84)));
    out_.Store(uint(int(7))*4, asuint(asuint(asfloat(_e89))));
    local_1 = 8388607u;
    uint _e97 = local_1;
    const uint _e100 = _naga_sqrtf(asuint(asfloat(_e97)));
    const uint _e105 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e100)));
    out_.Store(uint(int(8))*4, asuint(asuint(asfloat(_e105))));
    local_2 = 8388608u;
    uint _e113 = local_2;
    const uint _e116 = _naga_sqrtf(asuint(asfloat(_e113)));
    const uint _e121 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e116)));
    out_.Store(uint(int(9))*4, asuint(asuint(asfloat(_e121))));
    local_3 = 2139095039u;
    uint _e129 = local_3;
    const uint _e132 = _naga_sqrtf(asuint(asfloat(_e129)));
    const uint _e137 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e132)));
    out_.Store(uint(int(10))*4, asuint(asuint(asfloat(_e137))));
    local_4 = 2139095040u;
    uint _e145 = local_4;
    const uint _e148 = _naga_sqrtf(asuint(asfloat(_e145)));
    const uint _e153 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e148)));
    out_.Store(uint(int(11))*4, asuint(asuint(asfloat(_e153))));
    const uint _e162 = _naga_sqrtf(asuint(-(1.0)));
    const uint _e167 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e162)));
    out_.Store(uint(int(12))*4, asuint(asuint(asfloat(_e167))));
    local_5 = 2139095041u;
    uint _e175 = local_5;
    const uint _e178 = _naga_sqrtf(asuint(asfloat(_e175)));
    const uint _e183 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e178)));
    out_.Store(uint(int(13))*4, asuint(asuint(asfloat(_e183))));
    value = 4.0;
    float _e191 = value;
    value = (_e191 + float(int(1)));
    const float _e195 = inverse_root(_e191);
    out_.Store(uint(int(14))*4, asuint(asuint(_e195)));
    float _e200 = value;
    out_.Store(uint(int(15))*4, asuint(asuint(_e200)));
    const int _e206 = rsqrtf(true);
    out_.Store(uint(int(16))*4, asuint(uint(_e206)));
    const int _e212 = rsqrtf(false);
    out_.Store(uint(int(17))*4, asuint(uint(_e212)));
    const float _e219 = rsqrtf_1(2.0, 3.0);
    out_.Store(uint(int(18))*4, asuint(asuint(_e219)));
    local_6 = 1065353217u;
    uint _e226 = local_6;
    const uint _e229 = _naga_sqrtf(asuint(asfloat(_e226)));
    const uint _e234 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e229)));
    out_.Store(uint(int(19))*4, asuint(asuint(asfloat(_e234))));
    local_7 = 1065353218u;
    uint _e242 = local_7;
    const uint _e245 = _naga_sqrtf(asuint(asfloat(_e242)));
    const uint _e250 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e245)));
    out_.Store(uint(int(20))*4, asuint(asuint(asfloat(_e250))));
    local_8 = 1065353215u;
    uint _e258 = local_8;
    const uint _e261 = _naga_sqrtf(asuint(asfloat(_e258)));
    const uint _e266 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e261)));
    out_.Store(uint(int(21))*4, asuint(asuint(asfloat(_e266))));
    const float _e273 = inverse_root_2(4294967295u);
    out_.Store(uint(int(22))*4, asuint(asuint(_e273)));
    const float _e280 = inverse_root_1(naga_neg(int(4)));
    out_.Store(uint(int(23))*4, asuint(asuint(_e280)));
    const float _e286 = inverse_root(16.0);
    out_.Store(uint(int(24))*4, asuint(asuint(_e286)));
    const uint _e293 = _naga_sqrtf(asuint(0.25));
    const uint _e298 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e293)));
    out_.Store(uint(int(25))*4, asuint(asuint(asfloat(_e298))));
    local_9 = 2147483649u;
    uint _e306 = local_9;
    const uint _e309 = _naga_sqrtf(asuint(asfloat(_e306)));
    const uint _e314 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e309)));
    out_.Store(uint(int(26))*4, asuint(asuint(asfloat(_e314))));
    const float _e321 = inverse_root_3(false);
    out_.Store(uint(int(27))*4, asuint(asuint(_e321)));
    const float _e327 = inverse_root_3(true);
    out_.Store(uint(int(28))*4, asuint(asuint(_e327)));
    const float _e333 = inverse_root(0.5);
    out_.Store(uint(int(29))*4, asuint(asuint(_e333)));
    const uint _e340 = _naga_sqrtf(asuint(2.0));
    out_.Store(uint(int(30))*4, asuint(asuint(asfloat(_e340))));
    const uint _e348 = _naga_sqrtf(asuint(2.0));
    const uint _e353 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e348)));
    out_.Store(uint(int(31))*4, asuint(asuint(asfloat(_e353))));
    const uint _e361 = _naga_sqrtf(asuint(2.0));
    const uint _e366 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e361)));
    out_.Store(uint(int(32))*4, asuint(asuint(asfloat(_e366))));
    value = 4.0;
    choose = false;
    bool _e375 = choose;
    if (_e375) {
        float _e376 = value;
        value = (_e376 + float(int(1)));
        const uint _e381 = _naga_sqrtf(asuint(_e376));
        const uint _e386 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e381)));
        local_10 = asfloat(_e386);
    } else {
        float _e389 = value;
        value = (_e389 + float(int(1)));
        const uint _e394 = _naga_sqrtf(asuint(_e389));
        const uint _e399 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e394)));
        local_10 = asfloat(_e399);
    }
    float _e403 = local_10;
    out_.Store(uint(int(33))*4, asuint(asuint(_e403)));
    float _e408 = value;
    out_.Store(uint(int(34))*4, asuint(asuint(_e408)));
    local_11 = false;
    if (false) {
        float _e415 = value;
        value = (_e415 + float(int(1)));
        const uint _e420 = _naga_sqrtf(asuint(_e415));
        const uint _e425 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e420)));
        local_11 = (asfloat(_e425) != 0.0);
    }
    bool _e429 = local_11;
    out_.Store(uint(int(35))*4, asuint(uint(_e429)));
    local_12 = true;
    if (true) {
    } else {
        float _e436 = value;
        value = (_e436 + float(int(1)));
        const uint _e441 = _naga_sqrtf(asuint(_e436));
        const uint _e446 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e441)));
        local_12 = (asfloat(_e446) != 0.0);
    }
    bool _e450 = local_12;
    out_.Store(uint(int(36))*4, asuint(uint(_e450)));
    float _e455 = value;
    out_.Store(uint(int(37))*4, asuint(asuint(_e455)));
    left = 4.0;
    right = 9.0;
    float _e464 = left;
    left = (_e464 + float(int(1)));
    const uint _e469 = _naga_sqrtf(asuint(_e464));
    const uint _e474 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e469)));
    float _e476 = right;
    right = (_e476 + float(int(1)));
    const uint _e481 = _naga_sqrtf(asuint(_e476));
    const uint _e486 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e481)));
    const float _e488 = pair(asfloat(_e474), asfloat(_e486));
    out_.Store(uint(int(38))*4, asuint(asuint(_e488)));
    float _e493 = left;
    out_.Store(uint(int(39))*4, asuint(asuint(_e493)));
    float _e498 = right;
    out_.Store(uint(int(40))*4, asuint(asuint(_e498)));
    float _e503 = value;
    value = (_e503 + float(int(1)));
    const uint _e508 = _naga_sqrtf(asuint(_e503));
    const uint _e513 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e508)));
    float _e514 = value;
    value = (_e514 + float(int(1)));
    const uint _e519 = _naga_sqrtf(asuint(_e514));
    const uint _e524 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e519)));
    out_.Store(uint(int(41))*4, asuint(asuint(asfloat(_e524))));
    float _e530 = value;
    out_.Store(uint(int(42))*4, asuint(asuint(_e530)));
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e563 = iteration;
                iteration = asint(asuint(_e563) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e537 = iteration;
            if ((_e537 < int(2))) {
            } else {
                break;
            }
            int _e540 = iteration;
            if ((_e540 == int(0))) {
                continue;
            }
            float _e543 = value;
            value = (_e543 + float(int(1)));
            const uint _e548 = _naga_sqrtf(asuint(_e543));
            const uint _e553 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e548)));
            local_13 = uint(int(43));
            uint _e559 = local_13;
            local_16 = _e559;
            uint _e561 = local_16;
            out_.Store(_e561*4, asuint(asuint(asfloat(_e553))));
        }
    }
    float _e566 = value;
    out_.Store(uint(int(44))*4, asuint(asuint(_e566)));
    float _e571 = value;
    value = (_e571 + float(int(1)));
    const uint _e576 = _naga_sqrtf(asuint(_e571));
    const uint _e581 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e576)));
    local_14 = asfloat(_e581);
    float _e584 = local_14;
    out_.Store(uint(int(45))*4, asuint(asuint(_e584)));
    float _e589 = value;
    out_.Store(uint(int(46))*4, asuint(asuint(_e589)));
    local_15 = true;
    if (true) {
        float _e596 = value;
        value = (_e596 + float(int(1)));
        const uint _e601 = _naga_sqrtf(asuint(_e596));
        const uint _e606 = _naga_divide_f32_(asuint(1.0), asuint(asfloat(_e601)));
        local_15 = (asfloat(_e606) != 0.0);
    }
    bool _e610 = local_15;
    out_.Store(uint(int(47))*4, asuint(uint(_e610)));
    float _e615 = value;
    out_.Store(uint(int(48))*4, asuint(asuint(_e615)));
}
