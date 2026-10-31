#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_3_block_0Compute { int _group_0_binding_0_cs[]; };


int case_chain(int selector) {
    int result = 0;
    result = 0;
    switch(selector) {
        case -1: {
            int _e3 = result;
            result = (_e3 + 1);
            int _e6 = result;
            result = (_e6 + 10);
            int _e9 = result;
            result = (_e9 + 100);
            break;
        }
        case 0: {
            int _e12 = result;
            result = (_e12 + 10);
            int _e15 = result;
            result = (_e15 + 100);
            break;
        }
        case 1: {
            int _e18 = result;
            result = (_e18 + 100);
            break;
        }
        default: {
            int _e21 = result;
            result = (_e21 + 1000);
            int _e24 = result;
            result = (_e24 + 10000);
            break;
        }
        case 2: {
            int _e27 = result;
            result = (_e27 + 10000);
            break;
        }
    }
    int _e30 = result;
    return _e30;
}

int grouped_labels(uint selector_1) {
    int result_1 = 0;
    result_1 = 0;
    switch(selector_1) {
        case 0u: {
            int _e3 = result_1;
            result_1 = (_e3 + 3);
            int _e6 = result_1;
            result_1 = (_e6 + 5);
            break;
        }
        case 1u: {
            int _e9 = result_1;
            result_1 = (_e9 + 3);
            int _e12 = result_1;
            result_1 = (_e12 + 5);
            break;
        }
        case 2u: {
            int _e15 = result_1;
            result_1 = (_e15 + 5);
            break;
        }
        default: {
            result_1 = 7;
            break;
        }
    }
    int _e19 = result_1;
    return _e19;
}

int nested_switches(int outer, int inner) {
    int result_2 = 0;
    result_2 = 0;
    switch(outer) {
        case 0: {
            int _e4 = result_2;
            result_2 = (_e4 + 1);
            switch(inner) {
                case 0: {
                    int _e7 = result_2;
                    result_2 = (_e7 + 10);
                    int _e10 = result_2;
                    result_2 = (_e10 + 20);
                    break;
                }
                default: {
                    int _e13 = result_2;
                    result_2 = (_e13 + 20);
                    break;
                }
            }
            int _e16 = result_2;
            result_2 = (_e16 + 100);
            break;
        }
        case 1: {
            int _e19 = result_2;
            result_2 = (_e19 + 100);
            break;
        }
        default: {
            result_2 = 900;
            break;
        }
    }
    int _e23 = result_2;
    return _e23;
}

int loop_jumps(int selector_2) {
    int result_3 = 0;
    int iteration = 0;
    result_3 = 0;
    {
        iteration = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e34 = iteration;
                iteration = (_e34 + 1);
            }
            loop_init = false;
            int _e5 = iteration;
            if ((_e5 < 4)) {
            } else {
                break;
            }
            switch(selector_2) {
                case 0: {
                    int _e8 = iteration;
                    if ((_e8 == 1)) {
                        continue;
                    }
                    int _e11 = iteration;
                    int _e14 = result_3;
                    result_3 = (_e14 + (_e11 + 1));
                    int _e16 = iteration;
                    if ((_e16 == 2)) {
                        break;
                    }
                    int _e19 = result_3;
                    result_3 = (_e19 + 10);
                    break;
                }
                case 1: {
                    int _e22 = iteration;
                    if ((_e22 == 2)) {
                        break;
                    }
                    int _e25 = result_3;
                    result_3 = (_e25 + 10);
                    break;
                }
                default: {
                    int _e28 = result_3;
                    result_3 = (_e28 + 100);
                    continue;
                }
            }
            int _e31 = result_3;
            result_3 = (_e31 + 1000);
        }
    }
    int _e37 = result_3;
    return _e37;
}

int terminal_paths(int selector_3, int flag) {
    int result_4 = 0;
    result_4 = 0;
    switch(selector_3) {
        case 0: {
            if ((flag != 0)) {
                return 3;
            }
            int _e7 = result_4;
            result_4 = (_e7 + 1);
            int _e10 = result_4;
            return (_e10 + 5);
        }
        case 1: {
            int _e13 = result_4;
            return (_e13 + 5);
        }
        default: {
            result_4 = 9;
            {
                int _e17 = result_4;
                return (_e17 + 10);
            }
            break;
        }
        case 2: {
            {
                int _e20 = result_4;
                return (_e20 + 10);
            }
            break;
        }
    }
}

