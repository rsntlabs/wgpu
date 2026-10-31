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
        local = uint(_e22);
        uint _e25 = local;
        local_10 = uint(_e25);
        uint _e28 = local_10;
        out_.Store(_e28*4, asuint(_e21));
        int _e31 = value;
        const float _e35 = affine(float(_e31), 1.5, int(2));
        uint _e36 = base;
        local_1 = uint((_e36 + 1u));
        uint _e42 = local_1;
        local_11 = uint(_e42);
        uint _e45 = local_11;
        out_.Store(_e45*4, asuint(naga_f2i32(_e35)));
        const uint _e50 = sum_steps(uint(int(5)), true);
        uint _e51 = base;
        local_2 = uint((_e51 + 2u));
        uint _e57 = local_2;
        local_12 = uint(_e57);
        uint _e60 = local_12;
        out_.Store(_e60*4, asuint(int(_e50)));
        const uint _e66 = sum_steps(5u, (int(0) != int(0)));
        uint _e67 = base;
        local_3 = uint((_e67 + 3u));
        uint _e73 = local_3;
        local_13 = uint(_e73);
        uint _e76 = local_13;
        out_.Store(_e76*4, asuint(int(_e66)));
        int _e78 = value;
        const float _e84 = affine(float(_e78), float(2u), int(true));
        uint _e85 = base;
        local_4 = uint((_e85 + 4u));
        uint _e91 = local_4;
        local_14 = uint(_e91);
        uint _e94 = local_14;
        out_.Store(_e94*4, asuint(naga_f2i32(_e84)));
        int _e96 = value;
        uint _e97 = base;
        local_5 = uint((_e97 + 5u));
        uint _e102 = local_5;
        local_15 = uint(_e102);
        uint _e105 = local_15;
        out_.Store(_e105*4, asuint(_e96));
        int _e107 = value;
        const int _e108 = choose(_e107);
        int _e109 = value;
        const int _e112 = choose(asint(asuint(_e109) + asuint(int(1))));
        uint _e114 = base;
        local_6 = uint((_e114 + 6u));
        uint _e119 = local_6;
        local_16 = uint(_e119);
        uint _e122 = local_16;
        out_.Store(_e122*4, asuint(asint(asuint(_e108) + asuint(_e112))));
        int _e124 = value;
        const bool _e125 = nonnegative(_e124);
        uint _e126 = base;
        local_7 = uint((_e126 + 7u));
        uint _e132 = local_7;
        local_17 = uint(_e132);
        uint _e135 = local_17;
        out_.Store(_e135*4, asuint(int(_e125)));
        int _e137 = argument;
        int _e138 = argument;
        argument = asint(asuint(_e138) + asuint(int(1)));
        const int _e141 = pair(_e137, _e138);
        uint _e142 = base;
        local_8 = uint((_e142 + 8u));
        uint _e147 = local_8;
        local_18 = uint(_e147);
        uint _e150 = local_18;
        out_.Store(_e150*4, asuint(_e141));
        int _e152 = argument;
        uint _e153 = base;
        local_9 = uint((_e153 + 9u));
        uint _e158 = local_9;
        local_19 = uint(_e158);
        uint _e161 = local_19;
        out_.Store(_e161*4, asuint(_e152));
    }
}
