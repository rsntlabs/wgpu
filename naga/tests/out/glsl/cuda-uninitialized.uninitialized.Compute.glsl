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
    uint local = 0u;
    uint local_1 = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    int chosen = 0;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    float weighted = 0.0;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    bool negative = false;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint magnitude = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    int total = 0;
    int iteration = 0;
    int copied = 0;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    int descending = 0;
    int iteration_1 = 0;
    int staged = 0;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    int remaining = 0;
    int partial = 0;
    int next = 0;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    int shadow = 0;
    int shadow_1 = 0;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    int local_42 = 0;
    uint local_43 = 0u;
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
        local_41 = uint((_e32 + _e33));
        uint _e38 = local_41;
        int _e40 = _group_0_binding_1_cs[_e38];
        local_42 = _e40;
        int _e41 = local_42;
        value = _e41;
        uint _e43 = i;
        if (((_e43 - 2u * (_e43 / 2u)) == 0u)) {
            int _e48 = value;
            chosen = (_e48 + 7);
        } else {
            int _e52 = value;
            chosen = (_e52 - 4);
        }
        int _e57 = chosen;
        uint _e58 = local;
        local_5 = _e58;
        uint _e60 = local_5;
        local_6 = uint(_e60);
        uint _e63 = base;
        local_7 = uint(_e63);
        uint _e67 = local_6;
        uint _e68 = local_7;
        local_43 = uint((_e67 + _e68));
        uint _e72 = local_43;
        _group_0_binding_0_cs[_e72] = _e57;
        int _e74 = value;
        uint _e75 = i;
        int _e80 = select_value(_e74, ((_e75 - 3u * (_e75 / 3u)) == 0u));
        uint _e81 = local;
        local_8 = _e81;
        uint _e83 = local_8;
        local_9 = uint(_e83);
        uint _e86 = base;
        local_10 = uint((_e86 + 1u));
        uint _e91 = local_9;
        uint _e92 = local_10;
        local_44 = uint((_e91 + _e92));
        uint _e96 = local_44;
        _group_0_binding_0_cs[_e96] = _e80;
        int _e98 = value;
        weighted = ((float(_e98) * 1.5) + 2.0);
        float _e105 = weighted;
        uint _e107 = local;
        local_11 = _e107;
        uint _e109 = local_11;
        local_12 = uint(_e109);
        uint _e112 = base;
        local_13 = uint((_e112 + 2u));
        uint _e117 = local_12;
        uint _e118 = local_13;
        local_45 = uint((_e117 + _e118));
        uint _e122 = local_45;
        _group_0_binding_0_cs[_e122] = int(_e105);
        int _e124 = value;
        negative = (_e124 < 0);
        bool _e128 = negative;
        uint _e129 = local;
        local_14 = _e129;
        uint _e131 = local_14;
        local_15 = uint(_e131);
        uint _e134 = base;
        local_16 = uint((_e134 + 3u));
        uint _e140 = local_15;
        uint _e141 = local_16;
        local_46 = uint((_e140 + _e141));
        uint _e145 = local_46;
        _group_0_binding_0_cs[_e145] = int(_e128);
        int _e147 = value;
        magnitude = uint((_e147 + 5));
        uint _e152 = magnitude;
        uint _e155 = local;
        local_17 = _e155;
        uint _e157 = local_17;
        local_18 = uint(_e157);
        uint _e160 = base;
        local_19 = uint((_e160 + 4u));
        uint _e166 = local_18;
        uint _e167 = local_19;
        local_47 = uint((_e166 + _e167));
        uint _e171 = local_47;
        _group_0_binding_0_cs[_e171] = int((_e152 * 3u));
        uint _e173 = i;
        uint _e176 = accumulate((_e173 - 5u * (_e173 / 5u)));
        uint _e177 = local;
        local_20 = _e177;
        uint _e179 = local_20;
        local_21 = uint(_e179);
        uint _e182 = base;
        local_22 = uint((_e182 + 5u));
        uint _e188 = local_21;
        uint _e189 = local_22;
        local_48 = uint((_e188 + _e189));
        uint _e193 = local_48;
        _group_0_binding_0_cs[_e193] = int(_e176);
        total = 0;
        {
            iteration = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e209 = iteration;
                    iteration = (_e209 + 1);
                }
                loop_init_1 = false;
                int _e199 = iteration;
                if ((_e199 < 3)) {
                } else {
                    break;
                }
                int _e202 = value;
                int _e203 = iteration;
                copied = (_e202 + _e203);
                int _e206 = copied;
                int _e207 = total;
                total = (_e207 + _e206);
            }
        }
        int _e212 = total;
        uint _e213 = local;
        local_23 = _e213;
        uint _e215 = local_23;
        local_24 = uint(_e215);
        uint _e218 = base;
        local_25 = uint((_e218 + 6u));
        uint _e223 = local_24;
        uint _e224 = local_25;
        local_49 = uint((_e223 + _e224));
        uint _e228 = local_49;
        _group_0_binding_0_cs[_e228] = _e212;
        descending = 0;
        iteration_1 = 0;
        {
            bool loop_init_2 = true;
            while(true) {
                if (!loop_init_2) {
                    int _e244 = iteration_1;
                    iteration_1 = (_e244 + 1);
                }
                loop_init_2 = false;
                int _e234 = iteration_1;
                if ((_e234 < 3)) {
                } else {
                    break;
                }
                int _e237 = value;
                int _e238 = iteration_1;
                staged = (_e237 - _e238);
                int _e241 = staged;
                int _e242 = descending;
                descending = (_e242 + _e241);
            }
        }
        int _e247 = descending;
        uint _e248 = local;
        local_26 = _e248;
        uint _e250 = local_26;
        local_27 = uint(_e250);
        uint _e253 = base;
        local_28 = uint((_e253 + 7u));
        uint _e258 = local_27;
        uint _e259 = local_28;
        local_50 = uint((_e258 + _e259));
        uint _e263 = local_50;
        _group_0_binding_0_cs[_e263] = _e247;
        remaining = 2;
        int _e267 = value;
        partial = _e267;
        while(true) {
            int _e269 = remaining;
            if ((_e269 > 0)) {
            } else {
                break;
            }
            {
                int _e272 = partial;
                int _e273 = remaining;
                next = (_e272 + _e273);
                int _e276 = next;
                partial = _e276;
                int _e277 = remaining;
                remaining = (_e277 - 1);
            }
        }
        int _e280 = partial;
        uint _e281 = local;
        local_29 = _e281;
        uint _e283 = local_29;
        local_30 = uint(_e283);
        uint _e286 = base;
        local_31 = uint((_e286 + 8u));
        uint _e291 = local_30;
        uint _e292 = local_31;
        local_51 = uint((_e291 + _e292));
        uint _e296 = local_51;
        _group_0_binding_0_cs[_e296] = _e280;
        int _e298 = value;
        shadow = _e298;
        {
            int _e300 = value;
            shadow_1 = (_e300 + 10);
            int _e304 = shadow_1;
            uint _e305 = local;
            local_32 = _e305;
            uint _e307 = local_32;
            local_33 = uint(_e307);
            uint _e310 = base;
            local_34 = uint((_e310 + 9u));
            uint _e315 = local_33;
            uint _e316 = local_34;
            local_52 = uint((_e315 + _e316));
            uint _e320 = local_52;
            _group_0_binding_0_cs[_e320] = _e304;
        }
        int _e322 = shadow;
        uint _e323 = local;
        local_35 = _e323;
        uint _e325 = local_35;
        local_36 = uint(_e325);
        uint _e328 = base;
        local_37 = uint((_e328 + 10u));
        uint _e333 = local_36;
        uint _e334 = local_37;
        local_53 = uint((_e333 + _e334));
        uint _e338 = local_53;
        _group_0_binding_0_cs[_e338] = _e322;
        int _e340 = value;
        float _e342 = scaled(float(_e340));
        uint _e343 = local;
        local_38 = _e343;
        uint _e345 = local_38;
        local_39 = uint(_e345);
        uint _e348 = base;
        local_40 = uint((_e348 + 11u));
        uint _e354 = local_39;
        uint _e355 = local_40;
        local_54 = uint((_e354 + _e355));
        uint _e359 = local_54;
        _group_0_binding_0_cs[_e359] = int(_e342);
    }
}

