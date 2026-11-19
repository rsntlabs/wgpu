// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_3[1];
struct type_5 {
    metal::int2 value;
    char _pad1[8];
};
struct type_7 {
    metal::uint2 value;
    char _pad1[8];
};
struct type_9 {
    metal::float2 value;
    char _pad1[8];
};
struct type_10 {
    metal::int4 value;
};
struct type_12 {
    metal::uint4 value;
};
struct type_14 {
    metal::float4 value;
};

int sum_pair(
    metal::int4 value
) {
    metal::int4 value_1 = {};
    value_1 = value;
    int _e4 = value_1.x;
    int _e5 = value_1.y;
    return as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5));
}

struct vector_valuesInput {
};
kernel void vector_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3& output [[buffer(0)]]
, constant type_5& signed2_1 [[buffer(1)]]
, constant type_7& unsigned2_1 [[buffer(2)]]
, constant type_9& real2_1 [[buffer(3)]]
, constant type_10& signed4_1 [[buffer(4)]]
, constant type_12& unsigned4_1 [[buffer(5)]]
, constant type_14& real4_1 [[buffer(6)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(7)]]
) {
    metal::int2 signed2_ = {};
    metal::uint2 unsigned2_ = {};
    metal::float2 real2_ = {};
    metal::int4 signed4_ = {};
    metal::uint4 unsigned4_ = {};
    metal::float4 real4_ = {};
    metal::int2 original_signed = {};
    metal::float2 original_real = {};
    metal::uint4 original_unsigned = {};
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
    metal::int2 _e4 = signed2_1.value;
    signed2_ = _e4;
    metal::uint2 _e8 = unsigned2_1.value;
    unsigned2_ = _e8;
    metal::float2 _e12 = real2_1.value;
    real2_ = _e12;
    metal::int4 _e16 = signed4_1.value;
    signed4_ = _e16;
    metal::uint4 _e20 = unsigned4_1.value;
    unsigned4_ = _e20;
    metal::float4 _e24 = real4_1.value;
    real4_ = _e24;
    uint lane = threadIdx.x + (blockIdx.x * 4u);
    if (lane >= 4u) {
        return;
    }
    uint base = 4u + (lane * 12u);
    metal::int2 _e37 = signed2_;
    original_signed = _e37;
    metal::float2 _e39 = real2_;
    original_real = _e39;
    metal::uint4 _e41 = unsigned4_;
    original_unsigned = _e41;
    int _e45 = signed2_.x;
    signed2_.x = as_type<int>(as_type<uint>(_e45) + as_type<uint>(static_cast<int>(lane)));
    int _e49 = signed2_.y;
    signed2_.y = as_type<int>(as_type<uint>(_e49) - as_type<uint>(static_cast<int>(lane)));
    uint _e52 = unsigned2_.x;
    unsigned2_.x = _e52 + lane;
    uint _e55 = unsigned2_.y;
    unsigned2_.y = _e55 + 2u;
    float _e60 = real2_.x;
    real2_.x = _e60 + static_cast<float>(lane);
    float _e63 = real2_.y;
    real2_.y = _e63 * 2.0;
    int _e67 = signed4_.x;
    int _e69 = signed4_.y;
    int _e72 = signed4_.z;
    metal::int4 _e74 = signed4_;
    int _e75 = sum_pair(_e74);
    signed4_ = metal::int4(_e67, _e69, as_type<int>(as_type<uint>(_e72) + as_type<uint>(static_cast<int>(lane))), _e75);
    uint _e78 = unsigned4_.y;
    unsigned4_.x = _e78 + 1u;
    uint _e83 = unsigned4_.w;
    unsigned4_.w = _e83 + lane;
    int _e86 = signed2_.x;
    output[base] = static_cast<uint>(as_type<int>(as_type<uint>(_e86) + as_type<uint>(10)));
    int _e93 = signed2_.y;
    local = static_cast<uint>(base + 1u);
    uint _e99 = local;
    output[_e99] = static_cast<uint>(_e93);
    uint _e103 = unsigned2_.x;
    uint _e104 = unsigned2_.y;
    local_1 = static_cast<uint>(base + 2u);
    uint _e110 = local_1;
    output[_e110] = _e103 + _e104;
    float _e113 = real2_.x;
    local_2 = static_cast<uint>(base + 3u);
    uint _e119 = local_2;
    output[_e119] = as_type<uint>(_e113);
    float _e122 = real2_.y;
    local_3 = static_cast<uint>(base + 4u);
    uint _e128 = local_3;
    output[_e128] = as_type<uint>(_e122);
    int _e131 = signed4_.z;
    local_4 = static_cast<uint>(base + 5u);
    uint _e139 = local_4;
    output[_e139] = static_cast<uint>(as_type<int>(as_type<uint>(_e131) + as_type<uint>(10)));
    int _e142 = signed4_.w;
    local_5 = static_cast<uint>(base + 6u);
    uint _e148 = local_5;
    output[_e148] = static_cast<uint>(_e142);
    uint _e152 = unsigned4_.x;
    uint _e153 = unsigned4_.w;
    local_6 = static_cast<uint>(base + 7u);
    uint _e159 = local_6;
    output[_e159] = _e152 + _e153;
    float _e163 = real4_.x;
    float _e164 = real4_.y;
    float _e167 = real4_.z;
    float _e170 = real4_.w;
    local_7 = static_cast<uint>(base + 8u);
    uint _e177 = local_7;
    output[_e177] = as_type<uint>(((_e163 + _e164) + _e167) + _e170);
    int _e180 = original_signed.x;
    local_8 = static_cast<uint>(base + 9u);
    uint _e188 = local_8;
    output[_e188] = static_cast<uint>(as_type<int>(as_type<uint>(_e180) + as_type<uint>(10)));
    float _e191 = original_real.x;
    local_9 = static_cast<uint>(base + 10u);
    uint _e197 = local_9;
    output[_e197] = as_type<uint>(_e191);
    uint _e201 = original_unsigned.x;
    uint _e202 = original_unsigned.w;
    local_10 = static_cast<uint>(base + 11u);
    uint _e208 = local_10;
    output[_e208] = _e201 + _e202;
}
