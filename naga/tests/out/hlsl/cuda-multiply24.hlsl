RWByteAddressBuffer out_ : register(u0);

int naga_extractBits(
    int e,
    uint offset,
    uint count
) {
    uint w = 32;
    uint o = min(offset, w);
    uint c = min(count, w - o);
    return (c == 0 ? 0 : (e << (w - c - o)) >> (w - c));
}
int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int signed_conversion(float first_1, float second_1)
{
    return asint((asuint(naga_extractBits(naga_f2i32(first_1), 0u, 24u)) * asuint(naga_extractBits(naga_f2i32(second_1), 0u, 24u))));
}

uint naga_extractBits(
    uint e,
    uint offset,
    uint count
) {
    uint w = 32;
    uint o = min(offset, w);
    uint c = min(count, w - o);
    return (c == 0 ? 0 : (e << (w - c - o)) >> (w - c));
}
uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

uint unsigned_conversion(float first_2, float second_2)
{
    return (naga_extractBits(naga_f2u32(first_2), 0u, 24u) * naga_extractBits(naga_f2u32(second_2), 0u, 24u));
}

int _mul24_(bool first_3, bool second_3)
{
    int local_35 = (int)0;
    int local_36 = (int)0;

    if (first_3) {
        if (second_3) {
            local_35 = int(71);
        } else {
            local_35 = int(73);
        }
        int _e7 = local_35;
        local_36 = _e7;
    } else {
        local_36 = int(79);
    }
    int _e12 = local_36;
    return _e12;
}

int _mul24_1(float first_4, float second_4)
{
    return naga_f2i32(((first_4 * 10.0) + second_4));
}

uint _umul24_(int first_5, int second_5)
{
    return uint(asint(asuint(asint(asuint(first_5) + asuint(second_5))) + asuint(int(100))));
}

