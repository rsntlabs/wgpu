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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var choose_a: bool;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: i32;
    var a: i32;
    var b: i32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: i32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var index_a: i32;
    var index_b: i32;
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
    var local_29: i32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: i32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var c: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: i32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var condition: i32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var lane: u32;
    var local_value: i32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: f32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: u32;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: bool;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: i32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var shift_value: i32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: i32;
    var local_68: u32;
    var value: i32;
    var other: i32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: i32;
    var count: i32;
    var left: i32;
    var right: i32;
    var local_72: array<u32, 2>;
    var local_73: u32;
    var local_74: i32;
    var local_75: i32;
    var local_76: array<u32, 2>;
    var local_77: u32;
    var local_78: u32;
    var local_79: i32;
    var local_80: array<u32, 2>;
    var local_81: u32;
    var local_82: u32;
    var local_83: i32;
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
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    local_2 = array<u32, 2>();
    local_2[0] = 2u;
    local_2[1] = 0u;
    let _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e33 = i;
    let _e34 = n;
    if (_e33 < _e34) {
        let _e36 = i;
        base = (_e36 * 25u);
        let _e40 = i;
        choose_a = ((_e40 % 2u) == 0u);
        let _e46 = choose_a;
        if _e46 {
            let _e49 = local_1;
            local_5 = _e49;
            let _e50 = i;
            local_6 = u32(_e50);
            let _e54 = local_5;
            local_76 = _e54;
            let _e55 = local_6;
            let _e57 = local_76[1];
            local_76[1] = (_e57 + _e55);
            let _e61 = local_76[0];
            local_77 = u32(_e61);
            let _e65 = local_76[1];
            local_78 = u32(_e65);
            let _e69 = local_78;
            let _e71 = input_a[_e69];
            local_79 = _e71;
            let _e72 = local_79;
            local_74 = _e72;
            let _e74 = local_74;
            local_9 = _e74;
        } else {
            let _e78 = local_2;
            local_7 = _e78;
            let _e79 = i;
            local_8 = u32(_e79);
            let _e83 = local_7;
            local_80 = _e83;
            let _e84 = local_8;
            let _e86 = local_80[1];
            local_80[1] = (_e86 + _e84);
            let _e90 = local_80[0];
            local_81 = u32(_e90);
            let _e94 = local_80[1];
            local_82 = u32(_e94);
            let _e98 = local_82;
            let _e100 = input_b[_e98];
            local_83 = _e100;
            let _e101 = local_83;
            local_75 = _e101;
            let _e103 = local_75;
            local_9 = _e103;
        }
        let _e106 = local_9;
        let _e109 = local;
        local_3 = _e109;
        let _e110 = base;
        local_4 = u32(_e110);
        let _e114 = local_3;
        local_84 = _e114;
        let _e115 = local_4;
        let _e117 = local_84[1];
        local_84[1] = (_e117 + _e115);
        let _e121 = local_84[0];
        local_85 = u32(_e121);
        let _e125 = local_84[1];
        local_86 = u32(_e125);
        let _e128 = local_86;
        out[_e128] = _e106;
        a = 3i;
        b = 5i;
        let _e134 = choose_a;
        if _e134 {
            let _e135 = a;
            a = (_e135 + 1i);
            let _e138 = shifted(_e135);
            local_12 = _e138;
        } else {
            let _e140 = b;
            b = (_e140 + 1i);
            let _e143 = shifted(_e140);
            local_12 = _e143;
        }
        let _e146 = local_12;
        let _e148 = local;
        local_10 = _e148;
        let _e149 = base;
        local_11 = u32((_e149 + 1u));
        let _e155 = local_10;
        local_87 = _e155;
        let _e156 = local_11;
        let _e158 = local_87[1];
        local_87[1] = (_e158 + _e156);
        let _e162 = local_87[0];
        local_88 = u32(_e162);
        let _e166 = local_87[1];
        local_89 = u32(_e166);
        let _e169 = local_89;
        out[_e169] = _e146;
        let _e171 = a;
        let _e174 = b;
        let _e177 = local;
        local_13 = _e177;
        let _e178 = base;
        local_14 = u32((_e178 + 2u));
        let _e184 = local_13;
        local_90 = _e184;
        let _e185 = local_14;
        let _e187 = local_90[1];
        local_90[1] = (_e187 + _e185);
        let _e191 = local_90[0];
        local_91 = u32(_e191);
        let _e195 = local_90[1];
        local_92 = u32(_e195);
        let _e198 = local_92;
        out[_e198] = ((_e171 * 10i) + _e174);
        let _e200 = choose_a;
        if _e200 {
            let _e201 = a;
            a = (_e201 + 1i);
            discard_(_e201);
        } else {
            let _e204 = b;
            b = (_e204 + 1i);
            discard_(_e204);
        }
        let _e207 = a;
        let _e210 = b;
        let _e213 = local;
        local_15 = _e213;
        let _e214 = base;
        local_16 = u32((_e214 + 3u));
        let _e220 = local_15;
        local_93 = _e220;
        let _e221 = local_16;
        let _e223 = local_93[1];
        local_93[1] = (_e223 + _e221);
        let _e227 = local_93[0];
        local_94 = u32(_e227);
        let _e231 = local_93[1];
        local_95 = u32(_e231);
        let _e234 = local_95;
        out[_e234] = ((_e207 * 10i) + _e210);
        index_a = 0i;
        index_b = 0i;
        let _e240 = choose_a;
        if _e240 {
            let _e243 = local_1;
            local_17 = _e243;
            let _e244 = index_a;
            index_a = (_e244 + 1i);
            local_18 = u32(_e244);
        } else {
            let _e251 = local_2;
            local_19 = _e251;
            let _e252 = index_b;
            index_b = (_e252 + 1i);
            local_20 = u32(_e252);
        }
        let _e257 = index_a;
        let _e260 = index_b;
        let _e263 = local;
        local_21 = _e263;
        let _e264 = base;
        local_22 = u32((_e264 + 4u));
        let _e270 = local_21;
        local_96 = _e270;
        let _e271 = local_22;
        let _e273 = local_96[1];
        local_96[1] = (_e273 + _e271);
        let _e277 = local_96[0];
        local_97 = u32(_e277);
        let _e281 = local_96[1];
        local_98 = u32(_e281);
        let _e284 = local_98;
        out[_e284] = ((_e257 * 10i) + _e260);
        a = 3i;
        b = 5i;
        let _e288 = choose_a;
        if _e288 {
            a = 7i;
        } else {
            b = 7i;
        }
        let _e291 = a;
        let _e294 = b;
        let _e297 = local;
        local_23 = _e297;
        let _e298 = base;
        local_24 = u32((_e298 + 5u));
        let _e304 = local_23;
        local_99 = _e304;
        let _e305 = local_24;
        let _e307 = local_99[1];
        local_99[1] = (_e307 + _e305);
        let _e311 = local_99[0];
        local_100 = u32(_e311);
        let _e315 = local_99[1];
        local_101 = u32(_e315);
        let _e318 = local_101;
        out[_e318] = ((_e291 * 10i) + _e294);
        let _e320 = choose_a;
        if _e320 {
            let _e321 = a;
            a = (_e321 + 2i);
        } else {
            let _e324 = b;
            b = (_e324 + 2i);
        }
        let _e327 = a;
        let _e330 = b;
        let _e333 = local;
        local_25 = _e333;
        let _e334 = base;
        local_26 = u32((_e334 + 6u));
        let _e340 = local_25;
        local_102 = _e340;
        let _e341 = local_26;
        let _e343 = local_102[1];
        local_102[1] = (_e343 + _e341);
        let _e347 = local_102[0];
        local_103 = u32(_e347);
        let _e351 = local_102[1];
        local_104 = u32(_e351);
        let _e354 = local_104;
        out[_e354] = ((_e327 * 10i) + _e330);
        let _e356 = choose_a;
        if _e356 {
            let _e357 = a;
            a = (_e357 + 1i);
            let _e360 = a;
            local_29 = _e360;
        } else {
            let _e362 = b;
            b = (_e362 + 1i);
            let _e365 = b;
            local_29 = _e365;
        }
        let _e368 = local_29;
        let _e370 = local;
        local_27 = _e370;
        let _e371 = base;
        local_28 = u32((_e371 + 7u));
        let _e377 = local_27;
        local_105 = _e377;
        let _e378 = local_28;
        let _e380 = local_105[1];
        local_105[1] = (_e380 + _e378);
        let _e384 = local_105[0];
        local_106 = u32(_e384);
        let _e388 = local_105[1];
        local_107 = u32(_e388);
        let _e391 = local_107;
        out[_e391] = _e368;
        let _e393 = choose_a;
        if _e393 {
            let _e394 = a;
            a = (_e394 + 1i);
            local_32 = _e394;
        } else {
            let _e398 = b;
            b = (_e398 + 1i);
            local_32 = _e398;
        }
        let _e403 = local_32;
        let _e405 = local;
        local_30 = _e405;
        let _e406 = base;
        local_31 = u32((_e406 + 8u));
        let _e412 = local_30;
        local_108 = _e412;
        let _e413 = local_31;
        let _e415 = local_108[1];
        local_108[1] = (_e415 + _e413);
        let _e419 = local_108[0];
        local_109 = u32(_e419);
        let _e423 = local_108[1];
        local_110 = u32(_e423);
        let _e426 = local_110;
        out[_e426] = _e403;
        let _e428 = a;
        let _e431 = b;
        let _e434 = local;
        local_33 = _e434;
        let _e435 = base;
        local_34 = u32((_e435 + 9u));
        let _e441 = local_33;
        local_111 = _e441;
        let _e442 = local_34;
        let _e444 = local_111[1];
        local_111[1] = (_e444 + _e442);
        let _e448 = local_111[0];
        local_112 = u32(_e448);
        let _e452 = local_111[1];
        local_113 = u32(_e452);
        let _e455 = local_113;
        out[_e455] = ((_e428 * 100i) + _e431);
        let _e457 = choose_a;
        c = i32(_e457);
        b = 7i;
        let _e461 = c;
        if (_e461 != 0i) {
            c = 0i;
            let _e465 = c;
            c = (_e465 + 1i);
            local_37 = _e465;
        } else {
            b = 0i;
            let _e470 = b;
            b = (_e470 + 1i);
            local_37 = _e470;
        }
        let _e475 = local_37;
        let _e477 = local;
        local_35 = _e477;
        let _e478 = base;
        local_36 = u32((_e478 + 10u));
        let _e484 = local_35;
        local_114 = _e484;
        let _e485 = local_36;
        let _e487 = local_114[1];
        local_114[1] = (_e487 + _e485);
        let _e491 = local_114[0];
        local_115 = u32(_e491);
        let _e495 = local_114[1];
        local_116 = u32(_e495);
        let _e498 = local_116;
        out[_e498] = _e475;
        let _e500 = c;
        let _e503 = b;
        let _e506 = local;
        local_38 = _e506;
        let _e507 = base;
        local_39 = u32((_e507 + 11u));
        let _e513 = local_38;
        local_117 = _e513;
        let _e514 = local_39;
        let _e516 = local_117[1];
        local_117[1] = (_e516 + _e514);
        let _e520 = local_117[0];
        local_118 = u32(_e520);
        let _e524 = local_117[1];
        local_119 = u32(_e524);
        let _e527 = local_119;
        out[_e527] = ((_e500 * 10i) + _e503);
        condition = 0i;
        a = 2i;
        b = 4i;
        condition = 1i;
        let _e534 = condition;
        let _e535 = condition;
        if (_e535 != 0i) {
            a = _e534;
        } else {
            b = _e534;
        }
        let _e538 = a;
        let _e541 = b;
        let _e544 = local;
        local_40 = _e544;
        let _e545 = base;
        local_41 = u32((_e545 + 12u));
        let _e551 = local_40;
        local_120 = _e551;
        let _e552 = local_41;
        let _e554 = local_120[1];
        local_120[1] = (_e554 + _e552);
        let _e558 = local_120[0];
        local_121 = u32(_e558);
        let _e562 = local_120[1];
        local_122 = u32(_e562);
        let _e565 = local_122;
        out[_e565] = ((_e538 * 10i) + _e541);
        a = 2i;
        b = 4i;
        c = 6i;
        let _e570 = choose_a;
        if _e570 {
            let _e571 = i;
            if ((_e571 % 4u) == 0u) {
                let _e576 = a;
                a = (_e576 + 3i);
            } else {
                let _e579 = b;
                b = (_e579 + 3i);
            }
        } else {
            let _e582 = c;
            c = (_e582 + 3i);
        }
        let _e585 = a;
        let _e588 = b;
        let _e592 = c;
        let _e595 = local;
        local_42 = _e595;
        let _e596 = base;
        local_43 = u32((_e596 + 13u));
        let _e602 = local_42;
        local_123 = _e602;
        let _e603 = local_43;
        let _e605 = local_123[1];
        local_123[1] = (_e605 + _e603);
        let _e609 = local_123[0];
        local_124 = u32(_e609);
        let _e613 = local_123[1];
        local_125 = u32(_e613);
        let _e616 = local_125;
        out[_e616] = (((_e585 * 100i) + (_e588 * 10i)) + _e592);
        lane = threadIdx.x;
        let _e620 = lane;
        shared_values[_e620] = 20i;
        local_value = 10i;
        let _e626 = choose_a;
        if _e626 {
            let _e627 = local_value;
            local_value = (_e627 + 5i);
        } else {
            let _e630 = lane;
            let _e632 = shared_values[_e630];
            shared_values[_e630] = (_e632 + 5i);
        }
        let _e635 = local_value;
        let _e638 = lane;
        let _e640 = shared_values[_e638];
        let _e643 = local;
        local_44 = _e643;
        let _e644 = base;
        local_45 = u32((_e644 + 14u));
        let _e650 = local_44;
        local_126 = _e650;
        let _e651 = local_45;
        let _e653 = local_126[1];
        local_126[1] = (_e653 + _e651);
        let _e657 = local_126[0];
        local_127 = u32(_e657);
        let _e661 = local_126[1];
        local_128 = u32(_e661);
        let _e664 = local_128;
        out[_e664] = ((_e635 * 100i) + _e640);
        let _e666 = choose_a;
        if _e666 {
            let _e667 = lane;
            shared_values[_e667] = 30i;
        } else {
            let _e671 = local;
            local_46 = _e671;
            let _e672 = base;
            local_47 = u32((_e672 + 15u));
            let _e678 = local_46;
            local_129 = _e678;
            let _e679 = local_47;
            let _e681 = local_129[1];
            local_129[1] = (_e681 + _e679);
            let _e685 = local_129[0];
            local_130 = u32(_e685);
            let _e689 = local_129[1];
            local_131 = u32(_e689);
            let _e693 = local_131;
            out[_e693] = 30i;
        }
        let _e695 = lane;
        let _e697 = shared_values[_e695];
        let _e699 = local;
        local_48 = _e699;
        let _e700 = base;
        local_49 = u32((_e700 + 16u));
        let _e706 = local_48;
        local_132 = _e706;
        let _e707 = local_49;
        let _e709 = local_132[1];
        local_132[1] = (_e709 + _e707);
        let _e713 = local_132[0];
        local_133 = u32(_e713);
        let _e717 = local_132[1];
        local_134 = u32(_e717);
        let _e720 = local_134;
        out[_e720] = _e697;
        let _e722 = choose_a;
        if _e722 {
            local_52 = 1.5f;
        } else {
            local_52 = f32(3i);
        }
        let _e729 = local_52;
        let _e731 = local;
        local_50 = _e731;
        let _e732 = base;
        local_51 = u32((_e732 + 17u));
        let _e739 = local_50;
        local_135 = _e739;
        let _e740 = local_51;
        let _e742 = local_135[1];
        local_135[1] = (_e742 + _e740);
        let _e746 = local_135[0];
        local_136 = u32(_e746);
        let _e750 = local_135[1];
        local_137 = u32(_e750);
        let _e753 = local_137;
        out[_e753] = i32(_e729);
        let _e755 = choose_a;
        if _e755 {
            local_55 = u32(-(1i));
        } else {
            local_55 = 2u;
        }
        let _e763 = local_55;
        let _e765 = local;
        local_53 = _e765;
        let _e766 = base;
        local_54 = u32((_e766 + 18u));
        let _e773 = local_53;
        local_138 = _e773;
        let _e774 = local_54;
        let _e776 = local_138[1];
        local_138[1] = (_e776 + _e774);
        let _e780 = local_138[0];
        local_139 = u32(_e780);
        let _e784 = local_138[1];
        local_140 = u32(_e784);
        let _e787 = local_140;
        out[_e787] = i32(_e763);
        let _e789 = choose_a;
        if _e789 {
            local_58 = true;
        } else {
            local_58 = false;
        }
        let _e795 = local_58;
        let _e797 = local;
        local_56 = _e797;
        let _e798 = base;
        local_57 = u32((_e798 + 19u));
        let _e805 = local_56;
        local_141 = _e805;
        let _e806 = local_57;
        let _e808 = local_141[1];
        local_141[1] = (_e808 + _e806);
        let _e812 = local_141[0];
        local_142 = u32(_e812);
        let _e816 = local_141[1];
        local_143 = u32(_e816);
        let _e819 = local_143;
        out[_e819] = i32(_e795);
        let _e821 = choose_a;
        if _e821 {
            local_61 = i32(true);
        } else {
            local_61 = 2i;
        }
        let _e828 = local_61;
        let _e830 = local;
        local_59 = _e830;
        let _e831 = base;
        local_60 = u32((_e831 + 20u));
        let _e837 = local_59;
        local_144 = _e837;
        let _e838 = local_60;
        let _e840 = local_144[1];
        local_144[1] = (_e840 + _e838);
        let _e844 = local_144[0];
        local_145 = u32(_e844);
        let _e848 = local_144[1];
        local_146 = u32(_e848);
        let _e851 = local_146;
        out[_e851] = _e828;
        let _e853 = choose_a;
        if _e853 {
            local_64 = 4u;
        } else {
            local_64 = 8u;
        }
        let _e859 = local_64;
        let _e861 = local;
        local_62 = _e861;
        let _e862 = base;
        local_63 = u32((_e862 + 21u));
        let _e869 = local_62;
        local_147 = _e869;
        let _e870 = local_63;
        let _e872 = local_147[1];
        local_147[1] = (_e872 + _e870);
        let _e876 = local_147[0];
        local_148 = u32(_e876);
        let _e880 = local_147[1];
        local_149 = u32(_e880);
        let _e883 = local_149;
        out[_e883] = i32(_e859);
        a = 3i;
        shift_value = 2i;
        let _e888 = choose_a;
        if _e888 {
            let _e889 = shift_value;
            local_67 = _e889;
        } else {
            let _e891 = a;
            local_67 = _e891;
        }
        let _e894 = local_67;
        shift_value = 1i;
        let _e896 = shift_value;
        local_68 = u32(_e896);
        let _e899 = local_68;
        let _e902 = local;
        local_65 = _e902;
        let _e903 = base;
        local_66 = u32((_e903 + 22u));
        let _e909 = local_65;
        local_150 = _e909;
        let _e910 = local_66;
        let _e912 = local_150[1];
        local_150[1] = (_e912 + _e910);
        let _e916 = local_150[0];
        local_151 = u32(_e916);
        let _e920 = local_150[1];
        local_152 = u32(_e920);
        let _e923 = local_152;
        out[_e923] = (_e894 << _e899);
        value = 3i;
        other = 7i;
        let _e929 = choose_a;
        if _e929 {
            let _e930 = value;
            local_71 = _e930;
        } else {
            let _e932 = other;
            local_71 = _e932;
        }
        let _e935 = local_71;
        let _e936 = value;
        value = (_e936 + 1i);
        let _e939 = pair(_e935, _e936);
        let _e941 = local;
        local_69 = _e941;
        let _e942 = base;
        local_70 = u32((_e942 + 23u));
        let _e948 = local_69;
        local_153 = _e948;
        let _e949 = local_70;
        let _e951 = local_153[1];
        local_153[1] = (_e951 + _e949);
        let _e955 = local_153[0];
        local_154 = u32(_e955);
        let _e959 = local_153[1];
        local_155 = u32(_e959);
        let _e962 = local_155;
        out[_e962] = _e939;
        count = 0i;
        left = 0i;
        right = 0i;
        {
            loop {
                let _e970 = count;
                if (_e970 < 3i) {
                } else {
                    break;
                }
                let _e973 = count;
                count = (_e973 + 1i);
                let _e976 = count;
                if (_e976 == 2i) {
                    continue;
                }
                continuing {
                    let _e979 = choose_a;
                    if _e979 {
                        let _e980 = left;
                        left = (_e980 + 1i);
                    } else {
                        let _e983 = right;
                        right = (_e983 + 1i);
                    }
                }
            }
        }
        let _e986 = left;
        let _e989 = right;
        let _e993 = count;
        let _e996 = local;
        local_72 = _e996;
        let _e997 = base;
        local_73 = u32((_e997 + 24u));
        let _e1003 = local_72;
        local_156 = _e1003;
        let _e1004 = local_73;
        let _e1006 = local_156[1];
        local_156[1] = (_e1006 + _e1004);
        let _e1010 = local_156[0];
        local_157 = u32(_e1010);
        let _e1014 = local_156[1];
        local_158 = u32(_e1014);
        let _e1017 = local_158;
        out[_e1017] = (((_e986 * 100i) + (_e989 * 10i)) + _e993);
    }
}