int update_value(int value, int token) {
    return (value + token);
}

ivec2 call_results(int selector_4, int counter_1) {
    int counter_2 = 0;
    int result_5 = 0;
    int named_value = 0;
    int named_value_1 = 0;
    int named_value_2 = 0;
    counter_2 = counter_1;
    result_5 = 2;
    switch(selector_4) {
        case 0: {
            {
                int _e5 = result_5;
                int _e6 = counter_2;
                counter_2 = (_e6 + 1);
                int _e9 = counter_2;
                int _e10 = update_value(_e5, _e9);
                named_value = _e10;
                int _e12 = named_value;
                int _e13 = named_value;
                result_5 = (_e12 + _e13);
            }
            {
                int _e15 = result_5;
                int _e16 = counter_2;
                counter_2 = (_e16 + 1);
                int _e19 = counter_2;
                int _e20 = update_value(_e15, _e19);
                named_value_1 = _e20;
                int _e22 = named_value_1;
                int _e23 = named_value_1;
                result_5 = (_e22 * _e23);
            }
            {
                int _e25 = result_5;
                int _e26 = counter_2;
                counter_2 = (_e26 + 1);
                int _e29 = counter_2;
                int _e30 = update_value(_e25, _e29);
                named_value_2 = _e30;
                int _e32 = named_value_2;
                int _e33 = named_value_2;
                result_5 = (_e32 + _e33);
                break;
            }
            break;
        }
        case 1: {
            {
                int _e35 = result_5;
                int _e36 = counter_2;
                counter_2 = (_e36 + 1);
                int _e39 = counter_2;
                int _e40 = update_value(_e35, _e39);
                named_value_1 = _e40;
                int _e42 = named_value_1;
                int _e43 = named_value_1;
                result_5 = (_e42 * _e43);
            }
            {
                int _e45 = result_5;
                int _e46 = counter_2;
                counter_2 = (_e46 + 1);
                int _e49 = counter_2;
                int _e50 = update_value(_e45, _e49);
                named_value_2 = _e50;
                int _e52 = named_value_2;
                int _e53 = named_value_2;
                result_5 = (_e52 + _e53);
                break;
            }
            break;
        }
        default: {
            {
                int _e55 = result_5;
                int _e56 = counter_2;
                counter_2 = (_e56 + 1);
                int _e59 = counter_2;
                int _e60 = update_value(_e55, _e59);
                named_value_2 = _e60;
                int _e62 = named_value_2;
                int _e63 = named_value_2;
                result_5 = (_e62 + _e63);
                break;
            }
            break;
        }
    }
    int _e65 = result_5;
    int _e66 = counter_2;
    return ivec2(_e65, _e66);
}

