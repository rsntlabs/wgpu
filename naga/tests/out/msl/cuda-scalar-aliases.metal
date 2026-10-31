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
        local = _e24;
        uint _e26 = local;
        local_12 = _e26;
        uint _e28 = local_12;
        out[_e28] = _e23;
        local_2 = i;
        uint _e32 = local_2;
        local_13 = _e32;
        uint _e34 = local_13;
        int _e37 = input[_e34];
        local_14 = _e37;
        int _e39 = local_14;
        local_11 = _e39;
        int _e41 = local_11;
        int _e45 = transform(static_cast<float>(_e41), 2.0, 1);
        uint _e47 = base;
        local_1 = static_cast<uint>(_e47 + 1u);
        uint _e52 = local_1;
        local_15 = _e52;
        uint _e54 = local_15;
        out[_e54] = static_cast<uint>(_e45);
        signed_count = naga_neg(3);
        int _e59 = signed_count;
        uint _e61 = base;
        local_3 = static_cast<uint>(_e61 + 2u);
        uint _e66 = local_3;
        local_16 = _e66;
        uint _e68 = local_16;
        out[_e68] = static_cast<uint>(_e59);
        {
            fraction = 3.75;
            float _e72 = fraction;
            uint _e74 = base;
            local_4 = static_cast<uint>(_e74 + 3u);
            uint _e79 = local_4;
            local_17 = _e79;
            uint _e81 = local_17;
            out[_e81] = naga_f2u32(_e72);
        }
        after_block = naga_neg(5);
        int _e86 = after_block;
        uint _e88 = base;
        local_5 = static_cast<uint>(_e88 + 4u);
        uint _e93 = local_5;
        local_18 = _e93;
        uint _e95 = local_18;
        out[_e95] = static_cast<uint>(_e86);
        coefficient = 1.25;
        float _e99 = coefficient;
        uint _e103 = base;
        local_6 = static_cast<uint>(_e103 + 5u);
        uint _e108 = local_6;
        local_19 = _e108;
        uint _e110 = local_19;
        out[_e110] = naga_f2u32(_e99 * 4.0);
        selected = naga_mod(i, 2u) == 0u;
        bool _e117 = selected;
        uint _e119 = base;
        local_7 = static_cast<uint>(_e119 + 6u);
        uint _e124 = local_7;
        local_20 = _e124;
        uint _e126 = local_20;
        out[_e126] = static_cast<uint>(_e117);
        total = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e130 = total;
                if (_e130 < 3) {
                } else {
                    break;
                }
                int _e133 = total;
                current = _e133;
                int _e135 = current;
                total = as_type<int>(as_type<uint>(_e135) + as_type<uint>(1));
            }
        }
        int _e138 = total;
        uint _e140 = base;
        local_8 = static_cast<uint>(_e140 + 7u);
        uint _e145 = local_8;
        local_21 = _e145;
        uint _e147 = local_21;
        out[_e147] = static_cast<uint>(_e138);
        after_loop = 1.5;
        float _e151 = after_loop;
        uint _e155 = base;
        local_9 = static_cast<uint>(_e155 + 8u);
        uint _e160 = local_9;
        local_22 = _e160;
        uint _e162 = local_22;
        out[_e162] = naga_f2u32(_e151 * 2.0);
        uint _e166 = base;
        local_10 = static_cast<uint>(_e166 + 9u);
        uint _e171 = local_10;
        local_23 = _e171;
        uint _e173 = local_23;
        out[_e173] = naga_f2u32(static_cast<float>(n_1));
    }
}
