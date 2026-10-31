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
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = _group_0_binding_1_cs[_e17];
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = ((i - 2u * (i / 2u)) == 0u);
        bool _e31 = choose;
        bool _e32 = classify(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e36 = local_1;
        local_17 = _e36;
        uint _e38 = local_17;
        _group_0_binding_0_cs[_e38] = int(_e32);
        int _e41 = value;
        int _e42 = classify_1(_e41);
        uint _e43 = base;
        local_2 = uint((_e43 + 1u));
        uint _e48 = local_2;
        local_18 = _e48;
        uint _e50 = local_18;
        _group_0_binding_0_cs[_e50] = _e42;
        int _e52 = value;
        uint _e56 = classify_2(uint((_e52 + 16)));
        uint _e57 = base;
        local_3 = uint((_e57 + 2u));
        uint _e63 = local_3;
        local_19 = _e63;
        uint _e65 = local_19;
        _group_0_binding_0_cs[_e65] = int(_e56);
        int _e67 = value;
        float _e69 = classify_3(float(_e67));
        uint _e70 = base;
        local_4 = uint((_e70 + 3u));
        uint _e76 = local_4;
        local_20 = _e76;
        uint _e78 = local_20;
        _group_0_binding_0_cs[_e78] = int(_e69);
        bool _e80 = choose;
        int _e81 = value;
        int _e86 = rank(int(_e80), (float(_e81) + 0.5));
        uint _e87 = base;
        local_5 = uint((_e87 + 4u));
        uint _e92 = local_5;
        local_21 = _e92;
        uint _e94 = local_21;
        _group_0_binding_0_cs[_e94] = _e86;
        int _e96 = value;
        bool _e100 = choose;
        int _e102 = rank_1((float(_e96) + 0.5), int(_e100));
        uint _e103 = base;
        local_6 = uint((_e103 + 5u));
        uint _e108 = local_6;
        local_22 = _e108;
        uint _e110 = local_22;
        _group_0_binding_0_cs[_e110] = _e102;
        int _e112 = value;
        int _e116 = value;
        int _e118 = promote(uint((_e112 + 16)), float(_e116));
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e124 = local_7;
        local_23 = _e124;
        uint _e126 = local_23;
        _group_0_binding_0_cs[_e126] = _e118;
        int _e128 = value;
        effect = _e128;
        bool _e130 = choose;
        int _e131 = effect;
        effect = (_e131 + 1);
        touch(_e130, _e131);
        int _e134 = effect;
        uint _e135 = base;
        local_8 = uint((_e135 + 7u));
        uint _e140 = local_8;
        local_24 = _e140;
        uint _e142 = local_24;
        _group_0_binding_0_cs[_e142] = _e134;
        int _e144 = effect;
        int _e145 = touch_1(_e144);
        uint _e146 = base;
        local_9 = uint((_e146 + 8u));
        uint _e151 = local_9;
        local_25 = _e151;
        uint _e153 = local_25;
        _group_0_binding_0_cs[_e153] = _e145;
        int _e155 = value;
        int _e159 = frozen((float(_e155) + 0.75));
        uint _e160 = base;
        local_10 = uint((_e160 + 9u));
        uint _e165 = local_10;
        local_26 = _e165;
        uint _e167 = local_26;
        _group_0_binding_0_cs[_e167] = _e159;
        int _e169 = value;
        int _e173 = stage_1((float(_e169) + 0.75));
        uint _e174 = base;
        local_11 = uint((_e174 + 10u));
        uint _e179 = local_11;
        local_27 = _e179;
        uint _e181 = local_27;
        _group_0_binding_0_cs[_e181] = _e173;
        int _e183 = effect;
        effect = (_e183 + 1);
        int _e186 = classify_1(_e183);
        int _e187 = touch_1(_e186);
        nested = _e187;
        int _e189 = nested;
        int _e192 = effect;
        uint _e194 = base;
        local_12 = uint((_e194 + 11u));
        uint _e199 = local_12;
        local_28 = _e199;
        uint _e201 = local_28;
        _group_0_binding_0_cs[_e201] = ((_e189 * 10) + _e192);
        int _e203 = value;
        argument = (_e203 + 8);
        int _e207 = argument;
        int _e208 = argument;
        argument = (_e208 + 1);
        int _e212 = pair(float(_e207), _e208);
        captured = _e212;
        int _e214 = captured;
        int _e217 = argument;
        uint _e219 = base;
        local_13 = uint((_e219 + 12u));
        uint _e224 = local_13;
        local_29 = _e224;
        uint _e226 = local_29;
        _group_0_binding_0_cs[_e226] = ((_e214 * 100) + _e217);
    }
}

