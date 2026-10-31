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


int increment(int value_1) {
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = (_e3 + 2);
    int _e5 = value_2;
    return _e5;
}

int twice(int value_3) {
    int _e1 = increment(value_3);
    return (_e1 * 2);
}

int advance(int value_4) {
    int _e1 = twice(value_4);
    return (_e1 + 1);
}

int retreat(int value_5) {
    return (value_5 - 3);
}

float scaled(float value_6) {
    return ((value_6 * 1.5) + 0.5);
}

bool differs(int value_7, int other) {
    return (value_7 != other);
}

void consume(bool stop, int value_8) {
    int value_9 = 0;
    value_9 = value_8;
    if (stop) {
        return;
    }
    int _e3 = value_9;
    int _e4 = advance(_e3);
    value_9 = _e4;
    return;
}

void forward(bool stop_1, int value_10) {
    int _e2 = retreat(value_10);
    consume(stop_1, _e2);
    return;
}

uint plus_one(uint value_11) {
    return (value_11 + 1u);
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
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    int local_15 = 0;
    int local_16 = 0;
    int local_17 = 0;
    uint local_18 = 0u;
    int local_19 = 0;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    int local_26 = 0;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    int local_33 = 0;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = i;
        uint _e15 = local;
        local_18 = _e15;
        uint _e17 = local_18;
        int _e20 = _group_0_binding_1_cs[_e17];
        local_19 = _e20;
        int _e22 = local_19;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        choose = ((i - 2u * (i / 2u)) == 0u);
        int _e31 = value;
        int _e32 = increment(_e31);
        uint _e33 = base;
        local_1 = _e33;
        uint _e35 = local_1;
        local_20 = _e35;
        uint _e37 = local_20;
        _group_0_binding_0_cs[_e37] = _e32;
        int _e40 = value;
        int _e41 = twice(_e40);
        uint _e42 = base;
        local_2 = uint((_e42 + 1u));
        uint _e47 = local_2;
        local_21 = _e47;
        uint _e49 = local_21;
        _group_0_binding_0_cs[_e49] = _e41;
        int _e51 = value;
        int _e52 = advance(_e51);
        uint _e53 = base;
        local_3 = uint((_e53 + 2u));
        uint _e58 = local_3;
        local_22 = _e58;
        uint _e60 = local_22;
        _group_0_binding_0_cs[_e60] = _e52;
        int _e62 = value;
        int _e63 = retreat(_e62);
        uint _e64 = base;
        local_4 = uint((_e64 + 3u));
        uint _e69 = local_4;
        local_23 = _e69;
        uint _e71 = local_23;
        _group_0_binding_0_cs[_e71] = _e63;
        int _e73 = value;
        float _e75 = scaled(float(_e73));
        uint _e76 = base;
        local_5 = uint((_e76 + 4u));
        uint _e82 = local_5;
        local_24 = _e82;
        uint _e84 = local_24;
        _group_0_binding_0_cs[_e84] = int(_e75);
        int _e86 = value;
        local_7 = i;
        uint _e88 = local_7;
        local_25 = _e88;
        uint _e90 = local_25;
        int _e92 = _group_0_binding_1_cs[_e90];
        local_26 = _e92;
        int _e94 = local_26;
        local_16 = _e94;
        int _e96 = local_16;
        bool _e97 = differs(_e86, _e96);
        uint _e98 = base;
        local_6 = uint((_e98 + 5u));
        uint _e104 = local_6;
        local_27 = _e104;
        uint _e106 = local_27;
        _group_0_binding_0_cs[_e106] = int(_e97);
        int _e108 = value;
        effect = _e108;
        bool _e110 = choose;
        int _e111 = effect;
        effect = (_e111 + 1);
        consume(_e110, _e111);
        int _e114 = effect;
        uint _e115 = base;
        local_8 = uint((_e115 + 6u));
        uint _e120 = local_8;
        local_28 = _e120;
        uint _e122 = local_28;
        _group_0_binding_0_cs[_e122] = _e114;
        bool _e124 = choose;
        int _e126 = effect;
        effect = (_e126 + 1);
        forward(!(_e124), _e126);
        int _e129 = effect;
        uint _e130 = base;
        local_9 = uint((_e130 + 7u));
        uint _e135 = local_9;
        local_29 = _e135;
        uint _e137 = local_29;
        _group_0_binding_0_cs[_e137] = _e129;
        int _e139 = effect;
        int _e140 = advance(_e139);
        uint _e141 = base;
        local_10 = uint((_e141 + 8u));
        uint _e146 = local_10;
        local_30 = _e146;
        uint _e148 = local_30;
        _group_0_binding_0_cs[_e148] = _e140;
        int _e150 = effect;
        uint _e154 = plus_one(uint((_e150 + 16)));
        uint _e155 = base;
        local_11 = uint((_e155 + 9u));
        uint _e161 = local_11;
        local_31 = _e161;
        uint _e163 = local_31;
        _group_0_binding_0_cs[_e163] = int(_e154);
        int _e165 = effect;
        local_13 = i;
        uint _e167 = local_13;
        local_32 = _e167;
        uint _e169 = local_32;
        int _e171 = _group_0_binding_1_cs[_e169];
        local_33 = _e171;
        int _e173 = local_33;
        local_17 = _e173;
        int _e175 = local_17;
        bool _e176 = differs(_e165, _e175);
        uint _e177 = base;
        local_12 = uint((_e177 + 10u));
        uint _e183 = local_12;
        local_34 = _e183;
        uint _e185 = local_34;
        _group_0_binding_0_cs[_e185] = int(_e176);
        int _e187 = effect;
        uint _e188 = base;
        local_14 = uint((_e188 + 11u));
        uint _e193 = local_14;
        local_35 = _e193;
        uint _e195 = local_35;
        _group_0_binding_0_cs[_e195] = _e187;
    }
}

