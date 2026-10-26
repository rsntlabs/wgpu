struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn choose(value: vec2<i32>) -> i32 {
    var value_1: vec2<i32>;

    value_1 = value;
    let _e4 = value_1.x;
    let _e7 = value_1.y;
    return ((_e4 * 10i) + _e7);
}

fn choose_1(value_2: uint3_) -> i32 {
    var value_3: uint3_;

    value_3 = value_2;
    let _e3 = value_3.z;
    return i32(_e3);
}

fn choose_2(value_4: vec4<f32>) -> i32 {
    var value_5: vec4<f32>;

    value_5 = value_4;
    let _e3 = value_5.w;
    return i32(_e3);
}

fn bump(value_6: int3_) -> int3_ {
    var value_7: int3_;

    value_7 = value_6;
    let _e4 = value_7.y;
    value_7.y = (_e4 + 1i);
    let _e6 = value_7;
    return _e6;
}

fn shift(value_8: float3_) -> float3_ {
    var value_9: float3_;

    value_9 = value_8;
    let _e4 = value_9.x;
    value_9.x = (_e4 + 2f);
    let _e9 = value_9.x;
    let _e10 = value_9.y;
    value_9.z = (_e9 + _e10);
    let _e12 = value_9;
    return _e12;
}

fn pair(first: float3_, second: i32) -> i32 {
    var first_1: float3_;
    var second_1: i32;

    first_1 = first;
    second_1 = second;
    let _e5 = first_1.x;
    let _e9 = second_1;
    return ((i32(_e5) * 10i) + _e9);
}

