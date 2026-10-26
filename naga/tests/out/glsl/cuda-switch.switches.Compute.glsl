#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_3_block_0Compute { int _group_0_binding_0_cs[]; };


int case_chain(int selector) {
    int selector_1 = 0;
    int result = 0;
    selector_1 = selector;
    result = 0;
    int _e4 = selector_1;
    switch(_e4) {
        case -1: {
            int _e6 = result;
            result = (_e6 + 1);
        }
        case 0: {
            int _e9 = result;
            result = (_e9 + 10);
        }
        case 1: {
            int _e12 = result;
            result = (_e12 + 100);
            break;
        }
        default: {
            int _e15 = result;
            result = (_e15 + 1000);
        }
        case 2: {
            int _e18 = result;
            result = (_e18 + 10000);
            break;
        }
    }
    int _e20 = result;
    return _e20;
}

int grouped_labels(uint selector_2) {
    uint selector_3 = 0u;
    int result_1 = 0;
    selector_3 = selector_2;
    result_1 = 0;
    uint _e4 = selector_3;
    switch(_e4) {
        case 0u:
        case 1u: {
            int _e6 = result_1;
            result_1 = (_e6 + 3);
        }
        case 2u: {
            int _e9 = result_1;
            result_1 = (_e9 + 5);
            break;
        }
        default: {
            result_1 = 7;
            break;
        }
    }
    int _e12 = result_1;
    return _e12;
}

int nested_switches(int outer, int inner) {
    int outer_1 = 0;
    int inner_1 = 0;
    int result_2 = 0;
    outer_1 = outer;
    inner_1 = inner;
    result_2 = 0;
    int _e6 = outer_1;
    switch(_e6) {
        case 0: {
            int _e8 = result_2;
            result_2 = (_e8 + 1);
            int _e10 = inner_1;
            switch(_e10) {
                case 0: {
                    int _e12 = result_2;
                    result_2 = (_e12 + 10);
                }
                default: {
                    int _e15 = result_2;
                    result_2 = (_e15 + 20);
                    break;
                }
            }
        }
        case 1: {
            int _e18 = result_2;
            result_2 = (_e18 + 100);
            break;
        }
        default: {
            result_2 = 900;
            break;
        }
    }
    int _e21 = result_2;
    return _e21;
}

int loop_jumps(int selector_4) {
    int selector_5 = 0;
    int result_3 = 0;
    int iteration = 0;
    selector_5 = selector_4;
    result_3 = 0;
    {
        iteration = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e9 = iteration;
                iteration = (_e9 + 1);
            }
            loop_init = false;
            int _e7 = iteration;
            if ((_e7 < 4)) {
            } else {
                break;
            }
            int _e12 = selector_5;
            switch(_e12) {
                case 0: {
                    int _e14 = iteration;
                    if ((_e14 == 1)) {
                        continue;
                    }
                    int _e17 = iteration;
                    int _e19 = result_3;
                    result_3 = (_e19 + (_e17 + 1));
                }
                case 1: {
                    int _e22 = iteration;
                    if ((_e22 == 2)) {
                        break;
                    }
                    int _e25 = result_3;
                    result_3 = (_e25 + 10);
                    break;
                }
                default: {
                    int _e28 = result_3;
                    result_3 = (_e28 + 100);
                    continue;
                }
            }
            int _e31 = result_3;
            result_3 = (_e31 + 1000);
        }
    }
    int _e33 = result_3;
    return _e33;
}

int terminal_paths(int selector_6, int flag) {
    int selector_7 = 0;
    int flag_1 = 0;
    int result_4 = 0;
    selector_7 = selector_6;
    flag_1 = flag;
    result_4 = 0;
    int _e6 = selector_7;
    switch(_e6) {
        case 0: {
            int _e8 = flag_1;
            if ((_e8 != 0)) {
                return 3;
            }
            int _e12 = result_4;
            result_4 = (_e12 + 1);
        }
        case 1: {
            int _e15 = result_4;
            return (_e15 + 5);
        }
        default: {
            result_4 = 9;
        }
        case 2: {
            {
                int _e19 = result_4;
                return (_e19 + 10);
            }
            break;
        }
    }
}

