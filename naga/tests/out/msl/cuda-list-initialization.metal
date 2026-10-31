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
    uint local_68 = {};
    values_1.inner[0] = seed;
    values_1.inner[1] = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    local_68 = 2u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_68;
            local_68 = _e13 + 1u;
        }
        loop_init = false;
        uint _e8 = local_68;
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
    int local_35 = {};
    uint local_36 = {};
    int local_37 = {};
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
    uint local_66 = {};
    uint local_67 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_36 = static_cast<uint>(_e3);
    uint _e6 = local_36;
    int _e9 = out[_e6];
    local_37 = _e9;
    int _e11 = local_37;
    local_35 = _e11;
    int seed_2 = local_35;
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
            uint _e38 = local_2;
            local_2 = _e38 + 1u;
        }
        loop_init_1 = false;
        uint _e33 = local_2;
        if (_e33 >= 3u) {
            break;
        }
        safe_values.inner[_e33] = int {};
    }
    int _e41 = zero;
    local_3 = static_cast<uint>(0);
    uint _e45 = local_3;
    local_38 = static_cast<uint>(_e45);
    uint _e48 = local_38;
    out[_e48] = _e41;
    int _e50 = copy_zero;
    local_4 = static_cast<uint>(1);
    uint _e54 = local_4;
    local_39 = static_cast<uint>(_e54);
    uint _e57 = local_39;
    out[_e57] = _e50;
    bool _e59 = enabled;
    local_5 = static_cast<uint>(2);
    uint _e64 = local_5;
    local_40 = static_cast<uint>(_e64);
    uint _e67 = local_40;
    out[_e67] = static_cast<int>(_e59);
    local_6 = static_cast<uint>(3);
    uint _e73 = local_6;
    local_41 = static_cast<uint>(_e73);
    uint _e76 = local_41;
    out[_e76] = static_cast<int>(count);
    float _e78 = sample;
    local_7 = static_cast<uint>(4);
    uint _e85 = local_7;
    local_42 = static_cast<uint>(_e85);
    uint _e88 = local_42;
    out[_e88] = naga_f2i32(_e78 * 2.0);
    int _e90 = Local;
    local_8 = static_cast<uint>(5);
    uint _e96 = local_8;
    local_43 = static_cast<uint>(_e96);
    uint _e99 = local_43;
    out[_e99] = as_type<int>(as_type<uint>(Global) + as_type<uint>(_e90));
    int _e103 = safe_values.inner[2];
    local_9 = static_cast<uint>(6);
    uint _e107 = local_9;
    local_44 = static_cast<uint>(_e107);
    uint _e110 = local_44;
    out[_e110] = _e103;
    values.inner[0] = 1;
    int _e118 = values.inner[0];
    values.inner[1] = as_type<int>(as_type<uint>(_e118) + as_type<uint>(1));
    int _e124 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e124) + as_type<uint>(1));
    int _e131 = values.inner[0];
    int _e132 = values.inner[1];
    int _e136 = values.inner[2];
    local_10 = static_cast<uint>(7);
    uint _e141 = local_10;
    local_45 = static_cast<uint>(_e141);
    uint _e144 = local_45;
    out[_e144] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e131) + as_type<uint>(_e132))) + as_type<uint>(_e136));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e157 = changed.inner[0];
    changed.inner[2] = _e157;
    int _e160 = changed.inner[0];
    local_11 = static_cast<uint>(8);
    uint _e164 = local_11;
    local_46 = static_cast<uint>(_e164);
    uint _e167 = local_46;
    out[_e167] = _e160;
    int _e171 = changed.inner[2];
    local_12 = static_cast<uint>(9);
    uint _e175 = local_12;
    local_47 = static_cast<uint>(_e175);
    uint _e178 = local_47;
    out[_e178] = _e171;
    point.x = 1;
    int _e184 = point.x;
    point.y = as_type<int>(as_type<uint>(_e184) + as_type<uint>(1));
    int _e189 = point.y;
    point.z = as_type<int>(as_type<uint>(_e189) + as_type<uint>(1));
    int _e194 = point.z;
    local_13 = static_cast<uint>(10);
    uint _e198 = local_13;
    local_48 = static_cast<uint>(_e198);
    uint _e201 = local_48;
    out[_e201] = _e194;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e211 = changed_point.x;
    changed_point.z = _e211;
    int _e214 = changed_point.x;
    local_14 = static_cast<uint>(11);
    uint _e218 = local_14;
    local_49 = static_cast<uint>(_e218);
    uint _e221 = local_49;
    out[_e221] = _e214;
    int _e224 = changed_point.z;
    local_15 = static_cast<uint>(12);
    uint _e228 = local_15;
    local_50 = static_cast<uint>(_e228);
    uint _e231 = local_50;
    out[_e231] = _e224;
    nested.inner[0].x = 1;
    nested.inner[0].y = 2;
    nested.inner[0].z = int {};
    nested.inner[1].x = 3;
    nested.inner[1].y = int {};
    nested.inner[1].z = int {};
    int _e254 = nested.inner[0].z;
    int _e255 = nested.inner[1].x;
    local_16 = static_cast<uint>(13);
    uint _e260 = local_16;
    local_51 = static_cast<uint>(_e260);
    uint _e263 = local_51;
    out[_e263] = as_type<int>(as_type<uint>(_e254) + as_type<uint>(_e255));
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e282 = flat.inner[0].x;
    int _e283 = flat.inner[0].y;
    int _e288 = flat.inner[1].x;
    int _e293 = flat.inner[1].y;
    local_17 = static_cast<uint>(14);
    uint _e298 = local_17;
    local_52 = static_cast<uint>(_e298);
    uint _e301 = local_52;
    out[_e301] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e282) + as_type<uint>(_e283))) + as_type<uint>(_e288))) + as_type<uint>(_e293));
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e310 = original;
    copied = _e310;
    int3_ _e314 = original;
    copies.inner[0] = _e314;
    copies.inner[1].x = 5;
    copies.inner[1].y = 6;
    copies.inner[1].z = int {};
    original.x = 99;
    int _e325 = copied.x;
    local_18 = static_cast<uint>(15);
    uint _e329 = local_18;
    local_53 = static_cast<uint>(_e329);
    uint _e332 = local_53;
    out[_e332] = _e325;
    int _e337 = copies.inner[0].x;
    local_19 = static_cast<uint>(16);
    uint _e341 = local_19;
    local_54 = static_cast<uint>(_e341);
    uint _e344 = local_54;
    out[_e344] = _e337;
    int _e349 = copies.inner[1].z;
    local_20 = static_cast<uint>(17);
    uint _e353 = local_20;
    local_55 = static_cast<uint>(_e353);
    uint _e356 = local_55;
    out[_e356] = _e349;
    counter = seed_2;
    int _e361 = counter;
    counter = as_type<int>(as_type<uint>(_e361) + as_type<uint>(1));
    ordered.inner[0] = _e361;
    int _e365 = counter;
    counter = as_type<int>(as_type<uint>(_e365) + as_type<uint>(1));
    ordered.inner[1] = _e365;
    int _e369 = counter;
    ordered.inner[2] = _e369;
    int _e372 = ordered.inner[0];
    int _e377 = ordered.inner[1];
    int _e383 = ordered.inner[2];
    local_21 = static_cast<uint>(18);
    uint _e388 = local_21;
    local_56 = static_cast<uint>(_e388);
    uint _e391 = local_56;
    out[_e391] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e372) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e377) * as_type<uint>(10))))) + as_type<uint>(_e383));
    int _e393 = counter;
    local_22 = static_cast<uint>(19);
    uint _e397 = local_22;
    local_57 = static_cast<uint>(_e397);
    uint _e400 = local_57;
    out[_e400] = _e393;
    int _e402 = counter;
    counter = as_type<int>(as_type<uint>(_e402) + as_type<uint>(1));
    int _e406 = pair(_e402, 4);
    local_23 = static_cast<uint>(20);
    uint _e410 = local_23;
    local_58 = static_cast<uint>(_e410);
    uint _e413 = local_58;
    out[_e413] = _e406;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e443 = iteration;
                iteration = as_type<int>(as_type<uint>(_e443) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e419 = iteration;
            if (_e419 < 3) {
            } else {
                break;
            }
            int _e424 = iteration;
            reset.inner[0] = _e424;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (metal::all(loop_bound_3 == uint2(0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e432 = local_24;
                    local_24 = _e432 + 1u;
                }
                loop_init_3 = false;
                uint _e427 = local_24;
                if (_e427 >= 3u) {
                    break;
                }
                reset.inner[_e427] = int {};
            }
            int _e437 = reset.inner[2];
            int _e438 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e438) + as_type<uint>(_e437));
            reset.inner[2] = 9;
        }
    }
    int _e446 = zero_total;
    local_25 = static_cast<uint>(21);
    uint _e450 = local_25;
    local_59 = static_cast<uint>(_e450);
    uint _e453 = local_59;
    out[_e453] = _e446;
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
                int _e467 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e467) + as_type<uint>(1));
            }
            loop_init_4 = false;
            int _e461 = iteration_1;
            int _e462 = limit;
            if (_e461 < _e462) {
            } else {
                break;
            }
            int _e464 = iteration_1;
            int _e465 = total;
            total = as_type<int>(as_type<uint>(_e465) + as_type<uint>(_e464));
        }
    }
    int _e470 = total;
    local_26 = static_cast<uint>(22);
    uint _e474 = local_26;
    local_60 = static_cast<uint>(_e474);
    uint _e477 = local_60;
    out[_e477] = _e470;
    Number = 4;
    int _e483 = Number;
    cached.inner[0] = _e483;
    int _e485 = Number;
    cached.inner[1] = as_type<int>(as_type<uint>(_e485) + as_type<uint>(1));
    int _e490 = cached.inner[1];
    local_27 = static_cast<uint>(23);
    uint _e494 = local_27;
    local_61 = static_cast<uint>(_e494);
    uint _e497 = local_61;
    out[_e497] = _e490;
    frozen.inner[0] = 3;
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e509 = local_28;
            local_28 = _e509 + 1u;
        }
        loop_init_5 = false;
        uint _e504 = local_28;
        if (_e504 >= 3u) {
            break;
        }
        frozen.inner[_e504] = int {};
    }
    int _e516 = frozen.inner[0];
    int _e517 = frozen.inner[1];
    int _e521 = frozen.inner[2];
    local_29 = static_cast<uint>(24);
    uint _e526 = local_29;
    local_62 = static_cast<uint>(_e526);
    uint _e529 = local_62;
    out[_e529] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e516) + as_type<uint>(_e517))) + as_type<uint>(_e521));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = float {};
    float _e540 = floating.y;
    local_30 = static_cast<uint>(25);
    uint _e545 = local_30;
    local_63 = static_cast<uint>(_e545);
    uint _e548 = local_63;
    out[_e548] = as_type<int>(_e540);
    float _e551 = floating.z;
    local_31 = static_cast<uint>(26);
    uint _e556 = local_31;
    local_64 = static_cast<uint>(_e556);
    uint _e559 = local_64;
    out[_e559] = as_type<int>(_e551);
    int3_ _e562 = make_list(6);
    from_call = _e562;
    int _e566 = from_call.x;
    int _e567 = from_call.z;
    local_32 = static_cast<uint>(27);
    uint _e572 = local_32;
    local_65 = static_cast<uint>(_e572);
    uint _e575 = local_65;
    out[_e575] = as_type<int>(as_type<uint>(_e566) + as_type<uint>(_e567));
    local_33 = static_cast<uint>(28);
    uint _e584 = local_33;
    local_66 = static_cast<uint>(_e584);
    uint _e587 = local_66;
    out[_e587] = naga_f2i32(Scale * 10.0);
    int _e591 = list_sum(as_type<int>(as_type<uint>(seed_2) + as_type<uint>(3)));
    local_34 = static_cast<uint>(29);
    uint _e595 = local_34;
    local_67 = static_cast<uint>(_e595);
    uint _e598 = local_67;
    out[_e598] = _e591;
}
