RWByteAddressBuffer out_ : register(u0);

float from_bits(uint value_1)
{
    return asfloat(value_1);
}

int _float_as_int(int first, int second)
{
    return asint(asuint(first) + asuint(second));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(1, 1, 1)]
void bitcasts()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int local_9 = (int)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    uint local_12 = (uint)0;
    int local_13 = (int)0;
    uint local_14 = (uint)0;
    int local_15 = (int)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    float value = (float)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    int signed_bits = (int)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint unsigned_bits = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    int local_35 = (int)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;

    local = uint(int(0));
    uint _e7 = local;
    out_.Store(_e7*4, asuint(uint(asint(float(true)))));
    local_1 = uint(int(1));
    uint _e17 = local_1;
    out_.Store(_e17*4, asuint(uint(asint(float(int(3))))));
    local_2 = uint(int(2));
    uint _e26 = local_2;
    out_.Store(_e26*4, asuint(uint(asint(float(5u)))));
    local_3 = uint(int(3));
    uint _e34 = local_3;
    out_.Store(_e34*4, asuint(uint(asint(2.75))));
    local_4 = uint(int(4));
    uint _e42 = local_4;
    out_.Store(_e42*4, asuint(asuint(float(true))));
    local_5 = uint(int(5));
    uint _e50 = local_5;
    out_.Store(_e50*4, asuint(asuint(float(int(3)))));
    local_6 = uint(int(6));
    uint _e58 = local_6;
    out_.Store(_e58*4, asuint(asuint(float(5u))));
    local_7 = uint(int(7));
    uint _e65 = local_7;
    out_.Store(_e65*4, asuint(asuint(2.75)));
    local_9 = int(true);
    int _e70 = local_9;
    local_8 = uint(int(8));
    uint _e76 = local_8;
    out_.Store(_e76*4, asuint(asuint(asfloat(_e70))));
    local_11 = int(3);
    int _e80 = local_11;
    local_10 = uint(int(9));
    uint _e86 = local_10;
    out_.Store(_e86*4, asuint(asuint(asfloat(_e80))));
    local_13 = int(5u);
    int _e91 = local_13;
    local_12 = uint(int(10));
    uint _e97 = local_12;
    out_.Store(_e97*4, asuint(asuint(asfloat(_e91))));
    local_15 = naga_f2i32(2.75);
    int _e102 = local_15;
    local_14 = uint(int(11));
    uint _e108 = local_14;
    out_.Store(_e108*4, asuint(asuint(asfloat(_e102))));
    local_17 = uint(true);
    uint _e113 = local_17;
    local_16 = uint(int(12));
    uint _e119 = local_16;
    out_.Store(_e119*4, asuint(asuint(asfloat(_e113))));
    local_19 = uint(int(3));
    uint _e124 = local_19;
    local_18 = uint(int(13));
    uint _e130 = local_18;
    out_.Store(_e130*4, asuint(asuint(asfloat(_e124))));
    local_21 = 5u;
    uint _e134 = local_21;
    local_20 = uint(int(14));
    uint _e140 = local_20;
    out_.Store(_e140*4, asuint(asuint(asfloat(_e134))));
    local_23 = naga_f2u32(2.75);
    uint _e145 = local_23;
    local_22 = uint(int(15));
    uint _e151 = local_22;
    out_.Store(_e151*4, asuint(asuint(asfloat(_e145))));
    value = 1.5;
    float _e155 = value;
    value = (_e155 + float(int(1)));
    local_24 = uint(int(16));
    uint _e164 = local_24;
    out_.Store(_e164*4, asuint(uint(asint(_e155))));
    float _e166 = value;
    local_25 = uint(int(17));
    uint _e171 = local_25;
    out_.Store(_e171*4, asuint(asuint(_e166)));
    float _e173 = value;
    value = (_e173 + float(int(1)));
    local_26 = uint(int(18));
    uint _e181 = local_26;
    out_.Store(_e181*4, asuint(asuint(_e173)));
    float _e183 = value;
    local_27 = uint(int(19));
    uint _e188 = local_27;
    out_.Store(_e188*4, asuint(asuint(_e183)));
    signed_bits = int(1065353216);
    int _e192 = signed_bits;
    signed_bits = asint(asuint(_e192) + asuint(int(1)));
    local_28 = uint(int(20));
    uint _e200 = local_28;
    out_.Store(_e200*4, asuint(asuint(asfloat(_e192))));
    int _e202 = signed_bits;
    local_29 = uint(int(21));
    uint _e207 = local_29;
    out_.Store(_e207*4, asuint(uint(_e202)));
    unsigned_bits = 1073741824u;
    uint _e211 = unsigned_bits;
    unsigned_bits = (_e211 + uint(int(1)));
    local_30 = uint(int(22));
    uint _e220 = local_30;
    out_.Store(_e220*4, asuint(asuint(asfloat(_e211))));
    uint _e222 = unsigned_bits;
    local_31 = uint(int(23));
    uint _e226 = local_31;
    out_.Store(_e226*4, asuint(_e222));
    const int _e230 = _float_as_int(int(3), int(4));
    local_32 = uint(int(24));
    uint _e235 = local_32;
    out_.Store(_e235*4, asuint(uint(_e230)));
    const float _e238 = from_bits(3212836864u);
    local_33 = uint(int(25));
    uint _e243 = local_33;
    out_.Store(_e243*4, asuint(asuint(_e238)));
    local_35 = int(2139095040);
    int _e247 = local_35;
    local_34 = uint(int(26));
    uint _e253 = local_34;
    out_.Store(_e253*4, asuint(asuint(asfloat(_e247))));
    local_37 = 2143363909u;
    uint _e257 = local_37;
    local_36 = uint(int(27));
    uint _e263 = local_36;
    out_.Store(_e263*4, asuint(asuint(asfloat(_e257))));
    local_39 = naga_f2u32(1065353200.0);
    uint _e268 = local_39;
    local_38 = uint(int(28));
    uint _e274 = local_38;
    out_.Store(_e274*4, asuint(asuint(asfloat(_e268))));
    local_40 = uint(int(29));
    uint _e283 = local_40;
    out_.Store(_e283*4, asuint(uint(asint(float(1u)))));
}
