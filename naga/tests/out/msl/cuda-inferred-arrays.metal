// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[2];
};
struct int3_ {
    int x;
    int y;
    int z;
};
typedef int type_2[1];
struct type_4 {
    int inner[3];
};
struct type_6 {
    bool inner[3];
};
struct type_7 {
    uint inner[2];
};
struct type_9 {
    float inner[2];
};
struct type_10 {
    int3_ inner[2];
};
struct type_12 {
    metal::int2 inner[2];
};
struct type_13 {
    int3_ inner[3];
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_14 {
    float3_ inner[2];
};

int pair(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first) * as_type<uint>(10))) + as_type<uint>(second));
}

int sum(
    int seed
) {
    type_1 values_1 = {};
    values_1.inner[0] = seed;
    values_1.inner[1] = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    int _e10 = values_1.inner[0];
    int _e11 = values_1.inner[1];
    return as_type<int>(as_type<uint>(_e10) + as_type<uint>(_e11));
}

int3_ triple(
    int seed_1
) {
    int3_ value = {};
    value.x = seed_1;
    value.y = as_type<int>(as_type<uint>(seed_1) + as_type<uint>(1));
    value.z = as_type<int>(as_type<uint>(seed_1) + as_type<uint>(2));
    int3_ _e9 = value;
    return _e9;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void inferred_arrays(
  device type_2& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    type_4 values = {};
    type_1 copied = {};
    type_1 zeroes = {};
    type_6 flags = {};
    type_7 counts = {};
    type_9 samples = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    type_4 self = {};
    uint local_7 = {};
    type_4 changed = {};
    uint local_8 = {};
    uint local_9 = {};
    type_10 points = {};
    uint local_10 = {};
    type_12 flat = {};
    uint local_11 = {};
    uint local_12 = {};
    int3_ original = {};
    type_13 copies = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    type_1 Number = {};
    type_1 next = {};
    uint local_16 = {};
    int Count = {};
    type_4 scratch = {};
    uint local_17 = {};
    type_9 pending = {};
    uint local_18 = {};
    type_14 pending_vectors = {};
    uint local_19 = {};
    int counter = {};
    type_4 ordered = {};
    uint local_20 = {};
    uint local_21 = {};
    type_1 called = {};
    uint local_22 = {};
    uint local_23 = {};
    int zero_total = {};
    int iteration = {};
    type_12 reset = {};
    uint local_24 = {};
    int total = {};
    int iteration_1 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_1 frozen = {};
    uint local_27 = {};
    type_9 signed_zeroes = {};
    uint local_28 = {};
    uint local_29 = {};
    type_10 from_calls = {};
    uint local_30 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    int seed_2 = out[_e3];
    values.inner[0] = seed_2;
    values.inner[1] = as_type<int>(as_type<uint>(seed_2) + as_type<uint>(1));
    values.inner[2] = as_type<int>(as_type<uint>(seed_2) + as_type<uint>(2));
    copied.inner[0] = 4;
    copied.inner[1] = 5;
    zeroes.inner[0] = 0;
    zeroes.inner[1] = 0;
    flags.inner[0] = true;
    flags.inner[1] = false;
    flags.inner[2] = true;
    counts.inner[0] = 3u;
    counts.inner[1] = 5u;
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.5;
    int _e46 = values.inner[0];
    int _e47 = values.inner[1];
    int _e51 = values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e56 = local_1;
    out[_e56] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e46) + as_type<uint>(_e47))) + as_type<uint>(_e51));
    int _e60 = copied.inner[0];
    local_2 = static_cast<uint>(1);
    uint _e64 = local_2;
    out[_e64] = _e60;
    int _e70 = zeroes.inner[0];
    int _e71 = zeroes.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e76 = local_3;
    out[_e76] = as_type<int>(as_type<uint>(_e70) + as_type<uint>(_e71));
    bool _e80 = flags.inner[0];
    bool _e84 = flags.inner[1];
    bool _e89 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e95 = local_4;
    out[_e95] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e80)) + as_type<uint>(static_cast<int>(_e84)))) + as_type<uint>(static_cast<int>(_e89)));
    uint _e101 = counts.inner[0];
    uint _e102 = counts.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e108 = local_5;
    out[_e108] = static_cast<int>(_e101 + _e102);
    float _e114 = samples.inner[0];
    float _e115 = samples.inner[1];
    local_6 = static_cast<uint>(5);
    uint _e121 = local_6;
    out[_e121] = naga_f2i32(_e114 + _e115);
    self.inner[0] = 1;
    int _e129 = self.inner[0];
    self.inner[1] = as_type<int>(as_type<uint>(_e129) + as_type<uint>(1));
    int _e135 = self.inner[1];
    self.inner[2] = as_type<int>(as_type<uint>(_e135) + as_type<uint>(1));
    int _e140 = self.inner[0];
    int _e145 = self.inner[1];
    int _e151 = self.inner[2];
    local_7 = static_cast<uint>(6);
    uint _e156 = local_7;
    out[_e156] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e140) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e145) * as_type<uint>(10))))) + as_type<uint>(_e151));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e169 = changed.inner[0];
    changed.inner[2] = _e169;
    int _e172 = changed.inner[0];
    local_8 = static_cast<uint>(7);
    uint _e176 = local_8;
    out[_e176] = _e172;
    int _e180 = changed.inner[2];
    local_9 = static_cast<uint>(8);
    uint _e184 = local_9;
    out[_e184] = _e180;
    points.inner[0].x = 1;
    int _e193 = points.inner[0].x;
    points.inner[0].y = as_type<int>(as_type<uint>(_e193) + as_type<uint>(1));
    int _e200 = points.inner[0].y;
    points.inner[0].z = as_type<int>(as_type<uint>(_e200) + as_type<uint>(1));
    int3_ _e207 = points.inner[0];
    points.inner[1] = _e207;
    int _e211 = points.inner[1].z;
    local_10 = static_cast<uint>(9);
    uint _e215 = local_10;
    out[_e215] = _e211;
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e231 = flat.inner[1].y;
    local_11 = static_cast<uint>(10);
    uint _e235 = local_11;
    out[_e235] = _e231;
    int _e240 = flat.inner[1].x;
    local_12 = static_cast<uint>(11);
    uint _e244 = local_12;
    out[_e244] = _e240;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e255 = original;
    copies.inner[0] = _e255;
    int3_ _e257 = original;
    copies.inner[1] = _e257;
    copies.inner[2].x = 7;
    copies.inner[2].y = 8;
    copies.inner[2].z = int {};
    original.x = 99;
    int _e270 = copies.inner[0].x;
    local_13 = static_cast<uint>(12);
    uint _e274 = local_13;
    out[_e274] = _e270;
    int _e279 = copies.inner[1].y;
    local_14 = static_cast<uint>(13);
    uint _e283 = local_14;
    out[_e283] = _e279;
    int _e288 = copies.inner[2].z;
    local_15 = static_cast<uint>(14);
    uint _e292 = local_15;
    out[_e292] = _e288;
    Number.inner[0] = 2;
    Number.inner[1] = 3;
    int _e303 = Number.inner[1];
    next.inner[0] = _e303;
    int _e307 = Number.inner[0];
    next.inner[1] = _e307;
    int _e310 = next.inner[0];
    local_16 = static_cast<uint>(15);
    uint _e314 = local_16;
    out[_e314] = _e310;
    Count = 3;
    scratch = type_4 {};
    int _e322 = scratch.inner[2];
    local_17 = static_cast<uint>(16);
    uint _e326 = local_17;
    out[_e326] = _e322;
    pending.inner[0] = 1.0;
    pending.inner[1] = static_cast<float>(2);
    float _e338 = pending.inner[0];
    float _e339 = pending.inner[1];
    local_18 = static_cast<uint>(17);
    uint _e345 = local_18;
    out[_e345] = naga_f2i32(_e338 + _e339);
    pending_vectors.inner[0].x = 1.0;
    pending_vectors.inner[0].y = static_cast<float>(2);
    pending_vectors.inner[0].z = float {};
    pending_vectors.inner[1].x = 3.0;
    pending_vectors.inner[1].y = float {};
    pending_vectors.inner[1].z = float {};
    float _e369 = pending_vectors.inner[0].x;
    float _e370 = pending_vectors.inner[0].y;
    float _e375 = pending_vectors.inner[1].x;
    local_19 = static_cast<uint>(18);
    uint _e381 = local_19;
    out[_e381] = naga_f2i32((_e369 + _e370) + _e375);
    counter = seed_2;
    int _e386 = counter;
    counter = as_type<int>(as_type<uint>(_e386) + as_type<uint>(1));
    ordered.inner[0] = _e386;
    int _e390 = counter;
    counter = as_type<int>(as_type<uint>(_e390) + as_type<uint>(1));
    ordered.inner[1] = _e390;
    int _e394 = counter;
    ordered.inner[2] = _e394;
    int _e397 = ordered.inner[0];
    int _e402 = ordered.inner[1];
    int _e408 = ordered.inner[2];
    local_20 = static_cast<uint>(19);
    uint _e413 = local_20;
    out[_e413] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e397) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e402) * as_type<uint>(10))))) + as_type<uint>(_e408));
    int _e415 = counter;
    local_21 = static_cast<uint>(20);
    uint _e419 = local_21;
    out[_e419] = _e415;
    int _e423 = counter;
    counter = as_type<int>(as_type<uint>(_e423) + as_type<uint>(1));
    int _e427 = pair(_e423, 4);
    called.inner[0] = _e427;
    int _e429 = counter;
    called.inner[1] = _e429;
    int _e434 = called.inner[0];
    int _e435 = called.inner[1];
    local_22 = static_cast<uint>(21);
    uint _e440 = local_22;
    out[_e440] = as_type<int>(as_type<uint>(_e434) + as_type<uint>(_e435));
    int _e442 = counter;
    local_23 = static_cast<uint>(22);
    uint _e446 = local_23;
    out[_e446] = _e442;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e482 = iteration;
                iteration = as_type<int>(as_type<uint>(_e482) + as_type<uint>(1));
            }
            loop_init = false;
            int _e452 = iteration;
            if (_e452 < 3) {
            } else {
                break;
            }
            int _e457 = iteration;
            reset.inner[0].x = _e457;
            reset.inner[0].y = int {};
            reset.inner[1] = metal::int2 {};
            int _e469 = reset.inner[0].y;
            int _e470 = reset.inner[1].x;
            int _e472 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e472) + as_type<uint>(as_type<int>(as_type<uint>(_e469) + as_type<uint>(_e470))));
            reset.inner[0].y = 9;
            reset.inner[1].x = 8;
        }
    }
    int _e485 = zero_total;
    local_24 = static_cast<uint>(23);
    uint _e489 = local_24;
    out[_e489] = _e485;
    total = 0;
    {
        iteration_1 = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e504 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e504) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e495 = iteration_1;
            if (_e495 < 4) {
            } else {
                break;
            }
            int _e498 = iteration_1;
            if (_e498 == 1) {
                continue;
            }
            int _e501 = iteration_1;
            int _e502 = total;
            total = as_type<int>(as_type<uint>(_e502) + as_type<uint>(_e501));
        }
    }
    int _e507 = total;
    local_25 = static_cast<uint>(24);
    uint _e511 = local_25;
    out[_e511] = _e507;
    int _e514 = sum(4);
    local_26 = static_cast<uint>(25);
    uint _e518 = local_26;
    out[_e518] = _e514;
    frozen.inner[0] = 2;
    frozen.inner[1] = 3;
    int _e529 = frozen.inner[0];
    int _e530 = frozen.inner[1];
    local_27 = static_cast<uint>(26);
    uint _e535 = local_27;
    out[_e535] = as_type<int>(as_type<uint>(_e529) + as_type<uint>(_e530));
    signed_zeroes.inner[0] = -(0.0);
    signed_zeroes.inner[1] = 0.0;
    float _e545 = signed_zeroes.inner[0];
    local_28 = static_cast<uint>(27);
    uint _e550 = local_28;
    out[_e550] = as_type<int>(_e545);
    float _e554 = signed_zeroes.inner[1];
    local_29 = static_cast<uint>(28);
    uint _e559 = local_29;
    out[_e559] = as_type<int>(_e554);
    int3_ _e564 = triple(6);
    from_calls.inner[0] = _e564;
    int3_ _e567 = triple(9);
    from_calls.inner[1] = _e567;
    int _e574 = from_calls.inner[0].x;
    int _e575 = from_calls.inner[1].z;
    local_30 = static_cast<uint>(29);
    uint _e580 = local_30;
    out[_e580] = as_type<int>(as_type<uint>(_e574) + as_type<uint>(_e575));
}
