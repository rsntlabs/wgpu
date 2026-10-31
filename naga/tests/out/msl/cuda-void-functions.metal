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
        local = _e23;
        uint _e25 = local;
        local_6 = _e25;
        uint _e27 = local_6;
        out[_e27] = _e22;
        int _e30 = value;
        value = as_type<int>(as_type<uint>(_e30) + as_type<uint>(1));
        int _e33 = next_value(_e30);
        consume(true, _e33, 2u, 0.5);
        int _e37 = value;
        uint _e38 = base;
        local_1 = static_cast<uint>(_e38 + 1u);
        uint _e43 = local_1;
        local_7 = _e43;
        uint _e45 = local_7;
        out[_e45] = _e37;
        int _e51 = value;
        value = as_type<int>(as_type<uint>(_e51) + as_type<uint>(1));
        forward(naga_mod(i, 2u) == 0u, _e51);
        int _e54 = value;
        uint _e55 = base;
        local_2 = static_cast<uint>(_e55 + 2u);
        uint _e60 = local_2;
        local_8 = _e60;
        uint _e62 = local_8;
        out[_e62] = _e54;
        iterations = 0;
        {
            int _e66 = value;
            value = as_type<int>(as_type<uint>(_e66) + as_type<uint>(1));
            consume(0 != 0, _e66, static_cast<uint>(0), static_cast<float>(1u));
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e85 = value;
                    value = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
                    int _e88 = value;
                    consume(false, _e88, 0u, 1.0);
                }
                loop_init = false;
                int _e76 = iterations;
                if (_e76 < 3) {
                } else {
                    break;
                }
                int _e79 = iterations;
                iterations = as_type<int>(as_type<uint>(_e79) + as_type<uint>(1));
                int _e82 = iterations;
                if (_e82 == 1) {
                    continue;
                }
            }
        }
        int _e92 = value;
        uint _e93 = base;
        local_3 = static_cast<uint>(_e93 + 3u);
        uint _e98 = local_3;
        local_9 = _e98;
        uint _e100 = local_9;
        out[_e100] = _e92;
        int _e102 = iterations;
        uint _e103 = base;
        local_4 = static_cast<uint>(_e103 + 4u);
        uint _e108 = local_4;
        local_10 = _e108;
        uint _e110 = local_10;
        out[_e110] = _e102;
        int _e112 = value;
        int _e113 = next_value(_e112);
        uint _e114 = base;
        local_5 = static_cast<uint>(_e114 + 5u);
        uint _e119 = local_5;
        local_11 = _e119;
        uint _e121 = local_11;
        out[_e121] = _e113;
    }
}
