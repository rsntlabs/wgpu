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
    float2 f2_ = (float2)0;
    float3_ f3_ = (float3_)0;
    float4 f4_ = (float4)0;
    int2 i2_ = (int2)0;
    int3_ i3_ = (int3_)0;
    int4 i4_ = (int4)0;
    uint2 u2_ = (uint2)0;
    uint3_ u3_ = (uint3_)0;
    uint4 u4_ = (uint4)0;
    float3_ frozen = (float3_)0;
    float3_ copied = (float3_)0;
    int3_ changed = (int3_)0;
    float3_ samples[2] = (float3_[2])0;
    int index = (int)0;
    bool choose_first = (bool)0;
    float local = (float)0;
    float local_1 = (float)0;
    float3_ local_2 = (float3_)0;
    int local_3 = (int)0;
    uint local_4 = (uint)0;
    int argument = (int)0;
    int3_ captured = (int3_)0;
    uint local_5 = (uint)0;

    int seed = asint(out_.Load(uint(int(0))*4));
    f2_ = float2(float(seed), 1.5);
    f3_ = Constructfloat3_(1.0, 2.0, 3.0);
    f4_ = float4(float(int(1)), float(int(2)), float(int(3)), float(int(4)));
    i2_ = int2(seed, naga_neg(int(2)));
    i3_ = Constructint3_(int(1), int(2), int(3));
    i4_ = int4(int(1), int(2), int(3), int(4));
    u2_ = uint2(uint(naga_neg(int(1))), uint(int(2)));
    u3_ = Constructuint3_(uint(int(1)), uint(int(2)), uint(int(3)));
    u4_ = uint4(uint(int(1)), uint(int(2)), uint(int(3)), uint(int(4)));
    float _e66 = f2_.x;
    float _e67 = f2_.y;
    out_.Store(uint(int(0))*4, asuint(naga_f2i32((_e66 + _e67))));
    float _e75 = f3_.x;
    float _e76 = f3_.y;
    float _e79 = f3_.z;
    out_.Store(uint(int(1))*4, asuint(naga_f2i32(((_e75 + _e76) + _e79))));
    float _e86 = f4_.w;
    out_.Store(uint(int(2))*4, asuint(naga_f2i32(_e86)));
    int _e93 = i2_.x;
    int _e94 = i2_.y;
    out_.Store(uint(int(3))*4, asuint(asint(asuint(_e93) + asuint(_e94))));
    int _e100 = i3_.z;
    out_.Store(uint(int(4))*4, asuint(_e100));
    int _e106 = i4_.x;
    int _e107 = i4_.w;
    out_.Store(uint(int(5))*4, asuint(asint(asuint(_e106) + asuint(_e107))));
    uint _e113 = u2_.x;
    out_.Store(uint(int(6))*4, asuint(int((_e113 == 4294967295u))));
    uint _e122 = u3_.x;
    uint _e123 = u3_.z;
    out_.Store(uint(int(7))*4, asuint(int((_e122 + _e123))));
    uint _e130 = u4_.w;
    out_.Store(uint(int(8))*4, asuint(int(_e130)));
    float3_ _e135 = f3_;
    frozen = _e135;
    float3_ _e137 = frozen;
    copied = _e137;
    copied.x = 9.0;
    float _e142 = frozen.x;
    float _e146 = copied.x;
    out_.Store(uint(int(9))*4, asuint(naga_f2i32(((_e142 * 10.0) + _e146))));
    int3_ _e152 = i3_;
    const int3_ _e153 = bump(_e152);
    changed = _e153;
    int _e156 = changed.y;
    int _e160 = i3_.y;
    out_.Store(uint(int(10))*4, asuint(asint(asuint(asint(asuint(_e156) * asuint(int(10)))) + asuint(_e160))));
    float3_ _e165 = f3_;
    const float3_ _e166 = shift(_e165);
    out_.Store(uint(int(11))*4, asuint(naga_f2i32(_e166.z)));
    int2 _e172 = i2_;
    const int _e173 = choose(_e172);
    uint3_ _e174 = u3_;
    const int _e175 = choose_1(_e174);
    float4 _e177 = f4_;
    const int _e178 = choose_2(_e177);
    out_.Store(uint(int(12))*4, asuint(asint(asuint(asint(asuint(_e173) + asuint(_e175))) + asuint(_e178))));
    float3_ _e183 = f3_;
    samples[int(0)] = _e183;
    samples[int(1)] = Constructfloat3_(float(int(5)), float(int(6)), float(int(7)));
    index = int(0);
    int _e198 = index;
    index = asint(asuint(_e198) + asuint(int(1)));
    int _e201 = index;
    int _e202 = index;
    index = asint(asuint(_e202) + asuint(int(1)));
    float _e207 = samples[min(uint(_e202), 1u)].x;
    samples[min(uint(_e202), 1u)].x = (_e207 + float(_e201));
    float _e210 = samples[min(uint(_e202), 1u)].x;
    out_.Store(uint(int(13))*4, asuint(naga_f2i32(_e210)));
    int _e215 = index;
    float _e221 = samples[int(0)].x;
    float _e229 = samples[int(1)].x;
    out_.Store(uint(int(14))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e215) * asuint(int(100)))) + asuint(asint(asuint(naga_f2i32(_e221)) * asuint(int(10)))))) + asuint(naga_f2i32(_e229)))));
    choose_first = false;
    bool _e237 = choose_first;
    if (_e237) {
        float _e241 = samples[int(0)].y;
        samples[int(0)].y = (_e241 + float(int(1)));
        local = _e241;
    } else {
        float _e249 = samples[int(1)].y;
        samples[int(1)].y = (_e249 + float(int(1)));
        local = _e249;
    }
    float _e255 = local;
    out_.Store(uint(int(15))*4, asuint(naga_f2i32(_e255)));
    float _e263 = samples[int(1)].y;
    out_.Store(uint(int(16))*4, asuint(naga_f2i32(_e263)));
    float3_ _e268 = f3_;
    bool _e269 = choose_first;
    if (_e269) {
        samples[int(0)] = _e268;
        float _e273 = samples[int(0)].z;
        local_1 = _e273;
    } else {
        samples[int(1)] = _e268;
        float _e278 = samples[int(1)].z;
        local_1 = _e278;
    }
    float _e281 = local_1;
    out_.Store(uint(int(17))*4, asuint(naga_f2i32(_e281)));
    if (true) {
        local_2 = Constructfloat3_(float(int(7)), float(int(8)), float(int(9)));
    } else {
        float3_ _e295 = f3_;
        local_2 = _e295;
    }
    float3_ _e298 = local_2;
    out_.Store(uint(int(18))*4, asuint(naga_f2i32(_e298.y)));
    {
        local_3 = asint(asuint(seed) + asuint(int(2)));
        int _e307 = local_3;
        local_4 = uint(int(19));
        uint _e311 = local_4;
        local_5 = _e311;
        uint _e313 = local_5;
        out_.Store(_e313*4, asuint(_e307));
    }
    argument = int(3);
    int _e317 = argument;
    int _e318 = argument;
    argument = asint(asuint(_e318) + asuint(int(1)));
    int _e321 = argument;
    captured = Constructint3_(_e317, _e318, _e321);
    int _e325 = captured.x;
    int _e329 = captured.y;
    int _e334 = captured.z;
    out_.Store(uint(int(20))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e325) * asuint(int(100)))) + asuint(asint(asuint(_e329) * asuint(int(10)))))) + asuint(_e334))));
    int _e339 = argument;
    out_.Store(uint(int(21))*4, asuint(_e339));
    float3_ _e343 = f3_;
    f3_.x = 9.0;
    const int _e347 = pair(_e343, int(4));
    out_.Store(uint(int(22))*4, asuint(_e347));
    float _e352 = f3_.x;
    out_.Store(uint(int(23))*4, asuint(naga_f2i32(_e352)));
}
