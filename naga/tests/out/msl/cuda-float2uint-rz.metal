// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_3[1];
struct type_4 {
    uint value;
    char _pad1[12];
};

float forward(
    float value
) {
    return value;
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct convert_valuesInput {
};
kernel void convert_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant type_4& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint counter = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    float local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    uint local_16 = {};
    float local_17 = {};
    int extra = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 10u);
    uint _e17 = input[index];
    float value_1 = as_type<float>(_e17);
    counter = 0u;
    output[base] = naga_f2u32(value_1);
    float _e24 = forward(value_1);
    local = static_cast<uint>(base + 1u);
    uint _e30 = local;
    output[_e30] = naga_f2u32(_e24);
    uint _e32 = counter;
    counter = _e32 + static_cast<uint>(1);
    local_1 = static_cast<uint>(base + 2u);
    uint _e41 = local_1;
    output[_e41] = naga_f2u32(value_1);
    uint _e43 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e48 = local_2;
    output[_e48] = _e43;
    if ((index & 1u) != 0u) {
        uint _e54 = counter;
        local_14 = _e54;
        uint _e56 = local_14;
        counter = _e56 + static_cast<uint>(1);
        local_15 = value_1;
        float _e61 = local_15;
        local_4 = _e61;
        float _e63 = local_4;
        local_6 = naga_f2u32(_e63);
    } else {
        uint _e66 = counter;
        local_16 = _e66;
        uint _e68 = local_16;
        counter = _e68 + static_cast<uint>(1);
        local_17 = value_1;
        float _e73 = local_17;
        local_5 = _e73;
        float _e75 = local_5;
        local_6 = naga_f2u32(_e75);
    }
    uint _e79 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e84 = local_3;
    output[_e84] = _e79;
    uint _e86 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e91 = local_7;
    output[_e91] = _e86;
    local_8 = static_cast<uint>(base + 6u);
    uint _e100 = local_8;
    output[_e100] = naga_f2u32(static_cast<float>(16777217u));
    local_9 = static_cast<uint>(base + 7u);
    uint _e109 = local_9;
    output[_e109] = naga_f2u32(static_cast<float>(2147483649u));
    local_10 = static_cast<uint>(base + 8u);
    uint _e118 = local_10;
    output[_e118] = naga_f2u32(static_cast<float>(true));
    local_11 = 7;
    extra = int {};
    extra = 3;
    int _e126 = local_11;
    int _e127 = extra;
    local_13 = static_cast<uint>(as_type<int>(as_type<uint>(_e126) + as_type<uint>(_e127)));
    uint _e131 = local_13;
    local_12 = static_cast<uint>(base + 9u);
    uint _e136 = local_12;
    output[_e136] = _e131;
}
