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
        local = static_cast<uint>(i);
        uint _e16 = local;
        local_18 = static_cast<uint>(_e16);
        uint _e19 = local_18;
        int _e22 = input[_e19];
        local_19 = _e22;
        int _e24 = local_19;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        choose = naga_mod(i, 2u) == 0u;
        int _e33 = value;
        int _e34 = increment(_e33);
        uint _e35 = base;
        local_1 = static_cast<uint>(_e35);
        uint _e38 = local_1;
        local_20 = static_cast<uint>(_e38);
        uint _e41 = local_20;
        out[_e41] = _e34;
        int _e44 = value;
        int _e45 = twice(_e44);
        uint _e46 = base;
        local_2 = static_cast<uint>(_e46 + 1u);
        uint _e51 = local_2;
        local_21 = static_cast<uint>(_e51);
        uint _e54 = local_21;
        out[_e54] = _e45;
        int _e56 = value;
        int _e57 = advance(_e56);
        uint _e58 = base;
        local_3 = static_cast<uint>(_e58 + 2u);
        uint _e63 = local_3;
        local_22 = static_cast<uint>(_e63);
        uint _e66 = local_22;
        out[_e66] = _e57;
        int _e68 = value;
        int _e69 = retreat(_e68);
        uint _e70 = base;
        local_4 = static_cast<uint>(_e70 + 3u);
        uint _e75 = local_4;
        local_23 = static_cast<uint>(_e75);
        uint _e78 = local_23;
        out[_e78] = _e69;
        int _e80 = value;
        float _e82 = scaled(static_cast<float>(_e80));
        uint _e83 = base;
        local_5 = static_cast<uint>(_e83 + 4u);
        uint _e89 = local_5;
        local_24 = static_cast<uint>(_e89);
        uint _e92 = local_24;
        out[_e92] = naga_f2i32(_e82);
        int _e94 = value;
        local_7 = static_cast<uint>(i);
        uint _e97 = local_7;
        local_25 = static_cast<uint>(_e97);
        uint _e100 = local_25;
        int _e102 = input[_e100];
        local_26 = _e102;
        int _e104 = local_26;
        local_16 = _e104;
        int _e106 = local_16;
        bool _e107 = differs(_e94, _e106);
        uint _e108 = base;
        local_6 = static_cast<uint>(_e108 + 5u);
        uint _e114 = local_6;
        local_27 = static_cast<uint>(_e114);
        uint _e117 = local_27;
        out[_e117] = static_cast<int>(_e107);
        int _e119 = value;
        effect = _e119;
        bool _e121 = choose;
        int _e122 = effect;
        effect = as_type<int>(as_type<uint>(_e122) + as_type<uint>(1));
        consume(_e121, _e122);
        int _e125 = effect;
        uint _e126 = base;
        local_8 = static_cast<uint>(_e126 + 6u);
        uint _e131 = local_8;
        local_28 = static_cast<uint>(_e131);
        uint _e134 = local_28;
        out[_e134] = _e125;
        bool _e136 = choose;
        int _e138 = effect;
        effect = as_type<int>(as_type<uint>(_e138) + as_type<uint>(1));
        forward(!(_e136), _e138);
        int _e141 = effect;
        uint _e142 = base;
        local_9 = static_cast<uint>(_e142 + 7u);
        uint _e147 = local_9;
        local_29 = static_cast<uint>(_e147);
        uint _e150 = local_29;
        out[_e150] = _e141;
        int _e152 = effect;
        int _e153 = advance(_e152);
        uint _e154 = base;
        local_10 = static_cast<uint>(_e154 + 8u);
        uint _e159 = local_10;
        local_30 = static_cast<uint>(_e159);
        uint _e162 = local_30;
        out[_e162] = _e153;
        int _e164 = effect;
        uint _e168 = plus_one(static_cast<uint>(as_type<int>(as_type<uint>(_e164) + as_type<uint>(16))));
        uint _e169 = base;
        local_11 = static_cast<uint>(_e169 + 9u);
        uint _e175 = local_11;
        local_31 = static_cast<uint>(_e175);
        uint _e178 = local_31;
        out[_e178] = static_cast<int>(_e168);
        int _e180 = effect;
        local_13 = static_cast<uint>(i);
        uint _e183 = local_13;
        local_32 = static_cast<uint>(_e183);
        uint _e186 = local_32;
        int _e188 = input[_e186];
        local_33 = _e188;
        int _e190 = local_33;
        local_17 = _e190;
        int _e192 = local_17;
        bool _e193 = differs(_e180, _e192);
        uint _e194 = base;
        local_12 = static_cast<uint>(_e194 + 10u);
        uint _e200 = local_12;
        local_34 = static_cast<uint>(_e200);
        uint _e203 = local_34;
        out[_e203] = static_cast<int>(_e193);
        int _e205 = effect;
        uint _e206 = base;
        local_14 = static_cast<uint>(_e206 + 11u);
        uint _e211 = local_14;
        local_35 = static_cast<uint>(_e211);
        uint _e214 = local_35;
        out[_e214] = _e205;
    }
}
