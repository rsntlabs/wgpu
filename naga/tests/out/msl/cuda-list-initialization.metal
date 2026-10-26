// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_2 {
    int inner[3];
};
struct int3_ {
    int x;
    int y;
    int z;
};
typedef int type_4[1];
struct type_6 {
    int3_ inner[2];
};
struct type_8 {
    metal::int2 inner[2];
};
struct type_9 {
    int inner[2];
};
struct float3_ {
    float x;
    float y;
    float z;
};
constant int Global = 2;
constant float Scale = 0.5;

int pair(
    int first,
    int second
) {
    int first_1 = {};
    int second_1 = {};
    first_1 = first;
    second_1 = second;
    int _e5 = first_1;
    int _e7 = second_1;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e5) * as_type<uint>(10))) + as_type<uint>(_e7));
}

int list_sum(
    int seed_1
) {
    int seed_2 = {};
    type_2 values_1 = {};
    uint local_130 = {};
    seed_2 = seed_1;
    int _e4 = seed_2;
    values_1.inner[0] = _e4;
    int _e7 = seed_2;
    values_1.inner[1] = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
    local_130 = 2u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e16 = local_130;
            local_130 = _e16 + 1u;
        }
        loop_init = false;
        uint _e12 = local_130;
        if (_e12 >= 3u) {
            break;
        }
        values_1.inner[_e12] = int {};
    }
    int _e23 = values_1.inner[0];
    int _e24 = values_1.inner[1];
    int _e28 = values_1.inner[2];
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e23) + as_type<uint>(_e24))) + as_type<uint>(_e28));
}

