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
    uint lane = (uint)0;
    uint group = (uint)0;
    float base = (float)0;
    uint next = (uint)0;
    float3_ copied = (float3_)0;
    int offset = (int)0;
    bool choose_shared = (bool)0;
    uint row = (uint)0;
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
    lane = threadIdx.x;
    group = blockIdx.x;
    uint _e13 = group;
    uint _e16 = lane;
    base = float(((_e13 * 16u) + _e16));
    float _e20 = base;
    float _e23 = base;
    float _e27 = base;
    uint _e31 = lane;
    values[min(uint(_e31), 7u)] = Constructfloat3_((_e20 + 0.5), (-(_e23) - 1.25), (_e27 + 2.5));
    uint _e34 = lane;
    if ((_e34 == 0u)) {
        uint _e37 = group;
        uint _e41 = group;
        uint _e45 = group;
        broadcast = Constructfloat3_((float(_e37) + 0.25), (float(_e41) + 0.5), (float(_e45) + 0.75));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e51 = lane;
    next = naga_mod((_e51 + 1u), 8u);
    uint _e57 = next;
    float3_ _e59 = values[min(uint(_e57), 7u)];
    const float3_ _e60 = shift(_e59);
    copied = _e60;
    {
        offset = int(1);
        int _e64 = offset;
        float _e66 = copied.x;
        copied.x = (_e66 + float(_e64));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e69 = lane;
    choose_shared = ((_e69 & 1u) != 0u);
    float _e77 = broadcast.x;
    bool _e78 = choose_shared;
    if (_e78) {
        uint _e79 = lane;
        float _e82 = values[min(uint(_e79), 7u)].y;
        values[min(uint(_e79), 7u)].y = (_e82 + _e77);
    } else {
        float _e85 = copied.y;
        copied.y = (_e85 + _e77);
    }
    float _e88 = copied.x;
    uint _e89 = lane;
    values[min(uint(_e89), 7u)].z = _e88;
    uint _e92 = group;
    uint _e95 = lane;
    row = (((_e92 * 8u) + _e95) * 9u);
    float _e101 = copied.x;
    uint _e104[2] = output;
    local = _e104;
    uint _e105 = row;
    local_1 = uint(_e105);
    uint _e109[2] = local;
    local_18 = _e109;
    uint _e110 = local_1;
    uint _e112 = local_18[1];
    local_18[1] = (_e112 + _e110);
    uint _e116 = local_18[0];
    local_19 = uint(_e116);
    uint _e120 = local_18[1];
    local_20 = uint(_e120);
    uint _e123 = local_20;
    output_1.Store(_e123*4, asuint(_e101));
    float _e126 = copied.y;
    uint _e128[2] = output;
    local_2 = _e128;
    uint _e129 = row;
    local_3 = uint((_e129 + 1u));
    uint _e135[2] = local_2;
    local_21 = _e135;
    uint _e136 = local_3;
    uint _e138 = local_21[1];
    local_21[1] = (_e138 + _e136);
    uint _e142 = local_21[0];
    local_22 = uint(_e142);
    uint _e146 = local_21[1];
    local_23 = uint(_e146);
    uint _e149 = local_23;
    output_1.Store(_e149*4, asuint(_e126));
    float _e152 = copied.z;
    uint _e154[2] = output;
    local_4 = _e154;
    uint _e155 = row;
    local_5 = uint((_e155 + 2u));
    uint _e161[2] = local_4;
    local_24 = _e161;
    uint _e162 = local_5;
    uint _e164 = local_24[1];
    local_24[1] = (_e164 + _e162);
    uint _e168 = local_24[0];
    local_25 = uint(_e168);
    uint _e172 = local_24[1];
    local_26 = uint(_e172);
    uint _e175 = local_26;
    output_1.Store(_e175*4, asuint(_e152));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e177 = next;
    float _e180 = values[min(uint(_e177), 7u)].x;
    uint _e182[2] = output;
    local_6 = _e182;
    uint _e183 = row;
    local_7 = uint((_e183 + 3u));
    uint _e189[2] = local_6;
    local_27 = _e189;
    uint _e190 = local_7;
    uint _e192 = local_27[1];
    local_27[1] = (_e192 + _e190);
    uint _e196 = local_27[0];
    local_28 = uint(_e196);
    uint _e200 = local_27[1];
    local_29 = uint(_e200);
    uint _e203 = local_29;
    output_1.Store(_e203*4, asuint(_e180));
    uint _e205 = next;
    float _e208 = values[min(uint(_e205), 7u)].y;
    uint _e210[2] = output;
    local_8 = _e210;
    uint _e211 = row;
    local_9 = uint((_e211 + 4u));
    uint _e217[2] = local_8;
    local_30 = _e217;
    uint _e218 = local_9;
    uint _e220 = local_30[1];
    local_30[1] = (_e220 + _e218);
    uint _e224 = local_30[0];
    local_31 = uint(_e224);
    uint _e228 = local_30[1];
    local_32 = uint(_e228);
    uint _e231 = local_32;
    output_1.Store(_e231*4, asuint(_e208));
    uint _e233 = next;
    float _e236 = values[min(uint(_e233), 7u)].z;
    uint _e238[2] = output;
    local_10 = _e238;
    uint _e239 = row;
    local_11 = uint((_e239 + 5u));
    uint _e245[2] = local_10;
    local_33 = _e245;
    uint _e246 = local_11;
    uint _e248 = local_33[1];
    local_33[1] = (_e248 + _e246);
    uint _e252 = local_33[0];
    local_34 = uint(_e252);
    uint _e256 = local_33[1];
    local_35 = uint(_e256);
    uint _e259 = local_35;
    output_1.Store(_e259*4, asuint(_e236));
    float _e262 = broadcast.x;
    uint _e264[2] = output;
    local_12 = _e264;
    uint _e265 = row;
    local_13 = uint((_e265 + 6u));
    uint _e271[2] = local_12;
    local_36 = _e271;
    uint _e272 = local_13;
    uint _e274 = local_36[1];
    local_36[1] = (_e274 + _e272);
    uint _e278 = local_36[0];
    local_37 = uint(_e278);
    uint _e282 = local_36[1];
    local_38 = uint(_e282);
    uint _e285 = local_38;
    output_1.Store(_e285*4, asuint(_e262));
    float _e288 = broadcast.y;
    uint _e290[2] = output;
    local_14 = _e290;
    uint _e291 = row;
    local_15 = uint((_e291 + 7u));
    uint _e297[2] = local_14;
    local_39 = _e297;
    uint _e298 = local_15;
    uint _e300 = local_39[1];
    local_39[1] = (_e300 + _e298);
    uint _e304 = local_39[0];
    local_40 = uint(_e304);
    uint _e308 = local_39[1];
    local_41 = uint(_e308);
    uint _e311 = local_41;
    output_1.Store(_e311*4, asuint(_e288));
    float _e314 = broadcast.z;
    uint _e316[2] = output;
    local_16 = _e316;
    uint _e317 = row;
    local_17 = uint((_e317 + 8u));
    uint _e323[2] = local_16;
    local_42 = _e323;
    uint _e324 = local_17;
    uint _e326 = local_42[1];
    local_42[1] = (_e326 + _e324);
    uint _e330 = local_42[0];
    local_43 = uint(_e330);
    uint _e334 = local_42[1];
    local_44 = uint(_e334);
    uint _e337 = local_44;
    output_1.Store(_e337*4, asuint(_e314));
}
