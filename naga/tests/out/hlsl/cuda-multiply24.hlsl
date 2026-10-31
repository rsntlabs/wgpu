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
    int local_66 = (int)0;
    int local_67 = (int)0;

    if (first_3) {
        if (second_3) {
            local_66 = int(71);
        } else {
            local_66 = int(73);
        }
        int _e7 = local_66;
        local_67 = _e7;
    } else {
        local_67 = int(79);
    }
    int _e12 = local_67;
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
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;

    local = uint(int(0));
    uint _e15 = local;
    local_34 = uint(_e15);
    uint _e18 = local_34;
    out_.Store(_e18*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    local_1 = uint(int(1));
    uint _e30 = local_1;
    local_35 = uint(_e30);
    uint _e33 = local_35;
    out_.Store(_e33*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    local_2 = uint(int(2));
    uint _e49 = local_2;
    local_36 = uint(_e49);
    uint _e52 = local_36;
    out_.Store(_e52*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    local_3 = uint(int(3));
    uint _e64 = local_3;
    local_37 = uint(_e64);
    uint _e67 = local_37;
    out_.Store(_e67*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e72 = signed_conversion(3.75, -(2.75));
    local_4 = uint(int(4));
    uint _e77 = local_4;
    local_38 = uint(_e77);
    uint _e80 = local_38;
    out_.Store(_e80*4, asuint(uint(_e72)));
    const int _e85 = signed_conversion(-(3.75), 2.75);
    local_5 = uint(int(5));
    uint _e90 = local_5;
    local_39 = uint(_e90);
    uint _e93 = local_39;
    out_.Store(_e93*4, asuint(uint(_e85)));
    const uint _e97 = unsigned_conversion(3.75, 2.75);
    local_6 = uint(int(6));
    uint _e101 = local_6;
    local_40 = uint(_e101);
    uint _e104 = local_40;
    out_.Store(_e104*4, asuint(_e97));
    const uint _e108 = unsigned_conversion(16777215.0, 1.0);
    local_7 = uint(int(7));
    uint _e112 = local_7;
    local_41 = uint(_e112);
    uint _e115 = local_41;
    out_.Store(_e115*4, asuint(_e108));
    const int _e119 = _mul24_(true, true);
    local_8 = uint(int(8));
    uint _e124 = local_8;
    local_42 = uint(_e124);
    uint _e127 = local_42;
    out_.Store(_e127*4, asuint(uint(_e119)));
    const int _e131 = _mul24_(false, true);
    local_9 = uint(int(9));
    uint _e136 = local_9;
    local_43 = uint(_e136);
    uint _e139 = local_43;
    out_.Store(_e139*4, asuint(uint(_e131)));
    local_10 = uint(int(10));
    uint _e156 = local_10;
    local_44 = uint(_e156);
    uint _e159 = local_44;
    out_.Store(_e159*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    local_11 = uint(int(11));
    uint _e176 = local_11;
    local_45 = uint(_e176);
    uint _e179 = local_45;
    out_.Store(_e179*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e183 = _mul24_1(3.75, 2.0);
    local_12 = uint(int(12));
    uint _e188 = local_12;
    local_46 = uint(_e188);
    uint _e191 = local_46;
    out_.Store(_e191*4, asuint(uint(_e183)));
    const uint _e195 = _umul24_(int(3), int(4));
    local_13 = uint(int(13));
    uint _e199 = local_13;
    local_47 = uint(_e199);
    uint _e202 = local_47;
    out_.Store(_e202*4, asuint(_e195));
    local_14 = uint(int(14));
    uint _e214 = local_14;
    local_48 = uint(_e214);
    uint _e217 = local_48;
    out_.Store(_e217*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e223 = _umul24_(int(true), int(true));
    local_15 = uint(int(15));
    uint _e227 = local_15;
    local_49 = uint(_e227);
    uint _e230 = local_49;
    out_.Store(_e230*4, asuint(_e223));
    local_16 = uint(int(16));
    uint _e243 = local_16;
    local_50 = uint(_e243);
    uint _e246 = local_50;
    out_.Store(_e246*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e251 = signed_pair(naga_neg(int(7)), int(3));
    local_17 = uint(int(17));
    uint _e256 = local_17;
    local_51 = uint(_e256);
    uint _e259 = local_51;
    out_.Store(_e259*4, asuint(uint(_e251)));
    local_18 = uint(int(18));
    uint _e284 = local_18;
    local_52 = uint(_e284);
    uint _e287 = local_52;
    out_.Store(_e287*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    local_19 = uint(int(19));
    uint _e305 = local_19;
    local_53 = uint(_e305);
    uint _e308 = local_53;
    out_.Store(_e308*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e314 = first;
    uint _e315 = second;
    local_20 = uint(int(20));
    uint _e329 = local_20;
    local_54 = uint(_e329);
    uint _e332 = local_54;
    out_.Store(_e332*4, asuint(uint(asint((asuint(naga_extractBits(_e314, 0u, 24u)) * asuint(naga_extractBits(int(_e315), 0u, 24u)))))));
    int _e334 = first;
    uint _e336 = second;
    local_21 = uint(int(21));
    uint _e345 = local_21;
    local_55 = uint(_e345);
    uint _e348 = local_55;
    out_.Store(_e348*4, asuint((naga_extractBits(uint(_e334), 0u, 24u) * naga_extractBits(_e336, 0u, 24u))));
    local_22 = uint(int(22));
    uint _e364 = local_22;
    local_56 = uint(_e364);
    uint _e367 = local_56;
    out_.Store(_e367*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    local_23 = uint(int(23));
    uint _e379 = local_23;
    local_57 = uint(_e379);
    uint _e382 = local_57;
    out_.Store(_e382*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local_25 = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local_25 = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e409 = local_25;
    local_24 = uint(int(24));
    uint _e414 = local_24;
    local_58 = uint(_e414);
    uint _e417 = local_58;
    out_.Store(_e417*4, asuint(uint(_e409)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e446 = values[int(0)];
    int _e447 = values[int(1)];
    local_26 = uint(int(25));
    uint _e453 = local_26;
    local_59 = uint(_e453);
    uint _e456 = local_59;
    out_.Store(_e456*4, asuint(uint(asint(asuint(_e446) + asuint(_e447)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e464 = Count;
    int _e465 = scratch[int(0)];
    local_28 = uint(int(26));
    uint _e471 = local_28;
    local_60 = uint(_e471);
    uint _e474 = local_60;
    out_.Store(_e474*4, asuint(uint(asint(asuint(_e464) + asuint(_e465)))));
    counter = int(2);
    int _e478 = counter;
    counter = asint(asuint(_e478) + asuint(int(1)));
    int _e481 = counter;
    counter = asint(asuint(_e481) + asuint(int(1)));
    local_29 = uint(int(27));
    uint _e496 = local_29;
    local_61 = uint(_e496);
    uint _e499 = local_61;
    out_.Store(_e499*4, asuint(uint(asint((asuint(naga_extractBits(_e478, 0u, 24u)) * asuint(naga_extractBits(_e481, 0u, 24u)))))));
    int _e501 = counter;
    local_30 = uint(int(28));
    uint _e506 = local_30;
    local_62 = uint(_e506);
    uint _e509 = local_62;
    out_.Store(_e509*4, asuint(uint(_e501)));
    total = int(0);
    {
        index = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e532 = index;
                index = asint(asuint(_e532) + asuint(int(1)));
            }
            loop_init = false;
            int _e515 = index;
            if ((_e515 < int(3))) {
            } else {
                break;
            }
            int _e518 = index;
            int _e530 = total;
            total = asint(asuint(_e530) + asuint(asint((asuint(naga_extractBits(asint(asuint(_e518) + asuint(int(1))), 0u, 24u)) * asuint(naga_extractBits(int(2), 0u, 24u))))));
        }
    }
    int _e535 = total;
    local_31 = uint(int(29));
    uint _e540 = local_31;
    local_63 = uint(_e540);
    uint _e543 = local_63;
    out_.Store(_e543*4, asuint(uint(_e535)));
    {
        local_32 = uint(int(30));
        uint _e551 = local_32;
        local_64 = uint(_e551);
        uint _e554 = local_64;
        out_.Store(_e554*4, asuint(uint(naga_f2i32(9.75))));
    }
    local_33 = uint(int(31));
    uint _e570 = local_33;
    local_65 = uint(_e570);
    uint _e573 = local_65;
    out_.Store(_e573*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
