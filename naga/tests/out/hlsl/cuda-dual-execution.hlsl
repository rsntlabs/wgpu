struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n_1 : register(b2) { type_5 n_1; }

int step_(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    value_2 = asint(asuint(_e3) + asuint(int(3)));
    int _e5 = value_2;
    return _e5;
}

int doubled(int value_3)
{
    int value_4 = (int)0;

    value_4 = value_3;
    int _e2 = value_4;
    const int _e3 = step_(_e2);
    return asint(asuint(_e3) * asuint(int(2)));
}

uint advance(uint value_5)
{
    uint value_6 = (uint)0;

    value_6 = value_5;
    uint _e3 = value_6;
    return (_e3 + 5u);
}

uint retreat(uint value_7)
{
    uint value_8 = (uint)0;

    value_8 = value_7;
    uint _e3 = value_8;
    return (_e3 - 2u);
}

float scale(float value_9, int bias)
{
    float value_10 = (float)0;
    int bias_1 = (int)0;

    value_10 = value_9;
    bias_1 = bias;
    float _e5 = value_10;
    int _e7 = bias_1;
    return ((_e5 * 2.0) + float(_e7));
}

bool same(int left, int right)
{
    int left_1 = (int)0;
    int right_1 = (int)0;

    left_1 = left;
    right_1 = right;
    int _e4 = left_1;
    int _e5 = right_1;
    return (_e4 == _e5);
}

void consume(bool stop, int value_11)
{
    bool stop_1 = (bool)0;
    int value_12 = (int)0;

    stop_1 = stop;
    value_12 = value_11;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_12;
    const int _e6 = doubled(_e5);
    value_12 = _e6;
    return;
}

void forward(bool stop_2, int value_13)
{
    bool stop_3 = (bool)0;
    int value_14 = (int)0;

    stop_3 = stop_2;
    value_14 = value_13;
    bool _e4 = stop_3;
    int _e5 = value_14;
    const int _e6 = step_(_e5);
    consume(_e4, _e6);
    return;
}

