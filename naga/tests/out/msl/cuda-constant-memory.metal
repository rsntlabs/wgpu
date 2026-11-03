// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size3;
    uint size4;
    uint size6;
    uint size7;
};

struct Settings_cuda_record_0_ {
    uint scale;
    uint bias;
};
struct type_1 {
    uint inner[4];
};
typedef uint type_2[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_5 {
    uint inner[2];
};

uint weighted_unsigned(
    uint input_2,
    uint index_1,
    device uint const& addend,
    device type_1 const& weights,
    device Settings_cuda_record_0_ const& settings
) {
    uint index_2 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint _e4 = settings.scale;
    index_2 = uint {};
    local_31 = uint {};
    local_32 = uint {};
    index_2 = index_1;
    uint _e13 = index_2;
    local_31 = _e13;
    uint _e15 = local_31;
    uint _e18 = weights.inner[_e15];
    local_32 = _e18;
    uint _e20 = local_32;
    uint _e23 = addend;
    return ((input_2 * _e4) + _e20) + _e23;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct constant_memoryInput {
};
kernel void constant_memory(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device uint const& addend [[buffer(3)]]
, device type_1 const& weights [[buffer(4)]]
, device Settings_cuda_record_0_ const& settings [[buffer(5)]]
, device type_2& output_2 [[buffer(0)]]
, device type_2 const& input_3 [[buffer(1)]]
, constant type_3& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(6)]]
) {
    type_5 output = {};
    type_5 input = {};
    type_5 local = {};
    uint local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    type_5 value = {};
    type_5 local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    type_5 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    output = type_5 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_5 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint count_2 = count.value;
    uint index_3 = (blockIdx.x * 4u) + threadIdx.x;
    if (index_3 < count_2) {
        type_5 _e24 = input;
        local_2 = _e24;
        local_3 = index_3;
        type_5 _e27 = local_2;
        local_7 = _e27;
        uint _e29 = local_3;
        uint _e31 = local_7.inner[1];
        local_7.inner[1] = _e31 + _e29;
        uint _e35 = local_7.inner[0];
        local_8 = static_cast<uint>(_e35);
        uint _e39 = local_7.inner[1];
        local_9 = static_cast<uint>(_e39);
        uint _e42 = local_9;
        uint _e45 = input_3[_e42];
        local_10 = _e45;
        uint _e47 = local_10;
        local_6 = _e47;
        uint _e49 = local_6;
        uint _e52 = weighted_unsigned(_e49, naga_mod(index_3, 4u), addend, weights, settings);
        uint _e55 = settings.bias;
        value = type_5 {};
        value.inner[0] = 4u;
        value.inner[1] = 0u;
        local_4 = 31u;
        uint _e65 = local_4;
        local_5 = 41u;
        uint _e69 = local_5;
        type_5 _e72 = output;
        local = _e72;
        local_1 = index_3;
        type_5 _e75 = local;
        local_11 = _e75;
        uint _e77 = local_1;
        uint _e79 = local_11.inner[1];
        local_11.inner[1] = _e79 + _e77;
        uint _e83 = local_11.inner[0];
        local_12 = static_cast<uint>(_e83);
        uint _e87 = local_11.inner[1];
        local_13 = static_cast<uint>(_e87);
        uint _e90 = local_13;
        output_2[_e90] = ((_e52 + _e55) + _e65) + _e69;
    }
}


struct constant_referencesInput {
};
kernel void constant_references(
  metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, device uint const& addend [[buffer(3)]]
, device type_1 const& weights [[buffer(4)]]
, device Settings_cuda_record_0_ const& settings [[buffer(5)]]
, device type_2& output_3 [[buffer(0)]]
, device type_2 const& input_4 [[buffer(1)]]
, constant type_3& count_1 [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(6)]]
) {
    type_5 output_1 = {};
    type_5 input_1 = {};
    Settings_cuda_record_0_ current = {};
    type_5 view = {};
    type_5 local_14 = {};
    type_5 local_15 = {};
    type_5 local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    type_5 values = {};
    uint index = {};
    type_5 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_5 value_1 = {};
    type_5 local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_5 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    type_5 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    output_1 = type_5 {};
    output_1.inner[0] = 2u;
    output_1.inner[1] = 0u;
    input_1 = type_5 {};
    input_1.inner[0] = 3u;
    input_1.inner[1] = 0u;
    uint count_3 = count_1.value;
    uint index_4 = (blockIdx_1.x * 4u) + threadIdx_1.x;
    if (index_4 >= count_3) {
        return;
    }
    Settings_cuda_record_0_ _e24 = settings;
    current = _e24;
    view = type_5 {};
    view.inner[0] = 4u;
    view.inner[1] = 0u;
    type_5 _e33 = input_1;
    local_15 = _e33;
    index = uint {};
    local_20 = uint {};
    local_21 = uint {};
    values = type_5 {};
    values.inner[0] = 4u;
    values.inner[1] = 0u;
    index = naga_mod(index_4 + 1u, 4u);
    type_5 _e53 = values;
    local_19 = _e53;
    uint _e55 = index;
    local_20 = _e55;
    type_5 _e57 = local_19;
    local_22 = _e57;
    uint _e59 = local_20;
    uint _e61 = local_22.inner[1];
    local_22.inner[1] = _e61 + _e59;
    uint _e65 = local_22.inner[0];
    local_23 = static_cast<uint>(_e65);
    uint _e69 = local_22.inner[1];
    local_24 = static_cast<uint>(_e69);
    uint _e72 = local_24;
    uint _e75 = weights.inner[_e72];
    local_21 = _e75;
    uint _e77 = local_21;
    type_5 _e78 = local_15;
    local_25 = _e78;
    uint _e81 = local_25.inner[1];
    local_25.inner[1] = _e81 + index_4;
    uint _e85 = local_25.inner[0];
    local_26 = static_cast<uint>(_e85);
    uint _e89 = local_25.inner[1];
    local_27 = static_cast<uint>(_e89);
    uint _e92 = local_27;
    uint _e95 = input_4[_e92];
    uint _e98 = addend;
    uint _e101 = current.scale;
    uint _e104 = current.bias;
    type_5 _e107 = view;
    local_16 = _e107;
    type_5 _e109 = local_16;
    value_1 = _e109;
    local_17 = 37u;
    uint _e113 = local_17;
    local_18 = 43u;
    uint _e117 = local_18;
    type_5 _e120 = output_1;
    local_14 = _e120;
    type_5 _e122 = local_14;
    local_28 = _e122;
    uint _e125 = local_28.inner[1];
    local_28.inner[1] = _e125 + index_4;
    uint _e129 = local_28.inner[0];
    local_29 = static_cast<uint>(_e129);
    uint _e133 = local_28.inner[1];
    local_30 = static_cast<uint>(_e133);
    uint _e136 = local_30;
    output_3[_e136] = (((((_e95 + _e77) + _e98) + _e101) + _e104) + _e113) + _e117;
}
