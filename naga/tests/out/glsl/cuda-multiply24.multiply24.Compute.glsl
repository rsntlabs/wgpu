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
    int local_66 = 0;
    int local_67 = 0;
    if (first_3) {
        if (second_3) {
            local_66 = 71;
        } else {
            local_66 = 73;
        }
        int _e7 = local_66;
        local_67 = _e7;
    } else {
        local_67 = 79;
    }
    int _e12 = local_67;
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
    local = uint(0);
    uint _e15 = local;
    local_34 = uint(_e15);
    uint _e18 = local_34;
    _group_0_binding_0_cs[_e18] = uint(int((uint(bitfieldExtract(8388608, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(1, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_1 = uint(1);
    uint _e30 = local_1;
    local_35 = uint(_e30);
    uint _e33 = local_35;
    _group_0_binding_0_cs[_e33] = (bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    local_2 = uint(2);
    uint _e49 = local_2;
    local_36 = uint(_e49);
    uint _e52 = local_36;
    _group_0_binding_0_cs[_e52] = uint(int((uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_3 = uint(3);
    uint _e64 = local_3;
    local_37 = uint(_e64);
    uint _e67 = local_37;
    _group_0_binding_0_cs[_e67] = (bitfieldExtract(16777216u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(13u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e72 = signed_conversion(3.75, -(2.75));
    local_4 = uint(4);
    uint _e77 = local_4;
    local_38 = uint(_e77);
    uint _e80 = local_38;
    _group_0_binding_0_cs[_e80] = uint(_e72);
    int _e85 = signed_conversion(-(3.75), 2.75);
    local_5 = uint(5);
    uint _e90 = local_5;
    local_39 = uint(_e90);
    uint _e93 = local_39;
    _group_0_binding_0_cs[_e93] = uint(_e85);
    uint _e97 = unsigned_conversion(3.75, 2.75);
    local_6 = uint(6);
    uint _e101 = local_6;
    local_40 = uint(_e101);
    uint _e104 = local_40;
    _group_0_binding_0_cs[_e104] = _e97;
    uint _e108 = unsigned_conversion(16777215.0, 1.0);
    local_7 = uint(7);
    uint _e112 = local_7;
    local_41 = uint(_e112);
    uint _e115 = local_41;
    _group_0_binding_0_cs[_e115] = _e108;
    int _e119 = _mul24_(true, true);
    local_8 = uint(8);
    uint _e124 = local_8;
    local_42 = uint(_e124);
    uint _e127 = local_42;
    _group_0_binding_0_cs[_e127] = uint(_e119);
    int _e131 = _mul24_(false, true);
    local_9 = uint(9);
    uint _e136 = local_9;
    local_43 = uint(_e136);
    uint _e139 = local_43;
    _group_0_binding_0_cs[_e139] = uint(_e131);
    local_10 = uint(10);
    uint _e156 = local_10;
    local_44 = uint(_e156);
    uint _e159 = local_44;
    _group_0_binding_0_cs[_e159] = uint(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_11 = uint(11);
    uint _e176 = local_11;
    local_45 = uint(_e176);
    uint _e179 = local_45;
    _group_0_binding_0_cs[_e179] = uint(int((uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e183 = _mul24_1(3.75, 2.0);
    local_12 = uint(12);
    uint _e188 = local_12;
    local_46 = uint(_e188);
    uint _e191 = local_46;
    _group_0_binding_0_cs[_e191] = uint(_e183);
    uint _e195 = _umul24_(3, 4);
    local_13 = uint(13);
    uint _e199 = local_13;
    local_47 = uint(_e199);
    uint _e202 = local_47;
    _group_0_binding_0_cs[_e202] = _e195;
    local_14 = uint(14);
    uint _e214 = local_14;
    local_48 = uint(_e214);
    uint _e217 = local_48;
    _group_0_binding_0_cs[_e217] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    uint _e223 = _umul24_(int(true), int(true));
    local_15 = uint(15);
    uint _e227 = local_15;
    local_49 = uint(_e227);
    uint _e230 = local_49;
    _group_0_binding_0_cs[_e230] = _e223;
    local_16 = uint(16);
    uint _e243 = local_16;
    local_50 = uint(_e243);
    uint _e246 = local_50;
    _group_0_binding_0_cs[_e246] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(uint(4), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e251 = signed_pair(-(7), 3);
    local_17 = uint(17);
    uint _e256 = local_17;
    local_51 = uint(_e256);
    uint _e259 = local_51;
    _group_0_binding_0_cs[_e259] = uint(_e251);
    local_18 = uint(18);
    uint _e284 = local_18;
    local_52 = uint(_e284);
    uint _e287 = local_52;
    _group_0_binding_0_cs[_e287] = uint(int((uint(bitfieldExtract(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(5, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_19 = uint(19);
    uint _e305 = local_19;
    local_53 = uint(_e305);
    uint _e308 = local_53;
    _group_0_binding_0_cs[_e308] = (bitfieldExtract((bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    first = -3;
    second = 5u;
    int _e314 = first;
    uint _e315 = second;
    local_20 = uint(20);
    uint _e329 = local_20;
    local_54 = uint(_e329);
    uint _e332 = local_54;
    _group_0_binding_0_cs[_e332] = uint(int((uint(bitfieldExtract(_e314, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(_e315), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e334 = first;
    uint _e336 = second;
    local_21 = uint(21);
    uint _e345 = local_21;
    local_55 = uint(_e345);
    uint _e348 = local_55;
    _group_0_binding_0_cs[_e348] = (bitfieldExtract(uint(_e334), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(_e336, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    local_22 = uint(22);
    uint _e364 = local_22;
    local_56 = uint(_e364);
    uint _e367 = local_56;
    _group_0_binding_0_cs[_e367] = uint(int((uint(bitfieldExtract(25165824, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(16777217, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    local_23 = uint(23);
    uint _e379 = local_23;
    local_57 = uint(_e379);
    uint _e382 = local_57;
    _group_0_binding_0_cs[_e382] = (bitfieldExtract(4286578688u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4278190081u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    if (true) {
        local_25 = int((uint(bitfieldExtract(-(3), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(7, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    } else {
        local_25 = int((uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    }
    int _e409 = local_25;
    local_24 = uint(24);
    uint _e414 = local_24;
    local_58 = uint(_e414);
    uint _e417 = local_58;
    _group_0_binding_0_cs[_e417] = uint(_e409);
    values[0] = int((uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    values[1] = int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    int _e446 = values[0];
    int _e447 = values[1];
    local_26 = uint(25);
    uint _e453 = local_26;
    local_59 = uint(_e453);
    uint _e456 = local_59;
    _group_0_binding_0_cs[_e456] = uint((_e446 + _e447));
    Count = 2;
    scratch = int[2](0, 0);
    int _e464 = Count;
    int _e465 = scratch[0];
    local_28 = uint(26);
    uint _e471 = local_28;
    local_60 = uint(_e471);
    uint _e474 = local_60;
    _group_0_binding_0_cs[_e474] = uint((_e464 + _e465));
    counter = 2;
    int _e478 = counter;
    counter = (_e478 + 1);
    int _e481 = counter;
    counter = (_e481 + 1);
    local_29 = uint(27);
    uint _e496 = local_29;
    local_61 = uint(_e496);
    uint _e499 = local_61;
    _group_0_binding_0_cs[_e499] = uint(int((uint(bitfieldExtract(_e478, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(_e481, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e501 = counter;
    local_30 = uint(28);
    uint _e506 = local_30;
    local_62 = uint(_e506);
    uint _e509 = local_62;
    _group_0_binding_0_cs[_e509] = uint(_e501);
    total = 0;
    {
        index = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e532 = index;
                index = (_e532 + 1);
            }
            loop_init = false;
            int _e515 = index;
            if ((_e515 < 3)) {
            } else {
                break;
            }
            int _e518 = index;
            int _e530 = total;
            total = (_e530 + int((uint(bitfieldExtract((_e518 + 1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
        }
    }
    int _e535 = total;
    local_31 = uint(29);
    uint _e540 = local_31;
    local_63 = uint(_e540);
    uint _e543 = local_63;
    _group_0_binding_0_cs[_e543] = uint(_e535);
    {
        local_32 = uint(30);
        uint _e551 = local_32;
        local_64 = uint(_e551);
        uint _e554 = local_64;
        _group_0_binding_0_cs[_e554] = uint(int(9.75));
    }
    local_33 = uint(31);
    uint _e570 = local_33;
    local_65 = uint(_e570);
    uint _e573 = local_65;
    _group_0_binding_0_cs[_e573] = uint(int((uint(bitfieldExtract(16777215, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
}

