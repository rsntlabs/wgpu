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
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(10));
}

void discard(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e3 = value_4;
    value_4 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
    return;
}

int pair(
    int x,
    int y
) {
    int x_1 = {};
    int y_1 = {};
    x_1 = x;
    y_1 = y;
    int _e5 = x_1;
    int _e7 = y_1;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e5) * as_type<uint>(10))) + as_type<uint>(_e7));
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
, device type_1& out [[user(fake0)]]
, device type_1 const& input_a [[user(fake0)]]
, device type_1 const& input_b [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, threadgroup type_4& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_8 local = {};
    type_8 local_1 = {};
    type_8 local_2 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    bool choose_a = {};
    type_8 local_3 = {};
    uint local_4 = {};
    type_8 local_5 = {};
    uint local_6 = {};
    type_8 local_7 = {};
    uint local_8 = {};
    int local_9 = {};
    int a = {};
    int b = {};
    type_8 local_10 = {};
    uint local_11 = {};
    int local_12 = {};
    type_8 local_13 = {};
    uint local_14 = {};
    type_8 local_15 = {};
    uint local_16 = {};
    int index_a = {};
    int index_b = {};
    type_8 local_17 = {};
    uint local_18 = {};
    type_8 local_19 = {};
    uint local_20 = {};
    type_8 local_21 = {};
    uint local_22 = {};
    type_8 local_23 = {};
    uint local_24 = {};
    type_8 local_25 = {};
    uint local_26 = {};
    type_8 local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    type_8 local_30 = {};
    uint local_31 = {};
    int local_32 = {};
    type_8 local_33 = {};
    uint local_34 = {};
    int c = {};
    type_8 local_35 = {};
    uint local_36 = {};
    int local_37 = {};
    type_8 local_38 = {};
    uint local_39 = {};
    int condition = {};
    type_8 local_40 = {};
    uint local_41 = {};
    type_8 local_42 = {};
    uint local_43 = {};
    uint lane = {};
    int local_value = {};
    type_8 local_44 = {};
    uint local_45 = {};
    type_8 local_46 = {};
    uint local_47 = {};
    type_8 local_48 = {};
    uint local_49 = {};
    type_8 local_50 = {};
    uint local_51 = {};
    float local_52 = {};
    type_8 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_8 local_56 = {};
    uint local_57 = {};
    bool local_58 = {};
    type_8 local_59 = {};
    uint local_60 = {};
    int local_61 = {};
    type_8 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    int shift_value = {};
    type_8 local_65 = {};
    uint local_66 = {};
    int local_67 = {};
    uint local_68 = {};
    int value = {};
    int other = {};
    type_8 local_69 = {};
    uint local_70 = {};
    int local_71 = {};
    int count = {};
    int left = {};
    int right = {};
    type_8 local_72 = {};
    uint local_73 = {};
    int local_74 = {};
    int local_75 = {};
    type_8 local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    int local_79 = {};
    type_8 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    int local_83 = {};
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
    type_8 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    local = type_8 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_8 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    local_2 = type_8 {};
    local_2.inner[0] = 2u;
    local_2.inner[1] = 0u;
    uint _e25 = n_1.value;
    n = _e25;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e33 = i;
    uint _e34 = n;
    if (_e33 < _e34) {
        uint _e36 = i;
        base = _e36 * 25u;
        uint _e40 = i;
        choose_a = naga_mod(_e40, 2u) == 0u;
        bool _e46 = choose_a;
        if (_e46) {
            type_8 _e49 = local_1;
            local_5 = _e49;
            uint _e50 = i;
            local_6 = static_cast<uint>(_e50);
            type_8 _e54 = local_5;
            local_76 = _e54;
            uint _e55 = local_6;
            uint _e57 = local_76.inner[1];
            local_76.inner[1] = _e57 + _e55;
            uint _e61 = local_76.inner[0];
            local_77 = static_cast<uint>(_e61);
            uint _e65 = local_76.inner[1];
            local_78 = static_cast<uint>(_e65);
            uint _e69 = local_78;
            int _e71 = input_a[_e69];
            local_79 = _e71;
            int _e72 = local_79;
            local_74 = _e72;
            int _e74 = local_74;
            local_9 = _e74;
        } else {
            type_8 _e78 = local_2;
            local_7 = _e78;
            uint _e79 = i;
            local_8 = static_cast<uint>(_e79);
            type_8 _e83 = local_7;
            local_80 = _e83;
            uint _e84 = local_8;
            uint _e86 = local_80.inner[1];
            local_80.inner[1] = _e86 + _e84;
            uint _e90 = local_80.inner[0];
            local_81 = static_cast<uint>(_e90);
            uint _e94 = local_80.inner[1];
            local_82 = static_cast<uint>(_e94);
            uint _e98 = local_82;
            int _e100 = input_b[_e98];
            local_83 = _e100;
            int _e101 = local_83;
            local_75 = _e101;
            int _e103 = local_75;
            local_9 = _e103;
        }
        int _e106 = local_9;
        type_8 _e109 = local;
        local_3 = _e109;
        uint _e110 = base;
        local_4 = static_cast<uint>(_e110);
        type_8 _e114 = local_3;
        local_84 = _e114;
        uint _e115 = local_4;
        uint _e117 = local_84.inner[1];
        local_84.inner[1] = _e117 + _e115;
        uint _e121 = local_84.inner[0];
        local_85 = static_cast<uint>(_e121);
        uint _e125 = local_84.inner[1];
        local_86 = static_cast<uint>(_e125);
        uint _e128 = local_86;
        out[_e128] = _e106;
        a = 3;
        b = 5;
        bool _e134 = choose_a;
        if (_e134) {
            int _e135 = a;
            a = as_type<int>(as_type<uint>(_e135) + as_type<uint>(1));
            int _e138 = shifted(_e135);
            local_12 = _e138;
        } else {
            int _e140 = b;
            b = as_type<int>(as_type<uint>(_e140) + as_type<uint>(1));
            int _e143 = shifted(_e140);
            local_12 = _e143;
        }
        int _e146 = local_12;
        type_8 _e148 = local;
        local_10 = _e148;
        uint _e149 = base;
        local_11 = static_cast<uint>(_e149 + 1u);
        type_8 _e155 = local_10;
        local_87 = _e155;
        uint _e156 = local_11;
        uint _e158 = local_87.inner[1];
        local_87.inner[1] = _e158 + _e156;
        uint _e162 = local_87.inner[0];
        local_88 = static_cast<uint>(_e162);
        uint _e166 = local_87.inner[1];
        local_89 = static_cast<uint>(_e166);
        uint _e169 = local_89;
        out[_e169] = _e146;
        int _e171 = a;
        int _e174 = b;
        type_8 _e177 = local;
        local_13 = _e177;
        uint _e178 = base;
        local_14 = static_cast<uint>(_e178 + 2u);
        type_8 _e184 = local_13;
        local_90 = _e184;
        uint _e185 = local_14;
        uint _e187 = local_90.inner[1];
        local_90.inner[1] = _e187 + _e185;
        uint _e191 = local_90.inner[0];
        local_91 = static_cast<uint>(_e191);
        uint _e195 = local_90.inner[1];
        local_92 = static_cast<uint>(_e195);
        uint _e198 = local_92;
        out[_e198] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e171) * as_type<uint>(10))) + as_type<uint>(_e174));
        bool _e200 = choose_a;
        if (_e200) {
            int _e201 = a;
            a = as_type<int>(as_type<uint>(_e201) + as_type<uint>(1));
            discard(_e201);
        } else {
            int _e204 = b;
            b = as_type<int>(as_type<uint>(_e204) + as_type<uint>(1));
            discard(_e204);
        }
        int _e207 = a;
        int _e210 = b;
        type_8 _e213 = local;
        local_15 = _e213;
        uint _e214 = base;
        local_16 = static_cast<uint>(_e214 + 3u);
        type_8 _e220 = local_15;
        local_93 = _e220;
        uint _e221 = local_16;
        uint _e223 = local_93.inner[1];
        local_93.inner[1] = _e223 + _e221;
        uint _e227 = local_93.inner[0];
        local_94 = static_cast<uint>(_e227);
        uint _e231 = local_93.inner[1];
        local_95 = static_cast<uint>(_e231);
        uint _e234 = local_95;
        out[_e234] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e207) * as_type<uint>(10))) + as_type<uint>(_e210));
        index_a = 0;
        index_b = 0;
        bool _e240 = choose_a;
        if (_e240) {
            type_8 _e243 = local_1;
            local_17 = _e243;
            int _e244 = index_a;
            index_a = as_type<int>(as_type<uint>(_e244) + as_type<uint>(1));
            local_18 = static_cast<uint>(_e244);
        } else {
            type_8 _e251 = local_2;
            local_19 = _e251;
            int _e252 = index_b;
            index_b = as_type<int>(as_type<uint>(_e252) + as_type<uint>(1));
            local_20 = static_cast<uint>(_e252);
        }
        int _e257 = index_a;
        int _e260 = index_b;
        type_8 _e263 = local;
        local_21 = _e263;
        uint _e264 = base;
        local_22 = static_cast<uint>(_e264 + 4u);
        type_8 _e270 = local_21;
        local_96 = _e270;
        uint _e271 = local_22;
        uint _e273 = local_96.inner[1];
        local_96.inner[1] = _e273 + _e271;
        uint _e277 = local_96.inner[0];
        local_97 = static_cast<uint>(_e277);
        uint _e281 = local_96.inner[1];
        local_98 = static_cast<uint>(_e281);
        uint _e284 = local_98;
        out[_e284] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e257) * as_type<uint>(10))) + as_type<uint>(_e260));
        a = 3;
        b = 5;
        bool _e288 = choose_a;
        if (_e288) {
            a = 7;
        } else {
            b = 7;
        }
        int _e291 = a;
        int _e294 = b;
        type_8 _e297 = local;
        local_23 = _e297;
        uint _e298 = base;
        local_24 = static_cast<uint>(_e298 + 5u);
        type_8 _e304 = local_23;
        local_99 = _e304;
        uint _e305 = local_24;
        uint _e307 = local_99.inner[1];
        local_99.inner[1] = _e307 + _e305;
        uint _e311 = local_99.inner[0];
        local_100 = static_cast<uint>(_e311);
        uint _e315 = local_99.inner[1];
        local_101 = static_cast<uint>(_e315);
        uint _e318 = local_101;
        out[_e318] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e291) * as_type<uint>(10))) + as_type<uint>(_e294));
        bool _e320 = choose_a;
        if (_e320) {
            int _e321 = a;
            a = as_type<int>(as_type<uint>(_e321) + as_type<uint>(2));
        } else {
            int _e324 = b;
            b = as_type<int>(as_type<uint>(_e324) + as_type<uint>(2));
        }
        int _e327 = a;
        int _e330 = b;
        type_8 _e333 = local;
        local_25 = _e333;
        uint _e334 = base;
        local_26 = static_cast<uint>(_e334 + 6u);
        type_8 _e340 = local_25;
        local_102 = _e340;
        uint _e341 = local_26;
        uint _e343 = local_102.inner[1];
        local_102.inner[1] = _e343 + _e341;
        uint _e347 = local_102.inner[0];
        local_103 = static_cast<uint>(_e347);
        uint _e351 = local_102.inner[1];
        local_104 = static_cast<uint>(_e351);
        uint _e354 = local_104;
        out[_e354] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e327) * as_type<uint>(10))) + as_type<uint>(_e330));
        bool _e356 = choose_a;
        if (_e356) {
            int _e357 = a;
            a = as_type<int>(as_type<uint>(_e357) + as_type<uint>(1));
            int _e360 = a;
            local_29 = _e360;
        } else {
            int _e362 = b;
            b = as_type<int>(as_type<uint>(_e362) + as_type<uint>(1));
            int _e365 = b;
            local_29 = _e365;
        }
        int _e368 = local_29;
        type_8 _e370 = local;
        local_27 = _e370;
        uint _e371 = base;
        local_28 = static_cast<uint>(_e371 + 7u);
        type_8 _e377 = local_27;
        local_105 = _e377;
        uint _e378 = local_28;
        uint _e380 = local_105.inner[1];
        local_105.inner[1] = _e380 + _e378;
        uint _e384 = local_105.inner[0];
        local_106 = static_cast<uint>(_e384);
        uint _e388 = local_105.inner[1];
        local_107 = static_cast<uint>(_e388);
        uint _e391 = local_107;
        out[_e391] = _e368;
        bool _e393 = choose_a;
        if (_e393) {
            int _e394 = a;
            a = as_type<int>(as_type<uint>(_e394) + as_type<uint>(1));
            local_32 = _e394;
        } else {
            int _e398 = b;
            b = as_type<int>(as_type<uint>(_e398) + as_type<uint>(1));
            local_32 = _e398;
        }
        int _e403 = local_32;
        type_8 _e405 = local;
        local_30 = _e405;
        uint _e406 = base;
        local_31 = static_cast<uint>(_e406 + 8u);
        type_8 _e412 = local_30;
        local_108 = _e412;
        uint _e413 = local_31;
        uint _e415 = local_108.inner[1];
        local_108.inner[1] = _e415 + _e413;
        uint _e419 = local_108.inner[0];
        local_109 = static_cast<uint>(_e419);
        uint _e423 = local_108.inner[1];
        local_110 = static_cast<uint>(_e423);
        uint _e426 = local_110;
        out[_e426] = _e403;
        int _e428 = a;
        int _e431 = b;
        type_8 _e434 = local;
        local_33 = _e434;
        uint _e435 = base;
        local_34 = static_cast<uint>(_e435 + 9u);
        type_8 _e441 = local_33;
        local_111 = _e441;
        uint _e442 = local_34;
        uint _e444 = local_111.inner[1];
        local_111.inner[1] = _e444 + _e442;
        uint _e448 = local_111.inner[0];
        local_112 = static_cast<uint>(_e448);
        uint _e452 = local_111.inner[1];
        local_113 = static_cast<uint>(_e452);
        uint _e455 = local_113;
        out[_e455] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e428) * as_type<uint>(100))) + as_type<uint>(_e431));
        bool _e457 = choose_a;
        c = static_cast<int>(_e457);
        b = 7;
        int _e461 = c;
        if (_e461 != 0) {
            c = 0;
            int _e465 = c;
            c = as_type<int>(as_type<uint>(_e465) + as_type<uint>(1));
            local_37 = _e465;
        } else {
            b = 0;
            int _e470 = b;
            b = as_type<int>(as_type<uint>(_e470) + as_type<uint>(1));
            local_37 = _e470;
        }
        int _e475 = local_37;
        type_8 _e477 = local;
        local_35 = _e477;
        uint _e478 = base;
        local_36 = static_cast<uint>(_e478 + 10u);
        type_8 _e484 = local_35;
        local_114 = _e484;
        uint _e485 = local_36;
        uint _e487 = local_114.inner[1];
        local_114.inner[1] = _e487 + _e485;
        uint _e491 = local_114.inner[0];
        local_115 = static_cast<uint>(_e491);
        uint _e495 = local_114.inner[1];
        local_116 = static_cast<uint>(_e495);
        uint _e498 = local_116;
        out[_e498] = _e475;
        int _e500 = c;
        int _e503 = b;
        type_8 _e506 = local;
        local_38 = _e506;
        uint _e507 = base;
        local_39 = static_cast<uint>(_e507 + 11u);
        type_8 _e513 = local_38;
        local_117 = _e513;
        uint _e514 = local_39;
        uint _e516 = local_117.inner[1];
        local_117.inner[1] = _e516 + _e514;
        uint _e520 = local_117.inner[0];
        local_118 = static_cast<uint>(_e520);
        uint _e524 = local_117.inner[1];
        local_119 = static_cast<uint>(_e524);
        uint _e527 = local_119;
        out[_e527] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e500) * as_type<uint>(10))) + as_type<uint>(_e503));
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e534 = condition;
        int _e535 = condition;
        if (_e535 != 0) {
            a = _e534;
        } else {
            b = _e534;
        }
        int _e538 = a;
        int _e541 = b;
        type_8 _e544 = local;
        local_40 = _e544;
        uint _e545 = base;
        local_41 = static_cast<uint>(_e545 + 12u);
        type_8 _e551 = local_40;
        local_120 = _e551;
        uint _e552 = local_41;
        uint _e554 = local_120.inner[1];
        local_120.inner[1] = _e554 + _e552;
        uint _e558 = local_120.inner[0];
        local_121 = static_cast<uint>(_e558);
        uint _e562 = local_120.inner[1];
        local_122 = static_cast<uint>(_e562);
        uint _e565 = local_122;
        out[_e565] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e538) * as_type<uint>(10))) + as_type<uint>(_e541));
        a = 2;
        b = 4;
        c = 6;
        bool _e570 = choose_a;
        if (_e570) {
            uint _e571 = i;
            if (naga_mod(_e571, 4u) == 0u) {
                int _e576 = a;
                a = as_type<int>(as_type<uint>(_e576) + as_type<uint>(3));
            } else {
                int _e579 = b;
                b = as_type<int>(as_type<uint>(_e579) + as_type<uint>(3));
            }
        } else {
            int _e582 = c;
            c = as_type<int>(as_type<uint>(_e582) + as_type<uint>(3));
        }
        int _e585 = a;
        int _e588 = b;
        int _e592 = c;
        type_8 _e595 = local;
        local_42 = _e595;
        uint _e596 = base;
        local_43 = static_cast<uint>(_e596 + 13u);
        type_8 _e602 = local_42;
        local_123 = _e602;
        uint _e603 = local_43;
        uint _e605 = local_123.inner[1];
        local_123.inner[1] = _e605 + _e603;
        uint _e609 = local_123.inner[0];
        local_124 = static_cast<uint>(_e609);
        uint _e613 = local_123.inner[1];
        local_125 = static_cast<uint>(_e613);
        uint _e616 = local_125;
        out[_e616] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e585) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e588) * as_type<uint>(10))))) + as_type<uint>(_e592));
        lane = threadIdx.x;
        uint _e620 = lane;
        shared_values.inner[_e620] = 20;
        local_value = 10;
        bool _e626 = choose_a;
        if (_e626) {
            int _e627 = local_value;
            local_value = as_type<int>(as_type<uint>(_e627) + as_type<uint>(5));
        } else {
            uint _e630 = lane;
            int _e632 = shared_values.inner[_e630];
            shared_values.inner[_e630] = as_type<int>(as_type<uint>(_e632) + as_type<uint>(5));
        }
        int _e635 = local_value;
        uint _e638 = lane;
        int _e640 = shared_values.inner[_e638];
        type_8 _e643 = local;
        local_44 = _e643;
        uint _e644 = base;
        local_45 = static_cast<uint>(_e644 + 14u);
        type_8 _e650 = local_44;
        local_126 = _e650;
        uint _e651 = local_45;
        uint _e653 = local_126.inner[1];
        local_126.inner[1] = _e653 + _e651;
        uint _e657 = local_126.inner[0];
        local_127 = static_cast<uint>(_e657);
        uint _e661 = local_126.inner[1];
        local_128 = static_cast<uint>(_e661);
        uint _e664 = local_128;
        out[_e664] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e635) * as_type<uint>(100))) + as_type<uint>(_e640));
        bool _e666 = choose_a;
        if (_e666) {
            uint _e667 = lane;
            shared_values.inner[_e667] = 30;
        } else {
            type_8 _e671 = local;
            local_46 = _e671;
            uint _e672 = base;
            local_47 = static_cast<uint>(_e672 + 15u);
            type_8 _e678 = local_46;
            local_129 = _e678;
            uint _e679 = local_47;
            uint _e681 = local_129.inner[1];
            local_129.inner[1] = _e681 + _e679;
            uint _e685 = local_129.inner[0];
            local_130 = static_cast<uint>(_e685);
            uint _e689 = local_129.inner[1];
            local_131 = static_cast<uint>(_e689);
            uint _e693 = local_131;
            out[_e693] = 30;
        }
        uint _e695 = lane;
        int _e697 = shared_values.inner[_e695];
        type_8 _e699 = local;
        local_48 = _e699;
        uint _e700 = base;
        local_49 = static_cast<uint>(_e700 + 16u);
        type_8 _e706 = local_48;
        local_132 = _e706;
        uint _e707 = local_49;
        uint _e709 = local_132.inner[1];
        local_132.inner[1] = _e709 + _e707;
        uint _e713 = local_132.inner[0];
        local_133 = static_cast<uint>(_e713);
        uint _e717 = local_132.inner[1];
        local_134 = static_cast<uint>(_e717);
        uint _e720 = local_134;
        out[_e720] = _e697;
        bool _e722 = choose_a;
        if (_e722) {
            local_52 = 1.5;
        } else {
            local_52 = static_cast<float>(3);
        }
        float _e729 = local_52;
        type_8 _e731 = local;
        local_50 = _e731;
        uint _e732 = base;
        local_51 = static_cast<uint>(_e732 + 17u);
        type_8 _e739 = local_50;
        local_135 = _e739;
        uint _e740 = local_51;
        uint _e742 = local_135.inner[1];
        local_135.inner[1] = _e742 + _e740;
        uint _e746 = local_135.inner[0];
        local_136 = static_cast<uint>(_e746);
        uint _e750 = local_135.inner[1];
        local_137 = static_cast<uint>(_e750);
        uint _e753 = local_137;
        out[_e753] = naga_f2i32(_e729);
        bool _e755 = choose_a;
        if (_e755) {
            local_55 = static_cast<uint>(naga_neg(1));
        } else {
            local_55 = 2u;
        }
        uint _e763 = local_55;
        type_8 _e765 = local;
        local_53 = _e765;
        uint _e766 = base;
        local_54 = static_cast<uint>(_e766 + 18u);
        type_8 _e773 = local_53;
        local_138 = _e773;
        uint _e774 = local_54;
        uint _e776 = local_138.inner[1];
        local_138.inner[1] = _e776 + _e774;
        uint _e780 = local_138.inner[0];
        local_139 = static_cast<uint>(_e780);
        uint _e784 = local_138.inner[1];
        local_140 = static_cast<uint>(_e784);
        uint _e787 = local_140;
        out[_e787] = static_cast<int>(_e763);
        bool _e789 = choose_a;
        if (_e789) {
            local_58 = true;
        } else {
            local_58 = false;
        }
        bool _e795 = local_58;
        type_8 _e797 = local;
        local_56 = _e797;
        uint _e798 = base;
        local_57 = static_cast<uint>(_e798 + 19u);
        type_8 _e805 = local_56;
        local_141 = _e805;
        uint _e806 = local_57;
        uint _e808 = local_141.inner[1];
        local_141.inner[1] = _e808 + _e806;
        uint _e812 = local_141.inner[0];
        local_142 = static_cast<uint>(_e812);
        uint _e816 = local_141.inner[1];
        local_143 = static_cast<uint>(_e816);
        uint _e819 = local_143;
        out[_e819] = static_cast<int>(_e795);
        bool _e821 = choose_a;
        if (_e821) {
            local_61 = static_cast<int>(true);
        } else {
            local_61 = 2;
        }
        int _e828 = local_61;
        type_8 _e830 = local;
        local_59 = _e830;
        uint _e831 = base;
        local_60 = static_cast<uint>(_e831 + 20u);
        type_8 _e837 = local_59;
        local_144 = _e837;
        uint _e838 = local_60;
        uint _e840 = local_144.inner[1];
        local_144.inner[1] = _e840 + _e838;
        uint _e844 = local_144.inner[0];
        local_145 = static_cast<uint>(_e844);
        uint _e848 = local_144.inner[1];
        local_146 = static_cast<uint>(_e848);
        uint _e851 = local_146;
        out[_e851] = _e828;
        bool _e853 = choose_a;
        if (_e853) {
            local_64 = 4u;
        } else {
            local_64 = 8u;
        }
        uint _e859 = local_64;
        type_8 _e861 = local;
        local_62 = _e861;
        uint _e862 = base;
        local_63 = static_cast<uint>(_e862 + 21u);
        type_8 _e869 = local_62;
        local_147 = _e869;
        uint _e870 = local_63;
        uint _e872 = local_147.inner[1];
        local_147.inner[1] = _e872 + _e870;
        uint _e876 = local_147.inner[0];
        local_148 = static_cast<uint>(_e876);
        uint _e880 = local_147.inner[1];
        local_149 = static_cast<uint>(_e880);
        uint _e883 = local_149;
        out[_e883] = static_cast<int>(_e859);
        a = 3;
        shift_value = 2;
        bool _e888 = choose_a;
        if (_e888) {
            int _e889 = shift_value;
            local_67 = _e889;
        } else {
            int _e891 = a;
            local_67 = _e891;
        }
        int _e894 = local_67;
        shift_value = 1;
        int _e896 = shift_value;
        local_68 = static_cast<uint>(_e896);
        uint _e899 = local_68;
        type_8 _e902 = local;
        local_65 = _e902;
        uint _e903 = base;
        local_66 = static_cast<uint>(_e903 + 22u);
        type_8 _e909 = local_65;
        local_150 = _e909;
        uint _e910 = local_66;
        uint _e912 = local_150.inner[1];
        local_150.inner[1] = _e912 + _e910;
        uint _e916 = local_150.inner[0];
        local_151 = static_cast<uint>(_e916);
        uint _e920 = local_150.inner[1];
        local_152 = static_cast<uint>(_e920);
        uint _e923 = local_152;
        out[_e923] = _e894 << _e899;
        value = 3;
        other = 7;
        bool _e929 = choose_a;
        if (_e929) {
            int _e930 = value;
            local_71 = _e930;
        } else {
            int _e932 = other;
            local_71 = _e932;
        }
        int _e935 = local_71;
        int _e936 = value;
        value = as_type<int>(as_type<uint>(_e936) + as_type<uint>(1));
        int _e939 = pair(_e935, _e936);
        type_8 _e941 = local;
        local_69 = _e941;
        uint _e942 = base;
        local_70 = static_cast<uint>(_e942 + 23u);
        type_8 _e948 = local_69;
        local_153 = _e948;
        uint _e949 = local_70;
        uint _e951 = local_153.inner[1];
        local_153.inner[1] = _e951 + _e949;
        uint _e955 = local_153.inner[0];
        local_154 = static_cast<uint>(_e955);
        uint _e959 = local_153.inner[1];
        local_155 = static_cast<uint>(_e959);
        uint _e962 = local_155;
        out[_e962] = _e939;
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
                    bool _e979 = choose_a;
                    if (_e979) {
                        int _e980 = left;
                        left = as_type<int>(as_type<uint>(_e980) + as_type<uint>(1));
                    } else {
                        int _e983 = right;
                        right = as_type<int>(as_type<uint>(_e983) + as_type<uint>(1));
                    }
                }
                loop_init = false;
                int _e970 = count;
                if (_e970 < 3) {
                } else {
                    break;
                }
                int _e973 = count;
                count = as_type<int>(as_type<uint>(_e973) + as_type<uint>(1));
                int _e976 = count;
                if (_e976 == 2) {
                    continue;
                }
            }
        }
        int _e986 = left;
        int _e989 = right;
        int _e993 = count;
        type_8 _e996 = local;
        local_72 = _e996;
        uint _e997 = base;
        local_73 = static_cast<uint>(_e997 + 24u);
        type_8 _e1003 = local_72;
        local_156 = _e1003;
        uint _e1004 = local_73;
        uint _e1006 = local_156.inner[1];
        local_156.inner[1] = _e1006 + _e1004;
        uint _e1010 = local_156.inner[0];
        local_157 = static_cast<uint>(_e1010);
        uint _e1014 = local_156.inner[1];
        local_158 = static_cast<uint>(_e1014);
        uint _e1017 = local_158;
        out[_e1017] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e986) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e989) * as_type<uint>(10))))) + as_type<uint>(_e993));
    }
}
