#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };


int next_value(int value_1) {
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    return (_e3 + 1);
}

void consume(bool stop, int value_3, uint count, float scale) {
    bool stop_1 = false;
    int value_4 = 0;
    uint count_1 = 0u;
    float scale_1 = 0.0;
    stop_1 = stop;
    value_4 = value_3;
    count_1 = count;
    scale_1 = scale;
    uint _e8 = count_1;
    int _e9 = value_4;
    value_4 = int((uint(_e9) + _e8));
    bool _e13 = stop_1;
    if (_e13) {
        return;
    }
    float _e14 = scale_1;
    int _e15 = value_4;
    value_4 = int((float(_e15) * _e14));
    return;
}

void forward(bool stop_2, int value_5) {
    bool stop_3 = false;
    int value_6 = 0;
    stop_3 = stop_2;
    value_6 = value_5;
    bool _e4 = stop_3;
    int _e5 = value_6;
    int _e6 = next_value(_e5);
    consume(_e4, _e6, 2u, 0.5);
    return;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    int iterations = 0;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    uint _e11 = _group_0_binding_1_cs.value;
    n = _e11;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e19 = i;
    uint _e20 = n;
    if ((_e19 < _e20)) {
        uint _e22 = i;
        base = (_e22 * 6u);
        value = 2;
        int _e28 = value;
        value = (_e28 + 1);
        consume(false, _e28, 1u, 1.5);
        int _e34 = value;
        uint _e37[2] = local;
        local_1 = _e37;
        uint _e38 = base;
        local_2 = uint(_e38);
        uint _e42[2] = local_1;
        local_13 = _e42;
        uint _e43 = local_2;
        uint _e45 = local_13[1];
        local_13[1] = (_e45 + _e43);
        uint _e49 = local_13[0];
        local_14 = uint(_e49);
        uint _e53 = local_13[1];
        local_15 = uint(_e53);
        uint _e56 = local_15;
        _group_0_binding_0_cs[_e56] = _e34;
        int _e58 = value;
        value = (_e58 + 1);
        int _e61 = next_value(_e58);
        consume(true, _e61, 2u, 0.5);
        int _e65 = value;
        uint _e67[2] = local;
        local_3 = _e67;
        uint _e68 = base;
        local_4 = uint((_e68 + 1u));
        uint _e74[2] = local_3;
        local_16 = _e74;
        uint _e75 = local_4;
        uint _e77 = local_16[1];
        local_16[1] = (_e77 + _e75);
        uint _e81 = local_16[0];
        local_17 = uint(_e81);
        uint _e85 = local_16[1];
        local_18 = uint(_e85);
        uint _e88 = local_18;
        _group_0_binding_0_cs[_e88] = _e65;
        uint _e90 = i;
        int _e95 = value;
        value = (_e95 + 1);
        forward(((_e90 - 2u * (_e90 / 2u)) == 0u), _e95);
        int _e98 = value;
        uint _e100[2] = local;
        local_5 = _e100;
        uint _e101 = base;
        local_6 = uint((_e101 + 2u));
        uint _e107[2] = local_5;
        local_19 = _e107;
        uint _e108 = local_6;
        uint _e110 = local_19[1];
        local_19[1] = (_e110 + _e108);
        uint _e114 = local_19[0];
        local_20 = uint(_e114);
        uint _e118 = local_19[1];
        local_21 = uint(_e118);
        uint _e121 = local_21;
        _group_0_binding_0_cs[_e121] = _e98;
        iterations = 0;
        {
            int _e125 = value;
            value = (_e125 + 1);
            consume((0 != 0), _e125, uint(0), float(1u));
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e144 = value;
                    value = (_e144 + 1);
                    int _e147 = value;
                    consume(false, _e147, 0u, 1.0);
                }
                loop_init = false;
                int _e135 = iterations;
                if ((_e135 < 3)) {
                } else {
                    break;
                }
                int _e138 = iterations;
                iterations = (_e138 + 1);
                int _e141 = iterations;
                if ((_e141 == 1)) {
                    continue;
                }
            }
        }
        int _e151 = value;
        uint _e153[2] = local;
        local_7 = _e153;
        uint _e154 = base;
        local_8 = uint((_e154 + 3u));
        uint _e160[2] = local_7;
        local_22 = _e160;
        uint _e161 = local_8;
        uint _e163 = local_22[1];
        local_22[1] = (_e163 + _e161);
        uint _e167 = local_22[0];
        local_23 = uint(_e167);
        uint _e171 = local_22[1];
        local_24 = uint(_e171);
        uint _e174 = local_24;
        _group_0_binding_0_cs[_e174] = _e151;
        int _e176 = iterations;
        uint _e178[2] = local;
        local_9 = _e178;
        uint _e179 = base;
        local_10 = uint((_e179 + 4u));
        uint _e185[2] = local_9;
        local_25 = _e185;
        uint _e186 = local_10;
        uint _e188 = local_25[1];
        local_25[1] = (_e188 + _e186);
        uint _e192 = local_25[0];
        local_26 = uint(_e192);
        uint _e196 = local_25[1];
        local_27 = uint(_e196);
        uint _e199 = local_27;
        _group_0_binding_0_cs[_e199] = _e176;
        int _e201 = value;
        int _e202 = next_value(_e201);
        uint _e204[2] = local;
        local_11 = _e204;
        uint _e205 = base;
        local_12 = uint((_e205 + 5u));
        uint _e211[2] = local_11;
        local_28 = _e211;
        uint _e212 = local_12;
        uint _e214 = local_28[1];
        local_28[1] = (_e214 + _e212);
        uint _e218 = local_28[0];
        local_29 = uint(_e218);
        uint _e222 = local_28[1];
        local_30 = uint(_e222);
        uint _e225 = local_30;
        _group_0_binding_0_cs[_e225] = _e202;
    }
}

