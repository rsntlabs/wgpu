// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef uint type_6[1];

metal::float2 fabs(
    metal::float2 value_1
) {
    metal::float2 value_2 = {};
    uint local_144 = {};
    uint local_145 = {};
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_144 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_144;
    float _e15 = value_2.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_145 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_145;
    return metal::float2(as_type<float>(_e12), as_type<float>(_e24));
}

float3_ fabs_1(
    float3_ value_3
) {
    float3_ value_4 = {};
    uint local_146 = {};
    uint local_147 = {};
    uint local_148 = {};
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_146 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_146;
    float _e15 = value_4.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_147 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_147;
    float _e27 = value_4.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_148 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_148;
    return float3_ {as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36)};
}

metal::float4 fabs_2(
    metal::float4 value_5
) {
    metal::float4 value_6 = {};
    uint local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_149 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_149;
    float _e15 = value_6.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_150 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_150;
    float _e27 = value_6.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_151 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_151;
    float _e39 = value_6.w;
    uint _e42 = as_type<uint>(_e39) & 2147483647u;
    local_152 = (_e42 > 2139095040u) ? 2143289344u : _e42;
    uint _e48 = local_152;
    return metal::float4(as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36), as_type<float>(_e48));
}

float absolute(
    float value_7
) {
    float value_8 = {};
    uint local_153 = {};
    value_8 = value_7;
    float _e2 = value_8;
    uint _e5 = as_type<uint>(_e2) & 2147483647u;
    local_153 = (_e5 > 2139095040u) ? 2143289344u : _e5;
    uint _e11 = local_153;
    return as_type<float>(_e11);
}

float converted_absolute(
    int value_9
) {
    int value_10 = {};
    uint local_154 = {};
    value_10 = value_9;
    int _e2 = value_10;
    uint _e6 = as_type<uint>(static_cast<float>(_e2)) & 2147483647u;
    local_154 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_154;
    return as_type<float>(_e12);
}

float converted_absolute_1(
    uint value_11
) {
    uint value_12 = {};
    uint local_155 = {};
    value_12 = value_11;
    uint _e2 = value_12;
    uint _e6 = as_type<uint>(static_cast<float>(_e2)) & 2147483647u;
    local_155 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_155;
    return as_type<float>(_e12);
}

float converted_absolute_2(
    bool value_13
) {
    bool value_14 = {};
    uint local_156 = {};
    value_14 = value_13;
    bool _e2 = value_14;
    uint _e6 = as_type<uint>(static_cast<float>(_e2)) & 2147483647u;
    local_156 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_156;
    return as_type<float>(_e12);
}

int fabs_3(
    int value_15
) {
    int value_16 = {};
    value_16 = value_15;
    int _e3 = value_16;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(40));
}

uint fabs_4(
    uint value_17
) {
    uint value_18 = {};
    value_18 = value_17;
    uint _e3 = value_18;
    return _e3 + 50u;
}

int fabs_5(
    bool value_19
) {
    bool value_20 = {};
    int local_157 = {};
    value_20 = value_19;
    bool _e2 = value_20;
    if (_e2) {
        local_157 = 7;
    } else {
        local_157 = 9;
    }
    int _e6 = local_157;
    return _e6;
}

int fabsf(
    bool value_21
) {
    bool value_22 = {};
    int local_158 = {};
    value_22 = value_21;
    bool _e2 = value_22;
    if (_e2) {
        local_158 = 11;
    } else {
        local_158 = 13;
    }
    int _e6 = local_158;
    return _e6;
}

