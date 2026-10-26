@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn case_chain(selector: i32) -> i32 {
    var selector_1: i32;
    var result: i32;

    selector_1 = selector;
    result = 0i;
    let _e4 = selector_1;
    switch _e4 {
        case -1: {
            {
                let _e6 = result;
                result = (_e6 + 1i);
            }
            {
                let _e9 = result;
                result = (_e9 + 10i);
            }
            {
                let _e12 = result;
                result = (_e12 + 100i);
                break;
            }
        }
        case 0: {
            {
                let _e9 = result;
                result = (_e9 + 10i);
            }
            {
                let _e12 = result;
                result = (_e12 + 100i);
                break;
            }
        }
        case 1: {
            let _e12 = result;
            result = (_e12 + 100i);
            break;
        }
        default: {
            {
                let _e15 = result;
                result = (_e15 + 1000i);
            }
            {
                let _e18 = result;
                result = (_e18 + 10000i);
                break;
            }
        }
        case 2: {
            let _e18 = result;
            result = (_e18 + 10000i);
            break;
        }
    }
    let _e20 = result;
    return _e20;
}

fn grouped_labels(selector_2: u32) -> i32 {
    var selector_3: u32;
    var result_1: i32;

    selector_3 = selector_2;
    result_1 = 0i;
    let _e4 = selector_3;
    switch _e4 {
        case 0u, 1u: {
            {
                let _e6 = result_1;
                result_1 = (_e6 + 3i);
            }
            {
                let _e9 = result_1;
                result_1 = (_e9 + 5i);
                break;
            }
        }
        case 2u: {
            let _e9 = result_1;
            result_1 = (_e9 + 5i);
            break;
        }
        default: {
            result_1 = 7i;
            break;
        }
    }
    let _e12 = result_1;
    return _e12;
}

fn nested_switches(outer: i32, inner: i32) -> i32 {
    var outer_1: i32;
    var inner_1: i32;
    var result_2: i32;

    outer_1 = outer;
    inner_1 = inner;
    result_2 = 0i;
    let _e6 = outer_1;
    switch _e6 {
        case 0: {
            {
                let _e8 = result_2;
                result_2 = (_e8 + 1i);
                let _e10 = inner_1;
                switch _e10 {
                    case 0: {
                        {
                            let _e12 = result_2;
                            result_2 = (_e12 + 10i);
                        }
                        {
                            let _e15 = result_2;
                            result_2 = (_e15 + 20i);
                            break;
                        }
                    }
                    default: {
                        let _e15 = result_2;
                        result_2 = (_e15 + 20i);
                        break;
                    }
                }
            }
            {
                let _e18 = result_2;
                result_2 = (_e18 + 100i);
                break;
            }
        }
        case 1: {
            let _e18 = result_2;
            result_2 = (_e18 + 100i);
            break;
        }
        default: {
            result_2 = 900i;
            break;
        }
    }
    let _e21 = result_2;
    return _e21;
}

fn loop_jumps(selector_4: i32) -> i32 {
    var selector_5: i32;
    var result_3: i32;
    var iteration: i32;

    selector_5 = selector_4;
    result_3 = 0i;
    {
        iteration = 0i;
        loop {
            let _e7 = iteration;
            if (_e7 < 4i) {
            } else {
                break;
            }
            let _e12 = selector_5;
            switch _e12 {
                case 0: {
                    {
                        let _e14 = iteration;
                        if (_e14 == 1i) {
                            continue;
                        }
                        let _e17 = iteration;
                        let _e19 = result_3;
                        result_3 = (_e19 + (_e17 + 1i));
                    }
                    {
                        let _e22 = iteration;
                        if (_e22 == 2i) {
                            break;
                        }
                        let _e25 = result_3;
                        result_3 = (_e25 + 10i);
                        break;
                    }
                }
                case 1: {
                    let _e22 = iteration;
                    if (_e22 == 2i) {
                        break;
                    }
                    let _e25 = result_3;
                    result_3 = (_e25 + 10i);
                    break;
                }
                default: {
                    let _e28 = result_3;
                    result_3 = (_e28 + 100i);
                    continue;
                }
            }
            let _e31 = result_3;
            result_3 = (_e31 + 1000i);
            continuing {
                let _e9 = iteration;
                iteration = (_e9 + 1i);
            }
        }
    }
    let _e33 = result_3;
    return _e33;
}

