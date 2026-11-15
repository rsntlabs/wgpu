struct Record_cuda_record_0_ {
    x: i32,
    y: i32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
@group(0) @binding(1)
var<storage> input_2: array<i32>;

fn kind(value_2: i32) -> i32 {
    return 1i;
}

fn kind_1(value_3: u32) -> i32 {
    return 2i;
}

fn selected(value_4: i32) -> i32 {
    return (10i + value_4);
}

fn default_value_unsigned() -> u32 {
    return u32(7i);
}

fn self_named_unsigned() -> u32 {
    return u32(9i);
}

fn deduced_kind_int(value_5: i32) -> i32 {
    let _e1 = kind(value_5);
    return _e1;
}

fn deduced_kind_unsigned(value_6: u32) -> i32 {
    let _e1 = kind_1(value_6);
    return _e1;
}

fn converted_unsigned_int(value_7: i32) -> u32 {
    return u32(value_7);
}

fn converted_int_unsigned(value_8: u32) -> i32 {
    return i32(value_8);
}

fn selected_unsigned(value_9: u32) -> i32 {
    return (20i + i32(value_9));
}

fn selected_int(value_10: i32) -> i32 {
    return (20i + value_10);
}

fn frozen_cv_const_u0020_int() -> i32 {
    var value_11: i32;
    var local_141: i32;

    value_11 = 7i;
    local_141 = 4i;
    let _e3 = local_141;
    return _e3;
}

fn frozen_cv_int() -> i32 {
    var value_12: i32;
    var local_142: i32;

    value_12 = 7i;
    local_142 = 3i;
    let _e3 = local_142;
    return _e3;
}

fn vector_value_float3_() -> i32 {
    var value_13: float3_;

    value_13.x = 1f;
    value_13.y = 2f;
    value_13.z = 3f;
    let _e8 = value_13.z;
    return i32(_e8);
}

fn record_value_Record() -> i32 {
    var value_14: Record_cuda_record_0_;

    value_14.x = 4i;
    value_14.y = 5i;
    let _e7 = value_14.x;
    let _e8 = value_14.y;
    return (_e7 + _e8);
}

fn shape_value_dim3_() -> u32 {
    var value_15: dim3_;

    value_15 = dim3_(1u, 1u, 1u);
    let _e8 = value_15.y;
    let _e10 = value_15.x;
    let _e14 = value_15.z;
    return ((_e10 + (10u * _e8)) + (100u * _e14));
}

fn null_value_decltype_u0028_nullptr_u0029_() {
    return;
}

@compute @workgroup_size(4, 1, 1)
fn default_template_arguments(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var output: array<u32, 2>;
    var input: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
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
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var value: i32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: bool;
    var local_42: i32;
    var local_43: bool;
    var local_44: i32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var input_1: array<u32, 2>;
    var local_55: array<u32, 2>;
    var value_1: array<u32, 2>;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: i32;
    var amount: i32;
    var old: i32;
    var amount_1: i32;
    var old_1: i32;
    var amount_2: i32;
    var old_2: i32;
    var local_59: i32;
    var local_60: i32;
    var amount_3: i32;
    var old_3: i32;
    var local_61: i32;
    var local_62: i32;
    var amount_4: i32;
    var old_4: i32;
    var amount_5: i32;
    var old_5: i32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: u32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: u32;
    var local_72: array<u32, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;
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

    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    input = array<u32, 2>();
    input[0] = 3u;
    input[1] = 0u;
    let lane = threadIdx.x;
    let base = (4u + (lane * 24u));
    let _e18 = default_value_unsigned();
    let _e20 = output;
    local = _e20;
    let _e22 = local;
    local_63 = _e22;
    let _e25 = local_63[1];
    local_63[1] = (_e25 + base);
    let _e29 = local_63[0];
    local_64 = u32(_e29);
    let _e33 = local_63[1];
    local_65 = u32(_e33);
    let _e36 = local_65;
    output_1[_e36] = _e18;
    let _e39 = default_value_unsigned();
    let _e40 = output;
    local_1 = _e40;
    local_2 = u32((base + 1u));
    let _e46 = local_1;
    local_66 = _e46;
    let _e48 = local_2;
    let _e50 = local_66[1];
    local_66[1] = (_e50 + _e48);
    let _e54 = local_66[0];
    local_67 = u32(_e54);
    let _e58 = local_66[1];
    local_68 = u32(_e58);
    let _e61 = local_68;
    output_1[_e61] = _e39;
    let _e63 = default_value_unsigned();
    let _e64 = output;
    local_3 = _e64;
    local_4 = u32((base + 2u));
    let _e70 = local_3;
    local_69 = _e70;
    let _e72 = local_4;
    let _e74 = local_69[1];
    local_69[1] = (_e74 + _e72);
    let _e78 = local_69[0];
    local_70 = u32(_e78);
    let _e82 = local_69[1];
    local_71 = u32(_e82);
    let _e85 = local_71;
    output_1[_e85] = _e63;
    let _e87 = self_named_unsigned();
    let _e88 = output;
    local_5 = _e88;
    local_6 = u32((base + 3u));
    let _e94 = local_5;
    local_72 = _e94;
    let _e96 = local_6;
    let _e98 = local_72[1];
    local_72[1] = (_e98 + _e96);
    let _e102 = local_72[0];
    local_73 = u32(_e102);
    let _e106 = local_72[1];
    local_74 = u32(_e106);
    let _e109 = local_74;
    output_1[_e109] = _e87;
    let _e112 = deduced_kind_int(1i);
    let _e114 = output;
    local_7 = _e114;
    local_8 = u32((base + 4u));
    let _e120 = local_7;
    local_75 = _e120;
    let _e122 = local_8;
    let _e124 = local_75[1];
    local_75[1] = (_e124 + _e122);
    let _e128 = local_75[0];
    local_76 = u32(_e128);
    let _e132 = local_75[1];
    local_77 = u32(_e132);
    let _e135 = local_77;
    output_1[_e135] = u32(_e112);
    let _e138 = deduced_kind_unsigned(1u);
    let _e140 = output;
    local_9 = _e140;
    local_10 = u32((base + 5u));
    let _e146 = local_9;
    local_78 = _e146;
    let _e148 = local_10;
    let _e150 = local_78[1];
    local_78[1] = (_e150 + _e148);
    let _e154 = local_78[0];
    local_79 = u32(_e154);
    let _e158 = local_78[1];
    local_80 = u32(_e158);
    let _e161 = local_80;
    output_1[_e161] = u32(_e138);
    let _e164 = converted_unsigned_int(3i);
    let _e165 = kind_1(_e164);
    let _e167 = output;
    local_11 = _e167;
    local_12 = u32((base + 6u));
    let _e173 = local_11;
    local_81 = _e173;
    let _e175 = local_12;
    let _e177 = local_81[1];
    local_81[1] = (_e177 + _e175);
    let _e181 = local_81[0];
    local_82 = u32(_e181);
    let _e185 = local_81[1];
    local_83 = u32(_e185);
    let _e188 = local_83;
    output_1[_e188] = u32(_e165);
    let _e191 = converted_int_unsigned(3u);
    let _e192 = kind(_e191);
    let _e194 = output;
    local_13 = _e194;
    local_14 = u32((base + 7u));
    let _e200 = local_13;
    local_84 = _e200;
    let _e202 = local_14;
    let _e204 = local_84[1];
    local_84[1] = (_e204 + _e202);
    let _e208 = local_84[0];
    local_85 = u32(_e208);
    let _e212 = local_84[1];
    local_86 = u32(_e212);
    let _e215 = local_86;
    output_1[_e215] = u32(_e192);
    let _e218 = selected(1i);
    let _e220 = output;
    local_15 = _e220;
    local_16 = u32((base + 8u));
    let _e226 = local_15;
    local_87 = _e226;
    let _e228 = local_16;
    let _e230 = local_87[1];
    local_87[1] = (_e230 + _e228);
    let _e234 = local_87[0];
    local_88 = u32(_e234);
    let _e238 = local_87[1];
    local_89 = u32(_e238);
    let _e241 = local_89;
    output_1[_e241] = u32(_e218);
    let _e244 = selected_unsigned(1u);
    let _e246 = output;
    local_17 = _e246;
    local_18 = u32((base + 9u));
    let _e252 = local_17;
    local_90 = _e252;
    let _e254 = local_18;
    let _e256 = local_90[1];
    local_90[1] = (_e256 + _e254);
    let _e260 = local_90[0];
    local_91 = u32(_e260);
    let _e264 = local_90[1];
    local_92 = u32(_e264);
    let _e267 = local_92;
    output_1[_e267] = u32(_e244);
    let _e270 = selected_int(1i);
    let _e272 = output;
    local_19 = _e272;
    local_20 = u32((base + 10u));
    let _e278 = local_19;
    local_93 = _e278;
    let _e280 = local_20;
    let _e282 = local_93[1];
    local_93[1] = (_e282 + _e280);
    let _e286 = local_93[0];
    local_94 = u32(_e286);
    let _e290 = local_93[1];
    local_95 = u32(_e290);
    let _e293 = local_95;
    output_1[_e293] = u32(_e270);
    let _e295 = frozen_cv_const_u0020_int();
    let _e297 = output;
    local_21 = _e297;
    local_22 = u32((base + 11u));
    let _e303 = local_21;
    local_96 = _e303;
    let _e305 = local_22;
    let _e307 = local_96[1];
    local_96[1] = (_e307 + _e305);
    let _e311 = local_96[0];
    local_97 = u32(_e311);
    let _e315 = local_96[1];
    local_98 = u32(_e315);
    let _e318 = local_98;
    output_1[_e318] = u32(_e295);
    let _e320 = frozen_cv_int();
    let _e322 = output;
    local_23 = _e322;
    local_24 = u32((base + 12u));
    let _e328 = local_23;
    local_99 = _e328;
    let _e330 = local_24;
    let _e332 = local_99[1];
    local_99[1] = (_e332 + _e330);
    let _e336 = local_99[0];
    local_100 = u32(_e336);
    let _e340 = local_99[1];
    local_101 = u32(_e340);
    let _e343 = local_101;
    output_1[_e343] = u32(_e320);
    let _e345 = vector_value_float3_();
    let _e347 = output;
    local_25 = _e347;
    local_26 = u32((base + 13u));
    let _e353 = local_25;
    local_102 = _e353;
    let _e355 = local_26;
    let _e357 = local_102[1];
    local_102[1] = (_e357 + _e355);
    let _e361 = local_102[0];
    local_103 = u32(_e361);
    let _e365 = local_102[1];
    local_104 = u32(_e365);
    let _e368 = local_104;
    output_1[_e368] = u32(_e345);
    let _e370 = record_value_Record();
    let _e372 = output;
    local_27 = _e372;
    local_28 = u32((base + 14u));
    let _e378 = local_27;
    local_105 = _e378;
    let _e380 = local_28;
    let _e382 = local_105[1];
    local_105[1] = (_e382 + _e380);
    let _e386 = local_105[0];
    local_106 = u32(_e386);
    let _e390 = local_105[1];
    local_107 = u32(_e390);
    let _e393 = local_107;
    output_1[_e393] = u32(_e370);
    let _e395 = shape_value_dim3_();
    let _e396 = output;
    local_29 = _e396;
    local_30 = u32((base + 15u));
    let _e402 = local_29;
    local_108 = _e402;
    let _e404 = local_30;
    let _e406 = local_108[1];
    local_108[1] = (_e406 + _e404);
    let _e410 = local_108[0];
    local_109 = u32(_e410);
    let _e414 = local_108[1];
    local_110 = u32(_e414);
    let _e417 = local_110;
    output_1[_e417] = _e395;
    null_value_decltype_u0028_nullptr_u0029_();
    let _e421 = output;
    local_31 = _e421;
    local_32 = u32((base + 16u));
    let _e427 = local_31;
    local_111 = _e427;
    let _e429 = local_32;
    let _e431 = local_111[1];
    local_111[1] = (_e431 + _e429);
    let _e435 = local_111[0];
    local_112 = u32(_e435);
    let _e439 = local_111[1];
    local_113 = u32(_e439);
    let _e442 = local_113;
    output_1[_e442] = u32(true);
    let _e445 = input;
    local_35 = _e445;
    local_36 = u32(1i);
    local_57 = u32();
    local_58 = i32();
    let _e454 = local_35;
    input_1 = _e454;
    let _e456 = local_36;
    let _e458 = input_1[1];
    input_1[1] = (_e458 + _e456);
    let _e462 = input_1;
    local_55 = _e462;
    let _e464 = local_55;
    value_1 = _e464;
    let _e467 = value_1;
    local_56 = _e467;
    local_57 = u32(0i);
    let _e472 = local_56;
    local_114 = _e472;
    let _e474 = local_57;
    let _e476 = local_114[1];
    local_114[1] = (_e476 + _e474);
    let _e480 = local_114[0];
    local_115 = u32(_e480);
    let _e484 = local_114[1];
    local_116 = u32(_e484);
    let _e487 = local_116;
    let _e490 = input_2[_e487];
    local_58 = _e490;
    let _e492 = local_58;
    let _e494 = output;
    local_33 = _e494;
    local_34 = u32((base + 17u));
    let _e500 = local_33;
    local_117 = _e500;
    let _e502 = local_34;
    let _e504 = local_117[1];
    local_117[1] = (_e504 + _e502);
    let _e508 = local_117[0];
    local_118 = u32(_e508);
    let _e512 = local_117[1];
    local_119 = u32(_e512);
    let _e515 = local_119;
    output_1[_e515] = u32(_e492);
    value = (i32(lane) + 1i);
    amount = i32();
    old = i32();
    amount = 2i;
    let _e527 = value;
    old = _e527;
    let _e529 = amount;
    let _e530 = value;
    value = (_e530 + _e529);
    let _e532 = old;
    let _e534 = output;
    local_37 = _e534;
    local_38 = u32((base + 18u));
    let _e540 = local_37;
    local_120 = _e540;
    let _e542 = local_38;
    let _e544 = local_120[1];
    local_120[1] = (_e544 + _e542);
    let _e548 = local_120[0];
    local_121 = u32(_e548);
    let _e552 = local_120[1];
    local_122 = u32(_e552);
    let _e555 = local_122;
    output_1[_e555] = u32(_e532);
    amount_1 = i32();
    old_1 = i32();
    amount_1 = 3i;
    let _e563 = value;
    old_1 = _e563;
    let _e565 = amount_1;
    let _e566 = value;
    value = (_e566 + _e565);
    let _e568 = old_1;
    let _e570 = output;
    local_39 = _e570;
    local_40 = u32((base + 19u));
    let _e576 = local_39;
    local_123 = _e576;
    let _e578 = local_40;
    let _e580 = local_123[1];
    local_123[1] = (_e580 + _e578);
    let _e584 = local_123[0];
    local_124 = u32(_e584);
    let _e588 = local_123[1];
    local_125 = u32(_e588);
    let _e591 = local_125;
    output_1[_e591] = u32(_e568);
    local_41 = false;
    if false {
        amount_2 = i32();
        old_2 = i32();
        amount_2 = 2i;
        let _e601 = value;
        local_59 = _e601;
        let _e603 = local_59;
        old_2 = _e603;
        let _e605 = amount_2;
        let _e606 = value;
        local_60 = _e606;
        let _e608 = local_60;
        value = (_e608 + _e605);
        let _e610 = old_2;
        local_42 = _e610;
        let _e612 = local_42;
        local_41 = (_e612 != 0i);
    }
    local_43 = true;
    if true {
    } else {
        amount_3 = i32();
        old_3 = i32();
        amount_3 = 2i;
        let _e623 = value;
        local_61 = _e623;
        let _e625 = local_61;
        old_3 = _e625;
        let _e627 = amount_3;
        let _e628 = value;
        local_62 = _e628;
        let _e630 = local_62;
        value = (_e630 + _e627);
        let _e632 = old_3;
        local_44 = _e632;
        let _e634 = local_44;
        local_43 = (_e634 != 0i);
    }
    amount_4 = i32();
    old_4 = i32();
    amount_4 = 2i;
    let _e643 = value;
    old_4 = _e643;
    let _e645 = amount_4;
    let _e646 = value;
    value = (_e646 + _e645);
    let _e648 = value;
    let _e650 = output;
    local_45 = _e650;
    local_46 = u32((base + 20u));
    let _e656 = local_45;
    local_126 = _e656;
    let _e658 = local_46;
    let _e660 = local_126[1];
    local_126[1] = (_e660 + _e658);
    let _e664 = local_126[0];
    local_127 = u32(_e664);
    let _e668 = local_126[1];
    local_128 = u32(_e668);
    let _e671 = local_128;
    output_1[_e671] = u32(_e648);
    let _e673 = default_value_unsigned();
    let _e674 = kind_1(_e673);
    let _e676 = output;
    local_47 = _e676;
    local_48 = u32((base + 21u));
    let _e682 = local_47;
    local_129 = _e682;
    let _e684 = local_48;
    let _e686 = local_129[1];
    local_129[1] = (_e686 + _e684);
    let _e690 = local_129[0];
    local_130 = u32(_e690);
    let _e694 = local_129[1];
    local_131 = u32(_e694);
    let _e697 = local_131;
    output_1[_e697] = u32(_e674);
    let _e699 = input;
    local_51 = _e699;
    local_52 = u32(0i);
    let _e704 = local_51;
    local_132 = _e704;
    let _e706 = local_52;
    let _e708 = local_132[1];
    local_132[1] = (_e708 + _e706);
    let _e712 = local_132[0];
    local_133 = u32(_e712);
    let _e716 = local_132[1];
    local_134 = u32(_e716);
    let _e719 = local_134;
    let _e721 = input_2[_e719];
    amount_5 = i32();
    old_5 = i32();
    amount_5 = _e721;
    let _e727 = value;
    old_5 = _e727;
    let _e729 = amount_5;
    let _e730 = value;
    value = (_e730 + _e729);
    let _e732 = old_5;
    let _e734 = output;
    local_49 = _e734;
    local_50 = u32((base + 22u));
    let _e740 = local_49;
    local_135 = _e740;
    let _e742 = local_50;
    let _e744 = local_135[1];
    local_135[1] = (_e744 + _e742);
    let _e748 = local_135[0];
    local_136 = u32(_e748);
    let _e752 = local_135[1];
    local_137 = u32(_e752);
    let _e755 = local_137;
    output_1[_e755] = u32(_e732);
    let _e757 = value;
    let _e759 = output;
    local_53 = _e759;
    local_54 = u32((base + 23u));
    let _e765 = local_53;
    local_138 = _e765;
    let _e767 = local_54;
    let _e769 = local_138[1];
    local_138[1] = (_e769 + _e767);
    let _e773 = local_138[0];
    local_139 = u32(_e773);
    let _e777 = local_138[1];
    local_140 = u32(_e777);
    let _e780 = local_140;
    output_1[_e780] = u32(_e757);
}