int3_ make_list(
    int seed_3
) {
    int seed_4 = {};
    int3_ value = {};
    seed_4 = seed_3;
    int _e3 = seed_4;
    value.x = _e3;
    int _e6 = seed_4;
    value.y = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
    int _e10 = seed_4;
    value.z = as_type<int>(as_type<uint>(_e10) + as_type<uint>(2));
    int3_ _e13 = value;
    return _e13;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void list_initialization(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    int seed = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    int zero = {};
    int copy_zero = {};
    bool enabled = {};
    uint count = {};
    float sample = {};
    int Local = {};
    int Safe = {};
    int local_4 = {};
    type_2 safe_values = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_2 values = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    type_2 changed = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int3_ point = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    int3_ changed_point = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    type_6 nested = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_8 flat = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    int3_ original = {};
    int3_ copied = {};
    type_6 copies = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    int counter = {};
    type_2 ordered = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    int called = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    int zero_total = {};
    int iteration = {};
    type_2 reset = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    int total = {};
    int iteration_1 = {};
    int limit = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    int Number = {};
    type_9 cached = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    type_2 frozen = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    float3_ floating = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    int3_ from_call = {};
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
    int local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
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
    local = 0u;
    uint _e2 = local;
    local_1 = _e2;
    uint _e4 = local_1;
    local_2 = static_cast<uint>(_e4);
    local_3 = static_cast<uint>(0);
    uint _e11 = local_2;
    uint _e12 = local_3;
    local_98 = static_cast<uint>(_e11 + _e12);
    uint _e17 = local_98;
    int _e19 = out[_e17];
    local_99 = _e19;
    int _e20 = local_99;
    seed = _e20;
    zero = 0;
    copy_zero = 0;
    enabled = true;
    count = static_cast<uint>(7);
    sample = 1.5;
    Local = 3;
    Safe = 3;
    safe_values.inner[0] = 1;
    local_5 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e47 = local_5;
            local_5 = _e47 + 1u;
        }
        loop_init_1 = false;
        uint _e42 = local_5;
        if (_e42 >= 3u) {
            break;
        }
        safe_values.inner[_e42] = int {};
    }
    int _e50 = zero;
    uint _e51 = local;
    local_6 = _e51;
    uint _e53 = local_6;
    local_7 = static_cast<uint>(_e53);
    local_8 = static_cast<uint>(0);
    uint _e59 = local_7;
    uint _e60 = local_8;
    local_100 = static_cast<uint>(_e59 + _e60);
    uint _e64 = local_100;
    out[_e64] = _e50;
    int _e66 = copy_zero;
    uint _e67 = local;
    local_9 = _e67;
    uint _e69 = local_9;
    local_10 = static_cast<uint>(_e69);
    local_11 = static_cast<uint>(1);
    uint _e75 = local_10;
    uint _e76 = local_11;
    local_101 = static_cast<uint>(_e75 + _e76);
    uint _e80 = local_101;
    out[_e80] = _e66;
    bool _e82 = enabled;
    uint _e84 = local;
    local_12 = _e84;
    uint _e86 = local_12;
    local_13 = static_cast<uint>(_e86);
    local_14 = static_cast<uint>(2);
    uint _e92 = local_13;
    uint _e93 = local_14;
    local_102 = static_cast<uint>(_e92 + _e93);
    uint _e97 = local_102;
    out[_e97] = static_cast<int>(_e82);
    uint _e99 = count;
    uint _e101 = local;
    local_15 = _e101;
    uint _e103 = local_15;
    local_16 = static_cast<uint>(_e103);
    local_17 = static_cast<uint>(3);
    uint _e109 = local_16;
    uint _e110 = local_17;
    local_103 = static_cast<uint>(_e109 + _e110);
    uint _e114 = local_103;
    out[_e114] = static_cast<int>(_e99);
    float _e116 = sample;
    uint _e120 = local;
    local_18 = _e120;
    uint _e122 = local_18;
    local_19 = static_cast<uint>(_e122);
    local_20 = static_cast<uint>(4);
    uint _e128 = local_19;
    uint _e129 = local_20;
    local_104 = static_cast<uint>(_e128 + _e129);
    uint _e133 = local_104;
    out[_e133] = naga_f2i32(_e116 * 2.0);
    int _e135 = Local;
    uint _e138 = local;
    local_21 = _e138;
    uint _e140 = local_21;
    local_22 = static_cast<uint>(_e140);
    local_23 = static_cast<uint>(5);
    uint _e146 = local_22;
    uint _e147 = local_23;
    local_105 = static_cast<uint>(_e146 + _e147);
    uint _e151 = local_105;
    out[_e151] = as_type<int>(as_type<uint>(Global) + as_type<uint>(_e135));
    int _e155 = safe_values.inner[2];
    uint _e156 = local;
    local_24 = _e156;
    uint _e158 = local_24;
    local_25 = static_cast<uint>(_e158);
    local_26 = static_cast<uint>(6);
    uint _e164 = local_25;
    uint _e165 = local_26;
    local_106 = static_cast<uint>(_e164 + _e165);
    uint _e169 = local_106;
    out[_e169] = _e155;
    values.inner[0] = 1;
    int _e177 = values.inner[0];
    values.inner[1] = as_type<int>(as_type<uint>(_e177) + as_type<uint>(1));
    int _e183 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e183) + as_type<uint>(1));
    int _e190 = values.inner[0];
    int _e191 = values.inner[1];
    int _e195 = values.inner[2];
    uint _e197 = local;
    local_27 = _e197;
    uint _e199 = local_27;
    local_28 = static_cast<uint>(_e199);
    local_29 = static_cast<uint>(7);
    uint _e205 = local_28;
    uint _e206 = local_29;
    local_107 = static_cast<uint>(_e205 + _e206);
    uint _e210 = local_107;
    out[_e210] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e190) + as_type<uint>(_e191))) + as_type<uint>(_e195));
    changed.inner[0] = 1;
    changed.inner[0] = 7;
    changed.inner[1] = 2;
    int _e223 = changed.inner[0];
    changed.inner[2] = _e223;
    int _e226 = changed.inner[0];
    uint _e227 = local;
    local_30 = _e227;
    uint _e229 = local_30;
    local_31 = static_cast<uint>(_e229);
    local_32 = static_cast<uint>(8);
    uint _e235 = local_31;
    uint _e236 = local_32;
    local_108 = static_cast<uint>(_e235 + _e236);
    uint _e240 = local_108;
    out[_e240] = _e226;
    int _e244 = changed.inner[2];
    uint _e245 = local;
    local_33 = _e245;
    uint _e247 = local_33;
    local_34 = static_cast<uint>(_e247);
    local_35 = static_cast<uint>(9);
    uint _e253 = local_34;
    uint _e254 = local_35;
    local_109 = static_cast<uint>(_e253 + _e254);
    uint _e258 = local_109;
    out[_e258] = _e244;
    point.x = 1;
    int _e264 = point.x;
    point.y = as_type<int>(as_type<uint>(_e264) + as_type<uint>(1));
    int _e269 = point.y;
    point.z = as_type<int>(as_type<uint>(_e269) + as_type<uint>(1));
    int _e274 = point.z;
    uint _e275 = local;
    local_36 = _e275;
    uint _e277 = local_36;
    local_37 = static_cast<uint>(_e277);
    local_38 = static_cast<uint>(10);
    uint _e283 = local_37;
    uint _e284 = local_38;
    local_110 = static_cast<uint>(_e283 + _e284);
    uint _e288 = local_110;
    out[_e288] = _e274;
    changed_point.x = 1;
    changed_point.x = 9;
    changed_point.y = 2;
    int _e298 = changed_point.x;
    changed_point.z = _e298;
    int _e301 = changed_point.x;
    uint _e302 = local;
    local_39 = _e302;
    uint _e304 = local_39;
    local_40 = static_cast<uint>(_e304);
    local_41 = static_cast<uint>(11);
    uint _e310 = local_40;
    uint _e311 = local_41;
    local_111 = static_cast<uint>(_e310 + _e311);
    uint _e315 = local_111;
    out[_e315] = _e301;
    int _e318 = changed_point.z;
    uint _e319 = local;
    local_42 = _e319;
    uint _e321 = local_42;
    local_43 = static_cast<uint>(_e321);
    local_44 = static_cast<uint>(12);
    uint _e327 = local_43;
    uint _e328 = local_44;
    local_112 = static_cast<uint>(_e327 + _e328);
    uint _e332 = local_112;
    out[_e332] = _e318;
    nested.inner[0].x = 1;
    nested.inner[0].y = 2;
    nested.inner[0].z = int {};
    nested.inner[1].x = 3;
    nested.inner[1].y = int {};
    nested.inner[1].z = int {};
    int _e355 = nested.inner[0].z;
    int _e356 = nested.inner[1].x;
    uint _e358 = local;
    local_45 = _e358;
    uint _e360 = local_45;
    local_46 = static_cast<uint>(_e360);
    local_47 = static_cast<uint>(13);
    uint _e366 = local_46;
    uint _e367 = local_47;
    local_113 = static_cast<uint>(_e366 + _e367);
    uint _e371 = local_113;
    out[_e371] = as_type<int>(as_type<uint>(_e355) + as_type<uint>(_e356));
    flat.inner[0].x = 1;
    flat.inner[0].y = 2;
    flat.inner[1].x = 3;
    flat.inner[1].y = int {};
    int _e390 = flat.inner[0].x;
    int _e391 = flat.inner[0].y;
    int _e396 = flat.inner[1].x;
    int _e401 = flat.inner[1].y;
    uint _e403 = local;
    local_48 = _e403;
    uint _e405 = local_48;
    local_49 = static_cast<uint>(_e405);
    local_50 = static_cast<uint>(14);
    uint _e411 = local_49;
    uint _e412 = local_50;
    local_114 = static_cast<uint>(_e411 + _e412);
    uint _e416 = local_114;
    out[_e416] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e390) + as_type<uint>(_e391))) + as_type<uint>(_e396))) + as_type<uint>(_e401));
    original.x = 2;
    original.y = 3;
    original.z = 4;
    int3_ _e425 = original;
    copied = _e425;
    int3_ _e429 = original;
    copies.inner[0] = _e429;
    copies.inner[1].x = 5;
    copies.inner[1].y = 6;
    copies.inner[1].z = int {};
    original.x = 99;
    int _e440 = copied.x;
    uint _e441 = local;
    local_51 = _e441;
    uint _e443 = local_51;
    local_52 = static_cast<uint>(_e443);
    local_53 = static_cast<uint>(15);
    uint _e449 = local_52;
    uint _e450 = local_53;
    local_115 = static_cast<uint>(_e449 + _e450);
    uint _e454 = local_115;
    out[_e454] = _e440;
    int _e459 = copies.inner[0].x;
    uint _e460 = local;
    local_54 = _e460;
    uint _e462 = local_54;
    local_55 = static_cast<uint>(_e462);
    local_56 = static_cast<uint>(16);
    uint _e468 = local_55;
    uint _e469 = local_56;
    local_116 = static_cast<uint>(_e468 + _e469);
    uint _e473 = local_116;
    out[_e473] = _e459;
    int _e478 = copies.inner[1].z;
    uint _e479 = local;
    local_57 = _e479;
    uint _e481 = local_57;
    local_58 = static_cast<uint>(_e481);
    local_59 = static_cast<uint>(17);
    uint _e487 = local_58;
    uint _e488 = local_59;
    local_117 = static_cast<uint>(_e487 + _e488);
    uint _e492 = local_117;
    out[_e492] = _e478;
    int _e494 = seed;
    counter = _e494;
    int _e498 = counter;
    counter = as_type<int>(as_type<uint>(_e498) + as_type<uint>(1));
    ordered.inner[0] = _e498;
    int _e502 = counter;
    counter = as_type<int>(as_type<uint>(_e502) + as_type<uint>(1));
    ordered.inner[1] = _e502;
    int _e506 = counter;
    ordered.inner[2] = _e506;
    int _e509 = ordered.inner[0];
    int _e514 = ordered.inner[1];
    int _e520 = ordered.inner[2];
    uint _e522 = local;
    local_60 = _e522;
    uint _e524 = local_60;
    local_61 = static_cast<uint>(_e524);
    local_62 = static_cast<uint>(18);
    uint _e530 = local_61;
    uint _e531 = local_62;
    local_118 = static_cast<uint>(_e530 + _e531);
    uint _e535 = local_118;
    out[_e535] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e509) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e514) * as_type<uint>(10))))) + as_type<uint>(_e520));
    int _e537 = counter;
    uint _e538 = local;
    local_63 = _e538;
    uint _e540 = local_63;
    local_64 = static_cast<uint>(_e540);
    local_65 = static_cast<uint>(19);
    uint _e546 = local_64;
    uint _e547 = local_65;
    local_119 = static_cast<uint>(_e546 + _e547);
    uint _e551 = local_119;
    out[_e551] = _e537;
    int _e553 = counter;
    counter = as_type<int>(as_type<uint>(_e553) + as_type<uint>(1));
    int _e557 = pair(_e553, 4);
    called = _e557;
    int _e559 = called;
    uint _e560 = local;
    local_66 = _e560;
    uint _e562 = local_66;
    local_67 = static_cast<uint>(_e562);
    local_68 = static_cast<uint>(20);
    uint _e568 = local_67;
    uint _e569 = local_68;
    local_120 = static_cast<uint>(_e568 + _e569);
    uint _e573 = local_120;
    out[_e573] = _e559;
    zero_total = 0;
    {
        iteration = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e603 = iteration;
                iteration = as_type<int>(as_type<uint>(_e603) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e579 = iteration;
            if (_e579 < 3) {
            } else {
                break;
            }
            int _e584 = iteration;
            reset.inner[0] = _e584;
            local_69 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (metal::all(loop_bound_3 == uint2(0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e592 = local_69;
                    local_69 = _e592 + 1u;
                }
                loop_init_3 = false;
                uint _e587 = local_69;
                if (_e587 >= 3u) {
                    break;
                }
                reset.inner[_e587] = int {};
            }
            int _e597 = reset.inner[2];
            int _e598 = zero_total;
            zero_total = as_type<int>(as_type<uint>(_e598) + as_type<uint>(_e597));
            reset.inner[2] = 9;
        }
    }
    int _e606 = zero_total;
    uint _e607 = local;
    local_70 = _e607;
    uint _e609 = local_70;
    local_71 = static_cast<uint>(_e609);
    local_72 = static_cast<uint>(21);
    uint _e615 = local_71;
    uint _e616 = local_72;
    local_121 = static_cast<uint>(_e615 + _e616);
    uint _e620 = local_121;
    out[_e620] = _e606;
    total = 0;
    {
        iteration_1 = 0;
        limit = 3;
        uint2 loop_bound_4 = uint2(4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (metal::all(loop_bound_4 == uint2(0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                int _e634 = iteration_1;
                iteration_1 = as_type<int>(as_type<uint>(_e634) + as_type<uint>(1));
            }
            loop_init_4 = false;
            int _e628 = iteration_1;
            int _e629 = limit;
            if (_e628 < _e629) {
            } else {
                break;
            }
            int _e631 = iteration_1;
            int _e632 = total;
            total = as_type<int>(as_type<uint>(_e632) + as_type<uint>(_e631));
        }
    }
    int _e637 = total;
    uint _e638 = local;
    local_73 = _e638;
    uint _e640 = local_73;
    local_74 = static_cast<uint>(_e640);
    local_75 = static_cast<uint>(22);
    uint _e646 = local_74;
    uint _e647 = local_75;
    local_122 = static_cast<uint>(_e646 + _e647);
    uint _e651 = local_122;
    out[_e651] = _e637;
    Number = 4;
    int _e657 = Number;
    cached.inner[0] = _e657;
    int _e659 = Number;
    cached.inner[1] = as_type<int>(as_type<uint>(_e659) + as_type<uint>(1));
    int _e664 = cached.inner[1];
    uint _e665 = local;
    local_76 = _e665;
    uint _e667 = local_76;
    local_77 = static_cast<uint>(_e667);
    local_78 = static_cast<uint>(23);
    uint _e673 = local_77;
    uint _e674 = local_78;
    local_123 = static_cast<uint>(_e673 + _e674);
    uint _e678 = local_123;
    out[_e678] = _e664;
    frozen.inner[0] = 3;
    local_79 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e690 = local_79;
            local_79 = _e690 + 1u;
        }
        loop_init_5 = false;
        uint _e685 = local_79;
        if (_e685 >= 3u) {
            break;
        }
        frozen.inner[_e685] = int {};
    }
    int _e697 = frozen.inner[0];
    int _e698 = frozen.inner[1];
    int _e702 = frozen.inner[2];
    uint _e704 = local;
    local_80 = _e704;
    uint _e706 = local_80;
    local_81 = static_cast<uint>(_e706);
    local_82 = static_cast<uint>(24);
    uint _e712 = local_81;
    uint _e713 = local_82;
    local_124 = static_cast<uint>(_e712 + _e713);
    uint _e717 = local_124;
    out[_e717] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e697) + as_type<uint>(_e698))) + as_type<uint>(_e702));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = float {};
    float _e728 = floating.y;
    uint _e730 = local;
    local_83 = _e730;
    uint _e732 = local_83;
    local_84 = static_cast<uint>(_e732);
    local_85 = static_cast<uint>(25);
    uint _e738 = local_84;
    uint _e739 = local_85;
    local_125 = static_cast<uint>(_e738 + _e739);
    uint _e743 = local_125;
    out[_e743] = as_type<int>(_e728);
    float _e746 = floating.z;
    uint _e748 = local;
    local_86 = _e748;
    uint _e750 = local_86;
    local_87 = static_cast<uint>(_e750);
    local_88 = static_cast<uint>(26);
    uint _e756 = local_87;
    uint _e757 = local_88;
    local_126 = static_cast<uint>(_e756 + _e757);
    uint _e761 = local_126;
    out[_e761] = as_type<int>(_e746);
    int3_ _e764 = make_list(6);
    from_call = _e764;
    int _e768 = from_call.x;
    int _e769 = from_call.z;
    uint _e771 = local;
    local_89 = _e771;
    uint _e773 = local_89;
    local_90 = static_cast<uint>(_e773);
    local_91 = static_cast<uint>(27);
    uint _e779 = local_90;
    uint _e780 = local_91;
    local_127 = static_cast<uint>(_e779 + _e780);
    uint _e784 = local_127;
    out[_e784] = as_type<int>(as_type<uint>(_e768) + as_type<uint>(_e769));
    uint _e790 = local;
    local_92 = _e790;
    uint _e792 = local_92;
    local_93 = static_cast<uint>(_e792);
    local_94 = static_cast<uint>(28);
    uint _e798 = local_93;
    uint _e799 = local_94;
    local_128 = static_cast<uint>(_e798 + _e799);
    uint _e803 = local_128;
    out[_e803] = naga_f2i32(Scale * 10.0);
    int _e805 = seed;
    int _e808 = list_sum(as_type<int>(as_type<uint>(_e805) + as_type<uint>(3)));
    uint _e809 = local;
    local_95 = _e809;
    uint _e811 = local_95;
    local_96 = static_cast<uint>(_e811);
    local_97 = static_cast<uint>(29);
    uint _e817 = local_96;
    uint _e818 = local_97;
    local_129 = static_cast<uint>(_e817 + _e818);
    uint _e822 = local_129;
    out[_e822] = _e808;
}
