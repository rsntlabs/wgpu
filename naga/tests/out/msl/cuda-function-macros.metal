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
    type_3 values = {};
    metal::uint2 vector = {};
    uint counter = {};
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
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint declared = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    pair.first = 11u;
    pair.second = 13u;
    values.inner[0] = 2u;
    values.inner[1] = 3u;
    values.inner[2] = 5u;
    vector = metal::uint2(17u, 19u);
    counter = 0u;
    out[start] = 7u;
    local = static_cast<uint>(start + 1u);
    uint _e31 = local;
    out[_e31] = 11u;
    local_1 = static_cast<uint>(start + 2u);
    uint _e41 = local_1;
    out[_e41] = 2u + 3u;
    local_2 = static_cast<uint>(start + 3u);
    uint _e52 = local_2;
    out[_e52] = (1u + 2u) * 3u;
    local_3 = static_cast<uint>(start + 4u);
    uint _e61 = local_3;
    out[_e61] = 5u + 6u;
    local_4 = static_cast<uint>(start + 5u);
    uint _e70 = local_4;
    out[_e70] = 7u + 8u;
    uint _e73 = pair.first;
    local_5 = static_cast<uint>(start + 6u);
    uint _e78 = local_5;
    out[_e78] = _e73;
    uint _e81 = pair.second;
    local_6 = static_cast<uint>(start + 7u);
    uint _e86 = local_6;
    out[_e86] = _e81;
    local_7 = static_cast<uint>(start + 8u);
    uint _e94 = local_7;
    out[_e94] = static_cast<uint>(3);
    uint _e97 = values.inner[lane];
    local_8 = static_cast<uint>(start + 9u);
    uint _e102 = local_8;
    out[_e102] = _e97;
    uint _e105 = vector.x;
    local_9 = static_cast<uint>(start + 10u);
    uint _e110 = local_9;
    out[_e110] = _e105;
    uint _e113 = vector.y;
    local_10 = static_cast<uint>(start + 11u);
    uint _e118 = local_10;
    out[_e118] = _e113;
    uint _e120 = counter;
    counter = _e120 + static_cast<uint>(1);
    uint _e124 = counter;
    counter = _e124 + static_cast<uint>(1);
    local_11 = static_cast<uint>(start + 12u);
    uint _e132 = local_11;
    out[_e132] = _e124;
    uint _e134 = counter;
    local_12 = static_cast<uint>(start + 13u);
    uint _e139 = local_12;
    out[_e139] = _e134;
    local_13 = static_cast<uint>(start + 14u);
    uint _e145 = local_13;
    out[_e145] = 19u;
    uint _e148 = counter;
    local_14 = static_cast<uint>(start + 15u);
    uint _e153 = local_14;
    out[_e153] = _e148;
    values.inner[0] = 23u;
    uint _e158 = values.inner[0];
    local_15 = static_cast<uint>(start + 16u);
    uint _e163 = local_15;
    out[_e163] = _e158;
    uint _e167 = values.inner[0];
    local_16 = static_cast<uint>(start + 17u);
    uint _e172 = local_16;
    out[_e172] = _e167;
    if (lane == 0u) {
        local_18 = 29u;
    } else {
        local_18 = 31u;
    }
    uint _e181 = local_18;
    local_17 = static_cast<uint>(start + 18u);
    uint _e186 = local_17;
    out[_e186] = _e181;
    uint _e188 = advance(lane);
    local_19 = static_cast<uint>(start + 19u);
    uint _e193 = local_19;
    out[_e193] = _e188;
    declared = 37u;
    uint _e197 = declared;
    local_20 = static_cast<uint>(start + 20u);
    uint _e202 = local_20;
    out[_e202] = _e197;
    local_21 = static_cast<uint>(start + 21u);
    uint _e211 = local_21;
    out[_e211] = as_type<uint>(-(0.0));
    local_22 = static_cast<uint>(start + 22u);
    uint _e217 = local_22;
    out[_e217] = 4294967295u;
    local_23 = static_cast<uint>(start + 23u);
    uint _e226 = local_23;
    out[_e226] = 41u + lane;
}
