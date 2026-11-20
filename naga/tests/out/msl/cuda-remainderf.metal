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
    float value_2
) {
    return 1u;
}

uint _naga_remainderf(
    uint dividend_bits,
    uint divisor_bits
) {
    uint dividend_significand = {};
    int dividend_exponent = {};
    uint divisor_significand = {};
    int divisor_exponent = {};
    uint remainder = {};
    uint remaining_bits = {};
    uint _e8 = dividend_bits & 2147483647u;
    uint _e9 = divisor_bits & 2147483647u;
    uint _e10 = dividend_bits & 2147483648u;
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if ((_e8 == 0u) || (_e9 == 2139095040u)) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    uint _e24 = _e8 & 8388607u;
    uint _e25 = _e8 >> 23u;
    dividend_significand = _e24 | 8388608u;
    dividend_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e25)) - as_type<uint>(127));
    if (_e25 == 0u) {
        uint _e35 = metal::clz(_e24) - 8u;
        dividend_significand = _e24 << _e35;
        dividend_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e35)));
    }
    uint _e40 = dividend_significand;
    int _e41 = dividend_exponent;
    uint _e46 = _e9 & 8388607u;
    uint _e47 = _e9 >> 23u;
    divisor_significand = _e46 | 8388608u;
    divisor_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e47)) - as_type<uint>(127));
    if (_e47 == 0u) {
        uint _e57 = metal::clz(_e46) - 8u;
        divisor_significand = _e46 << _e57;
        divisor_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e57)));
    }
    uint _e62 = divisor_significand;
    int _e63 = divisor_exponent;
    remainder = _e40;
    int _e66 = as_type<int>(as_type<uint>(_e41) - as_type<uint>(_e63));
    if (_e66 < -1) {
        return dividend_bits;
    }
    bool _e70 = _e66 == -1;
    uint _e72 = _e70 ? (_e62 << 1u) : _e62;
    remaining_bits = static_cast<uint>(_e70 ? 0 : _e66);
    uint2 loop_bound = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e76 = remaining_bits;
        if (_e76 == 0u) {
            break;
        }
        uint _e78 = remainder;
        remainder = ((_e78 >= _e72) ? (_e78 - _e72) : _e78) << 1u;
        remaining_bits = _e76 - 1u;
    }
    uint _e84 = remainder;
    bool _e85 = _e84 >= _e72;
    uint _e87 = _e85 ? (_e84 - _e72) : _e84;
    uint _e88 = _e87 + _e87;
    bool _e92 = (_e88 > _e72) || ((_e88 == _e72) && _e85);
    uint _e96 = _e92 ? (_e72 - _e87) : _e87;
    uint _e97 = _e92 ? (_e10 ^ 2147483648u) : _e10;
    if (_e96 == 0u) {
        return _e97;
    }
    uint _e101 = metal::clz(_e96) - 8u;
    uint _e102 = _e96 << _e101;
    int _e104 = as_type<int>(as_type<uint>(_e70 ? _e41 : _e63) - as_type<uint>(static_cast<int>(_e101)));
    return _e97 | ((_e104 >= -126) ? ((static_cast<uint>(as_type<int>(as_type<uint>(_e104) + as_type<uint>(127))) << 23u) | (_e102 & 8388607u)) : (_e102 >> (static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e104))) & 31u)));
}

struct nearest_remaindersInput {
};
kernel void nearest_remainders(
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
    float value = {};
    float value_1 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 4u);
    uint _e18 = input[index].x;
    float x = as_type<float>(_e18);
    uint _e22 = input[index].y;
    float y = as_type<float>(_e22);
    counter = 0u;
    uint _e28 = _naga_remainderf(as_type<uint>(x), as_type<uint>(y));
    output[base] = as_type<uint>(as_type<float>(_e28));
    value = float {};
    value = x;
    uint _e36 = counter;
    counter = _e36 + static_cast<uint>(1);
    float _e40 = value;
    value_1 = float {};
    value_1 = y;
    uint _e44 = counter;
    counter = _e44 + static_cast<uint>(1);
    float _e48 = value_1;
    uint _e51 = _naga_remainderf(as_type<uint>(_e40), as_type<uint>(_e48));
    local = static_cast<uint>(base + 1u);
    uint _e58 = local;
    output[_e58] = as_type<uint>(as_type<float>(_e51));
    uint _e60 = counter;
    local_1 = static_cast<uint>(base + 2u);
    uint _e65 = local_1;
    output[_e65] = _e60;
    uint _e69 = _naga_remainderf(as_type<uint>(x), as_type<uint>(y));
    uint _e71 = kind(as_type<float>(_e69));
    local_2 = static_cast<uint>(base + 3u);
    uint _e76 = local_2;
    output[_e76] = _e71;
}
