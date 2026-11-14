// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef ulong type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

ulong reverse_word(
    ulong value
) {
    return (static_cast<ulong>(metal::reverse_bits(static_cast<uint>(value))) << 32u) | static_cast<ulong>(metal::reverse_bits(static_cast<uint>(value >> 32u)));
}

struct reverse_wordsInput {
};
[[max_total_threads_per_threadgroup(64)]] kernel void reverse_words(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant type_3& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    uint local = {};
    uint count_1 = count.value;
    uint index = (blockIdx.x * 64u) + threadIdx.x;
    if (index >= count_1) {
        return;
    }
    ulong _e13 = input[index];
    ulong _e14 = reverse_word(_e13);
    local = static_cast<uint>(index + 4u);
    uint _e19 = local;
    output[_e19] = _e14;
}
