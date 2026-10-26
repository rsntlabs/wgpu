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
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    if ((_e3 < 0)) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1) {
    int left_2 = 0;
    int right_2 = 0;
    left_2 = left_1;
    right_2 = right_1;
    int _e4 = left_2;
    int _e5 = right_2;
    return (_e4 + _e5);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    bool choose = false;
    int x = 0;
    int sequenced = 0;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int target = 0;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    int rhs = 0;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    int middle = 0;
    int selected = 0;
    int local_17 = 0;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    int left = 0;
    int right = 0;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    int identity = 0;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint position = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    int effect = 0;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    int total = 0;
    int iteration = 0;
    int current = 0;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    int ticks = 0;
    int passes = 0;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    int argument = 0;
    int first = 0;
    int second = 0;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    int local_43 = 0;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    local = 0u;
    local_1 = 0u;
    uint _e8 = _group_0_binding_2_cs.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 12u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_42 = uint((_e32 + _e33));
        uint _e38 = local_42;
        int _e40 = _group_0_binding_1_cs[_e38];
        local_43 = _e40;
        int _e41 = local_43;
        value = _e41;
        uint _e43 = i;
        choose = ((_e43 - 2u * (_e43 / 2u)) == 0u);
        int _e49 = value;
        x = _e49;
        int _e51 = x;
        x = (_e51 + 2);
        int _e54 = x;
        x = (_e54 * 3);
        int _e57 = x;
        sequenced = (_e57 - 1);
        int _e61 = sequenced;
        uint _e62 = local;
        local_5 = _e62;
        uint _e64 = local_5;
        local_6 = uint(_e64);
        uint _e67 = base;
        local_7 = uint(_e67);
        uint _e71 = local_6;
        uint _e72 = local_7;
        local_44 = uint((_e71 + _e72));
        uint _e76 = local_44;
        _group_0_binding_0_cs[_e76] = _e61;
        int _e78 = x;
        uint _e79 = local;
        local_8 = _e79;
        uint _e81 = local_8;
        local_9 = uint(_e81);
        uint _e84 = base;
        local_10 = uint((_e84 + 1u));
        uint _e89 = local_9;
        uint _e90 = local_10;
        local_45 = uint((_e89 + _e90));
        uint _e94 = local_45;
        _group_0_binding_0_cs[_e94] = _e78;
        target = 0;
        int _e98 = value;
        target = _e98;
        int _e99 = target;
        target = (_e99 + 4);
        int _e102 = target;
        uint _e103 = local;
        local_11 = _e103;
        uint _e105 = local_11;
        local_12 = uint(_e105);
        uint _e108 = base;
        local_13 = uint((_e108 + 2u));
        uint _e113 = local_12;
        uint _e114 = local_13;
        local_46 = uint((_e113 + _e114));
        uint _e118 = local_46;
        _group_0_binding_0_cs[_e118] = _e102;
        int _e120 = value;
        target = (_e120 + 1);
        int _e123 = target;
        rhs = (_e123 + 3);
        int _e127 = rhs;
        int _e130 = target;
        uint _e132 = local;
        local_14 = _e132;
        uint _e134 = local_14;
        local_15 = uint(_e134);
        uint _e137 = base;
        local_16 = uint((_e137 + 3u));
        uint _e142 = local_15;
        uint _e143 = local_16;
        local_47 = uint((_e142 + _e143));
        uint _e147 = local_47;
        _group_0_binding_0_cs[_e147] = ((_e127 * 10) + _e130);
        middle = 0;
        bool _e151 = choose;
        if (_e151) {
            int _e152 = value;
            middle = (_e152 + 2);
            int _e155 = middle;
            local_17 = (_e155 + 3);
        } else {
            int _e159 = value;
            local_17 = (_e159 - 2);
        }
        int _e164 = local_17;
        selected = _e164;
        int _e166 = selected;
        int _e169 = middle;
        uint _e171 = local;
        local_18 = _e171;
        uint _e173 = local_18;
        local_19 = uint(_e173);
        uint _e176 = base;
        local_20 = uint((_e176 + 4u));
        uint _e181 = local_19;
        uint _e182 = local_20;
        local_48 = uint((_e181 + _e182));
        uint _e186 = local_48;
        _group_0_binding_0_cs[_e186] = ((_e166 * 10) + _e169);
        int _e188 = value;
        left = _e188;
        int _e190 = value;
        right = (_e190 + 10);
        int _e194 = value;
        consume(_e194);
        bool _e195 = choose;
        if (_e195) {
            int _e196 = left;
            left = (_e196 + 3);
        } else {
            int _e199 = right;
            right = (_e199 + 3);
        }
        int _e202 = left;
        int _e205 = right;
        uint _e207 = local;
        local_21 = _e207;
        uint _e209 = local_21;
        local_22 = uint(_e209);
        uint _e212 = base;
        local_23 = uint((_e212 + 5u));
        uint _e217 = local_22;
        uint _e218 = local_23;
        local_49 = uint((_e217 + _e218));
        uint _e222 = local_49;
        _group_0_binding_0_cs[_e222] = ((_e202 * 100) + _e205);
        int _e224 = value;
        identity = _e224;
        int _e226 = identity;
        identity = (_e226 + 1);
        consume(_e226);
        int _e229 = identity;
        identity = (_e229 + 1);
        int _e232 = identity;
        uint _e233 = local;
        local_24 = _e233;
        uint _e235 = local_24;
        local_25 = uint(_e235);
        uint _e238 = base;
        local_26 = uint((_e238 + 6u));
        uint _e243 = local_25;
        uint _e244 = local_26;
        local_50 = uint((_e243 + _e244));
        uint _e248 = local_50;
        _group_0_binding_0_cs[_e248] = _e232;
        uint _e250 = base;
        position = (_e250 + 4u);
        uint _e254 = position;
        position = (_e254 + 2u);
        int _e257 = value;
        uint _e262 = position;
        position = (_e262 + uint(1));
        uint _e266 = local;
        local_27 = _e266;
        uint _e268 = local_27;
        local_28 = uint(_e268);
        uint _e271 = position;
        local_29 = uint(_e271);
        uint _e274 = local_28;
        uint _e275 = local_29;
        local_51 = uint((_e274 + _e275));
        uint _e279 = local_51;
        _group_0_binding_0_cs[_e279] = ((_e257 * 2) + 2);
        int _e281 = value;
        effect = _e281;
        int _e283 = effect;
        effect = (_e283 + 1);
        consume(_e283);
        int _e286 = effect;
        effect = (_e286 + 1);
        consume(_e286);
        int _e289 = effect;
        effect = (_e289 + 1);
        consume(_e289);
        int _e292 = effect;
        effect = (_e292 + 1);
        consume(_e292);
        int _e295 = effect;
        uint _e296 = local;
        local_30 = _e296;
        uint _e298 = local_30;
        local_31 = uint(_e298);
        uint _e301 = base;
        local_32 = uint((_e301 + 8u));
        uint _e306 = local_31;
        uint _e307 = local_32;
        local_52 = uint((_e306 + _e307));
        uint _e311 = local_52;
        _group_0_binding_0_cs[_e311] = _e295;
        total = 0;
        {
            iteration = 0;
            int _e317 = value;
            current = _e317;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e328 = iteration;
                    iteration = (_e328 + 1);
                    int _e331 = current;
                    current = (_e331 + 2);
                }
                loop_init = false;
                int _e319 = iteration;
                if ((_e319 < 4)) {
                } else {
                    break;
                }
                int _e322 = iteration;
                if ((_e322 != 1)) {
                    int _e325 = current;
                    int _e326 = total;
                    total = (_e326 + _e325);
                } else {
                    continue;
                }
            }
        }
        int _e334 = total;
        uint _e335 = local;
        local_33 = _e335;
        uint _e337 = local_33;
        local_34 = uint(_e337);
        uint _e340 = base;
        local_35 = uint((_e340 + 9u));
        uint _e345 = local_34;
        uint _e346 = local_35;
        local_53 = uint((_e345 + _e346));
        uint _e350 = local_53;
        _group_0_binding_0_cs[_e350] = _e334;
        int _e352 = value;
        ticks = _e352;
        passes = 0;
        {
            int _e356 = value;
            ticks = (_e356 + 1);
            passes = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e366 = ticks;
                    ticks = (_e366 + 2);
                }
                loop_init_1 = false;
                int _e360 = passes;
                passes = (_e360 + 1);
                int _e363 = passes;
                if ((_e363 < 4)) {
                } else {
                    break;
                }
            }
        }
        int _e369 = ticks;
        int _e372 = passes;
        uint _e374 = local;
        local_36 = _e374;
        uint _e376 = local_36;
        local_37 = uint(_e376);
        uint _e379 = base;
        local_38 = uint((_e379 + 10u));
        uint _e384 = local_37;
        uint _e385 = local_38;
        local_54 = uint((_e384 + _e385));
        uint _e389 = local_54;
        _group_0_binding_0_cs[_e389] = ((_e369 * 10) + _e372);
        int _e391 = value;
        argument = _e391;
        int _e393 = argument;
        argument = (_e393 + 1);
        int _e396 = argument;
        int _e398 = pair_add(_e396, 2);
        first = _e398;
        int _e400 = first;
        int _e402 = pair_add(_e400, 3);
        second = _e402;
        int _e404 = second;
        int _e407 = argument;
        uint _e409 = local;
        local_39 = _e409;
        uint _e411 = local_39;
        local_40 = uint(_e411);
        uint _e414 = base;
        local_41 = uint((_e414 + 11u));
        uint _e419 = local_40;
        uint _e420 = local_41;
        local_55 = uint((_e419 + _e420));
        uint _e424 = local_55;
        _group_0_binding_0_cs[_e424] = ((_e404 * 10) + _e407);
    }
}

