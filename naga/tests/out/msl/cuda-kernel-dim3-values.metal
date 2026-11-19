// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
typedef uint type_1[1];
struct type_2 {
    dim3_ value;
    char _pad1[4];
};

uint kind(
    dim3_ param
) {
    return 11u;
}

uint kind_1(
    uint3_ param_1
) {
    return 22u;
}

struct dim3_valuesInput {
};
kernel void dim3_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_1& output [[buffer(0)]]
, constant type_2& shape_1 [[buffer(1)]]
, constant type_2& fixed_1 [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    dim3_ shape = {};
    dim3_ fixed = {};
    dim3_ original = {};
    uint3_ packed = {};
    dim3_ restored = {};
    dim3_ local = {};
    dim3_ partial = {};
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
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint lane = {};
    dim3_ _e4 = shape_1.value;
    shape = _e4;
    dim3_ _e8 = fixed_1.value;
    fixed = _e8;
    uint lane_1 = threadIdx.x + (blockIdx.x * 4u);
    if (lane_1 >= 4u) {
        return;
    }
    uint base = 4u + (lane_1 * 14u);
    dim3_ _e21 = shape;
    original = _e21;
    dim3_ _e23 = original;
    packed = uint3_ {_e23.x, _e23.y, _e23.z};
    uint3_ _e29 = packed;
    restored = dim3_ {_e29.x, _e29.y, _e29.z};
    lane = uint {};
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = shape.x;
    shape.x = _e40 + _e38;
    uint _e44 = shape.y;
    shape.y = _e44 + 2u;
    uint _e49 = shape.x;
    uint _e51 = shape.y;
    shape = dim3_ {_e49, _e51, 1u};
    local = dim3_ {1u, 1u, 1u};
    partial = dim3_ {2u, 1u, 1u};
    uint _e65 = original.x;
    output[base] = _e65;
    uint _e69 = original.y;
    local_1 = static_cast<uint>(base + 1u);
    uint _e74 = local_1;
    output[_e74] = _e69;
    uint _e77 = original.z;
    local_2 = static_cast<uint>(base + 2u);
    uint _e82 = local_2;
    output[_e82] = _e77;
    uint _e85 = shape.x;
    local_3 = static_cast<uint>(base + 3u);
    uint _e90 = local_3;
    output[_e90] = _e85;
    uint _e93 = shape.y;
    local_4 = static_cast<uint>(base + 4u);
    uint _e98 = local_4;
    output[_e98] = _e93;
    uint _e101 = shape.z;
    local_5 = static_cast<uint>(base + 5u);
    uint _e106 = local_5;
    output[_e106] = _e101;
    uint _e110 = local.x;
    uint _e111 = local.y;
    uint _e114 = local.z;
    local_6 = static_cast<uint>(base + 6u);
    uint _e120 = local_6;
    output[_e120] = (_e110 + _e111) + _e114;
    uint _e123 = fixed.x;
    local_7 = static_cast<uint>(base + 7u);
    uint _e128 = local_7;
    output[_e128] = _e123;
    uint _e131 = fixed.y;
    local_8 = static_cast<uint>(base + 8u);
    uint _e136 = local_8;
    output[_e136] = _e131;
    uint _e139 = fixed.z;
    local_9 = static_cast<uint>(base + 9u);
    uint _e144 = local_9;
    output[_e144] = _e139;
    dim3_ _e146 = shape;
    uint _e147 = kind(_e146);
    uint3_ _e148 = packed;
    uint _e149 = kind_1(_e148);
    local_10 = static_cast<uint>(base + 10u);
    uint _e155 = local_10;
    output[_e155] = _e147 + _e149;
    uint _e159 = restored.x;
    uint _e160 = restored.y;
    uint _e163 = restored.z;
    local_11 = static_cast<uint>(base + 11u);
    uint _e169 = local_11;
    output[_e169] = (_e159 ^ _e160) ^ _e163;
    local_12 = static_cast<uint>(base + 12u);
    uint _e175 = local_12;
    output[_e175] = 4u;
    uint _e180 = partial.y;
    uint _e181 = partial.z;
    local_13 = static_cast<uint>(base + 13u);
    uint _e187 = local_13;
    output[_e187] = _e180 + _e181;
}
