#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

shared uint slots[4];

uvec3 threadIdx_2 = uvec3(0u);

uvec3 blockIdx_2 = uvec3(0u);

layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint counter;

shared uint slots_1[2][2];

shared uint slots_2[4];

shared uint counter_1;

shared uint slots_3[2][2];

shared uint slots_4[4];


uint phase_exchange_10u(uint phase_4, uint value_2) {
    uint first = 0u;
    uint second = 0u;
    uint neighbor = 0u;
    uint next_4 = 0u;
    uint next_5 = 0u;
    uint local_86 = 0u;
    uint local_87 = 0u;
    uvec3 _e3 = threadIdx_2;
    uint lane_4 = _e3.x;
    if ((lane_4 == 0u)) {
        if ((phase_4 == 0u)) {
            counter = ((value_2 + 10u) + 40u);
        } else {
            uint _e17 = counter;
            counter = (_e17 + (phase_4 * 3u));
        }
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint saved_counter = counter;
    {
        if ((phase_4 == 0u)) {
            slots_1[(lane_4 / 2u)][(lane_4 - 2u * (lane_4 / 2u))] = (value_2 + 10u);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e33 = (lane_4 + 1u);
        neighbor = (_e33 - 4u * (_e33 / 4u));
        uint _e37 = neighbor;
        uint _e42 = neighbor;
        uint _e46 = slots_1[(_e37 / 2u)][(_e42 - 2u * (_e42 / 2u))];
        next_4 = _e46;
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        if ((phase_4 != 0u)) {
            uint _e50 = next_4;
            slots_1[(lane_4 / 2u)][(lane_4 - 2u * (lane_4 / 2u))] = (_e50 + phase_4);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e64 = slots_1[(lane_4 / 2u)][(lane_4 - 2u * (lane_4 / 2u))];
        first = _e64;
    }
    {
        if ((phase_4 == 0u)) {
            slots_2[lane_4] = ((value_2 + 10u) + 20u);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e75 = (lane_4 + 3u);
        uint _e80 = slots_2[(_e75 - 4u * (_e75 / 4u))];
        next_5 = _e80;
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        if ((phase_4 != 0u)) {
            uint _e86 = next_5;
            slots_2[lane_4] = (_e86 + (phase_4 * 2u));
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e90 = slots_2[lane_4];
        second = _e90;
    }
    uint _e92 = second;
    local_86 = 8u;
    uint _e95 = local_86;
    uint _e97 = first;
    local_87 = 16u;
    uint _e101 = local_87;
    uint result_4 = ((_e97 | (_e92 << _e95)) | (saved_counter << _e101));
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    return result_4;
}

uint phase_exchange_100u(uint phase_5, uint value_3) {
    uint first_1 = 0u;
    uint second_1 = 0u;
    uint neighbor_1 = 0u;
    uint next_6 = 0u;
    uint next_7 = 0u;
    uint local_88 = 0u;
    uint local_89 = 0u;
    uvec3 _e3 = threadIdx_2;
    uint lane_5 = _e3.x;
    if ((lane_5 == 0u)) {
        if ((phase_5 == 0u)) {
            counter_1 = ((value_3 + 100u) + 40u);
        } else {
            uint _e17 = counter_1;
            counter_1 = (_e17 + (phase_5 * 3u));
        }
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint saved_counter_1 = counter_1;
    {
        if ((phase_5 == 0u)) {
            slots_3[(lane_5 / 2u)][(lane_5 - 2u * (lane_5 / 2u))] = (value_3 + 100u);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e33 = (lane_5 + 1u);
        neighbor_1 = (_e33 - 4u * (_e33 / 4u));
        uint _e37 = neighbor_1;
        uint _e42 = neighbor_1;
        uint _e46 = slots_3[(_e37 / 2u)][(_e42 - 2u * (_e42 / 2u))];
        next_6 = _e46;
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        if ((phase_5 != 0u)) {
            uint _e50 = next_6;
            slots_3[(lane_5 / 2u)][(lane_5 - 2u * (lane_5 / 2u))] = (_e50 + phase_5);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e64 = slots_3[(lane_5 / 2u)][(lane_5 - 2u * (lane_5 / 2u))];
        first_1 = _e64;
    }
    {
        if ((phase_5 == 0u)) {
            slots_4[lane_5] = ((value_3 + 100u) + 20u);
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e75 = (lane_5 + 3u);
        uint _e80 = slots_4[(_e75 - 4u * (_e75 / 4u))];
        next_7 = _e80;
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        if ((phase_5 != 0u)) {
            uint _e86 = next_7;
            slots_4[lane_5] = (_e86 + (phase_5 * 2u));
        }
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e90 = slots_4[lane_5];
        second_1 = _e90;
    }
    uint _e92 = second_1;
    local_88 = 8u;
    uint _e95 = local_88;
    uint _e97 = first_1;
    local_89 = 16u;
    uint _e101 = local_89;
    uint result_5 = ((_e97 | (_e92 << _e95)) | (saved_counter_1 << _e101));
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    return result_5;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        slots = uint[4](0u, 0u, 0u, 0u);
        counter = 0u;
        slots_1 = uint[2][2](uint[2](0u, 0u), uint[2](0u, 0u));
        slots_2 = uint[4](0u, 0u, 0u, 0u);
        counter_1 = 0u;
        slots_3 = uint[2][2](uint[2](0u, 0u), uint[2](0u, 0u));
        slots_4 = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint output_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint output_1[2] = uint[2](0u, 0u);
    uint value = 0u;
    uint offset = 0u;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14[2] = uint[2](0u, 0u);
    uint output_2[2] = uint[2](0u, 0u);
    uint phase = 0u;
    uint lane = 0u;
    uint next = 0u;
    uint result = 0u;
    uint offset_1 = 0u;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint output_3[2] = uint[2](0u, 0u);
    uint phase_1 = 0u;
    uint lane_1 = 0u;
    uint next_1 = 0u;
    uint result_1 = 0u;
    uint offset_2 = 0u;
    uint local_17[2] = uint[2](0u, 0u);
    uint local_18 = 0u;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31[2] = uint[2](0u, 0u);
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37[2] = uint[2](0u, 0u);
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40[2] = uint[2](0u, 0u);
    uint local_41 = 0u;
    uint local_42 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 2u;
    output_[1] = 0u;
    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    uint _e11[2] = output_;
    local = _e11;
    value = 0u;
    offset = 0u;
    local_2 = 0u;
    local_4 = 0u;
    local_6 = 0u;
    local_8 = 0u;
    local_10 = 0u;
    local_12 = 0u;
    phase = 0u;
    lane = 0u;
    next = 0u;
    result = 0u;
    offset_1 = 0u;
    local_16 = 0u;
    phase_1 = 0u;
    lane_1 = 0u;
    next_1 = 0u;
    result_1 = 0u;
    offset_2 = 0u;
    local_18 = 0u;
    uint _e53[2] = local;
    output_1 = _e53;
    uvec3 _e59 = threadIdx_2;
    value = ((blockIdx.x * 16u) + _e59.x);
    uvec3 _e67 = threadIdx_2;
    offset = (((blockIdx.x * 4u) + _e67.x) * 8u);
    uint _e73 = value;
    uint _e75 = phase_exchange_10u(0u, _e73);
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
    _group_0_binding_0_cs[_e96] = _e75;
    uint _e99 = value;
    uint _e101 = phase_exchange_100u(0u, _e99);
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
    _group_0_binding_0_cs[_e124] = _e101;
    uint _e128 = phase_exchange_10u(1u, 0u);
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
    _group_0_binding_0_cs[_e151] = _e128;
    uint _e155 = phase_exchange_100u(1u, 0u);
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
    _group_0_binding_0_cs[_e178] = _e155;
    uint _e182 = phase_exchange_10u(2u, 0u);
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
    _group_0_binding_0_cs[_e205] = _e182;
    uint _e209 = phase_exchange_100u(2u, 0u);
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
    _group_0_binding_0_cs[_e232] = _e209;
    uint _e234[2] = output_1;
    local_13 = _e234;
    phase = 0u;
    lane = 0u;
    next = 0u;
    result = 0u;
    offset_1 = 0u;
    local_16 = 0u;
    uint _e248[2] = local_13;
    output_2 = _e248;
    phase = 0u;
    uvec3 _e253 = threadIdx_2;
    lane = _e253.x;
    uint _e256 = phase;
    if ((_e256 == 0u)) {
        uint _e264 = lane;
        uint _e266 = lane;
        slots[_e266] = ((700u + (blockIdx.x * 16u)) + _e264);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e269 = lane;
    uint _e271 = (_e269 + 1u);
    uint _e276 = slots[(_e271 - 4u * (_e271 / 4u))];
    next = _e276;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e278 = phase;
    if ((_e278 != 0u)) {
        uint _e281 = next;
        uint _e282 = phase;
        uint _e284 = lane;
        slots[_e284] = (_e281 + _e282);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e286 = lane;
    uint _e288 = slots[_e286];
    result = _e288;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
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
    _group_0_binding_0_cs[_e324] = _e298;
    uint _e326[2] = output_1;
    local_14 = _e326;
    phase_1 = 0u;
    lane_1 = 0u;
    next_1 = 0u;
    result_1 = 0u;
    offset_2 = 0u;
    local_18 = 0u;
    uint _e340[2] = local_14;
    output_3 = _e340;
    phase_1 = 1u;
    uvec3 _e345 = threadIdx_2;
    lane_1 = _e345.x;
    uint _e348 = phase_1;
    if ((_e348 == 0u)) {
        uint _e356 = lane_1;
        uint _e358 = lane_1;
        slots[_e358] = ((700u + (blockIdx.x * 16u)) + _e356);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e361 = lane_1;
    uint _e363 = (_e361 + 1u);
    uint _e368 = slots[(_e363 - 4u * (_e363 / 4u))];
    next_1 = _e368;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e370 = phase_1;
    if ((_e370 != 0u)) {
        uint _e373 = next_1;
        uint _e374 = phase_1;
        uint _e376 = lane_1;
        slots[_e376] = (_e373 + _e374);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e378 = lane_1;
    uint _e380 = slots[_e378];
    result_1 = _e380;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
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
    _group_0_binding_0_cs[_e416] = _e390;
}

