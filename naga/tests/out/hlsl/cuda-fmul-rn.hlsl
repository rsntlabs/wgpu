ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_fmul_rn(uint left_bits, uint right_bits)
{
    uint _e8 = (left_bits & 2147483647u);
    uint _e9 = (right_bits & 2147483647u);
    uint _e11 = ((left_bits ^ right_bits) & 2147483648u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    bool _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if ((_e17 && _e20)) {
        return 2143289344u;
    }
    uint _e22 = (_e11 | 2139095040u);
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = (_e8 >> 23u);
    uint _e27 = (_e9 >> 23u);
    bool _e28 = (_e26 != 0u);
    bool _e29 = (_e27 != 0u);
    uint _e34 = ((_e8 & 8388607u) | (_e28 ? 8388608u : 0u));
    uint _e35 = ((_e9 & 8388607u) | (_e29 ? 8388608u : 0u));
    uint _e38 = (_e34 & 4095u);
    uint _e39 = (_e35 & 4095u);
    uint _e40 = (_e34 >> 12u);
    uint _e41 = (_e35 >> 12u);
    uint _e42 = (_e38 * _e39);
    uint _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    uint _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    uint _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    int _e64 = int(((_e50 != 0u) ? (55u - (31u - firstbithigh(_e50))) : (31u - (31u - firstbithigh((_e54 | 1u))))));
    int _e69 = asint(asuint(int((_e28 ? _e26 : 1u))) + asuint(int((_e29 ? _e27 : 1u))));
    int _e79 = asint(asuint(max(asint(asuint(_e64) - asuint(int(23))), asint(asuint(int(151)) - asuint(_e69)))) - asuint(int(3)));
    uint _e103 = (uint(min(max(_e79, int(0)), int(31))) & 31u);
    uint _e131 = (uint(min(max(asint(asuint(_e79) - asuint(int(24))), int(0)), int(31))) & 31u);
    uint _e151 = ((_e79 <= int(0)) ? (((_e50 << 24u) | _e54) << (uint(min(max(asint(asuint(int(0)) - asuint(_e79)), int(0)), int(31))) & 31u)) : ((_e79 < int(24)) ? (((_e50 << (uint(min(max(asint(asuint(int(24)) - asuint(_e79)), int(0)), int(31))) & 31u)) | (_e54 >> _e103)) | uint(((_e54 & ((1u << _e103) - 1u)) != 0u))) : ((_e79 == int(24)) ? (_e50 | uint((_e54 != 0u))) : ((_e79 < int(48)) ? ((_e50 >> _e131) | uint((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))) : uint(((_e50 | _e54) != 0u))))));
    uint _e155 = (_e151 & 7u);
    uint _e156 = (_e151 >> 3u);
    uint _e164 = (_e156 + uint(((_e155 > 4u) || ((_e155 == 4u) && ((_e156 & 1u) != 0u)))));
    bool _e166 = (_e164 >= 16777216u);
    uint _e168 = (_e166 ? (_e164 >> 1u) : _e164);
    int _e170 = asint(asuint(asint(asuint(asint(asuint(_e64) + asuint(_e69))) - asuint(int(173)))) + asuint(int(_e166)));
    if ((_e170 >= int(255))) {
        return _e22;
    }
    return (_e11 | ((((_e168 >= 8388608u) ? uint(max(_e170, int(1))) : 0u) << 23u) | (_e168 & 8388607u)));
}

float product_value(float first, float second)
{
    const uint _e4 = _naga_fmul_rn(asuint(first), asuint(second));
    return asfloat(_e4);
}

int _fmul_rn(bool first_1, bool second_1)
{
    int local_17 = (int)0;

    if (first_1) {
        local_17 = int(7);
    } else {
        local_17 = int(9);
    }
    int _e6 = local_17;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

[numthreads(32, 1, 1)]
void multiply_round_nearest(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int cursor = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    bool local_6 = (bool)0;
    bool local_7 = (bool)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float first_2 = asfloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float second_2 = asfloat(_e30);
    const uint _e34 = _naga_fmul_rn(asuint(first_2), asuint(second_2));
    output.Store(base*4, asuint(asuint(asfloat(_e34))));
    const float _e39 = product_value(first_2, second_2);
    local_2 = uint((base + 1u));
    uint _e45 = local_2;
    output.Store(_e45*4, asuint(asuint(_e39)));
    cursor = int(0);
    int _e51 = cursor;
    cursor = asint(asuint(_e51) + asuint(int(1)));
    local_4 = uint(((index * 2u) + uint(_e51)));
    uint _e58 = local_4;
    uint _e60 = asuint(input.Load(_e58*4));
    int _e64 = cursor;
    cursor = asint(asuint(_e64) + asuint(int(1)));
    local_5 = uint(((index * 2u) + uint(_e64)));
    uint _e71 = local_5;
    uint _e73 = asuint(input.Load(_e71*4));
    const float _e75 = product_value(asfloat(_e60), asfloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    output.Store(_e81*4, asuint(asuint(_e75)));
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = asint(asuint(_e85) + asuint(int(1)));
        const uint _e91 = _naga_fmul_rn(asuint(float(_e85)), asuint(first_2));
        const uint _e94 = _naga_fabsf(asuint(asfloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = asint(asuint(_e99) + asuint(int(1)));
        const uint _e105 = _naga_fmul_rn(asuint(first_2), asuint(float(_e99)));
        const uint _e108 = _naga_fabsf(asuint(asfloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    output.Store(_e117*4, asuint(uint(_e111)));
    const uint _e125 = _naga_fmul_rn(asuint(-(0.0)), asuint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    output.Store(_e132*4, asuint(asuint(asfloat(_e125))));
    const uint _e139 = _naga_fmul_rn(asuint(-(0.0)), asuint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    output.Store(_e146*4, asuint(asuint(asfloat(_e139))));
    const float _e152 = product_value(float(int(2)), float(3u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    output.Store(_e158*4, asuint(asuint(_e152)));
    const int _e162 = _fmul_rn(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    output.Store(_e168*4, asuint(uint(_e162)));
    const uint _e172 = _naga_fmul_rn(asuint(second_2), asuint(first_2));
    local_13 = uint((base + 8u));
    uint _e179 = local_13;
    output.Store(_e179*4, asuint(asuint(asfloat(_e172))));
    local_15 = 1065353217u;
    uint _e183 = local_15;
    local_16 = 1065353214u;
    uint _e187 = local_16;
    const uint _e191 = _naga_fmul_rn(asuint(asfloat(_e183)), asuint(asfloat(_e187)));
    local_14 = uint((base + 9u));
    uint _e200 = local_14;
    output.Store(_e200*4, asuint(asuint((asfloat(_e191) - 1.0))));
}
