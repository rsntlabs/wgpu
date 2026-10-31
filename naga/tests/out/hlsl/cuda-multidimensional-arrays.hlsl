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
        uint _e28 = local;
        local_42 = _e28;
        uint _e30 = local_42;
        out_.Store(_e30*4, asuint(_e24));
        int _e38 = points[int(1)][int(1)].x;
        local_1 = uint(int(1));
        uint _e42 = local_1;
        local_43 = _e42;
        uint _e44 = local_43;
        out_.Store(_e44*4, asuint(_e38));
        int _e51 = points[int(1)][int(1)].y;
        local_2 = uint(int(2));
        uint _e55 = local_2;
        local_44 = _e55;
        uint _e57 = local_44;
        out_.Store(_e57*4, asuint(_e51));
    }
    {
        original_1.x = int(1);
        original_1.y = int(2);
        original_1.z = int(3);
        int3_ _e69 = original_1;
        points_1[0][0] = _e69;
        points_1[0][1] = ZeroValueint3_();
        int3_ _e74 = original_1;
        points_1[1][0] = _e74;
        points_1[1][1].x = int(5);
        points_1[1][1].y = ZeroValueint();
        points_1[1][1].z = ZeroValueint();
        int _e87 = points_1[int(0)][int(0)].z;
        local_3 = uint(int(3));
        uint _e91 = local_3;
        local_45 = _e91;
        uint _e93 = local_45;
        out_.Store(_e93*4, asuint(_e87));
        int _e100 = points_1[int(1)][int(1)].x;
        local_4 = uint(int(4));
        uint _e104 = local_4;
        local_46 = _e104;
        uint _e106 = local_46;
        out_.Store(_e106*4, asuint(_e100));
        int _e113 = points_1[int(1)][int(1)].z;
        local_5 = uint(int(5));
        uint _e117 = local_5;
        local_47 = _e117;
        uint _e119 = local_47;
        out_.Store(_e119*4, asuint(_e113));
    }
    {
        original_2.x = int(1);
        original_2.y = int(2);
        original_2.z = int(3);
        original_2.w = int(4);
        int4 _e133 = original_2;
        points_2[0][0] = _e133;
        points_2[0][1] = ZeroValueint4();
        int4 _e138 = original_2;
        points_2[1][0] = _e138;
        points_2[1][1].x = int(5);
        points_2[1][1].y = ZeroValueint();
        points_2[1][1].z = ZeroValueint();
        points_2[1][1].w = ZeroValueint();
        int _e153 = points_2[int(0)][int(0)].w;
        local_6 = uint(int(6));
        uint _e157 = local_6;
        local_48 = _e157;
        uint _e159 = local_48;
        out_.Store(_e159*4, asuint(_e153));
        int _e166 = points_2[int(1)][int(1)].x;
        local_7 = uint(int(7));
        uint _e170 = local_7;
        local_49 = _e170;
        uint _e172 = local_49;
        out_.Store(_e172*4, asuint(_e166));
        int _e179 = points_2[int(1)][int(1)].w;
        local_8 = uint(int(8));
        uint _e183 = local_8;
        local_50 = _e183;
        uint _e185 = local_50;
        out_.Store(_e185*4, asuint(_e179));
    }
    {
        original_3.x = uint(int(1));
        original_3.y = uint(int(2));
        uint2 _e197 = original_3;
        points_3[0][0] = _e197;
        points_3[0][1] = ZeroValueuint2();
        uint2 _e202 = original_3;
        points_3[1][0] = _e202;
        points_3[1][1].x = uint(int(5));
        points_3[1][1].y = ZeroValueuint();
        uint _e214 = points_3[int(0)][int(0)].y;
        local_9 = uint(int(9));
        uint _e219 = local_9;
        local_51 = _e219;
        uint _e221 = local_51;
        out_.Store(_e221*4, asuint(int(_e214)));
        uint _e228 = points_3[int(1)][int(1)].x;
        local_10 = uint(int(10));
        uint _e233 = local_10;
        local_52 = _e233;
        uint _e235 = local_52;
        out_.Store(_e235*4, asuint(int(_e228)));
        uint _e242 = points_3[int(1)][int(1)].y;
        local_11 = uint(int(11));
        uint _e247 = local_11;
        local_53 = _e247;
        uint _e249 = local_53;
        out_.Store(_e249*4, asuint(int(_e242)));
    }
    {
        original_4.x = uint(int(1));
        original_4.y = uint(int(2));
        original_4.z = uint(int(3));
        uint3_ _e264 = original_4;
        points_4[0][0] = _e264;
        points_4[0][1] = ZeroValueuint3_();
        uint3_ _e269 = original_4;
        points_4[1][0] = _e269;
        points_4[1][1].x = uint(int(5));
        points_4[1][1].y = ZeroValueuint();
        points_4[1][1].z = ZeroValueuint();
        uint _e283 = points_4[int(0)][int(0)].z;
        local_12 = uint(int(12));
        uint _e288 = local_12;
        local_54 = _e288;
        uint _e290 = local_54;
        out_.Store(_e290*4, asuint(int(_e283)));
        uint _e297 = points_4[int(1)][int(1)].x;
        local_13 = uint(int(13));
        uint _e302 = local_13;
        local_55 = _e302;
        uint _e304 = local_55;
        out_.Store(_e304*4, asuint(int(_e297)));
        uint _e311 = points_4[int(1)][int(1)].z;
        local_14 = uint(int(14));
        uint _e316 = local_14;
        local_56 = _e316;
        uint _e318 = local_56;
        out_.Store(_e318*4, asuint(int(_e311)));
    }
    {
        original_5.x = uint(int(1));
        original_5.y = uint(int(2));
        original_5.z = uint(int(3));
        original_5.w = uint(int(4));
        uint4 _e336 = original_5;
        points_5[0][0] = _e336;
        points_5[0][1] = ZeroValueuint4();
        uint4 _e341 = original_5;
        points_5[1][0] = _e341;
        points_5[1][1].x = uint(int(5));
        points_5[1][1].y = ZeroValueuint();
        points_5[1][1].z = ZeroValueuint();
        points_5[1][1].w = ZeroValueuint();
        uint _e357 = points_5[int(0)][int(0)].w;
        local_15 = uint(int(15));
        uint _e362 = local_15;
        local_57 = _e362;
        uint _e364 = local_57;
        out_.Store(_e364*4, asuint(int(_e357)));
        uint _e371 = points_5[int(1)][int(1)].x;
        local_16 = uint(int(16));
        uint _e376 = local_16;
        local_58 = _e376;
        uint _e378 = local_58;
        out_.Store(_e378*4, asuint(int(_e371)));
        uint _e385 = points_5[int(1)][int(1)].w;
        local_17 = uint(int(17));
        uint _e390 = local_17;
        local_59 = _e390;
        uint _e392 = local_59;
        out_.Store(_e392*4, asuint(int(_e385)));
    }
    {
        original_6.x = float(int(1));
        original_6.y = float(int(2));
        float2 _e404 = original_6;
        points_6[0][0] = _e404;
        points_6[0][1] = ZeroValuefloat2();
        float2 _e409 = original_6;
        points_6[1][0] = _e409;
        points_6[1][1].x = float(int(5));
        points_6[1][1].y = ZeroValuefloat();
        float _e421 = points_6[int(0)][int(0)].y;
        local_18 = uint(int(18));
        uint _e426 = local_18;
        local_60 = _e426;
        uint _e428 = local_60;
        out_.Store(_e428*4, asuint(naga_f2i32(_e421)));
        float _e435 = points_6[int(1)][int(1)].x;
        local_19 = uint(int(19));
        uint _e440 = local_19;
        local_61 = _e440;
        uint _e442 = local_61;
        out_.Store(_e442*4, asuint(naga_f2i32(_e435)));
        float _e449 = points_6[int(1)][int(1)].y;
        local_20 = uint(int(20));
        uint _e454 = local_20;
        local_62 = _e454;
        uint _e456 = local_62;
        out_.Store(_e456*4, asuint(naga_f2i32(_e449)));
    }
    {
        original_7.x = float(int(1));
        original_7.y = float(int(2));
        original_7.z = float(int(3));
        float3_ _e471 = original_7;
        points_7[0][0] = _e471;
        points_7[0][1] = ZeroValuefloat3_();
        float3_ _e476 = original_7;
        points_7[1][0] = _e476;
        points_7[1][1].x = float(int(5));
        points_7[1][1].y = ZeroValuefloat();
        points_7[1][1].z = ZeroValuefloat();
        float _e490 = points_7[int(0)][int(0)].z;
        local_21 = uint(int(21));
        uint _e495 = local_21;
        local_63 = _e495;
        uint _e497 = local_63;
        out_.Store(_e497*4, asuint(naga_f2i32(_e490)));
        float _e504 = points_7[int(1)][int(1)].x;
        local_22 = uint(int(22));
        uint _e509 = local_22;
        local_64 = _e509;
        uint _e511 = local_64;
        out_.Store(_e511*4, asuint(naga_f2i32(_e504)));
        float _e518 = points_7[int(1)][int(1)].z;
        local_23 = uint(int(23));
        uint _e523 = local_23;
        local_65 = _e523;
        uint _e525 = local_65;
        out_.Store(_e525*4, asuint(naga_f2i32(_e518)));
    }
    {
        original_8.x = float(int(1));
        original_8.y = float(int(2));
        original_8.z = float(int(3));
        original_8.w = float(int(4));
        float4 _e543 = original_8;
        points_8[0][0] = _e543;
        points_8[0][1] = ZeroValuefloat4();
        float4 _e548 = original_8;
        points_8[1][0] = _e548;
        points_8[1][1].x = float(int(5));
        points_8[1][1].y = ZeroValuefloat();
        points_8[1][1].z = ZeroValuefloat();
        points_8[1][1].w = ZeroValuefloat();
        float _e564 = points_8[int(0)][int(0)].w;
        local_24 = uint(int(24));
        uint _e569 = local_24;
        local_66 = _e569;
        uint _e571 = local_66;
        out_.Store(_e571*4, asuint(naga_f2i32(_e564)));
        float _e578 = points_8[int(1)][int(1)].x;
        local_25 = uint(int(25));
        uint _e583 = local_25;
        local_67 = _e583;
        uint _e585 = local_67;
        out_.Store(_e585*4, asuint(naga_f2i32(_e578)));
        float _e592 = points_8[int(1)][int(1)].w;
        local_26 = uint(int(26));
        uint _e597 = local_26;
        local_68 = _e597;
        uint _e599 = local_68;
        out_.Store(_e599*4, asuint(naga_f2i32(_e592)));
    }
    changed[0][0] = int(1);
    local_27 = 1u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e612 = local_27;
            local_27 = (_e612 + 1u);
        }
        loop_init = false;
        uint _e607 = local_27;
        if ((_e607 >= 2u)) {
            break;
        }
        changed[0][min(uint(_e607), 1u)] = ZeroValueint();
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
            uint _e642 = local_28;
            local_28 = (_e642 + 1u);
        }
        loop_init_1 = false;
        uint _e627 = local_28;
        if ((_e627 >= 2u)) {
            break;
        }
        local_29 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e639 = local_29;
                local_29 = (_e639 + 1u);
            }
            loop_init_2 = false;
            uint _e634 = local_29;
            if ((_e634 >= 3u)) {
                break;
            }
            nested_empty[min(uint(_e627), 1u)][min(uint(_e634), 2u)] = ZeroValueint();
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
            uint _e656 = local_30;
            local_30 = (_e656 + 1u);
        }
        loop_init_3 = false;
        uint _e651 = local_30;
        if ((_e651 >= 3u)) {
            break;
        }
        partial[0][min(uint(_e651), 2u)] = ZeroValueint();
    }
    local_31 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e675 = local_31;
            local_31 = (_e675 + 1u);
        }
        loop_init_4 = false;
        uint _e661 = local_31;
        if ((_e661 >= 2u)) {
            break;
        }
        local_32 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e672 = local_32;
                local_32 = (_e672 + 1u);
            }
            loop_init_5 = false;
            uint _e667 = local_32;
            if ((_e667 >= 3u)) {
                break;
            }
            partial[min(uint(_e661), 1u)][min(uint(_e667), 2u)] = ZeroValueint();
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
            uint _e690 = local_33;
            local_33 = (_e690 + 1u);
        }
        loop_init_6 = false;
        uint _e685 = local_33;
        if ((_e685 >= 3u)) {
            break;
        }
        volume[0][0][min(uint(_e685), 2u)] = ZeroValueint();
    }
    local_34 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e709 = local_34;
            local_34 = (_e709 + 1u);
        }
        loop_init_7 = false;
        uint _e695 = local_34;
        if ((_e695 >= 2u)) {
            break;
        }
        local_35 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e706 = local_35;
                local_35 = (_e706 + 1u);
            }
            loop_init_8 = false;
            uint _e701 = local_35;
            if ((_e701 >= 3u)) {
                break;
            }
            volume[0][min(uint(_e695), 1u)][min(uint(_e701), 2u)] = ZeroValueint();
        }
    }
    local_36 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e737 = local_36;
            local_36 = (_e737 + 1u);
        }
        loop_init_9 = false;
        uint _e714 = local_36;
        if ((_e714 >= 2u)) {
            break;
        }
        local_37 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e734 = local_37;
                local_37 = (_e734 + 1u);
            }
            loop_init_10 = false;
            uint _e720 = local_37;
            if ((_e720 >= 2u)) {
                break;
            }
            local_38 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e731 = local_38;
                    local_38 = (_e731 + 1u);
                }
                loop_init_11 = false;
                uint _e726 = local_38;
                if ((_e726 >= 3u)) {
                    break;
                }
                volume[min(uint(_e714), 1u)][min(uint(_e720), 1u)][min(uint(_e726), 2u)] = ZeroValueint();
            }
        }
    }
    int _e744 = changed[int(0)][int(1)];
    shared_values[int(1)][int(2)] = _e744;
    int _e754 = changed[int(1)][int(0)];
    int _e759 = changed[int(1)][int(1)];
    shared_points[int(1)][int(0)] = Constructfloat3_(float(_e754), float(_e759), float(int(4)));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    int _e779 = shared_values[int(1)][int(2)];
    int _e780 = nested_empty[int(1)][int(2)];
    int _e786 = partial[int(1)][int(2)];
    int _e794 = volume[int(1)][int(1)][int(2)];
    local_39 = uint(int(27));
    uint _e799 = local_39;
    out_.Store(_e799*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e779) + asuint(_e780))) + asuint(_e786))) + asuint(_e794))));
    float _e806 = shared_points[int(1)][int(0)].x;
    local_40 = uint(int(28));
    uint _e811 = local_40;
    out_.Store(_e811*4, asuint(naga_f2i32(_e806)));
    float _e818 = shared_points[int(1)][int(0)].y;
    local_41 = uint(int(29));
    uint _e823 = local_41;
    out_.Store(_e823*4, asuint(naga_f2i32(_e818)));
}
