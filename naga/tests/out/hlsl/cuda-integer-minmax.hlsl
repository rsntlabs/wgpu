RWByteAddressBuffer out_ : register(u0);

int min_(int first_1, int second_1, int third)
{
    return asint(asuint(asint(asuint(asint(asuint(first_1) + asuint(second_1))) + asuint(third))) + asuint(int(100)));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int bounded(int value_1)
{
    return min(max(value_1, naga_neg(int(2))), int(2));
}

[numthreads(1, 1, 1)]
void integer_minmax()
{
    int first = (int)0;
    int second = (int)0;
    int value = (int)0;

    int seed = asint(out_.Load(uint(int(0))*4));
    out_.Store(uint(int(0))*4, asuint(min(seed, naga_neg(int(7)))));
    out_.Store(uint(int(1))*4, asuint(max(seed, naga_neg(int(7)))));
    out_.Store(uint(int(2))*4, asuint(int(min(3u, 9u))));
    out_.Store(uint(int(3))*4, asuint(int(max(3u, 9u))));
    out_.Store(uint(int(4))*4, asuint(int((min(uint(naga_neg(int(1))), 2u) == 2u))));
    out_.Store(uint(int(5))*4, asuint(int((max(uint(naga_neg(int(1))), 2u) == 4294967295u))));
    out_.Store(uint(int(6))*4, asuint(int((min(2u, uint(naga_neg(int(1)))) == 2u))));
    out_.Store(uint(int(7))*4, asuint(int((max(2u, uint(naga_neg(int(1)))) == 4294967295u))));
    out_.Store(uint(int(8))*4, asuint(min(int(true), int(false))));
    out_.Store(uint(int(9))*4, asuint(max(int(false), int(true))));
    out_.Store(uint(int(10))*4, asuint(min(max(seed, naga_neg(int(5))), int(2))));
    out_.Store(uint(int(11))*4, asuint(int((min(uint(naga_neg(int(2))), 4u) == 4u))));
    const int _e112 = min_(seed, int(4), int(5));
    out_.Store(uint(int(12))*4, asuint(_e112));
    const int _e116 = bounded(seed);
    out_.Store(uint(int(13))*4, asuint(_e116));
    first = int(3);
    second = int(7);
    int _e124 = first;
    first = asint(asuint(_e124) + asuint(int(1)));
    int _e127 = second;
    second = asint(asuint(_e127) + asuint(int(1)));
    out_.Store(uint(int(14))*4, asuint(max(_e124, _e127)));
    int _e134 = first;
    out_.Store(uint(int(15))*4, asuint(_e134));
    int _e138 = second;
    out_.Store(uint(int(16))*4, asuint(_e138));
    value = seed;
    int _e143 = value;
    int _e144 = value;
    value = asint(asuint(_e144) + asuint(int(1)));
    out_.Store(uint(int(17))*4, asuint(max(_e143, _e144)));
    int _e151 = value;
    out_.Store(uint(int(18))*4, asuint(_e151));
    out_.Store(uint(int(19))*4, asuint(int((min(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1))), int(2147483647)) == asint(asuint(naga_neg(int(2147483647))) - asuint(int(1)))))));
    out_.Store(uint(int(20))*4, asuint(int((max(4294967295u, 0u) == 4294967295u))));
    out_.Store(uint(int(21))*4, asuint(int((min(uint(false), 3u) == 0u))));
    out_.Store(uint(int(22))*4, asuint(int((max(uint(true), 0u) == 1u))));
    out_.Store(uint(int(23))*4, asuint(min(seed, seed)));
}
