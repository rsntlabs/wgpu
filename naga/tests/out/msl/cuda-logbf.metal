// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_2[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

uint kind(
    float value_1
) {
    return 1u;
}

struct exponent_valuesInput {
};
kernel void exponent_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2 const& input [[buffer(0)]]
, device type_2& output [[buffer(1)]]
, constant type_3& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint counter = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
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
    bool _e38 = _e23 > 2139095040u;
    local = ((_e23 == 0u) || _e38) ? (_e38 ? 2143289344u : 4286578688u) : ((_e23 == 2139095040u) ? 2139095040u : as_type<uint>(static_cast<float>((_e25 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e23)))) : as_type<int>(as_type<uint>(static_cast<int>(_e25)) - as_type<uint>(127)))));
    uint _e50 = local;
    output[base] = as_type<uint>(as_type<float>(_e50));
    value = float {};
    value = value_2;
    uint _e58 = counter;
    counter = _e58 + static_cast<uint>(1);
    float _e62 = value;
    uint _e65 = as_type<uint>(_e62) & 2147483647u;
    uint _e67 = _e65 >> 23u;
    bool _e80 = _e65 > 2139095040u;
    local_2 = ((_e65 == 0u) || _e80) ? (_e80 ? 2143289344u : 4286578688u) : ((_e65 == 2139095040u) ? 2139095040u : as_type<uint>(static_cast<float>((_e67 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e65)))) : as_type<int>(as_type<uint>(static_cast<int>(_e67)) - as_type<uint>(127)))));
    uint _e92 = local_2;
    local_1 = static_cast<uint>(base + 1u);
    uint _e99 = local_1;
    output[_e99] = as_type<uint>(as_type<float>(_e92));
    uint _e101 = counter;
    local_3 = static_cast<uint>(base + 2u);
    uint _e106 = local_3;
    output[_e106] = _e101;
    uint _e110 = as_type<uint>(value_2) & 2147483647u;
    uint _e112 = _e110 >> 23u;
    bool _e125 = _e110 > 2139095040u;
    local_5 = ((_e110 == 0u) || _e125) ? (_e125 ? 2143289344u : 4286578688u) : ((_e110 == 2139095040u) ? 2139095040u : as_type<uint>(static_cast<float>((_e112 == 0u) ? as_type<int>(as_type<uint>(-118) - as_type<uint>(static_cast<int>(metal::clz(_e110)))) : as_type<int>(as_type<uint>(static_cast<int>(_e112)) - as_type<uint>(127)))));
    uint _e137 = local_5;
    uint _e139 = kind(as_type<float>(_e137));
    local_4 = static_cast<uint>(base + 3u);
    uint _e144 = local_4;
    output[_e144] = _e139;
}
