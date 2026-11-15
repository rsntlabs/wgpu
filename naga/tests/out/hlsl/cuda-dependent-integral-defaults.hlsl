static const int Initial_1 = int(6);

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

uint chain_6_6u_6_()
{
    return uint(int(6));
}

uint chain_7_7u_7_()
{
    return uint(int(7));
}

int merged_8_8_()
{
    return int(8);
}

uint flag_0_false()
{
    return uint(false);
}

uint flag_1_true()
{
    return uint(true);
}

uint cross_u002d_1_7u()
{
    return 7u;
}

uint wide_65535ULL_65535u()
{
    return 65535u;
}

uint mixed_unsigned_4_4_()
{
    return uint(int(4));
}

int mixed_int_9_9_()
{
    return int(9);
}

uint choose_3_3_unsigned(uint value)
{
    return (value + uint(int(3)));
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void dependent_integral_defaults(uint3 threadIdx : SV_GroupThreadID)
{
    int Initial = (int)0;
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
    int state = (int)0;
    uint local_11 = (uint)0;
    bool local_12 = (bool)0;
    int local_13 = (int)0;
    bool local_14 = (bool)0;
    int local_15 = (int)0;
    uint local_16 = (uint)0;
    int index = (int)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    int old = (int)0;
    int old_1 = (int)0;
    int local_20 = (int)0;
    int local_21 = (int)0;
    int old_2 = (int)0;
    int local_22 = (int)0;
    int local_23 = (int)0;
    int old_3 = (int)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    Initial = int(99);
    const uint _e8 = chain_6_6u_6_();
    output.Store(base*4, asuint(_e8));
    const uint _e11 = chain_6_6u_6_();
    local = uint((base + 1u));
    uint _e16 = local;
    output.Store(_e16*4, asuint(_e11));
    const uint _e18 = chain_6_6u_6_();
    local_1 = uint((base + 2u));
    uint _e23 = local_1;
    output.Store(_e23*4, asuint(_e18));
    const uint _e25 = chain_7_7u_7_();
    local_2 = uint((base + 3u));
    uint _e30 = local_2;
    output.Store(_e30*4, asuint(_e25));
    const int _e32 = merged_8_8_();
    local_3 = uint((base + 4u));
    uint _e38 = local_3;
    output.Store(_e38*4, asuint(uint(_e32)));
    const uint _e40 = flag_0_false();
    local_4 = uint((base + 5u));
    uint _e45 = local_4;
    output.Store(_e45*4, asuint(_e40));
    const uint _e47 = flag_1_true();
    local_5 = uint((base + 6u));
    uint _e52 = local_5;
    output.Store(_e52*4, asuint(_e47));
    const uint _e54 = cross_u002d_1_7u();
    local_6 = uint((base + 7u));
    uint _e59 = local_6;
    output.Store(_e59*4, asuint(_e54));
    const uint _e61 = wide_65535ULL_65535u();
    local_7 = uint((base + 8u));
    uint _e66 = local_7;
    output.Store(_e66*4, asuint(_e61));
    const uint _e68 = mixed_unsigned_4_4_();
    local_8 = uint((base + 9u));
    uint _e73 = local_8;
    output.Store(_e73*4, asuint(_e68));
    const int _e75 = mixed_int_9_9_();
    local_9 = uint((base + 10u));
    uint _e81 = local_9;
    output.Store(_e81*4, asuint(uint(_e75)));
    const uint _e84 = choose_3_3_unsigned(2u);
    local_10 = uint((base + 11u));
    uint _e89 = local_10;
    output.Store(_e89*4, asuint(_e84));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    old = ZeroValueint();
    int _e97 = state;
    old = _e97;
    int _e99 = state;
    state = asint(asuint(_e99) + asuint(int(2)));
    int _e102 = old;
    local_11 = uint((base + 12u));
    uint _e108 = local_11;
    output.Store(_e108*4, asuint(uint(_e102)));
    local_12 = false;
    if (false) {
        old_1 = ZeroValueint();
        int _e114 = state;
        local_20 = _e114;
        int _e116 = local_20;
        old_1 = _e116;
        int _e118 = state;
        local_21 = _e118;
        int _e120 = local_21;
        state = asint(asuint(_e120) + asuint(int(99)));
        int _e123 = old_1;
        local_13 = _e123;
        int _e125 = local_13;
        local_12 = (_e125 != int(0));
    }
    local_14 = true;
    if (true) {
    } else {
        old_2 = ZeroValueint();
        int _e132 = state;
        local_22 = _e132;
        int _e134 = local_22;
        old_2 = _e134;
        int _e136 = state;
        local_23 = _e136;
        int _e138 = local_23;
        state = asint(asuint(_e138) + asuint(int(99)));
        int _e141 = old_2;
        local_15 = _e141;
        int _e143 = local_15;
        local_14 = (_e143 != int(0));
    }
    old_3 = ZeroValueint();
    int _e148 = state;
    old_3 = _e148;
    int _e150 = state;
    state = asint(asuint(_e150) + asuint(int(3)));
    int _e153 = state;
    local_16 = uint((base + 13u));
    uint _e159 = local_16;
    output.Store(_e159*4, asuint(uint(_e153)));
    index = int(0);
    int _e163 = index;
    index = asint(asuint(_e163) + asuint(int(1)));
    local_18 = uint(_e163);
    uint _e168 = local_18;
    int _e171 = asint(input.Load(_e168*4));
    const uint _e173 = choose_3_3_unsigned(uint(_e171));
    local_17 = uint((base + 14u));
    uint _e178 = local_17;
    output.Store(_e178*4, asuint(_e173));
    int _e180 = index;
    local_19 = uint((base + 15u));
    uint _e186 = local_19;
    output.Store(_e186*4, asuint(uint(_e180)));
}
