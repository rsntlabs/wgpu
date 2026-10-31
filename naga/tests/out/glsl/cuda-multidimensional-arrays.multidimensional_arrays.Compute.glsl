#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

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
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

shared int shared_values[2][3];

shared float3_ shared_points[2][2];


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_values = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
        shared_points = float3_[2][2](float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)), float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)));
    }
    memoryBarrierShared();
    barrier();
    ivec2 original = ivec2(0);
    ivec2 points[2][2] = ivec2[2][2](ivec2[2](ivec2(0), ivec2(0)), ivec2[2](ivec2(0), ivec2(0)));
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int3_ original_1 = int3_(0, 0, 0);
    int3_ points_1[2][2] = int3_[2][2](int3_[2](int3_(0, 0, 0), int3_(0, 0, 0)), int3_[2](int3_(0, 0, 0), int3_(0, 0, 0)));
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    ivec4 original_2 = ivec4(0);
    ivec4 points_2[2][2] = ivec4[2][2](ivec4[2](ivec4(0), ivec4(0)), ivec4[2](ivec4(0), ivec4(0)));
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uvec2 original_3 = uvec2(0u);
    uvec2 points_3[2][2] = uvec2[2][2](uvec2[2](uvec2(0u), uvec2(0u)), uvec2[2](uvec2(0u), uvec2(0u)));
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint3_ original_4 = uint3_(0u, 0u, 0u);
    uint3_ points_4[2][2] = uint3_[2][2](uint3_[2](uint3_(0u, 0u, 0u), uint3_(0u, 0u, 0u)), uint3_[2](uint3_(0u, 0u, 0u), uint3_(0u, 0u, 0u)));
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uvec4 original_5 = uvec4(0u);
    uvec4 points_5[2][2] = uvec4[2][2](uvec4[2](uvec4(0u), uvec4(0u)), uvec4[2](uvec4(0u), uvec4(0u)));
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    vec2 original_6 = vec2(0.0);
    vec2 points_6[2][2] = vec2[2][2](vec2[2](vec2(0.0), vec2(0.0)), vec2[2](vec2(0.0), vec2(0.0)));
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    float3_ original_7 = float3_(0.0, 0.0, 0.0);
    float3_ points_7[2][2] = float3_[2][2](float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)), float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0)));
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    vec4 original_8 = vec4(0.0);
    vec4 points_8[2][2] = vec4[2][2](vec4[2](vec4(0.0), vec4(0.0)), vec4[2](vec4(0.0), vec4(0.0)));
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    int changed[2][2] = int[2][2](int[2](0, 0), int[2](0, 0));
    uint local_27 = 0u;
    int nested_empty[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local_28 = 0u;
    uint local_29 = 0u;
    int partial[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    int volume[2][2][3] = int[2][2][3](int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)), int[2][3](int[3](0, 0, 0), int[3](0, 0, 0)));
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
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
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68 = 0u;
    {
        original.x = 1;
        original.y = 2;
        ivec2 _e8 = original;
        points[0][0] = _e8;
        points[0][1] = ivec2(0);
        ivec2 _e13 = original;
        points[1][0] = _e13;
        points[1][1].x = 5;
        points[1][1].y = 0;
        int _e24 = points[0][0].y;
        local = uint(0);
        uint _e28 = local;
        local_42 = _e28;
        uint _e30 = local_42;
        _group_0_binding_0_cs[_e30] = _e24;
        int _e38 = points[1][1].x;
        local_1 = uint(1);
        uint _e42 = local_1;
        local_43 = _e42;
        uint _e44 = local_43;
        _group_0_binding_0_cs[_e44] = _e38;
        int _e51 = points[1][1].y;
        local_2 = uint(2);
        uint _e55 = local_2;
        local_44 = _e55;
        uint _e57 = local_44;
        _group_0_binding_0_cs[_e57] = _e51;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e69 = original_1;
        points_1[0][0] = _e69;
        points_1[0][1] = int3_(0, 0, 0);
        int3_ _e74 = original_1;
        points_1[1][0] = _e74;
        points_1[1][1].x = 5;
        points_1[1][1].y = 0;
        points_1[1][1].z = 0;
        int _e87 = points_1[0][0].z;
        local_3 = uint(3);
        uint _e91 = local_3;
        local_45 = _e91;
        uint _e93 = local_45;
        _group_0_binding_0_cs[_e93] = _e87;
        int _e100 = points_1[1][1].x;
        local_4 = uint(4);
        uint _e104 = local_4;
        local_46 = _e104;
        uint _e106 = local_46;
        _group_0_binding_0_cs[_e106] = _e100;
        int _e113 = points_1[1][1].z;
        local_5 = uint(5);
        uint _e117 = local_5;
        local_47 = _e117;
        uint _e119 = local_47;
        _group_0_binding_0_cs[_e119] = _e113;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        ivec4 _e133 = original_2;
        points_2[0][0] = _e133;
        points_2[0][1] = ivec4(0);
        ivec4 _e138 = original_2;
        points_2[1][0] = _e138;
        points_2[1][1].x = 5;
        points_2[1][1].y = 0;
        points_2[1][1].z = 0;
        points_2[1][1].w = 0;
        int _e153 = points_2[0][0].w;
        local_6 = uint(6);
        uint _e157 = local_6;
        local_48 = _e157;
        uint _e159 = local_48;
        _group_0_binding_0_cs[_e159] = _e153;
        int _e166 = points_2[1][1].x;
        local_7 = uint(7);
        uint _e170 = local_7;
        local_49 = _e170;
        uint _e172 = local_49;
        _group_0_binding_0_cs[_e172] = _e166;
        int _e179 = points_2[1][1].w;
        local_8 = uint(8);
        uint _e183 = local_8;
        local_50 = _e183;
        uint _e185 = local_50;
        _group_0_binding_0_cs[_e185] = _e179;
    }
    {
        original_3.x = uint(1);
        original_3.y = uint(2);
        uvec2 _e197 = original_3;
        points_3[0][0] = _e197;
        points_3[0][1] = uvec2(0u);
        uvec2 _e202 = original_3;
        points_3[1][0] = _e202;
        points_3[1][1].x = uint(5);
        points_3[1][1].y = 0u;
        uint _e214 = points_3[0][0].y;
        local_9 = uint(9);
        uint _e219 = local_9;
        local_51 = _e219;
        uint _e221 = local_51;
        _group_0_binding_0_cs[_e221] = int(_e214);
        uint _e228 = points_3[1][1].x;
        local_10 = uint(10);
        uint _e233 = local_10;
        local_52 = _e233;
        uint _e235 = local_52;
        _group_0_binding_0_cs[_e235] = int(_e228);
        uint _e242 = points_3[1][1].y;
        local_11 = uint(11);
        uint _e247 = local_11;
        local_53 = _e247;
        uint _e249 = local_53;
        _group_0_binding_0_cs[_e249] = int(_e242);
    }
    {
        original_4.x = uint(1);
        original_4.y = uint(2);
        original_4.z = uint(3);
        uint3_ _e264 = original_4;
        points_4[0][0] = _e264;
        points_4[0][1] = uint3_(0u, 0u, 0u);
        uint3_ _e269 = original_4;
        points_4[1][0] = _e269;
        points_4[1][1].x = uint(5);
        points_4[1][1].y = 0u;
        points_4[1][1].z = 0u;
        uint _e283 = points_4[0][0].z;
        local_12 = uint(12);
        uint _e288 = local_12;
        local_54 = _e288;
        uint _e290 = local_54;
        _group_0_binding_0_cs[_e290] = int(_e283);
        uint _e297 = points_4[1][1].x;
        local_13 = uint(13);
        uint _e302 = local_13;
        local_55 = _e302;
        uint _e304 = local_55;
        _group_0_binding_0_cs[_e304] = int(_e297);
        uint _e311 = points_4[1][1].z;
        local_14 = uint(14);
        uint _e316 = local_14;
        local_56 = _e316;
        uint _e318 = local_56;
        _group_0_binding_0_cs[_e318] = int(_e311);
    }
    {
        original_5.x = uint(1);
        original_5.y = uint(2);
        original_5.z = uint(3);
        original_5.w = uint(4);
        uvec4 _e336 = original_5;
        points_5[0][0] = _e336;
        points_5[0][1] = uvec4(0u);
        uvec4 _e341 = original_5;
        points_5[1][0] = _e341;
        points_5[1][1].x = uint(5);
        points_5[1][1].y = 0u;
        points_5[1][1].z = 0u;
        points_5[1][1].w = 0u;
        uint _e357 = points_5[0][0].w;
        local_15 = uint(15);
        uint _e362 = local_15;
        local_57 = _e362;
        uint _e364 = local_57;
        _group_0_binding_0_cs[_e364] = int(_e357);
        uint _e371 = points_5[1][1].x;
        local_16 = uint(16);
        uint _e376 = local_16;
        local_58 = _e376;
        uint _e378 = local_58;
        _group_0_binding_0_cs[_e378] = int(_e371);
        uint _e385 = points_5[1][1].w;
        local_17 = uint(17);
        uint _e390 = local_17;
        local_59 = _e390;
        uint _e392 = local_59;
        _group_0_binding_0_cs[_e392] = int(_e385);
    }
    {
        original_6.x = float(1);
        original_6.y = float(2);
        vec2 _e404 = original_6;
        points_6[0][0] = _e404;
        points_6[0][1] = vec2(0.0);
        vec2 _e409 = original_6;
        points_6[1][0] = _e409;
        points_6[1][1].x = float(5);
        points_6[1][1].y = 0.0;
        float _e421 = points_6[0][0].y;
        local_18 = uint(18);
        uint _e426 = local_18;
        local_60 = _e426;
        uint _e428 = local_60;
        _group_0_binding_0_cs[_e428] = int(_e421);
        float _e435 = points_6[1][1].x;
        local_19 = uint(19);
        uint _e440 = local_19;
        local_61 = _e440;
        uint _e442 = local_61;
        _group_0_binding_0_cs[_e442] = int(_e435);
        float _e449 = points_6[1][1].y;
        local_20 = uint(20);
        uint _e454 = local_20;
        local_62 = _e454;
        uint _e456 = local_62;
        _group_0_binding_0_cs[_e456] = int(_e449);
    }
    {
        original_7.x = float(1);
        original_7.y = float(2);
        original_7.z = float(3);
        float3_ _e471 = original_7;
        points_7[0][0] = _e471;
        points_7[0][1] = float3_(0.0, 0.0, 0.0);
        float3_ _e476 = original_7;
        points_7[1][0] = _e476;
        points_7[1][1].x = float(5);
        points_7[1][1].y = 0.0;
        points_7[1][1].z = 0.0;
        float _e490 = points_7[0][0].z;
        local_21 = uint(21);
        uint _e495 = local_21;
        local_63 = _e495;
        uint _e497 = local_63;
        _group_0_binding_0_cs[_e497] = int(_e490);
        float _e504 = points_7[1][1].x;
        local_22 = uint(22);
        uint _e509 = local_22;
        local_64 = _e509;
        uint _e511 = local_64;
        _group_0_binding_0_cs[_e511] = int(_e504);
        float _e518 = points_7[1][1].z;
        local_23 = uint(23);
        uint _e523 = local_23;
        local_65 = _e523;
        uint _e525 = local_65;
        _group_0_binding_0_cs[_e525] = int(_e518);
    }
    {
        original_8.x = float(1);
        original_8.y = float(2);
        original_8.z = float(3);
        original_8.w = float(4);
        vec4 _e543 = original_8;
        points_8[0][0] = _e543;
        points_8[0][1] = vec4(0.0);
        vec4 _e548 = original_8;
        points_8[1][0] = _e548;
        points_8[1][1].x = float(5);
        points_8[1][1].y = 0.0;
        points_8[1][1].z = 0.0;
        points_8[1][1].w = 0.0;
        float _e564 = points_8[0][0].w;
        local_24 = uint(24);
        uint _e569 = local_24;
        local_66 = _e569;
        uint _e571 = local_66;
        _group_0_binding_0_cs[_e571] = int(_e564);
        float _e578 = points_8[1][1].x;
        local_25 = uint(25);
        uint _e583 = local_25;
        local_67 = _e583;
        uint _e585 = local_67;
        _group_0_binding_0_cs[_e585] = int(_e578);
        float _e592 = points_8[1][1].w;
        local_26 = uint(26);
        uint _e597 = local_26;
        local_68 = _e597;
        uint _e599 = local_68;
        _group_0_binding_0_cs[_e599] = int(_e592);
    }
    changed[0][0] = 1;
    local_27 = 1u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e612 = local_27;
            local_27 = (_e612 + 1u);
        }
        loop_init = false;
        uint _e607 = local_27;
        if ((_e607 >= 2u)) {
            break;
        }
        changed[0][_e607] = 0;
    }
    changed[0][1] = 9;
    changed[1][0] = 2;
    changed[1][1] = 3;
    local_28 = 0u;
    bool loop_init_1 = true;
    while(true) {
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
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                uint _e639 = local_29;
                local_29 = (_e639 + 1u);
            }
            loop_init_2 = false;
            uint _e634 = local_29;
            if ((_e634 >= 3u)) {
                break;
            }
            nested_empty[_e627][_e634] = 0;
        }
    }
    partial[0][0] = 1;
    local_30 = 1u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e656 = local_30;
            local_30 = (_e656 + 1u);
        }
        loop_init_3 = false;
        uint _e651 = local_30;
        if ((_e651 >= 3u)) {
            break;
        }
        partial[0][_e651] = 0;
    }
    local_31 = 1u;
    bool loop_init_4 = true;
    while(true) {
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
        bool loop_init_5 = true;
        while(true) {
            if (!loop_init_5) {
                uint _e672 = local_32;
                local_32 = (_e672 + 1u);
            }
            loop_init_5 = false;
            uint _e667 = local_32;
            if ((_e667 >= 3u)) {
                break;
            }
            partial[_e661][_e667] = 0;
        }
    }
    volume[0][0][0] = 1;
    local_33 = 1u;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            uint _e690 = local_33;
            local_33 = (_e690 + 1u);
        }
        loop_init_6 = false;
        uint _e685 = local_33;
        if ((_e685 >= 3u)) {
            break;
        }
        volume[0][0][_e685] = 0;
    }
    local_34 = 1u;
    bool loop_init_7 = true;
    while(true) {
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
        bool loop_init_8 = true;
        while(true) {
            if (!loop_init_8) {
                uint _e706 = local_35;
                local_35 = (_e706 + 1u);
            }
            loop_init_8 = false;
            uint _e701 = local_35;
            if ((_e701 >= 3u)) {
                break;
            }
            volume[0][_e695][_e701] = 0;
        }
    }
    local_36 = 1u;
    bool loop_init_9 = true;
    while(true) {
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
        bool loop_init_10 = true;
        while(true) {
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
            bool loop_init_11 = true;
            while(true) {
                if (!loop_init_11) {
                    uint _e731 = local_38;
                    local_38 = (_e731 + 1u);
                }
                loop_init_11 = false;
                uint _e726 = local_38;
                if ((_e726 >= 3u)) {
                    break;
                }
                volume[_e714][_e720][_e726] = 0;
            }
        }
    }
    int _e744 = changed[0][1];
    shared_values[1][2] = _e744;
    int _e754 = changed[1][0];
    int _e759 = changed[1][1];
    shared_points[1][0] = float3_(float(_e754), float(_e759), float(4));
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    int _e779 = shared_values[1][2];
    int _e780 = nested_empty[1][2];
    int _e786 = partial[1][2];
    int _e794 = volume[1][1][2];
    local_39 = uint(27);
    uint _e799 = local_39;
    _group_0_binding_0_cs[_e799] = (((_e779 + _e780) + _e786) + _e794);
    float _e806 = shared_points[1][0].x;
    local_40 = uint(28);
    uint _e811 = local_40;
    _group_0_binding_0_cs[_e811] = int(_e806);
    float _e818 = shared_points[1][0].y;
    local_41 = uint(29);
    uint _e823 = local_41;
    _group_0_binding_0_cs[_e823] = int(_e818);
}

