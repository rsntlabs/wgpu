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
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    uint lane = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int signed_count = (int)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    float fraction = (float)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    int after_block = (int)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    float coefficient = (float)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    bool selected = (bool)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    int total = (int)0;
    int current = (int)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    float after_loop = (float)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    int local_37 = (int)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;

    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 10u);
        lane = threadIdx.x;
        uint _e25 = i;
        uint _e28 = lane;
        shared_values[min(uint(_e28), 63u)] = (_e25 + 10u);
        uint _e31 = lane;
        uint _e33 = shared_values[min(uint(_e31), 63u)];
        uint _e34 = local;
        local_2 = _e34;
        uint _e36 = local_2;
        local_3 = uint(_e36);
        uint _e39 = base;
        local_4 = uint(_e39);
        uint _e43 = local_3;
        uint _e44 = local_4;
        local_35 = uint((_e43 + _e44));
        uint _e48 = local_35;
        out_.Store(_e48*4, asuint(_e33));
        uint _e50 = local_1;
        local_8 = _e50;
        uint _e52 = local_8;
        local_9 = uint(_e52);
        uint _e55 = i;
        local_10 = uint(_e55);
        uint _e59 = local_9;
        uint _e60 = local_10;
        local_36 = uint((_e59 + _e60));
        uint _e65 = local_36;
        int _e67 = asint(input.Load(_e65*4));
        local_37 = _e67;
        int _e68 = local_37;
        const int _e72 = transform(float(_e68), 2.0, int(1));
        uint _e74 = local;
        local_5 = _e74;
        uint _e76 = local_5;
        local_6 = uint(_e76);
        uint _e79 = base;
        local_7 = uint((_e79 + 1u));
        uint _e84 = local_6;
        uint _e85 = local_7;
        local_38 = uint((_e84 + _e85));
        uint _e89 = local_38;
        out_.Store(_e89*4, asuint(uint(_e72)));
        signed_count = naga_neg(int(3));
        int _e94 = signed_count;
        uint _e96 = local;
        local_11 = _e96;
        uint _e98 = local_11;
        local_12 = uint(_e98);
        uint _e101 = base;
        local_13 = uint((_e101 + 2u));
        uint _e106 = local_12;
        uint _e107 = local_13;
        local_39 = uint((_e106 + _e107));
        uint _e111 = local_39;
        out_.Store(_e111*4, asuint(uint(_e94)));
        {
            fraction = 3.75;
            float _e115 = fraction;
            uint _e117 = local;
            local_14 = _e117;
            uint _e119 = local_14;
            local_15 = uint(_e119);
            uint _e122 = base;
            local_16 = uint((_e122 + 3u));
            uint _e127 = local_15;
            uint _e128 = local_16;
            local_40 = uint((_e127 + _e128));
            uint _e132 = local_40;
            out_.Store(_e132*4, asuint(naga_f2u32(_e115)));
        }
        after_block = naga_neg(int(5));
        int _e137 = after_block;
        uint _e139 = local;
        local_17 = _e139;
        uint _e141 = local_17;
        local_18 = uint(_e141);
        uint _e144 = base;
        local_19 = uint((_e144 + 4u));
        uint _e149 = local_18;
        uint _e150 = local_19;
        local_41 = uint((_e149 + _e150));
        uint _e154 = local_41;
        out_.Store(_e154*4, asuint(uint(_e137)));
        coefficient = 1.25;
        float _e158 = coefficient;
        uint _e162 = local;
        local_20 = _e162;
        uint _e164 = local_20;
        local_21 = uint(_e164);
        uint _e167 = base;
        local_22 = uint((_e167 + 5u));
        uint _e172 = local_21;
        uint _e173 = local_22;
        local_42 = uint((_e172 + _e173));
        uint _e177 = local_42;
        out_.Store(_e177*4, asuint(naga_f2u32((_e158 * 4.0))));
        uint _e179 = i;
        selected = (naga_mod(_e179, 2u) == 0u);
        bool _e185 = selected;
        uint _e187 = local;
        local_23 = _e187;
        uint _e189 = local_23;
        local_24 = uint(_e189);
        uint _e192 = base;
        local_25 = uint((_e192 + 6u));
        uint _e197 = local_24;
        uint _e198 = local_25;
        local_43 = uint((_e197 + _e198));
        uint _e202 = local_43;
        out_.Store(_e202*4, asuint(uint(_e185)));
        total = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e206 = total;
                if ((_e206 < int(3))) {
                } else {
                    break;
                }
                int _e209 = total;
                current = _e209;
                int _e211 = current;
                total = asint(asuint(_e211) + asuint(int(1)));
            }
        }
        int _e214 = total;
        uint _e216 = local;
        local_26 = _e216;
        uint _e218 = local_26;
        local_27 = uint(_e218);
        uint _e221 = base;
        local_28 = uint((_e221 + 7u));
        uint _e226 = local_27;
        uint _e227 = local_28;
        local_44 = uint((_e226 + _e227));
        uint _e231 = local_44;
        out_.Store(_e231*4, asuint(uint(_e214)));
        after_loop = 1.5;
        float _e235 = after_loop;
        uint _e239 = local;
        local_29 = _e239;
        uint _e241 = local_29;
        local_30 = uint(_e241);
        uint _e244 = base;
        local_31 = uint((_e244 + 8u));
        uint _e249 = local_30;
        uint _e250 = local_31;
        local_45 = uint((_e249 + _e250));
        uint _e254 = local_45;
        out_.Store(_e254*4, asuint(naga_f2u32((_e235 * 2.0))));
        uint _e256 = n;
        uint _e259 = local;
        local_32 = _e259;
        uint _e261 = local_32;
        local_33 = uint(_e261);
        uint _e264 = base;
        local_34 = uint((_e264 + 9u));
        uint _e269 = local_33;
        uint _e270 = local_34;
        local_46 = uint((_e269 + _e270));
        uint _e274 = local_46;
        out_.Store(_e274*4, asuint(naga_f2u32(float(_e256))));
    }
}
