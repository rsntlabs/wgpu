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
    uint values[3] = (uint[3])0;
    uint2 vector_ = (uint2)0;
    uint counter = (uint)0;
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
    uint declared = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;

    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    pair.first = 11u;
    pair.second = 13u;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector_ = uint2(17u, 19u);
    counter = 0u;
    out_.Store(start*4, asuint(7u));
    local = uint((start + 1u));
    uint _e31 = local;
    out_.Store(_e31*4, asuint(11u));
    local_1 = uint((start + 2u));
    uint _e41 = local_1;
    out_.Store(_e41*4, asuint((2u + 3u)));
    local_2 = uint((start + 3u));
    uint _e52 = local_2;
    out_.Store(_e52*4, asuint(((1u + 2u) * 3u)));
    local_3 = uint((start + 4u));
    uint _e61 = local_3;
    out_.Store(_e61*4, asuint((5u + 6u)));
    local_4 = uint((start + 5u));
    uint _e70 = local_4;
    out_.Store(_e70*4, asuint((7u + 8u)));
    uint _e73 = pair.first;
    local_5 = uint((start + 6u));
    uint _e78 = local_5;
    out_.Store(_e78*4, asuint(_e73));
    uint _e81 = pair.second;
    local_6 = uint((start + 7u));
    uint _e86 = local_6;
    out_.Store(_e86*4, asuint(_e81));
    local_7 = uint((start + 8u));
    uint _e94 = local_7;
    out_.Store(_e94*4, asuint(uint(int(3))));
    uint _e97 = values[min(uint(lane), 2u)];
    local_8 = uint((start + 9u));
    uint _e102 = local_8;
    out_.Store(_e102*4, asuint(_e97));
    uint _e105 = vector_.x;
    local_9 = uint((start + 10u));
    uint _e110 = local_9;
    out_.Store(_e110*4, asuint(_e105));
    uint _e113 = vector_.y;
    local_10 = uint((start + 11u));
    uint _e118 = local_10;
    out_.Store(_e118*4, asuint(_e113));
    uint _e120 = counter;
    counter = (_e120 + uint(int(1)));
    uint _e124 = counter;
    counter = (_e124 + uint(int(1)));
    local_11 = uint((start + 12u));
    uint _e132 = local_11;
    out_.Store(_e132*4, asuint(_e124));
    uint _e134 = counter;
    local_12 = uint((start + 13u));
    uint _e139 = local_12;
    out_.Store(_e139*4, asuint(_e134));
    local_13 = uint((start + 14u));
    uint _e145 = local_13;
    out_.Store(_e145*4, asuint(19u));
    uint _e148 = counter;
    local_14 = uint((start + 15u));
    uint _e153 = local_14;
    out_.Store(_e153*4, asuint(_e148));
    values[int(0)] = 23u;
    uint _e158 = values[int(0)];
    local_15 = uint((start + 16u));
    uint _e163 = local_15;
    out_.Store(_e163*4, asuint(_e158));
    uint _e167 = values[int(0)];
    local_16 = uint((start + 17u));
    uint _e172 = local_16;
    out_.Store(_e172*4, asuint(_e167));
    if ((lane == 0u)) {
        local_18 = 29u;
    } else {
        local_18 = 31u;
    }
    uint _e181 = local_18;
    local_17 = uint((start + 18u));
    uint _e186 = local_17;
    out_.Store(_e186*4, asuint(_e181));
    const uint _e188 = advance(lane);
    local_19 = uint((start + 19u));
    uint _e193 = local_19;
    out_.Store(_e193*4, asuint(_e188));
    declared = 37u;
    uint _e197 = declared;
    local_20 = uint((start + 20u));
    uint _e202 = local_20;
    out_.Store(_e202*4, asuint(_e197));
    local_21 = uint((start + 21u));
    uint _e211 = local_21;
    out_.Store(_e211*4, asuint(asuint(-(0.0))));
    local_22 = uint((start + 22u));
    uint _e217 = local_22;
    out_.Store(_e217*4, asuint(4294967295u));
    local_23 = uint((start + 23u));
    uint _e226 = local_23;
    out_.Store(_e226*4, asuint((41u + lane)));
}
