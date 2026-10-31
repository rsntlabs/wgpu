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

int increment(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(2));
    int _e5 = value_2;
    return _e5;
}

int twice(
    int value_3
) {
    int _e1 = increment(value_3);
    return as_type<int>(as_type<uint>(_e1) * as_type<uint>(2));
}

int advance(
    int value_4
) {
    int _e1 = twice(value_4);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(1));
}

int retreat(
    int value_5
) {
    return as_type<int>(as_type<uint>(value_5) - as_type<uint>(3));
}

float scaled(
    float value_6
) {
    return (value_6 * 1.5) + 0.5;
}

bool differs(
    int value_7,
    int other
) {
    return value_7 != other;
}

void consume(
    bool stop,
    int value_8
) {
    int value_9 = {};
    value_9 = value_8;
    if (stop) {
        return;
    }
    int _e3 = value_9;
    int _e4 = advance(_e3);
    value_9 = _e4;
    return;
}

void forward(
    bool stop_1,
    int value_10
) {
    int _e2 = retreat(value_10);
    consume(stop_1, _e2);
    return;
}

uint plus_one(
    uint value_11
) {
    return value_11 + 1u;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


struct function_specifiersInput {
};
kernel void function_specifiers(
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
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    int local_15 = {};
    int local_16 = {};
    int local_17 = {};
    uint local_18 = {};
    int local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    int local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        local = i;
        uint _e15 = local;
        local_18 = _e15;
        uint _e17 = local_18;
        int _e20 = input[_e17];
        local_19 = _e20;
        int _e22 = local_19;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        choose = naga_mod(i, 2u) == 0u;
        int _e31 = value;
        int _e32 = increment(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e35 = local_1;
        local_20 = _e35;
        uint _e37 = local_20;
        out[_e37] = _e32;
        int _e40 = value;
        int _e41 = twice(_e40);
        uint _e42 = base;
        local_2 = static_cast<uint>(_e42 + 1u);
        uint _e47 = local_2;
        local_21 = _e47;
        uint _e49 = local_21;
        out[_e49] = _e41;
        int _e51 = value;
        int _e52 = advance(_e51);
        uint _e53 = base;
        local_3 = static_cast<uint>(_e53 + 2u);
        uint _e58 = local_3;
        local_22 = _e58;
        uint _e60 = local_22;
        out[_e60] = _e52;
        int _e62 = value;
        int _e63 = retreat(_e62);
        uint _e64 = base;
        local_4 = static_cast<uint>(_e64 + 3u);
        uint _e69 = local_4;
        local_23 = _e69;
        uint _e71 = local_23;
        out[_e71] = _e63;
        int _e73 = value;
        float _e75 = scaled(static_cast<float>(_e73));
        uint _e76 = base;
        local_5 = static_cast<uint>(_e76 + 4u);
        uint _e82 = local_5;
        local_24 = _e82;
        uint _e84 = local_24;
        out[_e84] = naga_f2i32(_e75);
        int _e86 = value;
        local_7 = i;
        uint _e88 = local_7;
        local_25 = _e88;
        uint _e90 = local_25;
        int _e92 = input[_e90];
        local_26 = _e92;
        int _e94 = local_26;
        local_16 = _e94;
        int _e96 = local_16;
        bool _e97 = differs(_e86, _e96);
        uint _e98 = base;
        local_6 = static_cast<uint>(_e98 + 5u);
        uint _e104 = local_6;
        local_27 = _e104;
        uint _e106 = local_27;
        out[_e106] = static_cast<int>(_e97);
        int _e108 = value;
        effect = _e108;
        bool _e110 = choose;
        int _e111 = effect;
        effect = as_type<int>(as_type<uint>(_e111) + as_type<uint>(1));
        consume(_e110, _e111);
        int _e114 = effect;
        uint _e115 = base;
        local_8 = static_cast<uint>(_e115 + 6u);
        uint _e120 = local_8;
        local_28 = _e120;
        uint _e122 = local_28;
        out[_e122] = _e114;
        bool _e124 = choose;
        int _e126 = effect;
        effect = as_type<int>(as_type<uint>(_e126) + as_type<uint>(1));
        forward(!(_e124), _e126);
        int _e129 = effect;
        uint _e130 = base;
        local_9 = static_cast<uint>(_e130 + 7u);
        uint _e135 = local_9;
        local_29 = _e135;
        uint _e137 = local_29;
        out[_e137] = _e129;
        int _e139 = effect;
        int _e140 = advance(_e139);
        uint _e141 = base;
        local_10 = static_cast<uint>(_e141 + 8u);
        uint _e146 = local_10;
        local_30 = _e146;
        uint _e148 = local_30;
        out[_e148] = _e140;
        int _e150 = effect;
        uint _e154 = plus_one(static_cast<uint>(as_type<int>(as_type<uint>(_e150) + as_type<uint>(16))));
        uint _e155 = base;
        local_11 = static_cast<uint>(_e155 + 9u);
        uint _e161 = local_11;
        local_31 = _e161;
        uint _e163 = local_31;
        out[_e163] = static_cast<int>(_e154);
        int _e165 = effect;
        local_13 = i;
        uint _e167 = local_13;
        local_32 = _e167;
        uint _e169 = local_32;
        int _e171 = input[_e169];
        local_33 = _e171;
        int _e173 = local_33;
        local_17 = _e173;
        int _e175 = local_17;
        bool _e176 = differs(_e165, _e175);
        uint _e177 = base;
        local_12 = static_cast<uint>(_e177 + 10u);
        uint _e183 = local_12;
        local_34 = _e183;
        uint _e185 = local_34;
        out[_e185] = static_cast<int>(_e176);
        int _e187 = effect;
        uint _e188 = base;
        local_14 = static_cast<uint>(_e188 + 11u);
        uint _e193 = local_14;
        local_35 = _e193;
        uint _e195 = local_35;
        out[_e195] = _e187;
    }
}
