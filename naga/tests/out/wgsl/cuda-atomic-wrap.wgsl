@group(0) @binding(0)
var<storage, read_write> output: array<atomic<u32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
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
    var index: u32;
    var local_63: u32;
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
    var local_126: u32;
    var local_127: u32;
    var local_128: u32;
    var local_129: u32;
    var local_130: u32;
    var local_131: u32;
    var local_132: u32;
    var local_133: u32;
    var local_134: u32;
    var local_135: u32;
    var local_136: u32;
    var local_137: u32;
    var local_138: u32;
    var local_139: u32;
    var local_140: u32;
    var local_141: u32;
    var local_142: u32;
    var local_143: u32;
    var local_144: u32;
    var local_145: u32;
    var local_146: u32;
    var local_147: u32;
    var local_148: u32;
    var local_149: u32;
    var local_150: u32;
    var local_151: u32;
    var local_152: u32;
    var local_153: u32;
    var local_154: u32;
    var local_155: u32;
    var local_156: u32;
    var local_157: u32;
    var local_158: u32;
    var local_159: u32;
    var local_160: u32;
    var local_161: u32;
    var local_162: u32;
    var local_163: u32;
    var local_164: u32;
    var local_165: u32;
    var local_166: u32;
    var local_167: u32;
    var local_168: u32;
    var local_169: u32;
    var local_170: u32;
    var local_171: u32;
    var local_172: u32;
    var local_173: u32;
    var local_174: u32;
    var local_175: u32;
    var local_176: u32;
    var local_177: u32;
    var local_178: u32;
    var local_179: u32;
    var local_180: u32;
    var local_181: u32;
    var local_182: u32;
    var local_183: u32;
    var local_184: u32;
    var local_185: u32;
    var local_186: u32;
    var local_187: u32;
    var local_188: u32;
    var local_189: u32;
    var local_190: u32;
    var local_191: u32;
    var local_192: u32;
    var local_193: u32;
    var local_194: u32;
    var local_195: u32;
    var local_196: u32;
    var local_197: u32;
    var local_198: u32;
    var local_199: u32;
    var local_200: u32;
    var local_201: u32;
    var local_202: u32;
    var local_203: u32;
    var local_204: u32;
    var local_205: u32;
    var local_206: u32;
    var local_207: u32;
    var local_208: u32;
    var local_209: u32;
    var local_210: u32;
    var local_211: u32;
    var local_212: u32;
    var local_213: u32;
    var local_214: u32;
    var local_215: u32;

    local_1 = 0u;
    let _e2 = local_1;
    local_105 = u32(0u);
    let _e6 = local_105;
    let _e10 = atomicAdd((&output[_e6]), 0u);
    local_2 = _e10;
    loop {
        let _e12 = local_2;
        let _e17 = local_105;
        loop {
            let _e19 = atomicCompareExchangeWeak((&output[_e17]), _e12, select((_e12 + 1u), 0u, (_e12 >= _e2)));
            local_192 = _e19.old_value;
            if (_e19.exchanged || (_e19.old_value != _e12)) {
                break;
            }
        }
        let _e26 = local_192;
        local_106 = _e26;
        let _e28 = local_106;
        local_2 = _e28;
        if (_e28 == _e12) {
            break;
        }
    }
    let _e30 = local_2;
    local = u32(16i);
    let _e34 = local;
    local_107 = u32(_e34);
    let _e37 = local_107;
    atomicStore((&output[_e37]), _e30);
    local_4 = u32(1i);
    local_5 = u32(1.75f);
    let _e45 = local_5;
    let _e46 = local_4;
    local_108 = u32(_e46);
    let _e49 = local_108;
    let _e52 = atomicAdd((&output[_e49]), 0u);
    local_6 = _e52;
    loop {
        let _e54 = local_6;
        let _e59 = local_108;
        loop {
            let _e61 = atomicCompareExchangeWeak((&output[_e59]), _e54, select((_e54 + 1u), 0u, (_e54 >= _e45)));
            local_193 = _e61.old_value;
            if (_e61.exchanged || (_e61.old_value != _e54)) {
                break;
            }
        }
        let _e68 = local_193;
        local_109 = _e68;
        let _e70 = local_109;
        local_6 = _e70;
        if (_e70 == _e54) {
            break;
        }
    }
    let _e72 = local_6;
    local_3 = u32(17i);
    let _e76 = local_3;
    local_110 = u32(_e76);
    let _e79 = local_110;
    atomicStore((&output[_e79]), _e72);
    local_8 = u32(2i);
    local_9 = 1u;
    let _e86 = local_9;
    let _e87 = local_8;
    local_111 = u32(_e87);
    let _e90 = local_111;
    let _e93 = atomicAdd((&output[_e90]), 0u);
    local_10 = _e93;
    loop {
        let _e95 = local_10;
        let _e100 = local_111;
        loop {
            let _e102 = atomicCompareExchangeWeak((&output[_e100]), _e95, select((_e95 + 1u), 0u, (_e95 >= _e86)));
            local_194 = _e102.old_value;
            if (_e102.exchanged || (_e102.old_value != _e95)) {
                break;
            }
        }
        let _e109 = local_194;
        local_112 = _e109;
        let _e111 = local_112;
        local_10 = _e111;
        if (_e111 == _e95) {
            break;
        }
    }
    let _e113 = local_10;
    local_7 = u32(18i);
    let _e117 = local_7;
    local_113 = u32(_e117);
    let _e120 = local_113;
    atomicStore((&output[_e120]), _e113);
    local_12 = u32(3i);
    local_13 = 1u;
    let _e127 = local_13;
    let _e128 = local_12;
    local_114 = u32(_e128);
    let _e131 = local_114;
    let _e134 = atomicAdd((&output[_e131]), 0u);
    local_14 = _e134;
    loop {
        let _e136 = local_14;
        let _e141 = local_114;
        loop {
            let _e143 = atomicCompareExchangeWeak((&output[_e141]), _e136, select((_e136 + 1u), 0u, (_e136 >= _e127)));
            local_195 = _e143.old_value;
            if (_e143.exchanged || (_e143.old_value != _e136)) {
                break;
            }
        }
        let _e150 = local_195;
        local_115 = _e150;
        let _e152 = local_115;
        local_14 = _e152;
        if (_e152 == _e136) {
            break;
        }
    }
    let _e154 = local_14;
    local_11 = u32(19i);
    let _e158 = local_11;
    local_116 = u32(_e158);
    let _e161 = local_116;
    atomicStore((&output[_e161]), _e154);
    local_16 = u32(4i);
    local_17 = u32(-(1i));
    let _e170 = local_17;
    let _e171 = local_16;
    local_117 = u32(_e171);
    let _e174 = local_117;
    let _e177 = atomicAdd((&output[_e174]), 0u);
    local_18 = _e177;
    loop {
        let _e179 = local_18;
        let _e184 = local_117;
        loop {
            let _e186 = atomicCompareExchangeWeak((&output[_e184]), _e179, select((_e179 + 1u), 0u, (_e179 >= _e170)));
            local_196 = _e186.old_value;
            if (_e186.exchanged || (_e186.old_value != _e179)) {
                break;
            }
        }
        let _e193 = local_196;
        local_118 = _e193;
        let _e195 = local_118;
        local_18 = _e195;
        if (_e195 == _e179) {
            break;
        }
    }
    let _e197 = local_18;
    local_15 = u32(20i);
    let _e201 = local_15;
    local_119 = u32(_e201);
    let _e204 = local_119;
    atomicStore((&output[_e204]), _e197);
    local_20 = u32(5i);
    local_21 = 4294967295u;
    let _e211 = local_21;
    let _e212 = local_20;
    local_120 = u32(_e212);
    let _e215 = local_120;
    let _e218 = atomicAdd((&output[_e215]), 0u);
    local_22 = _e218;
    loop {
        let _e220 = local_22;
        let _e225 = local_120;
        loop {
            let _e227 = atomicCompareExchangeWeak((&output[_e225]), _e220, select((_e220 + 1u), 0u, (_e220 >= _e211)));
            local_197 = _e227.old_value;
            if (_e227.exchanged || (_e227.old_value != _e220)) {
                break;
            }
        }
        let _e234 = local_197;
        local_121 = _e234;
        let _e236 = local_121;
        local_22 = _e236;
        if (_e236 == _e220) {
            break;
        }
    }
    let _e238 = local_22;
    local_19 = u32(21i);
    let _e242 = local_19;
    local_122 = u32(_e242);
    let _e245 = local_122;
    atomicStore((&output[_e245]), _e238);
    local_24 = u32(6i);
    local_25 = 2147483648u;
    let _e252 = local_25;
    let _e253 = local_24;
    local_123 = u32(_e253);
    let _e256 = local_123;
    let _e259 = atomicAdd((&output[_e256]), 0u);
    local_26 = _e259;
    loop {
        let _e261 = local_26;
        let _e266 = local_123;
        loop {
            let _e268 = atomicCompareExchangeWeak((&output[_e266]), _e261, select((_e261 + 1u), 0u, (_e261 >= _e252)));
            local_198 = _e268.old_value;
            if (_e268.exchanged || (_e268.old_value != _e261)) {
                break;
            }
        }
        let _e275 = local_198;
        local_124 = _e275;
        let _e277 = local_124;
        local_26 = _e277;
        if (_e277 == _e261) {
            break;
        }
    }
    let _e279 = local_26;
    local_23 = u32(22i);
    let _e283 = local_23;
    local_125 = u32(_e283);
    let _e286 = local_125;
    atomicStore((&output[_e286]), _e279);
    local_28 = u32(7i);
    local_29 = 2147483648u;
    let _e293 = local_29;
    let _e294 = local_28;
    local_126 = u32(_e294);
    let _e297 = local_126;
    let _e300 = atomicAdd((&output[_e297]), 0u);
    local_30 = _e300;
    loop {
        let _e302 = local_30;
        let _e307 = local_126;
        loop {
            let _e309 = atomicCompareExchangeWeak((&output[_e307]), _e302, select((_e302 + 1u), 0u, (_e302 >= _e293)));
            local_199 = _e309.old_value;
            if (_e309.exchanged || (_e309.old_value != _e302)) {
                break;
            }
        }
        let _e316 = local_199;
        local_127 = _e316;
        let _e318 = local_127;
        local_30 = _e318;
        if (_e318 == _e302) {
            break;
        }
    }
    let _e320 = local_30;
    local_27 = u32(23i);
    let _e324 = local_27;
    local_128 = u32(_e324);
    let _e327 = local_128;
    atomicStore((&output[_e327]), _e320);
    local_32 = u32(8i);
    local_33 = 0u;
    let _e334 = local_33;
    let _e335 = local_32;
    local_129 = u32(_e335);
    let _e338 = local_129;
    let _e341 = atomicAdd((&output[_e338]), 0u);
    local_34 = _e341;
    loop {
        let _e343 = local_34;
        let _e350 = local_129;
        loop {
            let _e352 = atomicCompareExchangeWeak((&output[_e350]), _e343, select((_e343 - 1u), _e334, ((_e343 == 0u) || (_e343 > _e334))));
            local_200 = _e352.old_value;
            if (_e352.exchanged || (_e352.old_value != _e343)) {
                break;
            }
        }
        let _e359 = local_200;
        local_130 = _e359;
        let _e361 = local_130;
        local_34 = _e361;
        if (_e361 == _e343) {
            break;
        }
    }
    let _e363 = local_34;
    local_31 = u32(24i);
    let _e367 = local_31;
    local_131 = u32(_e367);
    let _e370 = local_131;
    atomicStore((&output[_e370]), _e363);
    local_36 = u32(9i);
    local_37 = u32(1.75f);
    let _e378 = local_37;
    let _e379 = local_36;
    local_132 = u32(_e379);
    let _e382 = local_132;
    let _e385 = atomicAdd((&output[_e382]), 0u);
    local_38 = _e385;
    loop {
        let _e387 = local_38;
        let _e394 = local_132;
        loop {
            let _e396 = atomicCompareExchangeWeak((&output[_e394]), _e387, select((_e387 - 1u), _e378, ((_e387 == 0u) || (_e387 > _e378))));
            local_201 = _e396.old_value;
            if (_e396.exchanged || (_e396.old_value != _e387)) {
                break;
            }
        }
        let _e403 = local_201;
        local_133 = _e403;
        let _e405 = local_133;
        local_38 = _e405;
        if (_e405 == _e387) {
            break;
        }
    }
    let _e407 = local_38;
    local_35 = u32(25i);
    let _e411 = local_35;
    local_134 = u32(_e411);
    let _e414 = local_134;
    atomicStore((&output[_e414]), _e407);
    local_40 = u32(10i);
    local_41 = 1u;
    let _e421 = local_41;
    let _e422 = local_40;
    local_135 = u32(_e422);
    let _e425 = local_135;
    let _e428 = atomicAdd((&output[_e425]), 0u);
    local_42 = _e428;
    loop {
        let _e430 = local_42;
        let _e437 = local_135;
        loop {
            let _e439 = atomicCompareExchangeWeak((&output[_e437]), _e430, select((_e430 - 1u), _e421, ((_e430 == 0u) || (_e430 > _e421))));
            local_202 = _e439.old_value;
            if (_e439.exchanged || (_e439.old_value != _e430)) {
                break;
            }
        }
        let _e446 = local_202;
        local_136 = _e446;
        let _e448 = local_136;
        local_42 = _e448;
        if (_e448 == _e430) {
            break;
        }
    }
    let _e450 = local_42;
    local_39 = u32(26i);
    let _e454 = local_39;
    local_137 = u32(_e454);
    let _e457 = local_137;
    atomicStore((&output[_e457]), _e450);
    local_44 = u32(11i);
    local_45 = 1u;
    let _e464 = local_45;
    let _e465 = local_44;
    local_138 = u32(_e465);
    let _e468 = local_138;
    let _e471 = atomicAdd((&output[_e468]), 0u);
    local_46 = _e471;
    loop {
        let _e473 = local_46;
        let _e480 = local_138;
        loop {
            let _e482 = atomicCompareExchangeWeak((&output[_e480]), _e473, select((_e473 - 1u), _e464, ((_e473 == 0u) || (_e473 > _e464))));
            local_203 = _e482.old_value;
            if (_e482.exchanged || (_e482.old_value != _e473)) {
                break;
            }
        }
        let _e489 = local_203;
        local_139 = _e489;
        let _e491 = local_139;
        local_46 = _e491;
        if (_e491 == _e473) {
            break;
        }
    }
    let _e493 = local_46;
    local_43 = u32(27i);
    let _e497 = local_43;
    local_140 = u32(_e497);
    let _e500 = local_140;
    atomicStore((&output[_e500]), _e493);
    local_48 = u32(12i);
    local_49 = u32(-(1i));
    let _e509 = local_49;
    let _e510 = local_48;
    local_141 = u32(_e510);
    let _e513 = local_141;
    let _e516 = atomicAdd((&output[_e513]), 0u);
    local_50 = _e516;
    loop {
        let _e518 = local_50;
        let _e525 = local_141;
        loop {
            let _e527 = atomicCompareExchangeWeak((&output[_e525]), _e518, select((_e518 - 1u), _e509, ((_e518 == 0u) || (_e518 > _e509))));
            local_204 = _e527.old_value;
            if (_e527.exchanged || (_e527.old_value != _e518)) {
                break;
            }
        }
        let _e534 = local_204;
        local_142 = _e534;
        let _e536 = local_142;
        local_50 = _e536;
        if (_e536 == _e518) {
            break;
        }
    }
    let _e538 = local_50;
    local_47 = u32(28i);
    let _e542 = local_47;
    local_143 = u32(_e542);
    let _e545 = local_143;
    atomicStore((&output[_e545]), _e538);
    local_52 = u32(13i);
    local_53 = 4294967295u;
    let _e552 = local_53;
    let _e553 = local_52;
    local_144 = u32(_e553);
    let _e556 = local_144;
    let _e559 = atomicAdd((&output[_e556]), 0u);
    local_54 = _e559;
    loop {
        let _e561 = local_54;
        let _e568 = local_144;
        loop {
            let _e570 = atomicCompareExchangeWeak((&output[_e568]), _e561, select((_e561 - 1u), _e552, ((_e561 == 0u) || (_e561 > _e552))));
            local_205 = _e570.old_value;
            if (_e570.exchanged || (_e570.old_value != _e561)) {
                break;
            }
        }
        let _e577 = local_205;
        local_145 = _e577;
        let _e579 = local_145;
        local_54 = _e579;
        if (_e579 == _e561) {
            break;
        }
    }
    let _e581 = local_54;
    local_51 = u32(29i);
    let _e585 = local_51;
    local_146 = u32(_e585);
    let _e588 = local_146;
    atomicStore((&output[_e588]), _e581);
    local_56 = u32(14i);
    local_57 = 1u;
    let _e595 = local_57;
    let _e596 = local_56;
    local_147 = u32(_e596);
    let _e599 = local_147;
    let _e602 = atomicAdd((&output[_e599]), 0u);
    local_58 = _e602;
    loop {
        let _e604 = local_58;
        let _e611 = local_147;
        loop {
            let _e613 = atomicCompareExchangeWeak((&output[_e611]), _e604, select((_e604 - 1u), _e595, ((_e604 == 0u) || (_e604 > _e595))));
            local_206 = _e613.old_value;
            if (_e613.exchanged || (_e613.old_value != _e604)) {
                break;
            }
        }
        let _e620 = local_206;
        local_148 = _e620;
        let _e622 = local_148;
        local_58 = _e622;
        if (_e622 == _e604) {
            break;
        }
    }
    let _e624 = local_58;
    local_55 = u32(30i);
    let _e628 = local_55;
    local_149 = u32(_e628);
    let _e631 = local_149;
    atomicStore((&output[_e631]), _e624);
    local_60 = u32(15i);
    local_61 = 2147483648u;
    let _e638 = local_61;
    let _e639 = local_60;
    local_150 = u32(_e639);
    let _e642 = local_150;
    let _e645 = atomicAdd((&output[_e642]), 0u);
    local_62 = _e645;
    loop {
        let _e647 = local_62;
        let _e654 = local_150;
        loop {
            let _e656 = atomicCompareExchangeWeak((&output[_e654]), _e647, select((_e647 - 1u), _e638, ((_e647 == 0u) || (_e647 > _e638))));
            local_207 = _e656.old_value;
            if (_e656.exchanged || (_e656.old_value != _e647)) {
                break;
            }
        }
        let _e663 = local_207;
        local_151 = _e663;
        let _e665 = local_151;
        local_62 = _e665;
        if (_e665 == _e647) {
            break;
        }
    }
    let _e667 = local_62;
    local_59 = u32(31i);
    let _e671 = local_59;
    local_152 = u32(_e671);
    let _e674 = local_152;
    atomicStore((&output[_e674]), _e667);
    {
        index = u32(0i);
        loop {
            let _e679 = index;
            if (_e679 < 16u) {
            } else {
                break;
            }
            let _e682 = index;
            local_64 = u32(_e682);
            let _e685 = local_64;
            local_153 = u32(_e685);
            let _e688 = local_153;
            let _e690 = atomicLoad((&output[_e688]));
            local_154 = _e690;
            let _e692 = local_154;
            local_104 = _e692;
            let _e694 = local_104;
            let _e695 = index;
            local_63 = u32((32u + _e695));
            let _e700 = local_63;
            local_155 = u32(_e700);
            let _e703 = local_155;
            atomicStore((&output[_e703]), _e694);
            continuing {
                let _e705 = index;
                index = (_e705 + u32(1i));
            }
        }
    }
    local_65 = 1u;
    let _e711 = local_65;
    local_156 = u32(0u);
    let _e715 = local_156;
    let _e718 = atomicAdd((&output[_e715]), 0u);
    local_66 = _e718;
    loop {
        let _e720 = local_66;
        let _e725 = local_156;
        loop {
            let _e727 = atomicCompareExchangeWeak((&output[_e725]), _e720, select((_e720 + 1u), 0u, (_e720 >= _e711)));
            local_208 = _e727.old_value;
            if (_e727.exchanged || (_e727.old_value != _e720)) {
                break;
            }
        }
        let _e734 = local_208;
        local_157 = _e734;
        let _e736 = local_157;
        local_66 = _e736;
        if (_e736 == _e720) {
            break;
        }
    }
    local_67 = u32(8i);
    local_68 = 1u;
    let _e743 = local_68;
    let _e744 = local_67;
    local_158 = u32(_e744);
    let _e747 = local_158;
    let _e750 = atomicAdd((&output[_e747]), 0u);
    local_69 = _e750;
    loop {
        let _e752 = local_69;
        let _e759 = local_158;
        loop {
            let _e761 = atomicCompareExchangeWeak((&output[_e759]), _e752, select((_e752 - 1u), _e743, ((_e752 == 0u) || (_e752 > _e743))));
            local_209 = _e761.old_value;
            if (_e761.exchanged || (_e761.old_value != _e752)) {
                break;
            }
        }
        let _e768 = local_209;
        local_159 = _e768;
        let _e770 = local_159;
        local_69 = _e770;
        if (_e770 == _e752) {
            break;
        }
    }
    local_71 = u32(0i);
    let _e775 = local_71;
    local_160 = u32(_e775);
    let _e778 = local_160;
    let _e780 = atomicLoad((&output[_e778]));
    local_70 = u32(48i);
    let _e784 = local_70;
    local_161 = u32(_e784);
    let _e787 = local_161;
    atomicStore((&output[_e787]), _e780);
    local_73 = u32(8i);
    let _e792 = local_73;
    local_162 = u32(_e792);
    let _e795 = local_162;
    let _e797 = atomicLoad((&output[_e795]));
    local_72 = u32(49i);
    let _e801 = local_72;
    local_163 = u32(_e801);
    let _e804 = local_163;
    atomicStore((&output[_e804]), _e797);
    local_74 = u32(50i);
    let _e809 = local_74;
    local_164 = u32(_e809);
    let _e812 = local_164;
    atomicStore((&output[_e812]), 2u);
    local_76 = u32(50i);
    local_77 = u32(50i);
    let _e821 = local_77;
    local_165 = u32(_e821);
    let _e824 = local_165;
    let _e826 = atomicLoad((&output[_e824]));
    let _e830 = local_165;
    atomicStore((&output[_e830]), (_e826 + u32(1i)));
    let _e832 = local_76;
    local_166 = u32(_e832);
    let _e835 = local_166;
    let _e838 = atomicAdd((&output[_e835]), 0u);
    local_78 = _e838;
    loop {
        let _e840 = local_78;
        let _e845 = local_166;
        loop {
            let _e847 = atomicCompareExchangeWeak((&output[_e845]), _e840, select((_e840 + 1u), 0u, (_e840 >= _e826)));
            local_210 = _e847.old_value;
            if (_e847.exchanged || (_e847.old_value != _e840)) {
                break;
            }
        }
        let _e854 = local_210;
        local_167 = _e854;
        let _e856 = local_167;
        local_78 = _e856;
        if (_e856 == _e840) {
            break;
        }
    }
    let _e858 = local_78;
    local_75 = u32(51i);
    let _e862 = local_75;
    local_168 = u32(_e862);
    let _e865 = local_168;
    atomicStore((&output[_e865]), _e858);
    local_80 = u32(50i);
    let _e870 = local_80;
    local_169 = u32(_e870);
    let _e873 = local_169;
    let _e875 = atomicLoad((&output[_e873]));
    local_79 = u32(52i);
    let _e879 = local_79;
    local_170 = u32(_e879);
    let _e882 = local_170;
    atomicStore((&output[_e882]), _e875);
    local_82 = u32(50i);
    local_83 = u32(50i);
    let _e890 = local_83;
    local_171 = u32(_e890);
    let _e893 = local_171;
    let _e895 = atomicLoad((&output[_e893]));
    let _e899 = local_171;
    atomicStore((&output[_e899]), (_e895 + u32(1i)));
    let _e901 = local_82;
    local_172 = u32(_e901);
    let _e904 = local_172;
    let _e907 = atomicAdd((&output[_e904]), 0u);
    local_84 = _e907;
    loop {
        let _e909 = local_84;
        let _e916 = local_172;
        loop {
            let _e918 = atomicCompareExchangeWeak((&output[_e916]), _e909, select((_e909 - 1u), _e895, ((_e909 == 0u) || (_e909 > _e895))));
            local_211 = _e918.old_value;
            if (_e918.exchanged || (_e918.old_value != _e909)) {
                break;
            }
        }
        let _e925 = local_211;
        local_173 = _e925;
        let _e927 = local_173;
        local_84 = _e927;
        if (_e927 == _e909) {
            break;
        }
    }
    let _e929 = local_84;
    local_81 = u32(53i);
    let _e933 = local_81;
    local_174 = u32(_e933);
    let _e936 = local_174;
    atomicStore((&output[_e936]), _e929);
    local_86 = u32(50i);
    let _e941 = local_86;
    local_175 = u32(_e941);
    let _e944 = local_175;
    let _e946 = atomicLoad((&output[_e944]));
    local_85 = u32(54i);
    let _e950 = local_85;
    local_176 = u32(_e950);
    let _e953 = local_176;
    atomicStore((&output[_e953]), _e946);
    local_87 = u32(50i);
    let _e958 = local_87;
    local_177 = u32(_e958);
    let _e961 = local_177;
    atomicStore((&output[_e961]), 2u);
    local_89 = u32(50i);
    local_90 = u32(50i);
    local_91 = 3u;
    let _e972 = local_91;
    let _e973 = local_90;
    local_178 = u32(_e973);
    let _e976 = local_178;
    let _e979 = atomicAdd((&output[_e976]), 0u);
    local_92 = _e979;
    loop {
        let _e981 = local_92;
        let _e986 = local_178;
        loop {
            let _e988 = atomicCompareExchangeWeak((&output[_e986]), _e981, select((_e981 + 1u), 0u, (_e981 >= _e972)));
            local_212 = _e988.old_value;
            if (_e988.exchanged || (_e988.old_value != _e981)) {
                break;
            }
        }
        let _e995 = local_212;
        local_179 = _e995;
        let _e997 = local_179;
        local_92 = _e997;
        if (_e997 == _e981) {
            break;
        }
    }
    let _e999 = local_92;
    let _e1000 = local_89;
    local_180 = u32(_e1000);
    let _e1003 = local_180;
    let _e1006 = atomicAdd((&output[_e1003]), 0u);
    local_93 = _e1006;
    loop {
        let _e1008 = local_93;
        let _e1015 = local_180;
        loop {
            let _e1017 = atomicCompareExchangeWeak((&output[_e1015]), _e1008, select((_e1008 - 1u), _e999, ((_e1008 == 0u) || (_e1008 > _e999))));
            local_213 = _e1017.old_value;
            if (_e1017.exchanged || (_e1017.old_value != _e1008)) {
                break;
            }
        }
        let _e1024 = local_213;
        local_181 = _e1024;
        let _e1026 = local_181;
        local_93 = _e1026;
        if (_e1026 == _e1008) {
            break;
        }
    }
    let _e1028 = local_93;
    local_88 = u32(55i);
    let _e1032 = local_88;
    local_182 = u32(_e1032);
    let _e1035 = local_182;
    atomicStore((&output[_e1035]), _e1028);
    local_95 = u32(50i);
    let _e1040 = local_95;
    local_183 = u32(_e1040);
    let _e1043 = local_183;
    let _e1045 = atomicLoad((&output[_e1043]));
    local_94 = u32(56i);
    let _e1049 = local_94;
    local_184 = u32(_e1049);
    let _e1052 = local_184;
    atomicStore((&output[_e1052]), _e1045);
    local_97 = u32(50i);
    local_98 = u32(50i);
    local_99 = 3u;
    let _e1062 = local_99;
    let _e1063 = local_98;
    local_185 = u32(_e1063);
    let _e1066 = local_185;
    let _e1069 = atomicAdd((&output[_e1066]), 0u);
    local_100 = _e1069;
    loop {
        let _e1071 = local_100;
        let _e1078 = local_185;
        loop {
            let _e1080 = atomicCompareExchangeWeak((&output[_e1078]), _e1071, select((_e1071 - 1u), _e1062, ((_e1071 == 0u) || (_e1071 > _e1062))));
            local_214 = _e1080.old_value;
            if (_e1080.exchanged || (_e1080.old_value != _e1071)) {
                break;
            }
        }
        let _e1087 = local_214;
        local_186 = _e1087;
        let _e1089 = local_186;
        local_100 = _e1089;
        if (_e1089 == _e1071) {
            break;
        }
    }
    let _e1091 = local_100;
    let _e1092 = local_97;
    local_187 = u32(_e1092);
    let _e1095 = local_187;
    let _e1098 = atomicAdd((&output[_e1095]), 0u);
    local_101 = _e1098;
    loop {
        let _e1100 = local_101;
        let _e1105 = local_187;
        loop {
            let _e1107 = atomicCompareExchangeWeak((&output[_e1105]), _e1100, select((_e1100 + 1u), 0u, (_e1100 >= _e1091)));
            local_215 = _e1107.old_value;
            if (_e1107.exchanged || (_e1107.old_value != _e1100)) {
                break;
            }
        }
        let _e1114 = local_215;
        local_188 = _e1114;
        let _e1116 = local_188;
        local_101 = _e1116;
        if (_e1116 == _e1100) {
            break;
        }
    }
    let _e1118 = local_101;
    local_96 = u32(57i);
    let _e1122 = local_96;
    local_189 = u32(_e1122);
    let _e1125 = local_189;
    atomicStore((&output[_e1125]), _e1118);
    local_103 = u32(50i);
    let _e1130 = local_103;
    local_190 = u32(_e1130);
    let _e1133 = local_190;
    let _e1135 = atomicLoad((&output[_e1133]));
    local_102 = u32(58i);
    let _e1139 = local_102;
    local_191 = u32(_e1139);
    let _e1142 = local_191;
    atomicStore((&output[_e1142]), _e1135);
}
