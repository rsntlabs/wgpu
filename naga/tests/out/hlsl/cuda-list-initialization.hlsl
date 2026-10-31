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
    uint local_68 = (uint)0;

    values_1[0] = seed;
    values_1[1] = asint(asuint(seed) + asuint(int(1)));
    local_68 = 2u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_68;
            local_68 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_68;
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
    int local_35 = (int)0;
    uint local_36 = (uint)0;
    int local_37 = (int)0;
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
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_36 = uint(_e3);
    uint _e6 = local_36;
    int _e9 = asint(out_.Load(_e6*4));
    local_37 = _e9;
    int _e11 = local_37;
    local_35 = _e11;
    int seed_2 = local_35;
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
            uint _e38 = local_2;
            local_2 = (_e38 + 1u);
        }
        loop_init_1 = false;
        uint _e33 = local_2;
        if ((_e33 >= 3u)) {
            break;
        }
        safe_values[min(uint(_e33), 2u)] = ZeroValueint();
    }
    int _e41 = zero;
    local_3 = uint(int(0));
    uint _e45 = local_3;
    local_38 = uint(_e45);
    uint _e48 = local_38;
    out_.Store(_e48*4, asuint(_e41));
    int _e50 = copy_zero;
    local_4 = uint(int(1));
    uint _e54 = local_4;
    local_39 = uint(_e54);
    uint _e57 = local_39;
    out_.Store(_e57*4, asuint(_e50));
    bool _e59 = enabled;
    local_5 = uint(int(2));
    uint _e64 = local_5;
    local_40 = uint(_e64);
    uint _e67 = local_40;
    out_.Store(_e67*4, asuint(int(_e59)));
    local_6 = uint(int(3));
    uint _e73 = local_6;
    local_41 = uint(_e73);
    uint _e76 = local_41;
    out_.Store(_e76*4, asuint(int(count)));
    float _e78 = sample_;
    local_7 = uint(int(4));
    uint _e85 = local_7;
    local_42 = uint(_e85);
    uint _e88 = local_42;
    out_.Store(_e88*4, asuint(naga_f2i32((_e78 * 2.0))));
    int _e90 = Local;
    local_8 = uint(int(5));
    uint _e96 = local_8;
    local_43 = uint(_e96);
    uint _e99 = local_43;
    out_.Store(_e99*4, asuint(asint(asuint(Global) + asuint(_e90))));
    int _e103 = safe_values[int(2)];
    local_9 = uint(int(6));
    uint _e107 = local_9;
    local_44 = uint(_e107);
    uint _e110 = local_44;
    out_.Store(_e110*4, asuint(_e103));
    values[0] = int(1);
    int _e118 = values[int(0)];
    values[1] = asint(asuint(_e118) + asuint(int(1)));
    int _e124 = values[int(1)];
    values[2] = asint(asuint(_e124) + asuint(int(1)));
    int _e131 = values[int(0)];
    int _e132 = values[int(1)];
    int _e136 = values[int(2)];
    local_10 = uint(int(7));
    uint _e141 = local_10;
    local_45 = uint(_e141);
    uint _e144 = local_45;
    out_.Store(_e144*4, asuint(asint(asuint(asint(asuint(_e131) + asuint(_e132))) + asuint(_e136))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e157 = changed[int(0)];
    changed[2] = _e157;
    int _e160 = changed[int(0)];
    local_11 = uint(int(8));
    uint _e164 = local_11;
    local_46 = uint(_e164);
    uint _e167 = local_46;
    out_.Store(_e167*4, asuint(_e160));
    int _e171 = changed[int(2)];
    local_12 = uint(int(9));
    uint _e175 = local_12;
    local_47 = uint(_e175);
    uint _e178 = local_47;
    out_.Store(_e178*4, asuint(_e171));
    point_.x = int(1);
    int _e184 = point_.x;
    point_.y = asint(asuint(_e184) + asuint(int(1)));
    int _e189 = point_.y;
    point_.z = asint(asuint(_e189) + asuint(int(1)));
    int _e194 = point_.z;
    local_13 = uint(int(10));
    uint _e198 = local_13;
    local_48 = uint(_e198);
    uint _e201 = local_48;
    out_.Store(_e201*4, asuint(_e194));
    changed_point.x = int(1);
    changed_point.x = int(9);
    changed_point.y = int(2);
    int _e211 = changed_point.x;
    changed_point.z = _e211;
    int _e214 = changed_point.x;
    local_14 = uint(int(11));
    uint _e218 = local_14;
    local_49 = uint(_e218);
    uint _e221 = local_49;
    out_.Store(_e221*4, asuint(_e214));
    int _e224 = changed_point.z;
    local_15 = uint(int(12));
    uint _e228 = local_15;
    local_50 = uint(_e228);
    uint _e231 = local_50;
    out_.Store(_e231*4, asuint(_e224));
    nested[0].x = int(1);
    nested[0].y = int(2);
    nested[0].z = ZeroValueint();
    nested[1].x = int(3);
    nested[1].y = ZeroValueint();
    nested[1].z = ZeroValueint();
    int _e254 = nested[int(0)].z;
    int _e255 = nested[int(1)].x;
    local_16 = uint(int(13));
    uint _e260 = local_16;
    local_51 = uint(_e260);
    uint _e263 = local_51;
    out_.Store(_e263*4, asuint(asint(asuint(_e254) + asuint(_e255))));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e282 = flat[int(0)].x;
    int _e283 = flat[int(0)].y;
    int _e288 = flat[int(1)].x;
    int _e293 = flat[int(1)].y;
    local_17 = uint(int(14));
    uint _e298 = local_17;
    local_52 = uint(_e298);
    uint _e301 = local_52;
    out_.Store(_e301*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e282) + asuint(_e283))) + asuint(_e288))) + asuint(_e293))));
    original.x = int(2);
    original.y = int(3);
    original.z = int(4);
    int3_ _e310 = original;
    copied = _e310;
    int3_ _e314 = original;
    copies[0] = _e314;
    copies[1].x = int(5);
    copies[1].y = int(6);
    copies[1].z = ZeroValueint();
    original.x = int(99);
    int _e325 = copied.x;
    local_18 = uint(int(15));
    uint _e329 = local_18;
    local_53 = uint(_e329);
    uint _e332 = local_53;
    out_.Store(_e332*4, asuint(_e325));
    int _e337 = copies[int(0)].x;
    local_19 = uint(int(16));
    uint _e341 = local_19;
    local_54 = uint(_e341);
    uint _e344 = local_54;
    out_.Store(_e344*4, asuint(_e337));
    int _e349 = copies[int(1)].z;
    local_20 = uint(int(17));
    uint _e353 = local_20;
    local_55 = uint(_e353);
    uint _e356 = local_55;
    out_.Store(_e356*4, asuint(_e349));
    counter = seed_2;
    int _e361 = counter;
    counter = asint(asuint(_e361) + asuint(int(1)));
    ordered[0] = _e361;
    int _e365 = counter;
    counter = asint(asuint(_e365) + asuint(int(1)));
    ordered[1] = _e365;
    int _e369 = counter;
    ordered[2] = _e369;
    int _e372 = ordered[int(0)];
    int _e377 = ordered[int(1)];
    int _e383 = ordered[int(2)];
    local_21 = uint(int(18));
    uint _e388 = local_21;
    local_56 = uint(_e388);
    uint _e391 = local_56;
    out_.Store(_e391*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e372) * asuint(int(100)))) + asuint(asint(asuint(_e377) * asuint(int(10)))))) + asuint(_e383))));
    int _e393 = counter;
    local_22 = uint(int(19));
    uint _e397 = local_22;
    local_57 = uint(_e397);
    uint _e400 = local_57;
    out_.Store(_e400*4, asuint(_e393));
    int _e402 = counter;
    counter = asint(asuint(_e402) + asuint(int(1)));
    const int _e406 = pair(_e402, int(4));
    local_23 = uint(int(20));
    uint _e410 = local_23;
    local_58 = uint(_e410);
    uint _e413 = local_58;
    out_.Store(_e413*4, asuint(_e406));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e443 = iteration;
                iteration = asint(asuint(_e443) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e419 = iteration;
            if ((_e419 < int(3))) {
            } else {
                break;
            }
            int _e424 = iteration;
            reset[0] = _e424;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e432 = local_24;
                    local_24 = (_e432 + 1u);
                }
                loop_init_3 = false;
                uint _e427 = local_24;
                if ((_e427 >= 3u)) {
                    break;
                }
                reset[min(uint(_e427), 2u)] = ZeroValueint();
            }
            int _e437 = reset[int(2)];
            int _e438 = zero_total;
            zero_total = asint(asuint(_e438) + asuint(_e437));
            reset[int(2)] = int(9);
        }
    }
    int _e446 = zero_total;
    local_25 = uint(int(21));
    uint _e450 = local_25;
    local_59 = uint(_e450);
    uint _e453 = local_59;
    out_.Store(_e453*4, asuint(_e446));
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
                int _e467 = iteration_1;
                iteration_1 = asint(asuint(_e467) + asuint(int(1)));
            }
            loop_init_4 = false;
            int _e461 = iteration_1;
            int _e462 = limit;
            if ((_e461 < _e462)) {
            } else {
                break;
            }
            int _e464 = iteration_1;
            int _e465 = total;
            total = asint(asuint(_e465) + asuint(_e464));
        }
    }
    int _e470 = total;
    local_26 = uint(int(22));
    uint _e474 = local_26;
    local_60 = uint(_e474);
    uint _e477 = local_60;
    out_.Store(_e477*4, asuint(_e470));
    Number = int(4);
    int _e483 = Number;
    cached[0] = _e483;
    int _e485 = Number;
    cached[1] = asint(asuint(_e485) + asuint(int(1)));
    int _e490 = cached[int(1)];
    local_27 = uint(int(23));
    uint _e494 = local_27;
    local_61 = uint(_e494);
    uint _e497 = local_61;
    out_.Store(_e497*4, asuint(_e490));
    frozen[0] = int(3);
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e509 = local_28;
            local_28 = (_e509 + 1u);
        }
        loop_init_5 = false;
        uint _e504 = local_28;
        if ((_e504 >= 3u)) {
            break;
        }
        frozen[min(uint(_e504), 2u)] = ZeroValueint();
    }
    int _e516 = frozen[int(0)];
    int _e517 = frozen[int(1)];
    int _e521 = frozen[int(2)];
    local_29 = uint(int(24));
    uint _e526 = local_29;
    local_62 = uint(_e526);
    uint _e529 = local_62;
    out_.Store(_e529*4, asuint(asint(asuint(asint(asuint(_e516) + asuint(_e517))) + asuint(_e521))));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = ZeroValuefloat();
    float _e540 = floating.y;
    local_30 = uint(int(25));
    uint _e545 = local_30;
    local_63 = uint(_e545);
    uint _e548 = local_63;
    out_.Store(_e548*4, asuint(asint(_e540)));
    float _e551 = floating.z;
    local_31 = uint(int(26));
    uint _e556 = local_31;
    local_64 = uint(_e556);
    uint _e559 = local_64;
    out_.Store(_e559*4, asuint(asint(_e551)));
    const int3_ _e562 = make_list(int(6));
    from_call = _e562;
    int _e566 = from_call.x;
    int _e567 = from_call.z;
    local_32 = uint(int(27));
    uint _e572 = local_32;
    local_65 = uint(_e572);
    uint _e575 = local_65;
    out_.Store(_e575*4, asuint(asint(asuint(_e566) + asuint(_e567))));
    local_33 = uint(int(28));
    uint _e584 = local_33;
    local_66 = uint(_e584);
    uint _e587 = local_66;
    out_.Store(_e587*4, asuint(naga_f2i32((Scale * 10.0))));
    const int _e591 = list_sum(asint(asuint(seed_2) + asuint(int(3))));
    local_34 = uint(int(29));
    uint _e595 = local_34;
    local_67 = uint(_e595);
    uint _e598 = local_67;
    out_.Store(_e598*4, asuint(_e591));
}
