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
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
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

    local = uint(int(0));
    uint _e3 = local;
    local_29 = uint(_e3);
    uint _e6 = local_29;
    int _e9 = asint(out_.Load(_e6*4));
    seed = _e9;
    int _e11 = seed;
    signed_values[int(0)] = _e11;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e26 = signed_values[int(0)];
    int _e27 = signed_values[int(1)];
    int _e31 = signed_values[int(2)];
    local_1 = uint(int(0));
    uint _e36 = local_1;
    local_30 = uint(_e36);
    uint _e39 = local_30;
    out_.Store(_e39*4, asuint(asint(asuint(asint(asuint(_e26) + asuint(_e27))) + asuint(_e31))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e53 = words[int(0)];
    uint _e54 = words[int(1)];
    local_2 = uint(int(1));
    uint _e62 = local_2;
    local_31 = uint(_e62);
    uint _e65 = local_31;
    out_.Store(_e65*4, asuint(int(((_e53 + _e54) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e79 = samples[int(0)];
    float _e80 = samples[int(1)];
    local_3 = uint(int(2));
    uint _e88 = local_3;
    local_32 = uint(_e88);
    uint _e91 = local_32;
    out_.Store(_e91*4, asuint(naga_f2i32(((_e79 + _e80) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e95 = seed;
    flags[int(0)] = (_e95 != int(0));
    flags[int(2)] = true;
    bool _e105 = flags[int(0)];
    bool _e111 = flags[int(1)];
    bool _e118 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e124 = local_4;
    local_33 = uint(_e124);
    uint _e127 = local_33;
    out_.Store(_e127*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e105)) * asuint(int(100)))) + asuint(asint(asuint(int(_e111)) * asuint(int(10)))))) + asuint(int(_e118)))));
    zeros = ZeroValuearray2_int_();
    int _e135 = zeros[int(0)];
    int _e136 = zeros[int(1)];
    local_5 = uint(int(4));
    uint _e141 = local_5;
    local_34 = uint(_e141);
    uint _e144 = local_34;
    out_.Store(_e144*4, asuint(asint(asuint(_e135) + asuint(_e136))));
    int _e146 = seed;
    const int _e147 = local_sum(_e146);
    local_6 = uint(int(5));
    uint _e151 = local_6;
    local_35 = uint(_e151);
    uint _e154 = local_35;
    out_.Store(_e154*4, asuint(_e147));
    const int _e157 = reset_sum(int(3));
    local_7 = uint(int(6));
    uint _e161 = local_7;
    local_36 = uint(_e161);
    uint _e164 = local_36;
    out_.Store(_e164*4, asuint(_e157));
    zero_flags = ZeroValuearray2_bool_();
    bool _e170 = zero_flags[int(0)];
    local_9 = _e170;
    if (_e170) {
    } else {
        bool _e174 = zero_flags[int(1)];
        local_9 = _e174;
    }
    bool _e175 = local_9;
    local_8 = uint(int(7));
    uint _e180 = local_8;
    local_37 = uint(_e180);
    uint _e183 = local_37;
    out_.Store(_e183*4, asuint(int(_e175)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e202 = bank_1[int(0)];
        float _e203 = bank_1[int(1)];
        local_10 = uint(int(8));
        uint _e209 = local_10;
        local_38 = uint(_e209);
        uint _e212 = local_38;
        out_.Store(_e212*4, asuint(naga_f2i32((_e202 + _e203))));
    }
    uint _e218 = bank[int(0)];
    uint _e219 = bank[int(1)];
    local_11 = uint(int(9));
    uint _e225 = local_11;
    local_39 = uint(_e225);
    uint _e228 = local_39;
    out_.Store(_e228*4, asuint(int((_e218 + _e219))));
    {
        int _e230 = seed;
        signed_values_1[int(0)] = _e230;
        int _e234 = seed;
        signed_values_1[int(1)] = _e234;
        int _e241 = signed_values_1[int(0)];
        int _e242 = signed_values_1[int(1)];
        local_12 = uint(int(10));
        uint _e247 = local_12;
        local_40 = uint(_e247);
        uint _e250 = local_40;
        out_.Store(_e250*4, asuint(asint(asuint(_e241) + asuint(_e242))));
    }
    int _e254 = signed_values[int(0)];
    local_13 = uint(int(11));
    uint _e258 = local_13;
    local_41 = uint(_e258);
    uint _e261 = local_41;
    out_.Store(_e261*4, asuint(_e254));
    mixed = ZeroValuearray2_int_();
    int _e265 = seed;
    seed = asint(asuint(_e265) + asuint(int(1)));
    int next = seed;
    mixed[int(0)] = next;
    int _e271 = seed;
    seed = asint(asuint(_e271) + asuint(int(1)));
    mixed[int(1)] = _e271;
    int _e278 = mixed[int(0)];
    int _e283 = mixed[int(1)];
    local_14 = uint(int(12));
    uint _e288 = local_14;
    local_42 = uint(_e288);
    uint _e291 = local_42;
    out_.Store(_e291*4, asuint(asint(asuint(asint(asuint(_e278) * asuint(int(10)))) + asuint(_e283))));
    int _e293 = seed;
    local_15 = uint(int(13));
    uint _e297 = local_15;
    local_43 = uint(_e297);
    uint _e300 = local_43;
    out_.Store(_e300*4, asuint(_e293));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e327 = i;
                i = asint(asuint(_e327) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e306 = i;
            if ((_e306 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e311 = i;
            if ((_e311 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e319 = reset[int(0)];
            int _e320 = i;
            int _e322 = reset_total;
            reset_total = asint(asuint(_e322) + asuint(asint(asuint(_e319) + asuint(_e320))));
            reset[int(0)] = int(99);
        }
    }
    int _e330 = reset_total;
    local_16 = uint(int(14));
    uint _e334 = local_16;
    local_44 = uint(_e334);
    uint _e337 = local_44;
    out_.Store(_e337*4, asuint(_e330));
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
                int _e369 = j;
                j = asint(asuint(_e369) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e345 = j;
            if ((_e345 < int(3))) {
            } else {
                break;
            }
            int _e348 = j;
            int _e352 = scratch[min(uint(naga_mod(_e348, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e348, int(2))), 1u)] = asint(asuint(_e352) + asuint(int(1)));
            int _e355 = j;
            if ((_e355 == int(1))) {
                continue;
            }
            int _e360 = scratch[int(0)];
            int _e365 = scratch[int(1)];
            int _e367 = total;
            total = asint(asuint(_e367) + asuint(asint(asuint(asint(asuint(_e360) * asuint(int(10)))) + asuint(_e365))));
        }
    }
    int _e372 = total;
    local_17 = uint(int(15));
    uint _e376 = local_17;
    local_45 = uint(_e376);
    uint _e379 = local_45;
    out_.Store(_e379*4, asuint(_e372));
    zero_samples = ZeroValuearray2_float_();
    float _e387 = zero_samples[int(0)];
    float _e388 = zero_samples[int(1)];
    local_18 = uint(int(16));
    uint _e394 = local_18;
    local_46 = uint(_e394);
    uint _e397 = local_46;
    out_.Store(_e397*4, asuint(naga_f2i32((_e387 + _e388))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e419 = left[int(0)];
    int _e420 = right[int(0)];
    local_19 = uint(int(17));
    uint _e425 = local_19;
    local_47 = uint(_e425);
    uint _e428 = local_47;
    out_.Store(_e428*4, asuint(asint(asuint(_e419) + asuint(_e420))));
    {
        temporary = ZeroValuearray2_int_();
        int _e432 = seed;
        temporary[int(0)] = _e432;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e444 = temporary_1[int(0)];
            int _e445 = temporary_1[int(1)];
            local_20 = uint(int(18));
            uint _e450 = local_20;
            local_48 = uint(_e450);
            uint _e453 = local_48;
            out_.Store(_e453*4, asuint(asint(asuint(_e444) + asuint(_e445))));
        }
        int _e457 = temporary[int(0)];
        local_21 = uint(int(19));
        uint _e461 = local_21;
        local_49 = uint(_e461);
        uint _e464 = local_49;
        out_.Store(_e464*4, asuint(_e457));
    }
    int _e466 = seed;
    bool choose = ((_e466 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e475 = rhs;
    rhs = asint(asuint(_e475) + asuint(int(1)));
    int _e478 = rhs;
    if (choose) {
        int _e479 = index;
        index = asint(asuint(_e479) + asuint(int(1)));
        int _e483 = left[min(uint(_e479), 1u)];
        left[min(uint(_e479), 1u)] = asint(asuint(_e483) + asuint(_e478));
        int _e485 = left[min(uint(_e479), 1u)];
        local_23 = _e485;
    } else {
        int _e487 = index;
        index = asint(asuint(_e487) + asuint(int(1)));
        int _e491 = right[min(uint(_e487), 1u)];
        right[min(uint(_e487), 1u)] = asint(asuint(_e491) + asuint(_e478));
        int _e493 = right[min(uint(_e487), 1u)];
        local_23 = _e493;
    }
    int _e496 = local_23;
    local_22 = uint(int(20));
    uint _e500 = local_22;
    local_50 = uint(_e500);
    uint _e503 = local_50;
    out_.Store(_e503*4, asuint(_e496));
    int _e505 = index;
    local_24 = uint(int(21));
    uint _e509 = local_24;
    local_51 = uint(_e509);
    uint _e512 = local_51;
    out_.Store(_e512*4, asuint(_e505));
    int _e516 = left[int(0)];
    int _e521 = right[int(0)];
    local_25 = uint(int(22));
    uint _e526 = local_25;
    local_52 = uint(_e526);
    uint _e529 = local_52;
    out_.Store(_e529*4, asuint(asint(asuint(asint(asuint(_e516) * asuint(int(100)))) + asuint(_e521))));
    if (choose) {
        right[int(1)] = int(9);
        int _e534 = right[int(1)];
        right[int(1)] = asint(asuint(_e534) + asuint(int(1)));
        local_27 = _e534;
    } else {
        left[int(1)] = int(9);
        int _e541 = left[int(1)];
        left[int(1)] = asint(asuint(_e541) + asuint(int(1)));
        local_27 = _e541;
    }
    int _e546 = local_27;
    local_26 = uint(int(23));
    uint _e550 = local_26;
    local_53 = uint(_e550);
    uint _e553 = local_53;
    out_.Store(_e553*4, asuint(_e546));
    int _e557 = left[int(1)];
    int _e562 = right[int(1)];
    local_28 = uint(int(24));
    uint _e567 = local_28;
    local_54 = uint(_e567);
    uint _e570 = local_54;
    out_.Store(_e570*4, asuint(asint(asuint(asint(asuint(_e557) * asuint(int(100)))) + asuint(_e562))));
}
