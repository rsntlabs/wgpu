// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_3[1];
struct type_4 {
    uint inner[2];
};

int case_chain(
    int selector
) {
    int selector_1 = {};
    int result = {};
    selector_1 = selector;
    result = 0;
    int _e4 = selector_1;
    switch(_e4) {
        case -1: {
            int _e6 = result;
            result = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
        }
        case 0: {
            int _e9 = result;
            result = as_type<int>(as_type<uint>(_e9) + as_type<uint>(10));
        }
        case 1: {
            int _e12 = result;
            result = as_type<int>(as_type<uint>(_e12) + as_type<uint>(100));
            break;
        }
        default: {
            int _e15 = result;
            result = as_type<int>(as_type<uint>(_e15) + as_type<uint>(1000));
        }
        case 2: {
            int _e18 = result;
            result = as_type<int>(as_type<uint>(_e18) + as_type<uint>(10000));
            break;
        }
    }
    int _e20 = result;
    return _e20;
}

int grouped_labels(
    uint selector_2
) {
    uint selector_3 = {};
    int result_1 = {};
    selector_3 = selector_2;
    result_1 = 0;
    uint _e4 = selector_3;
    switch(_e4) {
        case 0u:
        case 1u: {
            int _e6 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e6) + as_type<uint>(3));
        }
        case 2u: {
            int _e9 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e9) + as_type<uint>(5));
            break;
        }
        default: {
            result_1 = 7;
            break;
        }
    }
    int _e12 = result_1;
    return _e12;
}

int nested_switches(
    int outer,
    int inner
) {
    int outer_1 = {};
    int inner_1 = {};
    int result_2 = {};
    outer_1 = outer;
    inner_1 = inner;
    result_2 = 0;
    int _e6 = outer_1;
    switch(_e6) {
        case 0: {
            int _e8 = result_2;
            result_2 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
            int _e10 = inner_1;
            switch(_e10) {
                case 0: {
                    int _e12 = result_2;
                    result_2 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(10));
                }
                default: {
                    int _e15 = result_2;
                    result_2 = as_type<int>(as_type<uint>(_e15) + as_type<uint>(20));
                    break;
                }
            }
        }
        case 1: {
            int _e18 = result_2;
            result_2 = as_type<int>(as_type<uint>(_e18) + as_type<uint>(100));
            break;
        }
        default: {
            result_2 = 900;
            break;
        }
    }
    int _e21 = result_2;
    return _e21;
}

int loop_jumps(
    int selector_4
) {
    int selector_5 = {};
    int result_3 = {};
    int iteration = {};
    selector_5 = selector_4;
    result_3 = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e9 = iteration;
                iteration = as_type<int>(as_type<uint>(_e9) + as_type<uint>(1));
            }
            loop_init = false;
            int _e7 = iteration;
            if (_e7 < 4) {
            } else {
                break;
            }
            int _e12 = selector_5;
            switch(_e12) {
                case 0: {
                    int _e14 = iteration;
                    if (_e14 == 1) {
                        continue;
                    }
                    int _e17 = iteration;
                    int _e19 = result_3;
                    result_3 = as_type<int>(as_type<uint>(_e19) + as_type<uint>(as_type<int>(as_type<uint>(_e17) + as_type<uint>(1))));
                }
                case 1: {
                    int _e22 = iteration;
                    if (_e22 == 2) {
                        break;
                    }
                    int _e25 = result_3;
                    result_3 = as_type<int>(as_type<uint>(_e25) + as_type<uint>(10));
                    break;
                }
                default: {
                    int _e28 = result_3;
                    result_3 = as_type<int>(as_type<uint>(_e28) + as_type<uint>(100));
                    continue;
                }
            }
            int _e31 = result_3;
            result_3 = as_type<int>(as_type<uint>(_e31) + as_type<uint>(1000));
        }
    }
    int _e33 = result_3;
    return _e33;
}

