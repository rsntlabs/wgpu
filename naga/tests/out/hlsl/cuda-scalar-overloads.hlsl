struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n : register(b2) { type_5 n; }

bool classify(bool value_1)
{
    return !(value_1);
}

int classify_1(int value_2)
{
    return asint(asuint(value_2) + asuint(int(10)));
}

uint classify_2(uint value_3)
{
    return (value_3 + 20u);
}

float classify_3(float value_4)
{
    return ((value_4 * 1.5) + 0.5);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int rank(int left, float right)
{
    return asint(asuint(asint(asuint(left) * asuint(int(10)))) + asuint(naga_f2i32(right)));
}

int rank_1(float left_1, int right_1)
{
    return asint(asuint(asint(asuint(int(100)) + asuint(asint(asuint(naga_f2i32(left_1)) * asuint(int(10)))))) + asuint(right_1));
}

int pair(float left_2, int right_2)
{
    return asint(asuint(asint(asuint(naga_f2i32(left_2)) * asuint(int(10)))) + asuint(right_2));
}

int promote(uint left_3, float right_3)
{
    return asint(asuint(asint(asuint(int(200)) + asuint(int(left_3)))) + asuint(naga_f2i32(right_3)));
}

void touch(bool stop, int value_5)
{
    int value_6 = (int)0;

    value_6 = value_5;
    if (stop) {
        return;
    }
    int _e3 = value_6;
    const int _e4 = classify_1(_e3);
    value_6 = _e4;
    return;
}

int touch_1(int value_7)
{
    const int _e1 = classify_1(value_7);
    return asint(asuint(_e1) + asuint(int(3)));
}

int stage(int value_8)
{
    return asint(asuint(value_8) + asuint(int(2)));
}

int frozen(float value_9)
{
    const int _e2 = stage(naga_f2i32(value_9));
    return _e2;
}

int stage_1(float value_10)
{
    return asint(asuint(naga_f2i32(value_10)) + asuint(int(100)));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void scalar_overloads(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
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
    int nested = (int)0;
    uint local_12 = (uint)0;
    int argument = (int)0;
    int captured = (int)0;
    uint local_13 = (uint)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    int local_16 = (int)0;
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

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 13u);
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = asint(input.Load(_e17*4));
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = (naga_mod(i, 2u) == 0u);
        bool _e31 = choose;
        const bool _e32 = classify(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e36 = local_1;
        local_17 = _e36;
        uint _e38 = local_17;
        out_.Store(_e38*4, asuint(int(_e32)));
        int _e41 = value;
        const int _e42 = classify_1(_e41);
        uint _e43 = base;
        local_2 = uint((_e43 + 1u));
        uint _e48 = local_2;
        local_18 = _e48;
        uint _e50 = local_18;
        out_.Store(_e50*4, asuint(_e42));
        int _e52 = value;
        const uint _e56 = classify_2(uint(asint(asuint(_e52) + asuint(int(16)))));
        uint _e57 = base;
        local_3 = uint((_e57 + 2u));
        uint _e63 = local_3;
        local_19 = _e63;
        uint _e65 = local_19;
        out_.Store(_e65*4, asuint(int(_e56)));
        int _e67 = value;
        const float _e69 = classify_3(float(_e67));
        uint _e70 = base;
        local_4 = uint((_e70 + 3u));
        uint _e76 = local_4;
        local_20 = _e76;
        uint _e78 = local_20;
        out_.Store(_e78*4, asuint(naga_f2i32(_e69)));
        bool _e80 = choose;
        int _e81 = value;
        const int _e86 = rank(int(_e80), (float(_e81) + 0.5));
        uint _e87 = base;
        local_5 = uint((_e87 + 4u));
        uint _e92 = local_5;
        local_21 = _e92;
        uint _e94 = local_21;
        out_.Store(_e94*4, asuint(_e86));
        int _e96 = value;
        bool _e100 = choose;
        const int _e102 = rank_1((float(_e96) + 0.5), int(_e100));
        uint _e103 = base;
        local_6 = uint((_e103 + 5u));
        uint _e108 = local_6;
        local_22 = _e108;
        uint _e110 = local_22;
        out_.Store(_e110*4, asuint(_e102));
        int _e112 = value;
        int _e116 = value;
        const int _e118 = promote(uint(asint(asuint(_e112) + asuint(int(16)))), float(_e116));
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e124 = local_7;
        local_23 = _e124;
        uint _e126 = local_23;
        out_.Store(_e126*4, asuint(_e118));
        int _e128 = value;
        effect = _e128;
        bool _e130 = choose;
        int _e131 = effect;
        effect = asint(asuint(_e131) + asuint(int(1)));
        touch(_e130, _e131);
        int _e134 = effect;
        uint _e135 = base;
        local_8 = uint((_e135 + 7u));
        uint _e140 = local_8;
        local_24 = _e140;
        uint _e142 = local_24;
        out_.Store(_e142*4, asuint(_e134));
        int _e144 = effect;
        const int _e145 = touch_1(_e144);
        uint _e146 = base;
        local_9 = uint((_e146 + 8u));
        uint _e151 = local_9;
        local_25 = _e151;
        uint _e153 = local_25;
        out_.Store(_e153*4, asuint(_e145));
        int _e155 = value;
        const int _e159 = frozen((float(_e155) + 0.75));
        uint _e160 = base;
        local_10 = uint((_e160 + 9u));
        uint _e165 = local_10;
        local_26 = _e165;
        uint _e167 = local_26;
        out_.Store(_e167*4, asuint(_e159));
        int _e169 = value;
        const int _e173 = stage_1((float(_e169) + 0.75));
        uint _e174 = base;
        local_11 = uint((_e174 + 10u));
        uint _e179 = local_11;
        local_27 = _e179;
        uint _e181 = local_27;
        out_.Store(_e181*4, asuint(_e173));
        int _e183 = effect;
        effect = asint(asuint(_e183) + asuint(int(1)));
        const int _e186 = classify_1(_e183);
        const int _e187 = touch_1(_e186);
        nested = _e187;
        int _e189 = nested;
        int _e192 = effect;
        uint _e194 = base;
        local_12 = uint((_e194 + 11u));
        uint _e199 = local_12;
        local_28 = _e199;
        uint _e201 = local_28;
        out_.Store(_e201*4, asuint(asint(asuint(asint(asuint(_e189) * asuint(int(10)))) + asuint(_e192))));
        int _e203 = value;
        argument = asint(asuint(_e203) + asuint(int(8)));
        int _e207 = argument;
        int _e208 = argument;
        argument = asint(asuint(_e208) + asuint(int(1)));
        const int _e212 = pair(float(_e207), _e208);
        captured = _e212;
        int _e214 = captured;
        int _e217 = argument;
        uint _e219 = base;
        local_13 = uint((_e219 + 12u));
        uint _e224 = local_13;
        local_29 = _e224;
        uint _e226 = local_29;
        out_.Store(_e226*4, asuint(asint(asuint(asint(asuint(_e214) * asuint(int(100)))) + asuint(_e217))));
    }
}
