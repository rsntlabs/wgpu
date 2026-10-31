struct float3_ {
    float x;
    float y;
    float z;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

float3_ shift(float3_ value)
{
    float3_ value_1 = (float3_)0;

    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = (_e4 + 1.0);
    float _e9 = value_1.y;
    float _e10 = value_1.z;
    value_1.z = (_e9 + _e10);
    float3_ _e12 = value_1;
    const float3_ float3_1 = _e12;
    return float3_1;
}

float pair(float3_ value_2, int digit)
{
    float3_ value_3 = (float3_)0;

    value_3 = value_2;
    float _e4 = value_3.x;
    return ((_e4 * 10.0) + float(digit));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(1, 1, 1)]
void vector_resources()
{
    int i = (int)0;
    float3_ copied = (float3_)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int index = (int)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    bool choose_first = (bool)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    float local_16 = (float)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    float local_21 = (float)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    float3_ local_24 = (float3_)0;
    bool pick_local = (bool)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    float3_ snapshot = (float3_)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    float3_ local_36 = (float3_)0;
    float3_ local_37 = (float3_)0;
    float3_ local_38 = (float3_)0;
    float local_39 = (float)0;
    float local_40 = (float)0;
    float local_41 = (float)0;
    float local_42 = (float)0;
    float local_43 = (float)0;
    float local_44 = (float)0;
    float local_45 = (float)0;
    float3_ local_46 = (float3_)0;
    float local_47 = (float)0;
    float local_48 = (float)0;
    float3_ local_49 = (float3_)0;
    float local_50 = (float)0;
    float local_51 = (float)0;
    float local_52 = (float)0;
    float local_53 = (float)0;
    float3_ local_54 = (float3_)0;
    float local_55 = (float)0;
    uint local_56 = (uint)0;
    float3_ local_57 = (float3_)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    float3_ local_60 = (float3_)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    float3_ local_63 = (float3_)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    float local_66 = (float)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    float local_69 = (float)0;
    uint local_70 = (uint)0;
    float local_71 = (float)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    float local_74 = (float)0;
    uint local_75 = (uint)0;
    float local_76 = (float)0;
    uint local_77 = (uint)0;
    float local_78 = (float)0;
    uint local_79 = (uint)0;
    float local_80 = (float)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    float3_ local_84 = (float3_)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    float local_87 = (float)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    float local_90 = (float)0;
    uint local_91 = (uint)0;
    float3_ local_92 = (float3_)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    float local_97 = (float)0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    float local_100 = (float)0;
    uint local_101 = (uint)0;
    float local_102 = (float)0;
    uint local_103 = (uint)0;
    float local_104 = (float)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    float3_ local_107 = (float3_)0;
    uint local_108 = (uint)0;
    float local_109 = (float)0;
    uint local_110 = (uint)0;

    {
        i = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e31 = i;
                i = asint(asuint(_e31) + asuint(int(1)));
            }
            loop_init = false;
            int _e2 = i;
            if ((_e2 < int(3))) {
            } else {
                break;
            }
            int _e5 = i;
            local = uint(_e5);
            uint _e9 = local;
            local_56 = uint(_e9);
            uint _e13 = local_56;
            float3_ _e15 = Constructfloat3_(asfloat(input.Load(_e13*12+0)), asfloat(input.Load(_e13*12+4)), asfloat(input.Load(_e13*12+8)));
            local_57 = _e15;
            float3_ _e16 = local_57;
            local_36 = _e16;
            float3_ _e18 = local_36;
            copied = _e18;
            float3_ _e20 = copied;
            const float3_ _e21 = shift(_e20);
            int _e22 = i;
            local_1 = uint(_e22);
            uint _e26 = local_1;
            local_58 = uint(_e26);
            uint _e29 = local_58;
            {
                float3_ _value4 = _e21;
                output.Store(_e29*12+0, asuint(_value4.x));
                output.Store(_e29*12+4, asuint(_value4.y));
                output.Store(_e29*12+8, asuint(_value4.z));
            }
        }
    }
    local_3 = uint(int(0));
    uint _e38 = local_3;
    local_59 = uint(_e38);
    uint _e42 = local_59;
    float3_ _e44 = Constructfloat3_(asfloat(input.Load(_e42*12+0)), asfloat(input.Load(_e42*12+4)), asfloat(input.Load(_e42*12+8)));
    local_60 = _e44;
    float3_ _e45 = local_60;
    local_37 = _e45;
    float3_ _e47 = local_37;
    local_2 = uint(int(3));
    uint _e52 = local_2;
    local_61 = uint(_e52);
    uint _e55 = local_61;
    {
        float3_ _value2 = _e47;
        output.Store(_e55*12+0, asuint(_value2.x));
        output.Store(_e55*12+4, asuint(_value2.y));
        output.Store(_e55*12+8, asuint(_value2.z));
    }
    local_5 = uint(int(1));
    uint _e60 = local_5;
    local_62 = uint(_e60);
    uint _e64 = local_62;
    float3_ _e66 = Constructfloat3_(asfloat(input.Load(_e64*12+0)), asfloat(input.Load(_e64*12+4)), asfloat(input.Load(_e64*12+8)));
    local_63 = _e66;
    float3_ _e67 = local_63;
    local_38 = _e67;
    float3_ _e69 = local_38;
    const float3_ _e70 = shift(_e69);
    local_4 = uint(int(3));
    uint _e75 = local_4;
    local_64 = uint(_e75);
    uint _e78 = local_64;
    output.Store(4+_e78*12, asuint(_e70.x));
    index = int(0);
    index = int(1);
    local_7 = uint(int(2));
    uint _e87 = local_7;
    local_65 = uint(_e87);
    uint _e91 = local_65;
    float _e94 = asfloat(input.Load(0+_e91*12));
    local_66 = _e94;
    float _e95 = local_66;
    local_39 = _e95;
    float _e97 = local_39;
    int _e98 = index;
    index = asint(asuint(_e98) + asuint(int(1)));
    local_6 = uint(_e98);
    uint _e103 = local_6;
    local_67 = uint(_e103);
    uint _e106 = local_67;
    output.Store(0+_e106*12, asuint(_e97));
    int _e109 = index;
    local_9 = uint(int(0));
    uint _e113 = local_9;
    local_68 = uint(_e113);
    uint _e117 = local_68;
    float _e120 = asfloat(input.Load(0+_e117*12));
    local_69 = _e120;
    float _e121 = local_69;
    local_40 = _e121;
    float _e123 = local_40;
    local_10 = uint(int(1));
    uint _e127 = local_10;
    local_70 = uint(_e127);
    uint _e131 = local_70;
    float _e134 = asfloat(input.Load(0+_e131*12));
    local_71 = _e134;
    float _e135 = local_71;
    local_41 = _e135;
    float _e137 = local_41;
    local_8 = uint(int(4));
    uint _e143 = local_8;
    local_72 = uint(_e143);
    uint _e146 = local_72;
    {
        float3_ _value2 = Constructfloat3_(float(_e109), _e123, _e137);
        output.Store(_e146*12+0, asuint(_value2.x));
        output.Store(_e146*12+4, asuint(_value2.y));
        output.Store(_e146*12+8, asuint(_value2.z));
    }
    choose_first = true;
    bool _e150 = choose_first;
    if (_e150) {
        local_11 = uint(int(0));
        uint _e154 = local_11;
        local_73 = uint(_e154);
        uint _e158 = local_73;
        float _e161 = asfloat(output.Load(4+_e158*12));
        local_74 = _e161;
        float _e162 = local_74;
        local_42 = _e162;
        float _e164 = local_42;
        uint _e167 = local_73;
        output.Store(4+_e167*12, asuint((_e164 + 2.0)));
    } else {
        local_12 = uint(int(2));
        uint _e173 = local_12;
        local_75 = uint(_e173);
        uint _e177 = local_75;
        float _e180 = asfloat(output.Load(4+_e177*12));
        local_76 = _e180;
        float _e181 = local_76;
        local_43 = _e181;
        float _e183 = local_43;
        uint _e186 = local_75;
        output.Store(4+_e186*12, asuint((_e183 + 2.0)));
    }
    bool _e189 = choose_first;
    if (_e189) {
        local_14 = uint(int(0));
        uint _e193 = local_14;
        local_77 = uint(_e193);
        uint _e197 = local_77;
        float _e200 = asfloat(output.Load(8+_e197*12));
        local_78 = _e200;
        float _e201 = local_78;
        local_44 = _e201;
        float _e203 = local_44;
        uint _e207 = local_77;
        output.Store(8+_e207*12, asuint((_e203 + float(int(1)))));
        local_16 = _e203;
    } else {
        local_15 = uint(int(2));
        uint _e214 = local_15;
        local_79 = uint(_e214);
        uint _e218 = local_79;
        float _e221 = asfloat(output.Load(8+_e218*12));
        local_80 = _e221;
        float _e222 = local_80;
        local_45 = _e222;
        float _e224 = local_45;
        uint _e228 = local_79;
        output.Store(8+_e228*12, asuint((_e224 + float(int(1)))));
        local_16 = _e224;
    }
    float _e233 = local_16;
    local_13 = uint(int(4));
    uint _e237 = local_13;
    local_81 = uint(_e237);
    uint _e240 = local_81;
    output.Store(0+_e240*12, asuint(_e233));
    int _e243 = index;
    local_17 = uint(int(4));
    uint _e248 = local_17;
    local_82 = uint(_e248);
    uint _e251 = local_82;
    output.Store(8+_e251*12, asuint(float(_e243)));
    local_20 = uint(int(1));
    uint _e257 = local_20;
    local_83 = uint(_e257);
    uint _e261 = local_83;
    float3_ _e263 = Constructfloat3_(asfloat(input.Load(_e261*12+0)), asfloat(input.Load(_e261*12+4)), asfloat(input.Load(_e261*12+8)));
    local_84 = _e263;
    float3_ _e264 = local_84;
    local_46 = _e264;
    float3_ _e266 = local_46;
    bool _e267 = choose_first;
    if (_e267) {
        local_18 = uint(int(0));
        uint _e271 = local_18;
        local_85 = uint(_e271);
        uint _e274 = local_85;
        {
            float3_ _value3 = _e266;
            output.Store(_e274*12+0, asuint(_value3.x));
            output.Store(_e274*12+4, asuint(_value3.y));
            output.Store(_e274*12+8, asuint(_value3.z));
        }
        uint _e276 = local_18;
        local_86 = uint(_e276);
        uint _e280 = local_86;
        float _e283 = asfloat(output.Load(0+_e280*12));
        local_87 = _e283;
        float _e284 = local_87;
        local_47 = _e284;
        float _e286 = local_47;
        uint _e290 = local_86;
        output.Store(0+_e290*12, asuint((_e286 + float(int(1)))));
        local_21 = _e286;
    } else {
        local_19 = uint(int(2));
        uint _e297 = local_19;
        local_88 = uint(_e297);
        uint _e300 = local_88;
        {
            float3_ _value3 = _e266;
            output.Store(_e300*12+0, asuint(_value3.x));
            output.Store(_e300*12+4, asuint(_value3.y));
            output.Store(_e300*12+8, asuint(_value3.z));
        }
        uint _e302 = local_19;
        local_89 = uint(_e302);
        uint _e306 = local_89;
        float _e309 = asfloat(output.Load(0+_e306*12));
        local_90 = _e309;
        float _e310 = local_90;
        local_48 = _e310;
        float _e312 = local_48;
        uint _e316 = local_89;
        output.Store(0+_e316*12, asuint((_e312 + float(int(1)))));
        local_21 = _e312;
    }
    local_23 = uint(int(0));
    uint _e323 = local_23;
    local_91 = uint(_e323);
    uint _e327 = local_91;
    float3_ _e329 = Constructfloat3_(asfloat(output.Load(_e327*12+0)), asfloat(output.Load(_e327*12+4)), asfloat(output.Load(_e327*12+8)));
    local_92 = _e329;
    float3_ _e330 = local_92;
    local_49 = _e330;
    float3_ _e332 = local_49;
    local_22 = uint(int(5));
    uint _e336 = local_22;
    local_93 = uint(_e336);
    uint _e339 = local_93;
    {
        float3_ _value2 = _e332;
        output.Store(_e339*12+0, asuint(_value2.x));
        output.Store(_e339*12+4, asuint(_value2.y));
        output.Store(_e339*12+8, asuint(_value2.z));
    }
    local_24 = Constructfloat3_(float(int(20)), float(int(30)), float(int(40)));
    pick_local = false;
    pick_local = true;
    bool _e352 = pick_local;
    if (_e352) {
        local_24.z = 7.0;
    } else {
        local_25 = uint(int(1));
        uint _e358 = local_25;
        local_94 = uint(_e358);
        uint _e362 = local_94;
        output.Store(8+_e362*12, asuint(7.0));
    }
    float3_ _e365 = local_24;
    local_26 = uint(int(6));
    uint _e369 = local_26;
    local_95 = uint(_e369);
    uint _e372 = local_95;
    {
        float3_ _value2 = _e365;
        output.Store(_e372*12+0, asuint(_value2.x));
        output.Store(_e372*12+4, asuint(_value2.y));
        output.Store(_e372*12+8, asuint(_value2.z));
    }
    local_28 = uint(int(1));
    uint _e377 = local_28;
    local_96 = uint(_e377);
    uint _e381 = local_96;
    float _e384 = asfloat(output.Load(8+_e381*12));
    local_97 = _e384;
    float _e385 = local_97;
    local_50 = _e385;
    float _e387 = local_50;
    local_27 = uint(int(6));
    uint _e391 = local_27;
    local_98 = uint(_e391);
    uint _e394 = local_98;
    output.Store(0+_e394*12, asuint(_e387));
    local_30 = uint(int(0));
    uint _e400 = local_30;
    local_99 = uint(_e400);
    uint _e404 = local_99;
    float _e407 = asfloat(output.Load(0+_e404*12));
    local_100 = _e407;
    float _e408 = local_100;
    local_51 = _e408;
    float _e410 = local_51;
    local_31 = uint(int(1));
    uint _e414 = local_31;
    local_101 = uint(_e414);
    uint _e418 = local_101;
    float _e421 = asfloat(output.Load(0+_e418*12));
    local_102 = _e421;
    float _e422 = local_102;
    local_52 = _e422;
    float _e424 = local_52;
    local_32 = uint(int(2));
    uint _e428 = local_32;
    local_103 = uint(_e428);
    uint _e432 = local_103;
    float _e435 = asfloat(output.Load(0+_e432*12));
    local_104 = _e435;
    float _e436 = local_104;
    local_53 = _e436;
    float _e438 = local_53;
    local_29 = uint(int(7));
    uint _e443 = local_29;
    local_105 = uint(_e443);
    uint _e446 = local_105;
    {
        float3_ _value2 = Constructfloat3_(_e410, _e424, _e438);
        output.Store(_e446*12+0, asuint(_value2.x));
        output.Store(_e446*12+4, asuint(_value2.y));
        output.Store(_e446*12+8, asuint(_value2.z));
    }
    local_33 = uint(int(0));
    uint _e451 = local_33;
    local_106 = uint(_e451);
    uint _e455 = local_106;
    float3_ _e457 = Constructfloat3_(asfloat(input.Load(_e455*12+0)), asfloat(input.Load(_e455*12+4)), asfloat(input.Load(_e455*12+8)));
    local_107 = _e457;
    float3_ _e458 = local_107;
    local_54 = _e458;
    float3_ _e460 = local_54;
    snapshot = _e460;
    float3_ _e462 = snapshot;
    snapshot.x = 9.0;
    const float _e466 = pair(_e462, int(4));
    float _e468 = snapshot.x;
    local_35 = uint(int(2));
    uint _e472 = local_35;
    local_108 = uint(_e472);
    uint _e476 = local_108;
    float _e479 = asfloat(input.Load(8+_e476*12));
    local_109 = _e479;
    float _e480 = local_109;
    local_55 = _e480;
    float _e482 = local_55;
    local_34 = uint(int(8));
    uint _e487 = local_34;
    local_110 = uint(_e487);
    uint _e490 = local_110;
    {
        float3_ _value2 = Constructfloat3_(_e466, _e468, _e482);
        output.Store(_e490*12+0, asuint(_value2.x));
        output.Store(_e490*12+4, asuint(_value2.y));
        output.Store(_e490*12+8, asuint(_value2.z));
    }
}
