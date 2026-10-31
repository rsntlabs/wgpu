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
        local = i_1;
        uint _e15 = local;
        local_14 = _e15;
        uint _e17 = local_14;
        int _e20 = _group_0_binding_1_cs[_e17];
        local_15 = _e20;
        int _e22 = local_15;
        local_13 = _e22;
        int _e24 = local_13;
        value = _e24;
        if (((i_1 - 2u * (i_1 / 2u)) == 0u)) {
            int _e30 = value;
            chosen = (_e30 + 7);
        } else {
            int _e34 = value;
            chosen = (_e34 - 4);
        }
        int _e39 = chosen;
        uint _e40 = base;
        local_1 = _e40;
        uint _e42 = local_1;
        local_16 = _e42;
        uint _e44 = local_16;
        _group_0_binding_0_cs[_e44] = _e39;
        int _e47 = value;
        int _e52 = select_value(_e47, ((i_1 - 3u * (i_1 / 3u)) == 0u));
        uint _e53 = base;
        local_2 = uint((_e53 + 1u));
        uint _e58 = local_2;
        local_17 = _e58;
        uint _e60 = local_17;
        _group_0_binding_0_cs[_e60] = _e52;
        int _e62 = value;
        weighted = ((float(_e62) * 1.5) + 2.0);
        float _e69 = weighted;
        uint _e71 = base;
        local_3 = uint((_e71 + 2u));
        uint _e76 = local_3;
        local_18 = _e76;
        uint _e78 = local_18;
        _group_0_binding_0_cs[_e78] = int(_e69);
        int _e80 = value;
        negative = (_e80 < 0);
        bool _e84 = negative;
        uint _e85 = base;
        local_4 = uint((_e85 + 3u));
        uint _e91 = local_4;
        local_19 = _e91;
        uint _e93 = local_19;
        _group_0_binding_0_cs[_e93] = int(_e84);
        int _e95 = value;
        magnitude = uint((_e95 + 5));
        uint _e100 = magnitude;
        uint _e103 = base;
        local_5 = uint((_e103 + 4u));
        uint _e109 = local_5;
        local_20 = _e109;
        uint _e111 = local_20;
        _group_0_binding_0_cs[_e111] = int((_e100 * 3u));
        uint _e115 = accumulate((i_1 - 5u * (i_1 / 5u)));
        uint _e116 = base;
        local_6 = uint((_e116 + 5u));
        uint _e122 = local_6;
        local_21 = _e122;
        uint _e124 = local_21;
        _group_0_binding_0_cs[_e124] = int(_e115);
        total = 0;
        {
            iteration = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e140 = iteration;
                    iteration = (_e140 + 1);
                }
                loop_init_1 = false;
                int _e130 = iteration;
                if ((_e130 < 3)) {
                } else {
                    break;
                }
                int _e133 = value;
                int _e134 = iteration;
                copied = (_e133 + _e134);
                int _e137 = copied;
                int _e138 = total;
                total = (_e138 + _e137);
            }
        }
        int _e143 = total;
        uint _e144 = base;
        local_7 = uint((_e144 + 6u));
        uint _e149 = local_7;
        local_22 = _e149;
        uint _e151 = local_22;
        _group_0_binding_0_cs[_e151] = _e143;
        descending = 0;
        iteration_1 = 0;
        {
            bool loop_init_2 = true;
            while(true) {
                if (!loop_init_2) {
                    int _e167 = iteration_1;
                    iteration_1 = (_e167 + 1);
                }
                loop_init_2 = false;
                int _e157 = iteration_1;
                if ((_e157 < 3)) {
                } else {
                    break;
                }
                int _e160 = value;
                int _e161 = iteration_1;
                staged = (_e160 - _e161);
                int _e164 = staged;
                int _e165 = descending;
                descending = (_e165 + _e164);
            }
        }
        int _e170 = descending;
        uint _e171 = base;
        local_8 = uint((_e171 + 7u));
        uint _e176 = local_8;
        local_23 = _e176;
        uint _e178 = local_23;
        _group_0_binding_0_cs[_e178] = _e170;
        remaining = 2;
        int _e182 = value;
        partial = _e182;
        while(true) {
            int _e184 = remaining;
            if ((_e184 > 0)) {
            } else {
                break;
            }
            {
                int _e187 = partial;
                int _e188 = remaining;
                next = (_e187 + _e188);
                int _e191 = next;
                partial = _e191;
                int _e192 = remaining;
                remaining = (_e192 - 1);
            }
        }
        int _e195 = partial;
        uint _e196 = base;
        local_9 = uint((_e196 + 8u));
        uint _e201 = local_9;
        local_24 = _e201;
        uint _e203 = local_24;
        _group_0_binding_0_cs[_e203] = _e195;
        int _e205 = value;
        shadow = _e205;
        {
            int _e207 = value;
            shadow_1 = (_e207 + 10);
            int _e211 = shadow_1;
            uint _e212 = base;
            local_10 = uint((_e212 + 9u));
            uint _e217 = local_10;
            local_25 = _e217;
            uint _e219 = local_25;
            _group_0_binding_0_cs[_e219] = _e211;
        }
        int _e221 = shadow;
        uint _e222 = base;
        local_11 = uint((_e222 + 10u));
        uint _e227 = local_11;
        local_26 = _e227;
        uint _e229 = local_26;
        _group_0_binding_0_cs[_e229] = _e221;
        int _e231 = value;
        float _e233 = scaled(float(_e231));
        uint _e234 = base;
        local_12 = uint((_e234 + 11u));
        uint _e240 = local_12;
        local_27 = _e240;
        uint _e242 = local_27;
        _group_0_binding_0_cs[_e242] = int(_e233);
    }
}

