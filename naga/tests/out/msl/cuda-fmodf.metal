// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_fmodf(
    uint dividend_bits,
    uint divisor_bits
) {
    uint dividend_significand = {};
    int dividend_exponent = {};
    uint divisor_significand = {};
    int divisor_exponent = {};
    uint remainder = {};
    uint remaining_bits = {};
    uint _e8 = dividend_bits & 2147483647u;
    uint _e9 = divisor_bits & 2147483647u;
    uint _e10 = dividend_bits & 2147483648u;
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if (_e8 < _e9) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    uint _e22 = _e8 & 8388607u;
    uint _e23 = _e8 >> 23u;
    dividend_significand = _e22 | 8388608u;
    dividend_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e23)) - as_type<uint>(127));
    if (_e23 == 0u) {
        uint _e33 = metal::clz(_e22) - 8u;
        dividend_significand = _e22 << _e33;
        dividend_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e33)));
    }
    uint _e38 = dividend_significand;
    int _e39 = dividend_exponent;
    uint _e44 = _e9 & 8388607u;
    uint _e45 = _e9 >> 23u;
    divisor_significand = _e44 | 8388608u;
    divisor_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e45)) - as_type<uint>(127));
    if (_e45 == 0u) {
        uint _e55 = metal::clz(_e44) - 8u;
        divisor_significand = _e44 << _e55;
        divisor_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e55)));
    }
    uint _e60 = divisor_significand;
    int _e61 = divisor_exponent;
    remainder = _e38;
    remaining_bits = static_cast<uint>(as_type<int>(as_type<uint>(_e39) - as_type<uint>(_e61)));
    uint2 loop_bound = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e66 = remaining_bits;
        if (_e66 == 0u) {
            break;
        }
        uint _e68 = remainder;
        remainder = ((_e68 >= _e60) ? (_e68 - _e60) : _e68) << 1u;
        remaining_bits = _e66 - 1u;
    }
    uint _e74 = remainder;
    uint _e77 = (_e74 >= _e60) ? (_e74 - _e60) : _e74;
    if (_e77 == 0u) {
        return _e10;
    }
    uint _e81 = metal::clz(_e77) - 8u;
    uint _e82 = _e77 << _e81;
    int _e84 = as_type<int>(as_type<uint>(_e61) - as_type<uint>(static_cast<int>(_e81)));
    return _e10 | ((_e84 >= -126) ? ((static_cast<uint>(as_type<int>(as_type<uint>(_e84) + as_type<uint>(127))) << 23u) | (_e82 & 8388607u)) : (_e82 >> (static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e84))) & 31u)));
}

float sample_remainder(
    float numerator,
    float denominator_1
) {
    uint _e4 = _naga_fmodf(as_type<uint>(numerator), as_type<uint>(denominator_1));
    return as_type<float>(_e4);
}

int fmodf(
    bool numerator_1,
    bool denominator_2
) {
    int local_32 = {};
    if (numerator_1) {
        local_32 = 7;
    } else {
        local_32 = 9;
    }
    int _e6 = local_32;
    return _e6;
}

