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


int step_(int value_1) {
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = (_e3 + 3);
    int _e5 = value_2;
    return _e5;
}

int doubled(int value_3) {
    int _e1 = step_(value_3);
    return (_e1 * 2);
}

uint advance(uint value_4) {
    return (value_4 + 5u);
}

uint retreat(uint value_5) {
    return (value_5 - 2u);
}

float scale(float value_6, int bias) {
    return ((value_6 * 2.0) + float(bias));
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
    int _e2 = step_(value_9);
    consume(stop_1, _e2);
    return;
}

int device_only(int value_10) {
    int _e1 = step_(value_10);
    return (_e1 + 1);
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
        int _e28 = value;
        int _e29 = step_(_e28);
        uint _e30 = base;
        local_1 = uint(_e30);
        uint _e33 = local_1;
        local_20 = uint(_e33);
        uint _e36 = local_20;
        _group_0_binding_0_cs[_e36] = _e29;
        int _e39 = value;
        uint _e40 = base;
        local_2 = uint((_e40 + 1u));
        uint _e45 = local_2;
        local_21 = uint(_e45);
        uint _e48 = local_21;
        _group_0_binding_0_cs[_e48] = _e39;
        int _e50 = value;
        int _e51 = doubled(_e50);
        uint _e52 = base;
        local_3 = uint((_e52 + 2u));
        uint _e57 = local_3;
        local_22 = uint(_e57);
        uint _e60 = local_22;
        _group_0_binding_0_cs[_e60] = _e51;
        int _e62 = value;
        uint _e64 = advance(uint(_e62));
        uint _e65 = base;
        local_4 = uint((_e65 + 3u));
        uint _e71 = local_4;
        local_23 = uint(_e71);
        uint _e74 = local_23;
        _group_0_binding_0_cs[_e74] = int(_e64);
        int _e76 = value;
        uint _e78 = retreat(uint(_e76));
        uint _e79 = base;
        local_5 = uint((_e79 + 4u));
        uint _e85 = local_5;
        local_24 = uint(_e85);
        uint _e88 = local_24;
        _group_0_binding_0_cs[_e88] = int(_e78);
        int _e90 = value;
        float _e93 = scale(float(_e90), 4);
        uint _e94 = base;
        local_6 = uint((_e94 + 5u));
        uint _e100 = local_6;
        local_25 = uint(_e100);
        uint _e103 = local_25;
        _group_0_binding_0_cs[_e103] = int(_e93);
        int _e105 = value;
        local_8 = uint(i);
        uint _e108 = local_8;
        local_26 = uint(_e108);
        uint _e111 = local_26;
        int _e113 = _group_0_binding_1_cs[_e111];
        local_27 = _e113;
        int _e115 = local_27;
        local_16 = _e115;
        int _e117 = local_16;
        bool _e118 = same(_e105, _e117);
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e125 = local_7;
        local_28 = uint(_e125);
        uint _e128 = local_28;
        _group_0_binding_0_cs[_e128] = int(_e118);
        int _e134 = value;
        value = (_e134 + 1);
        consume(((i - 2u * (i / 2u)) == 0u), _e134);
        int _e137 = value;
        uint _e138 = base;
        local_9 = uint((_e138 + 7u));
        uint _e143 = local_9;
        local_29 = uint(_e143);
        uint _e146 = local_29;
        _group_0_binding_0_cs[_e146] = _e137;
        int _e152 = value;
        value = (_e152 + 1);
        forward(((i - 2u * (i / 2u)) != 0u), _e152);
        int _e155 = value;
        uint _e156 = base;
        local_10 = uint((_e156 + 8u));
        uint _e161 = local_10;
        local_30 = uint(_e161);
        uint _e164 = local_30;
        _group_0_binding_0_cs[_e164] = _e155;
        int _e166 = value;
        local_12 = uint(i);
        uint _e169 = local_12;
        local_31 = uint(_e169);
        uint _e172 = local_31;
        int _e174 = _group_0_binding_1_cs[_e172];
        local_32 = _e174;
        int _e176 = local_32;
        local_17 = _e176;
        int _e178 = local_17;
        bool _e179 = same(_e166, _e178);
        uint _e180 = base;
        local_11 = uint((_e180 + 9u));
        uint _e186 = local_11;
        local_33 = uint(_e186);
        uint _e189 = local_33;
        _group_0_binding_0_cs[_e189] = int(_e179);
        int _e191 = value;
        int _e192 = step_(_e191);
        int _e193 = device_only(_e192);
        uint _e194 = base;
        local_13 = uint((_e194 + 10u));
        uint _e199 = local_13;
        local_34 = uint(_e199);
        uint _e202 = local_34;
        _group_0_binding_0_cs[_e202] = _e193;
        int _e204 = value;
        uint _e205 = base;
        local_14 = uint((_e205 + 11u));
        uint _e210 = local_14;
        local_35 = uint(_e210);
        uint _e213 = local_35;
        _group_0_binding_0_cs[_e213] = _e204;
    }
}

