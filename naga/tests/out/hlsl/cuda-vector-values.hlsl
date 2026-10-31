struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct int3_ {
    int x;
    int y;
    int z;
};

struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);

int choose(int2 value)
{
    int2 value_1 = (int2)0;

    value_1 = value;
    int _e4 = value_1.x;
    int _e7 = value_1.y;
    return asint(asuint(asint(asuint(_e4) * asuint(int(10)))) + asuint(_e7));
}

int choose_1(uint3_ value_2)
{
    uint3_ value_3 = (uint3_)0;

    value_3 = value_2;
    uint _e3 = value_3.z;
    return int(_e3);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int choose_2(float4 value_4)
{
    float4 value_5 = (float4)0;

    value_5 = value_4;
    float _e3 = value_5.w;
    return naga_f2i32(_e3);
}

int3_ bump(int3_ value_6)
{
    int3_ value_7 = (int3_)0;

    value_7 = value_6;
    int _e4 = value_7.y;
    value_7.y = asint(asuint(_e4) + asuint(int(1)));
    int3_ _e6 = value_7;
    const int3_ int3_1 = _e6;
    return int3_1;
}

float3_ shift(float3_ value_8)
{
    float3_ value_9 = (float3_)0;

    value_9 = value_8;
    float _e4 = value_9.x;
    value_9.x = (_e4 + 2.0);
    float _e9 = value_9.x;
    float _e10 = value_9.y;
    value_9.z = (_e9 + _e10);
    float3_ _e12 = value_9;
    const float3_ float3_1 = _e12;
    return float3_1;
}

int pair(float3_ first, int second)
{
    float3_ first_1 = (float3_)0;

    first_1 = first;
    float _e4 = first_1.x;
    return asint(asuint(asint(asuint(naga_f2i32(_e4)) * asuint(int(10)))) + asuint(second));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

int3_ Constructint3_(int arg0, int arg1, int arg2) {
    int3_ ret = (int3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint3_ Constructuint3_(uint arg0, uint arg1, uint arg2) {
    uint3_ ret = (uint3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(1, 1, 1)]
void vector_values()
{
    uint local = (uint)0;
    float2 f2_ = (float2)0;
    float3_ f3_ = (float3_)0;
    float4 f4_ = (float4)0;
    int2 i2_ = (int2)0;
    int3_ i3_ = (int3_)0;
    int4 i4_ = (int4)0;
    uint2 u2_ = (uint2)0;
    uint3_ u3_ = (uint3_)0;
    uint4 u4_ = (uint4)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    float3_ frozen = (float3_)0;
    float3_ copied = (float3_)0;
    uint local_10 = (uint)0;
    int3_ changed = (int3_)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    float3_ samples[2] = (float3_[2])0;
    int index = (int)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    bool choose_first = (bool)0;
    uint local_16 = (uint)0;
    float local_17 = (float)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    float local_20 = (float)0;
    uint local_21 = (uint)0;
    float3_ local_22 = (float3_)0;
    int local_23 = (int)0;
    uint local_24 = (uint)0;
    int argument = (int)0;
    int3_ captured = (int3_)0;
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

    local = uint(int(0));
    uint _e3 = local;
    local_29 = uint(_e3);
    uint _e6 = local_29;
    int seed = asint(out_.Load(_e6*4));
    f2_ = float2(float(seed), 1.5);
    f3_ = Constructfloat3_(1.0, 2.0, 3.0);
    f4_ = float4(float(int(1)), float(int(2)), float(int(3)), float(int(4)));
    i2_ = int2(seed, naga_neg(int(2)));
    i3_ = Constructint3_(int(1), int(2), int(3));
    i4_ = int4(int(1), int(2), int(3), int(4));
    u2_ = uint2(uint(naga_neg(int(1))), uint(int(2)));
    u3_ = Constructuint3_(uint(int(1)), uint(int(2)), uint(int(3)));
    u4_ = uint4(uint(int(1)), uint(int(2)), uint(int(3)), uint(int(4)));
    float _e71 = f2_.x;
    float _e72 = f2_.y;
    local_1 = uint(int(0));
    uint _e78 = local_1;
    local_30 = uint(_e78);
    uint _e81 = local_30;
    out_.Store(_e81*4, asuint(naga_f2i32((_e71 + _e72))));
    float _e85 = f3_.x;
    float _e86 = f3_.y;
    float _e89 = f3_.z;
    local_2 = uint(int(1));
    uint _e95 = local_2;
    local_31 = uint(_e95);
    uint _e98 = local_31;
    out_.Store(_e98*4, asuint(naga_f2i32(((_e85 + _e86) + _e89))));
    float _e101 = f4_.w;
    local_3 = uint(int(2));
    uint _e106 = local_3;
    local_32 = uint(_e106);
    uint _e109 = local_32;
    out_.Store(_e109*4, asuint(naga_f2i32(_e101)));
    int _e113 = i2_.x;
    int _e114 = i2_.y;
    local_4 = uint(int(3));
    uint _e119 = local_4;
    local_33 = uint(_e119);
    uint _e122 = local_33;
    out_.Store(_e122*4, asuint(asint(asuint(_e113) + asuint(_e114))));
    int _e125 = i3_.z;
    local_5 = uint(int(4));
    uint _e129 = local_5;
    local_34 = uint(_e129);
    uint _e132 = local_34;
    out_.Store(_e132*4, asuint(_e125));
    int _e136 = i4_.x;
    int _e137 = i4_.w;
    local_6 = uint(int(5));
    uint _e142 = local_6;
    local_35 = uint(_e142);
    uint _e145 = local_35;
    out_.Store(_e145*4, asuint(asint(asuint(_e136) + asuint(_e137))));
    uint _e148 = u2_.x;
    local_7 = uint(int(6));
    uint _e155 = local_7;
    local_36 = uint(_e155);
    uint _e158 = local_36;
    out_.Store(_e158*4, asuint(int((_e148 == 4294967295u))));
    uint _e162 = u3_.x;
    uint _e163 = u3_.z;
    local_8 = uint(int(7));
    uint _e169 = local_8;
    local_37 = uint(_e169);
    uint _e172 = local_37;
    out_.Store(_e172*4, asuint(int((_e162 + _e163))));
    uint _e175 = u4_.w;
    local_9 = uint(int(8));
    uint _e180 = local_9;
    local_38 = uint(_e180);
    uint _e183 = local_38;
    out_.Store(_e183*4, asuint(int(_e175)));
    float3_ _e185 = f3_;
    frozen = _e185;
    float3_ _e187 = frozen;
    copied = _e187;
    copied.x = 9.0;
    float _e192 = frozen.x;
    float _e196 = copied.x;
    local_10 = uint(int(9));
    uint _e202 = local_10;
    local_39 = uint(_e202);
    uint _e205 = local_39;
    out_.Store(_e205*4, asuint(naga_f2i32(((_e192 * 10.0) + _e196))));
    int3_ _e207 = i3_;
    const int3_ _e208 = bump(_e207);
    changed = _e208;
    int _e211 = changed.y;
    int _e215 = i3_.y;
    local_11 = uint(int(10));
    uint _e220 = local_11;
    local_40 = uint(_e220);
    uint _e223 = local_40;
    out_.Store(_e223*4, asuint(asint(asuint(asint(asuint(_e211) * asuint(int(10)))) + asuint(_e215))));
    float3_ _e225 = f3_;
    const float3_ _e226 = shift(_e225);
    local_12 = uint(int(11));
    uint _e232 = local_12;
    local_41 = uint(_e232);
    uint _e235 = local_41;
    out_.Store(_e235*4, asuint(naga_f2i32(_e226.z)));
    int2 _e237 = i2_;
    const int _e238 = choose(_e237);
    uint3_ _e239 = u3_;
    const int _e240 = choose_1(_e239);
    float4 _e242 = f4_;
    const int _e243 = choose_2(_e242);
    local_13 = uint(int(12));
    uint _e248 = local_13;
    local_42 = uint(_e248);
    uint _e251 = local_42;
    out_.Store(_e251*4, asuint(asint(asuint(asint(asuint(_e238) + asuint(_e240))) + asuint(_e243))));
    float3_ _e253 = f3_;
    samples[int(0)] = _e253;
    samples[int(1)] = Constructfloat3_(float(int(5)), float(int(6)), float(int(7)));
    index = int(0);
    int _e268 = index;
    index = asint(asuint(_e268) + asuint(int(1)));
    int _e271 = index;
    int _e272 = index;
    index = asint(asuint(_e272) + asuint(int(1)));
    float _e277 = samples[min(uint(_e272), 1u)].x;
    samples[min(uint(_e272), 1u)].x = (_e277 + float(_e271));
    float _e280 = samples[min(uint(_e272), 1u)].x;
    local_14 = uint(int(13));
    uint _e285 = local_14;
    local_43 = uint(_e285);
    uint _e288 = local_43;
    out_.Store(_e288*4, asuint(naga_f2i32(_e280)));
    int _e290 = index;
    float _e296 = samples[int(0)].x;
    float _e304 = samples[int(1)].x;
    local_15 = uint(int(14));
    uint _e310 = local_15;
    local_44 = uint(_e310);
    uint _e313 = local_44;
    out_.Store(_e313*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e290) * asuint(int(100)))) + asuint(asint(asuint(naga_f2i32(_e296)) * asuint(int(10)))))) + asuint(naga_f2i32(_e304)))));
    choose_first = false;
    bool _e317 = choose_first;
    if (_e317) {
        float _e321 = samples[int(0)].y;
        samples[int(0)].y = (_e321 + float(int(1)));
        local_17 = _e321;
    } else {
        float _e329 = samples[int(1)].y;
        samples[int(1)].y = (_e329 + float(int(1)));
        local_17 = _e329;
    }
    float _e335 = local_17;
    local_16 = uint(int(15));
    uint _e340 = local_16;
    local_45 = uint(_e340);
    uint _e343 = local_45;
    out_.Store(_e343*4, asuint(naga_f2i32(_e335)));
    float _e348 = samples[int(1)].y;
    local_18 = uint(int(16));
    uint _e353 = local_18;
    local_46 = uint(_e353);
    uint _e356 = local_46;
    out_.Store(_e356*4, asuint(naga_f2i32(_e348)));
    float3_ _e358 = f3_;
    bool _e359 = choose_first;
    if (_e359) {
        samples[int(0)] = _e358;
        float _e363 = samples[int(0)].z;
        local_20 = _e363;
    } else {
        samples[int(1)] = _e358;
        float _e368 = samples[int(1)].z;
        local_20 = _e368;
    }
    float _e371 = local_20;
    local_19 = uint(int(17));
    uint _e376 = local_19;
    local_47 = uint(_e376);
    uint _e379 = local_47;
    out_.Store(_e379*4, asuint(naga_f2i32(_e371)));
    if (true) {
        local_22 = Constructfloat3_(float(int(7)), float(int(8)), float(int(9)));
    } else {
        float3_ _e390 = f3_;
        local_22 = _e390;
    }
    float3_ _e393 = local_22;
    local_21 = uint(int(18));
    uint _e399 = local_21;
    local_48 = uint(_e399);
    uint _e402 = local_48;
    out_.Store(_e402*4, asuint(naga_f2i32(_e393.y)));
    {
        local_23 = asint(asuint(seed) + asuint(int(2)));
        int _e407 = local_23;
        local_24 = uint(int(19));
        uint _e411 = local_24;
        local_49 = uint(_e411);
        uint _e414 = local_49;
        out_.Store(_e414*4, asuint(_e407));
    }
    argument = int(3);
    int _e418 = argument;
    int _e419 = argument;
    argument = asint(asuint(_e419) + asuint(int(1)));
    int _e422 = argument;
    captured = Constructint3_(_e418, _e419, _e422);
    int _e426 = captured.x;
    int _e430 = captured.y;
    int _e435 = captured.z;
    local_25 = uint(int(20));
    uint _e440 = local_25;
    local_50 = uint(_e440);
    uint _e443 = local_50;
    out_.Store(_e443*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e426) * asuint(int(100)))) + asuint(asint(asuint(_e430) * asuint(int(10)))))) + asuint(_e435))));
    int _e445 = argument;
    local_26 = uint(int(21));
    uint _e449 = local_26;
    local_51 = uint(_e449);
    uint _e452 = local_51;
    out_.Store(_e452*4, asuint(_e445));
    float3_ _e454 = f3_;
    f3_.x = 9.0;
    const int _e458 = pair(_e454, int(4));
    local_27 = uint(int(22));
    uint _e462 = local_27;
    local_52 = uint(_e462);
    uint _e465 = local_52;
    out_.Store(_e465*4, asuint(_e458));
    float _e468 = f3_.x;
    local_28 = uint(int(23));
    uint _e473 = local_28;
    local_53 = uint(_e473);
    uint _e476 = local_53;
    out_.Store(_e476*4, asuint(naga_f2i32(_e468)));
}
