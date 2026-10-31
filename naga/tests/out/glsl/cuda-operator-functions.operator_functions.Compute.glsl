#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct Record_cuda_record_0_ {
    int value;
    int history[2];
};
layout(std430) readonly buffer type_4_block_0Compute { ivec2 _group_0_binding_0_cs[]; };

layout(std430) buffer type_6_block_1Compute { uint _group_0_binding_1_cs[]; };


ivec2 operator_u002b(ivec2 value) {
    ivec2 value_1 = ivec2(0);
    value_1 = value;
    int _e3 = value_1.x;
    int _e5 = value_1.y;
    return ivec2(_e3, _e5);
}

ivec2 operator_u002d(ivec2 value_2) {
    ivec2 value_3 = ivec2(0);
    value_3 = value_2;
    int _e3 = value_3.x;
    int _e6 = value_3.y;
    return ivec2(-(_e3), -(_e6));
}

ivec2 operator_u007e(ivec2 value_4) {
    ivec2 value_5 = ivec2(0);
    value_5 = value_4;
    int _e3 = value_5.x;
    int _e6 = value_5.y;
    return ivec2(~(_e3), ~(_e6));
}

bool operator_u0021_(ivec2 value_6) {
    ivec2 value_7 = ivec2(0);
    bool local_40 = false;
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = (_e4 == 0);
    local_40 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_40 = (_e9 == 0);
    }
    bool _e11 = local_40;
    return _e11;
}

int operator_u002a(ivec2 value_8) {
    ivec2 value_9 = ivec2(0);
    value_9 = value_8;
    int _e4 = value_9.x;
    int _e7 = value_9.y;
    return ((_e4 * 10) + _e7);
}

ivec2 operator_u0026_(ivec2 value_10) {
    ivec2 value_11 = ivec2(0);
    value_11 = value_10;
    int _e3 = value_11.y;
    int _e5 = value_11.x;
    return ivec2(_e3, _e5);
}

ivec2 operator_u002b_1(ivec2 left_1, ivec2 right_1) {
    ivec2 left_2 = ivec2(0);
    ivec2 right_2 = ivec2(0);
    left_2 = left_1;
    right_2 = right_1;
    int _e6 = left_2.x;
    int _e7 = right_2.x;
    int _e11 = left_2.y;
    int _e12 = right_2.y;
    return ivec2((_e6 + _e7), (_e11 + _e12));
}

ivec2 operator_u002d_1(ivec2 left_3, ivec2 right_3) {
    ivec2 left_4 = ivec2(0);
    ivec2 right_4 = ivec2(0);
    left_4 = left_3;
    right_4 = right_3;
    int _e6 = left_4.x;
    int _e7 = right_4.x;
    int _e11 = left_4.y;
    int _e12 = right_4.y;
    return ivec2((_e6 - _e7), (_e11 - _e12));
}

ivec2 operator_u002a_1(ivec2 left_5, ivec2 right_5) {
    ivec2 left_6 = ivec2(0);
    ivec2 right_6 = ivec2(0);
    left_6 = left_5;
    right_6 = right_5;
    int _e6 = left_6.x;
    int _e7 = right_6.x;
    int _e11 = left_6.y;
    int _e12 = right_6.y;
    return ivec2((_e6 * _e7), (_e11 * _e12));
}

ivec2 operator_u002f(ivec2 left_7, ivec2 right_7) {
    ivec2 left_8 = ivec2(0);
    ivec2 right_8 = ivec2(0);
    left_8 = left_7;
    right_8 = right_7;
    int _e6 = left_8.x;
    int _e7 = right_8.x;
    int _e11 = left_8.y;
    int _e12 = right_8.y;
    return ivec2((_e6 / _e7), (_e11 / _e12));
}

ivec2 operator_u0025_(ivec2 left_9, ivec2 right_9) {
    ivec2 left_10 = ivec2(0);
    ivec2 right_10 = ivec2(0);
    left_10 = left_9;
    right_10 = right_9;
    int _e6 = left_10.x;
    int _e7 = right_10.x;
    int _e11 = left_10.y;
    int _e12 = right_10.y;
    return ivec2((_e6 - _e7 * (_e6 / _e7)), (_e11 - _e12 * (_e11 / _e12)));
}

ivec2 operator_u0026_1(ivec2 left_11, ivec2 right_11) {
    ivec2 left_12 = ivec2(0);
    ivec2 right_12 = ivec2(0);
    left_12 = left_11;
    right_12 = right_11;
    int _e6 = left_12.x;
    int _e7 = right_12.x;
    int _e11 = left_12.y;
    int _e12 = right_12.y;
    return ivec2((_e6 & _e7), (_e11 & _e12));
}

