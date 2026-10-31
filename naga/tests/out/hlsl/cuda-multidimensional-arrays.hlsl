struct int3_ {
    int x;
    int y;
    int z;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer out_ : register(u0);
groupshared int shared_values[2][3];
groupshared float3_ shared_points[2][2];

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

int2 ZeroValueint2() {
    return (int2)0;
}

int ZeroValueint() {
    return (int)0;
}

int3_ ZeroValueint3_() {
    return (int3_)0;
}

int4 ZeroValueint4() {
    return (int4)0;
}

uint2 ZeroValueuint2() {
    return (uint2)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

uint3_ ZeroValueuint3_() {
    return (uint3_)0;
}

uint4 ZeroValueuint4() {
    return (uint4)0;
}

float2 ZeroValuefloat2() {
    return (float2)0;
}

float ZeroValuefloat() {
    return (float)0;
}

float3_ ZeroValuefloat3_() {
    return (float3_)0;
}

float4 ZeroValuefloat4() {
    return (float4)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void multidimensional_arrays(uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_values = (int[2][3])0;
        shared_points = (float3_[2][2])0;
    }
    GroupMemoryBarrierWithGroupSync();
    int2 original = (int2)0;
    int2 points[2][2] = (int2[2][2])0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int3_ original_1 = (int3_)0;
    int3_ points_1[2][2] = (int3_[2][2])0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int4 original_2 = (int4)0;
    int4 points_2[2][2] = (int4[2][2])0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint2 original_3 = (uint2)0;
    uint2 points_3[2][2] = (uint2[2][2])0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint3_ original_4 = (uint3_)0;
    uint3_ points_4[2][2] = (uint3_[2][2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint4 original_5 = (uint4)0;
    uint4 points_5[2][2] = (uint4[2][2])0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    float2 original_6 = (float2)0;
    float2 points_6[2][2] = (float2[2][2])0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    float3_ original_7 = (float3_)0;
    float3_ points_7[2][2] = (float3_[2][2])0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    float4 original_8 = (float4)0;
    float4 points_8[2][2] = (float4[2][2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    int changed[2][2] = (int[2][2])0;
    uint local_27 = (uint)0;
    int nested_empty[2][3] = (int[2][3])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    int partial[2][3] = (int[2][3])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    int volume[2][2][3] = (int[2][2][3])0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
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

    {
        original.x = int(1);
        original.y = int(2);
        int2 _e8 = original;
        points[0][0] = _e8;
        points[0][1] = ZeroValueint2();
        int2 _e13 = original;
        points[1][0] = _e13;
        points[1][1].x = int(5);
        points[1][1].y = ZeroValueint();
        int _e24 = points[int(0)][int(0)].y;
        local = uint(int(0));
        uint _e29 = local;
        local_42 = uint(_e29);
        uint _e32 = local_42;
        out_.Store(_e32*4, asuint(_e24));
        int _e39 = points[int(1)][int(1)].x;
        local_1 = uint(int(1));
        uint _e43 = local_1;
        local_43 = uint(_e43);
        uint _e46 = local_43;
        out_.Store(_e46*4, asuint(_e39));
        int _e53 = points[int(1)][int(1)].y;
        local_2 = uint(int(2));
        uint _e57 = local_2;
        local_44 = uint(_e57);
        uint _e60 = local_44;
        out_.Store(_e60*4, asuint(_e53));
    }
    {
        original_1.x = int(1);
        original_1.y = int(2);
        original_1.z = int(3);
        int3_ _e72 = original_1;
        points_1[0][0] = _e72;
        points_1[0][1] = ZeroValueint3_();
        int3_ _e77 = original_1;
        points_1[1][0] = _e77;
        points_1[1][1].x = int(5);
        points_1[1][1].y = ZeroValueint();
        points_1[1][1].z = ZeroValueint();
        int _e90 = points_1[int(0)][int(0)].z;
        local_3 = uint(int(3));
        uint _e94 = local_3;
        local_45 = uint(_e94);
        uint _e97 = local_45;
        out_.Store(_e97*4, asuint(_e90));
        int _e104 = points_1[int(1)][int(1)].x;
        local_4 = uint(int(4));
        uint _e108 = local_4;
        local_46 = uint(_e108);
        uint _e111 = local_46;
        out_.Store(_e111*4, asuint(_e104));
        int _e118 = points_1[int(1)][int(1)].z;
        local_5 = uint(int(5));
        uint _e122 = local_5;
        local_47 = uint(_e122);
        uint _e125 = local_47;
        out_.Store(_e125*4, asuint(_e118));
    }
    {
        original_2.x = int(1);
        original_2.y = int(2);
        original_2.z = int(3);
        original_2.w = int(4);
        int4 _e139 = original_2;
        points_2[0][0] = _e139;
        points_2[0][1] = ZeroValueint4();
        int4 _e144 = original_2;
        points_2[1][0] = _e144;
        points_2[1][1].x = int(5);
        points_2[1][1].y = ZeroValueint();
        points_2[1][1].z = ZeroValueint();
        points_2[1][1].w = ZeroValueint();
        int _e159 = points_2[int(0)][int(0)].w;
        local_6 = uint(int(6));
        uint _e163 = local_6;
        local_48 = uint(_e163);
        uint _e166 = local_48;
        out_.Store(_e166*4, asuint(_e159));
        int _e173 = points_2[int(1)][int(1)].x;
        local_7 = uint(int(7));
        uint _e177 = local_7;
        local_49 = uint(_e177);
        uint _e180 = local_49;
        out_.Store(_e180*4, asuint(_e173));
        int _e187 = points_2[int(1)][int(1)].w;
        local_8 = uint(int(8));
        uint _e191 = local_8;
        local_50 = uint(_e191);
        uint _e194 = local_50;
        out_.Store(_e194*4, asuint(_e187));
    }
    {
        original_3.x = uint(int(1));
        original_3.y = uint(int(2));
        uint2 _e206 = original_3;
        points_3[0][0] = _e206;
        points_3[0][1] = ZeroValueuint2();
        uint2 _e211 = original_3;
        points_3[1][0] = _e211;
        points_3[1][1].x = uint(int(5));
        points_3[1][1].y = ZeroValueuint();
        uint _e223 = points_3[int(0)][int(0)].y;
        local_9 = uint(int(9));
        uint _e228 = local_9;
        local_51 = uint(_e228);
        uint _e231 = local_51;
        out_.Store(_e231*4, asuint(int(_e223)));
        uint _e238 = points_3[int(1)][int(1)].x;
        local_10 = uint(int(10));
        uint _e243 = local_10;
        local_52 = uint(_e243);
        uint _e246 = local_52;
        out_.Store(_e246*4, asuint(int(_e238)));
        uint _e253 = points_3[int(1)][int(1)].y;
        local_11 = uint(int(11));
        uint _e258 = local_11;
        local_53 = uint(_e258);
        uint _e261 = local_53;
        out_.Store(_e261*4, asuint(int(_e253)));
    }
    {
        original_4.x = uint(int(1));
        original_4.y = uint(int(2));
        original_4.z = uint(int(3));
        uint3_ _e276 = original_4;
        points_4[0][0] = _e276;
        points_4[0][1] = ZeroValueuint3_();
        uint3_ _e281 = original_4;
        points_4[1][0] = _e281;
        points_4[1][1].x = uint(int(5));
        points_4[1][1].y = ZeroValueuint();
        points_4[1][1].z = ZeroValueuint();
        uint _e295 = points_4[int(0)][int(0)].z;
        local_12 = uint(int(12));
        uint _e300 = local_12;
        local_54 = uint(_e300);
        uint _e303 = local_54;
        out_.Store(_e303*4, asuint(int(_e295)));
        uint _e310 = points_4[int(1)][int(1)].x;
        local_13 = uint(int(13));
        uint _e315 = local_13;
        local_55 = uint(_e315);
        uint _e318 = local_55;
        out_.Store(_e318*4, asuint(int(_e310)));
        uint _e325 = points_4[int(1)][int(1)].z;
        local_14 = uint(int(14));
        uint _e330 = local_14;
        local_56 = uint(_e330);
        uint _e333 = local_56;
        out_.Store(_e333*4, asuint(int(_e325)));
    }
    {
        original_5.x = uint(int(1));
        original_5.y = uint(int(2));
        original_5.z = uint(int(3));
        original_5.w = uint(int(4));
        uint4 _e351 = original_5;
        points_5[0][0] = _e351;
        points_5[0][1] = ZeroValueuint4();
        uint4 _e356 = original_5;
        points_5[1][0] = _e356;
        points_5[1][1].x = uint(int(5));
        points_5[1][1].y = ZeroValueuint();
        points_5[1][1].z = ZeroValueuint();
        points_5[1][1].w = ZeroValueuint();
        uint _e372 = points_5[int(0)][int(0)].w;
        local_15 = uint(int(15));
        uint _e377 = local_15;
        local_57 = uint(_e377);
        uint _e380 = local_57;
        out_.Store(_e380*4, asuint(int(_e372)));
        uint _e387 = points_5[int(1)][int(1)].x;
        local_16 = uint(int(16));
        uint _e392 = local_16;
        local_58 = uint(_e392);
        uint _e395 = local_58;
        out_.Store(_e395*4, asuint(int(_e387)));
        uint _e402 = points_5[int(1)][int(1)].w;
        local_17 = uint(int(17));
        uint _e407 = local_17;
        local_59 = uint(_e407);
        uint _e410 = local_59;
        out_.Store(_e410*4, asuint(int(_e402)));
    }
    {
        original_6.x = float(int(1));
        original_6.y = float(int(2));
        float2 _e422 = original_6;
        points_6[0][0] = _e422;
        points_6[0][1] = ZeroValuefloat2();
        float2 _e427 = original_6;
        points_6[1][0] = _e427;
        points_6[1][1].x = float(int(5));
        points_6[1][1].y = ZeroValuefloat();
        float _e439 = points_6[int(0)][int(0)].y;
        local_18 = uint(int(18));
        uint _e444 = local_18;
        local_60 = uint(_e444);
        uint _e447 = local_60;
        out_.Store(_e447*4, asuint(naga_f2i32(_e439)));
        float _e454 = points_6[int(1)][int(1)].x;
        local_19 = uint(int(19));
        uint _e459 = local_19;
        local_61 = uint(_e459);
        uint _e462 = local_61;
        out_.Store(_e462*4, asuint(naga_f2i32(_e454)));
        float _e469 = points_6[int(1)][int(1)].y;
        local_20 = uint(int(20));
        uint _e474 = local_20;
        local_62 = uint(_e474);
        uint _e477 = local_62;
        out_.Store(_e477*4, asuint(naga_f2i32(_e469)));
    }
    {
        original_7.x = float(int(1));
        original_7.y = float(int(2));
        original_7.z = float(int(3));
        float3_ _e492 = original_7;
        points_7[0][0] = _e492;
        points_7[0][1] = ZeroValuefloat3_();
        float3_ _e497 = original_7;
        points_7[1][0] = _e497;
        points_7[1][1].x = float(int(5));
        points_7[1][1].y = ZeroValuefloat();
        points_7[1][1].z = ZeroValuefloat();
        float _e511 = points_7[int(0)][int(0)].z;
        local_21 = uint(int(21));
        uint _e516 = local_21;
        local_63 = uint(_e516);
        uint _e519 = local_63;
        out_.Store(_e519*4, asuint(naga_f2i32(_e511)));
        float _e526 = points_7[int(1)][int(1)].x;
        local_22 = uint(int(22));
        uint _e531 = local_22;
        local_64 = uint(_e531);
        uint _e534 = local_64;
        out_.Store(_e534*4, asuint(naga_f2i32(_e526)));
        float _e541 = points_7[int(1)][int(1)].z;
        local_23 = uint(int(23));
        uint _e546 = local_23;
        local_65 = uint(_e546);
        uint _e549 = local_65;
        out_.Store(_e549*4, asuint(naga_f2i32(_e541)));
    }
    {
        original_8.x = float(int(1));
        original_8.y = float(int(2));
        original_8.z = float(int(3));
        original_8.w = float(int(4));
        float4 _e567 = original_8;
        points_8[0][0] = _e567;
        points_8[0][1] = ZeroValuefloat4();
        float4 _e572 = original_8;
        points_8[1][0] = _e572;
        points_8[1][1].x = float(int(5));
        points_8[1][1].y = ZeroValuefloat();
        points_8[1][1].z = ZeroValuefloat();
        points_8[1][1].w = ZeroValuefloat();
        float _e588 = points_8[int(0)][int(0)].w;
        local_24 = uint(int(24));
        uint _e593 = local_24;
        local_66 = uint(_e593);
        uint _e596 = local_66;
        out_.Store(_e596*4, asuint(naga_f2i32(_e588)));
        float _e603 = points_8[int(1)][int(1)].x;
        local_25 = uint(int(25));
        uint _e608 = local_25;
        local_67 = uint(_e608);
        uint _e611 = local_67;
        out_.Store(_e611*4, asuint(naga_f2i32(_e603)));
        float _e618 = points_8[int(1)][int(1)].w;
        local_26 = uint(int(26));
        uint _e623 = local_26;
        local_68 = uint(_e623);
        uint _e626 = local_68;
        out_.Store(_e626*4, asuint(naga_f2i32(_e618)));
    }
    changed[0][0] = int(1);
    local_27 = 1u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e639 = local_27;
            local_27 = (_e639 + 1u);
        }
        loop_init = false;
        uint _e634 = local_27;
        if ((_e634 >= 2u)) {
            break;
        }
        changed[0][min(uint(_e634), 1u)] = ZeroValueint();
    }
    changed[int(0)][int(1)] = int(9);
    changed[1][0] = int(2);
    changed[1][1] = int(3);
    local_28 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e669 = local_28;
            local_28 = (_e669 + 1u);
        }
        loop_init_1 = false;
        uint _e654 = local_28;
        if ((_e654 >= 2u)) {
            break;
        }
        local_29 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e666 = local_29;
                local_29 = (_e666 + 1u);
            }
            loop_init_2 = false;
            uint _e661 = local_29;
            if ((_e661 >= 3u)) {
                break;
            }
            nested_empty[min(uint(_e654), 1u)][min(uint(_e661), 2u)] = ZeroValueint();
        }
    }
    partial[0][0] = int(1);
    local_30 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e683 = local_30;
            local_30 = (_e683 + 1u);
        }
        loop_init_3 = false;
        uint _e678 = local_30;
        if ((_e678 >= 3u)) {
            break;
        }
        partial[0][min(uint(_e678), 2u)] = ZeroValueint();
    }
    local_31 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e702 = local_31;
            local_31 = (_e702 + 1u);
        }
        loop_init_4 = false;
        uint _e688 = local_31;
        if ((_e688 >= 2u)) {
            break;
        }
        local_32 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e699 = local_32;
                local_32 = (_e699 + 1u);
            }
            loop_init_5 = false;
            uint _e694 = local_32;
            if ((_e694 >= 3u)) {
                break;
            }
            partial[min(uint(_e688), 1u)][min(uint(_e694), 2u)] = ZeroValueint();
        }
    }
    volume[0][0][0] = int(1);
    local_33 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e717 = local_33;
            local_33 = (_e717 + 1u);
        }
        loop_init_6 = false;
        uint _e712 = local_33;
        if ((_e712 >= 3u)) {
            break;
        }
        volume[0][0][min(uint(_e712), 2u)] = ZeroValueint();
    }
    local_34 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e736 = local_34;
            local_34 = (_e736 + 1u);
        }
        loop_init_7 = false;
        uint _e722 = local_34;
        if ((_e722 >= 2u)) {
            break;
        }
        local_35 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e733 = local_35;
                local_35 = (_e733 + 1u);
            }
            loop_init_8 = false;
            uint _e728 = local_35;
            if ((_e728 >= 3u)) {
                break;
            }
            volume[0][min(uint(_e722), 1u)][min(uint(_e728), 2u)] = ZeroValueint();
        }
    }
    local_36 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e764 = local_36;
            local_36 = (_e764 + 1u);
        }
        loop_init_9 = false;
        uint _e741 = local_36;
        if ((_e741 >= 2u)) {
            break;
        }
        local_37 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e761 = local_37;
                local_37 = (_e761 + 1u);
            }
            loop_init_10 = false;
            uint _e747 = local_37;
            if ((_e747 >= 2u)) {
                break;
            }
            local_38 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e758 = local_38;
                    local_38 = (_e758 + 1u);
                }
                loop_init_11 = false;
                uint _e753 = local_38;
                if ((_e753 >= 3u)) {
                    break;
                }
                volume[min(uint(_e741), 1u)][min(uint(_e747), 1u)][min(uint(_e753), 2u)] = ZeroValueint();
            }
        }
    }
    int _e771 = changed[int(0)][int(1)];
    shared_values[int(1)][int(2)] = _e771;
    int _e781 = changed[int(1)][int(0)];
    int _e786 = changed[int(1)][int(1)];
    shared_points[int(1)][int(0)] = Constructfloat3_(float(_e781), float(_e786), float(int(4)));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    int _e806 = shared_values[int(1)][int(2)];
    int _e807 = nested_empty[int(1)][int(2)];
    int _e813 = partial[int(1)][int(2)];
    int _e821 = volume[int(1)][int(1)][int(2)];
    local_39 = uint(int(27));
    uint _e826 = local_39;
    local_69 = uint(_e826);
    uint _e829 = local_69;
    out_.Store(_e829*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e806) + asuint(_e807))) + asuint(_e813))) + asuint(_e821))));
    float _e836 = shared_points[int(1)][int(0)].x;
    local_40 = uint(int(28));
    uint _e841 = local_40;
    local_70 = uint(_e841);
    uint _e844 = local_70;
    out_.Store(_e844*4, asuint(naga_f2i32(_e836)));
    float _e851 = shared_points[int(1)][int(0)].y;
    local_41 = uint(int(29));
    uint _e856 = local_41;
    local_71 = uint(_e856);
    uint _e859 = local_71;
    out_.Store(_e859*4, asuint(naga_f2i32(_e851)));
}