fn terminal_paths(selector_6: i32, flag: i32) -> i32 {
    var selector_7: i32;
    var flag_1: i32;
    var result_4: i32;

    selector_7 = selector_6;
    flag_1 = flag;
    result_4 = 0i;
    let _e6 = selector_7;
    switch _e6 {
        case 0: {
            {
                let _e8 = flag_1;
                if (_e8 != 0i) {
                    return 3i;
                }
                let _e12 = result_4;
                result_4 = (_e12 + 1i);
            }
            {
                let _e15 = result_4;
                return (_e15 + 5i);
            }
        }
        case 1: {
            let _e15 = result_4;
            return (_e15 + 5i);
        }
        default: {
            {
                result_4 = 9i;
            }
            {
                {
                    let _e19 = result_4;
                    return (_e19 + 10i);
                }
            }
        }
        case 2: {
            {
                let _e19 = result_4;
                return (_e19 + 10i);
            }
        }
    }
}

fn update_value(value: i32, token: i32) -> i32 {
    var value_1: i32;
    var token_1: i32;

    value_1 = value;
    token_1 = token;
    let _e4 = value_1;
    let _e5 = token_1;
    return (_e4 + _e5);
}

fn call_results(selector_8: i32, counter_1: i32) -> vec2<i32> {
    var selector_9: i32;
    var counter_2: i32;
    var result_5: i32;
    var named_value: i32;
    var named_value_1: i32;
    var named_value_2: i32;

    selector_9 = selector_8;
    counter_2 = counter_1;
    result_5 = 2i;
    let _e6 = selector_9;
    switch _e6 {
        case 0: {
            {
                {
                    let _e8 = result_5;
                    let _e9 = counter_2;
                    counter_2 = (_e9 + 1i);
                    let _e12 = counter_2;
                    let _e13 = update_value(_e8, _e12);
                    named_value = _e13;
                    let _e14 = named_value;
                    let _e15 = named_value;
                    result_5 = (_e14 + _e15);
                }
            }
            {
                {
                    let _e18 = result_5;
                    let _e19 = counter_2;
                    counter_2 = (_e19 + 1i);
                    let _e22 = counter_2;
                    let _e23 = update_value(_e18, _e22);
                    named_value_1 = _e23;
                    let _e24 = named_value_1;
                    let _e25 = named_value_1;
                    result_5 = (_e24 * _e25);
                }
            }
            {
                {
                    let _e28 = result_5;
                    let _e29 = counter_2;
                    counter_2 = (_e29 + 1i);
                    let _e32 = counter_2;
                    let _e33 = update_value(_e28, _e32);
                    named_value_2 = _e33;
                    let _e34 = named_value_2;
                    let _e35 = named_value_2;
                    result_5 = (_e34 + _e35);
                    break;
                }
            }
        }
        case 1: {
            {
                {
                    let _e18 = result_5;
                    let _e19 = counter_2;
                    counter_2 = (_e19 + 1i);
                    let _e22 = counter_2;
                    let _e23 = update_value(_e18, _e22);
                    named_value_1 = _e23;
                    let _e24 = named_value_1;
                    let _e25 = named_value_1;
                    result_5 = (_e24 * _e25);
                }
            }
            {
                {
                    let _e28 = result_5;
                    let _e29 = counter_2;
                    counter_2 = (_e29 + 1i);
                    let _e32 = counter_2;
                    let _e33 = update_value(_e28, _e32);
                    named_value_2 = _e33;
                    let _e34 = named_value_2;
                    let _e35 = named_value_2;
                    result_5 = (_e34 + _e35);
                    break;
                }
            }
        }
        default: {
            {
                let _e28 = result_5;
                let _e29 = counter_2;
                counter_2 = (_e29 + 1i);
                let _e32 = counter_2;
                let _e33 = update_value(_e28, _e32);
                named_value_2 = _e33;
                let _e34 = named_value_2;
                let _e35 = named_value_2;
                result_5 = (_e34 + _e35);
                break;
            }
        }
    }
    let _e37 = result_5;
    let _e38 = counter_2;
    return vec2<i32>(_e37, _e38);
}

