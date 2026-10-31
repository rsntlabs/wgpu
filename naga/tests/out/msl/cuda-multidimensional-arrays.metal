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
    type_33 local = {};
    metal::int2 original = {};
    type_5 points = {};
    type_33 local_1 = {};
    uint local_2 = {};
    type_33 local_3 = {};
    uint local_4 = {};
    type_33 local_5 = {};
    uint local_6 = {};
    int3_ original_1 = {};
    type_7 points_1 = {};
    type_33 local_7 = {};
    uint local_8 = {};
    type_33 local_9 = {};
    uint local_10 = {};
    type_33 local_11 = {};
    uint local_12 = {};
    metal::int4 original_2 = {};
    type_10 points_2 = {};
    type_33 local_13 = {};
    uint local_14 = {};
    type_33 local_15 = {};
    uint local_16 = {};
    type_33 local_17 = {};
    uint local_18 = {};
    metal::uint2 original_3 = {};
    type_13 points_3 = {};
    type_33 local_19 = {};
    uint local_20 = {};
    type_33 local_21 = {};
    uint local_22 = {};
    type_33 local_23 = {};
    uint local_24 = {};
    uint3_ original_4 = {};
    type_15 points_4 = {};
    type_33 local_25 = {};
    uint local_26 = {};
    type_33 local_27 = {};
    uint local_28 = {};
    type_33 local_29 = {};
    uint local_30 = {};
    metal::uint4 original_5 = {};
    type_18 points_5 = {};
    type_33 local_31 = {};
    uint local_32 = {};
    type_33 local_33 = {};
    uint local_34 = {};
    type_33 local_35 = {};
    uint local_36 = {};
    metal::float2 original_6 = {};
    type_22 points_6 = {};
    type_33 local_37 = {};
    uint local_38 = {};
    type_33 local_39 = {};
    uint local_40 = {};
    type_33 local_41 = {};
    uint local_42 = {};
    float3_ original_7 = {};
    type_24 points_7 = {};
    type_33 local_43 = {};
    uint local_44 = {};
    type_33 local_45 = {};
    uint local_46 = {};
    type_33 local_47 = {};
    uint local_48 = {};
    metal::float4 original_8 = {};
    type_27 points_8 = {};
    type_33 local_49 = {};
    uint local_50 = {};
    type_33 local_51 = {};
    uint local_52 = {};
    type_33 local_53 = {};
    uint local_54 = {};
    type_29 changed = {};
    uint local_55 = {};
    type_31 nested_empty = {};
    uint local_56 = {};
    uint local_57 = {};
    type_31 partial = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    type_32 volume = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    type_33 local_67 = {};
    uint local_68 = {};
    type_33 local_69 = {};
    uint local_70 = {};
    type_33 local_71 = {};
    uint local_72 = {};
    type_33 local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    type_33 local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    type_33 local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    type_33 local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    type_33 local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    type_33 local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    type_33 local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    type_33 local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    type_33 local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    type_33 local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    type_33 local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    type_33 local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    type_33 local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    type_33 local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    type_33 local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    type_33 local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    type_33 local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    type_33 local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    type_33 local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    type_33 local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    type_33 local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    type_33 local_136 = {};
    uint local_137 = {};
    uint local_138 = {};
    type_33 local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    type_33 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    type_33 local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    type_33 local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    type_33 local_151 = {};
    uint local_152 = {};
    uint local_153 = {};
    type_33 local_154 = {};
    uint local_155 = {};
    uint local_156 = {};
    type_33 local_157 = {};
    uint local_158 = {};
    uint local_159 = {};
    type_33 local_160 = {};
    uint local_161 = {};
    uint local_162 = {};
    local = type_33 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
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
        type_33 _e34 = local;
        local_1 = _e34;
        local_2 = static_cast<uint>(0);
        type_33 _e39 = local_1;
        local_73 = _e39;
        uint _e40 = local_2;
        uint _e42 = local_73.inner[1];
        local_73.inner[1] = _e42 + _e40;
        uint _e46 = local_73.inner[0];
        local_74 = static_cast<uint>(_e46);
        uint _e50 = local_73.inner[1];
        local_75 = static_cast<uint>(_e50);
        uint _e53 = local_75;
        out[_e53] = _e31;
        int _e60 = points.inner[1].inner[1].x;
        type_33 _e62 = local;
        local_3 = _e62;
        local_4 = static_cast<uint>(1);
        type_33 _e67 = local_3;
        local_76 = _e67;
        uint _e68 = local_4;
        uint _e70 = local_76.inner[1];
        local_76.inner[1] = _e70 + _e68;
        uint _e74 = local_76.inner[0];
        local_77 = static_cast<uint>(_e74);
        uint _e78 = local_76.inner[1];
        local_78 = static_cast<uint>(_e78);
        uint _e81 = local_78;
        out[_e81] = _e60;
        int _e88 = points.inner[1].inner[1].y;
        type_33 _e90 = local;
        local_5 = _e90;
        local_6 = static_cast<uint>(2);
        type_33 _e95 = local_5;
        local_79 = _e95;
        uint _e96 = local_6;
        uint _e98 = local_79.inner[1];
        local_79.inner[1] = _e98 + _e96;
        uint _e102 = local_79.inner[0];
        local_80 = static_cast<uint>(_e102);
        uint _e106 = local_79.inner[1];
        local_81 = static_cast<uint>(_e106);
        uint _e109 = local_81;
        out[_e109] = _e88;
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
        type_33 _e141 = local;
        local_7 = _e141;
        local_8 = static_cast<uint>(3);
        type_33 _e146 = local_7;
        local_82 = _e146;
        uint _e147 = local_8;
        uint _e149 = local_82.inner[1];
        local_82.inner[1] = _e149 + _e147;
        uint _e153 = local_82.inner[0];
        local_83 = static_cast<uint>(_e153);
        uint _e157 = local_82.inner[1];
        local_84 = static_cast<uint>(_e157);
        uint _e160 = local_84;
        out[_e160] = _e139;
        int _e167 = points_1.inner[1].inner[1].x;
        type_33 _e169 = local;
        local_9 = _e169;
        local_10 = static_cast<uint>(4);
        type_33 _e174 = local_9;
        local_85 = _e174;
        uint _e175 = local_10;
        uint _e177 = local_85.inner[1];
        local_85.inner[1] = _e177 + _e175;
        uint _e181 = local_85.inner[0];
        local_86 = static_cast<uint>(_e181);
        uint _e185 = local_85.inner[1];
        local_87 = static_cast<uint>(_e185);
        uint _e188 = local_87;
        out[_e188] = _e167;
        int _e195 = points_1.inner[1].inner[1].z;
        type_33 _e197 = local;
        local_11 = _e197;
        local_12 = static_cast<uint>(5);
        type_33 _e202 = local_11;
        local_88 = _e202;
        uint _e203 = local_12;
        uint _e205 = local_88.inner[1];
        local_88.inner[1] = _e205 + _e203;
        uint _e209 = local_88.inner[0];
        local_89 = static_cast<uint>(_e209);
        uint _e213 = local_88.inner[1];
        local_90 = static_cast<uint>(_e213);
        uint _e216 = local_90;
        out[_e216] = _e195;
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
        type_33 _e252 = local;
        local_13 = _e252;
        local_14 = static_cast<uint>(6);
        type_33 _e257 = local_13;
        local_91 = _e257;
        uint _e258 = local_14;
        uint _e260 = local_91.inner[1];
        local_91.inner[1] = _e260 + _e258;
        uint _e264 = local_91.inner[0];
        local_92 = static_cast<uint>(_e264);
        uint _e268 = local_91.inner[1];
        local_93 = static_cast<uint>(_e268);
        uint _e271 = local_93;
        out[_e271] = _e250;
        int _e278 = points_2.inner[1].inner[1].x;
        type_33 _e280 = local;
        local_15 = _e280;
        local_16 = static_cast<uint>(7);
        type_33 _e285 = local_15;
        local_94 = _e285;
        uint _e286 = local_16;
        uint _e288 = local_94.inner[1];
        local_94.inner[1] = _e288 + _e286;
        uint _e292 = local_94.inner[0];
        local_95 = static_cast<uint>(_e292);
        uint _e296 = local_94.inner[1];
        local_96 = static_cast<uint>(_e296);
        uint _e299 = local_96;
        out[_e299] = _e278;
        int _e306 = points_2.inner[1].inner[1].w;
        type_33 _e308 = local;
        local_17 = _e308;
        local_18 = static_cast<uint>(8);
        type_33 _e313 = local_17;
        local_97 = _e313;
        uint _e314 = local_18;
        uint _e316 = local_97.inner[1];
        local_97.inner[1] = _e316 + _e314;
        uint _e320 = local_97.inner[0];
        local_98 = static_cast<uint>(_e320);
        uint _e324 = local_97.inner[1];
        local_99 = static_cast<uint>(_e324);
        uint _e327 = local_99;
        out[_e327] = _e306;
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
        type_33 _e359 = local;
        local_19 = _e359;
        local_20 = static_cast<uint>(9);
        type_33 _e364 = local_19;
        local_100 = _e364;
        uint _e365 = local_20;
        uint _e367 = local_100.inner[1];
        local_100.inner[1] = _e367 + _e365;
        uint _e371 = local_100.inner[0];
        local_101 = static_cast<uint>(_e371);
        uint _e375 = local_100.inner[1];
        local_102 = static_cast<uint>(_e375);
        uint _e378 = local_102;
        out[_e378] = static_cast<int>(_e356);
        uint _e385 = points_3.inner[1].inner[1].x;
        type_33 _e388 = local;
        local_21 = _e388;
        local_22 = static_cast<uint>(10);
        type_33 _e393 = local_21;
        local_103 = _e393;
        uint _e394 = local_22;
        uint _e396 = local_103.inner[1];
        local_103.inner[1] = _e396 + _e394;
        uint _e400 = local_103.inner[0];
        local_104 = static_cast<uint>(_e400);
        uint _e404 = local_103.inner[1];
        local_105 = static_cast<uint>(_e404);
        uint _e407 = local_105;
        out[_e407] = static_cast<int>(_e385);
        uint _e414 = points_3.inner[1].inner[1].y;
        type_33 _e417 = local;
        local_23 = _e417;
        local_24 = static_cast<uint>(11);
        type_33 _e422 = local_23;
        local_106 = _e422;
        uint _e423 = local_24;
        uint _e425 = local_106.inner[1];
        local_106.inner[1] = _e425 + _e423;
        uint _e429 = local_106.inner[0];
        local_107 = static_cast<uint>(_e429);
        uint _e433 = local_106.inner[1];
        local_108 = static_cast<uint>(_e433);
        uint _e436 = local_108;
        out[_e436] = static_cast<int>(_e414);
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
        type_33 _e473 = local;
        local_25 = _e473;
        local_26 = static_cast<uint>(12);
        type_33 _e478 = local_25;
        local_109 = _e478;
        uint _e479 = local_26;
        uint _e481 = local_109.inner[1];
        local_109.inner[1] = _e481 + _e479;
        uint _e485 = local_109.inner[0];
        local_110 = static_cast<uint>(_e485);
        uint _e489 = local_109.inner[1];
        local_111 = static_cast<uint>(_e489);
        uint _e492 = local_111;
        out[_e492] = static_cast<int>(_e470);
        uint _e499 = points_4.inner[1].inner[1].x;
        type_33 _e502 = local;
        local_27 = _e502;
        local_28 = static_cast<uint>(13);
        type_33 _e507 = local_27;
        local_112 = _e507;
        uint _e508 = local_28;
        uint _e510 = local_112.inner[1];
        local_112.inner[1] = _e510 + _e508;
        uint _e514 = local_112.inner[0];
        local_113 = static_cast<uint>(_e514);
        uint _e518 = local_112.inner[1];
        local_114 = static_cast<uint>(_e518);
        uint _e521 = local_114;
        out[_e521] = static_cast<int>(_e499);
        uint _e528 = points_4.inner[1].inner[1].z;
        type_33 _e531 = local;
        local_29 = _e531;
        local_30 = static_cast<uint>(14);
        type_33 _e536 = local_29;
        local_115 = _e536;
        uint _e537 = local_30;
        uint _e539 = local_115.inner[1];
        local_115.inner[1] = _e539 + _e537;
        uint _e543 = local_115.inner[0];
        local_116 = static_cast<uint>(_e543);
        uint _e547 = local_115.inner[1];
        local_117 = static_cast<uint>(_e547);
        uint _e550 = local_117;
        out[_e550] = static_cast<int>(_e528);
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
        type_33 _e592 = local;
        local_31 = _e592;
        local_32 = static_cast<uint>(15);
        type_33 _e597 = local_31;
        local_118 = _e597;
        uint _e598 = local_32;
        uint _e600 = local_118.inner[1];
        local_118.inner[1] = _e600 + _e598;
        uint _e604 = local_118.inner[0];
        local_119 = static_cast<uint>(_e604);
        uint _e608 = local_118.inner[1];
        local_120 = static_cast<uint>(_e608);
        uint _e611 = local_120;
        out[_e611] = static_cast<int>(_e589);
        uint _e618 = points_5.inner[1].inner[1].x;
        type_33 _e621 = local;
        local_33 = _e621;
        local_34 = static_cast<uint>(16);
        type_33 _e626 = local_33;
        local_121 = _e626;
        uint _e627 = local_34;
        uint _e629 = local_121.inner[1];
        local_121.inner[1] = _e629 + _e627;
        uint _e633 = local_121.inner[0];
        local_122 = static_cast<uint>(_e633);
        uint _e637 = local_121.inner[1];
        local_123 = static_cast<uint>(_e637);
        uint _e640 = local_123;
        out[_e640] = static_cast<int>(_e618);
        uint _e647 = points_5.inner[1].inner[1].w;
        type_33 _e650 = local;
        local_35 = _e650;
        local_36 = static_cast<uint>(17);
        type_33 _e655 = local_35;
        local_124 = _e655;
        uint _e656 = local_36;
        uint _e658 = local_124.inner[1];
        local_124.inner[1] = _e658 + _e656;
        uint _e662 = local_124.inner[0];
        local_125 = static_cast<uint>(_e662);
        uint _e666 = local_124.inner[1];
        local_126 = static_cast<uint>(_e666);
        uint _e669 = local_126;
        out[_e669] = static_cast<int>(_e647);
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
        type_33 _e701 = local;
        local_37 = _e701;
        local_38 = static_cast<uint>(18);
        type_33 _e706 = local_37;
        local_127 = _e706;
        uint _e707 = local_38;
        uint _e709 = local_127.inner[1];
        local_127.inner[1] = _e709 + _e707;
        uint _e713 = local_127.inner[0];
        local_128 = static_cast<uint>(_e713);
        uint _e717 = local_127.inner[1];
        local_129 = static_cast<uint>(_e717);
        uint _e720 = local_129;
        out[_e720] = naga_f2i32(_e698);
        float _e727 = points_6.inner[1].inner[1].x;
        type_33 _e730 = local;
        local_39 = _e730;
        local_40 = static_cast<uint>(19);
        type_33 _e735 = local_39;
        local_130 = _e735;
        uint _e736 = local_40;
        uint _e738 = local_130.inner[1];
        local_130.inner[1] = _e738 + _e736;
        uint _e742 = local_130.inner[0];
        local_131 = static_cast<uint>(_e742);
        uint _e746 = local_130.inner[1];
        local_132 = static_cast<uint>(_e746);
        uint _e749 = local_132;
        out[_e749] = naga_f2i32(_e727);
        float _e756 = points_6.inner[1].inner[1].y;
        type_33 _e759 = local;
        local_41 = _e759;
        local_42 = static_cast<uint>(20);
        type_33 _e764 = local_41;
        local_133 = _e764;
        uint _e765 = local_42;
        uint _e767 = local_133.inner[1];
        local_133.inner[1] = _e767 + _e765;
        uint _e771 = local_133.inner[0];
        local_134 = static_cast<uint>(_e771);
        uint _e775 = local_133.inner[1];
        local_135 = static_cast<uint>(_e775);
        uint _e778 = local_135;
        out[_e778] = naga_f2i32(_e756);
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
        type_33 _e815 = local;
        local_43 = _e815;
        local_44 = static_cast<uint>(21);
        type_33 _e820 = local_43;
        local_136 = _e820;
        uint _e821 = local_44;
        uint _e823 = local_136.inner[1];
        local_136.inner[1] = _e823 + _e821;
        uint _e827 = local_136.inner[0];
        local_137 = static_cast<uint>(_e827);
        uint _e831 = local_136.inner[1];
        local_138 = static_cast<uint>(_e831);
        uint _e834 = local_138;
        out[_e834] = naga_f2i32(_e812);
        float _e841 = points_7.inner[1].inner[1].x;
        type_33 _e844 = local;
        local_45 = _e844;
        local_46 = static_cast<uint>(22);
        type_33 _e849 = local_45;
        local_139 = _e849;
        uint _e850 = local_46;
        uint _e852 = local_139.inner[1];
        local_139.inner[1] = _e852 + _e850;
        uint _e856 = local_139.inner[0];
        local_140 = static_cast<uint>(_e856);
        uint _e860 = local_139.inner[1];
        local_141 = static_cast<uint>(_e860);
        uint _e863 = local_141;
        out[_e863] = naga_f2i32(_e841);
        float _e870 = points_7.inner[1].inner[1].z;
        type_33 _e873 = local;
        local_47 = _e873;
        local_48 = static_cast<uint>(23);
        type_33 _e878 = local_47;
        local_142 = _e878;
        uint _e879 = local_48;
        uint _e881 = local_142.inner[1];
        local_142.inner[1] = _e881 + _e879;
        uint _e885 = local_142.inner[0];
        local_143 = static_cast<uint>(_e885);
        uint _e889 = local_142.inner[1];
        local_144 = static_cast<uint>(_e889);
        uint _e892 = local_144;
        out[_e892] = naga_f2i32(_e870);
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
        type_33 _e934 = local;
        local_49 = _e934;
        local_50 = static_cast<uint>(24);
        type_33 _e939 = local_49;
        local_145 = _e939;
        uint _e940 = local_50;
        uint _e942 = local_145.inner[1];
        local_145.inner[1] = _e942 + _e940;
        uint _e946 = local_145.inner[0];
        local_146 = static_cast<uint>(_e946);
        uint _e950 = local_145.inner[1];
        local_147 = static_cast<uint>(_e950);
        uint _e953 = local_147;
        out[_e953] = naga_f2i32(_e931);
        float _e960 = points_8.inner[1].inner[1].x;
        type_33 _e963 = local;
        local_51 = _e963;
        local_52 = static_cast<uint>(25);
        type_33 _e968 = local_51;
        local_148 = _e968;
        uint _e969 = local_52;
        uint _e971 = local_148.inner[1];
        local_148.inner[1] = _e971 + _e969;
        uint _e975 = local_148.inner[0];
        local_149 = static_cast<uint>(_e975);
        uint _e979 = local_148.inner[1];
        local_150 = static_cast<uint>(_e979);
        uint _e982 = local_150;
        out[_e982] = naga_f2i32(_e960);
        float _e989 = points_8.inner[1].inner[1].w;
        type_33 _e992 = local;
        local_53 = _e992;
        local_54 = static_cast<uint>(26);
        type_33 _e997 = local_53;
        local_151 = _e997;
        uint _e998 = local_54;
        uint _e1000 = local_151.inner[1];
        local_151.inner[1] = _e1000 + _e998;
        uint _e1004 = local_151.inner[0];
        local_152 = static_cast<uint>(_e1004);
        uint _e1008 = local_151.inner[1];
        local_153 = static_cast<uint>(_e1008);
        uint _e1011 = local_153;
        out[_e1011] = naga_f2i32(_e989);
    }
    changed.inner[0].inner[0] = 1;
    local_55 = 1u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e1024 = local_55;
            local_55 = _e1024 + 1u;
        }
        loop_init = false;
        uint _e1019 = local_55;
        if (_e1019 >= 2u) {
            break;
        }
        changed.inner[0].inner[_e1019] = int {};
    }
    changed.inner[0].inner[1] = 9;
    changed.inner[1].inner[0] = 2;
    changed.inner[1].inner[1] = 3;
    local_56 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e1054 = local_56;
            local_56 = _e1054 + 1u;
        }
        loop_init_1 = false;
        uint _e1039 = local_56;
        if (_e1039 >= 2u) {
            break;
        }
        local_57 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e1051 = local_57;
                local_57 = _e1051 + 1u;
            }
            loop_init_2 = false;
            uint _e1046 = local_57;
            if (_e1046 >= 3u) {
                break;
            }
            nested_empty.inner[_e1039].inner[_e1046] = int {};
        }
    }
    partial.inner[0].inner[0] = 1;
    local_58 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e1068 = local_58;
            local_58 = _e1068 + 1u;
        }
        loop_init_3 = false;
        uint _e1063 = local_58;
        if (_e1063 >= 3u) {
            break;
        }
        partial.inner[0].inner[_e1063] = int {};
    }
    local_59 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e1087 = local_59;
            local_59 = _e1087 + 1u;
        }
        loop_init_4 = false;
        uint _e1073 = local_59;
        if (_e1073 >= 2u) {
            break;
        }
        local_60 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e1084 = local_60;
                local_60 = _e1084 + 1u;
            }
            loop_init_5 = false;
            uint _e1079 = local_60;
            if (_e1079 >= 3u) {
                break;
            }
            partial.inner[_e1073].inner[_e1079] = int {};
        }
    }
    volume.inner[0].inner[0].inner[0] = 1;
    local_61 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e1102 = local_61;
            local_61 = _e1102 + 1u;
        }
        loop_init_6 = false;
        uint _e1097 = local_61;
        if (_e1097 >= 3u) {
            break;
        }
        volume.inner[0].inner[0].inner[_e1097] = int {};
    }
    local_62 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e1121 = local_62;
            local_62 = _e1121 + 1u;
        }
        loop_init_7 = false;
        uint _e1107 = local_62;
        if (_e1107 >= 2u) {
            break;
        }
        local_63 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (metal::all(loop_bound_8 == uint2(0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e1118 = local_63;
                local_63 = _e1118 + 1u;
            }
            loop_init_8 = false;
            uint _e1113 = local_63;
            if (_e1113 >= 3u) {
                break;
            }
            volume.inner[0].inner[_e1107].inner[_e1113] = int {};
        }
    }
    local_64 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e1149 = local_64;
            local_64 = _e1149 + 1u;
        }
        loop_init_9 = false;
        uint _e1126 = local_64;
        if (_e1126 >= 2u) {
            break;
        }
        local_65 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (metal::all(loop_bound_10 == uint2(0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e1146 = local_65;
                local_65 = _e1146 + 1u;
            }
            loop_init_10 = false;
            uint _e1132 = local_65;
            if (_e1132 >= 2u) {
                break;
            }
            local_66 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (metal::all(loop_bound_11 == uint2(0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e1143 = local_66;
                    local_66 = _e1143 + 1u;
                }
                loop_init_11 = false;
                uint _e1138 = local_66;
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
    type_33 _e1209 = local;
    local_67 = _e1209;
    local_68 = static_cast<uint>(27);
    type_33 _e1214 = local_67;
    local_154 = _e1214;
    uint _e1215 = local_68;
    uint _e1217 = local_154.inner[1];
    local_154.inner[1] = _e1217 + _e1215;
    uint _e1221 = local_154.inner[0];
    local_155 = static_cast<uint>(_e1221);
    uint _e1225 = local_154.inner[1];
    local_156 = static_cast<uint>(_e1225);
    uint _e1228 = local_156;
    out[_e1228] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e1191) + as_type<uint>(_e1192))) + as_type<uint>(_e1198))) + as_type<uint>(_e1206));
    float _e1235 = shared_points.inner[1].inner[0].x;
    type_33 _e1238 = local;
    local_69 = _e1238;
    local_70 = static_cast<uint>(28);
    type_33 _e1243 = local_69;
    local_157 = _e1243;
    uint _e1244 = local_70;
    uint _e1246 = local_157.inner[1];
    local_157.inner[1] = _e1246 + _e1244;
    uint _e1250 = local_157.inner[0];
    local_158 = static_cast<uint>(_e1250);
    uint _e1254 = local_157.inner[1];
    local_159 = static_cast<uint>(_e1254);
    uint _e1257 = local_159;
    out[_e1257] = naga_f2i32(_e1235);
    float _e1264 = shared_points.inner[1].inner[0].y;
    type_33 _e1267 = local;
    local_71 = _e1267;
    local_72 = static_cast<uint>(29);
    type_33 _e1272 = local_71;
    local_160 = _e1272;
    uint _e1273 = local_72;
    uint _e1275 = local_160.inner[1];
    local_160.inner[1] = _e1275 + _e1273;
    uint _e1279 = local_160.inner[0];
    local_161 = static_cast<uint>(_e1279);
    uint _e1283 = local_160.inner[1];
    local_162 = static_cast<uint>(_e1283);
    uint _e1286 = local_162;
    out[_e1286] = naga_f2i32(_e1264);
}
