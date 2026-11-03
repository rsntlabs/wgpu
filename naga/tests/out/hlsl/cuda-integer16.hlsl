struct Record_cuda_record_0_ {
    int16_t signed_value;
    uint16_t unsigned_value;
    uint wide;
    int16_t tail;
    uint16_t tag;
};

struct type_6 {
    uint16_t value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
RWByteAddressBuffer observations : register(u2);
cbuffer count : register(b3) { type_6 count; }

int promoted(int value)
{
    return int(31);
}

int exact(int16_t value_1)
{
    return int(41);
}

int exact_1(uint16_t value_2)
{
    return int(43);
}

int16_t identity_short(int16_t value_3)
{
    return value_3;
}

uint16_t identity_unsigned_u0020_short(uint16_t value_4)
{
    return value_4;
}

int signed_type_u002d_1_()
{
    const int _e1 = exact(int16_t(-1));
    return _e1;
}

int unsigned_type_65535u()
{
    const int _e1 = exact_1(uint16_t(65535));
    return _e1;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_div(int lhs, int rhs) {
    return lhs / (((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

int16_t naga_f2i16(float value) {
    return int16_t(clamp(value, -32768.0, 32767.0));
}

uint16_t naga_f2u16(float value) {
    return uint16_t(clamp(value, 0.0, 65535.0));
}

Record_cuda_record_0_ ConstructRecord_cuda_record_0_(int16_t arg0, uint16_t arg1, uint arg2, int16_t arg3, uint16_t arg4) {
    Record_cuda_record_0_ ret = (Record_cuda_record_0_)0;
    ret.signed_value = arg0;
    ret.unsigned_value = arg1;
    ret.wide = arg2;
    ret.tail = arg3;
    ret.tag = arg4;
    return ret;
}

[numthreads(4, 1, 1)]
void integer16_(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    Record_cuda_record_0_ original = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ result = (Record_cuda_record_0_)0;
    int16_t signed_value = (int16_t)0;
    uint16_t unsigned_value = (uint16_t)0;
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
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int16_t local_16 = (int16_t)0;
    Record_cuda_record_0_ local_17 = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ local_18 = (Record_cuda_record_0_)0;

    uint16_t count_1 = count.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= uint(count_1))) {
        return;
    }
    Record_cuda_record_0_ _e14 = ConstructRecord_cuda_record_0_(input.Load<int16_t>(index*12+0), input.Load<uint16_t>(index*12+2), asuint(input.Load(index*12+4)), input.Load<int16_t>(index*12+8), input.Load<uint16_t>(index*12+10));
    local_18 = _e14;
    Record_cuda_record_0_ _e16 = local_18;
    local_17 = _e16;
    Record_cuda_record_0_ _e18 = local_17;
    original = _e18;
    Record_cuda_record_0_ _e20 = original;
    result = _e20;
    uint16_t _e24 = original.unsigned_value;
    uint16_t _e26 = original.unsigned_value;
    int promoted_sum = asint(asuint(int(_e24)) + asuint(int(_e26)));
    int16_t _e30 = original.signed_value;
    const int16_t _e31 = identity_short(_e30);
    signed_value = _e31;
    uint16_t _e34 = original.unsigned_value;
    const uint16_t _e35 = identity_unsigned_u0020_short(_e34);
    unsigned_value = _e35;
    int16_t _e37 = signed_value;
    signed_value = int16_t(asint(asuint(int(_e37)) + asuint(int(3))));
    int16_t _e45 = signed_value;
    signed_value = int16_t(naga_div(int(_e45), int(int16_t(naga_neg(int(1))))));
    uint16_t _e52 = unsigned_value;
    unsigned_value = uint16_t(asint(asuint(int(_e52)) + asuint(int(uint16_t(int(1))))));
    uint16_t _e57 = unsigned_value;
    local = uint(int(1));
    uint _e62 = local;
    unsigned_value = uint16_t((int(_e57) << _e62));
    int16_t _e65 = signed_value;
    result.signed_value = naga_f2i16(float(_e65));
    uint16_t _e69 = unsigned_value;
    result.unsigned_value = naga_f2u16(float(_e69));
    result.wide = uint(promoted_sum);
    int16_t _e76 = original.tail;
    result.tail = int16_t(~(int(_e76)));
    uint16_t _e82 = original.tag;
    result.tag = uint16_t(asint(asuint(int(_e82)) + asuint(int(1))));
    Record_cuda_record_0_ _e88 = result;
    {
        Record_cuda_record_0_ _value2 = _e88;
        output.Store(index*12+0, _value2.signed_value);
        output.Store(index*12+2, _value2.unsigned_value);
        output.Store(index*12+4, asuint(_value2.wide));
        output.Store(index*12+8, _value2.tail);
        output.Store(index*12+10, _value2.tag);
    }
    uint base = (index * 16u);
    observations.Store(base*4, asuint(uint(promoted_sum)));
    uint16_t _e97 = original.unsigned_value;
    const int _e99 = promoted(int(_e97));
    local_1 = uint((base + 1u));
    uint _e105 = local_1;
    observations.Store(_e105*4, asuint(uint(_e99)));
    int16_t _e108 = original.signed_value;
    const int _e109 = exact(_e108);
    local_2 = uint((base + 2u));
    uint _e115 = local_2;
    observations.Store(_e115*4, asuint(uint(_e109)));
    uint16_t _e118 = original.unsigned_value;
    const int _e119 = exact_1(_e118);
    local_3 = uint((base + 3u));
    uint _e125 = local_3;
    observations.Store(_e125*4, asuint(uint(_e119)));
    const int _e127 = signed_type_u002d_1_();
    local_4 = uint((base + 4u));
    uint _e133 = local_4;
    observations.Store(_e133*4, asuint(uint(_e127)));
    const int _e135 = unsigned_type_65535u();
    local_5 = uint((base + 5u));
    uint _e141 = local_5;
    observations.Store(_e141*4, asuint(uint(_e135)));
    uint16_t _e144 = original.unsigned_value;
    local_6 = uint((base + 6u));
    uint _e151 = local_6;
    observations.Store(_e151*4, asuint(uint(int(_e144))));
    uint16_t _e154 = original.unsigned_value;
    local_7 = uint((base + 7u));
    uint _e162 = local_7;
    observations.Store(_e162*4, asuint(uint(naga_neg(int(_e154)))));
    uint16_t _e165 = original.unsigned_value;
    local_8 = uint((base + 8u));
    uint _e173 = local_8;
    observations.Store(_e173*4, asuint(uint(~(int(_e165)))));
    local_9 = uint((base + 9u));
    uint _e189 = local_9;
    observations.Store(_e189*4, asuint(uint(naga_div(int(int16_t(naga_neg(int(32768)))), int(int16_t(naga_neg(int(1))))))));
    int16_t _e193 = original.signed_value;
    uint16_t _e195 = original.unsigned_value;
    local_10 = uint((base + 10u));
    uint _e203 = local_10;
    observations.Store(_e203*4, asuint(uint((int(_e193) < int(_e195)))));
    int16_t _e206 = original.signed_value;
    local_11 = uint((base + 11u));
    uint _e215 = local_11;
    observations.Store(_e215*4, asuint(uint((uint(_e206) < 1u))));
    int16_t _e218 = result.signed_value;
    local_12 = uint((base + 12u));
    uint _e224 = local_12;
    observations.Store(_e224*4, asuint(uint(_e218)));
    uint16_t _e227 = result.unsigned_value;
    local_13 = uint((base + 13u));
    uint _e233 = local_13;
    observations.Store(_e233*4, asuint(uint(_e227)));
    int16_t _e236 = original.tail;
    local_14 = uint((base + 14u));
    uint _e242 = local_14;
    observations.Store(_e242*4, asuint(uint(_e236)));
    if (((index & 1u) != 0u)) {
        int16_t _e249 = original.signed_value;
        local_16 = _e249;
    } else {
        int16_t _e252 = result.tail;
        local_16 = _e252;
    }
    int16_t _e255 = local_16;
    const int _e256 = exact(_e255);
    local_15 = uint((base + 15u));
    uint _e262 = local_15;
    observations.Store(_e262*4, asuint(uint(_e256)));
}
