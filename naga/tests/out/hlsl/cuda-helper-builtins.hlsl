struct NagaConstants {
    int first_vertex;
    int first_instance;
    uint other;
};
ConstantBuffer<NagaConstants> _NagaConstants: register(b0, space1);

struct type_5 {
    float value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct type_7 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

static uint3 threadIdx_1 = (uint3)0;
static uint3 blockIdx_1 = (uint3)0;
static uint3 gridDim_1 = (uint3)0;
ByteAddressBuffer input : register(t0);
cbuffer scale : register(b1) { type_5 scale; }
ByteAddressBuffer points : register(t2);
cbuffer limit : register(b3) { type_7 limit; }
RWByteAddressBuffer out_ : register(u4);

uint thread_component(uint axis)
{
    if ((axis == 0u)) {
        uint3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if ((axis == 1u)) {
        uint3 _e9 = threadIdx_1;
        return _e9.y;
    }
    uint3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(uint axis_1)
{
    if ((axis_1 == 0u)) {
        uint3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if ((axis_1 == 1u)) {
        uint3 _e9 = blockIdx_1;
        return _e9.y;
    }
    uint3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(uint axis_2)
{
    if ((axis_2 == 0u)) {
        return 1u;
    }
    if ((axis_2 == 1u)) {
        return 1u;
    }
    return 1u;
}

uint grid_component(uint axis_3)
{
    if ((axis_3 == 0u)) {
        uint3 _e4 = gridDim_1;
        return _e4.x;
    }
    if ((axis_3 == 1u)) {
        uint3 _e9 = gridDim_1;
        return _e9.y;
    }
    uint3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(uint axis_4)
{
    const uint _e1 = thread_component(axis_4);
    return _e1;
}

float component_1(float offset)
{
    uint3 _e2 = blockIdx_1;
    return (float(_e2.x) + offset);
}

uint global_x()
{
    const uint _e1 = group_component(0u);
    const uint _e3 = shape_component(0u);
    const uint _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

uint kind(uint value)
{
    return 11u;
}

void observe()
{
    uint3 _e1 = gridDim_1;
    if ((_e1.z != 0u)) {
        return;
    } else {
        return;
    }
}

[numthreads(1, 1, 1)]
void coordinates(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint3 gridDim : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;

    float scale_1 = scale.value;
    uint limit_1 = limit.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other);
    const uint _e12 = global_x();
    if ((_e12 >= limit_1)) {
        return;
    }
    observe();
    const uint _e15 = thread_component(0u);
    local = uint(int(0));
    uint _e19 = local;
    out_.Store(_e19*4, asuint(_e15));
    const uint _e23 = thread_component(1u);
    local_1 = uint(int(1));
    uint _e27 = local_1;
    out_.Store(_e27*4, asuint(_e23));
    const uint _e30 = thread_component(2u);
    local_2 = uint(int(2));
    uint _e34 = local_2;
    out_.Store(_e34*4, asuint(_e30));
    const uint _e37 = group_component(0u);
    local_3 = uint(int(3));
    uint _e41 = local_3;
    out_.Store(_e41*4, asuint(_e37));
    const uint _e44 = group_component(1u);
    local_4 = uint(int(4));
    uint _e48 = local_4;
    out_.Store(_e48*4, asuint(_e44));
    const uint _e51 = group_component(2u);
    local_5 = uint(int(5));
    uint _e55 = local_5;
    out_.Store(_e55*4, asuint(_e51));
    const uint _e58 = shape_component(0u);
    local_6 = uint(int(6));
    uint _e62 = local_6;
    out_.Store(_e62*4, asuint(_e58));
    const uint _e65 = shape_component(1u);
    local_7 = uint(int(7));
    uint _e69 = local_7;
    out_.Store(_e69*4, asuint(_e65));
    const uint _e72 = shape_component(2u);
    local_8 = uint(int(8));
    uint _e76 = local_8;
    out_.Store(_e76*4, asuint(_e72));
    const uint _e79 = grid_component(0u);
    local_9 = uint(int(9));
    uint _e83 = local_9;
    out_.Store(_e83*4, asuint(_e79));
    const uint _e86 = grid_component(1u);
    local_10 = uint(int(10));
    uint _e90 = local_10;
    out_.Store(_e90*4, asuint(_e86));
    const uint _e93 = grid_component(2u);
    local_11 = uint(int(11));
    uint _e97 = local_11;
    out_.Store(_e97*4, asuint(_e93));
    const uint _e99 = global_x();
    local_12 = uint(int(12));
    uint _e103 = local_12;
    out_.Store(_e103*4, asuint(_e99));
    const uint _e106 = component(0u);
    local_13 = uint(int(13));
    uint _e110 = local_13;
    out_.Store(_e110*4, asuint(_e106));
    const float _e113 = component_1(2.5);
    local_14 = uint(int(14));
    uint _e118 = local_14;
    out_.Store(_e118*4, asuint(asuint(_e113)));
    local_15 = uint(int(15));
    uint _e124 = local_15;
    out_.Store(_e124*4, asuint(threadIdx.x));
    local_16 = uint(int(16));
    uint _e130 = local_16;
    out_.Store(_e130*4, asuint(blockIdx.y));
    local_17 = uint(int(17));
    uint _e136 = local_17;
    out_.Store(_e136*4, asuint(uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other).z));
    local_18 = uint(int(18));
    uint _e141 = local_18;
    out_.Store(_e141*4, asuint(1u));
    local_20 = uint(int(0));
    uint _e147 = local_20;
    int _e150 = asint(input.Load(_e147*4));
    local_19 = uint(int(19));
    uint _e155 = local_19;
    out_.Store(_e155*4, asuint(uint(_e150)));
    local_21 = uint(int(20));
    uint _e161 = local_21;
    out_.Store(_e161*4, asuint(asuint(scale_1)));
    local_23 = uint(int(0));
    uint _e166 = local_23;
    float _e170 = asfloat(points.Load(0+_e166*12));
    local_22 = uint(int(21));
    uint _e175 = local_22;
    out_.Store(_e175*4, asuint(asuint(_e170)));
    local_25 = uint(int(0));
    uint _e180 = local_25;
    float _e183 = asfloat(points.Load(4+_e180*12));
    local_24 = uint(int(22));
    uint _e188 = local_24;
    out_.Store(_e188*4, asuint(asuint(_e183)));
    local_27 = uint(int(0));
    uint _e193 = local_27;
    float _e196 = asfloat(points.Load(8+_e193*12));
    local_26 = uint(int(23));
    uint _e201 = local_26;
    out_.Store(_e201*4, asuint(asuint(_e196)));
    local_28 = uint(int(24));
    uint _e206 = local_28;
    out_.Store(_e206*4, asuint(limit_1));
    const uint _e209 = thread_component(0u);
    const uint _e211 = group_component(1u);
    const uint _e214 = shape_component(2u);
    const uint _e217 = grid_component(0u);
    local_29 = uint(int(25));
    uint _e222 = local_29;
    out_.Store(_e222*4, asuint((((_e209 + _e211) + _e214) + _e217)));
    const uint _e224 = global_x();
    const uint _e225 = global_x();
    local_30 = uint(int(26));
    uint _e230 = local_30;
    out_.Store(_e230*4, asuint((_e224 + _e225)));
    local_32 = uint(int(0));
    uint _e235 = local_32;
    int _e237 = asint(input.Load(_e235*4));
    local_33 = uint(int(0));
    uint _e243 = local_33;
    float _e246 = asfloat(points.Load(0+_e243*12));
    local_31 = uint(int(27));
    uint _e252 = local_31;
    out_.Store(_e252*4, asuint(asuint(((float(_e237) * scale_1) + _e246))));
    const uint _e255 = kind(threadIdx.x);
    local_34 = uint(int(28));
    uint _e259 = local_34;
    out_.Store(_e259*4, asuint(_e255));
    const uint _e262 = grid_component(2u);
    local_35 = uint(int(29));
    uint _e266 = local_35;
    out_.Store(_e266*4, asuint(_e262));
}
