struct One_cuda_record_0_ {
    int x;
};

struct Two_cuda_record_1_ {
    uint x;
    float y;
};

struct Trio_cuda_record_2_ {
    int x;
    uint y;
    float z;
};

struct Four_cuda_record_3_ {
    int x;
    uint y;
    float z;
    uint w;
};

struct Twin_cuda_record_4_ {
    int x;
    uint y;
    float z;
};

struct type_4 {
    One_cuda_record_0_ value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct type_5 {
    Two_cuda_record_1_ value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_6 {
    Trio_cuda_record_2_ value;
    int _end_pad_0;
};

struct type_7 {
    Four_cuda_record_3_ value;
};

RWByteAddressBuffer output : register(u0);
cbuffer one_1 : register(b1) { type_4 one_1; }
cbuffer two_1 : register(b2) { type_5 two_1; }
cbuffer three_1 : register(b3) { type_6 three_1; }
cbuffer four_1 : register(b4) { type_7 four_1; }
ByteAddressBuffer input : register(t5);

uint kind(Trio_cuda_record_2_ param)
{
    return 11u;
}

uint kind_1(Twin_cuda_record_4_ param_1)
{
    return 22u;
}

uint ZeroValueuint() {
    return (uint)0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

Trio_cuda_record_2_ ConstructTrio_cuda_record_2_(int arg0, uint arg1, float arg2) {
    Trio_cuda_record_2_ ret = (Trio_cuda_record_2_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(4, 1, 1)]
void record_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    One_cuda_record_0_ one = (One_cuda_record_0_)0;
    Two_cuda_record_1_ two = (Two_cuda_record_1_)0;
    Trio_cuda_record_2_ three = (Trio_cuda_record_2_)0;
    Four_cuda_record_3_ four = (Four_cuda_record_3_)0;
    Trio_cuda_record_2_ original = (Trio_cuda_record_2_)0;
    Four_cuda_record_3_ changed = (Four_cuda_record_3_)0;
    Twin_cuda_record_4_ other = (Twin_cuda_record_4_)0;
    Trio_cuda_record_2_ stored = (Trio_cuda_record_2_)0;
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
    Trio_cuda_record_2_ local_11 = (Trio_cuda_record_2_)0;
    Trio_cuda_record_2_ local_12 = (Trio_cuda_record_2_)0;

    One_cuda_record_0_ _e4 = one_1.value;
    one = _e4;
    Two_cuda_record_1_ _e8 = two_1.value;
    two = _e8;
    Trio_cuda_record_2_ _e12 = three_1.value;
    three = _e12;
    Four_cuda_record_3_ _e16 = four_1.value;
    four = _e16;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 12u));
    Trio_cuda_record_2_ _e29 = three;
    original = _e29;
    int _e33 = one.x;
    one.x = asint(asuint(_e33) + asuint(int(lane_1)));
    lane = ZeroValueuint();
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = three.y;
    three.y = (_e40 + _e38);
    int _e45 = three.x;
    three.x = asint(asuint(_e45) - asuint(int(lane_1)));
    Four_cuda_record_3_ _e47 = four;
    changed = _e47;
    int _e51 = changed.x;
    changed.x = asint(asuint(_e51) + asuint(int(lane_1)));
    uint _e54 = changed.y;
    changed.y = (_e54 + 1u);
    float _e58 = changed.z;
    changed.z = (_e58 * 2.0);
    Four_cuda_record_3_ _e61 = changed;
    four = _e61;
    int _e63 = original.x;
    other.x = _e63;
    uint _e67 = original.y;
    other.y = _e67;
    float _e70 = original.z;
    other.z = _e70;
    Trio_cuda_record_2_ _e74 = ConstructTrio_cuda_record_2_(asint(input.Load(lane_1*12+0)), asuint(input.Load(lane_1*12+4)), asfloat(input.Load(lane_1*12+8)));
    local_12 = _e74;
    Trio_cuda_record_2_ _e76 = local_12;
    local_11 = _e76;
    Trio_cuda_record_2_ _e78 = local_11;
    stored = _e78;
    int _e81 = one.x;
    output.Store(base*4, asuint(uint(asint(asuint(_e81) + asuint(int(10))))));
    uint _e88 = two.x;
    local = uint((base + 1u));
    uint _e93 = local;
    output.Store(_e93*4, asuint(_e88));
    float _e96 = two.y;
    local_1 = uint((base + 2u));
    uint _e102 = local_1;
    output.Store(_e102*4, asuint(asuint(_e96)));
    int _e105 = three.x;
    local_2 = uint((base + 3u));
    uint _e113 = local_2;
    output.Store(_e113*4, asuint(uint(asint(asuint(_e105) + asuint(int(20))))));
    uint _e116 = three.y;
    local_3 = uint((base + 4u));
    uint _e121 = local_3;
    output.Store(_e121*4, asuint(_e116));
    float _e124 = three.z;
    local_4 = uint((base + 5u));
    uint _e130 = local_4;
    output.Store(_e130*4, asuint(asuint(_e124)));
    int _e133 = four.x;
    local_5 = uint((base + 6u));
    uint _e141 = local_5;
    output.Store(_e141*4, asuint(uint(asint(asuint(_e133) + asuint(int(20))))));
    uint _e144 = four.y;
    local_6 = uint((base + 7u));
    uint _e149 = local_6;
    output.Store(_e149*4, asuint(_e144));
    float _e152 = four.z;
    local_7 = uint((base + 8u));
    uint _e158 = local_7;
    output.Store(_e158*4, asuint(asuint(_e152)));
    uint _e161 = four.w;
    local_8 = uint((base + 9u));
    uint _e166 = local_8;
    output.Store(_e166*4, asuint(_e161));
    uint _e169 = original.y;
    local_9 = uint((base + 10u));
    uint _e174 = local_9;
    output.Store(_e174*4, asuint(_e169));
    Trio_cuda_record_2_ _e176 = three;
    const uint _e177 = kind(_e176);
    Twin_cuda_record_4_ _e178 = other;
    const uint _e179 = kind_1(_e178);
    int _e182 = stored.x;
    uint _e186 = stored.y;
    float _e189 = stored.z;
    local_10 = uint((base + 11u));
    uint _e196 = local_10;
    output.Store(_e196*4, asuint(((((_e177 + _e179) + uint(_e182)) + _e186) + naga_f2u32(_e189))));
}
