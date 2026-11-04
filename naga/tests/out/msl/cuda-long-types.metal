// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef long long_;
typedef long_ type_2[1];
typedef ulong unsigned_long;
typedef unsigned_long type_3[1];
struct type_4 {
    unsigned_long value;
    char _pad1[8];
};
struct type_5 {
    long_ value;
    char _pad1[8];
};

uint kind(
    long_ value
) {
    return 3u;
}

uint kind_1(
    long value_1
) {
    return 5u;
}

long_ identity_long(
    long_ value_2
) {
    return value_2;
}

struct long_typesInput {
};
[[max_total_threads_per_threadgroup(64)]] kernel void long_types(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant type_4& count [[buffer(2)]]
, constant type_5& bias [[buffer(3)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(4)]]
) {
    unsigned_long count_1 = count.value;
    long_ bias_1 = bias.value;
    uint index = (blockIdx.x * 64u) + threadIdx.x;
    if (static_cast<ulong>(index) >= count_1) {
        return;
    }
    long_ _e17 = input[index];
    long_ _e19 = identity_long(as_type<long>(as_type<ulong>(_e17) + as_type<ulong>(bias_1)));
    uint _e20 = kind(_e19);
    uint _e23 = kind_1(_e19);
    uint tags = (_e20 * 10u) + _e23;
    output[index] = static_cast<ulong>(as_type<long>(as_type<ulong>(_e19) + as_type<ulong>(1L))) + static_cast<ulong>(tags);
}
