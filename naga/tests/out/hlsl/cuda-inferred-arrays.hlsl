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
    int values[3] = (int[3])0;
    int copied[2] = (int[2])0;
    int zeroes[2] = (int[2])0;
    bool flags[3] = (bool[3])0;
    uint counts[2] = (uint[2])0;
    float samples[2] = (float[2])0;
    int self[3] = (int[3])0;
    int changed[3] = (int[3])0;
    int3_ points[2] = (int3_[2])0;
    int2 flat[2] = (int2[2])0;
    int3_ original = (int3_)0;
    int3_ copies[3] = (int3_[3])0;
    int Number[2] = (int[2])0;
    int next[2] = (int[2])0;
    int Count = (int)0;
    int scratch[3] = (int[3])0;
    float pending[2] = (float[2])0;
    float3_ pending_vectors[2] = (float3_[2])0;
    int counter = (int)0;
    int ordered[3] = (int[3])0;
    int called[2] = (int[2])0;
    int zero_total = (int)0;
    int iteration = (int)0;
    int2 reset[2] = (int2[2])0;
    int total = (int)0;
    int iteration_1 = (int)0;
    int frozen[2] = (int[2])0;
    float signed_zeroes[2] = (float[2])0;
    int3_ from_calls[2] = (int3_[2])0;

    int seed_2 = asint(out_.Load(uint(int(0))*4));
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
    int _e44 = values[int(0)];
    int _e45 = values[int(1)];
    int _e49 = values[int(2)];
    out_.Store(uint(int(0))*4, asuint(asint(asuint(asint(asuint(_e44) + asuint(_e45))) + asuint(_e49))));
    int _e56 = copied[int(0)];
    out_.Store(uint(int(1))*4, asuint(_e56));
    int _e64 = zeroes[int(0)];
    int _e65 = zeroes[int(1)];
    out_.Store(uint(int(2))*4, asuint(asint(asuint(_e64) + asuint(_e65))));
    bool _e72 = flags[int(0)];
    bool _e76 = flags[int(1)];
    bool _e81 = flags[int(2)];
    out_.Store(uint(int(3))*4, asuint(asint(asuint(asint(asuint(int(_e72)) + asuint(int(_e76)))) + asuint(int(_e81)))));
    uint _e91 = counts[int(0)];
    uint _e92 = counts[int(1)];
    out_.Store(uint(int(4))*4, asuint(int((_e91 + _e92))));
    float _e102 = samples[int(0)];
    float _e103 = samples[int(1)];
    out_.Store(uint(int(5))*4, asuint(naga_f2i32((_e102 + _e103))));
    self[0] = int(1);
    int _e115 = self[int(0)];
    self[1] = asint(asuint(_e115) + asuint(int(1)));
    int _e121 = self[int(1)];
    self[2] = asint(asuint(_e121) + asuint(int(1)));
    int _e126 = self[int(0)];
    int _e131 = self[int(1)];
    int _e137 = self[int(2)];
    out_.Store(uint(int(6))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e126) * asuint(int(100)))) + asuint(asint(asuint(_e131) * asuint(int(10)))))) + asuint(_e137))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e153 = changed[int(0)];
    changed[2] = _e153;
    int _e156 = changed[int(0)];
    out_.Store(uint(int(7))*4, asuint(_e156));
    int _e162 = changed[int(2)];
    out_.Store(uint(int(8))*4, asuint(_e162));
    points[0].x = int(1);
    int _e173 = points[int(0)].x;
    points[0].y = asint(asuint(_e173) + asuint(int(1)));
    int _e180 = points[int(0)].y;
    points[0].z = asint(asuint(_e180) + asuint(int(1)));
    int3_ _e187 = points[int(0)];
    points[1] = _e187;
    int _e191 = points[int(1)].z;
    out_.Store(uint(int(9))*4, asuint(_e191));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e209 = flat[int(1)].y;
    out_.Store(uint(int(10))*4, asuint(_e209));
    int _e216 = flat[int(1)].x;
    out_.Store(uint(int(11))*4, asuint(_e216));
    original.x = int(4);
    original.y = int(5);
    original.z = int(6);
    int3_ _e229 = original;
    copies[0] = _e229;
    int3_ _e231 = original;
    copies[1] = _e231;
    copies[2].x = int(7);
    copies[2].y = int(8);
    copies[2].z = ZeroValueint();
    original.x = int(99);
    int _e244 = copies[int(0)].x;
    out_.Store(uint(int(12))*4, asuint(_e244));
    int _e251 = copies[int(1)].y;
    out_.Store(uint(int(13))*4, asuint(_e251));
    int _e258 = copies[int(2)].z;
    out_.Store(uint(int(14))*4, asuint(_e258));
    Number[0] = int(2);
    Number[1] = int(3);
    int _e271 = Number[int(1)];
    next[0] = _e271;
    int _e275 = Number[int(0)];
    next[1] = _e275;
    int _e278 = next[int(0)];
    out_.Store(uint(int(15))*4, asuint(_e278));
    Count = int(3);
    scratch = ZeroValuearray3_int_();
    int _e288 = scratch[int(2)];
    out_.Store(uint(int(16))*4, asuint(_e288));
    pending[0] = 1.0;
    pending[1] = float(int(2));
    float _e302 = pending[int(0)];
    float _e303 = pending[int(1)];
    out_.Store(uint(int(17))*4, asuint(naga_f2i32((_e302 + _e303))));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(int(2));
    pending_vectors[0].z = ZeroValuefloat();
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = ZeroValuefloat();
    pending_vectors[1].z = ZeroValuefloat();
    float _e331 = pending_vectors[int(0)].x;
    float _e332 = pending_vectors[int(0)].y;
    float _e337 = pending_vectors[int(1)].x;
    out_.Store(uint(int(18))*4, asuint(naga_f2i32(((_e331 + _e332) + _e337))));
    counter = seed_2;
    int _e346 = counter;
    counter = asint(asuint(_e346) + asuint(int(1)));
    ordered[0] = _e346;
    int _e350 = counter;
    counter = asint(asuint(_e350) + asuint(int(1)));
    ordered[1] = _e350;
    int _e354 = counter;
    ordered[2] = _e354;
    int _e357 = ordered[int(0)];
    int _e362 = ordered[int(1)];
    int _e368 = ordered[int(2)];
    out_.Store(uint(int(19))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e357) * asuint(int(100)))) + asuint(asint(asuint(_e362) * asuint(int(10)))))) + asuint(_e368))));
    int _e373 = counter;
    out_.Store(uint(int(20))*4, asuint(_e373));
    int _e379 = counter;
    counter = asint(asuint(_e379) + asuint(int(1)));
    const int _e383 = pair(_e379, int(4));
    called[0] = _e383;
    int _e385 = counter;
    called[1] = _e385;
    int _e390 = called[int(0)];
    int _e391 = called[int(1)];
    out_.Store(uint(int(21))*4, asuint(asint(asuint(_e390) + asuint(_e391))));
    int _e396 = counter;
    out_.Store(uint(int(22))*4, asuint(_e396));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e434 = iteration;
                iteration = asint(asuint(_e434) + asuint(int(1)));
            }
            loop_init = false;
            int _e404 = iteration;
            if ((_e404 < int(3))) {
            } else {
                break;
            }
            int _e409 = iteration;
            reset[0].x = _e409;
            reset[0].y = ZeroValueint();
            reset[1] = ZeroValueint2();
            int _e421 = reset[int(0)].y;
            int _e422 = reset[int(1)].x;
            int _e424 = zero_total;
            zero_total = asint(asuint(_e424) + asuint(asint(asuint(_e421) + asuint(_e422))));
            reset[int(0)].y = int(9);
            reset[int(1)].x = int(8);
        }
    }
    int _e437 = zero_total;
    out_.Store(uint(int(23))*4, asuint(_e437));
    total = int(0);
    {
        iteration_1 = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e454 = iteration_1;
                iteration_1 = asint(asuint(_e454) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e445 = iteration_1;
            if ((_e445 < int(4))) {
            } else {
                break;
            }
            int _e448 = iteration_1;
            if ((_e448 == int(1))) {
                continue;
            }
            int _e451 = iteration_1;
            int _e452 = total;
            total = asint(asuint(_e452) + asuint(_e451));
        }
    }
    int _e457 = total;
    out_.Store(uint(int(24))*4, asuint(_e457));
    const int _e462 = sum(int(4));
    out_.Store(uint(int(25))*4, asuint(_e462));
    frozen[0] = int(2);
    frozen[1] = int(3);
    int _e475 = frozen[int(0)];
    int _e476 = frozen[int(1)];
    out_.Store(uint(int(26))*4, asuint(asint(asuint(_e475) + asuint(_e476))));
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e489 = signed_zeroes[int(0)];
    out_.Store(uint(int(27))*4, asuint(asint(_e489)));
    float _e496 = signed_zeroes[int(1)];
    out_.Store(uint(int(28))*4, asuint(asint(_e496)));
    const int3_ _e504 = triple(int(6));
    from_calls[0] = _e504;
    const int3_ _e507 = triple(int(9));
    from_calls[1] = _e507;
    int _e514 = from_calls[int(0)].x;
    int _e515 = from_calls[int(1)].z;
    out_.Store(uint(int(29))*4, asuint(asint(asuint(_e514) + asuint(_e515))));
}
