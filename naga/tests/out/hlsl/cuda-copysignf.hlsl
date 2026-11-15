ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

float copied(float value, float sign_)
{
    return asfloat(((asuint(value) & 2147483647u) | (asuint(sign_) & 2147483648u)));
}

int copysignf(bool value_1, bool sign_1)
{
    int local_22 = (int)0;

    if (value_1) {
        local_22 = int(7);
    } else {
        local_22 = int(9);
    }
    int _e6 = local_22;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(32, 1, 1)]
void copy_signs(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
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
    int cursor = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    bool run = (bool)0;
    bool local_15 = (bool)0;
    bool local_16 = (bool)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    float local_19 = (float)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 912u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float value_2 = asfloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float sign_2 = asfloat(_e30);
    output.Store(base*4, asuint(asuint(asfloat(((asuint(value_2) & 2147483647u) | (asuint(sign_2) & 2147483648u))))));
    const float _e43 = copied(value_2, sign_2);
    local_2 = uint((base + 1u));
    uint _e49 = local_2;
    output.Store(_e49*4, asuint(asuint(_e43)));
    local_3 = uint((base + 2u));
    uint _e67 = local_3;
    output.Store(_e67*4, asuint(asuint(asfloat(((asuint(0.0) & 2147483647u) | (asuint(-(0.0)) & 2147483648u))))));
    local_4 = uint((base + 3u));
    uint _e85 = local_4;
    output.Store(_e85*4, asuint(asuint(asfloat(((asuint(-(0.0)) & 2147483647u) | (asuint(0.0) & 2147483648u))))));
    local_6 = 4286578689u;
    uint _e89 = local_6;
    local_5 = uint((base + 4u));
    uint _e105 = local_5;
    output.Store(_e105*4, asuint(asuint(asfloat(((asuint(asfloat(_e89)) & 2147483647u) | (asuint(0.0) & 2147483648u))))));
    local_8 = 2143363909u;
    uint _e109 = local_8;
    local_7 = uint((base + 5u));
    uint _e126 = local_7;
    output.Store(_e126*4, asuint(asuint(asfloat(((asuint(asfloat(_e109)) & 2147483647u) | (asuint(-(0.0)) & 2147483648u))))));
    const float _e133 = copied(float(naga_neg(int(3))), float(0u));
    local_9 = uint((base + 6u));
    uint _e139 = local_9;
    output.Store(_e139*4, asuint(asuint(_e133)));
    const float _e146 = copied(float(5u), float(naga_neg(int(1))));
    local_10 = uint((base + 7u));
    uint _e152 = local_10;
    output.Store(_e152*4, asuint(asuint(_e146)));
    const int _e156 = copysignf(true, false);
    local_11 = uint((base + 8u));
    uint _e162 = local_11;
    output.Store(_e162*4, asuint(uint(_e156)));
    cursor = int(0);
    int _e168 = cursor;
    cursor = asint(asuint(_e168) + asuint(int(1)));
    local_13 = uint(((index * 2u) + uint(_e168)));
    uint _e175 = local_13;
    uint _e177 = asuint(input.Load(_e175*4));
    int _e181 = cursor;
    cursor = asint(asuint(_e181) + asuint(int(1)));
    local_14 = uint(((index * 2u) + uint(_e181)));
    uint _e188 = local_14;
    uint _e190 = asuint(input.Load(_e188*4));
    const float _e192 = copied(asfloat(_e177), asfloat(_e190));
    local_12 = uint((base + 9u));
    uint _e198 = local_12;
    output.Store(_e198*4, asuint(asuint(_e192)));
    run = false;
    bool _e202 = run;
    local_15 = _e202;
    if (_e202) {
        int _e204 = cursor;
        cursor = asint(asuint(_e204) + asuint(int(1)));
        const uint _e217 = _naga_fabsf(asuint(asfloat(((asuint(float(_e204)) & 2147483647u) | (asuint(sign_2) & 2147483648u)))));
        local_15 = (_e217 != 0u);
    }
    run = true;
    bool _e221 = run;
    local_16 = _e221;
    if (_e221) {
    } else {
        int _e223 = cursor;
        cursor = asint(asuint(_e223) + asuint(int(1)));
        const uint _e236 = _naga_fabsf(asuint(asfloat(((asuint(float(_e223)) & 2147483647u) | (asuint(sign_2) & 2147483648u)))));
        local_16 = (_e236 != 0u);
    }
    int _e239 = cursor;
    local_17 = uint((base + 10u));
    uint _e245 = local_17;
    output.Store(_e245*4, asuint(uint(_e239)));
    bool _e247 = run;
    if (_e247) {
        local_19 = asfloat(((asuint(value_2) & 2147483647u) | (asuint(sign_2) & 2147483648u)));
    } else {
        int _e257 = cursor;
        cursor = asint(asuint(_e257) + asuint(int(1)));
        local_19 = asfloat(((asuint(float(_e257)) & 2147483647u) | (asuint(sign_2) & 2147483648u)));
    }
    float _e271 = local_19;
    local_18 = uint((base + 11u));
    uint _e277 = local_18;
    output.Store(_e277*4, asuint(asuint(_e271)));
    const float _e283 = copied(float(true), -(1.0));
    local_20 = uint((base + 12u));
    uint _e289 = local_20;
    output.Store(_e289*4, asuint(asuint(_e283)));
    int _e291 = cursor;
    local_21 = uint((base + 13u));
    uint _e297 = local_21;
    output.Store(_e297*4, asuint(uint(_e291)));
}