@compute @workgroup_size(1, 1, 1)
fn switches() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var counter: i32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var first: vec2<i32>;
    var second: vec2<i32>;
    var third: vec2<i32>;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: u32;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: u32;
    var local_97: u32;
    var local_98: u32;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: u32;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: u32;
    var local_109: u32;
    var local_110: u32;
    var local_111: u32;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: u32;
    var local_116: u32;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: u32;
    var local_121: u32;
    var local_122: u32;
    var local_123: u32;
    var local_124: u32;
    var local_125: u32;

    local = 0u;
    let _e4 = case_chain(-(1i));
    let _e5 = local;
    local_1 = _e5;
    let _e7 = local_1;
    local_2 = u32(_e7);
    local_3 = u32(0i);
    let _e14 = local_2;
    let _e15 = local_3;
    local_94 = u32((_e14 + _e15));
    let _e19 = local_94;
    out[_e19] = _e4;
    let _e22 = case_chain(0i);
    let _e23 = local;
    local_4 = _e23;
    let _e25 = local_4;
    local_5 = u32(_e25);
    local_6 = u32(1i);
    let _e31 = local_5;
    let _e32 = local_6;
    local_95 = u32((_e31 + _e32));
    let _e36 = local_95;
    out[_e36] = _e22;
    let _e39 = case_chain(1i);
    let _e40 = local;
    local_7 = _e40;
    let _e42 = local_7;
    local_8 = u32(_e42);
    local_9 = u32(2i);
    let _e48 = local_8;
    let _e49 = local_9;
    local_96 = u32((_e48 + _e49));
    let _e53 = local_96;
    out[_e53] = _e39;
    let _e56 = case_chain(2i);
    let _e57 = local;
    local_10 = _e57;
    let _e59 = local_10;
    local_11 = u32(_e59);
    local_12 = u32(3i);
    let _e65 = local_11;
    let _e66 = local_12;
    local_97 = u32((_e65 + _e66));
    let _e70 = local_97;
    out[_e70] = _e56;
    let _e73 = case_chain(8i);
    let _e74 = local;
    local_13 = _e74;
    let _e76 = local_13;
    local_14 = u32(_e76);
    local_15 = u32(4i);
    let _e82 = local_14;
    let _e83 = local_15;
    local_98 = u32((_e82 + _e83));
    let _e87 = local_98;
    out[_e87] = _e73;
    let _e90 = grouped_labels(0u);
    let _e91 = local;
    local_16 = _e91;
    let _e93 = local_16;
    local_17 = u32(_e93);
    local_18 = u32(5i);
    let _e99 = local_17;
    let _e100 = local_18;
    local_99 = u32((_e99 + _e100));
    let _e104 = local_99;
    out[_e104] = _e90;
    let _e107 = grouped_labels(1u);
    let _e108 = local;
    local_19 = _e108;
    let _e110 = local_19;
    local_20 = u32(_e110);
    local_21 = u32(6i);
    let _e116 = local_20;
    let _e117 = local_21;
    local_100 = u32((_e116 + _e117));
    let _e121 = local_100;
    out[_e121] = _e107;
    let _e124 = grouped_labels(2u);
    let _e125 = local;
    local_22 = _e125;
    let _e127 = local_22;
    local_23 = u32(_e127);
    local_24 = u32(7i);
    let _e133 = local_23;
    let _e134 = local_24;
    local_101 = u32((_e133 + _e134));
    let _e138 = local_101;
    out[_e138] = _e124;
    let _e141 = grouped_labels(8u);
    let _e142 = local;
    local_25 = _e142;
    let _e144 = local_25;
    local_26 = u32(_e144);
    local_27 = u32(8i);
    let _e150 = local_26;
    let _e151 = local_27;
    local_102 = u32((_e150 + _e151));
    let _e155 = local_102;
    out[_e155] = _e141;
    let _e159 = nested_switches(0i, 0i);
    let _e160 = local;
    local_28 = _e160;
    let _e162 = local_28;
    local_29 = u32(_e162);
    local_30 = u32(9i);
    let _e168 = local_29;
    let _e169 = local_30;
    local_103 = u32((_e168 + _e169));
    let _e173 = local_103;
    out[_e173] = _e159;
    let _e177 = nested_switches(0i, 8i);
    let _e178 = local;
    local_31 = _e178;
    let _e180 = local_31;
    local_32 = u32(_e180);
    local_33 = u32(10i);
    let _e186 = local_32;
    let _e187 = local_33;
    local_104 = u32((_e186 + _e187));
    let _e191 = local_104;
    out[_e191] = _e177;
    let _e195 = nested_switches(1i, 0i);
    let _e196 = local;
    local_34 = _e196;
    let _e198 = local_34;
    local_35 = u32(_e198);
    local_36 = u32(11i);
    let _e204 = local_35;
    let _e205 = local_36;
    local_105 = u32((_e204 + _e205));
    let _e209 = local_105;
    out[_e209] = _e195;
    let _e213 = nested_switches(8i, 0i);
    let _e214 = local;
    local_37 = _e214;
    let _e216 = local_37;
    local_38 = u32(_e216);
    local_39 = u32(12i);
    let _e222 = local_38;
    let _e223 = local_39;
    local_106 = u32((_e222 + _e223));
    let _e227 = local_106;
    out[_e227] = _e213;
    let _e230 = loop_jumps(0i);
    let _e231 = local;
    local_40 = _e231;
    let _e233 = local_40;
    local_41 = u32(_e233);
    local_42 = u32(13i);
    let _e239 = local_41;
    let _e240 = local_42;
    local_107 = u32((_e239 + _e240));
    let _e244 = local_107;
    out[_e244] = _e230;
    let _e247 = loop_jumps(1i);
    let _e248 = local;
    local_43 = _e248;
    let _e250 = local_43;
    local_44 = u32(_e250);
    local_45 = u32(14i);
    let _e256 = local_44;
    let _e257 = local_45;
    local_108 = u32((_e256 + _e257));
    let _e261 = local_108;
    out[_e261] = _e247;
    let _e264 = loop_jumps(8i);
    let _e265 = local;
    local_46 = _e265;
    let _e267 = local_46;
    local_47 = u32(_e267);
    local_48 = u32(15i);
    let _e273 = local_47;
    let _e274 = local_48;
    local_109 = u32((_e273 + _e274));
    let _e278 = local_109;
    out[_e278] = _e264;
    let _e282 = terminal_paths(0i, 1i);
    let _e283 = local;
    local_49 = _e283;
    let _e285 = local_49;
    local_50 = u32(_e285);
    local_51 = u32(16i);
    let _e291 = local_50;
    let _e292 = local_51;
    local_110 = u32((_e291 + _e292));
    let _e296 = local_110;
    out[_e296] = _e282;
    let _e300 = terminal_paths(0i, 0i);
    let _e301 = local;
    local_52 = _e301;
    let _e303 = local_52;
    local_53 = u32(_e303);
    local_54 = u32(17i);
    let _e309 = local_53;
    let _e310 = local_54;
    local_111 = u32((_e309 + _e310));
    let _e314 = local_111;
    out[_e314] = _e300;
    let _e318 = terminal_paths(1i, 1i);
    let _e319 = local;
    local_55 = _e319;
    let _e321 = local_55;
    local_56 = u32(_e321);
    local_57 = u32(18i);
    let _e327 = local_56;
    let _e328 = local_57;
    local_112 = u32((_e327 + _e328));
    let _e332 = local_112;
    out[_e332] = _e318;
    let _e336 = terminal_paths(8i, 0i);
    let _e337 = local;
    local_58 = _e337;
    let _e339 = local_58;
    local_59 = u32(_e339);
    local_60 = u32(19i);
    let _e345 = local_59;
    let _e346 = local_60;
    local_113 = u32((_e345 + _e346));
    let _e350 = local_113;
    out[_e350] = _e336;
    let _e354 = terminal_paths(2i, 0i);
    let _e355 = local;
    local_61 = _e355;
    let _e357 = local_61;
    local_62 = u32(_e357);
    local_63 = u32(20i);
    let _e363 = local_62;
    let _e364 = local_63;
    local_114 = u32((_e363 + _e364));
    let _e368 = local_114;
    out[_e368] = _e354;
    counter = 0i;
    let _e372 = counter;
    counter = (_e372 + 1i);
    switch _e372 {
        case 0: {
            let _e375 = counter;
            let _e376 = local;
            local_64 = _e376;
            let _e378 = local_64;
            local_65 = u32(_e378);
            local_66 = u32(21i);
            let _e384 = local_65;
            let _e385 = local_66;
            local_115 = u32((_e384 + _e385));
            let _e389 = local_115;
            out[_e389] = _e375;
            let _e391 = counter;
            let _e394 = local;
            local_67 = _e394;
            let _e396 = local_67;
            local_68 = u32(_e396);
            local_69 = u32(22i);
            let _e402 = local_68;
            let _e403 = local_69;
            local_116 = u32((_e402 + _e403));
            let _e407 = local_116;
            out[_e407] = (_e391 + 1i);
            break;
        }
        case 1: {
            let _e409 = counter;
            let _e412 = local;
            local_67 = _e412;
            let _e414 = local_67;
            local_68 = u32(_e414);
            local_69 = u32(22i);
            let _e420 = local_68;
            let _e421 = local_69;
            local_117 = u32((_e420 + _e421));
            let _e425 = local_117;
            out[_e425] = (_e409 + 1i);
            break;
        }
        default: {
            let _e427 = local;
            local_70 = _e427;
            let _e429 = local_70;
            local_71 = u32(_e429);
            local_72 = u32(21i);
            let _e435 = local_71;
            let _e436 = local_72;
            local_118 = u32((_e435 + _e436));
            let _e441 = local_118;
            out[_e441] = 99i;
            break;
        }
    }
    let _e443 = counter;
    let _e444 = local;
    local_73 = _e444;
    let _e446 = local_73;
    local_74 = u32(_e446);
    local_75 = u32(23i);
    let _e452 = local_74;
    let _e453 = local_75;
    local_119 = u32((_e452 + _e453));
    let _e457 = local_119;
    out[_e457] = _e443;
    let _e461 = call_results(0i, 0i);
    first = _e461;
    let _e464 = first.y;
    let _e466 = call_results(1i, _e464);
    second = _e466;
    let _e469 = second.y;
    let _e471 = call_results(8i, _e469);
    third = _e471;
    let _e474 = first.x;
    let _e475 = local;
    local_76 = _e475;
    let _e477 = local_76;
    local_77 = u32(_e477);
    local_78 = u32(24i);
    let _e483 = local_77;
    let _e484 = local_78;
    local_120 = u32((_e483 + _e484));
    let _e488 = local_120;
    out[_e488] = _e474;
    let _e491 = second.x;
    let _e492 = local;
    local_79 = _e492;
    let _e494 = local_79;
    local_80 = u32(_e494);
    local_81 = u32(25i);
    let _e500 = local_80;
    let _e501 = local_81;
    local_121 = u32((_e500 + _e501));
    let _e505 = local_121;
    out[_e505] = _e491;
    let _e508 = third.x;
    let _e509 = local;
    local_82 = _e509;
    let _e511 = local_82;
    local_83 = u32(_e511);
    local_84 = u32(26i);
    let _e517 = local_83;
    let _e518 = local_84;
    local_122 = u32((_e517 + _e518));
    let _e522 = local_122;
    out[_e522] = _e508;
    let _e525 = third.y;
    let _e526 = local;
    local_85 = _e526;
    let _e528 = local_85;
    local_86 = u32(_e528);
    local_87 = u32(27i);
    let _e534 = local_86;
    let _e535 = local_87;
    local_123 = u32((_e534 + _e535));
    let _e539 = local_123;
    out[_e539] = _e525;
    let _e542 = third.y;
    counter = _e542;
    let _e544 = third.x;
    let _e545 = counter;
    counter = (_e545 + 1i);
    let _e548 = counter;
    let _e549 = update_value(_e544, _e548);
    let _e550 = local;
    local_88 = _e550;
    let _e552 = local_88;
    local_89 = u32(_e552);
    local_90 = u32(28i);
    let _e558 = local_89;
    let _e559 = local_90;
    local_124 = u32((_e558 + _e559));
    let _e563 = local_124;
    out[_e563] = _e549;
    let _e565 = counter;
    let _e566 = local;
    local_91 = _e566;
    let _e568 = local_91;
    local_92 = u32(_e568);
    local_93 = u32(29i);
    let _e574 = local_92;
    let _e575 = local_93;
    local_125 = u32((_e574 + _e575));
    let _e579 = local_125;
    out[_e579] = _e565;
}
