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
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint base = 0u;
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    bool choose = false;
    int x = 0;
    int sequenced = 0;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    int target = 0;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    int rhs = 0;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    int middle = 0;
    int selected = 0;
    int local_10 = 0;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    int left = 0;
    int right = 0;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14 = 0u;
    int identity = 0;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint position = 0u;
    uint local_17[2] = uint[2](0u, 0u);
    uint local_18 = 0u;
    int effect = 0;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    int total = 0;
    int iteration = 0;
    int current = 0;
    uint local_21[2] = uint[2](0u, 0u);
    uint local_22 = 0u;
    int ticks = 0;
    int passes = 0;
    uint local_23[2] = uint[2](0u, 0u);
    uint local_24 = 0u;
    int argument = 0;
    int first = 0;
    int second = 0;
    uint local_25[2] = uint[2](0u, 0u);
    uint local_26 = 0u;
    int local_27 = 0;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30 = 0u;
    int local_31 = 0;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35[2] = uint[2](0u, 0u);
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38[2] = uint[2](0u, 0u);
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53[2] = uint[2](0u, 0u);
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59[2] = uint[2](0u, 0u);
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 1u;
    input_[1] = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        uint _e27[2] = input_;
        local = _e27;
        local_1 = uint(i);
        uint _e31[2] = local;
        local_28 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_28[1];
        local_28[1] = (_e35 + _e33);
        uint _e39 = local_28[0];
        local_29 = uint(_e39);
        uint _e43 = local_28[1];
        local_30 = uint(_e43);
        uint _e46 = local_30;
        int _e49 = _group_0_binding_1_cs[_e46];
        local_31 = _e49;
        int _e51 = local_31;
        local_27 = _e51;
        int _e53 = local_27;
        value = _e53;
        choose = ((i - 2u * (i / 2u)) == 0u);
        int _e60 = value;
        x = _e60;
        int _e62 = x;
        x = (_e62 + 2);
        int _e65 = x;
        x = (_e65 * 3);
        int _e68 = x;
        sequenced = (_e68 - 1);
        int _e72 = sequenced;
        uint _e74[2] = out_;
        local_2 = _e74;
        uint _e76 = base;
        local_3 = uint(_e76);
        uint _e79[2] = local_2;
        local_32 = _e79;
        uint _e81 = local_3;
        uint _e83 = local_32[1];
        local_32[1] = (_e83 + _e81);
        uint _e87 = local_32[0];
        local_33 = uint(_e87);
        uint _e91 = local_32[1];
        local_34 = uint(_e91);
        uint _e94 = local_34;
        _group_0_binding_0_cs[_e94] = _e72;
        int _e97 = x;
        uint _e98[2] = out_;
        local_4 = _e98;
        uint _e100 = base;
        local_5 = uint((_e100 + 1u));
        uint _e105[2] = local_4;
        local_35 = _e105;
        uint _e107 = local_5;
        uint _e109 = local_35[1];
        local_35[1] = (_e109 + _e107);
        uint _e113 = local_35[0];
        local_36 = uint(_e113);
        uint _e117 = local_35[1];
        local_37 = uint(_e117);
        uint _e120 = local_37;
        _group_0_binding_0_cs[_e120] = _e97;
        target = 0;
        int _e124 = value;
        target = _e124;
        int _e125 = target;
        target = (_e125 + 4);
        int _e128 = target;
        uint _e129[2] = out_;
        local_6 = _e129;
        uint _e131 = base;
        local_7 = uint((_e131 + 2u));
        uint _e136[2] = local_6;
        local_38 = _e136;
        uint _e138 = local_7;
        uint _e140 = local_38[1];
        local_38[1] = (_e140 + _e138);
        uint _e144 = local_38[0];
        local_39 = uint(_e144);
        uint _e148 = local_38[1];
        local_40 = uint(_e148);
        uint _e151 = local_40;
        _group_0_binding_0_cs[_e151] = _e128;
        int _e153 = value;
        target = (_e153 + 1);
        int _e156 = target;
        rhs = (_e156 + 3);
        int _e160 = rhs;
        int _e163 = target;
        uint _e165[2] = out_;
        local_8 = _e165;
        uint _e167 = base;
        local_9 = uint((_e167 + 3u));
        uint _e172[2] = local_8;
        local_41 = _e172;
        uint _e174 = local_9;
        uint _e176 = local_41[1];
        local_41[1] = (_e176 + _e174);
        uint _e180 = local_41[0];
        local_42 = uint(_e180);
        uint _e184 = local_41[1];
        local_43 = uint(_e184);
        uint _e187 = local_43;
        _group_0_binding_0_cs[_e187] = ((_e160 * 10) + _e163);
        middle = 0;
        bool _e191 = choose;
        if (_e191) {
            int _e192 = value;
            middle = (_e192 + 2);
            int _e195 = middle;
            local_10 = (_e195 + 3);
        } else {
            int _e199 = value;
            local_10 = (_e199 - 2);
        }
        int _e204 = local_10;
        selected = _e204;
        int _e206 = selected;
        int _e209 = middle;
        uint _e211[2] = out_;
        local_11 = _e211;
        uint _e213 = base;
        local_12 = uint((_e213 + 4u));
        uint _e218[2] = local_11;
        local_44 = _e218;
        uint _e220 = local_12;
        uint _e222 = local_44[1];
        local_44[1] = (_e222 + _e220);
        uint _e226 = local_44[0];
        local_45 = uint(_e226);
        uint _e230 = local_44[1];
        local_46 = uint(_e230);
        uint _e233 = local_46;
        _group_0_binding_0_cs[_e233] = ((_e206 * 10) + _e209);
        int _e235 = value;
        left = _e235;
        int _e237 = value;
        right = (_e237 + 10);
        int _e241 = value;
        consume(_e241);
        bool _e242 = choose;
        if (_e242) {
            int _e243 = left;
            left = (_e243 + 3);
        } else {
            int _e246 = right;
            right = (_e246 + 3);
        }
        int _e249 = left;
        int _e252 = right;
        uint _e254[2] = out_;
        local_13 = _e254;
        uint _e256 = base;
        local_14 = uint((_e256 + 5u));
        uint _e261[2] = local_13;
        local_47 = _e261;
        uint _e263 = local_14;
        uint _e265 = local_47[1];
        local_47[1] = (_e265 + _e263);
        uint _e269 = local_47[0];
        local_48 = uint(_e269);
        uint _e273 = local_47[1];
        local_49 = uint(_e273);
        uint _e276 = local_49;
        _group_0_binding_0_cs[_e276] = ((_e249 * 100) + _e252);
        int _e278 = value;
        identity = _e278;
        int _e280 = identity;
        identity = (_e280 + 1);
        consume(_e280);
        int _e283 = identity;
        identity = (_e283 + 1);
        int _e286 = identity;
        uint _e287[2] = out_;
        local_15 = _e287;
        uint _e289 = base;
        local_16 = uint((_e289 + 6u));
        uint _e294[2] = local_15;
        local_50 = _e294;
        uint _e296 = local_16;
        uint _e298 = local_50[1];
        local_50[1] = (_e298 + _e296);
        uint _e302 = local_50[0];
        local_51 = uint(_e302);
        uint _e306 = local_50[1];
        local_52 = uint(_e306);
        uint _e309 = local_52;
        _group_0_binding_0_cs[_e309] = _e286;
        uint _e311 = base;
        position = (_e311 + 4u);
        uint _e315 = position;
        position = (_e315 + 2u);
        int _e318 = value;
        uint _e323 = position;
        position = (_e323 + uint(1));
        uint _e327[2] = out_;
        local_17 = _e327;
        uint _e329 = position;
        local_18 = uint(_e329);
        uint _e332[2] = local_17;
        local_53 = _e332;
        uint _e334 = local_18;
        uint _e336 = local_53[1];
        local_53[1] = (_e336 + _e334);
        uint _e340 = local_53[0];
        local_54 = uint(_e340);
        uint _e344 = local_53[1];
        local_55 = uint(_e344);
        uint _e347 = local_55;
        _group_0_binding_0_cs[_e347] = ((_e318 * 2) + 2);
        int _e349 = value;
        effect = _e349;
        int _e351 = effect;
        effect = (_e351 + 1);
        consume(_e351);
        int _e354 = effect;
        effect = (_e354 + 1);
        consume(_e354);
        int _e357 = effect;
        effect = (_e357 + 1);
        consume(_e357);
        int _e360 = effect;
        effect = (_e360 + 1);
        consume(_e360);
        int _e363 = effect;
        uint _e364[2] = out_;
        local_19 = _e364;
        uint _e366 = base;
        local_20 = uint((_e366 + 8u));
        uint _e371[2] = local_19;
        local_56 = _e371;
        uint _e373 = local_20;
        uint _e375 = local_56[1];
        local_56[1] = (_e375 + _e373);
        uint _e379 = local_56[0];
        local_57 = uint(_e379);
        uint _e383 = local_56[1];
        local_58 = uint(_e383);
        uint _e386 = local_58;
        _group_0_binding_0_cs[_e386] = _e363;
        total = 0;
        {
            iteration = 0;
            int _e392 = value;
            current = _e392;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e403 = iteration;
                    iteration = (_e403 + 1);
                    int _e406 = current;
                    current = (_e406 + 2);
                }
                loop_init = false;
                int _e394 = iteration;
                if ((_e394 < 4)) {
                } else {
                    break;
                }
                int _e397 = iteration;
                if ((_e397 != 1)) {
                    int _e400 = current;
                    int _e401 = total;
                    total = (_e401 + _e400);
                } else {
                    continue;
                }
            }
        }
        int _e409 = total;
        uint _e410[2] = out_;
        local_21 = _e410;
        uint _e412 = base;
        local_22 = uint((_e412 + 9u));
        uint _e417[2] = local_21;
        local_59 = _e417;
        uint _e419 = local_22;
        uint _e421 = local_59[1];
        local_59[1] = (_e421 + _e419);
        uint _e425 = local_59[0];
        local_60 = uint(_e425);
        uint _e429 = local_59[1];
        local_61 = uint(_e429);
        uint _e432 = local_61;
        _group_0_binding_0_cs[_e432] = _e409;
        int _e434 = value;
        ticks = _e434;
        passes = 0;
        {
            int _e438 = value;
            ticks = (_e438 + 1);
            passes = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e448 = ticks;
                    ticks = (_e448 + 2);
                }
                loop_init_1 = false;
                int _e442 = passes;
                passes = (_e442 + 1);
                int _e445 = passes;
                if ((_e445 < 4)) {
                } else {
                    break;
                }
            }
        }
        int _e451 = ticks;
        int _e454 = passes;
        uint _e456[2] = out_;
        local_23 = _e456;
        uint _e458 = base;
        local_24 = uint((_e458 + 10u));
        uint _e463[2] = local_23;
        local_62 = _e463;
        uint _e465 = local_24;
        uint _e467 = local_62[1];
        local_62[1] = (_e467 + _e465);
        uint _e471 = local_62[0];
        local_63 = uint(_e471);
        uint _e475 = local_62[1];
        local_64 = uint(_e475);
        uint _e478 = local_64;
        _group_0_binding_0_cs[_e478] = ((_e451 * 10) + _e454);
        int _e480 = value;
        argument = _e480;
        int _e482 = argument;
        argument = (_e482 + 1);
        int _e485 = argument;
        int _e487 = pair_add(_e485, 2);
        first = _e487;
        int _e489 = first;
        int _e491 = pair_add(_e489, 3);
        second = _e491;
        int _e493 = second;
        int _e496 = argument;
        uint _e498[2] = out_;
        local_25 = _e498;
        uint _e500 = base;
        local_26 = uint((_e500 + 11u));
        uint _e505[2] = local_25;
        local_65 = _e505;
        uint _e507 = local_26;
        uint _e509 = local_65[1];
        local_65[1] = (_e509 + _e507);
        uint _e513 = local_65[0];
        local_66 = uint(_e513);
        uint _e517 = local_65[1];
        local_67 = uint(_e517);
        uint _e520 = local_67;
        _group_0_binding_0_cs[_e520] = ((_e493 * 10) + _e496);
    }
}

