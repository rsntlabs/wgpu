struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n_1 : register(b1) { type_3 n_1; }

[numthreads(1, 1, 1)]
void loops(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    int n = (int)0;
    int sum = (int)0;
    int i = (int)0;
    int i_1 = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;

    local = 0u;
    int _e5 = n_1.value;
    n = _e5;
    sum = int(0);
    {
        i = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e23 = i;
                i = asint(asuint(_e23) + asuint(int(1)));
            }
            loop_init = false;
            int _e11 = i;
            int _e12 = n;
            if ((_e11 < _e12)) {
            } else {
                break;
            }
            int _e14 = i;
            if ((_e14 == int(2))) {
                continue;
            }
            int _e17 = i;
            if ((_e17 == int(7))) {
                break;
            }
            int _e20 = sum;
            int _e21 = i;
            sum = asint(asuint(_e20) + asuint(_e21));
        }
    }
    i_1 = int(0);
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e28 = i_1;
        if ((_e28 < int(3))) {
        } else {
            break;
        }
        {
            int _e31 = i_1;
            i_1 = asint(asuint(_e31) + asuint(int(1)));
            int _e34 = i_1;
            if ((_e34 == int(2))) {
                continue;
            }
            int _e37 = sum;
            sum = asint(asuint(_e37) + asuint(int(10)));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e46 = sum;
            if (!((_e46 < int(150)))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e40 = sum;
        sum = asint(asuint(_e40) + asuint(int(100)));
        int _e43 = sum;
        if ((_e43 > int(200))) {
            break;
        }
    }
    int _e50 = sum;
    uint _e51 = local;
    local_1 = _e51;
    uint _e53 = local_1;
    local_2 = uint(_e53);
    local_3 = uint(threadIdx.x);
    uint _e60 = local_2;
    uint _e61 = local_3;
    local_4 = uint((_e60 + _e61));
    uint _e65 = local_4;
    out_.Store(_e65*4, asuint(_e50));
}
