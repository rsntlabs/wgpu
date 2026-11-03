// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size3;
    uint size4;
};

struct type_1 {
    uint inner[4];
};
typedef uint type_3[1];
struct type_4 {
    uint inner[2];
};
struct type_5 {
    type_4 inner[2];
};

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint phase_exchange_10u(
    uint phase_4,
    uint value_2,
    thread metal::uint3& threadIdx_2,
    threadgroup uint& counter,
    threadgroup type_5& slots_1,
    threadgroup type_1& slots_2
) {
    uint first = {};
    uint second = {};
    uint neighbor = {};
    uint next_4 = {};
    uint next_5 = {};
    uint local_86 = {};
    uint local_87 = {};
    metal::uint3 _e3 = threadIdx_2;
    uint lane_4 = _e3.x;
    if (lane_4 == 0u) {
        if (phase_4 == 0u) {
            counter = (value_2 + 10u) + 40u;
        } else {
            uint _e17 = counter;
            counter = _e17 + (phase_4 * 3u);
        }
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint saved_counter = counter;
    {
        if (phase_4 == 0u) {
            slots_1.inner[naga_div(lane_4, 2u)].inner[naga_mod(lane_4, 2u)] = value_2 + 10u;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        neighbor = naga_mod(lane_4 + 1u, 4u);
        uint _e37 = neighbor;
        uint _e42 = neighbor;
        uint _e46 = slots_1.inner[naga_div(_e37, 2u)].inner[naga_mod(_e42, 2u)];
        next_4 = _e46;
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        if (phase_4 != 0u) {
            uint _e50 = next_4;
            slots_1.inner[naga_div(lane_4, 2u)].inner[naga_mod(lane_4, 2u)] = _e50 + phase_4;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e64 = slots_1.inner[naga_div(lane_4, 2u)].inner[naga_mod(lane_4, 2u)];
        first = _e64;
    }
    {
        if (phase_4 == 0u) {
            slots_2.inner[lane_4] = (value_2 + 10u) + 20u;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e80 = slots_2.inner[naga_mod(lane_4 + 3u, 4u)];
        next_5 = _e80;
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        if (phase_4 != 0u) {
            uint _e86 = next_5;
            slots_2.inner[lane_4] = _e86 + (phase_4 * 2u);
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e90 = slots_2.inner[lane_4];
        second = _e90;
    }
    uint _e92 = second;
    local_86 = 8u;
    uint _e95 = local_86;
    uint _e97 = first;
    local_87 = 16u;
    uint _e101 = local_87;
    uint result_4 = (_e97 | (_e92 << _e95)) | (saved_counter << _e101);
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    return result_4;
}

uint phase_exchange_100u(
    uint phase_5,
    uint value_3,
    thread metal::uint3& threadIdx_2,
    threadgroup uint& counter_1,
    threadgroup type_5& slots_3,
    threadgroup type_1& slots_4
) {
    uint first_1 = {};
    uint second_1 = {};
    uint neighbor_1 = {};
    uint next_6 = {};
    uint next_7 = {};
    uint local_88 = {};
    uint local_89 = {};
    metal::uint3 _e3 = threadIdx_2;
    uint lane_5 = _e3.x;
    if (lane_5 == 0u) {
        if (phase_5 == 0u) {
            counter_1 = (value_3 + 100u) + 40u;
        } else {
            uint _e17 = counter_1;
            counter_1 = _e17 + (phase_5 * 3u);
        }
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint saved_counter_1 = counter_1;
    {
        if (phase_5 == 0u) {
            slots_3.inner[naga_div(lane_5, 2u)].inner[naga_mod(lane_5, 2u)] = value_3 + 100u;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        neighbor_1 = naga_mod(lane_5 + 1u, 4u);
        uint _e37 = neighbor_1;
        uint _e42 = neighbor_1;
        uint _e46 = slots_3.inner[naga_div(_e37, 2u)].inner[naga_mod(_e42, 2u)];
        next_6 = _e46;
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        if (phase_5 != 0u) {
            uint _e50 = next_6;
            slots_3.inner[naga_div(lane_5, 2u)].inner[naga_mod(lane_5, 2u)] = _e50 + phase_5;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e64 = slots_3.inner[naga_div(lane_5, 2u)].inner[naga_mod(lane_5, 2u)];
        first_1 = _e64;
    }
    {
        if (phase_5 == 0u) {
            slots_4.inner[lane_5] = (value_3 + 100u) + 20u;
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e80 = slots_4.inner[naga_mod(lane_5 + 3u, 4u)];
        next_7 = _e80;
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        if (phase_5 != 0u) {
            uint _e86 = next_7;
            slots_4.inner[lane_5] = _e86 + (phase_5 * 2u);
        }
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e90 = slots_4.inner[lane_5];
        second_1 = _e90;
    }
    uint _e92 = second_1;
    local_88 = 8u;
    uint _e95 = local_88;
    uint _e97 = first_1;
    local_89 = 16u;
    uint _e101 = local_89;
    uint result_5 = (_e97 | (_e92 << _e95)) | (saved_counter_1 << _e101);
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    return result_5;
}

struct device_sharedInput {
};
kernel void device_shared(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, threadgroup type_1& slots
, device type_3& output_8 [[user(fake0)]]
, threadgroup uint& counter
, threadgroup type_5& slots_1
, threadgroup type_1& slots_2
, threadgroup uint& counter_1
, threadgroup type_5& slots_3
, threadgroup type_1& slots_4
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_2 = {};
    metal::uint3 blockIdx_2 = {};
    if (__local_invocation_index == 0u) {
        slots = {};
        counter = {};
        slots_1 = {};
        slots_2 = {};
        counter_1 = {};
        slots_3 = {};
        slots_4 = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_4 output = {};
    type_4 local = {};
    type_4 output_1 = {};
    uint value = {};
    uint offset = {};
    type_4 local_1 = {};
    uint local_2 = {};
    type_4 local_3 = {};
    uint local_4 = {};
    type_4 local_5 = {};
    uint local_6 = {};
    type_4 local_7 = {};
    uint local_8 = {};
    type_4 local_9 = {};
    uint local_10 = {};
    type_4 local_11 = {};
    uint local_12 = {};
    type_4 local_13 = {};
    type_4 local_14 = {};
    type_4 output_2 = {};
    uint phase = {};
    uint lane = {};
    uint next = {};
    uint result = {};
    uint offset_1 = {};
    type_4 local_15 = {};
    uint local_16 = {};
    type_4 output_3 = {};
    uint phase_1 = {};
    uint lane_1 = {};
    uint next_1 = {};
    uint result_1 = {};
    uint offset_2 = {};
    type_4 local_17 = {};
    uint local_18 = {};
    type_4 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_4 local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_4 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    type_4 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    type_4 local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    type_4 local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    type_4 local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    type_4 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    output = type_4 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    type_4 _e11 = output;
    local = _e11;
    value = uint {};
    offset = uint {};
    local_2 = uint {};
    local_4 = uint {};
    local_6 = uint {};
    local_8 = uint {};
    local_10 = uint {};
    local_12 = uint {};
    phase = uint {};
    lane = uint {};
    next = uint {};
    result = uint {};
    offset_1 = uint {};
    local_16 = uint {};
    phase_1 = uint {};
    lane_1 = uint {};
    next_1 = uint {};
    result_1 = uint {};
    offset_2 = uint {};
    local_18 = uint {};
    type_4 _e53 = local;
    output_1 = _e53;
    metal::uint3 _e59 = threadIdx_2;
    value = (blockIdx.x * 16u) + _e59.x;
    metal::uint3 _e67 = threadIdx_2;
    offset = ((blockIdx.x * 4u) + _e67.x) * 8u;
    uint _e73 = value;
    uint _e75 = phase_exchange_10u(0u, _e73, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e77 = output_1;
    local_1 = _e77;
    uint _e79 = offset;
    local_2 = _e79;
    type_4 _e81 = local_1;
    local_19 = _e81;
    uint _e83 = local_2;
    uint _e85 = local_19.inner[1];
    local_19.inner[1] = _e85 + _e83;
    uint _e89 = local_19.inner[0];
    local_20 = static_cast<uint>(_e89);
    uint _e93 = local_19.inner[1];
    local_21 = static_cast<uint>(_e93);
    uint _e96 = local_21;
    output_8[_e96] = _e75;
    uint _e99 = value;
    uint _e101 = phase_exchange_100u(0u, _e99, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e102 = output_1;
    local_3 = _e102;
    uint _e104 = offset;
    local_4 = static_cast<uint>(_e104 + 1u);
    type_4 _e109 = local_3;
    local_22 = _e109;
    uint _e111 = local_4;
    uint _e113 = local_22.inner[1];
    local_22.inner[1] = _e113 + _e111;
    uint _e117 = local_22.inner[0];
    local_23 = static_cast<uint>(_e117);
    uint _e121 = local_22.inner[1];
    local_24 = static_cast<uint>(_e121);
    uint _e124 = local_24;
    output_8[_e124] = _e101;
    uint _e128 = phase_exchange_10u(1u, 0u, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e129 = output_1;
    local_5 = _e129;
    uint _e131 = offset;
    local_6 = static_cast<uint>(_e131 + 2u);
    type_4 _e136 = local_5;
    local_25 = _e136;
    uint _e138 = local_6;
    uint _e140 = local_25.inner[1];
    local_25.inner[1] = _e140 + _e138;
    uint _e144 = local_25.inner[0];
    local_26 = static_cast<uint>(_e144);
    uint _e148 = local_25.inner[1];
    local_27 = static_cast<uint>(_e148);
    uint _e151 = local_27;
    output_8[_e151] = _e128;
    uint _e155 = phase_exchange_100u(1u, 0u, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e156 = output_1;
    local_7 = _e156;
    uint _e158 = offset;
    local_8 = static_cast<uint>(_e158 + 3u);
    type_4 _e163 = local_7;
    local_28 = _e163;
    uint _e165 = local_8;
    uint _e167 = local_28.inner[1];
    local_28.inner[1] = _e167 + _e165;
    uint _e171 = local_28.inner[0];
    local_29 = static_cast<uint>(_e171);
    uint _e175 = local_28.inner[1];
    local_30 = static_cast<uint>(_e175);
    uint _e178 = local_30;
    output_8[_e178] = _e155;
    uint _e182 = phase_exchange_10u(2u, 0u, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e183 = output_1;
    local_9 = _e183;
    uint _e185 = offset;
    local_10 = static_cast<uint>(_e185 + 4u);
    type_4 _e190 = local_9;
    local_31 = _e190;
    uint _e192 = local_10;
    uint _e194 = local_31.inner[1];
    local_31.inner[1] = _e194 + _e192;
    uint _e198 = local_31.inner[0];
    local_32 = static_cast<uint>(_e198);
    uint _e202 = local_31.inner[1];
    local_33 = static_cast<uint>(_e202);
    uint _e205 = local_33;
    output_8[_e205] = _e182;
    uint _e209 = phase_exchange_100u(2u, 0u, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e210 = output_1;
    local_11 = _e210;
    uint _e212 = offset;
    local_12 = static_cast<uint>(_e212 + 5u);
    type_4 _e217 = local_11;
    local_34 = _e217;
    uint _e219 = local_12;
    uint _e221 = local_34.inner[1];
    local_34.inner[1] = _e221 + _e219;
    uint _e225 = local_34.inner[0];
    local_35 = static_cast<uint>(_e225);
    uint _e229 = local_34.inner[1];
    local_36 = static_cast<uint>(_e229);
    uint _e232 = local_36;
    output_8[_e232] = _e209;
    type_4 _e234 = output_1;
    local_13 = _e234;
    phase = uint {};
    lane = uint {};
    next = uint {};
    result = uint {};
    offset_1 = uint {};
    local_16 = uint {};
    type_4 _e248 = local_13;
    output_2 = _e248;
    phase = 0u;
    metal::uint3 _e253 = threadIdx_2;
    lane = _e253.x;
    uint _e256 = phase;
    if (_e256 == 0u) {
        uint _e264 = lane;
        uint _e266 = lane;
        slots.inner[_e266] = (700u + (blockIdx.x * 16u)) + _e264;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e269 = lane;
    uint _e276 = slots.inner[naga_mod(_e269 + 1u, 4u)];
    next = _e276;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e278 = phase;
    if (_e278 != 0u) {
        uint _e281 = next;
        uint _e282 = phase;
        uint _e284 = lane;
        slots.inner[_e284] = _e281 + _e282;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e286 = lane;
    uint _e288 = slots.inner[_e286];
    result = _e288;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e293 = lane;
    offset_1 = ((blockIdx.x * 4u) + _e293) * 8u;
    uint _e298 = result;
    type_4 _e300 = output_2;
    local_15 = _e300;
    uint _e302 = offset_1;
    uint _e305 = phase;
    local_16 = static_cast<uint>((_e302 + 6u) + _e305);
    type_4 _e309 = local_15;
    local_37 = _e309;
    uint _e311 = local_16;
    uint _e313 = local_37.inner[1];
    local_37.inner[1] = _e313 + _e311;
    uint _e317 = local_37.inner[0];
    local_38 = static_cast<uint>(_e317);
    uint _e321 = local_37.inner[1];
    local_39 = static_cast<uint>(_e321);
    uint _e324 = local_39;
    output_8[_e324] = _e298;
    type_4 _e326 = output_1;
    local_14 = _e326;
    phase_1 = uint {};
    lane_1 = uint {};
    next_1 = uint {};
    result_1 = uint {};
    offset_2 = uint {};
    local_18 = uint {};
    type_4 _e340 = local_14;
    output_3 = _e340;
    phase_1 = 1u;
    metal::uint3 _e345 = threadIdx_2;
    lane_1 = _e345.x;
    uint _e348 = phase_1;
    if (_e348 == 0u) {
        uint _e356 = lane_1;
        uint _e358 = lane_1;
        slots.inner[_e358] = (700u + (blockIdx.x * 16u)) + _e356;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e361 = lane_1;
    uint _e368 = slots.inner[naga_mod(_e361 + 1u, 4u)];
    next_1 = _e368;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e370 = phase_1;
    if (_e370 != 0u) {
        uint _e373 = next_1;
        uint _e374 = phase_1;
        uint _e376 = lane_1;
        slots.inner[_e376] = _e373 + _e374;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e378 = lane_1;
    uint _e380 = slots.inner[_e378];
    result_1 = _e380;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e385 = lane_1;
    offset_2 = ((blockIdx.x * 4u) + _e385) * 8u;
    uint _e390 = result_1;
    type_4 _e392 = output_3;
    local_17 = _e392;
    uint _e394 = offset_2;
    uint _e397 = phase_1;
    local_18 = static_cast<uint>((_e394 + 6u) + _e397);
    type_4 _e401 = local_17;
    local_40 = _e401;
    uint _e403 = local_18;
    uint _e405 = local_40.inner[1];
    local_40.inner[1] = _e405 + _e403;
    uint _e409 = local_40.inner[0];
    local_41 = static_cast<uint>(_e409);
    uint _e413 = local_40.inner[1];
    local_42 = static_cast<uint>(_e413);
    uint _e416 = local_42;
    output_8[_e416] = _e390;
}


struct forwarded_sharedInput {
};
kernel void forwarded_shared(
  metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, threadgroup type_1& slots
, device type_3& output_9 [[user(fake0)]]
, threadgroup uint& counter
, threadgroup type_5& slots_1
, threadgroup type_1& slots_2
, threadgroup uint& counter_1
, threadgroup type_5& slots_3
, threadgroup type_1& slots_4
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_2 = {};
    metal::uint3 blockIdx_2 = {};
    if (__local_invocation_index == 0u) {
        slots = {};
        counter = {};
        slots_1 = {};
        slots_2 = {};
        counter_1 = {};
        slots_3 = {};
        slots_4 = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_4 output_4 = {};
    type_4 local_43 = {};
    type_4 output_5 = {};
    uint value_1 = {};
    uint offset_3 = {};
    type_4 local_44 = {};
    uint local_45 = {};
    type_4 local_46 = {};
    uint local_47 = {};
    type_4 local_48 = {};
    uint local_49 = {};
    type_4 local_50 = {};
    uint local_51 = {};
    type_4 local_52 = {};
    uint local_53 = {};
    type_4 local_54 = {};
    uint local_55 = {};
    type_4 local_56 = {};
    type_4 local_57 = {};
    type_4 output_6 = {};
    uint phase_2 = {};
    uint lane_2 = {};
    uint next_2 = {};
    uint result_2 = {};
    uint offset_4 = {};
    type_4 local_58 = {};
    uint local_59 = {};
    type_4 output_7 = {};
    uint phase_3 = {};
    uint lane_3 = {};
    uint next_3 = {};
    uint result_3 = {};
    uint offset_5 = {};
    type_4 local_60 = {};
    uint local_61 = {};
    type_4 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_4 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_4 local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    type_4 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    type_4 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_4 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_4 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    type_4 local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    output_4 = type_4 {};
    output_4.inner[0] = 2u;
    output_4.inner[1] = 0u;
    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    type_4 _e11 = output_4;
    local_43 = _e11;
    value_1 = uint {};
    offset_3 = uint {};
    local_45 = uint {};
    local_47 = uint {};
    local_49 = uint {};
    local_51 = uint {};
    local_53 = uint {};
    local_55 = uint {};
    phase_2 = uint {};
    lane_2 = uint {};
    next_2 = uint {};
    result_2 = uint {};
    offset_4 = uint {};
    local_59 = uint {};
    phase_3 = uint {};
    lane_3 = uint {};
    next_3 = uint {};
    result_3 = uint {};
    offset_5 = uint {};
    local_61 = uint {};
    type_4 _e53 = local_43;
    output_5 = _e53;
    metal::uint3 _e59 = threadIdx_2;
    value_1 = (blockIdx_1.x * 16u) + _e59.x;
    metal::uint3 _e67 = threadIdx_2;
    offset_3 = ((blockIdx_1.x * 4u) + _e67.x) * 8u;
    uint _e73 = value_1;
    uint _e75 = phase_exchange_10u(0u, _e73, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e77 = output_5;
    local_44 = _e77;
    uint _e79 = offset_3;
    local_45 = _e79;
    type_4 _e81 = local_44;
    local_62 = _e81;
    uint _e83 = local_45;
    uint _e85 = local_62.inner[1];
    local_62.inner[1] = _e85 + _e83;
    uint _e89 = local_62.inner[0];
    local_63 = static_cast<uint>(_e89);
    uint _e93 = local_62.inner[1];
    local_64 = static_cast<uint>(_e93);
    uint _e96 = local_64;
    output_9[_e96] = _e75;
    uint _e99 = value_1;
    uint _e101 = phase_exchange_100u(0u, _e99, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e102 = output_5;
    local_46 = _e102;
    uint _e104 = offset_3;
    local_47 = static_cast<uint>(_e104 + 1u);
    type_4 _e109 = local_46;
    local_65 = _e109;
    uint _e111 = local_47;
    uint _e113 = local_65.inner[1];
    local_65.inner[1] = _e113 + _e111;
    uint _e117 = local_65.inner[0];
    local_66 = static_cast<uint>(_e117);
    uint _e121 = local_65.inner[1];
    local_67 = static_cast<uint>(_e121);
    uint _e124 = local_67;
    output_9[_e124] = _e101;
    uint _e128 = phase_exchange_10u(1u, 0u, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e129 = output_5;
    local_48 = _e129;
    uint _e131 = offset_3;
    local_49 = static_cast<uint>(_e131 + 2u);
    type_4 _e136 = local_48;
    local_68 = _e136;
    uint _e138 = local_49;
    uint _e140 = local_68.inner[1];
    local_68.inner[1] = _e140 + _e138;
    uint _e144 = local_68.inner[0];
    local_69 = static_cast<uint>(_e144);
    uint _e148 = local_68.inner[1];
    local_70 = static_cast<uint>(_e148);
    uint _e151 = local_70;
    output_9[_e151] = _e128;
    uint _e155 = phase_exchange_100u(1u, 0u, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e156 = output_5;
    local_50 = _e156;
    uint _e158 = offset_3;
    local_51 = static_cast<uint>(_e158 + 3u);
    type_4 _e163 = local_50;
    local_71 = _e163;
    uint _e165 = local_51;
    uint _e167 = local_71.inner[1];
    local_71.inner[1] = _e167 + _e165;
    uint _e171 = local_71.inner[0];
    local_72 = static_cast<uint>(_e171);
    uint _e175 = local_71.inner[1];
    local_73 = static_cast<uint>(_e175);
    uint _e178 = local_73;
    output_9[_e178] = _e155;
    uint _e182 = phase_exchange_10u(2u, 0u, threadIdx_2, counter, slots_1, slots_2);
    type_4 _e183 = output_5;
    local_52 = _e183;
    uint _e185 = offset_3;
    local_53 = static_cast<uint>(_e185 + 4u);
    type_4 _e190 = local_52;
    local_74 = _e190;
    uint _e192 = local_53;
    uint _e194 = local_74.inner[1];
    local_74.inner[1] = _e194 + _e192;
    uint _e198 = local_74.inner[0];
    local_75 = static_cast<uint>(_e198);
    uint _e202 = local_74.inner[1];
    local_76 = static_cast<uint>(_e202);
    uint _e205 = local_76;
    output_9[_e205] = _e182;
    uint _e209 = phase_exchange_100u(2u, 0u, threadIdx_2, counter_1, slots_3, slots_4);
    type_4 _e210 = output_5;
    local_54 = _e210;
    uint _e212 = offset_3;
    local_55 = static_cast<uint>(_e212 + 5u);
    type_4 _e217 = local_54;
    local_77 = _e217;
    uint _e219 = local_55;
    uint _e221 = local_77.inner[1];
    local_77.inner[1] = _e221 + _e219;
    uint _e225 = local_77.inner[0];
    local_78 = static_cast<uint>(_e225);
    uint _e229 = local_77.inner[1];
    local_79 = static_cast<uint>(_e229);
    uint _e232 = local_79;
    output_9[_e232] = _e209;
    type_4 _e234 = output_5;
    local_56 = _e234;
    phase_2 = uint {};
    lane_2 = uint {};
    next_2 = uint {};
    result_2 = uint {};
    offset_4 = uint {};
    local_59 = uint {};
    type_4 _e248 = local_56;
    output_6 = _e248;
    phase_2 = 0u;
    metal::uint3 _e253 = threadIdx_2;
    lane_2 = _e253.x;
    uint _e256 = phase_2;
    if (_e256 == 0u) {
        uint _e264 = lane_2;
        uint _e266 = lane_2;
        slots.inner[_e266] = (700u + (blockIdx_1.x * 16u)) + _e264;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e269 = lane_2;
    uint _e276 = slots.inner[naga_mod(_e269 + 1u, 4u)];
    next_2 = _e276;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e278 = phase_2;
    if (_e278 != 0u) {
        uint _e281 = next_2;
        uint _e282 = phase_2;
        uint _e284 = lane_2;
        slots.inner[_e284] = _e281 + _e282;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e286 = lane_2;
    uint _e288 = slots.inner[_e286];
    result_2 = _e288;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e293 = lane_2;
    offset_4 = ((blockIdx_1.x * 4u) + _e293) * 8u;
    uint _e298 = result_2;
    type_4 _e300 = output_6;
    local_58 = _e300;
    uint _e302 = offset_4;
    uint _e305 = phase_2;
    local_59 = static_cast<uint>((_e302 + 6u) + _e305);
    type_4 _e309 = local_58;
    local_80 = _e309;
    uint _e311 = local_59;
    uint _e313 = local_80.inner[1];
    local_80.inner[1] = _e313 + _e311;
    uint _e317 = local_80.inner[0];
    local_81 = static_cast<uint>(_e317);
    uint _e321 = local_80.inner[1];
    local_82 = static_cast<uint>(_e321);
    uint _e324 = local_82;
    output_9[_e324] = _e298;
    type_4 _e326 = output_5;
    local_57 = _e326;
    phase_3 = uint {};
    lane_3 = uint {};
    next_3 = uint {};
    result_3 = uint {};
    offset_5 = uint {};
    local_61 = uint {};
    type_4 _e340 = local_57;
    output_7 = _e340;
    phase_3 = 1u;
    metal::uint3 _e345 = threadIdx_2;
    lane_3 = _e345.x;
    uint _e348 = phase_3;
    if (_e348 == 0u) {
        uint _e356 = lane_3;
        uint _e358 = lane_3;
        slots.inner[_e358] = (700u + (blockIdx_1.x * 16u)) + _e356;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e361 = lane_3;
    uint _e368 = slots.inner[naga_mod(_e361 + 1u, 4u)];
    next_3 = _e368;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e370 = phase_3;
    if (_e370 != 0u) {
        uint _e373 = next_3;
        uint _e374 = phase_3;
        uint _e376 = lane_3;
        slots.inner[_e376] = _e373 + _e374;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e378 = lane_3;
    uint _e380 = slots.inner[_e378];
    result_3 = _e380;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e385 = lane_3;
    offset_5 = ((blockIdx_1.x * 4u) + _e385) * 8u;
    uint _e390 = result_3;
    type_4 _e392 = output_7;
    local_60 = _e392;
    uint _e394 = offset_5;
    uint _e397 = phase_3;
    local_61 = static_cast<uint>((_e394 + 6u) + _e397);
    type_4 _e401 = local_60;
    local_83 = _e401;
    uint _e403 = local_61;
    uint _e405 = local_83.inner[1];
    local_83.inner[1] = _e405 + _e403;
    uint _e409 = local_83.inner[0];
    local_84 = static_cast<uint>(_e409);
    uint _e413 = local_83.inner[1];
    local_85 = static_cast<uint>(_e413);
    uint _e416 = local_85;
    output_9[_e416] = _e390;
}
