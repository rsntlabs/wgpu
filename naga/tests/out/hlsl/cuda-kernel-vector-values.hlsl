struct type_5 {
    int2 value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_7 {
    uint2 value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_9 {
    float2 value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_10 {
    int4 value;
};

struct type_12 {
    uint4 value;
};

struct type_14 {
    float4 value;
};

RWByteAddressBuffer output : register(u0);
cbuffer signed2_1 : register(b1) { type_5 signed2_1; }
cbuffer unsigned2_1 : register(b2) { type_7 unsigned2_1; }
cbuffer real2_1 : register(b3) { type_9 real2_1; }
cbuffer signed4_1 : register(b4) { type_10 signed4_1; }
cbuffer unsigned4_1 : register(b5) { type_12 unsigned4_1; }
cbuffer real4_1 : register(b6) { type_14 real4_1; }

int sum_pair(int4 value)
{
    int4 value_1 = (int4)0;

    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return asint(asuint(_e4) + asuint(_e5));
}

[numthreads(4, 1, 1)]
void vector_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    int2 signed2_ = (int2)0;
    uint2 unsigned2_ = (uint2)0;
    float2 real2_ = (float2)0;
    int4 signed4_ = (int4)0;
    uint4 unsigned4_ = (uint4)0;
    float4 real4_ = (float4)0;
    int2 original_signed = (int2)0;
    float2 original_real = (float2)0;
    uint4 original_unsigned = (uint4)0;
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

    int2 _e4 = signed2_1.value;
    signed2_ = _e4;
    uint2 _e8 = unsigned2_1.value;
    unsigned2_ = _e8;
    float2 _e12 = real2_1.value;
    real2_ = _e12;
    int4 _e16 = signed4_1.value;
    signed4_ = _e16;
    uint4 _e20 = unsigned4_1.value;
    unsigned4_ = _e20;
    float4 _e24 = real4_1.value;
    real4_ = _e24;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    int2 _e37 = signed2_;
    original_signed = _e37;
    float2 _e39 = real2_;
    original_real = _e39;
    uint4 _e41 = unsigned4_;
    original_unsigned = _e41;
    int _e45 = signed2_.x;
    signed2_.x = asint(asuint(_e45) + asuint(int(lane)));
    int _e49 = signed2_.y;
    signed2_.y = asint(asuint(_e49) - asuint(int(lane)));
    uint _e52 = unsigned2_.x;
    unsigned2_.x = (_e52 + lane);
    uint _e55 = unsigned2_.y;
    unsigned2_.y = (_e55 + 2u);
    float _e60 = real2_.x;
    real2_.x = (_e60 + float(lane));
    float _e63 = real2_.y;
    real2_.y = (_e63 * 2.0);
    int _e67 = signed4_.x;
    int _e69 = signed4_.y;
    int _e72 = signed4_.z;
    int4 _e74 = signed4_;
    const int _e75 = sum_pair(_e74);
    signed4_ = int4(_e67, _e69, asint(asuint(_e72) + asuint(int(lane))), _e75);
    uint _e78 = unsigned4_.y;
    unsigned4_.x = (_e78 + 1u);
    uint _e83 = unsigned4_.w;
    unsigned4_.w = (_e83 + lane);
    int _e86 = signed2_.x;
    output.Store(base*4, asuint(uint(asint(asuint(_e86) + asuint(int(10))))));
    int _e93 = signed2_.y;
    local = uint((base + 1u));
    uint _e99 = local;
    output.Store(_e99*4, asuint(uint(_e93)));
    uint _e103 = unsigned2_.x;
    uint _e104 = unsigned2_.y;
    local_1 = uint((base + 2u));
    uint _e110 = local_1;
    output.Store(_e110*4, asuint((_e103 + _e104)));
    float _e113 = real2_.x;
    local_2 = uint((base + 3u));
    uint _e119 = local_2;
    output.Store(_e119*4, asuint(asuint(_e113)));
    float _e122 = real2_.y;
    local_3 = uint((base + 4u));
    uint _e128 = local_3;
    output.Store(_e128*4, asuint(asuint(_e122)));
    int _e131 = signed4_.z;
    local_4 = uint((base + 5u));
    uint _e139 = local_4;
    output.Store(_e139*4, asuint(uint(asint(asuint(_e131) + asuint(int(10))))));
    int _e142 = signed4_.w;
    local_5 = uint((base + 6u));
    uint _e148 = local_5;
    output.Store(_e148*4, asuint(uint(_e142)));
    uint _e152 = unsigned4_.x;
    uint _e153 = unsigned4_.w;
    local_6 = uint((base + 7u));
    uint _e159 = local_6;
    output.Store(_e159*4, asuint((_e152 + _e153)));
    float _e163 = real4_.x;
    float _e164 = real4_.y;
    float _e167 = real4_.z;
    float _e170 = real4_.w;
    local_7 = uint((base + 8u));
    uint _e177 = local_7;
    output.Store(_e177*4, asuint(asuint((((_e163 + _e164) + _e167) + _e170))));
    int _e180 = original_signed.x;
    local_8 = uint((base + 9u));
    uint _e188 = local_8;
    output.Store(_e188*4, asuint(uint(asint(asuint(_e180) + asuint(int(10))))));
    float _e191 = original_real.x;
    local_9 = uint((base + 10u));
    uint _e197 = local_9;
    output.Store(_e197*4, asuint(asuint(_e191)));
    uint _e201 = original_unsigned.x;
    uint _e202 = original_unsigned.w;
    local_10 = uint((base + 11u));
    uint _e208 = local_10;
    output.Store(_e208*4, asuint((_e201 + _e202)));
}
