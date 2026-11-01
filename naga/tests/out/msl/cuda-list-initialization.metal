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
    uint local_4 = {};
    values_1.inner[0] = seed;
    values_1.inner[1] = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    local_4 = 2u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_4;
            local_4 = _e13 + 1u;
        }
        loop_init = false;
        uint _e8 = local_4;
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
    int zero = {};
    int copy_zero = {};
    bool enabled = {};
    float sample = {};
    int Local = {};
    int Safe = {};
    int local = {};
    type_2 safe_values = {};
    uint local_1 = {};
    type_2 values = {};
    type_2 changed = {};
    int3_ point = {};
    int3_ changed_point = {};
    type_6 nested = {};
    type_8 flat = {};
    int3_ original = {};
    int3_ copied = {};
    type_6 copies = {};
    int counter = {};
    type_2 ordered = {};
    int zero_total = {};
    int iteration = {};
    type_2 reset = {};
    uint local_2 = {};
    int total = {};
    int iteration_1 = {};
    int limit = {};
    int Number = {};
    type_9 cached = {};
    type_2 frozen = {};
    uint local_3 = {};
    float3_ floating = {};
    int3_ from_call = {};
    int seed_2 = out[static_cast<uint>(0)];
    zero = 0;
    copy_zero = 0;
    enabled = true;
    uint count = static_cast<uint>(7);
    sample = 1.5;
    Local = 3;
    Safe = 3;
    safe_values.inner[0] = 1;
    local_1 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e29 = local_1;
            local_1 = _e29 + 1u;
        }
        loop_init_1 = false;
        uint _e24 = local_1;
        if (_e24 >= 3u) {
            break;
        }
        safe_values.inner[_e24] = int {};
    }
    int _e32 = zero;
    out[static_cast<uint>(0)] = _e32;
    int _e36 = copy_zero;
    out[static_cast<uint>(1)] = _e36;
    bool _e40 = enabled;
    out[static_cast<uint>(2)] = static_cast<int>(_e40);
    out[static_cast<uint>(3)] = static_cast<int>(count);
    float _e49 = sample;
    out[static_cast<uint>(4)] = naga_f2i32(_e49 * 2.0);
    int _e56 = Local;
    out[static_cast<uint>(5)] = as_type<int>(as_type<uint>(Global) + as_type<uint>(_e56));
    int _e64 = safe_values.inner[2];
    out[static_cast<uint>(6)] = _e64;
    values.inner[0] = 1;
    int _e74 = values.inner[0];
    values.inner[1] = as_type<int>(as_type<uint>(_e74) + as_type<uint>(1));
    int _e80 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e80) + as_type<uint>(1));
    int _e87 = values.inner[0];
    int _e88 = values.inner[1];
    int _e92 = values.inner[2];
    out[static_cast<uint>(7)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e87) + as_type<uint>(_e88))) + as_type<uint>(_e92));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e108 = changed.inner[0];
    changed.inner[2] = _e108;
    int _e111 = changed.inner[0];
    out[static_cast<uint>(8)] = _e111;
    int _e117 = changed.inner[2];
    out[static_cast<uint>(9)] = _e117;
    point.x = 1;
    int _e125 = point.x;
    point.y = as_type<int>(as_type<uint>(_e125) + as_type<uint>(1));
    int _e130 = point.y;
    point.z = as_type<int>(as_type<uint>(_e130) + as_type<uint>(1));
    int _e135 = point.z;
    out[static_cast<uint>(10)] = _e135;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e147 = changed_point.x;
    changed_point.z = _e147;
    int _e150 = changed_point.x;
    out[static_cast<uint>(11)] = _e150;
    int _e155 = changed_point.z;
    out[static_cast<uint>(12)] = _e155;
    nested.inner[0].x = 1;
    nested.inner[0].y = 2;
    nested.inner[0].z = int {};
    nested.inner[1].x = 3;
    nested.inner[1].y = int {};
    nested.inner[1].z = int {};
    int _e180 = nested.inner[0].z;
    int _e181 = nested.inner[1].x;
    out[static_cast<uint>(13)] = as_type<int>(as_type<uint>(_e180) + as_type<uint>(_e181));
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e203 = flat.inner[0].x;
    int _e204 = flat.inner[0].y;
    int _e209 = flat.inner[1].x;
    int _e214 = flat.inner[1].y;
    out[static_cast<uint>(14)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e203) + as_type<uint>(_e204))) + as_type<uint>(_e209))) + as_type<uint>(_e214));
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e226 = original;
    copied = _e226;
    int3_ _e230 = original;
    copies.inner[0] = _e230;
    copies.inner[1].x = 5;
    copies.inner[1].y = 6;
    copies.inner[1].z = int {};
    original.x = 99;
    int _e241 = copied.x;
    out[static_cast<uint>(15)] = _e241;
    int _e248 = copies.inner[0].x;
    out[static_cast<uint>(16)] = _e248;
    int _e255 = copies.inner[1].z;
    out[static_cast<uint>(17)] = _e255;
    counter = seed_2;
    int _e262 = counter;
    counter = as_type<int>(as_type<uint>(_e262) + as_type<uint>(1));
    ordered.inner[0] = _e262;
    int _e266 = counter;
    counter = as_type<int>(as_type<uint>(_e266) + as_type<uint>(1));
    ordered.inner[1] = _e266;
    int _e270 = counter;
    ordered.inner[2] = _e270;
    int _e273 = ordered.inner[0];
    int _e278 = ordered.inner[1];
    int _e284 = ordered.inner[2];
    out[static_cast<uint>(18)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e273) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e278) * as_type<uint>(10))))) + as_type<uint>(_e284));
    int _e289 = counter;
    out[static_cast<uint>(19)] = _e289;
    int _e293 = counter;
    counter = as_type<int>(as_type<uint>(_e293) + as_type<uint>(1));
    int _e297 = pair(_e293, 4);
    out[static_cast<uint>(20)] = _e297;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e329 = iteration;
                iteration = as_type<int>(as_type<uint>(_e329) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e305 = iteration;
            if (_e305 < 3) {
            } else {
                break;
            }
            int _e310 = iteration;
            reset.inner[0] = _e310;
            local_2 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (metal::all(loop_bound_3 == uint2(0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e318 = local_2;
                    local_2 = _e318 + 1u;
                }
                loop_init_3 = false;
                uint _e313 = local_2;
                if (_e313 >= 3u) {
                    break;
                }
                reset.inner[_e313] = int {};
            }
            int _e323 = reset.inner[2];
            int _e324 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e324) + as_type<uint>(_e323));
            reset.inner[2] = 9;
        }
    }
    int _e332 = zero_total;
    out[static_cast<uint>(21)] = _e332;
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
                int _e348 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e348) + as_type<uint>(1));
            }
            loop_init_4 = false;
            int _e342 = iteration_1;
            int _e343 = limit;
            if (_e342 < _e343) {
            } else {
                break;
            }
            int _e345 = iteration_1;
            int _e346 = total;
            total = as_type<int>(as_type<uint>(_e346) + as_type<uint>(_e345));
        }
    }
    int _e351 = total;
    out[static_cast<uint>(22)] = _e351;
    Number = 4;
    int _e359 = Number;
    cached.inner[0] = _e359;
    int _e361 = Number;
    cached.inner[1] = as_type<int>(as_type<uint>(_e361) + as_type<uint>(1));
    int _e366 = cached.inner[1];
    out[static_cast<uint>(23)] = _e366;
    frozen.inner[0] = 3;
    local_3 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e380 = local_3;
            local_3 = _e380 + 1u;
        }
        loop_init_5 = false;
        uint _e375 = local_3;
        if (_e375 >= 3u) {
            break;
        }
        frozen.inner[_e375] = int {};
    }
    int _e387 = frozen.inner[0];
    int _e388 = frozen.inner[1];
    int _e392 = frozen.inner[2];
    out[static_cast<uint>(24)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e387) + as_type<uint>(_e388))) + as_type<uint>(_e392));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = float {};
    float _e406 = floating.y;
    out[static_cast<uint>(25)] = as_type<int>(_e406);
    float _e412 = floating.z;
    out[static_cast<uint>(26)] = as_type<int>(_e412);
    int3_ _e418 = make_list(6);
    from_call = _e418;
    int _e422 = from_call.x;
    int _e423 = from_call.z;
    out[static_cast<uint>(27)] = as_type<int>(as_type<uint>(_e422) + as_type<uint>(_e423));
    out[static_cast<uint>(28)] = naga_f2i32(Scale * 10.0);
    int _e437 = list_sum(as_type<int>(as_type<uint>(seed_2) + as_type<uint>(3)));
    out[static_cast<uint>(29)] = _e437;
}
