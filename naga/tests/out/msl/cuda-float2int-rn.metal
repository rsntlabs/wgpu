// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_3[1];
typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};

float forward(
    float value
) {
    return value;
}

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
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


struct convert_valuesInput {
};
kernel void convert_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant type_5& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint counter = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    float local_5 = {};
    int local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    int local_9 = {};
    uint local_10 = {};
    int local_11 = {};
    uint local_12 = {};
    float local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    int extra = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 8u);
    uint _e17 = input[index];
    float value_1 = as_type<float>(_e17);
    counter = 0u;
    uint _e22 = _naga_rintf(as_type<uint>(value_1));
    output[base] = naga_f2i32(as_type<float>(_e22));
    float _e27 = forward(value_1);
    uint _e29 = _naga_rintf(as_type<uint>(_e27));
    local = static_cast<uint>(base + 1u);
    uint _e36 = local;
    output[_e36] = naga_f2i32(as_type<float>(_e29));
    uint _e38 = counter;
    counter = _e38 + static_cast<uint>(1);
    uint _e43 = _naga_rintf(as_type<uint>(value_1));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = naga_f2i32(as_type<float>(_e43));
    uint _e52 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e58 = local_2;
    output[_e58] = static_cast<int>(_e52);
    if ((index & 1u) != 0u) {
        uint _e64 = counter;
        local_12 = _e64;
        uint _e66 = local_12;
        counter = _e66 + static_cast<uint>(1);
        local_13 = value_1;
        float _e71 = local_13;
        local_4 = _e71;
        float _e73 = local_4;
        uint _e75 = _naga_rintf(as_type<uint>(_e73));
        local_6 = naga_f2i32(as_type<float>(_e75));
    } else {
        uint _e79 = counter;
        local_14 = _e79;
        uint _e81 = local_14;
        counter = _e81 + static_cast<uint>(1);
        local_15 = value_1;
        float _e86 = local_15;
        local_5 = _e86;
        float _e88 = local_5;
        uint _e90 = _naga_rintf(as_type<uint>(_e88));
        local_6 = naga_f2i32(as_type<float>(_e90));
    }
    int _e95 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e100 = local_3;
    output[_e100] = _e95;
    uint _e102 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e108 = local_7;
    output[_e108] = static_cast<int>(_e102);
    uint _e113 = _naga_rintf(as_type<uint>(static_cast<float>(16777217)));
    local_8 = static_cast<uint>(base + 6u);
    uint _e120 = local_8;
    output[_e120] = naga_f2i32(as_type<float>(_e113));
    local_9 = 7;
    extra = int {};
    extra = 3;
    int _e128 = local_9;
    int _e129 = extra;
    local_11 = as_type<int>(as_type<uint>(_e128) + as_type<uint>(_e129));
    int _e132 = local_11;
    local_10 = static_cast<uint>(base + 7u);
    uint _e137 = local_10;
    output[_e137] = _e132;
}
