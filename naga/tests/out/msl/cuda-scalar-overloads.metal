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
    bool value_2 = {};
    value_2 = value_1;
    bool _e2 = value_2;
    return !(_e2);
}

int classify_1(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e3 = value_4;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(10));
}

uint classify_2(
    uint value_5
) {
    uint value_6 = {};
    value_6 = value_5;
    uint _e3 = value_6;
    return _e3 + 20u;
}

float classify_3(
    float value_7
) {
    float value_8 = {};
    value_8 = value_7;
    float _e3 = value_8;
    return (_e3 * 1.5) + 0.5;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int rank(
    int left,
    float right
) {
    int left_1 = {};
    float right_1 = {};
    left_1 = left;
    right_1 = right;
    int _e5 = left_1;
    float _e7 = right_1;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e5) * as_type<uint>(10))) + as_type<uint>(naga_f2i32(_e7)));
}

int rank_1(
    float left_2,
    int right_2
) {
    float left_3 = {};
    int right_3 = {};
    left_3 = left_2;
    right_3 = right_2;
    float _e5 = left_3;
    int _e10 = right_3;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(100) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e5)) * as_type<uint>(10))))) + as_type<uint>(_e10));
}

int pair(
    float left_4,
    int right_4
) {
    float left_5 = {};
    int right_5 = {};
    left_5 = left_4;
    right_5 = right_4;
    float _e4 = left_5;
    int _e8 = right_5;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e4)) * as_type<uint>(10))) + as_type<uint>(_e8));
}

int promote(
    uint left_6,
    float right_6
) {
    uint left_7 = {};
    float right_7 = {};
    left_7 = left_6;
    right_7 = right_6;
    uint _e5 = left_7;
    float _e8 = right_7;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(200) + as_type<uint>(static_cast<int>(_e5)))) + as_type<uint>(naga_f2i32(_e8)));
}

void touch(
    bool stop,
    int value_9
) {
    bool stop_1 = {};
    int value_10 = {};
    stop_1 = stop;
    value_10 = value_9;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_10;
    int _e6 = classify_1(_e5);
    value_10 = _e6;
    return;
}

int touch_1(
    int value_11
) {
    int value_12 = {};
    value_12 = value_11;
    int _e2 = value_12;
    int _e3 = classify_1(_e2);
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(3));
}

int stage(
    int value_13
) {
    int value_14 = {};
    value_14 = value_13;
    int _e3 = value_14;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(2));
}

int frozen(
    float value_15
) {
    float value_16 = {};
    value_16 = value_15;
    float _e2 = value_16;
    int _e4 = stage(naga_f2i32(_e2));
    return _e4;
}

