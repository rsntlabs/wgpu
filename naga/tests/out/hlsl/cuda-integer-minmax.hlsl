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
    int first = (int)0;
    int second = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    int value = (int)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    int seed = asint(out_.Load(_e3*4));
    local_1 = uint(int(0));
    uint _e13 = local_1;
    out_.Store(_e13*4, asuint(min(seed, naga_neg(int(7)))));
    local_2 = uint(int(1));
    uint _e21 = local_2;
    out_.Store(_e21*4, asuint(max(seed, naga_neg(int(7)))));
    local_3 = uint(int(2));
    uint _e30 = local_3;
    out_.Store(_e30*4, asuint(int(min(3u, 9u))));
    local_4 = uint(int(3));
    uint _e39 = local_4;
    out_.Store(_e39*4, asuint(int(max(3u, 9u))));
    local_5 = uint(int(4));
    uint _e52 = local_5;
    out_.Store(_e52*4, asuint(int((min(uint(naga_neg(int(1))), 2u) == 2u))));
    local_6 = uint(int(5));
    uint _e65 = local_6;
    out_.Store(_e65*4, asuint(int((max(uint(naga_neg(int(1))), 2u) == 4294967295u))));
    local_7 = uint(int(6));
    uint _e78 = local_7;
    out_.Store(_e78*4, asuint(int((min(2u, uint(naga_neg(int(1)))) == 2u))));
    local_8 = uint(int(7));
    uint _e91 = local_8;
    out_.Store(_e91*4, asuint(int((max(2u, uint(naga_neg(int(1)))) == 4294967295u))));
    local_9 = uint(int(8));
    uint _e101 = local_9;
    out_.Store(_e101*4, asuint(min(int(true), int(false))));
    local_10 = uint(int(9));
    uint _e111 = local_10;
    out_.Store(_e111*4, asuint(max(int(false), int(true))));
    local_11 = uint(int(10));
    uint _e121 = local_11;
    out_.Store(_e121*4, asuint(min(max(seed, naga_neg(int(5))), int(2))));
    local_12 = uint(int(11));
    uint _e134 = local_12;
    out_.Store(_e134*4, asuint(int((min(uint(naga_neg(int(2))), 4u) == 4u))));
    const int _e138 = min_(seed, int(4), int(5));
    local_13 = uint(int(12));
    uint _e142 = local_13;
    out_.Store(_e142*4, asuint(_e138));
    const int _e144 = bounded(seed);
    local_14 = uint(int(13));
    uint _e148 = local_14;
    out_.Store(_e148*4, asuint(_e144));
    first = int(3);
    second = int(7);
    int _e154 = first;
    first = asint(asuint(_e154) + asuint(int(1)));
    int _e157 = second;
    second = asint(asuint(_e157) + asuint(int(1)));
    local_15 = uint(int(14));
    uint _e164 = local_15;
    out_.Store(_e164*4, asuint(max(_e154, _e157)));
    int _e166 = first;
    local_16 = uint(int(15));
    uint _e170 = local_16;
    out_.Store(_e170*4, asuint(_e166));
    int _e172 = second;
    local_17 = uint(int(16));
    uint _e176 = local_17;
    out_.Store(_e176*4, asuint(_e172));
    value = seed;
    int _e179 = value;
    int _e180 = value;
    value = asint(asuint(_e180) + asuint(int(1)));
    local_18 = uint(int(17));
    uint _e187 = local_18;
    out_.Store(_e187*4, asuint(max(_e179, _e180)));
    int _e189 = value;
    local_19 = uint(int(18));
    uint _e193 = local_19;
    out_.Store(_e193*4, asuint(_e189));
    local_20 = uint(int(19));
    uint _e210 = local_20;
    out_.Store(_e210*4, asuint(int((min(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1))), int(2147483647)) == asint(asuint(naga_neg(int(2147483647))) - asuint(int(1)))))));
    local_21 = uint(int(20));
    uint _e221 = local_21;
    out_.Store(_e221*4, asuint(int((max(4294967295u, 0u) == 4294967295u))));
    local_22 = uint(int(21));
    uint _e233 = local_22;
    out_.Store(_e233*4, asuint(int((min(uint(false), 3u) == 0u))));
    local_23 = uint(int(22));
    uint _e245 = local_23;
    out_.Store(_e245*4, asuint(int((max(uint(true), 0u) == 1u))));
    local_24 = uint(int(23));
    uint _e251 = local_24;
    out_.Store(_e251*4, asuint(min(seed, seed)));
}
