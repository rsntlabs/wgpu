struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
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
    uint base = (uint)0;
    uint lane = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int signed_count = (int)0;
    uint local_3 = (uint)0;
    float fraction = (float)0;
    uint local_4 = (uint)0;
    int after_block = (int)0;
    uint local_5 = (uint)0;
    float coefficient = (float)0;
    uint local_6 = (uint)0;
    bool selected = (bool)0;
    uint local_7 = (uint)0;
    int total = (int)0;
    int current = (int)0;
    uint local_8 = (uint)0;
    float after_loop = (float)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 10u);
        lane = threadIdx.x;
        uint _e18 = lane;
        shared_values[min(uint(_e18), 63u)] = (i + 10u);
        uint _e21 = lane;
        uint _e23 = shared_values[min(uint(_e21), 63u)];
        uint _e24 = base;
        local = _e24;
        uint _e26 = local;
        local_12 = _e26;
        uint _e28 = local_12;
        out_.Store(_e28*4, asuint(_e23));
        local_2 = i;
        uint _e32 = local_2;
        local_13 = _e32;
        uint _e34 = local_13;
        int _e37 = asint(input.Load(_e34*4));
        local_14 = _e37;
        int _e39 = local_14;
        local_11 = _e39;
        int _e41 = local_11;
        const int _e45 = transform(float(_e41), 2.0, int(1));
        uint _e47 = base;
        local_1 = uint((_e47 + 1u));
        uint _e52 = local_1;
        local_15 = _e52;
        uint _e54 = local_15;
        out_.Store(_e54*4, asuint(uint(_e45)));
        signed_count = naga_neg(int(3));
        int _e59 = signed_count;
        uint _e61 = base;
        local_3 = uint((_e61 + 2u));
        uint _e66 = local_3;
        local_16 = _e66;
        uint _e68 = local_16;
        out_.Store(_e68*4, asuint(uint(_e59)));
        {
            fraction = 3.75;
            float _e72 = fraction;
            uint _e74 = base;
            local_4 = uint((_e74 + 3u));
            uint _e79 = local_4;
            local_17 = _e79;
            uint _e81 = local_17;
            out_.Store(_e81*4, asuint(naga_f2u32(_e72)));
        }
        after_block = naga_neg(int(5));
        int _e86 = after_block;
        uint _e88 = base;
        local_5 = uint((_e88 + 4u));
        uint _e93 = local_5;
        local_18 = _e93;
        uint _e95 = local_18;
        out_.Store(_e95*4, asuint(uint(_e86)));
        coefficient = 1.25;
        float _e99 = coefficient;
        uint _e103 = base;
        local_6 = uint((_e103 + 5u));
        uint _e108 = local_6;
        local_19 = _e108;
        uint _e110 = local_19;
        out_.Store(_e110*4, asuint(naga_f2u32((_e99 * 4.0))));
        selected = (naga_mod(i, 2u) == 0u);
        bool _e117 = selected;
        uint _e119 = base;
        local_7 = uint((_e119 + 6u));
        uint _e124 = local_7;
        local_20 = _e124;
        uint _e126 = local_20;
        out_.Store(_e126*4, asuint(uint(_e117)));
        total = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e130 = total;
                if ((_e130 < int(3))) {
                } else {
                    break;
                }
                int _e133 = total;
                current = _e133;
                int _e135 = current;
                total = asint(asuint(_e135) + asuint(int(1)));
            }
        }
        int _e138 = total;
        uint _e140 = base;
        local_8 = uint((_e140 + 7u));
        uint _e145 = local_8;
        local_21 = _e145;
        uint _e147 = local_21;
        out_.Store(_e147*4, asuint(uint(_e138)));
        after_loop = 1.5;
        float _e151 = after_loop;
        uint _e155 = base;
        local_9 = uint((_e155 + 8u));
        uint _e160 = local_9;
        local_22 = _e160;
        uint _e162 = local_22;
        out_.Store(_e162*4, asuint(naga_f2u32((_e151 * 2.0))));
        uint _e166 = base;
        local_10 = uint((_e166 + 9u));
        uint _e171 = local_10;
        local_23 = _e171;
        uint _e173 = local_23;
        out_.Store(_e173*4, asuint(naga_f2u32(float(n_1))));
    }
}