int terminal_paths(
    int selector_6,
    int flag
) {
    int selector_7 = {};
    int flag_1 = {};
    int result_4 = {};
    selector_7 = selector_6;
    flag_1 = flag;
    result_4 = 0;
    int _e6 = selector_7;
    switch(_e6) {
        case 0: {
            int _e8 = flag_1;
            if (_e8 != 0) {
                return 3;
            }
            int _e12 = result_4;
            result_4 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(1));
        }
        case 1: {
            int _e15 = result_4;
            return as_type<int>(as_type<uint>(_e15) + as_type<uint>(5));
        }
        default: {
            result_4 = 9;
        }
        case 2: {
            {
                int _e19 = result_4;
                return as_type<int>(as_type<uint>(_e19) + as_type<uint>(10));
            }
            break;
        }
    }
}

int update_value(
    int value,
    int token
) {
    int value_1 = {};
    int token_1 = {};
    value_1 = value;
    token_1 = token;
    int _e4 = value_1;
    int _e5 = token_1;
    return as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5));
}

metal::int2 call_results(
    int selector_8,
    int counter_1
) {
    int selector_9 = {};
    int counter_2 = {};
    int result_5 = {};
    int named_value = {};
    int named_value_1 = {};
    int named_value_2 = {};
    selector_9 = selector_8;
    counter_2 = counter_1;
    result_5 = 2;
    int _e6 = selector_9;
    switch(_e6) {
        case 0: {
            {
                int _e8 = result_5;
                int _e9 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e9) + as_type<uint>(1));
                int _e12 = counter_2;
                int _e13 = update_value(_e8, _e12);
                named_value = _e13;
                int _e14 = named_value;
                int _e15 = named_value;
                result_5 = as_type<int>(as_type<uint>(_e14) + as_type<uint>(_e15));
            }
        }
        case 1: {
            {
                int _e18 = result_5;
                int _e19 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e19) + as_type<uint>(1));
                int _e22 = counter_2;
                int _e23 = update_value(_e18, _e22);
                named_value_1 = _e23;
                int _e24 = named_value_1;
                int _e25 = named_value_1;
                result_5 = as_type<int>(as_type<uint>(_e24) * as_type<uint>(_e25));
            }
        }
        default: {
            {
                int _e28 = result_5;
                int _e29 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e29) + as_type<uint>(1));
                int _e32 = counter_2;
                int _e33 = update_value(_e28, _e32);
                named_value_2 = _e33;
                int _e34 = named_value_2;
                int _e35 = named_value_2;
                result_5 = as_type<int>(as_type<uint>(_e34) + as_type<uint>(_e35));
                break;
            }
            break;
        }
    }
    int _e37 = result_5;
    int _e38 = counter_2;
    return metal::int2(_e37, _e38);
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void switches(
  device type_3& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_4 local = {};
    type_4 local_1 = {};
    uint local_2 = {};
    type_4 local_3 = {};
    uint local_4 = {};
    type_4 local_5 = {};
    uint local_6 = {};
    type_4 local_7 = {};
    uint local_8 = {};
    type_4 local_9 = {};
    uint local_10 = {};
    type_4 local_11 = {};
    uint local_12 = {};
    type_4 local_13 = {};
    uint local_14 = {};
    type_4 local_15 = {};
    uint local_16 = {};
    type_4 local_17 = {};
    uint local_18 = {};
    type_4 local_19 = {};
    uint local_20 = {};
    type_4 local_21 = {};
    uint local_22 = {};
    type_4 local_23 = {};
    uint local_24 = {};
    type_4 local_25 = {};
    uint local_26 = {};
    type_4 local_27 = {};
    uint local_28 = {};
    type_4 local_29 = {};
    uint local_30 = {};
    type_4 local_31 = {};
    uint local_32 = {};
    type_4 local_33 = {};
    uint local_34 = {};
    type_4 local_35 = {};
    uint local_36 = {};
    type_4 local_37 = {};
    uint local_38 = {};
    type_4 local_39 = {};
    uint local_40 = {};
    type_4 local_41 = {};
    uint local_42 = {};
    int counter = {};
    type_4 local_43 = {};
    uint local_44 = {};
    type_4 local_45 = {};
    uint local_46 = {};
    type_4 local_47 = {};
    uint local_48 = {};
    type_4 local_49 = {};
    uint local_50 = {};
    metal::int2 first = {};
    metal::int2 second = {};
    metal::int2 third = {};
    type_4 local_51 = {};
    uint local_52 = {};
    type_4 local_53 = {};
    uint local_54 = {};
    type_4 local_55 = {};
    uint local_56 = {};
    type_4 local_57 = {};
    uint local_58 = {};
    type_4 local_59 = {};
    uint local_60 = {};
    type_4 local_61 = {};
    uint local_62 = {};
    type_4 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_4 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_4 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_4 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_4 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_4 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_4 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_4 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_4 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_4 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_4 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_4 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_4 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_4 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_4 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_4 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_4 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_4 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_4 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_4 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_4 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_4 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_4 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_4 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_4 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_4 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    type_4 local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    type_4 local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    type_4 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    type_4 local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    type_4 local_153 = {};
    uint local_154 = {};
    uint local_155 = {};
    type_4 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    local = type_4 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    int _e9 = case_chain(naga_neg(1));
    type_4 _e12 = local;
    local_1 = _e12;
    local_2 = static_cast<uint>(0);
    type_4 _e17 = local_1;
    local_63 = _e17;
    uint _e18 = local_2;
    uint _e20 = local_63.inner[1];
    local_63.inner[1] = _e20 + _e18;
    uint _e24 = local_63.inner[0];
    local_64 = static_cast<uint>(_e24);
    uint _e28 = local_63.inner[1];
    local_65 = static_cast<uint>(_e28);
    uint _e31 = local_65;
    out[_e31] = _e9;
    int _e34 = case_chain(0);
    type_4 _e36 = local;
    local_3 = _e36;
    local_4 = static_cast<uint>(1);
    type_4 _e41 = local_3;
    local_66 = _e41;
    uint _e42 = local_4;
    uint _e44 = local_66.inner[1];
    local_66.inner[1] = _e44 + _e42;
    uint _e48 = local_66.inner[0];
    local_67 = static_cast<uint>(_e48);
    uint _e52 = local_66.inner[1];
    local_68 = static_cast<uint>(_e52);
    uint _e55 = local_68;
    out[_e55] = _e34;
    int _e58 = case_chain(1);
    type_4 _e60 = local;
    local_5 = _e60;
    local_6 = static_cast<uint>(2);
    type_4 _e65 = local_5;
    local_69 = _e65;
    uint _e66 = local_6;
    uint _e68 = local_69.inner[1];
    local_69.inner[1] = _e68 + _e66;
    uint _e72 = local_69.inner[0];
    local_70 = static_cast<uint>(_e72);
    uint _e76 = local_69.inner[1];
    local_71 = static_cast<uint>(_e76);
    uint _e79 = local_71;
    out[_e79] = _e58;
    int _e82 = case_chain(2);
    type_4 _e84 = local;
    local_7 = _e84;
    local_8 = static_cast<uint>(3);
    type_4 _e89 = local_7;
    local_72 = _e89;
    uint _e90 = local_8;
    uint _e92 = local_72.inner[1];
    local_72.inner[1] = _e92 + _e90;
    uint _e96 = local_72.inner[0];
    local_73 = static_cast<uint>(_e96);
    uint _e100 = local_72.inner[1];
    local_74 = static_cast<uint>(_e100);
    uint _e103 = local_74;
    out[_e103] = _e82;
    int _e106 = case_chain(8);
    type_4 _e108 = local;
    local_9 = _e108;
    local_10 = static_cast<uint>(4);
    type_4 _e113 = local_9;
    local_75 = _e113;
    uint _e114 = local_10;
    uint _e116 = local_75.inner[1];
    local_75.inner[1] = _e116 + _e114;
    uint _e120 = local_75.inner[0];
    local_76 = static_cast<uint>(_e120);
    uint _e124 = local_75.inner[1];
    local_77 = static_cast<uint>(_e124);
    uint _e127 = local_77;
    out[_e127] = _e106;
    int _e130 = grouped_labels(0u);
    type_4 _e132 = local;
    local_11 = _e132;
    local_12 = static_cast<uint>(5);
    type_4 _e137 = local_11;
    local_78 = _e137;
    uint _e138 = local_12;
    uint _e140 = local_78.inner[1];
    local_78.inner[1] = _e140 + _e138;
    uint _e144 = local_78.inner[0];
    local_79 = static_cast<uint>(_e144);
    uint _e148 = local_78.inner[1];
    local_80 = static_cast<uint>(_e148);
    uint _e151 = local_80;
    out[_e151] = _e130;
    int _e154 = grouped_labels(1u);
    type_4 _e156 = local;
    local_13 = _e156;
    local_14 = static_cast<uint>(6);
    type_4 _e161 = local_13;
    local_81 = _e161;
    uint _e162 = local_14;
    uint _e164 = local_81.inner[1];
    local_81.inner[1] = _e164 + _e162;
    uint _e168 = local_81.inner[0];
    local_82 = static_cast<uint>(_e168);
    uint _e172 = local_81.inner[1];
    local_83 = static_cast<uint>(_e172);
    uint _e175 = local_83;
    out[_e175] = _e154;
    int _e178 = grouped_labels(2u);
    type_4 _e180 = local;
    local_15 = _e180;
    local_16 = static_cast<uint>(7);
    type_4 _e185 = local_15;
    local_84 = _e185;
    uint _e186 = local_16;
    uint _e188 = local_84.inner[1];
    local_84.inner[1] = _e188 + _e186;
    uint _e192 = local_84.inner[0];
    local_85 = static_cast<uint>(_e192);
    uint _e196 = local_84.inner[1];
    local_86 = static_cast<uint>(_e196);
    uint _e199 = local_86;
    out[_e199] = _e178;
    int _e202 = grouped_labels(8u);
    type_4 _e204 = local;
    local_17 = _e204;
    local_18 = static_cast<uint>(8);
    type_4 _e209 = local_17;
    local_87 = _e209;
    uint _e210 = local_18;
    uint _e212 = local_87.inner[1];
    local_87.inner[1] = _e212 + _e210;
    uint _e216 = local_87.inner[0];
    local_88 = static_cast<uint>(_e216);
    uint _e220 = local_87.inner[1];
    local_89 = static_cast<uint>(_e220);
    uint _e223 = local_89;
    out[_e223] = _e202;
    int _e227 = nested_switches(0, 0);
    type_4 _e229 = local;
    local_19 = _e229;
    local_20 = static_cast<uint>(9);
    type_4 _e234 = local_19;
    local_90 = _e234;
    uint _e235 = local_20;
    uint _e237 = local_90.inner[1];
    local_90.inner[1] = _e237 + _e235;
    uint _e241 = local_90.inner[0];
    local_91 = static_cast<uint>(_e241);
    uint _e245 = local_90.inner[1];
    local_92 = static_cast<uint>(_e245);
    uint _e248 = local_92;
    out[_e248] = _e227;
    int _e252 = nested_switches(0, 8);
    type_4 _e254 = local;
    local_21 = _e254;
    local_22 = static_cast<uint>(10);
    type_4 _e259 = local_21;
    local_93 = _e259;
    uint _e260 = local_22;
    uint _e262 = local_93.inner[1];
    local_93.inner[1] = _e262 + _e260;
    uint _e266 = local_93.inner[0];
    local_94 = static_cast<uint>(_e266);
    uint _e270 = local_93.inner[1];
    local_95 = static_cast<uint>(_e270);
    uint _e273 = local_95;
    out[_e273] = _e252;
    int _e277 = nested_switches(1, 0);
    type_4 _e279 = local;
    local_23 = _e279;
    local_24 = static_cast<uint>(11);
    type_4 _e284 = local_23;
    local_96 = _e284;
    uint _e285 = local_24;
    uint _e287 = local_96.inner[1];
    local_96.inner[1] = _e287 + _e285;
    uint _e291 = local_96.inner[0];
    local_97 = static_cast<uint>(_e291);
    uint _e295 = local_96.inner[1];
    local_98 = static_cast<uint>(_e295);
    uint _e298 = local_98;
    out[_e298] = _e277;
    int _e302 = nested_switches(8, 0);
    type_4 _e304 = local;
    local_25 = _e304;
    local_26 = static_cast<uint>(12);
    type_4 _e309 = local_25;
    local_99 = _e309;
    uint _e310 = local_26;
    uint _e312 = local_99.inner[1];
    local_99.inner[1] = _e312 + _e310;
    uint _e316 = local_99.inner[0];
    local_100 = static_cast<uint>(_e316);
    uint _e320 = local_99.inner[1];
    local_101 = static_cast<uint>(_e320);
    uint _e323 = local_101;
    out[_e323] = _e302;
    int _e326 = loop_jumps(0);
    type_4 _e328 = local;
    local_27 = _e328;
    local_28 = static_cast<uint>(13);
    type_4 _e333 = local_27;
    local_102 = _e333;
    uint _e334 = local_28;
    uint _e336 = local_102.inner[1];
    local_102.inner[1] = _e336 + _e334;
    uint _e340 = local_102.inner[0];
    local_103 = static_cast<uint>(_e340);
    uint _e344 = local_102.inner[1];
    local_104 = static_cast<uint>(_e344);
    uint _e347 = local_104;
    out[_e347] = _e326;
    int _e350 = loop_jumps(1);
    type_4 _e352 = local;
    local_29 = _e352;
    local_30 = static_cast<uint>(14);
    type_4 _e357 = local_29;
    local_105 = _e357;
    uint _e358 = local_30;
    uint _e360 = local_105.inner[1];
    local_105.inner[1] = _e360 + _e358;
    uint _e364 = local_105.inner[0];
    local_106 = static_cast<uint>(_e364);
    uint _e368 = local_105.inner[1];
    local_107 = static_cast<uint>(_e368);
    uint _e371 = local_107;
    out[_e371] = _e350;
    int _e374 = loop_jumps(8);
    type_4 _e376 = local;
    local_31 = _e376;
    local_32 = static_cast<uint>(15);
    type_4 _e381 = local_31;
    local_108 = _e381;
    uint _e382 = local_32;
    uint _e384 = local_108.inner[1];
    local_108.inner[1] = _e384 + _e382;
    uint _e388 = local_108.inner[0];
    local_109 = static_cast<uint>(_e388);
    uint _e392 = local_108.inner[1];
    local_110 = static_cast<uint>(_e392);
    uint _e395 = local_110;
    out[_e395] = _e374;
    int _e399 = terminal_paths(0, 1);
    type_4 _e401 = local;
    local_33 = _e401;
    local_34 = static_cast<uint>(16);
    type_4 _e406 = local_33;
    local_111 = _e406;
    uint _e407 = local_34;
    uint _e409 = local_111.inner[1];
    local_111.inner[1] = _e409 + _e407;
    uint _e413 = local_111.inner[0];
    local_112 = static_cast<uint>(_e413);
    uint _e417 = local_111.inner[1];
    local_113 = static_cast<uint>(_e417);
    uint _e420 = local_113;
    out[_e420] = _e399;
    int _e424 = terminal_paths(0, 0);
    type_4 _e426 = local;
    local_35 = _e426;
    local_36 = static_cast<uint>(17);
    type_4 _e431 = local_35;
    local_114 = _e431;
    uint _e432 = local_36;
    uint _e434 = local_114.inner[1];
    local_114.inner[1] = _e434 + _e432;
    uint _e438 = local_114.inner[0];
    local_115 = static_cast<uint>(_e438);
    uint _e442 = local_114.inner[1];
    local_116 = static_cast<uint>(_e442);
    uint _e445 = local_116;
    out[_e445] = _e424;
    int _e449 = terminal_paths(1, 1);
    type_4 _e451 = local;
    local_37 = _e451;
    local_38 = static_cast<uint>(18);
    type_4 _e456 = local_37;
    local_117 = _e456;
    uint _e457 = local_38;
    uint _e459 = local_117.inner[1];
    local_117.inner[1] = _e459 + _e457;
    uint _e463 = local_117.inner[0];
    local_118 = static_cast<uint>(_e463);
    uint _e467 = local_117.inner[1];
    local_119 = static_cast<uint>(_e467);
    uint _e470 = local_119;
    out[_e470] = _e449;
    int _e474 = terminal_paths(8, 0);
    type_4 _e476 = local;
    local_39 = _e476;
    local_40 = static_cast<uint>(19);
    type_4 _e481 = local_39;
    local_120 = _e481;
    uint _e482 = local_40;
    uint _e484 = local_120.inner[1];
    local_120.inner[1] = _e484 + _e482;
    uint _e488 = local_120.inner[0];
    local_121 = static_cast<uint>(_e488);
    uint _e492 = local_120.inner[1];
    local_122 = static_cast<uint>(_e492);
    uint _e495 = local_122;
    out[_e495] = _e474;
    int _e499 = terminal_paths(2, 0);
    type_4 _e501 = local;
    local_41 = _e501;
    local_42 = static_cast<uint>(20);
    type_4 _e506 = local_41;
    local_123 = _e506;
    uint _e507 = local_42;
    uint _e509 = local_123.inner[1];
    local_123.inner[1] = _e509 + _e507;
    uint _e513 = local_123.inner[0];
    local_124 = static_cast<uint>(_e513);
    uint _e517 = local_123.inner[1];
    local_125 = static_cast<uint>(_e517);
    uint _e520 = local_125;
    out[_e520] = _e499;
    counter = 0;
    int _e524 = counter;
    counter = as_type<int>(as_type<uint>(_e524) + as_type<uint>(1));
    switch(_e524) {
        case 0: {
            int _e527 = counter;
            type_4 _e529 = local;
            local_43 = _e529;
            local_44 = static_cast<uint>(21);
            type_4 _e534 = local_43;
            local_126 = _e534;
            uint _e535 = local_44;
            uint _e537 = local_126.inner[1];
            local_126.inner[1] = _e537 + _e535;
            uint _e541 = local_126.inner[0];
            local_127 = static_cast<uint>(_e541);
            uint _e545 = local_126.inner[1];
            local_128 = static_cast<uint>(_e545);
            uint _e548 = local_128;
            out[_e548] = _e527;
            int _e550 = counter;
            type_4 _e554 = local;
            local_45 = _e554;
            local_46 = static_cast<uint>(22);
            type_4 _e559 = local_45;
            local_129 = _e559;
            uint _e560 = local_46;
            uint _e562 = local_129.inner[1];
            local_129.inner[1] = _e562 + _e560;
            uint _e566 = local_129.inner[0];
            local_130 = static_cast<uint>(_e566);
            uint _e570 = local_129.inner[1];
            local_131 = static_cast<uint>(_e570);
            uint _e573 = local_131;
            out[_e573] = as_type<int>(as_type<uint>(_e550) + as_type<uint>(1));
            break;
        }
        case 1: {
            int _e575 = counter;
            type_4 _e579 = local;
            local_45 = _e579;
            local_46 = static_cast<uint>(22);
            type_4 _e584 = local_45;
            local_132 = _e584;
            uint _e585 = local_46;
            uint _e587 = local_132.inner[1];
            local_132.inner[1] = _e587 + _e585;
            uint _e591 = local_132.inner[0];
            local_133 = static_cast<uint>(_e591);
            uint _e595 = local_132.inner[1];
            local_134 = static_cast<uint>(_e595);
            uint _e598 = local_134;
            out[_e598] = as_type<int>(as_type<uint>(_e575) + as_type<uint>(1));
            break;
        }
        default: {
            type_4 _e601 = local;
            local_47 = _e601;
            local_48 = static_cast<uint>(21);
            type_4 _e606 = local_47;
            local_135 = _e606;
            uint _e607 = local_48;
            uint _e609 = local_135.inner[1];
            local_135.inner[1] = _e609 + _e607;
            uint _e613 = local_135.inner[0];
            local_136 = static_cast<uint>(_e613);
            uint _e617 = local_135.inner[1];
            local_137 = static_cast<uint>(_e617);
            uint _e621 = local_137;
            out[_e621] = 99;
            break;
        }
    }
    int _e623 = counter;
    type_4 _e625 = local;
    local_49 = _e625;
    local_50 = static_cast<uint>(23);
    type_4 _e630 = local_49;
    local_138 = _e630;
    uint _e631 = local_50;
    uint _e633 = local_138.inner[1];
    local_138.inner[1] = _e633 + _e631;
    uint _e637 = local_138.inner[0];
    local_139 = static_cast<uint>(_e637);
    uint _e641 = local_138.inner[1];
    local_140 = static_cast<uint>(_e641);
    uint _e644 = local_140;
    out[_e644] = _e623;
    metal::int2 _e648 = call_results(0, 0);
    first = _e648;
    int _e651 = first.y;
    metal::int2 _e653 = call_results(1, _e651);
    second = _e653;
    int _e656 = second.y;
    metal::int2 _e658 = call_results(8, _e656);
    third = _e658;
    int _e661 = first.x;
    type_4 _e663 = local;
    local_51 = _e663;
    local_52 = static_cast<uint>(24);
    type_4 _e668 = local_51;
    local_141 = _e668;
    uint _e669 = local_52;
    uint _e671 = local_141.inner[1];
    local_141.inner[1] = _e671 + _e669;
    uint _e675 = local_141.inner[0];
    local_142 = static_cast<uint>(_e675);
    uint _e679 = local_141.inner[1];
    local_143 = static_cast<uint>(_e679);
    uint _e682 = local_143;
    out[_e682] = _e661;
    int _e685 = second.x;
    type_4 _e687 = local;
    local_53 = _e687;
    local_54 = static_cast<uint>(25);
    type_4 _e692 = local_53;
    local_144 = _e692;
    uint _e693 = local_54;
    uint _e695 = local_144.inner[1];
    local_144.inner[1] = _e695 + _e693;
    uint _e699 = local_144.inner[0];
    local_145 = static_cast<uint>(_e699);
    uint _e703 = local_144.inner[1];
    local_146 = static_cast<uint>(_e703);
    uint _e706 = local_146;
    out[_e706] = _e685;
    int _e709 = third.x;
    type_4 _e711 = local;
    local_55 = _e711;
    local_56 = static_cast<uint>(26);
    type_4 _e716 = local_55;
    local_147 = _e716;
    uint _e717 = local_56;
    uint _e719 = local_147.inner[1];
    local_147.inner[1] = _e719 + _e717;
    uint _e723 = local_147.inner[0];
    local_148 = static_cast<uint>(_e723);
    uint _e727 = local_147.inner[1];
    local_149 = static_cast<uint>(_e727);
    uint _e730 = local_149;
    out[_e730] = _e709;
    int _e733 = third.y;
    type_4 _e735 = local;
    local_57 = _e735;
    local_58 = static_cast<uint>(27);
    type_4 _e740 = local_57;
    local_150 = _e740;
    uint _e741 = local_58;
    uint _e743 = local_150.inner[1];
    local_150.inner[1] = _e743 + _e741;
    uint _e747 = local_150.inner[0];
    local_151 = static_cast<uint>(_e747);
    uint _e751 = local_150.inner[1];
    local_152 = static_cast<uint>(_e751);
    uint _e754 = local_152;
    out[_e754] = _e733;
    int _e757 = third.y;
    counter = _e757;
    int _e759 = third.x;
    int _e760 = counter;
    counter = as_type<int>(as_type<uint>(_e760) + as_type<uint>(1));
    int _e763 = counter;
    int _e764 = update_value(_e759, _e763);
    type_4 _e766 = local;
    local_59 = _e766;
    local_60 = static_cast<uint>(28);
    type_4 _e771 = local_59;
    local_153 = _e771;
    uint _e772 = local_60;
    uint _e774 = local_153.inner[1];
    local_153.inner[1] = _e774 + _e772;
    uint _e778 = local_153.inner[0];
    local_154 = static_cast<uint>(_e778);
    uint _e782 = local_153.inner[1];
    local_155 = static_cast<uint>(_e782);
    uint _e785 = local_155;
    out[_e785] = _e764;
    int _e787 = counter;
    type_4 _e789 = local;
    local_61 = _e789;
    local_62 = static_cast<uint>(29);
    type_4 _e794 = local_61;
    local_156 = _e794;
    uint _e795 = local_62;
    uint _e797 = local_156.inner[1];
    local_156.inner[1] = _e797 + _e795;
    uint _e801 = local_156.inner[0];
    local_157 = static_cast<uint>(_e801);
    uint _e805 = local_156.inner[1];
    local_158 = static_cast<uint>(_e805);
    uint _e808 = local_158;
    out[_e808] = _e787;
}
