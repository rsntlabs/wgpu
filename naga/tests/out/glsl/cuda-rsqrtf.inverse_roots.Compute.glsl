#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_sqrtf(uint input_bits) {
    uint significand = 0u;
    uint adjusted_exponent = 0u;
    uint upper_word = 0u;
    uint lower_word = 0u;
    uint root = 0u;
    uint remainder = 0u;
    uint iteration_1 = 0u;
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
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
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
    bool loop_init = true;
    while(true) {
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

uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits) {
    uint numerator_significand = 0u;
    int numerator_exponent = 0;
    uint denominator_significand = 0u;
    int denominator_exponent = 0;
    uint quotient = 0u;
    uint remainder_1 = 0u;
    uint iteration_2 = 0u;
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
    numerator_exponent = (int(_e31) - 127);
    if ((_e31 == 0u)) {
        uint _e41 = (uint(31 - findMSB(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126 - int(_e41));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (int(_e53) - 127);
    if ((_e53 == 0u)) {
        uint _e63 = (uint(31 - findMSB(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126 - int(_e63));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = ((_e47 - _e69) - int(_e70));
    if ((_e75 < -150)) {
        return _e11;
    }
    quotient = 1u;
    remainder_1 = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration_2 = 0u;
    bool loop_init_1 = true;
    while(true) {
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
    if ((_e75 < -126)) {
        uint _e103 = (uint((-126 - _e75)) & 31u);
        uint _e104 = (1u << _e103);
        uint _e106 = (_e96 & (_e104 - 1u));
        uint _e107 = (_e104 >> 1u);
        uint _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u)));
    }
    uint _e120 = (_e97 << 1u);
    uint _e128 = (_e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u));
    uint _e130 = (_e128 >> 24u);
    int _e133 = (_e75 + int(_e130));
    if ((_e133 > 127)) {
        return _e12;
    }
    return (_e11 | ((uint((_e133 + 127)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

float inverse_root(float value_1) {
    uint _e2 = _naga_sqrtf(floatBitsToUint(value_1));
    uint _e7 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e2)));
    return uintBitsToFloat(_e7);
}

float inverse_root_1(int value_2) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_2)));
    uint _e8 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e3)));
    return uintBitsToFloat(_e8);
}

float inverse_root_2(uint value_3) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_3)));
    uint _e8 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e3)));
    return uintBitsToFloat(_e8);
}

float inverse_root_3(bool value_4) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_4)));
    uint _e8 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e3)));
    return uintBitsToFloat(_e8);
}

int rsqrtf(bool value_5) {
    int local_17 = 0;
    if (value_5) {
        local_17 = 7;
    } else {
        local_17 = 9;
    }
    int _e6 = local_17;
    return _e6;
}

float rsqrtf_1(float first, float second) {
    return (first + second);
}

float pair(float first_1, float second_1) {
    return ((first_1 * 10.0) + second_1);
}

