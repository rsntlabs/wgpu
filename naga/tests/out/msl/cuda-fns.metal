// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_2[1];
struct type_4 {
    uint inner[4];
};

uint _naga_fns(
    uint mask,
    uint base,
    int offset
) {
    int position = {};
    int remaining = {};
    if (base > 31u) {
        return 4294967295u;
    }
    uint _e8 = base & 31u;
    if (offset == 0) {
        return (((mask >> _e8) & 1u) != 0u) ? base : 4294967295u;
    }
    int _e18 = (offset > 0) ? 1 : -1;
    position = static_cast<int>(_e8);
    remaining = offset;
    uint2 loop_bound = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        int _e23 = position;
        if ((_e23 < 0) || (_e23 > 31)) {
            break;
        }
        uint _e27 = static_cast<uint>(_e23);
        if (((mask >> (_e27 & 31u)) & 1u) != 0u) {
            int _e32 = remaining;
            if (_e32 == _e18) {
                return _e27;
            }
            remaining = as_type<int>(as_type<uint>(_e32) - as_type<uint>(_e18));
        }
        position = as_type<int>(as_type<uint>(_e23) + as_type<uint>(_e18));
    }
    return 4294967295u;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct fnsInput {
};
kernel void fns(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, device type_2 const& input [[buffer(1)]]
, threadgroup type_4& shared_values
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint row = {};
    uint at = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint value = {};
    uint local_4 = {};
    uint local_5 = {};
    int local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    bool local_10 = {};
    bool local_11 = {};
    uint local_12 = {};
    uint index = {};
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
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint lane = threadIdx.x;
    uint count = input[static_cast<uint>(0)];
    shared_values.inner[lane] = lane + 1u;
    uint _e14 = _naga_fns(1u, 0u, 1);
    if (_e14 == 0u) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    }
    {
        row = lane;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init) {
                uint _e77 = row;
                row = _e77 + 4u;
            }
            loop_init = false;
            uint _e18 = row;
            if (_e18 < count) {
            } else {
                break;
            }
            uint _e20 = row;
            at = 1u + (_e20 * 3u);
            uint _e26 = at;
            local_1 = _e26;
            uint _e28 = local_1;
            local_23 = _e28;
            uint _e30 = local_23;
            uint _e32 = input[_e30];
            local_24 = _e32;
            uint _e34 = local_24;
            local_20 = _e34;
            uint _e36 = local_20;
            uint _e37 = at;
            local_2 = static_cast<uint>(_e37 + 1u);
            uint _e42 = local_2;
            local_25 = _e42;
            uint _e44 = local_25;
            uint _e46 = input[_e44];
            local_26 = _e46;
            uint _e48 = local_26;
            local_21 = _e48;
            uint _e50 = local_21;
            uint _e51 = at;
            local_3 = static_cast<uint>(_e51 + 2u);
            uint _e56 = local_3;
            local_27 = _e56;
            uint _e58 = local_27;
            uint _e60 = input[_e58];
            local_28 = _e60;
            uint _e62 = local_28;
            local_22 = _e62;
            uint _e64 = local_22;
            uint _e66 = _naga_fns(_e36, _e50, static_cast<int>(_e64));
            uint _e67 = row;
            local = static_cast<uint>(4u + _e67);
            uint _e72 = local;
            local_29 = _e72;
            uint _e74 = local_29;
            output[_e74] = _e66;
        }
    }
    uint base_1 = (4u + count) + (lane * 11u);
    value = 1u;
    uint _e87 = value;
    value = _e87 + static_cast<uint>(1);
    local_4 = (_e87 * 16909060u) ^ 2164195711u;
    uint _e96 = local_4;
    uint _e97 = value;
    value = _e97 + static_cast<uint>(1);
    local_5 = (_e97 * 5u) & 31u;
    uint _e106 = local_5;
    uint _e107 = value;
    value = _e107 + static_cast<uint>(1);
    local_6 = as_type<int>(as_type<uint>(2) - as_type<uint>(static_cast<int>(_e107)));
    int _e115 = local_6;
    uint _e116 = _naga_fns(_e96, _e106, _e115);
    output[base_1] = _e116;
    uint _e119 = value;
    local_7 = static_cast<uint>(base_1 + 1u);
    uint _e124 = local_7;
    output[_e124] = _e119;
    if ((lane & 1u) == 0u) {
        uint _e130 = value;
        value = _e130 + static_cast<uint>(1);
        uint _e136 = _naga_fns(_e130, 0u, 1);
        local_8 = _e136;
    } else {
        local_8 = 0u;
    }
    uint _e140 = value;
    local_9 = static_cast<uint>(base_1 + 2u);
    uint _e145 = local_9;
    output[_e145] = _e140;
    local_10 = false;
    if (false) {
        uint _e149 = value;
        value = _e149 + static_cast<uint>(1);
        uint _e155 = _naga_fns(_e149, 0u, 1);
        local_10 = _e155 != 0u;
    }
    local_11 = true;
    if (true) {
    } else {
        uint _e160 = value;
        value = _e160 + static_cast<uint>(1);
        uint _e166 = _naga_fns(_e160, 0u, 1);
        local_11 = _e166 != 0u;
    }
    uint _e169 = value;
    value = _e169 + static_cast<uint>(1);
    uint _e175 = _naga_fns(_e169, 0u, 1);
    uint _e176 = value;
    local_12 = static_cast<uint>(base_1 + 3u);
    uint _e181 = local_12;
    output[_e181] = _e176;
    index = 1u;
    uint _e185 = index;
    index = _e185 + static_cast<uint>(1);
    uint _e190 = input[_e185];
    uint _e191 = index;
    index = _e191 + static_cast<uint>(1);
    uint _e196 = input[_e191];
    uint _e197 = index;
    index = _e197 + static_cast<uint>(1);
    uint _e202 = input[_e197];
    uint _e204 = _naga_fns(_e190, _e196, static_cast<int>(_e202));
    local_13 = static_cast<uint>(base_1 + 4u);
    uint _e209 = local_13;
    output[_e209] = _e204;
    uint _e211 = index;
    local_14 = static_cast<uint>(base_1 + 5u);
    uint _e216 = local_14;
    output[_e216] = _e211;
    uint _e221 = _naga_fns(2863311530u, 2u, 0);
    local_15 = static_cast<uint>(base_1 + 6u);
    uint _e226 = local_15;
    output[_e226] = _e221;
    uint _e231 = _naga_fns(2863311530u, 2u, 1);
    local_16 = static_cast<uint>(base_1 + 7u);
    uint _e236 = local_16;
    output[_e236] = _e231;
    uint _e242 = _naga_fns(2863311530u, 2u, naga_neg(1));
    local_17 = static_cast<uint>(base_1 + 8u);
    uint _e247 = local_17;
    output[_e247] = _e242;
    uint _e255 = _naga_fns(4294967295u, 31u, as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    local_18 = static_cast<uint>(base_1 + 9u);
    uint _e260 = local_18;
    output[_e260] = _e255;
    uint _e267 = shared_values.inner[(lane + 1u) & 3u];
    local_19 = static_cast<uint>(base_1 + 10u);
    uint _e272 = local_19;
    output[_e272] = _e267;
}
