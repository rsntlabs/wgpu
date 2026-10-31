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
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_31 = uint(_e3);
    uint _e6 = local_31;
    int seed_2 = asint(out_.Load(_e6*4));
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
    int _e49 = values[int(0)];
    int _e50 = values[int(1)];
    int _e54 = values[int(2)];
    local_1 = uint(int(0));
    uint _e59 = local_1;
    local_32 = uint(_e59);
    uint _e62 = local_32;
    out_.Store(_e62*4, asuint(asint(asuint(asint(asuint(_e49) + asuint(_e50))) + asuint(_e54))));
    int _e66 = copied[int(0)];
    local_2 = uint(int(1));
    uint _e70 = local_2;
    local_33 = uint(_e70);
    uint _e73 = local_33;
    out_.Store(_e73*4, asuint(_e66));
    int _e79 = zeroes[int(0)];
    int _e80 = zeroes[int(1)];
    local_3 = uint(int(2));
    uint _e85 = local_3;
    local_34 = uint(_e85);
    uint _e88 = local_34;
    out_.Store(_e88*4, asuint(asint(asuint(_e79) + asuint(_e80))));
    bool _e92 = flags[int(0)];
    bool _e96 = flags[int(1)];
    bool _e101 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e107 = local_4;
    local_35 = uint(_e107);
    uint _e110 = local_35;
    out_.Store(_e110*4, asuint(asint(asuint(asint(asuint(int(_e92)) + asuint(int(_e96)))) + asuint(int(_e101)))));
    uint _e116 = counts[int(0)];
    uint _e117 = counts[int(1)];
    local_5 = uint(int(4));
    uint _e123 = local_5;
    local_36 = uint(_e123);
    uint _e126 = local_36;
    out_.Store(_e126*4, asuint(int((_e116 + _e117))));
    float _e132 = samples[int(0)];
    float _e133 = samples[int(1)];
    local_6 = uint(int(5));
    uint _e139 = local_6;
    local_37 = uint(_e139);
    uint _e142 = local_37;
    out_.Store(_e142*4, asuint(naga_f2i32((_e132 + _e133))));
    self[0] = int(1);
    int _e150 = self[int(0)];
    self[1] = asint(asuint(_e150) + asuint(int(1)));
    int _e156 = self[int(1)];
    self[2] = asint(asuint(_e156) + asuint(int(1)));
    int _e161 = self[int(0)];
    int _e166 = self[int(1)];
    int _e172 = self[int(2)];
    local_7 = uint(int(6));
    uint _e177 = local_7;
    local_38 = uint(_e177);
    uint _e180 = local_38;
    out_.Store(_e180*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e161) * asuint(int(100)))) + asuint(asint(asuint(_e166) * asuint(int(10)))))) + asuint(_e172))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e193 = changed[int(0)];
    changed[2] = _e193;
    int _e196 = changed[int(0)];
    local_8 = uint(int(7));
    uint _e200 = local_8;
    local_39 = uint(_e200);
    uint _e203 = local_39;
    out_.Store(_e203*4, asuint(_e196));
    int _e207 = changed[int(2)];
    local_9 = uint(int(8));
    uint _e211 = local_9;
    local_40 = uint(_e211);
    uint _e214 = local_40;
    out_.Store(_e214*4, asuint(_e207));
    points[0].x = int(1);
    int _e223 = points[int(0)].x;
    points[0].y = asint(asuint(_e223) + asuint(int(1)));
    int _e230 = points[int(0)].y;
    points[0].z = asint(asuint(_e230) + asuint(int(1)));
    int3_ _e237 = points[int(0)];
    points[1] = _e237;
    int _e241 = points[int(1)].z;
    local_10 = uint(int(9));
    uint _e245 = local_10;
    local_41 = uint(_e245);
    uint _e248 = local_41;
    out_.Store(_e248*4, asuint(_e241));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e264 = flat[int(1)].y;
    local_11 = uint(int(10));
    uint _e268 = local_11;
    local_42 = uint(_e268);
    uint _e271 = local_42;
    out_.Store(_e271*4, asuint(_e264));
    int _e276 = flat[int(1)].x;
    local_12 = uint(int(11));
    uint _e280 = local_12;
    local_43 = uint(_e280);
    uint _e283 = local_43;
    out_.Store(_e283*4, asuint(_e276));
    original.x = int(4);
    original.y = int(5);
    original.z = int(6);
    int3_ _e294 = original;
    copies[0] = _e294;
    int3_ _e296 = original;
    copies[1] = _e296;
    copies[2].x = int(7);
    copies[2].y = int(8);
    copies[2].z = ZeroValueint();
    original.x = int(99);
    int _e309 = copies[int(0)].x;
    local_13 = uint(int(12));
    uint _e313 = local_13;
    local_44 = uint(_e313);
    uint _e316 = local_44;
    out_.Store(_e316*4, asuint(_e309));
    int _e321 = copies[int(1)].y;
    local_14 = uint(int(13));
    uint _e325 = local_14;
    local_45 = uint(_e325);
    uint _e328 = local_45;
    out_.Store(_e328*4, asuint(_e321));
    int _e333 = copies[int(2)].z;
    local_15 = uint(int(14));
    uint _e337 = local_15;
    local_46 = uint(_e337);
    uint _e340 = local_46;
    out_.Store(_e340*4, asuint(_e333));
    Number[0] = int(2);
    Number[1] = int(3);
    int _e351 = Number[int(1)];
    next[0] = _e351;
    int _e355 = Number[int(0)];
    next[1] = _e355;
    int _e358 = next[int(0)];
    local_16 = uint(int(15));
    uint _e362 = local_16;
    local_47 = uint(_e362);
    uint _e365 = local_47;
    out_.Store(_e365*4, asuint(_e358));
    Count = int(3);
    scratch = ZeroValuearray3_int_();
    int _e373 = scratch[int(2)];
    local_17 = uint(int(16));
    uint _e377 = local_17;
    local_48 = uint(_e377);
    uint _e380 = local_48;
    out_.Store(_e380*4, asuint(_e373));
    pending[0] = 1.0;
    pending[1] = float(int(2));
    float _e392 = pending[int(0)];
    float _e393 = pending[int(1)];
    local_18 = uint(int(17));
    uint _e399 = local_18;
    local_49 = uint(_e399);
    uint _e402 = local_49;
    out_.Store(_e402*4, asuint(naga_f2i32((_e392 + _e393))));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(int(2));
    pending_vectors[0].z = ZeroValuefloat();
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = ZeroValuefloat();
    pending_vectors[1].z = ZeroValuefloat();
    float _e426 = pending_vectors[int(0)].x;
    float _e427 = pending_vectors[int(0)].y;
    float _e432 = pending_vectors[int(1)].x;
    local_19 = uint(int(18));
    uint _e438 = local_19;
    local_50 = uint(_e438);
    uint _e441 = local_50;
    out_.Store(_e441*4, asuint(naga_f2i32(((_e426 + _e427) + _e432))));
    counter = seed_2;
    int _e446 = counter;
    counter = asint(asuint(_e446) + asuint(int(1)));
    ordered[0] = _e446;
    int _e450 = counter;
    counter = asint(asuint(_e450) + asuint(int(1)));
    ordered[1] = _e450;
    int _e454 = counter;
    ordered[2] = _e454;
    int _e457 = ordered[int(0)];
    int _e462 = ordered[int(1)];
    int _e468 = ordered[int(2)];
    local_20 = uint(int(19));
    uint _e473 = local_20;
    local_51 = uint(_e473);
    uint _e476 = local_51;
    out_.Store(_e476*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e457) * asuint(int(100)))) + asuint(asint(asuint(_e462) * asuint(int(10)))))) + asuint(_e468))));
    int _e478 = counter;
    local_21 = uint(int(20));
    uint _e482 = local_21;
    local_52 = uint(_e482);
    uint _e485 = local_52;
    out_.Store(_e485*4, asuint(_e478));
    int _e489 = counter;
    counter = asint(asuint(_e489) + asuint(int(1)));
    const int _e493 = pair(_e489, int(4));
    called[0] = _e493;
    int _e495 = counter;
    called[1] = _e495;
    int _e500 = called[int(0)];
    int _e501 = called[int(1)];
    local_22 = uint(int(21));
    uint _e506 = local_22;
    local_53 = uint(_e506);
    uint _e509 = local_53;
    out_.Store(_e509*4, asuint(asint(asuint(_e500) + asuint(_e501))));
    int _e511 = counter;
    local_23 = uint(int(22));
    uint _e515 = local_23;
    local_54 = uint(_e515);
    uint _e518 = local_54;
    out_.Store(_e518*4, asuint(_e511));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e554 = iteration;
                iteration = asint(asuint(_e554) + asuint(int(1)));
            }
            loop_init = false;
            int _e524 = iteration;
            if ((_e524 < int(3))) {
            } else {
                break;
            }
            int _e529 = iteration;
            reset[0].x = _e529;
            reset[0].y = ZeroValueint();
            reset[1] = ZeroValueint2();
            int _e541 = reset[int(0)].y;
            int _e542 = reset[int(1)].x;
            int _e544 = zero_total;
            zero_total = asint(asuint(_e544) + asuint(asint(asuint(_e541) + asuint(_e542))));
            reset[int(0)].y = int(9);
            reset[int(1)].x = int(8);
        }
    }
    int _e557 = zero_total;
    local_24 = uint(int(23));
    uint _e561 = local_24;
    local_55 = uint(_e561);
    uint _e564 = local_55;
    out_.Store(_e564*4, asuint(_e557));
    total = int(0);
    {
        iteration_1 = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e579 = iteration_1;
                iteration_1 = asint(asuint(_e579) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e570 = iteration_1;
            if ((_e570 < int(4))) {
            } else {
                break;
            }
            int _e573 = iteration_1;
            if ((_e573 == int(1))) {
                continue;
            }
            int _e576 = iteration_1;
            int _e577 = total;
            total = asint(asuint(_e577) + asuint(_e576));
        }
    }
    int _e582 = total;
    local_25 = uint(int(24));
    uint _e586 = local_25;
    local_56 = uint(_e586);
    uint _e589 = local_56;
    out_.Store(_e589*4, asuint(_e582));
    const int _e592 = sum(int(4));
    local_26 = uint(int(25));
    uint _e596 = local_26;
    local_57 = uint(_e596);
    uint _e599 = local_57;
    out_.Store(_e599*4, asuint(_e592));
    frozen[0] = int(2);
    frozen[1] = int(3);
    int _e610 = frozen[int(0)];
    int _e611 = frozen[int(1)];
    local_27 = uint(int(26));
    uint _e616 = local_27;
    local_58 = uint(_e616);
    uint _e619 = local_58;
    out_.Store(_e619*4, asuint(asint(asuint(_e610) + asuint(_e611))));
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e629 = signed_zeroes[int(0)];
    local_28 = uint(int(27));
    uint _e634 = local_28;
    local_59 = uint(_e634);
    uint _e637 = local_59;
    out_.Store(_e637*4, asuint(asint(_e629)));
    float _e641 = signed_zeroes[int(1)];
    local_29 = uint(int(28));
    uint _e646 = local_29;
    local_60 = uint(_e646);
    uint _e649 = local_60;
    out_.Store(_e649*4, asuint(asint(_e641)));
    const int3_ _e654 = triple(int(6));
    from_calls[0] = _e654;
    const int3_ _e657 = triple(int(9));
    from_calls[1] = _e657;
    int _e664 = from_calls[int(0)].x;
    int _e665 = from_calls[int(1)].z;
    local_30 = uint(int(29));
    uint _e670 = local_30;
    local_61 = uint(_e670);
    uint _e673 = local_61;
    out_.Store(_e673*4, asuint(asint(asuint(_e664) + asuint(_e665))));
}
