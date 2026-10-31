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
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
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
    uint _e18 = _group_0_binding_2_cs.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 12u);
        uint _e35[2] = input_;
        local = _e35;
        uint _e36 = i;
        local_1 = uint(_e36);
        uint _e40[2] = local;
        local_28 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_28[1];
        local_28[1] = (_e43 + _e41);
        uint _e47 = local_28[0];
        local_29 = uint(_e47);
        uint _e51 = local_28[1];
        local_30 = uint(_e51);
        uint _e55 = local_30;
        int _e57 = _group_0_binding_1_cs[_e55];
        local_31 = _e57;
        int _e58 = local_31;
        local_27 = _e58;
        int _e60 = local_27;
        value = _e60;
        uint _e62 = i;
        choose = ((_e62 - 2u * (_e62 / 2u)) == 0u);
        int _e68 = value;
        x = _e68;
        int _e70 = x;
        x = (_e70 + 2);
        int _e73 = x;
        x = (_e73 * 3);
        int _e76 = x;
        sequenced = (_e76 - 1);
        int _e80 = sequenced;
        uint _e83[2] = out_;
        local_2 = _e83;
        uint _e84 = base;
        local_3 = uint(_e84);
        uint _e88[2] = local_2;
        local_32 = _e88;
        uint _e89 = local_3;
        uint _e91 = local_32[1];
        local_32[1] = (_e91 + _e89);
        uint _e95 = local_32[0];
        local_33 = uint(_e95);
        uint _e99 = local_32[1];
        local_34 = uint(_e99);
        uint _e102 = local_34;
        _group_0_binding_0_cs[_e102] = _e80;
        int _e104 = x;
        uint _e106[2] = out_;
        local_4 = _e106;
        uint _e107 = base;
        local_5 = uint((_e107 + 1u));
        uint _e113[2] = local_4;
        local_35 = _e113;
        uint _e114 = local_5;
        uint _e116 = local_35[1];
        local_35[1] = (_e116 + _e114);
        uint _e120 = local_35[0];
        local_36 = uint(_e120);
        uint _e124 = local_35[1];
        local_37 = uint(_e124);
        uint _e127 = local_37;
        _group_0_binding_0_cs[_e127] = _e104;
        target = 0;
        int _e131 = value;
        target = _e131;
        int _e132 = target;
        target = (_e132 + 4);
        int _e135 = target;
        uint _e137[2] = out_;
        local_6 = _e137;
        uint _e138 = base;
        local_7 = uint((_e138 + 2u));
        uint _e144[2] = local_6;
        local_38 = _e144;
        uint _e145 = local_7;
        uint _e147 = local_38[1];
        local_38[1] = (_e147 + _e145);
        uint _e151 = local_38[0];
        local_39 = uint(_e151);
        uint _e155 = local_38[1];
        local_40 = uint(_e155);
        uint _e158 = local_40;
        _group_0_binding_0_cs[_e158] = _e135;
        int _e160 = value;
        target = (_e160 + 1);
        int _e163 = target;
        rhs = (_e163 + 3);
        int _e167 = rhs;
        int _e170 = target;
        uint _e173[2] = out_;
        local_8 = _e173;
        uint _e174 = base;
        local_9 = uint((_e174 + 3u));
        uint _e180[2] = local_8;
        local_41 = _e180;
        uint _e181 = local_9;
        uint _e183 = local_41[1];
        local_41[1] = (_e183 + _e181);
        uint _e187 = local_41[0];
        local_42 = uint(_e187);
        uint _e191 = local_41[1];
        local_43 = uint(_e191);
        uint _e194 = local_43;
        _group_0_binding_0_cs[_e194] = ((_e167 * 10) + _e170);
        middle = 0;
        bool _e198 = choose;
        if (_e198) {
            int _e199 = value;
            middle = (_e199 + 2);
            int _e202 = middle;
            local_10 = (_e202 + 3);
        } else {
            int _e206 = value;
            local_10 = (_e206 - 2);
        }
        int _e211 = local_10;
        selected = _e211;
        int _e213 = selected;
        int _e216 = middle;
        uint _e219[2] = out_;
        local_11 = _e219;
        uint _e220 = base;
        local_12 = uint((_e220 + 4u));
        uint _e226[2] = local_11;
        local_44 = _e226;
        uint _e227 = local_12;
        uint _e229 = local_44[1];
        local_44[1] = (_e229 + _e227);
        uint _e233 = local_44[0];
        local_45 = uint(_e233);
        uint _e237 = local_44[1];
        local_46 = uint(_e237);
        uint _e240 = local_46;
        _group_0_binding_0_cs[_e240] = ((_e213 * 10) + _e216);
        int _e242 = value;
        left = _e242;
        int _e244 = value;
        right = (_e244 + 10);
        int _e248 = value;
        consume(_e248);
        bool _e249 = choose;
        if (_e249) {
            int _e250 = left;
            left = (_e250 + 3);
        } else {
            int _e253 = right;
            right = (_e253 + 3);
        }
        int _e256 = left;
        int _e259 = right;
        uint _e262[2] = out_;
        local_13 = _e262;
        uint _e263 = base;
        local_14 = uint((_e263 + 5u));
        uint _e269[2] = local_13;
        local_47 = _e269;
        uint _e270 = local_14;
        uint _e272 = local_47[1];
        local_47[1] = (_e272 + _e270);
        uint _e276 = local_47[0];
        local_48 = uint(_e276);
        uint _e280 = local_47[1];
        local_49 = uint(_e280);
        uint _e283 = local_49;
        _group_0_binding_0_cs[_e283] = ((_e256 * 100) + _e259);
        int _e285 = value;
        identity = _e285;
        int _e287 = identity;
        identity = (_e287 + 1);
        consume(_e287);
        int _e290 = identity;
        identity = (_e290 + 1);
        int _e293 = identity;
        uint _e295[2] = out_;
        local_15 = _e295;
        uint _e296 = base;
        local_16 = uint((_e296 + 6u));
        uint _e302[2] = local_15;
        local_50 = _e302;
        uint _e303 = local_16;
        uint _e305 = local_50[1];
        local_50[1] = (_e305 + _e303);
        uint _e309 = local_50[0];
        local_51 = uint(_e309);
        uint _e313 = local_50[1];
        local_52 = uint(_e313);
        uint _e316 = local_52;
        _group_0_binding_0_cs[_e316] = _e293;
        uint _e318 = base;
        position = (_e318 + 4u);
        uint _e322 = position;
        position = (_e322 + 2u);
        int _e325 = value;
        uint _e330 = position;
        position = (_e330 + uint(1));
        uint _e335[2] = out_;
        local_17 = _e335;
        uint _e336 = position;
        local_18 = uint(_e336);
        uint _e340[2] = local_17;
        local_53 = _e340;
        uint _e341 = local_18;
        uint _e343 = local_53[1];
        local_53[1] = (_e343 + _e341);
        uint _e347 = local_53[0];
        local_54 = uint(_e347);
        uint _e351 = local_53[1];
        local_55 = uint(_e351);
        uint _e354 = local_55;
        _group_0_binding_0_cs[_e354] = ((_e325 * 2) + 2);
        int _e356 = value;
        effect = _e356;
        int _e358 = effect;
        effect = (_e358 + 1);
        consume(_e358);
        int _e361 = effect;
        effect = (_e361 + 1);
        consume(_e361);
        int _e364 = effect;
        effect = (_e364 + 1);
        consume(_e364);
        int _e367 = effect;
        effect = (_e367 + 1);
        consume(_e367);
        int _e370 = effect;
        uint _e372[2] = out_;
        local_19 = _e372;
        uint _e373 = base;
        local_20 = uint((_e373 + 8u));
        uint _e379[2] = local_19;
        local_56 = _e379;
        uint _e380 = local_20;
        uint _e382 = local_56[1];
        local_56[1] = (_e382 + _e380);
        uint _e386 = local_56[0];
        local_57 = uint(_e386);
        uint _e390 = local_56[1];
        local_58 = uint(_e390);
        uint _e393 = local_58;
        _group_0_binding_0_cs[_e393] = _e370;
        total = 0;
        {
            iteration = 0;
            int _e399 = value;
            current = _e399;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e410 = iteration;
                    iteration = (_e410 + 1);
                    int _e413 = current;
                    current = (_e413 + 2);
                }
                loop_init = false;
                int _e401 = iteration;
                if ((_e401 < 4)) {
                } else {
                    break;
                }
                int _e404 = iteration;
                if ((_e404 != 1)) {
                    int _e407 = current;
                    int _e408 = total;
                    total = (_e408 + _e407);
                } else {
                    continue;
                }
            }
        }
        int _e416 = total;
        uint _e418[2] = out_;
        local_21 = _e418;
        uint _e419 = base;
        local_22 = uint((_e419 + 9u));
        uint _e425[2] = local_21;
        local_59 = _e425;
        uint _e426 = local_22;
        uint _e428 = local_59[1];
        local_59[1] = (_e428 + _e426);
        uint _e432 = local_59[0];
        local_60 = uint(_e432);
        uint _e436 = local_59[1];
        local_61 = uint(_e436);
        uint _e439 = local_61;
        _group_0_binding_0_cs[_e439] = _e416;
        int _e441 = value;
        ticks = _e441;
        passes = 0;
        {
            int _e445 = value;
            ticks = (_e445 + 1);
            passes = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e455 = ticks;
                    ticks = (_e455 + 2);
                }
                loop_init_1 = false;
                int _e449 = passes;
                passes = (_e449 + 1);
                int _e452 = passes;
                if ((_e452 < 4)) {
                } else {
                    break;
                }
            }
        }
        int _e458 = ticks;
        int _e461 = passes;
        uint _e464[2] = out_;
        local_23 = _e464;
        uint _e465 = base;
        local_24 = uint((_e465 + 10u));
        uint _e471[2] = local_23;
        local_62 = _e471;
        uint _e472 = local_24;
        uint _e474 = local_62[1];
        local_62[1] = (_e474 + _e472);
        uint _e478 = local_62[0];
        local_63 = uint(_e478);
        uint _e482 = local_62[1];
        local_64 = uint(_e482);
        uint _e485 = local_64;
        _group_0_binding_0_cs[_e485] = ((_e458 * 10) + _e461);
        int _e487 = value;
        argument = _e487;
        int _e489 = argument;
        argument = (_e489 + 1);
        int _e492 = argument;
        int _e494 = pair_add(_e492, 2);
        first = _e494;
        int _e496 = first;
        int _e498 = pair_add(_e496, 3);
        second = _e498;
        int _e500 = second;
        int _e503 = argument;
        uint _e506[2] = out_;
        local_25 = _e506;
        uint _e507 = base;
        local_26 = uint((_e507 + 11u));
        uint _e513[2] = local_25;
        local_65 = _e513;
        uint _e514 = local_26;
        uint _e516 = local_65[1];
        local_65[1] = (_e516 + _e514);
        uint _e520 = local_65[0];
        local_66 = uint(_e520);
        uint _e524 = local_65[1];
        local_67 = uint(_e524);
        uint _e527 = local_67;
        _group_0_binding_0_cs[_e527] = ((_e500 * 10) + _e503);
    }
}

