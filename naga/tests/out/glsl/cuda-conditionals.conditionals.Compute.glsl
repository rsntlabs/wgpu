#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std430) readonly buffer type_1_block_2Compute { int _group_0_binding_2_cs[]; };

layout(std140) uniform type_3_block_3Compute { type_3 _group_0_binding_3_cs; };

shared int shared_values[64];


int shifted(int value_1) {
    return (value_1 + 10);
}

void discard_(int value_2) {
    int value_3 = 0;
    value_3 = value_2;
    int _e3 = value_3;
    value_3 = (_e3 + 1);
    return;
}

int pair(int x, int y) {
    return ((x * 10) + y);
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = int[64](0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    }
    memoryBarrierShared();
    barrier();
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    bool choose_a = false;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int local_3 = 0;
    int a = 0;
    int b = 0;
    uint local_4 = 0u;
    int local_5 = 0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    int index_a = 0;
    int index_b = 0;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    int local_14 = 0;
    uint local_15 = 0u;
    int local_16 = 0;
    uint local_17 = 0u;
    int c = 0;
    uint local_18 = 0u;
    int local_19 = 0;
    uint local_20 = 0u;
    int condition = 0;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint lane = 0u;
    int local_value = 0;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    float local_27 = 0.0;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    bool local_31 = false;
    uint local_32 = 0u;
    int local_33 = 0;
    uint local_34 = 0u;
    uint local_35 = 0u;
    int shift_value = 0;
    uint local_36 = 0u;
    int local_37 = 0;
    uint local_38 = 0u;
    int value = 0;
    int other = 0;
    uint local_39 = 0u;
    int local_40 = 0;
    int count = 0;
    int left = 0;
    int right = 0;
    uint local_41 = 0u;
    int local_42 = 0;
    int local_43 = 0;
    uint local_44 = 0u;
    int local_45 = 0;
    uint local_46 = 0u;
    int local_47 = 0;
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
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint n_1 = _group_0_binding_3_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 25u);
        choose_a = ((i - 2u * (i / 2u)) == 0u);
        bool _e19 = choose_a;
        if (_e19) {
            local_1 = uint(i);
            uint _e22 = local_1;
            local_44 = uint(_e22);
            uint _e25 = local_44;
            int _e28 = _group_0_binding_1_cs[_e25];
            local_45 = _e28;
            int _e30 = local_45;
            local_42 = _e30;
            int _e32 = local_42;
            local_3 = _e32;
        } else {
            local_2 = uint(i);
            uint _e36 = local_2;
            local_46 = uint(_e36);
            uint _e39 = local_46;
            int _e42 = _group_0_binding_2_cs[_e39];
            local_47 = _e42;
            int _e44 = local_47;
            local_43 = _e44;
            int _e46 = local_43;
            local_3 = _e46;
        }
        int _e49 = local_3;
        uint _e50 = base;
        local = uint(_e50);
        uint _e53 = local;
        local_48 = uint(_e53);
        uint _e56 = local_48;
        _group_0_binding_0_cs[_e56] = _e49;
        a = 3;
        b = 5;
        bool _e63 = choose_a;
        if (_e63) {
            int _e64 = a;
            a = (_e64 + 1);
            int _e67 = shifted(_e64);
            local_5 = _e67;
        } else {
            int _e69 = b;
            b = (_e69 + 1);
            int _e72 = shifted(_e69);
            local_5 = _e72;
        }
        int _e75 = local_5;
        uint _e76 = base;
        local_4 = uint((_e76 + 1u));
        uint _e81 = local_4;
        local_49 = uint(_e81);
        uint _e84 = local_49;
        _group_0_binding_0_cs[_e84] = _e75;
        int _e86 = a;
        int _e89 = b;
        uint _e91 = base;
        local_6 = uint((_e91 + 2u));
        uint _e96 = local_6;
        local_50 = uint(_e96);
        uint _e99 = local_50;
        _group_0_binding_0_cs[_e99] = ((_e86 * 10) + _e89);
        bool _e101 = choose_a;
        if (_e101) {
            int _e102 = a;
            a = (_e102 + 1);
            discard_(_e102);
        } else {
            int _e105 = b;
            b = (_e105 + 1);
            discard_(_e105);
        }
        int _e108 = a;
        int _e111 = b;
        uint _e113 = base;
        local_7 = uint((_e113 + 3u));
        uint _e118 = local_7;
        local_51 = uint(_e118);
        uint _e121 = local_51;
        _group_0_binding_0_cs[_e121] = ((_e108 * 10) + _e111);
        index_a = 0;
        index_b = 0;
        bool _e127 = choose_a;
        if (_e127) {
            int _e128 = index_a;
            index_a = (_e128 + 1);
            local_8 = uint(_e128);
        } else {
            int _e133 = index_b;
            index_b = (_e133 + 1);
            local_9 = uint(_e133);
        }
        int _e138 = index_a;
        int _e141 = index_b;
        uint _e143 = base;
        local_10 = uint((_e143 + 4u));
        uint _e148 = local_10;
        local_52 = uint(_e148);
        uint _e151 = local_52;
        _group_0_binding_0_cs[_e151] = ((_e138 * 10) + _e141);
        a = 3;
        b = 5;
        bool _e155 = choose_a;
        if (_e155) {
            a = 7;
        } else {
            b = 7;
        }
        int _e158 = a;
        int _e161 = b;
        uint _e163 = base;
        local_11 = uint((_e163 + 5u));
        uint _e168 = local_11;
        local_53 = uint(_e168);
        uint _e171 = local_53;
        _group_0_binding_0_cs[_e171] = ((_e158 * 10) + _e161);
        bool _e173 = choose_a;
        if (_e173) {
            int _e174 = a;
            a = (_e174 + 2);
        } else {
            int _e177 = b;
            b = (_e177 + 2);
        }
        int _e180 = a;
        int _e183 = b;
        uint _e185 = base;
        local_12 = uint((_e185 + 6u));
        uint _e190 = local_12;
        local_54 = uint(_e190);
        uint _e193 = local_54;
        _group_0_binding_0_cs[_e193] = ((_e180 * 10) + _e183);
        bool _e195 = choose_a;
        if (_e195) {
            int _e196 = a;
            a = (_e196 + 1);
            int _e199 = a;
            local_14 = _e199;
        } else {
            int _e201 = b;
            b = (_e201 + 1);
            int _e204 = b;
            local_14 = _e204;
        }
        int _e207 = local_14;
        uint _e208 = base;
        local_13 = uint((_e208 + 7u));
        uint _e213 = local_13;
        local_55 = uint(_e213);
        uint _e216 = local_55;
        _group_0_binding_0_cs[_e216] = _e207;
        bool _e218 = choose_a;
        if (_e218) {
            int _e219 = a;
            a = (_e219 + 1);
            local_16 = _e219;
        } else {
            int _e223 = b;
            b = (_e223 + 1);
            local_16 = _e223;
        }
        int _e228 = local_16;
        uint _e229 = base;
        local_15 = uint((_e229 + 8u));
        uint _e234 = local_15;
        local_56 = uint(_e234);
        uint _e237 = local_56;
        _group_0_binding_0_cs[_e237] = _e228;
        int _e239 = a;
        int _e242 = b;
        uint _e244 = base;
        local_17 = uint((_e244 + 9u));
        uint _e249 = local_17;
        local_57 = uint(_e249);
        uint _e252 = local_57;
        _group_0_binding_0_cs[_e252] = ((_e239 * 100) + _e242);
        bool _e254 = choose_a;
        c = int(_e254);
        b = 7;
        int _e258 = c;
        if ((_e258 != 0)) {
            c = 0;
            int _e262 = c;
            c = (_e262 + 1);
            local_19 = _e262;
        } else {
            b = 0;
            int _e267 = b;
            b = (_e267 + 1);
            local_19 = _e267;
        }
        int _e272 = local_19;
        uint _e273 = base;
        local_18 = uint((_e273 + 10u));
        uint _e278 = local_18;
        local_58 = uint(_e278);
        uint _e281 = local_58;
        _group_0_binding_0_cs[_e281] = _e272;
        int _e283 = c;
        int _e286 = b;
        uint _e288 = base;
        local_20 = uint((_e288 + 11u));
        uint _e293 = local_20;
        local_59 = uint(_e293);
        uint _e296 = local_59;
        _group_0_binding_0_cs[_e296] = ((_e283 * 10) + _e286);
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e303 = condition;
        int _e304 = condition;
        if ((_e304 != 0)) {
            a = _e303;
        } else {
            b = _e303;
        }
        int _e307 = a;
        int _e310 = b;
        uint _e312 = base;
        local_21 = uint((_e312 + 12u));
        uint _e317 = local_21;
        local_60 = uint(_e317);
        uint _e320 = local_60;
        _group_0_binding_0_cs[_e320] = ((_e307 * 10) + _e310);
        a = 2;
        b = 4;
        c = 6;
        bool _e325 = choose_a;
        if (_e325) {
            if (((i - 4u * (i / 4u)) == 0u)) {
                int _e330 = a;
                a = (_e330 + 3);
            } else {
                int _e333 = b;
                b = (_e333 + 3);
            }
        } else {
            int _e336 = c;
            c = (_e336 + 3);
        }
        int _e339 = a;
        int _e342 = b;
        int _e346 = c;
        uint _e348 = base;
        local_22 = uint((_e348 + 13u));
        uint _e353 = local_22;
        local_61 = uint(_e353);
        uint _e356 = local_61;
        _group_0_binding_0_cs[_e356] = (((_e339 * 100) + (_e342 * 10)) + _e346);
        lane = threadIdx.x;
        uint _e360 = lane;
        shared_values[_e360] = 20;
        local_value = 10;
        bool _e366 = choose_a;
        if (_e366) {
            int _e367 = local_value;
            local_value = (_e367 + 5);
        } else {
            uint _e370 = lane;
            int _e372 = shared_values[_e370];
            shared_values[_e370] = (_e372 + 5);
        }
        int _e375 = local_value;
        uint _e378 = lane;
        int _e380 = shared_values[_e378];
        uint _e382 = base;
        local_23 = uint((_e382 + 14u));
        uint _e387 = local_23;
        local_62 = uint(_e387);
        uint _e390 = local_62;
        _group_0_binding_0_cs[_e390] = ((_e375 * 100) + _e380);
        bool _e392 = choose_a;
        if (_e392) {
            uint _e393 = lane;
            shared_values[_e393] = 30;
        } else {
            uint _e396 = base;
            local_24 = uint((_e396 + 15u));
            uint _e401 = local_24;
            local_63 = uint(_e401);
            uint _e404 = local_63;
            _group_0_binding_0_cs[_e404] = 30;
        }
        uint _e407 = lane;
        int _e409 = shared_values[_e407];
        uint _e410 = base;
        local_25 = uint((_e410 + 16u));
        uint _e415 = local_25;
        local_64 = uint(_e415);
        uint _e418 = local_64;
        _group_0_binding_0_cs[_e418] = _e409;
        bool _e420 = choose_a;
        if (_e420) {
            local_27 = 1.5;
        } else {
            local_27 = float(3);
        }
        float _e427 = local_27;
        uint _e428 = base;
        local_26 = uint((_e428 + 17u));
        uint _e434 = local_26;
        local_65 = uint(_e434);
        uint _e437 = local_65;
        _group_0_binding_0_cs[_e437] = int(_e427);
        bool _e439 = choose_a;
        if (_e439) {
            local_29 = uint(-(1));
        } else {
            local_29 = 2u;
        }
        uint _e447 = local_29;
        uint _e448 = base;
        local_28 = uint((_e448 + 18u));
        uint _e454 = local_28;
        local_66 = uint(_e454);
        uint _e457 = local_66;
        _group_0_binding_0_cs[_e457] = int(_e447);
        bool _e459 = choose_a;
        if (_e459) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e465 = local_31;
        uint _e466 = base;
        local_30 = uint((_e466 + 19u));
        uint _e472 = local_30;
        local_67 = uint(_e472);
        uint _e475 = local_67;
        _group_0_binding_0_cs[_e475] = int(_e465);
        bool _e477 = choose_a;
        if (_e477) {
            local_33 = int(true);
        } else {
            local_33 = 2;
        }
        int _e484 = local_33;
        uint _e485 = base;
        local_32 = uint((_e485 + 20u));
        uint _e490 = local_32;
        local_68 = uint(_e490);
        uint _e493 = local_68;
        _group_0_binding_0_cs[_e493] = _e484;
        bool _e495 = choose_a;
        if (_e495) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e501 = local_35;
        uint _e502 = base;
        local_34 = uint((_e502 + 21u));
        uint _e508 = local_34;
        local_69 = uint(_e508);
        uint _e511 = local_69;
        _group_0_binding_0_cs[_e511] = int(_e501);
        a = 3;
        shift_value = 2;
        bool _e516 = choose_a;
        if (_e516) {
            int _e517 = shift_value;
            local_37 = _e517;
        } else {
            int _e519 = a;
            local_37 = _e519;
        }
        int _e522 = local_37;
        shift_value = 1;
        int _e524 = shift_value;
        local_38 = uint(_e524);
        uint _e527 = local_38;
        uint _e529 = base;
        local_36 = uint((_e529 + 22u));
        uint _e534 = local_36;
        local_70 = uint(_e534);
        uint _e537 = local_70;
        _group_0_binding_0_cs[_e537] = (_e522 << _e527);
        value = 3;
        other = 7;
        bool _e543 = choose_a;
        if (_e543) {
            int _e544 = value;
            local_40 = _e544;
        } else {
            int _e546 = other;
            local_40 = _e546;
        }
        int _e549 = local_40;
        int _e550 = value;
        value = (_e550 + 1);
        int _e553 = pair(_e549, _e550);
        uint _e554 = base;
        local_39 = uint((_e554 + 23u));
        uint _e559 = local_39;
        local_71 = uint(_e559);
        uint _e562 = local_71;
        _group_0_binding_0_cs[_e562] = _e553;
        count = 0;
        left = 0;
        right = 0;
        {
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    bool _e579 = choose_a;
                    if (_e579) {
                        int _e580 = left;
                        left = (_e580 + 1);
                    } else {
                        int _e583 = right;
                        right = (_e583 + 1);
                    }
                }
                loop_init = false;
                int _e570 = count;
                if ((_e570 < 3)) {
                } else {
                    break;
                }
                int _e573 = count;
                count = (_e573 + 1);
                int _e576 = count;
                if ((_e576 == 2)) {
                    continue;
                }
            }
        }
        int _e586 = left;
        int _e589 = right;
        int _e593 = count;
        uint _e595 = base;
        local_41 = uint((_e595 + 24u));
        uint _e600 = local_41;
        local_72 = uint(_e600);
        uint _e603 = local_72;
        _group_0_binding_0_cs[_e603] = (((_e586 * 100) + (_e589 * 10)) + _e593);
    }
}

