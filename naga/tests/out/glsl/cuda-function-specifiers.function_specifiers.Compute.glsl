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
        local = uint(i);
        uint _e16 = local;
        local_18 = uint(_e16);
        uint _e19 = local_18;
        int _e22 = _group_0_binding_1_cs[_e19];
        local_19 = _e22;
        int _e24 = local_19;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        choose = ((i - 2u * (i / 2u)) == 0u);
        int _e33 = value;
        int _e34 = increment(_e33);
        uint _e35 = base;
        local_1 = uint(_e35);
        uint _e38 = local_1;
        local_20 = uint(_e38);
        uint _e41 = local_20;
        _group_0_binding_0_cs[_e41] = _e34;
        int _e44 = value;
        int _e45 = twice(_e44);
        uint _e46 = base;
        local_2 = uint((_e46 + 1u));
        uint _e51 = local_2;
        local_21 = uint(_e51);
        uint _e54 = local_21;
        _group_0_binding_0_cs[_e54] = _e45;
        int _e56 = value;
        int _e57 = advance(_e56);
        uint _e58 = base;
        local_3 = uint((_e58 + 2u));
        uint _e63 = local_3;
        local_22 = uint(_e63);
        uint _e66 = local_22;
        _group_0_binding_0_cs[_e66] = _e57;
        int _e68 = value;
        int _e69 = retreat(_e68);
        uint _e70 = base;
        local_4 = uint((_e70 + 3u));
        uint _e75 = local_4;
        local_23 = uint(_e75);
        uint _e78 = local_23;
        _group_0_binding_0_cs[_e78] = _e69;
        int _e80 = value;
        float _e82 = scaled(float(_e80));
        uint _e83 = base;
        local_5 = uint((_e83 + 4u));
        uint _e89 = local_5;
        local_24 = uint(_e89);
        uint _e92 = local_24;
        _group_0_binding_0_cs[_e92] = int(_e82);
        int _e94 = value;
        local_7 = uint(i);
        uint _e97 = local_7;
        local_25 = uint(_e97);
        uint _e100 = local_25;
        int _e102 = _group_0_binding_1_cs[_e100];
        local_26 = _e102;
        int _e104 = local_26;
        local_16 = _e104;
        int _e106 = local_16;
        bool _e107 = differs(_e94, _e106);
        uint _e108 = base;
        local_6 = uint((_e108 + 5u));
        uint _e114 = local_6;
        local_27 = uint(_e114);
        uint _e117 = local_27;
        _group_0_binding_0_cs[_e117] = int(_e107);
        int _e119 = value;
        effect = _e119;
        bool _e121 = choose;
        int _e122 = effect;
        effect = (_e122 + 1);
        consume(_e121, _e122);
        int _e125 = effect;
        uint _e126 = base;
        local_8 = uint((_e126 + 6u));
        uint _e131 = local_8;
        local_28 = uint(_e131);
        uint _e134 = local_28;
        _group_0_binding_0_cs[_e134] = _e125;
        bool _e136 = choose;
        int _e138 = effect;
        effect = (_e138 + 1);
        forward(!(_e136), _e138);
        int _e141 = effect;
        uint _e142 = base;
        local_9 = uint((_e142 + 7u));
        uint _e147 = local_9;
        local_29 = uint(_e147);
        uint _e150 = local_29;
        _group_0_binding_0_cs[_e150] = _e141;
        int _e152 = effect;
        int _e153 = advance(_e152);
        uint _e154 = base;
        local_10 = uint((_e154 + 8u));
        uint _e159 = local_10;
        local_30 = uint(_e159);
        uint _e162 = local_30;
        _group_0_binding_0_cs[_e162] = _e153;
        int _e164 = effect;
        uint _e168 = plus_one(uint((_e164 + 16)));
        uint _e169 = base;
        local_11 = uint((_e169 + 9u));
        uint _e175 = local_11;
        local_31 = uint(_e175);
        uint _e178 = local_31;
        _group_0_binding_0_cs[_e178] = int(_e168);
        int _e180 = effect;
        local_13 = uint(i);
        uint _e183 = local_13;
        local_32 = uint(_e183);
        uint _e186 = local_32;
        int _e188 = _group_0_binding_1_cs[_e186];
        local_33 = _e188;
        int _e190 = local_33;
        local_17 = _e190;
        int _e192 = local_17;
        bool _e193 = differs(_e180, _e192);
        uint _e194 = base;
        local_12 = uint((_e194 + 10u));
        uint _e200 = local_12;
        local_34 = uint(_e200);
        uint _e203 = local_34;
        _group_0_binding_0_cs[_e203] = int(_e193);
        int _e205 = effect;
        uint _e206 = base;
        local_14 = uint((_e206 + 11u));
        uint _e211 = local_14;
        local_35 = uint(_e211);
        uint _e214 = local_35;
        _group_0_binding_0_cs[_e214] = _e205;
    }
}

