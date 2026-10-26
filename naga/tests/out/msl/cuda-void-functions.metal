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
    uint local = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    int iterations = {};
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
    local = 0u;
    uint _e6 = n_1.value;
    n = _e6;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e14 = i;
    uint _e15 = n;
    if (_e14 < _e15) {
        uint _e17 = i;
        base = _e17 * 6u;
        value = 2;
        int _e23 = value;
        value = as_type<int>(as_type<uint>(_e23) + as_type<uint>(1));
        consume(false, _e23, 1u, 1.5);
        int _e29 = value;
        uint _e30 = local;
        local_1 = _e30;
        uint _e32 = local_1;
        local_2 = static_cast<uint>(_e32);
        uint _e35 = base;
        local_3 = static_cast<uint>(_e35);
        uint _e39 = local_2;
        uint _e40 = local_3;
        local_19 = static_cast<uint>(_e39 + _e40);
        uint _e44 = local_19;
        out[_e44] = _e29;
        int _e46 = value;
        value = as_type<int>(as_type<uint>(_e46) + as_type<uint>(1));
        int _e49 = next_value(_e46);
        consume(true, _e49, 2u, 0.5);
        int _e53 = value;
        uint _e54 = local;
        local_4 = _e54;
        uint _e56 = local_4;
        local_5 = static_cast<uint>(_e56);
        uint _e59 = base;
        local_6 = static_cast<uint>(_e59 + 1u);
        uint _e64 = local_5;
        uint _e65 = local_6;
        local_20 = static_cast<uint>(_e64 + _e65);
        uint _e69 = local_20;
        out[_e69] = _e53;
        uint _e71 = i;
        int _e76 = value;
        value = as_type<int>(as_type<uint>(_e76) + as_type<uint>(1));
        forward(naga_mod(_e71, 2u) == 0u, _e76);
        int _e79 = value;
        uint _e80 = local;
        local_7 = _e80;
        uint _e82 = local_7;
        local_8 = static_cast<uint>(_e82);
        uint _e85 = base;
        local_9 = static_cast<uint>(_e85 + 2u);
        uint _e90 = local_8;
        uint _e91 = local_9;
        local_21 = static_cast<uint>(_e90 + _e91);
        uint _e95 = local_21;
        out[_e95] = _e79;
        iterations = 0;
        {
            int _e99 = value;
            value = as_type<int>(as_type<uint>(_e99) + as_type<uint>(1));
            consume(0 != 0, _e99, static_cast<uint>(0), static_cast<float>(1u));
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e118 = value;
                    value = as_type<int>(as_type<uint>(_e118) + as_type<uint>(1));
                    int _e121 = value;
                    consume(false, _e121, 0u, 1.0);
                }
                loop_init = false;
                int _e109 = iterations;
                if (_e109 < 3) {
                } else {
                    break;
                }
                int _e112 = iterations;
                iterations = as_type<int>(as_type<uint>(_e112) + as_type<uint>(1));
                int _e115 = iterations;
                if (_e115 == 1) {
                    continue;
                }
            }
        }
        int _e125 = value;
        uint _e126 = local;
        local_10 = _e126;
        uint _e128 = local_10;
        local_11 = static_cast<uint>(_e128);
        uint _e131 = base;
        local_12 = static_cast<uint>(_e131 + 3u);
        uint _e136 = local_11;
        uint _e137 = local_12;
        local_22 = static_cast<uint>(_e136 + _e137);
        uint _e141 = local_22;
        out[_e141] = _e125;
        int _e143 = iterations;
        uint _e144 = local;
        local_13 = _e144;
        uint _e146 = local_13;
        local_14 = static_cast<uint>(_e146);
        uint _e149 = base;
        local_15 = static_cast<uint>(_e149 + 4u);
        uint _e154 = local_14;
        uint _e155 = local_15;
        local_23 = static_cast<uint>(_e154 + _e155);
        uint _e159 = local_23;
        out[_e159] = _e143;
        int _e161 = value;
        int _e162 = next_value(_e161);
        uint _e163 = local;
        local_16 = _e163;
        uint _e165 = local_16;
        local_17 = static_cast<uint>(_e165);
        uint _e168 = base;
        local_18 = static_cast<uint>(_e168 + 5u);
        uint _e173 = local_17;
        uint _e174 = local_18;
        local_24 = static_cast<uint>(_e173 + _e174);
        uint _e178 = local_24;
        out[_e178] = _e162;
    }
}
