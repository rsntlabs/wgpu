ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int finite_value(float value)
{
    return int(((asuint(value) & 2147483647u) < 2139095040u));
}

int infinite_value(float value_1)
{
    return int(((asuint(value_1) & 2147483647u) == 2139095040u));
}

int nan_value(float value_2)
{
    return int(((asuint(value_2) & 2147483647u) > 2139095040u));
}

int sign_value(float value_3)
{
    return int(((asuint(value_3) & 2147483648u) != 0u));
}

uint result_kind(int value_4)
{
    return (10u + uint(value_4));
}

int signbit(bool value_5)
{
    int local_33 = (int)0;

    if (value_5) {
        local_33 = int(7);
    } else {
        local_33 = int(9);
    }
    int _e6 = local_33;
    return _e6;
}

[numthreads(32, 1, 1)]
void float_classification(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int cursor = (int)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    bool local_16 = (bool)0;
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

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 544u)) {
        return;
    }
    uint bits = asuint(input.Load(index*4));
    uint base = (4u + (index * 23u));
    float value_6 = asfloat(bits);
    output.Store(base*4, asuint(uint(int(((asuint(value_6) & 2147483647u) < 2139095040u)))));
    local = uint((base + 1u));
    uint _e37 = local;
    output.Store(_e37*4, asuint(uint(int(((asuint(value_6) & 2147483647u) == 2139095040u)))));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(uint(int(((asuint(value_6) & 2147483647u) > 2139095040u)))));
    local_2 = uint((base + 3u));
    uint _e63 = local_2;
    output.Store(_e63*4, asuint(uint(int(((asuint(value_6) & 2147483648u) != 0u)))));
    const int _e65 = finite_value(value_6);
    local_3 = uint((base + 4u));
    uint _e71 = local_3;
    output.Store(_e71*4, asuint(uint(_e65)));
    const int _e73 = infinite_value(value_6);
    local_4 = uint((base + 5u));
    uint _e79 = local_4;
    output.Store(_e79*4, asuint(uint(_e73)));
    const int _e81 = nan_value(value_6);
    local_5 = uint((base + 6u));
    uint _e87 = local_5;
    output.Store(_e87*4, asuint(uint(_e81)));
    const int _e89 = sign_value(value_6);
    local_6 = uint((base + 7u));
    uint _e95 = local_6;
    output.Store(_e95*4, asuint(uint(_e89)));
    const uint _e103 = result_kind(int(((asuint(value_6) & 2147483647u) > 2139095040u)));
    local_7 = uint((base + 8u));
    uint _e108 = local_7;
    output.Store(_e108*4, asuint(_e103));
    cursor = int(0);
    int _e112 = cursor;
    cursor = asint(asuint(_e112) + asuint(int(1)));
    local_9 = uint((index + uint(_e112)));
    uint _e119 = local_9;
    uint _e121 = asuint(input.Load(_e119*4));
    local_8 = uint((base + 9u));
    uint _e134 = local_8;
    output.Store(_e134*4, asuint(uint(int(((asuint(asfloat(_e121)) & 2147483648u) != 0u)))));
    int _e136 = cursor;
    local_10 = uint((base + 10u));
    uint _e142 = local_10;
    output.Store(_e142*4, asuint(uint(_e136)));
    const int _e145 = signbit(true);
    local_11 = uint((base + 11u));
    uint _e151 = local_11;
    output.Store(_e151*4, asuint(uint(_e145)));
    if ((int(((asuint(value_6) & 2147483647u) < 2139095040u)) != int(0))) {
        local_12 = uint((base + 12u));
        uint _e165 = local_12;
        local_30 = _e165;
        uint _e167 = local_30;
        output.Store(_e167*4, asuint(2u));
    } else {
        if ((int(((asuint(value_6) & 2147483647u) == 2139095040u)) != int(0))) {
            local_13 = uint((base + 12u));
            uint _e182 = local_13;
            local_31 = _e182;
            uint _e184 = local_31;
            output.Store(_e184*4, asuint(3u));
        } else {
            local_14 = uint((base + 12u));
            uint _e191 = local_14;
            local_32 = _e191;
            uint _e193 = local_32;
            output.Store(_e193*4, asuint(4u));
        }
    }
    local_16 = false;
    if (false) {
        int _e198 = cursor;
        cursor = asint(asuint(_e198) + asuint(int(1)));
        local_16 = (int(((asuint((value_6 + float(_e198))) & 2147483647u) > 2139095040u)) != int(0));
    }
    bool _e211 = local_16;
    local_15 = uint((base + 13u));
    uint _e217 = local_15;
    output.Store(_e217*4, asuint(uint(_e211)));
    int _e219 = cursor;
    local_17 = uint((base + 14u));
    uint _e225 = local_17;
    output.Store(_e225*4, asuint(uint(_e219)));
    local_18 = uint((base + 15u));
    uint _e240 = local_18;
    output.Store(_e240*4, asuint(uint(int(((asuint(float(int(3))) & 2147483647u) < 2139095040u)))));
    local_19 = uint((base + 16u));
    uint _e254 = local_19;
    output.Store(_e254*4, asuint(uint(int(((asuint(0.0) & 2147483648u) != 0u)))));
    local_20 = uint((base + 17u));
    uint _e269 = local_20;
    output.Store(_e269*4, asuint(uint(int(((asuint(-(0.0)) & 2147483648u) != 0u)))));
    const int _e273 = sign_value(-(0.0));
    local_21 = uint((base + 18u));
    uint _e279 = local_21;
    output.Store(_e279*4, asuint(uint(_e273)));
    local_23 = 2139095040u;
    uint _e283 = local_23;
    local_22 = uint((base + 19u));
    uint _e296 = local_22;
    output.Store(_e296*4, asuint(uint(int(((asuint(asfloat(_e283)) & 2147483647u) < 2139095040u)))));
    local_25 = 2139095040u;
    uint _e300 = local_25;
    local_24 = uint((base + 20u));
    uint _e313 = local_24;
    output.Store(_e313*4, asuint(uint(int(((asuint(asfloat(_e300)) & 2147483647u) == 2139095040u)))));
    local_27 = 4286578689u;
    uint _e317 = local_27;
    local_26 = uint((base + 21u));
    uint _e330 = local_26;
    output.Store(_e330*4, asuint(uint(int(((asuint(asfloat(_e317)) & 2147483647u) > 2139095040u)))));
    local_29 = 4286578689u;
    uint _e334 = local_29;
    local_28 = uint((base + 22u));
    uint _e347 = local_28;
    output.Store(_e347*4, asuint(uint(int(((asuint(asfloat(_e334)) & 2147483648u) != 0u)))));
}
