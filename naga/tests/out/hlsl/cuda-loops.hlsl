struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer n : register(b1) { type_3 n; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void loops(uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
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
                int _e25 = i;
                i = asint(asuint(_e25) + asuint(int(1)));
            }
            loop_init = false;
            int _e14 = i;
            if ((_e14 < n_1)) {
            } else {
                break;
            }
            int _e16 = i;
            if ((_e16 == int(2))) {
                continue;
            }
            int _e19 = i;
            if ((_e19 == int(7))) {
                break;
            }
            int _e22 = sum;
            int _e23 = i;
            sum = asint(asuint(_e22) + asuint(_e23));
        }
    }
    i_1 = int(0);
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e30 = i_1;
        if ((_e30 < int(3))) {
        } else {
            break;
        }
        {
            int _e33 = i_1;
            i_1 = asint(asuint(_e33) + asuint(int(1)));
            int _e36 = i_1;
            if ((_e36 == int(2))) {
                continue;
            }
            int _e39 = sum;
            sum = asint(asuint(_e39) + asuint(int(10)));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e48 = sum;
            if (!((_e48 < int(150)))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e42 = sum;
        sum = asint(asuint(_e42) + asuint(int(100)));
        int _e45 = sum;
        if ((_e45 > int(200))) {
            break;
        }
    }
    int _e52 = sum;
    uint _e54[2] = out_;
    local = _e54;
    local_1 = uint(threadIdx.x);
    uint _e59[2] = local;
    local_2 = _e59;
    uint _e61 = local_1;
    uint _e63 = local_2[1];
    local_2[1] = (_e63 + _e61);
    uint _e67 = local_2[0];
    local_3 = uint(_e67);
    uint _e71 = local_2[1];
    local_4 = uint(_e71);
    uint _e74 = local_4;
    out_1.Store(_e74*4, asuint(_e52));
}
