struct float3_ {
    float x;
    float y;
    float z;
};

struct DecltypeRecord_cuda_record_0_ {
    int tag;
    float3_ vector_;
};

struct float1_ {
    float x;
};

struct dim3_ {
    uint x;
    uint y;
    uint z;
};

static const uint GlobalWord = 7u;

RWByteAddressBuffer output : register(u0);

uint global_decltype_value()
{
    return GlobalWord;
}

void old_nullptr_value()
{
    return;
}

int vector_decltype_kind(float1_ value)
{
    float1_ value_1 = (float1_)0;

    value_1 = value;
    return int(2);
}

int copied_decltype_value_int(int value_2)
{
    return value_2;
}

int copied_decltype_value_unsigned(uint value_3)
{
    return int(value_3);
}

float1_ Constructfloat1_(float arg0) {
    float1_ ret = (float1_)0;
    ret.x = arg0;
    return ret;
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(4, 1, 1)]
void decltype_objects(uint3 threadIdx : SV_GroupThreadID)
{
    int source = (int)0;
    int counter = (int)0;
    uint local = (uint)0;
    int mutable_value = (int)0;
    int frozen_value = (int)0;
    int Constant = (int)0;
    int mutable_copy = (int)0;
    int frozen_copy = (int)0;
    int constant_copy = (int)0;
    uint local_1 = (uint)0;
    int local_2 = (int)0;
    uint local_3 = (uint)0;
    int local_4 = (int)0;
    uint local_5 = (uint)0;
    int local_6 = (int)0;
    uint local_7 = (uint)0;
    float1_ one = (float1_)0;
    float1_ one_copy = (float1_)0;
    float2 two = (float2)0;
    float2 two_copy = (float2)0;
    float3_ three = (float3_)0;
    float3_ three_copy = (float3_)0;
    float4 four = (float4)0;
    float4 four_copy = (float4)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    DecltypeRecord_cuda_record_0_ record = (DecltypeRecord_cuda_record_0_)0;
    DecltypeRecord_cuda_record_0_ record_copy = (DecltypeRecord_cuda_record_0_)0;
    DecltypeRecord_cuda_record_0_ records[2] = (DecltypeRecord_cuda_record_0_[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    dim3_ shape = (dim3_)0;
    dim3_ default_shape = (dim3_)0;
    dim3_ explicit_shape = (dim3_)0;
    dim3_ braced_shape = (dim3_)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    int Hidden = (int)0;
    int outer_copy = (int)0;
    uint local_20 = (uint)0;
    float Hidden_1 = (float)0;
    float inner_copy = (float)0;
    uint local_21 = (uint)0;
    int after_copy = (int)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    float1_ singles[2] = (float1_[2])0;
    float3_ triples[2] = (float3_[2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    DecltypeRecord_cuda_record_0_ expression = (DecltypeRecord_cuda_record_0_)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 25u));
    source = int(1);
    counter = asint(asuint(int(lane)) + asuint(int(1)));
    int first = counter;
    counter = asint(asuint(first) + asuint(int(1)));
    int second = counter;
    counter = asint(asuint(second) + asuint(int(1)));
    int third = counter;
    counter = asint(asuint(third) + asuint(int(1)));
    int fourth = counter;
    counter = asint(asuint(fourth) + asuint(int(1)));
    int fifth = counter;
    counter = asint(asuint(fifth) + asuint(int(1)));
    int sixth = counter;
    counter = asint(asuint(sixth) + asuint(int(1)));
    int seventh = counter;
    counter = asint(asuint(seventh) + asuint(int(1)));
    output.Store(base*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(asint(asuint(asint(asuint(asint(asuint(first) + asuint(second))) + asuint(third))) + asuint(fourth))) + asuint(fifth))) + asuint(sixth))) + asuint(seventh)))));
    int _e42 = counter;
    local = uint((base + 1u));
    uint _e48 = local;
    output.Store(_e48*4, asuint(uint(_e42)));
    mutable_value = int(1);
    frozen_value = int(2);
    Constant = int(3);
    mutable_copy = int(4);
    frozen_copy = int(5);
    constant_copy = int(6);
    local_2 = int(1);
    int _e64 = local_2;
    local_1 = uint((base + 2u));
    uint _e70 = local_1;
    output.Store(_e70*4, asuint(uint(_e64)));
    local_4 = int(2);
    int _e74 = local_4;
    local_3 = uint((base + 3u));
    uint _e80 = local_3;
    output.Store(_e80*4, asuint(uint(_e74)));
    local_6 = int(2);
    int _e84 = local_6;
    local_5 = uint((base + 4u));
    uint _e90 = local_5;
    output.Store(_e90*4, asuint(uint(_e84)));
    const uint _e92 = global_decltype_value();
    local_7 = uint((base + 5u));
    uint _e97 = local_7;
    output.Store(_e97*4, asuint(_e92));
    one = Constructfloat1_(2.0);
    one_copy.x = 3.0;
    two = float2(1.0, 2.0);
    two_copy.x = 3.0;
    two_copy.y = 4.0;
    three = Constructfloat3_(1.0, 2.0, 3.0);
    three_copy.x = 4.0;
    three_copy.y = 5.0;
    three_copy.z = 6.0;
    four = float4(1.0, 2.0, 3.0, 4.0);
    four_copy.x = 5.0;
    four_copy.y = 6.0;
    four_copy.z = 7.0;
    four_copy.w = 8.0;
    float _e142 = one_copy.x;
    local_8 = uint((base + 6u));
    uint _e148 = local_8;
    output.Store(_e148*4, asuint(naga_f2u32(_e142)));
    float1_ _e150 = one_copy;
    const int _e151 = vector_decltype_kind(_e150);
    local_9 = uint((base + 7u));
    uint _e157 = local_9;
    output.Store(_e157*4, asuint(uint(_e151)));
    float _e160 = two_copy.y;
    local_10 = uint((base + 8u));
    uint _e166 = local_10;
    output.Store(_e166*4, asuint(naga_f2u32(_e160)));
    float _e169 = three_copy.z;
    local_11 = uint((base + 9u));
    uint _e175 = local_11;
    output.Store(_e175*4, asuint(naga_f2u32(_e169)));
    float _e178 = four_copy.w;
    local_12 = uint((base + 10u));
    uint _e184 = local_12;
    output.Store(_e184*4, asuint(naga_f2u32(_e178)));
    record.tag = int(1);
    record.vector_.x = 2.0;
    record.vector_.y = 3.0;
    record.vector_.z = 4.0;
    record_copy.tag = int(9);
    record_copy.vector_.x = 5.0;
    record_copy.vector_.y = 6.0;
    record_copy.vector_.z = 7.0;
    records[0].tag = int(2);
    records[0].vector_.x = 3.0;
    records[0].vector_.y = 4.0;
    records[0].vector_.z = 5.0;
    records[1].tag = int(6);
    records[1].vector_.x = 7.0;
    records[1].vector_.y = 8.0;
    records[1].vector_.z = 9.0;
    int _e228 = record_copy.tag;
    float _e232 = record_copy.vector_.y;
    local_13 = uint((base + 11u));
    uint _e239 = local_13;
    output.Store(_e239*4, asuint((uint(_e228) + naga_f2u32(_e232))));
    float _e245 = records[int(1)].vector_.z;
    local_14 = uint((base + 12u));
    uint _e251 = local_14;
    output.Store(_e251*4, asuint(naga_f2u32(_e245)));
    shape = Constructdim3_(1u, 1u, 1u);
    default_shape = Constructdim3_(1u, 1u, 1u);
    explicit_shape = Constructdim3_(2u, 3u, 1u);
    braced_shape = Constructdim3_(4u, 5u, 1u);
    uint _e275 = default_shape.y;
    uint _e278 = default_shape.x;
    uint _e281 = default_shape.z;
    local_15 = uint((base + 13u));
    uint _e289 = local_15;
    output.Store(_e289*4, asuint(((_e278 + (10u * _e275)) + (100u * _e281))));
    uint _e293 = explicit_shape.y;
    uint _e296 = explicit_shape.x;
    uint _e299 = explicit_shape.z;
    local_16 = uint((base + 14u));
    uint _e307 = local_16;
    output.Store(_e307*4, asuint(((_e296 + (10u * _e293)) + (100u * _e299))));
    uint _e311 = braced_shape.y;
    uint _e314 = braced_shape.x;
    uint _e317 = braced_shape.z;
    local_17 = uint((base + 15u));
    uint _e325 = local_17;
    output.Store(_e325*4, asuint(((_e314 + (10u * _e311)) + (100u * _e317))));
    const int _e328 = copied_decltype_value_int(int(7));
    local_18 = uint((base + 16u));
    uint _e334 = local_18;
    output.Store(_e334*4, asuint(uint(_e328)));
    const int _e337 = copied_decltype_value_unsigned(9u);
    local_19 = uint((base + 17u));
    uint _e343 = local_19;
    output.Store(_e343*4, asuint(uint(_e337)));
    Hidden = int(3);
    outer_copy = int(4);
    int _e349 = outer_copy;
    local_20 = uint((base + 18u));
    uint _e355 = local_20;
    output.Store(_e355*4, asuint(uint(_e349)));
    {
        Hidden_1 = 2.0;
        inner_copy = 3.0;
        float _e361 = inner_copy;
        local_21 = uint((base + 19u));
        uint _e367 = local_21;
        local_27 = _e367;
        uint _e369 = local_27;
        output.Store(_e369*4, asuint(naga_f2u32(_e361)));
    }
    after_copy = int(5);
    int _e373 = after_copy;
    local_22 = uint((base + 20u));
    uint _e379 = local_22;
    output.Store(_e379*4, asuint(uint(_e373)));
    old_nullptr_value();
    local_23 = uint((base + 21u));
    uint _e387 = local_23;
    output.Store(_e387*4, asuint(uint(true)));
    singles[0].x = 2.0;
    singles[1].x = 5.0;
    triples[0].x = 1.0;
    triples[0].y = 2.0;
    triples[0].z = 3.0;
    triples[1].x = 4.0;
    triples[1].y = 5.0;
    triples[1].z = 6.0;
    float _e414 = singles[int(1)].x;
    local_24 = uint((base + 22u));
    uint _e420 = local_24;
    output.Store(_e420*4, asuint(naga_f2u32(_e414)));
    float _e425 = triples[int(1)].z;
    local_25 = uint((base + 23u));
    uint _e431 = local_25;
    output.Store(_e431*4, asuint(naga_f2u32(_e425)));
    expression.tag = int(10);
    expression.vector_.x = 11.0;
    expression.vector_.y = 12.0;
    expression.vector_.z = 13.0;
    int _e444 = expression.tag;
    float _e448 = expression.vector_.z;
    local_26 = uint((base + 24u));
    uint _e455 = local_26;
    output.Store(_e455*4, asuint((uint(_e444) + naga_f2u32(_e448))));
}
