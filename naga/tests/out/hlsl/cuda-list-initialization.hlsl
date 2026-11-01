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

static const int Global = int(2);
static const float Scale = 0.5;

RWByteAddressBuffer out_ : register(u0);

int pair(int first, int second)
{
    return asint(asuint(asint(asuint(first) * asuint(int(10)))) + asuint(second));
}

int ZeroValueint() {
    return (int)0;
}

int list_sum(int seed)
{
    int values_1[3] = (int[3])0;
    uint local_4 = (uint)0;

    values_1[0] = seed;
    values_1[1] = asint(asuint(seed) + asuint(int(1)));
    local_4 = 2u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e13 = local_4;
            local_4 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_4;
        if ((_e8 >= 3u)) {
            break;
        }
        values_1[min(uint(_e8), 2u)] = ZeroValueint();
    }
    int _e20 = values_1[int(0)];
    int _e21 = values_1[int(1)];
    int _e25 = values_1[int(2)];
    return asint(asuint(asint(asuint(_e20) + asuint(_e21))) + asuint(_e25));
}

int3_ make_list(int seed_1)
{
    int3_ value = (int3_)0;

    value.x = seed_1;
    value.y = asint(asuint(seed_1) + asuint(int(1)));
    value.z = asint(asuint(seed_1) + asuint(int(2)));
    int3_ _e9 = value;
    const int3_ int3_1 = _e9;
    return int3_1;
}

