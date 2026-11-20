// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];

struct nested_offsetsInput {
};
kernel void nested_offsets(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    int pair = {};
    uint MiddleStart = {};
    uint LeafStart = {};
    uint First = {};
    uint Pair = {};
    uint Tail = {};
    uint Last = {};
    uint End = {};
    uint LocalPair = {};
    uint LeafPair = {};
    uint Sum = {};
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
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 12u);
    pair = 7;
    MiddleStart = 16u;
    LeafStart = 32u;
    First = 32u;
    Pair = 40u;
    Tail = 48u;
    Last = 64u;
    End = 80u;
    LocalPair = 56u;
    LeafPair = 8u;
    Sum = 40u;
    uint _e28 = MiddleStart;
    output[base] = _e28;
    uint _e31 = LeafStart;
    local = static_cast<uint>(base + 1u);
    uint _e36 = local;
    output[_e36] = _e31;
    uint _e38 = First;
    local_1 = static_cast<uint>(base + 2u);
    uint _e43 = local_1;
    output[_e43] = _e38;
    uint _e45 = Pair;
    local_2 = static_cast<uint>(base + 3u);
    uint _e50 = local_2;
    output[_e50] = _e45;
    uint _e52 = Tail;
    local_3 = static_cast<uint>(base + 4u);
    uint _e57 = local_3;
    output[_e57] = _e52;
    uint _e59 = Last;
    local_4 = static_cast<uint>(base + 5u);
    uint _e64 = local_4;
    output[_e64] = _e59;
    uint _e66 = End;
    local_5 = static_cast<uint>(base + 6u);
    uint _e71 = local_5;
    output[_e71] = _e66;
    uint _e73 = LocalPair;
    local_6 = static_cast<uint>(base + 7u);
    uint _e78 = local_6;
    output[_e78] = _e73;
    uint _e80 = LeafPair;
    local_7 = static_cast<uint>(base + 8u);
    uint _e85 = local_7;
    output[_e85] = _e80;
    uint _e87 = Sum;
    local_8 = static_cast<uint>(base + 9u);
    uint _e92 = local_8;
    output[_e92] = _e87;
    int _e94 = pair;
    local_9 = static_cast<uint>(base + 10u);
    uint _e100 = local_9;
    output[_e100] = static_cast<uint>(_e94);
    local_10 = static_cast<uint>(base + 11u);
    uint _e106 = local_10;
    output[_e106] = lane;
}
