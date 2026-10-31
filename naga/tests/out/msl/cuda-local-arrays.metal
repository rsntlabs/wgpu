// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[3];
};
struct type_2 {
    int inner[2];
};
typedef int type_3[1];
struct type_5 {
    uint inner[2];
};
struct type_7 {
    float inner[2];
};
struct type_9 {
    bool inner[3];
};
struct type_10 {
    bool inner[2];
};

int local_sum(
    int value
) {
    type_1 values = {};
    values = type_1 {};
    values.inner[0] = value;
    values.inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(1));
    int _e13 = values.inner[0];
    int _e14 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e13) + as_type<uint>(_e14));
    int _e20 = values.inner[2];
    return _e20;
}

int reset_sum(
    int count
) {
    int result = {};
    int i_1 = {};
    type_2 values_1 = {};
    result = 0;
    {
        i_1 = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e24 = i_1;
                i_1 = as_type<int>(as_type<uint>(_e24) + as_type<uint>(1));
            }
            loop_init = false;
            int _e5 = i_1;
            if (_e5 < count) {
            } else {
                break;
            }
            values_1 = type_2 {};
            int _e9 = i_1;
            values_1.inner[1] = _e9;
            int _e16 = values_1.inner[0];
            int _e17 = values_1.inner[1];
            int _e19 = result;
            result = as_type<int>(as_type<uint>(_e19) + as_type<uint>(as_type<int>(as_type<uint>(_e16) + as_type<uint>(_e17))));
            values_1.inner[0] = 99;
        }
    }
    int _e27 = result;
    return _e27;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_mod(int lhs, int rhs) {
    int divisor = metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}