float ZeroValuefloat() {
    return (float)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void list_initialization()
{
    int zero = (int)0;
    int copy_zero = (int)0;
    bool enabled = (bool)0;
    float sample_ = (float)0;
    int Local = (int)0;
    int Safe = (int)0;
    int local = (int)0;
    int safe_values[3] = (int[3])0;
    uint local_1 = (uint)0;
    int values[3] = (int[3])0;
    int changed[3] = (int[3])0;
    int3_ point_ = (int3_)0;
    int3_ changed_point = (int3_)0;
    int3_ nested[2] = (int3_[2])0;
    int2 flat[2] = (int2[2])0;
    int3_ original = (int3_)0;
    int3_ copied = (int3_)0;
    int3_ copies[2] = (int3_[2])0;
    int counter = (int)0;
    int ordered[3] = (int[3])0;
    int zero_total = (int)0;
    int iteration = (int)0;
    int reset[3] = (int[3])0;
    uint local_2 = (uint)0;
    int total = (int)0;
    int iteration_1 = (int)0;
    int limit = (int)0;
    int Number = (int)0;
    int cached[2] = (int[2])0;
    int frozen[3] = (int[3])0;
    uint local_3 = (uint)0;
    float3_ floating = (float3_)0;
    int3_ from_call = (int3_)0;

    int seed_2 = asint(out_.Load(uint(int(0))*4));
    zero = int(0);
    copy_zero = int(0);
    enabled = true;
    uint count = uint(int(7));
    sample_ = 1.5;
    Local = int(3);
    Safe = int(3);
    safe_values[0] = int(1);
    local_1 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e29 = local_1;
            local_1 = (_e29 + 1u);
        }
        loop_init_1 = false;
        uint _e24 = local_1;
        if ((_e24 >= 3u)) {
            break;
        }
        safe_values[min(uint(_e24), 2u)] = ZeroValueint();
    }
    int _e32 = zero;
    out_.Store(uint(int(0))*4, asuint(_e32));
    int _e36 = copy_zero;
    out_.Store(uint(int(1))*4, asuint(_e36));
    bool _e40 = enabled;
    out_.Store(uint(int(2))*4, asuint(int(_e40)));
    out_.Store(uint(int(3))*4, asuint(int(count)));
    float _e49 = sample_;
    out_.Store(uint(int(4))*4, asuint(naga_f2i32((_e49 * 2.0))));
    int _e56 = Local;
    out_.Store(uint(int(5))*4, asuint(asint(asuint(Global) + asuint(_e56))));
    int _e64 = safe_values[int(2)];
    out_.Store(uint(int(6))*4, asuint(_e64));
    values[0] = int(1);
    int _e74 = values[int(0)];
    values[1] = asint(asuint(_e74) + asuint(int(1)));
    int _e80 = values[int(1)];
    values[2] = asint(asuint(_e80) + asuint(int(1)));
    int _e87 = values[int(0)];
    int _e88 = values[int(1)];
    int _e92 = values[int(2)];
    out_.Store(uint(int(7))*4, asuint(asint(asuint(asint(asuint(_e87) + asuint(_e88))) + asuint(_e92))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e108 = changed[int(0)];
    changed[2] = _e108;
    int _e111 = changed[int(0)];
    out_.Store(uint(int(8))*4, asuint(_e111));
    int _e117 = changed[int(2)];
    out_.Store(uint(int(9))*4, asuint(_e117));
    point_.x = int(1);
    int _e125 = point_.x;
    point_.y = asint(asuint(_e125) + asuint(int(1)));
    int _e130 = point_.y;
    point_.z = asint(asuint(_e130) + asuint(int(1)));
    int _e135 = point_.z;
    out_.Store(uint(int(10))*4, asuint(_e135));
    changed_point.x = int(1);
    changed_point.x = int(9);
    changed_point.y = int(2);
    int _e147 = changed_point.x;
    changed_point.z = _e147;
    int _e150 = changed_point.x;
    out_.Store(uint(int(11))*4, asuint(_e150));
    int _e155 = changed_point.z;
    out_.Store(uint(int(12))*4, asuint(_e155));
    nested[0].x = int(1);
    nested[0].y = int(2);
    nested[0].z = ZeroValueint();
    nested[1].x = int(3);
    nested[1].y = ZeroValueint();
    nested[1].z = ZeroValueint();
    int _e180 = nested[int(0)].z;
    int _e181 = nested[int(1)].x;
    out_.Store(uint(int(13))*4, asuint(asint(asuint(_e180) + asuint(_e181))));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e203 = flat[int(0)].x;
    int _e204 = flat[int(0)].y;
    int _e209 = flat[int(1)].x;
    int _e214 = flat[int(1)].y;
    out_.Store(uint(int(14))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e203) + asuint(_e204))) + asuint(_e209))) + asuint(_e214))));
    original.x = int(2);
    original.y = int(3);
    original.z = int(4);
    int3_ _e226 = original;
    copied = _e226;
    int3_ _e230 = original;
    copies[0] = _e230;
    copies[1].x = int(5);
    copies[1].y = int(6);
    copies[1].z = ZeroValueint();
    original.x = int(99);
    int _e241 = copied.x;
    out_.Store(uint(int(15))*4, asuint(_e241));
    int _e248 = copies[int(0)].x;
    out_.Store(uint(int(16))*4, asuint(_e248));
    int _e255 = copies[int(1)].z;
    out_.Store(uint(int(17))*4, asuint(_e255));
    counter = seed_2;
    int _e262 = counter;
    counter = asint(asuint(_e262) + asuint(int(1)));
    ordered[0] = _e262;
    int _e266 = counter;
    counter = asint(asuint(_e266) + asuint(int(1)));
    ordered[1] = _e266;
    int _e270 = counter;
    ordered[2] = _e270;
    int _e273 = ordered[int(0)];
    int _e278 = ordered[int(1)];
    int _e284 = ordered[int(2)];
    out_.Store(uint(int(18))*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e273) * asuint(int(100)))) + asuint(asint(asuint(_e278) * asuint(int(10)))))) + asuint(_e284))));
    int _e289 = counter;
    out_.Store(uint(int(19))*4, asuint(_e289));
    int _e293 = counter;
    counter = asint(asuint(_e293) + asuint(int(1)));
    const int _e297 = pair(_e293, int(4));
    out_.Store(uint(int(20))*4, asuint(_e297));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e329 = iteration;
                iteration = asint(asuint(_e329) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e305 = iteration;
            if ((_e305 < int(3))) {
            } else {
                break;
            }
            int _e310 = iteration;
            reset[0] = _e310;
            local_2 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e318 = local_2;
                    local_2 = (_e318 + 1u);
                }
                loop_init_3 = false;
                uint _e313 = local_2;
                if ((_e313 >= 3u)) {
                    break;
                }
                reset[min(uint(_e313), 2u)] = ZeroValueint();
            }
            int _e323 = reset[int(2)];
            int _e324 = zero_total;
            zero_total = asint(asuint(_e324) + asuint(_e323));
            reset[int(2)] = int(9);
        }
    }
    int _e332 = zero_total;
    out_.Store(uint(int(21))*4, asuint(_e332));
    total = int(0);
    {
        iteration_1 = int(0);
        limit = int(3);
        uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                int _e348 = iteration_1;
                iteration_1 = asint(asuint(_e348) + asuint(int(1)));
            }
            loop_init_4 = false;
            int _e342 = iteration_1;
            int _e343 = limit;
            if ((_e342 < _e343)) {
            } else {
                break;
            }
            int _e345 = iteration_1;
            int _e346 = total;
            total = asint(asuint(_e346) + asuint(_e345));
        }
    }
    int _e351 = total;
    out_.Store(uint(int(22))*4, asuint(_e351));
    Number = int(4);
    int _e359 = Number;
    cached[0] = _e359;
    int _e361 = Number;
    cached[1] = asint(asuint(_e361) + asuint(int(1)));
    int _e366 = cached[int(1)];
    out_.Store(uint(int(23))*4, asuint(_e366));
    frozen[0] = int(3);
    local_3 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e380 = local_3;
            local_3 = (_e380 + 1u);
        }
        loop_init_5 = false;
        uint _e375 = local_3;
        if ((_e375 >= 3u)) {
            break;
        }
        frozen[min(uint(_e375), 2u)] = ZeroValueint();
    }
    int _e387 = frozen[int(0)];
    int _e388 = frozen[int(1)];
    int _e392 = frozen[int(2)];
    out_.Store(uint(int(24))*4, asuint(asint(asuint(asint(asuint(_e387) + asuint(_e388))) + asuint(_e392))));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = ZeroValuefloat();
    float _e406 = floating.y;
    out_.Store(uint(int(25))*4, asuint(asint(_e406)));
    float _e412 = floating.z;
    out_.Store(uint(int(26))*4, asuint(asint(_e412)));
    const int3_ _e418 = make_list(int(6));
    from_call = _e418;
    int _e422 = from_call.x;
    int _e423 = from_call.z;
    out_.Store(uint(int(27))*4, asuint(asint(asuint(_e422) + asuint(_e423))));
    out_.Store(uint(int(28))*4, asuint(naga_f2i32((Scale * 10.0))));
    const int _e437 = list_sum(asint(asuint(seed_2) + asuint(int(3))));
    out_.Store(uint(int(29))*4, asuint(_e437));
}
