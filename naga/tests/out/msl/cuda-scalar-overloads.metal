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
, device type_4& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    bool choose = {};
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
    int effect = {};
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
    int nested = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    int argument = {};
    int captured = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    int local_45 = {};
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
    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e16 = i;
    uint _e17 = n;
    if (_e16 < _e17) {
        uint _e19 = i;
        base = _e19 * 13u;
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = static_cast<uint>(_e25);
        uint _e28 = i;
        local_4 = static_cast<uint>(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_44 = static_cast<uint>(_e32 + _e33);
        uint _e38 = local_44;
        int _e40 = input[_e38];
        local_45 = _e40;
        int _e41 = local_45;
        value = _e41;
        uint _e43 = i;
        choose = naga_mod(_e43, 2u) == 0u;
        bool _e49 = choose;
        bool _e50 = classify(_e49);
        uint _e51 = local;
        local_5 = _e51;
        uint _e53 = local_5;
        local_6 = static_cast<uint>(_e53);
        uint _e56 = base;
        local_7 = static_cast<uint>(_e56);
        uint _e61 = local_6;
        uint _e62 = local_7;
        local_46 = static_cast<uint>(_e61 + _e62);
        uint _e66 = local_46;
        out[_e66] = static_cast<int>(_e50);
        int _e68 = value;
        int _e69 = classify_1(_e68);
        uint _e70 = local;
        local_8 = _e70;
        uint _e72 = local_8;
        local_9 = static_cast<uint>(_e72);
        uint _e75 = base;
        local_10 = static_cast<uint>(_e75 + 1u);
        uint _e80 = local_9;
        uint _e81 = local_10;
        local_47 = static_cast<uint>(_e80 + _e81);
        uint _e85 = local_47;
        out[_e85] = _e69;
        int _e87 = value;
        uint _e91 = classify_2(static_cast<uint>(as_type<int>(as_type<uint>(_e87) + as_type<uint>(16))));
        uint _e92 = local;
        local_11 = _e92;
        uint _e94 = local_11;
        local_12 = static_cast<uint>(_e94);
        uint _e97 = base;
        local_13 = static_cast<uint>(_e97 + 2u);
        uint _e103 = local_12;
        uint _e104 = local_13;
        local_48 = static_cast<uint>(_e103 + _e104);
        uint _e108 = local_48;
        out[_e108] = static_cast<int>(_e91);
        int _e110 = value;
        float _e112 = classify_3(static_cast<float>(_e110));
        uint _e113 = local;
        local_14 = _e113;
        uint _e115 = local_14;
        local_15 = static_cast<uint>(_e115);
        uint _e118 = base;
        local_16 = static_cast<uint>(_e118 + 3u);
        uint _e124 = local_15;
        uint _e125 = local_16;
        local_49 = static_cast<uint>(_e124 + _e125);
        uint _e129 = local_49;
        out[_e129] = naga_f2i32(_e112);
        bool _e131 = choose;
        int _e132 = value;
        int _e137 = rank(static_cast<int>(_e131), static_cast<float>(_e132) + 0.5);
        uint _e138 = local;
        local_17 = _e138;
        uint _e140 = local_17;
        local_18 = static_cast<uint>(_e140);
        uint _e143 = base;
        local_19 = static_cast<uint>(_e143 + 4u);
        uint _e148 = local_18;
        uint _e149 = local_19;
        local_50 = static_cast<uint>(_e148 + _e149);
        uint _e153 = local_50;
        out[_e153] = _e137;
        int _e155 = value;
        bool _e159 = choose;
        int _e161 = rank_1(static_cast<float>(_e155) + 0.5, static_cast<int>(_e159));
        uint _e162 = local;
        local_20 = _e162;
        uint _e164 = local_20;
        local_21 = static_cast<uint>(_e164);
        uint _e167 = base;
        local_22 = static_cast<uint>(_e167 + 5u);
        uint _e172 = local_21;
        uint _e173 = local_22;
        local_51 = static_cast<uint>(_e172 + _e173);
        uint _e177 = local_51;
        out[_e177] = _e161;
        int _e179 = value;
        int _e183 = value;
        int _e185 = promote(static_cast<uint>(as_type<int>(as_type<uint>(_e179) + as_type<uint>(16))), static_cast<float>(_e183));
        uint _e186 = local;
        local_23 = _e186;
        uint _e188 = local_23;
        local_24 = static_cast<uint>(_e188);
        uint _e191 = base;
        local_25 = static_cast<uint>(_e191 + 6u);
        uint _e196 = local_24;
        uint _e197 = local_25;
        local_52 = static_cast<uint>(_e196 + _e197);
        uint _e201 = local_52;
        out[_e201] = _e185;
        int _e203 = value;
        effect = _e203;
        bool _e205 = choose;
        int _e206 = effect;
        effect = as_type<int>(as_type<uint>(_e206) + as_type<uint>(1));
        touch(_e205, _e206);
        int _e209 = effect;
        uint _e210 = local;
        local_26 = _e210;
        uint _e212 = local_26;
        local_27 = static_cast<uint>(_e212);
        uint _e215 = base;
        local_28 = static_cast<uint>(_e215 + 7u);
        uint _e220 = local_27;
        uint _e221 = local_28;
        local_53 = static_cast<uint>(_e220 + _e221);
        uint _e225 = local_53;
        out[_e225] = _e209;
        int _e227 = effect;
        int _e228 = touch_1(_e227);
        uint _e229 = local;
        local_29 = _e229;
        uint _e231 = local_29;
        local_30 = static_cast<uint>(_e231);
        uint _e234 = base;
        local_31 = static_cast<uint>(_e234 + 8u);
        uint _e239 = local_30;
        uint _e240 = local_31;
        local_54 = static_cast<uint>(_e239 + _e240);
        uint _e244 = local_54;
        out[_e244] = _e228;
        int _e246 = value;
        int _e250 = frozen(static_cast<float>(_e246) + 0.75);
        uint _e251 = local;
        local_32 = _e251;
        uint _e253 = local_32;
        local_33 = static_cast<uint>(_e253);
        uint _e256 = base;
        local_34 = static_cast<uint>(_e256 + 9u);
        uint _e261 = local_33;
        uint _e262 = local_34;
        local_55 = static_cast<uint>(_e261 + _e262);
        uint _e266 = local_55;
        out[_e266] = _e250;
        int _e268 = value;
        int _e272 = stage_1(static_cast<float>(_e268) + 0.75);
        uint _e273 = local;
        local_35 = _e273;
        uint _e275 = local_35;
        local_36 = static_cast<uint>(_e275);
        uint _e278 = base;
        local_37 = static_cast<uint>(_e278 + 10u);
        uint _e283 = local_36;
        uint _e284 = local_37;
        local_56 = static_cast<uint>(_e283 + _e284);
        uint _e288 = local_56;
        out[_e288] = _e272;
        int _e290 = effect;
        effect = as_type<int>(as_type<uint>(_e290) + as_type<uint>(1));
        int _e293 = classify_1(_e290);
        int _e294 = touch_1(_e293);
        nested = _e294;
        int _e296 = nested;
        int _e299 = effect;
        uint _e301 = local;
        local_38 = _e301;
        uint _e303 = local_38;
        local_39 = static_cast<uint>(_e303);
        uint _e306 = base;
        local_40 = static_cast<uint>(_e306 + 11u);
        uint _e311 = local_39;
        uint _e312 = local_40;
        local_57 = static_cast<uint>(_e311 + _e312);
        uint _e316 = local_57;
        out[_e316] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e296) * as_type<uint>(10))) + as_type<uint>(_e299));
        int _e318 = value;
        argument = as_type<int>(as_type<uint>(_e318) + as_type<uint>(8));
        int _e322 = argument;
        int _e323 = argument;
        argument = as_type<int>(as_type<uint>(_e323) + as_type<uint>(1));
        int _e327 = pair(static_cast<float>(_e322), _e323);
        captured = _e327;
        int _e329 = captured;
        int _e332 = argument;
        uint _e334 = local;
        local_41 = _e334;
        uint _e336 = local_41;
        local_42 = static_cast<uint>(_e336);
        uint _e339 = base;
        local_43 = static_cast<uint>(_e339 + 12u);
        uint _e344 = local_42;
        uint _e345 = local_43;
        local_58 = static_cast<uint>(_e344 + _e345);
        uint _e349 = local_58;
        out[_e349] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e329) * as_type<uint>(100))) + as_type<uint>(_e332));
    }
}
