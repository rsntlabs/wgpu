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
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 9u);
    uint value_1 = input[index];
    counter = 0u;
    uint _e24 = 31u - metal::clz(value_1 | 1u);
    uint _e26 = metal::min(_e24, 23u);
    uint _e28 = _e24 - _e26;
    uint _e30 = (value_1 << (23u - _e26)) >> _e28;
    uint _e37 = 1u << _e28;
    output[base] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e24 + 127u) << 23u) | (_e30 & 8388607u)) + (((((value_1 & (_e37 - 1u)) << 1u) | (_e30 & 1u)) > _e37) ? 1u : 0u)) : 0u));
    uint _e53 = forward(value_1);
    uint _e58 = 31u - metal::clz(_e53 | 1u);
    uint _e60 = metal::min(_e58, 23u);
    uint _e62 = _e58 - _e60;
    uint _e64 = (_e53 << (23u - _e60)) >> _e62;
    uint _e71 = 1u << _e62;
    local = static_cast<uint>(base + 1u);
    uint _e89 = local;
    output[_e89] = as_type<uint>(as_type<float>((_e53 != 0u) ? ((((_e58 + 127u) << 23u) | (_e64 & 8388607u)) + (((((_e53 & (_e71 - 1u)) << 1u) | (_e64 & 1u)) > _e71) ? 1u : 0u)) : 0u));
    uint _e91 = counter;
    counter = _e91 + static_cast<uint>(1);
    uint _e99 = 31u - metal::clz(value_1 | 1u);
    uint _e101 = metal::min(_e99, 23u);
    uint _e103 = _e99 - _e101;
    uint _e105 = (value_1 << (23u - _e101)) >> _e103;
    uint _e112 = 1u << _e103;
    local_1 = static_cast<uint>(base + 2u);
    uint _e130 = local_1;
    output[_e130] = as_type<uint>(as_type<float>((value_1 != 0u) ? ((((_e99 + 127u) << 23u) | (_e105 & 8388607u)) + (((((value_1 & (_e112 - 1u)) << 1u) | (_e105 & 1u)) > _e112) ? 1u : 0u)) : 0u));
    uint _e132 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e137 = local_2;
    output[_e137] = _e132;
    if ((index & 1u) != 0u) {
        uint _e143 = counter;
        local_11 = _e143;
        uint _e145 = local_11;
        counter = _e145 + static_cast<uint>(1);
        local_12 = value_1;
        uint _e150 = local_12;
        local_4 = _e150;
        uint _e152 = local_4;
        uint _e157 = 31u - metal::clz(_e152 | 1u);
        uint _e159 = metal::min(_e157, 23u);
        uint _e161 = _e157 - _e159;
        uint _e163 = (_e152 << (23u - _e159)) >> _e161;
        uint _e170 = 1u << _e161;
        local_6 = as_type<uint>(as_type<float>((_e152 != 0u) ? ((((_e157 + 127u) << 23u) | (_e163 & 8388607u)) + (((((_e152 & (_e170 - 1u)) << 1u) | (_e163 & 1u)) > _e170) ? 1u : 0u)) : 0u));
    } else {
        uint _e185 = counter;
        local_13 = _e185;
        uint _e187 = local_13;
        counter = _e187 + static_cast<uint>(1);
        local_14 = value_1;
        uint _e192 = local_14;
        local_5 = _e192;
        uint _e194 = local_5;
        uint _e199 = 31u - metal::clz(_e194 | 1u);
        uint _e201 = metal::min(_e199, 23u);
        uint _e203 = _e199 - _e201;
        uint _e205 = (_e194 << (23u - _e201)) >> _e203;
        uint _e212 = 1u << _e203;
        local_6 = as_type<uint>(as_type<float>((_e194 != 0u) ? ((((_e199 + 127u) << 23u) | (_e205 & 8388607u)) + (((((_e194 & (_e212 - 1u)) << 1u) | (_e205 & 1u)) > _e212) ? 1u : 0u)) : 0u));
    }
    uint _e228 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e233 = local_3;
    output[_e233] = _e228;
    uint _e235 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e240 = local_7;
    output[_e240] = _e235;
    uint _e244 = static_cast<uint>(naga_neg(1));
    uint _e249 = 31u - metal::clz(_e244 | 1u);
    uint _e251 = metal::min(_e249, 23u);
    uint _e253 = _e249 - _e251;
    uint _e255 = (_e244 << (23u - _e251)) >> _e253;
    uint _e262 = 1u << _e253;
    local_8 = static_cast<uint>(base + 6u);
    uint _e280 = local_8;
    output[_e280] = as_type<uint>(as_type<float>((_e244 != 0u) ? ((((_e249 + 127u) << 23u) | (_e255 & 8388607u)) + (((((_e244 & (_e262 - 1u)) << 1u) | (_e255 & 1u)) > _e262) ? 1u : 0u)) : 0u));
    uint _e283 = naga_f2u32(3.5);
    uint _e288 = 31u - metal::clz(_e283 | 1u);
    uint _e290 = metal::min(_e288, 23u);
    uint _e292 = _e288 - _e290;
    uint _e294 = (_e283 << (23u - _e290)) >> _e292;
    uint _e301 = 1u << _e292;
    local_9 = static_cast<uint>(base + 7u);
    uint _e319 = local_9;
    output[_e319] = as_type<uint>(as_type<float>((_e283 != 0u) ? ((((_e288 + 127u) << 23u) | (_e294 & 8388607u)) + (((((_e283 & (_e301 - 1u)) << 1u) | (_e294 & 1u)) > _e301) ? 1u : 0u)) : 0u));
    uint _e325 = 31u - metal::clz(value_1 | 1u);
    uint _e327 = metal::min(_e325, 23u);
    local_10 = static_cast<uint>(base + 8u);
    uint _e347 = local_10;
    output[_e347] = as_type<uint>(as_type<float>((value_1 != 0u) ? (((_e325 + 127u) << 23u) | (((value_1 << (23u - _e327)) >> (_e325 - _e327)) & 8388607u)) : 0u));
}
