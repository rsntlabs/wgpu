struct int3_ {
    int x;
    int y;
    int z;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_1 : register(u0);
groupshared int shared_values[2][3];
groupshared float3_ shared_points[2][2];

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int2 ZeroValueint2() {
    return (int2)0;
}

int ZeroValueint() {
    return (int)0;
}

int3_ ZeroValueint3_() {
    return (int3_)0;
}

int4 ZeroValueint4() {
    return (int4)0;
}

uint2 ZeroValueuint2() {
    return (uint2)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

uint3_ ZeroValueuint3_() {
    return (uint3_)0;
}

uint4 ZeroValueuint4() {
    return (uint4)0;
}

float2 ZeroValuefloat2() {
    return (float2)0;
}

float ZeroValuefloat() {
    return (float)0;
}

float3_ ZeroValuefloat3_() {
    return (float3_)0;
}

float4 ZeroValuefloat4() {
    return (float4)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void multidimensional_arrays(uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_values = (int[2][3])0;
        shared_points = (float3_[2][2])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint out_[2] = (uint[2])0;
    int2 original = (int2)0;
    int2 points[2][2] = (int2[2][2])0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    int3_ original_1 = (int3_)0;
    int3_ points_1[2][2] = (int3_[2][2])0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    int4 original_2 = (int4)0;
    int4 points_2[2][2] = (int4[2][2])0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint2 original_3 = (uint2)0;
    uint2 points_3[2][2] = (uint2[2][2])0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint3_ original_4 = (uint3_)0;
    uint3_ points_4[2][2] = (uint3_[2][2])0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint4 original_5 = (uint4)0;
    uint4 points_5[2][2] = (uint4[2][2])0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    float2 original_6 = (float2)0;
    float2 points_6[2][2] = (float2[2][2])0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    float3_ original_7 = (float3_)0;
    float3_ points_7[2][2] = (float3_[2][2])0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    float4 original_8 = (float4)0;
    float4 points_8[2][2] = (float4[2][2])0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    int changed[2][2] = (int[2][2])0;
    uint local_54 = (uint)0;
    int nested_empty[2][3] = (int[2][3])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    int partial[2][3] = (int[2][3])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    int volume[2][2][3] = (int[2][2][3])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68[2] = (uint[2])0;
    uint local_69 = (uint)0;
    uint local_70[2] = (uint[2])0;
    uint local_71 = (uint)0;
    uint local_72[2] = (uint[2])0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75[2] = (uint[2])0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78[2] = (uint[2])0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81[2] = (uint[2])0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84[2] = (uint[2])0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87[2] = (uint[2])0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90[2] = (uint[2])0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93[2] = (uint[2])0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96[2] = (uint[2])0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99[2] = (uint[2])0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102[2] = (uint[2])0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105[2] = (uint[2])0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108[2] = (uint[2])0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111[2] = (uint[2])0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114[2] = (uint[2])0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117[2] = (uint[2])0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120[2] = (uint[2])0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123[2] = (uint[2])0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126[2] = (uint[2])0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129[2] = (uint[2])0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132[2] = (uint[2])0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    uint local_135[2] = (uint[2])0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138[2] = (uint[2])0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141[2] = (uint[2])0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144[2] = (uint[2])0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    uint local_147[2] = (uint[2])0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150[2] = (uint[2])0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;
    uint local_153[2] = (uint[2])0;
    uint local_154 = (uint)0;
    uint local_155 = (uint)0;
    uint local_156[2] = (uint[2])0;
    uint local_157 = (uint)0;
    uint local_158 = (uint)0;
    uint local_159[2] = (uint[2])0;
    uint local_160 = (uint)0;
    uint local_161 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    {
        original.x = int(1);
        original.y = int(2);
        int2 _e15 = original;
        points[0][0] = _e15;
        points[0][1] = ZeroValueint2();
        int2 _e20 = original;
        points[1][0] = _e20;
        points[1][1].x = int(5);
        points[1][1].y = ZeroValueint();
        int _e31 = points[int(0)][int(0)].y;
        uint _e34[2] = out_;
        local = _e34;
        local_1 = uint(int(0));
        uint _e39[2] = local;
        local_72 = _e39;
        uint _e40 = local_1;
        uint _e42 = local_72[1];
        local_72[1] = (_e42 + _e40);
        uint _e46 = local_72[0];
        local_73 = uint(_e46);
        uint _e50 = local_72[1];
        local_74 = uint(_e50);
        uint _e53 = local_74;
        out_1.Store(_e53*4, asuint(_e31));
        int _e60 = points[int(1)][int(1)].x;
        uint _e62[2] = out_;
        local_2 = _e62;
        local_3 = uint(int(1));
        uint _e67[2] = local_2;
        local_75 = _e67;
        uint _e68 = local_3;
        uint _e70 = local_75[1];
        local_75[1] = (_e70 + _e68);
        uint _e74 = local_75[0];
        local_76 = uint(_e74);
        uint _e78 = local_75[1];
        local_77 = uint(_e78);
        uint _e81 = local_77;
        out_1.Store(_e81*4, asuint(_e60));
        int _e88 = points[int(1)][int(1)].y;
        uint _e90[2] = out_;
        local_4 = _e90;
        local_5 = uint(int(2));
        uint _e95[2] = local_4;
        local_78 = _e95;
        uint _e96 = local_5;
        uint _e98 = local_78[1];
        local_78[1] = (_e98 + _e96);
        uint _e102 = local_78[0];
        local_79 = uint(_e102);
        uint _e106 = local_78[1];
        local_80 = uint(_e106);
        uint _e109 = local_80;
        out_1.Store(_e109*4, asuint(_e88));
    }
    {
        original_1.x = int(1);
        original_1.y = int(2);
        original_1.z = int(3);
        int3_ _e121 = original_1;
        points_1[0][0] = _e121;
        points_1[0][1] = ZeroValueint3_();
        int3_ _e126 = original_1;
        points_1[1][0] = _e126;
        points_1[1][1].x = int(5);
        points_1[1][1].y = ZeroValueint();
        points_1[1][1].z = ZeroValueint();
        int _e139 = points_1[int(0)][int(0)].z;
        uint _e141[2] = out_;
        local_6 = _e141;
        local_7 = uint(int(3));
        uint _e146[2] = local_6;
        local_81 = _e146;
        uint _e147 = local_7;
        uint _e149 = local_81[1];
        local_81[1] = (_e149 + _e147);
        uint _e153 = local_81[0];
        local_82 = uint(_e153);
        uint _e157 = local_81[1];
        local_83 = uint(_e157);
        uint _e160 = local_83;
        out_1.Store(_e160*4, asuint(_e139));
        int _e167 = points_1[int(1)][int(1)].x;
        uint _e169[2] = out_;
        local_8 = _e169;
        local_9 = uint(int(4));
        uint _e174[2] = local_8;
        local_84 = _e174;
        uint _e175 = local_9;
        uint _e177 = local_84[1];
        local_84[1] = (_e177 + _e175);
        uint _e181 = local_84[0];
        local_85 = uint(_e181);
        uint _e185 = local_84[1];
        local_86 = uint(_e185);
        uint _e188 = local_86;
        out_1.Store(_e188*4, asuint(_e167));
        int _e195 = points_1[int(1)][int(1)].z;
        uint _e197[2] = out_;
        local_10 = _e197;
        local_11 = uint(int(5));
        uint _e202[2] = local_10;
        local_87 = _e202;
        uint _e203 = local_11;
        uint _e205 = local_87[1];
        local_87[1] = (_e205 + _e203);
        uint _e209 = local_87[0];
        local_88 = uint(_e209);
        uint _e213 = local_87[1];
        local_89 = uint(_e213);
        uint _e216 = local_89;
        out_1.Store(_e216*4, asuint(_e195));
    }
    {
        original_2.x = int(1);
        original_2.y = int(2);
        original_2.z = int(3);
        original_2.w = int(4);
        int4 _e230 = original_2;
        points_2[0][0] = _e230;
        points_2[0][1] = ZeroValueint4();
        int4 _e235 = original_2;
        points_2[1][0] = _e235;
        points_2[1][1].x = int(5);
        points_2[1][1].y = ZeroValueint();
        points_2[1][1].z = ZeroValueint();
        points_2[1][1].w = ZeroValueint();
        int _e250 = points_2[int(0)][int(0)].w;
        uint _e252[2] = out_;
        local_12 = _e252;
        local_13 = uint(int(6));
        uint _e257[2] = local_12;
        local_90 = _e257;
        uint _e258 = local_13;
        uint _e260 = local_90[1];
        local_90[1] = (_e260 + _e258);
        uint _e264 = local_90[0];
        local_91 = uint(_e264);
        uint _e268 = local_90[1];
        local_92 = uint(_e268);
        uint _e271 = local_92;
        out_1.Store(_e271*4, asuint(_e250));
        int _e278 = points_2[int(1)][int(1)].x;
        uint _e280[2] = out_;
        local_14 = _e280;
        local_15 = uint(int(7));
        uint _e285[2] = local_14;
        local_93 = _e285;
        uint _e286 = local_15;
        uint _e288 = local_93[1];
        local_93[1] = (_e288 + _e286);
        uint _e292 = local_93[0];
        local_94 = uint(_e292);
        uint _e296 = local_93[1];
        local_95 = uint(_e296);
        uint _e299 = local_95;
        out_1.Store(_e299*4, asuint(_e278));
        int _e306 = points_2[int(1)][int(1)].w;
        uint _e308[2] = out_;
        local_16 = _e308;
        local_17 = uint(int(8));
        uint _e313[2] = local_16;
        local_96 = _e313;
        uint _e314 = local_17;
        uint _e316 = local_96[1];
        local_96[1] = (_e316 + _e314);
        uint _e320 = local_96[0];
        local_97 = uint(_e320);
        uint _e324 = local_96[1];
        local_98 = uint(_e324);
        uint _e327 = local_98;
        out_1.Store(_e327*4, asuint(_e306));
    }
    {
        original_3.x = uint(int(1));
        original_3.y = uint(int(2));
        uint2 _e339 = original_3;
        points_3[0][0] = _e339;
        points_3[0][1] = ZeroValueuint2();
        uint2 _e344 = original_3;
        points_3[1][0] = _e344;
        points_3[1][1].x = uint(int(5));
        points_3[1][1].y = ZeroValueuint();
        uint _e356 = points_3[int(0)][int(0)].y;
        uint _e359[2] = out_;
        local_18 = _e359;
        local_19 = uint(int(9));
        uint _e364[2] = local_18;
        local_99 = _e364;
        uint _e365 = local_19;
        uint _e367 = local_99[1];
        local_99[1] = (_e367 + _e365);
        uint _e371 = local_99[0];
        local_100 = uint(_e371);
        uint _e375 = local_99[1];
        local_101 = uint(_e375);
        uint _e378 = local_101;
        out_1.Store(_e378*4, asuint(int(_e356)));
        uint _e385 = points_3[int(1)][int(1)].x;
        uint _e388[2] = out_;
        local_20 = _e388;
        local_21 = uint(int(10));
        uint _e393[2] = local_20;
        local_102 = _e393;
        uint _e394 = local_21;
        uint _e396 = local_102[1];
        local_102[1] = (_e396 + _e394);
        uint _e400 = local_102[0];
        local_103 = uint(_e400);
        uint _e404 = local_102[1];
        local_104 = uint(_e404);
        uint _e407 = local_104;
        out_1.Store(_e407*4, asuint(int(_e385)));
        uint _e414 = points_3[int(1)][int(1)].y;
        uint _e417[2] = out_;
        local_22 = _e417;
        local_23 = uint(int(11));
        uint _e422[2] = local_22;
        local_105 = _e422;
        uint _e423 = local_23;
        uint _e425 = local_105[1];
        local_105[1] = (_e425 + _e423);
        uint _e429 = local_105[0];
        local_106 = uint(_e429);
        uint _e433 = local_105[1];
        local_107 = uint(_e433);
        uint _e436 = local_107;
        out_1.Store(_e436*4, asuint(int(_e414)));
    }
    {
        original_4.x = uint(int(1));
        original_4.y = uint(int(2));
        original_4.z = uint(int(3));
        uint3_ _e451 = original_4;
        points_4[0][0] = _e451;
        points_4[0][1] = ZeroValueuint3_();
        uint3_ _e456 = original_4;
        points_4[1][0] = _e456;
        points_4[1][1].x = uint(int(5));
        points_4[1][1].y = ZeroValueuint();
        points_4[1][1].z = ZeroValueuint();
        uint _e470 = points_4[int(0)][int(0)].z;
        uint _e473[2] = out_;
        local_24 = _e473;
        local_25 = uint(int(12));
        uint _e478[2] = local_24;
        local_108 = _e478;
        uint _e479 = local_25;
        uint _e481 = local_108[1];
        local_108[1] = (_e481 + _e479);
        uint _e485 = local_108[0];
        local_109 = uint(_e485);
        uint _e489 = local_108[1];
        local_110 = uint(_e489);
        uint _e492 = local_110;
        out_1.Store(_e492*4, asuint(int(_e470)));
        uint _e499 = points_4[int(1)][int(1)].x;
        uint _e502[2] = out_;
        local_26 = _e502;
        local_27 = uint(int(13));
        uint _e507[2] = local_26;
        local_111 = _e507;
        uint _e508 = local_27;
        uint _e510 = local_111[1];
        local_111[1] = (_e510 + _e508);
        uint _e514 = local_111[0];
        local_112 = uint(_e514);
        uint _e518 = local_111[1];
        local_113 = uint(_e518);
        uint _e521 = local_113;
        out_1.Store(_e521*4, asuint(int(_e499)));
        uint _e528 = points_4[int(1)][int(1)].z;
        uint _e531[2] = out_;
        local_28 = _e531;
        local_29 = uint(int(14));
        uint _e536[2] = local_28;
        local_114 = _e536;
        uint _e537 = local_29;
        uint _e539 = local_114[1];
        local_114[1] = (_e539 + _e537);
        uint _e543 = local_114[0];
        local_115 = uint(_e543);
        uint _e547 = local_114[1];
        local_116 = uint(_e547);
        uint _e550 = local_116;
        out_1.Store(_e550*4, asuint(int(_e528)));
    }
    {
        original_5.x = uint(int(1));
        original_5.y = uint(int(2));
        original_5.z = uint(int(3));
        original_5.w = uint(int(4));
        uint4 _e568 = original_5;
        points_5[0][0] = _e568;
        points_5[0][1] = ZeroValueuint4();
        uint4 _e573 = original_5;
        points_5[1][0] = _e573;
        points_5[1][1].x = uint(int(5));
        points_5[1][1].y = ZeroValueuint();
        points_5[1][1].z = ZeroValueuint();
        points_5[1][1].w = ZeroValueuint();
        uint _e589 = points_5[int(0)][int(0)].w;
        uint _e592[2] = out_;
        local_30 = _e592;
        local_31 = uint(int(15));
        uint _e597[2] = local_30;
        local_117 = _e597;
        uint _e598 = local_31;
        uint _e600 = local_117[1];
        local_117[1] = (_e600 + _e598);
        uint _e604 = local_117[0];
        local_118 = uint(_e604);
        uint _e608 = local_117[1];
        local_119 = uint(_e608);
        uint _e611 = local_119;
        out_1.Store(_e611*4, asuint(int(_e589)));
        uint _e618 = points_5[int(1)][int(1)].x;
        uint _e621[2] = out_;
        local_32 = _e621;
        local_33 = uint(int(16));
        uint _e626[2] = local_32;
        local_120 = _e626;
        uint _e627 = local_33;
        uint _e629 = local_120[1];
        local_120[1] = (_e629 + _e627);
        uint _e633 = local_120[0];
        local_121 = uint(_e633);
        uint _e637 = local_120[1];
        local_122 = uint(_e637);
        uint _e640 = local_122;
        out_1.Store(_e640*4, asuint(int(_e618)));
        uint _e647 = points_5[int(1)][int(1)].w;
        uint _e650[2] = out_;
        local_34 = _e650;
        local_35 = uint(int(17));
        uint _e655[2] = local_34;
        local_123 = _e655;
        uint _e656 = local_35;
        uint _e658 = local_123[1];
        local_123[1] = (_e658 + _e656);
        uint _e662 = local_123[0];
        local_124 = uint(_e662);
        uint _e666 = local_123[1];
        local_125 = uint(_e666);
        uint _e669 = local_125;
        out_1.Store(_e669*4, asuint(int(_e647)));
    }
    {
        original_6.x = float(int(1));
        original_6.y = float(int(2));
        float2 _e681 = original_6;
        points_6[0][0] = _e681;
        points_6[0][1] = ZeroValuefloat2();
        float2 _e686 = original_6;
        points_6[1][0] = _e686;
        points_6[1][1].x = float(int(5));
        points_6[1][1].y = ZeroValuefloat();
        float _e698 = points_6[int(0)][int(0)].y;
        uint _e701[2] = out_;
        local_36 = _e701;
        local_37 = uint(int(18));
        uint _e706[2] = local_36;
        local_126 = _e706;
        uint _e707 = local_37;
        uint _e709 = local_126[1];
        local_126[1] = (_e709 + _e707);
        uint _e713 = local_126[0];
        local_127 = uint(_e713);
        uint _e717 = local_126[1];
        local_128 = uint(_e717);
        uint _e720 = local_128;
        out_1.Store(_e720*4, asuint(naga_f2i32(_e698)));
        float _e727 = points_6[int(1)][int(1)].x;
        uint _e730[2] = out_;
        local_38 = _e730;
        local_39 = uint(int(19));
        uint _e735[2] = local_38;
        local_129 = _e735;
        uint _e736 = local_39;
        uint _e738 = local_129[1];
        local_129[1] = (_e738 + _e736);
        uint _e742 = local_129[0];
        local_130 = uint(_e742);
        uint _e746 = local_129[1];
        local_131 = uint(_e746);
        uint _e749 = local_131;
        out_1.Store(_e749*4, asuint(naga_f2i32(_e727)));
        float _e756 = points_6[int(1)][int(1)].y;
        uint _e759[2] = out_;
        local_40 = _e759;
        local_41 = uint(int(20));
        uint _e764[2] = local_40;
        local_132 = _e764;
        uint _e765 = local_41;
        uint _e767 = local_132[1];
        local_132[1] = (_e767 + _e765);
        uint _e771 = local_132[0];
        local_133 = uint(_e771);
        uint _e775 = local_132[1];
        local_134 = uint(_e775);
        uint _e778 = local_134;
        out_1.Store(_e778*4, asuint(naga_f2i32(_e756)));
    }
    {
        original_7.x = float(int(1));
        original_7.y = float(int(2));
        original_7.z = float(int(3));
        float3_ _e793 = original_7;
        points_7[0][0] = _e793;
        points_7[0][1] = ZeroValuefloat3_();
        float3_ _e798 = original_7;
        points_7[1][0] = _e798;
        points_7[1][1].x = float(int(5));
        points_7[1][1].y = ZeroValuefloat();
        points_7[1][1].z = ZeroValuefloat();
        float _e812 = points_7[int(0)][int(0)].z;
        uint _e815[2] = out_;
        local_42 = _e815;
        local_43 = uint(int(21));
        uint _e820[2] = local_42;
        local_135 = _e820;
        uint _e821 = local_43;
        uint _e823 = local_135[1];
        local_135[1] = (_e823 + _e821);
        uint _e827 = local_135[0];
        local_136 = uint(_e827);
        uint _e831 = local_135[1];
        local_137 = uint(_e831);
        uint _e834 = local_137;
        out_1.Store(_e834*4, asuint(naga_f2i32(_e812)));
        float _e841 = points_7[int(1)][int(1)].x;
        uint _e844[2] = out_;
        local_44 = _e844;
        local_45 = uint(int(22));
        uint _e849[2] = local_44;
        local_138 = _e849;
        uint _e850 = local_45;
        uint _e852 = local_138[1];
        local_138[1] = (_e852 + _e850);
        uint _e856 = local_138[0];
        local_139 = uint(_e856);
        uint _e860 = local_138[1];
        local_140 = uint(_e860);
        uint _e863 = local_140;
        out_1.Store(_e863*4, asuint(naga_f2i32(_e841)));
        float _e870 = points_7[int(1)][int(1)].z;
        uint _e873[2] = out_;
        local_46 = _e873;
        local_47 = uint(int(23));
        uint _e878[2] = local_46;
        local_141 = _e878;
        uint _e879 = local_47;
        uint _e881 = local_141[1];
        local_141[1] = (_e881 + _e879);
        uint _e885 = local_141[0];
        local_142 = uint(_e885);
        uint _e889 = local_141[1];
        local_143 = uint(_e889);
        uint _e892 = local_143;
        out_1.Store(_e892*4, asuint(naga_f2i32(_e870)));
    }
    {
        original_8.x = float(int(1));
        original_8.y = float(int(2));
        original_8.z = float(int(3));
        original_8.w = float(int(4));
        float4 _e910 = original_8;
        points_8[0][0] = _e910;
        points_8[0][1] = ZeroValuefloat4();
        float4 _e915 = original_8;
        points_8[1][0] = _e915;
        points_8[1][1].x = float(int(5));
        points_8[1][1].y = ZeroValuefloat();
        points_8[1][1].z = ZeroValuefloat();
        points_8[1][1].w = ZeroValuefloat();
        float _e931 = points_8[int(0)][int(0)].w;
        uint _e934[2] = out_;
        local_48 = _e934;
        local_49 = uint(int(24));
        uint _e939[2] = local_48;
        local_144 = _e939;
        uint _e940 = local_49;
        uint _e942 = local_144[1];
        local_144[1] = (_e942 + _e940);
        uint _e946 = local_144[0];
        local_145 = uint(_e946);
        uint _e950 = local_144[1];
        local_146 = uint(_e950);
        uint _e953 = local_146;
        out_1.Store(_e953*4, asuint(naga_f2i32(_e931)));
        float _e960 = points_8[int(1)][int(1)].x;
        uint _e963[2] = out_;
        local_50 = _e963;
        local_51 = uint(int(25));
        uint _e968[2] = local_50;
        local_147 = _e968;
        uint _e969 = local_51;
        uint _e971 = local_147[1];
        local_147[1] = (_e971 + _e969);
        uint _e975 = local_147[0];
        local_148 = uint(_e975);
        uint _e979 = local_147[1];
        local_149 = uint(_e979);
        uint _e982 = local_149;
        out_1.Store(_e982*4, asuint(naga_f2i32(_e960)));
        float _e989 = points_8[int(1)][int(1)].w;
        uint _e992[2] = out_;
        local_52 = _e992;
        local_53 = uint(int(26));
        uint _e997[2] = local_52;
        local_150 = _e997;
        uint _e998 = local_53;
        uint _e1000 = local_150[1];
        local_150[1] = (_e1000 + _e998);
        uint _e1004 = local_150[0];
        local_151 = uint(_e1004);
        uint _e1008 = local_150[1];
        local_152 = uint(_e1008);
        uint _e1011 = local_152;
        out_1.Store(_e1011*4, asuint(naga_f2i32(_e989)));
    }
    changed[0][0] = int(1);
    local_54 = 1u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e1024 = local_54;
            local_54 = (_e1024 + 1u);
        }
        loop_init = false;
        uint _e1019 = local_54;
        if ((_e1019 >= 2u)) {
            break;
        }
        changed[0][min(uint(_e1019), 1u)] = ZeroValueint();
    }
    changed[int(0)][int(1)] = int(9);
    changed[1][0] = int(2);
    changed[1][1] = int(3);
    local_55 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e1054 = local_55;
            local_55 = (_e1054 + 1u);
        }
        loop_init_1 = false;
        uint _e1039 = local_55;
        if ((_e1039 >= 2u)) {
            break;
        }
        local_56 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e1051 = local_56;
                local_56 = (_e1051 + 1u);
            }
            loop_init_2 = false;
            uint _e1046 = local_56;
            if ((_e1046 >= 3u)) {
                break;
            }
            nested_empty[min(uint(_e1039), 1u)][min(uint(_e1046), 2u)] = ZeroValueint();
        }
    }
    partial[0][0] = int(1);
    local_57 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e1068 = local_57;
            local_57 = (_e1068 + 1u);
        }
        loop_init_3 = false;
        uint _e1063 = local_57;
        if ((_e1063 >= 3u)) {
            break;
        }
        partial[0][min(uint(_e1063), 2u)] = ZeroValueint();
    }
    local_58 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e1087 = local_58;
            local_58 = (_e1087 + 1u);
        }
        loop_init_4 = false;
        uint _e1073 = local_58;
        if ((_e1073 >= 2u)) {
            break;
        }
        local_59 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e1084 = local_59;
                local_59 = (_e1084 + 1u);
            }
            loop_init_5 = false;
            uint _e1079 = local_59;
            if ((_e1079 >= 3u)) {
                break;
            }
            partial[min(uint(_e1073), 1u)][min(uint(_e1079), 2u)] = ZeroValueint();
        }
    }
    volume[0][0][0] = int(1);
    local_60 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e1102 = local_60;
            local_60 = (_e1102 + 1u);
        }
        loop_init_6 = false;
        uint _e1097 = local_60;
        if ((_e1097 >= 3u)) {
            break;
        }
        volume[0][0][min(uint(_e1097), 2u)] = ZeroValueint();
    }
    local_61 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e1121 = local_61;
            local_61 = (_e1121 + 1u);
        }
        loop_init_7 = false;
        uint _e1107 = local_61;
        if ((_e1107 >= 2u)) {
            break;
        }
        local_62 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e1118 = local_62;
                local_62 = (_e1118 + 1u);
            }
            loop_init_8 = false;
            uint _e1113 = local_62;
            if ((_e1113 >= 3u)) {
                break;
            }
            volume[0][min(uint(_e1107), 1u)][min(uint(_e1113), 2u)] = ZeroValueint();
        }
    }
    local_63 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e1149 = local_63;
            local_63 = (_e1149 + 1u);
        }
        loop_init_9 = false;
        uint _e1126 = local_63;
        if ((_e1126 >= 2u)) {
            break;
        }
        local_64 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e1146 = local_64;
                local_64 = (_e1146 + 1u);
            }
            loop_init_10 = false;
            uint _e1132 = local_64;
            if ((_e1132 >= 2u)) {
                break;
            }
            local_65 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e1143 = local_65;
                    local_65 = (_e1143 + 1u);
                }
                loop_init_11 = false;
                uint _e1138 = local_65;
                if ((_e1138 >= 3u)) {
                    break;
                }
                volume[min(uint(_e1126), 1u)][min(uint(_e1132), 1u)][min(uint(_e1138), 2u)] = ZeroValueint();
            }
        }
    }
    int _e1156 = changed[int(0)][int(1)];
    shared_values[int(1)][int(2)] = _e1156;
    int _e1166 = changed[int(1)][int(0)];
    int _e1171 = changed[int(1)][int(1)];
    shared_points[int(1)][int(0)] = Constructfloat3_(float(_e1166), float(_e1171), float(int(4)));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    int _e1191 = shared_values[int(1)][int(2)];
    int _e1192 = nested_empty[int(1)][int(2)];
    int _e1198 = partial[int(1)][int(2)];
    int _e1206 = volume[int(1)][int(1)][int(2)];
    uint _e1209[2] = out_;
    local_66 = _e1209;
    local_67 = uint(int(27));
    uint _e1214[2] = local_66;
    local_153 = _e1214;
    uint _e1215 = local_67;
    uint _e1217 = local_153[1];
    local_153[1] = (_e1217 + _e1215);
    uint _e1221 = local_153[0];
    local_154 = uint(_e1221);
    uint _e1225 = local_153[1];
    local_155 = uint(_e1225);
    uint _e1228 = local_155;
    out_1.Store(_e1228*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e1191) + asuint(_e1192))) + asuint(_e1198))) + asuint(_e1206))));
    float _e1235 = shared_points[int(1)][int(0)].x;
    uint _e1238[2] = out_;
    local_68 = _e1238;
    local_69 = uint(int(28));
    uint _e1243[2] = local_68;
    local_156 = _e1243;
    uint _e1244 = local_69;
    uint _e1246 = local_156[1];
    local_156[1] = (_e1246 + _e1244);
    uint _e1250 = local_156[0];
    local_157 = uint(_e1250);
    uint _e1254 = local_156[1];
    local_158 = uint(_e1254);
    uint _e1257 = local_158;
    out_1.Store(_e1257*4, asuint(naga_f2i32(_e1235)));
    float _e1264 = shared_points[int(1)][int(0)].y;
    uint _e1267[2] = out_;
    local_70 = _e1267;
    local_71 = uint(int(29));
    uint _e1272[2] = local_70;
    local_159 = _e1272;
    uint _e1273 = local_71;
    uint _e1275 = local_159[1];
    local_159[1] = (_e1275 + _e1273);
    uint _e1279 = local_159[0];
    local_160 = uint(_e1279);
    uint _e1283 = local_159[1];
    local_161 = uint(_e1283);
    uint _e1286 = local_161;
    out_1.Store(_e1286*4, asuint(naga_f2i32(_e1264)));
}
