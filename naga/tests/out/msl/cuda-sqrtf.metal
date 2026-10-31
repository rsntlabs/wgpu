// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_sqrtf(
    uint input_bits
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration = {};
    uint _e5 = input_bits & 2147483647u;
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits & 8388607u;
    uint _e20 = _e5 >> 23u;
    significand = _e19 | 8388608u;
    adjusted_exponent = _e20 + 127u;
    if (_e20 == 0u) {
        uint _e28 = metal::clz(_e19) - 8u;
        significand = _e19 << _e28;
        adjusted_exponent = 128u - _e28;
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = _e33 & 1u;
    upper_word = _e32 >> (9u - _e34);
    lower_word = _e32 << (23u + _e34);
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = _e72 + 1u;
        }
        loop_init = false;
        uint _e50 = iteration;
        if (_e50 >= 24u) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = (_e55 << 2u) | (_e52 >> 14u);
        uint _e65 = (_e54 << 2u) | 1u;
        bool _e66 = _e63 >= _e65;
        uint _e69 = _e54 << 1u;
        upper_word = ((_e52 << 2u) | (_e53 >> 30u)) & 65535u;
        lower_word = _e53 << 2u;
        remainder = _e66 ? (_e63 - _e65) : _e63;
        root = _e66 ? (_e69 | 1u) : _e69;
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return ((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u);
}

float root_1(
    float value_1
) {
    uint _e2 = _naga_sqrtf(as_type<uint>(value_1));
    return as_type<float>(_e2);
}

float root_2(
    int value_2
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_2)));
    return as_type<float>(_e3);
}

float root_3(
    uint value_3
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_3)));
    return as_type<float>(_e3);
}

float root_4(
    bool value_4
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(static_cast<float>(value_4)));
    return as_type<float>(_e3);
}

int sqrtf(
    bool value_5
) {
    int local_70 = {};
    if (value_5) {
        local_70 = 7;
    } else {
        local_70 = 9;
    }
    int _e6 = local_70;
    return _e6;
}

