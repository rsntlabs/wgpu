// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint _naga_frsqrt_rn(
    uint input_bits
) {
    uint significand = {};
    uint trial_bit = {};
    uint _e7 = input_bits & 2147483647u;
    uint _e8 = input_bits & 2147483648u;
    if (_e7 == 0u) {
        return _e8 | 2139095040u;
    }
    if ((_e8 != 0u) || (_e7 > 2139095040u)) {
        return 2143289344u;
    }
    if (_e7 == 2139095040u) {
        return 0u;
    }
    uint _e18 = _e7 >> 23u;
    uint _e19 = _e7 & 8388607u;
    bool _e20 = _e18 != 0u;
    uint _e25 = metal::clz(_e19 | 1u) - 8u;
    uint _e29 = _e20 ? (_e19 | 8388608u) : (_e19 << (_e25 & 31u));
    int _e35 = _e20 ? static_cast<int>(_e18) : as_type<int>(as_type<uint>(1) - as_type<uint>(static_cast<int>(_e25)));
    int _e37 = as_type<int>(as_type<uint>(_e35) - as_type<uint>(127));
    int _e46 = as_type<int>(as_type<uint>(naga_neg(as_type<int>(as_type<uint>(_e37) + as_type<uint>(1))) >> 1u) + as_type<uint>(static_cast<int>(((_e37 & 1) == 0) && (_e29 == 8388608u))));
    uint _e52 = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(198) - as_type<uint>(_e35))) - as_type<uint>(as_type<int>(as_type<uint>(_e46) * as_type<uint>(2)))));
    significand = 8388608u;
    trial_bit = 22u;
    uint2 loop_bound = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e56 = significand;
        uint _e57 = trial_bit;
        uint _e60 = _e56 | (1u << (_e57 & 31u));
        uint _e61 = _e60 << 1u;
        uint _e65 = _e61 & 4095u;
        uint _e66 = _e61 >> 12u;
        uint _e67 = _e65 * _e65;
        uint _e71 = (2u * (_e65 * _e66)) + (_e67 >> 12u);
        uint _e74 = (_e66 * _e66) + (_e71 >> 12u);
        uint _e75 = _e67 & 4095u;
        uint _e76 = _e71 & 4095u;
        uint _e77 = _e74 & 4095u;
        uint _e79 = (_e74 >> 12u) & 4095u;
        uint _e81 = _e74 >> 24u;
        uint _e82 = _e29 & 4095u;
        uint _e83 = _e29 >> 12u;
        uint _e108 = ((_e83 * _e81) + ((((_e82 * _e81) + (_e83 * _e79)) + ((((_e82 * _e79) + (_e83 * _e77)) + ((((_e82 * _e77) + (_e83 * _e76)) + ((((_e82 * _e76) + (_e83 * _e75)) + ((_e82 * _e75) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u;
        significand = (((71u + static_cast<uint>(_e108 != 0u)) + static_cast<uint>(_e108 >= 2u)) < _e52) ? _e60 : _e56;
        if (_e57 == 0u) {
            break;
        }
        trial_bit = _e57 - 1u;
    }
    uint _e121 = significand;
    uint _e123 = (_e121 << 1u) + 1u;
    uint _e127 = _e123 & 4095u;
    uint _e128 = _e123 >> 12u;
    uint _e129 = _e127 * _e127;
    uint _e133 = (2u * (_e127 * _e128)) + (_e129 >> 12u);
    uint _e136 = (_e128 * _e128) + (_e133 >> 12u);
    uint _e137 = _e129 & 4095u;
    uint _e138 = _e133 & 4095u;
    uint _e139 = _e136 & 4095u;
    uint _e141 = (_e136 >> 12u) & 4095u;
    uint _e143 = _e136 >> 24u;
    uint _e144 = _e29 & 4095u;
    uint _e145 = _e29 >> 12u;
    uint _e170 = ((_e145 * _e143) + ((((_e144 * _e143) + (_e145 * _e141)) + ((((_e144 * _e141) + (_e145 * _e139)) + ((((_e144 * _e139) + (_e145 * _e138)) + ((((_e144 * _e138) + (_e145 * _e137)) + ((_e144 * _e137) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u;
    uint _e181 = _e121 + static_cast<uint>(((71u + static_cast<uint>(_e170 != 0u)) + static_cast<uint>(_e170 >= 2u)) < _e52);
    bool _e183 = _e181 >= 16777216u;
    return (static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e46) + as_type<uint>(static_cast<int>(_e183)))) + as_type<uint>(127))) << 23u) | ((_e183 ? (_e181 >> 1u) : _e181) & 8388607u);
}

float reciprocal_sqrt_value(
    float value
) {
    uint _e2 = _naga_frsqrt_rn(as_type<uint>(value));
    return as_type<float>(_e2);
}

int _frsqrt_rn(
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
    uint input_bits_1
) {
    uint _e2 = input_bits_1 & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

struct reciprocal_sqrt_round_nearestInput {
};
kernel void reciprocal_sqrt_round_nearest(
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
    uint _e18 = _naga_frsqrt_rn(as_type<uint>(value_2));
    output[base] = as_type<uint>(as_type<float>(_e18));
    float _e23 = reciprocal_sqrt_value(value_2);
    local = static_cast<uint>(base + 1u);
    uint _e29 = local;
    output[_e29] = as_type<uint>(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = as_type<int>(as_type<uint>(_e33) + as_type<uint>(1));
    local_2 = static_cast<uint>(index + static_cast<uint>(_e33));
    uint _e40 = local_2;
    uint _e42 = input[_e40];
    float _e44 = reciprocal_sqrt_value(as_type<float>(_e42));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = as_type<uint>(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = as_type<int>(as_type<uint>(_e54) + as_type<uint>(1));
        uint _e59 = _naga_frsqrt_rn(as_type<uint>(static_cast<float>(_e54)));
        uint _e62 = _naga_fabsf(as_type<uint>(as_type<float>(_e59)));
        local_3 = _e62 != 0u;
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
        uint _e72 = _naga_frsqrt_rn(as_type<uint>(static_cast<float>(_e67)));
        uint _e75 = _naga_fabsf(as_type<uint>(as_type<float>(_e72)));
        local_4 = _e75 != 0u;
    }
    int _e78 = cursor;
    local_5 = static_cast<uint>(base + 3u);
    uint _e84 = local_5;
    output[_e84] = static_cast<uint>(_e78);
    uint _e89 = _naga_frsqrt_rn(as_type<uint>(-(0.0)));
    local_6 = static_cast<uint>(base + 4u);
    uint _e96 = local_6;
    output[_e96] = as_type<uint>(as_type<float>(_e89));
    local_8 = 2139095040u;
    uint _e100 = local_8;
    uint _e103 = _naga_frsqrt_rn(as_type<uint>(as_type<float>(_e100)));
    local_7 = static_cast<uint>(base + 5u);
    uint _e110 = local_7;
    output[_e110] = as_type<uint>(as_type<float>(_e103));
    float _e114 = reciprocal_sqrt_value(static_cast<float>(4u));
    local_9 = static_cast<uint>(base + 6u);
    uint _e120 = local_9;
    output[_e120] = as_type<uint>(_e114);
    int _e123 = _frsqrt_rn(true);
    local_10 = static_cast<uint>(base + 7u);
    uint _e129 = local_10;
    output[_e129] = static_cast<uint>(_e123);
    if (true) {
        uint _e133 = _naga_frsqrt_rn(as_type<uint>(value_2));
        local_12 = as_type<float>(_e133);
    } else {
        int _e136 = cursor;
        cursor = as_type<int>(as_type<uint>(_e136) + as_type<uint>(1));
        uint _e141 = _naga_frsqrt_rn(as_type<uint>(static_cast<float>(_e136)));
        local_12 = as_type<float>(_e141);
    }
    float _e145 = local_12;
    local_11 = static_cast<uint>(base + 8u);
    uint _e151 = local_11;
    output[_e151] = as_type<uint>(_e145);
    int _e153 = cursor;
    local_13 = static_cast<uint>(base + 9u);
    uint _e159 = local_13;
    output[_e159] = static_cast<uint>(_e153);
}
