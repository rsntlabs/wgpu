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
    int result = {};
    result = 0;
    switch(selector) {
        case -1: {
            int _e3 = result;
            result = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
            int _e6 = result;
            result = as_type<int>(as_type<uint>(_e6) + as_type<uint>(10));
            int _e9 = result;
            result = as_type<int>(as_type<uint>(_e9) + as_type<uint>(100));
            break;
        }
        case 0: {
            int _e12 = result;
            result = as_type<int>(as_type<uint>(_e12) + as_type<uint>(10));
            int _e15 = result;
            result = as_type<int>(as_type<uint>(_e15) + as_type<uint>(100));
            break;
        }
        case 1: {
            int _e18 = result;
            result = as_type<int>(as_type<uint>(_e18) + as_type<uint>(100));
            break;
        }
        default: {
            int _e21 = result;
            result = as_type<int>(as_type<uint>(_e21) + as_type<uint>(1000));
            int _e24 = result;
            result = as_type<int>(as_type<uint>(_e24) + as_type<uint>(10000));
            break;
        }
        case 2: {
            int _e27 = result;
            result = as_type<int>(as_type<uint>(_e27) + as_type<uint>(10000));
            break;
        }
    }
    int _e30 = result;
    return _e30;
}

int grouped_labels(
    uint selector_1
) {
    int result_1 = {};
    result_1 = 0;
    switch(selector_1) {
        case 0u: {
            int _e3 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(3));
            int _e6 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e6) + as_type<uint>(5));
            break;
        }
        case 1u: {
            int _e9 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e9) + as_type<uint>(3));
            int _e12 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(5));
            break;
        }
        case 2u: {
            int _e15 = result_1;
            result_1 = as_type<int>(as_type<uint>(_e15) + as_type<uint>(5));
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

int nested_switches(
    int outer,
    int inner
) {
    int result_2 = {};
    result_2 = 0;
    switch(outer) {
        case 0: {
            int _e4 = result_2;
            result_2 = as_type<int>(as_type<uint>(_e4) + as_type<uint>(1));
            switch(inner) {
                case 0: {
                    int _e7 = result_2;
                    result_2 = as_type<int>(as_type<uint>(_e7) + as_type<uint>(10));
                    int _e10 = result_2;
                    result_2 = as_type<int>(as_type<uint>(_e10) + as_type<uint>(20));
                    break;
                }
                default: {
                    int _e13 = result_2;
                    result_2 = as_type<int>(as_type<uint>(_e13) + as_type<uint>(20));
                    break;
                }
            }
            int _e16 = result_2;
            result_2 = as_type<int>(as_type<uint>(_e16) + as_type<uint>(100));
            break;
        }
        case 1: {
            int _e19 = result_2;
            result_2 = as_type<int>(as_type<uint>(_e19) + as_type<uint>(100));
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

int loop_jumps(
    int selector_2
) {
    int result_3 = {};
    int iteration = {};
    result_3 = 0;
    {
        iteration = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e34 = iteration;
                iteration = as_type<int>(as_type<uint>(_e34) + as_type<uint>(1));
            }
            loop_init = false;
            int _e5 = iteration;
            if (_e5 < 4) {
            } else {
                break;
            }
            switch(selector_2) {
                case 0: {
                    int _e8 = iteration;
                    if (_e8 == 1) {
                        continue;
                    }
                    int _e11 = iteration;
                    int _e14 = result_3;
                    result_3 = as_type<int>(as_type<uint>(_e14) + as_type<uint>(as_type<int>(as_type<uint>(_e11) + as_type<uint>(1))));
                    int _e16 = iteration;
                    if (_e16 == 2) {
                        break;
                    }
                    int _e19 = result_3;
                    result_3 = as_type<int>(as_type<uint>(_e19) + as_type<uint>(10));
                    break;
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
    int _e37 = result_3;
    return _e37;
}

int terminal_paths(
    int selector_3,
    int flag
) {
    int result_4 = {};
    result_4 = 0;
    switch(selector_3) {
        case 0: {
            if (flag != 0) {
                return 3;
            }
            int _e7 = result_4;
            result_4 = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
            int _e10 = result_4;
            return as_type<int>(as_type<uint>(_e10) + as_type<uint>(5));
        }
        case 1: {
            int _e13 = result_4;
            return as_type<int>(as_type<uint>(_e13) + as_type<uint>(5));
        }
        default: {
            result_4 = 9;
            {
                int _e17 = result_4;
                return as_type<int>(as_type<uint>(_e17) + as_type<uint>(10));
            }
            break;
        }
        case 2: {
            {
                int _e20 = result_4;
                return as_type<int>(as_type<uint>(_e20) + as_type<uint>(10));
            }
            break;
        }
    }
}

int update_value(
    int value,
    int token
) {
    return as_type<int>(as_type<uint>(value) + as_type<uint>(token));
}

metal::int2 call_results(
    int selector_4,
    int counter_1
) {
    int counter_2 = {};
    int result_5 = {};
    int named_value = {};
    int named_value_1 = {};
    int named_value_2 = {};
    counter_2 = counter_1;
    result_5 = 2;
    switch(selector_4) {
        case 0: {
            {
                int _e5 = result_5;
                int _e6 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
                int _e9 = counter_2;
                int _e10 = update_value(_e5, _e9);
                named_value = _e10;
                int _e12 = named_value;
                int _e13 = named_value;
                result_5 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(_e13));
            }
            {
                int _e15 = result_5;
                int _e16 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e16) + as_type<uint>(1));
                int _e19 = counter_2;
                int _e20 = update_value(_e15, _e19);
                named_value_1 = _e20;
                int _e22 = named_value_1;
                int _e23 = named_value_1;
                result_5 = as_type<int>(as_type<uint>(_e22) * as_type<uint>(_e23));
            }
            {
                int _e25 = result_5;
                int _e26 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e26) + as_type<uint>(1));
                int _e29 = counter_2;
                int _e30 = update_value(_e25, _e29);
                named_value_2 = _e30;
                int _e32 = named_value_2;
                int _e33 = named_value_2;
                result_5 = as_type<int>(as_type<uint>(_e32) + as_type<uint>(_e33));
                break;
            }
            break;
        }
        case 1: {
            {
                int _e35 = result_5;
                int _e36 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e36) + as_type<uint>(1));
                int _e39 = counter_2;
                int _e40 = update_value(_e35, _e39);
                named_value_1 = _e40;
                int _e42 = named_value_1;
                int _e43 = named_value_1;
                result_5 = as_type<int>(as_type<uint>(_e42) * as_type<uint>(_e43));
            }
            {
                int _e45 = result_5;
                int _e46 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e46) + as_type<uint>(1));
                int _e49 = counter_2;
                int _e50 = update_value(_e45, _e49);
                named_value_2 = _e50;
                int _e52 = named_value_2;
                int _e53 = named_value_2;
                result_5 = as_type<int>(as_type<uint>(_e52) + as_type<uint>(_e53));
                break;
            }
            break;
        }
        default: {
            {
                int _e55 = result_5;
                int _e56 = counter_2;
                counter_2 = as_type<int>(as_type<uint>(_e56) + as_type<uint>(1));
                int _e59 = counter_2;
                int _e60 = update_value(_e55, _e59);
                named_value_2 = _e60;
                int _e62 = named_value_2;
                int _e63 = named_value_2;
                result_5 = as_type<int>(as_type<uint>(_e62) + as_type<uint>(_e63));
                break;
            }
            break;
        }
    }
    int _e65 = result_5;
    int _e66 = counter_2;
    return metal::int2(_e65, _e66);
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void switches(
  device type_3& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_4 out = {};
    type_4 local = {};
    uint local_1 = {};
    type_4 local_2 = {};
    uint local_3 = {};
    type_4 local_4 = {};
    uint local_5 = {};
    type_4 local_6 = {};
    uint local_7 = {};
    type_4 local_8 = {};
    uint local_9 = {};
    type_4 local_10 = {};
    uint local_11 = {};
    type_4 local_12 = {};
    uint local_13 = {};
    type_4 local_14 = {};
    uint local_15 = {};
    type_4 local_16 = {};
    uint local_17 = {};
    type_4 local_18 = {};
    uint local_19 = {};
    type_4 local_20 = {};
    uint local_21 = {};
    type_4 local_22 = {};
    uint local_23 = {};
    type_4 local_24 = {};
    uint local_25 = {};
    type_4 local_26 = {};
    uint local_27 = {};
    type_4 local_28 = {};
    uint local_29 = {};
    type_4 local_30 = {};
    uint local_31 = {};
    type_4 local_32 = {};
    uint local_33 = {};
    type_4 local_34 = {};
    uint local_35 = {};
    type_4 local_36 = {};
    uint local_37 = {};
    type_4 local_38 = {};
    uint local_39 = {};
    type_4 local_40 = {};
    uint local_41 = {};
    int counter = {};
    type_4 local_42 = {};
    uint local_43 = {};
    type_4 local_44 = {};
    uint local_45 = {};
    type_4 local_46 = {};
    uint local_47 = {};
    type_4 local_48 = {};
    uint local_49 = {};
    metal::int2 first = {};
    metal::int2 second = {};
    metal::int2 third = {};
    type_4 local_50 = {};
    uint local_51 = {};
    type_4 local_52 = {};
    uint local_53 = {};
    type_4 local_54 = {};
    uint local_55 = {};
    type_4 local_56 = {};
    uint local_57 = {};
    type_4 local_58 = {};
    uint local_59 = {};
    type_4 local_60 = {};
    uint local_61 = {};
    type_4 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_4 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_4 local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    type_4 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    type_4 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_4 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_4 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    type_4 local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    type_4 local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    type_4 local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    type_4 local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    type_4 local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    type_4 local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    type_4 local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    type_4 local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    type_4 local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    type_4 local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    type_4 local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    type_4 local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    type_4 local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    type_4 local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    type_4 local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    type_4 local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    type_4 local_131 = {};
    uint local_132 = {};
    uint local_133 = {};
    type_4 local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    type_4 local_137 = {};
    uint local_138 = {};
    uint local_139 = {};
    type_4 local_140 = {};
    uint local_141 = {};
    uint local_142 = {};
    type_4 local_143 = {};
    uint local_144 = {};
    uint local_145 = {};
    type_4 local_146 = {};
    uint local_147 = {};
    uint local_148 = {};
    type_4 local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    type_4 local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    type_4 local_155 = {};
    uint local_156 = {};
    uint local_157 = {};
    out = type_4 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    int _e9 = case_chain(naga_neg(1));
    type_4 _e12 = out;
    local = _e12;
    local_1 = static_cast<uint>(0);
    type_4 _e17 = local;
    local_62 = _e17;
    uint _e18 = local_1;
    uint _e20 = local_62.inner[1];
    local_62.inner[1] = _e20 + _e18;
    uint _e24 = local_62.inner[0];
    local_63 = static_cast<uint>(_e24);
    uint _e28 = local_62.inner[1];
    local_64 = static_cast<uint>(_e28);
    uint _e31 = local_64;
    out_1[_e31] = _e9;
    int _e34 = case_chain(0);
    type_4 _e36 = out;
    local_2 = _e36;
    local_3 = static_cast<uint>(1);
    type_4 _e41 = local_2;
    local_65 = _e41;
    uint _e42 = local_3;
    uint _e44 = local_65.inner[1];
    local_65.inner[1] = _e44 + _e42;
    uint _e48 = local_65.inner[0];
    local_66 = static_cast<uint>(_e48);
    uint _e52 = local_65.inner[1];
    local_67 = static_cast<uint>(_e52);
    uint _e55 = local_67;
    out_1[_e55] = _e34;
    int _e58 = case_chain(1);
    type_4 _e60 = out;
    local_4 = _e60;
    local_5 = static_cast<uint>(2);
    type_4 _e65 = local_4;
    local_68 = _e65;
    uint _e66 = local_5;
    uint _e68 = local_68.inner[1];
    local_68.inner[1] = _e68 + _e66;
    uint _e72 = local_68.inner[0];
    local_69 = static_cast<uint>(_e72);
    uint _e76 = local_68.inner[1];
    local_70 = static_cast<uint>(_e76);
    uint _e79 = local_70;
    out_1[_e79] = _e58;
    int _e82 = case_chain(2);
    type_4 _e84 = out;
    local_6 = _e84;
    local_7 = static_cast<uint>(3);
    type_4 _e89 = local_6;
    local_71 = _e89;
    uint _e90 = local_7;
    uint _e92 = local_71.inner[1];
    local_71.inner[1] = _e92 + _e90;
    uint _e96 = local_71.inner[0];
    local_72 = static_cast<uint>(_e96);
    uint _e100 = local_71.inner[1];
    local_73 = static_cast<uint>(_e100);
    uint _e103 = local_73;
    out_1[_e103] = _e82;
    int _e106 = case_chain(8);
    type_4 _e108 = out;
    local_8 = _e108;
    local_9 = static_cast<uint>(4);
    type_4 _e113 = local_8;
    local_74 = _e113;
    uint _e114 = local_9;
    uint _e116 = local_74.inner[1];
    local_74.inner[1] = _e116 + _e114;
    uint _e120 = local_74.inner[0];
    local_75 = static_cast<uint>(_e120);
    uint _e124 = local_74.inner[1];
    local_76 = static_cast<uint>(_e124);
    uint _e127 = local_76;
    out_1[_e127] = _e106;
    int _e130 = grouped_labels(0u);
    type_4 _e132 = out;
    local_10 = _e132;
    local_11 = static_cast<uint>(5);
    type_4 _e137 = local_10;
    local_77 = _e137;
    uint _e138 = local_11;
    uint _e140 = local_77.inner[1];
    local_77.inner[1] = _e140 + _e138;
    uint _e144 = local_77.inner[0];
    local_78 = static_cast<uint>(_e144);
    uint _e148 = local_77.inner[1];
    local_79 = static_cast<uint>(_e148);
    uint _e151 = local_79;
    out_1[_e151] = _e130;
    int _e154 = grouped_labels(1u);
    type_4 _e156 = out;
    local_12 = _e156;
    local_13 = static_cast<uint>(6);
    type_4 _e161 = local_12;
    local_80 = _e161;
    uint _e162 = local_13;
    uint _e164 = local_80.inner[1];
    local_80.inner[1] = _e164 + _e162;
    uint _e168 = local_80.inner[0];
    local_81 = static_cast<uint>(_e168);
    uint _e172 = local_80.inner[1];
    local_82 = static_cast<uint>(_e172);
    uint _e175 = local_82;
    out_1[_e175] = _e154;
    int _e178 = grouped_labels(2u);
    type_4 _e180 = out;
    local_14 = _e180;
    local_15 = static_cast<uint>(7);
    type_4 _e185 = local_14;
    local_83 = _e185;
    uint _e186 = local_15;
    uint _e188 = local_83.inner[1];
    local_83.inner[1] = _e188 + _e186;
    uint _e192 = local_83.inner[0];
    local_84 = static_cast<uint>(_e192);
    uint _e196 = local_83.inner[1];
    local_85 = static_cast<uint>(_e196);
    uint _e199 = local_85;
    out_1[_e199] = _e178;
    int _e202 = grouped_labels(8u);
    type_4 _e204 = out;
    local_16 = _e204;
    local_17 = static_cast<uint>(8);
    type_4 _e209 = local_16;
    local_86 = _e209;
    uint _e210 = local_17;
    uint _e212 = local_86.inner[1];
    local_86.inner[1] = _e212 + _e210;
    uint _e216 = local_86.inner[0];
    local_87 = static_cast<uint>(_e216);
    uint _e220 = local_86.inner[1];
    local_88 = static_cast<uint>(_e220);
    uint _e223 = local_88;
    out_1[_e223] = _e202;
    int _e227 = nested_switches(0, 0);
    type_4 _e229 = out;
    local_18 = _e229;
    local_19 = static_cast<uint>(9);
    type_4 _e234 = local_18;
    local_89 = _e234;
    uint _e235 = local_19;
    uint _e237 = local_89.inner[1];
    local_89.inner[1] = _e237 + _e235;
    uint _e241 = local_89.inner[0];
    local_90 = static_cast<uint>(_e241);
    uint _e245 = local_89.inner[1];
    local_91 = static_cast<uint>(_e245);
    uint _e248 = local_91;
    out_1[_e248] = _e227;
    int _e252 = nested_switches(0, 8);
    type_4 _e254 = out;
    local_20 = _e254;
    local_21 = static_cast<uint>(10);
    type_4 _e259 = local_20;
    local_92 = _e259;
    uint _e260 = local_21;
    uint _e262 = local_92.inner[1];
    local_92.inner[1] = _e262 + _e260;
    uint _e266 = local_92.inner[0];
    local_93 = static_cast<uint>(_e266);
    uint _e270 = local_92.inner[1];
    local_94 = static_cast<uint>(_e270);
    uint _e273 = local_94;
    out_1[_e273] = _e252;
    int _e277 = nested_switches(1, 0);
    type_4 _e279 = out;
    local_22 = _e279;
    local_23 = static_cast<uint>(11);
    type_4 _e284 = local_22;
    local_95 = _e284;
    uint _e285 = local_23;
    uint _e287 = local_95.inner[1];
    local_95.inner[1] = _e287 + _e285;
    uint _e291 = local_95.inner[0];
    local_96 = static_cast<uint>(_e291);
    uint _e295 = local_95.inner[1];
    local_97 = static_cast<uint>(_e295);
    uint _e298 = local_97;
    out_1[_e298] = _e277;
    int _e302 = nested_switches(8, 0);
    type_4 _e304 = out;
    local_24 = _e304;
    local_25 = static_cast<uint>(12);
    type_4 _e309 = local_24;
    local_98 = _e309;
    uint _e310 = local_25;
    uint _e312 = local_98.inner[1];
    local_98.inner[1] = _e312 + _e310;
    uint _e316 = local_98.inner[0];
    local_99 = static_cast<uint>(_e316);
    uint _e320 = local_98.inner[1];
    local_100 = static_cast<uint>(_e320);
    uint _e323 = local_100;
    out_1[_e323] = _e302;
    int _e326 = loop_jumps(0);
    type_4 _e328 = out;
    local_26 = _e328;
    local_27 = static_cast<uint>(13);
    type_4 _e333 = local_26;
    local_101 = _e333;
    uint _e334 = local_27;
    uint _e336 = local_101.inner[1];
    local_101.inner[1] = _e336 + _e334;
    uint _e340 = local_101.inner[0];
    local_102 = static_cast<uint>(_e340);
    uint _e344 = local_101.inner[1];
    local_103 = static_cast<uint>(_e344);
    uint _e347 = local_103;
    out_1[_e347] = _e326;
    int _e350 = loop_jumps(1);
    type_4 _e352 = out;
    local_28 = _e352;
    local_29 = static_cast<uint>(14);
    type_4 _e357 = local_28;
    local_104 = _e357;
    uint _e358 = local_29;
    uint _e360 = local_104.inner[1];
    local_104.inner[1] = _e360 + _e358;
    uint _e364 = local_104.inner[0];
    local_105 = static_cast<uint>(_e364);
    uint _e368 = local_104.inner[1];
    local_106 = static_cast<uint>(_e368);
    uint _e371 = local_106;
    out_1[_e371] = _e350;
    int _e374 = loop_jumps(8);
    type_4 _e376 = out;
    local_30 = _e376;
    local_31 = static_cast<uint>(15);
    type_4 _e381 = local_30;
    local_107 = _e381;
    uint _e382 = local_31;
    uint _e384 = local_107.inner[1];
    local_107.inner[1] = _e384 + _e382;
    uint _e388 = local_107.inner[0];
    local_108 = static_cast<uint>(_e388);
    uint _e392 = local_107.inner[1];
    local_109 = static_cast<uint>(_e392);
    uint _e395 = local_109;
    out_1[_e395] = _e374;
    int _e399 = terminal_paths(0, 1);
    type_4 _e401 = out;
    local_32 = _e401;
    local_33 = static_cast<uint>(16);
    type_4 _e406 = local_32;
    local_110 = _e406;
    uint _e407 = local_33;
    uint _e409 = local_110.inner[1];
    local_110.inner[1] = _e409 + _e407;
    uint _e413 = local_110.inner[0];
    local_111 = static_cast<uint>(_e413);
    uint _e417 = local_110.inner[1];
    local_112 = static_cast<uint>(_e417);
    uint _e420 = local_112;
    out_1[_e420] = _e399;
    int _e424 = terminal_paths(0, 0);
    type_4 _e426 = out;
    local_34 = _e426;
    local_35 = static_cast<uint>(17);
    type_4 _e431 = local_34;
    local_113 = _e431;
    uint _e432 = local_35;
    uint _e434 = local_113.inner[1];
    local_113.inner[1] = _e434 + _e432;
    uint _e438 = local_113.inner[0];
    local_114 = static_cast<uint>(_e438);
    uint _e442 = local_113.inner[1];
    local_115 = static_cast<uint>(_e442);
    uint _e445 = local_115;
    out_1[_e445] = _e424;
    int _e449 = terminal_paths(1, 1);
    type_4 _e451 = out;
    local_36 = _e451;
    local_37 = static_cast<uint>(18);
    type_4 _e456 = local_36;
    local_116 = _e456;
    uint _e457 = local_37;
    uint _e459 = local_116.inner[1];
    local_116.inner[1] = _e459 + _e457;
    uint _e463 = local_116.inner[0];
    local_117 = static_cast<uint>(_e463);
    uint _e467 = local_116.inner[1];
    local_118 = static_cast<uint>(_e467);
    uint _e470 = local_118;
    out_1[_e470] = _e449;
    int _e474 = terminal_paths(8, 0);
    type_4 _e476 = out;
    local_38 = _e476;
    local_39 = static_cast<uint>(19);
    type_4 _e481 = local_38;
    local_119 = _e481;
    uint _e482 = local_39;
    uint _e484 = local_119.inner[1];
    local_119.inner[1] = _e484 + _e482;
    uint _e488 = local_119.inner[0];
    local_120 = static_cast<uint>(_e488);
    uint _e492 = local_119.inner[1];
    local_121 = static_cast<uint>(_e492);
    uint _e495 = local_121;
    out_1[_e495] = _e474;
    int _e499 = terminal_paths(2, 0);
    type_4 _e501 = out;
    local_40 = _e501;
    local_41 = static_cast<uint>(20);
    type_4 _e506 = local_40;
    local_122 = _e506;
    uint _e507 = local_41;
    uint _e509 = local_122.inner[1];
    local_122.inner[1] = _e509 + _e507;
    uint _e513 = local_122.inner[0];
    local_123 = static_cast<uint>(_e513);
    uint _e517 = local_122.inner[1];
    local_124 = static_cast<uint>(_e517);
    uint _e520 = local_124;
    out_1[_e520] = _e499;
    counter = 0;
    int _e524 = counter;
    counter = as_type<int>(as_type<uint>(_e524) + as_type<uint>(1));
    switch(_e524) {
        case 0: {
            int _e527 = counter;
            type_4 _e529 = out;
            local_42 = _e529;
            local_43 = static_cast<uint>(21);
            type_4 _e534 = local_42;
            local_125 = _e534;
            uint _e535 = local_43;
            uint _e537 = local_125.inner[1];
            local_125.inner[1] = _e537 + _e535;
            uint _e541 = local_125.inner[0];
            local_126 = static_cast<uint>(_e541);
            uint _e545 = local_125.inner[1];
            local_127 = static_cast<uint>(_e545);
            uint _e548 = local_127;
            out_1[_e548] = _e527;
            int _e550 = counter;
            type_4 _e554 = out;
            local_44 = _e554;
            local_45 = static_cast<uint>(22);
            type_4 _e559 = local_44;
            local_128 = _e559;
            uint _e560 = local_45;
            uint _e562 = local_128.inner[1];
            local_128.inner[1] = _e562 + _e560;
            uint _e566 = local_128.inner[0];
            local_129 = static_cast<uint>(_e566);
            uint _e570 = local_128.inner[1];
            local_130 = static_cast<uint>(_e570);
            uint _e573 = local_130;
            out_1[_e573] = as_type<int>(as_type<uint>(_e550) + as_type<uint>(1));
            break;
        }
        case 1: {
            int _e575 = counter;
            type_4 _e579 = out;
            local_44 = _e579;
            local_45 = static_cast<uint>(22);
            type_4 _e584 = local_44;
            local_131 = _e584;
            uint _e585 = local_45;
            uint _e587 = local_131.inner[1];
            local_131.inner[1] = _e587 + _e585;
            uint _e591 = local_131.inner[0];
            local_132 = static_cast<uint>(_e591);
            uint _e595 = local_131.inner[1];
            local_133 = static_cast<uint>(_e595);
            uint _e598 = local_133;
            out_1[_e598] = as_type<int>(as_type<uint>(_e575) + as_type<uint>(1));
            break;
        }
        default: {
            type_4 _e601 = out;
            local_46 = _e601;
            local_47 = static_cast<uint>(21);
            type_4 _e606 = local_46;
            local_134 = _e606;
            uint _e607 = local_47;
            uint _e609 = local_134.inner[1];
            local_134.inner[1] = _e609 + _e607;
            uint _e613 = local_134.inner[0];
            local_135 = static_cast<uint>(_e613);
            uint _e617 = local_134.inner[1];
            local_136 = static_cast<uint>(_e617);
            uint _e621 = local_136;
            out_1[_e621] = 99;
            break;
        }
    }
    int _e623 = counter;
    type_4 _e625 = out;
    local_48 = _e625;
    local_49 = static_cast<uint>(23);
    type_4 _e630 = local_48;
    local_137 = _e630;
    uint _e631 = local_49;
    uint _e633 = local_137.inner[1];
    local_137.inner[1] = _e633 + _e631;
    uint _e637 = local_137.inner[0];
    local_138 = static_cast<uint>(_e637);
    uint _e641 = local_137.inner[1];
    local_139 = static_cast<uint>(_e641);
    uint _e644 = local_139;
    out_1[_e644] = _e623;
    metal::int2 _e648 = call_results(0, 0);
    first = _e648;
    int _e651 = first.y;
    metal::int2 _e653 = call_results(1, _e651);
    second = _e653;
    int _e656 = second.y;
    metal::int2 _e658 = call_results(8, _e656);
    third = _e658;
    int _e661 = first.x;
    type_4 _e663 = out;
    local_50 = _e663;
    local_51 = static_cast<uint>(24);
    type_4 _e668 = local_50;
    local_140 = _e668;
    uint _e669 = local_51;
    uint _e671 = local_140.inner[1];
    local_140.inner[1] = _e671 + _e669;
    uint _e675 = local_140.inner[0];
    local_141 = static_cast<uint>(_e675);
    uint _e679 = local_140.inner[1];
    local_142 = static_cast<uint>(_e679);
    uint _e682 = local_142;
    out_1[_e682] = _e661;
    int _e685 = second.x;
    type_4 _e687 = out;
    local_52 = _e687;
    local_53 = static_cast<uint>(25);
    type_4 _e692 = local_52;
    local_143 = _e692;
    uint _e693 = local_53;
    uint _e695 = local_143.inner[1];
    local_143.inner[1] = _e695 + _e693;
    uint _e699 = local_143.inner[0];
    local_144 = static_cast<uint>(_e699);
    uint _e703 = local_143.inner[1];
    local_145 = static_cast<uint>(_e703);
    uint _e706 = local_145;
    out_1[_e706] = _e685;
    int _e709 = third.x;
    type_4 _e711 = out;
    local_54 = _e711;
    local_55 = static_cast<uint>(26);
    type_4 _e716 = local_54;
    local_146 = _e716;
    uint _e717 = local_55;
    uint _e719 = local_146.inner[1];
    local_146.inner[1] = _e719 + _e717;
    uint _e723 = local_146.inner[0];
    local_147 = static_cast<uint>(_e723);
    uint _e727 = local_146.inner[1];
    local_148 = static_cast<uint>(_e727);
    uint _e730 = local_148;
    out_1[_e730] = _e709;
    int _e733 = third.y;
    type_4 _e735 = out;
    local_56 = _e735;
    local_57 = static_cast<uint>(27);
    type_4 _e740 = local_56;
    local_149 = _e740;
    uint _e741 = local_57;
    uint _e743 = local_149.inner[1];
    local_149.inner[1] = _e743 + _e741;
    uint _e747 = local_149.inner[0];
    local_150 = static_cast<uint>(_e747);
    uint _e751 = local_149.inner[1];
    local_151 = static_cast<uint>(_e751);
    uint _e754 = local_151;
    out_1[_e754] = _e733;
    int _e757 = third.y;
    counter = _e757;
    int _e759 = third.x;
    int _e760 = counter;
    counter = as_type<int>(as_type<uint>(_e760) + as_type<uint>(1));
    int _e763 = counter;
    int _e764 = update_value(_e759, _e763);
    type_4 _e766 = out;
    local_58 = _e766;
    local_59 = static_cast<uint>(28);
    type_4 _e771 = local_58;
    local_152 = _e771;
    uint _e772 = local_59;
    uint _e774 = local_152.inner[1];
    local_152.inner[1] = _e774 + _e772;
    uint _e778 = local_152.inner[0];
    local_153 = static_cast<uint>(_e778);
    uint _e782 = local_152.inner[1];
    local_154 = static_cast<uint>(_e782);
    uint _e785 = local_154;
    out_1[_e785] = _e764;
    int _e787 = counter;
    type_4 _e789 = out;
    local_60 = _e789;
    local_61 = static_cast<uint>(29);
    type_4 _e794 = local_60;
    local_155 = _e794;
    uint _e795 = local_61;
    uint _e797 = local_155.inner[1];
    local_155.inner[1] = _e797 + _e795;
    uint _e801 = local_155.inner[0];
    local_156 = static_cast<uint>(_e801);
    uint _e805 = local_155.inner[1];
    local_157 = static_cast<uint>(_e805);
    uint _e808 = local_157;
    out_1[_e808] = _e787;
}
