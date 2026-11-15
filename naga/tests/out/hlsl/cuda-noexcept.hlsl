static const bool Safe = true;

RWByteAddressBuffer output : register(u0);

int choose_noexcept(int value_1)
{
    return asint(asuint(int(10)) + asuint(value_1));
}

int choose_noexcept_1(uint value_2)
{
    return asint(asuint(int(20)) + asuint(int(value_2)));
}

uint combined_noexcept(uint a, uint b)
{
    return ((((a & 65535u) + (b & 65535u)) & 65535u) | (((((a >> 16u) & 65535u) + ((b >> 16u) & 65535u)) & 65535u) << 16u));
}

int skipped_noexcept()
{
    bool local_37 = (bool)0;

    return int(7);
}

int converted_noexcept()
{
    return int(9);
}

int false_noexcept()
{
    return int(13);
}

int reverse_noexcept()
{
    return int(14);
}

int default_noexcept(int value_3)
{
    return asint(asuint(value_3) + asuint(int(4)));
}

int float_bool_noexcept()
{
    return int(15);
}

int ZeroValueint() {
    return (int)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void noexcept_helpers(uint3 threadIdx : SV_GroupThreadID)
{
    int value = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    bool local_8 = (bool)0;
    int local_9 = (int)0;
    bool local_10 = (bool)0;
    int local_11 = (int)0;
    int local_12 = (int)0;
    int local_13 = (int)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    int local_18 = (int)0;
    uint local_19 = (uint)0;
    int local_20 = (int)0;
    uint local_21 = (uint)0;
    int local_22 = (int)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    int amount = (int)0;
    int old = (int)0;
    int amount_1 = (int)0;
    int old_1 = (int)0;
    uint scale = (uint)0;
    uint scale_1 = (uint)0;
    int amount_2 = (int)0;
    int old_2 = (int)0;
    int local_29 = (int)0;
    int local_30 = (int)0;
    int amount_3 = (int)0;
    int old_3 = (int)0;
    int local_31 = (int)0;
    int local_32 = (int)0;
    int amount_4 = (int)0;
    int old_4 = (int)0;
    int local_33 = (int)0;
    int local_34 = (int)0;
    int amount_5 = (int)0;
    int old_5 = (int)0;
    int local_35 = (int)0;
    int local_36 = (int)0;
    int amount_6 = (int)0;
    int old_6 = (int)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 18u));
    value = asint(asuint(int(lane)) + asuint(int(1)));
    amount = ZeroValueint();
    old = ZeroValueint();
    amount = int(2);
    int _e16 = value;
    old = _e16;
    int _e18 = amount;
    int _e19 = value;
    value = asint(asuint(_e19) + asuint(_e18));
    int _e21 = old;
    output.Store(base*4, asuint(uint(_e21)));
    amount_1 = ZeroValueint();
    old_1 = ZeroValueint();
    amount_1 = int(5);
    int _e31 = value;
    old_1 = _e31;
    int _e33 = amount_1;
    int _e34 = value;
    value = asint(asuint(_e34) + asuint(_e33));
    int _e36 = old_1;
    local = uint((base + 1u));
    uint _e42 = local;
    output.Store(_e42*4, asuint(uint(_e36)));
    int _e44 = value;
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(uint(_e44)));
    const int _e53 = choose_noexcept(int(1));
    local_2 = uint((base + 3u));
    uint _e59 = local_2;
    output.Store(_e59*4, asuint(uint(_e53)));
    const int _e62 = choose_noexcept_1(1u);
    local_3 = uint((base + 4u));
    uint _e68 = local_3;
    output.Store(_e68*4, asuint(uint(_e62)));
    scale = ZeroValueuint();
    scale = 3u;
    int _e74 = value;
    value = asint(asuint(_e74) + asuint(int(1)));
    uint _e78 = scale;
    local_5 = (uint(_e74) * _e78);
    uint _e81 = local_5;
    scale_1 = ZeroValueuint();
    scale_1 = 5u;
    int _e86 = value;
    value = asint(asuint(_e86) + asuint(int(1)));
    uint _e90 = scale_1;
    local_6 = (uint(_e86) * _e90);
    uint _e93 = local_6;
    const uint _e94 = combined_noexcept(_e81, _e93);
    local_4 = uint((base + 5u));
    uint _e99 = local_4;
    output.Store(_e99*4, asuint(_e94));
    int _e101 = value;
    local_7 = uint((base + 6u));
    uint _e107 = local_7;
    output.Store(_e107*4, asuint(uint(_e101)));
    local_8 = false;
    if (false) {
        amount_2 = ZeroValueint();
        old_2 = ZeroValueint();
        amount_2 = int(2);
        int _e117 = value;
        local_29 = _e117;
        int _e119 = local_29;
        old_2 = _e119;
        int _e121 = amount_2;
        int _e122 = value;
        local_30 = _e122;
        int _e124 = local_30;
        value = asint(asuint(_e124) + asuint(_e121));
        int _e126 = old_2;
        local_9 = _e126;
        int _e128 = local_9;
        local_8 = (_e128 != int(0));
    }
    local_10 = true;
    if (true) {
    } else {
        amount_3 = ZeroValueint();
        old_3 = ZeroValueint();
        amount_3 = int(2);
        int _e139 = value;
        local_31 = _e139;
        int _e141 = local_31;
        old_3 = _e141;
        int _e143 = amount_3;
        int _e144 = value;
        local_32 = _e144;
        int _e146 = local_32;
        value = asint(asuint(_e146) + asuint(_e143));
        int _e148 = old_3;
        local_11 = _e148;
        int _e150 = local_11;
        local_10 = (_e150 != int(0));
    }
    if (((lane & 1u) == 0u)) {
        amount_4 = ZeroValueint();
        old_4 = ZeroValueint();
        amount_4 = int(2);
        int _e163 = value;
        local_33 = _e163;
        int _e165 = local_33;
        old_4 = _e165;
        int _e167 = amount_4;
        int _e168 = value;
        local_34 = _e168;
        int _e170 = local_34;
        value = asint(asuint(_e170) + asuint(_e167));
        int _e172 = old_4;
        local_12 = _e172;
        int _e174 = local_12;
        local_14 = _e174;
    } else {
        amount_5 = ZeroValueint();
        old_5 = ZeroValueint();
        amount_5 = int(3);
        int _e182 = value;
        local_35 = _e182;
        int _e184 = local_35;
        old_5 = _e184;
        int _e186 = amount_5;
        int _e187 = value;
        local_36 = _e187;
        int _e189 = local_36;
        value = asint(asuint(_e189) + asuint(_e186));
        int _e191 = old_5;
        local_13 = _e191;
        int _e193 = local_13;
        local_14 = _e193;
    }
    int _e195 = value;
    local_15 = uint((base + 7u));
    uint _e201 = local_15;
    output.Store(_e201*4, asuint(uint(_e195)));
    amount_6 = ZeroValueint();
    old_6 = ZeroValueint();
    amount_6 = int(2);
    int _e209 = value;
    old_6 = _e209;
    int _e211 = amount_6;
    int _e212 = value;
    value = asint(asuint(_e212) + asuint(_e211));
    int _e214 = value;
    local_16 = uint((base + 8u));
    uint _e220 = local_16;
    output.Store(_e220*4, asuint(uint(_e214)));
    int _e222 = value;
    local_18 = asint(asuint(_e222) + asuint(int(1)));
    int _e226 = local_18;
    local_17 = uint((base + 9u));
    uint _e232 = local_17;
    output.Store(_e232*4, asuint(uint(_e226)));
    int _e234 = value;
    local_20 = asint(asuint(_e234) + asuint(int(2)));
    int _e238 = local_20;
    local_19 = uint((base + 10u));
    uint _e244 = local_19;
    output.Store(_e244*4, asuint(uint(_e238)));
    int _e246 = value;
    local_22 = asint(asuint(_e246) + asuint(int(3)));
    int _e250 = local_22;
    local_21 = uint((base + 11u));
    uint _e256 = local_21;
    output.Store(_e256*4, asuint(uint(_e250)));
    const int _e258 = skipped_noexcept();
    local_23 = uint((base + 12u));
    uint _e264 = local_23;
    output.Store(_e264*4, asuint(uint(_e258)));
    const int _e266 = converted_noexcept();
    local_24 = uint((base + 13u));
    uint _e272 = local_24;
    output.Store(_e272*4, asuint(uint(_e266)));
    const int _e274 = false_noexcept();
    local_25 = uint((base + 14u));
    uint _e280 = local_25;
    output.Store(_e280*4, asuint(uint(_e274)));
    const int _e282 = reverse_noexcept();
    local_26 = uint((base + 15u));
    uint _e288 = local_26;
    output.Store(_e288*4, asuint(uint(_e282)));
    const int _e291 = default_noexcept(int(3));
    local_27 = uint((base + 16u));
    uint _e297 = local_27;
    output.Store(_e297*4, asuint(uint(_e291)));
    const int _e299 = float_bool_noexcept();
    local_28 = uint((base + 17u));
    uint _e305 = local_28;
    output.Store(_e305*4, asuint(uint(_e299)));
}
