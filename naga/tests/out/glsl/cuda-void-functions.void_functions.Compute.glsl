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
    uint out_[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    int iterations = 0;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21[2] = uint[2](0u, 0u);
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
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
        uint _e37[2] = out_;
        local = _e37;
        uint _e38 = base;
        local_1 = uint(_e38);
        uint _e42[2] = local;
        local_12 = _e42;
        uint _e43 = local_1;
        uint _e45 = local_12[1];
        local_12[1] = (_e45 + _e43);
        uint _e49 = local_12[0];
        local_13 = uint(_e49);
        uint _e53 = local_12[1];
        local_14 = uint(_e53);
        uint _e56 = local_14;
        _group_0_binding_0_cs[_e56] = _e34;
        int _e58 = value;
        value = (_e58 + 1);
        int _e61 = next_value(_e58);
        consume(true, _e61, 2u, 0.5);
        int _e65 = value;
        uint _e67[2] = out_;
        local_2 = _e67;
        uint _e68 = base;
        local_3 = uint((_e68 + 1u));
        uint _e74[2] = local_2;
        local_15 = _e74;
        uint _e75 = local_3;
        uint _e77 = local_15[1];
        local_15[1] = (_e77 + _e75);
        uint _e81 = local_15[0];
        local_16 = uint(_e81);
        uint _e85 = local_15[1];
        local_17 = uint(_e85);
        uint _e88 = local_17;
        _group_0_binding_0_cs[_e88] = _e65;
        uint _e90 = i;
        int _e95 = value;
        value = (_e95 + 1);
        forward(((_e90 - 2u * (_e90 / 2u)) == 0u), _e95);
        int _e98 = value;
        uint _e100[2] = out_;
        local_4 = _e100;
        uint _e101 = base;
        local_5 = uint((_e101 + 2u));
        uint _e107[2] = local_4;
        local_18 = _e107;
        uint _e108 = local_5;
        uint _e110 = local_18[1];
        local_18[1] = (_e110 + _e108);
        uint _e114 = local_18[0];
        local_19 = uint(_e114);
        uint _e118 = local_18[1];
        local_20 = uint(_e118);
        uint _e121 = local_20;
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
        uint _e153[2] = out_;
        local_6 = _e153;
        uint _e154 = base;
        local_7 = uint((_e154 + 3u));
        uint _e160[2] = local_6;
        local_21 = _e160;
        uint _e161 = local_7;
        uint _e163 = local_21[1];
        local_21[1] = (_e163 + _e161);
        uint _e167 = local_21[0];
        local_22 = uint(_e167);
        uint _e171 = local_21[1];
        local_23 = uint(_e171);
        uint _e174 = local_23;
        _group_0_binding_0_cs[_e174] = _e151;
        int _e176 = iterations;
        uint _e178[2] = out_;
        local_8 = _e178;
        uint _e179 = base;
        local_9 = uint((_e179 + 4u));
        uint _e185[2] = local_8;
        local_24 = _e185;
        uint _e186 = local_9;
        uint _e188 = local_24[1];
        local_24[1] = (_e188 + _e186);
        uint _e192 = local_24[0];
        local_25 = uint(_e192);
        uint _e196 = local_24[1];
        local_26 = uint(_e196);
        uint _e199 = local_26;
        _group_0_binding_0_cs[_e199] = _e176;
        int _e201 = value;
        int _e202 = next_value(_e201);
        uint _e204[2] = out_;
        local_10 = _e204;
        uint _e205 = base;
        local_11 = uint((_e205 + 5u));
        uint _e211[2] = local_10;
        local_27 = _e211;
        uint _e212 = local_11;
        uint _e214 = local_27[1];
        local_27[1] = (_e214 + _e212);
        uint _e218 = local_27[0];
        local_28 = uint(_e218);
        uint _e222 = local_27[1];
        local_29 = uint(_e222);
        uint _e225 = local_29;
        _group_0_binding_0_cs[_e225] = _e202;
    }
}

