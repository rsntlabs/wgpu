// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef uint type_6[1];

metal::float2 fabs(
    metal::float2 value_1
) {
    metal::float2 value_2 = {};
    uint local_83 = {};
    uint local_84 = {};
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_83 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_83;
    float _e15 = value_2.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_84 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_84;
    return metal::float2(as_type<float>(_e12), as_type<float>(_e24));
}

float3_ fabs_1(
    float3_ value_3
) {
    float3_ value_4 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_85 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_85;
    float _e15 = value_4.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_86 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_86;
    float _e27 = value_4.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_87 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_87;
    return float3_ {as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36)};
}

metal::float4 fabs_2(
    metal::float4 value_5
) {
    metal::float4 value_6 = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_88 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_88;
    float _e15 = value_6.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_89 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_89;
    float _e27 = value_6.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_90 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_90;
    float _e39 = value_6.w;
    uint _e42 = as_type<uint>(_e39) & 2147483647u;
    local_91 = (_e42 > 2139095040u) ? 2143289344u : _e42;
    uint _e48 = local_91;
    return metal::float4(as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36), as_type<float>(_e48));
}

float absolute(
    float value_7
) {
    uint local_92 = {};
    uint _e3 = as_type<uint>(value_7) & 2147483647u;
    local_92 = (_e3 > 2139095040u) ? 2143289344u : _e3;
    uint _e9 = local_92;
    return as_type<float>(_e9);
}

float converted_absolute(
    int value_8
) {
    uint local_93 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_8)) & 2147483647u;
    local_93 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_93;
    return as_type<float>(_e10);
}

float converted_absolute_1(
    uint value_9
) {
    uint local_94 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_9)) & 2147483647u;
    local_94 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_94;
    return as_type<float>(_e10);
}

float converted_absolute_2(
    bool value_10
) {
    uint local_95 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_10)) & 2147483647u;
    local_95 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_95;
    return as_type<float>(_e10);
}

int fabs_3(
    int value_11
) {
    return as_type<int>(as_type<uint>(value_11) + as_type<uint>(40));
}

uint fabs_4(
    uint value_12
) {
    return value_12 + 50u;
}

int fabs_5(
    bool value_13
) {
    int local_96 = {};
    if (value_13) {
        local_96 = 7;
    } else {
        local_96 = 9;
    }
    int _e6 = local_96;
    return _e6;
}

int fabsf(
    bool value_14
) {
    int local_97 = {};
    if (value_14) {
        local_97 = 11;
    } else {
        local_97 = 13;
    }
    int _e6 = local_97;
    return _e6;
}

