RWByteAddressBuffer out_ : register(u0);

uint _naga_sqrtf(uint input_bits)
{
    uint significand = (uint)0;
    uint adjusted_exponent = (uint)0;
    uint upper_word = (uint)0;
    uint lower_word = (uint)0;
    uint root = (uint)0;
    uint remainder = (uint)0;
    uint iteration = (uint)0;

    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = ((31u - firstbithigh(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

float root_1(float value_1)
{
    const uint _e2 = _naga_sqrtf(asuint(value_1));
    return asfloat(_e2);
}

float root_2(int value_2)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_2)));
    return asfloat(_e3);
}

float root_3(uint value_3)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_3)));
    return asfloat(_e3);
}

float root_4(bool value_4)
{
    const uint _e3 = _naga_sqrtf(asuint(float(value_4)));
    return asfloat(_e3);
}

int sqrtf(bool value_5)
{
    int local_40 = (int)0;

    if (value_5) {
        local_40 = int(7);
    } else {
        local_40 = int(9);
    }
    int _e6 = local_40;
    return _e6;
}

float sqrtf_1(float first, float second)
{
    return (first + second);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void roots()
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
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    float value = (float)0;
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
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;

    const uint _e2 = _naga_sqrtf(asuint(0.0));
    local = uint(int(0));
    uint _e8 = local;
    out_.Store(_e8*4, asuint(asuint(asfloat(_e2))));
    const uint _e14 = _naga_sqrtf(asuint(-(0.0)));
    local_1 = uint(int(1));
    uint _e20 = local_1;
    out_.Store(_e20*4, asuint(asuint(asfloat(_e14))));
    const uint _e24 = _naga_sqrtf(asuint(1.0));
    local_2 = uint(int(2));
    uint _e30 = local_2;
    out_.Store(_e30*4, asuint(asuint(asfloat(_e24))));
    const float _e33 = root_2(int(4));
    local_3 = uint(int(3));
    uint _e38 = local_3;
    out_.Store(_e38*4, asuint(asuint(_e33)));
    const float _e41 = root_3(9u);
    local_4 = uint(int(4));
    uint _e46 = local_4;
    out_.Store(_e46*4, asuint(asuint(_e41)));
    const uint _e50 = _naga_sqrtf(asuint(6.25));
    local_5 = uint(int(5));
    uint _e56 = local_5;
    out_.Store(_e56*4, asuint(asuint(asfloat(_e50))));
    const uint _e60 = _naga_sqrtf(asuint(2.0));
    local_6 = uint(int(6));
    uint _e66 = local_6;
    out_.Store(_e66*4, asuint(asuint(asfloat(_e60))));
    local_8 = 1u;
    uint _e70 = local_8;
    const uint _e73 = _naga_sqrtf(asuint(asfloat(_e70)));
    local_7 = uint(int(7));
    uint _e79 = local_7;
    out_.Store(_e79*4, asuint(asuint(asfloat(_e73))));
    local_10 = 8388607u;
    uint _e83 = local_10;
    const uint _e86 = _naga_sqrtf(asuint(asfloat(_e83)));
    local_9 = uint(int(8));
    uint _e92 = local_9;
    out_.Store(_e92*4, asuint(asuint(asfloat(_e86))));
    local_12 = 8388608u;
    uint _e96 = local_12;
    const uint _e99 = _naga_sqrtf(asuint(asfloat(_e96)));
    local_11 = uint(int(9));
    uint _e105 = local_11;
    out_.Store(_e105*4, asuint(asuint(asfloat(_e99))));
    local_14 = 2139095039u;
    uint _e109 = local_14;
    const uint _e112 = _naga_sqrtf(asuint(asfloat(_e109)));
    local_13 = uint(int(10));
    uint _e118 = local_13;
    out_.Store(_e118*4, asuint(asuint(asfloat(_e112))));
    local_16 = 2139095040u;
    uint _e122 = local_16;
    const uint _e125 = _naga_sqrtf(asuint(asfloat(_e122)));
    local_15 = uint(int(11));
    uint _e131 = local_15;
    out_.Store(_e131*4, asuint(asuint(asfloat(_e125))));
    const uint _e136 = _naga_sqrtf(asuint(-(1.0)));
    local_17 = uint(int(12));
    uint _e142 = local_17;
    out_.Store(_e142*4, asuint(asuint(asfloat(_e136))));
    local_19 = 2139095041u;
    uint _e146 = local_19;
    const uint _e149 = _naga_sqrtf(asuint(asfloat(_e146)));
    local_18 = uint(int(13));
    uint _e155 = local_18;
    out_.Store(_e155*4, asuint(asuint(asfloat(_e149))));
    value = 4.0;
    float _e159 = value;
    value = (_e159 + float(int(1)));
    const float _e163 = root_1(_e159);
    local_20 = uint(int(14));
    uint _e168 = local_20;
    out_.Store(_e168*4, asuint(asuint(_e163)));
    float _e170 = value;
    local_21 = uint(int(15));
    uint _e175 = local_21;
    out_.Store(_e175*4, asuint(asuint(_e170)));
    const int _e178 = sqrtf(true);
    local_22 = uint(int(16));
    uint _e183 = local_22;
    out_.Store(_e183*4, asuint(uint(_e178)));
    const int _e186 = sqrtf(false);
    local_23 = uint(int(17));
    uint _e191 = local_23;
    out_.Store(_e191*4, asuint(uint(_e186)));
    const float _e195 = sqrtf_1(2.0, 3.0);
    local_24 = uint(int(18));
    uint _e200 = local_24;
    out_.Store(_e200*4, asuint(asuint(_e195)));
    local_26 = 1065353217u;
    uint _e204 = local_26;
    const uint _e207 = _naga_sqrtf(asuint(asfloat(_e204)));
    local_25 = uint(int(19));
    uint _e213 = local_25;
    out_.Store(_e213*4, asuint(asuint(asfloat(_e207))));
    local_28 = 1065353218u;
    uint _e217 = local_28;
    const uint _e220 = _naga_sqrtf(asuint(asfloat(_e217)));
    local_27 = uint(int(20));
    uint _e226 = local_27;
    out_.Store(_e226*4, asuint(asuint(asfloat(_e220))));
    local_30 = 1065353215u;
    uint _e230 = local_30;
    const uint _e233 = _naga_sqrtf(asuint(asfloat(_e230)));
    local_29 = uint(int(21));
    uint _e239 = local_29;
    out_.Store(_e239*4, asuint(asuint(asfloat(_e233))));
    const float _e242 = root_3(4294967295u);
    local_31 = uint(int(22));
    uint _e247 = local_31;
    out_.Store(_e247*4, asuint(asuint(_e242)));
    const float _e251 = root_2(naga_neg(int(4)));
    local_32 = uint(int(23));
    uint _e256 = local_32;
    out_.Store(_e256*4, asuint(asuint(_e251)));
    const float _e259 = root_1(16.0);
    local_33 = uint(int(24));
    uint _e264 = local_33;
    out_.Store(_e264*4, asuint(asuint(_e259)));
    const uint _e268 = _naga_sqrtf(asuint(0.25));
    local_34 = uint(int(25));
    uint _e274 = local_34;
    out_.Store(_e274*4, asuint(asuint(asfloat(_e268))));
    local_36 = 2147483649u;
    uint _e278 = local_36;
    const uint _e281 = _naga_sqrtf(asuint(asfloat(_e278)));
    local_35 = uint(int(26));
    uint _e287 = local_35;
    out_.Store(_e287*4, asuint(asuint(asfloat(_e281))));
    const float _e290 = root_4(false);
    local_37 = uint(int(27));
    uint _e295 = local_37;
    out_.Store(_e295*4, asuint(asuint(_e290)));
    const float _e298 = root_4(true);
    local_38 = uint(int(28));
    uint _e303 = local_38;
    out_.Store(_e303*4, asuint(asuint(_e298)));
    const float _e306 = root_1(0.5);
    local_39 = uint(int(29));
    uint _e311 = local_39;
    out_.Store(_e311*4, asuint(asuint(_e306)));
}
