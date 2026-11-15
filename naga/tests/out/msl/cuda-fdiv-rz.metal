// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_divide_f32_rz(
    uint numerator_bits,
    uint denominator_bits
) {
    uint numerator_significand = {};
    int numerator_exponent = {};
    uint denominator_significand = {};
    int denominator_exponent = {};
    uint quotient = {};
    uint remainder = {};
    uint iteration = {};
    uint _e8 = numerator_bits & 2147483647u;
    uint _e9 = denominator_bits & 2147483647u;
    uint _e11 = (numerator_bits ^ denominator_bits) & 2147483648u;
    bool _e16 = _e8 == 0u;
    bool _e17 = _e9 == 0u;
    bool _e19 = _e8 == 2139095040u;
    bool _e20 = _e9 == 2139095040u;
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e11 | 2139095040u;
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
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e94 = iteration;
            iteration = _e94 + 1u;
        }
        loop_init = false;
        uint _e83 = iteration;
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
    if (_e75 < -126) {
        return _e11 | (_e96 >> (static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e75))) & 31u));
    }
    if (_e75 > 127) {
        return _e11 | 2139095039u;
    }
    return _e11 | ((static_cast<uint>(as_type<int>(as_type<uint>(_e75) + as_type<uint>(127))) << 23u) | (_e96 & 8388607u));
}

float truncated_quotient(
    float first,
    float second
) {
    uint _e4 = _naga_divide_f32_rz(as_type<uint>(first), as_type<uint>(second));
    return as_type<float>(_e4);
}

int _fdiv_rz(
    bool first_1,
    bool second_1
) {
    int local_16 = {};
    if (first_1) {
        local_16 = 7;
    } else {
        local_16 = 9;
    }
    int _e6 = local_16;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_divide_f32_(
    uint numerator_bits_1,
    uint denominator_bits_1
) {
    uint numerator_significand_1 = {};
    int numerator_exponent_1 = {};
    uint denominator_significand_1 = {};
    int denominator_exponent_1 = {};
    uint quotient_1 = {};
    uint remainder_1 = {};
    uint iteration_1 = {};
    uint _e8 = numerator_bits_1 & 2147483647u;
    uint _e9 = denominator_bits_1 & 2147483647u;
    uint _e11 = (numerator_bits_1 ^ denominator_bits_1) & 2147483648u;
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
    numerator_significand_1 = _e30 | 8388608u;
    numerator_exponent_1 = as_type<int>(as_type<uint>(static_cast<int>(_e31)) - as_type<uint>(127));
    if (_e31 == 0u) {
        uint _e41 = metal::clz(_e30) - 8u;
        numerator_significand_1 = _e30 << _e41;
        numerator_exponent_1 = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e41)));
    }
    uint _e46 = numerator_significand_1;
    int _e47 = numerator_exponent_1;
    uint _e52 = _e9 & 8388607u;
    uint _e53 = _e9 >> 23u;
    denominator_significand_1 = _e52 | 8388608u;
    denominator_exponent_1 = as_type<int>(as_type<uint>(static_cast<int>(_e53)) - as_type<uint>(127));
    if (_e53 == 0u) {
        uint _e63 = metal::clz(_e52) - 8u;
        denominator_significand_1 = _e52 << _e63;
        denominator_exponent_1 = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e63)));
    }
    uint _e68 = denominator_significand_1;
    int _e69 = denominator_exponent_1;
    bool _e70 = _e46 < _e68;
    int _e75 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e47) - as_type<uint>(_e69))) - as_type<uint>(static_cast<int>(_e70)));
    if (_e75 < -150) {
        return _e11;
    }
    quotient_1 = 1u;
    remainder_1 = (_e70 ? (_e46 << 1u) : _e46) - _e68;
    iteration_1 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e94 = iteration_1;
            iteration_1 = _e94 + 1u;
        }
        loop_init_1 = false;
        uint _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        uint _e85 = remainder_1;
        uint _e86 = quotient_1;
        uint _e87 = _e85 << 1u;
        bool _e88 = _e87 >= _e68;
        remainder_1 = _e88 ? (_e87 - _e68) : _e87;
        quotient_1 = (_e86 << 1u) | (_e88 ? 1u : 0u);
    }
    uint _e96 = quotient_1;
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

