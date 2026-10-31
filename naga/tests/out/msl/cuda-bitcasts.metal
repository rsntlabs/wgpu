// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_3[1];

float from_bits(
    uint value_1
) {
    return as_type<float>(value_1);
}

int _float_as_int(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(first) + as_type<uint>(second));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


kernel void bitcasts(
  device type_3& out [[user(fake0)]]
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
    int local_9 = {};
    uint local_10 = {};
    int local_11 = {};
    uint local_12 = {};
    int local_13 = {};
    uint local_14 = {};
    int local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    float value = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    int signed_bits = {};
    uint local_28 = {};
    uint local_29 = {};
    uint unsigned_bits = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    int local_35 = {};
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
    uint local_70 = {};
    local = static_cast<uint>(0);
    uint _e7 = local;
    local_41 = static_cast<uint>(_e7);
    uint _e10 = local_41;
    out[_e10] = static_cast<uint>(as_type<int>(static_cast<float>(true)));
    local_1 = static_cast<uint>(1);
    uint _e20 = local_1;
    local_42 = static_cast<uint>(_e20);
    uint _e23 = local_42;
    out[_e23] = static_cast<uint>(as_type<int>(static_cast<float>(3)));
    local_2 = static_cast<uint>(2);
    uint _e32 = local_2;
    local_43 = static_cast<uint>(_e32);
    uint _e35 = local_43;
    out[_e35] = static_cast<uint>(as_type<int>(static_cast<float>(5u)));
    local_3 = static_cast<uint>(3);
    uint _e43 = local_3;
    local_44 = static_cast<uint>(_e43);
    uint _e46 = local_44;
    out[_e46] = static_cast<uint>(as_type<int>(2.75));
    local_4 = static_cast<uint>(4);
    uint _e54 = local_4;
    local_45 = static_cast<uint>(_e54);
    uint _e57 = local_45;
    out[_e57] = as_type<uint>(static_cast<float>(true));
    local_5 = static_cast<uint>(5);
    uint _e65 = local_5;
    local_46 = static_cast<uint>(_e65);
    uint _e68 = local_46;
    out[_e68] = as_type<uint>(static_cast<float>(3));
    local_6 = static_cast<uint>(6);
    uint _e76 = local_6;
    local_47 = static_cast<uint>(_e76);
    uint _e79 = local_47;
    out[_e79] = as_type<uint>(static_cast<float>(5u));
    local_7 = static_cast<uint>(7);
    uint _e86 = local_7;
    local_48 = static_cast<uint>(_e86);
    uint _e89 = local_48;
    out[_e89] = as_type<uint>(2.75);
    local_9 = static_cast<int>(true);
    int _e94 = local_9;
    local_8 = static_cast<uint>(8);
    uint _e100 = local_8;
    local_49 = static_cast<uint>(_e100);
    uint _e103 = local_49;
    out[_e103] = as_type<uint>(as_type<float>(_e94));
    local_11 = 3;
    int _e107 = local_11;
    local_10 = static_cast<uint>(9);
    uint _e113 = local_10;
    local_50 = static_cast<uint>(_e113);
    uint _e116 = local_50;
    out[_e116] = as_type<uint>(as_type<float>(_e107));
    local_13 = static_cast<int>(5u);
    int _e121 = local_13;
    local_12 = static_cast<uint>(10);
    uint _e127 = local_12;
    local_51 = static_cast<uint>(_e127);
    uint _e130 = local_51;
    out[_e130] = as_type<uint>(as_type<float>(_e121));
    local_15 = naga_f2i32(2.75);
    int _e135 = local_15;
    local_14 = static_cast<uint>(11);
    uint _e141 = local_14;
    local_52 = static_cast<uint>(_e141);
    uint _e144 = local_52;
    out[_e144] = as_type<uint>(as_type<float>(_e135));
    local_17 = static_cast<uint>(true);
    uint _e149 = local_17;
    local_16 = static_cast<uint>(12);
    uint _e155 = local_16;
    local_53 = static_cast<uint>(_e155);
    uint _e158 = local_53;
    out[_e158] = as_type<uint>(as_type<float>(_e149));
    local_19 = static_cast<uint>(3);
    uint _e163 = local_19;
    local_18 = static_cast<uint>(13);
    uint _e169 = local_18;
    local_54 = static_cast<uint>(_e169);
    uint _e172 = local_54;
    out[_e172] = as_type<uint>(as_type<float>(_e163));
    local_21 = 5u;
    uint _e176 = local_21;
    local_20 = static_cast<uint>(14);
    uint _e182 = local_20;
    local_55 = static_cast<uint>(_e182);
    uint _e185 = local_55;
    out[_e185] = as_type<uint>(as_type<float>(_e176));
    local_23 = naga_f2u32(2.75);
    uint _e190 = local_23;
    local_22 = static_cast<uint>(15);
    uint _e196 = local_22;
    local_56 = static_cast<uint>(_e196);
    uint _e199 = local_56;
    out[_e199] = as_type<uint>(as_type<float>(_e190));
    value = 1.5;
    float _e203 = value;
    value = _e203 + static_cast<float>(1);
    local_24 = static_cast<uint>(16);
    uint _e212 = local_24;
    local_57 = static_cast<uint>(_e212);
    uint _e215 = local_57;
    out[_e215] = static_cast<uint>(as_type<int>(_e203));
    float _e217 = value;
    local_25 = static_cast<uint>(17);
    uint _e222 = local_25;
    local_58 = static_cast<uint>(_e222);
    uint _e225 = local_58;
    out[_e225] = as_type<uint>(_e217);
    float _e227 = value;
    value = _e227 + static_cast<float>(1);
    local_26 = static_cast<uint>(18);
    uint _e235 = local_26;
    local_59 = static_cast<uint>(_e235);
    uint _e238 = local_59;
    out[_e238] = as_type<uint>(_e227);
    float _e240 = value;
    local_27 = static_cast<uint>(19);
    uint _e245 = local_27;
    local_60 = static_cast<uint>(_e245);
    uint _e248 = local_60;
    out[_e248] = as_type<uint>(_e240);
    signed_bits = 1065353216;
    int _e252 = signed_bits;
    signed_bits = as_type<int>(as_type<uint>(_e252) + as_type<uint>(1));
    local_28 = static_cast<uint>(20);
    uint _e260 = local_28;
    local_61 = static_cast<uint>(_e260);
    uint _e263 = local_61;
    out[_e263] = as_type<uint>(as_type<float>(_e252));
    int _e265 = signed_bits;
    local_29 = static_cast<uint>(21);
    uint _e270 = local_29;
    local_62 = static_cast<uint>(_e270);
    uint _e273 = local_62;
    out[_e273] = static_cast<uint>(_e265);
    unsigned_bits = 1073741824u;
    uint _e277 = unsigned_bits;
    unsigned_bits = _e277 + static_cast<uint>(1);
    local_30 = static_cast<uint>(22);
    uint _e286 = local_30;
    local_63 = static_cast<uint>(_e286);
    uint _e289 = local_63;
    out[_e289] = as_type<uint>(as_type<float>(_e277));
    uint _e291 = unsigned_bits;
    local_31 = static_cast<uint>(23);
    uint _e295 = local_31;
    local_64 = static_cast<uint>(_e295);
    uint _e298 = local_64;
    out[_e298] = _e291;
    int _e302 = _float_as_int(3, 4);
    local_32 = static_cast<uint>(24);
    uint _e307 = local_32;
    local_65 = static_cast<uint>(_e307);
    uint _e310 = local_65;
    out[_e310] = static_cast<uint>(_e302);
    float _e313 = from_bits(3212836864u);
    local_33 = static_cast<uint>(25);
    uint _e318 = local_33;
    local_66 = static_cast<uint>(_e318);
    uint _e321 = local_66;
    out[_e321] = as_type<uint>(_e313);
    local_35 = 2139095040;
    int _e325 = local_35;
    local_34 = static_cast<uint>(26);
    uint _e331 = local_34;
    local_67 = static_cast<uint>(_e331);
    uint _e334 = local_67;
    out[_e334] = as_type<uint>(as_type<float>(_e325));
    local_37 = 2143363909u;
    uint _e338 = local_37;
    local_36 = static_cast<uint>(27);
    uint _e344 = local_36;
    local_68 = static_cast<uint>(_e344);
    uint _e347 = local_68;
    out[_e347] = as_type<uint>(as_type<float>(_e338));
    local_39 = naga_f2u32(1065353200.0);
    uint _e352 = local_39;
    local_38 = static_cast<uint>(28);
    uint _e358 = local_38;
    local_69 = static_cast<uint>(_e358);
    uint _e361 = local_69;
    out[_e361] = as_type<uint>(as_type<float>(_e352));
    local_40 = static_cast<uint>(29);
    uint _e370 = local_40;
    local_70 = static_cast<uint>(_e370);
    uint _e373 = local_70;
    out[_e373] = static_cast<uint>(as_type<int>(static_cast<float>(1u)));
}
