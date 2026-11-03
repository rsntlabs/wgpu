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
    uvec3 threadIdx_1 = gl_LocalInvocationID;
    uvec3 blockIdx_1 = gl_WorkGroupID;
    uint output_4[2] = uint[2](0u, 0u);
    uint local_43[2] = uint[2](0u, 0u);
    uint output_5[2] = uint[2](0u, 0u);
    uint value_1 = 0u;
    uint offset_3 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46[2] = uint[2](0u, 0u);
    uint local_47 = 0u;
    uint local_48[2] = uint[2](0u, 0u);
    uint local_49 = 0u;
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51 = 0u;
    uint local_52[2] = uint[2](0u, 0u);
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57[2] = uint[2](0u, 0u);
    uint output_6[2] = uint[2](0u, 0u);
    uint phase_2 = 0u;
    uint lane_2 = 0u;
    uint next_2 = 0u;
    uint result_2 = 0u;
    uint offset_4 = 0u;
    uint local_58[2] = uint[2](0u, 0u);
    uint local_59 = 0u;
    uint output_7[2] = uint[2](0u, 0u);
    uint phase_3 = 0u;
    uint lane_3 = 0u;
    uint next_3 = 0u;
    uint result_3 = 0u;
    uint offset_5 = 0u;
    uint local_60[2] = uint[2](0u, 0u);
    uint local_61 = 0u;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68[2] = uint[2](0u, 0u);
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71[2] = uint[2](0u, 0u);
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74[2] = uint[2](0u, 0u);
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80[2] = uint[2](0u, 0u);
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83[2] = uint[2](0u, 0u);
    uint local_84 = 0u;
    uint local_85 = 0u;
    output_4 = uint[2](0u, 0u);
    output_4[0] = 2u;
    output_4[1] = 0u;
    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    uint _e11[2] = output_4;
    local_43 = _e11;
    value_1 = 0u;
    offset_3 = 0u;
    local_45 = 0u;
    local_47 = 0u;
    local_49 = 0u;
    local_51 = 0u;
    local_53 = 0u;
    local_55 = 0u;
    phase_2 = 0u;
    lane_2 = 0u;
    next_2 = 0u;
    result_2 = 0u;
    offset_4 = 0u;
    local_59 = 0u;
    phase_3 = 0u;
    lane_3 = 0u;
    next_3 = 0u;
    result_3 = 0u;
    offset_5 = 0u;
    local_61 = 0u;
    uint _e53[2] = local_43;
    output_5 = _e53;
    uvec3 _e59 = threadIdx_2;
    value_1 = ((blockIdx_1.x * 16u) + _e59.x);
    uvec3 _e67 = threadIdx_2;
    offset_3 = (((blockIdx_1.x * 4u) + _e67.x) * 8u);
    uint _e73 = value_1;
    uint _e75 = phase_exchange_10u(0u, _e73);
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
    _group_0_binding_0_cs[_e96] = _e75;
    uint _e99 = value_1;
    uint _e101 = phase_exchange_100u(0u, _e99);
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
    _group_0_binding_0_cs[_e124] = _e101;
    uint _e128 = phase_exchange_10u(1u, 0u);
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
    _group_0_binding_0_cs[_e151] = _e128;
    uint _e155 = phase_exchange_100u(1u, 0u);
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
    _group_0_binding_0_cs[_e178] = _e155;
    uint _e182 = phase_exchange_10u(2u, 0u);
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
    _group_0_binding_0_cs[_e205] = _e182;
    uint _e209 = phase_exchange_100u(2u, 0u);
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
    _group_0_binding_0_cs[_e232] = _e209;
    uint _e234[2] = output_5;
    local_56 = _e234;
    phase_2 = 0u;
    lane_2 = 0u;
    next_2 = 0u;
    result_2 = 0u;
    offset_4 = 0u;
    local_59 = 0u;
    uint _e248[2] = local_56;
    output_6 = _e248;
    phase_2 = 0u;
    uvec3 _e253 = threadIdx_2;
    lane_2 = _e253.x;
    uint _e256 = phase_2;
    if ((_e256 == 0u)) {
        uint _e264 = lane_2;
        uint _e266 = lane_2;
        slots[_e266] = ((700u + (blockIdx_1.x * 16u)) + _e264);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e269 = lane_2;
    uint _e271 = (_e269 + 1u);
    uint _e276 = slots[(_e271 - 4u * (_e271 / 4u))];
    next_2 = _e276;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e278 = phase_2;
    if ((_e278 != 0u)) {
        uint _e281 = next_2;
        uint _e282 = phase_2;
        uint _e284 = lane_2;
        slots[_e284] = (_e281 + _e282);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e286 = lane_2;
    uint _e288 = slots[_e286];
    result_2 = _e288;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
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
    _group_0_binding_0_cs[_e324] = _e298;
    uint _e326[2] = output_5;
    local_57 = _e326;
    phase_3 = 0u;
    lane_3 = 0u;
    next_3 = 0u;
    result_3 = 0u;
    offset_5 = 0u;
    local_61 = 0u;
    uint _e340[2] = local_57;
    output_7 = _e340;
    phase_3 = 1u;
    uvec3 _e345 = threadIdx_2;
    lane_3 = _e345.x;
    uint _e348 = phase_3;
    if ((_e348 == 0u)) {
        uint _e356 = lane_3;
        uint _e358 = lane_3;
        slots[_e358] = ((700u + (blockIdx_1.x * 16u)) + _e356);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e361 = lane_3;
    uint _e363 = (_e361 + 1u);
    uint _e368 = slots[(_e363 - 4u * (_e363 / 4u))];
    next_3 = _e368;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e370 = phase_3;
    if ((_e370 != 0u)) {
        uint _e373 = next_3;
        uint _e374 = phase_3;
        uint _e376 = lane_3;
        slots[_e376] = (_e373 + _e374);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e378 = lane_3;
    uint _e380 = slots[_e378];
    result_3 = _e380;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
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
    _group_0_binding_0_cs[_e416] = _e390;
}

