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
    bool value_2 = false;
    value_2 = value_1;
    bool _e2 = value_2;
    return !(_e2);
}

int classify_1(int value_3) {
    int value_4 = 0;
    value_4 = value_3;
    int _e3 = value_4;
    return (_e3 + 10);
}

uint classify_2(uint value_5) {
    uint value_6 = 0u;
    value_6 = value_5;
    uint _e3 = value_6;
    return (_e3 + 20u);
}

float classify_3(float value_7) {
    float value_8 = 0.0;
    value_8 = value_7;
    float _e3 = value_8;
    return ((_e3 * 1.5) + 0.5);
}

int rank(int left, float right) {
    int left_1 = 0;
    float right_1 = 0.0;
    left_1 = left;
    right_1 = right;
    int _e5 = left_1;
    float _e7 = right_1;
    return ((_e5 * 10) + int(_e7));
}

int rank_1(float left_2, int right_2) {
    float left_3 = 0.0;
    int right_3 = 0;
    left_3 = left_2;
    right_3 = right_2;
    float _e5 = left_3;
    int _e10 = right_3;
    return ((100 + (int(_e5) * 10)) + _e10);
}

int pair(float left_4, int right_4) {
    float left_5 = 0.0;
    int right_5 = 0;
    left_5 = left_4;
    right_5 = right_4;
    float _e4 = left_5;
    int _e8 = right_5;
    return ((int(_e4) * 10) + _e8);
}

int promote(uint left_6, float right_6) {
    uint left_7 = 0u;
    float right_7 = 0.0;
    left_7 = left_6;
    right_7 = right_6;
    uint _e5 = left_7;
    float _e8 = right_7;
    return ((200 + int(_e5)) + int(_e8));
}

void touch(bool stop, int value_9) {
    bool stop_1 = false;
    int value_10 = 0;
    stop_1 = stop;
    value_10 = value_9;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_10;
    int _e6 = classify_1(_e5);
    value_10 = _e6;
    return;
}

int touch_1(int value_11) {
    int value_12 = 0;
    value_12 = value_11;
    int _e2 = value_12;
    int _e3 = classify_1(_e2);
    return (_e3 + 3);
}

int stage(int value_13) {
    int value_14 = 0;
    value_14 = value_13;
    int _e3 = value_14;
    return (_e3 + 2);
}

int frozen(float value_15) {
    float value_16 = 0.0;
    value_16 = value_15;
    float _e2 = value_16;
    int _e4 = stage(int(_e2));
    return _e4;
}

