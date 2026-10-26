struct uint3_ {
    uint x;
    uint y;
    uint z;
};

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

RWByteAddressBuffer out_ : register(u0);

int choose(int2 value)
{
    int2 value_1 = (int2)0;

    value_1 = value;
    int _e4 = value_1.x;
    int _e7 = value_1.y;
    return asint(asuint(asint(asuint(_e4) * asuint(int(10)))) + asuint(_e7));
}

int choose_1(uint3_ value_2)
{
    uint3_ value_3 = (uint3_)0;

    value_3 = value_2;
    uint _e3 = value_3.z;
    return int(_e3);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int choose_2(float4 value_4)
{
    float4 value_5 = (float4)0;

    value_5 = value_4;
    float _e3 = value_5.w;
    return naga_f2i32(_e3);
}

int3_ bump(int3_ value_6)
{
    int3_ value_7 = (int3_)0;

    value_7 = value_6;
    int _e4 = value_7.y;
    value_7.y = asint(asuint(_e4) + asuint(int(1)));
    int3_ _e6 = value_7;
    const int3_ int3_1 = _e6;
    return int3_1;
}

float3_ shift(float3_ value_8)
{
    float3_ value_9 = (float3_)0;

    value_9 = value_8;
    float _e4 = value_9.x;
    value_9.x = (_e4 + 2.0);
    float _e9 = value_9.x;
    float _e10 = value_9.y;
    value_9.z = (_e9 + _e10);
    float3_ _e12 = value_9;
    const float3_ float3_1 = _e12;
    return float3_1;
}

int pair(float3_ first, int second)
{
    float3_ first_1 = (float3_)0;
    int second_1 = (int)0;

    first_1 = first;
    second_1 = second;
    float _e5 = first_1.x;
    int _e9 = second_1;
    return asint(asuint(asint(asuint(naga_f2i32(_e5)) * asuint(int(10)))) + asuint(_e9));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

int3_ Constructint3_(int arg0, int arg1, int arg2) {
    int3_ ret = (int3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint3_ Constructuint3_(uint arg0, uint arg1, uint arg2) {
    uint3_ ret = (uint3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(1, 1, 1)]
void vector_values()
{
    uint local = (uint)0;
    int seed = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    float2 f2_ = (float2)0;
    float3_ f3_ = (float3_)0;
    float4 f4_ = (float4)0;
    int2 i2_ = (int2)0;
    int3_ i3_ = (int3_)0;
    int4 i4_ = (int4)0;
    uint2 u2_ = (uint2)0;
    uint3_ u3_ = (uint3_)0;
    uint4 u4_ = (uint4)0;
    uint local_4 = (uint)0;
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
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    float3_ frozen = (float3_)0;
    float3_ copied = (float3_)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    int3_ changed = (int3_)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    float3_ samples[2] = (float3_[2])0;
    int index = (int)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    bool choose_first = (bool)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    float local_52 = (float)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    float local_59 = (float)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    float3_ local_63 = (float3_)0;
    int local_64 = (int)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    int argument = (int)0;
    int3_ captured = (int3_)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    int local_81 = (int)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
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
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;

    local = 0u;
    uint _e2 = local;
    local_1 = _e2;
    uint _e4 = local_1;
    local_2 = uint(_e4);
    local_3 = uint(int(0));
    uint _e11 = local_2;
    uint _e12 = local_3;
    local_80 = uint((_e11 + _e12));
    uint _e17 = local_80;
    int _e19 = asint(out_.Load(_e17*4));
    local_81 = _e19;
    int _e20 = local_81;
    seed = _e20;
    int _e22 = seed;
    f2_ = float2(float(_e22), 1.5);
    f3_ = Constructfloat3_(1.0, 2.0, 3.0);
    f4_ = float4(float(int(1)), float(int(2)), float(int(3)), float(int(4)));
    int _e42 = seed;
    i2_ = int2(_e42, naga_neg(int(2)));
    i3_ = Constructint3_(int(1), int(2), int(3));
    i4_ = int4(int(1), int(2), int(3), int(4));
    u2_ = uint2(uint(naga_neg(int(1))), uint(int(2)));
    u3_ = Constructuint3_(uint(int(1)), uint(int(2)), uint(int(3)));
    u4_ = uint4(uint(int(1)), uint(int(2)), uint(int(3)), uint(int(4)));
    float _e85 = f2_.x;
    float _e86 = f2_.y;
    uint _e89 = local;
    local_4 = _e89;
    uint _e91 = local_4;
    local_5 = uint(_e91);
    local_6 = uint(int(0));
    uint _e97 = local_5;
    uint _e98 = local_6;
    local_82 = uint((_e97 + _e98));
    uint _e102 = local_82;
    out_.Store(_e102*4, asuint(naga_f2i32((_e85 + _e86))));
    float _e106 = f3_.x;
    float _e107 = f3_.y;
    float _e110 = f3_.z;
    uint _e113 = local;
    local_7 = _e113;
    uint _e115 = local_7;
    local_8 = uint(_e115);
    local_9 = uint(int(1));
    uint _e121 = local_8;
    uint _e122 = local_9;
    local_83 = uint((_e121 + _e122));
    uint _e126 = local_83;
    out_.Store(_e126*4, asuint(naga_f2i32(((_e106 + _e107) + _e110))));
    float _e129 = f4_.w;
    uint _e131 = local;
    local_10 = _e131;
    uint _e133 = local_10;
    local_11 = uint(_e133);
    local_12 = uint(int(2));
    uint _e139 = local_11;
    uint _e140 = local_12;
    local_84 = uint((_e139 + _e140));
    uint _e144 = local_84;
    out_.Store(_e144*4, asuint(naga_f2i32(_e129)));
    int _e148 = i2_.x;
    int _e149 = i2_.y;
    uint _e151 = local;
    local_13 = _e151;
    uint _e153 = local_13;
    local_14 = uint(_e153);
    local_15 = uint(int(3));
    uint _e159 = local_14;
    uint _e160 = local_15;
    local_85 = uint((_e159 + _e160));
    uint _e164 = local_85;
    out_.Store(_e164*4, asuint(asint(asuint(_e148) + asuint(_e149))));
    int _e167 = i3_.z;
    uint _e168 = local;
    local_16 = _e168;
    uint _e170 = local_16;
    local_17 = uint(_e170);
    local_18 = uint(int(4));
    uint _e176 = local_17;
    uint _e177 = local_18;
    local_86 = uint((_e176 + _e177));
    uint _e181 = local_86;
    out_.Store(_e181*4, asuint(_e167));
    int _e185 = i4_.x;
    int _e186 = i4_.w;
    uint _e188 = local;
    local_19 = _e188;
    uint _e190 = local_19;
    local_20 = uint(_e190);
    local_21 = uint(int(5));
    uint _e196 = local_20;
    uint _e197 = local_21;
    local_87 = uint((_e196 + _e197));
    uint _e201 = local_87;
    out_.Store(_e201*4, asuint(asint(asuint(_e185) + asuint(_e186))));
    uint _e204 = u2_.x;
    uint _e207 = local;
    local_22 = _e207;
    uint _e209 = local_22;
    local_23 = uint(_e209);
    local_24 = uint(int(6));
    uint _e216 = local_23;
    uint _e217 = local_24;
    local_88 = uint((_e216 + _e217));
    uint _e221 = local_88;
    out_.Store(_e221*4, asuint(int((_e204 == 4294967295u))));
    uint _e225 = u3_.x;
    uint _e226 = u3_.z;
    uint _e229 = local;
    local_25 = _e229;
    uint _e231 = local_25;
    local_26 = uint(_e231);
    local_27 = uint(int(7));
    uint _e237 = local_26;
    uint _e238 = local_27;
    local_89 = uint((_e237 + _e238));
    uint _e242 = local_89;
    out_.Store(_e242*4, asuint(int((_e225 + _e226))));
    uint _e245 = u4_.w;
    uint _e247 = local;
    local_28 = _e247;
    uint _e249 = local_28;
    local_29 = uint(_e249);
    local_30 = uint(int(8));
    uint _e255 = local_29;
    uint _e256 = local_30;
    local_90 = uint((_e255 + _e256));
    uint _e260 = local_90;
    out_.Store(_e260*4, asuint(int(_e245)));
    float3_ _e262 = f3_;
    frozen = _e262;
    float3_ _e264 = frozen;
    copied = _e264;
    copied.x = 9.0;
    float _e269 = frozen.x;
    float _e273 = copied.x;
    uint _e276 = local;
    local_31 = _e276;
    uint _e278 = local_31;
    local_32 = uint(_e278);
    local_33 = uint(int(9));
    uint _e284 = local_32;
    uint _e285 = local_33;
    local_91 = uint((_e284 + _e285));
    uint _e289 = local_91;
    out_.Store(_e289*4, asuint(naga_f2i32(((_e269 * 10.0) + _e273))));
    int3_ _e291 = i3_;
    const int3_ _e292 = bump(_e291);
    changed = _e292;
    int _e295 = changed.y;
    int _e299 = i3_.y;
    uint _e301 = local;
    local_34 = _e301;
    uint _e303 = local_34;
    local_35 = uint(_e303);
    local_36 = uint(int(10));
    uint _e309 = local_35;
    uint _e310 = local_36;
    local_92 = uint((_e309 + _e310));
    uint _e314 = local_92;
    out_.Store(_e314*4, asuint(asint(asuint(asint(asuint(_e295) * asuint(int(10)))) + asuint(_e299))));
    float3_ _e316 = f3_;
    const float3_ _e317 = shift(_e316);
    uint _e320 = local;
    local_37 = _e320;
    uint _e322 = local_37;
    local_38 = uint(_e322);
    local_39 = uint(int(11));
    uint _e328 = local_38;
    uint _e329 = local_39;
    local_93 = uint((_e328 + _e329));
    uint _e333 = local_93;
    out_.Store(_e333*4, asuint(naga_f2i32(_e317.z)));
    int2 _e335 = i2_;
    const int _e336 = choose(_e335);
    uint3_ _e337 = u3_;
    const int _e338 = choose_1(_e337);
    float4 _e340 = f4_;
    const int _e341 = choose_2(_e340);
    uint _e343 = local;
    local_40 = _e343;
    uint _e345 = local_40;
    local_41 = uint(_e345);
    local_42 = uint(int(12));
    uint _e351 = local_41;
    uint _e352 = local_42;
    local_94 = uint((_e351 + _e352));
    uint _e356 = local_94;
    out_.Store(_e356*4, asuint(asint(asuint(asint(asuint(_e336) + asuint(_e338))) + asuint(_e341))));
    float3_ _e358 = f3_;
    samples[int(0)] = _e358;
    samples[int(1)] = Constructfloat3_(float(int(5)), float(int(6)), float(int(7)));
    index = int(0);
    int _e373 = index;
    index = asint(asuint(_e373) + asuint(int(1)));
    int _e376 = index;
    int _e377 = index;
    index = asint(asuint(_e377) + asuint(int(1)));
    float _e382 = samples[min(uint(_e377), 1u)].x;
    samples[min(uint(_e377), 1u)].x = (_e382 + float(_e376));
    float _e385 = samples[min(uint(_e377), 1u)].x;
    uint _e387 = local;
    local_43 = _e387;
    uint _e389 = local_43;
    local_44 = uint(_e389);
    local_45 = uint(int(13));
    uint _e395 = local_44;
    uint _e396 = local_45;
    local_95 = uint((_e395 + _e396));
    uint _e400 = local_95;
    out_.Store(_e400*4, asuint(naga_f2i32(_e385)));
    int _e402 = index;
    float _e408 = samples[int(0)].x;
    float _e416 = samples[int(1)].x;
    uint _e419 = local;
    local_46 = _e419;
    uint _e421 = local_46;
    local_47 = uint(_e421);
    local_48 = uint(int(14));
    uint _e427 = local_47;
    uint _e428 = local_48;
    local_96 = uint((_e427 + _e428));
    uint _e432 = local_96;
    out_.Store(_e432*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e402) * asuint(int(100)))) + asuint(asint(asuint(naga_f2i32(_e408)) * asuint(int(10)))))) + asuint(naga_f2i32(_e416)))));
    choose_first = false;
    bool _e436 = choose_first;
    if (_e436) {
        float _e440 = samples[int(0)].y;
        samples[int(0)].y = (_e440 + float(int(1)));
        local_52 = _e440;
    } else {
        float _e448 = samples[int(1)].y;
        samples[int(1)].y = (_e448 + float(int(1)));
        local_52 = _e448;
    }
    float _e454 = local_52;
    uint _e456 = local;
    local_49 = _e456;
    uint _e458 = local_49;
    local_50 = uint(_e458);
    local_51 = uint(int(15));
    uint _e464 = local_50;
    uint _e465 = local_51;
    local_97 = uint((_e464 + _e465));
    uint _e469 = local_97;
    out_.Store(_e469*4, asuint(naga_f2i32(_e454)));
    float _e474 = samples[int(1)].y;
    uint _e476 = local;
    local_53 = _e476;
    uint _e478 = local_53;
    local_54 = uint(_e478);
    local_55 = uint(int(16));
    uint _e484 = local_54;
    uint _e485 = local_55;
    local_98 = uint((_e484 + _e485));
    uint _e489 = local_98;
    out_.Store(_e489*4, asuint(naga_f2i32(_e474)));
    float3_ _e491 = f3_;
    bool _e492 = choose_first;
    if (_e492) {
        samples[int(0)] = _e491;
        float _e496 = samples[int(0)].z;
        local_59 = _e496;
    } else {
        samples[int(1)] = _e491;
        float _e501 = samples[int(1)].z;
        local_59 = _e501;
    }
    float _e504 = local_59;
    uint _e506 = local;
    local_56 = _e506;
    uint _e508 = local_56;
    local_57 = uint(_e508);
    local_58 = uint(int(17));
    uint _e514 = local_57;
    uint _e515 = local_58;
    local_99 = uint((_e514 + _e515));
    uint _e519 = local_99;
    out_.Store(_e519*4, asuint(naga_f2i32(_e504)));
    if (true) {
        local_63 = Constructfloat3_(float(int(7)), float(int(8)), float(int(9)));
    } else {
        float3_ _e530 = f3_;
        local_63 = _e530;
    }
    float3_ _e533 = local_63;
    uint _e536 = local;
    local_60 = _e536;
    uint _e538 = local_60;
    local_61 = uint(_e538);
    local_62 = uint(int(18));
    uint _e544 = local_61;
    uint _e545 = local_62;
    local_100 = uint((_e544 + _e545));
    uint _e549 = local_100;
    out_.Store(_e549*4, asuint(naga_f2i32(_e533.y)));
    {
        int _e551 = seed;
        local_64 = asint(asuint(_e551) + asuint(int(2)));
        int _e555 = local_64;
        uint _e556 = local;
        local_65 = _e556;
        uint _e558 = local_65;
        local_66 = uint(_e558);
        local_67 = uint(int(19));
        uint _e564 = local_66;
        uint _e565 = local_67;
        local_101 = uint((_e564 + _e565));
        uint _e569 = local_101;
        out_.Store(_e569*4, asuint(_e555));
    }
    argument = int(3);
    int _e573 = argument;
    int _e574 = argument;
    argument = asint(asuint(_e574) + asuint(int(1)));
    int _e577 = argument;
    captured = Constructint3_(_e573, _e574, _e577);
    int _e581 = captured.x;
    int _e585 = captured.y;
    int _e590 = captured.z;
    uint _e592 = local;
    local_68 = _e592;
    uint _e594 = local_68;
    local_69 = uint(_e594);
    local_70 = uint(int(20));
    uint _e600 = local_69;
    uint _e601 = local_70;
    local_102 = uint((_e600 + _e601));
    uint _e605 = local_102;
    out_.Store(_e605*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e581) * asuint(int(100)))) + asuint(asint(asuint(_e585) * asuint(int(10)))))) + asuint(_e590))));
    int _e607 = argument;
    uint _e608 = local;
    local_71 = _e608;
    uint _e610 = local_71;
    local_72 = uint(_e610);
    local_73 = uint(int(21));
    uint _e616 = local_72;
    uint _e617 = local_73;
    local_103 = uint((_e616 + _e617));
    uint _e621 = local_103;
    out_.Store(_e621*4, asuint(_e607));
    float3_ _e623 = f3_;
    f3_.x = 9.0;
    const int _e627 = pair(_e623, int(4));
    uint _e628 = local;
    local_74 = _e628;
    uint _e630 = local_74;
    local_75 = uint(_e630);
    local_76 = uint(int(22));
    uint _e636 = local_75;
    uint _e637 = local_76;
    local_104 = uint((_e636 + _e637));
    uint _e641 = local_104;
    out_.Store(_e641*4, asuint(_e627));
    float _e644 = f3_.x;
    uint _e646 = local;
    local_77 = _e646;
    uint _e648 = local_77;
    local_78 = uint(_e648);
    local_79 = uint(int(23));
    uint _e654 = local_78;
    uint _e655 = local_79;
    local_105 = uint((_e654 + _e655));
    uint _e659 = local_105;
    out_.Store(_e659*4, asuint(naga_f2i32(_e644)));
}
