@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;

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
    var out: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var counter: i32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var first: vec2<i32>;
    var second: vec2<i32>;
    var third: vec2<i32>;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: array<u32, 2>;
    var local_59: u32;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: u32;
    var local_70: u32;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: u32;
    var local_74: array<u32, 2>;
    var local_75: u32;
    var local_76: u32;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: array<u32, 2>;
    var local_81: u32;
    var local_82: u32;
    var local_83: array<u32, 2>;
    var local_84: u32;
    var local_85: u32;
    var local_86: array<u32, 2>;
    var local_87: u32;
    var local_88: u32;
    var local_89: array<u32, 2>;
    var local_90: u32;
    var local_91: u32;
    var local_92: array<u32, 2>;
    var local_93: u32;
    var local_94: u32;
    var local_95: array<u32, 2>;
    var local_96: u32;
    var local_97: u32;
    var local_98: array<u32, 2>;
    var local_99: u32;
    var local_100: u32;
    var local_101: array<u32, 2>;
    var local_102: u32;
    var local_103: u32;
    var local_104: array<u32, 2>;
    var local_105: u32;
    var local_106: u32;
    var local_107: array<u32, 2>;
    var local_108: u32;
    var local_109: u32;
    var local_110: array<u32, 2>;
    var local_111: u32;
    var local_112: u32;
    var local_113: array<u32, 2>;
    var local_114: u32;
    var local_115: u32;
    var local_116: array<u32, 2>;
    var local_117: u32;
    var local_118: u32;
    var local_119: array<u32, 2>;
    var local_120: u32;
    var local_121: u32;
    var local_122: array<u32, 2>;
    var local_123: u32;
    var local_124: u32;
    var local_125: array<u32, 2>;
    var local_126: u32;
    var local_127: u32;
    var local_128: array<u32, 2>;
    var local_129: u32;
    var local_130: u32;
    var local_131: array<u32, 2>;
    var local_132: u32;
    var local_133: u32;
    var local_134: array<u32, 2>;
    var local_135: u32;
    var local_136: u32;
    var local_137: array<u32, 2>;
    var local_138: u32;
    var local_139: u32;
    var local_140: array<u32, 2>;
    var local_141: u32;
    var local_142: u32;
    var local_143: array<u32, 2>;
    var local_144: u32;
    var local_145: u32;
    var local_146: array<u32, 2>;
    var local_147: u32;
    var local_148: u32;
    var local_149: array<u32, 2>;
    var local_150: u32;
    var local_151: u32;
    var local_152: array<u32, 2>;
    var local_153: u32;
    var local_154: u32;
    var local_155: array<u32, 2>;
    var local_156: u32;
    var local_157: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let _e9 = case_chain(-(1i));
    let _e12 = out;
    local = _e12;
    local_1 = u32(0i);
    let _e17 = local;
    local_62 = _e17;
    let _e18 = local_1;
    let _e20 = local_62[1];
    local_62[1] = (_e20 + _e18);
    let _e24 = local_62[0];
    local_63 = u32(_e24);
    let _e28 = local_62[1];
    local_64 = u32(_e28);
    let _e31 = local_64;
    out_1[_e31] = _e9;
    let _e34 = case_chain(0i);
    let _e36 = out;
    local_2 = _e36;
    local_3 = u32(1i);
    let _e41 = local_2;
    local_65 = _e41;
    let _e42 = local_3;
    let _e44 = local_65[1];
    local_65[1] = (_e44 + _e42);
    let _e48 = local_65[0];
    local_66 = u32(_e48);
    let _e52 = local_65[1];
    local_67 = u32(_e52);
    let _e55 = local_67;
    out_1[_e55] = _e34;
    let _e58 = case_chain(1i);
    let _e60 = out;
    local_4 = _e60;
    local_5 = u32(2i);
    let _e65 = local_4;
    local_68 = _e65;
    let _e66 = local_5;
    let _e68 = local_68[1];
    local_68[1] = (_e68 + _e66);
    let _e72 = local_68[0];
    local_69 = u32(_e72);
    let _e76 = local_68[1];
    local_70 = u32(_e76);
    let _e79 = local_70;
    out_1[_e79] = _e58;
    let _e82 = case_chain(2i);
    let _e84 = out;
    local_6 = _e84;
    local_7 = u32(3i);
    let _e89 = local_6;
    local_71 = _e89;
    let _e90 = local_7;
    let _e92 = local_71[1];
    local_71[1] = (_e92 + _e90);
    let _e96 = local_71[0];
    local_72 = u32(_e96);
    let _e100 = local_71[1];
    local_73 = u32(_e100);
    let _e103 = local_73;
    out_1[_e103] = _e82;
    let _e106 = case_chain(8i);
    let _e108 = out;
    local_8 = _e108;
    local_9 = u32(4i);
    let _e113 = local_8;
    local_74 = _e113;
    let _e114 = local_9;
    let _e116 = local_74[1];
    local_74[1] = (_e116 + _e114);
    let _e120 = local_74[0];
    local_75 = u32(_e120);
    let _e124 = local_74[1];
    local_76 = u32(_e124);
    let _e127 = local_76;
    out_1[_e127] = _e106;
    let _e130 = grouped_labels(0u);
    let _e132 = out;
    local_10 = _e132;
    local_11 = u32(5i);
    let _e137 = local_10;
    local_77 = _e137;
    let _e138 = local_11;
    let _e140 = local_77[1];
    local_77[1] = (_e140 + _e138);
    let _e144 = local_77[0];
    local_78 = u32(_e144);
    let _e148 = local_77[1];
    local_79 = u32(_e148);
    let _e151 = local_79;
    out_1[_e151] = _e130;
    let _e154 = grouped_labels(1u);
    let _e156 = out;
    local_12 = _e156;
    local_13 = u32(6i);
    let _e161 = local_12;
    local_80 = _e161;
    let _e162 = local_13;
    let _e164 = local_80[1];
    local_80[1] = (_e164 + _e162);
    let _e168 = local_80[0];
    local_81 = u32(_e168);
    let _e172 = local_80[1];
    local_82 = u32(_e172);
    let _e175 = local_82;
    out_1[_e175] = _e154;
    let _e178 = grouped_labels(2u);
    let _e180 = out;
    local_14 = _e180;
    local_15 = u32(7i);
    let _e185 = local_14;
    local_83 = _e185;
    let _e186 = local_15;
    let _e188 = local_83[1];
    local_83[1] = (_e188 + _e186);
    let _e192 = local_83[0];
    local_84 = u32(_e192);
    let _e196 = local_83[1];
    local_85 = u32(_e196);
    let _e199 = local_85;
    out_1[_e199] = _e178;
    let _e202 = grouped_labels(8u);
    let _e204 = out;
    local_16 = _e204;
    local_17 = u32(8i);
    let _e209 = local_16;
    local_86 = _e209;
    let _e210 = local_17;
    let _e212 = local_86[1];
    local_86[1] = (_e212 + _e210);
    let _e216 = local_86[0];
    local_87 = u32(_e216);
    let _e220 = local_86[1];
    local_88 = u32(_e220);
    let _e223 = local_88;
    out_1[_e223] = _e202;
    let _e227 = nested_switches(0i, 0i);
    let _e229 = out;
    local_18 = _e229;
    local_19 = u32(9i);
    let _e234 = local_18;
    local_89 = _e234;
    let _e235 = local_19;
    let _e237 = local_89[1];
    local_89[1] = (_e237 + _e235);
    let _e241 = local_89[0];
    local_90 = u32(_e241);
    let _e245 = local_89[1];
    local_91 = u32(_e245);
    let _e248 = local_91;
    out_1[_e248] = _e227;
    let _e252 = nested_switches(0i, 8i);
    let _e254 = out;
    local_20 = _e254;
    local_21 = u32(10i);
    let _e259 = local_20;
    local_92 = _e259;
    let _e260 = local_21;
    let _e262 = local_92[1];
    local_92[1] = (_e262 + _e260);
    let _e266 = local_92[0];
    local_93 = u32(_e266);
    let _e270 = local_92[1];
    local_94 = u32(_e270);
    let _e273 = local_94;
    out_1[_e273] = _e252;
    let _e277 = nested_switches(1i, 0i);
    let _e279 = out;
    local_22 = _e279;
    local_23 = u32(11i);
    let _e284 = local_22;
    local_95 = _e284;
    let _e285 = local_23;
    let _e287 = local_95[1];
    local_95[1] = (_e287 + _e285);
    let _e291 = local_95[0];
    local_96 = u32(_e291);
    let _e295 = local_95[1];
    local_97 = u32(_e295);
    let _e298 = local_97;
    out_1[_e298] = _e277;
    let _e302 = nested_switches(8i, 0i);
    let _e304 = out;
    local_24 = _e304;
    local_25 = u32(12i);
    let _e309 = local_24;
    local_98 = _e309;
    let _e310 = local_25;
    let _e312 = local_98[1];
    local_98[1] = (_e312 + _e310);
    let _e316 = local_98[0];
    local_99 = u32(_e316);
    let _e320 = local_98[1];
    local_100 = u32(_e320);
    let _e323 = local_100;
    out_1[_e323] = _e302;
    let _e326 = loop_jumps(0i);
    let _e328 = out;
    local_26 = _e328;
    local_27 = u32(13i);
    let _e333 = local_26;
    local_101 = _e333;
    let _e334 = local_27;
    let _e336 = local_101[1];
    local_101[1] = (_e336 + _e334);
    let _e340 = local_101[0];
    local_102 = u32(_e340);
    let _e344 = local_101[1];
    local_103 = u32(_e344);
    let _e347 = local_103;
    out_1[_e347] = _e326;
    let _e350 = loop_jumps(1i);
    let _e352 = out;
    local_28 = _e352;
    local_29 = u32(14i);
    let _e357 = local_28;
    local_104 = _e357;
    let _e358 = local_29;
    let _e360 = local_104[1];
    local_104[1] = (_e360 + _e358);
    let _e364 = local_104[0];
    local_105 = u32(_e364);
    let _e368 = local_104[1];
    local_106 = u32(_e368);
    let _e371 = local_106;
    out_1[_e371] = _e350;
    let _e374 = loop_jumps(8i);
    let _e376 = out;
    local_30 = _e376;
    local_31 = u32(15i);
    let _e381 = local_30;
    local_107 = _e381;
    let _e382 = local_31;
    let _e384 = local_107[1];
    local_107[1] = (_e384 + _e382);
    let _e388 = local_107[0];
    local_108 = u32(_e388);
    let _e392 = local_107[1];
    local_109 = u32(_e392);
    let _e395 = local_109;
    out_1[_e395] = _e374;
    let _e399 = terminal_paths(0i, 1i);
    let _e401 = out;
    local_32 = _e401;
    local_33 = u32(16i);
    let _e406 = local_32;
    local_110 = _e406;
    let _e407 = local_33;
    let _e409 = local_110[1];
    local_110[1] = (_e409 + _e407);
    let _e413 = local_110[0];
    local_111 = u32(_e413);
    let _e417 = local_110[1];
    local_112 = u32(_e417);
    let _e420 = local_112;
    out_1[_e420] = _e399;
    let _e424 = terminal_paths(0i, 0i);
    let _e426 = out;
    local_34 = _e426;
    local_35 = u32(17i);
    let _e431 = local_34;
    local_113 = _e431;
    let _e432 = local_35;
    let _e434 = local_113[1];
    local_113[1] = (_e434 + _e432);
    let _e438 = local_113[0];
    local_114 = u32(_e438);
    let _e442 = local_113[1];
    local_115 = u32(_e442);
    let _e445 = local_115;
    out_1[_e445] = _e424;
    let _e449 = terminal_paths(1i, 1i);
    let _e451 = out;
    local_36 = _e451;
    local_37 = u32(18i);
    let _e456 = local_36;
    local_116 = _e456;
    let _e457 = local_37;
    let _e459 = local_116[1];
    local_116[1] = (_e459 + _e457);
    let _e463 = local_116[0];
    local_117 = u32(_e463);
    let _e467 = local_116[1];
    local_118 = u32(_e467);
    let _e470 = local_118;
    out_1[_e470] = _e449;
    let _e474 = terminal_paths(8i, 0i);
    let _e476 = out;
    local_38 = _e476;
    local_39 = u32(19i);
    let _e481 = local_38;
    local_119 = _e481;
    let _e482 = local_39;
    let _e484 = local_119[1];
    local_119[1] = (_e484 + _e482);
    let _e488 = local_119[0];
    local_120 = u32(_e488);
    let _e492 = local_119[1];
    local_121 = u32(_e492);
    let _e495 = local_121;
    out_1[_e495] = _e474;
    let _e499 = terminal_paths(2i, 0i);
    let _e501 = out;
    local_40 = _e501;
    local_41 = u32(20i);
    let _e506 = local_40;
    local_122 = _e506;
    let _e507 = local_41;
    let _e509 = local_122[1];
    local_122[1] = (_e509 + _e507);
    let _e513 = local_122[0];
    local_123 = u32(_e513);
    let _e517 = local_122[1];
    local_124 = u32(_e517);
    let _e520 = local_124;
    out_1[_e520] = _e499;
    counter = 0i;
    let _e524 = counter;
    counter = (_e524 + 1i);
    switch _e524 {
        case 0: {
            let _e527 = counter;
            let _e529 = out;
            local_42 = _e529;
            local_43 = u32(21i);
            let _e534 = local_42;
            local_125 = _e534;
            let _e535 = local_43;
            let _e537 = local_125[1];
            local_125[1] = (_e537 + _e535);
            let _e541 = local_125[0];
            local_126 = u32(_e541);
            let _e545 = local_125[1];
            local_127 = u32(_e545);
            let _e548 = local_127;
            out_1[_e548] = _e527;
            let _e550 = counter;
            let _e554 = out;
            local_44 = _e554;
            local_45 = u32(22i);
            let _e559 = local_44;
            local_128 = _e559;
            let _e560 = local_45;
            let _e562 = local_128[1];
            local_128[1] = (_e562 + _e560);
            let _e566 = local_128[0];
            local_129 = u32(_e566);
            let _e570 = local_128[1];
            local_130 = u32(_e570);
            let _e573 = local_130;
            out_1[_e573] = (_e550 + 1i);
            break;
        }
        case 1: {
            let _e575 = counter;
            let _e579 = out;
            local_44 = _e579;
            local_45 = u32(22i);
            let _e584 = local_44;
            local_131 = _e584;
            let _e585 = local_45;
            let _e587 = local_131[1];
            local_131[1] = (_e587 + _e585);
            let _e591 = local_131[0];
            local_132 = u32(_e591);
            let _e595 = local_131[1];
            local_133 = u32(_e595);
            let _e598 = local_133;
            out_1[_e598] = (_e575 + 1i);
            break;
        }
        default: {
            let _e601 = out;
            local_46 = _e601;
            local_47 = u32(21i);
            let _e606 = local_46;
            local_134 = _e606;
            let _e607 = local_47;
            let _e609 = local_134[1];
            local_134[1] = (_e609 + _e607);
            let _e613 = local_134[0];
            local_135 = u32(_e613);
            let _e617 = local_134[1];
            local_136 = u32(_e617);
            let _e621 = local_136;
            out_1[_e621] = 99i;
            break;
        }
    }
    let _e623 = counter;
    let _e625 = out;
    local_48 = _e625;
    local_49 = u32(23i);
    let _e630 = local_48;
    local_137 = _e630;
    let _e631 = local_49;
    let _e633 = local_137[1];
    local_137[1] = (_e633 + _e631);
    let _e637 = local_137[0];
    local_138 = u32(_e637);
    let _e641 = local_137[1];
    local_139 = u32(_e641);
    let _e644 = local_139;
    out_1[_e644] = _e623;
    let _e648 = call_results(0i, 0i);
    first = _e648;
    let _e651 = first.y;
    let _e653 = call_results(1i, _e651);
    second = _e653;
    let _e656 = second.y;
    let _e658 = call_results(8i, _e656);
    third = _e658;
    let _e661 = first.x;
    let _e663 = out;
    local_50 = _e663;
    local_51 = u32(24i);
    let _e668 = local_50;
    local_140 = _e668;
    let _e669 = local_51;
    let _e671 = local_140[1];
    local_140[1] = (_e671 + _e669);
    let _e675 = local_140[0];
    local_141 = u32(_e675);
    let _e679 = local_140[1];
    local_142 = u32(_e679);
    let _e682 = local_142;
    out_1[_e682] = _e661;
    let _e685 = second.x;
    let _e687 = out;
    local_52 = _e687;
    local_53 = u32(25i);
    let _e692 = local_52;
    local_143 = _e692;
    let _e693 = local_53;
    let _e695 = local_143[1];
    local_143[1] = (_e695 + _e693);
    let _e699 = local_143[0];
    local_144 = u32(_e699);
    let _e703 = local_143[1];
    local_145 = u32(_e703);
    let _e706 = local_145;
    out_1[_e706] = _e685;
    let _e709 = third.x;
    let _e711 = out;
    local_54 = _e711;
    local_55 = u32(26i);
    let _e716 = local_54;
    local_146 = _e716;
    let _e717 = local_55;
    let _e719 = local_146[1];
    local_146[1] = (_e719 + _e717);
    let _e723 = local_146[0];
    local_147 = u32(_e723);
    let _e727 = local_146[1];
    local_148 = u32(_e727);
    let _e730 = local_148;
    out_1[_e730] = _e709;
    let _e733 = third.y;
    let _e735 = out;
    local_56 = _e735;
    local_57 = u32(27i);
    let _e740 = local_56;
    local_149 = _e740;
    let _e741 = local_57;
    let _e743 = local_149[1];
    local_149[1] = (_e743 + _e741);
    let _e747 = local_149[0];
    local_150 = u32(_e747);
    let _e751 = local_149[1];
    local_151 = u32(_e751);
    let _e754 = local_151;
    out_1[_e754] = _e733;
    let _e757 = third.y;
    counter = _e757;
    let _e759 = third.x;
    let _e760 = counter;
    counter = (_e760 + 1i);
    let _e763 = counter;
    let _e764 = update_value(_e759, _e763);
    let _e766 = out;
    local_58 = _e766;
    local_59 = u32(28i);
    let _e771 = local_58;
    local_152 = _e771;
    let _e772 = local_59;
    let _e774 = local_152[1];
    local_152[1] = (_e774 + _e772);
    let _e778 = local_152[0];
    local_153 = u32(_e778);
    let _e782 = local_152[1];
    local_154 = u32(_e782);
    let _e785 = local_154;
    out_1[_e785] = _e764;
    let _e787 = counter;
    let _e789 = out;
    local_60 = _e789;
    local_61 = u32(29i);
    let _e794 = local_60;
    local_155 = _e794;
    let _e795 = local_61;
    let _e797 = local_155[1];
    local_155[1] = (_e797 + _e795);
    let _e801 = local_155[0];
    local_156 = u32(_e801);
    let _e805 = local_155[1];
    local_157 = u32(_e805);
    let _e808 = local_157;
    out_1[_e808] = _e787;
}
