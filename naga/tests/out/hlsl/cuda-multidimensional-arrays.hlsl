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
    uint local = (uint)0;
    int2 original = (int2)0;
    int2 points[2][2] = (int2[2][2])0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int3_ original_1 = (int3_)0;
    int3_ points_1[2][2] = (int3_[2][2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    int4 original_2 = (int4)0;
    int4 points_2[2][2] = (int4[2][2])0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint2 original_3 = (uint2)0;
    uint2 points_3[2][2] = (uint2[2][2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint3_ original_4 = (uint3_)0;
    uint3_ points_4[2][2] = (uint3_[2][2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint4 original_5 = (uint4)0;
    uint4 points_5[2][2] = (uint4[2][2])0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    float2 original_6 = (float2)0;
    float2 points_6[2][2] = (float2[2][2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    float3_ original_7 = (float3_)0;
    float3_ points_7[2][2] = (float3_[2][2])0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    float4 original_8 = (float4)0;
    float4 points_8[2][2] = (float4[2][2])0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    int changed[2][2] = (int[2][2])0;
    uint local_82 = (uint)0;
    int nested_empty[2][3] = (int[2][3])0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    int partial[2][3] = (int[2][3])0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    int volume[2][2][3] = (int[2][2][3])0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;

    local = 0u;
    {
        original.x = int(1);
        original.y = int(2);
        int2 _e10 = original;
        points[0][0] = _e10;
        points[0][1] = ZeroValueint2();
        int2 _e15 = original;
        points[1][0] = _e15;
        points[1][1].x = int(5);
        points[1][1].y = ZeroValueint();
        int _e26 = points[int(0)][int(0)].y;
        uint _e27 = local;
        local_1 = _e27;
        uint _e29 = local_1;
        local_2 = uint(_e29);
        local_3 = uint(int(0));
        uint _e36 = local_2;
        uint _e37 = local_3;
        local_103 = uint((_e36 + _e37));
        uint _e41 = local_103;
        out_.Store(_e41*4, asuint(_e26));
        int _e48 = points[int(1)][int(1)].x;
        uint _e49 = local;
        local_4 = _e49;
        uint _e51 = local_4;
        local_5 = uint(_e51);
        local_6 = uint(int(1));
        uint _e57 = local_5;
        uint _e58 = local_6;
        local_104 = uint((_e57 + _e58));
        uint _e62 = local_104;
        out_.Store(_e62*4, asuint(_e48));
        int _e69 = points[int(1)][int(1)].y;
        uint _e70 = local;
        local_7 = _e70;
        uint _e72 = local_7;
        local_8 = uint(_e72);
        local_9 = uint(int(2));
        uint _e78 = local_8;
        uint _e79 = local_9;
        local_105 = uint((_e78 + _e79));
        uint _e83 = local_105;
        out_.Store(_e83*4, asuint(_e69));
    }
    {
        original_1.x = int(1);
        original_1.y = int(2);
        original_1.z = int(3);
        int3_ _e95 = original_1;
        points_1[0][0] = _e95;
        points_1[0][1] = ZeroValueint3_();
        int3_ _e100 = original_1;
        points_1[1][0] = _e100;
        points_1[1][1].x = int(5);
        points_1[1][1].y = ZeroValueint();
        points_1[1][1].z = ZeroValueint();
        int _e113 = points_1[int(0)][int(0)].z;
        uint _e114 = local;
        local_10 = _e114;
        uint _e116 = local_10;
        local_11 = uint(_e116);
        local_12 = uint(int(3));
        uint _e122 = local_11;
        uint _e123 = local_12;
        local_106 = uint((_e122 + _e123));
        uint _e127 = local_106;
        out_.Store(_e127*4, asuint(_e113));
        int _e134 = points_1[int(1)][int(1)].x;
        uint _e135 = local;
        local_13 = _e135;
        uint _e137 = local_13;
        local_14 = uint(_e137);
        local_15 = uint(int(4));
        uint _e143 = local_14;
        uint _e144 = local_15;
        local_107 = uint((_e143 + _e144));
        uint _e148 = local_107;
        out_.Store(_e148*4, asuint(_e134));
        int _e155 = points_1[int(1)][int(1)].z;
        uint _e156 = local;
        local_16 = _e156;
        uint _e158 = local_16;
        local_17 = uint(_e158);
        local_18 = uint(int(5));
        uint _e164 = local_17;
        uint _e165 = local_18;
        local_108 = uint((_e164 + _e165));
        uint _e169 = local_108;
        out_.Store(_e169*4, asuint(_e155));
    }
    {
        original_2.x = int(1);
        original_2.y = int(2);
        original_2.z = int(3);
        original_2.w = int(4);
        int4 _e183 = original_2;
        points_2[0][0] = _e183;
        points_2[0][1] = ZeroValueint4();
        int4 _e188 = original_2;
        points_2[1][0] = _e188;
        points_2[1][1].x = int(5);
        points_2[1][1].y = ZeroValueint();
        points_2[1][1].z = ZeroValueint();
        points_2[1][1].w = ZeroValueint();
        int _e203 = points_2[int(0)][int(0)].w;
        uint _e204 = local;
        local_19 = _e204;
        uint _e206 = local_19;
        local_20 = uint(_e206);
        local_21 = uint(int(6));
        uint _e212 = local_20;
        uint _e213 = local_21;
        local_109 = uint((_e212 + _e213));
        uint _e217 = local_109;
        out_.Store(_e217*4, asuint(_e203));
        int _e224 = points_2[int(1)][int(1)].x;
        uint _e225 = local;
        local_22 = _e225;
        uint _e227 = local_22;
        local_23 = uint(_e227);
        local_24 = uint(int(7));
        uint _e233 = local_23;
        uint _e234 = local_24;
        local_110 = uint((_e233 + _e234));
        uint _e238 = local_110;
        out_.Store(_e238*4, asuint(_e224));
        int _e245 = points_2[int(1)][int(1)].w;
        uint _e246 = local;
        local_25 = _e246;
        uint _e248 = local_25;
        local_26 = uint(_e248);
        local_27 = uint(int(8));
        uint _e254 = local_26;
        uint _e255 = local_27;
        local_111 = uint((_e254 + _e255));
        uint _e259 = local_111;
        out_.Store(_e259*4, asuint(_e245));
    }
    {
        original_3.x = uint(int(1));
        original_3.y = uint(int(2));
        uint2 _e271 = original_3;
        points_3[0][0] = _e271;
        points_3[0][1] = ZeroValueuint2();
        uint2 _e276 = original_3;
        points_3[1][0] = _e276;
        points_3[1][1].x = uint(int(5));
        points_3[1][1].y = ZeroValueuint();
        uint _e288 = points_3[int(0)][int(0)].y;
        uint _e290 = local;
        local_28 = _e290;
        uint _e292 = local_28;
        local_29 = uint(_e292);
        local_30 = uint(int(9));
        uint _e298 = local_29;
        uint _e299 = local_30;
        local_112 = uint((_e298 + _e299));
        uint _e303 = local_112;
        out_.Store(_e303*4, asuint(int(_e288)));
        uint _e310 = points_3[int(1)][int(1)].x;
        uint _e312 = local;
        local_31 = _e312;
        uint _e314 = local_31;
        local_32 = uint(_e314);
        local_33 = uint(int(10));
        uint _e320 = local_32;
        uint _e321 = local_33;
        local_113 = uint((_e320 + _e321));
        uint _e325 = local_113;
        out_.Store(_e325*4, asuint(int(_e310)));
        uint _e332 = points_3[int(1)][int(1)].y;
        uint _e334 = local;
        local_34 = _e334;
        uint _e336 = local_34;
        local_35 = uint(_e336);
        local_36 = uint(int(11));
        uint _e342 = local_35;
        uint _e343 = local_36;
        local_114 = uint((_e342 + _e343));
        uint _e347 = local_114;
        out_.Store(_e347*4, asuint(int(_e332)));
    }
    {
        original_4.x = uint(int(1));
        original_4.y = uint(int(2));
        original_4.z = uint(int(3));
        uint3_ _e362 = original_4;
        points_4[0][0] = _e362;
        points_4[0][1] = ZeroValueuint3_();
        uint3_ _e367 = original_4;
        points_4[1][0] = _e367;
        points_4[1][1].x = uint(int(5));
        points_4[1][1].y = ZeroValueuint();
        points_4[1][1].z = ZeroValueuint();
        uint _e381 = points_4[int(0)][int(0)].z;
        uint _e383 = local;
        local_37 = _e383;
        uint _e385 = local_37;
        local_38 = uint(_e385);
        local_39 = uint(int(12));
        uint _e391 = local_38;
        uint _e392 = local_39;
        local_115 = uint((_e391 + _e392));
        uint _e396 = local_115;
        out_.Store(_e396*4, asuint(int(_e381)));
        uint _e403 = points_4[int(1)][int(1)].x;
        uint _e405 = local;
        local_40 = _e405;
        uint _e407 = local_40;
        local_41 = uint(_e407);
        local_42 = uint(int(13));
        uint _e413 = local_41;
        uint _e414 = local_42;
        local_116 = uint((_e413 + _e414));
        uint _e418 = local_116;
        out_.Store(_e418*4, asuint(int(_e403)));
        uint _e425 = points_4[int(1)][int(1)].z;
        uint _e427 = local;
        local_43 = _e427;
        uint _e429 = local_43;
        local_44 = uint(_e429);
        local_45 = uint(int(14));
        uint _e435 = local_44;
        uint _e436 = local_45;
        local_117 = uint((_e435 + _e436));
        uint _e440 = local_117;
        out_.Store(_e440*4, asuint(int(_e425)));
    }
    {
        original_5.x = uint(int(1));
        original_5.y = uint(int(2));
        original_5.z = uint(int(3));
        original_5.w = uint(int(4));
        uint4 _e458 = original_5;
        points_5[0][0] = _e458;
        points_5[0][1] = ZeroValueuint4();
        uint4 _e463 = original_5;
        points_5[1][0] = _e463;
        points_5[1][1].x = uint(int(5));
        points_5[1][1].y = ZeroValueuint();
        points_5[1][1].z = ZeroValueuint();
        points_5[1][1].w = ZeroValueuint();
        uint _e479 = points_5[int(0)][int(0)].w;
        uint _e481 = local;
        local_46 = _e481;
        uint _e483 = local_46;
        local_47 = uint(_e483);
        local_48 = uint(int(15));
        uint _e489 = local_47;
        uint _e490 = local_48;
        local_118 = uint((_e489 + _e490));
        uint _e494 = local_118;
        out_.Store(_e494*4, asuint(int(_e479)));
        uint _e501 = points_5[int(1)][int(1)].x;
        uint _e503 = local;
        local_49 = _e503;
        uint _e505 = local_49;
        local_50 = uint(_e505);
        local_51 = uint(int(16));
        uint _e511 = local_50;
        uint _e512 = local_51;
        local_119 = uint((_e511 + _e512));
        uint _e516 = local_119;
        out_.Store(_e516*4, asuint(int(_e501)));
        uint _e523 = points_5[int(1)][int(1)].w;
        uint _e525 = local;
        local_52 = _e525;
        uint _e527 = local_52;
        local_53 = uint(_e527);
        local_54 = uint(int(17));
        uint _e533 = local_53;
        uint _e534 = local_54;
        local_120 = uint((_e533 + _e534));
        uint _e538 = local_120;
        out_.Store(_e538*4, asuint(int(_e523)));
    }
    {
        original_6.x = float(int(1));
        original_6.y = float(int(2));
        float2 _e550 = original_6;
        points_6[0][0] = _e550;
        points_6[0][1] = ZeroValuefloat2();
        float2 _e555 = original_6;
        points_6[1][0] = _e555;
        points_6[1][1].x = float(int(5));
        points_6[1][1].y = ZeroValuefloat();
        float _e567 = points_6[int(0)][int(0)].y;
        uint _e569 = local;
        local_55 = _e569;
        uint _e571 = local_55;
        local_56 = uint(_e571);
        local_57 = uint(int(18));
        uint _e577 = local_56;
        uint _e578 = local_57;
        local_121 = uint((_e577 + _e578));
        uint _e582 = local_121;
        out_.Store(_e582*4, asuint(naga_f2i32(_e567)));
        float _e589 = points_6[int(1)][int(1)].x;
        uint _e591 = local;
        local_58 = _e591;
        uint _e593 = local_58;
        local_59 = uint(_e593);
        local_60 = uint(int(19));
        uint _e599 = local_59;
        uint _e600 = local_60;
        local_122 = uint((_e599 + _e600));
        uint _e604 = local_122;
        out_.Store(_e604*4, asuint(naga_f2i32(_e589)));
        float _e611 = points_6[int(1)][int(1)].y;
        uint _e613 = local;
        local_61 = _e613;
        uint _e615 = local_61;
        local_62 = uint(_e615);
        local_63 = uint(int(20));
        uint _e621 = local_62;
        uint _e622 = local_63;
        local_123 = uint((_e621 + _e622));
        uint _e626 = local_123;
        out_.Store(_e626*4, asuint(naga_f2i32(_e611)));
    }
    {
        original_7.x = float(int(1));
        original_7.y = float(int(2));
        original_7.z = float(int(3));
        float3_ _e641 = original_7;
        points_7[0][0] = _e641;
        points_7[0][1] = ZeroValuefloat3_();
        float3_ _e646 = original_7;
        points_7[1][0] = _e646;
        points_7[1][1].x = float(int(5));
        points_7[1][1].y = ZeroValuefloat();
        points_7[1][1].z = ZeroValuefloat();
        float _e660 = points_7[int(0)][int(0)].z;
        uint _e662 = local;
        local_64 = _e662;
        uint _e664 = local_64;
        local_65 = uint(_e664);
        local_66 = uint(int(21));
        uint _e670 = local_65;
        uint _e671 = local_66;
        local_124 = uint((_e670 + _e671));
        uint _e675 = local_124;
        out_.Store(_e675*4, asuint(naga_f2i32(_e660)));
        float _e682 = points_7[int(1)][int(1)].x;
        uint _e684 = local;
        local_67 = _e684;
        uint _e686 = local_67;
        local_68 = uint(_e686);
        local_69 = uint(int(22));
        uint _e692 = local_68;
        uint _e693 = local_69;
        local_125 = uint((_e692 + _e693));
        uint _e697 = local_125;
        out_.Store(_e697*4, asuint(naga_f2i32(_e682)));
        float _e704 = points_7[int(1)][int(1)].z;
        uint _e706 = local;
        local_70 = _e706;
        uint _e708 = local_70;
        local_71 = uint(_e708);
        local_72 = uint(int(23));
        uint _e714 = local_71;
        uint _e715 = local_72;
        local_126 = uint((_e714 + _e715));
        uint _e719 = local_126;
        out_.Store(_e719*4, asuint(naga_f2i32(_e704)));
    }
    {
        original_8.x = float(int(1));
        original_8.y = float(int(2));
        original_8.z = float(int(3));
        original_8.w = float(int(4));
        float4 _e737 = original_8;
        points_8[0][0] = _e737;
        points_8[0][1] = ZeroValuefloat4();
        float4 _e742 = original_8;
        points_8[1][0] = _e742;
        points_8[1][1].x = float(int(5));
        points_8[1][1].y = ZeroValuefloat();
        points_8[1][1].z = ZeroValuefloat();
        points_8[1][1].w = ZeroValuefloat();
        float _e758 = points_8[int(0)][int(0)].w;
        uint _e760 = local;
        local_73 = _e760;
        uint _e762 = local_73;
        local_74 = uint(_e762);
        local_75 = uint(int(24));
        uint _e768 = local_74;
        uint _e769 = local_75;
        local_127 = uint((_e768 + _e769));
        uint _e773 = local_127;
        out_.Store(_e773*4, asuint(naga_f2i32(_e758)));
        float _e780 = points_8[int(1)][int(1)].x;
        uint _e782 = local;
        local_76 = _e782;
        uint _e784 = local_76;
        local_77 = uint(_e784);
        local_78 = uint(int(25));
        uint _e790 = local_77;
        uint _e791 = local_78;
        local_128 = uint((_e790 + _e791));
        uint _e795 = local_128;
        out_.Store(_e795*4, asuint(naga_f2i32(_e780)));
        float _e802 = points_8[int(1)][int(1)].w;
        uint _e804 = local;
        local_79 = _e804;
        uint _e806 = local_79;
        local_80 = uint(_e806);
        local_81 = uint(int(26));
        uint _e812 = local_80;
        uint _e813 = local_81;
        local_129 = uint((_e812 + _e813));
        uint _e817 = local_129;
        out_.Store(_e817*4, asuint(naga_f2i32(_e802)));
    }
    changed[0][0] = int(1);
    local_82 = 1u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e830 = local_82;
            local_82 = (_e830 + 1u);
        }
        loop_init = false;
        uint _e825 = local_82;
        if ((_e825 >= 2u)) {
            break;
        }
        changed[0][min(uint(_e825), 1u)] = ZeroValueint();
    }
    changed[int(0)][int(1)] = int(9);
    changed[1][0] = int(2);
    changed[1][1] = int(3);
    local_83 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e860 = local_83;
            local_83 = (_e860 + 1u);
        }
        loop_init_1 = false;
        uint _e845 = local_83;
        if ((_e845 >= 2u)) {
            break;
        }
        local_84 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e857 = local_84;
                local_84 = (_e857 + 1u);
            }
            loop_init_2 = false;
            uint _e852 = local_84;
            if ((_e852 >= 3u)) {
                break;
            }
            nested_empty[min(uint(_e845), 1u)][min(uint(_e852), 2u)] = ZeroValueint();
        }
    }
    partial[0][0] = int(1);
    local_85 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e874 = local_85;
            local_85 = (_e874 + 1u);
        }
        loop_init_3 = false;
        uint _e869 = local_85;
        if ((_e869 >= 3u)) {
            break;
        }
        partial[0][min(uint(_e869), 2u)] = ZeroValueint();
    }
    local_86 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e893 = local_86;
            local_86 = (_e893 + 1u);
        }
        loop_init_4 = false;
        uint _e879 = local_86;
        if ((_e879 >= 2u)) {
            break;
        }
        local_87 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e890 = local_87;
                local_87 = (_e890 + 1u);
            }
            loop_init_5 = false;
            uint _e885 = local_87;
            if ((_e885 >= 3u)) {
                break;
            }
            partial[min(uint(_e879), 1u)][min(uint(_e885), 2u)] = ZeroValueint();
        }
    }
    volume[0][0][0] = int(1);
    local_88 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e908 = local_88;
            local_88 = (_e908 + 1u);
        }
        loop_init_6 = false;
        uint _e903 = local_88;
        if ((_e903 >= 3u)) {
            break;
        }
        volume[0][0][min(uint(_e903), 2u)] = ZeroValueint();
    }
    local_89 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e927 = local_89;
            local_89 = (_e927 + 1u);
        }
        loop_init_7 = false;
        uint _e913 = local_89;
        if ((_e913 >= 2u)) {
            break;
        }
        local_90 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e924 = local_90;
                local_90 = (_e924 + 1u);
            }
            loop_init_8 = false;
            uint _e919 = local_90;
            if ((_e919 >= 3u)) {
                break;
            }
            volume[0][min(uint(_e913), 1u)][min(uint(_e919), 2u)] = ZeroValueint();
        }
    }
    local_91 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e955 = local_91;
            local_91 = (_e955 + 1u);
        }
        loop_init_9 = false;
        uint _e932 = local_91;
        if ((_e932 >= 2u)) {
            break;
        }
        local_92 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e952 = local_92;
                local_92 = (_e952 + 1u);
            }
            loop_init_10 = false;
            uint _e938 = local_92;
            if ((_e938 >= 2u)) {
                break;
            }
            local_93 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e949 = local_93;
                    local_93 = (_e949 + 1u);
                }
                loop_init_11 = false;
                uint _e944 = local_93;
                if ((_e944 >= 3u)) {
                    break;
                }
                volume[min(uint(_e932), 1u)][min(uint(_e938), 1u)][min(uint(_e944), 2u)] = ZeroValueint();
            }
        }
    }
    int _e962 = changed[int(0)][int(1)];
    shared_values[int(1)][int(2)] = _e962;
    int _e972 = changed[int(1)][int(0)];
    int _e977 = changed[int(1)][int(1)];
    shared_points[int(1)][int(0)] = Constructfloat3_(float(_e972), float(_e977), float(int(4)));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    int _e997 = shared_values[int(1)][int(2)];
    int _e998 = nested_empty[int(1)][int(2)];
    int _e1004 = partial[int(1)][int(2)];
    int _e1012 = volume[int(1)][int(1)][int(2)];
    uint _e1014 = local;
    local_94 = _e1014;
    uint _e1016 = local_94;
    local_95 = uint(_e1016);
    local_96 = uint(int(27));
    uint _e1022 = local_95;
    uint _e1023 = local_96;
    local_130 = uint((_e1022 + _e1023));
    uint _e1027 = local_130;
    out_.Store(_e1027*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e997) + asuint(_e998))) + asuint(_e1004))) + asuint(_e1012))));
    float _e1034 = shared_points[int(1)][int(0)].x;
    uint _e1036 = local;
    local_97 = _e1036;
    uint _e1038 = local_97;
    local_98 = uint(_e1038);
    local_99 = uint(int(28));
    uint _e1044 = local_98;
    uint _e1045 = local_99;
    local_131 = uint((_e1044 + _e1045));
    uint _e1049 = local_131;
    out_.Store(_e1049*4, asuint(naga_f2i32(_e1034)));
    float _e1056 = shared_points[int(1)][int(0)].y;
    uint _e1058 = local;
    local_100 = _e1058;
    uint _e1060 = local_100;
    local_101 = uint(_e1060);
    local_102 = uint(int(29));
    uint _e1066 = local_101;
    uint _e1067 = local_102;
    local_132 = uint((_e1066 + _e1067));
    uint _e1071 = local_132;
    out_.Store(_e1071*4, asuint(naga_f2i32(_e1056)));
}
