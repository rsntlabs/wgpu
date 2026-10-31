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
    int value_2 = 0;
    bool choose_first_1 = false;
    int result = 0;
    value_2 = value_1;
    choose_first_1 = choose_first;
    bool _e5 = choose_first_1;
    if (_e5) {
        int _e7 = value_2;
        result = (_e7 + 3);
    } else {
        int _e10 = value_2;
        result = (_e10 - 2);
    }
    int _e12 = result;
    return _e12;
}

float scaled(float value_3) {
    float value_4 = 0.0;
    float result_1 = 0.0;
    value_4 = value_3;
    float _e4 = value_4;
    result_1 = ((_e4 * 2.0) + 4.0);
    float _e8 = result_1;
    return _e8;
}

uint accumulate(uint limit) {
    uint limit_1 = 0u;
    uint sum = 0u;
    uint i_1 = 0u;
    uint term = 0u;
    limit_1 = limit;
    sum = 0u;
    {
        i_1 = 0u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e9 = i_1;
                i_1 = (_e9 + uint(1));
            }
            loop_init = false;
            uint _e6 = i_1;
            uint _e7 = limit_1;
            if ((_e6 < _e7)) {
            } else {
                break;
            }
            uint _e15 = i_1;
            if (((_e15 - 2u * (_e15 / 2u)) == 0u)) {
                uint _e20 = i_1;
                term = (_e20 + 1u);
            } else {
                uint _e23 = i_1;
                term = (_e23 * 2u);
            }
            uint _e25 = term;
            uint _e26 = sum;
            sum = (_e26 + _e25);
        }
    }
    uint _e28 = sum;
    return _e28;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local[2] = uint[2](0u, 0u);
    uint local_1[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    int chosen = 0;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    float weighted = 0.0;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    bool negative = false;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint magnitude = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    int total = 0;
    int iteration = 0;
    int copied = 0;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    int descending = 0;
    int iteration_1 = 0;
    int staged = 0;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    int remaining = 0;
    int partial = 0;
    int next = 0;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    int shadow = 0;
    int shadow_1 = 0;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    int local_28 = 0;
    uint local_29[2] = uint[2](0u, 0u);
    uint local_30 = 0u;
    uint local_31 = 0u;
    int local_32 = 0;
    uint local_33[2] = uint[2](0u, 0u);
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39[2] = uint[2](0u, 0u);
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42[2] = uint[2](0u, 0u);
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45[2] = uint[2](0u, 0u);
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48[2] = uint[2](0u, 0u);
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60[2] = uint[2](0u, 0u);
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63[2] = uint[2](0u, 0u);
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66[2] = uint[2](0u, 0u);
    uint local_67 = 0u;
    uint local_68 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    local_1 = uint[2](0u, 0u);
    local_1[0] = 1u;
    local_1[1] = 0u;
    uint _e18 = _group_0_binding_2_cs.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 12u);
        uint _e35[2] = local_1;
        local_2 = _e35;
        uint _e36 = i;
        local_3 = uint(_e36);
        uint _e40[2] = local_2;
        local_29 = _e40;
        uint _e41 = local_3;
        uint _e43 = local_29[1];
        local_29[1] = (_e43 + _e41);
        uint _e47 = local_29[0];
        local_30 = uint(_e47);
        uint _e51 = local_29[1];
        local_31 = uint(_e51);
        uint _e55 = local_31;
        int _e57 = _group_0_binding_1_cs[_e55];
        local_32 = _e57;
        int _e58 = local_32;
        local_28 = _e58;
        int _e60 = local_28;
        value = _e60;
        uint _e62 = i;
        if (((_e62 - 2u * (_e62 / 2u)) == 0u)) {
            int _e67 = value;
            chosen = (_e67 + 7);
        } else {
            int _e71 = value;
            chosen = (_e71 - 4);
        }
        int _e76 = chosen;
        uint _e79[2] = local;
        local_4 = _e79;
        uint _e80 = base;
        local_5 = uint(_e80);
        uint _e84[2] = local_4;
        local_33 = _e84;
        uint _e85 = local_5;
        uint _e87 = local_33[1];
        local_33[1] = (_e87 + _e85);
        uint _e91 = local_33[0];
        local_34 = uint(_e91);
        uint _e95 = local_33[1];
        local_35 = uint(_e95);
        uint _e98 = local_35;
        _group_0_binding_0_cs[_e98] = _e76;
        int _e100 = value;
        uint _e101 = i;
        int _e106 = select_value(_e100, ((_e101 - 3u * (_e101 / 3u)) == 0u));
        uint _e108[2] = local;
        local_6 = _e108;
        uint _e109 = base;
        local_7 = uint((_e109 + 1u));
        uint _e115[2] = local_6;
        local_36 = _e115;
        uint _e116 = local_7;
        uint _e118 = local_36[1];
        local_36[1] = (_e118 + _e116);
        uint _e122 = local_36[0];
        local_37 = uint(_e122);
        uint _e126 = local_36[1];
        local_38 = uint(_e126);
        uint _e129 = local_38;
        _group_0_binding_0_cs[_e129] = _e106;
        int _e131 = value;
        weighted = ((float(_e131) * 1.5) + 2.0);
        float _e138 = weighted;
        uint _e141[2] = local;
        local_8 = _e141;
        uint _e142 = base;
        local_9 = uint((_e142 + 2u));
        uint _e148[2] = local_8;
        local_39 = _e148;
        uint _e149 = local_9;
        uint _e151 = local_39[1];
        local_39[1] = (_e151 + _e149);
        uint _e155 = local_39[0];
        local_40 = uint(_e155);
        uint _e159 = local_39[1];
        local_41 = uint(_e159);
        uint _e162 = local_41;
        _group_0_binding_0_cs[_e162] = int(_e138);
        int _e164 = value;
        negative = (_e164 < 0);
        bool _e168 = negative;
        uint _e170[2] = local;
        local_10 = _e170;
        uint _e171 = base;
        local_11 = uint((_e171 + 3u));
        uint _e178[2] = local_10;
        local_42 = _e178;
        uint _e179 = local_11;
        uint _e181 = local_42[1];
        local_42[1] = (_e181 + _e179);
        uint _e185 = local_42[0];
        local_43 = uint(_e185);
        uint _e189 = local_42[1];
        local_44 = uint(_e189);
        uint _e192 = local_44;
        _group_0_binding_0_cs[_e192] = int(_e168);
        int _e194 = value;
        magnitude = uint((_e194 + 5));
        uint _e199 = magnitude;
        uint _e203[2] = local;
        local_12 = _e203;
        uint _e204 = base;
        local_13 = uint((_e204 + 4u));
        uint _e211[2] = local_12;
        local_45 = _e211;
        uint _e212 = local_13;
        uint _e214 = local_45[1];
        local_45[1] = (_e214 + _e212);
        uint _e218 = local_45[0];
        local_46 = uint(_e218);
        uint _e222 = local_45[1];
        local_47 = uint(_e222);
        uint _e225 = local_47;
        _group_0_binding_0_cs[_e225] = int((_e199 * 3u));
        uint _e227 = i;
        uint _e230 = accumulate((_e227 - 5u * (_e227 / 5u)));
        uint _e232[2] = local;
        local_14 = _e232;
        uint _e233 = base;
        local_15 = uint((_e233 + 5u));
        uint _e240[2] = local_14;
        local_48 = _e240;
        uint _e241 = local_15;
        uint _e243 = local_48[1];
        local_48[1] = (_e243 + _e241);
        uint _e247 = local_48[0];
        local_49 = uint(_e247);
        uint _e251 = local_48[1];
        local_50 = uint(_e251);
        uint _e254 = local_50;
        _group_0_binding_0_cs[_e254] = int(_e230);
        total = 0;
        {
            iteration = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e270 = iteration;
                    iteration = (_e270 + 1);
                }
                loop_init_1 = false;
                int _e260 = iteration;
                if ((_e260 < 3)) {
                } else {
                    break;
                }
                int _e263 = value;
                int _e264 = iteration;
                copied = (_e263 + _e264);
                int _e267 = copied;
                int _e268 = total;
                total = (_e268 + _e267);
            }
        }
        int _e273 = total;
        uint _e275[2] = local;
        local_16 = _e275;
        uint _e276 = base;
        local_17 = uint((_e276 + 6u));
        uint _e282[2] = local_16;
        local_51 = _e282;
        uint _e283 = local_17;
        uint _e285 = local_51[1];
        local_51[1] = (_e285 + _e283);
        uint _e289 = local_51[0];
        local_52 = uint(_e289);
        uint _e293 = local_51[1];
        local_53 = uint(_e293);
        uint _e296 = local_53;
        _group_0_binding_0_cs[_e296] = _e273;
        descending = 0;
        iteration_1 = 0;
        {
            bool loop_init_2 = true;
            while(true) {
                if (!loop_init_2) {
                    int _e312 = iteration_1;
                    iteration_1 = (_e312 + 1);
                }
                loop_init_2 = false;
                int _e302 = iteration_1;
                if ((_e302 < 3)) {
                } else {
                    break;
                }
                int _e305 = value;
                int _e306 = iteration_1;
                staged = (_e305 - _e306);
                int _e309 = staged;
                int _e310 = descending;
                descending = (_e310 + _e309);
            }
        }
        int _e315 = descending;
        uint _e317[2] = local;
        local_18 = _e317;
        uint _e318 = base;
        local_19 = uint((_e318 + 7u));
        uint _e324[2] = local_18;
        local_54 = _e324;
        uint _e325 = local_19;
        uint _e327 = local_54[1];
        local_54[1] = (_e327 + _e325);
        uint _e331 = local_54[0];
        local_55 = uint(_e331);
        uint _e335 = local_54[1];
        local_56 = uint(_e335);
        uint _e338 = local_56;
        _group_0_binding_0_cs[_e338] = _e315;
        remaining = 2;
        int _e342 = value;
        partial = _e342;
        while(true) {
            int _e344 = remaining;
            if ((_e344 > 0)) {
            } else {
                break;
            }
            {
                int _e347 = partial;
                int _e348 = remaining;
                next = (_e347 + _e348);
                int _e351 = next;
                partial = _e351;
                int _e352 = remaining;
                remaining = (_e352 - 1);
            }
        }
        int _e355 = partial;
        uint _e357[2] = local;
        local_20 = _e357;
        uint _e358 = base;
        local_21 = uint((_e358 + 8u));
        uint _e364[2] = local_20;
        local_57 = _e364;
        uint _e365 = local_21;
        uint _e367 = local_57[1];
        local_57[1] = (_e367 + _e365);
        uint _e371 = local_57[0];
        local_58 = uint(_e371);
        uint _e375 = local_57[1];
        local_59 = uint(_e375);
        uint _e378 = local_59;
        _group_0_binding_0_cs[_e378] = _e355;
        int _e380 = value;
        shadow = _e380;
        {
            int _e382 = value;
            shadow_1 = (_e382 + 10);
            int _e386 = shadow_1;
            uint _e388[2] = local;
            local_22 = _e388;
            uint _e389 = base;
            local_23 = uint((_e389 + 9u));
            uint _e395[2] = local_22;
            local_60 = _e395;
            uint _e396 = local_23;
            uint _e398 = local_60[1];
            local_60[1] = (_e398 + _e396);
            uint _e402 = local_60[0];
            local_61 = uint(_e402);
            uint _e406 = local_60[1];
            local_62 = uint(_e406);
            uint _e409 = local_62;
            _group_0_binding_0_cs[_e409] = _e386;
        }
        int _e411 = shadow;
        uint _e413[2] = local;
        local_24 = _e413;
        uint _e414 = base;
        local_25 = uint((_e414 + 10u));
        uint _e420[2] = local_24;
        local_63 = _e420;
        uint _e421 = local_25;
        uint _e423 = local_63[1];
        local_63[1] = (_e423 + _e421);
        uint _e427 = local_63[0];
        local_64 = uint(_e427);
        uint _e431 = local_63[1];
        local_65 = uint(_e431);
        uint _e434 = local_65;
        _group_0_binding_0_cs[_e434] = _e411;
        int _e436 = value;
        float _e438 = scaled(float(_e436));
        uint _e440[2] = local;
        local_26 = _e440;
        uint _e441 = base;
        local_27 = uint((_e441 + 11u));
        uint _e448[2] = local_26;
        local_66 = _e448;
        uint _e449 = local_27;
        uint _e451 = local_66[1];
        local_66[1] = (_e451 + _e449);
        uint _e455 = local_66[0];
        local_67 = uint(_e455);
        uint _e459 = local_66[1];
        local_68 = uint(_e459);
        uint _e462 = local_68;
        _group_0_binding_0_cs[_e462] = int(_e438);
    }
}

