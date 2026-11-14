RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int ZeroValueint() {
    return (int)0;
}

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

[numthreads(4, 1, 1)]
void void_casts(uint3 threadIdx : SV_GroupThreadID)
{
    int value = (int)0;
    int local = (int)0;
    int local_1 = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int index = (int)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int turn = (int)0;
    uint local_9 = (uint)0;
    int Count = (int)0;
    int array[3] = (int[3])0;
    uint local_10 = (uint)0;
    int step_ = (int)0;
    int previous = (int)0;
    int local_11 = (int)0;
    int local_12 = (int)0;
    int step_1 = (int)0;
    int previous_1 = (int)0;
    int local_13 = (int)0;
    int local_14 = (int)0;
    int local_15 = (int)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 8u));
    value = asint(asuint(int(lane)) + asuint(int(1)));
    int _e10 = value;
    value = asint(asuint(_e10) + asuint(int(1)));
    int _e13 = value;
    value = asint(asuint(_e13) + asuint(int(1)));
    int _e16 = value;
    value = asint(asuint(_e16) + asuint(int(1)));
    int _e19 = value;
    output.Store(base*4, asuint(_e19));
    bool choose = ((lane & 1u) == 0u);
    if (choose) {
        step_ = ZeroValueint();
        previous = ZeroValueint();
        step_ = int(3);
        int _e32 = value;
        local_11 = _e32;
        int _e34 = local_11;
        previous = _e34;
        int _e36 = step_;
        int _e37 = value;
        local_12 = _e37;
        int _e39 = local_12;
        value = asint(asuint(_e39) + asuint(_e36));
        int _e41 = previous;
        local = _e41;
    } else {
        step_1 = ZeroValueint();
        previous_1 = ZeroValueint();
        step_1 = int(7);
        int _e49 = value;
        local_13 = _e49;
        int _e51 = local_13;
        previous_1 = _e51;
        int _e53 = step_1;
        int _e54 = value;
        local_14 = _e54;
        int _e56 = local_14;
        value = asint(asuint(_e56) + asuint(_e53));
        int _e58 = previous_1;
        local_1 = _e58;
    }
    int _e60 = value;
    local_2 = uint((base + 1u));
    uint _e65 = local_2;
    output.Store(_e65*4, asuint(_e60));
    int _e67 = value;
    value = asint(asuint(_e67) + asuint(int(1)));
    int _e70 = value;
    value = asint(asuint(_e70) + asuint(int(1)));
    int _e73 = value;
    local_3 = uint((base + 2u));
    uint _e78 = local_3;
    output.Store(_e78*4, asuint(_e73));
    index = int(0);
    int _e82 = index;
    index = asint(asuint(_e82) + asuint(int(1)));
    local_4 = uint(_e82);
    int _e87 = index;
    index = asint(asuint(_e87) + asuint(int(1)));
    local_5 = uint(_e87);
    int _e92 = index;
    local_6 = uint((base + 3u));
    uint _e97 = local_6;
    output.Store(_e97*4, asuint(_e92));
    int _e103 = asint(input.Load(uint(int(0))*4));
    local_7 = uint((base + 4u));
    uint _e108 = local_7;
    output.Store(_e108*4, asuint(_e103));
    local_15 = ZeroValueint();
    int _e112 = value;
    local_15 = _e112;
    int _e114 = local_15;
    value = asint(asuint(_e114) + asuint(int(1)));
    int _e117 = value;
    local_8 = uint((base + 5u));
    uint _e122 = local_8;
    output.Store(_e122*4, asuint(_e117));
    {
        turn = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e132 = turn;
                turn = asint(asuint(_e132) + asuint(int(1)));
            }
            loop_init = false;
            int _e126 = turn;
            if ((_e126 < int(2))) {
            } else {
                break;
            }
            int _e129 = value;
            value = asint(asuint(_e129) + asuint(int(1)));
        }
    }
    int _e135 = value;
    local_9 = uint((base + 6u));
    uint _e140 = local_9;
    output.Store(_e140*4, asuint(_e135));
    int runtime = asint(input.Load(uint(int(1))*4));
    Count = int(3);
    array = ZeroValuearray3_int_();
    int _e152 = array[int(2)];
    local_10 = uint((base + 7u));
    uint _e157 = local_10;
    output.Store(_e157*4, asuint(_e152));
}