ivec2 operator_u007c(ivec2 left_13, ivec2 right_13) {
    ivec2 left_14 = ivec2(0);
    ivec2 right_14 = ivec2(0);
    left_14 = left_13;
    right_14 = right_13;
    int _e6 = left_14.x;
    int _e7 = right_14.x;
    int _e11 = left_14.y;
    int _e12 = right_14.y;
    return ivec2((_e6 | _e7), (_e11 | _e12));
}

ivec2 operator_u005e(ivec2 left_15, ivec2 right_15) {
    ivec2 left_16 = ivec2(0);
    ivec2 right_16 = ivec2(0);
    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return ivec2((_e6 ^ _e7), (_e11 ^ _e12));
}

ivec2 operator(ivec2 left_17, ivec2 right_17) {
    ivec2 left_18 = ivec2(0);
    ivec2 right_18 = ivec2(0);
    uint local_41 = 0u;
    uint local_42 = 0u;
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_41 = uint(_e7);
    uint _e10 = local_41;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_42 = uint(_e15);
    uint _e18 = local_42;
    return ivec2((_e5 << _e10), (_e13 << _e18));
}

ivec2 operator_1(ivec2 left_19, ivec2 right_19) {
    ivec2 left_20 = ivec2(0);
    ivec2 right_20 = ivec2(0);
    left_20 = left_19;
    right_20 = right_19;
    int _e5 = left_20.x;
    int _e7 = right_20.x;
    int _e11 = left_20.y;
    int _e13 = right_20.y;
    return ivec2((_e5 >> uint(_e7)), (_e11 >> uint(_e13)));
}

Record_cuda_record_0_ operator_u002a_2(Record_cuda_record_0_ value_12) {
    Record_cuda_record_0_ value_13 = Record_cuda_record_0_(0, int[2](0, 0));
    value_13 = value_12;
    int _e3 = value_13.value;
    value_13.value = (_e3 + 1);
    Record_cuda_record_0_ _e6 = value_13;
    return _e6;
}

int operator_u0026_2(Record_cuda_record_0_ value_14) {
    Record_cuda_record_0_ value_15 = Record_cuda_record_0_(0, int[2](0, 0));
    value_15 = value_14;
    int _e3 = value_15.value;
    return _e3;
}

Record_cuda_record_0_ operator_u002d_2(Record_cuda_record_0_ value_16) {
    Record_cuda_record_0_ value_17 = Record_cuda_record_0_(0, int[2](0, 0));
    value_17 = value_16;
    int _e4 = value_17.value;
    value_17.value = -(_e4);
    Record_cuda_record_0_ _e6 = value_17;
    return _e6;
}