int stage_1(
    float value_17
) {
    float value_18 = {};
    value_18 = value_17;
    float _e2 = value_18;
    return as_type<int>(as_type<uint>(naga_f2i32(_e2)) + as_type<uint>(100));
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
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
    uint n = {};
    uint i = {};
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
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 13u;
        type_7 _e35 = input;
        local = _e35;
        uint _e36 = i;
        local_1 = static_cast<uint>(_e36);
        type_7 _e40 = local;
        local_29 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_29.inner[1];
        local_29.inner[1] = _e43 + _e41;
        uint _e47 = local_29.inner[0];
        local_30 = static_cast<uint>(_e47);
        uint _e51 = local_29.inner[1];
        local_31 = static_cast<uint>(_e51);
        uint _e55 = local_31;
        int _e57 = input_1[_e55];
        local_32 = _e57;
        int _e58 = local_32;
        local_28 = _e58;
        int _e60 = local_28;
        value = _e60;
        uint _e62 = i;
        choose = naga_mod(_e62, 2u) == 0u;
        bool _e68 = choose;
        bool _e69 = classify(_e68);
        type_7 _e72 = out;
        local_2 = _e72;
        uint _e73 = base;
        local_3 = static_cast<uint>(_e73);
        type_7 _e78 = local_2;
        local_33 = _e78;
        uint _e79 = local_3;
        uint _e81 = local_33.inner[1];
        local_33.inner[1] = _e81 + _e79;
        uint _e85 = local_33.inner[0];
        local_34 = static_cast<uint>(_e85);
        uint _e89 = local_33.inner[1];
        local_35 = static_cast<uint>(_e89);
        uint _e92 = local_35;
        out_1[_e92] = static_cast<int>(_e69);
        int _e94 = value;
        int _e95 = classify_1(_e94);
        type_7 _e97 = out;
        local_4 = _e97;
        uint _e98 = base;
        local_5 = static_cast<uint>(_e98 + 1u);
        type_7 _e104 = local_4;
        local_36 = _e104;
        uint _e105 = local_5;
        uint _e107 = local_36.inner[1];
        local_36.inner[1] = _e107 + _e105;
        uint _e111 = local_36.inner[0];
        local_37 = static_cast<uint>(_e111);
        uint _e115 = local_36.inner[1];
        local_38 = static_cast<uint>(_e115);
        uint _e118 = local_38;
        out_1[_e118] = _e95;
        int _e120 = value;
        uint _e124 = classify_2(static_cast<uint>(as_type<int>(as_type<uint>(_e120) + as_type<uint>(16))));
        type_7 _e126 = out;
        local_6 = _e126;
        uint _e127 = base;
        local_7 = static_cast<uint>(_e127 + 2u);
        type_7 _e134 = local_6;
        local_39 = _e134;
        uint _e135 = local_7;
        uint _e137 = local_39.inner[1];
        local_39.inner[1] = _e137 + _e135;
        uint _e141 = local_39.inner[0];
        local_40 = static_cast<uint>(_e141);
        uint _e145 = local_39.inner[1];
        local_41 = static_cast<uint>(_e145);
        uint _e148 = local_41;
        out_1[_e148] = static_cast<int>(_e124);
        int _e150 = value;
        float _e152 = classify_3(static_cast<float>(_e150));
        type_7 _e154 = out;
        local_8 = _e154;
        uint _e155 = base;
        local_9 = static_cast<uint>(_e155 + 3u);
        type_7 _e162 = local_8;
        local_42 = _e162;
        uint _e163 = local_9;
        uint _e165 = local_42.inner[1];
        local_42.inner[1] = _e165 + _e163;
        uint _e169 = local_42.inner[0];
        local_43 = static_cast<uint>(_e169);
        uint _e173 = local_42.inner[1];
        local_44 = static_cast<uint>(_e173);
        uint _e176 = local_44;
        out_1[_e176] = naga_f2i32(_e152);
        bool _e178 = choose;
        int _e179 = value;
        int _e184 = rank(static_cast<int>(_e178), static_cast<float>(_e179) + 0.5);
        type_7 _e186 = out;
        local_10 = _e186;
        uint _e187 = base;
        local_11 = static_cast<uint>(_e187 + 4u);
        type_7 _e193 = local_10;
        local_45 = _e193;
        uint _e194 = local_11;
        uint _e196 = local_45.inner[1];
        local_45.inner[1] = _e196 + _e194;
        uint _e200 = local_45.inner[0];
        local_46 = static_cast<uint>(_e200);
        uint _e204 = local_45.inner[1];
        local_47 = static_cast<uint>(_e204);
        uint _e207 = local_47;
        out_1[_e207] = _e184;
        int _e209 = value;
        bool _e213 = choose;
        int _e215 = rank_1(static_cast<float>(_e209) + 0.5, static_cast<int>(_e213));
        type_7 _e217 = out;
        local_12 = _e217;
        uint _e218 = base;
        local_13 = static_cast<uint>(_e218 + 5u);
        type_7 _e224 = local_12;
        local_48 = _e224;
        uint _e225 = local_13;
        uint _e227 = local_48.inner[1];
        local_48.inner[1] = _e227 + _e225;
        uint _e231 = local_48.inner[0];
        local_49 = static_cast<uint>(_e231);
        uint _e235 = local_48.inner[1];
        local_50 = static_cast<uint>(_e235);
        uint _e238 = local_50;
        out_1[_e238] = _e215;
        int _e240 = value;
        int _e244 = value;
        int _e246 = promote(static_cast<uint>(as_type<int>(as_type<uint>(_e240) + as_type<uint>(16))), static_cast<float>(_e244));
        type_7 _e248 = out;
        local_14 = _e248;
        uint _e249 = base;
        local_15 = static_cast<uint>(_e249 + 6u);
        type_7 _e255 = local_14;
        local_51 = _e255;
        uint _e256 = local_15;
        uint _e258 = local_51.inner[1];
        local_51.inner[1] = _e258 + _e256;
        uint _e262 = local_51.inner[0];
        local_52 = static_cast<uint>(_e262);
        uint _e266 = local_51.inner[1];
        local_53 = static_cast<uint>(_e266);
        uint _e269 = local_53;
        out_1[_e269] = _e246;
        int _e271 = value;
        effect = _e271;
        bool _e273 = choose;
        int _e274 = effect;
        effect = as_type<int>(as_type<uint>(_e274) + as_type<uint>(1));
        touch(_e273, _e274);
        int _e277 = effect;
        type_7 _e279 = out;
        local_16 = _e279;
        uint _e280 = base;
        local_17 = static_cast<uint>(_e280 + 7u);
        type_7 _e286 = local_16;
        local_54 = _e286;
        uint _e287 = local_17;
        uint _e289 = local_54.inner[1];
        local_54.inner[1] = _e289 + _e287;
        uint _e293 = local_54.inner[0];
        local_55 = static_cast<uint>(_e293);
        uint _e297 = local_54.inner[1];
        local_56 = static_cast<uint>(_e297);
        uint _e300 = local_56;
        out_1[_e300] = _e277;
        int _e302 = effect;
        int _e303 = touch_1(_e302);
        type_7 _e305 = out;
        local_18 = _e305;
        uint _e306 = base;
        local_19 = static_cast<uint>(_e306 + 8u);
        type_7 _e312 = local_18;
        local_57 = _e312;
        uint _e313 = local_19;
        uint _e315 = local_57.inner[1];
        local_57.inner[1] = _e315 + _e313;
        uint _e319 = local_57.inner[0];
        local_58 = static_cast<uint>(_e319);
        uint _e323 = local_57.inner[1];
        local_59 = static_cast<uint>(_e323);
        uint _e326 = local_59;
        out_1[_e326] = _e303;
        int _e328 = value;
        int _e332 = frozen(static_cast<float>(_e328) + 0.75);
        type_7 _e334 = out;
        local_20 = _e334;
        uint _e335 = base;
        local_21 = static_cast<uint>(_e335 + 9u);
        type_7 _e341 = local_20;
        local_60 = _e341;
        uint _e342 = local_21;
        uint _e344 = local_60.inner[1];
        local_60.inner[1] = _e344 + _e342;
        uint _e348 = local_60.inner[0];
        local_61 = static_cast<uint>(_e348);
        uint _e352 = local_60.inner[1];
        local_62 = static_cast<uint>(_e352);
        uint _e355 = local_62;
        out_1[_e355] = _e332;
        int _e357 = value;
        int _e361 = stage_1(static_cast<float>(_e357) + 0.75);
        type_7 _e363 = out;
        local_22 = _e363;
        uint _e364 = base;
        local_23 = static_cast<uint>(_e364 + 10u);
        type_7 _e370 = local_22;
        local_63 = _e370;
        uint _e371 = local_23;
        uint _e373 = local_63.inner[1];
        local_63.inner[1] = _e373 + _e371;
        uint _e377 = local_63.inner[0];
        local_64 = static_cast<uint>(_e377);
        uint _e381 = local_63.inner[1];
        local_65 = static_cast<uint>(_e381);
        uint _e384 = local_65;
        out_1[_e384] = _e361;
        int _e386 = effect;
        effect = as_type<int>(as_type<uint>(_e386) + as_type<uint>(1));
        int _e389 = classify_1(_e386);
        int _e390 = touch_1(_e389);
        nested = _e390;
        int _e392 = nested;
        int _e395 = effect;
        type_7 _e398 = out;
        local_24 = _e398;
        uint _e399 = base;
        local_25 = static_cast<uint>(_e399 + 11u);
        type_7 _e405 = local_24;
        local_66 = _e405;
        uint _e406 = local_25;
        uint _e408 = local_66.inner[1];
        local_66.inner[1] = _e408 + _e406;
        uint _e412 = local_66.inner[0];
        local_67 = static_cast<uint>(_e412);
        uint _e416 = local_66.inner[1];
        local_68 = static_cast<uint>(_e416);
        uint _e419 = local_68;
        out_1[_e419] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e392) * as_type<uint>(10))) + as_type<uint>(_e395));
        int _e421 = value;
        argument = as_type<int>(as_type<uint>(_e421) + as_type<uint>(8));
        int _e425 = argument;
        int _e426 = argument;
        argument = as_type<int>(as_type<uint>(_e426) + as_type<uint>(1));
        int _e430 = pair(static_cast<float>(_e425), _e426);
        captured = _e430;
        int _e432 = captured;
        int _e435 = argument;
        type_7 _e438 = out;
        local_26 = _e438;
        uint _e439 = base;
        local_27 = static_cast<uint>(_e439 + 12u);
        type_7 _e445 = local_26;
        local_69 = _e445;
        uint _e446 = local_27;
        uint _e448 = local_69.inner[1];
        local_69.inner[1] = _e448 + _e446;
        uint _e452 = local_69.inner[0];
        local_70 = static_cast<uint>(_e452);
        uint _e456 = local_69.inner[1];
        local_71 = static_cast<uint>(_e456);
        uint _e459 = local_71;
        out_1[_e459] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e432) * as_type<uint>(100))) + as_type<uint>(_e435));
    }
}
