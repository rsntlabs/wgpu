struct R_cuda_record_0_ {
    x: i32,
    y: i32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct int1_ {
    x: i32,
}

struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
@group(0) @binding(1)
var<storage> input_9: array<i32>;

fn kind(value: i32) -> i32 {
    return 1i;
}

fn kind_1(value_1: u32) -> i32 {
    return 2i;
}

fn chain_unsigned_unsigned_const_u0020_unsigned() -> u32 {
    var value_2: u32;

    value_2 = 7u;
    let _e2 = value_2;
    return _e2;
}

fn selected_int_int(input_2: i32) -> i32 {
    let _e1 = kind(input_2);
    return _e1;
}

fn selected_unsigned_unsigned(input_3: u32) -> i32 {
    let _e1 = kind_1(input_3);
    return _e1;
}

fn cv_value_int_const_u0020_int() -> i32 {
    var value_3: i32;
    var local_123: i32;

    value_3 = 7i;
    local_123 = 4i;
    let _e3 = local_123;
    return _e3;
}

fn cv_value_int_int() -> i32 {
    var value_4: i32;
    var local_124: i32;

    value_4 = 7i;
    local_124 = 3i;
    let _e3 = local_124;
    return _e3;
}

fn merged_unsigned_unsigned(input_4: u32) -> u32 {
    return input_4;
}

fn vector3_float3_float3_(input_5: float3_) -> i32 {
    var input_6: float3_;
    var value_5: float3_;

    input_6 = input_5;
    let _e3 = input_6;
    value_5 = _e3;
    let _e5 = value_5.z;
    return i32(_e5);
}

fn vector1_int1_int1_(input_7: int1_) -> i32 {
    var input_8: int1_;
    var value_6: int1_;

    input_8 = input_7;
    let _e3 = input_8;
    value_6 = _e3;
    let _e5 = value_6.x;
    return _e5;
}

fn record_value_R_R() -> i32 {
    var value_7: R_cuda_record_0_;

    value_7.x = 4i;
    value_7.y = 5i;
    let _e7 = value_7.x;
    let _e8 = value_7.y;
    return (_e7 + _e8);
}

fn shape_dim3_dim3_() -> u32 {
    var value_8: dim3_;

    value_8 = dim3_(1u, 1u, 1u);
    let _e7 = value_8.x;
    let _e8 = value_8.y;
    let _e11 = value_8.z;
    return ((_e7 + _e8) + _e11);
}

fn null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_() {
    return;
}

@compute @workgroup_size(4, 1, 1)
fn dependent_type_defaults(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
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
    var vector: float3_;
    var one: int1_;
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
    var local_25: i32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var state: i32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: bool;
    var local_35: i32;
    var local_36: bool;
    var local_37: i32;
    var index: i32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var input_1: array<u32, 2>;
    var local_46: array<u32, 2>;
    var pointer: array<u32, 2>;
    var local_47: array<u32, 2>;
    var local_48: array<u32, 2>;
    var local_49: i32;
    var amount: i32;
    var copy: i32;
    var old: i32;
    var amount_1: u32;
    var copy_1: u32;
    var old_1: i32;
    var amount_2: i32;
    var copy_2: i32;
    var old_2: i32;
    var local_50: i32;
    var local_51: i32;
    var amount_3: i32;
    var copy_3: i32;
    var old_3: i32;
    var local_52: i32;
    var local_53: i32;
    var amount_4: i32;
    var copy_4: i32;
    var old_4: i32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: u32;
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

    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    input = array<u32, 2>();
    input[0] = 3u;
    input[1] = 0u;
    let lane = threadIdx.x;
    let base = (4u + (lane * 20u));
    let _e18 = chain_unsigned_unsigned_const_u0020_unsigned();
    let _e20 = output;
    local = _e20;
    let _e22 = local;
    local_54 = _e22;
    let _e25 = local_54[1];
    local_54[1] = (_e25 + base);
    let _e29 = local_54[0];
    local_55 = u32(_e29);
    let _e33 = local_54[1];
    local_56 = u32(_e33);
    let _e36 = local_56;
    output_1[_e36] = _e18;
    let _e39 = chain_unsigned_unsigned_const_u0020_unsigned();
    let _e40 = output;
    local_1 = _e40;
    local_2 = u32((base + 1u));
    let _e46 = local_1;
    local_57 = _e46;
    let _e48 = local_2;
    let _e50 = local_57[1];
    local_57[1] = (_e50 + _e48);
    let _e54 = local_57[0];
    local_58 = u32(_e54);
    let _e58 = local_57[1];
    local_59 = u32(_e58);
    let _e61 = local_59;
    output_1[_e61] = _e39;
    let _e63 = chain_unsigned_unsigned_const_u0020_unsigned();
    let _e64 = output;
    local_3 = _e64;
    local_4 = u32((base + 2u));
    let _e70 = local_3;
    local_60 = _e70;
    let _e72 = local_4;
    let _e74 = local_60[1];
    local_60[1] = (_e74 + _e72);
    let _e78 = local_60[0];
    local_61 = u32(_e78);
    let _e82 = local_60[1];
    local_62 = u32(_e82);
    let _e85 = local_62;
    output_1[_e85] = _e63;
    let _e88 = selected_int_int(1i);
    let _e90 = output;
    local_5 = _e90;
    local_6 = u32((base + 3u));
    let _e96 = local_5;
    local_63 = _e96;
    let _e98 = local_6;
    let _e100 = local_63[1];
    local_63[1] = (_e100 + _e98);
    let _e104 = local_63[0];
    local_64 = u32(_e104);
    let _e108 = local_63[1];
    local_65 = u32(_e108);
    let _e111 = local_65;
    output_1[_e111] = u32(_e88);
    let _e114 = selected_unsigned_unsigned(1u);
    let _e116 = output;
    local_7 = _e116;
    local_8 = u32((base + 4u));
    let _e122 = local_7;
    local_66 = _e122;
    let _e124 = local_8;
    let _e126 = local_66[1];
    local_66[1] = (_e126 + _e124);
    let _e130 = local_66[0];
    local_67 = u32(_e130);
    let _e134 = local_66[1];
    local_68 = u32(_e134);
    let _e137 = local_68;
    output_1[_e137] = u32(_e114);
    let _e139 = cv_value_int_const_u0020_int();
    let _e141 = output;
    local_9 = _e141;
    local_10 = u32((base + 5u));
    let _e147 = local_9;
    local_69 = _e147;
    let _e149 = local_10;
    let _e151 = local_69[1];
    local_69[1] = (_e151 + _e149);
    let _e155 = local_69[0];
    local_70 = u32(_e155);
    let _e159 = local_69[1];
    local_71 = u32(_e159);
    let _e162 = local_71;
    output_1[_e162] = u32(_e139);
    let _e164 = cv_value_int_int();
    let _e166 = output;
    local_11 = _e166;
    local_12 = u32((base + 6u));
    let _e172 = local_11;
    local_72 = _e172;
    let _e174 = local_12;
    let _e176 = local_72[1];
    local_72[1] = (_e176 + _e174);
    let _e180 = local_72[0];
    local_73 = u32(_e180);
    let _e184 = local_72[1];
    local_74 = u32(_e184);
    let _e187 = local_74;
    output_1[_e187] = u32(_e164);
    let _e190 = merged_unsigned_unsigned(8u);
    let _e191 = output;
    local_13 = _e191;
    local_14 = u32((base + 7u));
    let _e197 = local_13;
    local_75 = _e197;
    let _e199 = local_14;
    let _e201 = local_75[1];
    local_75[1] = (_e201 + _e199);
    let _e205 = local_75[0];
    local_76 = u32(_e205);
    let _e209 = local_75[1];
    local_77 = u32(_e209);
    let _e212 = local_77;
    output_1[_e212] = _e190;
    vector.x = f32(1i);
    vector.y = f32(2i);
    vector.z = f32(3i);
    one.x = 7i;
    let _e227 = vector;
    let _e228 = vector3_float3_float3_(_e227);
    let _e230 = output;
    local_15 = _e230;
    local_16 = u32((base + 8u));
    let _e236 = local_15;
    local_78 = _e236;
    let _e238 = local_16;
    let _e240 = local_78[1];
    local_78[1] = (_e240 + _e238);
    let _e244 = local_78[0];
    local_79 = u32(_e244);
    let _e248 = local_78[1];
    local_80 = u32(_e248);
    let _e251 = local_80;
    output_1[_e251] = u32(_e228);
    let _e253 = one;
    let _e254 = vector1_int1_int1_(_e253);
    let _e256 = output;
    local_17 = _e256;
    local_18 = u32((base + 9u));
    let _e262 = local_17;
    local_81 = _e262;
    let _e264 = local_18;
    let _e266 = local_81[1];
    local_81[1] = (_e266 + _e264);
    let _e270 = local_81[0];
    local_82 = u32(_e270);
    let _e274 = local_81[1];
    local_83 = u32(_e274);
    let _e277 = local_83;
    output_1[_e277] = u32(_e254);
    let _e279 = record_value_R_R();
    let _e281 = output;
    local_19 = _e281;
    local_20 = u32((base + 10u));
    let _e287 = local_19;
    local_84 = _e287;
    let _e289 = local_20;
    let _e291 = local_84[1];
    local_84[1] = (_e291 + _e289);
    let _e295 = local_84[0];
    local_85 = u32(_e295);
    let _e299 = local_84[1];
    local_86 = u32(_e299);
    let _e302 = local_86;
    output_1[_e302] = u32(_e279);
    let _e304 = shape_dim3_dim3_();
    let _e305 = output;
    local_21 = _e305;
    local_22 = u32((base + 11u));
    let _e311 = local_21;
    local_87 = _e311;
    let _e313 = local_22;
    let _e315 = local_87[1];
    local_87[1] = (_e315 + _e313);
    let _e319 = local_87[0];
    local_88 = u32(_e319);
    let _e323 = local_87[1];
    local_89 = u32(_e323);
    let _e326 = local_89;
    output_1[_e326] = _e304;
    null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_();
    let _e330 = output;
    local_23 = _e330;
    local_24 = u32((base + 12u));
    let _e336 = local_23;
    local_90 = _e336;
    let _e338 = local_24;
    let _e340 = local_90[1];
    local_90[1] = (_e340 + _e338);
    let _e344 = local_90[0];
    local_91 = u32(_e344);
    let _e348 = local_90[1];
    local_92 = u32(_e348);
    let _e351 = local_92;
    output_1[_e351] = u32(true);
    local_25 = 0i;
    local_49 = i32();
    input_1 = array<u32, 2>();
    input_1[0] = 4u;
    input_1[1] = 0u;
    let _e364 = input_1;
    local_46 = _e364;
    let _e366 = local_46;
    pointer = _e366;
    let _e369 = pointer;
    local_47 = _e369;
    let _e371 = local_47;
    local_93 = _e371;
    let _e374 = local_93[0];
    local_94 = u32(_e374);
    let _e378 = local_93[1];
    local_95 = u32(_e378);
    local_25 = 9i;
    let _e382 = pointer;
    local_48 = _e382;
    let _e384 = local_48;
    local_96 = _e384;
    let _e387 = local_96[0];
    local_97 = u32(_e387);
    let _e391 = local_96[1];
    local_98 = u32(_e391);
    let _e394 = local_25;
    local_49 = _e394;
    let _e396 = local_49;
    let _e398 = output;
    local_26 = _e398;
    local_27 = u32((base + 13u));
    let _e404 = local_26;
    local_99 = _e404;
    let _e406 = local_27;
    let _e408 = local_99[1];
    local_99[1] = (_e408 + _e406);
    let _e412 = local_99[0];
    local_100 = u32(_e412);
    let _e416 = local_99[1];
    local_101 = u32(_e416);
    let _e419 = local_101;
    output_1[_e419] = u32(_e396);
    let _e421 = local_25;
    let _e423 = output;
    local_28 = _e423;
    local_29 = u32((base + 14u));
    let _e429 = local_28;
    local_102 = _e429;
    let _e431 = local_29;
    let _e433 = local_102[1];
    local_102[1] = (_e433 + _e431);
    let _e437 = local_102[0];
    local_103 = u32(_e437);
    let _e441 = local_102[1];
    local_104 = u32(_e441);
    let _e444 = local_104;
    output_1[_e444] = u32(_e421);
    state = (i32(lane) + 1i);
    amount = i32();
    copy = i32();
    old = i32();
    amount = 2i;
    let _e458 = amount;
    copy = _e458;
    let _e460 = state;
    old = _e460;
    let _e462 = copy;
    let _e463 = state;
    state = (_e463 + _e462);
    let _e465 = old;
    let _e467 = output;
    local_30 = _e467;
    local_31 = u32((base + 15u));
    let _e473 = local_30;
    local_105 = _e473;
    let _e475 = local_31;
    let _e477 = local_105[1];
    local_105[1] = (_e477 + _e475);
    let _e481 = local_105[0];
    local_106 = u32(_e481);
    let _e485 = local_105[1];
    local_107 = u32(_e485);
    let _e488 = local_107;
    output_1[_e488] = u32(_e465);
    amount_1 = u32();
    copy_1 = u32();
    old_1 = i32();
    amount_1 = 3u;
    let _e498 = amount_1;
    copy_1 = _e498;
    let _e500 = state;
    old_1 = _e500;
    let _e502 = copy_1;
    let _e504 = state;
    state = (_e504 + i32(_e502));
    let _e506 = old_1;
    let _e508 = output;
    local_32 = _e508;
    local_33 = u32((base + 16u));
    let _e514 = local_32;
    local_108 = _e514;
    let _e516 = local_33;
    let _e518 = local_108[1];
    local_108[1] = (_e518 + _e516);
    let _e522 = local_108[0];
    local_109 = u32(_e522);
    let _e526 = local_108[1];
    local_110 = u32(_e526);
    let _e529 = local_110;
    output_1[_e529] = u32(_e506);
    local_34 = false;
    if false {
        amount_2 = i32();
        copy_2 = i32();
        old_2 = i32();
        amount_2 = 99i;
        let _e541 = amount_2;
        copy_2 = _e541;
        let _e543 = state;
        local_50 = _e543;
        let _e545 = local_50;
        old_2 = _e545;
        let _e547 = copy_2;
        let _e548 = state;
        local_51 = _e548;
        let _e550 = local_51;
        state = (_e550 + _e547);
        let _e552 = old_2;
        local_35 = _e552;
        let _e554 = local_35;
        local_34 = (_e554 != 0i);
    }
    local_36 = true;
    if true {
    } else {
        amount_3 = i32();
        copy_3 = i32();
        old_3 = i32();
        amount_3 = 99i;
        let _e567 = amount_3;
        copy_3 = _e567;
        let _e569 = state;
        local_52 = _e569;
        let _e571 = local_52;
        old_3 = _e571;
        let _e573 = copy_3;
        let _e574 = state;
        local_53 = _e574;
        let _e576 = local_53;
        state = (_e576 + _e573);
        let _e578 = old_3;
        local_37 = _e578;
        let _e580 = local_37;
        local_36 = (_e580 != 0i);
    }
    index = 0i;
    let _e586 = input;
    local_38 = _e586;
    let _e588 = index;
    index = (_e588 + 1i);
    local_39 = u32(_e588);
    let _e593 = local_38;
    local_111 = _e593;
    let _e595 = local_39;
    let _e597 = local_111[1];
    local_111[1] = (_e597 + _e595);
    let _e601 = local_111[0];
    local_112 = u32(_e601);
    let _e605 = local_111[1];
    local_113 = u32(_e605);
    let _e608 = local_113;
    let _e611 = input_9[_e608];
    amount_4 = i32();
    copy_4 = i32();
    old_4 = i32();
    amount_4 = _e611;
    let _e619 = amount_4;
    copy_4 = _e619;
    let _e621 = state;
    old_4 = _e621;
    let _e623 = copy_4;
    let _e624 = state;
    state = (_e624 + _e623);
    let _e626 = state;
    let _e628 = output;
    local_40 = _e628;
    local_41 = u32((base + 17u));
    let _e634 = local_40;
    local_114 = _e634;
    let _e636 = local_41;
    let _e638 = local_114[1];
    local_114[1] = (_e638 + _e636);
    let _e642 = local_114[0];
    local_115 = u32(_e642);
    let _e646 = local_114[1];
    local_116 = u32(_e646);
    let _e649 = local_116;
    output_1[_e649] = u32(_e626);
    let _e651 = index;
    let _e653 = output;
    local_42 = _e653;
    local_43 = u32((base + 18u));
    let _e659 = local_42;
    local_117 = _e659;
    let _e661 = local_43;
    let _e663 = local_117[1];
    local_117[1] = (_e663 + _e661);
    let _e667 = local_117[0];
    local_118 = u32(_e667);
    let _e671 = local_117[1];
    local_119 = u32(_e671);
    let _e674 = local_119;
    output_1[_e674] = u32(_e651);
    let _e677 = merged_unsigned_unsigned(1u);
    let _e678 = kind_1(_e677);
    let _e680 = output;
    local_44 = _e680;
    local_45 = u32((base + 19u));
    let _e686 = local_44;
    local_120 = _e686;
    let _e688 = local_45;
    let _e690 = local_120[1];
    local_120[1] = (_e690 + _e688);
    let _e694 = local_120[0];
    local_121 = u32(_e694);
    let _e698 = local_120[1];
    local_122 = u32(_e698);
    let _e701 = local_122;
    output_1[_e701] = u32(_e678);
}
