groupshared uint slots[4];
static uint3 threadIdx_2 = (uint3)0;
static uint3 blockIdx_2 = (uint3)0;
RWByteAddressBuffer output_8 : register(u0);
RWByteAddressBuffer output_9 : register(u0);
groupshared uint counter;
groupshared uint slots_1[2][2];
groupshared uint slots_2[4];
groupshared uint counter_1;
groupshared uint slots_3[2][2];
groupshared uint slots_4[4];

uint naga_div(uint lhs, uint rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint phase_exchange_10u(uint phase_4, uint value_2)
{
    uint first = (uint)0;
    uint second = (uint)0;
    uint neighbor = (uint)0;
    uint next_4 = (uint)0;
    uint next_5 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;

    uint3 _e3 = threadIdx_2;
    uint lane_4 = _e3.x;
    if ((lane_4 == 0u)) {
        if ((phase_4 == 0u)) {
            counter = ((value_2 + 10u) + 40u);
        } else {
            uint _e17 = counter;
            counter = (_e17 + (phase_4 * 3u));
        }
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint saved_counter = counter;
    {
        if ((phase_4 == 0u)) {
            slots_1[min(uint(naga_div(lane_4, 2u)), 1u)][min(uint(naga_mod(lane_4, 2u)), 1u)] = (value_2 + 10u);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        neighbor = naga_mod((lane_4 + 1u), 4u);
        uint _e37 = neighbor;
        uint _e42 = neighbor;
        uint _e46 = slots_1[min(uint(naga_div(_e37, 2u)), 1u)][min(uint(naga_mod(_e42, 2u)), 1u)];
        next_4 = _e46;
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        if ((phase_4 != 0u)) {
            uint _e50 = next_4;
            slots_1[min(uint(naga_div(lane_4, 2u)), 1u)][min(uint(naga_mod(lane_4, 2u)), 1u)] = (_e50 + phase_4);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e64 = slots_1[min(uint(naga_div(lane_4, 2u)), 1u)][min(uint(naga_mod(lane_4, 2u)), 1u)];
        first = _e64;
    }
    {
        if ((phase_4 == 0u)) {
            slots_2[min(uint(lane_4), 3u)] = ((value_2 + 10u) + 20u);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e80 = slots_2[min(uint(naga_mod((lane_4 + 3u), 4u)), 3u)];
        next_5 = _e80;
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        if ((phase_4 != 0u)) {
            uint _e86 = next_5;
            slots_2[min(uint(lane_4), 3u)] = (_e86 + (phase_4 * 2u));
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e90 = slots_2[min(uint(lane_4), 3u)];
        second = _e90;
    }
    uint _e92 = second;
    local_86 = 8u;
    uint _e95 = local_86;
    uint _e97 = first;
    local_87 = 16u;
    uint _e101 = local_87;
    uint result_4 = ((_e97 | (_e92 << _e95)) | (saved_counter << _e101));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    return result_4;
}

uint phase_exchange_100u(uint phase_5, uint value_3)
{
    uint first_1 = (uint)0;
    uint second_1 = (uint)0;
    uint neighbor_1 = (uint)0;
    uint next_6 = (uint)0;
    uint next_7 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;

    uint3 _e3 = threadIdx_2;
    uint lane_5 = _e3.x;
    if ((lane_5 == 0u)) {
        if ((phase_5 == 0u)) {
            counter_1 = ((value_3 + 100u) + 40u);
        } else {
            uint _e17 = counter_1;
            counter_1 = (_e17 + (phase_5 * 3u));
        }
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint saved_counter_1 = counter_1;
    {
        if ((phase_5 == 0u)) {
            slots_3[min(uint(naga_div(lane_5, 2u)), 1u)][min(uint(naga_mod(lane_5, 2u)), 1u)] = (value_3 + 100u);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        neighbor_1 = naga_mod((lane_5 + 1u), 4u);
        uint _e37 = neighbor_1;
        uint _e42 = neighbor_1;
        uint _e46 = slots_3[min(uint(naga_div(_e37, 2u)), 1u)][min(uint(naga_mod(_e42, 2u)), 1u)];
        next_6 = _e46;
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        if ((phase_5 != 0u)) {
            uint _e50 = next_6;
            slots_3[min(uint(naga_div(lane_5, 2u)), 1u)][min(uint(naga_mod(lane_5, 2u)), 1u)] = (_e50 + phase_5);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e64 = slots_3[min(uint(naga_div(lane_5, 2u)), 1u)][min(uint(naga_mod(lane_5, 2u)), 1u)];
        first_1 = _e64;
    }
    {
        if ((phase_5 == 0u)) {
            slots_4[min(uint(lane_5), 3u)] = ((value_3 + 100u) + 20u);
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e80 = slots_4[min(uint(naga_mod((lane_5 + 3u), 4u)), 3u)];
        next_7 = _e80;
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        if ((phase_5 != 0u)) {
            uint _e86 = next_7;
            slots_4[min(uint(lane_5), 3u)] = (_e86 + (phase_5 * 2u));
        }
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e90 = slots_4[min(uint(lane_5), 3u)];
        second_1 = _e90;
    }
    uint _e92 = second_1;
    local_88 = 8u;
    uint _e95 = local_88;
    uint _e97 = first_1;
    local_89 = 16u;
    uint _e101 = local_89;
    uint result_5 = ((_e97 | (_e92 << _e95)) | (saved_counter_1 << _e101));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    return result_5;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void device_shared(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        slots = (uint[4])0;
        counter = (uint)0;
        slots_1 = (uint[2][2])0;
        slots_2 = (uint[4])0;
        counter_1 = (uint)0;
        slots_3 = (uint[2][2])0;
        slots_4 = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint output_1[2] = (uint[2])0;
    uint value = (uint)0;
    uint offset = (uint)0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14[2] = (uint[2])0;
    uint output_2[2] = (uint[2])0;
    uint phase = (uint)0;
    uint lane = (uint)0;
    uint next = (uint)0;
    uint result = (uint)0;
    uint offset_1 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint output_3[2] = (uint[2])0;
    uint phase_1 = (uint)0;
    uint lane_1 = (uint)0;
    uint next_1 = (uint)0;
    uint result_1 = (uint)0;
    uint offset_2 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    uint _e11[2] = output;
    local = _e11;
    value = ZeroValueuint();
    offset = ZeroValueuint();
    local_2 = ZeroValueuint();
    local_4 = ZeroValueuint();
    local_6 = ZeroValueuint();
    local_8 = ZeroValueuint();
    local_10 = ZeroValueuint();
    local_12 = ZeroValueuint();
    phase = ZeroValueuint();
    lane = ZeroValueuint();
    next = ZeroValueuint();
    result = ZeroValueuint();
    offset_1 = ZeroValueuint();
    local_16 = ZeroValueuint();
    phase_1 = ZeroValueuint();
    lane_1 = ZeroValueuint();
    next_1 = ZeroValueuint();
    result_1 = ZeroValueuint();
    offset_2 = ZeroValueuint();
    local_18 = ZeroValueuint();
    uint _e53[2] = local;
    output_1 = _e53;
    uint3 _e59 = threadIdx_2;
    value = ((blockIdx.x * 16u) + _e59.x);
    uint3 _e67 = threadIdx_2;
    offset = (((blockIdx.x * 4u) + _e67.x) * 8u);
    uint _e73 = value;
    const uint _e75 = phase_exchange_10u(0u, _e73);
    uint _e77[2] = output_1;
    local_1 = _e77;
    uint _e79 = offset;
    local_2 = _e79;
    uint _e81[2] = local_1;
    local_19 = _e81;
    uint _e83 = local_2;
    uint _e85 = local_19[1];
    local_19[1] = (_e85 + _e83);
    uint _e89 = local_19[0];
    local_20 = uint(_e89);
    uint _e93 = local_19[1];
    local_21 = uint(_e93);
    uint _e96 = local_21;
    output_8.Store(_e96*4, asuint(_e75));
    uint _e99 = value;
    const uint _e101 = phase_exchange_100u(0u, _e99);
    uint _e102[2] = output_1;
    local_3 = _e102;
    uint _e104 = offset;
    local_4 = uint((_e104 + 1u));
    uint _e109[2] = local_3;
    local_22 = _e109;
    uint _e111 = local_4;
    uint _e113 = local_22[1];
    local_22[1] = (_e113 + _e111);
    uint _e117 = local_22[0];
    local_23 = uint(_e117);
    uint _e121 = local_22[1];
    local_24 = uint(_e121);
    uint _e124 = local_24;
    output_8.Store(_e124*4, asuint(_e101));
    const uint _e128 = phase_exchange_10u(1u, 0u);
    uint _e129[2] = output_1;
    local_5 = _e129;
    uint _e131 = offset;
    local_6 = uint((_e131 + 2u));
    uint _e136[2] = local_5;
    local_25 = _e136;
    uint _e138 = local_6;
    uint _e140 = local_25[1];
    local_25[1] = (_e140 + _e138);
    uint _e144 = local_25[0];
    local_26 = uint(_e144);
    uint _e148 = local_25[1];
    local_27 = uint(_e148);
    uint _e151 = local_27;
    output_8.Store(_e151*4, asuint(_e128));
    const uint _e155 = phase_exchange_100u(1u, 0u);
    uint _e156[2] = output_1;
    local_7 = _e156;
    uint _e158 = offset;
    local_8 = uint((_e158 + 3u));
    uint _e163[2] = local_7;
    local_28 = _e163;
    uint _e165 = local_8;
    uint _e167 = local_28[1];
    local_28[1] = (_e167 + _e165);
    uint _e171 = local_28[0];
    local_29 = uint(_e171);
    uint _e175 = local_28[1];
    local_30 = uint(_e175);
    uint _e178 = local_30;
    output_8.Store(_e178*4, asuint(_e155));
    const uint _e182 = phase_exchange_10u(2u, 0u);
    uint _e183[2] = output_1;
    local_9 = _e183;
    uint _e185 = offset;
    local_10 = uint((_e185 + 4u));
    uint _e190[2] = local_9;
    local_31 = _e190;
    uint _e192 = local_10;
    uint _e194 = local_31[1];
    local_31[1] = (_e194 + _e192);
    uint _e198 = local_31[0];
    local_32 = uint(_e198);
    uint _e202 = local_31[1];
    local_33 = uint(_e202);
    uint _e205 = local_33;
    output_8.Store(_e205*4, asuint(_e182));
    const uint _e209 = phase_exchange_100u(2u, 0u);
    uint _e210[2] = output_1;
    local_11 = _e210;
    uint _e212 = offset;
    local_12 = uint((_e212 + 5u));
    uint _e217[2] = local_11;
    local_34 = _e217;
    uint _e219 = local_12;
    uint _e221 = local_34[1];
    local_34[1] = (_e221 + _e219);
    uint _e225 = local_34[0];
    local_35 = uint(_e225);
    uint _e229 = local_34[1];
    local_36 = uint(_e229);
    uint _e232 = local_36;
    output_8.Store(_e232*4, asuint(_e209));
    uint _e234[2] = output_1;
    local_13 = _e234;
    phase = ZeroValueuint();
    lane = ZeroValueuint();
    next = ZeroValueuint();
    result = ZeroValueuint();
    offset_1 = ZeroValueuint();
    local_16 = ZeroValueuint();
    uint _e248[2] = local_13;
    output_2 = _e248;
    phase = 0u;
    uint3 _e253 = threadIdx_2;
    lane = _e253.x;
    uint _e256 = phase;
    if ((_e256 == 0u)) {
        uint _e264 = lane;
        uint _e266 = lane;
        slots[min(uint(_e266), 3u)] = ((700u + (blockIdx.x * 16u)) + _e264);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e269 = lane;
    uint _e276 = slots[min(uint(naga_mod((_e269 + 1u), 4u)), 3u)];
    next = _e276;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e278 = phase;
    if ((_e278 != 0u)) {
        uint _e281 = next;
        uint _e282 = phase;
        uint _e284 = lane;
        slots[min(uint(_e284), 3u)] = (_e281 + _e282);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e286 = lane;
    uint _e288 = slots[min(uint(_e286), 3u)];
    result = _e288;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e293 = lane;
    offset_1 = (((blockIdx.x * 4u) + _e293) * 8u);
    uint _e298 = result;
    uint _e300[2] = output_2;
    local_15 = _e300;
    uint _e302 = offset_1;
    uint _e305 = phase;
    local_16 = uint(((_e302 + 6u) + _e305));
    uint _e309[2] = local_15;
    local_37 = _e309;
    uint _e311 = local_16;
    uint _e313 = local_37[1];
    local_37[1] = (_e313 + _e311);
    uint _e317 = local_37[0];
    local_38 = uint(_e317);
    uint _e321 = local_37[1];
    local_39 = uint(_e321);
    uint _e324 = local_39;
    output_8.Store(_e324*4, asuint(_e298));
    uint _e326[2] = output_1;
    local_14 = _e326;
    phase_1 = ZeroValueuint();
    lane_1 = ZeroValueuint();
    next_1 = ZeroValueuint();
    result_1 = ZeroValueuint();
    offset_2 = ZeroValueuint();
    local_18 = ZeroValueuint();
    uint _e340[2] = local_14;
    output_3 = _e340;
    phase_1 = 1u;
    uint3 _e345 = threadIdx_2;
    lane_1 = _e345.x;
    uint _e348 = phase_1;
    if ((_e348 == 0u)) {
        uint _e356 = lane_1;
        uint _e358 = lane_1;
        slots[min(uint(_e358), 3u)] = ((700u + (blockIdx.x * 16u)) + _e356);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e361 = lane_1;
    uint _e368 = slots[min(uint(naga_mod((_e361 + 1u), 4u)), 3u)];
    next_1 = _e368;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e370 = phase_1;
    if ((_e370 != 0u)) {
        uint _e373 = next_1;
        uint _e374 = phase_1;
        uint _e376 = lane_1;
        slots[min(uint(_e376), 3u)] = (_e373 + _e374);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e378 = lane_1;
    uint _e380 = slots[min(uint(_e378), 3u)];
    result_1 = _e380;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e385 = lane_1;
    offset_2 = (((blockIdx.x * 4u) + _e385) * 8u);
    uint _e390 = result_1;
    uint _e392[2] = output_3;
    local_17 = _e392;
    uint _e394 = offset_2;
    uint _e397 = phase_1;
    local_18 = uint(((_e394 + 6u) + _e397));
    uint _e401[2] = local_17;
    local_40 = _e401;
    uint _e403 = local_18;
    uint _e405 = local_40[1];
    local_40[1] = (_e405 + _e403);
    uint _e409 = local_40[0];
    local_41 = uint(_e409);
    uint _e413 = local_40[1];
    local_42 = uint(_e413);
    uint _e416 = local_42;
    output_8.Store(_e416*4, asuint(_e390));
}

[numthreads(4, 1, 1)]
void forwarded_shared(uint3 threadIdx_1 : SV_GroupThreadID, uint3 blockIdx_1 : SV_GroupID, uint local_invocation_index_1 : SV_GroupIndex)
{
    if (local_invocation_index_1 == 0) {
        slots = (uint[4])0;
        counter = (uint)0;
        slots_1 = (uint[2][2])0;
        slots_2 = (uint[4])0;
        counter_1 = (uint)0;
        slots_3 = (uint[2][2])0;
        slots_4 = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output_4[2] = (uint[2])0;
    uint local_43[2] = (uint[2])0;
    uint output_5[2] = (uint[2])0;
    uint value_1 = (uint)0;
    uint offset_3 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56[2] = (uint[2])0;
    uint local_57[2] = (uint[2])0;
    uint output_6[2] = (uint[2])0;
    uint phase_2 = (uint)0;
    uint lane_2 = (uint)0;
    uint next_2 = (uint)0;
    uint result_2 = (uint)0;
    uint offset_4 = (uint)0;
    uint local_58[2] = (uint[2])0;
    uint local_59 = (uint)0;
    uint output_7[2] = (uint[2])0;
    uint phase_3 = (uint)0;
    uint lane_3 = (uint)0;
    uint next_3 = (uint)0;
    uint result_3 = (uint)0;
    uint offset_5 = (uint)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65[2] = (uint[2])0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68[2] = (uint[2])0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74[2] = (uint[2])0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77[2] = (uint[2])0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80[2] = (uint[2])0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83[2] = (uint[2])0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;

    output_4 = ZeroValuearray2_uint_();
    output_4[0] = 2u;
    output_4[1] = 0u;
    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    uint _e11[2] = output_4;
    local_43 = _e11;
    value_1 = ZeroValueuint();
    offset_3 = ZeroValueuint();
    local_45 = ZeroValueuint();
    local_47 = ZeroValueuint();
    local_49 = ZeroValueuint();
    local_51 = ZeroValueuint();
    local_53 = ZeroValueuint();
    local_55 = ZeroValueuint();
    phase_2 = ZeroValueuint();
    lane_2 = ZeroValueuint();
    next_2 = ZeroValueuint();
    result_2 = ZeroValueuint();
    offset_4 = ZeroValueuint();
    local_59 = ZeroValueuint();
    phase_3 = ZeroValueuint();
    lane_3 = ZeroValueuint();
    next_3 = ZeroValueuint();
    result_3 = ZeroValueuint();
    offset_5 = ZeroValueuint();
    local_61 = ZeroValueuint();
    uint _e53[2] = local_43;
    output_5 = _e53;
    uint3 _e59 = threadIdx_2;
    value_1 = ((blockIdx_1.x * 16u) + _e59.x);
    uint3 _e67 = threadIdx_2;
    offset_3 = (((blockIdx_1.x * 4u) + _e67.x) * 8u);
    uint _e73 = value_1;
    const uint _e75 = phase_exchange_10u(0u, _e73);
    uint _e77[2] = output_5;
    local_44 = _e77;
    uint _e79 = offset_3;
    local_45 = _e79;
    uint _e81[2] = local_44;
    local_62 = _e81;
    uint _e83 = local_45;
    uint _e85 = local_62[1];
    local_62[1] = (_e85 + _e83);
    uint _e89 = local_62[0];
    local_63 = uint(_e89);
    uint _e93 = local_62[1];
    local_64 = uint(_e93);
    uint _e96 = local_64;
    output_9.Store(_e96*4, asuint(_e75));
    uint _e99 = value_1;
    const uint _e101 = phase_exchange_100u(0u, _e99);
    uint _e102[2] = output_5;
    local_46 = _e102;
    uint _e104 = offset_3;
    local_47 = uint((_e104 + 1u));
    uint _e109[2] = local_46;
    local_65 = _e109;
    uint _e111 = local_47;
    uint _e113 = local_65[1];
    local_65[1] = (_e113 + _e111);
    uint _e117 = local_65[0];
    local_66 = uint(_e117);
    uint _e121 = local_65[1];
    local_67 = uint(_e121);
    uint _e124 = local_67;
    output_9.Store(_e124*4, asuint(_e101));
    const uint _e128 = phase_exchange_10u(1u, 0u);
    uint _e129[2] = output_5;
    local_48 = _e129;
    uint _e131 = offset_3;
    local_49 = uint((_e131 + 2u));
    uint _e136[2] = local_48;
    local_68 = _e136;
    uint _e138 = local_49;
    uint _e140 = local_68[1];
    local_68[1] = (_e140 + _e138);
    uint _e144 = local_68[0];
    local_69 = uint(_e144);
    uint _e148 = local_68[1];
    local_70 = uint(_e148);
    uint _e151 = local_70;
    output_9.Store(_e151*4, asuint(_e128));
    const uint _e155 = phase_exchange_100u(1u, 0u);
    uint _e156[2] = output_5;
    local_50 = _e156;
    uint _e158 = offset_3;
    local_51 = uint((_e158 + 3u));
    uint _e163[2] = local_50;
    local_71 = _e163;
    uint _e165 = local_51;
    uint _e167 = local_71[1];
    local_71[1] = (_e167 + _e165);
    uint _e171 = local_71[0];
    local_72 = uint(_e171);
    uint _e175 = local_71[1];
    local_73 = uint(_e175);
    uint _e178 = local_73;
    output_9.Store(_e178*4, asuint(_e155));
    const uint _e182 = phase_exchange_10u(2u, 0u);
    uint _e183[2] = output_5;
    local_52 = _e183;
    uint _e185 = offset_3;
    local_53 = uint((_e185 + 4u));
    uint _e190[2] = local_52;
    local_74 = _e190;
    uint _e192 = local_53;
    uint _e194 = local_74[1];
    local_74[1] = (_e194 + _e192);
    uint _e198 = local_74[0];
    local_75 = uint(_e198);
    uint _e202 = local_74[1];
    local_76 = uint(_e202);
    uint _e205 = local_76;
    output_9.Store(_e205*4, asuint(_e182));
    const uint _e209 = phase_exchange_100u(2u, 0u);
    uint _e210[2] = output_5;
    local_54 = _e210;
    uint _e212 = offset_3;
    local_55 = uint((_e212 + 5u));
    uint _e217[2] = local_54;
    local_77 = _e217;
    uint _e219 = local_55;
    uint _e221 = local_77[1];
    local_77[1] = (_e221 + _e219);
    uint _e225 = local_77[0];
    local_78 = uint(_e225);
    uint _e229 = local_77[1];
    local_79 = uint(_e229);
    uint _e232 = local_79;
    output_9.Store(_e232*4, asuint(_e209));
    uint _e234[2] = output_5;
    local_56 = _e234;
    phase_2 = ZeroValueuint();
    lane_2 = ZeroValueuint();
    next_2 = ZeroValueuint();
    result_2 = ZeroValueuint();
    offset_4 = ZeroValueuint();
    local_59 = ZeroValueuint();
    uint _e248[2] = local_56;
    output_6 = _e248;
    phase_2 = 0u;
    uint3 _e253 = threadIdx_2;
    lane_2 = _e253.x;
    uint _e256 = phase_2;
    if ((_e256 == 0u)) {
        uint _e264 = lane_2;
        uint _e266 = lane_2;
        slots[min(uint(_e266), 3u)] = ((700u + (blockIdx_1.x * 16u)) + _e264);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e269 = lane_2;
    uint _e276 = slots[min(uint(naga_mod((_e269 + 1u), 4u)), 3u)];
    next_2 = _e276;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e278 = phase_2;
    if ((_e278 != 0u)) {
        uint _e281 = next_2;
        uint _e282 = phase_2;
        uint _e284 = lane_2;
        slots[min(uint(_e284), 3u)] = (_e281 + _e282);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e286 = lane_2;
    uint _e288 = slots[min(uint(_e286), 3u)];
    result_2 = _e288;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e293 = lane_2;
    offset_4 = (((blockIdx_1.x * 4u) + _e293) * 8u);
    uint _e298 = result_2;
    uint _e300[2] = output_6;
    local_58 = _e300;
    uint _e302 = offset_4;
    uint _e305 = phase_2;
    local_59 = uint(((_e302 + 6u) + _e305));
    uint _e309[2] = local_58;
    local_80 = _e309;
    uint _e311 = local_59;
    uint _e313 = local_80[1];
    local_80[1] = (_e313 + _e311);
    uint _e317 = local_80[0];
    local_81 = uint(_e317);
    uint _e321 = local_80[1];
    local_82 = uint(_e321);
    uint _e324 = local_82;
    output_9.Store(_e324*4, asuint(_e298));
    uint _e326[2] = output_5;
    local_57 = _e326;
    phase_3 = ZeroValueuint();
    lane_3 = ZeroValueuint();
    next_3 = ZeroValueuint();
    result_3 = ZeroValueuint();
    offset_5 = ZeroValueuint();
    local_61 = ZeroValueuint();
    uint _e340[2] = local_57;
    output_7 = _e340;
    phase_3 = 1u;
    uint3 _e345 = threadIdx_2;
    lane_3 = _e345.x;
    uint _e348 = phase_3;
    if ((_e348 == 0u)) {
        uint _e356 = lane_3;
        uint _e358 = lane_3;
        slots[min(uint(_e358), 3u)] = ((700u + (blockIdx_1.x * 16u)) + _e356);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e361 = lane_3;
    uint _e368 = slots[min(uint(naga_mod((_e361 + 1u), 4u)), 3u)];
    next_3 = _e368;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e370 = phase_3;
    if ((_e370 != 0u)) {
        uint _e373 = next_3;
        uint _e374 = phase_3;
        uint _e376 = lane_3;
        slots[min(uint(_e376), 3u)] = (_e373 + _e374);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e378 = lane_3;
    uint _e380 = slots[min(uint(_e378), 3u)];
    result_3 = _e380;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e385 = lane_3;
    offset_5 = (((blockIdx_1.x * 4u) + _e385) * 8u);
    uint _e390 = result_3;
    uint _e392[2] = output_7;
    local_60 = _e392;
    uint _e394 = offset_5;
    uint _e397 = phase_3;
    local_61 = uint(((_e394 + 6u) + _e397));
    uint _e401[2] = local_60;
    local_83 = _e401;
    uint _e403 = local_61;
    uint _e405 = local_83[1];
    local_83[1] = (_e405 + _e403);
    uint _e409 = local_83[0];
    local_84 = uint(_e409);
    uint _e413 = local_83[1];
    local_85 = uint(_e413);
    uint _e416 = local_85;
    output_9.Store(_e416*4, asuint(_e390));
}
