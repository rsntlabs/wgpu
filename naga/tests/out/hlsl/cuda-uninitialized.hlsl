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
        local = i_1;
        uint _e15 = local;
        local_14 = _e15;
        uint _e17 = local_14;
        int _e20 = asint(input.Load(_e17*4));
        local_15 = _e20;
        int _e22 = local_15;
        local_13 = _e22;
        int _e24 = local_13;
        value = _e24;
        if ((naga_mod(i_1, 2u) == 0u)) {
            int _e30 = value;
            chosen = asint(asuint(_e30) + asuint(int(7)));
        } else {
            int _e34 = value;
            chosen = asint(asuint(_e34) - asuint(int(4)));
        }
        int _e39 = chosen;
        uint _e40 = base;
        local_1 = _e40;
        uint _e42 = local_1;
        local_16 = _e42;
        uint _e44 = local_16;
        out_.Store(_e44*4, asuint(_e39));
        int _e47 = value;
        const int _e52 = select_value(_e47, (naga_mod(i_1, 3u) == 0u));
        uint _e53 = base;
        local_2 = uint((_e53 + 1u));
        uint _e58 = local_2;
        local_17 = _e58;
        uint _e60 = local_17;
        out_.Store(_e60*4, asuint(_e52));
        int _e62 = value;
        weighted = ((float(_e62) * 1.5) + 2.0);
        float _e69 = weighted;
        uint _e71 = base;
        local_3 = uint((_e71 + 2u));
        uint _e76 = local_3;
        local_18 = _e76;
        uint _e78 = local_18;
        out_.Store(_e78*4, asuint(naga_f2i32(_e69)));
        int _e80 = value;
        negative = (_e80 < int(0));
        bool _e84 = negative;
        uint _e85 = base;
        local_4 = uint((_e85 + 3u));
        uint _e91 = local_4;
        local_19 = _e91;
        uint _e93 = local_19;
        out_.Store(_e93*4, asuint(int(_e84)));
        int _e95 = value;
        magnitude = uint(asint(asuint(_e95) + asuint(int(5))));
        uint _e100 = magnitude;
        uint _e103 = base;
        local_5 = uint((_e103 + 4u));
        uint _e109 = local_5;
        local_20 = _e109;
        uint _e111 = local_20;
        out_.Store(_e111*4, asuint(int((_e100 * 3u))));
        const uint _e115 = accumulate(naga_mod(i_1, 5u));
        uint _e116 = base;
        local_6 = uint((_e116 + 5u));
        uint _e122 = local_6;
        local_21 = _e122;
        uint _e124 = local_21;
        out_.Store(_e124*4, asuint(int(_e115)));
        total = int(0);
        {
            iteration = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e140 = iteration;
                    iteration = asint(asuint(_e140) + asuint(int(1)));
                }
                loop_init_1 = false;
                int _e130 = iteration;
                if ((_e130 < int(3))) {
                } else {
                    break;
                }
                int _e133 = value;
                int _e134 = iteration;
                copied = asint(asuint(_e133) + asuint(_e134));
                int _e137 = copied;
                int _e138 = total;
                total = asint(asuint(_e138) + asuint(_e137));
            }
        }
        int _e143 = total;
        uint _e144 = base;
        local_7 = uint((_e144 + 6u));
        uint _e149 = local_7;
        local_22 = _e149;
        uint _e151 = local_22;
        out_.Store(_e151*4, asuint(_e143));
        descending = int(0);
        iteration_1 = int(0);
        {
            uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e167 = iteration_1;
                    iteration_1 = asint(asuint(_e167) + asuint(int(1)));
                }
                loop_init_2 = false;
                int _e157 = iteration_1;
                if ((_e157 < int(3))) {
                } else {
                    break;
                }
                int _e160 = value;
                int _e161 = iteration_1;
                staged = asint(asuint(_e160) - asuint(_e161));
                int _e164 = staged;
                int _e165 = descending;
                descending = asint(asuint(_e165) + asuint(_e164));
            }
        }
        int _e170 = descending;
        uint _e171 = base;
        local_8 = uint((_e171 + 7u));
        uint _e176 = local_8;
        local_23 = _e176;
        uint _e178 = local_23;
        out_.Store(_e178*4, asuint(_e170));
        remaining = int(2);
        int _e182 = value;
        partial = _e182;
        uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
        while(true) {
            if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e184 = remaining;
            if ((_e184 > int(0))) {
            } else {
                break;
            }
            {
                int _e187 = partial;
                int _e188 = remaining;
                next = asint(asuint(_e187) + asuint(_e188));
                int _e191 = next;
                partial = _e191;
                int _e192 = remaining;
                remaining = asint(asuint(_e192) - asuint(int(1)));
            }
        }
        int _e195 = partial;
        uint _e196 = base;
        local_9 = uint((_e196 + 8u));
        uint _e201 = local_9;
        local_24 = _e201;
        uint _e203 = local_24;
        out_.Store(_e203*4, asuint(_e195));
        int _e205 = value;
        shadow = _e205;
        {
            int _e207 = value;
            shadow_1 = asint(asuint(_e207) + asuint(int(10)));
            int _e211 = shadow_1;
            uint _e212 = base;
            local_10 = uint((_e212 + 9u));
            uint _e217 = local_10;
            local_25 = _e217;
            uint _e219 = local_25;
            out_.Store(_e219*4, asuint(_e211));
        }
        int _e221 = shadow;
        uint _e222 = base;
        local_11 = uint((_e222 + 10u));
        uint _e227 = local_11;
        local_26 = _e227;
        uint _e229 = local_26;
        out_.Store(_e229*4, asuint(_e221));
        int _e231 = value;
        const float _e233 = scaled(float(_e231));
        uint _e234 = base;
        local_12 = uint((_e234 + 11u));
        uint _e240 = local_12;
        local_27 = _e240;
        uint _e242 = local_27;
        out_.Store(_e242*4, asuint(naga_f2i32(_e233)));
    }
}
