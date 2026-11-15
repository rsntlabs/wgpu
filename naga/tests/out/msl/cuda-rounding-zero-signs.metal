// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_2[1];

uint _naga_floorf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    uint _e6 = input_bits & 2147483648u;
    uint _e14 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e15 = _e14 - 1u;
    uint _e19 = input_bits & ~(_e15);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19)));
}

float floor_value(
    float value
) {
    uint _e2 = _naga_floorf(as_type<uint>(value));
    return as_type<float>(_e2);
}

uint _naga_ceilf(
    uint input_bits_1
) {
    uint _e5 = input_bits_1 & 2147483647u;
    uint _e6 = input_bits_1 & 2147483648u;
    uint _e13 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e14 = _e13 - 1u;
    uint _e18 = input_bits_1 & ~(_e14);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_1 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_1 : (_e6 | ((1u - (_e6 >> 31u)) * 1065353216u))) : (((_e6 == 0u) && ((input_bits_1 & _e14) != 0u)) ? (_e18 + _e13) : _e18)));
}

float ceil_value(
    float value_1
) {
    uint _e2 = _naga_ceilf(as_type<uint>(value_1));
    return as_type<float>(_e2);
}

struct rounding_zero_signsInput {
};
kernel void rounding_zero_signs(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2 const& input [[user(fake0)]]
, device type_2& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
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
    int cursor = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint index = threadIdx.x;
    uint bits = input[index];
    uint base = 4u + (index * 14u);
    uint _e11 = _naga_floorf(as_type<uint>(as_type<float>(bits)));
    output[base] = as_type<uint>(as_type<float>(_e11));
    uint _e18 = _naga_ceilf(as_type<uint>(as_type<float>(bits)));
    local = static_cast<uint>(base + 1u);
    uint _e25 = local;
    output[_e25] = as_type<uint>(as_type<float>(_e18));
    float _e28 = floor_value(as_type<float>(bits));
    local_1 = static_cast<uint>(base + 2u);
    uint _e34 = local_1;
    output[_e34] = as_type<uint>(_e28);
    float _e37 = ceil_value(as_type<float>(bits));
    local_2 = static_cast<uint>(base + 3u);
    uint _e43 = local_2;
    output[_e43] = as_type<uint>(_e37);
    uint _e47 = _naga_floorf(as_type<uint>(0.0));
    local_3 = static_cast<uint>(base + 4u);
    uint _e54 = local_3;
    output[_e54] = as_type<uint>(as_type<float>(_e47));
    uint _e59 = _naga_floorf(as_type<uint>(-(0.0)));
    local_4 = static_cast<uint>(base + 5u);
    uint _e66 = local_4;
    output[_e66] = as_type<uint>(as_type<float>(_e59));
    uint _e70 = _naga_ceilf(as_type<uint>(0.0));
    local_5 = static_cast<uint>(base + 6u);
    uint _e77 = local_5;
    output[_e77] = as_type<uint>(as_type<float>(_e70));
    uint _e82 = _naga_ceilf(as_type<uint>(-(0.0)));
    local_6 = static_cast<uint>(base + 7u);
    uint _e89 = local_6;
    output[_e89] = as_type<uint>(as_type<float>(_e82));
    uint _e93 = _naga_floorf(as_type<uint>(0.25));
    local_7 = static_cast<uint>(base + 8u);
    uint _e100 = local_7;
    output[_e100] = as_type<uint>(as_type<float>(_e93));
    uint _e105 = _naga_ceilf(as_type<uint>(-(0.25)));
    local_8 = static_cast<uint>(base + 9u);
    uint _e112 = local_8;
    output[_e112] = as_type<uint>(as_type<float>(_e105));
    cursor = 0;
    int _e116 = cursor;
    cursor = as_type<int>(as_type<uint>(_e116) + as_type<uint>(1));
    local_10 = static_cast<uint>(index + static_cast<uint>(_e116));
    uint _e123 = local_10;
    uint _e125 = input[_e123];
    float _e127 = floor_value(as_type<float>(_e125));
    local_9 = static_cast<uint>(base + 10u);
    uint _e133 = local_9;
    output[_e133] = as_type<uint>(_e127);
    int _e135 = cursor;
    cursor = as_type<int>(as_type<uint>(_e135) + as_type<uint>(1));
    float _e139 = ceil_value(static_cast<float>(_e135));
    local_11 = static_cast<uint>(base + 11u);
    uint _e145 = local_11;
    output[_e145] = as_type<uint>(_e139);
    int _e147 = cursor;
    local_12 = static_cast<uint>(base + 12u);
    uint _e155 = local_12;
    output[_e155] = static_cast<uint>(as_type<int>(as_type<uint>(_e147) - as_type<uint>(1)));
    int _e157 = cursor;
    local_13 = static_cast<uint>(base + 13u);
    uint _e163 = local_13;
    output[_e163] = static_cast<uint>(_e157);
}
