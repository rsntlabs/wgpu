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
        local = uint(_e24);
        uint _e27 = local;
        local_12 = uint(_e27);
        uint _e30 = local_12;
        out_.Store(_e30*4, asuint(_e23));
        local_2 = uint(i);
        uint _e35 = local_2;
        local_13 = uint(_e35);
        uint _e38 = local_13;
        int _e41 = asint(input.Load(_e38*4));
        local_14 = _e41;
        int _e43 = local_14;
        local_11 = _e43;
        int _e45 = local_11;
        const int _e49 = transform(float(_e45), 2.0, int(1));
        uint _e51 = base;
        local_1 = uint((_e51 + 1u));
        uint _e56 = local_1;
        local_15 = uint(_e56);
        uint _e59 = local_15;
        out_.Store(_e59*4, asuint(uint(_e49)));
        signed_count = naga_neg(int(3));
        int _e64 = signed_count;
        uint _e66 = base;
        local_3 = uint((_e66 + 2u));
        uint _e71 = local_3;
        local_16 = uint(_e71);
        uint _e74 = local_16;
        out_.Store(_e74*4, asuint(uint(_e64)));
        {
            fraction = 3.75;
            float _e78 = fraction;
            uint _e80 = base;
            local_4 = uint((_e80 + 3u));
            uint _e85 = local_4;
            local_17 = uint(_e85);
            uint _e88 = local_17;
            out_.Store(_e88*4, asuint(naga_f2u32(_e78)));
        }
        after_block = naga_neg(int(5));
        int _e93 = after_block;
        uint _e95 = base;
        local_5 = uint((_e95 + 4u));
        uint _e100 = local_5;
        local_18 = uint(_e100);
        uint _e103 = local_18;
        out_.Store(_e103*4, asuint(uint(_e93)));
        coefficient = 1.25;
        float _e107 = coefficient;
        uint _e111 = base;
        local_6 = uint((_e111 + 5u));
        uint _e116 = local_6;
        local_19 = uint(_e116);
        uint _e119 = local_19;
        out_.Store(_e119*4, asuint(naga_f2u32((_e107 * 4.0))));
        selected = (naga_mod(i, 2u) == 0u);
        bool _e126 = selected;
        uint _e128 = base;
        local_7 = uint((_e128 + 6u));
        uint _e133 = local_7;
        local_20 = uint(_e133);
        uint _e136 = local_20;
        out_.Store(_e136*4, asuint(uint(_e126)));
        total = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e140 = total;
                if ((_e140 < int(3))) {
                } else {
                    break;
                }
                int _e143 = total;
                current = _e143;
                int _e145 = current;
                total = asint(asuint(_e145) + asuint(int(1)));
            }
        }
        int _e148 = total;
        uint _e150 = base;
        local_8 = uint((_e150 + 7u));
        uint _e155 = local_8;
        local_21 = uint(_e155);
        uint _e158 = local_21;
        out_.Store(_e158*4, asuint(uint(_e148)));
        after_loop = 1.5;
        float _e162 = after_loop;
        uint _e166 = base;
        local_9 = uint((_e166 + 8u));
        uint _e171 = local_9;
        local_22 = uint(_e171);
        uint _e174 = local_22;
        out_.Store(_e174*4, asuint(naga_f2u32((_e162 * 2.0))));
        uint _e178 = base;
        local_10 = uint((_e178 + 9u));
        uint _e183 = local_10;
        local_23 = uint(_e183);
        uint _e186 = local_23;
        out_.Store(_e186*4, asuint(naga_f2u32(float(n_1))));
    }
}
