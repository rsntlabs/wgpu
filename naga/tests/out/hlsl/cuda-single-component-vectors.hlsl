struct int1_ {
    int x;
};

struct float1_ {
    float x;
};

struct uint1_ {
    uint x;
};

struct short1_ {
    int16_t x;
};

struct ushort1_ {
    uint16_t x;
};

struct type_7 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
RWByteAddressBuffer observations : register(u2);
cbuffer count : register(b3) { type_7 count; }

uint kind(float1_ value)
{
    float1_ value_1 = (float1_)0;

    value_1 = value;
    return 11u;
}

uint kind_1(int1_ value_2)
{
    int1_ value_3 = (int1_)0;

    value_3 = value_2;
    return 13u;
}

uint kind_2(uint1_ value_4)
{
    uint1_ value_5 = (uint1_)0;

    value_5 = value_4;
    return 17u;
}

uint kind_3(short1_ value_6)
{
    short1_ value_7 = (short1_)0;

    value_7 = value_6;
    return 19u;
}

uint kind_4(ushort1_ value_8)
{
    ushort1_ value_9 = (ushort1_)0;

    value_9 = value_8;
    return 23u;
}

uint kind_5(float value_10)
{
    return 31u;
}

uint kind_6(int value_11)
{
    return 37u;
}

uint kind_7(uint value_12)
{
    return 41u;
}

uint kind_8(int16_t value_13)
{
    return 43u;
}

uint kind_9(uint16_t value_14)
{
    return 47u;
}

int1_ identity_int1_(int1_ value_15)
{
    int1_ value_16 = (int1_)0;

    value_16 = value_15;
    int1_ _e2 = value_16;
    const int1_ int1_1 = _e2;
    return int1_1;
}

uint1_ identity_uint1_(uint1_ value_17)
{
    uint1_ value_18 = (uint1_)0;

    value_18 = value_17;
    uint1_ _e2 = value_18;
    const uint1_ uint1_1 = _e2;
    return uint1_1;
}

int1_ Constructint1_(int arg0) {
    int1_ ret = (int1_)0;
    ret.x = arg0;
    return ret;
}

uint1_ Constructuint1_(uint arg0) {
    uint1_ ret = (uint1_)0;
    ret.x = arg0;
    return ret;
}

float1_ Constructfloat1_(float arg0) {
    float1_ ret = (float1_)0;
    ret.x = arg0;
    return ret;
}

short1_ Constructshort1_(int16_t arg0) {
    short1_ ret = (short1_)0;
    ret.x = arg0;
    return ret;
}

ushort1_ Constructushort1_(uint16_t arg0) {
    ushort1_ ret = (ushort1_)0;
    ret.x = arg0;
    return ret;
}

int1_ ZeroValueint1_() {
    return (int1_)0;
}

