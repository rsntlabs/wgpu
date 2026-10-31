#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };


bool classify(bool value_1) {
    return !(value_1);
}

int classify_1(int value_2) {
    return (value_2 + 10);
}

uint classify_2(uint value_3) {
    return (value_3 + 20u);
}

float classify_3(float value_4) {
    return ((value_4 * 1.5) + 0.5);
}

int rank(int left, float right) {
    return ((left * 10) + int(right));
}

int rank_1(float left_1, int right_1) {
    return ((100 + (int(left_1) * 10)) + right_1);
}

int pair(float left_2, int right_2) {
    return ((int(left_2) * 10) + right_2);
}

int promote(uint left_3, float right_3) {
    return ((200 + int(left_3)) + int(right_3));
}

void touch(bool stop, int value_5) {
    int value_6 = 0;
    value_6 = value_5;
    if (stop) {
        return;
    }
    int _e3 = value_6;
    int _e4 = classify_1(_e3);
    value_6 = _e4;
    return;
}

int touch_1(int value_7) {
    int _e1 = classify_1(value_7);
    return (_e1 + 3);
}

int stage(int value_8) {
    return (value_8 + 2);
}

int frozen(float value_9) {
    int _e2 = stage(int(value_9));
    return _e2;
}

int stage_1(float value_10) {
    return (int(value_10) + 100);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint base = 0u;
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    bool choose = false;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    int effect = 0;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    int nested = 0;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    int argument = 0;
    int captured = 0;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    int local_28 = 0;
    uint local_29[2] = uint[2](0u, 0u);
    uint local_30 = 0u;
    uint local_31 = 0u;
    int local_32 = 0;
    uint local_33[2] = uint[2](0u, 0u);
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39[2] = uint[2](0u, 0u);
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42[2] = uint[2](0u, 0u);
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45[2] = uint[2](0u, 0u);
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48[2] = uint[2](0u, 0u);
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60[2] = uint[2](0u, 0u);
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63[2] = uint[2](0u, 0u);
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66[2] = uint[2](0u, 0u);
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69[2] = uint[2](0u, 0u);
    uint local_70 = 0u;
    uint local_71 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 1u;
    input_[1] = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 13u);
        uint _e27[2] = input_;
        local = _e27;
        local_1 = uint(i);
        uint _e31[2] = local;
        local_29 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_29[1];
        local_29[1] = (_e35 + _e33);
        uint _e39 = local_29[0];
        local_30 = uint(_e39);
        uint _e43 = local_29[1];
        local_31 = uint(_e43);
        uint _e46 = local_31;
        int _e49 = _group_0_binding_1_cs[_e46];
        local_32 = _e49;
        int _e51 = local_32;
        local_28 = _e51;
        int _e53 = local_28;
        value = _e53;
        choose = ((i - 2u * (i / 2u)) == 0u);
        bool _e60 = choose;
        bool _e61 = classify(_e60);
        uint _e63[2] = out_;
        local_2 = _e63;
        uint _e65 = base;
        local_3 = uint(_e65);
        uint _e69[2] = local_2;
        local_33 = _e69;
        uint _e71 = local_3;
        uint _e73 = local_33[1];
        local_33[1] = (_e73 + _e71);
        uint _e77 = local_33[0];
        local_34 = uint(_e77);
        uint _e81 = local_33[1];
        local_35 = uint(_e81);
        uint _e84 = local_35;
        _group_0_binding_0_cs[_e84] = int(_e61);
        int _e87 = value;
        int _e88 = classify_1(_e87);
        uint _e89[2] = out_;
        local_4 = _e89;
        uint _e91 = base;
        local_5 = uint((_e91 + 1u));
        uint _e96[2] = local_4;
        local_36 = _e96;
        uint _e98 = local_5;
        uint _e100 = local_36[1];
        local_36[1] = (_e100 + _e98);
        uint _e104 = local_36[0];
        local_37 = uint(_e104);
        uint _e108 = local_36[1];
        local_38 = uint(_e108);
        uint _e111 = local_38;
        _group_0_binding_0_cs[_e111] = _e88;
        int _e113 = value;
        uint _e117 = classify_2(uint((_e113 + 16)));
        uint _e118[2] = out_;
        local_6 = _e118;
        uint _e120 = base;
        local_7 = uint((_e120 + 2u));
        uint _e126[2] = local_6;
        local_39 = _e126;
        uint _e128 = local_7;
        uint _e130 = local_39[1];
        local_39[1] = (_e130 + _e128);
        uint _e134 = local_39[0];
        local_40 = uint(_e134);
        uint _e138 = local_39[1];
        local_41 = uint(_e138);
        uint _e141 = local_41;
        _group_0_binding_0_cs[_e141] = int(_e117);
        int _e143 = value;
        float _e145 = classify_3(float(_e143));
        uint _e146[2] = out_;
        local_8 = _e146;
        uint _e148 = base;
        local_9 = uint((_e148 + 3u));
        uint _e154[2] = local_8;
        local_42 = _e154;
        uint _e156 = local_9;
        uint _e158 = local_42[1];
        local_42[1] = (_e158 + _e156);
        uint _e162 = local_42[0];
        local_43 = uint(_e162);
        uint _e166 = local_42[1];
        local_44 = uint(_e166);
        uint _e169 = local_44;
        _group_0_binding_0_cs[_e169] = int(_e145);
        bool _e171 = choose;
        int _e172 = value;
        int _e177 = rank(int(_e171), (float(_e172) + 0.5));
        uint _e178[2] = out_;
        local_10 = _e178;
        uint _e180 = base;
        local_11 = uint((_e180 + 4u));
        uint _e185[2] = local_10;
        local_45 = _e185;
        uint _e187 = local_11;
        uint _e189 = local_45[1];
        local_45[1] = (_e189 + _e187);
        uint _e193 = local_45[0];
        local_46 = uint(_e193);
        uint _e197 = local_45[1];
        local_47 = uint(_e197);
        uint _e200 = local_47;
        _group_0_binding_0_cs[_e200] = _e177;
        int _e202 = value;
        bool _e206 = choose;
        int _e208 = rank_1((float(_e202) + 0.5), int(_e206));
        uint _e209[2] = out_;
        local_12 = _e209;
        uint _e211 = base;
        local_13 = uint((_e211 + 5u));
        uint _e216[2] = local_12;
        local_48 = _e216;
        uint _e218 = local_13;
        uint _e220 = local_48[1];
        local_48[1] = (_e220 + _e218);
        uint _e224 = local_48[0];
        local_49 = uint(_e224);
        uint _e228 = local_48[1];
        local_50 = uint(_e228);
        uint _e231 = local_50;
        _group_0_binding_0_cs[_e231] = _e208;
        int _e233 = value;
        int _e237 = value;
        int _e239 = promote(uint((_e233 + 16)), float(_e237));
        uint _e240[2] = out_;
        local_14 = _e240;
        uint _e242 = base;
        local_15 = uint((_e242 + 6u));
        uint _e247[2] = local_14;
        local_51 = _e247;
        uint _e249 = local_15;
        uint _e251 = local_51[1];
        local_51[1] = (_e251 + _e249);
        uint _e255 = local_51[0];
        local_52 = uint(_e255);
        uint _e259 = local_51[1];
        local_53 = uint(_e259);
        uint _e262 = local_53;
        _group_0_binding_0_cs[_e262] = _e239;
        int _e264 = value;
        effect = _e264;
        bool _e266 = choose;
        int _e267 = effect;
        effect = (_e267 + 1);
        touch(_e266, _e267);
        int _e270 = effect;
        uint _e271[2] = out_;
        local_16 = _e271;
        uint _e273 = base;
        local_17 = uint((_e273 + 7u));
        uint _e278[2] = local_16;
        local_54 = _e278;
        uint _e280 = local_17;
        uint _e282 = local_54[1];
        local_54[1] = (_e282 + _e280);
        uint _e286 = local_54[0];
        local_55 = uint(_e286);
        uint _e290 = local_54[1];
        local_56 = uint(_e290);
        uint _e293 = local_56;
        _group_0_binding_0_cs[_e293] = _e270;
        int _e295 = effect;
        int _e296 = touch_1(_e295);
        uint _e297[2] = out_;
        local_18 = _e297;
        uint _e299 = base;
        local_19 = uint((_e299 + 8u));
        uint _e304[2] = local_18;
        local_57 = _e304;
        uint _e306 = local_19;
        uint _e308 = local_57[1];
        local_57[1] = (_e308 + _e306);
        uint _e312 = local_57[0];
        local_58 = uint(_e312);
        uint _e316 = local_57[1];
        local_59 = uint(_e316);
        uint _e319 = local_59;
        _group_0_binding_0_cs[_e319] = _e296;
        int _e321 = value;
        int _e325 = frozen((float(_e321) + 0.75));
        uint _e326[2] = out_;
        local_20 = _e326;
        uint _e328 = base;
        local_21 = uint((_e328 + 9u));
        uint _e333[2] = local_20;
        local_60 = _e333;
        uint _e335 = local_21;
        uint _e337 = local_60[1];
        local_60[1] = (_e337 + _e335);
        uint _e341 = local_60[0];
        local_61 = uint(_e341);
        uint _e345 = local_60[1];
        local_62 = uint(_e345);
        uint _e348 = local_62;
        _group_0_binding_0_cs[_e348] = _e325;
        int _e350 = value;
        int _e354 = stage_1((float(_e350) + 0.75));
        uint _e355[2] = out_;
        local_22 = _e355;
        uint _e357 = base;
        local_23 = uint((_e357 + 10u));
        uint _e362[2] = local_22;
        local_63 = _e362;
        uint _e364 = local_23;
        uint _e366 = local_63[1];
        local_63[1] = (_e366 + _e364);
        uint _e370 = local_63[0];
        local_64 = uint(_e370);
        uint _e374 = local_63[1];
        local_65 = uint(_e374);
        uint _e377 = local_65;
        _group_0_binding_0_cs[_e377] = _e354;
        int _e379 = effect;
        effect = (_e379 + 1);
        int _e382 = classify_1(_e379);
        int _e383 = touch_1(_e382);
        nested = _e383;
        int _e385 = nested;
        int _e388 = effect;
        uint _e390[2] = out_;
        local_24 = _e390;
        uint _e392 = base;
        local_25 = uint((_e392 + 11u));
        uint _e397[2] = local_24;
        local_66 = _e397;
        uint _e399 = local_25;
        uint _e401 = local_66[1];
        local_66[1] = (_e401 + _e399);
        uint _e405 = local_66[0];
        local_67 = uint(_e405);
        uint _e409 = local_66[1];
        local_68 = uint(_e409);
        uint _e412 = local_68;
        _group_0_binding_0_cs[_e412] = ((_e385 * 10) + _e388);
        int _e414 = value;
        argument = (_e414 + 8);
        int _e418 = argument;
        int _e419 = argument;
        argument = (_e419 + 1);
        int _e423 = pair(float(_e418), _e419);
        captured = _e423;
        int _e425 = captured;
        int _e428 = argument;
        uint _e430[2] = out_;
        local_26 = _e430;
        uint _e432 = base;
        local_27 = uint((_e432 + 12u));
        uint _e437[2] = local_26;
        local_69 = _e437;
        uint _e439 = local_27;
        uint _e441 = local_69[1];
        local_69[1] = (_e441 + _e439);
        uint _e445 = local_69[0];
        local_70 = uint(_e445);
        uint _e449 = local_69[1];
        local_71 = uint(_e449);
        uint _e452 = local_71;
        _group_0_binding_0_cs[_e452] = ((_e425 * 100) + _e428);
    }
}

