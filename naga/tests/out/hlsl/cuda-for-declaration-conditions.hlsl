ByteAddressBuffer input_4 : register(t0);
RWByteAddressBuffer output_1 : register(u1);

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void for_conditions(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
    int cursor = (int)0;
    int total = (int)0;
    uint iterations = (uint)0;
    uint observed = (uint)0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    int local_1 = (int)0;
    uint local_2[2] = (uint[2])0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    int inferred_cursor = (int)0;
    int inferred_total = (int)0;
    uint local_9[2] = (uint[2])0;
    int local_10 = (int)0;
    int value_1 = (int)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    int break_cursor = (int)0;
    int first = (int)0;
    uint continued = (uint)0;
    uint local_15[2] = (uint[2])0;
    int local_16 = (int)0;
    int value_2 = (int)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint input_1[2] = (uint[2])0;
    uint offset = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    int local_23 = (int)0;
    int local_24 = (int)0;
    int local_25 = (int)0;
    uint input_2[2] = (uint[2])0;
    uint offset_1 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    int local_28 = (int)0;
    int local_29 = (int)0;
    int local_30 = (int)0;
    uint input_3[2] = (uint[2])0;
    uint offset_2 = (uint)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    int local_33 = (int)0;
    int local_34 = (int)0;
    int local_35 = (int)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    int local_39 = (int)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    int local_55 = (int)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    int local_65 = (int)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;

    input = ZeroValuearray2_uint_();
    input[0] = 2u;
    input[1] = 0u;
    output = ZeroValuearray2_uint_();
    output[0] = 3u;
    output[1] = 0u;
    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint offset_3 = (lane * 4u);
    uint base = (4u + (lane * 8u));
    cursor = int(0);
    total = int(0);
    iterations = 0u;
    observed = 0u;
    {
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e102 = value;
                uint _e104 = observed;
                observed = (_e104 + uint(_e102));
                uint _e106 = iterations;
                iterations = (_e106 + uint(int(1)));
            }
            loop_init = false;
            uint _e36[2] = input;
            local = _e36;
            offset = ZeroValueuint();
            local_22 = ZeroValueuint();
            local_23 = ZeroValueint();
            uint _e44[2] = local;
            input_1 = _e44;
            offset = offset_3;
            uint _e48[2] = input_1;
            local_21 = _e48;
            int _e50 = cursor;
            local_24 = _e50;
            int _e52 = local_24;
            cursor = asint(asuint(_e52) + asuint(int(1)));
            uint _e56 = offset;
            local_22 = uint((_e56 + uint(_e52)));
            uint _e60[2] = local_21;
            local_36 = _e60;
            uint _e62 = local_22;
            uint _e64 = local_36[1];
            local_36[1] = (_e64 + _e62);
            uint _e68 = local_36[0];
            local_37 = uint(_e68);
            uint _e72 = local_36[1];
            local_38 = uint(_e72);
            uint _e75 = local_38;
            int _e78 = asint(input_4.Load(_e75*4));
            local_39 = _e78;
            int _e80 = local_39;
            local_25 = _e80;
            int _e82 = local_25;
            local_23 = _e82;
            int _e84 = local_23;
            local_1 = _e84;
            int _e86 = local_1;
            value = _e86;
            int _e88 = value;
            if ((_e88 != int(0))) {
            } else {
                break;
            }
            int _e91 = value;
            int _e92 = total;
            total = asint(asuint(_e92) + asuint(_e91));
            uint _e94 = iterations;
            value = asint(asuint(int(10)) + asuint(int(_e94)));
            uint _e98 = iterations;
            if ((_e98 == 0u)) {
                continue;
            }
        }
    }
    int _e110 = total;
    uint _e113[2] = output;
    local_2 = _e113;
    uint _e115[2] = local_2;
    local_40 = _e115;
    uint _e118 = local_40[1];
    local_40[1] = (_e118 + base);
    uint _e122 = local_40[0];
    local_41 = uint(_e122);
    uint _e126 = local_40[1];
    local_42 = uint(_e126);
    uint _e129 = local_42;
    output_1.Store(_e129*4, asuint(uint(_e110)));
    int _e132 = cursor;
    uint _e134[2] = output;
    local_3 = _e134;
    local_4 = uint((base + 1u));
    uint _e140[2] = local_3;
    local_43 = _e140;
    uint _e142 = local_4;
    uint _e144 = local_43[1];
    local_43[1] = (_e144 + _e142);
    uint _e148 = local_43[0];
    local_44 = uint(_e148);
    uint _e152 = local_43[1];
    local_45 = uint(_e152);
    uint _e155 = local_45;
    output_1.Store(_e155*4, asuint(uint(_e132)));
    uint _e157 = iterations;
    uint _e158[2] = output;
    local_5 = _e158;
    local_6 = uint((base + 2u));
    uint _e164[2] = local_5;
    local_46 = _e164;
    uint _e166 = local_6;
    uint _e168 = local_46[1];
    local_46[1] = (_e168 + _e166);
    uint _e172 = local_46[0];
    local_47 = uint(_e172);
    uint _e176 = local_46[1];
    local_48 = uint(_e176);
    uint _e179 = local_48;
    output_1.Store(_e179*4, asuint(_e157));
    uint _e181 = observed;
    uint _e182[2] = output;
    local_7 = _e182;
    local_8 = uint((base + 3u));
    uint _e188[2] = local_7;
    local_49 = _e188;
    uint _e190 = local_8;
    uint _e192 = local_49[1];
    local_49[1] = (_e192 + _e190);
    uint _e196 = local_49[0];
    local_50 = uint(_e196);
    uint _e200 = local_49[1];
    local_51 = uint(_e200);
    uint _e203 = local_51;
    output_1.Store(_e203*4, asuint(_e181));
    inferred_cursor = int(0);
    inferred_total = int(0);
    {
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                value_1 = int(0);
            }
            loop_init_1 = false;
            uint _e210[2] = input;
            local_9 = _e210;
            offset_1 = ZeroValueuint();
            local_27 = ZeroValueuint();
            local_28 = ZeroValueint();
            uint _e218[2] = local_9;
            input_2 = _e218;
            offset_1 = offset_3;
            uint _e222[2] = input_2;
            local_26 = _e222;
            int _e224 = inferred_cursor;
            local_29 = _e224;
            int _e226 = local_29;
            inferred_cursor = asint(asuint(_e226) + asuint(int(1)));
            uint _e230 = offset_1;
            local_27 = uint((_e230 + uint(_e226)));
            uint _e234[2] = local_26;
            local_52 = _e234;
            uint _e236 = local_27;
            uint _e238 = local_52[1];
            local_52[1] = (_e238 + _e236);
            uint _e242 = local_52[0];
            local_53 = uint(_e242);
            uint _e246 = local_52[1];
            local_54 = uint(_e246);
            uint _e249 = local_54;
            int _e252 = asint(input_4.Load(_e249*4));
            local_55 = _e252;
            int _e254 = local_55;
            local_30 = _e254;
            int _e256 = local_30;
            local_28 = _e256;
            int _e258 = local_28;
            local_10 = _e258;
            int _e260 = local_10;
            value_1 = _e260;
            int _e262 = value_1;
            if ((_e262 != int(0))) {
            } else {
                break;
            }
            int _e265 = value_1;
            int _e266 = inferred_total;
            inferred_total = asint(asuint(_e266) + asuint(_e265));
            value_1 = int(99);
        }
    }
    int _e271 = inferred_total;
    uint _e273[2] = output;
    local_11 = _e273;
    local_12 = uint((base + 4u));
    uint _e279[2] = local_11;
    local_56 = _e279;
    uint _e281 = local_12;
    uint _e283 = local_56[1];
    local_56[1] = (_e283 + _e281);
    uint _e287 = local_56[0];
    local_57 = uint(_e287);
    uint _e291 = local_56[1];
    local_58 = uint(_e291);
    uint _e294 = local_58;
    output_1.Store(_e294*4, asuint(uint(_e271)));
    int _e296 = inferred_cursor;
    uint _e298[2] = output;
    local_13 = _e298;
    local_14 = uint((base + 5u));
    uint _e304[2] = local_13;
    local_59 = _e304;
    uint _e306 = local_14;
    uint _e308 = local_59[1];
    local_59[1] = (_e308 + _e306);
    uint _e312 = local_59[0];
    local_60 = uint(_e312);
    uint _e316 = local_59[1];
    local_61 = uint(_e316);
    uint _e319 = local_61;
    output_1.Store(_e319*4, asuint(uint(_e296)));
    break_cursor = int(0);
    first = int(0);
    continued = 0u;
    {
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e384 = continued;
                continued = (_e384 + uint(int(1)));
            }
            loop_init_2 = false;
            uint _e328[2] = input;
            local_15 = _e328;
            offset_2 = ZeroValueuint();
            local_32 = ZeroValueuint();
            local_33 = ZeroValueint();
            uint _e336[2] = local_15;
            input_3 = _e336;
            offset_2 = offset_3;
            uint _e340[2] = input_3;
            local_31 = _e340;
            int _e342 = break_cursor;
            local_34 = _e342;
            int _e344 = local_34;
            break_cursor = asint(asuint(_e344) + asuint(int(1)));
            uint _e348 = offset_2;
            local_32 = uint((_e348 + uint(_e344)));
            uint _e352[2] = local_31;
            local_62 = _e352;
            uint _e354 = local_32;
            uint _e356 = local_62[1];
            local_62[1] = (_e356 + _e354);
            uint _e360 = local_62[0];
            local_63 = uint(_e360);
            uint _e364 = local_62[1];
            local_64 = uint(_e364);
            uint _e367 = local_64;
            int _e370 = asint(input_4.Load(_e367*4));
            local_65 = _e370;
            int _e372 = local_65;
            local_35 = _e372;
            int _e374 = local_35;
            local_33 = _e374;
            int _e376 = local_33;
            local_16 = _e376;
            int _e378 = local_16;
            value_2 = _e378;
            int _e380 = value_2;
            if ((_e380 != int(0))) {
            } else {
                break;
            }
            int _e383 = value_2;
            first = _e383;
            break;
        }
    }
    int _e388 = break_cursor;
    uint _e390[2] = output;
    local_17 = _e390;
    local_18 = uint((base + 6u));
    uint _e396[2] = local_17;
    local_66 = _e396;
    uint _e398 = local_18;
    uint _e400 = local_66[1];
    local_66[1] = (_e400 + _e398);
    uint _e404 = local_66[0];
    local_67 = uint(_e404);
    uint _e408 = local_66[1];
    local_68 = uint(_e408);
    uint _e411 = local_68;
    output_1.Store(_e411*4, asuint(uint(_e388)));
    int _e413 = first;
    uint _e415 = continued;
    uint _e419[2] = output;
    local_19 = _e419;
    local_20 = uint((base + 7u));
    uint _e425[2] = local_19;
    local_69 = _e425;
    uint _e427 = local_20;
    uint _e429 = local_69[1];
    local_69[1] = (_e429 + _e427);
    uint _e433 = local_69[0];
    local_70 = uint(_e433);
    uint _e437 = local_69[1];
    local_71 = uint(_e437);
    uint _e440 = local_71;
    output_1.Store(_e440*4, asuint((uint(_e413) + (100u * _e415))));
}
