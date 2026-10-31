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
    var local_13: i32;
    var local_14: u32;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: array<u32, 2>;
    var selected: array<u32, 2>;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: array<u32, 2>;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var iteration: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: array<u32, 2>;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: array<u32, 2>;
    var local_50: array<u32, 2>;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var end: array<u32, 2>;
    var local_55: array<u32, 2>;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: array<u32, 2>;
    var local_59: u32;
    var local_60: array<u32, 2>;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: array<u32, 2>;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: i32;
    var local_68: i32;
    var local_69: i32;
    var local_70: i32;
    var local_71: i32;
    var local_72: i32;
    var local_73: i32;
    var local_74: i32;
    var local_75: i32;
    var local_76: i32;
    var local_77: i32;
    var local_78: i32;
    var local_79: i32;
    var local_80: i32;
    var local_81: i32;
    var local_82: i32;
    var local_83: array<u32, 2>;
    var local_84: u32;
    var local_85: u32;
    var local_86: i32;
    var local_87: array<u32, 2>;
    var local_88: array<u32, 2>;
    var local_89: u32;
    var local_90: u32;
    var local_91: i32;
    var local_92: array<u32, 2>;
    var local_93: u32;
    var local_94: u32;
    var local_95: array<u32, 2>;
    var local_96: u32;
    var local_97: u32;
    var local_98: i32;
    var local_99: array<u32, 2>;
    var local_100: u32;
    var local_101: u32;
    var local_102: array<u32, 2>;
    var local_103: u32;
    var local_104: u32;
    var local_105: i32;
    var local_106: array<u32, 2>;
    var local_107: u32;
    var local_108: u32;
    var local_109: array<u32, 2>;
    var local_110: array<u32, 2>;
    var local_111: array<u32, 2>;
    var local_112: u32;
    var local_113: u32;
    var local_114: i32;
    var local_115: array<u32, 2>;
    var local_116: u32;
    var local_117: u32;
    var local_118: array<u32, 2>;
    var local_119: array<u32, 2>;
    var local_120: u32;
    var local_121: u32;
    var local_122: i32;
    var local_123: array<u32, 2>;
    var local_124: u32;
    var local_125: u32;
    var local_126: i32;
    var local_127: array<u32, 2>;
    var local_128: u32;
    var local_129: u32;
    var local_130: array<u32, 2>;
    var local_131: u32;
    var local_132: u32;
    var local_133: i32;
    var local_134: array<u32, 2>;
    var local_135: u32;
    var local_136: u32;
    var local_137: array<u32, 2>;
    var local_138: u32;
    var local_139: u32;
    var local_140: i32;
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
    var local_151: array<u32, 2>;
    var local_152: u32;
    var local_153: u32;
    var local_154: i32;
    var local_155: array<u32, 2>;
    var local_156: u32;
    var local_157: u32;
    var local_158: array<u32, 2>;
    var local_159: array<u32, 2>;
    var local_160: array<u32, 2>;
    var local_161: u32;
    var local_162: u32;
    var local_163: i32;
    var local_164: array<u32, 2>;
    var local_165: u32;
    var local_166: u32;
    var local_167: array<u32, 2>;
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
    var local_178: array<u32, 2>;
    var local_179: u32;
    var local_180: u32;
    var local_181: i32;
    var local_182: array<u32, 2>;
    var local_183: u32;
    var local_184: u32;
    var local_185: array<u32, 2>;
    var local_186: array<u32, 2>;
    var local_187: u32;
    var local_188: u32;
    var local_189: i32;
    var local_190: array<u32, 2>;
    var local_191: u32;
    var local_192: u32;
    var local_193: array<u32, 2>;
    var local_194: array<u32, 2>;
    var local_195: u32;
    var local_196: u32;
    var local_197: i32;
    var local_198: array<u32, 2>;
    var local_199: u32;
    var local_200: u32;
    var local_201: array<u32, 2>;
    var local_202: u32;
    var local_203: u32;
    var local_204: i32;
    var local_205: array<u32, 2>;
    var local_206: u32;
    var local_207: u32;

    out = array<u32, 2>();
    out[0] = 0u;
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
    local_83 = _e30;
    let _e32 = local_1;
    let _e34 = local_83[1];
    local_83[1] = (_e34 + _e32);
    let _e38 = local_83[0];
    local_84 = u32(_e38);
    let _e42 = local_83[1];
    local_85 = u32(_e42);
    let _e45 = local_85;
    let _e48 = out_1[_e45];
    local_86 = _e48;
    let _e50 = local_86;
    local_67 = _e50;
    let _e52 = local_67;
    let choose = (_e52 != 0i);
    pointer = array<u32, 2>();
    pointer[0] = 1u;
    pointer[1] = 0u;
    let _e62 = pointer;
    local_2 = _e62;
    let _e64 = local_2;
    copy = _e64;
    let _e66 = pointer;
    local_3 = _e66;
    local_4 = u32(1i);
    local_87 = array<u32, 2>();
    local_87[0] = 2u;
    local_87[1] = 0u;
    let _e77 = local_4;
    let _e79 = local_87[1];
    local_87[1] = (_e79 + _e77);
    let _e82 = local_87;
    pointer = _e82;
    let _e83 = pointer;
    local_7 = _e83;
    let _e85 = local_7;
    local_88 = _e85;
    let _e88 = local_88[0];
    local_89 = u32(_e88);
    let _e92 = local_88[1];
    local_90 = u32(_e92);
    let _e95 = local_89;
    switch _e95 {
        case 1u: {
            let _e96 = local_90;
            let _e98 = first[_e96];
            local_91 = _e98;
        }
        default: {
            let _e100 = local_90;
            let _e102 = second[_e100];
            local_91 = _e102;
        }
    }
    let _e105 = local_91;
    local_68 = _e105;
    let _e107 = local_68;
    let _e108 = out;
    local_5 = _e108;
    local_6 = u32(0i);
    let _e113 = local_5;
    local_92 = _e113;
    let _e115 = local_6;
    let _e117 = local_92[1];
    local_92[1] = (_e117 + _e115);
    let _e121 = local_92[0];
    local_93 = u32(_e121);
    let _e125 = local_92[1];
    local_94 = u32(_e125);
    let _e128 = local_94;
    out_1[_e128] = _e107;
    let _e131 = copy;
    local_10 = _e131;
    let _e133 = local_10;
    local_95 = _e133;
    let _e136 = local_95[0];
    local_96 = u32(_e136);
    let _e140 = local_95[1];
    local_97 = u32(_e140);
    let _e143 = local_96;
    switch _e143 {
        case 1u: {
            let _e144 = local_97;
            let _e146 = first[_e144];
            local_98 = _e146;
        }
        default: {
            let _e148 = local_97;
            let _e150 = second[_e148];
            local_98 = _e150;
        }
    }
    let _e153 = local_98;
    local_69 = _e153;
    let _e155 = local_69;
    let _e156 = out;
    local_8 = _e156;
    local_9 = u32(1i);
    let _e161 = local_8;
    local_99 = _e161;
    let _e163 = local_9;
    let _e165 = local_99[1];
    local_99[1] = (_e165 + _e163);
    let _e169 = local_99[0];
    local_100 = u32(_e169);
    let _e173 = local_99[1];
    local_101 = u32(_e173);
    let _e176 = local_101;
    out_1[_e176] = _e155;
    let _e178 = local_3;
    local_102 = _e178;
    let _e181 = local_102[0];
    local_103 = u32(_e181);
    let _e185 = local_102[1];
    local_104 = u32(_e185);
    let _e188 = local_103;
    switch _e188 {
        case 1u: {
            let _e189 = local_104;
            let _e191 = first[_e189];
            local_105 = _e191;
        }
        default: {
            let _e193 = local_104;
            let _e195 = second[_e193];
            local_105 = _e195;
        }
    }
    let _e198 = local_105;
    local_70 = _e198;
    let _e200 = local_70;
    local_13 = _e200;
    let _e202 = local_13;
    let _e203 = out;
    local_11 = _e203;
    local_12 = u32(2i);
    let _e208 = local_11;
    local_106 = _e208;
    let _e210 = local_12;
    let _e212 = local_106[1];
    local_106[1] = (_e212 + _e210);
    let _e216 = local_106[0];
    local_107 = u32(_e216);
    let _e220 = local_106[1];
    local_108 = u32(_e220);
    let _e223 = local_108;
    out_1[_e223] = _e202;
    if choose {
        local_14 = u32(2i);
        local_109 = array<u32, 2>();
        local_109[0] = 1u;
        local_109[1] = 0u;
        let _e234 = local_14;
        let _e236 = local_109[1];
        local_109[1] = (_e236 + _e234);
        let _e239 = local_109;
        pointer = _e239;
    } else {
        local_15 = u32(2i);
        local_110 = array<u32, 2>();
        local_110[0] = 2u;
        local_110[1] = 0u;
        let _e249 = local_15;
        let _e251 = local_110[1];
        local_110[1] = (_e251 + _e249);
        let _e254 = local_110;
        pointer = _e254;
    }
    let _e255 = pointer;
    local_18 = _e255;
    let _e257 = local_18;
    local_111 = _e257;
    let _e260 = local_111[0];
    local_112 = u32(_e260);
    let _e264 = local_111[1];
    local_113 = u32(_e264);
    let _e267 = local_112;
    switch _e267 {
        case 1u: {
            let _e268 = local_113;
            let _e270 = first[_e268];
            local_114 = _e270;
        }
        default: {
            let _e272 = local_113;
            let _e274 = second[_e272];
            local_114 = _e274;
        }
    }
    let _e277 = local_114;
    local_71 = _e277;
    let _e279 = local_71;
    let _e280 = out;
    local_16 = _e280;
    local_17 = u32(3i);
    let _e285 = local_16;
    local_115 = _e285;
    let _e287 = local_17;
    let _e289 = local_115[1];
    local_115[1] = (_e289 + _e287);
    let _e293 = local_115[0];
    local_116 = u32(_e293);
    let _e297 = local_115[1];
    local_117 = u32(_e297);
    let _e300 = local_117;
    out_1[_e300] = _e279;
    let _e302 = pointer;
    local_19 = _e302;
    let _e304 = local_19;
    selected = _e304;
    local_20 = u32(1i);
    local_118 = array<u32, 2>();
    local_118[0] = 1u;
    local_118[1] = 0u;
    let _e315 = local_20;
    let _e317 = local_118[1];
    local_118[1] = (_e317 + _e315);
    let _e320 = local_118;
    pointer = _e320;
    let _e322 = selected;
    local_21 = _e322;
    let _e324 = local_21;
    local_119 = _e324;
    let _e327 = local_119[0];
    local_120 = u32(_e327);
    let _e331 = local_119[1];
    local_121 = u32(_e331);
    let _e334 = local_120;
    switch _e334 {
        case 1u: {
            let _e335 = local_121;
            let _e337 = first[_e335];
            local_122 = _e337;
        }
        default: {
            let _e339 = local_121;
            let _e341 = second[_e339];
            local_122 = _e341;
        }
    }
    let _e344 = local_122;
    local_72 = _e344;
    let _e346 = local_72;
    let _e348 = (_e346 + 20i);
    let _e349 = local_120;
    switch _e349 {
        case 1u: {
            let _e350 = local_121;
            first[_e350] = _e348;
        }
        default: {
            let _e352 = local_121;
            second[_e352] = _e348;
        }
    }
    let _e354 = pointer;
    local_24 = _e354;
    let _e356 = local_24;
    local_123 = _e356;
    let _e359 = local_123[0];
    local_124 = u32(_e359);
    let _e363 = local_123[1];
    local_125 = u32(_e363);
    let _e366 = local_124;
    switch _e366 {
        case 1u: {
            let _e367 = local_125;
            let _e369 = first[_e367];
            local_126 = _e369;
        }
        default: {
            let _e371 = local_125;
            let _e373 = second[_e371];
            local_126 = _e373;
        }
    }
    let _e376 = local_126;
    local_73 = _e376;
    let _e378 = local_73;
    let _e379 = out;
    local_22 = _e379;
    local_23 = u32(4i);
    let _e384 = local_22;
    local_127 = _e384;
    let _e386 = local_23;
    let _e388 = local_127[1];
    local_127[1] = (_e388 + _e386);
    let _e392 = local_127[0];
    local_128 = u32(_e392);
    let _e396 = local_127[1];
    local_129 = u32(_e396);
    let _e399 = local_129;
    out_1[_e399] = _e378;
    let _e401 = selected;
    local_27 = _e401;
    let _e403 = local_27;
    local_130 = _e403;
    let _e406 = local_130[0];
    local_131 = u32(_e406);
    let _e410 = local_130[1];
    local_132 = u32(_e410);
    let _e413 = local_131;
    switch _e413 {
        case 1u: {
            let _e414 = local_132;
            let _e416 = first[_e414];
            local_133 = _e416;
        }
        default: {
            let _e418 = local_132;
            let _e420 = second[_e418];
            local_133 = _e420;
        }
    }
    let _e423 = local_133;
    local_74 = _e423;
    let _e425 = local_74;
    let _e426 = out;
    local_25 = _e426;
    local_26 = u32(5i);
    let _e431 = local_25;
    local_134 = _e431;
    let _e433 = local_26;
    let _e435 = local_134[1];
    local_134[1] = (_e435 + _e433);
    let _e439 = local_134[0];
    local_135 = u32(_e439);
    let _e443 = local_134[1];
    local_136 = u32(_e443);
    let _e446 = local_136;
    out_1[_e446] = _e425;
    let _e448 = copy;
    local_30 = _e448;
    let _e450 = local_30;
    local_137 = _e450;
    let _e453 = local_137[0];
    local_138 = u32(_e453);
    let _e457 = local_137[1];
    local_139 = u32(_e457);
    let _e460 = local_138;
    switch _e460 {
        case 1u: {
            let _e461 = local_139;
            let _e463 = first[_e461];
            local_140 = _e463;
        }
        default: {
            let _e465 = local_139;
            let _e467 = second[_e465];
            local_140 = _e467;
        }
    }
    let _e470 = local_140;
    local_75 = _e470;
    let _e472 = local_75;
    let _e473 = out;
    local_28 = _e473;
    local_29 = u32(6i);
    let _e478 = local_28;
    local_141 = _e478;
    let _e480 = local_29;
    let _e482 = local_141[1];
    local_141[1] = (_e482 + _e480);
    let _e486 = local_141[0];
    local_142 = u32(_e486);
    let _e490 = local_141[1];
    local_143 = u32(_e490);
    let _e493 = local_143;
    out_1[_e493] = _e472;
    let _e497 = first[2i];
    let _e498 = out;
    local_31 = _e498;
    local_32 = u32(7i);
    let _e503 = local_31;
    local_144 = _e503;
    let _e505 = local_32;
    let _e507 = local_144[1];
    local_144[1] = (_e507 + _e505);
    let _e511 = local_144[0];
    local_145 = u32(_e511);
    let _e515 = local_144[1];
    local_146 = u32(_e515);
    let _e518 = local_146;
    out_1[_e518] = _e497;
    let _e522 = second[2i];
    let _e523 = out;
    local_33 = _e523;
    local_34 = u32(8i);
    let _e528 = local_33;
    local_147 = _e528;
    let _e530 = local_34;
    let _e532 = local_147[1];
    local_147[1] = (_e532 + _e530);
    let _e536 = local_147[0];
    local_148 = u32(_e536);
    let _e540 = local_147[1];
    local_149 = u32(_e540);
    let _e543 = local_149;
    out_1[_e543] = _e522;
    local_150 = array<u32, 2>();
    local_150[0] = 1u;
    local_150[1] = 0u;
    let _e551 = local_150;
    pointer = _e551;
    {
        iteration = 0i;
        loop {
            let _e554 = iteration;
            if (_e554 < 3i) {
            } else {
                break;
            }
            let _e557 = pointer;
            local_37 = _e557;
            let _e559 = local_37;
            local_151 = _e559;
            let _e562 = local_151[0];
            local_152 = u32(_e562);
            let _e566 = local_151[1];
            local_153 = u32(_e566);
            let _e569 = local_152;
            switch _e569 {
                case 1u: {
                    let _e570 = local_153;
                    let _e572 = first[_e570];
                    local_154 = _e572;
                }
                default: {
                    let _e574 = local_153;
                    let _e576 = second[_e574];
                    local_154 = _e576;
                }
            }
            let _e579 = local_154;
            local_76 = _e579;
            let _e581 = local_76;
            let _e582 = out;
            local_35 = _e582;
            let _e584 = iteration;
            local_36 = u32((9i + _e584));
            let _e589 = local_35;
            local_155 = _e589;
            let _e591 = local_36;
            let _e593 = local_155[1];
            local_155[1] = (_e593 + _e591);
            let _e597 = local_155[0];
            local_156 = u32(_e597);
            let _e601 = local_155[1];
            local_157 = u32(_e601);
            let _e604 = local_157;
            out_1[_e604] = _e581;
            let _e606 = iteration;
            if (_e606 == 0i) {
                local_38 = u32(1i);
                local_158 = array<u32, 2>();
                local_158[0] = 2u;
                local_158[1] = 0u;
                let _e618 = local_38;
                let _e620 = local_158[1];
                local_158[1] = (_e620 + _e618);
                let _e623 = local_158;
                pointer = _e623;
            } else {
                local_39 = u32(3i);
                local_159 = array<u32, 2>();
                local_159[0] = 1u;
                local_159[1] = 0u;
                let _e633 = local_39;
                let _e635 = local_159[1];
                local_159[1] = (_e635 + _e633);
                let _e638 = local_159;
                pointer = _e638;
            }
            continuing {
                let _e639 = iteration;
                iteration = (_e639 + 1i);
            }
        }
    }
    let _e642 = pointer;
    local_42 = _e642;
    let _e644 = local_42;
    local_160 = _e644;
    let _e647 = local_160[0];
    local_161 = u32(_e647);
    let _e651 = local_160[1];
    local_162 = u32(_e651);
    let _e654 = local_161;
    switch _e654 {
        case 1u: {
            let _e655 = local_162;
            let _e657 = first[_e655];
            local_163 = _e657;
        }
        default: {
            let _e659 = local_162;
            let _e661 = second[_e659];
            local_163 = _e661;
        }
    }
    let _e664 = local_163;
    local_77 = _e664;
    let _e666 = local_77;
    let _e667 = out;
    local_40 = _e667;
    local_41 = u32(12i);
    let _e672 = local_40;
    local_164 = _e672;
    let _e674 = local_41;
    let _e676 = local_164[1];
    local_164[1] = (_e676 + _e674);
    let _e680 = local_164[0];
    local_165 = u32(_e680);
    let _e684 = local_164[1];
    local_166 = u32(_e684);
    let _e687 = local_166;
    out_1[_e687] = _e666;
    let _e689 = copy;
    local_43 = _e689;
    let _e691 = local_43;
    local_167 = _e691;
    let _e693 = local_167;
    pointer = _e693;
    let _e694 = pointer;
    local_44 = _e694;
    local_45 = u32(1i);
    let _e699 = local_44;
    local_168 = _e699;
    let _e701 = local_45;
    let _e703 = local_168[1];
    local_168[1] = (_e703 + _e701);
    let _e706 = local_168;
    pointer = _e706;
    let _e707 = pointer;
    local_48 = _e707;
    let _e709 = local_48;
    local_169 = _e709;
    let _e712 = local_169[0];
    local_170 = u32(_e712);
    let _e716 = local_169[1];
    local_171 = u32(_e716);
    let _e719 = local_170;
    switch _e719 {
        case 1u: {
            let _e720 = local_171;
            let _e722 = first[_e720];
            local_172 = _e722;
        }
        default: {
            let _e724 = local_171;
            let _e726 = second[_e724];
            local_172 = _e726;
        }
    }
    let _e729 = local_172;
    local_78 = _e729;
    let _e731 = local_78;
    let _e732 = out;
    local_46 = _e732;
    local_47 = u32(13i);
    let _e737 = local_46;
    local_173 = _e737;
    let _e739 = local_47;
    let _e741 = local_173[1];
    local_173[1] = (_e741 + _e739);
    let _e745 = local_173[0];
    local_174 = u32(_e745);
    let _e749 = local_173[1];
    local_175 = u32(_e749);
    let _e752 = local_175;
    out_1[_e752] = _e731;
    let _e754 = copy;
    local_49 = _e754;
    let _e756 = local_49;
    local_176 = _e756;
    let _e758 = local_176;
    pointer = _e758;
    let _e759 = pointer;
    local_50 = _e759;
    let _e761 = local_50;
    local_177 = _e761;
    let _e763 = local_177;
    copy = _e763;
    let _e764 = copy;
    local_53 = _e764;
    let _e766 = local_53;
    local_178 = _e766;
    let _e769 = local_178[0];
    local_179 = u32(_e769);
    let _e773 = local_178[1];
    local_180 = u32(_e773);
    let _e776 = local_179;
    switch _e776 {
        case 1u: {
            let _e777 = local_180;
            let _e779 = first[_e777];
            local_181 = _e779;
        }
        default: {
            let _e781 = local_180;
            let _e783 = second[_e781];
            local_181 = _e783;
        }
    }
    let _e786 = local_181;
    local_79 = _e786;
    let _e788 = local_79;
    let _e789 = out;
    local_51 = _e789;
    local_52 = u32(14i);
    let _e794 = local_51;
    local_182 = _e794;
    let _e796 = local_52;
    let _e798 = local_182[1];
    local_182[1] = (_e798 + _e796);
    let _e802 = local_182[0];
    local_183 = u32(_e802);
    let _e806 = local_182[1];
    local_184 = u32(_e806);
    let _e809 = local_184;
    out_1[_e809] = _e788;
    local_54 = u32(4i);
    end = array<u32, 2>();
    end[0] = 1u;
    end[1] = 0u;
    let _e820 = local_54;
    let _e822 = end[1];
    end[1] = (_e822 + _e820);
    let _e826 = end;
    local_55 = _e826;
    let _e828 = local_55;
    local_185 = _e828;
    let _e830 = local_185;
    pointer = _e830;
    let _e831 = pointer;
    local_58 = _e831;
    local_59 = u32(1i);
    let _e836 = local_58;
    local_186 = _e836;
    let _e838 = local_59;
    let _e840 = local_186[1];
    local_186[1] = (_e840 - _e838);
    let _e844 = local_186[0];
    local_187 = u32(_e844);
    let _e848 = local_186[1];
    local_188 = u32(_e848);
    let _e851 = local_187;
    switch _e851 {
        case 1u: {
            let _e852 = local_188;
            let _e854 = first[_e852];
            local_189 = _e854;
        }
        default: {
            let _e856 = local_188;
            let _e858 = second[_e856];
            local_189 = _e858;
        }
    }
    let _e861 = local_189;
    local_80 = _e861;
    let _e863 = local_80;
    let _e864 = out;
    local_56 = _e864;
    local_57 = u32(15i);
    let _e869 = local_56;
    local_190 = _e869;
    let _e871 = local_57;
    let _e873 = local_190[1];
    local_190[1] = (_e873 + _e871);
    let _e877 = local_190[0];
    local_191 = u32(_e877);
    let _e881 = local_190[1];
    local_192 = u32(_e881);
    let _e884 = local_192;
    out_1[_e884] = _e863;
    local_193 = array<u32, 2>();
    local_193[0] = 2u;
    local_193[1] = 0u;
    let _e892 = local_193;
    pointer = _e892;
    let _e893 = pointer;
    local_60 = _e893;
    let _e896 = pointer[1];
    pointer[1] = (_e896 + 1u);
    let _e900 = pointer;
    local_63 = _e900;
    let _e902 = local_63;
    local_194 = _e902;
    let _e905 = local_194[0];
    local_195 = u32(_e905);
    let _e909 = local_194[1];
    local_196 = u32(_e909);
    let _e912 = local_195;
    switch _e912 {
        case 1u: {
            let _e913 = local_196;
            let _e915 = first[_e913];
            local_197 = _e915;
        }
        default: {
            let _e917 = local_196;
            let _e919 = second[_e917];
            local_197 = _e919;
        }
    }
    let _e922 = local_197;
    local_81 = _e922;
    let _e924 = local_81;
    let _e925 = out;
    local_61 = _e925;
    local_62 = u32(16i);
    let _e930 = local_61;
    local_198 = _e930;
    let _e932 = local_62;
    let _e934 = local_198[1];
    local_198[1] = (_e934 + _e932);
    let _e938 = local_198[0];
    local_199 = u32(_e938);
    let _e942 = local_198[1];
    local_200 = u32(_e942);
    let _e945 = local_200;
    out_1[_e945] = _e924;
    let _e947 = copy;
    local_66 = _e947;
    let _e949 = local_66;
    local_201 = _e949;
    let _e952 = local_201[0];
    local_202 = u32(_e952);
    let _e956 = local_201[1];
    local_203 = u32(_e956);
    let _e959 = local_202;
    switch _e959 {
        case 1u: {
            let _e960 = local_203;
            let _e962 = first[_e960];
            local_204 = _e962;
        }
        default: {
            let _e964 = local_203;
            let _e966 = second[_e964];
            local_204 = _e966;
        }
    }
    let _e969 = local_204;
    local_82 = _e969;
    let _e971 = local_82;
    let _e972 = out;
    local_64 = _e972;
    local_65 = u32(17i);
    let _e977 = local_64;
    local_205 = _e977;
    let _e979 = local_65;
    let _e981 = local_205[1];
    local_205[1] = (_e981 + _e979);
    let _e985 = local_205[0];
    local_206 = u32(_e985);
    let _e989 = local_205[1];
    local_207 = u32(_e989);
    let _e992 = local_207;
    out_1[_e992] = _e971;
}
