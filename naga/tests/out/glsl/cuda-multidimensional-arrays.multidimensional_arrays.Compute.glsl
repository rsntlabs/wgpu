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
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71 = 0u;
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
        uint _e29 = local;
        local_42 = uint(_e29);
        uint _e32 = local_42;
        _group_0_binding_0_cs[_e32] = _e24;
        int _e39 = points[1][1].x;
        local_1 = uint(1);
        uint _e43 = local_1;
        local_43 = uint(_e43);
        uint _e46 = local_43;
        _group_0_binding_0_cs[_e46] = _e39;
        int _e53 = points[1][1].y;
        local_2 = uint(2);
        uint _e57 = local_2;
        local_44 = uint(_e57);
        uint _e60 = local_44;
        _group_0_binding_0_cs[_e60] = _e53;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e72 = original_1;
        points_1[0][0] = _e72;
        points_1[0][1] = int3_(0, 0, 0);
        int3_ _e77 = original_1;
        points_1[1][0] = _e77;
        points_1[1][1].x = 5;
        points_1[1][1].y = 0;
        points_1[1][1].z = 0;
        int _e90 = points_1[0][0].z;
        local_3 = uint(3);
        uint _e94 = local_3;
        local_45 = uint(_e94);
        uint _e97 = local_45;
        _group_0_binding_0_cs[_e97] = _e90;
        int _e104 = points_1[1][1].x;
        local_4 = uint(4);
        uint _e108 = local_4;
        local_46 = uint(_e108);
        uint _e111 = local_46;
        _group_0_binding_0_cs[_e111] = _e104;
        int _e118 = points_1[1][1].z;
        local_5 = uint(5);
        uint _e122 = local_5;
        local_47 = uint(_e122);
        uint _e125 = local_47;
        _group_0_binding_0_cs[_e125] = _e118;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        ivec4 _e139 = original_2;
        points_2[0][0] = _e139;
        points_2[0][1] = ivec4(0);
        ivec4 _e144 = original_2;
        points_2[1][0] = _e144;
        points_2[1][1].x = 5;
        points_2[1][1].y = 0;
        points_2[1][1].z = 0;
        points_2[1][1].w = 0;
        int _e159 = points_2[0][0].w;
        local_6 = uint(6);
        uint _e163 = local_6;
        local_48 = uint(_e163);
        uint _e166 = local_48;
        _group_0_binding_0_cs[_e166] = _e159;
        int _e173 = points_2[1][1].x;
        local_7 = uint(7);
        uint _e177 = local_7;
        local_49 = uint(_e177);
        uint _e180 = local_49;
        _group_0_binding_0_cs[_e180] = _e173;
        int _e187 = points_2[1][1].w;
        local_8 = uint(8);
        uint _e191 = local_8;
        local_50 = uint(_e191);
        uint _e194 = local_50;
        _group_0_binding_0_cs[_e194] = _e187;
    }
    {
        original_3.x = uint(1);
        original_3.y = uint(2);
        uvec2 _e206 = original_3;
        points_3[0][0] = _e206;
        points_3[0][1] = uvec2(0u);
        uvec2 _e211 = original_3;
        points_3[1][0] = _e211;
        points_3[1][1].x = uint(5);
        points_3[1][1].y = 0u;
        uint _e223 = points_3[0][0].y;
        local_9 = uint(9);
        uint _e228 = local_9;
        local_51 = uint(_e228);
        uint _e231 = local_51;
        _group_0_binding_0_cs[_e231] = int(_e223);
        uint _e238 = points_3[1][1].x;
        local_10 = uint(10);
        uint _e243 = local_10;
        local_52 = uint(_e243);
        uint _e246 = local_52;
        _group_0_binding_0_cs[_e246] = int(_e238);
        uint _e253 = points_3[1][1].y;
        local_11 = uint(11);
        uint _e258 = local_11;
        local_53 = uint(_e258);
        uint _e261 = local_53;
        _group_0_binding_0_cs[_e261] = int(_e253);
    }
    {
        original_4.x = uint(1);
        original_4.y = uint(2);
        original_4.z = uint(3);
        uint3_ _e276 = original_4;
        points_4[0][0] = _e276;
        points_4[0][1] = uint3_(0u, 0u, 0u);
        uint3_ _e281 = original_4;
        points_4[1][0] = _e281;
        points_4[1][1].x = uint(5);
        points_4[1][1].y = 0u;
        points_4[1][1].z = 0u;
        uint _e295 = points_4[0][0].z;
        local_12 = uint(12);
        uint _e300 = local_12;
        local_54 = uint(_e300);
        uint _e303 = local_54;
        _group_0_binding_0_cs[_e303] = int(_e295);
        uint _e310 = points_4[1][1].x;
        local_13 = uint(13);
        uint _e315 = local_13;
        local_55 = uint(_e315);
        uint _e318 = local_55;
        _group_0_binding_0_cs[_e318] = int(_e310);
        uint _e325 = points_4[1][1].z;
        local_14 = uint(14);
        uint _e330 = local_14;
        local_56 = uint(_e330);
        uint _e333 = local_56;
        _group_0_binding_0_cs[_e333] = int(_e325);
    }
    {
        original_5.x = uint(1);
        original_5.y = uint(2);
        original_5.z = uint(3);
        original_5.w = uint(4);
        uvec4 _e351 = original_5;
        points_5[0][0] = _e351;
        points_5[0][1] = uvec4(0u);
        uvec4 _e356 = original_5;
        points_5[1][0] = _e356;
        points_5[1][1].x = uint(5);
        points_5[1][1].y = 0u;
        points_5[1][1].z = 0u;
        points_5[1][1].w = 0u;
        uint _e372 = points_5[0][0].w;
        local_15 = uint(15);
        uint _e377 = local_15;
        local_57 = uint(_e377);
        uint _e380 = local_57;
        _group_0_binding_0_cs[_e380] = int(_e372);
        uint _e387 = points_5[1][1].x;
        local_16 = uint(16);
        uint _e392 = local_16;
        local_58 = uint(_e392);
        uint _e395 = local_58;
        _group_0_binding_0_cs[_e395] = int(_e387);
        uint _e402 = points_5[1][1].w;
        local_17 = uint(17);
        uint _e407 = local_17;
        local_59 = uint(_e407);
        uint _e410 = local_59;
        _group_0_binding_0_cs[_e410] = int(_e402);
    }
    {
        original_6.x = float(1);
        original_6.y = float(2);
        vec2 _e422 = original_6;
        points_6[0][0] = _e422;
        points_6[0][1] = vec2(0.0);
        vec2 _e427 = original_6;
        points_6[1][0] = _e427;
        points_6[1][1].x = float(5);
        points_6[1][1].y = 0.0;
        float _e439 = points_6[0][0].y;
        local_18 = uint(18);
        uint _e444 = local_18;
        local_60 = uint(_e444);
        uint _e447 = local_60;
        _group_0_binding_0_cs[_e447] = int(_e439);
        float _e454 = points_6[1][1].x;
        local_19 = uint(19);
        uint _e459 = local_19;
        local_61 = uint(_e459);
        uint _e462 = local_61;
        _group_0_binding_0_cs[_e462] = int(_e454);
        float _e469 = points_6[1][1].y;
        local_20 = uint(20);
        uint _e474 = local_20;
        local_62 = uint(_e474);
        uint _e477 = local_62;
        _group_0_binding_0_cs[_e477] = int(_e469);
    }
    {
        original_7.x = float(1);
        original_7.y = float(2);
        original_7.z = float(3);
        float3_ _e492 = original_7;
        points_7[0][0] = _e492;
        points_7[0][1] = float3_(0.0, 0.0, 0.0);
        float3_ _e497 = original_7;
        points_7[1][0] = _e497;
        points_7[1][1].x = float(5);
        points_7[1][1].y = 0.0;
        points_7[1][1].z = 0.0;
        float _e511 = points_7[0][0].z;
        local_21 = uint(21);
        uint _e516 = local_21;
        local_63 = uint(_e516);
        uint _e519 = local_63;
        _group_0_binding_0_cs[_e519] = int(_e511);
        float _e526 = points_7[1][1].x;
        local_22 = uint(22);
        uint _e531 = local_22;
        local_64 = uint(_e531);
        uint _e534 = local_64;
        _group_0_binding_0_cs[_e534] = int(_e526);
        float _e541 = points_7[1][1].z;
        local_23 = uint(23);
        uint _e546 = local_23;
        local_65 = uint(_e546);
        uint _e549 = local_65;
        _group_0_binding_0_cs[_e549] = int(_e541);
    }
    {
        original_8.x = float(1);
        original_8.y = float(2);
        original_8.z = float(3);
        original_8.w = float(4);
        vec4 _e567 = original_8;
        points_8[0][0] = _e567;
        points_8[0][1] = vec4(0.0);
        vec4 _e572 = original_8;
        points_8[1][0] = _e572;
        points_8[1][1].x = float(5);
        points_8[1][1].y = 0.0;
        points_8[1][1].z = 0.0;
        points_8[1][1].w = 0.0;
        float _e588 = points_8[0][0].w;
        local_24 = uint(24);
        uint _e593 = local_24;
        local_66 = uint(_e593);
        uint _e596 = local_66;
        _group_0_binding_0_cs[_e596] = int(_e588);
        float _e603 = points_8[1][1].x;
        local_25 = uint(25);
        uint _e608 = local_25;
        local_67 = uint(_e608);
        uint _e611 = local_67;
        _group_0_binding_0_cs[_e611] = int(_e603);
        float _e618 = points_8[1][1].w;
        local_26 = uint(26);
        uint _e623 = local_26;
        local_68 = uint(_e623);
        uint _e626 = local_68;
        _group_0_binding_0_cs[_e626] = int(_e618);
    }
    changed[0][0] = 1;
    local_27 = 1u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e639 = local_27;
            local_27 = (_e639 + 1u);
        }
        loop_init = false;
        uint _e634 = local_27;
        if ((_e634 >= 2u)) {
            break;
        }
        changed[0][_e634] = 0;
    }
    changed[0][1] = 9;
    changed[1][0] = 2;
    changed[1][1] = 3;
    local_28 = 0u;
    bool loop_init_1 = true;
    while(true) {
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
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                uint _e666 = local_29;
                local_29 = (_e666 + 1u);
            }
            loop_init_2 = false;
            uint _e661 = local_29;
            if ((_e661 >= 3u)) {
                break;
            }
            nested_empty[_e654][_e661] = 0;
        }
    }
    partial[0][0] = 1;
    local_30 = 1u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e683 = local_30;
            local_30 = (_e683 + 1u);
        }
        loop_init_3 = false;
        uint _e678 = local_30;
        if ((_e678 >= 3u)) {
            break;
        }
        partial[0][_e678] = 0;
    }
    local_31 = 1u;
    bool loop_init_4 = true;
    while(true) {
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
        bool loop_init_5 = true;
        while(true) {
            if (!loop_init_5) {
                uint _e699 = local_32;
                local_32 = (_e699 + 1u);
            }
            loop_init_5 = false;
            uint _e694 = local_32;
            if ((_e694 >= 3u)) {
                break;
            }
            partial[_e688][_e694] = 0;
        }
    }
    volume[0][0][0] = 1;
    local_33 = 1u;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            uint _e717 = local_33;
            local_33 = (_e717 + 1u);
        }
        loop_init_6 = false;
        uint _e712 = local_33;
        if ((_e712 >= 3u)) {
            break;
        }
        volume[0][0][_e712] = 0;
    }
    local_34 = 1u;
    bool loop_init_7 = true;
    while(true) {
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
        bool loop_init_8 = true;
        while(true) {
            if (!loop_init_8) {
                uint _e733 = local_35;
                local_35 = (_e733 + 1u);
            }
            loop_init_8 = false;
            uint _e728 = local_35;
            if ((_e728 >= 3u)) {
                break;
            }
            volume[0][_e722][_e728] = 0;
        }
    }
    local_36 = 1u;
    bool loop_init_9 = true;
    while(true) {
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
        bool loop_init_10 = true;
        while(true) {
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
            bool loop_init_11 = true;
            while(true) {
                if (!loop_init_11) {
                    uint _e758 = local_38;
                    local_38 = (_e758 + 1u);
                }
                loop_init_11 = false;
                uint _e753 = local_38;
                if ((_e753 >= 3u)) {
                    break;
                }
                volume[_e741][_e747][_e753] = 0;
            }
        }
    }
    int _e771 = changed[0][1];
    shared_values[1][2] = _e771;
    int _e781 = changed[1][0];
    int _e786 = changed[1][1];
    shared_points[1][0] = float3_(float(_e781), float(_e786), float(4));
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    int _e806 = shared_values[1][2];
    int _e807 = nested_empty[1][2];
    int _e813 = partial[1][2];
    int _e821 = volume[1][1][2];
    local_39 = uint(27);
    uint _e826 = local_39;
    local_69 = uint(_e826);
    uint _e829 = local_69;
    _group_0_binding_0_cs[_e829] = (((_e806 + _e807) + _e813) + _e821);
    float _e836 = shared_points[1][0].x;
    local_40 = uint(28);
    uint _e841 = local_40;
    local_70 = uint(_e841);
    uint _e844 = local_70;
    _group_0_binding_0_cs[_e844] = int(_e836);
    float _e851 = shared_points[1][0].y;
    local_41 = uint(29);
    uint _e856 = local_41;
    local_71 = uint(_e856);
    uint _e859 = local_71;
    _group_0_binding_0_cs[_e859] = int(_e851);
}

