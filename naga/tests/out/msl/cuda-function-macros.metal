// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct Pair_cuda_record_0_ {
    uint first;
    uint second;
};
typedef uint type_1[1];
struct type_3 {
    uint inner[3];
};

uint advance(
    uint value
) {
    return value + 3u;
}

struct function_macrosInput {
};
kernel void function_macros(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Pair_cuda_record_0_ pair = {};
    Pair_cuda_record_0_ local = {};
    type_3 values = {};
    metal::uint2 vector = {};
    uint counter = {};
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
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint declared = {};
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
    uint local_48 = {};
    uint local_49 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    uint start = lane * 24u;
    local.first = 11u;
    local.second = 13u;
    Pair_cuda_record_0_ _e11 = local;
    pair = _e11;
    values.inner[0] = 2u;
    values.inner[1] = 3u;
    values.inner[2] = 5u;
    vector = metal::uint2(17u, 19u);
    counter = 0u;
    local_1 = static_cast<uint>(start);
    uint _e28 = local_1;
    local_26 = static_cast<uint>(_e28);
    uint _e31 = local_26;
    out[_e31] = 7u;
    local_2 = static_cast<uint>(start + 1u);
    uint _e39 = local_2;
    local_27 = static_cast<uint>(_e39);
    uint _e42 = local_27;
    out[_e42] = 11u;
    local_3 = static_cast<uint>(start + 2u);
    uint _e52 = local_3;
    local_28 = static_cast<uint>(_e52);
    uint _e55 = local_28;
    out[_e55] = 2u + 3u;
    local_4 = static_cast<uint>(start + 3u);
    uint _e66 = local_4;
    local_29 = static_cast<uint>(_e66);
    uint _e69 = local_29;
    out[_e69] = (1u + 2u) * 3u;
    local_5 = static_cast<uint>(start + 4u);
    uint _e78 = local_5;
    local_30 = static_cast<uint>(_e78);
    uint _e81 = local_30;
    out[_e81] = 5u + 6u;
    local_6 = static_cast<uint>(start + 5u);
    uint _e90 = local_6;
    local_31 = static_cast<uint>(_e90);
    uint _e93 = local_31;
    out[_e93] = 7u + 8u;
    uint _e96 = pair.first;
    local_7 = static_cast<uint>(start + 6u);
    uint _e101 = local_7;
    local_32 = static_cast<uint>(_e101);
    uint _e104 = local_32;
    out[_e104] = _e96;
    uint _e107 = pair.second;
    local_8 = static_cast<uint>(start + 7u);
    uint _e112 = local_8;
    local_33 = static_cast<uint>(_e112);
    uint _e115 = local_33;
    out[_e115] = _e107;
    local_9 = static_cast<uint>(start + 8u);
    uint _e123 = local_9;
    local_34 = static_cast<uint>(_e123);
    uint _e126 = local_34;
    out[_e126] = static_cast<uint>(3);
    uint _e129 = values.inner[lane];
    local_10 = static_cast<uint>(start + 9u);
    uint _e134 = local_10;
    local_35 = static_cast<uint>(_e134);
    uint _e137 = local_35;
    out[_e137] = _e129;
    uint _e140 = vector.x;
    local_11 = static_cast<uint>(start + 10u);
    uint _e145 = local_11;
    local_36 = static_cast<uint>(_e145);
    uint _e148 = local_36;
    out[_e148] = _e140;
    uint _e151 = vector.y;
    local_12 = static_cast<uint>(start + 11u);
    uint _e156 = local_12;
    local_37 = static_cast<uint>(_e156);
    uint _e159 = local_37;
    out[_e159] = _e151;
    uint _e161 = counter;
    counter = _e161 + static_cast<uint>(1);
    uint _e165 = counter;
    counter = _e165 + static_cast<uint>(1);
    local_13 = static_cast<uint>(start + 12u);
    uint _e173 = local_13;
    local_38 = static_cast<uint>(_e173);
    uint _e176 = local_38;
    out[_e176] = _e165;
    uint _e178 = counter;
    local_14 = static_cast<uint>(start + 13u);
    uint _e183 = local_14;
    local_39 = static_cast<uint>(_e183);
    uint _e186 = local_39;
    out[_e186] = _e178;
    local_15 = static_cast<uint>(start + 14u);
    uint _e192 = local_15;
    local_40 = static_cast<uint>(_e192);
    uint _e195 = local_40;
    out[_e195] = 19u;
    uint _e198 = counter;
    local_16 = static_cast<uint>(start + 15u);
    uint _e203 = local_16;
    local_41 = static_cast<uint>(_e203);
    uint _e206 = local_41;
    out[_e206] = _e198;
    values.inner[0] = 23u;
    uint _e211 = values.inner[0];
    local_17 = static_cast<uint>(start + 16u);
    uint _e216 = local_17;
    local_42 = static_cast<uint>(_e216);
    uint _e219 = local_42;
    out[_e219] = _e211;
    uint _e223 = values.inner[0];
    local_18 = static_cast<uint>(start + 17u);
    uint _e228 = local_18;
    local_43 = static_cast<uint>(_e228);
    uint _e231 = local_43;
    out[_e231] = _e223;
    if (lane == 0u) {
        local_20 = 29u;
    } else {
        local_20 = 31u;
    }
    uint _e240 = local_20;
    local_19 = static_cast<uint>(start + 18u);
    uint _e245 = local_19;
    local_44 = static_cast<uint>(_e245);
    uint _e248 = local_44;
    out[_e248] = _e240;
    uint _e250 = advance(lane);
    local_21 = static_cast<uint>(start + 19u);
    uint _e255 = local_21;
    local_45 = static_cast<uint>(_e255);
    uint _e258 = local_45;
    out[_e258] = _e250;
    declared = 37u;
    uint _e262 = declared;
    local_22 = static_cast<uint>(start + 20u);
    uint _e267 = local_22;
    local_46 = static_cast<uint>(_e267);
    uint _e270 = local_46;
    out[_e270] = _e262;
    local_23 = static_cast<uint>(start + 21u);
    uint _e279 = local_23;
    local_47 = static_cast<uint>(_e279);
    uint _e282 = local_47;
    out[_e282] = as_type<uint>(-(0.0));
    local_24 = static_cast<uint>(start + 22u);
    uint _e288 = local_24;
    local_48 = static_cast<uint>(_e288);
    uint _e291 = local_48;
    out[_e291] = 4294967295u;
    local_25 = static_cast<uint>(start + 23u);
    uint _e300 = local_25;
    local_49 = static_cast<uint>(_e300);
    uint _e303 = local_49;
    out[_e303] = 41u + lane;
}
