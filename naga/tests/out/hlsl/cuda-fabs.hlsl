struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);

float2 fabs(float2 value_1)
{
    float2 value_2 = (float2)0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;

    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_144 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_144;
    float _e15 = value_2.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_145 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_145;
    return float2(asfloat(_e12), asfloat(_e24));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

float3_ fabs_1(float3_ value_3)
{
    float3_ value_4 = (float3_)0;
    uint local_146 = (uint)0;
    uint local_147 = (uint)0;
    uint local_148 = (uint)0;

    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_146 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_146;
    float _e15 = value_4.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_147 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_147;
    float _e27 = value_4.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_148 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_148;
    const float3_ float3_1 = Constructfloat3_(asfloat(_e12), asfloat(_e24), asfloat(_e36));
    return float3_1;
}

float4 fabs_2(float4 value_5)
{
    float4 value_6 = (float4)0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;

    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_149 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_149;
    float _e15 = value_6.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_150 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_150;
    float _e27 = value_6.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_151 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_151;
    float _e39 = value_6.w;
    uint _e42 = (asuint(_e39) & 2147483647u);
    local_152 = ((_e42 > 2139095040u) ? 2143289344u : _e42);
    uint _e48 = local_152;
    return float4(asfloat(_e12), asfloat(_e24), asfloat(_e36), asfloat(_e48));
}

float absolute(float value_7)
{
    float value_8 = (float)0;
    uint local_153 = (uint)0;

    value_8 = value_7;
    float _e2 = value_8;
    uint _e5 = (asuint(_e2) & 2147483647u);
    local_153 = ((_e5 > 2139095040u) ? 2143289344u : _e5);
    uint _e11 = local_153;
    return asfloat(_e11);
}

float converted_absolute(int value_9)
{
    int value_10 = (int)0;
    uint local_154 = (uint)0;

    value_10 = value_9;
    int _e2 = value_10;
    uint _e6 = (asuint(float(_e2)) & 2147483647u);
    local_154 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_154;
    return asfloat(_e12);
}

float converted_absolute_1(uint value_11)
{
    uint value_12 = (uint)0;
    uint local_155 = (uint)0;

    value_12 = value_11;
    uint _e2 = value_12;
    uint _e6 = (asuint(float(_e2)) & 2147483647u);
    local_155 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_155;
    return asfloat(_e12);
}

float converted_absolute_2(bool value_13)
{
    bool value_14 = (bool)0;
    uint local_156 = (uint)0;

    value_14 = value_13;
    bool _e2 = value_14;
    uint _e6 = (asuint(float(_e2)) & 2147483647u);
    local_156 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_156;
    return asfloat(_e12);
}

int fabs_3(int value_15)
{
    int value_16 = (int)0;

    value_16 = value_15;
    int _e3 = value_16;
    return asint(asuint(_e3) + asuint(int(40)));
}

uint fabs_4(uint value_17)
{
    uint value_18 = (uint)0;

    value_18 = value_17;
    uint _e3 = value_18;
    return (_e3 + 50u);
}

int fabs_5(bool value_19)
{
    bool value_20 = (bool)0;
    int local_157 = (int)0;

    value_20 = value_19;
    bool _e2 = value_20;
    if (_e2) {
        local_157 = int(7);
    } else {
        local_157 = int(9);
    }
    int _e6 = local_157;
    return _e6;
}

int fabsf(bool value_21)
{
    bool value_22 = (bool)0;
    int local_158 = (int)0;

    value_22 = value_21;
    bool _e2 = value_22;
    if (_e2) {
        local_158 = int(11);
    } else {
        local_158 = int(13);
    }
    int _e6 = local_158;
    return _e6;
}

float fabsf_1(float first, float second)
{
    float first_1 = (float)0;
    float second_1 = (float)0;

    first_1 = first;
    second_1 = second;
    float _e4 = first_1;
    float _e5 = second_1;
    return (_e4 + _e5);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void absolutes()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    float value = (float)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
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
    float3_ triple = (float3_)0;
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
    float2 pair = (float2)0;
    float4 quadruple = (float4)0;
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
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138 = (uint)0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;

    local = 0u;
    uint _e5 = (asuint(0.0) & 2147483647u);
    local_4 = ((_e5 > 2139095040u) ? 2143289344u : _e5);
    uint _e11 = local_4;
    uint _e14 = local;
    local_1 = _e14;
    uint _e16 = local_1;
    local_2 = uint(_e16);
    local_3 = uint(int(0));
    uint _e23 = local_2;
    uint _e24 = local_3;
    local_114 = uint((_e23 + _e24));
    uint _e28 = local_114;
    out_.Store(_e28*4, asuint(asuint(asfloat(_e11))));
    uint _e34 = (asuint(-(0.0)) & 2147483647u);
    local_8 = ((_e34 > 2139095040u) ? 2143289344u : _e34);
    uint _e40 = local_8;
    uint _e43 = local;
    local_5 = _e43;
    uint _e45 = local_5;
    local_6 = uint(_e45);
    local_7 = uint(int(1));
    uint _e51 = local_6;
    uint _e52 = local_7;
    local_115 = uint((_e51 + _e52));
    uint _e56 = local_115;
    out_.Store(_e56*4, asuint(asuint(asfloat(_e40))));
    uint _e62 = (asuint(-(1.75)) & 2147483647u);
    local_12 = ((_e62 > 2139095040u) ? 2143289344u : _e62);
    uint _e68 = local_12;
    uint _e71 = local;
    local_9 = _e71;
    uint _e73 = local_9;
    local_10 = uint(_e73);
    local_11 = uint(int(2));
    uint _e79 = local_10;
    uint _e80 = local_11;
    local_116 = uint((_e79 + _e80));
    uint _e84 = local_116;
    out_.Store(_e84*4, asuint(asuint(asfloat(_e68))));
    const float _e88 = absolute(-(1.25));
    uint _e90 = local;
    local_13 = _e90;
    uint _e92 = local_13;
    local_14 = uint(_e92);
    local_15 = uint(int(3));
    uint _e98 = local_14;
    uint _e99 = local_15;
    local_117 = uint((_e98 + _e99));
    uint _e103 = local_117;
    out_.Store(_e103*4, asuint(asuint(_e88)));
    const float _e107 = converted_absolute(naga_neg(int(3)));
    uint _e109 = local;
    local_16 = _e109;
    uint _e111 = local_16;
    local_17 = uint(_e111);
    local_18 = uint(int(4));
    uint _e117 = local_17;
    uint _e118 = local_18;
    local_118 = uint((_e117 + _e118));
    uint _e122 = local_118;
    out_.Store(_e122*4, asuint(asuint(_e107)));
    const float _e125 = converted_absolute_1(4294967295u);
    uint _e127 = local;
    local_19 = _e127;
    uint _e129 = local_19;
    local_20 = uint(_e129);
    local_21 = uint(int(5));
    uint _e135 = local_20;
    uint _e136 = local_21;
    local_119 = uint((_e135 + _e136));
    uint _e140 = local_119;
    out_.Store(_e140*4, asuint(asuint(_e125)));
    const float _e143 = converted_absolute_2(true);
    uint _e145 = local;
    local_22 = _e145;
    uint _e147 = local_22;
    local_23 = uint(_e147);
    local_24 = uint(int(6));
    uint _e153 = local_23;
    uint _e154 = local_24;
    local_120 = uint((_e153 + _e154));
    uint _e158 = local_120;
    out_.Store(_e158*4, asuint(asuint(_e143)));
    const float _e161 = converted_absolute_2(false);
    uint _e163 = local;
    local_25 = _e163;
    uint _e165 = local_25;
    local_26 = uint(_e165);
    local_27 = uint(int(7));
    uint _e171 = local_26;
    uint _e172 = local_27;
    local_121 = uint((_e171 + _e172));
    uint _e176 = local_121;
    out_.Store(_e176*4, asuint(asuint(_e161)));
    local_31 = 1u;
    uint _e180 = local_31;
    uint _e184 = (asuint(asfloat(_e180)) & 2147483647u);
    local_32 = ((_e184 > 2139095040u) ? 2143289344u : _e184);
    uint _e190 = local_32;
    uint _e193 = local;
    local_28 = _e193;
    uint _e195 = local_28;
    local_29 = uint(_e195);
    local_30 = uint(int(8));
    uint _e201 = local_29;
    uint _e202 = local_30;
    local_122 = uint((_e201 + _e202));
    uint _e206 = local_122;
    out_.Store(_e206*4, asuint(asuint(asfloat(_e190))));
    local_36 = 2147483649u;
    uint _e210 = local_36;
    uint _e214 = (asuint(asfloat(_e210)) & 2147483647u);
    local_37 = ((_e214 > 2139095040u) ? 2143289344u : _e214);
    uint _e220 = local_37;
    uint _e223 = local;
    local_33 = _e223;
    uint _e225 = local_33;
    local_34 = uint(_e225);
    local_35 = uint(int(9));
    uint _e231 = local_34;
    uint _e232 = local_35;
    local_123 = uint((_e231 + _e232));
    uint _e236 = local_123;
    out_.Store(_e236*4, asuint(asuint(asfloat(_e220))));
    local_41 = 8388607u;
    uint _e240 = local_41;
    uint _e244 = (asuint(asfloat(_e240)) & 2147483647u);
    local_42 = ((_e244 > 2139095040u) ? 2143289344u : _e244);
    uint _e250 = local_42;
    uint _e253 = local;
    local_38 = _e253;
    uint _e255 = local_38;
    local_39 = uint(_e255);
    local_40 = uint(int(10));
    uint _e261 = local_39;
    uint _e262 = local_40;
    local_124 = uint((_e261 + _e262));
    uint _e266 = local_124;
    out_.Store(_e266*4, asuint(asuint(asfloat(_e250))));
    local_46 = 2155872255u;
    uint _e270 = local_46;
    uint _e274 = (asuint(asfloat(_e270)) & 2147483647u);
    local_47 = ((_e274 > 2139095040u) ? 2143289344u : _e274);
    uint _e280 = local_47;
    uint _e283 = local;
    local_43 = _e283;
    uint _e285 = local_43;
    local_44 = uint(_e285);
    local_45 = uint(int(11));
    uint _e291 = local_44;
    uint _e292 = local_45;
    local_125 = uint((_e291 + _e292));
    uint _e296 = local_125;
    out_.Store(_e296*4, asuint(asuint(asfloat(_e280))));
    uint _e301 = (asuint(3.4028235e38) & 2147483647u);
    local_51 = ((_e301 > 2139095040u) ? 2143289344u : _e301);
    uint _e307 = local_51;
    uint _e310 = local;
    local_48 = _e310;
    uint _e312 = local_48;
    local_49 = uint(_e312);
    local_50 = uint(int(12));
    uint _e318 = local_49;
    uint _e319 = local_50;
    local_126 = uint((_e318 + _e319));
    uint _e323 = local_126;
    out_.Store(_e323*4, asuint(asuint(asfloat(_e307))));
    uint _e329 = (asuint(-(3.4028235e38)) & 2147483647u);
    local_55 = ((_e329 > 2139095040u) ? 2143289344u : _e329);
    uint _e335 = local_55;
    uint _e338 = local;
    local_52 = _e338;
    uint _e340 = local_52;
    local_53 = uint(_e340);
    local_54 = uint(int(13));
    uint _e346 = local_53;
    uint _e347 = local_54;
    local_127 = uint((_e346 + _e347));
    uint _e351 = local_127;
    out_.Store(_e351*4, asuint(asuint(asfloat(_e335))));
    local_59 = 2139095040u;
    uint _e355 = local_59;
    uint _e359 = (asuint(asfloat(_e355)) & 2147483647u);
    local_60 = ((_e359 > 2139095040u) ? 2143289344u : _e359);
    uint _e365 = local_60;
    uint _e368 = local;
    local_56 = _e368;
    uint _e370 = local_56;
    local_57 = uint(_e370);
    local_58 = uint(int(14));
    uint _e376 = local_57;
    uint _e377 = local_58;
    local_128 = uint((_e376 + _e377));
    uint _e381 = local_128;
    out_.Store(_e381*4, asuint(asuint(asfloat(_e365))));
    local_64 = 4286578688u;
    uint _e385 = local_64;
    uint _e389 = (asuint(asfloat(_e385)) & 2147483647u);
    local_65 = ((_e389 > 2139095040u) ? 2143289344u : _e389);
    uint _e395 = local_65;
    uint _e398 = local;
    local_61 = _e398;
    uint _e400 = local_61;
    local_62 = uint(_e400);
    local_63 = uint(int(15));
    uint _e406 = local_62;
    uint _e407 = local_63;
    local_129 = uint((_e406 + _e407));
    uint _e411 = local_129;
    out_.Store(_e411*4, asuint(asuint(asfloat(_e395))));
    local_69 = 2143363909u;
    uint _e415 = local_69;
    uint _e419 = (asuint(asfloat(_e415)) & 2147483647u);
    local_70 = ((_e419 > 2139095040u) ? 2143289344u : _e419);
    uint _e425 = local_70;
    uint _e428 = local;
    local_66 = _e428;
    uint _e430 = local_66;
    local_67 = uint(_e430);
    local_68 = uint(int(16));
    uint _e436 = local_67;
    uint _e437 = local_68;
    local_130 = uint((_e436 + _e437));
    uint _e441 = local_130;
    out_.Store(_e441*4, asuint(asuint(asfloat(_e425))));
    local_74 = 2139095041u;
    uint _e445 = local_74;
    uint _e449 = (asuint(asfloat(_e445)) & 2147483647u);
    local_75 = ((_e449 > 2139095040u) ? 2143289344u : _e449);
    uint _e455 = local_75;
    uint _e458 = local;
    local_71 = _e458;
    uint _e460 = local_71;
    local_72 = uint(_e460);
    local_73 = uint(int(17));
    uint _e466 = local_72;
    uint _e467 = local_73;
    local_131 = uint((_e466 + _e467));
    uint _e471 = local_131;
    out_.Store(_e471*4, asuint(asuint(asfloat(_e455))));
    value = -(2.75);
    float _e476 = value;
    value = (_e476 + float(int(1)));
    uint _e482 = (asuint(_e476) & 2147483647u);
    local_79 = ((_e482 > 2139095040u) ? 2143289344u : _e482);
    uint _e488 = local_79;
    uint _e491 = local;
    local_76 = _e491;
    uint _e493 = local_76;
    local_77 = uint(_e493);
    local_78 = uint(int(18));
    uint _e499 = local_77;
    uint _e500 = local_78;
    local_132 = uint((_e499 + _e500));
    uint _e504 = local_132;
    out_.Store(_e504*4, asuint(asuint(asfloat(_e488))));
    float _e506 = value;
    uint _e508 = local;
    local_80 = _e508;
    uint _e510 = local_80;
    local_81 = uint(_e510);
    local_82 = uint(int(19));
    uint _e516 = local_81;
    uint _e517 = local_82;
    local_133 = uint((_e516 + _e517));
    uint _e521 = local_133;
    out_.Store(_e521*4, asuint(asuint(_e506)));
    const int _e525 = fabs_3(naga_neg(int(3)));
    uint _e527 = local;
    local_83 = _e527;
    uint _e529 = local_83;
    local_84 = uint(_e529);
    local_85 = uint(int(20));
    uint _e535 = local_84;
    uint _e536 = local_85;
    local_134 = uint((_e535 + _e536));
    uint _e540 = local_134;
    out_.Store(_e540*4, asuint(uint(_e525)));
    const uint _e543 = fabs_4(3u);
    uint _e544 = local;
    local_86 = _e544;
    uint _e546 = local_86;
    local_87 = uint(_e546);
    local_88 = uint(int(21));
    uint _e552 = local_87;
    uint _e553 = local_88;
    local_135 = uint((_e552 + _e553));
    uint _e557 = local_135;
    out_.Store(_e557*4, asuint(_e543));
    const int _e560 = fabs_5(true);
    uint _e562 = local;
    local_89 = _e562;
    uint _e564 = local_89;
    local_90 = uint(_e564);
    local_91 = uint(int(22));
    uint _e570 = local_90;
    uint _e571 = local_91;
    local_136 = uint((_e570 + _e571));
    uint _e575 = local_136;
    out_.Store(_e575*4, asuint(uint(_e560)));
    const int _e578 = fabs_5(false);
    uint _e580 = local;
    local_92 = _e580;
    uint _e582 = local_92;
    local_93 = uint(_e582);
    local_94 = uint(int(23));
    uint _e588 = local_93;
    uint _e589 = local_94;
    local_137 = uint((_e588 + _e589));
    uint _e593 = local_137;
    out_.Store(_e593*4, asuint(uint(_e578)));
    const int _e596 = fabsf(true);
    uint _e598 = local;
    local_95 = _e598;
    uint _e600 = local_95;
    local_96 = uint(_e600);
    local_97 = uint(int(24));
    uint _e606 = local_96;
    uint _e607 = local_97;
    local_138 = uint((_e606 + _e607));
    uint _e611 = local_138;
    out_.Store(_e611*4, asuint(uint(_e596)));
    local_98 = 2147483649u;
    uint _e619 = local_98;
    const float3_ _e622 = fabs_1(Constructfloat3_(-(2.5), -(0.0), asfloat(_e619)));
    triple = _e622;
    float _e625 = triple.x;
    uint _e627 = local;
    local_99 = _e627;
    uint _e629 = local_99;
    local_100 = uint(_e629);
    local_101 = uint(int(25));
    uint _e635 = local_100;
    uint _e636 = local_101;
    local_139 = uint((_e635 + _e636));
    uint _e640 = local_139;
    out_.Store(_e640*4, asuint(asuint(_e625)));
    float _e643 = triple.y;
    uint _e645 = local;
    local_102 = _e645;
    uint _e647 = local_102;
    local_103 = uint(_e647);
    local_104 = uint(int(26));
    uint _e653 = local_103;
    uint _e654 = local_104;
    local_140 = uint((_e653 + _e654));
    uint _e658 = local_140;
    out_.Store(_e658*4, asuint(asuint(_e643)));
    float _e661 = triple.z;
    uint _e663 = local;
    local_105 = _e663;
    uint _e665 = local_105;
    local_106 = uint(_e665);
    local_107 = uint(int(27));
    uint _e671 = local_106;
    uint _e672 = local_107;
    local_141 = uint((_e671 + _e672));
    uint _e676 = local_141;
    out_.Store(_e676*4, asuint(asuint(_e661)));
    const float _e681 = fabsf_1(-(2.0), 3.0);
    uint _e683 = local;
    local_108 = _e683;
    uint _e685 = local_108;
    local_109 = uint(_e685);
    local_110 = uint(int(28));
    uint _e691 = local_109;
    uint _e692 = local_110;
    local_142 = uint((_e691 + _e692));
    uint _e696 = local_142;
    out_.Store(_e696*4, asuint(asuint(_e681)));
    const float2 _e703 = fabs(float2(-(3.0), -(4.0)));
    pair = _e703;
    const float4 _e714 = fabs_2(float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e714;
    float _e718 = pair.x;
    float _e719 = pair.y;
    float _e722 = quadruple.x;
    float _e725 = quadruple.w;
    uint _e728 = local;
    local_111 = _e728;
    uint _e730 = local_111;
    local_112 = uint(_e730);
    local_113 = uint(int(29));
    uint _e736 = local_112;
    uint _e737 = local_113;
    local_143 = uint((_e736 + _e737));
    uint _e741 = local_143;
    out_.Store(_e741*4, asuint(asuint((((_e718 + _e719) + _e722) + _e725))));
}
