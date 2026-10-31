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
struct type_33 {
    uint inner[2];
};
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void multidimensional_arrays(
  uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, threadgroup type_31& shared_values
, threadgroup type_24& shared_points
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
        shared_points = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_33 out = {};
    metal::int2 original = {};
    type_5 points = {};
    type_33 local = {};
    uint local_1 = {};
    type_33 local_2 = {};
    uint local_3 = {};
    type_33 local_4 = {};
    uint local_5 = {};
    int3_ original_1 = {};
    type_7 points_1 = {};
    type_33 local_6 = {};
    uint local_7 = {};
    type_33 local_8 = {};
    uint local_9 = {};
    type_33 local_10 = {};
    uint local_11 = {};
    metal::int4 original_2 = {};
    type_10 points_2 = {};
    type_33 local_12 = {};
    uint local_13 = {};
    type_33 local_14 = {};
    uint local_15 = {};
    type_33 local_16 = {};
    uint local_17 = {};
    metal::uint2 original_3 = {};
    type_13 points_3 = {};
    type_33 local_18 = {};
    uint local_19 = {};
    type_33 local_20 = {};
    uint local_21 = {};
    type_33 local_22 = {};
    uint local_23 = {};
    uint3_ original_4 = {};
    type_15 points_4 = {};
    type_33 local_24 = {};
    uint local_25 = {};
    type_33 local_26 = {};
    uint local_27 = {};
    type_33 local_28 = {};
    uint local_29 = {};
    metal::uint4 original_5 = {};
    type_18 points_5 = {};
    type_33 local_30 = {};
    uint local_31 = {};
    type_33 local_32 = {};
    uint local_33 = {};
    type_33 local_34 = {};
    uint local_35 = {};
    metal::float2 original_6 = {};
    type_22 points_6 = {};
    type_33 local_36 = {};
    uint local_37 = {};
    type_33 local_38 = {};
    uint local_39 = {};
    type_33 local_40 = {};
    uint local_41 = {};
    float3_ original_7 = {};
    type_24 points_7 = {};
    type_33 local_42 = {};
    uint local_43 = {};
    type_33 local_44 = {};
    uint local_45 = {};
    type_33 local_46 = {};
    uint local_47 = {};
    metal::float4 original_8 = {};
    type_27 points_8 = {};
    type_33 local_48 = {};
    uint local_49 = {};
    type_33 local_50 = {};
    uint local_51 = {};
    type_33 local_52 = {};
    uint local_53 = {};
    type_29 changed = {};
    uint local_54 = {};
    type_31 nested_empty = {};
    uint local_55 = {};
    uint local_56 = {};
    type_31 partial = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    type_32 volume = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_33 local_66 = {};
    uint local_67 = {};
    type_33 local_68 = {};
    uint local_69 = {};
    type_33 local_70 = {};
    uint local_71 = {};
    type_33 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_33 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_33 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_33 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_33 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_33 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_33 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_33 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_33 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_33 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_33 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_33 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_33 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_33 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_33 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_33 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_33 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_33 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_33 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_33 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_33 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_33 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_33 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    type_33 local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    type_33 local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    type_33 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    type_33 local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    type_33 local_153 = {};
    uint local_154 = {};
    uint local_155 = {};
    type_33 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    type_33 local_159 = {};
    uint local_160 = {};
    uint local_161 = {};
    out = type_33 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    {
        original.x = 1;
        original.y = 2;
        metal::int2 _e15 = original;
        points.inner[0].inner[0] = _e15;
        points.inner[0].inner[1] = metal::int2 {};
        metal::int2 _e20 = original;
        points.inner[1].inner[0] = _e20;
        points.inner[1].inner[1].x = 5;
        points.inner[1].inner[1].y = int {};
        int _e31 = points.inner[0].inner[0].y;
        type_33 _e34 = out;
        local = _e34;
        local_1 = static_cast<uint>(0);
        type_33 _e39 = local;
        local_72 = _e39;
        uint _e40 = local_1;
        uint _e42 = local_72.inner[1];
        local_72.inner[1] = _e42 + _e40;
        uint _e46 = local_72.inner[0];
        local_73 = static_cast<uint>(_e46);
        uint _e50 = local_72.inner[1];
        local_74 = static_cast<uint>(_e50);
        uint _e53 = local_74;
        out_1[_e53] = _e31;
        int _e60 = points.inner[1].inner[1].x;
        type_33 _e62 = out;
        local_2 = _e62;
        local_3 = static_cast<uint>(1);
        type_33 _e67 = local_2;
        local_75 = _e67;
        uint _e68 = local_3;
        uint _e70 = local_75.inner[1];
        local_75.inner[1] = _e70 + _e68;
        uint _e74 = local_75.inner[0];
        local_76 = static_cast<uint>(_e74);
        uint _e78 = local_75.inner[1];
        local_77 = static_cast<uint>(_e78);
        uint _e81 = local_77;
        out_1[_e81] = _e60;
        int _e88 = points.inner[1].inner[1].y;
        type_33 _e90 = out;
        local_4 = _e90;
        local_5 = static_cast<uint>(2);
        type_33 _e95 = local_4;
        local_78 = _e95;
        uint _e96 = local_5;
        uint _e98 = local_78.inner[1];
        local_78.inner[1] = _e98 + _e96;
        uint _e102 = local_78.inner[0];
        local_79 = static_cast<uint>(_e102);
        uint _e106 = local_78.inner[1];
        local_80 = static_cast<uint>(_e106);
        uint _e109 = local_80;
        out_1[_e109] = _e88;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e121 = original_1;
        points_1.inner[0].inner[0] = _e121;
        points_1.inner[0].inner[1] = int3_ {};
        int3_ _e126 = original_1;
        points_1.inner[1].inner[0] = _e126;
        points_1.inner[1].inner[1].x = 5;
        points_1.inner[1].inner[1].y = int {};
        points_1.inner[1].inner[1].z = int {};
        int _e139 = points_1.inner[0].inner[0].z;
        type_33 _e141 = out;
        local_6 = _e141;
        local_7 = static_cast<uint>(3);
        type_33 _e146 = local_6;
        local_81 = _e146;
        uint _e147 = local_7;
        uint _e149 = local_81.inner[1];
        local_81.inner[1] = _e149 + _e147;
        uint _e153 = local_81.inner[0];
        local_82 = static_cast<uint>(_e153);
        uint _e157 = local_81.inner[1];
        local_83 = static_cast<uint>(_e157);
        uint _e160 = local_83;
        out_1[_e160] = _e139;
        int _e167 = points_1.inner[1].inner[1].x;
        type_33 _e169 = out;
        local_8 = _e169;
        local_9 = static_cast<uint>(4);
        type_33 _e174 = local_8;
        local_84 = _e174;
        uint _e175 = local_9;
        uint _e177 = local_84.inner[1];
        local_84.inner[1] = _e177 + _e175;
        uint _e181 = local_84.inner[0];
        local_85 = static_cast<uint>(_e181);
        uint _e185 = local_84.inner[1];
        local_86 = static_cast<uint>(_e185);
        uint _e188 = local_86;
        out_1[_e188] = _e167;
        int _e195 = points_1.inner[1].inner[1].z;
        type_33 _e197 = out;
        local_10 = _e197;
        local_11 = static_cast<uint>(5);
        type_33 _e202 = local_10;
        local_87 = _e202;
        uint _e203 = local_11;
        uint _e205 = local_87.inner[1];
        local_87.inner[1] = _e205 + _e203;
        uint _e209 = local_87.inner[0];
        local_88 = static_cast<uint>(_e209);
        uint _e213 = local_87.inner[1];
        local_89 = static_cast<uint>(_e213);
        uint _e216 = local_89;
        out_1[_e216] = _e195;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        metal::int4 _e230 = original_2;
        points_2.inner[0].inner[0] = _e230;
        points_2.inner[0].inner[1] = metal::int4 {};
        metal::int4 _e235 = original_2;
        points_2.inner[1].inner[0] = _e235;
        points_2.inner[1].inner[1].x = 5;
        points_2.inner[1].inner[1].y = int {};
        points_2.inner[1].inner[1].z = int {};
        points_2.inner[1].inner[1].w = int {};
        int _e250 = points_2.inner[0].inner[0].w;
        type_33 _e252 = out;
        local_12 = _e252;
        local_13 = static_cast<uint>(6);
        type_33 _e257 = local_12;
        local_90 = _e257;
        uint _e258 = local_13;
        uint _e260 = local_90.inner[1];
        local_90.inner[1] = _e260 + _e258;
        uint _e264 = local_90.inner[0];
        local_91 = static_cast<uint>(_e264);
        uint _e268 = local_90.inner[1];
        local_92 = static_cast<uint>(_e268);
        uint _e271 = local_92;
        out_1[_e271] = _e250;
        int _e278 = points_2.inner[1].inner[1].x;
        type_33 _e280 = out;
        local_14 = _e280;
        local_15 = static_cast<uint>(7);
        type_33 _e285 = local_14;
        local_93 = _e285;
        uint _e286 = local_15;
        uint _e288 = local_93.inner[1];
        local_93.inner[1] = _e288 + _e286;
        uint _e292 = local_93.inner[0];
        local_94 = static_cast<uint>(_e292);
        uint _e296 = local_93.inner[1];
        local_95 = static_cast<uint>(_e296);
        uint _e299 = local_95;
        out_1[_e299] = _e278;
        int _e306 = points_2.inner[1].inner[1].w;
        type_33 _e308 = out;
        local_16 = _e308;
        local_17 = static_cast<uint>(8);
        type_33 _e313 = local_16;
        local_96 = _e313;
        uint _e314 = local_17;
        uint _e316 = local_96.inner[1];
        local_96.inner[1] = _e316 + _e314;
        uint _e320 = local_96.inner[0];
        local_97 = static_cast<uint>(_e320);
        uint _e324 = local_96.inner[1];
        local_98 = static_cast<uint>(_e324);
        uint _e327 = local_98;
        out_1[_e327] = _e306;
    }
    {
        original_3.x = static_cast<uint>(1);
        original_3.y = static_cast<uint>(2);
        metal::uint2 _e339 = original_3;
        points_3.inner[0].inner[0] = _e339;
        points_3.inner[0].inner[1] = metal::uint2 {};
        metal::uint2 _e344 = original_3;
        points_3.inner[1].inner[0] = _e344;
        points_3.inner[1].inner[1].x = static_cast<uint>(5);
        points_3.inner[1].inner[1].y = uint {};
        uint _e356 = points_3.inner[0].inner[0].y;
        type_33 _e359 = out;
        local_18 = _e359;
        local_19 = static_cast<uint>(9);
        type_33 _e364 = local_18;
        local_99 = _e364;
        uint _e365 = local_19;
        uint _e367 = local_99.inner[1];
        local_99.inner[1] = _e367 + _e365;
        uint _e371 = local_99.inner[0];
        local_100 = static_cast<uint>(_e371);
        uint _e375 = local_99.inner[1];
        local_101 = static_cast<uint>(_e375);
        uint _e378 = local_101;
        out_1[_e378] = static_cast<int>(_e356);
        uint _e385 = points_3.inner[1].inner[1].x;
        type_33 _e388 = out;
        local_20 = _e388;
        local_21 = static_cast<uint>(10);
        type_33 _e393 = local_20;
        local_102 = _e393;
        uint _e394 = local_21;
        uint _e396 = local_102.inner[1];
        local_102.inner[1] = _e396 + _e394;
        uint _e400 = local_102.inner[0];
        local_103 = static_cast<uint>(_e400);
        uint _e404 = local_102.inner[1];
        local_104 = static_cast<uint>(_e404);
        uint _e407 = local_104;
        out_1[_e407] = static_cast<int>(_e385);
        uint _e414 = points_3.inner[1].inner[1].y;
        type_33 _e417 = out;
        local_22 = _e417;
        local_23 = static_cast<uint>(11);
        type_33 _e422 = local_22;
        local_105 = _e422;
        uint _e423 = local_23;
        uint _e425 = local_105.inner[1];
        local_105.inner[1] = _e425 + _e423;
        uint _e429 = local_105.inner[0];
        local_106 = static_cast<uint>(_e429);
        uint _e433 = local_105.inner[1];
        local_107 = static_cast<uint>(_e433);
        uint _e436 = local_107;
        out_1[_e436] = static_cast<int>(_e414);
    }
    {
        original_4.x = static_cast<uint>(1);
        original_4.y = static_cast<uint>(2);
        original_4.z = static_cast<uint>(3);
        uint3_ _e451 = original_4;
        points_4.inner[0].inner[0] = _e451;
        points_4.inner[0].inner[1] = uint3_ {};
        uint3_ _e456 = original_4;
        points_4.inner[1].inner[0] = _e456;
        points_4.inner[1].inner[1].x = static_cast<uint>(5);
        points_4.inner[1].inner[1].y = uint {};
        points_4.inner[1].inner[1].z = uint {};
        uint _e470 = points_4.inner[0].inner[0].z;
        type_33 _e473 = out;
        local_24 = _e473;
        local_25 = static_cast<uint>(12);
        type_33 _e478 = local_24;
        local_108 = _e478;
        uint _e479 = local_25;
        uint _e481 = local_108.inner[1];
        local_108.inner[1] = _e481 + _e479;
        uint _e485 = local_108.inner[0];
        local_109 = static_cast<uint>(_e485);
        uint _e489 = local_108.inner[1];
        local_110 = static_cast<uint>(_e489);
        uint _e492 = local_110;
        out_1[_e492] = static_cast<int>(_e470);
        uint _e499 = points_4.inner[1].inner[1].x;
        type_33 _e502 = out;
        local_26 = _e502;
        local_27 = static_cast<uint>(13);
        type_33 _e507 = local_26;
        local_111 = _e507;
        uint _e508 = local_27;
        uint _e510 = local_111.inner[1];
        local_111.inner[1] = _e510 + _e508;
        uint _e514 = local_111.inner[0];
        local_112 = static_cast<uint>(_e514);
        uint _e518 = local_111.inner[1];
        local_113 = static_cast<uint>(_e518);
        uint _e521 = local_113;
        out_1[_e521] = static_cast<int>(_e499);
        uint _e528 = points_4.inner[1].inner[1].z;
        type_33 _e531 = out;
        local_28 = _e531;
        local_29 = static_cast<uint>(14);
        type_33 _e536 = local_28;
        local_114 = _e536;
        uint _e537 = local_29;
        uint _e539 = local_114.inner[1];
        local_114.inner[1] = _e539 + _e537;
        uint _e543 = local_114.inner[0];
        local_115 = static_cast<uint>(_e543);
        uint _e547 = local_114.inner[1];
        local_116 = static_cast<uint>(_e547);
        uint _e550 = local_116;
        out_1[_e550] = static_cast<int>(_e528);
    }
    {
        original_5.x = static_cast<uint>(1);
        original_5.y = static_cast<uint>(2);
        original_5.z = static_cast<uint>(3);
        original_5.w = static_cast<uint>(4);
        metal::uint4 _e568 = original_5;
        points_5.inner[0].inner[0] = _e568;
        points_5.inner[0].inner[1] = metal::uint4 {};
        metal::uint4 _e573 = original_5;
        points_5.inner[1].inner[0] = _e573;
        points_5.inner[1].inner[1].x = static_cast<uint>(5);
        points_5.inner[1].inner[1].y = uint {};
        points_5.inner[1].inner[1].z = uint {};
        points_5.inner[1].inner[1].w = uint {};
        uint _e589 = points_5.inner[0].inner[0].w;
        type_33 _e592 = out;
        local_30 = _e592;
        local_31 = static_cast<uint>(15);
        type_33 _e597 = local_30;
        local_117 = _e597;
        uint _e598 = local_31;
        uint _e600 = local_117.inner[1];
        local_117.inner[1] = _e600 + _e598;
        uint _e604 = local_117.inner[0];
        local_118 = static_cast<uint>(_e604);
        uint _e608 = local_117.inner[1];
        local_119 = static_cast<uint>(_e608);
        uint _e611 = local_119;
        out_1[_e611] = static_cast<int>(_e589);
        uint _e618 = points_5.inner[1].inner[1].x;
        type_33 _e621 = out;
        local_32 = _e621;
        local_33 = static_cast<uint>(16);
        type_33 _e626 = local_32;
        local_120 = _e626;
        uint _e627 = local_33;
        uint _e629 = local_120.inner[1];
        local_120.inner[1] = _e629 + _e627;
        uint _e633 = local_120.inner[0];
        local_121 = static_cast<uint>(_e633);
        uint _e637 = local_120.inner[1];
        local_122 = static_cast<uint>(_e637);
        uint _e640 = local_122;
        out_1[_e640] = static_cast<int>(_e618);
        uint _e647 = points_5.inner[1].inner[1].w;
        type_33 _e650 = out;
        local_34 = _e650;
        local_35 = static_cast<uint>(17);
        type_33 _e655 = local_34;
        local_123 = _e655;
        uint _e656 = local_35;
        uint _e658 = local_123.inner[1];
        local_123.inner[1] = _e658 + _e656;
        uint _e662 = local_123.inner[0];
        local_124 = static_cast<uint>(_e662);
        uint _e666 = local_123.inner[1];
        local_125 = static_cast<uint>(_e666);
        uint _e669 = local_125;
        out_1[_e669] = static_cast<int>(_e647);
    }
    {
        original_6.x = static_cast<float>(1);
        original_6.y = static_cast<float>(2);
        metal::float2 _e681 = original_6;
        points_6.inner[0].inner[0] = _e681;
        points_6.inner[0].inner[1] = metal::float2 {};
        metal::float2 _e686 = original_6;
        points_6.inner[1].inner[0] = _e686;
        points_6.inner[1].inner[1].x = static_cast<float>(5);
        points_6.inner[1].inner[1].y = float {};
        float _e698 = points_6.inner[0].inner[0].y;
        type_33 _e701 = out;
        local_36 = _e701;
        local_37 = static_cast<uint>(18);
        type_33 _e706 = local_36;
        local_126 = _e706;
        uint _e707 = local_37;
        uint _e709 = local_126.inner[1];
        local_126.inner[1] = _e709 + _e707;
        uint _e713 = local_126.inner[0];
        local_127 = static_cast<uint>(_e713);
        uint _e717 = local_126.inner[1];
        local_128 = static_cast<uint>(_e717);
        uint _e720 = local_128;
        out_1[_e720] = naga_f2i32(_e698);
        float _e727 = points_6.inner[1].inner[1].x;
        type_33 _e730 = out;
        local_38 = _e730;
        local_39 = static_cast<uint>(19);
        type_33 _e735 = local_38;
        local_129 = _e735;
        uint _e736 = local_39;
        uint _e738 = local_129.inner[1];
        local_129.inner[1] = _e738 + _e736;
        uint _e742 = local_129.inner[0];
        local_130 = static_cast<uint>(_e742);
        uint _e746 = local_129.inner[1];
        local_131 = static_cast<uint>(_e746);
        uint _e749 = local_131;
        out_1[_e749] = naga_f2i32(_e727);
        float _e756 = points_6.inner[1].inner[1].y;
        type_33 _e759 = out;
        local_40 = _e759;
        local_41 = static_cast<uint>(20);
        type_33 _e764 = local_40;
        local_132 = _e764;
        uint _e765 = local_41;
        uint _e767 = local_132.inner[1];
        local_132.inner[1] = _e767 + _e765;
        uint _e771 = local_132.inner[0];
        local_133 = static_cast<uint>(_e771);
        uint _e775 = local_132.inner[1];
        local_134 = static_cast<uint>(_e775);
        uint _e778 = local_134;
        out_1[_e778] = naga_f2i32(_e756);
    }
    {
        original_7.x = static_cast<float>(1);
        original_7.y = static_cast<float>(2);
        original_7.z = static_cast<float>(3);
        float3_ _e793 = original_7;
        points_7.inner[0].inner[0] = _e793;
        points_7.inner[0].inner[1] = float3_ {};
        float3_ _e798 = original_7;
        points_7.inner[1].inner[0] = _e798;
        points_7.inner[1].inner[1].x = static_cast<float>(5);
        points_7.inner[1].inner[1].y = float {};
        points_7.inner[1].inner[1].z = float {};
        float _e812 = points_7.inner[0].inner[0].z;
        type_33 _e815 = out;
        local_42 = _e815;
        local_43 = static_cast<uint>(21);
        type_33 _e820 = local_42;
        local_135 = _e820;
        uint _e821 = local_43;
        uint _e823 = local_135.inner[1];
        local_135.inner[1] = _e823 + _e821;
        uint _e827 = local_135.inner[0];
        local_136 = static_cast<uint>(_e827);
        uint _e831 = local_135.inner[1];
        local_137 = static_cast<uint>(_e831);
        uint _e834 = local_137;
        out_1[_e834] = naga_f2i32(_e812);
        float _e841 = points_7.inner[1].inner[1].x;
        type_33 _e844 = out;
        local_44 = _e844;
        local_45 = static_cast<uint>(22);
        type_33 _e849 = local_44;
        local_138 = _e849;
        uint _e850 = local_45;
        uint _e852 = local_138.inner[1];
        local_138.inner[1] = _e852 + _e850;
        uint _e856 = local_138.inner[0];
        local_139 = static_cast<uint>(_e856);
        uint _e860 = local_138.inner[1];
        local_140 = static_cast<uint>(_e860);
        uint _e863 = local_140;
        out_1[_e863] = naga_f2i32(_e841);
        float _e870 = points_7.inner[1].inner[1].z;
        type_33 _e873 = out;
        local_46 = _e873;
        local_47 = static_cast<uint>(23);
        type_33 _e878 = local_46;
        local_141 = _e878;
        uint _e879 = local_47;
        uint _e881 = local_141.inner[1];
        local_141.inner[1] = _e881 + _e879;
        uint _e885 = local_141.inner[0];
        local_142 = static_cast<uint>(_e885);
        uint _e889 = local_141.inner[1];
        local_143 = static_cast<uint>(_e889);
        uint _e892 = local_143;
        out_1[_e892] = naga_f2i32(_e870);
    }
    {
        original_8.x = static_cast<float>(1);
        original_8.y = static_cast<float>(2);
        original_8.z = static_cast<float>(3);
        original_8.w = static_cast<float>(4);
        metal::float4 _e910 = original_8;
        points_8.inner[0].inner[0] = _e910;
        points_8.inner[0].inner[1] = metal::float4 {};
        metal::float4 _e915 = original_8;
        points_8.inner[1].inner[0] = _e915;
        points_8.inner[1].inner[1].x = static_cast<float>(5);
        points_8.inner[1].inner[1].y = float {};
        points_8.inner[1].inner[1].z = float {};
        points_8.inner[1].inner[1].w = float {};
        float _e931 = points_8.inner[0].inner[0].w;
        type_33 _e934 = out;
        local_48 = _e934;
        local_49 = static_cast<uint>(24);
        type_33 _e939 = local_48;
        local_144 = _e939;
        uint _e940 = local_49;
        uint _e942 = local_144.inner[1];
        local_144.inner[1] = _e942 + _e940;
        uint _e946 = local_144.inner[0];
        local_145 = static_cast<uint>(_e946);
        uint _e950 = local_144.inner[1];
        local_146 = static_cast<uint>(_e950);
        uint _e953 = local_146;
        out_1[_e953] = naga_f2i32(_e931);
        float _e960 = points_8.inner[1].inner[1].x;
        type_33 _e963 = out;
        local_50 = _e963;
        local_51 = static_cast<uint>(25);
        type_33 _e968 = local_50;
        local_147 = _e968;
        uint _e969 = local_51;
        uint _e971 = local_147.inner[1];
        local_147.inner[1] = _e971 + _e969;
        uint _e975 = local_147.inner[0];
        local_148 = static_cast<uint>(_e975);
        uint _e979 = local_147.inner[1];
        local_149 = static_cast<uint>(_e979);
        uint _e982 = local_149;
        out_1[_e982] = naga_f2i32(_e960);
        float _e989 = points_8.inner[1].inner[1].w;
        type_33 _e992 = out;
        local_52 = _e992;
        local_53 = static_cast<uint>(26);
        type_33 _e997 = local_52;
        local_150 = _e997;
        uint _e998 = local_53;
        uint _e1000 = local_150.inner[1];
        local_150.inner[1] = _e1000 + _e998;
        uint _e1004 = local_150.inner[0];
        local_151 = static_cast<uint>(_e1004);
        uint _e1008 = local_150.inner[1];
        local_152 = static_cast<uint>(_e1008);
        uint _e1011 = local_152;
        out_1[_e1011] = naga_f2i32(_e989);
    }
    changed.inner[0].inner[0] = 1;
    local_54 = 1u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e1024 = local_54;
            local_54 = _e1024 + 1u;
        }
        loop_init = false;
        uint _e1019 = local_54;
        if (_e1019 >= 2u) {
            break;
        }
        changed.inner[0].inner[_e1019] = int {};
    }
    changed.inner[0].inner[1] = 9;
    changed.inner[1].inner[0] = 2;
    changed.inner[1].inner[1] = 3;
    local_55 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e1054 = local_55;
            local_55 = _e1054 + 1u;
        }
        loop_init_1 = false;
        uint _e1039 = local_55;
        if (_e1039 >= 2u) {
            break;
        }
        local_56 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e1051 = local_56;
                local_56 = _e1051 + 1u;
            }
            loop_init_2 = false;
            uint _e1046 = local_56;
            if (_e1046 >= 3u) {
                break;
            }
            nested_empty.inner[_e1039].inner[_e1046] = int {};
        }
    }
    partial.inner[0].inner[0] = 1;
    local_57 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e1068 = local_57;
            local_57 = _e1068 + 1u;
        }
        loop_init_3 = false;
        uint _e1063 = local_57;
        if (_e1063 >= 3u) {
            break;
        }
        partial.inner[0].inner[_e1063] = int {};
    }
    local_58 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e1087 = local_58;
            local_58 = _e1087 + 1u;
        }
        loop_init_4 = false;
        uint _e1073 = local_58;
        if (_e1073 >= 2u) {
            break;
        }
        local_59 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e1084 = local_59;
                local_59 = _e1084 + 1u;
            }
            loop_init_5 = false;
            uint _e1079 = local_59;
            if (_e1079 >= 3u) {
                break;
            }
            partial.inner[_e1073].inner[_e1079] = int {};
        }
    }
    volume.inner[0].inner[0].inner[0] = 1;
    local_60 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e1102 = local_60;
            local_60 = _e1102 + 1u;
        }
        loop_init_6 = false;
        uint _e1097 = local_60;
        if (_e1097 >= 3u) {
            break;
        }
        volume.inner[0].inner[0].inner[_e1097] = int {};
    }
    local_61 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e1121 = local_61;
            local_61 = _e1121 + 1u;
        }
        loop_init_7 = false;
        uint _e1107 = local_61;
        if (_e1107 >= 2u) {
            break;
        }
        local_62 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (metal::all(loop_bound_8 == uint2(0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e1118 = local_62;
                local_62 = _e1118 + 1u;
            }
            loop_init_8 = false;
            uint _e1113 = local_62;
            if (_e1113 >= 3u) {
                break;
            }
            volume.inner[0].inner[_e1107].inner[_e1113] = int {};
        }
    }
    local_63 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e1149 = local_63;
            local_63 = _e1149 + 1u;
        }
        loop_init_9 = false;
        uint _e1126 = local_63;
        if (_e1126 >= 2u) {
            break;
        }
        local_64 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (metal::all(loop_bound_10 == uint2(0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e1146 = local_64;
                local_64 = _e1146 + 1u;
            }
            loop_init_10 = false;
            uint _e1132 = local_64;
            if (_e1132 >= 2u) {
                break;
            }
            local_65 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (metal::all(loop_bound_11 == uint2(0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e1143 = local_65;
                    local_65 = _e1143 + 1u;
                }
                loop_init_11 = false;
                uint _e1138 = local_65;
                if (_e1138 >= 3u) {
                    break;
                }
                volume.inner[_e1126].inner[_e1132].inner[_e1138] = int {};
            }
        }
    }
    int _e1156 = changed.inner[0].inner[1];
    shared_values.inner[1].inner[2] = _e1156;
    int _e1166 = changed.inner[1].inner[0];
    int _e1171 = changed.inner[1].inner[1];
    shared_points.inner[1].inner[0] = float3_ {static_cast<float>(_e1166), static_cast<float>(_e1171), static_cast<float>(4)};
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    int _e1191 = shared_values.inner[1].inner[2];
    int _e1192 = nested_empty.inner[1].inner[2];
    int _e1198 = partial.inner[1].inner[2];
    int _e1206 = volume.inner[1].inner[1].inner[2];
    type_33 _e1209 = out;
    local_66 = _e1209;
    local_67 = static_cast<uint>(27);
    type_33 _e1214 = local_66;
    local_153 = _e1214;
    uint _e1215 = local_67;
    uint _e1217 = local_153.inner[1];
    local_153.inner[1] = _e1217 + _e1215;
    uint _e1221 = local_153.inner[0];
    local_154 = static_cast<uint>(_e1221);
    uint _e1225 = local_153.inner[1];
    local_155 = static_cast<uint>(_e1225);
    uint _e1228 = local_155;
    out_1[_e1228] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e1191) + as_type<uint>(_e1192))) + as_type<uint>(_e1198))) + as_type<uint>(_e1206));
    float _e1235 = shared_points.inner[1].inner[0].x;
    type_33 _e1238 = out;
    local_68 = _e1238;
    local_69 = static_cast<uint>(28);
    type_33 _e1243 = local_68;
    local_156 = _e1243;
    uint _e1244 = local_69;
    uint _e1246 = local_156.inner[1];
    local_156.inner[1] = _e1246 + _e1244;
    uint _e1250 = local_156.inner[0];
    local_157 = static_cast<uint>(_e1250);
    uint _e1254 = local_156.inner[1];
    local_158 = static_cast<uint>(_e1254);
    uint _e1257 = local_158;
    out_1[_e1257] = naga_f2i32(_e1235);
    float _e1264 = shared_points.inner[1].inner[0].y;
    type_33 _e1267 = out;
    local_70 = _e1267;
    local_71 = static_cast<uint>(29);
    type_33 _e1272 = local_70;
    local_159 = _e1272;
    uint _e1273 = local_71;
    uint _e1275 = local_159.inner[1];
    local_159.inner[1] = _e1275 + _e1273;
    uint _e1279 = local_159.inner[0];
    local_160 = static_cast<uint>(_e1279);
    uint _e1283 = local_159.inner[1];
    local_161 = static_cast<uint>(_e1283);
    uint _e1286 = local_161;
    out_1[_e1286] = naga_f2i32(_e1264);
}
