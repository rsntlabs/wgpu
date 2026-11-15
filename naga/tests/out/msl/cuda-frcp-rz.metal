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

float truncated_reciprocal(
    float value
) {
    uint _e4 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(value));
    return as_type<float>(_e4);
}

int _frcp_rz(
    bool value_1
) {
    int local_14 = {};
    if (value_1) {
        local_14 = 7;
    } else {
        local_14 = 9;
    }
    int _e6 = local_14;
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

struct reciprocal_round_zeroInput {
};
kernel void reciprocal_round_zero(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    int cursor = {};
    uint local_1 = {};
    uint local_2 = {};
    bool local_3 = {};
    bool local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    float local_12 = {};
    uint local_13 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 10u);
    uint _e15 = input[index];
    float value_2 = as_type<float>(_e15);
    uint _e20 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(value_2));
    output[base] = as_type<uint>(as_type<float>(_e20));
    float _e25 = truncated_reciprocal(value_2);
    local = static_cast<uint>(base + 1u);
    uint _e31 = local;
    output[_e31] = as_type<uint>(_e25);
    cursor = 0;
    int _e35 = cursor;
    cursor = as_type<int>(as_type<uint>(_e35) + as_type<uint>(1));
    local_2 = static_cast<uint>(index + static_cast<uint>(_e35));
    uint _e42 = local_2;
    uint _e44 = input[_e42];
    float _e46 = truncated_reciprocal(as_type<float>(_e44));
    local_1 = static_cast<uint>(base + 2u);
    uint _e52 = local_1;
    output[_e52] = as_type<uint>(_e46);
    local_3 = false;
    if (false) {
        int _e56 = cursor;
        cursor = as_type<int>(as_type<uint>(_e56) + as_type<uint>(1));
        uint _e63 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(static_cast<float>(_e56)));
        uint _e66 = _naga_fabsf(as_type<uint>(as_type<float>(_e63)));
        local_3 = _e66 != 0u;
    }
    local_4 = true;
    if (true) {
    } else {
        int _e71 = cursor;
        cursor = as_type<int>(as_type<uint>(_e71) + as_type<uint>(1));
        uint _e78 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(static_cast<float>(_e71)));
        uint _e81 = _naga_fabsf(as_type<uint>(as_type<float>(_e78)));
        local_4 = _e81 != 0u;
    }
    int _e84 = cursor;
    local_5 = static_cast<uint>(base + 3u);
    uint _e90 = local_5;
    output[_e90] = static_cast<uint>(_e84);
    uint _e97 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(-(0.0)));
    local_6 = static_cast<uint>(base + 4u);
    uint _e104 = local_6;
    output[_e104] = as_type<uint>(as_type<float>(_e97));
    local_8 = 4286578688u;
    uint _e108 = local_8;
    uint _e113 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e108)));
    local_7 = static_cast<uint>(base + 5u);
    uint _e120 = local_7;
    output[_e120] = as_type<uint>(as_type<float>(_e113));
    float _e124 = truncated_reciprocal(static_cast<float>(2u));
    local_9 = static_cast<uint>(base + 6u);
    uint _e130 = local_9;
    output[_e130] = as_type<uint>(_e124);
    int _e133 = _frcp_rz(true);
    local_10 = static_cast<uint>(base + 7u);
    uint _e139 = local_10;
    output[_e139] = static_cast<uint>(_e133);
    if (true) {
        uint _e145 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(value_2));
        local_12 = as_type<float>(_e145);
    } else {
        int _e148 = cursor;
        cursor = as_type<int>(as_type<uint>(_e148) + as_type<uint>(1));
        uint _e155 = _naga_divide_f32_rz(as_type<uint>(1.0), as_type<uint>(static_cast<float>(_e148)));
        local_12 = as_type<float>(_e155);
    }
    float _e159 = local_12;
    local_11 = static_cast<uint>(base + 8u);
    uint _e165 = local_11;
    output[_e165] = as_type<uint>(_e159);
    uint _e170 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(value_2));
    local_13 = static_cast<uint>(base + 9u);
    uint _e177 = local_13;
    output[_e177] = as_type<uint>(as_type<float>(_e170));
}
