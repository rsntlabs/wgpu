struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n : register(b2) { type_5 n; }

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
    const int _e1 = increment(value_3);
    return asint(asuint(_e1) * asuint(int(2)));
}

int advance(int value_4)
{
    const int _e1 = twice(value_4);
    return asint(asuint(_e1) + asuint(int(1)));
}

int retreat(int value_5)
{
    return asint(asuint(value_5) - asuint(int(3)));
}

float scaled(float value_6)
{
    return ((value_6 * 1.5) + 0.5);
}

bool differs(int value_7, int other)
{
    return (value_7 != other);
}

void consume(bool stop, int value_8)
{
    int value_9 = (int)0;

    value_9 = value_8;
    if (stop) {
        return;
    }
    int _e3 = value_9;
    const int _e4 = advance(_e3);
    value_9 = _e4;
    return;
}

void forward(bool stop_1, int value_10)
{
    const int _e2 = retreat(value_10);
    consume(stop_1, _e2);
    return;
}

uint plus_one(uint value_11)
{
    return (value_11 + 1u);
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
    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        uint _e27[2] = input;
        local = _e27;
        local_1 = uint(i);
        uint _e31[2] = local;
        local_33 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_33[1];
        local_33[1] = (_e35 + _e33);
        uint _e39 = local_33[0];
        local_34 = uint(_e39);
        uint _e43 = local_33[1];
        local_35 = uint(_e43);
        uint _e46 = local_35;
        int _e49 = asint(input_1.Load(_e46*4));
        local_36 = _e49;
        int _e51 = local_36;
        local_30 = _e51;
        int _e53 = local_30;
        value = _e53;
        choose = (naga_mod(i, 2u) == 0u);
        int _e60 = value;
        const int _e61 = increment(_e60);
        uint _e63[2] = out_;
        local_2 = _e63;
        uint _e65 = base;
        local_3 = uint(_e65);
        uint _e68[2] = local_2;
        local_37 = _e68;
        uint _e70 = local_3;
        uint _e72 = local_37[1];
        local_37[1] = (_e72 + _e70);
        uint _e76 = local_37[0];
        local_38 = uint(_e76);
        uint _e80 = local_37[1];
        local_39 = uint(_e80);
        uint _e83 = local_39;
        out_1.Store(_e83*4, asuint(_e61));
        int _e86 = value;
        const int _e87 = twice(_e86);
        uint _e88[2] = out_;
        local_4 = _e88;
        uint _e90 = base;
        local_5 = uint((_e90 + 1u));
        uint _e95[2] = local_4;
        local_40 = _e95;
        uint _e97 = local_5;
        uint _e99 = local_40[1];
        local_40[1] = (_e99 + _e97);
        uint _e103 = local_40[0];
        local_41 = uint(_e103);
        uint _e107 = local_40[1];
        local_42 = uint(_e107);
        uint _e110 = local_42;
        out_1.Store(_e110*4, asuint(_e87));
        int _e112 = value;
        const int _e113 = advance(_e112);
        uint _e114[2] = out_;
        local_6 = _e114;
        uint _e116 = base;
        local_7 = uint((_e116 + 2u));
        uint _e121[2] = local_6;
        local_43 = _e121;
        uint _e123 = local_7;
        uint _e125 = local_43[1];
        local_43[1] = (_e125 + _e123);
        uint _e129 = local_43[0];
        local_44 = uint(_e129);
        uint _e133 = local_43[1];
        local_45 = uint(_e133);
        uint _e136 = local_45;
        out_1.Store(_e136*4, asuint(_e113));
        int _e138 = value;
        const int _e139 = retreat(_e138);
        uint _e140[2] = out_;
        local_8 = _e140;
        uint _e142 = base;
        local_9 = uint((_e142 + 3u));
        uint _e147[2] = local_8;
        local_46 = _e147;
        uint _e149 = local_9;
        uint _e151 = local_46[1];
        local_46[1] = (_e151 + _e149);
        uint _e155 = local_46[0];
        local_47 = uint(_e155);
        uint _e159 = local_46[1];
        local_48 = uint(_e159);
        uint _e162 = local_48;
        out_1.Store(_e162*4, asuint(_e139));
        int _e164 = value;
        const float _e166 = scaled(float(_e164));
        uint _e167[2] = out_;
        local_10 = _e167;
        uint _e169 = base;
        local_11 = uint((_e169 + 4u));
        uint _e175[2] = local_10;
        local_49 = _e175;
        uint _e177 = local_11;
        uint _e179 = local_49[1];
        local_49[1] = (_e179 + _e177);
        uint _e183 = local_49[0];
        local_50 = uint(_e183);
        uint _e187 = local_49[1];
        local_51 = uint(_e187);
        uint _e190 = local_51;
        out_1.Store(_e190*4, asuint(naga_f2i32(_e166)));
        int _e192 = value;
        uint _e193[2] = input;
        local_14 = _e193;
        local_15 = uint(i);
        uint _e197[2] = local_14;
        local_52 = _e197;
        uint _e199 = local_15;
        uint _e201 = local_52[1];
        local_52[1] = (_e201 + _e199);
        uint _e205 = local_52[0];
        local_53 = uint(_e205);
        uint _e209 = local_52[1];
        local_54 = uint(_e209);
        uint _e212 = local_54;
        int _e214 = asint(input_1.Load(_e212*4));
        local_55 = _e214;
        int _e216 = local_55;
        local_31 = _e216;
        int _e218 = local_31;
        const bool _e219 = differs(_e192, _e218);
        uint _e220[2] = out_;
        local_12 = _e220;
        uint _e222 = base;
        local_13 = uint((_e222 + 5u));
        uint _e228[2] = local_12;
        local_56 = _e228;
        uint _e230 = local_13;
        uint _e232 = local_56[1];
        local_56[1] = (_e232 + _e230);
        uint _e236 = local_56[0];
        local_57 = uint(_e236);
        uint _e240 = local_56[1];
        local_58 = uint(_e240);
        uint _e243 = local_58;
        out_1.Store(_e243*4, asuint(int(_e219)));
        int _e245 = value;
        effect = _e245;
        bool _e247 = choose;
        int _e248 = effect;
        effect = asint(asuint(_e248) + asuint(int(1)));
        consume(_e247, _e248);
        int _e251 = effect;
        uint _e252[2] = out_;
        local_16 = _e252;
        uint _e254 = base;
        local_17 = uint((_e254 + 6u));
        uint _e259[2] = local_16;
        local_59 = _e259;
        uint _e261 = local_17;
        uint _e263 = local_59[1];
        local_59[1] = (_e263 + _e261);
        uint _e267 = local_59[0];
        local_60 = uint(_e267);
        uint _e271 = local_59[1];
        local_61 = uint(_e271);
        uint _e274 = local_61;
        out_1.Store(_e274*4, asuint(_e251));
        bool _e276 = choose;
        int _e278 = effect;
        effect = asint(asuint(_e278) + asuint(int(1)));
        forward(!(_e276), _e278);
        int _e281 = effect;
        uint _e282[2] = out_;
        local_18 = _e282;
        uint _e284 = base;
        local_19 = uint((_e284 + 7u));
        uint _e289[2] = local_18;
        local_62 = _e289;
        uint _e291 = local_19;
        uint _e293 = local_62[1];
        local_62[1] = (_e293 + _e291);
        uint _e297 = local_62[0];
        local_63 = uint(_e297);
        uint _e301 = local_62[1];
        local_64 = uint(_e301);
        uint _e304 = local_64;
        out_1.Store(_e304*4, asuint(_e281));
        int _e306 = effect;
        const int _e307 = advance(_e306);
        uint _e308[2] = out_;
        local_20 = _e308;
        uint _e310 = base;
        local_21 = uint((_e310 + 8u));
        uint _e315[2] = local_20;
        local_65 = _e315;
        uint _e317 = local_21;
        uint _e319 = local_65[1];
        local_65[1] = (_e319 + _e317);
        uint _e323 = local_65[0];
        local_66 = uint(_e323);
        uint _e327 = local_65[1];
        local_67 = uint(_e327);
        uint _e330 = local_67;
        out_1.Store(_e330*4, asuint(_e307));
        int _e332 = effect;
        const uint _e336 = plus_one(uint(asint(asuint(_e332) + asuint(int(16)))));
        uint _e337[2] = out_;
        local_22 = _e337;
        uint _e339 = base;
        local_23 = uint((_e339 + 9u));
        uint _e345[2] = local_22;
        local_68 = _e345;
        uint _e347 = local_23;
        uint _e349 = local_68[1];
        local_68[1] = (_e349 + _e347);
        uint _e353 = local_68[0];
        local_69 = uint(_e353);
        uint _e357 = local_68[1];
        local_70 = uint(_e357);
        uint _e360 = local_70;
        out_1.Store(_e360*4, asuint(int(_e336)));
        int _e362 = effect;
        uint _e363[2] = input;
        local_26 = _e363;
        local_27 = uint(i);
        uint _e367[2] = local_26;
        local_71 = _e367;
        uint _e369 = local_27;
        uint _e371 = local_71[1];
        local_71[1] = (_e371 + _e369);
        uint _e375 = local_71[0];
        local_72 = uint(_e375);
        uint _e379 = local_71[1];
        local_73 = uint(_e379);
        uint _e382 = local_73;
        int _e384 = asint(input_1.Load(_e382*4));
        local_74 = _e384;
        int _e386 = local_74;
        local_32 = _e386;
        int _e388 = local_32;
        const bool _e389 = differs(_e362, _e388);
        uint _e390[2] = out_;
        local_24 = _e390;
        uint _e392 = base;
        local_25 = uint((_e392 + 10u));
        uint _e398[2] = local_24;
        local_75 = _e398;
        uint _e400 = local_25;
        uint _e402 = local_75[1];
        local_75[1] = (_e402 + _e400);
        uint _e406 = local_75[0];
        local_76 = uint(_e406);
        uint _e410 = local_75[1];
        local_77 = uint(_e410);
        uint _e413 = local_77;
        out_1.Store(_e413*4, asuint(int(_e389)));
        int _e415 = effect;
        uint _e416[2] = out_;
        local_28 = _e416;
        uint _e418 = base;
        local_29 = uint((_e418 + 11u));
        uint _e423[2] = local_28;
        local_78 = _e423;
        uint _e425 = local_29;
        uint _e427 = local_78[1];
        local_78[1] = (_e427 + _e425);
        uint _e431 = local_78[0];
        local_79 = uint(_e431);
        uint _e435 = local_78[1];
        local_80 = uint(_e435);
        uint _e438 = local_80;
        out_1.Store(_e438*4, asuint(_e415));
    }
}