struct divide_round_zeroInput {
};
kernel void divide_round_zero(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int cursor = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    bool local_6 = {};
    bool local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    float local_14 = {};
    uint local_15 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 10u);
    local = static_cast<uint>(index * 2u);
    uint _e17 = local;
    uint _e20 = input[_e17];
    float first_2 = as_type<float>(_e20);
    local_1 = static_cast<uint>((index * 2u) + 1u);
    uint _e28 = local_1;
    uint _e30 = input[_e28];
    float second_2 = as_type<float>(_e30);
    uint _e34 = _naga_divide_f32_rz(as_type<uint>(first_2), as_type<uint>(second_2));
    output[base] = as_type<uint>(as_type<float>(_e34));
    float _e39 = truncated_quotient(first_2, second_2);
    local_2 = static_cast<uint>(base + 1u);
    uint _e45 = local_2;
    output[_e45] = as_type<uint>(_e39);
    cursor = 0;
    int _e51 = cursor;
    cursor = as_type<int>(as_type<uint>(_e51) + as_type<uint>(1));
    local_4 = static_cast<uint>((index * 2u) + static_cast<uint>(_e51));
    uint _e58 = local_4;
    uint _e60 = input[_e58];
    int _e64 = cursor;
    cursor = as_type<int>(as_type<uint>(_e64) + as_type<uint>(1));
    local_5 = static_cast<uint>((index * 2u) + static_cast<uint>(_e64));
    uint _e71 = local_5;
    uint _e73 = input[_e71];
    float _e75 = truncated_quotient(as_type<float>(_e60), as_type<float>(_e73));
    local_3 = static_cast<uint>(base + 2u);
    uint _e81 = local_3;
    output[_e81] = as_type<uint>(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
        uint _e91 = _naga_divide_f32_rz(as_type<uint>(static_cast<float>(_e85)), as_type<uint>(first_2));
        uint _e94 = _naga_fabsf(as_type<uint>(as_type<float>(_e91)));
        local_6 = _e94 != 0u;
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = as_type<int>(as_type<uint>(_e99) + as_type<uint>(1));
        uint _e105 = _naga_divide_f32_rz(as_type<uint>(first_2), as_type<uint>(static_cast<float>(_e99)));
        uint _e108 = _naga_fabsf(as_type<uint>(as_type<float>(_e105)));
        local_7 = _e108 != 0u;
    }
    int _e111 = cursor;
    local_8 = static_cast<uint>(base + 3u);
    uint _e117 = local_8;
    output[_e117] = static_cast<uint>(_e111);
    uint _e125 = _naga_divide_f32_rz(as_type<uint>(-(0.0)), as_type<uint>(-(0.0)));
    local_9 = static_cast<uint>(base + 4u);
    uint _e132 = local_9;
    output[_e132] = as_type<uint>(as_type<float>(_e125));
    uint _e139 = _naga_divide_f32_rz(as_type<uint>(-(0.0)), as_type<uint>(0.0));
    local_10 = static_cast<uint>(base + 5u);
    uint _e146 = local_10;
    output[_e146] = as_type<uint>(as_type<float>(_e139));
    float _e152 = truncated_quotient(static_cast<float>(2), static_cast<float>(3u));
    local_11 = static_cast<uint>(base + 6u);
    uint _e158 = local_11;
    output[_e158] = as_type<uint>(_e152);
    int _e162 = _fdiv_rz(true, false);
    local_12 = static_cast<uint>(base + 7u);
    uint _e168 = local_12;
    output[_e168] = static_cast<uint>(_e162);
    if (true) {
        uint _e173 = _naga_divide_f32_rz(as_type<uint>(first_2), as_type<uint>(second_2));
        local_14 = as_type<float>(_e173);
    } else {
        int _e176 = cursor;
        cursor = as_type<int>(as_type<uint>(_e176) + as_type<uint>(1));
        uint _e182 = _naga_divide_f32_rz(as_type<uint>(static_cast<float>(_e176)), as_type<uint>(first_2));
        local_14 = as_type<float>(_e182);
    }
    float _e186 = local_14;
    local_13 = static_cast<uint>(base + 8u);
    uint _e192 = local_13;
    output[_e192] = as_type<uint>(_e186);
    uint _e196 = _naga_divide_f32_(as_type<uint>(first_2), as_type<uint>(second_2));
    local_15 = static_cast<uint>(base + 9u);
    uint _e203 = local_15;
    output[_e203] = as_type<uint>(as_type<float>(_e196));
}
