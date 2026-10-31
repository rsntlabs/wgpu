struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);

float2 fabs(float2 value_1)
{
    float2 value_2 = (float2)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;

    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_53 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_53;
    float _e15 = value_2.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_54 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_54;
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
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;

    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_55 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_55;
    float _e15 = value_4.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_56 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_56;
    float _e27 = value_4.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_57 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_57;
    const float3_ float3_1 = Constructfloat3_(asfloat(_e12), asfloat(_e24), asfloat(_e36));
    return float3_1;
}

float4 fabs_2(float4 value_5)
{
    float4 value_6 = (float4)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;

    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = (asuint(_e3) & 2147483647u);
    local_58 = ((_e6 > 2139095040u) ? 2143289344u : _e6);
    uint _e12 = local_58;
    float _e15 = value_6.y;
    uint _e18 = (asuint(_e15) & 2147483647u);
    local_59 = ((_e18 > 2139095040u) ? 2143289344u : _e18);
    uint _e24 = local_59;
    float _e27 = value_6.z;
    uint _e30 = (asuint(_e27) & 2147483647u);
    local_60 = ((_e30 > 2139095040u) ? 2143289344u : _e30);
    uint _e36 = local_60;
    float _e39 = value_6.w;
    uint _e42 = (asuint(_e39) & 2147483647u);
    local_61 = ((_e42 > 2139095040u) ? 2143289344u : _e42);
    uint _e48 = local_61;
    return float4(asfloat(_e12), asfloat(_e24), asfloat(_e36), asfloat(_e48));
}

float absolute(float value_7)
{
    uint local_62 = (uint)0;

    uint _e3 = (asuint(value_7) & 2147483647u);
    local_62 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_62;
    return asfloat(_e9);
}

float converted_absolute(int value_8)
{
    uint local_63 = (uint)0;

    uint _e4 = (asuint(float(value_8)) & 2147483647u);
    local_63 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_63;
    return asfloat(_e10);
}

float converted_absolute_1(uint value_9)
{
    uint local_64 = (uint)0;

    uint _e4 = (asuint(float(value_9)) & 2147483647u);
    local_64 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_64;
    return asfloat(_e10);
}

float converted_absolute_2(bool value_10)
{
    uint local_65 = (uint)0;

    uint _e4 = (asuint(float(value_10)) & 2147483647u);
    local_65 = ((_e4 > 2139095040u) ? 2143289344u : _e4);
    uint _e10 = local_65;
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
    int local_66 = (int)0;

    if (value_13) {
        local_66 = int(7);
    } else {
        local_66 = int(9);
    }
    int _e6 = local_66;
    return _e6;
}

