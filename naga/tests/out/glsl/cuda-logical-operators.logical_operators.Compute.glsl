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
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    bool local_24 = false;
    uint local_25 = 0u;
    bool local_26 = false;
    uint local_27 = 0u;
    bool local_28 = false;
    uint local_29 = 0u;
    bool local_30 = false;
    uint local_31 = 0u;
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
    _group_0_binding_0_cs[_e35] = uint(_e29);
    int _e41 = both.payload[1];
    local_1 = uint((base + 1u));
    uint _e47 = local_1;
    _group_0_binding_0_cs[_e47] = uint(_e41);
    int _e50 = either.value;
    local_2 = uint((base + 2u));
    uint _e56 = local_2;
    _group_0_binding_0_cs[_e56] = uint(_e50);
    int _e61 = either.payload[0];
    local_3 = uint((base + 3u));
    uint _e67 = local_3;
    _group_0_binding_0_cs[_e67] = uint(_e61);
    int _e70 = left.value;
    local_4 = uint((base + 4u));
    uint _e76 = local_4;
    _group_0_binding_0_cs[_e76] = uint(_e70);
    int _e81 = left.payload[1];
    local_5 = uint((base + 5u));
    uint _e87 = local_5;
    _group_0_binding_0_cs[_e87] = uint(_e81);
    Sample_cuda_record_0_ _e89 = left;
    int _e91 = operator_u0026_u0026_1(_e89, 9);
    local_6 = uint((base + 6u));
    uint _e97 = local_6;
    _group_0_binding_0_cs[_e97] = uint(_e91);
    Sample_cuda_record_0_ _e99 = right;
    int _e101 = operator_u007c_u007c_1(0, _e99);
    local_7 = uint((base + 7u));
    uint _e107 = local_7;
    _group_0_binding_0_cs[_e107] = uint(_e101);
    Sample_cuda_record_0_ _e109 = left;
    Sample_cuda_record_0_ _e110 = right;
    Sample_cuda_record_0_ _e111 = operator_u0026_u0026_(_e109, _e110);
    local_8 = uint((base + 8u));
    uint _e118 = local_8;
    _group_0_binding_0_cs[_e118] = uint(_e111.value);
    Sample_cuda_record_0_ _e120 = left;
    Sample_cuda_record_0_ _e121 = right;
    Sample_cuda_record_0_ _e122 = operator_u007c_u007c(_e120, _e121);
    local_9 = uint((base + 9u));
    uint _e131 = local_9;
    _group_0_binding_0_cs[_e131] = uint(_e122.payload[0]);
    first = ivec2(2, 3);
    second = ivec2(4, 5);
    ivec2 _e141 = first;
    ivec2 _e142 = second;
    ivec2 _e143 = operator_u0026_u0026_2(_e141, _e142);
    local_10 = uint((base + 10u));
    uint _e150 = local_10;
    _group_0_binding_0_cs[_e150] = uint(_e143.x);
    ivec2 _e152 = first;
    ivec2 _e153 = second;
    ivec2 _e154 = operator_u007c_u007c_2(_e152, _e153);
    local_11 = uint((base + 11u));
    uint _e161 = local_11;
    _group_0_binding_0_cs[_e161] = uint(_e154.y);
    ivec2 _e163 = first;
    ivec2 _e164 = second;
    ivec2 _e165 = operator_u0026_u0026_2(_e163, _e164);
    ivec2 _e166 = first;
    ivec2 _e167 = operator_u0026_u0026_2(_e165, _e166);
    local_12 = uint((base + 12u));
    uint _e174 = local_12;
    _group_0_binding_0_cs[_e174] = uint(_e167.x);
    ivec2 _e176 = first;
    ivec2 _e177 = second;
    ivec2 _e178 = first;
    ivec2 _e179 = operator_u0026_u0026_2(_e177, _e178);
    ivec2 _e180 = operator_u007c_u007c_2(_e176, _e179);
    local_13 = uint((base + 13u));
    uint _e187 = local_13;
    _group_0_binding_0_cs[_e187] = uint(_e180.y);
    ivec2 _e189 = first;
    ivec2 _e190 = second;
    ivec2 _e191 = operator_u007c_u007c_2(_e189, _e190);
    ivec2 _e192 = first;
    ivec2 _e193 = operator_u0026_u0026_2(_e191, _e192);
    local_14 = uint((base + 14u));
    uint _e200 = local_14;
    _group_0_binding_0_cs[_e200] = uint(_e193.x);
    if (true) {
        Sample_cuda_record_0_ _e203 = left;
        local_16 = _e203;
    } else {
        Sample_cuda_record_0_ _e205 = right;
        local_16 = _e205;
    }
    Sample_cuda_record_0_ _e208 = local_16;
    int _e210 = operator_u0026_u0026_1(_e208, 1);
    local_15 = uint((base + 15u));
    uint _e216 = local_15;
    _group_0_binding_0_cs[_e216] = uint(_e210);
    if (true) {
        Sample_cuda_record_0_ _e219 = left;
        Sample_cuda_record_0_ _e220 = right;
        Sample_cuda_record_0_ _e221 = operator_u0026_u0026_(_e219, _e220);
        local_18 = _e221;
    } else {
        Sample_cuda_record_0_ _e223 = right;
        Sample_cuda_record_0_ _e224 = left;
        Sample_cuda_record_0_ _e225 = operator_u007c_u007c(_e223, _e224);
        local_18 = _e225;
    }
    Sample_cuda_record_0_ _e228 = local_18;
    local_17 = uint((base + 16u));
    uint _e235 = local_17;
    _group_0_binding_0_cs[_e235] = uint(_e228.value);
    counter = 0;
    if (false) {
        int _e240 = counter;
        counter = (_e240 + 1);
        local_19.value = _e240;
        local_19.payload[0] = 1;
        local_19.payload[1] = 2;
        Sample_cuda_record_0_ _e250 = local_19;
        Sample_cuda_record_0_ _e251 = right;
        Sample_cuda_record_0_ _e252 = operator_u0026_u0026_(_e250, _e251);
        evaluated = _e252;
    } else {
        Sample_cuda_record_0_ _e254 = left;
        int _e255 = counter;
        counter = (_e255 + 1);
        local_20.value = _e255;
        local_20.payload[0] = 1;
        local_20.payload[1] = 2;
        Sample_cuda_record_0_ _e265 = local_20;
        Sample_cuda_record_0_ _e266 = operator_u007c_u007c(_e254, _e265);
        evaluated = _e266;
    }
    int _e270 = evaluated.value;
    local_21 = uint((base + 17u));
    uint _e276 = local_21;
    _group_0_binding_0_cs[_e276] = uint(_e270);
    int _e278 = counter;
    local_22 = uint((base + 18u));
    uint _e284 = local_22;
    _group_0_binding_0_cs[_e284] = uint(_e278);
    local_24 = false;
    if (false) {
        Sample_cuda_record_0_ _e288 = left;
        Sample_cuda_record_0_ _e289 = right;
        Sample_cuda_record_0_ _e290 = operator_u0026_u0026_(_e288, _e289);
        local_24 = (_e290.value != 0);
    }
    bool _e294 = local_24;
    local_23 = uint((base + 19u));
    uint _e300 = local_23;
    _group_0_binding_0_cs[_e300] = uint(_e294);
    local_26 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e304 = left;
        Sample_cuda_record_0_ _e305 = right;
        Sample_cuda_record_0_ _e306 = operator_u007c_u007c(_e304, _e305);
        local_26 = (_e306.value != 0);
    }
    bool _e310 = local_26;
    local_25 = uint((base + 20u));
    uint _e316 = local_25;
    _group_0_binding_0_cs[_e316] = uint(_e310);
    bool _e320 = (2 != 0);
    local_28 = _e320;
    if (_e320) {
        local_28 = (3 != 0);
    }
    bool _e325 = local_28;
    local_27 = uint((base + 21u));
    uint _e331 = local_27;
    _group_0_binding_0_cs[_e331] = uint(_e325);
    bool _e335 = (0 != 0);
    local_30 = _e335;
    if (_e335) {
    } else {
        local_30 = (4 != 0);
    }
    bool _e340 = local_30;
    local_29 = uint((base + 22u));
    uint _e346 = local_29;
    _group_0_binding_0_cs[_e346] = uint(_e340);
    local_31 = uint((base + 23u));
    uint _e353 = local_31;
    _group_0_binding_0_cs[_e353] = threadIdx.x;
}