[numthreads(4, 1, 1)]
void single_component_vectors(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    int1_ signed_value = (int1_)0;
    uint1_ unsigned_value = (uint1_)0;
    float1_ floating = (float1_)0;
    short1_ signed_half = (short1_)0;
    ushort1_ unsigned_half = (ushort1_)0;
    int1_ changed = (int1_)0;
    int1_ local = (int1_)0;
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
    int1_ result = (int1_)0;
    int1_ local_16 = (int1_)0;

    uint count_1 = count.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    int _e14 = asint(input.Load(0+index*4));
    const int1_ _e16 = identity_int1_(Constructint1_(_e14));
    signed_value = _e16;
    int _e19 = signed_value.x;
    const uint1_ _e22 = identity_uint1_(Constructuint1_(uint(_e19)));
    unsigned_value = _e22;
    int _e25 = signed_value.x;
    floating = Constructfloat1_((float((_e25 & int(7))) + 0.5));
    int _e34 = signed_value.x;
    signed_half = Constructshort1_(int16_t(_e34));
    int _e39 = signed_value.x;
    unsigned_half = Constructushort1_(uint16_t(_e39));
    int16_t _e44 = signed_half.x;
    signed_half.x = int16_t(asint(asuint(int(_e44)) + asuint(int(1))));
    uint16_t _e50 = unsigned_half.x;
    unsigned_half.x = uint16_t(asint(asuint(int(_e50)) + asuint(int(1))));
    result = ZeroValueint1_();
    int1_ _e57 = signed_value;
    local_16 = _e57;
    int1_ _e59 = local_16;
    result = _e59;
    int _e62 = result.x;
    result.x = (_e62 ^ int(324508639));
    int1_ _e65 = result;
    local = _e65;
    int1_ _e67 = local;
    changed = _e67;
    int1_ _e69 = changed;
    {
        int1_ _value2 = _e69;
        output.Store(index*4+0, asuint(_value2.x));
    }
    uint base = (index * 16u);
    int _e75 = signed_value.x;
    observations.Store(base*4, asuint(uint(_e75)));
    int _e80 = changed.x;
    local_1 = uint((base + 1u));
    uint _e86 = local_1;
    observations.Store(_e86*4, asuint(uint(_e80)));
    uint _e89 = unsigned_value.x;
    local_2 = uint((base + 2u));
    uint _e94 = local_2;
    observations.Store(_e94*4, asuint(_e89));
    float _e97 = floating.x;
    local_3 = uint((base + 3u));
    uint _e103 = local_3;
    observations.Store(_e103*4, asuint(asuint(_e97)));
    int16_t _e106 = signed_half.x;
    local_4 = uint((base + 4u));
    uint _e112 = local_4;
    observations.Store(_e112*4, asuint(uint(_e106)));
    uint16_t _e115 = unsigned_half.x;
    local_5 = uint((base + 5u));
    uint _e121 = local_5;
    observations.Store(_e121*4, asuint(uint(_e115)));
    float1_ _e123 = floating;
    const uint _e124 = kind(_e123);
    local_6 = uint((base + 6u));
    uint _e129 = local_6;
    observations.Store(_e129*4, asuint(_e124));
    int1_ _e131 = signed_value;
    const uint _e132 = kind_1(_e131);
    local_7 = uint((base + 7u));
    uint _e137 = local_7;
    observations.Store(_e137*4, asuint(_e132));
    uint1_ _e139 = unsigned_value;
    const uint _e140 = kind_2(_e139);
    local_8 = uint((base + 8u));
    uint _e145 = local_8;
    observations.Store(_e145*4, asuint(_e140));
    short1_ _e147 = signed_half;
    const uint _e148 = kind_3(_e147);
    local_9 = uint((base + 9u));
    uint _e153 = local_9;
    observations.Store(_e153*4, asuint(_e148));
    ushort1_ _e155 = unsigned_half;
    const uint _e156 = kind_4(_e155);
    local_10 = uint((base + 10u));
    uint _e161 = local_10;
    observations.Store(_e161*4, asuint(_e156));
    float _e164 = floating.x;
    const uint _e165 = kind_5(_e164);
    local_11 = uint((base + 11u));
    uint _e170 = local_11;
    observations.Store(_e170*4, asuint(_e165));
    int _e173 = signed_value.x;
    const uint _e174 = kind_6(_e173);
    local_12 = uint((base + 12u));
    uint _e179 = local_12;
    observations.Store(_e179*4, asuint(_e174));
    uint _e182 = unsigned_value.x;
    const uint _e183 = kind_7(_e182);
    local_13 = uint((base + 13u));
    uint _e188 = local_13;
    observations.Store(_e188*4, asuint(_e183));
    int16_t _e191 = signed_half.x;
    const uint _e192 = kind_8(_e191);
    local_14 = uint((base + 14u));
    uint _e197 = local_14;
    observations.Store(_e197*4, asuint(_e192));
    uint16_t _e200 = unsigned_half.x;
    const uint _e201 = kind_9(_e200);
    local_15 = uint((base + 15u));
    uint _e206 = local_15;
    observations.Store(_e206*4, asuint(_e201));
}
