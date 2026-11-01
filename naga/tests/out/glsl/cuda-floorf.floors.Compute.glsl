#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_floorf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    bool _e7 = ((input_bits & 2147483648u) != 0u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value_1) {
    uint _e2 = _naga_floorf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
}

float floor_value_1(int value_2) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_2)));
    return uintBitsToFloat(_e3);
}

float floor_value_2(uint value_3) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_3)));
    return uintBitsToFloat(_e3);
}

float floor_value_3(bool value_4) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_4)));
    return uintBitsToFloat(_e3);
}

int floorf(bool value_5) {
    int local_42 = 0;
    if (value_5) {
        local_42 = 7;
    } else {
        local_42 = 9;
    }
    int _e6 = local_42;
    return _e6;
}

float floorf_1(float first, float second) {
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
    float value = 0.0;
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
    uint _e2 = _naga_floorf(floatBitsToUint(0.0));
    local = uint(0);
    uint _e8 = local;
    _group_0_binding_0_cs[_e8] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e14 = _naga_floorf(floatBitsToUint(-(0.0)));
    local_1 = uint(1);
    uint _e20 = local_1;
    _group_0_binding_0_cs[_e20] = floatBitsToUint(uintBitsToFloat(_e14));
    uint _e24 = _naga_floorf(floatBitsToUint(1.75));
    local_2 = uint(2);
    uint _e30 = local_2;
    _group_0_binding_0_cs[_e30] = floatBitsToUint(uintBitsToFloat(_e24));
    uint _e35 = _naga_floorf(floatBitsToUint(-(1.25)));
    local_3 = uint(3);
    uint _e41 = local_3;
    _group_0_binding_0_cs[_e41] = floatBitsToUint(uintBitsToFloat(_e35));
    float _e44 = floor_value_1(3);
    local_4 = uint(4);
    uint _e49 = local_4;
    _group_0_binding_0_cs[_e49] = floatBitsToUint(_e44);
    float _e52 = floor_value_2(5u);
    local_5 = uint(5);
    uint _e57 = local_5;
    _group_0_binding_0_cs[_e57] = floatBitsToUint(_e52);
    float _e60 = floor_value_3(true);
    local_6 = uint(6);
    uint _e65 = local_6;
    _group_0_binding_0_cs[_e65] = floatBitsToUint(_e60);
    float _e68 = floor_value_3(false);
    local_7 = uint(7);
    uint _e73 = local_7;
    _group_0_binding_0_cs[_e73] = floatBitsToUint(_e68);
    local_9 = 1u;
    uint _e77 = local_9;
    uint _e80 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e77)));
    local_8 = uint(8);
    uint _e86 = local_8;
    _group_0_binding_0_cs[_e86] = floatBitsToUint(uintBitsToFloat(_e80));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    uint _e93 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e90)));
    local_10 = uint(9);
    uint _e99 = local_10;
    _group_0_binding_0_cs[_e99] = floatBitsToUint(uintBitsToFloat(_e93));
    local_13 = 8388607u;
    uint _e103 = local_13;
    uint _e106 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e103)));
    local_12 = uint(10);
    uint _e112 = local_12;
    _group_0_binding_0_cs[_e112] = floatBitsToUint(uintBitsToFloat(_e106));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    uint _e119 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e116)));
    local_14 = uint(11);
    uint _e125 = local_14;
    _group_0_binding_0_cs[_e125] = floatBitsToUint(uintBitsToFloat(_e119));
    uint _e129 = _naga_floorf(floatBitsToUint(3.4028235e38));
    local_16 = uint(12);
    uint _e135 = local_16;
    _group_0_binding_0_cs[_e135] = floatBitsToUint(uintBitsToFloat(_e129));
    uint _e140 = _naga_floorf(floatBitsToUint(-(3.4028235e38)));
    local_17 = uint(13);
    uint _e146 = local_17;
    _group_0_binding_0_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e140));
    local_19 = 2139095039u;
    uint _e150 = local_19;
    uint _e153 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e150)));
    local_18 = uint(14);
    uint _e159 = local_18;
    _group_0_binding_0_cs[_e159] = floatBitsToUint(uintBitsToFloat(_e153));
    local_21 = 4286578687u;
    uint _e163 = local_21;
    uint _e166 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e163)));
    local_20 = uint(15);
    uint _e172 = local_20;
    _group_0_binding_0_cs[_e172] = floatBitsToUint(uintBitsToFloat(_e166));
    local_23 = 2139095040u;
    uint _e176 = local_23;
    uint _e179 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e176)));
    local_22 = uint(16);
    uint _e185 = local_22;
    _group_0_binding_0_cs[_e185] = floatBitsToUint(uintBitsToFloat(_e179));
    local_25 = 4286578688u;
    uint _e189 = local_25;
    uint _e192 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e189)));
    local_24 = uint(17);
    uint _e198 = local_24;
    _group_0_binding_0_cs[_e198] = floatBitsToUint(uintBitsToFloat(_e192));
    local_27 = 2143363909u;
    uint _e202 = local_27;
    uint _e205 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e202)));
    local_26 = uint(18);
    uint _e211 = local_26;
    _group_0_binding_0_cs[_e211] = floatBitsToUint(uintBitsToFloat(_e205));
    local_29 = 2139095041u;
    uint _e215 = local_29;
    uint _e218 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e215)));
    local_28 = uint(19);
    uint _e224 = local_28;
    _group_0_binding_0_cs[_e224] = floatBitsToUint(uintBitsToFloat(_e218));
    value = 2.75;
    float _e228 = value;
    value = (_e228 + float(1));
    float _e232 = floor_value(_e228);
    local_30 = uint(20);
    uint _e237 = local_30;
    _group_0_binding_0_cs[_e237] = floatBitsToUint(_e232);
    float _e239 = value;
    local_31 = uint(21);
    uint _e244 = local_31;
    _group_0_binding_0_cs[_e244] = floatBitsToUint(_e239);
    int _e247 = floorf(true);
    local_32 = uint(22);
    uint _e252 = local_32;
    _group_0_binding_0_cs[_e252] = uint(_e247);
    int _e255 = floorf(false);
    local_33 = uint(23);
    uint _e260 = local_33;
    _group_0_binding_0_cs[_e260] = uint(_e255);
    float _e264 = floorf_1(2.0, 3.0);
    local_34 = uint(24);
    uint _e269 = local_34;
    _group_0_binding_0_cs[_e269] = floatBitsToUint(_e264);
    local_36 = 1258291199u;
    uint _e273 = local_36;
    uint _e276 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e273)));
    local_35 = uint(25);
    uint _e282 = local_35;
    _group_0_binding_0_cs[_e282] = floatBitsToUint(uintBitsToFloat(_e276));
    local_38 = 3405774847u;
    uint _e286 = local_38;
    uint _e289 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e286)));
    local_37 = uint(26);
    uint _e295 = local_37;
    _group_0_binding_0_cs[_e295] = floatBitsToUint(uintBitsToFloat(_e289));
    float _e298 = floor_value_2(4294967295u);
    local_39 = uint(27);
    uint _e303 = local_39;
    _group_0_binding_0_cs[_e303] = floatBitsToUint(_e298);
    float _e309 = floor_value_1((-(2147483647) - 1));
    local_40 = uint(28);
    uint _e314 = local_40;
    _group_0_binding_0_cs[_e314] = floatBitsToUint(_e309);
    uint _e318 = _naga_floorf(floatBitsToUint(10000000000.0));
    local_41 = uint(29);
    uint _e324 = local_41;
    _group_0_binding_0_cs[_e324] = floatBitsToUint(uintBitsToFloat(_e318));
}

