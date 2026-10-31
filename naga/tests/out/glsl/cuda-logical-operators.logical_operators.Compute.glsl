#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct Sample_cuda_record_0_ {
    int value;
    int payload[2];
};
layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


Sample_cuda_record_0_ operator_u0026_u0026_(Sample_cuda_record_0_ left_1, Sample_cuda_record_0_ right_1) {
    Sample_cuda_record_0_ left_2 = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ right_2 = Sample_cuda_record_0_(0, int[2](0, 0));
    left_2 = left_1;
    right_2 = right_1;
    int _e7 = left_2.value;
    int _e10 = right_2.value;
    left_2.value = ((_e7 * 10) + _e10);
    int _e18 = right_2.payload[0];
    int _e19 = left_2.payload[1];
    left_2.payload[1] = (_e19 + _e18);
    Sample_cuda_record_0_ _e21 = left_2;
    return _e21;
}

Sample_cuda_record_0_ operator_u007c_u007c(Sample_cuda_record_0_ left_3, Sample_cuda_record_0_ right_3) {
    Sample_cuda_record_0_ left_4 = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ right_4 = Sample_cuda_record_0_(0, int[2](0, 0));
    left_4 = left_3;
    right_4 = right_3;
    int _e7 = left_4.value;
    int _e10 = right_4.value;
    left_4.value = ((_e7 * 100) + _e10);
    int _e18 = right_4.payload[1];
    int _e19 = left_4.payload[0];
    left_4.payload[0] = (_e19 + _e18);
    Sample_cuda_record_0_ _e21 = left_4;
    return _e21;
}

int operator_u0026_u0026_1(Sample_cuda_record_0_ left_5, int right_5) {
    Sample_cuda_record_0_ left_6 = Sample_cuda_record_0_(0, int[2](0, 0));
    left_6 = left_5;
    int _e4 = left_6.value;
    return ((_e4 * 10) + right_5);
}

int operator_u007c_u007c_1(int left_7, Sample_cuda_record_0_ right_6) {
    Sample_cuda_record_0_ right_7 = Sample_cuda_record_0_(0, int[2](0, 0));
    right_7 = right_6;
    int _e6 = right_7.value;
    return ((left_7 * 100) + _e6);
}

ivec2 operator_u0026_u0026_2(ivec2 left_8, ivec2 right_8) {
    ivec2 left_9 = ivec2(0);
    ivec2 right_9 = ivec2(0);
    left_9 = left_8;
    right_9 = right_8;
    int _e6 = left_9.x;
    int _e9 = right_9.x;
    int _e13 = left_9.y;
    int _e16 = right_9.y;
    return ivec2(((_e6 * 10) + _e9), ((_e13 * 10) + _e16));
}

