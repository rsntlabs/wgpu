struct float3_ {
    float x;
    float y;
    float z;
};

struct Sample_cuda_record_0_ {
    float3_ position;
    uint tag;
};

struct Packet_cuda_record_1_ {
    uint serial;
    int _pad1_0;
    float2 uv;
    Sample_cuda_record_0_ samples[2];
    float weights[2][2];
    float4 colour;
};

struct Packet_cuda_record_2_ {
    int w;
    int x;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

Packet_cuda_record_1_ adjust(Packet_cuda_record_1_ value, int bias)
{
    Packet_cuda_record_1_ value_1 = (Packet_cuda_record_1_)0;

    value_1 = value;
    uint _e5 = value_1.serial;
    value_1.serial = (_e5 + uint(bias));
    float _e12 = value_1.weights[int(0)][int(1)];
    float _e18 = value_1.samples[int(1)].position.x;
    value_1.samples[int(1)].position.x = (_e18 + _e12);
    uint _e24 = value_1.samples[int(0)].tag;
    value_1.weights[int(1)][int(0)] = float(_e24);
    Packet_cuda_record_1_ _e31 = value_1;
    const Packet_cuda_record_1_ packet_cuda_record_1_ = _e31;
    return packet_cuda_record_1_;
}

Packet_cuda_record_1_ operator_u002b(Packet_cuda_record_1_ left, Packet_cuda_record_1_ right)
{
    Packet_cuda_record_1_ left_1 = (Packet_cuda_record_1_)0;
    Packet_cuda_record_1_ right_1 = (Packet_cuda_record_1_)0;

    left_1 = left;
    right_1 = right;
    uint _e6 = right_1.serial;
    uint _e7 = left_1.serial;
    left_1.serial = (_e7 + _e6);
    float _e13 = right_1.uv.y;
    float _e14 = left_1.uv.x;
    left_1.uv.x = (_e14 + _e13);
    Packet_cuda_record_1_ _e16 = left_1;
    const Packet_cuda_record_1_ packet_cuda_record_1_1 = _e16;
    return packet_cuda_record_1_1;
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

Sample_cuda_record_0_ ConstructSample_cuda_record_0_(float3_ arg0, uint arg1) {
    Sample_cuda_record_0_ ret = (Sample_cuda_record_0_)0;
    ret.position = arg0;
    ret.tag = arg1;
    return ret;
}

typedef Sample_cuda_record_0_ ret_Constructarray2_Sample_cuda_record_0__[2];
ret_Constructarray2_Sample_cuda_record_0__ Constructarray2_Sample_cuda_record_0__(Sample_cuda_record_0_ arg0, Sample_cuda_record_0_ arg1) {
    Sample_cuda_record_0_ ret[2] = { arg0, arg1 };
    return ret;
}

typedef float ret_Constructarray2_float_[2];
ret_Constructarray2_float_ Constructarray2_float_(float arg0, float arg1) {
    float ret[2] = { arg0, arg1 };
    return ret;
}

typedef float ret_Constructarray2_array2_float__[2][2];
ret_Constructarray2_array2_float__ Constructarray2_array2_float__(float arg0[2], float arg1[2]) {
    float ret[2][2] = { arg0, arg1 };
    return ret;
}

Packet_cuda_record_1_ ConstructPacket_cuda_record_1_(uint arg0, float2 arg1, Sample_cuda_record_0_ arg2[2], float arg3[2][2], float4 arg4) {
    Packet_cuda_record_1_ ret = (Packet_cuda_record_1_)0;
    ret.serial = arg0;
    ret.uv = arg1;
    ret.samples = arg2;
    ret.weights = arg3;
    ret.colour = arg4;
    return ret;
}

[numthreads(2, 1, 1)]
void structures(uint3 threadIdx : SV_GroupThreadID)
{
    Packet_cuda_record_1_ original = (Packet_cuda_record_1_)0;
    Packet_cuda_record_1_ changed = (Packet_cuda_record_1_)0;
    Packet_cuda_record_2_ local = (Packet_cuda_record_2_)0;
    Packet_cuda_record_1_ combined = (Packet_cuda_record_1_)0;
    int sample_ = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int row = (int)0;
    int column = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    Packet_cuda_record_1_ local_6 = (Packet_cuda_record_1_)0;
    Packet_cuda_record_1_ local_7 = (Packet_cuda_record_1_)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;

    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    Packet_cuda_record_1_ _e6 = ConstructPacket_cuda_record_1_(asuint(input.Load(lane*80+0)), asfloat(input.Load2(lane*80+8)), Constructarray2_Sample_cuda_record_0__(ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(lane*80+16+0+0+0)), asfloat(input.Load(lane*80+16+0+0+4)), asfloat(input.Load(lane*80+16+0+0+8))), asuint(input.Load(lane*80+16+0+12))), ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(lane*80+16+16+0+0)), asfloat(input.Load(lane*80+16+16+0+4)), asfloat(input.Load(lane*80+16+16+0+8))), asuint(input.Load(lane*80+16+16+12)))), Constructarray2_array2_float__(Constructarray2_float_(asfloat(input.Load(lane*80+48+0+0)), asfloat(input.Load(lane*80+48+0+4))), Constructarray2_float_(asfloat(input.Load(lane*80+48+8+0)), asfloat(input.Load(lane*80+48+8+4)))), asfloat(input.Load4(lane*80+64)));
    local_7 = _e6;
    Packet_cuda_record_1_ _e8 = local_7;
    local_6 = _e8;
    Packet_cuda_record_1_ _e10 = local_6;
    original = _e10;
    Packet_cuda_record_1_ _e12 = original;
    const Packet_cuda_record_1_ _e16 = adjust(_e12, asint(asuint(int(3)) + asuint(int(lane))));
    changed = _e16;
    {
        local.w = int(7);
        local.x = int(11);
        int _e25 = local.w;
        int _e26 = local.x;
        uint _e33 = changed.samples[int(0)].tag;
        changed.samples[int(0)].tag = (_e33 + uint(asint(asuint(_e25) + asuint(_e26))));
    }
    Packet_cuda_record_1_ _e35 = changed;
    Packet_cuda_record_1_ _e36 = original;
    const Packet_cuda_record_1_ _e37 = operator_u002b(_e35, _e36);
    combined = _e37;
    uint _e40 = original.serial;
    float _e47 = combined.weights[int(0)][int(0)];
    combined.weights[int(0)][int(0)] = (_e47 + float(_e40));
    uint _e50 = combined.serial;
    combined.colour.w = float(_e50);
    uint slot = (lane + 1u);
    uint _e57 = combined.serial;
    output.Store(0+slot*80, asuint(_e57));
    float2 _e62 = combined.uv;
    output.Store2(8+slot*80, asuint(_e62));
    {
        sample_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e85 = sample_;
                sample_ = asint(asuint(_e85) + asuint(int(1)));
            }
            loop_init = false;
            int _e67 = sample_;
            if ((_e67 < int(2))) {
            } else {
                break;
            }
            int _e71 = sample_;
            Sample_cuda_record_0_ _e73 = combined.samples[min(uint(_e71), 1u)];
            local_1 = slot;
            int _e75 = sample_;
            local_2 = uint(_e75);
            uint _e78 = local_1;
            local_8 = _e78;
            uint _e80 = local_8;
            uint _e83 = local_2;
            {
                Sample_cuda_record_0_ _value4 = _e73;
                {
                    float3_ _value5 = _value4.position;
                    output.Store(_e83*16+16+_e80*80+0+0, asuint(_value5.x));
                    output.Store(_e83*16+16+_e80*80+0+4, asuint(_value5.y));
                    output.Store(_e83*16+16+_e80*80+0+8, asuint(_value5.z));
                }
                output.Store(_e83*16+16+_e80*80+12, asuint(_value4.tag));
            }
        }
    }
    {
        row = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e123 = row;
                row = asint(asuint(_e123) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e90 = row;
            if ((_e90 < int(2))) {
            } else {
                break;
            }
            {
                column = int(0);
                uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
                bool loop_init_2 = true;
                while(true) {
                    if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                    loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                    if (!loop_init_2) {
                        int _e120 = column;
                        column = asint(asuint(_e120) + asuint(int(1)));
                    }
                    loop_init_2 = false;
                    int _e95 = column;
                    if ((_e95 < int(2))) {
                    } else {
                        break;
                    }
                    int _e99 = row;
                    int _e101 = column;
                    float _e103 = combined.weights[min(uint(_e99), 1u)][min(uint(_e101), 1u)];
                    local_3 = slot;
                    int _e105 = row;
                    local_4 = uint(_e105);
                    int _e108 = column;
                    local_5 = uint(_e108);
                    uint _e111 = local_3;
                    local_9 = _e111;
                    uint _e113 = local_9;
                    uint _e116 = local_4;
                    uint _e118 = local_5;
                    output.Store(_e118*4+_e116*8+48+_e113*80, asuint(_e103));
                }
            }
        }
    }
    float4 _e127 = combined.colour;
    output.Store4(64+slot*80, asuint(_e127));
}
