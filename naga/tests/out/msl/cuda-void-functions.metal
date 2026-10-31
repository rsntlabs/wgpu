// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};
struct type_7 {
    uint inner[2];
};

int next_value(
    int value_1
) {
    return as_type<int>(as_type<uint>(value_1) + as_type<uint>(1));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

void consume(
    bool stop,
    int value_2,
    uint count,
    float scale
) {
    int value_3 = {};
    value_3 = value_2;
    int _e5 = value_3;
    value_3 = static_cast<int>(static_cast<uint>(_e5) + count);
    if (stop) {
        return;
    }
    int _e9 = value_3;
    value_3 = naga_f2i32(static_cast<float>(_e9) * scale);
    return;
}

void forward(
    bool stop_1,
    int value_4
) {
    int _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5);
    return;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct void_functionsInput {
};
kernel void void_functions(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out_1 [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    uint base = {};
    int value = {};
    type_7 local = {};
    uint local_1 = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    int iterations = {};
    type_7 local_6 = {};
    uint local_7 = {};
    type_7 local_8 = {};
    uint local_9 = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    type_7 local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    type_7 local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    type_7 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_7 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_7 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 6u;
        value = 2;
        int _e22 = value;
        value = as_type<int>(as_type<uint>(_e22) + as_type<uint>(1));
        consume(false, _e22, 1u, 1.5);
        int _e28 = value;
        type_7 _e30 = out;
        local = _e30;
        uint _e32 = base;
        local_1 = static_cast<uint>(_e32);
        type_7 _e35 = local;
        local_12 = _e35;
        uint _e37 = local_1;
        uint _e39 = local_12.inner[1];
        local_12.inner[1] = _e39 + _e37;
        uint _e43 = local_12.inner[0];
        local_13 = static_cast<uint>(_e43);
        uint _e47 = local_12.inner[1];
        local_14 = static_cast<uint>(_e47);
        uint _e50 = local_14;
        out_1[_e50] = _e28;
        int _e53 = value;
        value = as_type<int>(as_type<uint>(_e53) + as_type<uint>(1));
        int _e56 = next_value(_e53);
        consume(true, _e56, 2u, 0.5);
        int _e60 = value;
        type_7 _e61 = out;
        local_2 = _e61;
        uint _e63 = base;
        local_3 = static_cast<uint>(_e63 + 1u);
        type_7 _e68 = local_2;
        local_15 = _e68;
        uint _e70 = local_3;
        uint _e72 = local_15.inner[1];
        local_15.inner[1] = _e72 + _e70;
        uint _e76 = local_15.inner[0];
        local_16 = static_cast<uint>(_e76);
        uint _e80 = local_15.inner[1];
        local_17 = static_cast<uint>(_e80);
        uint _e83 = local_17;
        out_1[_e83] = _e60;
        int _e89 = value;
        value = as_type<int>(as_type<uint>(_e89) + as_type<uint>(1));
        forward(naga_mod(i, 2u) == 0u, _e89);
        int _e92 = value;
        type_7 _e93 = out;
        local_4 = _e93;
        uint _e95 = base;
        local_5 = static_cast<uint>(_e95 + 2u);
        type_7 _e100 = local_4;
        local_18 = _e100;
        uint _e102 = local_5;
        uint _e104 = local_18.inner[1];
        local_18.inner[1] = _e104 + _e102;
        uint _e108 = local_18.inner[0];
        local_19 = static_cast<uint>(_e108);
        uint _e112 = local_18.inner[1];
        local_20 = static_cast<uint>(_e112);
        uint _e115 = local_20;
        out_1[_e115] = _e92;
        iterations = 0;
        {
            int _e119 = value;
            value = as_type<int>(as_type<uint>(_e119) + as_type<uint>(1));
            consume(0 != 0, _e119, static_cast<uint>(0), static_cast<float>(1u));
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e138 = value;
                    value = as_type<int>(as_type<uint>(_e138) + as_type<uint>(1));
                    int _e141 = value;
                    consume(false, _e141, 0u, 1.0);
                }
                loop_init = false;
                int _e129 = iterations;
                if (_e129 < 3) {
                } else {
                    break;
                }
                int _e132 = iterations;
                iterations = as_type<int>(as_type<uint>(_e132) + as_type<uint>(1));
                int _e135 = iterations;
                if (_e135 == 1) {
                    continue;
                }
            }
        }
        int _e145 = value;
        type_7 _e146 = out;
        local_6 = _e146;
        uint _e148 = base;
        local_7 = static_cast<uint>(_e148 + 3u);
        type_7 _e153 = local_6;
        local_21 = _e153;
        uint _e155 = local_7;
        uint _e157 = local_21.inner[1];
        local_21.inner[1] = _e157 + _e155;
        uint _e161 = local_21.inner[0];
        local_22 = static_cast<uint>(_e161);
        uint _e165 = local_21.inner[1];
        local_23 = static_cast<uint>(_e165);
        uint _e168 = local_23;
        out_1[_e168] = _e145;
        int _e170 = iterations;
        type_7 _e171 = out;
        local_8 = _e171;
        uint _e173 = base;
        local_9 = static_cast<uint>(_e173 + 4u);
        type_7 _e178 = local_8;
        local_24 = _e178;
        uint _e180 = local_9;
        uint _e182 = local_24.inner[1];
        local_24.inner[1] = _e182 + _e180;
        uint _e186 = local_24.inner[0];
        local_25 = static_cast<uint>(_e186);
        uint _e190 = local_24.inner[1];
        local_26 = static_cast<uint>(_e190);
        uint _e193 = local_26;
        out_1[_e193] = _e170;
        int _e195 = value;
        int _e196 = next_value(_e195);
        type_7 _e197 = out;
        local_10 = _e197;
        uint _e199 = base;
        local_11 = static_cast<uint>(_e199 + 5u);
        type_7 _e204 = local_10;
        local_27 = _e204;
        uint _e206 = local_11;
        uint _e208 = local_27.inner[1];
        local_27.inner[1] = _e208 + _e206;
        uint _e212 = local_27.inner[0];
        local_28 = static_cast<uint>(_e212);
        uint _e216 = local_27.inner[1];
        local_29 = static_cast<uint>(_e216);
        uint _e219 = local_29;
        out_1[_e219] = _e196;
    }
}
