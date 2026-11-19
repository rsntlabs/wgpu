// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_2[1];
typedef uint type_3[1];
struct type_4 {
    uint value;
    char _pad1[12];
};

int forward(
    int value
) {
    return value;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


struct convert_valuesInput {
};
kernel void convert_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant type_4& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint counter = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    int local_4 = {};
    int local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int local_12 = {};
    uint local_13 = {};
    int local_14 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 9u);
    int value_1 = input[index];
    counter = 0u;
    uint _e20 = as_type<uint>(value_1);
    uint _e22 = _e20 >> 31u;
    uint _e28 = (_e20 ^ ((_e22 != 0u) ? 4294967295u : 0u)) + _e22;
    uint _e32 = 31u - metal::clz(_e28 | 1u);
    uint _e34 = metal::min(_e32, 23u);
    uint _e36 = _e32 - _e34;
    uint _e38 = (_e28 << (23u - _e34)) >> _e36;
    uint _e46 = 1u << _e36;
    output[base] = as_type<uint>(as_type<float>((_e28 != 0u) ? ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (_e38 & 8388607u)) + (((((_e28 & (_e46 - 1u)) << 1u) | (_e38 & 1u)) > _e46) ? 1u : 0u))) : 0u));
    int _e62 = forward(value_1);
    uint _e63 = as_type<uint>(_e62);
    uint _e65 = _e63 >> 31u;
    uint _e71 = (_e63 ^ ((_e65 != 0u) ? 4294967295u : 0u)) + _e65;
    uint _e75 = 31u - metal::clz(_e71 | 1u);
    uint _e77 = metal::min(_e75, 23u);
    uint _e79 = _e75 - _e77;
    uint _e81 = (_e71 << (23u - _e77)) >> _e79;
    uint _e89 = 1u << _e79;
    local = static_cast<uint>(base + 1u);
    uint _e107 = local;
    output[_e107] = as_type<uint>(as_type<float>((_e71 != 0u) ? ((_e65 << 31u) | ((((_e75 + 127u) << 23u) | (_e81 & 8388607u)) + (((((_e71 & (_e89 - 1u)) << 1u) | (_e81 & 1u)) > _e89) ? 1u : 0u))) : 0u));
    uint _e109 = counter;
    counter = _e109 + static_cast<uint>(1);
    uint _e113 = as_type<uint>(value_1);
    uint _e115 = _e113 >> 31u;
    uint _e121 = (_e113 ^ ((_e115 != 0u) ? 4294967295u : 0u)) + _e115;
    uint _e125 = 31u - metal::clz(_e121 | 1u);
    uint _e127 = metal::min(_e125, 23u);
    uint _e129 = _e125 - _e127;
    uint _e131 = (_e121 << (23u - _e127)) >> _e129;
    uint _e139 = 1u << _e129;
    local_1 = static_cast<uint>(base + 2u);
    uint _e157 = local_1;
    output[_e157] = as_type<uint>(as_type<float>((_e121 != 0u) ? ((_e115 << 31u) | ((((_e125 + 127u) << 23u) | (_e131 & 8388607u)) + (((((_e121 & (_e139 - 1u)) << 1u) | (_e131 & 1u)) > _e139) ? 1u : 0u))) : 0u));
    uint _e159 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e164 = local_2;
    output[_e164] = _e159;
    if ((index & 1u) != 0u) {
        uint _e170 = counter;
        local_11 = _e170;
        uint _e172 = local_11;
        counter = _e172 + static_cast<uint>(1);
        local_12 = value_1;
        int _e177 = local_12;
        local_4 = _e177;
        int _e179 = local_4;
        uint _e180 = as_type<uint>(_e179);
        uint _e182 = _e180 >> 31u;
        uint _e188 = (_e180 ^ ((_e182 != 0u) ? 4294967295u : 0u)) + _e182;
        uint _e192 = 31u - metal::clz(_e188 | 1u);
        uint _e194 = metal::min(_e192, 23u);
        uint _e196 = _e192 - _e194;
        uint _e198 = (_e188 << (23u - _e194)) >> _e196;
        uint _e206 = 1u << _e196;
        local_6 = as_type<uint>(as_type<float>((_e188 != 0u) ? ((_e182 << 31u) | ((((_e192 + 127u) << 23u) | (_e198 & 8388607u)) + (((((_e188 & (_e206 - 1u)) << 1u) | (_e198 & 1u)) > _e206) ? 1u : 0u))) : 0u));
    } else {
        uint _e221 = counter;
        local_13 = _e221;
        uint _e223 = local_13;
        counter = _e223 + static_cast<uint>(1);
        local_14 = value_1;
        int _e228 = local_14;
        local_5 = _e228;
        int _e230 = local_5;
        uint _e231 = as_type<uint>(_e230);
        uint _e233 = _e231 >> 31u;
        uint _e239 = (_e231 ^ ((_e233 != 0u) ? 4294967295u : 0u)) + _e233;
        uint _e243 = 31u - metal::clz(_e239 | 1u);
        uint _e245 = metal::min(_e243, 23u);
        uint _e247 = _e243 - _e245;
        uint _e249 = (_e239 << (23u - _e245)) >> _e247;
        uint _e257 = 1u << _e247;
        local_6 = as_type<uint>(as_type<float>((_e239 != 0u) ? ((_e233 << 31u) | ((((_e243 + 127u) << 23u) | (_e249 & 8388607u)) + (((((_e239 & (_e257 - 1u)) << 1u) | (_e249 & 1u)) > _e257) ? 1u : 0u))) : 0u));
    }
    uint _e273 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e278 = local_3;
    output[_e278] = _e273;
    uint _e280 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e285 = local_7;
    output[_e285] = _e280;
    uint _e289 = as_type<uint>(static_cast<int>(4294967295u));
    uint _e291 = _e289 >> 31u;
    uint _e297 = (_e289 ^ ((_e291 != 0u) ? 4294967295u : 0u)) + _e291;
    uint _e301 = 31u - metal::clz(_e297 | 1u);
    uint _e303 = metal::min(_e301, 23u);
    uint _e305 = _e301 - _e303;
    uint _e307 = (_e297 << (23u - _e303)) >> _e305;
    uint _e315 = 1u << _e305;
    local_8 = static_cast<uint>(base + 6u);
    uint _e333 = local_8;
    output[_e333] = as_type<uint>(as_type<float>((_e297 != 0u) ? ((_e291 << 31u) | ((((_e301 + 127u) << 23u) | (_e307 & 8388607u)) + (((((_e297 & (_e315 - 1u)) << 1u) | (_e307 & 1u)) > _e315) ? 1u : 0u))) : 0u));
    uint _e338 = as_type<uint>(naga_f2i32(-(3.5)));
    uint _e340 = _e338 >> 31u;
    uint _e346 = (_e338 ^ ((_e340 != 0u) ? 4294967295u : 0u)) + _e340;
    uint _e350 = 31u - metal::clz(_e346 | 1u);
    uint _e352 = metal::min(_e350, 23u);
    uint _e354 = _e350 - _e352;
    uint _e356 = (_e346 << (23u - _e352)) >> _e354;
    uint _e364 = 1u << _e354;
    local_9 = static_cast<uint>(base + 7u);
    uint _e382 = local_9;
    output[_e382] = as_type<uint>(as_type<float>((_e346 != 0u) ? ((_e340 << 31u) | ((((_e350 + 127u) << 23u) | (_e356 & 8388607u)) + (((((_e346 & (_e364 - 1u)) << 1u) | (_e356 & 1u)) > _e364) ? 1u : 0u))) : 0u));
    uint _e384 = as_type<uint>(value_1);
    uint _e386 = _e384 >> 31u;
    uint _e392 = (_e384 ^ ((_e386 != 0u) ? 4294967295u : 0u)) + _e386;
    uint _e396 = 31u - metal::clz(_e392 | 1u);
    uint _e398 = metal::min(_e396, 23u);
    local_10 = static_cast<uint>(base + 8u);
    uint _e419 = local_10;
    output[_e419] = as_type<uint>(as_type<float>((_e392 != 0u) ? ((_e386 << 31u) | (((_e396 + 127u) << 23u) | (((_e392 << (23u - _e398)) >> (_e396 - _e398)) & 8388607u))) : 0u));
}
