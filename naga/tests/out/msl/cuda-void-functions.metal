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
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

void consume(
    bool stop,
    int value_3,
    uint count,
    float scale
) {
    bool stop_1 = {};
    int value_4 = {};
    uint count_1 = {};
    float scale_1 = {};
    stop_1 = stop;
    value_4 = value_3;
    count_1 = count;
    scale_1 = scale;
    uint _e8 = count_1;
    int _e9 = value_4;
    value_4 = static_cast<int>(static_cast<uint>(_e9) + _e8);
    bool _e13 = stop_1;
    if (_e13) {
        return;
    }
    float _e14 = scale_1;
    int _e15 = value_4;
    value_4 = naga_f2i32(static_cast<float>(_e15) * _e14);
    return;
}

void forward(
    bool stop_2,
    int value_5
) {
    bool stop_3 = {};
    int value_6 = {};
    stop_3 = stop_2;
    value_6 = value_5;
    bool _e4 = stop_3;
    int _e5 = value_6;
    int _e6 = next_value(_e5);
    consume(_e4, _e6, 2u, 0.5);
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
, device type_4& out [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 local = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    type_7 local_1 = {};
    uint local_2 = {};
    type_7 local_3 = {};
    uint local_4 = {};
    type_7 local_5 = {};
    uint local_6 = {};
    int iterations = {};
    type_7 local_7 = {};
    uint local_8 = {};
    type_7 local_9 = {};
    uint local_10 = {};
    type_7 local_11 = {};
    uint local_12 = {};
    type_7 local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    type_7 local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    type_7 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_7 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    type_7 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    local = type_7 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    uint _e11 = n_1.value;
    n = _e11;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e19 = i;
    uint _e20 = n;
    if (_e19 < _e20) {
        uint _e22 = i;
        base = _e22 * 6u;
        value = 2;
        int _e28 = value;
        value = as_type<int>(as_type<uint>(_e28) + as_type<uint>(1));
        consume(false, _e28, 1u, 1.5);
        int _e34 = value;
        type_7 _e37 = local;
        local_1 = _e37;
        uint _e38 = base;
        local_2 = static_cast<uint>(_e38);
        type_7 _e42 = local_1;
        local_13 = _e42;
        uint _e43 = local_2;
        uint _e45 = local_13.inner[1];
        local_13.inner[1] = _e45 + _e43;
        uint _e49 = local_13.inner[0];
        local_14 = static_cast<uint>(_e49);
        uint _e53 = local_13.inner[1];
        local_15 = static_cast<uint>(_e53);
        uint _e56 = local_15;
        out[_e56] = _e34;
        int _e58 = value;
        value = as_type<int>(as_type<uint>(_e58) + as_type<uint>(1));
        int _e61 = next_value(_e58);
        consume(true, _e61, 2u, 0.5);
        int _e65 = value;
        type_7 _e67 = local;
        local_3 = _e67;
        uint _e68 = base;
        local_4 = static_cast<uint>(_e68 + 1u);
        type_7 _e74 = local_3;
        local_16 = _e74;
        uint _e75 = local_4;
        uint _e77 = local_16.inner[1];
        local_16.inner[1] = _e77 + _e75;
        uint _e81 = local_16.inner[0];
        local_17 = static_cast<uint>(_e81);
        uint _e85 = local_16.inner[1];
        local_18 = static_cast<uint>(_e85);
        uint _e88 = local_18;
        out[_e88] = _e65;
        uint _e90 = i;
        int _e95 = value;
        value = as_type<int>(as_type<uint>(_e95) + as_type<uint>(1));
        forward(naga_mod(_e90, 2u) == 0u, _e95);
        int _e98 = value;
        type_7 _e100 = local;
        local_5 = _e100;
        uint _e101 = base;
        local_6 = static_cast<uint>(_e101 + 2u);
        type_7 _e107 = local_5;
        local_19 = _e107;
        uint _e108 = local_6;
        uint _e110 = local_19.inner[1];
        local_19.inner[1] = _e110 + _e108;
        uint _e114 = local_19.inner[0];
        local_20 = static_cast<uint>(_e114);
        uint _e118 = local_19.inner[1];
        local_21 = static_cast<uint>(_e118);
        uint _e121 = local_21;
        out[_e121] = _e98;
        iterations = 0;
        {
            int _e125 = value;
            value = as_type<int>(as_type<uint>(_e125) + as_type<uint>(1));
            consume(0 != 0, _e125, static_cast<uint>(0), static_cast<float>(1u));
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e144 = value;
                    value = as_type<int>(as_type<uint>(_e144) + as_type<uint>(1));
                    int _e147 = value;
                    consume(false, _e147, 0u, 1.0);
                }
                loop_init = false;
                int _e135 = iterations;
                if (_e135 < 3) {
                } else {
                    break;
                }
                int _e138 = iterations;
                iterations = as_type<int>(as_type<uint>(_e138) + as_type<uint>(1));
                int _e141 = iterations;
                if (_e141 == 1) {
                    continue;
                }
            }
        }
        int _e151 = value;
        type_7 _e153 = local;
        local_7 = _e153;
        uint _e154 = base;
        local_8 = static_cast<uint>(_e154 + 3u);
        type_7 _e160 = local_7;
        local_22 = _e160;
        uint _e161 = local_8;
        uint _e163 = local_22.inner[1];
        local_22.inner[1] = _e163 + _e161;
        uint _e167 = local_22.inner[0];
        local_23 = static_cast<uint>(_e167);
        uint _e171 = local_22.inner[1];
        local_24 = static_cast<uint>(_e171);
        uint _e174 = local_24;
        out[_e174] = _e151;
        int _e176 = iterations;
        type_7 _e178 = local;
        local_9 = _e178;
        uint _e179 = base;
        local_10 = static_cast<uint>(_e179 + 4u);
        type_7 _e185 = local_9;
        local_25 = _e185;
        uint _e186 = local_10;
        uint _e188 = local_25.inner[1];
        local_25.inner[1] = _e188 + _e186;
        uint _e192 = local_25.inner[0];
        local_26 = static_cast<uint>(_e192);
        uint _e196 = local_25.inner[1];
        local_27 = static_cast<uint>(_e196);
        uint _e199 = local_27;
        out[_e199] = _e176;
        int _e201 = value;
        int _e202 = next_value(_e201);
        type_7 _e204 = local;
        local_11 = _e204;
        uint _e205 = base;
        local_12 = static_cast<uint>(_e205 + 5u);
        type_7 _e211 = local_11;
        local_28 = _e211;
        uint _e212 = local_12;
        uint _e214 = local_28.inner[1];
        local_28.inner[1] = _e214 + _e212;
        uint _e218 = local_28.inner[0];
        local_29 = static_cast<uint>(_e218);
        uint _e222 = local_28.inner[1];
        local_30 = static_cast<uint>(_e222);
        uint _e225 = local_30;
        out[_e225] = _e202;
    }
}
