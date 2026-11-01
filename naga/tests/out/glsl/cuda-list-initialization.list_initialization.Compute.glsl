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
const int Global = 2;
const float Scale = 0.5;

layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };


int pair(int first, int second) {
    return ((first * 10) + second);
}

int list_sum(int seed) {
    int values_1[3] = int[3](0, 0, 0);
    uint local_4 = 0u;
    values_1[0] = seed;
    values_1[1] = (seed + 1);
    local_4 = 2u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e13 = local_4;
            local_4 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_4;
        if ((_e8 >= 3u)) {
            break;
        }
        values_1[_e8] = 0;
    }
    int _e20 = values_1[0];
    int _e21 = values_1[1];
    int _e25 = values_1[2];
    return ((_e20 + _e21) + _e25);
}

int3_ make_list(int seed_1) {
    int3_ value = int3_(0, 0, 0);
    value.x = seed_1;
    value.y = (seed_1 + 1);
    value.z = (seed_1 + 2);
    int3_ _e9 = value;
    return _e9;
}

void main() {
    int zero = 0;
    int copy_zero = 0;
    bool enabled = false;
    float sample_ = 0.0;
    int Local = 0;
    int Safe = 0;
    int local = 0;
    int safe_values[3] = int[3](0, 0, 0);
    uint local_1 = 0u;
    int values[3] = int[3](0, 0, 0);
    int changed[3] = int[3](0, 0, 0);
    int3_ point = int3_(0, 0, 0);
    int3_ changed_point = int3_(0, 0, 0);
    int3_ nested[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    ivec2 flat_[2] = ivec2[2](ivec2(0), ivec2(0));
    int3_ original = int3_(0, 0, 0);
    int3_ copied = int3_(0, 0, 0);
    int3_ copies[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    int counter = 0;
    int ordered[3] = int[3](0, 0, 0);
    int zero_total = 0;
    int iteration = 0;
    int reset[3] = int[3](0, 0, 0);
    uint local_2 = 0u;
    int total = 0;
    int iteration_1 = 0;
    int limit = 0;
    int Number = 0;
    int cached[2] = int[2](0, 0);
    int frozen[3] = int[3](0, 0, 0);
    uint local_3 = 0u;
    float3_ floating = float3_(0.0, 0.0, 0.0);
    int3_ from_call = int3_(0, 0, 0);
    int seed_2 = _group_0_binding_0_cs[uint(0)];
    zero = 0;
    copy_zero = 0;
    enabled = true;
    uint count = uint(7);
    sample_ = 1.5;
    Local = 3;
    Safe = 3;
    safe_values[0] = 1;
    local_1 = 1u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e29 = local_1;
            local_1 = (_e29 + 1u);
        }
        loop_init_1 = false;
        uint _e24 = local_1;
        if ((_e24 >= 3u)) {
            break;
        }
        safe_values[_e24] = 0;
    }
    int _e32 = zero;
    _group_0_binding_0_cs[uint(0)] = _e32;
    int _e36 = copy_zero;
    _group_0_binding_0_cs[uint(1)] = _e36;
    bool _e40 = enabled;
    _group_0_binding_0_cs[uint(2)] = int(_e40);
    _group_0_binding_0_cs[uint(3)] = int(count);
    float _e49 = sample_;
    _group_0_binding_0_cs[uint(4)] = int((_e49 * 2.0));
    int _e56 = Local;
    _group_0_binding_0_cs[uint(5)] = (Global + _e56);
    int _e64 = safe_values[2];
    _group_0_binding_0_cs[uint(6)] = _e64;
    values[0] = 1;
    int _e74 = values[0];
    values[1] = (_e74 + 1);
    int _e80 = values[1];
    values[2] = (_e80 + 1);
    int _e87 = values[0];
    int _e88 = values[1];
    int _e92 = values[2];
    _group_0_binding_0_cs[uint(7)] = ((_e87 + _e88) + _e92);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e108 = changed[0];
    changed[2] = _e108;
    int _e111 = changed[0];
    _group_0_binding_0_cs[uint(8)] = _e111;
    int _e117 = changed[2];
    _group_0_binding_0_cs[uint(9)] = _e117;
    point.x = 1;
    int _e125 = point.x;
    point.y = (_e125 + 1);
    int _e130 = point.y;
    point.z = (_e130 + 1);
    int _e135 = point.z;
    _group_0_binding_0_cs[uint(10)] = _e135;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e147 = changed_point.x;
    changed_point.z = _e147;
    int _e150 = changed_point.x;
    _group_0_binding_0_cs[uint(11)] = _e150;
    int _e155 = changed_point.z;
    _group_0_binding_0_cs[uint(12)] = _e155;
    nested[0].x = 1;
    nested[0].y = 2;
    nested[0].z = 0;
    nested[1].x = 3;
    nested[1].y = 0;
    nested[1].z = 0;
    int _e180 = nested[0].z;
    int _e181 = nested[1].x;
    _group_0_binding_0_cs[uint(13)] = (_e180 + _e181);
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e203 = flat_[0].x;
    int _e204 = flat_[0].y;
    int _e209 = flat_[1].x;
    int _e214 = flat_[1].y;
    _group_0_binding_0_cs[uint(14)] = (((_e203 + _e204) + _e209) + _e214);
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e226 = original;
    copied = _e226;
    int3_ _e230 = original;
    copies[0] = _e230;
    copies[1].x = 5;
    copies[1].y = 6;
    copies[1].z = 0;
    original.x = 99;
    int _e241 = copied.x;
    _group_0_binding_0_cs[uint(15)] = _e241;
    int _e248 = copies[0].x;
    _group_0_binding_0_cs[uint(16)] = _e248;
    int _e255 = copies[1].z;
    _group_0_binding_0_cs[uint(17)] = _e255;
    counter = seed_2;
    int _e262 = counter;
    counter = (_e262 + 1);
    ordered[0] = _e262;
    int _e266 = counter;
    counter = (_e266 + 1);
    ordered[1] = _e266;
    int _e270 = counter;
    ordered[2] = _e270;
    int _e273 = ordered[0];
    int _e278 = ordered[1];
    int _e284 = ordered[2];
    _group_0_binding_0_cs[uint(18)] = (((_e273 * 100) + (_e278 * 10)) + _e284);
    int _e289 = counter;
    _group_0_binding_0_cs[uint(19)] = _e289;
    int _e293 = counter;
    counter = (_e293 + 1);
    int _e297 = pair(_e293, 4);
    _group_0_binding_0_cs[uint(20)] = _e297;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e329 = iteration;
                iteration = (_e329 + 1);
            }
            loop_init_2 = false;
            int _e305 = iteration;
            if ((_e305 < 3)) {
            } else {
                break;
            }
            int _e310 = iteration;
            reset[0] = _e310;
            local_2 = 1u;
            bool loop_init_3 = true;
            while(true) {
                if (!loop_init_3) {
                    uint _e318 = local_2;
                    local_2 = (_e318 + 1u);
                }
                loop_init_3 = false;
                uint _e313 = local_2;
                if ((_e313 >= 3u)) {
                    break;
                }
                reset[_e313] = 0;
            }
            int _e323 = reset[2];
            int _e324 = zero_total;
            zero_total = (_e324 + _e323);
            reset[2] = 9;
        }
    }
    int _e332 = zero_total;
    _group_0_binding_0_cs[uint(21)] = _e332;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                int _e348 = iteration_1;
                iteration_1 = (_e348 + 1);
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
            total = (_e346 + _e345);
        }
    }
    int _e351 = total;
    _group_0_binding_0_cs[uint(22)] = _e351;
    Number = 4;
    int _e359 = Number;
    cached[0] = _e359;
    int _e361 = Number;
    cached[1] = (_e361 + 1);
    int _e366 = cached[1];
    _group_0_binding_0_cs[uint(23)] = _e366;
    frozen[0] = 3;
    local_3 = 1u;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            uint _e380 = local_3;
            local_3 = (_e380 + 1u);
        }
        loop_init_5 = false;
        uint _e375 = local_3;
        if ((_e375 >= 3u)) {
            break;
        }
        frozen[_e375] = 0;
    }
    int _e387 = frozen[0];
    int _e388 = frozen[1];
    int _e392 = frozen[2];
    _group_0_binding_0_cs[uint(24)] = ((_e387 + _e388) + _e392);
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = 0.0;
    float _e406 = floating.y;
    _group_0_binding_0_cs[uint(25)] = floatBitsToInt(_e406);
    float _e412 = floating.z;
    _group_0_binding_0_cs[uint(26)] = floatBitsToInt(_e412);
    int3_ _e418 = make_list(6);
    from_call = _e418;
    int _e422 = from_call.x;
    int _e423 = from_call.z;
    _group_0_binding_0_cs[uint(27)] = (_e422 + _e423);
    _group_0_binding_0_cs[uint(28)] = int((Scale * 10.0));
    int _e437 = list_sum((seed_2 + 3));
    _group_0_binding_0_cs[uint(29)] = _e437;
}

