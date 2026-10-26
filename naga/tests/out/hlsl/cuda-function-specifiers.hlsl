struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
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

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void function_specifiers(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    bool choose = (bool)0;
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
    int effect = (int)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
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
    int local_48 = (int)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    int local_55 = (int)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    int local_62 = (int)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;

    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 12u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_47 = uint((_e32 + _e33));
        uint _e38 = local_47;
        int _e40 = asint(input.Load(_e38*4));
        local_48 = _e40;
        int _e41 = local_48;
        value = _e41;
        uint _e43 = i;
        choose = (naga_mod(_e43, 2u) == 0u);
        int _e49 = value;
        const int _e50 = increment(_e49);
        uint _e51 = local;
        local_5 = _e51;
        uint _e53 = local_5;
        local_6 = uint(_e53);
        uint _e56 = base;
        local_7 = uint(_e56);
        uint _e60 = local_6;
        uint _e61 = local_7;
        local_49 = uint((_e60 + _e61));
        uint _e65 = local_49;
        out_.Store(_e65*4, asuint(_e50));
        int _e67 = value;
        const int _e68 = twice(_e67);
        uint _e69 = local;
        local_8 = _e69;
        uint _e71 = local_8;
        local_9 = uint(_e71);
        uint _e74 = base;
        local_10 = uint((_e74 + 1u));
        uint _e79 = local_9;
        uint _e80 = local_10;
        local_50 = uint((_e79 + _e80));
        uint _e84 = local_50;
        out_.Store(_e84*4, asuint(_e68));
        int _e86 = value;
        const int _e87 = advance(_e86);
        uint _e88 = local;
        local_11 = _e88;
        uint _e90 = local_11;
        local_12 = uint(_e90);
        uint _e93 = base;
        local_13 = uint((_e93 + 2u));
        uint _e98 = local_12;
        uint _e99 = local_13;
        local_51 = uint((_e98 + _e99));
        uint _e103 = local_51;
        out_.Store(_e103*4, asuint(_e87));
        int _e105 = value;
        const int _e106 = retreat(_e105);
        uint _e107 = local;
        local_14 = _e107;
        uint _e109 = local_14;
        local_15 = uint(_e109);
        uint _e112 = base;
        local_16 = uint((_e112 + 3u));
        uint _e117 = local_15;
        uint _e118 = local_16;
        local_52 = uint((_e117 + _e118));
        uint _e122 = local_52;
        out_.Store(_e122*4, asuint(_e106));
        int _e124 = value;
        const float _e126 = scaled(float(_e124));
        uint _e127 = local;
        local_17 = _e127;
        uint _e129 = local_17;
        local_18 = uint(_e129);
        uint _e132 = base;
        local_19 = uint((_e132 + 4u));
        uint _e138 = local_18;
        uint _e139 = local_19;
        local_53 = uint((_e138 + _e139));
        uint _e143 = local_53;
        out_.Store(_e143*4, asuint(naga_f2i32(_e126)));
        int _e145 = value;
        uint _e146 = local_1;
        local_23 = _e146;
        uint _e148 = local_23;
        local_24 = uint(_e148);
        uint _e151 = i;
        local_25 = uint(_e151);
        uint _e154 = local_24;
        uint _e155 = local_25;
        local_54 = uint((_e154 + _e155));
        uint _e160 = local_54;
        int _e162 = asint(input.Load(_e160*4));
        local_55 = _e162;
        int _e163 = local_55;
        const bool _e164 = differs(_e145, _e163);
        uint _e165 = local;
        local_20 = _e165;
        uint _e167 = local_20;
        local_21 = uint(_e167);
        uint _e170 = base;
        local_22 = uint((_e170 + 5u));
        uint _e176 = local_21;
        uint _e177 = local_22;
        local_56 = uint((_e176 + _e177));
        uint _e181 = local_56;
        out_.Store(_e181*4, asuint(int(_e164)));
        int _e183 = value;
        effect = _e183;
        bool _e185 = choose;
        int _e186 = effect;
        effect = asint(asuint(_e186) + asuint(int(1)));
        consume(_e185, _e186);
        int _e189 = effect;
        uint _e190 = local;
        local_26 = _e190;
        uint _e192 = local_26;
        local_27 = uint(_e192);
        uint _e195 = base;
        local_28 = uint((_e195 + 6u));
        uint _e200 = local_27;
        uint _e201 = local_28;
        local_57 = uint((_e200 + _e201));
        uint _e205 = local_57;
        out_.Store(_e205*4, asuint(_e189));
        bool _e207 = choose;
        int _e209 = effect;
        effect = asint(asuint(_e209) + asuint(int(1)));
        forward(!(_e207), _e209);
        int _e212 = effect;
        uint _e213 = local;
        local_29 = _e213;
        uint _e215 = local_29;
        local_30 = uint(_e215);
        uint _e218 = base;
        local_31 = uint((_e218 + 7u));
        uint _e223 = local_30;
        uint _e224 = local_31;
        local_58 = uint((_e223 + _e224));
        uint _e228 = local_58;
        out_.Store(_e228*4, asuint(_e212));
        int _e230 = effect;
        const int _e231 = advance(_e230);
        uint _e232 = local;
        local_32 = _e232;
        uint _e234 = local_32;
        local_33 = uint(_e234);
        uint _e237 = base;
        local_34 = uint((_e237 + 8u));
        uint _e242 = local_33;
        uint _e243 = local_34;
        local_59 = uint((_e242 + _e243));
        uint _e247 = local_59;
        out_.Store(_e247*4, asuint(_e231));
        int _e249 = effect;
        const uint _e253 = plus_one(uint(asint(asuint(_e249) + asuint(int(16)))));
        uint _e254 = local;
        local_35 = _e254;
        uint _e256 = local_35;
        local_36 = uint(_e256);
        uint _e259 = base;
        local_37 = uint((_e259 + 9u));
        uint _e265 = local_36;
        uint _e266 = local_37;
        local_60 = uint((_e265 + _e266));
        uint _e270 = local_60;
        out_.Store(_e270*4, asuint(int(_e253)));
        int _e272 = effect;
        uint _e273 = local_1;
        local_41 = _e273;
        uint _e275 = local_41;
        local_42 = uint(_e275);
        uint _e278 = i;
        local_43 = uint(_e278);
        uint _e281 = local_42;
        uint _e282 = local_43;
        local_61 = uint((_e281 + _e282));
        uint _e287 = local_61;
        int _e289 = asint(input.Load(_e287*4));
        local_62 = _e289;
        int _e290 = local_62;
        const bool _e291 = differs(_e272, _e290);
        uint _e292 = local;
        local_38 = _e292;
        uint _e294 = local_38;
        local_39 = uint(_e294);
        uint _e297 = base;
        local_40 = uint((_e297 + 10u));
        uint _e303 = local_39;
        uint _e304 = local_40;
        local_63 = uint((_e303 + _e304));
        uint _e308 = local_63;
        out_.Store(_e308*4, asuint(int(_e291)));
        int _e310 = effect;
        uint _e311 = local;
        local_44 = _e311;
        uint _e313 = local_44;
        local_45 = uint(_e313);
        uint _e316 = base;
        local_46 = uint((_e316 + 11u));
        uint _e321 = local_45;
        uint _e322 = local_46;
        local_64 = uint((_e321 + _e322));
        uint _e326 = local_64;
        out_.Store(_e326*4, asuint(_e310));
    }
}
