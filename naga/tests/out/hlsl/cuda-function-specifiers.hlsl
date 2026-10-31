struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
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

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void function_specifiers(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    bool choose = (bool)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int effect = (int)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    int local_15 = (int)0;
    int local_16 = (int)0;
    int local_17 = (int)0;
    uint local_18 = (uint)0;
    int local_19 = (int)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    int local_26 = (int)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    int local_33 = (int)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = i;
        uint _e15 = local;
        local_18 = _e15;
        uint _e17 = local_18;
        int _e20 = asint(input.Load(_e17*4));
        local_19 = _e20;
        int _e22 = local_19;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        choose = (naga_mod(i, 2u) == 0u);
        int _e31 = value;
        const int _e32 = increment(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e35 = local_1;
        local_20 = _e35;
        uint _e37 = local_20;
        out_.Store(_e37*4, asuint(_e32));
        int _e40 = value;
        const int _e41 = twice(_e40);
        uint _e42 = base;
        local_2 = uint((_e42 + 1u));
        uint _e47 = local_2;
        local_21 = _e47;
        uint _e49 = local_21;
        out_.Store(_e49*4, asuint(_e41));
        int _e51 = value;
        const int _e52 = advance(_e51);
        uint _e53 = base;
        local_3 = uint((_e53 + 2u));
        uint _e58 = local_3;
        local_22 = _e58;
        uint _e60 = local_22;
        out_.Store(_e60*4, asuint(_e52));
        int _e62 = value;
        const int _e63 = retreat(_e62);
        uint _e64 = base;
        local_4 = uint((_e64 + 3u));
        uint _e69 = local_4;
        local_23 = _e69;
        uint _e71 = local_23;
        out_.Store(_e71*4, asuint(_e63));
        int _e73 = value;
        const float _e75 = scaled(float(_e73));
        uint _e76 = base;
        local_5 = uint((_e76 + 4u));
        uint _e82 = local_5;
        local_24 = _e82;
        uint _e84 = local_24;
        out_.Store(_e84*4, asuint(naga_f2i32(_e75)));
        int _e86 = value;
        local_7 = i;
        uint _e88 = local_7;
        local_25 = _e88;
        uint _e90 = local_25;
        int _e92 = asint(input.Load(_e90*4));
        local_26 = _e92;
        int _e94 = local_26;
        local_16 = _e94;
        int _e96 = local_16;
        const bool _e97 = differs(_e86, _e96);
        uint _e98 = base;
        local_6 = uint((_e98 + 5u));
        uint _e104 = local_6;
        local_27 = _e104;
        uint _e106 = local_27;
        out_.Store(_e106*4, asuint(int(_e97)));
        int _e108 = value;
        effect = _e108;
        bool _e110 = choose;
        int _e111 = effect;
        effect = asint(asuint(_e111) + asuint(int(1)));
        consume(_e110, _e111);
        int _e114 = effect;
        uint _e115 = base;
        local_8 = uint((_e115 + 6u));
        uint _e120 = local_8;
        local_28 = _e120;
        uint _e122 = local_28;
        out_.Store(_e122*4, asuint(_e114));
        bool _e124 = choose;
        int _e126 = effect;
        effect = asint(asuint(_e126) + asuint(int(1)));
        forward(!(_e124), _e126);
        int _e129 = effect;
        uint _e130 = base;
        local_9 = uint((_e130 + 7u));
        uint _e135 = local_9;
        local_29 = _e135;
        uint _e137 = local_29;
        out_.Store(_e137*4, asuint(_e129));
        int _e139 = effect;
        const int _e140 = advance(_e139);
        uint _e141 = base;
        local_10 = uint((_e141 + 8u));
        uint _e146 = local_10;
        local_30 = _e146;
        uint _e148 = local_30;
        out_.Store(_e148*4, asuint(_e140));
        int _e150 = effect;
        const uint _e154 = plus_one(uint(asint(asuint(_e150) + asuint(int(16)))));
        uint _e155 = base;
        local_11 = uint((_e155 + 9u));
        uint _e161 = local_11;
        local_31 = _e161;
        uint _e163 = local_31;
        out_.Store(_e163*4, asuint(int(_e154)));
        int _e165 = effect;
        local_13 = i;
        uint _e167 = local_13;
        local_32 = _e167;
        uint _e169 = local_32;
        int _e171 = asint(input.Load(_e169*4));
        local_33 = _e171;
        int _e173 = local_33;
        local_17 = _e173;
        int _e175 = local_17;
        const bool _e176 = differs(_e165, _e175);
        uint _e177 = base;
        local_12 = uint((_e177 + 10u));
        uint _e183 = local_12;
        local_34 = _e183;
        uint _e185 = local_34;
        out_.Store(_e185*4, asuint(int(_e176)));
        int _e187 = effect;
        uint _e188 = base;
        local_14 = uint((_e188 + 11u));
        uint _e193 = local_14;
        local_35 = _e193;
        uint _e195 = local_35;
        out_.Store(_e195*4, asuint(_e187));
    }
}
