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
    uint local = (uint)0;
    Packet_cuda_record_1_ changed = (Packet_cuda_record_1_)0;
    Packet_cuda_record_2_ local_1 = (Packet_cuda_record_2_)0;
    Packet_cuda_record_1_ combined = (Packet_cuda_record_1_)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int sample_ = (int)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int row = (int)0;
    int column = (int)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    Packet_cuda_record_1_ local_10 = (Packet_cuda_record_1_)0;
    uint local_11 = (uint)0;
    Packet_cuda_record_1_ local_12 = (Packet_cuda_record_1_)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;

    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    local = uint(lane);
    uint _e6 = local;
    local_11 = uint(_e6);
    uint _e9 = local_11;
    Packet_cuda_record_1_ _e12 = ConstructPacket_cuda_record_1_(asuint(input.Load(_e9*80+0)), asfloat(input.Load2(_e9*80+8)), Constructarray2_Sample_cuda_record_0__(ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e9*80+16+0+0+0)), asfloat(input.Load(_e9*80+16+0+0+4)), asfloat(input.Load(_e9*80+16+0+0+8))), asuint(input.Load(_e9*80+16+0+12))), ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e9*80+16+16+0+0)), asfloat(input.Load(_e9*80+16+16+0+4)), asfloat(input.Load(_e9*80+16+16+0+8))), asuint(input.Load(_e9*80+16+16+12)))), Constructarray2_array2_float__(Constructarray2_float_(asfloat(input.Load(_e9*80+48+0+0)), asfloat(input.Load(_e9*80+48+0+4))), Constructarray2_float_(asfloat(input.Load(_e9*80+48+8+0)), asfloat(input.Load(_e9*80+48+8+4)))), asfloat(input.Load4(_e9*80+64)));
    local_12 = _e12;
    Packet_cuda_record_1_ _e14 = local_12;
    local_10 = _e14;
    Packet_cuda_record_1_ _e16 = local_10;
    original = _e16;
    Packet_cuda_record_1_ _e18 = original;
    const Packet_cuda_record_1_ _e22 = adjust(_e18, asint(asuint(int(3)) + asuint(int(lane))));
    changed = _e22;
    {
        local_1.w = int(7);
        local_1.x = int(11);
        int _e31 = local_1.w;
        int _e32 = local_1.x;
        uint _e39 = changed.samples[int(0)].tag;
        changed.samples[int(0)].tag = (_e39 + uint(asint(asuint(_e31) + asuint(_e32))));
    }
    Packet_cuda_record_1_ _e41 = changed;
    Packet_cuda_record_1_ _e42 = original;
    const Packet_cuda_record_1_ _e43 = operator_u002b(_e41, _e42);
    combined = _e43;
    uint _e46 = original.serial;
    float _e53 = combined.weights[int(0)][int(0)];
    combined.weights[int(0)][int(0)] = (_e53 + float(_e46));
    uint _e56 = combined.serial;
    combined.colour.w = float(_e56);
    uint slot = (lane + 1u);
    uint _e63 = combined.serial;
    local_2 = uint(slot);
    uint _e66 = local_2;
    local_13 = uint(_e66);
    uint _e69 = local_13;
    output.Store(0+_e69*80, asuint(_e63));
    float2 _e74 = combined.uv;
    local_3 = uint(slot);
    uint _e77 = local_3;
    local_14 = uint(_e77);
    uint _e80 = local_14;
    output.Store2(8+_e80*80, asuint(_e74));
    {
        sample_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e105 = sample_;
                sample_ = asint(asuint(_e105) + asuint(int(1)));
            }
            loop_init = false;
            int _e85 = sample_;
            if ((_e85 < int(2))) {
            } else {
                break;
            }
            int _e89 = sample_;
            Sample_cuda_record_0_ _e91 = combined.samples[min(uint(_e89), 1u)];
            local_4 = uint(slot);
            int _e94 = sample_;
            local_5 = uint(_e94);
            uint _e97 = local_4;
            local_15 = uint(_e97);
            uint _e100 = local_15;
            uint _e103 = local_5;
            {
                Sample_cuda_record_0_ _value4 = _e91;
                {
                    float3_ _value5 = _value4.position;
                    output.Store(_e103*16+16+_e100*80+0+0, asuint(_value5.x));
                    output.Store(_e103*16+16+_e100*80+0+4, asuint(_value5.y));
                    output.Store(_e103*16+16+_e100*80+0+8, asuint(_value5.z));
                }
                output.Store(_e103*16+16+_e100*80+12, asuint(_value4.tag));
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
                int _e145 = row;
                row = asint(asuint(_e145) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e110 = row;
            if ((_e110 < int(2))) {
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
                        int _e142 = column;
                        column = asint(asuint(_e142) + asuint(int(1)));
                    }
                    loop_init_2 = false;
                    int _e115 = column;
                    if ((_e115 < int(2))) {
                    } else {
                        break;
                    }
                    int _e119 = row;
                    int _e121 = column;
                    float _e123 = combined.weights[min(uint(_e119), 1u)][min(uint(_e121), 1u)];
                    local_6 = uint(slot);
                    int _e126 = row;
                    local_7 = uint(_e126);
                    int _e129 = column;
                    local_8 = uint(_e129);
                    uint _e132 = local_6;
                    local_16 = uint(_e132);
                    uint _e135 = local_16;
                    uint _e138 = local_7;
                    uint _e140 = local_8;
                    output.Store(_e140*4+_e138*8+48+_e135*80, asuint(_e123));
                }
            }
        }
    }
    float4 _e149 = combined.colour;
    local_9 = uint(slot);
    uint _e152 = local_9;
    local_17 = uint(_e152);
    uint _e155 = local_17;
    output.Store4(64+_e155*80, asuint(_e149));
}
