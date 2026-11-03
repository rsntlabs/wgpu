// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct Ratio_cuda_record_0_ {
    float value;
};
typedef uint type_4[1];
struct type_5 {
    float inner[2];
};

uint _naga_divide_f32_(
    uint numerator_bits,
    uint denominator_bits
) {
    uint numerator_significand = {};
    int numerator_exponent = {};
    uint denominator_significand = {};
    int denominator_exponent = {};
    uint quotient = {};
    uint remainder = {};
    uint iteration_1 = {};
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
    remainder = (_e70 ? (_e46 << 1u) : _e46) - _e68;
    iteration_1 = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e94 = iteration_1;
            iteration_1 = _e94 + 1u;
        }
        loop_init = false;
        uint _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        uint _e85 = remainder;
        uint _e86 = quotient;
        uint _e87 = _e85 << 1u;
        bool _e88 = _e87 >= _e68;
        remainder = _e88 ? (_e87 - _e68) : _e87;
        quotient = (_e86 << 1u) | (_e88 ? 1u : 0u);
    }
    uint _e96 = quotient;
    uint _e97 = remainder;
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

float quotient_1(
    float numerator,
    float denominator
) {
    uint _e4 = _naga_divide_f32_(as_type<uint>(numerator), as_type<uint>(denominator));
    return as_type<float>(_e4);
}

metal::float4 operator_u002f(
    metal::float4 left_1,
    metal::float4 right_4
) {
    metal::float4 left_2 = {};
    metal::float4 right_5 = {};
    left_2 = left_1;
    right_5 = right_4;
    float _e6 = left_2.x;
    float _e7 = right_5.x;
    uint _e10 = _naga_divide_f32_(as_type<uint>(_e6), as_type<uint>(_e7));
    float _e14 = left_2.y;
    float _e15 = right_5.y;
    uint _e18 = _naga_divide_f32_(as_type<uint>(_e14), as_type<uint>(_e15));
    float _e22 = left_2.z;
    float _e23 = right_5.z;
    uint _e26 = _naga_divide_f32_(as_type<uint>(_e22), as_type<uint>(_e23));
    float _e30 = left_2.w;
    float _e31 = right_5.w;
    uint _e34 = _naga_divide_f32_(as_type<uint>(_e30), as_type<uint>(_e31));
    return metal::float4(as_type<float>(_e10), as_type<float>(_e18), as_type<float>(_e26), as_type<float>(_e34));
}

metal::float4 operator_u002f_1(
    metal::float4 left_3,
    float right_6
) {
    metal::float4 left_4 = {};
    left_4 = left_3;
    float _e4 = left_4.x;
    uint _e7 = _naga_divide_f32_(as_type<uint>(_e4), as_type<uint>(right_6));
    float _e10 = left_4.y;
    uint _e13 = _naga_divide_f32_(as_type<uint>(_e10), as_type<uint>(right_6));
    float _e16 = left_4.z;
    uint _e19 = _naga_divide_f32_(as_type<uint>(_e16), as_type<uint>(right_6));
    float _e22 = left_4.w;
    uint _e25 = _naga_divide_f32_(as_type<uint>(_e22), as_type<uint>(right_6));
    return metal::float4(as_type<float>(_e7), as_type<float>(_e13), as_type<float>(_e19), as_type<float>(_e25));
}

metal::float4 operator_u002f_2(
    float left_5,
    metal::float4 right_7
) {
    metal::float4 right_8 = {};
    right_8 = right_7;
    float _e4 = right_8.x;
    uint _e7 = _naga_divide_f32_(as_type<uint>(left_5), as_type<uint>(_e4));
    float _e10 = right_8.y;
    uint _e13 = _naga_divide_f32_(as_type<uint>(left_5), as_type<uint>(_e10));
    float _e16 = right_8.z;
    uint _e19 = _naga_divide_f32_(as_type<uint>(left_5), as_type<uint>(_e16));
    float _e22 = right_8.w;
    uint _e25 = _naga_divide_f32_(as_type<uint>(left_5), as_type<uint>(_e22));
    return metal::float4(as_type<float>(_e7), as_type<float>(_e13), as_type<float>(_e19), as_type<float>(_e25));
}

