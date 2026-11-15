static const int N_1 = int(4);

static uint3 threadIdx_1 = (uint3)0;
RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int choose(int value)
{
    return asint(asuint(value) + asuint(int(10)));
}

int self_named_4_()
{
    return int(4);
}

int inherited_5_()
{
    return int(5);
}

int value_7_()
{
    return int(7);
}

int add_3_int(int value_1)
{
    return asint(asuint(value_1) + asuint(int(3)));
}

uint add_7_unsigned(uint value_2)
{
    return (value_2 + uint(int(7)));
}

uint mixed_unsigned_5_()
{
    return uint(int(5));
}

int mixed_int_8_()
{
    return int(8);
}

uint flags_true_4u()
{
    return (uint(true) + 4u);
}

int cast_value_3_()
{
    return int(3);
}

int comma_value_2_()
{
    return int(2);
}

int shifted_4_()
{
    return int(4);
}

int choose_20_unsigned(uint value_3)
{
    return asint(asuint(int(value_3)) + asuint(int(20)));
}

int choose_20_int(int value_4)
{
    return asint(asuint(value_4) + asuint(int(20)));
}

int skipped_thread_true()
{
    return int(true);
}

int skipped_grid_false()
{
    return int(false);
}

int skipped_call_true()
{
    return int(true);
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void integral_template_defaults(uint3 threadIdx : SV_GroupThreadID)
{
    int N = (int)0;
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
    int state = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    bool local_17 = (bool)0;
    int local_18 = (int)0;
    bool local_19 = (bool)0;
    int local_20 = (int)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    int index = (int)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    int old = (int)0;
    int old_1 = (int)0;
    int old_2 = (int)0;
    int local_28 = (int)0;
    int local_29 = (int)0;
    int old_3 = (int)0;
    int local_30 = (int)0;
    int local_31 = (int)0;
    int old_4 = (int)0;

    threadIdx_1 = threadIdx;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 24u));
    N = int(99);
    const int _e9 = self_named_4_();
    output.Store(base*4, asuint(uint(_e9)));
    const int _e13 = inherited_5_();
    local = uint((base + 1u));
    uint _e19 = local;
    output.Store(_e19*4, asuint(uint(_e13)));
    const int _e21 = value_7_();
    local_1 = uint((base + 2u));
    uint _e27 = local_1;
    output.Store(_e27*4, asuint(uint(_e21)));
    const int _e29 = value_7_();
    local_2 = uint((base + 3u));
    uint _e35 = local_2;
    output.Store(_e35*4, asuint(uint(_e29)));
    const int _e37 = value_7_();
    local_3 = uint((base + 4u));
    uint _e43 = local_3;
    output.Store(_e43*4, asuint(uint(_e37)));
    const int _e46 = add_3_int(int(2));
    local_4 = uint((base + 5u));
    uint _e52 = local_4;
    output.Store(_e52*4, asuint(uint(_e46)));
    const uint _e55 = add_7_unsigned(3u);
    local_5 = uint((base + 6u));
    uint _e60 = local_5;
    output.Store(_e60*4, asuint(_e55));
    const uint _e62 = mixed_unsigned_5_();
    local_6 = uint((base + 7u));
    uint _e67 = local_6;
    output.Store(_e67*4, asuint(_e62));
    const int _e69 = mixed_int_8_();
    local_7 = uint((base + 8u));
    uint _e75 = local_7;
    output.Store(_e75*4, asuint(uint(_e69)));
    const uint _e77 = flags_true_4u();
    local_8 = uint((base + 9u));
    uint _e82 = local_8;
    output.Store(_e82*4, asuint(_e77));
    const int _e84 = cast_value_3_();
    local_9 = uint((base + 10u));
    uint _e90 = local_9;
    output.Store(_e90*4, asuint(uint(_e84)));
    const int _e92 = comma_value_2_();
    local_10 = uint((base + 11u));
    uint _e98 = local_10;
    output.Store(_e98*4, asuint(uint(_e92)));
    const int _e100 = shifted_4_();
    local_11 = uint((base + 12u));
    uint _e106 = local_11;
    output.Store(_e106*4, asuint(uint(_e100)));
    const int _e109 = choose(int(1));
    local_12 = uint((base + 13u));
    uint _e115 = local_12;
    output.Store(_e115*4, asuint(uint(_e109)));
    const int _e118 = choose_20_unsigned(1u);
    local_13 = uint((base + 14u));
    uint _e124 = local_13;
    output.Store(_e124*4, asuint(uint(_e118)));
    const int _e127 = choose_20_int(int(1));
    local_14 = uint((base + 15u));
    uint _e133 = local_14;
    output.Store(_e133*4, asuint(uint(_e127)));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    old = ZeroValueint();
    int _e141 = state;
    old = _e141;
    int _e143 = state;
    state = asint(asuint(_e143) + asuint(int(2)));
    int _e146 = old;
    local_15 = uint((base + 16u));
    uint _e152 = local_15;
    output.Store(_e152*4, asuint(uint(_e146)));
    old_1 = ZeroValueint();
    int _e156 = state;
    old_1 = _e156;
    int _e158 = state;
    state = asint(asuint(_e158) + asuint(int(3)));
    int _e161 = old_1;
    local_16 = uint((base + 17u));
    uint _e167 = local_16;
    output.Store(_e167*4, asuint(uint(_e161)));
    local_17 = false;
    if (false) {
        old_2 = ZeroValueint();
        int _e173 = state;
        local_28 = _e173;
        int _e175 = local_28;
        old_2 = _e175;
        int _e177 = state;
        local_29 = _e177;
        int _e179 = local_29;
        state = asint(asuint(_e179) + asuint(int(2)));
        int _e182 = old_2;
        local_18 = _e182;
        int _e184 = local_18;
        local_17 = (_e184 != int(0));
    }
    local_19 = true;
    if (true) {
    } else {
        old_3 = ZeroValueint();
        int _e191 = state;
        local_30 = _e191;
        int _e193 = local_30;
        old_3 = _e193;
        int _e195 = state;
        local_31 = _e195;
        int _e197 = local_31;
        state = asint(asuint(_e197) + asuint(int(2)));
        int _e200 = old_3;
        local_20 = _e200;
        int _e202 = local_20;
        local_19 = (_e202 != int(0));
    }
    old_4 = ZeroValueint();
    int _e207 = state;
    old_4 = _e207;
    int _e209 = state;
    state = asint(asuint(_e209) + asuint(int(2)));
    int _e212 = state;
    local_21 = uint((base + 18u));
    uint _e218 = local_21;
    output.Store(_e218*4, asuint(uint(_e212)));
    const int _e220 = skipped_thread_true();
    local_22 = uint((base + 19u));
    uint _e226 = local_22;
    output.Store(_e226*4, asuint(uint(_e220)));
    const int _e228 = skipped_grid_false();
    local_23 = uint((base + 20u));
    uint _e234 = local_23;
    output.Store(_e234*4, asuint(uint(_e228)));
    const int _e236 = skipped_call_true();
    local_24 = uint((base + 21u));
    uint _e242 = local_24;
    output.Store(_e242*4, asuint(uint(_e236)));
    index = int(0);
    int _e246 = index;
    index = asint(asuint(_e246) + asuint(int(1)));
    local_26 = uint(_e246);
    uint _e251 = local_26;
    int _e254 = asint(input.Load(_e251*4));
    const int _e255 = add_3_int(_e254);
    local_25 = uint((base + 22u));
    uint _e261 = local_25;
    output.Store(_e261*4, asuint(uint(_e255)));
    int _e263 = index;
    local_27 = uint((base + 23u));
    uint _e269 = local_27;
    output.Store(_e269*4, asuint(uint(_e263)));
}
