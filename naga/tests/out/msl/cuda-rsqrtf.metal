// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_sqrtf(
    uint input_bits
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration_1 = {};
    uint _e5 = input_bits & 2147483647u;
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits & 8388607u;
    uint _e20 = _e5 >> 23u;
    significand = _e19 | 8388608u;
    adjusted_exponent = _e20 + 127u;
    if (_e20 == 0u) {
        uint _e28 = metal::clz(_e19) - 8u;
        significand = _e19 << _e28;
        adjusted_exponent = 128u - _e28;
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = _e33 & 1u;
    upper_word = _e32 >> (9u - _e34);
    lower_word = _e32 << (23u + _e34);
    root = 0u;
    remainder = 0u;
    iteration_1 = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration_1;
            iteration_1 = _e72 + 1u;
        }
        loop_init = false;
        uint _e50 = iteration_1;
        if (_e50 >= 24u) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = (_e55 << 2u) | (_e52 >> 14u);
        uint _e65 = (_e54 << 2u) | 1u;
        bool _e66 = _e63 >= _e65;
        uint _e69 = _e54 << 1u;
        upper_word = ((_e52 << 2u) | (_e53 >> 30u)) & 65535u;
        lower_word = _e53 << 2u;
        remainder = _e66 ? (_e63 - _e65) : _e63;
        root = _e66 ? (_e69 | 1u) : _e69;
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return ((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u);
}

uint _naga_divide_f32_(
    uint numerator_bits,
    uint denominator_bits
) {
    uint numerator_significand = {};
    int numerator_exponent = {};
    uint denominator_significand = {};
    int denominator_exponent = {};
    uint quotient = {};
    uint remainder_1 = {};
    uint iteration_2 = {};
    uint _e8 = numerator_bits & 2147483647u;
    uint _e9 = denominator_bits & 2147483647u;
    uint _e11 = (numerator_bits ^ denominator_bits) & 2147483648u;
    uint _e12 = _e11 | 2139095040u;
    bool _e16 = _e8 == 0u;
    bool _e17 = _e9 == 0u;
    bool _e19 = _e8 == 2139095040u;
    bool _e20 = _e9 == 2139095040u;
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    uint _e30 = _e8 & 8388607u;
    uint _e31 = _e8 >> 23u;
    numerator_significand = _e30 | 8388608u;
    numerator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e31)) - as_type<uint>(127));
    if (_e31 == 0u) {
        uint _e41 = metal::clz(_e30) - 8u;
        numerator_significand = _e30 << _e41;
        numerator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = _e9 & 8388607u;
    uint _e53 = _e9 >> 23u;
    denominator_significand = _e52 | 8388608u;
    denominator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e53)) - as_type<uint>(127));
    if (_e53 == 0u) {
        uint _e63 = metal::clz(_e52) - 8u;
        denominator_significand = _e52 << _e63;
        denominator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = _e46 < _e68;
    int _e75 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e47) - as_type<uint>(_e69))) - as_type<uint>(static_cast<int>(_e70)));
    if (_e75 < -150) {
        return _e11;
    }
    quotient = 1u;
    remainder_1 = (_e70 ? (_e46 << 1u) : _e46) - _e68;
    iteration_2 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e94 = iteration_2;
            iteration_2 = _e94 + 1u;
        }
        loop_init_1 = false;
        uint _e83 = iteration_2;
        if (_e83 >= 23u) {
            break;
        }
        uint _e85 = remainder_1;
        uint _e86 = quotient;
        uint _e87 = _e85 << 1u;
        bool _e88 = _e87 >= _e68;
        remainder_1 = _e88 ? (_e87 - _e68) : _e87;
        quotient = (_e86 << 1u) | (_e88 ? 1u : 0u);
    }
    uint _e96 = quotient;
    uint _e97 = remainder_1;
    if (_e75 < -126) {
        uint _e103 = static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e75))) & 31u;
        uint _e104 = 1u << _e103;
        uint _e106 = _e96 & (_e104 - 1u);
        uint _e107 = _e104 >> 1u;
        uint _e108 = _e96 >> _e103;
        return _e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u));
    }
    uint _e120 = _e97 << 1u;
    uint _e128 = _e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u);
    uint _e130 = _e128 >> 24u;
    int _e133 = as_type<int>(as_type<uint>(_e75) + as_type<uint>(static_cast<int>(_e130)));
    if (_e133 > 127) {
        return _e12;
    }
    return _e11 | ((static_cast<uint>(as_type<int>(as_type<uint>(_e133) + as_type<uint>(127))) << 23u) | ((_e128 >> _e130) & 8388607u));
}

