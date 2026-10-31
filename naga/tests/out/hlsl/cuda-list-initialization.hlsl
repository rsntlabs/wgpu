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
    uint local_66 = (uint)0;

    values_1[0] = seed;
    values_1[1] = asint(asuint(seed) + asuint(int(1)));
    local_66 = 2u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_66;
            local_66 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_66;
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
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_35 = uint(_e3);
    uint _e6 = local_35;
    int seed_2 = asint(out_.Load(_e6*4));
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
            uint _e34 = local_2;
            local_2 = (_e34 + 1u);
        }
        loop_init_1 = false;
        uint _e29 = local_2;
        if ((_e29 >= 3u)) {
            break;
        }
        safe_values[min(uint(_e29), 2u)] = ZeroValueint();
    }
    int _e37 = zero;
    local_3 = uint(int(0));
    uint _e41 = local_3;
    local_36 = uint(_e41);
    uint _e44 = local_36;
    out_.Store(_e44*4, asuint(_e37));
    int _e46 = copy_zero;
    local_4 = uint(int(1));
    uint _e50 = local_4;
    local_37 = uint(_e50);
    uint _e53 = local_37;
    out_.Store(_e53*4, asuint(_e46));
    bool _e55 = enabled;
    local_5 = uint(int(2));
    uint _e60 = local_5;
    local_38 = uint(_e60);
    uint _e63 = local_38;
    out_.Store(_e63*4, asuint(int(_e55)));
    local_6 = uint(int(3));
    uint _e69 = local_6;
    local_39 = uint(_e69);
    uint _e72 = local_39;
    out_.Store(_e72*4, asuint(int(count)));
    float _e74 = sample_;
    local_7 = uint(int(4));
    uint _e81 = local_7;
    local_40 = uint(_e81);
    uint _e84 = local_40;
    out_.Store(_e84*4, asuint(naga_f2i32((_e74 * 2.0))));
    int _e86 = Local;
    local_8 = uint(int(5));
    uint _e92 = local_8;
    local_41 = uint(_e92);
    uint _e95 = local_41;
    out_.Store(_e95*4, asuint(asint(asuint(Global) + asuint(_e86))));
    int _e99 = safe_values[int(2)];
    local_9 = uint(int(6));
    uint _e103 = local_9;
    local_42 = uint(_e103);
    uint _e106 = local_42;
    out_.Store(_e106*4, asuint(_e99));
    values[0] = int(1);
    int _e114 = values[int(0)];
    values[1] = asint(asuint(_e114) + asuint(int(1)));
    int _e120 = values[int(1)];
    values[2] = asint(asuint(_e120) + asuint(int(1)));
    int _e127 = values[int(0)];
    int _e128 = values[int(1)];
    int _e132 = values[int(2)];
    local_10 = uint(int(7));
    uint _e137 = local_10;
    local_43 = uint(_e137);
    uint _e140 = local_43;
    out_.Store(_e140*4, asuint(asint(asuint(asint(asuint(_e127) + asuint(_e128))) + asuint(_e132))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e153 = changed[int(0)];
    changed[2] = _e153;
    int _e156 = changed[int(0)];
    local_11 = uint(int(8));
    uint _e160 = local_11;
    local_44 = uint(_e160);
    uint _e163 = local_44;
    out_.Store(_e163*4, asuint(_e156));
    int _e167 = changed[int(2)];
    local_12 = uint(int(9));
    uint _e171 = local_12;
    local_45 = uint(_e171);
    uint _e174 = local_45;
    out_.Store(_e174*4, asuint(_e167));
    point_.x = int(1);
    int _e180 = point_.x;
    point_.y = asint(asuint(_e180) + asuint(int(1)));
    int _e185 = point_.y;
    point_.z = asint(asuint(_e185) + asuint(int(1)));
    int _e190 = point_.z;
    local_13 = uint(int(10));
    uint _e194 = local_13;
    local_46 = uint(_e194);
    uint _e197 = local_46;
    out_.Store(_e197*4, asuint(_e190));
    changed_point.x = int(1);
    changed_point.x = int(9);
    changed_point.y = int(2);
    int _e207 = changed_point.x;
    changed_point.z = _e207;
    int _e210 = changed_point.x;
    local_14 = uint(int(11));
    uint _e214 = local_14;
    local_47 = uint(_e214);
    uint _e217 = local_47;
    out_.Store(_e217*4, asuint(_e210));
    int _e220 = changed_point.z;
    local_15 = uint(int(12));
    uint _e224 = local_15;
    local_48 = uint(_e224);
    uint _e227 = local_48;
    out_.Store(_e227*4, asuint(_e220));
    nested[0].x = int(1);
    nested[0].y = int(2);
    nested[0].z = ZeroValueint();
    nested[1].x = int(3);
    nested[1].y = ZeroValueint();
    nested[1].z = ZeroValueint();
    int _e250 = nested[int(0)].z;
    int _e251 = nested[int(1)].x;
    local_16 = uint(int(13));
    uint _e256 = local_16;
    local_49 = uint(_e256);
    uint _e259 = local_49;
    out_.Store(_e259*4, asuint(asint(asuint(_e250) + asuint(_e251))));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e278 = flat[int(0)].x;
    int _e279 = flat[int(0)].y;
    int _e284 = flat[int(1)].x;
    int _e289 = flat[int(1)].y;
    local_17 = uint(int(14));
    uint _e294 = local_17;
    local_50 = uint(_e294);
    uint _e297 = local_50;
    out_.Store(_e297*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e278) + asuint(_e279))) + asuint(_e284))) + asuint(_e289))));
    original.x = int(2);
    original.y = int(3);
    original.z = int(4);
    int3_ _e306 = original;
    copied = _e306;
    int3_ _e310 = original;
    copies[0] = _e310;
    copies[1].x = int(5);
    copies[1].y = int(6);
    copies[1].z = ZeroValueint();
    original.x = int(99);
    int _e321 = copied.x;
    local_18 = uint(int(15));
    uint _e325 = local_18;
    local_51 = uint(_e325);
    uint _e328 = local_51;
    out_.Store(_e328*4, asuint(_e321));
    int _e333 = copies[int(0)].x;
    local_19 = uint(int(16));
    uint _e337 = local_19;
    local_52 = uint(_e337);
    uint _e340 = local_52;
    out_.Store(_e340*4, asuint(_e333));
    int _e345 = copies[int(1)].z;
    local_20 = uint(int(17));
    uint _e349 = local_20;
    local_53 = uint(_e349);
    uint _e352 = local_53;
    out_.Store(_e352*4, asuint(_e345));
    counter = seed_2;
    int _e357 = counter;
    counter = asint(asuint(_e357) + asuint(int(1)));
    ordered[0] = _e357;
    int _e361 = counter;
    counter = asint(asuint(_e361) + asuint(int(1)));
    ordered[1] = _e361;
    int _e365 = counter;
    ordered[2] = _e365;
    int _e368 = ordered[int(0)];
    int _e373 = ordered[int(1)];
    int _e379 = ordered[int(2)];
    local_21 = uint(int(18));
    uint _e384 = local_21;
    local_54 = uint(_e384);
    uint _e387 = local_54;
    out_.Store(_e387*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e368) * asuint(int(100)))) + asuint(asint(asuint(_e373) * asuint(int(10)))))) + asuint(_e379))));
    int _e389 = counter;
    local_22 = uint(int(19));
    uint _e393 = local_22;
    local_55 = uint(_e393);
    uint _e396 = local_55;
    out_.Store(_e396*4, asuint(_e389));
    int _e398 = counter;
    counter = asint(asuint(_e398) + asuint(int(1)));
    const int _e402 = pair(_e398, int(4));
    local_23 = uint(int(20));
    uint _e406 = local_23;
    local_56 = uint(_e406);
    uint _e409 = local_56;
    out_.Store(_e409*4, asuint(_e402));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e439 = iteration;
                iteration = asint(asuint(_e439) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e415 = iteration;
            if ((_e415 < int(3))) {
            } else {
                break;
            }
            int _e420 = iteration;
            reset[0] = _e420;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e428 = local_24;
                    local_24 = (_e428 + 1u);
                }
                loop_init_3 = false;
                uint _e423 = local_24;
                if ((_e423 >= 3u)) {
                    break;
                }
                reset[min(uint(_e423), 2u)] = ZeroValueint();
            }
            int _e433 = reset[int(2)];
            int _e434 = zero_total;
            zero_total = asint(asuint(_e434) + asuint(_e433));
            reset[int(2)] = int(9);
        }
    }
    int _e442 = zero_total;
    local_25 = uint(int(21));
    uint _e446 = local_25;
    local_57 = uint(_e446);
    uint _e449 = local_57;
    out_.Store(_e449*4, asuint(_e442));
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
                int _e463 = iteration_1;
                iteration_1 = asint(asuint(_e463) + asuint(int(1)));
            }
            loop_init_4 = false;
            int _e457 = iteration_1;
            int _e458 = limit;
            if ((_e457 < _e458)) {
            } else {
                break;
            }
            int _e460 = iteration_1;
            int _e461 = total;
            total = asint(asuint(_e461) + asuint(_e460));
        }
    }
    int _e466 = total;
    local_26 = uint(int(22));
    uint _e470 = local_26;
    local_58 = uint(_e470);
    uint _e473 = local_58;
    out_.Store(_e473*4, asuint(_e466));
    Number = int(4);
    int _e479 = Number;
    cached[0] = _e479;
    int _e481 = Number;
    cached[1] = asint(asuint(_e481) + asuint(int(1)));
    int _e486 = cached[int(1)];
    local_27 = uint(int(23));
    uint _e490 = local_27;
    local_59 = uint(_e490);
    uint _e493 = local_59;
    out_.Store(_e493*4, asuint(_e486));
    frozen[0] = int(3);
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e505 = local_28;
            local_28 = (_e505 + 1u);
        }
        loop_init_5 = false;
        uint _e500 = local_28;
        if ((_e500 >= 3u)) {
            break;
        }
        frozen[min(uint(_e500), 2u)] = ZeroValueint();
    }
    int _e512 = frozen[int(0)];
    int _e513 = frozen[int(1)];
    int _e517 = frozen[int(2)];
    local_29 = uint(int(24));
    uint _e522 = local_29;
    local_60 = uint(_e522);
    uint _e525 = local_60;
    out_.Store(_e525*4, asuint(asint(asuint(asint(asuint(_e512) + asuint(_e513))) + asuint(_e517))));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = ZeroValuefloat();
    float _e536 = floating.y;
    local_30 = uint(int(25));
    uint _e541 = local_30;
    local_61 = uint(_e541);
    uint _e544 = local_61;
    out_.Store(_e544*4, asuint(asint(_e536)));
    float _e547 = floating.z;
    local_31 = uint(int(26));
    uint _e552 = local_31;
    local_62 = uint(_e552);
    uint _e555 = local_62;
    out_.Store(_e555*4, asuint(asint(_e547)));
    const int3_ _e558 = make_list(int(6));
    from_call = _e558;
    int _e562 = from_call.x;
    int _e563 = from_call.z;
    local_32 = uint(int(27));
    uint _e568 = local_32;
    local_63 = uint(_e568);
    uint _e571 = local_63;
    out_.Store(_e571*4, asuint(asint(asuint(_e562) + asuint(_e563))));
    local_33 = uint(int(28));
    uint _e580 = local_33;
    local_64 = uint(_e580);
    uint _e583 = local_64;
    out_.Store(_e583*4, asuint(naga_f2i32((Scale * 10.0))));
    const int _e587 = list_sum(asint(asuint(seed_2) + asuint(int(3))));
    local_34 = uint(int(29));
    uint _e591 = local_34;
    local_65 = uint(_e591);
    uint _e594 = local_65;
    out_.Store(_e594*4, asuint(_e587));
}
