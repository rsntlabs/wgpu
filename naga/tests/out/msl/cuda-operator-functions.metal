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
    bool local_40 = {};
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = _e4 == 0;
    local_40 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_40 = _e9 == 0;
    }
    bool _e11 = local_40;
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
    uint local_41 = {};
    uint local_42 = {};
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_41 = static_cast<uint>(_e7);
    uint _e10 = local_41;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_42 = static_cast<uint>(_e15);
    uint _e18 = local_42;
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
    metal::int2 local_39 = {};
    uint base = threadIdx.x * 36u;
    local = static_cast<uint>(threadIdx.x);
    uint _e7 = local;
    metal::int2 _e10 = input[_e7];
    local_39 = _e10;
    metal::int2 _e12 = local_39;
    local_38 = _e12;
    metal::int2 _e14 = local_38;
    left = _e14;
    right = metal::int2(3, 2);
    metal::int2 _e20 = left;
    metal::int2 _e21 = operator_u002b(_e20);
    local_1 = static_cast<uint>(base + 0u);
    uint _e28 = local_1;
    out[_e28] = static_cast<uint>(_e21.x);
    metal::int2 _e31 = left;
    metal::int2 _e32 = operator_u002d(_e31);
    local_2 = static_cast<uint>(base + 1u);
    uint _e39 = local_2;
    out[_e39] = static_cast<uint>(_e32.y);
    metal::int2 _e41 = left;
    metal::int2 _e42 = operator_u007e(_e41);
    local_3 = static_cast<uint>(base + 2u);
    uint _e49 = local_3;
    out[_e49] = static_cast<uint>(_e42.x);
    metal::int2 _e51 = left;
    bool _e52 = operator_u0021_(_e51);
    local_4 = static_cast<uint>(base + 3u);
    uint _e58 = local_4;
    out[_e58] = static_cast<uint>(_e52);
    metal::int2 _e60 = left;
    int _e61 = operator_u002a(_e60);
    local_5 = static_cast<uint>(base + 4u);
    uint _e67 = local_5;
    out[_e67] = static_cast<uint>(_e61);
    metal::int2 _e69 = left;
    metal::int2 _e70 = operator_u0026_(_e69);
    local_6 = static_cast<uint>(base + 5u);
    uint _e77 = local_6;
    out[_e77] = static_cast<uint>(_e70.x);
    metal::int2 _e79 = left;
    metal::int2 _e80 = right;
    metal::int2 _e81 = operator_u002b_1(_e79, _e80);
    local_7 = static_cast<uint>(base + 6u);
    uint _e88 = local_7;
    out[_e88] = static_cast<uint>(_e81.x);
    metal::int2 _e90 = left;
    metal::int2 _e91 = right;
    metal::int2 _e92 = operator_u002d_1(_e90, _e91);
    local_8 = static_cast<uint>(base + 7u);
    uint _e99 = local_8;
    out[_e99] = static_cast<uint>(_e92.y);
    metal::int2 _e101 = left;
    metal::int2 _e102 = right;
    metal::int2 _e103 = operator_u002a_1(_e101, _e102);
    local_9 = static_cast<uint>(base + 8u);
    uint _e110 = local_9;
    out[_e110] = static_cast<uint>(_e103.x);
    metal::int2 _e112 = left;
    metal::int2 _e113 = right;
    metal::int2 _e114 = operator_u002f(_e112, _e113);
    local_10 = static_cast<uint>(base + 9u);
    uint _e121 = local_10;
    out[_e121] = static_cast<uint>(_e114.y);
    metal::int2 _e123 = left;
    metal::int2 _e124 = right;
    metal::int2 _e125 = operator_u0025_(_e123, _e124);
    local_11 = static_cast<uint>(base + 10u);
    uint _e132 = local_11;
    out[_e132] = static_cast<uint>(_e125.y);
    metal::int2 _e134 = left;
    metal::int2 _e135 = right;
    metal::int2 _e136 = operator_u0026_1(_e134, _e135);
    local_12 = static_cast<uint>(base + 11u);
    uint _e143 = local_12;
    out[_e143] = static_cast<uint>(_e136.x);
    metal::int2 _e145 = left;
    metal::int2 _e146 = right;
    metal::int2 _e147 = operator_u007c(_e145, _e146);
    local_13 = static_cast<uint>(base + 12u);
    uint _e154 = local_13;
    out[_e154] = static_cast<uint>(_e147.y);
    metal::int2 _e156 = left;
    metal::int2 _e157 = right;
    metal::int2 _e158 = operator_u005e(_e156, _e157);
    local_14 = static_cast<uint>(base + 13u);
    uint _e165 = local_14;
    out[_e165] = static_cast<uint>(_e158.x);
    metal::int2 _e167 = left;
    metal::int2 _e168 = right;
    metal::int2 _e169 = operator_(_e167, _e168);
    local_15 = static_cast<uint>(base + 14u);
    uint _e176 = local_15;
    out[_e176] = static_cast<uint>(_e169.x);
    metal::int2 _e178 = left;
    metal::int2 _e179 = right;
    metal::int2 _e180 = operator_1(_e178, _e179);
    local_16 = static_cast<uint>(base + 15u);
    uint _e187 = local_16;
    out[_e187] = static_cast<uint>(_e180.y);
    metal::int2 _e189 = left;
    metal::int2 _e190 = operator_u002b(_e189);
    local_17 = static_cast<uint>(base + 16u);
    uint _e197 = local_17;
    out[_e197] = static_cast<uint>(_e190.y);
    metal::int2 _e199 = left;
    metal::int2 _e200 = right;
    metal::int2 _e201 = operator_u002d_1(_e199, _e200);
    local_18 = static_cast<uint>(base + 17u);
    uint _e208 = local_18;
    out[_e208] = static_cast<uint>(_e201.x);
    metal::int2 _e210 = left;
    int _e211 = operator_u002a(_e210);
    local_19 = static_cast<uint>(base + 18u);
    uint _e217 = local_19;
    out[_e217] = static_cast<uint>(_e211);
    metal::int2 _e219 = left;
    metal::int2 _e220 = right;
    metal::int2 _e221 = operator_u0026_1(_e219, _e220);
    local_20 = static_cast<uint>(base + 19u);
    uint _e228 = local_20;
    out[_e228] = static_cast<uint>(_e221.y);
    metal::int2 _e230 = left;
    metal::int2 _e231 = operator_u0026_(_e230);
    int _e232 = operator_u002a(_e231);
    local_21 = static_cast<uint>(base + 20u);
    uint _e238 = local_21;
    out[_e238] = static_cast<uint>(_e232);
    metal::int2 _e240 = left;
    metal::int2 _e241 = operator_u0026_(_e240);
    metal::int2 _e242 = operator_u0026_(_e241);
    local_22 = static_cast<uint>(base + 21u);
    uint _e249 = local_22;
    out[_e249] = static_cast<uint>(_e242.x);
    metal::int2 _e251 = left;
    metal::int2 _e252 = right;
    metal::int2 _e253 = right;
    metal::int2 _e254 = operator_u002a_1(_e252, _e253);
    metal::int2 _e255 = operator_u002b_1(_e251, _e254);
    local_23 = static_cast<uint>(base + 22u);
    uint _e262 = local_23;
    out[_e262] = static_cast<uint>(_e255.x);
    metal::int2 _e264 = left;
    metal::int2 _e265 = right;
    metal::int2 _e269 = operator_u002b_1(_e265, metal::int2(1, 1));
    metal::int2 _e270 = operator_(_e264, _e269);
    local_24 = static_cast<uint>(base + 23u);
    uint _e277 = local_24;
    out[_e277] = static_cast<uint>(_e270.x);
    metal::int2 _e279 = left;
    metal::int2 _e280 = right;
    metal::int2 _e284 = operator_u0026_1(_e280, metal::int2(1, 1));
    metal::int2 _e285 = operator_u007c(_e279, _e284);
    local_25 = static_cast<uint>(base + 24u);
    uint _e292 = local_25;
    out[_e292] = static_cast<uint>(_e285.y);
    metal::int2 _e294 = left;
    metal::int2 _e295 = right;
    metal::int2 _e296 = operator_u002d_1(_e294, _e295);
    metal::int2 _e297 = right;
    metal::int2 _e298 = operator_u002d_1(_e296, _e297);
    local_26 = static_cast<uint>(base + 25u);
    uint _e305 = local_26;
    out[_e305] = static_cast<uint>(_e298.x);
    original.value = 9;
    original.history.inner[0] = 1;
    original.history.inner[1] = 2;
    Record_cuda_record_0_ _e315 = original;
    Record_cuda_record_0_ _e317 = operator_u002a_3(_e315, 3);
    scaled = _e317;
    local_28.value = 9;
    local_28.history.inner[0] = 1;
    local_28.history.inner[1] = 2;
    Record_cuda_record_0_ _e327 = local_28;
    int _e328 = operator_u0026_2(_e327);
    local_27 = static_cast<uint>(base + 26u);
    uint _e334 = local_27;
    out[_e334] = static_cast<uint>(_e328);
    Record_cuda_record_0_ _e336 = original;
    Record_cuda_record_0_ _e337 = operator_u002a_2(_e336);
    int _e338 = operator_u0026_2(_e337);
    local_29 = static_cast<uint>(base + 27u);
    uint _e344 = local_29;
    out[_e344] = static_cast<uint>(_e338);
    int _e347 = scaled.value;
    local_30 = static_cast<uint>(base + 28u);
    uint _e353 = local_30;
    out[_e353] = static_cast<uint>(_e347);
    int _e358 = scaled.history.inner[1];
    local_31 = static_cast<uint>(base + 29u);
    uint _e364 = local_31;
    out[_e364] = static_cast<uint>(_e358);
    int _e367 = original.value;
    local_32 = static_cast<uint>(base + 30u);
    uint _e373 = local_32;
    out[_e373] = static_cast<uint>(_e367);
    int _e378 = original.history.inner[1];
    local_33 = static_cast<uint>(base + 31u);
    uint _e384 = local_33;
    out[_e384] = static_cast<uint>(_e378);
    Record_cuda_record_0_ _e386 = original;
    Record_cuda_record_0_ _e387 = operator_u002d_2(_e386);
    local_34 = static_cast<uint>(base + 32u);
    uint _e394 = local_34;
    out[_e394] = static_cast<uint>(_e387.value);
    Record_cuda_record_0_ _e396 = original;
    Record_cuda_record_0_ _e398 = operator_u002a_3(_e396, 2);
    local_35 = static_cast<uint>(base + 33u);
    uint _e405 = local_35;
    out[_e405] = static_cast<uint>(_e398.value);
    Record_cuda_record_0_ _e407 = original;
    Record_cuda_record_0_ _e408 = operator_u002a_2(_e407);
    int _e409 = operator_u0026_2(_e408);
    local_36 = static_cast<uint>(base + 34u);
    uint _e415 = local_36;
    out[_e415] = static_cast<uint>(_e409);
    bool _e420 = operator_u0021_(metal::int2(0, 0));
    local_37 = static_cast<uint>(base + 35u);
    uint _e426 = local_37;
    out[_e426] = static_cast<uint>(_e420);
}
