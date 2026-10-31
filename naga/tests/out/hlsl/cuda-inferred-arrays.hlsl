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

    local = uint(int(0));
    uint _e3 = local;
    int seed_2 = asint(out_.Load(_e3*4));
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
    int _e46 = values[int(0)];
    int _e47 = values[int(1)];
    int _e51 = values[int(2)];
    local_1 = uint(int(0));
    uint _e56 = local_1;
    out_.Store(_e56*4, asuint(asint(asuint(asint(asuint(_e46) + asuint(_e47))) + asuint(_e51))));
    int _e60 = copied[int(0)];
    local_2 = uint(int(1));
    uint _e64 = local_2;
    out_.Store(_e64*4, asuint(_e60));
    int _e70 = zeroes[int(0)];
    int _e71 = zeroes[int(1)];
    local_3 = uint(int(2));
    uint _e76 = local_3;
    out_.Store(_e76*4, asuint(asint(asuint(_e70) + asuint(_e71))));
    bool _e80 = flags[int(0)];
    bool _e84 = flags[int(1)];
    bool _e89 = flags[int(2)];
    local_4 = uint(int(3));
    uint _e95 = local_4;
    out_.Store(_e95*4, asuint(asint(asuint(asint(asuint(int(_e80)) + asuint(int(_e84)))) + asuint(int(_e89)))));
    uint _e101 = counts[int(0)];
    uint _e102 = counts[int(1)];
    local_5 = uint(int(4));
    uint _e108 = local_5;
    out_.Store(_e108*4, asuint(int((_e101 + _e102))));
    float _e114 = samples[int(0)];
    float _e115 = samples[int(1)];
    local_6 = uint(int(5));
    uint _e121 = local_6;
    out_.Store(_e121*4, asuint(naga_f2i32((_e114 + _e115))));
    self[0] = int(1);
    int _e129 = self[int(0)];
    self[1] = asint(asuint(_e129) + asuint(int(1)));
    int _e135 = self[int(1)];
    self[2] = asint(asuint(_e135) + asuint(int(1)));
    int _e140 = self[int(0)];
    int _e145 = self[int(1)];
    int _e151 = self[int(2)];
    local_7 = uint(int(6));
    uint _e156 = local_7;
    out_.Store(_e156*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e140) * asuint(int(100)))) + asuint(asint(asuint(_e145) * asuint(int(10)))))) + asuint(_e151))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e169 = changed[int(0)];
    changed[2] = _e169;
    int _e172 = changed[int(0)];
    local_8 = uint(int(7));
    uint _e176 = local_8;
    out_.Store(_e176*4, asuint(_e172));
    int _e180 = changed[int(2)];
    local_9 = uint(int(8));
    uint _e184 = local_9;
    out_.Store(_e184*4, asuint(_e180));
    points[0].x = int(1);
    int _e193 = points[int(0)].x;
    points[0].y = asint(asuint(_e193) + asuint(int(1)));
    int _e200 = points[int(0)].y;
    points[0].z = asint(asuint(_e200) + asuint(int(1)));
    int3_ _e207 = points[int(0)];
    points[1] = _e207;
    int _e211 = points[int(1)].z;
    local_10 = uint(int(9));
    uint _e215 = local_10;
    out_.Store(_e215*4, asuint(_e211));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e231 = flat[int(1)].y;
    local_11 = uint(int(10));
    uint _e235 = local_11;
    out_.Store(_e235*4, asuint(_e231));
    int _e240 = flat[int(1)].x;
    local_12 = uint(int(11));
    uint _e244 = local_12;
    out_.Store(_e244*4, asuint(_e240));
    original.x = int(4);
    original.y = int(5);
    original.z = int(6);
    int3_ _e255 = original;
    copies[0] = _e255;
    int3_ _e257 = original;
    copies[1] = _e257;
    copies[2].x = int(7);
    copies[2].y = int(8);
    copies[2].z = ZeroValueint();
    original.x = int(99);
    int _e270 = copies[int(0)].x;
    local_13 = uint(int(12));
    uint _e274 = local_13;
    out_.Store(_e274*4, asuint(_e270));
    int _e279 = copies[int(1)].y;
    local_14 = uint(int(13));
    uint _e283 = local_14;
    out_.Store(_e283*4, asuint(_e279));
    int _e288 = copies[int(2)].z;
    local_15 = uint(int(14));
    uint _e292 = local_15;
    out_.Store(_e292*4, asuint(_e288));
    Number[0] = int(2);
    Number[1] = int(3);
    int _e303 = Number[int(1)];
    next[0] = _e303;
    int _e307 = Number[int(0)];
    next[1] = _e307;
    int _e310 = next[int(0)];
    local_16 = uint(int(15));
    uint _e314 = local_16;
    out_.Store(_e314*4, asuint(_e310));
    Count = int(3);
    scratch = ZeroValuearray3_int_();
    int _e322 = scratch[int(2)];
    local_17 = uint(int(16));
    uint _e326 = local_17;
    out_.Store(_e326*4, asuint(_e322));
    pending[0] = 1.0;
    pending[1] = float(int(2));
    float _e338 = pending[int(0)];
    float _e339 = pending[int(1)];
    local_18 = uint(int(17));
    uint _e345 = local_18;
    out_.Store(_e345*4, asuint(naga_f2i32((_e338 + _e339))));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(int(2));
    pending_vectors[0].z = ZeroValuefloat();
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = ZeroValuefloat();
    pending_vectors[1].z = ZeroValuefloat();
    float _e369 = pending_vectors[int(0)].x;
    float _e370 = pending_vectors[int(0)].y;
    float _e375 = pending_vectors[int(1)].x;
    local_19 = uint(int(18));
    uint _e381 = local_19;
    out_.Store(_e381*4, asuint(naga_f2i32(((_e369 + _e370) + _e375))));
    counter = seed_2;
    int _e386 = counter;
    counter = asint(asuint(_e386) + asuint(int(1)));
    ordered[0] = _e386;
    int _e390 = counter;
    counter = asint(asuint(_e390) + asuint(int(1)));
    ordered[1] = _e390;
    int _e394 = counter;
    ordered[2] = _e394;
    int _e397 = ordered[int(0)];
    int _e402 = ordered[int(1)];
    int _e408 = ordered[int(2)];
    local_20 = uint(int(19));
    uint _e413 = local_20;
    out_.Store(_e413*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e397) * asuint(int(100)))) + asuint(asint(asuint(_e402) * asuint(int(10)))))) + asuint(_e408))));
    int _e415 = counter;
    local_21 = uint(int(20));
    uint _e419 = local_21;
    out_.Store(_e419*4, asuint(_e415));
    int _e423 = counter;
    counter = asint(asuint(_e423) + asuint(int(1)));
    const int _e427 = pair(_e423, int(4));
    called[0] = _e427;
    int _e429 = counter;
    called[1] = _e429;
    int _e434 = called[int(0)];
    int _e435 = called[int(1)];
    local_22 = uint(int(21));
    uint _e440 = local_22;
    out_.Store(_e440*4, asuint(asint(asuint(_e434) + asuint(_e435))));
    int _e442 = counter;
    local_23 = uint(int(22));
    uint _e446 = local_23;
    out_.Store(_e446*4, asuint(_e442));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e482 = iteration;
                iteration = asint(asuint(_e482) + asuint(int(1)));
            }
            loop_init = false;
            int _e452 = iteration;
            if ((_e452 < int(3))) {
            } else {
                break;
            }
            int _e457 = iteration;
            reset[0].x = _e457;
            reset[0].y = ZeroValueint();
            reset[1] = ZeroValueint2();
            int _e469 = reset[int(0)].y;
            int _e470 = reset[int(1)].x;
            int _e472 = zero_total;
            zero_total = asint(asuint(_e472) + asuint(asint(asuint(_e469) + asuint(_e470))));
            reset[int(0)].y = int(9);
            reset[int(1)].x = int(8);
        }
    }
    int _e485 = zero_total;
    local_24 = uint(int(23));
    uint _e489 = local_24;
    out_.Store(_e489*4, asuint(_e485));
    total = int(0);
    {
        iteration_1 = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e504 = iteration_1;
                iteration_1 = asint(asuint(_e504) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e495 = iteration_1;
            if ((_e495 < int(4))) {
            } else {
                break;
            }
            int _e498 = iteration_1;
            if ((_e498 == int(1))) {
                continue;
            }
            int _e501 = iteration_1;
            int _e502 = total;
            total = asint(asuint(_e502) + asuint(_e501));
        }
    }
    int _e507 = total;
    local_25 = uint(int(24));
    uint _e511 = local_25;
    out_.Store(_e511*4, asuint(_e507));
    const int _e514 = sum(int(4));
    local_26 = uint(int(25));
    uint _e518 = local_26;
    out_.Store(_e518*4, asuint(_e514));
    frozen[0] = int(2);
    frozen[1] = int(3);
    int _e529 = frozen[int(0)];
    int _e530 = frozen[int(1)];
    local_27 = uint(int(26));
    uint _e535 = local_27;
    out_.Store(_e535*4, asuint(asint(asuint(_e529) + asuint(_e530))));
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e545 = signed_zeroes[int(0)];
    local_28 = uint(int(27));
    uint _e550 = local_28;
    out_.Store(_e550*4, asuint(asint(_e545)));
    float _e554 = signed_zeroes[int(1)];
    local_29 = uint(int(28));
    uint _e559 = local_29;
    out_.Store(_e559*4, asuint(asint(_e554)));
    const int3_ _e564 = triple(int(6));
    from_calls[0] = _e564;
    const int3_ _e567 = triple(int(9));
    from_calls[1] = _e567;
    int _e574 = from_calls[int(0)].x;
    int _e575 = from_calls[int(1)].z;
    local_30 = uint(int(29));
    uint _e580 = local_30;
    out_.Store(_e580*4, asuint(asint(asuint(_e574) + asuint(_e575))));
}
