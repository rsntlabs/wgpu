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
    type_4 values = {};
    type_1 copied = {};
    type_1 zeroes = {};
    type_6 flags = {};
    type_7 counts = {};
    type_9 samples = {};
    type_4 self = {};
    type_4 changed = {};
    type_10 points = {};
    type_12 flat = {};
    int3_ original = {};
    type_13 copies = {};
    type_1 Number = {};
    type_1 next = {};
    int Count = {};
    type_4 scratch = {};
    type_9 pending = {};
    type_14 pending_vectors = {};
    int counter = {};
    type_4 ordered = {};
    type_1 called = {};
    int zero_total = {};
    int iteration = {};
    type_12 reset = {};
    int total = {};
    int iteration_1 = {};
    type_1 frozen = {};
    type_9 signed_zeroes = {};
    type_10 from_calls = {};
    int seed_2 = out[static_cast<uint>(0)];
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
    int _e44 = values.inner[0];
    int _e45 = values.inner[1];
    int _e49 = values.inner[2];
    out[static_cast<uint>(0)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e44) + as_type<uint>(_e45))) + as_type<uint>(_e49));
    int _e56 = copied.inner[0];
    out[static_cast<uint>(1)] = _e56;
    int _e64 = zeroes.inner[0];
    int _e65 = zeroes.inner[1];
    out[static_cast<uint>(2)] = as_type<int>(as_type<uint>(_e64) + as_type<uint>(_e65));
    bool _e72 = flags.inner[0];
    bool _e76 = flags.inner[1];
    bool _e81 = flags.inner[2];
    out[static_cast<uint>(3)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e72)) + as_type<uint>(static_cast<int>(_e76)))) + as_type<uint>(static_cast<int>(_e81)));
    uint _e91 = counts.inner[0];
    uint _e92 = counts.inner[1];
    out[static_cast<uint>(4)] = static_cast<int>(_e91 + _e92);
    float _e102 = samples.inner[0];
    float _e103 = samples.inner[1];
    out[static_cast<uint>(5)] = naga_f2i32(_e102 + _e103);
    self.inner[0] = 1;
    int _e115 = self.inner[0];
    self.inner[1] = as_type<int>(as_type<uint>(_e115) + as_type<uint>(1));
    int _e121 = self.inner[1];
    self.inner[2] = as_type<int>(as_type<uint>(_e121) + as_type<uint>(1));
    int _e126 = self.inner[0];
    int _e131 = self.inner[1];
    int _e137 = self.inner[2];
    out[static_cast<uint>(6)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e126) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e131) * as_type<uint>(10))))) + as_type<uint>(_e137));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e153 = changed.inner[0];
    changed.inner[2] = _e153;
    int _e156 = changed.inner[0];
    out[static_cast<uint>(7)] = _e156;
    int _e162 = changed.inner[2];
    out[static_cast<uint>(8)] = _e162;
    points.inner[0].x = 1;
    int _e173 = points.inner[0].x;
    points.inner[0].y = as_type<int>(as_type<uint>(_e173) + as_type<uint>(1));
    int _e180 = points.inner[0].y;
    points.inner[0].z = as_type<int>(as_type<uint>(_e180) + as_type<uint>(1));
    int3_ _e187 = points.inner[0];
    points.inner[1] = _e187;
    int _e191 = points.inner[1].z;
    out[static_cast<uint>(9)] = _e191;
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e209 = flat.inner[1].y;
    out[static_cast<uint>(10)] = _e209;
    int _e216 = flat.inner[1].x;
    out[static_cast<uint>(11)] = _e216;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e229 = original;
    copies.inner[0] = _e229;
    int3_ _e231 = original;
    copies.inner[1] = _e231;
    copies.inner[2].x = 7;
    copies.inner[2].y = 8;
    copies.inner[2].z = int {};
    original.x = 99;
    int _e244 = copies.inner[0].x;
    out[static_cast<uint>(12)] = _e244;
    int _e251 = copies.inner[1].y;
    out[static_cast<uint>(13)] = _e251;
    int _e258 = copies.inner[2].z;
    out[static_cast<uint>(14)] = _e258;
    Number.inner[0] = 2;
    Number.inner[1] = 3;
    int _e271 = Number.inner[1];
    next.inner[0] = _e271;
    int _e275 = Number.inner[0];
    next.inner[1] = _e275;
    int _e278 = next.inner[0];
    out[static_cast<uint>(15)] = _e278;
    Count = 3;
    scratch = type_4 {};
    int _e288 = scratch.inner[2];
    out[static_cast<uint>(16)] = _e288;
    pending.inner[0] = 1.0;
    pending.inner[1] = static_cast<float>(2);
    float _e302 = pending.inner[0];
    float _e303 = pending.inner[1];
    out[static_cast<uint>(17)] = naga_f2i32(_e302 + _e303);
    pending_vectors.inner[0].x = 1.0;
    pending_vectors.inner[0].y = static_cast<float>(2);
    pending_vectors.inner[0].z = float {};
    pending_vectors.inner[1].x = 3.0;
    pending_vectors.inner[1].y = float {};
    pending_vectors.inner[1].z = float {};
    float _e331 = pending_vectors.inner[0].x;
    float _e332 = pending_vectors.inner[0].y;
    float _e337 = pending_vectors.inner[1].x;
    out[static_cast<uint>(18)] = naga_f2i32((_e331 + _e332) + _e337);
    counter = seed_2;
    int _e346 = counter;
    counter = as_type<int>(as_type<uint>(_e346) + as_type<uint>(1));
    ordered.inner[0] = _e346;
    int _e350 = counter;
    counter = as_type<int>(as_type<uint>(_e350) + as_type<uint>(1));
    ordered.inner[1] = _e350;
    int _e354 = counter;
    ordered.inner[2] = _e354;
    int _e357 = ordered.inner[0];
    int _e362 = ordered.inner[1];
    int _e368 = ordered.inner[2];
    out[static_cast<uint>(19)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e357) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e362) * as_type<uint>(10))))) + as_type<uint>(_e368));
    int _e373 = counter;
    out[static_cast<uint>(20)] = _e373;
    int _e379 = counter;
    counter = as_type<int>(as_type<uint>(_e379) + as_type<uint>(1));
    int _e383 = pair(_e379, 4);
    called.inner[0] = _e383;
    int _e385 = counter;
    called.inner[1] = _e385;
    int _e390 = called.inner[0];
    int _e391 = called.inner[1];
    out[static_cast<uint>(21)] = as_type<int>(as_type<uint>(_e390) + as_type<uint>(_e391));
    int _e396 = counter;
    out[static_cast<uint>(22)] = _e396;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e434 = iteration;
                iteration = as_type<int>(as_type<uint>(_e434) + as_type<uint>(1));
            }
            loop_init = false;
            int _e404 = iteration;
            if (_e404 < 3) {
            } else {
                break;
            }
            int _e409 = iteration;
            reset.inner[0].x = _e409;
            reset.inner[0].y = int {};
            reset.inner[1] = metal::int2 {};
            int _e421 = reset.inner[0].y;
            int _e422 = reset.inner[1].x;
            int _e424 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e424) + as_type<uint>(as_type<int>(as_type<uint>(_e421) + as_type<uint>(_e422))));
            reset.inner[0].y = 9;
            reset.inner[1].x = 8;
        }
    }
    int _e437 = zero_total;
    out[static_cast<uint>(23)] = _e437;
    total = 0;
    {
        iteration_1 = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e454 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e454) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e445 = iteration_1;
            if (_e445 < 4) {
            } else {
                break;
            }
            int _e448 = iteration_1;
            if (_e448 == 1) {
                continue;
            }
            int _e451 = iteration_1;
            int _e452 = total;
            total = as_type<int>(as_type<uint>(_e452) + as_type<uint>(_e451));
        }
    }
    int _e457 = total;
    out[static_cast<uint>(24)] = _e457;
    int _e462 = sum(4);
    out[static_cast<uint>(25)] = _e462;
    frozen.inner[0] = 2;
    frozen.inner[1] = 3;
    int _e475 = frozen.inner[0];
    int _e476 = frozen.inner[1];
    out[static_cast<uint>(26)] = as_type<int>(as_type<uint>(_e475) + as_type<uint>(_e476));
    signed_zeroes.inner[0] = -(0.0);
    signed_zeroes.inner[1] = 0.0;
    float _e489 = signed_zeroes.inner[0];
    out[static_cast<uint>(27)] = as_type<int>(_e489);
    float _e496 = signed_zeroes.inner[1];
    out[static_cast<uint>(28)] = as_type<int>(_e496);
    int3_ _e504 = triple(6);
    from_calls.inner[0] = _e504;
    int3_ _e507 = triple(9);
    from_calls.inner[1] = _e507;
    int _e514 = from_calls.inner[0].x;
    int _e515 = from_calls.inner[1].z;
    out[static_cast<uint>(29)] = as_type<int>(as_type<uint>(_e514) + as_type<uint>(_e515));
}
