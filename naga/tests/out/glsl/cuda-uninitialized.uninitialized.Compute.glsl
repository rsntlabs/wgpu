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


int select_value(int value_1, bool choose_first) {
    int result = 0;
    if (choose_first) {
        result = (value_1 + 3);
    } else {
        result = (value_1 - 2);
    }
    int _e9 = result;
    return _e9;
}

float scaled(float value_2) {
    float result_1 = ((value_2 * 2.0) + 4.0);
    return result_1;
}

uint accumulate(uint limit) {
    uint sum = 0u;
    uint i = 0u;
    uint term = 0u;
    sum = 0u;
    {
        i = 0u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e24 = i;
                i = (_e24 + uint(1));
            }
            loop_init = false;
            uint _e5 = i;
            if ((_e5 < limit)) {
            } else {
                break;
            }
            uint _e7 = i;
            if (((_e7 - 2u * (_e7 / 2u)) == 0u)) {
                uint _e12 = i;
                term = (_e12 + 1u);
            } else {
                uint _e16 = i;
                term = (_e16 * 2u);
            }
            uint _e21 = term;
            uint _e22 = sum;
            sum = (_e22 + _e21);
        }
    }
    uint _e28 = sum;
    return _e28;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    int chosen = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    float weighted = 0.0;
    uint local_3 = 0u;
    bool negative = false;
    uint local_4 = 0u;
    uint magnitude = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    int total = 0;
    int iteration = 0;
    int copied = 0;
    uint local_7 = 0u;
    int descending = 0;
    int iteration_1 = 0;
    int staged = 0;
    uint local_8 = 0u;
    int remaining = 0;
    int partial = 0;
    int next = 0;
    uint local_9 = 0u;
    int shadow = 0;
    int shadow_1 = 0;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    int local_13 = 0;
    uint local_14 = 0u;
    int local_15 = 0;
    uint local_16 = 0u;
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
    uint n_1 = _group_0_binding_2_cs.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 12u);
        local = uint(i_1);
        uint _e16 = local;
        local_14 = uint(_e16);
        uint _e19 = local_14;
        int _e22 = _group_0_binding_1_cs[_e19];
        local_15 = _e22;
        int _e24 = local_15;
        local_13 = _e24;
        int _e26 = local_13;
        value = _e26;
        if (((i_1 - 2u * (i_1 / 2u)) == 0u)) {
            int _e32 = value;
            chosen = (_e32 + 7);
        } else {
            int _e36 = value;
            chosen = (_e36 - 4);
        }
        int _e41 = chosen;
        uint _e42 = base;
        local_1 = uint(_e42);
        uint _e45 = local_1;
        local_16 = uint(_e45);
        uint _e48 = local_16;
        _group_0_binding_0_cs[_e48] = _e41;
        int _e51 = value;
        int _e56 = select_value(_e51, ((i_1 - 3u * (i_1 / 3u)) == 0u));
        uint _e57 = base;
        local_2 = uint((_e57 + 1u));
        uint _e62 = local_2;
        local_17 = uint(_e62);
        uint _e65 = local_17;
        _group_0_binding_0_cs[_e65] = _e56;
        int _e67 = value;
        weighted = ((float(_e67) * 1.5) + 2.0);
        float _e74 = weighted;
        uint _e76 = base;
        local_3 = uint((_e76 + 2u));
        uint _e81 = local_3;
        local_18 = uint(_e81);
        uint _e84 = local_18;
        _group_0_binding_0_cs[_e84] = int(_e74);
        int _e86 = value;
        negative = (_e86 < 0);
        bool _e90 = negative;
        uint _e91 = base;
        local_4 = uint((_e91 + 3u));
        uint _e97 = local_4;
        local_19 = uint(_e97);
        uint _e100 = local_19;
        _group_0_binding_0_cs[_e100] = int(_e90);
        int _e102 = value;
        magnitude = uint((_e102 + 5));
        uint _e107 = magnitude;
        uint _e110 = base;
        local_5 = uint((_e110 + 4u));
        uint _e116 = local_5;
        local_20 = uint(_e116);
        uint _e119 = local_20;
        _group_0_binding_0_cs[_e119] = int((_e107 * 3u));
        uint _e123 = accumulate((i_1 - 5u * (i_1 / 5u)));
        uint _e124 = base;
        local_6 = uint((_e124 + 5u));
        uint _e130 = local_6;
        local_21 = uint(_e130);
        uint _e133 = local_21;
        _group_0_binding_0_cs[_e133] = int(_e123);
        total = 0;
        {
            iteration = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e149 = iteration;
                    iteration = (_e149 + 1);
                }
                loop_init_1 = false;
                int _e139 = iteration;
                if ((_e139 < 3)) {
                } else {
                    break;
                }
                int _e142 = value;
                int _e143 = iteration;
                copied = (_e142 + _e143);
                int _e146 = copied;
                int _e147 = total;
                total = (_e147 + _e146);
            }
        }
        int _e152 = total;
        uint _e153 = base;
        local_7 = uint((_e153 + 6u));
        uint _e158 = local_7;
        local_22 = uint(_e158);
        uint _e161 = local_22;
        _group_0_binding_0_cs[_e161] = _e152;
        descending = 0;
        iteration_1 = 0;
        {
            bool loop_init_2 = true;
            while(true) {
                if (!loop_init_2) {
                    int _e177 = iteration_1;
                    iteration_1 = (_e177 + 1);
                }
                loop_init_2 = false;
                int _e167 = iteration_1;
                if ((_e167 < 3)) {
                } else {
                    break;
                }
                int _e170 = value;
                int _e171 = iteration_1;
                staged = (_e170 - _e171);
                int _e174 = staged;
                int _e175 = descending;
                descending = (_e175 + _e174);
            }
        }
        int _e180 = descending;
        uint _e181 = base;
        local_8 = uint((_e181 + 7u));
        uint _e186 = local_8;
        local_23 = uint(_e186);
        uint _e189 = local_23;
        _group_0_binding_0_cs[_e189] = _e180;
        remaining = 2;
        int _e193 = value;
        partial = _e193;
        while(true) {
            int _e195 = remaining;
            if ((_e195 > 0)) {
            } else {
                break;
            }
            {
                int _e198 = partial;
                int _e199 = remaining;
                next = (_e198 + _e199);
                int _e202 = next;
                partial = _e202;
                int _e203 = remaining;
                remaining = (_e203 - 1);
            }
        }
        int _e206 = partial;
        uint _e207 = base;
        local_9 = uint((_e207 + 8u));
        uint _e212 = local_9;
        local_24 = uint(_e212);
        uint _e215 = local_24;
        _group_0_binding_0_cs[_e215] = _e206;
        int _e217 = value;
        shadow = _e217;
        {
            int _e219 = value;
            shadow_1 = (_e219 + 10);
            int _e223 = shadow_1;
            uint _e224 = base;
            local_10 = uint((_e224 + 9u));
            uint _e229 = local_10;
            local_25 = uint(_e229);
            uint _e232 = local_25;
            _group_0_binding_0_cs[_e232] = _e223;
        }
        int _e234 = shadow;
        uint _e235 = base;
        local_11 = uint((_e235 + 10u));
        uint _e240 = local_11;
        local_26 = uint(_e240);
        uint _e243 = local_26;
        _group_0_binding_0_cs[_e243] = _e234;
        int _e245 = value;
        float _e247 = scaled(float(_e245));
        uint _e248 = base;
        local_12 = uint((_e248 + 11u));
        uint _e254 = local_12;
        local_27 = uint(_e254);
        uint _e257 = local_27;
        _group_0_binding_0_cs[_e257] = int(_e247);
    }
}

