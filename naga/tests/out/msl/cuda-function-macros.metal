// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct Pair_cuda_record_0_ {
    uint first;
    uint second;
};
typedef uint type_1[1];
struct type_3 {
    uint inner[3];
};

uint advance(
    uint value
) {
    return value + 3u;
}

struct function_macrosInput {
};
kernel void function_macros(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Pair_cuda_record_0_ pair = {};
    Pair_cuda_record_0_ local = {};
    type_3 values = {};
    metal::uint2 vector = {};
    uint counter = {};
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
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint declared = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    local.first = 11u;
    local.second = 13u;
    Pair_cuda_record_0_ _e11 = local;
    pair = _e11;
    values.inner[0] = 2u;
    values.inner[1] = 3u;
    values.inner[2] = 5u;
    vector = metal::uint2(17u, 19u);
    counter = 0u;
    out[start] = 7u;
    local_1 = static_cast<uint>(start + 1u);
    uint _e33 = local_1;
    out[_e33] = 11u;
    local_2 = static_cast<uint>(start + 2u);
    uint _e43 = local_2;
    out[_e43] = 2u + 3u;
    local_3 = static_cast<uint>(start + 3u);
    uint _e54 = local_3;
    out[_e54] = (1u + 2u) * 3u;
    local_4 = static_cast<uint>(start + 4u);
    uint _e63 = local_4;
    out[_e63] = 5u + 6u;
    local_5 = static_cast<uint>(start + 5u);
    uint _e72 = local_5;
    out[_e72] = 7u + 8u;
    uint _e75 = pair.first;
    local_6 = static_cast<uint>(start + 6u);
    uint _e80 = local_6;
    out[_e80] = _e75;
    uint _e83 = pair.second;
    local_7 = static_cast<uint>(start + 7u);
    uint _e88 = local_7;
    out[_e88] = _e83;
    local_8 = static_cast<uint>(start + 8u);
    uint _e96 = local_8;
    out[_e96] = static_cast<uint>(3);
    uint _e99 = values.inner[lane];
    local_9 = static_cast<uint>(start + 9u);
    uint _e104 = local_9;
    out[_e104] = _e99;
    uint _e107 = vector.x;
    local_10 = static_cast<uint>(start + 10u);
    uint _e112 = local_10;
    out[_e112] = _e107;
    uint _e115 = vector.y;
    local_11 = static_cast<uint>(start + 11u);
    uint _e120 = local_11;
    out[_e120] = _e115;
    uint _e122 = counter;
    counter = _e122 + static_cast<uint>(1);
    uint _e126 = counter;
    counter = _e126 + static_cast<uint>(1);
    local_12 = static_cast<uint>(start + 12u);
    uint _e134 = local_12;
    out[_e134] = _e126;
    uint _e136 = counter;
    local_13 = static_cast<uint>(start + 13u);
    uint _e141 = local_13;
    out[_e141] = _e136;
    local_14 = static_cast<uint>(start + 14u);
    uint _e147 = local_14;
    out[_e147] = 19u;
    uint _e150 = counter;
    local_15 = static_cast<uint>(start + 15u);
    uint _e155 = local_15;
    out[_e155] = _e150;
    values.inner[0] = 23u;
    uint _e160 = values.inner[0];
    local_16 = static_cast<uint>(start + 16u);
    uint _e165 = local_16;
    out[_e165] = _e160;
    uint _e169 = values.inner[0];
    local_17 = static_cast<uint>(start + 17u);
    uint _e174 = local_17;
    out[_e174] = _e169;
    if (lane == 0u) {
        local_19 = 29u;
    } else {
        local_19 = 31u;
    }
    uint _e183 = local_19;
    local_18 = static_cast<uint>(start + 18u);
    uint _e188 = local_18;
    out[_e188] = _e183;
    uint _e190 = advance(lane);
    local_20 = static_cast<uint>(start + 19u);
    uint _e195 = local_20;
    out[_e195] = _e190;
    declared = 37u;
    uint _e199 = declared;
    local_21 = static_cast<uint>(start + 20u);
    uint _e204 = local_21;
    out[_e204] = _e199;
    local_22 = static_cast<uint>(start + 21u);
    uint _e213 = local_22;
    out[_e213] = as_type<uint>(-(0.0));
    local_23 = static_cast<uint>(start + 22u);
    uint _e219 = local_23;
    out[_e219] = 4294967295u;
    local_24 = static_cast<uint>(start + 23u);
    uint _e228 = local_24;
    out[_e228] = 41u + lane;
}
