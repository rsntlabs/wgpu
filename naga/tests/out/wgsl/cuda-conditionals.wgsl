struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_a_1: array<i32>;
@group(0) @binding(2)
var<storage> input_b_1: array<i32>;
@group(0) @binding(3)
var<uniform> n: type_3;
var<workgroup> shared_values: array<i32, 64>;

fn shifted(value_1: i32) -> i32 {
    return (value_1 + 10i);
}

fn discard_(value_2: i32) {
    var value_3: i32;

    value_3 = value_2;
    let _e3 = value_3;
    value_3 = (_e3 + 1i);
    return;
}

fn pair(x: i32, y: i32) -> i32 {
    return ((x * 10i) + y);
}

@compute @workgroup_size(64, 1, 1)
fn conditionals(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var input_a: array<u32, 2>;
    var input_b: array<u32, 2>;
    var base: u32;
    var choose_a: bool;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: i32;
    var a: i32;
    var b: i32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: i32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var index_a: i32;
    var index_b: i32;
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
    var local_26: i32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: i32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var c: i32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var condition: i32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var lane: u32;
    var local_value: i32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: f32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: bool;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: i32;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: u32;
    var shift_value: i32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: i32;
    var local_65: u32;
    var value: i32;
    var other: i32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: i32;
    var count: i32;
    var left: i32;
    var right: i32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: i32;
    var local_72: i32;
    var local_73: array<u32, 2>;
    var local_74: u32;
    var local_75: u32;
    var local_76: i32;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: i32;
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

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input_a = array<u32, 2>();
    input_a[0] = 1u;
    input_a[1] = 0u;
    input_b = array<u32, 2>();
    input_b[0] = 2u;
    input_b[1] = 0u;
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 25u);
        choose_a = ((i % 2u) == 0u);
        let _e37 = choose_a;
        if _e37 {
            let _e39 = input_a;
            local_2 = _e39;
            local_3 = u32(i);
            let _e43 = local_2;
            local_73 = _e43;
            let _e45 = local_3;
            let _e47 = local_73[1];
            local_73[1] = (_e47 + _e45);
            let _e51 = local_73[0];
            local_74 = u32(_e51);
            let _e55 = local_73[1];
            local_75 = u32(_e55);
            let _e58 = local_75;
            let _e61 = input_a_1[_e58];
            local_76 = _e61;
            let _e63 = local_76;
            local_71 = _e63;
            let _e65 = local_71;
            local_6 = _e65;
        } else {
            let _e68 = input_b;
            local_4 = _e68;
            local_5 = u32(i);
            let _e72 = local_4;
            local_77 = _e72;
            let _e74 = local_5;
            let _e76 = local_77[1];
            local_77[1] = (_e76 + _e74);
            let _e80 = local_77[0];
            local_78 = u32(_e80);
            let _e84 = local_77[1];
            local_79 = u32(_e84);
            let _e87 = local_79;
            let _e90 = input_b_1[_e87];
            local_80 = _e90;
            let _e92 = local_80;
            local_72 = _e92;
            let _e94 = local_72;
            local_6 = _e94;
        }
        let _e97 = local_6;
        let _e99 = out;
        local = _e99;
        let _e101 = base;
        local_1 = u32(_e101);
        let _e104 = local;
        local_81 = _e104;
        let _e106 = local_1;
        let _e108 = local_81[1];
        local_81[1] = (_e108 + _e106);
        let _e112 = local_81[0];
        local_82 = u32(_e112);
        let _e116 = local_81[1];
        local_83 = u32(_e116);
        let _e119 = local_83;
        out_1[_e119] = _e97;
        a = 3i;
        b = 5i;
        let _e126 = choose_a;
        if _e126 {
            let _e127 = a;
            a = (_e127 + 1i);
            let _e130 = shifted(_e127);
            local_9 = _e130;
        } else {
            let _e132 = b;
            b = (_e132 + 1i);
            let _e135 = shifted(_e132);
            local_9 = _e135;
        }
        let _e138 = local_9;
        let _e139 = out;
        local_7 = _e139;
        let _e141 = base;
        local_8 = u32((_e141 + 1u));
        let _e146 = local_7;
        local_84 = _e146;
        let _e148 = local_8;
        let _e150 = local_84[1];
        local_84[1] = (_e150 + _e148);
        let _e154 = local_84[0];
        local_85 = u32(_e154);
        let _e158 = local_84[1];
        local_86 = u32(_e158);
        let _e161 = local_86;
        out_1[_e161] = _e138;
        let _e163 = a;
        let _e166 = b;
        let _e168 = out;
        local_10 = _e168;
        let _e170 = base;
        local_11 = u32((_e170 + 2u));
        let _e175 = local_10;
        local_87 = _e175;
        let _e177 = local_11;
        let _e179 = local_87[1];
        local_87[1] = (_e179 + _e177);
        let _e183 = local_87[0];
        local_88 = u32(_e183);
        let _e187 = local_87[1];
        local_89 = u32(_e187);
        let _e190 = local_89;
        out_1[_e190] = ((_e163 * 10i) + _e166);
        let _e192 = choose_a;
        if _e192 {
            let _e193 = a;
            a = (_e193 + 1i);
            discard_(_e193);
        } else {
            let _e196 = b;
            b = (_e196 + 1i);
            discard_(_e196);
        }
        let _e199 = a;
        let _e202 = b;
        let _e204 = out;
        local_12 = _e204;
        let _e206 = base;
        local_13 = u32((_e206 + 3u));
        let _e211 = local_12;
        local_90 = _e211;
        let _e213 = local_13;
        let _e215 = local_90[1];
        local_90[1] = (_e215 + _e213);
        let _e219 = local_90[0];
        local_91 = u32(_e219);
        let _e223 = local_90[1];
        local_92 = u32(_e223);
        let _e226 = local_92;
        out_1[_e226] = ((_e199 * 10i) + _e202);
        index_a = 0i;
        index_b = 0i;
        let _e232 = choose_a;
        if _e232 {
            let _e234 = input_a;
            local_14 = _e234;
            let _e236 = index_a;
            index_a = (_e236 + 1i);
            local_15 = u32(_e236);
        } else {
            let _e242 = input_b;
            local_16 = _e242;
            let _e244 = index_b;
            index_b = (_e244 + 1i);
            local_17 = u32(_e244);
        }
        let _e249 = index_a;
        let _e252 = index_b;
        let _e254 = out;
        local_18 = _e254;
        let _e256 = base;
        local_19 = u32((_e256 + 4u));
        let _e261 = local_18;
        local_93 = _e261;
        let _e263 = local_19;
        let _e265 = local_93[1];
        local_93[1] = (_e265 + _e263);
        let _e269 = local_93[0];
        local_94 = u32(_e269);
        let _e273 = local_93[1];
        local_95 = u32(_e273);
        let _e276 = local_95;
        out_1[_e276] = ((_e249 * 10i) + _e252);
        a = 3i;
        b = 5i;
        let _e280 = choose_a;
        if _e280 {
            a = 7i;
        } else {
            b = 7i;
        }
        let _e283 = a;
        let _e286 = b;
        let _e288 = out;
        local_20 = _e288;
        let _e290 = base;
        local_21 = u32((_e290 + 5u));
        let _e295 = local_20;
        local_96 = _e295;
        let _e297 = local_21;
        let _e299 = local_96[1];
        local_96[1] = (_e299 + _e297);
        let _e303 = local_96[0];
        local_97 = u32(_e303);
        let _e307 = local_96[1];
        local_98 = u32(_e307);
        let _e310 = local_98;
        out_1[_e310] = ((_e283 * 10i) + _e286);
        let _e312 = choose_a;
        if _e312 {
            let _e313 = a;
            a = (_e313 + 2i);
        } else {
            let _e316 = b;
            b = (_e316 + 2i);
        }
        let _e319 = a;
        let _e322 = b;
        let _e324 = out;
        local_22 = _e324;
        let _e326 = base;
        local_23 = u32((_e326 + 6u));
        let _e331 = local_22;
        local_99 = _e331;
        let _e333 = local_23;
        let _e335 = local_99[1];
        local_99[1] = (_e335 + _e333);
        let _e339 = local_99[0];
        local_100 = u32(_e339);
        let _e343 = local_99[1];
        local_101 = u32(_e343);
        let _e346 = local_101;
        out_1[_e346] = ((_e319 * 10i) + _e322);
        let _e348 = choose_a;
        if _e348 {
            let _e349 = a;
            a = (_e349 + 1i);
            let _e352 = a;
            local_26 = _e352;
        } else {
            let _e354 = b;
            b = (_e354 + 1i);
            let _e357 = b;
            local_26 = _e357;
        }
        let _e360 = local_26;
        let _e361 = out;
        local_24 = _e361;
        let _e363 = base;
        local_25 = u32((_e363 + 7u));
        let _e368 = local_24;
        local_102 = _e368;
        let _e370 = local_25;
        let _e372 = local_102[1];
        local_102[1] = (_e372 + _e370);
        let _e376 = local_102[0];
        local_103 = u32(_e376);
        let _e380 = local_102[1];
        local_104 = u32(_e380);
        let _e383 = local_104;
        out_1[_e383] = _e360;
        let _e385 = choose_a;
        if _e385 {
            let _e386 = a;
            a = (_e386 + 1i);
            local_29 = _e386;
        } else {
            let _e390 = b;
            b = (_e390 + 1i);
            local_29 = _e390;
        }
        let _e395 = local_29;
        let _e396 = out;
        local_27 = _e396;
        let _e398 = base;
        local_28 = u32((_e398 + 8u));
        let _e403 = local_27;
        local_105 = _e403;
        let _e405 = local_28;
        let _e407 = local_105[1];
        local_105[1] = (_e407 + _e405);
        let _e411 = local_105[0];
        local_106 = u32(_e411);
        let _e415 = local_105[1];
        local_107 = u32(_e415);
        let _e418 = local_107;
        out_1[_e418] = _e395;
        let _e420 = a;
        let _e423 = b;
        let _e425 = out;
        local_30 = _e425;
        let _e427 = base;
        local_31 = u32((_e427 + 9u));
        let _e432 = local_30;
        local_108 = _e432;
        let _e434 = local_31;
        let _e436 = local_108[1];
        local_108[1] = (_e436 + _e434);
        let _e440 = local_108[0];
        local_109 = u32(_e440);
        let _e444 = local_108[1];
        local_110 = u32(_e444);
        let _e447 = local_110;
        out_1[_e447] = ((_e420 * 100i) + _e423);
        let _e449 = choose_a;
        c = i32(_e449);
        b = 7i;
        let _e453 = c;
        if (_e453 != 0i) {
            c = 0i;
            let _e457 = c;
            c = (_e457 + 1i);
            local_34 = _e457;
        } else {
            b = 0i;
            let _e462 = b;
            b = (_e462 + 1i);
            local_34 = _e462;
        }
        let _e467 = local_34;
        let _e468 = out;
        local_32 = _e468;
        let _e470 = base;
        local_33 = u32((_e470 + 10u));
        let _e475 = local_32;
        local_111 = _e475;
        let _e477 = local_33;
        let _e479 = local_111[1];
        local_111[1] = (_e479 + _e477);
        let _e483 = local_111[0];
        local_112 = u32(_e483);
        let _e487 = local_111[1];
        local_113 = u32(_e487);
        let _e490 = local_113;
        out_1[_e490] = _e467;
        let _e492 = c;
        let _e495 = b;
        let _e497 = out;
        local_35 = _e497;
        let _e499 = base;
        local_36 = u32((_e499 + 11u));
        let _e504 = local_35;
        local_114 = _e504;
        let _e506 = local_36;
        let _e508 = local_114[1];
        local_114[1] = (_e508 + _e506);
        let _e512 = local_114[0];
        local_115 = u32(_e512);
        let _e516 = local_114[1];
        local_116 = u32(_e516);
        let _e519 = local_116;
        out_1[_e519] = ((_e492 * 10i) + _e495);
        condition = 0i;
        a = 2i;
        b = 4i;
        condition = 1i;
        let _e526 = condition;
        let _e527 = condition;
        if (_e527 != 0i) {
            a = _e526;
        } else {
            b = _e526;
        }
        let _e530 = a;
        let _e533 = b;
        let _e535 = out;
        local_37 = _e535;
        let _e537 = base;
        local_38 = u32((_e537 + 12u));
        let _e542 = local_37;
        local_117 = _e542;
        let _e544 = local_38;
        let _e546 = local_117[1];
        local_117[1] = (_e546 + _e544);
        let _e550 = local_117[0];
        local_118 = u32(_e550);
        let _e554 = local_117[1];
        local_119 = u32(_e554);
        let _e557 = local_119;
        out_1[_e557] = ((_e530 * 10i) + _e533);
        a = 2i;
        b = 4i;
        c = 6i;
        let _e562 = choose_a;
        if _e562 {
            if ((i % 4u) == 0u) {
                let _e567 = a;
                a = (_e567 + 3i);
            } else {
                let _e570 = b;
                b = (_e570 + 3i);
            }
        } else {
            let _e573 = c;
            c = (_e573 + 3i);
        }
        let _e576 = a;
        let _e579 = b;
        let _e583 = c;
        let _e585 = out;
        local_39 = _e585;
        let _e587 = base;
        local_40 = u32((_e587 + 13u));
        let _e592 = local_39;
        local_120 = _e592;
        let _e594 = local_40;
        let _e596 = local_120[1];
        local_120[1] = (_e596 + _e594);
        let _e600 = local_120[0];
        local_121 = u32(_e600);
        let _e604 = local_120[1];
        local_122 = u32(_e604);
        let _e607 = local_122;
        out_1[_e607] = (((_e576 * 100i) + (_e579 * 10i)) + _e583);
        lane = threadIdx.x;
        let _e611 = lane;
        shared_values[_e611] = 20i;
        local_value = 10i;
        let _e617 = choose_a;
        if _e617 {
            let _e618 = local_value;
            local_value = (_e618 + 5i);
        } else {
            let _e621 = lane;
            let _e623 = shared_values[_e621];
            shared_values[_e621] = (_e623 + 5i);
        }
        let _e626 = local_value;
        let _e629 = lane;
        let _e631 = shared_values[_e629];
        let _e633 = out;
        local_41 = _e633;
        let _e635 = base;
        local_42 = u32((_e635 + 14u));
        let _e640 = local_41;
        local_123 = _e640;
        let _e642 = local_42;
        let _e644 = local_123[1];
        local_123[1] = (_e644 + _e642);
        let _e648 = local_123[0];
        local_124 = u32(_e648);
        let _e652 = local_123[1];
        local_125 = u32(_e652);
        let _e655 = local_125;
        out_1[_e655] = ((_e626 * 100i) + _e631);
        let _e657 = choose_a;
        if _e657 {
            let _e658 = lane;
            shared_values[_e658] = 30i;
        } else {
            let _e661 = out;
            local_43 = _e661;
            let _e663 = base;
            local_44 = u32((_e663 + 15u));
            let _e668 = local_43;
            local_126 = _e668;
            let _e670 = local_44;
            let _e672 = local_126[1];
            local_126[1] = (_e672 + _e670);
            let _e676 = local_126[0];
            local_127 = u32(_e676);
            let _e680 = local_126[1];
            local_128 = u32(_e680);
            let _e683 = local_128;
            out_1[_e683] = 30i;
        }
        let _e686 = lane;
        let _e688 = shared_values[_e686];
        let _e689 = out;
        local_45 = _e689;
        let _e691 = base;
        local_46 = u32((_e691 + 16u));
        let _e696 = local_45;
        local_129 = _e696;
        let _e698 = local_46;
        let _e700 = local_129[1];
        local_129[1] = (_e700 + _e698);
        let _e704 = local_129[0];
        local_130 = u32(_e704);
        let _e708 = local_129[1];
        local_131 = u32(_e708);
        let _e711 = local_131;
        out_1[_e711] = _e688;
        let _e713 = choose_a;
        if _e713 {
            local_49 = 1.5f;
        } else {
            local_49 = f32(3i);
        }
        let _e720 = local_49;
        let _e721 = out;
        local_47 = _e721;
        let _e723 = base;
        local_48 = u32((_e723 + 17u));
        let _e729 = local_47;
        local_132 = _e729;
        let _e731 = local_48;
        let _e733 = local_132[1];
        local_132[1] = (_e733 + _e731);
        let _e737 = local_132[0];
        local_133 = u32(_e737);
        let _e741 = local_132[1];
        local_134 = u32(_e741);
        let _e744 = local_134;
        out_1[_e744] = i32(_e720);
        let _e746 = choose_a;
        if _e746 {
            local_52 = u32(-(1i));
        } else {
            local_52 = 2u;
        }
        let _e754 = local_52;
        let _e755 = out;
        local_50 = _e755;
        let _e757 = base;
        local_51 = u32((_e757 + 18u));
        let _e763 = local_50;
        local_135 = _e763;
        let _e765 = local_51;
        let _e767 = local_135[1];
        local_135[1] = (_e767 + _e765);
        let _e771 = local_135[0];
        local_136 = u32(_e771);
        let _e775 = local_135[1];
        local_137 = u32(_e775);
        let _e778 = local_137;
        out_1[_e778] = i32(_e754);
        let _e780 = choose_a;
        if _e780 {
            local_55 = true;
        } else {
            local_55 = false;
        }
        let _e786 = local_55;
        let _e787 = out;
        local_53 = _e787;
        let _e789 = base;
        local_54 = u32((_e789 + 19u));
        let _e795 = local_53;
        local_138 = _e795;
        let _e797 = local_54;
        let _e799 = local_138[1];
        local_138[1] = (_e799 + _e797);
        let _e803 = local_138[0];
        local_139 = u32(_e803);
        let _e807 = local_138[1];
        local_140 = u32(_e807);
        let _e810 = local_140;
        out_1[_e810] = i32(_e786);
        let _e812 = choose_a;
        if _e812 {
            local_58 = i32(true);
        } else {
            local_58 = 2i;
        }
        let _e819 = local_58;
        let _e820 = out;
        local_56 = _e820;
        let _e822 = base;
        local_57 = u32((_e822 + 20u));
        let _e827 = local_56;
        local_141 = _e827;
        let _e829 = local_57;
        let _e831 = local_141[1];
        local_141[1] = (_e831 + _e829);
        let _e835 = local_141[0];
        local_142 = u32(_e835);
        let _e839 = local_141[1];
        local_143 = u32(_e839);
        let _e842 = local_143;
        out_1[_e842] = _e819;
        let _e844 = choose_a;
        if _e844 {
            local_61 = 4u;
        } else {
            local_61 = 8u;
        }
        let _e850 = local_61;
        let _e851 = out;
        local_59 = _e851;
        let _e853 = base;
        local_60 = u32((_e853 + 21u));
        let _e859 = local_59;
        local_144 = _e859;
        let _e861 = local_60;
        let _e863 = local_144[1];
        local_144[1] = (_e863 + _e861);
        let _e867 = local_144[0];
        local_145 = u32(_e867);
        let _e871 = local_144[1];
        local_146 = u32(_e871);
        let _e874 = local_146;
        out_1[_e874] = i32(_e850);
        a = 3i;
        shift_value = 2i;
        let _e879 = choose_a;
        if _e879 {
            let _e880 = shift_value;
            local_64 = _e880;
        } else {
            let _e882 = a;
            local_64 = _e882;
        }
        let _e885 = local_64;
        shift_value = 1i;
        let _e887 = shift_value;
        local_65 = u32(_e887);
        let _e890 = local_65;
        let _e892 = out;
        local_62 = _e892;
        let _e894 = base;
        local_63 = u32((_e894 + 22u));
        let _e899 = local_62;
        local_147 = _e899;
        let _e901 = local_63;
        let _e903 = local_147[1];
        local_147[1] = (_e903 + _e901);
        let _e907 = local_147[0];
        local_148 = u32(_e907);
        let _e911 = local_147[1];
        local_149 = u32(_e911);
        let _e914 = local_149;
        out_1[_e914] = (_e885 << _e890);
        value = 3i;
        other = 7i;
        let _e920 = choose_a;
        if _e920 {
            let _e921 = value;
            local_68 = _e921;
        } else {
            let _e923 = other;
            local_68 = _e923;
        }
        let _e926 = local_68;
        let _e927 = value;
        value = (_e927 + 1i);
        let _e930 = pair(_e926, _e927);
        let _e931 = out;
        local_66 = _e931;
        let _e933 = base;
        local_67 = u32((_e933 + 23u));
        let _e938 = local_66;
        local_150 = _e938;
        let _e940 = local_67;
        let _e942 = local_150[1];
        local_150[1] = (_e942 + _e940);
        let _e946 = local_150[0];
        local_151 = u32(_e946);
        let _e950 = local_150[1];
        local_152 = u32(_e950);
        let _e953 = local_152;
        out_1[_e953] = _e930;
        count = 0i;
        left = 0i;
        right = 0i;
        {
            loop {
                let _e961 = count;
                if (_e961 < 3i) {
                } else {
                    break;
                }
                let _e964 = count;
                count = (_e964 + 1i);
                let _e967 = count;
                if (_e967 == 2i) {
                    continue;
                }
                continuing {
                    let _e970 = choose_a;
                    if _e970 {
                        let _e971 = left;
                        left = (_e971 + 1i);
                    } else {
                        let _e974 = right;
                        right = (_e974 + 1i);
                    }
                }
            }
        }
        let _e977 = left;
        let _e980 = right;
        let _e984 = count;
        let _e986 = out;
        local_69 = _e986;
        let _e988 = base;
        local_70 = u32((_e988 + 24u));
        let _e993 = local_69;
        local_153 = _e993;
        let _e995 = local_70;
        let _e997 = local_153[1];
        local_153[1] = (_e997 + _e995);
        let _e1001 = local_153[0];
        local_154 = u32(_e1001);
        let _e1005 = local_153[1];
        local_155 = u32(_e1005);
        let _e1008 = local_155;
        out_1[_e1008] = (((_e977 * 100i) + (_e980 * 10i)) + _e984);
    }
}
