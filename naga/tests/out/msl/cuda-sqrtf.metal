// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_sqrtf(
    uint input_bits
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration = {};
    uint _e5 = input_bits & 2147483647u;
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits & 8388607u;
    uint _e20 = _e5 >> 23u;
    significand = _e19 | 8388608u;
    adjusted_exponent = _e20 + 127u;
    if (_e20 == 0u) {
        uint _e28 = metal::clz(_e19) - 8u;
        significand = _e19 << _e28;
        adjusted_exponent = 128u - _e28;
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = _e33 & 1u;
    upper_word = _e32 >> (9u - _e34);
    lower_word = _e32 << (23u + _e34);
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = _e72 + 1u;
        }
        loop_init = false;
        uint _e50 = iteration;
        if (_e50 >= 24u) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = (_e55 << 2u) | (_e52 >> 14u);
        uint _e65 = (_e54 << 2u) | 1u;
        bool _e66 = _e63 >= _e65;
        uint _e69 = _e54 << 1u;
        upper_word = ((_e52 << 2u) | (_e53 >> 30u)) & 65535u;
        lower_word = _e53 << 2u;
        remainder = _e66 ? (_e63 - _e65) : _e63;
        root = _e66 ? (_e69 | 1u) : _e69;
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return ((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u);
}

float root_1(
    float value_1
) {
    uint _e2 = _naga_sqrtf(as_type<uint>(value_1));
    return as_type<float>(_e2);
}

float root_2(
    int value_2
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_2)));
    return as_type<float>(_e3);
}

float root_3(
    uint value_3
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_3)));
    return as_type<float>(_e3);
}

float root_4(
    bool value_4
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_4)));
    return as_type<float>(_e3);
}

int sqrtf(
    bool value_5
) {
    int local_10 = {};
    if (value_5) {
        local_10 = 7;
    } else {
        local_10 = 9;
    }
    int _e6 = local_10;
    return _e6;
}

float sqrtf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void roots(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    float value = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint _e2 = _naga_sqrtf(as_type<uint>(0.0));
    out[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e2));
    uint _e12 = _naga_sqrtf(as_type<uint>(-(0.0)));
    out[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e12));
    uint _e20 = _naga_sqrtf(as_type<uint>(1.0));
    out[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e20));
    float _e27 = root_2(4);
    out[static_cast<uint>(3)] = as_type<uint>(_e27);
    float _e33 = root_3(9u);
    out[static_cast<uint>(4)] = as_type<uint>(_e33);
    uint _e40 = _naga_sqrtf(as_type<uint>(6.25));
    out[static_cast<uint>(5)] = as_type<uint>(as_type<float>(_e40));
    uint _e48 = _naga_sqrtf(as_type<uint>(2.0));
    out[static_cast<uint>(6)] = as_type<uint>(as_type<float>(_e48));
    local = 1u;
    uint _e56 = local;
    uint _e59 = _naga_sqrtf(as_type<uint>(as_type<float>(_e56)));
    out[static_cast<uint>(7)] = as_type<uint>(as_type<float>(_e59));
    local_1 = 8388607u;
    uint _e67 = local_1;
    uint _e70 = _naga_sqrtf(as_type<uint>(as_type<float>(_e67)));
    out[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e70));
    local_2 = 8388608u;
    uint _e78 = local_2;
    uint _e81 = _naga_sqrtf(as_type<uint>(as_type<float>(_e78)));
    out[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e81));
    local_3 = 2139095039u;
    uint _e89 = local_3;
    uint _e92 = _naga_sqrtf(as_type<uint>(as_type<float>(_e89)));
    out[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e92));
    local_4 = 2139095040u;
    uint _e100 = local_4;
    uint _e103 = _naga_sqrtf(as_type<uint>(as_type<float>(_e100)));
    out[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e103));
    uint _e112 = _naga_sqrtf(as_type<uint>(-(1.0)));
    out[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e112));
    local_5 = 2139095041u;
    uint _e120 = local_5;
    uint _e123 = _naga_sqrtf(as_type<uint>(as_type<float>(_e120)));
    out[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e123));
    value = 4.0;
    float _e131 = value;
    value = _e131 + static_cast<float>(1);
    float _e135 = root_1(_e131);
    out[static_cast<uint>(14)] = as_type<uint>(_e135);
    float _e140 = value;
    out[static_cast<uint>(15)] = as_type<uint>(_e140);
    int _e146 = sqrtf(true);
    out[static_cast<uint>(16)] = static_cast<uint>(_e146);
    int _e152 = sqrtf(false);
    out[static_cast<uint>(17)] = static_cast<uint>(_e152);
    float _e159 = sqrtf_1(2.0, 3.0);
    out[static_cast<uint>(18)] = as_type<uint>(_e159);
    local_6 = 1065353217u;
    uint _e166 = local_6;
    uint _e169 = _naga_sqrtf(as_type<uint>(as_type<float>(_e166)));
    out[static_cast<uint>(19)] = as_type<uint>(as_type<float>(_e169));
    local_7 = 1065353218u;
    uint _e177 = local_7;
    uint _e180 = _naga_sqrtf(as_type<uint>(as_type<float>(_e177)));
    out[static_cast<uint>(20)] = as_type<uint>(as_type<float>(_e180));
    local_8 = 1065353215u;
    uint _e188 = local_8;
    uint _e191 = _naga_sqrtf(as_type<uint>(as_type<float>(_e188)));
    out[static_cast<uint>(21)] = as_type<uint>(as_type<float>(_e191));
    float _e198 = root_3(4294967295u);
    out[static_cast<uint>(22)] = as_type<uint>(_e198);
    float _e205 = root_2(naga_neg(4));
    out[static_cast<uint>(23)] = as_type<uint>(_e205);
    float _e211 = root_1(16.0);
    out[static_cast<uint>(24)] = as_type<uint>(_e211);
    uint _e218 = _naga_sqrtf(as_type<uint>(0.25));
    out[static_cast<uint>(25)] = as_type<uint>(as_type<float>(_e218));
    local_9 = 2147483649u;
    uint _e226 = local_9;
    uint _e229 = _naga_sqrtf(as_type<uint>(as_type<float>(_e226)));
    out[static_cast<uint>(26)] = as_type<uint>(as_type<float>(_e229));
    float _e236 = root_4(false);
    out[static_cast<uint>(27)] = as_type<uint>(_e236);
    float _e242 = root_4(true);
    out[static_cast<uint>(28)] = as_type<uint>(_e242);
    float _e248 = root_1(0.5);
    out[static_cast<uint>(29)] = as_type<uint>(_e248);
}
