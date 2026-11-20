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
    float value_3
) {
    return 1u;
}

uint _naga_divide_f32_rd(
    uint numerator_bits,
    uint denominator_bits
) {
    uint numerator_significand = {};
    int numerator_exponent = {};
    uint denominator_significand = {};
    int denominator_exponent = {};
    uint quotient = {};
    uint remainder = {};
    uint iteration = {};
    uint _e8 = numerator_bits & 2147483647u;
    uint _e9 = denominator_bits & 2147483647u;
    uint _e11 = (numerator_bits ^ denominator_bits) & 2147483648u;
    uint _e12 = _e11 | 2139095040u;
    bool _e16 = _e8 == 0u;
    bool _e17 = _e9 == 0u;
    bool _e19 = _e8 == 2139095040u;
    bool _e20 = _e9 == 2139095040u;
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    uint _e30 = _e8 & 8388607u;
    uint _e31 = _e8 >> 23u;
    numerator_significand = _e30 | 8388608u;
    numerator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e31)) - as_type<uint>(127));
    if (_e31 == 0u) {
        uint _e41 = metal::clz(_e30) - 8u;
        numerator_significand = _e30 << _e41;
        numerator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = _e9 & 8388607u;
    uint _e53 = _e9 >> 23u;
    denominator_significand = _e52 | 8388608u;
    denominator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e53)) - as_type<uint>(127));
    if (_e53 == 0u) {
        uint _e63 = metal::clz(_e52) - 8u;
        denominator_significand = _e52 << _e63;
        denominator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = _e46 < _e68;
    int _e75 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e47) - as_type<uint>(_e69))) - as_type<uint>(static_cast<int>(_e70)));
    bool _e78 = _e11 != 0u;
    if (_e75 < -150) {
        return _e11 | static_cast<uint>(_e78);
    }
    quotient = 1u;
    remainder = (_e70 ? (_e46 << 1u) : _e46) - _e68;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e97 = iteration;
            iteration = _e97 + 1u;
        }
        loop_init = false;
        uint _e86 = iteration;
        if (_e86 >= 23u) {
            break;
        }
        uint _e88 = remainder;
        uint _e89 = quotient;
        uint _e90 = _e88 << 1u;
        bool _e91 = _e90 >= _e68;
        remainder = _e91 ? (_e90 - _e68) : _e90;
        quotient = (_e89 << 1u) | (_e91 ? 1u : 0u);
    }
    uint _e99 = quotient;
    uint _e100 = remainder;
    if (_e75 < -126) {
        uint _e106 = static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e75))) & 31u;
        return _e11 | ((_e99 >> _e106) + static_cast<uint>(_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)));
    }
    uint _e120 = _e99 + ((_e78 && (_e100 != 0u)) ? 1u : 0u);
    uint _e122 = _e120 >> 24u;
    int _e125 = as_type<int>(as_type<uint>(_e75) + as_type<uint>(static_cast<int>(_e122)));
    if (_e125 > 127) {
        return _e78 ? _e12 : 2139095039u;
    }
    return _e11 | ((static_cast<uint>(as_type<int>(as_type<uint>(_e125) + as_type<uint>(127))) << 23u) | ((_e120 >> _e122) & 8388607u));
}

struct divide_valuesInput {
};
kernel void divide_values(
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
    float value_1 = {};
    float value_2 = {};
    uint count_1 = count.value;
    uint index = threadIdx.x + (blockIdx.x * 4u);
    if (index >= count_1) {
        return;
    }
    uint base = 4u + (index * 8u);
    uint _e18 = input[index].x;
    float x = as_type<float>(_e18);
    uint _e22 = input[index].y;
    float y = as_type<float>(_e22);
    counter = 0u;
    uint _e28 = _naga_divide_f32_rd(as_type<uint>(x), as_type<uint>(y));
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
    uint _e51 = _naga_divide_f32_rd(as_type<uint>(_e40), as_type<uint>(_e48));
    local = static_cast<uint>(base + 1u);
    uint _e58 = local;
    output[_e58] = as_type<uint>(as_type<float>(_e51));
    uint _e60 = counter;
    local_1 = static_cast<uint>(base + 2u);
    uint _e65 = local_1;
    output[_e65] = _e60;
    uint _e70 = _naga_divide_f32_rd(as_type<uint>(1.0), as_type<uint>(y));
    local_2 = static_cast<uint>(base + 3u);
    uint _e77 = local_2;
    output[_e77] = as_type<uint>(as_type<float>(_e70));
    value_2 = float {};
    value_2 = y;
    uint _e82 = counter;
    counter = _e82 + static_cast<uint>(1);
    float _e86 = value_2;
    uint _e90 = _naga_divide_f32_rd(as_type<uint>(1.0), as_type<uint>(_e86));
    local_3 = static_cast<uint>(base + 4u);
    uint _e97 = local_3;
    output[_e97] = as_type<uint>(as_type<float>(_e90));
    uint _e99 = counter;
    local_4 = static_cast<uint>(base + 5u);
    uint _e104 = local_4;
    output[_e104] = _e99;
    uint _e108 = _naga_divide_f32_rd(as_type<uint>(x), as_type<uint>(y));
    uint _e110 = kind(as_type<float>(_e108));
    local_5 = static_cast<uint>(base + 6u);
    uint _e115 = local_5;
    output[_e115] = _e110;
    uint _e120 = _naga_divide_f32_rd(as_type<uint>(1.0), as_type<uint>(y));
    uint _e122 = kind(as_type<float>(_e120));
    local_6 = static_cast<uint>(base + 7u);
    uint _e127 = local_6;
    output[_e127] = _e122;
}
