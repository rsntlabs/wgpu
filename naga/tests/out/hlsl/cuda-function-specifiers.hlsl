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
        local = uint(i);
        uint _e16 = local;
        local_18 = uint(_e16);
        uint _e19 = local_18;
        int _e22 = asint(input.Load(_e19*4));
        local_19 = _e22;
        int _e24 = local_19;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        choose = (naga_mod(i, 2u) == 0u);
        int _e33 = value;
        const int _e34 = increment(_e33);
        uint _e35 = base;
        local_1 = uint(_e35);
        uint _e38 = local_1;
        local_20 = uint(_e38);
        uint _e41 = local_20;
        out_.Store(_e41*4, asuint(_e34));
        int _e44 = value;
        const int _e45 = twice(_e44);
        uint _e46 = base;
        local_2 = uint((_e46 + 1u));
        uint _e51 = local_2;
        local_21 = uint(_e51);
        uint _e54 = local_21;
        out_.Store(_e54*4, asuint(_e45));
        int _e56 = value;
        const int _e57 = advance(_e56);
        uint _e58 = base;
        local_3 = uint((_e58 + 2u));
        uint _e63 = local_3;
        local_22 = uint(_e63);
        uint _e66 = local_22;
        out_.Store(_e66*4, asuint(_e57));
        int _e68 = value;
        const int _e69 = retreat(_e68);
        uint _e70 = base;
        local_4 = uint((_e70 + 3u));
        uint _e75 = local_4;
        local_23 = uint(_e75);
        uint _e78 = local_23;
        out_.Store(_e78*4, asuint(_e69));
        int _e80 = value;
        const float _e82 = scaled(float(_e80));
        uint _e83 = base;
        local_5 = uint((_e83 + 4u));
        uint _e89 = local_5;
        local_24 = uint(_e89);
        uint _e92 = local_24;
        out_.Store(_e92*4, asuint(naga_f2i32(_e82)));
        int _e94 = value;
        local_7 = uint(i);
        uint _e97 = local_7;
        local_25 = uint(_e97);
        uint _e100 = local_25;
        int _e102 = asint(input.Load(_e100*4));
        local_26 = _e102;
        int _e104 = local_26;
        local_16 = _e104;
        int _e106 = local_16;
        const bool _e107 = differs(_e94, _e106);
        uint _e108 = base;
        local_6 = uint((_e108 + 5u));
        uint _e114 = local_6;
        local_27 = uint(_e114);
        uint _e117 = local_27;
        out_.Store(_e117*4, asuint(int(_e107)));
        int _e119 = value;
        effect = _e119;
        bool _e121 = choose;
        int _e122 = effect;
        effect = asint(asuint(_e122) + asuint(int(1)));
        consume(_e121, _e122);
        int _e125 = effect;
        uint _e126 = base;
        local_8 = uint((_e126 + 6u));
        uint _e131 = local_8;
        local_28 = uint(_e131);
        uint _e134 = local_28;
        out_.Store(_e134*4, asuint(_e125));
        bool _e136 = choose;
        int _e138 = effect;
        effect = asint(asuint(_e138) + asuint(int(1)));
        forward(!(_e136), _e138);
        int _e141 = effect;
        uint _e142 = base;
        local_9 = uint((_e142 + 7u));
        uint _e147 = local_9;
        local_29 = uint(_e147);
        uint _e150 = local_29;
        out_.Store(_e150*4, asuint(_e141));
        int _e152 = effect;
        const int _e153 = advance(_e152);
        uint _e154 = base;
        local_10 = uint((_e154 + 8u));
        uint _e159 = local_10;
        local_30 = uint(_e159);
        uint _e162 = local_30;
        out_.Store(_e162*4, asuint(_e153));
        int _e164 = effect;
        const uint _e168 = plus_one(uint(asint(asuint(_e164) + asuint(int(16)))));
        uint _e169 = base;
        local_11 = uint((_e169 + 9u));
        uint _e175 = local_11;
        local_31 = uint(_e175);
        uint _e178 = local_31;
        out_.Store(_e178*4, asuint(int(_e168)));
        int _e180 = effect;
        local_13 = uint(i);
        uint _e183 = local_13;
        local_32 = uint(_e183);
        uint _e186 = local_32;
        int _e188 = asint(input.Load(_e186*4));
        local_33 = _e188;
        int _e190 = local_33;
        local_17 = _e190;
        int _e192 = local_17;
        const bool _e193 = differs(_e180, _e192);
        uint _e194 = base;
        local_12 = uint((_e194 + 10u));
        uint _e200 = local_12;
        local_34 = uint(_e200);
        uint _e203 = local_34;
        out_.Store(_e203*4, asuint(int(_e193)));
        int _e205 = effect;
        uint _e206 = base;
        local_14 = uint((_e206 + 11u));
        uint _e211 = local_14;
        local_35 = uint(_e211);
        uint _e214 = local_35;
        out_.Store(_e214*4, asuint(_e205));
    }
}