ivec2 operator_u007c_u007c_2(ivec2 left_10, ivec2 right_10) {
    ivec2 left_11 = ivec2(0);
    ivec2 right_11 = ivec2(0);
    left_11 = left_10;
    right_11 = right_10;
    int _e6 = left_11.x;
    int _e9 = right_11.x;
    int _e13 = left_11.y;
    int _e16 = right_11.y;
    return ivec2(((_e6 * 100) + _e9), ((_e13 * 100) + _e16));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    Sample_cuda_record_0_ left = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ right = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ both = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ either = Sample_cuda_record_0_(0, int[2](0, 0));
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
    ivec2 first = ivec2(0);
    ivec2 second = ivec2(0);
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    Sample_cuda_record_0_ local_16 = Sample_cuda_record_0_(0, int[2](0, 0));
    uint local_17 = 0u;
    Sample_cuda_record_0_ local_18 = Sample_cuda_record_0_(0, int[2](0, 0));
    int counter = 0;
    Sample_cuda_record_0_ evaluated = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ local_19 = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ local_20 = Sample_cuda_record_0_(0, int[2](0, 0));
    Sample_cuda_record_0_ local_21 = Sample_cuda_record_0_(0, int[2](0, 0));
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    bool local_25 = false;
    uint local_26 = 0u;
    bool local_27 = false;
    uint local_28 = 0u;
    bool local_29 = false;
    uint local_30 = 0u;
    bool local_31 = false;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
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
    uint base = (threadIdx.x * 24u);
    left.value = 2;
    left.payload[0] = 3;
    left.payload[1] = 4;
    right.value = 5;
    right.payload[0] = 6;
    right.payload[1] = 7;
    Sample_cuda_record_0_ _e20 = left;
    Sample_cuda_record_0_ _e21 = right;
    Sample_cuda_record_0_ _e22 = operator_u0026_u0026_(_e20, _e21);
    both = _e22;
    Sample_cuda_record_0_ _e24 = left;
    Sample_cuda_record_0_ _e25 = right;
    Sample_cuda_record_0_ _e26 = operator_u007c_u007c(_e24, _e25);
    either = _e26;
    int _e29 = both.value;
    local = uint((base + 0u));
    uint _e35 = local;
    local_33 = uint(_e35);
    uint _e38 = local_33;
    _group_0_binding_0_cs[_e38] = uint(_e29);
    int _e44 = both.payload[1];
    local_1 = uint((base + 1u));
    uint _e50 = local_1;
    local_34 = uint(_e50);
    uint _e53 = local_34;
    _group_0_binding_0_cs[_e53] = uint(_e44);
    int _e56 = either.value;
    local_2 = uint((base + 2u));
    uint _e62 = local_2;
    local_35 = uint(_e62);
    uint _e65 = local_35;
    _group_0_binding_0_cs[_e65] = uint(_e56);
    int _e70 = either.payload[0];
    local_3 = uint((base + 3u));
    uint _e76 = local_3;
    local_36 = uint(_e76);
    uint _e79 = local_36;
    _group_0_binding_0_cs[_e79] = uint(_e70);
    int _e82 = left.value;
    local_4 = uint((base + 4u));
    uint _e88 = local_4;
    local_37 = uint(_e88);
    uint _e91 = local_37;
    _group_0_binding_0_cs[_e91] = uint(_e82);
    int _e96 = left.payload[1];
    local_5 = uint((base + 5u));
    uint _e102 = local_5;
    local_38 = uint(_e102);
    uint _e105 = local_38;
    _group_0_binding_0_cs[_e105] = uint(_e96);
    Sample_cuda_record_0_ _e107 = left;
    int _e109 = operator_u0026_u0026_1(_e107, 9);
    local_6 = uint((base + 6u));
    uint _e115 = local_6;
    local_39 = uint(_e115);
    uint _e118 = local_39;
    _group_0_binding_0_cs[_e118] = uint(_e109);
    Sample_cuda_record_0_ _e120 = right;
    int _e122 = operator_u007c_u007c_1(0, _e120);
    local_7 = uint((base + 7u));
    uint _e128 = local_7;
    local_40 = uint(_e128);
    uint _e131 = local_40;
    _group_0_binding_0_cs[_e131] = uint(_e122);
    Sample_cuda_record_0_ _e133 = left;
    Sample_cuda_record_0_ _e134 = right;
    Sample_cuda_record_0_ _e135 = operator_u0026_u0026_(_e133, _e134);
    local_8 = uint((base + 8u));
    uint _e142 = local_8;
    local_41 = uint(_e142);
    uint _e145 = local_41;
    _group_0_binding_0_cs[_e145] = uint(_e135.value);
    Sample_cuda_record_0_ _e147 = left;
    Sample_cuda_record_0_ _e148 = right;
    Sample_cuda_record_0_ _e149 = operator_u007c_u007c(_e147, _e148);
    local_9 = uint((base + 9u));
    uint _e158 = local_9;
    local_42 = uint(_e158);
    uint _e161 = local_42;
    _group_0_binding_0_cs[_e161] = uint(_e149.payload[0]);
    first = ivec2(2, 3);
    second = ivec2(4, 5);
    ivec2 _e171 = first;
    ivec2 _e172 = second;
    ivec2 _e173 = operator_u0026_u0026_2(_e171, _e172);
    local_10 = uint((base + 10u));
    uint _e180 = local_10;
    local_43 = uint(_e180);
    uint _e183 = local_43;
    _group_0_binding_0_cs[_e183] = uint(_e173.x);
    ivec2 _e185 = first;
    ivec2 _e186 = second;
    ivec2 _e187 = operator_u007c_u007c_2(_e185, _e186);
    local_11 = uint((base + 11u));
    uint _e194 = local_11;
    local_44 = uint(_e194);
    uint _e197 = local_44;
    _group_0_binding_0_cs[_e197] = uint(_e187.y);
    ivec2 _e199 = first;
    ivec2 _e200 = second;
    ivec2 _e201 = operator_u0026_u0026_2(_e199, _e200);
    ivec2 _e202 = first;
    ivec2 _e203 = operator_u0026_u0026_2(_e201, _e202);
    local_12 = uint((base + 12u));
    uint _e210 = local_12;
    local_45 = uint(_e210);
    uint _e213 = local_45;
    _group_0_binding_0_cs[_e213] = uint(_e203.x);
    ivec2 _e215 = first;
    ivec2 _e216 = second;
    ivec2 _e217 = first;
    ivec2 _e218 = operator_u0026_u0026_2(_e216, _e217);
    ivec2 _e219 = operator_u007c_u007c_2(_e215, _e218);
    local_13 = uint((base + 13u));
    uint _e226 = local_13;
    local_46 = uint(_e226);
    uint _e229 = local_46;
    _group_0_binding_0_cs[_e229] = uint(_e219.y);
    ivec2 _e231 = first;
    ivec2 _e232 = second;
    ivec2 _e233 = operator_u007c_u007c_2(_e231, _e232);
    ivec2 _e234 = first;
    ivec2 _e235 = operator_u0026_u0026_2(_e233, _e234);
    local_14 = uint((base + 14u));
    uint _e242 = local_14;
    local_47 = uint(_e242);
    uint _e245 = local_47;
    _group_0_binding_0_cs[_e245] = uint(_e235.x);
    if (true) {
        Sample_cuda_record_0_ _e248 = left;
        local_16 = _e248;
    } else {
        Sample_cuda_record_0_ _e250 = right;
        local_16 = _e250;
    }
    Sample_cuda_record_0_ _e253 = local_16;
    int _e255 = operator_u0026_u0026_1(_e253, 1);
    local_15 = uint((base + 15u));
    uint _e261 = local_15;
    local_48 = uint(_e261);
    uint _e264 = local_48;
    _group_0_binding_0_cs[_e264] = uint(_e255);
    if (true) {
        Sample_cuda_record_0_ _e267 = left;
        Sample_cuda_record_0_ _e268 = right;
        Sample_cuda_record_0_ _e269 = operator_u0026_u0026_(_e267, _e268);
        local_18 = _e269;
    } else {
        Sample_cuda_record_0_ _e271 = right;
        Sample_cuda_record_0_ _e272 = left;
        Sample_cuda_record_0_ _e273 = operator_u007c_u007c(_e271, _e272);
        local_18 = _e273;
    }
    Sample_cuda_record_0_ _e276 = local_18;
    local_17 = uint((base + 16u));
    uint _e283 = local_17;
    local_49 = uint(_e283);
    uint _e286 = local_49;
    _group_0_binding_0_cs[_e286] = uint(_e276.value);
    counter = 0;
    if (false) {
        int _e291 = counter;
        counter = (_e291 + 1);
        local_19.value = _e291;
        local_19.payload[0] = 1;
        local_19.payload[1] = 2;
        Sample_cuda_record_0_ _e301 = local_19;
        Sample_cuda_record_0_ _e302 = right;
        Sample_cuda_record_0_ _e303 = operator_u0026_u0026_(_e301, _e302);
        local_21 = _e303;
    } else {
        Sample_cuda_record_0_ _e305 = left;
        int _e306 = counter;
        counter = (_e306 + 1);
        local_20.value = _e306;
        local_20.payload[0] = 1;
        local_20.payload[1] = 2;
        Sample_cuda_record_0_ _e316 = local_20;
        Sample_cuda_record_0_ _e317 = operator_u007c_u007c(_e305, _e316);
        local_21 = _e317;
    }
    Sample_cuda_record_0_ _e320 = local_21;
    evaluated = _e320;
    int _e323 = evaluated.value;
    local_22 = uint((base + 17u));
    uint _e329 = local_22;
    local_50 = uint(_e329);
    uint _e332 = local_50;
    _group_0_binding_0_cs[_e332] = uint(_e323);
    int _e334 = counter;
    local_23 = uint((base + 18u));
    uint _e340 = local_23;
    local_51 = uint(_e340);
    uint _e343 = local_51;
    _group_0_binding_0_cs[_e343] = uint(_e334);
    local_25 = false;
    if (false) {
        Sample_cuda_record_0_ _e347 = left;
        Sample_cuda_record_0_ _e348 = right;
        Sample_cuda_record_0_ _e349 = operator_u0026_u0026_(_e347, _e348);
        local_25 = (_e349.value != 0);
    }
    bool _e353 = local_25;
    local_24 = uint((base + 19u));
    uint _e359 = local_24;
    local_52 = uint(_e359);
    uint _e362 = local_52;
    _group_0_binding_0_cs[_e362] = uint(_e353);
    local_27 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e366 = left;
        Sample_cuda_record_0_ _e367 = right;
        Sample_cuda_record_0_ _e368 = operator_u007c_u007c(_e366, _e367);
        local_27 = (_e368.value != 0);
    }
    bool _e372 = local_27;
    local_26 = uint((base + 20u));
    uint _e378 = local_26;
    local_53 = uint(_e378);
    uint _e381 = local_53;
    _group_0_binding_0_cs[_e381] = uint(_e372);
    bool _e385 = (2 != 0);
    local_29 = _e385;
    if (_e385) {
        local_29 = (3 != 0);
    }
    bool _e390 = local_29;
    local_28 = uint((base + 21u));
    uint _e396 = local_28;
    local_54 = uint(_e396);
    uint _e399 = local_54;
    _group_0_binding_0_cs[_e399] = uint(_e390);
    bool _e403 = (0 != 0);
    local_31 = _e403;
    if (_e403) {
    } else {
        local_31 = (4 != 0);
    }
    bool _e408 = local_31;
    local_30 = uint((base + 22u));
    uint _e414 = local_30;
    local_55 = uint(_e414);
    uint _e417 = local_55;
    _group_0_binding_0_cs[_e417] = uint(_e408);
    local_32 = uint((base + 23u));
    uint _e424 = local_32;
    local_56 = uint(_e424);
    uint _e427 = local_56;
    _group_0_binding_0_cs[_e427] = threadIdx.x;
}

