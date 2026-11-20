// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];

struct indexed_offsetsInput {
};
kernel void indexed_offsets(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    int cursor = {};
    uint LeafValue = {};
    uint GridFirst = {};
    uint GridLast = {};
    uint Row = {};
    uint LeafObject = {};
    uint Hex = {};
    uint Octal = {};
    uint WideZero = {};
    uint Pair = {};
    uint Quad = {};
    uint Triple = {};
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
    cursor = 7;
    LeafValue = 32u;
    GridFirst = 40u;
    GridLast = 56u;
    Row = 48u;
    LeafObject = 20u;
    Hex = 32u;
    Octal = 56u;
    WideZero = 8u;
    Pair = 16u;
    Quad = 48u;
    Triple = 76u;
    uint _e30 = LeafValue;
    output[base] = _e30;
    uint _e33 = GridFirst;
    local = static_cast<uint>(base + 1u);
    uint _e38 = local;
    output[_e38] = _e33;
    uint _e40 = GridLast;
    local_1 = static_cast<uint>(base + 2u);
    uint _e45 = local_1;
    output[_e45] = _e40;
    uint _e47 = Row;
    local_2 = static_cast<uint>(base + 3u);
    uint _e52 = local_2;
    output[_e52] = _e47;
    uint _e54 = LeafObject;
    local_3 = static_cast<uint>(base + 4u);
    uint _e59 = local_3;
    output[_e59] = _e54;
    uint _e61 = Hex;
    local_4 = static_cast<uint>(base + 5u);
    uint _e66 = local_4;
    output[_e66] = _e61;
    uint _e68 = Octal;
    local_5 = static_cast<uint>(base + 6u);
    uint _e73 = local_5;
    output[_e73] = _e68;
    uint _e75 = WideZero;
    local_6 = static_cast<uint>(base + 7u);
    uint _e80 = local_6;
    output[_e80] = _e75;
    uint _e82 = Pair;
    local_7 = static_cast<uint>(base + 8u);
    uint _e87 = local_7;
    output[_e87] = _e82;
    uint _e89 = Quad;
    local_8 = static_cast<uint>(base + 9u);
    uint _e94 = local_8;
    output[_e94] = _e89;
    uint _e96 = Triple;
    local_9 = static_cast<uint>(base + 10u);
    uint _e101 = local_9;
    output[_e101] = _e96;
    int _e103 = cursor;
    local_10 = static_cast<uint>(base + 11u);
    uint _e110 = local_10;
    output[_e110] = static_cast<uint>(_e103) + lane;
}
