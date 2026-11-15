static const int Count_1 = int(5);

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int kind(uint value_6)
{
    return int(2);
}

uint value_unsigned_5_()
{
    return uint(int(5));
}

uint self_named_unsigned()
{
    return uint(int(9));
}

int choose_3_(int value_7)
{
    return asint(asuint(int(3)) + asuint(value_7));
}

int choose_5_(uint value_8)
{
    return asint(asuint(asint(asuint(int(20)) + asuint(int(5)))) + asuint(int(value_8)));
}

int choose_7_(int value_9)
{
    return asint(asuint(int(7)) + asuint(value_9));
}

uint caller_1_()
{
    const uint _e0 = value_unsigned_5_();
    return _e0;
}

int ZeroValueint() {
    return (int)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void template_default_merging(uint3 threadIdx : SV_GroupThreadID)
{
    int Count = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int state = (int)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    bool local_11 = (bool)0;
    int local_12 = (int)0;
    bool local_13 = (bool)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    int index = (int)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    int value = (int)0;
    int old = (int)0;
    uint value_1 = (uint)0;
    int old_1 = (int)0;
    int value_2 = (int)0;
    int old_2 = (int)0;
    int local_20 = (int)0;
    int local_21 = (int)0;
    int value_3 = (int)0;
    int old_3 = (int)0;
    int local_22 = (int)0;
    int local_23 = (int)0;
    int value_4 = (int)0;
    int old_4 = (int)0;
    int value_5 = (int)0;
    int old_5 = (int)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    Count = int(99);
    const uint _e8 = value_unsigned_5_();
    output.Store(base*4, asuint(_e8));
    const uint _e11 = value_unsigned_5_();
    local = uint((base + 1u));
    uint _e16 = local;
    output.Store(_e16*4, asuint(_e11));
    const uint _e18 = value_unsigned_5_();
    local_1 = uint((base + 2u));
    uint _e23 = local_1;
    output.Store(_e23*4, asuint(_e18));
    const uint _e25 = value_unsigned_5_();
    local_2 = uint((base + 3u));
    uint _e30 = local_2;
    output.Store(_e30*4, asuint(_e25));
    const uint _e32 = self_named_unsigned();
    local_3 = uint((base + 4u));
    uint _e37 = local_3;
    output.Store(_e37*4, asuint(_e32));
    const uint _e39 = value_unsigned_5_();
    const int _e40 = kind(_e39);
    local_4 = uint((base + 5u));
    uint _e46 = local_4;
    output.Store(_e46*4, asuint(uint(_e40)));
    const int _e49 = choose_3_(int(1));
    local_5 = uint((base + 6u));
    uint _e55 = local_5;
    output.Store(_e55*4, asuint(uint(_e49)));
    const int _e58 = choose_5_(1u);
    local_6 = uint((base + 7u));
    uint _e64 = local_6;
    output.Store(_e64*4, asuint(uint(_e58)));
    const int _e67 = choose_7_(int(1));
    local_7 = uint((base + 8u));
    uint _e73 = local_7;
    output.Store(_e73*4, asuint(uint(_e67)));
    const uint _e75 = caller_1_();
    local_8 = uint((base + 9u));
    uint _e80 = local_8;
    output.Store(_e80*4, asuint(_e75));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    value = ZeroValueint();
    old = ZeroValueint();
    value = int(1);
    int _e92 = state;
    old = _e92;
    int _e94 = value;
    int _e97 = state;
    state = asint(asuint(_e97) + asuint(asint(asuint(int(2)) + asuint(_e94))));
    int _e99 = old;
    local_9 = uint((base + 10u));
    uint _e105 = local_9;
    output.Store(_e105*4, asuint(uint(_e99)));
    value_1 = ZeroValueuint();
    old_1 = ZeroValueint();
    value_1 = 2u;
    int _e113 = state;
    old_1 = _e113;
    uint _e115 = value_1;
    int _e119 = state;
    state = asint(asuint(_e119) + asuint(asint(asuint(int(3)) + asuint(int(_e115)))));
    int _e121 = old_1;
    local_10 = uint((base + 11u));
    uint _e127 = local_10;
    output.Store(_e127*4, asuint(uint(_e121)));
    local_11 = false;
    if (false) {
        value_2 = ZeroValueint();
        old_2 = ZeroValueint();
        value_2 = int(9);
        int _e137 = state;
        local_20 = _e137;
        int _e139 = local_20;
        old_2 = _e139;
        int _e141 = value_2;
        int _e144 = state;
        local_21 = _e144;
        int _e146 = local_21;
        state = asint(asuint(_e146) + asuint(asint(asuint(int(2)) + asuint(_e141))));
        int _e148 = old_2;
        local_12 = _e148;
        int _e150 = local_12;
        local_11 = (_e150 != int(0));
    }
    local_13 = true;
    if (true) {
    } else {
        value_3 = ZeroValueint();
        old_3 = ZeroValueint();
        value_3 = int(9);
        int _e161 = state;
        local_22 = _e161;
        int _e163 = local_22;
        old_3 = _e163;
        int _e165 = value_3;
        int _e168 = state;
        local_23 = _e168;
        int _e170 = local_23;
        state = asint(asuint(_e170) + asuint(asint(asuint(int(2)) + asuint(_e165))));
        int _e172 = old_3;
        local_14 = _e172;
        int _e174 = local_14;
        local_13 = (_e174 != int(0));
    }
    value_4 = ZeroValueint();
    old_4 = ZeroValueint();
    value_4 = int(0);
    int _e183 = state;
    old_4 = _e183;
    int _e185 = value_4;
    int _e188 = state;
    state = asint(asuint(_e188) + asuint(asint(asuint(int(2)) + asuint(_e185))));
    int _e190 = state;
    local_15 = uint((base + 12u));
    uint _e196 = local_15;
    output.Store(_e196*4, asuint(uint(_e190)));
    index = int(0);
    int _e200 = index;
    index = asint(asuint(_e200) + asuint(int(1)));
    local_17 = uint(_e200);
    uint _e205 = local_17;
    int _e208 = asint(input.Load(_e205*4));
    value_5 = ZeroValueint();
    old_5 = ZeroValueint();
    value_5 = _e208;
    int _e214 = state;
    old_5 = _e214;
    int _e216 = value_5;
    int _e219 = state;
    state = asint(asuint(_e219) + asuint(asint(asuint(int(2)) + asuint(_e216))));
    int _e221 = old_5;
    local_16 = uint((base + 13u));
    uint _e227 = local_16;
    output.Store(_e227*4, asuint(uint(_e221)));
    int _e229 = state;
    local_18 = uint((base + 14u));
    uint _e235 = local_18;
    output.Store(_e235*4, asuint(uint(_e229)));
    int _e237 = index;
    local_19 = uint((base + 15u));
    uint _e243 = local_19;
    output.Store(_e243*4, asuint(uint(_e237)));
}
