struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer output : register(u0);

[numthreads(64, 1, 1)]
void object_sizes()
{
    float3_ values[2] = (float3_[2])0;

    output.Store(uint(int(0))*4, asuint(uint(24uL)));
    output.Store(uint(int(1))*4, asuint(uint(12uL)));
    output.Store(uint(int(2))*4, asuint(uint(8uL)));
}
