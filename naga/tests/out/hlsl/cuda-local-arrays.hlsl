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
    int signed_values[3] = (int[3])0;
    uint words[2] = (uint[2])0;
    float samples[2] = (float[2])0;
    bool flags[3] = (bool[3])0;
    int zeros[2] = (int[2])0;
    bool zero_flags[2] = (bool[2])0;
    bool local = (bool)0;
    uint bank[2] = (uint[2])0;
    float bank_1[2] = (float[2])0;
    uint local_1 = (uint)0;
    int signed_values_1[2] = (int[2])0;
    uint local_2 = (uint)0;
    int mixed[2] = (int[2])0;
    int reset_total = (int)0;
    int i = (int)0;
    int reset[2] = (int[2])0;
    int total = (int)0;
    int scratch[2] = (int[2])0;
    int j = (int)0;
    float zero_samples[2] = (float[2])0;
    int left[2] = (int[2])0;
    int right[2] = (int[2])0;
    int temporary[2] = (int[2])0;
    int temporary_1[2] = (int[2])0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    int index = (int)0;
    int rhs = (int)0;
    int local_5 = (int)0;
    int local_6 = (int)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;

    int _e4 = asint(out_.Load(uint(int(0))*4));
    seed = _e4;
    int _e6 = seed;
    signed_values[int(0)] = _e6;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e21 = signed_values[int(0)];
    int _e22 = signed_values[int(1)];
    int _e26 = signed_values[int(2)];
    out_.Store(uint(int(0))*4, asuint(asint(asuint(asint(asuint(_e21) + asuint(_e22))) + asuint(_e26))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e43 = words[int(0)];
    uint _e44 = words[int(1)];
    out_.Store(uint(int(1))*4, asuint(int(((_e43 + _e44) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e64 = samples[int(0)];
    float _e65 = samples[int(1)];
    out_.Store(uint(int(2))*4, asuint(naga_f2i32(((_e64 + _e65) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e75 = seed;
    flags[int(0)] = (_e75 != int(0));
    flags[int(2)] = true;
    bool _e85 = flags[int(0)];
    bool _e91 = flags[int(1)];
    bool _e98 = flags[int(2)];
    out_.Store(uint(int(3))*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e85)) * asuint(int(100)))) + asuint(asint(asuint(int(_e91)) * asuint(int(10)))))) + asuint(int(_e98)))));
    zeros = ZeroValuearray2_int_();
    int _e110 = zeros[int(0)];
    int _e111 = zeros[int(1)];
    out_.Store(uint(int(4))*4, asuint(asint(asuint(_e110) + asuint(_e111))));
    int _e116 = seed;
    const int _e117 = local_sum(_e116);
    out_.Store(uint(int(5))*4, asuint(_e117));
    const int _e122 = reset_sum(int(3));
    out_.Store(uint(int(6))*4, asuint(_e122));
    zero_flags = ZeroValuearray2_bool_();
    bool _e130 = zero_flags[int(0)];
    local = _e130;
    if (_e130) {
    } else {
        bool _e134 = zero_flags[int(1)];
        local = _e134;
    }
    bool _e135 = local;
    out_.Store(uint(int(7))*4, asuint(int(_e135)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e157 = bank_1[int(0)];
        float _e158 = bank_1[int(1)];
        local_1 = uint(int(8));
        uint _e164 = local_1;
        local_7 = _e164;
        uint _e166 = local_7;
        out_.Store(_e166*4, asuint(naga_f2i32((_e157 + _e158))));
    }
    uint _e172 = bank[int(0)];
    uint _e173 = bank[int(1)];
    out_.Store(uint(int(9))*4, asuint(int((_e172 + _e173))));
    {
        int _e179 = seed;
        signed_values_1[int(0)] = _e179;
        int _e183 = seed;
        signed_values_1[int(1)] = _e183;
        int _e190 = signed_values_1[int(0)];
        int _e191 = signed_values_1[int(1)];
        local_2 = uint(int(10));
        uint _e196 = local_2;
        local_8 = _e196;
        uint _e198 = local_8;
        out_.Store(_e198*4, asuint(asint(asuint(_e190) + asuint(_e191))));
    }
    int _e202 = signed_values[int(0)];
    out_.Store(uint(int(11))*4, asuint(_e202));
    mixed = ZeroValuearray2_int_();
    int _e208 = seed;
    seed = asint(asuint(_e208) + asuint(int(1)));
    int next = seed;
    mixed[int(0)] = next;
    int _e214 = seed;
    seed = asint(asuint(_e214) + asuint(int(1)));
    mixed[int(1)] = _e214;
    int _e221 = mixed[int(0)];
    int _e226 = mixed[int(1)];
    out_.Store(uint(int(12))*4, asuint(asint(asuint(asint(asuint(_e221) * asuint(int(10)))) + asuint(_e226))));
    int _e231 = seed;
    out_.Store(uint(int(13))*4, asuint(_e231));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e260 = i;
                i = asint(asuint(_e260) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e239 = i;
            if ((_e239 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e244 = i;
            if ((_e244 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e252 = reset[int(0)];
            int _e253 = i;
            int _e255 = reset_total;
            reset_total = asint(asuint(_e255) + asuint(asint(asuint(_e252) + asuint(_e253))));
            reset[int(0)] = int(99);
        }
    }
    int _e263 = reset_total;
    out_.Store(uint(int(14))*4, asuint(_e263));
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
                int _e297 = j;
                j = asint(asuint(_e297) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e273 = j;
            if ((_e273 < int(3))) {
            } else {
                break;
            }
            int _e276 = j;
            int _e280 = scratch[min(uint(naga_mod(_e276, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e276, int(2))), 1u)] = asint(asuint(_e280) + asuint(int(1)));
            int _e283 = j;
            if ((_e283 == int(1))) {
                continue;
            }
            int _e288 = scratch[int(0)];
            int _e293 = scratch[int(1)];
            int _e295 = total;
            total = asint(asuint(_e295) + asuint(asint(asuint(asint(asuint(_e288) * asuint(int(10)))) + asuint(_e293))));
        }
    }
    int _e300 = total;
    out_.Store(uint(int(15))*4, asuint(_e300));
    zero_samples = ZeroValuearray2_float_();
    float _e310 = zero_samples[int(0)];
    float _e311 = zero_samples[int(1)];
    out_.Store(uint(int(16))*4, asuint(naga_f2i32((_e310 + _e311))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e337 = left[int(0)];
    int _e338 = right[int(0)];
    out_.Store(uint(int(17))*4, asuint(asint(asuint(_e337) + asuint(_e338))));
    {
        temporary = ZeroValuearray2_int_();
        int _e345 = seed;
        temporary[int(0)] = _e345;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e357 = temporary_1[int(0)];
            int _e358 = temporary_1[int(1)];
            local_3 = uint(int(18));
            uint _e363 = local_3;
            local_9 = _e363;
            uint _e365 = local_9;
            out_.Store(_e365*4, asuint(asint(asuint(_e357) + asuint(_e358))));
        }
        int _e369 = temporary[int(0)];
        local_4 = uint(int(19));
        uint _e373 = local_4;
        local_10 = _e373;
        uint _e375 = local_10;
        out_.Store(_e375*4, asuint(_e369));
    }
    int _e377 = seed;
    bool choose = ((_e377 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e386 = rhs;
    rhs = asint(asuint(_e386) + asuint(int(1)));
    int _e389 = rhs;
    if (choose) {
        int _e390 = index;
        index = asint(asuint(_e390) + asuint(int(1)));
        int _e394 = left[min(uint(_e390), 1u)];
        left[min(uint(_e390), 1u)] = asint(asuint(_e394) + asuint(_e389));
        int _e396 = left[min(uint(_e390), 1u)];
        local_5 = _e396;
    } else {
        int _e398 = index;
        index = asint(asuint(_e398) + asuint(int(1)));
        int _e402 = right[min(uint(_e398), 1u)];
        right[min(uint(_e398), 1u)] = asint(asuint(_e402) + asuint(_e389));
        int _e404 = right[min(uint(_e398), 1u)];
        local_5 = _e404;
    }
    int _e407 = local_5;
    out_.Store(uint(int(20))*4, asuint(_e407));
    int _e411 = index;
    out_.Store(uint(int(21))*4, asuint(_e411));
    int _e417 = left[int(0)];
    int _e422 = right[int(0)];
    out_.Store(uint(int(22))*4, asuint(asint(asuint(asint(asuint(_e417) * asuint(int(100)))) + asuint(_e422))));
    if (choose) {
        right[int(1)] = int(9);
        int _e430 = right[int(1)];
        right[int(1)] = asint(asuint(_e430) + asuint(int(1)));
        local_6 = _e430;
    } else {
        left[int(1)] = int(9);
        int _e437 = left[int(1)];
        left[int(1)] = asint(asuint(_e437) + asuint(int(1)));
        local_6 = _e437;
    }
    int _e442 = local_6;
    out_.Store(uint(int(23))*4, asuint(_e442));
    int _e448 = left[int(1)];
    int _e453 = right[int(1)];
    out_.Store(uint(int(24))*4, asuint(asint(asuint(asint(asuint(_e448) * asuint(int(100)))) + asuint(_e453))));
}
