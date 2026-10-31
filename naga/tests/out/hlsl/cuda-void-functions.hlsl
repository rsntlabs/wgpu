struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n : register(b1) { type_5 n; }

int next_value(int value_1)
{
    return asint(asuint(value_1) + asuint(int(1)));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

void consume(bool stop, int value_2, uint count, float scale)
{
    int value_3 = (int)0;

    value_3 = value_2;
    int _e5 = value_3;
    value_3 = int((uint(_e5) + count));
    if (stop) {
        return;
    }
    int _e9 = value_3;
    value_3 = naga_f2i32((float(_e9) * scale));
    return;
}

void forward(bool stop_1, int value_4)
{
    const int _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5);
    return;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void void_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int iterations = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 6u);
        value = int(2);
        int _e16 = value;
        value = asint(asuint(_e16) + asuint(int(1)));
        consume(false, _e16, 1u, 1.5);
        int _e22 = value;
        uint _e23 = base;
        local = _e23;
        uint _e25 = local;
        local_6 = _e25;
        uint _e27 = local_6;
        out_.Store(_e27*4, asuint(_e22));
        int _e30 = value;
        value = asint(asuint(_e30) + asuint(int(1)));
        const int _e33 = next_value(_e30);
        consume(true, _e33, 2u, 0.5);
        int _e37 = value;
        uint _e38 = base;
        local_1 = uint((_e38 + 1u));
        uint _e43 = local_1;
        local_7 = _e43;
        uint _e45 = local_7;
        out_.Store(_e45*4, asuint(_e37));
        int _e51 = value;
        value = asint(asuint(_e51) + asuint(int(1)));
        forward((naga_mod(i, 2u) == 0u), _e51);
        int _e54 = value;
        uint _e55 = base;
        local_2 = uint((_e55 + 2u));
        uint _e60 = local_2;
        local_8 = _e60;
        uint _e62 = local_8;
        out_.Store(_e62*4, asuint(_e54));
        iterations = int(0);
        {
            int _e66 = value;
            value = asint(asuint(_e66) + asuint(int(1)));
            consume((int(0) != int(0)), _e66, uint(int(0)), float(1u));
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e85 = value;
                    value = asint(asuint(_e85) + asuint(int(1)));
                    int _e88 = value;
                    consume(false, _e88, 0u, 1.0);
                }
                loop_init = false;
                int _e76 = iterations;
                if ((_e76 < int(3))) {
                } else {
                    break;
                }
                int _e79 = iterations;
                iterations = asint(asuint(_e79) + asuint(int(1)));
                int _e82 = iterations;
                if ((_e82 == int(1))) {
                    continue;
                }
            }
        }
        int _e92 = value;
        uint _e93 = base;
        local_3 = uint((_e93 + 3u));
        uint _e98 = local_3;
        local_9 = _e98;
        uint _e100 = local_9;
        out_.Store(_e100*4, asuint(_e92));
        int _e102 = iterations;
        uint _e103 = base;
        local_4 = uint((_e103 + 4u));
        uint _e108 = local_4;
        local_10 = _e108;
        uint _e110 = local_10;
        out_.Store(_e110*4, asuint(_e102));
        int _e112 = value;
        const int _e113 = next_value(_e112);
        uint _e114 = base;
        local_5 = uint((_e114 + 5u));
        uint _e119 = local_5;
        local_11 = _e119;
        uint _e121 = local_11;
        out_.Store(_e121*4, asuint(_e113));
    }
}
