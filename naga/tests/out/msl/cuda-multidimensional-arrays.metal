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
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
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
        uint _e29 = local;
        local_42 = static_cast<uint>(_e29);
        uint _e32 = local_42;
        out[_e32] = _e24;
        int _e39 = points.inner[1].inner[1].x;
        local_1 = static_cast<uint>(1);
        uint _e43 = local_1;
        local_43 = static_cast<uint>(_e43);
        uint _e46 = local_43;
        out[_e46] = _e39;
        int _e53 = points.inner[1].inner[1].y;
        local_2 = static_cast<uint>(2);
        uint _e57 = local_2;
        local_44 = static_cast<uint>(_e57);
        uint _e60 = local_44;
        out[_e60] = _e53;
    }
    {
        original_1.x = 1;
        original_1.y = 2;
        original_1.z = 3;
        int3_ _e72 = original_1;
        points_1.inner[0].inner[0] = _e72;
        points_1.inner[0].inner[1] = int3_ {};
        int3_ _e77 = original_1;
        points_1.inner[1].inner[0] = _e77;
        points_1.inner[1].inner[1].x = 5;
        points_1.inner[1].inner[1].y = int {};
        points_1.inner[1].inner[1].z = int {};
        int _e90 = points_1.inner[0].inner[0].z;
        local_3 = static_cast<uint>(3);
        uint _e94 = local_3;
        local_45 = static_cast<uint>(_e94);
        uint _e97 = local_45;
        out[_e97] = _e90;
        int _e104 = points_1.inner[1].inner[1].x;
        local_4 = static_cast<uint>(4);
        uint _e108 = local_4;
        local_46 = static_cast<uint>(_e108);
        uint _e111 = local_46;
        out[_e111] = _e104;
        int _e118 = points_1.inner[1].inner[1].z;
        local_5 = static_cast<uint>(5);
        uint _e122 = local_5;
        local_47 = static_cast<uint>(_e122);
        uint _e125 = local_47;
        out[_e125] = _e118;
    }
    {
        original_2.x = 1;
        original_2.y = 2;
        original_2.z = 3;
        original_2.w = 4;
        metal::int4 _e139 = original_2;
        points_2.inner[0].inner[0] = _e139;
        points_2.inner[0].inner[1] = metal::int4 {};
        metal::int4 _e144 = original_2;
        points_2.inner[1].inner[0] = _e144;
        points_2.inner[1].inner[1].x = 5;
        points_2.inner[1].inner[1].y = int {};
        points_2.inner[1].inner[1].z = int {};
        points_2.inner[1].inner[1].w = int {};
        int _e159 = points_2.inner[0].inner[0].w;
        local_6 = static_cast<uint>(6);
        uint _e163 = local_6;
        local_48 = static_cast<uint>(_e163);
        uint _e166 = local_48;
        out[_e166] = _e159;
        int _e173 = points_2.inner[1].inner[1].x;
        local_7 = static_cast<uint>(7);
        uint _e177 = local_7;
        local_49 = static_cast<uint>(_e177);
        uint _e180 = local_49;
        out[_e180] = _e173;
        int _e187 = points_2.inner[1].inner[1].w;
        local_8 = static_cast<uint>(8);
        uint _e191 = local_8;
        local_50 = static_cast<uint>(_e191);
        uint _e194 = local_50;
        out[_e194] = _e187;
    }
    {
        original_3.x = static_cast<uint>(1);
        original_3.y = static_cast<uint>(2);
        metal::uint2 _e206 = original_3;
        points_3.inner[0].inner[0] = _e206;
        points_3.inner[0].inner[1] = metal::uint2 {};
        metal::uint2 _e211 = original_3;
        points_3.inner[1].inner[0] = _e211;
        points_3.inner[1].inner[1].x = static_cast<uint>(5);
        points_3.inner[1].inner[1].y = uint {};
        uint _e223 = points_3.inner[0].inner[0].y;
        local_9 = static_cast<uint>(9);
        uint _e228 = local_9;
        local_51 = static_cast<uint>(_e228);
        uint _e231 = local_51;
        out[_e231] = static_cast<int>(_e223);
        uint _e238 = points_3.inner[1].inner[1].x;
        local_10 = static_cast<uint>(10);
        uint _e243 = local_10;
        local_52 = static_cast<uint>(_e243);
        uint _e246 = local_52;
        out[_e246] = static_cast<int>(_e238);
        uint _e253 = points_3.inner[1].inner[1].y;
        local_11 = static_cast<uint>(11);
        uint _e258 = local_11;
        local_53 = static_cast<uint>(_e258);
        uint _e261 = local_53;
        out[_e261] = static_cast<int>(_e253);
    }
    {
        original_4.x = static_cast<uint>(1);
        original_4.y = static_cast<uint>(2);
        original_4.z = static_cast<uint>(3);
        uint3_ _e276 = original_4;
        points_4.inner[0].inner[0] = _e276;
        points_4.inner[0].inner[1] = uint3_ {};
        uint3_ _e281 = original_4;
        points_4.inner[1].inner[0] = _e281;
        points_4.inner[1].inner[1].x = static_cast<uint>(5);
        points_4.inner[1].inner[1].y = uint {};
        points_4.inner[1].inner[1].z = uint {};
        uint _e295 = points_4.inner[0].inner[0].z;
        local_12 = static_cast<uint>(12);
        uint _e300 = local_12;
        local_54 = static_cast<uint>(_e300);
        uint _e303 = local_54;
        out[_e303] = static_cast<int>(_e295);
        uint _e310 = points_4.inner[1].inner[1].x;
        local_13 = static_cast<uint>(13);
        uint _e315 = local_13;
        local_55 = static_cast<uint>(_e315);
        uint _e318 = local_55;
        out[_e318] = static_cast<int>(_e310);
        uint _e325 = points_4.inner[1].inner[1].z;
        local_14 = static_cast<uint>(14);
        uint _e330 = local_14;
        local_56 = static_cast<uint>(_e330);
        uint _e333 = local_56;
        out[_e333] = static_cast<int>(_e325);
    }
    {
        original_5.x = static_cast<uint>(1);
        original_5.y = static_cast<uint>(2);
        original_5.z = static_cast<uint>(3);
        original_5.w = static_cast<uint>(4);
        metal::uint4 _e351 = original_5;
        points_5.inner[0].inner[0] = _e351;
        points_5.inner[0].inner[1] = metal::uint4 {};
        metal::uint4 _e356 = original_5;
        points_5.inner[1].inner[0] = _e356;
        points_5.inner[1].inner[1].x = static_cast<uint>(5);
        points_5.inner[1].inner[1].y = uint {};
        points_5.inner[1].inner[1].z = uint {};
        points_5.inner[1].inner[1].w = uint {};
        uint _e372 = points_5.inner[0].inner[0].w;
        local_15 = static_cast<uint>(15);
        uint _e377 = local_15;
        local_57 = static_cast<uint>(_e377);
        uint _e380 = local_57;
        out[_e380] = static_cast<int>(_e372);
        uint _e387 = points_5.inner[1].inner[1].x;
        local_16 = static_cast<uint>(16);
        uint _e392 = local_16;
        local_58 = static_cast<uint>(_e392);
        uint _e395 = local_58;
        out[_e395] = static_cast<int>(_e387);
        uint _e402 = points_5.inner[1].inner[1].w;
        local_17 = static_cast<uint>(17);
        uint _e407 = local_17;
        local_59 = static_cast<uint>(_e407);
        uint _e410 = local_59;
        out[_e410] = static_cast<int>(_e402);
    }
    {
        original_6.x = static_cast<float>(1);
        original_6.y = static_cast<float>(2);
        metal::float2 _e422 = original_6;
        points_6.inner[0].inner[0] = _e422;
        points_6.inner[0].inner[1] = metal::float2 {};
        metal::float2 _e427 = original_6;
        points_6.inner[1].inner[0] = _e427;
        points_6.inner[1].inner[1].x = static_cast<float>(5);
        points_6.inner[1].inner[1].y = float {};
        float _e439 = points_6.inner[0].inner[0].y;
        local_18 = static_cast<uint>(18);
        uint _e444 = local_18;
        local_60 = static_cast<uint>(_e444);
        uint _e447 = local_60;
        out[_e447] = naga_f2i32(_e439);
        float _e454 = points_6.inner[1].inner[1].x;
        local_19 = static_cast<uint>(19);
        uint _e459 = local_19;
        local_61 = static_cast<uint>(_e459);
        uint _e462 = local_61;
        out[_e462] = naga_f2i32(_e454);
        float _e469 = points_6.inner[1].inner[1].y;
        local_20 = static_cast<uint>(20);
        uint _e474 = local_20;
        local_62 = static_cast<uint>(_e474);
        uint _e477 = local_62;
        out[_e477] = naga_f2i32(_e469);
    }
    {
        original_7.x = static_cast<float>(1);
        original_7.y = static_cast<float>(2);
        original_7.z = static_cast<float>(3);
        float3_ _e492 = original_7;
        points_7.inner[0].inner[0] = _e492;
        points_7.inner[0].inner[1] = float3_ {};
        float3_ _e497 = original_7;
        points_7.inner[1].inner[0] = _e497;
        points_7.inner[1].inner[1].x = static_cast<float>(5);
        points_7.inner[1].inner[1].y = float {};
        points_7.inner[1].inner[1].z = float {};
        float _e511 = points_7.inner[0].inner[0].z;
        local_21 = static_cast<uint>(21);
        uint _e516 = local_21;
        local_63 = static_cast<uint>(_e516);
        uint _e519 = local_63;
        out[_e519] = naga_f2i32(_e511);
        float _e526 = points_7.inner[1].inner[1].x;
        local_22 = static_cast<uint>(22);
        uint _e531 = local_22;
        local_64 = static_cast<uint>(_e531);
        uint _e534 = local_64;
        out[_e534] = naga_f2i32(_e526);
        float _e541 = points_7.inner[1].inner[1].z;
        local_23 = static_cast<uint>(23);
        uint _e546 = local_23;
        local_65 = static_cast<uint>(_e546);
        uint _e549 = local_65;
        out[_e549] = naga_f2i32(_e541);
    }
    {
        original_8.x = static_cast<float>(1);
        original_8.y = static_cast<float>(2);
        original_8.z = static_cast<float>(3);
        original_8.w = static_cast<float>(4);
        metal::float4 _e567 = original_8;
        points_8.inner[0].inner[0] = _e567;
        points_8.inner[0].inner[1] = metal::float4 {};
        metal::float4 _e572 = original_8;
        points_8.inner[1].inner[0] = _e572;
        points_8.inner[1].inner[1].x = static_cast<float>(5);
        points_8.inner[1].inner[1].y = float {};
        points_8.inner[1].inner[1].z = float {};
        points_8.inner[1].inner[1].w = float {};
        float _e588 = points_8.inner[0].inner[0].w;
        local_24 = static_cast<uint>(24);
        uint _e593 = local_24;
        local_66 = static_cast<uint>(_e593);
        uint _e596 = local_66;
        out[_e596] = naga_f2i32(_e588);
        float _e603 = points_8.inner[1].inner[1].x;
        local_25 = static_cast<uint>(25);
        uint _e608 = local_25;
        local_67 = static_cast<uint>(_e608);
        uint _e611 = local_67;
        out[_e611] = naga_f2i32(_e603);
        float _e618 = points_8.inner[1].inner[1].w;
        local_26 = static_cast<uint>(26);
        uint _e623 = local_26;
        local_68 = static_cast<uint>(_e623);
        uint _e626 = local_68;
        out[_e626] = naga_f2i32(_e618);
    }
    changed.inner[0].inner[0] = 1;
    local_27 = 1u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e639 = local_27;
            local_27 = _e639 + 1u;
        }
        loop_init = false;
        uint _e634 = local_27;
        if (_e634 >= 2u) {
            break;
        }
        changed.inner[0].inner[_e634] = int {};
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
            uint _e669 = local_28;
            local_28 = _e669 + 1u;
        }
        loop_init_1 = false;
        uint _e654 = local_28;
        if (_e654 >= 2u) {
            break;
        }
        local_29 = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e666 = local_29;
                local_29 = _e666 + 1u;
            }
            loop_init_2 = false;
            uint _e661 = local_29;
            if (_e661 >= 3u) {
                break;
            }
            nested_empty.inner[_e654].inner[_e661] = int {};
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
            uint _e683 = local_30;
            local_30 = _e683 + 1u;
        }
        loop_init_3 = false;
        uint _e678 = local_30;
        if (_e678 >= 3u) {
            break;
        }
        partial.inner[0].inner[_e678] = int {};
    }
    local_31 = 1u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e702 = local_31;
            local_31 = _e702 + 1u;
        }
        loop_init_4 = false;
        uint _e688 = local_31;
        if (_e688 >= 2u) {
            break;
        }
        local_32 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e699 = local_32;
                local_32 = _e699 + 1u;
            }
            loop_init_5 = false;
            uint _e694 = local_32;
            if (_e694 >= 3u) {
                break;
            }
            partial.inner[_e688].inner[_e694] = int {};
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
            uint _e717 = local_33;
            local_33 = _e717 + 1u;
        }
        loop_init_6 = false;
        uint _e712 = local_33;
        if (_e712 >= 3u) {
            break;
        }
        volume.inner[0].inner[0].inner[_e712] = int {};
    }
    local_34 = 1u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e736 = local_34;
            local_34 = _e736 + 1u;
        }
        loop_init_7 = false;
        uint _e722 = local_34;
        if (_e722 >= 2u) {
            break;
        }
        local_35 = 0u;
        uint2 loop_bound_8 = uint2(4294967295u);
        bool loop_init_8 = true;
        while(true) {
            if (metal::all(loop_bound_8 == uint2(0u))) { break; }
            loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
            if (!loop_init_8) {
                uint _e733 = local_35;
                local_35 = _e733 + 1u;
            }
            loop_init_8 = false;
            uint _e728 = local_35;
            if (_e728 >= 3u) {
                break;
            }
            volume.inner[0].inner[_e722].inner[_e728] = int {};
        }
    }
    local_36 = 1u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e764 = local_36;
            local_36 = _e764 + 1u;
        }
        loop_init_9 = false;
        uint _e741 = local_36;
        if (_e741 >= 2u) {
            break;
        }
        local_37 = 0u;
        uint2 loop_bound_10 = uint2(4294967295u);
        bool loop_init_10 = true;
        while(true) {
            if (metal::all(loop_bound_10 == uint2(0u))) { break; }
            loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
            if (!loop_init_10) {
                uint _e761 = local_37;
                local_37 = _e761 + 1u;
            }
            loop_init_10 = false;
            uint _e747 = local_37;
            if (_e747 >= 2u) {
                break;
            }
            local_38 = 0u;
            uint2 loop_bound_11 = uint2(4294967295u);
            bool loop_init_11 = true;
            while(true) {
                if (metal::all(loop_bound_11 == uint2(0u))) { break; }
                loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
                if (!loop_init_11) {
                    uint _e758 = local_38;
                    local_38 = _e758 + 1u;
                }
                loop_init_11 = false;
                uint _e753 = local_38;
                if (_e753 >= 3u) {
                    break;
                }
                volume.inner[_e741].inner[_e747].inner[_e753] = int {};
            }
        }
    }
    int _e771 = changed.inner[0].inner[1];
    shared_values.inner[1].inner[2] = _e771;
    int _e781 = changed.inner[1].inner[0];
    int _e786 = changed.inner[1].inner[1];
    shared_points.inner[1].inner[0] = float3_ {static_cast<float>(_e781), static_cast<float>(_e786), static_cast<float>(4)};
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    int _e806 = shared_values.inner[1].inner[2];
    int _e807 = nested_empty.inner[1].inner[2];
    int _e813 = partial.inner[1].inner[2];
    int _e821 = volume.inner[1].inner[1].inner[2];
    local_39 = static_cast<uint>(27);
    uint _e826 = local_39;
    local_69 = static_cast<uint>(_e826);
    uint _e829 = local_69;
    out[_e829] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e806) + as_type<uint>(_e807))) + as_type<uint>(_e813))) + as_type<uint>(_e821));
    float _e836 = shared_points.inner[1].inner[0].x;
    local_40 = static_cast<uint>(28);
    uint _e841 = local_40;
    local_70 = static_cast<uint>(_e841);
    uint _e844 = local_70;
    out[_e844] = naga_f2i32(_e836);
    float _e851 = shared_points.inner[1].inner[0].y;
    local_41 = static_cast<uint>(29);
    uint _e856 = local_41;
    local_71 = static_cast<uint>(_e856);
    uint _e859 = local_71;
    out[_e859] = naga_f2i32(_e851);
}
