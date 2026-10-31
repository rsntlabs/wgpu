// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};
struct type_7 {
    uint inner[2];
};

bool classify(
    bool value_1
) {
    return !(value_1);
}

int classify_1(
    int value_2
) {
    return as_type<int>(as_type<uint>(value_2) + as_type<uint>(10));
}

uint classify_2(
    uint value_3
) {
    return value_3 + 20u;
}

float classify_3(
    float value_4
) {
    return (value_4 * 1.5) + 0.5;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int rank(
    int left,
    float right
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(left) * as_type<uint>(10))) + as_type<uint>(naga_f2i32(right)));
}

int rank_1(
    float left_1,
    int right_1
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(100) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(left_1)) * as_type<uint>(10))))) + as_type<uint>(right_1));
}

int pair(
    float left_2,
    int right_2
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(left_2)) * as_type<uint>(10))) + as_type<uint>(right_2));
}

int promote(
    uint left_3,
    float right_3
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(200) + as_type<uint>(static_cast<int>(left_3)))) + as_type<uint>(naga_f2i32(right_3)));
}

void touch(
    bool stop,
    int value_5
) {
    int value_6 = {};
    value_6 = value_5;
    if (stop) {
        return;
    }
    int _e3 = value_6;
    int _e4 = classify_1(_e3);
    value_6 = _e4;
    return;
}

int touch_1(
    int value_7
) {
    int _e1 = classify_1(value_7);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(3));
}

int stage(
    int value_8
) {
    return as_type<int>(as_type<uint>(value_8) + as_type<uint>(2));
}

int frozen(
    float value_9
) {
    int _e2 = stage(naga_f2i32(value_9));
    return _e2;
}

