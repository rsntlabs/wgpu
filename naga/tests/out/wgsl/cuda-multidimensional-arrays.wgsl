struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
var<workgroup> shared_values: array<array<i32, 3>, 2>;
var<workgroup> shared_points: array<array<float3_, 2>, 2>;

@compute @workgroup_size(1, 1, 1)
fn multidimensional_arrays() {
    var local: u32;
    var original: vec2<i32>;
    var points: array<array<vec2<i32>, 2>, 2>;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var original_1: int3_;
    var points_1: array<array<int3_, 2>, 2>;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var original_2: vec4<i32>;
    var points_2: array<array<vec4<i32>, 2>, 2>;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var original_3: vec2<u32>;
    var points_3: array<array<vec2<u32>, 2>, 2>;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var original_4: uint3_;
    var points_4: array<array<uint3_, 2>, 2>;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var original_5: vec4<u32>;
    var points_5: array<array<vec4<u32>, 2>, 2>;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var original_6: vec2<f32>;
    var points_6: array<array<vec2<f32>, 2>, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var original_7: float3_;
    var points_7: array<array<float3_, 2>, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var original_8: vec4<f32>;
    var points_8: array<array<vec4<f32>, 2>, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var changed: array<array<i32, 2>, 2>;
    var local_82: u32;
    var nested_empty: array<array<i32, 3>, 2>;
    var local_83: u32;
    var local_84: u32;
    var partial: array<array<i32, 3>, 2>;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;
    var volume: array<array<array<i32, 3>, 2>, 2>;
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

    local = 0u;
    {
        original.x = 1i;
        original.y = 2i;
        let _e10 = original;
        points[0][0] = _e10;
        points[0][1] = vec2<i32>();
        let _e15 = original;
        points[1][0] = _e15;
        points[1][1].x = 5i;
        points[1][1].y = i32();
        let _e26 = points[0i][0i].y;
        let _e27 = local;
        local_1 = _e27;
        let _e29 = local_1;
        local_2 = u32(_e29);
        local_3 = u32(0i);
        let _e36 = local_2;
        let _e37 = local_3;
        local_103 = u32((_e36 + _e37));
        let _e41 = local_103;
        out[_e41] = _e26;
        let _e48 = points[1i][1i].x;
        let _e49 = local;
        local_4 = _e49;
        let _e51 = local_4;
        local_5 = u32(_e51);
        local_6 = u32(1i);
        let _e57 = local_5;
        let _e58 = local_6;
        local_104 = u32((_e57 + _e58));
        let _e62 = local_104;
        out[_e62] = _e48;
        let _e69 = points[1i][1i].y;
        let _e70 = local;
        local_7 = _e70;
        let _e72 = local_7;
        local_8 = u32(_e72);
        local_9 = u32(2i);
        let _e78 = local_8;
        let _e79 = local_9;
        local_105 = u32((_e78 + _e79));
        let _e83 = local_105;
        out[_e83] = _e69;
    }
    {
        original_1.x = 1i;
        original_1.y = 2i;
        original_1.z = 3i;
        let _e95 = original_1;
        points_1[0][0] = _e95;
        points_1[0][1] = int3_();
        let _e100 = original_1;
        points_1[1][0] = _e100;
        points_1[1][1].x = 5i;
        points_1[1][1].y = i32();
        points_1[1][1].z = i32();
        let _e113 = points_1[0i][0i].z;
        let _e114 = local;
        local_10 = _e114;
        let _e116 = local_10;
        local_11 = u32(_e116);
        local_12 = u32(3i);
        let _e122 = local_11;
        let _e123 = local_12;
        local_106 = u32((_e122 + _e123));
        let _e127 = local_106;
        out[_e127] = _e113;
        let _e134 = points_1[1i][1i].x;
        let _e135 = local;
        local_13 = _e135;
        let _e137 = local_13;
        local_14 = u32(_e137);
        local_15 = u32(4i);
        let _e143 = local_14;
        let _e144 = local_15;
        local_107 = u32((_e143 + _e144));
        let _e148 = local_107;
        out[_e148] = _e134;
        let _e155 = points_1[1i][1i].z;
        let _e156 = local;
        local_16 = _e156;
        let _e158 = local_16;
        local_17 = u32(_e158);
        local_18 = u32(5i);
        let _e164 = local_17;
        let _e165 = local_18;
        local_108 = u32((_e164 + _e165));
        let _e169 = local_108;
        out[_e169] = _e155;
    }
    {
        original_2.x = 1i;
        original_2.y = 2i;
        original_2.z = 3i;
        original_2.w = 4i;
        let _e183 = original_2;
        points_2[0][0] = _e183;
        points_2[0][1] = vec4<i32>();
        let _e188 = original_2;
        points_2[1][0] = _e188;
        points_2[1][1].x = 5i;
        points_2[1][1].y = i32();
        points_2[1][1].z = i32();
        points_2[1][1].w = i32();
        let _e203 = points_2[0i][0i].w;
        let _e204 = local;
        local_19 = _e204;
        let _e206 = local_19;
        local_20 = u32(_e206);
        local_21 = u32(6i);
        let _e212 = local_20;
        let _e213 = local_21;
        local_109 = u32((_e212 + _e213));
        let _e217 = local_109;
        out[_e217] = _e203;
        let _e224 = points_2[1i][1i].x;
        let _e225 = local;
        local_22 = _e225;
        let _e227 = local_22;
        local_23 = u32(_e227);
        local_24 = u32(7i);
        let _e233 = local_23;
        let _e234 = local_24;
        local_110 = u32((_e233 + _e234));
        let _e238 = local_110;
        out[_e238] = _e224;
        let _e245 = points_2[1i][1i].w;
        let _e246 = local;
        local_25 = _e246;
        let _e248 = local_25;
        local_26 = u32(_e248);
        local_27 = u32(8i);
        let _e254 = local_26;
        let _e255 = local_27;
        local_111 = u32((_e254 + _e255));
        let _e259 = local_111;
        out[_e259] = _e245;
    }
    {
        original_3.x = u32(1i);
        original_3.y = u32(2i);
        let _e271 = original_3;
        points_3[0][0] = _e271;
        points_3[0][1] = vec2<u32>();
        let _e276 = original_3;
        points_3[1][0] = _e276;
        points_3[1][1].x = u32(5i);
        points_3[1][1].y = u32();
        let _e288 = points_3[0i][0i].y;
        let _e290 = local;
        local_28 = _e290;
        let _e292 = local_28;
        local_29 = u32(_e292);
        local_30 = u32(9i);
        let _e298 = local_29;
        let _e299 = local_30;
        local_112 = u32((_e298 + _e299));
        let _e303 = local_112;
        out[_e303] = i32(_e288);
        let _e310 = points_3[1i][1i].x;
        let _e312 = local;
        local_31 = _e312;
        let _e314 = local_31;
        local_32 = u32(_e314);
        local_33 = u32(10i);
        let _e320 = local_32;
        let _e321 = local_33;
        local_113 = u32((_e320 + _e321));
        let _e325 = local_113;
        out[_e325] = i32(_e310);
        let _e332 = points_3[1i][1i].y;
        let _e334 = local;
        local_34 = _e334;
        let _e336 = local_34;
        local_35 = u32(_e336);
        local_36 = u32(11i);
        let _e342 = local_35;
        let _e343 = local_36;
        local_114 = u32((_e342 + _e343));
        let _e347 = local_114;
        out[_e347] = i32(_e332);
    }
    {
        original_4.x = u32(1i);
        original_4.y = u32(2i);
        original_4.z = u32(3i);
        let _e362 = original_4;
        points_4[0][0] = _e362;
        points_4[0][1] = uint3_();
        let _e367 = original_4;
        points_4[1][0] = _e367;
        points_4[1][1].x = u32(5i);
        points_4[1][1].y = u32();
        points_4[1][1].z = u32();
        let _e381 = points_4[0i][0i].z;
        let _e383 = local;
        local_37 = _e383;
        let _e385 = local_37;
        local_38 = u32(_e385);
        local_39 = u32(12i);
        let _e391 = local_38;
        let _e392 = local_39;
        local_115 = u32((_e391 + _e392));
        let _e396 = local_115;
        out[_e396] = i32(_e381);
        let _e403 = points_4[1i][1i].x;
        let _e405 = local;
        local_40 = _e405;
        let _e407 = local_40;
        local_41 = u32(_e407);
        local_42 = u32(13i);
        let _e413 = local_41;
        let _e414 = local_42;
        local_116 = u32((_e413 + _e414));
        let _e418 = local_116;
        out[_e418] = i32(_e403);
        let _e425 = points_4[1i][1i].z;
        let _e427 = local;
        local_43 = _e427;
        let _e429 = local_43;
        local_44 = u32(_e429);
        local_45 = u32(14i);
        let _e435 = local_44;
        let _e436 = local_45;
        local_117 = u32((_e435 + _e436));
        let _e440 = local_117;
        out[_e440] = i32(_e425);
    }
    {
        original_5.x = u32(1i);
        original_5.y = u32(2i);
        original_5.z = u32(3i);
        original_5.w = u32(4i);
        let _e458 = original_5;
        points_5[0][0] = _e458;
        points_5[0][1] = vec4<u32>();
        let _e463 = original_5;
        points_5[1][0] = _e463;
        points_5[1][1].x = u32(5i);
        points_5[1][1].y = u32();
        points_5[1][1].z = u32();
        points_5[1][1].w = u32();
        let _e479 = points_5[0i][0i].w;
        let _e481 = local;
        local_46 = _e481;
        let _e483 = local_46;
        local_47 = u32(_e483);
        local_48 = u32(15i);
        let _e489 = local_47;
        let _e490 = local_48;
        local_118 = u32((_e489 + _e490));
        let _e494 = local_118;
        out[_e494] = i32(_e479);
        let _e501 = points_5[1i][1i].x;
        let _e503 = local;
        local_49 = _e503;
        let _e505 = local_49;
        local_50 = u32(_e505);
        local_51 = u32(16i);
        let _e511 = local_50;
        let _e512 = local_51;
        local_119 = u32((_e511 + _e512));
        let _e516 = local_119;
        out[_e516] = i32(_e501);
        let _e523 = points_5[1i][1i].w;
        let _e525 = local;
        local_52 = _e525;
        let _e527 = local_52;
        local_53 = u32(_e527);
        local_54 = u32(17i);
        let _e533 = local_53;
        let _e534 = local_54;
        local_120 = u32((_e533 + _e534));
        let _e538 = local_120;
        out[_e538] = i32(_e523);
    }
    {
        original_6.x = f32(1i);
        original_6.y = f32(2i);
        let _e550 = original_6;
        points_6[0][0] = _e550;
        points_6[0][1] = vec2<f32>();
        let _e555 = original_6;
        points_6[1][0] = _e555;
        points_6[1][1].x = f32(5i);
        points_6[1][1].y = f32();
        let _e567 = points_6[0i][0i].y;
        let _e569 = local;
        local_55 = _e569;
        let _e571 = local_55;
        local_56 = u32(_e571);
        local_57 = u32(18i);
        let _e577 = local_56;
        let _e578 = local_57;
        local_121 = u32((_e577 + _e578));
        let _e582 = local_121;
        out[_e582] = i32(_e567);
        let _e589 = points_6[1i][1i].x;
        let _e591 = local;
        local_58 = _e591;
        let _e593 = local_58;
        local_59 = u32(_e593);
        local_60 = u32(19i);
        let _e599 = local_59;
        let _e600 = local_60;
        local_122 = u32((_e599 + _e600));
        let _e604 = local_122;
        out[_e604] = i32(_e589);
        let _e611 = points_6[1i][1i].y;
        let _e613 = local;
        local_61 = _e613;
        let _e615 = local_61;
        local_62 = u32(_e615);
        local_63 = u32(20i);
        let _e621 = local_62;
        let _e622 = local_63;
        local_123 = u32((_e621 + _e622));
        let _e626 = local_123;
        out[_e626] = i32(_e611);
    }
    {
        original_7.x = f32(1i);
        original_7.y = f32(2i);
        original_7.z = f32(3i);
        let _e641 = original_7;
        points_7[0][0] = _e641;
        points_7[0][1] = float3_();
        let _e646 = original_7;
        points_7[1][0] = _e646;
        points_7[1][1].x = f32(5i);
        points_7[1][1].y = f32();
        points_7[1][1].z = f32();
        let _e660 = points_7[0i][0i].z;
        let _e662 = local;
        local_64 = _e662;
        let _e664 = local_64;
        local_65 = u32(_e664);
        local_66 = u32(21i);
        let _e670 = local_65;
        let _e671 = local_66;
        local_124 = u32((_e670 + _e671));
        let _e675 = local_124;
        out[_e675] = i32(_e660);
        let _e682 = points_7[1i][1i].x;
        let _e684 = local;
        local_67 = _e684;
        let _e686 = local_67;
        local_68 = u32(_e686);
        local_69 = u32(22i);
        let _e692 = local_68;
        let _e693 = local_69;
        local_125 = u32((_e692 + _e693));
        let _e697 = local_125;
        out[_e697] = i32(_e682);
        let _e704 = points_7[1i][1i].z;
        let _e706 = local;
        local_70 = _e706;
        let _e708 = local_70;
        local_71 = u32(_e708);
        local_72 = u32(23i);
        let _e714 = local_71;
        let _e715 = local_72;
        local_126 = u32((_e714 + _e715));
        let _e719 = local_126;
        out[_e719] = i32(_e704);
    }
    {
        original_8.x = f32(1i);
        original_8.y = f32(2i);
        original_8.z = f32(3i);
        original_8.w = f32(4i);
        let _e737 = original_8;
        points_8[0][0] = _e737;
        points_8[0][1] = vec4<f32>();
        let _e742 = original_8;
        points_8[1][0] = _e742;
        points_8[1][1].x = f32(5i);
        points_8[1][1].y = f32();
        points_8[1][1].z = f32();
        points_8[1][1].w = f32();
        let _e758 = points_8[0i][0i].w;
        let _e760 = local;
        local_73 = _e760;
        let _e762 = local_73;
        local_74 = u32(_e762);
        local_75 = u32(24i);
        let _e768 = local_74;
        let _e769 = local_75;
        local_127 = u32((_e768 + _e769));
        let _e773 = local_127;
        out[_e773] = i32(_e758);
        let _e780 = points_8[1i][1i].x;
        let _e782 = local;
        local_76 = _e782;
        let _e784 = local_76;
        local_77 = u32(_e784);
        local_78 = u32(25i);
        let _e790 = local_77;
        let _e791 = local_78;
        local_128 = u32((_e790 + _e791));
        let _e795 = local_128;
        out[_e795] = i32(_e780);
        let _e802 = points_8[1i][1i].w;
        let _e804 = local;
        local_79 = _e804;
        let _e806 = local_79;
        local_80 = u32(_e806);
        local_81 = u32(26i);
        let _e812 = local_80;
        let _e813 = local_81;
        local_129 = u32((_e812 + _e813));
        let _e817 = local_129;
        out[_e817] = i32(_e802);
    }
    changed[0][0] = 1i;
    local_82 = 1u;
    loop {
        let _e825 = local_82;
        if (_e825 >= 2u) {
            break;
        }
        changed[0][_e825] = i32();
        continuing {
            let _e830 = local_82;
            local_82 = (_e830 + 1u);
        }
    }
    changed[0i][1i] = 9i;
    changed[1][0] = 2i;
    changed[1][1] = 3i;
    local_83 = 0u;
    loop {
        let _e845 = local_83;
        if (_e845 >= 2u) {
            break;
        }
        local_84 = 0u;
        loop {
            let _e852 = local_84;
            if (_e852 >= 3u) {
                break;
            }
            nested_empty[_e845][_e852] = i32();
            continuing {
                let _e857 = local_84;
                local_84 = (_e857 + 1u);
            }
        }
        continuing {
            let _e860 = local_83;
            local_83 = (_e860 + 1u);
        }
    }
    partial[0][0] = 1i;
    local_85 = 1u;
    loop {
        let _e869 = local_85;
        if (_e869 >= 3u) {
            break;
        }
        partial[0][_e869] = i32();
        continuing {
            let _e874 = local_85;
            local_85 = (_e874 + 1u);
        }
    }
    local_86 = 1u;
    loop {
        let _e879 = local_86;
        if (_e879 >= 2u) {
            break;
        }
        local_87 = 0u;
        loop {
            let _e885 = local_87;
            if (_e885 >= 3u) {
                break;
            }
            partial[_e879][_e885] = i32();
            continuing {
                let _e890 = local_87;
                local_87 = (_e890 + 1u);
            }
        }
        continuing {
            let _e893 = local_86;
            local_86 = (_e893 + 1u);
        }
    }
    volume[0][0][0] = 1i;
    local_88 = 1u;
    loop {
        let _e903 = local_88;
        if (_e903 >= 3u) {
            break;
        }
        volume[0][0][_e903] = i32();
        continuing {
            let _e908 = local_88;
            local_88 = (_e908 + 1u);
        }
    }
    local_89 = 1u;
    loop {
        let _e913 = local_89;
        if (_e913 >= 2u) {
            break;
        }
        local_90 = 0u;
        loop {
            let _e919 = local_90;
            if (_e919 >= 3u) {
                break;
            }
            volume[0][_e913][_e919] = i32();
            continuing {
                let _e924 = local_90;
                local_90 = (_e924 + 1u);
            }
        }
        continuing {
            let _e927 = local_89;
            local_89 = (_e927 + 1u);
        }
    }
    local_91 = 1u;
    loop {
        let _e932 = local_91;
        if (_e932 >= 2u) {
            break;
        }
        local_92 = 0u;
        loop {
            let _e938 = local_92;
            if (_e938 >= 2u) {
                break;
            }
            local_93 = 0u;
            loop {
                let _e944 = local_93;
                if (_e944 >= 3u) {
                    break;
                }
                volume[_e932][_e938][_e944] = i32();
                continuing {
                    let _e949 = local_93;
                    local_93 = (_e949 + 1u);
                }
            }
            continuing {
                let _e952 = local_92;
                local_92 = (_e952 + 1u);
            }
        }
        continuing {
            let _e955 = local_91;
            local_91 = (_e955 + 1u);
        }
    }
    let _e962 = changed[0i][1i];
    shared_values[1i][2i] = _e962;
    let _e972 = changed[1i][0i];
    let _e977 = changed[1i][1i];
    shared_points[1i][0i] = float3_(f32(_e972), f32(_e977), f32(4i));
    storageBarrier();
    workgroupBarrier();
    let _e997 = shared_values[1i][2i];
    let _e998 = nested_empty[1i][2i];
    let _e1004 = partial[1i][2i];
    let _e1012 = volume[1i][1i][2i];
    let _e1014 = local;
    local_94 = _e1014;
    let _e1016 = local_94;
    local_95 = u32(_e1016);
    local_96 = u32(27i);
    let _e1022 = local_95;
    let _e1023 = local_96;
    local_130 = u32((_e1022 + _e1023));
    let _e1027 = local_130;
    out[_e1027] = (((_e997 + _e998) + _e1004) + _e1012);
    let _e1034 = shared_points[1i][0i].x;
    let _e1036 = local;
    local_97 = _e1036;
    let _e1038 = local_97;
    local_98 = u32(_e1038);
    local_99 = u32(28i);
    let _e1044 = local_98;
    let _e1045 = local_99;
    local_131 = u32((_e1044 + _e1045));
    let _e1049 = local_131;
    out[_e1049] = i32(_e1034);
    let _e1056 = shared_points[1i][0i].y;
    let _e1058 = local;
    local_100 = _e1058;
    let _e1060 = local_100;
    local_101 = u32(_e1060);
    local_102 = u32(29i);
    let _e1066 = local_101;
    let _e1067 = local_102;
    local_132 = u32((_e1066 + _e1067));
    let _e1071 = local_132;
    out[_e1071] = i32(_e1056);
}
