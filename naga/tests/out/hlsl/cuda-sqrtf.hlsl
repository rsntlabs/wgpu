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
    int local_70 = (int)0;

    if (value_5) {
        local_70 = int(7);
    } else {
        local_70 = int(9);
    }
    int _e6 = local_70;
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
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;

    const uint _e2 = _naga_sqrtf(asuint(0.0));
    local = uint(int(0));
    uint _e9 = local;
    local_40 = uint(_e9);
    uint _e12 = local_40;
    out_.Store(_e12*4, asuint(asuint(asfloat(_e2))));
    const uint _e17 = _naga_sqrtf(asuint(-(0.0)));
    local_1 = uint(int(1));
    uint _e23 = local_1;
    local_41 = uint(_e23);
    uint _e26 = local_41;
    out_.Store(_e26*4, asuint(asuint(asfloat(_e17))));
    const uint _e30 = _naga_sqrtf(asuint(1.0));
    local_2 = uint(int(2));
    uint _e36 = local_2;
    local_42 = uint(_e36);
    uint _e39 = local_42;
    out_.Store(_e39*4, asuint(asuint(asfloat(_e30))));
    const float _e42 = root_2(int(4));
    local_3 = uint(int(3));
    uint _e47 = local_3;
    local_43 = uint(_e47);
    uint _e50 = local_43;
    out_.Store(_e50*4, asuint(asuint(_e42)));
    const float _e53 = root_3(9u);
    local_4 = uint(int(4));
    uint _e58 = local_4;
    local_44 = uint(_e58);
    uint _e61 = local_44;
    out_.Store(_e61*4, asuint(asuint(_e53)));
    const uint _e65 = _naga_sqrtf(asuint(6.25));
    local_5 = uint(int(5));
    uint _e71 = local_5;
    local_45 = uint(_e71);
    uint _e74 = local_45;
    out_.Store(_e74*4, asuint(asuint(asfloat(_e65))));
    const uint _e78 = _naga_sqrtf(asuint(2.0));
    local_6 = uint(int(6));
    uint _e84 = local_6;
    local_46 = uint(_e84);
    uint _e87 = local_46;
    out_.Store(_e87*4, asuint(asuint(asfloat(_e78))));
    local_8 = 1u;
    uint _e91 = local_8;
    const uint _e94 = _naga_sqrtf(asuint(asfloat(_e91)));
    local_7 = uint(int(7));
    uint _e100 = local_7;
    local_47 = uint(_e100);
    uint _e103 = local_47;
    out_.Store(_e103*4, asuint(asuint(asfloat(_e94))));
    local_10 = 8388607u;
    uint _e107 = local_10;
    const uint _e110 = _naga_sqrtf(asuint(asfloat(_e107)));
    local_9 = uint(int(8));
    uint _e116 = local_9;
    local_48 = uint(_e116);
    uint _e119 = local_48;
    out_.Store(_e119*4, asuint(asuint(asfloat(_e110))));
    local_12 = 8388608u;
    uint _e123 = local_12;
    const uint _e126 = _naga_sqrtf(asuint(asfloat(_e123)));
    local_11 = uint(int(9));
    uint _e132 = local_11;
    local_49 = uint(_e132);
    uint _e135 = local_49;
    out_.Store(_e135*4, asuint(asuint(asfloat(_e126))));
    local_14 = 2139095039u;
    uint _e139 = local_14;
    const uint _e142 = _naga_sqrtf(asuint(asfloat(_e139)));
    local_13 = uint(int(10));
    uint _e148 = local_13;
    local_50 = uint(_e148);
    uint _e151 = local_50;
    out_.Store(_e151*4, asuint(asuint(asfloat(_e142))));
    local_16 = 2139095040u;
    uint _e155 = local_16;
    const uint _e158 = _naga_sqrtf(asuint(asfloat(_e155)));
    local_15 = uint(int(11));
    uint _e164 = local_15;
    local_51 = uint(_e164);
    uint _e167 = local_51;
    out_.Store(_e167*4, asuint(asuint(asfloat(_e158))));
    const uint _e172 = _naga_sqrtf(asuint(-(1.0)));
    local_17 = uint(int(12));
    uint _e178 = local_17;
    local_52 = uint(_e178);
    uint _e181 = local_52;
    out_.Store(_e181*4, asuint(asuint(asfloat(_e172))));
    local_19 = 2139095041u;
    uint _e185 = local_19;
    const uint _e188 = _naga_sqrtf(asuint(asfloat(_e185)));
    local_18 = uint(int(13));
    uint _e194 = local_18;
    local_53 = uint(_e194);
    uint _e197 = local_53;
    out_.Store(_e197*4, asuint(asuint(asfloat(_e188))));
    value = 4.0;
    float _e201 = value;
    value = (_e201 + float(int(1)));
    const float _e205 = root_1(_e201);
    local_20 = uint(int(14));
    uint _e210 = local_20;
    local_54 = uint(_e210);
    uint _e213 = local_54;
    out_.Store(_e213*4, asuint(asuint(_e205)));
    float _e215 = value;
    local_21 = uint(int(15));
    uint _e220 = local_21;
    local_55 = uint(_e220);
    uint _e223 = local_55;
    out_.Store(_e223*4, asuint(asuint(_e215)));
    const int _e226 = sqrtf(true);
    local_22 = uint(int(16));
    uint _e231 = local_22;
    local_56 = uint(_e231);
    uint _e234 = local_56;
    out_.Store(_e234*4, asuint(uint(_e226)));
    const int _e237 = sqrtf(false);
    local_23 = uint(int(17));
    uint _e242 = local_23;
    local_57 = uint(_e242);
    uint _e245 = local_57;
    out_.Store(_e245*4, asuint(uint(_e237)));
    const float _e249 = sqrtf_1(2.0, 3.0);
    local_24 = uint(int(18));
    uint _e254 = local_24;
    local_58 = uint(_e254);
    uint _e257 = local_58;
    out_.Store(_e257*4, asuint(asuint(_e249)));
    local_26 = 1065353217u;
    uint _e261 = local_26;
    const uint _e264 = _naga_sqrtf(asuint(asfloat(_e261)));
    local_25 = uint(int(19));
    uint _e270 = local_25;
    local_59 = uint(_e270);
    uint _e273 = local_59;
    out_.Store(_e273*4, asuint(asuint(asfloat(_e264))));
    local_28 = 1065353218u;
    uint _e277 = local_28;
    const uint _e280 = _naga_sqrtf(asuint(asfloat(_e277)));
    local_27 = uint(int(20));
    uint _e286 = local_27;
    local_60 = uint(_e286);
    uint _e289 = local_60;
    out_.Store(_e289*4, asuint(asuint(asfloat(_e280))));
    local_30 = 1065353215u;
    uint _e293 = local_30;
    const uint _e296 = _naga_sqrtf(asuint(asfloat(_e293)));
    local_29 = uint(int(21));
    uint _e302 = local_29;
    local_61 = uint(_e302);
    uint _e305 = local_61;
    out_.Store(_e305*4, asuint(asuint(asfloat(_e296))));
    const float _e308 = root_3(4294967295u);
    local_31 = uint(int(22));
    uint _e313 = local_31;
    local_62 = uint(_e313);
    uint _e316 = local_62;
    out_.Store(_e316*4, asuint(asuint(_e308)));
    const float _e320 = root_2(naga_neg(int(4)));
    local_32 = uint(int(23));
    uint _e325 = local_32;
    local_63 = uint(_e325);
    uint _e328 = local_63;
    out_.Store(_e328*4, asuint(asuint(_e320)));
    const float _e331 = root_1(16.0);
    local_33 = uint(int(24));
    uint _e336 = local_33;
    local_64 = uint(_e336);
    uint _e339 = local_64;
    out_.Store(_e339*4, asuint(asuint(_e331)));
    const uint _e343 = _naga_sqrtf(asuint(0.25));
    local_34 = uint(int(25));
    uint _e349 = local_34;
    local_65 = uint(_e349);
    uint _e352 = local_65;
    out_.Store(_e352*4, asuint(asuint(asfloat(_e343))));
    local_36 = 2147483649u;
    uint _e356 = local_36;
    const uint _e359 = _naga_sqrtf(asuint(asfloat(_e356)));
    local_35 = uint(int(26));
    uint _e365 = local_35;
    local_66 = uint(_e365);
    uint _e368 = local_66;
    out_.Store(_e368*4, asuint(asuint(asfloat(_e359))));
    const float _e371 = root_4(false);
    local_37 = uint(int(27));
    uint _e376 = local_37;
    local_67 = uint(_e376);
    uint _e379 = local_67;
    out_.Store(_e379*4, asuint(asuint(_e371)));
    const float _e382 = root_4(true);
    local_38 = uint(int(28));
    uint _e387 = local_38;
    local_68 = uint(_e387);
    uint _e390 = local_68;
    out_.Store(_e390*4, asuint(asuint(_e382)));
    const float _e393 = root_1(0.5);
    local_39 = uint(int(29));
    uint _e398 = local_39;
    local_69 = uint(_e398);
    uint _e401 = local_69;
    out_.Store(_e401*4, asuint(asuint(_e393)));
}
