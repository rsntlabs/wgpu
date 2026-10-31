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
    uint local_66 = 0u;
    values_1[0] = seed;
    values_1[1] = (seed + 1);
    local_66 = 2u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e13 = local_66;
            local_66 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_66;
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
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_35 = uint(_e3);
    uint _e6 = local_35;
    int seed_2 = _group_0_binding_0_cs[_e6];
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
            uint _e34 = local_2;
            local_2 = (_e34 + 1u);
        }
        loop_init_1 = false;
        uint _e29 = local_2;
        if ((_e29 >= 3u)) {
            break;
        }
        safe_values[_e29] = 0;
    }
    int _e37 = zero;
    local_3 = uint(0);
    uint _e41 = local_3;
    local_36 = uint(_e41);
    uint _e44 = local_36;
    _group_0_binding_0_cs[_e44] = _e37;
    int _e46 = copy_zero;
    local_4 = uint(1);
    uint _e50 = local_4;
    local_37 = uint(_e50);
    uint _e53 = local_37;
    _group_0_binding_0_cs[_e53] = _e46;
    bool _e55 = enabled;
    local_5 = uint(2);
    uint _e60 = local_5;
    local_38 = uint(_e60);
    uint _e63 = local_38;
    _group_0_binding_0_cs[_e63] = int(_e55);
    local_6 = uint(3);
    uint _e69 = local_6;
    local_39 = uint(_e69);
    uint _e72 = local_39;
    _group_0_binding_0_cs[_e72] = int(count);
    float _e74 = sample_;
    local_7 = uint(4);
    uint _e81 = local_7;
    local_40 = uint(_e81);
    uint _e84 = local_40;
    _group_0_binding_0_cs[_e84] = int((_e74 * 2.0));
    int _e86 = Local;
    local_8 = uint(5);
    uint _e92 = local_8;
    local_41 = uint(_e92);
    uint _e95 = local_41;
    _group_0_binding_0_cs[_e95] = (Global + _e86);
    int _e99 = safe_values[2];
    local_9 = uint(6);
    uint _e103 = local_9;
    local_42 = uint(_e103);
    uint _e106 = local_42;
    _group_0_binding_0_cs[_e106] = _e99;
    values[0] = 1;
    int _e114 = values[0];
    values[1] = (_e114 + 1);
    int _e120 = values[1];
    values[2] = (_e120 + 1);
    int _e127 = values[0];
    int _e128 = values[1];
    int _e132 = values[2];
    local_10 = uint(7);
    uint _e137 = local_10;
    local_43 = uint(_e137);
    uint _e140 = local_43;
    _group_0_binding_0_cs[_e140] = ((_e127 + _e128) + _e132);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e153 = changed[0];
    changed[2] = _e153;
    int _e156 = changed[0];
    local_11 = uint(8);
    uint _e160 = local_11;
    local_44 = uint(_e160);
    uint _e163 = local_44;
    _group_0_binding_0_cs[_e163] = _e156;
    int _e167 = changed[2];
    local_12 = uint(9);
    uint _e171 = local_12;
    local_45 = uint(_e171);
    uint _e174 = local_45;
    _group_0_binding_0_cs[_e174] = _e167;
    point.x = 1;
    int _e180 = point.x;
    point.y = (_e180 + 1);
    int _e185 = point.y;
    point.z = (_e185 + 1);
    int _e190 = point.z;
    local_13 = uint(10);
    uint _e194 = local_13;
    local_46 = uint(_e194);
    uint _e197 = local_46;
    _group_0_binding_0_cs[_e197] = _e190;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e207 = changed_point.x;
    changed_point.z = _e207;
    int _e210 = changed_point.x;
    local_14 = uint(11);
    uint _e214 = local_14;
    local_47 = uint(_e214);
    uint _e217 = local_47;
    _group_0_binding_0_cs[_e217] = _e210;
    int _e220 = changed_point.z;
    local_15 = uint(12);
    uint _e224 = local_15;
    local_48 = uint(_e224);
    uint _e227 = local_48;
    _group_0_binding_0_cs[_e227] = _e220;
    nested[0].x = 1;
    nested[0].y = 2;
    nested[0].z = 0;
    nested[1].x = 3;
    nested[1].y = 0;
    nested[1].z = 0;
    int _e250 = nested[0].z;
    int _e251 = nested[1].x;
    local_16 = uint(13);
    uint _e256 = local_16;
    local_49 = uint(_e256);
    uint _e259 = local_49;
    _group_0_binding_0_cs[_e259] = (_e250 + _e251);
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e278 = flat_[0].x;
    int _e279 = flat_[0].y;
    int _e284 = flat_[1].x;
    int _e289 = flat_[1].y;
    local_17 = uint(14);
    uint _e294 = local_17;
    local_50 = uint(_e294);
    uint _e297 = local_50;
    _group_0_binding_0_cs[_e297] = (((_e278 + _e279) + _e284) + _e289);
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e306 = original;
    copied = _e306;
    int3_ _e310 = original;
    copies[0] = _e310;
    copies[1].x = 5;
    copies[1].y = 6;
    copies[1].z = 0;
    original.x = 99;
    int _e321 = copied.x;
    local_18 = uint(15);
    uint _e325 = local_18;
    local_51 = uint(_e325);
    uint _e328 = local_51;
    _group_0_binding_0_cs[_e328] = _e321;
    int _e333 = copies[0].x;
    local_19 = uint(16);
    uint _e337 = local_19;
    local_52 = uint(_e337);
    uint _e340 = local_52;
    _group_0_binding_0_cs[_e340] = _e333;
    int _e345 = copies[1].z;
    local_20 = uint(17);
    uint _e349 = local_20;
    local_53 = uint(_e349);
    uint _e352 = local_53;
    _group_0_binding_0_cs[_e352] = _e345;
    counter = seed_2;
    int _e357 = counter;
    counter = (_e357 + 1);
    ordered[0] = _e357;
    int _e361 = counter;
    counter = (_e361 + 1);
    ordered[1] = _e361;
    int _e365 = counter;
    ordered[2] = _e365;
    int _e368 = ordered[0];
    int _e373 = ordered[1];
    int _e379 = ordered[2];
    local_21 = uint(18);
    uint _e384 = local_21;
    local_54 = uint(_e384);
    uint _e387 = local_54;
    _group_0_binding_0_cs[_e387] = (((_e368 * 100) + (_e373 * 10)) + _e379);
    int _e389 = counter;
    local_22 = uint(19);
    uint _e393 = local_22;
    local_55 = uint(_e393);
    uint _e396 = local_55;
    _group_0_binding_0_cs[_e396] = _e389;
    int _e398 = counter;
    counter = (_e398 + 1);
    int _e402 = pair(_e398, 4);
    local_23 = uint(20);
    uint _e406 = local_23;
    local_56 = uint(_e406);
    uint _e409 = local_56;
    _group_0_binding_0_cs[_e409] = _e402;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e439 = iteration;
                iteration = (_e439 + 1);
            }
            loop_init_2 = false;
            int _e415 = iteration;
            if ((_e415 < 3)) {
            } else {
                break;
            }
            int _e420 = iteration;
            reset[0] = _e420;
            local_24 = 1u;
            bool loop_init_3 = true;
            while(true) {
                if (!loop_init_3) {
                    uint _e428 = local_24;
                    local_24 = (_e428 + 1u);
                }
                loop_init_3 = false;
                uint _e423 = local_24;
                if ((_e423 >= 3u)) {
                    break;
                }
                reset[_e423] = 0;
            }
            int _e433 = reset[2];
            int _e434 = zero_total;
            zero_total = (_e434 + _e433);
            reset[2] = 9;
        }
    }
    int _e442 = zero_total;
    local_25 = uint(21);
    uint _e446 = local_25;
    local_57 = uint(_e446);
    uint _e449 = local_57;
    _group_0_binding_0_cs[_e449] = _e442;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                int _e463 = iteration_1;
                iteration_1 = (_e463 + 1);
            }
            loop_init_4 = false;
            int _e457 = iteration_1;
            int _e458 = limit;
            if ((_e457 < _e458)) {
            } else {
                break;
            }
            int _e460 = iteration_1;
            int _e461 = total;
            total = (_e461 + _e460);
        }
    }
    int _e466 = total;
    local_26 = uint(22);
    uint _e470 = local_26;
    local_58 = uint(_e470);
    uint _e473 = local_58;
    _group_0_binding_0_cs[_e473] = _e466;
    Number = 4;
    int _e479 = Number;
    cached[0] = _e479;
    int _e481 = Number;
    cached[1] = (_e481 + 1);
    int _e486 = cached[1];
    local_27 = uint(23);
    uint _e490 = local_27;
    local_59 = uint(_e490);
    uint _e493 = local_59;
    _group_0_binding_0_cs[_e493] = _e486;
    frozen[0] = 3;
    local_28 = 1u;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            uint _e505 = local_28;
            local_28 = (_e505 + 1u);
        }
        loop_init_5 = false;
        uint _e500 = local_28;
        if ((_e500 >= 3u)) {
            break;
        }
        frozen[_e500] = 0;
    }
    int _e512 = frozen[0];
    int _e513 = frozen[1];
    int _e517 = frozen[2];
    local_29 = uint(24);
    uint _e522 = local_29;
    local_60 = uint(_e522);
    uint _e525 = local_60;
    _group_0_binding_0_cs[_e525] = ((_e512 + _e513) + _e517);
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = 0.0;
    float _e536 = floating.y;
    local_30 = uint(25);
    uint _e541 = local_30;
    local_61 = uint(_e541);
    uint _e544 = local_61;
    _group_0_binding_0_cs[_e544] = floatBitsToInt(_e536);
    float _e547 = floating.z;
    local_31 = uint(26);
    uint _e552 = local_31;
    local_62 = uint(_e552);
    uint _e555 = local_62;
    _group_0_binding_0_cs[_e555] = floatBitsToInt(_e547);
    int3_ _e558 = make_list(6);
    from_call = _e558;
    int _e562 = from_call.x;
    int _e563 = from_call.z;
    local_32 = uint(27);
    uint _e568 = local_32;
    local_63 = uint(_e568);
    uint _e571 = local_63;
    _group_0_binding_0_cs[_e571] = (_e562 + _e563);
    local_33 = uint(28);
    uint _e580 = local_33;
    local_64 = uint(_e580);
    uint _e583 = local_64;
    _group_0_binding_0_cs[_e583] = int((Scale * 10.0));
    int _e587 = list_sum((seed_2 + 3));
    local_34 = uint(29);
    uint _e591 = local_34;
    local_65 = uint(_e591);
    uint _e594 = local_65;
    _group_0_binding_0_cs[_e594] = _e587;
}

