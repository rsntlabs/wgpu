struct type_2 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_2 count; }

uint forward(uint value)
{
    return value;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(4, 1, 1)]
void convert_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint value_1 = asuint(input.Load(index*4));
    counter = 0u;
    uint _e24 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e26 = min(_e24, 23u);
    output.Store(base*4, asuint(asuint(asfloat(((value_1 != 0u) ? (((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> (_e24 - _e26)) & 8388607u)) : 0u)))));
    const uint _e44 = forward(value_1);
    uint _e49 = (31u - (31u - firstbithigh((_e44 | 1u))));
    uint _e51 = min(_e49, 23u);
    local = uint((base + 1u));
    uint _e71 = local;
    output.Store(_e71*4, asuint(asuint(asfloat(((_e44 != 0u) ? (((_e49 + 127u) << 23u) | (((_e44 << (23u - _e51)) >> (_e49 - _e51)) & 8388607u)) : 0u)))));
    uint _e73 = counter;
    counter = (_e73 + uint(int(1)));
    uint _e81 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e83 = min(_e81, 23u);
    local_1 = uint((base + 2u));
    uint _e103 = local_1;
    output.Store(_e103*4, asuint(asuint(asfloat(((value_1 != 0u) ? (((_e81 + 127u) << 23u) | (((value_1 << (23u - _e83)) >> (_e81 - _e83)) & 8388607u)) : 0u)))));
    uint _e105 = counter;
    local_2 = uint((base + 3u));
    uint _e110 = local_2;
    output.Store(_e110*4, asuint(_e105));
    if (((index & 1u) != 0u)) {
        uint _e116 = counter;
        local_12 = _e116;
        uint _e118 = local_12;
        counter = (_e118 + uint(int(1)));
        local_13 = value_1;
        uint _e123 = local_13;
        local_4 = _e123;
        uint _e125 = local_4;
        uint _e130 = (31u - (31u - firstbithigh((_e125 | 1u))));
        uint _e132 = min(_e130, 23u);
        local_6 = asuint(asfloat(((_e125 != 0u) ? (((_e130 + 127u) << 23u) | (((_e125 << (23u - _e132)) >> (_e130 - _e132)) & 8388607u)) : 0u)));
    } else {
        uint _e149 = counter;
        local_14 = _e149;
        uint _e151 = local_14;
        counter = (_e151 + uint(int(1)));
        local_15 = value_1;
        uint _e156 = local_15;
        local_5 = _e156;
        uint _e158 = local_5;
        uint _e163 = (31u - (31u - firstbithigh((_e158 | 1u))));
        uint _e165 = min(_e163, 23u);
        local_6 = asuint(asfloat(((_e158 != 0u) ? (((_e163 + 127u) << 23u) | (((_e158 << (23u - _e165)) >> (_e163 - _e165)) & 8388607u)) : 0u)));
    }
    uint _e183 = local_6;
    local_3 = uint((base + 4u));
    uint _e188 = local_3;
    output.Store(_e188*4, asuint(_e183));
    uint _e190 = counter;
    local_7 = uint((base + 5u));
    uint _e195 = local_7;
    output.Store(_e195*4, asuint(_e190));
    uint _e199 = uint(naga_neg(int(1)));
    uint _e204 = (31u - (31u - firstbithigh((_e199 | 1u))));
    uint _e206 = min(_e204, 23u);
    local_8 = uint((base + 6u));
    uint _e226 = local_8;
    output.Store(_e226*4, asuint(asuint(asfloat(((_e199 != 0u) ? (((_e204 + 127u) << 23u) | (((_e199 << (23u - _e206)) >> (_e204 - _e206)) & 8388607u)) : 0u)))));
    uint _e229 = naga_f2u32(3.5);
    uint _e234 = (31u - (31u - firstbithigh((_e229 | 1u))));
    uint _e236 = min(_e234, 23u);
    local_9 = uint((base + 7u));
    uint _e256 = local_9;
    output.Store(_e256*4, asuint(asuint(asfloat(((_e229 != 0u) ? (((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> (_e234 - _e236)) & 8388607u)) : 0u)))));
    uint _e262 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e264 = min(_e262, 23u);
    uint _e266 = (_e262 - _e264);
    local_10 = uint((base + 8u));
    uint _e290 = local_10;
    output.Store(_e290*4, asuint(asuint(asfloat(((value_1 != 0u) ? ((((_e262 + 127u) << 23u) | (((value_1 << (23u - _e264)) >> _e266) & 8388607u)) + (((value_1 & ((1u << _e266) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    uint _e296 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e298 = min(_e296, 23u);
    uint _e300 = (_e296 - _e298);
    uint _e302 = ((value_1 << (23u - _e298)) >> _e300);
    uint _e309 = (1u << _e300);
    local_11 = uint((base + 9u));
    uint _e327 = local_11;
    output.Store(_e327*4, asuint(asuint(asfloat(((value_1 != 0u) ? ((((_e296 + 127u) << 23u) | (_e302 & 8388607u)) + (((((value_1 & (_e309 - 1u)) << 1u) | (_e302 & 1u)) > _e309) ? 1u : 0u)) : 0u)))));
}
