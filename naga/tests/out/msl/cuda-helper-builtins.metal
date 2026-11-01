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
    out[static_cast<uint>(0)] = _e15;
    uint _e21 = thread_component(1u, threadIdx_1);
    out[static_cast<uint>(1)] = _e21;
    uint _e26 = thread_component(2u, threadIdx_1);
    out[static_cast<uint>(2)] = _e26;
    uint _e31 = group_component(0u, blockIdx_1);
    out[static_cast<uint>(3)] = _e31;
    uint _e36 = group_component(1u, blockIdx_1);
    out[static_cast<uint>(4)] = _e36;
    uint _e41 = group_component(2u, blockIdx_1);
    out[static_cast<uint>(5)] = _e41;
    uint _e46 = shape_component(0u);
    out[static_cast<uint>(6)] = _e46;
    uint _e51 = shape_component(1u);
    out[static_cast<uint>(7)] = _e51;
    uint _e56 = shape_component(2u);
    out[static_cast<uint>(8)] = _e56;
    uint _e61 = grid_component(0u, gridDim_1);
    out[static_cast<uint>(9)] = _e61;
    uint _e66 = grid_component(1u, gridDim_1);
    out[static_cast<uint>(10)] = _e66;
    uint _e71 = grid_component(2u, gridDim_1);
    out[static_cast<uint>(11)] = _e71;
    uint _e75 = global_x(threadIdx_1, blockIdx_1);
    out[static_cast<uint>(12)] = _e75;
    uint _e80 = component(0u, threadIdx_1);
    out[static_cast<uint>(13)] = _e80;
    float _e85 = component_1(2.5, blockIdx_1);
    out[static_cast<uint>(14)] = as_type<uint>(_e85);
    out[static_cast<uint>(15)] = threadIdx.x;
    out[static_cast<uint>(16)] = blockIdx.y;
    out[static_cast<uint>(17)] = gridDim.z;
    out[static_cast<uint>(18)] = 1u;
    int _e110 = input[static_cast<uint>(0)];
    out[static_cast<uint>(19)] = static_cast<uint>(_e110);
    out[static_cast<uint>(20)] = as_type<uint>(scale_1);
    float _e124 = points[static_cast<uint>(0)].x;
    out[static_cast<uint>(21)] = as_type<uint>(_e124);
    float _e133 = points[static_cast<uint>(0)].y;
    out[static_cast<uint>(22)] = as_type<uint>(_e133);
    float _e142 = points[static_cast<uint>(0)].z;
    out[static_cast<uint>(23)] = as_type<uint>(_e142);
    out[static_cast<uint>(24)] = limit_1;
    uint _e151 = thread_component(0u, threadIdx_1);
    uint _e153 = group_component(1u, blockIdx_1);
    uint _e156 = shape_component(2u);
    uint _e159 = grid_component(0u, gridDim_1);
    out[static_cast<uint>(25)] = ((_e151 + _e153) + _e156) + _e159;
    uint _e164 = global_x(threadIdx_1, blockIdx_1);
    uint _e165 = global_x(threadIdx_1, blockIdx_1);
    out[static_cast<uint>(26)] = _e164 + _e165;
    int _e173 = input[static_cast<uint>(0)];
    float _e180 = points[static_cast<uint>(0)].x;
    out[static_cast<uint>(27)] = as_type<uint>((static_cast<float>(_e173) * scale_1) + _e180);
    uint _e187 = kind(threadIdx.x);
    out[static_cast<uint>(28)] = _e187;
    uint _e192 = grid_component(2u, gridDim_1);
    out[static_cast<uint>(29)] = _e192;
}
