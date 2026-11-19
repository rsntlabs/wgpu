// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];
struct type_2 {
    uint value;
    char _pad1[12];
};

uint forward(
    uint value
) {
    return value;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct convert_valuesInput {
};
kernel void convert_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_1 const& input [[buffer(0)]]
, device type_1& output [[buffer(1)]]
, constant type_2& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint counter = {};
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
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 10u);
    uint value_1 = input[index];
    counter = 0u;
    uint _e24 = 31u - metal::clz(value_1 | 1u);
    uint _e26 = metal::min(_e24, 23u);
    output[base] = as_type<uint>(as_type<float>((value_1 != 0u) ? (((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> (_e24 - _e26)) & 8388607u)) : 0u));
    uint _e44 = forward(value_1);
    uint _e49 = 31u - metal::clz(_e44 | 1u);
    uint _e51 = metal::min(_e49, 23u);
    local = static_cast<uint>(base + 1u);
    uint _e71 = local;
    output[_e71] = as_type<uint>(as_type<float>((_e44 != 0u) ? (((_e49 + 127u) << 23u) | (((_e44 << (23u - _e51)) >> (_e49 - _e51)) & 8388607u)) : 0u));
    uint _e73 = counter;
    counter = _e73 + static_cast<uint>(1);
    uint _e81 = 31u - metal::clz(value_1 | 1u);
    uint _e83 = metal::min(_e81, 23u);
    local_1 = static_cast<uint>(base + 2u);
    uint _e103 = local_1;
    output[_e103] = as_type<uint>(as_type<float>((value_1 != 0u) ? (((_e81 + 127u) << 23u) | (((value_1 << (23u - _e83)) >> (_e81 - _e83)) & 8388607u)) : 0u));
    uint _e105 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e110 = local_2;
    output[_e110] = _e105;
    if ((index & 1u) != 0u) {
        uint _e116 = counter;
        local_12 = _e116;
        uint _e118 = local_12;
        counter = _e118 + static_cast<uint>(1);
        local_13 = value_1;
        uint _e123 = local_13;
        local_4 = _e123;
        uint _e125 = local_4;
        uint _e130 = 31u - metal::clz(_e125 | 1u);
        uint _e132 = metal::min(_e130, 23u);
        local_6 = as_type<uint>(as_type<float>((_e125 != 0u) ? (((_e130 + 127u) << 23u) | (((_e125 << (23u - _e132)) >> (_e130 - _e132)) & 8388607u)) : 0u));
    } else {
        uint _e149 = counter;
        local_14 = _e149;
        uint _e151 = local_14;
        counter = _e151 + static_cast<uint>(1);
        local_15 = value_1;
        uint _e156 = local_15;
        local_5 = _e156;
        uint _e158 = local_5;
        uint _e163 = 31u - metal::clz(_e158 | 1u);
        uint _e165 = metal::min(_e163, 23u);
        local_6 = as_type<uint>(as_type<float>((_e158 != 0u) ? (((_e163 + 127u) << 23u) | (((_e158 << (23u - _e165)) >> (_e163 - _e165)) & 8388607u)) : 0u));
    }
    uint _e183 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e188 = local_3;
    output[_e188] = _e183;
    uint _e190 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e195 = local_7;
    output[_e195] = _e190;
    uint _e199 = static_cast<uint>(naga_neg(1));
    uint _e204 = 31u - metal::clz(_e199 | 1u);
    uint _e206 = metal::min(_e204, 23u);
    local_8 = static_cast<uint>(base + 6u);
    uint _e226 = local_8;
    output[_e226] = as_type<uint>(as_type<float>((_e199 != 0u) ? (((_e204 + 127u) << 23u) | (((_e199 << (23u - _e206)) >> (_e204 - _e206)) & 8388607u)) : 0u));
    uint _e229 = naga_f2u32(3.5);
    uint _e234 = 31u - metal::clz(_e229 | 1u);
    uint _e236 = metal::min(_e234, 23u);
    local_9 = static_cast<uint>(base + 7u);
    uint _e256 = local_9;
    output[_e256] = as_type<uint>(as_type<float>((_e229 != 0u) ? (((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> (_e234 - _e236)) & 8388607u)) : 0u));
    uint _e262 = 31u - metal::clz(value_1 | 1u);
    uint _e264 = metal::min(_e262, 23u);
    uint _e266 = _e262 - _e264;
    local_10 = static_cast<uint>(base + 8u);
    uint _e290 = local_10;
    output[_e290] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e262 + 127u) << 23u) | (((value_1 << (23u - _e264)) >> _e266) & 8388607u)) + (((value_1 & ((1u << _e266) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e296 = 31u - metal::clz(value_1 | 1u);
    uint _e298 = metal::min(_e296, 23u);
    uint _e300 = _e296 - _e298;
    uint _e302 = (value_1 << (23u - _e298)) >> _e300;
    uint _e309 = 1u << _e300;
    local_11 = static_cast<uint>(base + 9u);
    uint _e327 = local_11;
    output[_e327] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e296 + 127u) << 23u) | (_e302 & 8388607u)) + (((((value_1 & (_e309 - 1u)) << 1u) | (_e302 & 1u)) > _e309) ? 1u : 0u)) : 0u));
}
