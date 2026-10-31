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

int doubled(int value_3)
{
    const int _e1 = increment(value_3);
    return asint(asuint(_e1) * asuint(int(2)));
}

uint advance(uint value_4)
{
    return (value_4 + 3u);
}

uint retreat(uint value_5)
{
    return (value_5 - 1u);
}

float scale(float value_6, int bias)
{
    return ((value_6 * 1.5) + float(bias));
}

bool same(int left, int right)
{
    return (left == right);
}

void consume(bool stop, int value_7)
{
    int value_8 = (int)0;

    value_8 = value_7;
    if (stop) {
        return;
    }
    int _e3 = value_8;
    const int _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

void forward(bool stop_1, int value_9)
{
    const int _e2 = increment(value_9);
    consume(stop_1, _e2);
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
    uint base = (uint)0;
    int value = (int)0;
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
    uint local_26 = (uint)0;
    int local_27 = (int)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    int local_32 = (int)0;
    uint local_33 = (uint)0;
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
        int _e26 = value;
        const int _e27 = increment(_e26);
        uint _e28 = base;
        local_1 = _e28;
        uint _e30 = local_1;
        local_20 = _e30;
        uint _e32 = local_20;
        out_.Store(_e32*4, asuint(_e27));
        int _e35 = value;
        uint _e36 = base;
        local_2 = uint((_e36 + 1u));
        uint _e41 = local_2;
        local_21 = _e41;
        uint _e43 = local_21;
        out_.Store(_e43*4, asuint(_e35));
        int _e45 = value;
        const int _e46 = doubled(_e45);
        uint _e47 = base;
        local_3 = uint((_e47 + 2u));
        uint _e52 = local_3;
        local_22 = _e52;
        uint _e54 = local_22;
        out_.Store(_e54*4, asuint(_e46));
        int _e56 = value;
        const uint _e58 = advance(uint(_e56));
        uint _e59 = base;
        local_4 = uint((_e59 + 3u));
        uint _e65 = local_4;
        local_23 = _e65;
        uint _e67 = local_23;
        out_.Store(_e67*4, asuint(int(_e58)));
        int _e69 = value;
        const uint _e71 = retreat(uint(_e69));
        uint _e72 = base;
        local_5 = uint((_e72 + 4u));
        uint _e78 = local_5;
        local_24 = _e78;
        uint _e80 = local_24;
        out_.Store(_e80*4, asuint(int(_e71)));
        int _e82 = value;
        const float _e85 = scale(float(_e82), int(2));
        uint _e86 = base;
        local_6 = uint((_e86 + 5u));
        uint _e92 = local_6;
        local_25 = _e92;
        uint _e94 = local_25;
        out_.Store(_e94*4, asuint(naga_f2i32(_e85)));
        int _e96 = value;
        local_8 = i;
        uint _e98 = local_8;
        local_26 = _e98;
        uint _e100 = local_26;
        int _e102 = asint(input.Load(_e100*4));
        local_27 = _e102;
        int _e104 = local_27;
        local_16 = _e104;
        int _e106 = local_16;
        const bool _e107 = same(_e96, _e106);
        uint _e108 = base;
        local_7 = uint((_e108 + 6u));
        uint _e114 = local_7;
        local_28 = _e114;
        uint _e116 = local_28;
        out_.Store(_e116*4, asuint(int(_e107)));
        int _e122 = value;
        value = asint(asuint(_e122) + asuint(int(1)));
        consume((naga_mod(i, 2u) == 0u), _e122);
        int _e125 = value;
        uint _e126 = base;
        local_9 = uint((_e126 + 7u));
        uint _e131 = local_9;
        local_29 = _e131;
        uint _e133 = local_29;
        out_.Store(_e133*4, asuint(_e125));
        int _e139 = value;
        value = asint(asuint(_e139) + asuint(int(1)));
        forward((naga_mod(i, 2u) != 0u), _e139);
        int _e142 = value;
        uint _e143 = base;
        local_10 = uint((_e143 + 8u));
        uint _e148 = local_10;
        local_30 = _e148;
        uint _e150 = local_30;
        out_.Store(_e150*4, asuint(_e142));
        int _e152 = value;
        local_12 = i;
        uint _e154 = local_12;
        local_31 = _e154;
        uint _e156 = local_31;
        int _e158 = asint(input.Load(_e156*4));
        local_32 = _e158;
        int _e160 = local_32;
        local_17 = _e160;
        int _e162 = local_17;
        const bool _e163 = same(_e152, _e162);
        uint _e164 = base;
        local_11 = uint((_e164 + 9u));
        uint _e170 = local_11;
        local_33 = _e170;
        uint _e172 = local_33;
        out_.Store(_e172*4, asuint(int(_e163)));
        int _e174 = value;
        const int _e175 = increment(_e174);
        const int _e176 = increment(_e175);
        uint _e177 = base;
        local_13 = uint((_e177 + 10u));
        uint _e182 = local_13;
        local_34 = _e182;
        uint _e184 = local_34;
        out_.Store(_e184*4, asuint(_e176));
        int _e186 = value;
        uint _e187 = base;
        local_14 = uint((_e187 + 11u));
        uint _e192 = local_14;
        local_35 = _e192;
        uint _e194 = local_35;
        out_.Store(_e194*4, asuint(_e186));
    }
}