int signed_pair(int first_6, int second_6)
{
    return asint((asuint(naga_extractBits(first_6, 0u, 24u)) * asuint(naga_extractBits(second_6, 0u, 24u))));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

[numthreads(1, 1, 1)]
void multiply24_()
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
    int first = (int)0;
    uint second = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    int local_25 = (int)0;
    int values[2] = (int[2])0;
    uint local_26 = (uint)0;
    int Count = (int)0;
    int local_27 = (int)0;
    int scratch[2] = (int[2])0;
    uint local_28 = (uint)0;
    int counter = (int)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    int total = (int)0;
    int index = (int)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;

    local = uint(int(0));
    uint _e14 = local;
    out_.Store(_e14*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    local_1 = uint(int(1));
    uint _e27 = local_1;
    out_.Store(_e27*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    local_2 = uint(int(2));
    uint _e43 = local_2;
    out_.Store(_e43*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    local_3 = uint(int(3));
    uint _e55 = local_3;
    out_.Store(_e55*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e60 = signed_conversion(3.75, -(2.75));
    local_4 = uint(int(4));
    uint _e65 = local_4;
    out_.Store(_e65*4, asuint(uint(_e60)));
    const int _e70 = signed_conversion(-(3.75), 2.75);
    local_5 = uint(int(5));
    uint _e75 = local_5;
    out_.Store(_e75*4, asuint(uint(_e70)));
    const uint _e79 = unsigned_conversion(3.75, 2.75);
    local_6 = uint(int(6));
    uint _e83 = local_6;
    out_.Store(_e83*4, asuint(_e79));
    const uint _e87 = unsigned_conversion(16777215.0, 1.0);
    local_7 = uint(int(7));
    uint _e91 = local_7;
    out_.Store(_e91*4, asuint(_e87));
    const int _e95 = _mul24_(true, true);
    local_8 = uint(int(8));
    uint _e100 = local_8;
    out_.Store(_e100*4, asuint(uint(_e95)));
    const int _e104 = _mul24_(false, true);
    local_9 = uint(int(9));
    uint _e109 = local_9;
    out_.Store(_e109*4, asuint(uint(_e104)));
    local_10 = uint(int(10));
    uint _e126 = local_10;
    out_.Store(_e126*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    local_11 = uint(int(11));
    uint _e143 = local_11;
    out_.Store(_e143*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e147 = _mul24_1(3.75, 2.0);
    local_12 = uint(int(12));
    uint _e152 = local_12;
    out_.Store(_e152*4, asuint(uint(_e147)));
    const uint _e156 = _umul24_(int(3), int(4));
    local_13 = uint(int(13));
    uint _e160 = local_13;
    out_.Store(_e160*4, asuint(_e156));
    local_14 = uint(int(14));
    uint _e172 = local_14;
    out_.Store(_e172*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e178 = _umul24_(int(true), int(true));
    local_15 = uint(int(15));
    uint _e182 = local_15;
    out_.Store(_e182*4, asuint(_e178));
    local_16 = uint(int(16));
    uint _e195 = local_16;
    out_.Store(_e195*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e200 = signed_pair(naga_neg(int(7)), int(3));
    local_17 = uint(int(17));
    uint _e205 = local_17;
    out_.Store(_e205*4, asuint(uint(_e200)));
    local_18 = uint(int(18));
    uint _e230 = local_18;
    out_.Store(_e230*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    local_19 = uint(int(19));
    uint _e248 = local_19;
    out_.Store(_e248*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e254 = first;
    uint _e255 = second;
    local_20 = uint(int(20));
    uint _e269 = local_20;
    out_.Store(_e269*4, asuint(uint(asint((asuint(naga_extractBits(_e254, 0u, 24u)) * asuint(naga_extractBits(int(_e255), 0u, 24u)))))));
    int _e271 = first;
    uint _e273 = second;
    local_21 = uint(int(21));
    uint _e282 = local_21;
    out_.Store(_e282*4, asuint((naga_extractBits(uint(_e271), 0u, 24u) * naga_extractBits(_e273, 0u, 24u))));
    local_22 = uint(int(22));
    uint _e298 = local_22;
    out_.Store(_e298*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    local_23 = uint(int(23));
    uint _e310 = local_23;
    out_.Store(_e310*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local_25 = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local_25 = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e337 = local_25;
    local_24 = uint(int(24));
    uint _e342 = local_24;
    out_.Store(_e342*4, asuint(uint(_e337)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e371 = values[int(0)];
    int _e372 = values[int(1)];
    local_26 = uint(int(25));
    uint _e378 = local_26;
    out_.Store(_e378*4, asuint(uint(asint(asuint(_e371) + asuint(_e372)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e386 = Count;
    int _e387 = scratch[int(0)];
    local_28 = uint(int(26));
    uint _e393 = local_28;
    out_.Store(_e393*4, asuint(uint(asint(asuint(_e386) + asuint(_e387)))));
    counter = int(2);
    int _e397 = counter;
    counter = asint(asuint(_e397) + asuint(int(1)));
    int _e400 = counter;
    counter = asint(asuint(_e400) + asuint(int(1)));
    local_29 = uint(int(27));
    uint _e415 = local_29;
    out_.Store(_e415*4, asuint(uint(asint((asuint(naga_extractBits(_e397, 0u, 24u)) * asuint(naga_extractBits(_e400, 0u, 24u)))))));
    int _e417 = counter;
    local_30 = uint(int(28));
    uint _e422 = local_30;
    out_.Store(_e422*4, asuint(uint(_e417)));
    total = int(0);
    {
        index = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e445 = index;
                index = asint(asuint(_e445) + asuint(int(1)));
            }
            loop_init = false;
            int _e428 = index;
            if ((_e428 < int(3))) {
            } else {
                break;
            }
            int _e431 = index;
            int _e443 = total;
            total = asint(asuint(_e443) + asuint(asint((asuint(naga_extractBits(asint(asuint(_e431) + asuint(int(1))), 0u, 24u)) * asuint(naga_extractBits(int(2), 0u, 24u))))));
        }
    }
    int _e448 = total;
    local_31 = uint(int(29));
    uint _e453 = local_31;
    out_.Store(_e453*4, asuint(uint(_e448)));
    {
        local_32 = uint(int(30));
        uint _e461 = local_32;
        local_34 = _e461;
        uint _e463 = local_34;
        out_.Store(_e463*4, asuint(uint(naga_f2i32(9.75))));
    }
    local_33 = uint(int(31));
    uint _e479 = local_33;
    out_.Store(_e479*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
