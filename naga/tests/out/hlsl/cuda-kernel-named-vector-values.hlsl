struct int3_ {
    int x;
    int y;
    int z;
};

struct int1_ {
    int x;
};

struct type_3 {
    int1_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct uint1_ {
    uint x;
};

struct type_4 {
    uint1_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct float1_ {
    float x;
};

struct type_6 {
    float1_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct type_7 {
    int3_ value;
    int _end_pad_0;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct type_8 {
    uint3_ value;
    int _end_pad_0;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct type_9 {
    float3_ value;
    int _end_pad_0;
};

RWByteAddressBuffer output : register(u0);
cbuffer signed1_1 : register(b1) { type_3 signed1_1; }
cbuffer unsigned1_1 : register(b2) { type_4 unsigned1_1; }
cbuffer real1_1 : register(b3) { type_6 real1_1; }
cbuffer signed3_1 : register(b4) { type_7 signed3_1; }
cbuffer unsigned3_1 : register(b5) { type_8 unsigned3_1; }
cbuffer real3_1 : register(b6) { type_9 real3_1; }
ByteAddressBuffer input : register(t7);

int sum_pair(int3_ value)
{
    int3_ value_1 = (int3_)0;

    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return asint(asuint(_e4) + asuint(_e5));
}

int3_ Constructint3_(int arg0, int arg1, int arg2) {
    int3_ ret = (int3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(4, 1, 1)]
void named_vectors(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    int1_ signed1_ = (int1_)0;
    uint1_ unsigned1_ = (uint1_)0;
    float1_ real1_ = (float1_)0;
    int3_ signed3_ = (int3_)0;
    uint3_ unsigned3_ = (uint3_)0;
    float3_ real3_ = (float3_)0;
    int1_ original_signed = (int1_)0;
    float1_ original_real = (float1_)0;
    uint3_ original_unsigned = (uint3_)0;
    float3_ stored = (float3_)0;
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
    float3_ local_11 = (float3_)0;
    float3_ local_12 = (float3_)0;

    int1_ _e4 = signed1_1.value;
    signed1_ = _e4;
    uint1_ _e8 = unsigned1_1.value;
    unsigned1_ = _e8;
    float1_ _e12 = real1_1.value;
    real1_ = _e12;
    int3_ _e16 = signed3_1.value;
    signed3_ = _e16;
    uint3_ _e20 = unsigned3_1.value;
    unsigned3_ = _e20;
    float3_ _e24 = real3_1.value;
    real3_ = _e24;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    int1_ _e37 = signed1_;
    original_signed = _e37;
    float1_ _e39 = real1_;
    original_real = _e39;
    uint3_ _e41 = unsigned3_;
    original_unsigned = _e41;
    int _e45 = signed1_.x;
    signed1_.x = asint(asuint(_e45) + asuint(int(lane)));
    uint _e48 = unsigned1_.x;
    unsigned1_.x = (_e48 + lane);
    float _e52 = real1_.x;
    real1_.x = (_e52 + float(lane));
    int _e55 = signed3_.x;
    int _e57 = signed3_.y;
    int _e60 = signed3_.z;
    signed3_ = Constructint3_(_e55, _e57, asint(asuint(_e60) + asuint(int(lane))));
    uint _e64 = unsigned3_.y;
    unsigned3_.x = (_e64 + 1u);
    uint _e69 = unsigned3_.z;
    unsigned3_.z = (_e69 + lane);
    float3_ _e73 = Constructfloat3_(asfloat(input.Load(lane*12+0)), asfloat(input.Load(lane*12+4)), asfloat(input.Load(lane*12+8)));
    local_12 = _e73;
    float3_ _e75 = local_12;
    local_11 = _e75;
    float3_ _e77 = local_11;
    stored = _e77;
    int _e80 = signed1_.x;
    output.Store(base*4, asuint(uint(asint(asuint(_e80) + asuint(int(10))))));
    uint _e87 = unsigned1_.x;
    local = uint((base + 1u));
    uint _e92 = local;
    output.Store(_e92*4, asuint(_e87));
    float _e95 = real1_.x;
    local_1 = uint((base + 2u));
    uint _e101 = local_1;
    output.Store(_e101*4, asuint(asuint(_e95)));
    int _e104 = signed3_.z;
    local_2 = uint((base + 3u));
    uint _e112 = local_2;
    output.Store(_e112*4, asuint(uint(asint(asuint(_e104) + asuint(int(10))))));
    int3_ _e114 = signed3_;
    const int _e115 = sum_pair(_e114);
    local_3 = uint((base + 4u));
    uint _e121 = local_3;
    output.Store(_e121*4, asuint(uint(_e115)));
    uint _e125 = unsigned3_.x;
    uint _e126 = unsigned3_.z;
    local_4 = uint((base + 5u));
    uint _e132 = local_4;
    output.Store(_e132*4, asuint((_e125 + _e126)));
    float _e136 = real3_.x;
    float _e137 = real3_.y;
    float _e140 = real3_.z;
    local_5 = uint((base + 6u));
    uint _e147 = local_5;
    output.Store(_e147*4, asuint(asuint(((_e136 + _e137) + _e140))));
    int _e150 = original_signed.x;
    local_6 = uint((base + 7u));
    uint _e158 = local_6;
    output.Store(_e158*4, asuint(uint(asint(asuint(_e150) + asuint(int(10))))));
    uint _e162 = original_unsigned.x;
    uint _e163 = original_unsigned.z;
    local_7 = uint((base + 8u));
    uint _e169 = local_7;
    output.Store(_e169*4, asuint((_e162 + _e163)));
    float _e172 = original_real.x;
    local_8 = uint((base + 9u));
    uint _e178 = local_8;
    output.Store(_e178*4, asuint(asuint(_e172)));
    float _e181 = stored.z;
    local_9 = uint((base + 10u));
    uint _e187 = local_9;
    output.Store(_e187*4, asuint(asuint(_e181)));
    float _e191 = stored.x;
    float _e192 = real3_.x;
    local_10 = uint((base + 11u));
    uint _e199 = local_10;
    output.Store(_e199*4, asuint(asuint((_e191 + _e192))));
}
