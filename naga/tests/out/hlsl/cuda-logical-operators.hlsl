struct Sample_cuda_record_0_ {
    int value;
    int payload_[2];
};

RWByteAddressBuffer out_ : register(u0);

Sample_cuda_record_0_ operator_u0026_u0026_(Sample_cuda_record_0_ left_1, Sample_cuda_record_0_ right_1)
{
    Sample_cuda_record_0_ left_2 = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ right_2 = (Sample_cuda_record_0_)0;

    left_2 = left_1;
    right_2 = right_1;
    int _e7 = left_2.value;
    int _e10 = right_2.value;
    left_2.value = asint(asuint(asint(asuint(_e7) * asuint(int(10)))) + asuint(_e10));
    int _e18 = right_2.payload_[int(0)];
    int _e19 = left_2.payload_[int(1)];
    left_2.payload_[int(1)] = asint(asuint(_e19) + asuint(_e18));
    Sample_cuda_record_0_ _e21 = left_2;
    const Sample_cuda_record_0_ sample_cuda_record_0_ = _e21;
    return sample_cuda_record_0_;
}

Sample_cuda_record_0_ operator_u007c_u007c(Sample_cuda_record_0_ left_3, Sample_cuda_record_0_ right_3)
{
    Sample_cuda_record_0_ left_4 = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ right_4 = (Sample_cuda_record_0_)0;

    left_4 = left_3;
    right_4 = right_3;
    int _e7 = left_4.value;
    int _e10 = right_4.value;
    left_4.value = asint(asuint(asint(asuint(_e7) * asuint(int(100)))) + asuint(_e10));
    int _e18 = right_4.payload_[int(1)];
    int _e19 = left_4.payload_[int(0)];
    left_4.payload_[int(0)] = asint(asuint(_e19) + asuint(_e18));
    Sample_cuda_record_0_ _e21 = left_4;
    const Sample_cuda_record_0_ sample_cuda_record_0_1 = _e21;
    return sample_cuda_record_0_1;
}

int operator_u0026_u0026_1(Sample_cuda_record_0_ left_5, int right_5)
{
    Sample_cuda_record_0_ left_6 = (Sample_cuda_record_0_)0;

    left_6 = left_5;
    int _e4 = left_6.value;
    return asint(asuint(asint(asuint(_e4) * asuint(int(10)))) + asuint(right_5));
}

int operator_u007c_u007c_1(int left_7, Sample_cuda_record_0_ right_6)
{
    Sample_cuda_record_0_ right_7 = (Sample_cuda_record_0_)0;

    right_7 = right_6;
    int _e6 = right_7.value;
    return asint(asuint(asint(asuint(left_7) * asuint(int(100)))) + asuint(_e6));
}

int2 operator_u0026_u0026_2(int2 left_8, int2 right_8)
{
    int2 left_9 = (int2)0;
    int2 right_9 = (int2)0;

    left_9 = left_8;
    right_9 = right_8;
    int _e6 = left_9.x;
    int _e9 = right_9.x;
    int _e13 = left_9.y;
    int _e16 = right_9.y;
    return int2(asint(asuint(asint(asuint(_e6) * asuint(int(10)))) + asuint(_e9)), asint(asuint(asint(asuint(_e13) * asuint(int(10)))) + asuint(_e16)));
}

int2 operator_u007c_u007c_2(int2 left_10, int2 right_10)
{
    int2 left_11 = (int2)0;
    int2 right_11 = (int2)0;

    left_11 = left_10;
    right_11 = right_10;
    int _e6 = left_11.x;
    int _e9 = right_11.x;
    int _e13 = left_11.y;
    int _e16 = right_11.y;
    return int2(asint(asuint(asint(asuint(_e6) * asuint(int(100)))) + asuint(_e9)), asint(asuint(asint(asuint(_e13) * asuint(int(100)))) + asuint(_e16)));
}

