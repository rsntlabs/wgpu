struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n_1 : register(b2) { type_5 n_1; }

int increment(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    value_2 = asint(asuint(_e3) + asuint(int(2)));
    int _e5 = value_2;
    return _e5;
}

int twice(int value_3)
{
    int value_4 = (int)0;

    value_4 = value_3;
    int _e2 = value_4;
    const int _e3 = increment(_e2);
    return asint(asuint(_e3) * asuint(int(2)));
}

int advance(int value_5)
{
    int value_6 = (int)0;

    value_6 = value_5;
    int _e2 = value_6;
    const int _e3 = twice(_e2);
    return asint(asuint(_e3) + asuint(int(1)));
}

int retreat(int value_7)
{
    int value_8 = (int)0;

    value_8 = value_7;
    int _e3 = value_8;
    return asint(asuint(_e3) - asuint(int(3)));
}

float scaled(float value_9)
{
    float value_10 = (float)0;

    value_10 = value_9;
    float _e3 = value_10;
    return ((_e3 * 1.5) + 0.5);
}

bool differs(int value_11, int other)
{
    int value_12 = (int)0;
    int other_1 = (int)0;

    value_12 = value_11;
    other_1 = other;
    int _e4 = value_12;
    int _e5 = other_1;
    return (_e4 != _e5);
}

void consume(bool stop, int value_13)
{
    bool stop_1 = (bool)0;
    int value_14 = (int)0;

    stop_1 = stop;
    value_14 = value_13;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_14;
    const int _e6 = advance(_e5);
    value_14 = _e6;
    return;
}

void forward(bool stop_2, int value_15)
{
    bool stop_3 = (bool)0;
    int value_16 = (int)0;

    stop_3 = stop_2;
    value_16 = value_15;
    bool _e4 = stop_3;
    int _e5 = value_16;
    const int _e6 = retreat(_e5);
    consume(_e4, _e6);
    return;
}

