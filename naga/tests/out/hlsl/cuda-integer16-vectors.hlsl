struct short3_ {
    int16_t x;
    int16_t y;
    int16_t z;
};

struct type_6 {
    uint16_t value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct ushort3_ {
    uint16_t x;
    uint16_t y;
    uint16_t z;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
RWByteAddressBuffer observations : register(u2);
cbuffer count : register(b3) { type_6 count; }

uint promoted(int value)
{
    return 31u;
}

uint field_kind(uint16_t value_1)
{
    return 43u;
}

short3_ identity_short3_(short3_ value_2)
{
    short3_ value_3 = (short3_)0;

    value_3 = value_2;
    short3_ _e2 = value_3;
    const short3_ short3_1 = _e2;
    return short3_1;
}

uint16_t4 identity_ushort4_(uint16_t4 value_4)
{
    uint16_t4 value_5 = (uint16_t4)0;

    value_5 = value_4;
    uint16_t4 _e2 = value_5;
    return _e2;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

ushort3_ Constructushort3_(uint16_t arg0, uint16_t arg1, uint16_t arg2) {
    ushort3_ ret = (ushort3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

short3_ ZeroValueshort3_() {
    return (short3_)0;
}

short3_ Constructshort3_(int16_t arg0, int16_t arg1, int16_t arg2) {
    short3_ ret = (short3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(4, 1, 1)]
void integer16_vectors(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    short3_ signed_triple = (short3_)0;
    int16_t2 signed_pair = (int16_t2)0;
    int16_t4 signed_quad = (int16_t4)0;
    int16_t4 copied_quad = (int16_t4)0;
    uint16_t2 unsigned_pair = (uint16_t2)0;
    ushort3_ unsigned_triple = (ushort3_)0;
    uint16_t4 unsigned_quad = (uint16_t4)0;
    short3_ local = (short3_)0;
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
    short3_ local_16 = (short3_)0;
    short3_ result = (short3_)0;
    short3_ local_17 = (short3_)0;
    short3_ local_18 = (short3_)0;

    uint16_t count_1 = count.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= uint(count_1))) {
        return;
    }
    short3_ _e14 = Constructshort3_(input.Load<int16_t>(index*6+0), input.Load<int16_t>(index*6+2), input.Load<int16_t>(index*6+4));
    local_18 = _e14;
    short3_ _e16 = local_18;
    local_16 = _e16;
    short3_ _e18 = local_16;
    const short3_ _e19 = identity_short3_(_e18);
    signed_triple = _e19;
    int16_t _e22 = signed_triple.x;
    int16_t _e24 = signed_triple.y;
    signed_pair = int16_t2(_e22, _e24);
    int16_t _e28 = signed_triple.x;
    int16_t _e30 = signed_triple.y;
    int16_t _e32 = signed_triple.z;
    signed_quad = int16_t4(_e28, _e30, _e32, int16_t(int(7)));
    int16_t4 _e37 = signed_quad;
    copied_quad = _e37;
    int16_t _e40 = signed_triple.x;
    int16_t _e42 = copied_quad.w;
    copied_quad.w = int16_t(asint(asuint(int(_e42)) + asuint(int(_e40))));
    int16_t _e48 = signed_triple.x;
    int16_t _e50 = signed_triple.y;
    unsigned_pair = uint16_t2(uint16_t(_e48), uint16_t(_e50));
    uint16_t _e56 = unsigned_pair.x;
    unsigned_pair.x = uint16_t(asint(asuint(int(_e56)) + asuint(int(1))));
    uint16_t _e62 = unsigned_pair.y;
    unsigned_pair.y = uint16_t(asint(asuint(int(_e62)) + asuint(int(1))));
    int16_t _e68 = signed_triple.x;
    int16_t _e70 = signed_triple.y;
    int16_t _e72 = signed_triple.z;
    unsigned_triple = Constructushort3_(uint16_t(_e68), uint16_t(_e70), uint16_t(_e72));
    int16_t _e79 = signed_triple.z;
    int16_t _e81 = signed_triple.y;
    int16_t _e83 = signed_triple.x;
    const uint16_t4 _e90 = identity_ushort4_(uint16_t4(uint16_t(_e79), uint16_t(_e81), uint16_t(_e83), uint16_t(65535u)));
    unsigned_quad = _e90;
    uint16_t _e93 = unsigned_quad.w;
    unsigned_quad.w = uint16_t(asint(asuint(int(_e93)) + asuint(int(2))));
    result = ZeroValueshort3_();
    short3_ _e100 = signed_triple;
    local_17 = _e100;
    short3_ _e102 = local_17;
    result = _e102;
    int16_t _e105 = result.x;
    result.x = int16_t(asint(asuint(int(_e105)) + asuint(int(3))));
    int16_t _e111 = result.y;
    result.y = int16_t(naga_neg(int(_e111)));
    int16_t _e117 = result.z;
    result.z = int16_t((int(_e117) ^ int(4951)));
    short3_ _e122 = result;
    local = _e122;
    short3_ _e124 = local;
    {
        short3_ _value2 = _e124;
        output.Store(index*6+0, _value2.x);
        output.Store(index*6+2, _value2.y);
        output.Store(index*6+4, _value2.z);
    }
    uint base = (index * 16u);
    int16_t _e130 = signed_pair.x;
    observations.Store(base*4, asuint(uint(_e130)));
    int16_t _e135 = signed_pair.y;
    local_1 = uint((base + 1u));
    uint _e141 = local_1;
    observations.Store(_e141*4, asuint(uint(_e135)));
    int16_t _e144 = copied_quad.x;
    local_2 = uint((base + 2u));
    uint _e150 = local_2;
    observations.Store(_e150*4, asuint(uint(_e144)));
    int16_t _e153 = copied_quad.y;
    local_3 = uint((base + 3u));
    uint _e159 = local_3;
    observations.Store(_e159*4, asuint(uint(_e153)));
    int16_t _e162 = copied_quad.z;
    local_4 = uint((base + 4u));
    uint _e168 = local_4;
    observations.Store(_e168*4, asuint(uint(_e162)));
    int16_t _e171 = copied_quad.w;
    local_5 = uint((base + 5u));
    uint _e177 = local_5;
    observations.Store(_e177*4, asuint(uint(_e171)));
    uint16_t _e180 = unsigned_pair.x;
    local_6 = uint((base + 6u));
    uint _e186 = local_6;
    observations.Store(_e186*4, asuint(uint(_e180)));
    uint16_t _e189 = unsigned_pair.y;
    local_7 = uint((base + 7u));
    uint _e195 = local_7;
    observations.Store(_e195*4, asuint(uint(_e189)));
    uint16_t _e199 = unsigned_triple.y;
    uint16_t _e203 = unsigned_triple.x;
    local_8 = uint((base + 8u));
    uint _e211 = local_8;
    observations.Store(_e211*4, asuint(uint(asint(asuint(int(_e203)) + asuint(asint(asuint(int(3)) * asuint(int(_e199))))))));
    uint16_t _e214 = unsigned_triple.z;
    local_9 = uint((base + 9u));
    uint _e220 = local_9;
    observations.Store(_e220*4, asuint(uint(_e214)));
    uint16_t _e223 = unsigned_quad.x;
    local_10 = uint((base + 10u));
    uint _e229 = local_10;
    observations.Store(_e229*4, asuint(uint(_e223)));
    uint16_t _e232 = unsigned_quad.y;
    local_11 = uint((base + 11u));
    uint _e238 = local_11;
    observations.Store(_e238*4, asuint(uint(_e232)));
    uint16_t _e241 = unsigned_quad.z;
    local_12 = uint((base + 12u));
    uint _e247 = local_12;
    observations.Store(_e247*4, asuint(uint(_e241)));
    uint16_t _e250 = unsigned_quad.w;
    local_13 = uint((base + 13u));
    uint _e256 = local_13;
    observations.Store(_e256*4, asuint(uint(_e250)));
    uint16_t _e259 = unsigned_triple.x;
    const uint _e261 = promoted(int(_e259));
    local_14 = uint((base + 14u));
    uint _e266 = local_14;
    observations.Store(_e266*4, asuint(_e261));
    uint16_t _e269 = unsigned_triple.z;
    const uint _e270 = field_kind(_e269);
    local_15 = uint((base + 15u));
    uint _e275 = local_15;
    observations.Store(_e275*4, asuint(_e270));
}
