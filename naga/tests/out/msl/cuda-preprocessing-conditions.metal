// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];

uint later(
    uint value
) {
    return value + 73u;
}

struct preprocessing_conditionsInput {
};
kernel void preprocessing_conditions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
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
    uint local_15 = {};
    uint local_16 = {};
    uint counter = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    out[start] = 7u;
    local = static_cast<uint>(start + 1u);
    uint _e13 = local;
    out[_e13] = 11u;
    local_1 = static_cast<uint>(start + 2u);
    uint _e20 = local_1;
    out[_e20] = 13u;
    local_2 = static_cast<uint>(start + 3u);
    uint _e27 = local_2;
    out[_e27] = 17u;
    local_3 = static_cast<uint>(start + 4u);
    uint _e34 = local_3;
    out[_e34] = 19u;
    local_4 = static_cast<uint>(start + 5u);
    uint _e41 = local_4;
    out[_e41] = 23u;
    local_5 = static_cast<uint>(start + 6u);
    uint _e48 = local_5;
    out[_e48] = 29u;
    local_6 = static_cast<uint>(start + 7u);
    uint _e55 = local_6;
    out[_e55] = 31u;
    local_7 = static_cast<uint>(start + 8u);
    uint _e62 = local_7;
    out[_e62] = 37u;
    local_8 = static_cast<uint>(start + 9u);
    uint _e69 = local_8;
    out[_e69] = 41u;
    local_9 = static_cast<uint>(start + 10u);
    uint _e76 = local_9;
    out[_e76] = 43u;
    local_10 = static_cast<uint>(start + 11u);
    uint _e83 = local_10;
    out[_e83] = 47u;
    local_11 = static_cast<uint>(start + 12u);
    uint _e90 = local_11;
    out[_e90] = 53u;
    local_12 = static_cast<uint>(start + 13u);
    uint _e97 = local_12;
    out[_e97] = 59u;
    local_13 = static_cast<uint>(start + 14u);
    uint _e104 = local_13;
    out[_e104] = 61u;
    local_14 = static_cast<uint>(start + 15u);
    uint _e111 = local_14;
    out[_e111] = 67u;
    local_15 = static_cast<uint>(start + 16u);
    uint _e118 = local_15;
    out[_e118] = 71u;
    uint _e121 = later(lane);
    local_16 = static_cast<uint>(start + 17u);
    uint _e126 = local_16;
    out[_e126] = _e121;
    counter = 0u;
    uint _e130 = counter;
    counter = _e130 + static_cast<uint>(1);
    local_17 = static_cast<uint>(start + 18u);
    uint _e138 = local_17;
    out[_e138] = _e130;
    uint _e140 = counter;
    local_18 = static_cast<uint>(start + 19u);
    uint _e145 = local_18;
    out[_e145] = _e140;
    local_19 = static_cast<uint>(start + 20u);
    uint _e153 = local_19;
    out[_e153] = static_cast<uint>(true);
    local_20 = static_cast<uint>(start + 21u);
    uint _e159 = local_20;
    out[_e159] = lane;
    local_21 = static_cast<uint>(start + 22u);
    uint _e168 = local_21;
    out[_e168] = as_type<uint>(-(0.0));
    local_22 = static_cast<uint>(start + 23u);
    uint _e174 = local_22;
    out[_e174] = 4294967295u;
}
