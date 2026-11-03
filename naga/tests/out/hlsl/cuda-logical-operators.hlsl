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
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    bool local_24 = (bool)0;
    uint local_25 = (uint)0;
    bool local_26 = (bool)0;
    uint local_27 = (uint)0;
    bool local_28 = (bool)0;
    uint local_29 = (uint)0;
    bool local_30 = (bool)0;
    uint local_31 = (uint)0;

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
    out_.Store(_e35*4, asuint(uint(_e29)));
    int _e41 = both.payload_[int(1)];
    local_1 = uint((base + 1u));
    uint _e47 = local_1;
    out_.Store(_e47*4, asuint(uint(_e41)));
    int _e50 = either.value;
    local_2 = uint((base + 2u));
    uint _e56 = local_2;
    out_.Store(_e56*4, asuint(uint(_e50)));
    int _e61 = either.payload_[int(0)];
    local_3 = uint((base + 3u));
    uint _e67 = local_3;
    out_.Store(_e67*4, asuint(uint(_e61)));
    int _e70 = left.value;
    local_4 = uint((base + 4u));
    uint _e76 = local_4;
    out_.Store(_e76*4, asuint(uint(_e70)));
    int _e81 = left.payload_[int(1)];
    local_5 = uint((base + 5u));
    uint _e87 = local_5;
    out_.Store(_e87*4, asuint(uint(_e81)));
    Sample_cuda_record_0_ _e89 = left;
    const int _e91 = operator_u0026_u0026_1(_e89, int(9));
    local_6 = uint((base + 6u));
    uint _e97 = local_6;
    out_.Store(_e97*4, asuint(uint(_e91)));
    Sample_cuda_record_0_ _e99 = right;
    const int _e101 = operator_u007c_u007c_1(int(0), _e99);
    local_7 = uint((base + 7u));
    uint _e107 = local_7;
    out_.Store(_e107*4, asuint(uint(_e101)));
    Sample_cuda_record_0_ _e109 = left;
    Sample_cuda_record_0_ _e110 = right;
    const Sample_cuda_record_0_ _e111 = operator_u0026_u0026_(_e109, _e110);
    local_8 = uint((base + 8u));
    uint _e118 = local_8;
    out_.Store(_e118*4, asuint(uint(_e111.value)));
    Sample_cuda_record_0_ _e120 = left;
    Sample_cuda_record_0_ _e121 = right;
    const Sample_cuda_record_0_ _e122 = operator_u007c_u007c(_e120, _e121);
    local_9 = uint((base + 9u));
    uint _e131 = local_9;
    out_.Store(_e131*4, asuint(uint(_e122.payload_[int(0)])));
    first = int2(int(2), int(3));
    second = int2(int(4), int(5));
    int2 _e141 = first;
    int2 _e142 = second;
    const int2 _e143 = operator_u0026_u0026_2(_e141, _e142);
    local_10 = uint((base + 10u));
    uint _e150 = local_10;
    out_.Store(_e150*4, asuint(uint(_e143.x)));
    int2 _e152 = first;
    int2 _e153 = second;
    const int2 _e154 = operator_u007c_u007c_2(_e152, _e153);
    local_11 = uint((base + 11u));
    uint _e161 = local_11;
    out_.Store(_e161*4, asuint(uint(_e154.y)));
    int2 _e163 = first;
    int2 _e164 = second;
    const int2 _e165 = operator_u0026_u0026_2(_e163, _e164);
    int2 _e166 = first;
    const int2 _e167 = operator_u0026_u0026_2(_e165, _e166);
    local_12 = uint((base + 12u));
    uint _e174 = local_12;
    out_.Store(_e174*4, asuint(uint(_e167.x)));
    int2 _e176 = first;
    int2 _e177 = second;
    int2 _e178 = first;
    const int2 _e179 = operator_u0026_u0026_2(_e177, _e178);
    const int2 _e180 = operator_u007c_u007c_2(_e176, _e179);
    local_13 = uint((base + 13u));
    uint _e187 = local_13;
    out_.Store(_e187*4, asuint(uint(_e180.y)));
    int2 _e189 = first;
    int2 _e190 = second;
    const int2 _e191 = operator_u007c_u007c_2(_e189, _e190);
    int2 _e192 = first;
    const int2 _e193 = operator_u0026_u0026_2(_e191, _e192);
    local_14 = uint((base + 14u));
    uint _e200 = local_14;
    out_.Store(_e200*4, asuint(uint(_e193.x)));
    if (true) {
        Sample_cuda_record_0_ _e203 = left;
        local_16 = _e203;
    } else {
        Sample_cuda_record_0_ _e205 = right;
        local_16 = _e205;
    }
    Sample_cuda_record_0_ _e208 = local_16;
    const int _e210 = operator_u0026_u0026_1(_e208, int(1));
    local_15 = uint((base + 15u));
    uint _e216 = local_15;
    out_.Store(_e216*4, asuint(uint(_e210)));
    if (true) {
        Sample_cuda_record_0_ _e219 = left;
        Sample_cuda_record_0_ _e220 = right;
        const Sample_cuda_record_0_ _e221 = operator_u0026_u0026_(_e219, _e220);
        local_18 = _e221;
    } else {
        Sample_cuda_record_0_ _e223 = right;
        Sample_cuda_record_0_ _e224 = left;
        const Sample_cuda_record_0_ _e225 = operator_u007c_u007c(_e223, _e224);
        local_18 = _e225;
    }
    Sample_cuda_record_0_ _e228 = local_18;
    local_17 = uint((base + 16u));
    uint _e235 = local_17;
    out_.Store(_e235*4, asuint(uint(_e228.value)));
    counter = int(0);
    if (false) {
        int _e240 = counter;
        counter = asint(asuint(_e240) + asuint(int(1)));
        local_19.value = _e240;
        local_19.payload_[0] = int(1);
        local_19.payload_[1] = int(2);
        Sample_cuda_record_0_ _e250 = local_19;
        Sample_cuda_record_0_ _e251 = right;
        const Sample_cuda_record_0_ _e252 = operator_u0026_u0026_(_e250, _e251);
        evaluated = _e252;
    } else {
        Sample_cuda_record_0_ _e254 = left;
        int _e255 = counter;
        counter = asint(asuint(_e255) + asuint(int(1)));
        local_20.value = _e255;
        local_20.payload_[0] = int(1);
        local_20.payload_[1] = int(2);
        Sample_cuda_record_0_ _e265 = local_20;
        const Sample_cuda_record_0_ _e266 = operator_u007c_u007c(_e254, _e265);
        evaluated = _e266;
    }
    int _e270 = evaluated.value;
    local_21 = uint((base + 17u));
    uint _e276 = local_21;
    out_.Store(_e276*4, asuint(uint(_e270)));
    int _e278 = counter;
    local_22 = uint((base + 18u));
    uint _e284 = local_22;
    out_.Store(_e284*4, asuint(uint(_e278)));
    local_24 = false;
    if (false) {
        Sample_cuda_record_0_ _e288 = left;
        Sample_cuda_record_0_ _e289 = right;
        const Sample_cuda_record_0_ _e290 = operator_u0026_u0026_(_e288, _e289);
        local_24 = (_e290.value != int(0));
    }
    bool _e294 = local_24;
    local_23 = uint((base + 19u));
    uint _e300 = local_23;
    out_.Store(_e300*4, asuint(uint(_e294)));
    local_26 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e304 = left;
        Sample_cuda_record_0_ _e305 = right;
        const Sample_cuda_record_0_ _e306 = operator_u007c_u007c(_e304, _e305);
        local_26 = (_e306.value != int(0));
    }
    bool _e310 = local_26;
    local_25 = uint((base + 20u));
    uint _e316 = local_25;
    out_.Store(_e316*4, asuint(uint(_e310)));
    bool _e320 = (int(2) != int(0));
    local_28 = _e320;
    if (_e320) {
        local_28 = (int(3) != int(0));
    }
    bool _e325 = local_28;
    local_27 = uint((base + 21u));
    uint _e331 = local_27;
    out_.Store(_e331*4, asuint(uint(_e325)));
    bool _e335 = (int(0) != int(0));
    local_30 = _e335;
    if (_e335) {
    } else {
        local_30 = (int(4) != int(0));
    }
    bool _e340 = local_30;
    local_29 = uint((base + 22u));
    uint _e346 = local_29;
    out_.Store(_e346*4, asuint(uint(_e340)));
    local_31 = uint((base + 23u));
    uint _e353 = local_31;
    out_.Store(_e353*4, asuint(threadIdx.x));
}
