struct int3_ {
    int x;
    int y;
    int z;
};

struct float3_ {
    float x;
    float y;
    float z;
};

static const int Global = int(2);
static const float Scale = 0.5;

RWByteAddressBuffer out_ : register(u0);

int pair(int first, int second)
{
    int first_1 = (int)0;
    int second_1 = (int)0;

    first_1 = first;
    second_1 = second;
    int _e5 = first_1;
    int _e7 = second_1;
    return asint(asuint(asint(asuint(_e5) * asuint(int(10)))) + asuint(_e7));
}

int ZeroValueint() {
    return (int)0;
}

int list_sum(int seed_1)
{
    int seed_2 = (int)0;
    int values_1[3] = (int[3])0;
    uint local_130 = (uint)0;

    seed_2 = seed_1;
    int _e4 = seed_2;
    values_1[0] = _e4;
    int _e7 = seed_2;
    values_1[1] = asint(asuint(_e7) + asuint(int(1)));
    local_130 = 2u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e16 = local_130;
            local_130 = (_e16 + 1u);
        }
        loop_init = false;
        uint _e12 = local_130;
        if ((_e12 >= 3u)) {
            break;
        }
        values_1[min(uint(_e12), 2u)] = ZeroValueint();
    }
    int _e23 = values_1[int(0)];
    int _e24 = values_1[int(1)];
    int _e28 = values_1[int(2)];
    return asint(asuint(asint(asuint(_e23) + asuint(_e24))) + asuint(_e28));
}

int3_ make_list(int seed_3)
{
    int seed_4 = (int)0;
    int3_ value = (int3_)0;

    seed_4 = seed_3;
    int _e3 = seed_4;
    value.x = _e3;
    int _e6 = seed_4;
    value.y = asint(asuint(_e6) + asuint(int(1)));
    int _e10 = seed_4;
    value.z = asint(asuint(_e10) + asuint(int(2)));
    int3_ _e13 = value;
    const int3_ int3_1 = _e13;
    return int3_1;
}

