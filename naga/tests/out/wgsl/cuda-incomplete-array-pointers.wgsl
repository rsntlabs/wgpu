struct type_6 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input_1: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output_1: array<i32>;
@group(0) @binding(2)
var<uniform> count: type_6;

@compute @workgroup_size(4, 1, 1)
fn incomplete_array_pointers(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var input: array<u32, 3>;
    var output: array<u32, 3>;
    var local: array<u32, 3>;
    var small: array<i32, 3>;
    var large: array<i32, 5>;
    var view: array<u32, 3>;
    var local_1: array<u32, 3>;
    var local_2: array<u32, 3>;
    var snapshot: array<u32, 3>;
    var local_3: array<u32, 3>;
    var large_view: array<u32, 3>;
    var local_4: array<u32, 3>;
    var local_5: u32;
    var local_6: u32;
    var local_7: array<u32, 3>;
    var selected: array<u32, 3>;
    var local_8: array<u32, 3>;
    var nullable: array<u32, 3>;
    var local_9: array<u32, 3>;
    var optional: i32;
    var local_10: array<u32, 3>;
    var local_11: bool;
    var local_12: array<u32, 3>;
    var local_13: i32;
    var local_14: array<u32, 3>;
    var roundtrip: array<u32, 3>;
    var pairs: array<array<i32, 2>, 2>;
    var local_15: u32;
    var row: array<u32, 3>;
    var local_16: array<u32, 3>;
    var row_view: array<u32, 3>;
    var local_17: array<u32, 3>;
    var local_18: array<u32, 3>;
    var local_19: array<u32, 3>;
    var elements: array<u32, 3>;
    var local_20: array<u32, 3>;
    var phase: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: array<u32, 3>;
    var local_24: array<u32, 3>;
    var local_25: array<u32, 3>;
    var local_26: u32;
    var local_27: array<u32, 3>;
    var local_28: u32;
    var local_29: array<u32, 3>;
    var local_30: array<u32, 3>;
    var local_31: u32;
    var local_32: array<u32, 3>;
    var local_33: array<u32, 3>;
    var local_34: u32;
    var local_35: array<u32, 3>;
    var local_36: array<u32, 3>;
    var local_37: u32;
    var local_38: array<u32, 3>;
    var local_39: u32;
    var local_40: array<u32, 3>;
    var local_41: array<u32, 3>;
    var local_42: u32;
    var local_43: array<u32, 3>;
    var local_44: bool;
    var local_45: array<u32, 3>;
    var local_46: u32;
    var local_47: array<u32, 3>;
    var local_48: u32;
    var local_49: array<u32, 3>;
    var local_50: u32;
    var local_51: array<u32, 3>;
    var local_52: array<u32, 3>;
    var local_53: u32;
    var local_54: array<u32, 3>;
    var view_1: array<u32, 3>;
    var index: u32;
    var local_55: array<u32, 3>;
    var local_56: u32;
    var local_57: i32;
    var view_2: array<u32, 3>;
    var index_1: u32;
    var local_58: array<u32, 3>;
    var local_59: u32;
    var local_60: i32;
    var local_61: u32;
    var view_3: array<u32, 3>;
    var index_2: u32;
    var local_62: array<u32, 3>;
    var local_63: u32;
    var local_64: i32;
    var local_65: i32;
    var view_4: array<u32, 3>;
    var index_3: u32;
    var local_66: array<u32, 3>;
    var local_67: u32;
    var local_68: i32;
    var view_5: array<u32, 3>;
    var index_4: u32;
    var local_69: array<u32, 3>;
    var local_70: u32;
    var local_71: i32;
    var local_72: u32;
    var view_6: array<u32, 3>;
    var index_5: u32;
    var local_73: array<u32, 3>;
    var local_74: u32;
    var local_75: i32;
    var view_7: array<u32, 3>;
    var index_6: u32;
    var local_76: array<u32, 3>;
    var local_77: u32;
    var local_78: i32;
    var view_8: array<u32, 3>;
    var index_7: u32;
    var local_79: array<u32, 3>;
    var local_80: u32;
    var local_81: i32;
    var view_9: array<u32, 3>;
    var index_8: u32;
    var local_82: array<u32, 3>;
    var local_83: u32;
    var local_84: i32;
    var view_10: array<u32, 3>;
    var index_9: u32;
    var local_85: array<u32, 3>;
    var local_86: u32;
    var local_87: i32;
    var local_88: array<u32, 3>;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: array<u32, 3>;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: i32;
    var local_97: array<u32, 3>;
    var local_98: array<u32, 3>;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: i32;
    var local_103: u32;
    var local_104: array<u32, 3>;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: i32;
    var local_109: array<u32, 3>;
    var local_110: array<u32, 3>;
    var local_111: array<u32, 3>;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: i32;
    var local_116: array<u32, 3>;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: array<u32, 3>;
    var local_121: u32;
    var local_122: u32;
    var local_123: u32;
    var local_124: array<u32, 3>;
    var local_125: u32;
    var local_126: u32;
    var local_127: u32;
    var local_128: array<u32, 3>;
    var local_129: u32;
    var local_130: u32;
    var local_131: u32;
    var local_132: u32;
    var local_133: array<u32, 3>;
    var local_134: array<u32, 3>;
    var local_135: u32;
    var local_136: u32;
    var local_137: u32;
    var local_138: array<u32, 3>;
    var local_139: u32;
    var local_140: u32;
    var local_141: u32;
    var local_142: array<u32, 3>;
    var local_143: u32;
    var local_144: u32;
    var local_145: u32;
    var local_146: i32;
    var local_147: array<u32, 3>;
    var local_148: u32;
    var local_149: u32;
    var local_150: u32;
    var local_151: array<u32, 3>;
    var local_152: u32;
    var local_153: u32;
    var local_154: u32;
    var local_155: i32;
    var local_156: array<u32, 3>;
    var local_157: u32;
    var local_158: u32;
    var local_159: u32;
    var local_160: array<u32, 3>;
    var local_161: u32;
    var local_162: u32;
    var local_163: u32;
    var local_164: i32;
    var local_165: array<u32, 3>;
    var local_166: u32;
    var local_167: u32;
    var local_168: u32;
    var local_169: array<u32, 3>;
    var local_170: u32;
    var local_171: u32;
    var local_172: u32;
    var local_173: array<u32, 3>;
    var local_174: u32;
    var local_175: u32;
    var local_176: u32;
    var local_177: i32;
    var local_178: array<u32, 3>;
    var local_179: u32;
    var local_180: u32;
    var local_181: u32;
    var local_182: array<u32, 3>;
    var local_183: array<u32, 3>;
    var local_184: u32;
    var local_185: u32;
    var local_186: u32;
    var local_187: array<u32, 3>;
    var local_188: u32;
    var local_189: u32;
    var local_190: u32;
    var local_191: array<u32, 3>;
    var local_192: u32;
    var local_193: u32;
    var local_194: u32;
    var local_195: array<u32, 3>;
    var local_196: u32;
    var local_197: u32;
    var local_198: u32;
    var local_199: array<u32, 3>;
    var local_200: u32;
    var local_201: u32;
    var local_202: u32;
    var local_203: array<u32, 3>;
    var local_204: u32;
    var local_205: u32;
    var local_206: u32;
    var local_207: i32;
    var local_208: array<u32, 3>;
    var local_209: u32;
    var local_210: u32;
    var local_211: u32;

    input = array<u32, 3>();
    input[0] = 2u;
    input[1] = 0u;
    output = array<u32, 3>();
    output[0] = 3u;
    output[1] = 0u;
    let count_1 = count.value;
    let index_10 = ((blockIdx.x * 4u) + threadIdx.x);
    if (index_10 >= count_1) {
        return;
    }
    let _e24 = input;
    local = _e24;
    let _e26 = local;
    local_88 = _e26;
    let _e29 = local_88[0];
    local_89 = u32(_e29);
    let _e33 = local_88[1];
    local_90 = u32(_e33);
    let _e37 = local_88[2];
    local_91 = u32(_e37);
    let _e42 = input_1[index_10];
    let value = (_e42 & 255i);
    small[0] = value;
    small[1] = (value + 1i);
    small[2] = (value + 2i);
    large[0] = (value + 3i);
    large[1] = (value + 4i);
    large[2] = (value + 5i);
    large[3] = (value + 6i);
    large[4] = (value + 7i);
    view = array<u32, 3>();
    view[0] = 4u;
    view[1] = 0u;
    let _e76 = view;
    local_1 = _e76;
    index = u32();
    local_56 = u32();
    local_57 = i32();
    let _e86 = local_1;
    view_1 = _e86;
    index = u32(1i);
    let _e90 = view_1;
    local_55 = _e90;
    let _e92 = index;
    local_56 = _e92;
    let _e94 = local_55;
    local_92 = _e94;
    let _e97 = local_92[0];
    local_93 = u32(_e97);
    let _e101 = local_92[1];
    local_94 = u32(_e101);
    let _e105 = local_92[2];
    local_95 = u32(_e105);
    let _e108 = local_93;
    switch _e108 {
        case 4u: {
            let _e109 = local_56;
            let _e111 = small[_e109];
            local_96 = _e111;
        }
        default: {
            let _e113 = local_56;
            let _e115 = large[_e113];
            local_96 = _e115;
        }
    }
    let _e118 = local_96;
    local_57 = _e118;
    let before = local_57;
    let _e121 = view;
    local_2 = _e121;
    let _e123 = local_2;
    snapshot = _e123;
    local_97 = array<u32, 3>();
    local_97[0] = 5u;
    local_97[1] = 0u;
    let _e131 = local_97;
    view = _e131;
    let _e132 = view;
    local_3 = _e132;
    let _e134 = local_3;
    large_view = _e134;
    let _e136 = view;
    local_4 = _e136;
    index_1 = u32();
    local_59 = u32();
    local_60 = i32();
    let _e146 = local_4;
    view_2 = _e146;
    index_1 = u32(3i);
    let _e150 = view_2;
    local_58 = _e150;
    let _e152 = index_1;
    local_59 = _e152;
    let _e154 = local_58;
    local_98 = _e154;
    let _e157 = local_98[0];
    local_99 = u32(_e157);
    let _e161 = local_98[1];
    local_100 = u32(_e161);
    let _e165 = local_98[2];
    local_101 = u32(_e165);
    let _e168 = local_99;
    switch _e168 {
        case 4u: {
            let _e169 = local_59;
            let _e171 = small[_e169];
            local_102 = _e171;
        }
        default: {
            let _e173 = local_59;
            let _e175 = large[_e173];
            local_102 = _e175;
        }
    }
    let _e178 = local_102;
    local_60 = _e178;
    let after = local_60;
    if ((index_10 & 1u) == 0u) {
        local_6 = 6u;
        local_5 = 1u;
    } else {
        local_6 = 5u;
        local_5 = 0u;
    }
    let _e194 = local_6;
    switch _e194 {
        case 5u: {
            local_61 = 5u;
        }
        default: {
            local_61 = 11u;
        }
    }
    let _e200 = local_61;
    switch _e200 {
        case 5u: {
            local_103 = 5u;
        }
        default: {
            local_103 = 13u;
        }
    }
    let _e206 = local_103;
    switch _e206 {
        case 5u: {
            let _e207 = view;
            local_7 = _e207;
        }
        default: {
            let _e210 = snapshot;
            local_7 = _e210;
        }
    }
    let _e213 = local_7;
    selected = _e213;
    let _e216 = selected;
    local_8 = _e216;
    let _e219 = u32(1i);
    let _e220 = local_8;
    local_104 = _e220;
    let _e223 = local_104[0];
    local_105 = u32(_e223);
    let _e227 = local_104[1];
    local_106 = u32(_e227);
    let _e231 = local_104[2];
    local_107 = u32(_e231);
    let _e234 = local_105;
    switch _e234 {
        case 4u: {
            let _e236 = small[_e219];
            local_108 = _e236;
        }
        default: {
            let _e239 = large[_e219];
            local_108 = _e239;
        }
    }
    let _e242 = local_108;
    let _e244 = (_e242 + 7i);
    let _e245 = local_105;
    switch _e245 {
        case 4u: {
            small[_e219] = _e244;
        }
        default: {
            large[_e219] = _e244;
        }
    }
    nullable = array<u32, 3>();
    nullable[0] = 1u;
    if ((index_10 % 3u) != 0u) {
        let _e256 = selected;
        local_9 = _e256;
        let _e258 = local_9;
        local_109 = _e258;
        let _e260 = local_109;
        nullable = _e260;
    }
    optional = -(1i);
    let _e266 = nullable;
    local_10 = _e266;
    let _e268 = local_10;
    local_110 = _e268;
    let _e271 = local_110[0];
    local_11 = (_e271 != 1u);
    let _e275 = local_11;
    if _e275 {
        let _e276 = nullable;
        local_12 = _e276;
        index_2 = u32();
        local_63 = u32();
        local_64 = i32();
        let _e286 = local_12;
        view_3 = _e286;
        index_2 = u32(0i);
        let _e290 = view_3;
        local_62 = _e290;
        let _e292 = index_2;
        local_63 = _e292;
        let _e294 = local_62;
        local_111 = _e294;
        let _e297 = local_111[0];
        local_112 = u32(_e297);
        let _e301 = local_111[1];
        local_113 = u32(_e301);
        let _e305 = local_111[2];
        local_114 = u32(_e305);
        local_115 = i32();
        let _e310 = local_112;
        switch _e310 {
            case 4u: {
                let _e311 = local_63;
                let _e313 = small[_e311];
                local_115 = _e313;
            }
            case 5u: {
                let _e314 = local_63;
                let _e316 = large[_e314];
                local_115 = _e316;
            }
            default: {
            }
        }
        let _e317 = local_115;
        local_65 = _e317;
        let _e319 = local_65;
        local_64 = _e319;
        let _e321 = local_64;
        local_13 = _e321;
        let _e323 = local_13;
        optional = _e323;
    }
    let _e324 = selected;
    local_14 = _e324;
    let _e326 = local_14;
    roundtrip = _e326;
    pairs[0][0] = (value + 8i);
    pairs[0][1] = (value + 9i);
    pairs[1][0] = (value + 10i);
    pairs[1][1] = (value + 11i);
    local_15 = u32(1i);
    row = array<u32, 3>();
    row[0] = 6u;
    row[1] = 0u;
    let _e352 = local_15;
    let _e354 = row[1];
    row[1] = (_e354 + _e352);
    let _e358 = row;
    local_16 = _e358;
    let _e360 = local_16;
    row_view = _e360;
    let _e363 = row_view;
    local_17 = _e363;
    index_3 = u32();
    local_67 = u32();
    local_68 = i32();
    let _e373 = local_17;
    view_4 = _e373;
    index_3 = u32(0i);
    let _e377 = view_4;
    local_66 = _e377;
    let _e379 = index_3;
    local_67 = _e379;
    let _e381 = local_66;
    local_116 = _e381;
    let _e384 = local_116[0];
    local_117 = u32(_e384);
    let _e388 = local_116[1];
    local_118 = u32(_e388);
    let _e392 = local_116[2];
    local_119 = u32(_e392);
    let _e395 = local_118;
    let _e397 = local_67;
    let _e399 = pairs[_e395][_e397];
    local_68 = _e399;
    let row_first = local_68;
    let _e402 = row_view;
    local_18 = _e402;
    index_4 = u32();
    local_70 = u32();
    local_71 = i32();
    let _e412 = local_18;
    view_5 = _e412;
    index_4 = u32(1i);
    let _e416 = view_5;
    local_69 = _e416;
    let _e418 = index_4;
    local_70 = _e418;
    let _e420 = local_69;
    local_120 = _e420;
    let _e423 = local_120[0];
    local_121 = u32(_e423);
    let _e427 = local_120[1];
    local_122 = u32(_e427);
    let _e431 = local_120[2];
    local_123 = u32(_e431);
    let _e434 = local_122;
    let _e436 = local_70;
    let _e438 = pairs[_e434][_e436];
    local_71 = _e438;
    let row_second = local_71;
    let _e441 = row_view;
    local_19 = _e441;
    let _e443 = local_19;
    local_124 = _e443;
    let _e446 = local_124[0];
    local_125 = u32(_e446);
    let _e450 = local_124[1];
    local_126 = u32(_e450);
    let _e454 = local_124[2];
    local_127 = u32(_e454);
    elements = array<u32, 3>();
    elements[0] = 7u;
    elements[1] = 0u;
    let _e463 = local_126;
    elements[2] = _e463;
    let _e467 = elements[1];
    elements[1] = (_e467 + 1u);
    let _e471 = elements;
    local_20 = _e471;
    let _e473 = local_20;
    local_128 = _e473;
    let _e476 = local_128[0];
    local_129 = u32(_e476);
    let _e480 = local_128[1];
    local_130 = u32(_e480);
    let _e484 = local_128[2];
    local_131 = u32(_e484);
    let _e487 = local_131;
    let _e489 = local_130;
    let _e491 = pairs[_e487][_e489];
    let _e494 = local_131;
    let _e496 = local_130;
    pairs[_e494][_e496] = (_e491 + 1i);
    {
        phase = u32(0i);
        loop {
            let _e501 = phase;
            if (_e501 < 3u) {
            } else {
                break;
            }
            let _e504 = phase;
            if ((_e504 & 1u) == 0u) {
                local_22 = 6u;
                local_21 = 1u;
            } else {
                local_22 = 8u;
                local_21 = 0u;
            }
            let _e518 = local_22;
            switch _e518 {
                case 6u: {
                    local_72 = 11u;
                }
                default: {
                    local_72 = 27u;
                }
            }
            let _e524 = local_72;
            switch _e524 {
                case 11u: {
                    local_132 = 13u;
                }
                default: {
                    local_132 = 32u;
                }
            }
            let _e530 = local_132;
            switch _e530 {
                case 13u: {
                    let _e532 = snapshot;
                    local_23 = _e532;
                }
                default: {
                    let _e535 = large_view;
                    local_23 = _e535;
                }
            }
            let _e538 = local_23;
            local_133 = _e538;
            let _e540 = local_133;
            view = _e540;
            continuing {
                let _e541 = phase;
                phase = (_e541 + u32(1i));
            }
        }
    }
    let base = ((index_10 + 1u) * 12u);
    let _e550 = output;
    local_24 = _e550;
    let _e552 = local_24;
    local_134 = _e552;
    let _e555 = local_134[0];
    local_135 = u32(_e555);
    let _e559 = local_134[1];
    local_136 = u32(_e559);
    let _e563 = local_134[2];
    local_137 = u32(_e563);
    output_1[base] = before;
    let _e568 = output;
    local_25 = _e568;
    local_26 = u32((base + 1u));
    let _e574 = local_25;
    local_138 = _e574;
    let _e577 = local_138[0];
    local_139 = u32(_e577);
    let _e581 = local_138[1];
    local_140 = u32(_e581);
    let _e585 = local_138[2];
    local_141 = u32(_e585);
    let _e588 = local_26;
    output_1[_e588] = after;
    let _e591 = snapshot;
    local_29 = _e591;
    index_5 = u32();
    local_74 = u32();
    local_75 = i32();
    let _e601 = local_29;
    view_6 = _e601;
    index_5 = u32(1i);
    let _e605 = view_6;
    local_73 = _e605;
    let _e607 = index_5;
    local_74 = _e607;
    let _e609 = local_73;
    local_142 = _e609;
    let _e612 = local_142[0];
    local_143 = u32(_e612);
    let _e616 = local_142[1];
    local_144 = u32(_e616);
    let _e620 = local_142[2];
    local_145 = u32(_e620);
    let _e623 = local_143;
    switch _e623 {
        case 4u: {
            let _e624 = local_74;
            let _e626 = small[_e624];
            local_146 = _e626;
        }
        default: {
            let _e628 = local_74;
            let _e630 = large[_e628];
            local_146 = _e630;
        }
    }
    let _e633 = local_146;
    local_75 = _e633;
    let _e635 = local_75;
    let _e636 = output;
    local_27 = _e636;
    local_28 = u32((base + 2u));
    let _e642 = local_27;
    local_147 = _e642;
    let _e645 = local_147[0];
    local_148 = u32(_e645);
    let _e649 = local_147[1];
    local_149 = u32(_e649);
    let _e653 = local_147[2];
    local_150 = u32(_e653);
    let _e656 = local_28;
    output_1[_e656] = _e635;
    let _e659 = large_view;
    local_32 = _e659;
    index_6 = u32();
    local_77 = u32();
    local_78 = i32();
    let _e669 = local_32;
    view_7 = _e669;
    index_6 = u32(1i);
    let _e673 = view_7;
    local_76 = _e673;
    let _e675 = index_6;
    local_77 = _e675;
    let _e677 = local_76;
    local_151 = _e677;
    let _e680 = local_151[0];
    local_152 = u32(_e680);
    let _e684 = local_151[1];
    local_153 = u32(_e684);
    let _e688 = local_151[2];
    local_154 = u32(_e688);
    let _e691 = local_152;
    switch _e691 {
        case 4u: {
            let _e692 = local_77;
            let _e694 = small[_e692];
            local_155 = _e694;
        }
        default: {
            let _e696 = local_77;
            let _e698 = large[_e696];
            local_155 = _e698;
        }
    }
    let _e701 = local_155;
    local_78 = _e701;
    let _e703 = local_78;
    let _e704 = output;
    local_30 = _e704;
    local_31 = u32((base + 3u));
    let _e710 = local_30;
    local_156 = _e710;
    let _e713 = local_156[0];
    local_157 = u32(_e713);
    let _e717 = local_156[1];
    local_158 = u32(_e717);
    let _e721 = local_156[2];
    local_159 = u32(_e721);
    let _e724 = local_31;
    output_1[_e724] = _e703;
    let _e726 = selected;
    local_35 = _e726;
    index_7 = u32();
    local_80 = u32();
    local_81 = i32();
    let _e736 = local_35;
    view_8 = _e736;
    index_7 = u32(1i);
    let _e740 = view_8;
    local_79 = _e740;
    let _e742 = index_7;
    local_80 = _e742;
    let _e744 = local_79;
    local_160 = _e744;
    let _e747 = local_160[0];
    local_161 = u32(_e747);
    let _e751 = local_160[1];
    local_162 = u32(_e751);
    let _e755 = local_160[2];
    local_163 = u32(_e755);
    let _e758 = local_161;
    switch _e758 {
        case 4u: {
            let _e759 = local_80;
            let _e761 = small[_e759];
            local_164 = _e761;
        }
        default: {
            let _e763 = local_80;
            let _e765 = large[_e763];
            local_164 = _e765;
        }
    }
    let _e768 = local_164;
    local_81 = _e768;
    let _e770 = local_81;
    let _e771 = output;
    local_33 = _e771;
    local_34 = u32((base + 4u));
    let _e777 = local_33;
    local_165 = _e777;
    let _e780 = local_165[0];
    local_166 = u32(_e780);
    let _e784 = local_165[1];
    local_167 = u32(_e784);
    let _e788 = local_165[2];
    local_168 = u32(_e788);
    let _e791 = local_34;
    output_1[_e791] = _e770;
    let _e793 = optional;
    let _e794 = output;
    local_36 = _e794;
    local_37 = u32((base + 5u));
    let _e800 = local_36;
    local_169 = _e800;
    let _e803 = local_169[0];
    local_170 = u32(_e803);
    let _e807 = local_169[1];
    local_171 = u32(_e807);
    let _e811 = local_169[2];
    local_172 = u32(_e811);
    let _e814 = local_37;
    output_1[_e814] = _e793;
    let _e817 = roundtrip;
    local_40 = _e817;
    index_8 = u32();
    local_83 = u32();
    local_84 = i32();
    let _e827 = local_40;
    view_9 = _e827;
    index_8 = u32(0i);
    let _e831 = view_9;
    local_82 = _e831;
    let _e833 = index_8;
    local_83 = _e833;
    let _e835 = local_82;
    local_173 = _e835;
    let _e838 = local_173[0];
    local_174 = u32(_e838);
    let _e842 = local_173[1];
    local_175 = u32(_e842);
    let _e846 = local_173[2];
    local_176 = u32(_e846);
    let _e849 = local_174;
    switch _e849 {
        case 4u: {
            let _e850 = local_83;
            let _e852 = small[_e850];
            local_177 = _e852;
        }
        default: {
            let _e854 = local_83;
            let _e856 = large[_e854];
            local_177 = _e856;
        }
    }
    let _e859 = local_177;
    local_84 = _e859;
    let _e861 = local_84;
    let _e862 = output;
    local_38 = _e862;
    local_39 = u32((base + 6u));
    let _e868 = local_38;
    local_178 = _e868;
    let _e871 = local_178[0];
    local_179 = u32(_e871);
    let _e875 = local_178[1];
    local_180 = u32(_e875);
    let _e879 = local_178[2];
    local_181 = u32(_e879);
    let _e882 = local_39;
    output_1[_e882] = _e861;
    let _e884 = nullable;
    local_43 = _e884;
    let _e886 = local_43;
    local_182 = _e886;
    let _e889 = local_182[0];
    local_44 = (_e889 != 1u);
    let _e893 = local_44;
    let _e894 = output;
    local_41 = _e894;
    local_42 = u32((base + 7u));
    let _e901 = local_41;
    local_183 = _e901;
    let _e904 = local_183[0];
    local_184 = u32(_e904);
    let _e908 = local_183[1];
    local_185 = u32(_e908);
    let _e912 = local_183[2];
    local_186 = u32(_e912);
    let _e915 = local_42;
    output_1[_e915] = i32(_e893);
    let _e917 = output;
    local_45 = _e917;
    local_46 = u32((base + 8u));
    let _e923 = local_45;
    local_187 = _e923;
    let _e926 = local_187[0];
    local_188 = u32(_e926);
    let _e930 = local_187[1];
    local_189 = u32(_e930);
    let _e934 = local_187[2];
    local_190 = u32(_e934);
    let _e937 = local_46;
    output_1[_e937] = row_first;
    let _e939 = output;
    local_47 = _e939;
    local_48 = u32((base + 9u));
    let _e945 = local_47;
    local_191 = _e945;
    let _e948 = local_191[0];
    local_192 = u32(_e948);
    let _e952 = local_191[1];
    local_193 = u32(_e952);
    let _e956 = local_191[2];
    local_194 = u32(_e956);
    let _e959 = local_48;
    output_1[_e959] = row_second;
    let _e961 = elements;
    local_51 = _e961;
    let _e963 = local_51;
    local_195 = _e963;
    let _e966 = local_195[0];
    local_196 = u32(_e966);
    let _e970 = local_195[1];
    local_197 = u32(_e970);
    let _e974 = local_195[2];
    local_198 = u32(_e974);
    let _e977 = local_198;
    let _e979 = local_197;
    let _e981 = pairs[_e977][_e979];
    let _e982 = output;
    local_49 = _e982;
    local_50 = u32((base + 10u));
    let _e988 = local_49;
    local_199 = _e988;
    let _e991 = local_199[0];
    local_200 = u32(_e991);
    let _e995 = local_199[1];
    local_201 = u32(_e995);
    let _e999 = local_199[2];
    local_202 = u32(_e999);
    let _e1002 = local_50;
    output_1[_e1002] = _e981;
    let _e1004 = view;
    local_54 = _e1004;
    index_9 = u32();
    local_86 = u32();
    local_87 = i32();
    let _e1014 = local_54;
    view_10 = _e1014;
    index_9 = u32(1i);
    let _e1018 = view_10;
    local_85 = _e1018;
    let _e1020 = index_9;
    local_86 = _e1020;
    let _e1022 = local_85;
    local_203 = _e1022;
    let _e1025 = local_203[0];
    local_204 = u32(_e1025);
    let _e1029 = local_203[1];
    local_205 = u32(_e1029);
    let _e1033 = local_203[2];
    local_206 = u32(_e1033);
    let _e1036 = local_204;
    switch _e1036 {
        case 4u: {
            let _e1037 = local_86;
            let _e1039 = small[_e1037];
            local_207 = _e1039;
        }
        default: {
            let _e1041 = local_86;
            let _e1043 = large[_e1041];
            local_207 = _e1043;
        }
    }
    let _e1046 = local_207;
    local_87 = _e1046;
    let _e1048 = local_87;
    let _e1049 = output;
    local_52 = _e1049;
    local_53 = u32((base + 11u));
    let _e1055 = local_52;
    local_208 = _e1055;
    let _e1058 = local_208[0];
    local_209 = u32(_e1058);
    let _e1062 = local_208[1];
    local_210 = u32(_e1062);
    let _e1066 = local_208[2];
    local_211 = u32(_e1066);
    let _e1069 = local_53;
    output_1[_e1069] = _e1048;
}
