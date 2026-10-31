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

    local = uint(int(0));
    uint _e3 = local;
    int _e6 = asint(out_.Load(_e3*4));
    seed = _e6;
    int _e8 = seed;
    signed_values[int(0)] = _e8;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e23 = signed_values[int(0)];
    int _e24 = signed_values[int(1)];
    int _e28 = signed_values[int(2)];
    local_1 = uint(int(0));
    uint _e33 = local_1;
    out_.Store(_e33*4, asuint(asint(asuint(asint(asuint(_e23) + asuint(_e24))) + asuint(_e28))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e47 = words[int(0)];
    uint _e48 = words[int(1)];
    local_2 = uint(int(1));
    uint _e56 = local_2;
    out_.Store(_e56*4, asuint(int(((_e47 + _e48) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e70 = samples[int(0)];
    float _e71 = samples[int(1)];
    local_3 = uint(int(2));
    uint _e79 = local_3;
    out_.Store(_e79*4, asuint(naga_f2i32(((_e70 + _e71) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e83 = seed;
    flags[int(0)] = (_e83 != int(0));
    flags[int(2)] = true;
    bool _e93 = flags[int(0)];
    bool _e99 = flags[int(1)];
    bool _e106 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e112 = local_4;
    out_.Store(_e112*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e93)) * asuint(int(100)))) + asuint(asint(asuint(int(_e99)) * asuint(int(10)))))) + asuint(int(_e106)))));
    zeros = ZeroValuearray2_int_();
    int _e120 = zeros[int(0)];
    int _e121 = zeros[int(1)];
    local_5 = uint(int(4));
    uint _e126 = local_5;
    out_.Store(_e126*4, asuint(asint(asuint(_e120) + asuint(_e121))));
    int _e128 = seed;
    const int _e129 = local_sum(_e128);
    local_6 = uint(int(5));
    uint _e133 = local_6;
    out_.Store(_e133*4, asuint(_e129));
    const int _e136 = reset_sum(int(3));
    local_7 = uint(int(6));
    uint _e140 = local_7;
    out_.Store(_e140*4, asuint(_e136));
    zero_flags = ZeroValuearray2_bool_();
    bool _e146 = zero_flags[int(0)];
    local_9 = _e146;
    if (_e146) {
    } else {
        bool _e150 = zero_flags[int(1)];
        local_9 = _e150;
    }
    bool _e151 = local_9;
    local_8 = uint(int(7));
    uint _e156 = local_8;
    out_.Store(_e156*4, asuint(int(_e151)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e175 = bank_1[int(0)];
        float _e176 = bank_1[int(1)];
        local_10 = uint(int(8));
        uint _e182 = local_10;
        local_29 = _e182;
        uint _e184 = local_29;
        out_.Store(_e184*4, asuint(naga_f2i32((_e175 + _e176))));
    }
    uint _e190 = bank[int(0)];
    uint _e191 = bank[int(1)];
    local_11 = uint(int(9));
    uint _e197 = local_11;
    out_.Store(_e197*4, asuint(int((_e190 + _e191))));
    {
        int _e199 = seed;
        signed_values_1[int(0)] = _e199;
        int _e203 = seed;
        signed_values_1[int(1)] = _e203;
        int _e210 = signed_values_1[int(0)];
        int _e211 = signed_values_1[int(1)];
        local_12 = uint(int(10));
        uint _e216 = local_12;
        local_30 = _e216;
        uint _e218 = local_30;
        out_.Store(_e218*4, asuint(asint(asuint(_e210) + asuint(_e211))));
    }
    int _e222 = signed_values[int(0)];
    local_13 = uint(int(11));
    uint _e226 = local_13;
    out_.Store(_e226*4, asuint(_e222));
    mixed = ZeroValuearray2_int_();
    int _e230 = seed;
    seed = asint(asuint(_e230) + asuint(int(1)));
    int next = seed;
    mixed[int(0)] = next;
    int _e236 = seed;
    seed = asint(asuint(_e236) + asuint(int(1)));
    mixed[int(1)] = _e236;
    int _e243 = mixed[int(0)];
    int _e248 = mixed[int(1)];
    local_14 = uint(int(12));
    uint _e253 = local_14;
    out_.Store(_e253*4, asuint(asint(asuint(asint(asuint(_e243) * asuint(int(10)))) + asuint(_e248))));
    int _e255 = seed;
    local_15 = uint(int(13));
    uint _e259 = local_15;
    out_.Store(_e259*4, asuint(_e255));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e286 = i;
                i = asint(asuint(_e286) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e265 = i;
            if ((_e265 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e270 = i;
            if ((_e270 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e278 = reset[int(0)];
            int _e279 = i;
            int _e281 = reset_total;
            reset_total = asint(asuint(_e281) + asuint(asint(asuint(_e278) + asuint(_e279))));
            reset[int(0)] = int(99);
        }
    }
    int _e289 = reset_total;
    local_16 = uint(int(14));
    uint _e293 = local_16;
    out_.Store(_e293*4, asuint(_e289));
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
                int _e325 = j;
                j = asint(asuint(_e325) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e301 = j;
            if ((_e301 < int(3))) {
            } else {
                break;
            }
            int _e304 = j;
            int _e308 = scratch[min(uint(naga_mod(_e304, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e304, int(2))), 1u)] = asint(asuint(_e308) + asuint(int(1)));
            int _e311 = j;
            if ((_e311 == int(1))) {
                continue;
            }
            int _e316 = scratch[int(0)];
            int _e321 = scratch[int(1)];
            int _e323 = total;
            total = asint(asuint(_e323) + asuint(asint(asuint(asint(asuint(_e316) * asuint(int(10)))) + asuint(_e321))));
        }
    }
    int _e328 = total;
    local_17 = uint(int(15));
    uint _e332 = local_17;
    out_.Store(_e332*4, asuint(_e328));
    zero_samples = ZeroValuearray2_float_();
    float _e340 = zero_samples[int(0)];
    float _e341 = zero_samples[int(1)];
    local_18 = uint(int(16));
    uint _e347 = local_18;
    out_.Store(_e347*4, asuint(naga_f2i32((_e340 + _e341))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e369 = left[int(0)];
    int _e370 = right[int(0)];
    local_19 = uint(int(17));
    uint _e375 = local_19;
    out_.Store(_e375*4, asuint(asint(asuint(_e369) + asuint(_e370))));
    {
        temporary = ZeroValuearray2_int_();
        int _e379 = seed;
        temporary[int(0)] = _e379;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e391 = temporary_1[int(0)];
            int _e392 = temporary_1[int(1)];
            local_20 = uint(int(18));
            uint _e397 = local_20;
            local_31 = _e397;
            uint _e399 = local_31;
            out_.Store(_e399*4, asuint(asint(asuint(_e391) + asuint(_e392))));
        }
        int _e403 = temporary[int(0)];
        local_21 = uint(int(19));
        uint _e407 = local_21;
        local_32 = _e407;
        uint _e409 = local_32;
        out_.Store(_e409*4, asuint(_e403));
    }
    int _e411 = seed;
    bool choose = ((_e411 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e420 = rhs;
    rhs = asint(asuint(_e420) + asuint(int(1)));
    int _e423 = rhs;
    if (choose) {
        int _e424 = index;
        index = asint(asuint(_e424) + asuint(int(1)));
        int _e428 = left[min(uint(_e424), 1u)];
        left[min(uint(_e424), 1u)] = asint(asuint(_e428) + asuint(_e423));
        int _e430 = left[min(uint(_e424), 1u)];
        local_23 = _e430;
    } else {
        int _e432 = index;
        index = asint(asuint(_e432) + asuint(int(1)));
        int _e436 = right[min(uint(_e432), 1u)];
        right[min(uint(_e432), 1u)] = asint(asuint(_e436) + asuint(_e423));
        int _e438 = right[min(uint(_e432), 1u)];
        local_23 = _e438;
    }
    int _e441 = local_23;
    local_22 = uint(int(20));
    uint _e445 = local_22;
    out_.Store(_e445*4, asuint(_e441));
    int _e447 = index;
    local_24 = uint(int(21));
    uint _e451 = local_24;
    out_.Store(_e451*4, asuint(_e447));
    int _e455 = left[int(0)];
    int _e460 = right[int(0)];
    local_25 = uint(int(22));
    uint _e465 = local_25;
    out_.Store(_e465*4, asuint(asint(asuint(asint(asuint(_e455) * asuint(int(100)))) + asuint(_e460))));
    if (choose) {
        right[int(1)] = int(9);
        int _e470 = right[int(1)];
        right[int(1)] = asint(asuint(_e470) + asuint(int(1)));
        local_27 = _e470;
    } else {
        left[int(1)] = int(9);
        int _e477 = left[int(1)];
        left[int(1)] = asint(asuint(_e477) + asuint(int(1)));
        local_27 = _e477;
    }
    int _e482 = local_27;
    local_26 = uint(int(23));
    uint _e486 = local_26;
    out_.Store(_e486*4, asuint(_e482));
    int _e490 = left[int(1)];
    int _e495 = right[int(1)];
    local_28 = uint(int(24));
    uint _e500 = local_28;
    out_.Store(_e500*4, asuint(asint(asuint(asint(asuint(_e490) * asuint(int(100)))) + asuint(_e495))));
}
