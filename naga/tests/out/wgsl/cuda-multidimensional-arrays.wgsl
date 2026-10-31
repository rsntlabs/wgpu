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
var<storage, read_write> out_1: array<i32>;
var<workgroup> shared_values: array<array<i32, 3>, 2>;
var<workgroup> shared_points: array<array<float3_, 2>, 2>;

@compute @workgroup_size(1, 1, 1)
fn multidimensional_arrays() {
    var out: array<u32, 2>;
    var original: vec2<i32>;
    var points: array<array<vec2<i32>, 2>, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var original_1: int3_;
    var points_1: array<array<int3_, 2>, 2>;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var original_2: vec4<i32>;
    var points_2: array<array<vec4<i32>, 2>, 2>;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var original_3: vec2<u32>;
    var points_3: array<array<vec2<u32>, 2>, 2>;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var original_4: uint3_;
    var points_4: array<array<uint3_, 2>, 2>;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var original_5: vec4<u32>;
    var points_5: array<array<vec4<u32>, 2>, 2>;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var original_6: vec2<f32>;
    var points_6: array<array<vec2<f32>, 2>, 2>;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var original_7: float3_;
    var points_7: array<array<float3_, 2>, 2>;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var original_8: vec4<f32>;
    var points_8: array<array<vec4<f32>, 2>, 2>;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var changed: array<array<i32, 2>, 2>;
    var local_54: u32;
    var nested_empty: array<array<i32, 3>, 2>;
    var local_55: u32;
    var local_56: u32;
    var partial: array<array<i32, 3>, 2>;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var volume: array<array<array<i32, 3>, 2>, 2>;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: u32;
    var local_70: array<u32, 2>;
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
    var local_159: array<u32, 2>;
    var local_160: u32;
    var local_161: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    {
        original.x = 1i;
        original.y = 2i;
        let _e15 = original;
        points[0][0] = _e15;
        points[0][1] = vec2<i32>();
        let _e20 = original;
        points[1][0] = _e20;
        points[1][1].x = 5i;
        points[1][1].y = i32();
        let _e31 = points[0i][0i].y;
        let _e34 = out;
        local = _e34;
        local_1 = u32(0i);
        let _e39 = local;
        local_72 = _e39;
        let _e40 = local_1;
        let _e42 = local_72[1];
        local_72[1] = (_e42 + _e40);
        let _e46 = local_72[0];
        local_73 = u32(_e46);
        let _e50 = local_72[1];
        local_74 = u32(_e50);
        let _e53 = local_74;
        out_1[_e53] = _e31;
        let _e60 = points[1i][1i].x;
        let _e62 = out;
        local_2 = _e62;
        local_3 = u32(1i);
        let _e67 = local_2;
        local_75 = _e67;
        let _e68 = local_3;
        let _e70 = local_75[1];
        local_75[1] = (_e70 + _e68);
        let _e74 = local_75[0];
        local_76 = u32(_e74);
        let _e78 = local_75[1];
        local_77 = u32(_e78);
        let _e81 = local_77;
        out_1[_e81] = _e60;
        let _e88 = points[1i][1i].y;
        let _e90 = out;
        local_4 = _e90;
        local_5 = u32(2i);
        let _e95 = local_4;
        local_78 = _e95;
        let _e96 = local_5;
        let _e98 = local_78[1];
        local_78[1] = (_e98 + _e96);
        let _e102 = local_78[0];
        local_79 = u32(_e102);
        let _e106 = local_78[1];
        local_80 = u32(_e106);
        let _e109 = local_80;
        out_1[_e109] = _e88;
    }
    {
        original_1.x = 1i;
        original_1.y = 2i;
        original_1.z = 3i;
        let _e121 = original_1;
        points_1[0][0] = _e121;
        points_1[0][1] = int3_();
        let _e126 = original_1;
        points_1[1][0] = _e126;
        points_1[1][1].x = 5i;
        points_1[1][1].y = i32();
        points_1[1][1].z = i32();
        let _e139 = points_1[0i][0i].z;
        let _e141 = out;
        local_6 = _e141;
        local_7 = u32(3i);
        let _e146 = local_6;
        local_81 = _e146;
        let _e147 = local_7;
        let _e149 = local_81[1];
        local_81[1] = (_e149 + _e147);
        let _e153 = local_81[0];
        local_82 = u32(_e153);
        let _e157 = local_81[1];
        local_83 = u32(_e157);
        let _e160 = local_83;
        out_1[_e160] = _e139;
        let _e167 = points_1[1i][1i].x;
        let _e169 = out;
        local_8 = _e169;
        local_9 = u32(4i);
        let _e174 = local_8;
        local_84 = _e174;
        let _e175 = local_9;
        let _e177 = local_84[1];
        local_84[1] = (_e177 + _e175);
        let _e181 = local_84[0];
        local_85 = u32(_e181);
        let _e185 = local_84[1];
        local_86 = u32(_e185);
        let _e188 = local_86;
        out_1[_e188] = _e167;
        let _e195 = points_1[1i][1i].z;
        let _e197 = out;
        local_10 = _e197;
        local_11 = u32(5i);
        let _e202 = local_10;
        local_87 = _e202;
        let _e203 = local_11;
        let _e205 = local_87[1];
        local_87[1] = (_e205 + _e203);
        let _e209 = local_87[0];
        local_88 = u32(_e209);
        let _e213 = local_87[1];
        local_89 = u32(_e213);
        let _e216 = local_89;
        out_1[_e216] = _e195;
    }
    {
        original_2.x = 1i;
        original_2.y = 2i;
        original_2.z = 3i;
        original_2.w = 4i;
        let _e230 = original_2;
        points_2[0][0] = _e230;
        points_2[0][1] = vec4<i32>();
        let _e235 = original_2;
        points_2[1][0] = _e235;
        points_2[1][1].x = 5i;
        points_2[1][1].y = i32();
        points_2[1][1].z = i32();
        points_2[1][1].w = i32();
        let _e250 = points_2[0i][0i].w;
        let _e252 = out;
        local_12 = _e252;
        local_13 = u32(6i);
        let _e257 = local_12;
        local_90 = _e257;
        let _e258 = local_13;
        let _e260 = local_90[1];
        local_90[1] = (_e260 + _e258);
        let _e264 = local_90[0];
        local_91 = u32(_e264);
        let _e268 = local_90[1];
        local_92 = u32(_e268);
        let _e271 = local_92;
        out_1[_e271] = _e250;
        let _e278 = points_2[1i][1i].x;
        let _e280 = out;
        local_14 = _e280;
        local_15 = u32(7i);
        let _e285 = local_14;
        local_93 = _e285;
        let _e286 = local_15;
        let _e288 = local_93[1];
        local_93[1] = (_e288 + _e286);
        let _e292 = local_93[0];
        local_94 = u32(_e292);
        let _e296 = local_93[1];
        local_95 = u32(_e296);
        let _e299 = local_95;
        out_1[_e299] = _e278;
        let _e306 = points_2[1i][1i].w;
        let _e308 = out;
        local_16 = _e308;
        local_17 = u32(8i);
        let _e313 = local_16;
        local_96 = _e313;
        let _e314 = local_17;
        let _e316 = local_96[1];
        local_96[1] = (_e316 + _e314);
        let _e320 = local_96[0];
        local_97 = u32(_e320);
        let _e324 = local_96[1];
        local_98 = u32(_e324);
        let _e327 = local_98;
        out_1[_e327] = _e306;
    }
    {
        original_3.x = u32(1i);
        original_3.y = u32(2i);
        let _e339 = original_3;
        points_3[0][0] = _e339;
        points_3[0][1] = vec2<u32>();
        let _e344 = original_3;
        points_3[1][0] = _e344;
        points_3[1][1].x = u32(5i);
        points_3[1][1].y = u32();
        let _e356 = points_3[0i][0i].y;
        let _e359 = out;
        local_18 = _e359;
        local_19 = u32(9i);
        let _e364 = local_18;
        local_99 = _e364;
        let _e365 = local_19;
        let _e367 = local_99[1];
        local_99[1] = (_e367 + _e365);
        let _e371 = local_99[0];
        local_100 = u32(_e371);
        let _e375 = local_99[1];
        local_101 = u32(_e375);
        let _e378 = local_101;
        out_1[_e378] = i32(_e356);
        let _e385 = points_3[1i][1i].x;
        let _e388 = out;
        local_20 = _e388;
        local_21 = u32(10i);
        let _e393 = local_20;
        local_102 = _e393;
        let _e394 = local_21;
        let _e396 = local_102[1];
        local_102[1] = (_e396 + _e394);
        let _e400 = local_102[0];
        local_103 = u32(_e400);
        let _e404 = local_102[1];
        local_104 = u32(_e404);
        let _e407 = local_104;
        out_1[_e407] = i32(_e385);
        let _e414 = points_3[1i][1i].y;
        let _e417 = out;
        local_22 = _e417;
        local_23 = u32(11i);
        let _e422 = local_22;
        local_105 = _e422;
        let _e423 = local_23;
        let _e425 = local_105[1];
        local_105[1] = (_e425 + _e423);
        let _e429 = local_105[0];
        local_106 = u32(_e429);
        let _e433 = local_105[1];
        local_107 = u32(_e433);
        let _e436 = local_107;
        out_1[_e436] = i32(_e414);
    }
    {
        original_4.x = u32(1i);
        original_4.y = u32(2i);
        original_4.z = u32(3i);
        let _e451 = original_4;
        points_4[0][0] = _e451;
        points_4[0][1] = uint3_();
        let _e456 = original_4;
        points_4[1][0] = _e456;
        points_4[1][1].x = u32(5i);
        points_4[1][1].y = u32();
        points_4[1][1].z = u32();
        let _e470 = points_4[0i][0i].z;
        let _e473 = out;
        local_24 = _e473;
        local_25 = u32(12i);
        let _e478 = local_24;
        local_108 = _e478;
        let _e479 = local_25;
        let _e481 = local_108[1];
        local_108[1] = (_e481 + _e479);
        let _e485 = local_108[0];
        local_109 = u32(_e485);
        let _e489 = local_108[1];
        local_110 = u32(_e489);
        let _e492 = local_110;
        out_1[_e492] = i32(_e470);
        let _e499 = points_4[1i][1i].x;
        let _e502 = out;
        local_26 = _e502;
        local_27 = u32(13i);
        let _e507 = local_26;
        local_111 = _e507;
        let _e508 = local_27;
        let _e510 = local_111[1];
        local_111[1] = (_e510 + _e508);
        let _e514 = local_111[0];
        local_112 = u32(_e514);
        let _e518 = local_111[1];
        local_113 = u32(_e518);
        let _e521 = local_113;
        out_1[_e521] = i32(_e499);
        let _e528 = points_4[1i][1i].z;
        let _e531 = out;
        local_28 = _e531;
        local_29 = u32(14i);
        let _e536 = local_28;
        local_114 = _e536;
        let _e537 = local_29;
        let _e539 = local_114[1];
        local_114[1] = (_e539 + _e537);
        let _e543 = local_114[0];
        local_115 = u32(_e543);
        let _e547 = local_114[1];
        local_116 = u32(_e547);
        let _e550 = local_116;
        out_1[_e550] = i32(_e528);
    }
    {
        original_5.x = u32(1i);
        original_5.y = u32(2i);
        original_5.z = u32(3i);
        original_5.w = u32(4i);
        let _e568 = original_5;
        points_5[0][0] = _e568;
        points_5[0][1] = vec4<u32>();
        let _e573 = original_5;
        points_5[1][0] = _e573;
        points_5[1][1].x = u32(5i);
        points_5[1][1].y = u32();
        points_5[1][1].z = u32();
        points_5[1][1].w = u32();
        let _e589 = points_5[0i][0i].w;
        let _e592 = out;
        local_30 = _e592;
        local_31 = u32(15i);
        let _e597 = local_30;
        local_117 = _e597;
        let _e598 = local_31;
        let _e600 = local_117[1];
        local_117[1] = (_e600 + _e598);
        let _e604 = local_117[0];
        local_118 = u32(_e604);
        let _e608 = local_117[1];
        local_119 = u32(_e608);
        let _e611 = local_119;
        out_1[_e611] = i32(_e589);
        let _e618 = points_5[1i][1i].x;
        let _e621 = out;
        local_32 = _e621;
        local_33 = u32(16i);
        let _e626 = local_32;
        local_120 = _e626;
        let _e627 = local_33;
        let _e629 = local_120[1];
        local_120[1] = (_e629 + _e627);
        let _e633 = local_120[0];
        local_121 = u32(_e633);
        let _e637 = local_120[1];
        local_122 = u32(_e637);
        let _e640 = local_122;
        out_1[_e640] = i32(_e618);
        let _e647 = points_5[1i][1i].w;
        let _e650 = out;
        local_34 = _e650;
        local_35 = u32(17i);
        let _e655 = local_34;
        local_123 = _e655;
        let _e656 = local_35;
        let _e658 = local_123[1];
        local_123[1] = (_e658 + _e656);
        let _e662 = local_123[0];
        local_124 = u32(_e662);
        let _e666 = local_123[1];
        local_125 = u32(_e666);
        let _e669 = local_125;
        out_1[_e669] = i32(_e647);
    }
    {
        original_6.x = f32(1i);
        original_6.y = f32(2i);
        let _e681 = original_6;
        points_6[0][0] = _e681;
        points_6[0][1] = vec2<f32>();
        let _e686 = original_6;
        points_6[1][0] = _e686;
        points_6[1][1].x = f32(5i);
        points_6[1][1].y = f32();
        let _e698 = points_6[0i][0i].y;
        let _e701 = out;
        local_36 = _e701;
        local_37 = u32(18i);
        let _e706 = local_36;
        local_126 = _e706;
        let _e707 = local_37;
        let _e709 = local_126[1];
        local_126[1] = (_e709 + _e707);
        let _e713 = local_126[0];
        local_127 = u32(_e713);
        let _e717 = local_126[1];
        local_128 = u32(_e717);
        let _e720 = local_128;
        out_1[_e720] = i32(_e698);
        let _e727 = points_6[1i][1i].x;
        let _e730 = out;
        local_38 = _e730;
        local_39 = u32(19i);
        let _e735 = local_38;
        local_129 = _e735;
        let _e736 = local_39;
        let _e738 = local_129[1];
        local_129[1] = (_e738 + _e736);
        let _e742 = local_129[0];
        local_130 = u32(_e742);
        let _e746 = local_129[1];
        local_131 = u32(_e746);
        let _e749 = local_131;
        out_1[_e749] = i32(_e727);
        let _e756 = points_6[1i][1i].y;
        let _e759 = out;
        local_40 = _e759;
        local_41 = u32(20i);
        let _e764 = local_40;
        local_132 = _e764;
        let _e765 = local_41;
        let _e767 = local_132[1];
        local_132[1] = (_e767 + _e765);
        let _e771 = local_132[0];
        local_133 = u32(_e771);
        let _e775 = local_132[1];
        local_134 = u32(_e775);
        let _e778 = local_134;
        out_1[_e778] = i32(_e756);
    }
    {
        original_7.x = f32(1i);
        original_7.y = f32(2i);
        original_7.z = f32(3i);
        let _e793 = original_7;
        points_7[0][0] = _e793;
        points_7[0][1] = float3_();
        let _e798 = original_7;
        points_7[1][0] = _e798;
        points_7[1][1].x = f32(5i);
        points_7[1][1].y = f32();
        points_7[1][1].z = f32();
        let _e812 = points_7[0i][0i].z;
        let _e815 = out;
        local_42 = _e815;
        local_43 = u32(21i);
        let _e820 = local_42;
        local_135 = _e820;
        let _e821 = local_43;
        let _e823 = local_135[1];
        local_135[1] = (_e823 + _e821);
        let _e827 = local_135[0];
        local_136 = u32(_e827);
        let _e831 = local_135[1];
        local_137 = u32(_e831);
        let _e834 = local_137;
        out_1[_e834] = i32(_e812);
        let _e841 = points_7[1i][1i].x;
        let _e844 = out;
        local_44 = _e844;
        local_45 = u32(22i);
        let _e849 = local_44;
        local_138 = _e849;
        let _e850 = local_45;
        let _e852 = local_138[1];
        local_138[1] = (_e852 + _e850);
        let _e856 = local_138[0];
        local_139 = u32(_e856);
        let _e860 = local_138[1];
        local_140 = u32(_e860);
        let _e863 = local_140;
        out_1[_e863] = i32(_e841);
        let _e870 = points_7[1i][1i].z;
        let _e873 = out;
        local_46 = _e873;
        local_47 = u32(23i);
        let _e878 = local_46;
        local_141 = _e878;
        let _e879 = local_47;
        let _e881 = local_141[1];
        local_141[1] = (_e881 + _e879);
        let _e885 = local_141[0];
        local_142 = u32(_e885);
        let _e889 = local_141[1];
        local_143 = u32(_e889);
        let _e892 = local_143;
        out_1[_e892] = i32(_e870);
    }
    {
        original_8.x = f32(1i);
        original_8.y = f32(2i);
        original_8.z = f32(3i);
        original_8.w = f32(4i);
        let _e910 = original_8;
        points_8[0][0] = _e910;
        points_8[0][1] = vec4<f32>();
        let _e915 = original_8;
        points_8[1][0] = _e915;
        points_8[1][1].x = f32(5i);
        points_8[1][1].y = f32();
        points_8[1][1].z = f32();
        points_8[1][1].w = f32();
        let _e931 = points_8[0i][0i].w;
        let _e934 = out;
        local_48 = _e934;
        local_49 = u32(24i);
        let _e939 = local_48;
        local_144 = _e939;
        let _e940 = local_49;
        let _e942 = local_144[1];
        local_144[1] = (_e942 + _e940);
        let _e946 = local_144[0];
        local_145 = u32(_e946);
        let _e950 = local_144[1];
        local_146 = u32(_e950);
        let _e953 = local_146;
        out_1[_e953] = i32(_e931);
        let _e960 = points_8[1i][1i].x;
        let _e963 = out;
        local_50 = _e963;
        local_51 = u32(25i);
        let _e968 = local_50;
        local_147 = _e968;
        let _e969 = local_51;
        let _e971 = local_147[1];
        local_147[1] = (_e971 + _e969);
        let _e975 = local_147[0];
        local_148 = u32(_e975);
        let _e979 = local_147[1];
        local_149 = u32(_e979);
        let _e982 = local_149;
        out_1[_e982] = i32(_e960);
        let _e989 = points_8[1i][1i].w;
        let _e992 = out;
        local_52 = _e992;
        local_53 = u32(26i);
        let _e997 = local_52;
        local_150 = _e997;
        let _e998 = local_53;
        let _e1000 = local_150[1];
        local_150[1] = (_e1000 + _e998);
        let _e1004 = local_150[0];
        local_151 = u32(_e1004);
        let _e1008 = local_150[1];
        local_152 = u32(_e1008);
        let _e1011 = local_152;
        out_1[_e1011] = i32(_e989);
    }
    changed[0][0] = 1i;
    local_54 = 1u;
    loop {
        let _e1019 = local_54;
        if (_e1019 >= 2u) {
            break;
        }
        changed[0][_e1019] = i32();
        continuing {
            let _e1024 = local_54;
            local_54 = (_e1024 + 1u);
        }
    }
    changed[0i][1i] = 9i;
    changed[1][0] = 2i;
    changed[1][1] = 3i;
    local_55 = 0u;
    loop {
        let _e1039 = local_55;
        if (_e1039 >= 2u) {
            break;
        }
        local_56 = 0u;
        loop {
            let _e1046 = local_56;
            if (_e1046 >= 3u) {
                break;
            }
            nested_empty[_e1039][_e1046] = i32();
            continuing {
                let _e1051 = local_56;
                local_56 = (_e1051 + 1u);
            }
        }
        continuing {
            let _e1054 = local_55;
            local_55 = (_e1054 + 1u);
        }
    }
    partial[0][0] = 1i;
    local_57 = 1u;
    loop {
        let _e1063 = local_57;
        if (_e1063 >= 3u) {
            break;
        }
        partial[0][_e1063] = i32();
        continuing {
            let _e1068 = local_57;
            local_57 = (_e1068 + 1u);
        }
    }
    local_58 = 1u;
    loop {
        let _e1073 = local_58;
        if (_e1073 >= 2u) {
            break;
        }
        local_59 = 0u;
        loop {
            let _e1079 = local_59;
            if (_e1079 >= 3u) {
                break;
            }
            partial[_e1073][_e1079] = i32();
            continuing {
                let _e1084 = local_59;
                local_59 = (_e1084 + 1u);
            }
        }
        continuing {
            let _e1087 = local_58;
            local_58 = (_e1087 + 1u);
        }
    }
    volume[0][0][0] = 1i;
    local_60 = 1u;
    loop {
        let _e1097 = local_60;
        if (_e1097 >= 3u) {
            break;
        }
        volume[0][0][_e1097] = i32();
        continuing {
            let _e1102 = local_60;
            local_60 = (_e1102 + 1u);
        }
    }
    local_61 = 1u;
    loop {
        let _e1107 = local_61;
        if (_e1107 >= 2u) {
            break;
        }
        local_62 = 0u;
        loop {
            let _e1113 = local_62;
            if (_e1113 >= 3u) {
                break;
            }
            volume[0][_e1107][_e1113] = i32();
            continuing {
                let _e1118 = local_62;
                local_62 = (_e1118 + 1u);
            }
        }
        continuing {
            let _e1121 = local_61;
            local_61 = (_e1121 + 1u);
        }
    }
    local_63 = 1u;
    loop {
        let _e1126 = local_63;
        if (_e1126 >= 2u) {
            break;
        }
        local_64 = 0u;
        loop {
            let _e1132 = local_64;
            if (_e1132 >= 2u) {
                break;
            }
            local_65 = 0u;
            loop {
                let _e1138 = local_65;
                if (_e1138 >= 3u) {
                    break;
                }
                volume[_e1126][_e1132][_e1138] = i32();
                continuing {
                    let _e1143 = local_65;
                    local_65 = (_e1143 + 1u);
                }
            }
            continuing {
                let _e1146 = local_64;
                local_64 = (_e1146 + 1u);
            }
        }
        continuing {
            let _e1149 = local_63;
            local_63 = (_e1149 + 1u);
        }
    }
    let _e1156 = changed[0i][1i];
    shared_values[1i][2i] = _e1156;
    let _e1166 = changed[1i][0i];
    let _e1171 = changed[1i][1i];
    shared_points[1i][0i] = float3_(f32(_e1166), f32(_e1171), f32(4i));
    storageBarrier();
    workgroupBarrier();
    let _e1191 = shared_values[1i][2i];
    let _e1192 = nested_empty[1i][2i];
    let _e1198 = partial[1i][2i];
    let _e1206 = volume[1i][1i][2i];
    let _e1209 = out;
    local_66 = _e1209;
    local_67 = u32(27i);
    let _e1214 = local_66;
    local_153 = _e1214;
    let _e1215 = local_67;
    let _e1217 = local_153[1];
    local_153[1] = (_e1217 + _e1215);
    let _e1221 = local_153[0];
    local_154 = u32(_e1221);
    let _e1225 = local_153[1];
    local_155 = u32(_e1225);
    let _e1228 = local_155;
    out_1[_e1228] = (((_e1191 + _e1192) + _e1198) + _e1206);
    let _e1235 = shared_points[1i][0i].x;
    let _e1238 = out;
    local_68 = _e1238;
    local_69 = u32(28i);
    let _e1243 = local_68;
    local_156 = _e1243;
    let _e1244 = local_69;
    let _e1246 = local_156[1];
    local_156[1] = (_e1246 + _e1244);
    let _e1250 = local_156[0];
    local_157 = u32(_e1250);
    let _e1254 = local_156[1];
    local_158 = u32(_e1254);
    let _e1257 = local_158;
    out_1[_e1257] = i32(_e1235);
    let _e1264 = shared_points[1i][0i].y;
    let _e1267 = out;
    local_70 = _e1267;
    local_71 = u32(29i);
    let _e1272 = local_70;
    local_159 = _e1272;
    let _e1273 = local_71;
    let _e1275 = local_159[1];
    local_159[1] = (_e1275 + _e1273);
    let _e1279 = local_159[0];
    local_160 = u32(_e1279);
    let _e1283 = local_159[1];
    local_161 = u32(_e1283);
    let _e1286 = local_161;
    out_1[_e1286] = i32(_e1264);
}
