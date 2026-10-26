struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n_1 : register(b2) { type_5 n_1; }

int select_value(int value_1, bool choose_first)
{
    int value_2 = (int)0;
    bool choose_first_1 = (bool)0;
    int result = (int)0;

    value_2 = value_1;
    choose_first_1 = choose_first;
    bool _e5 = choose_first_1;
    if (_e5) {
        int _e7 = value_2;
        result = asint(asuint(_e7) + asuint(int(3)));
    } else {
        int _e10 = value_2;
        result = asint(asuint(_e10) - asuint(int(2)));
    }
    int _e12 = result;
    return _e12;
}

float scaled(float value_3)
{
    float value_4 = (float)0;
    float result_1 = (float)0;

    value_4 = value_3;
    float _e4 = value_4;
    result_1 = ((_e4 * 2.0) + 4.0);
    float _e8 = result_1;
    return _e8;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint accumulate(uint limit)
{
    uint limit_1 = (uint)0;
    uint sum = (uint)0;
    uint i_1 = (uint)0;
    uint term = (uint)0;

    limit_1 = limit;
    sum = 0u;
    {
        i_1 = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e9 = i_1;
                i_1 = (_e9 + uint(int(1)));
            }
            loop_init = false;
            uint _e6 = i_1;
            uint _e7 = limit_1;
            if ((_e6 < _e7)) {
            } else {
                break;
            }
            uint _e15 = i_1;
            if ((naga_mod(_e15, 2u) == 0u)) {
                uint _e20 = i_1;
                term = (_e20 + 1u);
            } else {
                uint _e23 = i_1;
                term = (_e23 * 2u);
            }
            uint _e25 = term;
            uint _e26 = sum;
            sum = (_e26 + _e25);
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
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    int chosen = (int)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    float weighted = (float)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    bool negative = (bool)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint magnitude = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int copied = (int)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    int descending = (int)0;
    int iteration_1 = (int)0;
    int staged = (int)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    int remaining = (int)0;
    int partial = (int)0;
    int next = (int)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    int shadow = (int)0;
    int shadow_1 = (int)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    int local_42 = (int)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;

    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 12u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_41 = uint((_e32 + _e33));
        uint _e38 = local_41;
        int _e40 = asint(input.Load(_e38*4));
        local_42 = _e40;
        int _e41 = local_42;
        value = _e41;
        uint _e43 = i;
        if ((naga_mod(_e43, 2u) == 0u)) {
            int _e48 = value;
            chosen = asint(asuint(_e48) + asuint(int(7)));
        } else {
            int _e52 = value;
            chosen = asint(asuint(_e52) - asuint(int(4)));
        }
        int _e57 = chosen;
        uint _e58 = local;
        local_5 = _e58;
        uint _e60 = local_5;
        local_6 = uint(_e60);
        uint _e63 = base;
        local_7 = uint(_e63);
        uint _e67 = local_6;
        uint _e68 = local_7;
        local_43 = uint((_e67 + _e68));
        uint _e72 = local_43;
        out_.Store(_e72*4, asuint(_e57));
        int _e74 = value;
        uint _e75 = i;
        const int _e80 = select_value(_e74, (naga_mod(_e75, 3u) == 0u));
        uint _e81 = local;
        local_8 = _e81;
        uint _e83 = local_8;
        local_9 = uint(_e83);
        uint _e86 = base;
        local_10 = uint((_e86 + 1u));
        uint _e91 = local_9;
        uint _e92 = local_10;
        local_44 = uint((_e91 + _e92));
        uint _e96 = local_44;
        out_.Store(_e96*4, asuint(_e80));
        int _e98 = value;
        weighted = ((float(_e98) * 1.5) + 2.0);
        float _e105 = weighted;
        uint _e107 = local;
        local_11 = _e107;
        uint _e109 = local_11;
        local_12 = uint(_e109);
        uint _e112 = base;
        local_13 = uint((_e112 + 2u));
        uint _e117 = local_12;
        uint _e118 = local_13;
        local_45 = uint((_e117 + _e118));
        uint _e122 = local_45;
        out_.Store(_e122*4, asuint(naga_f2i32(_e105)));
        int _e124 = value;
        negative = (_e124 < int(0));
        bool _e128 = negative;
        uint _e129 = local;
        local_14 = _e129;
        uint _e131 = local_14;
        local_15 = uint(_e131);
        uint _e134 = base;
        local_16 = uint((_e134 + 3u));
        uint _e140 = local_15;
        uint _e141 = local_16;
        local_46 = uint((_e140 + _e141));
        uint _e145 = local_46;
        out_.Store(_e145*4, asuint(int(_e128)));
        int _e147 = value;
        magnitude = uint(asint(asuint(_e147) + asuint(int(5))));
        uint _e152 = magnitude;
        uint _e155 = local;
        local_17 = _e155;
        uint _e157 = local_17;
        local_18 = uint(_e157);
        uint _e160 = base;
        local_19 = uint((_e160 + 4u));
        uint _e166 = local_18;
        uint _e167 = local_19;
        local_47 = uint((_e166 + _e167));
        uint _e171 = local_47;
        out_.Store(_e171*4, asuint(int((_e152 * 3u))));
        uint _e173 = i;
        const uint _e176 = accumulate(naga_mod(_e173, 5u));
        uint _e177 = local;
        local_20 = _e177;
        uint _e179 = local_20;
        local_21 = uint(_e179);
        uint _e182 = base;
        local_22 = uint((_e182 + 5u));
        uint _e188 = local_21;
        uint _e189 = local_22;
        local_48 = uint((_e188 + _e189));
        uint _e193 = local_48;
        out_.Store(_e193*4, asuint(int(_e176)));
        total = int(0);
        {
            iteration = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e209 = iteration;
                    iteration = asint(asuint(_e209) + asuint(int(1)));
                }
                loop_init_1 = false;
                int _e199 = iteration;
                if ((_e199 < int(3))) {
                } else {
                    break;
                }
                int _e202 = value;
                int _e203 = iteration;
                copied = asint(asuint(_e202) + asuint(_e203));
                int _e206 = copied;
                int _e207 = total;
                total = asint(asuint(_e207) + asuint(_e206));
            }
        }
        int _e212 = total;
        uint _e213 = local;
        local_23 = _e213;
        uint _e215 = local_23;
        local_24 = uint(_e215);
        uint _e218 = base;
        local_25 = uint((_e218 + 6u));
        uint _e223 = local_24;
        uint _e224 = local_25;
        local_49 = uint((_e223 + _e224));
        uint _e228 = local_49;
        out_.Store(_e228*4, asuint(_e212));
        descending = int(0);
        iteration_1 = int(0);
        {
            uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e244 = iteration_1;
                    iteration_1 = asint(asuint(_e244) + asuint(int(1)));
                }
                loop_init_2 = false;
                int _e234 = iteration_1;
                if ((_e234 < int(3))) {
                } else {
                    break;
                }
                int _e237 = value;
                int _e238 = iteration_1;
                staged = asint(asuint(_e237) - asuint(_e238));
                int _e241 = staged;
                int _e242 = descending;
                descending = asint(asuint(_e242) + asuint(_e241));
            }
        }
        int _e247 = descending;
        uint _e248 = local;
        local_26 = _e248;
        uint _e250 = local_26;
        local_27 = uint(_e250);
        uint _e253 = base;
        local_28 = uint((_e253 + 7u));
        uint _e258 = local_27;
        uint _e259 = local_28;
        local_50 = uint((_e258 + _e259));
        uint _e263 = local_50;
        out_.Store(_e263*4, asuint(_e247));
        remaining = int(2);
        int _e267 = value;
        partial = _e267;
        uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
        while(true) {
            if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e269 = remaining;
            if ((_e269 > int(0))) {
            } else {
                break;
            }
            {
                int _e272 = partial;
                int _e273 = remaining;
                next = asint(asuint(_e272) + asuint(_e273));
                int _e276 = next;
                partial = _e276;
                int _e277 = remaining;
                remaining = asint(asuint(_e277) - asuint(int(1)));
            }
        }
        int _e280 = partial;
        uint _e281 = local;
        local_29 = _e281;
        uint _e283 = local_29;
        local_30 = uint(_e283);
        uint _e286 = base;
        local_31 = uint((_e286 + 8u));
        uint _e291 = local_30;
        uint _e292 = local_31;
        local_51 = uint((_e291 + _e292));
        uint _e296 = local_51;
        out_.Store(_e296*4, asuint(_e280));
        int _e298 = value;
        shadow = _e298;
        {
            int _e300 = value;
            shadow_1 = asint(asuint(_e300) + asuint(int(10)));
            int _e304 = shadow_1;
            uint _e305 = local;
            local_32 = _e305;
            uint _e307 = local_32;
            local_33 = uint(_e307);
            uint _e310 = base;
            local_34 = uint((_e310 + 9u));
            uint _e315 = local_33;
            uint _e316 = local_34;
            local_52 = uint((_e315 + _e316));
            uint _e320 = local_52;
            out_.Store(_e320*4, asuint(_e304));
        }
        int _e322 = shadow;
        uint _e323 = local;
        local_35 = _e323;
        uint _e325 = local_35;
        local_36 = uint(_e325);
        uint _e328 = base;
        local_37 = uint((_e328 + 10u));
        uint _e333 = local_36;
        uint _e334 = local_37;
        local_53 = uint((_e333 + _e334));
        uint _e338 = local_53;
        out_.Store(_e338*4, asuint(_e322));
        int _e340 = value;
        const float _e342 = scaled(float(_e340));
        uint _e343 = local;
        local_38 = _e343;
        uint _e345 = local_38;
        local_39 = uint(_e345);
        uint _e348 = base;
        local_40 = uint((_e348 + 11u));
        uint _e354 = local_39;
        uint _e355 = local_40;
        local_54 = uint((_e354 + _e355));
        uint _e359 = local_54;
        out_.Store(_e359*4, asuint(naga_f2i32(_e342)));
    }
}
