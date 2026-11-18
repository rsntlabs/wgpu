ByteAddressBuffer input_4 : register(t0);
RWByteAddressBuffer output_1 : register(u1);

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void while_conditions(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
    int cursor = (int)0;
    int total = (int)0;
    int entry = (int)0;
    uint local[2] = (uint[2])0;
    int local_1 = (int)0;
    uint local_2[2] = (uint[2])0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    int inferred_cursor = (int)0;
    int inferred_total = (int)0;
    uint local_5[2] = (uint[2])0;
    int local_6 = (int)0;
    int entry_1 = (int)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    int early_cursor = (int)0;
    int first = (int)0;
    uint local_11[2] = (uint[2])0;
    int local_12 = (int)0;
    int entry_2 = (int)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    int repeat = (int)0;
    int fixed = (int)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    int entry_3 = (int)0;
    int nested = (int)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    int entry_4 = (int)0;
    int entry_5 = (int)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    int false_count = (int)0;
    int stopped = (int)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    float fraction = (float)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint input_1[2] = (uint[2])0;
    uint offset = (uint)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    int local_33 = (int)0;
    int local_34 = (int)0;
    int local_35 = (int)0;
    uint input_2[2] = (uint[2])0;
    uint offset_1 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    int local_38 = (int)0;
    int local_39 = (int)0;
    int local_40 = (int)0;
    uint input_3[2] = (uint[2])0;
    uint offset_2 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    int local_43 = (int)0;
    int local_44 = (int)0;
    int local_45 = (int)0;
    int local_46 = (int)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    int local_50 = (int)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    int local_60 = (int)0;
    uint local_61[2] = (uint[2])0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64[2] = (uint[2])0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67[2] = (uint[2])0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    int local_70 = (int)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74[2] = (uint[2])0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77[2] = (uint[2])0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80[2] = (uint[2])0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    int local_83 = (int)0;
    uint local_84[2] = (uint[2])0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87[2] = (uint[2])0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90[2] = (uint[2])0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93[2] = (uint[2])0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96[2] = (uint[2])0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;

    input = ZeroValuearray2_uint_();
    input[0] = 2u;
    input[1] = 0u;
    output = ZeroValuearray2_uint_();
    output[0] = 3u;
    output[1] = 0u;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint offset_3 = (lane * 4u);
    uint base = (4u + (lane * 12u));
    cursor = int(0);
    total = int(0);
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e32[2] = input;
        local = _e32;
        offset = ZeroValueuint();
        local_32 = ZeroValueuint();
        local_33 = ZeroValueint();
        uint _e40[2] = local;
        input_1 = _e40;
        offset = offset_3;
        uint _e44[2] = input_1;
        local_31 = _e44;
        int _e46 = cursor;
        local_34 = _e46;
        int _e48 = local_34;
        cursor = asint(asuint(_e48) + asuint(int(1)));
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
        int _e74 = asint(input_4.Load(_e71*4));
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
        if ((_e84 != int(0))) {
        } else {
            break;
        }
        {
            int _e87 = entry;
            if ((_e87 == int(1))) {
                entry = int(99);
                continue;
            }
            int _e91 = entry;
            int _e92 = total;
            total = asint(asuint(_e92) + asuint(_e91));
        }
    }
    int _e94 = total;
    uint _e97[2] = output;
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
    output_1.Store(_e113*4, asuint(uint(_e94)));
    int _e116 = cursor;
    uint _e118[2] = output;
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
    output_1.Store(_e139*4, asuint(uint(_e116)));
    inferred_cursor = int(0);
    inferred_total = int(0);
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        uint _e146[2] = input;
        local_5 = _e146;
        offset_1 = ZeroValueuint();
        local_37 = ZeroValueuint();
        local_38 = ZeroValueint();
        uint _e154[2] = local_5;
        input_2 = _e154;
        offset_1 = offset_3;
        uint _e158[2] = input_2;
        local_36 = _e158;
        int _e160 = inferred_cursor;
        local_39 = _e160;
        int _e162 = local_39;
        inferred_cursor = asint(asuint(_e162) + asuint(int(1)));
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
        int _e188 = asint(input_4.Load(_e185*4));
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
        if ((_e198 != int(0))) {
        } else {
            break;
        }
        {
            int _e201 = entry_1;
            bool should_continue = false;
            switch(_e201) {
                case 1: {
                    entry_1 = int(77);
                    should_continue = true;
                    break;
                }
                default: {
                    int _e203 = entry_1;
                    int _e204 = inferred_total;
                    inferred_total = asint(asuint(_e204) + asuint(_e203));
                    break;
                }
            }
            if (should_continue) {
                continue;
            }
        }
    }
    int _e206 = inferred_total;
    uint _e208[2] = output;
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
    output_1.Store(_e229*4, asuint(uint(_e206)));
    int _e231 = inferred_cursor;
    uint _e233[2] = output;
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
    output_1.Store(_e254*4, asuint(uint(_e231)));
    early_cursor = int(0);
    first = int(0);
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        uint _e261[2] = input;
        local_11 = _e261;
        offset_2 = ZeroValueuint();
        local_42 = ZeroValueuint();
        local_43 = ZeroValueint();
        uint _e269[2] = local_11;
        input_3 = _e269;
        offset_2 = offset_3;
        uint _e273[2] = input_3;
        local_41 = _e273;
        int _e275 = early_cursor;
        local_44 = _e275;
        int _e277 = local_44;
        early_cursor = asint(asuint(_e277) + asuint(int(1)));
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
        int _e303 = asint(input_4.Load(_e300*4));
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
        if ((_e313 != int(0))) {
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
    uint _e319[2] = output;
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
    output_1.Store(_e340*4, asuint(uint(_e317)));
    int _e342 = early_cursor;
    uint _e344[2] = output;
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
    output_1.Store(_e365*4, asuint(uint(_e342)));
    repeat = int(0);
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        fixed = int(1);
        int _e371 = fixed;
        if ((_e371 != int(0))) {
        } else {
            break;
        }
        {
            int _e374 = fixed;
            int _e375 = repeat;
            repeat = asint(asuint(_e375) + asuint(_e374));
            int _e377 = repeat;
            if ((_e377 == int(2))) {
                break;
            }
        }
    }
    int _e380 = repeat;
    uint _e382[2] = output;
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
    output_1.Store(_e403*4, asuint(uint(_e380)));
    entry_3 = int(50);
    nested = int(0);
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        uint _e410[2] = input;
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
        int _e431 = asint(input_4.Load(_e428*4));
        local_83 = _e431;
        int _e433 = local_83;
        local_46 = _e433;
        int _e435 = local_46;
        entry_4 = _e435;
        int _e437 = entry_4;
        if ((_e437 != int(0))) {
        } else {
            break;
        }
        {
            {
                entry_5 = int(9);
                int _e442 = entry_5;
                int _e443 = nested;
                nested = asint(asuint(_e443) + asuint(_e442));
            }
            int _e445 = entry_4;
            int _e446 = nested;
            nested = asint(asuint(_e446) + asuint(_e445));
            break;
        }
    }
    int _e448 = nested;
    uint _e450[2] = output;
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
    output_1.Store(_e471*4, asuint(uint(_e448)));
    int _e473 = entry_3;
    uint _e475[2] = output;
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
    output_1.Store(_e496*4, asuint(uint(_e473)));
    false_count = int(0);
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        int _e500 = false_count;
        false_count = asint(asuint(_e500) + asuint(int(1)));
        stopped = int(0);
        int _e505 = stopped;
        if ((_e505 != int(0))) {
        } else {
            break;
        }
        {
            int _e508 = total;
            total = asint(asuint(_e508) + asuint(int(1)));
        }
    }
    int _e511 = false_count;
    uint _e513[2] = output;
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
    output_1.Store(_e534*4, asuint(uint(_e511)));
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        fraction = 0.5;
        float _e538 = fraction;
        const uint _e540 = _naga_fabsf(asuint(_e538));
        if ((_e540 != 0u)) {
        } else {
            break;
        }
        {
            int _e543 = total;
            total = asint(asuint(_e543) + asuint(int(1)));
            break;
        }
    }
    int _e546 = total;
    uint _e548[2] = output;
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
    output_1.Store(_e569*4, asuint(uint(_e546)));
    int _e571 = cursor;
    int _e572 = inferred_cursor;
    int _e574 = early_cursor;
    int _e576 = false_count;
    uint _e579[2] = output;
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
    output_1.Store(_e600*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(_e571) + asuint(_e572))) + asuint(_e574))) + asuint(_e576)))));
}
