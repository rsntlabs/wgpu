struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n : register(b1) { type_5 n; }

float affine(float value_1, float scale, int offset)
{
    float value_2 = (float)0;

    value_2 = value_1;
    float _e4 = value_2;
    value_2 = (_e4 * scale);
    float _e6 = value_2;
    return (_e6 + float(offset));
}

bool nonnegative(int value_3)
{
    return (value_3 >= int(0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint sum_steps(uint count, bool include_even)
{
    uint total = (uint)0;
    uint i = (uint)0;
    bool local_20 = (bool)0;

    total = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e18 = i;
                i = (_e18 + uint(int(1)));
            }
            loop_init = false;
            uint _e6 = i;
            if ((_e6 < count)) {
            } else {
                break;
            }
            local_20 = include_even;
            if (include_even) {
            } else {
                uint _e9 = i;
                local_20 = (naga_mod(_e9, 2u) != 0u);
            }
            bool _e14 = local_20;
            if (_e14) {
                uint _e15 = i;
                uint _e16 = total;
                total = (_e16 + _e15);
            }
        }
    }
    uint _e22 = total;
    return _e22;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int choose(int value_4)
{
    const bool _e1 = nonnegative(value_4);
    if (_e1) {
        const float _e5 = affine(float(value_4), 2.0, int(1));
        return naga_f2i32(_e5);
    }
    return naga_neg(value_4);
}

int pair(int a, int b)
{
    return asint(asuint(asint(asuint(a) * asuint(int(10)))) + asuint(b));
}

[numthreads(64, 1, 1)]
void device_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    int argument = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
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

    uint n_1 = n.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 10u);
        value = asint(asuint(int(i_1)) - asuint(int(35)));
        argument = int(3);
        int _e20 = value;
        const int _e21 = choose(_e20);
        uint _e22 = base;
        local = _e22;
        uint _e24 = local;
        local_10 = _e24;
        uint _e26 = local_10;
        out_.Store(_e26*4, asuint(_e21));
        int _e29 = value;
        const float _e33 = affine(float(_e29), 1.5, int(2));
        uint _e34 = base;
        local_1 = uint((_e34 + 1u));
        uint _e40 = local_1;
        local_11 = _e40;
        uint _e42 = local_11;
        out_.Store(_e42*4, asuint(naga_f2i32(_e33)));
        const uint _e47 = sum_steps(uint(int(5)), true);
        uint _e48 = base;
        local_2 = uint((_e48 + 2u));
        uint _e54 = local_2;
        local_12 = _e54;
        uint _e56 = local_12;
        out_.Store(_e56*4, asuint(int(_e47)));
        const uint _e62 = sum_steps(5u, (int(0) != int(0)));
        uint _e63 = base;
        local_3 = uint((_e63 + 3u));
        uint _e69 = local_3;
        local_13 = _e69;
        uint _e71 = local_13;
        out_.Store(_e71*4, asuint(int(_e62)));
        int _e73 = value;
        const float _e79 = affine(float(_e73), float(2u), int(true));
        uint _e80 = base;
        local_4 = uint((_e80 + 4u));
        uint _e86 = local_4;
        local_14 = _e86;
        uint _e88 = local_14;
        out_.Store(_e88*4, asuint(naga_f2i32(_e79)));
        int _e90 = value;
        uint _e91 = base;
        local_5 = uint((_e91 + 5u));
        uint _e96 = local_5;
        local_15 = _e96;
        uint _e98 = local_15;
        out_.Store(_e98*4, asuint(_e90));
        int _e100 = value;
        const int _e101 = choose(_e100);
        int _e102 = value;
        const int _e105 = choose(asint(asuint(_e102) + asuint(int(1))));
        uint _e107 = base;
        local_6 = uint((_e107 + 6u));
        uint _e112 = local_6;
        local_16 = _e112;
        uint _e114 = local_16;
        out_.Store(_e114*4, asuint(asint(asuint(_e101) + asuint(_e105))));
        int _e116 = value;
        const bool _e117 = nonnegative(_e116);
        uint _e118 = base;
        local_7 = uint((_e118 + 7u));
        uint _e124 = local_7;
        local_17 = _e124;
        uint _e126 = local_17;
        out_.Store(_e126*4, asuint(int(_e117)));
        int _e128 = argument;
        int _e129 = argument;
        argument = asint(asuint(_e129) + asuint(int(1)));
        const int _e132 = pair(_e128, _e129);
        uint _e133 = base;
        local_8 = uint((_e133 + 8u));
        uint _e138 = local_8;
        local_18 = _e138;
        uint _e140 = local_18;
        out_.Store(_e140*4, asuint(_e132));
        int _e142 = argument;
        uint _e143 = base;
        local_9 = uint((_e143 + 9u));
        uint _e148 = local_9;
        local_19 = _e148;
        uint _e150 = local_19;
        out_.Store(_e150*4, asuint(_e142));
    }
}
