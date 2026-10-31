#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


int signed_conversion(float first_1, float second_1) {
    return int((uint(bitfieldExtract(int(first_1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(second_1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
}

uint unsigned_conversion(float first_2, float second_2) {
    return (bitfieldExtract(uint(first_2), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(uint(second_2), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
}

int _mul24_(bool first_3, bool second_3) {
    int local_35 = 0;
    int local_36 = 0;
    if (first_3) {
        if (second_3) {
            local_35 = 71;
        } else {
            local_35 = 73;
        }
        int _e7 = local_35;
        local_36 = _e7;
    } else {
        local_36 = 79;
    }
    int _e12 = local_36;
    return _e12;
}

int _mul24_1(float first_4, float second_4) {
    return int(((first_4 * 10.0) + second_4));
}

uint _umul24_(int first_5, int second_5) {
    return uint(((first_5 + second_5) + 100));
}

int signed_pair(int first_6, int second_6) {
    return int((uint(bitfieldExtract(first_6, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(second_6, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
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
    int first = 0;
    uint second = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    int local_25 = 0;
    int values[2] = int[2](0, 0);
    uint local_26 = 0u;
    int Count = 0;
    int local_27 = 0;
    int scratch[2] = int[2](0, 0);
    uint local_28 = 0u;
    int counter = 0;
    uint local_29 = 0u;
    uint local_30 = 0u;
    int total = 0;
    int index = 0;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    local = uint(0);
    uint _e14 = local;
    _group_0_binding_0_cs[_e14] = uint(int((uint(bitfieldExtract(8388608, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(1, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_1 = uint(1);
    uint _e27 = local_1;
    _group_0_binding_0_cs[_e27] = (bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    local_2 = uint(2);
    uint _e43 = local_2;
    _group_0_binding_0_cs[_e43] = uint(int((uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_3 = uint(3);
    uint _e55 = local_3;
    _group_0_binding_0_cs[_e55] = (bitfieldExtract(16777216u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(13u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e60 = signed_conversion(3.75, -(2.75));
    local_4 = uint(4);
    uint _e65 = local_4;
    _group_0_binding_0_cs[_e65] = uint(_e60);
    int _e70 = signed_conversion(-(3.75), 2.75);
    local_5 = uint(5);
    uint _e75 = local_5;
    _group_0_binding_0_cs[_e75] = uint(_e70);
    uint _e79 = unsigned_conversion(3.75, 2.75);
    local_6 = uint(6);
    uint _e83 = local_6;
    _group_0_binding_0_cs[_e83] = _e79;
    uint _e87 = unsigned_conversion(16777215.0, 1.0);
    local_7 = uint(7);
    uint _e91 = local_7;
    _group_0_binding_0_cs[_e91] = _e87;
    int _e95 = _mul24_(true, true);
    local_8 = uint(8);
    uint _e100 = local_8;
    _group_0_binding_0_cs[_e100] = uint(_e95);
    int _e104 = _mul24_(false, true);
    local_9 = uint(9);
    uint _e109 = local_9;
    _group_0_binding_0_cs[_e109] = uint(_e104);
    local_10 = uint(10);
    uint _e126 = local_10;
    _group_0_binding_0_cs[_e126] = uint(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_11 = uint(11);
    uint _e143 = local_11;
    _group_0_binding_0_cs[_e143] = uint(int((uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e147 = _mul24_1(3.75, 2.0);
    local_12 = uint(12);
    uint _e152 = local_12;
    _group_0_binding_0_cs[_e152] = uint(_e147);
    uint _e156 = _umul24_(3, 4);
    local_13 = uint(13);
    uint _e160 = local_13;
    _group_0_binding_0_cs[_e160] = _e156;
    local_14 = uint(14);
    uint _e172 = local_14;
    _group_0_binding_0_cs[_e172] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    uint _e178 = _umul24_(int(true), int(true));
    local_15 = uint(15);
    uint _e182 = local_15;
    _group_0_binding_0_cs[_e182] = _e178;
    local_16 = uint(16);
    uint _e195 = local_16;
    _group_0_binding_0_cs[_e195] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(uint(4), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e200 = signed_pair(-(7), 3);
    local_17 = uint(17);
    uint _e205 = local_17;
    _group_0_binding_0_cs[_e205] = uint(_e200);
    local_18 = uint(18);
    uint _e230 = local_18;
    _group_0_binding_0_cs[_e230] = uint(int((uint(bitfieldExtract(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(5, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_19 = uint(19);
    uint _e248 = local_19;
    _group_0_binding_0_cs[_e248] = (bitfieldExtract((bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    first = -3;
    second = 5u;
    int _e254 = first;
    uint _e255 = second;
    local_20 = uint(20);
    uint _e269 = local_20;
    _group_0_binding_0_cs[_e269] = uint(int((uint(bitfieldExtract(_e254, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(_e255), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e271 = first;
    uint _e273 = second;
    local_21 = uint(21);
    uint _e282 = local_21;
    _group_0_binding_0_cs[_e282] = (bitfieldExtract(uint(_e271), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(_e273, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    local_22 = uint(22);
    uint _e298 = local_22;
    _group_0_binding_0_cs[_e298] = uint(int((uint(bitfieldExtract(25165824, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(16777217, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_23 = uint(23);
    uint _e310 = local_23;
    _group_0_binding_0_cs[_e310] = (bitfieldExtract(4286578688u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4278190081u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    if (true) {
        local_25 = int((uint(bitfieldExtract(-(3), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(7, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    } else {
        local_25 = int((uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    }
    int _e337 = local_25;
    local_24 = uint(24);
    uint _e342 = local_24;
    _group_0_binding_0_cs[_e342] = uint(_e337);
    values[0] = int((uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    values[1] = int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    int _e371 = values[0];
    int _e372 = values[1];
    local_26 = uint(25);
    uint _e378 = local_26;
    _group_0_binding_0_cs[_e378] = uint((_e371 + _e372));
    Count = 2;
    scratch = int[2](0, 0);
    int _e386 = Count;
    int _e387 = scratch[0];
    local_28 = uint(26);
    uint _e393 = local_28;
    _group_0_binding_0_cs[_e393] = uint((_e386 + _e387));
    counter = 2;
    int _e397 = counter;
    counter = (_e397 + 1);
    int _e400 = counter;
    counter = (_e400 + 1);
    local_29 = uint(27);
    uint _e415 = local_29;
    _group_0_binding_0_cs[_e415] = uint(int((uint(bitfieldExtract(_e397, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(_e400, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e417 = counter;
    local_30 = uint(28);
    uint _e422 = local_30;
    _group_0_binding_0_cs[_e422] = uint(_e417);
    total = 0;
    {
        index = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e445 = index;
                index = (_e445 + 1);
            }
            loop_init = false;
            int _e428 = index;
            if ((_e428 < 3)) {
            } else {
                break;
            }
            int _e431 = index;
            int _e443 = total;
            total = (_e443 + int((uint(bitfieldExtract((_e431 + 1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
        }
    }
    int _e448 = total;
    local_31 = uint(29);
    uint _e453 = local_31;
    _group_0_binding_0_cs[_e453] = uint(_e448);
    {
        local_32 = uint(30);
        uint _e461 = local_32;
        local_34 = _e461;
        uint _e463 = local_34;
        _group_0_binding_0_cs[_e463] = uint(int(9.75));
    }
    local_33 = uint(31);
    uint _e479 = local_33;
    _group_0_binding_0_cs[_e479] = uint(int((uint(bitfieldExtract(16777215, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
}

