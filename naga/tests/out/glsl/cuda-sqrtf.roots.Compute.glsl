#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_sqrtf(uint input_bits) {
    uint significand = 0u;
    uint adjusted_exponent = 0u;
    uint upper_word = 0u;
    uint lower_word = 0u;
    uint root = 0u;
    uint remainder = 0u;
    uint iteration = 0u;
    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

float root_1(float value_1) {
    uint _e2 = _naga_sqrtf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
}

float root_2(int value_2) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_2)));
    return uintBitsToFloat(_e3);
}

float root_3(uint value_3) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_3)));
    return uintBitsToFloat(_e3);
}

float root_4(bool value_4) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_4)));
    return uintBitsToFloat(_e3);
}

int sqrtf(bool value_5) {
    int local_40 = 0;
    if (value_5) {
        local_40 = 7;
    } else {
        local_40 = 9;
    }
    int _e6 = local_40;
    return _e6;
}

float sqrtf_1(float first, float second) {
    return (first + second);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    float value = 0.0;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint _e2 = _naga_sqrtf(floatBitsToUint(0.0));
    local = uint(0);
    uint _e8 = local;
    _group_0_binding_0_cs[_e8] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e14 = _naga_sqrtf(floatBitsToUint(-(0.0)));
    local_1 = uint(1);
    uint _e20 = local_1;
    _group_0_binding_0_cs[_e20] = floatBitsToUint(uintBitsToFloat(_e14));
    uint _e24 = _naga_sqrtf(floatBitsToUint(1.0));
    local_2 = uint(2);
    uint _e30 = local_2;
    _group_0_binding_0_cs[_e30] = floatBitsToUint(uintBitsToFloat(_e24));
    float _e33 = root_2(4);
    local_3 = uint(3);
    uint _e38 = local_3;
    _group_0_binding_0_cs[_e38] = floatBitsToUint(_e33);
    float _e41 = root_3(9u);
    local_4 = uint(4);
    uint _e46 = local_4;
    _group_0_binding_0_cs[_e46] = floatBitsToUint(_e41);
    uint _e50 = _naga_sqrtf(floatBitsToUint(6.25));
    local_5 = uint(5);
    uint _e56 = local_5;
    _group_0_binding_0_cs[_e56] = floatBitsToUint(uintBitsToFloat(_e50));
    uint _e60 = _naga_sqrtf(floatBitsToUint(2.0));
    local_6 = uint(6);
    uint _e66 = local_6;
    _group_0_binding_0_cs[_e66] = floatBitsToUint(uintBitsToFloat(_e60));
    local_8 = 1u;
    uint _e70 = local_8;
    uint _e73 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e70)));
    local_7 = uint(7);
    uint _e79 = local_7;
    _group_0_binding_0_cs[_e79] = floatBitsToUint(uintBitsToFloat(_e73));
    local_10 = 8388607u;
    uint _e83 = local_10;
    uint _e86 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e83)));
    local_9 = uint(8);
    uint _e92 = local_9;
    _group_0_binding_0_cs[_e92] = floatBitsToUint(uintBitsToFloat(_e86));
    local_12 = 8388608u;
    uint _e96 = local_12;
    uint _e99 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e96)));
    local_11 = uint(9);
    uint _e105 = local_11;
    _group_0_binding_0_cs[_e105] = floatBitsToUint(uintBitsToFloat(_e99));
    local_14 = 2139095039u;
    uint _e109 = local_14;
    uint _e112 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e109)));
    local_13 = uint(10);
    uint _e118 = local_13;
    _group_0_binding_0_cs[_e118] = floatBitsToUint(uintBitsToFloat(_e112));
    local_16 = 2139095040u;
    uint _e122 = local_16;
    uint _e125 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e122)));
    local_15 = uint(11);
    uint _e131 = local_15;
    _group_0_binding_0_cs[_e131] = floatBitsToUint(uintBitsToFloat(_e125));
    uint _e136 = _naga_sqrtf(floatBitsToUint(-(1.0)));
    local_17 = uint(12);
    uint _e142 = local_17;
    _group_0_binding_0_cs[_e142] = floatBitsToUint(uintBitsToFloat(_e136));
    local_19 = 2139095041u;
    uint _e146 = local_19;
    uint _e149 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e146)));
    local_18 = uint(13);
    uint _e155 = local_18;
    _group_0_binding_0_cs[_e155] = floatBitsToUint(uintBitsToFloat(_e149));
    value = 4.0;
    float _e159 = value;
    value = (_e159 + float(1));
    float _e163 = root_1(_e159);
    local_20 = uint(14);
    uint _e168 = local_20;
    _group_0_binding_0_cs[_e168] = floatBitsToUint(_e163);
    float _e170 = value;
    local_21 = uint(15);
    uint _e175 = local_21;
    _group_0_binding_0_cs[_e175] = floatBitsToUint(_e170);
    int _e178 = sqrtf(true);
    local_22 = uint(16);
    uint _e183 = local_22;
    _group_0_binding_0_cs[_e183] = uint(_e178);
    int _e186 = sqrtf(false);
    local_23 = uint(17);
    uint _e191 = local_23;
    _group_0_binding_0_cs[_e191] = uint(_e186);
    float _e195 = sqrtf_1(2.0, 3.0);
    local_24 = uint(18);
    uint _e200 = local_24;
    _group_0_binding_0_cs[_e200] = floatBitsToUint(_e195);
    local_26 = 1065353217u;
    uint _e204 = local_26;
    uint _e207 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e204)));
    local_25 = uint(19);
    uint _e213 = local_25;
    _group_0_binding_0_cs[_e213] = floatBitsToUint(uintBitsToFloat(_e207));
    local_28 = 1065353218u;
    uint _e217 = local_28;
    uint _e220 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e217)));
    local_27 = uint(20);
    uint _e226 = local_27;
    _group_0_binding_0_cs[_e226] = floatBitsToUint(uintBitsToFloat(_e220));
    local_30 = 1065353215u;
    uint _e230 = local_30;
    uint _e233 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e230)));
    local_29 = uint(21);
    uint _e239 = local_29;
    _group_0_binding_0_cs[_e239] = floatBitsToUint(uintBitsToFloat(_e233));
    float _e242 = root_3(4294967295u);
    local_31 = uint(22);
    uint _e247 = local_31;
    _group_0_binding_0_cs[_e247] = floatBitsToUint(_e242);
    float _e251 = root_2(-(4));
    local_32 = uint(23);
    uint _e256 = local_32;
    _group_0_binding_0_cs[_e256] = floatBitsToUint(_e251);
    float _e259 = root_1(16.0);
    local_33 = uint(24);
    uint _e264 = local_33;
    _group_0_binding_0_cs[_e264] = floatBitsToUint(_e259);
    uint _e268 = _naga_sqrtf(floatBitsToUint(0.25));
    local_34 = uint(25);
    uint _e274 = local_34;
    _group_0_binding_0_cs[_e274] = floatBitsToUint(uintBitsToFloat(_e268));
    local_36 = 2147483649u;
    uint _e278 = local_36;
    uint _e281 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e278)));
    local_35 = uint(26);
    uint _e287 = local_35;
    _group_0_binding_0_cs[_e287] = floatBitsToUint(uintBitsToFloat(_e281));
    float _e290 = root_4(false);
    local_37 = uint(27);
    uint _e295 = local_37;
    _group_0_binding_0_cs[_e295] = floatBitsToUint(_e290);
    float _e298 = root_4(true);
    local_38 = uint(28);
    uint _e303 = local_38;
    _group_0_binding_0_cs[_e303] = floatBitsToUint(_e298);
    float _e306 = root_1(0.5);
    local_39 = uint(29);
    uint _e311 = local_39;
    _group_0_binding_0_cs[_e311] = floatBitsToUint(_e306);
}