float fabsf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void absolutes(
  device type_6& out [[user(fake0)]]
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
    float value = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    float3_ triple = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    metal::float2 pair = {};
    metal::float4 quadruple = {};
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
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    uint _e3 = as_type<uint>(0.0) & 2147483647u;
    local_1 = (_e3 > 2139095040u) ? 2143289344u : _e3;
    uint _e9 = local_1;
    local = static_cast<uint>(0);
    uint _e16 = local;
    local_53 = static_cast<uint>(_e16);
    uint _e19 = local_53;
    out[_e19] = as_type<uint>(as_type<float>(_e9));
    uint _e25 = as_type<uint>(-(0.0)) & 2147483647u;
    local_3 = (_e25 > 2139095040u) ? 2143289344u : _e25;
    uint _e31 = local_3;
    local_2 = static_cast<uint>(1);
    uint _e37 = local_2;
    local_54 = static_cast<uint>(_e37);
    uint _e40 = local_54;
    out[_e40] = as_type<uint>(as_type<float>(_e31));
    uint _e46 = as_type<uint>(-(1.75)) & 2147483647u;
    local_5 = (_e46 > 2139095040u) ? 2143289344u : _e46;
    uint _e52 = local_5;
    local_4 = static_cast<uint>(2);
    uint _e58 = local_4;
    local_55 = static_cast<uint>(_e58);
    uint _e61 = local_55;
    out[_e61] = as_type<uint>(as_type<float>(_e52));
    float _e65 = absolute(-(1.25));
    local_6 = static_cast<uint>(3);
    uint _e70 = local_6;
    local_56 = static_cast<uint>(_e70);
    uint _e73 = local_56;
    out[_e73] = as_type<uint>(_e65);
    float _e77 = converted_absolute(naga_neg(3));
    local_7 = static_cast<uint>(4);
    uint _e82 = local_7;
    local_57 = static_cast<uint>(_e82);
    uint _e85 = local_57;
    out[_e85] = as_type<uint>(_e77);
    float _e88 = converted_absolute_1(4294967295u);
    local_8 = static_cast<uint>(5);
    uint _e93 = local_8;
    local_58 = static_cast<uint>(_e93);
    uint _e96 = local_58;
    out[_e96] = as_type<uint>(_e88);
    float _e99 = converted_absolute_2(true);
    local_9 = static_cast<uint>(6);
    uint _e104 = local_9;
    local_59 = static_cast<uint>(_e104);
    uint _e107 = local_59;
    out[_e107] = as_type<uint>(_e99);
    float _e110 = converted_absolute_2(false);
    local_10 = static_cast<uint>(7);
    uint _e115 = local_10;
    local_60 = static_cast<uint>(_e115);
    uint _e118 = local_60;
    out[_e118] = as_type<uint>(_e110);
    local_12 = 1u;
    uint _e122 = local_12;
    uint _e126 = as_type<uint>(as_type<float>(_e122)) & 2147483647u;
    local_13 = (_e126 > 2139095040u) ? 2143289344u : _e126;
    uint _e132 = local_13;
    local_11 = static_cast<uint>(8);
    uint _e138 = local_11;
    local_61 = static_cast<uint>(_e138);
    uint _e141 = local_61;
    out[_e141] = as_type<uint>(as_type<float>(_e132));
    local_15 = 2147483649u;
    uint _e145 = local_15;
    uint _e149 = as_type<uint>(as_type<float>(_e145)) & 2147483647u;
    local_16 = (_e149 > 2139095040u) ? 2143289344u : _e149;
    uint _e155 = local_16;
    local_14 = static_cast<uint>(9);
    uint _e161 = local_14;
    local_62 = static_cast<uint>(_e161);
    uint _e164 = local_62;
    out[_e164] = as_type<uint>(as_type<float>(_e155));
    local_18 = 8388607u;
    uint _e168 = local_18;
    uint _e172 = as_type<uint>(as_type<float>(_e168)) & 2147483647u;
    local_19 = (_e172 > 2139095040u) ? 2143289344u : _e172;
    uint _e178 = local_19;
    local_17 = static_cast<uint>(10);
    uint _e184 = local_17;
    local_63 = static_cast<uint>(_e184);
    uint _e187 = local_63;
    out[_e187] = as_type<uint>(as_type<float>(_e178));
    local_21 = 2155872255u;
    uint _e191 = local_21;
    uint _e195 = as_type<uint>(as_type<float>(_e191)) & 2147483647u;
    local_22 = (_e195 > 2139095040u) ? 2143289344u : _e195;
    uint _e201 = local_22;
    local_20 = static_cast<uint>(11);
    uint _e207 = local_20;
    local_64 = static_cast<uint>(_e207);
    uint _e210 = local_64;
    out[_e210] = as_type<uint>(as_type<float>(_e201));
    uint _e215 = as_type<uint>(340282350000000000000000000000000000000.0) & 2147483647u;
    local_24 = (_e215 > 2139095040u) ? 2143289344u : _e215;
    uint _e221 = local_24;
    local_23 = static_cast<uint>(12);
    uint _e227 = local_23;
    local_65 = static_cast<uint>(_e227);
    uint _e230 = local_65;
    out[_e230] = as_type<uint>(as_type<float>(_e221));
    uint _e236 = as_type<uint>(-(340282350000000000000000000000000000000.0)) & 2147483647u;
    local_26 = (_e236 > 2139095040u) ? 2143289344u : _e236;
    uint _e242 = local_26;
    local_25 = static_cast<uint>(13);
    uint _e248 = local_25;
    local_66 = static_cast<uint>(_e248);
    uint _e251 = local_66;
    out[_e251] = as_type<uint>(as_type<float>(_e242));
    local_28 = 2139095040u;
    uint _e255 = local_28;
    uint _e259 = as_type<uint>(as_type<float>(_e255)) & 2147483647u;
    local_29 = (_e259 > 2139095040u) ? 2143289344u : _e259;
    uint _e265 = local_29;
    local_27 = static_cast<uint>(14);
    uint _e271 = local_27;
    local_67 = static_cast<uint>(_e271);
    uint _e274 = local_67;
    out[_e274] = as_type<uint>(as_type<float>(_e265));
    local_31 = 4286578688u;
    uint _e278 = local_31;
    uint _e282 = as_type<uint>(as_type<float>(_e278)) & 2147483647u;
    local_32 = (_e282 > 2139095040u) ? 2143289344u : _e282;
    uint _e288 = local_32;
    local_30 = static_cast<uint>(15);
    uint _e294 = local_30;
    local_68 = static_cast<uint>(_e294);
    uint _e297 = local_68;
    out[_e297] = as_type<uint>(as_type<float>(_e288));
    local_34 = 2143363909u;
    uint _e301 = local_34;
    uint _e305 = as_type<uint>(as_type<float>(_e301)) & 2147483647u;
    local_35 = (_e305 > 2139095040u) ? 2143289344u : _e305;
    uint _e311 = local_35;
    local_33 = static_cast<uint>(16);
    uint _e317 = local_33;
    local_69 = static_cast<uint>(_e317);
    uint _e320 = local_69;
    out[_e320] = as_type<uint>(as_type<float>(_e311));
    local_37 = 2139095041u;
    uint _e324 = local_37;
    uint _e328 = as_type<uint>(as_type<float>(_e324)) & 2147483647u;
    local_38 = (_e328 > 2139095040u) ? 2143289344u : _e328;
    uint _e334 = local_38;
    local_36 = static_cast<uint>(17);
    uint _e340 = local_36;
    local_70 = static_cast<uint>(_e340);
    uint _e343 = local_70;
    out[_e343] = as_type<uint>(as_type<float>(_e334));
    value = -(2.75);
    float _e348 = value;
    value = _e348 + static_cast<float>(1);
    uint _e354 = as_type<uint>(_e348) & 2147483647u;
    local_40 = (_e354 > 2139095040u) ? 2143289344u : _e354;
    uint _e360 = local_40;
    local_39 = static_cast<uint>(18);
    uint _e366 = local_39;
    local_71 = static_cast<uint>(_e366);
    uint _e369 = local_71;
    out[_e369] = as_type<uint>(as_type<float>(_e360));
    float _e371 = value;
    local_41 = static_cast<uint>(19);
    uint _e376 = local_41;
    local_72 = static_cast<uint>(_e376);
    uint _e379 = local_72;
    out[_e379] = as_type<uint>(_e371);
    int _e383 = fabs_3(naga_neg(3));
    local_42 = static_cast<uint>(20);
    uint _e388 = local_42;
    local_73 = static_cast<uint>(_e388);
    uint _e391 = local_73;
    out[_e391] = static_cast<uint>(_e383);
    uint _e394 = fabs_4(3u);
    local_43 = static_cast<uint>(21);
    uint _e398 = local_43;
    local_74 = static_cast<uint>(_e398);
    uint _e401 = local_74;
    out[_e401] = _e394;
    int _e404 = fabs_5(true);
    local_44 = static_cast<uint>(22);
    uint _e409 = local_44;
    local_75 = static_cast<uint>(_e409);
    uint _e412 = local_75;
    out[_e412] = static_cast<uint>(_e404);
    int _e415 = fabs_5(false);
    local_45 = static_cast<uint>(23);
    uint _e420 = local_45;
    local_76 = static_cast<uint>(_e420);
    uint _e423 = local_76;
    out[_e423] = static_cast<uint>(_e415);
    int _e426 = fabsf(true);
    local_46 = static_cast<uint>(24);
    uint _e431 = local_46;
    local_77 = static_cast<uint>(_e431);
    uint _e434 = local_77;
    out[_e434] = static_cast<uint>(_e426);
    local_47 = 2147483649u;
    uint _e442 = local_47;
    float3_ _e445 = fabs_1(float3_ {-(2.5), -(0.0), as_type<float>(_e442)});
    triple = _e445;
    float _e448 = triple.x;
    local_48 = static_cast<uint>(25);
    uint _e453 = local_48;
    local_78 = static_cast<uint>(_e453);
    uint _e456 = local_78;
    out[_e456] = as_type<uint>(_e448);
    float _e459 = triple.y;
    local_49 = static_cast<uint>(26);
    uint _e464 = local_49;
    local_79 = static_cast<uint>(_e464);
    uint _e467 = local_79;
    out[_e467] = as_type<uint>(_e459);
    float _e470 = triple.z;
    local_50 = static_cast<uint>(27);
    uint _e475 = local_50;
    local_80 = static_cast<uint>(_e475);
    uint _e478 = local_80;
    out[_e478] = as_type<uint>(_e470);
    float _e483 = fabsf_1(-(2.0), 3.0);
    local_51 = static_cast<uint>(28);
    uint _e488 = local_51;
    local_81 = static_cast<uint>(_e488);
    uint _e491 = local_81;
    out[_e491] = as_type<uint>(_e483);
    metal::float2 _e498 = fabs(metal::float2(-(3.0), -(4.0)));
    pair = _e498;
    metal::float4 _e509 = fabs_2(metal::float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e509;
    float _e513 = pair.x;
    float _e514 = pair.y;
    float _e517 = quadruple.x;
    float _e520 = quadruple.w;
    local_52 = static_cast<uint>(29);
    uint _e526 = local_52;
    local_82 = static_cast<uint>(_e526);
    uint _e529 = local_82;
    out[_e529] = as_type<uint>(((_e513 + _e514) + _e517) + _e520);
}
