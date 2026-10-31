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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_21 = static_cast<uint>(_e3);
    uint _e6 = local_21;
    float seed = out[_e6];
    uint _e12 = as_type<uint>(seed);
    bool _e21 = (_e12 & 2147483647u) > 2139095040u;
    uint _e22 = as_type<uint>(-(7.5));
    bool _e28 = (_e22 & 2147483647u) > 2139095040u;
    local_1 = static_cast<uint>(0);
    uint _e40 = local_1;
    local_22 = static_cast<uint>(_e40);
    uint _e43 = local_22;
    out[_e43] = as_type<float>((_e21 && _e28) ? 2143289344u : (_e28 ? _e12 : (_e21 ? _e22 : ((((_e12 >= 2147483648u) ? ~(_e12) : (_e12 ^ 2147483648u)) < ((_e22 >= 2147483648u) ? ~(_e22) : (_e22 ^ 2147483648u))) ? _e12 : _e22))));
    uint _e47 = as_type<uint>(seed);
    bool _e56 = (_e47 & 2147483647u) > 2139095040u;
    uint _e57 = as_type<uint>(-(7.5));
    bool _e63 = (_e57 & 2147483647u) > 2139095040u;
    local_2 = static_cast<uint>(1);
    uint _e75 = local_2;
    local_23 = static_cast<uint>(_e75);
    uint _e78 = local_23;
    out[_e78] = as_type<float>((_e56 && _e63) ? 2143289344u : (_e63 ? _e47 : (_e56 ? _e57 : ((((_e47 >= 2147483648u) ? ~(_e47) : (_e47 ^ 2147483648u)) > ((_e57 >= 2147483648u) ? ~(_e57) : (_e57 ^ 2147483648u))) ? _e47 : _e57))));
    uint _e80 = as_type<uint>(seed);
    bool _e89 = (_e80 & 2147483647u) > 2139095040u;
    uint _e91 = as_type<uint>(1.5);
    bool _e97 = (_e91 & 2147483647u) > 2139095040u;
    local_3 = static_cast<uint>(2);
    uint _e109 = local_3;
    local_24 = static_cast<uint>(_e109);
    uint _e112 = local_24;
    out[_e112] = as_type<float>((_e89 && _e97) ? 2143289344u : (_e97 ? _e80 : (_e89 ? _e91 : ((((_e80 >= 2147483648u) ? ~(_e80) : (_e80 ^ 2147483648u)) < ((_e91 >= 2147483648u) ? ~(_e91) : (_e91 ^ 2147483648u))) ? _e80 : _e91))));
    uint _e116 = as_type<uint>(-(2.25));
    bool _e125 = (_e116 & 2147483647u) > 2139095040u;
    uint _e126 = as_type<uint>(seed);
    bool _e132 = (_e126 & 2147483647u) > 2139095040u;
    local_4 = static_cast<uint>(3);
    uint _e144 = local_4;
    local_25 = static_cast<uint>(_e144);
    uint _e147 = local_25;
    out[_e147] = as_type<float>((_e125 && _e132) ? 2143289344u : (_e132 ? _e116 : (_e125 ? _e126 : ((((_e116 >= 2147483648u) ? ~(_e116) : (_e116 ^ 2147483648u)) > ((_e126 >= 2147483648u) ? ~(_e126) : (_e126 ^ 2147483648u))) ? _e116 : _e126))));
    uint _e154 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e163 = (_e154 & 2147483647u) > 2139095040u;
    uint _e164 = as_type<uint>(static_cast<float>(5u));
    bool _e170 = (_e164 & 2147483647u) > 2139095040u;
    local_5 = static_cast<uint>(4);
    uint _e182 = local_5;
    local_26 = static_cast<uint>(_e182);
    uint _e185 = local_26;
    out[_e185] = as_type<float>((_e163 && _e170) ? 2143289344u : (_e170 ? _e154 : (_e163 ? _e164 : ((((_e154 >= 2147483648u) ? ~(_e154) : (_e154 ^ 2147483648u)) < ((_e164 >= 2147483648u) ? ~(_e164) : (_e164 ^ 2147483648u))) ? _e154 : _e164))));
    uint _e192 = as_type<uint>(static_cast<float>(5u));
    bool _e201 = (_e192 & 2147483647u) > 2139095040u;
    uint _e202 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e208 = (_e202 & 2147483647u) > 2139095040u;
    local_6 = static_cast<uint>(5);
    uint _e220 = local_6;
    local_27 = static_cast<uint>(_e220);
    uint _e223 = local_27;
    out[_e223] = as_type<float>((_e201 && _e208) ? 2143289344u : (_e208 ? _e192 : (_e201 ? _e202 : ((((_e192 >= 2147483648u) ? ~(_e192) : (_e192 ^ 2147483648u)) > ((_e202 >= 2147483648u) ? ~(_e202) : (_e202 ^ 2147483648u))) ? _e192 : _e202))));
    uint _e229 = as_type<uint>(static_cast<float>(true));
    bool _e238 = (_e229 & 2147483647u) > 2139095040u;
    uint _e239 = as_type<uint>(static_cast<float>(false));
    bool _e245 = (_e239 & 2147483647u) > 2139095040u;
    local_7 = static_cast<uint>(6);
    uint _e257 = local_7;
    local_28 = static_cast<uint>(_e257);
    uint _e260 = local_28;
    out[_e260] = as_type<float>((_e238 && _e245) ? 2143289344u : (_e245 ? _e229 : (_e238 ? _e239 : ((((_e229 >= 2147483648u) ? ~(_e229) : (_e229 ^ 2147483648u)) < ((_e239 >= 2147483648u) ? ~(_e239) : (_e239 ^ 2147483648u))) ? _e229 : _e239))));
    uint _e266 = as_type<uint>(static_cast<float>(false));
    bool _e275 = (_e266 & 2147483647u) > 2139095040u;
    uint _e276 = as_type<uint>(static_cast<float>(true));
    bool _e282 = (_e276 & 2147483647u) > 2139095040u;
    local_8 = static_cast<uint>(7);
    uint _e294 = local_8;
    local_29 = static_cast<uint>(_e294);
    uint _e297 = local_29;
    out[_e297] = as_type<float>((_e275 && _e282) ? 2143289344u : (_e282 ? _e266 : (_e275 ? _e276 : ((((_e266 >= 2147483648u) ? ~(_e266) : (_e266 ^ 2147483648u)) > ((_e276 >= 2147483648u) ? ~(_e276) : (_e276 ^ 2147483648u))) ? _e266 : _e276))));
    uint _e301 = as_type<uint>(seed);
    bool _e310 = (_e301 & 2147483647u) > 2139095040u;
    uint _e311 = as_type<uint>(-(4.0));
    bool _e317 = (_e311 & 2147483647u) > 2139095040u;
    uint _e326 = as_type<uint>(as_type<float>((_e310 && _e317) ? 2143289344u : (_e317 ? _e301 : (_e310 ? _e311 : ((((_e301 >= 2147483648u) ? ~(_e301) : (_e301 ^ 2147483648u)) > ((_e311 >= 2147483648u) ? ~(_e311) : (_e311 ^ 2147483648u))) ? _e301 : _e311)))));
    bool _e335 = (_e326 & 2147483647u) > 2139095040u;
    uint _e337 = as_type<uint>(2.5);
    bool _e343 = (_e337 & 2147483647u) > 2139095040u;
    local_9 = static_cast<uint>(8);
    uint _e355 = local_9;
    local_30 = static_cast<uint>(_e355);
    uint _e358 = local_30;
    out[_e358] = as_type<float>((_e335 && _e343) ? 2143289344u : (_e343 ? _e326 : (_e335 ? _e337 : ((((_e326 >= 2147483648u) ? ~(_e326) : (_e326 ^ 2147483648u)) < ((_e337 >= 2147483648u) ? ~(_e337) : (_e337 ^ 2147483648u))) ? _e326 : _e337))));
    float _e363 = min(seed, 1.25, -(3.5));
    local_10 = static_cast<uint>(9);
    uint _e367 = local_10;
    local_31 = static_cast<uint>(_e367);
    uint _e370 = local_31;
    out[_e370] = _e363;
    float _e372 = bounded(seed);
    local_11 = static_cast<uint>(10);
    uint _e376 = local_11;
    local_32 = static_cast<uint>(_e376);
    uint _e379 = local_32;
    out[_e379] = _e372;
    first = 1.25;
    second = 2.5;
    float _e385 = first;
    first = _e385 + static_cast<float>(1);
    float _e389 = second;
    second = _e389 + static_cast<float>(1);
    uint _e393 = as_type<uint>(_e385);
    bool _e402 = (_e393 & 2147483647u) > 2139095040u;
    uint _e403 = as_type<uint>(_e389);
    bool _e409 = (_e403 & 2147483647u) > 2139095040u;
    local_12 = static_cast<uint>(11);
    uint _e421 = local_12;
    local_33 = static_cast<uint>(_e421);
    uint _e424 = local_33;
    out[_e424] = as_type<float>((_e402 && _e409) ? 2143289344u : (_e409 ? _e393 : (_e402 ? _e403 : ((((_e393 >= 2147483648u) ? ~(_e393) : (_e393 ^ 2147483648u)) > ((_e403 >= 2147483648u) ? ~(_e403) : (_e403 ^ 2147483648u))) ? _e393 : _e403))));
    float _e426 = first;
    local_13 = static_cast<uint>(12);
    uint _e430 = local_13;
    local_34 = static_cast<uint>(_e430);
    uint _e433 = local_34;
    out[_e433] = _e426;
    float _e435 = second;
    local_14 = static_cast<uint>(13);
    uint _e439 = local_14;
    local_35 = static_cast<uint>(_e439);
    uint _e442 = local_35;
    out[_e442] = _e435;
    value = seed;
    float _e445 = value;
    float _e446 = value;
    value = _e446 + static_cast<float>(1);
    uint _e450 = as_type<uint>(_e445);
    bool _e459 = (_e450 & 2147483647u) > 2139095040u;
    uint _e460 = as_type<uint>(_e446);
    bool _e466 = (_e460 & 2147483647u) > 2139095040u;
    local_15 = static_cast<uint>(14);
    uint _e478 = local_15;
    local_36 = static_cast<uint>(_e478);
    uint _e481 = local_36;
    out[_e481] = as_type<float>((_e459 && _e466) ? 2143289344u : (_e466 ? _e450 : (_e459 ? _e460 : ((((_e450 >= 2147483648u) ? ~(_e450) : (_e450 ^ 2147483648u)) > ((_e460 >= 2147483648u) ? ~(_e460) : (_e460 ^ 2147483648u))) ? _e450 : _e460))));
    float _e483 = value;
    local_16 = static_cast<uint>(15);
    uint _e487 = local_16;
    local_37 = static_cast<uint>(_e487);
    uint _e490 = local_37;
    out[_e490] = _e483;
    uint _e494 = as_type<uint>(static_cast<float>(16777217));
    bool _e503 = (_e494 & 2147483647u) > 2139095040u;
    uint _e505 = as_type<uint>(16777216.0);
    bool _e511 = (_e505 & 2147483647u) > 2139095040u;
    local_17 = static_cast<uint>(16);
    uint _e523 = local_17;
    local_38 = static_cast<uint>(_e523);
    uint _e526 = local_38;
    out[_e526] = as_type<float>((_e503 && _e511) ? 2143289344u : (_e511 ? _e494 : (_e503 ? _e505 : ((((_e494 >= 2147483648u) ? ~(_e494) : (_e494 ^ 2147483648u)) > ((_e505 >= 2147483648u) ? ~(_e505) : (_e505 ^ 2147483648u))) ? _e494 : _e505))));
    uint _e530 = as_type<uint>(static_cast<float>(4294967295u));
    bool _e539 = (_e530 & 2147483647u) > 2139095040u;
    uint _e541 = as_type<uint>(4294967300.0);
    bool _e547 = (_e541 & 2147483647u) > 2139095040u;
    local_18 = static_cast<uint>(17);
    uint _e559 = local_18;
    local_39 = static_cast<uint>(_e559);
    uint _e562 = local_39;
    out[_e562] = as_type<float>((_e539 && _e547) ? 2143289344u : (_e547 ? _e530 : (_e539 ? _e541 : ((((_e530 >= 2147483648u) ? ~(_e530) : (_e530 ^ 2147483648u)) < ((_e541 >= 2147483648u) ? ~(_e541) : (_e541 ^ 2147483648u))) ? _e530 : _e541))));
    uint _e566 = as_type<uint>(static_cast<float>(true));
    bool _e575 = (_e566 & 2147483647u) > 2139095040u;
    uint _e576 = as_type<uint>(seed);
    bool _e582 = (_e576 & 2147483647u) > 2139095040u;
    local_19 = static_cast<uint>(18);
    uint _e594 = local_19;
    local_40 = static_cast<uint>(_e594);
    uint _e597 = local_40;
    out[_e597] = as_type<float>((_e575 && _e582) ? 2143289344u : (_e582 ? _e566 : (_e575 ? _e576 : ((((_e566 >= 2147483648u) ? ~(_e566) : (_e566 ^ 2147483648u)) > ((_e576 >= 2147483648u) ? ~(_e576) : (_e576 ^ 2147483648u))) ? _e566 : _e576))));
    uint _e599 = as_type<uint>(seed);
    bool _e608 = (_e599 & 2147483647u) > 2139095040u;
    uint _e609 = as_type<uint>(seed);
    bool _e615 = (_e609 & 2147483647u) > 2139095040u;
    local_20 = static_cast<uint>(19);
    uint _e627 = local_20;
    local_41 = static_cast<uint>(_e627);
    uint _e630 = local_41;
    out[_e630] = as_type<float>((_e608 && _e615) ? 2143289344u : (_e615 ? _e599 : (_e608 ? _e609 : ((((_e599 >= 2147483648u) ? ~(_e599) : (_e599 ^ 2147483648u)) < ((_e609 >= 2147483648u) ? ~(_e609) : (_e609 ^ 2147483648u))) ? _e599 : _e609))));
}
