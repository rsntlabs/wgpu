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
, device type_4& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    uint local = {};
    bool choose = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int effect = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int nested = {};
    uint local_12 = {};
    int argument = {};
    int captured = {};
    uint local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    int local_16 = {};
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
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 13u;
        local = static_cast<uint>(i);
        uint _e16 = local;
        local_15 = static_cast<uint>(_e16);
        uint _e19 = local_15;
        int _e22 = input[_e19];
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = naga_mod(i, 2u) == 0u;
        bool _e33 = choose;
        bool _e34 = classify(_e33);
        uint _e35 = base;
        local_1 = static_cast<uint>(_e35);
        uint _e39 = local_1;
        local_17 = static_cast<uint>(_e39);
        uint _e42 = local_17;
        out[_e42] = static_cast<int>(_e34);
        int _e45 = value;
        int _e46 = classify_1(_e45);
        uint _e47 = base;
        local_2 = static_cast<uint>(_e47 + 1u);
        uint _e52 = local_2;
        local_18 = static_cast<uint>(_e52);
        uint _e55 = local_18;
        out[_e55] = _e46;
        int _e57 = value;
        uint _e61 = classify_2(static_cast<uint>(as_type<int>(as_type<uint>(_e57) + as_type<uint>(16))));
        uint _e62 = base;
        local_3 = static_cast<uint>(_e62 + 2u);
        uint _e68 = local_3;
        local_19 = static_cast<uint>(_e68);
        uint _e71 = local_19;
        out[_e71] = static_cast<int>(_e61);
        int _e73 = value;
        float _e75 = classify_3(static_cast<float>(_e73));
        uint _e76 = base;
        local_4 = static_cast<uint>(_e76 + 3u);
        uint _e82 = local_4;
        local_20 = static_cast<uint>(_e82);
        uint _e85 = local_20;
        out[_e85] = naga_f2i32(_e75);
        bool _e87 = choose;
        int _e88 = value;
        int _e93 = rank(static_cast<int>(_e87), static_cast<float>(_e88) + 0.5);
        uint _e94 = base;
        local_5 = static_cast<uint>(_e94 + 4u);
        uint _e99 = local_5;
        local_21 = static_cast<uint>(_e99);
        uint _e102 = local_21;
        out[_e102] = _e93;
        int _e104 = value;
        bool _e108 = choose;
        int _e110 = rank_1(static_cast<float>(_e104) + 0.5, static_cast<int>(_e108));
        uint _e111 = base;
        local_6 = static_cast<uint>(_e111 + 5u);
        uint _e116 = local_6;
        local_22 = static_cast<uint>(_e116);
        uint _e119 = local_22;
        out[_e119] = _e110;
        int _e121 = value;
        int _e125 = value;
        int _e127 = promote(static_cast<uint>(as_type<int>(as_type<uint>(_e121) + as_type<uint>(16))), static_cast<float>(_e125));
        uint _e128 = base;
        local_7 = static_cast<uint>(_e128 + 6u);
        uint _e133 = local_7;
        local_23 = static_cast<uint>(_e133);
        uint _e136 = local_23;
        out[_e136] = _e127;
        int _e138 = value;
        effect = _e138;
        bool _e140 = choose;
        int _e141 = effect;
        effect = as_type<int>(as_type<uint>(_e141) + as_type<uint>(1));
        touch(_e140, _e141);
        int _e144 = effect;
        uint _e145 = base;
        local_8 = static_cast<uint>(_e145 + 7u);
        uint _e150 = local_8;
        local_24 = static_cast<uint>(_e150);
        uint _e153 = local_24;
        out[_e153] = _e144;
        int _e155 = effect;
        int _e156 = touch_1(_e155);
        uint _e157 = base;
        local_9 = static_cast<uint>(_e157 + 8u);
        uint _e162 = local_9;
        local_25 = static_cast<uint>(_e162);
        uint _e165 = local_25;
        out[_e165] = _e156;
        int _e167 = value;
        int _e171 = frozen(static_cast<float>(_e167) + 0.75);
        uint _e172 = base;
        local_10 = static_cast<uint>(_e172 + 9u);
        uint _e177 = local_10;
        local_26 = static_cast<uint>(_e177);
        uint _e180 = local_26;
        out[_e180] = _e171;
        int _e182 = value;
        int _e186 = stage_1(static_cast<float>(_e182) + 0.75);
        uint _e187 = base;
        local_11 = static_cast<uint>(_e187 + 10u);
        uint _e192 = local_11;
        local_27 = static_cast<uint>(_e192);
        uint _e195 = local_27;
        out[_e195] = _e186;
        int _e197 = effect;
        effect = as_type<int>(as_type<uint>(_e197) + as_type<uint>(1));
        int _e200 = classify_1(_e197);
        int _e201 = touch_1(_e200);
        nested = _e201;
        int _e203 = nested;
        int _e206 = effect;
        uint _e208 = base;
        local_12 = static_cast<uint>(_e208 + 11u);
        uint _e213 = local_12;
        local_28 = static_cast<uint>(_e213);
        uint _e216 = local_28;
        out[_e216] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e203) * as_type<uint>(10))) + as_type<uint>(_e206));
        int _e218 = value;
        argument = as_type<int>(as_type<uint>(_e218) + as_type<uint>(8));
        int _e222 = argument;
        int _e223 = argument;
        argument = as_type<int>(as_type<uint>(_e223) + as_type<uint>(1));
        int _e227 = pair(static_cast<float>(_e222), _e223);
        captured = _e227;
        int _e229 = captured;
        int _e232 = argument;
        uint _e234 = base;
        local_13 = static_cast<uint>(_e234 + 12u);
        uint _e239 = local_13;
        local_29 = static_cast<uint>(_e239);
        uint _e242 = local_29;
        out[_e242] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e229) * as_type<uint>(100))) + as_type<uint>(_e232));
    }
}
