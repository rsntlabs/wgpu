struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n_1 : register(b1) { type_5 n_1; }

int next_value(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    return asint(asuint(_e3) + asuint(int(1)));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

void consume(bool stop, int value_3, uint count, float scale)
{
    bool stop_1 = (bool)0;
    int value_4 = (int)0;
    uint count_1 = (uint)0;
    float scale_1 = (float)0;

    stop_1 = stop;
    value_4 = value_3;
    count_1 = count;
    scale_1 = scale;
    uint _e8 = count_1;
    int _e9 = value_4;
    value_4 = int((uint(_e9) + _e8));
    bool _e13 = stop_1;
    if (_e13) {
        return;
    }
    float _e14 = scale_1;
    int _e15 = value_4;
    value_4 = naga_f2i32((float(_e15) * _e14));
    return;
}

void forward(bool stop_2, int value_5)
{
    bool stop_3 = (bool)0;
    int value_6 = (int)0;

    stop_3 = stop_2;
    value_6 = value_5;
    bool _e4 = stop_3;
    int _e5 = value_6;
    const int _e6 = next_value(_e5);
    consume(_e4, _e6, 2u, 0.5);
    return;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void void_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int iterations = (int)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;

    local = 0u;
    uint _e6 = n_1.value;
    n = _e6;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e14 = i;
    uint _e15 = n;
    if ((_e14 < _e15)) {
        uint _e17 = i;
        base = (_e17 * 6u);
        value = int(2);
        int _e23 = value;
        value = asint(asuint(_e23) + asuint(int(1)));
        consume(false, _e23, 1u, 1.5);
        int _e29 = value;
        uint _e30 = local;
        local_1 = _e30;
        uint _e32 = local_1;
        local_2 = uint(_e32);
        uint _e35 = base;
        local_3 = uint(_e35);
        uint _e39 = local_2;
        uint _e40 = local_3;
        local_19 = uint((_e39 + _e40));
        uint _e44 = local_19;
        out_.Store(_e44*4, asuint(_e29));
        int _e46 = value;
        value = asint(asuint(_e46) + asuint(int(1)));
        const int _e49 = next_value(_e46);
        consume(true, _e49, 2u, 0.5);
        int _e53 = value;
        uint _e54 = local;
        local_4 = _e54;
        uint _e56 = local_4;
        local_5 = uint(_e56);
        uint _e59 = base;
        local_6 = uint((_e59 + 1u));
        uint _e64 = local_5;
        uint _e65 = local_6;
        local_20 = uint((_e64 + _e65));
        uint _e69 = local_20;
        out_.Store(_e69*4, asuint(_e53));
        uint _e71 = i;
        int _e76 = value;
        value = asint(asuint(_e76) + asuint(int(1)));
        forward((naga_mod(_e71, 2u) == 0u), _e76);
        int _e79 = value;
        uint _e80 = local;
        local_7 = _e80;
        uint _e82 = local_7;
        local_8 = uint(_e82);
        uint _e85 = base;
        local_9 = uint((_e85 + 2u));
        uint _e90 = local_8;
        uint _e91 = local_9;
        local_21 = uint((_e90 + _e91));
        uint _e95 = local_21;
        out_.Store(_e95*4, asuint(_e79));
        iterations = int(0);
        {
            int _e99 = value;
            value = asint(asuint(_e99) + asuint(int(1)));
            consume((int(0) != int(0)), _e99, uint(int(0)), float(1u));
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e118 = value;
                    value = asint(asuint(_e118) + asuint(int(1)));
                    int _e121 = value;
                    consume(false, _e121, 0u, 1.0);
                }
                loop_init = false;
                int _e109 = iterations;
                if ((_e109 < int(3))) {
                } else {
                    break;
                }
                int _e112 = iterations;
                iterations = asint(asuint(_e112) + asuint(int(1)));
                int _e115 = iterations;
                if ((_e115 == int(1))) {
                    continue;
                }
            }
        }
        int _e125 = value;
        uint _e126 = local;
        local_10 = _e126;
        uint _e128 = local_10;
        local_11 = uint(_e128);
        uint _e131 = base;
        local_12 = uint((_e131 + 3u));
        uint _e136 = local_11;
        uint _e137 = local_12;
        local_22 = uint((_e136 + _e137));
        uint _e141 = local_22;
        out_.Store(_e141*4, asuint(_e125));
        int _e143 = iterations;
        uint _e144 = local;
        local_13 = _e144;
        uint _e146 = local_13;
        local_14 = uint(_e146);
        uint _e149 = base;
        local_15 = uint((_e149 + 4u));
        uint _e154 = local_14;
        uint _e155 = local_15;
        local_23 = uint((_e154 + _e155));
        uint _e159 = local_23;
        out_.Store(_e159*4, asuint(_e143));
        int _e161 = value;
        const int _e162 = next_value(_e161);
        uint _e163 = local;
        local_16 = _e163;
        uint _e165 = local_16;
        local_17 = uint(_e165);
        uint _e168 = base;
        local_18 = uint((_e168 + 5u));
        uint _e173 = local_17;
        uint _e174 = local_18;
        local_24 = uint((_e173 + _e174));
        uint _e178 = local_24;
        out_.Store(_e178*4, asuint(_e162));
    }
}
