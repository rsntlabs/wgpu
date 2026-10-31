struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n : register(b2) { type_5 n; }
groupshared uint shared_values[64];

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int transform(float value, float multiplier, int offset)
{
    return naga_f2i32(((value * multiplier) + float(offset)));
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
    uint out_[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint base = (uint)0;
    uint lane = (uint)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    int signed_count = (int)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    float fraction = (float)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    int after_block = (int)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    float coefficient = (float)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    bool selected = (bool)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    int total = (int)0;
    int current = (int)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    float after_loop = (float)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    int local_22 = (int)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    int local_29 = (int)0;
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
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 1u;
    input[1] = 0u;
    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 10u);
        lane = threadIdx.x;
        uint _e30 = lane;
        shared_values[min(uint(_e30), 63u)] = (i + 10u);
        uint _e33 = lane;
        uint _e35 = shared_values[min(uint(_e33), 63u)];
        uint _e37[2] = out_;
        local = _e37;
        uint _e39 = base;
        local_1 = uint(_e39);
        uint _e42[2] = local;
        local_23 = _e42;
        uint _e44 = local_1;
        uint _e46 = local_23[1];
        local_23[1] = (_e46 + _e44);
        uint _e50 = local_23[0];
        local_24 = uint(_e50);
        uint _e54 = local_23[1];
        local_25 = uint(_e54);
        uint _e57 = local_25;
        out_1.Store(_e57*4, asuint(_e35));
        uint _e61[2] = input;
        local_4 = _e61;
        local_5 = uint(i);
        uint _e65[2] = local_4;
        local_26 = _e65;
        uint _e67 = local_5;
        uint _e69 = local_26[1];
        local_26[1] = (_e69 + _e67);
        uint _e73 = local_26[0];
        local_27 = uint(_e73);
        uint _e77 = local_26[1];
        local_28 = uint(_e77);
        uint _e80 = local_28;
        int _e83 = asint(input_1.Load(_e80*4));
        local_29 = _e83;
        int _e85 = local_29;
        local_22 = _e85;
        int _e87 = local_22;
        const int _e91 = transform(float(_e87), 2.0, int(1));
        uint _e93[2] = out_;
        local_2 = _e93;
        uint _e95 = base;
        local_3 = uint((_e95 + 1u));
        uint _e100[2] = local_2;
        local_30 = _e100;
        uint _e102 = local_3;
        uint _e104 = local_30[1];
        local_30[1] = (_e104 + _e102);
        uint _e108 = local_30[0];
        local_31 = uint(_e108);
        uint _e112 = local_30[1];
        local_32 = uint(_e112);
        uint _e115 = local_32;
        out_1.Store(_e115*4, asuint(uint(_e91)));
        signed_count = naga_neg(int(3));
        int _e120 = signed_count;
        uint _e122[2] = out_;
        local_6 = _e122;
        uint _e124 = base;
        local_7 = uint((_e124 + 2u));
        uint _e129[2] = local_6;
        local_33 = _e129;
        uint _e131 = local_7;
        uint _e133 = local_33[1];
        local_33[1] = (_e133 + _e131);
        uint _e137 = local_33[0];
        local_34 = uint(_e137);
        uint _e141 = local_33[1];
        local_35 = uint(_e141);
        uint _e144 = local_35;
        out_1.Store(_e144*4, asuint(uint(_e120)));
        {
            fraction = 3.75;
            float _e148 = fraction;
            uint _e150[2] = out_;
            local_8 = _e150;
            uint _e152 = base;
            local_9 = uint((_e152 + 3u));
            uint _e157[2] = local_8;
            local_36 = _e157;
            uint _e159 = local_9;
            uint _e161 = local_36[1];
            local_36[1] = (_e161 + _e159);
            uint _e165 = local_36[0];
            local_37 = uint(_e165);
            uint _e169 = local_36[1];
            local_38 = uint(_e169);
            uint _e172 = local_38;
            out_1.Store(_e172*4, asuint(naga_f2u32(_e148)));
        }
        after_block = naga_neg(int(5));
        int _e177 = after_block;
        uint _e179[2] = out_;
        local_10 = _e179;
        uint _e181 = base;
        local_11 = uint((_e181 + 4u));
        uint _e186[2] = local_10;
        local_39 = _e186;
        uint _e188 = local_11;
        uint _e190 = local_39[1];
        local_39[1] = (_e190 + _e188);
        uint _e194 = local_39[0];
        local_40 = uint(_e194);
        uint _e198 = local_39[1];
        local_41 = uint(_e198);
        uint _e201 = local_41;
        out_1.Store(_e201*4, asuint(uint(_e177)));
        coefficient = 1.25;
        float _e205 = coefficient;
        uint _e209[2] = out_;
        local_12 = _e209;
        uint _e211 = base;
        local_13 = uint((_e211 + 5u));
        uint _e216[2] = local_12;
        local_42 = _e216;
        uint _e218 = local_13;
        uint _e220 = local_42[1];
        local_42[1] = (_e220 + _e218);
        uint _e224 = local_42[0];
        local_43 = uint(_e224);
        uint _e228 = local_42[1];
        local_44 = uint(_e228);
        uint _e231 = local_44;
        out_1.Store(_e231*4, asuint(naga_f2u32((_e205 * 4.0))));
        selected = (naga_mod(i, 2u) == 0u);
        bool _e238 = selected;
        uint _e240[2] = out_;
        local_14 = _e240;
        uint _e242 = base;
        local_15 = uint((_e242 + 6u));
        uint _e247[2] = local_14;
        local_45 = _e247;
        uint _e249 = local_15;
        uint _e251 = local_45[1];
        local_45[1] = (_e251 + _e249);
        uint _e255 = local_45[0];
        local_46 = uint(_e255);
        uint _e259 = local_45[1];
        local_47 = uint(_e259);
        uint _e262 = local_47;
        out_1.Store(_e262*4, asuint(uint(_e238)));
        total = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e266 = total;
                if ((_e266 < int(3))) {
                } else {
                    break;
                }
                int _e269 = total;
                current = _e269;
                int _e271 = current;
                total = asint(asuint(_e271) + asuint(int(1)));
            }
        }
        int _e274 = total;
        uint _e276[2] = out_;
        local_16 = _e276;
        uint _e278 = base;
        local_17 = uint((_e278 + 7u));
        uint _e283[2] = local_16;
        local_48 = _e283;
        uint _e285 = local_17;
        uint _e287 = local_48[1];
        local_48[1] = (_e287 + _e285);
        uint _e291 = local_48[0];
        local_49 = uint(_e291);
        uint _e295 = local_48[1];
        local_50 = uint(_e295);
        uint _e298 = local_50;
        out_1.Store(_e298*4, asuint(uint(_e274)));
        after_loop = 1.5;
        float _e302 = after_loop;
        uint _e306[2] = out_;
        local_18 = _e306;
        uint _e308 = base;
        local_19 = uint((_e308 + 8u));
        uint _e313[2] = local_18;
        local_51 = _e313;
        uint _e315 = local_19;
        uint _e317 = local_51[1];
        local_51[1] = (_e317 + _e315);
        uint _e321 = local_51[0];
        local_52 = uint(_e321);
        uint _e325 = local_51[1];
        local_53 = uint(_e325);
        uint _e328 = local_53;
        out_1.Store(_e328*4, asuint(naga_f2u32((_e302 * 2.0))));
        uint _e332[2] = out_;
        local_20 = _e332;
        uint _e334 = base;
        local_21 = uint((_e334 + 9u));
        uint _e339[2] = local_20;
        local_54 = _e339;
        uint _e341 = local_21;
        uint _e343 = local_54[1];
        local_54[1] = (_e343 + _e341);
        uint _e347 = local_54[0];
        local_55 = uint(_e347);
        uint _e351 = local_54[1];
        local_56 = uint(_e351);
        uint _e354 = local_56;
        out_1.Store(_e354*4, asuint(naga_f2u32(float(n_1))));
    }
}
