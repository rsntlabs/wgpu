// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];
struct type_4 {
    metal::int2 inner[2];
};
struct type_5 {
    type_4 inner[2];
};
struct int3_ {
    int x;
    int y;
    int z;
};
struct type_6 {
    int3_ inner[2];
};
struct type_7 {
    type_6 inner[2];
};
struct type_9 {
    metal::int4 inner[2];
};
struct type_10 {
    type_9 inner[2];
};
struct type_12 {
    metal::uint2 inner[2];
};
struct type_13 {
    type_12 inner[2];
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct type_14 {
    uint3_ inner[2];
};
struct type_15 {
    type_14 inner[2];
};
struct type_17 {
    metal::uint4 inner[2];
};
struct type_18 {
    type_17 inner[2];
};
struct type_21 {
    metal::float2 inner[2];
};
struct type_22 {
    type_21 inner[2];
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_23 {
    float3_ inner[2];
};
struct type_24 {
    type_23 inner[2];
};
struct type_26 {
    metal::float4 inner[2];
};
struct type_27 {
    type_26 inner[2];
};
struct type_28 {
    int inner[2];
};
struct type_29 {
    type_28 inner[2];
};
struct type_30 {
    int inner[3];
};
struct type_31 {
    type_30 inner[2];
};
struct type_32 {
    type_31 inner[2];
};
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void multidimensional_arrays(
  uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, threadgroup type_31& shared_values
, threadgroup type_24& shared_points
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
        shared_points = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local = {};
    metal::int2 original = {};
    type_5 points = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    int3_ original_1 = {};
    type_7 points_1 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    metal::int4 original_2 = {};
    type_10 points_2 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    metal::uint2 original_3 = {};
    type_13 points_3 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint3_ original_4 = {};
    type_15 points_4 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    metal::uint4 original_5 = {};
    type_18 points_5 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    metal::float2 original_6 = {};
    type_22 points_6 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    float3_ original_7 = {};
    type_24 points_7 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    metal::float4 original_8 = {};
    type_27 points_8 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    type_29 changed = {};
    uint local_82 = {};
    type_31 nested_empty = {};
    uint local_83 = {};
    uint local_84 = {};
    type_31 partial = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    type_32 volume = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    local = 0u;
    {
        original.x = 1;
        original.y = 2;
        metal::int2 _e10 = original;
        points.inner[0].inner[0] = _e10;
        points.inner[0].inner[1] = metal::int2 {};
        metal::int2 _e15 = original;
        points.inner[1].inner[0] = _e15;
        points.inner[1].inner[1].x = 5;
        points.inner[1].inner[1].y = int {};
        int _e26 = points.inner[0].inner[0].y;
        uint _e27 = local;
        local_1 = _e27;
        uint _e29 = local_1;
        local_2 = static_cast<uint>(_e29);
        local_3 = static_cast<uint>(0);
        uint _e36 = local_2;
        uint _e37 = local_3;
        local_103 = static_cast<uint>(_e36 + _e37);
        uint _e41 = local_103;
        out[_e41] = _e26;
        int _e48 = points.inner[1].inner[1].x;
        uint _e49 = local;
        local_4 = _e49;
        uint _e51 = local_4;
        local_5 = static_cast<uint>(_e51);
        local_6 = static_cast<uint>(1);
        uint _e57 = local_5;
        uint _e58 = local_6;
        local_104 = static_cast<uint>(_e57 + _e58);
        uint _e62 = local_104;
        out[_e62] = _e48;
        int _e69 = points.inner[1].inner[1].y;
        uint _e70 = local;
        local_7 = _e70;
        uint _e72 = local_7;
        local_8 = static_cast<uint>(_e72);
        local_9 = static_cast<uint>(2);
        uint _e78 = local_8;
        uint _e79 = local_9;
        local_105 = static_cast<uint>(_e78 + _e79);
        uint _e83 = local_105;
        out[_e83] = _e69;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e95 = original_1;
        points_1.inner[0].inner[0] = _e95;
        points_1.inner[0].inner[1] = int3_ {};
        int3_ _e100 = original_1;
        points_1.inner[1].inner[0] = _e100;
        points_1.inner[1].inner[1].x = 5;
        points_1.inner[1].inner[1].y = int {};
        points_1.inner[1].inner[1].z = int {};
        int _e113 = points_1.inner[0].inner[0].z;
        uint _e114 = local;
        local_10 = _e114;
        uint _e116 = local_10;
        local_11 = static_cast<uint>(_e116);
        local_12 = static_cast<uint>(3);
        uint _e122 = local_11;
        uint _e123 = local_12;
        local_106 = static_cast<uint>(_e122 + _e123);
        uint _e127 = local_106;
        out[_e127] = _e113;
        int _e134 = points_1.inner[1].inner[1].x;
        uint _e135 = local;
        local_13 = _e135;
        uint _e137 = local_13;
        local_14 = static_cast<uint>(_e137);
        local_15 = static_cast<uint>(4);
        uint _e143 = local_14;
        uint _e144 = local_15;
        local_107 = static_cast<uint>(_e143 + _e144);
        uint _e148 = local_107;
        out[_e148] = _e134;
        int _e155 = points_1.inner[1].inner[1].z;
        uint _e156 = local;
        local_16 = _e156;
        uint _e158 = local_16;
        local_17 = static_cast<uint>(_e158);
        local_18 = static_cast<uint>(5);
        uint _e164 = local_17;
        uint _e165 = local_18;
        local_108 = static_cast<uint>(_e164 + _e165);
        uint _e169 = local_108;
        out[_e169] = _e155;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        metal::int4 _e183 = original_2;
        points_2.inner[0].inner[0] = _e183;
        points_2.inner[0].inner[1] = metal::int4 {};
        metal::int4 _e188 = original_2;
        points_2.inner[1].inner[0] = _e188;
        points_2.inner[1].inner[1].x = 5;
        points_2.inner[1].inner[1].y = int {};
        points_2.inner[1].inner[1].z = int {};
        points_2.inner[1].inner[1].w = int {};
        int _e203 = points_2.inner[0].inner[0].w;
        uint _e204 = local;
        local_19 = _e204;
        uint _e206 = local_19;
        local_20 = static_cast<uint>(_e206);
        local_21 = static_cast<uint>(6);
        uint _e212 = local_20;
        uint _e213 = local_21;
        local_109 = static_cast<uint>(_e212 + _e213);
        uint _e217 = local_109;
        out[_e217] = _e203;
        int _e224 = points_2.inner[1].inner[1].x;
        uint _e225 = local;
        local_22 = _e225;
        uint _e227 = local_22;
        local_23 = static_cast<uint>(_e227);
        local_24 = static_cast<uint>(7);
        uint _e233 = local_23;
        uint _e234 = local_24;
        local_110 = static_cast<uint>(_e233 + _e234);
        uint _e238 = local_110;
        out[_e238] = _e224;
        int _e245 = points_2.inner[1].inner[1].w;
        uint _e246 = local;
        local_25 = _e246;
        uint _e248 = local_25;
        local_26 = static_cast<uint>(_e248);
        local_27 = static_cast<uint>(8);
        uint _e254 = local_26;
        uint _e255 = local_27;
        local_111 = static_cast<uint>(_e254 + _e255);
        uint _e259 = local_111;
        out[_e259] = _e245;
    }
    {
        original_3.x = static_cast<uint>(1);
        original_3.y = static_cast<uint>(2);
        metal::uint2 _e271 = original_3;
        points_3.inner[0].inner[0] = _e271;
        points_3.inner[0].inner[1] = metal::uint2 {};
        metal::uint2 _e276 = original_3;
        points_3.inner[1].inner[0] = _e276;
        points_3.inner[1].inner[1].x = static_cast<uint>(5);
        points_3.inner[1].inner[1].y = uint {};
        uint _e288 = points_3.inner[0].inner[0].y;
        uint _e290 = local;
        local_28 = _e290;
        uint _e292 = local_28;
        local_29 = static_cast<uint>(_e292);
        local_30 = static_cast<uint>(9);
        uint _e298 = local_29;
        uint _e299 = local_30;
        local_112 = static_cast<uint>(_e298 + _e299);
        uint _e303 = local_112;
        out[_e303] = static_cast<int>(_e288);
        uint _e310 = points_3.inner[1].inner[1].x;
        uint _e312 = local;
        local_31 = _e312;
        uint _e314 = local_31;
        local_32 = static_cast<uint>(_e314);
        local_33 = static_cast<uint>(10);
        uint _e320 = local_32;
        uint _e321 = local_33;
        local_113 = static_cast<uint>(_e320 + _e321);
        uint _e325 = local_113;
        out[_e325] = static_cast<int>(_e310);
        uint _e332 = points_3.inner[1].inner[1].y;
        uint _e334 = local;
        local_34 = _e334;
        uint _e336 = local_34;
        local_35 = static_cast<uint>(_e336);
        local_36 = static_cast<uint>(11);
        uint _e342 = local_35;
        uint _e343 = local_36;
        local_114 = static_cast<uint>(_e342 + _e343);
        uint _e347 = local_114;
        out[_e347] = static_cast<int>(_e332);
    }
    {
        original_4.x = static_cast<uint>(1);
        original_4.y = static_cast<uint>(2);
        original_4.z = static_cast<uint>(3);
        uint3_ _e362 = original_4;
        points_4.inner[0].inner[0] = _e362;
        points_4.inner[0].inner[1] = uint3_ {};
        uint3_ _e367 = original_4;
        points_4.inner[1].inner[0] = _e367;
        points_4.inner[1].inner[1].x = static_cast<uint>(5);
        points_4.inner[1].inner[1].y = uint {};
        points_4.inner[1].inner[1].z = uint {};
        uint _e381 = points_4.inner[0].inner[0].z;
        uint _e383 = local;
        local_37 = _e383;
        uint _e385 = local_37;
        local_38 = static_cast<uint>(_e385);
        local_39 = static_cast<uint>(12);
        uint _e391 = local_38;
        uint _e392 = local_39;
        local_115 = static_cast<uint>(_e391 + _e392);
        uint _e396 = local_115;
        out[_e396] = static_cast<int>(_e381);
        uint _e403 = points_4.inner[1].inner[1].x;
        uint _e405 = local;
        local_40 = _e405;
        uint _e407 = local_40;
        local_41 = static_cast<uint>(_e407);
        local_42 = static_cast<uint>(13);
        uint _e413 = local_41;
        uint _e414 = local_42;
        local_116 = static_cast<uint>(_e413 + _e414);
        uint _e418 = local_116;
        out[_e418] = static_cast<int>(_e403);
        uint _e425 = points_4.inner[1].inner[1].z;
        uint _e427 = local;
        local_43 = _e427;
        uint _e429 = local_43;
        local_44 = static_cast<uint>(_e429);
        local_45 = static_cast<uint>(14);
        uint _e435 = local_44;
        uint _e436 = local_45;
        local_117 = static_cast<uint>(_e435 + _e436);
        uint _e440 = local_117;
        out[_e440] = static_cast<int>(_e425);
    }
    {
        original_5.x = static_cast<uint>(1);
        original_5.y = static_cast<uint>(2);
        original_5.z = static_cast<uint>(3);
        original_5.w = static_cast<uint>(4);
        metal::uint4 _e458 = original_5;
        points_5.inner[0].inner[0] = _e458;
        points_5.inner[0].inner[1] = metal::uint4 {};
        metal::uint4 _e463 = original_5;
        points_5.inner[1].inner[0] = _e463;
        points_5.inner[1].inner[1].x = static_cast<uint>(5);
        points_5.inner[1].inner[1].y = uint {};
        points_5.inner[1].inner[1].z = uint {};
        points_5.inner[1].inner[1].w = uint {};
        uint _e479 = points_5.inner[0].inner[0].w;
        uint _e481 = local;
        local_46 = _e481;
        uint _e483 = local_46;
        local_47 = static_cast<uint>(_e483);
        local_48 = static_cast<uint>(15);
        uint _e489 = local_47;
        uint _e490 = local_48;
        local_118 = static_cast<uint>(_e489 + _e490);
        uint _e494 = local_118;
        out[_e494] = static_cast<int>(_e479);
        uint _e501 = points_5.inner[1].inner[1].x;
        uint _e503 = local;
        local_49 = _e503;
        uint _e505 = local_49;
        local_50 = static_cast<uint>(_e505);
        local_51 = static_cast<uint>(16);
        uint _e511 = local_50;
        uint _e512 = local_51;
        local_119 = static_cast<uint>(_e511 + _e512);
        uint _e516 = local_119;
        out[_e516] = static_cast<int>(_e501);
        uint _e523 = points_5.inner[1].inner[1].w;
        uint _e525 = local;
        local_52 = _e525;
        uint _e527 = local_52;
        local_53 = static_cast<uint>(_e527);
        local_54 = static_cast<uint>(17);
        uint _e533 = local_53;
        uint _e534 = local_54;
        local_120 = static_cast<uint>(_e533 + _e534);
        uint _e538 = local_120;
        out[_e538] = static_cast<int>(_e523);
    }
    {
        original_6.x = static_cast<float>(1);
        original_6.y = static_cast<float>(2);
        metal::float2 _e550 = original_6;
        points_6.inner[0].inner[0] = _e550;
        points_6.inner[0].inner[1] = metal::float2 {};
        metal::float2 _e555 = original_6;
        points_6.inner[1].inner[0] = _e555;
        points_6.inner[1].inner[1].x = static_cast<float>(5);
        points_6.inner[1].inner[1].y = float {};
        float _e567 = points_6.inner[0].inner[0].y;
        uint _e569 = local;
        local_55 = _e569;
        uint _e571 = local_55;
        local_56 = static_cast<uint>(_e571);
        local_57 = static_cast<uint>(18);
        uint _e577 = local_56;
        uint _e578 = local_57;
        local_121 = static_cast<uint>(_e577 + _e578);
        uint _e582 = local_121;
        out[_e582] = naga_f2i32(_e567);
        float _e589 = points_6.inner[1].inner[1].x;
        uint _e591 = local;
        local_58 = _e591;
        uint _e593 = local_58;
        local_59 = static_cast<uint>(_e593);
        local_60 = static_cast<uint>(19);
        uint _e599 = local_59;
        uint _e600 = local_60;
        local_122 = static_cast<uint>(_e599 + _e600);
        uint _e604 = local_122;
        out[_e604] = naga_f2i32(_e589);
        float _e611 = points_6.inner[1].inner[1].y;
        uint _e613 = local;
        local_61 = _e613;
        uint _e615 = local_61;
        local_62 = static_cast<uint>(_e615);
        local_63 = static_cast<uint>(20);
        uint _e621 = local_62;
        uint _e622 = local_63;
        local_123 = static_cast<uint>(_e621 + _e622);
        uint _e626 = local_123;
        out[_e626] = naga_f2i32(_e611);
    }
    {
        original_7.x = static_cast<float>(1);
        original_7.y = static_cast<float>(2);
        original_7.z = static_cast<float>(3);
        float3_ _e641 = original_7;
        points_7.inner[0].inner[0] = _e641;
        points_7.inner[0].inner[1] = float3_ {};
        float3_ _e646 = original_7;
        points_7.inner[1].inner[0] = _e646;
        points_7.inner[1].inner[1].x = static_cast<float>(5);
        points_7.inner[1].inner[1].y = float {};
        points_7.inner[1].inner[1].z = float {};
        float _e660 = points_7.inner[0].inner[0].z;
        uint _e662 = local;
        local_64 = _e662;
        uint _e664 = local_64;
        local_65 = static_cast<uint>(_e664);
        local_66 = static_cast<uint>(21);
        uint _e670 = local_65;
        uint _e671 = local_66;
        local_124 = static_cast<uint>(_e670 + _e671);
        uint _e675 = local_124;
        out[_e675] = naga_f2i32(_e660);
        float _e682 = points_7.inner[1].inner[1].x;
        uint _e684 = local;
        local_67 = _e684;
        uint _e686 = local_67;
        local_68 = static_cast<uint>(_e686);
        local_69 = static_cast<uint>(22);
        uint _e692 = local_68;
        uint _e693 = local_69;
        local_125 = static_cast<uint>(_e692 + _e693);
        uint _e697 = local_125;
        out[_e697] = naga_f2i32(_e682);
        float _e704 = points_7.inner[1].inner[1].z;
        uint _e706 = local;
        local_70 = _e706;
        uint _e708 = local_70;
        local_71 = static_cast<uint>(_e708);
        local_72 = static_cast<uint>(23);
        uint _e714 = local_71;
        uint _e715 = local_72;
        local_126 = static_cast<uint>(_e714 + _e715);
        uint _e719 = local_126;
        out[_e719] = naga_f2i32(_e704);
    }
    {
        original_8.x = static_cast<float>(1);
        original_8.y = static_cast<float>(2);
        original_8.z = static_cast<float>(3);
        original_8.w = static_cast<float>(4);
        metal::float4 _e737 = original_8;
        points_8.inner[0].inner[0] = _e737;
        points_8.inner[0].inner[1] = metal::float4 {};
        metal::float4 _e742 = original_8;
        points_8.inner[1].inner[0] = _e742;
        points_8.inner[1].inner[1].x = static_cast<float>(5);
        points_8.inner[1].inner[1].y = float {};
        points_8.inner[1].inner[1].z = float {};
        points_8.inner[1].inner[1].w = float {};
        float _e758 = points_8.inner[0].inner[0].w;
        uint _e760 = local;
        local_73 = _e760;
        uint _e762 = local_73;
        local_74 = static_cast<uint>(_e762);
        local_75 = static_cast<uint>(24);
        uint _e768 = local_74;
        uint _e769 = local_75;
        local_127 = static_cast<uint>(_e768 + _e769);
        uint _e773 = local_127;
        out[_e773] = naga_f2i32(_e758);
        float _e780 = points_8.inner[1].inner[1].x;
        uint _e782 = local;
        local_76 = _e782;
        uint _e784 = local_76;
        local_77 = static_cast<uint>(_e784);
        local_78 = static_cast<uint>(25);
        uint _e790 = local_77;
        uint _e791 = local_78;
        local_128 = static_cast<uint>(_e790 + _e791);
        uint _e795 = local_128;
        out[_e795] = naga_f2i32(_e780);
        float _e802 = points_8.inner[1].inner[1].w;
        uint _e804 = local;
        local_79 = _e804;
        uint _e806 = local_79;
        local_80 = static_cast<uint>(_e806);
        local_81 = static_cast<uint>(26);
        uint _e812 = local_80;
        uint _e813 = local_81;
        local_129 = static_cast<uint>(_e812 + _e813);
        uint _e817 = local_129;
        out[_e817] = naga_f2i32(_e802);
    }
    changed.inner[0].inner[0] = 1;
    local_82 = 1u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e830 = local_82;
            local_82 = _e830 + 1u;
        }
        loop_init = false;
        uint _e825 = local_82;
        if (_e825 >= 2u) {
            break;
        }
        changed.inner[0].inner[_e825] = int {};
    }
    changed.inner[0].inner[1] = 9;
    changed.inner[1].inner[0] = 2;
    changed.inner[1].inner[1] = 3;
    local_83 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e860 = local_83;
            local_83 = _e860 + 1u;
        }
        loop_init_1 = false;
        uint _e845 = local_83;
        if (_e845 >= 2u) {
            break;
        }
        local_84 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e857 = local_84;
                local_84 = _e857 + 1u;
            }
            loop_init_2 = false;
            uint _e852 = local_84;
            if (_e852 >= 3u) {
                break;
            }
            nested_empty.inner[_e845].inner[_e852] = int {};
        }
    }
    partial.inner[0].inner[0] = 1;
    local_85 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e874 = local_85;
            local_85 = _e874 + 1u;
        }
        loop_init_3 = false;
        uint _e869 = local_85;
        if (_e869 >= 3u) {
            break;
        }
        partial.inner[0].inner[_e869] = int {};
    }
    local_86 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e893 = local_86;
            local_86 = _e893 + 1u;
        }
        loop_init_4 = false;
        uint _e879 = local_86;
        if (_e879 >= 2u) {
            break;
        }
        local_87 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e890 = local_87;
                local_87 = _e890 + 1u;
            }
            loop_init_5 = false;
            uint _e885 = local_87;
            if (_e885 >= 3u) {
                break;
            }
            partial.inner[_e879].inner[_e885] = int {};
        }
    }
    volume.inner[0].inner[0].inner[0] = 1;
    local_88 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e908 = local_88;
            local_88 = _e908 + 1u;
        }
        loop_init_6 = false;
        uint _e903 = local_88;
        if (_e903 >= 3u) {
            break;
        }
        volume.inner[0].inner[0].inner[_e903] = int {};
    }
    local_89 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e927 = local_89;
            local_89 = _e927 + 1u;
        }
        loop_init_7 = false;
        uint _e913 = local_89;
        if (_e913 >= 2u) {
            break;
        }
        local_90 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (metal::all(loop_bound_8 == uint2(0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e924 = local_90;
                local_90 = _e924 + 1u;
            }
            loop_init_8 = false;
            uint _e919 = local_90;
            if (_e919 >= 3u) {
                break;
            }
            volume.inner[0].inner[_e913].inner[_e919] = int {};
        }
    }
    local_91 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e955 = local_91;
            local_91 = _e955 + 1u;
        }
        loop_init_9 = false;
        uint _e932 = local_91;
        if (_e932 >= 2u) {
            break;
        }
        local_92 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (metal::all(loop_bound_10 == uint2(0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e952 = local_92;
                local_92 = _e952 + 1u;
            }
            loop_init_10 = false;
            uint _e938 = local_92;
            if (_e938 >= 2u) {
                break;
            }
            local_93 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (metal::all(loop_bound_11 == uint2(0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e949 = local_93;
                    local_93 = _e949 + 1u;
                }
                loop_init_11 = false;
                uint _e944 = local_93;
                if (_e944 >= 3u) {
                    break;
                }
                volume.inner[_e932].inner[_e938].inner[_e944] = int {};
            }
        }
    }
    int _e962 = changed.inner[0].inner[1];
    shared_values.inner[1].inner[2] = _e962;
    int _e972 = changed.inner[1].inner[0];
    int _e977 = changed.inner[1].inner[1];
    shared_points.inner[1].inner[0] = float3_ {static_cast<float>(_e972), static_cast<float>(_e977), static_cast<float>(4)};
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    int _e997 = shared_values.inner[1].inner[2];
    int _e998 = nested_empty.inner[1].inner[2];
    int _e1004 = partial.inner[1].inner[2];
    int _e1012 = volume.inner[1].inner[1].inner[2];
    uint _e1014 = local;
    local_94 = _e1014;
    uint _e1016 = local_94;
    local_95 = static_cast<uint>(_e1016);
    local_96 = static_cast<uint>(27);
    uint _e1022 = local_95;
    uint _e1023 = local_96;
    local_130 = static_cast<uint>(_e1022 + _e1023);
    uint _e1027 = local_130;
    out[_e1027] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e997) + as_type<uint>(_e998))) + as_type<uint>(_e1004))) + as_type<uint>(_e1012));
    float _e1034 = shared_points.inner[1].inner[0].x;
    uint _e1036 = local;
    local_97 = _e1036;
    uint _e1038 = local_97;
    local_98 = static_cast<uint>(_e1038);
    local_99 = static_cast<uint>(28);
    uint _e1044 = local_98;
    uint _e1045 = local_99;
    local_131 = static_cast<uint>(_e1044 + _e1045);
    uint _e1049 = local_131;
    out[_e1049] = naga_f2i32(_e1034);
    float _e1056 = shared_points.inner[1].inner[0].y;
    uint _e1058 = local;
    local_100 = _e1058;
    uint _e1060 = local_100;
    local_101 = static_cast<uint>(_e1060);
    local_102 = static_cast<uint>(29);
    uint _e1066 = local_101;
    uint _e1067 = local_102;
    local_132 = static_cast<uint>(_e1066 + _e1067);
    uint _e1071 = local_132;
    out[_e1071] = naga_f2i32(_e1056);
}
