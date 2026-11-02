@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;

@compute @workgroup_size(1, 1, 1)
fn pointer_assignments() {
    var out: array<u32, 2>;
    var first: array<i32, 4>;
    var second: array<i32, 4>;
    var local: array<u32, 2>;
    var local_1: u32;
    var pointer: array<u32, 2>;
    var local_2: array<u32, 2>;
    var copy: array<u32, 2>;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: array<u32, 2>;
    var local_18: array<u32, 2>;
    var selected: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var iteration: i32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: array<u32, 2>;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: array<u32, 2>;
    var local_49: array<u32, 2>;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var end: array<u32, 2>;
    var local_54: array<u32, 2>;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: array<u32, 2>;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: i32;
    var local_67: array<u32, 2>;
    var local_68: u32;
    var local_69: u32;
    var local_70: array<u32, 2>;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: u32;
    var local_74: i32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;
    var local_81: i32;
    var local_82: array<u32, 2>;
    var local_83: u32;
    var local_84: u32;
    var local_85: array<u32, 2>;
    var local_86: u32;
    var local_87: u32;
    var local_88: i32;
    var local_89: array<u32, 2>;
    var local_90: u32;
    var local_91: u32;
    var local_92: array<u32, 2>;
    var local_93: array<u32, 2>;
    var local_94: array<u32, 2>;
    var local_95: u32;
    var local_96: u32;
    var local_97: i32;
    var local_98: array<u32, 2>;
    var local_99: u32;
    var local_100: u32;
    var local_101: array<u32, 2>;
    var local_102: array<u32, 2>;
    var local_103: u32;
    var local_104: u32;
    var local_105: i32;
    var local_106: array<u32, 2>;
    var local_107: u32;
    var local_108: u32;
    var local_109: i32;
    var local_110: array<u32, 2>;
    var local_111: u32;
    var local_112: u32;
    var local_113: array<u32, 2>;
    var local_114: u32;
    var local_115: u32;
    var local_116: i32;
    var local_117: array<u32, 2>;
    var local_118: u32;
    var local_119: u32;
    var local_120: array<u32, 2>;
    var local_121: u32;
    var local_122: u32;
    var local_123: i32;
    var local_124: array<u32, 2>;
    var local_125: u32;
    var local_126: u32;
    var local_127: array<u32, 2>;
    var local_128: u32;
    var local_129: u32;
    var local_130: array<u32, 2>;
    var local_131: u32;
    var local_132: u32;
    var local_133: array<u32, 2>;
    var local_134: array<u32, 2>;
    var local_135: u32;
    var local_136: u32;
    var local_137: i32;
    var local_138: array<u32, 2>;
    var local_139: u32;
    var local_140: u32;
    var local_141: array<u32, 2>;
    var local_142: array<u32, 2>;
    var local_143: array<u32, 2>;
    var local_144: u32;
    var local_145: u32;
    var local_146: i32;
    var local_147: array<u32, 2>;
    var local_148: u32;
    var local_149: u32;
    var local_150: array<u32, 2>;
    var local_151: array<u32, 2>;
    var local_152: array<u32, 2>;
    var local_153: u32;
    var local_154: u32;
    var local_155: i32;
    var local_156: array<u32, 2>;
    var local_157: u32;
    var local_158: u32;
    var local_159: array<u32, 2>;
    var local_160: array<u32, 2>;
    var local_161: array<u32, 2>;
    var local_162: u32;
    var local_163: u32;
    var local_164: i32;
    var local_165: array<u32, 2>;
    var local_166: u32;
    var local_167: u32;
    var local_168: array<u32, 2>;
    var local_169: array<u32, 2>;
    var local_170: u32;
    var local_171: u32;
    var local_172: i32;
    var local_173: array<u32, 2>;
    var local_174: u32;
    var local_175: u32;
    var local_176: array<u32, 2>;
    var local_177: array<u32, 2>;
    var local_178: u32;
    var local_179: u32;
    var local_180: i32;
    var local_181: array<u32, 2>;
    var local_182: u32;
    var local_183: u32;
    var local_184: array<u32, 2>;
    var local_185: u32;
    var local_186: u32;
    var local_187: i32;
    var local_188: array<u32, 2>;
    var local_189: u32;
    var local_190: u32;

    out = array<u32, 2>();
    out[0] = 2u;
    out[1] = 0u;
    first[0] = 2i;
    first[1] = 3i;
    first[2] = 5i;
    first[3] = 7i;
    second[0] = 11i;
    second[1] = 13i;
    second[2] = 17i;
    second[3] = 19i;
    let _e25 = out;
    local = _e25;
    local_1 = u32(30i);
    let _e30 = local;
    local_67 = _e30;
    let _e32 = local_1;
    let _e34 = local_67[1];
    local_67[1] = (_e34 + _e32);
    let _e38 = local_67[0];
    local_68 = u32(_e38);
    let _e42 = local_67[1];
    local_69 = u32(_e42);
    let _e45 = local_69;
    let _e48 = out_1[_e45];
    let choose = (_e48 != 0i);
    pointer = array<u32, 2>();
    pointer[0] = 3u;
    pointer[1] = 0u;
    let _e58 = pointer;
    local_2 = _e58;
    let _e60 = local_2;
    copy = _e60;
    let _e62 = pointer;
    local_3 = _e62;
    local_4 = u32(1i);
    local_70 = array<u32, 2>();
    local_70[0] = 4u;
    local_70[1] = 0u;
    let _e73 = local_4;
    let _e75 = local_70[1];
    local_70[1] = (_e75 + _e73);
    let _e78 = local_70;
    pointer = _e78;
    let _e79 = pointer;
    local_7 = _e79;
    let _e81 = local_7;
    local_71 = _e81;
    let _e84 = local_71[0];
    local_72 = u32(_e84);
    let _e88 = local_71[1];
    local_73 = u32(_e88);
    let _e91 = local_72;
    switch _e91 {
        case 3u: {
            let _e92 = local_73;
            let _e94 = first[_e92];
            local_74 = _e94;
        }
        default: {
            let _e96 = local_73;
            let _e98 = second[_e96];
            local_74 = _e98;
        }
    }
    let _e101 = local_74;
    let _e102 = out;
    local_5 = _e102;
    local_6 = u32(0i);
    let _e107 = local_5;
    local_75 = _e107;
    let _e109 = local_6;
    let _e111 = local_75[1];
    local_75[1] = (_e111 + _e109);
    let _e115 = local_75[0];
    local_76 = u32(_e115);
    let _e119 = local_75[1];
    local_77 = u32(_e119);
    let _e122 = local_77;
    out_1[_e122] = _e101;
    let _e125 = copy;
    local_10 = _e125;
    let _e127 = local_10;
    local_78 = _e127;
    let _e130 = local_78[0];
    local_79 = u32(_e130);
    let _e134 = local_78[1];
    local_80 = u32(_e134);
    let _e137 = local_79;
    switch _e137 {
        case 3u: {
            let _e138 = local_80;
            let _e140 = first[_e138];
            local_81 = _e140;
        }
        default: {
            let _e142 = local_80;
            let _e144 = second[_e142];
            local_81 = _e144;
        }
    }
    let _e147 = local_81;
    let _e148 = out;
    local_8 = _e148;
    local_9 = u32(1i);
    let _e153 = local_8;
    local_82 = _e153;
    let _e155 = local_9;
    let _e157 = local_82[1];
    local_82[1] = (_e157 + _e155);
    let _e161 = local_82[0];
    local_83 = u32(_e161);
    let _e165 = local_82[1];
    local_84 = u32(_e165);
    let _e168 = local_84;
    out_1[_e168] = _e147;
    let _e170 = local_3;
    local_85 = _e170;
    let _e173 = local_85[0];
    local_86 = u32(_e173);
    let _e177 = local_85[1];
    local_87 = u32(_e177);
    let _e180 = local_86;
    switch _e180 {
        case 3u: {
            let _e181 = local_87;
            let _e183 = first[_e181];
            local_88 = _e183;
        }
        default: {
            let _e185 = local_87;
            let _e187 = second[_e185];
            local_88 = _e187;
        }
    }
    let _e190 = local_88;
    let _e191 = out;
    local_11 = _e191;
    local_12 = u32(2i);
    let _e196 = local_11;
    local_89 = _e196;
    let _e198 = local_12;
    let _e200 = local_89[1];
    local_89[1] = (_e200 + _e198);
    let _e204 = local_89[0];
    local_90 = u32(_e204);
    let _e208 = local_89[1];
    local_91 = u32(_e208);
    let _e211 = local_91;
    out_1[_e211] = _e190;
    if choose {
        local_13 = u32(2i);
        local_92 = array<u32, 2>();
        local_92[0] = 3u;
        local_92[1] = 0u;
        let _e222 = local_13;
        let _e224 = local_92[1];
        local_92[1] = (_e224 + _e222);
        let _e227 = local_92;
        pointer = _e227;
    } else {
        local_14 = u32(2i);
        local_93 = array<u32, 2>();
        local_93[0] = 4u;
        local_93[1] = 0u;
        let _e237 = local_14;
        let _e239 = local_93[1];
        local_93[1] = (_e239 + _e237);
        let _e242 = local_93;
        pointer = _e242;
    }
    let _e243 = pointer;
    local_17 = _e243;
    let _e245 = local_17;
    local_94 = _e245;
    let _e248 = local_94[0];
    local_95 = u32(_e248);
    let _e252 = local_94[1];
    local_96 = u32(_e252);
    let _e255 = local_95;
    switch _e255 {
        case 3u: {
            let _e256 = local_96;
            let _e258 = first[_e256];
            local_97 = _e258;
        }
        default: {
            let _e260 = local_96;
            let _e262 = second[_e260];
            local_97 = _e262;
        }
    }
    let _e265 = local_97;
    let _e266 = out;
    local_15 = _e266;
    local_16 = u32(3i);
    let _e271 = local_15;
    local_98 = _e271;
    let _e273 = local_16;
    let _e275 = local_98[1];
    local_98[1] = (_e275 + _e273);
    let _e279 = local_98[0];
    local_99 = u32(_e279);
    let _e283 = local_98[1];
    local_100 = u32(_e283);
    let _e286 = local_100;
    out_1[_e286] = _e265;
    let _e288 = pointer;
    local_18 = _e288;
    let _e290 = local_18;
    selected = _e290;
    local_19 = u32(1i);
    local_101 = array<u32, 2>();
    local_101[0] = 3u;
    local_101[1] = 0u;
    let _e301 = local_19;
    let _e303 = local_101[1];
    local_101[1] = (_e303 + _e301);
    let _e306 = local_101;
    pointer = _e306;
    let _e308 = selected;
    local_20 = _e308;
    let _e310 = local_20;
    local_102 = _e310;
    let _e313 = local_102[0];
    local_103 = u32(_e313);
    let _e317 = local_102[1];
    local_104 = u32(_e317);
    let _e320 = local_103;
    switch _e320 {
        case 3u: {
            let _e321 = local_104;
            let _e323 = first[_e321];
            local_105 = _e323;
        }
        default: {
            let _e325 = local_104;
            let _e327 = second[_e325];
            local_105 = _e327;
        }
    }
    let _e330 = local_105;
    let _e332 = (_e330 + 20i);
    let _e333 = local_103;
    switch _e333 {
        case 3u: {
            let _e334 = local_104;
            first[_e334] = _e332;
        }
        default: {
            let _e336 = local_104;
            second[_e336] = _e332;
        }
    }
    let _e338 = pointer;
    local_23 = _e338;
    let _e340 = local_23;
    local_106 = _e340;
    let _e343 = local_106[0];
    local_107 = u32(_e343);
    let _e347 = local_106[1];
    local_108 = u32(_e347);
    let _e350 = local_107;
    switch _e350 {
        case 3u: {
            let _e351 = local_108;
            let _e353 = first[_e351];
            local_109 = _e353;
        }
        default: {
            let _e355 = local_108;
            let _e357 = second[_e355];
            local_109 = _e357;
        }
    }
    let _e360 = local_109;
    let _e361 = out;
    local_21 = _e361;
    local_22 = u32(4i);
    let _e366 = local_21;
    local_110 = _e366;
    let _e368 = local_22;
    let _e370 = local_110[1];
    local_110[1] = (_e370 + _e368);
    let _e374 = local_110[0];
    local_111 = u32(_e374);
    let _e378 = local_110[1];
    local_112 = u32(_e378);
    let _e381 = local_112;
    out_1[_e381] = _e360;
    let _e383 = selected;
    local_26 = _e383;
    let _e385 = local_26;
    local_113 = _e385;
    let _e388 = local_113[0];
    local_114 = u32(_e388);
    let _e392 = local_113[1];
    local_115 = u32(_e392);
    let _e395 = local_114;
    switch _e395 {
        case 3u: {
            let _e396 = local_115;
            let _e398 = first[_e396];
            local_116 = _e398;
        }
        default: {
            let _e400 = local_115;
            let _e402 = second[_e400];
            local_116 = _e402;
        }
    }
    let _e405 = local_116;
    let _e406 = out;
    local_24 = _e406;
    local_25 = u32(5i);
    let _e411 = local_24;
    local_117 = _e411;
    let _e413 = local_25;
    let _e415 = local_117[1];
    local_117[1] = (_e415 + _e413);
    let _e419 = local_117[0];
    local_118 = u32(_e419);
    let _e423 = local_117[1];
    local_119 = u32(_e423);
    let _e426 = local_119;
    out_1[_e426] = _e405;
    let _e428 = copy;
    local_29 = _e428;
    let _e430 = local_29;
    local_120 = _e430;
    let _e433 = local_120[0];
    local_121 = u32(_e433);
    let _e437 = local_120[1];
    local_122 = u32(_e437);
    let _e440 = local_121;
    switch _e440 {
        case 3u: {
            let _e441 = local_122;
            let _e443 = first[_e441];
            local_123 = _e443;
        }
        default: {
            let _e445 = local_122;
            let _e447 = second[_e445];
            local_123 = _e447;
        }
    }
    let _e450 = local_123;
    let _e451 = out;
    local_27 = _e451;
    local_28 = u32(6i);
    let _e456 = local_27;
    local_124 = _e456;
    let _e458 = local_28;
    let _e460 = local_124[1];
    local_124[1] = (_e460 + _e458);
    let _e464 = local_124[0];
    local_125 = u32(_e464);
    let _e468 = local_124[1];
    local_126 = u32(_e468);
    let _e471 = local_126;
    out_1[_e471] = _e450;
    let _e475 = first[2i];
    let _e476 = out;
    local_30 = _e476;
    local_31 = u32(7i);
    let _e481 = local_30;
    local_127 = _e481;
    let _e483 = local_31;
    let _e485 = local_127[1];
    local_127[1] = (_e485 + _e483);
    let _e489 = local_127[0];
    local_128 = u32(_e489);
    let _e493 = local_127[1];
    local_129 = u32(_e493);
    let _e496 = local_129;
    out_1[_e496] = _e475;
    let _e500 = second[2i];
    let _e501 = out;
    local_32 = _e501;
    local_33 = u32(8i);
    let _e506 = local_32;
    local_130 = _e506;
    let _e508 = local_33;
    let _e510 = local_130[1];
    local_130[1] = (_e510 + _e508);
    let _e514 = local_130[0];
    local_131 = u32(_e514);
    let _e518 = local_130[1];
    local_132 = u32(_e518);
    let _e521 = local_132;
    out_1[_e521] = _e500;
    local_133 = array<u32, 2>();
    local_133[0] = 3u;
    local_133[1] = 0u;
    let _e529 = local_133;
    pointer = _e529;
    {
        iteration = 0i;
        loop {
            let _e532 = iteration;
            if (_e532 < 3i) {
            } else {
                break;
            }
            let _e535 = pointer;
            local_36 = _e535;
            let _e537 = local_36;
            local_134 = _e537;
            let _e540 = local_134[0];
            local_135 = u32(_e540);
            let _e544 = local_134[1];
            local_136 = u32(_e544);
            let _e547 = local_135;
            switch _e547 {
                case 3u: {
                    let _e548 = local_136;
                    let _e550 = first[_e548];
                    local_137 = _e550;
                }
                default: {
                    let _e552 = local_136;
                    let _e554 = second[_e552];
                    local_137 = _e554;
                }
            }
            let _e557 = local_137;
            local_66 = _e557;
            let _e559 = local_66;
            let _e560 = out;
            local_34 = _e560;
            let _e562 = iteration;
            local_35 = u32((9i + _e562));
            let _e567 = local_34;
            local_138 = _e567;
            let _e569 = local_35;
            let _e571 = local_138[1];
            local_138[1] = (_e571 + _e569);
            let _e575 = local_138[0];
            local_139 = u32(_e575);
            let _e579 = local_138[1];
            local_140 = u32(_e579);
            let _e582 = local_140;
            out_1[_e582] = _e559;
            let _e584 = iteration;
            if (_e584 == 0i) {
                local_37 = u32(1i);
                local_141 = array<u32, 2>();
                local_141[0] = 4u;
                local_141[1] = 0u;
                let _e596 = local_37;
                let _e598 = local_141[1];
                local_141[1] = (_e598 + _e596);
                let _e601 = local_141;
                pointer = _e601;
            } else {
                local_38 = u32(3i);
                local_142 = array<u32, 2>();
                local_142[0] = 3u;
                local_142[1] = 0u;
                let _e611 = local_38;
                let _e613 = local_142[1];
                local_142[1] = (_e613 + _e611);
                let _e616 = local_142;
                pointer = _e616;
            }
            continuing {
                let _e617 = iteration;
                iteration = (_e617 + 1i);
            }
        }
    }
    let _e620 = pointer;
    local_41 = _e620;
    let _e622 = local_41;
    local_143 = _e622;
    let _e625 = local_143[0];
    local_144 = u32(_e625);
    let _e629 = local_143[1];
    local_145 = u32(_e629);
    let _e632 = local_144;
    switch _e632 {
        case 3u: {
            let _e633 = local_145;
            let _e635 = first[_e633];
            local_146 = _e635;
        }
        default: {
            let _e637 = local_145;
            let _e639 = second[_e637];
            local_146 = _e639;
        }
    }
    let _e642 = local_146;
    let _e643 = out;
    local_39 = _e643;
    local_40 = u32(12i);
    let _e648 = local_39;
    local_147 = _e648;
    let _e650 = local_40;
    let _e652 = local_147[1];
    local_147[1] = (_e652 + _e650);
    let _e656 = local_147[0];
    local_148 = u32(_e656);
    let _e660 = local_147[1];
    local_149 = u32(_e660);
    let _e663 = local_149;
    out_1[_e663] = _e642;
    let _e665 = copy;
    local_42 = _e665;
    let _e667 = local_42;
    local_150 = _e667;
    let _e669 = local_150;
    pointer = _e669;
    let _e670 = pointer;
    local_43 = _e670;
    local_44 = u32(1i);
    let _e675 = local_43;
    local_151 = _e675;
    let _e677 = local_44;
    let _e679 = local_151[1];
    local_151[1] = (_e679 + _e677);
    let _e682 = local_151;
    pointer = _e682;
    let _e683 = pointer;
    local_47 = _e683;
    let _e685 = local_47;
    local_152 = _e685;
    let _e688 = local_152[0];
    local_153 = u32(_e688);
    let _e692 = local_152[1];
    local_154 = u32(_e692);
    let _e695 = local_153;
    switch _e695 {
        case 3u: {
            let _e696 = local_154;
            let _e698 = first[_e696];
            local_155 = _e698;
        }
        default: {
            let _e700 = local_154;
            let _e702 = second[_e700];
            local_155 = _e702;
        }
    }
    let _e705 = local_155;
    let _e706 = out;
    local_45 = _e706;
    local_46 = u32(13i);
    let _e711 = local_45;
    local_156 = _e711;
    let _e713 = local_46;
    let _e715 = local_156[1];
    local_156[1] = (_e715 + _e713);
    let _e719 = local_156[0];
    local_157 = u32(_e719);
    let _e723 = local_156[1];
    local_158 = u32(_e723);
    let _e726 = local_158;
    out_1[_e726] = _e705;
    let _e728 = copy;
    local_48 = _e728;
    let _e730 = local_48;
    local_159 = _e730;
    let _e732 = local_159;
    pointer = _e732;
    let _e733 = pointer;
    local_49 = _e733;
    let _e735 = local_49;
    local_160 = _e735;
    let _e737 = local_160;
    copy = _e737;
    let _e738 = copy;
    local_52 = _e738;
    let _e740 = local_52;
    local_161 = _e740;
    let _e743 = local_161[0];
    local_162 = u32(_e743);
    let _e747 = local_161[1];
    local_163 = u32(_e747);
    let _e750 = local_162;
    switch _e750 {
        case 3u: {
            let _e751 = local_163;
            let _e753 = first[_e751];
            local_164 = _e753;
        }
        default: {
            let _e755 = local_163;
            let _e757 = second[_e755];
            local_164 = _e757;
        }
    }
    let _e760 = local_164;
    let _e761 = out;
    local_50 = _e761;
    local_51 = u32(14i);
    let _e766 = local_50;
    local_165 = _e766;
    let _e768 = local_51;
    let _e770 = local_165[1];
    local_165[1] = (_e770 + _e768);
    let _e774 = local_165[0];
    local_166 = u32(_e774);
    let _e778 = local_165[1];
    local_167 = u32(_e778);
    let _e781 = local_167;
    out_1[_e781] = _e760;
    local_53 = u32(4i);
    end = array<u32, 2>();
    end[0] = 3u;
    end[1] = 0u;
    let _e792 = local_53;
    let _e794 = end[1];
    end[1] = (_e794 + _e792);
    let _e798 = end;
    local_54 = _e798;
    let _e800 = local_54;
    local_168 = _e800;
    let _e802 = local_168;
    pointer = _e802;
    let _e803 = pointer;
    local_57 = _e803;
    local_58 = u32(1i);
    let _e808 = local_57;
    local_169 = _e808;
    let _e810 = local_58;
    let _e812 = local_169[1];
    local_169[1] = (_e812 - _e810);
    let _e816 = local_169[0];
    local_170 = u32(_e816);
    let _e820 = local_169[1];
    local_171 = u32(_e820);
    let _e823 = local_170;
    switch _e823 {
        case 3u: {
            let _e824 = local_171;
            let _e826 = first[_e824];
            local_172 = _e826;
        }
        default: {
            let _e828 = local_171;
            let _e830 = second[_e828];
            local_172 = _e830;
        }
    }
    let _e833 = local_172;
    let _e834 = out;
    local_55 = _e834;
    local_56 = u32(15i);
    let _e839 = local_55;
    local_173 = _e839;
    let _e841 = local_56;
    let _e843 = local_173[1];
    local_173[1] = (_e843 + _e841);
    let _e847 = local_173[0];
    local_174 = u32(_e847);
    let _e851 = local_173[1];
    local_175 = u32(_e851);
    let _e854 = local_175;
    out_1[_e854] = _e833;
    local_176 = array<u32, 2>();
    local_176[0] = 4u;
    local_176[1] = 0u;
    let _e862 = local_176;
    pointer = _e862;
    let _e863 = pointer;
    local_59 = _e863;
    let _e866 = pointer[1];
    pointer[1] = (_e866 + 1u);
    let _e870 = pointer;
    local_62 = _e870;
    let _e872 = local_62;
    local_177 = _e872;
    let _e875 = local_177[0];
    local_178 = u32(_e875);
    let _e879 = local_177[1];
    local_179 = u32(_e879);
    let _e882 = local_178;
    switch _e882 {
        case 3u: {
            let _e883 = local_179;
            let _e885 = first[_e883];
            local_180 = _e885;
        }
        default: {
            let _e887 = local_179;
            let _e889 = second[_e887];
            local_180 = _e889;
        }
    }
    let _e892 = local_180;
    let _e893 = out;
    local_60 = _e893;
    local_61 = u32(16i);
    let _e898 = local_60;
    local_181 = _e898;
    let _e900 = local_61;
    let _e902 = local_181[1];
    local_181[1] = (_e902 + _e900);
    let _e906 = local_181[0];
    local_182 = u32(_e906);
    let _e910 = local_181[1];
    local_183 = u32(_e910);
    let _e913 = local_183;
    out_1[_e913] = _e892;
    let _e915 = copy;
    local_65 = _e915;
    let _e917 = local_65;
    local_184 = _e917;
    let _e920 = local_184[0];
    local_185 = u32(_e920);
    let _e924 = local_184[1];
    local_186 = u32(_e924);
    let _e927 = local_185;
    switch _e927 {
        case 3u: {
            let _e928 = local_186;
            let _e930 = first[_e928];
            local_187 = _e930;
        }
        default: {
            let _e932 = local_186;
            let _e934 = second[_e932];
            local_187 = _e934;
        }
    }
    let _e937 = local_187;
    let _e938 = out;
    local_63 = _e938;
    local_64 = u32(17i);
    let _e943 = local_63;
    local_188 = _e943;
    let _e945 = local_64;
    let _e947 = local_188[1];
    local_188[1] = (_e947 + _e945);
    let _e951 = local_188[0];
    local_189 = u32(_e951);
    let _e955 = local_188[1];
    local_190 = u32(_e955);
    let _e958 = local_190;
    out_1[_e958] = _e937;
}
