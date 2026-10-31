// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef float type_1[1];

float min(
    float first_1,
    float second_1,
    float third
) {
    uint _e3 = as_type<uint>(first_1);
    bool _e12 = (_e3 & 2147483647u) > 2139095040u;
    uint _e13 = as_type<uint>(second_1);
    bool _e19 = (_e13 & 2147483647u) > 2139095040u;
    uint _e28 = as_type<uint>(as_type<float>((_e12 && _e19) ? 2143289344u : (_e19 ? _e3 : (_e12 ? _e13 : ((((_e3 >= 2147483648u) ? ~(_e3) : (_e3 ^ 2147483648u)) < ((_e13 >= 2147483648u) ? ~(_e13) : (_e13 ^ 2147483648u))) ? _e3 : _e13)))));
    bool _e37 = (_e28 & 2147483647u) > 2139095040u;
    uint _e38 = as_type<uint>(third);
    bool _e44 = (_e38 & 2147483647u) > 2139095040u;
    return as_type<float>((_e37 && _e44) ? 2143289344u : (_e44 ? _e28 : (_e37 ? _e38 : ((((_e28 >= 2147483648u) ? ~(_e28) : (_e28 ^ 2147483648u)) < ((_e38 >= 2147483648u) ? ~(_e38) : (_e38 ^ 2147483648u))) ? _e28 : _e38))));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

float bounded(
    float value_1
) {
    uint _e6 = as_type<uint>(value_1);
    bool _e15 = (_e6 & 2147483647u) > 2139095040u;
    uint _e16 = as_type<uint>(static_cast<float>(4));
    bool _e22 = (_e16 & 2147483647u) > 2139095040u;
    uint _e31 = as_type<uint>(static_cast<float>(naga_neg(2)));
    bool _e40 = (_e31 & 2147483647u) > 2139095040u;
    uint _e41 = as_type<uint>(as_type<float>((_e15 && _e22) ? 2143289344u : (_e22 ? _e6 : (_e15 ? _e16 : ((((_e6 >= 2147483648u) ? ~(_e6) : (_e6 ^ 2147483648u)) < ((_e16 >= 2147483648u) ? ~(_e16) : (_e16 ^ 2147483648u))) ? _e6 : _e16)))));
    bool _e47 = (_e41 & 2147483647u) > 2139095040u;
    return as_type<float>((_e40 && _e47) ? 2143289344u : (_e47 ? _e31 : (_e40 ? _e41 : ((((_e31 >= 2147483648u) ? ~(_e31) : (_e31 ^ 2147483648u)) > ((_e41 >= 2147483648u) ? ~(_e41) : (_e41 ^ 2147483648u))) ? _e31 : _e41))));
}

kernel void float_minmax(
  device type_1& out [[user(fake0)]]
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
    float first = {};
    float second = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float value = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    float local_21 = {};
    uint local_22 = {};
    float local_23 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_22 = static_cast<uint>(_e3);
    uint _e6 = local_22;
    float _e9 = out[_e6];
    local_23 = _e9;
    float _e11 = local_23;
    local_21 = _e11;
    float seed = local_21;
    uint _e16 = as_type<uint>(seed);
    bool _e25 = (_e16 & 2147483647u) > 2139095040u;
    uint _e26 = as_type<uint>(-(7.5));
    bool _e32 = (_e26 & 2147483647u) > 2139095040u;
    local_1 = static_cast<uint>(0);
    uint _e44 = local_1;
    local_24 = static_cast<uint>(_e44);
    uint _e47 = local_24;
    out[_e47] = as_type<float>((_e25 && _e32) ? 2143289344u : (_e32 ? _e16 : (_e25 ? _e26 : ((((_e16 >= 2147483648u) ? ~(_e16) : (_e16 ^ 2147483648u)) < ((_e26 >= 2147483648u) ? ~(_e26) : (_e26 ^ 2147483648u))) ? _e16 : _e26))));
    uint _e51 = as_type<uint>(seed);
    bool _e60 = (_e51 & 2147483647u) > 2139095040u;
    uint _e61 = as_type<uint>(-(7.5));
    bool _e67 = (_e61 & 2147483647u) > 2139095040u;
    local_2 = static_cast<uint>(1);
    uint _e79 = local_2;
    local_25 = static_cast<uint>(_e79);
    uint _e82 = local_25;
    out[_e82] = as_type<float>((_e60 && _e67) ? 2143289344u : (_e67 ? _e51 : (_e60 ? _e61 : ((((_e51 >= 2147483648u) ? ~(_e51) : (_e51 ^ 2147483648u)) > ((_e61 >= 2147483648u) ? ~(_e61) : (_e61 ^ 2147483648u))) ? _e51 : _e61))));
    uint _e84 = as_type<uint>(seed);
    bool _e93 = (_e84 & 2147483647u) > 2139095040u;
    uint _e95 = as_type<uint>(1.5);
    bool _e101 = (_e95 & 2147483647u) > 2139095040u;
    local_3 = static_cast<uint>(2);
    uint _e113 = local_3;
    local_26 = static_cast<uint>(_e113);
    uint _e116 = local_26;
    out[_e116] = as_type<float>((_e93 && _e101) ? 2143289344u : (_e101 ? _e84 : (_e93 ? _e95 : ((((_e84 >= 2147483648u) ? ~(_e84) : (_e84 ^ 2147483648u)) < ((_e95 >= 2147483648u) ? ~(_e95) : (_e95 ^ 2147483648u))) ? _e84 : _e95))));
    uint _e120 = as_type<uint>(-(2.25));
    bool _e129 = (_e120 & 2147483647u) > 2139095040u;
    uint _e130 = as_type<uint>(seed);
    bool _e136 = (_e130 & 2147483647u) > 2139095040u;
    local_4 = static_cast<uint>(3);
    uint _e148 = local_4;
    local_27 = static_cast<uint>(_e148);
    uint _e151 = local_27;
    out[_e151] = as_type<float>((_e129 && _e136) ? 2143289344u : (_e136 ? _e120 : (_e129 ? _e130 : ((((_e120 >= 2147483648u) ? ~(_e120) : (_e120 ^ 2147483648u)) > ((_e130 >= 2147483648u) ? ~(_e130) : (_e130 ^ 2147483648u))) ? _e120 : _e130))));
    uint _e158 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e167 = (_e158 & 2147483647u) > 2139095040u;
    uint _e168 = as_type<uint>(static_cast<float>(5u));
    bool _e174 = (_e168 & 2147483647u) > 2139095040u;
    local_5 = static_cast<uint>(4);
    uint _e186 = local_5;
    local_28 = static_cast<uint>(_e186);
    uint _e189 = local_28;
    out[_e189] = as_type<float>((_e167 && _e174) ? 2143289344u : (_e174 ? _e158 : (_e167 ? _e168 : ((((_e158 >= 2147483648u) ? ~(_e158) : (_e158 ^ 2147483648u)) < ((_e168 >= 2147483648u) ? ~(_e168) : (_e168 ^ 2147483648u))) ? _e158 : _e168))));
    uint _e196 = as_type<uint>(static_cast<float>(5u));
    bool _e205 = (_e196 & 2147483647u) > 2139095040u;
    uint _e206 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e212 = (_e206 & 2147483647u) > 2139095040u;
    local_6 = static_cast<uint>(5);
    uint _e224 = local_6;
    local_29 = static_cast<uint>(_e224);
    uint _e227 = local_29;
    out[_e227] = as_type<float>((_e205 && _e212) ? 2143289344u : (_e212 ? _e196 : (_e205 ? _e206 : ((((_e196 >= 2147483648u) ? ~(_e196) : (_e196 ^ 2147483648u)) > ((_e206 >= 2147483648u) ? ~(_e206) : (_e206 ^ 2147483648u))) ? _e196 : _e206))));
    uint _e233 = as_type<uint>(static_cast<float>(true));
    bool _e242 = (_e233 & 2147483647u) > 2139095040u;
    uint _e243 = as_type<uint>(static_cast<float>(false));
    bool _e249 = (_e243 & 2147483647u) > 2139095040u;
    local_7 = static_cast<uint>(6);
    uint _e261 = local_7;
    local_30 = static_cast<uint>(_e261);
    uint _e264 = local_30;
    out[_e264] = as_type<float>((_e242 && _e249) ? 2143289344u : (_e249 ? _e233 : (_e242 ? _e243 : ((((_e233 >= 2147483648u) ? ~(_e233) : (_e233 ^ 2147483648u)) < ((_e243 >= 2147483648u) ? ~(_e243) : (_e243 ^ 2147483648u))) ? _e233 : _e243))));
    uint _e270 = as_type<uint>(static_cast<float>(false));
    bool _e279 = (_e270 & 2147483647u) > 2139095040u;
    uint _e280 = as_type<uint>(static_cast<float>(true));
    bool _e286 = (_e280 & 2147483647u) > 2139095040u;
    local_8 = static_cast<uint>(7);
    uint _e298 = local_8;
    local_31 = static_cast<uint>(_e298);
    uint _e301 = local_31;
    out[_e301] = as_type<float>((_e279 && _e286) ? 2143289344u : (_e286 ? _e270 : (_e279 ? _e280 : ((((_e270 >= 2147483648u) ? ~(_e270) : (_e270 ^ 2147483648u)) > ((_e280 >= 2147483648u) ? ~(_e280) : (_e280 ^ 2147483648u))) ? _e270 : _e280))));
    uint _e305 = as_type<uint>(seed);
    bool _e314 = (_e305 & 2147483647u) > 2139095040u;
    uint _e315 = as_type<uint>(-(4.0));
    bool _e321 = (_e315 & 2147483647u) > 2139095040u;
    uint _e330 = as_type<uint>(as_type<float>((_e314 && _e321) ? 2143289344u : (_e321 ? _e305 : (_e314 ? _e315 : ((((_e305 >= 2147483648u) ? ~(_e305) : (_e305 ^ 2147483648u)) > ((_e315 >= 2147483648u) ? ~(_e315) : (_e315 ^ 2147483648u))) ? _e305 : _e315)))));
    bool _e339 = (_e330 & 2147483647u) > 2139095040u;
    uint _e341 = as_type<uint>(2.5);
    bool _e347 = (_e341 & 2147483647u) > 2139095040u;
    local_9 = static_cast<uint>(8);
    uint _e359 = local_9;
    local_32 = static_cast<uint>(_e359);
    uint _e362 = local_32;
    out[_e362] = as_type<float>((_e339 && _e347) ? 2143289344u : (_e347 ? _e330 : (_e339 ? _e341 : ((((_e330 >= 2147483648u) ? ~(_e330) : (_e330 ^ 2147483648u)) < ((_e341 >= 2147483648u) ? ~(_e341) : (_e341 ^ 2147483648u))) ? _e330 : _e341))));
    float _e367 = min(seed, 1.25, -(3.5));
    local_10 = static_cast<uint>(9);
    uint _e371 = local_10;
    local_33 = static_cast<uint>(_e371);
    uint _e374 = local_33;
    out[_e374] = _e367;
    float _e376 = bounded(seed);
    local_11 = static_cast<uint>(10);
    uint _e380 = local_11;
    local_34 = static_cast<uint>(_e380);
    uint _e383 = local_34;
    out[_e383] = _e376;
    first = 1.25;
    second = 2.5;
    float _e389 = first;
    first = _e389 + static_cast<float>(1);
    float _e393 = second;
    second = _e393 + static_cast<float>(1);
    uint _e397 = as_type<uint>(_e389);
    bool _e406 = (_e397 & 2147483647u) > 2139095040u;
    uint _e407 = as_type<uint>(_e393);
    bool _e413 = (_e407 & 2147483647u) > 2139095040u;
    local_12 = static_cast<uint>(11);
    uint _e425 = local_12;
    local_35 = static_cast<uint>(_e425);
    uint _e428 = local_35;
    out[_e428] = as_type<float>((_e406 && _e413) ? 2143289344u : (_e413 ? _e397 : (_e406 ? _e407 : ((((_e397 >= 2147483648u) ? ~(_e397) : (_e397 ^ 2147483648u)) > ((_e407 >= 2147483648u) ? ~(_e407) : (_e407 ^ 2147483648u))) ? _e397 : _e407))));
    float _e430 = first;
    local_13 = static_cast<uint>(12);
    uint _e434 = local_13;
    local_36 = static_cast<uint>(_e434);
    uint _e437 = local_36;
    out[_e437] = _e430;
    float _e439 = second;
    local_14 = static_cast<uint>(13);
    uint _e443 = local_14;
    local_37 = static_cast<uint>(_e443);
    uint _e446 = local_37;
    out[_e446] = _e439;
    value = seed;
    float _e449 = value;
    float _e450 = value;
    value = _e450 + static_cast<float>(1);
    uint _e454 = as_type<uint>(_e449);
    bool _e463 = (_e454 & 2147483647u) > 2139095040u;
    uint _e464 = as_type<uint>(_e450);
    bool _e470 = (_e464 & 2147483647u) > 2139095040u;
    local_15 = static_cast<uint>(14);
    uint _e482 = local_15;
    local_38 = static_cast<uint>(_e482);
    uint _e485 = local_38;
    out[_e485] = as_type<float>((_e463 && _e470) ? 2143289344u : (_e470 ? _e454 : (_e463 ? _e464 : ((((_e454 >= 2147483648u) ? ~(_e454) : (_e454 ^ 2147483648u)) > ((_e464 >= 2147483648u) ? ~(_e464) : (_e464 ^ 2147483648u))) ? _e454 : _e464))));
    float _e487 = value;
    local_16 = static_cast<uint>(15);
    uint _e491 = local_16;
    local_39 = static_cast<uint>(_e491);
    uint _e494 = local_39;
    out[_e494] = _e487;
    uint _e498 = as_type<uint>(static_cast<float>(16777217));
    bool _e507 = (_e498 & 2147483647u) > 2139095040u;
    uint _e509 = as_type<uint>(16777216.0);
    bool _e515 = (_e509 & 2147483647u) > 2139095040u;
    local_17 = static_cast<uint>(16);
    uint _e527 = local_17;
    local_40 = static_cast<uint>(_e527);
    uint _e530 = local_40;
    out[_e530] = as_type<float>((_e507 && _e515) ? 2143289344u : (_e515 ? _e498 : (_e507 ? _e509 : ((((_e498 >= 2147483648u) ? ~(_e498) : (_e498 ^ 2147483648u)) > ((_e509 >= 2147483648u) ? ~(_e509) : (_e509 ^ 2147483648u))) ? _e498 : _e509))));
    uint _e534 = as_type<uint>(static_cast<float>(4294967295u));
    bool _e543 = (_e534 & 2147483647u) > 2139095040u;
    uint _e545 = as_type<uint>(4294967300.0);
    bool _e551 = (_e545 & 2147483647u) > 2139095040u;
    local_18 = static_cast<uint>(17);
    uint _e563 = local_18;
    local_41 = static_cast<uint>(_e563);
    uint _e566 = local_41;
    out[_e566] = as_type<float>((_e543 && _e551) ? 2143289344u : (_e551 ? _e534 : (_e543 ? _e545 : ((((_e534 >= 2147483648u) ? ~(_e534) : (_e534 ^ 2147483648u)) < ((_e545 >= 2147483648u) ? ~(_e545) : (_e545 ^ 2147483648u))) ? _e534 : _e545))));
    uint _e570 = as_type<uint>(static_cast<float>(true));
    bool _e579 = (_e570 & 2147483647u) > 2139095040u;
    uint _e580 = as_type<uint>(seed);
    bool _e586 = (_e580 & 2147483647u) > 2139095040u;
    local_19 = static_cast<uint>(18);
    uint _e598 = local_19;
    local_42 = static_cast<uint>(_e598);
    uint _e601 = local_42;
    out[_e601] = as_type<float>((_e579 && _e586) ? 2143289344u : (_e586 ? _e570 : (_e579 ? _e580 : ((((_e570 >= 2147483648u) ? ~(_e570) : (_e570 ^ 2147483648u)) > ((_e580 >= 2147483648u) ? ~(_e580) : (_e580 ^ 2147483648u))) ? _e570 : _e580))));
    uint _e603 = as_type<uint>(seed);
    bool _e612 = (_e603 & 2147483647u) > 2139095040u;
    uint _e613 = as_type<uint>(seed);
    bool _e619 = (_e613 & 2147483647u) > 2139095040u;
    local_20 = static_cast<uint>(19);
    uint _e631 = local_20;
    local_43 = static_cast<uint>(_e631);
    uint _e634 = local_43;
    out[_e634] = as_type<float>((_e612 && _e619) ? 2143289344u : (_e619 ? _e603 : (_e612 ? _e613 : ((((_e603 >= 2147483648u) ? ~(_e603) : (_e603 ^ 2147483648u)) < ((_e613 >= 2147483648u) ? ~(_e613) : (_e613 ^ 2147483648u))) ? _e603 : _e613))));
}
