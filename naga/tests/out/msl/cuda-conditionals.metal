// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

typedef int type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_4 {
    int inner[64];
};
struct type_8 {
    uint inner[2];
};

int shifted(
    int value_1
) {
    return as_type<int>(as_type<uint>(value_1) + as_type<uint>(10));
}

void discard(
    int value_2
) {
    int value_3 = {};
    value_3 = value_2;
    int _e3 = value_3;
    value_3 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
    return;
}

int pair(
    int x,
    int y
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(x) * as_type<uint>(10))) + as_type<uint>(y));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct conditionalsInput {
};
kernel void conditionals(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, device type_1 const& input_a_1 [[user(fake0)]]
, device type_1 const& input_b_1 [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, threadgroup type_4& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_8 out = {};
    type_8 input_a = {};
    type_8 input_b = {};
    uint base = {};
    bool choose_a = {};
    type_8 local = {};
    uint local_1 = {};
    type_8 local_2 = {};
    uint local_3 = {};
    type_8 local_4 = {};
    uint local_5 = {};
    int local_6 = {};
    int a = {};
    int b = {};
    type_8 local_7 = {};
    uint local_8 = {};
    int local_9 = {};
    type_8 local_10 = {};
    uint local_11 = {};
    type_8 local_12 = {};
    uint local_13 = {};
    int index_a = {};
    int index_b = {};
    type_8 local_14 = {};
    uint local_15 = {};
    type_8 local_16 = {};
    uint local_17 = {};
    type_8 local_18 = {};
    uint local_19 = {};
    type_8 local_20 = {};
    uint local_21 = {};
    type_8 local_22 = {};
    uint local_23 = {};
    type_8 local_24 = {};
    uint local_25 = {};
    int local_26 = {};
    type_8 local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    type_8 local_30 = {};
    uint local_31 = {};
    int c = {};
    type_8 local_32 = {};
    uint local_33 = {};
    int local_34 = {};
    type_8 local_35 = {};
    uint local_36 = {};
    int condition = {};
    type_8 local_37 = {};
    uint local_38 = {};
    type_8 local_39 = {};
    uint local_40 = {};
    uint lane = {};
    int local_value = {};
    type_8 local_41 = {};
    uint local_42 = {};
    type_8 local_43 = {};
    uint local_44 = {};
    type_8 local_45 = {};
    uint local_46 = {};
    type_8 local_47 = {};
    uint local_48 = {};
    float local_49 = {};
    type_8 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_8 local_53 = {};
    uint local_54 = {};
    bool local_55 = {};
    type_8 local_56 = {};
    uint local_57 = {};
    int local_58 = {};
    type_8 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    int shift_value = {};
    type_8 local_62 = {};
    uint local_63 = {};
    int local_64 = {};
    uint local_65 = {};
    int value = {};
    int other = {};
    type_8 local_66 = {};
    uint local_67 = {};
    int local_68 = {};
    int count = {};
    int left = {};
    int right = {};
    type_8 local_69 = {};
    uint local_70 = {};
    int local_71 = {};
    int local_72 = {};
    type_8 local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    int local_76 = {};
    type_8 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    int local_80 = {};
    type_8 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_8 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_8 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_8 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_8 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_8 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_8 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_8 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_8 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_8 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_8 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_8 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_8 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_8 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_8 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_8 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_8 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_8 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_8 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_8 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    type_8 local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    type_8 local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    type_8 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    type_8 local_150 = {};
    uint local_151 = {};
    uint local_152 = {};
    type_8 local_153 = {};
    uint local_154 = {};
    uint local_155 = {};
    out = type_8 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input_a = type_8 {};
    input_a.inner[0] = 1u;
    input_a.inner[1] = 0u;
    input_b = type_8 {};
    input_b.inner[0] = 2u;
    input_b.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 25u;
        choose_a = naga_mod(i, 2u) == 0u;
        bool _e37 = choose_a;
        if (_e37) {
            type_8 _e39 = input_a;
            local_2 = _e39;
            local_3 = static_cast<uint>(i);
            type_8 _e43 = local_2;
            local_73 = _e43;
            uint _e45 = local_3;
            uint _e47 = local_73.inner[1];
            local_73.inner[1] = _e47 + _e45;
            uint _e51 = local_73.inner[0];
            local_74 = static_cast<uint>(_e51);
            uint _e55 = local_73.inner[1];
            local_75 = static_cast<uint>(_e55);
            uint _e58 = local_75;
            int _e61 = input_a_1[_e58];
            local_76 = _e61;
            int _e63 = local_76;
            local_71 = _e63;
            int _e65 = local_71;
            local_6 = _e65;
        } else {
            type_8 _e68 = input_b;
            local_4 = _e68;
            local_5 = static_cast<uint>(i);
            type_8 _e72 = local_4;
            local_77 = _e72;
            uint _e74 = local_5;
            uint _e76 = local_77.inner[1];
            local_77.inner[1] = _e76 + _e74;
            uint _e80 = local_77.inner[0];
            local_78 = static_cast<uint>(_e80);
            uint _e84 = local_77.inner[1];
            local_79 = static_cast<uint>(_e84);
            uint _e87 = local_79;
            int _e90 = input_b_1[_e87];
            local_80 = _e90;
            int _e92 = local_80;
            local_72 = _e92;
            int _e94 = local_72;
            local_6 = _e94;
        }
        int _e97 = local_6;
        type_8 _e99 = out;
        local = _e99;
        uint _e101 = base;
        local_1 = static_cast<uint>(_e101);
        type_8 _e104 = local;
        local_81 = _e104;
        uint _e106 = local_1;
        uint _e108 = local_81.inner[1];
        local_81.inner[1] = _e108 + _e106;
        uint _e112 = local_81.inner[0];
        local_82 = static_cast<uint>(_e112);
        uint _e116 = local_81.inner[1];
        local_83 = static_cast<uint>(_e116);
        uint _e119 = local_83;
        out_1[_e119] = _e97;
        a = 3;
        b = 5;
        bool _e126 = choose_a;
        if (_e126) {
            int _e127 = a;
            a = as_type<int>(as_type<uint>(_e127) + as_type<uint>(1));
            int _e130 = shifted(_e127);
            local_9 = _e130;
        } else {
            int _e132 = b;
            b = as_type<int>(as_type<uint>(_e132) + as_type<uint>(1));
            int _e135 = shifted(_e132);
            local_9 = _e135;
        }
        int _e138 = local_9;
        type_8 _e139 = out;
        local_7 = _e139;
        uint _e141 = base;
        local_8 = static_cast<uint>(_e141 + 1u);
        type_8 _e146 = local_7;
        local_84 = _e146;
        uint _e148 = local_8;
        uint _e150 = local_84.inner[1];
        local_84.inner[1] = _e150 + _e148;
        uint _e154 = local_84.inner[0];
        local_85 = static_cast<uint>(_e154);
        uint _e158 = local_84.inner[1];
        local_86 = static_cast<uint>(_e158);
        uint _e161 = local_86;
        out_1[_e161] = _e138;
        int _e163 = a;
        int _e166 = b;
        type_8 _e168 = out;
        local_10 = _e168;
        uint _e170 = base;
        local_11 = static_cast<uint>(_e170 + 2u);
        type_8 _e175 = local_10;
        local_87 = _e175;
        uint _e177 = local_11;
        uint _e179 = local_87.inner[1];
        local_87.inner[1] = _e179 + _e177;
        uint _e183 = local_87.inner[0];
        local_88 = static_cast<uint>(_e183);
        uint _e187 = local_87.inner[1];
        local_89 = static_cast<uint>(_e187);
        uint _e190 = local_89;
        out_1[_e190] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e163) * as_type<uint>(10))) + as_type<uint>(_e166));
        bool _e192 = choose_a;
        if (_e192) {
            int _e193 = a;
            a = as_type<int>(as_type<uint>(_e193) + as_type<uint>(1));
            discard(_e193);
        } else {
            int _e196 = b;
            b = as_type<int>(as_type<uint>(_e196) + as_type<uint>(1));
            discard(_e196);
        }
        int _e199 = a;
        int _e202 = b;
        type_8 _e204 = out;
        local_12 = _e204;
        uint _e206 = base;
        local_13 = static_cast<uint>(_e206 + 3u);
        type_8 _e211 = local_12;
        local_90 = _e211;
        uint _e213 = local_13;
        uint _e215 = local_90.inner[1];
        local_90.inner[1] = _e215 + _e213;
        uint _e219 = local_90.inner[0];
        local_91 = static_cast<uint>(_e219);
        uint _e223 = local_90.inner[1];
        local_92 = static_cast<uint>(_e223);
        uint _e226 = local_92;
        out_1[_e226] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e199) * as_type<uint>(10))) + as_type<uint>(_e202));
        index_a = 0;
        index_b = 0;
        bool _e232 = choose_a;
        if (_e232) {
            type_8 _e234 = input_a;
            local_14 = _e234;
            int _e236 = index_a;
            index_a = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
            local_15 = static_cast<uint>(_e236);
        } else {
            type_8 _e242 = input_b;
            local_16 = _e242;
            int _e244 = index_b;
            index_b = as_type<int>(as_type<uint>(_e244) + as_type<uint>(1));
            local_17 = static_cast<uint>(_e244);
        }
        int _e249 = index_a;
        int _e252 = index_b;
        type_8 _e254 = out;
        local_18 = _e254;
        uint _e256 = base;
        local_19 = static_cast<uint>(_e256 + 4u);
        type_8 _e261 = local_18;
        local_93 = _e261;
        uint _e263 = local_19;
        uint _e265 = local_93.inner[1];
        local_93.inner[1] = _e265 + _e263;
        uint _e269 = local_93.inner[0];
        local_94 = static_cast<uint>(_e269);
        uint _e273 = local_93.inner[1];
        local_95 = static_cast<uint>(_e273);
        uint _e276 = local_95;
        out_1[_e276] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e249) * as_type<uint>(10))) + as_type<uint>(_e252));
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
        type_8 _e288 = out;
        local_20 = _e288;
        uint _e290 = base;
        local_21 = static_cast<uint>(_e290 + 5u);
        type_8 _e295 = local_20;
        local_96 = _e295;
        uint _e297 = local_21;
        uint _e299 = local_96.inner[1];
        local_96.inner[1] = _e299 + _e297;
        uint _e303 = local_96.inner[0];
        local_97 = static_cast<uint>(_e303);
        uint _e307 = local_96.inner[1];
        local_98 = static_cast<uint>(_e307);
        uint _e310 = local_98;
        out_1[_e310] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e283) * as_type<uint>(10))) + as_type<uint>(_e286));
        bool _e312 = choose_a;
        if (_e312) {
            int _e313 = a;
            a = as_type<int>(as_type<uint>(_e313) + as_type<uint>(2));
        } else {
            int _e316 = b;
            b = as_type<int>(as_type<uint>(_e316) + as_type<uint>(2));
        }
        int _e319 = a;
        int _e322 = b;
        type_8 _e324 = out;
        local_22 = _e324;
        uint _e326 = base;
        local_23 = static_cast<uint>(_e326 + 6u);
        type_8 _e331 = local_22;
        local_99 = _e331;
        uint _e333 = local_23;
        uint _e335 = local_99.inner[1];
        local_99.inner[1] = _e335 + _e333;
        uint _e339 = local_99.inner[0];
        local_100 = static_cast<uint>(_e339);
        uint _e343 = local_99.inner[1];
        local_101 = static_cast<uint>(_e343);
        uint _e346 = local_101;
        out_1[_e346] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e319) * as_type<uint>(10))) + as_type<uint>(_e322));
        bool _e348 = choose_a;
        if (_e348) {
            int _e349 = a;
            a = as_type<int>(as_type<uint>(_e349) + as_type<uint>(1));
            int _e352 = a;
            local_26 = _e352;
        } else {
            int _e354 = b;
            b = as_type<int>(as_type<uint>(_e354) + as_type<uint>(1));
            int _e357 = b;
            local_26 = _e357;
        }
        int _e360 = local_26;
        type_8 _e361 = out;
        local_24 = _e361;
        uint _e363 = base;
        local_25 = static_cast<uint>(_e363 + 7u);
        type_8 _e368 = local_24;
        local_102 = _e368;
        uint _e370 = local_25;
        uint _e372 = local_102.inner[1];
        local_102.inner[1] = _e372 + _e370;
        uint _e376 = local_102.inner[0];
        local_103 = static_cast<uint>(_e376);
        uint _e380 = local_102.inner[1];
        local_104 = static_cast<uint>(_e380);
        uint _e383 = local_104;
        out_1[_e383] = _e360;
        bool _e385 = choose_a;
        if (_e385) {
            int _e386 = a;
            a = as_type<int>(as_type<uint>(_e386) + as_type<uint>(1));
            local_29 = _e386;
        } else {
            int _e390 = b;
            b = as_type<int>(as_type<uint>(_e390) + as_type<uint>(1));
            local_29 = _e390;
        }
        int _e395 = local_29;
        type_8 _e396 = out;
        local_27 = _e396;
        uint _e398 = base;
        local_28 = static_cast<uint>(_e398 + 8u);
        type_8 _e403 = local_27;
        local_105 = _e403;
        uint _e405 = local_28;
        uint _e407 = local_105.inner[1];
        local_105.inner[1] = _e407 + _e405;
        uint _e411 = local_105.inner[0];
        local_106 = static_cast<uint>(_e411);
        uint _e415 = local_105.inner[1];
        local_107 = static_cast<uint>(_e415);
        uint _e418 = local_107;
        out_1[_e418] = _e395;
        int _e420 = a;
        int _e423 = b;
        type_8 _e425 = out;
        local_30 = _e425;
        uint _e427 = base;
        local_31 = static_cast<uint>(_e427 + 9u);
        type_8 _e432 = local_30;
        local_108 = _e432;
        uint _e434 = local_31;
        uint _e436 = local_108.inner[1];
        local_108.inner[1] = _e436 + _e434;
        uint _e440 = local_108.inner[0];
        local_109 = static_cast<uint>(_e440);
        uint _e444 = local_108.inner[1];
        local_110 = static_cast<uint>(_e444);
        uint _e447 = local_110;
        out_1[_e447] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e420) * as_type<uint>(100))) + as_type<uint>(_e423));
        bool _e449 = choose_a;
        c = static_cast<int>(_e449);
        b = 7;
        int _e453 = c;
        if (_e453 != 0) {
            c = 0;
            int _e457 = c;
            c = as_type<int>(as_type<uint>(_e457) + as_type<uint>(1));
            local_34 = _e457;
        } else {
            b = 0;
            int _e462 = b;
            b = as_type<int>(as_type<uint>(_e462) + as_type<uint>(1));
            local_34 = _e462;
        }
        int _e467 = local_34;
        type_8 _e468 = out;
        local_32 = _e468;
        uint _e470 = base;
        local_33 = static_cast<uint>(_e470 + 10u);
        type_8 _e475 = local_32;
        local_111 = _e475;
        uint _e477 = local_33;
        uint _e479 = local_111.inner[1];
        local_111.inner[1] = _e479 + _e477;
        uint _e483 = local_111.inner[0];
        local_112 = static_cast<uint>(_e483);
        uint _e487 = local_111.inner[1];
        local_113 = static_cast<uint>(_e487);
        uint _e490 = local_113;
        out_1[_e490] = _e467;
        int _e492 = c;
        int _e495 = b;
        type_8 _e497 = out;
        local_35 = _e497;
        uint _e499 = base;
        local_36 = static_cast<uint>(_e499 + 11u);
        type_8 _e504 = local_35;
        local_114 = _e504;
        uint _e506 = local_36;
        uint _e508 = local_114.inner[1];
        local_114.inner[1] = _e508 + _e506;
        uint _e512 = local_114.inner[0];
        local_115 = static_cast<uint>(_e512);
        uint _e516 = local_114.inner[1];
        local_116 = static_cast<uint>(_e516);
        uint _e519 = local_116;
        out_1[_e519] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e492) * as_type<uint>(10))) + as_type<uint>(_e495));
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e526 = condition;
        int _e527 = condition;
        if (_e527 != 0) {
            a = _e526;
        } else {
            b = _e526;
        }
        int _e530 = a;
        int _e533 = b;
        type_8 _e535 = out;
        local_37 = _e535;
        uint _e537 = base;
        local_38 = static_cast<uint>(_e537 + 12u);
        type_8 _e542 = local_37;
        local_117 = _e542;
        uint _e544 = local_38;
        uint _e546 = local_117.inner[1];
        local_117.inner[1] = _e546 + _e544;
        uint _e550 = local_117.inner[0];
        local_118 = static_cast<uint>(_e550);
        uint _e554 = local_117.inner[1];
        local_119 = static_cast<uint>(_e554);
        uint _e557 = local_119;
        out_1[_e557] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e530) * as_type<uint>(10))) + as_type<uint>(_e533));
        a = 2;
        b = 4;
        c = 6;
        bool _e562 = choose_a;
        if (_e562) {
            if (naga_mod(i, 4u) == 0u) {
                int _e567 = a;
                a = as_type<int>(as_type<uint>(_e567) + as_type<uint>(3));
            } else {
                int _e570 = b;
                b = as_type<int>(as_type<uint>(_e570) + as_type<uint>(3));
            }
        } else {
            int _e573 = c;
            c = as_type<int>(as_type<uint>(_e573) + as_type<uint>(3));
        }
        int _e576 = a;
        int _e579 = b;
        int _e583 = c;
        type_8 _e585 = out;
        local_39 = _e585;
        uint _e587 = base;
        local_40 = static_cast<uint>(_e587 + 13u);
        type_8 _e592 = local_39;
        local_120 = _e592;
        uint _e594 = local_40;
        uint _e596 = local_120.inner[1];
        local_120.inner[1] = _e596 + _e594;
        uint _e600 = local_120.inner[0];
        local_121 = static_cast<uint>(_e600);
        uint _e604 = local_120.inner[1];
        local_122 = static_cast<uint>(_e604);
        uint _e607 = local_122;
        out_1[_e607] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e576) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e579) * as_type<uint>(10))))) + as_type<uint>(_e583));
        lane = threadIdx.x;
        uint _e611 = lane;
        shared_values.inner[_e611] = 20;
        local_value = 10;
        bool _e617 = choose_a;
        if (_e617) {
            int _e618 = local_value;
            local_value = as_type<int>(as_type<uint>(_e618) + as_type<uint>(5));
        } else {
            uint _e621 = lane;
            int _e623 = shared_values.inner[_e621];
            shared_values.inner[_e621] = as_type<int>(as_type<uint>(_e623) + as_type<uint>(5));
        }
        int _e626 = local_value;
        uint _e629 = lane;
        int _e631 = shared_values.inner[_e629];
        type_8 _e633 = out;
        local_41 = _e633;
        uint _e635 = base;
        local_42 = static_cast<uint>(_e635 + 14u);
        type_8 _e640 = local_41;
        local_123 = _e640;
        uint _e642 = local_42;
        uint _e644 = local_123.inner[1];
        local_123.inner[1] = _e644 + _e642;
        uint _e648 = local_123.inner[0];
        local_124 = static_cast<uint>(_e648);
        uint _e652 = local_123.inner[1];
        local_125 = static_cast<uint>(_e652);
        uint _e655 = local_125;
        out_1[_e655] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e626) * as_type<uint>(100))) + as_type<uint>(_e631));
        bool _e657 = choose_a;
        if (_e657) {
            uint _e658 = lane;
            shared_values.inner[_e658] = 30;
        } else {
            type_8 _e661 = out;
            local_43 = _e661;
            uint _e663 = base;
            local_44 = static_cast<uint>(_e663 + 15u);
            type_8 _e668 = local_43;
            local_126 = _e668;
            uint _e670 = local_44;
            uint _e672 = local_126.inner[1];
            local_126.inner[1] = _e672 + _e670;
            uint _e676 = local_126.inner[0];
            local_127 = static_cast<uint>(_e676);
            uint _e680 = local_126.inner[1];
            local_128 = static_cast<uint>(_e680);
            uint _e683 = local_128;
            out_1[_e683] = 30;
        }
        uint _e686 = lane;
        int _e688 = shared_values.inner[_e686];
        type_8 _e689 = out;
        local_45 = _e689;
        uint _e691 = base;
        local_46 = static_cast<uint>(_e691 + 16u);
        type_8 _e696 = local_45;
        local_129 = _e696;
        uint _e698 = local_46;
        uint _e700 = local_129.inner[1];
        local_129.inner[1] = _e700 + _e698;
        uint _e704 = local_129.inner[0];
        local_130 = static_cast<uint>(_e704);
        uint _e708 = local_129.inner[1];
        local_131 = static_cast<uint>(_e708);
        uint _e711 = local_131;
        out_1[_e711] = _e688;
        bool _e713 = choose_a;
        if (_e713) {
            local_49 = 1.5;
        } else {
            local_49 = static_cast<float>(3);
        }
        float _e720 = local_49;
        type_8 _e721 = out;
        local_47 = _e721;
        uint _e723 = base;
        local_48 = static_cast<uint>(_e723 + 17u);
        type_8 _e729 = local_47;
        local_132 = _e729;
        uint _e731 = local_48;
        uint _e733 = local_132.inner[1];
        local_132.inner[1] = _e733 + _e731;
        uint _e737 = local_132.inner[0];
        local_133 = static_cast<uint>(_e737);
        uint _e741 = local_132.inner[1];
        local_134 = static_cast<uint>(_e741);
        uint _e744 = local_134;
        out_1[_e744] = naga_f2i32(_e720);
        bool _e746 = choose_a;
        if (_e746) {
            local_52 = static_cast<uint>(naga_neg(1));
        } else {
            local_52 = 2u;
        }
        uint _e754 = local_52;
        type_8 _e755 = out;
        local_50 = _e755;
        uint _e757 = base;
        local_51 = static_cast<uint>(_e757 + 18u);
        type_8 _e763 = local_50;
        local_135 = _e763;
        uint _e765 = local_51;
        uint _e767 = local_135.inner[1];
        local_135.inner[1] = _e767 + _e765;
        uint _e771 = local_135.inner[0];
        local_136 = static_cast<uint>(_e771);
        uint _e775 = local_135.inner[1];
        local_137 = static_cast<uint>(_e775);
        uint _e778 = local_137;
        out_1[_e778] = static_cast<int>(_e754);
        bool _e780 = choose_a;
        if (_e780) {
            local_55 = true;
        } else {
            local_55 = false;
        }
        bool _e786 = local_55;
        type_8 _e787 = out;
        local_53 = _e787;
        uint _e789 = base;
        local_54 = static_cast<uint>(_e789 + 19u);
        type_8 _e795 = local_53;
        local_138 = _e795;
        uint _e797 = local_54;
        uint _e799 = local_138.inner[1];
        local_138.inner[1] = _e799 + _e797;
        uint _e803 = local_138.inner[0];
        local_139 = static_cast<uint>(_e803);
        uint _e807 = local_138.inner[1];
        local_140 = static_cast<uint>(_e807);
        uint _e810 = local_140;
        out_1[_e810] = static_cast<int>(_e786);
        bool _e812 = choose_a;
        if (_e812) {
            local_58 = static_cast<int>(true);
        } else {
            local_58 = 2;
        }
        int _e819 = local_58;
        type_8 _e820 = out;
        local_56 = _e820;
        uint _e822 = base;
        local_57 = static_cast<uint>(_e822 + 20u);
        type_8 _e827 = local_56;
        local_141 = _e827;
        uint _e829 = local_57;
        uint _e831 = local_141.inner[1];
        local_141.inner[1] = _e831 + _e829;
        uint _e835 = local_141.inner[0];
        local_142 = static_cast<uint>(_e835);
        uint _e839 = local_141.inner[1];
        local_143 = static_cast<uint>(_e839);
        uint _e842 = local_143;
        out_1[_e842] = _e819;
        bool _e844 = choose_a;
        if (_e844) {
            local_61 = 4u;
        } else {
            local_61 = 8u;
        }
        uint _e850 = local_61;
        type_8 _e851 = out;
        local_59 = _e851;
        uint _e853 = base;
        local_60 = static_cast<uint>(_e853 + 21u);
        type_8 _e859 = local_59;
        local_144 = _e859;
        uint _e861 = local_60;
        uint _e863 = local_144.inner[1];
        local_144.inner[1] = _e863 + _e861;
        uint _e867 = local_144.inner[0];
        local_145 = static_cast<uint>(_e867);
        uint _e871 = local_144.inner[1];
        local_146 = static_cast<uint>(_e871);
        uint _e874 = local_146;
        out_1[_e874] = static_cast<int>(_e850);
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
        local_65 = static_cast<uint>(_e887);
        uint _e890 = local_65;
        type_8 _e892 = out;
        local_62 = _e892;
        uint _e894 = base;
        local_63 = static_cast<uint>(_e894 + 22u);
        type_8 _e899 = local_62;
        local_147 = _e899;
        uint _e901 = local_63;
        uint _e903 = local_147.inner[1];
        local_147.inner[1] = _e903 + _e901;
        uint _e907 = local_147.inner[0];
        local_148 = static_cast<uint>(_e907);
        uint _e911 = local_147.inner[1];
        local_149 = static_cast<uint>(_e911);
        uint _e914 = local_149;
        out_1[_e914] = _e885 << _e890;
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
        value = as_type<int>(as_type<uint>(_e927) + as_type<uint>(1));
        int _e930 = pair(_e926, _e927);
        type_8 _e931 = out;
        local_66 = _e931;
        uint _e933 = base;
        local_67 = static_cast<uint>(_e933 + 23u);
        type_8 _e938 = local_66;
        local_150 = _e938;
        uint _e940 = local_67;
        uint _e942 = local_150.inner[1];
        local_150.inner[1] = _e942 + _e940;
        uint _e946 = local_150.inner[0];
        local_151 = static_cast<uint>(_e946);
        uint _e950 = local_150.inner[1];
        local_152 = static_cast<uint>(_e950);
        uint _e953 = local_152;
        out_1[_e953] = _e930;
        count = 0;
        left = 0;
        right = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    bool _e970 = choose_a;
                    if (_e970) {
                        int _e971 = left;
                        left = as_type<int>(as_type<uint>(_e971) + as_type<uint>(1));
                    } else {
                        int _e974 = right;
                        right = as_type<int>(as_type<uint>(_e974) + as_type<uint>(1));
                    }
                }
                loop_init = false;
                int _e961 = count;
                if (_e961 < 3) {
                } else {
                    break;
                }
                int _e964 = count;
                count = as_type<int>(as_type<uint>(_e964) + as_type<uint>(1));
                int _e967 = count;
                if (_e967 == 2) {
                    continue;
                }
            }
        }
        int _e977 = left;
        int _e980 = right;
        int _e984 = count;
        type_8 _e986 = out;
        local_69 = _e986;
        uint _e988 = base;
        local_70 = static_cast<uint>(_e988 + 24u);
        type_8 _e993 = local_69;
        local_153 = _e993;
        uint _e995 = local_70;
        uint _e997 = local_153.inner[1];
        local_153.inner[1] = _e997 + _e995;
        uint _e1001 = local_153.inner[0];
        local_154 = static_cast<uint>(_e1001);
        uint _e1005 = local_153.inner[1];
        local_155 = static_cast<uint>(_e1005);
        uint _e1008 = local_155;
        out_1[_e1008] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e977) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e980) * as_type<uint>(10))))) + as_type<uint>(_e984));
    }
}
