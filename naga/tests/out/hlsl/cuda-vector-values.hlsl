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

    local = uint(int(0));
    uint _e3 = local;
    int seed = asint(out_.Load(_e3*4));
    f2_ = float2(float(seed), 1.5);
    f3_ = Constructfloat3_(1.0, 2.0, 3.0);
    f4_ = float4(float(int(1)), float(int(2)), float(int(3)), float(int(4)));
    i2_ = int2(seed, naga_neg(int(2)));
    i3_ = Constructint3_(int(1), int(2), int(3));
    i4_ = int4(int(1), int(2), int(3), int(4));
    u2_ = uint2(uint(naga_neg(int(1))), uint(int(2)));
    u3_ = Constructuint3_(uint(int(1)), uint(int(2)), uint(int(3)));
    u4_ = uint4(uint(int(1)), uint(int(2)), uint(int(3)), uint(int(4)));
    float _e68 = f2_.x;
    float _e69 = f2_.y;
    local_1 = uint(int(0));
    uint _e75 = local_1;
    out_.Store(_e75*4, asuint(naga_f2i32((_e68 + _e69))));
    float _e79 = f3_.x;
    float _e80 = f3_.y;
    float _e83 = f3_.z;
    local_2 = uint(int(1));
    uint _e89 = local_2;
    out_.Store(_e89*4, asuint(naga_f2i32(((_e79 + _e80) + _e83))));
    float _e92 = f4_.w;
    local_3 = uint(int(2));
    uint _e97 = local_3;
    out_.Store(_e97*4, asuint(naga_f2i32(_e92)));
    int _e101 = i2_.x;
    int _e102 = i2_.y;
    local_4 = uint(int(3));
    uint _e107 = local_4;
    out_.Store(_e107*4, asuint(asint(asuint(_e101) + asuint(_e102))));
    int _e110 = i3_.z;
    local_5 = uint(int(4));
    uint _e114 = local_5;
    out_.Store(_e114*4, asuint(_e110));
    int _e118 = i4_.x;
    int _e119 = i4_.w;
    local_6 = uint(int(5));
    uint _e124 = local_6;
    out_.Store(_e124*4, asuint(asint(asuint(_e118) + asuint(_e119))));
    uint _e127 = u2_.x;
    local_7 = uint(int(6));
    uint _e134 = local_7;
    out_.Store(_e134*4, asuint(int((_e127 == 4294967295u))));
    uint _e138 = u3_.x;
    uint _e139 = u3_.z;
    local_8 = uint(int(7));
    uint _e145 = local_8;
    out_.Store(_e145*4, asuint(int((_e138 + _e139))));
    uint _e148 = u4_.w;
    local_9 = uint(int(8));
    uint _e153 = local_9;
    out_.Store(_e153*4, asuint(int(_e148)));
    float3_ _e155 = f3_;
    frozen = _e155;
    float3_ _e157 = frozen;
    copied = _e157;
    copied.x = 9.0;
    float _e162 = frozen.x;
    float _e166 = copied.x;
    local_10 = uint(int(9));
    uint _e172 = local_10;
    out_.Store(_e172*4, asuint(naga_f2i32(((_e162 * 10.0) + _e166))));
    int3_ _e174 = i3_;
    const int3_ _e175 = bump(_e174);
    changed = _e175;
    int _e178 = changed.y;
    int _e182 = i3_.y;
    local_11 = uint(int(10));
    uint _e187 = local_11;
    out_.Store(_e187*4, asuint(asint(asuint(asint(asuint(_e178) * asuint(int(10)))) + asuint(_e182))));
    float3_ _e189 = f3_;
    const float3_ _e190 = shift(_e189);
    local_12 = uint(int(11));
    uint _e196 = local_12;
    out_.Store(_e196*4, asuint(naga_f2i32(_e190.z)));
    int2 _e198 = i2_;
    const int _e199 = choose(_e198);
    uint3_ _e200 = u3_;
    const int _e201 = choose_1(_e200);
    float4 _e203 = f4_;
    const int _e204 = choose_2(_e203);
    local_13 = uint(int(12));
    uint _e209 = local_13;
    out_.Store(_e209*4, asuint(asint(asuint(asint(asuint(_e199) + asuint(_e201))) + asuint(_e204))));
    float3_ _e211 = f3_;
    samples[int(0)] = _e211;
    samples[int(1)] = Constructfloat3_(float(int(5)), float(int(6)), float(int(7)));
    index = int(0);
    int _e226 = index;
    index = asint(asuint(_e226) + asuint(int(1)));
    int _e229 = index;
    int _e230 = index;
    index = asint(asuint(_e230) + asuint(int(1)));
    float _e235 = samples[min(uint(_e230), 1u)].x;
    samples[min(uint(_e230), 1u)].x = (_e235 + float(_e229));
    float _e238 = samples[min(uint(_e230), 1u)].x;
    local_14 = uint(int(13));
    uint _e243 = local_14;
    out_.Store(_e243*4, asuint(naga_f2i32(_e238)));
    int _e245 = index;
    float _e251 = samples[int(0)].x;
    float _e259 = samples[int(1)].x;
    local_15 = uint(int(14));
    uint _e265 = local_15;
    out_.Store(_e265*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e245) * asuint(int(100)))) + asuint(asint(asuint(naga_f2i32(_e251)) * asuint(int(10)))))) + asuint(naga_f2i32(_e259)))));
    choose_first = false;
    bool _e269 = choose_first;
    if (_e269) {
        float _e273 = samples[int(0)].y;
        samples[int(0)].y = (_e273 + float(int(1)));
        local_17 = _e273;
    } else {
        float _e281 = samples[int(1)].y;
        samples[int(1)].y = (_e281 + float(int(1)));
        local_17 = _e281;
    }
    float _e287 = local_17;
    local_16 = uint(int(15));
    uint _e292 = local_16;
    out_.Store(_e292*4, asuint(naga_f2i32(_e287)));
    float _e297 = samples[int(1)].y;
    local_18 = uint(int(16));
    uint _e302 = local_18;
    out_.Store(_e302*4, asuint(naga_f2i32(_e297)));
    float3_ _e304 = f3_;
    bool _e305 = choose_first;
    if (_e305) {
        samples[int(0)] = _e304;
        float _e309 = samples[int(0)].z;
        local_20 = _e309;
    } else {
        samples[int(1)] = _e304;
        float _e314 = samples[int(1)].z;
        local_20 = _e314;
    }
    float _e317 = local_20;
    local_19 = uint(int(17));
    uint _e322 = local_19;
    out_.Store(_e322*4, asuint(naga_f2i32(_e317)));
    if (true) {
        local_22 = Constructfloat3_(float(int(7)), float(int(8)), float(int(9)));
    } else {
        float3_ _e333 = f3_;
        local_22 = _e333;
    }
    float3_ _e336 = local_22;
    local_21 = uint(int(18));
    uint _e342 = local_21;
    out_.Store(_e342*4, asuint(naga_f2i32(_e336.y)));
    {
        local_23 = asint(asuint(seed) + asuint(int(2)));
        int _e347 = local_23;
        local_24 = uint(int(19));
        uint _e351 = local_24;
        local_29 = _e351;
        uint _e353 = local_29;
        out_.Store(_e353*4, asuint(_e347));
    }
    argument = int(3);
    int _e357 = argument;
    int _e358 = argument;
    argument = asint(asuint(_e358) + asuint(int(1)));
    int _e361 = argument;
    captured = Constructint3_(_e357, _e358, _e361);
    int _e365 = captured.x;
    int _e369 = captured.y;
    int _e374 = captured.z;
    local_25 = uint(int(20));
    uint _e379 = local_25;
    out_.Store(_e379*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e365) * asuint(int(100)))) + asuint(asint(asuint(_e369) * asuint(int(10)))))) + asuint(_e374))));
    int _e381 = argument;
    local_26 = uint(int(21));
    uint _e385 = local_26;
    out_.Store(_e385*4, asuint(_e381));
    float3_ _e387 = f3_;
    f3_.x = 9.0;
    const int _e391 = pair(_e387, int(4));
    local_27 = uint(int(22));
    uint _e395 = local_27;
    out_.Store(_e395*4, asuint(_e391));
    float _e398 = f3_.x;
    local_28 = uint(int(23));
    uint _e403 = local_28;
    out_.Store(_e403*4, asuint(naga_f2i32(_e398)));
}
