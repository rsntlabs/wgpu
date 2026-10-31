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
        local = uint(i);
        uint _e16 = local;
        local_17 = uint(_e16);
        uint _e19 = local_17;
        int _e22 = _group_0_binding_1_cs[_e19];
        local_18 = _e22;
        int _e24 = local_18;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        int _e28 = value;
        value = (_e28 + 1);
        first = _e28;
        int _e32 = value;
        value = (_e32 + 1);
        second = _e32;
        int _e36 = value;
        third = _e36;
        int _e38 = first;
        int _e41 = second;
        int _e45 = third;
        uint _e47 = base;
        local_1 = uint(_e47);
        uint _e50 = local_1;
        local_19 = uint(_e50);
        uint _e53 = local_19;
        _group_0_binding_0_cs[_e53] = (((_e38 * 100) + (_e41 * 10)) + _e45);
        int _e56 = value;
        uint _e57 = base;
        local_2 = uint((_e57 + 1u));
        uint _e62 = local_2;
        local_20 = uint(_e62);
        uint _e65 = local_20;
        _group_0_binding_0_cs[_e65] = _e56;
        int _e67 = value;
        initialized = (_e67 + 3);
        int _e71 = initialized;
        omitted = (_e71 + 2);
        int _e75 = omitted;
        int _e76 = initialized;
        final = (_e75 + _e76);
        int _e79 = final;
        uint _e80 = base;
        local_3 = uint((_e80 + 2u));
        uint _e85 = local_3;
        local_21 = uint(_e85);
        uint _e88 = local_21;
        _group_0_binding_0_cs[_e88] = _e79;
        int _e90 = value;
        fixed_ = (_e90 + 1);
        int _e94 = fixed_;
        fixed_next = (_e94 + 2);
        int _e98 = fixed_next;
        uint _e99 = base;
        local_4 = uint((_e99 + 3u));
        uint _e104 = local_4;
        local_22 = uint(_e104);
        uint _e107 = local_22;
        _group_0_binding_0_cs[_e107] = _e98;
        int _e109 = value;
        alias_first = (_e109 + 4);
        int _e113 = alias_first;
        alias_next = (_e113 + 1);
        int _e117 = alias_next;
        uint _e118 = base;
        local_5 = uint((_e118 + 4u));
        uint _e123 = local_5;
        local_23 = uint(_e123);
        uint _e126 = local_23;
        _group_0_binding_0_cs[_e126] = _e117;
        int _e128 = value;
        positive = (_e128 > 0);
        bool _e132 = positive;
        local_6 = _e132;
        if (_e132) {
            local_7 = uint(i);
            uint _e136 = local_7;
            local_24 = uint(_e136);
            uint _e139 = local_24;
            int _e141 = _group_0_binding_1_cs[_e139];
            local_25 = _e141;
            int _e143 = local_25;
            local_16 = _e143;
            int _e145 = local_16;
            int _e148 = value;
            local_6 = (_e148 == (_e145 + 2));
        }
        bool _e150 = local_6;
        same = _e150;
        bool _e152 = same;
        uint _e153 = base;
        local_8 = uint((_e153 + 5u));
        uint _e159 = local_8;
        local_26 = uint(_e159);
        uint _e162 = local_26;
        _group_0_binding_0_cs[_e162] = int(_e152);
        int _e164 = value;
        low = (float(_e164) * 0.5);
        float _e169 = low;
        high = (_e169 + 1.5);
        float _e173 = high;
        uint _e177 = base;
        local_9 = uint((_e177 + 6u));
        uint _e182 = local_9;
        local_27 = uint(_e182);
        uint _e185 = local_27;
        _group_0_binding_0_cs[_e185] = int((_e173 * 2.0));
        start = (i - 5u * (i / 5u));
        uint _e190 = start;
        finish = (_e190 + 3u);
        uint _e194 = finish;
        uint _e195 = base;
        local_10 = uint((_e195 + 7u));
        uint _e201 = local_10;
        local_28 = uint(_e201);
        uint _e204 = local_28;
        _group_0_binding_0_cs[_e204] = int(_e194);
        int _e206 = value;
        int _e207 = cached_type(_e206);
        uint _e208 = base;
        local_11 = uint((_e208 + 8u));
        uint _e213 = local_11;
        local_29 = uint(_e213);
        uint _e216 = local_29;
        _group_0_binding_0_cs[_e216] = _e207;
        int _e218 = value;
        outside = _e218;
        {
            int _e220 = value;
            outside_1 = (_e220 + 5);
            int _e224 = outside_1;
            derived = (_e224 + 2);
            int _e228 = derived;
            uint _e229 = base;
            local_12 = uint((_e229 + 9u));
            uint _e234 = local_12;
            local_30 = uint(_e234);
            uint _e237 = local_30;
            _group_0_binding_0_cs[_e237] = _e228;
        }
        total = 0;
        {
            iteration = 0;
            int _e243 = value;
            seed = _e243;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e260 = iteration;
                    iteration = (_e260 + 1);
                }
                loop_init = false;
                int _e245 = iteration;
                if ((_e245 < 4)) {
                } else {
                    break;
                }
                int _e248 = iteration;
                if ((_e248 == 1)) {
                    continue;
                }
                int _e251 = seed;
                int _e252 = iteration;
                term = (_e251 + _e252);
                int _e255 = term;
                copied = _e255;
                int _e257 = copied;
                int _e258 = total;
                total = (_e258 + _e257);
            }
        }
        int _e263 = total;
        uint _e264 = base;
        local_13 = uint((_e264 + 10u));
        uint _e269 = local_13;
        local_31 = uint(_e269);
        uint _e272 = local_31;
        _group_0_binding_0_cs[_e272] = _e263;
        int _e274 = value;
        int _e276 = pair_add(_e274, 2);
        from_call = _e276;
        int _e278 = from_call;
        int _e280 = pair_add(_e278, 3);
        from_prior = _e280;
        int _e282 = from_prior;
        int _e283 = outside;
        uint _e285 = base;
        local_14 = uint((_e285 + 11u));
        uint _e290 = local_14;
        local_32 = uint(_e290);
        uint _e293 = local_32;
        _group_0_binding_0_cs[_e293] = (_e282 + _e283);
    }
}

