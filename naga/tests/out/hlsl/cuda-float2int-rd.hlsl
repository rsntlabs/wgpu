struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_5 count; }

float forward(float value)
{
    return value;
}

uint _naga_floorf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

int ZeroValueint() {
    return (int)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(4, 1, 1)]
void convert_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    float local_4 = (float)0;
    float local_5 = (float)0;
    int local_6 = (int)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int local_9 = (int)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    uint local_12 = (uint)0;
    float local_13 = (float)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    int extra = (int)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e17 = asuint(input.Load(index*4));
    float value_1 = asfloat(_e17);
    counter = 0u;
    const uint _e22 = _naga_floorf(asuint(value_1));
    output.Store(base*4, asuint(naga_f2i32(asfloat(_e22))));
    const float _e27 = forward(value_1);
    const uint _e29 = _naga_floorf(asuint(_e27));
    local = uint((base + 1u));
    uint _e36 = local;
    output.Store(_e36*4, asuint(naga_f2i32(asfloat(_e29))));
    uint _e38 = counter;
    counter = (_e38 + uint(int(1)));
    const uint _e43 = _naga_floorf(asuint(value_1));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(naga_f2i32(asfloat(_e43))));
    uint _e52 = counter;
    local_2 = uint((base + 3u));
    uint _e58 = local_2;
    output.Store(_e58*4, asuint(int(_e52)));
    if (((index & 1u) != 0u)) {
        uint _e64 = counter;
        local_12 = _e64;
        uint _e66 = local_12;
        counter = (_e66 + uint(int(1)));
        local_13 = value_1;
        float _e71 = local_13;
        local_4 = _e71;
        float _e73 = local_4;
        const uint _e75 = _naga_floorf(asuint(_e73));
        local_6 = naga_f2i32(asfloat(_e75));
    } else {
        uint _e79 = counter;
        local_14 = _e79;
        uint _e81 = local_14;
        counter = (_e81 + uint(int(1)));
        local_15 = value_1;
        float _e86 = local_15;
        local_5 = _e86;
        float _e88 = local_5;
        const uint _e90 = _naga_floorf(asuint(_e88));
        local_6 = naga_f2i32(asfloat(_e90));
    }
    int _e95 = local_6;
    local_3 = uint((base + 4u));
    uint _e100 = local_3;
    output.Store(_e100*4, asuint(_e95));
    uint _e102 = counter;
    local_7 = uint((base + 5u));
    uint _e108 = local_7;
    output.Store(_e108*4, asuint(int(_e102)));
    const uint _e113 = _naga_floorf(asuint(float(int(16777217))));
    local_8 = uint((base + 6u));
    uint _e120 = local_8;
    output.Store(_e120*4, asuint(naga_f2i32(asfloat(_e113))));
    local_9 = int(7);
    extra = ZeroValueint();
    extra = int(3);
    int _e128 = local_9;
    int _e129 = extra;
    local_11 = asint(asuint(_e128) + asuint(_e129));
    int _e132 = local_11;
    local_10 = uint((base + 7u));
    uint _e137 = local_10;
    output.Store(_e137*4, asuint(_e132));
}
