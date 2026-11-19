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
    output[base] = as_type<uint>(as_type<float>((_e28 != 0u) ? ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> _e36) & 8388607u)) + (((_e28 & ((1u << _e36) - 1u)) != 0u) ? _e22 : 0u))) : 0u));
    int _e59 = forward(value_1);
    uint _e60 = as_type<uint>(_e59);
    uint _e62 = _e60 >> 31u;
    uint _e68 = (_e60 ^ ((_e62 != 0u) ? 4294967295u : 0u)) + _e62;
    uint _e72 = 31u - metal::clz(_e68 | 1u);
    uint _e74 = metal::min(_e72, 23u);
    uint _e76 = _e72 - _e74;
    local = static_cast<uint>(base + 1u);
    uint _e101 = local;
    output[_e101] = as_type<uint>(as_type<float>((_e68 != 0u) ? ((_e62 << 31u) | ((((_e72 + 127u) << 23u) | (((_e68 << (23u - _e74)) >> _e76) & 8388607u)) + (((_e68 & ((1u << _e76) - 1u)) != 0u) ? _e62 : 0u))) : 0u));
    uint _e103 = counter;
    counter = _e103 + static_cast<uint>(1);
    uint _e107 = as_type<uint>(value_1);
    uint _e109 = _e107 >> 31u;
    uint _e115 = (_e107 ^ ((_e109 != 0u) ? 4294967295u : 0u)) + _e109;
    uint _e119 = 31u - metal::clz(_e115 | 1u);
    uint _e121 = metal::min(_e119, 23u);
    uint _e123 = _e119 - _e121;
    local_1 = static_cast<uint>(base + 2u);
    uint _e148 = local_1;
    output[_e148] = as_type<uint>(as_type<float>((_e115 != 0u) ? ((_e109 << 31u) | ((((_e119 + 127u) << 23u) | (((_e115 << (23u - _e121)) >> _e123) & 8388607u)) + (((_e115 & ((1u << _e123) - 1u)) != 0u) ? _e109 : 0u))) : 0u));
    uint _e150 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e155 = local_2;
    output[_e155] = _e150;
    if ((index & 1u) != 0u) {
        uint _e161 = counter;
        local_12 = _e161;
        uint _e163 = local_12;
        counter = _e163 + static_cast<uint>(1);
        local_13 = value_1;
        int _e168 = local_13;
        local_4 = _e168;
        int _e170 = local_4;
        uint _e171 = as_type<uint>(_e170);
        uint _e173 = _e171 >> 31u;
        uint _e179 = (_e171 ^ ((_e173 != 0u) ? 4294967295u : 0u)) + _e173;
        uint _e183 = 31u - metal::clz(_e179 | 1u);
        uint _e185 = metal::min(_e183, 23u);
        uint _e187 = _e183 - _e185;
        local_6 = as_type<uint>(as_type<float>((_e179 != 0u) ? ((_e173 << 31u) | ((((_e183 + 127u) << 23u) | (((_e179 << (23u - _e185)) >> _e187) & 8388607u)) + (((_e179 & ((1u << _e187) - 1u)) != 0u) ? _e173 : 0u))) : 0u));
    } else {
        uint _e209 = counter;
        local_14 = _e209;
        uint _e211 = local_14;
        counter = _e211 + static_cast<uint>(1);
        local_15 = value_1;
        int _e216 = local_15;
        local_5 = _e216;
        int _e218 = local_5;
        uint _e219 = as_type<uint>(_e218);
        uint _e221 = _e219 >> 31u;
        uint _e227 = (_e219 ^ ((_e221 != 0u) ? 4294967295u : 0u)) + _e221;
        uint _e231 = 31u - metal::clz(_e227 | 1u);
        uint _e233 = metal::min(_e231, 23u);
        uint _e235 = _e231 - _e233;
        local_6 = as_type<uint>(as_type<float>((_e227 != 0u) ? ((_e221 << 31u) | ((((_e231 + 127u) << 23u) | (((_e227 << (23u - _e233)) >> _e235) & 8388607u)) + (((_e227 & ((1u << _e235) - 1u)) != 0u) ? _e221 : 0u))) : 0u));
    }
    uint _e258 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e263 = local_3;
    output[_e263] = _e258;
    uint _e265 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e270 = local_7;
    output[_e270] = _e265;
    uint _e274 = as_type<uint>(static_cast<int>(4294967295u));
    uint _e276 = _e274 >> 31u;
    uint _e282 = (_e274 ^ ((_e276 != 0u) ? 4294967295u : 0u)) + _e276;
    uint _e286 = 31u - metal::clz(_e282 | 1u);
    uint _e288 = metal::min(_e286, 23u);
    uint _e290 = _e286 - _e288;
    local_8 = static_cast<uint>(base + 6u);
    uint _e315 = local_8;
    output[_e315] = as_type<uint>(as_type<float>((_e282 != 0u) ? ((_e276 << 31u) | ((((_e286 + 127u) << 23u) | (((_e282 << (23u - _e288)) >> _e290) & 8388607u)) + (((_e282 & ((1u << _e290) - 1u)) != 0u) ? _e276 : 0u))) : 0u));
    uint _e320 = as_type<uint>(naga_f2i32(-(3.5)));
    uint _e322 = _e320 >> 31u;
    uint _e328 = (_e320 ^ ((_e322 != 0u) ? 4294967295u : 0u)) + _e322;
    uint _e332 = 31u - metal::clz(_e328 | 1u);
    uint _e334 = metal::min(_e332, 23u);
    uint _e336 = _e332 - _e334;
    local_9 = static_cast<uint>(base + 7u);
    uint _e361 = local_9;
    output[_e361] = as_type<uint>(as_type<float>((_e328 != 0u) ? ((_e322 << 31u) | ((((_e332 + 127u) << 23u) | (((_e328 << (23u - _e334)) >> _e336) & 8388607u)) + (((_e328 & ((1u << _e336) - 1u)) != 0u) ? _e322 : 0u))) : 0u));
    uint _e363 = as_type<uint>(value_1);
    uint _e365 = _e363 >> 31u;
    uint _e371 = (_e363 ^ ((_e365 != 0u) ? 4294967295u : 0u)) + _e365;
    uint _e375 = 31u - metal::clz(_e371 | 1u);
    uint _e377 = metal::min(_e375, 23u);
    local_10 = static_cast<uint>(base + 8u);
    uint _e398 = local_10;
    output[_e398] = as_type<uint>(as_type<float>((_e371 != 0u) ? ((_e365 << 31u) | (((_e375 + 127u) << 23u) | (((_e371 << (23u - _e377)) >> (_e375 - _e377)) & 8388607u))) : 0u));
    uint _e400 = as_type<uint>(value_1);
    uint _e402 = _e400 >> 31u;
    uint _e408 = (_e400 ^ ((_e402 != 0u) ? 4294967295u : 0u)) + _e402;
    uint _e412 = 31u - metal::clz(_e408 | 1u);
    uint _e414 = metal::min(_e412, 23u);
    uint _e416 = _e412 - _e414;
    uint _e418 = (_e408 << (23u - _e414)) >> _e416;
    uint _e426 = 1u << _e416;
    local_11 = static_cast<uint>(base + 9u);
    uint _e444 = local_11;
    output[_e444] = as_type<uint>(as_type<float>((_e408 != 0u) ? ((_e402 << 31u) | ((((_e412 + 127u) << 23u) | (_e418 & 8388607u)) + (((((_e408 & (_e426 - 1u)) << 1u) | (_e418 & 1u)) > _e426) ? 1u : 0u))) : 0u));
}