float fabsf_1(
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


kernel void absolutes(
  device type_6& out [[user(fake0)]]
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
    float value = {};
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
    float3_ triple = {};
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
    metal::float2 pair = {};
    metal::float4 quadruple = {};
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
    uint local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    uint local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    local = 0u;
    uint _e5 = as_type<uint>(0.0) & 2147483647u;
    local_4 = (_e5 > 2139095040u) ? 2143289344u : _e5;
    uint _e11 = local_4;
    uint _e14 = local;
    local_1 = _e14;
    uint _e16 = local_1;
    local_2 = static_cast<uint>(_e16);
    local_3 = static_cast<uint>(0);
    uint _e23 = local_2;
    uint _e24 = local_3;
    local_114 = static_cast<uint>(_e23 + _e24);
    uint _e28 = local_114;
    out[_e28] = as_type<uint>(as_type<float>(_e11));
    uint _e34 = as_type<uint>(-(0.0)) & 2147483647u;
    local_8 = (_e34 > 2139095040u) ? 2143289344u : _e34;
    uint _e40 = local_8;
    uint _e43 = local;
    local_5 = _e43;
    uint _e45 = local_5;
    local_6 = static_cast<uint>(_e45);
    local_7 = static_cast<uint>(1);
    uint _e51 = local_6;
    uint _e52 = local_7;
    local_115 = static_cast<uint>(_e51 + _e52);
    uint _e56 = local_115;
    out[_e56] = as_type<uint>(as_type<float>(_e40));
    uint _e62 = as_type<uint>(-(1.75)) & 2147483647u;
    local_12 = (_e62 > 2139095040u) ? 2143289344u : _e62;
    uint _e68 = local_12;
    uint _e71 = local;
    local_9 = _e71;
    uint _e73 = local_9;
    local_10 = static_cast<uint>(_e73);
    local_11 = static_cast<uint>(2);
    uint _e79 = local_10;
    uint _e80 = local_11;
    local_116 = static_cast<uint>(_e79 + _e80);
    uint _e84 = local_116;
    out[_e84] = as_type<uint>(as_type<float>(_e68));
    float _e88 = absolute(-(1.25));
    uint _e90 = local;
    local_13 = _e90;
    uint _e92 = local_13;
    local_14 = static_cast<uint>(_e92);
    local_15 = static_cast<uint>(3);
    uint _e98 = local_14;
    uint _e99 = local_15;
    local_117 = static_cast<uint>(_e98 + _e99);
    uint _e103 = local_117;
    out[_e103] = as_type<uint>(_e88);
    float _e107 = converted_absolute(naga_neg(3));
    uint _e109 = local;
    local_16 = _e109;
    uint _e111 = local_16;
    local_17 = static_cast<uint>(_e111);
    local_18 = static_cast<uint>(4);
    uint _e117 = local_17;
    uint _e118 = local_18;
    local_118 = static_cast<uint>(_e117 + _e118);
    uint _e122 = local_118;
    out[_e122] = as_type<uint>(_e107);
    float _e125 = converted_absolute_1(4294967295u);
    uint _e127 = local;
    local_19 = _e127;
    uint _e129 = local_19;
    local_20 = static_cast<uint>(_e129);
    local_21 = static_cast<uint>(5);
    uint _e135 = local_20;
    uint _e136 = local_21;
    local_119 = static_cast<uint>(_e135 + _e136);
    uint _e140 = local_119;
    out[_e140] = as_type<uint>(_e125);
    float _e143 = converted_absolute_2(true);
    uint _e145 = local;
    local_22 = _e145;
    uint _e147 = local_22;
    local_23 = static_cast<uint>(_e147);
    local_24 = static_cast<uint>(6);
    uint _e153 = local_23;
    uint _e154 = local_24;
    local_120 = static_cast<uint>(_e153 + _e154);
    uint _e158 = local_120;
    out[_e158] = as_type<uint>(_e143);
    float _e161 = converted_absolute_2(false);
    uint _e163 = local;
    local_25 = _e163;
    uint _e165 = local_25;
    local_26 = static_cast<uint>(_e165);
    local_27 = static_cast<uint>(7);
    uint _e171 = local_26;
    uint _e172 = local_27;
    local_121 = static_cast<uint>(_e171 + _e172);
    uint _e176 = local_121;
    out[_e176] = as_type<uint>(_e161);
    local_31 = 1u;
    uint _e180 = local_31;
    uint _e184 = as_type<uint>(as_type<float>(_e180)) & 2147483647u;
    local_32 = (_e184 > 2139095040u) ? 2143289344u : _e184;
    uint _e190 = local_32;
    uint _e193 = local;
    local_28 = _e193;
    uint _e195 = local_28;
    local_29 = static_cast<uint>(_e195);
    local_30 = static_cast<uint>(8);
    uint _e201 = local_29;
    uint _e202 = local_30;
    local_122 = static_cast<uint>(_e201 + _e202);
    uint _e206 = local_122;
    out[_e206] = as_type<uint>(as_type<float>(_e190));
    local_36 = 2147483649u;
    uint _e210 = local_36;
    uint _e214 = as_type<uint>(as_type<float>(_e210)) & 2147483647u;
    local_37 = (_e214 > 2139095040u) ? 2143289344u : _e214;
    uint _e220 = local_37;
    uint _e223 = local;
    local_33 = _e223;
    uint _e225 = local_33;
    local_34 = static_cast<uint>(_e225);
    local_35 = static_cast<uint>(9);
    uint _e231 = local_34;
    uint _e232 = local_35;
    local_123 = static_cast<uint>(_e231 + _e232);
    uint _e236 = local_123;
    out[_e236] = as_type<uint>(as_type<float>(_e220));
    local_41 = 8388607u;
    uint _e240 = local_41;
    uint _e244 = as_type<uint>(as_type<float>(_e240)) & 2147483647u;
    local_42 = (_e244 > 2139095040u) ? 2143289344u : _e244;
    uint _e250 = local_42;
    uint _e253 = local;
    local_38 = _e253;
    uint _e255 = local_38;
    local_39 = static_cast<uint>(_e255);
    local_40 = static_cast<uint>(10);
    uint _e261 = local_39;
    uint _e262 = local_40;
    local_124 = static_cast<uint>(_e261 + _e262);
    uint _e266 = local_124;
    out[_e266] = as_type<uint>(as_type<float>(_e250));
    local_46 = 2155872255u;
    uint _e270 = local_46;
    uint _e274 = as_type<uint>(as_type<float>(_e270)) & 2147483647u;
    local_47 = (_e274 > 2139095040u) ? 2143289344u : _e274;
    uint _e280 = local_47;
    uint _e283 = local;
    local_43 = _e283;
    uint _e285 = local_43;
    local_44 = static_cast<uint>(_e285);
    local_45 = static_cast<uint>(11);
    uint _e291 = local_44;
    uint _e292 = local_45;
    local_125 = static_cast<uint>(_e291 + _e292);
    uint _e296 = local_125;
    out[_e296] = as_type<uint>(as_type<float>(_e280));
    uint _e301 = as_type<uint>(340282350000000000000000000000000000000.0) & 2147483647u;
    local_51 = (_e301 > 2139095040u) ? 2143289344u : _e301;
    uint _e307 = local_51;
    uint _e310 = local;
    local_48 = _e310;
    uint _e312 = local_48;
    local_49 = static_cast<uint>(_e312);
    local_50 = static_cast<uint>(12);
    uint _e318 = local_49;
    uint _e319 = local_50;
    local_126 = static_cast<uint>(_e318 + _e319);
    uint _e323 = local_126;
    out[_e323] = as_type<uint>(as_type<float>(_e307));
    uint _e329 = as_type<uint>(-(340282350000000000000000000000000000000.0)) & 2147483647u;
    local_55 = (_e329 > 2139095040u) ? 2143289344u : _e329;
    uint _e335 = local_55;
    uint _e338 = local;
    local_52 = _e338;
    uint _e340 = local_52;
    local_53 = static_cast<uint>(_e340);
    local_54 = static_cast<uint>(13);
    uint _e346 = local_53;
    uint _e347 = local_54;
    local_127 = static_cast<uint>(_e346 + _e347);
    uint _e351 = local_127;
    out[_e351] = as_type<uint>(as_type<float>(_e335));
    local_59 = 2139095040u;
    uint _e355 = local_59;
    uint _e359 = as_type<uint>(as_type<float>(_e355)) & 2147483647u;
    local_60 = (_e359 > 2139095040u) ? 2143289344u : _e359;
    uint _e365 = local_60;
    uint _e368 = local;
    local_56 = _e368;
    uint _e370 = local_56;
    local_57 = static_cast<uint>(_e370);
    local_58 = static_cast<uint>(14);
    uint _e376 = local_57;
    uint _e377 = local_58;
    local_128 = static_cast<uint>(_e376 + _e377);
    uint _e381 = local_128;
    out[_e381] = as_type<uint>(as_type<float>(_e365));
    local_64 = 4286578688u;
    uint _e385 = local_64;
    uint _e389 = as_type<uint>(as_type<float>(_e385)) & 2147483647u;
    local_65 = (_e389 > 2139095040u) ? 2143289344u : _e389;
    uint _e395 = local_65;
    uint _e398 = local;
    local_61 = _e398;
    uint _e400 = local_61;
    local_62 = static_cast<uint>(_e400);
    local_63 = static_cast<uint>(15);
    uint _e406 = local_62;
    uint _e407 = local_63;
    local_129 = static_cast<uint>(_e406 + _e407);
    uint _e411 = local_129;
    out[_e411] = as_type<uint>(as_type<float>(_e395));
    local_69 = 2143363909u;
    uint _e415 = local_69;
    uint _e419 = as_type<uint>(as_type<float>(_e415)) & 2147483647u;
    local_70 = (_e419 > 2139095040u) ? 2143289344u : _e419;
    uint _e425 = local_70;
    uint _e428 = local;
    local_66 = _e428;
    uint _e430 = local_66;
    local_67 = static_cast<uint>(_e430);
    local_68 = static_cast<uint>(16);
    uint _e436 = local_67;
    uint _e437 = local_68;
    local_130 = static_cast<uint>(_e436 + _e437);
    uint _e441 = local_130;
    out[_e441] = as_type<uint>(as_type<float>(_e425));
    local_74 = 2139095041u;
    uint _e445 = local_74;
    uint _e449 = as_type<uint>(as_type<float>(_e445)) & 2147483647u;
    local_75 = (_e449 > 2139095040u) ? 2143289344u : _e449;
    uint _e455 = local_75;
    uint _e458 = local;
    local_71 = _e458;
    uint _e460 = local_71;
    local_72 = static_cast<uint>(_e460);
    local_73 = static_cast<uint>(17);
    uint _e466 = local_72;
    uint _e467 = local_73;
    local_131 = static_cast<uint>(_e466 + _e467);
    uint _e471 = local_131;
    out[_e471] = as_type<uint>(as_type<float>(_e455));
    value = -(2.75);
    float _e476 = value;
    value = _e476 + static_cast<float>(1);
    uint _e482 = as_type<uint>(_e476) & 2147483647u;
    local_79 = (_e482 > 2139095040u) ? 2143289344u : _e482;
    uint _e488 = local_79;
    uint _e491 = local;
    local_76 = _e491;
    uint _e493 = local_76;
    local_77 = static_cast<uint>(_e493);
    local_78 = static_cast<uint>(18);
    uint _e499 = local_77;
    uint _e500 = local_78;
    local_132 = static_cast<uint>(_e499 + _e500);
    uint _e504 = local_132;
    out[_e504] = as_type<uint>(as_type<float>(_e488));
    float _e506 = value;
    uint _e508 = local;
    local_80 = _e508;
    uint _e510 = local_80;
    local_81 = static_cast<uint>(_e510);
    local_82 = static_cast<uint>(19);
    uint _e516 = local_81;
    uint _e517 = local_82;
    local_133 = static_cast<uint>(_e516 + _e517);
    uint _e521 = local_133;
    out[_e521] = as_type<uint>(_e506);
    int _e525 = fabs_3(naga_neg(3));
    uint _e527 = local;
    local_83 = _e527;
    uint _e529 = local_83;
    local_84 = static_cast<uint>(_e529);
    local_85 = static_cast<uint>(20);
    uint _e535 = local_84;
    uint _e536 = local_85;
    local_134 = static_cast<uint>(_e535 + _e536);
    uint _e540 = local_134;
    out[_e540] = static_cast<uint>(_e525);
    uint _e543 = fabs_4(3u);
    uint _e544 = local;
    local_86 = _e544;
    uint _e546 = local_86;
    local_87 = static_cast<uint>(_e546);
    local_88 = static_cast<uint>(21);
    uint _e552 = local_87;
    uint _e553 = local_88;
    local_135 = static_cast<uint>(_e552 + _e553);
    uint _e557 = local_135;
    out[_e557] = _e543;
    int _e560 = fabs_5(true);
    uint _e562 = local;
    local_89 = _e562;
    uint _e564 = local_89;
    local_90 = static_cast<uint>(_e564);
    local_91 = static_cast<uint>(22);
    uint _e570 = local_90;
    uint _e571 = local_91;
    local_136 = static_cast<uint>(_e570 + _e571);
    uint _e575 = local_136;
    out[_e575] = static_cast<uint>(_e560);
    int _e578 = fabs_5(false);
    uint _e580 = local;
    local_92 = _e580;
    uint _e582 = local_92;
    local_93 = static_cast<uint>(_e582);
    local_94 = static_cast<uint>(23);
    uint _e588 = local_93;
    uint _e589 = local_94;
    local_137 = static_cast<uint>(_e588 + _e589);
    uint _e593 = local_137;
    out[_e593] = static_cast<uint>(_e578);
    int _e596 = fabsf(true);
    uint _e598 = local;
    local_95 = _e598;
    uint _e600 = local_95;
    local_96 = static_cast<uint>(_e600);
    local_97 = static_cast<uint>(24);
    uint _e606 = local_96;
    uint _e607 = local_97;
    local_138 = static_cast<uint>(_e606 + _e607);
    uint _e611 = local_138;
    out[_e611] = static_cast<uint>(_e596);
    local_98 = 2147483649u;
    uint _e619 = local_98;
    float3_ _e622 = fabs_1(float3_ {-(2.5), -(0.0), as_type<float>(_e619)});
    triple = _e622;
    float _e625 = triple.x;
    uint _e627 = local;
    local_99 = _e627;
    uint _e629 = local_99;
    local_100 = static_cast<uint>(_e629);
    local_101 = static_cast<uint>(25);
    uint _e635 = local_100;
    uint _e636 = local_101;
    local_139 = static_cast<uint>(_e635 + _e636);
    uint _e640 = local_139;
    out[_e640] = as_type<uint>(_e625);
    float _e643 = triple.y;
    uint _e645 = local;
    local_102 = _e645;
    uint _e647 = local_102;
    local_103 = static_cast<uint>(_e647);
    local_104 = static_cast<uint>(26);
    uint _e653 = local_103;
    uint _e654 = local_104;
    local_140 = static_cast<uint>(_e653 + _e654);
    uint _e658 = local_140;
    out[_e658] = as_type<uint>(_e643);
    float _e661 = triple.z;
    uint _e663 = local;
    local_105 = _e663;
    uint _e665 = local_105;
    local_106 = static_cast<uint>(_e665);
    local_107 = static_cast<uint>(27);
    uint _e671 = local_106;
    uint _e672 = local_107;
    local_141 = static_cast<uint>(_e671 + _e672);
    uint _e676 = local_141;
    out[_e676] = as_type<uint>(_e661);
    float _e681 = fabsf_1(-(2.0), 3.0);
    uint _e683 = local;
    local_108 = _e683;
    uint _e685 = local_108;
    local_109 = static_cast<uint>(_e685);
    local_110 = static_cast<uint>(28);
    uint _e691 = local_109;
    uint _e692 = local_110;
    local_142 = static_cast<uint>(_e691 + _e692);
    uint _e696 = local_142;
    out[_e696] = as_type<uint>(_e681);
    metal::float2 _e703 = fabs(metal::float2(-(3.0), -(4.0)));
    pair = _e703;
    metal::float4 _e714 = fabs_2(metal::float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e714;
    float _e718 = pair.x;
    float _e719 = pair.y;
    float _e722 = quadruple.x;
    float _e725 = quadruple.w;
    uint _e728 = local;
    local_111 = _e728;
    uint _e730 = local_111;
    local_112 = static_cast<uint>(_e730);
    local_113 = static_cast<uint>(29);
    uint _e736 = local_112;
    uint _e737 = local_113;
    local_143 = static_cast<uint>(_e736 + _e737);
    uint _e741 = local_143;
    out[_e741] = as_type<uint>(((_e718 + _e719) + _e722) + _e725);
}
