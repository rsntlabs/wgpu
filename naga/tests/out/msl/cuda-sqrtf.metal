// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_sqrtf(
    uint input_bits
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration = {};
    uint _e5 = input_bits & 2147483647u;
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits & 8388607u;
    uint _e20 = _e5 >> 23u;
    significand = _e19 | 8388608u;
    adjusted_exponent = _e20 + 127u;
    if (_e20 == 0u) {
        uint _e28 = metal::clz(_e19) - 8u;
        significand = _e19 << _e28;
        adjusted_exponent = 128u - _e28;
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = _e33 & 1u;
    upper_word = _e32 >> (9u - _e34);
    lower_word = _e32 << (23u + _e34);
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = _e72 + 1u;
        }
        loop_init = false;
        uint _e50 = iteration;
        if (_e50 >= 24u) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = (_e55 << 2u) | (_e52 >> 14u);
        uint _e65 = (_e54 << 2u) | 1u;
        bool _e66 = _e63 >= _e65;
        uint _e69 = _e54 << 1u;
        upper_word = ((_e52 << 2u) | (_e53 >> 30u)) & 65535u;
        lower_word = _e53 << 2u;
        remainder = _e66 ? (_e63 - _e65) : _e63;
        root = _e66 ? (_e69 | 1u) : _e69;
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return ((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u);
}

float root_1(
    float value_1
) {
    float value_2 = {};
    value_2 = value_1;
    float _e2 = value_2;
    uint _e4 = _naga_sqrtf(as_type<uint>(_e2));
    return as_type<float>(_e4);
}

float root_2(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e2 = value_4;
    uint _e5 = _naga_sqrtf(as_type<uint>(static_cast<float>(_e2)));
    return as_type<float>(_e5);
}

float root_3(
    uint value_5
) {
    uint value_6 = {};
    value_6 = value_5;
    uint _e2 = value_6;
    uint _e5 = _naga_sqrtf(as_type<uint>(static_cast<float>(_e2)));
    return as_type<float>(_e5);
}

float root_4(
    bool value_7
) {
    bool value_8 = {};
    value_8 = value_7;
    bool _e2 = value_8;
    uint _e5 = _naga_sqrtf(as_type<uint>(static_cast<float>(_e2)));
    return as_type<float>(_e5);
}

int sqrtf(
    bool value_9
) {
    bool value_10 = {};
    int local_131 = {};
    value_10 = value_9;
    bool _e2 = value_10;
    if (_e2) {
        local_131 = 7;
    } else {
        local_131 = 9;
    }
    int _e6 = local_131;
    return _e6;
}

