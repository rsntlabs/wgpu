// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];
struct type_3 {
    uint inner[4];
};
struct type_6 {
    uint inner[2];
};

void synchronize(
) {
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    return;
}

uint selected(
) {
    return 7u;
}

uint selected_1(
    int value
) {
    return 13u;
}

void copied_decltype_u0028_nullptr_u0029_(
) {
    return;
}

struct source_nullInput {
};
kernel void source_null(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_2& output_1 [[user(fake0)]]
, threadgroup type_3& values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_6 output = {};
    uint counter = {};
    type_6 pointer = {};
    type_6 local = {};
    type_6 local_1 = {};
    uint local_2 = {};
    type_6 local_3 = {};
    uint local_4 = {};
    type_6 local_5 = {};
    uint local_6 = {};
    type_6 local_7 = {};
    bool local_8 = {};
    type_6 local_9 = {};
    uint local_10 = {};
    type_6 local_11 = {};
    uint local_12 = {};
    type_6 local_13 = {};
    uint local_14 = {};
    type_6 local_15 = {};
    uint local_16 = {};
    type_6 local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    type_6 local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    type_6 local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    type_6 local_26 = {};
    type_6 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    type_6 local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    type_6 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    type_6 local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    type_6 local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    output = type_6 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x;
    counter = 0u;
    copied_decltype_u0028_nullptr_u0029_();
    uint _e10 = counter;
    counter = _e10 + static_cast<uint>(1);
    pointer = type_6 {};
    pointer.inner[0] = 1u;
    values.inner[lane] = lane + 3u;
    synchronize();
    uint base = lane * 8u;
    uint _e27 = values.inner[3u - lane];
    type_6 _e29 = output;
    local = _e29;
    type_6 _e31 = local;
    local_17 = _e31;
    uint _e34 = local_17.inner[1];
    local_17.inner[1] = _e34 + base;
    uint _e38 = local_17.inner[0];
    local_18 = static_cast<uint>(_e38);
    uint _e42 = local_17.inner[1];
    local_19 = static_cast<uint>(_e42);
    uint _e45 = local_19;
    output_1[_e45] = _e27;
    uint _e48 = selected();
    type_6 _e49 = output;
    local_1 = _e49;
    local_2 = static_cast<uint>(base + 1u);
    type_6 _e55 = local_1;
    local_20 = _e55;
    uint _e57 = local_2;
    uint _e59 = local_20.inner[1];
    local_20.inner[1] = _e59 + _e57;
    uint _e63 = local_20.inner[0];
    local_21 = static_cast<uint>(_e63);
    uint _e67 = local_20.inner[1];
    local_22 = static_cast<uint>(_e67);
    uint _e70 = local_22;
    output_1[_e70] = _e48;
    uint _e73 = selected_1(0);
    type_6 _e74 = output;
    local_3 = _e74;
    local_4 = static_cast<uint>(base + 2u);
    type_6 _e80 = local_3;
    local_23 = _e80;
    uint _e82 = local_4;
    uint _e84 = local_23.inner[1];
    local_23.inner[1] = _e84 + _e82;
    uint _e88 = local_23.inner[0];
    local_24 = static_cast<uint>(_e88);
    uint _e92 = local_23.inner[1];
    local_25 = static_cast<uint>(_e92);
    uint _e95 = local_25;
    output_1[_e95] = _e73;
    type_6 _e98 = pointer;
    local_7 = _e98;
    type_6 _e100 = local_7;
    local_26 = _e100;
    uint _e103 = local_26.inner[0];
    local_8 = _e103 == 1u;
    bool _e107 = local_8;
    type_6 _e109 = output;
    local_5 = _e109;
    local_6 = static_cast<uint>(base + 3u);
    type_6 _e115 = local_5;
    local_27 = _e115;
    uint _e117 = local_6;
    uint _e119 = local_27.inner[1];
    local_27.inner[1] = _e119 + _e117;
    uint _e123 = local_27.inner[0];
    local_28 = static_cast<uint>(_e123);
    uint _e127 = local_27.inner[1];
    local_29 = static_cast<uint>(_e127);
    uint _e130 = local_29;
    output_1[_e130] = static_cast<uint>(_e107);
    uint _e132 = counter;
    type_6 _e133 = output;
    local_9 = _e133;
    local_10 = static_cast<uint>(base + 4u);
    type_6 _e139 = local_9;
    local_30 = _e139;
    uint _e141 = local_10;
    uint _e143 = local_30.inner[1];
    local_30.inner[1] = _e143 + _e141;
    uint _e147 = local_30.inner[0];
    local_31 = static_cast<uint>(_e147);
    uint _e151 = local_30.inner[1];
    local_32 = static_cast<uint>(_e151);
    uint _e154 = local_32;
    output_1[_e154] = _e132;
    copied_decltype_u0028_nullptr_u0029_();
    uint _e156 = selected();
    type_6 _e157 = output;
    local_11 = _e157;
    local_12 = static_cast<uint>(base + 5u);
    type_6 _e163 = local_11;
    local_33 = _e163;
    uint _e165 = local_12;
    uint _e167 = local_33.inner[1];
    local_33.inner[1] = _e167 + _e165;
    uint _e171 = local_33.inner[0];
    local_34 = static_cast<uint>(_e171);
    uint _e175 = local_33.inner[1];
    local_35 = static_cast<uint>(_e175);
    uint _e178 = local_35;
    output_1[_e178] = _e156;
    uint _e180 = selected();
    type_6 _e181 = output;
    local_13 = _e181;
    local_14 = static_cast<uint>(base + 6u);
    type_6 _e187 = local_13;
    local_36 = _e187;
    uint _e189 = local_14;
    uint _e191 = local_36.inner[1];
    local_36.inner[1] = _e191 + _e189;
    uint _e195 = local_36.inner[0];
    local_37 = static_cast<uint>(_e195);
    uint _e199 = local_36.inner[1];
    local_38 = static_cast<uint>(_e199);
    uint _e202 = local_38;
    output_1[_e202] = _e180;
    type_6 _e206 = output;
    local_15 = _e206;
    local_16 = static_cast<uint>(base + 7u);
    type_6 _e212 = local_15;
    local_39 = _e212;
    uint _e214 = local_16;
    uint _e216 = local_39.inner[1];
    local_39.inner[1] = _e216 + _e214;
    uint _e220 = local_39.inner[0];
    local_40 = static_cast<uint>(_e220);
    uint _e224 = local_39.inner[1];
    local_41 = static_cast<uint>(_e224);
    uint _e227 = local_41;
    output_1[_e227] = static_cast<uint>(false);
}
