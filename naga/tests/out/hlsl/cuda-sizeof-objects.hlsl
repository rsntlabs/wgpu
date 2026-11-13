struct float3_ {
    float x;
    float y;
    float z;
};

struct Record_cuda_record_0_ {
    float3_ vector_;
    int matrix_[2][3];
};

RWByteAddressBuffer output : register(u0);

[numthreads(64, 1, 1)]
void object_sizes()
{
    float3_ values[2] = (float3_[2])0;
    Record_cuda_record_0_ record = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ records[2] = (Record_cuda_record_0_[2])0;

    output.Store(uint(int(0))*4, asuint(uint(24uL)));
    output.Store(uint(int(1))*4, asuint(uint(12uL)));
    output.Store(uint(int(2))*4, asuint(uint(8uL)));
    output.Store(uint(int(3))*4, asuint(uint(12uL)));
    output.Store(uint(int(4))*4, asuint(uint(24uL)));
    output.Store(uint(int(5))*4, asuint(uint(4uL)));
    output.Store(uint(int(6))*4, asuint(uint(4uL)));
    output.Store(uint(int(7))*4, asuint(uint(12uL)));
    output.Store(uint(int(8))*4, asuint(uint(12uL)));
    output.Store(uint(int(9))*4, asuint(uint(4uL)));
    output.Store(uint(int(10))*4, asuint(uint(36uL)));
    output.Store(uint(int(11))*4, asuint(uint(24uL)));
    output.Store(uint(int(12))*4, asuint(uint(24uL)));
    output.Store(uint(int(13))*4, asuint(uint(12uL)));
    output.Store(uint(int(14))*4, asuint(uint(12uL)));
    output.Store(uint(int(15))*4, asuint(uint(8uL)));
    output.Store(uint(int(16))*4, asuint(uint(1uL)));
    output.Store(uint(int(17))*4, asuint(uint(8uL)));
    output.Store(uint(int(18))*4, asuint(uint(4uL)));
    output.Store(uint(int(19))*4, asuint(uint(4uL)));
    output.Store(uint(int(20))*4, asuint(uint(1uL)));
    output.Store(uint(int(21))*4, asuint(uint(4uL)));
    output.Store(uint(int(22))*4, asuint(uint(8uL)));
    output.Store(uint(int(23))*4, asuint(uint(8uL)));
    output.Store(uint(int(24))*4, asuint(uint(12uL)));
}
