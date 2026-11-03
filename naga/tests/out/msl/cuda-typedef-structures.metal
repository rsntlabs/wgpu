// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size3;
    uint size4;
    uint size6;
    uint size7;
};

struct Pair_cuda_record_0_ {
    uint low;
    uint high;
};
struct type_1 {
    uint inner[2];
};
struct PacketTag_cuda_record_1_ {
    Pair_cuda_record_0_ pair;
    type_1 samples;
};
typedef PacketTag_cuda_record_1_ type_2[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct Bias_cuda_record_2_ {
    uint value;
};
typedef Pair_cuda_record_0_ type_5[1];

Pair_cuda_record_0_ rotated_pair(
    Pair_cuda_record_0_ value
) {
    Pair_cuda_record_0_ value_1 = {};
    Pair_cuda_record_0_ local_14 = {};
    value_1 = value;
    uint _e4 = value_1.high;
    local_14.low = _e4;
    uint _e8 = value_1.low;
    local_14.high = _e8;
    Pair_cuda_record_0_ _e9 = local_14;
    return _e9;
}

struct copy_records_PairInput {
};
kernel void copy_records_Pair(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_5& output_1 [[user(fake0)]]
, device type_5 const& input_1 [[user(fake0)]]
, constant type_3& count_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    Pair_cuda_record_0_ local_2 = {};
    uint local_3 = {};
    Pair_cuda_record_0_ local_4 = {};
    uint local_5 = {};
    uint count_3 = count_1.value;
    uint index = (blockIdx.x * 4u) + threadIdx.x;
    if (index < count_3) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        Pair_cuda_record_0_ _e17 = input_1[_e14];
        local_4 = _e17;
        Pair_cuda_record_0_ _e19 = local_4;
        local_2 = _e19;
        Pair_cuda_record_0_ _e21 = local_2;
        local = index;
        uint _e23 = local;
        local_5 = _e23;
        uint _e25 = local_5;
        output_1[_e25] = _e21;
    }
}


struct copy_records_PacketTagInput {
};
kernel void copy_records_PacketTag(
  metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, device type_2& output_2 [[user(fake0)]]
, device type_2 const& input_2 [[user(fake0)]]
, constant type_3& count_2 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local_6 = {};
    uint local_7 = {};
    PacketTag_cuda_record_1_ local_8 = {};
    uint local_9 = {};
    PacketTag_cuda_record_1_ local_10 = {};
    uint local_11 = {};
    uint count_4 = count_2.value;
    uint index_1 = (blockIdx_1.x * 4u) + threadIdx_1.x;
    if (index_1 < count_4) {
        local_7 = index_1;
        uint _e12 = local_7;
        local_9 = _e12;
        uint _e14 = local_9;
        PacketTag_cuda_record_1_ _e17 = input_2[_e14];
        local_10 = _e17;
        PacketTag_cuda_record_1_ _e19 = local_10;
        local_8 = _e19;
        PacketTag_cuda_record_1_ _e21 = local_8;
        local_6 = index_1;
        uint _e23 = local_6;
        local_11 = _e23;
        uint _e25 = local_11;
        output_2[_e25] = _e21;
    }
}


struct transform_recordsInput {
};
kernel void transform_records(
  metal::uint3 blockIdx_2 [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx_2 [[thread_position_in_threadgroup]]
, device type_2& output [[user(fake0)]]
, device type_2 const& input [[user(fake0)]]
, constant type_3& count [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Bias_cuda_record_2_ bias = {};
    PacketTag_cuda_record_1_ packet = {};
    PacketTag_cuda_record_1_ local_12 = {};
    PacketTag_cuda_record_1_ local_13 = {};
    uint count_5 = count.value;
    uint index_2 = (blockIdx_2.x * 4u) + threadIdx_2.x;
    if (index_2 >= count_5) {
        return;
    }
    bias.value = index_2 + 1u;
    PacketTag_cuda_record_1_ _e17 = input[index_2];
    local_13 = _e17;
    PacketTag_cuda_record_1_ _e19 = local_13;
    local_12 = _e19;
    PacketTag_cuda_record_1_ _e21 = local_12;
    packet = _e21;
    Pair_cuda_record_0_ _e24 = packet.pair;
    Pair_cuda_record_0_ _e25 = rotated_pair(_e24);
    packet.pair = _e25;
    uint _e28 = bias.value;
    uint _e32 = packet.samples.inner[0];
    packet.samples.inner[0] = _e32 + _e28;
    uint _e37 = packet.samples.inner[1];
    packet.samples.inner[1] = _e37 ^ 2779077210u;
    PacketTag_cuda_record_1_ _e40 = packet;
    output[index_2] = _e40;
}
