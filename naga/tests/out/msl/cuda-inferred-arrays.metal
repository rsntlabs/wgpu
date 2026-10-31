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
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_31 = static_cast<uint>(_e3);
    uint _e6 = local_31;
    int seed_2 = out[_e6];
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
    int _e49 = values.inner[0];
    int _e50 = values.inner[1];
    int _e54 = values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e59 = local_1;
    local_32 = static_cast<uint>(_e59);
    uint _e62 = local_32;
    out[_e62] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e49) + as_type<uint>(_e50))) + as_type<uint>(_e54));
    int _e66 = copied.inner[0];
    local_2 = static_cast<uint>(1);
    uint _e70 = local_2;
    local_33 = static_cast<uint>(_e70);
    uint _e73 = local_33;
    out[_e73] = _e66;
    int _e79 = zeroes.inner[0];
    int _e80 = zeroes.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e85 = local_3;
    local_34 = static_cast<uint>(_e85);
    uint _e88 = local_34;
    out[_e88] = as_type<int>(as_type<uint>(_e79) + as_type<uint>(_e80));
    bool _e92 = flags.inner[0];
    bool _e96 = flags.inner[1];
    bool _e101 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e107 = local_4;
    local_35 = static_cast<uint>(_e107);
    uint _e110 = local_35;
    out[_e110] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e92)) + as_type<uint>(static_cast<int>(_e96)))) + as_type<uint>(static_cast<int>(_e101)));
    uint _e116 = counts.inner[0];
    uint _e117 = counts.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e123 = local_5;
    local_36 = static_cast<uint>(_e123);
    uint _e126 = local_36;
    out[_e126] = static_cast<int>(_e116 + _e117);
    float _e132 = samples.inner[0];
    float _e133 = samples.inner[1];
    local_6 = static_cast<uint>(5);
    uint _e139 = local_6;
    local_37 = static_cast<uint>(_e139);
    uint _e142 = local_37;
    out[_e142] = naga_f2i32(_e132 + _e133);
    self.inner[0] = 1;
    int _e150 = self.inner[0];
    self.inner[1] = as_type<int>(as_type<uint>(_e150) + as_type<uint>(1));
    int _e156 = self.inner[1];
    self.inner[2] = as_type<int>(as_type<uint>(_e156) + as_type<uint>(1));
    int _e161 = self.inner[0];
    int _e166 = self.inner[1];
    int _e172 = self.inner[2];
    local_7 = static_cast<uint>(6);
    uint _e177 = local_7;
    local_38 = static_cast<uint>(_e177);
    uint _e180 = local_38;
    out[_e180] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e161) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e166) * as_type<uint>(10))))) + as_type<uint>(_e172));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e193 = changed.inner[0];
    changed.inner[2] = _e193;
    int _e196 = changed.inner[0];
    local_8 = static_cast<uint>(7);
    uint _e200 = local_8;
    local_39 = static_cast<uint>(_e200);
    uint _e203 = local_39;
    out[_e203] = _e196;
    int _e207 = changed.inner[2];
    local_9 = static_cast<uint>(8);
    uint _e211 = local_9;
    local_40 = static_cast<uint>(_e211);
    uint _e214 = local_40;
    out[_e214] = _e207;
    points.inner[0].x = 1;
    int _e223 = points.inner[0].x;
    points.inner[0].y = as_type<int>(as_type<uint>(_e223) + as_type<uint>(1));
    int _e230 = points.inner[0].y;
    points.inner[0].z = as_type<int>(as_type<uint>(_e230) + as_type<uint>(1));
    int3_ _e237 = points.inner[0];
    points.inner[1] = _e237;
    int _e241 = points.inner[1].z;
    local_10 = static_cast<uint>(9);
    uint _e245 = local_10;
    local_41 = static_cast<uint>(_e245);
    uint _e248 = local_41;
    out[_e248] = _e241;
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e264 = flat.inner[1].y;
    local_11 = static_cast<uint>(10);
    uint _e268 = local_11;
    local_42 = static_cast<uint>(_e268);
    uint _e271 = local_42;
    out[_e271] = _e264;
    int _e276 = flat.inner[1].x;
    local_12 = static_cast<uint>(11);
    uint _e280 = local_12;
    local_43 = static_cast<uint>(_e280);
    uint _e283 = local_43;
    out[_e283] = _e276;
    original.x = 4;
    original.y = 5;
    original.z = 6;
    int3_ _e294 = original;
    copies.inner[0] = _e294;
    int3_ _e296 = original;
    copies.inner[1] = _e296;
    copies.inner[2].x = 7;
    copies.inner[2].y = 8;
    copies.inner[2].z = int {};
    original.x = 99;
    int _e309 = copies.inner[0].x;
    local_13 = static_cast<uint>(12);
    uint _e313 = local_13;
    local_44 = static_cast<uint>(_e313);
    uint _e316 = local_44;
    out[_e316] = _e309;
    int _e321 = copies.inner[1].y;
    local_14 = static_cast<uint>(13);
    uint _e325 = local_14;
    local_45 = static_cast<uint>(_e325);
    uint _e328 = local_45;
    out[_e328] = _e321;
    int _e333 = copies.inner[2].z;
    local_15 = static_cast<uint>(14);
    uint _e337 = local_15;
    local_46 = static_cast<uint>(_e337);
    uint _e340 = local_46;
    out[_e340] = _e333;
    Number.inner[0] = 2;
    Number.inner[1] = 3;
    int _e351 = Number.inner[1];
    next.inner[0] = _e351;
    int _e355 = Number.inner[0];
    next.inner[1] = _e355;
    int _e358 = next.inner[0];
    local_16 = static_cast<uint>(15);
    uint _e362 = local_16;
    local_47 = static_cast<uint>(_e362);
    uint _e365 = local_47;
    out[_e365] = _e358;
    Count = 3;
    scratch = type_4 {};
    int _e373 = scratch.inner[2];
    local_17 = static_cast<uint>(16);
    uint _e377 = local_17;
    local_48 = static_cast<uint>(_e377);
    uint _e380 = local_48;
    out[_e380] = _e373;
    pending.inner[0] = 1.0;
    pending.inner[1] = static_cast<float>(2);
    float _e392 = pending.inner[0];
    float _e393 = pending.inner[1];
    local_18 = static_cast<uint>(17);
    uint _e399 = local_18;
    local_49 = static_cast<uint>(_e399);
    uint _e402 = local_49;
    out[_e402] = naga_f2i32(_e392 + _e393);
    pending_vectors.inner[0].x = 1.0;
    pending_vectors.inner[0].y = static_cast<float>(2);
    pending_vectors.inner[0].z = float {};
    pending_vectors.inner[1].x = 3.0;
    pending_vectors.inner[1].y = float {};
    pending_vectors.inner[1].z = float {};
    float _e426 = pending_vectors.inner[0].x;
    float _e427 = pending_vectors.inner[0].y;
    float _e432 = pending_vectors.inner[1].x;
    local_19 = static_cast<uint>(18);
    uint _e438 = local_19;
    local_50 = static_cast<uint>(_e438);
    uint _e441 = local_50;
    out[_e441] = naga_f2i32((_e426 + _e427) + _e432);
    counter = seed_2;
    int _e446 = counter;
    counter = as_type<int>(as_type<uint>(_e446) + as_type<uint>(1));
    ordered.inner[0] = _e446;
    int _e450 = counter;
    counter = as_type<int>(as_type<uint>(_e450) + as_type<uint>(1));
    ordered.inner[1] = _e450;
    int _e454 = counter;
    ordered.inner[2] = _e454;
    int _e457 = ordered.inner[0];
    int _e462 = ordered.inner[1];
    int _e468 = ordered.inner[2];
    local_20 = static_cast<uint>(19);
    uint _e473 = local_20;
    local_51 = static_cast<uint>(_e473);
    uint _e476 = local_51;
    out[_e476] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e457) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e462) * as_type<uint>(10))))) + as_type<uint>(_e468));
    int _e478 = counter;
    local_21 = static_cast<uint>(20);
    uint _e482 = local_21;
    local_52 = static_cast<uint>(_e482);
    uint _e485 = local_52;
    out[_e485] = _e478;
    int _e489 = counter;
    counter = as_type<int>(as_type<uint>(_e489) + as_type<uint>(1));
    int _e493 = pair(_e489, 4);
    called.inner[0] = _e493;
    int _e495 = counter;
    called.inner[1] = _e495;
    int _e500 = called.inner[0];
    int _e501 = called.inner[1];
    local_22 = static_cast<uint>(21);
    uint _e506 = local_22;
    local_53 = static_cast<uint>(_e506);
    uint _e509 = local_53;
    out[_e509] = as_type<int>(as_type<uint>(_e500) + as_type<uint>(_e501));
    int _e511 = counter;
    local_23 = static_cast<uint>(22);
    uint _e515 = local_23;
    local_54 = static_cast<uint>(_e515);
    uint _e518 = local_54;
    out[_e518] = _e511;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e554 = iteration;
                iteration = as_type<int>(as_type<uint>(_e554) + as_type<uint>(1));
            }
            loop_init = false;
            int _e524 = iteration;
            if (_e524 < 3) {
            } else {
                break;
            }
            int _e529 = iteration;
            reset.inner[0].x = _e529;
            reset.inner[0].y = int {};
            reset.inner[1] = metal::int2 {};
            int _e541 = reset.inner[0].y;
            int _e542 = reset.inner[1].x;
            int _e544 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e544) + as_type<uint>(as_type<int>(as_type<uint>(_e541) + as_type<uint>(_e542))));
            reset.inner[0].y = 9;
            reset.inner[1].x = 8;
        }
    }
    int _e557 = zero_total;
    local_24 = static_cast<uint>(23);
    uint _e561 = local_24;
    local_55 = static_cast<uint>(_e561);
    uint _e564 = local_55;
    out[_e564] = _e557;
    total = 0;
    {
        iteration_1 = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e579 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e579) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e570 = iteration_1;
            if (_e570 < 4) {
            } else {
                break;
            }
            int _e573 = iteration_1;
            if (_e573 == 1) {
                continue;
            }
            int _e576 = iteration_1;
            int _e577 = total;
            total = as_type<int>(as_type<uint>(_e577) + as_type<uint>(_e576));
        }
    }
    int _e582 = total;
    local_25 = static_cast<uint>(24);
    uint _e586 = local_25;
    local_56 = static_cast<uint>(_e586);
    uint _e589 = local_56;
    out[_e589] = _e582;
    int _e592 = sum(4);
    local_26 = static_cast<uint>(25);
    uint _e596 = local_26;
    local_57 = static_cast<uint>(_e596);
    uint _e599 = local_57;
    out[_e599] = _e592;
    frozen.inner[0] = 2;
    frozen.inner[1] = 3;
    int _e610 = frozen.inner[0];
    int _e611 = frozen.inner[1];
    local_27 = static_cast<uint>(26);
    uint _e616 = local_27;
    local_58 = static_cast<uint>(_e616);
    uint _e619 = local_58;
    out[_e619] = as_type<int>(as_type<uint>(_e610) + as_type<uint>(_e611));
    signed_zeroes.inner[0] = -(0.0);
    signed_zeroes.inner[1] = 0.0;
    float _e629 = signed_zeroes.inner[0];
    local_28 = static_cast<uint>(27);
    uint _e634 = local_28;
    local_59 = static_cast<uint>(_e634);
    uint _e637 = local_59;
    out[_e637] = as_type<int>(_e629);
    float _e641 = signed_zeroes.inner[1];
    local_29 = static_cast<uint>(28);
    uint _e646 = local_29;
    local_60 = static_cast<uint>(_e646);
    uint _e649 = local_60;
    out[_e649] = as_type<int>(_e641);
    int3_ _e654 = triple(6);
    from_calls.inner[0] = _e654;
    int3_ _e657 = triple(9);
    from_calls.inner[1] = _e657;
    int _e664 = from_calls.inner[0].x;
    int _e665 = from_calls.inner[1].z;
    local_30 = static_cast<uint>(29);
    uint _e670 = local_30;
    local_61 = static_cast<uint>(_e670);
    uint _e673 = local_61;
    out[_e673] = as_type<int>(as_type<uint>(_e664) + as_type<uint>(_e665));
}