@compute @workgroup_size(1, 1, 1)
fn vector_values() {
    var local: u32;
    var seed: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var f2_: vec2<f32>;
    var f3_: float3_;
    var f4_: vec4<f32>;
    var i2_: vec2<i32>;
    var i3_: int3_;
    var i4_: vec4<i32>;
    var u2_: vec2<u32>;
    var u3_: uint3_;
    var u4_: vec4<u32>;
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
    var frozen: float3_;
    var copied: float3_;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var changed: int3_;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var samples: array<float3_, 2>;
    var index: i32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var choose_first: bool;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: f32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: f32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: float3_;
    var local_64: i32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var argument: i32;
    var captured: int3_;
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
    var local_81: i32;
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

    local = 0u;
    let _e2 = local;
    local_1 = _e2;
    let _e4 = local_1;
    local_2 = u32(_e4);
    local_3 = u32(0i);
    let _e11 = local_2;
    let _e12 = local_3;
    local_80 = u32((_e11 + _e12));
    let _e17 = local_80;
    let _e19 = out[_e17];
    local_81 = _e19;
    let _e20 = local_81;
    seed = _e20;
    let _e22 = seed;
    f2_ = vec2<f32>(f32(_e22), 1.5f);
    f3_ = float3_(1f, 2f, 3f);
    f4_ = vec4<f32>(f32(1i), f32(2i), f32(3i), f32(4i));
    let _e42 = seed;
    i2_ = vec2<i32>(_e42, -(2i));
    i3_ = int3_(1i, 2i, 3i);
    i4_ = vec4<i32>(1i, 2i, 3i, 4i);
    u2_ = vec2<u32>(u32(-(1i)), u32(2i));
    u3_ = uint3_(u32(1i), u32(2i), u32(3i));
    u4_ = vec4<u32>(u32(1i), u32(2i), u32(3i), u32(4i));
    let _e85 = f2_.x;
    let _e86 = f2_.y;
    let _e89 = local;
    local_4 = _e89;
    let _e91 = local_4;
    local_5 = u32(_e91);
    local_6 = u32(0i);
    let _e97 = local_5;
    let _e98 = local_6;
    local_82 = u32((_e97 + _e98));
    let _e102 = local_82;
    out[_e102] = i32((_e85 + _e86));
    let _e106 = f3_.x;
    let _e107 = f3_.y;
    let _e110 = f3_.z;
    let _e113 = local;
    local_7 = _e113;
    let _e115 = local_7;
    local_8 = u32(_e115);
    local_9 = u32(1i);
    let _e121 = local_8;
    let _e122 = local_9;
    local_83 = u32((_e121 + _e122));
    let _e126 = local_83;
    out[_e126] = i32(((_e106 + _e107) + _e110));
    let _e129 = f4_.w;
    let _e131 = local;
    local_10 = _e131;
    let _e133 = local_10;
    local_11 = u32(_e133);
    local_12 = u32(2i);
    let _e139 = local_11;
    let _e140 = local_12;
    local_84 = u32((_e139 + _e140));
    let _e144 = local_84;
    out[_e144] = i32(_e129);
    let _e148 = i2_.x;
    let _e149 = i2_.y;
    let _e151 = local;
    local_13 = _e151;
    let _e153 = local_13;
    local_14 = u32(_e153);
    local_15 = u32(3i);
    let _e159 = local_14;
    let _e160 = local_15;
    local_85 = u32((_e159 + _e160));
    let _e164 = local_85;
    out[_e164] = (_e148 + _e149);
    let _e167 = i3_.z;
    let _e168 = local;
    local_16 = _e168;
    let _e170 = local_16;
    local_17 = u32(_e170);
    local_18 = u32(4i);
    let _e176 = local_17;
    let _e177 = local_18;
    local_86 = u32((_e176 + _e177));
    let _e181 = local_86;
    out[_e181] = _e167;
    let _e185 = i4_.x;
    let _e186 = i4_.w;
    let _e188 = local;
    local_19 = _e188;
    let _e190 = local_19;
    local_20 = u32(_e190);
    local_21 = u32(5i);
    let _e196 = local_20;
    let _e197 = local_21;
    local_87 = u32((_e196 + _e197));
    let _e201 = local_87;
    out[_e201] = (_e185 + _e186);
    let _e204 = u2_.x;
    let _e207 = local;
    local_22 = _e207;
    let _e209 = local_22;
    local_23 = u32(_e209);
    local_24 = u32(6i);
    let _e216 = local_23;
    let _e217 = local_24;
    local_88 = u32((_e216 + _e217));
    let _e221 = local_88;
    out[_e221] = i32((_e204 == 4294967295u));
    let _e225 = u3_.x;
    let _e226 = u3_.z;
    let _e229 = local;
    local_25 = _e229;
    let _e231 = local_25;
    local_26 = u32(_e231);
    local_27 = u32(7i);
    let _e237 = local_26;
    let _e238 = local_27;
    local_89 = u32((_e237 + _e238));
    let _e242 = local_89;
    out[_e242] = i32((_e225 + _e226));
    let _e245 = u4_.w;
    let _e247 = local;
    local_28 = _e247;
    let _e249 = local_28;
    local_29 = u32(_e249);
    local_30 = u32(8i);
    let _e255 = local_29;
    let _e256 = local_30;
    local_90 = u32((_e255 + _e256));
    let _e260 = local_90;
    out[_e260] = i32(_e245);
    let _e262 = f3_;
    frozen = _e262;
    let _e264 = frozen;
    copied = _e264;
    copied.x = 9f;
    let _e269 = frozen.x;
    let _e273 = copied.x;
    let _e276 = local;
    local_31 = _e276;
    let _e278 = local_31;
    local_32 = u32(_e278);
    local_33 = u32(9i);
    let _e284 = local_32;
    let _e285 = local_33;
    local_91 = u32((_e284 + _e285));
    let _e289 = local_91;
    out[_e289] = i32(((_e269 * 10f) + _e273));
    let _e291 = i3_;
    let _e292 = bump(_e291);
    changed = _e292;
    let _e295 = changed.y;
    let _e299 = i3_.y;
    let _e301 = local;
    local_34 = _e301;
    let _e303 = local_34;
    local_35 = u32(_e303);
    local_36 = u32(10i);
    let _e309 = local_35;
    let _e310 = local_36;
    local_92 = u32((_e309 + _e310));
    let _e314 = local_92;
    out[_e314] = ((_e295 * 10i) + _e299);
    let _e316 = f3_;
    let _e317 = shift(_e316);
    let _e320 = local;
    local_37 = _e320;
    let _e322 = local_37;
    local_38 = u32(_e322);
    local_39 = u32(11i);
    let _e328 = local_38;
    let _e329 = local_39;
    local_93 = u32((_e328 + _e329));
    let _e333 = local_93;
    out[_e333] = i32(_e317.z);
    let _e335 = i2_;
    let _e336 = choose(_e335);
    let _e337 = u3_;
    let _e338 = choose_1(_e337);
    let _e340 = f4_;
    let _e341 = choose_2(_e340);
    let _e343 = local;
    local_40 = _e343;
    let _e345 = local_40;
    local_41 = u32(_e345);
    local_42 = u32(12i);
    let _e351 = local_41;
    let _e352 = local_42;
    local_94 = u32((_e351 + _e352));
    let _e356 = local_94;
    out[_e356] = ((_e336 + _e338) + _e341);
    let _e358 = f3_;
    samples[0i] = _e358;
    samples[1i] = float3_(f32(5i), f32(6i), f32(7i));
    index = 0i;
    let _e373 = index;
    index = (_e373 + 1i);
    let _e376 = index;
    let _e377 = index;
    index = (_e377 + 1i);
    let _e382 = samples[_e377].x;
    samples[_e377].x = (_e382 + f32(_e376));
    let _e385 = samples[_e377].x;
    let _e387 = local;
    local_43 = _e387;
    let _e389 = local_43;
    local_44 = u32(_e389);
    local_45 = u32(13i);
    let _e395 = local_44;
    let _e396 = local_45;
    local_95 = u32((_e395 + _e396));
    let _e400 = local_95;
    out[_e400] = i32(_e385);
    let _e402 = index;
    let _e408 = samples[0i].x;
    let _e416 = samples[1i].x;
    let _e419 = local;
    local_46 = _e419;
    let _e421 = local_46;
    local_47 = u32(_e421);
    local_48 = u32(14i);
    let _e427 = local_47;
    let _e428 = local_48;
    local_96 = u32((_e427 + _e428));
    let _e432 = local_96;
    out[_e432] = (((_e402 * 100i) + (i32(_e408) * 10i)) + i32(_e416));
    choose_first = false;
    let _e436 = choose_first;
    if _e436 {
        let _e440 = samples[0i].y;
        samples[0i].y = (_e440 + f32(1i));
        local_52 = _e440;
    } else {
        let _e448 = samples[1i].y;
        samples[1i].y = (_e448 + f32(1i));
        local_52 = _e448;
    }
    let _e454 = local_52;
    let _e456 = local;
    local_49 = _e456;
    let _e458 = local_49;
    local_50 = u32(_e458);
    local_51 = u32(15i);
    let _e464 = local_50;
    let _e465 = local_51;
    local_97 = u32((_e464 + _e465));
    let _e469 = local_97;
    out[_e469] = i32(_e454);
    let _e474 = samples[1i].y;
    let _e476 = local;
    local_53 = _e476;
    let _e478 = local_53;
    local_54 = u32(_e478);
    local_55 = u32(16i);
    let _e484 = local_54;
    let _e485 = local_55;
    local_98 = u32((_e484 + _e485));
    let _e489 = local_98;
    out[_e489] = i32(_e474);
    let _e491 = f3_;
    let _e492 = choose_first;
    if _e492 {
        samples[0i] = _e491;
        let _e496 = samples[0i].z;
        local_59 = _e496;
    } else {
        samples[1i] = _e491;
        let _e501 = samples[1i].z;
        local_59 = _e501;
    }
    let _e504 = local_59;
    let _e506 = local;
    local_56 = _e506;
    let _e508 = local_56;
    local_57 = u32(_e508);
    local_58 = u32(17i);
    let _e514 = local_57;
    let _e515 = local_58;
    local_99 = u32((_e514 + _e515));
    let _e519 = local_99;
    out[_e519] = i32(_e504);
    if true {
        local_63 = float3_(f32(7i), f32(8i), f32(9i));
    } else {
        let _e530 = f3_;
        local_63 = _e530;
    }
    let _e533 = local_63;
    let _e536 = local;
    local_60 = _e536;
    let _e538 = local_60;
    local_61 = u32(_e538);
    local_62 = u32(18i);
    let _e544 = local_61;
    let _e545 = local_62;
    local_100 = u32((_e544 + _e545));
    let _e549 = local_100;
    out[_e549] = i32(_e533.y);
    {
        let _e551 = seed;
        local_64 = (_e551 + 2i);
        let _e555 = local_64;
        let _e556 = local;
        local_65 = _e556;
        let _e558 = local_65;
        local_66 = u32(_e558);
        local_67 = u32(19i);
        let _e564 = local_66;
        let _e565 = local_67;
        local_101 = u32((_e564 + _e565));
        let _e569 = local_101;
        out[_e569] = _e555;
    }
    argument = 3i;
    let _e573 = argument;
    let _e574 = argument;
    argument = (_e574 + 1i);
    let _e577 = argument;
    captured = int3_(_e573, _e574, _e577);
    let _e581 = captured.x;
    let _e585 = captured.y;
    let _e590 = captured.z;
    let _e592 = local;
    local_68 = _e592;
    let _e594 = local_68;
    local_69 = u32(_e594);
    local_70 = u32(20i);
    let _e600 = local_69;
    let _e601 = local_70;
    local_102 = u32((_e600 + _e601));
    let _e605 = local_102;
    out[_e605] = (((_e581 * 100i) + (_e585 * 10i)) + _e590);
    let _e607 = argument;
    let _e608 = local;
    local_71 = _e608;
    let _e610 = local_71;
    local_72 = u32(_e610);
    local_73 = u32(21i);
    let _e616 = local_72;
    let _e617 = local_73;
    local_103 = u32((_e616 + _e617));
    let _e621 = local_103;
    out[_e621] = _e607;
    let _e623 = f3_;
    f3_.x = 9f;
    let _e627 = pair(_e623, 4i);
    let _e628 = local;
    local_74 = _e628;
    let _e630 = local_74;
    local_75 = u32(_e630);
    local_76 = u32(22i);
    let _e636 = local_75;
    let _e637 = local_76;
    local_104 = u32((_e636 + _e637));
    let _e641 = local_104;
    out[_e641] = _e627;
    let _e644 = f3_.x;
    let _e646 = local;
    local_77 = _e646;
    let _e648 = local_77;
    local_78 = u32(_e648);
    local_79 = u32(23i);
    let _e654 = local_78;
    let _e655 = local_79;
    local_105 = u32((_e654 + _e655));
    let _e659 = local_105;
    out[_e659] = i32(_e644);
}
