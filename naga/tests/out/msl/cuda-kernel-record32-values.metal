// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size6;
};

struct Five_cuda_record_0_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
};
struct Six_cuda_record_1_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
};
struct Seven_cuda_record_2_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
};
struct Eight_cuda_record_3_ {
    int a;
    uint b;
    float c;
    uint d;
    int e;
    uint f;
    float g;
    uint h;
};
struct Small_cuda_record_4_ {
    uint value;
};
typedef uint type_3[1];
struct type_4 {
    Five_cuda_record_0_ value;
    char _pad1[12];
};
struct type_5 {
    Six_cuda_record_1_ value;
    char _pad1[8];
};
struct type_6 {
    Seven_cuda_record_2_ value;
    char _pad1[4];
};
struct type_7 {
    Eight_cuda_record_3_ value;
};
struct type_8 {
    Small_cuda_record_4_ value;
    char _pad1[12];
};
typedef Five_cuda_record_0_ type_9[1];
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct record32_valuesInput {
};
kernel void record32_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3& output [[buffer(0)]]
, constant type_4& five_1 [[buffer(1)]]
, constant type_5& six_1 [[buffer(2)]]
, constant type_6& seven_1 [[buffer(3)]]
, constant type_7& eight_1 [[buffer(4)]]
, constant type_8& small_1 [[buffer(5)]]
, device type_9 const& input [[buffer(6)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(7)]]
) {
    Five_cuda_record_0_ five = {};
    Six_cuda_record_1_ six = {};
    Seven_cuda_record_2_ seven = {};
    Eight_cuda_record_3_ eight = {};
    Small_cuda_record_4_ small = {};
    Five_cuda_record_0_ original = {};
    Seven_cuda_record_2_ saved = {};
    Eight_cuda_record_3_ changed = {};
    Five_cuda_record_0_ stored = {};
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
    uint lane = {};
    Five_cuda_record_0_ local_11 = {};
    Five_cuda_record_0_ local_12 = {};
    Five_cuda_record_0_ _e4 = five_1.value;
    five = _e4;
    Six_cuda_record_1_ _e8 = six_1.value;
    six = _e8;
    Seven_cuda_record_2_ _e12 = seven_1.value;
    seven = _e12;
    Eight_cuda_record_3_ _e16 = eight_1.value;
    eight = _e16;
    Small_cuda_record_4_ _e20 = small_1.value;
    small = _e20;
    uint lane_1 = threadIdx.x + (blockIdx.x * 4u);
    if (lane_1 >= 4u) {
        return;
    }
    uint base = 4u + (lane_1 * 12u);
    Five_cuda_record_0_ _e33 = five;
    original = _e33;
    Seven_cuda_record_2_ _e35 = seven;
    saved = _e35;
    lane = uint {};
    lane = lane_1;
    uint _e40 = lane;
    int _e43 = five.e;
    five.e = as_type<int>(as_type<uint>(_e43) + as_type<uint>(static_cast<int>(_e40)));
    float _e48 = seven.g;
    seven.g = _e48 + static_cast<float>(lane_1);
    Eight_cuda_record_3_ _e50 = eight;
    changed = _e50;
    uint _e53 = changed.h;
    changed.h = _e53 + lane_1;
    Eight_cuda_record_3_ _e55 = changed;
    eight = _e55;
    Five_cuda_record_0_ _e58 = input[lane_1];
    local_12 = _e58;
    Five_cuda_record_0_ _e60 = local_12;
    local_11 = _e60;
    Five_cuda_record_0_ _e62 = local_11;
    stored = _e62;
    int _e65 = original.e;
    output[base] = static_cast<uint>(as_type<int>(as_type<uint>(_e65) + as_type<uint>(30)));
    int _e72 = five.e;
    local = static_cast<uint>(base + 1u);
    uint _e80 = local;
    output[_e80] = static_cast<uint>(as_type<int>(as_type<uint>(_e72) + as_type<uint>(30)));
    int _e83 = six.e;
    local_1 = static_cast<uint>(base + 2u);
    uint _e91 = local_1;
    output[_e91] = static_cast<uint>(as_type<int>(as_type<uint>(_e83) + as_type<uint>(30)));
    uint _e94 = six.f;
    local_2 = static_cast<uint>(base + 3u);
    uint _e99 = local_2;
    output[_e99] = _e94;
    float _e102 = seven.g;
    local_3 = static_cast<uint>(base + 4u);
    uint _e108 = local_3;
    output[_e108] = as_type<uint>(_e102);
    float _e111 = saved.g;
    local_4 = static_cast<uint>(base + 5u);
    uint _e117 = local_4;
    output[_e117] = as_type<uint>(_e111);
    uint _e120 = eight.h;
    local_5 = static_cast<uint>(base + 6u);
    uint _e125 = local_5;
    output[_e125] = _e120;
    uint _e128 = eight.f;
    local_6 = static_cast<uint>(base + 7u);
    uint _e133 = local_6;
    output[_e133] = _e128;
    float _e136 = eight.g;
    local_7 = static_cast<uint>(base + 8u);
    uint _e142 = local_7;
    output[_e142] = as_type<uint>(_e136);
    int _e145 = eight.e;
    local_8 = static_cast<uint>(base + 9u);
    uint _e153 = local_8;
    output[_e153] = static_cast<uint>(as_type<int>(as_type<uint>(_e145) + as_type<uint>(30)));
    uint _e156 = small.value;
    local_9 = static_cast<uint>(base + 10u);
    uint _e161 = local_9;
    output[_e161] = _e156;
    int _e165 = stored.a;
    int _e166 = stored.e;
    uint _e170 = stored.b;
    uint _e173 = stored.d;
    float _e176 = stored.c;
    local_10 = static_cast<uint>(base + 11u);
    uint _e183 = local_10;
    output[_e183] = ((static_cast<uint>(as_type<int>(as_type<uint>(_e165) + as_type<uint>(_e166))) + _e170) + _e173) + naga_f2u32(_e176);
}
