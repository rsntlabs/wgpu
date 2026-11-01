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
    out_.Store(uint(int(0))*4, asuint(_e15));
    const uint _e21 = thread_component(1u);
    out_.Store(uint(int(1))*4, asuint(_e21));
    const uint _e26 = thread_component(2u);
    out_.Store(uint(int(2))*4, asuint(_e26));
    const uint _e31 = group_component(0u);
    out_.Store(uint(int(3))*4, asuint(_e31));
    const uint _e36 = group_component(1u);
    out_.Store(uint(int(4))*4, asuint(_e36));
    const uint _e41 = group_component(2u);
    out_.Store(uint(int(5))*4, asuint(_e41));
    const uint _e46 = shape_component(0u);
    out_.Store(uint(int(6))*4, asuint(_e46));
    const uint _e51 = shape_component(1u);
    out_.Store(uint(int(7))*4, asuint(_e51));
    const uint _e56 = shape_component(2u);
    out_.Store(uint(int(8))*4, asuint(_e56));
    const uint _e61 = grid_component(0u);
    out_.Store(uint(int(9))*4, asuint(_e61));
    const uint _e66 = grid_component(1u);
    out_.Store(uint(int(10))*4, asuint(_e66));
    const uint _e71 = grid_component(2u);
    out_.Store(uint(int(11))*4, asuint(_e71));
    const uint _e75 = global_x();
    out_.Store(uint(int(12))*4, asuint(_e75));
    const uint _e80 = component(0u);
    out_.Store(uint(int(13))*4, asuint(_e80));
    const float _e85 = component_1(2.5);
    out_.Store(uint(int(14))*4, asuint(asuint(_e85)));
    out_.Store(uint(int(15))*4, asuint(threadIdx.x));
    out_.Store(uint(int(16))*4, asuint(blockIdx.y));
    out_.Store(uint(int(17))*4, asuint(uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other).z));
    out_.Store(uint(int(18))*4, asuint(1u));
    int _e110 = asint(input.Load(uint(int(0))*4));
    out_.Store(uint(int(19))*4, asuint(uint(_e110)));
    out_.Store(uint(int(20))*4, asuint(asuint(scale_1)));
    float _e124 = asfloat(points.Load(0+uint(int(0))*12));
    out_.Store(uint(int(21))*4, asuint(asuint(_e124)));
    float _e133 = asfloat(points.Load(4+uint(int(0))*12));
    out_.Store(uint(int(22))*4, asuint(asuint(_e133)));
    float _e142 = asfloat(points.Load(8+uint(int(0))*12));
    out_.Store(uint(int(23))*4, asuint(asuint(_e142)));
    out_.Store(uint(int(24))*4, asuint(limit_1));
    const uint _e151 = thread_component(0u);
    const uint _e153 = group_component(1u);
    const uint _e156 = shape_component(2u);
    const uint _e159 = grid_component(0u);
    out_.Store(uint(int(25))*4, asuint((((_e151 + _e153) + _e156) + _e159)));
    const uint _e164 = global_x();
    const uint _e165 = global_x();
    out_.Store(uint(int(26))*4, asuint((_e164 + _e165)));
    int _e173 = asint(input.Load(uint(int(0))*4));
    float _e180 = asfloat(points.Load(0+uint(int(0))*12));
    out_.Store(uint(int(27))*4, asuint(asuint(((float(_e173) * scale_1) + _e180))));
    const uint _e187 = kind(threadIdx.x);
    out_.Store(uint(int(28))*4, asuint(_e187));
    const uint _e192 = grid_component(2u);
    out_.Store(uint(int(29))*4, asuint(_e192));
}
