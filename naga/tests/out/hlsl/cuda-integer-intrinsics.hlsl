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
    int _e1 = int(true);
    out_.Store(uint(int(0))*4, asuint(uint((_e1 < 0 ? 0 : 31 - asint(firstbithigh(_e1))))));
    out_.Store(uint(int(1))*4, asuint(uint((int(8) < 0 ? 0 : 31 - asint(firstbithigh(int(8)))))));
    int _e15 = int(2147483648u);
    out_.Store(uint(int(2))*4, asuint(uint((_e15 < 0 ? 0 : 31 - asint(firstbithigh(_e15))))));
    int _e22 = naga_f2i32(8.75);
    out_.Store(uint(int(3))*4, asuint(uint((_e22 < 0 ? 0 : 31 - asint(firstbithigh(_e22))))));
    out_.Store(uint(int(4))*4, asuint(uint(asint(asuint(asint(firstbitlow(int(true)))) + asuint(int(1))))));
    out_.Store(uint(int(5))*4, asuint(uint(asint(asuint(asint(firstbitlow(int(8)))) + asuint(int(1))))));
    out_.Store(uint(int(6))*4, asuint(uint(asint(asuint(asint(firstbitlow(int(2147483648u)))) + asuint(int(1))))));
    out_.Store(uint(int(7))*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_f2i32(8.75)))) + asuint(int(1))))));
    out_.Store(uint(int(8))*4, asuint(uint(int(countbits(uint(true))))));
    out_.Store(uint(int(9))*4, asuint(uint(int(countbits(uint(naga_neg(int(1))))))));
    out_.Store(uint(int(10))*4, asuint(uint(int(countbits(2147483649u)))));
    out_.Store(uint(int(11))*4, asuint(uint(int(countbits(naga_f2u32(3.75))))));
    out_.Store(uint(int(12))*4, asuint(reversebits(uint(true))));
    out_.Store(uint(int(13))*4, asuint(reversebits(uint(naga_neg(int(1))))));
    out_.Store(uint(int(14))*4, asuint(reversebits(19088743u)));
    out_.Store(uint(int(15))*4, asuint(reversebits(naga_f2u32(2.75))));
    const int _e120 = count(2147483649u);
    out_.Store(uint(int(16))*4, asuint(uint(_e120)));
    const int _e127 = scan(int(2147483648u));
    out_.Store(uint(int(17))*4, asuint(uint(_e127)));
    out_.Store(uint(int(18))*4, asuint(uint((int(0) < 0 ? 0 : 31 - asint(firstbithigh(int(0)))))));
    out_.Store(uint(int(19))*4, asuint(uint(asint(asuint(asint(firstbitlow(int(0)))) + asuint(int(1))))));
    out_.Store(uint(int(20))*4, asuint(uint(int(countbits(4294967295u)))));
    out_.Store(uint(int(21))*4, asuint(reversebits(0u)));
    out_.Store(uint(int(22))*4, asuint(reversebits(1u)));
    out_.Store(uint(int(23))*4, asuint(reversebits(2147483648u)));
    int _e169 = naga_neg(int(2));
    out_.Store(uint(int(24))*4, asuint(uint((_e169 < 0 ? 0 : 31 - asint(firstbithigh(_e169))))));
    out_.Store(uint(int(25))*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_neg(int(2))))) + asuint(int(1))))));
    out_.Store(uint(int(26))*4, asuint(uint(int(countbits(2863311530u)))));
    out_.Store(uint(int(27))*4, asuint(reversebits(2863311530u)));
    const int _e198 = _clz(int(3), int(4));
    out_.Store(uint(int(28))*4, asuint(uint(_e198)));
    out_.Store(uint(int(29))*4, asuint(uint((asint(asuint(int(countbits(3u))) - asuint(int(3))) < int(0)))));
}
