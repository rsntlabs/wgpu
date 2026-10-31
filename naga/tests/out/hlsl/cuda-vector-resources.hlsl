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
    float3_ local_43 = (float3_)0;
    float local_44 = (float)0;
    float local_45 = (float)0;
    float3_ local_46 = (float3_)0;
    float3_ local_47 = (float3_)0;
    uint local_48 = (uint)0;
    float3_ local_49 = (float3_)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    float3_ local_52 = (float3_)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    float3_ local_55 = (float3_)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    float local_63 = (float)0;
    uint local_64 = (uint)0;
    float local_65 = (float)0;
    uint local_66 = (uint)0;
    float local_67 = (float)0;
    uint local_68 = (uint)0;
    float local_69 = (float)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    float3_ local_73 = (float3_)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    float local_76 = (float)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    float local_79 = (float)0;
    uint local_80 = (uint)0;
    float3_ local_81 = (float3_)0;
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
    float3_ local_92 = (float3_)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;

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
            uint _e8 = local;
            local_48 = uint(_e8);
            uint _e11 = local_48;
            float3_ _e14 = Constructfloat3_(asfloat(input.Load(_e11*12+0)), asfloat(input.Load(_e11*12+4)), asfloat(input.Load(_e11*12+8)));
            local_49 = _e14;
            float3_ _e16 = local_49;
            local_36 = _e16;
            float3_ _e18 = local_36;
            copied = _e18;
            float3_ _e20 = copied;
            const float3_ _e21 = shift(_e20);
            int _e22 = i;
            local_1 = uint(_e22);
            uint _e25 = local_1;
            local_50 = uint(_e25);
            uint _e28 = local_50;
            {
                float3_ _value4 = _e21;
                output.Store(_e28*12+0, asuint(_value4.x));
                output.Store(_e28*12+4, asuint(_value4.y));
                output.Store(_e28*12+8, asuint(_value4.z));
            }
        }
    }
    local_3 = uint(int(0));
    uint _e37 = local_3;
    local_51 = uint(_e37);
    uint _e40 = local_51;
    float3_ _e43 = Constructfloat3_(asfloat(input.Load(_e40*12+0)), asfloat(input.Load(_e40*12+4)), asfloat(input.Load(_e40*12+8)));
    local_52 = _e43;
    float3_ _e45 = local_52;
    local_37 = _e45;
    float3_ _e47 = local_37;
    local_2 = uint(int(3));
    uint _e51 = local_2;
    local_53 = uint(_e51);
    uint _e54 = local_53;
    {
        float3_ _value2 = _e47;
        output.Store(_e54*12+0, asuint(_value2.x));
        output.Store(_e54*12+4, asuint(_value2.y));
        output.Store(_e54*12+8, asuint(_value2.z));
    }
    local_5 = uint(int(1));
    uint _e60 = local_5;
    local_54 = uint(_e60);
    uint _e63 = local_54;
    float3_ _e65 = Constructfloat3_(asfloat(input.Load(_e63*12+0)), asfloat(input.Load(_e63*12+4)), asfloat(input.Load(_e63*12+8)));
    local_55 = _e65;
    float3_ _e67 = local_55;
    local_38 = _e67;
    float3_ _e69 = local_38;
    const float3_ _e70 = shift(_e69);
    local_4 = uint(int(3));
    uint _e75 = local_4;
    local_56 = uint(_e75);
    uint _e78 = local_56;
    output.Store(4+_e78*12, asuint(_e70.x));
    index = int(0);
    index = int(1);
    local_7 = uint(int(2));
    uint _e87 = local_7;
    local_57 = uint(_e87);
    uint _e90 = local_57;
    float _e93 = asfloat(input.Load(0+_e90*12));
    int _e94 = index;
    index = asint(asuint(_e94) + asuint(int(1)));
    local_6 = uint(_e94);
    uint _e99 = local_6;
    local_58 = uint(_e99);
    uint _e102 = local_58;
    output.Store(0+_e102*12, asuint(_e93));
    int _e105 = index;
    local_9 = uint(int(0));
    uint _e109 = local_9;
    local_59 = uint(_e109);
    uint _e112 = local_59;
    float _e115 = asfloat(input.Load(0+_e112*12));
    local_10 = uint(int(1));
    uint _e119 = local_10;
    local_60 = uint(_e119);
    uint _e122 = local_60;
    float _e125 = asfloat(input.Load(0+_e122*12));
    local_8 = uint(int(4));
    uint _e131 = local_8;
    local_61 = uint(_e131);
    uint _e134 = local_61;
    {
        float3_ _value2 = Constructfloat3_(float(_e105), _e115, _e125);
        output.Store(_e134*12+0, asuint(_value2.x));
        output.Store(_e134*12+4, asuint(_value2.y));
        output.Store(_e134*12+8, asuint(_value2.z));
    }
    choose_first = true;
    bool _e138 = choose_first;
    if (_e138) {
        local_11 = uint(int(0));
        uint _e142 = local_11;
        local_62 = uint(_e142);
        uint _e145 = local_62;
        float _e148 = asfloat(output.Load(4+_e145*12));
        local_63 = _e148;
        float _e150 = local_63;
        local_39 = _e150;
        float _e152 = local_39;
        uint _e155 = local_62;
        output.Store(4+_e155*12, asuint((_e152 + 2.0)));
    } else {
        local_12 = uint(int(2));
        uint _e161 = local_12;
        local_64 = uint(_e161);
        uint _e164 = local_64;
        float _e167 = asfloat(output.Load(4+_e164*12));
        local_65 = _e167;
        float _e169 = local_65;
        local_40 = _e169;
        float _e171 = local_40;
        uint _e174 = local_64;
        output.Store(4+_e174*12, asuint((_e171 + 2.0)));
    }
    bool _e177 = choose_first;
    if (_e177) {
        local_14 = uint(int(0));
        uint _e181 = local_14;
        local_66 = uint(_e181);
        uint _e184 = local_66;
        float _e187 = asfloat(output.Load(8+_e184*12));
        local_67 = _e187;
        float _e189 = local_67;
        local_41 = _e189;
        float _e191 = local_41;
        uint _e195 = local_66;
        output.Store(8+_e195*12, asuint((_e191 + float(int(1)))));
        local_16 = _e191;
    } else {
        local_15 = uint(int(2));
        uint _e202 = local_15;
        local_68 = uint(_e202);
        uint _e205 = local_68;
        float _e208 = asfloat(output.Load(8+_e205*12));
        local_69 = _e208;
        float _e210 = local_69;
        local_42 = _e210;
        float _e212 = local_42;
        uint _e216 = local_68;
        output.Store(8+_e216*12, asuint((_e212 + float(int(1)))));
        local_16 = _e212;
    }
    float _e221 = local_16;
    local_13 = uint(int(4));
    uint _e225 = local_13;
    local_70 = uint(_e225);
    uint _e228 = local_70;
    output.Store(0+_e228*12, asuint(_e221));
    int _e231 = index;
    local_17 = uint(int(4));
    uint _e236 = local_17;
    local_71 = uint(_e236);
    uint _e239 = local_71;
    output.Store(8+_e239*12, asuint(float(_e231)));
    local_20 = uint(int(1));
    uint _e245 = local_20;
    local_72 = uint(_e245);
    uint _e248 = local_72;
    float3_ _e250 = Constructfloat3_(asfloat(input.Load(_e248*12+0)), asfloat(input.Load(_e248*12+4)), asfloat(input.Load(_e248*12+8)));
    local_73 = _e250;
    float3_ _e252 = local_73;
    local_43 = _e252;
    float3_ _e254 = local_43;
    bool _e255 = choose_first;
    if (_e255) {
        local_18 = uint(int(0));
        uint _e259 = local_18;
        local_74 = uint(_e259);
        uint _e262 = local_74;
        {
            float3_ _value3 = _e254;
            output.Store(_e262*12+0, asuint(_value3.x));
            output.Store(_e262*12+4, asuint(_value3.y));
            output.Store(_e262*12+8, asuint(_value3.z));
        }
        uint _e264 = local_18;
        local_75 = uint(_e264);
        uint _e267 = local_75;
        float _e270 = asfloat(output.Load(0+_e267*12));
        local_76 = _e270;
        float _e272 = local_76;
        local_44 = _e272;
        float _e274 = local_44;
        uint _e278 = local_75;
        output.Store(0+_e278*12, asuint((_e274 + float(int(1)))));
        local_21 = _e274;
    } else {
        local_19 = uint(int(2));
        uint _e285 = local_19;
        local_77 = uint(_e285);
        uint _e288 = local_77;
        {
            float3_ _value3 = _e254;
            output.Store(_e288*12+0, asuint(_value3.x));
            output.Store(_e288*12+4, asuint(_value3.y));
            output.Store(_e288*12+8, asuint(_value3.z));
        }
        uint _e290 = local_19;
        local_78 = uint(_e290);
        uint _e293 = local_78;
        float _e296 = asfloat(output.Load(0+_e293*12));
        local_79 = _e296;
        float _e298 = local_79;
        local_45 = _e298;
        float _e300 = local_45;
        uint _e304 = local_78;
        output.Store(0+_e304*12, asuint((_e300 + float(int(1)))));
        local_21 = _e300;
    }
    local_23 = uint(int(0));
    uint _e311 = local_23;
    local_80 = uint(_e311);
    uint _e314 = local_80;
    float3_ _e316 = Constructfloat3_(asfloat(output.Load(_e314*12+0)), asfloat(output.Load(_e314*12+4)), asfloat(output.Load(_e314*12+8)));
    local_81 = _e316;
    float3_ _e318 = local_81;
    local_46 = _e318;
    float3_ _e320 = local_46;
    local_22 = uint(int(5));
    uint _e324 = local_22;
    local_82 = uint(_e324);
    uint _e327 = local_82;
    {
        float3_ _value2 = _e320;
        output.Store(_e327*12+0, asuint(_value2.x));
        output.Store(_e327*12+4, asuint(_value2.y));
        output.Store(_e327*12+8, asuint(_value2.z));
    }
    local_24 = Constructfloat3_(float(int(20)), float(int(30)), float(int(40)));
    pick_local = false;
    pick_local = true;
    bool _e340 = pick_local;
    if (_e340) {
        local_24.z = 7.0;
    } else {
        local_25 = uint(int(1));
        uint _e346 = local_25;
        local_83 = uint(_e346);
        uint _e349 = local_83;
        output.Store(8+_e349*12, asuint(7.0));
    }
    float3_ _e353 = local_24;
    local_26 = uint(int(6));
    uint _e357 = local_26;
    local_84 = uint(_e357);
    uint _e360 = local_84;
    {
        float3_ _value2 = _e353;
        output.Store(_e360*12+0, asuint(_value2.x));
        output.Store(_e360*12+4, asuint(_value2.y));
        output.Store(_e360*12+8, asuint(_value2.z));
    }
    local_28 = uint(int(1));
    uint _e365 = local_28;
    local_85 = uint(_e365);
    uint _e368 = local_85;
    float _e371 = asfloat(output.Load(8+_e368*12));
    local_27 = uint(int(6));
    uint _e375 = local_27;
    local_86 = uint(_e375);
    uint _e378 = local_86;
    output.Store(0+_e378*12, asuint(_e371));
    local_30 = uint(int(0));
    uint _e384 = local_30;
    local_87 = uint(_e384);
    uint _e387 = local_87;
    float _e390 = asfloat(output.Load(0+_e387*12));
    local_31 = uint(int(1));
    uint _e394 = local_31;
    local_88 = uint(_e394);
    uint _e397 = local_88;
    float _e400 = asfloat(output.Load(0+_e397*12));
    local_32 = uint(int(2));
    uint _e404 = local_32;
    local_89 = uint(_e404);
    uint _e407 = local_89;
    float _e410 = asfloat(output.Load(0+_e407*12));
    local_29 = uint(int(7));
    uint _e415 = local_29;
    local_90 = uint(_e415);
    uint _e418 = local_90;
    {
        float3_ _value2 = Constructfloat3_(_e390, _e400, _e410);
        output.Store(_e418*12+0, asuint(_value2.x));
        output.Store(_e418*12+4, asuint(_value2.y));
        output.Store(_e418*12+8, asuint(_value2.z));
    }
    local_33 = uint(int(0));
    uint _e423 = local_33;
    local_91 = uint(_e423);
    uint _e426 = local_91;
    float3_ _e428 = Constructfloat3_(asfloat(input.Load(_e426*12+0)), asfloat(input.Load(_e426*12+4)), asfloat(input.Load(_e426*12+8)));
    local_92 = _e428;
    float3_ _e430 = local_92;
    local_47 = _e430;
    float3_ _e432 = local_47;
    snapshot = _e432;
    float3_ _e434 = snapshot;
    snapshot.x = 9.0;
    const float _e438 = pair(_e434, int(4));
    float _e440 = snapshot.x;
    local_35 = uint(int(2));
    uint _e444 = local_35;
    local_93 = uint(_e444);
    uint _e447 = local_93;
    float _e450 = asfloat(input.Load(8+_e447*12));
    local_34 = uint(int(8));
    uint _e455 = local_34;
    local_94 = uint(_e455);
    uint _e458 = local_94;
    {
        float3_ _value2 = Constructfloat3_(_e438, _e440, _e450);
        output.Store(_e458*12+0, asuint(_value2.x));
        output.Store(_e458*12+4, asuint(_value2.y));
        output.Store(_e458*12+8, asuint(_value2.z));
    }
}
