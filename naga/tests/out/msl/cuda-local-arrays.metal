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
    uint local = {};
    int seed = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    type_1 signed_values = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    type_5 words = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    type_7 samples = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    type_9 flags = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    type_2 zeros = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_10 zero_flags = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    bool local_28 = {};
    type_5 bank = {};
    type_7 bank_1 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_2 signed_values_1 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    type_2 mixed = {};
    int next = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    int reset_total = {};
    int i = {};
    type_2 reset = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    int total = {};
    type_2 scratch = {};
    int j = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_7 zero_samples = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_2 left = {};
    type_2 right = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_2 temporary = {};
    type_2 temporary_1 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    bool choose = {};
    int index = {};
    int rhs = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    int local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    int local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    int local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    local = 0u;
    uint _e2 = local;
    local_1 = _e2;
    uint _e4 = local_1;
    local_2 = static_cast<uint>(_e4);
    local_3 = static_cast<uint>(0);
    uint _e11 = local_2;
    uint _e12 = local_3;
    local_82 = static_cast<uint>(_e11 + _e12);
    uint _e17 = local_82;
    int _e19 = out[_e17];
    local_83 = _e19;
    int _e20 = local_83;
    seed = _e20;
    int _e22 = seed;
    signed_values.inner[0] = _e22;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e37 = signed_values.inner[0];
    int _e38 = signed_values.inner[1];
    int _e42 = signed_values.inner[2];
    uint _e44 = local;
    local_4 = _e44;
    uint _e46 = local_4;
    local_5 = static_cast<uint>(_e46);
    local_6 = static_cast<uint>(0);
    uint _e52 = local_5;
    uint _e53 = local_6;
    local_84 = static_cast<uint>(_e52 + _e53);
    uint _e57 = local_84;
    out[_e57] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e37) + as_type<uint>(_e38))) + as_type<uint>(_e42));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e71 = words.inner[0];
    uint _e72 = words.inner[1];
    uint _e76 = local;
    local_7 = _e76;
    uint _e78 = local_7;
    local_8 = static_cast<uint>(_e78);
    local_9 = static_cast<uint>(1);
    uint _e85 = local_8;
    uint _e86 = local_9;
    local_85 = static_cast<uint>(_e85 + _e86);
    uint _e90 = local_85;
    out[_e90] = static_cast<int>((_e71 + _e72) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e104 = samples.inner[0];
    float _e105 = samples.inner[1];
    uint _e110 = local;
    local_10 = _e110;
    uint _e112 = local_10;
    local_11 = static_cast<uint>(_e112);
    local_12 = static_cast<uint>(2);
    uint _e118 = local_11;
    uint _e119 = local_12;
    local_86 = static_cast<uint>(_e118 + _e119);
    uint _e123 = local_86;
    out[_e123] = naga_f2i32((_e104 + _e105) * 4.0);
    flags = type_9 {};
    int _e127 = seed;
    flags.inner[0] = _e127 != 0;
    flags.inner[2] = true;
    bool _e137 = flags.inner[0];
    bool _e143 = flags.inner[1];
    bool _e150 = flags.inner[2];
    uint _e153 = local;
    local_13 = _e153;
    uint _e155 = local_13;
    local_14 = static_cast<uint>(_e155);
    local_15 = static_cast<uint>(3);
    uint _e161 = local_14;
    uint _e162 = local_15;
    local_87 = static_cast<uint>(_e161 + _e162);
    uint _e166 = local_87;
    out[_e166] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e137)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e143)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e150)));
    zeros = type_2 {};
    int _e174 = zeros.inner[0];
    int _e175 = zeros.inner[1];
    uint _e177 = local;
    local_16 = _e177;
    uint _e179 = local_16;
    local_17 = static_cast<uint>(_e179);
    local_18 = static_cast<uint>(4);
    uint _e185 = local_17;
    uint _e186 = local_18;
    local_88 = static_cast<uint>(_e185 + _e186);
    uint _e190 = local_88;
    out[_e190] = as_type<int>(as_type<uint>(_e174) + as_type<uint>(_e175));
    int _e192 = seed;
    int _e193 = local_sum(_e192);
    uint _e194 = local;
    local_19 = _e194;
    uint _e196 = local_19;
    local_20 = static_cast<uint>(_e196);
    local_21 = static_cast<uint>(5);
    uint _e202 = local_20;
    uint _e203 = local_21;
    local_89 = static_cast<uint>(_e202 + _e203);
    uint _e207 = local_89;
    out[_e207] = _e193;
    int _e210 = reset_sum(3);
    uint _e211 = local;
    local_22 = _e211;
    uint _e213 = local_22;
    local_23 = static_cast<uint>(_e213);
    local_24 = static_cast<uint>(6);
    uint _e219 = local_23;
    uint _e220 = local_24;
    local_90 = static_cast<uint>(_e219 + _e220);
    uint _e224 = local_90;
    out[_e224] = _e210;
    zero_flags = type_10 {};
    bool _e230 = zero_flags.inner[0];
    local_28 = _e230;
    if (_e230) {
    } else {
        bool _e234 = zero_flags.inner[1];
        local_28 = _e234;
    }
    bool _e235 = local_28;
    uint _e236 = local;
    local_25 = _e236;
    uint _e238 = local_25;
    local_26 = static_cast<uint>(_e238);
    local_27 = static_cast<uint>(7);
    uint _e245 = local_26;
    uint _e246 = local_27;
    local_91 = static_cast<uint>(_e245 + _e246);
    uint _e250 = local_91;
    out[_e250] = static_cast<int>(_e235);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e269 = bank_1.inner[0];
        float _e270 = bank_1.inner[1];
        uint _e273 = local;
        local_29 = _e273;
        uint _e275 = local_29;
        local_30 = static_cast<uint>(_e275);
        local_31 = static_cast<uint>(8);
        uint _e281 = local_30;
        uint _e282 = local_31;
        local_92 = static_cast<uint>(_e281 + _e282);
        uint _e286 = local_92;
        out[_e286] = naga_f2i32(_e269 + _e270);
    }
    uint _e292 = bank.inner[0];
    uint _e293 = bank.inner[1];
    uint _e296 = local;
    local_32 = _e296;
    uint _e298 = local_32;
    local_33 = static_cast<uint>(_e298);
    local_34 = static_cast<uint>(9);
    uint _e304 = local_33;
    uint _e305 = local_34;
    local_93 = static_cast<uint>(_e304 + _e305);
    uint _e309 = local_93;
    out[_e309] = static_cast<int>(_e292 + _e293);
    {
        int _e311 = seed;
        signed_values_1.inner[0] = _e311;
        int _e315 = seed;
        signed_values_1.inner[1] = _e315;
        int _e322 = signed_values_1.inner[0];
        int _e323 = signed_values_1.inner[1];
        uint _e325 = local;
        local_35 = _e325;
        uint _e327 = local_35;
        local_36 = static_cast<uint>(_e327);
        local_37 = static_cast<uint>(10);
        uint _e333 = local_36;
        uint _e334 = local_37;
        local_94 = static_cast<uint>(_e333 + _e334);
        uint _e338 = local_94;
        out[_e338] = as_type<int>(as_type<uint>(_e322) + as_type<uint>(_e323));
    }
    int _e342 = signed_values.inner[0];
    uint _e343 = local;
    local_38 = _e343;
    uint _e345 = local_38;
    local_39 = static_cast<uint>(_e345);
    local_40 = static_cast<uint>(11);
    uint _e351 = local_39;
    uint _e352 = local_40;
    local_95 = static_cast<uint>(_e351 + _e352);
    uint _e356 = local_95;
    out[_e356] = _e342;
    mixed = type_2 {};
    int _e360 = seed;
    seed = as_type<int>(as_type<uint>(_e360) + as_type<uint>(1));
    int _e363 = seed;
    next = _e363;
    int _e365 = next;
    mixed.inner[0] = _e365;
    int _e368 = seed;
    seed = as_type<int>(as_type<uint>(_e368) + as_type<uint>(1));
    mixed.inner[1] = _e368;
    int _e375 = mixed.inner[0];
    int _e380 = mixed.inner[1];
    uint _e382 = local;
    local_41 = _e382;
    uint _e384 = local_41;
    local_42 = static_cast<uint>(_e384);
    local_43 = static_cast<uint>(12);
    uint _e390 = local_42;
    uint _e391 = local_43;
    local_96 = static_cast<uint>(_e390 + _e391);
    uint _e395 = local_96;
    out[_e395] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e375) * as_type<uint>(10))) + as_type<uint>(_e380));
    int _e397 = seed;
    uint _e398 = local;
    local_44 = _e398;
    uint _e400 = local_44;
    local_45 = static_cast<uint>(_e400);
    local_46 = static_cast<uint>(13);
    uint _e406 = local_45;
    uint _e407 = local_46;
    local_97 = static_cast<uint>(_e406 + _e407);
    uint _e411 = local_97;
    out[_e411] = _e397;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e438 = i;
                i = as_type<int>(as_type<uint>(_e438) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e417 = i;
            if (_e417 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e422 = i;
            if (_e422 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e430 = reset.inner[0];
            int _e431 = i;
            int _e433 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e433) + as_type<uint>(as_type<int>(as_type<uint>(_e430) + as_type<uint>(_e431))));
            reset.inner[0] = 99;
        }
    }
    int _e441 = reset_total;
    uint _e442 = local;
    local_47 = _e442;
    uint _e444 = local_47;
    local_48 = static_cast<uint>(_e444);
    local_49 = static_cast<uint>(14);
    uint _e450 = local_48;
    uint _e451 = local_49;
    local_98 = static_cast<uint>(_e450 + _e451);
    uint _e455 = local_98;
    out[_e455] = _e441;
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
                int _e487 = j;
                j = as_type<int>(as_type<uint>(_e487) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e463 = j;
            if (_e463 < 3) {
            } else {
                break;
            }
            int _e466 = j;
            int _e470 = scratch.inner[naga_mod(_e466, 2)];
            scratch.inner[naga_mod(_e466, 2)] = as_type<int>(as_type<uint>(_e470) + as_type<uint>(1));
            int _e473 = j;
            if (_e473 == 1) {
                continue;
            }
            int _e478 = scratch.inner[0];
            int _e483 = scratch.inner[1];
            int _e485 = total;
            total = as_type<int>(as_type<uint>(_e485) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e478) * as_type<uint>(10))) + as_type<uint>(_e483))));
        }
    }
    int _e490 = total;
    uint _e491 = local;
    local_50 = _e491;
    uint _e493 = local_50;
    local_51 = static_cast<uint>(_e493);
    local_52 = static_cast<uint>(15);
    uint _e499 = local_51;
    uint _e500 = local_52;
    local_99 = static_cast<uint>(_e499 + _e500);
    uint _e504 = local_99;
    out[_e504] = _e490;
    zero_samples = type_7 {};
    float _e512 = zero_samples.inner[0];
    float _e513 = zero_samples.inner[1];
    uint _e516 = local;
    local_53 = _e516;
    uint _e518 = local_53;
    local_54 = static_cast<uint>(_e518);
    local_55 = static_cast<uint>(16);
    uint _e524 = local_54;
    uint _e525 = local_55;
    local_100 = static_cast<uint>(_e524 + _e525);
    uint _e529 = local_100;
    out[_e529] = naga_f2i32(_e512 + _e513);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e551 = left.inner[0];
    int _e552 = right.inner[0];
    uint _e554 = local;
    local_56 = _e554;
    uint _e556 = local_56;
    local_57 = static_cast<uint>(_e556);
    local_58 = static_cast<uint>(17);
    uint _e562 = local_57;
    uint _e563 = local_58;
    local_101 = static_cast<uint>(_e562 + _e563);
    uint _e567 = local_101;
    out[_e567] = as_type<int>(as_type<uint>(_e551) + as_type<uint>(_e552));
    {
        temporary = type_2 {};
        int _e571 = seed;
        temporary.inner[0] = _e571;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e583 = temporary_1.inner[0];
            int _e584 = temporary_1.inner[1];
            uint _e586 = local;
            local_59 = _e586;
            uint _e588 = local_59;
            local_60 = static_cast<uint>(_e588);
            local_61 = static_cast<uint>(18);
            uint _e594 = local_60;
            uint _e595 = local_61;
            local_102 = static_cast<uint>(_e594 + _e595);
            uint _e599 = local_102;
            out[_e599] = as_type<int>(as_type<uint>(_e583) + as_type<uint>(_e584));
        }
        int _e603 = temporary.inner[0];
        uint _e604 = local;
        local_62 = _e604;
        uint _e606 = local_62;
        local_63 = static_cast<uint>(_e606);
        local_64 = static_cast<uint>(19);
        uint _e612 = local_63;
        uint _e613 = local_64;
        local_103 = static_cast<uint>(_e612 + _e613);
        uint _e617 = local_103;
        out[_e617] = _e603;
    }
    int _e619 = seed;
    choose = (_e619 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e629 = rhs;
    rhs = as_type<int>(as_type<uint>(_e629) + as_type<uint>(1));
    int _e632 = rhs;
    bool _e633 = choose;
    if (_e633) {
        int _e634 = index;
        index = as_type<int>(as_type<uint>(_e634) + as_type<uint>(1));
        int _e638 = left.inner[_e634];
        left.inner[_e634] = as_type<int>(as_type<uint>(_e638) + as_type<uint>(_e632));
        int _e640 = left.inner[_e634];
        local_68 = _e640;
    } else {
        int _e642 = index;
        index = as_type<int>(as_type<uint>(_e642) + as_type<uint>(1));
        int _e646 = right.inner[_e642];
        right.inner[_e642] = as_type<int>(as_type<uint>(_e646) + as_type<uint>(_e632));
        int _e648 = right.inner[_e642];
        local_68 = _e648;
    }
    int _e651 = local_68;
    uint _e652 = local;
    local_65 = _e652;
    uint _e654 = local_65;
    local_66 = static_cast<uint>(_e654);
    local_67 = static_cast<uint>(20);
    uint _e660 = local_66;
    uint _e661 = local_67;
    local_104 = static_cast<uint>(_e660 + _e661);
    uint _e665 = local_104;
    out[_e665] = _e651;
    int _e667 = index;
    uint _e668 = local;
    local_69 = _e668;
    uint _e670 = local_69;
    local_70 = static_cast<uint>(_e670);
    local_71 = static_cast<uint>(21);
    uint _e676 = local_70;
    uint _e677 = local_71;
    local_105 = static_cast<uint>(_e676 + _e677);
    uint _e681 = local_105;
    out[_e681] = _e667;
    int _e685 = left.inner[0];
    int _e690 = right.inner[0];
    uint _e692 = local;
    local_72 = _e692;
    uint _e694 = local_72;
    local_73 = static_cast<uint>(_e694);
    local_74 = static_cast<uint>(22);
    uint _e700 = local_73;
    uint _e701 = local_74;
    local_106 = static_cast<uint>(_e700 + _e701);
    uint _e705 = local_106;
    out[_e705] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e685) * as_type<uint>(100))) + as_type<uint>(_e690));
    bool _e707 = choose;
    if (_e707) {
        right.inner[1] = 9;
        int _e711 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e711) + as_type<uint>(1));
        local_78 = _e711;
    } else {
        left.inner[1] = 9;
        int _e718 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e718) + as_type<uint>(1));
        local_78 = _e718;
    }
    int _e723 = local_78;
    uint _e724 = local;
    local_75 = _e724;
    uint _e726 = local_75;
    local_76 = static_cast<uint>(_e726);
    local_77 = static_cast<uint>(23);
    uint _e732 = local_76;
    uint _e733 = local_77;
    local_107 = static_cast<uint>(_e732 + _e733);
    uint _e737 = local_107;
    out[_e737] = _e723;
    int _e741 = left.inner[1];
    int _e746 = right.inner[1];
    uint _e748 = local;
    local_79 = _e748;
    uint _e750 = local_79;
    local_80 = static_cast<uint>(_e750);
    local_81 = static_cast<uint>(24);
    uint _e756 = local_80;
    uint _e757 = local_81;
    local_108 = static_cast<uint>(_e756 + _e757);
    uint _e761 = local_108;
    out[_e761] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e741) * as_type<uint>(100))) + as_type<uint>(_e746));
}
