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
            local_1 = uint(i);
            uint _e22 = local_1;
            local_44 = uint(_e22);
            uint _e25 = local_44;
            int _e28 = asint(input_a.Load(_e25*4));
            local_45 = _e28;
            int _e30 = local_45;
            local_42 = _e30;
            int _e32 = local_42;
            local_3 = _e32;
        } else {
            local_2 = uint(i);
            uint _e36 = local_2;
            local_46 = uint(_e36);
            uint _e39 = local_46;
            int _e42 = asint(input_b.Load(_e39*4));
            local_47 = _e42;
            int _e44 = local_47;
            local_43 = _e44;
            int _e46 = local_43;
            local_3 = _e46;
        }
        int _e49 = local_3;
        uint _e50 = base;
        local = uint(_e50);
        uint _e53 = local;
        local_48 = uint(_e53);
        uint _e56 = local_48;
        out_.Store(_e56*4, asuint(_e49));
        a = int(3);
        b = int(5);
        bool _e63 = choose_a;
        if (_e63) {
            int _e64 = a;
            a = asint(asuint(_e64) + asuint(int(1)));
            const int _e67 = shifted(_e64);
            local_5 = _e67;
        } else {
            int _e69 = b;
            b = asint(asuint(_e69) + asuint(int(1)));
            const int _e72 = shifted(_e69);
            local_5 = _e72;
        }
        int _e75 = local_5;
        uint _e76 = base;
        local_4 = uint((_e76 + 1u));
        uint _e81 = local_4;
        local_49 = uint(_e81);
        uint _e84 = local_49;
        out_.Store(_e84*4, asuint(_e75));
        int _e86 = a;
        int _e89 = b;
        uint _e91 = base;
        local_6 = uint((_e91 + 2u));
        uint _e96 = local_6;
        local_50 = uint(_e96);
        uint _e99 = local_50;
        out_.Store(_e99*4, asuint(asint(asuint(asint(asuint(_e86) * asuint(int(10)))) + asuint(_e89))));
        bool _e101 = choose_a;
        if (_e101) {
            int _e102 = a;
            a = asint(asuint(_e102) + asuint(int(1)));
            discard_(_e102);
        } else {
            int _e105 = b;
            b = asint(asuint(_e105) + asuint(int(1)));
            discard_(_e105);
        }
        int _e108 = a;
        int _e111 = b;
        uint _e113 = base;
        local_7 = uint((_e113 + 3u));
        uint _e118 = local_7;
        local_51 = uint(_e118);
        uint _e121 = local_51;
        out_.Store(_e121*4, asuint(asint(asuint(asint(asuint(_e108) * asuint(int(10)))) + asuint(_e111))));
        index_a = int(0);
        index_b = int(0);
        bool _e127 = choose_a;
        if (_e127) {
            int _e128 = index_a;
            index_a = asint(asuint(_e128) + asuint(int(1)));
            local_8 = uint(_e128);
        } else {
            int _e133 = index_b;
            index_b = asint(asuint(_e133) + asuint(int(1)));
            local_9 = uint(_e133);
        }
        int _e138 = index_a;
        int _e141 = index_b;
        uint _e143 = base;
        local_10 = uint((_e143 + 4u));
        uint _e148 = local_10;
        local_52 = uint(_e148);
        uint _e151 = local_52;
        out_.Store(_e151*4, asuint(asint(asuint(asint(asuint(_e138) * asuint(int(10)))) + asuint(_e141))));
        a = int(3);
        b = int(5);
        bool _e155 = choose_a;
        if (_e155) {
            a = int(7);
        } else {
            b = int(7);
        }
        int _e158 = a;
        int _e161 = b;
        uint _e163 = base;
        local_11 = uint((_e163 + 5u));
        uint _e168 = local_11;
        local_53 = uint(_e168);
        uint _e171 = local_53;
        out_.Store(_e171*4, asuint(asint(asuint(asint(asuint(_e158) * asuint(int(10)))) + asuint(_e161))));
        bool _e173 = choose_a;
        if (_e173) {
            int _e174 = a;
            a = asint(asuint(_e174) + asuint(int(2)));
        } else {
            int _e177 = b;
            b = asint(asuint(_e177) + asuint(int(2)));
        }
        int _e180 = a;
        int _e183 = b;
        uint _e185 = base;
        local_12 = uint((_e185 + 6u));
        uint _e190 = local_12;
        local_54 = uint(_e190);
        uint _e193 = local_54;
        out_.Store(_e193*4, asuint(asint(asuint(asint(asuint(_e180) * asuint(int(10)))) + asuint(_e183))));
        bool _e195 = choose_a;
        if (_e195) {
            int _e196 = a;
            a = asint(asuint(_e196) + asuint(int(1)));
            int _e199 = a;
            local_14 = _e199;
        } else {
            int _e201 = b;
            b = asint(asuint(_e201) + asuint(int(1)));
            int _e204 = b;
            local_14 = _e204;
        }
        int _e207 = local_14;
        uint _e208 = base;
        local_13 = uint((_e208 + 7u));
        uint _e213 = local_13;
        local_55 = uint(_e213);
        uint _e216 = local_55;
        out_.Store(_e216*4, asuint(_e207));
        bool _e218 = choose_a;
        if (_e218) {
            int _e219 = a;
            a = asint(asuint(_e219) + asuint(int(1)));
            local_16 = _e219;
        } else {
            int _e223 = b;
            b = asint(asuint(_e223) + asuint(int(1)));
            local_16 = _e223;
        }
        int _e228 = local_16;
        uint _e229 = base;
        local_15 = uint((_e229 + 8u));
        uint _e234 = local_15;
        local_56 = uint(_e234);
        uint _e237 = local_56;
        out_.Store(_e237*4, asuint(_e228));
        int _e239 = a;
        int _e242 = b;
        uint _e244 = base;
        local_17 = uint((_e244 + 9u));
        uint _e249 = local_17;
        local_57 = uint(_e249);
        uint _e252 = local_57;
        out_.Store(_e252*4, asuint(asint(asuint(asint(asuint(_e239) * asuint(int(100)))) + asuint(_e242))));
        bool _e254 = choose_a;
        c = int(_e254);
        b = int(7);
        int _e258 = c;
        if ((_e258 != int(0))) {
            c = int(0);
            int _e262 = c;
            c = asint(asuint(_e262) + asuint(int(1)));
            local_19 = _e262;
        } else {
            b = int(0);
            int _e267 = b;
            b = asint(asuint(_e267) + asuint(int(1)));
            local_19 = _e267;
        }
        int _e272 = local_19;
        uint _e273 = base;
        local_18 = uint((_e273 + 10u));
        uint _e278 = local_18;
        local_58 = uint(_e278);
        uint _e281 = local_58;
        out_.Store(_e281*4, asuint(_e272));
        int _e283 = c;
        int _e286 = b;
        uint _e288 = base;
        local_20 = uint((_e288 + 11u));
        uint _e293 = local_20;
        local_59 = uint(_e293);
        uint _e296 = local_59;
        out_.Store(_e296*4, asuint(asint(asuint(asint(asuint(_e283) * asuint(int(10)))) + asuint(_e286))));
        condition = int(0);
        a = int(2);
        b = int(4);
        condition = int(1);
        int _e303 = condition;
        int _e304 = condition;
        if ((_e304 != int(0))) {
            a = _e303;
        } else {
            b = _e303;
        }
        int _e307 = a;
        int _e310 = b;
        uint _e312 = base;
        local_21 = uint((_e312 + 12u));
        uint _e317 = local_21;
        local_60 = uint(_e317);
        uint _e320 = local_60;
        out_.Store(_e320*4, asuint(asint(asuint(asint(asuint(_e307) * asuint(int(10)))) + asuint(_e310))));
        a = int(2);
        b = int(4);
        c = int(6);
        bool _e325 = choose_a;
        if (_e325) {
            if ((naga_mod(i, 4u) == 0u)) {
                int _e330 = a;
                a = asint(asuint(_e330) + asuint(int(3)));
            } else {
                int _e333 = b;
                b = asint(asuint(_e333) + asuint(int(3)));
            }
        } else {
            int _e336 = c;
            c = asint(asuint(_e336) + asuint(int(3)));
        }
        int _e339 = a;
        int _e342 = b;
        int _e346 = c;
        uint _e348 = base;
        local_22 = uint((_e348 + 13u));
        uint _e353 = local_22;
        local_61 = uint(_e353);
        uint _e356 = local_61;
        out_.Store(_e356*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e339) * asuint(int(100)))) + asuint(asint(asuint(_e342) * asuint(int(10)))))) + asuint(_e346))));
        lane = threadIdx.x;
        uint _e360 = lane;
        shared_values[min(uint(_e360), 63u)] = int(20);
        local_value = int(10);
        bool _e366 = choose_a;
        if (_e366) {
            int _e367 = local_value;
            local_value = asint(asuint(_e367) + asuint(int(5)));
        } else {
            uint _e370 = lane;
            int _e372 = shared_values[min(uint(_e370), 63u)];
            shared_values[min(uint(_e370), 63u)] = asint(asuint(_e372) + asuint(int(5)));
        }
        int _e375 = local_value;
        uint _e378 = lane;
        int _e380 = shared_values[min(uint(_e378), 63u)];
        uint _e382 = base;
        local_23 = uint((_e382 + 14u));
        uint _e387 = local_23;
        local_62 = uint(_e387);
        uint _e390 = local_62;
        out_.Store(_e390*4, asuint(asint(asuint(asint(asuint(_e375) * asuint(int(100)))) + asuint(_e380))));
        bool _e392 = choose_a;
        if (_e392) {
            uint _e393 = lane;
            shared_values[min(uint(_e393), 63u)] = int(30);
        } else {
            uint _e396 = base;
            local_24 = uint((_e396 + 15u));
            uint _e401 = local_24;
            local_63 = uint(_e401);
            uint _e404 = local_63;
            out_.Store(_e404*4, asuint(int(30)));
        }
        uint _e407 = lane;
        int _e409 = shared_values[min(uint(_e407), 63u)];
        uint _e410 = base;
        local_25 = uint((_e410 + 16u));
        uint _e415 = local_25;
        local_64 = uint(_e415);
        uint _e418 = local_64;
        out_.Store(_e418*4, asuint(_e409));
        bool _e420 = choose_a;
        if (_e420) {
            local_27 = 1.5;
        } else {
            local_27 = float(int(3));
        }
        float _e427 = local_27;
        uint _e428 = base;
        local_26 = uint((_e428 + 17u));
        uint _e434 = local_26;
        local_65 = uint(_e434);
        uint _e437 = local_65;
        out_.Store(_e437*4, asuint(naga_f2i32(_e427)));
        bool _e439 = choose_a;
        if (_e439) {
            local_29 = uint(naga_neg(int(1)));
        } else {
            local_29 = 2u;
        }
        uint _e447 = local_29;
        uint _e448 = base;
        local_28 = uint((_e448 + 18u));
        uint _e454 = local_28;
        local_66 = uint(_e454);
        uint _e457 = local_66;
        out_.Store(_e457*4, asuint(int(_e447)));
        bool _e459 = choose_a;
        if (_e459) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e465 = local_31;
        uint _e466 = base;
        local_30 = uint((_e466 + 19u));
        uint _e472 = local_30;
        local_67 = uint(_e472);
        uint _e475 = local_67;
        out_.Store(_e475*4, asuint(int(_e465)));
        bool _e477 = choose_a;
        if (_e477) {
            local_33 = int(true);
        } else {
            local_33 = int(2);
        }
        int _e484 = local_33;
        uint _e485 = base;
        local_32 = uint((_e485 + 20u));
        uint _e490 = local_32;
        local_68 = uint(_e490);
        uint _e493 = local_68;
        out_.Store(_e493*4, asuint(_e484));
        bool _e495 = choose_a;
        if (_e495) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e501 = local_35;
        uint _e502 = base;
        local_34 = uint((_e502 + 21u));
        uint _e508 = local_34;
        local_69 = uint(_e508);
        uint _e511 = local_69;
        out_.Store(_e511*4, asuint(int(_e501)));
        a = int(3);
        shift_value = int(2);
        bool _e516 = choose_a;
        if (_e516) {
            int _e517 = shift_value;
            local_37 = _e517;
        } else {
            int _e519 = a;
            local_37 = _e519;
        }
        int _e522 = local_37;
        shift_value = int(1);
        int _e524 = shift_value;
        local_38 = uint(_e524);
        uint _e527 = local_38;
        uint _e529 = base;
        local_36 = uint((_e529 + 22u));
        uint _e534 = local_36;
        local_70 = uint(_e534);
        uint _e537 = local_70;
        out_.Store(_e537*4, asuint((_e522 << _e527)));
        value = int(3);
        other = int(7);
        bool _e543 = choose_a;
        if (_e543) {
            int _e544 = value;
            local_40 = _e544;
        } else {
            int _e546 = other;
            local_40 = _e546;
        }
        int _e549 = local_40;
        int _e550 = value;
        value = asint(asuint(_e550) + asuint(int(1)));
        const int _e553 = pair(_e549, _e550);
        uint _e554 = base;
        local_39 = uint((_e554 + 23u));
        uint _e559 = local_39;
        local_71 = uint(_e559);
        uint _e562 = local_71;
        out_.Store(_e562*4, asuint(_e553));
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
                    bool _e579 = choose_a;
                    if (_e579) {
                        int _e580 = left;
                        left = asint(asuint(_e580) + asuint(int(1)));
                    } else {
                        int _e583 = right;
                        right = asint(asuint(_e583) + asuint(int(1)));
                    }
                }
                loop_init = false;
                int _e570 = count;
                if ((_e570 < int(3))) {
                } else {
                    break;
                }
                int _e573 = count;
                count = asint(asuint(_e573) + asuint(int(1)));
                int _e576 = count;
                if ((_e576 == int(2))) {
                    continue;
                }
            }
        }
        int _e586 = left;
        int _e589 = right;
        int _e593 = count;
        uint _e595 = base;
        local_41 = uint((_e595 + 24u));
        uint _e600 = local_41;
        local_72 = uint(_e600);
        uint _e603 = local_72;
        out_.Store(_e603*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e586) * asuint(int(100)))) + asuint(asint(asuint(_e589) * asuint(int(10)))))) + asuint(_e593))));
    }
}