uint _naga_fabsf(uint input_bits_1) {
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    float value = 0.0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    bool choose = false;
    float local_10 = 0.0;
    bool local_11 = false;
    bool local_12 = false;
    float left = 0.0;
    float right = 0.0;
    int iteration = 0;
    uint local_13 = 0u;
    float local_14 = 0.0;
    bool local_15 = false;
    uint local_16 = 0u;
    uint _e2 = _naga_sqrtf(floatBitsToUint(0.0));
    uint _e7 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e2)));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e7));
    uint _e17 = _naga_sqrtf(floatBitsToUint(-(0.0)));
    uint _e22 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e17)));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e22));
    uint _e30 = _naga_sqrtf(floatBitsToUint(1.0));
    uint _e35 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e30)));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e35));
    float _e42 = inverse_root_1(4);
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(_e42);
    float _e48 = inverse_root_2(9u);
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e48);
    uint _e55 = _naga_sqrtf(floatBitsToUint(6.25));
    uint _e60 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e55)));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(uintBitsToFloat(_e60));
    uint _e68 = _naga_sqrtf(floatBitsToUint(2.0));
    uint _e73 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e68)));
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(uintBitsToFloat(_e73));
    local = 1u;
    uint _e81 = local;
    uint _e84 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e81)));
    uint _e89 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e84)));
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(uintBitsToFloat(_e89));
    local_1 = 8388607u;
    uint _e97 = local_1;
    uint _e100 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e97)));
    uint _e105 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e100)));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(uintBitsToFloat(_e105));
    local_2 = 8388608u;
    uint _e113 = local_2;
    uint _e116 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e113)));
    uint _e121 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e116)));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e121));
    local_3 = 2139095039u;
    uint _e129 = local_3;
    uint _e132 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e129)));
    uint _e137 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e132)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e137));
    local_4 = 2139095040u;
    uint _e145 = local_4;
    uint _e148 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e145)));
    uint _e153 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e148)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e153));
    uint _e162 = _naga_sqrtf(floatBitsToUint(-(1.0)));
    uint _e167 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e162)));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e167));
    local_5 = 2139095041u;
    uint _e175 = local_5;
    uint _e178 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e175)));
    uint _e183 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e178)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e183));
    value = 4.0;
    float _e191 = value;
    value = (_e191 + float(1));
    float _e195 = inverse_root(_e191);
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(_e195);
    float _e200 = value;
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(_e200);
    int _e206 = rsqrtf(true);
    _group_0_binding_0_cs[uint(16)] = uint(_e206);
    int _e212 = rsqrtf(false);
    _group_0_binding_0_cs[uint(17)] = uint(_e212);
    float _e219 = rsqrtf_1(2.0, 3.0);
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(_e219);
    local_6 = 1065353217u;
    uint _e226 = local_6;
    uint _e229 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e226)));
    uint _e234 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e229)));
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(uintBitsToFloat(_e234));
    local_7 = 1065353218u;
    uint _e242 = local_7;
    uint _e245 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e242)));
    uint _e250 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e245)));
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(uintBitsToFloat(_e250));
    local_8 = 1065353215u;
    uint _e258 = local_8;
    uint _e261 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e258)));
    uint _e266 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e261)));
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(uintBitsToFloat(_e266));
    float _e273 = inverse_root_2(4294967295u);
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(_e273);
    float _e280 = inverse_root_1(-(4));
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(_e280);
    float _e286 = inverse_root(16.0);
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(_e286);
    uint _e293 = _naga_sqrtf(floatBitsToUint(0.25));
    uint _e298 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e293)));
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(uintBitsToFloat(_e298));
    local_9 = 2147483649u;
    uint _e306 = local_9;
    uint _e309 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e306)));
    uint _e314 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e309)));
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(uintBitsToFloat(_e314));
    float _e321 = inverse_root_3(false);
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e321);
    float _e327 = inverse_root_3(true);
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e327);
    float _e333 = inverse_root(0.5);
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint(_e333);
    uint _e340 = _naga_sqrtf(floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(30)] = floatBitsToUint(uintBitsToFloat(_e340));
    uint _e348 = _naga_sqrtf(floatBitsToUint(2.0));
    uint _e353 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e348)));
    _group_0_binding_0_cs[uint(31)] = floatBitsToUint(uintBitsToFloat(_e353));
    uint _e361 = _naga_sqrtf(floatBitsToUint(2.0));
    uint _e366 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e361)));
    _group_0_binding_0_cs[uint(32)] = floatBitsToUint(uintBitsToFloat(_e366));
    value = 4.0;
    choose = false;
    bool _e375 = choose;
    if (_e375) {
        float _e376 = value;
        value = (_e376 + float(1));
        uint _e381 = _naga_sqrtf(floatBitsToUint(_e376));
        uint _e386 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e381)));
        local_10 = uintBitsToFloat(_e386);
    } else {
        float _e389 = value;
        value = (_e389 + float(1));
        uint _e394 = _naga_sqrtf(floatBitsToUint(_e389));
        uint _e399 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e394)));
        local_10 = uintBitsToFloat(_e399);
    }
    float _e403 = local_10;
    _group_0_binding_0_cs[uint(33)] = floatBitsToUint(_e403);
    float _e408 = value;
    _group_0_binding_0_cs[uint(34)] = floatBitsToUint(_e408);
    local_11 = false;
    if (false) {
        float _e415 = value;
        value = (_e415 + float(1));
        uint _e420 = _naga_sqrtf(floatBitsToUint(_e415));
        uint _e425 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e420)));
        uint _e428 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e425)));
        local_11 = (_e428 != 0u);
    }
    bool _e431 = local_11;
    _group_0_binding_0_cs[uint(35)] = uint(_e431);
    local_12 = true;
    if (true) {
    } else {
        float _e438 = value;
        value = (_e438 + float(1));
        uint _e443 = _naga_sqrtf(floatBitsToUint(_e438));
        uint _e448 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e443)));
        uint _e451 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e448)));
        local_12 = (_e451 != 0u);
    }
    bool _e454 = local_12;
    _group_0_binding_0_cs[uint(36)] = uint(_e454);
    float _e459 = value;
    _group_0_binding_0_cs[uint(37)] = floatBitsToUint(_e459);
    left = 4.0;
    right = 9.0;
    float _e468 = left;
    left = (_e468 + float(1));
    uint _e473 = _naga_sqrtf(floatBitsToUint(_e468));
    uint _e478 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e473)));
    float _e480 = right;
    right = (_e480 + float(1));
    uint _e485 = _naga_sqrtf(floatBitsToUint(_e480));
    uint _e490 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e485)));
    float _e492 = pair(uintBitsToFloat(_e478), uintBitsToFloat(_e490));
    _group_0_binding_0_cs[uint(38)] = floatBitsToUint(_e492);
    float _e497 = left;
    _group_0_binding_0_cs[uint(39)] = floatBitsToUint(_e497);
    float _e502 = right;
    _group_0_binding_0_cs[uint(40)] = floatBitsToUint(_e502);
    float _e507 = value;
    value = (_e507 + float(1));
    uint _e512 = _naga_sqrtf(floatBitsToUint(_e507));
    uint _e517 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e512)));
    float _e518 = value;
    value = (_e518 + float(1));
    uint _e523 = _naga_sqrtf(floatBitsToUint(_e518));
    uint _e528 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e523)));
    _group_0_binding_0_cs[uint(41)] = floatBitsToUint(uintBitsToFloat(_e528));
    float _e534 = value;
    _group_0_binding_0_cs[uint(42)] = floatBitsToUint(_e534);
    {
        iteration = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e567 = iteration;
                iteration = (_e567 + 1);
            }
            loop_init_2 = false;
            int _e541 = iteration;
            if ((_e541 < 2)) {
            } else {
                break;
            }
            int _e544 = iteration;
            if ((_e544 == 0)) {
                continue;
            }
            float _e547 = value;
            value = (_e547 + float(1));
            uint _e552 = _naga_sqrtf(floatBitsToUint(_e547));
            uint _e557 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e552)));
            local_13 = uint(43);
            uint _e563 = local_13;
            local_16 = _e563;
            uint _e565 = local_16;
            _group_0_binding_0_cs[_e565] = floatBitsToUint(uintBitsToFloat(_e557));
        }
    }
    float _e570 = value;
    _group_0_binding_0_cs[uint(44)] = floatBitsToUint(_e570);
    float _e575 = value;
    value = (_e575 + float(1));
    uint _e580 = _naga_sqrtf(floatBitsToUint(_e575));
    uint _e585 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e580)));
    local_14 = uintBitsToFloat(_e585);
    float _e588 = local_14;
    _group_0_binding_0_cs[uint(45)] = floatBitsToUint(_e588);
    float _e593 = value;
    _group_0_binding_0_cs[uint(46)] = floatBitsToUint(_e593);
    local_15 = true;
    if (true) {
        float _e600 = value;
        value = (_e600 + float(1));
        uint _e605 = _naga_sqrtf(floatBitsToUint(_e600));
        uint _e610 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e605)));
        uint _e613 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e610)));
        local_15 = (_e613 != 0u);
    }
    bool _e616 = local_15;
    _group_0_binding_0_cs[uint(47)] = uint(_e616);
    float _e621 = value;
    _group_0_binding_0_cs[uint(48)] = floatBitsToUint(_e621);
}

