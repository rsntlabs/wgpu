struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n : register(b1) { type_3 n; }

[numthreads(1, 1, 1)]
void loops(uint3 threadIdx : SV_GroupThreadID)
{
    int sum = (int)0;
    int i = (int)0;
    int i_1 = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;

    int n_1 = n.value;
    sum = int(0);
    {
        i = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e19 = i;
                i = asint(asuint(_e19) + asuint(int(1)));
            }
            loop_init = false;
            int _e8 = i;
            if ((_e8 < n_1)) {
            } else {
                break;
            }
            int _e10 = i;
            if ((_e10 == int(2))) {
                continue;
            }
            int _e13 = i;
            if ((_e13 == int(7))) {
                break;
            }
            int _e16 = sum;
            int _e17 = i;
            sum = asint(asuint(_e16) + asuint(_e17));
        }
    }
    i_1 = int(0);
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e24 = i_1;
        if ((_e24 < int(3))) {
        } else {
            break;
        }
        {
            int _e27 = i_1;
            i_1 = asint(asuint(_e27) + asuint(int(1)));
            int _e30 = i_1;
            if ((_e30 == int(2))) {
                continue;
            }
            int _e33 = sum;
            sum = asint(asuint(_e33) + asuint(int(10)));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e42 = sum;
            if (!((_e42 < int(150)))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e36 = sum;
        sum = asint(asuint(_e36) + asuint(int(100)));
        int _e39 = sum;
        if ((_e39 > int(200))) {
            break;
        }
    }
    int _e46 = sum;
    local = uint(threadIdx.x);
    uint _e50 = local;
    local_1 = uint(_e50);
    uint _e53 = local_1;
    out_.Store(_e53*4, asuint(_e46));
}