void main() {
    uint out_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
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
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31 = 0u;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    uint local_38[2] = uint[2](0u, 0u);
    uint local_39 = 0u;
    uint local_40[2] = uint[2](0u, 0u);
    uint local_41 = 0u;
    int counter = 0;
    uint local_42[2] = uint[2](0u, 0u);
    uint local_43 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46[2] = uint[2](0u, 0u);
    uint local_47 = 0u;
    uint local_48[2] = uint[2](0u, 0u);
    uint local_49 = 0u;
    ivec2 first = ivec2(0);
    ivec2 second = ivec2(0);
    ivec2 third = ivec2(0);
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51 = 0u;
    uint local_52[2] = uint[2](0u, 0u);
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57 = 0u;
    uint local_58[2] = uint[2](0u, 0u);
    uint local_59 = 0u;
    uint local_60[2] = uint[2](0u, 0u);
    uint local_61 = 0u;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68[2] = uint[2](0u, 0u);
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71[2] = uint[2](0u, 0u);
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74[2] = uint[2](0u, 0u);
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80[2] = uint[2](0u, 0u);
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83[2] = uint[2](0u, 0u);
    uint local_84 = 0u;
    uint local_85 = 0u;
    uint local_86[2] = uint[2](0u, 0u);
    uint local_87 = 0u;
    uint local_88 = 0u;
    uint local_89[2] = uint[2](0u, 0u);
    uint local_90 = 0u;
    uint local_91 = 0u;
    uint local_92[2] = uint[2](0u, 0u);
    uint local_93 = 0u;
    uint local_94 = 0u;
    uint local_95[2] = uint[2](0u, 0u);
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98[2] = uint[2](0u, 0u);
    uint local_99 = 0u;
    uint local_100 = 0u;
    uint local_101[2] = uint[2](0u, 0u);
    uint local_102 = 0u;
    uint local_103 = 0u;
    uint local_104[2] = uint[2](0u, 0u);
    uint local_105 = 0u;
    uint local_106 = 0u;
    uint local_107[2] = uint[2](0u, 0u);
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110[2] = uint[2](0u, 0u);
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113[2] = uint[2](0u, 0u);
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116[2] = uint[2](0u, 0u);
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119[2] = uint[2](0u, 0u);
    uint local_120 = 0u;
    uint local_121 = 0u;
    uint local_122[2] = uint[2](0u, 0u);
    uint local_123 = 0u;
    uint local_124 = 0u;
    uint local_125[2] = uint[2](0u, 0u);
    uint local_126 = 0u;
    uint local_127 = 0u;
    uint local_128[2] = uint[2](0u, 0u);
    uint local_129 = 0u;
    uint local_130 = 0u;
    uint local_131[2] = uint[2](0u, 0u);
    uint local_132 = 0u;
    uint local_133 = 0u;
    uint local_134[2] = uint[2](0u, 0u);
    uint local_135 = 0u;
    uint local_136 = 0u;
    uint local_137[2] = uint[2](0u, 0u);
    uint local_138 = 0u;
    uint local_139 = 0u;
    uint local_140[2] = uint[2](0u, 0u);
    uint local_141 = 0u;
    uint local_142 = 0u;
    uint local_143[2] = uint[2](0u, 0u);
    uint local_144 = 0u;
    uint local_145 = 0u;
    uint local_146[2] = uint[2](0u, 0u);
    uint local_147 = 0u;
    uint local_148 = 0u;
    uint local_149[2] = uint[2](0u, 0u);
    uint local_150 = 0u;
    uint local_151 = 0u;
    uint local_152[2] = uint[2](0u, 0u);
    uint local_153 = 0u;
    uint local_154 = 0u;
    uint local_155[2] = uint[2](0u, 0u);
    uint local_156 = 0u;
    uint local_157 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    int _e9 = case_chain(-(1));
    uint _e12[2] = out_;
    local = _e12;
    local_1 = uint(0);
    uint _e17[2] = local;
    local_62 = _e17;
    uint _e18 = local_1;
    uint _e20 = local_62[1];
    local_62[1] = (_e20 + _e18);
    uint _e24 = local_62[0];
    local_63 = uint(_e24);
    uint _e28 = local_62[1];
    local_64 = uint(_e28);
    uint _e31 = local_64;
    _group_0_binding_0_cs[_e31] = _e9;
    int _e34 = case_chain(0);
    uint _e36[2] = out_;
    local_2 = _e36;
    local_3 = uint(1);
    uint _e41[2] = local_2;
    local_65 = _e41;
    uint _e42 = local_3;
    uint _e44 = local_65[1];
    local_65[1] = (_e44 + _e42);
    uint _e48 = local_65[0];
    local_66 = uint(_e48);
    uint _e52 = local_65[1];
    local_67 = uint(_e52);
    uint _e55 = local_67;
    _group_0_binding_0_cs[_e55] = _e34;
    int _e58 = case_chain(1);
    uint _e60[2] = out_;
    local_4 = _e60;
    local_5 = uint(2);
    uint _e65[2] = local_4;
    local_68 = _e65;
    uint _e66 = local_5;
    uint _e68 = local_68[1];
    local_68[1] = (_e68 + _e66);
    uint _e72 = local_68[0];
    local_69 = uint(_e72);
    uint _e76 = local_68[1];
    local_70 = uint(_e76);
    uint _e79 = local_70;
    _group_0_binding_0_cs[_e79] = _e58;
    int _e82 = case_chain(2);
    uint _e84[2] = out_;
    local_6 = _e84;
    local_7 = uint(3);
    uint _e89[2] = local_6;
    local_71 = _e89;
    uint _e90 = local_7;
    uint _e92 = local_71[1];
    local_71[1] = (_e92 + _e90);
    uint _e96 = local_71[0];
    local_72 = uint(_e96);
    uint _e100 = local_71[1];
    local_73 = uint(_e100);
    uint _e103 = local_73;
    _group_0_binding_0_cs[_e103] = _e82;
    int _e106 = case_chain(8);
    uint _e108[2] = out_;
    local_8 = _e108;
    local_9 = uint(4);
    uint _e113[2] = local_8;
    local_74 = _e113;
    uint _e114 = local_9;
    uint _e116 = local_74[1];
    local_74[1] = (_e116 + _e114);
    uint _e120 = local_74[0];
    local_75 = uint(_e120);
    uint _e124 = local_74[1];
    local_76 = uint(_e124);
    uint _e127 = local_76;
    _group_0_binding_0_cs[_e127] = _e106;
    int _e130 = grouped_labels(0u);
    uint _e132[2] = out_;
    local_10 = _e132;
    local_11 = uint(5);
    uint _e137[2] = local_10;
    local_77 = _e137;
    uint _e138 = local_11;
    uint _e140 = local_77[1];
    local_77[1] = (_e140 + _e138);
    uint _e144 = local_77[0];
    local_78 = uint(_e144);
    uint _e148 = local_77[1];
    local_79 = uint(_e148);
    uint _e151 = local_79;
    _group_0_binding_0_cs[_e151] = _e130;
    int _e154 = grouped_labels(1u);
    uint _e156[2] = out_;
    local_12 = _e156;
    local_13 = uint(6);
    uint _e161[2] = local_12;
    local_80 = _e161;
    uint _e162 = local_13;
    uint _e164 = local_80[1];
    local_80[1] = (_e164 + _e162);
    uint _e168 = local_80[0];
    local_81 = uint(_e168);
    uint _e172 = local_80[1];
    local_82 = uint(_e172);
    uint _e175 = local_82;
    _group_0_binding_0_cs[_e175] = _e154;
    int _e178 = grouped_labels(2u);
    uint _e180[2] = out_;
    local_14 = _e180;
    local_15 = uint(7);
    uint _e185[2] = local_14;
    local_83 = _e185;
    uint _e186 = local_15;
    uint _e188 = local_83[1];
    local_83[1] = (_e188 + _e186);
    uint _e192 = local_83[0];
    local_84 = uint(_e192);
    uint _e196 = local_83[1];
    local_85 = uint(_e196);
    uint _e199 = local_85;
    _group_0_binding_0_cs[_e199] = _e178;
    int _e202 = grouped_labels(8u);
    uint _e204[2] = out_;
    local_16 = _e204;
    local_17 = uint(8);
    uint _e209[2] = local_16;
    local_86 = _e209;
    uint _e210 = local_17;
    uint _e212 = local_86[1];
    local_86[1] = (_e212 + _e210);
    uint _e216 = local_86[0];
    local_87 = uint(_e216);
    uint _e220 = local_86[1];
    local_88 = uint(_e220);
    uint _e223 = local_88;
    _group_0_binding_0_cs[_e223] = _e202;
    int _e227 = nested_switches(0, 0);
    uint _e229[2] = out_;
    local_18 = _e229;
    local_19 = uint(9);
    uint _e234[2] = local_18;
    local_89 = _e234;
    uint _e235 = local_19;
    uint _e237 = local_89[1];
    local_89[1] = (_e237 + _e235);
    uint _e241 = local_89[0];
    local_90 = uint(_e241);
    uint _e245 = local_89[1];
    local_91 = uint(_e245);
    uint _e248 = local_91;
    _group_0_binding_0_cs[_e248] = _e227;
    int _e252 = nested_switches(0, 8);
    uint _e254[2] = out_;
    local_20 = _e254;
    local_21 = uint(10);
    uint _e259[2] = local_20;
    local_92 = _e259;
    uint _e260 = local_21;
    uint _e262 = local_92[1];
    local_92[1] = (_e262 + _e260);
    uint _e266 = local_92[0];
    local_93 = uint(_e266);
    uint _e270 = local_92[1];
    local_94 = uint(_e270);
    uint _e273 = local_94;
    _group_0_binding_0_cs[_e273] = _e252;
    int _e277 = nested_switches(1, 0);
    uint _e279[2] = out_;
    local_22 = _e279;
    local_23 = uint(11);
    uint _e284[2] = local_22;
    local_95 = _e284;
    uint _e285 = local_23;
    uint _e287 = local_95[1];
    local_95[1] = (_e287 + _e285);
    uint _e291 = local_95[0];
    local_96 = uint(_e291);
    uint _e295 = local_95[1];
    local_97 = uint(_e295);
    uint _e298 = local_97;
    _group_0_binding_0_cs[_e298] = _e277;
    int _e302 = nested_switches(8, 0);
    uint _e304[2] = out_;
    local_24 = _e304;
    local_25 = uint(12);
    uint _e309[2] = local_24;
    local_98 = _e309;
    uint _e310 = local_25;
    uint _e312 = local_98[1];
    local_98[1] = (_e312 + _e310);
    uint _e316 = local_98[0];
    local_99 = uint(_e316);
    uint _e320 = local_98[1];
    local_100 = uint(_e320);
    uint _e323 = local_100;
    _group_0_binding_0_cs[_e323] = _e302;
    int _e326 = loop_jumps(0);
    uint _e328[2] = out_;
    local_26 = _e328;
    local_27 = uint(13);
    uint _e333[2] = local_26;
    local_101 = _e333;
    uint _e334 = local_27;
    uint _e336 = local_101[1];
    local_101[1] = (_e336 + _e334);
    uint _e340 = local_101[0];
    local_102 = uint(_e340);
    uint _e344 = local_101[1];
    local_103 = uint(_e344);
    uint _e347 = local_103;
    _group_0_binding_0_cs[_e347] = _e326;
    int _e350 = loop_jumps(1);
    uint _e352[2] = out_;
    local_28 = _e352;
    local_29 = uint(14);
    uint _e357[2] = local_28;
    local_104 = _e357;
    uint _e358 = local_29;
    uint _e360 = local_104[1];
    local_104[1] = (_e360 + _e358);
    uint _e364 = local_104[0];
    local_105 = uint(_e364);
    uint _e368 = local_104[1];
    local_106 = uint(_e368);
    uint _e371 = local_106;
    _group_0_binding_0_cs[_e371] = _e350;
    int _e374 = loop_jumps(8);
    uint _e376[2] = out_;
    local_30 = _e376;
    local_31 = uint(15);
    uint _e381[2] = local_30;
    local_107 = _e381;
    uint _e382 = local_31;
    uint _e384 = local_107[1];
    local_107[1] = (_e384 + _e382);
    uint _e388 = local_107[0];
    local_108 = uint(_e388);
    uint _e392 = local_107[1];
    local_109 = uint(_e392);
    uint _e395 = local_109;
    _group_0_binding_0_cs[_e395] = _e374;
    int _e399 = terminal_paths(0, 1);
    uint _e401[2] = out_;
    local_32 = _e401;
    local_33 = uint(16);
    uint _e406[2] = local_32;
    local_110 = _e406;
    uint _e407 = local_33;
    uint _e409 = local_110[1];
    local_110[1] = (_e409 + _e407);
    uint _e413 = local_110[0];
    local_111 = uint(_e413);
    uint _e417 = local_110[1];
    local_112 = uint(_e417);
    uint _e420 = local_112;
    _group_0_binding_0_cs[_e420] = _e399;
    int _e424 = terminal_paths(0, 0);
    uint _e426[2] = out_;
    local_34 = _e426;
    local_35 = uint(17);
    uint _e431[2] = local_34;
    local_113 = _e431;
    uint _e432 = local_35;
    uint _e434 = local_113[1];
    local_113[1] = (_e434 + _e432);
    uint _e438 = local_113[0];
    local_114 = uint(_e438);
    uint _e442 = local_113[1];
    local_115 = uint(_e442);
    uint _e445 = local_115;
    _group_0_binding_0_cs[_e445] = _e424;
    int _e449 = terminal_paths(1, 1);
    uint _e451[2] = out_;
    local_36 = _e451;
    local_37 = uint(18);
    uint _e456[2] = local_36;
    local_116 = _e456;
    uint _e457 = local_37;
    uint _e459 = local_116[1];
    local_116[1] = (_e459 + _e457);
    uint _e463 = local_116[0];
    local_117 = uint(_e463);
    uint _e467 = local_116[1];
    local_118 = uint(_e467);
    uint _e470 = local_118;
    _group_0_binding_0_cs[_e470] = _e449;
    int _e474 = terminal_paths(8, 0);
    uint _e476[2] = out_;
    local_38 = _e476;
    local_39 = uint(19);
    uint _e481[2] = local_38;
    local_119 = _e481;
    uint _e482 = local_39;
    uint _e484 = local_119[1];
    local_119[1] = (_e484 + _e482);
    uint _e488 = local_119[0];
    local_120 = uint(_e488);
    uint _e492 = local_119[1];
    local_121 = uint(_e492);
    uint _e495 = local_121;
    _group_0_binding_0_cs[_e495] = _e474;
    int _e499 = terminal_paths(2, 0);
    uint _e501[2] = out_;
    local_40 = _e501;
    local_41 = uint(20);
    uint _e506[2] = local_40;
    local_122 = _e506;
    uint _e507 = local_41;
    uint _e509 = local_122[1];
    local_122[1] = (_e509 + _e507);
    uint _e513 = local_122[0];
    local_123 = uint(_e513);
    uint _e517 = local_122[1];
    local_124 = uint(_e517);
    uint _e520 = local_124;
    _group_0_binding_0_cs[_e520] = _e499;
    counter = 0;
    int _e524 = counter;
    counter = (_e524 + 1);
    switch(_e524) {
        case 0: {
            int _e527 = counter;
            uint _e529[2] = out_;
            local_42 = _e529;
            local_43 = uint(21);
            uint _e534[2] = local_42;
            local_125 = _e534;
            uint _e535 = local_43;
            uint _e537 = local_125[1];
            local_125[1] = (_e537 + _e535);
            uint _e541 = local_125[0];
            local_126 = uint(_e541);
            uint _e545 = local_125[1];
            local_127 = uint(_e545);
            uint _e548 = local_127;
            _group_0_binding_0_cs[_e548] = _e527;
            int _e550 = counter;
            uint _e554[2] = out_;
            local_44 = _e554;
            local_45 = uint(22);
            uint _e559[2] = local_44;
            local_128 = _e559;
            uint _e560 = local_45;
            uint _e562 = local_128[1];
            local_128[1] = (_e562 + _e560);
            uint _e566 = local_128[0];
            local_129 = uint(_e566);
            uint _e570 = local_128[1];
            local_130 = uint(_e570);
            uint _e573 = local_130;
            _group_0_binding_0_cs[_e573] = (_e550 + 1);
            break;
        }
        case 1: {
            int _e575 = counter;
            uint _e579[2] = out_;
            local_44 = _e579;
            local_45 = uint(22);
            uint _e584[2] = local_44;
            local_131 = _e584;
            uint _e585 = local_45;
            uint _e587 = local_131[1];
            local_131[1] = (_e587 + _e585);
            uint _e591 = local_131[0];
            local_132 = uint(_e591);
            uint _e595 = local_131[1];
            local_133 = uint(_e595);
            uint _e598 = local_133;
            _group_0_binding_0_cs[_e598] = (_e575 + 1);
            break;
        }
        default: {
            uint _e601[2] = out_;
            local_46 = _e601;
            local_47 = uint(21);
            uint _e606[2] = local_46;
            local_134 = _e606;
            uint _e607 = local_47;
            uint _e609 = local_134[1];
            local_134[1] = (_e609 + _e607);
            uint _e613 = local_134[0];
            local_135 = uint(_e613);
            uint _e617 = local_134[1];
            local_136 = uint(_e617);
            uint _e621 = local_136;
            _group_0_binding_0_cs[_e621] = 99;
            break;
        }
    }
    int _e623 = counter;
    uint _e625[2] = out_;
    local_48 = _e625;
    local_49 = uint(23);
    uint _e630[2] = local_48;
    local_137 = _e630;
    uint _e631 = local_49;
    uint _e633 = local_137[1];
    local_137[1] = (_e633 + _e631);
    uint _e637 = local_137[0];
    local_138 = uint(_e637);
    uint _e641 = local_137[1];
    local_139 = uint(_e641);
    uint _e644 = local_139;
    _group_0_binding_0_cs[_e644] = _e623;
    ivec2 _e648 = call_results(0, 0);
    first = _e648;
    int _e651 = first.y;
    ivec2 _e653 = call_results(1, _e651);
    second = _e653;
    int _e656 = second.y;
    ivec2 _e658 = call_results(8, _e656);
    third = _e658;
    int _e661 = first.x;
    uint _e663[2] = out_;
    local_50 = _e663;
    local_51 = uint(24);
    uint _e668[2] = local_50;
    local_140 = _e668;
    uint _e669 = local_51;
    uint _e671 = local_140[1];
    local_140[1] = (_e671 + _e669);
    uint _e675 = local_140[0];
    local_141 = uint(_e675);
    uint _e679 = local_140[1];
    local_142 = uint(_e679);
    uint _e682 = local_142;
    _group_0_binding_0_cs[_e682] = _e661;
    int _e685 = second.x;
    uint _e687[2] = out_;
    local_52 = _e687;
    local_53 = uint(25);
    uint _e692[2] = local_52;
    local_143 = _e692;
    uint _e693 = local_53;
    uint _e695 = local_143[1];
    local_143[1] = (_e695 + _e693);
    uint _e699 = local_143[0];
    local_144 = uint(_e699);
    uint _e703 = local_143[1];
    local_145 = uint(_e703);
    uint _e706 = local_145;
    _group_0_binding_0_cs[_e706] = _e685;
    int _e709 = third.x;
    uint _e711[2] = out_;
    local_54 = _e711;
    local_55 = uint(26);
    uint _e716[2] = local_54;
    local_146 = _e716;
    uint _e717 = local_55;
    uint _e719 = local_146[1];
    local_146[1] = (_e719 + _e717);
    uint _e723 = local_146[0];
    local_147 = uint(_e723);
    uint _e727 = local_146[1];
    local_148 = uint(_e727);
    uint _e730 = local_148;
    _group_0_binding_0_cs[_e730] = _e709;
    int _e733 = third.y;
    uint _e735[2] = out_;
    local_56 = _e735;
    local_57 = uint(27);
    uint _e740[2] = local_56;
    local_149 = _e740;
    uint _e741 = local_57;
    uint _e743 = local_149[1];
    local_149[1] = (_e743 + _e741);
    uint _e747 = local_149[0];
    local_150 = uint(_e747);
    uint _e751 = local_149[1];
    local_151 = uint(_e751);
    uint _e754 = local_151;
    _group_0_binding_0_cs[_e754] = _e733;
    int _e757 = third.y;
    counter = _e757;
    int _e759 = third.x;
    int _e760 = counter;
    counter = (_e760 + 1);
    int _e763 = counter;
    int _e764 = update_value(_e759, _e763);
    uint _e766[2] = out_;
    local_58 = _e766;
    local_59 = uint(28);
    uint _e771[2] = local_58;
    local_152 = _e771;
    uint _e772 = local_59;
    uint _e774 = local_152[1];
    local_152[1] = (_e774 + _e772);
    uint _e778 = local_152[0];
    local_153 = uint(_e778);
    uint _e782 = local_152[1];
    local_154 = uint(_e782);
    uint _e785 = local_154;
    _group_0_binding_0_cs[_e785] = _e764;
    int _e787 = counter;
    uint _e789[2] = out_;
    local_60 = _e789;
    local_61 = uint(29);
    uint _e794[2] = local_60;
    local_155 = _e794;
    uint _e795 = local_61;
    uint _e797 = local_155[1];
    local_155[1] = (_e797 + _e795);
    uint _e801 = local_155[0];
    local_156 = uint(_e801);
    uint _e805 = local_155[1];
    local_157 = uint(_e805);
    uint _e808 = local_157;
    _group_0_binding_0_cs[_e808] = _e787;
}

