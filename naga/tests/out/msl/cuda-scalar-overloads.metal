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
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = input[_e17];
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = naga_mod(i, 2u) == 0u;
        bool _e31 = choose;
        bool _e32 = classify(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e36 = local_1;
        local_17 = _e36;
        uint _e38 = local_17;
        out[_e38] = static_cast<int>(_e32);
        int _e41 = value;
        int _e42 = classify_1(_e41);
        uint _e43 = base;
        local_2 = static_cast<uint>(_e43 + 1u);
        uint _e48 = local_2;
        local_18 = _e48;
        uint _e50 = local_18;
        out[_e50] = _e42;
        int _e52 = value;
        uint _e56 = classify_2(static_cast<uint>(as_type<int>(as_type<uint>(_e52) + as_type<uint>(16))));
        uint _e57 = base;
        local_3 = static_cast<uint>(_e57 + 2u);
        uint _e63 = local_3;
        local_19 = _e63;
        uint _e65 = local_19;
        out[_e65] = static_cast<int>(_e56);
        int _e67 = value;
        float _e69 = classify_3(static_cast<float>(_e67));
        uint _e70 = base;
        local_4 = static_cast<uint>(_e70 + 3u);
        uint _e76 = local_4;
        local_20 = _e76;
        uint _e78 = local_20;
        out[_e78] = naga_f2i32(_e69);
        bool _e80 = choose;
        int _e81 = value;
        int _e86 = rank(static_cast<int>(_e80), static_cast<float>(_e81) + 0.5);
        uint _e87 = base;
        local_5 = static_cast<uint>(_e87 + 4u);
        uint _e92 = local_5;
        local_21 = _e92;
        uint _e94 = local_21;
        out[_e94] = _e86;
        int _e96 = value;
        bool _e100 = choose;
        int _e102 = rank_1(static_cast<float>(_e96) + 0.5, static_cast<int>(_e100));
        uint _e103 = base;
        local_6 = static_cast<uint>(_e103 + 5u);
        uint _e108 = local_6;
        local_22 = _e108;
        uint _e110 = local_22;
        out[_e110] = _e102;
        int _e112 = value;
        int _e116 = value;
        int _e118 = promote(static_cast<uint>(as_type<int>(as_type<uint>(_e112) + as_type<uint>(16))), static_cast<float>(_e116));
        uint _e119 = base;
        local_7 = static_cast<uint>(_e119 + 6u);
        uint _e124 = local_7;
        local_23 = _e124;
        uint _e126 = local_23;
        out[_e126] = _e118;
        int _e128 = value;
        effect = _e128;
        bool _e130 = choose;
        int _e131 = effect;
        effect = as_type<int>(as_type<uint>(_e131) + as_type<uint>(1));
        touch(_e130, _e131);
        int _e134 = effect;
        uint _e135 = base;
        local_8 = static_cast<uint>(_e135 + 7u);
        uint _e140 = local_8;
        local_24 = _e140;
        uint _e142 = local_24;
        out[_e142] = _e134;
        int _e144 = effect;
        int _e145 = touch_1(_e144);
        uint _e146 = base;
        local_9 = static_cast<uint>(_e146 + 8u);
        uint _e151 = local_9;
        local_25 = _e151;
        uint _e153 = local_25;
        out[_e153] = _e145;
        int _e155 = value;
        int _e159 = frozen(static_cast<float>(_e155) + 0.75);
        uint _e160 = base;
        local_10 = static_cast<uint>(_e160 + 9u);
        uint _e165 = local_10;
        local_26 = _e165;
        uint _e167 = local_26;
        out[_e167] = _e159;
        int _e169 = value;
        int _e173 = stage_1(static_cast<float>(_e169) + 0.75);
        uint _e174 = base;
        local_11 = static_cast<uint>(_e174 + 10u);
        uint _e179 = local_11;
        local_27 = _e179;
        uint _e181 = local_27;
        out[_e181] = _e173;
        int _e183 = effect;
        effect = as_type<int>(as_type<uint>(_e183) + as_type<uint>(1));
        int _e186 = classify_1(_e183);
        int _e187 = touch_1(_e186);
        nested = _e187;
        int _e189 = nested;
        int _e192 = effect;
        uint _e194 = base;
        local_12 = static_cast<uint>(_e194 + 11u);
        uint _e199 = local_12;
        local_28 = _e199;
        uint _e201 = local_28;
        out[_e201] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e189) * as_type<uint>(10))) + as_type<uint>(_e192));
        int _e203 = value;
        argument = as_type<int>(as_type<uint>(_e203) + as_type<uint>(8));
        int _e207 = argument;
        int _e208 = argument;
        argument = as_type<int>(as_type<uint>(_e208) + as_type<uint>(1));
        int _e212 = pair(static_cast<float>(_e207), _e208);
        captured = _e212;
        int _e214 = captured;
        int _e217 = argument;
        uint _e219 = base;
        local_13 = static_cast<uint>(_e219 + 12u);
        uint _e224 = local_13;
        local_29 = _e224;
        uint _e226 = local_29;
        out[_e226] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e214) * as_type<uint>(100))) + as_type<uint>(_e217));
    }
}