float operator_u002f_3(
    Ratio_cuda_record_0_ left_6,
    Ratio_cuda_record_0_ right_9
) {
    Ratio_cuda_record_0_ left_7 = {};
    Ratio_cuda_record_0_ right_10 = {};
    left_7 = left_6;
    right_10 = right_9;
    float _e6 = left_7.value;
    float _e7 = right_10.value;
    return _e6 + _e7;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int naga_div(int lhs, int rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}


kernel void divisions(
  device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    metal::float4 values = {};
    metal::float4 divisors = {};
    metal::float4 divided = {};
    float scalar = {};
    type_5 bank = {};
    uint index = {};
    float divisor = {};
    Ratio_cuda_record_0_ first = {};
    Ratio_cuda_record_0_ second = {};
    Ratio_cuda_record_0_ updated = {};
    Ratio_cuda_record_0_ local = {};
    float third = {};
    float left = {};
    float right = {};
    float selected_numerator = {};
    float selected_denominator = {};
    bool choose = {};
    float local_1 = {};
    bool local_2 = {};
    bool local_3 = {};
    float scale = {};
    int iteration = {};
    float local_4 = {};
    metal::float4 right_1 = {};
    metal::float4 local_5 = {};
    float right_2 = {};
    metal::float4 local_6 = {};
    float right_3 = {};
    Ratio_cuda_record_0_ local_7 = {};
    uint _e4 = input[static_cast<uint>(0)];
    float numerator_1 = as_type<float>(_e4);
    uint _e9 = input[static_cast<uint>(1)];
    float denominator_1 = as_type<float>(_e9);
    uint _e13 = _naga_divide_f32_(as_type<uint>(numerator_1), as_type<uint>(denominator_1));
    output[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e13));
    float _e20 = quotient_1(numerator_1, denominator_1);
    output[static_cast<uint>(1)] = as_type<uint>(_e20);
    uint _e29 = _naga_divide_f32_(as_type<uint>(numerator_1), as_type<uint>(static_cast<float>(3)));
    output[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e29));
    uint _e39 = _naga_divide_f32_(as_type<uint>(static_cast<float>(3)), as_type<uint>(numerator_1));
    output[static_cast<uint>(3)] = as_type<uint>(as_type<float>(_e39));
    uint _e50 = input[static_cast<uint>(3)];
    values = metal::float4(numerator_1, 1.0, -(0.0), as_type<float>(_e50));
    divisors = metal::float4(denominator_1, 3.0, 3.0, 2.0);
    metal::float4 _e60 = values;
    metal::float4 _e61 = divisors;
    metal::float4 _e62 = operator_u002f(_e60, _e61);
    divided = _e62;
    float _e65 = divided.x;
    output[static_cast<uint>(4)] = as_type<uint>(_e65);
    float _e71 = divided.y;
    output[static_cast<uint>(5)] = as_type<uint>(_e71);
    float _e77 = divided.z;
    output[static_cast<uint>(6)] = as_type<uint>(_e77);
    float _e83 = divided.w;
    output[static_cast<uint>(7)] = as_type<uint>(_e83);
    metal::float4 _e88 = values;
    metal::float4 _e90 = operator_u002f_1(_e88, 3.0);
    divided = _e90;
    float _e92 = divided.x;
    output[static_cast<uint>(8)] = as_type<uint>(_e92);
    float _e98 = divided.y;
    output[static_cast<uint>(9)] = as_type<uint>(_e98);
    float _e104 = divided.z;
    output[static_cast<uint>(10)] = as_type<uint>(_e104);
    float _e110 = divided.w;
    output[static_cast<uint>(11)] = as_type<uint>(_e110);
    metal::float4 _e115 = divisors;
    metal::float4 _e117 = operator_u002f_2(3.0, _e115);
    divided = _e117;
    float _e119 = divided.x;
    output[static_cast<uint>(12)] = as_type<uint>(_e119);
    float _e125 = divided.y;
    output[static_cast<uint>(13)] = as_type<uint>(_e125);
    float _e131 = divided.z;
    output[static_cast<uint>(14)] = as_type<uint>(_e131);
    float _e137 = divided.w;
    output[static_cast<uint>(15)] = as_type<uint>(_e137);
    metal::float4 _e142 = values;
    divided = _e142;
    metal::float4 _e143 = divisors;
    right_1 = metal::float4 {};
    right_1 = _e143;
    metal::float4 _e147 = divided;
    local_5 = _e147;
    metal::float4 _e149 = local_5;
    metal::float4 _e150 = right_1;
    metal::float4 _e151 = operator_u002f(_e149, _e150);
    divided = _e151;
    float _e153 = divided.x;
    output[static_cast<uint>(16)] = as_type<uint>(_e153);
    float _e159 = divided.y;
    output[static_cast<uint>(17)] = as_type<uint>(_e159);
    float _e165 = divided.z;
    output[static_cast<uint>(18)] = as_type<uint>(_e165);
    float _e171 = divided.w;
    output[static_cast<uint>(19)] = as_type<uint>(_e171);
    metal::float4 _e176 = values;
    divided = _e176;
    right_2 = float {};
    right_2 = 3.0;
    metal::float4 _e181 = divided;
    local_6 = _e181;
    metal::float4 _e183 = local_6;
    float _e184 = right_2;
    metal::float4 _e185 = operator_u002f_1(_e183, _e184);
    divided = _e185;
    float _e187 = divided.x;
    output[static_cast<uint>(20)] = as_type<uint>(_e187);
    float _e193 = divided.y;
    output[static_cast<uint>(21)] = as_type<uint>(_e193);
    float _e199 = divided.z;
    output[static_cast<uint>(22)] = as_type<uint>(_e199);
    float _e205 = divided.w;
    output[static_cast<uint>(23)] = as_type<uint>(_e205);
    scalar = numerator_1;
    float _e211 = scalar;
    uint _e214 = _naga_divide_f32_(as_type<uint>(_e211), as_type<uint>(denominator_1));
    scalar = as_type<float>(_e214);
    float _e216 = scalar;
    output[static_cast<uint>(24)] = as_type<uint>(_e216);
    float _e221 = scalar;
    output[static_cast<uint>(25)] = as_type<uint>(_e221);
    bank.inner[0] = numerator_1;
    bank.inner[1] = 7.0;
    index = 0u;
    divisor = denominator_1;
    float _e233 = divisor;
    divisor = _e233 + static_cast<float>(1);
    uint _e237 = index;
    index = _e237 + static_cast<uint>(1);
    float _e242 = bank.inner[_e237];
    uint _e245 = _naga_divide_f32_(as_type<uint>(_e242), as_type<uint>(_e233));
    bank.inner[_e237] = as_type<float>(_e245);
    float _e247 = bank.inner[_e237];
    output[static_cast<uint>(26)] = as_type<uint>(_e247);
    float _e254 = bank.inner[0];
    output[static_cast<uint>(27)] = as_type<uint>(_e254);
    uint _e259 = index;
    output[static_cast<uint>(28)] = _e259;
    float _e263 = divisor;
    output[static_cast<uint>(29)] = as_type<uint>(_e263);
    float _e270 = bank.inner[1];
    output[static_cast<uint>(30)] = as_type<uint>(_e270);
    output[static_cast<uint>(31)] = static_cast<uint>(naga_div(naga_neg(7), 3));
    output[static_cast<uint>(32)] = naga_div(4294967295u, 3u);
    first.value = 2.0;
    second.value = 3.0;
    Ratio_cuda_record_0_ _e295 = first;
    Ratio_cuda_record_0_ _e296 = second;
    float _e297 = operator_u002f_3(_e295, _e296);
    output[static_cast<uint>(33)] = as_type<uint>(_e297);
    right_3 = float {};
    right_3 = 3.0;
    float _e306 = right_3;
    float _e308 = first.value;
    first.value = _e308 + _e306;
    Ratio_cuda_record_0_ _e311 = first;
    local_7 = _e311;
    Ratio_cuda_record_0_ _e313 = local_7;
    local = _e313;
    Ratio_cuda_record_0_ _e315 = local;
    updated = _e315;
    float _e318 = updated.value;
    output[static_cast<uint>(34)] = as_type<uint>(_e318);
    float _e324 = first.value;
    output[static_cast<uint>(35)] = as_type<uint>(_e324);
    third = 0.33333334;
    float _e331 = third;
    output[static_cast<uint>(36)] = as_type<uint>(_e331);
    left = 2.0;
    right = 3.0;
    float _e340 = left;
    left = _e340 + static_cast<float>(1);
    float _e344 = right;
    right = _e344 + static_cast<float>(1);
    uint _e350 = _naga_divide_f32_(as_type<uint>(_e340), as_type<uint>(_e344));
    output[static_cast<uint>(37)] = as_type<uint>(as_type<float>(_e350));
    float _e356 = left;
    output[static_cast<uint>(38)] = as_type<uint>(_e356);
    float _e361 = right;
    output[static_cast<uint>(39)] = as_type<uint>(_e361);
    selected_numerator = numerator_1;
    selected_denominator = denominator_1;
    choose = false;
    bool _e370 = choose;
    if (_e370) {
        float _e371 = selected_numerator;
        selected_numerator = _e371 + static_cast<float>(1);
        float _e375 = selected_denominator;
        selected_denominator = _e375 + static_cast<float>(1);
        float _e379 = quotient_1(_e371, _e375);
        local_1 = _e379;
    } else {
        float _e381 = selected_numerator;
        selected_numerator = _e381 + static_cast<float>(1);
        float _e385 = selected_denominator;
        selected_denominator = _e385 + static_cast<float>(1);
        uint _e391 = _naga_divide_f32_(as_type<uint>(_e381), as_type<uint>(_e385));
        local_1 = as_type<float>(_e391);
    }
    float _e395 = local_1;
    output[static_cast<uint>(40)] = as_type<uint>(_e395);
    float _e400 = selected_numerator;
    output[static_cast<uint>(41)] = as_type<uint>(_e400);
    float _e405 = selected_denominator;
    output[static_cast<uint>(42)] = as_type<uint>(_e405);
    local_2 = false;
    if (false) {
        float _e412 = selected_numerator;
        selected_numerator = _e412 + static_cast<float>(1);
        float _e416 = selected_denominator;
        selected_denominator = _e416 + static_cast<float>(1);
        float _e420 = quotient_1(_e412, _e416);
        local_2 = _e420 != 0.0;
    }
    bool _e423 = local_2;
    output[static_cast<uint>(43)] = static_cast<uint>(_e423);
    float _e428 = selected_numerator;
    output[static_cast<uint>(44)] = as_type<uint>(_e428);
    local_3 = true;
    if (true) {
    } else {
        float _e435 = selected_numerator;
        selected_numerator = _e435 + static_cast<float>(1);
        float _e439 = selected_denominator;
        selected_denominator = _e439 + static_cast<float>(1);
        float _e443 = quotient_1(_e435, _e439);
        local_3 = _e443 != 0.0;
    }
    bool _e446 = local_3;
    output[static_cast<uint>(45)] = static_cast<uint>(_e446);
    float _e451 = selected_denominator;
    output[static_cast<uint>(46)] = as_type<uint>(_e451);
    scale = 6.0;
    float _e458 = scale;
    uint _e462 = _naga_divide_f32_(as_type<uint>(_e458), as_type<uint>(2.0));
    scale = as_type<float>(_e462);
    float _e464 = scale;
    uint _e468 = _naga_divide_f32_(as_type<uint>(_e464), as_type<uint>(3.0));
    scale = as_type<float>(_e468);
    float _e470 = scale;
    output[static_cast<uint>(47)] = as_type<uint>(_e470);
    float _e475 = scale;
    output[static_cast<uint>(48)] = as_type<uint>(_e475);
    scale = 8.0;
    {
        iteration = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e495 = iteration;
                iteration = as_type<int>(as_type<uint>(_e495) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e483 = iteration;
            if (_e483 < 2) {
            } else {
                break;
            }
            int _e486 = iteration;
            if (_e486 == 0) {
                continue;
            }
            float _e489 = scale;
            uint _e493 = _naga_divide_f32_(as_type<uint>(_e489), as_type<uint>(2.0));
            scale = as_type<float>(_e493);
        }
    }
    float _e498 = scale;
    output[static_cast<uint>(49)] = as_type<uint>(_e498);
    left = 2.0;
    right = 3.0;
    float _e505 = left;
    left = _e505 + static_cast<float>(1);
    float _e509 = right;
    right = _e509 + static_cast<float>(1);
    uint _e515 = _naga_divide_f32_(as_type<uint>(_e505), as_type<uint>(_e509));
    local_4 = as_type<float>(_e515);
    float _e518 = local_4;
    output[static_cast<uint>(50)] = as_type<uint>(_e518);
    float _e523 = left;
    output[static_cast<uint>(51)] = as_type<uint>(_e523);
    float _e528 = right;
    output[static_cast<uint>(52)] = as_type<uint>(_e528);
    uint _e535 = _naga_divide_f32_(as_type<uint>(numerator_1), as_type<uint>(denominator_1));
    uint _e540 = _naga_divide_f32_(as_type<uint>(as_type<float>(_e535)), as_type<uint>(3.0));
    output[static_cast<uint>(53)] = as_type<uint>(as_type<float>(_e540));
    uint _e549 = _naga_divide_f32_(as_type<uint>(24.0), as_type<uint>(denominator_1));
    uint _e554 = _naga_divide_f32_(as_type<uint>(as_type<float>(_e549)), as_type<uint>(2.0));
    output[static_cast<uint>(54)] = as_type<uint>(as_type<float>(_e554));
    uint _e563 = _naga_divide_f32_(as_type<uint>(denominator_1), as_type<uint>(2.0));
    uint _e568 = _naga_divide_f32_(as_type<uint>(24.0), as_type<uint>(as_type<float>(_e563)));
    output[static_cast<uint>(55)] = as_type<uint>(as_type<float>(_e568));
    uint _e578 = _naga_divide_f32_(as_type<uint>(numerator_1), as_type<uint>(static_cast<float>(true)));
    output[static_cast<uint>(56)] = as_type<uint>(as_type<float>(_e578));
    uint _e588 = _naga_divide_f32_(as_type<uint>(static_cast<float>(4294967295u)), as_type<uint>(denominator_1));
    output[static_cast<uint>(57)] = as_type<uint>(as_type<float>(_e588));
    uint _e597 = input[static_cast<uint>(2)];
    uint _e601 = _naga_divide_f32_(as_type<uint>(numerator_1), as_type<uint>(as_type<float>(_e597)));
    output[static_cast<uint>(58)] = as_type<uint>(as_type<float>(_e601));
    uint _e610 = input[static_cast<uint>(2)];
    uint _e615 = input[static_cast<uint>(2)];
    uint _e619 = _naga_divide_f32_(as_type<uint>(as_type<float>(_e610)), as_type<uint>(as_type<float>(_e615)));
    output[static_cast<uint>(59)] = as_type<uint>(as_type<float>(_e619));
    uint _e628 = input[static_cast<uint>(3)];
    uint _e633 = input[static_cast<uint>(3)];
    uint _e637 = _naga_divide_f32_(as_type<uint>(as_type<float>(_e628)), as_type<uint>(as_type<float>(_e633)));
    output[static_cast<uint>(60)] = as_type<uint>(as_type<float>(_e637));
}
