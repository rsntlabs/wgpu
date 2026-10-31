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
    float3_ local_51 = (float3_)0;
    float3_ local_52 = (float3_)0;
    uint local_53 = (uint)0;
    float local_54 = (float)0;
    uint local_55 = (uint)0;
    float local_56 = (float)0;
    uint local_57 = (uint)0;
    float local_58 = (float)0;
    uint local_59 = (uint)0;
    float local_60 = (float)0;
    float3_ local_61 = (float3_)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    float local_64 = (float)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    float local_67 = (float)0;
    float3_ local_68 = (float3_)0;
    uint local_69 = (uint)0;
    float3_ local_70 = (float3_)0;

    {
        i = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e29 = i;
                i = asint(asuint(_e29) + asuint(int(1)));
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
            local_48 = _e8;
            uint _e10 = local_48;
            float3_ _e13 = Constructfloat3_(asfloat(input.Load(_e10*12+0)), asfloat(input.Load(_e10*12+4)), asfloat(input.Load(_e10*12+8)));
            local_49 = _e13;
            float3_ _e15 = local_49;
            local_36 = _e15;
            float3_ _e17 = local_36;
            copied = _e17;
            float3_ _e19 = copied;
            const float3_ _e20 = shift(_e19);
            int _e21 = i;
            local_1 = uint(_e21);
            uint _e24 = local_1;
            local_50 = _e24;
            uint _e26 = local_50;
            {
                float3_ _value4 = _e20;
                output.Store(_e26*12+0, asuint(_value4.x));
                output.Store(_e26*12+4, asuint(_value4.y));
                output.Store(_e26*12+8, asuint(_value4.z));
            }
        }
    }
    local_3 = uint(int(0));
    uint _e35 = local_3;
    float3_ _e38 = Constructfloat3_(asfloat(input.Load(_e35*12+0)), asfloat(input.Load(_e35*12+4)), asfloat(input.Load(_e35*12+8)));
    local_51 = _e38;
    float3_ _e40 = local_51;
    local_37 = _e40;
    float3_ _e42 = local_37;
    local_2 = uint(int(3));
    uint _e46 = local_2;
    {
        float3_ _value2 = _e42;
        output.Store(_e46*12+0, asuint(_value2.x));
        output.Store(_e46*12+4, asuint(_value2.y));
        output.Store(_e46*12+8, asuint(_value2.z));
    }
    local_5 = uint(int(1));
    uint _e52 = local_5;
    float3_ _e54 = Constructfloat3_(asfloat(input.Load(_e52*12+0)), asfloat(input.Load(_e52*12+4)), asfloat(input.Load(_e52*12+8)));
    local_52 = _e54;
    float3_ _e56 = local_52;
    local_38 = _e56;
    float3_ _e58 = local_38;
    const float3_ _e59 = shift(_e58);
    local_4 = uint(int(3));
    uint _e64 = local_4;
    output.Store(4+_e64*12, asuint(_e59.x));
    index = int(0);
    index = int(1);
    local_7 = uint(int(2));
    uint _e73 = local_7;
    float _e76 = asfloat(input.Load(0+_e73*12));
    int _e77 = index;
    index = asint(asuint(_e77) + asuint(int(1)));
    local_6 = uint(_e77);
    uint _e82 = local_6;
    output.Store(0+_e82*12, asuint(_e76));
    int _e85 = index;
    local_9 = uint(int(0));
    uint _e89 = local_9;
    float _e92 = asfloat(input.Load(0+_e89*12));
    local_10 = uint(int(1));
    uint _e96 = local_10;
    float _e99 = asfloat(input.Load(0+_e96*12));
    local_8 = uint(int(4));
    uint _e105 = local_8;
    {
        float3_ _value2 = Constructfloat3_(float(_e85), _e92, _e99);
        output.Store(_e105*12+0, asuint(_value2.x));
        output.Store(_e105*12+4, asuint(_value2.y));
        output.Store(_e105*12+8, asuint(_value2.z));
    }
    choose_first = true;
    bool _e109 = choose_first;
    if (_e109) {
        local_11 = uint(int(0));
        uint _e113 = local_11;
        local_53 = _e113;
        uint _e115 = local_53;
        float _e118 = asfloat(output.Load(4+_e115*12));
        local_54 = _e118;
        float _e120 = local_54;
        local_39 = _e120;
        float _e122 = local_39;
        uint _e125 = local_53;
        output.Store(4+_e125*12, asuint((_e122 + 2.0)));
    } else {
        local_12 = uint(int(2));
        uint _e131 = local_12;
        local_55 = _e131;
        uint _e133 = local_55;
        float _e136 = asfloat(output.Load(4+_e133*12));
        local_56 = _e136;
        float _e138 = local_56;
        local_40 = _e138;
        float _e140 = local_40;
        uint _e143 = local_55;
        output.Store(4+_e143*12, asuint((_e140 + 2.0)));
    }
    bool _e146 = choose_first;
    if (_e146) {
        local_14 = uint(int(0));
        uint _e150 = local_14;
        local_57 = _e150;
        uint _e152 = local_57;
        float _e155 = asfloat(output.Load(8+_e152*12));
        local_58 = _e155;
        float _e157 = local_58;
        local_41 = _e157;
        float _e159 = local_41;
        uint _e163 = local_57;
        output.Store(8+_e163*12, asuint((_e159 + float(int(1)))));
        local_16 = _e159;
    } else {
        local_15 = uint(int(2));
        uint _e170 = local_15;
        local_59 = _e170;
        uint _e172 = local_59;
        float _e175 = asfloat(output.Load(8+_e172*12));
        local_60 = _e175;
        float _e177 = local_60;
        local_42 = _e177;
        float _e179 = local_42;
        uint _e183 = local_59;
        output.Store(8+_e183*12, asuint((_e179 + float(int(1)))));
        local_16 = _e179;
    }
    float _e188 = local_16;
    local_13 = uint(int(4));
    uint _e192 = local_13;
    output.Store(0+_e192*12, asuint(_e188));
    int _e195 = index;
    local_17 = uint(int(4));
    uint _e200 = local_17;
    output.Store(8+_e200*12, asuint(float(_e195)));
    local_20 = uint(int(1));
    uint _e206 = local_20;
    float3_ _e208 = Constructfloat3_(asfloat(input.Load(_e206*12+0)), asfloat(input.Load(_e206*12+4)), asfloat(input.Load(_e206*12+8)));
    local_61 = _e208;
    float3_ _e210 = local_61;
    local_43 = _e210;
    float3_ _e212 = local_43;
    bool _e213 = choose_first;
    if (_e213) {
        local_18 = uint(int(0));
        uint _e217 = local_18;
        local_62 = _e217;
        uint _e219 = local_62;
        {
            float3_ _value3 = _e212;
            output.Store(_e219*12+0, asuint(_value3.x));
            output.Store(_e219*12+4, asuint(_value3.y));
            output.Store(_e219*12+8, asuint(_value3.z));
        }
        uint _e221 = local_18;
        local_63 = _e221;
        uint _e223 = local_63;
        float _e226 = asfloat(output.Load(0+_e223*12));
        local_64 = _e226;
        float _e228 = local_64;
        local_44 = _e228;
        float _e230 = local_44;
        uint _e234 = local_63;
        output.Store(0+_e234*12, asuint((_e230 + float(int(1)))));
        local_21 = _e230;
    } else {
        local_19 = uint(int(2));
        uint _e241 = local_19;
        local_65 = _e241;
        uint _e243 = local_65;
        {
            float3_ _value3 = _e212;
            output.Store(_e243*12+0, asuint(_value3.x));
            output.Store(_e243*12+4, asuint(_value3.y));
            output.Store(_e243*12+8, asuint(_value3.z));
        }
        uint _e245 = local_19;
        local_66 = _e245;
        uint _e247 = local_66;
        float _e250 = asfloat(output.Load(0+_e247*12));
        local_67 = _e250;
        float _e252 = local_67;
        local_45 = _e252;
        float _e254 = local_45;
        uint _e258 = local_66;
        output.Store(0+_e258*12, asuint((_e254 + float(int(1)))));
        local_21 = _e254;
    }
    local_23 = uint(int(0));
    uint _e265 = local_23;
    float3_ _e267 = Constructfloat3_(asfloat(output.Load(_e265*12+0)), asfloat(output.Load(_e265*12+4)), asfloat(output.Load(_e265*12+8)));
    local_68 = _e267;
    float3_ _e269 = local_68;
    local_46 = _e269;
    float3_ _e271 = local_46;
    local_22 = uint(int(5));
    uint _e275 = local_22;
    {
        float3_ _value2 = _e271;
        output.Store(_e275*12+0, asuint(_value2.x));
        output.Store(_e275*12+4, asuint(_value2.y));
        output.Store(_e275*12+8, asuint(_value2.z));
    }
    local_24 = Constructfloat3_(float(int(20)), float(int(30)), float(int(40)));
    pick_local = false;
    pick_local = true;
    bool _e288 = pick_local;
    if (_e288) {
        local_24.z = 7.0;
    } else {
        local_25 = uint(int(1));
        uint _e294 = local_25;
        local_69 = _e294;
        uint _e296 = local_69;
        output.Store(8+_e296*12, asuint(7.0));
    }
    float3_ _e300 = local_24;
    local_26 = uint(int(6));
    uint _e304 = local_26;
    {
        float3_ _value2 = _e300;
        output.Store(_e304*12+0, asuint(_value2.x));
        output.Store(_e304*12+4, asuint(_value2.y));
        output.Store(_e304*12+8, asuint(_value2.z));
    }
    local_28 = uint(int(1));
    uint _e309 = local_28;
    float _e312 = asfloat(output.Load(8+_e309*12));
    local_27 = uint(int(6));
    uint _e316 = local_27;
    output.Store(0+_e316*12, asuint(_e312));
    local_30 = uint(int(0));
    uint _e322 = local_30;
    float _e325 = asfloat(output.Load(0+_e322*12));
    local_31 = uint(int(1));
    uint _e329 = local_31;
    float _e332 = asfloat(output.Load(0+_e329*12));
    local_32 = uint(int(2));
    uint _e336 = local_32;
    float _e339 = asfloat(output.Load(0+_e336*12));
    local_29 = uint(int(7));
    uint _e344 = local_29;
    {
        float3_ _value2 = Constructfloat3_(_e325, _e332, _e339);
        output.Store(_e344*12+0, asuint(_value2.x));
        output.Store(_e344*12+4, asuint(_value2.y));
        output.Store(_e344*12+8, asuint(_value2.z));
    }
    local_33 = uint(int(0));
    uint _e349 = local_33;
    float3_ _e351 = Constructfloat3_(asfloat(input.Load(_e349*12+0)), asfloat(input.Load(_e349*12+4)), asfloat(input.Load(_e349*12+8)));
    local_70 = _e351;
    float3_ _e353 = local_70;
    local_47 = _e353;
    float3_ _e355 = local_47;
    snapshot = _e355;
    float3_ _e357 = snapshot;
    snapshot.x = 9.0;
    const float _e361 = pair(_e357, int(4));
    float _e363 = snapshot.x;
    local_35 = uint(int(2));
    uint _e367 = local_35;
    float _e370 = asfloat(input.Load(8+_e367*12));
    local_34 = uint(int(8));
    uint _e375 = local_34;
    {
        float3_ _value2 = Constructfloat3_(_e361, _e363, _e370);
        output.Store(_e375*12+0, asuint(_value2.x));
        output.Store(_e375*12+4, asuint(_value2.y));
        output.Store(_e375*12+8, asuint(_value2.z));
    }
}
