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
    output[base] = naga_f2i32(value_1);
    float _e24 = forward(value_1);
    local = static_cast<uint>(base + 1u);
    uint _e30 = local;
    output[_e30] = naga_f2i32(_e24);
    uint _e32 = counter;
    counter = _e32 + static_cast<uint>(1);
    local_1 = static_cast<uint>(base + 2u);
    uint _e41 = local_1;
    output[_e41] = naga_f2i32(value_1);
    uint _e43 = counter;
    local_2 = static_cast<uint>(base + 3u);
    uint _e49 = local_2;
    output[_e49] = static_cast<int>(_e43);
    if ((index & 1u) != 0u) {
        uint _e55 = counter;
        local_12 = _e55;
        uint _e57 = local_12;
        counter = _e57 + static_cast<uint>(1);
        local_13 = value_1;
        float _e62 = local_13;
        local_4 = _e62;
        float _e64 = local_4;
        local_6 = naga_f2i32(_e64);
    } else {
        uint _e67 = counter;
        local_14 = _e67;
        uint _e69 = local_14;
        counter = _e69 + static_cast<uint>(1);
        local_15 = value_1;
        float _e74 = local_15;
        local_5 = _e74;
        float _e76 = local_5;
        local_6 = naga_f2i32(_e76);
    }
    int _e80 = local_6;
    local_3 = static_cast<uint>(base + 4u);
    uint _e85 = local_3;
    output[_e85] = _e80;
    uint _e87 = counter;
    local_7 = static_cast<uint>(base + 5u);
    uint _e93 = local_7;
    output[_e93] = static_cast<int>(_e87);
    local_8 = static_cast<uint>(base + 6u);
    uint _e102 = local_8;
    output[_e102] = naga_f2i32(static_cast<float>(16777217));
    local_9 = 7;
    extra = int {};
    extra = 3;
    int _e110 = local_9;
    int _e111 = extra;
    local_11 = as_type<int>(as_type<uint>(_e110) + as_type<uint>(_e111));
    int _e114 = local_11;
    local_10 = static_cast<uint>(base + 7u);
    uint _e119 = local_10;
    output[_e119] = _e114;
}
