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

RWByteAddressBuffer out_ : register(u0);

int pair(int first, int second)
{
    return asint(asuint(asint(asuint(first) * asuint(int(10)))) + asuint(second));
}

int sum(int seed)
{
    int values_1[2] = (int[2])0;

    values_1[0] = seed;
    values_1[1] = asint(asuint(seed) + asuint(int(1)));
    int _e10 = values_1[int(0)];
    int _e11 = values_1[int(1)];
    return asint(asuint(_e10) + asuint(_e11));
}

int3_ triple(int seed_1)
{
    int3_ value = (int3_)0;

    value.x = seed_1;
    value.y = asint(asuint(seed_1) + asuint(int(1)));
    value.z = asint(asuint(seed_1) + asuint(int(2)));
    int3_ _e9 = value;
    const int3_ int3_1 = _e9;
    return int3_1;
}

int ZeroValueint() {
    return (int)0;
}

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

float ZeroValuefloat() {
    return (float)0;
}

int2 ZeroValueint2() {
    return (int2)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void inferred_arrays()
{
    uint local = (uint)0;
    int values[3] = (int[3])0;
    int copied[2] = (int[2])0;
    int zeroes[2] = (int[2])0;
    bool flags[3] = (bool[3])0;
    uint counts[2] = (uint[2])0;
    float samples[2] = (float[2])0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    int self[3] = (int[3])0;
    uint local_7 = (uint)0;
    int changed[3] = (int[3])0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int3_ points[2] = (int3_[2])0;
    uint local_10 = (uint)0;
    int2 flat[2] = (int2[2])0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    int3_ original = (int3_)0;
    int3_ copies[3] = (int3_[3])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int Number[2] = (int[2])0;
    int next[2] = (int[2])0;
    uint local_16 = (uint)0;
    int Count = (int)0;
    int scratch[3] = (int[3])0;
    uint local_17 = (uint)0;
    float pending[2] = (float[2])0;
    uint local_18 = (uint)0;
    float3_ pending_vectors[2] = (float3_[2])0;
    uint local_19 = (uint)0;
    int counter = (int)0;
    int ordered[3] = (int[3])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    int called[2] = (int[2])0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    int zero_total = (int)0;
    int iteration = (int)0;
    int2 reset[2] = (int2[2])0;
    uint local_24 = (uint)0;
    int total = (int)0;
    int iteration_1 = (int)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    int frozen[2] = (int[2])0;
    uint local_27 = (uint)0;
    float signed_zeroes[2] = (float[2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    int3_ from_calls[2] = (int3_[2])0;
    uint local_30 = (uint)0;
    int local_31 = (int)0;
    uint local_32 = (uint)0;
    int local_33 = (int)0;
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

    local = uint(int(0));
    uint _e3 = local;
    local_32 = uint(_e3);
    uint _e6 = local_32;
    int _e9 = asint(out_.Load(_e6*4));
    local_33 = _e9;
    int _e11 = local_33;
    local_31 = _e11;
    int seed_2 = local_31;
    values[0] = seed_2;
    values[1] = asint(asuint(seed_2) + asuint(int(1)));
    values[2] = asint(asuint(seed_2) + asuint(int(2)));
    copied[0] = int(4);
    copied[1] = int(5);
    zeroes[0] = int(0);
    zeroes[1] = int(0);
    flags[0] = true;
    flags[1] = false;
    flags[2] = true;
    counts[0] = 3u;
    counts[1] = 5u;
    samples[0] = 1.5;
    samples[1] = 2.5;
    int _e53 = values[int(0)];
    int _e54 = values[int(1)];
    int _e58 = values[int(2)];
    local_1 = uint(int(0));
    uint _e63 = local_1;
    local_34 = uint(_e63);
    uint _e66 = local_34;
    out_.Store(_e66*4, asuint(asint(asuint(asint(asuint(_e53) + asuint(_e54))) + asuint(_e58))));
    int _e70 = copied[int(0)];
    local_2 = uint(int(1));
    uint _e74 = local_2;
    local_35 = uint(_e74);
    uint _e77 = local_35;
    out_.Store(_e77*4, asuint(_e70));
    int _e83 = zeroes[int(0)];
    int _e84 = zeroes[int(1)];
    local_3 = uint(int(2));
    uint _e89 = local_3;
    local_36 = uint(_e89);
    uint _e92 = local_36;
    out_.Store(_e92*4, asuint(asint(asuint(_e83) + asuint(_e84))));
    bool _e96 = flags[int(0)];
    bool _e100 = flags[int(1)];
    bool _e105 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e111 = local_4;
    local_37 = uint(_e111);
    uint _e114 = local_37;
    out_.Store(_e114*4, asuint(asint(asuint(asint(asuint(int(_e96)) + asuint(int(_e100)))) + asuint(int(_e105)))));
    uint _e120 = counts[int(0)];
    uint _e121 = counts[int(1)];
    local_5 = uint(int(4));
    uint _e127 = local_5;
    local_38 = uint(_e127);
    uint _e130 = local_38;
    out_.Store(_e130*4, asuint(int((_e120 + _e121))));
    float _e136 = samples[int(0)];
    float _e137 = samples[int(1)];
    local_6 = uint(int(5));
    uint _e143 = local_6;
    local_39 = uint(_e143);
    uint _e146 = local_39;
    out_.Store(_e146*4, asuint(naga_f2i32((_e136 + _e137))));
    self[0] = int(1);
    int _e154 = self[int(0)];
    self[1] = asint(asuint(_e154) + asuint(int(1)));
    int _e160 = self[int(1)];
    self[2] = asint(asuint(_e160) + asuint(int(1)));
    int _e165 = self[int(0)];
    int _e170 = self[int(1)];
    int _e176 = self[int(2)];
    local_7 = uint(int(6));
    uint _e181 = local_7;
    local_40 = uint(_e181);
    uint _e184 = local_40;
    out_.Store(_e184*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e165) * asuint(int(100)))) + asuint(asint(asuint(_e170) * asuint(int(10)))))) + asuint(_e176))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e197 = changed[int(0)];
    changed[2] = _e197;
    int _e200 = changed[int(0)];
    local_8 = uint(int(7));
    uint _e204 = local_8;
    local_41 = uint(_e204);
    uint _e207 = local_41;
    out_.Store(_e207*4, asuint(_e200));
    int _e211 = changed[int(2)];
    local_9 = uint(int(8));
    uint _e215 = local_9;
    local_42 = uint(_e215);
    uint _e218 = local_42;
    out_.Store(_e218*4, asuint(_e211));
    points[0].x = int(1);
    int _e227 = points[int(0)].x;
    points[0].y = asint(asuint(_e227) + asuint(int(1)));
    int _e234 = points[int(0)].y;
    points[0].z = asint(asuint(_e234) + asuint(int(1)));
    int3_ _e241 = points[int(0)];
    points[1] = _e241;
    int _e245 = points[int(1)].z;
    local_10 = uint(int(9));
    uint _e249 = local_10;
    local_43 = uint(_e249);
    uint _e252 = local_43;
    out_.Store(_e252*4, asuint(_e245));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e268 = flat[int(1)].y;
    local_11 = uint(int(10));
    uint _e272 = local_11;
    local_44 = uint(_e272);
    uint _e275 = local_44;
    out_.Store(_e275*4, asuint(_e268));
    int _e280 = flat[int(1)].x;
    local_12 = uint(int(11));
    uint _e284 = local_12;
    local_45 = uint(_e284);
    uint _e287 = local_45;
    out_.Store(_e287*4, asuint(_e280));
    original.x = int(4);
    original.y = int(5);
    original.z = int(6);
    int3_ _e298 = original;
    copies[0] = _e298;
    int3_ _e300 = original;
    copies[1] = _e300;
    copies[2].x = int(7);
    copies[2].y = int(8);
    copies[2].z = ZeroValueint();
    original.x = int(99);
    int _e313 = copies[int(0)].x;
    local_13 = uint(int(12));
    uint _e317 = local_13;
    local_46 = uint(_e317);
    uint _e320 = local_46;
    out_.Store(_e320*4, asuint(_e313));
    int _e325 = copies[int(1)].y;
    local_14 = uint(int(13));
    uint _e329 = local_14;
    local_47 = uint(_e329);
    uint _e332 = local_47;
    out_.Store(_e332*4, asuint(_e325));
    int _e337 = copies[int(2)].z;
    local_15 = uint(int(14));
    uint _e341 = local_15;
    local_48 = uint(_e341);
    uint _e344 = local_48;
    out_.Store(_e344*4, asuint(_e337));
    Number[0] = int(2);
    Number[1] = int(3);
    int _e355 = Number[int(1)];
    next[0] = _e355;
    int _e359 = Number[int(0)];
    next[1] = _e359;
    int _e362 = next[int(0)];
    local_16 = uint(int(15));
    uint _e366 = local_16;
    local_49 = uint(_e366);
    uint _e369 = local_49;
    out_.Store(_e369*4, asuint(_e362));
    Count = int(3);
    scratch = ZeroValuearray3_int_();
    int _e377 = scratch[int(2)];
    local_17 = uint(int(16));
    uint _e381 = local_17;
    local_50 = uint(_e381);
    uint _e384 = local_50;
    out_.Store(_e384*4, asuint(_e377));
    pending[0] = 1.0;
    pending[1] = float(int(2));
    float _e396 = pending[int(0)];
    float _e397 = pending[int(1)];
    local_18 = uint(int(17));
    uint _e403 = local_18;
    local_51 = uint(_e403);
    uint _e406 = local_51;
    out_.Store(_e406*4, asuint(naga_f2i32((_e396 + _e397))));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(int(2));
    pending_vectors[0].z = ZeroValuefloat();
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = ZeroValuefloat();
    pending_vectors[1].z = ZeroValuefloat();
    float _e430 = pending_vectors[int(0)].x;
    float _e431 = pending_vectors[int(0)].y;
    float _e436 = pending_vectors[int(1)].x;
    local_19 = uint(int(18));
    uint _e442 = local_19;
    local_52 = uint(_e442);
    uint _e445 = local_52;
    out_.Store(_e445*4, asuint(naga_f2i32(((_e430 + _e431) + _e436))));
    counter = seed_2;
    int _e450 = counter;
    counter = asint(asuint(_e450) + asuint(int(1)));
    ordered[0] = _e450;
    int _e454 = counter;
    counter = asint(asuint(_e454) + asuint(int(1)));
    ordered[1] = _e454;
    int _e458 = counter;
    ordered[2] = _e458;
    int _e461 = ordered[int(0)];
    int _e466 = ordered[int(1)];
    int _e472 = ordered[int(2)];
    local_20 = uint(int(19));
    uint _e477 = local_20;
    local_53 = uint(_e477);
    uint _e480 = local_53;
    out_.Store(_e480*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e461) * asuint(int(100)))) + asuint(asint(asuint(_e466) * asuint(int(10)))))) + asuint(_e472))));
    int _e482 = counter;
    local_21 = uint(int(20));
    uint _e486 = local_21;
    local_54 = uint(_e486);
    uint _e489 = local_54;
    out_.Store(_e489*4, asuint(_e482));
    int _e493 = counter;
    counter = asint(asuint(_e493) + asuint(int(1)));
    const int _e497 = pair(_e493, int(4));
    called[0] = _e497;
    int _e499 = counter;
    called[1] = _e499;
    int _e504 = called[int(0)];
    int _e505 = called[int(1)];
    local_22 = uint(int(21));
    uint _e510 = local_22;
    local_55 = uint(_e510);
    uint _e513 = local_55;
    out_.Store(_e513*4, asuint(asint(asuint(_e504) + asuint(_e505))));
    int _e515 = counter;
    local_23 = uint(int(22));
    uint _e519 = local_23;
    local_56 = uint(_e519);
    uint _e522 = local_56;
    out_.Store(_e522*4, asuint(_e515));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e558 = iteration;
                iteration = asint(asuint(_e558) + asuint(int(1)));
            }
            loop_init = false;
            int _e528 = iteration;
            if ((_e528 < int(3))) {
            } else {
                break;
            }
            int _e533 = iteration;
            reset[0].x = _e533;
            reset[0].y = ZeroValueint();
            reset[1] = ZeroValueint2();
            int _e545 = reset[int(0)].y;
            int _e546 = reset[int(1)].x;
            int _e548 = zero_total;
            zero_total = asint(asuint(_e548) + asuint(asint(asuint(_e545) + asuint(_e546))));
            reset[int(0)].y = int(9);
            reset[int(1)].x = int(8);
        }
    }
    int _e561 = zero_total;
    local_24 = uint(int(23));
    uint _e565 = local_24;
    local_57 = uint(_e565);
    uint _e568 = local_57;
    out_.Store(_e568*4, asuint(_e561));
    total = int(0);
    {
        iteration_1 = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e583 = iteration_1;
                iteration_1 = asint(asuint(_e583) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e574 = iteration_1;
            if ((_e574 < int(4))) {
            } else {
                break;
            }
            int _e577 = iteration_1;
            if ((_e577 == int(1))) {
                continue;
            }
            int _e580 = iteration_1;
            int _e581 = total;
            total = asint(asuint(_e581) + asuint(_e580));
        }
    }
    int _e586 = total;
    local_25 = uint(int(24));
    uint _e590 = local_25;
    local_58 = uint(_e590);
    uint _e593 = local_58;
    out_.Store(_e593*4, asuint(_e586));
    const int _e596 = sum(int(4));
    local_26 = uint(int(25));
    uint _e600 = local_26;
    local_59 = uint(_e600);
    uint _e603 = local_59;
    out_.Store(_e603*4, asuint(_e596));
    frozen[0] = int(2);
    frozen[1] = int(3);
    int _e614 = frozen[int(0)];
    int _e615 = frozen[int(1)];
    local_27 = uint(int(26));
    uint _e620 = local_27;
    local_60 = uint(_e620);
    uint _e623 = local_60;
    out_.Store(_e623*4, asuint(asint(asuint(_e614) + asuint(_e615))));
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e633 = signed_zeroes[int(0)];
    local_28 = uint(int(27));
    uint _e638 = local_28;
    local_61 = uint(_e638);
    uint _e641 = local_61;
    out_.Store(_e641*4, asuint(asint(_e633)));
    float _e645 = signed_zeroes[int(1)];
    local_29 = uint(int(28));
    uint _e650 = local_29;
    local_62 = uint(_e650);
    uint _e653 = local_62;
    out_.Store(_e653*4, asuint(asint(_e645)));
    const int3_ _e658 = triple(int(6));
    from_calls[0] = _e658;
    const int3_ _e661 = triple(int(9));
    from_calls[1] = _e661;
    int _e668 = from_calls[int(0)].x;
    int _e669 = from_calls[int(1)].z;
    local_30 = uint(int(29));
    uint _e674 = local_30;
    local_63 = uint(_e674);
    uint _e677 = local_63;
    out_.Store(_e677*4, asuint(asint(asuint(_e668) + asuint(_e669))));
}
