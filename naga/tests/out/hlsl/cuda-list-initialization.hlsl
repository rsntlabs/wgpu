struct int3_ {
    int x;
    int y;
    int z;
};

struct float3_ {
    float x;
    float y;
    float z;
};

static const int Global = int(2);
static const float Scale = 0.5;

RWByteAddressBuffer out_ : register(u0);

int pair(int first, int second)
{
    return asint(asuint(asint(asuint(first) * asuint(int(10)))) + asuint(second));
}

int ZeroValueint() {
    return (int)0;
}

int list_sum(int seed)
{
    int values_1[3] = (int[3])0;
    uint local_35 = (uint)0;

    values_1[0] = seed;
    values_1[1] = asint(asuint(seed) + asuint(int(1)));
    local_35 = 2u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_35;
            local_35 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_35;
        if ((_e8 >= 3u)) {
            break;
        }
        values_1[min(uint(_e8), 2u)] = ZeroValueint();
    }
    int _e20 = values_1[int(0)];
    int _e21 = values_1[int(1)];
    int _e25 = values_1[int(2)];
    return asint(asuint(asint(asuint(_e20) + asuint(_e21))) + asuint(_e25));
}

int3_ make_list(int seed_1)
{
    int3_ value = (int3_)0;

    value.x = seed_1;
    value.y = asint(asuint(seed_1) + asuint(int(1)));
    value.z = asint(asuint(seed_1) + asuint(int(2)));
    int3_ _e9 = value;
    const int3_ int3_1 = _e9;
    return int3_1;
}

