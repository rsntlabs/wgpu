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
    int index = (int)0;
    uint local_2 = (uint)0;
    bool choose_first = (bool)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    float local_7 = (float)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    float local_10 = (float)0;
    float3_ local_11 = (float3_)0;
    bool pick_local = (bool)0;
    uint local_12 = (uint)0;
    float3_ snapshot = (float3_)0;
    float3_ local_13 = (float3_)0;
    float3_ local_14 = (float3_)0;
    float3_ local_15 = (float3_)0;
    float local_16 = (float)0;
    float local_17 = (float)0;
    float local_18 = (float)0;
    float local_19 = (float)0;
    float3_ local_20 = (float3_)0;
    float local_21 = (float)0;
    float local_22 = (float)0;
    float3_ local_23 = (float3_)0;
    float3_ local_24 = (float3_)0;
    uint local_25 = (uint)0;
    float3_ local_26 = (float3_)0;
    uint local_27 = (uint)0;
    float3_ local_28 = (float3_)0;
    float3_ local_29 = (float3_)0;
    uint local_30 = (uint)0;
    float local_31 = (float)0;
    uint local_32 = (uint)0;
    float local_33 = (float)0;
    uint local_34 = (uint)0;
    float local_35 = (float)0;
    uint local_36 = (uint)0;
    float local_37 = (float)0;
    float3_ local_38 = (float3_)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    float local_41 = (float)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    float local_44 = (float)0;
    float3_ local_45 = (float3_)0;
    uint local_46 = (uint)0;
    float3_ local_47 = (float3_)0;

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
            local_25 = _e8;
            uint _e10 = local_25;
            float3_ _e13 = Constructfloat3_(asfloat(input.Load(_e10*12+0)), asfloat(input.Load(_e10*12+4)), asfloat(input.Load(_e10*12+8)));
            local_26 = _e13;
            float3_ _e15 = local_26;
            local_13 = _e15;
            float3_ _e17 = local_13;
            copied = _e17;
            float3_ _e19 = copied;
            const float3_ _e20 = shift(_e19);
            int _e21 = i;
            local_1 = uint(_e21);
            uint _e24 = local_1;
            local_27 = _e24;
            uint _e26 = local_27;
            {
                float3_ _value4 = _e20;
                output.Store(_e26*12+0, asuint(_value4.x));
                output.Store(_e26*12+4, asuint(_value4.y));
                output.Store(_e26*12+8, asuint(_value4.z));
            }
        }
    }
    float3_ _e36 = Constructfloat3_(asfloat(input.Load(uint(int(0))*12+0)), asfloat(input.Load(uint(int(0))*12+4)), asfloat(input.Load(uint(int(0))*12+8)));
    local_28 = _e36;
    float3_ _e38 = local_28;
    local_14 = _e38;
    float3_ _e40 = local_14;
    {
        float3_ _value2 = _e40;
        output.Store(uint(int(3))*12+0, asuint(_value2.x));
        output.Store(uint(int(3))*12+4, asuint(_value2.y));
        output.Store(uint(int(3))*12+8, asuint(_value2.z));
    }
    float3_ _e48 = Constructfloat3_(asfloat(input.Load(uint(int(1))*12+0)), asfloat(input.Load(uint(int(1))*12+4)), asfloat(input.Load(uint(int(1))*12+8)));
    local_29 = _e48;
    float3_ _e50 = local_29;
    local_15 = _e50;
    float3_ _e52 = local_15;
    const float3_ _e53 = shift(_e52);
    output.Store(4+uint(int(3))*12, asuint(_e53.x));
    index = int(0);
    index = int(1);
    float _e66 = asfloat(input.Load(0+uint(int(2))*12));
    int _e67 = index;
    index = asint(asuint(_e67) + asuint(int(1)));
    local_2 = uint(_e67);
    uint _e72 = local_2;
    output.Store(0+_e72*12, asuint(_e66));
    int _e75 = index;
    float _e80 = asfloat(input.Load(0+uint(int(0))*12));
    float _e85 = asfloat(input.Load(0+uint(int(1))*12));
    {
        float3_ _value2 = Constructfloat3_(float(_e75), _e80, _e85);
        output.Store(uint(int(4))*12+0, asuint(_value2.x));
        output.Store(uint(int(4))*12+4, asuint(_value2.y));
        output.Store(uint(int(4))*12+8, asuint(_value2.z));
    }
    choose_first = true;
    bool _e93 = choose_first;
    if (_e93) {
        local_3 = uint(int(0));
        uint _e97 = local_3;
        local_30 = _e97;
        uint _e99 = local_30;
        float _e102 = asfloat(output.Load(4+_e99*12));
        local_31 = _e102;
        float _e104 = local_31;
        local_16 = _e104;
        float _e106 = local_16;
        uint _e109 = local_30;
        output.Store(4+_e109*12, asuint((_e106 + 2.0)));
    } else {
        local_4 = uint(int(2));
        uint _e115 = local_4;
        local_32 = _e115;
        uint _e117 = local_32;
        float _e120 = asfloat(output.Load(4+_e117*12));
        local_33 = _e120;
        float _e122 = local_33;
        local_17 = _e122;
        float _e124 = local_17;
        uint _e127 = local_32;
        output.Store(4+_e127*12, asuint((_e124 + 2.0)));
    }
    bool _e130 = choose_first;
    if (_e130) {
        local_5 = uint(int(0));
        uint _e134 = local_5;
        local_34 = _e134;
        uint _e136 = local_34;
        float _e139 = asfloat(output.Load(8+_e136*12));
        local_35 = _e139;
        float _e141 = local_35;
        local_18 = _e141;
        float _e143 = local_18;
        uint _e147 = local_34;
        output.Store(8+_e147*12, asuint((_e143 + float(int(1)))));
        local_7 = _e143;
    } else {
        local_6 = uint(int(2));
        uint _e154 = local_6;
        local_36 = _e154;
        uint _e156 = local_36;
        float _e159 = asfloat(output.Load(8+_e156*12));
        local_37 = _e159;
        float _e161 = local_37;
        local_19 = _e161;
        float _e163 = local_19;
        uint _e167 = local_36;
        output.Store(8+_e167*12, asuint((_e163 + float(int(1)))));
        local_7 = _e163;
    }
    float _e172 = local_7;
    output.Store(0+uint(int(4))*12, asuint(_e172));
    int _e177 = index;
    output.Store(8+uint(int(4))*12, asuint(float(_e177)));
    float3_ _e186 = Constructfloat3_(asfloat(input.Load(uint(int(1))*12+0)), asfloat(input.Load(uint(int(1))*12+4)), asfloat(input.Load(uint(int(1))*12+8)));
    local_38 = _e186;
    float3_ _e188 = local_38;
    local_20 = _e188;
    float3_ _e190 = local_20;
    bool _e191 = choose_first;
    if (_e191) {
        local_8 = uint(int(0));
        uint _e195 = local_8;
        local_39 = _e195;
        uint _e197 = local_39;
        {
            float3_ _value3 = _e190;
            output.Store(_e197*12+0, asuint(_value3.x));
            output.Store(_e197*12+4, asuint(_value3.y));
            output.Store(_e197*12+8, asuint(_value3.z));
        }
        uint _e199 = local_8;
        local_40 = _e199;
        uint _e201 = local_40;
        float _e204 = asfloat(output.Load(0+_e201*12));
        local_41 = _e204;
        float _e206 = local_41;
        local_21 = _e206;
        float _e208 = local_21;
        uint _e212 = local_40;
        output.Store(0+_e212*12, asuint((_e208 + float(int(1)))));
        local_10 = _e208;
    } else {
        local_9 = uint(int(2));
        uint _e219 = local_9;
        local_42 = _e219;
        uint _e221 = local_42;
        {
            float3_ _value3 = _e190;
            output.Store(_e221*12+0, asuint(_value3.x));
            output.Store(_e221*12+4, asuint(_value3.y));
            output.Store(_e221*12+8, asuint(_value3.z));
        }
        uint _e223 = local_9;
        local_43 = _e223;
        uint _e225 = local_43;
        float _e228 = asfloat(output.Load(0+_e225*12));
        local_44 = _e228;
        float _e230 = local_44;
        local_22 = _e230;
        float _e232 = local_22;
        uint _e236 = local_43;
        output.Store(0+_e236*12, asuint((_e232 + float(int(1)))));
        local_10 = _e232;
    }
    float3_ _e243 = Constructfloat3_(asfloat(output.Load(uint(int(0))*12+0)), asfloat(output.Load(uint(int(0))*12+4)), asfloat(output.Load(uint(int(0))*12+8)));
    local_45 = _e243;
    float3_ _e245 = local_45;
    local_23 = _e245;
    float3_ _e247 = local_23;
    {
        float3_ _value2 = _e247;
        output.Store(uint(int(5))*12+0, asuint(_value2.x));
        output.Store(uint(int(5))*12+4, asuint(_value2.y));
        output.Store(uint(int(5))*12+8, asuint(_value2.z));
    }
    local_11 = Constructfloat3_(float(int(20)), float(int(30)), float(int(40)));
    pick_local = false;
    pick_local = true;
    bool _e262 = pick_local;
    if (_e262) {
        local_11.z = 7.0;
    } else {
        local_12 = uint(int(1));
        uint _e268 = local_12;
        local_46 = _e268;
        uint _e270 = local_46;
        output.Store(8+_e270*12, asuint(7.0));
    }
    float3_ _e274 = local_11;
    {
        float3_ _value2 = _e274;
        output.Store(uint(int(6))*12+0, asuint(_value2.x));
        output.Store(uint(int(6))*12+4, asuint(_value2.y));
        output.Store(uint(int(6))*12+8, asuint(_value2.z));
    }
    float _e282 = asfloat(output.Load(8+uint(int(1))*12));
    output.Store(0+uint(int(6))*12, asuint(_e282));
    float _e291 = asfloat(output.Load(0+uint(int(0))*12));
    float _e296 = asfloat(output.Load(0+uint(int(1))*12));
    float _e301 = asfloat(output.Load(0+uint(int(2))*12));
    {
        float3_ _value2 = Constructfloat3_(_e291, _e296, _e301);
        output.Store(uint(int(7))*12+0, asuint(_value2.x));
        output.Store(uint(int(7))*12+4, asuint(_value2.y));
        output.Store(uint(int(7))*12+8, asuint(_value2.z));
    }
    float3_ _e309 = Constructfloat3_(asfloat(input.Load(uint(int(0))*12+0)), asfloat(input.Load(uint(int(0))*12+4)), asfloat(input.Load(uint(int(0))*12+8)));
    local_47 = _e309;
    float3_ _e311 = local_47;
    local_24 = _e311;
    float3_ _e313 = local_24;
    snapshot = _e313;
    float3_ _e315 = snapshot;
    snapshot.x = 9.0;
    const float _e319 = pair(_e315, int(4));
    float _e321 = snapshot.x;
    float _e326 = asfloat(input.Load(8+uint(int(2))*12));
    {
        float3_ _value2 = Constructfloat3_(_e319, _e321, _e326);
        output.Store(uint(int(8))*12+0, asuint(_value2.x));
        output.Store(uint(int(8))*12+4, asuint(_value2.y));
        output.Store(uint(int(8))*12+8, asuint(_value2.z));
    }
}
