// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

float copied(
    float value,
    float sign
) {
    return as_type<float>((as_type<uint>(value) & 2147483647u) | (as_type<uint>(sign) & 2147483648u));
}

int copysignf(
    bool value_1,
    bool sign_1
) {
    int local_22 = {};
    if (value_1) {
        local_22 = 7;
    } else {
        local_22 = 9;
    }
    int _e6 = local_22;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct copy_signsInput {
};
kernel void copy_signs(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
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
    int cursor = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    bool run = {};
    bool local_15 = {};
    bool local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    float local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 912u) {
        return;
    }
    uint base = 4u + (index * 14u);
    local = static_cast<uint>(index * 2u);
    uint _e17 = local;
    uint _e20 = input[_e17];
    float value_2 = as_type<float>(_e20);
    local_1 = static_cast<uint>((index * 2u) + 1u);
    uint _e28 = local_1;
    uint _e30 = input[_e28];
    float sign_2 = as_type<float>(_e30);
    output[base] = as_type<uint>(as_type<float>((as_type<uint>(value_2) & 2147483647u) | (as_type<uint>(sign_2) & 2147483648u)));
    float _e43 = copied(value_2, sign_2);
    local_2 = static_cast<uint>(base + 1u);
    uint _e49 = local_2;
    output[_e49] = as_type<uint>(_e43);
    local_3 = static_cast<uint>(base + 2u);
    uint _e67 = local_3;
    output[_e67] = as_type<uint>(as_type<float>((as_type<uint>(0.0) & 2147483647u) | (as_type<uint>(-(0.0)) & 2147483648u)));
    local_4 = static_cast<uint>(base + 3u);
    uint _e85 = local_4;
    output[_e85] = as_type<uint>(as_type<float>((as_type<uint>(-(0.0)) & 2147483647u) | (as_type<uint>(0.0) & 2147483648u)));
    local_6 = 4286578689u;
    uint _e89 = local_6;
    local_5 = static_cast<uint>(base + 4u);
    uint _e105 = local_5;
    output[_e105] = as_type<uint>(as_type<float>((as_type<uint>(as_type<float>(_e89)) & 2147483647u) | (as_type<uint>(0.0) & 2147483648u)));
    local_8 = 2143363909u;
    uint _e109 = local_8;
    local_7 = static_cast<uint>(base + 5u);
    uint _e126 = local_7;
    output[_e126] = as_type<uint>(as_type<float>((as_type<uint>(as_type<float>(_e109)) & 2147483647u) | (as_type<uint>(-(0.0)) & 2147483648u)));
    float _e133 = copied(static_cast<float>(naga_neg(3)), static_cast<float>(0u));
    local_9 = static_cast<uint>(base + 6u);
    uint _e139 = local_9;
    output[_e139] = as_type<uint>(_e133);
    float _e146 = copied(static_cast<float>(5u), static_cast<float>(naga_neg(1)));
    local_10 = static_cast<uint>(base + 7u);
    uint _e152 = local_10;
    output[_e152] = as_type<uint>(_e146);
    int _e156 = copysignf(true, false);
    local_11 = static_cast<uint>(base + 8u);
    uint _e162 = local_11;
    output[_e162] = static_cast<uint>(_e156);
    cursor = 0;
    int _e168 = cursor;
    cursor = as_type<int>(as_type<uint>(_e168) + as_type<uint>(1));
    local_13 = static_cast<uint>((index * 2u) + static_cast<uint>(_e168));
    uint _e175 = local_13;
    uint _e177 = input[_e175];
    int _e181 = cursor;
    cursor = as_type<int>(as_type<uint>(_e181) + as_type<uint>(1));
    local_14 = static_cast<uint>((index * 2u) + static_cast<uint>(_e181));
    uint _e188 = local_14;
    uint _e190 = input[_e188];
    float _e192 = copied(as_type<float>(_e177), as_type<float>(_e190));
    local_12 = static_cast<uint>(base + 9u);
    uint _e198 = local_12;
    output[_e198] = as_type<uint>(_e192);
    run = false;
    bool _e202 = run;
    local_15 = _e202;
    if (_e202) {
        int _e204 = cursor;
        cursor = as_type<int>(as_type<uint>(_e204) + as_type<uint>(1));
        uint _e217 = _naga_fabsf(as_type<uint>(as_type<float>((as_type<uint>(static_cast<float>(_e204)) & 2147483647u) | (as_type<uint>(sign_2) & 2147483648u))));
        local_15 = _e217 != 0u;
    }
    run = true;
    bool _e221 = run;
    local_16 = _e221;
    if (_e221) {
    } else {
        int _e223 = cursor;
        cursor = as_type<int>(as_type<uint>(_e223) + as_type<uint>(1));
        uint _e236 = _naga_fabsf(as_type<uint>(as_type<float>((as_type<uint>(static_cast<float>(_e223)) & 2147483647u) | (as_type<uint>(sign_2) & 2147483648u))));
        local_16 = _e236 != 0u;
    }
    int _e239 = cursor;
    local_17 = static_cast<uint>(base + 10u);
    uint _e245 = local_17;
    output[_e245] = static_cast<uint>(_e239);
    bool _e247 = run;
    if (_e247) {
        local_19 = as_type<float>((as_type<uint>(value_2) & 2147483647u) | (as_type<uint>(sign_2) & 2147483648u));
    } else {
        int _e257 = cursor;
        cursor = as_type<int>(as_type<uint>(_e257) + as_type<uint>(1));
        local_19 = as_type<float>((as_type<uint>(static_cast<float>(_e257)) & 2147483647u) | (as_type<uint>(sign_2) & 2147483648u));
    }
    float _e271 = local_19;
    local_18 = static_cast<uint>(base + 11u);
    uint _e277 = local_18;
    output[_e277] = as_type<uint>(_e271);
    float _e283 = copied(static_cast<float>(true), -(1.0));
    local_20 = static_cast<uint>(base + 12u);
    uint _e289 = local_20;
    output[_e289] = as_type<uint>(_e283);
    int _e291 = cursor;
    local_21 = static_cast<uint>(base + 13u);
    uint _e297 = local_21;
    output[_e297] = static_cast<uint>(_e291);
}
