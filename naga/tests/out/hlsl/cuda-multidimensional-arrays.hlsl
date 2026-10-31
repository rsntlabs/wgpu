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

RWByteAddressBuffer out_ : register(u0);
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
    uint local[2] = (uint[2])0;
    int2 original = (int2)0;
    int2 points[2][2] = (int2[2][2])0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    int3_ original_1 = (int3_)0;
    int3_ points_1[2][2] = (int3_[2][2])0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    int4 original_2 = (int4)0;
    int4 points_2[2][2] = (int4[2][2])0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint2 original_3 = (uint2)0;
    uint2 points_3[2][2] = (uint2[2][2])0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint3_ original_4 = (uint3_)0;
    uint3_ points_4[2][2] = (uint3_[2][2])0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint4 original_5 = (uint4)0;
    uint4 points_5[2][2] = (uint4[2][2])0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    float2 original_6 = (float2)0;
    float2 points_6[2][2] = (float2[2][2])0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    float3_ original_7 = (float3_)0;
    float3_ points_7[2][2] = (float3_[2][2])0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    float4 original_8 = (float4)0;
    float4 points_8[2][2] = (float4[2][2])0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    int changed[2][2] = (int[2][2])0;
    uint local_55 = (uint)0;
    int nested_empty[2][3] = (int[2][3])0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    int partial[2][3] = (int[2][3])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    int volume[2][2][3] = (int[2][2][3])0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67[2] = (uint[2])0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73[2] = (uint[2])0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76[2] = (uint[2])0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79[2] = (uint[2])0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82[2] = (uint[2])0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85[2] = (uint[2])0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88[2] = (uint[2])0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91[2] = (uint[2])0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94[2] = (uint[2])0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97[2] = (uint[2])0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100[2] = (uint[2])0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103[2] = (uint[2])0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106[2] = (uint[2])0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109[2] = (uint[2])0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112[2] = (uint[2])0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115[2] = (uint[2])0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118[2] = (uint[2])0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121[2] = (uint[2])0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124[2] = (uint[2])0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127[2] = (uint[2])0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130[2] = (uint[2])0;
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;
    uint local_133[2] = (uint[2])0;
    uint local_134 = (uint)0;
    uint local_135 = (uint)0;
    uint local_136[2] = (uint[2])0;
    uint local_137 = (uint)0;
    uint local_138 = (uint)0;
    uint local_139[2] = (uint[2])0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142[2] = (uint[2])0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145[2] = (uint[2])0;
    uint local_146 = (uint)0;
    uint local_147 = (uint)0;
    uint local_148[2] = (uint[2])0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151[2] = (uint[2])0;
    uint local_152 = (uint)0;
    uint local_153 = (uint)0;
    uint local_154[2] = (uint[2])0;
    uint local_155 = (uint)0;
    uint local_156 = (uint)0;
    uint local_157[2] = (uint[2])0;
    uint local_158 = (uint)0;
    uint local_159 = (uint)0;
    uint local_160[2] = (uint[2])0;
    uint local_161 = (uint)0;
    uint local_162 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
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
        uint _e34[2] = local;
        local_1 = _e34;
        local_2 = uint(int(0));
        uint _e39[2] = local_1;
        local_73 = _e39;
        uint _e40 = local_2;
        uint _e42 = local_73[1];
        local_73[1] = (_e42 + _e40);
        uint _e46 = local_73[0];
        local_74 = uint(_e46);
        uint _e50 = local_73[1];
        local_75 = uint(_e50);
        uint _e53 = local_75;
        out_.Store(_e53*4, asuint(_e31));
        int _e60 = points[int(1)][int(1)].x;
        uint _e62[2] = local;
        local_3 = _e62;
        local_4 = uint(int(1));
        uint _e67[2] = local_3;
        local_76 = _e67;
        uint _e68 = local_4;
        uint _e70 = local_76[1];
        local_76[1] = (_e70 + _e68);
        uint _e74 = local_76[0];
        local_77 = uint(_e74);
        uint _e78 = local_76[1];
        local_78 = uint(_e78);
        uint _e81 = local_78;
        out_.Store(_e81*4, asuint(_e60));
        int _e88 = points[int(1)][int(1)].y;
        uint _e90[2] = local;
        local_5 = _e90;
        local_6 = uint(int(2));
        uint _e95[2] = local_5;
        local_79 = _e95;
        uint _e96 = local_6;
        uint _e98 = local_79[1];
        local_79[1] = (_e98 + _e96);
        uint _e102 = local_79[0];
        local_80 = uint(_e102);
        uint _e106 = local_79[1];
        local_81 = uint(_e106);
        uint _e109 = local_81;
        out_.Store(_e109*4, asuint(_e88));
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
        uint _e141[2] = local;
        local_7 = _e141;
        local_8 = uint(int(3));
        uint _e146[2] = local_7;
        local_82 = _e146;
        uint _e147 = local_8;
        uint _e149 = local_82[1];
        local_82[1] = (_e149 + _e147);
        uint _e153 = local_82[0];
        local_83 = uint(_e153);
        uint _e157 = local_82[1];
        local_84 = uint(_e157);
        uint _e160 = local_84;
        out_.Store(_e160*4, asuint(_e139));
        int _e167 = points_1[int(1)][int(1)].x;
        uint _e169[2] = local;
        local_9 = _e169;
        local_10 = uint(int(4));
        uint _e174[2] = local_9;
        local_85 = _e174;
        uint _e175 = local_10;
        uint _e177 = local_85[1];
        local_85[1] = (_e177 + _e175);
        uint _e181 = local_85[0];
        local_86 = uint(_e181);
        uint _e185 = local_85[1];
        local_87 = uint(_e185);
        uint _e188 = local_87;
        out_.Store(_e188*4, asuint(_e167));
        int _e195 = points_1[int(1)][int(1)].z;
        uint _e197[2] = local;
        local_11 = _e197;
        local_12 = uint(int(5));
        uint _e202[2] = local_11;
        local_88 = _e202;
        uint _e203 = local_12;
        uint _e205 = local_88[1];
        local_88[1] = (_e205 + _e203);
        uint _e209 = local_88[0];
        local_89 = uint(_e209);
        uint _e213 = local_88[1];
        local_90 = uint(_e213);
        uint _e216 = local_90;
        out_.Store(_e216*4, asuint(_e195));
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
        uint _e252[2] = local;
        local_13 = _e252;
        local_14 = uint(int(6));
        uint _e257[2] = local_13;
        local_91 = _e257;
        uint _e258 = local_14;
        uint _e260 = local_91[1];
        local_91[1] = (_e260 + _e258);
        uint _e264 = local_91[0];
        local_92 = uint(_e264);
        uint _e268 = local_91[1];
        local_93 = uint(_e268);
        uint _e271 = local_93;
        out_.Store(_e271*4, asuint(_e250));
        int _e278 = points_2[int(1)][int(1)].x;
        uint _e280[2] = local;
        local_15 = _e280;
        local_16 = uint(int(7));
        uint _e285[2] = local_15;
        local_94 = _e285;
        uint _e286 = local_16;
        uint _e288 = local_94[1];
        local_94[1] = (_e288 + _e286);
        uint _e292 = local_94[0];
        local_95 = uint(_e292);
        uint _e296 = local_94[1];
        local_96 = uint(_e296);
        uint _e299 = local_96;
        out_.Store(_e299*4, asuint(_e278));
        int _e306 = points_2[int(1)][int(1)].w;
        uint _e308[2] = local;
        local_17 = _e308;
        local_18 = uint(int(8));
        uint _e313[2] = local_17;
        local_97 = _e313;
        uint _e314 = local_18;
        uint _e316 = local_97[1];
        local_97[1] = (_e316 + _e314);
        uint _e320 = local_97[0];
        local_98 = uint(_e320);
        uint _e324 = local_97[1];
        local_99 = uint(_e324);
        uint _e327 = local_99;
        out_.Store(_e327*4, asuint(_e306));
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
        uint _e359[2] = local;
        local_19 = _e359;
        local_20 = uint(int(9));
        uint _e364[2] = local_19;
        local_100 = _e364;
        uint _e365 = local_20;
        uint _e367 = local_100[1];
        local_100[1] = (_e367 + _e365);
        uint _e371 = local_100[0];
        local_101 = uint(_e371);
        uint _e375 = local_100[1];
        local_102 = uint(_e375);
        uint _e378 = local_102;
        out_.Store(_e378*4, asuint(int(_e356)));
        uint _e385 = points_3[int(1)][int(1)].x;
        uint _e388[2] = local;
        local_21 = _e388;
        local_22 = uint(int(10));
        uint _e393[2] = local_21;
        local_103 = _e393;
        uint _e394 = local_22;
        uint _e396 = local_103[1];
        local_103[1] = (_e396 + _e394);
        uint _e400 = local_103[0];
        local_104 = uint(_e400);
        uint _e404 = local_103[1];
        local_105 = uint(_e404);
        uint _e407 = local_105;
        out_.Store(_e407*4, asuint(int(_e385)));
        uint _e414 = points_3[int(1)][int(1)].y;
        uint _e417[2] = local;
        local_23 = _e417;
        local_24 = uint(int(11));
        uint _e422[2] = local_23;
        local_106 = _e422;
        uint _e423 = local_24;
        uint _e425 = local_106[1];
        local_106[1] = (_e425 + _e423);
        uint _e429 = local_106[0];
        local_107 = uint(_e429);
        uint _e433 = local_106[1];
        local_108 = uint(_e433);
        uint _e436 = local_108;
        out_.Store(_e436*4, asuint(int(_e414)));
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
        uint _e473[2] = local;
        local_25 = _e473;
        local_26 = uint(int(12));
        uint _e478[2] = local_25;
        local_109 = _e478;
        uint _e479 = local_26;
        uint _e481 = local_109[1];
        local_109[1] = (_e481 + _e479);
        uint _e485 = local_109[0];
        local_110 = uint(_e485);
        uint _e489 = local_109[1];
        local_111 = uint(_e489);
        uint _e492 = local_111;
        out_.Store(_e492*4, asuint(int(_e470)));
        uint _e499 = points_4[int(1)][int(1)].x;
        uint _e502[2] = local;
        local_27 = _e502;
        local_28 = uint(int(13));
        uint _e507[2] = local_27;
        local_112 = _e507;
        uint _e508 = local_28;
        uint _e510 = local_112[1];
        local_112[1] = (_e510 + _e508);
        uint _e514 = local_112[0];
        local_113 = uint(_e514);
        uint _e518 = local_112[1];
        local_114 = uint(_e518);
        uint _e521 = local_114;
        out_.Store(_e521*4, asuint(int(_e499)));
        uint _e528 = points_4[int(1)][int(1)].z;
        uint _e531[2] = local;
        local_29 = _e531;
        local_30 = uint(int(14));
        uint _e536[2] = local_29;
        local_115 = _e536;
        uint _e537 = local_30;
        uint _e539 = local_115[1];
        local_115[1] = (_e539 + _e537);
        uint _e543 = local_115[0];
        local_116 = uint(_e543);
        uint _e547 = local_115[1];
        local_117 = uint(_e547);
        uint _e550 = local_117;
        out_.Store(_e550*4, asuint(int(_e528)));
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
        uint _e592[2] = local;
        local_31 = _e592;
        local_32 = uint(int(15));
        uint _e597[2] = local_31;
        local_118 = _e597;
        uint _e598 = local_32;
        uint _e600 = local_118[1];
        local_118[1] = (_e600 + _e598);
        uint _e604 = local_118[0];
        local_119 = uint(_e604);
        uint _e608 = local_118[1];
        local_120 = uint(_e608);
        uint _e611 = local_120;
        out_.Store(_e611*4, asuint(int(_e589)));
        uint _e618 = points_5[int(1)][int(1)].x;
        uint _e621[2] = local;
        local_33 = _e621;
        local_34 = uint(int(16));
        uint _e626[2] = local_33;
        local_121 = _e626;
        uint _e627 = local_34;
        uint _e629 = local_121[1];
        local_121[1] = (_e629 + _e627);
        uint _e633 = local_121[0];
        local_122 = uint(_e633);
        uint _e637 = local_121[1];
        local_123 = uint(_e637);
        uint _e640 = local_123;
        out_.Store(_e640*4, asuint(int(_e618)));
        uint _e647 = points_5[int(1)][int(1)].w;
        uint _e650[2] = local;
        local_35 = _e650;
        local_36 = uint(int(17));
        uint _e655[2] = local_35;
        local_124 = _e655;
        uint _e656 = local_36;
        uint _e658 = local_124[1];
        local_124[1] = (_e658 + _e656);
        uint _e662 = local_124[0];
        local_125 = uint(_e662);
        uint _e666 = local_124[1];
        local_126 = uint(_e666);
        uint _e669 = local_126;
        out_.Store(_e669*4, asuint(int(_e647)));
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
        uint _e701[2] = local;
        local_37 = _e701;
        local_38 = uint(int(18));
        uint _e706[2] = local_37;
        local_127 = _e706;
        uint _e707 = local_38;
        uint _e709 = local_127[1];
        local_127[1] = (_e709 + _e707);
        uint _e713 = local_127[0];
        local_128 = uint(_e713);
        uint _e717 = local_127[1];
        local_129 = uint(_e717);
        uint _e720 = local_129;
        out_.Store(_e720*4, asuint(naga_f2i32(_e698)));
        float _e727 = points_6[int(1)][int(1)].x;
        uint _e730[2] = local;
        local_39 = _e730;
        local_40 = uint(int(19));
        uint _e735[2] = local_39;
        local_130 = _e735;
        uint _e736 = local_40;
        uint _e738 = local_130[1];
        local_130[1] = (_e738 + _e736);
        uint _e742 = local_130[0];
        local_131 = uint(_e742);
        uint _e746 = local_130[1];
        local_132 = uint(_e746);
        uint _e749 = local_132;
        out_.Store(_e749*4, asuint(naga_f2i32(_e727)));
        float _e756 = points_6[int(1)][int(1)].y;
        uint _e759[2] = local;
        local_41 = _e759;
        local_42 = uint(int(20));
        uint _e764[2] = local_41;
        local_133 = _e764;
        uint _e765 = local_42;
        uint _e767 = local_133[1];
        local_133[1] = (_e767 + _e765);
        uint _e771 = local_133[0];
        local_134 = uint(_e771);
        uint _e775 = local_133[1];
        local_135 = uint(_e775);
        uint _e778 = local_135;
        out_.Store(_e778*4, asuint(naga_f2i32(_e756)));
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
        uint _e815[2] = local;
        local_43 = _e815;
        local_44 = uint(int(21));
        uint _e820[2] = local_43;
        local_136 = _e820;
        uint _e821 = local_44;
        uint _e823 = local_136[1];
        local_136[1] = (_e823 + _e821);
        uint _e827 = local_136[0];
        local_137 = uint(_e827);
        uint _e831 = local_136[1];
        local_138 = uint(_e831);
        uint _e834 = local_138;
        out_.Store(_e834*4, asuint(naga_f2i32(_e812)));
        float _e841 = points_7[int(1)][int(1)].x;
        uint _e844[2] = local;
        local_45 = _e844;
        local_46 = uint(int(22));
        uint _e849[2] = local_45;
        local_139 = _e849;
        uint _e850 = local_46;
        uint _e852 = local_139[1];
        local_139[1] = (_e852 + _e850);
        uint _e856 = local_139[0];
        local_140 = uint(_e856);
        uint _e860 = local_139[1];
        local_141 = uint(_e860);
        uint _e863 = local_141;
        out_.Store(_e863*4, asuint(naga_f2i32(_e841)));
        float _e870 = points_7[int(1)][int(1)].z;
        uint _e873[2] = local;
        local_47 = _e873;
        local_48 = uint(int(23));
        uint _e878[2] = local_47;
        local_142 = _e878;
        uint _e879 = local_48;
        uint _e881 = local_142[1];
        local_142[1] = (_e881 + _e879);
        uint _e885 = local_142[0];
        local_143 = uint(_e885);
        uint _e889 = local_142[1];
        local_144 = uint(_e889);
        uint _e892 = local_144;
        out_.Store(_e892*4, asuint(naga_f2i32(_e870)));
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
        uint _e934[2] = local;
        local_49 = _e934;
        local_50 = uint(int(24));
        uint _e939[2] = local_49;
        local_145 = _e939;
        uint _e940 = local_50;
        uint _e942 = local_145[1];
        local_145[1] = (_e942 + _e940);
        uint _e946 = local_145[0];
        local_146 = uint(_e946);
        uint _e950 = local_145[1];
        local_147 = uint(_e950);
        uint _e953 = local_147;
        out_.Store(_e953*4, asuint(naga_f2i32(_e931)));
        float _e960 = points_8[int(1)][int(1)].x;
        uint _e963[2] = local;
        local_51 = _e963;
        local_52 = uint(int(25));
        uint _e968[2] = local_51;
        local_148 = _e968;
        uint _e969 = local_52;
        uint _e971 = local_148[1];
        local_148[1] = (_e971 + _e969);
        uint _e975 = local_148[0];
        local_149 = uint(_e975);
        uint _e979 = local_148[1];
        local_150 = uint(_e979);
        uint _e982 = local_150;
        out_.Store(_e982*4, asuint(naga_f2i32(_e960)));
        float _e989 = points_8[int(1)][int(1)].w;
        uint _e992[2] = local;
        local_53 = _e992;
        local_54 = uint(int(26));
        uint _e997[2] = local_53;
        local_151 = _e997;
        uint _e998 = local_54;
        uint _e1000 = local_151[1];
        local_151[1] = (_e1000 + _e998);
        uint _e1004 = local_151[0];
        local_152 = uint(_e1004);
        uint _e1008 = local_151[1];
        local_153 = uint(_e1008);
        uint _e1011 = local_153;
        out_.Store(_e1011*4, asuint(naga_f2i32(_e989)));
    }
    changed[0][0] = int(1);
    local_55 = 1u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e1024 = local_55;
            local_55 = (_e1024 + 1u);
        }
        loop_init = false;
        uint _e1019 = local_55;
        if ((_e1019 >= 2u)) {
            break;
        }
        changed[0][min(uint(_e1019), 1u)] = ZeroValueint();
    }
    changed[int(0)][int(1)] = int(9);
    changed[1][0] = int(2);
    changed[1][1] = int(3);
    local_56 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e1054 = local_56;
            local_56 = (_e1054 + 1u);
        }
        loop_init_1 = false;
        uint _e1039 = local_56;
        if ((_e1039 >= 2u)) {
            break;
        }
        local_57 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e1051 = local_57;
                local_57 = (_e1051 + 1u);
            }
            loop_init_2 = false;
            uint _e1046 = local_57;
            if ((_e1046 >= 3u)) {
                break;
            }
            nested_empty[min(uint(_e1039), 1u)][min(uint(_e1046), 2u)] = ZeroValueint();
        }
    }
    partial[0][0] = int(1);
    local_58 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e1068 = local_58;
            local_58 = (_e1068 + 1u);
        }
        loop_init_3 = false;
        uint _e1063 = local_58;
        if ((_e1063 >= 3u)) {
            break;
        }
        partial[0][min(uint(_e1063), 2u)] = ZeroValueint();
    }
    local_59 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e1087 = local_59;
            local_59 = (_e1087 + 1u);
        }
        loop_init_4 = false;
        uint _e1073 = local_59;
        if ((_e1073 >= 2u)) {
            break;
        }
        local_60 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e1084 = local_60;
                local_60 = (_e1084 + 1u);
            }
            loop_init_5 = false;
            uint _e1079 = local_60;
            if ((_e1079 >= 3u)) {
                break;
            }
            partial[min(uint(_e1073), 1u)][min(uint(_e1079), 2u)] = ZeroValueint();
        }
    }
    volume[0][0][0] = int(1);
    local_61 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e1102 = local_61;
            local_61 = (_e1102 + 1u);
        }
        loop_init_6 = false;
        uint _e1097 = local_61;
        if ((_e1097 >= 3u)) {
            break;
        }
        volume[0][0][min(uint(_e1097), 2u)] = ZeroValueint();
    }
    local_62 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e1121 = local_62;
            local_62 = (_e1121 + 1u);
        }
        loop_init_7 = false;
        uint _e1107 = local_62;
        if ((_e1107 >= 2u)) {
            break;
        }
        local_63 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e1118 = local_63;
                local_63 = (_e1118 + 1u);
            }
            loop_init_8 = false;
            uint _e1113 = local_63;
            if ((_e1113 >= 3u)) {
                break;
            }
            volume[0][min(uint(_e1107), 1u)][min(uint(_e1113), 2u)] = ZeroValueint();
        }
    }
    local_64 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e1149 = local_64;
            local_64 = (_e1149 + 1u);
        }
        loop_init_9 = false;
        uint _e1126 = local_64;
        if ((_e1126 >= 2u)) {
            break;
        }
        local_65 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e1146 = local_65;
                local_65 = (_e1146 + 1u);
            }
            loop_init_10 = false;
            uint _e1132 = local_65;
            if ((_e1132 >= 2u)) {
                break;
            }
            local_66 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e1143 = local_66;
                    local_66 = (_e1143 + 1u);
                }
                loop_init_11 = false;
                uint _e1138 = local_66;
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
    uint _e1209[2] = local;
    local_67 = _e1209;
    local_68 = uint(int(27));
    uint _e1214[2] = local_67;
    local_154 = _e1214;
    uint _e1215 = local_68;
    uint _e1217 = local_154[1];
    local_154[1] = (_e1217 + _e1215);
    uint _e1221 = local_154[0];
    local_155 = uint(_e1221);
    uint _e1225 = local_154[1];
    local_156 = uint(_e1225);
    uint _e1228 = local_156;
    out_.Store(_e1228*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e1191) + asuint(_e1192))) + asuint(_e1198))) + asuint(_e1206))));
    float _e1235 = shared_points[int(1)][int(0)].x;
    uint _e1238[2] = local;
    local_69 = _e1238;
    local_70 = uint(int(28));
    uint _e1243[2] = local_69;
    local_157 = _e1243;
    uint _e1244 = local_70;
    uint _e1246 = local_157[1];
    local_157[1] = (_e1246 + _e1244);
    uint _e1250 = local_157[0];
    local_158 = uint(_e1250);
    uint _e1254 = local_157[1];
    local_159 = uint(_e1254);
    uint _e1257 = local_159;
    out_.Store(_e1257*4, asuint(naga_f2i32(_e1235)));
    float _e1264 = shared_points[int(1)][int(0)].y;
    uint _e1267[2] = local;
    local_71 = _e1267;
    local_72 = uint(int(29));
    uint _e1272[2] = local_71;
    local_160 = _e1272;
    uint _e1273 = local_72;
    uint _e1275 = local_160[1];
    local_160[1] = (_e1275 + _e1273);
    uint _e1279 = local_160[0];
    local_161 = uint(_e1279);
    uint _e1283 = local_160[1];
    local_162 = uint(_e1283);
    uint _e1286 = local_162;
    out_.Store(_e1286*4, asuint(naga_f2i32(_e1264)));
}
