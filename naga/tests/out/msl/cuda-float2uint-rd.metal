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

uint _naga_floorf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    uint _e6 = input_bits & 2147483648u;
    uint _e14 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e15 = _e14 - 1u;
    uint _e19 = input_bits & ~(_e15);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19)));
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
    int local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
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
    uint _e22 = _naga_floorf(as_type<uint>(value_1));
    output[base] = naga_f2u32(as_type<float>(_e22));
    float _e27 = forward(value_1);
    uint _e29 = _naga_floorf(as_type<uint>(_e27));
    local = static_cast<uint>(base + 1u);
    uint _e36 = local;
    output[_e36] = naga_f2u32(as_type<float>(_e29));
    uint _e38 = counter;
    counter = _e38 + static_cast<uint>(1);
    uint _e43 = _naga_floorf(as_type<uint>(value_1));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = naga_f2u32(as_type<float>(_e43));
    uint _e52 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e59 = local_2;
    output[_e59] = static_cast<uint>(static_cast<int>(_e52));
    if ((index & 1u) != 0u) {
        uint _e65 = counter;
        local_12 = _e65;
        uint _e67 = local_12;
        counter = _e67 + static_cast<uint>(1);
        local_13 = value_1;
        float _e72 = local_13;
        local_4 = _e72;
        float _e74 = local_4;
        uint _e76 = _naga_floorf(as_type<uint>(_e74));
        local_6 = naga_f2u32(as_type<float>(_e76));
    } else {
        uint _e80 = counter;
        local_14 = _e80;
        uint _e82 = local_14;
        counter = _e82 + static_cast<uint>(1);
        local_15 = value_1;
        float _e87 = local_15;
        local_5 = _e87;
        float _e89 = local_5;
        uint _e91 = _naga_floorf(as_type<uint>(_e89));
        local_6 = naga_f2u32(as_type<float>(_e91));
    }
    uint _e96 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e101 = local_3;
    output[_e101] = _e96;
    uint _e103 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e110 = local_7;
    output[_e110] = static_cast<uint>(static_cast<int>(_e103));
    uint _e115 = _naga_floorf(as_type<uint>(static_cast<float>(16777217u)));
    local_8 = static_cast<uint>(base + 6u);
    uint _e122 = local_8;
    output[_e122] = naga_f2u32(as_type<float>(_e115));
    local_9 = 7;
    extra = int {};
    extra = 3;
    int _e130 = local_9;
    int _e131 = extra;
    local_11 = static_cast<uint>(as_type<int>(as_type<uint>(_e130) + as_type<uint>(_e131)));
    uint _e135 = local_11;
    local_10 = static_cast<uint>(base + 7u);
    uint _e140 = local_10;
    output[_e140] = _e135;
}
