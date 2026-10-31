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
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint base = 0u;
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    int chosen = 0;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    float weighted = 0.0;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    bool negative = false;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint magnitude = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    int total = 0;
    int iteration = 0;
    int copied = 0;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    int descending = 0;
    int iteration_1 = 0;
    int staged = 0;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    int remaining = 0;
    int partial = 0;
    int next = 0;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    int shadow = 0;
    int shadow_1 = 0;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    int local_26 = 0;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    int local_30 = 0;
    uint local_31[2] = uint[2](0u, 0u);
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37[2] = uint[2](0u, 0u);
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40[2] = uint[2](0u, 0u);
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43[2] = uint[2](0u, 0u);
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46[2] = uint[2](0u, 0u);
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49[2] = uint[2](0u, 0u);
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52[2] = uint[2](0u, 0u);
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55[2] = uint[2](0u, 0u);
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58[2] = uint[2](0u, 0u);
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61[2] = uint[2](0u, 0u);
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64[2] = uint[2](0u, 0u);
    uint local_65 = 0u;
    uint local_66 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 1u;
    input_[1] = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 12u);
        uint _e27[2] = input_;
        local = _e27;
        local_1 = uint(i_1);
        uint _e31[2] = local;
        local_27 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_27[1];
        local_27[1] = (_e35 + _e33);
        uint _e39 = local_27[0];
        local_28 = uint(_e39);
        uint _e43 = local_27[1];
        local_29 = uint(_e43);
        uint _e46 = local_29;
        int _e49 = _group_0_binding_1_cs[_e46];
        local_30 = _e49;
        int _e51 = local_30;
        local_26 = _e51;
        int _e53 = local_26;
        value = _e53;
        if (((i_1 - 2u * (i_1 / 2u)) == 0u)) {
            int _e59 = value;
            chosen = (_e59 + 7);
        } else {
            int _e63 = value;
            chosen = (_e63 - 4);
        }
        int _e68 = chosen;
        uint _e70[2] = out_;
        local_2 = _e70;
        uint _e72 = base;
        local_3 = uint(_e72);
        uint _e75[2] = local_2;
        local_31 = _e75;
        uint _e77 = local_3;
        uint _e79 = local_31[1];
        local_31[1] = (_e79 + _e77);
        uint _e83 = local_31[0];
        local_32 = uint(_e83);
        uint _e87 = local_31[1];
        local_33 = uint(_e87);
        uint _e90 = local_33;
        _group_0_binding_0_cs[_e90] = _e68;
        int _e93 = value;
        int _e98 = select_value(_e93, ((i_1 - 3u * (i_1 / 3u)) == 0u));
        uint _e99[2] = out_;
        local_4 = _e99;
        uint _e101 = base;
        local_5 = uint((_e101 + 1u));
        uint _e106[2] = local_4;
        local_34 = _e106;
        uint _e108 = local_5;
        uint _e110 = local_34[1];
        local_34[1] = (_e110 + _e108);
        uint _e114 = local_34[0];
        local_35 = uint(_e114);
        uint _e118 = local_34[1];
        local_36 = uint(_e118);
        uint _e121 = local_36;
        _group_0_binding_0_cs[_e121] = _e98;
        int _e123 = value;
        weighted = ((float(_e123) * 1.5) + 2.0);
        float _e130 = weighted;
        uint _e132[2] = out_;
        local_6 = _e132;
        uint _e134 = base;
        local_7 = uint((_e134 + 2u));
        uint _e139[2] = local_6;
        local_37 = _e139;
        uint _e141 = local_7;
        uint _e143 = local_37[1];
        local_37[1] = (_e143 + _e141);
        uint _e147 = local_37[0];
        local_38 = uint(_e147);
        uint _e151 = local_37[1];
        local_39 = uint(_e151);
        uint _e154 = local_39;
        _group_0_binding_0_cs[_e154] = int(_e130);
        int _e156 = value;
        negative = (_e156 < 0);
        bool _e160 = negative;
        uint _e161[2] = out_;
        local_8 = _e161;
        uint _e163 = base;
        local_9 = uint((_e163 + 3u));
        uint _e169[2] = local_8;
        local_40 = _e169;
        uint _e171 = local_9;
        uint _e173 = local_40[1];
        local_40[1] = (_e173 + _e171);
        uint _e177 = local_40[0];
        local_41 = uint(_e177);
        uint _e181 = local_40[1];
        local_42 = uint(_e181);
        uint _e184 = local_42;
        _group_0_binding_0_cs[_e184] = int(_e160);
        int _e186 = value;
        magnitude = uint((_e186 + 5));
        uint _e191 = magnitude;
        uint _e194[2] = out_;
        local_10 = _e194;
        uint _e196 = base;
        local_11 = uint((_e196 + 4u));
        uint _e202[2] = local_10;
        local_43 = _e202;
        uint _e204 = local_11;
        uint _e206 = local_43[1];
        local_43[1] = (_e206 + _e204);
        uint _e210 = local_43[0];
        local_44 = uint(_e210);
        uint _e214 = local_43[1];
        local_45 = uint(_e214);
        uint _e217 = local_45;
        _group_0_binding_0_cs[_e217] = int((_e191 * 3u));
        uint _e221 = accumulate((i_1 - 5u * (i_1 / 5u)));
        uint _e222[2] = out_;
        local_12 = _e222;
        uint _e224 = base;
        local_13 = uint((_e224 + 5u));
        uint _e230[2] = local_12;
        local_46 = _e230;
        uint _e232 = local_13;
        uint _e234 = local_46[1];
        local_46[1] = (_e234 + _e232);
        uint _e238 = local_46[0];
        local_47 = uint(_e238);
        uint _e242 = local_46[1];
        local_48 = uint(_e242);
        uint _e245 = local_48;
        _group_0_binding_0_cs[_e245] = int(_e221);
        total = 0;
        {
            iteration = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e261 = iteration;
                    iteration = (_e261 + 1);
                }
                loop_init_1 = false;
                int _e251 = iteration;
                if ((_e251 < 3)) {
                } else {
                    break;
                }
                int _e254 = value;
                int _e255 = iteration;
                copied = (_e254 + _e255);
                int _e258 = copied;
                int _e259 = total;
                total = (_e259 + _e258);
            }
        }
        int _e264 = total;
        uint _e265[2] = out_;
        local_14 = _e265;
        uint _e267 = base;
        local_15 = uint((_e267 + 6u));
        uint _e272[2] = local_14;
        local_49 = _e272;
        uint _e274 = local_15;
        uint _e276 = local_49[1];
        local_49[1] = (_e276 + _e274);
        uint _e280 = local_49[0];
        local_50 = uint(_e280);
        uint _e284 = local_49[1];
        local_51 = uint(_e284);
        uint _e287 = local_51;
        _group_0_binding_0_cs[_e287] = _e264;
        descending = 0;
        iteration_1 = 0;
        {
            bool loop_init_2 = true;
            while(true) {
                if (!loop_init_2) {
                    int _e303 = iteration_1;
                    iteration_1 = (_e303 + 1);
                }
                loop_init_2 = false;
                int _e293 = iteration_1;
                if ((_e293 < 3)) {
                } else {
                    break;
                }
                int _e296 = value;
                int _e297 = iteration_1;
                staged = (_e296 - _e297);
                int _e300 = staged;
                int _e301 = descending;
                descending = (_e301 + _e300);
            }
        }
        int _e306 = descending;
        uint _e307[2] = out_;
        local_16 = _e307;
        uint _e309 = base;
        local_17 = uint((_e309 + 7u));
        uint _e314[2] = local_16;
        local_52 = _e314;
        uint _e316 = local_17;
        uint _e318 = local_52[1];
        local_52[1] = (_e318 + _e316);
        uint _e322 = local_52[0];
        local_53 = uint(_e322);
        uint _e326 = local_52[1];
        local_54 = uint(_e326);
        uint _e329 = local_54;
        _group_0_binding_0_cs[_e329] = _e306;
        remaining = 2;
        int _e333 = value;
        partial = _e333;
        while(true) {
            int _e335 = remaining;
            if ((_e335 > 0)) {
            } else {
                break;
            }
            {
                int _e338 = partial;
                int _e339 = remaining;
                next = (_e338 + _e339);
                int _e342 = next;
                partial = _e342;
                int _e343 = remaining;
                remaining = (_e343 - 1);
            }
        }
        int _e346 = partial;
        uint _e347[2] = out_;
        local_18 = _e347;
        uint _e349 = base;
        local_19 = uint((_e349 + 8u));
        uint _e354[2] = local_18;
        local_55 = _e354;
        uint _e356 = local_19;
        uint _e358 = local_55[1];
        local_55[1] = (_e358 + _e356);
        uint _e362 = local_55[0];
        local_56 = uint(_e362);
        uint _e366 = local_55[1];
        local_57 = uint(_e366);
        uint _e369 = local_57;
        _group_0_binding_0_cs[_e369] = _e346;
        int _e371 = value;
        shadow = _e371;
        {
            int _e373 = value;
            shadow_1 = (_e373 + 10);
            int _e377 = shadow_1;
            uint _e378[2] = out_;
            local_20 = _e378;
            uint _e380 = base;
            local_21 = uint((_e380 + 9u));
            uint _e385[2] = local_20;
            local_58 = _e385;
            uint _e387 = local_21;
            uint _e389 = local_58[1];
            local_58[1] = (_e389 + _e387);
            uint _e393 = local_58[0];
            local_59 = uint(_e393);
            uint _e397 = local_58[1];
            local_60 = uint(_e397);
            uint _e400 = local_60;
            _group_0_binding_0_cs[_e400] = _e377;
        }
        int _e402 = shadow;
        uint _e403[2] = out_;
        local_22 = _e403;
        uint _e405 = base;
        local_23 = uint((_e405 + 10u));
        uint _e410[2] = local_22;
        local_61 = _e410;
        uint _e412 = local_23;
        uint _e414 = local_61[1];
        local_61[1] = (_e414 + _e412);
        uint _e418 = local_61[0];
        local_62 = uint(_e418);
        uint _e422 = local_61[1];
        local_63 = uint(_e422);
        uint _e425 = local_63;
        _group_0_binding_0_cs[_e425] = _e402;
        int _e427 = value;
        float _e429 = scaled(float(_e427));
        uint _e430[2] = out_;
        local_24 = _e430;
        uint _e432 = base;
        local_25 = uint((_e432 + 11u));
        uint _e438[2] = local_24;
        local_64 = _e438;
        uint _e440 = local_25;
        uint _e442 = local_64[1];
        local_64[1] = (_e442 + _e440);
        uint _e446 = local_64[0];
        local_65 = uint(_e446);
        uint _e450 = local_64[1];
        local_66 = uint(_e450);
        uint _e453 = local_66;
        _group_0_binding_0_cs[_e453] = int(_e429);
    }
}