Record_cuda_record_0_ operator_u002a_3(Record_cuda_record_0_ value_18, int factor) {
    Record_cuda_record_0_ value_19 = Record_cuda_record_0_(0, int[2](0, 0));
    value_19 = value_18;
    int _e4 = value_19.value;
    value_19.value = (_e4 * factor);
    int _e9 = value_19.history[1];
    value_19.history[1] = (_e9 + factor);
    Record_cuda_record_0_ _e11 = value_19;
    return _e11;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    ivec2 left = ivec2(0);
    uint local = 0u;
    ivec2 right = ivec2(0);
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
    Record_cuda_record_0_ original = Record_cuda_record_0_(0, int[2](0, 0));
    Record_cuda_record_0_ scaled = Record_cuda_record_0_(0, int[2](0, 0));
    uint local_27 = 0u;
    Record_cuda_record_0_ local_28 = Record_cuda_record_0_(0, int[2](0, 0));
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    ivec2 local_38 = ivec2(0);
    ivec2 local_39 = ivec2(0);
    uint base = (threadIdx.x * 36u);
    local = uint(threadIdx.x);
    uint _e7 = local;
    ivec2 _e10 = _group_0_binding_0_cs[_e7];
    local_39 = _e10;
    ivec2 _e12 = local_39;
    local_38 = _e12;
    ivec2 _e14 = local_38;
    left = _e14;
    right = ivec2(3, 2);
    ivec2 _e20 = left;
    ivec2 _e21 = operator_u002b(_e20);
    local_1 = uint((base + 0u));
    uint _e28 = local_1;
    _group_0_binding_1_cs[_e28] = uint(_e21.x);
    ivec2 _e31 = left;
    ivec2 _e32 = operator_u002d(_e31);
    local_2 = uint((base + 1u));
    uint _e39 = local_2;
    _group_0_binding_1_cs[_e39] = uint(_e32.y);
    ivec2 _e41 = left;
    ivec2 _e42 = operator_u007e(_e41);
    local_3 = uint((base + 2u));
    uint _e49 = local_3;
    _group_0_binding_1_cs[_e49] = uint(_e42.x);
    ivec2 _e51 = left;
    bool _e52 = operator_u0021_(_e51);
    local_4 = uint((base + 3u));
    uint _e58 = local_4;
    _group_0_binding_1_cs[_e58] = uint(_e52);
    ivec2 _e60 = left;
    int _e61 = operator_u002a(_e60);
    local_5 = uint((base + 4u));
    uint _e67 = local_5;
    _group_0_binding_1_cs[_e67] = uint(_e61);
    ivec2 _e69 = left;
    ivec2 _e70 = operator_u0026_(_e69);
    local_6 = uint((base + 5u));
    uint _e77 = local_6;
    _group_0_binding_1_cs[_e77] = uint(_e70.x);
    ivec2 _e79 = left;
    ivec2 _e80 = right;
    ivec2 _e81 = operator_u002b_1(_e79, _e80);
    local_7 = uint((base + 6u));
    uint _e88 = local_7;
    _group_0_binding_1_cs[_e88] = uint(_e81.x);
    ivec2 _e90 = left;
    ivec2 _e91 = right;
    ivec2 _e92 = operator_u002d_1(_e90, _e91);
    local_8 = uint((base + 7u));
    uint _e99 = local_8;
    _group_0_binding_1_cs[_e99] = uint(_e92.y);
    ivec2 _e101 = left;
    ivec2 _e102 = right;
    ivec2 _e103 = operator_u002a_1(_e101, _e102);
    local_9 = uint((base + 8u));
    uint _e110 = local_9;
    _group_0_binding_1_cs[_e110] = uint(_e103.x);
    ivec2 _e112 = left;
    ivec2 _e113 = right;
    ivec2 _e114 = operator_u002f(_e112, _e113);
    local_10 = uint((base + 9u));
    uint _e121 = local_10;
    _group_0_binding_1_cs[_e121] = uint(_e114.y);
    ivec2 _e123 = left;
    ivec2 _e124 = right;
    ivec2 _e125 = operator_u0025_(_e123, _e124);
    local_11 = uint((base + 10u));
    uint _e132 = local_11;
    _group_0_binding_1_cs[_e132] = uint(_e125.y);
    ivec2 _e134 = left;
    ivec2 _e135 = right;
    ivec2 _e136 = operator_u0026_1(_e134, _e135);
    local_12 = uint((base + 11u));
    uint _e143 = local_12;
    _group_0_binding_1_cs[_e143] = uint(_e136.x);
    ivec2 _e145 = left;
    ivec2 _e146 = right;
    ivec2 _e147 = operator_u007c(_e145, _e146);
    local_13 = uint((base + 12u));
    uint _e154 = local_13;
    _group_0_binding_1_cs[_e154] = uint(_e147.y);
    ivec2 _e156 = left;
    ivec2 _e157 = right;
    ivec2 _e158 = operator_u005e(_e156, _e157);
    local_14 = uint((base + 13u));
    uint _e165 = local_14;
    _group_0_binding_1_cs[_e165] = uint(_e158.x);
    ivec2 _e167 = left;
    ivec2 _e168 = right;
    ivec2 _e169 = operator(_e167, _e168);
    local_15 = uint((base + 14u));
    uint _e176 = local_15;
    _group_0_binding_1_cs[_e176] = uint(_e169.x);
    ivec2 _e178 = left;
    ivec2 _e179 = right;
    ivec2 _e180 = operator_1(_e178, _e179);
    local_16 = uint((base + 15u));
    uint _e187 = local_16;
    _group_0_binding_1_cs[_e187] = uint(_e180.y);
    ivec2 _e189 = left;
    ivec2 _e190 = operator_u002b(_e189);
    local_17 = uint((base + 16u));
    uint _e197 = local_17;
    _group_0_binding_1_cs[_e197] = uint(_e190.y);
    ivec2 _e199 = left;
    ivec2 _e200 = right;
    ivec2 _e201 = operator_u002d_1(_e199, _e200);
    local_18 = uint((base + 17u));
    uint _e208 = local_18;
    _group_0_binding_1_cs[_e208] = uint(_e201.x);
    ivec2 _e210 = left;
    int _e211 = operator_u002a(_e210);
    local_19 = uint((base + 18u));
    uint _e217 = local_19;
    _group_0_binding_1_cs[_e217] = uint(_e211);
    ivec2 _e219 = left;
    ivec2 _e220 = right;
    ivec2 _e221 = operator_u0026_1(_e219, _e220);
    local_20 = uint((base + 19u));
    uint _e228 = local_20;
    _group_0_binding_1_cs[_e228] = uint(_e221.y);
    ivec2 _e230 = left;
    ivec2 _e231 = operator_u0026_(_e230);
    int _e232 = operator_u002a(_e231);
    local_21 = uint((base + 20u));
    uint _e238 = local_21;
    _group_0_binding_1_cs[_e238] = uint(_e232);
    ivec2 _e240 = left;
    ivec2 _e241 = operator_u0026_(_e240);
    ivec2 _e242 = operator_u0026_(_e241);
    local_22 = uint((base + 21u));
    uint _e249 = local_22;
    _group_0_binding_1_cs[_e249] = uint(_e242.x);
    ivec2 _e251 = left;
    ivec2 _e252 = right;
    ivec2 _e253 = right;
    ivec2 _e254 = operator_u002a_1(_e252, _e253);
    ivec2 _e255 = operator_u002b_1(_e251, _e254);
    local_23 = uint((base + 22u));
    uint _e262 = local_23;
    _group_0_binding_1_cs[_e262] = uint(_e255.x);
    ivec2 _e264 = left;
    ivec2 _e265 = right;
    ivec2 _e269 = operator_u002b_1(_e265, ivec2(1, 1));
    ivec2 _e270 = operator(_e264, _e269);
    local_24 = uint((base + 23u));
    uint _e277 = local_24;
    _group_0_binding_1_cs[_e277] = uint(_e270.x);
    ivec2 _e279 = left;
    ivec2 _e280 = right;
    ivec2 _e284 = operator_u0026_1(_e280, ivec2(1, 1));
    ivec2 _e285 = operator_u007c(_e279, _e284);
    local_25 = uint((base + 24u));
    uint _e292 = local_25;
    _group_0_binding_1_cs[_e292] = uint(_e285.y);
    ivec2 _e294 = left;
    ivec2 _e295 = right;
    ivec2 _e296 = operator_u002d_1(_e294, _e295);
    ivec2 _e297 = right;
    ivec2 _e298 = operator_u002d_1(_e296, _e297);
    local_26 = uint((base + 25u));
    uint _e305 = local_26;
    _group_0_binding_1_cs[_e305] = uint(_e298.x);
    original.value = 9;
    original.history[0] = 1;
    original.history[1] = 2;
    Record_cuda_record_0_ _e315 = original;
    Record_cuda_record_0_ _e317 = operator_u002a_3(_e315, 3);
    scaled = _e317;
    local_28.value = 9;
    local_28.history[0] = 1;
    local_28.history[1] = 2;
    Record_cuda_record_0_ _e327 = local_28;
    int _e328 = operator_u0026_2(_e327);
    local_27 = uint((base + 26u));
    uint _e334 = local_27;
    _group_0_binding_1_cs[_e334] = uint(_e328);
    Record_cuda_record_0_ _e336 = original;
    Record_cuda_record_0_ _e337 = operator_u002a_2(_e336);
    int _e338 = operator_u0026_2(_e337);
    local_29 = uint((base + 27u));
    uint _e344 = local_29;
    _group_0_binding_1_cs[_e344] = uint(_e338);
    int _e347 = scaled.value;
    local_30 = uint((base + 28u));
    uint _e353 = local_30;
    _group_0_binding_1_cs[_e353] = uint(_e347);
    int _e358 = scaled.history[1];
    local_31 = uint((base + 29u));
    uint _e364 = local_31;
    _group_0_binding_1_cs[_e364] = uint(_e358);
    int _e367 = original.value;
    local_32 = uint((base + 30u));
    uint _e373 = local_32;
    _group_0_binding_1_cs[_e373] = uint(_e367);
    int _e378 = original.history[1];
    local_33 = uint((base + 31u));
    uint _e384 = local_33;
    _group_0_binding_1_cs[_e384] = uint(_e378);
    Record_cuda_record_0_ _e386 = original;
    Record_cuda_record_0_ _e387 = operator_u002d_2(_e386);
    local_34 = uint((base + 32u));
    uint _e394 = local_34;
    _group_0_binding_1_cs[_e394] = uint(_e387.value);
    Record_cuda_record_0_ _e396 = original;
    Record_cuda_record_0_ _e398 = operator_u002a_3(_e396, 2);
    local_35 = uint((base + 33u));
    uint _e405 = local_35;
    _group_0_binding_1_cs[_e405] = uint(_e398.value);
    Record_cuda_record_0_ _e407 = original;
    Record_cuda_record_0_ _e408 = operator_u002a_2(_e407);
    int _e409 = operator_u0026_2(_e408);
    local_36 = uint((base + 34u));
    uint _e415 = local_36;
    _group_0_binding_1_cs[_e415] = uint(_e409);
    bool _e420 = operator_u0021_(ivec2(0, 0));
    local_37 = uint((base + 35u));
    uint _e426 = local_37;
    _group_0_binding_1_cs[_e426] = uint(_e420);
}

