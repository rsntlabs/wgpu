struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);

float2 fabs(float2 value_1)
{
    float2 value_2 = (float2)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;

    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_83 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_83;
    float _e15 = value_2.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_84 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_84;
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
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;

    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_85 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_85;
    float _e15 = value_4.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_86 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_86;
    float _e27 = value_4.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_87 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_87;
    const float3_ float3_1 = Constructfloat3_(asfloat(_e12), asfloat(_e24), asfloat(_e36));
    return float3_1;
}

float4 fabs_2(float4 value_5)
{
    float4 value_6 = (float4)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;

    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_88 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_88;
    float _e15 = value_6.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_89 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_89;
    float _e27 = value_6.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_90 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_90;
    float _e39 = value_6.w;
    uint _e42 = (asuint(_e39) & 2147483647u);
    local_91 = ((_e42 > 2139095040u) ? 2143289344u : _e42);
    uint _e48 = local_91;
    return float4(asfloat(_e12), asfloat(_e24), asfloat(_e36), asfloat(_e48));
}

float absolute(float value_7)
{
    uint local_92 = (uint)0;

    uint _e3 = (asuint(value_7) & 2147483647u);
    local_92 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_92;
    return asfloat(_e9);
}

float converted_absolute(int value_8)
{
    uint local_93 = (uint)0;

    uint _e4 = (asuint(float(value_8)) & 2147483647u);
    local_93 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_93;
    return asfloat(_e10);
}

float converted_absolute_1(uint value_9)
{
    uint local_94 = (uint)0;

    uint _e4 = (asuint(float(value_9)) & 2147483647u);
    local_94 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_94;
    return asfloat(_e10);
}

float converted_absolute_2(bool value_10)
{
    uint local_95 = (uint)0;

    uint _e4 = (asuint(float(value_10)) & 2147483647u);
    local_95 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_95;
    return asfloat(_e10);
}

int fabs_3(int value_11)
{
    return asint(asuint(value_11) + asuint(int(40)));
}

uint fabs_4(uint value_12)
{
    return (value_12 + 50u);
}

int fabs_5(bool value_13)
{
    int local_96 = (int)0;

    if (value_13) {
        local_96 = int(7);
    } else {
        local_96 = int(9);
    }
    int _e6 = local_96;
    return _e6;
}

int fabsf(bool value_14)
{
    int local_97 = (int)0;

    if (value_14) {
        local_97 = int(11);
    } else {
        local_97 = int(13);
    }
    int _e6 = local_97;
    return _e6;
}

