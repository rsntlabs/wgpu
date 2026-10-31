// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct type_1 {
    int inner[2];
};
struct Record_cuda_record_0_ {
    int value;
    type_1 history;
};
typedef metal::int2 type_4[1];
typedef uint type_6[1];

metal::int2 operator_u002b(
    metal::int2 value
) {
    metal::int2 value_1 = {};
    value_1 = value;
    int _e3 = value_1.x;
    int _e5 = value_1.y;
    return metal::int2(_e3, _e5);
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

metal::int2 operator_u002d(
    metal::int2 value_2
) {
    metal::int2 value_3 = {};
    value_3 = value_2;
    int _e3 = value_3.x;
    int _e6 = value_3.y;
    return metal::int2(naga_neg(_e3), naga_neg(_e6));
}

metal::int2 operator_u007e(
    metal::int2 value_4
) {
    metal::int2 value_5 = {};
    value_5 = value_4;
    int _e3 = value_5.x;
    int _e6 = value_5.y;
    return metal::int2(~(_e3), ~(_e6));
}

bool operator_u0021_(
    metal::int2 value_6
) {
    metal::int2 value_7 = {};
    bool local_77 = {};
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = _e4 == 0;
    local_77 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_77 = _e9 == 0;
    }
    bool _e11 = local_77;
    return _e11;
}

int operator_u002a(
    metal::int2 value_8
) {
    metal::int2 value_9 = {};
    value_9 = value_8;
    int _e4 = value_9.x;
    int _e7 = value_9.y;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) * as_type<uint>(10))) + as_type<uint>(_e7));
}

metal::int2 operator_u0026_(
    metal::int2 value_10
) {
    metal::int2 value_11 = {};
    value_11 = value_10;
    int _e3 = value_11.y;
    int _e5 = value_11.x;
    return metal::int2(_e3, _e5);
}

metal::int2 operator_u002b_1(
    metal::int2 left_1,
    metal::int2 right_1
) {
    metal::int2 left_2 = {};
    metal::int2 right_2 = {};
    left_2 = left_1;
    right_2 = right_1;
    int _e6 = left_2.x;
    int _e7 = right_2.x;
    int _e11 = left_2.y;
    int _e12 = right_2.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12)));
}

metal::int2 operator_u002d_1(
    metal::int2 left_3,
    metal::int2 right_3
) {
    metal::int2 left_4 = {};
    metal::int2 right_4 = {};
    left_4 = left_3;
    right_4 = right_3;
    int _e6 = left_4.x;
    int _e7 = right_4.x;
    int _e11 = left_4.y;
    int _e12 = right_4.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) - as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) - as_type<uint>(_e12)));
}

metal::int2 operator_u002a_1(
    metal::int2 left_5,
    metal::int2 right_5
) {
    metal::int2 left_6 = {};
    metal::int2 right_6 = {};
    left_6 = left_5;
    right_6 = right_5;
    int _e6 = left_6.x;
    int _e7 = right_6.x;
    int _e11 = left_6.y;
    int _e12 = right_6.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) * as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) * as_type<uint>(_e12)));
}

int naga_div(int lhs, int rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
}

metal::int2 operator_u002f(
    metal::int2 left_7,
    metal::int2 right_7
) {
    metal::int2 left_8 = {};
    metal::int2 right_8 = {};
    left_8 = left_7;
    right_8 = right_7;
    int _e6 = left_8.x;
    int _e7 = right_8.x;
    int _e11 = left_8.y;
    int _e12 = right_8.y;
    return metal::int2(naga_div(_e6, _e7), naga_div(_e11, _e12));
}