int fabsf(bool value_14)
{
    int local_67 = (int)0;

    if (value_14) {
        local_67 = int(11);
    } else {
        local_67 = int(13);
    }
    int _e6 = local_67;
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

    uint _e3 = (asuint(0.0) & 2147483647u);
    local_1 = ((_e3 > 2139095040u) ? 2143289344u : _e3);
    uint _e9 = local_1;
    local = uint(int(0));
    uint _e15 = local;
    out_.Store(_e15*4, asuint(asuint(asfloat(_e9))));
    uint _e22 = (asuint(-(0.0)) & 2147483647u);
    local_3 = ((_e22 > 2139095040u) ? 2143289344u : _e22);
    uint _e28 = local_3;
    local_2 = uint(int(1));
    uint _e34 = local_2;
    out_.Store(_e34*4, asuint(asuint(asfloat(_e28))));
    uint _e40 = (asuint(-(1.75)) & 2147483647u);
    local_5 = ((_e40 > 2139095040u) ? 2143289344u : _e40);
    uint _e46 = local_5;
    local_4 = uint(int(2));
    uint _e52 = local_4;
    out_.Store(_e52*4, asuint(asuint(asfloat(_e46))));
    const float _e56 = absolute(-(1.25));
    local_6 = uint(int(3));
    uint _e61 = local_6;
    out_.Store(_e61*4, asuint(asuint(_e56)));
    const float _e65 = converted_absolute(naga_neg(int(3)));
    local_7 = uint(int(4));
    uint _e70 = local_7;
    out_.Store(_e70*4, asuint(asuint(_e65)));
    const float _e73 = converted_absolute_1(4294967295u);
    local_8 = uint(int(5));
    uint _e78 = local_8;
    out_.Store(_e78*4, asuint(asuint(_e73)));
    const float _e81 = converted_absolute_2(true);
    local_9 = uint(int(6));
    uint _e86 = local_9;
    out_.Store(_e86*4, asuint(asuint(_e81)));
    const float _e89 = converted_absolute_2(false);
    local_10 = uint(int(7));
    uint _e94 = local_10;
    out_.Store(_e94*4, asuint(asuint(_e89)));
    local_12 = 1u;
    uint _e98 = local_12;
    uint _e102 = (asuint(asfloat(_e98)) & 2147483647u);
    local_13 = ((_e102 > 2139095040u) ? 2143289344u : _e102);
    uint _e108 = local_13;
    local_11 = uint(int(8));
    uint _e114 = local_11;
    out_.Store(_e114*4, asuint(asuint(asfloat(_e108))));
    local_15 = 2147483649u;
    uint _e118 = local_15;
    uint _e122 = (asuint(asfloat(_e118)) & 2147483647u);
    local_16 = ((_e122 > 2139095040u) ? 2143289344u : _e122);
    uint _e128 = local_16;
    local_14 = uint(int(9));
    uint _e134 = local_14;
    out_.Store(_e134*4, asuint(asuint(asfloat(_e128))));
    local_18 = 8388607u;
    uint _e138 = local_18;
    uint _e142 = (asuint(asfloat(_e138)) & 2147483647u);
    local_19 = ((_e142 > 2139095040u) ? 2143289344u : _e142);
    uint _e148 = local_19;
    local_17 = uint(int(10));
    uint _e154 = local_17;
    out_.Store(_e154*4, asuint(asuint(asfloat(_e148))));
    local_21 = 2155872255u;
    uint _e158 = local_21;
    uint _e162 = (asuint(asfloat(_e158)) & 2147483647u);
    local_22 = ((_e162 > 2139095040u) ? 2143289344u : _e162);
    uint _e168 = local_22;
    local_20 = uint(int(11));
    uint _e174 = local_20;
    out_.Store(_e174*4, asuint(asuint(asfloat(_e168))));
    uint _e179 = (asuint(3.4028235e38) & 2147483647u);
    local_24 = ((_e179 > 2139095040u) ? 2143289344u : _e179);
    uint _e185 = local_24;
    local_23 = uint(int(12));
    uint _e191 = local_23;
    out_.Store(_e191*4, asuint(asuint(asfloat(_e185))));
    uint _e197 = (asuint(-(3.4028235e38)) & 2147483647u);
    local_26 = ((_e197 > 2139095040u) ? 2143289344u : _e197);
    uint _e203 = local_26;
    local_25 = uint(int(13));
    uint _e209 = local_25;
    out_.Store(_e209*4, asuint(asuint(asfloat(_e203))));
    local_28 = 2139095040u;
    uint _e213 = local_28;
    uint _e217 = (asuint(asfloat(_e213)) & 2147483647u);
    local_29 = ((_e217 > 2139095040u) ? 2143289344u : _e217);
    uint _e223 = local_29;
    local_27 = uint(int(14));
    uint _e229 = local_27;
    out_.Store(_e229*4, asuint(asuint(asfloat(_e223))));
    local_31 = 4286578688u;
    uint _e233 = local_31;
    uint _e237 = (asuint(asfloat(_e233)) & 2147483647u);
    local_32 = ((_e237 > 2139095040u) ? 2143289344u : _e237);
    uint _e243 = local_32;
    local_30 = uint(int(15));
    uint _e249 = local_30;
    out_.Store(_e249*4, asuint(asuint(asfloat(_e243))));
    local_34 = 2143363909u;
    uint _e253 = local_34;
    uint _e257 = (asuint(asfloat(_e253)) & 2147483647u);
    local_35 = ((_e257 > 2139095040u) ? 2143289344u : _e257);
    uint _e263 = local_35;
    local_33 = uint(int(16));
    uint _e269 = local_33;
    out_.Store(_e269*4, asuint(asuint(asfloat(_e263))));
    local_37 = 2139095041u;
    uint _e273 = local_37;
    uint _e277 = (asuint(asfloat(_e273)) & 2147483647u);
    local_38 = ((_e277 > 2139095040u) ? 2143289344u : _e277);
    uint _e283 = local_38;
    local_36 = uint(int(17));
    uint _e289 = local_36;
    out_.Store(_e289*4, asuint(asuint(asfloat(_e283))));
    value = -(2.75);
    float _e294 = value;
    value = (_e294 + float(int(1)));
    uint _e300 = (asuint(_e294) & 2147483647u);
    local_40 = ((_e300 > 2139095040u) ? 2143289344u : _e300);
    uint _e306 = local_40;
    local_39 = uint(int(18));
    uint _e312 = local_39;
    out_.Store(_e312*4, asuint(asuint(asfloat(_e306))));
    float _e314 = value;
    local_41 = uint(int(19));
    uint _e319 = local_41;
    out_.Store(_e319*4, asuint(asuint(_e314)));
    const int _e323 = fabs_3(naga_neg(int(3)));
    local_42 = uint(int(20));
    uint _e328 = local_42;
    out_.Store(_e328*4, asuint(uint(_e323)));
    const uint _e331 = fabs_4(3u);
    local_43 = uint(int(21));
    uint _e335 = local_43;
    out_.Store(_e335*4, asuint(_e331));
    const int _e338 = fabs_5(true);
    local_44 = uint(int(22));
    uint _e343 = local_44;
    out_.Store(_e343*4, asuint(uint(_e338)));
    const int _e346 = fabs_5(false);
    local_45 = uint(int(23));
    uint _e351 = local_45;
    out_.Store(_e351*4, asuint(uint(_e346)));
    const int _e354 = fabsf(true);
    local_46 = uint(int(24));
    uint _e359 = local_46;
    out_.Store(_e359*4, asuint(uint(_e354)));
    local_47 = 2147483649u;
    uint _e367 = local_47;
    const float3_ _e370 = fabs_1(Constructfloat3_(-(2.5), -(0.0), asfloat(_e367)));
    triple = _e370;
    float _e373 = triple.x;
    local_48 = uint(int(25));
    uint _e378 = local_48;
    out_.Store(_e378*4, asuint(asuint(_e373)));
    float _e381 = triple.y;
    local_49 = uint(int(26));
    uint _e386 = local_49;
    out_.Store(_e386*4, asuint(asuint(_e381)));
    float _e389 = triple.z;
    local_50 = uint(int(27));
    uint _e394 = local_50;
    out_.Store(_e394*4, asuint(asuint(_e389)));
    const float _e399 = fabsf_1(-(2.0), 3.0);
    local_51 = uint(int(28));
    uint _e404 = local_51;
    out_.Store(_e404*4, asuint(asuint(_e399)));
    const float2 _e411 = fabs(float2(-(3.0), -(4.0)));
    pair = _e411;
    const float4 _e422 = fabs_2(float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e422;
    float _e426 = pair.x;
    float _e427 = pair.y;
    float _e430 = quadruple.x;
    float _e433 = quadruple.w;
    local_52 = uint(int(29));
    uint _e439 = local_52;
    out_.Store(_e439*4, asuint(asuint((((_e426 + _e427) + _e430) + _e433))));
}
