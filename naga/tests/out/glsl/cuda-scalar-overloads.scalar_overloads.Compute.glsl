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
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    bool choose = false;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    int effect = 0;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int nested = 0;
    uint local_12 = 0u;
    int argument = 0;
    int captured = 0;
    uint local_13 = 0u;
    int local_14 = 0;
    uint local_15 = 0u;
    int local_16 = 0;
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
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 13u);
        local = uint(i);
        uint _e16 = local;
        local_15 = uint(_e16);
        uint _e19 = local_15;
        int _e22 = _group_0_binding_1_cs[_e19];
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = ((i - 2u * (i / 2u)) == 0u);
        bool _e33 = choose;
        bool _e34 = classify(_e33);
        uint _e35 = base;
        local_1 = uint(_e35);
        uint _e39 = local_1;
        local_17 = uint(_e39);
        uint _e42 = local_17;
        _group_0_binding_0_cs[_e42] = int(_e34);
        int _e45 = value;
        int _e46 = classify_1(_e45);
        uint _e47 = base;
        local_2 = uint((_e47 + 1u));
        uint _e52 = local_2;
        local_18 = uint(_e52);
        uint _e55 = local_18;
        _group_0_binding_0_cs[_e55] = _e46;
        int _e57 = value;
        uint _e61 = classify_2(uint((_e57 + 16)));
        uint _e62 = base;
        local_3 = uint((_e62 + 2u));
        uint _e68 = local_3;
        local_19 = uint(_e68);
        uint _e71 = local_19;
        _group_0_binding_0_cs[_e71] = int(_e61);
        int _e73 = value;
        float _e75 = classify_3(float(_e73));
        uint _e76 = base;
        local_4 = uint((_e76 + 3u));
        uint _e82 = local_4;
        local_20 = uint(_e82);
        uint _e85 = local_20;
        _group_0_binding_0_cs[_e85] = int(_e75);
        bool _e87 = choose;
        int _e88 = value;
        int _e93 = rank(int(_e87), (float(_e88) + 0.5));
        uint _e94 = base;
        local_5 = uint((_e94 + 4u));
        uint _e99 = local_5;
        local_21 = uint(_e99);
        uint _e102 = local_21;
        _group_0_binding_0_cs[_e102] = _e93;
        int _e104 = value;
        bool _e108 = choose;
        int _e110 = rank_1((float(_e104) + 0.5), int(_e108));
        uint _e111 = base;
        local_6 = uint((_e111 + 5u));
        uint _e116 = local_6;
        local_22 = uint(_e116);
        uint _e119 = local_22;
        _group_0_binding_0_cs[_e119] = _e110;
        int _e121 = value;
        int _e125 = value;
        int _e127 = promote(uint((_e121 + 16)), float(_e125));
        uint _e128 = base;
        local_7 = uint((_e128 + 6u));
        uint _e133 = local_7;
        local_23 = uint(_e133);
        uint _e136 = local_23;
        _group_0_binding_0_cs[_e136] = _e127;
        int _e138 = value;
        effect = _e138;
        bool _e140 = choose;
        int _e141 = effect;
        effect = (_e141 + 1);
        touch(_e140, _e141);
        int _e144 = effect;
        uint _e145 = base;
        local_8 = uint((_e145 + 7u));
        uint _e150 = local_8;
        local_24 = uint(_e150);
        uint _e153 = local_24;
        _group_0_binding_0_cs[_e153] = _e144;
        int _e155 = effect;
        int _e156 = touch_1(_e155);
        uint _e157 = base;
        local_9 = uint((_e157 + 8u));
        uint _e162 = local_9;
        local_25 = uint(_e162);
        uint _e165 = local_25;
        _group_0_binding_0_cs[_e165] = _e156;
        int _e167 = value;
        int _e171 = frozen((float(_e167) + 0.75));
        uint _e172 = base;
        local_10 = uint((_e172 + 9u));
        uint _e177 = local_10;
        local_26 = uint(_e177);
        uint _e180 = local_26;
        _group_0_binding_0_cs[_e180] = _e171;
        int _e182 = value;
        int _e186 = stage_1((float(_e182) + 0.75));
        uint _e187 = base;
        local_11 = uint((_e187 + 10u));
        uint _e192 = local_11;
        local_27 = uint(_e192);
        uint _e195 = local_27;
        _group_0_binding_0_cs[_e195] = _e186;
        int _e197 = effect;
        effect = (_e197 + 1);
        int _e200 = classify_1(_e197);
        int _e201 = touch_1(_e200);
        nested = _e201;
        int _e203 = nested;
        int _e206 = effect;
        uint _e208 = base;
        local_12 = uint((_e208 + 11u));
        uint _e213 = local_12;
        local_28 = uint(_e213);
        uint _e216 = local_28;
        _group_0_binding_0_cs[_e216] = ((_e203 * 10) + _e206);
        int _e218 = value;
        argument = (_e218 + 8);
        int _e222 = argument;
        int _e223 = argument;
        argument = (_e223 + 1);
        int _e227 = pair(float(_e222), _e223);
        captured = _e227;
        int _e229 = captured;
        int _e232 = argument;
        uint _e234 = base;
        local_13 = uint((_e234 + 12u));
        uint _e239 = local_13;
        local_29 = uint(_e239);
        uint _e242 = local_29;
        _group_0_binding_0_cs[_e242] = ((_e229 * 100) + _e232);
    }
}

