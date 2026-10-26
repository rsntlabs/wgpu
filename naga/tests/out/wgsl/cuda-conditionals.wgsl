struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input_a: array<i32>;
@group(0) @binding(2)
var<storage> input_b: array<i32>;
@group(0) @binding(3)
var<uniform> n_1: type_3;
var<workgroup> shared_values: array<i32, 64>;

fn shifted(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    return (_e3 + 10i);
}

fn discard_(value_3: i32) {
    var value_4: i32;

    value_4 = value_3;
    let _e3 = value_4;
    value_4 = (_e3 + 1i);
    return;
}

fn pair(x: i32, y: i32) -> i32 {
    var x_1: i32;
    var y_1: i32;

    x_1 = x;
    y_1 = y;
    let _e5 = x_1;
    let _e7 = y_1;
    return ((_e5 * 10i) + _e7);
}

@compute @workgroup_size(64, 1, 1)
fn conditionals(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var choose_a: bool;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: i32;
    var a: i32;
    var b: i32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: i32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var index_a: i32;
    var index_b: i32;
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
    var local_41: i32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: i32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var c: i32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: i32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var condition: i32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var lane: u32;
    var local_value: i32;
    var local_62: u32;
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
    var local_74: f32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: bool;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: i32;
    var local_87: u32;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var shift_value: i32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: i32;
    var local_95: u32;
    var value: i32;
    var other: i32;
    var local_96: u32;
    var local_97: u32;
    var local_98: u32;
    var local_99: i32;
    var count: i32;
    var left: i32;
    var right: i32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: i32;
    var local_105: u32;
    var local_106: i32;
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

    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    let _e10 = n_1.value;
    n = _e10;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e18 = i;
    let _e19 = n;
    if (_e18 < _e19) {
        let _e21 = i;
        base = (_e21 * 25u);
        let _e25 = i;
        choose_a = ((_e25 % 2u) == 0u);
        let _e31 = choose_a;
        if _e31 {
            let _e32 = local_1;
            local_6 = _e32;
            let _e34 = local_6;
            local_7 = u32(_e34);
            let _e37 = i;
            local_8 = u32(_e37);
            let _e41 = local_7;
            let _e42 = local_8;
            local_103 = u32((_e41 + _e42));
            let _e47 = local_103;
            let _e49 = input_a[_e47];
            local_104 = _e49;
            let _e50 = local_104;
            local_12 = _e50;
        } else {
            let _e52 = local_2;
            local_9 = _e52;
            let _e54 = local_9;
            local_10 = u32(_e54);
            let _e57 = i;
            local_11 = u32(_e57);
            let _e61 = local_10;
            let _e62 = local_11;
            local_105 = u32((_e61 + _e62));
            let _e67 = local_105;
            let _e69 = input_b[_e67];
            local_106 = _e69;
            let _e70 = local_106;
            local_12 = _e70;
        }
        let _e73 = local_12;
        let _e74 = local;
        local_3 = _e74;
        let _e76 = local_3;
        local_4 = u32(_e76);
        let _e79 = base;
        local_5 = u32(_e79);
        let _e83 = local_4;
        let _e84 = local_5;
        local_107 = u32((_e83 + _e84));
        let _e88 = local_107;
        out[_e88] = _e73;
        a = 3i;
        b = 5i;
        let _e94 = choose_a;
        if _e94 {
            let _e95 = a;
            a = (_e95 + 1i);
            let _e98 = shifted(_e95);
            local_16 = _e98;
        } else {
            let _e100 = b;
            b = (_e100 + 1i);
            let _e103 = shifted(_e100);
            local_16 = _e103;
        }
        let _e106 = local_16;
        let _e107 = local;
        local_13 = _e107;
        let _e109 = local_13;
        local_14 = u32(_e109);
        let _e112 = base;
        local_15 = u32((_e112 + 1u));
        let _e117 = local_14;
        let _e118 = local_15;
        local_108 = u32((_e117 + _e118));
        let _e122 = local_108;
        out[_e122] = _e106;
        let _e124 = a;
        let _e127 = b;
        let _e129 = local;
        local_17 = _e129;
        let _e131 = local_17;
        local_18 = u32(_e131);
        let _e134 = base;
        local_19 = u32((_e134 + 2u));
        let _e139 = local_18;
        let _e140 = local_19;
        local_109 = u32((_e139 + _e140));
        let _e144 = local_109;
        out[_e144] = ((_e124 * 10i) + _e127);
        let _e146 = choose_a;
        if _e146 {
            let _e147 = a;
            a = (_e147 + 1i);
            discard_(_e147);
        } else {
            let _e150 = b;
            b = (_e150 + 1i);
            discard_(_e150);
        }
        let _e153 = a;
        let _e156 = b;
        let _e158 = local;
        local_20 = _e158;
        let _e160 = local_20;
        local_21 = u32(_e160);
        let _e163 = base;
        local_22 = u32((_e163 + 3u));
        let _e168 = local_21;
        let _e169 = local_22;
        local_110 = u32((_e168 + _e169));
        let _e173 = local_110;
        out[_e173] = ((_e153 * 10i) + _e156);
        index_a = 0i;
        index_b = 0i;
        let _e179 = choose_a;
        if _e179 {
            let _e180 = local_1;
            local_23 = _e180;
            let _e182 = local_23;
            local_24 = u32(_e182);
            let _e185 = index_a;
            index_a = (_e185 + 1i);
            local_25 = u32(_e185);
        } else {
            let _e190 = local_2;
            local_26 = _e190;
            let _e192 = local_26;
            local_27 = u32(_e192);
            let _e195 = index_b;
            index_b = (_e195 + 1i);
            local_28 = u32(_e195);
        }
        let _e200 = index_a;
        let _e203 = index_b;
        let _e205 = local;
        local_29 = _e205;
        let _e207 = local_29;
        local_30 = u32(_e207);
        let _e210 = base;
        local_31 = u32((_e210 + 4u));
        let _e215 = local_30;
        let _e216 = local_31;
        local_111 = u32((_e215 + _e216));
        let _e220 = local_111;
        out[_e220] = ((_e200 * 10i) + _e203);
        a = 3i;
        b = 5i;
        let _e224 = choose_a;
        if _e224 {
            a = 7i;
        } else {
            b = 7i;
        }
        let _e227 = a;
        let _e230 = b;
        let _e232 = local;
        local_32 = _e232;
        let _e234 = local_32;
        local_33 = u32(_e234);
        let _e237 = base;
        local_34 = u32((_e237 + 5u));
        let _e242 = local_33;
        let _e243 = local_34;
        local_112 = u32((_e242 + _e243));
        let _e247 = local_112;
        out[_e247] = ((_e227 * 10i) + _e230);
        let _e249 = choose_a;
        if _e249 {
            let _e250 = a;
            a = (_e250 + 2i);
        } else {
            let _e253 = b;
            b = (_e253 + 2i);
        }
        let _e256 = a;
        let _e259 = b;
        let _e261 = local;
        local_35 = _e261;
        let _e263 = local_35;
        local_36 = u32(_e263);
        let _e266 = base;
        local_37 = u32((_e266 + 6u));
        let _e271 = local_36;
        let _e272 = local_37;
        local_113 = u32((_e271 + _e272));
        let _e276 = local_113;
        out[_e276] = ((_e256 * 10i) + _e259);
        let _e278 = choose_a;
        if _e278 {
            let _e279 = a;
            a = (_e279 + 1i);
            let _e282 = a;
            local_41 = _e282;
        } else {
            let _e284 = b;
            b = (_e284 + 1i);
            let _e287 = b;
            local_41 = _e287;
        }
        let _e290 = local_41;
        let _e291 = local;
        local_38 = _e291;
        let _e293 = local_38;
        local_39 = u32(_e293);
        let _e296 = base;
        local_40 = u32((_e296 + 7u));
        let _e301 = local_39;
        let _e302 = local_40;
        local_114 = u32((_e301 + _e302));
        let _e306 = local_114;
        out[_e306] = _e290;
        let _e308 = choose_a;
        if _e308 {
            let _e309 = a;
            a = (_e309 + 1i);
            local_45 = _e309;
        } else {
            let _e313 = b;
            b = (_e313 + 1i);
            local_45 = _e313;
        }
        let _e318 = local_45;
        let _e319 = local;
        local_42 = _e319;
        let _e321 = local_42;
        local_43 = u32(_e321);
        let _e324 = base;
        local_44 = u32((_e324 + 8u));
        let _e329 = local_43;
        let _e330 = local_44;
        local_115 = u32((_e329 + _e330));
        let _e334 = local_115;
        out[_e334] = _e318;
        let _e336 = a;
        let _e339 = b;
        let _e341 = local;
        local_46 = _e341;
        let _e343 = local_46;
        local_47 = u32(_e343);
        let _e346 = base;
        local_48 = u32((_e346 + 9u));
        let _e351 = local_47;
        let _e352 = local_48;
        local_116 = u32((_e351 + _e352));
        let _e356 = local_116;
        out[_e356] = ((_e336 * 100i) + _e339);
        let _e358 = choose_a;
        c = i32(_e358);
        b = 7i;
        let _e362 = c;
        if (_e362 != 0i) {
            c = 0i;
            let _e366 = c;
            c = (_e366 + 1i);
            local_52 = _e366;
        } else {
            b = 0i;
            let _e371 = b;
            b = (_e371 + 1i);
            local_52 = _e371;
        }
        let _e376 = local_52;
        let _e377 = local;
        local_49 = _e377;
        let _e379 = local_49;
        local_50 = u32(_e379);
        let _e382 = base;
        local_51 = u32((_e382 + 10u));
        let _e387 = local_50;
        let _e388 = local_51;
        local_117 = u32((_e387 + _e388));
        let _e392 = local_117;
        out[_e392] = _e376;
        let _e394 = c;
        let _e397 = b;
        let _e399 = local;
        local_53 = _e399;
        let _e401 = local_53;
        local_54 = u32(_e401);
        let _e404 = base;
        local_55 = u32((_e404 + 11u));
        let _e409 = local_54;
        let _e410 = local_55;
        local_118 = u32((_e409 + _e410));
        let _e414 = local_118;
        out[_e414] = ((_e394 * 10i) + _e397);
        condition = 0i;
        a = 2i;
        b = 4i;
        condition = 1i;
        let _e421 = condition;
        let _e422 = condition;
        if (_e422 != 0i) {
            a = _e421;
        } else {
            b = _e421;
        }
        let _e425 = a;
        let _e428 = b;
        let _e430 = local;
        local_56 = _e430;
        let _e432 = local_56;
        local_57 = u32(_e432);
        let _e435 = base;
        local_58 = u32((_e435 + 12u));
        let _e440 = local_57;
        let _e441 = local_58;
        local_119 = u32((_e440 + _e441));
        let _e445 = local_119;
        out[_e445] = ((_e425 * 10i) + _e428);
        a = 2i;
        b = 4i;
        c = 6i;
        let _e450 = choose_a;
        if _e450 {
            let _e451 = i;
            if ((_e451 % 4u) == 0u) {
                let _e456 = a;
                a = (_e456 + 3i);
            } else {
                let _e459 = b;
                b = (_e459 + 3i);
            }
        } else {
            let _e462 = c;
            c = (_e462 + 3i);
        }
        let _e465 = a;
        let _e468 = b;
        let _e472 = c;
        let _e474 = local;
        local_59 = _e474;
        let _e476 = local_59;
        local_60 = u32(_e476);
        let _e479 = base;
        local_61 = u32((_e479 + 13u));
        let _e484 = local_60;
        let _e485 = local_61;
        local_120 = u32((_e484 + _e485));
        let _e489 = local_120;
        out[_e489] = (((_e465 * 100i) + (_e468 * 10i)) + _e472);
        lane = threadIdx.x;
        let _e493 = lane;
        shared_values[_e493] = 20i;
        local_value = 10i;
        let _e499 = choose_a;
        if _e499 {
            let _e500 = local_value;
            local_value = (_e500 + 5i);
        } else {
            let _e503 = lane;
            let _e505 = shared_values[_e503];
            shared_values[_e503] = (_e505 + 5i);
        }
        let _e508 = local_value;
        let _e511 = lane;
        let _e513 = shared_values[_e511];
        let _e515 = local;
        local_62 = _e515;
        let _e517 = local_62;
        local_63 = u32(_e517);
        let _e520 = base;
        local_64 = u32((_e520 + 14u));
        let _e525 = local_63;
        let _e526 = local_64;
        local_121 = u32((_e525 + _e526));
        let _e530 = local_121;
        out[_e530] = ((_e508 * 100i) + _e513);
        let _e532 = choose_a;
        if _e532 {
            let _e533 = lane;
            shared_values[_e533] = 30i;
        } else {
            let _e536 = local;
            local_65 = _e536;
            let _e538 = local_65;
            local_66 = u32(_e538);
            let _e541 = base;
            local_67 = u32((_e541 + 15u));
            let _e546 = local_66;
            let _e547 = local_67;
            local_122 = u32((_e546 + _e547));
            let _e552 = local_122;
            out[_e552] = 30i;
        }
        let _e554 = lane;
        let _e556 = shared_values[_e554];
        let _e557 = local;
        local_68 = _e557;
        let _e559 = local_68;
        local_69 = u32(_e559);
        let _e562 = base;
        local_70 = u32((_e562 + 16u));
        let _e567 = local_69;
        let _e568 = local_70;
        local_123 = u32((_e567 + _e568));
        let _e572 = local_123;
        out[_e572] = _e556;
        let _e574 = choose_a;
        if _e574 {
            local_74 = 1.5f;
        } else {
            local_74 = f32(3i);
        }
        let _e581 = local_74;
        let _e582 = local;
        local_71 = _e582;
        let _e584 = local_71;
        local_72 = u32(_e584);
        let _e587 = base;
        local_73 = u32((_e587 + 17u));
        let _e593 = local_72;
        let _e594 = local_73;
        local_124 = u32((_e593 + _e594));
        let _e598 = local_124;
        out[_e598] = i32(_e581);
        let _e600 = choose_a;
        if _e600 {
            local_78 = u32(-(1i));
        } else {
            local_78 = 2u;
        }
        let _e608 = local_78;
        let _e609 = local;
        local_75 = _e609;
        let _e611 = local_75;
        local_76 = u32(_e611);
        let _e614 = base;
        local_77 = u32((_e614 + 18u));
        let _e620 = local_76;
        let _e621 = local_77;
        local_125 = u32((_e620 + _e621));
        let _e625 = local_125;
        out[_e625] = i32(_e608);
        let _e627 = choose_a;
        if _e627 {
            local_82 = true;
        } else {
            local_82 = false;
        }
        let _e633 = local_82;
        let _e634 = local;
        local_79 = _e634;
        let _e636 = local_79;
        local_80 = u32(_e636);
        let _e639 = base;
        local_81 = u32((_e639 + 19u));
        let _e645 = local_80;
        let _e646 = local_81;
        local_126 = u32((_e645 + _e646));
        let _e650 = local_126;
        out[_e650] = i32(_e633);
        let _e652 = choose_a;
        if _e652 {
            local_86 = i32(true);
        } else {
            local_86 = 2i;
        }
        let _e659 = local_86;
        let _e660 = local;
        local_83 = _e660;
        let _e662 = local_83;
        local_84 = u32(_e662);
        let _e665 = base;
        local_85 = u32((_e665 + 20u));
        let _e670 = local_84;
        let _e671 = local_85;
        local_127 = u32((_e670 + _e671));
        let _e675 = local_127;
        out[_e675] = _e659;
        let _e677 = choose_a;
        if _e677 {
            local_90 = 4u;
        } else {
            local_90 = 8u;
        }
        let _e683 = local_90;
        let _e684 = local;
        local_87 = _e684;
        let _e686 = local_87;
        local_88 = u32(_e686);
        let _e689 = base;
        local_89 = u32((_e689 + 21u));
        let _e695 = local_88;
        let _e696 = local_89;
        local_128 = u32((_e695 + _e696));
        let _e700 = local_128;
        out[_e700] = i32(_e683);
        a = 3i;
        shift_value = 2i;
        let _e705 = choose_a;
        if _e705 {
            let _e706 = shift_value;
            local_94 = _e706;
        } else {
            let _e708 = a;
            local_94 = _e708;
        }
        let _e711 = local_94;
        shift_value = 1i;
        let _e713 = shift_value;
        local_95 = u32(_e713);
        let _e716 = local_95;
        let _e718 = local;
        local_91 = _e718;
        let _e720 = local_91;
        local_92 = u32(_e720);
        let _e723 = base;
        local_93 = u32((_e723 + 22u));
        let _e728 = local_92;
        let _e729 = local_93;
        local_129 = u32((_e728 + _e729));
        let _e733 = local_129;
        out[_e733] = (_e711 << _e716);
        value = 3i;
        other = 7i;
        let _e739 = choose_a;
        if _e739 {
            let _e740 = value;
            local_99 = _e740;
        } else {
            let _e742 = other;
            local_99 = _e742;
        }
        let _e745 = local_99;
        let _e746 = value;
        value = (_e746 + 1i);
        let _e749 = pair(_e745, _e746);
        let _e750 = local;
        local_96 = _e750;
        let _e752 = local_96;
        local_97 = u32(_e752);
        let _e755 = base;
        local_98 = u32((_e755 + 23u));
        let _e760 = local_97;
        let _e761 = local_98;
        local_130 = u32((_e760 + _e761));
        let _e765 = local_130;
        out[_e765] = _e749;
        count = 0i;
        left = 0i;
        right = 0i;
        {
            loop {
                let _e773 = count;
                if (_e773 < 3i) {
                } else {
                    break;
                }
                let _e776 = count;
                count = (_e776 + 1i);
                let _e779 = count;
                if (_e779 == 2i) {
                    continue;
                }
                continuing {
                    let _e782 = choose_a;
                    if _e782 {
                        let _e783 = left;
                        left = (_e783 + 1i);
                    } else {
                        let _e786 = right;
                        right = (_e786 + 1i);
                    }
                }
            }
        }
        let _e789 = left;
        let _e792 = right;
        let _e796 = count;
        let _e798 = local;
        local_100 = _e798;
        let _e800 = local_100;
        local_101 = u32(_e800);
        let _e803 = base;
        local_102 = u32((_e803 + 24u));
        let _e808 = local_101;
        let _e809 = local_102;
        local_131 = u32((_e808 + _e809));
        let _e813 = local_131;
        out[_e813] = (((_e789 * 100i) + (_e792 * 10i)) + _e796);
    }
}
