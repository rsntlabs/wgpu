// language: metal1.2
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];
struct type_5 {
    int inner[2];
};
struct type_6 {
    uint inner[2];
};

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int signed_conversion(
    float first_1,
    float second_1
) {
    return as_type<int>(as_type<uint>(metal::extract_bits(naga_f2i32(first_1), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(naga_f2i32(second_1), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

uint unsigned_conversion(
    float first_2,
    float second_2
) {
    return metal::extract_bits(naga_f2u32(first_2), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(naga_f2u32(second_2), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
}

int _mul24_(
    bool first_3,
    bool second_3
) {
    int local_162 = {};
    int local_163 = {};
    if (first_3) {
        if (second_3) {
            local_162 = 71;
        } else {
            local_162 = 73;
        }
        int _e7 = local_162;
        local_163 = _e7;
    } else {
        local_163 = 79;
    }
    int _e12 = local_163;
    return _e12;
}

int _mul24_1(
    float first_4,
    float second_4
) {
    return naga_f2i32((first_4 * 10.0) + second_4);
}

uint _umul24_(
    int first_5,
    int second_5
) {
    return static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first_5) + as_type<uint>(second_5))) + as_type<uint>(100)));
}

int signed_pair(
    int first_6,
    int second_6
) {
    return as_type<int>(as_type<uint>(metal::extract_bits(first_6, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(second_6, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void multiply24_(
  device type_4& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 out = {};
    type_6 local = {};
    uint local_1 = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    type_6 local_6 = {};
    uint local_7 = {};
    type_6 local_8 = {};
    uint local_9 = {};
    type_6 local_10 = {};
    uint local_11 = {};
    type_6 local_12 = {};
    uint local_13 = {};
    type_6 local_14 = {};
    uint local_15 = {};
    type_6 local_16 = {};
    uint local_17 = {};
    type_6 local_18 = {};
    uint local_19 = {};
    type_6 local_20 = {};
    uint local_21 = {};
    type_6 local_22 = {};
    uint local_23 = {};
    type_6 local_24 = {};
    uint local_25 = {};
    type_6 local_26 = {};
    uint local_27 = {};
    type_6 local_28 = {};
    uint local_29 = {};
    type_6 local_30 = {};
    uint local_31 = {};
    type_6 local_32 = {};
    uint local_33 = {};
    type_6 local_34 = {};
    uint local_35 = {};
    type_6 local_36 = {};
    uint local_37 = {};
    type_6 local_38 = {};
    uint local_39 = {};
    int first = {};
    uint second = {};
    type_6 local_40 = {};
    uint local_41 = {};
    type_6 local_42 = {};
    uint local_43 = {};
    type_6 local_44 = {};
    uint local_45 = {};
    type_6 local_46 = {};
    uint local_47 = {};
    type_6 local_48 = {};
    uint local_49 = {};
    int local_50 = {};
    type_5 values = {};
    type_6 local_51 = {};
    uint local_52 = {};
    int Count = {};
    int local_53 = {};
    type_5 scratch = {};
    type_6 local_54 = {};
    uint local_55 = {};
    int counter = {};
    type_6 local_56 = {};
    uint local_57 = {};
    type_6 local_58 = {};
    uint local_59 = {};
    int total = {};
    int index = {};
    type_6 local_60 = {};
    uint local_61 = {};
    type_6 local_62 = {};
    uint local_63 = {};
    type_6 local_64 = {};
    uint local_65 = {};
    type_6 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_6 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_6 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_6 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_6 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_6 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_6 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_6 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_6 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_6 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_6 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_6 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_6 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_6 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_6 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_6 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_6 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_6 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_6 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_6 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_6 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_6 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_6 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_6 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_6 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    type_6 local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    type_6 local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    type_6 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    type_6 local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    type_6 local_153 = {};
    uint local_154 = {};
    uint local_155 = {};
    type_6 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    type_6 local_159 = {};
    uint local_160 = {};
    uint local_161 = {};
    out = type_6 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    type_6 _e20 = out;
    local = _e20;
    local_1 = static_cast<uint>(0);
    type_6 _e25 = local;
    local_66 = _e25;
    uint _e26 = local_1;
    uint _e28 = local_66.inner[1];
    local_66.inner[1] = _e28 + _e26;
    uint _e32 = local_66.inner[0];
    local_67 = static_cast<uint>(_e32);
    uint _e36 = local_66.inner[1];
    local_68 = static_cast<uint>(_e36);
    uint _e39 = local_68;
    out_1[_e39] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388608, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(1, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e49 = out;
    local_2 = _e49;
    local_3 = static_cast<uint>(1);
    type_6 _e54 = local_2;
    local_69 = _e54;
    uint _e55 = local_3;
    uint _e57 = local_69.inner[1];
    local_69.inner[1] = _e57 + _e55;
    uint _e61 = local_69.inner[0];
    local_70 = static_cast<uint>(_e61);
    uint _e65 = local_69.inner[1];
    local_71 = static_cast<uint>(_e65);
    uint _e68 = local_71;
    out_1[_e68] = metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    type_6 _e82 = out;
    local_4 = _e82;
    local_5 = static_cast<uint>(2);
    type_6 _e87 = local_4;
    local_72 = _e87;
    uint _e88 = local_5;
    uint _e90 = local_72.inner[1];
    local_72.inner[1] = _e90 + _e88;
    uint _e94 = local_72.inner[0];
    local_73 = static_cast<uint>(_e94);
    uint _e98 = local_72.inner[1];
    local_74 = static_cast<uint>(_e98);
    uint _e101 = local_74;
    out_1[_e101] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e111 = out;
    local_6 = _e111;
    local_7 = static_cast<uint>(3);
    type_6 _e116 = local_6;
    local_75 = _e116;
    uint _e117 = local_7;
    uint _e119 = local_75.inner[1];
    local_75.inner[1] = _e119 + _e117;
    uint _e123 = local_75.inner[0];
    local_76 = static_cast<uint>(_e123);
    uint _e127 = local_75.inner[1];
    local_77 = static_cast<uint>(_e127);
    uint _e130 = local_77;
    out_1[_e130] = metal::extract_bits(16777216u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(13u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e135 = signed_conversion(3.75, -(2.75));
    type_6 _e138 = out;
    local_8 = _e138;
    local_9 = static_cast<uint>(4);
    type_6 _e143 = local_8;
    local_78 = _e143;
    uint _e144 = local_9;
    uint _e146 = local_78.inner[1];
    local_78.inner[1] = _e146 + _e144;
    uint _e150 = local_78.inner[0];
    local_79 = static_cast<uint>(_e150);
    uint _e154 = local_78.inner[1];
    local_80 = static_cast<uint>(_e154);
    uint _e157 = local_80;
    out_1[_e157] = static_cast<uint>(_e135);
    int _e162 = signed_conversion(-(3.75), 2.75);
    type_6 _e165 = out;
    local_10 = _e165;
    local_11 = static_cast<uint>(5);
    type_6 _e170 = local_10;
    local_81 = _e170;
    uint _e171 = local_11;
    uint _e173 = local_81.inner[1];
    local_81.inner[1] = _e173 + _e171;
    uint _e177 = local_81.inner[0];
    local_82 = static_cast<uint>(_e177);
    uint _e181 = local_81.inner[1];
    local_83 = static_cast<uint>(_e181);
    uint _e184 = local_83;
    out_1[_e184] = static_cast<uint>(_e162);
    uint _e188 = unsigned_conversion(3.75, 2.75);
    type_6 _e190 = out;
    local_12 = _e190;
    local_13 = static_cast<uint>(6);
    type_6 _e195 = local_12;
    local_84 = _e195;
    uint _e196 = local_13;
    uint _e198 = local_84.inner[1];
    local_84.inner[1] = _e198 + _e196;
    uint _e202 = local_84.inner[0];
    local_85 = static_cast<uint>(_e202);
    uint _e206 = local_84.inner[1];
    local_86 = static_cast<uint>(_e206);
    uint _e209 = local_86;
    out_1[_e209] = _e188;
    uint _e213 = unsigned_conversion(16777215.0, 1.0);
    type_6 _e215 = out;
    local_14 = _e215;
    local_15 = static_cast<uint>(7);
    type_6 _e220 = local_14;
    local_87 = _e220;
    uint _e221 = local_15;
    uint _e223 = local_87.inner[1];
    local_87.inner[1] = _e223 + _e221;
    uint _e227 = local_87.inner[0];
    local_88 = static_cast<uint>(_e227);
    uint _e231 = local_87.inner[1];
    local_89 = static_cast<uint>(_e231);
    uint _e234 = local_89;
    out_1[_e234] = _e213;
    int _e238 = _mul24_(true, true);
    type_6 _e241 = out;
    local_16 = _e241;
    local_17 = static_cast<uint>(8);
    type_6 _e246 = local_16;
    local_90 = _e246;
    uint _e247 = local_17;
    uint _e249 = local_90.inner[1];
    local_90.inner[1] = _e249 + _e247;
    uint _e253 = local_90.inner[0];
    local_91 = static_cast<uint>(_e253);
    uint _e257 = local_90.inner[1];
    local_92 = static_cast<uint>(_e257);
    uint _e260 = local_92;
    out_1[_e260] = static_cast<uint>(_e238);
    int _e264 = _mul24_(false, true);
    type_6 _e267 = out;
    local_18 = _e267;
    local_19 = static_cast<uint>(9);
    type_6 _e272 = local_18;
    local_93 = _e272;
    uint _e273 = local_19;
    uint _e275 = local_93.inner[1];
    local_93.inner[1] = _e275 + _e273;
    uint _e279 = local_93.inner[0];
    local_94 = static_cast<uint>(_e279);
    uint _e283 = local_93.inner[1];
    local_95 = static_cast<uint>(_e283);
    uint _e286 = local_95;
    out_1[_e286] = static_cast<uint>(_e264);
    type_6 _e301 = out;
    local_20 = _e301;
    local_21 = static_cast<uint>(10);
    type_6 _e306 = local_20;
    local_96 = _e306;
    uint _e307 = local_21;
    uint _e309 = local_96.inner[1];
    local_96.inner[1] = _e309 + _e307;
    uint _e313 = local_96.inner[0];
    local_97 = static_cast<uint>(_e313);
    uint _e317 = local_96.inner[1];
    local_98 = static_cast<uint>(_e317);
    uint _e320 = local_98;
    out_1[_e320] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e335 = out;
    local_22 = _e335;
    local_23 = static_cast<uint>(11);
    type_6 _e340 = local_22;
    local_99 = _e340;
    uint _e341 = local_23;
    uint _e343 = local_99.inner[1];
    local_99.inner[1] = _e343 + _e341;
    uint _e347 = local_99.inner[0];
    local_100 = static_cast<uint>(_e347);
    uint _e351 = local_99.inner[1];
    local_101 = static_cast<uint>(_e351);
    uint _e354 = local_101;
    out_1[_e354] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e358 = _mul24_1(3.75, 2.0);
    type_6 _e361 = out;
    local_24 = _e361;
    local_25 = static_cast<uint>(12);
    type_6 _e366 = local_24;
    local_102 = _e366;
    uint _e367 = local_25;
    uint _e369 = local_102.inner[1];
    local_102.inner[1] = _e369 + _e367;
    uint _e373 = local_102.inner[0];
    local_103 = static_cast<uint>(_e373);
    uint _e377 = local_102.inner[1];
    local_104 = static_cast<uint>(_e377);
    uint _e380 = local_104;
    out_1[_e380] = static_cast<uint>(_e358);
    uint _e384 = _umul24_(3, 4);
    type_6 _e386 = out;
    local_26 = _e386;
    local_27 = static_cast<uint>(13);
    type_6 _e391 = local_26;
    local_105 = _e391;
    uint _e392 = local_27;
    uint _e394 = local_105.inner[1];
    local_105.inner[1] = _e394 + _e392;
    uint _e398 = local_105.inner[0];
    local_106 = static_cast<uint>(_e398);
    uint _e402 = local_105.inner[1];
    local_107 = static_cast<uint>(_e402);
    uint _e405 = local_107;
    out_1[_e405] = _e384;
    type_6 _e415 = out;
    local_28 = _e415;
    local_29 = static_cast<uint>(14);
    type_6 _e420 = local_28;
    local_108 = _e420;
    uint _e421 = local_29;
    uint _e423 = local_108.inner[1];
    local_108.inner[1] = _e423 + _e421;
    uint _e427 = local_108.inner[0];
    local_109 = static_cast<uint>(_e427);
    uint _e431 = local_108.inner[1];
    local_110 = static_cast<uint>(_e431);
    uint _e434 = local_110;
    out_1[_e434] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    uint _e440 = _umul24_(static_cast<int>(true), static_cast<int>(true));
    type_6 _e442 = out;
    local_30 = _e442;
    local_31 = static_cast<uint>(15);
    type_6 _e447 = local_30;
    local_111 = _e447;
    uint _e448 = local_31;
    uint _e450 = local_111.inner[1];
    local_111.inner[1] = _e450 + _e448;
    uint _e454 = local_111.inner[0];
    local_112 = static_cast<uint>(_e454);
    uint _e458 = local_111.inner[1];
    local_113 = static_cast<uint>(_e458);
    uint _e461 = local_113;
    out_1[_e461] = _e440;
    type_6 _e472 = out;
    local_32 = _e472;
    local_33 = static_cast<uint>(16);
    type_6 _e477 = local_32;
    local_114 = _e477;
    uint _e478 = local_33;
    uint _e480 = local_114.inner[1];
    local_114.inner[1] = _e480 + _e478;
    uint _e484 = local_114.inner[0];
    local_115 = static_cast<uint>(_e484);
    uint _e488 = local_114.inner[1];
    local_116 = static_cast<uint>(_e488);
    uint _e491 = local_116;
    out_1[_e491] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(static_cast<uint>(4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e496 = signed_pair(naga_neg(7), 3);
    type_6 _e499 = out;
    local_34 = _e499;
    local_35 = static_cast<uint>(17);
    type_6 _e504 = local_34;
    local_117 = _e504;
    uint _e505 = local_35;
    uint _e507 = local_117.inner[1];
    local_117.inner[1] = _e507 + _e505;
    uint _e511 = local_117.inner[0];
    local_118 = static_cast<uint>(_e511);
    uint _e515 = local_117.inner[1];
    local_119 = static_cast<uint>(_e515);
    uint _e518 = local_119;
    out_1[_e518] = static_cast<uint>(_e496);
    type_6 _e541 = out;
    local_36 = _e541;
    local_37 = static_cast<uint>(18);
    type_6 _e546 = local_36;
    local_120 = _e546;
    uint _e547 = local_37;
    uint _e549 = local_120.inner[1];
    local_120.inner[1] = _e549 + _e547;
    uint _e553 = local_120.inner[0];
    local_121 = static_cast<uint>(_e553);
    uint _e557 = local_120.inner[1];
    local_122 = static_cast<uint>(_e557);
    uint _e560 = local_122;
    out_1[_e560] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e576 = out;
    local_38 = _e576;
    local_39 = static_cast<uint>(19);
    type_6 _e581 = local_38;
    local_123 = _e581;
    uint _e582 = local_39;
    uint _e584 = local_123.inner[1];
    local_123.inner[1] = _e584 + _e582;
    uint _e588 = local_123.inner[0];
    local_124 = static_cast<uint>(_e588);
    uint _e592 = local_123.inner[1];
    local_125 = static_cast<uint>(_e592);
    uint _e595 = local_125;
    out_1[_e595] = metal::extract_bits(metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    first = -3;
    second = 5u;
    int _e601 = first;
    uint _e602 = second;
    type_6 _e614 = out;
    local_40 = _e614;
    local_41 = static_cast<uint>(20);
    type_6 _e619 = local_40;
    local_126 = _e619;
    uint _e620 = local_41;
    uint _e622 = local_126.inner[1];
    local_126.inner[1] = _e622 + _e620;
    uint _e626 = local_126.inner[0];
    local_127 = static_cast<uint>(_e626);
    uint _e630 = local_126.inner[1];
    local_128 = static_cast<uint>(_e630);
    uint _e633 = local_128;
    out_1[_e633] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e601, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(_e602), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e635 = first;
    uint _e637 = second;
    type_6 _e644 = out;
    local_42 = _e644;
    local_43 = static_cast<uint>(21);
    type_6 _e649 = local_42;
    local_129 = _e649;
    uint _e650 = local_43;
    uint _e652 = local_129.inner[1];
    local_129.inner[1] = _e652 + _e650;
    uint _e656 = local_129.inner[0];
    local_130 = static_cast<uint>(_e656);
    uint _e660 = local_129.inner[1];
    local_131 = static_cast<uint>(_e660);
    uint _e663 = local_131;
    out_1[_e663] = metal::extract_bits(static_cast<uint>(_e635), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(_e637, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    type_6 _e677 = out;
    local_44 = _e677;
    local_45 = static_cast<uint>(22);
    type_6 _e682 = local_44;
    local_132 = _e682;
    uint _e683 = local_45;
    uint _e685 = local_132.inner[1];
    local_132.inner[1] = _e685 + _e683;
    uint _e689 = local_132.inner[0];
    local_133 = static_cast<uint>(_e689);
    uint _e693 = local_132.inner[1];
    local_134 = static_cast<uint>(_e693);
    uint _e696 = local_134;
    out_1[_e696] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(25165824, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(16777217, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e706 = out;
    local_46 = _e706;
    local_47 = static_cast<uint>(23);
    type_6 _e711 = local_46;
    local_135 = _e711;
    uint _e712 = local_47;
    uint _e714 = local_135.inner[1];
    local_135.inner[1] = _e714 + _e712;
    uint _e718 = local_135.inner[0];
    local_136 = static_cast<uint>(_e718);
    uint _e722 = local_135.inner[1];
    local_137 = static_cast<uint>(_e722);
    uint _e725 = local_137;
    out_1[_e725] = metal::extract_bits(4286578688u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4278190081u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    if (true) {
        local_50 = as_type<int>(as_type<uint>(metal::extract_bits(naga_neg(3), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(7, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    } else {
        local_50 = as_type<int>(as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    }
    int _e752 = local_50;
    type_6 _e755 = out;
    local_48 = _e755;
    local_49 = static_cast<uint>(24);
    type_6 _e760 = local_48;
    local_138 = _e760;
    uint _e761 = local_49;
    uint _e763 = local_138.inner[1];
    local_138.inner[1] = _e763 + _e761;
    uint _e767 = local_138.inner[0];
    local_139 = static_cast<uint>(_e767);
    uint _e771 = local_138.inner[1];
    local_140 = static_cast<uint>(_e771);
    uint _e774 = local_140;
    out_1[_e774] = static_cast<uint>(_e752);
    values.inner[0] = as_type<int>(as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    values.inner[1] = as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    int _e803 = values.inner[0];
    int _e804 = values.inner[1];
    type_6 _e808 = out;
    local_51 = _e808;
    local_52 = static_cast<uint>(25);
    type_6 _e813 = local_51;
    local_141 = _e813;
    uint _e814 = local_52;
    uint _e816 = local_141.inner[1];
    local_141.inner[1] = _e816 + _e814;
    uint _e820 = local_141.inner[0];
    local_142 = static_cast<uint>(_e820);
    uint _e824 = local_141.inner[1];
    local_143 = static_cast<uint>(_e824);
    uint _e827 = local_143;
    out_1[_e827] = static_cast<uint>(as_type<int>(as_type<uint>(_e803) + as_type<uint>(_e804)));
    Count = 2;
    scratch = type_5 {};
    int _e835 = Count;
    int _e836 = scratch.inner[0];
    type_6 _e840 = out;
    local_54 = _e840;
    local_55 = static_cast<uint>(26);
    type_6 _e845 = local_54;
    local_144 = _e845;
    uint _e846 = local_55;
    uint _e848 = local_144.inner[1];
    local_144.inner[1] = _e848 + _e846;
    uint _e852 = local_144.inner[0];
    local_145 = static_cast<uint>(_e852);
    uint _e856 = local_144.inner[1];
    local_146 = static_cast<uint>(_e856);
    uint _e859 = local_146;
    out_1[_e859] = static_cast<uint>(as_type<int>(as_type<uint>(_e835) + as_type<uint>(_e836)));
    counter = 2;
    int _e863 = counter;
    counter = as_type<int>(as_type<uint>(_e863) + as_type<uint>(1));
    int _e866 = counter;
    counter = as_type<int>(as_type<uint>(_e866) + as_type<uint>(1));
    type_6 _e879 = out;
    local_56 = _e879;
    local_57 = static_cast<uint>(27);
    type_6 _e884 = local_56;
    local_147 = _e884;
    uint _e885 = local_57;
    uint _e887 = local_147.inner[1];
    local_147.inner[1] = _e887 + _e885;
    uint _e891 = local_147.inner[0];
    local_148 = static_cast<uint>(_e891);
    uint _e895 = local_147.inner[1];
    local_149 = static_cast<uint>(_e895);
    uint _e898 = local_149;
    out_1[_e898] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e863, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e866, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e900 = counter;
    type_6 _e903 = out;
    local_58 = _e903;
    local_59 = static_cast<uint>(28);
    type_6 _e908 = local_58;
    local_150 = _e908;
    uint _e909 = local_59;
    uint _e911 = local_150.inner[1];
    local_150.inner[1] = _e911 + _e909;
    uint _e915 = local_150.inner[0];
    local_151 = static_cast<uint>(_e915);
    uint _e919 = local_150.inner[1];
    local_152 = static_cast<uint>(_e919);
    uint _e922 = local_152;
    out_1[_e922] = static_cast<uint>(_e900);
    total = 0;
    {
        index = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e945 = index;
                index = as_type<int>(as_type<uint>(_e945) + as_type<uint>(1));
            }
            loop_init = false;
            int _e928 = index;
            if (_e928 < 3) {
            } else {
                break;
            }
            int _e931 = index;
            int _e943 = total;
            total = as_type<int>(as_type<uint>(_e943) + as_type<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(_e931) + as_type<uint>(1)), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))))));
        }
    }
    int _e948 = total;
    type_6 _e951 = out;
    local_60 = _e951;
    local_61 = static_cast<uint>(29);
    type_6 _e956 = local_60;
    local_153 = _e956;
    uint _e957 = local_61;
    uint _e959 = local_153.inner[1];
    local_153.inner[1] = _e959 + _e957;
    uint _e963 = local_153.inner[0];
    local_154 = static_cast<uint>(_e963);
    uint _e967 = local_153.inner[1];
    local_155 = static_cast<uint>(_e967);
    uint _e970 = local_155;
    out_1[_e970] = static_cast<uint>(_e948);
    {
        type_6 _e976 = out;
        local_62 = _e976;
        local_63 = static_cast<uint>(30);
        type_6 _e981 = local_62;
        local_156 = _e981;
        uint _e982 = local_63;
        uint _e984 = local_156.inner[1];
        local_156.inner[1] = _e984 + _e982;
        uint _e988 = local_156.inner[0];
        local_157 = static_cast<uint>(_e988);
        uint _e992 = local_156.inner[1];
        local_158 = static_cast<uint>(_e992);
        uint _e995 = local_158;
        out_1[_e995] = static_cast<uint>(naga_f2i32(9.75));
    }
    type_6 _e1009 = out;
    local_64 = _e1009;
    local_65 = static_cast<uint>(31);
    type_6 _e1014 = local_64;
    local_159 = _e1014;
    uint _e1015 = local_65;
    uint _e1017 = local_159.inner[1];
    local_159.inner[1] = _e1017 + _e1015;
    uint _e1021 = local_159.inner[0];
    local_160 = static_cast<uint>(_e1021);
    uint _e1025 = local_159.inner[1];
    local_161 = static_cast<uint>(_e1025);
    uint _e1028 = local_161;
    out_1[_e1028] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(16777215, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
}
