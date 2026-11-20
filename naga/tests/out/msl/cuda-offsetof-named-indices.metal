// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];
constant uint RowIndex = 1u;
constant int ColumnIndex = 2;

uint selected_offset_0u(
) {
    uint offset = {};
    offset = 16u;
    uint _e2 = offset;
    return _e2;
}

uint selected_offset_1u(
) {
    uint offset_1 = {};
    offset_1 = 32u;
    uint _e2 = offset_1;
    return _e2;
}

struct named_offsetsInput {
};
kernel void named_offsets(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    int cursor = {};
    uint LocalColumn = {};
    int LocalRow = {};
    uint Zero = {};
    bool LastRow = {};
    uint Global = {};
    uint Local = {};
    uint Mixed = {};
    uint ZeroIndex = {};
    uint BoolIndex = {};
    uint Macro = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 10u);
    cursor = 7;
    LocalColumn = 1u;
    LocalRow = 1;
    Zero = 0u;
    LastRow = true;
    Global = 56u;
    Local = 52u;
    Mixed = 28u;
    ZeroIndex = 8u;
    BoolIndex = 48u;
    Macro = 56u;
    uint _e28 = Global;
    output[base] = _e28;
    uint _e31 = Local;
    local = static_cast<uint>(base + 1u);
    uint _e36 = local;
    output[_e36] = _e31;
    uint _e38 = Mixed;
    local_1 = static_cast<uint>(base + 2u);
    uint _e43 = local_1;
    output[_e43] = _e38;
    uint _e45 = ZeroIndex;
    local_2 = static_cast<uint>(base + 3u);
    uint _e50 = local_2;
    output[_e50] = _e45;
    uint _e52 = BoolIndex;
    local_3 = static_cast<uint>(base + 4u);
    uint _e57 = local_3;
    output[_e57] = _e52;
    uint _e59 = Macro;
    local_4 = static_cast<uint>(base + 5u);
    uint _e64 = local_4;
    output[_e64] = _e59;
    uint _e66 = selected_offset_0u();
    local_5 = static_cast<uint>(base + 6u);
    uint _e71 = local_5;
    output[_e71] = _e66;
    uint _e73 = selected_offset_1u();
    local_6 = static_cast<uint>(base + 7u);
    uint _e78 = local_6;
    output[_e78] = _e73;
    int _e80 = cursor;
    local_7 = static_cast<uint>(base + 8u);
    uint _e86 = local_7;
    output[_e86] = static_cast<uint>(_e80);
    local_8 = static_cast<uint>(base + 9u);
    uint _e92 = local_8;
    output[_e92] = lane;
}
