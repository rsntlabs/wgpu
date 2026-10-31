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
        int _e28 = value;
        const int _e29 = increment(_e28);
        uint _e30 = base;
        local_1 = uint(_e30);
        uint _e33 = local_1;
        local_20 = uint(_e33);
        uint _e36 = local_20;
        out_.Store(_e36*4, asuint(_e29));
        int _e39 = value;
        uint _e40 = base;
        local_2 = uint((_e40 + 1u));
        uint _e45 = local_2;
        local_21 = uint(_e45);
        uint _e48 = local_21;
        out_.Store(_e48*4, asuint(_e39));
        int _e50 = value;
        const int _e51 = doubled(_e50);
        uint _e52 = base;
        local_3 = uint((_e52 + 2u));
        uint _e57 = local_3;
        local_22 = uint(_e57);
        uint _e60 = local_22;
        out_.Store(_e60*4, asuint(_e51));
        int _e62 = value;
        const uint _e64 = advance(uint(_e62));
        uint _e65 = base;
        local_4 = uint((_e65 + 3u));
        uint _e71 = local_4;
        local_23 = uint(_e71);
        uint _e74 = local_23;
        out_.Store(_e74*4, asuint(int(_e64)));
        int _e76 = value;
        const uint _e78 = retreat(uint(_e76));
        uint _e79 = base;
        local_5 = uint((_e79 + 4u));
        uint _e85 = local_5;
        local_24 = uint(_e85);
        uint _e88 = local_24;
        out_.Store(_e88*4, asuint(int(_e78)));
        int _e90 = value;
        const float _e93 = scale(float(_e90), int(2));
        uint _e94 = base;
        local_6 = uint((_e94 + 5u));
        uint _e100 = local_6;
        local_25 = uint(_e100);
        uint _e103 = local_25;
        out_.Store(_e103*4, asuint(naga_f2i32(_e93)));
        int _e105 = value;
        local_8 = uint(i);
        uint _e108 = local_8;
        local_26 = uint(_e108);
        uint _e111 = local_26;
        int _e113 = asint(input.Load(_e111*4));
        local_27 = _e113;
        int _e115 = local_27;
        local_16 = _e115;
        int _e117 = local_16;
        const bool _e118 = same(_e105, _e117);
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e125 = local_7;
        local_28 = uint(_e125);
        uint _e128 = local_28;
        out_.Store(_e128*4, asuint(int(_e118)));
        int _e134 = value;
        value = asint(asuint(_e134) + asuint(int(1)));
        consume((naga_mod(i, 2u) == 0u), _e134);
        int _e137 = value;
        uint _e138 = base;
        local_9 = uint((_e138 + 7u));
        uint _e143 = local_9;
        local_29 = uint(_e143);
        uint _e146 = local_29;
        out_.Store(_e146*4, asuint(_e137));
        int _e152 = value;
        value = asint(asuint(_e152) + asuint(int(1)));
        forward((naga_mod(i, 2u) != 0u), _e152);
        int _e155 = value;
        uint _e156 = base;
        local_10 = uint((_e156 + 8u));
        uint _e161 = local_10;
        local_30 = uint(_e161);
        uint _e164 = local_30;
        out_.Store(_e164*4, asuint(_e155));
        int _e166 = value;
        local_12 = uint(i);
        uint _e169 = local_12;
        local_31 = uint(_e169);
        uint _e172 = local_31;
        int _e174 = asint(input.Load(_e172*4));
        local_32 = _e174;
        int _e176 = local_32;
        local_17 = _e176;
        int _e178 = local_17;
        const bool _e179 = same(_e166, _e178);
        uint _e180 = base;
        local_11 = uint((_e180 + 9u));
        uint _e186 = local_11;
        local_33 = uint(_e186);
        uint _e189 = local_33;
        out_.Store(_e189*4, asuint(int(_e179)));
        int _e191 = value;
        const int _e192 = increment(_e191);
        const int _e193 = increment(_e192);
        uint _e194 = base;
        local_13 = uint((_e194 + 10u));
        uint _e199 = local_13;
        local_34 = uint(_e199);
        uint _e202 = local_34;
        out_.Store(_e202*4, asuint(_e193));
        int _e204 = value;
        uint _e205 = base;
        local_14 = uint((_e205 + 11u));
        uint _e210 = local_14;
        local_35 = uint(_e210);
        uint _e213 = local_35;
        out_.Store(_e213*4, asuint(_e204));
    }
}
