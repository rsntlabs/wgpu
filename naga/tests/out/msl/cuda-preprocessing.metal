// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct Packet_cuda_record_0_ {
    uint first;
    uint second;
};
typedef uint type_1[1];
struct type_3 {
    uint inner[3];
};

uint later(
    uint value
) {
    return value + 5u;
}

struct preprocessingInput {
};
kernel void preprocessing(
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
    Packet_cuda_record_0_ original = {};
    Packet_cuda_record_0_ copied = {};
    uint local_8 = {};
    uint local_9 = {};
    uint SELF = {};
    uint LEFT = {};
    uint RIGHT = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint counter = {};
    Packet_cuda_record_0_ ordered = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    type_3 values = {};
    uint local_17 = {};
    uint index = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    local = static_cast<uint>(start + 0u);
    uint _e10 = local;
    out[_e10] = 7u;
    local_1 = static_cast<uint>(start + 1u);
    uint _e18 = local_1;
    out[_e18] = 11u;
    local_2 = static_cast<uint>(start + 2u);
    uint _e25 = local_2;
    out[_e25] = 22u;
    local_3 = static_cast<uint>(start + 3u);
    uint _e37 = local_3;
    out[_e37] = 2u + (3u * 4u);
    local_4 = static_cast<uint>(start + 4u);
    uint _e46 = local_4;
    out[_e46] = 2u + 3u;
    local_6 = 2u;
    uint _e50 = local_6;
    local_5 = static_cast<uint>(start + 5u);
    uint _e57 = local_5;
    out[_e57] = 3u << _e50;
    uint _e59 = later(lane);
    local_7 = static_cast<uint>(start + 6u);
    uint _e64 = local_7;
    out[_e64] = _e59;
    original.first = lane + 1u;
    original.second = lane + 2u;
    Packet_cuda_record_0_ _e73 = original;
    copied = _e73;
    uint _e76 = copied.first;
    local_8 = static_cast<uint>(start + 7u);
    uint _e81 = local_8;
    out[_e81] = _e76;
    uint _e84 = copied.second;
    local_9 = static_cast<uint>(start + 8u);
    uint _e89 = local_9;
    out[_e89] = _e84;
    SELF = 17u;
    LEFT = 19u;
    RIGHT = 23u;
    uint _e97 = SELF;
    local_10 = static_cast<uint>(start + 9u);
    uint _e102 = local_10;
    out[_e102] = _e97;
    uint _e104 = LEFT;
    local_11 = static_cast<uint>(start + 10u);
    uint _e109 = local_11;
    out[_e109] = _e104;
    uint _e111 = RIGHT;
    local_12 = static_cast<uint>(start + 11u);
    uint _e116 = local_12;
    out[_e116] = _e111;
    counter = 0u;
    uint _e120 = counter;
    counter = _e120 + static_cast<uint>(1);
    uint _e124 = counter;
    ordered.first = _e124;
    uint _e128 = counter;
    counter = _e128 + static_cast<uint>(1);
    uint _e132 = counter;
    ordered.second = _e132;
    uint _e134 = ordered.first;
    local_13 = static_cast<uint>(start + 12u);
    uint _e139 = local_13;
    out[_e139] = _e134;
    uint _e142 = ordered.second;
    local_14 = static_cast<uint>(start + 13u);
    uint _e147 = local_14;
    out[_e147] = _e142;
    uint _e149 = counter;
    local_15 = static_cast<uint>(start + 14u);
    uint _e154 = local_15;
    out[_e154] = _e149;
    local_16 = static_cast<uint>(start + 15u);
    uint _e160 = local_16;
    out[_e160] = 31u;
    values.inner[0] = 2u;
    values.inner[1] = 4u;
    values.inner[2] = 6u;
    uint _e171 = values.inner[lane];
    local_17 = static_cast<uint>(start + 16u);
    uint _e176 = local_17;
    out[_e176] = _e171;
    index = 0u;
    uint _e180 = index;
    index = _e180 + static_cast<uint>(1);
    uint _e185 = values.inner[_e180];
    local_18 = static_cast<uint>(start + 17u);
    uint _e190 = local_18;
    out[_e190] = _e185;
    uint _e192 = index;
    local_19 = static_cast<uint>(start + 18u);
    uint _e197 = local_19;
    out[_e197] = _e192;
    local_20 = static_cast<uint>(start + 19u);
    uint _e205 = local_20;
    out[_e205] = static_cast<uint>(true);
    local_21 = static_cast<uint>(start + 20u);
    uint _e211 = local_21;
    out[_e211] = 61u;
    local_22 = static_cast<uint>(start + 21u);
    uint _e218 = local_22;
    out[_e218] = lane;
    local_23 = static_cast<uint>(start + 22u);
    uint _e227 = local_23;
    out[_e227] = as_type<uint>(-(0.0));
    local_24 = static_cast<uint>(start + 23u);
    uint _e233 = local_24;
    out[_e233] = 4294967295u;
}