float inverse_root(
    float value_1
) {
    uint _e2 = _naga_sqrtf(as_type<uint>(value_1));
    uint _e7 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e2)));
    return as_type<float>(_e7);
}

float inverse_root_1(
    int value_2
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_2)));
    uint _e8 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e3)));
    return as_type<float>(_e8);
}

float inverse_root_2(
    uint value_3
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_3)));
    uint _e8 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e3)));
    return as_type<float>(_e8);
}

float inverse_root_3(
    bool value_4
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_4)));
    uint _e8 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e3)));
    return as_type<float>(_e8);
}

int rsqrtf(
    bool value_5
) {
    int local_17 = {};
    if (value_5) {
        local_17 = 7;
    } else {
        local_17 = 9;
    }
    int _e6 = local_17;
    return _e6;
}

float rsqrtf_1(
    float first,
    float second
) {
    return first + second;
}

float pair(
    float first_1,
    float second_1
) {
    return (first_1 * 10.0) + second_1;
}

uint _naga_fabsf(
    uint input_bits_1
) {
    uint _e2 = input_bits_1 & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void inverse_roots(
  device type_4& out [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    float value = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    bool choose = {};
    float local_10 = {};
    bool local_11 = {};
    bool local_12 = {};
    float left = {};
    float right = {};
    int iteration = {};
    uint local_13 = {};
    float local_14 = {};
    bool local_15 = {};
    uint local_16 = {};
    uint _e2 = _naga_sqrtf(as_type<uint>(0.0));
    uint _e7 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e2)));
    out[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e7));
    uint _e17 = _naga_sqrtf(as_type<uint>(-(0.0)));
    uint _e22 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e17)));
    out[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e22));
    uint _e30 = _naga_sqrtf(as_type<uint>(1.0));
    uint _e35 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e30)));
    out[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e35));
    float _e42 = inverse_root_1(4);
    out[static_cast<uint>(3)] = as_type<uint>(_e42);
    float _e48 = inverse_root_2(9u);
    out[static_cast<uint>(4)] = as_type<uint>(_e48);
    uint _e55 = _naga_sqrtf(as_type<uint>(6.25));
    uint _e60 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e55)));
    out[static_cast<uint>(5)] = as_type<uint>(as_type<float>(_e60));
    uint _e68 = _naga_sqrtf(as_type<uint>(2.0));
    uint _e73 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e68)));
    out[static_cast<uint>(6)] = as_type<uint>(as_type<float>(_e73));
    local = 1u;
    uint _e81 = local;
    uint _e84 = _naga_sqrtf(as_type<uint>(as_type<float>(_e81)));
    uint _e89 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e84)));
    out[static_cast<uint>(7)] = as_type<uint>(as_type<float>(_e89));
    local_1 = 8388607u;
    uint _e97 = local_1;
    uint _e100 = _naga_sqrtf(as_type<uint>(as_type<float>(_e97)));
    uint _e105 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e100)));
    out[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e105));
    local_2 = 8388608u;
    uint _e113 = local_2;
    uint _e116 = _naga_sqrtf(as_type<uint>(as_type<float>(_e113)));
    uint _e121 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e116)));
    out[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e121));
    local_3 = 2139095039u;
    uint _e129 = local_3;
    uint _e132 = _naga_sqrtf(as_type<uint>(as_type<float>(_e129)));
    uint _e137 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e132)));
    out[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e137));
    local_4 = 2139095040u;
    uint _e145 = local_4;
    uint _e148 = _naga_sqrtf(as_type<uint>(as_type<float>(_e145)));
    uint _e153 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e148)));
    out[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e153));
    uint _e162 = _naga_sqrtf(as_type<uint>(-(1.0)));
    uint _e167 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e162)));
    out[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e167));
    local_5 = 2139095041u;
    uint _e175 = local_5;
    uint _e178 = _naga_sqrtf(as_type<uint>(as_type<float>(_e175)));
    uint _e183 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e178)));
    out[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e183));
    value = 4.0;
    float _e191 = value;
    value = _e191 + static_cast<float>(1);
    float _e195 = inverse_root(_e191);
    out[static_cast<uint>(14)] = as_type<uint>(_e195);
    float _e200 = value;
    out[static_cast<uint>(15)] = as_type<uint>(_e200);
    int _e206 = rsqrtf(true);
    out[static_cast<uint>(16)] = static_cast<uint>(_e206);
    int _e212 = rsqrtf(false);
    out[static_cast<uint>(17)] = static_cast<uint>(_e212);
    float _e219 = rsqrtf_1(2.0, 3.0);
    out[static_cast<uint>(18)] = as_type<uint>(_e219);
    local_6 = 1065353217u;
    uint _e226 = local_6;
    uint _e229 = _naga_sqrtf(as_type<uint>(as_type<float>(_e226)));
    uint _e234 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e229)));
    out[static_cast<uint>(19)] = as_type<uint>(as_type<float>(_e234));
    local_7 = 1065353218u;
    uint _e242 = local_7;
    uint _e245 = _naga_sqrtf(as_type<uint>(as_type<float>(_e242)));
    uint _e250 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e245)));
    out[static_cast<uint>(20)] = as_type<uint>(as_type<float>(_e250));
    local_8 = 1065353215u;
    uint _e258 = local_8;
    uint _e261 = _naga_sqrtf(as_type<uint>(as_type<float>(_e258)));
    uint _e266 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e261)));
    out[static_cast<uint>(21)] = as_type<uint>(as_type<float>(_e266));
    float _e273 = inverse_root_2(4294967295u);
    out[static_cast<uint>(22)] = as_type<uint>(_e273);
    float _e280 = inverse_root_1(naga_neg(4));
    out[static_cast<uint>(23)] = as_type<uint>(_e280);
    float _e286 = inverse_root(16.0);
    out[static_cast<uint>(24)] = as_type<uint>(_e286);
    uint _e293 = _naga_sqrtf(as_type<uint>(0.25));
    uint _e298 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e293)));
    out[static_cast<uint>(25)] = as_type<uint>(as_type<float>(_e298));
    local_9 = 2147483649u;
    uint _e306 = local_9;
    uint _e309 = _naga_sqrtf(as_type<uint>(as_type<float>(_e306)));
    uint _e314 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e309)));
    out[static_cast<uint>(26)] = as_type<uint>(as_type<float>(_e314));
    float _e321 = inverse_root_3(false);
    out[static_cast<uint>(27)] = as_type<uint>(_e321);
    float _e327 = inverse_root_3(true);
    out[static_cast<uint>(28)] = as_type<uint>(_e327);
    float _e333 = inverse_root(0.5);
    out[static_cast<uint>(29)] = as_type<uint>(_e333);
    uint _e340 = _naga_sqrtf(as_type<uint>(2.0));
    out[static_cast<uint>(30)] = as_type<uint>(as_type<float>(_e340));
    uint _e348 = _naga_sqrtf(as_type<uint>(2.0));
    uint _e353 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e348)));
    out[static_cast<uint>(31)] = as_type<uint>(as_type<float>(_e353));
    uint _e361 = _naga_sqrtf(as_type<uint>(2.0));
    uint _e366 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e361)));
    out[static_cast<uint>(32)] = as_type<uint>(as_type<float>(_e366));
    value = 4.0;
    choose = false;
    bool _e375 = choose;
    if (_e375) {
        float _e376 = value;
        value = _e376 + static_cast<float>(1);
        uint _e381 = _naga_sqrtf(as_type<uint>(_e376));
        uint _e386 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e381)));
        local_10 = as_type<float>(_e386);
    } else {
        float _e389 = value;
        value = _e389 + static_cast<float>(1);
        uint _e394 = _naga_sqrtf(as_type<uint>(_e389));
        uint _e399 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e394)));
        local_10 = as_type<float>(_e399);
    }
    float _e403 = local_10;
    out[static_cast<uint>(33)] = as_type<uint>(_e403);
    float _e408 = value;
    out[static_cast<uint>(34)] = as_type<uint>(_e408);
    local_11 = false;
    if (false) {
        float _e415 = value;
        value = _e415 + static_cast<float>(1);
        uint _e420 = _naga_sqrtf(as_type<uint>(_e415));
        uint _e425 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e420)));
        uint _e428 = _naga_fabsf(as_type<uint>(as_type<float>(_e425)));
        local_11 = _e428 != 0u;
    }
    bool _e431 = local_11;
    out[static_cast<uint>(35)] = static_cast<uint>(_e431);
    local_12 = true;
    if (true) {
    } else {
        float _e438 = value;
        value = _e438 + static_cast<float>(1);
        uint _e443 = _naga_sqrtf(as_type<uint>(_e438));
        uint _e448 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e443)));
        uint _e451 = _naga_fabsf(as_type<uint>(as_type<float>(_e448)));
        local_12 = _e451 != 0u;
    }
    bool _e454 = local_12;
    out[static_cast<uint>(36)] = static_cast<uint>(_e454);
    float _e459 = value;
    out[static_cast<uint>(37)] = as_type<uint>(_e459);
    left = 4.0;
    right = 9.0;
    float _e468 = left;
    left = _e468 + static_cast<float>(1);
    uint _e473 = _naga_sqrtf(as_type<uint>(_e468));
    uint _e478 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e473)));
    float _e480 = right;
    right = _e480 + static_cast<float>(1);
    uint _e485 = _naga_sqrtf(as_type<uint>(_e480));
    uint _e490 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e485)));
    float _e492 = pair(as_type<float>(_e478), as_type<float>(_e490));
    out[static_cast<uint>(38)] = as_type<uint>(_e492);
    float _e497 = left;
    out[static_cast<uint>(39)] = as_type<uint>(_e497);
    float _e502 = right;
    out[static_cast<uint>(40)] = as_type<uint>(_e502);
    float _e507 = value;
    value = _e507 + static_cast<float>(1);
    uint _e512 = _naga_sqrtf(as_type<uint>(_e507));
    uint _e517 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e512)));
    float _e518 = value;
    value = _e518 + static_cast<float>(1);
    uint _e523 = _naga_sqrtf(as_type<uint>(_e518));
    uint _e528 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e523)));
    out[static_cast<uint>(41)] = as_type<uint>(as_type<float>(_e528));
    float _e534 = value;
    out[static_cast<uint>(42)] = as_type<uint>(_e534);
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e567 = iteration;
                iteration = as_type<int>(as_type<uint>(_e567) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e541 = iteration;
            if (_e541 < 2) {
            } else {
                break;
            }
            int _e544 = iteration;
            if (_e544 == 0) {
                continue;
            }
            float _e547 = value;
            value = _e547 + static_cast<float>(1);
            uint _e552 = _naga_sqrtf(as_type<uint>(_e547));
            uint _e557 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e552)));
            local_13 = static_cast<uint>(43);
            uint _e563 = local_13;
            local_16 = _e563;
            uint _e565 = local_16;
            out[_e565] = as_type<uint>(as_type<float>(_e557));
        }
    }
    float _e570 = value;
    out[static_cast<uint>(44)] = as_type<uint>(_e570);
    float _e575 = value;
    value = _e575 + static_cast<float>(1);
    uint _e580 = _naga_sqrtf(as_type<uint>(_e575));
    uint _e585 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e580)));
    local_14 = as_type<float>(_e585);
    float _e588 = local_14;
    out[static_cast<uint>(45)] = as_type<uint>(_e588);
    float _e593 = value;
    out[static_cast<uint>(46)] = as_type<uint>(_e593);
    local_15 = true;
    if (true) {
        float _e600 = value;
        value = _e600 + static_cast<float>(1);
        uint _e605 = _naga_sqrtf(as_type<uint>(_e600));
        uint _e610 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e605)));
        uint _e613 = _naga_fabsf(as_type<uint>(as_type<float>(_e610)));
        local_15 = _e613 != 0u;
    }
    bool _e616 = local_15;
    out[static_cast<uint>(47)] = static_cast<uint>(_e616);
    float _e621 = value;
    out[static_cast<uint>(48)] = as_type<uint>(_e621);
}
