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
    int local_4 = (int)0;
    int local_5 = (int)0;

    if (first_3) {
        if (second_3) {
            local_4 = int(71);
        } else {
            local_4 = int(73);
        }
        int _e7 = local_4;
        local_5 = _e7;
    } else {
        local_5 = int(79);
    }
    int _e12 = local_5;
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
    int first = (int)0;
    uint second = (uint)0;
    int local = (int)0;
    int values[2] = (int[2])0;
    int Count = (int)0;
    int local_1 = (int)0;
    int scratch[2] = (int[2])0;
    int counter = (int)0;
    int total = (int)0;
    int index = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;

    out_.Store(uint(int(0))*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    out_.Store(uint(int(1))*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    out_.Store(uint(int(2))*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    out_.Store(uint(int(3))*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e52 = signed_conversion(3.75, -(2.75));
    out_.Store(uint(int(4))*4, asuint(uint(_e52)));
    const int _e60 = signed_conversion(-(3.75), 2.75);
    out_.Store(uint(int(5))*4, asuint(uint(_e60)));
    const uint _e67 = unsigned_conversion(3.75, 2.75);
    out_.Store(uint(int(6))*4, asuint(_e67));
    const uint _e73 = unsigned_conversion(16777215.0, 1.0);
    out_.Store(uint(int(7))*4, asuint(_e73));
    const int _e79 = _mul24_(true, true);
    out_.Store(uint(int(8))*4, asuint(uint(_e79)));
    const int _e86 = _mul24_(false, true);
    out_.Store(uint(int(9))*4, asuint(uint(_e86)));
    out_.Store(uint(int(10))*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    out_.Store(uint(int(11))*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e123 = _mul24_1(3.75, 2.0);
    out_.Store(uint(int(12))*4, asuint(uint(_e123)));
    const uint _e130 = _umul24_(int(3), int(4));
    out_.Store(uint(int(13))*4, asuint(_e130));
    out_.Store(uint(int(14))*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e148 = _umul24_(int(true), int(true));
    out_.Store(uint(int(15))*4, asuint(_e148));
    out_.Store(uint(int(16))*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e166 = signed_pair(naga_neg(int(7)), int(3));
    out_.Store(uint(int(17))*4, asuint(uint(_e166)));
    out_.Store(uint(int(18))*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    out_.Store(uint(int(19))*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e214 = first;
    uint _e215 = second;
    out_.Store(uint(int(20))*4, asuint(uint(asint((asuint(naga_extractBits(_e214, 0u, 24u)) * asuint(naga_extractBits(int(_e215), 0u, 24u)))))));
    int _e229 = first;
    uint _e231 = second;
    out_.Store(uint(int(21))*4, asuint((naga_extractBits(uint(_e229), 0u, 24u) * naga_extractBits(_e231, 0u, 24u))));
    out_.Store(uint(int(22))*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    out_.Store(uint(int(23))*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e289 = local;
    out_.Store(uint(int(24))*4, asuint(uint(_e289)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e321 = values[int(0)];
    int _e322 = values[int(1)];
    out_.Store(uint(int(25))*4, asuint(uint(asint(asuint(_e321) + asuint(_e322)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e334 = Count;
    int _e335 = scratch[int(0)];
    out_.Store(uint(int(26))*4, asuint(uint(asint(asuint(_e334) + asuint(_e335)))));
    counter = int(2);
    int _e343 = counter;
    counter = asint(asuint(_e343) + asuint(int(1)));
    int _e346 = counter;
    counter = asint(asuint(_e346) + asuint(int(1)));
    out_.Store(uint(int(27))*4, asuint(uint(asint((asuint(naga_extractBits(_e343, 0u, 24u)) * asuint(naga_extractBits(_e346, 0u, 24u)))))));
    int _e361 = counter;
    out_.Store(uint(int(28))*4, asuint(uint(_e361)));
    total = int(0);
    {
        index = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e387 = index;
                index = asint(asuint(_e387) + asuint(int(1)));
            }
            loop_init = false;
            int _e370 = index;
            if ((_e370 < int(3))) {
            } else {
                break;
            }
            int _e373 = index;
            int _e385 = total;
            total = asint(asuint(_e385) + asuint(asint((asuint(naga_extractBits(asint(asuint(_e373) + asuint(int(1))), 0u, 24u)) * asuint(naga_extractBits(int(2), 0u, 24u))))));
        }
    }
    int _e390 = total;
    out_.Store(uint(int(29))*4, asuint(uint(_e390)));
    {
        local_2 = uint(int(30));
        uint _e401 = local_2;
        local_3 = _e401;
        uint _e403 = local_3;
        out_.Store(_e403*4, asuint(uint(naga_f2i32(9.75))));
    }
    out_.Store(uint(int(31))*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
