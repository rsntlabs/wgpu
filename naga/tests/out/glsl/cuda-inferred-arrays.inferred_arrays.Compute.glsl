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
    uint local = 0u;
    int values[3] = int[3](0, 0, 0);
    int copied[2] = int[2](0, 0);
    int zeroes[2] = int[2](0, 0);
    bool flags[3] = bool[3](false, false, false);
    uint counts[2] = uint[2](0u, 0u);
    float samples[2] = float[2](0.0, 0.0);
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    int self[3] = int[3](0, 0, 0);
    uint local_7 = 0u;
    int changed[3] = int[3](0, 0, 0);
    uint local_8 = 0u;
    uint local_9 = 0u;
    int3_ points[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    uint local_10 = 0u;
    ivec2 flat_[2] = ivec2[2](ivec2(0), ivec2(0));
    uint local_11 = 0u;
    uint local_12 = 0u;
    int3_ original = int3_(0, 0, 0);
    int3_ copies[3] = int3_[3](int3_(0, 0, 0), int3_(0, 0, 0), int3_(0, 0, 0));
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    int Number[2] = int[2](0, 0);
    int next[2] = int[2](0, 0);
    uint local_16 = 0u;
    int Count = 0;
    int scratch[3] = int[3](0, 0, 0);
    uint local_17 = 0u;
    float pending[2] = float[2](0.0, 0.0);
    uint local_18 = 0u;
    float3_ pending_vectors[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    uint local_19 = 0u;
    int counter = 0;
    int ordered[3] = int[3](0, 0, 0);
    uint local_20 = 0u;
    uint local_21 = 0u;
    int called[2] = int[2](0, 0);
    uint local_22 = 0u;
    uint local_23 = 0u;
    int zero_total = 0;
    int iteration = 0;
    ivec2 reset[2] = ivec2[2](ivec2(0), ivec2(0));
    uint local_24 = 0u;
    int total = 0;
    int iteration_1 = 0;
    uint local_25 = 0u;
    uint local_26 = 0u;
    int frozen[2] = int[2](0, 0);
    uint local_27 = 0u;
    float signed_zeroes[2] = float[2](0.0, 0.0);
    uint local_28 = 0u;
    uint local_29 = 0u;
    int3_ from_calls[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    uint local_30 = 0u;
    local = uint(0);
    uint _e3 = local;
    int seed_2 = _group_0_binding_0_cs[_e3];
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
    int _e46 = values[0];
    int _e47 = values[1];
    int _e51 = values[2];
    local_1 = uint(0);
    uint _e56 = local_1;
    _group_0_binding_0_cs[_e56] = ((_e46 + _e47) + _e51);
    int _e60 = copied[0];
    local_2 = uint(1);
    uint _e64 = local_2;
    _group_0_binding_0_cs[_e64] = _e60;
    int _e70 = zeroes[0];
    int _e71 = zeroes[1];
    local_3 = uint(2);
    uint _e76 = local_3;
    _group_0_binding_0_cs[_e76] = (_e70 + _e71);
    bool _e80 = flags[0];
    bool _e84 = flags[1];
    bool _e89 = flags[2];
    local_4 = uint(3);
    uint _e95 = local_4;
    _group_0_binding_0_cs[_e95] = ((int(_e80) + int(_e84)) + int(_e89));
    uint _e101 = counts[0];
    uint _e102 = counts[1];
    local_5 = uint(4);
    uint _e108 = local_5;
    _group_0_binding_0_cs[_e108] = int((_e101 + _e102));
    float _e114 = samples[0];
    float _e115 = samples[1];
    local_6 = uint(5);
    uint _e121 = local_6;
    _group_0_binding_0_cs[_e121] = int((_e114 + _e115));
    self[0] = 1;
    int _e129 = self[0];
    self[1] = (_e129 + 1);
    int _e135 = self[1];
    self[2] = (_e135 + 1);
    int _e140 = self[0];
    int _e145 = self[1];
    int _e151 = self[2];
    local_7 = uint(6);
    uint _e156 = local_7;
    _group_0_binding_0_cs[_e156] = (((_e140 * 100) + (_e145 * 10)) + _e151);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e169 = changed[0];
    changed[2] = _e169;
    int _e172 = changed[0];
    local_8 = uint(7);
    uint _e176 = local_8;
    _group_0_binding_0_cs[_e176] = _e172;
    int _e180 = changed[2];
    local_9 = uint(8);
    uint _e184 = local_9;
    _group_0_binding_0_cs[_e184] = _e180;
    points[0].x = 1;
    int _e193 = points[0].x;
    points[0].y = (_e193 + 1);
    int _e200 = points[0].y;
    points[0].z = (_e200 + 1);
    int3_ _e207 = points[0];
    points[1] = _e207;
    int _e211 = points[1].z;
    local_10 = uint(9);
    uint _e215 = local_10;
    _group_0_binding_0_cs[_e215] = _e211;
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e231 = flat_[1].y;
    local_11 = uint(10);
    uint _e235 = local_11;
    _group_0_binding_0_cs[_e235] = _e231;
    int _e240 = flat_[1].x;
    local_12 = uint(11);
    uint _e244 = local_12;
    _group_0_binding_0_cs[_e244] = _e240;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e255 = original;
    copies[0] = _e255;
    int3_ _e257 = original;
    copies[1] = _e257;
    copies[2].x = 7;
    copies[2].y = 8;
    copies[2].z = 0;
    original.x = 99;
    int _e270 = copies[0].x;
    local_13 = uint(12);
    uint _e274 = local_13;
    _group_0_binding_0_cs[_e274] = _e270;
    int _e279 = copies[1].y;
    local_14 = uint(13);
    uint _e283 = local_14;
    _group_0_binding_0_cs[_e283] = _e279;
    int _e288 = copies[2].z;
    local_15 = uint(14);
    uint _e292 = local_15;
    _group_0_binding_0_cs[_e292] = _e288;
    Number[0] = 2;
    Number[1] = 3;
    int _e303 = Number[1];
    next[0] = _e303;
    int _e307 = Number[0];
    next[1] = _e307;
    int _e310 = next[0];
    local_16 = uint(15);
    uint _e314 = local_16;
    _group_0_binding_0_cs[_e314] = _e310;
    Count = 3;
    scratch = int[3](0, 0, 0);
    int _e322 = scratch[2];
    local_17 = uint(16);
    uint _e326 = local_17;
    _group_0_binding_0_cs[_e326] = _e322;
    pending[0] = 1.0;
    pending[1] = float(2);
    float _e338 = pending[0];
    float _e339 = pending[1];
    local_18 = uint(17);
    uint _e345 = local_18;
    _group_0_binding_0_cs[_e345] = int((_e338 + _e339));
    pending_vectors[0].x = 1.0;
    pending_vectors[0].y = float(2);
    pending_vectors[0].z = 0.0;
    pending_vectors[1].x = 3.0;
    pending_vectors[1].y = 0.0;
    pending_vectors[1].z = 0.0;
    float _e369 = pending_vectors[0].x;
    float _e370 = pending_vectors[0].y;
    float _e375 = pending_vectors[1].x;
    local_19 = uint(18);
    uint _e381 = local_19;
    _group_0_binding_0_cs[_e381] = int(((_e369 + _e370) + _e375));
    counter = seed_2;
    int _e386 = counter;
    counter = (_e386 + 1);
    ordered[0] = _e386;
    int _e390 = counter;
    counter = (_e390 + 1);
    ordered[1] = _e390;
    int _e394 = counter;
    ordered[2] = _e394;
    int _e397 = ordered[0];
    int _e402 = ordered[1];
    int _e408 = ordered[2];
    local_20 = uint(19);
    uint _e413 = local_20;
    _group_0_binding_0_cs[_e413] = (((_e397 * 100) + (_e402 * 10)) + _e408);
    int _e415 = counter;
    local_21 = uint(20);
    uint _e419 = local_21;
    _group_0_binding_0_cs[_e419] = _e415;
    int _e423 = counter;
    counter = (_e423 + 1);
    int _e427 = pair(_e423, 4);
    called[0] = _e427;
    int _e429 = counter;
    called[1] = _e429;
    int _e434 = called[0];
    int _e435 = called[1];
    local_22 = uint(21);
    uint _e440 = local_22;
    _group_0_binding_0_cs[_e440] = (_e434 + _e435);
    int _e442 = counter;
    local_23 = uint(22);
    uint _e446 = local_23;
    _group_0_binding_0_cs[_e446] = _e442;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e482 = iteration;
                iteration = (_e482 + 1);
            }
            loop_init = false;
            int _e452 = iteration;
            if ((_e452 < 3)) {
            } else {
                break;
            }
            int _e457 = iteration;
            reset[0].x = _e457;
            reset[0].y = 0;
            reset[1] = ivec2(0);
            int _e469 = reset[0].y;
            int _e470 = reset[1].x;
            int _e472 = zero_total;
            zero_total = (_e472 + (_e469 + _e470));
            reset[0].y = 9;
            reset[1].x = 8;
        }
    }
    int _e485 = zero_total;
    local_24 = uint(23);
    uint _e489 = local_24;
    _group_0_binding_0_cs[_e489] = _e485;
    total = 0;
    {
        iteration_1 = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e504 = iteration_1;
                iteration_1 = (_e504 + 1);
            }
            loop_init_1 = false;
            int _e495 = iteration_1;
            if ((_e495 < 4)) {
            } else {
                break;
            }
            int _e498 = iteration_1;
            if ((_e498 == 1)) {
                continue;
            }
            int _e501 = iteration_1;
            int _e502 = total;
            total = (_e502 + _e501);
        }
    }
    int _e507 = total;
    local_25 = uint(24);
    uint _e511 = local_25;
    _group_0_binding_0_cs[_e511] = _e507;
    int _e514 = sum(4);
    local_26 = uint(25);
    uint _e518 = local_26;
    _group_0_binding_0_cs[_e518] = _e514;
    frozen[0] = 2;
    frozen[1] = 3;
    int _e529 = frozen[0];
    int _e530 = frozen[1];
    local_27 = uint(26);
    uint _e535 = local_27;
    _group_0_binding_0_cs[_e535] = (_e529 + _e530);
    signed_zeroes[0] = -(0.0);
    signed_zeroes[1] = 0.0;
    float _e545 = signed_zeroes[0];
    local_28 = uint(27);
    uint _e550 = local_28;
    _group_0_binding_0_cs[_e550] = floatBitsToInt(_e545);
    float _e554 = signed_zeroes[1];
    local_29 = uint(28);
    uint _e559 = local_29;
    _group_0_binding_0_cs[_e559] = floatBitsToInt(_e554);
    int3_ _e564 = triple(6);
    from_calls[0] = _e564;
    int3_ _e567 = triple(9);
    from_calls[1] = _e567;
    int _e574 = from_calls[0].x;
    int _e575 = from_calls[1].z;
    local_30 = uint(29);
    uint _e580 = local_30;
    _group_0_binding_0_cs[_e580] = (_e574 + _e575);
}

