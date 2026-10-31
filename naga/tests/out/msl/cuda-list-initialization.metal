// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_2 {
    int inner[3];
};
struct int3_ {
    int x;
    int y;
    int z;
};
typedef int type_4[1];
struct type_6 {
    int3_ inner[2];
};
struct type_8 {
    metal::int2 inner[2];
};
struct type_9 {
    int inner[2];
};
struct float3_ {
    float x;
    float y;
    float z;
};
constant int Global = 2;
constant float Scale = 0.5;

int pair(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first) * as_type<uint>(10))) + as_type<uint>(second));
}

int list_sum(
    int seed
) {
    type_2 values_1 = {};
    uint local_66 = {};
    values_1.inner[0] = seed;
    values_1.inner[1] = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    local_66 = 2u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_66;
            local_66 = _e13 + 1u;
        }
        loop_init = false;
        uint _e8 = local_66;
        if (_e8 >= 3u) {
            break;
        }
        values_1.inner[_e8] = int {};
    }
    int _e20 = values_1.inner[0];
    int _e21 = values_1.inner[1];
    int _e25 = values_1.inner[2];
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e20) + as_type<uint>(_e21))) + as_type<uint>(_e25));
}

int3_ make_list(
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


kernel void list_initialization(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    int zero = {};
    int copy_zero = {};
    bool enabled = {};
    float sample = {};
    int Local = {};
    int Safe = {};
    int local_1 = {};
    type_2 safe_values = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    type_2 values = {};
    uint local_10 = {};
    type_2 changed = {};
    uint local_11 = {};
    uint local_12 = {};
    int3_ point = {};
    uint local_13 = {};
    int3_ changed_point = {};
    uint local_14 = {};
    uint local_15 = {};
    type_6 nested = {};
    uint local_16 = {};
    type_8 flat = {};
    uint local_17 = {};
    int3_ original = {};
    int3_ copied = {};
    type_6 copies = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    int counter = {};
    type_2 ordered = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    int zero_total = {};
    int iteration = {};
    type_2 reset = {};
    uint local_24 = {};
    uint local_25 = {};
    int total = {};
    int iteration_1 = {};
    int limit = {};
    uint local_26 = {};
    int Number = {};
    type_9 cached = {};
    uint local_27 = {};
    type_2 frozen = {};
    uint local_28 = {};
    uint local_29 = {};
    float3_ floating = {};
    uint local_30 = {};
    uint local_31 = {};
    int3_ from_call = {};
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
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_35 = static_cast<uint>(_e3);
    uint _e6 = local_35;
    int seed_2 = out[_e6];
    zero = 0;
    copy_zero = 0;
    enabled = true;
    uint count = static_cast<uint>(7);
    sample = 1.5;
    Local = 3;
    Safe = 3;
    safe_values.inner[0] = 1;
    local_2 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e34 = local_2;
            local_2 = _e34 + 1u;
        }
        loop_init_1 = false;
        uint _e29 = local_2;
        if (_e29 >= 3u) {
            break;
        }
        safe_values.inner[_e29] = int {};
    }
    int _e37 = zero;
    local_3 = static_cast<uint>(0);
    uint _e41 = local_3;
    local_36 = static_cast<uint>(_e41);
    uint _e44 = local_36;
    out[_e44] = _e37;
    int _e46 = copy_zero;
    local_4 = static_cast<uint>(1);
    uint _e50 = local_4;
    local_37 = static_cast<uint>(_e50);
    uint _e53 = local_37;
    out[_e53] = _e46;
    bool _e55 = enabled;
    local_5 = static_cast<uint>(2);
    uint _e60 = local_5;
    local_38 = static_cast<uint>(_e60);
    uint _e63 = local_38;
    out[_e63] = static_cast<int>(_e55);
    local_6 = static_cast<uint>(3);
    uint _e69 = local_6;
    local_39 = static_cast<uint>(_e69);
    uint _e72 = local_39;
    out[_e72] = static_cast<int>(count);
    float _e74 = sample;
    local_7 = static_cast<uint>(4);
    uint _e81 = local_7;
    local_40 = static_cast<uint>(_e81);
    uint _e84 = local_40;
    out[_e84] = naga_f2i32(_e74 * 2.0);
    int _e86 = Local;
    local_8 = static_cast<uint>(5);
    uint _e92 = local_8;
    local_41 = static_cast<uint>(_e92);
    uint _e95 = local_41;
    out[_e95] = as_type<int>(as_type<uint>(Global) + as_type<uint>(_e86));
    int _e99 = safe_values.inner[2];
    local_9 = static_cast<uint>(6);
    uint _e103 = local_9;
    local_42 = static_cast<uint>(_e103);
    uint _e106 = local_42;
    out[_e106] = _e99;
    values.inner[0] = 1;
    int _e114 = values.inner[0];
    values.inner[1] = as_type<int>(as_type<uint>(_e114) + as_type<uint>(1));
    int _e120 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e120) + as_type<uint>(1));
    int _e127 = values.inner[0];
    int _e128 = values.inner[1];
    int _e132 = values.inner[2];
    local_10 = static_cast<uint>(7);
    uint _e137 = local_10;
    local_43 = static_cast<uint>(_e137);
    uint _e140 = local_43;
    out[_e140] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e127) + as_type<uint>(_e128))) + as_type<uint>(_e132));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e153 = changed.inner[0];
    changed.inner[2] = _e153;
    int _e156 = changed.inner[0];
    local_11 = static_cast<uint>(8);
    uint _e160 = local_11;
    local_44 = static_cast<uint>(_e160);
    uint _e163 = local_44;
    out[_e163] = _e156;
    int _e167 = changed.inner[2];
    local_12 = static_cast<uint>(9);
    uint _e171 = local_12;
    local_45 = static_cast<uint>(_e171);
    uint _e174 = local_45;
    out[_e174] = _e167;
    point.x = 1;
    int _e180 = point.x;
    point.y = as_type<int>(as_type<uint>(_e180) + as_type<uint>(1));
    int _e185 = point.y;
    point.z = as_type<int>(as_type<uint>(_e185) + as_type<uint>(1));
    int _e190 = point.z;
    local_13 = static_cast<uint>(10);
    uint _e194 = local_13;
    local_46 = static_cast<uint>(_e194);
    uint _e197 = local_46;
    out[_e197] = _e190;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e207 = changed_point.x;
    changed_point.z = _e207;
    int _e210 = changed_point.x;
    local_14 = static_cast<uint>(11);
    uint _e214 = local_14;
    local_47 = static_cast<uint>(_e214);
    uint _e217 = local_47;
    out[_e217] = _e210;
    int _e220 = changed_point.z;
    local_15 = static_cast<uint>(12);
    uint _e224 = local_15;
    local_48 = static_cast<uint>(_e224);
    uint _e227 = local_48;
    out[_e227] = _e220;
    nested.inner[0].x = 1;
    nested.inner[0].y = 2;
    nested.inner[0].z = int {};
    nested.inner[1].x = 3;
    nested.inner[1].y = int {};
    nested.inner[1].z = int {};
    int _e250 = nested.inner[0].z;
    int _e251 = nested.inner[1].x;
    local_16 = static_cast<uint>(13);
    uint _e256 = local_16;
    local_49 = static_cast<uint>(_e256);
    uint _e259 = local_49;
    out[_e259] = as_type<int>(as_type<uint>(_e250) + as_type<uint>(_e251));
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e278 = flat.inner[0].x;
    int _e279 = flat.inner[0].y;
    int _e284 = flat.inner[1].x;
    int _e289 = flat.inner[1].y;
    local_17 = static_cast<uint>(14);
    uint _e294 = local_17;
    local_50 = static_cast<uint>(_e294);
    uint _e297 = local_50;
    out[_e297] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e278) + as_type<uint>(_e279))) + as_type<uint>(_e284))) + as_type<uint>(_e289));
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e306 = original;
    copied = _e306;
    int3_ _e310 = original;
    copies.inner[0] = _e310;
    copies.inner[1].x = 5;
    copies.inner[1].y = 6;
    copies.inner[1].z = int {};
    original.x = 99;
    int _e321 = copied.x;
    local_18 = static_cast<uint>(15);
    uint _e325 = local_18;
    local_51 = static_cast<uint>(_e325);
    uint _e328 = local_51;
    out[_e328] = _e321;
    int _e333 = copies.inner[0].x;
    local_19 = static_cast<uint>(16);
    uint _e337 = local_19;
    local_52 = static_cast<uint>(_e337);
    uint _e340 = local_52;
    out[_e340] = _e333;
    int _e345 = copies.inner[1].z;
    local_20 = static_cast<uint>(17);
    uint _e349 = local_20;
    local_53 = static_cast<uint>(_e349);
    uint _e352 = local_53;
    out[_e352] = _e345;
    counter = seed_2;
    int _e357 = counter;
    counter = as_type<int>(as_type<uint>(_e357) + as_type<uint>(1));
    ordered.inner[0] = _e357;
    int _e361 = counter;
    counter = as_type<int>(as_type<uint>(_e361) + as_type<uint>(1));
    ordered.inner[1] = _e361;
    int _e365 = counter;
    ordered.inner[2] = _e365;
    int _e368 = ordered.inner[0];
    int _e373 = ordered.inner[1];
    int _e379 = ordered.inner[2];
    local_21 = static_cast<uint>(18);
    uint _e384 = local_21;
    local_54 = static_cast<uint>(_e384);
    uint _e387 = local_54;
    out[_e387] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e368) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e373) * as_type<uint>(10))))) + as_type<uint>(_e379));
    int _e389 = counter;
    local_22 = static_cast<uint>(19);
    uint _e393 = local_22;
    local_55 = static_cast<uint>(_e393);
    uint _e396 = local_55;
    out[_e396] = _e389;
    int _e398 = counter;
    counter = as_type<int>(as_type<uint>(_e398) + as_type<uint>(1));
    int _e402 = pair(_e398, 4);
    local_23 = static_cast<uint>(20);
    uint _e406 = local_23;
    local_56 = static_cast<uint>(_e406);
    uint _e409 = local_56;
    out[_e409] = _e402;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e439 = iteration;
                iteration = as_type<int>(as_type<uint>(_e439) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e415 = iteration;
            if (_e415 < 3) {
            } else {
                break;
            }
            int _e420 = iteration;
            reset.inner[0] = _e420;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (metal::all(loop_bound_3 == uint2(0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e428 = local_24;
                    local_24 = _e428 + 1u;
                }
                loop_init_3 = false;
                uint _e423 = local_24;
                if (_e423 >= 3u) {
                    break;
                }
                reset.inner[_e423] = int {};
            }
            int _e433 = reset.inner[2];
            int _e434 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e434) + as_type<uint>(_e433));
            reset.inner[2] = 9;
        }
    }
    int _e442 = zero_total;
    local_25 = static_cast<uint>(21);
    uint _e446 = local_25;
    local_57 = static_cast<uint>(_e446);
    uint _e449 = local_57;
    out[_e449] = _e442;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        uint2 loop_bound_4 = uint2(4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (metal::all(loop_bound_4 == uint2(0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                int _e463 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e463) + as_type<uint>(1));
            }
            loop_init_4 = false;
            int _e457 = iteration_1;
            int _e458 = limit;
            if (_e457 < _e458) {
            } else {
                break;
            }
            int _e460 = iteration_1;
            int _e461 = total;
            total = as_type<int>(as_type<uint>(_e461) + as_type<uint>(_e460));
        }
    }
    int _e466 = total;
    local_26 = static_cast<uint>(22);
    uint _e470 = local_26;
    local_58 = static_cast<uint>(_e470);
    uint _e473 = local_58;
    out[_e473] = _e466;
    Number = 4;
    int _e479 = Number;
    cached.inner[0] = _e479;
    int _e481 = Number;
    cached.inner[1] = as_type<int>(as_type<uint>(_e481) + as_type<uint>(1));
    int _e486 = cached.inner[1];
    local_27 = static_cast<uint>(23);
    uint _e490 = local_27;
    local_59 = static_cast<uint>(_e490);
    uint _e493 = local_59;
    out[_e493] = _e486;
    frozen.inner[0] = 3;
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e505 = local_28;
            local_28 = _e505 + 1u;
        }
        loop_init_5 = false;
        uint _e500 = local_28;
        if (_e500 >= 3u) {
            break;
        }
        frozen.inner[_e500] = int {};
    }
    int _e512 = frozen.inner[0];
    int _e513 = frozen.inner[1];
    int _e517 = frozen.inner[2];
    local_29 = static_cast<uint>(24);
    uint _e522 = local_29;
    local_60 = static_cast<uint>(_e522);
    uint _e525 = local_60;
    out[_e525] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e512) + as_type<uint>(_e513))) + as_type<uint>(_e517));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = float {};
    float _e536 = floating.y;
    local_30 = static_cast<uint>(25);
    uint _e541 = local_30;
    local_61 = static_cast<uint>(_e541);
    uint _e544 = local_61;
    out[_e544] = as_type<int>(_e536);
    float _e547 = floating.z;
    local_31 = static_cast<uint>(26);
    uint _e552 = local_31;
    local_62 = static_cast<uint>(_e552);
    uint _e555 = local_62;
    out[_e555] = as_type<int>(_e547);
    int3_ _e558 = make_list(6);
    from_call = _e558;
    int _e562 = from_call.x;
    int _e563 = from_call.z;
    local_32 = static_cast<uint>(27);
    uint _e568 = local_32;
    local_63 = static_cast<uint>(_e568);
    uint _e571 = local_63;
    out[_e571] = as_type<int>(as_type<uint>(_e562) + as_type<uint>(_e563));
    local_33 = static_cast<uint>(28);
    uint _e580 = local_33;
    local_64 = static_cast<uint>(_e580);
    uint _e583 = local_64;
    out[_e583] = naga_f2i32(Scale * 10.0);
    int _e587 = list_sum(as_type<int>(as_type<uint>(seed_2) + as_type<uint>(3)));
    local_34 = static_cast<uint>(29);
    uint _e591 = local_34;
    local_65 = static_cast<uint>(_e591);
    uint _e594 = local_65;
    out[_e594] = _e587;
}
