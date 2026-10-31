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
    uint out_[2] = uint[2](0u, 0u);
    uint input_a[2] = uint[2](0u, 0u);
    uint input_b[2] = uint[2](0u, 0u);
    uint base = 0u;
    bool choose_a = false;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    int local_6 = 0;
    int a = 0;
    int b = 0;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    int local_9 = 0;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    int index_a = 0;
    int index_b = 0;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    int local_26 = 0;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    int local_29 = 0;
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31 = 0u;
    int c = 0;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    int local_34 = 0;
    uint local_35[2] = uint[2](0u, 0u);
    uint local_36 = 0u;
    int condition = 0;
    uint local_37[2] = uint[2](0u, 0u);
    uint local_38 = 0u;
    uint local_39[2] = uint[2](0u, 0u);
    uint local_40 = 0u;
    uint lane = 0u;
    int local_value = 0;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    uint local_43[2] = uint[2](0u, 0u);
    uint local_44 = 0u;
    uint local_45[2] = uint[2](0u, 0u);
    uint local_46 = 0u;
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    float local_49 = 0.0;
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53[2] = uint[2](0u, 0u);
    uint local_54 = 0u;
    bool local_55 = false;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57 = 0u;
    int local_58 = 0;
    uint local_59[2] = uint[2](0u, 0u);
    uint local_60 = 0u;
    uint local_61 = 0u;
    int shift_value = 0;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    int local_64 = 0;
    uint local_65 = 0u;
    int value = 0;
    int other = 0;
    uint local_66[2] = uint[2](0u, 0u);
    uint local_67 = 0u;
    int local_68 = 0;
    int count = 0;
    int left = 0;
    int right = 0;
    uint local_69[2] = uint[2](0u, 0u);
    uint local_70 = 0u;
    int local_71 = 0;
    int local_72 = 0;
    uint local_73[2] = uint[2](0u, 0u);
    uint local_74 = 0u;
    uint local_75 = 0u;
    int local_76 = 0;
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    int local_80 = 0;
    uint local_81[2] = uint[2](0u, 0u);
    uint local_82 = 0u;
    uint local_83 = 0u;
    uint local_84[2] = uint[2](0u, 0u);
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87[2] = uint[2](0u, 0u);
    uint local_88 = 0u;
    uint local_89 = 0u;
    uint local_90[2] = uint[2](0u, 0u);
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93[2] = uint[2](0u, 0u);
    uint local_94 = 0u;
    uint local_95 = 0u;
    uint local_96[2] = uint[2](0u, 0u);
    uint local_97 = 0u;
    uint local_98 = 0u;
    uint local_99[2] = uint[2](0u, 0u);
    uint local_100 = 0u;
    uint local_101 = 0u;
    uint local_102[2] = uint[2](0u, 0u);
    uint local_103 = 0u;
    uint local_104 = 0u;
    uint local_105[2] = uint[2](0u, 0u);
    uint local_106 = 0u;
    uint local_107 = 0u;
    uint local_108[2] = uint[2](0u, 0u);
    uint local_109 = 0u;
    uint local_110 = 0u;
    uint local_111[2] = uint[2](0u, 0u);
    uint local_112 = 0u;
    uint local_113 = 0u;
    uint local_114[2] = uint[2](0u, 0u);
    uint local_115 = 0u;
    uint local_116 = 0u;
    uint local_117[2] = uint[2](0u, 0u);
    uint local_118 = 0u;
    uint local_119 = 0u;
    uint local_120[2] = uint[2](0u, 0u);
    uint local_121 = 0u;
    uint local_122 = 0u;
    uint local_123[2] = uint[2](0u, 0u);
    uint local_124 = 0u;
    uint local_125 = 0u;
    uint local_126[2] = uint[2](0u, 0u);
    uint local_127 = 0u;
    uint local_128 = 0u;
    uint local_129[2] = uint[2](0u, 0u);
    uint local_130 = 0u;
    uint local_131 = 0u;
    uint local_132[2] = uint[2](0u, 0u);
    uint local_133 = 0u;
    uint local_134 = 0u;
    uint local_135[2] = uint[2](0u, 0u);
    uint local_136 = 0u;
    uint local_137 = 0u;
    uint local_138[2] = uint[2](0u, 0u);
    uint local_139 = 0u;
    uint local_140 = 0u;
    uint local_141[2] = uint[2](0u, 0u);
    uint local_142 = 0u;
    uint local_143 = 0u;
    uint local_144[2] = uint[2](0u, 0u);
    uint local_145 = 0u;
    uint local_146 = 0u;
    uint local_147[2] = uint[2](0u, 0u);
    uint local_148 = 0u;
    uint local_149 = 0u;
    uint local_150[2] = uint[2](0u, 0u);
    uint local_151 = 0u;
    uint local_152 = 0u;
    uint local_153[2] = uint[2](0u, 0u);
    uint local_154 = 0u;
    uint local_155 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    input_a = uint[2](0u, 0u);
    input_a[0] = 1u;
    input_a[1] = 0u;
    input_b = uint[2](0u, 0u);
    input_b[0] = 2u;
    input_b[1] = 0u;
    uint n_1 = _group_0_binding_3_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 25u);
        choose_a = ((i - 2u * (i / 2u)) == 0u);
        bool _e37 = choose_a;
        if (_e37) {
            uint _e39[2] = input_a;
            local_2 = _e39;
            local_3 = uint(i);
            uint _e43[2] = local_2;
            local_73 = _e43;
            uint _e45 = local_3;
            uint _e47 = local_73[1];
            local_73[1] = (_e47 + _e45);
            uint _e51 = local_73[0];
            local_74 = uint(_e51);
            uint _e55 = local_73[1];
            local_75 = uint(_e55);
            uint _e58 = local_75;
            int _e61 = _group_0_binding_1_cs[_e58];
            local_76 = _e61;
            int _e63 = local_76;
            local_71 = _e63;
            int _e65 = local_71;
            local_6 = _e65;
        } else {
            uint _e68[2] = input_b;
            local_4 = _e68;
            local_5 = uint(i);
            uint _e72[2] = local_4;
            local_77 = _e72;
            uint _e74 = local_5;
            uint _e76 = local_77[1];
            local_77[1] = (_e76 + _e74);
            uint _e80 = local_77[0];
            local_78 = uint(_e80);
            uint _e84 = local_77[1];
            local_79 = uint(_e84);
            uint _e87 = local_79;
            int _e90 = _group_0_binding_2_cs[_e87];
            local_80 = _e90;
            int _e92 = local_80;
            local_72 = _e92;
            int _e94 = local_72;
            local_6 = _e94;
        }
        int _e97 = local_6;
        uint _e99[2] = out_;
        local = _e99;
        uint _e101 = base;
        local_1 = uint(_e101);
        uint _e104[2] = local;
        local_81 = _e104;
        uint _e106 = local_1;
        uint _e108 = local_81[1];
        local_81[1] = (_e108 + _e106);
        uint _e112 = local_81[0];
        local_82 = uint(_e112);
        uint _e116 = local_81[1];
        local_83 = uint(_e116);
        uint _e119 = local_83;
        _group_0_binding_0_cs[_e119] = _e97;
        a = 3;
        b = 5;
        bool _e126 = choose_a;
        if (_e126) {
            int _e127 = a;
            a = (_e127 + 1);
            int _e130 = shifted(_e127);
            local_9 = _e130;
        } else {
            int _e132 = b;
            b = (_e132 + 1);
            int _e135 = shifted(_e132);
            local_9 = _e135;
        }
        int _e138 = local_9;
        uint _e139[2] = out_;
        local_7 = _e139;
        uint _e141 = base;
        local_8 = uint((_e141 + 1u));
        uint _e146[2] = local_7;
        local_84 = _e146;
        uint _e148 = local_8;
        uint _e150 = local_84[1];
        local_84[1] = (_e150 + _e148);
        uint _e154 = local_84[0];
        local_85 = uint(_e154);
        uint _e158 = local_84[1];
        local_86 = uint(_e158);
        uint _e161 = local_86;
        _group_0_binding_0_cs[_e161] = _e138;
        int _e163 = a;
        int _e166 = b;
        uint _e168[2] = out_;
        local_10 = _e168;
        uint _e170 = base;
        local_11 = uint((_e170 + 2u));
        uint _e175[2] = local_10;
        local_87 = _e175;
        uint _e177 = local_11;
        uint _e179 = local_87[1];
        local_87[1] = (_e179 + _e177);
        uint _e183 = local_87[0];
        local_88 = uint(_e183);
        uint _e187 = local_87[1];
        local_89 = uint(_e187);
        uint _e190 = local_89;
        _group_0_binding_0_cs[_e190] = ((_e163 * 10) + _e166);
        bool _e192 = choose_a;
        if (_e192) {
            int _e193 = a;
            a = (_e193 + 1);
            discard_(_e193);
        } else {
            int _e196 = b;
            b = (_e196 + 1);
            discard_(_e196);
        }
        int _e199 = a;
        int _e202 = b;
        uint _e204[2] = out_;
        local_12 = _e204;
        uint _e206 = base;
        local_13 = uint((_e206 + 3u));
        uint _e211[2] = local_12;
        local_90 = _e211;
        uint _e213 = local_13;
        uint _e215 = local_90[1];
        local_90[1] = (_e215 + _e213);
        uint _e219 = local_90[0];
        local_91 = uint(_e219);
        uint _e223 = local_90[1];
        local_92 = uint(_e223);
        uint _e226 = local_92;
        _group_0_binding_0_cs[_e226] = ((_e199 * 10) + _e202);
        index_a = 0;
        index_b = 0;
        bool _e232 = choose_a;
        if (_e232) {
            uint _e234[2] = input_a;
            local_14 = _e234;
            int _e236 = index_a;
            index_a = (_e236 + 1);
            local_15 = uint(_e236);
        } else {
            uint _e242[2] = input_b;
            local_16 = _e242;
            int _e244 = index_b;
            index_b = (_e244 + 1);
            local_17 = uint(_e244);
        }
        int _e249 = index_a;
        int _e252 = index_b;
        uint _e254[2] = out_;
        local_18 = _e254;
        uint _e256 = base;
        local_19 = uint((_e256 + 4u));
        uint _e261[2] = local_18;
        local_93 = _e261;
        uint _e263 = local_19;
        uint _e265 = local_93[1];
        local_93[1] = (_e265 + _e263);
        uint _e269 = local_93[0];
        local_94 = uint(_e269);
        uint _e273 = local_93[1];
        local_95 = uint(_e273);
        uint _e276 = local_95;
        _group_0_binding_0_cs[_e276] = ((_e249 * 10) + _e252);
        a = 3;
        b = 5;
        bool _e280 = choose_a;
        if (_e280) {
            a = 7;
        } else {
            b = 7;
        }
        int _e283 = a;
        int _e286 = b;
        uint _e288[2] = out_;
        local_20 = _e288;
        uint _e290 = base;
        local_21 = uint((_e290 + 5u));
        uint _e295[2] = local_20;
        local_96 = _e295;
        uint _e297 = local_21;
        uint _e299 = local_96[1];
        local_96[1] = (_e299 + _e297);
        uint _e303 = local_96[0];
        local_97 = uint(_e303);
        uint _e307 = local_96[1];
        local_98 = uint(_e307);
        uint _e310 = local_98;
        _group_0_binding_0_cs[_e310] = ((_e283 * 10) + _e286);
        bool _e312 = choose_a;
        if (_e312) {
            int _e313 = a;
            a = (_e313 + 2);
        } else {
            int _e316 = b;
            b = (_e316 + 2);
        }
        int _e319 = a;
        int _e322 = b;
        uint _e324[2] = out_;
        local_22 = _e324;
        uint _e326 = base;
        local_23 = uint((_e326 + 6u));
        uint _e331[2] = local_22;
        local_99 = _e331;
        uint _e333 = local_23;
        uint _e335 = local_99[1];
        local_99[1] = (_e335 + _e333);
        uint _e339 = local_99[0];
        local_100 = uint(_e339);
        uint _e343 = local_99[1];
        local_101 = uint(_e343);
        uint _e346 = local_101;
        _group_0_binding_0_cs[_e346] = ((_e319 * 10) + _e322);
        bool _e348 = choose_a;
        if (_e348) {
            int _e349 = a;
            a = (_e349 + 1);
            int _e352 = a;
            local_26 = _e352;
        } else {
            int _e354 = b;
            b = (_e354 + 1);
            int _e357 = b;
            local_26 = _e357;
        }
        int _e360 = local_26;
        uint _e361[2] = out_;
        local_24 = _e361;
        uint _e363 = base;
        local_25 = uint((_e363 + 7u));
        uint _e368[2] = local_24;
        local_102 = _e368;
        uint _e370 = local_25;
        uint _e372 = local_102[1];
        local_102[1] = (_e372 + _e370);
        uint _e376 = local_102[0];
        local_103 = uint(_e376);
        uint _e380 = local_102[1];
        local_104 = uint(_e380);
        uint _e383 = local_104;
        _group_0_binding_0_cs[_e383] = _e360;
        bool _e385 = choose_a;
        if (_e385) {
            int _e386 = a;
            a = (_e386 + 1);
            local_29 = _e386;
        } else {
            int _e390 = b;
            b = (_e390 + 1);
            local_29 = _e390;
        }
        int _e395 = local_29;
        uint _e396[2] = out_;
        local_27 = _e396;
        uint _e398 = base;
        local_28 = uint((_e398 + 8u));
        uint _e403[2] = local_27;
        local_105 = _e403;
        uint _e405 = local_28;
        uint _e407 = local_105[1];
        local_105[1] = (_e407 + _e405);
        uint _e411 = local_105[0];
        local_106 = uint(_e411);
        uint _e415 = local_105[1];
        local_107 = uint(_e415);
        uint _e418 = local_107;
        _group_0_binding_0_cs[_e418] = _e395;
        int _e420 = a;
        int _e423 = b;
        uint _e425[2] = out_;
        local_30 = _e425;
        uint _e427 = base;
        local_31 = uint((_e427 + 9u));
        uint _e432[2] = local_30;
        local_108 = _e432;
        uint _e434 = local_31;
        uint _e436 = local_108[1];
        local_108[1] = (_e436 + _e434);
        uint _e440 = local_108[0];
        local_109 = uint(_e440);
        uint _e444 = local_108[1];
        local_110 = uint(_e444);
        uint _e447 = local_110;
        _group_0_binding_0_cs[_e447] = ((_e420 * 100) + _e423);
        bool _e449 = choose_a;
        c = int(_e449);
        b = 7;
        int _e453 = c;
        if ((_e453 != 0)) {
            c = 0;
            int _e457 = c;
            c = (_e457 + 1);
            local_34 = _e457;
        } else {
            b = 0;
            int _e462 = b;
            b = (_e462 + 1);
            local_34 = _e462;
        }
        int _e467 = local_34;
        uint _e468[2] = out_;
        local_32 = _e468;
        uint _e470 = base;
        local_33 = uint((_e470 + 10u));
        uint _e475[2] = local_32;
        local_111 = _e475;
        uint _e477 = local_33;
        uint _e479 = local_111[1];
        local_111[1] = (_e479 + _e477);
        uint _e483 = local_111[0];
        local_112 = uint(_e483);
        uint _e487 = local_111[1];
        local_113 = uint(_e487);
        uint _e490 = local_113;
        _group_0_binding_0_cs[_e490] = _e467;
        int _e492 = c;
        int _e495 = b;
        uint _e497[2] = out_;
        local_35 = _e497;
        uint _e499 = base;
        local_36 = uint((_e499 + 11u));
        uint _e504[2] = local_35;
        local_114 = _e504;
        uint _e506 = local_36;
        uint _e508 = local_114[1];
        local_114[1] = (_e508 + _e506);
        uint _e512 = local_114[0];
        local_115 = uint(_e512);
        uint _e516 = local_114[1];
        local_116 = uint(_e516);
        uint _e519 = local_116;
        _group_0_binding_0_cs[_e519] = ((_e492 * 10) + _e495);
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e526 = condition;
        int _e527 = condition;
        if ((_e527 != 0)) {
            a = _e526;
        } else {
            b = _e526;
        }
        int _e530 = a;
        int _e533 = b;
        uint _e535[2] = out_;
        local_37 = _e535;
        uint _e537 = base;
        local_38 = uint((_e537 + 12u));
        uint _e542[2] = local_37;
        local_117 = _e542;
        uint _e544 = local_38;
        uint _e546 = local_117[1];
        local_117[1] = (_e546 + _e544);
        uint _e550 = local_117[0];
        local_118 = uint(_e550);
        uint _e554 = local_117[1];
        local_119 = uint(_e554);
        uint _e557 = local_119;
        _group_0_binding_0_cs[_e557] = ((_e530 * 10) + _e533);
        a = 2;
        b = 4;
        c = 6;
        bool _e562 = choose_a;
        if (_e562) {
            if (((i - 4u * (i / 4u)) == 0u)) {
                int _e567 = a;
                a = (_e567 + 3);
            } else {
                int _e570 = b;
                b = (_e570 + 3);
            }
        } else {
            int _e573 = c;
            c = (_e573 + 3);
        }
        int _e576 = a;
        int _e579 = b;
        int _e583 = c;
        uint _e585[2] = out_;
        local_39 = _e585;
        uint _e587 = base;
        local_40 = uint((_e587 + 13u));
        uint _e592[2] = local_39;
        local_120 = _e592;
        uint _e594 = local_40;
        uint _e596 = local_120[1];
        local_120[1] = (_e596 + _e594);
        uint _e600 = local_120[0];
        local_121 = uint(_e600);
        uint _e604 = local_120[1];
        local_122 = uint(_e604);
        uint _e607 = local_122;
        _group_0_binding_0_cs[_e607] = (((_e576 * 100) + (_e579 * 10)) + _e583);
        lane = threadIdx.x;
        uint _e611 = lane;
        shared_values[_e611] = 20;
        local_value = 10;
        bool _e617 = choose_a;
        if (_e617) {
            int _e618 = local_value;
            local_value = (_e618 + 5);
        } else {
            uint _e621 = lane;
            int _e623 = shared_values[_e621];
            shared_values[_e621] = (_e623 + 5);
        }
        int _e626 = local_value;
        uint _e629 = lane;
        int _e631 = shared_values[_e629];
        uint _e633[2] = out_;
        local_41 = _e633;
        uint _e635 = base;
        local_42 = uint((_e635 + 14u));
        uint _e640[2] = local_41;
        local_123 = _e640;
        uint _e642 = local_42;
        uint _e644 = local_123[1];
        local_123[1] = (_e644 + _e642);
        uint _e648 = local_123[0];
        local_124 = uint(_e648);
        uint _e652 = local_123[1];
        local_125 = uint(_e652);
        uint _e655 = local_125;
        _group_0_binding_0_cs[_e655] = ((_e626 * 100) + _e631);
        bool _e657 = choose_a;
        if (_e657) {
            uint _e658 = lane;
            shared_values[_e658] = 30;
        } else {
            uint _e661[2] = out_;
            local_43 = _e661;
            uint _e663 = base;
            local_44 = uint((_e663 + 15u));
            uint _e668[2] = local_43;
            local_126 = _e668;
            uint _e670 = local_44;
            uint _e672 = local_126[1];
            local_126[1] = (_e672 + _e670);
            uint _e676 = local_126[0];
            local_127 = uint(_e676);
            uint _e680 = local_126[1];
            local_128 = uint(_e680);
            uint _e683 = local_128;
            _group_0_binding_0_cs[_e683] = 30;
        }
        uint _e686 = lane;
        int _e688 = shared_values[_e686];
        uint _e689[2] = out_;
        local_45 = _e689;
        uint _e691 = base;
        local_46 = uint((_e691 + 16u));
        uint _e696[2] = local_45;
        local_129 = _e696;
        uint _e698 = local_46;
        uint _e700 = local_129[1];
        local_129[1] = (_e700 + _e698);
        uint _e704 = local_129[0];
        local_130 = uint(_e704);
        uint _e708 = local_129[1];
        local_131 = uint(_e708);
        uint _e711 = local_131;
        _group_0_binding_0_cs[_e711] = _e688;
        bool _e713 = choose_a;
        if (_e713) {
            local_49 = 1.5;
        } else {
            local_49 = float(3);
        }
        float _e720 = local_49;
        uint _e721[2] = out_;
        local_47 = _e721;
        uint _e723 = base;
        local_48 = uint((_e723 + 17u));
        uint _e729[2] = local_47;
        local_132 = _e729;
        uint _e731 = local_48;
        uint _e733 = local_132[1];
        local_132[1] = (_e733 + _e731);
        uint _e737 = local_132[0];
        local_133 = uint(_e737);
        uint _e741 = local_132[1];
        local_134 = uint(_e741);
        uint _e744 = local_134;
        _group_0_binding_0_cs[_e744] = int(_e720);
        bool _e746 = choose_a;
        if (_e746) {
            local_52 = uint(-(1));
        } else {
            local_52 = 2u;
        }
        uint _e754 = local_52;
        uint _e755[2] = out_;
        local_50 = _e755;
        uint _e757 = base;
        local_51 = uint((_e757 + 18u));
        uint _e763[2] = local_50;
        local_135 = _e763;
        uint _e765 = local_51;
        uint _e767 = local_135[1];
        local_135[1] = (_e767 + _e765);
        uint _e771 = local_135[0];
        local_136 = uint(_e771);
        uint _e775 = local_135[1];
        local_137 = uint(_e775);
        uint _e778 = local_137;
        _group_0_binding_0_cs[_e778] = int(_e754);
        bool _e780 = choose_a;
        if (_e780) {
            local_55 = true;
        } else {
            local_55 = false;
        }
        bool _e786 = local_55;
        uint _e787[2] = out_;
        local_53 = _e787;
        uint _e789 = base;
        local_54 = uint((_e789 + 19u));
        uint _e795[2] = local_53;
        local_138 = _e795;
        uint _e797 = local_54;
        uint _e799 = local_138[1];
        local_138[1] = (_e799 + _e797);
        uint _e803 = local_138[0];
        local_139 = uint(_e803);
        uint _e807 = local_138[1];
        local_140 = uint(_e807);
        uint _e810 = local_140;
        _group_0_binding_0_cs[_e810] = int(_e786);
        bool _e812 = choose_a;
        if (_e812) {
            local_58 = int(true);
        } else {
            local_58 = 2;
        }
        int _e819 = local_58;
        uint _e820[2] = out_;
        local_56 = _e820;
        uint _e822 = base;
        local_57 = uint((_e822 + 20u));
        uint _e827[2] = local_56;
        local_141 = _e827;
        uint _e829 = local_57;
        uint _e831 = local_141[1];
        local_141[1] = (_e831 + _e829);
        uint _e835 = local_141[0];
        local_142 = uint(_e835);
        uint _e839 = local_141[1];
        local_143 = uint(_e839);
        uint _e842 = local_143;
        _group_0_binding_0_cs[_e842] = _e819;
        bool _e844 = choose_a;
        if (_e844) {
            local_61 = 4u;
        } else {
            local_61 = 8u;
        }
        uint _e850 = local_61;
        uint _e851[2] = out_;
        local_59 = _e851;
        uint _e853 = base;
        local_60 = uint((_e853 + 21u));
        uint _e859[2] = local_59;
        local_144 = _e859;
        uint _e861 = local_60;
        uint _e863 = local_144[1];
        local_144[1] = (_e863 + _e861);
        uint _e867 = local_144[0];
        local_145 = uint(_e867);
        uint _e871 = local_144[1];
        local_146 = uint(_e871);
        uint _e874 = local_146;
        _group_0_binding_0_cs[_e874] = int(_e850);
        a = 3;
        shift_value = 2;
        bool _e879 = choose_a;
        if (_e879) {
            int _e880 = shift_value;
            local_64 = _e880;
        } else {
            int _e882 = a;
            local_64 = _e882;
        }
        int _e885 = local_64;
        shift_value = 1;
        int _e887 = shift_value;
        local_65 = uint(_e887);
        uint _e890 = local_65;
        uint _e892[2] = out_;
        local_62 = _e892;
        uint _e894 = base;
        local_63 = uint((_e894 + 22u));
        uint _e899[2] = local_62;
        local_147 = _e899;
        uint _e901 = local_63;
        uint _e903 = local_147[1];
        local_147[1] = (_e903 + _e901);
        uint _e907 = local_147[0];
        local_148 = uint(_e907);
        uint _e911 = local_147[1];
        local_149 = uint(_e911);
        uint _e914 = local_149;
        _group_0_binding_0_cs[_e914] = (_e885 << _e890);
        value = 3;
        other = 7;
        bool _e920 = choose_a;
        if (_e920) {
            int _e921 = value;
            local_68 = _e921;
        } else {
            int _e923 = other;
            local_68 = _e923;
        }
        int _e926 = local_68;
        int _e927 = value;
        value = (_e927 + 1);
        int _e930 = pair(_e926, _e927);
        uint _e931[2] = out_;
        local_66 = _e931;
        uint _e933 = base;
        local_67 = uint((_e933 + 23u));
        uint _e938[2] = local_66;
        local_150 = _e938;
        uint _e940 = local_67;
        uint _e942 = local_150[1];
        local_150[1] = (_e942 + _e940);
        uint _e946 = local_150[0];
        local_151 = uint(_e946);
        uint _e950 = local_150[1];
        local_152 = uint(_e950);
        uint _e953 = local_152;
        _group_0_binding_0_cs[_e953] = _e930;
        count = 0;
        left = 0;
        right = 0;
        {
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    bool _e970 = choose_a;
                    if (_e970) {
                        int _e971 = left;
                        left = (_e971 + 1);
                    } else {
                        int _e974 = right;
                        right = (_e974 + 1);
                    }
                }
                loop_init = false;
                int _e961 = count;
                if ((_e961 < 3)) {
                } else {
                    break;
                }
                int _e964 = count;
                count = (_e964 + 1);
                int _e967 = count;
                if ((_e967 == 2)) {
                    continue;
                }
            }
        }
        int _e977 = left;
        int _e980 = right;
        int _e984 = count;
        uint _e986[2] = out_;
        local_69 = _e986;
        uint _e988 = base;
        local_70 = uint((_e988 + 24u));
        uint _e993[2] = local_69;
        local_153 = _e993;
        uint _e995 = local_70;
        uint _e997 = local_153[1];
        local_153[1] = (_e997 + _e995);
        uint _e1001 = local_153[0];
        local_154 = uint(_e1001);
        uint _e1005 = local_153[1];
        local_155 = uint(_e1005);
        uint _e1008 = local_155;
        _group_0_binding_0_cs[_e1008] = (((_e977 * 100) + (_e980 * 10)) + _e984);
    }
}

