// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_3[1];
typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};
struct type_6 {
    uint inner[64];
};

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int transform(
    float value,
    float multiplier,
    int offset
) {
    return naga_f2i32((value * multiplier) + static_cast<float>(offset));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct scalar_aliasesInput {
};
kernel void scalar_aliases(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_3& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, threadgroup type_6& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint base = {};
    uint lane = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int signed_count = {};
    uint local_3 = {};
    float fraction = {};
    uint local_4 = {};
    int after_block = {};
    uint local_5 = {};
    float coefficient = {};
    uint local_6 = {};
    bool selected = {};
    uint local_7 = {};
    int total = {};
    int current = {};
    uint local_8 = {};
    float after_loop = {};
    uint local_9 = {};
    uint local_10 = {};
    int local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 10u;
        lane = threadIdx.x;
        uint _e18 = lane;
        shared_values.inner[_e18] = i + 10u;
        uint _e21 = lane;
        uint _e23 = shared_values.inner[_e21];
        uint _e24 = base;
        local = static_cast<uint>(_e24);
        uint _e27 = local;
        local_12 = static_cast<uint>(_e27);
        uint _e30 = local_12;
        out[_e30] = _e23;
        local_2 = static_cast<uint>(i);
        uint _e35 = local_2;
        local_13 = static_cast<uint>(_e35);
        uint _e38 = local_13;
        int _e41 = input[_e38];
        local_14 = _e41;
        int _e43 = local_14;
        local_11 = _e43;
        int _e45 = local_11;
        int _e49 = transform(static_cast<float>(_e45), 2.0, 1);
        uint _e51 = base;
        local_1 = static_cast<uint>(_e51 + 1u);
        uint _e56 = local_1;
        local_15 = static_cast<uint>(_e56);
        uint _e59 = local_15;
        out[_e59] = static_cast<uint>(_e49);
        signed_count = naga_neg(3);
        int _e64 = signed_count;
        uint _e66 = base;
        local_3 = static_cast<uint>(_e66 + 2u);
        uint _e71 = local_3;
        local_16 = static_cast<uint>(_e71);
        uint _e74 = local_16;
        out[_e74] = static_cast<uint>(_e64);
        {
            fraction = 3.75;
            float _e78 = fraction;
            uint _e80 = base;
            local_4 = static_cast<uint>(_e80 + 3u);
            uint _e85 = local_4;
            local_17 = static_cast<uint>(_e85);
            uint _e88 = local_17;
            out[_e88] = naga_f2u32(_e78);
        }
        after_block = naga_neg(5);
        int _e93 = after_block;
        uint _e95 = base;
        local_5 = static_cast<uint>(_e95 + 4u);
        uint _e100 = local_5;
        local_18 = static_cast<uint>(_e100);
        uint _e103 = local_18;
        out[_e103] = static_cast<uint>(_e93);
        coefficient = 1.25;
        float _e107 = coefficient;
        uint _e111 = base;
        local_6 = static_cast<uint>(_e111 + 5u);
        uint _e116 = local_6;
        local_19 = static_cast<uint>(_e116);
        uint _e119 = local_19;
        out[_e119] = naga_f2u32(_e107 * 4.0);
        selected = naga_mod(i, 2u) == 0u;
        bool _e126 = selected;
        uint _e128 = base;
        local_7 = static_cast<uint>(_e128 + 6u);
        uint _e133 = local_7;
        local_20 = static_cast<uint>(_e133);
        uint _e136 = local_20;
        out[_e136] = static_cast<uint>(_e126);
        total = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e140 = total;
                if (_e140 < 3) {
                } else {
                    break;
                }
                int _e143 = total;
                current = _e143;
                int _e145 = current;
                total = as_type<int>(as_type<uint>(_e145) + as_type<uint>(1));
            }
        }
        int _e148 = total;
        uint _e150 = base;
        local_8 = static_cast<uint>(_e150 + 7u);
        uint _e155 = local_8;
        local_21 = static_cast<uint>(_e155);
        uint _e158 = local_21;
        out[_e158] = static_cast<uint>(_e148);
        after_loop = 1.5;
        float _e162 = after_loop;
        uint _e166 = base;
        local_9 = static_cast<uint>(_e166 + 8u);
        uint _e171 = local_9;
        local_22 = static_cast<uint>(_e171);
        uint _e174 = local_22;
        out[_e174] = naga_f2u32(_e162 * 2.0);
        uint _e178 = base;
        local_10 = static_cast<uint>(_e178 + 9u);
        uint _e183 = local_10;
        local_23 = static_cast<uint>(_e183);
        uint _e186 = local_23;
        out[_e186] = naga_f2u32(static_cast<float>(n_1));
    }
}
