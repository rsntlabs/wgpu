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
    out[_e19] = _e15;
    uint _e23 = thread_component(1u, threadIdx_1);
    local_1 = static_cast<uint>(1);
    uint _e27 = local_1;
    out[_e27] = _e23;
    uint _e30 = thread_component(2u, threadIdx_1);
    local_2 = static_cast<uint>(2);
    uint _e34 = local_2;
    out[_e34] = _e30;
    uint _e37 = group_component(0u, blockIdx_1);
    local_3 = static_cast<uint>(3);
    uint _e41 = local_3;
    out[_e41] = _e37;
    uint _e44 = group_component(1u, blockIdx_1);
    local_4 = static_cast<uint>(4);
    uint _e48 = local_4;
    out[_e48] = _e44;
    uint _e51 = group_component(2u, blockIdx_1);
    local_5 = static_cast<uint>(5);
    uint _e55 = local_5;
    out[_e55] = _e51;
    uint _e58 = shape_component(0u);
    local_6 = static_cast<uint>(6);
    uint _e62 = local_6;
    out[_e62] = _e58;
    uint _e65 = shape_component(1u);
    local_7 = static_cast<uint>(7);
    uint _e69 = local_7;
    out[_e69] = _e65;
    uint _e72 = shape_component(2u);
    local_8 = static_cast<uint>(8);
    uint _e76 = local_8;
    out[_e76] = _e72;
    uint _e79 = grid_component(0u, gridDim_1);
    local_9 = static_cast<uint>(9);
    uint _e83 = local_9;
    out[_e83] = _e79;
    uint _e86 = grid_component(1u, gridDim_1);
    local_10 = static_cast<uint>(10);
    uint _e90 = local_10;
    out[_e90] = _e86;
    uint _e93 = grid_component(2u, gridDim_1);
    local_11 = static_cast<uint>(11);
    uint _e97 = local_11;
    out[_e97] = _e93;
    uint _e99 = global_x(threadIdx_1, blockIdx_1);
    local_12 = static_cast<uint>(12);
    uint _e103 = local_12;
    out[_e103] = _e99;
    uint _e106 = component(0u, threadIdx_1);
    local_13 = static_cast<uint>(13);
    uint _e110 = local_13;
    out[_e110] = _e106;
    float _e113 = component_1(2.5, blockIdx_1);
    local_14 = static_cast<uint>(14);
    uint _e118 = local_14;
    out[_e118] = as_type<uint>(_e113);
    local_15 = static_cast<uint>(15);
    uint _e124 = local_15;
    out[_e124] = threadIdx.x;
    local_16 = static_cast<uint>(16);
    uint _e130 = local_16;
    out[_e130] = blockIdx.y;
    local_17 = static_cast<uint>(17);
    uint _e136 = local_17;
    out[_e136] = gridDim.z;
    local_18 = static_cast<uint>(18);
    uint _e141 = local_18;
    out[_e141] = 1u;
    local_20 = static_cast<uint>(0);
    uint _e147 = local_20;
    int _e150 = input[_e147];
    local_19 = static_cast<uint>(19);
    uint _e155 = local_19;
    out[_e155] = static_cast<uint>(_e150);
    local_21 = static_cast<uint>(20);
    uint _e161 = local_21;
    out[_e161] = as_type<uint>(scale_1);
    local_23 = static_cast<uint>(0);
    uint _e166 = local_23;
    float _e170 = points[_e166].x;
    local_22 = static_cast<uint>(21);
    uint _e175 = local_22;
    out[_e175] = as_type<uint>(_e170);
    local_25 = static_cast<uint>(0);
    uint _e180 = local_25;
    float _e183 = points[_e180].y;
    local_24 = static_cast<uint>(22);
    uint _e188 = local_24;
    out[_e188] = as_type<uint>(_e183);
    local_27 = static_cast<uint>(0);
    uint _e193 = local_27;
    float _e196 = points[_e193].z;
    local_26 = static_cast<uint>(23);
    uint _e201 = local_26;
    out[_e201] = as_type<uint>(_e196);
    local_28 = static_cast<uint>(24);
    uint _e206 = local_28;
    out[_e206] = limit_1;
    uint _e209 = thread_component(0u, threadIdx_1);
    uint _e211 = group_component(1u, blockIdx_1);
    uint _e214 = shape_component(2u);
    uint _e217 = grid_component(0u, gridDim_1);
    local_29 = static_cast<uint>(25);
    uint _e222 = local_29;
    out[_e222] = ((_e209 + _e211) + _e214) + _e217;
    uint _e224 = global_x(threadIdx_1, blockIdx_1);
    uint _e225 = global_x(threadIdx_1, blockIdx_1);
    local_30 = static_cast<uint>(26);
    uint _e230 = local_30;
    out[_e230] = _e224 + _e225;
    local_32 = static_cast<uint>(0);
    uint _e235 = local_32;
    int _e237 = input[_e235];
    local_33 = static_cast<uint>(0);
    uint _e243 = local_33;
    float _e246 = points[_e243].x;
    local_31 = static_cast<uint>(27);
    uint _e252 = local_31;
    out[_e252] = as_type<uint>((static_cast<float>(_e237) * scale_1) + _e246);
    uint _e255 = kind(threadIdx.x);
    local_34 = static_cast<uint>(28);
    uint _e259 = local_34;
    out[_e259] = _e255;
    uint _e262 = grid_component(2u, gridDim_1);
    local_35 = static_cast<uint>(29);
    uint _e266 = local_35;
    out[_e266] = _e262;
}
