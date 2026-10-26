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
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    return (_e3 + 10);
}

void discard_(int value_3) {
    int value_4 = 0;
    value_4 = value_3;
    int _e3 = value_4;
    value_4 = (_e3 + 1);
    return;
}

int pair(int x, int y) {
    int x_1 = 0;
    int y_1 = 0;
    x_1 = x;
    y_1 = y;
    int _e5 = x_1;
    int _e7 = y_1;
    return ((_e5 * 10) + _e7);
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = int[64](0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    }
    memoryBarrierShared();
    barrier();
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    bool choose_a = false;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int local_12 = 0;
    int a = 0;
    int b = 0;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    int local_16 = 0;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    int index_a = 0;
    int index_b = 0;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    int local_41 = 0;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    int local_45 = 0;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    int c = 0;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    int local_52 = 0;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    int condition = 0;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint lane = 0u;
    int local_value = 0;
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
    uint local_73 = 0u;
    float local_74 = 0.0;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81 = 0u;
    bool local_82 = false;
    uint local_83 = 0u;
    uint local_84 = 0u;
    uint local_85 = 0u;
    int local_86 = 0;
    uint local_87 = 0u;
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90 = 0u;
    int shift_value = 0;
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93 = 0u;
    int local_94 = 0;
    uint local_95 = 0u;
    int value = 0;
    int other = 0;
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98 = 0u;
    int local_99 = 0;
    int count = 0;
    int left = 0;
    int right = 0;
    uint local_100 = 0u;
    uint local_101 = 0u;
    uint local_102 = 0u;
    uint local_103 = 0u;
    int local_104 = 0;
    uint local_105 = 0u;
    int local_106 = 0;
    uint local_107 = 0u;
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110 = 0u;
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113 = 0u;
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116 = 0u;
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119 = 0u;
    uint local_120 = 0u;
    uint local_121 = 0u;
    uint local_122 = 0u;
    uint local_123 = 0u;
    uint local_124 = 0u;
    uint local_125 = 0u;
    uint local_126 = 0u;
    uint local_127 = 0u;
    uint local_128 = 0u;
    uint local_129 = 0u;
    uint local_130 = 0u;
    uint local_131 = 0u;
    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    uint _e10 = _group_0_binding_3_cs.value;
    n = _e10;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e18 = i;
    uint _e19 = n;
    if ((_e18 < _e19)) {
        uint _e21 = i;
        base = (_e21 * 25u);
        uint _e25 = i;
        choose_a = ((_e25 - 2u * (_e25 / 2u)) == 0u);
        bool _e31 = choose_a;
        if (_e31) {
            uint _e32 = local_1;
            local_6 = _e32;
            uint _e34 = local_6;
            local_7 = uint(_e34);
            uint _e37 = i;
            local_8 = uint(_e37);
            uint _e41 = local_7;
            uint _e42 = local_8;
            local_103 = uint((_e41 + _e42));
            uint _e47 = local_103;
            int _e49 = _group_0_binding_1_cs[_e47];
            local_104 = _e49;
            int _e50 = local_104;
            local_12 = _e50;
        } else {
            uint _e52 = local_2;
            local_9 = _e52;
            uint _e54 = local_9;
            local_10 = uint(_e54);
            uint _e57 = i;
            local_11 = uint(_e57);
            uint _e61 = local_10;
            uint _e62 = local_11;
            local_105 = uint((_e61 + _e62));
            uint _e67 = local_105;
            int _e69 = _group_0_binding_2_cs[_e67];
            local_106 = _e69;
            int _e70 = local_106;
            local_12 = _e70;
        }
        int _e73 = local_12;
        uint _e74 = local;
        local_3 = _e74;
        uint _e76 = local_3;
        local_4 = uint(_e76);
        uint _e79 = base;
        local_5 = uint(_e79);
        uint _e83 = local_4;
        uint _e84 = local_5;
        local_107 = uint((_e83 + _e84));
        uint _e88 = local_107;
        _group_0_binding_0_cs[_e88] = _e73;
        a = 3;
        b = 5;
        bool _e94 = choose_a;
        if (_e94) {
            int _e95 = a;
            a = (_e95 + 1);
            int _e98 = shifted(_e95);
            local_16 = _e98;
        } else {
            int _e100 = b;
            b = (_e100 + 1);
            int _e103 = shifted(_e100);
            local_16 = _e103;
        }
        int _e106 = local_16;
        uint _e107 = local;
        local_13 = _e107;
        uint _e109 = local_13;
        local_14 = uint(_e109);
        uint _e112 = base;
        local_15 = uint((_e112 + 1u));
        uint _e117 = local_14;
        uint _e118 = local_15;
        local_108 = uint((_e117 + _e118));
        uint _e122 = local_108;
        _group_0_binding_0_cs[_e122] = _e106;
        int _e124 = a;
        int _e127 = b;
        uint _e129 = local;
        local_17 = _e129;
        uint _e131 = local_17;
        local_18 = uint(_e131);
        uint _e134 = base;
        local_19 = uint((_e134 + 2u));
        uint _e139 = local_18;
        uint _e140 = local_19;
        local_109 = uint((_e139 + _e140));
        uint _e144 = local_109;
        _group_0_binding_0_cs[_e144] = ((_e124 * 10) + _e127);
        bool _e146 = choose_a;
        if (_e146) {
            int _e147 = a;
            a = (_e147 + 1);
            discard_(_e147);
        } else {
            int _e150 = b;
            b = (_e150 + 1);
            discard_(_e150);
        }
        int _e153 = a;
        int _e156 = b;
        uint _e158 = local;
        local_20 = _e158;
        uint _e160 = local_20;
        local_21 = uint(_e160);
        uint _e163 = base;
        local_22 = uint((_e163 + 3u));
        uint _e168 = local_21;
        uint _e169 = local_22;
        local_110 = uint((_e168 + _e169));
        uint _e173 = local_110;
        _group_0_binding_0_cs[_e173] = ((_e153 * 10) + _e156);
        index_a = 0;
        index_b = 0;
        bool _e179 = choose_a;
        if (_e179) {
            uint _e180 = local_1;
            local_23 = _e180;
            uint _e182 = local_23;
            local_24 = uint(_e182);
            int _e185 = index_a;
            index_a = (_e185 + 1);
            local_25 = uint(_e185);
        } else {
            uint _e190 = local_2;
            local_26 = _e190;
            uint _e192 = local_26;
            local_27 = uint(_e192);
            int _e195 = index_b;
            index_b = (_e195 + 1);
            local_28 = uint(_e195);
        }
        int _e200 = index_a;
        int _e203 = index_b;
        uint _e205 = local;
        local_29 = _e205;
        uint _e207 = local_29;
        local_30 = uint(_e207);
        uint _e210 = base;
        local_31 = uint((_e210 + 4u));
        uint _e215 = local_30;
        uint _e216 = local_31;
        local_111 = uint((_e215 + _e216));
        uint _e220 = local_111;
        _group_0_binding_0_cs[_e220] = ((_e200 * 10) + _e203);
        a = 3;
        b = 5;
        bool _e224 = choose_a;
        if (_e224) {
            a = 7;
        } else {
            b = 7;
        }
        int _e227 = a;
        int _e230 = b;
        uint _e232 = local;
        local_32 = _e232;
        uint _e234 = local_32;
        local_33 = uint(_e234);
        uint _e237 = base;
        local_34 = uint((_e237 + 5u));
        uint _e242 = local_33;
        uint _e243 = local_34;
        local_112 = uint((_e242 + _e243));
        uint _e247 = local_112;
        _group_0_binding_0_cs[_e247] = ((_e227 * 10) + _e230);
        bool _e249 = choose_a;
        if (_e249) {
            int _e250 = a;
            a = (_e250 + 2);
        } else {
            int _e253 = b;
            b = (_e253 + 2);
        }
        int _e256 = a;
        int _e259 = b;
        uint _e261 = local;
        local_35 = _e261;
        uint _e263 = local_35;
        local_36 = uint(_e263);
        uint _e266 = base;
        local_37 = uint((_e266 + 6u));
        uint _e271 = local_36;
        uint _e272 = local_37;
        local_113 = uint((_e271 + _e272));
        uint _e276 = local_113;
        _group_0_binding_0_cs[_e276] = ((_e256 * 10) + _e259);
        bool _e278 = choose_a;
        if (_e278) {
            int _e279 = a;
            a = (_e279 + 1);
            int _e282 = a;
            local_41 = _e282;
        } else {
            int _e284 = b;
            b = (_e284 + 1);
            int _e287 = b;
            local_41 = _e287;
        }
        int _e290 = local_41;
        uint _e291 = local;
        local_38 = _e291;
        uint _e293 = local_38;
        local_39 = uint(_e293);
        uint _e296 = base;
        local_40 = uint((_e296 + 7u));
        uint _e301 = local_39;
        uint _e302 = local_40;
        local_114 = uint((_e301 + _e302));
        uint _e306 = local_114;
        _group_0_binding_0_cs[_e306] = _e290;
        bool _e308 = choose_a;
        if (_e308) {
            int _e309 = a;
            a = (_e309 + 1);
            local_45 = _e309;
        } else {
            int _e313 = b;
            b = (_e313 + 1);
            local_45 = _e313;
        }
        int _e318 = local_45;
        uint _e319 = local;
        local_42 = _e319;
        uint _e321 = local_42;
        local_43 = uint(_e321);
        uint _e324 = base;
        local_44 = uint((_e324 + 8u));
        uint _e329 = local_43;
        uint _e330 = local_44;
        local_115 = uint((_e329 + _e330));
        uint _e334 = local_115;
        _group_0_binding_0_cs[_e334] = _e318;
        int _e336 = a;
        int _e339 = b;
        uint _e341 = local;
        local_46 = _e341;
        uint _e343 = local_46;
        local_47 = uint(_e343);
        uint _e346 = base;
        local_48 = uint((_e346 + 9u));
        uint _e351 = local_47;
        uint _e352 = local_48;
        local_116 = uint((_e351 + _e352));
        uint _e356 = local_116;
        _group_0_binding_0_cs[_e356] = ((_e336 * 100) + _e339);
        bool _e358 = choose_a;
        c = int(_e358);
        b = 7;
        int _e362 = c;
        if ((_e362 != 0)) {
            c = 0;
            int _e366 = c;
            c = (_e366 + 1);
            local_52 = _e366;
        } else {
            b = 0;
            int _e371 = b;
            b = (_e371 + 1);
            local_52 = _e371;
        }
        int _e376 = local_52;
        uint _e377 = local;
        local_49 = _e377;
        uint _e379 = local_49;
        local_50 = uint(_e379);
        uint _e382 = base;
        local_51 = uint((_e382 + 10u));
        uint _e387 = local_50;
        uint _e388 = local_51;
        local_117 = uint((_e387 + _e388));
        uint _e392 = local_117;
        _group_0_binding_0_cs[_e392] = _e376;
        int _e394 = c;
        int _e397 = b;
        uint _e399 = local;
        local_53 = _e399;
        uint _e401 = local_53;
        local_54 = uint(_e401);
        uint _e404 = base;
        local_55 = uint((_e404 + 11u));
        uint _e409 = local_54;
        uint _e410 = local_55;
        local_118 = uint((_e409 + _e410));
        uint _e414 = local_118;
        _group_0_binding_0_cs[_e414] = ((_e394 * 10) + _e397);
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e421 = condition;
        int _e422 = condition;
        if ((_e422 != 0)) {
            a = _e421;
        } else {
            b = _e421;
        }
        int _e425 = a;
        int _e428 = b;
        uint _e430 = local;
        local_56 = _e430;
        uint _e432 = local_56;
        local_57 = uint(_e432);
        uint _e435 = base;
        local_58 = uint((_e435 + 12u));
        uint _e440 = local_57;
        uint _e441 = local_58;
        local_119 = uint((_e440 + _e441));
        uint _e445 = local_119;
        _group_0_binding_0_cs[_e445] = ((_e425 * 10) + _e428);
        a = 2;
        b = 4;
        c = 6;
        bool _e450 = choose_a;
        if (_e450) {
            uint _e451 = i;
            if (((_e451 - 4u * (_e451 / 4u)) == 0u)) {
                int _e456 = a;
                a = (_e456 + 3);
            } else {
                int _e459 = b;
                b = (_e459 + 3);
            }
        } else {
            int _e462 = c;
            c = (_e462 + 3);
        }
        int _e465 = a;
        int _e468 = b;
        int _e472 = c;
        uint _e474 = local;
        local_59 = _e474;
        uint _e476 = local_59;
        local_60 = uint(_e476);
        uint _e479 = base;
        local_61 = uint((_e479 + 13u));
        uint _e484 = local_60;
        uint _e485 = local_61;
        local_120 = uint((_e484 + _e485));
        uint _e489 = local_120;
        _group_0_binding_0_cs[_e489] = (((_e465 * 100) + (_e468 * 10)) + _e472);
        lane = threadIdx.x;
        uint _e493 = lane;
        shared_values[_e493] = 20;
        local_value = 10;
        bool _e499 = choose_a;
        if (_e499) {
            int _e500 = local_value;
            local_value = (_e500 + 5);
        } else {
            uint _e503 = lane;
            int _e505 = shared_values[_e503];
            shared_values[_e503] = (_e505 + 5);
        }
        int _e508 = local_value;
        uint _e511 = lane;
        int _e513 = shared_values[_e511];
        uint _e515 = local;
        local_62 = _e515;
        uint _e517 = local_62;
        local_63 = uint(_e517);
        uint _e520 = base;
        local_64 = uint((_e520 + 14u));
        uint _e525 = local_63;
        uint _e526 = local_64;
        local_121 = uint((_e525 + _e526));
        uint _e530 = local_121;
        _group_0_binding_0_cs[_e530] = ((_e508 * 100) + _e513);
        bool _e532 = choose_a;
        if (_e532) {
            uint _e533 = lane;
            shared_values[_e533] = 30;
        } else {
            uint _e536 = local;
            local_65 = _e536;
            uint _e538 = local_65;
            local_66 = uint(_e538);
            uint _e541 = base;
            local_67 = uint((_e541 + 15u));
            uint _e546 = local_66;
            uint _e547 = local_67;
            local_122 = uint((_e546 + _e547));
            uint _e552 = local_122;
            _group_0_binding_0_cs[_e552] = 30;
        }
        uint _e554 = lane;
        int _e556 = shared_values[_e554];
        uint _e557 = local;
        local_68 = _e557;
        uint _e559 = local_68;
        local_69 = uint(_e559);
        uint _e562 = base;
        local_70 = uint((_e562 + 16u));
        uint _e567 = local_69;
        uint _e568 = local_70;
        local_123 = uint((_e567 + _e568));
        uint _e572 = local_123;
        _group_0_binding_0_cs[_e572] = _e556;
        bool _e574 = choose_a;
        if (_e574) {
            local_74 = 1.5;
        } else {
            local_74 = float(3);
        }
        float _e581 = local_74;
        uint _e582 = local;
        local_71 = _e582;
        uint _e584 = local_71;
        local_72 = uint(_e584);
        uint _e587 = base;
        local_73 = uint((_e587 + 17u));
        uint _e593 = local_72;
        uint _e594 = local_73;
        local_124 = uint((_e593 + _e594));
        uint _e598 = local_124;
        _group_0_binding_0_cs[_e598] = int(_e581);
        bool _e600 = choose_a;
        if (_e600) {
            local_78 = uint(-(1));
        } else {
            local_78 = 2u;
        }
        uint _e608 = local_78;
        uint _e609 = local;
        local_75 = _e609;
        uint _e611 = local_75;
        local_76 = uint(_e611);
        uint _e614 = base;
        local_77 = uint((_e614 + 18u));
        uint _e620 = local_76;
        uint _e621 = local_77;
        local_125 = uint((_e620 + _e621));
        uint _e625 = local_125;
        _group_0_binding_0_cs[_e625] = int(_e608);
        bool _e627 = choose_a;
        if (_e627) {
            local_82 = true;
        } else {
            local_82 = false;
        }
        bool _e633 = local_82;
        uint _e634 = local;
        local_79 = _e634;
        uint _e636 = local_79;
        local_80 = uint(_e636);
        uint _e639 = base;
        local_81 = uint((_e639 + 19u));
        uint _e645 = local_80;
        uint _e646 = local_81;
        local_126 = uint((_e645 + _e646));
        uint _e650 = local_126;
        _group_0_binding_0_cs[_e650] = int(_e633);
        bool _e652 = choose_a;
        if (_e652) {
            local_86 = int(true);
        } else {
            local_86 = 2;
        }
        int _e659 = local_86;
        uint _e660 = local;
        local_83 = _e660;
        uint _e662 = local_83;
        local_84 = uint(_e662);
        uint _e665 = base;
        local_85 = uint((_e665 + 20u));
        uint _e670 = local_84;
        uint _e671 = local_85;
        local_127 = uint((_e670 + _e671));
        uint _e675 = local_127;
        _group_0_binding_0_cs[_e675] = _e659;
        bool _e677 = choose_a;
        if (_e677) {
            local_90 = 4u;
        } else {
            local_90 = 8u;
        }
        uint _e683 = local_90;
        uint _e684 = local;
        local_87 = _e684;
        uint _e686 = local_87;
        local_88 = uint(_e686);
        uint _e689 = base;
        local_89 = uint((_e689 + 21u));
        uint _e695 = local_88;
        uint _e696 = local_89;
        local_128 = uint((_e695 + _e696));
        uint _e700 = local_128;
        _group_0_binding_0_cs[_e700] = int(_e683);
        a = 3;
        shift_value = 2;
        bool _e705 = choose_a;
        if (_e705) {
            int _e706 = shift_value;
            local_94 = _e706;
        } else {
            int _e708 = a;
            local_94 = _e708;
        }
        int _e711 = local_94;
        shift_value = 1;
        int _e713 = shift_value;
        local_95 = uint(_e713);
        uint _e716 = local_95;
        uint _e718 = local;
        local_91 = _e718;
        uint _e720 = local_91;
        local_92 = uint(_e720);
        uint _e723 = base;
        local_93 = uint((_e723 + 22u));
        uint _e728 = local_92;
        uint _e729 = local_93;
        local_129 = uint((_e728 + _e729));
        uint _e733 = local_129;
        _group_0_binding_0_cs[_e733] = (_e711 << _e716);
        value = 3;
        other = 7;
        bool _e739 = choose_a;
        if (_e739) {
            int _e740 = value;
            local_99 = _e740;
        } else {
            int _e742 = other;
            local_99 = _e742;
        }
        int _e745 = local_99;
        int _e746 = value;
        value = (_e746 + 1);
        int _e749 = pair(_e745, _e746);
        uint _e750 = local;
        local_96 = _e750;
        uint _e752 = local_96;
        local_97 = uint(_e752);
        uint _e755 = base;
        local_98 = uint((_e755 + 23u));
        uint _e760 = local_97;
        uint _e761 = local_98;
        local_130 = uint((_e760 + _e761));
        uint _e765 = local_130;
        _group_0_binding_0_cs[_e765] = _e749;
        count = 0;
        left = 0;
        right = 0;
        {
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    bool _e782 = choose_a;
                    if (_e782) {
                        int _e783 = left;
                        left = (_e783 + 1);
                    } else {
                        int _e786 = right;
                        right = (_e786 + 1);
                    }
                }
                loop_init = false;
                int _e773 = count;
                if ((_e773 < 3)) {
                } else {
                    break;
                }
                int _e776 = count;
                count = (_e776 + 1);
                int _e779 = count;
                if ((_e779 == 2)) {
                    continue;
                }
            }
        }
        int _e789 = left;
        int _e792 = right;
        int _e796 = count;
        uint _e798 = local;
        local_100 = _e798;
        uint _e800 = local_100;
        local_101 = uint(_e800);
        uint _e803 = base;
        local_102 = uint((_e803 + 24u));
        uint _e808 = local_101;
        uint _e809 = local_102;
        local_131 = uint((_e808 + _e809));
        uint _e813 = local_131;
        _group_0_binding_0_cs[_e813] = (((_e789 * 100) + (_e792 * 10)) + _e796);
    }
}

