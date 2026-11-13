// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_2[1];
typedef ulong type_3[1];

int count_word(
    ulong value
) {
    return static_cast<int>(metal::popcount(static_cast<uint>(value)) + metal::popcount(static_cast<uint>(value >> 32u)));
}

struct popcountsInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void popcounts(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, device type_3 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint index = threadIdx.x;
    ulong _e4 = input[index];
    int _e5 = count_word(_e4);
    output[index] = _e5;
}
