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

float rounded_even(
    float value
) {
    uint _e2 = _naga_rintf(as_type<uint>(value));
    return as_type<float>(_e2);
}

int rintf(
    bool value_1
) {
    int local_17 = {};
    if (value_1) {
        local_17 = 7;
    } else {
        local_17 = 9;
    }
    int _e6 = local_17;
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

struct nearest_evenInput {
};
kernel void nearest_even(
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
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    uint local_16 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 14u);
    uint _e15 = input[index];
    float value_2 = as_type<float>(_e15);
    uint _e18 = _naga_rintf(as_type<uint>(value_2));
    output[base] = as_type<uint>(as_type<float>(_e18));
    float _e23 = rounded_even(value_2);
    local = static_cast<uint>(base + 1u);
    uint _e29 = local;
    output[_e29] = as_type<uint>(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = as_type<int>(as_type<uint>(_e33) + as_type<uint>(1));
    local_2 = static_cast<uint>(index + static_cast<uint>(_e33));
    uint _e40 = local_2;
    uint _e42 = input[_e40];
    float _e44 = rounded_even(as_type<float>(_e42));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = as_type<uint>(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = as_type<int>(as_type<uint>(_e54) + as_type<uint>(1));
        uint _e59 = _naga_rintf(as_type<uint>(static_cast<float>(_e54)));
        uint _e62 = _naga_fabsf(as_type<uint>(as_type<float>(_e59)));
        local_3 = _e62 != 0u;
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
        uint _e72 = _naga_rintf(as_type<uint>(static_cast<float>(_e67)));
        uint _e75 = _naga_fabsf(as_type<uint>(as_type<float>(_e72)));
        local_4 = _e75 != 0u;
    }
    int _e78 = cursor;
    local_5 = static_cast<uint>(base + 3u);
    uint _e84 = local_5;
    output[_e84] = static_cast<uint>(_e78);
    uint _e89 = _naga_rintf(as_type<uint>(-(0.5)));
    local_6 = static_cast<uint>(base + 4u);
    uint _e96 = local_6;
    output[_e96] = as_type<uint>(as_type<float>(_e89));
    uint _e100 = _naga_rintf(as_type<uint>(0.5));
    local_7 = static_cast<uint>(base + 5u);
    uint _e107 = local_7;
    output[_e107] = as_type<uint>(as_type<float>(_e100));
    uint _e111 = _naga_rintf(as_type<uint>(2.5));
    local_8 = static_cast<uint>(base + 6u);
    uint _e118 = local_8;
    output[_e118] = as_type<uint>(as_type<float>(_e111));
    uint _e122 = _naga_roundf(as_type<uint>(2.5));
    local_9 = static_cast<uint>(base + 7u);
    uint _e129 = local_9;
    output[_e129] = as_type<uint>(as_type<float>(_e122));
    uint _e134 = _naga_rintf(as_type<uint>(-(2.5)));
    local_10 = static_cast<uint>(base + 8u);
    uint _e141 = local_10;
    output[_e141] = as_type<uint>(as_type<float>(_e134));
    uint _e146 = _naga_roundf(as_type<uint>(-(2.5)));
    local_11 = static_cast<uint>(base + 9u);
    uint _e153 = local_11;
    output[_e153] = as_type<uint>(as_type<float>(_e146));
    float _e157 = rounded_even(static_cast<float>(3u));
    local_12 = static_cast<uint>(base + 10u);
    uint _e163 = local_12;
    output[_e163] = as_type<uint>(_e157);
    int _e166 = rintf(true);
    local_13 = static_cast<uint>(base + 11u);
    uint _e172 = local_13;
    output[_e172] = static_cast<uint>(_e166);
    if (true) {
        uint _e176 = _naga_rintf(as_type<uint>(value_2));
        uint _e179 = _naga_rintf(as_type<uint>(as_type<float>(_e176)));
        local_15 = as_type<float>(_e179);
    } else {
        int _e182 = cursor;
        cursor = as_type<int>(as_type<uint>(_e182) + as_type<uint>(1));
        uint _e187 = _naga_rintf(as_type<uint>(static_cast<float>(_e182)));
        local_15 = as_type<float>(_e187);
    }
    float _e191 = local_15;
    local_14 = static_cast<uint>(base + 12u);
    uint _e197 = local_14;
    output[_e197] = as_type<uint>(_e191);
    int _e199 = cursor;
    local_16 = static_cast<uint>(base + 13u);
    uint _e205 = local_16;
    output[_e205] = static_cast<uint>(_e199);
}
