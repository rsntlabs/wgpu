struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer n_1 : register(b1) { type_3 n_1; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void loops(uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    int n = (int)0;
    int sum = (int)0;
    int i = (int)0;
    int i_1 = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    int _e10 = n_1.value;
    n = _e10;
    sum = int(0);
    {
        i = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e28 = i;
                i = asint(asuint(_e28) + asuint(int(1)));
            }
            loop_init = false;
            int _e16 = i;
            int _e17 = n;
            if ((_e16 < _e17)) {
            } else {
                break;
            }
            int _e19 = i;
            if ((_e19 == int(2))) {
                continue;
            }
            int _e22 = i;
            if ((_e22 == int(7))) {
                break;
            }
            int _e25 = sum;
            int _e26 = i;
            sum = asint(asuint(_e25) + asuint(_e26));
        }
    }
    i_1 = int(0);
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e33 = i_1;
        if ((_e33 < int(3))) {
        } else {
            break;
        }
        {
            int _e36 = i_1;
            i_1 = asint(asuint(_e36) + asuint(int(1)));
            int _e39 = i_1;
            if ((_e39 == int(2))) {
                continue;
            }
            int _e42 = sum;
            sum = asint(asuint(_e42) + asuint(int(10)));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e51 = sum;
            if (!((_e51 < int(150)))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e45 = sum;
        sum = asint(asuint(_e45) + asuint(int(100)));
        int _e48 = sum;
        if ((_e48 > int(200))) {
            break;
        }
    }
    int _e55 = sum;
    uint _e58[2] = out_;
    local = _e58;
    local_1 = uint(threadIdx.x);
    uint _e63[2] = local;
    local_2 = _e63;
    uint _e64 = local_1;
    uint _e66 = local_2[1];
    local_2[1] = (_e66 + _e64);
    uint _e70 = local_2[0];
    local_3 = uint(_e70);
    uint _e74 = local_2[1];
    local_4 = uint(_e74);
    uint _e77 = local_4;
    out_1.Store(_e77*4, asuint(_e55));
}
