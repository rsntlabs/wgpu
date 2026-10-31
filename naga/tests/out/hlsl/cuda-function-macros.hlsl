struct Pair_cuda_record_0_ {
    uint first;
    uint second;
};

RWByteAddressBuffer out_ : register(u0);

uint advance(uint value)
{
    return (value + 3u);
}

[numthreads(2, 1, 1)]
void function_macros(uint3 threadIdx : SV_GroupThreadID)
{
    Pair_cuda_record_0_ pair = (Pair_cuda_record_0_)0;
    Pair_cuda_record_0_ local = (Pair_cuda_record_0_)0;
    uint values[3] = (uint[3])0;
    uint2 vector_ = (uint2)0;
    uint counter = (uint)0;
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
    uint declared = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;

    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    local.first = 11u;
    local.second = 13u;
    Pair_cuda_record_0_ _e11 = local;
    pair = _e11;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector_ = uint2(17u, 19u);
    counter = 0u;
    out_.Store(start*4, asuint(7u));
    local_1 = uint((start + 1u));
    uint _e33 = local_1;
    out_.Store(_e33*4, asuint(11u));
    local_2 = uint((start + 2u));
    uint _e43 = local_2;
    out_.Store(_e43*4, asuint((2u + 3u)));
    local_3 = uint((start + 3u));
    uint _e54 = local_3;
    out_.Store(_e54*4, asuint(((1u + 2u) * 3u)));
    local_4 = uint((start + 4u));
    uint _e63 = local_4;
    out_.Store(_e63*4, asuint((5u + 6u)));
    local_5 = uint((start + 5u));
    uint _e72 = local_5;
    out_.Store(_e72*4, asuint((7u + 8u)));
    uint _e75 = pair.first;
    local_6 = uint((start + 6u));
    uint _e80 = local_6;
    out_.Store(_e80*4, asuint(_e75));
    uint _e83 = pair.second;
    local_7 = uint((start + 7u));
    uint _e88 = local_7;
    out_.Store(_e88*4, asuint(_e83));
    local_8 = uint((start + 8u));
    uint _e96 = local_8;
    out_.Store(_e96*4, asuint(uint(int(3))));
    uint _e99 = values[min(uint(lane), 2u)];
    local_9 = uint((start + 9u));
    uint _e104 = local_9;
    out_.Store(_e104*4, asuint(_e99));
    uint _e107 = vector_.x;
    local_10 = uint((start + 10u));
    uint _e112 = local_10;
    out_.Store(_e112*4, asuint(_e107));
    uint _e115 = vector_.y;
    local_11 = uint((start + 11u));
    uint _e120 = local_11;
    out_.Store(_e120*4, asuint(_e115));
    uint _e122 = counter;
    counter = (_e122 + uint(int(1)));
    uint _e126 = counter;
    counter = (_e126 + uint(int(1)));
    local_12 = uint((start + 12u));
    uint _e134 = local_12;
    out_.Store(_e134*4, asuint(_e126));
    uint _e136 = counter;
    local_13 = uint((start + 13u));
    uint _e141 = local_13;
    out_.Store(_e141*4, asuint(_e136));
    local_14 = uint((start + 14u));
    uint _e147 = local_14;
    out_.Store(_e147*4, asuint(19u));
    uint _e150 = counter;
    local_15 = uint((start + 15u));
    uint _e155 = local_15;
    out_.Store(_e155*4, asuint(_e150));
    values[int(0)] = 23u;
    uint _e160 = values[int(0)];
    local_16 = uint((start + 16u));
    uint _e165 = local_16;
    out_.Store(_e165*4, asuint(_e160));
    uint _e169 = values[int(0)];
    local_17 = uint((start + 17u));
    uint _e174 = local_17;
    out_.Store(_e174*4, asuint(_e169));
    if ((lane == 0u)) {
        local_19 = 29u;
    } else {
        local_19 = 31u;
    }
    uint _e183 = local_19;
    local_18 = uint((start + 18u));
    uint _e188 = local_18;
    out_.Store(_e188*4, asuint(_e183));
    const uint _e190 = advance(lane);
    local_20 = uint((start + 19u));
    uint _e195 = local_20;
    out_.Store(_e195*4, asuint(_e190));
    declared = 37u;
    uint _e199 = declared;
    local_21 = uint((start + 20u));
    uint _e204 = local_21;
    out_.Store(_e204*4, asuint(_e199));
    local_22 = uint((start + 21u));
    uint _e213 = local_22;
    out_.Store(_e213*4, asuint(asuint(-(0.0))));
    local_23 = uint((start + 22u));
    uint _e219 = local_23;
    out_.Store(_e219*4, asuint(4294967295u));
    local_24 = uint((start + 23u));
    uint _e228 = local_24;
    out_.Store(_e228*4, asuint((41u + lane)));
}
