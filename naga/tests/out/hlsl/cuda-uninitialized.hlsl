struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n : register(b2) { type_5 n; }

int select_value(int value_1, bool choose_first)
{
    int result = (int)0;

    if (choose_first) {
        result = asint(asuint(value_1) + asuint(int(3)));
    } else {
        result = asint(asuint(value_1) - asuint(int(2)));
    }
    int _e9 = result;
    return _e9;
}

float scaled(float value_2)
{
    float result_1 = ((value_2 * 2.0) + 4.0);
    return result_1;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint accumulate(uint limit)
{
    uint sum = (uint)0;
    uint i = (uint)0;
    uint term = (uint)0;

    sum = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e24 = i;
                i = (_e24 + uint(int(1)));
            }
            loop_init = false;
            uint _e5 = i;
            if ((_e5 < limit)) {
            } else {
                break;
            }
            uint _e7 = i;
            if ((naga_mod(_e7, 2u) == 0u)) {
                uint _e12 = i;
                term = (_e12 + 1u);
            } else {
                uint _e16 = i;
                term = (_e16 * 2u);
            }
            uint _e21 = term;
            uint _e22 = sum;
            sum = (_e22 + _e21);
        }
    }
    uint _e28 = sum;
    return _e28;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void uninitialized(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    int chosen = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    float weighted = (float)0;
    uint local_3 = (uint)0;
    bool negative = (bool)0;
    uint local_4 = (uint)0;
    uint magnitude = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int copied = (int)0;
    uint local_7 = (uint)0;
    int descending = (int)0;
    int iteration_1 = (int)0;
    int staged = (int)0;
    uint local_8 = (uint)0;
    int remaining = (int)0;
    int partial = (int)0;
    int next = (int)0;
    uint local_9 = (uint)0;
    int shadow = (int)0;
    int shadow_1 = (int)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    int local_13 = (int)0;
    uint local_14 = (uint)0;
    int local_15 = (int)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;

    uint n_1 = n.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 12u);
        local = uint(i_1);
        uint _e16 = local;
        local_14 = uint(_e16);
        uint _e19 = local_14;
        int _e22 = asint(input.Load(_e19*4));
        local_15 = _e22;
        int _e24 = local_15;
        local_13 = _e24;
        int _e26 = local_13;
        value = _e26;
        if ((naga_mod(i_1, 2u) == 0u)) {
            int _e32 = value;
            chosen = asint(asuint(_e32) + asuint(int(7)));
        } else {
            int _e36 = value;
            chosen = asint(asuint(_e36) - asuint(int(4)));
        }
        int _e41 = chosen;
        uint _e42 = base;
        local_1 = uint(_e42);
        uint _e45 = local_1;
        local_16 = uint(_e45);
        uint _e48 = local_16;
        out_.Store(_e48*4, asuint(_e41));
        int _e51 = value;
        const int _e56 = select_value(_e51, (naga_mod(i_1, 3u) == 0u));
        uint _e57 = base;
        local_2 = uint((_e57 + 1u));
        uint _e62 = local_2;
        local_17 = uint(_e62);
        uint _e65 = local_17;
        out_.Store(_e65*4, asuint(_e56));
        int _e67 = value;
        weighted = ((float(_e67) * 1.5) + 2.0);
        float _e74 = weighted;
        uint _e76 = base;
        local_3 = uint((_e76 + 2u));
        uint _e81 = local_3;
        local_18 = uint(_e81);
        uint _e84 = local_18;
        out_.Store(_e84*4, asuint(naga_f2i32(_e74)));
        int _e86 = value;
        negative = (_e86 < int(0));
        bool _e90 = negative;
        uint _e91 = base;
        local_4 = uint((_e91 + 3u));
        uint _e97 = local_4;
        local_19 = uint(_e97);
        uint _e100 = local_19;
        out_.Store(_e100*4, asuint(int(_e90)));
        int _e102 = value;
        magnitude = uint(asint(asuint(_e102) + asuint(int(5))));
        uint _e107 = magnitude;
        uint _e110 = base;
        local_5 = uint((_e110 + 4u));
        uint _e116 = local_5;
        local_20 = uint(_e116);
        uint _e119 = local_20;
        out_.Store(_e119*4, asuint(int((_e107 * 3u))));
        const uint _e123 = accumulate(naga_mod(i_1, 5u));
        uint _e124 = base;
        local_6 = uint((_e124 + 5u));
        uint _e130 = local_6;
        local_21 = uint(_e130);
        uint _e133 = local_21;
        out_.Store(_e133*4, asuint(int(_e123)));
        total = int(0);
        {
            iteration = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e149 = iteration;
                    iteration = asint(asuint(_e149) + asuint(int(1)));
                }
                loop_init_1 = false;
                int _e139 = iteration;
                if ((_e139 < int(3))) {
                } else {
                    break;
                }
                int _e142 = value;
                int _e143 = iteration;
                copied = asint(asuint(_e142) + asuint(_e143));
                int _e146 = copied;
                int _e147 = total;
                total = asint(asuint(_e147) + asuint(_e146));
            }
        }
        int _e152 = total;
        uint _e153 = base;
        local_7 = uint((_e153 + 6u));
        uint _e158 = local_7;
        local_22 = uint(_e158);
        uint _e161 = local_22;
        out_.Store(_e161*4, asuint(_e152));
        descending = int(0);
        iteration_1 = int(0);
        {
            uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e177 = iteration_1;
                    iteration_1 = asint(asuint(_e177) + asuint(int(1)));
                }
                loop_init_2 = false;
                int _e167 = iteration_1;
                if ((_e167 < int(3))) {
                } else {
                    break;
                }
                int _e170 = value;
                int _e171 = iteration_1;
                staged = asint(asuint(_e170) - asuint(_e171));
                int _e174 = staged;
                int _e175 = descending;
                descending = asint(asuint(_e175) + asuint(_e174));
            }
        }
        int _e180 = descending;
        uint _e181 = base;
        local_8 = uint((_e181 + 7u));
        uint _e186 = local_8;
        local_23 = uint(_e186);
        uint _e189 = local_23;
        out_.Store(_e189*4, asuint(_e180));
        remaining = int(2);
        int _e193 = value;
        partial = _e193;
        uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
        while(true) {
            if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e195 = remaining;
            if ((_e195 > int(0))) {
            } else {
                break;
            }
            {
                int _e198 = partial;
                int _e199 = remaining;
                next = asint(asuint(_e198) + asuint(_e199));
                int _e202 = next;
                partial = _e202;
                int _e203 = remaining;
                remaining = asint(asuint(_e203) - asuint(int(1)));
            }
        }
        int _e206 = partial;
        uint _e207 = base;
        local_9 = uint((_e207 + 8u));
        uint _e212 = local_9;
        local_24 = uint(_e212);
        uint _e215 = local_24;
        out_.Store(_e215*4, asuint(_e206));
        int _e217 = value;
        shadow = _e217;
        {
            int _e219 = value;
            shadow_1 = asint(asuint(_e219) + asuint(int(10)));
            int _e223 = shadow_1;
            uint _e224 = base;
            local_10 = uint((_e224 + 9u));
            uint _e229 = local_10;
            local_25 = uint(_e229);
            uint _e232 = local_25;
            out_.Store(_e232*4, asuint(_e223));
        }
        int _e234 = shadow;
        uint _e235 = base;
        local_11 = uint((_e235 + 10u));
        uint _e240 = local_11;
        local_26 = uint(_e240);
        uint _e243 = local_26;
        out_.Store(_e243*4, asuint(_e234));
        int _e245 = value;
        const float _e247 = scaled(float(_e245));
        uint _e248 = base;
        local_12 = uint((_e248 + 11u));
        uint _e254 = local_12;
        local_27 = uint(_e254);
        uint _e257 = local_27;
        out_.Store(_e257*4, asuint(naga_f2i32(_e247)));
    }
}
