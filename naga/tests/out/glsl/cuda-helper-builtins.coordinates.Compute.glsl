#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    float value;
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_7 {
    uint value;
};
uvec3 threadIdx_1 = uvec3(0u);

uvec3 blockIdx_1 = uvec3(0u);

uvec3 gridDim_1 = uvec3(0u);

layout(std430) readonly buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };

layout(std430) readonly buffer type_6_block_2Compute { float3_ _group_0_binding_2_cs[]; };

layout(std140) uniform type_7_block_3Compute { type_7 _group_0_binding_3_cs; };

layout(std430) buffer type_8_block_4Compute { uint _group_0_binding_4_cs[]; };


uint thread_component(uint axis) {
    if ((axis == 0u)) {
        uvec3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if ((axis == 1u)) {
        uvec3 _e9 = threadIdx_1;
        return _e9.y;
    }
    uvec3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(uint axis_1) {
    if ((axis_1 == 0u)) {
        uvec3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if ((axis_1 == 1u)) {
        uvec3 _e9 = blockIdx_1;
        return _e9.y;
    }
    uvec3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(uint axis_2) {
    if ((axis_2 == 0u)) {
        return 1u;
    }
    if ((axis_2 == 1u)) {
        return 1u;
    }
    return 1u;
}

uint grid_component(uint axis_3) {
    if ((axis_3 == 0u)) {
        uvec3 _e4 = gridDim_1;
        return _e4.x;
    }
    if ((axis_3 == 1u)) {
        uvec3 _e9 = gridDim_1;
        return _e9.y;
    }
    uvec3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(uint axis_4) {
    uint _e1 = thread_component(axis_4);
    return _e1;
}

float component_1(float offset) {
    uvec3 _e2 = blockIdx_1;
    return (float(_e2.x) + offset);
}

uint global_x() {
    uint _e1 = group_component(0u);
    uint _e3 = shape_component(0u);
    uint _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

uint kind(uint value) {
    return 11u;
}

void observe() {
    uvec3 _e1 = gridDim_1;
    if ((_e1.z != 0u)) {
        return;
    } else {
        return;
    }
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 gridDim = gl_NumWorkGroups;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    int local_36 = 0;
    float local_37 = 0.0;
    float local_38 = 0.0;
    float local_39 = 0.0;
    int local_40 = 0;
    float local_41 = 0.0;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    int local_62 = 0;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    float local_66 = 0.0;
    uint local_67 = 0u;
    uint local_68 = 0u;
    float local_69 = 0.0;
    uint local_70 = 0u;
    uint local_71 = 0u;
    float local_72 = 0.0;
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77 = 0u;
    int local_78 = 0;
    uint local_79 = 0u;
    float local_80 = 0.0;
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83 = 0u;
    float scale_1 = _group_0_binding_1_cs.value;
    uint limit_1 = _group_0_binding_3_cs.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    uint _e12 = global_x();
    if ((_e12 >= limit_1)) {
        return;
    }
    observe();
    uint _e15 = thread_component(0u);
    local = uint(0);
    uint _e19 = local;
    local_42 = uint(_e19);
    uint _e22 = local_42;
    _group_0_binding_4_cs[_e22] = _e15;
    uint _e26 = thread_component(1u);
    local_1 = uint(1);
    uint _e30 = local_1;
    local_43 = uint(_e30);
    uint _e33 = local_43;
    _group_0_binding_4_cs[_e33] = _e26;
    uint _e36 = thread_component(2u);
    local_2 = uint(2);
    uint _e40 = local_2;
    local_44 = uint(_e40);
    uint _e43 = local_44;
    _group_0_binding_4_cs[_e43] = _e36;
    uint _e46 = group_component(0u);
    local_3 = uint(3);
    uint _e50 = local_3;
    local_45 = uint(_e50);
    uint _e53 = local_45;
    _group_0_binding_4_cs[_e53] = _e46;
    uint _e56 = group_component(1u);
    local_4 = uint(4);
    uint _e60 = local_4;
    local_46 = uint(_e60);
    uint _e63 = local_46;
    _group_0_binding_4_cs[_e63] = _e56;
    uint _e66 = group_component(2u);
    local_5 = uint(5);
    uint _e70 = local_5;
    local_47 = uint(_e70);
    uint _e73 = local_47;
    _group_0_binding_4_cs[_e73] = _e66;
    uint _e76 = shape_component(0u);
    local_6 = uint(6);
    uint _e80 = local_6;
    local_48 = uint(_e80);
    uint _e83 = local_48;
    _group_0_binding_4_cs[_e83] = _e76;
    uint _e86 = shape_component(1u);
    local_7 = uint(7);
    uint _e90 = local_7;
    local_49 = uint(_e90);
    uint _e93 = local_49;
    _group_0_binding_4_cs[_e93] = _e86;
    uint _e96 = shape_component(2u);
    local_8 = uint(8);
    uint _e100 = local_8;
    local_50 = uint(_e100);
    uint _e103 = local_50;
    _group_0_binding_4_cs[_e103] = _e96;
    uint _e106 = grid_component(0u);
    local_9 = uint(9);
    uint _e110 = local_9;
    local_51 = uint(_e110);
    uint _e113 = local_51;
    _group_0_binding_4_cs[_e113] = _e106;
    uint _e116 = grid_component(1u);
    local_10 = uint(10);
    uint _e120 = local_10;
    local_52 = uint(_e120);
    uint _e123 = local_52;
    _group_0_binding_4_cs[_e123] = _e116;
    uint _e126 = grid_component(2u);
    local_11 = uint(11);
    uint _e130 = local_11;
    local_53 = uint(_e130);
    uint _e133 = local_53;
    _group_0_binding_4_cs[_e133] = _e126;
    uint _e135 = global_x();
    local_12 = uint(12);
    uint _e139 = local_12;
    local_54 = uint(_e139);
    uint _e142 = local_54;
    _group_0_binding_4_cs[_e142] = _e135;
    uint _e145 = component(0u);
    local_13 = uint(13);
    uint _e149 = local_13;
    local_55 = uint(_e149);
    uint _e152 = local_55;
    _group_0_binding_4_cs[_e152] = _e145;
    float _e155 = component_1(2.5);
    local_14 = uint(14);
    uint _e160 = local_14;
    local_56 = uint(_e160);
    uint _e163 = local_56;
    _group_0_binding_4_cs[_e163] = floatBitsToUint(_e155);
    local_15 = uint(15);
    uint _e169 = local_15;
    local_57 = uint(_e169);
    uint _e172 = local_57;
    _group_0_binding_4_cs[_e172] = threadIdx.x;
    local_16 = uint(16);
    uint _e178 = local_16;
    local_58 = uint(_e178);
    uint _e181 = local_58;
    _group_0_binding_4_cs[_e181] = blockIdx.y;
    local_17 = uint(17);
    uint _e187 = local_17;
    local_59 = uint(_e187);
    uint _e190 = local_59;
    _group_0_binding_4_cs[_e190] = gridDim.z;
    local_18 = uint(18);
    uint _e195 = local_18;
    local_60 = uint(_e195);
    uint _e198 = local_60;
    _group_0_binding_4_cs[_e198] = 1u;
    local_20 = uint(0);
    uint _e204 = local_20;
    local_61 = uint(_e204);
    uint _e207 = local_61;
    int _e210 = _group_0_binding_0_cs[_e207];
    local_62 = _e210;
    int _e212 = local_62;
    local_36 = _e212;
    int _e214 = local_36;
    local_19 = uint(19);
    uint _e219 = local_19;
    local_63 = uint(_e219);
    uint _e222 = local_63;
    _group_0_binding_4_cs[_e222] = uint(_e214);
    local_21 = uint(20);
    uint _e228 = local_21;
    local_64 = uint(_e228);
    uint _e231 = local_64;
    _group_0_binding_4_cs[_e231] = floatBitsToUint(scale_1);
    local_23 = uint(0);
    uint _e236 = local_23;
    local_65 = uint(_e236);
    uint _e239 = local_65;
    float _e243 = _group_0_binding_2_cs[_e239].x;
    local_66 = _e243;
    float _e245 = local_66;
    local_37 = _e245;
    float _e247 = local_37;
    local_22 = uint(21);
    uint _e252 = local_22;
    local_67 = uint(_e252);
    uint _e255 = local_67;
    _group_0_binding_4_cs[_e255] = floatBitsToUint(_e247);
    local_25 = uint(0);
    uint _e260 = local_25;
    local_68 = uint(_e260);
    uint _e263 = local_68;
    float _e266 = _group_0_binding_2_cs[_e263].y;
    local_69 = _e266;
    float _e268 = local_69;
    local_38 = _e268;
    float _e270 = local_38;
    local_24 = uint(22);
    uint _e275 = local_24;
    local_70 = uint(_e275);
    uint _e278 = local_70;
    _group_0_binding_4_cs[_e278] = floatBitsToUint(_e270);
    local_27 = uint(0);
    uint _e283 = local_27;
    local_71 = uint(_e283);
    uint _e286 = local_71;
    float _e289 = _group_0_binding_2_cs[_e286].z;
    local_72 = _e289;
    float _e291 = local_72;
    local_39 = _e291;
    float _e293 = local_39;
    local_26 = uint(23);
    uint _e298 = local_26;
    local_73 = uint(_e298);
    uint _e301 = local_73;
    _group_0_binding_4_cs[_e301] = floatBitsToUint(_e293);
    local_28 = uint(24);
    uint _e306 = local_28;
    local_74 = uint(_e306);
    uint _e309 = local_74;
    _group_0_binding_4_cs[_e309] = limit_1;
    uint _e312 = thread_component(0u);
    uint _e314 = group_component(1u);
    uint _e317 = shape_component(2u);
    uint _e320 = grid_component(0u);
    local_29 = uint(25);
    uint _e325 = local_29;
    local_75 = uint(_e325);
    uint _e328 = local_75;
    _group_0_binding_4_cs[_e328] = (((_e312 + _e314) + _e317) + _e320);
    uint _e330 = global_x();
    uint _e331 = global_x();
    local_30 = uint(26);
    uint _e336 = local_30;
    local_76 = uint(_e336);
    uint _e339 = local_76;
    _group_0_binding_4_cs[_e339] = (_e330 + _e331);
    local_32 = uint(0);
    uint _e344 = local_32;
    local_77 = uint(_e344);
    uint _e347 = local_77;
    int _e349 = _group_0_binding_0_cs[_e347];
    local_78 = _e349;
    int _e351 = local_78;
    local_40 = _e351;
    int _e353 = local_40;
    local_33 = uint(0);
    uint _e359 = local_33;
    local_79 = uint(_e359);
    uint _e362 = local_79;
    float _e365 = _group_0_binding_2_cs[_e362].x;
    local_80 = _e365;
    float _e367 = local_80;
    local_41 = _e367;
    float _e369 = local_41;
    local_31 = uint(27);
    uint _e375 = local_31;
    local_81 = uint(_e375);
    uint _e378 = local_81;
    _group_0_binding_4_cs[_e378] = floatBitsToUint(((float(_e353) * scale_1) + _e369));
    uint _e381 = kind(threadIdx.x);
    local_34 = uint(28);
    uint _e385 = local_34;
    local_82 = uint(_e385);
    uint _e388 = local_82;
    _group_0_binding_4_cs[_e388] = _e381;
    uint _e391 = grid_component(2u);
    local_35 = uint(29);
    uint _e395 = local_35;
    local_83 = uint(_e395);
    uint _e398 = local_83;
    _group_0_binding_4_cs[_e398] = _e391;
}

