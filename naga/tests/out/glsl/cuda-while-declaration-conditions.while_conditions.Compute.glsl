#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_2_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint input_[2] = uint[2](0u, 0u);
    uint output_[2] = uint[2](0u, 0u);
    int cursor = 0;
    int total = 0;
    int entry = 0;
    uint local[2] = uint[2](0u, 0u);
    int local_1 = 0;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    int inferred_cursor = 0;
    int inferred_total = 0;
    uint local_5[2] = uint[2](0u, 0u);
    int local_6 = 0;
    int entry_1 = 0;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    int early_cursor = 0;
    int first = 0;
    uint local_11[2] = uint[2](0u, 0u);
    int local_12 = 0;
    int entry_2 = 0;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14 = 0u;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    int repeat = 0;
    int fixed_ = 0;
    uint local_17[2] = uint[2](0u, 0u);
    uint local_18 = 0u;
    int entry_3 = 0;
    int nested = 0;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    int entry_4 = 0;
    int entry_5 = 0;
    uint local_21[2] = uint[2](0u, 0u);
    uint local_22 = 0u;
    uint local_23[2] = uint[2](0u, 0u);
    uint local_24 = 0u;
    int false_count = 0;
    int stopped = 0;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    float fraction = 0.0;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29[2] = uint[2](0u, 0u);
    uint local_30 = 0u;
    uint input_1[2] = uint[2](0u, 0u);
    uint offset = 0u;
    uint local_31[2] = uint[2](0u, 0u);
    uint local_32 = 0u;
    int local_33 = 0;
    int local_34 = 0;
    int local_35 = 0;
    uint input_2[2] = uint[2](0u, 0u);
    uint offset_1 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    int local_38 = 0;
    int local_39 = 0;
    int local_40 = 0;
    uint input_3[2] = uint[2](0u, 0u);
    uint offset_2 = 0u;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    int local_43 = 0;
    int local_44 = 0;
    int local_45 = 0;
    int local_46 = 0;
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    uint local_49 = 0u;
    int local_50 = 0;
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    uint local_59 = 0u;
    int local_60 = 0;
    uint local_61[2] = uint[2](0u, 0u);
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64[2] = uint[2](0u, 0u);
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67[2] = uint[2](0u, 0u);
    uint local_68 = 0u;
    uint local_69 = 0u;
    int local_70 = 0;
    uint local_71[2] = uint[2](0u, 0u);
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74[2] = uint[2](0u, 0u);
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80[2] = uint[2](0u, 0u);
    uint local_81 = 0u;
    uint local_82 = 0u;
    int local_83 = 0;
    uint local_84[2] = uint[2](0u, 0u);
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87[2] = uint[2](0u, 0u);
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90[2] = uint[2](0u, 0u);
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93[2] = uint[2](0u, 0u);
    uint local_94 = 0u;
    uint local_95 = 0u;
    uint local_96[2] = uint[2](0u, 0u);
    uint local_97 = 0u;
    uint local_98 = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 2u;
    input_[1] = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 3u;
    output_[1] = 0u;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint offset_3 = (lane * 4u);
    uint base = (4u + (lane * 12u));
    cursor = 0;
    total = 0;
    while(true) {
        uint _e32[2] = input_;
        local = _e32;
        offset = 0u;
        local_32 = 0u;
        local_33 = 0;
        uint _e40[2] = local;
        input_1 = _e40;
        offset = offset_3;
        uint _e44[2] = input_1;
        local_31 = _e44;
        int _e46 = cursor;
        local_34 = _e46;
        int _e48 = local_34;
        cursor = (_e48 + 1);
        uint _e52 = offset;
        local_32 = uint((_e52 + uint(_e48)));
        uint _e56[2] = local_31;
        local_47 = _e56;
        uint _e58 = local_32;
        uint _e60 = local_47[1];
        local_47[1] = (_e60 + _e58);
        uint _e64 = local_47[0];
        local_48 = uint(_e64);
        uint _e68 = local_47[1];
        local_49 = uint(_e68);
        uint _e71 = local_49;
        int _e74 = _group_0_binding_0_cs[_e71];
        local_50 = _e74;
        int _e76 = local_50;
        local_35 = _e76;
        int _e78 = local_35;
        local_33 = _e78;
        int _e80 = local_33;
        local_1 = _e80;
        int _e82 = local_1;
        entry = _e82;
        int _e84 = entry;
        if ((_e84 != 0)) {
        } else {
            break;
        }
        {
            int _e87 = entry;
            if ((_e87 == 1)) {
                entry = 99;
                continue;
            }
            int _e91 = entry;
            int _e92 = total;
            total = (_e92 + _e91);
        }
    }
    int _e94 = total;
    uint _e97[2] = output_;
    local_2 = _e97;
    uint _e99[2] = local_2;
    local_51 = _e99;
    uint _e102 = local_51[1];
    local_51[1] = (_e102 + base);
    uint _e106 = local_51[0];
    local_52 = uint(_e106);
    uint _e110 = local_51[1];
    local_53 = uint(_e110);
    uint _e113 = local_53;
    _group_0_binding_1_cs[_e113] = uint(_e94);
    int _e116 = cursor;
    uint _e118[2] = output_;
    local_3 = _e118;
    local_4 = uint((base + 1u));
    uint _e124[2] = local_3;
    local_54 = _e124;
    uint _e126 = local_4;
    uint _e128 = local_54[1];
    local_54[1] = (_e128 + _e126);
    uint _e132 = local_54[0];
    local_55 = uint(_e132);
    uint _e136 = local_54[1];
    local_56 = uint(_e136);
    uint _e139 = local_56;
    _group_0_binding_1_cs[_e139] = uint(_e116);
    inferred_cursor = 0;
    inferred_total = 0;
    while(true) {
        uint _e146[2] = input_;
        local_5 = _e146;
        offset_1 = 0u;
        local_37 = 0u;
        local_38 = 0;
        uint _e154[2] = local_5;
        input_2 = _e154;
        offset_1 = offset_3;
        uint _e158[2] = input_2;
        local_36 = _e158;
        int _e160 = inferred_cursor;
        local_39 = _e160;
        int _e162 = local_39;
        inferred_cursor = (_e162 + 1);
        uint _e166 = offset_1;
        local_37 = uint((_e166 + uint(_e162)));
        uint _e170[2] = local_36;
        local_57 = _e170;
        uint _e172 = local_37;
        uint _e174 = local_57[1];
        local_57[1] = (_e174 + _e172);
        uint _e178 = local_57[0];
        local_58 = uint(_e178);
        uint _e182 = local_57[1];
        local_59 = uint(_e182);
        uint _e185 = local_59;
        int _e188 = _group_0_binding_0_cs[_e185];
        local_60 = _e188;
        int _e190 = local_60;
        local_40 = _e190;
        int _e192 = local_40;
        local_38 = _e192;
        int _e194 = local_38;
        local_6 = _e194;
        int _e196 = local_6;
        entry_1 = _e196;
        int _e198 = entry_1;
        if ((_e198 != 0)) {
        } else {
            break;
        }
        {
            int _e201 = entry_1;
            switch(_e201) {
                case 1: {
                    entry_1 = 77;
                    continue;
                }
                default: {
                    int _e203 = entry_1;
                    int _e204 = inferred_total;
                    inferred_total = (_e204 + _e203);
                    break;
                }
            }
        }
    }
    int _e206 = inferred_total;
    uint _e208[2] = output_;
    local_7 = _e208;
    local_8 = uint((base + 2u));
    uint _e214[2] = local_7;
    local_61 = _e214;
    uint _e216 = local_8;
    uint _e218 = local_61[1];
    local_61[1] = (_e218 + _e216);
    uint _e222 = local_61[0];
    local_62 = uint(_e222);
    uint _e226 = local_61[1];
    local_63 = uint(_e226);
    uint _e229 = local_63;
    _group_0_binding_1_cs[_e229] = uint(_e206);
    int _e231 = inferred_cursor;
    uint _e233[2] = output_;
    local_9 = _e233;
    local_10 = uint((base + 3u));
    uint _e239[2] = local_9;
    local_64 = _e239;
    uint _e241 = local_10;
    uint _e243 = local_64[1];
    local_64[1] = (_e243 + _e241);
    uint _e247 = local_64[0];
    local_65 = uint(_e247);
    uint _e251 = local_64[1];
    local_66 = uint(_e251);
    uint _e254 = local_66;
    _group_0_binding_1_cs[_e254] = uint(_e231);
    early_cursor = 0;
    first = 0;
    while(true) {
        uint _e261[2] = input_;
        local_11 = _e261;
        offset_2 = 0u;
        local_42 = 0u;
        local_43 = 0;
        uint _e269[2] = local_11;
        input_3 = _e269;
        offset_2 = offset_3;
        uint _e273[2] = input_3;
        local_41 = _e273;
        int _e275 = early_cursor;
        local_44 = _e275;
        int _e277 = local_44;
        early_cursor = (_e277 + 1);
        uint _e281 = offset_2;
        local_42 = uint((_e281 + uint(_e277)));
        uint _e285[2] = local_41;
        local_67 = _e285;
        uint _e287 = local_42;
        uint _e289 = local_67[1];
        local_67[1] = (_e289 + _e287);
        uint _e293 = local_67[0];
        local_68 = uint(_e293);
        uint _e297 = local_67[1];
        local_69 = uint(_e297);
        uint _e300 = local_69;
        int _e303 = _group_0_binding_0_cs[_e300];
        local_70 = _e303;
        int _e305 = local_70;
        local_45 = _e305;
        int _e307 = local_45;
        local_43 = _e307;
        int _e309 = local_43;
        local_12 = _e309;
        int _e311 = local_12;
        entry_2 = _e311;
        int _e313 = entry_2;
        if ((_e313 != 0)) {
        } else {
            break;
        }
        {
            int _e316 = entry_2;
            first = _e316;
            break;
        }
    }
    int _e317 = first;
    uint _e319[2] = output_;
    local_13 = _e319;
    local_14 = uint((base + 4u));
    uint _e325[2] = local_13;
    local_71 = _e325;
    uint _e327 = local_14;
    uint _e329 = local_71[1];
    local_71[1] = (_e329 + _e327);
    uint _e333 = local_71[0];
    local_72 = uint(_e333);
    uint _e337 = local_71[1];
    local_73 = uint(_e337);
    uint _e340 = local_73;
    _group_0_binding_1_cs[_e340] = uint(_e317);
    int _e342 = early_cursor;
    uint _e344[2] = output_;
    local_15 = _e344;
    local_16 = uint((base + 5u));
    uint _e350[2] = local_15;
    local_74 = _e350;
    uint _e352 = local_16;
    uint _e354 = local_74[1];
    local_74[1] = (_e354 + _e352);
    uint _e358 = local_74[0];
    local_75 = uint(_e358);
    uint _e362 = local_74[1];
    local_76 = uint(_e362);
    uint _e365 = local_76;
    _group_0_binding_1_cs[_e365] = uint(_e342);
    repeat = 0;
    while(true) {
        fixed_ = 1;
        int _e371 = fixed_;
        if ((_e371 != 0)) {
        } else {
            break;
        }
        {
            int _e374 = fixed_;
            int _e375 = repeat;
            repeat = (_e375 + _e374);
            int _e377 = repeat;
            if ((_e377 == 2)) {
                break;
            }
        }
    }
    int _e380 = repeat;
    uint _e382[2] = output_;
    local_17 = _e382;
    local_18 = uint((base + 6u));
    uint _e388[2] = local_17;
    local_77 = _e388;
    uint _e390 = local_18;
    uint _e392 = local_77[1];
    local_77[1] = (_e392 + _e390);
    uint _e396 = local_77[0];
    local_78 = uint(_e396);
    uint _e400 = local_77[1];
    local_79 = uint(_e400);
    uint _e403 = local_79;
    _group_0_binding_1_cs[_e403] = uint(_e380);
    entry_3 = 50;
    nested = 0;
    while(true) {
        uint _e410[2] = input_;
        local_19 = _e410;
        local_20 = offset_3;
        uint _e413[2] = local_19;
        local_80 = _e413;
        uint _e415 = local_20;
        uint _e417 = local_80[1];
        local_80[1] = (_e417 + _e415);
        uint _e421 = local_80[0];
        local_81 = uint(_e421);
        uint _e425 = local_80[1];
        local_82 = uint(_e425);
        uint _e428 = local_82;
        int _e431 = _group_0_binding_0_cs[_e428];
        local_83 = _e431;
        int _e433 = local_83;
        local_46 = _e433;
        int _e435 = local_46;
        entry_4 = _e435;
        int _e437 = entry_4;
        if ((_e437 != 0)) {
        } else {
            break;
        }
        {
            {
                entry_5 = 9;
                int _e442 = entry_5;
                int _e443 = nested;
                nested = (_e443 + _e442);
            }
            int _e445 = entry_4;
            int _e446 = nested;
            nested = (_e446 + _e445);
            break;
        }
    }
    int _e448 = nested;
    uint _e450[2] = output_;
    local_21 = _e450;
    local_22 = uint((base + 7u));
    uint _e456[2] = local_21;
    local_84 = _e456;
    uint _e458 = local_22;
    uint _e460 = local_84[1];
    local_84[1] = (_e460 + _e458);
    uint _e464 = local_84[0];
    local_85 = uint(_e464);
    uint _e468 = local_84[1];
    local_86 = uint(_e468);
    uint _e471 = local_86;
    _group_0_binding_1_cs[_e471] = uint(_e448);
    int _e473 = entry_3;
    uint _e475[2] = output_;
    local_23 = _e475;
    local_24 = uint((base + 8u));
    uint _e481[2] = local_23;
    local_87 = _e481;
    uint _e483 = local_24;
    uint _e485 = local_87[1];
    local_87[1] = (_e485 + _e483);
    uint _e489 = local_87[0];
    local_88 = uint(_e489);
    uint _e493 = local_87[1];
    local_89 = uint(_e493);
    uint _e496 = local_89;
    _group_0_binding_1_cs[_e496] = uint(_e473);
    false_count = 0;
    while(true) {
        int _e500 = false_count;
        false_count = (_e500 + 1);
        stopped = 0;
        int _e505 = stopped;
        if ((_e505 != 0)) {
        } else {
            break;
        }
        {
            int _e508 = total;
            total = (_e508 + 1);
        }
    }
    int _e511 = false_count;
    uint _e513[2] = output_;
    local_25 = _e513;
    local_26 = uint((base + 9u));
    uint _e519[2] = local_25;
    local_90 = _e519;
    uint _e521 = local_26;
    uint _e523 = local_90[1];
    local_90[1] = (_e523 + _e521);
    uint _e527 = local_90[0];
    local_91 = uint(_e527);
    uint _e531 = local_90[1];
    local_92 = uint(_e531);
    uint _e534 = local_92;
    _group_0_binding_1_cs[_e534] = uint(_e511);
    while(true) {
        fraction = 0.5;
        float _e538 = fraction;
        uint _e540 = _naga_fabsf(floatBitsToUint(_e538));
        if ((_e540 != 0u)) {
        } else {
            break;
        }
        {
            int _e543 = total;
            total = (_e543 + 1);
            break;
        }
    }
    int _e546 = total;
    uint _e548[2] = output_;
    local_27 = _e548;
    local_28 = uint((base + 10u));
    uint _e554[2] = local_27;
    local_93 = _e554;
    uint _e556 = local_28;
    uint _e558 = local_93[1];
    local_93[1] = (_e558 + _e556);
    uint _e562 = local_93[0];
    local_94 = uint(_e562);
    uint _e566 = local_93[1];
    local_95 = uint(_e566);
    uint _e569 = local_95;
    _group_0_binding_1_cs[_e569] = uint(_e546);
    int _e571 = cursor;
    int _e572 = inferred_cursor;
    int _e574 = early_cursor;
    int _e576 = false_count;
    uint _e579[2] = output_;
    local_29 = _e579;
    local_30 = uint((base + 11u));
    uint _e585[2] = local_29;
    local_96 = _e585;
    uint _e587 = local_30;
    uint _e589 = local_96[1];
    local_96[1] = (_e589 + _e587);
    uint _e593 = local_96[0];
    local_97 = uint(_e593);
    uint _e597 = local_96[1];
    local_98 = uint(_e597);
    uint _e600 = local_98;
    _group_0_binding_1_cs[_e600] = uint((((_e571 + _e572) + _e574) + _e576));
}

