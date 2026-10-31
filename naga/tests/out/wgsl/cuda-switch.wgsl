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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var counter: i32;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var first: vec2<i32>;
    var second: vec2<i32>;
    var third: vec2<i32>;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: u32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: u32;
    var local_72: array<u32, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;
    var local_81: array<u32, 2>;
    var local_82: u32;
    var local_83: u32;
    var local_84: array<u32, 2>;
    var local_85: u32;
    var local_86: u32;
    var local_87: array<u32, 2>;
    var local_88: u32;
    var local_89: u32;
    var local_90: array<u32, 2>;
    var local_91: u32;
    var local_92: u32;
    var local_93: array<u32, 2>;
    var local_94: u32;
    var local_95: u32;
    var local_96: array<u32, 2>;
    var local_97: u32;
    var local_98: u32;
    var local_99: array<u32, 2>;
    var local_100: u32;
    var local_101: u32;
    var local_102: array<u32, 2>;
    var local_103: u32;
    var local_104: u32;
    var local_105: array<u32, 2>;
    var local_106: u32;
    var local_107: u32;
    var local_108: array<u32, 2>;
    var local_109: u32;
    var local_110: u32;
    var local_111: array<u32, 2>;
    var local_112: u32;
    var local_113: u32;
    var local_114: array<u32, 2>;
    var local_115: u32;
    var local_116: u32;
    var local_117: array<u32, 2>;
    var local_118: u32;
    var local_119: u32;
    var local_120: array<u32, 2>;
    var local_121: u32;
    var local_122: u32;
    var local_123: array<u32, 2>;
    var local_124: u32;
    var local_125: u32;
    var local_126: array<u32, 2>;
    var local_127: u32;
    var local_128: u32;
    var local_129: array<u32, 2>;
    var local_130: u32;
    var local_131: u32;
    var local_132: array<u32, 2>;
    var local_133: u32;
    var local_134: u32;
    var local_135: array<u32, 2>;
    var local_136: u32;
    var local_137: u32;
    var local_138: array<u32, 2>;
    var local_139: u32;
    var local_140: u32;
    var local_141: array<u32, 2>;
    var local_142: u32;
    var local_143: u32;
    var local_144: array<u32, 2>;
    var local_145: u32;
    var local_146: u32;
    var local_147: array<u32, 2>;
    var local_148: u32;
    var local_149: u32;
    var local_150: array<u32, 2>;
    var local_151: u32;
    var local_152: u32;
    var local_153: array<u32, 2>;
    var local_154: u32;
    var local_155: u32;
    var local_156: array<u32, 2>;
    var local_157: u32;
    var local_158: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    let _e9 = case_chain(-(1i));
    let _e12 = local;
    local_1 = _e12;
    local_2 = u32(0i);
    let _e17 = local_1;
    local_63 = _e17;
    let _e18 = local_2;
    let _e20 = local_63[1];
    local_63[1] = (_e20 + _e18);
    let _e24 = local_63[0];
    local_64 = u32(_e24);
    let _e28 = local_63[1];
    local_65 = u32(_e28);
    let _e31 = local_65;
    out[_e31] = _e9;
    let _e34 = case_chain(0i);
    let _e36 = local;
    local_3 = _e36;
    local_4 = u32(1i);
    let _e41 = local_3;
    local_66 = _e41;
    let _e42 = local_4;
    let _e44 = local_66[1];
    local_66[1] = (_e44 + _e42);
    let _e48 = local_66[0];
    local_67 = u32(_e48);
    let _e52 = local_66[1];
    local_68 = u32(_e52);
    let _e55 = local_68;
    out[_e55] = _e34;
    let _e58 = case_chain(1i);
    let _e60 = local;
    local_5 = _e60;
    local_6 = u32(2i);
    let _e65 = local_5;
    local_69 = _e65;
    let _e66 = local_6;
    let _e68 = local_69[1];
    local_69[1] = (_e68 + _e66);
    let _e72 = local_69[0];
    local_70 = u32(_e72);
    let _e76 = local_69[1];
    local_71 = u32(_e76);
    let _e79 = local_71;
    out[_e79] = _e58;
    let _e82 = case_chain(2i);
    let _e84 = local;
    local_7 = _e84;
    local_8 = u32(3i);
    let _e89 = local_7;
    local_72 = _e89;
    let _e90 = local_8;
    let _e92 = local_72[1];
    local_72[1] = (_e92 + _e90);
    let _e96 = local_72[0];
    local_73 = u32(_e96);
    let _e100 = local_72[1];
    local_74 = u32(_e100);
    let _e103 = local_74;
    out[_e103] = _e82;
    let _e106 = case_chain(8i);
    let _e108 = local;
    local_9 = _e108;
    local_10 = u32(4i);
    let _e113 = local_9;
    local_75 = _e113;
    let _e114 = local_10;
    let _e116 = local_75[1];
    local_75[1] = (_e116 + _e114);
    let _e120 = local_75[0];
    local_76 = u32(_e120);
    let _e124 = local_75[1];
    local_77 = u32(_e124);
    let _e127 = local_77;
    out[_e127] = _e106;
    let _e130 = grouped_labels(0u);
    let _e132 = local;
    local_11 = _e132;
    local_12 = u32(5i);
    let _e137 = local_11;
    local_78 = _e137;
    let _e138 = local_12;
    let _e140 = local_78[1];
    local_78[1] = (_e140 + _e138);
    let _e144 = local_78[0];
    local_79 = u32(_e144);
    let _e148 = local_78[1];
    local_80 = u32(_e148);
    let _e151 = local_80;
    out[_e151] = _e130;
    let _e154 = grouped_labels(1u);
    let _e156 = local;
    local_13 = _e156;
    local_14 = u32(6i);
    let _e161 = local_13;
    local_81 = _e161;
    let _e162 = local_14;
    let _e164 = local_81[1];
    local_81[1] = (_e164 + _e162);
    let _e168 = local_81[0];
    local_82 = u32(_e168);
    let _e172 = local_81[1];
    local_83 = u32(_e172);
    let _e175 = local_83;
    out[_e175] = _e154;
    let _e178 = grouped_labels(2u);
    let _e180 = local;
    local_15 = _e180;
    local_16 = u32(7i);
    let _e185 = local_15;
    local_84 = _e185;
    let _e186 = local_16;
    let _e188 = local_84[1];
    local_84[1] = (_e188 + _e186);
    let _e192 = local_84[0];
    local_85 = u32(_e192);
    let _e196 = local_84[1];
    local_86 = u32(_e196);
    let _e199 = local_86;
    out[_e199] = _e178;
    let _e202 = grouped_labels(8u);
    let _e204 = local;
    local_17 = _e204;
    local_18 = u32(8i);
    let _e209 = local_17;
    local_87 = _e209;
    let _e210 = local_18;
    let _e212 = local_87[1];
    local_87[1] = (_e212 + _e210);
    let _e216 = local_87[0];
    local_88 = u32(_e216);
    let _e220 = local_87[1];
    local_89 = u32(_e220);
    let _e223 = local_89;
    out[_e223] = _e202;
    let _e227 = nested_switches(0i, 0i);
    let _e229 = local;
    local_19 = _e229;
    local_20 = u32(9i);
    let _e234 = local_19;
    local_90 = _e234;
    let _e235 = local_20;
    let _e237 = local_90[1];
    local_90[1] = (_e237 + _e235);
    let _e241 = local_90[0];
    local_91 = u32(_e241);
    let _e245 = local_90[1];
    local_92 = u32(_e245);
    let _e248 = local_92;
    out[_e248] = _e227;
    let _e252 = nested_switches(0i, 8i);
    let _e254 = local;
    local_21 = _e254;
    local_22 = u32(10i);
    let _e259 = local_21;
    local_93 = _e259;
    let _e260 = local_22;
    let _e262 = local_93[1];
    local_93[1] = (_e262 + _e260);
    let _e266 = local_93[0];
    local_94 = u32(_e266);
    let _e270 = local_93[1];
    local_95 = u32(_e270);
    let _e273 = local_95;
    out[_e273] = _e252;
    let _e277 = nested_switches(1i, 0i);
    let _e279 = local;
    local_23 = _e279;
    local_24 = u32(11i);
    let _e284 = local_23;
    local_96 = _e284;
    let _e285 = local_24;
    let _e287 = local_96[1];
    local_96[1] = (_e287 + _e285);
    let _e291 = local_96[0];
    local_97 = u32(_e291);
    let _e295 = local_96[1];
    local_98 = u32(_e295);
    let _e298 = local_98;
    out[_e298] = _e277;
    let _e302 = nested_switches(8i, 0i);
    let _e304 = local;
    local_25 = _e304;
    local_26 = u32(12i);
    let _e309 = local_25;
    local_99 = _e309;
    let _e310 = local_26;
    let _e312 = local_99[1];
    local_99[1] = (_e312 + _e310);
    let _e316 = local_99[0];
    local_100 = u32(_e316);
    let _e320 = local_99[1];
    local_101 = u32(_e320);
    let _e323 = local_101;
    out[_e323] = _e302;
    let _e326 = loop_jumps(0i);
    let _e328 = local;
    local_27 = _e328;
    local_28 = u32(13i);
    let _e333 = local_27;
    local_102 = _e333;
    let _e334 = local_28;
    let _e336 = local_102[1];
    local_102[1] = (_e336 + _e334);
    let _e340 = local_102[0];
    local_103 = u32(_e340);
    let _e344 = local_102[1];
    local_104 = u32(_e344);
    let _e347 = local_104;
    out[_e347] = _e326;
    let _e350 = loop_jumps(1i);
    let _e352 = local;
    local_29 = _e352;
    local_30 = u32(14i);
    let _e357 = local_29;
    local_105 = _e357;
    let _e358 = local_30;
    let _e360 = local_105[1];
    local_105[1] = (_e360 + _e358);
    let _e364 = local_105[0];
    local_106 = u32(_e364);
    let _e368 = local_105[1];
    local_107 = u32(_e368);
    let _e371 = local_107;
    out[_e371] = _e350;
    let _e374 = loop_jumps(8i);
    let _e376 = local;
    local_31 = _e376;
    local_32 = u32(15i);
    let _e381 = local_31;
    local_108 = _e381;
    let _e382 = local_32;
    let _e384 = local_108[1];
    local_108[1] = (_e384 + _e382);
    let _e388 = local_108[0];
    local_109 = u32(_e388);
    let _e392 = local_108[1];
    local_110 = u32(_e392);
    let _e395 = local_110;
    out[_e395] = _e374;
    let _e399 = terminal_paths(0i, 1i);
    let _e401 = local;
    local_33 = _e401;
    local_34 = u32(16i);
    let _e406 = local_33;
    local_111 = _e406;
    let _e407 = local_34;
    let _e409 = local_111[1];
    local_111[1] = (_e409 + _e407);
    let _e413 = local_111[0];
    local_112 = u32(_e413);
    let _e417 = local_111[1];
    local_113 = u32(_e417);
    let _e420 = local_113;
    out[_e420] = _e399;
    let _e424 = terminal_paths(0i, 0i);
    let _e426 = local;
    local_35 = _e426;
    local_36 = u32(17i);
    let _e431 = local_35;
    local_114 = _e431;
    let _e432 = local_36;
    let _e434 = local_114[1];
    local_114[1] = (_e434 + _e432);
    let _e438 = local_114[0];
    local_115 = u32(_e438);
    let _e442 = local_114[1];
    local_116 = u32(_e442);
    let _e445 = local_116;
    out[_e445] = _e424;
    let _e449 = terminal_paths(1i, 1i);
    let _e451 = local;
    local_37 = _e451;
    local_38 = u32(18i);
    let _e456 = local_37;
    local_117 = _e456;
    let _e457 = local_38;
    let _e459 = local_117[1];
    local_117[1] = (_e459 + _e457);
    let _e463 = local_117[0];
    local_118 = u32(_e463);
    let _e467 = local_117[1];
    local_119 = u32(_e467);
    let _e470 = local_119;
    out[_e470] = _e449;
    let _e474 = terminal_paths(8i, 0i);
    let _e476 = local;
    local_39 = _e476;
    local_40 = u32(19i);
    let _e481 = local_39;
    local_120 = _e481;
    let _e482 = local_40;
    let _e484 = local_120[1];
    local_120[1] = (_e484 + _e482);
    let _e488 = local_120[0];
    local_121 = u32(_e488);
    let _e492 = local_120[1];
    local_122 = u32(_e492);
    let _e495 = local_122;
    out[_e495] = _e474;
    let _e499 = terminal_paths(2i, 0i);
    let _e501 = local;
    local_41 = _e501;
    local_42 = u32(20i);
    let _e506 = local_41;
    local_123 = _e506;
    let _e507 = local_42;
    let _e509 = local_123[1];
    local_123[1] = (_e509 + _e507);
    let _e513 = local_123[0];
    local_124 = u32(_e513);
    let _e517 = local_123[1];
    local_125 = u32(_e517);
    let _e520 = local_125;
    out[_e520] = _e499;
    counter = 0i;
    let _e524 = counter;
    counter = (_e524 + 1i);
    switch _e524 {
        case 0: {
            let _e527 = counter;
            let _e529 = local;
            local_43 = _e529;
            local_44 = u32(21i);
            let _e534 = local_43;
            local_126 = _e534;
            let _e535 = local_44;
            let _e537 = local_126[1];
            local_126[1] = (_e537 + _e535);
            let _e541 = local_126[0];
            local_127 = u32(_e541);
            let _e545 = local_126[1];
            local_128 = u32(_e545);
            let _e548 = local_128;
            out[_e548] = _e527;
            let _e550 = counter;
            let _e554 = local;
            local_45 = _e554;
            local_46 = u32(22i);
            let _e559 = local_45;
            local_129 = _e559;
            let _e560 = local_46;
            let _e562 = local_129[1];
            local_129[1] = (_e562 + _e560);
            let _e566 = local_129[0];
            local_130 = u32(_e566);
            let _e570 = local_129[1];
            local_131 = u32(_e570);
            let _e573 = local_131;
            out[_e573] = (_e550 + 1i);
            break;
        }
        case 1: {
            let _e575 = counter;
            let _e579 = local;
            local_45 = _e579;
            local_46 = u32(22i);
            let _e584 = local_45;
            local_132 = _e584;
            let _e585 = local_46;
            let _e587 = local_132[1];
            local_132[1] = (_e587 + _e585);
            let _e591 = local_132[0];
            local_133 = u32(_e591);
            let _e595 = local_132[1];
            local_134 = u32(_e595);
            let _e598 = local_134;
            out[_e598] = (_e575 + 1i);
            break;
        }
        default: {
            let _e601 = local;
            local_47 = _e601;
            local_48 = u32(21i);
            let _e606 = local_47;
            local_135 = _e606;
            let _e607 = local_48;
            let _e609 = local_135[1];
            local_135[1] = (_e609 + _e607);
            let _e613 = local_135[0];
            local_136 = u32(_e613);
            let _e617 = local_135[1];
            local_137 = u32(_e617);
            let _e621 = local_137;
            out[_e621] = 99i;
            break;
        }
    }
    let _e623 = counter;
    let _e625 = local;
    local_49 = _e625;
    local_50 = u32(23i);
    let _e630 = local_49;
    local_138 = _e630;
    let _e631 = local_50;
    let _e633 = local_138[1];
    local_138[1] = (_e633 + _e631);
    let _e637 = local_138[0];
    local_139 = u32(_e637);
    let _e641 = local_138[1];
    local_140 = u32(_e641);
    let _e644 = local_140;
    out[_e644] = _e623;
    let _e648 = call_results(0i, 0i);
    first = _e648;
    let _e651 = first.y;
    let _e653 = call_results(1i, _e651);
    second = _e653;
    let _e656 = second.y;
    let _e658 = call_results(8i, _e656);
    third = _e658;
    let _e661 = first.x;
    let _e663 = local;
    local_51 = _e663;
    local_52 = u32(24i);
    let _e668 = local_51;
    local_141 = _e668;
    let _e669 = local_52;
    let _e671 = local_141[1];
    local_141[1] = (_e671 + _e669);
    let _e675 = local_141[0];
    local_142 = u32(_e675);
    let _e679 = local_141[1];
    local_143 = u32(_e679);
    let _e682 = local_143;
    out[_e682] = _e661;
    let _e685 = second.x;
    let _e687 = local;
    local_53 = _e687;
    local_54 = u32(25i);
    let _e692 = local_53;
    local_144 = _e692;
    let _e693 = local_54;
    let _e695 = local_144[1];
    local_144[1] = (_e695 + _e693);
    let _e699 = local_144[0];
    local_145 = u32(_e699);
    let _e703 = local_144[1];
    local_146 = u32(_e703);
    let _e706 = local_146;
    out[_e706] = _e685;
    let _e709 = third.x;
    let _e711 = local;
    local_55 = _e711;
    local_56 = u32(26i);
    let _e716 = local_55;
    local_147 = _e716;
    let _e717 = local_56;
    let _e719 = local_147[1];
    local_147[1] = (_e719 + _e717);
    let _e723 = local_147[0];
    local_148 = u32(_e723);
    let _e727 = local_147[1];
    local_149 = u32(_e727);
    let _e730 = local_149;
    out[_e730] = _e709;
    let _e733 = third.y;
    let _e735 = local;
    local_57 = _e735;
    local_58 = u32(27i);
    let _e740 = local_57;
    local_150 = _e740;
    let _e741 = local_58;
    let _e743 = local_150[1];
    local_150[1] = (_e743 + _e741);
    let _e747 = local_150[0];
    local_151 = u32(_e747);
    let _e751 = local_150[1];
    local_152 = u32(_e751);
    let _e754 = local_152;
    out[_e754] = _e733;
    let _e757 = third.y;
    counter = _e757;
    let _e759 = third.x;
    let _e760 = counter;
    counter = (_e760 + 1i);
    let _e763 = counter;
    let _e764 = update_value(_e759, _e763);
    let _e766 = local;
    local_59 = _e766;
    local_60 = u32(28i);
    let _e771 = local_59;
    local_153 = _e771;
    let _e772 = local_60;
    let _e774 = local_153[1];
    local_153[1] = (_e774 + _e772);
    let _e778 = local_153[0];
    local_154 = u32(_e778);
    let _e782 = local_153[1];
    local_155 = u32(_e782);
    let _e785 = local_155;
    out[_e785] = _e764;
    let _e787 = counter;
    let _e789 = local;
    local_61 = _e789;
    local_62 = u32(29i);
    let _e794 = local_61;
    local_156 = _e794;
    let _e795 = local_62;
    let _e797 = local_156[1];
    local_156[1] = (_e797 + _e795);
    let _e801 = local_156[0];
    local_157 = u32(_e801);
    let _e805 = local_156[1];
    local_158 = u32(_e805);
    let _e808 = local_158;
    out[_e808] = _e787;
}
