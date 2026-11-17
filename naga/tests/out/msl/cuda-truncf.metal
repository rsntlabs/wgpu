// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_truncf(
    uint input_bits
) {
    uint _e4 = input_bits & 2147483647u;
    return (_e4 > 2139095040u) ? 2143289344u : ((_e4 >= 1258291200u) ? input_bits : ((_e4 < 1065353216u) ? (input_bits & 2147483648u) : (input_bits & ~(((1u << ((150u - (_e4 >> 23u)) & 31u)) - 1u)))));
}

float truncated(
    float value
) {
    uint _e2 = _naga_truncf(as_type<uint>(value));
    return as_type<float>(_e2);
}

int truncf(
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

struct truncationsInput {
};
kernel void truncations(
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
    uint local_14 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 12u);
    uint _e15 = input[index];
    float value_2 = as_type<float>(_e15);
    uint _e18 = _naga_truncf(as_type<uint>(value_2));
    output[base] = as_type<uint>(as_type<float>(_e18));
    float _e23 = truncated(value_2);
    local = static_cast<uint>(base + 1u);
    uint _e29 = local;
    output[_e29] = as_type<uint>(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = as_type<int>(as_type<uint>(_e33) + as_type<uint>(1));
    local_2 = static_cast<uint>(index + static_cast<uint>(_e33));
    uint _e40 = local_2;
    uint _e42 = input[_e40];
    float _e44 = truncated(as_type<float>(_e42));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = as_type<uint>(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = as_type<int>(as_type<uint>(_e54) + as_type<uint>(1));
        uint _e59 = _naga_truncf(as_type<uint>(static_cast<float>(_e54)));
        uint _e62 = _naga_fabsf(as_type<uint>(as_type<float>(_e59)));
        local_3 = _e62 != 0u;
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
        uint _e72 = _naga_truncf(as_type<uint>(static_cast<float>(_e67)));
        uint _e75 = _naga_fabsf(as_type<uint>(as_type<float>(_e72)));
        local_4 = _e75 != 0u;
    }
    int _e78 = cursor;
    local_5 = static_cast<uint>(base + 3u);
    uint _e84 = local_5;
    output[_e84] = static_cast<uint>(_e78);
    uint _e89 = _naga_truncf(as_type<uint>(-(0.0)));
    local_6 = static_cast<uint>(base + 4u);
    uint _e96 = local_6;
    output[_e96] = as_type<uint>(as_type<float>(_e89));
    uint _e101 = _naga_truncf(as_type<uint>(-(0.25)));
    local_7 = static_cast<uint>(base + 5u);
    uint _e108 = local_7;
    output[_e108] = as_type<uint>(as_type<float>(_e101));
    uint _e113 = _naga_truncf(as_type<uint>(-(1.75)));
    local_8 = static_cast<uint>(base + 6u);
    uint _e120 = local_8;
    output[_e120] = as_type<uint>(as_type<float>(_e113));
    float _e124 = truncated(static_cast<float>(3u));
    local_9 = static_cast<uint>(base + 7u);
    uint _e130 = local_9;
    output[_e130] = as_type<uint>(_e124);
    int _e133 = truncf(true);
    local_10 = static_cast<uint>(base + 8u);
    uint _e139 = local_10;
    output[_e139] = static_cast<uint>(_e133);
    if (true) {
        uint _e143 = _naga_truncf(as_type<uint>(value_2));
        local_12 = as_type<float>(_e143);
    } else {
        int _e146 = cursor;
        cursor = as_type<int>(as_type<uint>(_e146) + as_type<uint>(1));
        uint _e151 = _naga_truncf(as_type<uint>(static_cast<float>(_e146)));
        local_12 = as_type<float>(_e151);
    }
    float _e155 = local_12;
    local_11 = static_cast<uint>(base + 9u);
    uint _e161 = local_11;
    output[_e161] = as_type<uint>(_e155);
    uint _e164 = _naga_truncf(as_type<uint>(value_2));
    uint _e167 = _naga_truncf(as_type<uint>(as_type<float>(_e164)));
    local_13 = static_cast<uint>(base + 10u);
    uint _e174 = local_13;
    output[_e174] = as_type<uint>(as_type<float>(_e167));
    int _e176 = cursor;
    local_14 = static_cast<uint>(base + 11u);
    uint _e182 = local_14;
    output[_e182] = static_cast<uint>(_e176);
}
