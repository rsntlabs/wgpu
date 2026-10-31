// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];

uint later(
    uint value
) {
    return value + 73u;
}

struct preprocessing_conditionsInput {
};
kernel void preprocessing_conditions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
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
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint counter = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    local = static_cast<uint>(start);
    uint _e8 = local;
    local_24 = static_cast<uint>(_e8);
    uint _e11 = local_24;
    out[_e11] = 7u;
    local_1 = static_cast<uint>(start + 1u);
    uint _e19 = local_1;
    local_25 = static_cast<uint>(_e19);
    uint _e22 = local_25;
    out[_e22] = 11u;
    local_2 = static_cast<uint>(start + 2u);
    uint _e29 = local_2;
    local_26 = static_cast<uint>(_e29);
    uint _e32 = local_26;
    out[_e32] = 13u;
    local_3 = static_cast<uint>(start + 3u);
    uint _e39 = local_3;
    local_27 = static_cast<uint>(_e39);
    uint _e42 = local_27;
    out[_e42] = 17u;
    local_4 = static_cast<uint>(start + 4u);
    uint _e49 = local_4;
    local_28 = static_cast<uint>(_e49);
    uint _e52 = local_28;
    out[_e52] = 19u;
    local_5 = static_cast<uint>(start + 5u);
    uint _e59 = local_5;
    local_29 = static_cast<uint>(_e59);
    uint _e62 = local_29;
    out[_e62] = 23u;
    local_6 = static_cast<uint>(start + 6u);
    uint _e69 = local_6;
    local_30 = static_cast<uint>(_e69);
    uint _e72 = local_30;
    out[_e72] = 29u;
    local_7 = static_cast<uint>(start + 7u);
    uint _e79 = local_7;
    local_31 = static_cast<uint>(_e79);
    uint _e82 = local_31;
    out[_e82] = 31u;
    local_8 = static_cast<uint>(start + 8u);
    uint _e89 = local_8;
    local_32 = static_cast<uint>(_e89);
    uint _e92 = local_32;
    out[_e92] = 37u;
    local_9 = static_cast<uint>(start + 9u);
    uint _e99 = local_9;
    local_33 = static_cast<uint>(_e99);
    uint _e102 = local_33;
    out[_e102] = 41u;
    local_10 = static_cast<uint>(start + 10u);
    uint _e109 = local_10;
    local_34 = static_cast<uint>(_e109);
    uint _e112 = local_34;
    out[_e112] = 43u;
    local_11 = static_cast<uint>(start + 11u);
    uint _e119 = local_11;
    local_35 = static_cast<uint>(_e119);
    uint _e122 = local_35;
    out[_e122] = 47u;
    local_12 = static_cast<uint>(start + 12u);
    uint _e129 = local_12;
    local_36 = static_cast<uint>(_e129);
    uint _e132 = local_36;
    out[_e132] = 53u;
    local_13 = static_cast<uint>(start + 13u);
    uint _e139 = local_13;
    local_37 = static_cast<uint>(_e139);
    uint _e142 = local_37;
    out[_e142] = 59u;
    local_14 = static_cast<uint>(start + 14u);
    uint _e149 = local_14;
    local_38 = static_cast<uint>(_e149);
    uint _e152 = local_38;
    out[_e152] = 61u;
    local_15 = static_cast<uint>(start + 15u);
    uint _e159 = local_15;
    local_39 = static_cast<uint>(_e159);
    uint _e162 = local_39;
    out[_e162] = 67u;
    local_16 = static_cast<uint>(start + 16u);
    uint _e169 = local_16;
    local_40 = static_cast<uint>(_e169);
    uint _e172 = local_40;
    out[_e172] = 71u;
    uint _e175 = later(lane);
    local_17 = static_cast<uint>(start + 17u);
    uint _e180 = local_17;
    local_41 = static_cast<uint>(_e180);
    uint _e183 = local_41;
    out[_e183] = _e175;
    counter = 0u;
    uint _e187 = counter;
    counter = _e187 + static_cast<uint>(1);
    local_18 = static_cast<uint>(start + 18u);
    uint _e195 = local_18;
    local_42 = static_cast<uint>(_e195);
    uint _e198 = local_42;
    out[_e198] = _e187;
    uint _e200 = counter;
    local_19 = static_cast<uint>(start + 19u);
    uint _e205 = local_19;
    local_43 = static_cast<uint>(_e205);
    uint _e208 = local_43;
    out[_e208] = _e200;
    local_20 = static_cast<uint>(start + 20u);
    uint _e216 = local_20;
    local_44 = static_cast<uint>(_e216);
    uint _e219 = local_44;
    out[_e219] = static_cast<uint>(true);
    local_21 = static_cast<uint>(start + 21u);
    uint _e225 = local_21;
    local_45 = static_cast<uint>(_e225);
    uint _e228 = local_45;
    out[_e228] = lane;
    local_22 = static_cast<uint>(start + 22u);
    uint _e237 = local_22;
    local_46 = static_cast<uint>(_e237);
    uint _e240 = local_46;
    out[_e240] = as_type<uint>(-(0.0));
    local_23 = static_cast<uint>(start + 23u);
    uint _e246 = local_23;
    local_47 = static_cast<uint>(_e246);
    uint _e249 = local_47;
    out[_e249] = 4294967295u;
}
