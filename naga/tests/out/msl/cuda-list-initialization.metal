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
    uint local_35 = {};
    values_1.inner[0] = seed;
    values_1.inner[1] = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    local_35 = 2u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_35;
            local_35 = _e13 + 1u;
        }
        loop_init = false;
        uint _e8 = local_35;
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    int seed_2 = out[_e3];
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
            uint _e31 = local_2;
            local_2 = _e31 + 1u;
        }
        loop_init_1 = false;
        uint _e26 = local_2;
        if (_e26 >= 3u) {
            break;
        }
        safe_values.inner[_e26] = int {};
    }
    int _e34 = zero;
    local_3 = static_cast<uint>(0);
    uint _e38 = local_3;
    out[_e38] = _e34;
    int _e40 = copy_zero;
    local_4 = static_cast<uint>(1);
    uint _e44 = local_4;
    out[_e44] = _e40;
    bool _e46 = enabled;
    local_5 = static_cast<uint>(2);
    uint _e51 = local_5;
    out[_e51] = static_cast<int>(_e46);
    local_6 = static_cast<uint>(3);
    uint _e57 = local_6;
    out[_e57] = static_cast<int>(count);
    float _e59 = sample;
    local_7 = static_cast<uint>(4);
    uint _e66 = local_7;
    out[_e66] = naga_f2i32(_e59 * 2.0);
    int _e68 = Local;
    local_8 = static_cast<uint>(5);
    uint _e74 = local_8;
    out[_e74] = as_type<int>(as_type<uint>(Global) + as_type<uint>(_e68));
    int _e78 = safe_values.inner[2];
    local_9 = static_cast<uint>(6);
    uint _e82 = local_9;
    out[_e82] = _e78;
    values.inner[0] = 1;
    int _e90 = values.inner[0];
    values.inner[1] = as_type<int>(as_type<uint>(_e90) + as_type<uint>(1));
    int _e96 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e96) + as_type<uint>(1));
    int _e103 = values.inner[0];
    int _e104 = values.inner[1];
    int _e108 = values.inner[2];
    local_10 = static_cast<uint>(7);
    uint _e113 = local_10;
    out[_e113] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e103) + as_type<uint>(_e104))) + as_type<uint>(_e108));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e126 = changed.inner[0];
    changed.inner[2] = _e126;
    int _e129 = changed.inner[0];
    local_11 = static_cast<uint>(8);
    uint _e133 = local_11;
    out[_e133] = _e129;
    int _e137 = changed.inner[2];
    local_12 = static_cast<uint>(9);
    uint _e141 = local_12;
    out[_e141] = _e137;
    point.x = 1;
    int _e147 = point.x;
    point.y = as_type<int>(as_type<uint>(_e147) + as_type<uint>(1));
    int _e152 = point.y;
    point.z = as_type<int>(as_type<uint>(_e152) + as_type<uint>(1));
    int _e157 = point.z;
    local_13 = static_cast<uint>(10);
    uint _e161 = local_13;
    out[_e161] = _e157;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e171 = changed_point.x;
    changed_point.z = _e171;
    int _e174 = changed_point.x;
    local_14 = static_cast<uint>(11);
    uint _e178 = local_14;
    out[_e178] = _e174;
    int _e181 = changed_point.z;
    local_15 = static_cast<uint>(12);
    uint _e185 = local_15;
    out[_e185] = _e181;
    nested.inner[0].x = 1;
    nested.inner[0].y = 2;
    nested.inner[0].z = int {};
    nested.inner[1].x = 3;
    nested.inner[1].y = int {};
    nested.inner[1].z = int {};
    int _e208 = nested.inner[0].z;
    int _e209 = nested.inner[1].x;
    local_16 = static_cast<uint>(13);
    uint _e214 = local_16;
    out[_e214] = as_type<int>(as_type<uint>(_e208) + as_type<uint>(_e209));
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e233 = flat.inner[0].x;
    int _e234 = flat.inner[0].y;
    int _e239 = flat.inner[1].x;
    int _e244 = flat.inner[1].y;
    local_17 = static_cast<uint>(14);
    uint _e249 = local_17;
    out[_e249] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e233) + as_type<uint>(_e234))) + as_type<uint>(_e239))) + as_type<uint>(_e244));
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e258 = original;
    copied = _e258;
    int3_ _e262 = original;
    copies.inner[0] = _e262;
    copies.inner[1].x = 5;
    copies.inner[1].y = 6;
    copies.inner[1].z = int {};
    original.x = 99;
    int _e273 = copied.x;
    local_18 = static_cast<uint>(15);
    uint _e277 = local_18;
    out[_e277] = _e273;
    int _e282 = copies.inner[0].x;
    local_19 = static_cast<uint>(16);
    uint _e286 = local_19;
    out[_e286] = _e282;
    int _e291 = copies.inner[1].z;
    local_20 = static_cast<uint>(17);
    uint _e295 = local_20;
    out[_e295] = _e291;
    counter = seed_2;
    int _e300 = counter;
    counter = as_type<int>(as_type<uint>(_e300) + as_type<uint>(1));
    ordered.inner[0] = _e300;
    int _e304 = counter;
    counter = as_type<int>(as_type<uint>(_e304) + as_type<uint>(1));
    ordered.inner[1] = _e304;
    int _e308 = counter;
    ordered.inner[2] = _e308;
    int _e311 = ordered.inner[0];
    int _e316 = ordered.inner[1];
    int _e322 = ordered.inner[2];
    local_21 = static_cast<uint>(18);
    uint _e327 = local_21;
    out[_e327] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e311) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e316) * as_type<uint>(10))))) + as_type<uint>(_e322));
    int _e329 = counter;
    local_22 = static_cast<uint>(19);
    uint _e333 = local_22;
    out[_e333] = _e329;
    int _e335 = counter;
    counter = as_type<int>(as_type<uint>(_e335) + as_type<uint>(1));
    int _e339 = pair(_e335, 4);
    local_23 = static_cast<uint>(20);
    uint _e343 = local_23;
    out[_e343] = _e339;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e373 = iteration;
                iteration = as_type<int>(as_type<uint>(_e373) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e349 = iteration;
            if (_e349 < 3) {
            } else {
                break;
            }
            int _e354 = iteration;
            reset.inner[0] = _e354;
            local_24 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (metal::all(loop_bound_3 == uint2(0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e362 = local_24;
                    local_24 = _e362 + 1u;
                }
                loop_init_3 = false;
                uint _e357 = local_24;
                if (_e357 >= 3u) {
                    break;
                }
                reset.inner[_e357] = int {};
            }
            int _e367 = reset.inner[2];
            int _e368 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e368) + as_type<uint>(_e367));
            reset.inner[2] = 9;
        }
    }
    int _e376 = zero_total;
    local_25 = static_cast<uint>(21);
    uint _e380 = local_25;
    out[_e380] = _e376;
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
                int _e394 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e394) + as_type<uint>(1));
            }
            loop_init_4 = false;
            int _e388 = iteration_1;
            int _e389 = limit;
            if (_e388 < _e389) {
            } else {
                break;
            }
            int _e391 = iteration_1;
            int _e392 = total;
            total = as_type<int>(as_type<uint>(_e392) + as_type<uint>(_e391));
        }
    }
    int _e397 = total;
    local_26 = static_cast<uint>(22);
    uint _e401 = local_26;
    out[_e401] = _e397;
    Number = 4;
    int _e407 = Number;
    cached.inner[0] = _e407;
    int _e409 = Number;
    cached.inner[1] = as_type<int>(as_type<uint>(_e409) + as_type<uint>(1));
    int _e414 = cached.inner[1];
    local_27 = static_cast<uint>(23);
    uint _e418 = local_27;
    out[_e418] = _e414;
    frozen.inner[0] = 3;
    local_28 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e430 = local_28;
            local_28 = _e430 + 1u;
        }
        loop_init_5 = false;
        uint _e425 = local_28;
        if (_e425 >= 3u) {
            break;
        }
        frozen.inner[_e425] = int {};
    }
    int _e437 = frozen.inner[0];
    int _e438 = frozen.inner[1];
    int _e442 = frozen.inner[2];
    local_29 = static_cast<uint>(24);
    uint _e447 = local_29;
    out[_e447] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e437) + as_type<uint>(_e438))) + as_type<uint>(_e442));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = float {};
    float _e458 = floating.y;
    local_30 = static_cast<uint>(25);
    uint _e463 = local_30;
    out[_e463] = as_type<int>(_e458);
    float _e466 = floating.z;
    local_31 = static_cast<uint>(26);
    uint _e471 = local_31;
    out[_e471] = as_type<int>(_e466);
    int3_ _e474 = make_list(6);
    from_call = _e474;
    int _e478 = from_call.x;
    int _e479 = from_call.z;
    local_32 = static_cast<uint>(27);
    uint _e484 = local_32;
    out[_e484] = as_type<int>(as_type<uint>(_e478) + as_type<uint>(_e479));
    local_33 = static_cast<uint>(28);
    uint _e493 = local_33;
    out[_e493] = naga_f2i32(Scale * 10.0);
    int _e497 = list_sum(as_type<int>(as_type<uint>(seed_2) + as_type<uint>(3)));
    local_34 = static_cast<uint>(29);
    uint _e501 = local_34;
    out[_e501] = _e497;
}
