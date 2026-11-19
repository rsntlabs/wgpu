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
    uint _e28 = _e24 - _e26;
    output[base] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> _e28) & 8388607u)) + (((value_1 & ((1u << _e28) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e50 = forward(value_1);
    uint _e55 = 31u - metal::clz(_e50 | 1u);
    uint _e57 = metal::min(_e55, 23u);
    uint _e59 = _e55 - _e57;
    local = static_cast<uint>(base + 1u);
    uint _e83 = local;
    output[_e83] = as_type<uint>(as_type<float>((_e50 != 0u) ? ((((_e55 + 127u) << 23u) | (((_e50 << (23u - _e57)) >> _e59) & 8388607u)) + (((_e50 & ((1u << _e59) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e85 = counter;
    counter = _e85 + static_cast<uint>(1);
    uint _e93 = 31u - metal::clz(value_1 | 1u);
    uint _e95 = metal::min(_e93, 23u);
    uint _e97 = _e93 - _e95;
    local_1 = static_cast<uint>(base + 2u);
    uint _e121 = local_1;
    output[_e121] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e93 + 127u) << 23u) | (((value_1 << (23u - _e95)) >> _e97) & 8388607u)) + (((value_1 & ((1u << _e97) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e123 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e128 = local_2;
    output[_e128] = _e123;
    if ((index & 1u) != 0u) {
        uint _e134 = counter;
        local_12 = _e134;
        uint _e136 = local_12;
        counter = _e136 + static_cast<uint>(1);
        local_13 = value_1;
        uint _e141 = local_13;
        local_4 = _e141;
        uint _e143 = local_4;
        uint _e148 = 31u - metal::clz(_e143 | 1u);
        uint _e150 = metal::min(_e148, 23u);
        uint _e152 = _e148 - _e150;
        local_6 = as_type<uint>(as_type<float>((_e143 != 0u) ? ((((_e148 + 127u) << 23u) | (((_e143 << (23u - _e150)) >> _e152) & 8388607u)) + (((_e143 & ((1u << _e152) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    } else {
        uint _e173 = counter;
        local_14 = _e173;
        uint _e175 = local_14;
        counter = _e175 + static_cast<uint>(1);
        local_15 = value_1;
        uint _e180 = local_15;
        local_5 = _e180;
        uint _e182 = local_5;
        uint _e187 = 31u - metal::clz(_e182 | 1u);
        uint _e189 = metal::min(_e187, 23u);
        uint _e191 = _e187 - _e189;
        local_6 = as_type<uint>(as_type<float>((_e182 != 0u) ? ((((_e187 + 127u) << 23u) | (((_e182 << (23u - _e189)) >> _e191) & 8388607u)) + (((_e182 & ((1u << _e191) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    }
    uint _e213 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e218 = local_3;
    output[_e218] = _e213;
    uint _e220 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e225 = local_7;
    output[_e225] = _e220;
    uint _e229 = static_cast<uint>(naga_neg(1));
    uint _e234 = 31u - metal::clz(_e229 | 1u);
    uint _e236 = metal::min(_e234, 23u);
    uint _e238 = _e234 - _e236;
    local_8 = static_cast<uint>(base + 6u);
    uint _e262 = local_8;
    output[_e262] = as_type<uint>(as_type<float>((_e229 != 0u) ? ((((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> _e238) & 8388607u)) + (((_e229 & ((1u << _e238) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e265 = naga_f2u32(3.5);
    uint _e270 = 31u - metal::clz(_e265 | 1u);
    uint _e272 = metal::min(_e270, 23u);
    uint _e274 = _e270 - _e272;
    local_9 = static_cast<uint>(base + 7u);
    uint _e298 = local_9;
    output[_e298] = as_type<uint>(as_type<float>((_e265 != 0u) ? ((((_e270 + 127u) << 23u) | (((_e265 << (23u - _e272)) >> _e274) & 8388607u)) + (((_e265 & ((1u << _e274) - 1u)) != 0u) ? 1u : 0u)) : 0u));
    uint _e304 = 31u - metal::clz(value_1 | 1u);
    uint _e306 = metal::min(_e304, 23u);
    local_10 = static_cast<uint>(base + 8u);
    uint _e326 = local_10;
    output[_e326] = as_type<uint>(as_type<float>((value_1 != 0u) ? (((_e304 + 127u) << 23u) | (((value_1 << (23u - _e306)) >> (_e304 - _e306)) & 8388607u)) : 0u));
    uint _e332 = 31u - metal::clz(value_1 | 1u);
    uint _e334 = metal::min(_e332, 23u);
    uint _e336 = _e332 - _e334;
    uint _e338 = (value_1 << (23u - _e334)) >> _e336;
    uint _e345 = 1u << _e336;
    local_11 = static_cast<uint>(base + 9u);
    uint _e363 = local_11;
    output[_e363] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e332 + 127u) << 23u) | (_e338 & 8388607u)) + (((((value_1 & (_e345 - 1u)) << 1u) | (_e338 & 1u)) > _e345) ? 1u : 0u)) : 0u));
}