int naga_mod(int lhs, int rhs) {
    int divisor = metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

metal::int2 operator_u0025_(
    metal::int2 left_9,
    metal::int2 right_9
) {
    metal::int2 left_10 = {};
    metal::int2 right_10 = {};
    left_10 = left_9;
    right_10 = right_9;
    int _e6 = left_10.x;
    int _e7 = right_10.x;
    int _e11 = left_10.y;
    int _e12 = right_10.y;
    return metal::int2(naga_mod(_e6, _e7), naga_mod(_e11, _e12));
}

metal::int2 operator_u0026_1(
    metal::int2 left_11,
    metal::int2 right_11
) {
    metal::int2 left_12 = {};
    metal::int2 right_12 = {};
    left_12 = left_11;
    right_12 = right_11;
    int _e6 = left_12.x;
    int _e7 = right_12.x;
    int _e11 = left_12.y;
    int _e12 = right_12.y;
    return metal::int2(_e6 & _e7, _e11 & _e12);
}

metal::int2 operator_u007c(
    metal::int2 left_13,
    metal::int2 right_13
) {
    metal::int2 left_14 = {};
    metal::int2 right_14 = {};
    left_14 = left_13;
    right_14 = right_13;
    int _e6 = left_14.x;
    int _e7 = right_14.x;
    int _e11 = left_14.y;
    int _e12 = right_14.y;
    return metal::int2(_e6 | _e7, _e11 | _e12);
}

metal::int2 operator_u005e(
    metal::int2 left_15,
    metal::int2 right_15
) {
    metal::int2 left_16 = {};
    metal::int2 right_16 = {};
    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return metal::int2(_e6 ^ _e7, _e11 ^ _e12);
}

metal::int2 operator_(
    metal::int2 left_17,
    metal::int2 right_17
) {
    metal::int2 left_18 = {};
    metal::int2 right_18 = {};
    uint local_78 = {};
    uint local_79 = {};
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_78 = static_cast<uint>(_e7);
    uint _e10 = local_78;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_79 = static_cast<uint>(_e15);
    uint _e18 = local_79;
    return metal::int2(_e5 << _e10, _e13 << _e18);
}

metal::int2 operator_1(
    metal::int2 left_19,
    metal::int2 right_19
) {
    metal::int2 left_20 = {};
    metal::int2 right_20 = {};
    left_20 = left_19;
    right_20 = right_19;
    int _e5 = left_20.x;
    int _e7 = right_20.x;
    int _e11 = left_20.y;
    int _e13 = right_20.y;
    return metal::int2(_e5 >> static_cast<uint>(_e7), _e11 >> static_cast<uint>(_e13));
}

Record_cuda_record_0_ operator_u002a_2(
    Record_cuda_record_0_ value_12
) {
    Record_cuda_record_0_ value_13 = {};
    value_13 = value_12;
    int _e3 = value_13.value;
    value_13.value = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
    Record_cuda_record_0_ _e6 = value_13;
    return _e6;
}

int operator_u0026_2(
    Record_cuda_record_0_ value_14
) {
    Record_cuda_record_0_ value_15 = {};
    value_15 = value_14;
    int _e3 = value_15.value;
    return _e3;
}

Record_cuda_record_0_ operator_u002d_2(
    Record_cuda_record_0_ value_16
) {
    Record_cuda_record_0_ value_17 = {};
    value_17 = value_16;
    int _e4 = value_17.value;
    value_17.value = naga_neg(_e4);
    Record_cuda_record_0_ _e6 = value_17;
    return _e6;
}

Record_cuda_record_0_ operator_u002a_3(
    Record_cuda_record_0_ value_18,
    int factor
) {
    Record_cuda_record_0_ value_19 = {};
    value_19 = value_18;
    int _e4 = value_19.value;
    value_19.value = as_type<int>(as_type<uint>(_e4) * as_type<uint>(factor));
    int _e9 = value_19.history.inner[1];
    value_19.history.inner[1] = as_type<int>(as_type<uint>(_e9) + as_type<uint>(factor));
    Record_cuda_record_0_ _e11 = value_19;
    return _e11;
}

struct operator_functionsInput {
};
kernel void operator_functions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4 const& input [[user(fake0)]]
, device type_6& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::int2 left = {};
    uint local = {};
    metal::int2 right = {};
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
    Record_cuda_record_0_ original = {};
    Record_cuda_record_0_ scaled = {};
    uint local_27 = {};
    Record_cuda_record_0_ local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    metal::int2 local_38 = {};
    uint local_39 = {};
    metal::int2 local_40 = {};
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
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint base = threadIdx.x * 36u;
    local = static_cast<uint>(threadIdx.x);
    uint _e7 = local;
    local_39 = static_cast<uint>(_e7);
    uint _e10 = local_39;
    metal::int2 _e13 = input[_e10];
    local_40 = _e13;
    metal::int2 _e15 = local_40;
    local_38 = _e15;
    metal::int2 _e17 = local_38;
    left = _e17;
    right = metal::int2(3, 2);
    metal::int2 _e23 = left;
    metal::int2 _e24 = operator_u002b(_e23);
    local_1 = static_cast<uint>(base + 0u);
    uint _e31 = local_1;
    local_41 = static_cast<uint>(_e31);
    uint _e34 = local_41;
    out[_e34] = static_cast<uint>(_e24.x);
    metal::int2 _e37 = left;
    metal::int2 _e38 = operator_u002d(_e37);
    local_2 = static_cast<uint>(base + 1u);
    uint _e45 = local_2;
    local_42 = static_cast<uint>(_e45);
    uint _e48 = local_42;
    out[_e48] = static_cast<uint>(_e38.y);
    metal::int2 _e50 = left;
    metal::int2 _e51 = operator_u007e(_e50);
    local_3 = static_cast<uint>(base + 2u);
    uint _e58 = local_3;
    local_43 = static_cast<uint>(_e58);
    uint _e61 = local_43;
    out[_e61] = static_cast<uint>(_e51.x);
    metal::int2 _e63 = left;
    bool _e64 = operator_u0021_(_e63);
    local_4 = static_cast<uint>(base + 3u);
    uint _e70 = local_4;
    local_44 = static_cast<uint>(_e70);
    uint _e73 = local_44;
    out[_e73] = static_cast<uint>(_e64);
    metal::int2 _e75 = left;
    int _e76 = operator_u002a(_e75);
    local_5 = static_cast<uint>(base + 4u);
    uint _e82 = local_5;
    local_45 = static_cast<uint>(_e82);
    uint _e85 = local_45;
    out[_e85] = static_cast<uint>(_e76);
    metal::int2 _e87 = left;
    metal::int2 _e88 = operator_u0026_(_e87);
    local_6 = static_cast<uint>(base + 5u);
    uint _e95 = local_6;
    local_46 = static_cast<uint>(_e95);
    uint _e98 = local_46;
    out[_e98] = static_cast<uint>(_e88.x);
    metal::int2 _e100 = left;
    metal::int2 _e101 = right;
    metal::int2 _e102 = operator_u002b_1(_e100, _e101);
    local_7 = static_cast<uint>(base + 6u);
    uint _e109 = local_7;
    local_47 = static_cast<uint>(_e109);
    uint _e112 = local_47;
    out[_e112] = static_cast<uint>(_e102.x);
    metal::int2 _e114 = left;
    metal::int2 _e115 = right;
    metal::int2 _e116 = operator_u002d_1(_e114, _e115);
    local_8 = static_cast<uint>(base + 7u);
    uint _e123 = local_8;
    local_48 = static_cast<uint>(_e123);
    uint _e126 = local_48;
    out[_e126] = static_cast<uint>(_e116.y);
    metal::int2 _e128 = left;
    metal::int2 _e129 = right;
    metal::int2 _e130 = operator_u002a_1(_e128, _e129);
    local_9 = static_cast<uint>(base + 8u);
    uint _e137 = local_9;
    local_49 = static_cast<uint>(_e137);
    uint _e140 = local_49;
    out[_e140] = static_cast<uint>(_e130.x);
    metal::int2 _e142 = left;
    metal::int2 _e143 = right;
    metal::int2 _e144 = operator_u002f(_e142, _e143);
    local_10 = static_cast<uint>(base + 9u);
    uint _e151 = local_10;
    local_50 = static_cast<uint>(_e151);
    uint _e154 = local_50;
    out[_e154] = static_cast<uint>(_e144.y);
    metal::int2 _e156 = left;
    metal::int2 _e157 = right;
    metal::int2 _e158 = operator_u0025_(_e156, _e157);
    local_11 = static_cast<uint>(base + 10u);
    uint _e165 = local_11;
    local_51 = static_cast<uint>(_e165);
    uint _e168 = local_51;
    out[_e168] = static_cast<uint>(_e158.y);
    metal::int2 _e170 = left;
    metal::int2 _e171 = right;
    metal::int2 _e172 = operator_u0026_1(_e170, _e171);
    local_12 = static_cast<uint>(base + 11u);
    uint _e179 = local_12;
    local_52 = static_cast<uint>(_e179);
    uint _e182 = local_52;
    out[_e182] = static_cast<uint>(_e172.x);
    metal::int2 _e184 = left;
    metal::int2 _e185 = right;
    metal::int2 _e186 = operator_u007c(_e184, _e185);
    local_13 = static_cast<uint>(base + 12u);
    uint _e193 = local_13;
    local_53 = static_cast<uint>(_e193);
    uint _e196 = local_53;
    out[_e196] = static_cast<uint>(_e186.y);
    metal::int2 _e198 = left;
    metal::int2 _e199 = right;
    metal::int2 _e200 = operator_u005e(_e198, _e199);
    local_14 = static_cast<uint>(base + 13u);
    uint _e207 = local_14;
    local_54 = static_cast<uint>(_e207);
    uint _e210 = local_54;
    out[_e210] = static_cast<uint>(_e200.x);
    metal::int2 _e212 = left;
    metal::int2 _e213 = right;
    metal::int2 _e214 = operator_(_e212, _e213);
    local_15 = static_cast<uint>(base + 14u);
    uint _e221 = local_15;
    local_55 = static_cast<uint>(_e221);
    uint _e224 = local_55;
    out[_e224] = static_cast<uint>(_e214.x);
    metal::int2 _e226 = left;
    metal::int2 _e227 = right;
    metal::int2 _e228 = operator_1(_e226, _e227);
    local_16 = static_cast<uint>(base + 15u);
    uint _e235 = local_16;
    local_56 = static_cast<uint>(_e235);
    uint _e238 = local_56;
    out[_e238] = static_cast<uint>(_e228.y);
    metal::int2 _e240 = left;
    metal::int2 _e241 = operator_u002b(_e240);
    local_17 = static_cast<uint>(base + 16u);
    uint _e248 = local_17;
    local_57 = static_cast<uint>(_e248);
    uint _e251 = local_57;
    out[_e251] = static_cast<uint>(_e241.y);
    metal::int2 _e253 = left;
    metal::int2 _e254 = right;
    metal::int2 _e255 = operator_u002d_1(_e253, _e254);
    local_18 = static_cast<uint>(base + 17u);
    uint _e262 = local_18;
    local_58 = static_cast<uint>(_e262);
    uint _e265 = local_58;
    out[_e265] = static_cast<uint>(_e255.x);
    metal::int2 _e267 = left;
    int _e268 = operator_u002a(_e267);
    local_19 = static_cast<uint>(base + 18u);
    uint _e274 = local_19;
    local_59 = static_cast<uint>(_e274);
    uint _e277 = local_59;
    out[_e277] = static_cast<uint>(_e268);
    metal::int2 _e279 = left;
    metal::int2 _e280 = right;
    metal::int2 _e281 = operator_u0026_1(_e279, _e280);
    local_20 = static_cast<uint>(base + 19u);
    uint _e288 = local_20;
    local_60 = static_cast<uint>(_e288);
    uint _e291 = local_60;
    out[_e291] = static_cast<uint>(_e281.y);
    metal::int2 _e293 = left;
    metal::int2 _e294 = operator_u0026_(_e293);
    int _e295 = operator_u002a(_e294);
    local_21 = static_cast<uint>(base + 20u);
    uint _e301 = local_21;
    local_61 = static_cast<uint>(_e301);
    uint _e304 = local_61;
    out[_e304] = static_cast<uint>(_e295);
    metal::int2 _e306 = left;
    metal::int2 _e307 = operator_u0026_(_e306);
    metal::int2 _e308 = operator_u0026_(_e307);
    local_22 = static_cast<uint>(base + 21u);
    uint _e315 = local_22;
    local_62 = static_cast<uint>(_e315);
    uint _e318 = local_62;
    out[_e318] = static_cast<uint>(_e308.x);
    metal::int2 _e320 = left;
    metal::int2 _e321 = right;
    metal::int2 _e322 = right;
    metal::int2 _e323 = operator_u002a_1(_e321, _e322);
    metal::int2 _e324 = operator_u002b_1(_e320, _e323);
    local_23 = static_cast<uint>(base + 22u);
    uint _e331 = local_23;
    local_63 = static_cast<uint>(_e331);
    uint _e334 = local_63;
    out[_e334] = static_cast<uint>(_e324.x);
    metal::int2 _e336 = left;
    metal::int2 _e337 = right;
    metal::int2 _e341 = operator_u002b_1(_e337, metal::int2(1, 1));
    metal::int2 _e342 = operator_(_e336, _e341);
    local_24 = static_cast<uint>(base + 23u);
    uint _e349 = local_24;
    local_64 = static_cast<uint>(_e349);
    uint _e352 = local_64;
    out[_e352] = static_cast<uint>(_e342.x);
    metal::int2 _e354 = left;
    metal::int2 _e355 = right;
    metal::int2 _e359 = operator_u0026_1(_e355, metal::int2(1, 1));
    metal::int2 _e360 = operator_u007c(_e354, _e359);
    local_25 = static_cast<uint>(base + 24u);
    uint _e367 = local_25;
    local_65 = static_cast<uint>(_e367);
    uint _e370 = local_65;
    out[_e370] = static_cast<uint>(_e360.y);
    metal::int2 _e372 = left;
    metal::int2 _e373 = right;
    metal::int2 _e374 = operator_u002d_1(_e372, _e373);
    metal::int2 _e375 = right;
    metal::int2 _e376 = operator_u002d_1(_e374, _e375);
    local_26 = static_cast<uint>(base + 25u);
    uint _e383 = local_26;
    local_66 = static_cast<uint>(_e383);
    uint _e386 = local_66;
    out[_e386] = static_cast<uint>(_e376.x);
    original.value = 9;
    original.history.inner[0] = 1;
    original.history.inner[1] = 2;
    Record_cuda_record_0_ _e396 = original;
    Record_cuda_record_0_ _e398 = operator_u002a_3(_e396, 3);
    scaled = _e398;
    local_28.value = 9;
    local_28.history.inner[0] = 1;
    local_28.history.inner[1] = 2;
    Record_cuda_record_0_ _e408 = local_28;
    int _e409 = operator_u0026_2(_e408);
    local_27 = static_cast<uint>(base + 26u);
    uint _e415 = local_27;
    local_67 = static_cast<uint>(_e415);
    uint _e418 = local_67;
    out[_e418] = static_cast<uint>(_e409);
    Record_cuda_record_0_ _e420 = original;
    Record_cuda_record_0_ _e421 = operator_u002a_2(_e420);
    int _e422 = operator_u0026_2(_e421);
    local_29 = static_cast<uint>(base + 27u);
    uint _e428 = local_29;
    local_68 = static_cast<uint>(_e428);
    uint _e431 = local_68;
    out[_e431] = static_cast<uint>(_e422);
    int _e434 = scaled.value;
    local_30 = static_cast<uint>(base + 28u);
    uint _e440 = local_30;
    local_69 = static_cast<uint>(_e440);
    uint _e443 = local_69;
    out[_e443] = static_cast<uint>(_e434);
    int _e448 = scaled.history.inner[1];
    local_31 = static_cast<uint>(base + 29u);
    uint _e454 = local_31;
    local_70 = static_cast<uint>(_e454);
    uint _e457 = local_70;
    out[_e457] = static_cast<uint>(_e448);
    int _e460 = original.value;
    local_32 = static_cast<uint>(base + 30u);
    uint _e466 = local_32;
    local_71 = static_cast<uint>(_e466);
    uint _e469 = local_71;
    out[_e469] = static_cast<uint>(_e460);
    int _e474 = original.history.inner[1];
    local_33 = static_cast<uint>(base + 31u);
    uint _e480 = local_33;
    local_72 = static_cast<uint>(_e480);
    uint _e483 = local_72;
    out[_e483] = static_cast<uint>(_e474);
    Record_cuda_record_0_ _e485 = original;
    Record_cuda_record_0_ _e486 = operator_u002d_2(_e485);
    local_34 = static_cast<uint>(base + 32u);
    uint _e493 = local_34;
    local_73 = static_cast<uint>(_e493);
    uint _e496 = local_73;
    out[_e496] = static_cast<uint>(_e486.value);
    Record_cuda_record_0_ _e498 = original;
    Record_cuda_record_0_ _e500 = operator_u002a_3(_e498, 2);
    local_35 = static_cast<uint>(base + 33u);
    uint _e507 = local_35;
    local_74 = static_cast<uint>(_e507);
    uint _e510 = local_74;
    out[_e510] = static_cast<uint>(_e500.value);
    Record_cuda_record_0_ _e512 = original;
    Record_cuda_record_0_ _e513 = operator_u002a_2(_e512);
    int _e514 = operator_u0026_2(_e513);
    local_36 = static_cast<uint>(base + 34u);
    uint _e520 = local_36;
    local_75 = static_cast<uint>(_e520);
    uint _e523 = local_75;
    out[_e523] = static_cast<uint>(_e514);
    bool _e528 = operator_u0021_(metal::int2(0, 0));
    local_37 = static_cast<uint>(base + 35u);
    uint _e534 = local_37;
    local_76 = static_cast<uint>(_e534);
    uint _e537 = local_76;
    out[_e537] = static_cast<uint>(_e528);
}
