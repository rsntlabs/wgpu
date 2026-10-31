RWByteAddressBuffer out_ : register(u0);

int count(uint value)
{
    return int(countbits(value));
}

int scan(int value_1)
{
    return asint(asuint(asint(firstbitlow(value_1))) + asuint(int(1)));
}

int _clz(int first, int second)
{
    return asint(asuint(first) + asuint(second));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(1, 1, 1)]
void integer_intrinsics()
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
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;

    int _e1 = int(true);
    local = uint(int(0));
    uint _e7 = local;
    out_.Store(_e7*4, asuint(uint((_e1 < 0 ? 0 : 31 - asint(firstbithigh(_e1))))));
    local_1 = uint(int(1));
    uint _e16 = local_1;
    out_.Store(_e16*4, asuint(uint((int(8) < 0 ? 0 : 31 - asint(firstbithigh(int(8)))))));
    int _e19 = int(2147483648u);
    local_2 = uint(int(2));
    uint _e25 = local_2;
    out_.Store(_e25*4, asuint(uint((_e19 < 0 ? 0 : 31 - asint(firstbithigh(_e19))))));
    int _e28 = naga_f2i32(8.75);
    local_3 = uint(int(3));
    uint _e34 = local_3;
    out_.Store(_e34*4, asuint(uint((_e28 < 0 ? 0 : 31 - asint(firstbithigh(_e28))))));
    local_4 = uint(int(4));
    uint _e45 = local_4;
    out_.Store(_e45*4, asuint(uint(asint(asuint(asint(firstbitlow(int(true)))) + asuint(int(1))))));
    local_5 = uint(int(5));
    uint _e55 = local_5;
    out_.Store(_e55*4, asuint(uint(asint(asuint(asint(firstbitlow(int(8)))) + asuint(int(1))))));
    local_6 = uint(int(6));
    uint _e66 = local_6;
    out_.Store(_e66*4, asuint(uint(asint(asuint(asint(firstbitlow(int(2147483648u)))) + asuint(int(1))))));
    local_7 = uint(int(7));
    uint _e77 = local_7;
    out_.Store(_e77*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_f2i32(8.75)))) + asuint(int(1))))));
    local_8 = uint(int(8));
    uint _e87 = local_8;
    out_.Store(_e87*4, asuint(uint(int(countbits(uint(true))))));
    local_9 = uint(int(9));
    uint _e98 = local_9;
    out_.Store(_e98*4, asuint(uint(int(countbits(uint(naga_neg(int(1))))))));
    local_10 = uint(int(10));
    uint _e107 = local_10;
    out_.Store(_e107*4, asuint(uint(int(countbits(2147483649u)))));
    local_11 = uint(int(11));
    uint _e117 = local_11;
    out_.Store(_e117*4, asuint(uint(int(countbits(naga_f2u32(3.75))))));
    local_12 = uint(int(12));
    uint _e125 = local_12;
    out_.Store(_e125*4, asuint(reversebits(uint(true))));
    local_13 = uint(int(13));
    uint _e134 = local_13;
    out_.Store(_e134*4, asuint(reversebits(uint(naga_neg(int(1))))));
    local_14 = uint(int(14));
    uint _e141 = local_14;
    out_.Store(_e141*4, asuint(reversebits(19088743u)));
    local_15 = uint(int(15));
    uint _e149 = local_15;
    out_.Store(_e149*4, asuint(reversebits(naga_f2u32(2.75))));
    const int _e152 = count(2147483649u);
    local_16 = uint(int(16));
    uint _e157 = local_16;
    out_.Store(_e157*4, asuint(uint(_e152)));
    const int _e161 = scan(int(2147483648u));
    local_17 = uint(int(17));
    uint _e166 = local_17;
    out_.Store(_e166*4, asuint(uint(_e161)));
    local_18 = uint(int(18));
    uint _e174 = local_18;
    out_.Store(_e174*4, asuint(uint((int(0) < 0 ? 0 : 31 - asint(firstbithigh(int(0)))))));
    local_19 = uint(int(19));
    uint _e184 = local_19;
    out_.Store(_e184*4, asuint(uint(asint(asuint(asint(firstbitlow(int(0)))) + asuint(int(1))))));
    local_20 = uint(int(20));
    uint _e193 = local_20;
    out_.Store(_e193*4, asuint(uint(int(countbits(4294967295u)))));
    local_21 = uint(int(21));
    uint _e200 = local_21;
    out_.Store(_e200*4, asuint(reversebits(0u)));
    local_22 = uint(int(22));
    uint _e207 = local_22;
    out_.Store(_e207*4, asuint(reversebits(1u)));
    local_23 = uint(int(23));
    uint _e214 = local_23;
    out_.Store(_e214*4, asuint(reversebits(2147483648u)));
    int _e217 = naga_neg(int(2));
    local_24 = uint(int(24));
    uint _e223 = local_24;
    out_.Store(_e223*4, asuint(uint((_e217 < 0 ? 0 : 31 - asint(firstbithigh(_e217))))));
    local_25 = uint(int(25));
    uint _e234 = local_25;
    out_.Store(_e234*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_neg(int(2))))) + asuint(int(1))))));
    local_26 = uint(int(26));
    uint _e243 = local_26;
    out_.Store(_e243*4, asuint(uint(int(countbits(2863311530u)))));
    local_27 = uint(int(27));
    uint _e250 = local_27;
    out_.Store(_e250*4, asuint(reversebits(2863311530u)));
    const int _e254 = _clz(int(3), int(4));
    local_28 = uint(int(28));
    uint _e259 = local_28;
    out_.Store(_e259*4, asuint(uint(_e254)));
    local_29 = uint(int(29));
    uint _e272 = local_29;
    out_.Store(_e272*4, asuint(uint((asint(asuint(int(countbits(3u))) - asuint(int(3))) < int(0)))));
}
