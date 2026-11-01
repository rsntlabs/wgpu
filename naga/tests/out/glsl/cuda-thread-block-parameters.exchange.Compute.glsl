#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct dim3_ {
    uint x;
    uint y;
    uint z;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

uvec3 blockIdx_3 = uvec3(0u);

uvec3 gridDim_3 = uvec3(0u);

uvec3 threadIdx_1 = uvec3(0u);

shared uint values[4];


void synchronize(uvec3 blockIdx_1, uvec3 gridDim_1) {
    if ((dim3_(blockIdx_1.x, blockIdx_1.y, blockIdx_1.z).x < gridDim_1.x)) {
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        return;
    } else {
        return;
    }
}

uint reduce(uint input_, uint width, uvec3 blockIdx_2, uvec3 gridDim_2) {
    uint stride = 0u;
    uvec3 _e5 = threadIdx_1;
    uint lane = (_e5.x + (4u * (_e5.y + (1u * _e5.z))));
    values[lane] = input_;
    synchronize(blockIdx_2, gridDim_2);
    {
        stride = (width / 2u);
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e34 = stride;
                stride = (_e34 >> 1u);
            }
            loop_init = false;
            uint _e20 = stride;
            if ((_e20 > 0u)) {
            } else {
                break;
            }
            uint _e23 = stride;
            if ((lane < _e23)) {
                uint _e25 = stride;
                uint _e29 = values[(lane + _e25)];
                uint _e32 = values[lane];
                values[lane] = (_e32 + _e29);
            }
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
        }
    }
    uint _e40 = values[0];
    return _e40;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 gridDim = gl_NumWorkGroups;
    uint local = 0u;
    uint local_1 = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_3 = blockIdx;
    gridDim_3 = gridDim;
    uint lane_1 = (threadIdx.x + (4u * (threadIdx.y + (1u * threadIdx.z))));
    uint value = (((blockIdx.x * 10u) + lane_1) + 1u);
    uint _e22 = reduce(value, 4u, blockIdx, gridDim);
    uint base = (blockIdx.x * 8u);
    local = uint((base + lane_1));
    uint _e29 = local;
    _group_0_binding_0_cs[_e29] = _e22;
    local_1 = uint(((base + 4u) + lane_1));
    uint _e42 = local_1;
    _group_0_binding_0_cs[_e42] = (((value * 10u) + lane_1) + 4u);
}

