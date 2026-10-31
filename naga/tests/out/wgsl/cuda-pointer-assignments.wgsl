@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

@compute @workgroup_size(1, 1, 1)
fn pointer_assignments() {
    var local: array<u32, 2>;
    var first: array<i32, 4>;
    var second: array<i32, 4>;
    var choose: bool;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: array<u32, 2>;
    var local_5: array<u32, 2>;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: i32;
    var local_17: u32;
    var local_18: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: array<u32, 2>;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var local_25: array<u32, 2>;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var iteration: i32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: array<u32, 2>;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: array<u32, 2>;
    var local_54: array<u32, 2>;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: array<u32, 2>;
    var local_60: array<u32, 2>;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: array<u32, 2>;
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
    var local_83: i32;
    var local_84: i32;
    var local_85: i32;
    var local_86: i32;
    var local_87: i32;
    var local_88: array<u32, 2>;
    var local_89: u32;
    var local_90: u32;
    var local_91: i32;
    var local_92: array<u32, 2>;
    var local_93: array<u32, 2>;
    var local_94: u32;
    var local_95: u32;
    var local_96: i32;
    var local_97: array<u32, 2>;
    var local_98: u32;
    var local_99: u32;
    var local_100: array<u32, 2>;
    var local_101: u32;
    var local_102: u32;
    var local_103: i32;
    var local_104: array<u32, 2>;
    var local_105: u32;
    var local_106: u32;
    var local_107: array<u32, 2>;
    var local_108: u32;
    var local_109: u32;
    var local_110: i32;
    var local_111: array<u32, 2>;
    var local_112: u32;
    var local_113: u32;
    var local_114: array<u32, 2>;
    var local_115: array<u32, 2>;
    var local_116: array<u32, 2>;
    var local_117: u32;
    var local_118: u32;
    var local_119: i32;
    var local_120: array<u32, 2>;
    var local_121: u32;
    var local_122: u32;
    var local_123: array<u32, 2>;
    var local_124: array<u32, 2>;
    var local_125: u32;
    var local_126: u32;
    var local_127: i32;
    var local_128: array<u32, 2>;
    var local_129: u32;
    var local_130: u32;
    var local_131: i32;
    var local_132: array<u32, 2>;
    var local_133: u32;
    var local_134: u32;
    var local_135: array<u32, 2>;
    var local_136: u32;
    var local_137: u32;
    var local_138: i32;
    var local_139: array<u32, 2>;
    var local_140: u32;
    var local_141: u32;
    var local_142: array<u32, 2>;
    var local_143: u32;
    var local_144: u32;
    var local_145: i32;
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
    var local_156: array<u32, 2>;
    var local_157: u32;
    var local_158: u32;
    var local_159: i32;
    var local_160: array<u32, 2>;
    var local_161: u32;
    var local_162: u32;
    var local_163: array<u32, 2>;
    var local_164: array<u32, 2>;
    var local_165: array<u32, 2>;
    var local_166: u32;
    var local_167: u32;
    var local_168: i32;
    var local_169: array<u32, 2>;
    var local_170: u32;
    var local_171: u32;
    var local_172: array<u32, 2>;
    var local_173: array<u32, 2>;
    var local_174: array<u32, 2>;
    var local_175: u32;
    var local_176: u32;
    var local_177: i32;
    var local_178: array<u32, 2>;
    var local_179: u32;
    var local_180: u32;
    var local_181: array<u32, 2>;
    var local_182: array<u32, 2>;
    var local_183: array<u32, 2>;
    var local_184: u32;
    var local_185: u32;
    var local_186: i32;
    var local_187: array<u32, 2>;
    var local_188: u32;
    var local_189: u32;
    var local_190: array<u32, 2>;
    var local_191: array<u32, 2>;
    var local_192: u32;
    var local_193: u32;
    var local_194: i32;
    var local_195: array<u32, 2>;
    var local_196: u32;
    var local_197: u32;
    var local_198: array<u32, 2>;
    var local_199: array<u32, 2>;
    var local_200: u32;
    var local_201: u32;
    var local_202: i32;
    var local_203: array<u32, 2>;
    var local_204: u32;
    var local_205: u32;
    var local_206: array<u32, 2>;
    var local_207: u32;
    var local_208: u32;
    var local_209: i32;
    var local_210: array<u32, 2>;
    var local_211: u32;
    var local_212: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    first[0] = 2i;
    first[1] = 3i;
    first[2] = 5i;
    first[3] = 7i;
    second[0] = 11i;
    second[1] = 13i;
    second[2] = 17i;
    second[3] = 19i;
    let _e27 = local;
    local_1 = _e27;
    local_2 = u32(30i);
    let _e32 = local_1;
    local_88 = _e32;
    let _e33 = local_2;
    let _e35 = local_88[1];
    local_88[1] = (_e35 + _e33);
    let _e39 = local_88[0];
    local_89 = u32(_e39);
    let _e43 = local_88[1];
    local_90 = u32(_e43);
    let _e47 = local_90;
    let _e49 = out[_e47];
    local_91 = _e49;
    let _e50 = local_91;
    local_72 = _e50;
    let _e52 = local_72;
    choose = (_e52 != 0i);
    local_3 = array<u32, 2>();
    local_3[0] = 1u;
    local_3[1] = 0u;
    let _e64 = local_3;
    local_4 = _e64;
    let _e66 = local_4;
    local_5 = _e66;
    let _e68 = local_3;
    local_6 = _e68;
    local_7 = u32(1i);
    local_92 = array<u32, 2>();
    local_92[0] = 2u;
    local_92[1] = 0u;
    let _e78 = local_7;
    let _e80 = local_92[1];
    local_92[1] = (_e80 + _e78);
    let _e83 = local_92;
    local_3 = _e83;
    let _e85 = local_3;
    local_10 = _e85;
    let _e87 = local_10;
    local_93 = _e87;
    let _e89 = local_93[0];
    local_94 = u32(_e89);
    let _e93 = local_93[1];
    local_95 = u32(_e93);
    let _e97 = local_94;
    switch _e97 {
        case 1u: {
            let _e98 = local_95;
            let _e100 = first[_e98];
            local_96 = _e100;
        }
        default: {
            let _e101 = local_95;
            let _e103 = second[_e101];
            local_96 = _e103;
        }
    }
    let _e104 = local_96;
    local_73 = _e104;
    let _e106 = local_73;
    let _e108 = local;
    local_8 = _e108;
    local_9 = u32(0i);
    let _e113 = local_8;
    local_97 = _e113;
    let _e114 = local_9;
    let _e116 = local_97[1];
    local_97[1] = (_e116 + _e114);
    let _e120 = local_97[0];
    local_98 = u32(_e120);
    let _e124 = local_97[1];
    local_99 = u32(_e124);
    let _e127 = local_99;
    out[_e127] = _e106;
    let _e131 = local_5;
    local_13 = _e131;
    let _e133 = local_13;
    local_100 = _e133;
    let _e135 = local_100[0];
    local_101 = u32(_e135);
    let _e139 = local_100[1];
    local_102 = u32(_e139);
    let _e143 = local_101;
    switch _e143 {
        case 1u: {
            let _e144 = local_102;
            let _e146 = first[_e144];
            local_103 = _e146;
        }
        default: {
            let _e147 = local_102;
            let _e149 = second[_e147];
            local_103 = _e149;
        }
    }
    let _e150 = local_103;
    local_74 = _e150;
    let _e152 = local_74;
    let _e154 = local;
    local_11 = _e154;
    local_12 = u32(1i);
    let _e159 = local_11;
    local_104 = _e159;
    let _e160 = local_12;
    let _e162 = local_104[1];
    local_104[1] = (_e162 + _e160);
    let _e166 = local_104[0];
    local_105 = u32(_e166);
    let _e170 = local_104[1];
    local_106 = u32(_e170);
    let _e173 = local_106;
    out[_e173] = _e152;
    let _e176 = local_6;
    local_107 = _e176;
    let _e178 = local_107[0];
    local_108 = u32(_e178);
    let _e182 = local_107[1];
    local_109 = u32(_e182);
    let _e186 = local_108;
    switch _e186 {
        case 1u: {
            let _e187 = local_109;
            let _e189 = first[_e187];
            local_110 = _e189;
        }
        default: {
            let _e190 = local_109;
            let _e192 = second[_e190];
            local_110 = _e192;
        }
    }
    let _e193 = local_110;
    local_75 = _e193;
    let _e195 = local_75;
    local_16 = _e195;
    let _e197 = local_16;
    let _e199 = local;
    local_14 = _e199;
    local_15 = u32(2i);
    let _e204 = local_14;
    local_111 = _e204;
    let _e205 = local_15;
    let _e207 = local_111[1];
    local_111[1] = (_e207 + _e205);
    let _e211 = local_111[0];
    local_112 = u32(_e211);
    let _e215 = local_111[1];
    local_113 = u32(_e215);
    let _e218 = local_113;
    out[_e218] = _e197;
    let _e220 = choose;
    if _e220 {
        local_17 = u32(2i);
        local_114 = array<u32, 2>();
        local_114[0] = 1u;
        local_114[1] = 0u;
        let _e230 = local_17;
        let _e232 = local_114[1];
        local_114[1] = (_e232 + _e230);
        let _e235 = local_114;
        local_3 = _e235;
    } else {
        local_18 = u32(2i);
        local_115 = array<u32, 2>();
        local_115[0] = 2u;
        local_115[1] = 0u;
        let _e245 = local_18;
        let _e247 = local_115[1];
        local_115[1] = (_e247 + _e245);
        let _e250 = local_115;
        local_3 = _e250;
    }
    let _e252 = local_3;
    local_21 = _e252;
    let _e254 = local_21;
    local_116 = _e254;
    let _e256 = local_116[0];
    local_117 = u32(_e256);
    let _e260 = local_116[1];
    local_118 = u32(_e260);
    let _e264 = local_117;
    switch _e264 {
        case 1u: {
            let _e265 = local_118;
            let _e267 = first[_e265];
            local_119 = _e267;
        }
        default: {
            let _e268 = local_118;
            let _e270 = second[_e268];
            local_119 = _e270;
        }
    }
    let _e271 = local_119;
    local_76 = _e271;
    let _e273 = local_76;
    let _e275 = local;
    local_19 = _e275;
    local_20 = u32(3i);
    let _e280 = local_19;
    local_120 = _e280;
    let _e281 = local_20;
    let _e283 = local_120[1];
    local_120[1] = (_e283 + _e281);
    let _e287 = local_120[0];
    local_121 = u32(_e287);
    let _e291 = local_120[1];
    local_122 = u32(_e291);
    let _e294 = local_122;
    out[_e294] = _e273;
    let _e297 = local_3;
    local_22 = _e297;
    let _e299 = local_22;
    local_23 = _e299;
    local_24 = u32(1i);
    local_123 = array<u32, 2>();
    local_123[0] = 1u;
    local_123[1] = 0u;
    let _e309 = local_24;
    let _e311 = local_123[1];
    local_123[1] = (_e311 + _e309);
    let _e314 = local_123;
    local_3 = _e314;
    let _e317 = local_23;
    local_25 = _e317;
    let _e319 = local_25;
    local_124 = _e319;
    let _e321 = local_124[0];
    local_125 = u32(_e321);
    let _e325 = local_124[1];
    local_126 = u32(_e325);
    let _e329 = local_125;
    switch _e329 {
        case 1u: {
            let _e330 = local_126;
            let _e332 = first[_e330];
            local_127 = _e332;
        }
        default: {
            let _e333 = local_126;
            let _e335 = second[_e333];
            local_127 = _e335;
        }
    }
    let _e336 = local_127;
    local_77 = _e336;
    let _e338 = local_77;
    let _e340 = (_e338 + 20i);
    let _e341 = local_125;
    switch _e341 {
        case 1u: {
            let _e342 = local_126;
            first[_e342] = _e340;
        }
        default: {
            let _e344 = local_126;
            second[_e344] = _e340;
        }
    }
    let _e347 = local_3;
    local_28 = _e347;
    let _e349 = local_28;
    local_128 = _e349;
    let _e351 = local_128[0];
    local_129 = u32(_e351);
    let _e355 = local_128[1];
    local_130 = u32(_e355);
    let _e359 = local_129;
    switch _e359 {
        case 1u: {
            let _e360 = local_130;
            let _e362 = first[_e360];
            local_131 = _e362;
        }
        default: {
            let _e363 = local_130;
            let _e365 = second[_e363];
            local_131 = _e365;
        }
    }
    let _e366 = local_131;
    local_78 = _e366;
    let _e368 = local_78;
    let _e370 = local;
    local_26 = _e370;
    local_27 = u32(4i);
    let _e375 = local_26;
    local_132 = _e375;
    let _e376 = local_27;
    let _e378 = local_132[1];
    local_132[1] = (_e378 + _e376);
    let _e382 = local_132[0];
    local_133 = u32(_e382);
    let _e386 = local_132[1];
    local_134 = u32(_e386);
    let _e389 = local_134;
    out[_e389] = _e368;
    let _e392 = local_23;
    local_31 = _e392;
    let _e394 = local_31;
    local_135 = _e394;
    let _e396 = local_135[0];
    local_136 = u32(_e396);
    let _e400 = local_135[1];
    local_137 = u32(_e400);
    let _e404 = local_136;
    switch _e404 {
        case 1u: {
            let _e405 = local_137;
            let _e407 = first[_e405];
            local_138 = _e407;
        }
        default: {
            let _e408 = local_137;
            let _e410 = second[_e408];
            local_138 = _e410;
        }
    }
    let _e411 = local_138;
    local_79 = _e411;
    let _e413 = local_79;
    let _e415 = local;
    local_29 = _e415;
    local_30 = u32(5i);
    let _e420 = local_29;
    local_139 = _e420;
    let _e421 = local_30;
    let _e423 = local_139[1];
    local_139[1] = (_e423 + _e421);
    let _e427 = local_139[0];
    local_140 = u32(_e427);
    let _e431 = local_139[1];
    local_141 = u32(_e431);
    let _e434 = local_141;
    out[_e434] = _e413;
    let _e437 = local_5;
    local_34 = _e437;
    let _e439 = local_34;
    local_142 = _e439;
    let _e441 = local_142[0];
    local_143 = u32(_e441);
    let _e445 = local_142[1];
    local_144 = u32(_e445);
    let _e449 = local_143;
    switch _e449 {
        case 1u: {
            let _e450 = local_144;
            let _e452 = first[_e450];
            local_145 = _e452;
        }
        default: {
            let _e453 = local_144;
            let _e455 = second[_e453];
            local_145 = _e455;
        }
    }
    let _e456 = local_145;
    local_80 = _e456;
    let _e458 = local_80;
    let _e460 = local;
    local_32 = _e460;
    local_33 = u32(6i);
    let _e465 = local_32;
    local_146 = _e465;
    let _e466 = local_33;
    let _e468 = local_146[1];
    local_146[1] = (_e468 + _e466);
    let _e472 = local_146[0];
    local_147 = u32(_e472);
    let _e476 = local_146[1];
    local_148 = u32(_e476);
    let _e479 = local_148;
    out[_e479] = _e458;
    let _e483 = first[2i];
    let _e485 = local;
    local_35 = _e485;
    local_36 = u32(7i);
    let _e490 = local_35;
    local_149 = _e490;
    let _e491 = local_36;
    let _e493 = local_149[1];
    local_149[1] = (_e493 + _e491);
    let _e497 = local_149[0];
    local_150 = u32(_e497);
    let _e501 = local_149[1];
    local_151 = u32(_e501);
    let _e504 = local_151;
    out[_e504] = _e483;
    let _e508 = second[2i];
    let _e510 = local;
    local_37 = _e510;
    local_38 = u32(8i);
    let _e515 = local_37;
    local_152 = _e515;
    let _e516 = local_38;
    let _e518 = local_152[1];
    local_152[1] = (_e518 + _e516);
    let _e522 = local_152[0];
    local_153 = u32(_e522);
    let _e526 = local_152[1];
    local_154 = u32(_e526);
    let _e529 = local_154;
    out[_e529] = _e508;
    local_155 = array<u32, 2>();
    local_155[0] = 1u;
    local_155[1] = 0u;
    let _e537 = local_155;
    local_3 = _e537;
    {
        iteration = 0i;
        loop {
            let _e540 = iteration;
            if (_e540 < 3i) {
            } else {
                break;
            }
            let _e544 = local_3;
            local_41 = _e544;
            let _e546 = local_41;
            local_156 = _e546;
            let _e548 = local_156[0];
            local_157 = u32(_e548);
            let _e552 = local_156[1];
            local_158 = u32(_e552);
            let _e556 = local_157;
            switch _e556 {
                case 1u: {
                    let _e557 = local_158;
                    let _e559 = first[_e557];
                    local_159 = _e559;
                }
                default: {
                    let _e560 = local_158;
                    let _e562 = second[_e560];
                    local_159 = _e562;
                }
            }
            let _e563 = local_159;
            local_81 = _e563;
            let _e565 = local_81;
            let _e567 = local;
            local_39 = _e567;
            let _e568 = iteration;
            local_40 = u32((9i + _e568));
            let _e574 = local_39;
            local_160 = _e574;
            let _e575 = local_40;
            let _e577 = local_160[1];
            local_160[1] = (_e577 + _e575);
            let _e581 = local_160[0];
            local_161 = u32(_e581);
            let _e585 = local_160[1];
            local_162 = u32(_e585);
            let _e588 = local_162;
            out[_e588] = _e565;
            let _e590 = iteration;
            if (_e590 == 0i) {
                local_42 = u32(1i);
                local_163 = array<u32, 2>();
                local_163[0] = 2u;
                local_163[1] = 0u;
                let _e602 = local_42;
                let _e604 = local_163[1];
                local_163[1] = (_e604 + _e602);
                let _e607 = local_163;
                local_3 = _e607;
            } else {
                local_43 = u32(3i);
                local_164 = array<u32, 2>();
                local_164[0] = 1u;
                local_164[1] = 0u;
                let _e617 = local_43;
                let _e619 = local_164[1];
                local_164[1] = (_e619 + _e617);
                let _e622 = local_164;
                local_3 = _e622;
            }
            continuing {
                let _e623 = iteration;
                iteration = (_e623 + 1i);
            }
        }
    }
    let _e627 = local_3;
    local_46 = _e627;
    let _e629 = local_46;
    local_165 = _e629;
    let _e631 = local_165[0];
    local_166 = u32(_e631);
    let _e635 = local_165[1];
    local_167 = u32(_e635);
    let _e639 = local_166;
    switch _e639 {
        case 1u: {
            let _e640 = local_167;
            let _e642 = first[_e640];
            local_168 = _e642;
        }
        default: {
            let _e643 = local_167;
            let _e645 = second[_e643];
            local_168 = _e645;
        }
    }
    let _e646 = local_168;
    local_82 = _e646;
    let _e648 = local_82;
    let _e650 = local;
    local_44 = _e650;
    local_45 = u32(12i);
    let _e655 = local_44;
    local_169 = _e655;
    let _e656 = local_45;
    let _e658 = local_169[1];
    local_169[1] = (_e658 + _e656);
    let _e662 = local_169[0];
    local_170 = u32(_e662);
    let _e666 = local_169[1];
    local_171 = u32(_e666);
    let _e669 = local_171;
    out[_e669] = _e648;
    let _e672 = local_5;
    local_47 = _e672;
    let _e674 = local_47;
    local_172 = _e674;
    let _e675 = local_172;
    local_3 = _e675;
    let _e677 = local_3;
    local_48 = _e677;
    local_49 = u32(1i);
    let _e682 = local_48;
    local_173 = _e682;
    let _e683 = local_49;
    let _e685 = local_173[1];
    local_173[1] = (_e685 + _e683);
    let _e688 = local_173;
    local_3 = _e688;
    let _e690 = local_3;
    local_52 = _e690;
    let _e692 = local_52;
    local_174 = _e692;
    let _e694 = local_174[0];
    local_175 = u32(_e694);
    let _e698 = local_174[1];
    local_176 = u32(_e698);
    let _e702 = local_175;
    switch _e702 {
        case 1u: {
            let _e703 = local_176;
            let _e705 = first[_e703];
            local_177 = _e705;
        }
        default: {
            let _e706 = local_176;
            let _e708 = second[_e706];
            local_177 = _e708;
        }
    }
    let _e709 = local_177;
    local_83 = _e709;
    let _e711 = local_83;
    let _e713 = local;
    local_50 = _e713;
    local_51 = u32(13i);
    let _e718 = local_50;
    local_178 = _e718;
    let _e719 = local_51;
    let _e721 = local_178[1];
    local_178[1] = (_e721 + _e719);
    let _e725 = local_178[0];
    local_179 = u32(_e725);
    let _e729 = local_178[1];
    local_180 = u32(_e729);
    let _e732 = local_180;
    out[_e732] = _e711;
    let _e735 = local_5;
    local_53 = _e735;
    let _e737 = local_53;
    local_181 = _e737;
    let _e738 = local_181;
    local_3 = _e738;
    let _e740 = local_3;
    local_54 = _e740;
    let _e742 = local_54;
    local_182 = _e742;
    let _e743 = local_182;
    local_5 = _e743;
    let _e745 = local_5;
    local_57 = _e745;
    let _e747 = local_57;
    local_183 = _e747;
    let _e749 = local_183[0];
    local_184 = u32(_e749);
    let _e753 = local_183[1];
    local_185 = u32(_e753);
    let _e757 = local_184;
    switch _e757 {
        case 1u: {
            let _e758 = local_185;
            let _e760 = first[_e758];
            local_186 = _e760;
        }
        default: {
            let _e761 = local_185;
            let _e763 = second[_e761];
            local_186 = _e763;
        }
    }
    let _e764 = local_186;
    local_84 = _e764;
    let _e766 = local_84;
    let _e768 = local;
    local_55 = _e768;
    local_56 = u32(14i);
    let _e773 = local_55;
    local_187 = _e773;
    let _e774 = local_56;
    let _e776 = local_187[1];
    local_187[1] = (_e776 + _e774);
    let _e780 = local_187[0];
    local_188 = u32(_e780);
    let _e784 = local_187[1];
    local_189 = u32(_e784);
    let _e787 = local_189;
    out[_e787] = _e766;
    local_58 = u32(4i);
    local_59 = array<u32, 2>();
    local_59[0] = 1u;
    local_59[1] = 0u;
    let _e798 = local_58;
    let _e800 = local_59[1];
    local_59[1] = (_e800 + _e798);
    let _e805 = local_59;
    local_60 = _e805;
    let _e807 = local_60;
    local_190 = _e807;
    let _e808 = local_190;
    local_3 = _e808;
    let _e810 = local_3;
    local_63 = _e810;
    local_64 = u32(1i);
    let _e815 = local_63;
    local_191 = _e815;
    let _e816 = local_64;
    let _e818 = local_191[1];
    local_191[1] = (_e818 - _e816);
    let _e822 = local_191[0];
    local_192 = u32(_e822);
    let _e826 = local_191[1];
    local_193 = u32(_e826);
    let _e830 = local_192;
    switch _e830 {
        case 1u: {
            let _e831 = local_193;
            let _e833 = first[_e831];
            local_194 = _e833;
        }
        default: {
            let _e834 = local_193;
            let _e836 = second[_e834];
            local_194 = _e836;
        }
    }
    let _e837 = local_194;
    local_85 = _e837;
    let _e839 = local_85;
    let _e841 = local;
    local_61 = _e841;
    local_62 = u32(15i);
    let _e846 = local_61;
    local_195 = _e846;
    let _e847 = local_62;
    let _e849 = local_195[1];
    local_195[1] = (_e849 + _e847);
    let _e853 = local_195[0];
    local_196 = u32(_e853);
    let _e857 = local_195[1];
    local_197 = u32(_e857);
    let _e860 = local_197;
    out[_e860] = _e839;
    local_198 = array<u32, 2>();
    local_198[0] = 2u;
    local_198[1] = 0u;
    let _e868 = local_198;
    local_3 = _e868;
    let _e870 = local_3;
    local_65 = _e870;
    let _e873 = local_3[1];
    local_3[1] = (_e873 + 1u);
    let _e877 = local_3;
    local_68 = _e877;
    let _e879 = local_68;
    local_199 = _e879;
    let _e881 = local_199[0];
    local_200 = u32(_e881);
    let _e885 = local_199[1];
    local_201 = u32(_e885);
    let _e889 = local_200;
    switch _e889 {
        case 1u: {
            let _e890 = local_201;
            let _e892 = first[_e890];
            local_202 = _e892;
        }
        default: {
            let _e893 = local_201;
            let _e895 = second[_e893];
            local_202 = _e895;
        }
    }
    let _e896 = local_202;
    local_86 = _e896;
    let _e898 = local_86;
    let _e900 = local;
    local_66 = _e900;
    local_67 = u32(16i);
    let _e905 = local_66;
    local_203 = _e905;
    let _e906 = local_67;
    let _e908 = local_203[1];
    local_203[1] = (_e908 + _e906);
    let _e912 = local_203[0];
    local_204 = u32(_e912);
    let _e916 = local_203[1];
    local_205 = u32(_e916);
    let _e919 = local_205;
    out[_e919] = _e898;
    let _e922 = local_5;
    local_71 = _e922;
    let _e924 = local_71;
    local_206 = _e924;
    let _e926 = local_206[0];
    local_207 = u32(_e926);
    let _e930 = local_206[1];
    local_208 = u32(_e930);
    let _e934 = local_207;
    switch _e934 {
        case 1u: {
            let _e935 = local_208;
            let _e937 = first[_e935];
            local_209 = _e937;
        }
        default: {
            let _e938 = local_208;
            let _e940 = second[_e938];
            local_209 = _e940;
        }
    }
    let _e941 = local_209;
    local_87 = _e941;
    let _e943 = local_87;
    let _e945 = local;
    local_69 = _e945;
    local_70 = u32(17i);
    let _e950 = local_69;
    local_210 = _e950;
    let _e951 = local_70;
    let _e953 = local_210[1];
    local_210[1] = (_e953 + _e951);
    let _e957 = local_210[0];
    local_211 = u32(_e957);
    let _e961 = local_210[1];
    local_212 = u32(_e961);
    let _e964 = local_212;
    out[_e964] = _e943;
}