float fabsf_1(float first, float second)
{
    return (first + second);
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
    float value = (float)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    float3_ triple = (float3_)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    float2 pair = (float2)0;
    float4 quadruple = (float4)0;
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
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;

    uint _e3 = (asuint(0.0) & 2147483647u);
    local_1 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_1;
    local = uint(int(0));
    uint _e16 = local;
    local_53 = uint(_e16);
    uint _e19 = local_53;
    out_.Store(_e19*4, asuint(asuint(asfloat(_e9))));
    uint _e25 = (asuint(-(0.0)) & 2147483647u);
    local_3 = ((_e25 > 2139095040u) ? 2143289344u : _e25);
    uint _e31 = local_3;
    local_2 = uint(int(1));
    uint _e37 = local_2;
    local_54 = uint(_e37);
    uint _e40 = local_54;
    out_.Store(_e40*4, asuint(asuint(asfloat(_e31))));
    uint _e46 = (asuint(-(1.75)) & 2147483647u);
    local_5 = ((_e46 > 2139095040u) ? 2143289344u : _e46);
    uint _e52 = local_5;
    local_4 = uint(int(2));
    uint _e58 = local_4;
    local_55 = uint(_e58);
    uint _e61 = local_55;
    out_.Store(_e61*4, asuint(asuint(asfloat(_e52))));
    const float _e65 = absolute(-(1.25));
    local_6 = uint(int(3));
    uint _e70 = local_6;
    local_56 = uint(_e70);
    uint _e73 = local_56;
    out_.Store(_e73*4, asuint(asuint(_e65)));
    const float _e77 = converted_absolute(naga_neg(int(3)));
    local_7 = uint(int(4));
    uint _e82 = local_7;
    local_57 = uint(_e82);
    uint _e85 = local_57;
    out_.Store(_e85*4, asuint(asuint(_e77)));
    const float _e88 = converted_absolute_1(4294967295u);
    local_8 = uint(int(5));
    uint _e93 = local_8;
    local_58 = uint(_e93);
    uint _e96 = local_58;
    out_.Store(_e96*4, asuint(asuint(_e88)));
    const float _e99 = converted_absolute_2(true);
    local_9 = uint(int(6));
    uint _e104 = local_9;
    local_59 = uint(_e104);
    uint _e107 = local_59;
    out_.Store(_e107*4, asuint(asuint(_e99)));
    const float _e110 = converted_absolute_2(false);
    local_10 = uint(int(7));
    uint _e115 = local_10;
    local_60 = uint(_e115);
    uint _e118 = local_60;
    out_.Store(_e118*4, asuint(asuint(_e110)));
    local_12 = 1u;
    uint _e122 = local_12;
    uint _e126 = (asuint(asfloat(_e122)) & 2147483647u);
    local_13 = ((_e126 > 2139095040u) ? 2143289344u : _e126);
    uint _e132 = local_13;
    local_11 = uint(int(8));
    uint _e138 = local_11;
    local_61 = uint(_e138);
    uint _e141 = local_61;
    out_.Store(_e141*4, asuint(asuint(asfloat(_e132))));
    local_15 = 2147483649u;
    uint _e145 = local_15;
    uint _e149 = (asuint(asfloat(_e145)) & 2147483647u);
    local_16 = ((_e149 > 2139095040u) ? 2143289344u : _e149);
    uint _e155 = local_16;
    local_14 = uint(int(9));
    uint _e161 = local_14;
    local_62 = uint(_e161);
    uint _e164 = local_62;
    out_.Store(_e164*4, asuint(asuint(asfloat(_e155))));
    local_18 = 8388607u;
    uint _e168 = local_18;
    uint _e172 = (asuint(asfloat(_e168)) & 2147483647u);
    local_19 = ((_e172 > 2139095040u) ? 2143289344u : _e172);
    uint _e178 = local_19;
    local_17 = uint(int(10));
    uint _e184 = local_17;
    local_63 = uint(_e184);
    uint _e187 = local_63;
    out_.Store(_e187*4, asuint(asuint(asfloat(_e178))));
    local_21 = 2155872255u;
    uint _e191 = local_21;
    uint _e195 = (asuint(asfloat(_e191)) & 2147483647u);
    local_22 = ((_e195 > 2139095040u) ? 2143289344u : _e195);
    uint _e201 = local_22;
    local_20 = uint(int(11));
    uint _e207 = local_20;
    local_64 = uint(_e207);
    uint _e210 = local_64;
    out_.Store(_e210*4, asuint(asuint(asfloat(_e201))));
    uint _e215 = (asuint(3.4028235e38) & 2147483647u);
    local_24 = ((_e215 > 2139095040u) ? 2143289344u : _e215);
    uint _e221 = local_24;
    local_23 = uint(int(12));
    uint _e227 = local_23;
    local_65 = uint(_e227);
    uint _e230 = local_65;
    out_.Store(_e230*4, asuint(asuint(asfloat(_e221))));
    uint _e236 = (asuint(-(3.4028235e38)) & 2147483647u);
    local_26 = ((_e236 > 2139095040u) ? 2143289344u : _e236);
    uint _e242 = local_26;
    local_25 = uint(int(13));
    uint _e248 = local_25;
    local_66 = uint(_e248);
    uint _e251 = local_66;
    out_.Store(_e251*4, asuint(asuint(asfloat(_e242))));
    local_28 = 2139095040u;
    uint _e255 = local_28;
    uint _e259 = (asuint(asfloat(_e255)) & 2147483647u);
    local_29 = ((_e259 > 2139095040u) ? 2143289344u : _e259);
    uint _e265 = local_29;
    local_27 = uint(int(14));
    uint _e271 = local_27;
    local_67 = uint(_e271);
    uint _e274 = local_67;
    out_.Store(_e274*4, asuint(asuint(asfloat(_e265))));
    local_31 = 4286578688u;
    uint _e278 = local_31;
    uint _e282 = (asuint(asfloat(_e278)) & 2147483647u);
    local_32 = ((_e282 > 2139095040u) ? 2143289344u : _e282);
    uint _e288 = local_32;
    local_30 = uint(int(15));
    uint _e294 = local_30;
    local_68 = uint(_e294);
    uint _e297 = local_68;
    out_.Store(_e297*4, asuint(asuint(asfloat(_e288))));
    local_34 = 2143363909u;
    uint _e301 = local_34;
    uint _e305 = (asuint(asfloat(_e301)) & 2147483647u);
    local_35 = ((_e305 > 2139095040u) ? 2143289344u : _e305);
    uint _e311 = local_35;
    local_33 = uint(int(16));
    uint _e317 = local_33;
    local_69 = uint(_e317);
    uint _e320 = local_69;
    out_.Store(_e320*4, asuint(asuint(asfloat(_e311))));
    local_37 = 2139095041u;
    uint _e324 = local_37;
    uint _e328 = (asuint(asfloat(_e324)) & 2147483647u);
    local_38 = ((_e328 > 2139095040u) ? 2143289344u : _e328);
    uint _e334 = local_38;
    local_36 = uint(int(17));
    uint _e340 = local_36;
    local_70 = uint(_e340);
    uint _e343 = local_70;
    out_.Store(_e343*4, asuint(asuint(asfloat(_e334))));
    value = -(2.75);
    float _e348 = value;
    value = (_e348 + float(int(1)));
    uint _e354 = (asuint(_e348) & 2147483647u);
    local_40 = ((_e354 > 2139095040u) ? 2143289344u : _e354);
    uint _e360 = local_40;
    local_39 = uint(int(18));
    uint _e366 = local_39;
    local_71 = uint(_e366);
    uint _e369 = local_71;
    out_.Store(_e369*4, asuint(asuint(asfloat(_e360))));
    float _e371 = value;
    local_41 = uint(int(19));
    uint _e376 = local_41;
    local_72 = uint(_e376);
    uint _e379 = local_72;
    out_.Store(_e379*4, asuint(asuint(_e371)));
    const int _e383 = fabs_3(naga_neg(int(3)));
    local_42 = uint(int(20));
    uint _e388 = local_42;
    local_73 = uint(_e388);
    uint _e391 = local_73;
    out_.Store(_e391*4, asuint(uint(_e383)));
    const uint _e394 = fabs_4(3u);
    local_43 = uint(int(21));
    uint _e398 = local_43;
    local_74 = uint(_e398);
    uint _e401 = local_74;
    out_.Store(_e401*4, asuint(_e394));
    const int _e404 = fabs_5(true);
    local_44 = uint(int(22));
    uint _e409 = local_44;
    local_75 = uint(_e409);
    uint _e412 = local_75;
    out_.Store(_e412*4, asuint(uint(_e404)));
    const int _e415 = fabs_5(false);
    local_45 = uint(int(23));
    uint _e420 = local_45;
    local_76 = uint(_e420);
    uint _e423 = local_76;
    out_.Store(_e423*4, asuint(uint(_e415)));
    const int _e426 = fabsf(true);
    local_46 = uint(int(24));
    uint _e431 = local_46;
    local_77 = uint(_e431);
    uint _e434 = local_77;
    out_.Store(_e434*4, asuint(uint(_e426)));
    local_47 = 2147483649u;
    uint _e442 = local_47;
    const float3_ _e445 = fabs_1(Constructfloat3_(-(2.5), -(0.0), asfloat(_e442)));
    triple = _e445;
    float _e448 = triple.x;
    local_48 = uint(int(25));
    uint _e453 = local_48;
    local_78 = uint(_e453);
    uint _e456 = local_78;
    out_.Store(_e456*4, asuint(asuint(_e448)));
    float _e459 = triple.y;
    local_49 = uint(int(26));
    uint _e464 = local_49;
    local_79 = uint(_e464);
    uint _e467 = local_79;
    out_.Store(_e467*4, asuint(asuint(_e459)));
    float _e470 = triple.z;
    local_50 = uint(int(27));
    uint _e475 = local_50;
    local_80 = uint(_e475);
    uint _e478 = local_80;
    out_.Store(_e478*4, asuint(asuint(_e470)));
    const float _e483 = fabsf_1(-(2.0), 3.0);
    local_51 = uint(int(28));
    uint _e488 = local_51;
    local_81 = uint(_e488);
    uint _e491 = local_81;
    out_.Store(_e491*4, asuint(asuint(_e483)));
    const float2 _e498 = fabs(float2(-(3.0), -(4.0)));
    pair = _e498;
    const float4 _e509 = fabs_2(float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e509;
    float _e513 = pair.x;
    float _e514 = pair.y;
    float _e517 = quadruple.x;
    float _e520 = quadruple.w;
    local_52 = uint(int(29));
    uint _e526 = local_52;
    local_82 = uint(_e526);
    uint _e529 = local_82;
    out_.Store(_e529*4, asuint(asuint((((_e513 + _e514) + _e517) + _e520))));
}