float ZeroValuefloat() {
    return (float)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void list_initialization()
{
    uint local = (uint)0;
    int seed = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int zero = (int)0;
    int copy_zero = (int)0;
    bool enabled = (bool)0;
    uint count = (uint)0;
    float sample_ = (float)0;
    int Local = (int)0;
    int Safe = (int)0;
    int local_4 = (int)0;
    int safe_values[3] = (int[3])0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    int values[3] = (int[3])0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    int changed[3] = (int[3])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    int3_ point_ = (int3_)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    int3_ changed_point = (int3_)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    int3_ nested[2] = (int3_[2])0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    int2 flat[2] = (int2[2])0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    int3_ original = (int3_)0;
    int3_ copied = (int3_)0;
    int3_ copies[2] = (int3_[2])0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    int counter = (int)0;
    int ordered[3] = (int[3])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    int called = (int)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    int zero_total = (int)0;
    int iteration = (int)0;
    int reset[3] = (int[3])0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    int total = (int)0;
    int iteration_1 = (int)0;
    int limit = (int)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    int Number = (int)0;
    int cached[2] = (int[2])0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    int frozen[3] = (int[3])0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    float3_ floating = (float3_)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    int3_ from_call = (int3_)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    int local_99 = (int)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;

    local = 0u;
    uint _e2 = local;
    local_1 = _e2;
    uint _e4 = local_1;
    local_2 = uint(_e4);
    local_3 = uint(int(0));
    uint _e11 = local_2;
    uint _e12 = local_3;
    local_98 = uint((_e11 + _e12));
    uint _e17 = local_98;
    int _e19 = asint(out_.Load(_e17*4));
    local_99 = _e19;
    int _e20 = local_99;
    seed = _e20;
    zero = int(0);
    copy_zero = int(0);
    enabled = true;
    count = uint(int(7));
    sample_ = 1.5;
    Local = int(3);
    Safe = int(3);
    safe_values[0] = int(1);
    local_5 = 1u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e47 = local_5;
            local_5 = (_e47 + 1u);
        }
        loop_init_1 = false;
        uint _e42 = local_5;
        if ((_e42 >= 3u)) {
            break;
        }
        safe_values[min(uint(_e42), 2u)] = ZeroValueint();
    }
    int _e50 = zero;
    uint _e51 = local;
    local_6 = _e51;
    uint _e53 = local_6;
    local_7 = uint(_e53);
    local_8 = uint(int(0));
    uint _e59 = local_7;
    uint _e60 = local_8;
    local_100 = uint((_e59 + _e60));
    uint _e64 = local_100;
    out_.Store(_e64*4, asuint(_e50));
    int _e66 = copy_zero;
    uint _e67 = local;
    local_9 = _e67;
    uint _e69 = local_9;
    local_10 = uint(_e69);
    local_11 = uint(int(1));
    uint _e75 = local_10;
    uint _e76 = local_11;
    local_101 = uint((_e75 + _e76));
    uint _e80 = local_101;
    out_.Store(_e80*4, asuint(_e66));
    bool _e82 = enabled;
    uint _e84 = local;
    local_12 = _e84;
    uint _e86 = local_12;
    local_13 = uint(_e86);
    local_14 = uint(int(2));
    uint _e92 = local_13;
    uint _e93 = local_14;
    local_102 = uint((_e92 + _e93));
    uint _e97 = local_102;
    out_.Store(_e97*4, asuint(int(_e82)));
    uint _e99 = count;
    uint _e101 = local;
    local_15 = _e101;
    uint _e103 = local_15;
    local_16 = uint(_e103);
    local_17 = uint(int(3));
    uint _e109 = local_16;
    uint _e110 = local_17;
    local_103 = uint((_e109 + _e110));
    uint _e114 = local_103;
    out_.Store(_e114*4, asuint(int(_e99)));
    float _e116 = sample_;
    uint _e120 = local;
    local_18 = _e120;
    uint _e122 = local_18;
    local_19 = uint(_e122);
    local_20 = uint(int(4));
    uint _e128 = local_19;
    uint _e129 = local_20;
    local_104 = uint((_e128 + _e129));
    uint _e133 = local_104;
    out_.Store(_e133*4, asuint(naga_f2i32((_e116 * 2.0))));
    int _e135 = Local;
    uint _e138 = local;
    local_21 = _e138;
    uint _e140 = local_21;
    local_22 = uint(_e140);
    local_23 = uint(int(5));
    uint _e146 = local_22;
    uint _e147 = local_23;
    local_105 = uint((_e146 + _e147));
    uint _e151 = local_105;
    out_.Store(_e151*4, asuint(asint(asuint(Global) + asuint(_e135))));
    int _e155 = safe_values[int(2)];
    uint _e156 = local;
    local_24 = _e156;
    uint _e158 = local_24;
    local_25 = uint(_e158);
    local_26 = uint(int(6));
    uint _e164 = local_25;
    uint _e165 = local_26;
    local_106 = uint((_e164 + _e165));
    uint _e169 = local_106;
    out_.Store(_e169*4, asuint(_e155));
    values[0] = int(1);
    int _e177 = values[int(0)];
    values[1] = asint(asuint(_e177) + asuint(int(1)));
    int _e183 = values[int(1)];
    values[2] = asint(asuint(_e183) + asuint(int(1)));
    int _e190 = values[int(0)];
    int _e191 = values[int(1)];
    int _e195 = values[int(2)];
    uint _e197 = local;
    local_27 = _e197;
    uint _e199 = local_27;
    local_28 = uint(_e199);
    local_29 = uint(int(7));
    uint _e205 = local_28;
    uint _e206 = local_29;
    local_107 = uint((_e205 + _e206));
    uint _e210 = local_107;
    out_.Store(_e210*4, asuint(asint(asuint(asint(asuint(_e190) + asuint(_e191))) + asuint(_e195))));
    changed[0] = int(1);
    changed[int(0)] = int(7);
    changed[1] = int(2);
    int _e223 = changed[int(0)];
    changed[2] = _e223;
    int _e226 = changed[int(0)];
    uint _e227 = local;
    local_30 = _e227;
    uint _e229 = local_30;
    local_31 = uint(_e229);
    local_32 = uint(int(8));
    uint _e235 = local_31;
    uint _e236 = local_32;
    local_108 = uint((_e235 + _e236));
    uint _e240 = local_108;
    out_.Store(_e240*4, asuint(_e226));
    int _e244 = changed[int(2)];
    uint _e245 = local;
    local_33 = _e245;
    uint _e247 = local_33;
    local_34 = uint(_e247);
    local_35 = uint(int(9));
    uint _e253 = local_34;
    uint _e254 = local_35;
    local_109 = uint((_e253 + _e254));
    uint _e258 = local_109;
    out_.Store(_e258*4, asuint(_e244));
    point_.x = int(1);
    int _e264 = point_.x;
    point_.y = asint(asuint(_e264) + asuint(int(1)));
    int _e269 = point_.y;
    point_.z = asint(asuint(_e269) + asuint(int(1)));
    int _e274 = point_.z;
    uint _e275 = local;
    local_36 = _e275;
    uint _e277 = local_36;
    local_37 = uint(_e277);
    local_38 = uint(int(10));
    uint _e283 = local_37;
    uint _e284 = local_38;
    local_110 = uint((_e283 + _e284));
    uint _e288 = local_110;
    out_.Store(_e288*4, asuint(_e274));
    changed_point.x = int(1);
    changed_point.x = int(9);
    changed_point.y = int(2);
    int _e298 = changed_point.x;
    changed_point.z = _e298;
    int _e301 = changed_point.x;
    uint _e302 = local;
    local_39 = _e302;
    uint _e304 = local_39;
    local_40 = uint(_e304);
    local_41 = uint(int(11));
    uint _e310 = local_40;
    uint _e311 = local_41;
    local_111 = uint((_e310 + _e311));
    uint _e315 = local_111;
    out_.Store(_e315*4, asuint(_e301));
    int _e318 = changed_point.z;
    uint _e319 = local;
    local_42 = _e319;
    uint _e321 = local_42;
    local_43 = uint(_e321);
    local_44 = uint(int(12));
    uint _e327 = local_43;
    uint _e328 = local_44;
    local_112 = uint((_e327 + _e328));
    uint _e332 = local_112;
    out_.Store(_e332*4, asuint(_e318));
    nested[0].x = int(1);
    nested[0].y = int(2);
    nested[0].z = ZeroValueint();
    nested[1].x = int(3);
    nested[1].y = ZeroValueint();
    nested[1].z = ZeroValueint();
    int _e355 = nested[int(0)].z;
    int _e356 = nested[int(1)].x;
    uint _e358 = local;
    local_45 = _e358;
    uint _e360 = local_45;
    local_46 = uint(_e360);
    local_47 = uint(int(13));
    uint _e366 = local_46;
    uint _e367 = local_47;
    local_113 = uint((_e366 + _e367));
    uint _e371 = local_113;
    out_.Store(_e371*4, asuint(asint(asuint(_e355) + asuint(_e356))));
    flat[0].x = int(1);
    flat[0].y = int(2);
    flat[1].x = int(3);
    flat[1].y = ZeroValueint();
    int _e390 = flat[int(0)].x;
    int _e391 = flat[int(0)].y;
    int _e396 = flat[int(1)].x;
    int _e401 = flat[int(1)].y;
    uint _e403 = local;
    local_48 = _e403;
    uint _e405 = local_48;
    local_49 = uint(_e405);
    local_50 = uint(int(14));
    uint _e411 = local_49;
    uint _e412 = local_50;
    local_114 = uint((_e411 + _e412));
    uint _e416 = local_114;
    out_.Store(_e416*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e390) + asuint(_e391))) + asuint(_e396))) + asuint(_e401))));
    original.x = int(2);
    original.y = int(3);
    original.z = int(4);
    int3_ _e425 = original;
    copied = _e425;
    int3_ _e429 = original;
    copies[0] = _e429;
    copies[1].x = int(5);
    copies[1].y = int(6);
    copies[1].z = ZeroValueint();
    original.x = int(99);
    int _e440 = copied.x;
    uint _e441 = local;
    local_51 = _e441;
    uint _e443 = local_51;
    local_52 = uint(_e443);
    local_53 = uint(int(15));
    uint _e449 = local_52;
    uint _e450 = local_53;
    local_115 = uint((_e449 + _e450));
    uint _e454 = local_115;
    out_.Store(_e454*4, asuint(_e440));
    int _e459 = copies[int(0)].x;
    uint _e460 = local;
    local_54 = _e460;
    uint _e462 = local_54;
    local_55 = uint(_e462);
    local_56 = uint(int(16));
    uint _e468 = local_55;
    uint _e469 = local_56;
    local_116 = uint((_e468 + _e469));
    uint _e473 = local_116;
    out_.Store(_e473*4, asuint(_e459));
    int _e478 = copies[int(1)].z;
    uint _e479 = local;
    local_57 = _e479;
    uint _e481 = local_57;
    local_58 = uint(_e481);
    local_59 = uint(int(17));
    uint _e487 = local_58;
    uint _e488 = local_59;
    local_117 = uint((_e487 + _e488));
    uint _e492 = local_117;
    out_.Store(_e492*4, asuint(_e478));
    int _e494 = seed;
    counter = _e494;
    int _e498 = counter;
    counter = asint(asuint(_e498) + asuint(int(1)));
    ordered[0] = _e498;
    int _e502 = counter;
    counter = asint(asuint(_e502) + asuint(int(1)));
    ordered[1] = _e502;
    int _e506 = counter;
    ordered[2] = _e506;
    int _e509 = ordered[int(0)];
    int _e514 = ordered[int(1)];
    int _e520 = ordered[int(2)];
    uint _e522 = local;
    local_60 = _e522;
    uint _e524 = local_60;
    local_61 = uint(_e524);
    local_62 = uint(int(18));
    uint _e530 = local_61;
    uint _e531 = local_62;
    local_118 = uint((_e530 + _e531));
    uint _e535 = local_118;
    out_.Store(_e535*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e509) * asuint(int(100)))) + asuint(asint(asuint(_e514) * asuint(int(10)))))) + asuint(_e520))));
    int _e537 = counter;
    uint _e538 = local;
    local_63 = _e538;
    uint _e540 = local_63;
    local_64 = uint(_e540);
    local_65 = uint(int(19));
    uint _e546 = local_64;
    uint _e547 = local_65;
    local_119 = uint((_e546 + _e547));
    uint _e551 = local_119;
    out_.Store(_e551*4, asuint(_e537));
    int _e553 = counter;
    counter = asint(asuint(_e553) + asuint(int(1)));
    const int _e557 = pair(_e553, int(4));
    called = _e557;
    int _e559 = called;
    uint _e560 = local;
    local_66 = _e560;
    uint _e562 = local_66;
    local_67 = uint(_e562);
    local_68 = uint(int(20));
    uint _e568 = local_67;
    uint _e569 = local_68;
    local_120 = uint((_e568 + _e569));
    uint _e573 = local_120;
    out_.Store(_e573*4, asuint(_e559));
    zero_total = int(0);
    {
        iteration = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e603 = iteration;
                iteration = asint(asuint(_e603) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e579 = iteration;
            if ((_e579 < int(3))) {
            } else {
                break;
            }
            int _e584 = iteration;
            reset[0] = _e584;
            local_69 = 1u;
            uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
            bool loop_init_3 = true;
            while(true) {
                if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
                loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
                if (!loop_init_3) {
                    uint _e592 = local_69;
                    local_69 = (_e592 + 1u);
                }
                loop_init_3 = false;
                uint _e587 = local_69;
                if ((_e587 >= 3u)) {
                    break;
                }
                reset[min(uint(_e587), 2u)] = ZeroValueint();
            }
            int _e597 = reset[int(2)];
            int _e598 = zero_total;
            zero_total = asint(asuint(_e598) + asuint(_e597));
            reset[int(2)] = int(9);
        }
    }
    int _e606 = zero_total;
    uint _e607 = local;
    local_70 = _e607;
    uint _e609 = local_70;
    local_71 = uint(_e609);
    local_72 = uint(int(21));
    uint _e615 = local_71;
    uint _e616 = local_72;
    local_121 = uint((_e615 + _e616));
    uint _e620 = local_121;
    out_.Store(_e620*4, asuint(_e606));
    total = int(0);
    {
        iteration_1 = int(0);
        limit = int(3);
        uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                int _e634 = iteration_1;
                iteration_1 = asint(asuint(_e634) + asuint(int(1)));
            }
            loop_init_4 = false;
            int _e628 = iteration_1;
            int _e629 = limit;
            if ((_e628 < _e629)) {
            } else {
                break;
            }
            int _e631 = iteration_1;
            int _e632 = total;
            total = asint(asuint(_e632) + asuint(_e631));
        }
    }
    int _e637 = total;
    uint _e638 = local;
    local_73 = _e638;
    uint _e640 = local_73;
    local_74 = uint(_e640);
    local_75 = uint(int(22));
    uint _e646 = local_74;
    uint _e647 = local_75;
    local_122 = uint((_e646 + _e647));
    uint _e651 = local_122;
    out_.Store(_e651*4, asuint(_e637));
    Number = int(4);
    int _e657 = Number;
    cached[0] = _e657;
    int _e659 = Number;
    cached[1] = asint(asuint(_e659) + asuint(int(1)));
    int _e664 = cached[int(1)];
    uint _e665 = local;
    local_76 = _e665;
    uint _e667 = local_76;
    local_77 = uint(_e667);
    local_78 = uint(int(23));
    uint _e673 = local_77;
    uint _e674 = local_78;
    local_123 = uint((_e673 + _e674));
    uint _e678 = local_123;
    out_.Store(_e678*4, asuint(_e664));
    frozen[0] = int(3);
    local_79 = 1u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e690 = local_79;
            local_79 = (_e690 + 1u);
        }
        loop_init_5 = false;
        uint _e685 = local_79;
        if ((_e685 >= 3u)) {
            break;
        }
        frozen[min(uint(_e685), 2u)] = ZeroValueint();
    }
    int _e697 = frozen[int(0)];
    int _e698 = frozen[int(1)];
    int _e702 = frozen[int(2)];
    uint _e704 = local;
    local_80 = _e704;
    uint _e706 = local_80;
    local_81 = uint(_e706);
    local_82 = uint(int(24));
    uint _e712 = local_81;
    uint _e713 = local_82;
    local_124 = uint((_e712 + _e713));
    uint _e717 = local_124;
    out_.Store(_e717*4, asuint(asint(asuint(asint(asuint(_e697) + asuint(_e698))) + asuint(_e702))));
    floating.x = 1.5;
    floating.y = -(0.0);
    floating.z = ZeroValuefloat();
    float _e728 = floating.y;
    uint _e730 = local;
    local_83 = _e730;
    uint _e732 = local_83;
    local_84 = uint(_e732);
    local_85 = uint(int(25));
    uint _e738 = local_84;
    uint _e739 = local_85;
    local_125 = uint((_e738 + _e739));
    uint _e743 = local_125;
    out_.Store(_e743*4, asuint(asint(_e728)));
    float _e746 = floating.z;
    uint _e748 = local;
    local_86 = _e748;
    uint _e750 = local_86;
    local_87 = uint(_e750);
    local_88 = uint(int(26));
    uint _e756 = local_87;
    uint _e757 = local_88;
    local_126 = uint((_e756 + _e757));
    uint _e761 = local_126;
    out_.Store(_e761*4, asuint(asint(_e746)));
    const int3_ _e764 = make_list(int(6));
    from_call = _e764;
    int _e768 = from_call.x;
    int _e769 = from_call.z;
    uint _e771 = local;
    local_89 = _e771;
    uint _e773 = local_89;
    local_90 = uint(_e773);
    local_91 = uint(int(27));
    uint _e779 = local_90;
    uint _e780 = local_91;
    local_127 = uint((_e779 + _e780));
    uint _e784 = local_127;
    out_.Store(_e784*4, asuint(asint(asuint(_e768) + asuint(_e769))));
    uint _e790 = local;
    local_92 = _e790;
    uint _e792 = local_92;
    local_93 = uint(_e792);
    local_94 = uint(int(28));
    uint _e798 = local_93;
    uint _e799 = local_94;
    local_128 = uint((_e798 + _e799));
    uint _e803 = local_128;
    out_.Store(_e803*4, asuint(naga_f2i32((Scale * 10.0))));
    int _e805 = seed;
    const int _e808 = list_sum(asint(asuint(_e805) + asuint(int(3))));
    uint _e809 = local;
    local_95 = _e809;
    uint _e811 = local_95;
    local_96 = uint(_e811);
    local_97 = uint(int(29));
    uint _e817 = local_96;
    uint _e818 = local_97;
    local_129 = uint((_e817 + _e818));
    uint _e822 = local_129;
    out_.Store(_e822*4, asuint(_e808));
}
