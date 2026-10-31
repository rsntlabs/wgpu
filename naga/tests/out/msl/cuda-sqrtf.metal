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
    int local_40 = {};
    if (value_5) {
        local_40 = 7;
    } else {
        local_40 = 9;
    }
    int _e6 = local_40;
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
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    float value = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint _e2 = _naga_sqrtf(as_type<uint>(0.0));
    local = static_cast<uint>(0);
    uint _e8 = local;
    out[_e8] = as_type<uint>(as_type<float>(_e2));
    uint _e14 = _naga_sqrtf(as_type<uint>(-(0.0)));
    local_1 = static_cast<uint>(1);
    uint _e20 = local_1;
    out[_e20] = as_type<uint>(as_type<float>(_e14));
    uint _e24 = _naga_sqrtf(as_type<uint>(1.0));
    local_2 = static_cast<uint>(2);
    uint _e30 = local_2;
    out[_e30] = as_type<uint>(as_type<float>(_e24));
    float _e33 = root_2(4);
    local_3 = static_cast<uint>(3);
    uint _e38 = local_3;
    out[_e38] = as_type<uint>(_e33);
    float _e41 = root_3(9u);
    local_4 = static_cast<uint>(4);
    uint _e46 = local_4;
    out[_e46] = as_type<uint>(_e41);
    uint _e50 = _naga_sqrtf(as_type<uint>(6.25));
    local_5 = static_cast<uint>(5);
    uint _e56 = local_5;
    out[_e56] = as_type<uint>(as_type<float>(_e50));
    uint _e60 = _naga_sqrtf(as_type<uint>(2.0));
    local_6 = static_cast<uint>(6);
    uint _e66 = local_6;
    out[_e66] = as_type<uint>(as_type<float>(_e60));
    local_8 = 1u;
    uint _e70 = local_8;
    uint _e73 = _naga_sqrtf(as_type<uint>(as_type<float>(_e70)));
    local_7 = static_cast<uint>(7);
    uint _e79 = local_7;
    out[_e79] = as_type<uint>(as_type<float>(_e73));
    local_10 = 8388607u;
    uint _e83 = local_10;
    uint _e86 = _naga_sqrtf(as_type<uint>(as_type<float>(_e83)));
    local_9 = static_cast<uint>(8);
    uint _e92 = local_9;
    out[_e92] = as_type<uint>(as_type<float>(_e86));
    local_12 = 8388608u;
    uint _e96 = local_12;
    uint _e99 = _naga_sqrtf(as_type<uint>(as_type<float>(_e96)));
    local_11 = static_cast<uint>(9);
    uint _e105 = local_11;
    out[_e105] = as_type<uint>(as_type<float>(_e99));
    local_14 = 2139095039u;
    uint _e109 = local_14;
    uint _e112 = _naga_sqrtf(as_type<uint>(as_type<float>(_e109)));
    local_13 = static_cast<uint>(10);
    uint _e118 = local_13;
    out[_e118] = as_type<uint>(as_type<float>(_e112));
    local_16 = 2139095040u;
    uint _e122 = local_16;
    uint _e125 = _naga_sqrtf(as_type<uint>(as_type<float>(_e122)));
    local_15 = static_cast<uint>(11);
    uint _e131 = local_15;
    out[_e131] = as_type<uint>(as_type<float>(_e125));
    uint _e136 = _naga_sqrtf(as_type<uint>(-(1.0)));
    local_17 = static_cast<uint>(12);
    uint _e142 = local_17;
    out[_e142] = as_type<uint>(as_type<float>(_e136));
    local_19 = 2139095041u;
    uint _e146 = local_19;
    uint _e149 = _naga_sqrtf(as_type<uint>(as_type<float>(_e146)));
    local_18 = static_cast<uint>(13);
    uint _e155 = local_18;
    out[_e155] = as_type<uint>(as_type<float>(_e149));
    value = 4.0;
    float _e159 = value;
    value = _e159 + static_cast<float>(1);
    float _e163 = root_1(_e159);
    local_20 = static_cast<uint>(14);
    uint _e168 = local_20;
    out[_e168] = as_type<uint>(_e163);
    float _e170 = value;
    local_21 = static_cast<uint>(15);
    uint _e175 = local_21;
    out[_e175] = as_type<uint>(_e170);
    int _e178 = sqrtf(true);
    local_22 = static_cast<uint>(16);
    uint _e183 = local_22;
    out[_e183] = static_cast<uint>(_e178);
    int _e186 = sqrtf(false);
    local_23 = static_cast<uint>(17);
    uint _e191 = local_23;
    out[_e191] = static_cast<uint>(_e186);
    float _e195 = sqrtf_1(2.0, 3.0);
    local_24 = static_cast<uint>(18);
    uint _e200 = local_24;
    out[_e200] = as_type<uint>(_e195);
    local_26 = 1065353217u;
    uint _e204 = local_26;
    uint _e207 = _naga_sqrtf(as_type<uint>(as_type<float>(_e204)));
    local_25 = static_cast<uint>(19);
    uint _e213 = local_25;
    out[_e213] = as_type<uint>(as_type<float>(_e207));
    local_28 = 1065353218u;
    uint _e217 = local_28;
    uint _e220 = _naga_sqrtf(as_type<uint>(as_type<float>(_e217)));
    local_27 = static_cast<uint>(20);
    uint _e226 = local_27;
    out[_e226] = as_type<uint>(as_type<float>(_e220));
    local_30 = 1065353215u;
    uint _e230 = local_30;
    uint _e233 = _naga_sqrtf(as_type<uint>(as_type<float>(_e230)));
    local_29 = static_cast<uint>(21);
    uint _e239 = local_29;
    out[_e239] = as_type<uint>(as_type<float>(_e233));
    float _e242 = root_3(4294967295u);
    local_31 = static_cast<uint>(22);
    uint _e247 = local_31;
    out[_e247] = as_type<uint>(_e242);
    float _e251 = root_2(naga_neg(4));
    local_32 = static_cast<uint>(23);
    uint _e256 = local_32;
    out[_e256] = as_type<uint>(_e251);
    float _e259 = root_1(16.0);
    local_33 = static_cast<uint>(24);
    uint _e264 = local_33;
    out[_e264] = as_type<uint>(_e259);
    uint _e268 = _naga_sqrtf(as_type<uint>(0.25));
    local_34 = static_cast<uint>(25);
    uint _e274 = local_34;
    out[_e274] = as_type<uint>(as_type<float>(_e268));
    local_36 = 2147483649u;
    uint _e278 = local_36;
    uint _e281 = _naga_sqrtf(as_type<uint>(as_type<float>(_e278)));
    local_35 = static_cast<uint>(26);
    uint _e287 = local_35;
    out[_e287] = as_type<uint>(as_type<float>(_e281));
    float _e290 = root_4(false);
    local_37 = static_cast<uint>(27);
    uint _e295 = local_37;
    out[_e295] = as_type<uint>(_e290);
    float _e298 = root_4(true);
    local_38 = static_cast<uint>(28);
    uint _e303 = local_38;
    out[_e303] = as_type<uint>(_e298);
    float _e306 = root_1(0.5);
    local_39 = static_cast<uint>(29);
    uint _e311 = local_39;
    out[_e311] = as_type<uint>(_e306);
}
