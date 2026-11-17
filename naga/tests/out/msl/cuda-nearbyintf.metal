// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_rintf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    uint _e13 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e14 = _e13 - 1u;
    uint _e15 = input_bits & _e14;
    uint _e18 = input_bits & ~(_e14);
    uint _e20 = _e13 >> 1u;
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((input_bits & 2147483648u) | (((_e5 > 1056964608u) ? 1u : 0u) * 1065353216u))) : ((((_e15 > _e20) || ((_e15 == _e20) && ((_e18 & _e13) != 0u))) && (_e15 != 0u)) ? (_e18 + _e13) : _e18)));
}

float nearby_value(
    float value
) {
    uint _e2 = _naga_rintf(as_type<uint>(value));
    return as_type<float>(_e2);
}

int nearbyintf(
    bool value_1
) {
    int local_15 = {};
    if (value_1) {
        local_15 = 7;
    } else {
        local_15 = 9;
    }
    int _e6 = local_15;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits_1
) {
    uint _e2 = input_bits_1 & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_roundf(
    uint input_bits_2
) {
    uint _e5 = input_bits_2 & 2147483647u;
    uint _e6 = input_bits_2 & 2147483648u;
    uint _e13 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e14 = _e13 - 1u;
    uint _e15 = input_bits_2 & _e14;
    uint _e18 = input_bits_2 & ~(_e14);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_2 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_2 : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18)));
}

struct nearby_integersInput {
};
kernel void nearby_integers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    uint local_1 = {};
    int cursor = {};
    uint local_2 = {};
    uint local_3 = {};
    bool local_4 = {};
    bool local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    float local_13 = {};
    uint local_14 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 32u) {
        return;
    }
    uint base = 4u + (index * 12u);
    uint _e15 = input[index];
    float value_2 = as_type<float>(_e15);
    uint _e18 = _naga_rintf(as_type<uint>(value_2));
    output[base] = as_type<uint>(as_type<float>(_e18));
    uint _e24 = _naga_rintf(as_type<uint>(value_2));
    local = static_cast<uint>(base + 1u);
    uint _e31 = local;
    output[_e31] = as_type<uint>(as_type<float>(_e24));
    float _e33 = nearby_value(value_2);
    local_1 = static_cast<uint>(base + 2u);
    uint _e39 = local_1;
    output[_e39] = as_type<uint>(_e33);
    cursor = 0;
    int _e43 = cursor;
    cursor = as_type<int>(as_type<uint>(_e43) + as_type<uint>(1));
    local_3 = static_cast<uint>(index + static_cast<uint>(_e43));
    uint _e50 = local_3;
    uint _e52 = input[_e50];
    float _e54 = nearby_value(as_type<float>(_e52));
    local_2 = static_cast<uint>(base + 3u);
    uint _e60 = local_2;
    output[_e60] = as_type<uint>(_e54);
    local_4 = false;
    if (false) {
        int _e64 = cursor;
        cursor = as_type<int>(as_type<uint>(_e64) + as_type<uint>(1));
        uint _e69 = _naga_rintf(as_type<uint>(static_cast<float>(_e64)));
        uint _e72 = _naga_fabsf(as_type<uint>(as_type<float>(_e69)));
        local_4 = _e72 != 0u;
    }
    local_5 = true;
    if (true) {
    } else {
        int _e77 = cursor;
        cursor = as_type<int>(as_type<uint>(_e77) + as_type<uint>(1));
        uint _e82 = _naga_rintf(as_type<uint>(static_cast<float>(_e77)));
        uint _e85 = _naga_fabsf(as_type<uint>(as_type<float>(_e82)));
        local_5 = _e85 != 0u;
    }
    int _e88 = cursor;
    local_6 = static_cast<uint>(base + 4u);
    uint _e94 = local_6;
    output[_e94] = static_cast<uint>(_e88);
    uint _e99 = _naga_rintf(as_type<uint>(-(0.5)));
    local_7 = static_cast<uint>(base + 5u);
    uint _e106 = local_7;
    output[_e106] = as_type<uint>(as_type<float>(_e99));
    uint _e110 = _naga_rintf(as_type<uint>(2.5));
    local_8 = static_cast<uint>(base + 6u);
    uint _e117 = local_8;
    output[_e117] = as_type<uint>(as_type<float>(_e110));
    uint _e121 = _naga_roundf(as_type<uint>(2.5));
    local_9 = static_cast<uint>(base + 7u);
    uint _e128 = local_9;
    output[_e128] = as_type<uint>(as_type<float>(_e121));
    float _e132 = nearby_value(static_cast<float>(3u));
    local_10 = static_cast<uint>(base + 8u);
    uint _e138 = local_10;
    output[_e138] = as_type<uint>(_e132);
    int _e141 = nearbyintf(true);
    local_11 = static_cast<uint>(base + 9u);
    uint _e147 = local_11;
    output[_e147] = static_cast<uint>(_e141);
    if (true) {
        uint _e151 = _naga_rintf(as_type<uint>(value_2));
        uint _e154 = _naga_rintf(as_type<uint>(as_type<float>(_e151)));
        local_13 = as_type<float>(_e154);
    } else {
        int _e157 = cursor;
        cursor = as_type<int>(as_type<uint>(_e157) + as_type<uint>(1));
        uint _e162 = _naga_rintf(as_type<uint>(static_cast<float>(_e157)));
        local_13 = as_type<float>(_e162);
    }
    float _e166 = local_13;
    local_12 = static_cast<uint>(base + 10u);
    uint _e172 = local_12;
    output[_e172] = as_type<uint>(_e166);
    int _e174 = cursor;
    local_14 = static_cast<uint>(base + 11u);
    uint _e180 = local_14;
    output[_e180] = static_cast<uint>(_e174);
}