float sqrtf_1(
    float first,
    float second
) {
    float first_1 = {};
    float second_1 = {};
    first_1 = first;
    second_1 = second;
    float _e4 = first_1;
    float _e5 = second_1;
    return _e4 + _e5;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void roots(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    float value = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
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
    local = 0u;
    uint _e4 = _naga_sqrtf(as_type<uint>(0.0));
    uint _e7 = local;
    local_1 = _e7;
    uint _e9 = local_1;
    local_2 = static_cast<uint>(_e9);
    local_3 = static_cast<uint>(0);
    uint _e16 = local_2;
    uint _e17 = local_3;
    local_101 = static_cast<uint>(_e16 + _e17);
    uint _e21 = local_101;
    out[_e21] = as_type<uint>(as_type<float>(_e4));
    uint _e26 = _naga_sqrtf(as_type<uint>(-(0.0)));
    uint _e29 = local;
    local_4 = _e29;
    uint _e31 = local_4;
    local_5 = static_cast<uint>(_e31);
    local_6 = static_cast<uint>(1);
    uint _e37 = local_5;
    uint _e38 = local_6;
    local_102 = static_cast<uint>(_e37 + _e38);
    uint _e42 = local_102;
    out[_e42] = as_type<uint>(as_type<float>(_e26));
    uint _e46 = _naga_sqrtf(as_type<uint>(1.0));
    uint _e49 = local;
    local_7 = _e49;
    uint _e51 = local_7;
    local_8 = static_cast<uint>(_e51);
    local_9 = static_cast<uint>(2);
    uint _e57 = local_8;
    uint _e58 = local_9;
    local_103 = static_cast<uint>(_e57 + _e58);
    uint _e62 = local_103;
    out[_e62] = as_type<uint>(as_type<float>(_e46));
    float _e65 = root_2(4);
    uint _e67 = local;
    local_10 = _e67;
    uint _e69 = local_10;
    local_11 = static_cast<uint>(_e69);
    local_12 = static_cast<uint>(3);
    uint _e75 = local_11;
    uint _e76 = local_12;
    local_104 = static_cast<uint>(_e75 + _e76);
    uint _e80 = local_104;
    out[_e80] = as_type<uint>(_e65);
    float _e83 = root_3(9u);
    uint _e85 = local;
    local_13 = _e85;
    uint _e87 = local_13;
    local_14 = static_cast<uint>(_e87);
    local_15 = static_cast<uint>(4);
    uint _e93 = local_14;
    uint _e94 = local_15;
    local_105 = static_cast<uint>(_e93 + _e94);
    uint _e98 = local_105;
    out[_e98] = as_type<uint>(_e83);
    uint _e102 = _naga_sqrtf(as_type<uint>(6.25));
    uint _e105 = local;
    local_16 = _e105;
    uint _e107 = local_16;
    local_17 = static_cast<uint>(_e107);
    local_18 = static_cast<uint>(5);
    uint _e113 = local_17;
    uint _e114 = local_18;
    local_106 = static_cast<uint>(_e113 + _e114);
    uint _e118 = local_106;
    out[_e118] = as_type<uint>(as_type<float>(_e102));
    uint _e122 = _naga_sqrtf(as_type<uint>(2.0));
    uint _e125 = local;
    local_19 = _e125;
    uint _e127 = local_19;
    local_20 = static_cast<uint>(_e127);
    local_21 = static_cast<uint>(6);
    uint _e133 = local_20;
    uint _e134 = local_21;
    local_107 = static_cast<uint>(_e133 + _e134);
    uint _e138 = local_107;
    out[_e138] = as_type<uint>(as_type<float>(_e122));
    local_25 = 1u;
    uint _e142 = local_25;
    uint _e145 = _naga_sqrtf(as_type<uint>(as_type<float>(_e142)));
    uint _e148 = local;
    local_22 = _e148;
    uint _e150 = local_22;
    local_23 = static_cast<uint>(_e150);
    local_24 = static_cast<uint>(7);
    uint _e156 = local_23;
    uint _e157 = local_24;
    local_108 = static_cast<uint>(_e156 + _e157);
    uint _e161 = local_108;
    out[_e161] = as_type<uint>(as_type<float>(_e145));
    local_29 = 8388607u;
    uint _e165 = local_29;
    uint _e168 = _naga_sqrtf(as_type<uint>(as_type<float>(_e165)));
    uint _e171 = local;
    local_26 = _e171;
    uint _e173 = local_26;
    local_27 = static_cast<uint>(_e173);
    local_28 = static_cast<uint>(8);
    uint _e179 = local_27;
    uint _e180 = local_28;
    local_109 = static_cast<uint>(_e179 + _e180);
    uint _e184 = local_109;
    out[_e184] = as_type<uint>(as_type<float>(_e168));
    local_33 = 8388608u;
    uint _e188 = local_33;
    uint _e191 = _naga_sqrtf(as_type<uint>(as_type<float>(_e188)));
    uint _e194 = local;
    local_30 = _e194;
    uint _e196 = local_30;
    local_31 = static_cast<uint>(_e196);
    local_32 = static_cast<uint>(9);
    uint _e202 = local_31;
    uint _e203 = local_32;
    local_110 = static_cast<uint>(_e202 + _e203);
    uint _e207 = local_110;
    out[_e207] = as_type<uint>(as_type<float>(_e191));
    local_37 = 2139095039u;
    uint _e211 = local_37;
    uint _e214 = _naga_sqrtf(as_type<uint>(as_type<float>(_e211)));
    uint _e217 = local;
    local_34 = _e217;
    uint _e219 = local_34;
    local_35 = static_cast<uint>(_e219);
    local_36 = static_cast<uint>(10);
    uint _e225 = local_35;
    uint _e226 = local_36;
    local_111 = static_cast<uint>(_e225 + _e226);
    uint _e230 = local_111;
    out[_e230] = as_type<uint>(as_type<float>(_e214));
    local_41 = 2139095040u;
    uint _e234 = local_41;
    uint _e237 = _naga_sqrtf(as_type<uint>(as_type<float>(_e234)));
    uint _e240 = local;
    local_38 = _e240;
    uint _e242 = local_38;
    local_39 = static_cast<uint>(_e242);
    local_40 = static_cast<uint>(11);
    uint _e248 = local_39;
    uint _e249 = local_40;
    local_112 = static_cast<uint>(_e248 + _e249);
    uint _e253 = local_112;
    out[_e253] = as_type<uint>(as_type<float>(_e237));
    uint _e258 = _naga_sqrtf(as_type<uint>(-(1.0)));
    uint _e261 = local;
    local_42 = _e261;
    uint _e263 = local_42;
    local_43 = static_cast<uint>(_e263);
    local_44 = static_cast<uint>(12);
    uint _e269 = local_43;
    uint _e270 = local_44;
    local_113 = static_cast<uint>(_e269 + _e270);
    uint _e274 = local_113;
    out[_e274] = as_type<uint>(as_type<float>(_e258));
    local_48 = 2139095041u;
    uint _e278 = local_48;
    uint _e281 = _naga_sqrtf(as_type<uint>(as_type<float>(_e278)));
    uint _e284 = local;
    local_45 = _e284;
    uint _e286 = local_45;
    local_46 = static_cast<uint>(_e286);
    local_47 = static_cast<uint>(13);
    uint _e292 = local_46;
    uint _e293 = local_47;
    local_114 = static_cast<uint>(_e292 + _e293);
    uint _e297 = local_114;
    out[_e297] = as_type<uint>(as_type<float>(_e281));
    value = 4.0;
    float _e301 = value;
    value = _e301 + static_cast<float>(1);
    float _e305 = root_1(_e301);
    uint _e307 = local;
    local_49 = _e307;
    uint _e309 = local_49;
    local_50 = static_cast<uint>(_e309);
    local_51 = static_cast<uint>(14);
    uint _e315 = local_50;
    uint _e316 = local_51;
    local_115 = static_cast<uint>(_e315 + _e316);
    uint _e320 = local_115;
    out[_e320] = as_type<uint>(_e305);
    float _e322 = value;
    uint _e324 = local;
    local_52 = _e324;
    uint _e326 = local_52;
    local_53 = static_cast<uint>(_e326);
    local_54 = static_cast<uint>(15);
    uint _e332 = local_53;
    uint _e333 = local_54;
    local_116 = static_cast<uint>(_e332 + _e333);
    uint _e337 = local_116;
    out[_e337] = as_type<uint>(_e322);
    int _e340 = sqrtf(true);
    uint _e342 = local;
    local_55 = _e342;
    uint _e344 = local_55;
    local_56 = static_cast<uint>(_e344);
    local_57 = static_cast<uint>(16);
    uint _e350 = local_56;
    uint _e351 = local_57;
    local_117 = static_cast<uint>(_e350 + _e351);
    uint _e355 = local_117;
    out[_e355] = static_cast<uint>(_e340);
    int _e358 = sqrtf(false);
    uint _e360 = local;
    local_58 = _e360;
    uint _e362 = local_58;
    local_59 = static_cast<uint>(_e362);
    local_60 = static_cast<uint>(17);
    uint _e368 = local_59;
    uint _e369 = local_60;
    local_118 = static_cast<uint>(_e368 + _e369);
    uint _e373 = local_118;
    out[_e373] = static_cast<uint>(_e358);
    float _e377 = sqrtf_1(2.0, 3.0);
    uint _e379 = local;
    local_61 = _e379;
    uint _e381 = local_61;
    local_62 = static_cast<uint>(_e381);
    local_63 = static_cast<uint>(18);
    uint _e387 = local_62;
    uint _e388 = local_63;
    local_119 = static_cast<uint>(_e387 + _e388);
    uint _e392 = local_119;
    out[_e392] = as_type<uint>(_e377);
    local_67 = 1065353217u;
    uint _e396 = local_67;
    uint _e399 = _naga_sqrtf(as_type<uint>(as_type<float>(_e396)));
    uint _e402 = local;
    local_64 = _e402;
    uint _e404 = local_64;
    local_65 = static_cast<uint>(_e404);
    local_66 = static_cast<uint>(19);
    uint _e410 = local_65;
    uint _e411 = local_66;
    local_120 = static_cast<uint>(_e410 + _e411);
    uint _e415 = local_120;
    out[_e415] = as_type<uint>(as_type<float>(_e399));
    local_71 = 1065353218u;
    uint _e419 = local_71;
    uint _e422 = _naga_sqrtf(as_type<uint>(as_type<float>(_e419)));
    uint _e425 = local;
    local_68 = _e425;
    uint _e427 = local_68;
    local_69 = static_cast<uint>(_e427);
    local_70 = static_cast<uint>(20);
    uint _e433 = local_69;
    uint _e434 = local_70;
    local_121 = static_cast<uint>(_e433 + _e434);
    uint _e438 = local_121;
    out[_e438] = as_type<uint>(as_type<float>(_e422));
    local_75 = 1065353215u;
    uint _e442 = local_75;
    uint _e445 = _naga_sqrtf(as_type<uint>(as_type<float>(_e442)));
    uint _e448 = local;
    local_72 = _e448;
    uint _e450 = local_72;
    local_73 = static_cast<uint>(_e450);
    local_74 = static_cast<uint>(21);
    uint _e456 = local_73;
    uint _e457 = local_74;
    local_122 = static_cast<uint>(_e456 + _e457);
    uint _e461 = local_122;
    out[_e461] = as_type<uint>(as_type<float>(_e445));
    float _e464 = root_3(4294967295u);
    uint _e466 = local;
    local_76 = _e466;
    uint _e468 = local_76;
    local_77 = static_cast<uint>(_e468);
    local_78 = static_cast<uint>(22);
    uint _e474 = local_77;
    uint _e475 = local_78;
    local_123 = static_cast<uint>(_e474 + _e475);
    uint _e479 = local_123;
    out[_e479] = as_type<uint>(_e464);
    float _e483 = root_2(naga_neg(4));
    uint _e485 = local;
    local_79 = _e485;
    uint _e487 = local_79;
    local_80 = static_cast<uint>(_e487);
    local_81 = static_cast<uint>(23);
    uint _e493 = local_80;
    uint _e494 = local_81;
    local_124 = static_cast<uint>(_e493 + _e494);
    uint _e498 = local_124;
    out[_e498] = as_type<uint>(_e483);
    float _e501 = root_1(16.0);
    uint _e503 = local;
    local_82 = _e503;
    uint _e505 = local_82;
    local_83 = static_cast<uint>(_e505);
    local_84 = static_cast<uint>(24);
    uint _e511 = local_83;
    uint _e512 = local_84;
    local_125 = static_cast<uint>(_e511 + _e512);
    uint _e516 = local_125;
    out[_e516] = as_type<uint>(_e501);
    uint _e520 = _naga_sqrtf(as_type<uint>(0.25));
    uint _e523 = local;
    local_85 = _e523;
    uint _e525 = local_85;
    local_86 = static_cast<uint>(_e525);
    local_87 = static_cast<uint>(25);
    uint _e531 = local_86;
    uint _e532 = local_87;
    local_126 = static_cast<uint>(_e531 + _e532);
    uint _e536 = local_126;
    out[_e536] = as_type<uint>(as_type<float>(_e520));
    local_91 = 2147483649u;
    uint _e540 = local_91;
    uint _e543 = _naga_sqrtf(as_type<uint>(as_type<float>(_e540)));
    uint _e546 = local;
    local_88 = _e546;
    uint _e548 = local_88;
    local_89 = static_cast<uint>(_e548);
    local_90 = static_cast<uint>(26);
    uint _e554 = local_89;
    uint _e555 = local_90;
    local_127 = static_cast<uint>(_e554 + _e555);
    uint _e559 = local_127;
    out[_e559] = as_type<uint>(as_type<float>(_e543));
    float _e562 = root_4(false);
    uint _e564 = local;
    local_92 = _e564;
    uint _e566 = local_92;
    local_93 = static_cast<uint>(_e566);
    local_94 = static_cast<uint>(27);
    uint _e572 = local_93;
    uint _e573 = local_94;
    local_128 = static_cast<uint>(_e572 + _e573);
    uint _e577 = local_128;
    out[_e577] = as_type<uint>(_e562);
    float _e580 = root_4(true);
    uint _e582 = local;
    local_95 = _e582;
    uint _e584 = local_95;
    local_96 = static_cast<uint>(_e584);
    local_97 = static_cast<uint>(28);
    uint _e590 = local_96;
    uint _e591 = local_97;
    local_129 = static_cast<uint>(_e590 + _e591);
    uint _e595 = local_129;
    out[_e595] = as_type<uint>(_e580);
    float _e598 = root_1(0.5);
    uint _e600 = local;
    local_98 = _e600;
    uint _e602 = local_98;
    local_99 = static_cast<uint>(_e602);
    local_100 = static_cast<uint>(29);
    uint _e608 = local_99;
    uint _e609 = local_100;
    local_130 = static_cast<uint>(_e608 + _e609);
    uint _e613 = local_130;
    out[_e613] = as_type<uint>(_e598);
}
