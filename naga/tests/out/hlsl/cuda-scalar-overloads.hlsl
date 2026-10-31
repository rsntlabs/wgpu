struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n_1 : register(b2) { type_5 n_1; }

bool classify(bool value_1)
{
    bool value_2 = (bool)0;

    value_2 = value_1;
    bool _e2 = value_2;
    return !(_e2);
}

int classify_1(int value_3)
{
    int value_4 = (int)0;

    value_4 = value_3;
    int _e3 = value_4;
    return asint(asuint(_e3) + asuint(int(10)));
}

uint classify_2(uint value_5)
{
    uint value_6 = (uint)0;

    value_6 = value_5;
    uint _e3 = value_6;
    return (_e3 + 20u);
}

float classify_3(float value_7)
{
    float value_8 = (float)0;

    value_8 = value_7;
    float _e3 = value_8;
    return ((_e3 * 1.5) + 0.5);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int rank(int left, float right)
{
    int left_1 = (int)0;
    float right_1 = (float)0;

    left_1 = left;
    right_1 = right;
    int _e5 = left_1;
    float _e7 = right_1;
    return asint(asuint(asint(asuint(_e5) * asuint(int(10)))) + asuint(naga_f2i32(_e7)));
}

int rank_1(float left_2, int right_2)
{
    float left_3 = (float)0;
    int right_3 = (int)0;

    left_3 = left_2;
    right_3 = right_2;
    float _e5 = left_3;
    int _e10 = right_3;
    return asint(asuint(asint(asuint(int(100)) + asuint(asint(asuint(naga_f2i32(_e5)) * asuint(int(10)))))) + asuint(_e10));
}

int pair(float left_4, int right_4)
{
    float left_5 = (float)0;
    int right_5 = (int)0;

    left_5 = left_4;
    right_5 = right_4;
    float _e4 = left_5;
    int _e8 = right_5;
    return asint(asuint(asint(asuint(naga_f2i32(_e4)) * asuint(int(10)))) + asuint(_e8));
}

int promote(uint left_6, float right_6)
{
    uint left_7 = (uint)0;
    float right_7 = (float)0;

    left_7 = left_6;
    right_7 = right_6;
    uint _e5 = left_7;
    float _e8 = right_7;
    return asint(asuint(asint(asuint(int(200)) + asuint(int(_e5)))) + asuint(naga_f2i32(_e8)));
}

void touch(bool stop, int value_9)
{
    bool stop_1 = (bool)0;
    int value_10 = (int)0;

    stop_1 = stop;
    value_10 = value_9;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_10;
    const int _e6 = classify_1(_e5);
    value_10 = _e6;
    return;
}

int touch_1(int value_11)
{
    int value_12 = (int)0;

    value_12 = value_11;
    int _e2 = value_12;
    const int _e3 = classify_1(_e2);
    return asint(asuint(_e3) + asuint(int(3)));
}

int stage(int value_13)
{
    int value_14 = (int)0;

    value_14 = value_13;
    int _e3 = value_14;
    return asint(asuint(_e3) + asuint(int(2)));
}

int frozen(float value_15)
{
    float value_16 = (float)0;

    value_16 = value_15;
    float _e2 = value_16;
    const int _e4 = stage(naga_f2i32(_e2));
    return _e4;
}

int stage_1(float value_17)
{
    float value_18 = (float)0;

    value_18 = value_17;
    float _e2 = value_18;
    return asint(asuint(naga_f2i32(_e2)) + asuint(int(100)));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void scalar_overloads(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    bool choose = (bool)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    int effect = (int)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    int nested = (int)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    int argument = (int)0;
    int captured = (int)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    int local_28 = (int)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    int local_32 = (int)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 1u;
    input[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 13u);
        uint _e35[2] = input;
        local = _e35;
        uint _e36 = i;
        local_1 = uint(_e36);
        uint _e40[2] = local;
        local_29 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_29[1];
        local_29[1] = (_e43 + _e41);
        uint _e47 = local_29[0];
        local_30 = uint(_e47);
        uint _e51 = local_29[1];
        local_31 = uint(_e51);
        uint _e55 = local_31;
        int _e57 = asint(input_1.Load(_e55*4));
        local_32 = _e57;
        int _e58 = local_32;
        local_28 = _e58;
        int _e60 = local_28;
        value = _e60;
        uint _e62 = i;
        choose = (naga_mod(_e62, 2u) == 0u);
        bool _e68 = choose;
        const bool _e69 = classify(_e68);
        uint _e72[2] = out_;
        local_2 = _e72;
        uint _e73 = base;
        local_3 = uint(_e73);
        uint _e78[2] = local_2;
        local_33 = _e78;
        uint _e79 = local_3;
        uint _e81 = local_33[1];
        local_33[1] = (_e81 + _e79);
        uint _e85 = local_33[0];
        local_34 = uint(_e85);
        uint _e89 = local_33[1];
        local_35 = uint(_e89);
        uint _e92 = local_35;
        out_1.Store(_e92*4, asuint(int(_e69)));
        int _e94 = value;
        const int _e95 = classify_1(_e94);
        uint _e97[2] = out_;
        local_4 = _e97;
        uint _e98 = base;
        local_5 = uint((_e98 + 1u));
        uint _e104[2] = local_4;
        local_36 = _e104;
        uint _e105 = local_5;
        uint _e107 = local_36[1];
        local_36[1] = (_e107 + _e105);
        uint _e111 = local_36[0];
        local_37 = uint(_e111);
        uint _e115 = local_36[1];
        local_38 = uint(_e115);
        uint _e118 = local_38;
        out_1.Store(_e118*4, asuint(_e95));
        int _e120 = value;
        const uint _e124 = classify_2(uint(asint(asuint(_e120) + asuint(int(16)))));
        uint _e126[2] = out_;
        local_6 = _e126;
        uint _e127 = base;
        local_7 = uint((_e127 + 2u));
        uint _e134[2] = local_6;
        local_39 = _e134;
        uint _e135 = local_7;
        uint _e137 = local_39[1];
        local_39[1] = (_e137 + _e135);
        uint _e141 = local_39[0];
        local_40 = uint(_e141);
        uint _e145 = local_39[1];
        local_41 = uint(_e145);
        uint _e148 = local_41;
        out_1.Store(_e148*4, asuint(int(_e124)));
        int _e150 = value;
        const float _e152 = classify_3(float(_e150));
        uint _e154[2] = out_;
        local_8 = _e154;
        uint _e155 = base;
        local_9 = uint((_e155 + 3u));
        uint _e162[2] = local_8;
        local_42 = _e162;
        uint _e163 = local_9;
        uint _e165 = local_42[1];
        local_42[1] = (_e165 + _e163);
        uint _e169 = local_42[0];
        local_43 = uint(_e169);
        uint _e173 = local_42[1];
        local_44 = uint(_e173);
        uint _e176 = local_44;
        out_1.Store(_e176*4, asuint(naga_f2i32(_e152)));
        bool _e178 = choose;
        int _e179 = value;
        const int _e184 = rank(int(_e178), (float(_e179) + 0.5));
        uint _e186[2] = out_;
        local_10 = _e186;
        uint _e187 = base;
        local_11 = uint((_e187 + 4u));
        uint _e193[2] = local_10;
        local_45 = _e193;
        uint _e194 = local_11;
        uint _e196 = local_45[1];
        local_45[1] = (_e196 + _e194);
        uint _e200 = local_45[0];
        local_46 = uint(_e200);
        uint _e204 = local_45[1];
        local_47 = uint(_e204);
        uint _e207 = local_47;
        out_1.Store(_e207*4, asuint(_e184));
        int _e209 = value;
        bool _e213 = choose;
        const int _e215 = rank_1((float(_e209) + 0.5), int(_e213));
        uint _e217[2] = out_;
        local_12 = _e217;
        uint _e218 = base;
        local_13 = uint((_e218 + 5u));
        uint _e224[2] = local_12;
        local_48 = _e224;
        uint _e225 = local_13;
        uint _e227 = local_48[1];
        local_48[1] = (_e227 + _e225);
        uint _e231 = local_48[0];
        local_49 = uint(_e231);
        uint _e235 = local_48[1];
        local_50 = uint(_e235);
        uint _e238 = local_50;
        out_1.Store(_e238*4, asuint(_e215));
        int _e240 = value;
        int _e244 = value;
        const int _e246 = promote(uint(asint(asuint(_e240) + asuint(int(16)))), float(_e244));
        uint _e248[2] = out_;
        local_14 = _e248;
        uint _e249 = base;
        local_15 = uint((_e249 + 6u));
        uint _e255[2] = local_14;
        local_51 = _e255;
        uint _e256 = local_15;
        uint _e258 = local_51[1];
        local_51[1] = (_e258 + _e256);
        uint _e262 = local_51[0];
        local_52 = uint(_e262);
        uint _e266 = local_51[1];
        local_53 = uint(_e266);
        uint _e269 = local_53;
        out_1.Store(_e269*4, asuint(_e246));
        int _e271 = value;
        effect = _e271;
        bool _e273 = choose;
        int _e274 = effect;
        effect = asint(asuint(_e274) + asuint(int(1)));
        touch(_e273, _e274);
        int _e277 = effect;
        uint _e279[2] = out_;
        local_16 = _e279;
        uint _e280 = base;
        local_17 = uint((_e280 + 7u));
        uint _e286[2] = local_16;
        local_54 = _e286;
        uint _e287 = local_17;
        uint _e289 = local_54[1];
        local_54[1] = (_e289 + _e287);
        uint _e293 = local_54[0];
        local_55 = uint(_e293);
        uint _e297 = local_54[1];
        local_56 = uint(_e297);
        uint _e300 = local_56;
        out_1.Store(_e300*4, asuint(_e277));
        int _e302 = effect;
        const int _e303 = touch_1(_e302);
        uint _e305[2] = out_;
        local_18 = _e305;
        uint _e306 = base;
        local_19 = uint((_e306 + 8u));
        uint _e312[2] = local_18;
        local_57 = _e312;
        uint _e313 = local_19;
        uint _e315 = local_57[1];
        local_57[1] = (_e315 + _e313);
        uint _e319 = local_57[0];
        local_58 = uint(_e319);
        uint _e323 = local_57[1];
        local_59 = uint(_e323);
        uint _e326 = local_59;
        out_1.Store(_e326*4, asuint(_e303));
        int _e328 = value;
        const int _e332 = frozen((float(_e328) + 0.75));
        uint _e334[2] = out_;
        local_20 = _e334;
        uint _e335 = base;
        local_21 = uint((_e335 + 9u));
        uint _e341[2] = local_20;
        local_60 = _e341;
        uint _e342 = local_21;
        uint _e344 = local_60[1];
        local_60[1] = (_e344 + _e342);
        uint _e348 = local_60[0];
        local_61 = uint(_e348);
        uint _e352 = local_60[1];
        local_62 = uint(_e352);
        uint _e355 = local_62;
        out_1.Store(_e355*4, asuint(_e332));
        int _e357 = value;
        const int _e361 = stage_1((float(_e357) + 0.75));
        uint _e363[2] = out_;
        local_22 = _e363;
        uint _e364 = base;
        local_23 = uint((_e364 + 10u));
        uint _e370[2] = local_22;
        local_63 = _e370;
        uint _e371 = local_23;
        uint _e373 = local_63[1];
        local_63[1] = (_e373 + _e371);
        uint _e377 = local_63[0];
        local_64 = uint(_e377);
        uint _e381 = local_63[1];
        local_65 = uint(_e381);
        uint _e384 = local_65;
        out_1.Store(_e384*4, asuint(_e361));
        int _e386 = effect;
        effect = asint(asuint(_e386) + asuint(int(1)));
        const int _e389 = classify_1(_e386);
        const int _e390 = touch_1(_e389);
        nested = _e390;
        int _e392 = nested;
        int _e395 = effect;
        uint _e398[2] = out_;
        local_24 = _e398;
        uint _e399 = base;
        local_25 = uint((_e399 + 11u));
        uint _e405[2] = local_24;
        local_66 = _e405;
        uint _e406 = local_25;
        uint _e408 = local_66[1];
        local_66[1] = (_e408 + _e406);
        uint _e412 = local_66[0];
        local_67 = uint(_e412);
        uint _e416 = local_66[1];
        local_68 = uint(_e416);
        uint _e419 = local_68;
        out_1.Store(_e419*4, asuint(asint(asuint(asint(asuint(_e392) * asuint(int(10)))) + asuint(_e395))));
        int _e421 = value;
        argument = asint(asuint(_e421) + asuint(int(8)));
        int _e425 = argument;
        int _e426 = argument;
        argument = asint(asuint(_e426) + asuint(int(1)));
        const int _e430 = pair(float(_e425), _e426);
        captured = _e430;
        int _e432 = captured;
        int _e435 = argument;
        uint _e438[2] = out_;
        local_26 = _e438;
        uint _e439 = base;
        local_27 = uint((_e439 + 12u));
        uint _e445[2] = local_26;
        local_69 = _e445;
        uint _e446 = local_27;
        uint _e448 = local_69[1];
        local_69[1] = (_e448 + _e446);
        uint _e452 = local_69[0];
        local_70 = uint(_e452);
        uint _e456 = local_69[1];
        local_71 = uint(_e456);
        uint _e459 = local_71;
        out_1.Store(_e459*4, asuint(asint(asuint(asint(asuint(_e432) * asuint(int(100)))) + asuint(_e435))));
    }
}
