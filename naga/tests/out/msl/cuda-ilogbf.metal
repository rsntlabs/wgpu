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

uint kind(
    int value_1
) {
    return 2u;
}

struct exponent_valuesInput {
};
kernel void exponent_values(
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
    float value = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 4u);
    uint _e17 = input[index];
    float value_2 = as_type<float>(_e17);
    counter = 0u;
    uint _e23 = as_type<uint>(value_2) & 2147483647u;
    uint _e25 = _e23 >> 23u;
    output[base] = static_cast<uint>(((_e23 == 0u) || (_e23 > 2139095040u)) ? (-2147483647 - 1) : ((_e23 == 2139095040u) ? 2147483647 : ((_e25 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e23)))) : as_type<int>(as_type<uint>(static_cast<int>(_e25)) - as_type<uint>(127)))));
    value = float {};
    value = value_2;
    uint _e51 = counter;
    counter = _e51 + static_cast<uint>(1);
    float _e55 = value;
    uint _e58 = as_type<uint>(_e55) & 2147483647u;
    uint _e60 = _e58 >> 23u;
    local = static_cast<uint>(base + 1u);
    uint _e85 = local;
    output[_e85] = static_cast<uint>(((_e58 == 0u) || (_e58 > 2139095040u)) ? (-2147483647 - 1) : ((_e58 == 2139095040u) ? 2147483647 : ((_e60 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e58)))) : as_type<int>(as_type<uint>(static_cast<int>(_e60)) - as_type<uint>(127)))));
    uint _e87 = counter;
    local_1 = static_cast<uint>(base + 2u);
    uint _e92 = local_1;
    output[_e92] = _e87;
    uint _e96 = as_type<uint>(value_2) & 2147483647u;
    uint _e98 = _e96 >> 23u;
    uint _e118 = kind(((_e96 == 0u) || (_e96 > 2139095040u)) ? (-2147483647 - 1) : ((_e96 == 2139095040u) ? 2147483647 : ((_e98 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e96)))) : as_type<int>(as_type<uint>(static_cast<int>(_e98)) - as_type<uint>(127)))));
    local_2 = static_cast<uint>(base + 3u);
    uint _e123 = local_2;
    output[_e123] = _e118;
}
