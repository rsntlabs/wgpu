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

int step(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(3));
    int _e5 = value_2;
    return _e5;
}

int doubled(
    int value_3
) {
    int _e1 = step(value_3);
    return as_type<int>(as_type<uint>(_e1) * as_type<uint>(2));
}

uint advance(
    uint value_4
) {
    return value_4 + 5u;
}

uint retreat(
    uint value_5
) {
    return value_5 - 2u;
}

float scale(
    float value_6,
    int bias
) {
    return (value_6 * 2.0) + static_cast<float>(bias);
}

bool same(
    int left,
    int right
) {
    return left == right;
}

void consume(
    bool stop,
    int value_7
) {
    int value_8 = {};
    value_8 = value_7;
    if (stop) {
        return;
    }
    int _e3 = value_8;
    int _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

void forward(
    bool stop_1,
    int value_9
) {
    int _e2 = step(value_9);
    consume(stop_1, _e2);
    return;
}

int device_only(
    int value_10
) {
    int _e1 = step(value_10);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(1));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct dual_executionInput {
};
kernel void dual_execution(
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
    uint local_26 = {};
    int local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    int local_32 = {};
    uint local_33 = {};
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
        int _e26 = value;
        int _e27 = step(_e26);
        uint _e28 = base;
        local_1 = _e28;
        uint _e30 = local_1;
        local_20 = _e30;
        uint _e32 = local_20;
        out[_e32] = _e27;
        int _e35 = value;
        uint _e36 = base;
        local_2 = static_cast<uint>(_e36 + 1u);
        uint _e41 = local_2;
        local_21 = _e41;
        uint _e43 = local_21;
        out[_e43] = _e35;
        int _e45 = value;
        int _e46 = doubled(_e45);
        uint _e47 = base;
        local_3 = static_cast<uint>(_e47 + 2u);
        uint _e52 = local_3;
        local_22 = _e52;
        uint _e54 = local_22;
        out[_e54] = _e46;
        int _e56 = value;
        uint _e58 = advance(static_cast<uint>(_e56));
        uint _e59 = base;
        local_4 = static_cast<uint>(_e59 + 3u);
        uint _e65 = local_4;
        local_23 = _e65;
        uint _e67 = local_23;
        out[_e67] = static_cast<int>(_e58);
        int _e69 = value;
        uint _e71 = retreat(static_cast<uint>(_e69));
        uint _e72 = base;
        local_5 = static_cast<uint>(_e72 + 4u);
        uint _e78 = local_5;
        local_24 = _e78;
        uint _e80 = local_24;
        out[_e80] = static_cast<int>(_e71);
        int _e82 = value;
        float _e85 = scale(static_cast<float>(_e82), 4);
        uint _e86 = base;
        local_6 = static_cast<uint>(_e86 + 5u);
        uint _e92 = local_6;
        local_25 = _e92;
        uint _e94 = local_25;
        out[_e94] = naga_f2i32(_e85);
        int _e96 = value;
        local_8 = i;
        uint _e98 = local_8;
        local_26 = _e98;
        uint _e100 = local_26;
        int _e102 = input[_e100];
        local_27 = _e102;
        int _e104 = local_27;
        local_16 = _e104;
        int _e106 = local_16;
        bool _e107 = same(_e96, _e106);
        uint _e108 = base;
        local_7 = static_cast<uint>(_e108 + 6u);
        uint _e114 = local_7;
        local_28 = _e114;
        uint _e116 = local_28;
        out[_e116] = static_cast<int>(_e107);
        int _e122 = value;
        value = as_type<int>(as_type<uint>(_e122) + as_type<uint>(1));
        consume(naga_mod(i, 2u) == 0u, _e122);
        int _e125 = value;
        uint _e126 = base;
        local_9 = static_cast<uint>(_e126 + 7u);
        uint _e131 = local_9;
        local_29 = _e131;
        uint _e133 = local_29;
        out[_e133] = _e125;
        int _e139 = value;
        value = as_type<int>(as_type<uint>(_e139) + as_type<uint>(1));
        forward(naga_mod(i, 2u) != 0u, _e139);
        int _e142 = value;
        uint _e143 = base;
        local_10 = static_cast<uint>(_e143 + 8u);
        uint _e148 = local_10;
        local_30 = _e148;
        uint _e150 = local_30;
        out[_e150] = _e142;
        int _e152 = value;
        local_12 = i;
        uint _e154 = local_12;
        local_31 = _e154;
        uint _e156 = local_31;
        int _e158 = input[_e156];
        local_32 = _e158;
        int _e160 = local_32;
        local_17 = _e160;
        int _e162 = local_17;
        bool _e163 = same(_e152, _e162);
        uint _e164 = base;
        local_11 = static_cast<uint>(_e164 + 9u);
        uint _e170 = local_11;
        local_33 = _e170;
        uint _e172 = local_33;
        out[_e172] = static_cast<int>(_e163);
        int _e174 = value;
        int _e175 = step(_e174);
        int _e176 = device_only(_e175);
        uint _e177 = base;
        local_13 = static_cast<uint>(_e177 + 10u);
        uint _e182 = local_13;
        local_34 = _e182;
        uint _e184 = local_34;
        out[_e184] = _e176;
        int _e186 = value;
        uint _e187 = base;
        local_14 = static_cast<uint>(_e187 + 11u);
        uint _e192 = local_14;
        local_35 = _e192;
        uint _e194 = local_35;
        out[_e194] = _e186;
    }
}