int stage_1(float value_17) {
    float value_18 = 0.0;
    value_18 = value_17;
    float _e2 = value_18;
    return (int(_e2) + 100);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
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
    uint _e18 = _group_0_binding_2_cs.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 13u);
        uint _e35[2] = input_;
        local = _e35;
        uint _e36 = i;
        local_1 = uint(_e36);
        uint _e40[2] = local;
        local_29 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_29[1];
        local_29[1] = (_e43 + _e41);
        uint _e47 = local_29[0];
        local_30 = uint(_e47);
        uint _e51 = local_29[1];
        local_31 = uint(_e51);
        uint _e55 = local_31;
        int _e57 = _group_0_binding_1_cs[_e55];
        local_32 = _e57;
        int _e58 = local_32;
        local_28 = _e58;
        int _e60 = local_28;
        value = _e60;
        uint _e62 = i;
        choose = ((_e62 - 2u * (_e62 / 2u)) == 0u);
        bool _e68 = choose;
        bool _e69 = classify(_e68);
        uint _e72[2] = out_;
        local_2 = _e72;
        uint _e73 = base;
        local_3 = uint(_e73);
        uint _e78[2] = local_2;
        local_33 = _e78;
        uint _e79 = local_3;
        uint _e81 = local_33[1];
        local_33[1] = (_e81 + _e79);
        uint _e85 = local_33[0];
        local_34 = uint(_e85);
        uint _e89 = local_33[1];
        local_35 = uint(_e89);
        uint _e92 = local_35;
        _group_0_binding_0_cs[_e92] = int(_e69);
        int _e94 = value;
        int _e95 = classify_1(_e94);
        uint _e97[2] = out_;
        local_4 = _e97;
        uint _e98 = base;
        local_5 = uint((_e98 + 1u));
        uint _e104[2] = local_4;
        local_36 = _e104;
        uint _e105 = local_5;
        uint _e107 = local_36[1];
        local_36[1] = (_e107 + _e105);
        uint _e111 = local_36[0];
        local_37 = uint(_e111);
        uint _e115 = local_36[1];
        local_38 = uint(_e115);
        uint _e118 = local_38;
        _group_0_binding_0_cs[_e118] = _e95;
        int _e120 = value;
        uint _e124 = classify_2(uint((_e120 + 16)));
        uint _e126[2] = out_;
        local_6 = _e126;
        uint _e127 = base;
        local_7 = uint((_e127 + 2u));
        uint _e134[2] = local_6;
        local_39 = _e134;
        uint _e135 = local_7;
        uint _e137 = local_39[1];
        local_39[1] = (_e137 + _e135);
        uint _e141 = local_39[0];
        local_40 = uint(_e141);
        uint _e145 = local_39[1];
        local_41 = uint(_e145);
        uint _e148 = local_41;
        _group_0_binding_0_cs[_e148] = int(_e124);
        int _e150 = value;
        float _e152 = classify_3(float(_e150));
        uint _e154[2] = out_;
        local_8 = _e154;
        uint _e155 = base;
        local_9 = uint((_e155 + 3u));
        uint _e162[2] = local_8;
        local_42 = _e162;
        uint _e163 = local_9;
        uint _e165 = local_42[1];
        local_42[1] = (_e165 + _e163);
        uint _e169 = local_42[0];
        local_43 = uint(_e169);
        uint _e173 = local_42[1];
        local_44 = uint(_e173);
        uint _e176 = local_44;
        _group_0_binding_0_cs[_e176] = int(_e152);
        bool _e178 = choose;
        int _e179 = value;
        int _e184 = rank(int(_e178), (float(_e179) + 0.5));
        uint _e186[2] = out_;
        local_10 = _e186;
        uint _e187 = base;
        local_11 = uint((_e187 + 4u));
        uint _e193[2] = local_10;
        local_45 = _e193;
        uint _e194 = local_11;
        uint _e196 = local_45[1];
        local_45[1] = (_e196 + _e194);
        uint _e200 = local_45[0];
        local_46 = uint(_e200);
        uint _e204 = local_45[1];
        local_47 = uint(_e204);
        uint _e207 = local_47;
        _group_0_binding_0_cs[_e207] = _e184;
        int _e209 = value;
        bool _e213 = choose;
        int _e215 = rank_1((float(_e209) + 0.5), int(_e213));
        uint _e217[2] = out_;
        local_12 = _e217;
        uint _e218 = base;
        local_13 = uint((_e218 + 5u));
        uint _e224[2] = local_12;
        local_48 = _e224;
        uint _e225 = local_13;
        uint _e227 = local_48[1];
        local_48[1] = (_e227 + _e225);
        uint _e231 = local_48[0];
        local_49 = uint(_e231);
        uint _e235 = local_48[1];
        local_50 = uint(_e235);
        uint _e238 = local_50;
        _group_0_binding_0_cs[_e238] = _e215;
        int _e240 = value;
        int _e244 = value;
        int _e246 = promote(uint((_e240 + 16)), float(_e244));
        uint _e248[2] = out_;
        local_14 = _e248;
        uint _e249 = base;
        local_15 = uint((_e249 + 6u));
        uint _e255[2] = local_14;
        local_51 = _e255;
        uint _e256 = local_15;
        uint _e258 = local_51[1];
        local_51[1] = (_e258 + _e256);
        uint _e262 = local_51[0];
        local_52 = uint(_e262);
        uint _e266 = local_51[1];
        local_53 = uint(_e266);
        uint _e269 = local_53;
        _group_0_binding_0_cs[_e269] = _e246;
        int _e271 = value;
        effect = _e271;
        bool _e273 = choose;
        int _e274 = effect;
        effect = (_e274 + 1);
        touch(_e273, _e274);
        int _e277 = effect;
        uint _e279[2] = out_;
        local_16 = _e279;
        uint _e280 = base;
        local_17 = uint((_e280 + 7u));
        uint _e286[2] = local_16;
        local_54 = _e286;
        uint _e287 = local_17;
        uint _e289 = local_54[1];
        local_54[1] = (_e289 + _e287);
        uint _e293 = local_54[0];
        local_55 = uint(_e293);
        uint _e297 = local_54[1];
        local_56 = uint(_e297);
        uint _e300 = local_56;
        _group_0_binding_0_cs[_e300] = _e277;
        int _e302 = effect;
        int _e303 = touch_1(_e302);
        uint _e305[2] = out_;
        local_18 = _e305;
        uint _e306 = base;
        local_19 = uint((_e306 + 8u));
        uint _e312[2] = local_18;
        local_57 = _e312;
        uint _e313 = local_19;
        uint _e315 = local_57[1];
        local_57[1] = (_e315 + _e313);
        uint _e319 = local_57[0];
        local_58 = uint(_e319);
        uint _e323 = local_57[1];
        local_59 = uint(_e323);
        uint _e326 = local_59;
        _group_0_binding_0_cs[_e326] = _e303;
        int _e328 = value;
        int _e332 = frozen((float(_e328) + 0.75));
        uint _e334[2] = out_;
        local_20 = _e334;
        uint _e335 = base;
        local_21 = uint((_e335 + 9u));
        uint _e341[2] = local_20;
        local_60 = _e341;
        uint _e342 = local_21;
        uint _e344 = local_60[1];
        local_60[1] = (_e344 + _e342);
        uint _e348 = local_60[0];
        local_61 = uint(_e348);
        uint _e352 = local_60[1];
        local_62 = uint(_e352);
        uint _e355 = local_62;
        _group_0_binding_0_cs[_e355] = _e332;
        int _e357 = value;
        int _e361 = stage_1((float(_e357) + 0.75));
        uint _e363[2] = out_;
        local_22 = _e363;
        uint _e364 = base;
        local_23 = uint((_e364 + 10u));
        uint _e370[2] = local_22;
        local_63 = _e370;
        uint _e371 = local_23;
        uint _e373 = local_63[1];
        local_63[1] = (_e373 + _e371);
        uint _e377 = local_63[0];
        local_64 = uint(_e377);
        uint _e381 = local_63[1];
        local_65 = uint(_e381);
        uint _e384 = local_65;
        _group_0_binding_0_cs[_e384] = _e361;
        int _e386 = effect;
        effect = (_e386 + 1);
        int _e389 = classify_1(_e386);
        int _e390 = touch_1(_e389);
        nested = _e390;
        int _e392 = nested;
        int _e395 = effect;
        uint _e398[2] = out_;
        local_24 = _e398;
        uint _e399 = base;
        local_25 = uint((_e399 + 11u));
        uint _e405[2] = local_24;
        local_66 = _e405;
        uint _e406 = local_25;
        uint _e408 = local_66[1];
        local_66[1] = (_e408 + _e406);
        uint _e412 = local_66[0];
        local_67 = uint(_e412);
        uint _e416 = local_66[1];
        local_68 = uint(_e416);
        uint _e419 = local_68;
        _group_0_binding_0_cs[_e419] = ((_e392 * 10) + _e395);
        int _e421 = value;
        argument = (_e421 + 8);
        int _e425 = argument;
        int _e426 = argument;
        argument = (_e426 + 1);
        int _e430 = pair(float(_e425), _e426);
        captured = _e430;
        int _e432 = captured;
        int _e435 = argument;
        uint _e438[2] = out_;
        local_26 = _e438;
        uint _e439 = base;
        local_27 = uint((_e439 + 12u));
        uint _e445[2] = local_26;
        local_69 = _e445;
        uint _e446 = local_27;
        uint _e448 = local_69[1];
        local_69[1] = (_e448 + _e446);
        uint _e452 = local_69[0];
        local_70 = uint(_e452);
        uint _e456 = local_69[1];
        local_71 = uint(_e456);
        uint _e459 = local_71;
        _group_0_binding_0_cs[_e459] = ((_e432 * 100) + _e435);
    }
}

