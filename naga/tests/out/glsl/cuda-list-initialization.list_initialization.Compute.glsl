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
    uint local_68 = 0u;
    values_1[0] = seed;
    values_1[1] = (seed + 1);
    local_68 = 2u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e13 = local_68;
            local_68 = (_e13 + 1u);
        }
        loop_init = false;
        uint _e8 = local_68;
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
    int local_35 = 0;
    uint local_36 = 0u;
    int local_37 = 0;
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
    uint local_66 = 0u;
    uint local_67 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_36 = uint(_e3);
    uint _e6 = local_36;
    int _e9 = _group_0_binding_0_cs[_e6];
    local_37 = _e9;
    int _e11 = local_37;
    local_35 = _e11;
    int seed_2 = local_35;
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
            uint _e38 = local_2;
            local_2 = (_e38 + 1u);
        }
        loop_init_1 = false;
        uint _e33 = local_2;
        if ((_e33 >= 3u)) {
            break;
        }
        safe_values[_e33] = 0;
    }
    int _e41 = zero;
    local_3 = uint(0);
    uint _e45 = local_3;
    local_38 = uint(_e45);
    uint _e48 = local_38;
    _group_0_binding_0_cs[_e48] = _e41;
    int _e50 = copy_zero;
    local_4 = uint(1);
    uint _e54 = local_4;
    local_39 = uint(_e54);
    uint _e57 = local_39;
    _group_0_binding_0_cs[_e57] = _e50;
    bool _e59 = enabled;
    local_5 = uint(2);
    uint _e64 = local_5;
    local_40 = uint(_e64);
    uint _e67 = local_40;
    _group_0_binding_0_cs[_e67] = int(_e59);
    local_6 = uint(3);
    uint _e73 = local_6;
    local_41 = uint(_e73);
    uint _e76 = local_41;
    _group_0_binding_0_cs[_e76] = int(count);
    float _e78 = sample_;
    local_7 = uint(4);
    uint _e85 = local_7;
    local_42 = uint(_e85);
    uint _e88 = local_42;
    _group_0_binding_0_cs[_e88] = int((_e78 * 2.0));
    int _e90 = Local;
    local_8 = uint(5);
    uint _e96 = local_8;
    local_43 = uint(_e96);
    uint _e99 = local_43;
    _group_0_binding_0_cs[_e99] = (Global + _e90);
    int _e103 = safe_values[2];
    local_9 = uint(6);
    uint _e107 = local_9;
    local_44 = uint(_e107);
    uint _e110 = local_44;
    _group_0_binding_0_cs[_e110] = _e103;
    values[0] = 1;
    int _e118 = values[0];
    values[1] = (_e118 + 1);
    int _e124 = values[1];
    values[2] = (_e124 + 1);
    int _e131 = values[0];
    int _e132 = values[1];
    int _e136 = values[2];
    local_10 = uint(7);
    uint _e141 = local_10;
    local_45 = uint(_e141);
    uint _e144 = local_45;
    _group_0_binding_0_cs[_e144] = ((_e131 + _e132) + _e136);
    changed[0] = 1;
    changed[0] = 7;
    changed[1] = 2;
    int _e157 = changed[0];
    changed[2] = _e157;
    int _e160 = changed[0];
    local_11 = uint(8);
    uint _e164 = local_11;
    local_46 = uint(_e164);
    uint _e167 = local_46;
    _group_0_binding_0_cs[_e167] = _e160;
    int _e171 = changed[2];
    local_12 = uint(9);
    uint _e175 = local_12;
    local_47 = uint(_e175);
    uint _e178 = local_47;
    _group_0_binding_0_cs[_e178] = _e171;
    point.x = 1;
    int _e184 = point.x;
    point.y = (_e184 + 1);
    int _e189 = point.y;
    point.z = (_e189 + 1);
    int _e194 = point.z;
    local_13 = uint(10);
    uint _e198 = local_13;
    local_48 = uint(_e198);
    uint _e201 = local_48;
    _group_0_binding_0_cs[_e201] = _e194;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e211 = changed_point.x;
    changed_point.z = _e211;
    int _e214 = changed_point.x;
    local_14 = uint(11);
    uint _e218 = local_14;
    local_49 = uint(_e218);
    uint _e221 = local_49;
    _group_0_binding_0_cs[_e221] = _e214;
    int _e224 = changed_point.z;
    local_15 = uint(12);
    uint _e228 = local_15;
    local_50 = uint(_e228);
    uint _e231 = local_50;
    _group_0_binding_0_cs[_e231] = _e224;
    nested[0].x = 1;
    nested[0].y = 2;
    nested[0].z = 0;
    nested[1].x = 3;
    nested[1].y = 0;
    nested[1].z = 0;
    int _e254 = nested[0].z;
    int _e255 = nested[1].x;
    local_16 = uint(13);
    uint _e260 = local_16;
    local_51 = uint(_e260);
    uint _e263 = local_51;
    _group_0_binding_0_cs[_e263] = (_e254 + _e255);
    flat_[0].x = 1;
    flat_[0].y = 2;
    flat_[1].x = 3;
    flat_[1].y = 0;
    int _e282 = flat_[0].x;
    int _e283 = flat_[0].y;
    int _e288 = flat_[1].x;
    int _e293 = flat_[1].y;
    local_17 = uint(14);
    uint _e298 = local_17;
    local_52 = uint(_e298);
    uint _e301 = local_52;
    _group_0_binding_0_cs[_e301] = (((_e282 + _e283) + _e288) + _e293);
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e310 = original;
    copied = _e310;
    int3_ _e314 = original;
    copies[0] = _e314;
    copies[1].x = 5;
    copies[1].y = 6;
    copies[1].z = 0;
    original.x = 99;
    int _e325 = copied.x;
    local_18 = uint(15);
    uint _e329 = local_18;
    local_53 = uint(_e329);
    uint _e332 = local_53;
    _group_0_binding_0_cs[_e332] = _e325;
    int _e337 = copies[0].x;
    local_19 = uint(16);
    uint _e341 = local_19;
    local_54 = uint(_e341);
    uint _e344 = local_54;
    _group_0_binding_0_cs[_e344] = _e337;
    int _e349 = copies[1].z;
    local_20 = uint(17);
    uint _e353 = local_20;
    local_55 = uint(_e353);
    uint _e356 = local_55;
    _group_0_binding_0_cs[_e356] = _e349;
    counter = seed_2;
    int _e361 = counter;
    counter = (_e361 + 1);
    ordered[0] = _e361;
    int _e365 = counter;
    counter = (_e365 + 1);
    ordered[1] = _e365;
    int _e369 = counter;
    ordered[2] = _e369;
    int _e372 = ordered[0];
    int _e377 = ordered[1];
    int _e383 = ordered[2];
    local_21 = uint(18);
    uint _e388 = local_21;
    local_56 = uint(_e388);
    uint _e391 = local_56;
    _group_0_binding_0_cs[_e391] = (((_e372 * 100) + (_e377 * 10)) + _e383);
    int _e393 = counter;
    local_22 = uint(19);
    uint _e397 = local_22;
    local_57 = uint(_e397);
    uint _e400 = local_57;
    _group_0_binding_0_cs[_e400] = _e393;
    int _e402 = counter;
    counter = (_e402 + 1);
    int _e406 = pair(_e402, 4);
    local_23 = uint(20);
    uint _e410 = local_23;
    local_58 = uint(_e410);
    uint _e413 = local_58;
    _group_0_binding_0_cs[_e413] = _e406;
    zero_total = 0;
    {
        iteration = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e443 = iteration;
                iteration = (_e443 + 1);
            }
            loop_init_2 = false;
            int _e419 = iteration;
            if ((_e419 < 3)) {
            } else {
                break;
            }
            int _e424 = iteration;
            reset[0] = _e424;
            local_24 = 1u;
            bool loop_init_3 = true;
            while(true) {
                if (!loop_init_3) {
                    uint _e432 = local_24;
                    local_24 = (_e432 + 1u);
                }
                loop_init_3 = false;
                uint _e427 = local_24;
                if ((_e427 >= 3u)) {
                    break;
                }
                reset[_e427] = 0;
            }
            int _e437 = reset[2];
            int _e438 = zero_total;
            zero_total = (_e438 + _e437);
            reset[2] = 9;
        }
    }
    int _e446 = zero_total;
    local_25 = uint(21);
    uint _e450 = local_25;
    local_59 = uint(_e450);
    uint _e453 = local_59;
    _group_0_binding_0_cs[_e453] = _e446;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                int _e467 = iteration_1;
                iteration_1 = (_e467 + 1);
            }
            loop_init_4 = false;
            int _e461 = iteration_1;
            int _e462 = limit;
            if ((_e461 < _e462)) {
            } else {
                break;
            }
            int _e464 = iteration_1;
            int _e465 = total;
            total = (_e465 + _e464);
        }
    }
    int _e470 = total;
    local_26 = uint(22);
    uint _e474 = local_26;
    local_60 = uint(_e474);
    uint _e477 = local_60;
    _group_0_binding_0_cs[_e477] = _e470;
    Number = 4;
    int _e483 = Number;
    cached[0] = _e483;
    int _e485 = Number;
    cached[1] = (_e485 + 1);
    int _e490 = cached[1];
    local_27 = uint(23);
    uint _e494 = local_27;
    local_61 = uint(_e494);
    uint _e497 = local_61;
    _group_0_binding_0_cs[_e497] = _e490;
    frozen[0] = 3;
    local_28 = 1u;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            uint _e509 = local_28;
            local_28 = (_e509 + 1u);
        }
        loop_init_5 = false;
        uint _e504 = local_28;
        if ((_e504 >= 3u)) {
            break;
        }
        frozen[_e504] = 0;
    }
    int _e516 = frozen[0];
    int _e517 = frozen[1];
    int _e521 = frozen[2];
    local_29 = uint(24);
    uint _e526 = local_29;
    local_62 = uint(_e526);
    uint _e529 = local_62;
    _group_0_binding_0_cs[_e529] = ((_e516 + _e517) + _e521);
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = 0.0;
    float _e540 = floating.y;
    local_30 = uint(25);
    uint _e545 = local_30;
    local_63 = uint(_e545);
    uint _e548 = local_63;
    _group_0_binding_0_cs[_e548] = floatBitsToInt(_e540);
    float _e551 = floating.z;
    local_31 = uint(26);
    uint _e556 = local_31;
    local_64 = uint(_e556);
    uint _e559 = local_64;
    _group_0_binding_0_cs[_e559] = floatBitsToInt(_e551);
    int3_ _e562 = make_list(6);
    from_call = _e562;
    int _e566 = from_call.x;
    int _e567 = from_call.z;
    local_32 = uint(27);
    uint _e572 = local_32;
    local_65 = uint(_e572);
    uint _e575 = local_65;
    _group_0_binding_0_cs[_e575] = (_e566 + _e567);
    local_33 = uint(28);
    uint _e584 = local_33;
    local_66 = uint(_e584);
    uint _e587 = local_66;
    _group_0_binding_0_cs[_e587] = int((Scale * 10.0));
    int _e591 = list_sum((seed_2 + 3));
    local_34 = uint(29);
    uint _e595 = local_34;
    local_67 = uint(_e595);
    uint _e598 = local_67;
    _group_0_binding_0_cs[_e598] = _e591;
}

