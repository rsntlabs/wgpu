struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n_1 : register(b2) { type_5 n_1; }
groupshared uint shared_values[64];

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int transform(float value, float multiplier, int offset)
{
    float value_1 = (float)0;
    float multiplier_1 = (float)0;
    int offset_1 = (int)0;

    value_1 = value;
    multiplier_1 = multiplier;
    offset_1 = offset;
    float _e6 = value_1;
    float _e7 = multiplier_1;
    int _e9 = offset_1;
    return naga_f2i32(((_e6 * _e7) + float(_e9)));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(64, 1, 1)]
void scalar_aliases(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_values = (uint[64])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    uint lane = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    int signed_count = (int)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    float fraction = (float)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    int after_block = (int)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    float coefficient = (float)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    bool selected = (bool)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    int total = (int)0;
    int current = (int)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    float after_loop = (float)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    int local_24 = (int)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    int local_31 = (int)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26 = i;
    uint _e27 = n;
    if ((_e26 < _e27)) {
        uint _e29 = i;
        base = (_e29 * 10u);
        lane = threadIdx.x;
        uint _e35 = i;
        uint _e38 = lane;
        shared_values[min(uint(_e38), 63u)] = (_e35 + 10u);
        uint _e41 = lane;
        uint _e43 = shared_values[min(uint(_e41), 63u)];
        uint _e46[2] = local;
        local_2 = _e46;
        uint _e47 = base;
        local_3 = uint(_e47);
        uint _e51[2] = local_2;
        local_25 = _e51;
        uint _e52 = local_3;
        uint _e54 = local_25[1];
        local_25[1] = (_e54 + _e52);
        uint _e58 = local_25[0];
        local_26 = uint(_e58);
        uint _e62 = local_25[1];
        local_27 = uint(_e62);
        uint _e65 = local_27;
        out_.Store(_e65*4, asuint(_e43));
        uint _e69[2] = local_1;
        local_6 = _e69;
        uint _e70 = i;
        local_7 = uint(_e70);
        uint _e74[2] = local_6;
        local_28 = _e74;
        uint _e75 = local_7;
        uint _e77 = local_28[1];
        local_28[1] = (_e77 + _e75);
        uint _e81 = local_28[0];
        local_29 = uint(_e81);
        uint _e85 = local_28[1];
        local_30 = uint(_e85);
        uint _e89 = local_30;
        int _e91 = asint(input.Load(_e89*4));
        local_31 = _e91;
        int _e92 = local_31;
        local_24 = _e92;
        int _e94 = local_24;
        const int _e98 = transform(float(_e94), 2.0, int(1));
        uint _e101[2] = local;
        local_4 = _e101;
        uint _e102 = base;
        local_5 = uint((_e102 + 1u));
        uint _e108[2] = local_4;
        local_32 = _e108;
        uint _e109 = local_5;
        uint _e111 = local_32[1];
        local_32[1] = (_e111 + _e109);
        uint _e115 = local_32[0];
        local_33 = uint(_e115);
        uint _e119 = local_32[1];
        local_34 = uint(_e119);
        uint _e122 = local_34;
        out_.Store(_e122*4, asuint(uint(_e98)));
        signed_count = naga_neg(int(3));
        int _e127 = signed_count;
        uint _e130[2] = local;
        local_8 = _e130;
        uint _e131 = base;
        local_9 = uint((_e131 + 2u));
        uint _e137[2] = local_8;
        local_35 = _e137;
        uint _e138 = local_9;
        uint _e140 = local_35[1];
        local_35[1] = (_e140 + _e138);
        uint _e144 = local_35[0];
        local_36 = uint(_e144);
        uint _e148 = local_35[1];
        local_37 = uint(_e148);
        uint _e151 = local_37;
        out_.Store(_e151*4, asuint(uint(_e127)));
        {
            fraction = 3.75;
            float _e155 = fraction;
            uint _e158[2] = local;
            local_10 = _e158;
            uint _e159 = base;
            local_11 = uint((_e159 + 3u));
            uint _e165[2] = local_10;
            local_38 = _e165;
            uint _e166 = local_11;
            uint _e168 = local_38[1];
            local_38[1] = (_e168 + _e166);
            uint _e172 = local_38[0];
            local_39 = uint(_e172);
            uint _e176 = local_38[1];
            local_40 = uint(_e176);
            uint _e179 = local_40;
            out_.Store(_e179*4, asuint(naga_f2u32(_e155)));
        }
        after_block = naga_neg(int(5));
        int _e184 = after_block;
        uint _e187[2] = local;
        local_12 = _e187;
        uint _e188 = base;
        local_13 = uint((_e188 + 4u));
        uint _e194[2] = local_12;
        local_41 = _e194;
        uint _e195 = local_13;
        uint _e197 = local_41[1];
        local_41[1] = (_e197 + _e195);
        uint _e201 = local_41[0];
        local_42 = uint(_e201);
        uint _e205 = local_41[1];
        local_43 = uint(_e205);
        uint _e208 = local_43;
        out_.Store(_e208*4, asuint(uint(_e184)));
        coefficient = 1.25;
        float _e212 = coefficient;
        uint _e217[2] = local;
        local_14 = _e217;
        uint _e218 = base;
        local_15 = uint((_e218 + 5u));
        uint _e224[2] = local_14;
        local_44 = _e224;
        uint _e225 = local_15;
        uint _e227 = local_44[1];
        local_44[1] = (_e227 + _e225);
        uint _e231 = local_44[0];
        local_45 = uint(_e231);
        uint _e235 = local_44[1];
        local_46 = uint(_e235);
        uint _e238 = local_46;
        out_.Store(_e238*4, asuint(naga_f2u32((_e212 * 4.0))));
        uint _e240 = i;
        selected = (naga_mod(_e240, 2u) == 0u);
        bool _e246 = selected;
        uint _e249[2] = local;
        local_16 = _e249;
        uint _e250 = base;
        local_17 = uint((_e250 + 6u));
        uint _e256[2] = local_16;
        local_47 = _e256;
        uint _e257 = local_17;
        uint _e259 = local_47[1];
        local_47[1] = (_e259 + _e257);
        uint _e263 = local_47[0];
        local_48 = uint(_e263);
        uint _e267 = local_47[1];
        local_49 = uint(_e267);
        uint _e270 = local_49;
        out_.Store(_e270*4, asuint(uint(_e246)));
        total = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e274 = total;
                if ((_e274 < int(3))) {
                } else {
                    break;
                }
                int _e277 = total;
                current = _e277;
                int _e279 = current;
                total = asint(asuint(_e279) + asuint(int(1)));
            }
        }
        int _e282 = total;
        uint _e285[2] = local;
        local_18 = _e285;
        uint _e286 = base;
        local_19 = uint((_e286 + 7u));
        uint _e292[2] = local_18;
        local_50 = _e292;
        uint _e293 = local_19;
        uint _e295 = local_50[1];
        local_50[1] = (_e295 + _e293);
        uint _e299 = local_50[0];
        local_51 = uint(_e299);
        uint _e303 = local_50[1];
        local_52 = uint(_e303);
        uint _e306 = local_52;
        out_.Store(_e306*4, asuint(uint(_e282)));
        after_loop = 1.5;
        float _e310 = after_loop;
        uint _e315[2] = local;
        local_20 = _e315;
        uint _e316 = base;
        local_21 = uint((_e316 + 8u));
        uint _e322[2] = local_20;
        local_53 = _e322;
        uint _e323 = local_21;
        uint _e325 = local_53[1];
        local_53[1] = (_e325 + _e323);
        uint _e329 = local_53[0];
        local_54 = uint(_e329);
        uint _e333 = local_53[1];
        local_55 = uint(_e333);
        uint _e336 = local_55;
        out_.Store(_e336*4, asuint(naga_f2u32((_e310 * 2.0))));
        uint _e338 = n;
        uint _e342[2] = local;
        local_22 = _e342;
        uint _e343 = base;
        local_23 = uint((_e343 + 9u));
        uint _e349[2] = local_22;
        local_56 = _e349;
        uint _e350 = local_23;
        uint _e352 = local_56[1];
        local_56[1] = (_e352 + _e350);
        uint _e356 = local_56[0];
        local_57 = uint(_e356);
        uint _e360 = local_56[1];
        local_58 = uint(_e360);
        uint _e363 = local_58;
        out_.Store(_e363*4, asuint(naga_f2u32(float(_e338))));
    }
}
