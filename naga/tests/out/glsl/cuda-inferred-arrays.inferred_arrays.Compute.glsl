#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

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
layout(std430) buffer type_2_block_0Compute { int _group_0_binding_0_cs[]; };


int pair(int first, int second) {
    return ((first * 10) + second);
}

int sum(int seed) {
    int values_1[2] = int[2](0, 0);
    values_1[0] = seed;
    values_1[1] = (seed + 1);
    int _e10 = values_1[0];
    int _e11 = values_1[1];
    return (_e10 + _e11);
}

int3_ triple(int seed_1) {
    int3_ value = int3_(0, 0, 0);
    value.x = seed_1;
    value.y = (seed_1 + 1);
    value.z = (seed_1 + 2);
    int3_ _e9 = value;
    return _e9;
}

void main() {
    int values[3] = int[3](0, 0, 0);
    int copied[2] = int[2](0, 0);
    int zeroes[2] = int[2](0, 0);
    bool flags[3] = bool[3](false, false, false);
    uint counts[2] = uint[2](0u, 0u);
    float samples[2] = float[2](0.0, 0.0);
    int self[3] = int[3](0, 0, 0);
    int changed[3] = int[3](0, 0, 0);
    int3_ points[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    ivec2 flat_[2] = ivec2[2](ivec2(0), ivec2(0));
    int3_ original = int3_(0, 0, 0);
    int3_ copies[3] = int3_[3](int3_(0, 0, 0), int3_(0, 0, 0), int3_(0, 0, 0));
    int Number[2] = int[2](0, 0);
    int next[2] = int[2](0, 0);
    int Count = 0;
    int scratch[3] = int[3](0, 0, 0);
    float pending[2] = float[2](0.0, 0.0);
    float3_ pending_vectors[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    int counter = 0;
    int ordered[3] = int[3](0, 0, 0);
    int called[2] = int[2](0, 0);
    int zero_total = 0;
    int iteration = 0;
    ivec2 reset[2] = ivec2[2](ivec2(0), ivec2(0));
    int total = 0;
    int iteration_1 = 0;
    int frozen[2] = int[2](0, 0);
    float signed_zeroes[2] = float[2](0.0, 0.0);
    int3_ from_calls[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    int seed_2 = _group_0_binding_0_cs[uint(0)];
    values[0] = seed_2;
    values[1] = (seed_2 + 1);
    values[2] = (seed_2 + 2);
    copied[0] = 4;
    copied[1] = 5;
    zeroes[0] = 0;
    zeroes[1] = 0;
    flags[0] = true;
    flags[1] = false;
    flags[2] = true;
    counts[0] = 3u;
    counts[1] = 5u;
    samples[0] = 1.5;
    samples[1] = 2.5;
    int _e44 = values[0];
    int _e45 = values[1];
    int _e49 = values[2];
    _group_0_binding_0_cs[uint(0)] = ((_e44 + _e45) + _e49);
    int _e56 = copied[0];
    _group_0_binding_0_cs[uint(1)] = _e56;
    int _e64 = zeroes[0];
    int _e65 = zeroes[1];
    _group_0_binding_0_cs[uint(2)] = (_e64 + _e65);
    bool _e72 = flags[0];
    bool _e76 = flags[1];
    bool _e81 = flags[2];
    _group_0_binding_0_cs[uint(3)] = ((int(_e72) + int(_e76)) + int(_e81));
    uint _e91 = counts[0];
    uint _e92 = counts[1];
    _group_0_binding_0_cs[uint(4)] = int((_e91 + _e92));
    float _e102 = samples[0];
    float _e103 = samples[1];
    _group_0_binding_0_cs[uint(5)] = int((_e102 + _e103));
    self[0] = 1;
    int _e115 = self[0];
    self[1] = (_e115 + 1);
    int _e121 = self[1];
    self[2] = (_e121 + 1);
    int _e126 = self[0];
    int _e131 = self[1];
    int _e137 = self[2];
    _group_0_binding_0_cs[uint(6)] = (((_e126 * 100) + (_e131 * 10)) + _e137);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e153 = changed[0];
    changed[2] = _e153;
    int _e156 = changed[0];
    _group_0_binding_0_cs[uint(7)] = _e156;
    int _e162 = changed[2];
    _group_0_binding_0_cs[uint(8)] = _e162;
    points[0].x = 1;
    int _e173 = points[0].x;
    points[0].y = (_e173 + 1);
    int _e180 = points[0].y;
    points[0].z = (_e180 + 1);
    int3_ _e187 = points[0];
    points[1] = _e187;
    int _e191 = points[1].z;
    _group_0_binding_0_cs[uint(9)] = _e191;
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e209 = flat_[1].y;
    _group_0_binding_0_cs[uint(10)] = _e209;
    int _e216 = flat_[1].x;
    _group_0_binding_0_cs[uint(11)] = _e216;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e229 = original;
    copies[0] = _e229;
    int3_ _e231 = original;
    copies[1] = _e231;
    copies[2].x = 7;
    copies[2].y = 8;
    copies[2].z = 0;
    original.x = 99;
    int _e244 = copies[0].x;
    _group_0_binding_0_cs[uint(12)] = _e244;
    int _e251 = copies[1].y;
    _group_0_binding_0_cs[uint(13)] = _e251;
    int _e258 = copies[2].z;
    _group_0_binding_0_cs[uint(14)] = _e258;
    Number[0] = 2;
    Number[1] = 3;
    int _e271 = Number[1];
    next[0] = _e271;
    int _e275 = Number[0];
    next[1] = _e275;
    int _e278 = next[0];
    _group_0_binding_0_cs[uint(15)] = _e278;
    Count = 3;
    scratch = int[3](0, 0, 0);
    int _e288 = scratch[2];
    _group_0_binding_0_cs[uint(16)] = _e288;
    pending[0] = 1.0;
    pending[1] = float(2);
    float _e302 = pending[0];
    float _e303 = pending[1];
    _group_0_binding_0_cs[uint(17)] = int((_e302 + _e303));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(2);
    pending_vectors[0].z = 0.0;
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = 0.0;
    pending_vectors[1].z = 0.0;
    float _e331 = pending_vectors[0].x;
    float _e332 = pending_vectors[0].y;
    float _e337 = pending_vectors[1].x;
    _group_0_binding_0_cs[uint(18)] = int(((_e331 + _e332) + _e337));
    counter = seed_2;
    int _e346 = counter;
    counter = (_e346 + 1);
    ordered[0] = _e346;
    int _e350 = counter;
    counter = (_e350 + 1);
    ordered[1] = _e350;
    int _e354 = counter;
    ordered[2] = _e354;
    int _e357 = ordered[0];
    int _e362 = ordered[1];
    int _e368 = ordered[2];
    _group_0_binding_0_cs[uint(19)] = (((_e357 * 100) + (_e362 * 10)) + _e368);
    int _e373 = counter;
    _group_0_binding_0_cs[uint(20)] = _e373;
    int _e379 = counter;
    counter = (_e379 + 1);
    int _e383 = pair(_e379, 4);
    called[0] = _e383;
    int _e385 = counter;
    called[1] = _e385;
    int _e390 = called[0];
    int _e391 = called[1];
    _group_0_binding_0_cs[uint(21)] = (_e390 + _e391);
    int _e396 = counter;
    _group_0_binding_0_cs[uint(22)] = _e396;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e434 = iteration;
                iteration = (_e434 + 1);
            }
            loop_init = false;
            int _e404 = iteration;
            if ((_e404 < 3)) {
            } else {
                break;
            }
            int _e409 = iteration;
            reset[0].x = _e409;
            reset[0].y = 0;
            reset[1] = ivec2(0);
            int _e421 = reset[0].y;
            int _e422 = reset[1].x;
            int _e424 = zero_total;
            zero_total = (_e424 + (_e421 + _e422));
            reset[0].y = 9;
            reset[1].x = 8;
        }
    }
    int _e437 = zero_total;
    _group_0_binding_0_cs[uint(23)] = _e437;
    total = 0;
    {
        iteration_1 = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e454 = iteration_1;
                iteration_1 = (_e454 + 1);
            }
            loop_init_1 = false;
            int _e445 = iteration_1;
            if ((_e445 < 4)) {
            } else {
                break;
            }
            int _e448 = iteration_1;
            if ((_e448 == 1)) {
                continue;
            }
            int _e451 = iteration_1;
            int _e452 = total;
            total = (_e452 + _e451);
        }
    }
    int _e457 = total;
    _group_0_binding_0_cs[uint(24)] = _e457;
    int _e462 = sum(4);
    _group_0_binding_0_cs[uint(25)] = _e462;
    frozen[0] = 2;
    frozen[1] = 3;
    int _e475 = frozen[0];
    int _e476 = frozen[1];
    _group_0_binding_0_cs[uint(26)] = (_e475 + _e476);
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e489 = signed_zeroes[0];
    _group_0_binding_0_cs[uint(27)] = floatBitsToInt(_e489);
    float _e496 = signed_zeroes[1];
    _group_0_binding_0_cs[uint(28)] = floatBitsToInt(_e496);
    int3_ _e504 = triple(6);
    from_calls[0] = _e504;
    int3_ _e507 = triple(9);
    from_calls[1] = _e507;
    int _e514 = from_calls[0].x;
    int _e515 = from_calls[1].z;
    _group_0_binding_0_cs[uint(29)] = (_e514 + _e515);
}

