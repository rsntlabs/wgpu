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
struct type_6 {
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
, device type_1& output_1 [[user(fake0)]]
, threadgroup type_3& values
, threadgroup float3_& broadcast
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        broadcast = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_6 output = {};
    float3_ copied = {};
    int offset = {};
    type_6 local = {};
    uint local_1 = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    type_6 local_6 = {};
    uint local_7 = {};
    type_6 local_8 = {};
    uint local_9 = {};
    type_6 local_10 = {};
    uint local_11 = {};
    type_6 local_12 = {};
    uint local_13 = {};
    type_6 local_14 = {};
    uint local_15 = {};
    type_6 local_16 = {};
    uint local_17 = {};
    type_6 local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    type_6 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_6 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
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
    type_6 local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    output = type_6 {};
    output.inner[0] = 0u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint group = blockIdx.x;
    float base = static_cast<float>((group * 16u) + lane);
    values.inner[lane] = float3_ {base + 0.5, -(base) - 1.25, base + 2.5};
    if (lane == 0u) {
        broadcast = float3_ {static_cast<float>(group) + 0.25, static_cast<float>(group) + 0.5, static_cast<float>(group) + 0.75};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint next = naga_mod(lane + 1u, 8u);
    float3_ _e42 = values.inner[next];
    float3_ _e43 = shift(_e42);
    copied = _e43;
    {
        offset = 1;
        int _e47 = offset;
        float _e49 = copied.x;
        copied.x = _e49 + static_cast<float>(_e47);
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    bool choose_shared = (lane & 1u) != 0u;
    float _e58 = broadcast.x;
    if (choose_shared) {
        float _e61 = values.inner[lane].y;
        values.inner[lane].y = _e61 + _e58;
    } else {
        float _e64 = copied.y;
        copied.y = _e64 + _e58;
    }
    float _e67 = copied.x;
    values.inner[lane].z = _e67;
    uint row = ((group * 8u) + lane) * 9u;
    float _e76 = copied.x;
    type_6 _e78 = output;
    local = _e78;
    local_1 = static_cast<uint>(row);
    type_6 _e82 = local;
    local_18 = _e82;
    uint _e84 = local_1;
    uint _e86 = local_18.inner[1];
    local_18.inner[1] = _e86 + _e84;
    uint _e90 = local_18.inner[0];
    local_19 = static_cast<uint>(_e90);
    uint _e94 = local_18.inner[1];
    local_20 = static_cast<uint>(_e94);
    uint _e97 = local_20;
    output_1[_e97] = _e76;
    float _e101 = copied.y;
    type_6 _e102 = output;
    local_2 = _e102;
    local_3 = static_cast<uint>(row + 1u);
    type_6 _e108 = local_2;
    local_21 = _e108;
    uint _e110 = local_3;
    uint _e112 = local_21.inner[1];
    local_21.inner[1] = _e112 + _e110;
    uint _e116 = local_21.inner[0];
    local_22 = static_cast<uint>(_e116);
    uint _e120 = local_21.inner[1];
    local_23 = static_cast<uint>(_e120);
    uint _e123 = local_23;
    output_1[_e123] = _e101;
    float _e126 = copied.z;
    type_6 _e127 = output;
    local_4 = _e127;
    local_5 = static_cast<uint>(row + 2u);
    type_6 _e133 = local_4;
    local_24 = _e133;
    uint _e135 = local_5;
    uint _e137 = local_24.inner[1];
    local_24.inner[1] = _e137 + _e135;
    uint _e141 = local_24.inner[0];
    local_25 = static_cast<uint>(_e141);
    uint _e145 = local_24.inner[1];
    local_26 = static_cast<uint>(_e145);
    uint _e148 = local_26;
    output_1[_e148] = _e126;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    float _e152 = values.inner[next].x;
    type_6 _e153 = output;
    local_6 = _e153;
    local_7 = static_cast<uint>(row + 3u);
    type_6 _e159 = local_6;
    local_27 = _e159;
    uint _e161 = local_7;
    uint _e163 = local_27.inner[1];
    local_27.inner[1] = _e163 + _e161;
    uint _e167 = local_27.inner[0];
    local_28 = static_cast<uint>(_e167);
    uint _e171 = local_27.inner[1];
    local_29 = static_cast<uint>(_e171);
    uint _e174 = local_29;
    output_1[_e174] = _e152;
    float _e178 = values.inner[next].y;
    type_6 _e179 = output;
    local_8 = _e179;
    local_9 = static_cast<uint>(row + 4u);
    type_6 _e185 = local_8;
    local_30 = _e185;
    uint _e187 = local_9;
    uint _e189 = local_30.inner[1];
    local_30.inner[1] = _e189 + _e187;
    uint _e193 = local_30.inner[0];
    local_31 = static_cast<uint>(_e193);
    uint _e197 = local_30.inner[1];
    local_32 = static_cast<uint>(_e197);
    uint _e200 = local_32;
    output_1[_e200] = _e178;
    float _e204 = values.inner[next].z;
    type_6 _e205 = output;
    local_10 = _e205;
    local_11 = static_cast<uint>(row + 5u);
    type_6 _e211 = local_10;
    local_33 = _e211;
    uint _e213 = local_11;
    uint _e215 = local_33.inner[1];
    local_33.inner[1] = _e215 + _e213;
    uint _e219 = local_33.inner[0];
    local_34 = static_cast<uint>(_e219);
    uint _e223 = local_33.inner[1];
    local_35 = static_cast<uint>(_e223);
    uint _e226 = local_35;
    output_1[_e226] = _e204;
    float _e229 = broadcast.x;
    type_6 _e230 = output;
    local_12 = _e230;
    local_13 = static_cast<uint>(row + 6u);
    type_6 _e236 = local_12;
    local_36 = _e236;
    uint _e238 = local_13;
    uint _e240 = local_36.inner[1];
    local_36.inner[1] = _e240 + _e238;
    uint _e244 = local_36.inner[0];
    local_37 = static_cast<uint>(_e244);
    uint _e248 = local_36.inner[1];
    local_38 = static_cast<uint>(_e248);
    uint _e251 = local_38;
    output_1[_e251] = _e229;
    float _e254 = broadcast.y;
    type_6 _e255 = output;
    local_14 = _e255;
    local_15 = static_cast<uint>(row + 7u);
    type_6 _e261 = local_14;
    local_39 = _e261;
    uint _e263 = local_15;
    uint _e265 = local_39.inner[1];
    local_39.inner[1] = _e265 + _e263;
    uint _e269 = local_39.inner[0];
    local_40 = static_cast<uint>(_e269);
    uint _e273 = local_39.inner[1];
    local_41 = static_cast<uint>(_e273);
    uint _e276 = local_41;
    output_1[_e276] = _e254;
    float _e279 = broadcast.z;
    type_6 _e280 = output;
    local_16 = _e280;
    local_17 = static_cast<uint>(row + 8u);
    type_6 _e286 = local_16;
    local_42 = _e286;
    uint _e288 = local_17;
    uint _e290 = local_42.inner[1];
    local_42.inner[1] = _e290 + _e288;
    uint _e294 = local_42.inner[0];
    local_43 = static_cast<uint>(_e294);
    uint _e298 = local_42.inner[1];
    local_44 = static_cast<uint>(_e298);
    uint _e301 = local_44;
    output_1[_e301] = _e279;
}