int device_only(int value_15)
{
    int value_16 = (int)0;

    value_16 = value_15;
    int _e2 = value_16;
    const int _e3 = step_(_e2);
    return asint(asuint(_e3) + asuint(int(1)));
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
void dual_execution(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
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
    uint local_55[2] = (uint[2])0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    int local_58 = (int)0;
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
    int local_71 = (int)0;
    uint local_72[2] = (uint[2])0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
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
        int _e62 = value;
        const int _e63 = step_(_e62);
        uint _e66[2] = out_;
        local_2 = _e66;
        uint _e67 = base;
        local_3 = uint(_e67);
        uint _e71[2] = local_2;
        local_37 = _e71;
        uint _e72 = local_3;
        uint _e74 = local_37[1];
        local_37[1] = (_e74 + _e72);
        uint _e78 = local_37[0];
        local_38 = uint(_e78);
        uint _e82 = local_37[1];
        local_39 = uint(_e82);
        uint _e85 = local_39;
        out_1.Store(_e85*4, asuint(_e63));
        int _e87 = value;
        uint _e89[2] = out_;
        local_4 = _e89;
        uint _e90 = base;
        local_5 = uint((_e90 + 1u));
        uint _e96[2] = local_4;
        local_40 = _e96;
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
        const int _e113 = doubled(_e112);
        uint _e115[2] = out_;
        local_6 = _e115;
        uint _e116 = base;
        local_7 = uint((_e116 + 2u));
        uint _e122[2] = local_6;
        local_43 = _e122;
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
        const uint _e140 = advance(uint(_e138));
        uint _e142[2] = out_;
        local_8 = _e142;
        uint _e143 = base;
        local_9 = uint((_e143 + 3u));
        uint _e150[2] = local_8;
        local_46 = _e150;
        uint _e151 = local_9;
        uint _e153 = local_46[1];
        local_46[1] = (_e153 + _e151);
        uint _e157 = local_46[0];
        local_47 = uint(_e157);
        uint _e161 = local_46[1];
        local_48 = uint(_e161);
        uint _e164 = local_48;
        out_1.Store(_e164*4, asuint(int(_e140)));
        int _e166 = value;
        const uint _e168 = retreat(uint(_e166));
        uint _e170[2] = out_;
        local_10 = _e170;
        uint _e171 = base;
        local_11 = uint((_e171 + 4u));
        uint _e178[2] = local_10;
        local_49 = _e178;
        uint _e179 = local_11;
        uint _e181 = local_49[1];
        local_49[1] = (_e181 + _e179);
        uint _e185 = local_49[0];
        local_50 = uint(_e185);
        uint _e189 = local_49[1];
        local_51 = uint(_e189);
        uint _e192 = local_51;
        out_1.Store(_e192*4, asuint(int(_e168)));
        int _e194 = value;
        const float _e197 = scale(float(_e194), int(4));
        uint _e199[2] = out_;
        local_12 = _e199;
        uint _e200 = base;
        local_13 = uint((_e200 + 5u));
        uint _e207[2] = local_12;
        local_52 = _e207;
        uint _e208 = local_13;
        uint _e210 = local_52[1];
        local_52[1] = (_e210 + _e208);
        uint _e214 = local_52[0];
        local_53 = uint(_e214);
        uint _e218 = local_52[1];
        local_54 = uint(_e218);
        uint _e221 = local_54;
        out_1.Store(_e221*4, asuint(naga_f2i32(_e197)));
        int _e223 = value;
        uint _e225[2] = input;
        local_16 = _e225;
        uint _e226 = i;
        local_17 = uint(_e226);
        uint _e230[2] = local_16;
        local_55 = _e230;
        uint _e231 = local_17;
        uint _e233 = local_55[1];
        local_55[1] = (_e233 + _e231);
        uint _e237 = local_55[0];
        local_56 = uint(_e237);
        uint _e241 = local_55[1];
        local_57 = uint(_e241);
        uint _e245 = local_57;
        int _e247 = asint(input_1.Load(_e245*4));
        local_58 = _e247;
        int _e248 = local_58;
        local_31 = _e248;
        int _e250 = local_31;
        const bool _e251 = same(_e223, _e250);
        uint _e253[2] = out_;
        local_14 = _e253;
        uint _e254 = base;
        local_15 = uint((_e254 + 6u));
        uint _e261[2] = local_14;
        local_59 = _e261;
        uint _e262 = local_15;
        uint _e264 = local_59[1];
        local_59[1] = (_e264 + _e262);
        uint _e268 = local_59[0];
        local_60 = uint(_e268);
        uint _e272 = local_59[1];
        local_61 = uint(_e272);
        uint _e275 = local_61;
        out_1.Store(_e275*4, asuint(int(_e251)));
        uint _e277 = i;
        int _e282 = value;
        value = asint(asuint(_e282) + asuint(int(1)));
        consume((naga_mod(_e277, 2u) == 0u), _e282);
        int _e285 = value;
        uint _e287[2] = out_;
        local_18 = _e287;
        uint _e288 = base;
        local_19 = uint((_e288 + 7u));
        uint _e294[2] = local_18;
        local_62 = _e294;
        uint _e295 = local_19;
        uint _e297 = local_62[1];
        local_62[1] = (_e297 + _e295);
        uint _e301 = local_62[0];
        local_63 = uint(_e301);
        uint _e305 = local_62[1];
        local_64 = uint(_e305);
        uint _e308 = local_64;
        out_1.Store(_e308*4, asuint(_e285));
        uint _e310 = i;
        int _e315 = value;
        value = asint(asuint(_e315) + asuint(int(1)));
        forward((naga_mod(_e310, 2u) != 0u), _e315);
        int _e318 = value;
        uint _e320[2] = out_;
        local_20 = _e320;
        uint _e321 = base;
        local_21 = uint((_e321 + 8u));
        uint _e327[2] = local_20;
        local_65 = _e327;
        uint _e328 = local_21;
        uint _e330 = local_65[1];
        local_65[1] = (_e330 + _e328);
        uint _e334 = local_65[0];
        local_66 = uint(_e334);
        uint _e338 = local_65[1];
        local_67 = uint(_e338);
        uint _e341 = local_67;
        out_1.Store(_e341*4, asuint(_e318));
        int _e343 = value;
        uint _e345[2] = input;
        local_24 = _e345;
        uint _e346 = i;
        local_25 = uint(_e346);
        uint _e350[2] = local_24;
        local_68 = _e350;
        uint _e351 = local_25;
        uint _e353 = local_68[1];
        local_68[1] = (_e353 + _e351);
        uint _e357 = local_68[0];
        local_69 = uint(_e357);
        uint _e361 = local_68[1];
        local_70 = uint(_e361);
        uint _e365 = local_70;
        int _e367 = asint(input_1.Load(_e365*4));
        local_71 = _e367;
        int _e368 = local_71;
        local_32 = _e368;
        int _e370 = local_32;
        const bool _e371 = same(_e343, _e370);
        uint _e373[2] = out_;
        local_22 = _e373;
        uint _e374 = base;
        local_23 = uint((_e374 + 9u));
        uint _e381[2] = local_22;
        local_72 = _e381;
        uint _e382 = local_23;
        uint _e384 = local_72[1];
        local_72[1] = (_e384 + _e382);
        uint _e388 = local_72[0];
        local_73 = uint(_e388);
        uint _e392 = local_72[1];
        local_74 = uint(_e392);
        uint _e395 = local_74;
        out_1.Store(_e395*4, asuint(int(_e371)));
        int _e397 = value;
        const int _e398 = step_(_e397);
        const int _e399 = device_only(_e398);
        uint _e401[2] = out_;
        local_26 = _e401;
        uint _e402 = base;
        local_27 = uint((_e402 + 10u));
        uint _e408[2] = local_26;
        local_75 = _e408;
        uint _e409 = local_27;
        uint _e411 = local_75[1];
        local_75[1] = (_e411 + _e409);
        uint _e415 = local_75[0];
        local_76 = uint(_e415);
        uint _e419 = local_75[1];
        local_77 = uint(_e419);
        uint _e422 = local_77;
        out_1.Store(_e422*4, asuint(_e399));
        int _e424 = value;
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
