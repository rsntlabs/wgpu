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
    uint local = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    int iterations = 0;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    local = 0u;
    uint _e6 = _group_0_binding_1_cs.value;
    n = _e6;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e14 = i;
    uint _e15 = n;
    if ((_e14 < _e15)) {
        uint _e17 = i;
        base = (_e17 * 6u);
        value = 2;
        int _e23 = value;
        value = (_e23 + 1);
        consume(false, _e23, 1u, 1.5);
        int _e29 = value;
        uint _e30 = local;
        local_1 = _e30;
        uint _e32 = local_1;
        local_2 = uint(_e32);
        uint _e35 = base;
        local_3 = uint(_e35);
        uint _e39 = local_2;
        uint _e40 = local_3;
        local_19 = uint((_e39 + _e40));
        uint _e44 = local_19;
        _group_0_binding_0_cs[_e44] = _e29;
        int _e46 = value;
        value = (_e46 + 1);
        int _e49 = next_value(_e46);
        consume(true, _e49, 2u, 0.5);
        int _e53 = value;
        uint _e54 = local;
        local_4 = _e54;
        uint _e56 = local_4;
        local_5 = uint(_e56);
        uint _e59 = base;
        local_6 = uint((_e59 + 1u));
        uint _e64 = local_5;
        uint _e65 = local_6;
        local_20 = uint((_e64 + _e65));
        uint _e69 = local_20;
        _group_0_binding_0_cs[_e69] = _e53;
        uint _e71 = i;
        int _e76 = value;
        value = (_e76 + 1);
        forward(((_e71 - 2u * (_e71 / 2u)) == 0u), _e76);
        int _e79 = value;
        uint _e80 = local;
        local_7 = _e80;
        uint _e82 = local_7;
        local_8 = uint(_e82);
        uint _e85 = base;
        local_9 = uint((_e85 + 2u));
        uint _e90 = local_8;
        uint _e91 = local_9;
        local_21 = uint((_e90 + _e91));
        uint _e95 = local_21;
        _group_0_binding_0_cs[_e95] = _e79;
        iterations = 0;
        {
            int _e99 = value;
            value = (_e99 + 1);
            consume((0 != 0), _e99, uint(0), float(1u));
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e118 = value;
                    value = (_e118 + 1);
                    int _e121 = value;
                    consume(false, _e121, 0u, 1.0);
                }
                loop_init = false;
                int _e109 = iterations;
                if ((_e109 < 3)) {
                } else {
                    break;
                }
                int _e112 = iterations;
                iterations = (_e112 + 1);
                int _e115 = iterations;
                if ((_e115 == 1)) {
                    continue;
                }
            }
        }
        int _e125 = value;
        uint _e126 = local;
        local_10 = _e126;
        uint _e128 = local_10;
        local_11 = uint(_e128);
        uint _e131 = base;
        local_12 = uint((_e131 + 3u));
        uint _e136 = local_11;
        uint _e137 = local_12;
        local_22 = uint((_e136 + _e137));
        uint _e141 = local_22;
        _group_0_binding_0_cs[_e141] = _e125;
        int _e143 = iterations;
        uint _e144 = local;
        local_13 = _e144;
        uint _e146 = local_13;
        local_14 = uint(_e146);
        uint _e149 = base;
        local_15 = uint((_e149 + 4u));
        uint _e154 = local_14;
        uint _e155 = local_15;
        local_23 = uint((_e154 + _e155));
        uint _e159 = local_23;
        _group_0_binding_0_cs[_e159] = _e143;
        int _e161 = value;
        int _e162 = next_value(_e161);
        uint _e163 = local;
        local_16 = _e163;
        uint _e165 = local_16;
        local_17 = uint(_e165);
        uint _e168 = base;
        local_18 = uint((_e168 + 5u));
        uint _e173 = local_17;
        uint _e174 = local_18;
        local_24 = uint((_e173 + _e174));
        uint _e178 = local_24;
        _group_0_binding_0_cs[_e178] = _e162;
    }
}

