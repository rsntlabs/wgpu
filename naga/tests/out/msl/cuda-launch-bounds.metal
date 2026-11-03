// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size2;
    uint size3;
    uint size5;
    uint size6;
};

typedef uint type_2[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_4 {
    uint inner[2];
};

uint shifted_7u(
    uint value
) {
    return (value * 3u) + 7u;
}

struct boundedInput {
};
kernel void bounded(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2& output_4 [[user(fake0)]]
, device type_2 const& input_4 [[user(fake0)]]
, constant type_3& count_2 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_2 = {};
    metal::uint3 blockIdx_2 = {};
    type_4 output = {};
    type_4 input = {};
    type_4 local = {};
    type_4 local_1 = {};
    type_4 output_1 = {};
    type_4 input_1 = {};
    uint count = {};
    uint block_size = {};
    uint local_index = {};
    uint index = {};
    uint offset = {};
    type_4 local_2 = {};
    uint local_3 = {};
    type_4 local_4 = {};
    uint local_5 = {};
    type_4 local_6 = {};
    uint local_7 = {};
    type_4 local_8 = {};
    uint local_9 = {};
    type_4 local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    type_4 local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    type_4 local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    type_4 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_4 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_4 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    output = type_4 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_4 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint count_4 = count_2.value;
    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    type_4 _e20 = output;
    local = _e20;
    type_4 _e23 = input;
    local_1 = _e23;
    count = uint {};
    block_size = uint {};
    local_index = uint {};
    index = uint {};
    offset = uint {};
    local_3 = uint {};
    local_5 = uint {};
    local_7 = uint {};
    local_9 = uint {};
    local_11 = uint {};
    local_12 = uint {};
    type_4 _e47 = local;
    output_1 = _e47;
    type_4 _e49 = local_1;
    input_1 = _e49;
    count = count_4;
    block_size = (2u * 3u) * 2u;
    metal::uint3 _e59 = threadIdx_2;
    metal::uint3 _e62 = threadIdx_2;
    metal::uint3 _e65 = threadIdx_2;
    local_index = _e59.x + (2u * (_e62.y + (3u * _e65.z)));
    metal::uint3 _e75 = blockIdx_2;
    uint _e77 = block_size;
    uint _e79 = local_index;
    index = (_e75.x * _e77) + _e79;
    uint _e82 = index;
    uint _e83 = count;
    if (_e82 < _e83) {
        uint _e85 = index;
        offset = _e85 * 4u;
        type_4 _e90 = input_1;
        local_4 = _e90;
        uint _e92 = index;
        local_5 = _e92;
        type_4 _e94 = local_4;
        local_14 = _e94;
        uint _e96 = local_5;
        uint _e98 = local_14.inner[1];
        local_14.inner[1] = _e98 + _e96;
        uint _e102 = local_14.inner[0];
        local_15 = static_cast<uint>(_e102);
        uint _e106 = local_14.inner[1];
        local_16 = static_cast<uint>(_e106);
        uint _e109 = local_16;
        uint _e112 = input_4[_e109];
        local_17 = _e112;
        uint _e114 = local_17;
        local_13 = _e114;
        uint _e116 = local_13;
        local_12 = _e116;
        uint _e118 = local_12;
        uint _e119 = shifted_7u(_e118);
        type_4 _e121 = output_1;
        local_2 = _e121;
        uint _e123 = offset;
        local_3 = _e123;
        type_4 _e125 = local_2;
        local_18 = _e125;
        uint _e127 = local_3;
        uint _e129 = local_18.inner[1];
        local_18.inner[1] = _e129 + _e127;
        uint _e133 = local_18.inner[0];
        local_19 = static_cast<uint>(_e133);
        uint _e137 = local_18.inner[1];
        local_20 = static_cast<uint>(_e137);
        uint _e140 = local_20;
        output_4[_e140] = _e119;
        uint _e143 = block_size;
        type_4 _e144 = output_1;
        local_6 = _e144;
        uint _e146 = offset;
        local_7 = static_cast<uint>(_e146 + 1u);
        type_4 _e151 = local_6;
        local_21 = _e151;
        uint _e153 = local_7;
        uint _e155 = local_21.inner[1];
        local_21.inner[1] = _e155 + _e153;
        uint _e159 = local_21.inner[0];
        local_22 = static_cast<uint>(_e159);
        uint _e163 = local_21.inner[1];
        local_23 = static_cast<uint>(_e163);
        uint _e166 = local_23;
        output_4[_e166] = _e143;
        uint _e168 = local_index;
        type_4 _e169 = output_1;
        local_8 = _e169;
        uint _e171 = offset;
        local_9 = static_cast<uint>(_e171 + 2u);
        type_4 _e176 = local_8;
        local_24 = _e176;
        uint _e178 = local_9;
        uint _e180 = local_24.inner[1];
        local_24.inner[1] = _e180 + _e178;
        uint _e184 = local_24.inner[0];
        local_25 = static_cast<uint>(_e184);
        uint _e188 = local_24.inner[1];
        local_26 = static_cast<uint>(_e188);
        uint _e191 = local_26;
        output_4[_e191] = _e168;
        metal::uint3 _e194 = blockIdx_2;
        type_4 _e196 = output_1;
        local_10 = _e196;
        uint _e198 = offset;
        local_11 = static_cast<uint>(_e198 + 3u);
        type_4 _e203 = local_10;
        local_27 = _e203;
        uint _e205 = local_11;
        uint _e207 = local_27.inner[1];
        local_27.inner[1] = _e207 + _e205;
        uint _e211 = local_27.inner[0];
        local_28 = static_cast<uint>(_e211);
        uint _e215 = local_27.inner[1];
        local_29 = static_cast<uint>(_e215);
        uint _e218 = local_29;
        output_4[_e218] = _e194.x;
    }
}


struct bounded_template_12uInput {
};
kernel void bounded_template_12u(
  metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, device type_2& output_5 [[user(fake0)]]
, device type_2 const& input_5 [[user(fake0)]]
, constant type_3& count_3 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_2 = {};
    metal::uint3 blockIdx_2 = {};
    type_4 output_2 = {};
    type_4 input_2 = {};
    type_4 local_30 = {};
    type_4 local_31 = {};
    type_4 output_3 = {};
    type_4 input_3 = {};
    uint count_1 = {};
    uint block_size_1 = {};
    uint local_index_1 = {};
    uint index_1 = {};
    uint offset_1 = {};
    type_4 local_32 = {};
    uint local_33 = {};
    type_4 local_34 = {};
    uint local_35 = {};
    type_4 local_36 = {};
    uint local_37 = {};
    type_4 local_38 = {};
    uint local_39 = {};
    type_4 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    type_4 local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_4 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    type_4 local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_4 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_4 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    output_2 = type_4 {};
    output_2.inner[0] = 2u;
    output_2.inner[1] = 0u;
    input_2 = type_4 {};
    input_2.inner[0] = 3u;
    input_2.inner[1] = 0u;
    uint count_5 = count_3.value;
    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    type_4 _e20 = output_2;
    local_30 = _e20;
    type_4 _e23 = input_2;
    local_31 = _e23;
    count_1 = uint {};
    block_size_1 = uint {};
    local_index_1 = uint {};
    index_1 = uint {};
    offset_1 = uint {};
    local_33 = uint {};
    local_35 = uint {};
    local_37 = uint {};
    local_39 = uint {};
    local_41 = uint {};
    local_42 = uint {};
    type_4 _e47 = local_30;
    output_3 = _e47;
    type_4 _e49 = local_31;
    input_3 = _e49;
    count_1 = count_5;
    block_size_1 = (2u * 3u) * 2u;
    metal::uint3 _e59 = threadIdx_2;
    metal::uint3 _e62 = threadIdx_2;
    metal::uint3 _e65 = threadIdx_2;
    local_index_1 = _e59.x + (2u * (_e62.y + (3u * _e65.z)));
    metal::uint3 _e75 = blockIdx_2;
    uint _e77 = block_size_1;
    uint _e79 = local_index_1;
    index_1 = (_e75.x * _e77) + _e79;
    uint _e82 = index_1;
    uint _e83 = count_1;
    if (_e82 < _e83) {
        uint _e85 = index_1;
        offset_1 = _e85 * 4u;
        type_4 _e90 = input_3;
        local_34 = _e90;
        uint _e92 = index_1;
        local_35 = _e92;
        type_4 _e94 = local_34;
        local_44 = _e94;
        uint _e96 = local_35;
        uint _e98 = local_44.inner[1];
        local_44.inner[1] = _e98 + _e96;
        uint _e102 = local_44.inner[0];
        local_45 = static_cast<uint>(_e102);
        uint _e106 = local_44.inner[1];
        local_46 = static_cast<uint>(_e106);
        uint _e109 = local_46;
        uint _e112 = input_5[_e109];
        local_47 = _e112;
        uint _e114 = local_47;
        local_43 = _e114;
        uint _e116 = local_43;
        local_42 = _e116;
        uint _e118 = local_42;
        uint _e119 = shifted_7u(_e118);
        type_4 _e121 = output_3;
        local_32 = _e121;
        uint _e123 = offset_1;
        local_33 = _e123;
        type_4 _e125 = local_32;
        local_48 = _e125;
        uint _e127 = local_33;
        uint _e129 = local_48.inner[1];
        local_48.inner[1] = _e129 + _e127;
        uint _e133 = local_48.inner[0];
        local_49 = static_cast<uint>(_e133);
        uint _e137 = local_48.inner[1];
        local_50 = static_cast<uint>(_e137);
        uint _e140 = local_50;
        output_5[_e140] = _e119;
        uint _e143 = block_size_1;
        type_4 _e144 = output_3;
        local_36 = _e144;
        uint _e146 = offset_1;
        local_37 = static_cast<uint>(_e146 + 1u);
        type_4 _e151 = local_36;
        local_51 = _e151;
        uint _e153 = local_37;
        uint _e155 = local_51.inner[1];
        local_51.inner[1] = _e155 + _e153;
        uint _e159 = local_51.inner[0];
        local_52 = static_cast<uint>(_e159);
        uint _e163 = local_51.inner[1];
        local_53 = static_cast<uint>(_e163);
        uint _e166 = local_53;
        output_5[_e166] = _e143;
        uint _e168 = local_index_1;
        type_4 _e169 = output_3;
        local_38 = _e169;
        uint _e171 = offset_1;
        local_39 = static_cast<uint>(_e171 + 2u);
        type_4 _e176 = local_38;
        local_54 = _e176;
        uint _e178 = local_39;
        uint _e180 = local_54.inner[1];
        local_54.inner[1] = _e180 + _e178;
        uint _e184 = local_54.inner[0];
        local_55 = static_cast<uint>(_e184);
        uint _e188 = local_54.inner[1];
        local_56 = static_cast<uint>(_e188);
        uint _e191 = local_56;
        output_5[_e191] = _e168;
        metal::uint3 _e194 = blockIdx_2;
        type_4 _e196 = output_3;
        local_40 = _e196;
        uint _e198 = offset_1;
        local_41 = static_cast<uint>(_e198 + 3u);
        type_4 _e203 = local_40;
        local_57 = _e203;
        uint _e205 = local_41;
        uint _e207 = local_57.inner[1];
        local_57.inner[1] = _e207 + _e205;
        uint _e211 = local_57.inner[0];
        local_58 = static_cast<uint>(_e211);
        uint _e215 = local_57.inner[1];
        local_59 = static_cast<uint>(_e215);
        uint _e218 = local_59;
        output_5[_e218] = _e194.x;
    }
}
