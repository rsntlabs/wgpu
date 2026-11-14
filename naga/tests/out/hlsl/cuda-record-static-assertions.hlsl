struct float3_ {
    float x;
    float y;
    float z;
};

struct Inner_cuda_record_0_ {
    float3_ vector_;
    int row[3];
};

struct Record_cuda_record_1_ {
    int scalar;
    float3_ vector_;
    int matrix_[2][3];
    Inner_cuda_record_0_ nested;
};

struct Local_cuda_record_2_ {
    uint token;
};

RWByteAddressBuffer output : register(u0);

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(4, 1, 1)]
void record_assertions(uint3 threadIdx : SV_GroupThreadID)
{
    Record_cuda_record_1_ value = (Record_cuda_record_1_)0;
    Local_cuda_record_2_ local = (Local_cuda_record_2_)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;

    uint lane = threadIdx.x;
    value.scalar = int((lane + 3u));
    value.vector_ = Constructfloat3_(1.0, 2.0, float((lane + 5u)));
    value.matrix_[int(1)][int(2)] = int((lane + 9u));
    value.nested.row[int(2)] = int((lane + 15u));
    local.token = (lane + 21u);
    uint index = (4u + (lane * 8u));
    int _e38 = value.scalar;
    output.Store(index*4, asuint(uint(_e38)));
    float _e44 = value.vector_.z;
    local_1 = uint((index + 1u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(naga_f2u32(_e44)));
    int _e57 = value.matrix_[int(1)][int(2)];
    local_2 = uint((index + 2u));
    uint _e63 = local_2;
    output.Store(_e63*4, asuint(uint(_e57)));
    int _e69 = value.nested.row[int(2)];
    local_3 = uint((index + 3u));
    uint _e75 = local_3;
    output.Store(_e75*4, asuint(uint(_e69)));
    local_4 = uint((index + 4u));
    uint _e83 = local_4;
    output.Store(_e83*4, asuint(uint(64uL)));
    local_5 = uint((index + 5u));
    uint _e91 = local_5;
    output.Store(_e91*4, asuint(uint(24uL)));
    local_6 = uint((index + 6u));
    uint _e99 = local_6;
    output.Store(_e99*4, asuint(uint(12uL)));
    uint _e102 = local.token;
    local_7 = uint((index + 7u));
    uint _e107 = local_7;
    output.Store(_e107*4, asuint(_e102));
}
