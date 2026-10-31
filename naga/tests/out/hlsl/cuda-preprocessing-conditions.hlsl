RWByteAddressBuffer out_ : register(u0);

uint later(uint value)
{
    return (value + 73u);
}

[numthreads(2, 1, 1)]
void preprocessing_conditions(uint3 threadIdx : SV_GroupThreadID)
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
    uint counter = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;

    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    out_.Store(start*4, asuint(7u));
    local = uint((start + 1u));
    uint _e13 = local;
    out_.Store(_e13*4, asuint(11u));
    local_1 = uint((start + 2u));
    uint _e20 = local_1;
    out_.Store(_e20*4, asuint(13u));
    local_2 = uint((start + 3u));
    uint _e27 = local_2;
    out_.Store(_e27*4, asuint(17u));
    local_3 = uint((start + 4u));
    uint _e34 = local_3;
    out_.Store(_e34*4, asuint(19u));
    local_4 = uint((start + 5u));
    uint _e41 = local_4;
    out_.Store(_e41*4, asuint(23u));
    local_5 = uint((start + 6u));
    uint _e48 = local_5;
    out_.Store(_e48*4, asuint(29u));
    local_6 = uint((start + 7u));
    uint _e55 = local_6;
    out_.Store(_e55*4, asuint(31u));
    local_7 = uint((start + 8u));
    uint _e62 = local_7;
    out_.Store(_e62*4, asuint(37u));
    local_8 = uint((start + 9u));
    uint _e69 = local_8;
    out_.Store(_e69*4, asuint(41u));
    local_9 = uint((start + 10u));
    uint _e76 = local_9;
    out_.Store(_e76*4, asuint(43u));
    local_10 = uint((start + 11u));
    uint _e83 = local_10;
    out_.Store(_e83*4, asuint(47u));
    local_11 = uint((start + 12u));
    uint _e90 = local_11;
    out_.Store(_e90*4, asuint(53u));
    local_12 = uint((start + 13u));
    uint _e97 = local_12;
    out_.Store(_e97*4, asuint(59u));
    local_13 = uint((start + 14u));
    uint _e104 = local_13;
    out_.Store(_e104*4, asuint(61u));
    local_14 = uint((start + 15u));
    uint _e111 = local_14;
    out_.Store(_e111*4, asuint(67u));
    local_15 = uint((start + 16u));
    uint _e118 = local_15;
    out_.Store(_e118*4, asuint(71u));
    const uint _e121 = later(lane);
    local_16 = uint((start + 17u));
    uint _e126 = local_16;
    out_.Store(_e126*4, asuint(_e121));
    counter = 0u;
    uint _e130 = counter;
    counter = (_e130 + uint(int(1)));
    local_17 = uint((start + 18u));
    uint _e138 = local_17;
    out_.Store(_e138*4, asuint(_e130));
    uint _e140 = counter;
    local_18 = uint((start + 19u));
    uint _e145 = local_18;
    out_.Store(_e145*4, asuint(_e140));
    local_19 = uint((start + 20u));
    uint _e153 = local_19;
    out_.Store(_e153*4, asuint(uint(true)));
    local_20 = uint((start + 21u));
    uint _e159 = local_20;
    out_.Store(_e159*4, asuint(lane));
    local_21 = uint((start + 22u));
    uint _e168 = local_21;
    out_.Store(_e168*4, asuint(asuint(-(0.0))));
    local_22 = uint((start + 23u));
    uint _e174 = local_22;
    out_.Store(_e174*4, asuint(4294967295u));
}
