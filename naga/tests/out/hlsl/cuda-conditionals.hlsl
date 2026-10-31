struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input_a : register(t1);
ByteAddressBuffer input_b : register(t2);
cbuffer n : register(b3) { type_3 n; }
groupshared int shared_values[64];

int shifted(int value_1)
{
    return asint(asuint(value_1) + asuint(int(10)));
}

void discard_(int value_2)
{
    int value_3 = (int)0;

    value_3 = value_2;
    int _e3 = value_3;
    value_3 = asint(asuint(_e3) + asuint(int(1)));
    return;
}

int pair(int x, int y)
{
    return asint(asuint(asint(asuint(x) * asuint(int(10)))) + asuint(y));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void conditionals(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_values = (int[64])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint base = (uint)0;
    bool choose_a = (bool)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int local_3 = (int)0;
    int a = (int)0;
    int b = (int)0;
    uint local_4 = (uint)0;
    int local_5 = (int)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int index_a = (int)0;
    int index_b = (int)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    int local_16 = (int)0;
    uint local_17 = (uint)0;
    int c = (int)0;
    uint local_18 = (uint)0;
    int local_19 = (int)0;
    uint local_20 = (uint)0;
    int condition = (int)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint lane = (uint)0;
    int local_value = (int)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    float local_27 = (float)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    bool local_31 = (bool)0;
    uint local_32 = (uint)0;
    int local_33 = (int)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    int shift_value = (int)0;
    uint local_36 = (uint)0;
    int local_37 = (int)0;
    uint local_38 = (uint)0;
    int value = (int)0;
    int other = (int)0;
    uint local_39 = (uint)0;
    int local_40 = (int)0;
    int count = (int)0;
    int left = (int)0;
    int right = (int)0;
    uint local_41 = (uint)0;
    int local_42 = (int)0;
    int local_43 = (int)0;
    uint local_44 = (uint)0;
    int local_45 = (int)0;
    uint local_46 = (uint)0;
    int local_47 = (int)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 25u);
        choose_a = (naga_mod(i, 2u) == 0u);
        bool _e19 = choose_a;
        if (_e19) {
            local_1 = i;
            uint _e21 = local_1;
            local_44 = _e21;
            uint _e23 = local_44;
            int _e26 = asint(input_a.Load(_e23*4));
            local_45 = _e26;
            int _e28 = local_45;
            local_42 = _e28;
            int _e30 = local_42;
            local_3 = _e30;
        } else {
            local_2 = i;
            uint _e33 = local_2;
            local_46 = _e33;
            uint _e35 = local_46;
            int _e38 = asint(input_b.Load(_e35*4));
            local_47 = _e38;
            int _e40 = local_47;
            local_43 = _e40;
            int _e42 = local_43;
            local_3 = _e42;
        }
        int _e45 = local_3;
        uint _e46 = base;
        local = _e46;
        uint _e48 = local;
        local_48 = _e48;
        uint _e50 = local_48;
        out_.Store(_e50*4, asuint(_e45));
        a = int(3);
        b = int(5);
        bool _e57 = choose_a;
        if (_e57) {
            int _e58 = a;
            a = asint(asuint(_e58) + asuint(int(1)));
            const int _e61 = shifted(_e58);
            local_5 = _e61;
        } else {
            int _e63 = b;
            b = asint(asuint(_e63) + asuint(int(1)));
            const int _e66 = shifted(_e63);
            local_5 = _e66;
        }
        int _e69 = local_5;
        uint _e70 = base;
        local_4 = uint((_e70 + 1u));
        uint _e75 = local_4;
        local_49 = _e75;
        uint _e77 = local_49;
        out_.Store(_e77*4, asuint(_e69));
        int _e79 = a;
        int _e82 = b;
        uint _e84 = base;
        local_6 = uint((_e84 + 2u));
        uint _e89 = local_6;
        local_50 = _e89;
        uint _e91 = local_50;
        out_.Store(_e91*4, asuint(asint(asuint(asint(asuint(_e79) * asuint(int(10)))) + asuint(_e82))));
        bool _e93 = choose_a;
        if (_e93) {
            int _e94 = a;
            a = asint(asuint(_e94) + asuint(int(1)));
            discard_(_e94);
        } else {
            int _e97 = b;
            b = asint(asuint(_e97) + asuint(int(1)));
            discard_(_e97);
        }
        int _e100 = a;
        int _e103 = b;
        uint _e105 = base;
        local_7 = uint((_e105 + 3u));
        uint _e110 = local_7;
        local_51 = _e110;
        uint _e112 = local_51;
        out_.Store(_e112*4, asuint(asint(asuint(asint(asuint(_e100) * asuint(int(10)))) + asuint(_e103))));
        index_a = int(0);
        index_b = int(0);
        bool _e118 = choose_a;
        if (_e118) {
            int _e119 = index_a;
            index_a = asint(asuint(_e119) + asuint(int(1)));
            local_8 = uint(_e119);
        } else {
            int _e124 = index_b;
            index_b = asint(asuint(_e124) + asuint(int(1)));
            local_9 = uint(_e124);
        }
        int _e129 = index_a;
        int _e132 = index_b;
        uint _e134 = base;
        local_10 = uint((_e134 + 4u));
        uint _e139 = local_10;
        local_52 = _e139;
        uint _e141 = local_52;
        out_.Store(_e141*4, asuint(asint(asuint(asint(asuint(_e129) * asuint(int(10)))) + asuint(_e132))));
        a = int(3);
        b = int(5);
        bool _e145 = choose_a;
        if (_e145) {
            a = int(7);
        } else {
            b = int(7);
        }
        int _e148 = a;
        int _e151 = b;
        uint _e153 = base;
        local_11 = uint((_e153 + 5u));
        uint _e158 = local_11;
        local_53 = _e158;
        uint _e160 = local_53;
        out_.Store(_e160*4, asuint(asint(asuint(asint(asuint(_e148) * asuint(int(10)))) + asuint(_e151))));
        bool _e162 = choose_a;
        if (_e162) {
            int _e163 = a;
            a = asint(asuint(_e163) + asuint(int(2)));
        } else {
            int _e166 = b;
            b = asint(asuint(_e166) + asuint(int(2)));
        }
        int _e169 = a;
        int _e172 = b;
        uint _e174 = base;
        local_12 = uint((_e174 + 6u));
        uint _e179 = local_12;
        local_54 = _e179;
        uint _e181 = local_54;
        out_.Store(_e181*4, asuint(asint(asuint(asint(asuint(_e169) * asuint(int(10)))) + asuint(_e172))));
        bool _e183 = choose_a;
        if (_e183) {
            int _e184 = a;
            a = asint(asuint(_e184) + asuint(int(1)));
            int _e187 = a;
            local_14 = _e187;
        } else {
            int _e189 = b;
            b = asint(asuint(_e189) + asuint(int(1)));
            int _e192 = b;
            local_14 = _e192;
        }
        int _e195 = local_14;
        uint _e196 = base;
        local_13 = uint((_e196 + 7u));
        uint _e201 = local_13;
        local_55 = _e201;
        uint _e203 = local_55;
        out_.Store(_e203*4, asuint(_e195));
        bool _e205 = choose_a;
        if (_e205) {
            int _e206 = a;
            a = asint(asuint(_e206) + asuint(int(1)));
            local_16 = _e206;
        } else {
            int _e210 = b;
            b = asint(asuint(_e210) + asuint(int(1)));
            local_16 = _e210;
        }
        int _e215 = local_16;
        uint _e216 = base;
        local_15 = uint((_e216 + 8u));
        uint _e221 = local_15;
        local_56 = _e221;
        uint _e223 = local_56;
        out_.Store(_e223*4, asuint(_e215));
        int _e225 = a;
        int _e228 = b;
        uint _e230 = base;
        local_17 = uint((_e230 + 9u));
        uint _e235 = local_17;
        local_57 = _e235;
        uint _e237 = local_57;
        out_.Store(_e237*4, asuint(asint(asuint(asint(asuint(_e225) * asuint(int(100)))) + asuint(_e228))));
        bool _e239 = choose_a;
        c = int(_e239);
        b = int(7);
        int _e243 = c;
        if ((_e243 != int(0))) {
            c = int(0);
            int _e247 = c;
            c = asint(asuint(_e247) + asuint(int(1)));
            local_19 = _e247;
        } else {
            b = int(0);
            int _e252 = b;
            b = asint(asuint(_e252) + asuint(int(1)));
            local_19 = _e252;
        }
        int _e257 = local_19;
        uint _e258 = base;
        local_18 = uint((_e258 + 10u));
        uint _e263 = local_18;
        local_58 = _e263;
        uint _e265 = local_58;
        out_.Store(_e265*4, asuint(_e257));
        int _e267 = c;
        int _e270 = b;
        uint _e272 = base;
        local_20 = uint((_e272 + 11u));
        uint _e277 = local_20;
        local_59 = _e277;
        uint _e279 = local_59;
        out_.Store(_e279*4, asuint(asint(asuint(asint(asuint(_e267) * asuint(int(10)))) + asuint(_e270))));
        condition = int(0);
        a = int(2);
        b = int(4);
        condition = int(1);
        int _e286 = condition;
        int _e287 = condition;
        if ((_e287 != int(0))) {
            a = _e286;
        } else {
            b = _e286;
        }
        int _e290 = a;
        int _e293 = b;
        uint _e295 = base;
        local_21 = uint((_e295 + 12u));
        uint _e300 = local_21;
        local_60 = _e300;
        uint _e302 = local_60;
        out_.Store(_e302*4, asuint(asint(asuint(asint(asuint(_e290) * asuint(int(10)))) + asuint(_e293))));
        a = int(2);
        b = int(4);
        c = int(6);
        bool _e307 = choose_a;
        if (_e307) {
            if ((naga_mod(i, 4u) == 0u)) {
                int _e312 = a;
                a = asint(asuint(_e312) + asuint(int(3)));
            } else {
                int _e315 = b;
                b = asint(asuint(_e315) + asuint(int(3)));
            }
        } else {
            int _e318 = c;
            c = asint(asuint(_e318) + asuint(int(3)));
        }
        int _e321 = a;
        int _e324 = b;
        int _e328 = c;
        uint _e330 = base;
        local_22 = uint((_e330 + 13u));
        uint _e335 = local_22;
        local_61 = _e335;
        uint _e337 = local_61;
        out_.Store(_e337*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e321) * asuint(int(100)))) + asuint(asint(asuint(_e324) * asuint(int(10)))))) + asuint(_e328))));
        lane = threadIdx.x;
        uint _e341 = lane;
        shared_values[min(uint(_e341), 63u)] = int(20);
        local_value = int(10);
        bool _e347 = choose_a;
        if (_e347) {
            int _e348 = local_value;
            local_value = asint(asuint(_e348) + asuint(int(5)));
        } else {
            uint _e351 = lane;
            int _e353 = shared_values[min(uint(_e351), 63u)];
            shared_values[min(uint(_e351), 63u)] = asint(asuint(_e353) + asuint(int(5)));
        }
        int _e356 = local_value;
        uint _e359 = lane;
        int _e361 = shared_values[min(uint(_e359), 63u)];
        uint _e363 = base;
        local_23 = uint((_e363 + 14u));
        uint _e368 = local_23;
        local_62 = _e368;
        uint _e370 = local_62;
        out_.Store(_e370*4, asuint(asint(asuint(asint(asuint(_e356) * asuint(int(100)))) + asuint(_e361))));
        bool _e372 = choose_a;
        if (_e372) {
            uint _e373 = lane;
            shared_values[min(uint(_e373), 63u)] = int(30);
        } else {
            uint _e376 = base;
            local_24 = uint((_e376 + 15u));
            uint _e381 = local_24;
            local_63 = _e381;
            uint _e383 = local_63;
            out_.Store(_e383*4, asuint(int(30)));
        }
        uint _e386 = lane;
        int _e388 = shared_values[min(uint(_e386), 63u)];
        uint _e389 = base;
        local_25 = uint((_e389 + 16u));
        uint _e394 = local_25;
        local_64 = _e394;
        uint _e396 = local_64;
        out_.Store(_e396*4, asuint(_e388));
        bool _e398 = choose_a;
        if (_e398) {
            local_27 = 1.5;
        } else {
            local_27 = float(int(3));
        }
        float _e405 = local_27;
        uint _e406 = base;
        local_26 = uint((_e406 + 17u));
        uint _e412 = local_26;
        local_65 = _e412;
        uint _e414 = local_65;
        out_.Store(_e414*4, asuint(naga_f2i32(_e405)));
        bool _e416 = choose_a;
        if (_e416) {
            local_29 = uint(naga_neg(int(1)));
        } else {
            local_29 = 2u;
        }
        uint _e424 = local_29;
        uint _e425 = base;
        local_28 = uint((_e425 + 18u));
        uint _e431 = local_28;
        local_66 = _e431;
        uint _e433 = local_66;
        out_.Store(_e433*4, asuint(int(_e424)));
        bool _e435 = choose_a;
        if (_e435) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e441 = local_31;
        uint _e442 = base;
        local_30 = uint((_e442 + 19u));
        uint _e448 = local_30;
        local_67 = _e448;
        uint _e450 = local_67;
        out_.Store(_e450*4, asuint(int(_e441)));
        bool _e452 = choose_a;
        if (_e452) {
            local_33 = int(true);
        } else {
            local_33 = int(2);
        }
        int _e459 = local_33;
        uint _e460 = base;
        local_32 = uint((_e460 + 20u));
        uint _e465 = local_32;
        local_68 = _e465;
        uint _e467 = local_68;
        out_.Store(_e467*4, asuint(_e459));
        bool _e469 = choose_a;
        if (_e469) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e475 = local_35;
        uint _e476 = base;
        local_34 = uint((_e476 + 21u));
        uint _e482 = local_34;
        local_69 = _e482;
        uint _e484 = local_69;
        out_.Store(_e484*4, asuint(int(_e475)));
        a = int(3);
        shift_value = int(2);
        bool _e489 = choose_a;
        if (_e489) {
            int _e490 = shift_value;
            local_37 = _e490;
        } else {
            int _e492 = a;
            local_37 = _e492;
        }
        int _e495 = local_37;
        shift_value = int(1);
        int _e497 = shift_value;
        local_38 = uint(_e497);
        uint _e500 = local_38;
        uint _e502 = base;
        local_36 = uint((_e502 + 22u));
        uint _e507 = local_36;
        local_70 = _e507;
        uint _e509 = local_70;
        out_.Store(_e509*4, asuint((_e495 << _e500)));
        value = int(3);
        other = int(7);
        bool _e515 = choose_a;
        if (_e515) {
            int _e516 = value;
            local_40 = _e516;
        } else {
            int _e518 = other;
            local_40 = _e518;
        }
        int _e521 = local_40;
        int _e522 = value;
        value = asint(asuint(_e522) + asuint(int(1)));
        const int _e525 = pair(_e521, _e522);
        uint _e526 = base;
        local_39 = uint((_e526 + 23u));
        uint _e531 = local_39;
        local_71 = _e531;
        uint _e533 = local_71;
        out_.Store(_e533*4, asuint(_e525));
        count = int(0);
        left = int(0);
        right = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    bool _e550 = choose_a;
                    if (_e550) {
                        int _e551 = left;
                        left = asint(asuint(_e551) + asuint(int(1)));
                    } else {
                        int _e554 = right;
                        right = asint(asuint(_e554) + asuint(int(1)));
                    }
                }
                loop_init = false;
                int _e541 = count;
                if ((_e541 < int(3))) {
                } else {
                    break;
                }
                int _e544 = count;
                count = asint(asuint(_e544) + asuint(int(1)));
                int _e547 = count;
                if ((_e547 == int(2))) {
                    continue;
                }
            }
        }
        int _e557 = left;
        int _e560 = right;
        int _e564 = count;
        uint _e566 = base;
        local_41 = uint((_e566 + 24u));
        uint _e571 = local_41;
        local_72 = _e571;
        uint _e573 = local_72;
        out_.Store(_e573*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e557) * asuint(int(100)))) + asuint(asint(asuint(_e560) * asuint(int(10)))))) + asuint(_e564))));
    }
}
