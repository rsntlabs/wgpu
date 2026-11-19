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
    uint local_12 = {};
    int local_13 = {};
    uint local_14 = {};
    int local_15 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 10u);
    int value_1 = input[index];
    counter = 0u;
    uint _e20 = as_type<uint>(value_1);
    uint _e22 = _e20 >> 31u;
    uint _e28 = (_e20 ^ ((_e22 != 0u) ? 4294967295u : 0u)) + _e22;
    uint _e32 = 31u - metal::clz(_e28 | 1u);
    uint _e34 = metal::min(_e32, 23u);
    uint _e36 = _e32 - _e34;
    output[base] = as_type<uint>(as_type<float>((_e28 != 0u) ? ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> _e36) & 8388607u)) + (((_e28 & ((1u << _e36) - 1u)) != 0u) ? (1u - _e22) : 0u))) : 0u));
    int _e60 = forward(value_1);
    uint _e61 = as_type<uint>(_e60);
    uint _e63 = _e61 >> 31u;
    uint _e69 = (_e61 ^ ((_e63 != 0u) ? 4294967295u : 0u)) + _e63;
    uint _e73 = 31u - metal::clz(_e69 | 1u);
    uint _e75 = metal::min(_e73, 23u);
    uint _e77 = _e73 - _e75;
    local = static_cast<uint>(base + 1u);
    uint _e103 = local;
    output[_e103] = as_type<uint>(as_type<float>((_e69 != 0u) ? ((_e63 << 31u) | ((((_e73 + 127u) << 23u) | (((_e69 << (23u - _e75)) >> _e77) & 8388607u)) + (((_e69 & ((1u << _e77) - 1u)) != 0u) ? (1u - _e63) : 0u))) : 0u));
    uint _e105 = counter;
    counter = _e105 + static_cast<uint>(1);
    uint _e109 = as_type<uint>(value_1);
    uint _e111 = _e109 >> 31u;
    uint _e117 = (_e109 ^ ((_e111 != 0u) ? 4294967295u : 0u)) + _e111;
    uint _e121 = 31u - metal::clz(_e117 | 1u);
    uint _e123 = metal::min(_e121, 23u);
    uint _e125 = _e121 - _e123;
    local_1 = static_cast<uint>(base + 2u);
    uint _e151 = local_1;
    output[_e151] = as_type<uint>(as_type<float>((_e117 != 0u) ? ((_e111 << 31u) | ((((_e121 + 127u) << 23u) | (((_e117 << (23u - _e123)) >> _e125) & 8388607u)) + (((_e117 & ((1u << _e125) - 1u)) != 0u) ? (1u - _e111) : 0u))) : 0u));
    uint _e153 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e158 = local_2;
    output[_e158] = _e153;
    if ((index & 1u) != 0u) {
        uint _e164 = counter;
        local_12 = _e164;
        uint _e166 = local_12;
        counter = _e166 + static_cast<uint>(1);
        local_13 = value_1;
        int _e171 = local_13;
        local_4 = _e171;
        int _e173 = local_4;
        uint _e174 = as_type<uint>(_e173);
        uint _e176 = _e174 >> 31u;
        uint _e182 = (_e174 ^ ((_e176 != 0u) ? 4294967295u : 0u)) + _e176;
        uint _e186 = 31u - metal::clz(_e182 | 1u);
        uint _e188 = metal::min(_e186, 23u);
        uint _e190 = _e186 - _e188;
        local_6 = as_type<uint>(as_type<float>((_e182 != 0u) ? ((_e176 << 31u) | ((((_e186 + 127u) << 23u) | (((_e182 << (23u - _e188)) >> _e190) & 8388607u)) + (((_e182 & ((1u << _e190) - 1u)) != 0u) ? (1u - _e176) : 0u))) : 0u));
    } else {
        uint _e213 = counter;
        local_14 = _e213;
        uint _e215 = local_14;
        counter = _e215 + static_cast<uint>(1);
        local_15 = value_1;
        int _e220 = local_15;
        local_5 = _e220;
        int _e222 = local_5;
        uint _e223 = as_type<uint>(_e222);
        uint _e225 = _e223 >> 31u;
        uint _e231 = (_e223 ^ ((_e225 != 0u) ? 4294967295u : 0u)) + _e225;
        uint _e235 = 31u - metal::clz(_e231 | 1u);
        uint _e237 = metal::min(_e235, 23u);
        uint _e239 = _e235 - _e237;
        local_6 = as_type<uint>(as_type<float>((_e231 != 0u) ? ((_e225 << 31u) | ((((_e235 + 127u) << 23u) | (((_e231 << (23u - _e237)) >> _e239) & 8388607u)) + (((_e231 & ((1u << _e239) - 1u)) != 0u) ? (1u - _e225) : 0u))) : 0u));
    }
    uint _e263 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e268 = local_3;
    output[_e268] = _e263;
    uint _e270 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e275 = local_7;
    output[_e275] = _e270;
    uint _e279 = as_type<uint>(static_cast<int>(4294967295u));
    uint _e281 = _e279 >> 31u;
    uint _e287 = (_e279 ^ ((_e281 != 0u) ? 4294967295u : 0u)) + _e281;
    uint _e291 = 31u - metal::clz(_e287 | 1u);
    uint _e293 = metal::min(_e291, 23u);
    uint _e295 = _e291 - _e293;
    local_8 = static_cast<uint>(base + 6u);
    uint _e321 = local_8;
    output[_e321] = as_type<uint>(as_type<float>((_e287 != 0u) ? ((_e281 << 31u) | ((((_e291 + 127u) << 23u) | (((_e287 << (23u - _e293)) >> _e295) & 8388607u)) + (((_e287 & ((1u << _e295) - 1u)) != 0u) ? (1u - _e281) : 0u))) : 0u));
    uint _e326 = as_type<uint>(naga_f2i32(-(3.5)));
    uint _e328 = _e326 >> 31u;
    uint _e334 = (_e326 ^ ((_e328 != 0u) ? 4294967295u : 0u)) + _e328;
    uint _e338 = 31u - metal::clz(_e334 | 1u);
    uint _e340 = metal::min(_e338, 23u);
    uint _e342 = _e338 - _e340;
    local_9 = static_cast<uint>(base + 7u);
    uint _e368 = local_9;
    output[_e368] = as_type<uint>(as_type<float>((_e334 != 0u) ? ((_e328 << 31u) | ((((_e338 + 127u) << 23u) | (((_e334 << (23u - _e340)) >> _e342) & 8388607u)) + (((_e334 & ((1u << _e342) - 1u)) != 0u) ? (1u - _e328) : 0u))) : 0u));
    uint _e370 = as_type<uint>(value_1);
    uint _e372 = _e370 >> 31u;
    uint _e378 = (_e370 ^ ((_e372 != 0u) ? 4294967295u : 0u)) + _e372;
    uint _e382 = 31u - metal::clz(_e378 | 1u);
    uint _e384 = metal::min(_e382, 23u);
    local_10 = static_cast<uint>(base + 8u);
    uint _e405 = local_10;
    output[_e405] = as_type<uint>(as_type<float>((_e378 != 0u) ? ((_e372 << 31u) | (((_e382 + 127u) << 23u) | (((_e378 << (23u - _e384)) >> (_e382 - _e384)) & 8388607u))) : 0u));
    uint _e407 = as_type<uint>(value_1);
    uint _e409 = _e407 >> 31u;
    uint _e415 = (_e407 ^ ((_e409 != 0u) ? 4294967295u : 0u)) + _e409;
    uint _e419 = 31u - metal::clz(_e415 | 1u);
    uint _e421 = metal::min(_e419, 23u);
    uint _e423 = _e419 - _e421;
    uint _e425 = (_e415 << (23u - _e421)) >> _e423;
    uint _e433 = 1u << _e423;
    local_11 = static_cast<uint>(base + 9u);
    uint _e451 = local_11;
    output[_e451] = as_type<uint>(as_type<float>((_e415 != 0u) ? ((_e409 << 31u) | ((((_e419 + 127u) << 23u) | (_e425 & 8388607u)) + (((((_e415 & (_e433 - 1u)) << 1u) | (_e425 & 1u)) > _e433) ? 1u : 0u))) : 0u));
}
