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
        local = uint(i);
        uint _e16 = local;
        local_15 = uint(_e16);
        uint _e19 = local_15;
        int _e22 = asint(input.Load(_e19*4));
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = (naga_mod(i, 2u) == 0u);
        bool _e33 = choose;
        const bool _e34 = classify(_e33);
        uint _e35 = base;
        local_1 = uint(_e35);
        uint _e39 = local_1;
        local_17 = uint(_e39);
        uint _e42 = local_17;
        out_.Store(_e42*4, asuint(int(_e34)));
        int _e45 = value;
        const int _e46 = classify_1(_e45);
        uint _e47 = base;
        local_2 = uint((_e47 + 1u));
        uint _e52 = local_2;
        local_18 = uint(_e52);
        uint _e55 = local_18;
        out_.Store(_e55*4, asuint(_e46));
        int _e57 = value;
        const uint _e61 = classify_2(uint(asint(asuint(_e57) + asuint(int(16)))));
        uint _e62 = base;
        local_3 = uint((_e62 + 2u));
        uint _e68 = local_3;
        local_19 = uint(_e68);
        uint _e71 = local_19;
        out_.Store(_e71*4, asuint(int(_e61)));
        int _e73 = value;
        const float _e75 = classify_3(float(_e73));
        uint _e76 = base;
        local_4 = uint((_e76 + 3u));
        uint _e82 = local_4;
        local_20 = uint(_e82);
        uint _e85 = local_20;
        out_.Store(_e85*4, asuint(naga_f2i32(_e75)));
        bool _e87 = choose;
        int _e88 = value;
        const int _e93 = rank(int(_e87), (float(_e88) + 0.5));
        uint _e94 = base;
        local_5 = uint((_e94 + 4u));
        uint _e99 = local_5;
        local_21 = uint(_e99);
        uint _e102 = local_21;
        out_.Store(_e102*4, asuint(_e93));
        int _e104 = value;
        bool _e108 = choose;
        const int _e110 = rank_1((float(_e104) + 0.5), int(_e108));
        uint _e111 = base;
        local_6 = uint((_e111 + 5u));
        uint _e116 = local_6;
        local_22 = uint(_e116);
        uint _e119 = local_22;
        out_.Store(_e119*4, asuint(_e110));
        int _e121 = value;
        int _e125 = value;
        const int _e127 = promote(uint(asint(asuint(_e121) + asuint(int(16)))), float(_e125));
        uint _e128 = base;
        local_7 = uint((_e128 + 6u));
        uint _e133 = local_7;
        local_23 = uint(_e133);
        uint _e136 = local_23;
        out_.Store(_e136*4, asuint(_e127));
        int _e138 = value;
        effect = _e138;
        bool _e140 = choose;
        int _e141 = effect;
        effect = asint(asuint(_e141) + asuint(int(1)));
        touch(_e140, _e141);
        int _e144 = effect;
        uint _e145 = base;
        local_8 = uint((_e145 + 7u));
        uint _e150 = local_8;
        local_24 = uint(_e150);
        uint _e153 = local_24;
        out_.Store(_e153*4, asuint(_e144));
        int _e155 = effect;
        const int _e156 = touch_1(_e155);
        uint _e157 = base;
        local_9 = uint((_e157 + 8u));
        uint _e162 = local_9;
        local_25 = uint(_e162);
        uint _e165 = local_25;
        out_.Store(_e165*4, asuint(_e156));
        int _e167 = value;
        const int _e171 = frozen((float(_e167) + 0.75));
        uint _e172 = base;
        local_10 = uint((_e172 + 9u));
        uint _e177 = local_10;
        local_26 = uint(_e177);
        uint _e180 = local_26;
        out_.Store(_e180*4, asuint(_e171));
        int _e182 = value;
        const int _e186 = stage_1((float(_e182) + 0.75));
        uint _e187 = base;
        local_11 = uint((_e187 + 10u));
        uint _e192 = local_11;
        local_27 = uint(_e192);
        uint _e195 = local_27;
        out_.Store(_e195*4, asuint(_e186));
        int _e197 = effect;
        effect = asint(asuint(_e197) + asuint(int(1)));
        const int _e200 = classify_1(_e197);
        const int _e201 = touch_1(_e200);
        nested = _e201;
        int _e203 = nested;
        int _e206 = effect;
        uint _e208 = base;
        local_12 = uint((_e208 + 11u));
        uint _e213 = local_12;
        local_28 = uint(_e213);
        uint _e216 = local_28;
        out_.Store(_e216*4, asuint(asint(asuint(asint(asuint(_e203) * asuint(int(10)))) + asuint(_e206))));
        int _e218 = value;
        argument = asint(asuint(_e218) + asuint(int(8)));
        int _e222 = argument;
        int _e223 = argument;
        argument = asint(asuint(_e223) + asuint(int(1)));
        const int _e227 = pair(float(_e222), _e223);
        captured = _e227;
        int _e229 = captured;
        int _e232 = argument;
        uint _e234 = base;
        local_13 = uint((_e234 + 12u));
        uint _e239 = local_13;
        local_29 = uint(_e239);
        uint _e242 = local_29;
        out_.Store(_e242*4, asuint(asint(asuint(asint(asuint(_e229) * asuint(int(100)))) + asuint(_e232))));
    }
}
