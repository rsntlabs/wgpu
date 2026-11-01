// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];
struct type_4 {
    metal::int2 inner[2];
};
struct type_5 {
    type_4 inner[2];
};
struct int3_ {
    int x;
    int y;
    int z;
};
struct type_6 {
    int3_ inner[2];
};
struct type_7 {
    type_6 inner[2];
};
struct type_9 {
    metal::int4 inner[2];
};
struct type_10 {
    type_9 inner[2];
};
struct type_12 {
    metal::uint2 inner[2];
};
struct type_13 {
    type_12 inner[2];
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct type_14 {
    uint3_ inner[2];
};
struct type_15 {
    type_14 inner[2];
};
struct type_17 {
    metal::uint4 inner[2];
};
struct type_18 {
    type_17 inner[2];
};
struct type_21 {
    metal::float2 inner[2];
};
struct type_22 {
    type_21 inner[2];
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_23 {
    float3_ inner[2];
};
struct type_24 {
    type_23 inner[2];
};
struct type_26 {
    metal::float4 inner[2];
};
struct type_27 {
    type_26 inner[2];
};
struct type_28 {
    int inner[2];
};
struct type_29 {
    type_28 inner[2];
};
struct type_30 {
    int inner[3];
};
struct type_31 {
    type_30 inner[2];
};
struct type_32 {
    type_31 inner[2];
};
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void multidimensional_arrays(
  uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, threadgroup type_31& shared_values
, threadgroup type_24& shared_points
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
        shared_points = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    metal::int2 original = {};
    type_5 points = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int3_ original_1 = {};
    type_7 points_1 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    metal::int4 original_2 = {};
    type_10 points_2 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    metal::uint2 original_3 = {};
    type_13 points_3 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint3_ original_4 = {};
    type_15 points_4 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    metal::uint4 original_5 = {};
    type_18 points_5 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    metal::float2 original_6 = {};
    type_22 points_6 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    float3_ original_7 = {};
    type_24 points_7 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    metal::float4 original_8 = {};
    type_27 points_8 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_29 changed = {};
    uint local_27 = {};
    type_31 nested_empty = {};
    uint local_28 = {};
    uint local_29 = {};
    type_31 partial = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    type_32 volume = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    {
        original.x = 1;
        original.y = 2;
        metal::int2 _e8 = original;
        points.inner[0].inner[0] = _e8;
        points.inner[0].inner[1] = metal::int2 {};
        metal::int2 _e13 = original;
        points.inner[1].inner[0] = _e13;
        points.inner[1].inner[1].x = 5;
        points.inner[1].inner[1].y = int {};
        int _e24 = points.inner[0].inner[0].y;
        local = static_cast<uint>(0);
        uint _e28 = local;
        local_39 = _e28;
        uint _e30 = local_39;
        out[_e30] = _e24;
        int _e38 = points.inner[1].inner[1].x;
        local_1 = static_cast<uint>(1);
        uint _e42 = local_1;
        local_40 = _e42;
        uint _e44 = local_40;
        out[_e44] = _e38;
        int _e51 = points.inner[1].inner[1].y;
        local_2 = static_cast<uint>(2);
        uint _e55 = local_2;
        local_41 = _e55;
        uint _e57 = local_41;
        out[_e57] = _e51;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e69 = original_1;
        points_1.inner[0].inner[0] = _e69;
        points_1.inner[0].inner[1] = int3_ {};
        int3_ _e74 = original_1;
        points_1.inner[1].inner[0] = _e74;
        points_1.inner[1].inner[1].x = 5;
        points_1.inner[1].inner[1].y = int {};
        points_1.inner[1].inner[1].z = int {};
        int _e87 = points_1.inner[0].inner[0].z;
        local_3 = static_cast<uint>(3);
        uint _e91 = local_3;
        local_42 = _e91;
        uint _e93 = local_42;
        out[_e93] = _e87;
        int _e100 = points_1.inner[1].inner[1].x;
        local_4 = static_cast<uint>(4);
        uint _e104 = local_4;
        local_43 = _e104;
        uint _e106 = local_43;
        out[_e106] = _e100;
        int _e113 = points_1.inner[1].inner[1].z;
        local_5 = static_cast<uint>(5);
        uint _e117 = local_5;
        local_44 = _e117;
        uint _e119 = local_44;
        out[_e119] = _e113;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        metal::int4 _e133 = original_2;
        points_2.inner[0].inner[0] = _e133;
        points_2.inner[0].inner[1] = metal::int4 {};
        metal::int4 _e138 = original_2;
        points_2.inner[1].inner[0] = _e138;
        points_2.inner[1].inner[1].x = 5;
        points_2.inner[1].inner[1].y = int {};
        points_2.inner[1].inner[1].z = int {};
        points_2.inner[1].inner[1].w = int {};
        int _e153 = points_2.inner[0].inner[0].w;
        local_6 = static_cast<uint>(6);
        uint _e157 = local_6;
        local_45 = _e157;
        uint _e159 = local_45;
        out[_e159] = _e153;
        int _e166 = points_2.inner[1].inner[1].x;
        local_7 = static_cast<uint>(7);
        uint _e170 = local_7;
        local_46 = _e170;
        uint _e172 = local_46;
        out[_e172] = _e166;
        int _e179 = points_2.inner[1].inner[1].w;
        local_8 = static_cast<uint>(8);
        uint _e183 = local_8;
        local_47 = _e183;
        uint _e185 = local_47;
        out[_e185] = _e179;
    }
    {
        original_3.x = static_cast<uint>(1);
        original_3.y = static_cast<uint>(2);
        metal::uint2 _e197 = original_3;
        points_3.inner[0].inner[0] = _e197;
        points_3.inner[0].inner[1] = metal::uint2 {};
        metal::uint2 _e202 = original_3;
        points_3.inner[1].inner[0] = _e202;
        points_3.inner[1].inner[1].x = static_cast<uint>(5);
        points_3.inner[1].inner[1].y = uint {};
        uint _e214 = points_3.inner[0].inner[0].y;
        local_9 = static_cast<uint>(9);
        uint _e219 = local_9;
        local_48 = _e219;
        uint _e221 = local_48;
        out[_e221] = static_cast<int>(_e214);
        uint _e228 = points_3.inner[1].inner[1].x;
        local_10 = static_cast<uint>(10);
        uint _e233 = local_10;
        local_49 = _e233;
        uint _e235 = local_49;
        out[_e235] = static_cast<int>(_e228);
        uint _e242 = points_3.inner[1].inner[1].y;
        local_11 = static_cast<uint>(11);
        uint _e247 = local_11;
        local_50 = _e247;
        uint _e249 = local_50;
        out[_e249] = static_cast<int>(_e242);
    }
    {
        original_4.x = static_cast<uint>(1);
        original_4.y = static_cast<uint>(2);
        original_4.z = static_cast<uint>(3);
        uint3_ _e264 = original_4;
        points_4.inner[0].inner[0] = _e264;
        points_4.inner[0].inner[1] = uint3_ {};
        uint3_ _e269 = original_4;
        points_4.inner[1].inner[0] = _e269;
        points_4.inner[1].inner[1].x = static_cast<uint>(5);
        points_4.inner[1].inner[1].y = uint {};
        points_4.inner[1].inner[1].z = uint {};
        uint _e283 = points_4.inner[0].inner[0].z;
        local_12 = static_cast<uint>(12);
        uint _e288 = local_12;
        local_51 = _e288;
        uint _e290 = local_51;
        out[_e290] = static_cast<int>(_e283);
        uint _e297 = points_4.inner[1].inner[1].x;
        local_13 = static_cast<uint>(13);
        uint _e302 = local_13;
        local_52 = _e302;
        uint _e304 = local_52;
        out[_e304] = static_cast<int>(_e297);
        uint _e311 = points_4.inner[1].inner[1].z;
        local_14 = static_cast<uint>(14);
        uint _e316 = local_14;
        local_53 = _e316;
        uint _e318 = local_53;
        out[_e318] = static_cast<int>(_e311);
    }
    {
        original_5.x = static_cast<uint>(1);
        original_5.y = static_cast<uint>(2);
        original_5.z = static_cast<uint>(3);
        original_5.w = static_cast<uint>(4);
        metal::uint4 _e336 = original_5;
        points_5.inner[0].inner[0] = _e336;
        points_5.inner[0].inner[1] = metal::uint4 {};
        metal::uint4 _e341 = original_5;
        points_5.inner[1].inner[0] = _e341;
        points_5.inner[1].inner[1].x = static_cast<uint>(5);
        points_5.inner[1].inner[1].y = uint {};
        points_5.inner[1].inner[1].z = uint {};
        points_5.inner[1].inner[1].w = uint {};
        uint _e357 = points_5.inner[0].inner[0].w;
        local_15 = static_cast<uint>(15);
        uint _e362 = local_15;
        local_54 = _e362;
        uint _e364 = local_54;
        out[_e364] = static_cast<int>(_e357);
        uint _e371 = points_5.inner[1].inner[1].x;
        local_16 = static_cast<uint>(16);
        uint _e376 = local_16;
        local_55 = _e376;
        uint _e378 = local_55;
        out[_e378] = static_cast<int>(_e371);
        uint _e385 = points_5.inner[1].inner[1].w;
        local_17 = static_cast<uint>(17);
        uint _e390 = local_17;
        local_56 = _e390;
        uint _e392 = local_56;
        out[_e392] = static_cast<int>(_e385);
    }
    {
        original_6.x = static_cast<float>(1);
        original_6.y = static_cast<float>(2);
        metal::float2 _e404 = original_6;
        points_6.inner[0].inner[0] = _e404;
        points_6.inner[0].inner[1] = metal::float2 {};
        metal::float2 _e409 = original_6;
        points_6.inner[1].inner[0] = _e409;
        points_6.inner[1].inner[1].x = static_cast<float>(5);
        points_6.inner[1].inner[1].y = float {};
        float _e421 = points_6.inner[0].inner[0].y;
        local_18 = static_cast<uint>(18);
        uint _e426 = local_18;
        local_57 = _e426;
        uint _e428 = local_57;
        out[_e428] = naga_f2i32(_e421);
        float _e435 = points_6.inner[1].inner[1].x;
        local_19 = static_cast<uint>(19);
        uint _e440 = local_19;
        local_58 = _e440;
        uint _e442 = local_58;
        out[_e442] = naga_f2i32(_e435);
        float _e449 = points_6.inner[1].inner[1].y;
        local_20 = static_cast<uint>(20);
        uint _e454 = local_20;
        local_59 = _e454;
        uint _e456 = local_59;
        out[_e456] = naga_f2i32(_e449);
    }
    {
        original_7.x = static_cast<float>(1);
        original_7.y = static_cast<float>(2);
        original_7.z = static_cast<float>(3);
        float3_ _e471 = original_7;
        points_7.inner[0].inner[0] = _e471;
        points_7.inner[0].inner[1] = float3_ {};
        float3_ _e476 = original_7;
        points_7.inner[1].inner[0] = _e476;
        points_7.inner[1].inner[1].x = static_cast<float>(5);
        points_7.inner[1].inner[1].y = float {};
        points_7.inner[1].inner[1].z = float {};
        float _e490 = points_7.inner[0].inner[0].z;
        local_21 = static_cast<uint>(21);
        uint _e495 = local_21;
        local_60 = _e495;
        uint _e497 = local_60;
        out[_e497] = naga_f2i32(_e490);
        float _e504 = points_7.inner[1].inner[1].x;
        local_22 = static_cast<uint>(22);
        uint _e509 = local_22;
        local_61 = _e509;
        uint _e511 = local_61;
        out[_e511] = naga_f2i32(_e504);
        float _e518 = points_7.inner[1].inner[1].z;
        local_23 = static_cast<uint>(23);
        uint _e523 = local_23;
        local_62 = _e523;
        uint _e525 = local_62;
        out[_e525] = naga_f2i32(_e518);
    }
    {
        original_8.x = static_cast<float>(1);
        original_8.y = static_cast<float>(2);
        original_8.z = static_cast<float>(3);
        original_8.w = static_cast<float>(4);
        metal::float4 _e543 = original_8;
        points_8.inner[0].inner[0] = _e543;
        points_8.inner[0].inner[1] = metal::float4 {};
        metal::float4 _e548 = original_8;
        points_8.inner[1].inner[0] = _e548;
        points_8.inner[1].inner[1].x = static_cast<float>(5);
        points_8.inner[1].inner[1].y = float {};
        points_8.inner[1].inner[1].z = float {};
        points_8.inner[1].inner[1].w = float {};
        float _e564 = points_8.inner[0].inner[0].w;
        local_24 = static_cast<uint>(24);
        uint _e569 = local_24;
        local_63 = _e569;
        uint _e571 = local_63;
        out[_e571] = naga_f2i32(_e564);
        float _e578 = points_8.inner[1].inner[1].x;
        local_25 = static_cast<uint>(25);
        uint _e583 = local_25;
        local_64 = _e583;
        uint _e585 = local_64;
        out[_e585] = naga_f2i32(_e578);
        float _e592 = points_8.inner[1].inner[1].w;
        local_26 = static_cast<uint>(26);
        uint _e597 = local_26;
        local_65 = _e597;
        uint _e599 = local_65;
        out[_e599] = naga_f2i32(_e592);
    }
    changed.inner[0].inner[0] = 1;
    local_27 = 1u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e612 = local_27;
            local_27 = _e612 + 1u;
        }
        loop_init = false;
        uint _e607 = local_27;
        if (_e607 >= 2u) {
            break;
        }
        changed.inner[0].inner[_e607] = int {};
    }
    changed.inner[0].inner[1] = 9;
    changed.inner[1].inner[0] = 2;
    changed.inner[1].inner[1] = 3;
    local_28 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e642 = local_28;
            local_28 = _e642 + 1u;
        }
        loop_init_1 = false;
        uint _e627 = local_28;
        if (_e627 >= 2u) {
            break;
        }
        local_29 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e639 = local_29;
                local_29 = _e639 + 1u;
            }
            loop_init_2 = false;
            uint _e634 = local_29;
            if (_e634 >= 3u) {
                break;
            }
            nested_empty.inner[_e627].inner[_e634] = int {};
        }
    }
    partial.inner[0].inner[0] = 1;
    local_30 = 1u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e656 = local_30;
            local_30 = _e656 + 1u;
        }
        loop_init_3 = false;
        uint _e651 = local_30;
        if (_e651 >= 3u) {
            break;
        }
        partial.inner[0].inner[_e651] = int {};
    }
    local_31 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e675 = local_31;
            local_31 = _e675 + 1u;
        }
        loop_init_4 = false;
        uint _e661 = local_31;
        if (_e661 >= 2u) {
            break;
        }
        local_32 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e672 = local_32;
                local_32 = _e672 + 1u;
            }
            loop_init_5 = false;
            uint _e667 = local_32;
            if (_e667 >= 3u) {
                break;
            }
            partial.inner[_e661].inner[_e667] = int {};
        }
    }
    volume.inner[0].inner[0].inner[0] = 1;
    local_33 = 1u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e690 = local_33;
            local_33 = _e690 + 1u;
        }
        loop_init_6 = false;
        uint _e685 = local_33;
        if (_e685 >= 3u) {
            break;
        }
        volume.inner[0].inner[0].inner[_e685] = int {};
    }
    local_34 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e709 = local_34;
            local_34 = _e709 + 1u;
        }
        loop_init_7 = false;
        uint _e695 = local_34;
        if (_e695 >= 2u) {
            break;
        }
        local_35 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (metal::all(loop_bound_8 == uint2(0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e706 = local_35;
                local_35 = _e706 + 1u;
            }
            loop_init_8 = false;
            uint _e701 = local_35;
            if (_e701 >= 3u) {
                break;
            }
            volume.inner[0].inner[_e695].inner[_e701] = int {};
        }
    }
    local_36 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e737 = local_36;
            local_36 = _e737 + 1u;
        }
        loop_init_9 = false;
        uint _e714 = local_36;
        if (_e714 >= 2u) {
            break;
        }
        local_37 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (metal::all(loop_bound_10 == uint2(0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e734 = local_37;
                local_37 = _e734 + 1u;
            }
            loop_init_10 = false;
            uint _e720 = local_37;
            if (_e720 >= 2u) {
                break;
            }
            local_38 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (metal::all(loop_bound_11 == uint2(0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e731 = local_38;
                    local_38 = _e731 + 1u;
                }
                loop_init_11 = false;
                uint _e726 = local_38;
                if (_e726 >= 3u) {
                    break;
                }
                volume.inner[_e714].inner[_e720].inner[_e726] = int {};
            }
        }
    }
    int _e744 = changed.inner[0].inner[1];
    shared_values.inner[1].inner[2] = _e744;
    int _e754 = changed.inner[1].inner[0];
    int _e759 = changed.inner[1].inner[1];
    shared_points.inner[1].inner[0] = float3_ {static_cast<float>(_e754), static_cast<float>(_e759), static_cast<float>(4)};
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    int _e779 = shared_values.inner[1].inner[2];
    int _e780 = nested_empty.inner[1].inner[2];
    int _e786 = partial.inner[1].inner[2];
    int _e794 = volume.inner[1].inner[1].inner[2];
    out[static_cast<uint>(27)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e779) + as_type<uint>(_e780))) + as_type<uint>(_e786))) + as_type<uint>(_e794));
    float _e804 = shared_points.inner[1].inner[0].x;
    out[static_cast<uint>(28)] = naga_f2i32(_e804);
    float _e814 = shared_points.inner[1].inner[0].y;
    out[static_cast<uint>(29)] = naga_f2i32(_e814);
}
