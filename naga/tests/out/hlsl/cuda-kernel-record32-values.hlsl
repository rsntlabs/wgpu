struct Five_cuda_record_0_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
};

struct Six_cuda_record_1_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
};

struct Seven_cuda_record_2_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
};

struct Eight_cuda_record_3_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
    uint h;
};

struct Small_cuda_record_4_ {
    uint value;
};

struct type_4 {
    Five_cuda_record_0_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct type_5 {
    Six_cuda_record_1_ value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_6 {
    Seven_cuda_record_2_ value;
    int _end_pad_0;
};

struct type_7 {
    Eight_cuda_record_3_ value;
};

struct type_8 {
    Small_cuda_record_4_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer output : register(u0);
cbuffer five_1 : register(b1) { type_4 five_1; }
cbuffer six_1 : register(b2) { type_5 six_1; }
cbuffer seven_1 : register(b3) { type_6 seven_1; }
cbuffer eight_1 : register(b4) { type_7 eight_1; }
cbuffer small_1 : register(b5) { type_8 small_1; }
ByteAddressBuffer input : register(t6);

uint ZeroValueuint() {
    return (uint)0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

Five_cuda_record_0_ ConstructFive_cuda_record_0_(int arg0, uint arg1, float arg2, uint arg3, int arg4) {
    Five_cuda_record_0_ ret = (Five_cuda_record_0_)0;
    ret.a = arg0;
    ret.b = arg1;
    ret.c = arg2;
    ret.d = arg3;
    ret.e = arg4;
    return ret;
}

[numthreads(4, 1, 1)]
void record32_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    Five_cuda_record_0_ five = (Five_cuda_record_0_)0;
    Six_cuda_record_1_ six = (Six_cuda_record_1_)0;
    Seven_cuda_record_2_ seven = (Seven_cuda_record_2_)0;
    Eight_cuda_record_3_ eight = (Eight_cuda_record_3_)0;
    Small_cuda_record_4_ small = (Small_cuda_record_4_)0;
    Five_cuda_record_0_ original = (Five_cuda_record_0_)0;
    Seven_cuda_record_2_ saved = (Seven_cuda_record_2_)0;
    Eight_cuda_record_3_ changed = (Eight_cuda_record_3_)0;
    Five_cuda_record_0_ stored = (Five_cuda_record_0_)0;
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
    uint lane = (uint)0;
    Five_cuda_record_0_ local_11 = (Five_cuda_record_0_)0;
    Five_cuda_record_0_ local_12 = (Five_cuda_record_0_)0;

    Five_cuda_record_0_ _e4 = five_1.value;
    five = _e4;
    Six_cuda_record_1_ _e8 = six_1.value;
    six = _e8;
    Seven_cuda_record_2_ _e12 = seven_1.value;
    seven = _e12;
    Eight_cuda_record_3_ _e16 = eight_1.value;
    eight = _e16;
    Small_cuda_record_4_ _e20 = small_1.value;
    small = _e20;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 12u));
    Five_cuda_record_0_ _e33 = five;
    original = _e33;
    Seven_cuda_record_2_ _e35 = seven;
    saved = _e35;
    lane = ZeroValueuint();
    lane = lane_1;
    uint _e40 = lane;
    int _e43 = five.e;
    five.e = asint(asuint(_e43) + asuint(int(_e40)));
    float _e48 = seven.g;
    seven.g = (_e48 + float(lane_1));
    Eight_cuda_record_3_ _e50 = eight;
    changed = _e50;
    uint _e53 = changed.h;
    changed.h = (_e53 + lane_1);
    Eight_cuda_record_3_ _e55 = changed;
    eight = _e55;
    Five_cuda_record_0_ _e58 = ConstructFive_cuda_record_0_(asint(input.Load(lane_1*20+0)), asuint(input.Load(lane_1*20+4)), asfloat(input.Load(lane_1*20+8)), asuint(input.Load(lane_1*20+12)), asint(input.Load(lane_1*20+16)));
    local_12 = _e58;
    Five_cuda_record_0_ _e60 = local_12;
    local_11 = _e60;
    Five_cuda_record_0_ _e62 = local_11;
    stored = _e62;
    int _e65 = original.e;
    output.Store(base*4, asuint(uint(asint(asuint(_e65) + asuint(int(30))))));
    int _e72 = five.e;
    local = uint((base + 1u));
    uint _e80 = local;
    output.Store(_e80*4, asuint(uint(asint(asuint(_e72) + asuint(int(30))))));
    int _e83 = six.e;
    local_1 = uint((base + 2u));
    uint _e91 = local_1;
    output.Store(_e91*4, asuint(uint(asint(asuint(_e83) + asuint(int(30))))));
    uint _e94 = six.f;
    local_2 = uint((base + 3u));
    uint _e99 = local_2;
    output.Store(_e99*4, asuint(_e94));
    float _e102 = seven.g;
    local_3 = uint((base + 4u));
    uint _e108 = local_3;
    output.Store(_e108*4, asuint(asuint(_e102)));
    float _e111 = saved.g;
    local_4 = uint((base + 5u));
    uint _e117 = local_4;
    output.Store(_e117*4, asuint(asuint(_e111)));
    uint _e120 = eight.h;
    local_5 = uint((base + 6u));
    uint _e125 = local_5;
    output.Store(_e125*4, asuint(_e120));
    uint _e128 = eight.f;
    local_6 = uint((base + 7u));
    uint _e133 = local_6;
    output.Store(_e133*4, asuint(_e128));
    float _e136 = eight.g;
    local_7 = uint((base + 8u));
    uint _e142 = local_7;
    output.Store(_e142*4, asuint(asuint(_e136)));
    int _e145 = eight.e;
    local_8 = uint((base + 9u));
    uint _e153 = local_8;
    output.Store(_e153*4, asuint(uint(asint(asuint(_e145) + asuint(int(30))))));
    uint _e156 = small.value;
    local_9 = uint((base + 10u));
    uint _e161 = local_9;
    output.Store(_e161*4, asuint(_e156));
    int _e165 = stored.a;
    int _e166 = stored.e;
    uint _e170 = stored.b;
    uint _e173 = stored.d;
    float _e176 = stored.c;
    local_10 = uint((base + 11u));
    uint _e183 = local_10;
    output.Store(_e183*4, asuint((((uint(asint(asuint(_e165) + asuint(_e166))) + _e170) + _e173) + naga_f2u32(_e176))));
}
