// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size7;
};

struct int3_ {
    int x;
    int y;
    int z;
};
typedef uint type_2[1];
struct int1_ {
    int x;
};
struct type_3 {
    int1_ value;
    char _pad1[12];
};
struct uint1_ {
    uint x;
};
struct type_4 {
    uint1_ value;
    char _pad1[12];
};
struct float1_ {
    float x;
};
struct type_6 {
    float1_ value;
    char _pad1[12];
};
struct type_7 {
    int3_ value;
    char _pad1[4];
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct type_8 {
    uint3_ value;
    char _pad1[4];
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_9 {
    float3_ value;
    char _pad1[4];
};
typedef float3_ type_10[1];

int sum_pair(
    int3_ value
) {
    int3_ value_1 = {};
    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5));
}

struct named_vectorsInput {
};
kernel void named_vectors(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2& output [[buffer(0)]]
, constant type_3& signed1_1 [[buffer(1)]]
, constant type_4& unsigned1_1 [[buffer(2)]]
, constant type_6& real1_1 [[buffer(3)]]
, constant type_7& signed3_1 [[buffer(4)]]
, constant type_8& unsigned3_1 [[buffer(5)]]
, constant type_9& real3_1 [[buffer(6)]]
, device type_10 const& input [[buffer(7)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(8)]]
) {
    int1_ signed1_ = {};
    uint1_ unsigned1_ = {};
    float1_ real1_ = {};
    int3_ signed3_ = {};
    uint3_ unsigned3_ = {};
    float3_ real3_ = {};
    int1_ original_signed = {};
    float1_ original_real = {};
    uint3_ original_unsigned = {};
    float3_ stored = {};
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
    float3_ local_11 = {};
    float3_ local_12 = {};
    int1_ _e4 = signed1_1.value;
    signed1_ = _e4;
    uint1_ _e8 = unsigned1_1.value;
    unsigned1_ = _e8;
    float1_ _e12 = real1_1.value;
    real1_ = _e12;
    int3_ _e16 = signed3_1.value;
    signed3_ = _e16;
    uint3_ _e20 = unsigned3_1.value;
    unsigned3_ = _e20;
    float3_ _e24 = real3_1.value;
    real3_ = _e24;
    uint lane = threadIdx.x + (blockIdx.x * 4u);
    if (lane >= 4u) {
        return;
    }
    uint base = 4u + (lane * 12u);
    int1_ _e37 = signed1_;
    original_signed = _e37;
    float1_ _e39 = real1_;
    original_real = _e39;
    uint3_ _e41 = unsigned3_;
    original_unsigned = _e41;
    int _e45 = signed1_.x;
    signed1_.x = as_type<int>(as_type<uint>(_e45) + as_type<uint>(static_cast<int>(lane)));
    uint _e48 = unsigned1_.x;
    unsigned1_.x = _e48 + lane;
    float _e52 = real1_.x;
    real1_.x = _e52 + static_cast<float>(lane);
    int _e55 = signed3_.x;
    int _e57 = signed3_.y;
    int _e60 = signed3_.z;
    signed3_ = int3_ {_e55, _e57, as_type<int>(as_type<uint>(_e60) + as_type<uint>(static_cast<int>(lane)))};
    uint _e64 = unsigned3_.y;
    unsigned3_.x = _e64 + 1u;
    uint _e69 = unsigned3_.z;
    unsigned3_.z = _e69 + lane;
    float3_ _e73 = input[lane];
    local_12 = _e73;
    float3_ _e75 = local_12;
    local_11 = _e75;
    float3_ _e77 = local_11;
    stored = _e77;
    int _e80 = signed1_.x;
    output[base] = static_cast<uint>(as_type<int>(as_type<uint>(_e80) + as_type<uint>(10)));
    uint _e87 = unsigned1_.x;
    local = static_cast<uint>(base + 1u);
    uint _e92 = local;
    output[_e92] = _e87;
    float _e95 = real1_.x;
    local_1 = static_cast<uint>(base + 2u);
    uint _e101 = local_1;
    output[_e101] = as_type<uint>(_e95);
    int _e104 = signed3_.z;
    local_2 = static_cast<uint>(base + 3u);
    uint _e112 = local_2;
    output[_e112] = static_cast<uint>(as_type<int>(as_type<uint>(_e104) + as_type<uint>(10)));
    int3_ _e114 = signed3_;
    int _e115 = sum_pair(_e114);
    local_3 = static_cast<uint>(base + 4u);
    uint _e121 = local_3;
    output[_e121] = static_cast<uint>(_e115);
    uint _e125 = unsigned3_.x;
    uint _e126 = unsigned3_.z;
    local_4 = static_cast<uint>(base + 5u);
    uint _e132 = local_4;
    output[_e132] = _e125 + _e126;
    float _e136 = real3_.x;
    float _e137 = real3_.y;
    float _e140 = real3_.z;
    local_5 = static_cast<uint>(base + 6u);
    uint _e147 = local_5;
    output[_e147] = as_type<uint>((_e136 + _e137) + _e140);
    int _e150 = original_signed.x;
    local_6 = static_cast<uint>(base + 7u);
    uint _e158 = local_6;
    output[_e158] = static_cast<uint>(as_type<int>(as_type<uint>(_e150) + as_type<uint>(10)));
    uint _e162 = original_unsigned.x;
    uint _e163 = original_unsigned.z;
    local_7 = static_cast<uint>(base + 8u);
    uint _e169 = local_7;
    output[_e169] = _e162 + _e163;
    float _e172 = original_real.x;
    local_8 = static_cast<uint>(base + 9u);
    uint _e178 = local_8;
    output[_e178] = as_type<uint>(_e172);
    float _e181 = stored.z;
    local_9 = static_cast<uint>(base + 10u);
    uint _e187 = local_9;
    output[_e187] = as_type<uint>(_e181);
    float _e191 = stored.x;
    float _e192 = real3_.x;
    local_10 = static_cast<uint>(base + 11u);
    uint _e199 = local_10;
    output[_e199] = as_type<uint>(_e191 + _e192);
}
