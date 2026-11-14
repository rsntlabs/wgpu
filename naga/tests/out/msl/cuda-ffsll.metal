// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_2[1];
typedef long type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};

int first_set_word(
    long value
) {
    uint _e1 = static_cast<uint>(value);
    uint _e4 = static_cast<uint>(value >> 32u);
    return static_cast<int>((_e1 != 0u) ? (metal::ctz(_e1) + 1u) : ((_e4 != 0u) ? (metal::ctz(_e4) + 33u) : 0u));
}

struct first_set_positionsInput {
};
[[max_total_threads_per_threadgroup(64)]] kernel void first_set_positions(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, device type_4 const& input [[buffer(1)]]
, constant type_5& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint local = {};
    uint count_1 = count.value;
    uint index = (blockIdx.x * 64u) + threadIdx.x;
    if (index >= count_1) {
        return;
    }
    long _e13 = input[index];
    int _e14 = first_set_word(_e13);
    local = static_cast<uint>(index + 4u);
    uint _e19 = local;
    output[_e19] = _e14;
}
