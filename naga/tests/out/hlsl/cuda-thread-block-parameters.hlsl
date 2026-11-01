struct NagaConstants {
    int first_vertex;
    int first_instance;
    uint other;
};
ConstantBuffer<NagaConstants> _NagaConstants: register(b0, space1);

struct dim3_ {
    uint x;
    uint y;
    uint z;
};

RWByteAddressBuffer output : register(u0);
static uint3 blockIdx_3 = (uint3)0;
static uint3 gridDim_3 = (uint3)0;
static uint3 threadIdx_1 = (uint3)0;
groupshared uint values[4];

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

void synchronize(uint3 blockIdx_1, uint3 gridDim_1)
{
    if ((Constructdim3_(blockIdx_1.x, blockIdx_1.y, blockIdx_1.z).x < gridDim_1.x)) {
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        return;
    } else {
        return;
    }
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

uint reduce(uint input, uint width, uint3 blockIdx_2, uint3 gridDim_2)
{
    uint stride = (uint)0;

    uint3 _e5 = threadIdx_1;
    uint lane = (_e5.x + (4u * (_e5.y + (1u * _e5.z))));
    values[min(uint(lane), 3u)] = input;
    synchronize(blockIdx_2, gridDim_2);
    {
        stride = naga_div(width, 2u);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
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
                uint _e29 = values[min(uint((lane + _e25)), 3u)];
                uint _e32 = values[min(uint(lane), 3u)];
                values[min(uint(lane), 3u)] = (_e32 + _e29);
            }
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
        }
    }
    uint _e40 = values[int(0)];
    return _e40;
}

[numthreads(4, 1, 1)]
void exchange(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint3 gridDim : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local = (uint)0;
    uint local_1 = (uint)0;

    threadIdx_1 = threadIdx;
    blockIdx_3 = blockIdx;
    gridDim_3 = uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other);
    uint lane_1 = (threadIdx.x + (4u * (threadIdx.y + (1u * threadIdx.z))));
    uint value = (((blockIdx.x * 10u) + lane_1) + 1u);
    const uint _e22 = reduce(value, 4u, blockIdx, uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other));
    uint base = (blockIdx.x * 8u);
    local = uint((base + lane_1));
    uint _e29 = local;
    output.Store(_e29*4, asuint(_e22));
    local_1 = uint(((base + 4u) + lane_1));
    uint _e42 = local_1;
    output.Store(_e42*4, asuint((((value * 10u) + lane_1) + 4u)));
}
