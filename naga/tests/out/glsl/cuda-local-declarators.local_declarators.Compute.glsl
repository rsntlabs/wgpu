#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


int cached_type(int value_1) {
    int next = (value_1 + 1);
    int result = (next * 2);
    return result;
}

int pair_add(int left, int right) {
    return (left + right);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    int first = 0;
    int second = 0;
    int third = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int omitted = 0;
    int initialized = 0;
    int final = 0;
    uint local_3 = 0u;
    int fixed_ = 0;
    int fixed_next = 0;
    uint local_4 = 0u;
    int alias_first = 0;
    int alias_next = 0;
    uint local_5 = 0u;
    bool positive = false;
    bool same = false;
    bool local_6 = false;
    uint local_7 = 0u;
    uint local_8 = 0u;
    float low = 0.0;
    float high = 0.0;
    uint local_9 = 0u;
    uint start = 0u;
    uint finish = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int outside = 0;
    int outside_1 = 0;
    int derived = 0;
    uint local_12 = 0u;
    int total = 0;
    int iteration = 0;
    int seed = 0;
    int term = 0;
    int copied = 0;
    uint local_13 = 0u;
    int from_call = 0;
    int from_prior = 0;
    uint local_14 = 0u;
    int local_15 = 0;
    int local_16 = 0;
    uint local_17 = 0u;
    int local_18 = 0;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    int local_25 = 0;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = i;
        uint _e15 = local;
        local_17 = _e15;
        uint _e17 = local_17;
        int _e20 = _group_0_binding_1_cs[_e17];
        local_18 = _e20;
        int _e22 = local_18;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        int _e26 = value;
        value = (_e26 + 1);
        first = _e26;
        int _e30 = value;
        value = (_e30 + 1);
        second = _e30;
        int _e34 = value;
        third = _e34;
        int _e36 = first;
        int _e39 = second;
        int _e43 = third;
        uint _e45 = base;
        local_1 = _e45;
        uint _e47 = local_1;
        local_19 = _e47;
        uint _e49 = local_19;
        _group_0_binding_0_cs[_e49] = (((_e36 * 100) + (_e39 * 10)) + _e43);
        int _e52 = value;
        uint _e53 = base;
        local_2 = uint((_e53 + 1u));
        uint _e58 = local_2;
        local_20 = _e58;
        uint _e60 = local_20;
        _group_0_binding_0_cs[_e60] = _e52;
        int _e62 = value;
        initialized = (_e62 + 3);
        int _e66 = initialized;
        omitted = (_e66 + 2);
        int _e70 = omitted;
        int _e71 = initialized;
        final = (_e70 + _e71);
        int _e74 = final;
        uint _e75 = base;
        local_3 = uint((_e75 + 2u));
        uint _e80 = local_3;
        local_21 = _e80;
        uint _e82 = local_21;
        _group_0_binding_0_cs[_e82] = _e74;
        int _e84 = value;
        fixed_ = (_e84 + 1);
        int _e88 = fixed_;
        fixed_next = (_e88 + 2);
        int _e92 = fixed_next;
        uint _e93 = base;
        local_4 = uint((_e93 + 3u));
        uint _e98 = local_4;
        local_22 = _e98;
        uint _e100 = local_22;
        _group_0_binding_0_cs[_e100] = _e92;
        int _e102 = value;
        alias_first = (_e102 + 4);
        int _e106 = alias_first;
        alias_next = (_e106 + 1);
        int _e110 = alias_next;
        uint _e111 = base;
        local_5 = uint((_e111 + 4u));
        uint _e116 = local_5;
        local_23 = _e116;
        uint _e118 = local_23;
        _group_0_binding_0_cs[_e118] = _e110;
        int _e120 = value;
        positive = (_e120 > 0);
        bool _e124 = positive;
        local_6 = _e124;
        if (_e124) {
            local_7 = i;
            uint _e127 = local_7;
            local_24 = _e127;
            uint _e129 = local_24;
            int _e131 = _group_0_binding_1_cs[_e129];
            local_25 = _e131;
            int _e133 = local_25;
            local_16 = _e133;
            int _e135 = local_16;
            int _e138 = value;
            local_6 = (_e138 == (_e135 + 2));
        }
        bool _e140 = local_6;
        same = _e140;
        bool _e142 = same;
        uint _e143 = base;
        local_8 = uint((_e143 + 5u));
        uint _e149 = local_8;
        local_26 = _e149;
        uint _e151 = local_26;
        _group_0_binding_0_cs[_e151] = int(_e142);
        int _e153 = value;
        low = (float(_e153) * 0.5);
        float _e158 = low;
        high = (_e158 + 1.5);
        float _e162 = high;
        uint _e166 = base;
        local_9 = uint((_e166 + 6u));
        uint _e171 = local_9;
        local_27 = _e171;
        uint _e173 = local_27;
        _group_0_binding_0_cs[_e173] = int((_e162 * 2.0));
        start = (i - 5u * (i / 5u));
        uint _e178 = start;
        finish = (_e178 + 3u);
        uint _e182 = finish;
        uint _e183 = base;
        local_10 = uint((_e183 + 7u));
        uint _e189 = local_10;
        local_28 = _e189;
        uint _e191 = local_28;
        _group_0_binding_0_cs[_e191] = int(_e182);
        int _e193 = value;
        int _e194 = cached_type(_e193);
        uint _e195 = base;
        local_11 = uint((_e195 + 8u));
        uint _e200 = local_11;
        local_29 = _e200;
        uint _e202 = local_29;
        _group_0_binding_0_cs[_e202] = _e194;
        int _e204 = value;
        outside = _e204;
        {
            int _e206 = value;
            outside_1 = (_e206 + 5);
            int _e210 = outside_1;
            derived = (_e210 + 2);
            int _e214 = derived;
            uint _e215 = base;
            local_12 = uint((_e215 + 9u));
            uint _e220 = local_12;
            local_30 = _e220;
            uint _e222 = local_30;
            _group_0_binding_0_cs[_e222] = _e214;
        }
        total = 0;
        {
            iteration = 0;
            int _e228 = value;
            seed = _e228;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e245 = iteration;
                    iteration = (_e245 + 1);
                }
                loop_init = false;
                int _e230 = iteration;
                if ((_e230 < 4)) {
                } else {
                    break;
                }
                int _e233 = iteration;
                if ((_e233 == 1)) {
                    continue;
                }
                int _e236 = seed;
                int _e237 = iteration;
                term = (_e236 + _e237);
                int _e240 = term;
                copied = _e240;
                int _e242 = copied;
                int _e243 = total;
                total = (_e243 + _e242);
            }
        }
        int _e248 = total;
        uint _e249 = base;
        local_13 = uint((_e249 + 10u));
        uint _e254 = local_13;
        local_31 = _e254;
        uint _e256 = local_31;
        _group_0_binding_0_cs[_e256] = _e248;
        int _e258 = value;
        int _e260 = pair_add(_e258, 2);
        from_call = _e260;
        int _e262 = from_call;
        int _e264 = pair_add(_e262, 3);
        from_prior = _e264;
        int _e266 = from_prior;
        int _e267 = outside;
        uint _e269 = base;
        local_14 = uint((_e269 + 11u));
        uint _e274 = local_14;
        local_32 = _e274;
        uint _e276 = local_32;
        _group_0_binding_0_cs[_e276] = (_e266 + _e267);
    }
}

