RWByteAddressBuffer out_ : register(u0);

uint _naga_floorf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    bool _e7 = ((input_bits & 2147483648u) != 0u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value_1)
{
    const uint _e2 = _naga_floorf(asuint(value_1));
    return asfloat(_e2);
}

float floor_value_1(int value_2)
{
    const uint _e3 = _naga_floorf(asuint(float(value_2)));
    return asfloat(_e3);
}

float floor_value_2(uint value_3)
{
    const uint _e3 = _naga_floorf(asuint(float(value_3)));
    return asfloat(_e3);
}

float floor_value_3(bool value_4)
{
    const uint _e3 = _naga_floorf(asuint(float(value_4)));
    return asfloat(_e3);
}

int floorf(bool value_5)
{
    int local_42 = (int)0;

    if (value_5) {
        local_42 = int(7);
    } else {
        local_42 = int(9);
    }
    int _e6 = local_42;
    return _e6;
}

float floorf_1(float first, float second)
{
    return (first + second);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(1, 1, 1)]
void floors()
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
    float value = (float)0;
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
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;

    const uint _e2 = _naga_floorf(asuint(0.0));
    local = uint(int(0));
    uint _e8 = local;
    out_.Store(_e8*4, asuint(asuint(asfloat(_e2))));
    const uint _e14 = _naga_floorf(asuint(-(0.0)));
    local_1 = uint(int(1));
    uint _e20 = local_1;
    out_.Store(_e20*4, asuint(asuint(asfloat(_e14))));
    const uint _e24 = _naga_floorf(asuint(1.75));
    local_2 = uint(int(2));
    uint _e30 = local_2;
    out_.Store(_e30*4, asuint(asuint(asfloat(_e24))));
    const uint _e35 = _naga_floorf(asuint(-(1.25)));
    local_3 = uint(int(3));
    uint _e41 = local_3;
    out_.Store(_e41*4, asuint(asuint(asfloat(_e35))));
    const float _e44 = floor_value_1(int(3));
    local_4 = uint(int(4));
    uint _e49 = local_4;
    out_.Store(_e49*4, asuint(asuint(_e44)));
    const float _e52 = floor_value_2(5u);
    local_5 = uint(int(5));
    uint _e57 = local_5;
    out_.Store(_e57*4, asuint(asuint(_e52)));
    const float _e60 = floor_value_3(true);
    local_6 = uint(int(6));
    uint _e65 = local_6;
    out_.Store(_e65*4, asuint(asuint(_e60)));
    const float _e68 = floor_value_3(false);
    local_7 = uint(int(7));
    uint _e73 = local_7;
    out_.Store(_e73*4, asuint(asuint(_e68)));
    local_9 = 1u;
    uint _e77 = local_9;
    const uint _e80 = _naga_floorf(asuint(asfloat(_e77)));
    local_8 = uint(int(8));
    uint _e86 = local_8;
    out_.Store(_e86*4, asuint(asuint(asfloat(_e80))));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    const uint _e93 = _naga_floorf(asuint(asfloat(_e90)));
    local_10 = uint(int(9));
    uint _e99 = local_10;
    out_.Store(_e99*4, asuint(asuint(asfloat(_e93))));
    local_13 = 8388607u;
    uint _e103 = local_13;
    const uint _e106 = _naga_floorf(asuint(asfloat(_e103)));
    local_12 = uint(int(10));
    uint _e112 = local_12;
    out_.Store(_e112*4, asuint(asuint(asfloat(_e106))));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    const uint _e119 = _naga_floorf(asuint(asfloat(_e116)));
    local_14 = uint(int(11));
    uint _e125 = local_14;
    out_.Store(_e125*4, asuint(asuint(asfloat(_e119))));
    const uint _e129 = _naga_floorf(asuint(3.4028235e38));
    local_16 = uint(int(12));
    uint _e135 = local_16;
    out_.Store(_e135*4, asuint(asuint(asfloat(_e129))));
    const uint _e140 = _naga_floorf(asuint(-(3.4028235e38)));
    local_17 = uint(int(13));
    uint _e146 = local_17;
    out_.Store(_e146*4, asuint(asuint(asfloat(_e140))));
    local_19 = 2139095039u;
    uint _e150 = local_19;
    const uint _e153 = _naga_floorf(asuint(asfloat(_e150)));
    local_18 = uint(int(14));
    uint _e159 = local_18;
    out_.Store(_e159*4, asuint(asuint(asfloat(_e153))));
    local_21 = 4286578687u;
    uint _e163 = local_21;
    const uint _e166 = _naga_floorf(asuint(asfloat(_e163)));
    local_20 = uint(int(15));
    uint _e172 = local_20;
    out_.Store(_e172*4, asuint(asuint(asfloat(_e166))));
    local_23 = 2139095040u;
    uint _e176 = local_23;
    const uint _e179 = _naga_floorf(asuint(asfloat(_e176)));
    local_22 = uint(int(16));
    uint _e185 = local_22;
    out_.Store(_e185*4, asuint(asuint(asfloat(_e179))));
    local_25 = 4286578688u;
    uint _e189 = local_25;
    const uint _e192 = _naga_floorf(asuint(asfloat(_e189)));
    local_24 = uint(int(17));
    uint _e198 = local_24;
    out_.Store(_e198*4, asuint(asuint(asfloat(_e192))));
    local_27 = 2143363909u;
    uint _e202 = local_27;
    const uint _e205 = _naga_floorf(asuint(asfloat(_e202)));
    local_26 = uint(int(18));
    uint _e211 = local_26;
    out_.Store(_e211*4, asuint(asuint(asfloat(_e205))));
    local_29 = 2139095041u;
    uint _e215 = local_29;
    const uint _e218 = _naga_floorf(asuint(asfloat(_e215)));
    local_28 = uint(int(19));
    uint _e224 = local_28;
    out_.Store(_e224*4, asuint(asuint(asfloat(_e218))));
    value = 2.75;
    float _e228 = value;
    value = (_e228 + float(int(1)));
    const float _e232 = floor_value(_e228);
    local_30 = uint(int(20));
    uint _e237 = local_30;
    out_.Store(_e237*4, asuint(asuint(_e232)));
    float _e239 = value;
    local_31 = uint(int(21));
    uint _e244 = local_31;
    out_.Store(_e244*4, asuint(asuint(_e239)));
    const int _e247 = floorf(true);
    local_32 = uint(int(22));
    uint _e252 = local_32;
    out_.Store(_e252*4, asuint(uint(_e247)));
    const int _e255 = floorf(false);
    local_33 = uint(int(23));
    uint _e260 = local_33;
    out_.Store(_e260*4, asuint(uint(_e255)));
    const float _e264 = floorf_1(2.0, 3.0);
    local_34 = uint(int(24));
    uint _e269 = local_34;
    out_.Store(_e269*4, asuint(asuint(_e264)));
    local_36 = 1258291199u;
    uint _e273 = local_36;
    const uint _e276 = _naga_floorf(asuint(asfloat(_e273)));
    local_35 = uint(int(25));
    uint _e282 = local_35;
    out_.Store(_e282*4, asuint(asuint(asfloat(_e276))));
    local_38 = 3405774847u;
    uint _e286 = local_38;
    const uint _e289 = _naga_floorf(asuint(asfloat(_e286)));
    local_37 = uint(int(26));
    uint _e295 = local_37;
    out_.Store(_e295*4, asuint(asuint(asfloat(_e289))));
    const float _e298 = floor_value_2(4294967295u);
    local_39 = uint(int(27));
    uint _e303 = local_39;
    out_.Store(_e303*4, asuint(asuint(_e298)));
    const float _e309 = floor_value_1(asint(asuint(naga_neg(int(2147483647))) - asuint(int(1))));
    local_40 = uint(int(28));
    uint _e314 = local_40;
    out_.Store(_e314*4, asuint(asuint(_e309)));
    const uint _e318 = _naga_floorf(asuint(10000000000.0));
    local_41 = uint(int(29));
    uint _e324 = local_41;
    out_.Store(_e324*4, asuint(asuint(asfloat(_e318))));
}
