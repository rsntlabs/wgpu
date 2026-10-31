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
    int local_70 = 0;
    if (value_5) {
        local_70 = 7;
    } else {
        local_70 = 9;
    }
    int _e6 = local_70;
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
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint _e2 = _naga_sqrtf(floatBitsToUint(0.0));
    local = uint(0);
    uint _e9 = local;
    local_40 = uint(_e9);
    uint _e12 = local_40;
    _group_0_binding_0_cs[_e12] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e17 = _naga_sqrtf(floatBitsToUint(-(0.0)));
    local_1 = uint(1);
    uint _e23 = local_1;
    local_41 = uint(_e23);
    uint _e26 = local_41;
    _group_0_binding_0_cs[_e26] = floatBitsToUint(uintBitsToFloat(_e17));
    uint _e30 = _naga_sqrtf(floatBitsToUint(1.0));
    local_2 = uint(2);
    uint _e36 = local_2;
    local_42 = uint(_e36);
    uint _e39 = local_42;
    _group_0_binding_0_cs[_e39] = floatBitsToUint(uintBitsToFloat(_e30));
    float _e42 = root_2(4);
    local_3 = uint(3);
    uint _e47 = local_3;
    local_43 = uint(_e47);
    uint _e50 = local_43;
    _group_0_binding_0_cs[_e50] = floatBitsToUint(_e42);
    float _e53 = root_3(9u);
    local_4 = uint(4);
    uint _e58 = local_4;
    local_44 = uint(_e58);
    uint _e61 = local_44;
    _group_0_binding_0_cs[_e61] = floatBitsToUint(_e53);
    uint _e65 = _naga_sqrtf(floatBitsToUint(6.25));
    local_5 = uint(5);
    uint _e71 = local_5;
    local_45 = uint(_e71);
    uint _e74 = local_45;
    _group_0_binding_0_cs[_e74] = floatBitsToUint(uintBitsToFloat(_e65));
    uint _e78 = _naga_sqrtf(floatBitsToUint(2.0));
    local_6 = uint(6);
    uint _e84 = local_6;
    local_46 = uint(_e84);
    uint _e87 = local_46;
    _group_0_binding_0_cs[_e87] = floatBitsToUint(uintBitsToFloat(_e78));
    local_8 = 1u;
    uint _e91 = local_8;
    uint _e94 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e91)));
    local_7 = uint(7);
    uint _e100 = local_7;
    local_47 = uint(_e100);
    uint _e103 = local_47;
    _group_0_binding_0_cs[_e103] = floatBitsToUint(uintBitsToFloat(_e94));
    local_10 = 8388607u;
    uint _e107 = local_10;
    uint _e110 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e107)));
    local_9 = uint(8);
    uint _e116 = local_9;
    local_48 = uint(_e116);
    uint _e119 = local_48;
    _group_0_binding_0_cs[_e119] = floatBitsToUint(uintBitsToFloat(_e110));
    local_12 = 8388608u;
    uint _e123 = local_12;
    uint _e126 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e123)));
    local_11 = uint(9);
    uint _e132 = local_11;
    local_49 = uint(_e132);
    uint _e135 = local_49;
    _group_0_binding_0_cs[_e135] = floatBitsToUint(uintBitsToFloat(_e126));
    local_14 = 2139095039u;
    uint _e139 = local_14;
    uint _e142 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e139)));
    local_13 = uint(10);
    uint _e148 = local_13;
    local_50 = uint(_e148);
    uint _e151 = local_50;
    _group_0_binding_0_cs[_e151] = floatBitsToUint(uintBitsToFloat(_e142));
    local_16 = 2139095040u;
    uint _e155 = local_16;
    uint _e158 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e155)));
    local_15 = uint(11);
    uint _e164 = local_15;
    local_51 = uint(_e164);
    uint _e167 = local_51;
    _group_0_binding_0_cs[_e167] = floatBitsToUint(uintBitsToFloat(_e158));
    uint _e172 = _naga_sqrtf(floatBitsToUint(-(1.0)));
    local_17 = uint(12);
    uint _e178 = local_17;
    local_52 = uint(_e178);
    uint _e181 = local_52;
    _group_0_binding_0_cs[_e181] = floatBitsToUint(uintBitsToFloat(_e172));
    local_19 = 2139095041u;
    uint _e185 = local_19;
    uint _e188 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e185)));
    local_18 = uint(13);
    uint _e194 = local_18;
    local_53 = uint(_e194);
    uint _e197 = local_53;
    _group_0_binding_0_cs[_e197] = floatBitsToUint(uintBitsToFloat(_e188));
    value = 4.0;
    float _e201 = value;
    value = (_e201 + float(1));
    float _e205 = root_1(_e201);
    local_20 = uint(14);
    uint _e210 = local_20;
    local_54 = uint(_e210);
    uint _e213 = local_54;
    _group_0_binding_0_cs[_e213] = floatBitsToUint(_e205);
    float _e215 = value;
    local_21 = uint(15);
    uint _e220 = local_21;
    local_55 = uint(_e220);
    uint _e223 = local_55;
    _group_0_binding_0_cs[_e223] = floatBitsToUint(_e215);
    int _e226 = sqrtf(true);
    local_22 = uint(16);
    uint _e231 = local_22;
    local_56 = uint(_e231);
    uint _e234 = local_56;
    _group_0_binding_0_cs[_e234] = uint(_e226);
    int _e237 = sqrtf(false);
    local_23 = uint(17);
    uint _e242 = local_23;
    local_57 = uint(_e242);
    uint _e245 = local_57;
    _group_0_binding_0_cs[_e245] = uint(_e237);
    float _e249 = sqrtf_1(2.0, 3.0);
    local_24 = uint(18);
    uint _e254 = local_24;
    local_58 = uint(_e254);
    uint _e257 = local_58;
    _group_0_binding_0_cs[_e257] = floatBitsToUint(_e249);
    local_26 = 1065353217u;
    uint _e261 = local_26;
    uint _e264 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e261)));
    local_25 = uint(19);
    uint _e270 = local_25;
    local_59 = uint(_e270);
    uint _e273 = local_59;
    _group_0_binding_0_cs[_e273] = floatBitsToUint(uintBitsToFloat(_e264));
    local_28 = 1065353218u;
    uint _e277 = local_28;
    uint _e280 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e277)));
    local_27 = uint(20);
    uint _e286 = local_27;
    local_60 = uint(_e286);
    uint _e289 = local_60;
    _group_0_binding_0_cs[_e289] = floatBitsToUint(uintBitsToFloat(_e280));
    local_30 = 1065353215u;
    uint _e293 = local_30;
    uint _e296 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e293)));
    local_29 = uint(21);
    uint _e302 = local_29;
    local_61 = uint(_e302);
    uint _e305 = local_61;
    _group_0_binding_0_cs[_e305] = floatBitsToUint(uintBitsToFloat(_e296));
    float _e308 = root_3(4294967295u);
    local_31 = uint(22);
    uint _e313 = local_31;
    local_62 = uint(_e313);
    uint _e316 = local_62;
    _group_0_binding_0_cs[_e316] = floatBitsToUint(_e308);
    float _e320 = root_2(-(4));
    local_32 = uint(23);
    uint _e325 = local_32;
    local_63 = uint(_e325);
    uint _e328 = local_63;
    _group_0_binding_0_cs[_e328] = floatBitsToUint(_e320);
    float _e331 = root_1(16.0);
    local_33 = uint(24);
    uint _e336 = local_33;
    local_64 = uint(_e336);
    uint _e339 = local_64;
    _group_0_binding_0_cs[_e339] = floatBitsToUint(_e331);
    uint _e343 = _naga_sqrtf(floatBitsToUint(0.25));
    local_34 = uint(25);
    uint _e349 = local_34;
    local_65 = uint(_e349);
    uint _e352 = local_65;
    _group_0_binding_0_cs[_e352] = floatBitsToUint(uintBitsToFloat(_e343));
    local_36 = 2147483649u;
    uint _e356 = local_36;
    uint _e359 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e356)));
    local_35 = uint(26);
    uint _e365 = local_35;
    local_66 = uint(_e365);
    uint _e368 = local_66;
    _group_0_binding_0_cs[_e368] = floatBitsToUint(uintBitsToFloat(_e359));
    float _e371 = root_4(false);
    local_37 = uint(27);
    uint _e376 = local_37;
    local_67 = uint(_e376);
    uint _e379 = local_67;
    _group_0_binding_0_cs[_e379] = floatBitsToUint(_e371);
    float _e382 = root_4(true);
    local_38 = uint(28);
    uint _e387 = local_38;
    local_68 = uint(_e387);
    uint _e390 = local_68;
    _group_0_binding_0_cs[_e390] = floatBitsToUint(_e382);
    float _e393 = root_1(0.5);
    local_39 = uint(29);
    uint _e398 = local_39;
    local_69 = uint(_e398);
    uint _e401 = local_69;
    _group_0_binding_0_cs[_e401] = floatBitsToUint(_e393);
}

