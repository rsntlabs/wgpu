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
            local_134 = _e19.old_value;
            if (_e19.exchanged || (_e19.old_value != _e12)) {
                break;
            }
        }
        let _e26 = local_134;
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
    atomicStore((&output[_e34]), _e30);
    local_4 = u32(1i);
    local_5 = u32(1.75f);
    let _e42 = local_5;
    let _e43 = local_4;
    let _e46 = atomicAdd((&output[_e43]), 0u);
    local_6 = _e46;
    loop {
        let _e48 = local_6;
        loop {
            let _e54 = atomicCompareExchangeWeak((&output[_e43]), _e48, select((_e48 + 1u), 0u, (_e48 >= _e42)));
            local_135 = _e54.old_value;
            if (_e54.exchanged || (_e54.old_value != _e48)) {
                break;
            }
        }
        let _e61 = local_135;
        local_107 = _e61;
        let _e63 = local_107;
        local_6 = _e63;
        if (_e63 == _e48) {
            break;
        }
    }
    let _e65 = local_6;
    local_3 = u32(17i);
    let _e69 = local_3;
    atomicStore((&output[_e69]), _e65);
    local_8 = u32(2i);
    local_9 = 1u;
    let _e76 = local_9;
    let _e77 = local_8;
    let _e80 = atomicAdd((&output[_e77]), 0u);
    local_10 = _e80;
    loop {
        let _e82 = local_10;
        loop {
            let _e88 = atomicCompareExchangeWeak((&output[_e77]), _e82, select((_e82 + 1u), 0u, (_e82 >= _e76)));
            local_136 = _e88.old_value;
            if (_e88.exchanged || (_e88.old_value != _e82)) {
                break;
            }
        }
        let _e95 = local_136;
        local_108 = _e95;
        let _e97 = local_108;
        local_10 = _e97;
        if (_e97 == _e82) {
            break;
        }
    }
    let _e99 = local_10;
    local_7 = u32(18i);
    let _e103 = local_7;
    atomicStore((&output[_e103]), _e99);
    local_12 = u32(3i);
    local_13 = 1u;
    let _e110 = local_13;
    let _e111 = local_12;
    let _e114 = atomicAdd((&output[_e111]), 0u);
    local_14 = _e114;
    loop {
        let _e116 = local_14;
        loop {
            let _e122 = atomicCompareExchangeWeak((&output[_e111]), _e116, select((_e116 + 1u), 0u, (_e116 >= _e110)));
            local_137 = _e122.old_value;
            if (_e122.exchanged || (_e122.old_value != _e116)) {
                break;
            }
        }
        let _e129 = local_137;
        local_109 = _e129;
        let _e131 = local_109;
        local_14 = _e131;
        if (_e131 == _e116) {
            break;
        }
    }
    let _e133 = local_14;
    local_11 = u32(19i);
    let _e137 = local_11;
    atomicStore((&output[_e137]), _e133);
    local_16 = u32(4i);
    local_17 = u32(-(1i));
    let _e146 = local_17;
    let _e147 = local_16;
    let _e150 = atomicAdd((&output[_e147]), 0u);
    local_18 = _e150;
    loop {
        let _e152 = local_18;
        loop {
            let _e158 = atomicCompareExchangeWeak((&output[_e147]), _e152, select((_e152 + 1u), 0u, (_e152 >= _e146)));
            local_138 = _e158.old_value;
            if (_e158.exchanged || (_e158.old_value != _e152)) {
                break;
            }
        }
        let _e165 = local_138;
        local_110 = _e165;
        let _e167 = local_110;
        local_18 = _e167;
        if (_e167 == _e152) {
            break;
        }
    }
    let _e169 = local_18;
    local_15 = u32(20i);
    let _e173 = local_15;
    atomicStore((&output[_e173]), _e169);
    local_20 = u32(5i);
    local_21 = 4294967295u;
    let _e180 = local_21;
    let _e181 = local_20;
    let _e184 = atomicAdd((&output[_e181]), 0u);
    local_22 = _e184;
    loop {
        let _e186 = local_22;
        loop {
            let _e192 = atomicCompareExchangeWeak((&output[_e181]), _e186, select((_e186 + 1u), 0u, (_e186 >= _e180)));
            local_139 = _e192.old_value;
            if (_e192.exchanged || (_e192.old_value != _e186)) {
                break;
            }
        }
        let _e199 = local_139;
        local_111 = _e199;
        let _e201 = local_111;
        local_22 = _e201;
        if (_e201 == _e186) {
            break;
        }
    }
    let _e203 = local_22;
    local_19 = u32(21i);
    let _e207 = local_19;
    atomicStore((&output[_e207]), _e203);
    local_24 = u32(6i);
    local_25 = 2147483648u;
    let _e214 = local_25;
    let _e215 = local_24;
    let _e218 = atomicAdd((&output[_e215]), 0u);
    local_26 = _e218;
    loop {
        let _e220 = local_26;
        loop {
            let _e226 = atomicCompareExchangeWeak((&output[_e215]), _e220, select((_e220 + 1u), 0u, (_e220 >= _e214)));
            local_140 = _e226.old_value;
            if (_e226.exchanged || (_e226.old_value != _e220)) {
                break;
            }
        }
        let _e233 = local_140;
        local_112 = _e233;
        let _e235 = local_112;
        local_26 = _e235;
        if (_e235 == _e220) {
            break;
        }
    }
    let _e237 = local_26;
    local_23 = u32(22i);
    let _e241 = local_23;
    atomicStore((&output[_e241]), _e237);
    local_28 = u32(7i);
    local_29 = 2147483648u;
    let _e248 = local_29;
    let _e249 = local_28;
    let _e252 = atomicAdd((&output[_e249]), 0u);
    local_30 = _e252;
    loop {
        let _e254 = local_30;
        loop {
            let _e260 = atomicCompareExchangeWeak((&output[_e249]), _e254, select((_e254 + 1u), 0u, (_e254 >= _e248)));
            local_141 = _e260.old_value;
            if (_e260.exchanged || (_e260.old_value != _e254)) {
                break;
            }
        }
        let _e267 = local_141;
        local_113 = _e267;
        let _e269 = local_113;
        local_30 = _e269;
        if (_e269 == _e254) {
            break;
        }
    }
    let _e271 = local_30;
    local_27 = u32(23i);
    let _e275 = local_27;
    atomicStore((&output[_e275]), _e271);
    local_32 = u32(8i);
    local_33 = 0u;
    let _e282 = local_33;
    let _e283 = local_32;
    let _e286 = atomicAdd((&output[_e283]), 0u);
    local_34 = _e286;
    loop {
        let _e288 = local_34;
        loop {
            let _e296 = atomicCompareExchangeWeak((&output[_e283]), _e288, select((_e288 - 1u), _e282, ((_e288 == 0u) || (_e288 > _e282))));
            local_142 = _e296.old_value;
            if (_e296.exchanged || (_e296.old_value != _e288)) {
                break;
            }
        }
        let _e303 = local_142;
        local_114 = _e303;
        let _e305 = local_114;
        local_34 = _e305;
        if (_e305 == _e288) {
            break;
        }
    }
    let _e307 = local_34;
    local_31 = u32(24i);
    let _e311 = local_31;
    atomicStore((&output[_e311]), _e307);
    local_36 = u32(9i);
    local_37 = u32(1.75f);
    let _e319 = local_37;
    let _e320 = local_36;
    let _e323 = atomicAdd((&output[_e320]), 0u);
    local_38 = _e323;
    loop {
        let _e325 = local_38;
        loop {
            let _e333 = atomicCompareExchangeWeak((&output[_e320]), _e325, select((_e325 - 1u), _e319, ((_e325 == 0u) || (_e325 > _e319))));
            local_143 = _e333.old_value;
            if (_e333.exchanged || (_e333.old_value != _e325)) {
                break;
            }
        }
        let _e340 = local_143;
        local_115 = _e340;
        let _e342 = local_115;
        local_38 = _e342;
        if (_e342 == _e325) {
            break;
        }
    }
    let _e344 = local_38;
    local_35 = u32(25i);
    let _e348 = local_35;
    atomicStore((&output[_e348]), _e344);
    local_40 = u32(10i);
    local_41 = 1u;
    let _e355 = local_41;
    let _e356 = local_40;
    let _e359 = atomicAdd((&output[_e356]), 0u);
    local_42 = _e359;
    loop {
        let _e361 = local_42;
        loop {
            let _e369 = atomicCompareExchangeWeak((&output[_e356]), _e361, select((_e361 - 1u), _e355, ((_e361 == 0u) || (_e361 > _e355))));
            local_144 = _e369.old_value;
            if (_e369.exchanged || (_e369.old_value != _e361)) {
                break;
            }
        }
        let _e376 = local_144;
        local_116 = _e376;
        let _e378 = local_116;
        local_42 = _e378;
        if (_e378 == _e361) {
            break;
        }
    }
    let _e380 = local_42;
    local_39 = u32(26i);
    let _e384 = local_39;
    atomicStore((&output[_e384]), _e380);
    local_44 = u32(11i);
    local_45 = 1u;
    let _e391 = local_45;
    let _e392 = local_44;
    let _e395 = atomicAdd((&output[_e392]), 0u);
    local_46 = _e395;
    loop {
        let _e397 = local_46;
        loop {
            let _e405 = atomicCompareExchangeWeak((&output[_e392]), _e397, select((_e397 - 1u), _e391, ((_e397 == 0u) || (_e397 > _e391))));
            local_145 = _e405.old_value;
            if (_e405.exchanged || (_e405.old_value != _e397)) {
                break;
            }
        }
        let _e412 = local_145;
        local_117 = _e412;
        let _e414 = local_117;
        local_46 = _e414;
        if (_e414 == _e397) {
            break;
        }
    }
    let _e416 = local_46;
    local_43 = u32(27i);
    let _e420 = local_43;
    atomicStore((&output[_e420]), _e416);
    local_48 = u32(12i);
    local_49 = u32(-(1i));
    let _e429 = local_49;
    let _e430 = local_48;
    let _e433 = atomicAdd((&output[_e430]), 0u);
    local_50 = _e433;
    loop {
        let _e435 = local_50;
        loop {
            let _e443 = atomicCompareExchangeWeak((&output[_e430]), _e435, select((_e435 - 1u), _e429, ((_e435 == 0u) || (_e435 > _e429))));
            local_146 = _e443.old_value;
            if (_e443.exchanged || (_e443.old_value != _e435)) {
                break;
            }
        }
        let _e450 = local_146;
        local_118 = _e450;
        let _e452 = local_118;
        local_50 = _e452;
        if (_e452 == _e435) {
            break;
        }
    }
    let _e454 = local_50;
    local_47 = u32(28i);
    let _e458 = local_47;
    atomicStore((&output[_e458]), _e454);
    local_52 = u32(13i);
    local_53 = 4294967295u;
    let _e465 = local_53;
    let _e466 = local_52;
    let _e469 = atomicAdd((&output[_e466]), 0u);
    local_54 = _e469;
    loop {
        let _e471 = local_54;
        loop {
            let _e479 = atomicCompareExchangeWeak((&output[_e466]), _e471, select((_e471 - 1u), _e465, ((_e471 == 0u) || (_e471 > _e465))));
            local_147 = _e479.old_value;
            if (_e479.exchanged || (_e479.old_value != _e471)) {
                break;
            }
        }
        let _e486 = local_147;
        local_119 = _e486;
        let _e488 = local_119;
        local_54 = _e488;
        if (_e488 == _e471) {
            break;
        }
    }
    let _e490 = local_54;
    local_51 = u32(29i);
    let _e494 = local_51;
    atomicStore((&output[_e494]), _e490);
    local_56 = u32(14i);
    local_57 = 1u;
    let _e501 = local_57;
    let _e502 = local_56;
    let _e505 = atomicAdd((&output[_e502]), 0u);
    local_58 = _e505;
    loop {
        let _e507 = local_58;
        loop {
            let _e515 = atomicCompareExchangeWeak((&output[_e502]), _e507, select((_e507 - 1u), _e501, ((_e507 == 0u) || (_e507 > _e501))));
            local_148 = _e515.old_value;
            if (_e515.exchanged || (_e515.old_value != _e507)) {
                break;
            }
        }
        let _e522 = local_148;
        local_120 = _e522;
        let _e524 = local_120;
        local_58 = _e524;
        if (_e524 == _e507) {
            break;
        }
    }
    let _e526 = local_58;
    local_55 = u32(30i);
    let _e530 = local_55;
    atomicStore((&output[_e530]), _e526);
    local_60 = u32(15i);
    local_61 = 2147483648u;
    let _e537 = local_61;
    let _e538 = local_60;
    let _e541 = atomicAdd((&output[_e538]), 0u);
    local_62 = _e541;
    loop {
        let _e543 = local_62;
        loop {
            let _e551 = atomicCompareExchangeWeak((&output[_e538]), _e543, select((_e543 - 1u), _e537, ((_e543 == 0u) || (_e543 > _e537))));
            local_149 = _e551.old_value;
            if (_e551.exchanged || (_e551.old_value != _e543)) {
                break;
            }
        }
        let _e558 = local_149;
        local_121 = _e558;
        let _e560 = local_121;
        local_62 = _e560;
        if (_e560 == _e543) {
            break;
        }
    }
    let _e562 = local_62;
    local_59 = u32(31i);
    let _e566 = local_59;
    atomicStore((&output[_e566]), _e562);
    {
        index = u32(0i);
        loop {
            let _e571 = index;
            if (_e571 < 16u) {
            } else {
                break;
            }
            let _e574 = index;
            local_64 = _e574;
            let _e576 = local_64;
            local_122 = _e576;
            let _e578 = local_122;
            let _e580 = atomicLoad((&output[_e578]));
            local_123 = _e580;
            let _e582 = local_123;
            local_104 = _e582;
            let _e584 = local_104;
            let _e585 = index;
            local_63 = u32((32u + _e585));
            let _e590 = local_63;
            local_124 = _e590;
            let _e592 = local_124;
            atomicStore((&output[_e592]), _e584);
            continuing {
                let _e594 = index;
                index = (_e594 + u32(1i));
            }
        }
    }
    local_65 = 1u;
    let _e600 = local_65;
    local_125 = u32(0u);
    let _e604 = local_125;
    let _e607 = atomicAdd((&output[_e604]), 0u);
    local_66 = _e607;
    loop {
        let _e609 = local_66;
        let _e614 = local_125;
        loop {
            let _e616 = atomicCompareExchangeWeak((&output[_e614]), _e609, select((_e609 + 1u), 0u, (_e609 >= _e600)));
            local_150 = _e616.old_value;
            if (_e616.exchanged || (_e616.old_value != _e609)) {
                break;
            }
        }
        let _e623 = local_150;
        local_126 = _e623;
        let _e625 = local_126;
        local_66 = _e625;
        if (_e625 == _e609) {
            break;
        }
    }
    local_67 = u32(8i);
    local_68 = 1u;
    let _e632 = local_68;
    let _e633 = local_67;
    let _e636 = atomicAdd((&output[_e633]), 0u);
    local_69 = _e636;
    loop {
        let _e638 = local_69;
        loop {
            let _e646 = atomicCompareExchangeWeak((&output[_e633]), _e638, select((_e638 - 1u), _e632, ((_e638 == 0u) || (_e638 > _e632))));
            local_151 = _e646.old_value;
            if (_e646.exchanged || (_e646.old_value != _e638)) {
                break;
            }
        }
        let _e653 = local_151;
        local_127 = _e653;
        let _e655 = local_127;
        local_69 = _e655;
        if (_e655 == _e638) {
            break;
        }
    }
    local_71 = u32(0i);
    let _e660 = local_71;
    let _e662 = atomicLoad((&output[_e660]));
    local_70 = u32(48i);
    let _e666 = local_70;
    atomicStore((&output[_e666]), _e662);
    local_73 = u32(8i);
    let _e671 = local_73;
    let _e673 = atomicLoad((&output[_e671]));
    local_72 = u32(49i);
    let _e677 = local_72;
    atomicStore((&output[_e677]), _e673);
    local_74 = u32(50i);
    let _e682 = local_74;
    atomicStore((&output[_e682]), 2u);
    local_76 = u32(50i);
    local_77 = u32(50i);
    let _e691 = local_77;
    let _e693 = atomicLoad((&output[_e691]));
    atomicStore((&output[_e691]), (_e693 + u32(1i)));
    let _e698 = local_76;
    let _e701 = atomicAdd((&output[_e698]), 0u);
    local_78 = _e701;
    loop {
        let _e703 = local_78;
        loop {
            let _e709 = atomicCompareExchangeWeak((&output[_e698]), _e703, select((_e703 + 1u), 0u, (_e703 >= _e693)));
            local_152 = _e709.old_value;
            if (_e709.exchanged || (_e709.old_value != _e703)) {
                break;
            }
        }
        let _e716 = local_152;
        local_128 = _e716;
        let _e718 = local_128;
        local_78 = _e718;
        if (_e718 == _e703) {
            break;
        }
    }
    let _e720 = local_78;
    local_75 = u32(51i);
    let _e724 = local_75;
    atomicStore((&output[_e724]), _e720);
    local_80 = u32(50i);
    let _e729 = local_80;
    let _e731 = atomicLoad((&output[_e729]));
    local_79 = u32(52i);
    let _e735 = local_79;
    atomicStore((&output[_e735]), _e731);
    local_82 = u32(50i);
    local_83 = u32(50i);
    let _e743 = local_83;
    let _e745 = atomicLoad((&output[_e743]));
    atomicStore((&output[_e743]), (_e745 + u32(1i)));
    let _e750 = local_82;
    let _e753 = atomicAdd((&output[_e750]), 0u);
    local_84 = _e753;
    loop {
        let _e755 = local_84;
        loop {
            let _e763 = atomicCompareExchangeWeak((&output[_e750]), _e755, select((_e755 - 1u), _e745, ((_e755 == 0u) || (_e755 > _e745))));
            local_153 = _e763.old_value;
            if (_e763.exchanged || (_e763.old_value != _e755)) {
                break;
            }
        }
        let _e770 = local_153;
        local_129 = _e770;
        let _e772 = local_129;
        local_84 = _e772;
        if (_e772 == _e755) {
            break;
        }
    }
    let _e774 = local_84;
    local_81 = u32(53i);
    let _e778 = local_81;
    atomicStore((&output[_e778]), _e774);
    local_86 = u32(50i);
    let _e783 = local_86;
    let _e785 = atomicLoad((&output[_e783]));
    local_85 = u32(54i);
    let _e789 = local_85;
    atomicStore((&output[_e789]), _e785);
    local_87 = u32(50i);
    let _e794 = local_87;
    atomicStore((&output[_e794]), 2u);
    local_89 = u32(50i);
    local_90 = u32(50i);
    local_91 = 3u;
    let _e805 = local_91;
    let _e806 = local_90;
    let _e809 = atomicAdd((&output[_e806]), 0u);
    local_92 = _e809;
    loop {
        let _e811 = local_92;
        loop {
            let _e817 = atomicCompareExchangeWeak((&output[_e806]), _e811, select((_e811 + 1u), 0u, (_e811 >= _e805)));
            local_154 = _e817.old_value;
            if (_e817.exchanged || (_e817.old_value != _e811)) {
                break;
            }
        }
        let _e824 = local_154;
        local_130 = _e824;
        let _e826 = local_130;
        local_92 = _e826;
        if (_e826 == _e811) {
            break;
        }
    }
    let _e828 = local_92;
    let _e829 = local_89;
    let _e832 = atomicAdd((&output[_e829]), 0u);
    local_93 = _e832;
    loop {
        let _e834 = local_93;
        loop {
            let _e842 = atomicCompareExchangeWeak((&output[_e829]), _e834, select((_e834 - 1u), _e828, ((_e834 == 0u) || (_e834 > _e828))));
            local_155 = _e842.old_value;
            if (_e842.exchanged || (_e842.old_value != _e834)) {
                break;
            }
        }
        let _e849 = local_155;
        local_131 = _e849;
        let _e851 = local_131;
        local_93 = _e851;
        if (_e851 == _e834) {
            break;
        }
    }
    let _e853 = local_93;
    local_88 = u32(55i);
    let _e857 = local_88;
    atomicStore((&output[_e857]), _e853);
    local_95 = u32(50i);
    let _e862 = local_95;
    let _e864 = atomicLoad((&output[_e862]));
    local_94 = u32(56i);
    let _e868 = local_94;
    atomicStore((&output[_e868]), _e864);
    local_97 = u32(50i);
    local_98 = u32(50i);
    local_99 = 3u;
    let _e878 = local_99;
    let _e879 = local_98;
    let _e882 = atomicAdd((&output[_e879]), 0u);
    local_100 = _e882;
    loop {
        let _e884 = local_100;
        loop {
            let _e892 = atomicCompareExchangeWeak((&output[_e879]), _e884, select((_e884 - 1u), _e878, ((_e884 == 0u) || (_e884 > _e878))));
            local_156 = _e892.old_value;
            if (_e892.exchanged || (_e892.old_value != _e884)) {
                break;
            }
        }
        let _e899 = local_156;
        local_132 = _e899;
        let _e901 = local_132;
        local_100 = _e901;
        if (_e901 == _e884) {
            break;
        }
    }
    let _e903 = local_100;
    let _e904 = local_97;
    let _e907 = atomicAdd((&output[_e904]), 0u);
    local_101 = _e907;
    loop {
        let _e909 = local_101;
        loop {
            let _e915 = atomicCompareExchangeWeak((&output[_e904]), _e909, select((_e909 + 1u), 0u, (_e909 >= _e903)));
            local_157 = _e915.old_value;
            if (_e915.exchanged || (_e915.old_value != _e909)) {
                break;
            }
        }
        let _e922 = local_157;
        local_133 = _e922;
        let _e924 = local_133;
        local_101 = _e924;
        if (_e924 == _e909) {
            break;
        }
    }
    let _e926 = local_101;
    local_96 = u32(57i);
    let _e930 = local_96;
    atomicStore((&output[_e930]), _e926);
    local_103 = u32(50i);
    let _e935 = local_103;
    let _e937 = atomicLoad((&output[_e935]));
    local_102 = u32(58i);
    let _e941 = local_102;
    atomicStore((&output[_e941]), _e937);
}
