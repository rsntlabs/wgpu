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
    int local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_32 = static_cast<uint>(_e3);
    uint _e6 = local_32;
    int _e9 = out[_e6];
    local_33 = _e9;
    int _e11 = local_33;
    local_31 = _e11;
    int seed_2 = local_31;
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
    int _e53 = values.inner[0];
    int _e54 = values.inner[1];
    int _e58 = values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e63 = local_1;
    local_34 = static_cast<uint>(_e63);
    uint _e66 = local_34;
    out[_e66] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e53) + as_type<uint>(_e54))) + as_type<uint>(_e58));
    int _e70 = copied.inner[0];
    local_2 = static_cast<uint>(1);
    uint _e74 = local_2;
    local_35 = static_cast<uint>(_e74);
    uint _e77 = local_35;
    out[_e77] = _e70;
    int _e83 = zeroes.inner[0];
    int _e84 = zeroes.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e89 = local_3;
    local_36 = static_cast<uint>(_e89);
    uint _e92 = local_36;
    out[_e92] = as_type<int>(as_type<uint>(_e83) + as_type<uint>(_e84));
    bool _e96 = flags.inner[0];
    bool _e100 = flags.inner[1];
    bool _e105 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e111 = local_4;
    local_37 = static_cast<uint>(_e111);
    uint _e114 = local_37;
    out[_e114] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e96)) + as_type<uint>(static_cast<int>(_e100)))) + as_type<uint>(static_cast<int>(_e105)));
    uint _e120 = counts.inner[0];
    uint _e121 = counts.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e127 = local_5;
    local_38 = static_cast<uint>(_e127);
    uint _e130 = local_38;
    out[_e130] = static_cast<int>(_e120 + _e121);
    float _e136 = samples.inner[0];
    float _e137 = samples.inner[1];
    local_6 = static_cast<uint>(5);
    uint _e143 = local_6;
    local_39 = static_cast<uint>(_e143);
    uint _e146 = local_39;
    out[_e146] = naga_f2i32(_e136 + _e137);
    self.inner[0] = 1;
    int _e154 = self.inner[0];
    self.inner[1] = as_type<int>(as_type<uint>(_e154) + as_type<uint>(1));
    int _e160 = self.inner[1];
    self.inner[2] = as_type<int>(as_type<uint>(_e160) + as_type<uint>(1));
    int _e165 = self.inner[0];
    int _e170 = self.inner[1];
    int _e176 = self.inner[2];
    local_7 = static_cast<uint>(6);
    uint _e181 = local_7;
    local_40 = static_cast<uint>(_e181);
    uint _e184 = local_40;
    out[_e184] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e165) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e170) * as_type<uint>(10))))) + as_type<uint>(_e176));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e197 = changed.inner[0];
    changed.inner[2] = _e197;
    int _e200 = changed.inner[0];
    local_8 = static_cast<uint>(7);
    uint _e204 = local_8;
    local_41 = static_cast<uint>(_e204);
    uint _e207 = local_41;
    out[_e207] = _e200;
    int _e211 = changed.inner[2];
    local_9 = static_cast<uint>(8);
    uint _e215 = local_9;
    local_42 = static_cast<uint>(_e215);
    uint _e218 = local_42;
    out[_e218] = _e211;
    points.inner[0].x = 1;
    int _e227 = points.inner[0].x;
    points.inner[0].y = as_type<int>(as_type<uint>(_e227) + as_type<uint>(1));
    int _e234 = points.inner[0].y;
    points.inner[0].z = as_type<int>(as_type<uint>(_e234) + as_type<uint>(1));
    int3_ _e241 = points.inner[0];
    points.inner[1] = _e241;
    int _e245 = points.inner[1].z;
    local_10 = static_cast<uint>(9);
    uint _e249 = local_10;
    local_43 = static_cast<uint>(_e249);
    uint _e252 = local_43;
    out[_e252] = _e245;
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e268 = flat.inner[1].y;
    local_11 = static_cast<uint>(10);
    uint _e272 = local_11;
    local_44 = static_cast<uint>(_e272);
    uint _e275 = local_44;
    out[_e275] = _e268;
    int _e280 = flat.inner[1].x;
    local_12 = static_cast<uint>(11);
    uint _e284 = local_12;
    local_45 = static_cast<uint>(_e284);
    uint _e287 = local_45;
    out[_e287] = _e280;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e298 = original;
    copies.inner[0] = _e298;
    int3_ _e300 = original;
    copies.inner[1] = _e300;
    copies.inner[2].x = 7;
    copies.inner[2].y = 8;
    copies.inner[2].z = int {};
    original.x = 99;
    int _e313 = copies.inner[0].x;
    local_13 = static_cast<uint>(12);
    uint _e317 = local_13;
    local_46 = static_cast<uint>(_e317);
    uint _e320 = local_46;
    out[_e320] = _e313;
    int _e325 = copies.inner[1].y;
    local_14 = static_cast<uint>(13);
    uint _e329 = local_14;
    local_47 = static_cast<uint>(_e329);
    uint _e332 = local_47;
    out[_e332] = _e325;
    int _e337 = copies.inner[2].z;
    local_15 = static_cast<uint>(14);
    uint _e341 = local_15;
    local_48 = static_cast<uint>(_e341);
    uint _e344 = local_48;
    out[_e344] = _e337;
    Number.inner[0] = 2;
    Number.inner[1] = 3;
    int _e355 = Number.inner[1];
    next.inner[0] = _e355;
    int _e359 = Number.inner[0];
    next.inner[1] = _e359;
    int _e362 = next.inner[0];
    local_16 = static_cast<uint>(15);
    uint _e366 = local_16;
    local_49 = static_cast<uint>(_e366);
    uint _e369 = local_49;
    out[_e369] = _e362;
    Count = 3;
    scratch = type_4 {};
    int _e377 = scratch.inner[2];
    local_17 = static_cast<uint>(16);
    uint _e381 = local_17;
    local_50 = static_cast<uint>(_e381);
    uint _e384 = local_50;
    out[_e384] = _e377;
    pending.inner[0] = 1.0;
    pending.inner[1] = static_cast<float>(2);
    float _e396 = pending.inner[0];
    float _e397 = pending.inner[1];
    local_18 = static_cast<uint>(17);
    uint _e403 = local_18;
    local_51 = static_cast<uint>(_e403);
    uint _e406 = local_51;
    out[_e406] = naga_f2i32(_e396 + _e397);
    pending_vectors.inner[0].x = 1.0;
    pending_vectors.inner[0].y = static_cast<float>(2);
    pending_vectors.inner[0].z = float {};
    pending_vectors.inner[1].x = 3.0;
    pending_vectors.inner[1].y = float {};
    pending_vectors.inner[1].z = float {};
    float _e430 = pending_vectors.inner[0].x;
    float _e431 = pending_vectors.inner[0].y;
    float _e436 = pending_vectors.inner[1].x;
    local_19 = static_cast<uint>(18);
    uint _e442 = local_19;
    local_52 = static_cast<uint>(_e442);
    uint _e445 = local_52;
    out[_e445] = naga_f2i32((_e430 + _e431) + _e436);
    counter = seed_2;
    int _e450 = counter;
    counter = as_type<int>(as_type<uint>(_e450) + as_type<uint>(1));
    ordered.inner[0] = _e450;
    int _e454 = counter;
    counter = as_type<int>(as_type<uint>(_e454) + as_type<uint>(1));
    ordered.inner[1] = _e454;
    int _e458 = counter;
    ordered.inner[2] = _e458;
    int _e461 = ordered.inner[0];
    int _e466 = ordered.inner[1];
    int _e472 = ordered.inner[2];
    local_20 = static_cast<uint>(19);
    uint _e477 = local_20;
    local_53 = static_cast<uint>(_e477);
    uint _e480 = local_53;
    out[_e480] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e461) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e466) * as_type<uint>(10))))) + as_type<uint>(_e472));
    int _e482 = counter;
    local_21 = static_cast<uint>(20);
    uint _e486 = local_21;
    local_54 = static_cast<uint>(_e486);
    uint _e489 = local_54;
    out[_e489] = _e482;
    int _e493 = counter;
    counter = as_type<int>(as_type<uint>(_e493) + as_type<uint>(1));
    int _e497 = pair(_e493, 4);
    called.inner[0] = _e497;
    int _e499 = counter;
    called.inner[1] = _e499;
    int _e504 = called.inner[0];
    int _e505 = called.inner[1];
    local_22 = static_cast<uint>(21);
    uint _e510 = local_22;
    local_55 = static_cast<uint>(_e510);
    uint _e513 = local_55;
    out[_e513] = as_type<int>(as_type<uint>(_e504) + as_type<uint>(_e505));
    int _e515 = counter;
    local_23 = static_cast<uint>(22);
    uint _e519 = local_23;
    local_56 = static_cast<uint>(_e519);
    uint _e522 = local_56;
    out[_e522] = _e515;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e558 = iteration;
                iteration = as_type<int>(as_type<uint>(_e558) + as_type<uint>(1));
            }
            loop_init = false;
            int _e528 = iteration;
            if (_e528 < 3) {
            } else {
                break;
            }
            int _e533 = iteration;
            reset.inner[0].x = _e533;
            reset.inner[0].y = int {};
            reset.inner[1] = metal::int2 {};
            int _e545 = reset.inner[0].y;
            int _e546 = reset.inner[1].x;
            int _e548 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e548) + as_type<uint>(as_type<int>(as_type<uint>(_e545) + as_type<uint>(_e546))));
            reset.inner[0].y = 9;
            reset.inner[1].x = 8;
        }
    }
    int _e561 = zero_total;
    local_24 = static_cast<uint>(23);
    uint _e565 = local_24;
    local_57 = static_cast<uint>(_e565);
    uint _e568 = local_57;
    out[_e568] = _e561;
    total = 0;
    {
        iteration_1 = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e583 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e583) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e574 = iteration_1;
            if (_e574 < 4) {
            } else {
                break;
            }
            int _e577 = iteration_1;
            if (_e577 == 1) {
                continue;
            }
            int _e580 = iteration_1;
            int _e581 = total;
            total = as_type<int>(as_type<uint>(_e581) + as_type<uint>(_e580));
        }
    }
    int _e586 = total;
    local_25 = static_cast<uint>(24);
    uint _e590 = local_25;
    local_58 = static_cast<uint>(_e590);
    uint _e593 = local_58;
    out[_e593] = _e586;
    int _e596 = sum(4);
    local_26 = static_cast<uint>(25);
    uint _e600 = local_26;
    local_59 = static_cast<uint>(_e600);
    uint _e603 = local_59;
    out[_e603] = _e596;
    frozen.inner[0] = 2;
    frozen.inner[1] = 3;
    int _e614 = frozen.inner[0];
    int _e615 = frozen.inner[1];
    local_27 = static_cast<uint>(26);
    uint _e620 = local_27;
    local_60 = static_cast<uint>(_e620);
    uint _e623 = local_60;
    out[_e623] = as_type<int>(as_type<uint>(_e614) + as_type<uint>(_e615));
    signed_zeroes.inner[0] = -(0.0);
    signed_zeroes.inner[1] = 0.0;
    float _e633 = signed_zeroes.inner[0];
    local_28 = static_cast<uint>(27);
    uint _e638 = local_28;
    local_61 = static_cast<uint>(_e638);
    uint _e641 = local_61;
    out[_e641] = as_type<int>(_e633);
    float _e645 = signed_zeroes.inner[1];
    local_29 = static_cast<uint>(28);
    uint _e650 = local_29;
    local_62 = static_cast<uint>(_e650);
    uint _e653 = local_62;
    out[_e653] = as_type<int>(_e645);
    int3_ _e658 = triple(6);
    from_calls.inner[0] = _e658;
    int3_ _e661 = triple(9);
    from_calls.inner[1] = _e661;
    int _e668 = from_calls.inner[0].x;
    int _e669 = from_calls.inner[1].z;
    local_30 = static_cast<uint>(29);
    uint _e674 = local_30;
    local_63 = static_cast<uint>(_e674);
    uint _e677 = local_63;
    out[_e677] = as_type<int>(as_type<uint>(_e668) + as_type<uint>(_e669));
}
