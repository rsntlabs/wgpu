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
    int value_1 = {};
    type_1 values = {};
    value_1 = value;
    values = type_1 {};
    int _e6 = value_1;
    values.inner[0] = _e6;
    int _e10 = value_1;
    values.inner[1] = as_type<int>(as_type<uint>(_e10) + as_type<uint>(1));
    int _e18 = values.inner[0];
    int _e19 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
    int _e23 = values.inner[2];
    return _e23;
}

int reset_sum(
    int count
) {
    int count_1 = {};
    int result = {};
    int i_1 = {};
    type_2 values_1 = {};
    count_1 = count;
    result = 0;
    {
        i_1 = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e9 = i_1;
                i_1 = as_type<int>(as_type<uint>(_e9) + as_type<uint>(1));
            }
            loop_init = false;
            int _e6 = i_1;
            int _e7 = count_1;
            if (_e6 < _e7) {
            } else {
                break;
            }
            values_1 = type_2 {};
            int _e16 = i_1;
            values_1.inner[1] = _e16;
            int _e21 = values_1.inner[0];
            int _e22 = values_1.inner[1];
            int _e24 = result;
            result = as_type<int>(as_type<uint>(_e24) + as_type<uint>(as_type<int>(as_type<uint>(_e21) + as_type<uint>(_e22))));
            values_1.inner[0] = 99;
        }
    }
    int _e29 = result;
    return _e29;
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
  device type_3& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 local = {};
    int seed = {};
    type_5 local_1 = {};
    uint local_2 = {};
    type_1 signed_values = {};
    type_5 local_3 = {};
    uint local_4 = {};
    type_5 words = {};
    type_5 local_5 = {};
    uint local_6 = {};
    type_7 samples = {};
    type_5 local_7 = {};
    uint local_8 = {};
    type_9 flags = {};
    type_5 local_9 = {};
    uint local_10 = {};
    type_2 zeros = {};
    type_5 local_11 = {};
    uint local_12 = {};
    type_5 local_13 = {};
    uint local_14 = {};
    type_5 local_15 = {};
    uint local_16 = {};
    type_10 zero_flags = {};
    type_5 local_17 = {};
    uint local_18 = {};
    bool local_19 = {};
    type_5 bank = {};
    type_7 bank_1 = {};
    type_5 local_20 = {};
    uint local_21 = {};
    type_5 local_22 = {};
    uint local_23 = {};
    type_2 signed_values_1 = {};
    type_5 local_24 = {};
    uint local_25 = {};
    type_5 local_26 = {};
    uint local_27 = {};
    type_2 mixed = {};
    int next = {};
    type_5 local_28 = {};
    uint local_29 = {};
    type_5 local_30 = {};
    uint local_31 = {};
    int reset_total = {};
    int i = {};
    type_2 reset = {};
    type_5 local_32 = {};
    uint local_33 = {};
    int total = {};
    type_2 scratch = {};
    int j = {};
    type_5 local_34 = {};
    uint local_35 = {};
    type_7 zero_samples = {};
    type_5 local_36 = {};
    uint local_37 = {};
    type_2 left = {};
    type_2 right = {};
    type_5 local_38 = {};
    uint local_39 = {};
    type_2 temporary = {};
    type_2 temporary_1 = {};
    type_5 local_40 = {};
    uint local_41 = {};
    type_5 local_42 = {};
    uint local_43 = {};
    bool choose = {};
    int index = {};
    int rhs = {};
    type_5 local_44 = {};
    uint local_45 = {};
    int local_46 = {};
    type_5 local_47 = {};
    uint local_48 = {};
    type_5 local_49 = {};
    uint local_50 = {};
    type_5 local_51 = {};
    uint local_52 = {};
    int local_53 = {};
    type_5 local_54 = {};
    uint local_55 = {};
    int local_56 = {};
    type_5 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    int local_60 = {};
    type_5 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_5 local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    type_5 local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    type_5 local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    type_5 local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    type_5 local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    type_5 local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    type_5 local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    type_5 local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    type_5 local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    type_5 local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    type_5 local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    type_5 local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    type_5 local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    type_5 local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    type_5 local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    type_5 local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    type_5 local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    type_5 local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    type_5 local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    type_5 local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    type_5 local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    type_5 local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    type_5 local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    type_5 local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    local = type_5 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    type_5 _e9 = local;
    local_1 = _e9;
    local_2 = static_cast<uint>(0);
    type_5 _e14 = local_1;
    local_57 = _e14;
    uint _e15 = local_2;
    uint _e17 = local_57.inner[1];
    local_57.inner[1] = _e17 + _e15;
    uint _e21 = local_57.inner[0];
    local_58 = static_cast<uint>(_e21);
    uint _e25 = local_57.inner[1];
    local_59 = static_cast<uint>(_e25);
    uint _e29 = local_59;
    int _e31 = out[_e29];
    local_60 = _e31;
    int _e32 = local_60;
    local_56 = _e32;
    int _e34 = local_56;
    seed = _e34;
    int _e36 = seed;
    signed_values.inner[0] = _e36;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e51 = signed_values.inner[0];
    int _e52 = signed_values.inner[1];
    int _e56 = signed_values.inner[2];
    type_5 _e59 = local;
    local_3 = _e59;
    local_4 = static_cast<uint>(0);
    type_5 _e64 = local_3;
    local_61 = _e64;
    uint _e65 = local_4;
    uint _e67 = local_61.inner[1];
    local_61.inner[1] = _e67 + _e65;
    uint _e71 = local_61.inner[0];
    local_62 = static_cast<uint>(_e71);
    uint _e75 = local_61.inner[1];
    local_63 = static_cast<uint>(_e75);
    uint _e78 = local_63;
    out[_e78] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e51) + as_type<uint>(_e52))) + as_type<uint>(_e56));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e92 = words.inner[0];
    uint _e93 = words.inner[1];
    type_5 _e98 = local;
    local_5 = _e98;
    local_6 = static_cast<uint>(1);
    type_5 _e104 = local_5;
    local_64 = _e104;
    uint _e105 = local_6;
    uint _e107 = local_64.inner[1];
    local_64.inner[1] = _e107 + _e105;
    uint _e111 = local_64.inner[0];
    local_65 = static_cast<uint>(_e111);
    uint _e115 = local_64.inner[1];
    local_66 = static_cast<uint>(_e115);
    uint _e118 = local_66;
    out[_e118] = static_cast<int>((_e92 + _e93) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e132 = samples.inner[0];
    float _e133 = samples.inner[1];
    type_5 _e139 = local;
    local_7 = _e139;
    local_8 = static_cast<uint>(2);
    type_5 _e144 = local_7;
    local_67 = _e144;
    uint _e145 = local_8;
    uint _e147 = local_67.inner[1];
    local_67.inner[1] = _e147 + _e145;
    uint _e151 = local_67.inner[0];
    local_68 = static_cast<uint>(_e151);
    uint _e155 = local_67.inner[1];
    local_69 = static_cast<uint>(_e155);
    uint _e158 = local_69;
    out[_e158] = naga_f2i32((_e132 + _e133) * 4.0);
    flags = type_9 {};
    int _e162 = seed;
    flags.inner[0] = _e162 != 0;
    flags.inner[2] = true;
    bool _e172 = flags.inner[0];
    bool _e178 = flags.inner[1];
    bool _e185 = flags.inner[2];
    type_5 _e189 = local;
    local_9 = _e189;
    local_10 = static_cast<uint>(3);
    type_5 _e194 = local_9;
    local_70 = _e194;
    uint _e195 = local_10;
    uint _e197 = local_70.inner[1];
    local_70.inner[1] = _e197 + _e195;
    uint _e201 = local_70.inner[0];
    local_71 = static_cast<uint>(_e201);
    uint _e205 = local_70.inner[1];
    local_72 = static_cast<uint>(_e205);
    uint _e208 = local_72;
    out[_e208] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e172)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e178)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e185)));
    zeros = type_2 {};
    int _e216 = zeros.inner[0];
    int _e217 = zeros.inner[1];
    type_5 _e220 = local;
    local_11 = _e220;
    local_12 = static_cast<uint>(4);
    type_5 _e225 = local_11;
    local_73 = _e225;
    uint _e226 = local_12;
    uint _e228 = local_73.inner[1];
    local_73.inner[1] = _e228 + _e226;
    uint _e232 = local_73.inner[0];
    local_74 = static_cast<uint>(_e232);
    uint _e236 = local_73.inner[1];
    local_75 = static_cast<uint>(_e236);
    uint _e239 = local_75;
    out[_e239] = as_type<int>(as_type<uint>(_e216) + as_type<uint>(_e217));
    int _e241 = seed;
    int _e242 = local_sum(_e241);
    type_5 _e244 = local;
    local_13 = _e244;
    local_14 = static_cast<uint>(5);
    type_5 _e249 = local_13;
    local_76 = _e249;
    uint _e250 = local_14;
    uint _e252 = local_76.inner[1];
    local_76.inner[1] = _e252 + _e250;
    uint _e256 = local_76.inner[0];
    local_77 = static_cast<uint>(_e256);
    uint _e260 = local_76.inner[1];
    local_78 = static_cast<uint>(_e260);
    uint _e263 = local_78;
    out[_e263] = _e242;
    int _e266 = reset_sum(3);
    type_5 _e268 = local;
    local_15 = _e268;
    local_16 = static_cast<uint>(6);
    type_5 _e273 = local_15;
    local_79 = _e273;
    uint _e274 = local_16;
    uint _e276 = local_79.inner[1];
    local_79.inner[1] = _e276 + _e274;
    uint _e280 = local_79.inner[0];
    local_80 = static_cast<uint>(_e280);
    uint _e284 = local_79.inner[1];
    local_81 = static_cast<uint>(_e284);
    uint _e287 = local_81;
    out[_e287] = _e266;
    zero_flags = type_10 {};
    bool _e293 = zero_flags.inner[0];
    local_19 = _e293;
    if (_e293) {
    } else {
        bool _e297 = zero_flags.inner[1];
        local_19 = _e297;
    }
    bool _e298 = local_19;
    type_5 _e300 = local;
    local_17 = _e300;
    local_18 = static_cast<uint>(7);
    type_5 _e306 = local_17;
    local_82 = _e306;
    uint _e307 = local_18;
    uint _e309 = local_82.inner[1];
    local_82.inner[1] = _e309 + _e307;
    uint _e313 = local_82.inner[0];
    local_83 = static_cast<uint>(_e313);
    uint _e317 = local_82.inner[1];
    local_84 = static_cast<uint>(_e317);
    uint _e320 = local_84;
    out[_e320] = static_cast<int>(_e298);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e339 = bank_1.inner[0];
        float _e340 = bank_1.inner[1];
        type_5 _e344 = local;
        local_20 = _e344;
        local_21 = static_cast<uint>(8);
        type_5 _e349 = local_20;
        local_85 = _e349;
        uint _e350 = local_21;
        uint _e352 = local_85.inner[1];
        local_85.inner[1] = _e352 + _e350;
        uint _e356 = local_85.inner[0];
        local_86 = static_cast<uint>(_e356);
        uint _e360 = local_85.inner[1];
        local_87 = static_cast<uint>(_e360);
        uint _e363 = local_87;
        out[_e363] = naga_f2i32(_e339 + _e340);
    }
    uint _e369 = bank.inner[0];
    uint _e370 = bank.inner[1];
    type_5 _e374 = local;
    local_22 = _e374;
    local_23 = static_cast<uint>(9);
    type_5 _e379 = local_22;
    local_88 = _e379;
    uint _e380 = local_23;
    uint _e382 = local_88.inner[1];
    local_88.inner[1] = _e382 + _e380;
    uint _e386 = local_88.inner[0];
    local_89 = static_cast<uint>(_e386);
    uint _e390 = local_88.inner[1];
    local_90 = static_cast<uint>(_e390);
    uint _e393 = local_90;
    out[_e393] = static_cast<int>(_e369 + _e370);
    {
        int _e395 = seed;
        signed_values_1.inner[0] = _e395;
        int _e399 = seed;
        signed_values_1.inner[1] = _e399;
        int _e406 = signed_values_1.inner[0];
        int _e407 = signed_values_1.inner[1];
        type_5 _e410 = local;
        local_24 = _e410;
        local_25 = static_cast<uint>(10);
        type_5 _e415 = local_24;
        local_91 = _e415;
        uint _e416 = local_25;
        uint _e418 = local_91.inner[1];
        local_91.inner[1] = _e418 + _e416;
        uint _e422 = local_91.inner[0];
        local_92 = static_cast<uint>(_e422);
        uint _e426 = local_91.inner[1];
        local_93 = static_cast<uint>(_e426);
        uint _e429 = local_93;
        out[_e429] = as_type<int>(as_type<uint>(_e406) + as_type<uint>(_e407));
    }
    int _e433 = signed_values.inner[0];
    type_5 _e435 = local;
    local_26 = _e435;
    local_27 = static_cast<uint>(11);
    type_5 _e440 = local_26;
    local_94 = _e440;
    uint _e441 = local_27;
    uint _e443 = local_94.inner[1];
    local_94.inner[1] = _e443 + _e441;
    uint _e447 = local_94.inner[0];
    local_95 = static_cast<uint>(_e447);
    uint _e451 = local_94.inner[1];
    local_96 = static_cast<uint>(_e451);
    uint _e454 = local_96;
    out[_e454] = _e433;
    mixed = type_2 {};
    int _e458 = seed;
    seed = as_type<int>(as_type<uint>(_e458) + as_type<uint>(1));
    int _e461 = seed;
    next = _e461;
    int _e463 = next;
    mixed.inner[0] = _e463;
    int _e466 = seed;
    seed = as_type<int>(as_type<uint>(_e466) + as_type<uint>(1));
    mixed.inner[1] = _e466;
    int _e473 = mixed.inner[0];
    int _e478 = mixed.inner[1];
    type_5 _e481 = local;
    local_28 = _e481;
    local_29 = static_cast<uint>(12);
    type_5 _e486 = local_28;
    local_97 = _e486;
    uint _e487 = local_29;
    uint _e489 = local_97.inner[1];
    local_97.inner[1] = _e489 + _e487;
    uint _e493 = local_97.inner[0];
    local_98 = static_cast<uint>(_e493);
    uint _e497 = local_97.inner[1];
    local_99 = static_cast<uint>(_e497);
    uint _e500 = local_99;
    out[_e500] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e473) * as_type<uint>(10))) + as_type<uint>(_e478));
    int _e502 = seed;
    type_5 _e504 = local;
    local_30 = _e504;
    local_31 = static_cast<uint>(13);
    type_5 _e509 = local_30;
    local_100 = _e509;
    uint _e510 = local_31;
    uint _e512 = local_100.inner[1];
    local_100.inner[1] = _e512 + _e510;
    uint _e516 = local_100.inner[0];
    local_101 = static_cast<uint>(_e516);
    uint _e520 = local_100.inner[1];
    local_102 = static_cast<uint>(_e520);
    uint _e523 = local_102;
    out[_e523] = _e502;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e550 = i;
                i = as_type<int>(as_type<uint>(_e550) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e529 = i;
            if (_e529 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e534 = i;
            if (_e534 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e542 = reset.inner[0];
            int _e543 = i;
            int _e545 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e545) + as_type<uint>(as_type<int>(as_type<uint>(_e542) + as_type<uint>(_e543))));
            reset.inner[0] = 99;
        }
    }
    int _e553 = reset_total;
    type_5 _e555 = local;
    local_32 = _e555;
    local_33 = static_cast<uint>(14);
    type_5 _e560 = local_32;
    local_103 = _e560;
    uint _e561 = local_33;
    uint _e563 = local_103.inner[1];
    local_103.inner[1] = _e563 + _e561;
    uint _e567 = local_103.inner[0];
    local_104 = static_cast<uint>(_e567);
    uint _e571 = local_103.inner[1];
    local_105 = static_cast<uint>(_e571);
    uint _e574 = local_105;
    out[_e574] = _e553;
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
                int _e606 = j;
                j = as_type<int>(as_type<uint>(_e606) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e582 = j;
            if (_e582 < 3) {
            } else {
                break;
            }
            int _e585 = j;
            int _e589 = scratch.inner[naga_mod(_e585, 2)];
            scratch.inner[naga_mod(_e585, 2)] = as_type<int>(as_type<uint>(_e589) + as_type<uint>(1));
            int _e592 = j;
            if (_e592 == 1) {
                continue;
            }
            int _e597 = scratch.inner[0];
            int _e602 = scratch.inner[1];
            int _e604 = total;
            total = as_type<int>(as_type<uint>(_e604) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e597) * as_type<uint>(10))) + as_type<uint>(_e602))));
        }
    }
    int _e609 = total;
    type_5 _e611 = local;
    local_34 = _e611;
    local_35 = static_cast<uint>(15);
    type_5 _e616 = local_34;
    local_106 = _e616;
    uint _e617 = local_35;
    uint _e619 = local_106.inner[1];
    local_106.inner[1] = _e619 + _e617;
    uint _e623 = local_106.inner[0];
    local_107 = static_cast<uint>(_e623);
    uint _e627 = local_106.inner[1];
    local_108 = static_cast<uint>(_e627);
    uint _e630 = local_108;
    out[_e630] = _e609;
    zero_samples = type_7 {};
    float _e638 = zero_samples.inner[0];
    float _e639 = zero_samples.inner[1];
    type_5 _e643 = local;
    local_36 = _e643;
    local_37 = static_cast<uint>(16);
    type_5 _e648 = local_36;
    local_109 = _e648;
    uint _e649 = local_37;
    uint _e651 = local_109.inner[1];
    local_109.inner[1] = _e651 + _e649;
    uint _e655 = local_109.inner[0];
    local_110 = static_cast<uint>(_e655);
    uint _e659 = local_109.inner[1];
    local_111 = static_cast<uint>(_e659);
    uint _e662 = local_111;
    out[_e662] = naga_f2i32(_e638 + _e639);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e684 = left.inner[0];
    int _e685 = right.inner[0];
    type_5 _e688 = local;
    local_38 = _e688;
    local_39 = static_cast<uint>(17);
    type_5 _e693 = local_38;
    local_112 = _e693;
    uint _e694 = local_39;
    uint _e696 = local_112.inner[1];
    local_112.inner[1] = _e696 + _e694;
    uint _e700 = local_112.inner[0];
    local_113 = static_cast<uint>(_e700);
    uint _e704 = local_112.inner[1];
    local_114 = static_cast<uint>(_e704);
    uint _e707 = local_114;
    out[_e707] = as_type<int>(as_type<uint>(_e684) + as_type<uint>(_e685));
    {
        temporary = type_2 {};
        int _e711 = seed;
        temporary.inner[0] = _e711;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e723 = temporary_1.inner[0];
            int _e724 = temporary_1.inner[1];
            type_5 _e727 = local;
            local_40 = _e727;
            local_41 = static_cast<uint>(18);
            type_5 _e732 = local_40;
            local_115 = _e732;
            uint _e733 = local_41;
            uint _e735 = local_115.inner[1];
            local_115.inner[1] = _e735 + _e733;
            uint _e739 = local_115.inner[0];
            local_116 = static_cast<uint>(_e739);
            uint _e743 = local_115.inner[1];
            local_117 = static_cast<uint>(_e743);
            uint _e746 = local_117;
            out[_e746] = as_type<int>(as_type<uint>(_e723) + as_type<uint>(_e724));
        }
        int _e750 = temporary.inner[0];
        type_5 _e752 = local;
        local_42 = _e752;
        local_43 = static_cast<uint>(19);
        type_5 _e757 = local_42;
        local_118 = _e757;
        uint _e758 = local_43;
        uint _e760 = local_118.inner[1];
        local_118.inner[1] = _e760 + _e758;
        uint _e764 = local_118.inner[0];
        local_119 = static_cast<uint>(_e764);
        uint _e768 = local_118.inner[1];
        local_120 = static_cast<uint>(_e768);
        uint _e771 = local_120;
        out[_e771] = _e750;
    }
    int _e773 = seed;
    choose = (_e773 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e783 = rhs;
    rhs = as_type<int>(as_type<uint>(_e783) + as_type<uint>(1));
    int _e786 = rhs;
    bool _e787 = choose;
    if (_e787) {
        int _e788 = index;
        index = as_type<int>(as_type<uint>(_e788) + as_type<uint>(1));
        int _e792 = left.inner[_e788];
        left.inner[_e788] = as_type<int>(as_type<uint>(_e792) + as_type<uint>(_e786));
        int _e794 = left.inner[_e788];
        local_46 = _e794;
    } else {
        int _e796 = index;
        index = as_type<int>(as_type<uint>(_e796) + as_type<uint>(1));
        int _e800 = right.inner[_e796];
        right.inner[_e796] = as_type<int>(as_type<uint>(_e800) + as_type<uint>(_e786));
        int _e802 = right.inner[_e796];
        local_46 = _e802;
    }
    int _e805 = local_46;
    type_5 _e807 = local;
    local_44 = _e807;
    local_45 = static_cast<uint>(20);
    type_5 _e812 = local_44;
    local_121 = _e812;
    uint _e813 = local_45;
    uint _e815 = local_121.inner[1];
    local_121.inner[1] = _e815 + _e813;
    uint _e819 = local_121.inner[0];
    local_122 = static_cast<uint>(_e819);
    uint _e823 = local_121.inner[1];
    local_123 = static_cast<uint>(_e823);
    uint _e826 = local_123;
    out[_e826] = _e805;
    int _e828 = index;
    type_5 _e830 = local;
    local_47 = _e830;
    local_48 = static_cast<uint>(21);
    type_5 _e835 = local_47;
    local_124 = _e835;
    uint _e836 = local_48;
    uint _e838 = local_124.inner[1];
    local_124.inner[1] = _e838 + _e836;
    uint _e842 = local_124.inner[0];
    local_125 = static_cast<uint>(_e842);
    uint _e846 = local_124.inner[1];
    local_126 = static_cast<uint>(_e846);
    uint _e849 = local_126;
    out[_e849] = _e828;
    int _e853 = left.inner[0];
    int _e858 = right.inner[0];
    type_5 _e861 = local;
    local_49 = _e861;
    local_50 = static_cast<uint>(22);
    type_5 _e866 = local_49;
    local_127 = _e866;
    uint _e867 = local_50;
    uint _e869 = local_127.inner[1];
    local_127.inner[1] = _e869 + _e867;
    uint _e873 = local_127.inner[0];
    local_128 = static_cast<uint>(_e873);
    uint _e877 = local_127.inner[1];
    local_129 = static_cast<uint>(_e877);
    uint _e880 = local_129;
    out[_e880] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e853) * as_type<uint>(100))) + as_type<uint>(_e858));
    bool _e882 = choose;
    if (_e882) {
        right.inner[1] = 9;
        int _e886 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e886) + as_type<uint>(1));
        local_53 = _e886;
    } else {
        left.inner[1] = 9;
        int _e893 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e893) + as_type<uint>(1));
        local_53 = _e893;
    }
    int _e898 = local_53;
    type_5 _e900 = local;
    local_51 = _e900;
    local_52 = static_cast<uint>(23);
    type_5 _e905 = local_51;
    local_130 = _e905;
    uint _e906 = local_52;
    uint _e908 = local_130.inner[1];
    local_130.inner[1] = _e908 + _e906;
    uint _e912 = local_130.inner[0];
    local_131 = static_cast<uint>(_e912);
    uint _e916 = local_130.inner[1];
    local_132 = static_cast<uint>(_e916);
    uint _e919 = local_132;
    out[_e919] = _e898;
    int _e923 = left.inner[1];
    int _e928 = right.inner[1];
    type_5 _e931 = local;
    local_54 = _e931;
    local_55 = static_cast<uint>(24);
    type_5 _e936 = local_54;
    local_133 = _e936;
    uint _e937 = local_55;
    uint _e939 = local_133.inner[1];
    local_133.inner[1] = _e939 + _e937;
    uint _e943 = local_133.inner[0];
    local_134 = static_cast<uint>(_e943);
    uint _e947 = local_133.inner[1];
    local_135 = static_cast<uint>(_e947);
    uint _e950 = local_135;
    out[_e950] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e923) * as_type<uint>(100))) + as_type<uint>(_e928));
}
