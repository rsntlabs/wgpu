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
    int bias_1 = (int)0;

    value_1 = value;
    bias_1 = bias;
    int _e5 = bias_1;
    uint _e7 = value_1.serial;
    value_1.serial = (_e7 + uint(_e5));
    float _e19 = value_1.weights[int(0)][int(1)];
    float _e20 = value_1.samples[int(1)].position.x;
    value_1.samples[int(1)].position.x = (_e20 + _e19);
    uint _e31 = value_1.samples[int(0)].tag;
    value_1.weights[int(1)][int(0)] = float(_e31);
    Packet_cuda_record_1_ _e33 = value_1;
    const Packet_cuda_record_1_ packet_cuda_record_1_ = _e33;
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
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint lane = (uint)0;
    Packet_cuda_record_1_ original = (Packet_cuda_record_1_)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    Packet_cuda_record_1_ changed = (Packet_cuda_record_1_)0;
    Packet_cuda_record_2_ local_5 = (Packet_cuda_record_2_)0;
    Packet_cuda_record_1_ combined = (Packet_cuda_record_1_)0;
    uint slot = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    int sample_ = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int row = (int)0;
    int column = (int)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    Packet_cuda_record_1_ local_25 = (Packet_cuda_record_1_)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;

    local = 0u;
    local_1 = 0u;
    lane = threadIdx.x;
    uint _e7 = lane;
    if ((_e7 >= 2u)) {
        return;
    }
    uint _e10 = local;
    local_2 = _e10;
    uint _e12 = local_2;
    local_3 = uint(_e12);
    uint _e15 = lane;
    local_4 = uint(_e15);
    uint _e19 = local_3;
    uint _e20 = local_4;
    local_24 = uint((_e19 + _e20));
    uint _e25 = local_24;
    Packet_cuda_record_1_ _e27 = ConstructPacket_cuda_record_1_(asuint(input.Load(_e25*80+0)), asfloat(input.Load2(_e25*80+8)), Constructarray2_Sample_cuda_record_0__(ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e25*80+16+0+0+0)), asfloat(input.Load(_e25*80+16+0+0+4)), asfloat(input.Load(_e25*80+16+0+0+8))), asuint(input.Load(_e25*80+16+0+12))), ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e25*80+16+16+0+0)), asfloat(input.Load(_e25*80+16+16+0+4)), asfloat(input.Load(_e25*80+16+16+0+8))), asuint(input.Load(_e25*80+16+16+12)))), Constructarray2_array2_float__(Constructarray2_float_(asfloat(input.Load(_e25*80+48+0+0)), asfloat(input.Load(_e25*80+48+0+4))), Constructarray2_float_(asfloat(input.Load(_e25*80+48+8+0)), asfloat(input.Load(_e25*80+48+8+4)))), asfloat(input.Load4(_e25*80+64)));
    local_25 = _e27;
    Packet_cuda_record_1_ _e28 = local_25;
    original = _e28;
    Packet_cuda_record_1_ _e30 = original;
    uint _e31 = lane;
    const Packet_cuda_record_1_ _e35 = adjust(_e30, asint(asuint(int(3)) + asuint(int(_e31))));
    changed = _e35;
    {
        local_5.w = int(7);
        local_5.x = int(11);
        int _e44 = local_5.w;
        int _e45 = local_5.x;
        uint _e52 = changed.samples[int(0)].tag;
        changed.samples[int(0)].tag = (_e52 + uint(asint(asuint(_e44) + asuint(_e45))));
    }
    Packet_cuda_record_1_ _e54 = changed;
    Packet_cuda_record_1_ _e55 = original;
    const Packet_cuda_record_1_ _e56 = operator_u002b(_e54, _e55);
    combined = _e56;
    uint _e59 = original.serial;
    float _e66 = combined.weights[int(0)][int(0)];
    combined.weights[int(0)][int(0)] = (_e66 + float(_e59));
    uint _e69 = combined.serial;
    combined.colour.w = float(_e69);
    uint _e73 = lane;
    slot = (_e73 + 1u);
    uint _e78 = combined.serial;
    uint _e79 = local_1;
    local_6 = _e79;
    uint _e81 = local_6;
    local_7 = uint(_e81);
    uint _e84 = slot;
    local_8 = uint(_e84);
    uint _e88 = local_7;
    uint _e89 = local_8;
    local_26 = uint((_e88 + _e89));
    uint _e93 = local_26;
    output.Store(0+_e93*80, asuint(_e78));
    float2 _e97 = combined.uv;
    uint _e98 = local_1;
    local_9 = _e98;
    uint _e100 = local_9;
    local_10 = uint(_e100);
    uint _e103 = slot;
    local_11 = uint(_e103);
    uint _e106 = local_10;
    uint _e107 = local_11;
    local_27 = uint((_e106 + _e107));
    uint _e111 = local_27;
    output.Store2(8+_e111*80, asuint(_e97));
    {
        sample_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e144 = sample_;
                sample_ = asint(asuint(_e144) + asuint(int(1)));
            }
            loop_init = false;
            int _e116 = sample_;
            if ((_e116 < int(2))) {
            } else {
                break;
            }
            int _e120 = sample_;
            Sample_cuda_record_0_ _e122 = combined.samples[min(uint(_e120), 1u)];
            uint _e123 = local_1;
            local_12 = _e123;
            uint _e125 = local_12;
            local_13 = uint(_e125);
            uint _e128 = slot;
            local_14 = uint(_e128);
            int _e131 = sample_;
            local_15 = uint(_e131);
            uint _e134 = local_13;
            uint _e135 = local_14;
            local_28 = uint((_e134 + _e135));
            uint _e139 = local_28;
            uint _e142 = local_15;
            {
                Sample_cuda_record_0_ _value4 = _e122;
                {
                    float3_ _value5 = _value4.position;
                    output.Store(_e142*16+16+_e139*80+0+0, asuint(_value5.x));
                    output.Store(_e142*16+16+_e139*80+0+4, asuint(_value5.y));
                    output.Store(_e142*16+16+_e139*80+0+8, asuint(_value5.z));
                }
                output.Store(_e142*16+16+_e139*80+12, asuint(_value4.tag));
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
                int _e192 = row;
                row = asint(asuint(_e192) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e149 = row;
            if ((_e149 < int(2))) {
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
                        int _e189 = column;
                        column = asint(asuint(_e189) + asuint(int(1)));
                    }
                    loop_init_2 = false;
                    int _e154 = column;
                    if ((_e154 < int(2))) {
                    } else {
                        break;
                    }
                    int _e158 = row;
                    int _e160 = column;
                    float _e162 = combined.weights[min(uint(_e158), 1u)][min(uint(_e160), 1u)];
                    uint _e163 = local_1;
                    local_16 = _e163;
                    uint _e165 = local_16;
                    local_17 = uint(_e165);
                    uint _e168 = slot;
                    local_18 = uint(_e168);
                    int _e171 = row;
                    local_19 = uint(_e171);
                    int _e174 = column;
                    local_20 = uint(_e174);
                    uint _e177 = local_17;
                    uint _e178 = local_18;
                    local_29 = uint((_e177 + _e178));
                    uint _e182 = local_29;
                    uint _e185 = local_19;
                    uint _e187 = local_20;
                    output.Store(_e187*4+_e185*8+48+_e182*80, asuint(_e162));
                }
            }
        }
    }
    float4 _e196 = combined.colour;
    uint _e197 = local_1;
    local_21 = _e197;
    uint _e199 = local_21;
    local_22 = uint(_e199);
    uint _e202 = slot;
    local_23 = uint(_e202);
    uint _e205 = local_22;
    uint _e206 = local_23;
    local_30 = uint((_e205 + _e206));
    uint _e210 = local_30;
    output.Store4(64+_e210*80, asuint(_e196));
}
