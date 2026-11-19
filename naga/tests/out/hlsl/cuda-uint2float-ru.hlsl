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
    uint _e28 = (_e24 - _e26);
    output.Store(base*4, asuint(asuint(asfloat(((value_1 != 0u) ? ((((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> _e28) & 8388607u)) + (((value_1 & ((1u << _e28) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    const uint _e50 = forward(value_1);
    uint _e55 = (31u - (31u - firstbithigh((_e50 | 1u))));
    uint _e57 = min(_e55, 23u);
    uint _e59 = (_e55 - _e57);
    local = uint((base + 1u));
    uint _e83 = local;
    output.Store(_e83*4, asuint(asuint(asfloat(((_e50 != 0u) ? ((((_e55 + 127u) << 23u) | (((_e50 << (23u - _e57)) >> _e59) & 8388607u)) + (((_e50 & ((1u << _e59) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    uint _e85 = counter;
    counter = (_e85 + uint(int(1)));
    uint _e93 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e95 = min(_e93, 23u);
    uint _e97 = (_e93 - _e95);
    local_1 = uint((base + 2u));
    uint _e121 = local_1;
    output.Store(_e121*4, asuint(asuint(asfloat(((value_1 != 0u) ? ((((_e93 + 127u) << 23u) | (((value_1 << (23u - _e95)) >> _e97) & 8388607u)) + (((value_1 & ((1u << _e97) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    uint _e123 = counter;
    local_2 = uint((base + 3u));
    uint _e128 = local_2;
    output.Store(_e128*4, asuint(_e123));
    if (((index & 1u) != 0u)) {
        uint _e134 = counter;
        local_12 = _e134;
        uint _e136 = local_12;
        counter = (_e136 + uint(int(1)));
        local_13 = value_1;
        uint _e141 = local_13;
        local_4 = _e141;
        uint _e143 = local_4;
        uint _e148 = (31u - (31u - firstbithigh((_e143 | 1u))));
        uint _e150 = min(_e148, 23u);
        uint _e152 = (_e148 - _e150);
        local_6 = asuint(asfloat(((_e143 != 0u) ? ((((_e148 + 127u) << 23u) | (((_e143 << (23u - _e150)) >> _e152) & 8388607u)) + (((_e143 & ((1u << _e152) - 1u)) != 0u) ? 1u : 0u)) : 0u)));
    } else {
        uint _e173 = counter;
        local_14 = _e173;
        uint _e175 = local_14;
        counter = (_e175 + uint(int(1)));
        local_15 = value_1;
        uint _e180 = local_15;
        local_5 = _e180;
        uint _e182 = local_5;
        uint _e187 = (31u - (31u - firstbithigh((_e182 | 1u))));
        uint _e189 = min(_e187, 23u);
        uint _e191 = (_e187 - _e189);
        local_6 = asuint(asfloat(((_e182 != 0u) ? ((((_e187 + 127u) << 23u) | (((_e182 << (23u - _e189)) >> _e191) & 8388607u)) + (((_e182 & ((1u << _e191) - 1u)) != 0u) ? 1u : 0u)) : 0u)));
    }
    uint _e213 = local_6;
    local_3 = uint((base + 4u));
    uint _e218 = local_3;
    output.Store(_e218*4, asuint(_e213));
    uint _e220 = counter;
    local_7 = uint((base + 5u));
    uint _e225 = local_7;
    output.Store(_e225*4, asuint(_e220));
    uint _e229 = uint(naga_neg(int(1)));
    uint _e234 = (31u - (31u - firstbithigh((_e229 | 1u))));
    uint _e236 = min(_e234, 23u);
    uint _e238 = (_e234 - _e236);
    local_8 = uint((base + 6u));
    uint _e262 = local_8;
    output.Store(_e262*4, asuint(asuint(asfloat(((_e229 != 0u) ? ((((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> _e238) & 8388607u)) + (((_e229 & ((1u << _e238) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    uint _e265 = naga_f2u32(3.5);
    uint _e270 = (31u - (31u - firstbithigh((_e265 | 1u))));
    uint _e272 = min(_e270, 23u);
    uint _e274 = (_e270 - _e272);
    local_9 = uint((base + 7u));
    uint _e298 = local_9;
    output.Store(_e298*4, asuint(asuint(asfloat(((_e265 != 0u) ? ((((_e270 + 127u) << 23u) | (((_e265 << (23u - _e272)) >> _e274) & 8388607u)) + (((_e265 & ((1u << _e274) - 1u)) != 0u) ? 1u : 0u)) : 0u)))));
    uint _e304 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e306 = min(_e304, 23u);
    local_10 = uint((base + 8u));
    uint _e326 = local_10;
    output.Store(_e326*4, asuint(asuint(asfloat(((value_1 != 0u) ? (((_e304 + 127u) << 23u) | (((value_1 << (23u - _e306)) >> (_e304 - _e306)) & 8388607u)) : 0u)))));
    uint _e332 = (31u - (31u - firstbithigh((value_1 | 1u))));
    uint _e334 = min(_e332, 23u);
    uint _e336 = (_e332 - _e334);
    uint _e338 = ((value_1 << (23u - _e334)) >> _e336);
    uint _e345 = (1u << _e336);
    local_11 = uint((base + 9u));
    uint _e363 = local_11;
    output.Store(_e363*4, asuint(asuint(asfloat(((value_1 != 0u) ? ((((_e332 + 127u) << 23u) | (_e338 & 8388607u)) + (((((value_1 & (_e345 - 1u)) << 1u) | (_e338 & 1u)) > _e345) ? 1u : 0u)) : 0u)))));
}
