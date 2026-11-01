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
    int local_10 = (int)0;

    if (value_5) {
        local_10 = int(7);
    } else {
        local_10 = int(9);
    }
    int _e6 = local_10;
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
    float value = (float)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;

    const uint _e2 = _naga_sqrtf(asuint(0.0));
    out_.Store(uint(int(0))*4, asuint(asuint(asfloat(_e2))));
    const uint _e12 = _naga_sqrtf(asuint(-(0.0)));
    out_.Store(uint(int(1))*4, asuint(asuint(asfloat(_e12))));
    const uint _e20 = _naga_sqrtf(asuint(1.0));
    out_.Store(uint(int(2))*4, asuint(asuint(asfloat(_e20))));
    const float _e27 = root_2(int(4));
    out_.Store(uint(int(3))*4, asuint(asuint(_e27)));
    const float _e33 = root_3(9u);
    out_.Store(uint(int(4))*4, asuint(asuint(_e33)));
    const uint _e40 = _naga_sqrtf(asuint(6.25));
    out_.Store(uint(int(5))*4, asuint(asuint(asfloat(_e40))));
    const uint _e48 = _naga_sqrtf(asuint(2.0));
    out_.Store(uint(int(6))*4, asuint(asuint(asfloat(_e48))));
    local = 1u;
    uint _e56 = local;
    const uint _e59 = _naga_sqrtf(asuint(asfloat(_e56)));
    out_.Store(uint(int(7))*4, asuint(asuint(asfloat(_e59))));
    local_1 = 8388607u;
    uint _e67 = local_1;
    const uint _e70 = _naga_sqrtf(asuint(asfloat(_e67)));
    out_.Store(uint(int(8))*4, asuint(asuint(asfloat(_e70))));
    local_2 = 8388608u;
    uint _e78 = local_2;
    const uint _e81 = _naga_sqrtf(asuint(asfloat(_e78)));
    out_.Store(uint(int(9))*4, asuint(asuint(asfloat(_e81))));
    local_3 = 2139095039u;
    uint _e89 = local_3;
    const uint _e92 = _naga_sqrtf(asuint(asfloat(_e89)));
    out_.Store(uint(int(10))*4, asuint(asuint(asfloat(_e92))));
    local_4 = 2139095040u;
    uint _e100 = local_4;
    const uint _e103 = _naga_sqrtf(asuint(asfloat(_e100)));
    out_.Store(uint(int(11))*4, asuint(asuint(asfloat(_e103))));
    const uint _e112 = _naga_sqrtf(asuint(-(1.0)));
    out_.Store(uint(int(12))*4, asuint(asuint(asfloat(_e112))));
    local_5 = 2139095041u;
    uint _e120 = local_5;
    const uint _e123 = _naga_sqrtf(asuint(asfloat(_e120)));
    out_.Store(uint(int(13))*4, asuint(asuint(asfloat(_e123))));
    value = 4.0;
    float _e131 = value;
    value = (_e131 + float(int(1)));
    const float _e135 = root_1(_e131);
    out_.Store(uint(int(14))*4, asuint(asuint(_e135)));
    float _e140 = value;
    out_.Store(uint(int(15))*4, asuint(asuint(_e140)));
    const int _e146 = sqrtf(true);
    out_.Store(uint(int(16))*4, asuint(uint(_e146)));
    const int _e152 = sqrtf(false);
    out_.Store(uint(int(17))*4, asuint(uint(_e152)));
    const float _e159 = sqrtf_1(2.0, 3.0);
    out_.Store(uint(int(18))*4, asuint(asuint(_e159)));
    local_6 = 1065353217u;
    uint _e166 = local_6;
    const uint _e169 = _naga_sqrtf(asuint(asfloat(_e166)));
    out_.Store(uint(int(19))*4, asuint(asuint(asfloat(_e169))));
    local_7 = 1065353218u;
    uint _e177 = local_7;
    const uint _e180 = _naga_sqrtf(asuint(asfloat(_e177)));
    out_.Store(uint(int(20))*4, asuint(asuint(asfloat(_e180))));
    local_8 = 1065353215u;
    uint _e188 = local_8;
    const uint _e191 = _naga_sqrtf(asuint(asfloat(_e188)));
    out_.Store(uint(int(21))*4, asuint(asuint(asfloat(_e191))));
    const float _e198 = root_3(4294967295u);
    out_.Store(uint(int(22))*4, asuint(asuint(_e198)));
    const float _e205 = root_2(naga_neg(int(4)));
    out_.Store(uint(int(23))*4, asuint(asuint(_e205)));
    const float _e211 = root_1(16.0);
    out_.Store(uint(int(24))*4, asuint(asuint(_e211)));
    const uint _e218 = _naga_sqrtf(asuint(0.25));
    out_.Store(uint(int(25))*4, asuint(asuint(asfloat(_e218))));
    local_9 = 2147483649u;
    uint _e226 = local_9;
    const uint _e229 = _naga_sqrtf(asuint(asfloat(_e226)));
    out_.Store(uint(int(26))*4, asuint(asuint(asfloat(_e229))));
    const float _e236 = root_4(false);
    out_.Store(uint(int(27))*4, asuint(asuint(_e236)));
    const float _e242 = root_4(true);
    out_.Store(uint(int(28))*4, asuint(asuint(_e242)));
    const float _e248 = root_1(0.5);
    out_.Store(uint(int(29))*4, asuint(asuint(_e248)));
}