float ZeroValuefloat() {
    return (float)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void list_initialization()
{
    uint local = (uint)0;
    int zero = (int)0;
    int copy_zero = (int)0;
    bool enabled = (bool)0;
    float sample_ = (float)0;
    int Local = (int)0;
    int Safe = (int)0;
    int local_1 = (int)0;
    int safe_values[3] = (int[3])0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int values[3] = (int[3])0;
    uint local_10 = (uint)0;
    int changed[3] = (int[3])0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    int3_ point_ = (int3_)0;
    uint local_13 = (uint)0;
    int3_ changed_point = (int3_)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int3_ nested[2] = (int3_[2])0;
    uint local_16 = (uint)0;
    int2 flat[2] = (int2[2])0;
    uint local_17 = (uint)0;
    int3_ original = (int3_)0;
    int3_ copied = (int3_)0;
    int3_ copies[2] = (int3_[2])0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    int counter = (int)0;
    int ordered[3] = (int[3])0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    int zero_total = (int)0;
    int iteration = (int)0;
    int reset[3] = (int[3])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    int total = (int)0;
    int iteration_1 = (int)0;
    int limit = (int)0;
    uint local_26 = (uint)0;
    int Number = (int)0;
    int cached[2] = (int[2])0;
    uint local_27 = (uint)0;
    int frozen[3] = (int[3])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    float3_ floating = (float3_)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    int3_ from_call = (int3_)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    int seed_2 = asint(out_.Load(_e3*4));
    zero = int(0);
    copy_zero = int(0);
    enabled = true;
    uint count = uint(int(7));
    sample_ = 1.5;
    Local = int(3);
    Safe = int(3);
    safe_values[0] = int(1);
    local_2 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e31 = local_2;
            local_2 = (_e31 + 1u);
        }
        loop_init_1 = false;
        uint _e26 = local_2;
        if ((_e26 >= 3u)) {
            break;
        }
        safe_values[min(uint(_e26), 2u)] = ZeroValueint();
    }
    int _e34 = zero;
    local_3 = uint(int(0));
    uint _e38 = local_3;
    out_.Store(_e38*4, asuint(_e34));
    int _e40 = copy_zero;
    local_4 = uint(int(1));
    uint _e44 = local_4;
    out_.Store(_e44*4, asuint(_e40));
    bool _e46 = enabled;
    local_5 = uint(int(2));
    uint _e51 = local_5;
    out_.Store(_e51*4, asuint(int(_e46)));
    local_6 = uint(int(3));
    uint _e57 = local_6;
    out_.Store(_e57*4, asuint(int(count)));
    float _e59 = sample_;
    local_7 = uint(int(4));
    uint _e66 = local_7;
    out_.Store(_e66*4, asuint(naga_f2i32((_e59 * 2.0))));
    int _e68 = Local;
    local_8 = uint(int(5));
    uint _e74 = local_8;
    out_.Store(_e74*4, asuint(asint(asuint(Global) + asuint(_e68))));
    int _e78 = safe_values[int(2)];
    local_9 = uint(int(6));
    uint _e82 = local_9;
    out_.Store(_e82*4, asuint(_e78));
    values[0] = int(1);
    int _e90 = values[int(0)];
    values[1] = asint(asuint(_e90) + asuint(int(1)));
    int _e96 = values[int(1)];
    values[2] = asint(asuint(_e96) + asuint(int(1)));
    int _e103 = values[int(0)];
    int _e104 = values[int(1)];
    int _e108 = values[int(2)];
    local_10 = uint(int(7));
    uint _e113 = local_10;
    out_.Store(_e113*4, asuint(asint(asuint(asint(asuint(_e103) + asuint(_e104))) + asuint(_e108))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e126 = changed[int(0)];
    changed[2] = _e126;
    int _e129 = changed[int(0)];
    local_11 = uint(int(8));
    uint _e133 = local_11;
    out_.Store(_e133*4, asuint(_e129));
    int _e137 = changed[int(2)];
    local_12 = uint(int(9));
    uint _e141 = local_12;
    out_.Store(_e141*4, asuint(_e137));
    point_.x = int(1);
    int _e147 = point_.x;
    point_.y = asint(asuint(_e147) + asuint(int(1)));
    int _e152 = point_.y;
    point_.z = asint(asuint(_e152) + asuint(int(1)));
    int _e157 = point_.z;
    local_13 = uint(int(10));
    uint _e161 = local_13;
    out_.Store(_e161*4, asuint(_e157));
    changed_point.x = int(1);
    changed_point.x = int(9);
    changed_point.y = int(2);
    int _e171 = changed_point.x;
    changed_point.z = _e171;
    int _e174 = changed_point.x;
    local_14 = uint(int(11));
    uint _e178 = local_14;
    out_.Store(_e178*4, asuint(_e174));
    int _e181 = changed_point.z;
    local_15 = uint(int(12));
    uint _e185 = local_15;
    out_.Store(_e185*4, asuint(_e181));
    nested[0].x = int(1);
    nested[0].y = int(2);
    nested[0].z = ZeroValueint();
    nested[1].x = int(3);
    nested[1].y = ZeroValueint();
    nested[1].z = ZeroValueint();
    int _e208 = nested[int(0)].z;
    int _e209 = nested[int(1)].x;
    local_16 = uint(int(13));
    uint _e214 = local_16;
    out_.Store(_e214*4, asuint(asint(asuint(_e208) + asuint(_e209))));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e233 = flat[int(0)].x;
    int _e234 = flat[int(0)].y;
    int _e239 = flat[int(1)].x;
    int _e244 = flat[int(1)].y;
    local_17 = uint(int(14));
    uint _e249 = local_17;
    out_.Store(_e249*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e233) + asuint(_e234))) + asuint(_e239))) + asuint(_e244))));
    original.x = int(2);
    original.y = int(3);
    original.z = int(4);
    int3_ _e258 = original;
    copied = _e258;
    int3_ _e262 = original;
    copies[0] = _e262;
    copies[1].x = int(5);
    copies[1].y = int(6);
    copies[1].z = ZeroValueint();
    original.x = int(99);
    int _e273 = copied.x;
    local_18 = uint(int(15));
    uint _e277 = local_18;
    out_.Store(_e277*4, asuint(_e273));
    int _e282 = copies[int(0)].x;
    local_19 = uint(int(16));
    uint _e286 = local_19;
    out_.Store(_e286*4, asuint(_e282));
    int _e291 = copies[int(1)].z;
    local_20 = uint(int(17));
    uint _e295 = local_20;
    out_.Store(_e295*4, asuint(_e291));
    counter = seed_2;
    int _e300 = counter;
    counter = asint(asuint(_e300) + asuint(int(1)));
    ordered[0] = _e300;
    int _e304 = counter;
    counter = asint(asuint(_e304) + asuint(int(1)));
    ordered[1] = _e304;
    int _e308 = counter;
    ordered[2] = _e308;
    int _e311 = ordered[int(0)];
    int _e316 = ordered[int(1)];
    int _e322 = ordered[int(2)];
    local_21 = uint(int(18));
    uint _e327 = local_21;
    out_.Store(_e327*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e311) * asuint(int(100)))) + asuint(asint(asuint(_e316) * asuint(int(10)))))) + asuint(_e322))));
    int _e329 = counter;
    local_22 = uint(int(19));
    uint _e333 = local_22;
    out_.Store(_e333*4, asuint(_e329));
    int _e335 = counter;
    counter = asint(asuint(_e335) + asuint(int(1)));
    const int _e339 = pair(_e335, int(4));
    local_23 = uint(int(20));
    uint _e343 = local_23;
    out_.Store(_e343*4, asuint(_e339));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e373 = iteration;
                iteration = asint(asuint(_e373) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e349 = iteration;
            if ((_e349 < int(3))) {
            } else {
                break;
            }
            int _e354 = iteration;
            reset[0] = _e354;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e362 = local_24;
                    local_24 = (_e362 + 1u);
                }
                loop_init_3 = false;
                uint _e357 = local_24;
                if ((_e357 >= 3u)) {
                    break;
                }
                reset[min(uint(_e357), 2u)] = ZeroValueint();
            }
            int _e367 = reset[int(2)];
            int _e368 = zero_total;
            zero_total = asint(asuint(_e368) + asuint(_e367));
            reset[int(2)] = int(9);
        }
    }
    int _e376 = zero_total;
    local_25 = uint(int(21));
    uint _e380 = local_25;
    out_.Store(_e380*4, asuint(_e376));
    total = int(0);
    {
        iteration_1 = int(0);
        limit = int(3);
        uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                int _e394 = iteration_1;
                iteration_1 = asint(asuint(_e394) + asuint(int(1)));
            }
            loop_init_4 = false;
            int _e388 = iteration_1;
            int _e389 = limit;
            if ((_e388 < _e389)) {
            } else {
                break;
            }
            int _e391 = iteration_1;
            int _e392 = total;
            total = asint(asuint(_e392) + asuint(_e391));
        }
    }
    int _e397 = total;
    local_26 = uint(int(22));
    uint _e401 = local_26;
    out_.Store(_e401*4, asuint(_e397));
    Number = int(4);
    int _e407 = Number;
    cached[0] = _e407;
    int _e409 = Number;
    cached[1] = asint(asuint(_e409) + asuint(int(1)));
    int _e414 = cached[int(1)];
    local_27 = uint(int(23));
    uint _e418 = local_27;
    out_.Store(_e418*4, asuint(_e414));
    frozen[0] = int(3);
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e430 = local_28;
            local_28 = (_e430 + 1u);
        }
        loop_init_5 = false;
        uint _e425 = local_28;
        if ((_e425 >= 3u)) {
            break;
        }
        frozen[min(uint(_e425), 2u)] = ZeroValueint();
    }
    int _e437 = frozen[int(0)];
    int _e438 = frozen[int(1)];
    int _e442 = frozen[int(2)];
    local_29 = uint(int(24));
    uint _e447 = local_29;
    out_.Store(_e447*4, asuint(asint(asuint(asint(asuint(_e437) + asuint(_e438))) + asuint(_e442))));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = ZeroValuefloat();
    float _e458 = floating.y;
    local_30 = uint(int(25));
    uint _e463 = local_30;
    out_.Store(_e463*4, asuint(asint(_e458)));
    float _e466 = floating.z;
    local_31 = uint(int(26));
    uint _e471 = local_31;
    out_.Store(_e471*4, asuint(asint(_e466)));
    const int3_ _e474 = make_list(int(6));
    from_call = _e474;
    int _e478 = from_call.x;
    int _e479 = from_call.z;
    local_32 = uint(int(27));
    uint _e484 = local_32;
    out_.Store(_e484*4, asuint(asint(asuint(_e478) + asuint(_e479))));
    local_33 = uint(int(28));
    uint _e493 = local_33;
    out_.Store(_e493*4, asuint(naga_f2i32((Scale * 10.0))));
    const int _e497 = list_sum(asint(asuint(seed_2) + asuint(int(3))));
    local_34 = uint(int(29));
    uint _e501 = local_34;
    out_.Store(_e501*4, asuint(_e497));
}
