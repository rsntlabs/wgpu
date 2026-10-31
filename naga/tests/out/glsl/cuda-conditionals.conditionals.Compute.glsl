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
            local_1 = i;
            uint _e21 = local_1;
            local_44 = _e21;
            uint _e23 = local_44;
            int _e26 = _group_0_binding_1_cs[_e23];
            local_45 = _e26;
            int _e28 = local_45;
            local_42 = _e28;
            int _e30 = local_42;
            local_3 = _e30;
        } else {
            local_2 = i;
            uint _e33 = local_2;
            local_46 = _e33;
            uint _e35 = local_46;
            int _e38 = _group_0_binding_2_cs[_e35];
            local_47 = _e38;
            int _e40 = local_47;
            local_43 = _e40;
            int _e42 = local_43;
            local_3 = _e42;
        }
        int _e45 = local_3;
        uint _e46 = base;
        local = _e46;
        uint _e48 = local;
        local_48 = _e48;
        uint _e50 = local_48;
        _group_0_binding_0_cs[_e50] = _e45;
        a = 3;
        b = 5;
        bool _e57 = choose_a;
        if (_e57) {
            int _e58 = a;
            a = (_e58 + 1);
            int _e61 = shifted(_e58);
            local_5 = _e61;
        } else {
            int _e63 = b;
            b = (_e63 + 1);
            int _e66 = shifted(_e63);
            local_5 = _e66;
        }
        int _e69 = local_5;
        uint _e70 = base;
        local_4 = uint((_e70 + 1u));
        uint _e75 = local_4;
        local_49 = _e75;
        uint _e77 = local_49;
        _group_0_binding_0_cs[_e77] = _e69;
        int _e79 = a;
        int _e82 = b;
        uint _e84 = base;
        local_6 = uint((_e84 + 2u));
        uint _e89 = local_6;
        local_50 = _e89;
        uint _e91 = local_50;
        _group_0_binding_0_cs[_e91] = ((_e79 * 10) + _e82);
        bool _e93 = choose_a;
        if (_e93) {
            int _e94 = a;
            a = (_e94 + 1);
            discard_(_e94);
        } else {
            int _e97 = b;
            b = (_e97 + 1);
            discard_(_e97);
        }
        int _e100 = a;
        int _e103 = b;
        uint _e105 = base;
        local_7 = uint((_e105 + 3u));
        uint _e110 = local_7;
        local_51 = _e110;
        uint _e112 = local_51;
        _group_0_binding_0_cs[_e112] = ((_e100 * 10) + _e103);
        index_a = 0;
        index_b = 0;
        bool _e118 = choose_a;
        if (_e118) {
            int _e119 = index_a;
            index_a = (_e119 + 1);
            local_8 = uint(_e119);
        } else {
            int _e124 = index_b;
            index_b = (_e124 + 1);
            local_9 = uint(_e124);
        }
        int _e129 = index_a;
        int _e132 = index_b;
        uint _e134 = base;
        local_10 = uint((_e134 + 4u));
        uint _e139 = local_10;
        local_52 = _e139;
        uint _e141 = local_52;
        _group_0_binding_0_cs[_e141] = ((_e129 * 10) + _e132);
        a = 3;
        b = 5;
        bool _e145 = choose_a;
        if (_e145) {
            a = 7;
        } else {
            b = 7;
        }
        int _e148 = a;
        int _e151 = b;
        uint _e153 = base;
        local_11 = uint((_e153 + 5u));
        uint _e158 = local_11;
        local_53 = _e158;
        uint _e160 = local_53;
        _group_0_binding_0_cs[_e160] = ((_e148 * 10) + _e151);
        bool _e162 = choose_a;
        if (_e162) {
            int _e163 = a;
            a = (_e163 + 2);
        } else {
            int _e166 = b;
            b = (_e166 + 2);
        }
        int _e169 = a;
        int _e172 = b;
        uint _e174 = base;
        local_12 = uint((_e174 + 6u));
        uint _e179 = local_12;
        local_54 = _e179;
        uint _e181 = local_54;
        _group_0_binding_0_cs[_e181] = ((_e169 * 10) + _e172);
        bool _e183 = choose_a;
        if (_e183) {
            int _e184 = a;
            a = (_e184 + 1);
            int _e187 = a;
            local_14 = _e187;
        } else {
            int _e189 = b;
            b = (_e189 + 1);
            int _e192 = b;
            local_14 = _e192;
        }
        int _e195 = local_14;
        uint _e196 = base;
        local_13 = uint((_e196 + 7u));
        uint _e201 = local_13;
        local_55 = _e201;
        uint _e203 = local_55;
        _group_0_binding_0_cs[_e203] = _e195;
        bool _e205 = choose_a;
        if (_e205) {
            int _e206 = a;
            a = (_e206 + 1);
            local_16 = _e206;
        } else {
            int _e210 = b;
            b = (_e210 + 1);
            local_16 = _e210;
        }
        int _e215 = local_16;
        uint _e216 = base;
        local_15 = uint((_e216 + 8u));
        uint _e221 = local_15;
        local_56 = _e221;
        uint _e223 = local_56;
        _group_0_binding_0_cs[_e223] = _e215;
        int _e225 = a;
        int _e228 = b;
        uint _e230 = base;
        local_17 = uint((_e230 + 9u));
        uint _e235 = local_17;
        local_57 = _e235;
        uint _e237 = local_57;
        _group_0_binding_0_cs[_e237] = ((_e225 * 100) + _e228);
        bool _e239 = choose_a;
        c = int(_e239);
        b = 7;
        int _e243 = c;
        if ((_e243 != 0)) {
            c = 0;
            int _e247 = c;
            c = (_e247 + 1);
            local_19 = _e247;
        } else {
            b = 0;
            int _e252 = b;
            b = (_e252 + 1);
            local_19 = _e252;
        }
        int _e257 = local_19;
        uint _e258 = base;
        local_18 = uint((_e258 + 10u));
        uint _e263 = local_18;
        local_58 = _e263;
        uint _e265 = local_58;
        _group_0_binding_0_cs[_e265] = _e257;
        int _e267 = c;
        int _e270 = b;
        uint _e272 = base;
        local_20 = uint((_e272 + 11u));
        uint _e277 = local_20;
        local_59 = _e277;
        uint _e279 = local_59;
        _group_0_binding_0_cs[_e279] = ((_e267 * 10) + _e270);
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e286 = condition;
        int _e287 = condition;
        if ((_e287 != 0)) {
            a = _e286;
        } else {
            b = _e286;
        }
        int _e290 = a;
        int _e293 = b;
        uint _e295 = base;
        local_21 = uint((_e295 + 12u));
        uint _e300 = local_21;
        local_60 = _e300;
        uint _e302 = local_60;
        _group_0_binding_0_cs[_e302] = ((_e290 * 10) + _e293);
        a = 2;
        b = 4;
        c = 6;
        bool _e307 = choose_a;
        if (_e307) {
            if (((i - 4u * (i / 4u)) == 0u)) {
                int _e312 = a;
                a = (_e312 + 3);
            } else {
                int _e315 = b;
                b = (_e315 + 3);
            }
        } else {
            int _e318 = c;
            c = (_e318 + 3);
        }
        int _e321 = a;
        int _e324 = b;
        int _e328 = c;
        uint _e330 = base;
        local_22 = uint((_e330 + 13u));
        uint _e335 = local_22;
        local_61 = _e335;
        uint _e337 = local_61;
        _group_0_binding_0_cs[_e337] = (((_e321 * 100) + (_e324 * 10)) + _e328);
        lane = threadIdx.x;
        uint _e341 = lane;
        shared_values[_e341] = 20;
        local_value = 10;
        bool _e347 = choose_a;
        if (_e347) {
            int _e348 = local_value;
            local_value = (_e348 + 5);
        } else {
            uint _e351 = lane;
            int _e353 = shared_values[_e351];
            shared_values[_e351] = (_e353 + 5);
        }
        int _e356 = local_value;
        uint _e359 = lane;
        int _e361 = shared_values[_e359];
        uint _e363 = base;
        local_23 = uint((_e363 + 14u));
        uint _e368 = local_23;
        local_62 = _e368;
        uint _e370 = local_62;
        _group_0_binding_0_cs[_e370] = ((_e356 * 100) + _e361);
        bool _e372 = choose_a;
        if (_e372) {
            uint _e373 = lane;
            shared_values[_e373] = 30;
        } else {
            uint _e376 = base;
            local_24 = uint((_e376 + 15u));
            uint _e381 = local_24;
            local_63 = _e381;
            uint _e383 = local_63;
            _group_0_binding_0_cs[_e383] = 30;
        }
        uint _e386 = lane;
        int _e388 = shared_values[_e386];
        uint _e389 = base;
        local_25 = uint((_e389 + 16u));
        uint _e394 = local_25;
        local_64 = _e394;
        uint _e396 = local_64;
        _group_0_binding_0_cs[_e396] = _e388;
        bool _e398 = choose_a;
        if (_e398) {
            local_27 = 1.5;
        } else {
            local_27 = float(3);
        }
        float _e405 = local_27;
        uint _e406 = base;
        local_26 = uint((_e406 + 17u));
        uint _e412 = local_26;
        local_65 = _e412;
        uint _e414 = local_65;
        _group_0_binding_0_cs[_e414] = int(_e405);
        bool _e416 = choose_a;
        if (_e416) {
            local_29 = uint(-(1));
        } else {
            local_29 = 2u;
        }
        uint _e424 = local_29;
        uint _e425 = base;
        local_28 = uint((_e425 + 18u));
        uint _e431 = local_28;
        local_66 = _e431;
        uint _e433 = local_66;
        _group_0_binding_0_cs[_e433] = int(_e424);
        bool _e435 = choose_a;
        if (_e435) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e441 = local_31;
        uint _e442 = base;
        local_30 = uint((_e442 + 19u));
        uint _e448 = local_30;
        local_67 = _e448;
        uint _e450 = local_67;
        _group_0_binding_0_cs[_e450] = int(_e441);
        bool _e452 = choose_a;
        if (_e452) {
            local_33 = int(true);
        } else {
            local_33 = 2;
        }
        int _e459 = local_33;
        uint _e460 = base;
        local_32 = uint((_e460 + 20u));
        uint _e465 = local_32;
        local_68 = _e465;
        uint _e467 = local_68;
        _group_0_binding_0_cs[_e467] = _e459;
        bool _e469 = choose_a;
        if (_e469) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e475 = local_35;
        uint _e476 = base;
        local_34 = uint((_e476 + 21u));
        uint _e482 = local_34;
        local_69 = _e482;
        uint _e484 = local_69;
        _group_0_binding_0_cs[_e484] = int(_e475);
        a = 3;
        shift_value = 2;
        bool _e489 = choose_a;
        if (_e489) {
            int _e490 = shift_value;
            local_37 = _e490;
        } else {
            int _e492 = a;
            local_37 = _e492;
        }
        int _e495 = local_37;
        shift_value = 1;
        int _e497 = shift_value;
        local_38 = uint(_e497);
        uint _e500 = local_38;
        uint _e502 = base;
        local_36 = uint((_e502 + 22u));
        uint _e507 = local_36;
        local_70 = _e507;
        uint _e509 = local_70;
        _group_0_binding_0_cs[_e509] = (_e495 << _e500);
        value = 3;
        other = 7;
        bool _e515 = choose_a;
        if (_e515) {
            int _e516 = value;
            local_40 = _e516;
        } else {
            int _e518 = other;
            local_40 = _e518;
        }
        int _e521 = local_40;
        int _e522 = value;
        value = (_e522 + 1);
        int _e525 = pair(_e521, _e522);
        uint _e526 = base;
        local_39 = uint((_e526 + 23u));
        uint _e531 = local_39;
        local_71 = _e531;
        uint _e533 = local_71;
        _group_0_binding_0_cs[_e533] = _e525;
        count = 0;
        left = 0;
        right = 0;
        {
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    bool _e550 = choose_a;
                    if (_e550) {
                        int _e551 = left;
                        left = (_e551 + 1);
                    } else {
                        int _e554 = right;
                        right = (_e554 + 1);
                    }
                }
                loop_init = false;
                int _e541 = count;
                if ((_e541 < 3)) {
                } else {
                    break;
                }
                int _e544 = count;
                count = (_e544 + 1);
                int _e547 = count;
                if ((_e547 == 2)) {
                    continue;
                }
            }
        }
        int _e557 = left;
        int _e560 = right;
        int _e564 = count;
        uint _e566 = base;
        local_41 = uint((_e566 + 24u));
        uint _e571 = local_41;
        local_72 = _e571;
        uint _e573 = local_72;
        _group_0_binding_0_cs[_e573] = (((_e557 * 100) + (_e560 * 10)) + _e564);
    }
}

