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
    int local = (int)0;
    int local_1 = (int)0;
    int local_2 = (int)0;
    int local_3 = (int)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    float value = (float)0;
    int signed_bits = (int)0;
    uint unsigned_bits = (uint)0;
    int local_8 = (int)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    int local_12 = (int)0;
    int local_13 = (int)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;

    out_.Store(uint(int(0))*4, asuint(uint(asint(float(true)))));
    out_.Store(uint(int(1))*4, asuint(uint(asint(float(int(3))))));
    out_.Store(uint(int(2))*4, asuint(uint(asint(float(5u)))));
    out_.Store(uint(int(3))*4, asuint(uint(asint(2.75))));
    out_.Store(uint(int(4))*4, asuint(asuint(float(true))));
    out_.Store(uint(int(5))*4, asuint(asuint(float(int(3)))));
    out_.Store(uint(int(6))*4, asuint(asuint(float(5u))));
    out_.Store(uint(int(7))*4, asuint(asuint(2.75)));
    local = int(true);
    int _e54 = local;
    out_.Store(uint(int(8))*4, asuint(asuint(asfloat(_e54))));
    local_1 = int(3);
    int _e62 = local_1;
    out_.Store(uint(int(9))*4, asuint(asuint(asfloat(_e62))));
    local_2 = int(5u);
    int _e71 = local_2;
    out_.Store(uint(int(10))*4, asuint(asuint(asfloat(_e71))));
    local_3 = naga_f2i32(2.75);
    int _e80 = local_3;
    out_.Store(uint(int(11))*4, asuint(asuint(asfloat(_e80))));
    local_4 = uint(true);
    uint _e89 = local_4;
    out_.Store(uint(int(12))*4, asuint(asuint(asfloat(_e89))));
    local_5 = uint(int(3));
    uint _e98 = local_5;
    out_.Store(uint(int(13))*4, asuint(asuint(asfloat(_e98))));
    local_6 = 5u;
    uint _e106 = local_6;
    out_.Store(uint(int(14))*4, asuint(asuint(asfloat(_e106))));
    local_7 = naga_f2u32(2.75);
    uint _e115 = local_7;
    out_.Store(uint(int(15))*4, asuint(asuint(asfloat(_e115))));
    value = 1.5;
    float _e123 = value;
    value = (_e123 + float(int(1)));
    out_.Store(uint(int(16))*4, asuint(uint(asint(_e123))));
    float _e132 = value;
    out_.Store(uint(int(17))*4, asuint(asuint(_e132)));
    float _e137 = value;
    value = (_e137 + float(int(1)));
    out_.Store(uint(int(18))*4, asuint(asuint(_e137)));
    float _e145 = value;
    out_.Store(uint(int(19))*4, asuint(asuint(_e145)));
    signed_bits = int(1065353216);
    int _e152 = signed_bits;
    signed_bits = asint(asuint(_e152) + asuint(int(1)));
    out_.Store(uint(int(20))*4, asuint(asuint(asfloat(_e152))));
    int _e160 = signed_bits;
    out_.Store(uint(int(21))*4, asuint(uint(_e160)));
    unsigned_bits = 1073741824u;
    uint _e167 = unsigned_bits;
    unsigned_bits = (_e167 + uint(int(1)));
    out_.Store(uint(int(22))*4, asuint(asuint(asfloat(_e167))));
    uint _e176 = unsigned_bits;
    out_.Store(uint(int(23))*4, asuint(_e176));
    const int _e182 = _float_as_int(int(3), int(4));
    out_.Store(uint(int(24))*4, asuint(uint(_e182)));
    const float _e188 = from_bits(3212836864u);
    out_.Store(uint(int(25))*4, asuint(asuint(_e188)));
    local_8 = int(2139095040);
    int _e195 = local_8;
    out_.Store(uint(int(26))*4, asuint(asuint(asfloat(_e195))));
    local_9 = 2143363909u;
    uint _e203 = local_9;
    out_.Store(uint(int(27))*4, asuint(asuint(asfloat(_e203))));
    local_10 = naga_f2u32(1065353200.0);
    uint _e212 = local_10;
    out_.Store(uint(int(28))*4, asuint(asuint(asfloat(_e212))));
    out_.Store(uint(int(29))*4, asuint(uint(asint(float(1u)))));
    out_.Store(uint(int(30))*4, asuint(uint(asint(float(true)))));
    out_.Store(uint(int(31))*4, asuint(uint(asint(float(int(3))))));
    out_.Store(uint(int(32))*4, asuint(uint(asint(float(5u)))));
    out_.Store(uint(int(33))*4, asuint(uint(asint(2.75))));
    out_.Store(uint(int(34))*4, asuint(asuint(float(true))));
    out_.Store(uint(int(35))*4, asuint(asuint(float(int(3)))));
    out_.Store(uint(int(36))*4, asuint(asuint(float(5u))));
    out_.Store(uint(int(37))*4, asuint(asuint(2.75)));
    local_11 = int(true);
    int _e278 = local_11;
    out_.Store(uint(int(38))*4, asuint(asuint(asfloat(_e278))));
    local_12 = int(3);
    int _e286 = local_12;
    out_.Store(uint(int(39))*4, asuint(asuint(asfloat(_e286))));
    local_13 = int(5u);
    int _e295 = local_13;
    out_.Store(uint(int(40))*4, asuint(asuint(asfloat(_e295))));
    local_14 = naga_f2i32(2.75);
    int _e304 = local_14;
    out_.Store(uint(int(41))*4, asuint(asuint(asfloat(_e304))));
    local_15 = uint(true);
    uint _e313 = local_15;
    out_.Store(uint(int(42))*4, asuint(asuint(asfloat(_e313))));
    local_16 = uint(int(3));
    uint _e322 = local_16;
    out_.Store(uint(int(43))*4, asuint(asuint(asfloat(_e322))));
    local_17 = 5u;
    uint _e330 = local_17;
    out_.Store(uint(int(44))*4, asuint(asuint(asfloat(_e330))));
    local_18 = naga_f2u32(2.75);
    uint _e339 = local_18;
    out_.Store(uint(int(45))*4, asuint(asuint(asfloat(_e339))));
    value = 1.5;
    float _e346 = value;
    value = (_e346 + float(int(1)));
    out_.Store(uint(int(46))*4, asuint(uint(asint(_e346))));
    float _e355 = value;
    out_.Store(uint(int(47))*4, asuint(asuint(_e355)));
    float _e360 = value;
    value = (_e360 + float(int(1)));
    out_.Store(uint(int(48))*4, asuint(asuint(_e360)));
    float _e368 = value;
    out_.Store(uint(int(49))*4, asuint(asuint(_e368)));
    signed_bits = int(1065353216);
    int _e374 = signed_bits;
    signed_bits = asint(asuint(_e374) + asuint(int(1)));
    out_.Store(uint(int(50))*4, asuint(asuint(asfloat(_e374))));
    int _e382 = signed_bits;
    out_.Store(uint(int(51))*4, asuint(uint(_e382)));
    unsigned_bits = 1073741824u;
    uint _e388 = unsigned_bits;
    unsigned_bits = (_e388 + uint(int(1)));
    out_.Store(uint(int(52))*4, asuint(asuint(asfloat(_e388))));
    uint _e397 = unsigned_bits;
    out_.Store(uint(int(53))*4, asuint(_e397));
}
