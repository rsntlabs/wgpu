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
    local = static_cast<uint>(0);
    uint _e7 = local;
    out[_e7] = static_cast<uint>(as_type<int>(static_cast<float>(true)));
    local_1 = static_cast<uint>(1);
    uint _e17 = local_1;
    out[_e17] = static_cast<uint>(as_type<int>(static_cast<float>(3)));
    local_2 = static_cast<uint>(2);
    uint _e26 = local_2;
    out[_e26] = static_cast<uint>(as_type<int>(static_cast<float>(5u)));
    local_3 = static_cast<uint>(3);
    uint _e34 = local_3;
    out[_e34] = static_cast<uint>(as_type<int>(2.75));
    local_4 = static_cast<uint>(4);
    uint _e42 = local_4;
    out[_e42] = as_type<uint>(static_cast<float>(true));
    local_5 = static_cast<uint>(5);
    uint _e50 = local_5;
    out[_e50] = as_type<uint>(static_cast<float>(3));
    local_6 = static_cast<uint>(6);
    uint _e58 = local_6;
    out[_e58] = as_type<uint>(static_cast<float>(5u));
    local_7 = static_cast<uint>(7);
    uint _e65 = local_7;
    out[_e65] = as_type<uint>(2.75);
    local_9 = static_cast<int>(true);
    int _e70 = local_9;
    local_8 = static_cast<uint>(8);
    uint _e76 = local_8;
    out[_e76] = as_type<uint>(as_type<float>(_e70));
    local_11 = 3;
    int _e80 = local_11;
    local_10 = static_cast<uint>(9);
    uint _e86 = local_10;
    out[_e86] = as_type<uint>(as_type<float>(_e80));
    local_13 = static_cast<int>(5u);
    int _e91 = local_13;
    local_12 = static_cast<uint>(10);
    uint _e97 = local_12;
    out[_e97] = as_type<uint>(as_type<float>(_e91));
    local_15 = naga_f2i32(2.75);
    int _e102 = local_15;
    local_14 = static_cast<uint>(11);
    uint _e108 = local_14;
    out[_e108] = as_type<uint>(as_type<float>(_e102));
    local_17 = static_cast<uint>(true);
    uint _e113 = local_17;
    local_16 = static_cast<uint>(12);
    uint _e119 = local_16;
    out[_e119] = as_type<uint>(as_type<float>(_e113));
    local_19 = static_cast<uint>(3);
    uint _e124 = local_19;
    local_18 = static_cast<uint>(13);
    uint _e130 = local_18;
    out[_e130] = as_type<uint>(as_type<float>(_e124));
    local_21 = 5u;
    uint _e134 = local_21;
    local_20 = static_cast<uint>(14);
    uint _e140 = local_20;
    out[_e140] = as_type<uint>(as_type<float>(_e134));
    local_23 = naga_f2u32(2.75);
    uint _e145 = local_23;
    local_22 = static_cast<uint>(15);
    uint _e151 = local_22;
    out[_e151] = as_type<uint>(as_type<float>(_e145));
    value = 1.5;
    float _e155 = value;
    value = _e155 + static_cast<float>(1);
    local_24 = static_cast<uint>(16);
    uint _e164 = local_24;
    out[_e164] = static_cast<uint>(as_type<int>(_e155));
    float _e166 = value;
    local_25 = static_cast<uint>(17);
    uint _e171 = local_25;
    out[_e171] = as_type<uint>(_e166);
    float _e173 = value;
    value = _e173 + static_cast<float>(1);
    local_26 = static_cast<uint>(18);
    uint _e181 = local_26;
    out[_e181] = as_type<uint>(_e173);
    float _e183 = value;
    local_27 = static_cast<uint>(19);
    uint _e188 = local_27;
    out[_e188] = as_type<uint>(_e183);
    signed_bits = 1065353216;
    int _e192 = signed_bits;
    signed_bits = as_type<int>(as_type<uint>(_e192) + as_type<uint>(1));
    local_28 = static_cast<uint>(20);
    uint _e200 = local_28;
    out[_e200] = as_type<uint>(as_type<float>(_e192));
    int _e202 = signed_bits;
    local_29 = static_cast<uint>(21);
    uint _e207 = local_29;
    out[_e207] = static_cast<uint>(_e202);
    unsigned_bits = 1073741824u;
    uint _e211 = unsigned_bits;
    unsigned_bits = _e211 + static_cast<uint>(1);
    local_30 = static_cast<uint>(22);
    uint _e220 = local_30;
    out[_e220] = as_type<uint>(as_type<float>(_e211));
    uint _e222 = unsigned_bits;
    local_31 = static_cast<uint>(23);
    uint _e226 = local_31;
    out[_e226] = _e222;
    int _e230 = _float_as_int(3, 4);
    local_32 = static_cast<uint>(24);
    uint _e235 = local_32;
    out[_e235] = static_cast<uint>(_e230);
    float _e238 = from_bits(3212836864u);
    local_33 = static_cast<uint>(25);
    uint _e243 = local_33;
    out[_e243] = as_type<uint>(_e238);
    local_35 = 2139095040;
    int _e247 = local_35;
    local_34 = static_cast<uint>(26);
    uint _e253 = local_34;
    out[_e253] = as_type<uint>(as_type<float>(_e247));
    local_37 = 2143363909u;
    uint _e257 = local_37;
    local_36 = static_cast<uint>(27);
    uint _e263 = local_36;
    out[_e263] = as_type<uint>(as_type<float>(_e257));
    local_39 = naga_f2u32(1065353200.0);
    uint _e268 = local_39;
    local_38 = static_cast<uint>(28);
    uint _e274 = local_38;
    out[_e274] = as_type<uint>(as_type<float>(_e268));
    local_40 = static_cast<uint>(29);
    uint _e283 = local_40;
    out[_e283] = static_cast<uint>(as_type<int>(static_cast<float>(1u)));
}