float sqrtf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void roots(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    float value = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint _e2 = _naga_sqrtf(as_type<uint>(0.0));
    local = static_cast<uint>(0);
    uint _e9 = local;
    local_40 = static_cast<uint>(_e9);
    uint _e12 = local_40;
    out[_e12] = as_type<uint>(as_type<float>(_e2));
    uint _e17 = _naga_sqrtf(as_type<uint>(-(0.0)));
    local_1 = static_cast<uint>(1);
    uint _e23 = local_1;
    local_41 = static_cast<uint>(_e23);
    uint _e26 = local_41;
    out[_e26] = as_type<uint>(as_type<float>(_e17));
    uint _e30 = _naga_sqrtf(as_type<uint>(1.0));
    local_2 = static_cast<uint>(2);
    uint _e36 = local_2;
    local_42 = static_cast<uint>(_e36);
    uint _e39 = local_42;
    out[_e39] = as_type<uint>(as_type<float>(_e30));
    float _e42 = root_2(4);
    local_3 = static_cast<uint>(3);
    uint _e47 = local_3;
    local_43 = static_cast<uint>(_e47);
    uint _e50 = local_43;
    out[_e50] = as_type<uint>(_e42);
    float _e53 = root_3(9u);
    local_4 = static_cast<uint>(4);
    uint _e58 = local_4;
    local_44 = static_cast<uint>(_e58);
    uint _e61 = local_44;
    out[_e61] = as_type<uint>(_e53);
    uint _e65 = _naga_sqrtf(as_type<uint>(6.25));
    local_5 = static_cast<uint>(5);
    uint _e71 = local_5;
    local_45 = static_cast<uint>(_e71);
    uint _e74 = local_45;
    out[_e74] = as_type<uint>(as_type<float>(_e65));
    uint _e78 = _naga_sqrtf(as_type<uint>(2.0));
    local_6 = static_cast<uint>(6);
    uint _e84 = local_6;
    local_46 = static_cast<uint>(_e84);
    uint _e87 = local_46;
    out[_e87] = as_type<uint>(as_type<float>(_e78));
    local_8 = 1u;
    uint _e91 = local_8;
    uint _e94 = _naga_sqrtf(as_type<uint>(as_type<float>(_e91)));
    local_7 = static_cast<uint>(7);
    uint _e100 = local_7;
    local_47 = static_cast<uint>(_e100);
    uint _e103 = local_47;
    out[_e103] = as_type<uint>(as_type<float>(_e94));
    local_10 = 8388607u;
    uint _e107 = local_10;
    uint _e110 = _naga_sqrtf(as_type<uint>(as_type<float>(_e107)));
    local_9 = static_cast<uint>(8);
    uint _e116 = local_9;
    local_48 = static_cast<uint>(_e116);
    uint _e119 = local_48;
    out[_e119] = as_type<uint>(as_type<float>(_e110));
    local_12 = 8388608u;
    uint _e123 = local_12;
    uint _e126 = _naga_sqrtf(as_type<uint>(as_type<float>(_e123)));
    local_11 = static_cast<uint>(9);
    uint _e132 = local_11;
    local_49 = static_cast<uint>(_e132);
    uint _e135 = local_49;
    out[_e135] = as_type<uint>(as_type<float>(_e126));
    local_14 = 2139095039u;
    uint _e139 = local_14;
    uint _e142 = _naga_sqrtf(as_type<uint>(as_type<float>(_e139)));
    local_13 = static_cast<uint>(10);
    uint _e148 = local_13;
    local_50 = static_cast<uint>(_e148);
    uint _e151 = local_50;
    out[_e151] = as_type<uint>(as_type<float>(_e142));
    local_16 = 2139095040u;
    uint _e155 = local_16;
    uint _e158 = _naga_sqrtf(as_type<uint>(as_type<float>(_e155)));
    local_15 = static_cast<uint>(11);
    uint _e164 = local_15;
    local_51 = static_cast<uint>(_e164);
    uint _e167 = local_51;
    out[_e167] = as_type<uint>(as_type<float>(_e158));
    uint _e172 = _naga_sqrtf(as_type<uint>(-(1.0)));
    local_17 = static_cast<uint>(12);
    uint _e178 = local_17;
    local_52 = static_cast<uint>(_e178);
    uint _e181 = local_52;
    out[_e181] = as_type<uint>(as_type<float>(_e172));
    local_19 = 2139095041u;
    uint _e185 = local_19;
    uint _e188 = _naga_sqrtf(as_type<uint>(as_type<float>(_e185)));
    local_18 = static_cast<uint>(13);
    uint _e194 = local_18;
    local_53 = static_cast<uint>(_e194);
    uint _e197 = local_53;
    out[_e197] = as_type<uint>(as_type<float>(_e188));
    value = 4.0;
    float _e201 = value;
    value = _e201 + static_cast<float>(1);
    float _e205 = root_1(_e201);
    local_20 = static_cast<uint>(14);
    uint _e210 = local_20;
    local_54 = static_cast<uint>(_e210);
    uint _e213 = local_54;
    out[_e213] = as_type<uint>(_e205);
    float _e215 = value;
    local_21 = static_cast<uint>(15);
    uint _e220 = local_21;
    local_55 = static_cast<uint>(_e220);
    uint _e223 = local_55;
    out[_e223] = as_type<uint>(_e215);
    int _e226 = sqrtf(true);
    local_22 = static_cast<uint>(16);
    uint _e231 = local_22;
    local_56 = static_cast<uint>(_e231);
    uint _e234 = local_56;
    out[_e234] = static_cast<uint>(_e226);
    int _e237 = sqrtf(false);
    local_23 = static_cast<uint>(17);
    uint _e242 = local_23;
    local_57 = static_cast<uint>(_e242);
    uint _e245 = local_57;
    out[_e245] = static_cast<uint>(_e237);
    float _e249 = sqrtf_1(2.0, 3.0);
    local_24 = static_cast<uint>(18);
    uint _e254 = local_24;
    local_58 = static_cast<uint>(_e254);
    uint _e257 = local_58;
    out[_e257] = as_type<uint>(_e249);
    local_26 = 1065353217u;
    uint _e261 = local_26;
    uint _e264 = _naga_sqrtf(as_type<uint>(as_type<float>(_e261)));
    local_25 = static_cast<uint>(19);
    uint _e270 = local_25;
    local_59 = static_cast<uint>(_e270);
    uint _e273 = local_59;
    out[_e273] = as_type<uint>(as_type<float>(_e264));
    local_28 = 1065353218u;
    uint _e277 = local_28;
    uint _e280 = _naga_sqrtf(as_type<uint>(as_type<float>(_e277)));
    local_27 = static_cast<uint>(20);
    uint _e286 = local_27;
    local_60 = static_cast<uint>(_e286);
    uint _e289 = local_60;
    out[_e289] = as_type<uint>(as_type<float>(_e280));
    local_30 = 1065353215u;
    uint _e293 = local_30;
    uint _e296 = _naga_sqrtf(as_type<uint>(as_type<float>(_e293)));
    local_29 = static_cast<uint>(21);
    uint _e302 = local_29;
    local_61 = static_cast<uint>(_e302);
    uint _e305 = local_61;
    out[_e305] = as_type<uint>(as_type<float>(_e296));
    float _e308 = root_3(4294967295u);
    local_31 = static_cast<uint>(22);
    uint _e313 = local_31;
    local_62 = static_cast<uint>(_e313);
    uint _e316 = local_62;
    out[_e316] = as_type<uint>(_e308);
    float _e320 = root_2(naga_neg(4));
    local_32 = static_cast<uint>(23);
    uint _e325 = local_32;
    local_63 = static_cast<uint>(_e325);
    uint _e328 = local_63;
    out[_e328] = as_type<uint>(_e320);
    float _e331 = root_1(16.0);
    local_33 = static_cast<uint>(24);
    uint _e336 = local_33;
    local_64 = static_cast<uint>(_e336);
    uint _e339 = local_64;
    out[_e339] = as_type<uint>(_e331);
    uint _e343 = _naga_sqrtf(as_type<uint>(0.25));
    local_34 = static_cast<uint>(25);
    uint _e349 = local_34;
    local_65 = static_cast<uint>(_e349);
    uint _e352 = local_65;
    out[_e352] = as_type<uint>(as_type<float>(_e343));
    local_36 = 2147483649u;
    uint _e356 = local_36;
    uint _e359 = _naga_sqrtf(as_type<uint>(as_type<float>(_e356)));
    local_35 = static_cast<uint>(26);
    uint _e365 = local_35;
    local_66 = static_cast<uint>(_e365);
    uint _e368 = local_66;
    out[_e368] = as_type<uint>(as_type<float>(_e359));
    float _e371 = root_4(false);
    local_37 = static_cast<uint>(27);
    uint _e376 = local_37;
    local_67 = static_cast<uint>(_e376);
    uint _e379 = local_67;
    out[_e379] = as_type<uint>(_e371);
    float _e382 = root_4(true);
    local_38 = static_cast<uint>(28);
    uint _e387 = local_38;
    local_68 = static_cast<uint>(_e387);
    uint _e390 = local_68;
    out[_e390] = as_type<uint>(_e382);
    float _e393 = root_1(0.5);
    local_39 = static_cast<uint>(29);
    uint _e398 = local_39;
    local_69 = static_cast<uint>(_e398);
    uint _e401 = local_69;
    out[_e401] = as_type<uint>(_e393);
}