[numthreads(2, 1, 1)]
void logical_operators(uint3 threadIdx : SV_GroupThreadID)
{
    Sample_cuda_record_0_ left = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ right = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ both = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ either = (Sample_cuda_record_0_)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int2 first = (int2)0;
    int2 second = (int2)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    Sample_cuda_record_0_ local_16 = (Sample_cuda_record_0_)0;
    uint local_17 = (uint)0;
    Sample_cuda_record_0_ local_18 = (Sample_cuda_record_0_)0;
    int counter = (int)0;
    Sample_cuda_record_0_ evaluated = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ local_19 = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ local_20 = (Sample_cuda_record_0_)0;
    Sample_cuda_record_0_ local_21 = (Sample_cuda_record_0_)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    bool local_25 = (bool)0;
    uint local_26 = (uint)0;
    bool local_27 = (bool)0;
    uint local_28 = (uint)0;
    bool local_29 = (bool)0;
    uint local_30 = (uint)0;
    bool local_31 = (bool)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;

    uint base = (threadIdx.x * 24u);
    left.value = int(2);
    left.payload_[0] = int(3);
    left.payload_[1] = int(4);
    right.value = int(5);
    right.payload_[0] = int(6);
    right.payload_[1] = int(7);
    Sample_cuda_record_0_ _e20 = left;
    Sample_cuda_record_0_ _e21 = right;
    const Sample_cuda_record_0_ _e22 = operator_u0026_u0026_(_e20, _e21);
    both = _e22;
    Sample_cuda_record_0_ _e24 = left;
    Sample_cuda_record_0_ _e25 = right;
    const Sample_cuda_record_0_ _e26 = operator_u007c_u007c(_e24, _e25);
    either = _e26;
    int _e29 = both.value;
    local = uint((base + 0u));
    uint _e35 = local;
    local_33 = uint(_e35);
    uint _e38 = local_33;
    out_.Store(_e38*4, asuint(uint(_e29)));
    int _e44 = both.payload_[int(1)];
    local_1 = uint((base + 1u));
    uint _e50 = local_1;
    local_34 = uint(_e50);
    uint _e53 = local_34;
    out_.Store(_e53*4, asuint(uint(_e44)));
    int _e56 = either.value;
    local_2 = uint((base + 2u));
    uint _e62 = local_2;
    local_35 = uint(_e62);
    uint _e65 = local_35;
    out_.Store(_e65*4, asuint(uint(_e56)));
    int _e70 = either.payload_[int(0)];
    local_3 = uint((base + 3u));
    uint _e76 = local_3;
    local_36 = uint(_e76);
    uint _e79 = local_36;
    out_.Store(_e79*4, asuint(uint(_e70)));
    int _e82 = left.value;
    local_4 = uint((base + 4u));
    uint _e88 = local_4;
    local_37 = uint(_e88);
    uint _e91 = local_37;
    out_.Store(_e91*4, asuint(uint(_e82)));
    int _e96 = left.payload_[int(1)];
    local_5 = uint((base + 5u));
    uint _e102 = local_5;
    local_38 = uint(_e102);
    uint _e105 = local_38;
    out_.Store(_e105*4, asuint(uint(_e96)));
    Sample_cuda_record_0_ _e107 = left;
    const int _e109 = operator_u0026_u0026_1(_e107, int(9));
    local_6 = uint((base + 6u));
    uint _e115 = local_6;
    local_39 = uint(_e115);
    uint _e118 = local_39;
    out_.Store(_e118*4, asuint(uint(_e109)));
    Sample_cuda_record_0_ _e120 = right;
    const int _e122 = operator_u007c_u007c_1(int(0), _e120);
    local_7 = uint((base + 7u));
    uint _e128 = local_7;
    local_40 = uint(_e128);
    uint _e131 = local_40;
    out_.Store(_e131*4, asuint(uint(_e122)));
    Sample_cuda_record_0_ _e133 = left;
    Sample_cuda_record_0_ _e134 = right;
    const Sample_cuda_record_0_ _e135 = operator_u0026_u0026_(_e133, _e134);
    local_8 = uint((base + 8u));
    uint _e142 = local_8;
    local_41 = uint(_e142);
    uint _e145 = local_41;
    out_.Store(_e145*4, asuint(uint(_e135.value)));
    Sample_cuda_record_0_ _e147 = left;
    Sample_cuda_record_0_ _e148 = right;
    const Sample_cuda_record_0_ _e149 = operator_u007c_u007c(_e147, _e148);
    local_9 = uint((base + 9u));
    uint _e158 = local_9;
    local_42 = uint(_e158);
    uint _e161 = local_42;
    out_.Store(_e161*4, asuint(uint(_e149.payload_[int(0)])));
    first = int2(int(2), int(3));
    second = int2(int(4), int(5));
    int2 _e171 = first;
    int2 _e172 = second;
    const int2 _e173 = operator_u0026_u0026_2(_e171, _e172);
    local_10 = uint((base + 10u));
    uint _e180 = local_10;
    local_43 = uint(_e180);
    uint _e183 = local_43;
    out_.Store(_e183*4, asuint(uint(_e173.x)));
    int2 _e185 = first;
    int2 _e186 = second;
    const int2 _e187 = operator_u007c_u007c_2(_e185, _e186);
    local_11 = uint((base + 11u));
    uint _e194 = local_11;
    local_44 = uint(_e194);
    uint _e197 = local_44;
    out_.Store(_e197*4, asuint(uint(_e187.y)));
    int2 _e199 = first;
    int2 _e200 = second;
    const int2 _e201 = operator_u0026_u0026_2(_e199, _e200);
    int2 _e202 = first;
    const int2 _e203 = operator_u0026_u0026_2(_e201, _e202);
    local_12 = uint((base + 12u));
    uint _e210 = local_12;
    local_45 = uint(_e210);
    uint _e213 = local_45;
    out_.Store(_e213*4, asuint(uint(_e203.x)));
    int2 _e215 = first;
    int2 _e216 = second;
    int2 _e217 = first;
    const int2 _e218 = operator_u0026_u0026_2(_e216, _e217);
    const int2 _e219 = operator_u007c_u007c_2(_e215, _e218);
    local_13 = uint((base + 13u));
    uint _e226 = local_13;
    local_46 = uint(_e226);
    uint _e229 = local_46;
    out_.Store(_e229*4, asuint(uint(_e219.y)));
    int2 _e231 = first;
    int2 _e232 = second;
    const int2 _e233 = operator_u007c_u007c_2(_e231, _e232);
    int2 _e234 = first;
    const int2 _e235 = operator_u0026_u0026_2(_e233, _e234);
    local_14 = uint((base + 14u));
    uint _e242 = local_14;
    local_47 = uint(_e242);
    uint _e245 = local_47;
    out_.Store(_e245*4, asuint(uint(_e235.x)));
    if (true) {
        Sample_cuda_record_0_ _e248 = left;
        local_16 = _e248;
    } else {
        Sample_cuda_record_0_ _e250 = right;
        local_16 = _e250;
    }
    Sample_cuda_record_0_ _e253 = local_16;
    const int _e255 = operator_u0026_u0026_1(_e253, int(1));
    local_15 = uint((base + 15u));
    uint _e261 = local_15;
    local_48 = uint(_e261);
    uint _e264 = local_48;
    out_.Store(_e264*4, asuint(uint(_e255)));
    if (true) {
        Sample_cuda_record_0_ _e267 = left;
        Sample_cuda_record_0_ _e268 = right;
        const Sample_cuda_record_0_ _e269 = operator_u0026_u0026_(_e267, _e268);
        local_18 = _e269;
    } else {
        Sample_cuda_record_0_ _e271 = right;
        Sample_cuda_record_0_ _e272 = left;
        const Sample_cuda_record_0_ _e273 = operator_u007c_u007c(_e271, _e272);
        local_18 = _e273;
    }
    Sample_cuda_record_0_ _e276 = local_18;
    local_17 = uint((base + 16u));
    uint _e283 = local_17;
    local_49 = uint(_e283);
    uint _e286 = local_49;
    out_.Store(_e286*4, asuint(uint(_e276.value)));
    counter = int(0);
    if (false) {
        int _e291 = counter;
        counter = asint(asuint(_e291) + asuint(int(1)));
        local_19.value = _e291;
        local_19.payload_[0] = int(1);
        local_19.payload_[1] = int(2);
        Sample_cuda_record_0_ _e301 = local_19;
        Sample_cuda_record_0_ _e302 = right;
        const Sample_cuda_record_0_ _e303 = operator_u0026_u0026_(_e301, _e302);
        local_21 = _e303;
    } else {
        Sample_cuda_record_0_ _e305 = left;
        int _e306 = counter;
        counter = asint(asuint(_e306) + asuint(int(1)));
        local_20.value = _e306;
        local_20.payload_[0] = int(1);
        local_20.payload_[1] = int(2);
        Sample_cuda_record_0_ _e316 = local_20;
        const Sample_cuda_record_0_ _e317 = operator_u007c_u007c(_e305, _e316);
        local_21 = _e317;
    }
    Sample_cuda_record_0_ _e320 = local_21;
    evaluated = _e320;
    int _e323 = evaluated.value;
    local_22 = uint((base + 17u));
    uint _e329 = local_22;
    local_50 = uint(_e329);
    uint _e332 = local_50;
    out_.Store(_e332*4, asuint(uint(_e323)));
    int _e334 = counter;
    local_23 = uint((base + 18u));
    uint _e340 = local_23;
    local_51 = uint(_e340);
    uint _e343 = local_51;
    out_.Store(_e343*4, asuint(uint(_e334)));
    local_25 = false;
    if (false) {
        Sample_cuda_record_0_ _e347 = left;
        Sample_cuda_record_0_ _e348 = right;
        const Sample_cuda_record_0_ _e349 = operator_u0026_u0026_(_e347, _e348);
        local_25 = (_e349.value != int(0));
    }
    bool _e353 = local_25;
    local_24 = uint((base + 19u));
    uint _e359 = local_24;
    local_52 = uint(_e359);
    uint _e362 = local_52;
    out_.Store(_e362*4, asuint(uint(_e353)));
    local_27 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e366 = left;
        Sample_cuda_record_0_ _e367 = right;
        const Sample_cuda_record_0_ _e368 = operator_u007c_u007c(_e366, _e367);
        local_27 = (_e368.value != int(0));
    }
    bool _e372 = local_27;
    local_26 = uint((base + 20u));
    uint _e378 = local_26;
    local_53 = uint(_e378);
    uint _e381 = local_53;
    out_.Store(_e381*4, asuint(uint(_e372)));
    bool _e385 = (int(2) != int(0));
    local_29 = _e385;
    if (_e385) {
        local_29 = (int(3) != int(0));
    }
    bool _e390 = local_29;
    local_28 = uint((base + 21u));
    uint _e396 = local_28;
    local_54 = uint(_e396);
    uint _e399 = local_54;
    out_.Store(_e399*4, asuint(uint(_e390)));
    bool _e403 = (int(0) != int(0));
    local_31 = _e403;
    if (_e403) {
    } else {
        local_31 = (int(4) != int(0));
    }
    bool _e408 = local_31;
    local_30 = uint((base + 22u));
    uint _e414 = local_30;
    local_55 = uint(_e414);
    uint _e417 = local_55;
    out_.Store(_e417*4, asuint(uint(_e408)));
    local_32 = uint((base + 23u));
    uint _e424 = local_32;
    local_56 = uint(_e424);
    uint _e427 = local_56;
    out_.Store(_e427*4, asuint(threadIdx.x));
}
