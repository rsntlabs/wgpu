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
    return (value_1 + 1);
}

void consume(bool stop, int value_2, uint count, float scale) {
    int value_3 = 0;
    value_3 = value_2;
    int _e5 = value_3;
    value_3 = int((uint(_e5) + count));
    if (stop) {
        return;
    }
    int _e9 = value_3;
    value_3 = int((float(_e9) * scale));
    return;
}

void forward(bool stop_1, int value_4) {
    int _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5);
    return;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint out_[2] = uint[2](0u, 0u);
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
    uint n_1 = _group_0_binding_1_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 6u);
        value = 2;
        int _e22 = value;
        value = (_e22 + 1);
        consume(false, _e22, 1u, 1.5);
        int _e28 = value;
        uint _e30[2] = out_;
        local = _e30;
        uint _e32 = base;
        local_1 = uint(_e32);
        uint _e35[2] = local;
        local_12 = _e35;
        uint _e37 = local_1;
        uint _e39 = local_12[1];
        local_12[1] = (_e39 + _e37);
        uint _e43 = local_12[0];
        local_13 = uint(_e43);
        uint _e47 = local_12[1];
        local_14 = uint(_e47);
        uint _e50 = local_14;
        _group_0_binding_0_cs[_e50] = _e28;
        int _e53 = value;
        value = (_e53 + 1);
        int _e56 = next_value(_e53);
        consume(true, _e56, 2u, 0.5);
        int _e60 = value;
        uint _e61[2] = out_;
        local_2 = _e61;
        uint _e63 = base;
        local_3 = uint((_e63 + 1u));
        uint _e68[2] = local_2;
        local_15 = _e68;
        uint _e70 = local_3;
        uint _e72 = local_15[1];
        local_15[1] = (_e72 + _e70);
        uint _e76 = local_15[0];
        local_16 = uint(_e76);
        uint _e80 = local_15[1];
        local_17 = uint(_e80);
        uint _e83 = local_17;
        _group_0_binding_0_cs[_e83] = _e60;
        int _e89 = value;
        value = (_e89 + 1);
        forward(((i - 2u * (i / 2u)) == 0u), _e89);
        int _e92 = value;
        uint _e93[2] = out_;
        local_4 = _e93;
        uint _e95 = base;
        local_5 = uint((_e95 + 2u));
        uint _e100[2] = local_4;
        local_18 = _e100;
        uint _e102 = local_5;
        uint _e104 = local_18[1];
        local_18[1] = (_e104 + _e102);
        uint _e108 = local_18[0];
        local_19 = uint(_e108);
        uint _e112 = local_18[1];
        local_20 = uint(_e112);
        uint _e115 = local_20;
        _group_0_binding_0_cs[_e115] = _e92;
        iterations = 0;
        {
            int _e119 = value;
            value = (_e119 + 1);
            consume((0 != 0), _e119, uint(0), float(1u));
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e138 = value;
                    value = (_e138 + 1);
                    int _e141 = value;
                    consume(false, _e141, 0u, 1.0);
                }
                loop_init = false;
                int _e129 = iterations;
                if ((_e129 < 3)) {
                } else {
                    break;
                }
                int _e132 = iterations;
                iterations = (_e132 + 1);
                int _e135 = iterations;
                if ((_e135 == 1)) {
                    continue;
                }
            }
        }
        int _e145 = value;
        uint _e146[2] = out_;
        local_6 = _e146;
        uint _e148 = base;
        local_7 = uint((_e148 + 3u));
        uint _e153[2] = local_6;
        local_21 = _e153;
        uint _e155 = local_7;
        uint _e157 = local_21[1];
        local_21[1] = (_e157 + _e155);
        uint _e161 = local_21[0];
        local_22 = uint(_e161);
        uint _e165 = local_21[1];
        local_23 = uint(_e165);
        uint _e168 = local_23;
        _group_0_binding_0_cs[_e168] = _e145;
        int _e170 = iterations;
        uint _e171[2] = out_;
        local_8 = _e171;
        uint _e173 = base;
        local_9 = uint((_e173 + 4u));
        uint _e178[2] = local_8;
        local_24 = _e178;
        uint _e180 = local_9;
        uint _e182 = local_24[1];
        local_24[1] = (_e182 + _e180);
        uint _e186 = local_24[0];
        local_25 = uint(_e186);
        uint _e190 = local_24[1];
        local_26 = uint(_e190);
        uint _e193 = local_26;
        _group_0_binding_0_cs[_e193] = _e170;
        int _e195 = value;
        int _e196 = next_value(_e195);
        uint _e197[2] = out_;
        local_10 = _e197;
        uint _e199 = base;
        local_11 = uint((_e199 + 5u));
        uint _e204[2] = local_10;
        local_27 = _e204;
        uint _e206 = local_11;
        uint _e208 = local_27[1];
        local_27[1] = (_e208 + _e206);
        uint _e212 = local_27[0];
        local_28 = uint(_e212);
        uint _e216 = local_27[1];
        local_29 = uint(_e216);
        uint _e219 = local_29;
        _group_0_binding_0_cs[_e219] = _e196;
    }
}

