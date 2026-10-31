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
    int local_29 = (int)0;
    uint local_30 = (uint)0;
    int local_31 = (int)0;
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

    local = uint(int(0));
    uint _e3 = local;
    local_30 = uint(_e3);
    uint _e6 = local_30;
    int _e9 = asint(out_.Load(_e6*4));
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int seed = local_29;
    f2_ = float2(float(seed), 1.5);
    f3_ = Constructfloat3_(1.0, 2.0, 3.0);
    f4_ = float4(float(int(1)), float(int(2)), float(int(3)), float(int(4)));
    i2_ = int2(seed, naga_neg(int(2)));
    i3_ = Constructint3_(int(1), int(2), int(3));
    i4_ = int4(int(1), int(2), int(3), int(4));
    u2_ = uint2(uint(naga_neg(int(1))), uint(int(2)));
    u3_ = Constructuint3_(uint(int(1)), uint(int(2)), uint(int(3)));
    u4_ = uint4(uint(int(1)), uint(int(2)), uint(int(3)), uint(int(4)));
    float _e75 = f2_.x;
    float _e76 = f2_.y;
    local_1 = uint(int(0));
    uint _e82 = local_1;
    local_32 = uint(_e82);
    uint _e85 = local_32;
    out_.Store(_e85*4, asuint(naga_f2i32((_e75 + _e76))));
    float _e89 = f3_.x;
    float _e90 = f3_.y;
    float _e93 = f3_.z;
    local_2 = uint(int(1));
    uint _e99 = local_2;
    local_33 = uint(_e99);
    uint _e102 = local_33;
    out_.Store(_e102*4, asuint(naga_f2i32(((_e89 + _e90) + _e93))));
    float _e105 = f4_.w;
    local_3 = uint(int(2));
    uint _e110 = local_3;
    local_34 = uint(_e110);
    uint _e113 = local_34;
    out_.Store(_e113*4, asuint(naga_f2i32(_e105)));
    int _e117 = i2_.x;
    int _e118 = i2_.y;
    local_4 = uint(int(3));
    uint _e123 = local_4;
    local_35 = uint(_e123);
    uint _e126 = local_35;
    out_.Store(_e126*4, asuint(asint(asuint(_e117) + asuint(_e118))));
    int _e129 = i3_.z;
    local_5 = uint(int(4));
    uint _e133 = local_5;
    local_36 = uint(_e133);
    uint _e136 = local_36;
    out_.Store(_e136*4, asuint(_e129));
    int _e140 = i4_.x;
    int _e141 = i4_.w;
    local_6 = uint(int(5));
    uint _e146 = local_6;
    local_37 = uint(_e146);
    uint _e149 = local_37;
    out_.Store(_e149*4, asuint(asint(asuint(_e140) + asuint(_e141))));
    uint _e152 = u2_.x;
    local_7 = uint(int(6));
    uint _e159 = local_7;
    local_38 = uint(_e159);
    uint _e162 = local_38;
    out_.Store(_e162*4, asuint(int((_e152 == 4294967295u))));
    uint _e166 = u3_.x;
    uint _e167 = u3_.z;
    local_8 = uint(int(7));
    uint _e173 = local_8;
    local_39 = uint(_e173);
    uint _e176 = local_39;
    out_.Store(_e176*4, asuint(int((_e166 + _e167))));
    uint _e179 = u4_.w;
    local_9 = uint(int(8));
    uint _e184 = local_9;
    local_40 = uint(_e184);
    uint _e187 = local_40;
    out_.Store(_e187*4, asuint(int(_e179)));
    float3_ _e189 = f3_;
    frozen = _e189;
    float3_ _e191 = frozen;
    copied = _e191;
    copied.x = 9.0;
    float _e196 = frozen.x;
    float _e200 = copied.x;
    local_10 = uint(int(9));
    uint _e206 = local_10;
    local_41 = uint(_e206);
    uint _e209 = local_41;
    out_.Store(_e209*4, asuint(naga_f2i32(((_e196 * 10.0) + _e200))));
    int3_ _e211 = i3_;
    const int3_ _e212 = bump(_e211);
    changed = _e212;
    int _e215 = changed.y;
    int _e219 = i3_.y;
    local_11 = uint(int(10));
    uint _e224 = local_11;
    local_42 = uint(_e224);
    uint _e227 = local_42;
    out_.Store(_e227*4, asuint(asint(asuint(asint(asuint(_e215) * asuint(int(10)))) + asuint(_e219))));
    float3_ _e229 = f3_;
    const float3_ _e230 = shift(_e229);
    local_12 = uint(int(11));
    uint _e236 = local_12;
    local_43 = uint(_e236);
    uint _e239 = local_43;
    out_.Store(_e239*4, asuint(naga_f2i32(_e230.z)));
    int2 _e241 = i2_;
    const int _e242 = choose(_e241);
    uint3_ _e243 = u3_;
    const int _e244 = choose_1(_e243);
    float4 _e246 = f4_;
    const int _e247 = choose_2(_e246);
    local_13 = uint(int(12));
    uint _e252 = local_13;
    local_44 = uint(_e252);
    uint _e255 = local_44;
    out_.Store(_e255*4, asuint(asint(asuint(asint(asuint(_e242) + asuint(_e244))) + asuint(_e247))));
    float3_ _e257 = f3_;
    samples[int(0)] = _e257;
    samples[int(1)] = Constructfloat3_(float(int(5)), float(int(6)), float(int(7)));
    index = int(0);
    int _e272 = index;
    index = asint(asuint(_e272) + asuint(int(1)));
    int _e275 = index;
    int _e276 = index;
    index = asint(asuint(_e276) + asuint(int(1)));
    float _e281 = samples[min(uint(_e276), 1u)].x;
    samples[min(uint(_e276), 1u)].x = (_e281 + float(_e275));
    float _e284 = samples[min(uint(_e276), 1u)].x;
    local_14 = uint(int(13));
    uint _e289 = local_14;
    local_45 = uint(_e289);
    uint _e292 = local_45;
    out_.Store(_e292*4, asuint(naga_f2i32(_e284)));
    int _e294 = index;
    float _e300 = samples[int(0)].x;
    float _e308 = samples[int(1)].x;
    local_15 = uint(int(14));
    uint _e314 = local_15;
    local_46 = uint(_e314);
    uint _e317 = local_46;
    out_.Store(_e317*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e294) * asuint(int(100)))) + asuint(asint(asuint(naga_f2i32(_e300)) * asuint(int(10)))))) + asuint(naga_f2i32(_e308)))));
    choose_first = false;
    bool _e321 = choose_first;
    if (_e321) {
        float _e325 = samples[int(0)].y;
        samples[int(0)].y = (_e325 + float(int(1)));
        local_17 = _e325;
    } else {
        float _e333 = samples[int(1)].y;
        samples[int(1)].y = (_e333 + float(int(1)));
        local_17 = _e333;
    }
    float _e339 = local_17;
    local_16 = uint(int(15));
    uint _e344 = local_16;
    local_47 = uint(_e344);
    uint _e347 = local_47;
    out_.Store(_e347*4, asuint(naga_f2i32(_e339)));
    float _e352 = samples[int(1)].y;
    local_18 = uint(int(16));
    uint _e357 = local_18;
    local_48 = uint(_e357);
    uint _e360 = local_48;
    out_.Store(_e360*4, asuint(naga_f2i32(_e352)));
    float3_ _e362 = f3_;
    bool _e363 = choose_first;
    if (_e363) {
        samples[int(0)] = _e362;
        float _e367 = samples[int(0)].z;
        local_20 = _e367;
    } else {
        samples[int(1)] = _e362;
        float _e372 = samples[int(1)].z;
        local_20 = _e372;
    }
    float _e375 = local_20;
    local_19 = uint(int(17));
    uint _e380 = local_19;
    local_49 = uint(_e380);
    uint _e383 = local_49;
    out_.Store(_e383*4, asuint(naga_f2i32(_e375)));
    if (true) {
        local_22 = Constructfloat3_(float(int(7)), float(int(8)), float(int(9)));
    } else {
        float3_ _e394 = f3_;
        local_22 = _e394;
    }
    float3_ _e397 = local_22;
    local_21 = uint(int(18));
    uint _e403 = local_21;
    local_50 = uint(_e403);
    uint _e406 = local_50;
    out_.Store(_e406*4, asuint(naga_f2i32(_e397.y)));
    {
        local_23 = asint(asuint(seed) + asuint(int(2)));
        int _e411 = local_23;
        local_24 = uint(int(19));
        uint _e415 = local_24;
        local_51 = uint(_e415);
        uint _e418 = local_51;
        out_.Store(_e418*4, asuint(_e411));
    }
    argument = int(3);
    int _e422 = argument;
    int _e423 = argument;
    argument = asint(asuint(_e423) + asuint(int(1)));
    int _e426 = argument;
    captured = Constructint3_(_e422, _e423, _e426);
    int _e430 = captured.x;
    int _e434 = captured.y;
    int _e439 = captured.z;
    local_25 = uint(int(20));
    uint _e444 = local_25;
    local_52 = uint(_e444);
    uint _e447 = local_52;
    out_.Store(_e447*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e430) * asuint(int(100)))) + asuint(asint(asuint(_e434) * asuint(int(10)))))) + asuint(_e439))));
    int _e449 = argument;
    local_26 = uint(int(21));
    uint _e453 = local_26;
    local_53 = uint(_e453);
    uint _e456 = local_53;
    out_.Store(_e456*4, asuint(_e449));
    float3_ _e458 = f3_;
    f3_.x = 9.0;
    const int _e462 = pair(_e458, int(4));
    local_27 = uint(int(22));
    uint _e466 = local_27;
    local_54 = uint(_e466);
    uint _e469 = local_54;
    out_.Store(_e469*4, asuint(_e462));
    float _e472 = f3_.x;
    local_28 = uint(int(23));
    uint _e477 = local_28;
    local_55 = uint(_e477);
    uint _e480 = local_55;
    out_.Store(_e480*4, asuint(naga_f2i32(_e472)));
}
