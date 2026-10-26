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

int doubled(int value_3)
{
    int value_4 = (int)0;

    value_4 = value_3;
    int _e2 = value_4;
    const int _e3 = increment(_e2);
    return asint(asuint(_e3) * asuint(int(2)));
}

uint advance(uint value_5)
{
    uint value_6 = (uint)0;

    value_6 = value_5;
    uint _e3 = value_6;
    return (_e3 + 3u);
}

uint retreat(uint value_7)
{
    uint value_8 = (uint)0;

    value_8 = value_7;
    uint _e3 = value_8;
    return (_e3 - 1u);
}

float scale(float value_9, int bias)
{
    float value_10 = (float)0;
    int bias_1 = (int)0;

    value_10 = value_9;
    bias_1 = bias;
    float _e5 = value_10;
    int _e7 = bias_1;
    return ((_e5 * 1.5) + float(_e7));
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
    const int _e6 = increment(_e5);
    consume(_e4, _e6);
    return;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void inline_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
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
    uint local_55 = (uint)0;
    int local_56 = (int)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    int local_61 = (int)0;
    uint local_62 = (uint)0;
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
        int _e43 = value;
        const int _e44 = increment(_e43);
        uint _e45 = local;
        local_5 = _e45;
        uint _e47 = local_5;
        local_6 = uint(_e47);
        uint _e50 = base;
        local_7 = uint(_e50);
        uint _e54 = local_6;
        uint _e55 = local_7;
        local_49 = uint((_e54 + _e55));
        uint _e59 = local_49;
        out_.Store(_e59*4, asuint(_e44));
        int _e61 = value;
        uint _e62 = local;
        local_8 = _e62;
        uint _e64 = local_8;
        local_9 = uint(_e64);
        uint _e67 = base;
        local_10 = uint((_e67 + 1u));
        uint _e72 = local_9;
        uint _e73 = local_10;
        local_50 = uint((_e72 + _e73));
        uint _e77 = local_50;
        out_.Store(_e77*4, asuint(_e61));
        int _e79 = value;
        const int _e80 = doubled(_e79);
        uint _e81 = local;
        local_11 = _e81;
        uint _e83 = local_11;
        local_12 = uint(_e83);
        uint _e86 = base;
        local_13 = uint((_e86 + 2u));
        uint _e91 = local_12;
        uint _e92 = local_13;
        local_51 = uint((_e91 + _e92));
        uint _e96 = local_51;
        out_.Store(_e96*4, asuint(_e80));
        int _e98 = value;
        const uint _e100 = advance(uint(_e98));
        uint _e101 = local;
        local_14 = _e101;
        uint _e103 = local_14;
        local_15 = uint(_e103);
        uint _e106 = base;
        local_16 = uint((_e106 + 3u));
        uint _e112 = local_15;
        uint _e113 = local_16;
        local_52 = uint((_e112 + _e113));
        uint _e117 = local_52;
        out_.Store(_e117*4, asuint(int(_e100)));
        int _e119 = value;
        const uint _e121 = retreat(uint(_e119));
        uint _e122 = local;
        local_17 = _e122;
        uint _e124 = local_17;
        local_18 = uint(_e124);
        uint _e127 = base;
        local_19 = uint((_e127 + 4u));
        uint _e133 = local_18;
        uint _e134 = local_19;
        local_53 = uint((_e133 + _e134));
        uint _e138 = local_53;
        out_.Store(_e138*4, asuint(int(_e121)));
        int _e140 = value;
        const float _e143 = scale(float(_e140), int(2));
        uint _e144 = local;
        local_20 = _e144;
        uint _e146 = local_20;
        local_21 = uint(_e146);
        uint _e149 = base;
        local_22 = uint((_e149 + 5u));
        uint _e155 = local_21;
        uint _e156 = local_22;
        local_54 = uint((_e155 + _e156));
        uint _e160 = local_54;
        out_.Store(_e160*4, asuint(naga_f2i32(_e143)));
        int _e162 = value;
        uint _e163 = local_1;
        local_26 = _e163;
        uint _e165 = local_26;
        local_27 = uint(_e165);
        uint _e168 = i;
        local_28 = uint(_e168);
        uint _e171 = local_27;
        uint _e172 = local_28;
        local_55 = uint((_e171 + _e172));
        uint _e177 = local_55;
        int _e179 = asint(input.Load(_e177*4));
        local_56 = _e179;
        int _e180 = local_56;
        const bool _e181 = same(_e162, _e180);
        uint _e182 = local;
        local_23 = _e182;
        uint _e184 = local_23;
        local_24 = uint(_e184);
        uint _e187 = base;
        local_25 = uint((_e187 + 6u));
        uint _e193 = local_24;
        uint _e194 = local_25;
        local_57 = uint((_e193 + _e194));
        uint _e198 = local_57;
        out_.Store(_e198*4, asuint(int(_e181)));
        uint _e200 = i;
        int _e205 = value;
        value = asint(asuint(_e205) + asuint(int(1)));
        consume((naga_mod(_e200, 2u) == 0u), _e205);
        int _e208 = value;
        uint _e209 = local;
        local_29 = _e209;
        uint _e211 = local_29;
        local_30 = uint(_e211);
        uint _e214 = base;
        local_31 = uint((_e214 + 7u));
        uint _e219 = local_30;
        uint _e220 = local_31;
        local_58 = uint((_e219 + _e220));
        uint _e224 = local_58;
        out_.Store(_e224*4, asuint(_e208));
        uint _e226 = i;
        int _e231 = value;
        value = asint(asuint(_e231) + asuint(int(1)));
        forward((naga_mod(_e226, 2u) != 0u), _e231);
        int _e234 = value;
        uint _e235 = local;
        local_32 = _e235;
        uint _e237 = local_32;
        local_33 = uint(_e237);
        uint _e240 = base;
        local_34 = uint((_e240 + 8u));
        uint _e245 = local_33;
        uint _e246 = local_34;
        local_59 = uint((_e245 + _e246));
        uint _e250 = local_59;
        out_.Store(_e250*4, asuint(_e234));
        int _e252 = value;
        uint _e253 = local_1;
        local_38 = _e253;
        uint _e255 = local_38;
        local_39 = uint(_e255);
        uint _e258 = i;
        local_40 = uint(_e258);
        uint _e261 = local_39;
        uint _e262 = local_40;
        local_60 = uint((_e261 + _e262));
        uint _e267 = local_60;
        int _e269 = asint(input.Load(_e267*4));
        local_61 = _e269;
        int _e270 = local_61;
        const bool _e271 = same(_e252, _e270);
        uint _e272 = local;
        local_35 = _e272;
        uint _e274 = local_35;
        local_36 = uint(_e274);
        uint _e277 = base;
        local_37 = uint((_e277 + 9u));
        uint _e283 = local_36;
        uint _e284 = local_37;
        local_62 = uint((_e283 + _e284));
        uint _e288 = local_62;
        out_.Store(_e288*4, asuint(int(_e271)));
        int _e290 = value;
        const int _e291 = increment(_e290);
        const int _e292 = increment(_e291);
        uint _e293 = local;
        local_41 = _e293;
        uint _e295 = local_41;
        local_42 = uint(_e295);
        uint _e298 = base;
        local_43 = uint((_e298 + 10u));
        uint _e303 = local_42;
        uint _e304 = local_43;
        local_63 = uint((_e303 + _e304));
        uint _e308 = local_63;
        out_.Store(_e308*4, asuint(_e292));
        int _e310 = value;
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
