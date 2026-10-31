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

int doubled(int value_3) {
    int _e1 = increment(value_3);
    return (_e1 * 2);
}

uint advance(uint value_4) {
    return (value_4 + 3u);
}

uint retreat(uint value_5) {
    return (value_5 - 1u);
}

float scale(float value_6, int bias) {
    return ((value_6 * 1.5) + float(bias));
}

bool same(int left, int right) {
    return (left == right);
}

void consume(bool stop, int value_7) {
    int value_8 = 0;
    value_8 = value_7;
    if (stop) {
        return;
    }
    int _e3 = value_8;
    int _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

void forward(bool stop_1, int value_9) {
    int _e2 = increment(value_9);
    consume(stop_1, _e2);
    return;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
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
    uint local_26 = 0u;
    int local_27 = 0;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    int local_32 = 0;
    uint local_33 = 0u;
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
        int _e26 = value;
        int _e27 = increment(_e26);
        uint _e28 = base;
        local_1 = _e28;
        uint _e30 = local_1;
        local_20 = _e30;
        uint _e32 = local_20;
        _group_0_binding_0_cs[_e32] = _e27;
        int _e35 = value;
        uint _e36 = base;
        local_2 = uint((_e36 + 1u));
        uint _e41 = local_2;
        local_21 = _e41;
        uint _e43 = local_21;
        _group_0_binding_0_cs[_e43] = _e35;
        int _e45 = value;
        int _e46 = doubled(_e45);
        uint _e47 = base;
        local_3 = uint((_e47 + 2u));
        uint _e52 = local_3;
        local_22 = _e52;
        uint _e54 = local_22;
        _group_0_binding_0_cs[_e54] = _e46;
        int _e56 = value;
        uint _e58 = advance(uint(_e56));
        uint _e59 = base;
        local_4 = uint((_e59 + 3u));
        uint _e65 = local_4;
        local_23 = _e65;
        uint _e67 = local_23;
        _group_0_binding_0_cs[_e67] = int(_e58);
        int _e69 = value;
        uint _e71 = retreat(uint(_e69));
        uint _e72 = base;
        local_5 = uint((_e72 + 4u));
        uint _e78 = local_5;
        local_24 = _e78;
        uint _e80 = local_24;
        _group_0_binding_0_cs[_e80] = int(_e71);
        int _e82 = value;
        float _e85 = scale(float(_e82), 2);
        uint _e86 = base;
        local_6 = uint((_e86 + 5u));
        uint _e92 = local_6;
        local_25 = _e92;
        uint _e94 = local_25;
        _group_0_binding_0_cs[_e94] = int(_e85);
        int _e96 = value;
        local_8 = i;
        uint _e98 = local_8;
        local_26 = _e98;
        uint _e100 = local_26;
        int _e102 = _group_0_binding_1_cs[_e100];
        local_27 = _e102;
        int _e104 = local_27;
        local_16 = _e104;
        int _e106 = local_16;
        bool _e107 = same(_e96, _e106);
        uint _e108 = base;
        local_7 = uint((_e108 + 6u));
        uint _e114 = local_7;
        local_28 = _e114;
        uint _e116 = local_28;
        _group_0_binding_0_cs[_e116] = int(_e107);
        int _e122 = value;
        value = (_e122 + 1);
        consume(((i - 2u * (i / 2u)) == 0u), _e122);
        int _e125 = value;
        uint _e126 = base;
        local_9 = uint((_e126 + 7u));
        uint _e131 = local_9;
        local_29 = _e131;
        uint _e133 = local_29;
        _group_0_binding_0_cs[_e133] = _e125;
        int _e139 = value;
        value = (_e139 + 1);
        forward(((i - 2u * (i / 2u)) != 0u), _e139);
        int _e142 = value;
        uint _e143 = base;
        local_10 = uint((_e143 + 8u));
        uint _e148 = local_10;
        local_30 = _e148;
        uint _e150 = local_30;
        _group_0_binding_0_cs[_e150] = _e142;
        int _e152 = value;
        local_12 = i;
        uint _e154 = local_12;
        local_31 = _e154;
        uint _e156 = local_31;
        int _e158 = _group_0_binding_1_cs[_e156];
        local_32 = _e158;
        int _e160 = local_32;
        local_17 = _e160;
        int _e162 = local_17;
        bool _e163 = same(_e152, _e162);
        uint _e164 = base;
        local_11 = uint((_e164 + 9u));
        uint _e170 = local_11;
        local_33 = _e170;
        uint _e172 = local_33;
        _group_0_binding_0_cs[_e172] = int(_e163);
        int _e174 = value;
        int _e175 = increment(_e174);
        int _e176 = increment(_e175);
        uint _e177 = base;
        local_13 = uint((_e177 + 10u));
        uint _e182 = local_13;
        local_34 = _e182;
        uint _e184 = local_34;
        _group_0_binding_0_cs[_e184] = _e176;
        int _e186 = value;
        uint _e187 = base;
        local_14 = uint((_e187 + 11u));
        uint _e192 = local_14;
        local_35 = _e192;
        uint _e194 = local_35;
        _group_0_binding_0_cs[_e194] = _e186;
    }
}

