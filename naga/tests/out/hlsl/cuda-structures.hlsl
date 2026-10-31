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

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
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
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint lane = (uint)0;
    Packet_cuda_record_1_ original = (Packet_cuda_record_1_)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    Packet_cuda_record_1_ changed = (Packet_cuda_record_1_)0;
    Packet_cuda_record_2_ local_4 = (Packet_cuda_record_2_)0;
    Packet_cuda_record_1_ combined = (Packet_cuda_record_1_)0;
    uint slot = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    int sample_ = (int)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    int row = (int)0;
    int column = (int)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    Packet_cuda_record_1_ local_18 = (Packet_cuda_record_1_)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    Packet_cuda_record_1_ local_22 = (Packet_cuda_record_1_)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    lane = threadIdx.x;
    uint _e17 = lane;
    if ((_e17 >= 2u)) {
        return;
    }
    uint _e22[2] = local;
    local_2 = _e22;
    uint _e23 = lane;
    local_3 = uint(_e23);
    uint _e27[2] = local_2;
    local_19 = _e27;
    uint _e28 = local_3;
    uint _e30 = local_19[1];
    local_19[1] = (_e30 + _e28);
    uint _e34 = local_19[0];
    local_20 = uint(_e34);
    uint _e38 = local_19[1];
    local_21 = uint(_e38);
    uint _e42 = local_21;
    Packet_cuda_record_1_ _e44 = ConstructPacket_cuda_record_1_(asuint(input.Load(_e42*80+0)), asfloat(input.Load2(_e42*80+8)), Constructarray2_Sample_cuda_record_0__(ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e42*80+16+0+0+0)), asfloat(input.Load(_e42*80+16+0+0+4)), asfloat(input.Load(_e42*80+16+0+0+8))), asuint(input.Load(_e42*80+16+0+12))), ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input.Load(_e42*80+16+16+0+0)), asfloat(input.Load(_e42*80+16+16+0+4)), asfloat(input.Load(_e42*80+16+16+0+8))), asuint(input.Load(_e42*80+16+16+12)))), Constructarray2_array2_float__(Constructarray2_float_(asfloat(input.Load(_e42*80+48+0+0)), asfloat(input.Load(_e42*80+48+0+4))), Constructarray2_float_(asfloat(input.Load(_e42*80+48+8+0)), asfloat(input.Load(_e42*80+48+8+4)))), asfloat(input.Load4(_e42*80+64)));
    local_22 = _e44;
    Packet_cuda_record_1_ _e45 = local_22;
    local_18 = _e45;
    Packet_cuda_record_1_ _e47 = local_18;
    original = _e47;
    Packet_cuda_record_1_ _e49 = original;
    uint _e50 = lane;
    const Packet_cuda_record_1_ _e54 = adjust(_e49, asint(asuint(int(3)) + asuint(int(_e50))));
    changed = _e54;
    {
        local_4.w = int(7);
        local_4.x = int(11);
        int _e63 = local_4.w;
        int _e64 = local_4.x;
        uint _e71 = changed.samples[int(0)].tag;
        changed.samples[int(0)].tag = (_e71 + uint(asint(asuint(_e63) + asuint(_e64))));
    }
    Packet_cuda_record_1_ _e73 = changed;
    Packet_cuda_record_1_ _e74 = original;
    const Packet_cuda_record_1_ _e75 = operator_u002b(_e73, _e74);
    combined = _e75;
    uint _e78 = original.serial;
    float _e85 = combined.weights[int(0)][int(0)];
    combined.weights[int(0)][int(0)] = (_e85 + float(_e78));
    uint _e88 = combined.serial;
    combined.colour.w = float(_e88);
    uint _e92 = lane;
    slot = (_e92 + 1u);
    uint _e97 = combined.serial;
    uint _e100[2] = local_1;
    local_5 = _e100;
    uint _e101 = slot;
    local_6 = uint(_e101);
    uint _e105[2] = local_5;
    local_23 = _e105;
    uint _e106 = local_6;
    uint _e108 = local_23[1];
    local_23[1] = (_e108 + _e106);
    uint _e112 = local_23[0];
    local_24 = uint(_e112);
    uint _e116 = local_23[1];
    local_25 = uint(_e116);
    uint _e119 = local_25;
    output.Store(0+_e119*80, asuint(_e97));
    float2 _e123 = combined.uv;
    uint _e125[2] = local_1;
    local_7 = _e125;
    uint _e126 = slot;
    local_8 = uint(_e126);
    uint _e130[2] = local_7;
    local_26 = _e130;
    uint _e131 = local_8;
    uint _e133 = local_26[1];
    local_26[1] = (_e133 + _e131);
    uint _e137 = local_26[0];
    local_27 = uint(_e137);
    uint _e141 = local_26[1];
    local_28 = uint(_e141);
    uint _e144 = local_28;
    output.Store2(8+_e144*80, asuint(_e123));
    {
        sample_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e184 = sample_;
                sample_ = asint(asuint(_e184) + asuint(int(1)));
            }
            loop_init = false;
            int _e149 = sample_;
            if ((_e149 < int(2))) {
            } else {
                break;
            }
            int _e153 = sample_;
            Sample_cuda_record_0_ _e155 = combined.samples[min(uint(_e153), 1u)];
            uint _e157[2] = local_1;
            local_9 = _e157;
            uint _e158 = slot;
            local_10 = uint(_e158);
            int _e161 = sample_;
            local_11 = uint(_e161);
            uint _e165[2] = local_9;
            local_29 = _e165;
            uint _e166 = local_10;
            uint _e168 = local_29[1];
            local_29[1] = (_e168 + _e166);
            uint _e172 = local_29[0];
            local_30 = uint(_e172);
            uint _e176 = local_29[1];
            local_31 = uint(_e176);
            uint _e179 = local_31;
            uint _e182 = local_11;
            {
                Sample_cuda_record_0_ _value4 = _e155;
                {
                    float3_ _value5 = _value4.position;
                    output.Store(_e182*16+16+_e179*80+0+0, asuint(_value5.x));
                    output.Store(_e182*16+16+_e179*80+0+4, asuint(_value5.y));
                    output.Store(_e182*16+16+_e179*80+0+8, asuint(_value5.z));
                }
                output.Store(_e182*16+16+_e179*80+12, asuint(_value4.tag));
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
                int _e239 = row;
                row = asint(asuint(_e239) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e189 = row;
            if ((_e189 < int(2))) {
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
                        int _e236 = column;
                        column = asint(asuint(_e236) + asuint(int(1)));
                    }
                    loop_init_2 = false;
                    int _e194 = column;
                    if ((_e194 < int(2))) {
                    } else {
                        break;
                    }
                    int _e198 = row;
                    int _e200 = column;
                    float _e202 = combined.weights[min(uint(_e198), 1u)][min(uint(_e200), 1u)];
                    uint _e204[2] = local_1;
                    local_12 = _e204;
                    uint _e205 = slot;
                    local_13 = uint(_e205);
                    int _e208 = row;
                    local_14 = uint(_e208);
                    int _e211 = column;
                    local_15 = uint(_e211);
                    uint _e215[2] = local_12;
                    local_32 = _e215;
                    uint _e216 = local_13;
                    uint _e218 = local_32[1];
                    local_32[1] = (_e218 + _e216);
                    uint _e222 = local_32[0];
                    local_33 = uint(_e222);
                    uint _e226 = local_32[1];
                    local_34 = uint(_e226);
                    uint _e229 = local_34;
                    uint _e232 = local_14;
                    uint _e234 = local_15;
                    output.Store(_e234*4+_e232*8+48+_e229*80, asuint(_e202));
                }
            }
        }
    }
    float4 _e243 = combined.colour;
    uint _e245[2] = local_1;
    local_16 = _e245;
    uint _e246 = slot;
    local_17 = uint(_e246);
    uint _e250[2] = local_16;
    local_35 = _e250;
    uint _e251 = local_17;
    uint _e253 = local_35[1];
    local_35[1] = (_e253 + _e251);
    uint _e257 = local_35[0];
    local_36 = uint(_e257);
    uint _e261 = local_35[1];
    local_37 = uint(_e261);
    uint _e264 = local_37;
    output.Store4(64+_e264*80, asuint(_e243));
}
