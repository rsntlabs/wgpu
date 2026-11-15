// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_fadd_rn(
    uint left_bits,
    uint right_bits
) {
    uint _e9 = left_bits & 2147483647u;
    uint _e10 = right_bits & 2147483647u;
    uint _e11 = left_bits & 2147483648u;
    uint _e12 = right_bits & 2147483648u;
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e16 = _e9 == 2139095040u;
    bool _e17 = _e10 == 2139095040u;
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits;
    }
    if (_e17) {
        return right_bits;
    }
    bool _e22 = _e9 >= _e10;
    uint _e23 = _e22 ? _e9 : _e10;
    uint _e24 = _e22 ? _e10 : _e9;
    uint _e25 = _e22 ? _e11 : _e12;
    uint _e29 = _e23 >> 23u;
    uint _e30 = _e24 >> 23u;
    bool _e31 = _e29 != 0u;
    bool _e32 = _e30 != 0u;
    uint _e39 = ((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u;
    uint _e40 = ((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u;
    uint _e41 = _e31 ? _e29 : 1u;
    uint _e43 = _e41 - (_e32 ? _e30 : 1u);
    uint _e48 = _e43 & 31u;
    uint _e59 = (_e43 < 32u) ? ((_e40 >> _e48) | static_cast<uint>((_e40 & ((1u << _e48) - 1u)) != 0u)) : static_cast<uint>(_e40 != 0u);
    uint _e62 = (_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59);
    if (_e62 == 0u) {
        return _e11 & _e12;
    }
    bool _e66 = _e62 >= 134217728u;
    uint _e71 = 1u & 31u;
    uint _e83 = _e66 ? ((1u < 32u) ? ((_e62 >> _e71) | static_cast<uint>((_e62 & ((1u << _e71) - 1u)) != 0u)) : static_cast<uint>(_e62 != 0u)) : _e62;
    uint _e85 = _e41 + static_cast<uint>(_e66);
    uint _e90 = metal::min(metal::clz(_e83) - 5u, _e85 - 1u);
    uint _e91 = _e83 << _e90;
    uint _e95 = _e91 & 7u;
    uint _e96 = _e91 >> 3u;
    uint _e104 = _e96 + static_cast<uint>((_e95 > 4u) || ((_e95 == 4u) && ((_e96 & 1u) != 0u)));
    bool _e106 = _e104 >= 16777216u;
    uint _e108 = _e106 ? (_e104 >> 1u) : _e104;
    uint _e110 = (_e85 - _e90) + static_cast<uint>(_e106);
    if (_e110 >= 255u) {
        return _e25 | 2139095040u;
    }
    return _e25 | ((((_e108 >= 8388608u) ? _e110 : 0u) << 23u) | (_e108 & 8388607u));
}

float subtract_value(
    float first,
    float second
) {
    uint _e6 = _naga_fadd_rn(as_type<uint>(first), as_type<uint>(second) ^ 2147483648u);
    return as_type<float>(_e6);
}

int _fsub_rn(
    bool first_1,
    bool second_1
) {
    int local_17 = {};
    if (first_1) {
        local_17 = 7;
    } else {
        local_17 = 9;
    }
    int _e6 = local_17;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

struct subtract_round_nearestInput {
};
kernel void subtract_round_nearest(
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
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
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
    uint _e36 = _naga_fadd_rn(as_type<uint>(first_2), as_type<uint>(second_2) ^ 2147483648u);
    output[base] = as_type<uint>(as_type<float>(_e36));
    float _e41 = subtract_value(first_2, second_2);
    local_2 = static_cast<uint>(base + 1u);
    uint _e47 = local_2;
    output[_e47] = as_type<uint>(_e41);
    cursor = 0;
    int _e53 = cursor;
    cursor = as_type<int>(as_type<uint>(_e53) + as_type<uint>(1));
    local_4 = static_cast<uint>((index * 2u) + static_cast<uint>(_e53));
    uint _e60 = local_4;
    uint _e62 = input[_e60];
    int _e66 = cursor;
    cursor = as_type<int>(as_type<uint>(_e66) + as_type<uint>(1));
    local_5 = static_cast<uint>((index * 2u) + static_cast<uint>(_e66));
    uint _e73 = local_5;
    uint _e75 = input[_e73];
    float _e77 = subtract_value(as_type<float>(_e62), as_type<float>(_e75));
    local_3 = static_cast<uint>(base + 2u);
    uint _e83 = local_3;
    output[_e83] = as_type<uint>(_e77);
    local_6 = false;
    if (false) {
        int _e87 = cursor;
        cursor = as_type<int>(as_type<uint>(_e87) + as_type<uint>(1));
        uint _e95 = _naga_fadd_rn(as_type<uint>(static_cast<float>(_e87)), as_type<uint>(first_2) ^ 2147483648u);
        uint _e98 = _naga_fabsf(as_type<uint>(as_type<float>(_e95)));
        local_6 = _e98 != 0u;
    }
    local_7 = true;
    if (true) {
    } else {
        int _e103 = cursor;
        cursor = as_type<int>(as_type<uint>(_e103) + as_type<uint>(1));
        uint _e111 = _naga_fadd_rn(as_type<uint>(first_2), as_type<uint>(static_cast<float>(_e103)) ^ 2147483648u);
        uint _e114 = _naga_fabsf(as_type<uint>(as_type<float>(_e111)));
        local_7 = _e114 != 0u;
    }
    int _e117 = cursor;
    local_8 = static_cast<uint>(base + 3u);
    uint _e123 = local_8;
    output[_e123] = static_cast<uint>(_e117);
    uint _e133 = _naga_fadd_rn(as_type<uint>(-(0.0)), as_type<uint>(-(0.0)) ^ 2147483648u);
    local_9 = static_cast<uint>(base + 4u);
    uint _e140 = local_9;
    output[_e140] = as_type<uint>(as_type<float>(_e133));
    uint _e149 = _naga_fadd_rn(as_type<uint>(-(0.0)), as_type<uint>(0.0) ^ 2147483648u);
    local_10 = static_cast<uint>(base + 5u);
    uint _e156 = local_10;
    output[_e156] = as_type<uint>(as_type<float>(_e149));
    float _e162 = subtract_value(static_cast<float>(1), static_cast<float>(2u));
    local_11 = static_cast<uint>(base + 6u);
    uint _e168 = local_11;
    output[_e168] = as_type<uint>(_e162);
    int _e172 = _fsub_rn(true, false);
    local_12 = static_cast<uint>(base + 7u);
    uint _e178 = local_12;
    output[_e178] = static_cast<uint>(_e172);
    uint _e184 = _naga_fadd_rn(as_type<uint>(second_2), as_type<uint>(first_2) ^ 2147483648u);
    local_13 = static_cast<uint>(base + 8u);
    uint _e191 = local_13;
    output[_e191] = as_type<uint>(as_type<float>(_e184));
    local_15 = 1065353217u;
    uint _e195 = local_15;
    local_16 = 1065353214u;
    uint _e199 = local_16;
    uint _e207 = _naga_fadd_rn(as_type<uint>(as_type<float>(_e195) * as_type<float>(_e199)), as_type<uint>(1.0) ^ 2147483648u);
    local_14 = static_cast<uint>(base + 9u);
    uint _e214 = local_14;
    output[_e214] = as_type<uint>(as_type<float>(_e207));
}
