// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
constant uint Count = 4u;

uint verified_unsigned_4u(
    uint value
) {
    return value;
}

struct assertionsInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void assertions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    uint VectorBytes = {};
    uint local = {};
    VectorBytes = 12u;
    uint _e6 = verified_unsigned_4u(threadIdx.x + 7u);
    local = static_cast<uint>(threadIdx.x);
    uint _e10 = local;
    output[_e10] = _e6;
}
