struct Pair_cuda_record_0_ {
    uint low;
    uint high;
};

struct PacketTag_cuda_record_1_ {
    Pair_cuda_record_0_ pair;
    uint samples[2];
};

struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct Bias_cuda_record_2_ {
    uint value;
};

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer count : register(b2) { type_3 count; }
RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer count_1 : register(b2) { type_3 count_1; }
RWByteAddressBuffer output_2 : register(u0);
ByteAddressBuffer input_2 : register(t1);
cbuffer count_2 : register(b2) { type_3 count_2; }

Pair_cuda_record_0_ rotated_pair(Pair_cuda_record_0_ value)
{
    Pair_cuda_record_0_ value_1 = (Pair_cuda_record_0_)0;
    Pair_cuda_record_0_ local_14 = (Pair_cuda_record_0_)0;

    value_1 = value;
    uint _e4 = value_1.high;
    local_14.low = _e4;
    uint _e8 = value_1.low;
    local_14.high = _e8;
    Pair_cuda_record_0_ _e9 = local_14;
    const Pair_cuda_record_0_ pair_cuda_record_0_ = _e9;
    return pair_cuda_record_0_;
}

Pair_cuda_record_0_ ConstructPair_cuda_record_0_(uint arg0, uint arg1) {
    Pair_cuda_record_0_ ret = (Pair_cuda_record_0_)0;
    ret.low = arg0;
    ret.high = arg1;
    return ret;
}

[numthreads(4, 1, 1)]
void copy_records_Pair(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    Pair_cuda_record_0_ local_2 = (Pair_cuda_record_0_)0;
    uint local_3 = (uint)0;
    Pair_cuda_record_0_ local_4 = (Pair_cuda_record_0_)0;
    uint local_5 = (uint)0;

    uint count_3 = count_1.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index < count_3)) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        Pair_cuda_record_0_ _e17 = ConstructPair_cuda_record_0_(asuint(input_1.Load(_e14*8+0)), asuint(input_1.Load(_e14*8+4)));
        local_4 = _e17;
        Pair_cuda_record_0_ _e19 = local_4;
        local_2 = _e19;
        Pair_cuda_record_0_ _e21 = local_2;
        local = index;
        uint _e23 = local;
        local_5 = _e23;
        uint _e25 = local_5;
        {
            Pair_cuda_record_0_ _value3 = _e21;
            output_1.Store(_e25*8+0, asuint(_value3.low));
            output_1.Store(_e25*8+4, asuint(_value3.high));
        }
    }
}

typedef uint ret_Constructarray2_uint_[2];
ret_Constructarray2_uint_ Constructarray2_uint_(uint arg0, uint arg1) {
    uint ret[2] = { arg0, arg1 };
    return ret;
}

PacketTag_cuda_record_1_ ConstructPacketTag_cuda_record_1_(Pair_cuda_record_0_ arg0, uint arg1[2]) {
    PacketTag_cuda_record_1_ ret = (PacketTag_cuda_record_1_)0;
    ret.pair = arg0;
    ret.samples = arg1;
    return ret;
}

[numthreads(4, 1, 1)]
void copy_records_PacketTag(uint3 blockIdx_1 : SV_GroupID, uint3 threadIdx_1 : SV_GroupThreadID)
{
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    PacketTag_cuda_record_1_ local_8 = (PacketTag_cuda_record_1_)0;
    uint local_9 = (uint)0;
    PacketTag_cuda_record_1_ local_10 = (PacketTag_cuda_record_1_)0;
    uint local_11 = (uint)0;

    uint count_4 = count_2.value;
    uint index_1 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if ((index_1 < count_4)) {
        local_7 = index_1;
        uint _e12 = local_7;
        local_9 = _e12;
        uint _e14 = local_9;
        PacketTag_cuda_record_1_ _e17 = ConstructPacketTag_cuda_record_1_(ConstructPair_cuda_record_0_(asuint(input_2.Load(_e14*16+0+0)), asuint(input_2.Load(_e14*16+0+4))), Constructarray2_uint_(asuint(input_2.Load(_e14*16+8+0)), asuint(input_2.Load(_e14*16+8+4))));
        local_10 = _e17;
        PacketTag_cuda_record_1_ _e19 = local_10;
        local_8 = _e19;
        PacketTag_cuda_record_1_ _e21 = local_8;
        local_6 = index_1;
        uint _e23 = local_6;
        local_11 = _e23;
        uint _e25 = local_11;
        {
            PacketTag_cuda_record_1_ _value3 = _e21;
            {
                Pair_cuda_record_0_ _value4 = _value3.pair;
                output_2.Store(_e25*16+0+0, asuint(_value4.low));
                output_2.Store(_e25*16+0+4, asuint(_value4.high));
            }
            {
                uint _value4[2] = _value3.samples;
                output_2.Store(_e25*16+8+0, asuint(_value4[0]));
                output_2.Store(_e25*16+8+4, asuint(_value4[1]));
            }
        }
    }
}

[numthreads(4, 1, 1)]
void transform_records(uint3 blockIdx_2 : SV_GroupID, uint3 threadIdx_2 : SV_GroupThreadID)
{
    Bias_cuda_record_2_ bias = (Bias_cuda_record_2_)0;
    PacketTag_cuda_record_1_ packet = (PacketTag_cuda_record_1_)0;
    PacketTag_cuda_record_1_ local_12 = (PacketTag_cuda_record_1_)0;
    PacketTag_cuda_record_1_ local_13 = (PacketTag_cuda_record_1_)0;

    uint count_5 = count.value;
    uint index_2 = ((blockIdx_2.x * 4u) + threadIdx_2.x);
    if ((index_2 >= count_5)) {
        return;
    }
    bias.value = (index_2 + 1u);
    PacketTag_cuda_record_1_ _e17 = ConstructPacketTag_cuda_record_1_(ConstructPair_cuda_record_0_(asuint(input.Load(index_2*16+0+0)), asuint(input.Load(index_2*16+0+4))), Constructarray2_uint_(asuint(input.Load(index_2*16+8+0)), asuint(input.Load(index_2*16+8+4))));
    local_13 = _e17;
    PacketTag_cuda_record_1_ _e19 = local_13;
    local_12 = _e19;
    PacketTag_cuda_record_1_ _e21 = local_12;
    packet = _e21;
    Pair_cuda_record_0_ _e24 = packet.pair;
    const Pair_cuda_record_0_ _e25 = rotated_pair(_e24);
    packet.pair = _e25;
    uint _e28 = bias.value;
    uint _e32 = packet.samples[int(0)];
    packet.samples[int(0)] = (_e32 + _e28);
    uint _e37 = packet.samples[int(1)];
    packet.samples[int(1)] = (_e37 ^ 2779077210u);
    PacketTag_cuda_record_1_ _e40 = packet;
    {
        PacketTag_cuda_record_1_ _value2 = _e40;
        {
            Pair_cuda_record_0_ _value3 = _value2.pair;
            output.Store(index_2*16+0+0, asuint(_value3.low));
            output.Store(index_2*16+0+4, asuint(_value3.high));
        }
        {
            uint _value3[2] = _value2.samples;
            output.Store(index_2*16+8+0, asuint(_value3[0]));
            output.Store(index_2*16+8+4, asuint(_value3[1]));
        }
    }
}