int stage_1(
    float value_10
) {
    return as_type<int>(as_type<uint>(naga_f2i32(value_10)) + as_type<uint>(100));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct scalar_overloadsInput {
};
kernel void scalar_overloads(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out_1 [[user(fake0)]]
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
    uint base = {};
    int value = {};
    type_7 local = {};
    uint local_1 = {};
    bool choose = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    type_7 local_6 = {};
    uint local_7 = {};
    type_7 local_8 = {};
    uint local_9 = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    type_7 local_14 = {};
    uint local_15 = {};
    int effect = {};
    type_7 local_16 = {};
    uint local_17 = {};
    type_7 local_18 = {};
    uint local_19 = {};
    type_7 local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    int nested = {};
    type_7 local_24 = {};
    uint local_25 = {};
    int argument = {};
    int captured = {};
    type_7 local_26 = {};
    uint local_27 = {};
    int local_28 = {};
    type_7 local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    int local_32 = {};
    type_7 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    type_7 local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    type_7 local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    type_7 local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_7 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    type_7 local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_7 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_7 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    type_7 local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    type_7 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_7 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_7 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 1u;
    input.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 13u;
        type_7 _e27 = input;
        local = _e27;
        local_1 = static_cast<uint>(i);
        type_7 _e31 = local;
        local_29 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_29.inner[1];
        local_29.inner[1] = _e35 + _e33;
        uint _e39 = local_29.inner[0];
        local_30 = static_cast<uint>(_e39);
        uint _e43 = local_29.inner[1];
        local_31 = static_cast<uint>(_e43);
        uint _e46 = local_31;
        int _e49 = input_1[_e46];
        local_32 = _e49;
        int _e51 = local_32;
        local_28 = _e51;
        int _e53 = local_28;
        value = _e53;
        choose = naga_mod(i, 2u) == 0u;
        bool _e60 = choose;
        bool _e61 = classify(_e60);
        type_7 _e63 = out;
        local_2 = _e63;
        uint _e65 = base;
        local_3 = static_cast<uint>(_e65);
        type_7 _e69 = local_2;
        local_33 = _e69;
        uint _e71 = local_3;
        uint _e73 = local_33.inner[1];
        local_33.inner[1] = _e73 + _e71;
        uint _e77 = local_33.inner[0];
        local_34 = static_cast<uint>(_e77);
        uint _e81 = local_33.inner[1];
        local_35 = static_cast<uint>(_e81);
        uint _e84 = local_35;
        out_1[_e84] = static_cast<int>(_e61);
        int _e87 = value;
        int _e88 = classify_1(_e87);
        type_7 _e89 = out;
        local_4 = _e89;
        uint _e91 = base;
        local_5 = static_cast<uint>(_e91 + 1u);
        type_7 _e96 = local_4;
        local_36 = _e96;
        uint _e98 = local_5;
        uint _e100 = local_36.inner[1];
        local_36.inner[1] = _e100 + _e98;
        uint _e104 = local_36.inner[0];
        local_37 = static_cast<uint>(_e104);
        uint _e108 = local_36.inner[1];
        local_38 = static_cast<uint>(_e108);
        uint _e111 = local_38;
        out_1[_e111] = _e88;
        int _e113 = value;
        uint _e117 = classify_2(static_cast<uint>(as_type<int>(as_type<uint>(_e113) + as_type<uint>(16))));
        type_7 _e118 = out;
        local_6 = _e118;
        uint _e120 = base;
        local_7 = static_cast<uint>(_e120 + 2u);
        type_7 _e126 = local_6;
        local_39 = _e126;
        uint _e128 = local_7;
        uint _e130 = local_39.inner[1];
        local_39.inner[1] = _e130 + _e128;
        uint _e134 = local_39.inner[0];
        local_40 = static_cast<uint>(_e134);
        uint _e138 = local_39.inner[1];
        local_41 = static_cast<uint>(_e138);
        uint _e141 = local_41;
        out_1[_e141] = static_cast<int>(_e117);
        int _e143 = value;
        float _e145 = classify_3(static_cast<float>(_e143));
        type_7 _e146 = out;
        local_8 = _e146;
        uint _e148 = base;
        local_9 = static_cast<uint>(_e148 + 3u);
        type_7 _e154 = local_8;
        local_42 = _e154;
        uint _e156 = local_9;
        uint _e158 = local_42.inner[1];
        local_42.inner[1] = _e158 + _e156;
        uint _e162 = local_42.inner[0];
        local_43 = static_cast<uint>(_e162);
        uint _e166 = local_42.inner[1];
        local_44 = static_cast<uint>(_e166);
        uint _e169 = local_44;
        out_1[_e169] = naga_f2i32(_e145);
        bool _e171 = choose;
        int _e172 = value;
        int _e177 = rank(static_cast<int>(_e171), static_cast<float>(_e172) + 0.5);
        type_7 _e178 = out;
        local_10 = _e178;
        uint _e180 = base;
        local_11 = static_cast<uint>(_e180 + 4u);
        type_7 _e185 = local_10;
        local_45 = _e185;
        uint _e187 = local_11;
        uint _e189 = local_45.inner[1];
        local_45.inner[1] = _e189 + _e187;
        uint _e193 = local_45.inner[0];
        local_46 = static_cast<uint>(_e193);
        uint _e197 = local_45.inner[1];
        local_47 = static_cast<uint>(_e197);
        uint _e200 = local_47;
        out_1[_e200] = _e177;
        int _e202 = value;
        bool _e206 = choose;
        int _e208 = rank_1(static_cast<float>(_e202) + 0.5, static_cast<int>(_e206));
        type_7 _e209 = out;
        local_12 = _e209;
        uint _e211 = base;
        local_13 = static_cast<uint>(_e211 + 5u);
        type_7 _e216 = local_12;
        local_48 = _e216;
        uint _e218 = local_13;
        uint _e220 = local_48.inner[1];
        local_48.inner[1] = _e220 + _e218;
        uint _e224 = local_48.inner[0];
        local_49 = static_cast<uint>(_e224);
        uint _e228 = local_48.inner[1];
        local_50 = static_cast<uint>(_e228);
        uint _e231 = local_50;
        out_1[_e231] = _e208;
        int _e233 = value;
        int _e237 = value;
        int _e239 = promote(static_cast<uint>(as_type<int>(as_type<uint>(_e233) + as_type<uint>(16))), static_cast<float>(_e237));
        type_7 _e240 = out;
        local_14 = _e240;
        uint _e242 = base;
        local_15 = static_cast<uint>(_e242 + 6u);
        type_7 _e247 = local_14;
        local_51 = _e247;
        uint _e249 = local_15;
        uint _e251 = local_51.inner[1];
        local_51.inner[1] = _e251 + _e249;
        uint _e255 = local_51.inner[0];
        local_52 = static_cast<uint>(_e255);
        uint _e259 = local_51.inner[1];
        local_53 = static_cast<uint>(_e259);
        uint _e262 = local_53;
        out_1[_e262] = _e239;
        int _e264 = value;
        effect = _e264;
        bool _e266 = choose;
        int _e267 = effect;
        effect = as_type<int>(as_type<uint>(_e267) + as_type<uint>(1));
        touch(_e266, _e267);
        int _e270 = effect;
        type_7 _e271 = out;
        local_16 = _e271;
        uint _e273 = base;
        local_17 = static_cast<uint>(_e273 + 7u);
        type_7 _e278 = local_16;
        local_54 = _e278;
        uint _e280 = local_17;
        uint _e282 = local_54.inner[1];
        local_54.inner[1] = _e282 + _e280;
        uint _e286 = local_54.inner[0];
        local_55 = static_cast<uint>(_e286);
        uint _e290 = local_54.inner[1];
        local_56 = static_cast<uint>(_e290);
        uint _e293 = local_56;
        out_1[_e293] = _e270;
        int _e295 = effect;
        int _e296 = touch_1(_e295);
        type_7 _e297 = out;
        local_18 = _e297;
        uint _e299 = base;
        local_19 = static_cast<uint>(_e299 + 8u);
        type_7 _e304 = local_18;
        local_57 = _e304;
        uint _e306 = local_19;
        uint _e308 = local_57.inner[1];
        local_57.inner[1] = _e308 + _e306;
        uint _e312 = local_57.inner[0];
        local_58 = static_cast<uint>(_e312);
        uint _e316 = local_57.inner[1];
        local_59 = static_cast<uint>(_e316);
        uint _e319 = local_59;
        out_1[_e319] = _e296;
        int _e321 = value;
        int _e325 = frozen(static_cast<float>(_e321) + 0.75);
        type_7 _e326 = out;
        local_20 = _e326;
        uint _e328 = base;
        local_21 = static_cast<uint>(_e328 + 9u);
        type_7 _e333 = local_20;
        local_60 = _e333;
        uint _e335 = local_21;
        uint _e337 = local_60.inner[1];
        local_60.inner[1] = _e337 + _e335;
        uint _e341 = local_60.inner[0];
        local_61 = static_cast<uint>(_e341);
        uint _e345 = local_60.inner[1];
        local_62 = static_cast<uint>(_e345);
        uint _e348 = local_62;
        out_1[_e348] = _e325;
        int _e350 = value;
        int _e354 = stage_1(static_cast<float>(_e350) + 0.75);
        type_7 _e355 = out;
        local_22 = _e355;
        uint _e357 = base;
        local_23 = static_cast<uint>(_e357 + 10u);
        type_7 _e362 = local_22;
        local_63 = _e362;
        uint _e364 = local_23;
        uint _e366 = local_63.inner[1];
        local_63.inner[1] = _e366 + _e364;
        uint _e370 = local_63.inner[0];
        local_64 = static_cast<uint>(_e370);
        uint _e374 = local_63.inner[1];
        local_65 = static_cast<uint>(_e374);
        uint _e377 = local_65;
        out_1[_e377] = _e354;
        int _e379 = effect;
        effect = as_type<int>(as_type<uint>(_e379) + as_type<uint>(1));
        int _e382 = classify_1(_e379);
        int _e383 = touch_1(_e382);
        nested = _e383;
        int _e385 = nested;
        int _e388 = effect;
        type_7 _e390 = out;
        local_24 = _e390;
        uint _e392 = base;
        local_25 = static_cast<uint>(_e392 + 11u);
        type_7 _e397 = local_24;
        local_66 = _e397;
        uint _e399 = local_25;
        uint _e401 = local_66.inner[1];
        local_66.inner[1] = _e401 + _e399;
        uint _e405 = local_66.inner[0];
        local_67 = static_cast<uint>(_e405);
        uint _e409 = local_66.inner[1];
        local_68 = static_cast<uint>(_e409);
        uint _e412 = local_68;
        out_1[_e412] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e385) * as_type<uint>(10))) + as_type<uint>(_e388));
        int _e414 = value;
        argument = as_type<int>(as_type<uint>(_e414) + as_type<uint>(8));
        int _e418 = argument;
        int _e419 = argument;
        argument = as_type<int>(as_type<uint>(_e419) + as_type<uint>(1));
        int _e423 = pair(static_cast<float>(_e418), _e419);
        captured = _e423;
        int _e425 = captured;
        int _e428 = argument;
        type_7 _e430 = out;
        local_26 = _e430;
        uint _e432 = base;
        local_27 = static_cast<uint>(_e432 + 12u);
        type_7 _e437 = local_26;
        local_69 = _e437;
        uint _e439 = local_27;
        uint _e441 = local_69.inner[1];
        local_69.inner[1] = _e441 + _e439;
        uint _e445 = local_69.inner[0];
        local_70 = static_cast<uint>(_e445);
        uint _e449 = local_69.inner[1];
        local_71 = static_cast<uint>(_e449);
        uint _e452 = local_71;
        out_1[_e452] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e425) * as_type<uint>(100))) + as_type<uint>(_e428));
    }
}