float fmodf_1(
    float first,
    float second,
    float third
) {
    return (first + second) + third;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void remainders(
  device type_4& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    float value = {};
    float denominator = {};
    bool choose = {};
    float local_19 = {};
    bool local_20 = {};
    bool local_21 = {};
    float local_22 = {};
    int iteration = {};
    uint local_23 = {};
    bool local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint _e4 = _naga_fmodf(as_type<uint>(5.5), as_type<uint>(2.0));
    output[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e4));
    uint _e16 = _naga_fmodf(as_type<uint>(-(5.5)), as_type<uint>(2.0));
    output[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e16));
    uint _e27 = _naga_fmodf(as_type<uint>(5.5), as_type<uint>(-(2.0)));
    output[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e27));
    uint _e39 = _naga_fmodf(as_type<uint>(-(5.5)), as_type<uint>(-(2.0)));
    output[static_cast<uint>(3)] = as_type<uint>(as_type<float>(_e39));
    uint _e49 = _naga_fmodf(as_type<uint>(4.0), as_type<uint>(2.0));
    output[static_cast<uint>(4)] = as_type<uint>(as_type<float>(_e49));
    uint _e60 = _naga_fmodf(as_type<uint>(-(4.0)), as_type<uint>(2.0));
    output[static_cast<uint>(5)] = as_type<uint>(as_type<float>(_e60));
    uint _e71 = _naga_fmodf(as_type<uint>(0.0), as_type<uint>(-(2.0)));
    output[static_cast<uint>(6)] = as_type<uint>(as_type<float>(_e71));
    uint _e82 = _naga_fmodf(as_type<uint>(-(0.0)), as_type<uint>(2.0));
    output[static_cast<uint>(7)] = as_type<uint>(as_type<float>(_e82));
    uint _e92 = _naga_fmodf(as_type<uint>(1.0), as_type<uint>(3.0));
    output[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e92));
    uint _e102 = _naga_fmodf(as_type<uint>(3.0), as_type<uint>(1.0));
    output[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e102));
    local = 2139095039u;
    uint _e110 = local;
    local_1 = 1u;
    uint _e114 = local_1;
    uint _e118 = _naga_fmodf(as_type<uint>(as_type<float>(_e110)), as_type<uint>(as_type<float>(_e114)));
    output[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e118));
    local_2 = 4286578687u;
    uint _e126 = local_2;
    local_3 = 1u;
    uint _e130 = local_3;
    uint _e134 = _naga_fmodf(as_type<uint>(as_type<float>(_e126)), as_type<uint>(as_type<float>(_e130)));
    output[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e134));
    local_4 = 8388608u;
    uint _e142 = local_4;
    local_5 = 3u;
    uint _e146 = local_5;
    uint _e150 = _naga_fmodf(as_type<uint>(as_type<float>(_e142)), as_type<uint>(as_type<float>(_e146)));
    output[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e150));
    local_6 = 8388607u;
    uint _e158 = local_6;
    local_7 = 3u;
    uint _e162 = local_7;
    uint _e166 = _naga_fmodf(as_type<uint>(as_type<float>(_e158)), as_type<uint>(as_type<float>(_e162)));
    output[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e166));
    local_8 = 1u;
    uint _e174 = local_8;
    local_9 = 8388608u;
    uint _e178 = local_9;
    uint _e182 = _naga_fmodf(as_type<uint>(as_type<float>(_e174)), as_type<uint>(as_type<float>(_e178)));
    output[static_cast<uint>(14)] = as_type<uint>(as_type<float>(_e182));
    local_10 = 1065353217u;
    uint _e190 = local_10;
    uint _e195 = _naga_fmodf(as_type<uint>(as_type<float>(_e190)), as_type<uint>(1.0));
    output[static_cast<uint>(15)] = as_type<uint>(as_type<float>(_e195));
    local_11 = 1065353217u;
    uint _e203 = local_11;
    uint _e208 = _naga_fmodf(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e203)));
    output[static_cast<uint>(16)] = as_type<uint>(as_type<float>(_e208));
    local_12 = 2139095041u;
    uint _e216 = local_12;
    uint _e221 = _naga_fmodf(as_type<uint>(as_type<float>(_e216)), as_type<uint>(2.0));
    output[static_cast<uint>(17)] = as_type<uint>(as_type<float>(_e221));
    local_13 = 2143363909u;
    uint _e229 = local_13;
    uint _e234 = _naga_fmodf(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e229)));
    output[static_cast<uint>(18)] = as_type<uint>(as_type<float>(_e234));
    local_14 = 2139095040u;
    uint _e242 = local_14;
    uint _e247 = _naga_fmodf(as_type<uint>(as_type<float>(_e242)), as_type<uint>(2.0));
    output[static_cast<uint>(19)] = as_type<uint>(as_type<float>(_e247));
    local_15 = 4286578688u;
    uint _e255 = local_15;
    local_16 = 2139095040u;
    uint _e259 = local_16;
    uint _e263 = _naga_fmodf(as_type<uint>(as_type<float>(_e255)), as_type<uint>(as_type<float>(_e259)));
    output[static_cast<uint>(20)] = as_type<uint>(as_type<float>(_e263));
    uint _e273 = _naga_fmodf(as_type<uint>(1.0), as_type<uint>(0.0));
    output[static_cast<uint>(21)] = as_type<uint>(as_type<float>(_e273));
    uint _e283 = _naga_fmodf(as_type<uint>(0.0), as_type<uint>(0.0));
    output[static_cast<uint>(22)] = as_type<uint>(as_type<float>(_e283));
    local_17 = 2139095040u;
    uint _e291 = local_17;
    uint _e296 = _naga_fmodf(as_type<uint>(5.5), as_type<uint>(as_type<float>(_e291)));
    output[static_cast<uint>(23)] = as_type<uint>(as_type<float>(_e296));
    local_18 = 4286578688u;
    uint _e306 = local_18;
    uint _e310 = _naga_fmodf(as_type<uint>(-(5.5)), as_type<uint>(as_type<float>(_e306)));
    output[static_cast<uint>(24)] = as_type<uint>(as_type<float>(_e310));
    float _e320 = sample_remainder(static_cast<float>(7), static_cast<float>(3));
    output[static_cast<uint>(25)] = as_type<uint>(_e320);
    float _e329 = sample_remainder(static_cast<float>(7u), static_cast<float>(3u));
    output[static_cast<uint>(26)] = as_type<uint>(_e329);
    float _e338 = sample_remainder(static_cast<float>(true), static_cast<float>(true));
    output[static_cast<uint>(27)] = as_type<uint>(_e338);
    float _e347 = sample_remainder(static_cast<float>(false), static_cast<float>(true));
    output[static_cast<uint>(28)] = as_type<uint>(_e347);
    int _e354 = fmodf(true, false);
    output[static_cast<uint>(29)] = static_cast<uint>(_e354);
    int _e361 = fmodf(false, true);
    output[static_cast<uint>(30)] = static_cast<uint>(_e361);
    float _e369 = fmodf_1(1.0, 2.0, 3.0);
    output[static_cast<uint>(31)] = as_type<uint>(_e369);
    value = 5.5;
    float _e376 = value;
    value = _e376 + static_cast<float>(1);
    uint _e383 = _naga_fmodf(as_type<uint>(_e376), as_type<uint>(2.0));
    output[static_cast<uint>(32)] = as_type<uint>(as_type<float>(_e383));
    float _e389 = value;
    output[static_cast<uint>(33)] = as_type<uint>(_e389);
    denominator = 2.0;
    float _e396 = denominator;
    denominator = _e396 + static_cast<float>(1);
    uint _e403 = _naga_fmodf(as_type<uint>(7.0), as_type<uint>(_e396));
    output[static_cast<uint>(34)] = as_type<uint>(as_type<float>(_e403));
    float _e409 = denominator;
    output[static_cast<uint>(35)] = as_type<uint>(_e409);
    value = 5.5;
    float _e415 = value;
    value = _e415 + static_cast<float>(1);
    float _e419 = value;
    value = _e419 + static_cast<float>(1);
    uint _e425 = _naga_fmodf(as_type<uint>(_e415), as_type<uint>(_e419));
    output[static_cast<uint>(36)] = as_type<uint>(as_type<float>(_e425));
    float _e431 = value;
    output[static_cast<uint>(37)] = as_type<uint>(_e431);
    choose = false;
    bool _e438 = choose;
    if (_e438) {
        float _e439 = value;
        value = _e439 + static_cast<float>(1);
        uint _e446 = _naga_fmodf(as_type<uint>(_e439), as_type<uint>(2.0));
        local_19 = as_type<float>(_e446);
    } else {
        float _e449 = value;
        value = _e449 + static_cast<float>(1);
        uint _e456 = _naga_fmodf(as_type<uint>(_e449), as_type<uint>(3.0));
        local_19 = as_type<float>(_e456);
    }
    float _e460 = local_19;
    output[static_cast<uint>(38)] = as_type<uint>(_e460);
    float _e465 = value;
    output[static_cast<uint>(39)] = as_type<uint>(_e465);
    local_20 = false;
    if (false) {
        float _e472 = value;
        value = _e472 + static_cast<float>(1);
        uint _e479 = _naga_fmodf(as_type<uint>(_e472), as_type<uint>(2.0));
        local_20 = as_type<float>(_e479) != 0.0;
    }
    bool _e483 = local_20;
    output[static_cast<uint>(40)] = static_cast<uint>(_e483);
    local_21 = true;
    if (true) {
    } else {
        float _e490 = value;
        value = _e490 + static_cast<float>(1);
        uint _e497 = _naga_fmodf(as_type<uint>(_e490), as_type<uint>(2.0));
        local_21 = as_type<float>(_e497) != 0.0;
    }
    bool _e501 = local_21;
    output[static_cast<uint>(41)] = static_cast<uint>(_e501);
    float _e506 = value;
    output[static_cast<uint>(42)] = as_type<uint>(_e506);
    float _e511 = value;
    value = _e511 + static_cast<float>(1);
    uint _e518 = _naga_fmodf(as_type<uint>(_e511), as_type<uint>(2.0));
    float _e519 = value;
    value = _e519 + static_cast<float>(1);
    uint _e526 = _naga_fmodf(as_type<uint>(_e519), as_type<uint>(3.0));
    output[static_cast<uint>(43)] = as_type<uint>(as_type<float>(_e526));
    float _e532 = value;
    output[static_cast<uint>(44)] = as_type<uint>(_e532);
    float _e537 = value;
    value = _e537 + static_cast<float>(1);
    uint _e544 = _naga_fmodf(as_type<uint>(_e537), as_type<uint>(3.0));
    local_22 = as_type<float>(_e544);
    float _e547 = local_22;
    output[static_cast<uint>(45)] = as_type<uint>(_e547);
    float _e552 = value;
    output[static_cast<uint>(46)] = as_type<uint>(_e552);
    {
        iteration = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init) {
                int _e582 = iteration;
                iteration = as_type<int>(as_type<uint>(_e582) + as_type<uint>(1));
            }
            loop_init = false;
            int _e559 = iteration;
            if (_e559 < 2) {
            } else {
                break;
            }
            int _e562 = iteration;
            if (_e562 == 0) {
                continue;
            }
            float _e565 = value;
            value = _e565 + static_cast<float>(1);
            uint _e572 = _naga_fmodf(as_type<uint>(_e565), as_type<uint>(2.0));
            local_23 = static_cast<uint>(47);
            uint _e578 = local_23;
            local_31 = _e578;
            uint _e580 = local_31;
            output[_e580] = as_type<uint>(as_type<float>(_e572));
        }
    }
    float _e585 = value;
    output[static_cast<uint>(48)] = as_type<uint>(_e585);
    local_24 = true;
    if (true) {
        float _e592 = value;
        value = _e592 + static_cast<float>(1);
        uint _e599 = _naga_fmodf(as_type<uint>(_e592), as_type<uint>(2.0));
        local_24 = as_type<float>(_e599) != 0.0;
    }
    bool _e603 = local_24;
    output[static_cast<uint>(49)] = static_cast<uint>(_e603);
    float _e608 = value;
    output[static_cast<uint>(50)] = as_type<uint>(_e608);
    float _e617 = sample_remainder(static_cast<float>(4294967295u), static_cast<float>(3u));
    output[static_cast<uint>(51)] = as_type<uint>(_e617);
    float _e629 = sample_remainder(static_cast<float>(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1))), static_cast<float>(3));
    output[static_cast<uint>(52)] = as_type<uint>(_e629);
    uint _e638 = _naga_fmodf(as_type<uint>(0.5), as_type<uint>(0.25));
    output[static_cast<uint>(53)] = as_type<uint>(as_type<float>(_e638));
    uint _e649 = _naga_fmodf(as_type<uint>(-(0.5)), as_type<uint>(0.25));
    output[static_cast<uint>(54)] = as_type<uint>(as_type<float>(_e649));
    local_25 = 2147483647u;
    uint _e657 = local_25;
    uint _e662 = _naga_fmodf(as_type<uint>(as_type<float>(_e657)), as_type<uint>(1.0));
    output[static_cast<uint>(55)] = as_type<uint>(as_type<float>(_e662));
    float _e670 = sample_remainder(3.25, 2.0);
    output[static_cast<uint>(56)] = as_type<uint>(_e670);
    uint _e679 = _naga_fmodf(as_type<uint>(5.5), as_type<uint>(2.0));
    uint _e684 = _naga_fmodf(as_type<uint>(1.5), as_type<uint>(as_type<float>(_e679)));
    output[static_cast<uint>(57)] = as_type<uint>(as_type<float>(_e684));
    uint _e694 = _naga_fmodf(as_type<uint>(8.5), as_type<uint>(3.0));
    uint _e699 = _naga_fmodf(as_type<uint>(as_type<float>(_e694)), as_type<uint>(2.0));
    output[static_cast<uint>(58)] = as_type<uint>(as_type<float>(_e699));
    local_26 = 2139095040u;
    uint _e709 = local_26;
    uint _e713 = _naga_fmodf(as_type<uint>(-(0.0)), as_type<uint>(as_type<float>(_e709)));
    output[static_cast<uint>(59)] = as_type<uint>(as_type<float>(_e713));
    local_27 = 1u;
    uint _e721 = local_27;
    local_28 = 4286578688u;
    uint _e725 = local_28;
    uint _e729 = _naga_fmodf(as_type<uint>(as_type<float>(_e721)), as_type<uint>(as_type<float>(_e725)));
    output[static_cast<uint>(60)] = as_type<uint>(as_type<float>(_e729));
    local_29 = 8388609u;
    uint _e737 = local_29;
    local_30 = 8388607u;
    uint _e741 = local_30;
    uint _e745 = _naga_fmodf(as_type<uint>(as_type<float>(_e737)), as_type<uint>(as_type<float>(_e741)));
    output[static_cast<uint>(61)] = as_type<uint>(as_type<float>(_e745));
}
