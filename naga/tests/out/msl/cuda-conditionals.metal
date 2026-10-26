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
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    bool choose_a = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int local_12 = {};
    int a = {};
    int b = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    int local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    int index_a = {};
    int index_b = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    int local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    int local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    int c = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    int local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    int condition = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint lane = {};
    int local_value = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    float local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    bool local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    int local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    int shift_value = {};
    uint local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    int local_94 = {};
    uint local_95 = {};
    int value = {};
    int other = {};
    uint local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    int local_99 = {};
    int count = {};
    int left = {};
    int right = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    int local_104 = {};
    uint local_105 = {};
    int local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    uint _e10 = n_1.value;
    n = _e10;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e18 = i;
    uint _e19 = n;
    if (_e18 < _e19) {
        uint _e21 = i;
        base = _e21 * 25u;
        uint _e25 = i;
        choose_a = naga_mod(_e25, 2u) == 0u;
        bool _e31 = choose_a;
        if (_e31) {
            uint _e32 = local_1;
            local_6 = _e32;
            uint _e34 = local_6;
            local_7 = static_cast<uint>(_e34);
            uint _e37 = i;
            local_8 = static_cast<uint>(_e37);
            uint _e41 = local_7;
            uint _e42 = local_8;
            local_103 = static_cast<uint>(_e41 + _e42);
            uint _e47 = local_103;
            int _e49 = input_a[_e47];
            local_104 = _e49;
            int _e50 = local_104;
            local_12 = _e50;
        } else {
            uint _e52 = local_2;
            local_9 = _e52;
            uint _e54 = local_9;
            local_10 = static_cast<uint>(_e54);
            uint _e57 = i;
            local_11 = static_cast<uint>(_e57);
            uint _e61 = local_10;
            uint _e62 = local_11;
            local_105 = static_cast<uint>(_e61 + _e62);
            uint _e67 = local_105;
            int _e69 = input_b[_e67];
            local_106 = _e69;
            int _e70 = local_106;
            local_12 = _e70;
        }
        int _e73 = local_12;
        uint _e74 = local;
        local_3 = _e74;
        uint _e76 = local_3;
        local_4 = static_cast<uint>(_e76);
        uint _e79 = base;
        local_5 = static_cast<uint>(_e79);
        uint _e83 = local_4;
        uint _e84 = local_5;
        local_107 = static_cast<uint>(_e83 + _e84);
        uint _e88 = local_107;
        out[_e88] = _e73;
        a = 3;
        b = 5;
        bool _e94 = choose_a;
        if (_e94) {
            int _e95 = a;
            a = as_type<int>(as_type<uint>(_e95) + as_type<uint>(1));
            int _e98 = shifted(_e95);
            local_16 = _e98;
        } else {
            int _e100 = b;
            b = as_type<int>(as_type<uint>(_e100) + as_type<uint>(1));
            int _e103 = shifted(_e100);
            local_16 = _e103;
        }
        int _e106 = local_16;
        uint _e107 = local;
        local_13 = _e107;
        uint _e109 = local_13;
        local_14 = static_cast<uint>(_e109);
        uint _e112 = base;
        local_15 = static_cast<uint>(_e112 + 1u);
        uint _e117 = local_14;
        uint _e118 = local_15;
        local_108 = static_cast<uint>(_e117 + _e118);
        uint _e122 = local_108;
        out[_e122] = _e106;
        int _e124 = a;
        int _e127 = b;
        uint _e129 = local;
        local_17 = _e129;
        uint _e131 = local_17;
        local_18 = static_cast<uint>(_e131);
        uint _e134 = base;
        local_19 = static_cast<uint>(_e134 + 2u);
        uint _e139 = local_18;
        uint _e140 = local_19;
        local_109 = static_cast<uint>(_e139 + _e140);
        uint _e144 = local_109;
        out[_e144] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e124) * as_type<uint>(10))) + as_type<uint>(_e127));
        bool _e146 = choose_a;
        if (_e146) {
            int _e147 = a;
            a = as_type<int>(as_type<uint>(_e147) + as_type<uint>(1));
            discard(_e147);
        } else {
            int _e150 = b;
            b = as_type<int>(as_type<uint>(_e150) + as_type<uint>(1));
            discard(_e150);
        }
        int _e153 = a;
        int _e156 = b;
        uint _e158 = local;
        local_20 = _e158;
        uint _e160 = local_20;
        local_21 = static_cast<uint>(_e160);
        uint _e163 = base;
        local_22 = static_cast<uint>(_e163 + 3u);
        uint _e168 = local_21;
        uint _e169 = local_22;
        local_110 = static_cast<uint>(_e168 + _e169);
        uint _e173 = local_110;
        out[_e173] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e153) * as_type<uint>(10))) + as_type<uint>(_e156));
        index_a = 0;
        index_b = 0;
        bool _e179 = choose_a;
        if (_e179) {
            uint _e180 = local_1;
            local_23 = _e180;
            uint _e182 = local_23;
            local_24 = static_cast<uint>(_e182);
            int _e185 = index_a;
            index_a = as_type<int>(as_type<uint>(_e185) + as_type<uint>(1));
            local_25 = static_cast<uint>(_e185);
        } else {
            uint _e190 = local_2;
            local_26 = _e190;
            uint _e192 = local_26;
            local_27 = static_cast<uint>(_e192);
            int _e195 = index_b;
            index_b = as_type<int>(as_type<uint>(_e195) + as_type<uint>(1));
            local_28 = static_cast<uint>(_e195);
        }
        int _e200 = index_a;
        int _e203 = index_b;
        uint _e205 = local;
        local_29 = _e205;
        uint _e207 = local_29;
        local_30 = static_cast<uint>(_e207);
        uint _e210 = base;
        local_31 = static_cast<uint>(_e210 + 4u);
        uint _e215 = local_30;
        uint _e216 = local_31;
        local_111 = static_cast<uint>(_e215 + _e216);
        uint _e220 = local_111;
        out[_e220] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e200) * as_type<uint>(10))) + as_type<uint>(_e203));
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
        local_33 = static_cast<uint>(_e234);
        uint _e237 = base;
        local_34 = static_cast<uint>(_e237 + 5u);
        uint _e242 = local_33;
        uint _e243 = local_34;
        local_112 = static_cast<uint>(_e242 + _e243);
        uint _e247 = local_112;
        out[_e247] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e227) * as_type<uint>(10))) + as_type<uint>(_e230));
        bool _e249 = choose_a;
        if (_e249) {
            int _e250 = a;
            a = as_type<int>(as_type<uint>(_e250) + as_type<uint>(2));
        } else {
            int _e253 = b;
            b = as_type<int>(as_type<uint>(_e253) + as_type<uint>(2));
        }
        int _e256 = a;
        int _e259 = b;
        uint _e261 = local;
        local_35 = _e261;
        uint _e263 = local_35;
        local_36 = static_cast<uint>(_e263);
        uint _e266 = base;
        local_37 = static_cast<uint>(_e266 + 6u);
        uint _e271 = local_36;
        uint _e272 = local_37;
        local_113 = static_cast<uint>(_e271 + _e272);
        uint _e276 = local_113;
        out[_e276] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e256) * as_type<uint>(10))) + as_type<uint>(_e259));
        bool _e278 = choose_a;
        if (_e278) {
            int _e279 = a;
            a = as_type<int>(as_type<uint>(_e279) + as_type<uint>(1));
            int _e282 = a;
            local_41 = _e282;
        } else {
            int _e284 = b;
            b = as_type<int>(as_type<uint>(_e284) + as_type<uint>(1));
            int _e287 = b;
            local_41 = _e287;
        }
        int _e290 = local_41;
        uint _e291 = local;
        local_38 = _e291;
        uint _e293 = local_38;
        local_39 = static_cast<uint>(_e293);
        uint _e296 = base;
        local_40 = static_cast<uint>(_e296 + 7u);
        uint _e301 = local_39;
        uint _e302 = local_40;
        local_114 = static_cast<uint>(_e301 + _e302);
        uint _e306 = local_114;
        out[_e306] = _e290;
        bool _e308 = choose_a;
        if (_e308) {
            int _e309 = a;
            a = as_type<int>(as_type<uint>(_e309) + as_type<uint>(1));
            local_45 = _e309;
        } else {
            int _e313 = b;
            b = as_type<int>(as_type<uint>(_e313) + as_type<uint>(1));
            local_45 = _e313;
        }
        int _e318 = local_45;
        uint _e319 = local;
        local_42 = _e319;
        uint _e321 = local_42;
        local_43 = static_cast<uint>(_e321);
        uint _e324 = base;
        local_44 = static_cast<uint>(_e324 + 8u);
        uint _e329 = local_43;
        uint _e330 = local_44;
        local_115 = static_cast<uint>(_e329 + _e330);
        uint _e334 = local_115;
        out[_e334] = _e318;
        int _e336 = a;
        int _e339 = b;
        uint _e341 = local;
        local_46 = _e341;
        uint _e343 = local_46;
        local_47 = static_cast<uint>(_e343);
        uint _e346 = base;
        local_48 = static_cast<uint>(_e346 + 9u);
        uint _e351 = local_47;
        uint _e352 = local_48;
        local_116 = static_cast<uint>(_e351 + _e352);
        uint _e356 = local_116;
        out[_e356] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e336) * as_type<uint>(100))) + as_type<uint>(_e339));
        bool _e358 = choose_a;
        c = static_cast<int>(_e358);
        b = 7;
        int _e362 = c;
        if (_e362 != 0) {
            c = 0;
            int _e366 = c;
            c = as_type<int>(as_type<uint>(_e366) + as_type<uint>(1));
            local_52 = _e366;
        } else {
            b = 0;
            int _e371 = b;
            b = as_type<int>(as_type<uint>(_e371) + as_type<uint>(1));
            local_52 = _e371;
        }
        int _e376 = local_52;
        uint _e377 = local;
        local_49 = _e377;
        uint _e379 = local_49;
        local_50 = static_cast<uint>(_e379);
        uint _e382 = base;
        local_51 = static_cast<uint>(_e382 + 10u);
        uint _e387 = local_50;
        uint _e388 = local_51;
        local_117 = static_cast<uint>(_e387 + _e388);
        uint _e392 = local_117;
        out[_e392] = _e376;
        int _e394 = c;
        int _e397 = b;
        uint _e399 = local;
        local_53 = _e399;
        uint _e401 = local_53;
        local_54 = static_cast<uint>(_e401);
        uint _e404 = base;
        local_55 = static_cast<uint>(_e404 + 11u);
        uint _e409 = local_54;
        uint _e410 = local_55;
        local_118 = static_cast<uint>(_e409 + _e410);
        uint _e414 = local_118;
        out[_e414] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e394) * as_type<uint>(10))) + as_type<uint>(_e397));
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e421 = condition;
        int _e422 = condition;
        if (_e422 != 0) {
            a = _e421;
        } else {
            b = _e421;
        }
        int _e425 = a;
        int _e428 = b;
        uint _e430 = local;
        local_56 = _e430;
        uint _e432 = local_56;
        local_57 = static_cast<uint>(_e432);
        uint _e435 = base;
        local_58 = static_cast<uint>(_e435 + 12u);
        uint _e440 = local_57;
        uint _e441 = local_58;
        local_119 = static_cast<uint>(_e440 + _e441);
        uint _e445 = local_119;
        out[_e445] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e425) * as_type<uint>(10))) + as_type<uint>(_e428));
        a = 2;
        b = 4;
        c = 6;
        bool _e450 = choose_a;
        if (_e450) {
            uint _e451 = i;
            if (naga_mod(_e451, 4u) == 0u) {
                int _e456 = a;
                a = as_type<int>(as_type<uint>(_e456) + as_type<uint>(3));
            } else {
                int _e459 = b;
                b = as_type<int>(as_type<uint>(_e459) + as_type<uint>(3));
            }
        } else {
            int _e462 = c;
            c = as_type<int>(as_type<uint>(_e462) + as_type<uint>(3));
        }
        int _e465 = a;
        int _e468 = b;
        int _e472 = c;
        uint _e474 = local;
        local_59 = _e474;
        uint _e476 = local_59;
        local_60 = static_cast<uint>(_e476);
        uint _e479 = base;
        local_61 = static_cast<uint>(_e479 + 13u);
        uint _e484 = local_60;
        uint _e485 = local_61;
        local_120 = static_cast<uint>(_e484 + _e485);
        uint _e489 = local_120;
        out[_e489] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e465) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e468) * as_type<uint>(10))))) + as_type<uint>(_e472));
        lane = threadIdx.x;
        uint _e493 = lane;
        shared_values.inner[_e493] = 20;
        local_value = 10;
        bool _e499 = choose_a;
        if (_e499) {
            int _e500 = local_value;
            local_value = as_type<int>(as_type<uint>(_e500) + as_type<uint>(5));
        } else {
            uint _e503 = lane;
            int _e505 = shared_values.inner[_e503];
            shared_values.inner[_e503] = as_type<int>(as_type<uint>(_e505) + as_type<uint>(5));
        }
        int _e508 = local_value;
        uint _e511 = lane;
        int _e513 = shared_values.inner[_e511];
        uint _e515 = local;
        local_62 = _e515;
        uint _e517 = local_62;
        local_63 = static_cast<uint>(_e517);
        uint _e520 = base;
        local_64 = static_cast<uint>(_e520 + 14u);
        uint _e525 = local_63;
        uint _e526 = local_64;
        local_121 = static_cast<uint>(_e525 + _e526);
        uint _e530 = local_121;
        out[_e530] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e508) * as_type<uint>(100))) + as_type<uint>(_e513));
        bool _e532 = choose_a;
        if (_e532) {
            uint _e533 = lane;
            shared_values.inner[_e533] = 30;
        } else {
            uint _e536 = local;
            local_65 = _e536;
            uint _e538 = local_65;
            local_66 = static_cast<uint>(_e538);
            uint _e541 = base;
            local_67 = static_cast<uint>(_e541 + 15u);
            uint _e546 = local_66;
            uint _e547 = local_67;
            local_122 = static_cast<uint>(_e546 + _e547);
            uint _e552 = local_122;
            out[_e552] = 30;
        }
        uint _e554 = lane;
        int _e556 = shared_values.inner[_e554];
        uint _e557 = local;
        local_68 = _e557;
        uint _e559 = local_68;
        local_69 = static_cast<uint>(_e559);
        uint _e562 = base;
        local_70 = static_cast<uint>(_e562 + 16u);
        uint _e567 = local_69;
        uint _e568 = local_70;
        local_123 = static_cast<uint>(_e567 + _e568);
        uint _e572 = local_123;
        out[_e572] = _e556;
        bool _e574 = choose_a;
        if (_e574) {
            local_74 = 1.5;
        } else {
            local_74 = static_cast<float>(3);
        }
        float _e581 = local_74;
        uint _e582 = local;
        local_71 = _e582;
        uint _e584 = local_71;
        local_72 = static_cast<uint>(_e584);
        uint _e587 = base;
        local_73 = static_cast<uint>(_e587 + 17u);
        uint _e593 = local_72;
        uint _e594 = local_73;
        local_124 = static_cast<uint>(_e593 + _e594);
        uint _e598 = local_124;
        out[_e598] = naga_f2i32(_e581);
        bool _e600 = choose_a;
        if (_e600) {
            local_78 = static_cast<uint>(naga_neg(1));
        } else {
            local_78 = 2u;
        }
        uint _e608 = local_78;
        uint _e609 = local;
        local_75 = _e609;
        uint _e611 = local_75;
        local_76 = static_cast<uint>(_e611);
        uint _e614 = base;
        local_77 = static_cast<uint>(_e614 + 18u);
        uint _e620 = local_76;
        uint _e621 = local_77;
        local_125 = static_cast<uint>(_e620 + _e621);
        uint _e625 = local_125;
        out[_e625] = static_cast<int>(_e608);
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
        local_80 = static_cast<uint>(_e636);
        uint _e639 = base;
        local_81 = static_cast<uint>(_e639 + 19u);
        uint _e645 = local_80;
        uint _e646 = local_81;
        local_126 = static_cast<uint>(_e645 + _e646);
        uint _e650 = local_126;
        out[_e650] = static_cast<int>(_e633);
        bool _e652 = choose_a;
        if (_e652) {
            local_86 = static_cast<int>(true);
        } else {
            local_86 = 2;
        }
        int _e659 = local_86;
        uint _e660 = local;
        local_83 = _e660;
        uint _e662 = local_83;
        local_84 = static_cast<uint>(_e662);
        uint _e665 = base;
        local_85 = static_cast<uint>(_e665 + 20u);
        uint _e670 = local_84;
        uint _e671 = local_85;
        local_127 = static_cast<uint>(_e670 + _e671);
        uint _e675 = local_127;
        out[_e675] = _e659;
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
        local_88 = static_cast<uint>(_e686);
        uint _e689 = base;
        local_89 = static_cast<uint>(_e689 + 21u);
        uint _e695 = local_88;
        uint _e696 = local_89;
        local_128 = static_cast<uint>(_e695 + _e696);
        uint _e700 = local_128;
        out[_e700] = static_cast<int>(_e683);
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
        local_95 = static_cast<uint>(_e713);
        uint _e716 = local_95;
        uint _e718 = local;
        local_91 = _e718;
        uint _e720 = local_91;
        local_92 = static_cast<uint>(_e720);
        uint _e723 = base;
        local_93 = static_cast<uint>(_e723 + 22u);
        uint _e728 = local_92;
        uint _e729 = local_93;
        local_129 = static_cast<uint>(_e728 + _e729);
        uint _e733 = local_129;
        out[_e733] = _e711 << _e716;
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
        value = as_type<int>(as_type<uint>(_e746) + as_type<uint>(1));
        int _e749 = pair(_e745, _e746);
        uint _e750 = local;
        local_96 = _e750;
        uint _e752 = local_96;
        local_97 = static_cast<uint>(_e752);
        uint _e755 = base;
        local_98 = static_cast<uint>(_e755 + 23u);
        uint _e760 = local_97;
        uint _e761 = local_98;
        local_130 = static_cast<uint>(_e760 + _e761);
        uint _e765 = local_130;
        out[_e765] = _e749;
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
                    bool _e782 = choose_a;
                    if (_e782) {
                        int _e783 = left;
                        left = as_type<int>(as_type<uint>(_e783) + as_type<uint>(1));
                    } else {
                        int _e786 = right;
                        right = as_type<int>(as_type<uint>(_e786) + as_type<uint>(1));
                    }
                }
                loop_init = false;
                int _e773 = count;
                if (_e773 < 3) {
                } else {
                    break;
                }
                int _e776 = count;
                count = as_type<int>(as_type<uint>(_e776) + as_type<uint>(1));
                int _e779 = count;
                if (_e779 == 2) {
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
        local_101 = static_cast<uint>(_e800);
        uint _e803 = base;
        local_102 = static_cast<uint>(_e803 + 24u);
        uint _e808 = local_101;
        uint _e809 = local_102;
        local_131 = static_cast<uint>(_e808 + _e809);
        uint _e813 = local_131;
        out[_e813] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e789) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e792) * as_type<uint>(10))))) + as_type<uint>(_e796));
    }
}
