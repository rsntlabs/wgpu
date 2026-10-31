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

int doubled(
    int value_3
) {
    int _e1 = increment(value_3);
    return as_type<int>(as_type<uint>(_e1) * as_type<uint>(2));
}

uint advance(
    uint value_4
) {
    return value_4 + 3u;
}

uint retreat(
    uint value_5
) {
    return value_5 - 1u;
}

float scale(
    float value_6,
    int bias
) {
    return (value_6 * 1.5) + static_cast<float>(bias);
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
    int _e2 = increment(value_9);
    consume(stop_1, _e2);
    return;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct inline_functionsInput {
};
kernel void inline_functions(
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
        int _e28 = value;
        int _e29 = increment(_e28);
        uint _e30 = base;
        local_1 = static_cast<uint>(_e30);
        uint _e33 = local_1;
        local_20 = static_cast<uint>(_e33);
        uint _e36 = local_20;
        out[_e36] = _e29;
        int _e39 = value;
        uint _e40 = base;
        local_2 = static_cast<uint>(_e40 + 1u);
        uint _e45 = local_2;
        local_21 = static_cast<uint>(_e45);
        uint _e48 = local_21;
        out[_e48] = _e39;
        int _e50 = value;
        int _e51 = doubled(_e50);
        uint _e52 = base;
        local_3 = static_cast<uint>(_e52 + 2u);
        uint _e57 = local_3;
        local_22 = static_cast<uint>(_e57);
        uint _e60 = local_22;
        out[_e60] = _e51;
        int _e62 = value;
        uint _e64 = advance(static_cast<uint>(_e62));
        uint _e65 = base;
        local_4 = static_cast<uint>(_e65 + 3u);
        uint _e71 = local_4;
        local_23 = static_cast<uint>(_e71);
        uint _e74 = local_23;
        out[_e74] = static_cast<int>(_e64);
        int _e76 = value;
        uint _e78 = retreat(static_cast<uint>(_e76));
        uint _e79 = base;
        local_5 = static_cast<uint>(_e79 + 4u);
        uint _e85 = local_5;
        local_24 = static_cast<uint>(_e85);
        uint _e88 = local_24;
        out[_e88] = static_cast<int>(_e78);
        int _e90 = value;
        float _e93 = scale(static_cast<float>(_e90), 2);
        uint _e94 = base;
        local_6 = static_cast<uint>(_e94 + 5u);
        uint _e100 = local_6;
        local_25 = static_cast<uint>(_e100);
        uint _e103 = local_25;
        out[_e103] = naga_f2i32(_e93);
        int _e105 = value;
        local_8 = static_cast<uint>(i);
        uint _e108 = local_8;
        local_26 = static_cast<uint>(_e108);
        uint _e111 = local_26;
        int _e113 = input[_e111];
        local_27 = _e113;
        int _e115 = local_27;
        local_16 = _e115;
        int _e117 = local_16;
        bool _e118 = same(_e105, _e117);
        uint _e119 = base;
        local_7 = static_cast<uint>(_e119 + 6u);
        uint _e125 = local_7;
        local_28 = static_cast<uint>(_e125);
        uint _e128 = local_28;
        out[_e128] = static_cast<int>(_e118);
        int _e134 = value;
        value = as_type<int>(as_type<uint>(_e134) + as_type<uint>(1));
        consume(naga_mod(i, 2u) == 0u, _e134);
        int _e137 = value;
        uint _e138 = base;
        local_9 = static_cast<uint>(_e138 + 7u);
        uint _e143 = local_9;
        local_29 = static_cast<uint>(_e143);
        uint _e146 = local_29;
        out[_e146] = _e137;
        int _e152 = value;
        value = as_type<int>(as_type<uint>(_e152) + as_type<uint>(1));
        forward(naga_mod(i, 2u) != 0u, _e152);
        int _e155 = value;
        uint _e156 = base;
        local_10 = static_cast<uint>(_e156 + 8u);
        uint _e161 = local_10;
        local_30 = static_cast<uint>(_e161);
        uint _e164 = local_30;
        out[_e164] = _e155;
        int _e166 = value;
        local_12 = static_cast<uint>(i);
        uint _e169 = local_12;
        local_31 = static_cast<uint>(_e169);
        uint _e172 = local_31;
        int _e174 = input[_e172];
        local_32 = _e174;
        int _e176 = local_32;
        local_17 = _e176;
        int _e178 = local_17;
        bool _e179 = same(_e166, _e178);
        uint _e180 = base;
        local_11 = static_cast<uint>(_e180 + 9u);
        uint _e186 = local_11;
        local_33 = static_cast<uint>(_e186);
        uint _e189 = local_33;
        out[_e189] = static_cast<int>(_e179);
        int _e191 = value;
        int _e192 = increment(_e191);
        int _e193 = increment(_e192);
        uint _e194 = base;
        local_13 = static_cast<uint>(_e194 + 10u);
        uint _e199 = local_13;
        local_34 = static_cast<uint>(_e199);
        uint _e202 = local_34;
        out[_e202] = _e193;
        int _e204 = value;
        uint _e205 = base;
        local_14 = static_cast<uint>(_e205 + 11u);
        uint _e210 = local_14;
        local_35 = static_cast<uint>(_e210);
        uint _e213 = local_35;
        out[_e213] = _e204;
    }
}
