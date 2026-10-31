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
        local = uint(_e23);
        uint _e26 = local;
        local_6 = uint(_e26);
        uint _e29 = local_6;
        out_.Store(_e29*4, asuint(_e22));
        int _e32 = value;
        value = asint(asuint(_e32) + asuint(int(1)));
        const int _e35 = next_value(_e32);
        consume(true, _e35, 2u, 0.5);
        int _e39 = value;
        uint _e40 = base;
        local_1 = uint((_e40 + 1u));
        uint _e45 = local_1;
        local_7 = uint(_e45);
        uint _e48 = local_7;
        out_.Store(_e48*4, asuint(_e39));
        int _e54 = value;
        value = asint(asuint(_e54) + asuint(int(1)));
        forward((naga_mod(i, 2u) == 0u), _e54);
        int _e57 = value;
        uint _e58 = base;
        local_2 = uint((_e58 + 2u));
        uint _e63 = local_2;
        local_8 = uint(_e63);
        uint _e66 = local_8;
        out_.Store(_e66*4, asuint(_e57));
        iterations = int(0);
        {
            int _e70 = value;
            value = asint(asuint(_e70) + asuint(int(1)));
            consume((int(0) != int(0)), _e70, uint(int(0)), float(1u));
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e89 = value;
                    value = asint(asuint(_e89) + asuint(int(1)));
                    int _e92 = value;
                    consume(false, _e92, 0u, 1.0);
                }
                loop_init = false;
                int _e80 = iterations;
                if ((_e80 < int(3))) {
                } else {
                    break;
                }
                int _e83 = iterations;
                iterations = asint(asuint(_e83) + asuint(int(1)));
                int _e86 = iterations;
                if ((_e86 == int(1))) {
                    continue;
                }
            }
        }
        int _e96 = value;
        uint _e97 = base;
        local_3 = uint((_e97 + 3u));
        uint _e102 = local_3;
        local_9 = uint(_e102);
        uint _e105 = local_9;
        out_.Store(_e105*4, asuint(_e96));
        int _e107 = iterations;
        uint _e108 = base;
        local_4 = uint((_e108 + 4u));
        uint _e113 = local_4;
        local_10 = uint(_e113);
        uint _e116 = local_10;
        out_.Store(_e116*4, asuint(_e107));
        int _e118 = value;
        const int _e119 = next_value(_e118);
        uint _e120 = base;
        local_5 = uint((_e120 + 5u));
        uint _e125 = local_5;
        local_11 = uint(_e125);
        uint _e128 = local_11;
        out_.Store(_e128*4, asuint(_e119));
    }
}
