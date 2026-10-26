#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

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
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

shared int shared_values[2][3];

shared float3_ shared_points[2][2];


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
        shared_points = float3_[2][2](float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)), float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)));
    }
    memoryBarrierShared();
    barrier();
    uint local = 0u;
    ivec2 original = ivec2(0);
    ivec2 points[2][2] = ivec2[2][2](ivec2[2](ivec2(0), ivec2(0)), ivec2[2](ivec2(0), ivec2(0)));
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    int3_ original_1 = int3_(0, 0, 0);
    int3_ points_1[2][2] = int3_[2][2](int3_[2](int3_(0, 0, 0), int3_(0, 0, 0)), int3_[2](int3_(0, 0, 0), int3_(0, 0, 0)));
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    ivec4 original_2 = ivec4(0);
    ivec4 points_2[2][2] = ivec4[2][2](ivec4[2](ivec4(0), ivec4(0)), ivec4[2](ivec4(0), ivec4(0)));
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uvec2 original_3 = uvec2(0u);
    uvec2 points_3[2][2] = uvec2[2][2](uvec2[2](uvec2(0u), uvec2(0u)), uvec2[2](uvec2(0u), uvec2(0u)));
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint3_ original_4 = uint3_(0u, 0u, 0u);
    uint3_ points_4[2][2] = uint3_[2][2](uint3_[2](uint3_(0u, 0u, 0u), uint3_(0u, 0u, 0u)), uint3_[2](uint3_(0u, 0u, 0u), uint3_(0u, 0u, 0u)));
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uvec4 original_5 = uvec4(0u);
    uvec4 points_5[2][2] = uvec4[2][2](uvec4[2](uvec4(0u), uvec4(0u)), uvec4[2](uvec4(0u), uvec4(0u)));
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    vec2 original_6 = vec2(0.0);
    vec2 points_6[2][2] = vec2[2][2](vec2[2](vec2(0.0), vec2(0.0)), vec2[2](vec2(0.0), vec2(0.0)));
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    float3_ original_7 = float3_(0.0, 0.0, 0.0);
    float3_ points_7[2][2] = float3_[2][2](float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)), float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)));
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    vec4 original_8 = vec4(0.0);
    vec4 points_8[2][2] = vec4[2][2](vec4[2](vec4(0.0), vec4(0.0)), vec4[2](vec4(0.0), vec4(0.0)));
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81 = 0u;
    int changed[2][2] = int[2][2](int[2](0, 0), int[2](0, 0));
    uint local_82 = 0u;
    int nested_empty[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local_83 = 0u;
    uint local_84 = 0u;
    int partial[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87 = 0u;
    int volume[2][2][3] = int[2][2][3](int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)));
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90 = 0u;
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93 = 0u;
    uint local_94 = 0u;
    uint local_95 = 0u;
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98 = 0u;
    uint local_99 = 0u;
    uint local_100 = 0u;
    uint local_101 = 0u;
    uint local_102 = 0u;
    uint local_103 = 0u;
    uint local_104 = 0u;
    uint local_105 = 0u;
    uint local_106 = 0u;
    uint local_107 = 0u;
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110 = 0u;
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113 = 0u;
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116 = 0u;
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119 = 0u;
    uint local_120 = 0u;
    uint local_121 = 0u;
    uint local_122 = 0u;
    uint local_123 = 0u;
    uint local_124 = 0u;
    uint local_125 = 0u;
    uint local_126 = 0u;
    uint local_127 = 0u;
    uint local_128 = 0u;
    uint local_129 = 0u;
    uint local_130 = 0u;
    uint local_131 = 0u;
    uint local_132 = 0u;
    local = 0u;
    {
        original.x = 1;
        original.y = 2;
        ivec2 _e10 = original;
        points[0][0] = _e10;
        points[0][1] = ivec2(0);
        ivec2 _e15 = original;
        points[1][0] = _e15;
        points[1][1].x = 5;
        points[1][1].y = 0;
        int _e26 = points[0][0].y;
        uint _e27 = local;
        local_1 = _e27;
        uint _e29 = local_1;
        local_2 = uint(_e29);
        local_3 = uint(0);
        uint _e36 = local_2;
        uint _e37 = local_3;
        local_103 = uint((_e36 + _e37));
        uint _e41 = local_103;
        _group_0_binding_0_cs[_e41] = _e26;
        int _e48 = points[1][1].x;
        uint _e49 = local;
        local_4 = _e49;
        uint _e51 = local_4;
        local_5 = uint(_e51);
        local_6 = uint(1);
        uint _e57 = local_5;
        uint _e58 = local_6;
        local_104 = uint((_e57 + _e58));
        uint _e62 = local_104;
        _group_0_binding_0_cs[_e62] = _e48;
        int _e69 = points[1][1].y;
        uint _e70 = local;
        local_7 = _e70;
        uint _e72 = local_7;
        local_8 = uint(_e72);
        local_9 = uint(2);
        uint _e78 = local_8;
        uint _e79 = local_9;
        local_105 = uint((_e78 + _e79));
        uint _e83 = local_105;
        _group_0_binding_0_cs[_e83] = _e69;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e95 = original_1;
        points_1[0][0] = _e95;
        points_1[0][1] = int3_(0, 0, 0);
        int3_ _e100 = original_1;
        points_1[1][0] = _e100;
        points_1[1][1].x = 5;
        points_1[1][1].y = 0;
        points_1[1][1].z = 0;
        int _e113 = points_1[0][0].z;
        uint _e114 = local;
        local_10 = _e114;
        uint _e116 = local_10;
        local_11 = uint(_e116);
        local_12 = uint(3);
        uint _e122 = local_11;
        uint _e123 = local_12;
        local_106 = uint((_e122 + _e123));
        uint _e127 = local_106;
        _group_0_binding_0_cs[_e127] = _e113;
        int _e134 = points_1[1][1].x;
        uint _e135 = local;
        local_13 = _e135;
        uint _e137 = local_13;
        local_14 = uint(_e137);
        local_15 = uint(4);
        uint _e143 = local_14;
        uint _e144 = local_15;
        local_107 = uint((_e143 + _e144));
        uint _e148 = local_107;
        _group_0_binding_0_cs[_e148] = _e134;
        int _e155 = points_1[1][1].z;
        uint _e156 = local;
        local_16 = _e156;
        uint _e158 = local_16;
        local_17 = uint(_e158);
        local_18 = uint(5);
        uint _e164 = local_17;
        uint _e165 = local_18;
        local_108 = uint((_e164 + _e165));
        uint _e169 = local_108;
        _group_0_binding_0_cs[_e169] = _e155;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        ivec4 _e183 = original_2;
        points_2[0][0] = _e183;
        points_2[0][1] = ivec4(0);
        ivec4 _e188 = original_2;
        points_2[1][0] = _e188;
        points_2[1][1].x = 5;
        points_2[1][1].y = 0;
        points_2[1][1].z = 0;
        points_2[1][1].w = 0;
        int _e203 = points_2[0][0].w;
        uint _e204 = local;
        local_19 = _e204;
        uint _e206 = local_19;
        local_20 = uint(_e206);
        local_21 = uint(6);
        uint _e212 = local_20;
        uint _e213 = local_21;
        local_109 = uint((_e212 + _e213));
        uint _e217 = local_109;
        _group_0_binding_0_cs[_e217] = _e203;
        int _e224 = points_2[1][1].x;
        uint _e225 = local;
        local_22 = _e225;
        uint _e227 = local_22;
        local_23 = uint(_e227);
        local_24 = uint(7);
        uint _e233 = local_23;
        uint _e234 = local_24;
        local_110 = uint((_e233 + _e234));
        uint _e238 = local_110;
        _group_0_binding_0_cs[_e238] = _e224;
        int _e245 = points_2[1][1].w;
        uint _e246 = local;
        local_25 = _e246;
        uint _e248 = local_25;
        local_26 = uint(_e248);
        local_27 = uint(8);
        uint _e254 = local_26;
        uint _e255 = local_27;
        local_111 = uint((_e254 + _e255));
        uint _e259 = local_111;
        _group_0_binding_0_cs[_e259] = _e245;
    }
    {
        original_3.x = uint(1);
        original_3.y = uint(2);
        uvec2 _e271 = original_3;
        points_3[0][0] = _e271;
        points_3[0][1] = uvec2(0u);
        uvec2 _e276 = original_3;
        points_3[1][0] = _e276;
        points_3[1][1].x = uint(5);
        points_3[1][1].y = 0u;
        uint _e288 = points_3[0][0].y;
        uint _e290 = local;
        local_28 = _e290;
        uint _e292 = local_28;
        local_29 = uint(_e292);
        local_30 = uint(9);
        uint _e298 = local_29;
        uint _e299 = local_30;
        local_112 = uint((_e298 + _e299));
        uint _e303 = local_112;
        _group_0_binding_0_cs[_e303] = int(_e288);
        uint _e310 = points_3[1][1].x;
        uint _e312 = local;
        local_31 = _e312;
        uint _e314 = local_31;
        local_32 = uint(_e314);
        local_33 = uint(10);
        uint _e320 = local_32;
        uint _e321 = local_33;
        local_113 = uint((_e320 + _e321));
        uint _e325 = local_113;
        _group_0_binding_0_cs[_e325] = int(_e310);
        uint _e332 = points_3[1][1].y;
        uint _e334 = local;
        local_34 = _e334;
        uint _e336 = local_34;
        local_35 = uint(_e336);
        local_36 = uint(11);
        uint _e342 = local_35;
        uint _e343 = local_36;
        local_114 = uint((_e342 + _e343));
        uint _e347 = local_114;
        _group_0_binding_0_cs[_e347] = int(_e332);
    }
    {
        original_4.x = uint(1);
        original_4.y = uint(2);
        original_4.z = uint(3);
        uint3_ _e362 = original_4;
        points_4[0][0] = _e362;
        points_4[0][1] = uint3_(0u, 0u, 0u);
        uint3_ _e367 = original_4;
        points_4[1][0] = _e367;
        points_4[1][1].x = uint(5);
        points_4[1][1].y = 0u;
        points_4[1][1].z = 0u;
        uint _e381 = points_4[0][0].z;
        uint _e383 = local;
        local_37 = _e383;
        uint _e385 = local_37;
        local_38 = uint(_e385);
        local_39 = uint(12);
        uint _e391 = local_38;
        uint _e392 = local_39;
        local_115 = uint((_e391 + _e392));
        uint _e396 = local_115;
        _group_0_binding_0_cs[_e396] = int(_e381);
        uint _e403 = points_4[1][1].x;
        uint _e405 = local;
        local_40 = _e405;
        uint _e407 = local_40;
        local_41 = uint(_e407);
        local_42 = uint(13);
        uint _e413 = local_41;
        uint _e414 = local_42;
        local_116 = uint((_e413 + _e414));
        uint _e418 = local_116;
        _group_0_binding_0_cs[_e418] = int(_e403);
        uint _e425 = points_4[1][1].z;
        uint _e427 = local;
        local_43 = _e427;
        uint _e429 = local_43;
        local_44 = uint(_e429);
        local_45 = uint(14);
        uint _e435 = local_44;
        uint _e436 = local_45;
        local_117 = uint((_e435 + _e436));
        uint _e440 = local_117;
        _group_0_binding_0_cs[_e440] = int(_e425);
    }
    {
        original_5.x = uint(1);
        original_5.y = uint(2);
        original_5.z = uint(3);
        original_5.w = uint(4);
        uvec4 _e458 = original_5;
        points_5[0][0] = _e458;
        points_5[0][1] = uvec4(0u);
        uvec4 _e463 = original_5;
        points_5[1][0] = _e463;
        points_5[1][1].x = uint(5);
        points_5[1][1].y = 0u;
        points_5[1][1].z = 0u;
        points_5[1][1].w = 0u;
        uint _e479 = points_5[0][0].w;
        uint _e481 = local;
        local_46 = _e481;
        uint _e483 = local_46;
        local_47 = uint(_e483);
        local_48 = uint(15);
        uint _e489 = local_47;
        uint _e490 = local_48;
        local_118 = uint((_e489 + _e490));
        uint _e494 = local_118;
        _group_0_binding_0_cs[_e494] = int(_e479);
        uint _e501 = points_5[1][1].x;
        uint _e503 = local;
        local_49 = _e503;
        uint _e505 = local_49;
        local_50 = uint(_e505);
        local_51 = uint(16);
        uint _e511 = local_50;
        uint _e512 = local_51;
        local_119 = uint((_e511 + _e512));
        uint _e516 = local_119;
        _group_0_binding_0_cs[_e516] = int(_e501);
        uint _e523 = points_5[1][1].w;
        uint _e525 = local;
        local_52 = _e525;
        uint _e527 = local_52;
        local_53 = uint(_e527);
        local_54 = uint(17);
        uint _e533 = local_53;
        uint _e534 = local_54;
        local_120 = uint((_e533 + _e534));
        uint _e538 = local_120;
        _group_0_binding_0_cs[_e538] = int(_e523);
    }
    {
        original_6.x = float(1);
        original_6.y = float(2);
        vec2 _e550 = original_6;
        points_6[0][0] = _e550;
        points_6[0][1] = vec2(0.0);
        vec2 _e555 = original_6;
        points_6[1][0] = _e555;
        points_6[1][1].x = float(5);
        points_6[1][1].y = 0.0;
        float _e567 = points_6[0][0].y;
        uint _e569 = local;
        local_55 = _e569;
        uint _e571 = local_55;
        local_56 = uint(_e571);
        local_57 = uint(18);
        uint _e577 = local_56;
        uint _e578 = local_57;
        local_121 = uint((_e577 + _e578));
        uint _e582 = local_121;
        _group_0_binding_0_cs[_e582] = int(_e567);
        float _e589 = points_6[1][1].x;
        uint _e591 = local;
        local_58 = _e591;
        uint _e593 = local_58;
        local_59 = uint(_e593);
        local_60 = uint(19);
        uint _e599 = local_59;
        uint _e600 = local_60;
        local_122 = uint((_e599 + _e600));
        uint _e604 = local_122;
        _group_0_binding_0_cs[_e604] = int(_e589);
        float _e611 = points_6[1][1].y;
        uint _e613 = local;
        local_61 = _e613;
        uint _e615 = local_61;
        local_62 = uint(_e615);
        local_63 = uint(20);
        uint _e621 = local_62;
        uint _e622 = local_63;
        local_123 = uint((_e621 + _e622));
        uint _e626 = local_123;
        _group_0_binding_0_cs[_e626] = int(_e611);
    }
    {
        original_7.x = float(1);
        original_7.y = float(2);
        original_7.z = float(3);
        float3_ _e641 = original_7;
        points_7[0][0] = _e641;
        points_7[0][1] = float3_(0.0, 0.0, 0.0);
        float3_ _e646 = original_7;
        points_7[1][0] = _e646;
        points_7[1][1].x = float(5);
        points_7[1][1].y = 0.0;
        points_7[1][1].z = 0.0;
        float _e660 = points_7[0][0].z;
        uint _e662 = local;
        local_64 = _e662;
        uint _e664 = local_64;
        local_65 = uint(_e664);
        local_66 = uint(21);
        uint _e670 = local_65;
        uint _e671 = local_66;
        local_124 = uint((_e670 + _e671));
        uint _e675 = local_124;
        _group_0_binding_0_cs[_e675] = int(_e660);
        float _e682 = points_7[1][1].x;
        uint _e684 = local;
        local_67 = _e684;
        uint _e686 = local_67;
        local_68 = uint(_e686);
        local_69 = uint(22);
        uint _e692 = local_68;
        uint _e693 = local_69;
        local_125 = uint((_e692 + _e693));
        uint _e697 = local_125;
        _group_0_binding_0_cs[_e697] = int(_e682);
        float _e704 = points_7[1][1].z;
        uint _e706 = local;
        local_70 = _e706;
        uint _e708 = local_70;
        local_71 = uint(_e708);
        local_72 = uint(23);
        uint _e714 = local_71;
        uint _e715 = local_72;
        local_126 = uint((_e714 + _e715));
        uint _e719 = local_126;
        _group_0_binding_0_cs[_e719] = int(_e704);
    }
    {
        original_8.x = float(1);
        original_8.y = float(2);
        original_8.z = float(3);
        original_8.w = float(4);
        vec4 _e737 = original_8;
        points_8[0][0] = _e737;
        points_8[0][1] = vec4(0.0);
        vec4 _e742 = original_8;
        points_8[1][0] = _e742;
        points_8[1][1].x = float(5);
        points_8[1][1].y = 0.0;
        points_8[1][1].z = 0.0;
        points_8[1][1].w = 0.0;
        float _e758 = points_8[0][0].w;
        uint _e760 = local;
        local_73 = _e760;
        uint _e762 = local_73;
        local_74 = uint(_e762);
        local_75 = uint(24);
        uint _e768 = local_74;
        uint _e769 = local_75;
        local_127 = uint((_e768 + _e769));
        uint _e773 = local_127;
        _group_0_binding_0_cs[_e773] = int(_e758);
        float _e780 = points_8[1][1].x;
        uint _e782 = local;
        local_76 = _e782;
        uint _e784 = local_76;
        local_77 = uint(_e784);
        local_78 = uint(25);
        uint _e790 = local_77;
        uint _e791 = local_78;
        local_128 = uint((_e790 + _e791));
        uint _e795 = local_128;
        _group_0_binding_0_cs[_e795] = int(_e780);
        float _e802 = points_8[1][1].w;
        uint _e804 = local;
        local_79 = _e804;
        uint _e806 = local_79;
        local_80 = uint(_e806);
        local_81 = uint(26);
        uint _e812 = local_80;
        uint _e813 = local_81;
        local_129 = uint((_e812 + _e813));
        uint _e817 = local_129;
        _group_0_binding_0_cs[_e817] = int(_e802);
    }
    changed[0][0] = 1;
    local_82 = 1u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e830 = local_82;
            local_82 = (_e830 + 1u);
        }
        loop_init = false;
        uint _e825 = local_82;
        if ((_e825 >= 2u)) {
            break;
        }
        changed[0][_e825] = 0;
    }
    changed[0][1] = 9;
    changed[1][0] = 2;
    changed[1][1] = 3;
    local_83 = 0u;
    bool loop_init_1 = true;
    while(true) {
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
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                uint _e857 = local_84;
                local_84 = (_e857 + 1u);
            }
            loop_init_2 = false;
            uint _e852 = local_84;
            if ((_e852 >= 3u)) {
                break;
            }
            nested_empty[_e845][_e852] = 0;
        }
    }
    partial[0][0] = 1;
    local_85 = 1u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e874 = local_85;
            local_85 = (_e874 + 1u);
        }
        loop_init_3 = false;
        uint _e869 = local_85;
        if ((_e869 >= 3u)) {
            break;
        }
        partial[0][_e869] = 0;
    }
    local_86 = 1u;
    bool loop_init_4 = true;
    while(true) {
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
        bool loop_init_5 = true;
        while(true) {
            if (!loop_init_5) {
                uint _e890 = local_87;
                local_87 = (_e890 + 1u);
            }
            loop_init_5 = false;
            uint _e885 = local_87;
            if ((_e885 >= 3u)) {
                break;
            }
            partial[_e879][_e885] = 0;
        }
    }
    volume[0][0][0] = 1;
    local_88 = 1u;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            uint _e908 = local_88;
            local_88 = (_e908 + 1u);
        }
        loop_init_6 = false;
        uint _e903 = local_88;
        if ((_e903 >= 3u)) {
            break;
        }
        volume[0][0][_e903] = 0;
    }
    local_89 = 1u;
    bool loop_init_7 = true;
    while(true) {
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
        bool loop_init_8 = true;
        while(true) {
            if (!loop_init_8) {
                uint _e924 = local_90;
                local_90 = (_e924 + 1u);
            }
            loop_init_8 = false;
            uint _e919 = local_90;
            if ((_e919 >= 3u)) {
                break;
            }
            volume[0][_e913][_e919] = 0;
        }
    }
    local_91 = 1u;
    bool loop_init_9 = true;
    while(true) {
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
        bool loop_init_10 = true;
        while(true) {
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
            bool loop_init_11 = true;
            while(true) {
                if (!loop_init_11) {
                    uint _e949 = local_93;
                    local_93 = (_e949 + 1u);
                }
                loop_init_11 = false;
                uint _e944 = local_93;
                if ((_e944 >= 3u)) {
                    break;
                }
                volume[_e932][_e938][_e944] = 0;
            }
        }
    }
    int _e962 = changed[0][1];
    shared_values[1][2] = _e962;
    int _e972 = changed[1][0];
    int _e977 = changed[1][1];
    shared_points[1][0] = float3_(float(_e972), float(_e977), float(4));
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    int _e997 = shared_values[1][2];
    int _e998 = nested_empty[1][2];
    int _e1004 = partial[1][2];
    int _e1012 = volume[1][1][2];
    uint _e1014 = local;
    local_94 = _e1014;
    uint _e1016 = local_94;
    local_95 = uint(_e1016);
    local_96 = uint(27);
    uint _e1022 = local_95;
    uint _e1023 = local_96;
    local_130 = uint((_e1022 + _e1023));
    uint _e1027 = local_130;
    _group_0_binding_0_cs[_e1027] = (((_e997 + _e998) + _e1004) + _e1012);
    float _e1034 = shared_points[1][0].x;
    uint _e1036 = local;
    local_97 = _e1036;
    uint _e1038 = local_97;
    local_98 = uint(_e1038);
    local_99 = uint(28);
    uint _e1044 = local_98;
    uint _e1045 = local_99;
    local_131 = uint((_e1044 + _e1045));
    uint _e1049 = local_131;
    _group_0_binding_0_cs[_e1049] = int(_e1034);
    float _e1056 = shared_points[1][0].y;
    uint _e1058 = local;
    local_100 = _e1058;
    uint _e1060 = local_100;
    local_101 = uint(_e1060);
    local_102 = uint(29);
    uint _e1066 = local_101;
    uint _e1067 = local_102;
    local_132 = uint((_e1066 + _e1067));
    uint _e1071 = local_132;
    _group_0_binding_0_cs[_e1071] = int(_e1056);
}

