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

ByteAddressBuffer input_1 : register(t0);
RWByteAddressBuffer output_1 : register(u1);

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
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
    Packet_cuda_record_1_ original = (Packet_cuda_record_1_)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    Packet_cuda_record_1_ changed = (Packet_cuda_record_1_)0;
    Packet_cuda_record_2_ local_2 = (Packet_cuda_record_2_)0;
    Packet_cuda_record_1_ combined = (Packet_cuda_record_1_)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    int sample_ = (int)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int row = (int)0;
    int column = (int)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    Packet_cuda_record_1_ local_16 = (Packet_cuda_record_1_)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    Packet_cuda_record_1_ local_20 = (Packet_cuda_record_1_)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;

    input = ZeroValuearray2_uint_();
    input[0] = 0u;
    input[1] = 0u;
    output = ZeroValuearray2_uint_();
    output[0] = 1u;
    output[1] = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint _e17[2] = input;
    local = _e17;
    local_1 = uint(lane);
    uint _e21[2] = local;
    local_17 = _e21;
    uint _e23 = local_1;
    uint _e25 = local_17[1];
    local_17[1] = (_e25 + _e23);
    uint _e29 = local_17[0];
    local_18 = uint(_e29);
    uint _e33 = local_17[1];
    local_19 = uint(_e33);
    uint _e36 = local_19;
    Packet_cuda_record_1_ _e39 = ConstructPacket_cuda_record_1_(asuint(input_1.Load(_e36*80+0)), asfloat(input_1.Load2(_e36*80+8)), Constructarray2_Sample_cuda_record_0__(ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input_1.Load(_e36*80+16+0+0+0)), asfloat(input_1.Load(_e36*80+16+0+0+4)), asfloat(input_1.Load(_e36*80+16+0+0+8))), asuint(input_1.Load(_e36*80+16+0+12))), ConstructSample_cuda_record_0_(Constructfloat3_(asfloat(input_1.Load(_e36*80+16+16+0+0)), asfloat(input_1.Load(_e36*80+16+16+0+4)), asfloat(input_1.Load(_e36*80+16+16+0+8))), asuint(input_1.Load(_e36*80+16+16+12)))), Constructarray2_array2_float__(Constructarray2_float_(asfloat(input_1.Load(_e36*80+48+0+0)), asfloat(input_1.Load(_e36*80+48+0+4))), Constructarray2_float_(asfloat(input_1.Load(_e36*80+48+8+0)), asfloat(input_1.Load(_e36*80+48+8+4)))), asfloat(input_1.Load4(_e36*80+64)));
    local_20 = _e39;
    Packet_cuda_record_1_ _e41 = local_20;
    local_16 = _e41;
    Packet_cuda_record_1_ _e43 = local_16;
    original = _e43;
    Packet_cuda_record_1_ _e45 = original;
    const Packet_cuda_record_1_ _e49 = adjust(_e45, asint(asuint(int(3)) + asuint(int(lane))));
    changed = _e49;
    {
        local_2.w = int(7);
        local_2.x = int(11);
        int _e58 = local_2.w;
        int _e59 = local_2.x;
        uint _e66 = changed.samples[int(0)].tag;
        changed.samples[int(0)].tag = (_e66 + uint(asint(asuint(_e58) + asuint(_e59))));
    }
    Packet_cuda_record_1_ _e68 = changed;
    Packet_cuda_record_1_ _e69 = original;
    const Packet_cuda_record_1_ _e70 = operator_u002b(_e68, _e69);
    combined = _e70;
    uint _e73 = original.serial;
    float _e80 = combined.weights[int(0)][int(0)];
    combined.weights[int(0)][int(0)] = (_e80 + float(_e73));
    uint _e83 = combined.serial;
    combined.colour.w = float(_e83);
    uint slot = (lane + 1u);
    uint _e90 = combined.serial;
    uint _e92[2] = output;
    local_3 = _e92;
    local_4 = uint(slot);
    uint _e96[2] = local_3;
    local_21 = _e96;
    uint _e98 = local_4;
    uint _e100 = local_21[1];
    local_21[1] = (_e100 + _e98);
    uint _e104 = local_21[0];
    local_22 = uint(_e104);
    uint _e108 = local_21[1];
    local_23 = uint(_e108);
    uint _e111 = local_23;
    output_1.Store(0+_e111*80, asuint(_e90));
    float2 _e116 = combined.uv;
    uint _e117[2] = output;
    local_5 = _e117;
    local_6 = uint(slot);
    uint _e121[2] = local_5;
    local_24 = _e121;
    uint _e123 = local_6;
    uint _e125 = local_24[1];
    local_24[1] = (_e125 + _e123);
    uint _e129 = local_24[0];
    local_25 = uint(_e129);
    uint _e133 = local_24[1];
    local_26 = uint(_e133);
    uint _e136 = local_26;
    output_1.Store2(8+_e136*80, asuint(_e116));
    {
        sample_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e175 = sample_;
                sample_ = asint(asuint(_e175) + asuint(int(1)));
            }
            loop_init = false;
            int _e141 = sample_;
            if ((_e141 < int(2))) {
            } else {
                break;
            }
            int _e145 = sample_;
            Sample_cuda_record_0_ _e147 = combined.samples[min(uint(_e145), 1u)];
            uint _e148[2] = output;
            local_7 = _e148;
            local_8 = uint(slot);
            int _e152 = sample_;
            local_9 = uint(_e152);
            uint _e155[2] = local_7;
            local_27 = _e155;
            uint _e157 = local_8;
            uint _e159 = local_27[1];
            local_27[1] = (_e159 + _e157);
            uint _e163 = local_27[0];
            local_28 = uint(_e163);
            uint _e167 = local_27[1];
            local_29 = uint(_e167);
            uint _e170 = local_29;
            uint _e173 = local_9;
            {
                Sample_cuda_record_0_ _value4 = _e147;
                {
                    float3_ _value5 = _value4.position;
                    output_1.Store(_e173*16+16+_e170*80+0+0, asuint(_value5.x));
                    output_1.Store(_e173*16+16+_e170*80+0+4, asuint(_value5.y));
                    output_1.Store(_e173*16+16+_e170*80+0+8, asuint(_value5.z));
                }
                output_1.Store(_e173*16+16+_e170*80+12, asuint(_value4.tag));
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
                int _e229 = row;
                row = asint(asuint(_e229) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e180 = row;
            if ((_e180 < int(2))) {
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
                        int _e226 = column;
                        column = asint(asuint(_e226) + asuint(int(1)));
                    }
                    loop_init_2 = false;
                    int _e185 = column;
                    if ((_e185 < int(2))) {
                    } else {
                        break;
                    }
                    int _e189 = row;
                    int _e191 = column;
                    float _e193 = combined.weights[min(uint(_e189), 1u)][min(uint(_e191), 1u)];
                    uint _e194[2] = output;
                    local_10 = _e194;
                    local_11 = uint(slot);
                    int _e198 = row;
                    local_12 = uint(_e198);
                    int _e201 = column;
                    local_13 = uint(_e201);
                    uint _e204[2] = local_10;
                    local_30 = _e204;
                    uint _e206 = local_11;
                    uint _e208 = local_30[1];
                    local_30[1] = (_e208 + _e206);
                    uint _e212 = local_30[0];
                    local_31 = uint(_e212);
                    uint _e216 = local_30[1];
                    local_32 = uint(_e216);
                    uint _e219 = local_32;
                    uint _e222 = local_12;
                    uint _e224 = local_13;
                    output_1.Store(_e224*4+_e222*8+48+_e219*80, asuint(_e193));
                }
            }
        }
    }
    float4 _e233 = combined.colour;
    uint _e234[2] = output;
    local_14 = _e234;
    local_15 = uint(slot);
    uint _e238[2] = local_14;
    local_33 = _e238;
    uint _e240 = local_15;
    uint _e242 = local_33[1];
    local_33[1] = (_e242 + _e240);
    uint _e246 = local_33[0];
    local_34 = uint(_e246);
    uint _e250 = local_33[1];
    local_35 = uint(_e250);
    uint _e253 = local_35;
    output_1.Store4(64+_e253*80, asuint(_e233));
}
