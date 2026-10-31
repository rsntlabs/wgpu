// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size3;
    uint size5;
    uint size7;
};

typedef int type_4[1];
struct type_5 {
    float value;
    char _pad1[12];
};
struct float3_ {
    float x;
    float y;
    float z;
};
typedef float3_ type_6[1];
struct type_7 {
    uint value;
    char _pad1[12];
};
typedef uint type_8[1];

uint thread_component(
    uint axis,
    thread metal::uint3& threadIdx_1
) {
    if (axis == 0u) {
        metal::uint3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if (axis == 1u) {
        metal::uint3 _e9 = threadIdx_1;
        return _e9.y;
    }
    metal::uint3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(
    uint axis_1,
    thread metal::uint3& blockIdx_1
) {
    if (axis_1 == 0u) {
        metal::uint3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if (axis_1 == 1u) {
        metal::uint3 _e9 = blockIdx_1;
        return _e9.y;
    }
    metal::uint3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(
    uint axis_2
) {
    if (axis_2 == 0u) {
        return 1u;
    }
    if (axis_2 == 1u) {
        return 1u;
    }
    return 1u;
}

uint grid_component(
    uint axis_3,
    thread metal::uint3& gridDim_1
) {
    if (axis_3 == 0u) {
        metal::uint3 _e4 = gridDim_1;
        return _e4.x;
    }
    if (axis_3 == 1u) {
        metal::uint3 _e9 = gridDim_1;
        return _e9.y;
    }
    metal::uint3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(
    uint axis_4,
    thread metal::uint3& threadIdx_1
) {
    uint _e1 = thread_component(axis_4, threadIdx_1);
    return _e1;
}

float component_1(
    float offset,
    thread metal::uint3& blockIdx_1
) {
    metal::uint3 _e2 = blockIdx_1;
    return static_cast<float>(_e2.x) + offset;
}

uint global_x(
    thread metal::uint3& threadIdx_1,
    thread metal::uint3& blockIdx_1
) {
    uint _e1 = group_component(0u, blockIdx_1);
    uint _e3 = shape_component(0u);
    uint _e6 = component(0u, threadIdx_1);
    return (_e1 * _e3) + _e6;
}

uint kind(
    uint value
) {
    return 11u;
}

void observe(
    thread metal::uint3& gridDim_1
) {
    metal::uint3 _e1 = gridDim_1;
    if (_e1.z != 0u) {
        return;
    } else {
        return;
    }
}

struct coordinatesInput {
};
kernel void coordinates(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 gridDim [[threadgroups_per_grid]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& scale [[user(fake0)]]
, device type_6 const& points [[user(fake0)]]
, constant type_7& limit [[user(fake0)]]
, device type_8& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_1 = {};
    metal::uint3 blockIdx_1 = {};
    metal::uint3 gridDim_1 = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int local_36 = {};
    float local_37 = {};
    float local_38 = {};
    float local_39 = {};
    int local_40 = {};
    float local_41 = {};
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
    int local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    float local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    float local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    float local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    int local_78 = {};
    uint local_79 = {};
    float local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    float scale_1 = scale.value;
    uint limit_1 = limit.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    uint _e12 = global_x(threadIdx_1, blockIdx_1);
    if (_e12 >= limit_1) {
        return;
    }
    observe(gridDim_1);
    uint _e15 = thread_component(0u, threadIdx_1);
    local = static_cast<uint>(0);
    uint _e19 = local;
    local_42 = static_cast<uint>(_e19);
    uint _e22 = local_42;
    out[_e22] = _e15;
    uint _e26 = thread_component(1u, threadIdx_1);
    local_1 = static_cast<uint>(1);
    uint _e30 = local_1;
    local_43 = static_cast<uint>(_e30);
    uint _e33 = local_43;
    out[_e33] = _e26;
    uint _e36 = thread_component(2u, threadIdx_1);
    local_2 = static_cast<uint>(2);
    uint _e40 = local_2;
    local_44 = static_cast<uint>(_e40);
    uint _e43 = local_44;
    out[_e43] = _e36;
    uint _e46 = group_component(0u, blockIdx_1);
    local_3 = static_cast<uint>(3);
    uint _e50 = local_3;
    local_45 = static_cast<uint>(_e50);
    uint _e53 = local_45;
    out[_e53] = _e46;
    uint _e56 = group_component(1u, blockIdx_1);
    local_4 = static_cast<uint>(4);
    uint _e60 = local_4;
    local_46 = static_cast<uint>(_e60);
    uint _e63 = local_46;
    out[_e63] = _e56;
    uint _e66 = group_component(2u, blockIdx_1);
    local_5 = static_cast<uint>(5);
    uint _e70 = local_5;
    local_47 = static_cast<uint>(_e70);
    uint _e73 = local_47;
    out[_e73] = _e66;
    uint _e76 = shape_component(0u);
    local_6 = static_cast<uint>(6);
    uint _e80 = local_6;
    local_48 = static_cast<uint>(_e80);
    uint _e83 = local_48;
    out[_e83] = _e76;
    uint _e86 = shape_component(1u);
    local_7 = static_cast<uint>(7);
    uint _e90 = local_7;
    local_49 = static_cast<uint>(_e90);
    uint _e93 = local_49;
    out[_e93] = _e86;
    uint _e96 = shape_component(2u);
    local_8 = static_cast<uint>(8);
    uint _e100 = local_8;
    local_50 = static_cast<uint>(_e100);
    uint _e103 = local_50;
    out[_e103] = _e96;
    uint _e106 = grid_component(0u, gridDim_1);
    local_9 = static_cast<uint>(9);
    uint _e110 = local_9;
    local_51 = static_cast<uint>(_e110);
    uint _e113 = local_51;
    out[_e113] = _e106;
    uint _e116 = grid_component(1u, gridDim_1);
    local_10 = static_cast<uint>(10);
    uint _e120 = local_10;
    local_52 = static_cast<uint>(_e120);
    uint _e123 = local_52;
    out[_e123] = _e116;
    uint _e126 = grid_component(2u, gridDim_1);
    local_11 = static_cast<uint>(11);
    uint _e130 = local_11;
    local_53 = static_cast<uint>(_e130);
    uint _e133 = local_53;
    out[_e133] = _e126;
    uint _e135 = global_x(threadIdx_1, blockIdx_1);
    local_12 = static_cast<uint>(12);
    uint _e139 = local_12;
    local_54 = static_cast<uint>(_e139);
    uint _e142 = local_54;
    out[_e142] = _e135;
    uint _e145 = component(0u, threadIdx_1);
    local_13 = static_cast<uint>(13);
    uint _e149 = local_13;
    local_55 = static_cast<uint>(_e149);
    uint _e152 = local_55;
    out[_e152] = _e145;
    float _e155 = component_1(2.5, blockIdx_1);
    local_14 = static_cast<uint>(14);
    uint _e160 = local_14;
    local_56 = static_cast<uint>(_e160);
    uint _e163 = local_56;
    out[_e163] = as_type<uint>(_e155);
    local_15 = static_cast<uint>(15);
    uint _e169 = local_15;
    local_57 = static_cast<uint>(_e169);
    uint _e172 = local_57;
    out[_e172] = threadIdx.x;
    local_16 = static_cast<uint>(16);
    uint _e178 = local_16;
    local_58 = static_cast<uint>(_e178);
    uint _e181 = local_58;
    out[_e181] = blockIdx.y;
    local_17 = static_cast<uint>(17);
    uint _e187 = local_17;
    local_59 = static_cast<uint>(_e187);
    uint _e190 = local_59;
    out[_e190] = gridDim.z;
    local_18 = static_cast<uint>(18);
    uint _e195 = local_18;
    local_60 = static_cast<uint>(_e195);
    uint _e198 = local_60;
    out[_e198] = 1u;
    local_20 = static_cast<uint>(0);
    uint _e204 = local_20;
    local_61 = static_cast<uint>(_e204);
    uint _e207 = local_61;
    int _e210 = input[_e207];
    local_62 = _e210;
    int _e212 = local_62;
    local_36 = _e212;
    int _e214 = local_36;
    local_19 = static_cast<uint>(19);
    uint _e219 = local_19;
    local_63 = static_cast<uint>(_e219);
    uint _e222 = local_63;
    out[_e222] = static_cast<uint>(_e214);
    local_21 = static_cast<uint>(20);
    uint _e228 = local_21;
    local_64 = static_cast<uint>(_e228);
    uint _e231 = local_64;
    out[_e231] = as_type<uint>(scale_1);
    local_23 = static_cast<uint>(0);
    uint _e236 = local_23;
    local_65 = static_cast<uint>(_e236);
    uint _e239 = local_65;
    float _e243 = points[_e239].x;
    local_66 = _e243;
    float _e245 = local_66;
    local_37 = _e245;
    float _e247 = local_37;
    local_22 = static_cast<uint>(21);
    uint _e252 = local_22;
    local_67 = static_cast<uint>(_e252);
    uint _e255 = local_67;
    out[_e255] = as_type<uint>(_e247);
    local_25 = static_cast<uint>(0);
    uint _e260 = local_25;
    local_68 = static_cast<uint>(_e260);
    uint _e263 = local_68;
    float _e266 = points[_e263].y;
    local_69 = _e266;
    float _e268 = local_69;
    local_38 = _e268;
    float _e270 = local_38;
    local_24 = static_cast<uint>(22);
    uint _e275 = local_24;
    local_70 = static_cast<uint>(_e275);
    uint _e278 = local_70;
    out[_e278] = as_type<uint>(_e270);
    local_27 = static_cast<uint>(0);
    uint _e283 = local_27;
    local_71 = static_cast<uint>(_e283);
    uint _e286 = local_71;
    float _e289 = points[_e286].z;
    local_72 = _e289;
    float _e291 = local_72;
    local_39 = _e291;
    float _e293 = local_39;
    local_26 = static_cast<uint>(23);
    uint _e298 = local_26;
    local_73 = static_cast<uint>(_e298);
    uint _e301 = local_73;
    out[_e301] = as_type<uint>(_e293);
    local_28 = static_cast<uint>(24);
    uint _e306 = local_28;
    local_74 = static_cast<uint>(_e306);
    uint _e309 = local_74;
    out[_e309] = limit_1;
    uint _e312 = thread_component(0u, threadIdx_1);
    uint _e314 = group_component(1u, blockIdx_1);
    uint _e317 = shape_component(2u);
    uint _e320 = grid_component(0u, gridDim_1);
    local_29 = static_cast<uint>(25);
    uint _e325 = local_29;
    local_75 = static_cast<uint>(_e325);
    uint _e328 = local_75;
    out[_e328] = ((_e312 + _e314) + _e317) + _e320;
    uint _e330 = global_x(threadIdx_1, blockIdx_1);
    uint _e331 = global_x(threadIdx_1, blockIdx_1);
    local_30 = static_cast<uint>(26);
    uint _e336 = local_30;
    local_76 = static_cast<uint>(_e336);
    uint _e339 = local_76;
    out[_e339] = _e330 + _e331;
    local_32 = static_cast<uint>(0);
    uint _e344 = local_32;
    local_77 = static_cast<uint>(_e344);
    uint _e347 = local_77;
    int _e349 = input[_e347];
    local_78 = _e349;
    int _e351 = local_78;
    local_40 = _e351;
    int _e353 = local_40;
    local_33 = static_cast<uint>(0);
    uint _e359 = local_33;
    local_79 = static_cast<uint>(_e359);
    uint _e362 = local_79;
    float _e365 = points[_e362].x;
    local_80 = _e365;
    float _e367 = local_80;
    local_41 = _e367;
    float _e369 = local_41;
    local_31 = static_cast<uint>(27);
    uint _e375 = local_31;
    local_81 = static_cast<uint>(_e375);
    uint _e378 = local_81;
    out[_e378] = as_type<uint>((static_cast<float>(_e353) * scale_1) + _e369);
    uint _e381 = kind(threadIdx.x);
    local_34 = static_cast<uint>(28);
    uint _e385 = local_34;
    local_82 = static_cast<uint>(_e385);
    uint _e388 = local_82;
    out[_e388] = _e381;
    uint _e391 = grid_component(2u, gridDim_1);
    local_35 = static_cast<uint>(29);
    uint _e395 = local_35;
    local_83 = static_cast<uint>(_e395);
    uint _e398 = local_83;
    out[_e398] = _e391;
}
