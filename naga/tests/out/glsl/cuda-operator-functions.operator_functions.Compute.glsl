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
    bool local_77 = false;
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = (_e4 == 0);
    local_77 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_77 = (_e9 == 0);
    }
    bool _e11 = local_77;
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
    uint local_78 = 0u;
    uint local_79 = 0u;
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_78 = uint(_e7);
    uint _e10 = local_78;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_79 = uint(_e15);
    uint _e18 = local_79;
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
    uint local_39 = 0u;
    ivec2 local_40 = ivec2(0);
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
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint base = (threadIdx.x * 36u);
    local = uint(threadIdx.x);
    uint _e7 = local;
    local_39 = uint(_e7);
    uint _e10 = local_39;
    ivec2 _e13 = _group_0_binding_0_cs[_e10];
    local_40 = _e13;
    ivec2 _e15 = local_40;
    local_38 = _e15;
    ivec2 _e17 = local_38;
    left = _e17;
    right = ivec2(3, 2);
    ivec2 _e23 = left;
    ivec2 _e24 = operator_u002b(_e23);
    local_1 = uint((base + 0u));
    uint _e31 = local_1;
    local_41 = uint(_e31);
    uint _e34 = local_41;
    _group_0_binding_1_cs[_e34] = uint(_e24.x);
    ivec2 _e37 = left;
    ivec2 _e38 = operator_u002d(_e37);
    local_2 = uint((base + 1u));
    uint _e45 = local_2;
    local_42 = uint(_e45);
    uint _e48 = local_42;
    _group_0_binding_1_cs[_e48] = uint(_e38.y);
    ivec2 _e50 = left;
    ivec2 _e51 = operator_u007e(_e50);
    local_3 = uint((base + 2u));
    uint _e58 = local_3;
    local_43 = uint(_e58);
    uint _e61 = local_43;
    _group_0_binding_1_cs[_e61] = uint(_e51.x);
    ivec2 _e63 = left;
    bool _e64 = operator_u0021_(_e63);
    local_4 = uint((base + 3u));
    uint _e70 = local_4;
    local_44 = uint(_e70);
    uint _e73 = local_44;
    _group_0_binding_1_cs[_e73] = uint(_e64);
    ivec2 _e75 = left;
    int _e76 = operator_u002a(_e75);
    local_5 = uint((base + 4u));
    uint _e82 = local_5;
    local_45 = uint(_e82);
    uint _e85 = local_45;
    _group_0_binding_1_cs[_e85] = uint(_e76);
    ivec2 _e87 = left;
    ivec2 _e88 = operator_u0026_(_e87);
    local_6 = uint((base + 5u));
    uint _e95 = local_6;
    local_46 = uint(_e95);
    uint _e98 = local_46;
    _group_0_binding_1_cs[_e98] = uint(_e88.x);
    ivec2 _e100 = left;
    ivec2 _e101 = right;
    ivec2 _e102 = operator_u002b_1(_e100, _e101);
    local_7 = uint((base + 6u));
    uint _e109 = local_7;
    local_47 = uint(_e109);
    uint _e112 = local_47;
    _group_0_binding_1_cs[_e112] = uint(_e102.x);
    ivec2 _e114 = left;
    ivec2 _e115 = right;
    ivec2 _e116 = operator_u002d_1(_e114, _e115);
    local_8 = uint((base + 7u));
    uint _e123 = local_8;
    local_48 = uint(_e123);
    uint _e126 = local_48;
    _group_0_binding_1_cs[_e126] = uint(_e116.y);
    ivec2 _e128 = left;
    ivec2 _e129 = right;
    ivec2 _e130 = operator_u002a_1(_e128, _e129);
    local_9 = uint((base + 8u));
    uint _e137 = local_9;
    local_49 = uint(_e137);
    uint _e140 = local_49;
    _group_0_binding_1_cs[_e140] = uint(_e130.x);
    ivec2 _e142 = left;
    ivec2 _e143 = right;
    ivec2 _e144 = operator_u002f(_e142, _e143);
    local_10 = uint((base + 9u));
    uint _e151 = local_10;
    local_50 = uint(_e151);
    uint _e154 = local_50;
    _group_0_binding_1_cs[_e154] = uint(_e144.y);
    ivec2 _e156 = left;
    ivec2 _e157 = right;
    ivec2 _e158 = operator_u0025_(_e156, _e157);
    local_11 = uint((base + 10u));
    uint _e165 = local_11;
    local_51 = uint(_e165);
    uint _e168 = local_51;
    _group_0_binding_1_cs[_e168] = uint(_e158.y);
    ivec2 _e170 = left;
    ivec2 _e171 = right;
    ivec2 _e172 = operator_u0026_1(_e170, _e171);
    local_12 = uint((base + 11u));
    uint _e179 = local_12;
    local_52 = uint(_e179);
    uint _e182 = local_52;
    _group_0_binding_1_cs[_e182] = uint(_e172.x);
    ivec2 _e184 = left;
    ivec2 _e185 = right;
    ivec2 _e186 = operator_u007c(_e184, _e185);
    local_13 = uint((base + 12u));
    uint _e193 = local_13;
    local_53 = uint(_e193);
    uint _e196 = local_53;
    _group_0_binding_1_cs[_e196] = uint(_e186.y);
    ivec2 _e198 = left;
    ivec2 _e199 = right;
    ivec2 _e200 = operator_u005e(_e198, _e199);
    local_14 = uint((base + 13u));
    uint _e207 = local_14;
    local_54 = uint(_e207);
    uint _e210 = local_54;
    _group_0_binding_1_cs[_e210] = uint(_e200.x);
    ivec2 _e212 = left;
    ivec2 _e213 = right;
    ivec2 _e214 = operator(_e212, _e213);
    local_15 = uint((base + 14u));
    uint _e221 = local_15;
    local_55 = uint(_e221);
    uint _e224 = local_55;
    _group_0_binding_1_cs[_e224] = uint(_e214.x);
    ivec2 _e226 = left;
    ivec2 _e227 = right;
    ivec2 _e228 = operator_1(_e226, _e227);
    local_16 = uint((base + 15u));
    uint _e235 = local_16;
    local_56 = uint(_e235);
    uint _e238 = local_56;
    _group_0_binding_1_cs[_e238] = uint(_e228.y);
    ivec2 _e240 = left;
    ivec2 _e241 = operator_u002b(_e240);
    local_17 = uint((base + 16u));
    uint _e248 = local_17;
    local_57 = uint(_e248);
    uint _e251 = local_57;
    _group_0_binding_1_cs[_e251] = uint(_e241.y);
    ivec2 _e253 = left;
    ivec2 _e254 = right;
    ivec2 _e255 = operator_u002d_1(_e253, _e254);
    local_18 = uint((base + 17u));
    uint _e262 = local_18;
    local_58 = uint(_e262);
    uint _e265 = local_58;
    _group_0_binding_1_cs[_e265] = uint(_e255.x);
    ivec2 _e267 = left;
    int _e268 = operator_u002a(_e267);
    local_19 = uint((base + 18u));
    uint _e274 = local_19;
    local_59 = uint(_e274);
    uint _e277 = local_59;
    _group_0_binding_1_cs[_e277] = uint(_e268);
    ivec2 _e279 = left;
    ivec2 _e280 = right;
    ivec2 _e281 = operator_u0026_1(_e279, _e280);
    local_20 = uint((base + 19u));
    uint _e288 = local_20;
    local_60 = uint(_e288);
    uint _e291 = local_60;
    _group_0_binding_1_cs[_e291] = uint(_e281.y);
    ivec2 _e293 = left;
    ivec2 _e294 = operator_u0026_(_e293);
    int _e295 = operator_u002a(_e294);
    local_21 = uint((base + 20u));
    uint _e301 = local_21;
    local_61 = uint(_e301);
    uint _e304 = local_61;
    _group_0_binding_1_cs[_e304] = uint(_e295);
    ivec2 _e306 = left;
    ivec2 _e307 = operator_u0026_(_e306);
    ivec2 _e308 = operator_u0026_(_e307);
    local_22 = uint((base + 21u));
    uint _e315 = local_22;
    local_62 = uint(_e315);
    uint _e318 = local_62;
    _group_0_binding_1_cs[_e318] = uint(_e308.x);
    ivec2 _e320 = left;
    ivec2 _e321 = right;
    ivec2 _e322 = right;
    ivec2 _e323 = operator_u002a_1(_e321, _e322);
    ivec2 _e324 = operator_u002b_1(_e320, _e323);
    local_23 = uint((base + 22u));
    uint _e331 = local_23;
    local_63 = uint(_e331);
    uint _e334 = local_63;
    _group_0_binding_1_cs[_e334] = uint(_e324.x);
    ivec2 _e336 = left;
    ivec2 _e337 = right;
    ivec2 _e341 = operator_u002b_1(_e337, ivec2(1, 1));
    ivec2 _e342 = operator(_e336, _e341);
    local_24 = uint((base + 23u));
    uint _e349 = local_24;
    local_64 = uint(_e349);
    uint _e352 = local_64;
    _group_0_binding_1_cs[_e352] = uint(_e342.x);
    ivec2 _e354 = left;
    ivec2 _e355 = right;
    ivec2 _e359 = operator_u0026_1(_e355, ivec2(1, 1));
    ivec2 _e360 = operator_u007c(_e354, _e359);
    local_25 = uint((base + 24u));
    uint _e367 = local_25;
    local_65 = uint(_e367);
    uint _e370 = local_65;
    _group_0_binding_1_cs[_e370] = uint(_e360.y);
    ivec2 _e372 = left;
    ivec2 _e373 = right;
    ivec2 _e374 = operator_u002d_1(_e372, _e373);
    ivec2 _e375 = right;
    ivec2 _e376 = operator_u002d_1(_e374, _e375);
    local_26 = uint((base + 25u));
    uint _e383 = local_26;
    local_66 = uint(_e383);
    uint _e386 = local_66;
    _group_0_binding_1_cs[_e386] = uint(_e376.x);
    original.value = 9;
    original.history[0] = 1;
    original.history[1] = 2;
    Record_cuda_record_0_ _e396 = original;
    Record_cuda_record_0_ _e398 = operator_u002a_3(_e396, 3);
    scaled = _e398;
    local_28.value = 9;
    local_28.history[0] = 1;
    local_28.history[1] = 2;
    Record_cuda_record_0_ _e408 = local_28;
    int _e409 = operator_u0026_2(_e408);
    local_27 = uint((base + 26u));
    uint _e415 = local_27;
    local_67 = uint(_e415);
    uint _e418 = local_67;
    _group_0_binding_1_cs[_e418] = uint(_e409);
    Record_cuda_record_0_ _e420 = original;
    Record_cuda_record_0_ _e421 = operator_u002a_2(_e420);
    int _e422 = operator_u0026_2(_e421);
    local_29 = uint((base + 27u));
    uint _e428 = local_29;
    local_68 = uint(_e428);
    uint _e431 = local_68;
    _group_0_binding_1_cs[_e431] = uint(_e422);
    int _e434 = scaled.value;
    local_30 = uint((base + 28u));
    uint _e440 = local_30;
    local_69 = uint(_e440);
    uint _e443 = local_69;
    _group_0_binding_1_cs[_e443] = uint(_e434);
    int _e448 = scaled.history[1];
    local_31 = uint((base + 29u));
    uint _e454 = local_31;
    local_70 = uint(_e454);
    uint _e457 = local_70;
    _group_0_binding_1_cs[_e457] = uint(_e448);
    int _e460 = original.value;
    local_32 = uint((base + 30u));
    uint _e466 = local_32;
    local_71 = uint(_e466);
    uint _e469 = local_71;
    _group_0_binding_1_cs[_e469] = uint(_e460);
    int _e474 = original.history[1];
    local_33 = uint((base + 31u));
    uint _e480 = local_33;
    local_72 = uint(_e480);
    uint _e483 = local_72;
    _group_0_binding_1_cs[_e483] = uint(_e474);
    Record_cuda_record_0_ _e485 = original;
    Record_cuda_record_0_ _e486 = operator_u002d_2(_e485);
    local_34 = uint((base + 32u));
    uint _e493 = local_34;
    local_73 = uint(_e493);
    uint _e496 = local_73;
    _group_0_binding_1_cs[_e496] = uint(_e486.value);
    Record_cuda_record_0_ _e498 = original;
    Record_cuda_record_0_ _e500 = operator_u002a_3(_e498, 2);
    local_35 = uint((base + 33u));
    uint _e507 = local_35;
    local_74 = uint(_e507);
    uint _e510 = local_74;
    _group_0_binding_1_cs[_e510] = uint(_e500.value);
    Record_cuda_record_0_ _e512 = original;
    Record_cuda_record_0_ _e513 = operator_u002a_2(_e512);
    int _e514 = operator_u0026_2(_e513);
    local_36 = uint((base + 34u));
    uint _e520 = local_36;
    local_75 = uint(_e520);
    uint _e523 = local_75;
    _group_0_binding_1_cs[_e523] = uint(_e514);
    bool _e528 = operator_u0021_(ivec2(0, 0));
    local_37 = uint((base + 35u));
    uint _e534 = local_37;
    local_76 = uint(_e534);
    uint _e537 = local_76;
    _group_0_binding_1_cs[_e537] = uint(_e528);
}