int update_value(int value, int token) {
    int value_1 = 0;
    int token_1 = 0;
    value_1 = value;
    token_1 = token;
    int _e4 = value_1;
    int _e5 = token_1;
    return (_e4 + _e5);
}

ivec2 call_results(int selector_8, int counter_1) {
    int selector_9 = 0;
    int counter_2 = 0;
    int result_5 = 0;
    int named_value = 0;
    int named_value_1 = 0;
    int named_value_2 = 0;
    selector_9 = selector_8;
    counter_2 = counter_1;
    result_5 = 2;
    int _e6 = selector_9;
    switch(_e6) {
        case 0: {
            {
                int _e8 = result_5;
                int _e9 = counter_2;
                counter_2 = (_e9 + 1);
                int _e12 = counter_2;
                int _e13 = update_value(_e8, _e12);
                named_value = _e13;
                int _e14 = named_value;
                int _e15 = named_value;
                result_5 = (_e14 + _e15);
            }
        }
        case 1: {
            {
                int _e18 = result_5;
                int _e19 = counter_2;
                counter_2 = (_e19 + 1);
                int _e22 = counter_2;
                int _e23 = update_value(_e18, _e22);
                named_value_1 = _e23;
                int _e24 = named_value_1;
                int _e25 = named_value_1;
                result_5 = (_e24 * _e25);
            }
        }
        default: {
            {
                int _e28 = result_5;
                int _e29 = counter_2;
                counter_2 = (_e29 + 1);
                int _e32 = counter_2;
                int _e33 = update_value(_e28, _e32);
                named_value_2 = _e33;
                int _e34 = named_value_2;
                int _e35 = named_value_2;
                result_5 = (_e34 + _e35);
                break;
            }
            break;
        }
    }
    int _e37 = result_5;
    int _e38 = counter_2;
    return ivec2(_e37, _e38);
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
    int counter = 0;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    ivec2 first = ivec2(0);
    ivec2 second = ivec2(0);
    ivec2 third = ivec2(0);
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83 = 0u;
    uint local_84 = 0u;
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87 = 0u;
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90 = 0u;
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93 = 0u;
    uint local_94 = 0u;
    uint local_95 = 0u;
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98 = 0u;
    uint local_99 = 0u;
    uint local_100 = 0u;
    uint local_101 = 0u;
    uint local_102 = 0u;
    uint local_103 = 0u;
    uint local_104 = 0u;
    uint local_105 = 0u;
    uint local_106 = 0u;
    uint local_107 = 0u;
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110 = 0u;
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113 = 0u;
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116 = 0u;
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119 = 0u;
    uint local_120 = 0u;
    uint local_121 = 0u;
    uint local_122 = 0u;
    uint local_123 = 0u;
    uint local_124 = 0u;
    uint local_125 = 0u;
    local = 0u;
    int _e4 = case_chain(-(1));
    uint _e5 = local;
    local_1 = _e5;
    uint _e7 = local_1;
    local_2 = uint(_e7);
    local_3 = uint(0);
    uint _e14 = local_2;
    uint _e15 = local_3;
    local_94 = uint((_e14 + _e15));
    uint _e19 = local_94;
    _group_0_binding_0_cs[_e19] = _e4;
    int _e22 = case_chain(0);
    uint _e23 = local;
    local_4 = _e23;
    uint _e25 = local_4;
    local_5 = uint(_e25);
    local_6 = uint(1);
    uint _e31 = local_5;
    uint _e32 = local_6;
    local_95 = uint((_e31 + _e32));
    uint _e36 = local_95;
    _group_0_binding_0_cs[_e36] = _e22;
    int _e39 = case_chain(1);
    uint _e40 = local;
    local_7 = _e40;
    uint _e42 = local_7;
    local_8 = uint(_e42);
    local_9 = uint(2);
    uint _e48 = local_8;
    uint _e49 = local_9;
    local_96 = uint((_e48 + _e49));
    uint _e53 = local_96;
    _group_0_binding_0_cs[_e53] = _e39;
    int _e56 = case_chain(2);
    uint _e57 = local;
    local_10 = _e57;
    uint _e59 = local_10;
    local_11 = uint(_e59);
    local_12 = uint(3);
    uint _e65 = local_11;
    uint _e66 = local_12;
    local_97 = uint((_e65 + _e66));
    uint _e70 = local_97;
    _group_0_binding_0_cs[_e70] = _e56;
    int _e73 = case_chain(8);
    uint _e74 = local;
    local_13 = _e74;
    uint _e76 = local_13;
    local_14 = uint(_e76);
    local_15 = uint(4);
    uint _e82 = local_14;
    uint _e83 = local_15;
    local_98 = uint((_e82 + _e83));
    uint _e87 = local_98;
    _group_0_binding_0_cs[_e87] = _e73;
    int _e90 = grouped_labels(0u);
    uint _e91 = local;
    local_16 = _e91;
    uint _e93 = local_16;
    local_17 = uint(_e93);
    local_18 = uint(5);
    uint _e99 = local_17;
    uint _e100 = local_18;
    local_99 = uint((_e99 + _e100));
    uint _e104 = local_99;
    _group_0_binding_0_cs[_e104] = _e90;
    int _e107 = grouped_labels(1u);
    uint _e108 = local;
    local_19 = _e108;
    uint _e110 = local_19;
    local_20 = uint(_e110);
    local_21 = uint(6);
    uint _e116 = local_20;
    uint _e117 = local_21;
    local_100 = uint((_e116 + _e117));
    uint _e121 = local_100;
    _group_0_binding_0_cs[_e121] = _e107;
    int _e124 = grouped_labels(2u);
    uint _e125 = local;
    local_22 = _e125;
    uint _e127 = local_22;
    local_23 = uint(_e127);
    local_24 = uint(7);
    uint _e133 = local_23;
    uint _e134 = local_24;
    local_101 = uint((_e133 + _e134));
    uint _e138 = local_101;
    _group_0_binding_0_cs[_e138] = _e124;
    int _e141 = grouped_labels(8u);
    uint _e142 = local;
    local_25 = _e142;
    uint _e144 = local_25;
    local_26 = uint(_e144);
    local_27 = uint(8);
    uint _e150 = local_26;
    uint _e151 = local_27;
    local_102 = uint((_e150 + _e151));
    uint _e155 = local_102;
    _group_0_binding_0_cs[_e155] = _e141;
    int _e159 = nested_switches(0, 0);
    uint _e160 = local;
    local_28 = _e160;
    uint _e162 = local_28;
    local_29 = uint(_e162);
    local_30 = uint(9);
    uint _e168 = local_29;
    uint _e169 = local_30;
    local_103 = uint((_e168 + _e169));
    uint _e173 = local_103;
    _group_0_binding_0_cs[_e173] = _e159;
    int _e177 = nested_switches(0, 8);
    uint _e178 = local;
    local_31 = _e178;
    uint _e180 = local_31;
    local_32 = uint(_e180);
    local_33 = uint(10);
    uint _e186 = local_32;
    uint _e187 = local_33;
    local_104 = uint((_e186 + _e187));
    uint _e191 = local_104;
    _group_0_binding_0_cs[_e191] = _e177;
    int _e195 = nested_switches(1, 0);
    uint _e196 = local;
    local_34 = _e196;
    uint _e198 = local_34;
    local_35 = uint(_e198);
    local_36 = uint(11);
    uint _e204 = local_35;
    uint _e205 = local_36;
    local_105 = uint((_e204 + _e205));
    uint _e209 = local_105;
    _group_0_binding_0_cs[_e209] = _e195;
    int _e213 = nested_switches(8, 0);
    uint _e214 = local;
    local_37 = _e214;
    uint _e216 = local_37;
    local_38 = uint(_e216);
    local_39 = uint(12);
    uint _e222 = local_38;
    uint _e223 = local_39;
    local_106 = uint((_e222 + _e223));
    uint _e227 = local_106;
    _group_0_binding_0_cs[_e227] = _e213;
    int _e230 = loop_jumps(0);
    uint _e231 = local;
    local_40 = _e231;
    uint _e233 = local_40;
    local_41 = uint(_e233);
    local_42 = uint(13);
    uint _e239 = local_41;
    uint _e240 = local_42;
    local_107 = uint((_e239 + _e240));
    uint _e244 = local_107;
    _group_0_binding_0_cs[_e244] = _e230;
    int _e247 = loop_jumps(1);
    uint _e248 = local;
    local_43 = _e248;
    uint _e250 = local_43;
    local_44 = uint(_e250);
    local_45 = uint(14);
    uint _e256 = local_44;
    uint _e257 = local_45;
    local_108 = uint((_e256 + _e257));
    uint _e261 = local_108;
    _group_0_binding_0_cs[_e261] = _e247;
    int _e264 = loop_jumps(8);
    uint _e265 = local;
    local_46 = _e265;
    uint _e267 = local_46;
    local_47 = uint(_e267);
    local_48 = uint(15);
    uint _e273 = local_47;
    uint _e274 = local_48;
    local_109 = uint((_e273 + _e274));
    uint _e278 = local_109;
    _group_0_binding_0_cs[_e278] = _e264;
    int _e282 = terminal_paths(0, 1);
    uint _e283 = local;
    local_49 = _e283;
    uint _e285 = local_49;
    local_50 = uint(_e285);
    local_51 = uint(16);
    uint _e291 = local_50;
    uint _e292 = local_51;
    local_110 = uint((_e291 + _e292));
    uint _e296 = local_110;
    _group_0_binding_0_cs[_e296] = _e282;
    int _e300 = terminal_paths(0, 0);
    uint _e301 = local;
    local_52 = _e301;
    uint _e303 = local_52;
    local_53 = uint(_e303);
    local_54 = uint(17);
    uint _e309 = local_53;
    uint _e310 = local_54;
    local_111 = uint((_e309 + _e310));
    uint _e314 = local_111;
    _group_0_binding_0_cs[_e314] = _e300;
    int _e318 = terminal_paths(1, 1);
    uint _e319 = local;
    local_55 = _e319;
    uint _e321 = local_55;
    local_56 = uint(_e321);
    local_57 = uint(18);
    uint _e327 = local_56;
    uint _e328 = local_57;
    local_112 = uint((_e327 + _e328));
    uint _e332 = local_112;
    _group_0_binding_0_cs[_e332] = _e318;
    int _e336 = terminal_paths(8, 0);
    uint _e337 = local;
    local_58 = _e337;
    uint _e339 = local_58;
    local_59 = uint(_e339);
    local_60 = uint(19);
    uint _e345 = local_59;
    uint _e346 = local_60;
    local_113 = uint((_e345 + _e346));
    uint _e350 = local_113;
    _group_0_binding_0_cs[_e350] = _e336;
    int _e354 = terminal_paths(2, 0);
    uint _e355 = local;
    local_61 = _e355;
    uint _e357 = local_61;
    local_62 = uint(_e357);
    local_63 = uint(20);
    uint _e363 = local_62;
    uint _e364 = local_63;
    local_114 = uint((_e363 + _e364));
    uint _e368 = local_114;
    _group_0_binding_0_cs[_e368] = _e354;
    counter = 0;
    int _e372 = counter;
    counter = (_e372 + 1);
    switch(_e372) {
        case 0: {
            int _e375 = counter;
            uint _e376 = local;
            local_64 = _e376;
            uint _e378 = local_64;
            local_65 = uint(_e378);
            local_66 = uint(21);
            uint _e384 = local_65;
            uint _e385 = local_66;
            local_115 = uint((_e384 + _e385));
            uint _e389 = local_115;
            _group_0_binding_0_cs[_e389] = _e375;
            int _e391 = counter;
            uint _e394 = local;
            local_67 = _e394;
            uint _e396 = local_67;
            local_68 = uint(_e396);
            local_69 = uint(22);
            uint _e402 = local_68;
            uint _e403 = local_69;
            local_116 = uint((_e402 + _e403));
            uint _e407 = local_116;
            _group_0_binding_0_cs[_e407] = (_e391 + 1);
            break;
        }
        case 1: {
            int _e409 = counter;
            uint _e412 = local;
            local_67 = _e412;
            uint _e414 = local_67;
            local_68 = uint(_e414);
            local_69 = uint(22);
            uint _e420 = local_68;
            uint _e421 = local_69;
            local_117 = uint((_e420 + _e421));
            uint _e425 = local_117;
            _group_0_binding_0_cs[_e425] = (_e409 + 1);
            break;
        }
        default: {
            uint _e427 = local;
            local_70 = _e427;
            uint _e429 = local_70;
            local_71 = uint(_e429);
            local_72 = uint(21);
            uint _e435 = local_71;
            uint _e436 = local_72;
            local_118 = uint((_e435 + _e436));
            uint _e441 = local_118;
            _group_0_binding_0_cs[_e441] = 99;
            break;
        }
    }
    int _e443 = counter;
    uint _e444 = local;
    local_73 = _e444;
    uint _e446 = local_73;
    local_74 = uint(_e446);
    local_75 = uint(23);
    uint _e452 = local_74;
    uint _e453 = local_75;
    local_119 = uint((_e452 + _e453));
    uint _e457 = local_119;
    _group_0_binding_0_cs[_e457] = _e443;
    ivec2 _e461 = call_results(0, 0);
    first = _e461;
    int _e464 = first.y;
    ivec2 _e466 = call_results(1, _e464);
    second = _e466;
    int _e469 = second.y;
    ivec2 _e471 = call_results(8, _e469);
    third = _e471;
    int _e474 = first.x;
    uint _e475 = local;
    local_76 = _e475;
    uint _e477 = local_76;
    local_77 = uint(_e477);
    local_78 = uint(24);
    uint _e483 = local_77;
    uint _e484 = local_78;
    local_120 = uint((_e483 + _e484));
    uint _e488 = local_120;
    _group_0_binding_0_cs[_e488] = _e474;
    int _e491 = second.x;
    uint _e492 = local;
    local_79 = _e492;
    uint _e494 = local_79;
    local_80 = uint(_e494);
    local_81 = uint(25);
    uint _e500 = local_80;
    uint _e501 = local_81;
    local_121 = uint((_e500 + _e501));
    uint _e505 = local_121;
    _group_0_binding_0_cs[_e505] = _e491;
    int _e508 = third.x;
    uint _e509 = local;
    local_82 = _e509;
    uint _e511 = local_82;
    local_83 = uint(_e511);
    local_84 = uint(26);
    uint _e517 = local_83;
    uint _e518 = local_84;
    local_122 = uint((_e517 + _e518));
    uint _e522 = local_122;
    _group_0_binding_0_cs[_e522] = _e508;
    int _e525 = third.y;
    uint _e526 = local;
    local_85 = _e526;
    uint _e528 = local_85;
    local_86 = uint(_e528);
    local_87 = uint(27);
    uint _e534 = local_86;
    uint _e535 = local_87;
    local_123 = uint((_e534 + _e535));
    uint _e539 = local_123;
    _group_0_binding_0_cs[_e539] = _e525;
    int _e542 = third.y;
    counter = _e542;
    int _e544 = third.x;
    int _e545 = counter;
    counter = (_e545 + 1);
    int _e548 = counter;
    int _e549 = update_value(_e544, _e548);
    uint _e550 = local;
    local_88 = _e550;
    uint _e552 = local_88;
    local_89 = uint(_e552);
    local_90 = uint(28);
    uint _e558 = local_89;
    uint _e559 = local_90;
    local_124 = uint((_e558 + _e559));
    uint _e563 = local_124;
    _group_0_binding_0_cs[_e563] = _e549;
    int _e565 = counter;
    uint _e566 = local;
    local_91 = _e566;
    uint _e568 = local_91;
    local_92 = uint(_e568);
    local_93 = uint(29);
    uint _e574 = local_92;
    uint _e575 = local_93;
    local_125 = uint((_e574 + _e575));
    uint _e579 = local_125;
    _group_0_binding_0_cs[_e579] = _e565;
}