uint plus_one(uint value_17)
{
    uint value_18 = (uint)0;

    value_18 = value_17;
    uint _e3 = value_18;
    return (_e3 + 1u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void function_specifiers(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
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
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    int local_30 = (int)0;
    int local_31 = (int)0;
    int local_32 = (int)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    int local_36 = (int)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    int local_55 = (int)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65[2] = (uint[2])0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68[2] = (uint[2])0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    int local_74 = (int)0;
    uint local_75[2] = (uint[2])0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78[2] = (uint[2])0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;

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
        base = (_e29 * 12u);
        uint _e35[2] = input;
        local = _e35;
        uint _e36 = i;
        local_1 = uint(_e36);
        uint _e40[2] = local;
        local_33 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_33[1];
        local_33[1] = (_e43 + _e41);
        uint _e47 = local_33[0];
        local_34 = uint(_e47);
        uint _e51 = local_33[1];
        local_35 = uint(_e51);
        uint _e55 = local_35;
        int _e57 = asint(input_1.Load(_e55*4));
        local_36 = _e57;
        int _e58 = local_36;
        local_30 = _e58;
        int _e60 = local_30;
        value = _e60;
        uint _e62 = i;
        choose = (naga_mod(_e62, 2u) == 0u);
        int _e68 = value;
        const int _e69 = increment(_e68);
        uint _e72[2] = out_;
        local_2 = _e72;
        uint _e73 = base;
        local_3 = uint(_e73);
        uint _e77[2] = local_2;
        local_37 = _e77;
        uint _e78 = local_3;
        uint _e80 = local_37[1];
        local_37[1] = (_e80 + _e78);
        uint _e84 = local_37[0];
        local_38 = uint(_e84);
        uint _e88 = local_37[1];
        local_39 = uint(_e88);
        uint _e91 = local_39;
        out_1.Store(_e91*4, asuint(_e69));
        int _e93 = value;
        const int _e94 = twice(_e93);
        uint _e96[2] = out_;
        local_4 = _e96;
        uint _e97 = base;
        local_5 = uint((_e97 + 1u));
        uint _e103[2] = local_4;
        local_40 = _e103;
        uint _e104 = local_5;
        uint _e106 = local_40[1];
        local_40[1] = (_e106 + _e104);
        uint _e110 = local_40[0];
        local_41 = uint(_e110);
        uint _e114 = local_40[1];
        local_42 = uint(_e114);
        uint _e117 = local_42;
        out_1.Store(_e117*4, asuint(_e94));
        int _e119 = value;
        const int _e120 = advance(_e119);
        uint _e122[2] = out_;
        local_6 = _e122;
        uint _e123 = base;
        local_7 = uint((_e123 + 2u));
        uint _e129[2] = local_6;
        local_43 = _e129;
        uint _e130 = local_7;
        uint _e132 = local_43[1];
        local_43[1] = (_e132 + _e130);
        uint _e136 = local_43[0];
        local_44 = uint(_e136);
        uint _e140 = local_43[1];
        local_45 = uint(_e140);
        uint _e143 = local_45;
        out_1.Store(_e143*4, asuint(_e120));
        int _e145 = value;
        const int _e146 = retreat(_e145);
        uint _e148[2] = out_;
        local_8 = _e148;
        uint _e149 = base;
        local_9 = uint((_e149 + 3u));
        uint _e155[2] = local_8;
        local_46 = _e155;
        uint _e156 = local_9;
        uint _e158 = local_46[1];
        local_46[1] = (_e158 + _e156);
        uint _e162 = local_46[0];
        local_47 = uint(_e162);
        uint _e166 = local_46[1];
        local_48 = uint(_e166);
        uint _e169 = local_48;
        out_1.Store(_e169*4, asuint(_e146));
        int _e171 = value;
        const float _e173 = scaled(float(_e171));
        uint _e175[2] = out_;
        local_10 = _e175;
        uint _e176 = base;
        local_11 = uint((_e176 + 4u));
        uint _e183[2] = local_10;
        local_49 = _e183;
        uint _e184 = local_11;
        uint _e186 = local_49[1];
        local_49[1] = (_e186 + _e184);
        uint _e190 = local_49[0];
        local_50 = uint(_e190);
        uint _e194 = local_49[1];
        local_51 = uint(_e194);
        uint _e197 = local_51;
        out_1.Store(_e197*4, asuint(naga_f2i32(_e173)));
        int _e199 = value;
        uint _e201[2] = input;
        local_14 = _e201;
        uint _e202 = i;
        local_15 = uint(_e202);
        uint _e206[2] = local_14;
        local_52 = _e206;
        uint _e207 = local_15;
        uint _e209 = local_52[1];
        local_52[1] = (_e209 + _e207);
        uint _e213 = local_52[0];
        local_53 = uint(_e213);
        uint _e217 = local_52[1];
        local_54 = uint(_e217);
        uint _e221 = local_54;
        int _e223 = asint(input_1.Load(_e221*4));
        local_55 = _e223;
        int _e224 = local_55;
        local_31 = _e224;
        int _e226 = local_31;
        const bool _e227 = differs(_e199, _e226);
        uint _e229[2] = out_;
        local_12 = _e229;
        uint _e230 = base;
        local_13 = uint((_e230 + 5u));
        uint _e237[2] = local_12;
        local_56 = _e237;
        uint _e238 = local_13;
        uint _e240 = local_56[1];
        local_56[1] = (_e240 + _e238);
        uint _e244 = local_56[0];
        local_57 = uint(_e244);
        uint _e248 = local_56[1];
        local_58 = uint(_e248);
        uint _e251 = local_58;
        out_1.Store(_e251*4, asuint(int(_e227)));
        int _e253 = value;
        effect = _e253;
        bool _e255 = choose;
        int _e256 = effect;
        effect = asint(asuint(_e256) + asuint(int(1)));
        consume(_e255, _e256);
        int _e259 = effect;
        uint _e261[2] = out_;
        local_16 = _e261;
        uint _e262 = base;
        local_17 = uint((_e262 + 6u));
        uint _e268[2] = local_16;
        local_59 = _e268;
        uint _e269 = local_17;
        uint _e271 = local_59[1];
        local_59[1] = (_e271 + _e269);
        uint _e275 = local_59[0];
        local_60 = uint(_e275);
        uint _e279 = local_59[1];
        local_61 = uint(_e279);
        uint _e282 = local_61;
        out_1.Store(_e282*4, asuint(_e259));
        bool _e284 = choose;
        int _e286 = effect;
        effect = asint(asuint(_e286) + asuint(int(1)));
        forward(!(_e284), _e286);
        int _e289 = effect;
        uint _e291[2] = out_;
        local_18 = _e291;
        uint _e292 = base;
        local_19 = uint((_e292 + 7u));
        uint _e298[2] = local_18;
        local_62 = _e298;
        uint _e299 = local_19;
        uint _e301 = local_62[1];
        local_62[1] = (_e301 + _e299);
        uint _e305 = local_62[0];
        local_63 = uint(_e305);
        uint _e309 = local_62[1];
        local_64 = uint(_e309);
        uint _e312 = local_64;
        out_1.Store(_e312*4, asuint(_e289));
        int _e314 = effect;
        const int _e315 = advance(_e314);
        uint _e317[2] = out_;
        local_20 = _e317;
        uint _e318 = base;
        local_21 = uint((_e318 + 8u));
        uint _e324[2] = local_20;
        local_65 = _e324;
        uint _e325 = local_21;
        uint _e327 = local_65[1];
        local_65[1] = (_e327 + _e325);
        uint _e331 = local_65[0];
        local_66 = uint(_e331);
        uint _e335 = local_65[1];
        local_67 = uint(_e335);
        uint _e338 = local_67;
        out_1.Store(_e338*4, asuint(_e315));
        int _e340 = effect;
        const uint _e344 = plus_one(uint(asint(asuint(_e340) + asuint(int(16)))));
        uint _e346[2] = out_;
        local_22 = _e346;
        uint _e347 = base;
        local_23 = uint((_e347 + 9u));
        uint _e354[2] = local_22;
        local_68 = _e354;
        uint _e355 = local_23;
        uint _e357 = local_68[1];
        local_68[1] = (_e357 + _e355);
        uint _e361 = local_68[0];
        local_69 = uint(_e361);
        uint _e365 = local_68[1];
        local_70 = uint(_e365);
        uint _e368 = local_70;
        out_1.Store(_e368*4, asuint(int(_e344)));
        int _e370 = effect;
        uint _e372[2] = input;
        local_26 = _e372;
        uint _e373 = i;
        local_27 = uint(_e373);
        uint _e377[2] = local_26;
        local_71 = _e377;
        uint _e378 = local_27;
        uint _e380 = local_71[1];
        local_71[1] = (_e380 + _e378);
        uint _e384 = local_71[0];
        local_72 = uint(_e384);
        uint _e388 = local_71[1];
        local_73 = uint(_e388);
        uint _e392 = local_73;
        int _e394 = asint(input_1.Load(_e392*4));
        local_74 = _e394;
        int _e395 = local_74;
        local_32 = _e395;
        int _e397 = local_32;
        const bool _e398 = differs(_e370, _e397);
        uint _e400[2] = out_;
        local_24 = _e400;
        uint _e401 = base;
        local_25 = uint((_e401 + 10u));
        uint _e408[2] = local_24;
        local_75 = _e408;
        uint _e409 = local_25;
        uint _e411 = local_75[1];
        local_75[1] = (_e411 + _e409);
        uint _e415 = local_75[0];
        local_76 = uint(_e415);
        uint _e419 = local_75[1];
        local_77 = uint(_e419);
        uint _e422 = local_77;
        out_1.Store(_e422*4, asuint(int(_e398)));
        int _e424 = effect;
        uint _e426[2] = out_;
        local_28 = _e426;
        uint _e427 = base;
        local_29 = uint((_e427 + 11u));
        uint _e433[2] = local_28;
        local_78 = _e433;
        uint _e434 = local_29;
        uint _e436 = local_78[1];
        local_78[1] = (_e436 + _e434);
        uint _e440 = local_78[0];
        local_79 = uint(_e440);
        uint _e444 = local_78[1];
        local_80 = uint(_e444);
        uint _e447 = local_80;
        out_1.Store(_e447*4, asuint(_e424));
    }
}
