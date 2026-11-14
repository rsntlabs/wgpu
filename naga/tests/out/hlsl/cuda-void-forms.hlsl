RWByteAddressBuffer output : register(u0);

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

[numthreads(4, 1, 1)]
void void_forms(uint3 threadIdx : SV_GroupThreadID)
{
    int value = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int index = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int Count = (int)0;
    int local_6 = (int)0;
    int array[3] = (int[3])0;
    uint local_7 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 6u));
    value = int(lane);
    int _e8 = value;
    value = asint(asuint(_e8) + asuint(int(1)));
    int _e11 = value;
    value = asint(asuint(_e11) + asuint(int(1)));
    int _e14 = value;
    output.Store(base*4, asuint(_e14));
    int _e17 = value;
    value = asint(asuint(_e17) + asuint(int(1)));
    int _e20 = value;
    value = asint(asuint(_e20) + asuint(int(1)));
    int _e23 = value;
    local = uint((base + 1u));
    uint _e28 = local;
    output.Store(_e28*4, asuint(_e23));
    if (((lane & 1u) == 0u)) {
        int _e34 = value;
        value = asint(asuint(_e34) + asuint(int(3)));
    } else {
        int _e37 = value;
        value = asint(asuint(_e37) + asuint(int(7)));
    }
    int _e40 = value;
    local_1 = uint((base + 2u));
    uint _e45 = local_1;
    output.Store(_e45*4, asuint(_e40));
    int _e47 = value;
    value = asint(asuint(_e47) + asuint(int(1)));
    int _e50 = value;
    value = asint(asuint(_e50) + asuint(int(1)));
    int _e53 = value;
    local_2 = uint((base + 3u));
    uint _e58 = local_2;
    output.Store(_e58*4, asuint(_e53));
    index = int(0);
    int _e62 = index;
    index = asint(asuint(_e62) + asuint(int(1)));
    local_3 = uint(_e62);
    int _e67 = index;
    index = asint(asuint(_e67) + asuint(int(1)));
    local_4 = uint(_e67);
    int _e72 = index;
    local_5 = uint((base + 4u));
    uint _e77 = local_5;
    output.Store(_e77*4, asuint(_e72));
    Count = int(3);
    array = ZeroValuearray3_int_();
    int _e85 = array[int(2)];
    local_7 = uint((base + 5u));
    uint _e90 = local_7;
    output.Store(_e90*4, asuint(_e85));
}
