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
    float first_2 = {};
    float second_2 = {};
    first_2 = first_1;
    second_2 = second_1;
    float _e4 = first_2;
    float _e5 = second_2;
    return as_type<int>(as_type<uint>(metal::extract_bits(naga_f2i32(_e4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(naga_f2i32(_e5), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

uint unsigned_conversion(
    float first_3,
    float second_3
) {
    float first_4 = {};
    float second_4 = {};
    first_4 = first_3;
    second_4 = second_3;
    float _e4 = first_4;
    float _e5 = second_4;
    return metal::extract_bits(naga_f2u32(_e4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(naga_f2u32(_e5), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
}

int _mul24_(
    bool first_5,
    bool second_5
) {
    bool first_6 = {};
    bool second_6 = {};
    int local_163 = {};
    int local_164 = {};
    first_6 = first_5;
    second_6 = second_5;
    bool _e4 = first_6;
    if (_e4) {
        bool _e5 = second_6;
        if (_e5) {
            local_163 = 71;
        } else {
            local_163 = 73;
        }
        int _e9 = local_163;
        local_164 = _e9;
    } else {
        local_164 = 79;
    }
    int _e12 = local_164;
    return _e12;
}

int _mul24_1(
    float first_7,
    float second_7
) {
    float first_8 = {};
    float second_8 = {};
    first_8 = first_7;
    second_8 = second_7;
    float _e5 = first_8;
    float _e7 = second_8;
    return naga_f2i32((_e5 * 10.0) + _e7);
}

uint _umul24_(
    int first_9,
    int second_9
) {
    int first_10 = {};
    int second_10 = {};
    first_10 = first_9;
    second_10 = second_9;
    int _e4 = first_10;
    int _e5 = second_10;
    return static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5))) + as_type<uint>(100)));
}

int signed_pair(
    int first_11,
    int second_11
) {
    int first_12 = {};
    int second_12 = {};
    first_12 = first_11;
    second_12 = second_11;
    int _e4 = first_12;
    int _e5 = second_12;
    return as_type<int>(as_type<uint>(metal::extract_bits(_e4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void multiply24_(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 local = {};
    type_6 local_1 = {};
    uint local_2 = {};
    type_6 local_3 = {};
    uint local_4 = {};
    type_6 local_5 = {};
    uint local_6 = {};
    type_6 local_7 = {};
    uint local_8 = {};
    type_6 local_9 = {};
    uint local_10 = {};
    type_6 local_11 = {};
    uint local_12 = {};
    type_6 local_13 = {};
    uint local_14 = {};
    type_6 local_15 = {};
    uint local_16 = {};
    type_6 local_17 = {};
    uint local_18 = {};
    type_6 local_19 = {};
    uint local_20 = {};
    type_6 local_21 = {};
    uint local_22 = {};
    type_6 local_23 = {};
    uint local_24 = {};
    type_6 local_25 = {};
    uint local_26 = {};
    type_6 local_27 = {};
    uint local_28 = {};
    type_6 local_29 = {};
    uint local_30 = {};
    type_6 local_31 = {};
    uint local_32 = {};
    type_6 local_33 = {};
    uint local_34 = {};
    type_6 local_35 = {};
    uint local_36 = {};
    type_6 local_37 = {};
    uint local_38 = {};
    type_6 local_39 = {};
    uint local_40 = {};
    int first = {};
    uint second = {};
    type_6 local_41 = {};
    uint local_42 = {};
    type_6 local_43 = {};
    uint local_44 = {};
    type_6 local_45 = {};
    uint local_46 = {};
    type_6 local_47 = {};
    uint local_48 = {};
    type_6 local_49 = {};
    uint local_50 = {};
    int local_51 = {};
    type_5 values = {};
    type_6 local_52 = {};
    uint local_53 = {};
    int Count = {};
    int local_54 = {};
    type_5 scratch = {};
    type_6 local_55 = {};
    uint local_56 = {};
    int counter = {};
    type_6 local_57 = {};
    uint local_58 = {};
    type_6 local_59 = {};
    uint local_60 = {};
    int total = {};
    int index = {};
    type_6 local_61 = {};
    uint local_62 = {};
    type_6 local_63 = {};
    uint local_64 = {};
    type_6 local_65 = {};
    uint local_66 = {};
    type_6 local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    type_6 local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    type_6 local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    type_6 local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    type_6 local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    type_6 local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    type_6 local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    type_6 local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    type_6 local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    type_6 local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    type_6 local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    type_6 local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    type_6 local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    type_6 local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    type_6 local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    type_6 local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    type_6 local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    type_6 local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    type_6 local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    type_6 local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    type_6 local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    type_6 local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    type_6 local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    type_6 local_136 = {};
    uint local_137 = {};
    uint local_138 = {};
    type_6 local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    type_6 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    type_6 local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    type_6 local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    type_6 local_151 = {};
    uint local_152 = {};
    uint local_153 = {};
    type_6 local_154 = {};
    uint local_155 = {};
    uint local_156 = {};
    type_6 local_157 = {};
    uint local_158 = {};
    uint local_159 = {};
    type_6 local_160 = {};
    uint local_161 = {};
    uint local_162 = {};
    local = type_6 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    type_6 _e20 = local;
    local_1 = _e20;
    local_2 = static_cast<uint>(0);
    type_6 _e25 = local_1;
    local_67 = _e25;
    uint _e26 = local_2;
    uint _e28 = local_67.inner[1];
    local_67.inner[1] = _e28 + _e26;
    uint _e32 = local_67.inner[0];
    local_68 = static_cast<uint>(_e32);
    uint _e36 = local_67.inner[1];
    local_69 = static_cast<uint>(_e36);
    uint _e39 = local_69;
    out[_e39] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388608, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(1, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e49 = local;
    local_3 = _e49;
    local_4 = static_cast<uint>(1);
    type_6 _e54 = local_3;
    local_70 = _e54;
    uint _e55 = local_4;
    uint _e57 = local_70.inner[1];
    local_70.inner[1] = _e57 + _e55;
    uint _e61 = local_70.inner[0];
    local_71 = static_cast<uint>(_e61);
    uint _e65 = local_70.inner[1];
    local_72 = static_cast<uint>(_e65);
    uint _e68 = local_72;
    out[_e68] = metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    type_6 _e82 = local;
    local_5 = _e82;
    local_6 = static_cast<uint>(2);
    type_6 _e87 = local_5;
    local_73 = _e87;
    uint _e88 = local_6;
    uint _e90 = local_73.inner[1];
    local_73.inner[1] = _e90 + _e88;
    uint _e94 = local_73.inner[0];
    local_74 = static_cast<uint>(_e94);
    uint _e98 = local_73.inner[1];
    local_75 = static_cast<uint>(_e98);
    uint _e101 = local_75;
    out[_e101] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e111 = local;
    local_7 = _e111;
    local_8 = static_cast<uint>(3);
    type_6 _e116 = local_7;
    local_76 = _e116;
    uint _e117 = local_8;
    uint _e119 = local_76.inner[1];
    local_76.inner[1] = _e119 + _e117;
    uint _e123 = local_76.inner[0];
    local_77 = static_cast<uint>(_e123);
    uint _e127 = local_76.inner[1];
    local_78 = static_cast<uint>(_e127);
    uint _e130 = local_78;
    out[_e130] = metal::extract_bits(16777216u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(13u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e135 = signed_conversion(3.75, -(2.75));
    type_6 _e138 = local;
    local_9 = _e138;
    local_10 = static_cast<uint>(4);
    type_6 _e143 = local_9;
    local_79 = _e143;
    uint _e144 = local_10;
    uint _e146 = local_79.inner[1];
    local_79.inner[1] = _e146 + _e144;
    uint _e150 = local_79.inner[0];
    local_80 = static_cast<uint>(_e150);
    uint _e154 = local_79.inner[1];
    local_81 = static_cast<uint>(_e154);
    uint _e157 = local_81;
    out[_e157] = static_cast<uint>(_e135);
    int _e162 = signed_conversion(-(3.75), 2.75);
    type_6 _e165 = local;
    local_11 = _e165;
    local_12 = static_cast<uint>(5);
    type_6 _e170 = local_11;
    local_82 = _e170;
    uint _e171 = local_12;
    uint _e173 = local_82.inner[1];
    local_82.inner[1] = _e173 + _e171;
    uint _e177 = local_82.inner[0];
    local_83 = static_cast<uint>(_e177);
    uint _e181 = local_82.inner[1];
    local_84 = static_cast<uint>(_e181);
    uint _e184 = local_84;
    out[_e184] = static_cast<uint>(_e162);
    uint _e188 = unsigned_conversion(3.75, 2.75);
    type_6 _e190 = local;
    local_13 = _e190;
    local_14 = static_cast<uint>(6);
    type_6 _e195 = local_13;
    local_85 = _e195;
    uint _e196 = local_14;
    uint _e198 = local_85.inner[1];
    local_85.inner[1] = _e198 + _e196;
    uint _e202 = local_85.inner[0];
    local_86 = static_cast<uint>(_e202);
    uint _e206 = local_85.inner[1];
    local_87 = static_cast<uint>(_e206);
    uint _e209 = local_87;
    out[_e209] = _e188;
    uint _e213 = unsigned_conversion(16777215.0, 1.0);
    type_6 _e215 = local;
    local_15 = _e215;
    local_16 = static_cast<uint>(7);
    type_6 _e220 = local_15;
    local_88 = _e220;
    uint _e221 = local_16;
    uint _e223 = local_88.inner[1];
    local_88.inner[1] = _e223 + _e221;
    uint _e227 = local_88.inner[0];
    local_89 = static_cast<uint>(_e227);
    uint _e231 = local_88.inner[1];
    local_90 = static_cast<uint>(_e231);
    uint _e234 = local_90;
    out[_e234] = _e213;
    int _e238 = _mul24_(true, true);
    type_6 _e241 = local;
    local_17 = _e241;
    local_18 = static_cast<uint>(8);
    type_6 _e246 = local_17;
    local_91 = _e246;
    uint _e247 = local_18;
    uint _e249 = local_91.inner[1];
    local_91.inner[1] = _e249 + _e247;
    uint _e253 = local_91.inner[0];
    local_92 = static_cast<uint>(_e253);
    uint _e257 = local_91.inner[1];
    local_93 = static_cast<uint>(_e257);
    uint _e260 = local_93;
    out[_e260] = static_cast<uint>(_e238);
    int _e264 = _mul24_(false, true);
    type_6 _e267 = local;
    local_19 = _e267;
    local_20 = static_cast<uint>(9);
    type_6 _e272 = local_19;
    local_94 = _e272;
    uint _e273 = local_20;
    uint _e275 = local_94.inner[1];
    local_94.inner[1] = _e275 + _e273;
    uint _e279 = local_94.inner[0];
    local_95 = static_cast<uint>(_e279);
    uint _e283 = local_94.inner[1];
    local_96 = static_cast<uint>(_e283);
    uint _e286 = local_96;
    out[_e286] = static_cast<uint>(_e264);
    type_6 _e301 = local;
    local_21 = _e301;
    local_22 = static_cast<uint>(10);
    type_6 _e306 = local_21;
    local_97 = _e306;
    uint _e307 = local_22;
    uint _e309 = local_97.inner[1];
    local_97.inner[1] = _e309 + _e307;
    uint _e313 = local_97.inner[0];
    local_98 = static_cast<uint>(_e313);
    uint _e317 = local_97.inner[1];
    local_99 = static_cast<uint>(_e317);
    uint _e320 = local_99;
    out[_e320] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e335 = local;
    local_23 = _e335;
    local_24 = static_cast<uint>(11);
    type_6 _e340 = local_23;
    local_100 = _e340;
    uint _e341 = local_24;
    uint _e343 = local_100.inner[1];
    local_100.inner[1] = _e343 + _e341;
    uint _e347 = local_100.inner[0];
    local_101 = static_cast<uint>(_e347);
    uint _e351 = local_100.inner[1];
    local_102 = static_cast<uint>(_e351);
    uint _e354 = local_102;
    out[_e354] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e358 = _mul24_1(3.75, 2.0);
    type_6 _e361 = local;
    local_25 = _e361;
    local_26 = static_cast<uint>(12);
    type_6 _e366 = local_25;
    local_103 = _e366;
    uint _e367 = local_26;
    uint _e369 = local_103.inner[1];
    local_103.inner[1] = _e369 + _e367;
    uint _e373 = local_103.inner[0];
    local_104 = static_cast<uint>(_e373);
    uint _e377 = local_103.inner[1];
    local_105 = static_cast<uint>(_e377);
    uint _e380 = local_105;
    out[_e380] = static_cast<uint>(_e358);
    uint _e384 = _umul24_(3, 4);
    type_6 _e386 = local;
    local_27 = _e386;
    local_28 = static_cast<uint>(13);
    type_6 _e391 = local_27;
    local_106 = _e391;
    uint _e392 = local_28;
    uint _e394 = local_106.inner[1];
    local_106.inner[1] = _e394 + _e392;
    uint _e398 = local_106.inner[0];
    local_107 = static_cast<uint>(_e398);
    uint _e402 = local_106.inner[1];
    local_108 = static_cast<uint>(_e402);
    uint _e405 = local_108;
    out[_e405] = _e384;
    type_6 _e415 = local;
    local_29 = _e415;
    local_30 = static_cast<uint>(14);
    type_6 _e420 = local_29;
    local_109 = _e420;
    uint _e421 = local_30;
    uint _e423 = local_109.inner[1];
    local_109.inner[1] = _e423 + _e421;
    uint _e427 = local_109.inner[0];
    local_110 = static_cast<uint>(_e427);
    uint _e431 = local_109.inner[1];
    local_111 = static_cast<uint>(_e431);
    uint _e434 = local_111;
    out[_e434] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    uint _e440 = _umul24_(static_cast<int>(true), static_cast<int>(true));
    type_6 _e442 = local;
    local_31 = _e442;
    local_32 = static_cast<uint>(15);
    type_6 _e447 = local_31;
    local_112 = _e447;
    uint _e448 = local_32;
    uint _e450 = local_112.inner[1];
    local_112.inner[1] = _e450 + _e448;
    uint _e454 = local_112.inner[0];
    local_113 = static_cast<uint>(_e454);
    uint _e458 = local_112.inner[1];
    local_114 = static_cast<uint>(_e458);
    uint _e461 = local_114;
    out[_e461] = _e440;
    type_6 _e472 = local;
    local_33 = _e472;
    local_34 = static_cast<uint>(16);
    type_6 _e477 = local_33;
    local_115 = _e477;
    uint _e478 = local_34;
    uint _e480 = local_115.inner[1];
    local_115.inner[1] = _e480 + _e478;
    uint _e484 = local_115.inner[0];
    local_116 = static_cast<uint>(_e484);
    uint _e488 = local_115.inner[1];
    local_117 = static_cast<uint>(_e488);
    uint _e491 = local_117;
    out[_e491] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(static_cast<uint>(4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e496 = signed_pair(naga_neg(7), 3);
    type_6 _e499 = local;
    local_35 = _e499;
    local_36 = static_cast<uint>(17);
    type_6 _e504 = local_35;
    local_118 = _e504;
    uint _e505 = local_36;
    uint _e507 = local_118.inner[1];
    local_118.inner[1] = _e507 + _e505;
    uint _e511 = local_118.inner[0];
    local_119 = static_cast<uint>(_e511);
    uint _e515 = local_118.inner[1];
    local_120 = static_cast<uint>(_e515);
    uint _e518 = local_120;
    out[_e518] = static_cast<uint>(_e496);
    type_6 _e541 = local;
    local_37 = _e541;
    local_38 = static_cast<uint>(18);
    type_6 _e546 = local_37;
    local_121 = _e546;
    uint _e547 = local_38;
    uint _e549 = local_121.inner[1];
    local_121.inner[1] = _e549 + _e547;
    uint _e553 = local_121.inner[0];
    local_122 = static_cast<uint>(_e553);
    uint _e557 = local_121.inner[1];
    local_123 = static_cast<uint>(_e557);
    uint _e560 = local_123;
    out[_e560] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e576 = local;
    local_39 = _e576;
    local_40 = static_cast<uint>(19);
    type_6 _e581 = local_39;
    local_124 = _e581;
    uint _e582 = local_40;
    uint _e584 = local_124.inner[1];
    local_124.inner[1] = _e584 + _e582;
    uint _e588 = local_124.inner[0];
    local_125 = static_cast<uint>(_e588);
    uint _e592 = local_124.inner[1];
    local_126 = static_cast<uint>(_e592);
    uint _e595 = local_126;
    out[_e595] = metal::extract_bits(metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    first = -3;
    second = 5u;
    int _e601 = first;
    uint _e602 = second;
    type_6 _e614 = local;
    local_41 = _e614;
    local_42 = static_cast<uint>(20);
    type_6 _e619 = local_41;
    local_127 = _e619;
    uint _e620 = local_42;
    uint _e622 = local_127.inner[1];
    local_127.inner[1] = _e622 + _e620;
    uint _e626 = local_127.inner[0];
    local_128 = static_cast<uint>(_e626);
    uint _e630 = local_127.inner[1];
    local_129 = static_cast<uint>(_e630);
    uint _e633 = local_129;
    out[_e633] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e601, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(_e602), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e635 = first;
    uint _e637 = second;
    type_6 _e644 = local;
    local_43 = _e644;
    local_44 = static_cast<uint>(21);
    type_6 _e649 = local_43;
    local_130 = _e649;
    uint _e650 = local_44;
    uint _e652 = local_130.inner[1];
    local_130.inner[1] = _e652 + _e650;
    uint _e656 = local_130.inner[0];
    local_131 = static_cast<uint>(_e656);
    uint _e660 = local_130.inner[1];
    local_132 = static_cast<uint>(_e660);
    uint _e663 = local_132;
    out[_e663] = metal::extract_bits(static_cast<uint>(_e635), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(_e637, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    type_6 _e677 = local;
    local_45 = _e677;
    local_46 = static_cast<uint>(22);
    type_6 _e682 = local_45;
    local_133 = _e682;
    uint _e683 = local_46;
    uint _e685 = local_133.inner[1];
    local_133.inner[1] = _e685 + _e683;
    uint _e689 = local_133.inner[0];
    local_134 = static_cast<uint>(_e689);
    uint _e693 = local_133.inner[1];
    local_135 = static_cast<uint>(_e693);
    uint _e696 = local_135;
    out[_e696] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(25165824, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(16777217, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    type_6 _e706 = local;
    local_47 = _e706;
    local_48 = static_cast<uint>(23);
    type_6 _e711 = local_47;
    local_136 = _e711;
    uint _e712 = local_48;
    uint _e714 = local_136.inner[1];
    local_136.inner[1] = _e714 + _e712;
    uint _e718 = local_136.inner[0];
    local_137 = static_cast<uint>(_e718);
    uint _e722 = local_136.inner[1];
    local_138 = static_cast<uint>(_e722);
    uint _e725 = local_138;
    out[_e725] = metal::extract_bits(4286578688u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4278190081u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    if (true) {
        local_51 = as_type<int>(as_type<uint>(metal::extract_bits(naga_neg(3), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(7, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    } else {
        local_51 = as_type<int>(as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    }
    int _e752 = local_51;
    type_6 _e755 = local;
    local_49 = _e755;
    local_50 = static_cast<uint>(24);
    type_6 _e760 = local_49;
    local_139 = _e760;
    uint _e761 = local_50;
    uint _e763 = local_139.inner[1];
    local_139.inner[1] = _e763 + _e761;
    uint _e767 = local_139.inner[0];
    local_140 = static_cast<uint>(_e767);
    uint _e771 = local_139.inner[1];
    local_141 = static_cast<uint>(_e771);
    uint _e774 = local_141;
    out[_e774] = static_cast<uint>(_e752);
    values.inner[0] = as_type<int>(as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    values.inner[1] = as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    int _e803 = values.inner[0];
    int _e804 = values.inner[1];
    type_6 _e808 = local;
    local_52 = _e808;
    local_53 = static_cast<uint>(25);
    type_6 _e813 = local_52;
    local_142 = _e813;
    uint _e814 = local_53;
    uint _e816 = local_142.inner[1];
    local_142.inner[1] = _e816 + _e814;
    uint _e820 = local_142.inner[0];
    local_143 = static_cast<uint>(_e820);
    uint _e824 = local_142.inner[1];
    local_144 = static_cast<uint>(_e824);
    uint _e827 = local_144;
    out[_e827] = static_cast<uint>(as_type<int>(as_type<uint>(_e803) + as_type<uint>(_e804)));
    Count = 2;
    scratch = type_5 {};
    int _e835 = Count;
    int _e836 = scratch.inner[0];
    type_6 _e840 = local;
    local_55 = _e840;
    local_56 = static_cast<uint>(26);
    type_6 _e845 = local_55;
    local_145 = _e845;
    uint _e846 = local_56;
    uint _e848 = local_145.inner[1];
    local_145.inner[1] = _e848 + _e846;
    uint _e852 = local_145.inner[0];
    local_146 = static_cast<uint>(_e852);
    uint _e856 = local_145.inner[1];
    local_147 = static_cast<uint>(_e856);
    uint _e859 = local_147;
    out[_e859] = static_cast<uint>(as_type<int>(as_type<uint>(_e835) + as_type<uint>(_e836)));
    counter = 2;
    int _e863 = counter;
    counter = as_type<int>(as_type<uint>(_e863) + as_type<uint>(1));
    int _e866 = counter;
    counter = as_type<int>(as_type<uint>(_e866) + as_type<uint>(1));
    type_6 _e879 = local;
    local_57 = _e879;
    local_58 = static_cast<uint>(27);
    type_6 _e884 = local_57;
    local_148 = _e884;
    uint _e885 = local_58;
    uint _e887 = local_148.inner[1];
    local_148.inner[1] = _e887 + _e885;
    uint _e891 = local_148.inner[0];
    local_149 = static_cast<uint>(_e891);
    uint _e895 = local_148.inner[1];
    local_150 = static_cast<uint>(_e895);
    uint _e898 = local_150;
    out[_e898] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e863, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e866, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e900 = counter;
    type_6 _e903 = local;
    local_59 = _e903;
    local_60 = static_cast<uint>(28);
    type_6 _e908 = local_59;
    local_151 = _e908;
    uint _e909 = local_60;
    uint _e911 = local_151.inner[1];
    local_151.inner[1] = _e911 + _e909;
    uint _e915 = local_151.inner[0];
    local_152 = static_cast<uint>(_e915);
    uint _e919 = local_151.inner[1];
    local_153 = static_cast<uint>(_e919);
    uint _e922 = local_153;
    out[_e922] = static_cast<uint>(_e900);
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
    type_6 _e951 = local;
    local_61 = _e951;
    local_62 = static_cast<uint>(29);
    type_6 _e956 = local_61;
    local_154 = _e956;
    uint _e957 = local_62;
    uint _e959 = local_154.inner[1];
    local_154.inner[1] = _e959 + _e957;
    uint _e963 = local_154.inner[0];
    local_155 = static_cast<uint>(_e963);
    uint _e967 = local_154.inner[1];
    local_156 = static_cast<uint>(_e967);
    uint _e970 = local_156;
    out[_e970] = static_cast<uint>(_e948);
    {
        type_6 _e976 = local;
        local_63 = _e976;
        local_64 = static_cast<uint>(30);
        type_6 _e981 = local_63;
        local_157 = _e981;
        uint _e982 = local_64;
        uint _e984 = local_157.inner[1];
        local_157.inner[1] = _e984 + _e982;
        uint _e988 = local_157.inner[0];
        local_158 = static_cast<uint>(_e988);
        uint _e992 = local_157.inner[1];
        local_159 = static_cast<uint>(_e992);
        uint _e995 = local_159;
        out[_e995] = static_cast<uint>(naga_f2i32(9.75));
    }
    type_6 _e1009 = local;
    local_65 = _e1009;
    local_66 = static_cast<uint>(31);
    type_6 _e1014 = local_65;
    local_160 = _e1014;
    uint _e1015 = local_66;
    uint _e1017 = local_160.inner[1];
    local_160.inner[1] = _e1017 + _e1015;
    uint _e1021 = local_160.inner[0];
    local_161 = static_cast<uint>(_e1021);
    uint _e1025 = local_160.inner[1];
    local_162 = static_cast<uint>(_e1025);
    uint _e1028 = local_162;
    out[_e1028] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(16777215, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
}
