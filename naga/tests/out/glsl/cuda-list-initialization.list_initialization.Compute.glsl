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
    uint local_35 = 0u;
    values_1[0] = seed;
    values_1[1] = (seed + 1);
    local_35 = 2u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e13 = local_35;
            local_35 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_35;
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
    uint local = 0u;
    int zero = 0;
    int copy_zero = 0;
    bool enabled = false;
    float sample_ = 0.0;
    int Local = 0;
    int Safe = 0;
    int local_1 = 0;
    int safe_values[3] = int[3](0, 0, 0);
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    int values[3] = int[3](0, 0, 0);
    uint local_10 = 0u;
    int changed[3] = int[3](0, 0, 0);
    uint local_11 = 0u;
    uint local_12 = 0u;
    int3_ point = int3_(0, 0, 0);
    uint local_13 = 0u;
    int3_ changed_point = int3_(0, 0, 0);
    uint local_14 = 0u;
    uint local_15 = 0u;
    int3_ nested[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    uint local_16 = 0u;
    ivec2 flat_[2] = ivec2[2](ivec2(0), ivec2(0));
    uint local_17 = 0u;
    int3_ original = int3_(0, 0, 0);
    int3_ copied = int3_(0, 0, 0);
    int3_ copies[2] = int3_[2](int3_(0, 0, 0), int3_(0, 0, 0));
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    int counter = 0;
    int ordered[3] = int[3](0, 0, 0);
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    int zero_total = 0;
    int iteration = 0;
    int reset[3] = int[3](0, 0, 0);
    uint local_24 = 0u;
    uint local_25 = 0u;
    int total = 0;
    int iteration_1 = 0;
    int limit = 0;
    uint local_26 = 0u;
    int Number = 0;
    int cached[2] = int[2](0, 0);
    uint local_27 = 0u;
    int frozen[3] = int[3](0, 0, 0);
    uint local_28 = 0u;
    uint local_29 = 0u;
    float3_ floating = float3_(0.0, 0.0, 0.0);
    uint local_30 = 0u;
    uint local_31 = 0u;
    int3_ from_call = int3_(0, 0, 0);
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    local = uint(0);
    uint _e3 = local;
    int seed_2 = _group_0_binding_0_cs[_e3];
    zero = 0;
    copy_zero = 0;
    enabled = true;
    uint count = uint(7);
    sample_ = 1.5;
    Local = 3;
    Safe = 3;
    safe_values[0] = 1;
    local_2 = 1u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e31 = local_2;
            local_2 = (_e31 + 1u);
        }
        loop_init_1 = false;
        uint _e26 = local_2;
        if ((_e26 >= 3u)) {
            break;
        }
        safe_values[_e26] = 0;
    }
    int _e34 = zero;
    local_3 = uint(0);
    uint _e38 = local_3;
    _group_0_binding_0_cs[_e38] = _e34;
    int _e40 = copy_zero;
    local_4 = uint(1);
    uint _e44 = local_4;
    _group_0_binding_0_cs[_e44] = _e40;
    bool _e46 = enabled;
    local_5 = uint(2);
    uint _e51 = local_5;
    _group_0_binding_0_cs[_e51] = int(_e46);
    local_6 = uint(3);
    uint _e57 = local_6;
    _group_0_binding_0_cs[_e57] = int(count);
    float _e59 = sample_;
    local_7 = uint(4);
    uint _e66 = local_7;
    _group_0_binding_0_cs[_e66] = int((_e59 * 2.0));
    int _e68 = Local;
    local_8 = uint(5);
    uint _e74 = local_8;
    _group_0_binding_0_cs[_e74] = (Global + _e68);
    int _e78 = safe_values[2];
    local_9 = uint(6);
    uint _e82 = local_9;
    _group_0_binding_0_cs[_e82] = _e78;
    values[0] = 1;
    int _e90 = values[0];
    values[1] = (_e90 + 1);
    int _e96 = values[1];
    values[2] = (_e96 + 1);
    int _e103 = values[0];
    int _e104 = values[1];
    int _e108 = values[2];
    local_10 = uint(7);
    uint _e113 = local_10;
    _group_0_binding_0_cs[_e113] = ((_e103 + _e104) + _e108);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e126 = changed[0];
    changed[2] = _e126;
    int _e129 = changed[0];
    local_11 = uint(8);
    uint _e133 = local_11;
    _group_0_binding_0_cs[_e133] = _e129;
    int _e137 = changed[2];
    local_12 = uint(9);
    uint _e141 = local_12;
    _group_0_binding_0_cs[_e141] = _e137;
    point.x = 1;
    int _e147 = point.x;
    point.y = (_e147 + 1);
    int _e152 = point.y;
    point.z = (_e152 + 1);
    int _e157 = point.z;
    local_13 = uint(10);
    uint _e161 = local_13;
    _group_0_binding_0_cs[_e161] = _e157;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e171 = changed_point.x;
    changed_point.z = _e171;
    int _e174 = changed_point.x;
    local_14 = uint(11);
    uint _e178 = local_14;
    _group_0_binding_0_cs[_e178] = _e174;
    int _e181 = changed_point.z;
    local_15 = uint(12);
    uint _e185 = local_15;
    _group_0_binding_0_cs[_e185] = _e181;
    nested[0].x = 1;
    nested[0].y = 2;
    nested[0].z = 0;
    nested[1].x = 3;
    nested[1].y = 0;
    nested[1].z = 0;
    int _e208 = nested[0].z;
    int _e209 = nested[1].x;
    local_16 = uint(13);
    uint _e214 = local_16;
    _group_0_binding_0_cs[_e214] = (_e208 + _e209);
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e233 = flat_[0].x;
    int _e234 = flat_[0].y;
    int _e239 = flat_[1].x;
    int _e244 = flat_[1].y;
    local_17 = uint(14);
    uint _e249 = local_17;
    _group_0_binding_0_cs[_e249] = (((_e233 + _e234) + _e239) + _e244);
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e258 = original;
    copied = _e258;
    int3_ _e262 = original;
    copies[0] = _e262;
    copies[1].x = 5;
    copies[1].y = 6;
    copies[1].z = 0;
    original.x = 99;
    int _e273 = copied.x;
    local_18 = uint(15);
    uint _e277 = local_18;
    _group_0_binding_0_cs[_e277] = _e273;
    int _e282 = copies[0].x;
    local_19 = uint(16);
    uint _e286 = local_19;
    _group_0_binding_0_cs[_e286] = _e282;
    int _e291 = copies[1].z;
    local_20 = uint(17);
    uint _e295 = local_20;
    _group_0_binding_0_cs[_e295] = _e291;
    counter = seed_2;
    int _e300 = counter;
    counter = (_e300 + 1);
    ordered[0] = _e300;
    int _e304 = counter;
    counter = (_e304 + 1);
    ordered[1] = _e304;
    int _e308 = counter;
    ordered[2] = _e308;
    int _e311 = ordered[0];
    int _e316 = ordered[1];
    int _e322 = ordered[2];
    local_21 = uint(18);
    uint _e327 = local_21;
    _group_0_binding_0_cs[_e327] = (((_e311 * 100) + (_e316 * 10)) + _e322);
    int _e329 = counter;
    local_22 = uint(19);
    uint _e333 = local_22;
    _group_0_binding_0_cs[_e333] = _e329;
    int _e335 = counter;
    counter = (_e335 + 1);
    int _e339 = pair(_e335, 4);
    local_23 = uint(20);
    uint _e343 = local_23;
    _group_0_binding_0_cs[_e343] = _e339;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e373 = iteration;
                iteration = (_e373 + 1);
            }
            loop_init_2 = false;
            int _e349 = iteration;
            if ((_e349 < 3)) {
            } else {
                break;
            }
            int _e354 = iteration;
            reset[0] = _e354;
            local_24 = 1u;
            bool loop_init_3 = true;
            while(true) {
                if (!loop_init_3) {
                    uint _e362 = local_24;
                    local_24 = (_e362 + 1u);
                }
                loop_init_3 = false;
                uint _e357 = local_24;
                if ((_e357 >= 3u)) {
                    break;
                }
                reset[_e357] = 0;
            }
            int _e367 = reset[2];
            int _e368 = zero_total;
            zero_total = (_e368 + _e367);
            reset[2] = 9;
        }
    }
    int _e376 = zero_total;
    local_25 = uint(21);
    uint _e380 = local_25;
    _group_0_binding_0_cs[_e380] = _e376;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                int _e394 = iteration_1;
                iteration_1 = (_e394 + 1);
            }
            loop_init_4 = false;
            int _e388 = iteration_1;
            int _e389 = limit;
            if ((_e388 < _e389)) {
            } else {
                break;
            }
            int _e391 = iteration_1;
            int _e392 = total;
            total = (_e392 + _e391);
        }
    }
    int _e397 = total;
    local_26 = uint(22);
    uint _e401 = local_26;
    _group_0_binding_0_cs[_e401] = _e397;
    Number = 4;
    int _e407 = Number;
    cached[0] = _e407;
    int _e409 = Number;
    cached[1] = (_e409 + 1);
    int _e414 = cached[1];
    local_27 = uint(23);
    uint _e418 = local_27;
    _group_0_binding_0_cs[_e418] = _e414;
    frozen[0] = 3;
    local_28 = 1u;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            uint _e430 = local_28;
            local_28 = (_e430 + 1u);
        }
        loop_init_5 = false;
        uint _e425 = local_28;
        if ((_e425 >= 3u)) {
            break;
        }
        frozen[_e425] = 0;
    }
    int _e437 = frozen[0];
    int _e438 = frozen[1];
    int _e442 = frozen[2];
    local_29 = uint(24);
    uint _e447 = local_29;
    _group_0_binding_0_cs[_e447] = ((_e437 + _e438) + _e442);
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = 0.0;
    float _e458 = floating.y;
    local_30 = uint(25);
    uint _e463 = local_30;
    _group_0_binding_0_cs[_e463] = floatBitsToInt(_e458);
    float _e466 = floating.z;
    local_31 = uint(26);
    uint _e471 = local_31;
    _group_0_binding_0_cs[_e471] = floatBitsToInt(_e466);
    int3_ _e474 = make_list(6);
    from_call = _e474;
    int _e478 = from_call.x;
    int _e479 = from_call.z;
    local_32 = uint(27);
    uint _e484 = local_32;
    _group_0_binding_0_cs[_e484] = (_e478 + _e479);
    local_33 = uint(28);
    uint _e493 = local_33;
    _group_0_binding_0_cs[_e493] = int((Scale * 10.0));
    int _e497 = list_sum((seed_2 + 3));
    local_34 = uint(29);
    uint _e501 = local_34;
    _group_0_binding_0_cs[_e501] = _e497;
}

