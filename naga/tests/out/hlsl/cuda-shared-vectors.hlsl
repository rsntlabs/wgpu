struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer output_1 : register(u0);
groupshared float3_ values[8];
groupshared float3_ broadcast;

float3_ shift(float3_ value)
{
    float3_ value_1 = (float3_)0;

    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = (_e4 + 1.0);
    float _e9 = value_1.z;
    float _e10 = value_1.y;
    value_1.y = (_e9 - _e10);
    float3_ _e12 = value_1;
    const float3_ float3_1 = _e12;
    return float3_1;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(8, 1, 1)]
void shared_vectors(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (float3_[8])0;
        broadcast = (float3_)0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output[2] = (uint[2])0;
    float3_ copied = (float3_)0;
    int offset = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
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
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 0u;
    output[1] = 0u;
    uint lane = threadIdx.x;
    uint group = blockIdx.x;
    float base = float(((group * 16u) + lane));
    values[min(uint(lane), 7u)] = Constructfloat3_((base + 0.5), (-(base) - 1.25), (base + 2.5));
    if ((lane == 0u)) {
        broadcast = Constructfloat3_((float(group) + 0.25), (float(group) + 0.5), (float(group) + 0.75));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint next = naga_mod((lane + 1u), 8u);
    float3_ _e42 = values[min(uint(next), 7u)];
    const float3_ _e43 = shift(_e42);
    copied = _e43;
    {
        offset = int(1);
        int _e47 = offset;
        float _e49 = copied.x;
        copied.x = (_e49 + float(_e47));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    bool choose_shared = ((lane & 1u) != 0u);
    float _e58 = broadcast.x;
    if (choose_shared) {
        float _e61 = values[min(uint(lane), 7u)].y;
        values[min(uint(lane), 7u)].y = (_e61 + _e58);
    } else {
        float _e64 = copied.y;
        copied.y = (_e64 + _e58);
    }
    float _e67 = copied.x;
    values[min(uint(lane), 7u)].z = _e67;
    uint row = (((group * 8u) + lane) * 9u);
    float _e76 = copied.x;
    uint _e78[2] = output;
    local = _e78;
    local_1 = uint(row);
    uint _e82[2] = local;
    local_18 = _e82;
    uint _e84 = local_1;
    uint _e86 = local_18[1];
    local_18[1] = (_e86 + _e84);
    uint _e90 = local_18[0];
    local_19 = uint(_e90);
    uint _e94 = local_18[1];
    local_20 = uint(_e94);
    uint _e97 = local_20;
    output_1.Store(_e97*4, asuint(_e76));
    float _e101 = copied.y;
    uint _e102[2] = output;
    local_2 = _e102;
    local_3 = uint((row + 1u));
    uint _e108[2] = local_2;
    local_21 = _e108;
    uint _e110 = local_3;
    uint _e112 = local_21[1];
    local_21[1] = (_e112 + _e110);
    uint _e116 = local_21[0];
    local_22 = uint(_e116);
    uint _e120 = local_21[1];
    local_23 = uint(_e120);
    uint _e123 = local_23;
    output_1.Store(_e123*4, asuint(_e101));
    float _e126 = copied.z;
    uint _e127[2] = output;
    local_4 = _e127;
    local_5 = uint((row + 2u));
    uint _e133[2] = local_4;
    local_24 = _e133;
    uint _e135 = local_5;
    uint _e137 = local_24[1];
    local_24[1] = (_e137 + _e135);
    uint _e141 = local_24[0];
    local_25 = uint(_e141);
    uint _e145 = local_24[1];
    local_26 = uint(_e145);
    uint _e148 = local_26;
    output_1.Store(_e148*4, asuint(_e126));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    float _e152 = values[min(uint(next), 7u)].x;
    uint _e153[2] = output;
    local_6 = _e153;
    local_7 = uint((row + 3u));
    uint _e159[2] = local_6;
    local_27 = _e159;
    uint _e161 = local_7;
    uint _e163 = local_27[1];
    local_27[1] = (_e163 + _e161);
    uint _e167 = local_27[0];
    local_28 = uint(_e167);
    uint _e171 = local_27[1];
    local_29 = uint(_e171);
    uint _e174 = local_29;
    output_1.Store(_e174*4, asuint(_e152));
    float _e178 = values[min(uint(next), 7u)].y;
    uint _e179[2] = output;
    local_8 = _e179;
    local_9 = uint((row + 4u));
    uint _e185[2] = local_8;
    local_30 = _e185;
    uint _e187 = local_9;
    uint _e189 = local_30[1];
    local_30[1] = (_e189 + _e187);
    uint _e193 = local_30[0];
    local_31 = uint(_e193);
    uint _e197 = local_30[1];
    local_32 = uint(_e197);
    uint _e200 = local_32;
    output_1.Store(_e200*4, asuint(_e178));
    float _e204 = values[min(uint(next), 7u)].z;
    uint _e205[2] = output;
    local_10 = _e205;
    local_11 = uint((row + 5u));
    uint _e211[2] = local_10;
    local_33 = _e211;
    uint _e213 = local_11;
    uint _e215 = local_33[1];
    local_33[1] = (_e215 + _e213);
    uint _e219 = local_33[0];
    local_34 = uint(_e219);
    uint _e223 = local_33[1];
    local_35 = uint(_e223);
    uint _e226 = local_35;
    output_1.Store(_e226*4, asuint(_e204));
    float _e229 = broadcast.x;
    uint _e230[2] = output;
    local_12 = _e230;
    local_13 = uint((row + 6u));
    uint _e236[2] = local_12;
    local_36 = _e236;
    uint _e238 = local_13;
    uint _e240 = local_36[1];
    local_36[1] = (_e240 + _e238);
    uint _e244 = local_36[0];
    local_37 = uint(_e244);
    uint _e248 = local_36[1];
    local_38 = uint(_e248);
    uint _e251 = local_38;
    output_1.Store(_e251*4, asuint(_e229));
    float _e254 = broadcast.y;
    uint _e255[2] = output;
    local_14 = _e255;
    local_15 = uint((row + 7u));
    uint _e261[2] = local_14;
    local_39 = _e261;
    uint _e263 = local_15;
    uint _e265 = local_39[1];
    local_39[1] = (_e265 + _e263);
    uint _e269 = local_39[0];
    local_40 = uint(_e269);
    uint _e273 = local_39[1];
    local_41 = uint(_e273);
    uint _e276 = local_41;
    output_1.Store(_e276*4, asuint(_e254));
    float _e279 = broadcast.z;
    uint _e280[2] = output;
    local_16 = _e280;
    local_17 = uint((row + 8u));
    uint _e286[2] = local_16;
    local_42 = _e286;
    uint _e288 = local_17;
    uint _e290 = local_42[1];
    local_42[1] = (_e290 + _e288);
    uint _e294 = local_42[0];
    local_43 = uint(_e294);
    uint _e298 = local_42[1];
    local_44 = uint(_e298);
    uint _e301 = local_44;
    output_1.Store(_e301*4, asuint(_e279));
}
