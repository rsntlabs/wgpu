// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef float type_1[1];
struct type_3 {
    float3_ inner[8];
};
struct type_7 {
    uint inner[2];
};

float3_ shift(
    float3_ value
) {
    float3_ value_1 = {};
    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = _e4 + 1.0;
    float _e9 = value_1.z;
    float _e10 = value_1.y;
    value_1.y = _e9 - _e10;
    float3_ _e12 = value_1;
    return _e12;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct shared_vectorsInput {
};
kernel void shared_vectors(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& output [[user(fake0)]]
, threadgroup type_3& values
, threadgroup float3_& broadcast
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        broadcast = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_7 local = {};
    uint lane = {};
    uint group = {};
    float base = {};
    uint next = {};
    float3_ copied = {};
    int offset = {};
    bool choose_shared = {};
    uint row = {};
    type_7 local_1 = {};
    uint local_2 = {};
    type_7 local_3 = {};
    uint local_4 = {};
    type_7 local_5 = {};
    uint local_6 = {};
    type_7 local_7 = {};
    uint local_8 = {};
    type_7 local_9 = {};
    uint local_10 = {};
    type_7 local_11 = {};
    uint local_12 = {};
    type_7 local_13 = {};
    uint local_14 = {};
    type_7 local_15 = {};
    uint local_16 = {};
    type_7 local_17 = {};
    uint local_18 = {};
    type_7 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_7 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    type_7 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    type_7 local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    type_7 local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    type_7 local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    type_7 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    type_7 local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    local = type_7 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    lane = threadIdx.x;
    group = blockIdx.x;
    uint _e13 = group;
    uint _e16 = lane;
    base = static_cast<float>((_e13 * 16u) + _e16);
    float _e20 = base;
    float _e23 = base;
    float _e27 = base;
    uint _e31 = lane;
    values.inner[_e31] = float3_ {_e20 + 0.5, -(_e23) - 1.25, _e27 + 2.5};
    uint _e34 = lane;
    if (_e34 == 0u) {
        uint _e37 = group;
        uint _e41 = group;
        uint _e45 = group;
        broadcast = float3_ {static_cast<float>(_e37) + 0.25, static_cast<float>(_e41) + 0.5, static_cast<float>(_e45) + 0.75};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e51 = lane;
    next = naga_mod(_e51 + 1u, 8u);
    uint _e57 = next;
    float3_ _e59 = values.inner[_e57];
    float3_ _e60 = shift(_e59);
    copied = _e60;
    {
        offset = 1;
        int _e64 = offset;
        float _e66 = copied.x;
        copied.x = _e66 + static_cast<float>(_e64);
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e69 = lane;
    choose_shared = (_e69 & 1u) != 0u;
    float _e77 = broadcast.x;
    bool _e78 = choose_shared;
    if (_e78) {
        uint _e79 = lane;
        float _e82 = values.inner[_e79].y;
        values.inner[_e79].y = _e82 + _e77;
    } else {
        float _e85 = copied.y;
        copied.y = _e85 + _e77;
    }
    float _e88 = copied.x;
    uint _e89 = lane;
    values.inner[_e89].z = _e88;
    uint _e92 = group;
    uint _e95 = lane;
    row = ((_e92 * 8u) + _e95) * 9u;
    float _e101 = copied.x;
    type_7 _e104 = local;
    local_1 = _e104;
    uint _e105 = row;
    local_2 = static_cast<uint>(_e105);
    type_7 _e109 = local_1;
    local_19 = _e109;
    uint _e110 = local_2;
    uint _e112 = local_19.inner[1];
    local_19.inner[1] = _e112 + _e110;
    uint _e116 = local_19.inner[0];
    local_20 = static_cast<uint>(_e116);
    uint _e120 = local_19.inner[1];
    local_21 = static_cast<uint>(_e120);
    uint _e123 = local_21;
    output[_e123] = _e101;
    float _e126 = copied.y;
    type_7 _e128 = local;
    local_3 = _e128;
    uint _e129 = row;
    local_4 = static_cast<uint>(_e129 + 1u);
    type_7 _e135 = local_3;
    local_22 = _e135;
    uint _e136 = local_4;
    uint _e138 = local_22.inner[1];
    local_22.inner[1] = _e138 + _e136;
    uint _e142 = local_22.inner[0];
    local_23 = static_cast<uint>(_e142);
    uint _e146 = local_22.inner[1];
    local_24 = static_cast<uint>(_e146);
    uint _e149 = local_24;
    output[_e149] = _e126;
    float _e152 = copied.z;
    type_7 _e154 = local;
    local_5 = _e154;
    uint _e155 = row;
    local_6 = static_cast<uint>(_e155 + 2u);
    type_7 _e161 = local_5;
    local_25 = _e161;
    uint _e162 = local_6;
    uint _e164 = local_25.inner[1];
    local_25.inner[1] = _e164 + _e162;
    uint _e168 = local_25.inner[0];
    local_26 = static_cast<uint>(_e168);
    uint _e172 = local_25.inner[1];
    local_27 = static_cast<uint>(_e172);
    uint _e175 = local_27;
    output[_e175] = _e152;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e177 = next;
    float _e180 = values.inner[_e177].x;
    type_7 _e182 = local;
    local_7 = _e182;
    uint _e183 = row;
    local_8 = static_cast<uint>(_e183 + 3u);
    type_7 _e189 = local_7;
    local_28 = _e189;
    uint _e190 = local_8;
    uint _e192 = local_28.inner[1];
    local_28.inner[1] = _e192 + _e190;
    uint _e196 = local_28.inner[0];
    local_29 = static_cast<uint>(_e196);
    uint _e200 = local_28.inner[1];
    local_30 = static_cast<uint>(_e200);
    uint _e203 = local_30;
    output[_e203] = _e180;
    uint _e205 = next;
    float _e208 = values.inner[_e205].y;
    type_7 _e210 = local;
    local_9 = _e210;
    uint _e211 = row;
    local_10 = static_cast<uint>(_e211 + 4u);
    type_7 _e217 = local_9;
    local_31 = _e217;
    uint _e218 = local_10;
    uint _e220 = local_31.inner[1];
    local_31.inner[1] = _e220 + _e218;
    uint _e224 = local_31.inner[0];
    local_32 = static_cast<uint>(_e224);
    uint _e228 = local_31.inner[1];
    local_33 = static_cast<uint>(_e228);
    uint _e231 = local_33;
    output[_e231] = _e208;
    uint _e233 = next;
    float _e236 = values.inner[_e233].z;
    type_7 _e238 = local;
    local_11 = _e238;
    uint _e239 = row;
    local_12 = static_cast<uint>(_e239 + 5u);
    type_7 _e245 = local_11;
    local_34 = _e245;
    uint _e246 = local_12;
    uint _e248 = local_34.inner[1];
    local_34.inner[1] = _e248 + _e246;
    uint _e252 = local_34.inner[0];
    local_35 = static_cast<uint>(_e252);
    uint _e256 = local_34.inner[1];
    local_36 = static_cast<uint>(_e256);
    uint _e259 = local_36;
    output[_e259] = _e236;
    float _e262 = broadcast.x;
    type_7 _e264 = local;
    local_13 = _e264;
    uint _e265 = row;
    local_14 = static_cast<uint>(_e265 + 6u);
    type_7 _e271 = local_13;
    local_37 = _e271;
    uint _e272 = local_14;
    uint _e274 = local_37.inner[1];
    local_37.inner[1] = _e274 + _e272;
    uint _e278 = local_37.inner[0];
    local_38 = static_cast<uint>(_e278);
    uint _e282 = local_37.inner[1];
    local_39 = static_cast<uint>(_e282);
    uint _e285 = local_39;
    output[_e285] = _e262;
    float _e288 = broadcast.y;
    type_7 _e290 = local;
    local_15 = _e290;
    uint _e291 = row;
    local_16 = static_cast<uint>(_e291 + 7u);
    type_7 _e297 = local_15;
    local_40 = _e297;
    uint _e298 = local_16;
    uint _e300 = local_40.inner[1];
    local_40.inner[1] = _e300 + _e298;
    uint _e304 = local_40.inner[0];
    local_41 = static_cast<uint>(_e304);
    uint _e308 = local_40.inner[1];
    local_42 = static_cast<uint>(_e308);
    uint _e311 = local_42;
    output[_e311] = _e288;
    float _e314 = broadcast.z;
    type_7 _e316 = local;
    local_17 = _e316;
    uint _e317 = row;
    local_18 = static_cast<uint>(_e317 + 8u);
    type_7 _e323 = local_17;
    local_43 = _e323;
    uint _e324 = local_18;
    uint _e326 = local_43.inner[1];
    local_43.inner[1] = _e326 + _e324;
    uint _e330 = local_43.inner[0];
    local_44 = static_cast<uint>(_e330);
    uint _e334 = local_43.inner[1];
    local_45 = static_cast<uint>(_e334);
    uint _e337 = local_45;
    output[_e337] = _e314;
}
