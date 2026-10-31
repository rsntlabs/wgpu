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

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void uninitialized(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    int chosen = (int)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    float weighted = (float)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    bool negative = (bool)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint magnitude = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int copied = (int)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    int descending = (int)0;
    int iteration_1 = (int)0;
    int staged = (int)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    int remaining = (int)0;
    int partial = (int)0;
    int next = (int)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    int shadow = (int)0;
    int shadow_1 = (int)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    int local_28 = (int)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    int local_32 = (int)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 12u);
        uint _e35[2] = local_1;
        local_2 = _e35;
        uint _e36 = i;
        local_3 = uint(_e36);
        uint _e40[2] = local_2;
        local_29 = _e40;
        uint _e41 = local_3;
        uint _e43 = local_29[1];
        local_29[1] = (_e43 + _e41);
        uint _e47 = local_29[0];
        local_30 = uint(_e47);
        uint _e51 = local_29[1];
        local_31 = uint(_e51);
        uint _e55 = local_31;
        int _e57 = asint(input.Load(_e55*4));
        local_32 = _e57;
        int _e58 = local_32;
        local_28 = _e58;
        int _e60 = local_28;
        value = _e60;
        uint _e62 = i;
        if ((naga_mod(_e62, 2u) == 0u)) {
            int _e67 = value;
            chosen = asint(asuint(_e67) + asuint(int(7)));
        } else {
            int _e71 = value;
            chosen = asint(asuint(_e71) - asuint(int(4)));
        }
        int _e76 = chosen;
        uint _e79[2] = local;
        local_4 = _e79;
        uint _e80 = base;
        local_5 = uint(_e80);
        uint _e84[2] = local_4;
        local_33 = _e84;
        uint _e85 = local_5;
        uint _e87 = local_33[1];
        local_33[1] = (_e87 + _e85);
        uint _e91 = local_33[0];
        local_34 = uint(_e91);
        uint _e95 = local_33[1];
        local_35 = uint(_e95);
        uint _e98 = local_35;
        out_.Store(_e98*4, asuint(_e76));
        int _e100 = value;
        uint _e101 = i;
        const int _e106 = select_value(_e100, (naga_mod(_e101, 3u) == 0u));
        uint _e108[2] = local;
        local_6 = _e108;
        uint _e109 = base;
        local_7 = uint((_e109 + 1u));
        uint _e115[2] = local_6;
        local_36 = _e115;
        uint _e116 = local_7;
        uint _e118 = local_36[1];
        local_36[1] = (_e118 + _e116);
        uint _e122 = local_36[0];
        local_37 = uint(_e122);
        uint _e126 = local_36[1];
        local_38 = uint(_e126);
        uint _e129 = local_38;
        out_.Store(_e129*4, asuint(_e106));
        int _e131 = value;
        weighted = ((float(_e131) * 1.5) + 2.0);
        float _e138 = weighted;
        uint _e141[2] = local;
        local_8 = _e141;
        uint _e142 = base;
        local_9 = uint((_e142 + 2u));
        uint _e148[2] = local_8;
        local_39 = _e148;
        uint _e149 = local_9;
        uint _e151 = local_39[1];
        local_39[1] = (_e151 + _e149);
        uint _e155 = local_39[0];
        local_40 = uint(_e155);
        uint _e159 = local_39[1];
        local_41 = uint(_e159);
        uint _e162 = local_41;
        out_.Store(_e162*4, asuint(naga_f2i32(_e138)));
        int _e164 = value;
        negative = (_e164 < int(0));
        bool _e168 = negative;
        uint _e170[2] = local;
        local_10 = _e170;
        uint _e171 = base;
        local_11 = uint((_e171 + 3u));
        uint _e178[2] = local_10;
        local_42 = _e178;
        uint _e179 = local_11;
        uint _e181 = local_42[1];
        local_42[1] = (_e181 + _e179);
        uint _e185 = local_42[0];
        local_43 = uint(_e185);
        uint _e189 = local_42[1];
        local_44 = uint(_e189);
        uint _e192 = local_44;
        out_.Store(_e192*4, asuint(int(_e168)));
        int _e194 = value;
        magnitude = uint(asint(asuint(_e194) + asuint(int(5))));
        uint _e199 = magnitude;
        uint _e203[2] = local;
        local_12 = _e203;
        uint _e204 = base;
        local_13 = uint((_e204 + 4u));
        uint _e211[2] = local_12;
        local_45 = _e211;
        uint _e212 = local_13;
        uint _e214 = local_45[1];
        local_45[1] = (_e214 + _e212);
        uint _e218 = local_45[0];
        local_46 = uint(_e218);
        uint _e222 = local_45[1];
        local_47 = uint(_e222);
        uint _e225 = local_47;
        out_.Store(_e225*4, asuint(int((_e199 * 3u))));
        uint _e227 = i;
        const uint _e230 = accumulate(naga_mod(_e227, 5u));
        uint _e232[2] = local;
        local_14 = _e232;
        uint _e233 = base;
        local_15 = uint((_e233 + 5u));
        uint _e240[2] = local_14;
        local_48 = _e240;
        uint _e241 = local_15;
        uint _e243 = local_48[1];
        local_48[1] = (_e243 + _e241);
        uint _e247 = local_48[0];
        local_49 = uint(_e247);
        uint _e251 = local_48[1];
        local_50 = uint(_e251);
        uint _e254 = local_50;
        out_.Store(_e254*4, asuint(int(_e230)));
        total = int(0);
        {
            iteration = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e270 = iteration;
                    iteration = asint(asuint(_e270) + asuint(int(1)));
                }
                loop_init_1 = false;
                int _e260 = iteration;
                if ((_e260 < int(3))) {
                } else {
                    break;
                }
                int _e263 = value;
                int _e264 = iteration;
                copied = asint(asuint(_e263) + asuint(_e264));
                int _e267 = copied;
                int _e268 = total;
                total = asint(asuint(_e268) + asuint(_e267));
            }
        }
        int _e273 = total;
        uint _e275[2] = local;
        local_16 = _e275;
        uint _e276 = base;
        local_17 = uint((_e276 + 6u));
        uint _e282[2] = local_16;
        local_51 = _e282;
        uint _e283 = local_17;
        uint _e285 = local_51[1];
        local_51[1] = (_e285 + _e283);
        uint _e289 = local_51[0];
        local_52 = uint(_e289);
        uint _e293 = local_51[1];
        local_53 = uint(_e293);
        uint _e296 = local_53;
        out_.Store(_e296*4, asuint(_e273));
        descending = int(0);
        iteration_1 = int(0);
        {
            uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e312 = iteration_1;
                    iteration_1 = asint(asuint(_e312) + asuint(int(1)));
                }
                loop_init_2 = false;
                int _e302 = iteration_1;
                if ((_e302 < int(3))) {
                } else {
                    break;
                }
                int _e305 = value;
                int _e306 = iteration_1;
                staged = asint(asuint(_e305) - asuint(_e306));
                int _e309 = staged;
                int _e310 = descending;
                descending = asint(asuint(_e310) + asuint(_e309));
            }
        }
        int _e315 = descending;
        uint _e317[2] = local;
        local_18 = _e317;
        uint _e318 = base;
        local_19 = uint((_e318 + 7u));
        uint _e324[2] = local_18;
        local_54 = _e324;
        uint _e325 = local_19;
        uint _e327 = local_54[1];
        local_54[1] = (_e327 + _e325);
        uint _e331 = local_54[0];
        local_55 = uint(_e331);
        uint _e335 = local_54[1];
        local_56 = uint(_e335);
        uint _e338 = local_56;
        out_.Store(_e338*4, asuint(_e315));
        remaining = int(2);
        int _e342 = value;
        partial = _e342;
        uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
        while(true) {
            if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e344 = remaining;
            if ((_e344 > int(0))) {
            } else {
                break;
            }
            {
                int _e347 = partial;
                int _e348 = remaining;
                next = asint(asuint(_e347) + asuint(_e348));
                int _e351 = next;
                partial = _e351;
                int _e352 = remaining;
                remaining = asint(asuint(_e352) - asuint(int(1)));
            }
        }
        int _e355 = partial;
        uint _e357[2] = local;
        local_20 = _e357;
        uint _e358 = base;
        local_21 = uint((_e358 + 8u));
        uint _e364[2] = local_20;
        local_57 = _e364;
        uint _e365 = local_21;
        uint _e367 = local_57[1];
        local_57[1] = (_e367 + _e365);
        uint _e371 = local_57[0];
        local_58 = uint(_e371);
        uint _e375 = local_57[1];
        local_59 = uint(_e375);
        uint _e378 = local_59;
        out_.Store(_e378*4, asuint(_e355));
        int _e380 = value;
        shadow = _e380;
        {
            int _e382 = value;
            shadow_1 = asint(asuint(_e382) + asuint(int(10)));
            int _e386 = shadow_1;
            uint _e388[2] = local;
            local_22 = _e388;
            uint _e389 = base;
            local_23 = uint((_e389 + 9u));
            uint _e395[2] = local_22;
            local_60 = _e395;
            uint _e396 = local_23;
            uint _e398 = local_60[1];
            local_60[1] = (_e398 + _e396);
            uint _e402 = local_60[0];
            local_61 = uint(_e402);
            uint _e406 = local_60[1];
            local_62 = uint(_e406);
            uint _e409 = local_62;
            out_.Store(_e409*4, asuint(_e386));
        }
        int _e411 = shadow;
        uint _e413[2] = local;
        local_24 = _e413;
        uint _e414 = base;
        local_25 = uint((_e414 + 10u));
        uint _e420[2] = local_24;
        local_63 = _e420;
        uint _e421 = local_25;
        uint _e423 = local_63[1];
        local_63[1] = (_e423 + _e421);
        uint _e427 = local_63[0];
        local_64 = uint(_e427);
        uint _e431 = local_63[1];
        local_65 = uint(_e431);
        uint _e434 = local_65;
        out_.Store(_e434*4, asuint(_e411));
        int _e436 = value;
        const float _e438 = scaled(float(_e436));
        uint _e440[2] = local;
        local_26 = _e440;
        uint _e441 = base;
        local_27 = uint((_e441 + 11u));
        uint _e448[2] = local_26;
        local_66 = _e448;
        uint _e449 = local_27;
        uint _e451 = local_66[1];
        local_66[1] = (_e451 + _e449);
        uint _e455 = local_66[0];
        local_67 = uint(_e455);
        uint _e459 = local_66[1];
        local_68 = uint(_e459);
        uint _e462 = local_68;
        out_.Store(_e462*4, asuint(naga_f2i32(_e438)));
    }
}
