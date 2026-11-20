// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef metal::uint2 type_4[1];
typedef uint type_5[1];
struct type_6 {
    uint value;
    char _pad1[12];
};

uint kind(
    float value_4
) {
    return 1u;
}

uint _naga_ldexpf(
    uint bits,
    int exponent
) {
    uint _e12 = bits & 2147483647u;
    uint _e13 = bits & 2147483648u;
    if (_e12 > 2139095040u) {
        return 2143289344u;
    }
    if ((_e12 == 0u) || (_e12 == 2139095040u)) {
        return bits;
    }
    uint _e21 = metal::max(metal::clz(_e12), 8u) - 8u;
    uint _e23 = (_e12 << _e21) & 8388607u;
    uint _e24 = _e23 | 8388608u;
    int _e33 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(metal::max(static_cast<int>(_e12 >> 23u), 1)) - as_type<uint>(static_cast<int>(_e21)))) + as_type<uint>(metal::clamp(exponent, -512, 512)));
    if (_e33 >= 255) {
        return 2139095040u | _e13;
    }
    if (_e33 >= 1) {
        return ((static_cast<uint>(_e33) << 23u) | _e23) | _e13;
    }
    uint _e45 = static_cast<uint>(metal::clamp(as_type<int>(as_type<uint>(1) - as_type<uint>(_e33)), 1, 25));
    uint _e46 = _e24 >> _e45;
    uint _e47 = 1u << _e45;
    uint _e49 = _e24 & (_e47 - 1u);
    uint _e50 = _e47 >> 1u;
    return (_e46 + (((_e49 > _e50) || ((_e49 == _e50) && ((_e46 & 1u) != 0u))) ? 1u : 0u)) | _e13;
}

struct scale_valuesInput {
};
kernel void scale_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_5& output [[buffer(1)]]
, constant type_6& count [[buffer(2)]]
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
    float value = {};
    int value_1 = {};
    float value_2 = {};
    int value_3 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 8u);
    uint _e18 = input[index].x;
    float value_5 = as_type<float>(_e18);
    uint _e22 = input[index].y;
    int power = static_cast<int>(_e22);
    counter = 0u;
    uint _e27 = _naga_ldexpf(as_type<uint>(value_5), power);
    output[base] = as_type<uint>(as_type<float>(_e27));
    value = float {};
    value = value_5;
    uint _e35 = counter;
    counter = _e35 + static_cast<uint>(1);
    float _e39 = value;
    value_1 = int {};
    value_1 = power;
    uint _e43 = counter;
    counter = _e43 + static_cast<uint>(1);
    int _e47 = value_1;
    uint _e49 = _naga_ldexpf(as_type<uint>(_e39), _e47);
    local = static_cast<uint>(base + 1u);
    uint _e56 = local;
    output[_e56] = as_type<uint>(as_type<float>(_e49));
    uint _e58 = counter;
    local_1 = static_cast<uint>(base + 2u);
    uint _e63 = local_1;
    output[_e63] = _e58;
    uint _e66 = _naga_ldexpf(as_type<uint>(value_5), power);
    uint _e68 = kind(as_type<float>(_e66));
    local_2 = static_cast<uint>(base + 3u);
    uint _e73 = local_2;
    output[_e73] = _e68;
    uint _e76 = _naga_ldexpf(as_type<uint>(value_5), power);
    local_3 = static_cast<uint>(base + 4u);
    uint _e83 = local_3;
    output[_e83] = as_type<uint>(as_type<float>(_e76));
    value_2 = float {};
    value_2 = value_5;
    uint _e88 = counter;
    counter = _e88 + static_cast<uint>(1);
    float _e92 = value_2;
    value_3 = int {};
    value_3 = power;
    uint _e96 = counter;
    counter = _e96 + static_cast<uint>(1);
    int _e100 = value_3;
    uint _e102 = _naga_ldexpf(as_type<uint>(_e92), _e100);
    local_4 = static_cast<uint>(base + 5u);
    uint _e109 = local_4;
    output[_e109] = as_type<uint>(as_type<float>(_e102));
    uint _e111 = counter;
    local_5 = static_cast<uint>(base + 6u);
    uint _e116 = local_5;
    output[_e116] = _e111;
    uint _e119 = _naga_ldexpf(as_type<uint>(value_5), power);
    uint _e121 = kind(as_type<float>(_e119));
    local_6 = static_cast<uint>(base + 7u);
    uint _e126 = local_6;
    output[_e126] = _e121;
}
