// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef metal::uint2 type_3[1];
typedef uint type_4[1];

uint kind(
    float value_2
) {
    return 1u;
}

uint _naga_nextafterf(
    uint from_bits,
    uint toward_bits
) {
    uint _e8 = from_bits & 2147483647u;
    uint _e9 = toward_bits & 2147483647u;
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e13 = _e8 == 0u;
    if ((_e13 && (_e9 == 0u)) || (from_bits == toward_bits)) {
        return toward_bits;
    }
    if (_e13) {
        return (toward_bits & 2147483648u) | 1u;
    }
    return (((from_bits ^ toward_bits) < 2147483648u) && (_e9 > _e8)) ? (from_bits + 1u) : (from_bits - 1u);
}

struct next_valuesInput {
};
kernel void next_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint counter = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    float value = {};
    float value_1 = {};
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= 24u) {
        return;
    }
    uint base = 4u + (index * 4u);
    uint _e16 = input[index].x;
    float x = as_type<float>(_e16);
    uint _e20 = input[index].y;
    float y = as_type<float>(_e20);
    counter = 0u;
    uint _e26 = _naga_nextafterf(as_type<uint>(x), as_type<uint>(y));
    output[base] = as_type<uint>(as_type<float>(_e26));
    value = float {};
    value = x;
    uint _e34 = counter;
    counter = _e34 + static_cast<uint>(1);
    float _e38 = value;
    value_1 = float {};
    value_1 = y;
    uint _e42 = counter;
    counter = _e42 + static_cast<uint>(1);
    float _e46 = value_1;
    uint _e49 = _naga_nextafterf(as_type<uint>(_e38), as_type<uint>(_e46));
    local = static_cast<uint>(base + 1u);
    uint _e56 = local;
    output[_e56] = as_type<uint>(as_type<float>(_e49));
    uint _e58 = counter;
    local_1 = static_cast<uint>(base + 2u);
    uint _e63 = local_1;
    output[_e63] = _e58;
    uint _e67 = _naga_nextafterf(as_type<uint>(x), as_type<uint>(y));
    uint _e69 = kind(as_type<float>(_e67));
    local_2 = static_cast<uint>(base + 3u);
    uint _e74 = local_2;
    output[_e74] = _e69;
}
