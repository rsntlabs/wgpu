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
    var local: array<u32, 2>;
    var original: vec2<i32>;
    var points: array<array<vec2<i32>, 2>, 2>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var original_1: int3_;
    var points_1: array<array<int3_, 2>, 2>;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var original_2: vec4<i32>;
    var points_2: array<array<vec4<i32>, 2>, 2>;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var original_3: vec2<u32>;
    var points_3: array<array<vec2<u32>, 2>, 2>;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var original_4: uint3_;
    var points_4: array<array<uint3_, 2>, 2>;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var original_5: vec4<u32>;
    var points_5: array<array<vec4<u32>, 2>, 2>;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var original_6: vec2<f32>;
    var points_6: array<array<vec2<f32>, 2>, 2>;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var original_7: float3_;
    var points_7: array<array<float3_, 2>, 2>;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var original_8: vec4<f32>;
    var points_8: array<array<vec4<f32>, 2>, 2>;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var changed: array<array<i32, 2>, 2>;
    var local_55: u32;
    var nested_empty: array<array<i32, 3>, 2>;
    var local_56: u32;
    var local_57: u32;
    var partial: array<array<i32, 3>, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var volume: array<array<array<i32, 3>, 2>, 2>;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: array<u32, 2>;
    var local_68: u32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: array<u32, 2>;
    var local_74: u32;
    var local_75: u32;
    var local_76: array<u32, 2>;
    var local_77: u32;
    var local_78: u32;
    var local_79: array<u32, 2>;
    var local_80: u32;
    var local_81: u32;
    var local_82: array<u32, 2>;
    var local_83: u32;
    var local_84: u32;
    var local_85: array<u32, 2>;
    var local_86: u32;
    var local_87: u32;
    var local_88: array<u32, 2>;
    var local_89: u32;
    var local_90: u32;
    var local_91: array<u32, 2>;
    var local_92: u32;
    var local_93: u32;
    var local_94: array<u32, 2>;
    var local_95: u32;
    var local_96: u32;
    var local_97: array<u32, 2>;
    var local_98: u32;
    var local_99: u32;
    var local_100: array<u32, 2>;
    var local_101: u32;
    var local_102: u32;
    var local_103: array<u32, 2>;
    var local_104: u32;
    var local_105: u32;
    var local_106: array<u32, 2>;
    var local_107: u32;
    var local_108: u32;
    var local_109: array<u32, 2>;
    var local_110: u32;
    var local_111: u32;
    var local_112: array<u32, 2>;
    var local_113: u32;
    var local_114: u32;
    var local_115: array<u32, 2>;
    var local_116: u32;
    var local_117: u32;
    var local_118: array<u32, 2>;
    var local_119: u32;
    var local_120: u32;
    var local_121: array<u32, 2>;
    var local_122: u32;
    var local_123: u32;
    var local_124: array<u32, 2>;
    var local_125: u32;
    var local_126: u32;
    var local_127: array<u32, 2>;
    var local_128: u32;
    var local_129: u32;
    var local_130: array<u32, 2>;
    var local_131: u32;
    var local_132: u32;
    var local_133: array<u32, 2>;
    var local_134: u32;
    var local_135: u32;
    var local_136: array<u32, 2>;
    var local_137: u32;
    var local_138: u32;
    var local_139: array<u32, 2>;
    var local_140: u32;
    var local_141: u32;
    var local_142: array<u32, 2>;
    var local_143: u32;
    var local_144: u32;
    var local_145: array<u32, 2>;
    var local_146: u32;
    var local_147: u32;
    var local_148: array<u32, 2>;
    var local_149: u32;
    var local_150: u32;
    var local_151: array<u32, 2>;
    var local_152: u32;
    var local_153: u32;
    var local_154: array<u32, 2>;
    var local_155: u32;
    var local_156: u32;
    var local_157: array<u32, 2>;
    var local_158: u32;
    var local_159: u32;
    var local_160: array<u32, 2>;
    var local_161: u32;
    var local_162: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
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
        let _e34 = local;
        local_1 = _e34;
        local_2 = u32(0i);
        let _e39 = local_1;
        local_73 = _e39;
        let _e40 = local_2;
        let _e42 = local_73[1];
        local_73[1] = (_e42 + _e40);
        let _e46 = local_73[0];
        local_74 = u32(_e46);
        let _e50 = local_73[1];
        local_75 = u32(_e50);
        let _e53 = local_75;
        out[_e53] = _e31;
        let _e60 = points[1i][1i].x;
        let _e62 = local;
        local_3 = _e62;
        local_4 = u32(1i);
        let _e67 = local_3;
        local_76 = _e67;
        let _e68 = local_4;
        let _e70 = local_76[1];
        local_76[1] = (_e70 + _e68);
        let _e74 = local_76[0];
        local_77 = u32(_e74);
        let _e78 = local_76[1];
        local_78 = u32(_e78);
        let _e81 = local_78;
        out[_e81] = _e60;
        let _e88 = points[1i][1i].y;
        let _e90 = local;
        local_5 = _e90;
        local_6 = u32(2i);
        let _e95 = local_5;
        local_79 = _e95;
        let _e96 = local_6;
        let _e98 = local_79[1];
        local_79[1] = (_e98 + _e96);
        let _e102 = local_79[0];
        local_80 = u32(_e102);
        let _e106 = local_79[1];
        local_81 = u32(_e106);
        let _e109 = local_81;
        out[_e109] = _e88;
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
        let _e141 = local;
        local_7 = _e141;
        local_8 = u32(3i);
        let _e146 = local_7;
        local_82 = _e146;
        let _e147 = local_8;
        let _e149 = local_82[1];
        local_82[1] = (_e149 + _e147);
        let _e153 = local_82[0];
        local_83 = u32(_e153);
        let _e157 = local_82[1];
        local_84 = u32(_e157);
        let _e160 = local_84;
        out[_e160] = _e139;
        let _e167 = points_1[1i][1i].x;
        let _e169 = local;
        local_9 = _e169;
        local_10 = u32(4i);
        let _e174 = local_9;
        local_85 = _e174;
        let _e175 = local_10;
        let _e177 = local_85[1];
        local_85[1] = (_e177 + _e175);
        let _e181 = local_85[0];
        local_86 = u32(_e181);
        let _e185 = local_85[1];
        local_87 = u32(_e185);
        let _e188 = local_87;
        out[_e188] = _e167;
        let _e195 = points_1[1i][1i].z;
        let _e197 = local;
        local_11 = _e197;
        local_12 = u32(5i);
        let _e202 = local_11;
        local_88 = _e202;
        let _e203 = local_12;
        let _e205 = local_88[1];
        local_88[1] = (_e205 + _e203);
        let _e209 = local_88[0];
        local_89 = u32(_e209);
        let _e213 = local_88[1];
        local_90 = u32(_e213);
        let _e216 = local_90;
        out[_e216] = _e195;
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
        let _e252 = local;
        local_13 = _e252;
        local_14 = u32(6i);
        let _e257 = local_13;
        local_91 = _e257;
        let _e258 = local_14;
        let _e260 = local_91[1];
        local_91[1] = (_e260 + _e258);
        let _e264 = local_91[0];
        local_92 = u32(_e264);
        let _e268 = local_91[1];
        local_93 = u32(_e268);
        let _e271 = local_93;
        out[_e271] = _e250;
        let _e278 = points_2[1i][1i].x;
        let _e280 = local;
        local_15 = _e280;
        local_16 = u32(7i);
        let _e285 = local_15;
        local_94 = _e285;
        let _e286 = local_16;
        let _e288 = local_94[1];
        local_94[1] = (_e288 + _e286);
        let _e292 = local_94[0];
        local_95 = u32(_e292);
        let _e296 = local_94[1];
        local_96 = u32(_e296);
        let _e299 = local_96;
        out[_e299] = _e278;
        let _e306 = points_2[1i][1i].w;
        let _e308 = local;
        local_17 = _e308;
        local_18 = u32(8i);
        let _e313 = local_17;
        local_97 = _e313;
        let _e314 = local_18;
        let _e316 = local_97[1];
        local_97[1] = (_e316 + _e314);
        let _e320 = local_97[0];
        local_98 = u32(_e320);
        let _e324 = local_97[1];
        local_99 = u32(_e324);
        let _e327 = local_99;
        out[_e327] = _e306;
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
        let _e359 = local;
        local_19 = _e359;
        local_20 = u32(9i);
        let _e364 = local_19;
        local_100 = _e364;
        let _e365 = local_20;
        let _e367 = local_100[1];
        local_100[1] = (_e367 + _e365);
        let _e371 = local_100[0];
        local_101 = u32(_e371);
        let _e375 = local_100[1];
        local_102 = u32(_e375);
        let _e378 = local_102;
        out[_e378] = i32(_e356);
        let _e385 = points_3[1i][1i].x;
        let _e388 = local;
        local_21 = _e388;
        local_22 = u32(10i);
        let _e393 = local_21;
        local_103 = _e393;
        let _e394 = local_22;
        let _e396 = local_103[1];
        local_103[1] = (_e396 + _e394);
        let _e400 = local_103[0];
        local_104 = u32(_e400);
        let _e404 = local_103[1];
        local_105 = u32(_e404);
        let _e407 = local_105;
        out[_e407] = i32(_e385);
        let _e414 = points_3[1i][1i].y;
        let _e417 = local;
        local_23 = _e417;
        local_24 = u32(11i);
        let _e422 = local_23;
        local_106 = _e422;
        let _e423 = local_24;
        let _e425 = local_106[1];
        local_106[1] = (_e425 + _e423);
        let _e429 = local_106[0];
        local_107 = u32(_e429);
        let _e433 = local_106[1];
        local_108 = u32(_e433);
        let _e436 = local_108;
        out[_e436] = i32(_e414);
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
        let _e473 = local;
        local_25 = _e473;
        local_26 = u32(12i);
        let _e478 = local_25;
        local_109 = _e478;
        let _e479 = local_26;
        let _e481 = local_109[1];
        local_109[1] = (_e481 + _e479);
        let _e485 = local_109[0];
        local_110 = u32(_e485);
        let _e489 = local_109[1];
        local_111 = u32(_e489);
        let _e492 = local_111;
        out[_e492] = i32(_e470);
        let _e499 = points_4[1i][1i].x;
        let _e502 = local;
        local_27 = _e502;
        local_28 = u32(13i);
        let _e507 = local_27;
        local_112 = _e507;
        let _e508 = local_28;
        let _e510 = local_112[1];
        local_112[1] = (_e510 + _e508);
        let _e514 = local_112[0];
        local_113 = u32(_e514);
        let _e518 = local_112[1];
        local_114 = u32(_e518);
        let _e521 = local_114;
        out[_e521] = i32(_e499);
        let _e528 = points_4[1i][1i].z;
        let _e531 = local;
        local_29 = _e531;
        local_30 = u32(14i);
        let _e536 = local_29;
        local_115 = _e536;
        let _e537 = local_30;
        let _e539 = local_115[1];
        local_115[1] = (_e539 + _e537);
        let _e543 = local_115[0];
        local_116 = u32(_e543);
        let _e547 = local_115[1];
        local_117 = u32(_e547);
        let _e550 = local_117;
        out[_e550] = i32(_e528);
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
        let _e592 = local;
        local_31 = _e592;
        local_32 = u32(15i);
        let _e597 = local_31;
        local_118 = _e597;
        let _e598 = local_32;
        let _e600 = local_118[1];
        local_118[1] = (_e600 + _e598);
        let _e604 = local_118[0];
        local_119 = u32(_e604);
        let _e608 = local_118[1];
        local_120 = u32(_e608);
        let _e611 = local_120;
        out[_e611] = i32(_e589);
        let _e618 = points_5[1i][1i].x;
        let _e621 = local;
        local_33 = _e621;
        local_34 = u32(16i);
        let _e626 = local_33;
        local_121 = _e626;
        let _e627 = local_34;
        let _e629 = local_121[1];
        local_121[1] = (_e629 + _e627);
        let _e633 = local_121[0];
        local_122 = u32(_e633);
        let _e637 = local_121[1];
        local_123 = u32(_e637);
        let _e640 = local_123;
        out[_e640] = i32(_e618);
        let _e647 = points_5[1i][1i].w;
        let _e650 = local;
        local_35 = _e650;
        local_36 = u32(17i);
        let _e655 = local_35;
        local_124 = _e655;
        let _e656 = local_36;
        let _e658 = local_124[1];
        local_124[1] = (_e658 + _e656);
        let _e662 = local_124[0];
        local_125 = u32(_e662);
        let _e666 = local_124[1];
        local_126 = u32(_e666);
        let _e669 = local_126;
        out[_e669] = i32(_e647);
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
        let _e701 = local;
        local_37 = _e701;
        local_38 = u32(18i);
        let _e706 = local_37;
        local_127 = _e706;
        let _e707 = local_38;
        let _e709 = local_127[1];
        local_127[1] = (_e709 + _e707);
        let _e713 = local_127[0];
        local_128 = u32(_e713);
        let _e717 = local_127[1];
        local_129 = u32(_e717);
        let _e720 = local_129;
        out[_e720] = i32(_e698);
        let _e727 = points_6[1i][1i].x;
        let _e730 = local;
        local_39 = _e730;
        local_40 = u32(19i);
        let _e735 = local_39;
        local_130 = _e735;
        let _e736 = local_40;
        let _e738 = local_130[1];
        local_130[1] = (_e738 + _e736);
        let _e742 = local_130[0];
        local_131 = u32(_e742);
        let _e746 = local_130[1];
        local_132 = u32(_e746);
        let _e749 = local_132;
        out[_e749] = i32(_e727);
        let _e756 = points_6[1i][1i].y;
        let _e759 = local;
        local_41 = _e759;
        local_42 = u32(20i);
        let _e764 = local_41;
        local_133 = _e764;
        let _e765 = local_42;
        let _e767 = local_133[1];
        local_133[1] = (_e767 + _e765);
        let _e771 = local_133[0];
        local_134 = u32(_e771);
        let _e775 = local_133[1];
        local_135 = u32(_e775);
        let _e778 = local_135;
        out[_e778] = i32(_e756);
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
        let _e815 = local;
        local_43 = _e815;
        local_44 = u32(21i);
        let _e820 = local_43;
        local_136 = _e820;
        let _e821 = local_44;
        let _e823 = local_136[1];
        local_136[1] = (_e823 + _e821);
        let _e827 = local_136[0];
        local_137 = u32(_e827);
        let _e831 = local_136[1];
        local_138 = u32(_e831);
        let _e834 = local_138;
        out[_e834] = i32(_e812);
        let _e841 = points_7[1i][1i].x;
        let _e844 = local;
        local_45 = _e844;
        local_46 = u32(22i);
        let _e849 = local_45;
        local_139 = _e849;
        let _e850 = local_46;
        let _e852 = local_139[1];
        local_139[1] = (_e852 + _e850);
        let _e856 = local_139[0];
        local_140 = u32(_e856);
        let _e860 = local_139[1];
        local_141 = u32(_e860);
        let _e863 = local_141;
        out[_e863] = i32(_e841);
        let _e870 = points_7[1i][1i].z;
        let _e873 = local;
        local_47 = _e873;
        local_48 = u32(23i);
        let _e878 = local_47;
        local_142 = _e878;
        let _e879 = local_48;
        let _e881 = local_142[1];
        local_142[1] = (_e881 + _e879);
        let _e885 = local_142[0];
        local_143 = u32(_e885);
        let _e889 = local_142[1];
        local_144 = u32(_e889);
        let _e892 = local_144;
        out[_e892] = i32(_e870);
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
        let _e934 = local;
        local_49 = _e934;
        local_50 = u32(24i);
        let _e939 = local_49;
        local_145 = _e939;
        let _e940 = local_50;
        let _e942 = local_145[1];
        local_145[1] = (_e942 + _e940);
        let _e946 = local_145[0];
        local_146 = u32(_e946);
        let _e950 = local_145[1];
        local_147 = u32(_e950);
        let _e953 = local_147;
        out[_e953] = i32(_e931);
        let _e960 = points_8[1i][1i].x;
        let _e963 = local;
        local_51 = _e963;
        local_52 = u32(25i);
        let _e968 = local_51;
        local_148 = _e968;
        let _e969 = local_52;
        let _e971 = local_148[1];
        local_148[1] = (_e971 + _e969);
        let _e975 = local_148[0];
        local_149 = u32(_e975);
        let _e979 = local_148[1];
        local_150 = u32(_e979);
        let _e982 = local_150;
        out[_e982] = i32(_e960);
        let _e989 = points_8[1i][1i].w;
        let _e992 = local;
        local_53 = _e992;
        local_54 = u32(26i);
        let _e997 = local_53;
        local_151 = _e997;
        let _e998 = local_54;
        let _e1000 = local_151[1];
        local_151[1] = (_e1000 + _e998);
        let _e1004 = local_151[0];
        local_152 = u32(_e1004);
        let _e1008 = local_151[1];
        local_153 = u32(_e1008);
        let _e1011 = local_153;
        out[_e1011] = i32(_e989);
    }
    changed[0][0] = 1i;
    local_55 = 1u;
    loop {
        let _e1019 = local_55;
        if (_e1019 >= 2u) {
            break;
        }
        changed[0][_e1019] = i32();
        continuing {
            let _e1024 = local_55;
            local_55 = (_e1024 + 1u);
        }
    }
    changed[0i][1i] = 9i;
    changed[1][0] = 2i;
    changed[1][1] = 3i;
    local_56 = 0u;
    loop {
        let _e1039 = local_56;
        if (_e1039 >= 2u) {
            break;
        }
        local_57 = 0u;
        loop {
            let _e1046 = local_57;
            if (_e1046 >= 3u) {
                break;
            }
            nested_empty[_e1039][_e1046] = i32();
            continuing {
                let _e1051 = local_57;
                local_57 = (_e1051 + 1u);
            }
        }
        continuing {
            let _e1054 = local_56;
            local_56 = (_e1054 + 1u);
        }
    }
    partial[0][0] = 1i;
    local_58 = 1u;
    loop {
        let _e1063 = local_58;
        if (_e1063 >= 3u) {
            break;
        }
        partial[0][_e1063] = i32();
        continuing {
            let _e1068 = local_58;
            local_58 = (_e1068 + 1u);
        }
    }
    local_59 = 1u;
    loop {
        let _e1073 = local_59;
        if (_e1073 >= 2u) {
            break;
        }
        local_60 = 0u;
        loop {
            let _e1079 = local_60;
            if (_e1079 >= 3u) {
                break;
            }
            partial[_e1073][_e1079] = i32();
            continuing {
                let _e1084 = local_60;
                local_60 = (_e1084 + 1u);
            }
        }
        continuing {
            let _e1087 = local_59;
            local_59 = (_e1087 + 1u);
        }
    }
    volume[0][0][0] = 1i;
    local_61 = 1u;
    loop {
        let _e1097 = local_61;
        if (_e1097 >= 3u) {
            break;
        }
        volume[0][0][_e1097] = i32();
        continuing {
            let _e1102 = local_61;
            local_61 = (_e1102 + 1u);
        }
    }
    local_62 = 1u;
    loop {
        let _e1107 = local_62;
        if (_e1107 >= 2u) {
            break;
        }
        local_63 = 0u;
        loop {
            let _e1113 = local_63;
            if (_e1113 >= 3u) {
                break;
            }
            volume[0][_e1107][_e1113] = i32();
            continuing {
                let _e1118 = local_63;
                local_63 = (_e1118 + 1u);
            }
        }
        continuing {
            let _e1121 = local_62;
            local_62 = (_e1121 + 1u);
        }
    }
    local_64 = 1u;
    loop {
        let _e1126 = local_64;
        if (_e1126 >= 2u) {
            break;
        }
        local_65 = 0u;
        loop {
            let _e1132 = local_65;
            if (_e1132 >= 2u) {
                break;
            }
            local_66 = 0u;
            loop {
                let _e1138 = local_66;
                if (_e1138 >= 3u) {
                    break;
                }
                volume[_e1126][_e1132][_e1138] = i32();
                continuing {
                    let _e1143 = local_66;
                    local_66 = (_e1143 + 1u);
                }
            }
            continuing {
                let _e1146 = local_65;
                local_65 = (_e1146 + 1u);
            }
        }
        continuing {
            let _e1149 = local_64;
            local_64 = (_e1149 + 1u);
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
    let _e1209 = local;
    local_67 = _e1209;
    local_68 = u32(27i);
    let _e1214 = local_67;
    local_154 = _e1214;
    let _e1215 = local_68;
    let _e1217 = local_154[1];
    local_154[1] = (_e1217 + _e1215);
    let _e1221 = local_154[0];
    local_155 = u32(_e1221);
    let _e1225 = local_154[1];
    local_156 = u32(_e1225);
    let _e1228 = local_156;
    out[_e1228] = (((_e1191 + _e1192) + _e1198) + _e1206);
    let _e1235 = shared_points[1i][0i].x;
    let _e1238 = local;
    local_69 = _e1238;
    local_70 = u32(28i);
    let _e1243 = local_69;
    local_157 = _e1243;
    let _e1244 = local_70;
    let _e1246 = local_157[1];
    local_157[1] = (_e1246 + _e1244);
    let _e1250 = local_157[0];
    local_158 = u32(_e1250);
    let _e1254 = local_157[1];
    local_159 = u32(_e1254);
    let _e1257 = local_159;
    out[_e1257] = i32(_e1235);
    let _e1264 = shared_points[1i][0i].y;
    let _e1267 = local;
    local_71 = _e1267;
    local_72 = u32(29i);
    let _e1272 = local_71;
    local_160 = _e1272;
    let _e1273 = local_72;
    let _e1275 = local_160[1];
    local_160[1] = (_e1275 + _e1273);
    let _e1279 = local_160[0];
    local_161 = u32(_e1279);
    let _e1283 = local_160[1];
    local_162 = u32(_e1283);
    let _e1286 = local_162;
    out[_e1286] = i32(_e1264);
}
