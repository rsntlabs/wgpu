RWByteAddressBuffer out_ : register(u0);

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

int local_sum(int value)
{
    int values[3] = (int[3])0;

    values = ZeroValuearray3_int_();
    values[int(0)] = value;
    values[int(1)] = asint(asuint(value) + asuint(int(1)));
    int _e13 = values[int(0)];
    int _e14 = values[int(1)];
    values[int(2)] = asint(asuint(_e13) + asuint(_e14));
    int _e20 = values[int(2)];
    return _e20;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

int reset_sum(int count)
{
    int result = (int)0;
    int i_1 = (int)0;
    int values_1[2] = (int[2])0;

    result = int(0);
    {
        i_1 = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e24 = i_1;
                i_1 = asint(asuint(_e24) + asuint(int(1)));
            }
            loop_init = false;
            int _e5 = i_1;
            if ((_e5 < count)) {
            } else {
                break;
            }
            values_1 = ZeroValuearray2_int_();
            int _e9 = i_1;
            values_1[int(1)] = _e9;
            int _e16 = values_1[int(0)];
            int _e17 = values_1[int(1)];
            int _e19 = result;
            result = asint(asuint(_e19) + asuint(asint(asuint(_e16) + asuint(_e17))));
            values_1[int(0)] = int(99);
        }
    }
    int _e27 = result;
    return _e27;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_mod(int lhs, int rhs) {
    int divisor = ((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

typedef float ret_ZeroValuearray2_float_[2];
ret_ZeroValuearray2_float_ ZeroValuearray2_float_() {
    return (float[2])0;
}

typedef bool ret_ZeroValuearray3_bool_[3];
ret_ZeroValuearray3_bool_ ZeroValuearray3_bool_() {
    return (bool[3])0;
}

typedef bool ret_ZeroValuearray2_bool_[2];
ret_ZeroValuearray2_bool_ ZeroValuearray2_bool_() {
    return (bool[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void local_arrays()
{
    int seed = (int)0;
    uint local = (uint)0;
    int signed_values[3] = (int[3])0;
    uint local_1 = (uint)0;
    uint words[2] = (uint[2])0;
    uint local_2 = (uint)0;
    float samples[2] = (float[2])0;
    uint local_3 = (uint)0;
    bool flags[3] = (bool[3])0;
    uint local_4 = (uint)0;
    int zeros[2] = (int[2])0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    bool zero_flags[2] = (bool[2])0;
    uint local_8 = (uint)0;
    bool local_9 = (bool)0;
    uint bank[2] = (uint[2])0;
    float bank_1[2] = (float[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    int signed_values_1[2] = (int[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int mixed[2] = (int[2])0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int reset_total = (int)0;
    int i = (int)0;
    int reset[2] = (int[2])0;
    uint local_16 = (uint)0;
    int total = (int)0;
    int scratch[2] = (int[2])0;
    int j = (int)0;
    uint local_17 = (uint)0;
    float zero_samples[2] = (float[2])0;
    uint local_18 = (uint)0;
    int left[2] = (int[2])0;
    int right[2] = (int[2])0;
    uint local_19 = (uint)0;
    int temporary[2] = (int[2])0;
    int temporary_1[2] = (int[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    int index = (int)0;
    int rhs = (int)0;
    uint local_22 = (uint)0;
    int local_23 = (int)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    int local_27 = (int)0;
    uint local_28 = (uint)0;
    int local_29 = (int)0;
    uint local_30 = (uint)0;
    int local_31 = (int)0;
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
    uint local_42 = (uint)0;
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
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_30 = uint(_e3);
    uint _e6 = local_30;
    int _e9 = asint(out_.Load(_e6*4));
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int _e13 = local_29;
    seed = _e13;
    int _e15 = seed;
    signed_values[int(0)] = _e15;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e30 = signed_values[int(0)];
    int _e31 = signed_values[int(1)];
    int _e35 = signed_values[int(2)];
    local_1 = uint(int(0));
    uint _e40 = local_1;
    local_32 = uint(_e40);
    uint _e43 = local_32;
    out_.Store(_e43*4, asuint(asint(asuint(asint(asuint(_e30) + asuint(_e31))) + asuint(_e35))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e57 = words[int(0)];
    uint _e58 = words[int(1)];
    local_2 = uint(int(1));
    uint _e66 = local_2;
    local_33 = uint(_e66);
    uint _e69 = local_33;
    out_.Store(_e69*4, asuint(int(((_e57 + _e58) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e83 = samples[int(0)];
    float _e84 = samples[int(1)];
    local_3 = uint(int(2));
    uint _e92 = local_3;
    local_34 = uint(_e92);
    uint _e95 = local_34;
    out_.Store(_e95*4, asuint(naga_f2i32(((_e83 + _e84) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e99 = seed;
    flags[int(0)] = (_e99 != int(0));
    flags[int(2)] = true;
    bool _e109 = flags[int(0)];
    bool _e115 = flags[int(1)];
    bool _e122 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e128 = local_4;
    local_35 = uint(_e128);
    uint _e131 = local_35;
    out_.Store(_e131*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e109)) * asuint(int(100)))) + asuint(asint(asuint(int(_e115)) * asuint(int(10)))))) + asuint(int(_e122)))));
    zeros = ZeroValuearray2_int_();
    int _e139 = zeros[int(0)];
    int _e140 = zeros[int(1)];
    local_5 = uint(int(4));
    uint _e145 = local_5;
    local_36 = uint(_e145);
    uint _e148 = local_36;
    out_.Store(_e148*4, asuint(asint(asuint(_e139) + asuint(_e140))));
    int _e150 = seed;
    const int _e151 = local_sum(_e150);
    local_6 = uint(int(5));
    uint _e155 = local_6;
    local_37 = uint(_e155);
    uint _e158 = local_37;
    out_.Store(_e158*4, asuint(_e151));
    const int _e161 = reset_sum(int(3));
    local_7 = uint(int(6));
    uint _e165 = local_7;
    local_38 = uint(_e165);
    uint _e168 = local_38;
    out_.Store(_e168*4, asuint(_e161));
    zero_flags = ZeroValuearray2_bool_();
    bool _e174 = zero_flags[int(0)];
    local_9 = _e174;
    if (_e174) {
    } else {
        bool _e178 = zero_flags[int(1)];
        local_9 = _e178;
    }
    bool _e179 = local_9;
    local_8 = uint(int(7));
    uint _e184 = local_8;
    local_39 = uint(_e184);
    uint _e187 = local_39;
    out_.Store(_e187*4, asuint(int(_e179)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e206 = bank_1[int(0)];
        float _e207 = bank_1[int(1)];
        local_10 = uint(int(8));
        uint _e213 = local_10;
        local_40 = uint(_e213);
        uint _e216 = local_40;
        out_.Store(_e216*4, asuint(naga_f2i32((_e206 + _e207))));
    }
    uint _e222 = bank[int(0)];
    uint _e223 = bank[int(1)];
    local_11 = uint(int(9));
    uint _e229 = local_11;
    local_41 = uint(_e229);
    uint _e232 = local_41;
    out_.Store(_e232*4, asuint(int((_e222 + _e223))));
    {
        int _e234 = seed;
        signed_values_1[int(0)] = _e234;
        int _e238 = seed;
        signed_values_1[int(1)] = _e238;
        int _e245 = signed_values_1[int(0)];
        int _e246 = signed_values_1[int(1)];
        local_12 = uint(int(10));
        uint _e251 = local_12;
        local_42 = uint(_e251);
        uint _e254 = local_42;
        out_.Store(_e254*4, asuint(asint(asuint(_e245) + asuint(_e246))));
    }
    int _e258 = signed_values[int(0)];
    local_13 = uint(int(11));
    uint _e262 = local_13;
    local_43 = uint(_e262);
    uint _e265 = local_43;
    out_.Store(_e265*4, asuint(_e258));
    mixed = ZeroValuearray2_int_();
    int _e269 = seed;
    seed = asint(asuint(_e269) + asuint(int(1)));
    int next = seed;
    mixed[int(0)] = next;
    int _e275 = seed;
    seed = asint(asuint(_e275) + asuint(int(1)));
    mixed[int(1)] = _e275;
    int _e282 = mixed[int(0)];
    int _e287 = mixed[int(1)];
    local_14 = uint(int(12));
    uint _e292 = local_14;
    local_44 = uint(_e292);
    uint _e295 = local_44;
    out_.Store(_e295*4, asuint(asint(asuint(asint(asuint(_e282) * asuint(int(10)))) + asuint(_e287))));
    int _e297 = seed;
    local_15 = uint(int(13));
    uint _e301 = local_15;
    local_45 = uint(_e301);
    uint _e304 = local_45;
    out_.Store(_e304*4, asuint(_e297));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e331 = i;
                i = asint(asuint(_e331) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e310 = i;
            if ((_e310 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e315 = i;
            if ((_e315 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e323 = reset[int(0)];
            int _e324 = i;
            int _e326 = reset_total;
            reset_total = asint(asuint(_e326) + asuint(asint(asuint(_e323) + asuint(_e324))));
            reset[int(0)] = int(99);
        }
    }
    int _e334 = reset_total;
    local_16 = uint(int(14));
    uint _e338 = local_16;
    local_46 = uint(_e338);
    uint _e341 = local_46;
    out_.Store(_e341*4, asuint(_e334));
    total = int(0);
    {
        scratch = ZeroValuearray2_int_();
        j = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e373 = j;
                j = asint(asuint(_e373) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e349 = j;
            if ((_e349 < int(3))) {
            } else {
                break;
            }
            int _e352 = j;
            int _e356 = scratch[min(uint(naga_mod(_e352, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e352, int(2))), 1u)] = asint(asuint(_e356) + asuint(int(1)));
            int _e359 = j;
            if ((_e359 == int(1))) {
                continue;
            }
            int _e364 = scratch[int(0)];
            int _e369 = scratch[int(1)];
            int _e371 = total;
            total = asint(asuint(_e371) + asuint(asint(asuint(asint(asuint(_e364) * asuint(int(10)))) + asuint(_e369))));
        }
    }
    int _e376 = total;
    local_17 = uint(int(15));
    uint _e380 = local_17;
    local_47 = uint(_e380);
    uint _e383 = local_47;
    out_.Store(_e383*4, asuint(_e376));
    zero_samples = ZeroValuearray2_float_();
    float _e391 = zero_samples[int(0)];
    float _e392 = zero_samples[int(1)];
    local_18 = uint(int(16));
    uint _e398 = local_18;
    local_48 = uint(_e398);
    uint _e401 = local_48;
    out_.Store(_e401*4, asuint(naga_f2i32((_e391 + _e392))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e423 = left[int(0)];
    int _e424 = right[int(0)];
    local_19 = uint(int(17));
    uint _e429 = local_19;
    local_49 = uint(_e429);
    uint _e432 = local_49;
    out_.Store(_e432*4, asuint(asint(asuint(_e423) + asuint(_e424))));
    {
        temporary = ZeroValuearray2_int_();
        int _e436 = seed;
        temporary[int(0)] = _e436;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e448 = temporary_1[int(0)];
            int _e449 = temporary_1[int(1)];
            local_20 = uint(int(18));
            uint _e454 = local_20;
            local_50 = uint(_e454);
            uint _e457 = local_50;
            out_.Store(_e457*4, asuint(asint(asuint(_e448) + asuint(_e449))));
        }
        int _e461 = temporary[int(0)];
        local_21 = uint(int(19));
        uint _e465 = local_21;
        local_51 = uint(_e465);
        uint _e468 = local_51;
        out_.Store(_e468*4, asuint(_e461));
    }
    int _e470 = seed;
    bool choose = ((_e470 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e479 = rhs;
    rhs = asint(asuint(_e479) + asuint(int(1)));
    int _e482 = rhs;
    if (choose) {
        int _e483 = index;
        index = asint(asuint(_e483) + asuint(int(1)));
        int _e487 = left[min(uint(_e483), 1u)];
        left[min(uint(_e483), 1u)] = asint(asuint(_e487) + asuint(_e482));
        int _e489 = left[min(uint(_e483), 1u)];
        local_23 = _e489;
    } else {
        int _e491 = index;
        index = asint(asuint(_e491) + asuint(int(1)));
        int _e495 = right[min(uint(_e491), 1u)];
        right[min(uint(_e491), 1u)] = asint(asuint(_e495) + asuint(_e482));
        int _e497 = right[min(uint(_e491), 1u)];
        local_23 = _e497;
    }
    int _e500 = local_23;
    local_22 = uint(int(20));
    uint _e504 = local_22;
    local_52 = uint(_e504);
    uint _e507 = local_52;
    out_.Store(_e507*4, asuint(_e500));
    int _e509 = index;
    local_24 = uint(int(21));
    uint _e513 = local_24;
    local_53 = uint(_e513);
    uint _e516 = local_53;
    out_.Store(_e516*4, asuint(_e509));
    int _e520 = left[int(0)];
    int _e525 = right[int(0)];
    local_25 = uint(int(22));
    uint _e530 = local_25;
    local_54 = uint(_e530);
    uint _e533 = local_54;
    out_.Store(_e533*4, asuint(asint(asuint(asint(asuint(_e520) * asuint(int(100)))) + asuint(_e525))));
    if (choose) {
        right[int(1)] = int(9);
        int _e538 = right[int(1)];
        right[int(1)] = asint(asuint(_e538) + asuint(int(1)));
        local_27 = _e538;
    } else {
        left[int(1)] = int(9);
        int _e545 = left[int(1)];
        left[int(1)] = asint(asuint(_e545) + asuint(int(1)));
        local_27 = _e545;
    }
    int _e550 = local_27;
    local_26 = uint(int(23));
    uint _e554 = local_26;
    local_55 = uint(_e554);
    uint _e557 = local_55;
    out_.Store(_e557*4, asuint(_e550));
    int _e561 = left[int(1)];
    int _e566 = right[int(1)];
    local_28 = uint(int(24));
    uint _e571 = local_28;
    local_56 = uint(_e571);
    uint _e574 = local_56;
    out_.Store(_e574*4, asuint(asint(asuint(asint(asuint(_e561) * asuint(int(100)))) + asuint(_e566))));
}
