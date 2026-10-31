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
, device type_4& out [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int iterations = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 6u;
        value = 2;
        int _e16 = value;
        value = as_type<int>(as_type<uint>(_e16) + as_type<uint>(1));
        consume(false, _e16, 1u, 1.5);
        int _e22 = value;
        uint _e23 = base;
        local = static_cast<uint>(_e23);
        uint _e26 = local;
        local_6 = static_cast<uint>(_e26);
        uint _e29 = local_6;
        out[_e29] = _e22;
        int _e32 = value;
        value = as_type<int>(as_type<uint>(_e32) + as_type<uint>(1));
        int _e35 = next_value(_e32);
        consume(true, _e35, 2u, 0.5);
        int _e39 = value;
        uint _e40 = base;
        local_1 = static_cast<uint>(_e40 + 1u);
        uint _e45 = local_1;
        local_7 = static_cast<uint>(_e45);
        uint _e48 = local_7;
        out[_e48] = _e39;
        int _e54 = value;
        value = as_type<int>(as_type<uint>(_e54) + as_type<uint>(1));
        forward(naga_mod(i, 2u) == 0u, _e54);
        int _e57 = value;
        uint _e58 = base;
        local_2 = static_cast<uint>(_e58 + 2u);
        uint _e63 = local_2;
        local_8 = static_cast<uint>(_e63);
        uint _e66 = local_8;
        out[_e66] = _e57;
        iterations = 0;
        {
            int _e70 = value;
            value = as_type<int>(as_type<uint>(_e70) + as_type<uint>(1));
            consume(0 != 0, _e70, static_cast<uint>(0), static_cast<float>(1u));
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e89 = value;
                    value = as_type<int>(as_type<uint>(_e89) + as_type<uint>(1));
                    int _e92 = value;
                    consume(false, _e92, 0u, 1.0);
                }
                loop_init = false;
                int _e80 = iterations;
                if (_e80 < 3) {
                } else {
                    break;
                }
                int _e83 = iterations;
                iterations = as_type<int>(as_type<uint>(_e83) + as_type<uint>(1));
                int _e86 = iterations;
                if (_e86 == 1) {
                    continue;
                }
            }
        }
        int _e96 = value;
        uint _e97 = base;
        local_3 = static_cast<uint>(_e97 + 3u);
        uint _e102 = local_3;
        local_9 = static_cast<uint>(_e102);
        uint _e105 = local_9;
        out[_e105] = _e96;
        int _e107 = iterations;
        uint _e108 = base;
        local_4 = static_cast<uint>(_e108 + 4u);
        uint _e113 = local_4;
        local_10 = static_cast<uint>(_e113);
        uint _e116 = local_10;
        out[_e116] = _e107;
        int _e118 = value;
        int _e119 = next_value(_e118);
        uint _e120 = base;
        local_5 = static_cast<uint>(_e120 + 5u);
        uint _e125 = local_5;
        local_11 = static_cast<uint>(_e125);
        uint _e128 = local_11;
        out[_e128] = _e119;
    }
}