kernel void local_arrays(
  device type_3& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 out = {};
    int seed = {};
    type_5 local = {};
    uint local_1 = {};
    type_1 signed_values = {};
    type_5 local_2 = {};
    uint local_3 = {};
    type_5 words = {};
    type_5 local_4 = {};
    uint local_5 = {};
    type_7 samples = {};
    type_5 local_6 = {};
    uint local_7 = {};
    type_9 flags = {};
    type_5 local_8 = {};
    uint local_9 = {};
    type_2 zeros = {};
    type_5 local_10 = {};
    uint local_11 = {};
    type_5 local_12 = {};
    uint local_13 = {};
    type_5 local_14 = {};
    uint local_15 = {};
    type_10 zero_flags = {};
    type_5 local_16 = {};
    uint local_17 = {};
    bool local_18 = {};
    type_5 bank = {};
    type_7 bank_1 = {};
    type_5 local_19 = {};
    uint local_20 = {};
    type_5 local_21 = {};
    uint local_22 = {};
    type_2 signed_values_1 = {};
    type_5 local_23 = {};
    uint local_24 = {};
    type_5 local_25 = {};
    uint local_26 = {};
    type_2 mixed = {};
    type_5 local_27 = {};
    uint local_28 = {};
    type_5 local_29 = {};
    uint local_30 = {};
    int reset_total = {};
    int i = {};
    type_2 reset = {};
    type_5 local_31 = {};
    uint local_32 = {};
    int total = {};
    type_2 scratch = {};
    int j = {};
    type_5 local_33 = {};
    uint local_34 = {};
    type_7 zero_samples = {};
    type_5 local_35 = {};
    uint local_36 = {};
    type_2 left = {};
    type_2 right = {};
    type_5 local_37 = {};
    uint local_38 = {};
    type_2 temporary = {};
    type_2 temporary_1 = {};
    type_5 local_39 = {};
    uint local_40 = {};
    type_5 local_41 = {};
    uint local_42 = {};
    int index = {};
    int rhs = {};
    type_5 local_43 = {};
    uint local_44 = {};
    int local_45 = {};
    type_5 local_46 = {};
    uint local_47 = {};
    type_5 local_48 = {};
    uint local_49 = {};
    type_5 local_50 = {};
    uint local_51 = {};
    int local_52 = {};
    type_5 local_53 = {};
    uint local_54 = {};
    int local_55 = {};
    type_5 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    int local_59 = {};
    type_5 local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    type_5 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_5 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_5 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_5 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_5 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_5 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_5 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_5 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_5 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_5 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_5 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_5 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_5 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_5 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_5 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_5 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_5 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_5 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_5 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_5 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_5 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_5 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_5 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_5 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    out = type_5 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    type_5 _e7 = out;
    local = _e7;
    local_1 = static_cast<uint>(0);
    type_5 _e12 = local;
    local_56 = _e12;
    uint _e14 = local_1;
    uint _e16 = local_56.inner[1];
    local_56.inner[1] = _e16 + _e14;
    uint _e20 = local_56.inner[0];
    local_57 = static_cast<uint>(_e20);
    uint _e24 = local_56.inner[1];
    local_58 = static_cast<uint>(_e24);
    uint _e27 = local_58;
    int _e30 = out_1[_e27];
    local_59 = _e30;
    int _e32 = local_59;
    local_55 = _e32;
    int _e34 = local_55;
    seed = _e34;
    int _e36 = seed;
    signed_values.inner[0] = _e36;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e51 = signed_values.inner[0];
    int _e52 = signed_values.inner[1];
    int _e56 = signed_values.inner[2];
    type_5 _e58 = out;
    local_2 = _e58;
    local_3 = static_cast<uint>(0);
    type_5 _e63 = local_2;
    local_60 = _e63;
    uint _e65 = local_3;
    uint _e67 = local_60.inner[1];
    local_60.inner[1] = _e67 + _e65;
    uint _e71 = local_60.inner[0];
    local_61 = static_cast<uint>(_e71);
    uint _e75 = local_60.inner[1];
    local_62 = static_cast<uint>(_e75);
    uint _e78 = local_62;
    out_1[_e78] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e51) + as_type<uint>(_e52))) + as_type<uint>(_e56));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e92 = words.inner[0];
    uint _e93 = words.inner[1];
    type_5 _e97 = out;
    local_4 = _e97;
    local_5 = static_cast<uint>(1);
    type_5 _e103 = local_4;
    local_63 = _e103;
    uint _e105 = local_5;
    uint _e107 = local_63.inner[1];
    local_63.inner[1] = _e107 + _e105;
    uint _e111 = local_63.inner[0];
    local_64 = static_cast<uint>(_e111);
    uint _e115 = local_63.inner[1];
    local_65 = static_cast<uint>(_e115);
    uint _e118 = local_65;
    out_1[_e118] = static_cast<int>((_e92 + _e93) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e132 = samples.inner[0];
    float _e133 = samples.inner[1];
    type_5 _e138 = out;
    local_6 = _e138;
    local_7 = static_cast<uint>(2);
    type_5 _e143 = local_6;
    local_66 = _e143;
    uint _e145 = local_7;
    uint _e147 = local_66.inner[1];
    local_66.inner[1] = _e147 + _e145;
    uint _e151 = local_66.inner[0];
    local_67 = static_cast<uint>(_e151);
    uint _e155 = local_66.inner[1];
    local_68 = static_cast<uint>(_e155);
    uint _e158 = local_68;
    out_1[_e158] = naga_f2i32((_e132 + _e133) * 4.0);
    flags = type_9 {};
    int _e162 = seed;
    flags.inner[0] = _e162 != 0;
    flags.inner[2] = true;
    bool _e172 = flags.inner[0];
    bool _e178 = flags.inner[1];
    bool _e185 = flags.inner[2];
    type_5 _e188 = out;
    local_8 = _e188;
    local_9 = static_cast<uint>(3);
    type_5 _e193 = local_8;
    local_69 = _e193;
    uint _e195 = local_9;
    uint _e197 = local_69.inner[1];
    local_69.inner[1] = _e197 + _e195;
    uint _e201 = local_69.inner[0];
    local_70 = static_cast<uint>(_e201);
    uint _e205 = local_69.inner[1];
    local_71 = static_cast<uint>(_e205);
    uint _e208 = local_71;
    out_1[_e208] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e172)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e178)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e185)));
    zeros = type_2 {};
    int _e216 = zeros.inner[0];
    int _e217 = zeros.inner[1];
    type_5 _e219 = out;
    local_10 = _e219;
    local_11 = static_cast<uint>(4);
    type_5 _e224 = local_10;
    local_72 = _e224;
    uint _e226 = local_11;
    uint _e228 = local_72.inner[1];
    local_72.inner[1] = _e228 + _e226;
    uint _e232 = local_72.inner[0];
    local_73 = static_cast<uint>(_e232);
    uint _e236 = local_72.inner[1];
    local_74 = static_cast<uint>(_e236);
    uint _e239 = local_74;
    out_1[_e239] = as_type<int>(as_type<uint>(_e216) + as_type<uint>(_e217));
    int _e241 = seed;
    int _e242 = local_sum(_e241);
    type_5 _e243 = out;
    local_12 = _e243;
    local_13 = static_cast<uint>(5);
    type_5 _e248 = local_12;
    local_75 = _e248;
    uint _e250 = local_13;
    uint _e252 = local_75.inner[1];
    local_75.inner[1] = _e252 + _e250;
    uint _e256 = local_75.inner[0];
    local_76 = static_cast<uint>(_e256);
    uint _e260 = local_75.inner[1];
    local_77 = static_cast<uint>(_e260);
    uint _e263 = local_77;
    out_1[_e263] = _e242;
    int _e266 = reset_sum(3);
    type_5 _e267 = out;
    local_14 = _e267;
    local_15 = static_cast<uint>(6);
    type_5 _e272 = local_14;
    local_78 = _e272;
    uint _e274 = local_15;
    uint _e276 = local_78.inner[1];
    local_78.inner[1] = _e276 + _e274;
    uint _e280 = local_78.inner[0];
    local_79 = static_cast<uint>(_e280);
    uint _e284 = local_78.inner[1];
    local_80 = static_cast<uint>(_e284);
    uint _e287 = local_80;
    out_1[_e287] = _e266;
    zero_flags = type_10 {};
    bool _e293 = zero_flags.inner[0];
    local_18 = _e293;
    if (_e293) {
    } else {
        bool _e297 = zero_flags.inner[1];
        local_18 = _e297;
    }
    bool _e298 = local_18;
    type_5 _e299 = out;
    local_16 = _e299;
    local_17 = static_cast<uint>(7);
    type_5 _e305 = local_16;
    local_81 = _e305;
    uint _e307 = local_17;
    uint _e309 = local_81.inner[1];
    local_81.inner[1] = _e309 + _e307;
    uint _e313 = local_81.inner[0];
    local_82 = static_cast<uint>(_e313);
    uint _e317 = local_81.inner[1];
    local_83 = static_cast<uint>(_e317);
    uint _e320 = local_83;
    out_1[_e320] = static_cast<int>(_e298);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e339 = bank_1.inner[0];
        float _e340 = bank_1.inner[1];
        type_5 _e343 = out;
        local_19 = _e343;
        local_20 = static_cast<uint>(8);
        type_5 _e348 = local_19;
        local_84 = _e348;
        uint _e350 = local_20;
        uint _e352 = local_84.inner[1];
        local_84.inner[1] = _e352 + _e350;
        uint _e356 = local_84.inner[0];
        local_85 = static_cast<uint>(_e356);
        uint _e360 = local_84.inner[1];
        local_86 = static_cast<uint>(_e360);
        uint _e363 = local_86;
        out_1[_e363] = naga_f2i32(_e339 + _e340);
    }
    uint _e369 = bank.inner[0];
    uint _e370 = bank.inner[1];
    type_5 _e373 = out;
    local_21 = _e373;
    local_22 = static_cast<uint>(9);
    type_5 _e378 = local_21;
    local_87 = _e378;
    uint _e380 = local_22;
    uint _e382 = local_87.inner[1];
    local_87.inner[1] = _e382 + _e380;
    uint _e386 = local_87.inner[0];
    local_88 = static_cast<uint>(_e386);
    uint _e390 = local_87.inner[1];
    local_89 = static_cast<uint>(_e390);
    uint _e393 = local_89;
    out_1[_e393] = static_cast<int>(_e369 + _e370);
    {
        int _e395 = seed;
        signed_values_1.inner[0] = _e395;
        int _e399 = seed;
        signed_values_1.inner[1] = _e399;
        int _e406 = signed_values_1.inner[0];
        int _e407 = signed_values_1.inner[1];
        type_5 _e409 = out;
        local_23 = _e409;
        local_24 = static_cast<uint>(10);
        type_5 _e414 = local_23;
        local_90 = _e414;
        uint _e416 = local_24;
        uint _e418 = local_90.inner[1];
        local_90.inner[1] = _e418 + _e416;
        uint _e422 = local_90.inner[0];
        local_91 = static_cast<uint>(_e422);
        uint _e426 = local_90.inner[1];
        local_92 = static_cast<uint>(_e426);
        uint _e429 = local_92;
        out_1[_e429] = as_type<int>(as_type<uint>(_e406) + as_type<uint>(_e407));
    }
    int _e433 = signed_values.inner[0];
    type_5 _e434 = out;
    local_25 = _e434;
    local_26 = static_cast<uint>(11);
    type_5 _e439 = local_25;
    local_93 = _e439;
    uint _e441 = local_26;
    uint _e443 = local_93.inner[1];
    local_93.inner[1] = _e443 + _e441;
    uint _e447 = local_93.inner[0];
    local_94 = static_cast<uint>(_e447);
    uint _e451 = local_93.inner[1];
    local_95 = static_cast<uint>(_e451);
    uint _e454 = local_95;
    out_1[_e454] = _e433;
    mixed = type_2 {};
    int _e458 = seed;
    seed = as_type<int>(as_type<uint>(_e458) + as_type<uint>(1));
    int next = seed;
    mixed.inner[0] = next;
    int _e464 = seed;
    seed = as_type<int>(as_type<uint>(_e464) + as_type<uint>(1));
    mixed.inner[1] = _e464;
    int _e471 = mixed.inner[0];
    int _e476 = mixed.inner[1];
    type_5 _e478 = out;
    local_27 = _e478;
    local_28 = static_cast<uint>(12);
    type_5 _e483 = local_27;
    local_96 = _e483;
    uint _e485 = local_28;
    uint _e487 = local_96.inner[1];
    local_96.inner[1] = _e487 + _e485;
    uint _e491 = local_96.inner[0];
    local_97 = static_cast<uint>(_e491);
    uint _e495 = local_96.inner[1];
    local_98 = static_cast<uint>(_e495);
    uint _e498 = local_98;
    out_1[_e498] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e471) * as_type<uint>(10))) + as_type<uint>(_e476));
    int _e500 = seed;
    type_5 _e501 = out;
    local_29 = _e501;
    local_30 = static_cast<uint>(13);
    type_5 _e506 = local_29;
    local_99 = _e506;
    uint _e508 = local_30;
    uint _e510 = local_99.inner[1];
    local_99.inner[1] = _e510 + _e508;
    uint _e514 = local_99.inner[0];
    local_100 = static_cast<uint>(_e514);
    uint _e518 = local_99.inner[1];
    local_101 = static_cast<uint>(_e518);
    uint _e521 = local_101;
    out_1[_e521] = _e500;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e548 = i;
                i = as_type<int>(as_type<uint>(_e548) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e527 = i;
            if (_e527 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e532 = i;
            if (_e532 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e540 = reset.inner[0];
            int _e541 = i;
            int _e543 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e543) + as_type<uint>(as_type<int>(as_type<uint>(_e540) + as_type<uint>(_e541))));
            reset.inner[0] = 99;
        }
    }
    int _e551 = reset_total;
    type_5 _e552 = out;
    local_31 = _e552;
    local_32 = static_cast<uint>(14);
    type_5 _e557 = local_31;
    local_102 = _e557;
    uint _e559 = local_32;
    uint _e561 = local_102.inner[1];
    local_102.inner[1] = _e561 + _e559;
    uint _e565 = local_102.inner[0];
    local_103 = static_cast<uint>(_e565);
    uint _e569 = local_102.inner[1];
    local_104 = static_cast<uint>(_e569);
    uint _e572 = local_104;
    out_1[_e572] = _e551;
    total = 0;
    {
        scratch = type_2 {};
        j = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e604 = j;
                j = as_type<int>(as_type<uint>(_e604) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e580 = j;
            if (_e580 < 3) {
            } else {
                break;
            }
            int _e583 = j;
            int _e587 = scratch.inner[naga_mod(_e583, 2)];
            scratch.inner[naga_mod(_e583, 2)] = as_type<int>(as_type<uint>(_e587) + as_type<uint>(1));
            int _e590 = j;
            if (_e590 == 1) {
                continue;
            }
            int _e595 = scratch.inner[0];
            int _e600 = scratch.inner[1];
            int _e602 = total;
            total = as_type<int>(as_type<uint>(_e602) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e595) * as_type<uint>(10))) + as_type<uint>(_e600))));
        }
    }
    int _e607 = total;
    type_5 _e608 = out;
    local_33 = _e608;
    local_34 = static_cast<uint>(15);
    type_5 _e613 = local_33;
    local_105 = _e613;
    uint _e615 = local_34;
    uint _e617 = local_105.inner[1];
    local_105.inner[1] = _e617 + _e615;
    uint _e621 = local_105.inner[0];
    local_106 = static_cast<uint>(_e621);
    uint _e625 = local_105.inner[1];
    local_107 = static_cast<uint>(_e625);
    uint _e628 = local_107;
    out_1[_e628] = _e607;
    zero_samples = type_7 {};
    float _e636 = zero_samples.inner[0];
    float _e637 = zero_samples.inner[1];
    type_5 _e640 = out;
    local_35 = _e640;
    local_36 = static_cast<uint>(16);
    type_5 _e645 = local_35;
    local_108 = _e645;
    uint _e647 = local_36;
    uint _e649 = local_108.inner[1];
    local_108.inner[1] = _e649 + _e647;
    uint _e653 = local_108.inner[0];
    local_109 = static_cast<uint>(_e653);
    uint _e657 = local_108.inner[1];
    local_110 = static_cast<uint>(_e657);
    uint _e660 = local_110;
    out_1[_e660] = naga_f2i32(_e636 + _e637);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e682 = left.inner[0];
    int _e683 = right.inner[0];
    type_5 _e685 = out;
    local_37 = _e685;
    local_38 = static_cast<uint>(17);
    type_5 _e690 = local_37;
    local_111 = _e690;
    uint _e692 = local_38;
    uint _e694 = local_111.inner[1];
    local_111.inner[1] = _e694 + _e692;
    uint _e698 = local_111.inner[0];
    local_112 = static_cast<uint>(_e698);
    uint _e702 = local_111.inner[1];
    local_113 = static_cast<uint>(_e702);
    uint _e705 = local_113;
    out_1[_e705] = as_type<int>(as_type<uint>(_e682) + as_type<uint>(_e683));
    {
        temporary = type_2 {};
        int _e709 = seed;
        temporary.inner[0] = _e709;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e721 = temporary_1.inner[0];
            int _e722 = temporary_1.inner[1];
            type_5 _e724 = out;
            local_39 = _e724;
            local_40 = static_cast<uint>(18);
            type_5 _e729 = local_39;
            local_114 = _e729;
            uint _e731 = local_40;
            uint _e733 = local_114.inner[1];
            local_114.inner[1] = _e733 + _e731;
            uint _e737 = local_114.inner[0];
            local_115 = static_cast<uint>(_e737);
            uint _e741 = local_114.inner[1];
            local_116 = static_cast<uint>(_e741);
            uint _e744 = local_116;
            out_1[_e744] = as_type<int>(as_type<uint>(_e721) + as_type<uint>(_e722));
        }
        int _e748 = temporary.inner[0];
        type_5 _e749 = out;
        local_41 = _e749;
        local_42 = static_cast<uint>(19);
        type_5 _e754 = local_41;
        local_117 = _e754;
        uint _e756 = local_42;
        uint _e758 = local_117.inner[1];
        local_117.inner[1] = _e758 + _e756;
        uint _e762 = local_117.inner[0];
        local_118 = static_cast<uint>(_e762);
        uint _e766 = local_117.inner[1];
        local_119 = static_cast<uint>(_e766);
        uint _e769 = local_119;
        out_1[_e769] = _e748;
    }
    int _e771 = seed;
    bool choose = (_e771 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e780 = rhs;
    rhs = as_type<int>(as_type<uint>(_e780) + as_type<uint>(1));
    int _e783 = rhs;
    if (choose) {
        int _e784 = index;
        index = as_type<int>(as_type<uint>(_e784) + as_type<uint>(1));
        int _e788 = left.inner[_e784];
        left.inner[_e784] = as_type<int>(as_type<uint>(_e788) + as_type<uint>(_e783));
        int _e790 = left.inner[_e784];
        local_45 = _e790;
    } else {
        int _e792 = index;
        index = as_type<int>(as_type<uint>(_e792) + as_type<uint>(1));
        int _e796 = right.inner[_e792];
        right.inner[_e792] = as_type<int>(as_type<uint>(_e796) + as_type<uint>(_e783));
        int _e798 = right.inner[_e792];
        local_45 = _e798;
    }
    int _e801 = local_45;
    type_5 _e802 = out;
    local_43 = _e802;
    local_44 = static_cast<uint>(20);
    type_5 _e807 = local_43;
    local_120 = _e807;
    uint _e809 = local_44;
    uint _e811 = local_120.inner[1];
    local_120.inner[1] = _e811 + _e809;
    uint _e815 = local_120.inner[0];
    local_121 = static_cast<uint>(_e815);
    uint _e819 = local_120.inner[1];
    local_122 = static_cast<uint>(_e819);
    uint _e822 = local_122;
    out_1[_e822] = _e801;
    int _e824 = index;
    type_5 _e825 = out;
    local_46 = _e825;
    local_47 = static_cast<uint>(21);
    type_5 _e830 = local_46;
    local_123 = _e830;
    uint _e832 = local_47;
    uint _e834 = local_123.inner[1];
    local_123.inner[1] = _e834 + _e832;
    uint _e838 = local_123.inner[0];
    local_124 = static_cast<uint>(_e838);
    uint _e842 = local_123.inner[1];
    local_125 = static_cast<uint>(_e842);
    uint _e845 = local_125;
    out_1[_e845] = _e824;
    int _e849 = left.inner[0];
    int _e854 = right.inner[0];
    type_5 _e856 = out;
    local_48 = _e856;
    local_49 = static_cast<uint>(22);
    type_5 _e861 = local_48;
    local_126 = _e861;
    uint _e863 = local_49;
    uint _e865 = local_126.inner[1];
    local_126.inner[1] = _e865 + _e863;
    uint _e869 = local_126.inner[0];
    local_127 = static_cast<uint>(_e869);
    uint _e873 = local_126.inner[1];
    local_128 = static_cast<uint>(_e873);
    uint _e876 = local_128;
    out_1[_e876] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e849) * as_type<uint>(100))) + as_type<uint>(_e854));
    if (choose) {
        right.inner[1] = 9;
        int _e881 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e881) + as_type<uint>(1));
        local_52 = _e881;
    } else {
        left.inner[1] = 9;
        int _e888 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e888) + as_type<uint>(1));
        local_52 = _e888;
    }
    int _e893 = local_52;
    type_5 _e894 = out;
    local_50 = _e894;
    local_51 = static_cast<uint>(23);
    type_5 _e899 = local_50;
    local_129 = _e899;
    uint _e901 = local_51;
    uint _e903 = local_129.inner[1];
    local_129.inner[1] = _e903 + _e901;
    uint _e907 = local_129.inner[0];
    local_130 = static_cast<uint>(_e907);
    uint _e911 = local_129.inner[1];
    local_131 = static_cast<uint>(_e911);
    uint _e914 = local_131;
    out_1[_e914] = _e893;
    int _e918 = left.inner[1];
    int _e923 = right.inner[1];
    type_5 _e925 = out;
    local_53 = _e925;
    local_54 = static_cast<uint>(24);
    type_5 _e930 = local_53;
    local_132 = _e930;
    uint _e932 = local_54;
    uint _e934 = local_132.inner[1];
    local_132.inner[1] = _e934 + _e932;
    uint _e938 = local_132.inner[0];
    local_133 = static_cast<uint>(_e938);
    uint _e942 = local_132.inner[1];
    local_134 = static_cast<uint>(_e942);
    uint _e945 = local_134;
    out_1[_e945] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e918) * as_type<uint>(100))) + as_type<uint>(_e923));
}
