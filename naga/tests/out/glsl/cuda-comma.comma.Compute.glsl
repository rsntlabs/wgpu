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


void consume(int value_1) {
    if ((value_1 < 0)) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1) {
    return (left_1 + right_1);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    bool choose = false;
    int x = 0;
    int sequenced = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int target = 0;
    uint local_3 = 0u;
    int rhs = 0;
    uint local_4 = 0u;
    int middle = 0;
    int selected = 0;
    int local_5 = 0;
    uint local_6 = 0u;
    int left = 0;
    int right = 0;
    uint local_7 = 0u;
    int identity = 0;
    uint local_8 = 0u;
    uint position = 0u;
    uint local_9 = 0u;
    int effect = 0;
    uint local_10 = 0u;
    int total = 0;
    int iteration = 0;
    int current = 0;
    uint local_11 = 0u;
    int ticks = 0;
    int passes = 0;
    uint local_12 = 0u;
    int argument = 0;
    int first = 0;
    int second = 0;
    uint local_13 = 0u;
    int local_14 = 0;
    uint local_15 = 0u;
    int local_16 = 0;
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
    uint local_28 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = uint(i);
        uint _e16 = local;
        local_15 = uint(_e16);
        uint _e19 = local_15;
        int _e22 = _group_0_binding_1_cs[_e19];
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = ((i - 2u * (i / 2u)) == 0u);
        int _e33 = value;
        x = _e33;
        int _e35 = x;
        x = (_e35 + 2);
        int _e38 = x;
        x = (_e38 * 3);
        int _e41 = x;
        sequenced = (_e41 - 1);
        int _e45 = sequenced;
        uint _e46 = base;
        local_1 = uint(_e46);
        uint _e49 = local_1;
        local_17 = uint(_e49);
        uint _e52 = local_17;
        _group_0_binding_0_cs[_e52] = _e45;
        int _e55 = x;
        uint _e56 = base;
        local_2 = uint((_e56 + 1u));
        uint _e61 = local_2;
        local_18 = uint(_e61);
        uint _e64 = local_18;
        _group_0_binding_0_cs[_e64] = _e55;
        target = 0;
        int _e68 = value;
        target = _e68;
        int _e69 = target;
        target = (_e69 + 4);
        int _e72 = target;
        uint _e73 = base;
        local_3 = uint((_e73 + 2u));
        uint _e78 = local_3;
        local_19 = uint(_e78);
        uint _e81 = local_19;
        _group_0_binding_0_cs[_e81] = _e72;
        int _e83 = value;
        target = (_e83 + 1);
        int _e86 = target;
        rhs = (_e86 + 3);
        int _e90 = rhs;
        int _e93 = target;
        uint _e95 = base;
        local_4 = uint((_e95 + 3u));
        uint _e100 = local_4;
        local_20 = uint(_e100);
        uint _e103 = local_20;
        _group_0_binding_0_cs[_e103] = ((_e90 * 10) + _e93);
        middle = 0;
        bool _e107 = choose;
        if (_e107) {
            int _e108 = value;
            middle = (_e108 + 2);
            int _e111 = middle;
            local_5 = (_e111 + 3);
        } else {
            int _e115 = value;
            local_5 = (_e115 - 2);
        }
        int _e120 = local_5;
        selected = _e120;
        int _e122 = selected;
        int _e125 = middle;
        uint _e127 = base;
        local_6 = uint((_e127 + 4u));
        uint _e132 = local_6;
        local_21 = uint(_e132);
        uint _e135 = local_21;
        _group_0_binding_0_cs[_e135] = ((_e122 * 10) + _e125);
        int _e137 = value;
        left = _e137;
        int _e139 = value;
        right = (_e139 + 10);
        int _e143 = value;
        consume(_e143);
        bool _e144 = choose;
        if (_e144) {
            int _e145 = left;
            left = (_e145 + 3);
        } else {
            int _e148 = right;
            right = (_e148 + 3);
        }
        int _e151 = left;
        int _e154 = right;
        uint _e156 = base;
        local_7 = uint((_e156 + 5u));
        uint _e161 = local_7;
        local_22 = uint(_e161);
        uint _e164 = local_22;
        _group_0_binding_0_cs[_e164] = ((_e151 * 100) + _e154);
        int _e166 = value;
        identity = _e166;
        int _e168 = identity;
        identity = (_e168 + 1);
        consume(_e168);
        int _e171 = identity;
        identity = (_e171 + 1);
        int _e174 = identity;
        uint _e175 = base;
        local_8 = uint((_e175 + 6u));
        uint _e180 = local_8;
        local_23 = uint(_e180);
        uint _e183 = local_23;
        _group_0_binding_0_cs[_e183] = _e174;
        uint _e185 = base;
        position = (_e185 + 4u);
        uint _e189 = position;
        position = (_e189 + 2u);
        int _e192 = value;
        uint _e197 = position;
        position = (_e197 + uint(1));
        uint _e201 = position;
        local_9 = uint(_e201);
        uint _e204 = local_9;
        local_24 = uint(_e204);
        uint _e207 = local_24;
        _group_0_binding_0_cs[_e207] = ((_e192 * 2) + 2);
        int _e209 = value;
        effect = _e209;
        int _e211 = effect;
        effect = (_e211 + 1);
        consume(_e211);
        int _e214 = effect;
        effect = (_e214 + 1);
        consume(_e214);
        int _e217 = effect;
        effect = (_e217 + 1);
        consume(_e217);
        int _e220 = effect;
        effect = (_e220 + 1);
        consume(_e220);
        int _e223 = effect;
        uint _e224 = base;
        local_10 = uint((_e224 + 8u));
        uint _e229 = local_10;
        local_25 = uint(_e229);
        uint _e232 = local_25;
        _group_0_binding_0_cs[_e232] = _e223;
        total = 0;
        {
            iteration = 0;
            int _e238 = value;
            current = _e238;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e249 = iteration;
                    iteration = (_e249 + 1);
                    int _e252 = current;
                    current = (_e252 + 2);
                }
                loop_init = false;
                int _e240 = iteration;
                if ((_e240 < 4)) {
                } else {
                    break;
                }
                int _e243 = iteration;
                if ((_e243 != 1)) {
                    int _e246 = current;
                    int _e247 = total;
                    total = (_e247 + _e246);
                } else {
                    continue;
                }
            }
        }
        int _e255 = total;
        uint _e256 = base;
        local_11 = uint((_e256 + 9u));
        uint _e261 = local_11;
        local_26 = uint(_e261);
        uint _e264 = local_26;
        _group_0_binding_0_cs[_e264] = _e255;
        int _e266 = value;
        ticks = _e266;
        passes = 0;
        {
            int _e270 = value;
            ticks = (_e270 + 1);
            passes = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e280 = ticks;
                    ticks = (_e280 + 2);
                }
                loop_init_1 = false;
                int _e274 = passes;
                passes = (_e274 + 1);
                int _e277 = passes;
                if ((_e277 < 4)) {
                } else {
                    break;
                }
            }
        }
        int _e283 = ticks;
        int _e286 = passes;
        uint _e288 = base;
        local_12 = uint((_e288 + 10u));
        uint _e293 = local_12;
        local_27 = uint(_e293);
        uint _e296 = local_27;
        _group_0_binding_0_cs[_e296] = ((_e283 * 10) + _e286);
        int _e298 = value;
        argument = _e298;
        int _e300 = argument;
        argument = (_e300 + 1);
        int _e303 = argument;
        int _e305 = pair_add(_e303, 2);
        first = _e305;
        int _e307 = first;
        int _e309 = pair_add(_e307, 3);
        second = _e309;
        int _e311 = second;
        int _e314 = argument;
        uint _e316 = base;
        local_13 = uint((_e316 + 11u));
        uint _e321 = local_13;
        local_28 = uint(_e321);
        uint _e324 = local_28;
        _group_0_binding_0_cs[_e324] = ((_e311 * 10) + _e314);
    }
}

